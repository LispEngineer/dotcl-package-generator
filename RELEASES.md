# DotCL Package Generator Release Notes

* Author: Douglas P. Fields, Jr. - symbolics@lisp.engineer
* Copyright 2026 Douglas P. Fields, Jr.

This file tracks CLI-level and tool-behavior changes to `dotcl-packagegen`, keyed by the
`VERSION` in `Makefile`/`dotcl-packagegen.asd`. For the code-generation template's own version
history (the integer `*generator-version*` embedded in every emitted `.lisp` file), see
`apg-naming.lisp`'s `*generator-version*` docstring and `doc/generator-design-notes.md`'s "Generator
Version History" section instead — those two numbers are independent and do not always move
together.

## 2.50.3 — 2026-07-18

**`make test-runtime` expanded to real-world MonoGame, Gum, and additional BCL classes
(82 assertions, up from 36).**

* The generation step now also covers `System.DateTime` (many-arity constructor Master
  Wrapper, `-`/`=` struct operators returning a different struct type),
  `System.Text.StringBuilder` (`--defgeneric`; the many-overload `Append` Master
  Wrapper, `Chars` indexer, cross-class `csharp-generics:length` dispatch against
  `Vector2.Length()`), and — from the same real-world libraries `dotcl-dungeonslime`
  consumes, where the v48-v50 escapes were originally found downstream —
  `Microsoft.Xna.Framework.Vector2` (`--constant-properties "*" --defgeneric`; the
  documented `Normalize()` in-place boxing-mutation transcript case, `Zero` memoization
  identity, operators), `Color`/`Point`/`Rectangle` (constants, int-ctor dispatch,
  struct-taking methods like `Contains`/`Intersects`), `MathHelper`, `GameTime`,
  `Input.Keys`, Gum's `DimensionUnitType` (enum constants **plus GumCommon's own
  extension methods injected as real-world v38 coverage** — `get-is-pixel-based` on a
  memoized enum constant), `KeyCombo` (nullable-enum struct fields, `Is*`→`?` renaming,
  MonoGameGum extension-method injection), and `TextRuntime` (the exact
  all-parameters-defaulted constructor shape that motivated v48; constructed with
  `:full-instantiation nil` since full instantiation needs a live Gum/graphics
  environment).
* The MonoGame/Gum assemblies are staged from the NuGet cache into
  `RuntimeExerciseTest/refs/` (gitignored) before generation, since reflection needs an
  assembly's dependencies loadable from the same directory; versions are pinned in the
  `Makefile` and must match `RuntimeExerciseTest.csproj`'s new
  `MonoGame.Framework.DesktopGL`/`Gum.MonoGame` `PackageReference`s, which put the same
  assemblies in the test project's output for DotCL compile time and runtime.
  `build-setup.lisp`/`Program.cs` gained the corresponding assembly loads and
  `class-for-type` pre-registrations for the two new `--defgeneric` classes.
* `make test-runtime` also now clears `RuntimeExerciseTest`'s cached `dotcl-fasl`
  bundle before `dotnet build` — MSBuild's incremental inputs for the DotCL
  dependency-resolution target don't track `gen/`'s regenerated contents, so a stale
  `csharp-assembly-packages` fasl was silently reused when the generated class set
  changed.
* No `*generator-version*` bump — no generated-output shape changed.

## 2.50.2 — 2026-07-18

**New `make test-runtime` target: a runtime exercise suite that actually calls generated
wrapper code against live .NET objects.**

* Adds `RuntimeExerciseTest/`, a sibling C# project modeled directly on
  `dotcl-packagegen.csproj` itself: `dotcl-packagegen --out-dir RuntimeExerciseTest/gen`
  generates real packages for a handful of new `AssemblyToLispyTestTarget` fixture
  classes (`RuntimeExerciseFixtures`, `RuntimeOpStruct`, `GenericDispatchFixtureA`/
  `GenericDispatchFixtureB`, plus extensions to `EdgeCaseStruct`) and reuses
  `EventTestClass`/`GenericMethodTestClass`, plus `System.TimeSpan` as a single BCL smoke
  test; DotCL then cross-compiles that generated `.lisp` during `dotnet build`, exactly
  as a real downstream consumer (`dotcl-dungeonslime`) would, which also permanently
  regression-tests ASDF-loadability. `runtime-tests.lisp` is a small, self-contained
  assertion harness that then actually **calls** the generated functions and checks
  results, covering one test per historical runtime-dispatch escape (v48
  omitted-optional-arguments, v49 overload dispatch ordering, v50 `Nullable<T>` guards,
  including a cross-assembly nullable case) plus breadth (Master Wrapper branches with
  3+ clean overloads, operators including the Version-47-renamed `bitwise-or!`,
  properties/fields/indexer get-set, `--constant-properties` memoization identity via
  `cl:eq`, events, unified `--defgeneric` dispatch, generic methods including the
  `name<>` arity dispatcher, and struct boxing mutation aliasing).
* This is the structural fix for the class of bug the v48-v50 fixes all shared: each was
  a runtime-dispatch bug invisible to string-level assertions (paren-balance checking,
  `--read-check`'s read-back) and only ever found downstream, in a real consumer
  (Dungeon Slime). Verified to have teeth: hand-injecting the v48 bug shape (a
  defaulted-parameter's Lisp `&key` default changed from the real C# default to `nil`,
  reproducing the historical "omitted optional passed as nil" failure) makes exactly the
  targeted test fail with a clear diagnostic and a nonzero exit code; reverting restores
  a clean 36/36 pass.
* No `*generator-version*` bump — no generated-output shape changed. See
  `doc/plan-fable-detail-02.md` for the full design and acceptance criteria.

## 2.50.1 — 2026-07-18

**New `--read-check <dir>` mode: read-back verification of generated output through a
real Common Lisp reader.**

* Adds `read-check.lisp` (`read-check:run-read-check`), which reads every `.lisp`/`.asd`
  file in a directory (`packages.lisp` first, so every generated package exists before
  anything referencing it is read) through a genuine Lisp reader — evaluating only
  `defpackage`/`in-package` forms, and neutralizing `#.` read-time evaluation (it reads
  and discards the subform rather than evaluating it, so `csharp-generics.lisp`'s
  `#.(dotnet:class-for-type ...)` forms are validated as well-formed Lisp without
  requiring the target assembly to be loaded). Any packages created during the check
  (including the generated ones) are deleted again afterward.
* This closes an escape path that let the Version 47 bug (an invalid bare `#:|` export
  token, present since Version 30) go undetected for three generator versions: nothing in
  `make test` had ever read generated output through a real reader before, only checked
  paren balance (`check_parens.py`), which cannot see this class of bug. `make test` now
  runs `--read-check` on the generated `cspackages-test/` output as its final step.
* No `*generator-version*` bump — this is a verification-only addition; generated-output
  shape is unchanged. See `doc/plan-fable-detail-01.md` for the full design.

## 2.48.0 — 2026-07-14

**Constructors (and methods) with C# default parameter values are now fully supported,
generating a real wrapper instead of being skipped.**

* A class whose only constructor(s) had every parameter defaulted (e.g.
  `MonoGameGum.GueDeriving.TextRuntime(bool fullInstantiation = true, SystemManagers
  systemManagers = null)`) previously got no `new` at all. `clean-constructor-p` no longer
  disqualifies a defaulted parameter; a single such constructor (or any constructor/method
  needing to make a parameter optional) now routes through the same Master Wrapper
  `&optional`/`&key` dispatch multi-overload methods already used.
* Fixed a real correctness bug present in every previously generated package: an omitted
  optional argument was always silently passed as `nil`/`false` instead of its actual C#
  default (`find-parameter-default-str`'s `cl:return` sat inside a `cl:dolist`, only
  exiting the loop). Also fixed: an invalid duplicate-variable lambda list generated for
  some methods sharing a parameter name across overloads at different positions (e.g.
  `System.IO.Stream`'s `ReadExactlyAsync`).
* New `:default-kind`/`:default-type` metadata keys (see `doc/assembly-to-lispy.md`) let
  the generator emit each default's *actual* typed value — including constructing a boxed
  enum default via `dotnet:enum-or` — rather than guessing from `:type`. A default that
  cannot be faithfully represented as a Lisp literal (e.g. `CancellationToken token =
  default`) makes that one parameter mandatory instead, with its real C# default surfaced
  in the wrapper's docstring.
* See `doc/generator-design-notes.md`'s "Constructors and Methods With Default Parameter
  Values (Version 48)" section and `FEATURES.md`'s new "Default Parameter Values" section
  for the full design writeup.

## 2.46.0 — 2026-07-11

**Added `--csharp-generic-in-asd`/`--no-csharp-generic-in-asd` (global, ON by default): lets
`csharp-generics.lisp` be excluded from the generated `.asd`'s `:components`, commented out for
manual inclusion in a consuming project instead.**

* Only has any effect when at least one `--class` opted into `--defgeneric` (so
  `csharp-generics.lisp` is actually generated). `--no-csharp-generic-in-asd` writes its `:file`
  component out as a comment instead of an active component, with an explanation that it's meant
  to be spliced manually into the *consuming* project's own `.asd`, at a point after that
  project's own target assembly is already loaded.
* Rationale: `csharp-generics.lisp`'s `#.(dotnet:class-for-type ...)` resolves .NET types at
  *compile* time, unconditionally, since 2.41.0 — an accepted, already-documented limitation
  distinct from every other generated file's load-time-deferred resolution. If the whole
  generated system is loaded via an ASDF `:depends-on` before the consuming project's own
  assembly is in scope ([dotcl/dotcl#49](https://github.com/dotcl/dotcl/issues/49)), compiling
  `csharp-generics.lisp` specifically can fail even though every other file in the same system
  loads fine. `--no-csharp-generic-in-asd` sidesteps compiling it as part of the auto-generated
  system entirely, while keeping the exact component text available as a ready-to-paste comment.
* `csharp-generics.lisp` itself is still generated as a file either way; only its own `.asd`
  entry is affected.
* `*generator-version*` bumped 45 → 46 (generated-code shape change, `csharp-assembly-packages.asd`
  only, and only when `--defgeneric` is used at all). See `doc/generator-design-notes.md`'s
  Version 46 section.

## 2.45.0 — 2026-07-11

**Added `--ensure-type-in-generic`/`--no-ensure-type-in-generic` (sticky, OFF by default): an
alternate location for the "Register C# Type with CLOS" `eval-when`, placed inside
`csharp-generics.lisp` itself rather than a class's own file.**

* Emits the same `EnsureDotNetTypeClass` `eval-when` `--ensure-type` (2.44.0) made opt-in, but
  this time directly ahead of an opted-in class's own `#.(dotnet:class-for-type ...)`-specialized
  `defmethod` block inside `csharp-generics.lisp`, rather than inside that class's own package
  file.
* Unlike `--ensure-type`'s eval-when (`:load-toplevel`/`:execute` only), this one includes
  `:compile-toplevel`: `#.(dotnet:class-for-type ...)` is itself read-time-evaluated, i.e.
  already resolved *during compilation* of `csharp-generics.lisp` — an eval-when restricted to
  `:load-toplevel`/`:execute` would run only after the whole file (and every `#.` call in it)
  had already been compiled, too late to influence same-simple-name collision order relative to
  those calls.
* Not a new ASDF-`:depends-on`-safety regression: `csharp-generics.lisp`'s
  `#.(dotnet:class-for-type ...)` mechanism has resolved types at compile time unconditionally
  since 2.41.0 (`--defgeneric`'s own accepted, already-documented limitation, distinct from
  `<type>`'s load-time-deferred resolution) — this adds another compile-time call alongside an
  already-compile-time-dependent file, changing nothing about its existing characteristics.
* Only meaningful for a class that is also `--defgeneric`-opted-in; a class with no entry in
  `csharp-generics.lisp` is unaffected either way.
* `*generator-version*` bumped 44 → 45 (generated-code shape change, `csharp-generics.lisp`
  only). See `doc/generator-design-notes.md`'s Version 45 section for the full design writeup.

## 2.44.0 — 2026-07-11

**Added `--ensure-type`/`--no-ensure-type` (sticky, OFF by default): the per-class "Register C#
Type with CLOS" `eval-when` (`EnsureDotNetTypeClass`) that every previous version emitted
unconditionally is now opt-in.**

* Investigation into DotCL.Runtime's actual source found this eager registration call is not
  needed by anything this generator itself emits: `class-of`/`typep` on any wrapped .NET
  object, and `dotnet:class-for-type` (what `--defgeneric`'s generated `defmethod`s use),
  already lazily register a type's CLOS class themselves on first real need.
* Its only remaining effect is on registration *order*: when two .NET types share a simple
  name across different namespaces, whichever is registered first keeps the friendly
  `dotcl-internal::|Name|` CLOS class symbol. Eager, generation-order-based registration made
  that deterministic; without it, the winner depends on whichever type the running program
  happens to touch first. This only matters for hand-written user code dispatching via the
  simple-name pattern (never `--defgeneric`, which is immune either way) — and per
  `dotcl/dotcl#50` (already in the required DotCL.Runtime 0.1.17), a collision no longer causes
  silent cross-type misdispatch regardless, only a less-friendly assembly-qualified name plus a
  printed warning for whichever type loses the race.
* `--ensure-type`/`--no-ensure-type` is sticky — it applies directly to the current and every
  subsequent `--class`, with no separate per-class override pair (a deliberate exception to
  this tool's usual two-tier sticky-default/per-class-override convention for every other
  flag). Defaults to OFF, unlike this tool's other sticky flags (which all default to "off"
  too, but via a distinct `--enable-*`/`--export-all-*`/`--output-all-*` naming scheme).
* `*generator-version*` bumped 43 → 44 (generated-code shape change: every class file's
  registration block now only appears when opted in). See `doc/generator-design-notes.md`'s
  Version 44 section for the full investigation and design writeup.

## 2.43.0 — 2026-07-11

**Extended the [dotcl/dotcl#49](https://github.com/dotcl/dotcl/issues/49) fix to the two
remaining `defconstant` sites left out of scope in 2.42.0: C# `const` literal fields, and
`--constant-properties`-selected static fields/properties.**

* Both previously emitted `(cl:defconstant <name> (dotnet:static <type-str> "<Member>"))`,
  whose load-time-evaluated init-form hit the same ASDF-`:depends-on`-phase failure `<type>`
  was fixed for in 2.42.0 — a real build still failed even after that fix, since these two
  sites weren't covered.
* Rather than a plain (re-evaluated) `define-symbol-macro`, which would have silently changed
  the performance characteristics of every C# `const`/enum member and every
  `--constant-properties`-selected property (re-invoking a live .NET property/field read on
  *every* reference instead of once), these now use a **memoized** symbol-macro: a private
  cache variable, checked against a new shared `csharp-assembly-utils:+unbound-marker+`
  sentinel, computes the value on first use and reuses it thereafter — preserving
  `defconstant`'s original one-time-then-cached behavior (and its already-documented Version 29
  shared-boxed-instance aliasing hazard, unchanged) while still deferring the actual
  `dotnet:static` call away from load time.
* `--constant-properties`' documented behavior changes slightly as a result: it no longer
  changes re-evaluation semantics (both paths are now `define-symbol-macro`s), only which
  bindings get memoized-and-earmuffed (`+foo+`) vs. plain re-evaluated (`foo`) naming. See the
  updated `--constant-properties` description in `README.md`/`CLAUDE.md` and `FEATURES.md`'s
  rewritten "Static Constants and Symbol Macros" section.
* `*generator-version*` bumped 42 → 43 (generated-code shape change). See
  `doc/generator-design-notes.md`'s Version 43 section for the full design writeup.

## 2.42.0 — 2026-07-11

**Fixed [dotcl/dotcl#49](https://github.com/dotcl/dotcl/issues/49): a generated package now
loads cleanly as an ASDF `:depends-on` dependency of another system, instead of only working
when its files are spliced directly into the consumer's own `:components`.**

* Every generated class file's `<type>` binding is now a `cl:define-symbol-macro` instead of a
  `cl:defconstant`. A `defconstant`'s init-form runs at *load* time; when the generated package
  is an ASDF dependency, the consumer's build process loads the dependency's fasl (running
  `dotnet:resolve-type` there) before the target assembly is necessarily in that build
  process's own type-resolution context, so resolution failed with "type not found" even
  though the identical call succeeds once the deployed app actually runs. A symbol-macro only
  registers a substitution, deferring `resolve-type` to wherever `<type>` is actually *used*.
* This is free of any repeated-evaluation cost after first use, since `DotCL.Runtime` >= 0.1.17
  (already this tool's minimum, since 2.41.0) memoizes a `resolve-type` miss's assembly
  auto-load-and-retry runtime-side after the first expansion.
* The adjacent CLOS-registration `eval-when` (`EnsureDotNetTypeClass`) is narrowed from
  `(:compile-toplevel :load-toplevel :execute)` to `(:load-toplevel :execute)` for the
  identical reason — the dropped `:compile-toplevel` branch unconditionally forced its own
  `resolve-type` call during a dependency's compile phase, which would have reintroduced the
  same failure even after the `<type>` fix above.
* `*generator-version*` bumped 41 → 42 (generated-code shape change). See
  `doc/generator-design-notes.md`'s "`<type>` Becomes a `define-symbol-macro` (Version 42)"
  section for the full writeup, including what was deliberately left out of scope (C# `const`
  literal fields, and the opt-in `--constant-properties` flag) and why.

## 2.41.0 — 2026-07-10

**Consolidated `--defgeneric`/`--defgeneric-dynamic` into a single `--defgeneric`, built on
DotCL 0.1.17's `dotnet:class-for-type` and `defmethod` class-object-specializer support.**

* **Requires `DotCL.Runtime` >= 0.1.17** (`dotcl-packagegen.csproj` bumped from `0.1.15`) — this
  is a hard dependency bump, not optional.
* Every `--defgeneric`-generated dispatch `defmethod` now specializes on
  `#.(dotnet:class-for-type "<fq-name>")` instead of a literal, generation-time-guessed
  simple-name symbol — an ordinary top-level form (no `cl:eval`/`eval-when`/backquote) that is
  also immune to the pre-0.1.17 load-order-dependent naming-collision risk the old `--defgeneric`
  had to document as an accepted caveat.
* **Breaking:** `--defgeneric-dynamic`/`--no-defgeneric-dynamic`/`--enable-defgeneric-dynamic`/
  `--no-enable-defgeneric-dynamic` and the `csharp-generics-dynamic` package/file/`.asd`
  component are removed outright (clean break, not deprecated) — the new single mechanism
  strictly dominates both of the old two-mechanism approach's tradeoffs. Callers using
  `--defgeneric-dynamic` must switch to `--defgeneric`.
* **New limitation:** a generic-arity class (e.g. `` Dictionary`2 ``) opted into `--defgeneric`
  is now skipped, with an explanatory comment, rather than silently emitting a defmethod that
  could never fire — DotCL cannot yet dispatch on an open generic type's own definition. See
  `doc/dispatch-on-open-generics.md` for the mechanism and a proposal to lift this upstream.
* `*generator-version*` bumped 40 → 41 (generated-code shape change). See
  `doc/generator-design-notes.md`'s Version 41 section and `doc/make-everything-defgeneric.md`
  for full detail.

## 2.40.2 — 2026-07-06

**`:interfaces-closed` restructured as a plist, with a documented `GETF`-vs-`MEMBER` caveat.**

* `:interfaces-closed` (new in 2.40.1, below) is now emitted as a true plist — identity
  string, then a list of that identity's closed form(s) — matching the convention every
  other key in this metadata schema already follows, instead of a list of
  `(identity closed-1 closed-2 ...)` tuples.
* **Because its keys are strings, not symbols, this plist cannot be safely read with `GETF`**
  (the CL standard specifies `GETF` compares keys with `EQ`, and a string freshly read from a
  metadata file is never guaranteed to be `EQ` to a query string, even when `STRING=`).
  Consumers must instead use `(second (member identity interfaces-closed :test #'string=))`.
  This is documented prominently in `doc/assembly-to-lispy.md`'s schema entry (an
  `[!IMPORTANT]` callout), explained in full in `doc/generator-design-notes.md`'s "Generic
  Superclass/Interface Identity Matching (Version 40)" section, and demonstrated live in
  `tests/synthetic-target.test.lisp`'s regression test — not just described in prose.
* No `*generator-version*` change (still 40 — this only refines the already-added metadata
  keys' shape, not ancestor-resolution behavior).

## 2.40.1 — 2026-07-06

**Fixed a second, related bug: a type implementing the same open generic interface more than
once (legal C#, e.g. `class Foo : IEquatable<int>, IEquatable<string>`) produced a duplicate
`:interfaces` entry and a genuine key collision in `:interfaces-closed` (new in 2.40.0,
below), silently losing one closed instantiation's information.**

* `:interfaces`/`:interfaces-closed` are now computed by grouping `Type.GetInterfaces()` by
  identity, not a naive one-to-one mapping. `:interfaces` is deduplicated (one entry per
  distinct identity); `:interfaces-closed` groups *all* closed forms for a given identity
  together under that one identity, rather than emitting a separate, colliding entry per
  implementation.
* No `*generator-version*` change (still 40 — this closes a gap in the same Version 40 fix's
  metadata shape, not a new behavior change to ancestor resolution itself).

## 2.40.0 — 2026-07-06

**Fixed a correctness bug: a generic superclass/interface could never be resolved as an
ancestor, even when genuinely present in the provided assemblies.**

* `:superclass`/`:interfaces` (the metadata fields `--export-parents`/`--export-interfaces`/
  `--output-children`/`--output-implementations` all resolve ancestors by) previously used
  .NET's raw `Type.FullName` for a generic base/interface, which is either a closed
  instantiation's full assembly-qualified bracketed form (never matching the generic type
  definition's own bare identity) or, for a generic type referencing its own unresolved type
  parameter, documented to return `null` — silently losing the namespace when the code fell
  back to `Type.Name`. Both cases made ancestor resolution fail outright or misreport a
  genuinely-present ancestor as "missing." Confirmed against a real class hierarchy
  (MonoGameGum's `Gum.Collections.GraphicalUiElementCollection`).
* `:superclass`/`:interfaces` now always hold the generic type definition's bare, matchable
  identity, fixing resolution for any class with a generic ancestor. Two new metadata sibling
  keys, `:superclass-closed`/`:interfaces-closed`, preserve the discarded closed-instantiation
  information for documentation purposes. See `doc/assembly-to-lispy.md`'s updated schema and
  `doc/generator-design-notes.md`'s "Generic Superclass/Interface Identity Matching (Version 40)"
  section (`*generator-version*` bumped to 40).

## 2.39.0 — 2026-07-05

**Added recursive, multi-direction related-class discovery, with flag propagation.**

* New `--output-nested`/`--output-children`/`--output-implementations` (per-class, all OFF by
  default) plus sticky `--output-all-nested`/`--output-all-children`/
  `--output-all-implementations` CLI flags discover, respectively, types nested inside a class,
  its subclasses, and implementers of an interface, adding each as its own generated package.
  Unlike `--export-parents`/`--export-interfaces`, these are generate-only — nothing is
  re-exported into (or otherwise modifies) the class that discovered them.
* **Behavior change for existing `--export-parents`/`--export-interfaces` users:** every
  discovered class (via any of the five discovery directions) now carries its discoverer's
  entire per-class flag set, cascading recursively through the whole connected component a flag
  reaches — previously (2.33.0+), a discovered ancestor was always a flag-less plain package.
  `--constant-properties` is never propagated. See `doc/plan-v38.md`'s Part B and
  `doc/generator-design-notes.md`'s "Recursive Related-Class Discovery (Version 39)" section
  (`*generator-version*` bumped to 39).
* A warning (no hard cap) is printed if a single invocation discovers more than 200 additional
  classes this way.

## 2.38.0 — 2026-07-05

**Added optional per-class injection of C# extension methods, ON by default.**

* New `--extension-methods`/`--no-extension-methods` (per-class) plus sticky
  `--enable-extension-methods`/`--no-enable-extension-methods` CLI flags inject C# extension
  methods (found anywhere in the provided assemblies) whose `this` parameter type is exactly
  the requesting class into that class's own generated package, as ordinary `obj!`-first
  wrapper functions. Unlike every other sticky flag in this tool, this one **defaults ON** —
  a class's own applicable extension methods are injected unless explicitly disabled.
* Matching is exact/concrete only for this version (no base-class, interface, or open-generic
  matching); a dirty, generic, name-colliding, or ambiguously-overloaded candidate is skipped
  with a documenting comment instead of being generated. See `doc/plan-v38.md` and
  `doc/generator-design-notes.md`'s "Extension Methods (Version 38)" section
  (`*generator-version*` bumped to 38).

## 2.37.0 — 2026-07-05

**Fixed a gap: instance events (`add-X`/`remove-X`) were missing from the unified generics
packages.**

* `--defgeneric` and `--defgeneric-dynamic` now fold a class's instance events into
  `csharp-generics`/`csharp-generics-dynamic` alongside methods and property/field accessors —
  previously they were silently omitted (reported against a real class whose `Click` event's
  `add-click` was missing). No CLI change; only affects which names appear in the generated
  unified-generics packages for classes that have instance events. See
  `doc/make-everything-defgeneric.md`/`doc/make-everything-defgeneric-dynamic.md`
  (`*generator-version*` bumped to 37).

## 2.36.0 — 2026-07-05

**The static `--defgeneric` variant's collision comment now reports actual, known conflicts.**

* Previously, every class's collision comment in `csharp-generics.lisp` was a generic,
  purely hypothetical warning ("if another class collides..."). It now reports real findings,
  computed from every type visible to the package generator (every type reflected in every
  provided assembly's metadata, not just requested/generated ones): each other type sharing
  this class's simple name is listed as `ACTUAL` (also generated in this batch — the naming
  race is guaranteed to happen) or `POSSIBLE` (merely known to exist in the provided
  assemblies, not itself generated here), or the comment states plainly that none are known.
  No CLI change — this only affects `csharp-generics.lisp`'s generated comment text. See
  `doc/make-everything-defgeneric.md` (`*generator-version*` bumped to 36).

## 2.35.0 — 2026-07-05

**Renamed the Version 34 unified-generics mechanism to `-dynamic`; added a new, simpler static
variant under the original names.**

* Version 34's `--defgeneric`/`csharp-generics` mechanism (below) is renamed, with no behavior
  change, to `--defgeneric-dynamic`/`--no-defgeneric-dynamic` (per-class),
  `--enable-defgeneric-dynamic`/`--no-enable-defgeneric-dynamic` (sticky), and the
  `csharp-generics-dynamic` package/file — it was judged too ugly to be the only option (its
  generated `defmethod`s are installed via `cl:eval` of a backquoted form at load time). See
  `doc/make-everything-defgeneric-dynamic.md`.
* The freed original names (`--defgeneric`/`--no-defgeneric`,
  `--enable-defgeneric`/`--no-enable-defgeneric`, `csharp-generics` package/file) now drive a
  **new, independent, orthogonal** implementation: each unified name gets an ordinary top-level
  `cl:defmethod` — no `cl:eval`, no `eval-when`, no backquote — specializing directly on a
  literal symbol computed at generation time from the C# type's simple name
  (`dotcl-internal::|SimpleName|`). Simpler, more readable generated code, at the cost of a
  documented caveat: if two `--defgeneric`-opted-in classes in the same batch share a simple
  name across different namespaces, dispatch for whichever one loses DotCL's own class-naming
  race at load time is silently wrong. A class may use either variant, both, or neither. See
  `doc/make-everything-defgeneric.md` (including a worked, demonstrated example of the collision
  caveat via the `Makefile` smoke test's real-world `System.Threading.Timer`/
  `System.Timers.Timer` pair) and `FEATURES.md`'s "Unified Generic Methods" section
  (`*generator-version*` bumped to 35).

## 2.34.0 — 2026-07-05

**Added optional per-class unification of instance members into shared CLOS generic functions.**

* New per-class CLI flags `--defgeneric`/`--no-defgeneric` (attach to the most recently given
  `--class`, like `--export-parents`), plus sticky `--enable-defgeneric`/`--no-enable-defgeneric`
  (set the default for the current and every subsequent `--class` in command-line order, like
  `--export-all-parents`). A class opting in contributes its instance methods and instance
  property/field accessors (getters and setters) to a new shared `csharp-generics` package of
  CLOS generic functions dispatching on the C# runtime type of the receiver — e.g.
  `(csharp-generics:length x)` works whichever opted-in type `x` is, forwarding to that type's
  own generated wrapper. Excluded: static members, generic/type-parameterized instance methods,
  and overloaded indexers. A batch with no `--defgeneric` class emits no `csharp-generics.lisp`,
  no `csharp-generics` package, and no new `.asd` component — byte-identical output to before
  this version. See `FEATURES.md`'s "Unified Generic Methods" section and
  `doc/make-everything-defgeneric.md` for the full design (`*generator-version*` bumped to 34).

## 2.33.1 — 2026-07-05

**Added per-class one-time overrides for the `--export-all-*` sticky defaults.**

* `--export-parents`/`--export-interfaces`/`--export-object` each gained a `--no-` counterpart
  (`--no-export-parents`, `--no-export-interfaces`, `--no-export-object`) that turns the flag
  back off for just the most recently given `--class`, overriding whichever
  `--export-all-parents`/`--export-all-interfaces`/`--export-all-object` sticky default is in
  effect at that point — without this, once a sticky default was turned on there was no way to
  opt a single class back out of it. CLI-only change: `Program.cs` already resolved each class's
  final three booleans before building the manifest, so no change was needed to the manifest
  format, `assembly-package-generator.lisp`, or generated output shape (`*generator-version*`
  stays at 33).
* See `PLAN.md`'s "More Parent & Ancestor stuff" section and `--help`'s updated
  "Parents and interfaces" block.

## 2.33.0 — 2026-07-05

**Added optional per-class re-export of inherited super-class/interface members.**

* New per-class CLI flags `--export-parents`, `--export-interfaces`, `--export-object`
  (attach to the most recently given `--class`, like `--constant-properties`), plus sticky
  `--export-all-parents`/`--export-all-interfaces`/`--export-all-object` (and their `--no-`
  counterparts) that set the default for the current and every subsequent `--class` in
  command-line order. A class opting in also gets packages generated for its super-class
  chain and/or implemented interfaces (across *every* assembly provided on the command
  line, not just its own), with their non-conflicting members re-exported into its own
  package.
* New global `--skip-missing`/`--no-skip-missing` flag: by default, an ancestor that cannot
  be resolved in any provided assembly's metadata is a hard error, aborting before anything
  is generated (matching the existing missing-class behavior); `--skip-missing` downgrades
  this to a warning and drops just that ancestor.
* Re-export is implemented as a post-pass of `cl:shadowing-import`/`cl:import`/`cl:export`
  calls appended to `packages.lisp` after every class's `cl:defpackage` form — no
  topological ordering of the `defpackage` forms themselves is required. A name is skipped
  (documented with a comment, not silently dropped) when the requesting class already
  declares it itself, or when more than one ancestor exports the same name (ambiguous — a
  future version may add a renamed re-export for this case).
* See `doc/parents-and-interfaces-plan.md` for the full design, `FEATURES.md`'s new "Parents
  and Interfaces" section, and `assembly-package-generator.lisp`'s `*generator-version*`
  docstring (Version 33) for the implementation-level changelog.

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
