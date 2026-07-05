# DotCL Package Generator Release Notes

* Author: Douglas P. Fields, Jr. - symbolics@lisp.engineer
* Copyright 2026 Douglas P. Fields, Jr.

This file tracks CLI-level and tool-behavior changes to `dotcl-packagegen`, keyed by the
`VERSION` in `Makefile`/`dotcl-packagegen.asd`. For the code-generation template's own version
history (the integer `*generator-version*` embedded in every emitted `.lisp` file), see
`assembly-package-generator.lisp`'s docstring and `doc/generator-design-notes.md`'s "Generator
Version History" section instead — those two numbers are independent and do not always move
together.

## 2.32.0 — 2026-07-04

**Added support for C# events (`add_X`/`remove_X`).**

* Events were previously invisible end-to-end: filtered out at reflection time by the same
  `IsSpecialName` check that hides property/indexer accessors, so the Lisp side never even knew
  they existed (`doc/claude-suggested-improvements-20260703.md`'s item 4). `AssemblyToLispy.cs`
  now reflects instance events into a new `:events` metadata key (`FormatEventPlist`, mirroring
  `FormatPropertyPlist`) — static events (no receiver object) are explicitly excluded, since
  DotCL's `dotnet:add-event`/`dotnet:remove-event` have no verified calling convention for one
  (tracked as a `PLAN.md` follow-up).
* Each instance event `Foo` generates an `add-foo`/`remove-foo` function pair, both taking
  `(obj! handler)`, calling DotCL's existing `dotnet:add-event`/`dotnet:remove-event` — no DotCL
  runtime changes were needed, only reflection and codegen in this repo. Removal is by Lisp
  object identity: the same `handler` object originally passed to `add-foo` must be passed back
  to `remove-foo`; the generated `remove-foo` docstring calls this out explicitly.
* New naming-collision handling: since `add-X`/`remove-X` are synthesized compound names (not a
  1:1 mapping of one C# identifier the way every other member category's name is), a class can
  have an unrelated member that collides with a synthesized event name (e.g. a `Click` event
  alongside an `AddClick()` method). `event-wrapper-names` escalates through three tiers
  (`add-click`/`remove-click` → `add-click-event`/`remove-click-event` →
  `add-click!`/`remove-click!`, the last collision-proof by construction since C# cannot emit
  `!`), fed by a new shared helper (`class-member-names-excluding-events`) so
  `compute-package-exports-and-shadows` and `generate-class-file` can never disagree about an
  event's actual wrapper names.
* See `doc/generator-design-notes.md`'s "Events (Version 32)" section for the full design
  writeup, `doc/assembly-to-lispy.md`'s `:events` schema addition, and `FEATURES.md`'s new
  "Events" section.
* `*generator-version*` bumped 31 → 32.

## 2.30.0 — 2026-07-04

**Completed operator overload mapping coverage.**

* `GetCleanMethodName` now maps the 8 remaining standard C# overloadable operators previously
  left as raw `op_Xxx` names (`op_Modulus` → `%`, `op_BitwiseAnd` → `&`, `op_BitwiseOr` → `|`,
  `op_ExclusiveOr` → `^`, `op_LeftShift` → `<<`, `op_RightShift` → `>>`,
  `op_UnsignedRightShift` → `>>>`, `op_OnesComplement` → `~`), plus C# 11's checked-operator
  variants, suffixed `!` to coexist alongside their unchecked counterparts on the same type
  (`op_CheckedAddition` → `+!`, `op_CheckedSubtraction` → `-!`, `op_CheckedMultiply` → `*!`,
  `op_CheckedDivision` → `/!`, `op_CheckedUnaryNegation` → `-!`, `op_CheckedExplicit` →
  `explicit-cast!`).
* No generation-logic changes were needed: a mapped operator's `:name` is already its clean Lisp
  symbol by the time the generator's `"op_"`-prefix filters run, so any newly-mapped operator
  flows through the existing clean-method/Master Wrapper pipeline exactly like previously-mapped
  operators (`+`, `-`, `=`, `implicit-cast`, etc.) already did. See
  `doc/generator-design-notes.md`'s Version 30 section for the full investigation.
* Added operator-codegen test coverage (previously absent — only metadata `:mangled-name`
  extraction was tested): `AssemblyToLispyTestTarget/EdgeCases.cs`'s non-generic `EdgeCaseStruct`
  gained a newly-mapped binary operator (`operator %`) and a unary operator sharing another
  operator's symbol, and `package-generator-tests.lisp` gained a synthetic-class-plist test
  asserting the generated wrapper functions and their `:mangled-name`-based invocations.
* `*generator-version*` bumped 29 → 30.

## 2.29.0 — 2026-07-04

**Struct-boxing warning corrected; shared-mutable-constant hazard documented.**
Documentation-only fix — no dispatch/codegen behavior changed.

* The comment previously emitted above every struct/enum instance property/field
  mutator claimed `setf` "may only mutate a boxed copy, leaving the original unchanged."
  A live REPL check against `dotcl-dungeonslime` disproved this: mutation succeeds, in
  place, on the exact boxed `.NET` object the receiver refers to, regardless of how the
  new value is produced. The comment now describes the real caveat instead: if that
  boxed object is aliased elsewhere, mutating it through any one alias mutates it
  everywhere.
* The same investigation surfaced a more serious finding: a `--constant-properties`-
  selected (or true C# literal/`const`) `defconstant` of a mutable struct type (e.g.
  `Vector2.Zero`, `Color.White` — this tool's own flagship `--constant-properties`
  examples) is a *single* boxed instance, cached once and shared by every reference to
  that constant for the life of the program, since `defconstant`'s value form only ever
  runs once. Mutating it through any alias silently corrupts the "constant" everywhere,
  permanently. A new warning comment is now emitted above any such `defconstant` whose
  type isn't a recognized safe, immutable primitive.
* No fallback to `define-symbol-macro` was made for struct-typed constants — that would
  eliminate the hazard but at an unacceptable performance cost for exactly the
  high-frequency constants (`Vector2.Zero`, etc.) people use `--constant-properties` for.
  A real fix (a safe way to clone/copy a boxed struct) is tracked as a prioritized
  follow-up in `PLAN.md`, not delivered in this release.

See `doc/generator-design-notes.md`'s "Struct-Boxing Warnings Corrected;
Shared-Mutable-Constant Hazard Documented (Version 29)" section for the full incident
writeup, including the REPL transcript that surfaced this.

## 2.28.0 — 2026-07-03

**Generic-arity two-tier dispatch:** replaces the `2.27.0` arity-suffixed export scheme
(`aggregate-arity-1`, `aggregate-arity-2`, `aggregate-arity-3`, ...) with a dispatcher mirroring the
existing `*` static/instance convention, so a generic method name's public surface stays at most two
names.

* A method name whose overloads span more than one generic arity now exports at most `base-name`
  and `base-name<>` — never the individual per-arity names, which still exist but are now internal,
  unexported implementation details.
* `base-name<>` (or bare `base-name`, when every overload of that name is generic, e.g.
  `System.Linq.Enumerable.Aggregate`) takes the type argument(s) as its first parameter: pass a
  single .NET type for the single-type-argument overload, or a `cl:list` of types to select the
  overload taking that many type arguments — the count is resolved at runtime.
* When a non-generic overload of a name coexists with generic ones (e.g. a hypothetical `Foo` with
  both a plain overload and `Foo<T>`), passing an empty list (or `nil`) as the type argument to
  `foo<>` calls the non-generic `foo` directly, so callers don't need to special-case zero type
  arguments into a differently-named function.

See `doc/generator-design-notes.md`'s "Generic-Arity Two-Tier Dispatch (Version 28)" section for
full implementation details.

## 2.27.0 — 2026-07-03

**Public instance fields and multi-type-argument generic methods:** the two remaining
highest-priority capability gaps identified in
`doc/claude-suggested-improvements-20260703.md` are now supported.

* **Public instance fields** (e.g. a public mutable field on a plain data-holder class) were
  silently dropped entirely — no getter, no setter, no comment. They now generate a getter, and
  (unless the field is C#'s `readonly`) a setter. Since a field has no `get_Foo`/`set_Foo` accessor
  method the way a property does, the getter relies on `dotnet:invoke`'s built-in field-read
  support (passing the bare field name), and the setter uses the `setf`-expansion of
  `dotnet:invoke` itself — the idiomatic DotCL way to write a field or property directly (see
  `doc/dotnet-dotcl-interop.md`) — since `dotnet:invoke` has no field-write equivalent.
* **Generic methods with more than one type argument** (e.g. LINQ's `Select<TSource,TResult>`,
  `Join`, `ToDictionary<TSource,TKey,TResult>`) were previously excluded entirely — the generator
  only supported exactly one type argument. Every such method now generates, taking one Lisp
  parameter per type argument (`type-1`, `type-2`, ... — arity 1 keeps the legacy bare `type` name,
  so nothing about existing arity-1 generated code or callers changes). The one caveat: when the
  *same* C# method name is overloaded across *different* generic arities (e.g.
  `System.Linq.Enumerable.Aggregate`, overloaded at arity 1, 2, and 3), one Lisp function's lambda
  list can't flex between different numbers of type-argument parameters, so each arity now
  generates its own arity-suffixed function (`aggregate-arity-1`, `aggregate-arity-2`,
  `aggregate-arity-3`) instead of being incorrectly merged into one. The overwhelmingly common case
  — a non-generic method, or a generic method whose every overload shares the same arity (e.g.
  `Select`) — is entirely unaffected and keeps its plain name.

See `doc/generator-design-notes.md`'s "Public Instance Fields and Multi-Type-Argument Generic
Methods (Version 27)" section for full implementation details.

## 2.26.0 — 2026-07-03

**Indexer fix:** C# indexers (`this[...]`, e.g. `Dictionary<TKey,TValue>`'s `Item`) generated a
getter/setter that took only the receiver (`obj!`) with no index/key argument at all — the
metadata reflection layer (`AssemblyToLispy.cs`) never captured a property's own index parameters,
so the generated wrapper could never actually retrieve or store a value at runtime. Index
parameters are now captured via `PropertyInfo.GetIndexParameters()` the same way a method's
parameters are captured, and threaded through to `get_Item`/`set_Item` positionally by the
generator (index parameter(s) first, then the new value on the setter, matching C#'s own parameter
order). An indexer overloaded across multiple index-parameter signatures (e.g. `this[int]` and
`this[string]` on the same class) is not yet supported; it is now documented in a comment (the same
treatment as a dirty method/constructor overload) instead of the previous behavior of silently
generating a broken wrapper for the last-seen signature.

## 2.25.0 — 2026-07-03

**Receiver-parameter collision fix:** the hardcoded receiver parameter for instance methods and
properties was named `obj` in generated code, which collided with a C# method's own parameter of
the same name (e.g. `System.Object.Equals(object obj)`), producing an invalid Lisp lambda list
with a duplicate `obj` binding. The receiver is now named `obj!`, which `map-param-name` (the only
function that maps a C# parameter name into generated Lisp code) can never produce for an actual
parameter, guaranteeing no future collision regardless of the C# parameter's name.

## 2.24.0 — 2026-07-03

**Overload consolidation:** overloaded methods and constructors now generate at most one or two
Lisp functions total, instead of one dispatcher plus one type-suffixed direct-call function per
C# overload. The type-suffixed functions (e.g. `contains-vector-2`,
`get-ambiguous-time-offsets-date-time`, `new-single-single`) were pure redundancy — the existing
Master Wrapper `cond` dispatch already picks the exact right overload from argument types and
`supplied-p` flags — so they're no longer generated or exported at all:

* A method with 2+ clean overloads now emits just its Master Wrapper (`name`, plus `name*` only
  when the same name is overloaded as both instance and static — unchanged from before).
* Constructors gained a real Master Wrapper of their own (previously they only got a bare
  `(apply #'dotnet:new ...)` passthrough relying on DotCL's own runtime resolution, plus the
  type-suffixed functions). Every class now emits exactly one `new`, regardless of how many
  constructor overloads it has.
* To keep the per-overload documentation the deleted functions used to carry, every Master
  Wrapper's docstring now lists every overload it dispatches to — its human-readable signature
  plus that overload's own XML-doc Summary/Returns/Parameters text — so the full set of available
  overloads and their documentation is still visible from the one remaining function.

See `doc/generator-design-notes.md`'s "Overload Consolidation (Version 24)" section for the
implementation details.

## 2.23.0 — 2026-07-03

**Self-containment fix:** generated output no longer depends on this tool's own
`monoutils`/`utils` packages at runtime — a downstream project loading a generated batch had no
way to get those, so the "entirely self-contained" goal for generated packages wasn't actually
met. `monoutils:dotnet-p`/`boxed-dotnet-p` turned out to be backed by a native primitive
(`MonoUtilsRegistrar.Initialize()` in this tool's own `MonoUtils.cs`) unavailable to any host
that doesn't happen to load this exact assembly — rather than ship that dependency, the two
emitted call sites were swapped for stock DotCL 0.1.15 primitives that do the same job:

* The per-class `<type>` constant now calls `dotnet:resolve-type` directly instead of
  `monoutils:get-type` (which only ever wrapped that same call for a string argument, the only
  way generated code invoked it) — consistent with the CLOS-registration block a few lines
  later, which already called `dotnet:resolve-type` directly.
* The parameter-type-check fallback for non-primitive C# types now checks
  `(dotnet:object-type arg)` (truthy only for a wrapped `.NET` object, `NIL` otherwise) instead
  of `monoutils:dotnet-p`.
* The one genuinely custom piece of runtime logic generated code still needs — the
  `csharp-overload-not-found` condition raised by master-overload dispatchers — is now emitted
  as `csharp-assembly-utils:csharp-overload-not-found` instead of
  `utils:csharp-overload-not-found`, and a single-pass invocation now also writes
  `csharp-assembly-utils.lisp` into `--out-dir`, holding that condition. Its `defpackage` form is
  written into `packages.lisp` instead (ahead of every class's own `defpackage`), following this
  tool's own `packages.lisp` convention rather than making an exception for it.
* Both new pieces of generated content — the `csharp-assembly-utils` `defpackage` form and the
  condition definition itself — are copied verbatim from two new real, hand-written,
  independently loadable/`check_parens.py`-able source files
  (`csharp-assembly-utils-package.template.lisp`, `csharp-assembly-utils.template.lisp`),
  read with `uiop:read-file-string` (`generate-batch-packages-file` /
  new `generate-batch-utils-file`), rather than reconstructed via `format` calls — so the
  known-good source is what actually ships. Both templates are copied next to the built
  executable via `dotcl-packagegen.csproj`'s existing `<Content>`-copy pattern (the same one used
  for `dotcl-packagegen.asd`'s own version introspection), and their paths are passed down from
  `Program.cs` as two new scalar arguments on the `RUN-ASSEMBLY-PACKAGE-GENERATOR-BATCH` call.
* `csharp-assembly-packages.asd`'s `:components` gained a `csharp-assembly-utils` `:file`
  (`:depends-on ("packages")`, since its `in-package` form needs that package to already exist),
  and every per-class `:file`'s `:depends-on` became `("packages" "csharp-assembly-utils")`.
* `*generator-version*` bumped `22` → `23`, since this changes the emitted content of every
  class file, not just adding a new one; see `doc/generator-design-notes.md`'s "Self-Contained
  Runtime Support (Version 23)" section.
* `doc/package-generator-dependencies.md` corrected: its stale `dotcl-dungeonslime` file links
  now point at this repo's own `utils.lisp`/`monoutils.lisp`, and its "Dependencies of the
  Generated Packages" section was rewritten to reflect that `monoutils`/`utils` are no longer
  generated-output dependencies at all — only stock `dotnet:*` calls plus
  `csharp-assembly-utils:csharp-overload-not-found`.

## 2.22.0 — 2026-07-03

**New feature:** class `.lisp` files no longer each carry their own `(cl:defpackage ...)` form;
a single-pass invocation now consolidates every requested class's `defpackage` into one
`packages.lisp` file in `--out-dir`, following this codebase's own convention of a single
project-wide `packages.lisp`. Class files now only `(cl:in-package :<pkg-name>)`, so
`packages.lisp` must be loaded first — `csharp-assembly-packages.asd`'s component graph was
updated to enforce that.

* New Lisp function `generate-batch-packages-file` (`assembly-package-generator.lisp`), modeled
  on the existing `generate-batch-asd-file` (accumulate across the whole batch, write once),
  called from `generate-assembly-packages-batch` before the per-class `generate-class-file` loop
  runs. Each class's `defpackage` is preceded by a 3-line comment block naming its source `.lisp`
  file, its C# class, and its constant properties (`(none)` when empty), with a blank line
  between each package definition.
* The export/shadow-symbol computation `generate-class-file` used to build its (now-removed)
  inline `defpackage` was extracted into a new shared function,
  `compute-package-exports-and-shadows` — same logic, no behavior change, now the single source
  of truth used by both `generate-class-file` (indirectly, still needed for its `in-package`
  form) and `generate-batch-packages-file`.
* `generate-batch-asd-file`'s `:components` now lists `(:file "packages")` first, and every
  per-class `(:file "...")` entry gained `:depends-on ("packages")`, so ASDF's dependency graph
  — not just component-list order — enforces that `packages.lisp` loads before any class file
  that needs its package to already exist.
* `*generator-version*` bumped `21` → `22`, since this changes the shape of every generated
  `.lisp` package file (no more inline `defpackage`) as well as introducing a new generated file;
  see `doc/generator-design-notes.md`'s "Consolidated packages.lisp (Version 22)" section.
* `package-generator-tests.lisp`'s end-to-end `.asd`-generation test updated to expect `packages`
  as the first `:file` component ahead of the requested classes.

## 2.21.0 — 2026-07-03

**New feature:** a single-pass invocation now also emits `csharp-assembly-packages.asd` into
`--out-dir` alongside the generated `.lisp` package files, so the whole batch can be loaded in
one shot with `(asdf:load-system "csharp-assembly-packages")` instead of hand-writing a system
definition or a pile of `(load ...)` calls.

* New Lisp function `generate-batch-asd-file` (`assembly-package-generator.lisp`), called from
  `generate-assembly-packages-batch` once every requested class's `.lisp` file has been written.
  `:components` lists one `(:file "<pkg-name>")` per generated class, in the same order the
  classes were requested on the command line, using the same `type-fq-name-to-pkg-name` mapping
  `generate-class-file` uses for the file's actual name — so the two are guaranteed to agree.
* `:version` in the generated `.asd` is the short, 2-digit `*generator-version*` (e.g. `"21"`).
  `:long-description` additionally records the full `dotcl-packagegen` CLI/application version
  (e.g. `"2.21.0"`), the generation timestamp, and, per assembly, each requested class's
  fully-qualified name, assigned package name, and any constant-properties.
* Each manifest entry built by `Program.cs` now carries an explicit `:assembly-name` (the
  original `.dll` filename) so the Lisp side doesn't need to recover it by string-parsing the
  metadata file's path.
* `utils.lisp` gained `get-system-version`, a non-printing counterpart to the existing
  `print-system-version` (used by `--version`) that returns `dotcl-packagegen.asd`'s own
  `:version` string via the same `asdf:load-asd` + `asdf:component-version` introspection, so
  `Program.cs` can pass it through as the batch generator's `cli-version` argument.
* No `:depends-on` is emitted yet, even though every generated package's runtime code needs
  `monoutils`/`utils` (provided by this repo's own `dotcl-packagegen` system) — that's deferred
  to a later change.
* `*generator-version*` bumped `20` → `21`, since this release changes the single-pass
  generator's overall output (a new `csharp-assembly-packages.asd` file), even though it doesn't
  change the shape of any individual generated `.lisp` package file; see
  `doc/generator-design-notes.md`'s "Batch ASDF System Generation (Version 21)" section.
* `Makefile`'s `test` target's `check_parens.py` invocation now also globs `*.asd` in
  `cspackages-test/`, so the newly-generated system definition gets the same syntax check as
  every other generated file.

## 2.20.0 — 2026-07-03

**Bug fix:** open-generic C# type names (.NET's backtick arity suffix, e.g.
`System.Collections.Generic.Dictionary\`2` or `` System.Action`4 ``) previously leaked a raw
backtick into the generated Lisp package name and filename — and unlike the `+` case fixed in
`2.19.0`, this wasn't just cosmetic: a bare backtick is the Lisp reader's backquote macro
character, so `(cl:defpackage :system-collections-generic-dictionary\`2 ...)` didn't read back
as intended at all. The reader stopped the symbol token at the backtick and started a new
backquote form there, silently corrupting the whole `defpackage` form (wrong package name, plus
a spurious `(quote 2)` in place of `(:use :cl)`) rather than raising any error. This was
discovered while adding `Dictionary\`2` and its nested `KeyCollection`/`ValueCollection` to
`Makefile`'s test packages — no prior test had fed an open-generic type all the way through
`generate-class-file`.

* `type-fq-name-to-pkg-name` (`assembly-package-generator.lisp`, added in `2.19.0`) now also
  flattens `` ` `` to `-`, the same as `+`. Unlike `+`, a backtick has no legitimate use in any
  member/operator name in this codebase (only a type's own `Name`/`FullName` ever carries one),
  so this needed no special-casing to avoid corrupting an intentional operator symbol.
* `*generator-version*` bumped `19` → `20`; see `doc/generator-design-notes.md`'s "Generic Type
  Backtick Sanitization (Version 20)" section for details.
* `Makefile`'s `test` target now also generates
  `System.Collections.Generic.Dictionary\`2`/`KeyCollection`/`ValueCollection` (from
  `System.Collections.dll`) and `System.TimeZoneInfo`/`System.TimeZoneInfo+AdjustmentRule`
  (from `System.Runtime.dll`), giving this bug — and the `2.19.0` nested-type fix — real,
  checked-in regression coverage via `cspackages-test/`.

## 2.19.0 — 2026-07-03

**Bug fix:** nested C# type names (CIL's `+` separator, e.g.
`Microsoft.Xna.Framework.Graphics.SpriteFont+Glyph` for `Glyph` nested inside `SpriteFont`)
previously leaked a literal `+` — plus a spurious extra hyphen — into the generated Lisp
package name and output filename:

```
microsoft-xna-framework-graphics-sprite-font+-glyph.lisp   ; before (wrong)
microsoft-xna-framework-graphics-sprite-font-glyph.lisp    ; after (fixed)
```

* A new `type-fq-name-to-pkg-name` helper (`assembly-package-generator.lisp`) flattens `+` to
  `-`, the same convention already used for namespace `.` separators, when deriving a type's
  Lisp package/file name from its `:fully-qualified-name` — and no longer inserts a doubled
  hyphen at the nesting boundary. It deliberately does *not* change `camel-to-kebab` itself,
  which is also applied to already-mapped member/operator names (C#'s `+` operator is mapped to
  the literal one-character Lisp name `"+"` upstream, which a `+`-aware `camel-to-kebab` would
  otherwise corrupt). This affects only the generated Lisp package/file name; the underlying
  `:fully-qualified-name` metadata field and every reflection-facing use of it
  (`monoutils:get-type`, `dotnet:resolve-type`, `dotnet:the` type hints, `<type-str>`) are
  unchanged and still use the literal CIL `+`-form required to resolve the live .NET type.
  `--class` arguments for nested types must still use the `+`-separated CIL name (e.g.
  `--class Some.Outer+Inner`) — only the *output* naming changed.
* `*generator-version*` bumped `18` → `19` (this changes generated-file naming behavior); see
  `doc/generator-design-notes.md`'s "Nested Type Package Naming (Version 19)" section for
  details.
* Added end-to-end test coverage for three levels of C# type nesting: a new
  `NestingContainer`/`NestedLevel2`/`NestedLevel3` fixture in
  `AssemblyToLispyTestTarget/EdgeCases.cs`, assertions in `tests/synthetic-target.test.lisp`,
  and direct `type-fq-name-to-pkg-name` unit tests (1/2/3 levels of nesting), plus a regression
  test confirming `camel-to-kebab` leaves a bare `"+"` operator name untouched, in
  `package-generator-tests.lisp`.

## 2.18.0 — 2026-07-03

**Breaking change:** replaced the previous two-stage CLI (`--assembly --output` to reflect
metadata, then a separate `--assembly-metadata --class --output` invocation per class) with a
single-pass mode. One invocation now takes `--out-dir` plus one or more `--assembly` groups,
each with zero or more `--class` names (each optionally with its own
`--constant-properties`), and does metadata reflection plus package generation for everything
in one process:

```sh
dotcl-packagegen --out-dir some/directory \
  --assembly path/to/Some.Assembly.dll \
    --class Some.Class1 --constant-properties "*" \
    --class Some.Class2 \
  --assembly path/to/Some.Other.Assembly.dll \
    --class Some.Other.Class3
```

* The old `--assembly` (alone), `--assembly-metadata`, and single-class `--output <dir>` flags
  no longer exist; `--out-dir` replaces `--output` for the (now sole) generation mode.
* `--class` attaches to the most recently given `--assembly`; `--constant-properties` attaches
  to the most recently given `--class`.
* An `--assembly` with no `--class` options is valid and only emits that assembly's
  `<AssemblyName>.lispy.metadata` file, generating no packages.
* Every assembly file is validated to exist, and every requested class is validated to exist in
  its assembly's reflected metadata, before any output file is written — errors are collected
  and reported together (in red) and abort the whole run with nothing written, rather than
  partially generating output.
* All `.lisp` package files (and metadata files) produced by one invocation now share a single
  creation timestamp, instead of each file recording its own timestamp a few milliseconds apart.
* Internally: `Program.cs` now performs metadata reflection for every `--assembly` before
  booting DotCL (unchanged: reflection needs no Lisp), builds a Lisp-reader-compatible manifest
  file describing all assemblies/classes/constant-properties, and calls the new Lisp entry point
  `assembly-package-generator:run-assembly-package-generator-batch`, which replaces
  `run-assembly-package-generator`/`generate-assembly-packages`. `generate-class-file` gained an
  optional shared `creation-time` parameter.
* `*generator-version*` (the emitted-file-shape version) is unchanged at 18 — this release
  changes the CLI/orchestration layer, not the shape of generated Lisp code (beyond the shared
  timestamp source).
* `Makefile`'s `test` target was rewritten to use one single-pass invocation instead of eight
  separate two-stage calls.
