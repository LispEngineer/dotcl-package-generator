# Turn Everything into Generic Methods — Dynamic (Load-Time-Install) Variant

* Status: IMPLEMENTED (Generator Version 34; renamed from `--defgeneric`/`csharp-generics` to
  `--defgeneric-dynamic`/`csharp-generics-dynamic` in Generator Version 35 — see
  `doc/make-everything-defgeneric.md` for the sibling variant that now uses the original names).
* Related: `PLAN.md`'s original "Turn Everything into Generic Methods" section (idea sketch) and
  its "Improve Turn Everything into Generic Methods" follow-up (the rename + new sibling).

## Context

Today every generated C# class package is an island: `system-string:length`,
`system-array:length`, etc. are separate functions, even though semantically they're "the
same operation on different types." A user holding a boxed `#<DOTNET …>` instance must know
its exact package to call anything. This feature adds an opt-in mode that also unifies every
selected class's **instance** members into a single shared package of CLOS generic functions
(`csharp-generics-dynamic`), dispatching on the CLR type of the receiver — so
`(csharp-generics-dynamic:length x)` works whatever `x`'s type, calling through to that type's
own wrapper.

### Locked design decisions

1. **Robust load-time dispatch install**, NOT static `defmethod` specializers. The generator
   cannot know at generation time which Lisp class-name symbol a C# type will receive at
   runtime: DotCL names a type's CLOS class by its *simple* name when free, but gives a
   colliding same-simple-name type (different namespace) its unique *FullName* symbol instead,
   and which type wins is load-order-dependent (`Runtime.CLOS.cs:213-276`, esp. `simpleFree`
   at :248). So each method is installed **at load time** against the type's *actual* class
   object (fetched via `EnsureDotNetTypeClass(resolve-type "FQN")`), immune to the naming race.
   This robustness is the entire reason this variant exists alongside the sibling
   `--defgeneric` (static specializer) variant — see that doc for the tradeoff it accepts
   instead.
2. **Scope = instance methods, instance property/field accessors** (getters *and* setters),
   **and instance events** (`add-X`/`remove-X` pairs, both folded in as plain method-names
   entries — added in Generator Version 37 after a real-world report of a missing `add-click`).
   Excluded (documented as limitations): static methods (no receiver to dispatch on), and
   generic/type-parameterized instance methods (their wrapper puts type-args *before* `obj!`,
   so there's no stable `obj!`-first dispatch position). The `<>`-arity dispatchers are also
   excluded on the same grounds.
3. **Shared package name: `csharp-generics-dynamic`** (`:use :cl`), sitting alongside the
   existing `csharp-assembly-utils` and the sibling `csharp-generics` (static variant) package.
4. **Per-class opt-in, independent of the static variant.** Only classes flagged (directly via
   `--defgeneric-dynamic`, or via the sticky `--enable-defgeneric-dynamic` default) contribute
   to this package. A class may opt into this variant, the static variant, both, or neither —
   the two are entirely orthogonal. If no class opts into this variant, none of its
   file/package/`.asd` wiring is emitted (independent of whether the static variant is used).

### Why this is feasible

DotCL dispatches CLOS methods on the CLR type of a boxed instance: `class-of` a
`#<DOTNET …>` resolves to `EnsureDotNetTypeClass(dn.Type)` (`Runtime.CLOS.cs:575`). The
generator *already* registers each class's CLOS class inside each generated file
(`assembly-package-generator.lisp`'s per-class `EnsureDotNetTypeClass` `eval-when` block). DotCL
exposes a full CLOS MOP — `ensure-generic-function`, `add-method`, `class-name`, `(setf name)`
generic functions (`runtime/Mop.cs`, `runtime/Runtime.CLOS.cs:2222+`, `4302+`) — so both
`defgeneric` and load-time method installation are expressible.

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
  (`cspackages-test/system-collections-generic-sorted-list-2.lisp`).

So every generic can be `(name obj! &rest args)` and every method just forwards:
`(cl:apply #'pkg:name obj! args)`. This sidesteps CLOS lambda-list congruence entirely
(different classes' same-named members have wildly different arities) at the cost of a little
apply/dispatch overhead — which `PLAN.md` explicitly accepts as fine for v1.

## As-Built Implementation

**CLI (`Program.cs`):** `ClassSpec.DefGenericDynamic`; sticky `enableDefgenericDynamic`;
per-class `--defgeneric-dynamic`/`--no-defgeneric-dynamic`; sticky
`--enable-defgeneric-dynamic`/`--no-enable-defgeneric-dynamic`; manifest key
`:defgeneric-dynamic`.

**Lisp (`assembly-package-generator.lisp`):**
* `make-resolved-class`/`resolve-batch-entry` thread a `:defgeneric-dynamic` field, independent
  of (alongside) the static variant's `:defgeneric` field.
* `collect-class-instance-generics` — the "which wrapper names are eligible" collector — is
  **shared, mechanism-agnostic**, reused verbatim by both variants: given a class-plist,
  returns the instance method/getter names and setter names whose Lisp signature begins with
  `obj!` (excluding static members, generic/type-parameterized instance methods, and overloaded
  indexers).
* `%compute-defgeneric-model` — shared internal aggregator, parameterized on the resolved-class
  flag key (`:defgeneric` or `:defgeneric-dynamic`); `compute-defgeneric-dynamic-model` is its
  thin wrapper for this variant.
* `generate-batch-generics-dynamic-file` — writes `csharp-generics-dynamic.lisp`: one
  `cl:defgeneric`/`(cl:setf …)` `cl:defgeneric` per unified name, then per opted-in class one
  load-time install block:

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
  class under exactly that symbol, so the collision winner specializes on its simple symbol and
  the loser on its distinct FullName symbol — each on the correct class.
* `emit-defgeneric-defpackage` (shared helper) emits this variant's `csharp-generics-dynamic`
  `cl:defpackage` in `generate-batch-packages-file`, independently of the static variant's.
* `generate-batch-asd-file` adds `csharp-generics-dynamic` as its own `.asd` `:file` component
  (depending on `"packages"`, `"csharp-assembly-utils"`, and every one of *this variant's*
  opted-in classes' package files), independently of the static variant's component.

## Verification

1. `make check-parens` after any hand-edit.
2. `make build test` — regenerates `cspackages-test/csharp-generics-dynamic.lisp` and runs
   `check_parens.py` over it.
3. Manual REPL smoke: confirm `(csharp-generics-dynamic:length "abc")` and a `System.Array`
   instance both dispatch to their respective packages, and that a settable property routes
   through `(setf (csharp-generics-dynamic:… x) v)`.
4. Robustness spot-check: pick two opted-in classes and confirm each `EnsureDotNetTypeClass`
   install block specializes on the class's own `class-name`, so a same-simple-name collision
   would still attach each method to the correct class — this is the property the sibling
   static variant (`doc/make-everything-defgeneric.md`) explicitly does NOT have.
