# DotCL C# Lisp Package Generator

* Author: [Douglas P. Fields, Jr.](mailto:symbolics@lisp.engineer)
* Copyright 2026 Douglas P. Fields, Jr.
* License: [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) - see [LICENSE](LICENSE)

## Overview

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
  literal formatting, etc.)

* **Stage 2** (`--assembly-metadata <file> --class <FQN> --output <dir>`, boots DotCL): loads a
  Stage-1 metadata file and calls into `assembly-package-generator.lisp`
  (`run-assembly-package-generator` → `generate-assembly-packages` → `generate-class-file`),
  which reads the plist for the requested class(es) and emits a `.lisp` file defining a package
  with idiomatic Lisp wrapper functions for that C# type's constructors, methods, properties,
  and fields.

Splitting these stages means metadata can be captured once and reused, and Stage 2 (the part
that needs to boot the full Lisp host) can be iterated on without re-running reflection.

The metadata is a single Lisp s-expression.

## Origin

This package was split out of my
[DotCL Dungeon Slime](https://github.com/LispEngineer/dotcl-dungeonslime)
MonoGame proof of concept.


# CLI Usage (Stage 1 / Stage 2 directly)

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


# Building & Testing

A `Makefile` is provided with the following targets:

* `make build` — Builds the project (`dotnet build dotcl-packagegen.csproj -c Debug`),
  compiling both the C# host and the DotCL Common Lisp sources into
  `bin/Debug/net10.0/`.

* `make test` — Builds the project (via `build`), then runs the built executable
  in `--test` mode. This runs the generator's own Lisp unit tests
  (`package-generator-tests.lisp`, including the generated `System.TimeSpan`
  operator-overload checks) followed by the `AssemblyToLispy` metadata test
  suite against `System.Runtime.dll`, `System.Console.dll`, the synthetic
  `AssemblyToLispyTestTarget.dll`, and `DotCL.Runtime.dll`.

* `make package` — Builds Release binaries for every configured
  `RuntimeIdentifier` (`linux-x64`, `linux-arm64`, `win-x64`, `osx-x64`,
  `osx-arm64`, `any`) and produces the installable NuGet package(s)
  (`dotnet pack -c Release -o nupkg`) in the `nupkg/` directory: one package
  per RID plus a top-level meta-package that dispatches to them.

* `make deploy` — Depends on `package`, then installs (or reinstalls, if
  already present) `dotcl-packagegen` as a global `dotnet tool` from the
  package(s) just built (`dotnet tool install --global --add-source nupkg
  dotcl-packagegen`), making the `dotcl-packagegen` command available on
  `PATH` from any directory.

* `make clean` — Runs `dotnet clean` and removes the `bin/`, `obj/`,
  `AssemblyToLispyTestTarget/bin/`, `AssemblyToLispyTestTarget/obj/`, and
  `nupkg/` directories.

Typical workflow: `make build test` while developing, `make deploy` to install
a local build as the system-wide `dotcl-packagegen` command.
