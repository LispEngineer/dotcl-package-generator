# Turn Everything into Generic Methods — Implementation Plan

* Status: APPROVED design, NOT yet implemented.
* Related: `PLAN.md` "Turn Everything into Generic Methods" section (original idea sketch).

## Context

Today every generated C# class package is an island: `system-string:length`,
`system-array:length`, etc. are separate functions, even though semantically they're "the
same operation on different types." A user holding a boxed `#<DOTNET …>` instance must know
its exact package to call anything. This feature adds an opt-in mode that also unifies every
selected class's **instance** members into a single shared package of CLOS generic functions
(`csharp-generics`), dispatching on the CLR type of the receiver — so `(csharp-generics:length x)`
works whatever `x`'s type, calling through to that type's own wrapper.

### Locked design decisions (settled with the user)

1. **Robust load-time dispatch install**, NOT static `defmethod` specializers. The generator
   cannot know at generation time which Lisp class-name symbol a C# type will receive at
   runtime: DotCL names a type's CLOS class by its *simple* name when free, but gives a
   colliding same-simple-name type (different namespace) its unique *FullName* symbol instead,
   and which type wins is load-order-dependent (`Runtime.CLOS.cs:213-276`, esp. `simpleFree`
   at :248). So each method is installed **at load time** against the type's *actual* class
   object (fetched via `EnsureDotNetTypeClass(resolve-type "FQN")`), immune to the naming race.
2. **Scope = instance methods AND instance property/field accessors** (getters *and* setters).
   Excluded (documented as limitations): static methods (no receiver to dispatch on), and
   generic/type-parameterized instance methods (their wrapper puts type-args *before* `obj!`,
   so there's no stable `obj!`-first dispatch position). The `<>`-arity dispatchers are also
   excluded on the same grounds.
3. **Shared package name: `csharp-generics`** (`:use :cl`), sitting alongside the existing
   `csharp-assembly-utils`.
4. **Per-class opt-in.** Only classes flagged (directly or via the sticky default) contribute
   generics/methods. If no class opts in, none of the new file/package/asd wiring is emitted.

### Why this is feasible

DotCL dispatches CLOS methods on the CLR type of a boxed instance: `class-of` a
`#<DOTNET …>` resolves to `EnsureDotNetTypeClass(dn.Type)` (`Runtime.CLOS.cs:575`). The
generator *already* registers each class's CLOS class inside each generated file
(`assembly-package-generator.lisp:1449-1453`). DotCL exposes a full CLOS MOP —
`ensure-generic-function`, `add-method`, `class-name`, `(setf name)` generic functions
(`runtime/Mop.cs`, `runtime/Runtime.CLOS.cs:2222+`, `4302+`) — so both `defgeneric` and
load-time method installation are expressible.

Note on the naming race and why `(class-name cls)` is the right specializer: DotCL registers
each CLOS class under exactly **one** findable symbol — the non-colliding "winner" is
registered under its simple name (and uppercase variant) only (`Runtime.CLOS.cs:261-269`),
NOT its FullName; a colliding "loser" is registered under its FullName symbol only
(`:270-274`). So "always use FullName" does **not** work (the FullName isn't registered for
the common non-colliding case), and neither does "always use the simple name" (ambiguous under
collision). Fetching the class object and reading its own `(class-name cls)` yields whichever
symbol *that* class was actually registered under — always correct, in both cases.

### The uniform-signature key insight

Every instance wrapper takes the receiver first as `obj!`:
* method / getter: `(name obj! …)` — e.g. `(capacity obj!)`, `(item obj! key)`
* setter: `(cl:defun (cl:setf name) (new-value obj! …))` — receiver is the 2nd required arg
  (`cspackages-test/system-collections-generic-sorted-list-2.lisp:70-90`).

So every generic can be `(name obj! &rest args)` and every method just forwards:
`(cl:apply #'pkg:name obj! args)`. This sidesteps CLOS lambda-list congruence entirely
(different classes' same-named members have wildly different arities) at the cost of a little
apply/dispatch overhead — which `PLAN.md` explicitly accepts as fine for v1.

## Phase 1 — CLI surface (`Program.cs`)

Mirror the existing `--export-parents` / `--export-all-parents` / `--skip-missing` families.

* `ClassSpec` (`:381-392`): add `public bool DefGeneric;`.
* Sticky state (`:26-29`): add `bool enableDefgeneric = false;`.
* `--class` initializer (`:51-63`): seed `DefGeneric = enableDefgeneric,`.
* Per-class flags (mirror `--export-parents`/`--no-export-parents` at `:71-82`):
  `--defgeneric` / `--no-defgeneric` → set/clear `currentClass.DefGeneric` (error if no
  current `--class`).
* Sticky flags (mirror `--export-all-parents` at `:107-118`):
  `--enable-defgeneric` / `--no-enable-defgeneric` → set/clear `enableDefgeneric`.
* Manifest emission (`:188-195`): append `:defgeneric t|nil` to each class plist (bare Lisp
  token, like the other booleans). No new scalar arg to `DotclHost.Call` — it rides in the
  manifest like `:export-parents`.
* Help text (`PrintHelp`, `:305-379`): document all four flags in the per-class / sticky spots.

## Phase 2 — Thread the flag through the Lisp batch (`assembly-package-generator.lisp`)

Stickiness collapses in `Program.cs`; Lisp just sees a resolved per-class boolean.

* `make-resolved-class` (`:1782-1796`): add optional `defgeneric` param + `:defgeneric` key.
* `resolve-batch-entry` (`:1798-1824`): read `(getf class-entry :defgeneric)`, pass it in.
* `run-assembly-package-generator-batch` docstring (`:2290-2293`): document `:defgeneric`.

## Phase 3 — Collect the unified member set (new Lisp pass)

In `generate-assembly-packages-batch` (`:2163`), after `all-resolved` is materialized
(`:2265-2268`), build the generics model from the subset of resolved classes with
`:defgeneric` true. **Reuse the existing name computation to avoid drift** (the in-code
warning at `:427-429`): derive names exactly as `compute-package-exports-and-shadows`
(`:1210`) / `class-member-names-excluding-events` (`:1117`) / `method-name-wrapper-names`
(`:412`) do — do NOT re-derive names by hand.

Produce, per opted-in class, three name lists (filtering to instance, non-generic members):
1. **method / getter generic names** — instance method-group wrapper names + instance
   property/field getter names (indexers included; their extra args ride in `&rest`).
2. **settable names** — those instance properties/fields that emit a `(cl:setf name)` wrapper.
3. The class's `pkg-name` (`type-fq-name-to-pkg-name`, `:94`) and `fq-name`, for emission.

Aggregate across all opted-in classes into:
* the set of unique generic names (union) → `defgeneric` forms + package `:export`;
* the set of unique settable names (union) → `(setf name)` `defgeneric` forms;
* the union shadow set (names colliding with `:cl`, computed the same way per-class shadowing
  already is) → package `:shadow`;
* per generic name, the list of `(pkg . fq-name)` that specialize it → for docstrings.

## Phase 4 — Emit the shared package + generics

Two emission sites, following existing precedent (`generate-batch-utils-file` sibling-file +
`generate-batch-packages-file` cross-class post-pass):

**4a. `csharp-generics` defpackage** — in `generate-batch-packages-file` (`:2011`), alongside
the per-class `defpackage`s: `(cl:defpackage :csharp-generics (:use :cl) (:shadow …) (:export …))`
with the union shadow/export sets. Skip entirely if no class opted in.

**4b. New file `csharp-generics.lisp`** — a new `generate-batch-generics-file` (model it on
`generate-batch-utils-file`), emitting into `--out-dir`:
* `(cl:in-package :csharp-generics)`.
* For each unique generic name: `(cl:defgeneric name (obj! cl:&rest args) (:documentation …))`
  where the docstring lists the specializing packages/C# types (PLAN requirement).
* For each unique settable name:
  `(cl:defgeneric (cl:setf name) (new-value obj! cl:&rest args) (:documentation …))`.
* For each opted-in class, ONE load-time install block keyed on the class's *actual* runtime
  class object (robust against the naming race):

  ```lisp
  (cl:eval-when (:load-toplevel :execute)
    (cl:let* ((cls  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                       (dotnet:resolve-type "<FQ-NAME>")))
              (spec (cl:class-name cls)))
      ;; getters / methods
      (cl:eval `(cl:defmethod name ((obj! ,spec) cl:&rest args)
                  (cl:apply (cl:function <pkg>:name) obj! args)))
      ;; settable properties/fields
      (cl:eval `(cl:defmethod (cl:setf name) (new-value (obj! ,spec) cl:&rest args)
                  (cl:apply (cl:function (cl:setf <pkg>:name)) new-value obj! args)))
      …))
  ```

  Using `(class-name cls)` as the specializer symbol is robust because DotCL registers the
  class under exactly that symbol (`Runtime.CLOS.cs:263/273`), so the collision winner
  specializes on its simple symbol and the loser on its distinct FullName symbol — each on the
  correct class. (Fallback if `class-name`↔`find-class` round-trip ever proves unreliable:
  build the method with `add-method` on the class *object* directly, no symbol involved.)

**4c. `.asd` wiring** — in `generate-batch-asd-file` (called `:2280`): add `csharp-generics`
as a component with `:depends-on` = `csharp-assembly-utils` + every opted-in class package, so
it loads **last** (both the underlying `pkg:name` functions and each class's CLOS registration
must exist first). Skip if no class opted in.

Load/emit order in `generate-assembly-packages-batch` (`:2265-2280`): compute the generics
model (Phase 3) → `generate-batch-packages-file` (now also emits the `csharp-generics`
defpackage) → existing utils/per-class loop → `generate-batch-generics-file` (new) →
`generate-batch-asd-file` (now also wires the new component).

## Phase 5 — Versioning, docs, tests

* Bump: `:version` minor in `dotcl-packagegen.asd`, `VERSION` in `Makefile` — the generator
  version reads the `.asd` minor (`:13,24-27`); this is Generator Version 34.
* `*generator-version*` docstring changelog (`:33-68`): add the `34 - …` line.
* `doc/generator-design-notes.md`: new "Version 34 — Unified Generic Methods" section
  (rationale, the robust-load-time-install choice and *why* static specializers are unsafe,
  the `obj!`+`&rest`-apply forwarding, the excluded categories).
* `FEATURES.md`: new section (after "Methods and Method Overloads" / "Generic Methods",
  ~`:517-560`) documenting the `csharp-generics` package and the flags.
* `RELEASES.md`: CLI-level entry for the new flags.
* `CLAUDE.md` CLI-usage / flag-families paragraph: mention `--defgeneric`/`--enable-defgeneric`.
* `PLAN.md`: mark the "Turn Everything into Generic Methods" section DONE — append/mark only,
  do NOT delete or rewrite the existing text.
* `doc/assembly-to-lispy.md`: **no change** (no metadata-shape change).
* `Makefile` smoke test (`:50-94`): add `--enable-defgeneric` (and/or per-class `--defgeneric`)
  covering several classes with overlapping member names (e.g. `System.Object`,
  `System.String`, `System.Text.StringBuilder`, the `Dictionary`2`/`SortedList`2` group) so
  `csharp-generics.lisp` is generated into `cspackages-test/` and paren-checked; regenerate
  and commit the `cspackages-test/` drift.
* Consider a Lisp unit test in `generator-tests.lisp` asserting the generics-name collection
  matches `compute-package-exports-and-shadows` for a class (drift guard).

## Verification

1. `make check-parens` after any hand-edit.
2. `make build test` — runs Lisp + C# unit suites, regenerates `cspackages-test/` (now
   including `csharp-generics.lisp`), and runs `check_parens.py` over all generated output.
   Inspect the `cspackages-test/` git diff for the new package/file and sane defgeneric/method
   forms.
3. Manual REPL smoke (load the generated `cspackages-test/` system): confirm
   `(csharp-generics:length "abc")` and a `System.Array` instance both dispatch to their
   respective packages, and that a settable property routes through `(setf (csharp-generics:… x) v)`.
4. Robustness spot-check: pick two opted-in classes and confirm each `EnsureDotNetTypeClass`
   install block specializes on the class's own `class-name`, so a same-simple-name collision
   would still attach each method to the correct class.

## Files touched

* `Program.cs` — CLI flags, manifest key.
* `assembly-package-generator.lisp` — resolve/thread flag; Phase-3 collector; new
  `generate-batch-generics-file`; `csharp-generics` defpackage in
  `generate-batch-packages-file`; `.asd` component in `generate-batch-asd-file`; version +
  changelog.
* `dotcl-packagegen.asd`, `Makefile` — VERSION bump; smoke-test flags.
* `doc/generator-design-notes.md`, `FEATURES.md`, `RELEASES.md`, `CLAUDE.md`, `PLAN.md` — docs.
* `cspackages-test/*` — regenerated output (committed).
* (optional) `generator-tests.lisp` — drift-guard test.
