# Detail Plan 11: Arity-Less Package Nicknames for Generic Types

* Part of the plan series from `doc/plan-fable-20260718.md` (section 4.4); addresses
  `PLAN.md`'s "Handle generic classes name mangling using backticks more elegantly"
  Miscellaneous item, via a different (additive, filename-preserving) mechanism than
  the `list<1>` idea sketched there.
* Standalone. Output shape change (packages.lisp) → `*generator-version*` bump.
* Estimated scope: small.

## Problem

A generic type's package name carries its CIL arity suffix:
`System.Collections.Generic.List\`1` → package `system-collections-generic-list-1`.
Users typically neither know nor care about generic arity; guessing `-1`/`-2` is a
real usability wart (PLAN.md: "hard for users, who ... might not easily guess the
package name"). The `PLAN.md` idea of `list<1>` naming has a fatal flaw it itself
notes: package names double as filenames, where `<`/`>` are hostile.

## Design: additive nicknames, collision-guarded

Keep the canonical arity-suffixed package name and filename **unchanged**. In the
generated `packages.lisp`, add an arity-less `:nicknames` entry when unambiguous:

```lisp
(cl:defpackage #:system-collections-generic-list-1
  (:nicknames #:system-collections-generic-list)
  ...)
```

`(list:add ...)`-style references then work via
`system-collections-generic-list:...` — and, combined with any user-level package
local nicknames, read naturally.

### Rules

1. Candidate nickname: `type-fq-name-to-pkg-name` applied to the fq-name with the
   backtick-arity suffix stripped (only for types whose fq-name matches
   `generic-arity-fq-name-p` — the helper already exists in `apg-naming.lisp`).
   Nested generic types (`Dictionary\`2+KeyCollection`) — the arity token is
   *internal* (`...-dictionary-2-key-collection`): decide and document. Recommend:
   strip **every** `-N` arity token derived from a backtick when forming the
   nickname (`...-dictionary-key-collection`), computed from the fq-name (each
   `` `N `` segment), never by pattern-matching the kebab name (a literal `2` in a
   real type name like `Vector2` must survive — the transformation must run on the
   fq-name where backticks unambiguously mark arity).
2. **Collision guard (batch-wide):** the nickname is emitted only if, across the
   entire batch (all generated packages, all their canonical names AND all candidate
   nicknames), it is unique. `List\`1` alongside a hypothetical `List\`2` in one
   batch → neither gets the nickname; a nickname equal to any canonical package name
   (`Vector2` → `...-vector2` colliding with a nickname candidate from
   `Vector\`2`... note: `Vector\`2`'s candidate is `...-vector`, `Vector2`'s
   canonical is `...-vector2` — distinct; but engineer the check symmetrically
   anyway) → suppressed. When suppressed, emit a comment above the defpackage:
   `;; No arity-less nickname: would collide with <other>`.
3. **Cross-package references stay canonical.** Re-export forms, `csharp-generics`,
   `.asd` comments — everything the generator itself emits keeps using the canonical
   name. Nicknames are purely a user convenience surface (and this keeps the diff
   small and the invariant simple).

### Implementation points

* Batch-wide name collection + collision logic: in
  `generate-batch-packages-file` (`apg-reexports-and-generics.lisp`), which already
  sees every package in the batch; a pre-pass over all resolved classes builds
  {canonical → candidate} and the suppression set. Also confirm where the
  `csharp-generics` / `csharp-assembly-utils` package names enter the namespace —
  include them in the collision universe.
* Nickname computation: new helper in `apg-naming.lisp` (e.g.
  `type-fq-name-to-arityless-pkg-name`, returning `nil` for non-generic names),
  unit-tested alongside the existing naming tests.

## Testing

1. Unit (`package-generator-tests-naming.lisp`): the helper — `List\`1` →
   `...-list`; `Dictionary\`2+KeyCollection` → `...-dictionary-key-collection`;
   `Vector2` (no backtick) → `nil`; `ValueTuple\`2` vs `ValueTuple\`3` present
   together → both suppressed (collision logic test lives at the batch level —
   put it in `package-generator-tests-batch-resolution.lisp` or the defgeneric/
   packages-file codegen tests, wherever `generate-batch-packages-file` is already
   exercised with mocks).
2. Smoke: `cspackages-test/packages.lisp` diff — `List\`1`, `Dictionary\`2`,
   `SortedList\`2` gain nicknames; the seven `ValueTuple\`N` entries all get the
   suppression comment (a perfect built-in demonstration of the collision rule —
   mention this in the design-notes section); nested `KeyCollection`/
   `ValueCollection` per rule 1.
3. Plan 01's `--read-check` (if landed) validates the new defpackage forms read
   correctly; Plan 02's runtime suite (if landed) can reference one package by
   nickname.
4. `make check-parens`; full `make test`.

## Documentation

* `*generator-version*` bump + changelog line; design-notes section (include the
  nested-type stripping rule and collision universe definition).
* `FEATURES.md`: extend the "Type/package naming" Conventions subsection.
* `README.md`/`CLAUDE.md` brief mention; `RELEASES.md` + CLI `VERSION` minor bump.
* `PLAN.md`: append a note under the backtick-mangling item recording this as the
  chosen direction (the `list<1>` idea superseded).
