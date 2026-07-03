# DotCL Package Generator Revision History

* Author: Douglas P. Fields, Jr. - symbolics@lisp.engineer
* Copyright 2026 Douglas P. Fields, Jr.

This file tracks CLI-level and tool-behavior changes to `dotcl-packagegen`, keyed by the
`VERSION` in `Makefile`/`dotcl-packagegen.asd`. For the code-generation template's own version
history (the integer `*generator-version*` embedded in every emitted `.lisp` file), see
`assembly-package-generator.lisp`'s docstring and `doc/generator-design-notes.md`'s "Generator
Version History" section instead — those two numbers are independent and do not always move
together.

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
