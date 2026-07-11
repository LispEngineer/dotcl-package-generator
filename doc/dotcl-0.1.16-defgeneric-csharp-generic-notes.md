# DotCL Runtime Notes: `defmethod` Dispatch on Generic .NET Types

*(DotCL runtime version 0.1.16. Verified directly against the DotCL runtime source,
`Runtime.CLOS.cs`, checked out at `/home/dfields/src/cl/dotcl/runtime/Runtime.CLOS.cs` —
not inferred from this repo's generated output. This document is about **DotCL itself**,
not `dotcl-packagegen`'s own generator, though it directly bears on how anyone hand-writes
`defmethod`s against packages this tool generates.)*

## The question

Given a generic .NET type such as `List<T>`:

1. How does DotCL's CLOS layer dispatch `defmethod`s on it at all?
2. Can a `defmethod` distinguish a **closed** instantiation (e.g. `List<int>` vs.
   `List<string>`) from another closed instantiation of the same generic — or only
   dispatch on the **open** generic type definition as a whole?
3. What is the actual Lisp syntax for specializing on each?

## Short answer

DotCL *can* create a distinct CLOS class per closed instantiation — so dispatch that
distinguishes `List<int>` from `List<string>` is genuinely possible. But the **symbol**
your `defmethod` specializer uses to reach that class is assigned by a first-come,
first-served naming scheme that was designed for ordinary (non-generic) types. Only the
*first* closed instantiation of a given open generic that DotCL happens to register gets
the friendly, guessable symbol (`` dotcl-internal::|List`1| ``); every other closed
instantiation of that same generic still gets its own real, distinct class, but under an
ugly, assembly-qualified symbol that is not practical to predict or write literally.
There is no way to specialize on "any instantiation of `List<T>`" as a single open-generic
wildcard.

## Mechanism: `EnsureDotNetTypeClass`

Two backing tables, declared at the top of `Runtime.CLOS.cs`:

```csharp
// Runtime.CLOS.cs:11
private static readonly ConcurrentDictionary<Symbol, LispClass> _classRegistry = new(SymbolIdentityComparer.Instance);
// Runtime.CLOS.cs:13
private static readonly ConcurrentDictionary<Type, LispClass> _dotNetTypeRegistry = new();
```

- `_dotNetTypeRegistry` is keyed by the **exact CLR `Type` object**. .NET reflection gives
  `typeof(List<int>)` and `typeof(List<string>)` distinct `Type` identities (this is
  ordinary `.NET` behavior, not a DotCL choice) — so this table, in isolation, is perfectly
  capable of holding one distinct `LispClass` per closed instantiation.
- `_classRegistry` is keyed by a **Lisp `Symbol`**, and this is the table a `defmethod`
  specializer actually has to find its way into (a literal specializer like
  `` dotcl-internal::|Vector2| `` is read by the Lisp reader as a symbol, then resolved to
  a class via `find-class`/this registry).

`EnsureDotNetTypeClass(Type type)` (`Runtime.CLOS.cs:213-276`) is what bridges the two.
Walking through it:

```csharp
// Runtime.CLOS.cs:213-235
public static LispClass EnsureDotNetTypeClass(Type type)
{
    if (_dotNetTypeRegistry.TryGetValue(type, out var existing)) return existing;
    // Prefer the simple type name for the class symbol (friendly, and what
    // unquoted Lisp symbols resolve to). But simple names are ambiguous across
    // namespaces, so guard against collisions below.
    var simpleSym = Startup.Sym(type.Name);
    if (_classRegistry.TryGetValue(simpleSym, out var existingByName))
    {
        // The simple name is already taken. Adopt that class only if it is NOT
        // another .NET type's class — otherwise two same-named types from
        // different namespaces (e.g. System.Collections.ArrayList vs Other.ArrayList)
        // would share one Lisp class and misdirect class-of/typep/dispatch.
        // existingByName cannot be THIS type's class: the _dotNetTypeRegistry
        // lookup above missed.
        bool collidesWithOtherDotNetType =
            _dotNetTypeRegistry.Values.Any(c => ReferenceEquals(c, existingByName));
        if (!collidesWithOtherDotNetType)
        {
            _dotNetTypeRegistry[type] = existingByName;
            return existingByName;
        }
    }
    ...
```

1. **Cache hit on the exact `Type`** (line 215): if this precise closed (or non-generic)
   type has already been registered, return its class. Nothing generic-specific here.
2. **Compute `simpleSym` from `type.Name`** (line 219). This is the crux of the whole
   issue: `System.Reflection.Type.Name` for **any** instantiation of an open generic type
   is identical — the bare `` Name`Arity `` backtick form, with **no type arguments**
   (e.g. `` List`1 `` for both `List<int>` and `List<string>`). Only `Type.FullName`/
   `Type.ToString()` include the closed type arguments (bracketed, assembly-qualified).
   This is standard `.NET` reflection behavior, not something DotCL introduces — but
   DotCL's registry naming leans on `Type.Name`, which was clearly written with ordinary,
   non-generic types in mind.
3. **First registration of a `` List`1 ``-shaped type wins the short symbol.** If nothing
   is yet registered under `` List`1 ``, this type claims it as its friendly display name.
4. **Second (and every later) distinct closed instantiation of the same open generic
   collides.** `_classRegistry` already has *some* other `.NET` type's class under
   `` List`1 `` (specifically, the first instantiation's class) — the
   `collidesWithOtherDotNetType` check at line 228-229 is true, so this new type does
   **not** get to share that class. Continuing:

```csharp
// Runtime.CLOS.cs:236-276
    // Get or create the base class
    LispClass baseCls;
    if (type.BaseType != null && type.BaseType != typeof(object))
        baseCls = EnsureDotNetTypeClass(type.BaseType);
    else if (_classRegistry.TryGetValue(Startup.Sym("T"), out var tCls))
        baseCls = tCls;
    else
        baseCls = _classRegistry.Values.First(); // fallback

    // Name the class by simple name when that slot is free; on a cross-type
    // collision use the unique FullName so the colliding types stay distinct and
    // the first claimant keeps the friendly simple/uppercase names.
    bool simpleFree = !_classRegistry.ContainsKey(simpleSym);
    var classSym = simpleFree
        ? simpleSym
        : Startup.Sym(type.FullName
            ?? (type.Namespace is null ? type.Name : type.Namespace + "." + type.Name));

    var cls = new LispClass(classSym, Array.Empty<SlotDefinition>(), new[] { baseCls });
    var cpl = new List<LispClass> { cls };
    cpl.AddRange(baseCls.ClassPrecedenceList);
    cls.ClassPrecedenceList = cpl.ToArray();
    cls.EffectiveSlots = Array.Empty<SlotDefinition>();
    cls.IsBuiltIn = true;
    _dotNetTypeRegistry[type] = cls;
    if (simpleFree)
    {
        _classRegistry[simpleSym] = cls;
        // Also register under the uppercase name so unquoted Lisp symbols
        // (e.g. (ClsAnimal) read as CLSANIMAL) find the class correctly.
        var upperSym = Startup.Sym(type.Name.ToUpperInvariant());
        if (!ReferenceEquals(upperSym, simpleSym) && !_classRegistry.ContainsKey(upperSym))
            _classRegistry[upperSym] = cls;
    }
    else if (!_classRegistry.ContainsKey(classSym))
    {
        // Make the FullName-qualified class findable by its unique symbol.
        _classRegistry[classSym] = cls;
    }
    return cls;
}
```

5. **A genuinely new, distinct `LispClass` is always created** (line 254) for this
   `Type`, whether or not the simple name was free — this confirms point 1 of the short
   answer: a second closed instantiation is never silently merged into the first's class;
   it's a real, separate `LispClass` with its own identity and CPL.
6. **`classSym` picks the symbol this new class is filed under** (lines 248-252): the
   simple name if free, otherwise `type.FullName` (falling back to `Namespace + "." +
   Name` if `FullName` is somehow null). For a closed generic, `type.FullName` is the
   full, bracketed, assembly-qualified form, e.g.:
   ```
   System.Collections.Generic.List`1[[System.String, System.Private.CoreLib, Version=..., Culture=neutral, PublicKeyToken=...]]
   ```
7. **Which instantiation is "first" is entirely a function of program load/execution
   order** — whichever closed `List<T>` happens to be the first one DotCL's runtime is
   asked to reflect over (via `dotnet:new`, a property/method return value, an explicit
   `EnsureDotNetTypeClass`/`resolve-type` call, etc.) wins the friendly name. This is
   **not knowable at generation time or by reading source code** — it depends on actual
   runtime execution order.

Note also: unlike the ordinary same-simple-name-different-namespace collision case (where
the "winner" is a coin flip between two *conceptually equal* types), here every
instantiation of the generic is equally "canonical" — there is no principled reason one
closed form should be favored over another, which is exactly why this deserves separate
documentation from the plain-collision case.

## Worked example: `List<int>` vs. `List<string>`

Suppose your Lisp program, in this order, first touches a `List<int>` and later a
`List<string>` (e.g. two separate C# API calls returning each):

```lisp
;; First: some C# call returns a List<int>. DotCL calls EnsureDotNetTypeClass(typeof(List<int>)).
;; `List`1` is not yet registered anywhere -> List<int> claims the friendly symbol.
(defmethod describe-list ((obj dotcl-internal::|List`1|))
  (format t "a list (registered first): ~a items~%" (dotnet:invoke obj "Count")))

;; Later: another C# call returns a List<string>. DotCL calls EnsureDotNetTypeClass(typeof(List<string>)).
;; `List`1` is already taken by List<int>'s class (a genuine .NET-type collision) ->
;; List<string> gets its own class, filed under its FullName instead.
(defmethod describe-list
    ((obj dotcl-internal::|System.Collections.Generic.List`1[[System.String, System.Private.CoreLib, Version=8.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]]|))
  (format t "a list (registered second): ~a items~%" (dotnet:invoke obj "Count")))
```

Both `defmethod`s *do* correctly and separately dispatch — this proves closed-generic
dispatch works. But:

- The exact assembly-qualified string in the second specializer must match the runtime's
  actual `Type.FullName` for that exact build/architecture/culture — brittle to write and
  to keep correct across .NET version bumps.
- If your program happens to touch a `List<string>` *before* a `List<int>` at runtime
  (e.g. because of an unrelated code path, a different call order, or even nondeterministic
  ordering in concurrent code, since both registries are `ConcurrentDictionary`s with no
  documented ordering guarantee under concurrent first-touch), the two `defmethod`s above
  are now silently attached to the *wrong* class relative to what the developer assumed
  when writing them — `List<int>` would need the ugly FullName specializer and
  `List<string>` would get `` List`1 ``. Nothing in the language or the reader detects
  this; it is a silent runtime behavior swap, not an error.
- This directly parallels — and is the same underlying hazard shape as — two issues
  already documented elsewhere in this repository:
  - `doc/generator-design-notes.md`'s "Warning: Namespace Collision (Bug?)" section,
    which documents the same `EnsureDotNetTypeClass` simple-name collision mechanism for
    two *unrelated* types sharing a simple name across namespaces (e.g.
    `System.Object`/`Dougs.Special.Object`).
  - `doc/make-everything-defgeneric.md`'s "Static specializer collision caveat," which
    documents this repo's own generator emitting literal specializer symbols for
    `--defgeneric`-opted classes, and explicitly accepting (not preventing) exactly this
    kind of load-order-dependent misattachment risk.

  Those two documents are about **this repo's generator** choosing to emit literal
  specializer symbols at code-generation time for ordinary (non-generic, or open-generic-
  definition) classes. This document is about the **DotCL runtime mechanism itself**
  (`EnsureDotNetTypeClass`) that underlies all of them, applied to the specific case of
  *multiple closed instantiations of one open generic* — a case the generator's own
  metadata reflection doesn't even encounter today (per
  `doc/generator-design-notes.md`'s Version 40 section: "no arbitrary closed instantiation
  is ever itself separately reflected as its own top-level metadata entry"), but which a
  hand-written `defmethod` against generated packages can absolutely run into at runtime.

## Recommended robust pattern: resolve the class, don't guess the symbol

Because guessing which literal symbol a given closed instantiation will land on is
unreliable, the robust approach mirrors this repo's own `--defgeneric-dynamic` design
(`doc/make-everything-defgeneric-dynamic.md`): resolve the actual runtime class object for
the *specific* closed type you care about, immediately before installing the method, and
`eval` a `defmethod` against that resolved class rather than writing a literal specializer
symbol at all:

```lisp
(defun install-list-of-string-method ()
  ;; 1. Construct the exact closed generic Type you want to specialize on.
  (let* ((closed-type (dotnet:make-generic-type
                        "System.Collections.Generic.List`1" "System.String"))
         ;; 2. Force/resolve its class registration *right now*, at a point you control,
         ;;    rather than hoping it happens to be first or guessing its resulting symbol.
         (cls (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass" closed-type)))
    ;; 3. Install the defmethod against the resolved class object's own name,
    ;;    whatever DotCL actually assigned it.
    (eval `(defmethod describe-list ((obj ,(class-name cls)))
             (format t "a List<string>: ~a items~%" (dotnet:invoke obj "Count"))))))

(install-list-of-string-method)
```

This is strictly more verbose than a literal top-level `defmethod`, but it is correct
regardless of registration order, because it forces registration of *this specific* closed
type at a moment you control and then asks DotCL what symbol it actually ended up with,
rather than assuming `` List`1 `` or hand-constructing the assembly-qualified fallback
string.

There is currently **no supported way to specialize on the open generic definition as a
wildcard** (i.e., "match any `List<T>` regardless of `T`") — every registered class
corresponds to one specific closed (or non-generic) `Type`; there is no shared marker class
in the CPL that a `defmethod` could target to mean "any closing of this generic." The
closest available approximation today is to enumerate the specific closed types you expect
and write (or dynamically install, per the pattern above) one `defmethod` per closing.

## Appendix: Suggestions for DotCL

These are potential improvements to `EnsureDotNetTypeClass`/the surrounding CLOS
registration machinery, not something this repo (`dotcl-packagegen`) can fix on its own —
they'd need to land in DotCL itself.

1. **Make the friendly symbol closed-argument-aware instead of colliding on the bare
   backtick form.** Instead of naming every instantiation's candidate symbol from bare
   `type.Name` (`` List`1 ``), derive a readable *closed* form when `type.IsGenericType`
   and the type is closed — e.g. `` List`1<Int32> ``/`` List`1<String> `` (simple names of
   the type arguments, not full assembly-qualified strings). This would give every closed
   instantiation its own guessable, writable, *and* friendly symbol, eliminating the
   load-order race for the overwhelmingly common case (distinguishing a handful of closed
   instantiations of the same generic) without needing the ugly `FullName` fallback at
   all. The bare open-generic-name collision could then be reserved for the genuinely rare
   case of the *literal same closed instantiation* being independently loaded from two
   different assemblies/contexts.
2. **Expose a public lookup API so user code never has to construct a specializer symbol
   by hand.** Something like `dotnet:class-for-type`/`dotnet:find-dotnet-class`, taking
   either a `System.Type` (as already resolved via `dotnet:resolve-type`/
   `dotnet:make-generic-type`) or a type name string, returning the exact `LispClass`
   DotCL has (or will, on first call, lazily) registered for it. This would turn the
   "Recommended robust pattern" above from a workaround into the officially documented,
   first-class way to dispatch on any specific closed generic — and would also incidentally
   fix the analogous non-generic namespace-collision hazard documented in
   `doc/generator-design-notes.md`, since the same resolve-then-specialize pattern applies
   there too.
3. **Register an explicit open-generic marker class in the CPL, so "any closing of this
   generic" becomes expressible.** When `EnsureDotNetTypeClass` first encounters *any*
   closed instantiation of an open generic definition, it could also register (once) a
   class for the open generic definition itself (e.g. named from
   `type.GetGenericTypeDefinition()`, mirroring the `GetTypeIdentityFullName` fix this
   repo's own `AssemblyToLispy.cs` already applies for ancestor-matching — see
   `doc/generator-design-notes.md`'s Version 40 section for that precedent), and insert it
   into every closed instantiation's `ClassPrecedenceList` as a shared ancestor. A
   `defmethod` specializing on that marker class would then fire for *any* closing of the
   generic — directly answering "can it dispatch on the open type" with a clean yes,
   without disturbing the existing per-closed-instantiation classes or their own dispatch.
4. **Emit a diagnostic when the collision-fallback path triggers.** Currently
   `EnsureDotNetTypeClass`'s fallback-to-`FullName` branch (the `else` at line 270) is
   silent. A one-time warning (e.g. to `*error-output*`, or through whatever debug-logging
   facility DotCL already has) — "type `X` collided with an existing simple-named class;
   registered under fully-qualified name `Y` instead" — would surface the hazard the moment
   it actually occurs at runtime, instead of leaving it as a purely load-order-dependent
   silent behavior difference a developer only discovers by noticing a `defmethod` isn't
   firing. This mirrors this repository's own established philosophy of surfacing
   otherwise-silent risky situations rather than either preventing or ignoring them — e.g.
   `assembly-package-generator.lisp`'s >200-discovered-class fan-out warning, and the
   collision caveats already accepted-and-documented (not silently ignored) in
   `doc/make-everything-defgeneric.md`.

## Follow-up: DotCL 0.1.17

DotCL 0.1.17 implemented suggestions #1 (`dotnet:class-for-type`) and #2 (`defmethod`
class-object specializer support) from this appendix almost verbatim — its own `RELEASES.md`
explicitly credits this document. `dcl-packagegen`'s Generator Version 41 rebuilt
`--defgeneric` on exactly this API (see `doc/generator-design-notes.md`'s Version 41 section
and `doc/make-everything-defgeneric.md`), eliminating the entire simple-name/FullName
collision-race caveat this document analyzes above for the non-generic case.

Suggestion #3 (an open-generic marker class in the CPL) was **not** implemented in 0.1.17, and
remains the real blocker for dispatching on an open generic type's own definition (as opposed
to a specific closed instantiation, which 0.1.17's `DotNetTypeDisplayName` fix already handles
correctly). See `doc/dispatch-on-open-generics.md` for a full, current treatment of that gap
(expanding on this document's "Recommended robust pattern"/"Worked example" sections above,
which remain accurate for hand-written code targeting a specific closed instantiation), and
`doc/post-dotcl-0.1.17-generic-enhancements.md` for the living, broader post-0.1.17 follow-up
survey this note is itself now superseded by — check that document for the current status of
suggestion #4 and any newer gaps.
