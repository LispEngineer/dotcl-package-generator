# Turn Everything into Generic Methods

* Status: IMPLEMENTED (Generator Version 41; supersedes the two earlier independent variants
  from Versions 34/35, described below under "History").
* Related: `PLAN.md`'s "Improve Turn Everything into Generic Methods" section (the design that
  produced the original two variants); `doc/generator-design-notes.md`'s Version 41 section;
  `doc/dispatch-on-open-generics.md` (the one known remaining limitation, see below);
  `doc/post-dotcl-0.1.17-generic-enhancements.md`.

## Context

`--defgeneric` unifies every opted-in class's instance methods, instance property/field
getters/setters (indexers included), and instance events (`add-X`/`remove-X` pairs) into one
shared package (`csharp-generics`) of CLOS generic functions dispatching on the C# runtime type
of the receiver — one `(name obj! cl:&rest args)` generic (or `((cl:setf name) new-value obj!
cl:&rest args)` for a setter) per unified name, with each opted-in class contributing a
`cl:defmethod` that forwards via `cl:apply` to that class's own already-generated wrapper
function.

Generator Version 41 rebuilt this on DotCL 0.1.17's `dotnet:class-for-type` (a public,
lazily-registering lookup for a .NET type's CLOS class) plus `defmethod`'s new support for a
class *object*, not just a class-name symbol, as a specializer (via read-time `#.`). Every
emitted `defmethod` now specializes on `#.(dotnet:class-for-type "<fq-name>")`:

```lisp
;; System.Threading.Timer (system-threading-timer)
(cl:defmethod change ((obj! #.(dotnet:class-for-type "System.Threading.Timer")) cl:&rest args)
  (cl:apply (cl:function system-threading-timer:change) obj! args))
```

This is an ordinary top-level form — no `cl:eval`, no `cl:eval-when`, no backquote, no
hand-written runtime lookup — that resolves the *exact* named type by its fully-qualified name
at read time and hands back its real, already-assigned CLOS class object. **Requires
`DotCL.Runtime` >= 0.1.17** (`dotcl-packagegen.csproj`'s `PackageReference`).

## Locked design decisions

1. **One mechanism, one flag.** `--defgeneric`/`--no-defgeneric` (per-class), plus sticky
   `--enable-defgeneric`/`--no-enable-defgeneric` CLI defaults. There is no longer a separate
   `--defgeneric-dynamic` variant — see "History" below for why one existed and why it was
   retired.
2. **No naming-collision caveat.** Because `#.(dotnet:class-for-type fq-name)` always resolves
   by the class's own fully-qualified name directly — never a guessed simple-name symbol — the
   pre-0.1.17 load-order-dependent "which type wins DotCL's simple-name registration race" risk
   (documented at length in this doc's Version 35-40 history, and empirically demonstrated
   against `System.Threading.Timer`/`System.Timers.Timer`, two same-simple-name BCL types) no
   longer applies. Confirmed against the same Makefile smoke-test pair: both now get their own
   correct, independent `defmethod` with no caveat comment.
3. **Known limitation: generic-arity classes are not supported.** A `--defgeneric`-opted-in
   class whose fully-qualified name is a generic type definition (e.g.
   `` System.Collections.Generic.Dictionary`2 ``) is **skipped**, with an explanatory comment,
   rather than emitting a defmethod that could never fire — DotCL's `DotNetTypeDisplayName`
   names an *open* generic's CLOS class from its own type *parameters* (e.g.
   `Dictionary<TKey,TValue>`), which never matches any real *closed* instance's registered name
   (e.g. `Dictionary<String,Int32>`). See `doc/dispatch-on-open-generics.md` for the full
   mechanism and a proposal for DotCL to support this via an open-generic marker class in the
   CPL. The class's own ordinary package is unaffected — only unified-dispatch coverage is
   missing for it.
4. **Scope and per-class opt-in unchanged from the original design**: instance methods +
   instance property/field getters/setters (indexers included) + instance events (`add-X`/
   `remove-X` pairs, added in Generator Version 37 after a real-world report of a missing
   `add-click`), excluding static members and generic/type-parameterized instance methods
   (whose wrapper puts a type argument before `obj!`).

## As-Built Implementation

**CLI (`Program.cs`):** `ClassSpec.DefGenericStatic`; sticky `enableDefgenericStatic`;
per-class `--defgeneric`/`--no-defgeneric`; sticky `--enable-defgeneric`/`--no-enable-defgeneric`;
manifest key `:defgeneric`.

**Lisp (`assembly-package-generator.lisp`):**
* `collect-class-instance-generics` — collects eligible method/setter names per class,
  unchanged across this consolidation.
* `%compute-defgeneric-model` (internal aggregator) / `compute-defgeneric-model` (public thin
  wrapper).
* `generic-arity-fq-name-p` — checks for .NET's backtick arity suffix in a fully-qualified name,
  used to detect and skip a generic-arity class (see limitation 3 above).
* `generate-batch-generics-file` — writes `csharp-generics.lisp`: one `cl:defgeneric`/
  `(cl:setf …)` `cl:defgeneric` per unified name, then per opted-in class either a flat block of
  literal `cl:defmethod` forms (specializing on `#.(dotnet:class-for-type "<fq-name>")`) or, for
  a generic-arity class, a skip comment.
* `emit-defgeneric-defpackage` emits the `csharp-generics` `cl:defpackage`.
* `generate-batch-asd-file` adds `csharp-generics` as its own `.asd` `:file` component
  (depending on `"packages"`, `"csharp-assembly-utils"`, and every opted-in class's own package
  file).

## History

**Version 34** shipped the original working mechanism: every `defmethod` installed via
`cl:eval` of a backquoted form inside a `cl:eval-when`, because — pre-0.1.17 — the correct
specializer symbol was only knowable once DotCL resolved the class object at load time. Judged
too ugly to be the only option.

**Version 35** split this into two independent, orthogonal variants: the Version 34 mechanism,
renamed `--defgeneric-dynamic`/`csharp-generics-dynamic` (robust, ugly generated code), plus a
new sibling under the freed-up `--defgeneric`/`csharp-generics` names emitting a **literal**
specializer symbol computed at generation time (`dotcl-internal::|<simple-name>|`) — simple,
readable generated code, but carrying an accepted collision caveat: DotCL's
`EnsureDotNetTypeClass` names a type's CLOS class by its simple name only when free, and *which*
same-simple-name type wins that race across a batch was load-order-dependent and unknowable at
generation time. **Version 36** made that caveat's per-class comment report actual, known
conflicts (`build-simple-name-index`/`classify-simple-name-conflicts`) instead of a purely
hypothetical warning.

**Version 41** retired both variants outright and replaced them with the single mechanism
described above, once DotCL 0.1.17 made it possible to get Version 35's generated-code
simplicity *and* Version 34's collision-proof robustness at the same time — see
`doc/generator-design-notes.md`'s Version 41 section for the full rationale, and
`doc/dotcl-0.1.16-defgeneric-csharp-generic-notes.md` for the prior-cycle research (credited by
DotCL's own RELEASES.md) that drove the DotCL 0.1.17 API this consolidation depends on. The
`--defgeneric-dynamic` flags, `csharp-generics-dynamic` package, and all supporting Lisp
machinery (`generate-batch-generics-dynamic-file`, `compute-defgeneric-dynamic-model`, the old
`dotnet-type-simple-name`/`build-simple-name-index`/`classify-simple-name-conflicts` collision
machinery) were deleted, not deprecated — this was a clean break, since the new mechanism
strictly dominates both predecessors for every case it supports.

## Verification

1. `make check-parens` after any hand-edit.
2. `make build test` — regenerates `cspackages-test/csharp-generics.lisp` and runs
   `check_parens.py` over it; inspect the diff to confirm no `cl:eval`/`eval-when`/backquote
   anywhere in the file — only ordinary top-level `cl:defgeneric`/`cl:defmethod` forms, and no
   `csharp-generics-dynamic.lisp` file at all.
3. Manual REPL smoke: confirm `(csharp-generics:length "abc")` and a `System.Array` instance
   both dispatch to their respective packages, and that a settable property routes through
   `(setf (csharp-generics:… x) v)`.
4. Collision spot-check: the Makefile smoke test opts both `System.Threading.Timer` and
   `System.Timers.Timer` into `--defgeneric` — confirm both now get their own correct,
   independent `defmethod` (no shared literal symbol, no caveat comment).
5. Generic-arity skip spot-check: the Makefile smoke test opts
   `` System.Collections.Generic.Dictionary`2 ``/`` System.Collections.Generic.SortedList`2 ``
   into `--defgeneric` — confirm each gets a `SKIPPED` comment, not a dead `defmethod`.

## Known pre-existing issue found during verification (not introduced by this change)

Loading the *full* `cspackages-test` generated system (as opposed to an isolated batch) via a
real Lisp reader currently fails on an unrelated, pre-existing bug: `packages.lisp` exports C#'s
`|` (bitwise-OR) operator as a bare `#:|` token, which is unterminated/invalid Lisp syntax for a
symbol literally named `|` (it needs escaping, e.g. `#:\|`). This has been present since Version
30 (`op_BitwiseOr` → `|`) and was never caught because `check_parens.py` only validates
paren-balance, not full Lisp readability, and nothing in the existing test suite actually loads
generated output through a real Lisp reader. Not fixed here (out of scope for this feature) —
worth its own follow-up in `PLAN.md`.
