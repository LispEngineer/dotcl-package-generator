# Turn Everything into Generic Methods — Static (Literal-Specializer) Variant

* Status: IMPLEMENTED (Generator Version 35).
* Related: `PLAN.md`'s "Improve Turn Everything into Generic Methods" section (the design that
  produced this variant); `doc/make-everything-defgeneric-dynamic.md` for the sibling
  load-time-install variant this one exists alongside.

## Context

Generator Version 34 shipped a working "unify every class's instance members into one shared
package of CLOS generic functions" feature (see `doc/make-everything-defgeneric-dynamic.md`),
but its generated code was judged too ugly to be the only option: every `defmethod` is
installed via `cl:eval` of a backquoted form inside a `cl:eval-when`, because the correct
specializer symbol is only knowable once DotCL resolves the class object at load time. This
document describes the alternative the original design explicitly considered and deferred —
"Simple + documented caveat" — now implemented as an independent, orthogonal second variant
under the **original** flag/package names (`--defgeneric`, `csharp-generics`), freed up when the
first variant was renamed to `-dynamic`.

## Locked design decisions

1. **Literal, generation-time `defmethod` specializer**, not a load-time-resolved one. Every
   `cl:defmethod` this variant emits is an ordinary top-level form — no `cl:eval`, no
   `cl:eval-when`, no backquote, no runtime class-object lookup. Instead, the specializer
   symbol is computed directly at generation time from the C# type's *simple name* and written
   literally into the source.
2. **Static specializer collision caveat (accepted, not guarded against).** DotCL's
   `EnsureDotNetTypeClass` (`Runtime.CLOS.cs`) names a type's CLOS class by its simple name only
   when that name is free; a same-simple-name type from a *different* namespace instead gets
   registered under its unique FullName symbol, and **which type wins that race is
   load-order-dependent** — unknowable at generation time. This variant's literal specializer
   always assumes the simple name. So: **if two `--defgeneric`-opted-in classes in the same
   batch share a simple name across different namespaces, dispatch for whichever one loses
   DotCL's registration race at load time is silently wrong** — its methods attach to the
   *other* class's CLOS class. This is a real, demonstrated failure mode (see "Demonstrated
   collision" below), documented with a comment above every class's `defmethod` block in the
   generated file, not prevented. Use the sibling `--defgeneric-dynamic` variant
   (`doc/make-everything-defgeneric-dynamic.md`) instead when this risk matters — e.g. when a
   batch includes many classes and cannot easily audit for simple-name collisions.
3. **Scope, package shape, and per-class opt-in are identical to the dynamic variant**: instance
   methods + instance property/field getters/setters (indexers included), excluding static
   members and generic/type-parameterized instance methods (whose wrapper puts a type argument
   before `obj!`). Package name: `csharp-generics`. A class may opt into this variant
   (`--defgeneric`/`--enable-defgeneric`), the dynamic variant, both, or neither — entirely
   independent, orthogonal flags.

## Exact `.NET` `Type.Name` reproduction: `dotnet-type-simple-name`

The pre-existing `simple-type-name` helper (used only for human-readable docstrings/comments
elsewhere in the generator) is **not** suitable for computing this variant's specializer symbol:
it strips the backtick generic-arity suffix (`` List`1 `` → `List`) and never splits on CIL's
`+` nested-type separator (`TimeZoneInfo+AdjustmentRule` stays whole). DotCL's
`EnsureDotNetTypeClass` registers a type's simple-name CLOS class under exactly
`Startup.Sym(type.Name)` — .NET reflection's own `Type.Name`, backtick and all, with nesting
already resolved to just the innermost segment. `dotnet-type-simple-name` reproduces this
exactly: everything after the **last** `.` or `+` in the fully-qualified name, keeping any
trailing backtick arity intact:

| Fully-qualified name | `simple-type-name` (display) | `dotnet-type-simple-name` (specializer) |
|---|---|---|
| `Microsoft.Xna.Framework.Vector2` | `Vector2` | `Vector2` |
| `` System.Collections.Generic.List`1 `` | `List` | `` List`1 `` |
| `System.TimeZoneInfo+AdjustmentRule` | `TimeZoneInfo+AdjustmentRule` | `AdjustmentRule` |

The emitted specializer symbol is `dotcl-internal::|<dotnet-type-simple-name>|` — pipe-delimited
so the Lisp reader preserves exact case and any embedded backtick, interned into the
`DOTCL-INTERNAL` package to match where `Startup.Sym` puts a name not already present in `:cl`
(`../dotcl/runtime/Startup.cs`'s `Sym`/`Internal` package).

## As-Built Implementation

**CLI (`Program.cs`):** `ClassSpec.DefGenericStatic`; sticky `enableDefgenericStatic`;
per-class `--defgeneric`/`--no-defgeneric` (bare names); sticky
`--enable-defgeneric`/`--no-enable-defgeneric` (bare names); manifest key `:defgeneric` (bare).

**Lisp (`assembly-package-generator.lisp`):**
* `collect-class-instance-generics` — shared, mechanism-agnostic collector, reused verbatim
  from the dynamic variant (see that doc).
* `%compute-defgeneric-model` (shared internal aggregator) / `compute-defgeneric-model` (this
  variant's thin wrapper, keyed on `:defgeneric`).
* `generate-batch-generics-file` — writes `csharp-generics.lisp`: one `cl:defgeneric`/
  `(cl:setf …)` `cl:defgeneric` per unified name (identical shape to the dynamic variant's),
  then per opted-in class a flat block of literal `cl:defmethod` forms:

  ```lisp
  ;; System.Numerics.Vector4 (system-numerics-vector4)
  ;; NOTE: specializes on the simple-name CLOS class dotcl-internal::|Vector4|. If another
  ;; --defgeneric-opted-in class in this batch also simplifies to that name (a same-named
  ;; type from a different namespace), only one of them keeps this symbol at load time --
  ;; dispatch for the other would be wrong. See "Static specializer collision caveat".
  (cl:defmethod w ((obj! dotcl-internal::|Vector4|) cl:&rest args)
    (cl:apply (cl:function system-numerics-vector4:w) obj! args))
  ```
* `emit-defgeneric-defpackage` (shared helper) emits this variant's `csharp-generics`
  `cl:defpackage`, independently of the dynamic variant's.
* `generate-batch-asd-file` adds `csharp-generics` as its own `.asd` `:file` component
  (depending on `"packages"`, `"csharp-assembly-utils"`, and every one of *this variant's*
  opted-in classes' package files), independently of the dynamic variant's component.

## Demonstrated collision

The `Makefile` smoke test opts both `System.Threading.Timer` and `System.Timers.Timer` into
`--defgeneric` — genuine BCL types with the same simple name (`Timer`) in different namespaces,
both exposing overlapping member names (e.g. `Dispose`). This is a deliberate demonstration of
the documented caveat, not an oversight: inspect the generated `cspackages-test/csharp-generics.lisp`
and confirm both classes' `defmethod` blocks specialize on the identical literal symbol
`dotcl-internal::|Timer|`.

**Empirically confirmed** (isolated REPL load of just these two classes' generated packages,
via `dotcl` from the sibling `../dotcl` checkout): `class-of` a `System.Threading.Timer`
instance is `#<STANDARD-CLASS Timer>` (the simple-name winner — its own `.lisp` file loaded
first), while `class-of` a `System.Timers.Timer` instance is the distinct
`#<STANDARD-CLASS System.Timers.Timer>` (the FullName-qualified loser) — confirmed not `eq`.
The actual failure is sharper than "the loser's calls fail": because **both** classes'
`defmethod dispose` forms specialize on the exact same literal symbol, ordinary CLOS
method-redefinition semantics mean the second one *replaces* the first outright — there is only
ever one `dispose` method active for that specializer, whichever class's `defmethod` form
appears later in the file (i.e., later in `--class` command-line order):
* Calling the shared generic on the **winning** type's own instance (`System.Threading.Timer`)
  errors too — `DISPOSE: wrong number of arguments: 1 (expected 2)` — because the surviving
  method actually forwards to the *other* class's wrapper function, whose arity doesn't match.
* Calling it on the **losing** type's instance (`System.Timers.Timer`) gets a clean
  `No applicable method for generic function DISPOSE`, since its actual class was never a
  specializer target at all.

So the caveat is, if anything, understated: a simple-name collision between two opted-in classes
doesn't just misdirect the loser — it can break the *winner* too, for any member name both
classes happen to share.

## Verification

1. `make check-parens` after any hand-edit.
2. `make build test` — regenerates `cspackages-test/csharp-generics.lisp` and runs
   `check_parens.py` over it; inspect the diff to confirm no `cl:eval`/`eval-when`/backquote
   anywhere in the file — only ordinary top-level `cl:defgeneric`/`cl:defmethod` forms.
3. Manual REPL smoke: confirm `(csharp-generics:length "abc")` and a `System.Array` instance
   both dispatch to their respective packages, and that a settable property routes through
   `(setf (csharp-generics:… x) v)`.
4. Collision spot-check (see "Demonstrated collision" above, empirically confirmed): load an
   isolated batch of just `System.Threading.Timer`/`System.Timers.Timer` and confirm the
   wrong-arity error on the winner and `no-applicable-method` on the loser, exactly as described.

## Known pre-existing issue found during verification (not introduced by this change)

Loading the *full* `cspackages-test` generated system (as opposed to an isolated batch) via a
real Lisp reader currently fails on an unrelated, pre-existing bug: `packages.lisp` exports C#'s
`|` (bitwise-OR) operator as a bare `#:|` token, which is unterminated/invalid Lisp syntax for a
symbol literally named `|` (it needs escaping, e.g. `#:\|`). This has been present since Version
30 (`op_BitwiseOr` → `|`) and was never caught because `check_parens.py` only validates
paren-balance, not full Lisp readability, and nothing in the existing test suite actually loads
generated output through a real Lisp reader. Not fixed here (out of scope for this feature) —
worth its own follow-up in `PLAN.md`.
