# Detail Plan 06: Generated Struct `clone` Helper (PLAN.md Option A)

* Part of the plan series from `doc/plan-fable-20260718.md` (section 3.4); implements
  `PLAN.md`'s "Clone a Boxed Struct" **HIGH PRIORITY** item, Option A of its
  2026-07-04 research pass (generator-emitted per-type helper), staged per Option C:
  Option B (`dotnet:clone` upstream) is a separate one-paragraph proposal write-up
  included at the end of this plan.
* Standalone. Output shape changes → `*generator-version*` bump + design-notes
  section + `RELEASES.md` + `FEATURES.md`.
* Estimated scope: medium.

## Goal

Give users a safe way to copy a boxed struct so mutating the copy cannot corrupt
shared/cached instances (the Version 29 aliasing hazard: mutating a
`--constant-properties` memoized constant through any alias permanently corrupts the
"constant"). For every generated **struct** package, emit a `clone` function returning
an independent boxed copy.

## Background — code locations (post-refactor; PLAN.md's line refs are stale)

* Struct detection: `classify-class-members` (`apg-member-predicates.lisp`) already
  branches on `(eq kind :struct)` for the synthesized parameterless constructor;
  `(getf class-plist :kind)` is the source of truth (`:struct`/`:enum` = value types;
  **exclude `:enum`** — enums are immutable literals, nothing to clone).
* Readable/writeable member data: `cmc-instance-prop-groups` (single-signature,
  non-indexer groups only — indexers are excluded exactly as the existing accessor
  codegen excludes them), `cmc-instance-fields` (`:init-only` fields are readable but
  not settable).
* Constructor data: `cmc-clean-ctors`; the synthesized parameterless ctor for structs
  is always present (injected in `classify-class-members`).
* Emission home: new `emit-clone-function` helper in `apg-class-file-generator.lisp`,
  called from `generate-class-file` after the constructors section.
* Aliasing warning comment emitters live in `apg-immutability.lisp` — the clone
  function's docstring should cross-reference the same FEATURES.md section they cite.

## Design

### Name and collision handling

The function is package-local, so `clone` (not `clone-vector2`) is idiomatic:
`(vector2:clone v)`. Collision rule: if the class already has any member whose mapped
name is `clone` (C# `Clone()` is common — `System.String`, arrays, `ICloneable`
implementers), name ours `clone!` instead (consistent with the existing
reserved-name `!`-suffix convention) and emit a comment explaining why. Check against
the same name universe `compute-package-exports-and-shadows` builds (methods,
properties, fields, events, extension methods) — implement as a lookup against the
already-computed export set to guarantee agreement.

### Generation cases (from PLAN.md's research, updated to current code)

For each `:struct` class:

1. **Full-coverage case** — every *readable* single-signature instance
   property (`:readable`, non-indexer) is also *writeable*, and every public instance
   field is non-`:init-only`:
   ```lisp
   (cl:defun clone (obj!)
     "Returns an independent boxed copy of OBJ! ... (docstring cites the
      aliasing hazard and FEATURES.md's Struct Boxing Caveat section)"
     (cl:let ((copy (new)))
       (cl:setf (x copy) (x obj!))
       (cl:setf (y copy) (y obj!))
       copy))
   ```
   Uses the *generated wrapper names* (via the same mapped names the accessor
   emission computed), not raw `dotnet:invoke` — keeps it consistent and exercises
   the wrappers. `new` is the struct's parameterless constructor wrapper (always
   present for structs). Careful: if the package shadows `t`/`nil`-like names, all
   emitted operators are already `cl:`-qualified per repo convention — follow it.
2. **Constructor-match case** — not fully settable, but a clean constructor exists
   whose parameter list corresponds 1:1 to the full readable-member set. Match by
   count AND case-insensitive name correspondence between `map-param-name`d
   constructor parameters and mapped readable member names (e.g. `Vector2(float x,
   float y)` ↔ properties/fields `x`,`y`). Emit
   `(new (x obj!) (y obj!))` in constructor-parameter order. If several clean ctors
   qualify, prefer the exact-count full match; if name correspondence is partial,
   **do not guess** — fall to case 3.
3. **Unsupported case** — neither applies: emit no function, but a documenting
   comment (the established convention):
   ```lisp
   ;; No clone function generated for this struct: its readable state is not
   ;; fully reconstructible via settable members or a matching constructor.
   ```
4. Structs with NO readable instance members (marker structs): case 1 vacuously
   applies → `clone` is just `(new)` — fine, emit it.

### Export

Add the chosen name to the package's export list via
`compute-package-exports-and-shadows` (new logic must run there too, or the export
computation must be told the clone name — keep the decision logic in ONE function
called from both sites, mirroring how `event-wrapper-names` is shared to prevent
name disagreement).

## Testing

1. Unit tests (new `package-generator-tests-clone.lisp`, registered in
   `generator-tests.lisp`, added to `.asd`): mock struct plists for each case —
   full-coverage, ctor-match, unsupported, name-collision → `clone!`, enum → nothing.
   Assert emitted text and export list.
2. Fixtures: `AssemblyToLispyTestTarget/EdgeCases.cs` — add (if not present) a fully
   settable struct, a ctor-match-only struct (get-only properties + matching ctor),
   an unclonable struct, and a struct with its own `Clone()` method. Update
   `tests/synthetic-target.test.lisp` schema expectations.
3. Smoke: `cspackages-test/` diff — `System.TimeSpan` (get-only props + no matching
   full ctor? verify — likely case 3), the synthetic structs, and any
   `System.Numerics.Vector*` (constant-properties classes — the motivating case;
   `Vector2` has settable `X`/`Y` fields → case 1) gain `clone`.
4. Runtime (Plan 02 suite if present): clone a struct, mutate the copy, assert the
   original (and a memoized constant) is unchanged — the whole point of the feature.
5. `make check-parens`; full `make test`.

## Documentation

* `*generator-version*` bump + docstring line; design-notes section "Generated
  Struct clone Helper (Version NN)" covering the three cases and the collision rule.
* `FEATURES.md`: new "Cloning Structs" section; update "Struct Boxing Caveat" to
  point at `clone` as the mitigation.
* `RELEASES.md` + CLI `VERSION` minor bump (lockstep per `BUILD.md`).
* `PLAN.md`: append a dated DONE note under "Clone a Boxed Struct" (never rewrite the
  existing text), noting Option A shipped and Option B's status (below).

## Companion (small, do in same change): Option B upstream proposal

Add a `dotnet:clone` proposal subsection to `doc/dotnet-dotcl-interop.md`'s "Missing
Interoperability Capabilities & Proposed Enhancements" section, condensed from
`PLAN.md`'s Option B research (MemberwiseClone via skip-visibility dynamic method;
registration precedent in `Startup.cs`). If/when it ships upstream, a future
generator version can switch cases 1–2 to `(dotnet:clone obj!)` and case 3 becomes
supported — note that forward path in the proposal.
