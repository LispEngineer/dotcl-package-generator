# DotCL Package Generator Build Notes

* Author: [Douglas P. Fields, Jr.](mailto:symbolics@lisp.engineer)
* Copyright 2026 Douglas P. Fields, Jr.


# Version Numbers

When changing the code, the version number needs to be updated in
these locations:

* [`Makefile`](Makefile)
* [`apg-naming.lisp`](apg-naming.lisp) — `*generator-version*`, whenever generated-code
  *shape* changes (this is a separate integer from the CLI version below, though the
  latter's minor component tracks it — see the `Makefile`'s `VERSION` comment)
* [`dotcl-packagegen.asd`](dotcl-packagegen.asd)
* [`RELEASES.md`](RELEASES.md) — add an entry describing the change alongside the version bump.


# Parentheses Balance Checker

[`check_parens.py`](check_parens.py) 
(forked from my [dotcl-dungeonslime](https://github.com/LispEngineer/dotcl-dungeonslime)) 
scans Lisp source files and verifies that every opening parenthesis has a matching
closing one, correctly skipping character literals (`#\(`), single-line `;`
comments, nested `#| ... |#` block comments, and string literals. It exits
`0` if every file it's given is balanced, `1` otherwise.

* `make check-parens` — runs it over every `.lisp`/`.asd` file in the
  repository (excluding `bin/`, `obj/`, `.git/`, and `nupkg/`). Run this
  after hand-editing any Lisp source file.

* `make test` also runs it automatically, but on **generated** output rather
  than source: as part of the test run, `test` uses the freshly built
  executable to generate a couple of representative standard-.NET packages
  end-to-end (`System.TimeSpan` and `System.Console`, into
  `obj/test-generated/`) and then runs `check_parens.py` on those generated
  `.lisp` files. This is a regression check on the generator's own
  code-emission logic — since packages are produced via textual templating
  (`format` strings across the `apg-*.lisp` modules), a bug there can
  silently emit Lisp with mismatched parentheses that unit tests alone
  wouldn't catch.

To check a specific file (or a freshly generated one) directly:

```sh
python3 check_parens.py path/to/file.lisp [path/to/another.lisp ...]
```


# Reference Assembly Directory (`REF_DIR` / `DOTCL_PACKAGEGEN_REF_DIR`)

`make test`/`make test-runtime` need the .NET reference-assembly pack
(`Microsoft.NETCore.App.Ref`) to exercise the reflector and end-to-end smoke test against real
BCL assemblies. This directory is auto-discovered (`Makefile`'s `REF_DIR`, filtered to the
csproj's own `TargetFramework` major; and, independently, `AssemblyToLispyTest`'s
`ResolveRefAssemblyDirectory()` for the `--test` C# suite) across the known Arch
(`/usr/share/dotnet/...`) and Ubuntu (`/usr/lib/dotnet/...`) pack layouts — no longer a
hardcoded, SDK-patch-version-pinned path (see
[`doc/plan-fable-detail-08.md`](doc/plan-fable-detail-08.md)).

* Override explicitly with `make test REF_DIR=/some/path/` if auto-discovery picks the wrong
  one, or set `DOTCL_PACKAGEGEN_REF_DIR=/some/path/` for the same effect (the Makefile also
  falls back to `DOTCL_PACKAGEGEN_REF_DIR` if `REF_DIR` isn't given, and re-exports whichever
  one wins so Make and the C# test suite always agree).
* `make test` fails fast with a clear error if `REF_DIR` can't be resolved at all.

# Runtime Exercise Suite

`make test-runtime` (`RuntimeExerciseTest/`, see
[`doc/plan-fable-detail-02.md`](doc/plan-fable-detail-02.md)) goes further than
either `make test`'s paren-balance check or its `--read-check` read-back: it
actually **compiles, loads, and calls** freshly-generated wrapper code against
live .NET objects. `RuntimeExerciseTest.csproj` is a sibling C# project modeled
directly on `dotcl-packagegen.csproj` itself — DotCL cross-compiles the
generated `.lisp` (produced into `RuntimeExerciseTest/gen/`, gitignored) during
`dotnet build`, exactly as a real downstream consumer (`dotcl-dungeonslime`)
does, which also permanently regression-tests ASDF-loadability. Its
`runtime-tests.lisp` is a small, self-contained assertion harness (deliberately
not `tests/framework.lisp`, which does metadata schema validation for this
repo's own Stage-1 test suite instead) covering one test per historical
runtime-dispatch escape (v48 omitted-optional-arguments, v49 overload dispatch
ordering, v50 `Nullable<T>` guards) plus breadth (Master Wrapper branches,
operators, properties/fields/indexers, events, `--defgeneric` dispatch,
generic methods, struct boxing mutation), and real-world coverage against BCL
(`TimeSpan`/`DateTime`/`StringBuilder`), MonoGame (`Vector2` — including the
documented `Normalize()` in-place mutation transcript case — `Color`, `Point`,
`Rectangle`, `MathHelper`, `GameTime`, `Input.Keys`), and Gum
(`DimensionUnitType` with GumCommon's own injected extension methods,
`KeyCombo`, `TextRuntime`'s all-defaulted v48-motivator constructor). The
MonoGame/Gum assemblies are staged from the local NuGet cache into
`RuntimeExerciseTest/refs/` (gitignored); their versions are pinned in the
`Makefile` (`MONOGAME_VER`/`GUM_VER` etc.) and must be kept in lockstep with
`RuntimeExerciseTest.csproj`'s `PackageReference` versions. Run it before any
release, or after touching overload dispatch/codegen — `make test` alone
cannot catch this bug class, since it only ever validates the *shape* of
generated code, never that calling it produces correct results.
