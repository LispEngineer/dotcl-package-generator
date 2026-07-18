# Detail Plan 14: Records and `init`-Only Property Handling

* Part of the plan series from `doc/plan-fable-20260718.md` (section 5.4 item 2);
  addresses `doc/claude-suggested-improvements-20260703.md`'s item 10.
* Standalone. Metadata schema change + output shape change → update
  `doc/assembly-to-lispy.md` **in the same change** (hard repo rule), bump
  `*generator-version*`, design-notes, `FEATURES.md`, `RELEASES.md`.
* Estimated scope: medium.

## Goal

C# records and `init`-only properties are core modern idioms with zero detection
today. Two concrete deliverables:

1. **`init`-only property fidelity**: reflect and surface `init` accessors, and make
   the generated setter behavior deliberate instead of accidental.
2. **Record detection**: mark records in metadata and generated docs, and document
   `with`-style copying guidance.

Explicit non-goal: no `with`-expression emulation (that is Plan 06's `clone` +
setters territory, and records' immutability makes it Plan 06-case-3 anyway; a
record-aware `with`-style constructor helper is a possible follow-up — note it in
the design-notes section, don't build it).

## Part 1 — `init`-only properties

### Reflection (`AssemblyToLispy.cs`)

An `init` accessor is detected via the setter's return-parameter required modifier:

```csharp
bool isInitOnly = setMethod != null && setMethod.ReturnParameter
    .GetRequiredCustomModifiers()
    .Any(m => m.FullName == "System.Runtime.CompilerServices.IsExternalInit");
```

In `FormatPropertyPlist`: emit `:init-only t` on the property plist when detected
(alongside the existing `:writeable`; keep `:writeable t` — it IS writeable, only
restrictedly — the new flag qualifies it). Note the naming collision with the
*field* schema's existing `:init-only` (C# `readonly` fields) — same conceptual
meaning ("settable only during initialization"), so reusing the key is consistent;
state this explicitly in the schema doc.

### Schema + validators

* `doc/assembly-to-lispy.md`: property-plist section gains `:init-only`.
* `tests/framework.lisp`'s property schema validator: allow the new key.

### Codegen decision (the substantive part)

Today an `init` property reflects as writeable → generator emits a normal `setf`
mutator. Reflection *can* invoke init-only setters at runtime (the CLR does not
enforce `init` post-construction; it's a compile-time C# rule) — so the current
setter probably "works" while violating the type's contract. **Verify this against
DotCL live** (a fixture record, `setf` through the generated mutator — does it
succeed?). Then choose, and document in design-notes:

* **Recommended**: keep generating the setter (verified-working, and Lisp callers
  may legitimately need it for construction patterns reflection allows), but (a)
  add a docstring/comment line: "C# declares this property `init`-only — setting it
  after construction violates the type's intended immutability contract"; (b)
  exclude `init`-only setters from `csharp-generics` setter unification only if
  they were included before — keep behavior otherwise identical.
* If verification shows the setter *fails* at runtime under DotCL: switch to
  skip-with-comment (the standard convention) — that's a v26-class silent-broken-
  wrapper fix and should be called out prominently in RELEASES.md.

## Part 2 — Record detection

### Reflection

No single authoritative flag exists; use the standard heuristic, in order:

1. Type has a `public virtual/override` instance property `EqualityContract` of type
   `System.Type` with a protected getter (present on every class record), OR
2. a compiler-generated `<Clone>$` method (`type.GetMethod("<Clone>$")`).

Record structs (C# 10) have neither — they add `PrintMembers`/`Deconstruct`
patterns; treat record-struct detection as best-effort via a `Deconstruct` +
value-type + `PrintMembers` combination, or explicitly punt (recommended: **class
records only in v1**, documented).

Emit `:record t` in the type-level `:flags` (or as a sibling boolean key matching
however `:sealed`/`:abstract` are currently spelled — mirror the existing flags
mechanism exactly; check `GetTypeFlags`).

### Schema + codegen

* `doc/assembly-to-lispy.md`: document the flag + the detection heuristic + its
  best-effort nature.
* Codegen v1 uses it for **documentation only**: the class-file header comment and
  the package comment in `packages.lisp` gain `;; C# record type` and a pointer:
  "prefer constructing new instances over mutating (see init-only notes)".
  `Deconstruct` methods (records generate them; they're `out`-parameter methods →
  currently dirty-skipped, and Plan 05 would make them shine: a record's
  `deconstruct` returning all components as `cl:values`) — cross-reference Plan 05
  in the comment emitted for dirty `Deconstruct` overloads if trivially
  identifiable, else skip.

## Testing

1. Fixtures (`AssemblyToLispyTestTarget/EdgeCases.cs`): a class record
   (`public record PersonRecord(string Name, int Age);`), a class with one `init`
   property + one normal property, a plain class as control. (Confirm the synthetic
   target's `LangVersion`/TFM supports records — net10.0 does.)
2. C# metadata tests + `tests/synthetic-target.test.lisp`: `:record` present on the
   record, absent on control; `:init-only` on the init property only.
3. Codegen unit tests: docstring/comment lines emitted for init setter and record
   header.
4. Runtime verification transcript (Part 1's setter question) recorded in
   design-notes; automated in Plan 02's suite if available.
5. Smoke `cspackages-test/` diff: BCL classes are unlikely to change (few records in
   the generated set — `System.Range`? none currently generated); the synthetic
   classes carry the demonstration. `make check-parens`; full `make test`.

## Documentation

Standard set: `*generator-version*` bump + changelog, design-notes section (both
parts + verification transcript), `doc/assembly-to-lispy.md` (schema — same change),
`FEATURES.md` ("Records and Init-Only Properties" section; amend Unsupported),
`RELEASES.md`, CLI `VERSION` minor bump.
