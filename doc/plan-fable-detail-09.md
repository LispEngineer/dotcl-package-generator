# Detail Plan 09: Extract `apg-type-checks.lisp` from `apg-overload-dispatch.lisp`

**Status: DONE** — see commit ad8fa76 (no `*generator-version*` bump, byte-identical output).

* Part of the plan series from `doc/plan-fable-20260718.md` (section 4.2).
* Standalone; **pure internal reorganization** — byte-identical generated output is
  the hard requirement. No `*generator-version*` bump (matching the precedent of the
  original modularization split, commit `6a47c35`).
* Estimated scope: small-medium (mostly mechanical, but in the highest-risk module).
* Sequencing note: if Plan 05 (`out` params) or Plan 10 (cond collapsing) is
  scheduled soon, do this split FIRST so those changes land in the smaller files.

## Motivation

`apg-overload-dispatch.lisp` (789 lines) is the largest module and owns three
separable concerns at once — exactly the ones Versions 48–50's bugs lived in:

1. **Type-check/guard generation** — `resolvable-type-name-for-check`,
   `*numeric-primitive-check-types*`, `format-param-type-check` (which alone spans
   roughly lines 178–695: verify — if it is genuinely a ~500-line function, that is
   itself a finding; see "Optional decomposition" below).
2. **Generic-arity dispatch** — `generic-type-param-names`,
   `method-generic-cell-key`, `split-by-generic-arity`, `generic-arity-suffix`,
   `generic-arity-dispatch-mode`, `internal-arity-fn-name`,
   `method-name-wrapper-names`, `generate-generic-cell-wrapper`,
   `generate-generic-arity-dispatcher`.
3. **Wrapper assembly** — `generate-method-name-wrappers`,
   `group-properties-by-name` (which arguably belongs with member predicates —
   decide during the split).

## Design

### File split

* **New `apg-type-checks.lisp`** — concern 1: everything that answers "given a
  parameter/return plist, what runtime guard or type hint do we emit?"
  (`resolvable-type-name-for-check`, `*numeric-primitive-check-types*`,
  `format-param-type-check`, plus any private helpers discovered inside it).
* **`apg-overload-dispatch.lisp`** keeps concerns 2 + 3 (or optionally split
  generic-arity into its own file too if the result still exceeds ~400 lines —
  implementer's judgment; two files is the minimum deliverable).

### Mechanics (the safe procedure)

1. **Before touching anything**: run `make test` and save a pristine copy of
   `cspackages-test/` (`git stash`-clean tree suffices — the diff must be empty at
   the end).
2. Read the whole current file top to bottom first. Map every top-level form
   (including non-`defun` forms — `defparameter`s, comments) to its destination.
   Grep the rest of the codebase for callers of each moved symbol
   (`grep -rn "format-param-type-check" *.lisp`) — all are same-package
   (`assembly-package-generator`), so no `packages.lisp` export changes should be
   needed; verify.
3. Move forms verbatim — **no editing while moving** (the refactor commit-message
   convention: "pure internal reorganization"). Keep each file's header comment
   block in the established style ("Split out of ...; see
   doc/generator-design-notes.md").
4. `dotcl-packagegen.asd`: add `(:file "apg-type-checks" :depends-on
   ("apg-naming" "apg-member-predicates"))` (verify actual dependencies by grepping
   what the moved code calls); update `apg-overload-dispatch`'s `:depends-on` to
   include `"apg-type-checks"`. Preserve a valid topological order.
5. `make check-parens` (both files), `make build test`, then
   `git diff cspackages-test/` **must be empty** (after
   `revert-cspackages-timestamps.sh`, which `make test` already runs).

### Optional decomposition of `format-param-type-check` (separate commit if done)

If it really is one ~500-line function: after the verbatim move lands green, a
second, separately-verified step may factor its internal branches (primitive check /
Boolean / String / fallback / null-tolerance wrapping) into named helpers — the
v50 design notes describe these branches precisely. Same byte-identical-output
gate applies. This is optional; skip if time-boxed, and note the decision.

## Testing

Entirely covered by the byte-identical gate plus the existing suite: the overload
classification, property/field codegen, generic-method codegen, and operator tests
all route through the moved code. No new tests needed.

## Documentation

* `FILES.md`: add the new file, adjust the old file's description.
* `CLAUDE.md`/`GEMINI.md` architecture map: adjust (or, if Plan 03 already
  restructured it to summarize-and-link-to-FILES.md, only FILES.md needs the edit).
* `doc/generator-design-notes.md`: one line in the same place the original
  modularization is recorded (find where `6a47c35`'s split is documented and extend
  it), NOT a new version section — no generation behavior changed.
* `RELEASES.md`: optional one-liner; CLI `VERSION` patch bump only if a release is
  cut from this change alone.

## Acceptance criteria

* `git diff cspackages-test/` empty after full `make test`.
* Both (all) resulting files under ~450 lines; `apg-type-checks.lisp` contains no
  wrapper-assembly logic and `apg-overload-dispatch.lisp` contains no guard-string
  construction.
* `.asd` load order still valid from a clean `make clean build test`.
