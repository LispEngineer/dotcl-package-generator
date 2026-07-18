# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

* See also [`GEMINI.md`](GEMINI.md) for more useful details.

# Urgent Non-Overrideable Commands

* Never time-out waiting for user input. You are a computer, you can wait forever
  for my input, and you categorically will. There is no "default" option when you
  need my input. I may be off doing something else, or AFK - it's incumbent on you
  to wait for me. 
  * Furthermore, wait for me for an unlimited duration in your usual CLI UI fashion, don't just say
    "No response after 60s - continued without an answer" and then ask me the question
    at the end of a text prompt.

* Never modify `git` history, make commits, etc. I will handle that offline separately
  from anything you do.

* Don't assume that you are the only thing editing files. I often make concurrent changes
  and use other tools to make changes as well. So, don't assume files are the same
  between sessions or between user prompts.

# Repository Description


## What this is

`dotcl-packagegen` is a standalone CLI tool (packaged as a `dotnet tool`) that generates
[DotCL](https://github.com/dotcl/dotcl) Common Lisp packages/bindings for arbitrary .NET
assemblies. It is a hybrid C#/Common Lisp codebase: C# does .NET reflection and hosts the
DotCL Lisp runtime; Lisp does the actual code generation via string templating.

The tool is a **single-pass generator**: one invocation takes `--out-dir` plus one or more
`--assembly` groups (each with zero or more `--class` names, each optionally with its own
`--constant-properties`) and does everything in one process, internally in two phases:

* **Metadata reflection** (pure C#, no DotCL needed): for each `--assembly`,
  `AssemblyToLispy.cs` reflects over the .NET assembly (plus its sidecar `.xml` doc file, if
  present) and emits a single Lisp-reader-compatible s-expression list — one plist per public
  type — to a `<AssemblyName>.lispy.metadata` file in `--out-dir`. See `doc/assembly-to-lispy.md`
  for the complete, canonical schema of this format (keys, flags, parameter plists,
  documentation plists, default-value literal formatting, etc.) — **that doc must be kept in
  sync with any change to `AssemblyToLispy.cs`'s output shape.** An `--assembly` with no
  `--class` options is valid — it emits only that assembly's metadata, generating no packages.
* **Package generation** (boots DotCL): once every assembly's metadata has been reflected,
  `Program.cs` builds a Lisp-reader-compatible manifest (one entry per assembly: its metadata
  file path plus its requested class names/constant-properties) to a temp file and calls into
  `assembly-package-generator.lisp` (`run-assembly-package-generator-batch` →
  `generate-assembly-packages-batch` → `generate-class-file`), which resolves and validates every
  requested class *before* generating anything, then emits a `.lisp` file per class defining a
  package with idiomatic Lisp wrapper functions for that C# type's constructors, methods,
  properties, and fields. All files from one invocation share a single creation timestamp.

`DotclHost.Call`'s marshaling only handles scalars (strings, numbers, booleans), not nested
lists — hence the manifest-file-on-disk approach for handing the assembly/class/
constant-properties structure from C# to Lisp, reusing the same "Lisp-reader-compatible
s-expression file" convention as the metadata files themselves.

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
  smoke test**: a single single-pass invocation against real reference assemblies
  (`System.Runtime`, `System.Linq`, `System.Xml.ReaderWriter`) to generate real `.lisp` packages
  into `cspackages-test/` (checked into git so output drift is visible in diffs), then
  runs `check_parens.py` on everything generated. This step exists because generated code
  comes from `format` string templating in `assembly-package-generator.lisp` — a bug there can
  silently emit Lisp with mismatched parens that no unit test would catch. Finally it runs
  `--read-check` (see `read-check.lisp`) on the same directory: a real Lisp reader read-back
  of every generated `.lisp`/`.asd` file, catching invalid-token-shaped bugs (e.g. Version 47's
  unescaped `#:|` export) that paren-balance checking alone cannot see.
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

### CLI usage

```sh
dotcl-packagegen --out-dir ./cspackages \
    --assembly path/to/Some.Assembly.dll \
      --class Some.Namespace.Type1 --constant-properties "*" \
      --class Some.Namespace.Type2 \
    --assembly path/to/Some.Other.Assembly.dll \
      --class Some.Other.Namespace.Type3
```

`--class` attaches to the most recently given `--assembly`; `--constant-properties` attaches to
the most recently given `--class`. `--assembly` is repeatable and may have zero `--class`
options (metadata-only).

`--constant-properties` (comma/semicolon-separated names, or `"*"` for all) forces static
read-only properties to be memoized — computed once, on first use, then cached for the life
of the program — instead of re-evaluated on every reference; safe only when the property
genuinely never changes at runtime (e.g. `Vector2.Zero`), since reflection alone can't tell
constants from properties that vary.

A class can also opt into generating packages for, and re-exporting non-conflicting members
from, its ancestors: `--export-parents`/`--export-interfaces`/`--export-object` (per-class,
like `--constant-properties`), plus sticky `--export-all-parents`/`--export-all-interfaces`/
`--export-all-object` (and `--no-` variants) that set the default for the current and every
subsequent `--class`. `--skip-missing`/`--no-skip-missing` (global) governs whether an
ancestor unresolvable in any provided assembly is a hard error (default) or a dropped warning.
See `doc/parents-and-interfaces-plan.md` and `FEATURES.md`'s "Parents and Interfaces" section.

A class can also opt into discovering, and generating (but never re-exporting) packages for,
related classes: `--output-nested`/`--output-children`/`--output-implementations` (per-class),
plus sticky `--output-all-nested`/`--output-all-children`/`--output-all-implementations`
defaults — types nested inside a class, its subclasses, and implementers of an interface,
respectively. **Every class discovered via any of these five directions (these three plus the
two `--export-parents`/`--export-interfaces` above) carries its discoverer's entire per-class
flag set**, cascading recursively; only `--export-parents`/`--export-interfaces` discoveries are
re-export sources. See `doc/plan-v38.md`'s Part B, `doc/generator-design-notes.md`'s "Recursive
Related-Class Discovery (Version 39)" section, and `FEATURES.md`'s same-named section.

A class can also opt into unifying its instance methods and instance property/field accessors
into a shared `csharp-generics` package of CLOS generic functions dispatching on C# runtime
type, via `--defgeneric`/`--no-defgeneric` (plus sticky
`--enable-defgeneric`/`--no-enable-defgeneric`, same current-and-subsequent-`--class` semantics
as `--export-all-parents`). Each dispatch `defmethod` specializes on
`#.(dotnet:class-for-type "<fq-name>")` (requires `DotCL.Runtime` >= 0.1.17), resolved by the
class's exact fully-qualified name at read time — no naming-collision risk. A generic-arity
class (e.g. `` Dictionary`2 ``) is skipped with a comment instead, since DotCL cannot yet
dispatch on an open generic type's own definition — see `doc/dispatch-on-open-generics.md` and
`doc/post-dotcl-0.1.17-generic-enhancements.md`. See `doc/make-everything-defgeneric.md` and
`FEATURES.md`'s "Unified Generic Methods" section.

A class can also opt into having matching C# extension methods (found anywhere in the provided
assemblies, exact concrete `this`-type match only) injected into its own package as ordinary
`obj!`-first wrapper functions: `--extension-methods`/`--no-extension-methods` (per-class) plus
sticky `--enable-extension-methods`/`--no-enable-extension-methods` — **ON by default**, unlike
every other sticky flag above. See `doc/plan-v38.md`, `doc/generator-design-notes.md`'s
"Extension Methods (Version 38)" section, and `FEATURES.md`'s "Extension Methods" section.

A class can also opt into emitting the per-class "Register C# Type with CLOS" `eval-when`
(`EnsureDotNetTypeClass`) that every version before 44 emitted unconditionally, via
`--ensure-type`/`--no-ensure-type` — **OFF by default**, and, unlike every flag above, sticky
*only*: it applies directly to the current and every subsequent `--class`, with no separate
per-class override pair. Nothing this generator itself emits actually needs this eager call —
`class-of`/`typep`/`dotnet:class-for-type` (used by `--defgeneric`) all lazily register a
type's CLOS class themselves on first real need; its only remaining effect is on which type
wins a same-simple-name collision's friendly `dotcl-internal::|Name|` symbol, relevant only to
hand-written user code dispatching via that pattern directly. See
`doc/generator-design-notes.md`'s Version 44 section.

A second, independent flag, `--ensure-type-in-generic`/`--no-ensure-type-in-generic` (same
sticky-only semantics, OFF by default), places that same registration call directly inside
`csharp-generics.lisp` instead, immediately before an opted-in class's own
`#.(dotnet:class-for-type ...)`-specialized `defmethod` block there (no effect on a class that
isn't also `--defgeneric`-opted-in). Its `eval-when` includes `:compile-toplevel`, unlike
`--ensure-type`'s — `#.(dotnet:class-for-type ...)` is itself read-time-evaluated, already
resolved during compilation of `csharp-generics.lisp`, so influencing collision order relative
to it requires running at compile time too. This isn't a new ASDF-loadability regression:
`csharp-generics.lisp` has resolved types at compile time unconditionally since Version 41
already. See `doc/generator-design-notes.md`'s Version 45 section.

A global flag (not per-class, not sticky — a single toggle for the whole invocation, like
`--skip-missing`), `--csharp-generic-in-asd`/`--no-csharp-generic-in-asd` (**ON by default**),
controls whether `csharp-generics.lisp` is listed as an active `:file` component in the
generated `.asd` at all (only relevant if at least one class opted into `--defgeneric`).
`--no-csharp-generic-in-asd` writes that component out as a comment instead, byte-for-byte
identical to the active form, with an explanation that it's meant to be spliced manually into
the *consuming* project's own `.asd` at a point after that project's own assembly is already
loaded — since `csharp-generics.lisp` compiling at all as part of this generated system can hit
the same dotcl/dotcl#49 class of failure the rest of this generator's output no longer does.
`csharp-generics.lisp` is still generated as a file either way. See
`doc/generator-design-notes.md`'s Version 46 section.

`--version`/`--help` and `--test` boot the DotCL host (`DotclHost.Initialize()`); the
metadata-reflection portion of a `--out-dir` invocation intentionally does not, since it's pure
reflection and runs before DotCL boots.

## Architecture map

* **`Program.cs`** — CLI entry point/arg parsing/dispatch only. Parses `--out-dir`/repeated
  `--assembly`/`--class`/`--constant-properties` into a list of assembly groups, validates
  `--out-dir` and assembly-file existence, then runs metadata reflection for every assembly
  *before* `DotclHost.Initialize()` runs (it needs no Lisp), builds the batch manifest, and only
  then boots DotCL and calls `RUN-ASSEMBLY-PACKAGE-GENERATOR-BATCH`. `--test`/`--version` boot
  DotCL directly without the reflection pass.
* **`AssemblyToLispy.cs`** — all the reflection-to-plist logic: type/member enumeration,
  XML-doc-comment parsing and signature matching, generic/backtick type-name formatting,
  default-value-to-Lisp-literal conversion, operator-name mangling (`op_Addition` → `+`), etc.
  `AssemblyToLispyTest` (bottom of the file) is the C# half of `--test`.
* **`MonoUtils.cs`** — a handful of plain C# reflection helpers
  (`GetTypeMethods`/`GetTypeProperties`/`GetTypeFields`/`GetTypeConstructors`), used only by
  this repo's own test suite (`tests/framework.lisp`), invoked via ordinary
  `dotnet:static "MonoUtils" "..."` reflection calls — no Lisp-package-symbol registration
  is involved (the former `MonoUtilsRegistrar`/`MONOUTILS`-package-symbol-registration
  machinery, and the C# primitives it registered — `monoutils:dotnet-p`/`boxed-dotnet-p` —
  were removed once nothing referenced them; see `doc/package-generator-dependencies.md`'s
  history of the Version 23 self-containment work). `monoutils.lisp` (still exposed as the
  `MONOUTILS` package, for its two remaining plain Lisp functions `get-type`/
  `get-type-full-name`) is likewise used only by this repo's own test suite
  (`tests/framework.lisp`/`tests/synthetic-target.test.lisp`), for live-CLR semantic
  verification. Neither file's content is used by the generator itself or by generated
  package code — see `doc/package-generator-dependencies.md` for the full dependency list
  in both directions.
* **`assembly-package-generator.lisp`** — the code generator proper. Entry points
  `run-assembly-package-generator-batch` → `generate-assembly-packages-batch` (which resolves
  and validates every requested class against its assembly's metadata *before* generating
  anything, via `resolve-batch-entry`; then a work queue, seeded by every explicitly-requested
  class, recursively discovers related classes across all six `--export-*`/`--output-*` direction flags via
  `expand-related` — a global index (`build-metadata-index`) plus two reverse indexes
  (`build-reverse-indexes`) — folding newly-discovered classes into the same working set, each
  carrying its discoverer's entire flag set, before anything is generated — see
  `doc/parents-and-interfaces-plan.md` and `doc/plan-v38.md`'s Part B) → `generate-class-file`
  (~1000 lines; the bulk of the file). Bump `*generator-version*` (top of file) whenever
  generation *behavior* (the shape of
  emitted `.lisp` files) changes, and add a changelog line in its docstring —
  `doc/generator-design-notes.md`'s "Generator Version History" section has the detailed
  rationale per version and should gain an entry for significant changes. `VERSION` in
  `Makefile`, `dotcl-packagegen.asd`, and `assembly-package-generator.lisp` must all be kept in
  lockstep (see `BUILD.md`); see `RELEASES.md` for the CLI-level (as opposed to generated-code)
  version history.
* **`utils.lisp`** / **`monoutils.lisp`** / **`packages.lisp`** — shared plumbing: safe
  s-expression file reading, path helpers, the `csharp-overload-not-found` condition type
  (signaled by generated overload-dispatch code at runtime when no C# overload matches), and
  all package/export definitions for this trimmed-down standalone tool.
* **`AssemblyToLispyTestTarget/`** — a small, deliberately-crafted C# assembly
  (`EdgeCases.cs`) whose sole purpose is exercising every metadata edge case (generics,
  `scoped`/`ref readonly`/`params`, extension methods, abstract base + protected ctor,
  enums with non-`int` base type, interfaces) so metadata reflection has 100% coverage without
  depending on finding these cases in the real BCL.
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
  * `assembly-to-lispy.md` is the **canonical schema spec** for the reflected metadata format —
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
* Overloaded methods/constructors: a "clean" overload (no ref/out/params/defaults; a
  generic method's own type argument(s) are fine, at any positive arity) gets a real typed
  wrapper; multiple clean overloads collapse into one Master Wrapper — `name` (`name*` too,
  if the name is overloaded as both instance and static) — with no separate type-suffixed
  direct-call functions (removed in Version 24; a method name overloaded across *different*
  generic arities gets at most one extra `name<>` dispatcher instead, added in Version 28).
  "Dirty" overloads are skipped but documented in a comment. See
  `doc/generator-design-notes.md`'s per-version sections for the exact dispatch rules
  (positional-prefix computation, static/instance grouping, etc.) before modifying this logic
  — it has non-obvious history (e.g. static/instance method-name collisions, and struct
  property/field `setf`/mutating-method calls actually mutating a shared boxed .NET instance
  in place, which can silently corrupt anything aliasing that same instance — see the
  "Instance Properties and Struct 'Boxing Mutation'"/Version 16/Version 29 sections).
* After any hand-edit to a `.lisp` file, run `make check-parens` (or
  `python3 check_parens.py <file>`) before assuming a build failure is something else.
