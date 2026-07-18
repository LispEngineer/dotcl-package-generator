# Detail Plan 15: Nullable Reference-Type Annotations in Docstrings

* Part of the plan series from `doc/plan-fable-20260718.md` (section 5.4 item 3);
  addresses `doc/claude-suggested-improvements-20260703.md`'s item 12.
* Standalone. Metadata schema change + docstring-only output change →
  `doc/assembly-to-lispy.md` update in the same change, `*generator-version*` bump,
  design-notes, `FEATURES.md`, `RELEASES.md`.
* Estimated scope: small-medium.
* **Hard constraint — documentation only.** NRT annotations are erased at runtime
  and MUST NOT feed any dispatch guard or type check. Version 49/50's history is the
  cautionary tale; this plan deliberately keeps the entire feature out of
  `apg-overload-dispatch`/`apg-type-checks` code paths. State this in the
  design-notes section.

## Goal

Surface C# nullable reference-type annotations (`string?` vs `string`) so generated
docstrings can tell the caller "this parameter accepts nil" / "this return value may
be nil". Value-type nullability (`Nullable<T>`) is already fully handled by v50's
`:nullable-underlying-type` — this plan covers *reference* types only, and must not
disturb the v50 keys.

## Reflection (`AssemblyToLispy.cs`)

Use .NET 6+'s official `System.Reflection.NullabilityInfoContext`:

```csharp
private static readonly NullabilityInfoContext NullCtx = new();
// per parameter:  NullCtx.Create(parameterInfo).ReadState / .WriteState
// per return:     NullCtx.Create(methodInfo.ReturnParameter)
// per property:   NullCtx.Create(propertyInfo)
// per field:      NullCtx.Create(fieldInfo)
```

`NullabilityState` is `Nullable`/`NotNull`/`Unknown` (Unknown = assembly compiled
without NRT context — most older assemblies). Note: `NullabilityInfoContext` is not
thread-safe; the reflection pass is single-threaded (verify), so a shared instance
is fine — comment it.

### Metadata keys (documentation-only by construction)

Emit **only when the state is `Nullable`** (omit for NotNull/Unknown — keeps
metadata compact and unambiguous: absent = "not declared nullable or unknown"):

* Parameter plist: `:nullable-annotated t`
* Method plist: `:nullable-annotated-return t`
* Property/field plist: `:nullable-annotated t`

Key naming rationale (record in schema doc): deliberately distinct from v50's
`:nullable-underlying-type` family so no reader can confuse "runtime-relevant
`Nullable<T>` unwrapping data" with "advisory NRT annotation". Reference types only:
skip emission when the parameter/return type is a value type (a `Nullable<T>`
already carries the v50 key; emitting both would be redundant noise).

### Schema + validators

`doc/assembly-to-lispy.md`: add the keys to parameter/method/property/field plist
sections with the reference-type-only + Nullable-state-only emission rule.
`tests/framework.lisp` validators: allow the keys.

## Codegen (docstrings only)

`build-docstring` / `format-overload-doc-block` /
`format-combined-overloads-docstring` (`apg-overload-signatures.lisp`) and the
property/field accessor docstrings (`apg-class-file-generator.lisp`):

* Parameter list lines: append ` (may be nil)` to an annotated parameter's mention;
  where docstrings currently render signatures via `method-signature-str`, render
  the C#-style `?` suffix on the type name inside the signature string instead —
  choose ONE presentation (recommended: `?` suffix in signature strings, since the
  docstrings are already C#-signature-shaped) and apply uniformly.
* Return: a line `Returns: <type>? (may be nil)` or the `?`-suffixed signature.
* Property getter docstring: `May return nil.` when annotated; setter: `Accepts
  nil.`

Signature-string changes also affect the dirty/skip **comments** (they use
`method-signature-str`) — acceptable and desirable; verify no test asserts exact
signature text that must be updated (several unit tests will — update them).

## Testing

1. Fixtures: `AssemblyToLispyTestTarget` is compiled with `<Nullable>enable</Nullable>`?
   — **check the csproj**; if not, enable it (audit warnings) or scope annotations
   to a new small fixture file with `#nullable enable`. Add:
   `string? MaybeName(string? input)`, `string DefinitelyName(string input)`, a
   `string?` property, and one method in a `#nullable disable` region (→ Unknown →
   no key).
2. C# metadata tests + `tests/synthetic-target.test.lisp`: keys present/absent per
   fixture; explicitly assert the *absence* on Unknown and on value-typed params.
3. Codegen unit tests: docstring text contains the marker for annotated, not for
   unannotated.
4. Smoke: `cspackages-test/` diff — BCL assemblies ARE NRT-annotated, so many
   docstrings gain `?` markers; **expect a large but mechanical diff**; spot-check
   `System.String`/`System.Console` members against learned C# signatures.
5. `make check-parens`; full `make test`; Plan 01's `--read-check` if landed.

## Acceptance criteria

* Zero changes under `grep -n "nullable" apg-overload-dispatch.lisp`
  (/`apg-type-checks.lisp`) — the no-dispatch-impact constraint, mechanically
  checkable.
* Annotated fixture members' docstrings show nullability; Unknown-state members
  unchanged.
* Standard doc set updated (schema doc same-change; version bumps; design-notes
  section including the documentation-only constraint and key-naming rationale;
  `FEATURES.md` note under Documentation Comments; amend the Unsupported item).
