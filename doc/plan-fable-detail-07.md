# Detail Plan 07: `--options-file` (Response-File CLI Front End) + Invocation Echo

**Status: DONE** — see commit f5b2eaa (Version 52).

* Part of the plan series from `doc/plan-fable-20260718.md` (section 3.5); also
  satisfies most of `PLAN.md`'s "Add More to Generated `.lisp` Files" section.
* Standalone. Two halves, separable if desired: (A) response file — CLI-only, no
  generator-version bump; (B) invocation echo in generated output — output shape
  change → `*generator-version*` bump.
* Estimated scope: small-medium.

## Goal

Real invocations (see the ~60-line `Makefile` smoke invocation, or a Dungeon Slime
generation line) are unwieldy shell commands: hard to read, diff, and reproduce.
Provide:

* **(A)** `--options-file <path>`: a text file supplying CLI arguments, freely mixed
  with regular arguments, so a consuming project can keep its generation config as a
  versioned file.
* **(B)** Record the effective invocation in the generated output, so any generated
  package set is self-describing and regenerable.

## Part A — Response file

### Format decision

Use a **response file of CLI arguments** (the `@file` convention familiar from
dotnet/msvc/gcc), NOT a Lisp s-expression config. Rationale: `Program.cs` has no Lisp
reader (the manifest flows C#→Lisp, never the reverse); an args file reuses the
existing, well-tested parsing loop verbatim, needs no new schema doc, and keeps exact
CLI parity by construction. Format rules:

* One or more arguments per line, whitespace-split; a line's leading/trailing
  whitespace ignored.
* `#` at start of a *token* begins a comment to end of line.
* Quoting: support double-quoted tokens so class names with backticks/spaces survive
  (`--class "System.ValueTuple\`2"` — note backtick needs no escaping in a file,
  which is itself a readability win over the shell).
* Blank lines ignored. No recursion (`--options-file` inside an options file is an
  error — keep it simple; revisit if ever needed).

### Implementation (`Program.cs`)

1. **Pre-pass before the main parse loop**: scan `args`; whenever
   `--options-file <path>` appears, read + tokenize the file and splice the tokens
   into the argument list *at that position* (position matters — sticky flags are
   order-sensitive by design). Produce a new `string[]` and run the existing loop
   unchanged. Errors (missing file, unterminated quote, nested `--options-file`) →
   `WriteRed` + exit 1.
2. Tokenizer: a small pure function `TokenizeOptionsFile(string text) → List<string>`
   so it is unit-testable.
3. `PrintHelp()`: document the flag and format.

### Tests (Part A)

* C# unit tests: add a `TokenizeOptionsFileTest` set next to `AssemblyToLispyTest`
  (or a small new static test class invoked from the `--test` block in `Program.cs`):
  comments, quotes, blank lines, splice ordering.
* Makefile: convert the giant smoke-test invocation to an options file
  (`test-options.txt`, checked in) invoked as
  `$(EXECUTABLE) --out-dir $(GEN_TEST_DIR) --no-csharp-generic-in-asd --options-file test-options.txt`
  — this makes the smoke test itself the end-to-end proof, AND makes future smoke
  additions cleaner. Keep `REF_DIR`/`BIN_DIR` usable: the options file can't expand
  Make variables, so either generate it from a template in the Makefile (
  `sed "s|@REF_DIR@|$(REF_DIR)|g" test-options.txt.in > $(BIN_DIR)test-options.txt`)
  or keep assemblies on the command line and only classes/flags in the file.
  **Recommend the sed-template approach** — full coverage, one extra Makefile line.

## Part B — Invocation echo in generated output

### What to record, where

1. **`csharp-assembly-packages.asd`'s `:long-description`** (built in
   `generate-batch-asd-file`, `apg-batch-orchestration.lisp`) already lists
   assemblies/classes/constant-properties. Extend the per-class lines to include
   every non-default per-class flag (e.g. `(:defgeneric :export-parents)`), and add a
   global-flags line (`skip-missing`, `csharp-generic-in-asd`). The data is already
   in the manifest plists — thread it through to the `.asd` writer (check what
   `generate-batch-asd-file` currently receives; extend its parameters as needed).
2. **`packages.lisp` per-package comment** (emitted in
   `generate-batch-packages-file`, `apg-reexports-and-generics.lisp`): already names
   source file/class/constant-properties per `PLAN.md`; add a `;; Options:` line
   listing that class's non-default flags, and for discovered (not explicitly
   requested) classes, note the discoverer (`;; Discovered via: --output-nested from
   Some.Class`) — `expand-related`'s bookkeeping in `apg-batch-discovery.lisp` must
   surface the discovery edge if it doesn't already (check `make-resolved-class`'s
   fields; add a `discovered-via` field if absent).
3. **Per-class file header** (`emit-class-file-header`,
   `apg-class-file-generator.lisp`): add the same `;;; Options:` line after
   `;;; Class:`.

Format flags canonically (sorted, `--`-spelled, only non-defaults) so regenerating
with identical inputs produces identical bytes (the checked-in `cspackages-test/`
depends on output determinism; `revert-cspackages-timestamps.sh` handles only
timestamps).

### Tests (Part B)

* Unit: extend a codegen test to assert the Options line for a mock class with flags
  set/unset.
* Smoke: `cspackages-test/` diff shows the new lines; verify discovered classes (the
  `NestingContainer`/`AbstractBase`/`IDummyInterface` families) name their
  discoverers correctly.

## Documentation

* Part A: `README.md` CLI usage section + `CLAUDE.md`/`GEMINI.md`; `RELEASES.md`
  entry; CLI `VERSION` minor bump.
* Part B: `*generator-version*` bump + changelog docstring line + design-notes
  section; `FEATURES.md` (the "fixed header" description in Conventions changes);
  `PLAN.md`: append DONE notes under "Add More to Generated `.lisp` Files" for the
  items covered (options plist, assembly in packages.lisp comment, per-package
  options) — leave the not-covered items (e.g. structured `<constant-properties>`
  constant) untouched or note deferral.
* `FILES.md`: `test-options.txt.in` if the template approach is used.

## Acceptance criteria

* The smoke test runs through an options file and produces byte-identical output to
  the old direct invocation (modulo the Part B additions if done together).
* A generated directory's `.asd` + `packages.lisp` alone are sufficient to
  reconstruct the full generating invocation by hand.
* `make test` green; tokenizer unit tests green.
