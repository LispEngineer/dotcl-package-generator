# Extension Methods & Recursive Related-Class Discovery — Implementation Plan (v38 / v39)

* Author: (design) — for implementation by a later session (Sonnet Medium)
* Copyright 2026 Douglas P. Fields, Jr.
* Status: APPROVED-FOR-IMPLEMENTATION (not yet implemented)
* Related:
  * `PLAN.md` — "Handle Extension Methods in the Main Class" and "More Parent &
    Ancestor stuff" sections (the original idea sketches this doc realizes).
  * `doc/parents-and-interfaces-plan.md` — the v33 parents/interfaces feature
    this plan's Part B generalizes.
  * `doc/assembly-to-lispy.md` — the metadata schema. **No metadata schema
    changes are required by either part of this plan**; both reuse metadata
    that already exists (`:extension-method`/`:extension-this` for Part A;
    `:superclass`/`:interfaces`/`:nested`/`+`-separated FQ names for Part B).

## Overview

Two independent features, landed as two staged generator versions in one plan
doc. Each is independently buildable and testable; implement and ship Part A
first, then Part B.

* **Part A — Extension Methods (generator version 38).** For each generated
  class, find C# extension methods across the provided assemblies whose `this`
  parameter type is exactly that class, and inject them into the class's own
  package as instance-style (`obj!`-first) wrapper functions, so a user can call
  `some-class:some-extension obj! args...` directly.

* **Part B — Recursive Related-Class Discovery (generator version 39).**
  Generalize the v33 parents/interfaces ancestor-expansion into a recursive,
  multi-direction closure that also discovers **nested types**, **subclasses**,
  and **interface implementations**, adding every discovered type to the batch
  as its own package. Discovered classes **carry the anchor's flags recursively**
  (they keep discovering / re-exporting under the same options). The new
  downward directions never modify the anchor's own package — they only grow the
  set of packages generated.

Both parts reuse the existing global metadata index (`build-metadata-index`,
`assembly-package-generator.lisp:1994` — since split into the `apg-*.lisp` modules, this lives
in `apg-batch-discovery.lisp`; line numbers throughout this plan are historical, referring to
the pre-split monolith) and require **no `AssemblyToLispy.cs` output-shape change**.

## Locked design decisions (from requirements Q&A)

1. **Extension enablement:** per-class `--extension-methods` /
   `--no-extension-methods` plus sticky `--enable-extension-methods` /
   `--no-enable-extension-methods`, mirroring the parents/defgeneric flag pattern
   **but with the sticky default initialized ON** (a deliberate divergence from
   the other features' off-by-default). Existing `cspackages-test/` smoke output
   may change as a result — that is expected and gives diff visibility.
2. **Extension matching (v1):** inject an extension method into class `C` **only**
   when the extension method's `this` parameter type FQ-name is `string=` to
   `C`'s `:fully-qualified-name`. Open-generic `this` types (LINQ's
   `` IEnumerable`1[TSource] ``) and base-class/interface matching are **out of
   scope for v1** and are called out in "Deferred / Future" for later expansion.
3. **Downward directions (nested/children/implementations):** discovered classes
   are **added to the generation working set as their own packages only**. The
   anchor class's package is **never modified** — it is purely a discovery seed.
   `compute-reexports`/`emit-child-reexports` are **not** used for these
   directions. (This is in deliberate contrast to `--export-parents`/
   `--export-interfaces`, which re-export ancestor members *up into* the
   requesting class — that established v33 behavior is unchanged.)
4. **Flag propagation:** **recursive**. Every discovered class (via any
   direction, upward or downward) is processed as if the user had requested it
   with the **same per-class boolean flags the anchor carried**, so discovery and
   re-export cascade transitively through the whole connected component the
   anchor's flags reach. Constant-properties are **not** propagated (they name
   specific properties of one class). An explicitly requested class always keeps
   its own explicit flags + constant-properties (dedup preference, as today).

---

# Part A — Extension Methods (generator version 38)

## A.0 What is generated, and the matching/skip rules

A C# extension method is a `static` method, on a `static` class, whose first
parameter is the `this` parameter. In the metadata it appears in the holder
type's `:methods` list as `:is-static t :extension-method t`, with the first
parameter carrying `:extension-this t`. Example (from
`AssemblyToLispyTestTarget/EdgeCases.cs`): `DummyExtension(this object obj, int
value)` on a static holder class, whose `:extension-this` parameter `:type` is
`"System.Object"`.

Semantically `obj.DummyExtension(5)` is a call to the *extended* type; in CIL /
reflection it is the static call `Holder.DummyExtension(obj, 5)`. So the injected
wrapper takes the receiver as `obj!` and forwards to the holder's **static**
method, passing `obj!` as the first argument:

```lisp
(cl:defun dummy-extension (obj! value)
  "Extension method from <HolderFQ> (assembly <holder-assembly>)."
  (dotnet:static "<HolderFQ>" "DummyExtension" obj! value))
```

Note this differs from an ordinary instance-method wrapper (which calls
`dotnet:invoke` on `obj!`): an extension wrapper calls `dotnet:static` on the
**holder** type, with `obj!` threaded as the first positional argument.

**Matching (v1):** an extension method `E` (found anywhere in the provided
assemblies) is a candidate for class `C` iff `E`'s `:extension-this` parameter's
`:type` is `string=` to `C`'s `:fully-qualified-name`. A `:type` that is an open
generic — detected via the existing `generic-type-p` helper
(`assembly-package-generator.lisp:305`, "contains a backtick"), or that is a bare
generic-parameter name (not a resolvable FQ name) — never `string=`-matches a
concrete class FQ name, so those are naturally excluded; no special-casing is
required, but the matcher should still explicitly `generic-type-p`-guard the
`this` type so intent is clear.

**Per-candidate skip rules** (each skip emits a documenting comment, matching the
existing "dirty overload"/"unsupported indexer" convention):

* **Dirty** (any non-`this` parameter is `ref`/`out`/`ref-readonly`/`params`, or
  has a default) → skip; reuse `dirty-method-p` (`:513`) semantics on the
  parameters *after* the `this` parameter. Also skip if the method itself
  **`:is-generic`** (its own type argument(s) would have to precede `obj!`,
  breaking the uniform `obj!`-first shape) — same exclusion the defgeneric
  collector already makes.
* **Name collides with one of the class's own exported member names** (the class
  declares a real member mapping to the same Lisp name) → skip; the class's own
  member wins (mirrors C#'s "instance method beats extension method" resolution).
* **Name shared by ≥2 surviving candidate extension methods** (overloaded across
  one or several holders) → skip **all** of them with a comment listing every
  signature. Extension-method overload dispatch is deferred (see "Deferred /
  Future").

Every surviving candidate has a unique Lisp name and generates one simple
wrapper. The Lisp name is `map-member-name` of the method's clean `:name` (so
`IsFoo` → `foo?`, etc., identical to ordinary methods). The invoked CIL name is
`(or (getf m :mangled-name) (getf m :name))` (extension methods are not
operators, so `:mangled-name` is normally absent and the clean name is the CIL
name).

## A.1 CLI surface (`Program.cs`)

Follow the `--defgeneric` precedent exactly (`Program.cs:30-31,62-63,111-134,
151-158,230-231,452-453`):

* Add `bool enableExtensionMethods = true;` to the sticky-defaults block
  (`~26-31`). **Initialized to `true`** — this is the ON-by-default divergence.
* Add `public bool ExtensionMethods;` to `ClassSpec` (`~446-454`).
* In the `--class` branch (`~57-64`), seed
  `ExtensionMethods = enableExtensionMethods`.
* Add per-class arg handlers `--extension-methods` (sets current class's bool
  `true`; error if before any `--class`) and `--no-extension-methods` (sets
  `false`), modeled on `--defgeneric`/`--no-defgeneric` (`~123-134`).
* Add sticky handlers `--enable-extension-methods` (sets
  `enableExtensionMethods = true`) and `--no-enable-extension-methods` (`false`),
  modeled on `--enable-defgeneric`/`--no-enable-defgeneric` (`~155-158`).
* In manifest emission (`~224-234`), append
  `" :extension-methods "` + (`cls.ExtensionMethods ? "t" : "nil"`) to each
  `:classes` entry.
* Update `--help` (`PrintHelp`, `~343-439`): document the per-class flags in the
  per-class group and the sticky flags in the sticky-defaults group, explicitly
  noting the **default is ON** and that a class picks up matching extension
  methods from *all provided assemblies* (concrete `this`-type only, v1).

No change to the `DotclHost.Call` site or the batch entry signature — the flag
rides in the manifest, like `:defgeneric`.

## A.2 Extension-method index (Lisp)

New helper, built once inside `generate-assembly-packages-batch` right after
`build-metadata-index` (`:2806`):

```
build-extension-method-index (metadata-index)
  -> hash table: this-type-fq-name (string)
                 -> list of (method-plist . holder-plist)
```

Iterate every distinct type in `metadata-index` (its values are
`(type-plist . owning-entry)` — one per FQ name, first occurrence wins, so every
distinct type is visited once). For each type's `:methods` entry with
`:extension-method t`, read its first parameter (the `:extension-this` one), and
unless that parameter's `:type` is `generic-type-p`, push
`(cons method-plist type-plist)` onto the bucket for that `:type`. Preserve
first-seen order per bucket (so generated output is deterministic across a fixed
assembly set).

## A.3 Matching and threading onto the resolved-class

* `make-resolved-class` (`:1937`) gains a keyword param `extension-methods` (the
  per-class **flag**, defaulting nil for the ancestor/discovered case) stored as
  `:extension-methods`, plus a slot `:matched-extensions` (the computed list of
  `(method-plist . holder-plist)` for this class, defaulting nil). Follow the
  `:defgeneric` threading pattern.
* `resolve-batch-entry` (`:1964`) reads `(getf class-entry :extension-methods)`
  and passes it to `make-resolved-class` as the flag.
* In `generate-assembly-packages-batch`, after the working set is finalized (all
  explicit + discovered classes resolved) and the extension index is built,
  compute each resolved-class's `:matched-extensions`: for every resolved-class
  whose `:extension-methods` flag is true, look up
  `(gethash class-fq extension-index)`, apply the A.0 skip rules against that
  class's own export set (from `compute-package-exports-and-shadows`), and store
  the surviving `(method-plist . holder-plist)` list into the resolved-class's
  `:matched-extensions`. Store it back onto the same plist the rest of the
  pipeline reads.
  * In v38 only explicitly-requested classes carry the flag; in v39 flag
    propagation (Part B) will turn it on for discovered classes too, at which
    point they automatically get matched extensions with no further Part A work.

## A.4 Three-way name sync (exports / emission / generics)

Extension wrappers add **new exported symbols and new function bodies** to a
class's package, so all three functions that independently walk a class's members
must agree on them — exactly the invariant the v32 events work established (see
`class-member-names-excluding-events`). Thread the matched-extensions list into
each:

1. **`compute-package-exports-and-shadows`** (`:1230`) — add `&optional
   matched-extensions`. After the method-group export walk (`~1343-1360`), push
   each surviving extension wrapper's `map-member-name` onto `exports` (they then
   flow through the existing dedup + CL-shadow detection at `~1374-1382`).
2. **`generate-class-file`** (`:1521`) — add `&optional matched-extensions` (after
   `creation-time`). Emit the wrappers in a new block (see A.5).
3. **`collect-class-instance-generics`** (`:1386`) — add `&optional
   matched-extensions`. Extension wrappers are `obj!`-first instance-style, so per
   the v37 principle ("generics should include all generated instance-style
   wrappers") add each surviving extension wrapper's name to `method-names`
   (never `setter-names`). This makes them eligible for `--defgeneric` /
   `--defgeneric-dynamic` unification like any other instance method.

**Call-site updates** (all pass `(getf rc :matched-extensions)`):

* `generate-batch-packages-file` (`:2315`) — where it calls
  `compute-package-exports-and-shadows` per class to build each `defpackage`.
* `emit-child-reexports` (`:2146`) — passes it for **both** the child
  (`:2166`) and each ancestor spec (`:2174-2175`), since a re-export source that
  itself has matched extensions exports those names too, and they should flow
  through re-export like any other member.
* The class-file generation loop (`:2890-2894`) — pass it to
  `generate-class-file`.
* `%compute-defgeneric-model` (`:2249+`) — its `collect-class-instance-generics`
  call (`:2259`) passes it, so extension wrappers participate in the generics
  model.

## A.5 Emission spec (new block in `generate-class-file`)

Emit after the existing method-groups loop (`:1883-1931`), before the
`with-open-file`/lets close. For the matched-extensions list (already filtered to
survivors in A.3, but re-derive the skip *reasons* here for the documenting
comments, or thread both survivors and skip-records through — implementer's
choice; keeping the survivor computation in A.3 and re-deriving skip comments
from the raw bucket here is acceptable since both read the same class exports):

* Header comment: `;; Extension methods injected from other assemblies (this
  == <fq-name>):`.
* For each **surviving** candidate: emit
  `(cl:defun <lisp-name> (obj! <mapped-non-this-params...>) <docstring>
  (dotnet:static "<holder-fq>" "<cil-name>" obj! <mapped-non-this-params...>))`.
  The docstring names the holder type FQ-name and its owning assembly
  (`assembly-name` of the holder's owning entry — thread the holder's owning
  entry, or just its assembly name, into the matched list) plus any XML-doc
  summary already on the method plist (reuse `build-docstring`, `:622`).
* For each **skipped** candidate, emit a comment stating the reason (dirty /
  generic / name-collides-with-own-member / overloaded-extension-name) and the
  full `method-signature-str` (`:555`), mirroring the dirty-overload comment
  block.

Qualify every emitted CL operator with `cl:` (`cl:defun`) per the repo
convention. The non-`this` parameters are mapped with `map-param-name`
(`:133`), exactly like ordinary method parameters.

## A.6 Docs, versioning, tests (Part A)

* Bump `*generator-version*` → 38 (`assembly-package-generator.lisp:13`) with a
  changelog line in its docstring; bump `VERSION` in `Makefile` and
  `dotcl-packagegen.asd` in lockstep (see `BUILD.md`); add a
  `doc/generator-design-notes.md` "Extension Methods (Version 38)" section.
* Update `FEATURES.md` (new "Extension Methods" section), `RELEASES.md` (new CLI
  minor-version entry), `Program.cs --help`, and the CLAUDE.md / `GEMINI.md`
  CLI-usage blurbs.
* `doc/package-generator-dependencies.md`: note generated extension wrappers
  depend on `dotnet:static` (already used elsewhere) — no new dependency.
* Tests:
  * Add a concrete (non-generic, concrete-`this`) extension method to
    `AssemblyToLispyTestTarget/EdgeCases.cs` extending one of its own concrete
    types (not `object`), plus at least one overloaded and one dirty extension
    method to exercise the skip paths.
  * Add/extend a `tests/*.test.lisp` asserting the generated class package
    exports the injected wrapper name and that the skip comments appear.
  * Extend `make test`'s end-to-end smoke invocation to generate that extended
    type with extension methods on (the default), so `cspackages-test/` gains
    checked-in extension-wrapper output. Existing smoke classes may also gain
    concrete BCL extension methods — regenerate and commit the diff.
  * `make check-parens`; `make build test`.

---

# Part B — Recursive Related-Class Discovery (generator version 39)

## B.0 Semantics

Today (v33), `generate-assembly-packages-batch`'s Phase B (`:2825-2871`) calls
`expand-ancestors` for every class with `--export-parents`/`--export-interfaces`,
folds discovered ancestors into the working set as **plain** packages
(`make-resolved-class` with nil flags), and records, per child, which ancestors
feed its re-export block (`child-ancestor-fqs`).

Part B replaces that Phase with a **recursive, multi-direction closure with flag
propagation**:

* **Directions (per class, from its carried flag set):**
  * `--export-parents` — walk `:superclass` up (existing; `System.Object` gated by
    `--export-object`).
  * `--export-interfaces` — the class's `:interfaces` (existing; already
    transitive).
  * `--output-nested` — types whose FQ starts with `"<class-fq>+"` (transitively
    nested in one pass, since `+` is the nesting separator and FQ names are
    unique).
  * `--output-children` — direct subclasses (types whose `:superclass` `string=`
    this class), walked transitively via the work-queue.
  * `--output-implementations` — types whose `:interfaces` contains this class's
    FQ (already transitive, since `.NET`'s `GetInterfaces()` is transitive).
* **Every discovered class is enqueued carrying the discovering class's full
  per-class boolean flag set** (all `--export-*`/`--output-*` flags **plus** `--defgeneric`,
  `--defgeneric-dynamic`, `--extension-methods`). It is therefore itself
  processed for further discovery and re-export under those same flags —
  discovery cascades through the whole connected component. Constant-properties
  are not propagated (discovered classes get nil, unless explicitly requested).
* **Re-export vs. generate-only:**
  * `--export-parents`/`--export-interfaces` discoveries are **both** added to the
    working set **and** recorded as re-export sources for the discovering class
    (into `child-ancestor-fqs`), exactly as v33 does — so the discovering class
    re-exports those ancestors' members into itself.
  * `--output-nested`/`--output-children`/`--output-implementations` discoveries
    are **only** added to the working set. They are **never** recorded as
    re-export sources; the anchor / discovering class's own package is not
    modified by them.
* **Dedup / termination:** a single `visited` hash table over FQ names (seeded
  with every explicitly-requested class) terminates cycles and diamonds. A class
  reached by multiple paths is generated once. An explicitly-requested class that
  is also discovered keeps its explicit flags + constant-properties.
* **Missing handling:** unchanged for the upward directions — an unresolvable
  `:superclass`/`:interfaces` FQ is a hard error unless `--skip-missing`
  (existing `expand-ancestors` `missing` mechanism). The three downward
  directions have **no missing concept** — they enumerate whatever types exist in
  the provided assemblies; there is nothing to be "missing."
* **Fan-out safety:** because `--output-children`/`--output-implementations` on a
  widely-derived base/interface can pull in very many types (amplified by
  recursion), emit a `format-red`/warning to `*error-output*` reporting the total
  discovered-class count when it exceeds a threshold (e.g. 200), so an
  accidental combinatorial crawl is visible. Do not hard-cap.

## B.1 CLI surface (`Program.cs`)

Add three per-class flags + three sticky defaults, all modeled precisely on
`--export-parents` / `--export-all-parents` (`Program.cs:75-86,135-138`), **all
defaulting OFF** (unlike Part A):

* Per-class: `--output-nested` / `--no-output-nested`, `--output-children` /
  `--no-output-children`, `--output-implementations` /
  `--no-output-implementations`. Each sets a bool on the current `ClassSpec`;
  error if before any `--class`.
* Sticky: `--output-all-nested` / `--no-output-all-nested`,
  `--output-all-children` / `--no-output-all-children`,
  `--output-all-implementations` / `--no-output-all-implementations`.
* `ClassSpec` gains `bool OutputNested, OutputChildren, OutputImplementations;`;
  seed each from the corresponding sticky in the `--class` branch.
* Manifest: append `:output-nested`/`:output-children`/`:output-implementations`
  booleans to each `:classes` entry.
* `--help`: add the three per-class flags to the parents/interfaces group and the
  three sticky flags to the sticky-defaults group, with a note that they
  generate the discovered types as their own packages (they do **not** add
  anything to the anchor's package) and that flags propagate recursively to
  discovered classes.

## B.2 Reverse indexes (Lisp)

New helper built once from the global metadata index (alongside
`build-metadata-index`):

```
build-reverse-indexes (metadata-index)
  -> (values subclass-index implementer-index)
```

* `subclass-index`: `superclass-fq -> list of (type-plist . owning-entry)` for
  every type whose `:superclass` is that FQ.
* `implementer-index`: `interface-fq -> list of (type-plist . owning-entry)` for
  every type that lists that FQ in `:interfaces`.

Nested discovery needs no precomputed index — it is a prefix scan
(`"<class-fq>+"`) over `metadata-index`'s keys; optionally precompute an
`enclosing-fq -> nested list` map the same way for O(1) lookup, but the prefix
scan is acceptable given batch sizes.

## B.3 Generalized recursive expansion (replaces Phase B)

Replace/extend `expand-ancestors` (`:2034`) with a unified per-class expansion,
e.g. `expand-related`, that given a class-plist, its carried flag set, the
`index`, the two reverse indexes, and the shared `visited` table, returns:

* `discovered` — list of `(type-plist . owning-entry . carried-flags)` triples
  (or equivalent), one per newly-discovered type across **all** enabled
  directions, each tagged with the flag set to propagate to it (= this class's
  carried flags).
* `reexport-sources` — the subset of `discovered` FQ names reached via
  `--export-parents`/`--export-interfaces` only (for `child-ancestor-fqs`).
* `missing` — as today, from the upward directions only.

Drive it from `generate-assembly-packages-batch`'s Phase B with a **work queue**
seeded by every explicitly-requested resolved-class (each carrying its own
explicit flags). For each dequeued class: run `expand-related`; for each newly
`discovered` type not in `visited`, mark visited, create its resolved-class via
`make-resolved-class` **with the propagated flags** (and nil constant-properties),
append it to its owning entry's additions (as today, `:2841-2849`), and enqueue
it (so it discovers further). Accumulate `child-ancestor-fqs` per class from
`reexport-sources` (upward only). Accumulate `missing` and apply the existing
`--skip-missing` policy (`:2852-2862`).

The rest of Phase B / generation (`:2864-2901`) is unchanged: additions are
merged per entry, `entries-with-resolved-pairs`/`all-resolved` built, and
`compute-defgeneric-model`, `generate-batch-packages-file`,
`generate-class-file` per class, the generics files, and
`generate-batch-asd-file` all consume the enlarged working set with no signature
changes. `emit-child-reexports` continues to run only for classes with non-empty
`child-ancestor-fqs`, which now includes discovered classes that carry
`--export-parents`/`--export-interfaces` — so their re-export blocks are emitted
automatically.

## B.4 Interaction notes

* **`.asd` `:depends-on`** (`generate-batch-asd-file`, `:2675`) already adds each
  child's `child-ancestor-fqs` ancestor packages to its `:depends-on`; since
  downward discoveries are not re-export sources, they add no dependency edges,
  which is correct (a nested/child/implementation package does not need to load
  before the anchor).
* **Extension methods (Part A) compose automatically:** a discovered class that
  carries `--extension-methods` (propagated, and ON by default) has its
  `:matched-extensions` computed in A.3 like any other resolved-class — no extra
  work. This supersedes A.3's v38-only note that discovered classes get no
  extensions.
* **`--defgeneric`/`--defgeneric-dynamic` propagation:** a discovered class
  carrying either flag contributes to the corresponding generics package via the
  unchanged `compute-defgeneric-model`/`compute-defgeneric-dynamic-model` walk
  over `all-resolved` — again automatic.

## B.5 Docs, versioning, tests (Part B)

* Bump `*generator-version*` → 39, `VERSION` in `Makefile`/`dotcl-packagegen.asd`
  in lockstep; changelog line + `doc/generator-design-notes.md` "Recursive
  Related-Class Discovery (Version 39)" section (record the flag-propagation
  semantics and the anchor-not-modified rule explicitly).
* Update `doc/parents-and-interfaces-plan.md` with a short forward-reference to
  this generalization; update `FEATURES.md` (extend the "Parents and Interfaces"
  section, or add a "Related-Class Discovery" section), `RELEASES.md`,
  `Program.cs --help`, CLAUDE.md / `GEMINI.md`.
* Tests:
  * Use `EdgeCases.cs`'s existing abstract base + subclass + interface shapes
    (add a nested type and a second subclass if needed) to exercise all three
    downward directions and flag propagation; assert the discovered types get
    their own packages in the generated `packages.lisp`/`.asd`, that the anchor's
    own package is unchanged by downward discovery, and that a discovered class
    carrying `--export-parents` emits its own re-export block.
  * Extend `make test`'s smoke invocation with an `--output-children` (or
    `--output-implementations`) case, regenerate `cspackages-test/`, commit the
    diff.
  * `make check-parens`; `make build test`.

---

# Deferred / Future (noted, not implemented here)

* **Phase 5 virtual/override-aware shadow commentary** (from
  `doc/parents-and-interfaces-plan.md` Phase 5 and `PLAN.md`): refine re-export
  skip comments to distinguish a child *overriding* vs *shadowing* a parent
  member. Needs new `AssemblyToLispy.cs` metadata (`MethodInfo.IsVirtual` /
  `GetBaseDefinition()` → `:virtual`/`:new-slot`) + a `doc/assembly-to-lispy.md`
  schema update. Independent of both parts here.
* **Extension-method inheritance + generic matching:** match extension methods
  whose `this` type is a base class or implemented interface of the class, and
  whose `this` type is an open generic (e.g. LINQ's `IEnumerable<T>`) against
  generic/closed classes. Significant generic-type-matching work; highest payoff
  but riskiest — deferred past v38's exact-concrete-only rule.
* **Extension-method overload dispatch:** generalize the Master Wrapper
  (`generate-master-wrapper`, `:870`) to dispatch across multiple overloaded
  extension methods of the same name, each invoked via its own holder's
  `dotnet:static`. v38 skips overloaded extension names with a comment instead.
* **Generic superclass matching for `--output-children`:** v39 matches
  `:superclass` by exact FQ string, so a subclass whose base is a *closed*
  generic (`` Base`1[System.Int32] ``) won't match an anchor that is the *open*
  generic (`` Base`1 ``). Same class of limitation as extension generic matching.

# Files to touch (summary)

* **`Program.cs`** — Part A: sticky default (ON) + `ClassSpec` field + per-class
  & sticky arg handlers + manifest key + `--help` (`~26-31,57-64,111-162,
  224-234,343-439,446-454`). Part B: three more per-class + three more sticky
  flags + `ClassSpec` fields + manifest keys + `--help`.
* **`assembly-package-generator.lisp`** — Part A: `build-extension-method-index`,
  `make-resolved-class`/`resolve-batch-entry` threading, matched-extensions
  computation in `generate-assembly-packages-batch`, `&optional
  matched-extensions` on `compute-package-exports-and-shadows` /
  `generate-class-file` / `collect-class-instance-generics` + all call sites, the
  emission block. Part B: `build-reverse-indexes`, `expand-related` (generalizing
  `expand-ancestors`), the work-queue rewrite of Phase B with flag propagation.
  Version bumps (→38, →39).
* **`AssemblyToLispyTestTarget/EdgeCases.cs`** — a concrete extension method (+
  overloaded/dirty variants); nested type / extra subclass if needed.
* **`tests/*.test.lisp`** — extension-injection assertions; downward-discovery
  assertions.
* **Version/docs:** `Makefile`, `dotcl-packagegen.asd`,
  `doc/generator-design-notes.md`, `doc/package-generator-dependencies.md`,
  `doc/parents-and-interfaces-plan.md`, `FEATURES.md`, `RELEASES.md`, `CLAUDE.md`,
  `GEMINI.md`.
* **`cspackages-test/`** — regenerated smoke output for both parts.
* **`PLAN.md`** — append DONE/reference lines under the two source sections
  (append-only; do not rewrite the existing "Handle Extension Methods" / "More
  Parent & Ancestor stuff" text).

# Verification

1. `make build` — compiles C# host + cross-compiles Lisp.
2. `make check-parens` — after any hand-edit to a `.lisp` file.
3. `make test` — Lisp + C# unit suites, the new extension/discovery tests, and
   the end-to-end smoke generation (now including extension-on-by-default output
   and a downward-discovery invocation), finishing with `check_parens.py` over
   all generated output.
4. Manual end-to-end (Part A): generate a class with a known concrete extension
   method available in a provided assembly; confirm the injected wrapper appears
   in `packages.lisp` exports and in the class `.lisp` as a `dotnet:static`
   forward with a holder-naming docstring; load in a DotCL REPL and call
   `class:extension obj! ...` on a real instance.
5. Manual end-to-end (Part B): generate an anchor with `--output-children`
   `--export-parents`; confirm the discovered subclasses appear as their own
   packages/`.asd` components, the anchor's own package is unchanged by the
   downward discovery, and a discovered subclass emits its own re-export block
   (flag propagation). Confirm `--output-implementations` over an interface pulls
   in implementers, and the fan-out warning fires on a deliberately wide base.
