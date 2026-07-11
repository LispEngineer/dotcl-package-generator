# Post-DotCL-0.1.17 Generic-Type Enhancements: Living Follow-Up

* Status: LIVING DOCUMENT — tracks the gap between what DotCL provides for .NET generic types
  and what `dcl-packagegen` would ideally have, updated as new DotCL releases land.
* Related: `doc/dotcl-0.1.16-defgeneric-csharp-generic-notes.md` (the prior-cycle research this
  document is the direct successor to — read that first for full mechanism detail on
  `EnsureDotNetTypeClass`/the simple-name registration race), `doc/dispatch-on-open-generics.md`
  (deep dive + concrete proposal for item 1 below), `doc/generator-design-notes.md`'s Version 41
  section, `doc/make-everything-defgeneric.md`.

## Why this document exists

`doc/dotcl-0.1.16-defgeneric-csharp-generic-notes.md` researched DotCL 0.1.16's generic-type
CLOS dispatch mechanism and ended with an "Appendix: Suggestions for DotCL" — four concrete
proposals. DotCL 0.1.17 shipped (RELEASES.md explicitly credits that doc for driving "much of
this cycle's interop work") implementing suggestions #1 and #2 almost verbatim:

1. ✅ **Implemented (0.1.17).** `dotnet:class-for-type` — public, lazily-registering lookup for
   a .NET type's CLOS class, usable directly as a `defmethod` specializer.
2. ✅ **Implemented (0.1.17).** `defmethod` accepts a class object (not just a class-name
   symbol) as a specializer, via read-time `#.`.
3. ❌ **Not implemented.** An open-generic marker class in the CPL, so a `defmethod` can
   dispatch on "any closing of this generic" — see `doc/dispatch-on-open-generics.md` for the
   detailed gap analysis and a concrete design proposal.
4. ❌ **Not implemented.** A one-time diagnostic when `EnsureDotNetTypeClass`'s
   cross-namespace-collision fallback path triggers (still silent). Lower priority now that
   items 1-2 give `dcl-packagegen` a collision-proof alternative for its own generated code
   (see below) — but still relevant for anyone hand-writing a literal specializer symbol.

Two items landed as free side effects of 1-2 that the 0.1.16 doc didn't explicitly ask for but
directly matter to this project:

5. ✅ **Implemented (0.1.17).** `DotNetTypeDisplayName` gives every **closed** generic
   instantiation its own distinct, readable class name (`List<Int32>` vs `List<String>`)
   instead of every instantiation colliding on the bare backtick form. This is what makes
   closed-instance dispatch reliable at all under `#.(dotnet:class-for-type ...)`.
6. ✅ **Implemented (0.1.17).** `dotnet:resolve-type` auto-loads `PackageReference` assemblies
   from the app base directory on a miss (lazy, memoized, auto-invalidated) — reduces (does not
   eliminate) load-order fragility for any of these mechanisms.

## What `dcl-packagegen` did with items 1-2 and 5

Generator Version 41 (`assembly-package-generator.lisp`, see
`doc/generator-design-notes.md`'s Version 41 section) consolidated the two previous
`--defgeneric`/`--defgeneric-dynamic` mechanisms into one, built directly on items 1, 2, and 5:
every generated dispatch `defmethod` now specializes on `#.(dotnet:class-for-type "<fq-name>")`
— an ordinary top-level form, immune to the pre-0.1.17 load-order-dependent naming race, and
(thanks to item 5) correct for closed generics too, where the old mechanism was silently
broken. See `doc/make-everything-defgeneric.md` for the user-facing feature description.

## Remaining gaps (this project's perspective)

Prioritized by what they'd unblock in `dcl-packagegen` specifically:

### 1. Open-generic dispatch (suggestion #3) — HIGH

Covered in full in `doc/dispatch-on-open-generics.md`. Currently blocks `--defgeneric` from
covering any generic-arity class at all (`Dictionary\`2`, `List\`1`, etc. — the class still
gets its own ordinary package; only unified-generic-dispatch coverage is missing). The
CPL-marker-class proposal there is this project's recommended fix.

### 2. No way to reflect/generate a package for one specific closed instantiation — MEDIUM

`doc/generator-design-notes.md`'s Version 40 note already established that "no arbitrary
closed instantiation is ever itself separately reflected as its own top-level metadata entry"
— `AssemblyToLispy.cs` only ever reflects open generic type definitions. This is a
`dcl-packagegen`-side limitation, not a DotCL one, but item 5 above (closed instantiations now
getting distinct, stable, *predictable* class names from `DotNetTypeDisplayName`) makes it more
tempting to ask for: could `--class` someday accept a closed form (e.g.
`'System.Collections.Generic.List\`1[System.Int32]'`) and generate a full wrapper package for
that specific closing, not just a dispatch defmethod? This would require:
   - `AssemblyToLispy.cs` support for constructing/reflecting a closed instantiation on demand
     (via `Type.MakeGenericType`), not just enumerating what's already in the assembly's type
     table.
   - A naming convention for the generated package (`system-collections-generic-list-1-int32`?)
     distinct from the open definition's own package.
   - Deciding whether the closed package's methods should still forward through
     `dotnet:invoke`/`dotnet:static-generic` on the open type (as today's open-definition
     packages already do, working correctly for any instantiation via the generic-arity method
     wrappers) or whether a closed package buys anything beyond what `--defgeneric` dispatch
     (once item 1 lands) would already give a caller.
   - This is speculative — no concrete user request has driven it yet, unlike item 1. Listed
     here for completeness/tracking, not as an active proposal.

### 3. Silent collision diagnostic (suggestion #4) — LOW

No longer blocks anything in `dcl-packagegen`'s own generated code (item 2 sidesteps the whole
class-name-guessing problem), but still relevant to anyone hand-writing a literal
`dotcl-internal::|Name|`-style specializer against a package this tool generates (e.g. in
downstream application code, not in generated files themselves). Low priority; revisit only if
a concrete downstream pain point surfaces.

### 4. `dotnet:resolve-type` assembly-loading ordering — LOW / MONITORING ONLY

Item 6 (lazy `PackageReference` assembly auto-loading) reduces but does not fully eliminate the
requirement that `csharp-generics.lisp` load after every opted-in class's own file (so each
`#.(dotnet:class-for-type ...)` resolves against an already-loaded assembly) — this is
documented as an ordering requirement in `generate-batch-generics-file`'s docstring and encoded
in `generate-batch-asd-file`'s `:depends-on` lists, not something DotCL 0.1.17 changed the need
for. No action item here; noted only so a future DotCL release that further changes
`resolve-type`'s laziness/caching behavior gets checked against this ordering assumption.

## Status tracking

| Item | Source | Status | DotCL version |
|---|---|---|---|
| `dotnet:class-for-type` | 0.1.16 notes #1 | ✅ Implemented, adopted (Version 41) | 0.1.17 |
| `defmethod` class-object specializer | 0.1.16 notes #2 | ✅ Implemented, adopted (Version 41) | 0.1.17 |
| Open-generic CPL marker class | 0.1.16 notes #3 | ❌ Proposed (`doc/dispatch-on-open-generics.md`) | — |
| Collision diagnostic | 0.1.16 notes #4 | ❌ Not implemented, low priority | — |
| Closed-generic distinct display names | (side effect) | ✅ Implemented, adopted (Version 41) | 0.1.17 |
| Lazy `PackageReference` assembly loading | (side effect) | ✅ Implemented, monitoring only | 0.1.17 |
| Closed-instantiation-specific package generation | new (this doc) | Speculative, not proposed upstream | — |

Update this table (and add new rows) whenever a future DotCL release touches generic-type CLOS
registration, `dotnet:resolve-type`, or related dispatch machinery.
