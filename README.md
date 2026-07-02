# DotCL C# Lisp Package Generator

* Author: [Douglas P. Fields, Jr.](mailto:symbolics@lisp.engineer)
* Copyright 2026 Douglas P. Fields, Jr.
* License: [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) - see [LICENSE](LICENSE)

## Overview

TODO

# Usage

TODO

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
