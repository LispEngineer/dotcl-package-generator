# Detail Plan 16: Surface `[Obsolete]` and Tuple Element Names

**Status: DONE** — see commit 44f4d0c (Version 53). Tuple-element-name half scoped to
metadata only; docstring-rendering codegen deferred as documented future work.

* Part of the plan series from `doc/plan-fable-20260718.md` (section 5.4 items 4–5);
  addresses `doc/claude-suggested-improvements-20260703.md`'s items 9 and 11 (the
  `[Obsolete]` slice of 11 only — general attribute reflection stays out of scope).
* Standalone; the two halves are independent and may be split into separate commits.
* Metadata schema changes + docstring/comment-only output changes → schema doc
  same-change rule, `*generator-version*` bump, design-notes, `FEATURES.md`,
  `RELEASES.md`. Documentation-only: no dispatch impact (same hard constraint as
  Plan 15).
* Estimated scope: small.

## Half A — `[Obsolete]`

### Goal

Calling an obsolete member from Lisp today gives zero warning. Surface the
attribute so generated docstrings/comments carry it.

### Reflection (`AssemblyToLispy.cs`)

For types, methods, constructors, properties, fields, events:

```csharp
var obs = member.GetCustomAttribute<ObsoleteAttribute>();
// -> emit  :obsolete t  plus  :obsolete-message "..."  (when Message non-null)
//    plus  :obsolete-error t  (when IsError -- compiler-error-level obsolete)
```

Keys on the respective plists (type-level: alongside the other type keys, not
inside `:flags` — it carries a message payload, unlike the boolean flags; document
the choice). Message strings go through the existing `EscapeLispString`.

### Codegen

* Member wrappers: first docstring line after the signature part:
  `OBSOLETE: <message>` (or `OBSOLETE.` when no message). Applies to method
  wrappers (all emission paths), property/field accessors, event add/remove pairs,
  constructors (the Master Wrapper docstring notes which overloads are obsolete via
  the existing per-overload doc block).
* Obsolete-as-error members (`:obsolete-error`): still generate (reflection can
  invoke them; the error level is a C#-compiler concern) but say so:
  `OBSOLETE (error-level): ...`.
* Type-level obsolete: a header comment line in the class file + the package
  comment in `packages.lisp`.
* Decide + document: obsolete members are NOT excluded from generation or from
  `csharp-generics` (no behavior change — visibility only).

### Tests

Fixtures: `[Obsolete]`, `[Obsolete("use X instead")]`,
`[Obsolete("gone", true)]` members + one obsolete type in `EdgeCases.cs`; metadata
assertions (C# + `tests/synthetic-target.test.lisp` — validators updated); codegen
unit tests for the docstring lines. Smoke diff: BCL obsolete members (e.g. some on
`System.AppDomain`/`Environment` — verify) gain the marker.

## Half B — Tuple element names

### Goal

`(int Count, string Name) GetStats()` currently reflects as bare
`System.ValueTuple\`2[System.Int32,System.String]` — the semantic element names
(`Count`, `Name`) are erased from the type string. Surface them in docstrings.

### Reflection

Element names live in `[TupleElementNames]`
(`System.Runtime.CompilerServices.TupleElementNamesAttribute`, `TransformNames`
property) on the *parameter/return-parameter/property/field*, not the type. Note
`TransformNames` is a flattened pre-order list covering nested tuples — v1 handles
the **non-nested** case only (names count == tuple arity); when nesting is detected
(count mismatch), emit nothing (document).

Keys, emitted only when names exist:

* Parameter plist: `:tuple-element-names ("count" "name")` — decide raw C# names
  vs pre-kebab'd; **recommend raw C# names** (metadata stays a faithful reflection
  record; kebab-casing is generator policy) — document in schema.
* Method plist: `:tuple-element-return-names (...)`.
* Property/field plists: `:tuple-element-names`.

### Codegen

Docstrings only: where a tuple-typed parameter/return is mentioned, render the
C#-style named form `(System.Int32 Count, System.String Name)` instead of / next to
the raw `ValueTuple` string. Cheapest correct implementation: a helper in
`apg-overload-signatures.lisp` that, given the type string + names list, produces
the annotated rendering used by the docstring builders (leave
`method-signature-str`'s comment-facing output unchanged if that keeps the change
smaller — decide and be consistent).

### Tests

Fixtures: method returning a named tuple, method taking one, a nested-tuple case
(asserting *no* keys emitted); schema validator updates; codegen docstring test.
Smoke: minimal BCL impact expected (few named tuples in the generated set) — the
synthetic fixtures carry the demonstration.

## Shared closing checklist

* `doc/assembly-to-lispy.md` updated for every new key, same change (hard rule).
* `tests/framework.lisp` validators extended.
* `*generator-version*` bump (+ changelog line) once for the combined change (or
  once per half if split); design-notes section(s).
* `FEATURES.md`: extend the documentation-comments description; strike/amend the
  corresponding Unsupported bullets (attributes bullet: note `[Obsolete]` is now
  the surfaced exception; tuple names bullet removed).
* `RELEASES.md`; CLI `VERSION` minor bump (lockstep).
* `make check-parens`; full `make test`; review `cspackages-test/` diff.
