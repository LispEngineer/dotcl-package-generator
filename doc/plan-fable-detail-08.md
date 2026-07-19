# Detail Plan 08: De-Fragilize Tests Against .NET Version/Path Changes

**Status: DONE** — see commit 97f2c27.

* Part of the plan series from `doc/plan-fable-20260718.md` (section 3.6); addresses
  `PLAN.md`'s "Make the `AssemblyToLispy` tests less fragile" item (10.0.8 → 10.0.9
  upgrade broke tests).
* Standalone; no generated-output change → no `*generator-version*` bump.
* Estimated scope: small.

## Problem inventory (all verified in current source)

1. **`AssemblyToLispy.cs:1265`** — `AssemblyToLispyTest.AssemblyDirectory` is the
   hardcoded constant
   `"/usr/share/dotnet/packs/Microsoft.NETCore.App.Ref/10.0.9/ref/net10.0/"`
   (with the Ubuntu variant `/usr/lib/...` in a comment at lines 27/1264). Any .NET
   patch release, or running on Ubuntu, breaks `--test`.
2. **`Makefile`** — `REF_DIR = /usr/share/dotnet/packs/Microsoft.NETCore.App.Ref/10.0.9/ref/net10.0/`
   hardcodes both distro layout and patch version for the smoke test.
3. **Content fragility** — `AssemblyToLispyTest` asserts against reflected content of
   BCL assemblies (`System.Runtime`, `System.Console`), which legitimately changes
   across .NET versions. (Audit `RunTestOnAssembly` and per-assembly expectations in
   `tests/*.test.lisp` — `system-runtime.test.lisp`/`system-console.test.lisp` — for
   assertions on exact member sets vs. schema-shape validation; the schema validator
   itself is version-proof, exact-content assertions are not.)

## Design

### 1. Discover the reference-pack directory programmatically (C#)

Replace the constant with a resolver, tried in order:

1. Environment variable override `DOTCL_PACKAGEGEN_REF_DIR` (lets the Makefile and CI
   pin explicitly; also the escape hatch for unusual layouts).
2. Enumerate known pack roots — `/usr/share/dotnet/packs/Microsoft.NETCore.App.Ref/`
   (Arch), `/usr/lib/dotnet/packs/Microsoft.NETCore.App.Ref/` (Ubuntu), plus
   `$(dirname $(which dotnet))/packs/...` derived from
   `Environment.GetEnvironmentVariable("DOTNET_ROOT")` and from the running
   runtime's own location
   (`System.Runtime.InteropServices.RuntimeEnvironment.GetRuntimeDirectory()` →
   walk up to the dotnet root, then `packs/Microsoft.NETCore.App.Ref/`).
3. Within the found pack root: pick the **highest version directory whose major
   matches the running runtime's major** (`Environment.Version.Major`), then its
   `ref/netX.Y/` subdirectory. Version-sort properly (parse as `System.Version`,
   not string sort).
4. If nothing found: fail with a clear red message naming the roots searched and the
   env-var override.

Implement as `internal static string ResolveRefAssemblyDirectory()` in
`AssemblyToLispyTest` (or a small shared helper class if the Makefile-facing tool
also wants it — see next). Log the resolved path at test start so failures are
diagnosable.

### 2. Makefile

Replace the hardcoded `REF_DIR` with discovery:

```make
# Reference assembly dir: overridable, else auto-discovered (highest version
# matching the SDK major) across Arch/Ubuntu layouts.
REF_DIR ?= $(shell ls -d /usr/share/dotnet/packs/Microsoft.NETCore.App.Ref/*/ref/net*/ \
                         /usr/lib/dotnet/packs/Microsoft.NETCore.App.Ref/*/ref/net*/ 2>/dev/null \
                    | sort -V | tail -1)
```

Add a guard in the `test:` target: `@test -n "$(REF_DIR)" || (echo "REF_DIR not
found; set REF_DIR=... explicitly" >&2 && exit 1)`. Keep `?=` so
`make test REF_DIR=...` still pins. Export `DOTCL_PACKAGEGEN_REF_DIR=$(REF_DIR)` when
invoking `--test` so C# and Make agree on one directory.

Caveat to preserve: `sort -V | tail -1` may pick a *newer major* than the built
target framework (`net10.0` per the csproj). Prefer a filter on the csproj's
TargetFramework if trivially available (`grep -oP '<TargetFramework>net\K[0-9]+'`),
else document the assumption in a comment.

### 3. Reduce BCL content assertions

Audit pass over `AssemblyToLispyTest.RunTests()`/`RunTestOnAssembly` and
`tests/system-runtime.test.lisp` / `tests/system-console.test.lisp`:

* Keep: schema-shape validation (`validate-type-schema`), live-CLR semantic
  cross-checks (each documented member exists — these self-adapt to the running
  version), "reflects without throwing," counts-are-positive checks.
* Migrate: any assertion of an exact member list/count/signature on a BCL type that
  a patch release could legally change → either loosen to existence checks or move
  the exact assertion to the synthetic `AssemblyToLispyTestTarget` (add an
  equivalent fixture if the shape isn't covered there yet). List each migration in
  the commit-ready summary; if nothing qualifies (possible — the framework may
  already be shape-only), record that finding.

## Testing

* `make test` on the current machine (Arch): resolves the same directory as before,
  everything green.
* Simulate the failure mode: `DOTCL_PACKAGEGEN_REF_DIR=/nonexistent make test` fails
  with the clear message; `REF_DIR=` override works.
* If an Ubuntu machine/container is convenient, verify layout 2 — otherwise note it
  as untested-but-implemented in the summary.

## Documentation

* `Makefile` comments (the Arch/Ubuntu note becomes the discovery description).
* `CLAUDE.md`/`GEMINI.md`/`BUILD.md`: mention the env override.
* `RELEASES.md` entry; CLI `VERSION` patch bump.
* `PLAN.md`: append DONE under "Make the `AssemblyToLispy` tests less fragile".
