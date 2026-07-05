# Parents and Interfaces Re-Export — Implementation Plan

* Author: (design) — for implementation by a later session
* Status: APPROVED-FOR-IMPLEMENTATION (not yet implemented)
* Related: `PLAN.md` "Parents and Interfaces" section (the original idea sketch)

Locked design decisions:
1. Re-export via a **post-pass of `import`/`shadowing-import` + `export` calls**
   at the bottom of `packages.lisp` — **no topological sort**.
2. Interface name-collision handling: **skip-with-comment first**; the
   `interface->name` rename idea is deferred to a later version.

## Context

Today the generator reflects members with `BindingFlags.DeclaredOnly`
(`AssemblyToLispy.cs:142,158,170,182` and the constructor query at line 135), so a
generated class package contains **only the members the class declares itself** —
none inherited from base classes or interfaces. A user of, say, a generated
`derived` package cannot call an inherited base-class method through it; they must
separately know about, request, and reach into the base class's own package.

This feature lets the user opt in (per class, or via sticky CLI defaults) to:
* **generating packages for a class's ancestors** (super-classes and/or
  interfaces), and
* **re-exporting those ancestors' non-conflicting member wrappers into the child
  package**, so inherited members are usable directly as `child:some-inherited-method`.

The metadata already carries the inheritance graph: each type plist has
`:superclass` (the *immediate* base's fully-qualified name, or `nil`) and
`:interfaces` (an alphabetized list of FQ names). Because .NET's `GetInterfaces()`
is transitive, `:interfaces` is already fully flattened (interfaces-of-interfaces
included); only the class chain (`:superclass`) must be walked link-by-link up to
`System.Object`.

## Design Overview

Five moving parts:

1. **CLI flags** (`Program.cs`) — per-class opt-in plus sticky defaults, carried
   into the manifest.
2. **Global type index + ancestor expansion** (new Lisp pass) — resolve ancestors
   across *all* provided assemblies, dedupe, and add them to the working set.
3. **Re-export computation** (new Lisp function) — decide, per child, which
   ancestor symbols to re-export and which to skip (conflicts/ambiguity).
4. **Re-export emission** (`generate-batch-packages-file` + `.asd`) — post-pass
   `import`/`shadowing-import` + `export` calls after all `defpackage` forms; add
   ancestor packages to each child's `.asd` `:depends-on`.
5. **Docs / versioning / tests.**

Re-export is done as **selective `import` + `export`**, never `:use`, and every
`defpackage` form stays self-only (own symbols exactly as today). A separate block
of function calls at the very bottom of `packages.lisp`, emitted *after* all
`defpackage` forms, performs the re-exports. This removes any need to topologically
order the `defpackage` forms. Runtime load order (a re-exported symbol's function
must be `fboundp` before a caller uses it) is enforced by ASDF `:depends-on` edges
in the generated `.asd`, not by file order.

### Why not `:use` and why not topo sort

`:use`-ing ancestor packages would collide with `:cl`, with the child's own
symbols, and with each other, forcing wholesale shadowing. Selective
`import`/`export` skips conflicts cleanly and matches the "don't re-export
conflicting names" rule directly. And because all re-export happens as function
calls *after* every package already exists, intra-file `defpackage` order is
irrelevant — no topological sort.

## Phase 1 — CLI surface (`Program.cs`)

Current arg parsing (`Program.cs:24-59`) tracks `currentClass : ClassSpec?` and
attaches `--class`/`--constant-properties`. `ClassSpec` (line 294) has `Name` +
`ConstantProperties`.

Add:

* **Per-class flags** (attach to the most-recent `--class`, like
  `--constant-properties`): `--export-parents`, `--export-interfaces`,
  `--export-object`. Each sets a bool on the current `ClassSpec`; error (as
  `--constant-properties` does at line 55-59) if given before any `--class`.
* **Sticky default flags** (change the default for the current *and subsequent*
  classes, in CLI order — mirror `PLAN.md` lines 53-56):
  `--export-all-parents` / `--no-export-all-parents`,
  `--export-all-interfaces` / `--no-export-all-interfaces`,
  `--export-all-object` / `--no-export-all-object`. Maintain three sticky bools in
  the parse loop; when a new `--class` is created, seed its three per-class bools
  from the current sticky values. An explicit per-class `--export-parents` etc.
  overrides the sticky default for that one class (set the bool `true`
  regardless). (No explicit per-class "off" flag is required for the first cut,
  since sticky-off + omitting the per-class flag already yields off; note this in
  docs.)
* **Missing-parent policy:** `--skip-missing` / `--no-skip-missing` (global,
  last-one-wins; default = do NOT skip → a missing ancestor is a hard error, per
  `PLAN.md` lines 19-22). Store as one global bool passed through to Lisp.

`ClassSpec` gains: `bool ExportParents, ExportInterfaces, ExportObject`.

**Manifest emission** (`Program.cs:110-139`): add the three per-class booleans to
each `:classes` entry, and the global skip-missing flag at top level. New manifest
shape:

```
((:metadata-file "..." :assembly-name "..."
  :classes ((:name "..." :constant-properties "..."
             :export-parents t :export-interfaces nil :export-object nil) ...))
 ...
 ;; plus a top-level :skip-missing t/nil — see note below on placement)
```

Emit booleans as Lisp `t` / `nil` (bare, unquoted). For `:skip-missing`: simplest
is to thread it as a separate scalar argument to
`RUN-ASSEMBLY-PACKAGE-GENERATOR-BATCH` (alongside `outDir`, `creationTime`,
`cliVersion`) rather than embedding in the manifest list, since `DotclHost.Call`
marshals scalars fine and it's a single global flag. Update the `DotclHost.Call`
site (`Program.cs:156`) and the Lisp entry point signature accordingly.

Update `--help` output (`Program.cs:253-286`) with all new flags.

## Phase 2 — Global type index + ancestor expansion (Lisp)

Location: `assembly-package-generator.lisp`, feeding into
`generate-assembly-packages-batch` (line 1920). Preserve the existing
resolve-and-validate-everything-*before*-generating contract.

**2a. Build a global type index.** Today `resolve-batch-entry` (line 1781) loads
one assembly's metadata and resolves only that entry's classes against it. Add a
step that loads **every** entry's `:metadata-file` once and builds a lookup:
`fully-qualified-name (string) -> (values type-plist assembly-name)`. A hash table
keyed on FQ name. Reuse `utils:safe-read-form-from-file` (already used at line
1792). Guard against a metadata file appearing in two entries (load each distinct
file once).

**2b. Compute the ancestor closure per requested class.** New function, e.g.
`expand-ancestors (class-plist flags index) -> list of (type-plist assembly-name kind)`:
* If `:export-parents`: walk `:superclass` FQ names via the index, link by link,
  up the chain. Stop at `System.Object` — include it **only if** `:export-object`.
  A `nil`/absent `:superclass` ends the walk.
* If `:export-interfaces`: take the class's `:interfaces` list (already transitive)
  and resolve each via the index.
* Recurse: an included ancestor's own parents/interfaces are expanded under the
  *same* flags (so a grandparent's members can reach the child). Use a visited-set
  to terminate on cycles / diamonds (interfaces form a DAG).
* Any ancestor FQ name **not found in the index** (missing assembly, or an
  unresolvable open-generic base such as `System.Collections.Generic.List\`1`) is
  collected into a `missing` list.

**2c. Missing-ancestor policy.** After expanding all requested classes: if
`missing` is non-empty and `skip-missing` is false → print each in red
(`utils:format-red`, as done at line 1949) and `error` out (stop before generating
anything, matching the existing not-found behavior at lines 1947-1950). If
`skip-missing` is true → warn once per missing ancestor and drop it (re-export only
resolves what was found).

**2d. Dedupe into the working set.** A class may be both explicitly requested (with
its own `--constant-properties` and/or export flags) *and* pulled in as an ancestor
of another class, or shared as an ancestor of two children. Dedupe by
**(assembly-name, fully-qualified-name)**, preferring an explicit request's flags
and `--constant-properties` over an ancestor-induced entry (which has empty
constant-properties and no onward export flags unless it too was explicitly
requested). Ancestors are generated as **plain packages** (their own members only) —
they do not themselves re-export *their* ancestors unless separately requested;
the recursion in 2b already flattened everything each child needs.

**2e. Thread results into existing structures.** `generate-assembly-packages-batch`
builds `entries-with-resolved` (list of `(entry . resolved)`, where `resolved` is a
list of `(class-plist . constant-properties-list)`) and `all-resolved`. Ancestors
must land in these so `generate-batch-packages-file`,
`generate-batch-utils-file`, per-class `generate-class-file`, and
`generate-batch-asd-file` all pick them up unchanged. Concretely: after expansion,
insert each newly-added ancestor into the `resolved` list of the entry whose
`:assembly-name` matches the ancestor's home assembly (so the `.asd` groups it with
its real assembly). Keep command-line order stable for the originally-requested
classes; append newly-pulled-in ancestors after the explicitly-requested classes
of their assembly (stable, minimal reordering — satisfies `PLAN.md` lines 26-27
without a sort).

Additionally, retain a **child → resolved-ancestor-plists** map (built during 2b)
for Phases 3-4; the re-export pass needs to know, per child, exactly which ancestor
packages feed it.

## Phase 3 — Re-export computation (Lisp)

New function `compute-reexports (child-plist child-cprops ancestor-specs)` where
`ancestor-specs` is the child's resolved ancestor list (each with its plist +
its own constant-properties, which for a pulled-in ancestor is typically empty).

Returns a structure describing, for this child: a list of
`(source-package-name symbol-string needs-shadowing-import-p)` to re-export, plus a
list of skipped `(symbol-string reason)` for comment emission.

Algorithm:
1. Compute the child's own exports+shadows via the existing
   `compute-package-exports-and-shadows` (line 1209). Call the child's export set
   `CHILD-EXPORTS`.
2. For each ancestor, compute *its* exports+shadows the same way (reuse the same
   function — do not reimplement member walking). This yields, per ancestor, the
   set of symbol names it exports and which of those it shadows (i.e. are CL-named).
3. **Exclude the synthetic per-type symbols** from every ancestor's export set
   before considering re-export: `<type>`, `<type-str>`, `<creation>`,
   `<version>`, and `new`. These are type-identity-specific and must never be
   re-exported. (They are pushed unconditionally at lines 1263-1270.)
4. Build a tally across all ancestors: for each candidate symbol name, record which
   ancestor package(s) export it.
5. Decide per candidate symbol:
   * If the name is in `CHILD-EXPORTS` → **skip** (child declares its own; child
     wins; reason `"overridden/shadowed by child's own member"`). This is where a
     later Phase 5 could refine the comment using virtual/override metadata.
   * Else if exported by **more than one** ancestor → **skip** (ambiguous;
     reason `"defined in multiple ancestors: <pkgs>"`). This is the
     skip-with-comment path for the multi-interface-same-name case; the
     `interface->name` rename is explicitly deferred.
   * Else (exactly one ancestor exports it, child does not) → **re-export**.
     `needs-shadowing-import-p` is true iff that symbol name is a CL symbol name
     (i.e. it appears in the ancestor's shadow set — reuse the same
     CL-conflict detection `compute-package-exports-and-shadows` already applies;
     do not hand-roll a CL-symbol test).

Note on `--export-interfaces`: because a class already declares public wrappers for
every interface member it implements, those names are in `CHILD-EXPORTS` and will
be skipped here — so re-export from interface packages is usually a no-op. That is
expected; the value of `--export-interfaces` is generating the interface packages
themselves. Call this out in the generated comment and in the docs so it does not
read as a bug.

## Phase 4 — Emit re-exports (`generate-batch-packages-file` + `.asd`)

**4a. `generate-batch-packages-file` (line 1805).** Leave every `defpackage` form
exactly as today (self-only). After the loop that emits all `defpackage` forms,
emit a **re-export post-pass** section:

```lisp
;;; ===== Re-exports from parent/interface packages =====

;;; child-pkg: re-exports inherited members from ancestor-pkg-a, ancestor-pkg-b
;;; Skipped (child declares its own): foo, bar
;;; Skipped (ambiguous across ancestors): baz  [from iface-x, iface-y]
(cl:shadowing-import '(ancestor-pkg-a::length ...) ':child-pkg)
(cl:import '(ancestor-pkg-a::some-method ancestor-pkg-b::other-method ...) ':child-pkg)
(cl:export '(some-method other-method length ...) ':child-pkg)
```

Details:
* Iterate children in the same stable command-line order used elsewhere.
* Split re-exported symbols into the `shadowing-import` group
  (`needs-shadowing-import-p` true) and the plain `import` group; emit the two
  calls (omit either if empty). Then one `export` naming all re-exported symbol
  names (bare names, since after import they are interned in the child).
* Reference ancestor symbols with the `pkg::name` double-colon internal syntax in
  the `import`/`shadowing-import` source lists (they are external in the ancestor,
  so `pkg:name` also works; `::` is safe and uniform).
* Emit the skip comments so the output documents what was intentionally not
  re-exported (mirrors the existing "dirty overload"/"unsupported indexer"
  commenting convention).
* Qualify every operator with `cl:` (`cl:import`, `cl:export`,
  `cl:shadowing-import`) per the repo convention (CLAUDE.md "Generated Lisp
  templates qualify standard CL operators with `cl:`").

**4b. `.asd` dependencies (`generate-batch-asd-file`, line 1865).** Currently every
class `:file` depends on `("packages" "csharp-assembly-utils")` (line 1916). For a
child that re-exports from ancestors, add each ancestor's package file name
(`type-fq-name-to-pkg-name` of the ancestor FQ name) to that child's
`:depends-on`, so ASDF loads ancestor class files (defining the actual functions)
before the child's — guaranteeing the re-exported symbols are `fboundp` for any
caller. Ancestor `.lisp` files are already emitted as components because ancestors
are now in the working set (Phase 2e).

**4c. No change** to `generate-class-file` (line ~1200-1780) or
`generate-batch-utils-file` — ancestors generate as ordinary class packages, and
the child's own body is unchanged (re-export is purely package-level symbol
plumbing, no new function bodies in the child).

## Phase 5 — (Deferred / optional) shadow-comment fidelity

`PLAN.md` lines 40-43 want a comment when a child's **non-virtual** member shadows a
parent's. That needs new metadata: `MethodInfo.IsVirtual` and override/new-slot
detection (`GetBaseDefinition()`) in `AssemblyToLispy.cs`, surfaced as e.g.
`:virtual t` / `:new-slot t` flags, plus a `doc/assembly-to-lispy.md` schema
update. Re-export correctness does **not** depend on this — it only enriches the
skip comment in Phase 3 step 5. Implement as a follow-up version after Phases 1-4
ship.

## Phase 6 — Docs, versioning, tests

* **Version bump:** increment `*generator-version*` source is
  `dotcl-packagegen.asd`'s `:version` (read at `assembly-package-generator.lisp:24-27`);
  bump `VERSION` in `Makefile`, `dotcl-packagegen.asd`, and confirm the generator
  picks it up. Add a changelog line to the `*generator-version*` docstring
  (lines 34-67) and a detailed section in `doc/generator-design-notes.md`'s
  "Generator Version History".
* **Schema doc:** no change for Phases 1-4 (no new metadata). Phase 5 would update
  `doc/assembly-to-lispy.md`.
* **CLI docs:** update `Program.cs` `--help` (lines 253-286), plus `README.md`,
  `FEATURES.md`, and the CLAUDE.md/`GEMINI.md` CLI-usage blurbs.
* **Dependency doc:** note in `doc/package-generator-dependencies.md` that generated
  output now uses `cl:import`/`cl:shadowing-import`/`cl:export` (all standard CL,
  no new external deps).
* **Tests:**
  * Add a `tests/*.test.lisp` (or reuse `AssemblyToLispyTestTarget`'s
    `EdgeCases.cs`, which already has "abstract base + protected ctor" and
    interfaces) exercising a class with a known base + interface, asserting the
    generated `packages.lisp` re-export block imports the expected inherited
    symbols and skips the expected conflicts.
  * Extend `make test`'s end-to-end smoke step to include at least one
    `--export-parents`/`--export-interfaces` invocation, so `cspackages-test/`
    gains checked-in re-export output (diff visibility), and re-run
    `check_parens.py` over it (already part of `make test`).
  * Run `make check-parens` after any hand-edit; run `make build test`.

## Files to touch (summary)

* `Program.cs` — arg parsing (`~24-59`), `ClassSpec` (`~294`), manifest emission
  (`~110-139`), `DotclHost.Call` site (`~156`), `--help` (`~253-286`).
* `assembly-package-generator.lisp` — new global-index + `expand-ancestors` +
  `compute-reexports` functions; changes to `generate-assembly-packages-batch`
  (`1920`), `generate-batch-packages-file` (`1805`), `generate-batch-asd-file`
  (`1865`), and the batch entry point `run-assembly-package-generator-batch`
  (`1965`, new skip-missing arg); reuse `compute-package-exports-and-shadows`
  (`1209`), `type-fq-name-to-pkg-name` (`93`), `utils:safe-read-form-from-file`,
  `utils:format-red`.
* Version/docs: `dotcl-packagegen.asd`, `Makefile`, `doc/generator-design-notes.md`,
  `doc/package-generator-dependencies.md`, `README.md`, `FEATURES.md`, CLAUDE.md,
  GEMINI.md.
* Tests: a new/updated `tests/*.test.lisp`; `make test` smoke-step invocation;
  `cspackages-test/` regenerated output.
* `PLAN.md` — append a reference line pointing to this doc (do not rewrite the
  existing "Parents and Interfaces" section).

## Verification

1. `make build` — compiles C# host + cross-compiles Lisp.
2. `make check-parens` — after any hand-edit to `.lisp`.
3. `make test` — runs the Lisp + C# unit suites, the new re-export test, and the
   end-to-end smoke generation (now including an `--export-parents` invocation),
   finishing with `check_parens.py` over all generated output.
4. Manual end-to-end: run the built tool against a real assembly with a class that
   has a base class + interfaces, with `--export-parents --export-interfaces`, and
   confirm in the generated `packages.lisp`:
   * ancestor packages have their own `defpackage` forms,
   * a re-export post-pass block appears after all `defpackage` forms,
   * inherited members are imported+exported into the child,
   * conflicting/ambiguous names are skipped with explanatory comments,
   * the generated `.asd` lists ancestor files in each child's `:depends-on`.
   Then load the generated system in a DotCL REPL and call an inherited method
   through the child package (`child:some-inherited-method`) to confirm it resolves
   to the ancestor's function at runtime.
5. Missing-ancestor behavior: run with an `--export-parents` class whose base lives
   in an assembly not passed on the command line; confirm it errors and stops by
   default, and that adding `--skip-missing` downgrades to a warning + drops the
   ancestor.
