# Suggested Improvements: C# Capability Gap Analysis (2026-07-03)

This is a gap analysis of `dotcl-packagegen` as of generator version 25, covering both
halves of the pipeline:

* **Reflection layer** (`AssemblyToLispy.cs`) — what C# language/type-system
  capabilities are captured into the `.lispy.metadata` s-expression format at all.
* **Codegen layer** (`assembly-package-generator.lisp`) — of what *is* captured, what
  actually turns into generated Lisp wrapper code vs. gets silently skipped, documented
  as "dirty", or simply never consumed.

Findings come from reading both files directly against their design docs
(`doc/assembly-to-lispy.md`, `doc/generator-design-notes.md`), the edge-case test target
(`AssemblyToLispyTestTarget/EdgeCases.cs`) and Lisp test suite, and the project's own
`PLAN.md` and `doc/lispy-csharp-standard-library.md` (which already sketches design
thoughts for several of these). Items already owned by `PLAN.md` are cross-referenced
rather than duplicated — see the closing note.

Each item below has:

* **Priority** — High/Medium/Low, based on how commonly the construct appears in
  real-world C# APIs you'd plausibly want to wrap, and how bad the failure mode is when
  it's missing (silent omission is worse than a documented skip).
* **Difficulty** — High/Medium/Low, a rough implementation-cost estimate spanning
  reflection changes, schema changes, and codegen changes as needed.

Items are ordered roughly by priority, highest first.

---

## 1. Indexers (`this[]`) — **FIXED in generator version 26**

> **Update (2026-07-03):** fixed. See `RELEASES.md`'s 2.26.0 entry and
> `doc/generator-design-notes.md`'s "Indexer Support (Version 26)" section. The description below
> is left as-is for historical context (what was broken and why).

Indexers (`this[]`) — **currently generates broken code**

`FormatPropertyPlist` (`AssemblyToLispy.cs:404-443`) never captures index parameters for
indexer properties. This isn't just a missing feature — it actively emits a
runtime-broken wrapper today. Confirmed in
`cspackages-test/system-collections-generic-dictionary-2.lisp:105-109`, where
`Dictionary<TKey,TValue>`'s indexer becomes:

```lisp
(cl:defun item (obj!) ... "get_Item")
(cl:defun (cl:setf item) (new-value obj!) ... "set_Item" new-value)
```

silently dropping the required `key` argument. Calling either today fails or does the
wrong thing at runtime.

* **Priority: High** — indexers are ubiquitous (`Dictionary`, `List`, custom
  collections), and this is silent, not just absent.
* **Difficulty: Medium** — needs index-parameter capture added to `FormatPropertyPlist`
  (`AssemblyToLispy.cs:404-443`), plus a new codegen branch mirroring the existing
  property get/set pattern (`assembly-package-generator.lisp:1040-1071`) extended to pass
  the index argument(s) through.

## 2. Public instance fields — **FIXED in generator version 27**

> **Update (2026-07-03):** fixed. See `RELEASES.md`'s 2.27.0 entry and
> `doc/generator-design-notes.md`'s "Public Instance Fields and Multi-Type-Argument Generic
> Methods (Version 27)" section. The description below is left as-is for historical context.

Public instance fields — silently dropped, no codegen path at all

`public-instance-field-p` (`assembly-package-generator.lisp:171-174`) is defined but
never invoked anywhere in the file. There is no codegen branch for public instance
fields at all — they're captured in metadata but generate nothing, with no comment
marking them as skipped (unlike dirty overloads, which at least leave a comment).

* **Priority: High** — this is a silent, invisible gap: simple POD-style structs/classes
  with public fields lose those members with zero trace in the generated output.
* **Difficulty: Low** — the predicate and field data already exist; this just needs a
  codegen branch mirroring the existing get/set-property pattern
  (`assembly-package-generator.lisp:1040-1071`).

## 3. Generic methods with arity ≥ 2 — **FIXED in generator version 27**

> **Update (2026-07-03):** fixed. See `RELEASES.md`'s 2.27.0 entry and
> `doc/generator-design-notes.md`'s "Public Instance Fields and Multi-Type-Argument Generic
> Methods (Version 27)" section, which also covers the same-name/different-arity case (e.g.
> `Enumerable.Aggregate`) that generalizing arity naively would have gotten wrong. The description
> below is left as-is for historical context.

Generic methods with arity ≥ 2 — excludes most of LINQ

`clean-method-p`/`simple-method-p` (`assembly-package-generator.lisp:204,230`) hard-restrict
generic methods to arity ≤ 1 (`(or (not is-generic) (eql arity 1))`). Any method with 2+
generic type parameters is classified "dirty" and skipped with a comment. This silently
excludes much of LINQ: `Select<TSource,TResult>`, `Join`, `GroupBy`,
`ToDictionary<TSource,TKey,TValue>`, and similar shapes are all arity ≥ 2.

* **Priority: High** — LINQ-style multi-type-param generics are extremely common in
  modern .NET APIs; this is likely the single biggest functional gap for anyone wrapping
  collection/query-style assemblies.
* **Difficulty: High** — needs the `dotnet:invoke-generic`/`dotnet:static-generic`-style
  dispatch (currently arity-1-only, `assembly-package-generator.lisp:181-215,559-571,699-741`)
  generalized to N type arguments, plus working out how that interacts with the
  overload-dispatch machinery.

## 4. Events (`add_`/`remove_`) — filtered out before metadata is even emitted

Events are excluded at the reflection layer itself: the `IsSpecialName` filter
(`AssemblyToLispy.cs:143-145`) drops them before they ever reach the metadata file, so
the Lisp side never even sees that they exist. A design sketch exists
(`doc/lispy-csharp-standard-library.md:508-514`, proposing `add-handler`/`remove-handler`
functions) but nothing is implemented.

* **Priority: High** — events are common in UI/async-notification-style APIs.
* **Difficulty: Medium-High** — this is a new metadata category end-to-end: reflection
  capture → schema addition → codegen → deciding on a Lisp-idiomatic handler-add/remove
  convention (closures as handlers, removal semantics, etc.).

## 5. Type-level metadata captured but never consumed

`AssemblyToLispy.cs` already captures superclass, interface list, abstract/sealed/other
flags, and class-level XML doc summary for every type — but
`assembly-package-generator.lisp` never reads any of it (grep confirms only `:kind` is
consulted, at lines 765 and 869, solely to detect `:struct`/`:enum`). None of this
surfaces in generated output at all.

* **Priority: Medium** — pure documentation/discoverability value, not functional — but
  cheap enough that it's worth bundling in with the high-priority quick wins above.
* **Difficulty: Low** — the data already flows through the full pipeline; this is purely
  a matter of emitting it as header comments in each generated `.lisp` file.

## 6. Enums treated as a deliberate feature (currently accidental)

Enum values only work today by accident: enum members are reflected as ordinary
`IsLiteral` static fields, so they happen to fall through the existing literal-field
`defconstant` path (`assembly-package-generator.lisp:990-997`). There is no `:kind :enum`
-specific codegen branch, no `[Flags]`-aware bit-oring helpers, and no
`ToString`/`Parse`/`TryParse` convenience wrappers (all noted as open thoughts in
`doc/lispy-csharp-standard-library.md:452-458`).

* **Priority: Medium** — enums are ubiquitous, but the accidental path already produces
  usable constants for the common non-flags case, softening the impact.
* **Difficulty: Medium** — flags-aware helpers and deliberate per-enum-type grouping/doc
  comments are a moderate, well-scoped addition.

## 7. Operator overload coverage is incomplete — DONE (2026-07-04)

`GetCleanMethodName` (`AssemblyToLispy.cs`) now also maps `%` (Modulus), `&`, `|`, `^`, `<<`,
`>>`, `>>>` (unsigned right shift), `~` (OnesComplement), and C# 11's checked-operator variants
(suffixed `!`, e.g. `+!` for `op_CheckedAddition`). No generator-side codegen changes were
needed — a mapped operator's `:name` is already its clean symbol by the time
`assembly-package-generator.lisp`'s `"op_"`-prefix filters run, so it flows through the existing
clean-method/Master Wrapper pipeline exactly like the previously-mapped operators. See
`doc/generator-design-notes.md`'s Version 30 section and `PLAN.md`'s corresponding entry.

## 8. Generic class name mangling via backticks (already tracked in `PLAN.md`)

Already flagged in `PLAN.md:20-25` as an "ugly workaround": users must know a class's
generic arity to guess its generated package name, since backticks (C#'s generic-arity
marker) can't appear directly in Lisp package names.

* **Priority: Medium** — UX friction on every generic class used (`Dictionary<K,V>`,
  `List<T>`, etc.).
* **Difficulty: Medium** — a naming-scheme redesign with backward-compatibility and
  collision implications across all currently-generated packages.

## 9. Tuple element names lost

`TupleElementNamesAttribute` is never read. C# 7+ named tuples
(`(int x, string y)`) print as generic `System.ValueTuple\`2[...]` with element names
lost entirely.

* **Priority: Medium** — named tuple returns are common in modern C# method signatures.
* **Difficulty: Medium** — needs attribute parsing plus tuple-aware accessor naming in
  the generated wrapper.

## 10. Records — no detection or idiomatic handling

No heuristic distinguishes records from ordinary classes/structs. Positional records,
`with`-expression non-destructive updates, and C# 9 `init`-only property accessors
(distinct from ordinary `set`) are all indistinguishable from plain classes with mutable
setters today. Only a design sketch exists
(`doc/lispy-csharp-standard-library.md:426-432`, proposing a `with-record-update` macro).

* **Priority: Medium** — records are idiomatic and increasingly common in newer C# APIs;
  softened by the fact that ordinary class-style access already "works" mechanically,
  just not idiomatically.
* **Difficulty: Medium** — detection itself is easy (heuristic on compiler-generated
  `EqualityContract`/`<Clone>$` members); a genuinely Lispy `with`-update macro is more
  design work.

## 11. Custom/general attributes not surfaced

Explicitly deferred in `doc/assembly-to-lispy.md`'s "Phase 4" section. Only a handful of
special-purpose attributes are inspected today (`CompilerGeneratedAttribute`,
`ExtensionAttribute`, `IsReadOnlyAttribute`, `ScopedRefAttribute`, `ParamArrayAttribute`),
all purely for internal filtering — none surfaced to Lisp. `[Obsolete]`, `[Flags]`, and
general custom attributes are invisible to generated output.
`doc/lispy-csharp-standard-library.md:493-501` raises this as an open, unresolved
question ("Do I even care about attributes...?").

* **Priority: Medium** — `[Obsolete]` surfaced as a doc warning has real practical value;
  general attribute reflection is more of a nice-to-have.
* **Difficulty: Medium** — a CIL custom-attribute-table walk plus a scoping decision
  about which attributes actually matter.

## 12. Nullable reference type annotations (`string?` vs `string`)

`NullableAttribute`/`NullableContextAttribute` are never read, so `string` and `string?`
are indistinguishable in generated metadata/docs.

* **Priority: Medium** — widespread in modern C# codebases; informational value for
  callers deciding whether to null-check.
* **Difficulty: Medium** — the nullable-attribute encoding is notoriously fiddly
  (context attribute plus a per-nullable-slot byte array to interpret correctly).

## 13. Method visibility/virtuality metadata

Methods carry no `:public`/`:protected` flag (inconsistent — constructors and fields
already have this), and there's no `IsVirtual`/`IsAbstract`/`IsFinal`/override detection
for methods at all.

* **Priority: Low-Medium** — mostly a completeness/documentation gap; the existing
  visibility filter already excludes non-public methods, so protected-surfacing matters
  less here than it does for constructors/fields.
* **Difficulty: Low** — straightforward `MethodInfo` property reads, mirroring the
  existing constructor/field pattern.

## 14. Interfaces/delegates as first-class generation targets

Interface and delegate members flow through the identical class-generation pipeline
today, with no implementer-wiring (can't easily target "anything implementing
`IFoo`") and no delegate-specific handling (no way to pass a Lisp closure where a C#
delegate/`Func`/`Action` is expected). See open notes in
`doc/lispy-csharp-standard-library.md:516-519`.

* **Priority: Low-Medium** — interfaces are often consumable via a concrete
  implementation that's already covered; delegate-passing needs broader DotCL interop
  work, not just generator changes.
* **Difficulty: High** — delegate marshaling is fundamentally a runtime-interop feature,
  not purely a codegen concern.

## 15. Explicit interface implementations

The compiler emits these as private methods, so they're silently dropped by the
visibility filter (`AssemblyToLispy.cs:143`). Never mentioned anywhere in code or docs.

* **Priority: Low** — uncommon in typical consumer-facing APIs, though it does appear in
  some BCL interfaces (e.g. `IEnumerable.GetEnumerator`'s explicit forms).
* **Difficulty: Medium** — needs interface-qualified name resolution to expose these
  sensibly (they can't just use the plain method name, which may collide).

## 16. Generic constraints and variance

Generic constraints (`where T : ...`) are explicitly deferred in
`doc/assembly-to-lispy.md`'s "Phase 4" section; generic parameter variance (`in`/`out`)
is not mentioned anywhere in code or docs.

* **Priority: Low** — purely informational value, since Lisp's dynamic typing means
  neither is enforced at the call site regardless.
* **Difficulty: Low-Medium** — straightforward reflection calls
  (`GetGenericParameterConstraints`, `GenericParameterAttributes`); mostly a schema/doc
  addition.

## 17. Async methods (`Task`/`Task<T>`/`ValueTask`)

No detection or unwrapping of async return types. Using this properly requires a policy
decision first — block-and-unwrap synchronously vs. exposing some future/promise-like
Lisp construct.

* **Priority: Low-Medium** — async is common in modern .NET APIs, but the impact depends
  heavily on which assemblies users actually target; many commonly-wrapped BCL surfaces
  are still sync.
* **Difficulty: High** — this is a semantic design question first, mechanical reflection
  second; needs a DotCL-side async story before the generator can do anything sensible.

## 18. Ref structs (`Span<T>`, etc.)

`Type.IsByRefLike` is never checked. Independently, this is already documented as
**currently impossible** at the DotCL interop layer itself — ref-like types can't be
boxed/wrapped by the runtime today (`doc/dotnet-dotcl-interop.md:288-289`).

* **Priority: Low** — blocked upstream regardless of any generator-side change.
* **Difficulty: High** — blocked on DotCL runtime work, not something the generator can
  fix on its own.

## 19. Static abstract interface members (C# 11)

No specific handling exists; these would flow through the ordinary method pipeline today
with untested/unknown results.

* **Priority: Low** — a niche feature, mostly used for generic math interfaces.
* **Difficulty: Medium**.

## 20. Function pointers and unsafe pointer types

`Type.IsFunctionPointer` is never checked, and `Type.IsPointer` is used only internally
for XML-doc-key formatting (`AssemblyToLispy.cs:887-889`), never exposed in output.

* **Priority: Low** — rare outside low-level interop code.
* **Difficulty: High** — fundamentally unsafe/unmanaged marshaling; likely out of scope
  for a Lisp-safety-oriented wrapper generator regardless of effort spent.

## 21. Nested-type parent/child linkage

Nested types already generate as independent flattened packages (the v19 `+`-flattening,
`assembly-package-generator.lisp:68-88`), but with no comment or metadata linking a
nested type's package back to its enclosing type.

* **Priority: Low** — cosmetic/discoverability only.
* **Difficulty: Low** — the data is already available via the `+`-separated
  fully-qualified name; just needs a derived doc comment.

## 22. Partial methods / finalizers

No special-casing exists. Partial methods without bodies don't survive to compiled
metadata anyway (largely moot). Finalizers pass through as an ordinary `Finalize` method
with no semantic marker distinguishing them.

* **Priority: Low** — finalizers are rarely something you'd want to invoke directly from
  Lisp.
* **Difficulty: Low** — finalizer exclusion (if desired) is a simple name-based check;
  partial methods require no work at all.

---

## Incidental findings (not gaps — cleanup notes)

A few pieces of dead or vestigial code turned up while exploring that are worth a look
independent of the capability gaps above:

* **`public-instance-field-p` is dead code.** Defined at
  `assembly-package-generator.lisp:171-174` but never called anywhere — this coincides
  directly with item 2 above (public instance fields having no codegen path); once that
  gap is fixed, this predicate presumably becomes the entry point.
* **`generic-type-p` never fires today.** Defined at
  `assembly-package-generator.lisp:177-179`, it tests for a literal `!` character in a
  type-name string — but `GetFriendlyTypeName` (`AssemblyToLispy.cs:733-740`) never
  emits `!` in current output. This appears to be vestigial from an earlier metadata
  shape. Confirmed empirically: in
  `cspackages-test/system-collections-generic-dictionary-2.lisp`, a
  `Dictionary<TKey,TValue>` method using the class's own generic parameters (e.g.
  `Add(TKey key, TValue value)`) is already treated as an ordinary "clean" method and
  generated normally — this predicate never gates it.
* **Minor doc/schema mismatch.** `doc/assembly-to-lispy.md`'s "Details" section (lines
  29-41) lists "Generic Parameters" as something the tool cares about, but the actual
  schema section never defines a `:generic-parameters` key for type-level generics —
  only method-level generic arity and the type-level `:generic-type`/
  `:generic-type-definition` flags actually exist in the emitted schema.

---

## Relationship to `PLAN.md`

Several related items are already tracked in `PLAN.md` and are intentionally not
duplicated here in full — see that file for ownership and status:

* Generic class name mangling via backticks (`PLAN.md:20-25`) — cross-referenced above
  as item 8.
* Dirty-overload (`ref`/`out`) handling with `-ref` suffix naming and
  out-parameter-to-multiple-values mapping (`PLAN.md:39-40`).
* Casting/boxing mutator parameters to the correct type (`PLAN.md:41-43`).
* Adding return/parameter-type documentation comments (`PLAN.md:44-45`).
* Naming convention changes (`IsSomething` → `something?`, `ToSomething` → `->something`,
  `GetSomething` → TBD) (`PLAN.md:46-50`).
* Variable-arity operator overloads (`PLAN.md:51-52`).
