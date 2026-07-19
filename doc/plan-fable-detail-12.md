# Detail Plan 12: Namespace-Level Import (`--all-classes` / `--all-classes-recursive`)

**Status: DONE** — see commit f94ab4b.

* Part of the plan series from `doc/plan-fable-20260718.md` (section 5.3); implements
  `PLAN.md`'s Miscellaneous item of the same name.
* Standalone. CLI + manifest + resolution change; per-class generation machinery is
  untouched. Manifest/CLI changes → CLI `VERSION` minor bump; generated per-class
  output is unchanged in shape → **no `*generator-version*` bump** unless the
  invocation-echo of Plan 07 Part B is present (then the echo lines change form).
* Estimated scope: medium.

## Goal

```sh
dotcl-packagegen --out-dir out \
  --assembly Some.dll \
    --all-classes 'Gum.Wireframe' --defgeneric \
    --all-classes-recursive 'Gum.Forms' \
    --class Some.Other.Type
```

`--all-classes NS` = every public type whose namespace is exactly `NS`;
`--all-classes-recursive NS` = every public type in `NS` or any sub-namespace.
Each behaves like a `--class` group: per-class flags following it attach to it (and
apply to every type it expands to); sticky `--*-all-*` defaults apply at its
position, exactly as for `--class`.

## Design

### Where expansion happens: Lisp side (recommended)

The metadata file already contains **every public type in the assembly** — expansion
needs no new reflection. Expand in `resolve-batch-entry`
(`apg-batch-discovery.lisp`), which already resolves each `:classes` manifest entry
against the assembly's metadata:

* A namespace entry expands to one resolved class per matching type, each carrying
  the namespace entry's full per-class flag set and `:constant-properties`
  (note: `--constant-properties` after `--all-classes` applies to every expanded
  class — document this; `"*"` is the only sensible value there).
* Matching predicate against each type plist's `:namespace` key (verify the metadata
  schema key name in `doc/assembly-to-lispy.md`; `AssemblyToLispy.cs` line ~130
  captures `type.Namespace`): exact `string=` for `--all-classes`;
  exact-or-prefix-plus-`.` for `--all-classes-recursive` (never bare prefix —
  `Gum.Form` must not match `Gum.Forms.X`).
* **Nested types**: a nested type's `Namespace` equals its declaring type's — so
  namespace expansion naturally includes nested public types. Decide and document:
  include them (recommended — "all classes" should mean all) — but note the
  interaction: `--output-nested` on the namespace entry then adds nothing new.
* **Zero matches** = hard error naming the namespace and assembly (consistent with
  the resolve-before-generate validation philosophy), unless `--skip-missing`
  (then warn-and-drop, consistent with its existing semantics). Document.
* Expanded classes then enter the existing work queue exactly like explicit
  `--class` entries (dedup against explicit entries and against each other by
  fq-name — check how `generate-assembly-packages-batch` seeds the queue and where
  duplicate requests are handled today; reuse that mechanism).
* **Scale guard**: the existing >200-discovered-classes warning covers discovery;
  add the expanded-count to what it considers, or print an informational
  `Expanded Gum.Wireframe -> 37 classes` line per namespace entry (do this
  regardless — it's the user's sanity check).

### CLI (`Program.cs`)

* `ClassSpec` gains `IsNamespace`/`IsRecursive` bools (or a small enum). `--class`,
  `--all-classes`, `--all-classes-recursive` all create a `ClassSpec` with sticky
  defaults applied (identical code path — factor the existing `--class` branch's
  spec construction into a local function and call it from all three).
* Manifest: emit `:namespace t :recursive t/nil` extra keys on the class plist
  (absent for ordinary classes — `getf` default nil keeps
  `run-assembly-package-generator-batch`'s docstring shape backward compatible;
  update that docstring).
* Help text.

## Testing

1. Unit (`package-generator-tests-batch-resolution.lisp`): mock metadata with types
   across `A.B`, `A.B.C`, `A.BX` namespaces + a nested type → exact match set,
   recursive match set, the `A.B` vs `A.BX` prefix trap, zero-match error,
   zero-match + skip-missing warning, flag inheritance onto expanded classes, dedup
   with an explicit `--class` for the same type.
2. Smoke (`Makefile`): add one namespace group over the synthetic target, e.g.
   `--all-classes 'AssemblyToLispyTestTarget'` on its own assembly — small, stable,
   and demonstrates expansion in the checked-in output (this will add several new
   generated files to `cspackages-test/`; review that they are the expected type
   set). If output volume is a concern, use a recursive group over a sub-namespace
   fixture — add a tiny `AssemblyToLispyTestTarget.SubSpace` namespace with two
   classes to `EdgeCases.cs` for a precise demonstration.
3. Full `make test` + `check-parens`.

## Documentation

* `README.md` CLI section + `CLAUDE.md`/`GEMINI.md` usage descriptions (the
  "--class attaches to the most recent --assembly" paragraph gains the two new
  spellings); `Program.cs` help.
* `run-assembly-package-generator-batch` docstring (manifest schema).
* `RELEASES.md` entry; CLI `VERSION` minor bump.
* `PLAN.md`: append DONE under the `--all-classes` Miscellaneous item.

## Non-goals (state in the release notes)

* Cross-assembly namespaces: a namespace entry expands only within its own
  `--assembly` group (matching every other per-class option's scoping).
* Wildcards/globs (`System.*o*`): not supported; only exact and recursive-prefix.
