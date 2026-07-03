# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

`dotcl-packagegen` is a standalone CLI tool (packaged as a `dotnet tool`) that generates
[DotCL](https://github.com/dotcl/dotcl) Common Lisp packages/bindings for arbitrary .NET
assemblies. It is a hybrid C#/Common Lisp codebase: C# does .NET reflection and hosts the
DotCL Lisp runtime; Lisp does the actual code generation via string templating.

The tool operates in two independent stages:

* **Stage 1** (`--assembly <dll> --output <metadata-file>`, pure C#, no DotCL needed):
  `AssemblyToLispy.cs` reflects over a .NET assembly (plus its sidecar `.xml` doc file, if
  present) and emits a single Lisp-reader-compatible s-expression list — one plist per public
  type — to a "lispy metadata" file. See `doc/assembly-to-lispy.md` for the complete, canonical
  schema of this format (keys, flags, parameter plists, documentation plists, default-value
  literal formatting, etc.) — **that doc must be kept in sync with any change to
  `AssemblyToLispy.cs`'s output shape.**
* **Stage 2** (`--assembly-metadata <file> --class <FQN> --output <dir>`, boots DotCL): loads a
  Stage-1 metadata file and calls into `assembly-package-generator.lisp`
  (`run-assembly-package-generator` → `generate-assembly-packages` → `generate-class-file`),
  which reads the plist for the requested class(es) and emits a `.lisp` file defining a package
  with idiomatic Lisp wrapper functions for that C# type's constructors, methods, properties,
  and fields.

Splitting these stages means metadata can be captured once and reused, and Stage 2 (the part
that needs to boot the full Lisp host) can be iterated on without re-running reflection.

## Build & test commands

Always prefer the `Makefile` targets over calling `dotnet` directly — they encode ordering and
post-build verification steps that matter (see below).

* `make build` — `dotnet build dotcl-packagegen.csproj -c Debug`. Compiles the C# host *and*
  cross-compiles the DotCL Lisp sources (`packages.lisp`, `utils.lisp`, `monoutils.lisp`,
  `assembly-package-generator.lisp`, `package-generator-tests.lisp`, `generator-tests.lisp` —
  see `dotcl-packagegen.asd` for the load order) into `bin/Debug/net10.0/`.
* `make test` — builds, then runs the built executable's `--test` mode (Lisp unit tests in
  `package-generator-tests.lisp`/`generator-tests.lisp`, plus the `AssemblyToLispyTest` C# suite
  against `System.Runtime.dll`, `System.Console.dll`, the synthetic
  `AssemblyToLispyTestTarget.dll`, and `DotCL.Runtime.dll`). It then does an **end-to-end
  smoke test**: runs both stages against real reference assemblies
  (`System.Runtime`, `System.Linq`, `System.Xml.ReaderWriter`) to generate real `.lisp` packages
  into `cspackages-test/` (checked into git so output drift is visible in diffs), and finally
  runs `check_parens.py` on everything generated. This last step exists because generated code
  comes from `format` string templating in `assembly-package-generator.lisp` — a bug there can
  silently emit Lisp with mismatched parens that no unit test would catch.
* `make check-parens` — runs `check_parens.py` over every source `.lisp`/`.asd` file in the
  repo. **Run this after hand-editing any `.lisp` file**; a stray/missing paren produces
  confusing downstream errors (symbols reported as "not external", macros silently swallowing
  subsequent top-level forms) rather than a clear syntax error.
* `make package` — `dotnet pack -c Release -o nupkg`, once per `RuntimeIdentifier`
  (`linux-x64`, `linux-arm64`, `win-x64`, `osx-x64`, `osx-arm64`, `any`), producing the
  per-RID packages plus a dispatching meta-package.
* `make deploy` — depends on `package`; installs the freshly built package as a global
  `dotnet tool`, uninstalling any previous global install first.
* `make clean` — `dotnet clean` plus removal of `bin/`, `obj/`, `AssemblyToLispyTestTarget/{bin,obj}`,
  `nupkg/`.

Typical dev loop: `make build test`. Use `make deploy` only when you actually want the
system-wide `dotcl-packagegen` command updated.

To check a single Lisp file's paren balance directly: `python3 check_parens.py path/to/file.lisp`.

There is no separate "run one test" entry point — `--test` runs the whole Lisp + C# suite in
one process; Lisp tests are self-registering (see `tests/framework.lisp`'s `def-assembly-test`)
rather than individually addressable from the CLI.

### CLI usage (Stage 1 / Stage 2 directly)

```sh
dotcl-packagegen --assembly path/to/Some.dll --output some.lispy.metadata
dotcl-packagegen --assembly-metadata some.lispy.metadata --class Some.Namespace.Type \
    --output ./cspackages --constant-properties "*"
```

`--constant-properties` (comma/semicolon-separated names, or `"*"` for all) forces static
read-only properties to be emitted as `defconstant` instead of `define-symbol-macro` — safe
only when the property genuinely never changes at runtime (e.g. `Vector2.Zero`), since
reflection alone can't tell constants from properties that vary.

`--version`/`--help` and `--test` boot the DotCL host (`DotclHost.Initialize()`); `--assembly`
(Stage 1 alone) intentionally does not, since it's pure reflection.

## Architecture map

* **`Program.cs`** — CLI entry point/arg parsing/dispatch only. Stage 1 (`--assembly`) is
  handled *before* `DotclHost.Initialize()` runs, since it needs no Lisp; everything else
  (Stage 2, `--test`, `--version`) boots DotCL first.
* **`AssemblyToLispy.cs`** — Stage 1. All the reflection-to-plist logic: type/member
  enumeration, XML-doc-comment parsing and signature matching, generic/backtick type-name
  formatting, default-value-to-Lisp-literal conversion, operator-name mangling
  (`op_Addition` → `+`), etc. `AssemblyToLispyTest` (bottom of the file) is the C# half of
  `--test`.
* **`MonoUtils.cs`** — small set of C#-implemented Lisp primitives (registered into DotCL via
  `MonoUtilsRegistrar.Initialize()`), exposed to Lisp as the `MONOUTILS` package
  (`monoutils.lisp` re-exports them). Used both by the generator itself and by *generated*
  package code at runtime (e.g. `monoutils:dotnet-p`, `monoutils:get-type` — see
  `doc/package-generator-dependencies.md` for the full dependency list in both directions).
* **`assembly-package-generator.lisp`** — Stage 2, the code generator proper. Entry points
  `run-assembly-package-generator` → `generate-assembly-packages` → `generate-class-file`
  (~1000 lines; the bulk of the file). Bump `*generator-version*` (top of file) whenever
  generation *behavior* changes, and add a changelog line in its docstring — `doc/generator-design-notes.md`'s
  "Generator Version History" section has the detailed rationale per version and should gain an
  entry for significant changes. `VERSION` in `Makefile`, `dotcl-packagegen.asd`, and
  `assembly-package-generator.lisp` must all be kept in lockstep (see `BUILD.md`).
* **`utils.lisp`** / **`monoutils.lisp`** / **`packages.lisp`** — shared plumbing: safe
  s-expression file reading, path helpers, the `csharp-overload-not-found` condition type
  (signaled by generated overload-dispatch code at runtime when no C# overload matches), and
  all package/export definitions for this trimmed-down standalone tool.
* **`AssemblyToLispyTestTarget/`** — a small, deliberately-crafted C# assembly
  (`EdgeCases.cs`) whose sole purpose is exercising every metadata edge case (generics,
  `scoped`/`ref readonly`/`params`, extension methods, abstract base + protected ctor,
  enums with non-`int` base type, interfaces) so Stage 1 has 100% coverage without depending on
  finding these cases in the real BCL.
* **`tests/`** — Lisp test suite, dynamically discovered at runtime (globbed, not statically
  loaded via the `.asd`): `framework.lisp` provides the `deftest`/`assert-equal` DSL plus a
  recursive schema validator (`validate-type-schema` etc., enforcing the exact schema in
  `doc/assembly-to-lispy.md`) and a semantic CLR cross-checker (resolves each documented type
  live via `monoutils:get-type` and confirms members actually exist). Each
  `tests/*.test.lisp` file registers itself against one target assembly via
  `def-assembly-test`; add a new file here (not by editing `framework.lisp`) when adding
  coverage for a new assembly.
* **`cspackages-test/`** — checked-in output of `make test`'s end-to-end smoke-generation step.
  Not hand-edited; regenerated by `make test`. Useful for diffing generation output across
  changes.
* **`doc/`** — design docs, not just notes:
  * `assembly-to-lispy.md` is the **canonical schema spec** for the Stage 1 metadata format —
    treat it as authoritative and update it alongside any `AssemblyToLispy.cs` output change.
  * `generator-design-notes.md` is the versioned design/rationale log for
    `assembly-package-generator.lisp` (naming conventions, overload dispatch algorithm,
    struct-boxing caveats, CLOS class registration/collision caveats, etc.) — read the relevant
    section before changing overload resolution, naming, or constructor/operator generation.
  * `dotnet-dotcl-interop.md` documents the DotCL `dotnet:*` Lisp API (both directions:
    Lisp-calls-.NET and .NET-calls-Lisp) that generated packages and the generator itself rely on.
  * `package-generator-dependencies.md` enumerates exactly which `utils`/`monoutils` symbols
    the generator (and separately, its *generated output*) depend on — check this before
    removing or renaming anything in `utils.lisp`/`monoutils.lisp`.

## Key conventions when touching the generator

* Generated Lisp templates qualify standard CL operators with `cl:` (e.g. `cl:defun`,
  `cl:cond`, `cl:length`) because generated packages routinely `:shadow` symbols like `=`,
  `and`, or `t` to match C# operator/member names — an unqualified call would resolve to the
  shadowed local version instead of the real CL function. Follow this pattern in any new
  code-emitting `format` calls.
* C# names that collide with CL reader syntax (`quote`, `function`, `t`, `nil`) get mapped to
  safe suffixed forms (`quote!`, `function!`, `t!`, `nil!`) rather than being shadowed.
  `Is*`-prefixed predicates become `*?` (`IsEmpty` → `empty?`); this is deliberately distinct
  from Lisp's usual "-p" suffix.
* Overloaded methods/constructors: a "clean" overload (no ref/out/params/generics/defaults)
  gets a real typed wrapper; multiple clean overloads get one `&rest`/`&optional`
  runtime-dispatching wrapper plus type-suffixed direct-call wrappers (e.g.
  `contains-vector-2`); "dirty" overloads are skipped but documented in a comment. See
  `doc/generator-design-notes.md`'s per-version sections for the exact dispatch rules
  (positional-prefix computation, static/instance grouping, etc.) before modifying this logic
  — it has non-obvious history (e.g. static/instance method-name collisions, struct boxing
  losing mutations across `dotnet:invoke` calls).
* After any hand-edit to a `.lisp` file, run `make check-parens` (or
  `python3 check_parens.py <file>`) before assuming a build failure is something else.
