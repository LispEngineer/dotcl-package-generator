# File Manifest

* Author: Douglas P. Fields, Jr. - symbolics@lisp.engineer
* Copyright 2026 Douglas P. Fields, Jr.

Succinct purpose/contents of every top-level file, `AssemblyToLispyTestTarget/`'s files,
and a summary (not a file listing) of `cspackages-test/`'s contents. See `CLAUDE.md`'s
"Architecture map" for how the generator pipeline fits together, and `doc/` for deeper
design docs.

## C# Host

* **`Program.cs`** — CLI entry point: arg parsing/dispatch, `--out-dir`/`--assembly`/
  `--class`/`--constant-properties`/flag parsing, runs metadata reflection before booting
  DotCL, builds the batch manifest, and invokes the Lisp generator.
* **`AssemblyToLispy.cs`** — reflects a .NET assembly (plus its XML doc file) into a
  Lisp-reader-compatible `.lispy.metadata` plist file: type/member enumeration, XML-doc
  parsing, generic/operator name mangling, default-value literal formatting. Includes the
  `AssemblyToLispyTest` C# test suite (`--test` mode).
* **`MonoUtils.cs`** — small reflection helpers (`GetTypeMethods`/`GetTypeProperties`/etc.)
  exposed to Lisp via plain `dotnet:static` calls, used only by this repo's own
  (`tests/framework.lisp`) test suite.
* **`dotcl-packagegen.csproj`** — the tool's project file (target framework, package
  metadata, DotCL.Runtime dependency version, content-copy rules for `.lisp`/`.asd`
  sources into the build output).
* **`NuGet.Config`** — package sources; includes a local `../dotcl/out` feed for
  DotCL.Runtime versions not yet published to nuget.org.

## Lisp Generator Core

All emit one Lisp package, `assembly-package-generator`; split out of a former single
`assembly-package-generator.lisp` (see `doc/generator-design-notes.md`) for maintainability.

* **`packages.lisp`** — defines every Lisp package and its exports for this tool
  (`assembly-package-generator`, `utils`, `monoutils`, `package-generator-tests`, etc.).
* **`utils.lisp`** — shared plumbing: safe s-expression file reading, path helpers, the
  `csharp-overload-not-found` condition type.
* **`monoutils.lisp`** — package definition/shims exposing `get-type`/`get-type-full-name`
  for live-CLR semantic verification in this repo's own test suite only.
* **`read-check.lisp`** — `run-read-check`: reads every generated `.lisp`/`.asd` file in a
  directory through a real Lisp reader (not just paren-balance checking), invoked from
  `Program.cs`'s `--read-check <dir>` mode and as part of `make test`. A verification tool,
  not part of the generator itself. See `doc/plan-fable-detail-01.md`.
* **`apg-naming.lisp`** — `*generator-version*`/changelog, and naming/mangling helpers
  (`camel-to-kebab`, `map-member-name`, `type-fq-name-to-pkg-name`, `safe-symbol-token`,
  string-escaping).
* **`apg-member-predicates.lisp`** — member-classification predicates (is this a clean
  method? a constant property? a mutable field?) and `classify-class-members`.
* **`apg-overload-signatures.lisp`** — signature-string and docstring-formatting helpers
  used when documenting a method/constructor's overloads.
* **`apg-overload-dispatch.lisp`** — the overload/generic-arity dispatch engine: Master
  Wrapper generation, single-overload wrappers, generic-arity dispatchers.
* **`apg-immutability.lisp`** — tracks which C# types are known-safe immutable primitives,
  and emits struct-boxing-mutation warning comments where they aren't.
* **`apg-export-mirrors.lisp`** — computes a class's `defpackage` export/shadow lists
  (`compute-package-exports-and-shadows`), shared with `generate-class-file`.
* **`apg-class-file-generator.lisp`** — `generate-class-file` itself and its `emit-*`
  section helpers (constructors, properties, fields, events, indexers, CLOS registration).
* **`apg-batch-discovery.lisp`** — batch entry resolution and recursive related-class
  discovery (`--export-parents`/`--output-children`/etc.) across a metadata index.
* **`apg-reexports-and-generics.lisp`** — ancestor member re-exports
  (`emit-child-reexports`) and the unified `--defgeneric` CLOS generic-function machinery.
* **`apg-batch-orchestration.lisp`** — top-level batch entry points
  (`run-assembly-package-generator-batch` → `generate-assembly-packages-batch`), plus
  `packages.lisp`/`.asd` file emission for a generated batch.

## Generated-Output Templates

* **`csharp-assembly-utils-package.template.lisp`** — standalone `defpackage` form for the
  shared `CSHARP-ASSEMBLY-UTILS` package, copied verbatim into every generated
  `packages.lisp`.
* **`csharp-assembly-utils.template.lisp`** — shared runtime support (the
  `csharp-overload-not-found` condition, memoized-constant sentinel) copied verbatim into
  every generated batch's `csharp-assembly-utils.lisp`.

## Tests

* **`generator-tests.lisp`** — `run-generator-tests`, the harness `Program.cs` invokes in
  `--test` mode; calls every `run-*-tests` function below in sequence.
* **`package-generator-tests-support.lisp`** — shared test-support code (`assert-test`, etc.)
  for the clusters below.
* **`package-generator-tests-naming.lisp`** — naming/mangling helper tests
  (`camel-to-kebab`, `type-fq-name-to-pkg-name`, `safe-symbol-token`, `split-string`).
* **`package-generator-tests-operator-overloads.lisp`** — operator-overload codegen tests
  (mapped operator methods, `op_BitwiseOr` → `bitwise-or!`).
* **`package-generator-tests-overload-classification.lisp`** — clean/dirty overload
  classification and generic-arity dispatch-mode tests.
* **`package-generator-tests-batch-resolution.lisp`** — batch entry resolution/
  orchestration tests.
* **`package-generator-tests-property-field-codegen.lisp`** — property/field/indexer
  codegen tests.
* **`package-generator-tests-generic-method-codegen.lisp`** — generic-method codegen tests.
* **`package-generator-tests-events.lisp`** — C# event (add/remove accessor) codegen tests.
* **`package-generator-tests-parents-interfaces.lisp`** — `--export-parents`/
  `--export-interfaces` upward-ancestor-graph re-export tests.
* **`package-generator-tests-related-discovery.lisp`** — recursive related-class
  (nested/children/implementations) downward-discovery tests.
* **`package-generator-tests-defgeneric.lisp`** — unified `--defgeneric` CLOS
  generic-function tests.
* **`package-generator-tests-extension-methods.lisp`** — extension-method injection tests.
* **`package-generator-tests-read-check.lisp`** — `read-check:run-read-check` tests,
  including a regression test recreating the exact Version 47 unescaped-`#:|` bug shape.

(The `tests/` subdirectory holds a separate, dynamically-globbed suite that
semantically cross-checks reflected metadata against the live CLR — not itemized here.)

## Build & Tooling

* **`Makefile`** — all build/test/package/deploy/clean targets; the canonical entry point
  for building, testing, and packaging this tool (see `CLAUDE.md`/`BUILD.md`).
* **`dotcl-packagegen.asd`** — ASDF system definition for the generator's own Lisp sources
  (load order, version).
* **`check_parens.py`** — validates parenthesis balance across `.lisp`/`.asd` files; run
  after hand-editing Lisp, and as part of `make test`'s generated-output smoke check.
* **`revert-cspackages-timestamps.sh`** — reverts `cspackages-test/`'s embedded
  generation-timestamp/version lines when they're the *only* diff after `make test`
  regenerates it, so timestamp-only churn doesn't show up as a real change.
* **`.gitignore`** — ignores `bin/`, `obj/`, `.vscode/`, `.aider*`, `scratch/`, `nupkg/`.

## Documentation

* **`README.md`** — top-level overview/quickstart for the repository.
* **`CLAUDE.md`** — instructions/architecture map for Claude Code (this file's own
  counterpart in intent); symlinked as **`AGENTS.md`**.
* **`GEMINI.md`** — pointer instructions for Gemini/Antigravity, deferring to
  `README.md`/`CLAUDE.md`.
* **`BUILD.md`** — build-specific notes (e.g. keeping `VERSION` in lockstep across files).
* **`FEATURES.md`** — feature-by-feature description of what generated packages look like
  and support.
* **`RELEASES.md`** — CLI-level/tool-behavior release history, keyed by version.
* **`PLAN.md`** — open work items, deferred features, and in-progress investigation
  writeups (append/mark-done only, never rewritten).
* **`LICENSE`** — Apache 2.0 license text.
* **`doc/`** — deeper design docs (metadata schema, generator design-decision history,
  DotCL interop reference, dependency lists, feature-specific design plans) — not itemized
  here; see `CLAUDE.md`'s "Architecture map" for pointers into it.

## `AssemblyToLispyTestTarget/`

A small, deliberately-crafted C# assembly whose sole purpose is giving `AssemblyToLispy.cs`
100% metadata-edge-case coverage without depending on finding those cases in the real BCL.

* **`EdgeCases.cs`** — the actual test-target source: generics, `scoped`/`ref readonly`/
  `params`, extension methods, abstract base + protected ctor, enums with a non-`int` base
  type, interfaces, events, indexers, etc.
* **`AssemblyToLispyTestTarget.csproj`** — its project file (net10.0, doc-file generation
  enabled since `AssemblyToLispy.cs` also exercises XML-doc parsing against it).

## `cspackages-test/`

Checked-in output of `make test`'s end-to-end smoke-generation step — **not hand-edited**,
regenerated on every `make test` run so generation-output drift is visible in diffs. Holds:

* `.lispy.metadata` files — the raw reflected-metadata output for each real reference
  assembly the smoke test targets (`System.Runtime`, `System.Linq`,
  `System.Xml.ReaderWriter`, `System.Numerics.Vectors`, etc.) plus `AssemblyToLispyTestTarget`.
* One generated `.lisp` package file per requested/discovered class (methods, properties,
  constructors, events, re-exports, CLOS registration, etc.).
* `packages.lisp` — the consolidated `defpackage` forms for the whole batch.
* `csharp-assembly-utils.lisp` / `csharp-generics.lisp` — the batch's shared runtime-support
  and unified-generics files.
* `csharp-assembly-packages.asd` — the ASDF system tying every generated file together.

## `RuntimeExerciseTest/`

The runtime exercise suite (`make test-runtime`, see
[`doc/plan-fable-detail-02.md`](doc/plan-fable-detail-02.md)): actually compiles, loads,
and calls generated wrapper code against live .NET objects, guarding the v48-v50
runtime-dispatch escape class invisible to `make test`'s string-level checks.

* **`RuntimeExerciseTest.csproj`** — modeled on `dotcl-packagegen.csproj` itself: DotCL
  cross-compiles `gen/`'s generated `.lisp` during `dotnet build`, exactly as
  `dotcl-dungeonslime` consumes real generated output. References
  `AssemblyToLispyTestTarget.csproj` directly (needed so `--defgeneric`'s
  `#.(dotnet:class-for-type ...)` forms can resolve those fixture types at DotCL
  compile time) and declares `gen/` as a `DotclAsdSearchPath`.
* **`build-setup.lisp`** — a `DotclBuildInit` script, loaded before both dependency
  resolution and root compilation: explicitly loads `AssemblyToLispyTestTarget.dll` plus
  the MonoGame/Gum assemblies, and pre-registers the CLOS classes for every
  `--defgeneric` class in the batch, since the usual `dotnet:resolve-type`
  base-directory probe looks in the wrong place when running inside an in-process
  MSBuild task.
* **`runtime-exercise.asd`** — `:depends-on ("csharp-assembly-packages")` (the system
  `gen/` defines, regardless of which classes were requested).
* **`runtime-tests.lisp`** — the assertion suite itself: a small, self-contained
  `deftest`/`check-equal`-style harness (deliberately not `tests/framework.lisp`, which
  does metadata schema validation for this repo's own Stage-1 suite instead) covering one
  test per historical escape (v48 omitted defaults, v49 dispatch ordering, v50
  `Nullable<T>`) plus breadth (Master Wrapper branches, operators, properties/fields/
  indexers, static-property memoization, events, `--defgeneric` dispatch, generic
  methods, struct boxing mutation), and real-world coverage against BCL
  (`TimeSpan`/`DateTime`/`StringBuilder`), MonoGame (`Vector2` incl. the documented
  `Normalize()` in-place mutation transcript case, `Color`, `Point`, `Rectangle`,
  `MathHelper`, `GameTime`, `Input.Keys`), and Gum (`DimensionUnitType` with GumCommon's
  own injected extension methods, `KeyCombo`, `TextRuntime`'s all-defaulted v48-motivator
  constructor).
* **`Program.cs`** — boots DotCL, pre-registers the same `--defgeneric` CLOS classes
  (this time for the real runtime process, not the build-time MSBuild task), loads the
  manifest, calls `RUN-RUNTIME-EXERCISE-TESTS`, and exits nonzero on any failure.
* **`gen/`** — output of `make test-runtime`'s generation step; gitignored, not checked in
  (unlike `cspackages-test/`, which exists specifically to make generation-output drift
  visible in diffs — `gen/`'s only job is to be compiled and called, not diffed).
* **`refs/`** — staging directory (gitignored) the `Makefile` fills from the NuGet cache
  with the pinned MonoGame/Gum assemblies plus their own dependencies, so metadata
  reflection can resolve cross-assembly references from one directory.

Fixture classes supporting this suite live in `AssemblyToLispyTestTarget/EdgeCases.cs`:
`RuntimeExerciseFixtures`, `EdgeCaseStruct` (extended with a constructor, a mutable
instance property, and a populated indexer backing array), `RuntimeOpStruct`,
`GenericDispatchFixtureA`/`GenericDispatchFixtureB`, reusing the pre-existing
`EventTestClass`/`GenericMethodTestClass`.
