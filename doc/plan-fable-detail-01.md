# Detail Plan 01: Read-Back Verification of Generated Output (`--read-check`)

* Part of the plan series from `doc/plan-fable-20260718.md` (section 3.1(a)).
* Standalone: no dependency on any other plan in this series.
* Estimated scope: small-medium. New Lisp file (~150 lines), small `Program.cs` mode,
  one Makefile line. No generated-output shape change → **no `*generator-version*` bump**.

## Goal

Every `.lisp`/`.asd` file the generator emits must be verifiably **readable by a real
Common Lisp reader**, as part of `make test` — not merely paren-balanced
(`check_parens.py`'s only guarantee). This directly closes the escape path of the
Version 47 bug (invalid bare `#:|` export token, present since Version 30, never caught
because nothing ever read generated output).

## Background / current state

* `make test` (Makefile, `test:` target) runs the smoke generation into
  `cspackages-test/`, then `./revert-cspackages-timestamps.sh`, then
  `python3 check_parens.py $(GEN_TEST_DIR)/*.lisp $(GEN_TEST_DIR)/*.asd`.
* `Program.cs` run modes: single-pass generation (`--out-dir`), `--test`
  (calls Lisp `RUN-GENERATOR-TESTS` then C# `AssemblyToLispyTest.RunTests()`),
  `--version`, `--help`. All non-generation modes boot DotCL via
  `DotclHost.Initialize()` + `LoadDotclManifest()`.
* Generated files contain constructs that make naive `cl:read`-ing fail:
  1. **Package-qualified symbols referencing generated packages**
     (`csharp-assembly-utils:...`, cross-package re-export forms in `packages.lisp`) —
     reading a qualified symbol whose package doesn't exist signals a reader error.
     Therefore the checker must **evaluate `cl:defpackage`/`cl:in-package` forms as it
     encounters them** (they are pure package-creation/current-package operations) while
     only *reading* everything else.
  2. **`#.` read-time evaluation** in `csharp-generics.lisp`
     (`#.(dotnet:class-for-type "...")`) — must NOT be evaluated (target assemblies are
     not loaded during the check). Neutralize `#.` via a modified readtable.
  3. **Escaped symbols** (`\|`, `|...|`) — the entire point: the real reader must accept
     them.

## Design

### New Lisp file: `read-check.lisp`

New package `read-check` (add to `packages.lisp`, export `run-read-check`). Not an
`apg-` module — it is a verification tool, not part of the generator. Core function:

```lisp
(defun run-read-check (directory)
  "Reads every generated .lisp and .asd file in DIRECTORY through the real
   Lisp reader, evaluating only defpackage/in-package forms, erroring on the
   first unreadable form. Returns the total number of forms read."
  ...)
```

Algorithm:

1. Build the file list: `packages.lisp` **first** (creates every generated package),
   then every other `*.lisp` sorted (`csharp-assembly-utils.lisp`, class files,
   `csharp-generics.lisp` naturally sorts early — order no longer matters once
   packages.lisp has run), then `*.asd`.
   Use `uiop:directory-files` + filename filtering (pattern used elsewhere:
   see `tests/framework.lisp`'s glob of `tests/*.test.lisp`).
2. Create a **fresh readtable** (`(copy-readtable nil)`) and neutralize `#.`:
   ```lisp
   (set-dispatch-macro-character
    #\# #\.
    (lambda (stream subchar narg)
      (declare (ignore subchar narg))
      ;; Read (and discard) the subform without evaluating it -- this still
      ;; validates the subform's own readability.
      (read stream t nil t)
      nil)
    readtable)
   ```
3. Per file: `with-open-file`, bind `*readtable*` to the modified one,
   `*package*` initially to a scratch package (e.g. make a dedicated
   `read-check-scratch` package that `:use`s nothing, created fresh per run),
   and `*read-eval*` to `nil` as belt-and-braces (the `#.` override never calls
   `eval`, so `nil` is safe and guarantees no other eval path exists).
   Loop `(read stream nil eof-marker)` until EOF, counting forms. For each form
   read at top level:
   * `(cl:defpackage ...)` / `(defpackage ...)` head → `eval` it.
   * `(cl:in-package ...)` / `(in-package ...)` head → `setf *package*`
     to `(find-package (second form))` (do not blindly `eval` arbitrary forms).
   * Anything else → discard.
   Note the head symbols will have been read into the scratch package unless
   `cl:`-qualified; generated files consistently emit `cl:defpackage`/
   `cl:in-package`, but match by `symbol-name` string-equal to `"DEFPACKAGE"`/
   `"IN-PACKAGE"` to be robust.
4. Wrap each file's read loop in `handler-case`; on error, report via
   `utils:format-red` with **file name and the 1-based index of the failing
   top-level form** (line numbers aren't available from `read`; form index plus
   `file-position` at failure is enough to locate it), then re-signal so the
   process exits non-zero.
5. **Package cleanup**: after the run, `delete-package` every package created during
   the check (snapshot `(list-all-packages)` before, diff after). This matters only
   if `run-read-check` is later called inside `--test`'s process; as a standalone
   process invocation it's hygiene. Do it anyway — cheap insurance.

### `Program.cs`: new `--read-check <dir>` mode

* Parse `--read-check` + directory argument alongside the existing mode flags.
* Mode ordering: handle after `--test` in the mode dispatch (it needs
  `DotclHost.Initialize()` + `LoadDotclManifest()`, same as `--test`; it must NOT
  run the metadata-reflection stage).
* Call `DotclHost.Call("RUN-READ-CHECK", dir)`; on Lisp error, print red and
  `Environment.Exit(1)`. On success print the form count.
* Add to `PrintHelp()` (`Opt("--read-check", ...)`).

### Makefile

In the `test:` target, after the existing `check_parens.py` line:

```make
	# Full-reader validation: every generated file must be readable by the
	# real Lisp reader (catches invalid symbol tokens, bad string escapes,
	# and reader-macro breakage that paren-balance checking cannot see --
	# see doc/generator-design-notes.md's Version 47 section for the bug
	# class this exists to catch).
	$(EXECUTABLE) --read-check $(GEN_TEST_DIR)
```

### `.asd` / build integration

* Add `(:file "read-check" :depends-on ("packages" "utils"))` to
  `dotcl-packagegen.asd`'s `:components`.
* Add the package definition + export to `packages.lisp`.
* Run `make check-parens` after writing the new Lisp file.

## Testing the checker itself

Add a new test file `package-generator-tests-read-check.lisp` (mirroring the existing
`package-generator-tests-*.lisp` pattern: registered in `generator-tests.lisp`'s
`run-generator-tests`, `.asd` component added):

1. **Positive**: write a small temp directory (via `uiop:with-temporary-file` or a
   scratch subdir under the output dir) containing a `packages.lisp` with a
   `defpackage` exporting `#:\|` (the exact v47 shape, correctly escaped) and a class
   file using `#.(some-form)` — assert `run-read-check` succeeds and returns a
   positive form count.
2. **Negative**: a file containing the *broken* v47 token (a bare `#:|` followed by a
   newline) — assert `run-read-check` signals an error naming that file. This is the
   regression test proving the checker catches the historical bug.
3. **Negative**: unbalanced-string case (`"unterminated`) — proves coverage beyond
   what `check_parens.py` already catches.

## Acceptance criteria

* `make test` passes end-to-end, with the new `--read-check` step reading every file
  in `cspackages-test/` (including `csharp-generics.lisp` and the `.asd`).
* Manually corrupting one generated file (e.g. `sed -i 's/#:\\\\|/#:|/'` on the
  packages file) makes `make test` fail red with the file named.
* The three checker unit tests above pass under `--test`.

## Documentation updates

* `README.md`/`CLAUDE.md`/`GEMINI.md`: mention the new test phase in the `make test`
  description.
* `FILES.md`: add `read-check.lisp` and the new test file.
* `RELEASES.md`: new entry (CLI-level change: new `--read-check` mode). Bump the
  CLI `VERSION` patch/minor in `dotcl-packagegen.asd` per `BUILD.md` lockstep rules.
  No `*generator-version*` bump (generated output unchanged).
* `doc/generator-design-notes.md`: no new generator version section needed; optionally
  add a back-reference from the Version 47 section ("now guarded by `--read-check`").
