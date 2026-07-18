# Detail Plan 10: Collapse Degenerate Master Wrapper `cond` Branches

* Part of the plan series from `doc/plan-fable-20260718.md` (section 4.3); addresses
  `PLAN.md`'s Miscellaneous item about `System.Linq.Enumerable.Average()`'s
  many-identical-branch `cond`.
* Standalone; benefits from Plan 09's split (the change lands in dispatch/assembly
  code) but does not require it.
* Output shape changes → `*generator-version*` bump + design-notes section +
  `RELEASES.md`.
* Estimated scope: medium — small in code, but **dispatch-ordering is this repo's
  most bug-prone area (v49!)**; the safety argument must be airtight.

## Problem

The Master Wrapper emits one `cl:cond` branch per clean overload. When several
overloads' guards degenerate to the same test (commonly "argument is a .NET object"
— `dotnet:is-instance-of` unavailable distinctions, or LINQ's many
selector-overloads), the generated `cond` contains runs of branches with literally
identical guards, of which only the first is ever reachable; sometimes the bodies
are identical too. `Enumerable.Average` is the canonical offender. Effects: bloated
output, and — worse for this project's workflow — *unauditable* output (humans
finding dispatch bugs by reading generated code is how v48–v50 were caught).

## Safety analysis (write this into the design-notes section)

Guard ordering is semantic (v49 fixed exactly an ordering bug). The only
transformations permitted are ones that provably cannot change dispatch:

* **T1 — Dead-branch elision**: if branch *i* and branch *j* (*i* < *j*) have
  byte-identical guard strings, branch *j* is unreachable regardless of bodies.
  Dropping *j* never changes behavior. When bodies differ, dropping *j* silently
  discards an overload that was already unreachable — that is a *pre-existing*
  dispatch limitation now made visible: emit a comment in place of the dropped
  branch (`;; unreachable: same runtime guard as <sig above>; calls <sig>`), listing
  the shadowed overload's signature. This surfaces latent ambiguity rather than
  hiding it — very much in this repo's spirit.
* **T2 — Uniform-body collapse**: if after T1 every remaining branch has a
  byte-identical body AND the branch set is guard-exhaustive for the wrapper (ends
  in the error/fallthrough branch pattern the Master Wrapper emits — verify the
  actual shape: does it end with `(cl:t (cl:error ...))` /
  `csharp-overload-not-found`?), the whole `cond` may reduce to the single body —
  but ONLY if the final else-branch is the not-found error and at least one guard
  exists... Careful: reducing to the bare body *removes* the argument validation the
  guards provided (a wrong-typed argument would now reach `dotnet:invoke` instead of
  signaling `csharp-overload-not-found`). Decision: **keep validation** — collapse
  to `(cl:cond (<single shared guard> <body>) (cl:t <not-found error>))` when all
  guards are also identical (which T1 already produces: one branch + error branch —
  i.e. T2 falls out of T1 automatically). So T2 as a distinct transformation is
  unnecessary; T1 alone, applied at the branch level, achieves the Average cleanup.
  Record this reasoning.

No reordering, no guard merging, no "similar" matching — identical strings only.

## Implementation

1. **Locate the branch-assembly point.** The Master Wrapper's per-overload branches
   are built inside `apg-overload-dispatch.lisp`'s dispatch machinery (within
   `format-param-type-check`'s callers / `generate-method-name-wrappers` path — or
   `apg-type-checks.lisp` + dispatch after Plan 09). Find where the per-overload
   (guard, body) pair becomes text. The transformation wants the pairs **as data
   before concatenation**: if the current code formats each branch directly to the
   stream, refactor minimally so branches are first collected into a list of
   `(guard-string body-string signature-string)` triples, then emitted.
2. Apply T1 over the collected triples: walk in order, keep a hash-set of seen
   guard strings; a duplicate becomes an emitted comment line (with its
   `method-signature-str`) instead of a branch.
3. Constructors' Master Wrapper (`emit-constructors` Case 3) uses the same dispatch
   machinery — confirm it flows through the same collection point so both benefit;
   same for the static/instance `name*` split and generic-arity internal functions.
4. This applies to *positional-slot* guards too (the `&optional`/`&key` default
   dispatch added in v48): make sure dedup keys on the complete guard expression for
   the branch, not a fragment.

## Testing

1. Unit (`package-generator-tests-overload-classification.lisp` or the codegen test
   files): mock a method group with (a) two overloads producing identical guards +
   different bodies → assert one branch + one `;; unreachable:` comment; (b)
   identical guards + identical bodies → one branch, comment optional (decide:
   still emit the comment for uniformity — recommended); (c) distinct guards →
   untouched, order preserved byte-for-byte.
2. Smoke: `cspackages-test/system-linq-enumerable.lisp` diff — `average` (and
   likely `sum`, `max`, `min`) shrink dramatically; **manually review every changed
   wrapper in the diff** to confirm only duplicate-guard branches disappeared and
   each got its comment. The diff review is the main acceptance gate.
3. Runtime (Plan 02 suite if present): call a collapsed wrapper (Average over a
   list) and a multi-branch wrapper on each branch — assert unchanged behavior.
4. `make check-parens`; full `make test`.

## Documentation

* `*generator-version*` bump + docstring changelog line.
* `doc/generator-design-notes.md`: new version section including the safety analysis
  above and the explicit non-goals (no reordering/merging).
* `FEATURES.md`: brief note in the overload-dispatch description that
  unreachable same-guard overloads are elided with a comment.
* `RELEASES.md` + CLI `VERSION` minor bump (lockstep).
* `PLAN.md`: append DONE on the Average item.
