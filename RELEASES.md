# DotCL Package Generator Release Notes

* Author: Douglas P. Fields, Jr. - symbolics@lisp.engineer
* Copyright 2026 Douglas P. Fields, Jr.

This file tracks CLI-level and tool-behavior changes to `dotcl-packagegen`, keyed by the
`VERSION` in `Makefile`/`dotcl-packagegen.asd`. For the code-generation template's own version
history (the integer `*generator-version*` embedded in every emitted `.lisp` file), see
`assembly-package-generator.lisp`'s docstring and `doc/generator-design-notes.md`'s "Generator
Version History" section instead — those two numbers are independent and do not always move
together.

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
