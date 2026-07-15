# Bug: Master overload dispatch's non-primitive type check is unusable for
# `Nullable<T>` (`T?`) parameters — regression surfaced by Version 49's fix

## Context

This is a follow-on from `doc/bug-in-dispatching.md` ("Master overload
dispatcher can pick the wrong overload...", now fixed in Version 49). That
fix replaced the old, overly-permissive fallback type check (`(or (null arg)
(dotnet:object-type arg))`, which just asked "is this *any* wrapped .NET
object") with a precise one using `dotnet:is-instance-of` against the
parameter's actual type name (`apg-overload-dispatch.lisp`,
`format-param-type-check`, ~line 160):

```lisp
(t
 (format nil "(cl:or (cl:null ~A) (dotnet:is-instance-of ~A ~S))" arg-str arg-str param-type))
```

This is correct and necessary for ordinary reference types (`Song` vs.
`SongCollection`, etc.) — see the original doc. But it introduces a new,
previously-impossible failure mode for parameters of type `Nullable<T>`
(C#'s `T?` for a value type `T`), because `PARAM-TYPE` for those parameters
is a *simple/friendly*, non-assembly-qualified generic type name like
`"System.Nullable\`1[Microsoft.Xna.Framework.Rectangle]"`.

## Symptom

Discovered downstream in `dotcl-dungeonslime`, calling the generated
`sprite-batch:draw` wrapper (for `SpriteBatch.Draw`, which has a
`Rectangle? sourceRectangle` parameter) with a **non-null** source rectangle
— i.e. the common case of drawing a sub-region of a texture atlas. This is
called every frame from the title screen's draw loop, so the failure repeats
every frame until the process is killed:

```
;; Unhandled error in foreign callback: #<ERROR: DOTNET: type not found: System.Nullable`1[Microsoft.Xna.Framework.Rectangle]>
;; Unhandled error in foreign callback: #<ERROR: DOTNET:INVOKE SpriteBatch.Begin: Begin cannot be called again until End has been successfully called.>
```

(The second error is a downstream consequence: the `Draw` call throws
mid-`Begin`/`End` block, so `End` never runs, and the *next* frame's `Begin`
then fails too — both are the same root cause.)

Reproduced directly in a `dotcl` REPL, independent of any game code:

```lisp
DUNGEON-SLIME> (dotnet:resolve-type "System.Nullable`1[Microsoft.Xna.Framework.Rectangle]")
;; => ERROR: DOTNET: type not found: System.Nullable`1[Microsoft.Xna.Framework.Rectangle]

DUNGEON-SLIME> (dotnet:is-instance-of (rect:new 0 0 1 1) "System.Nullable`1[Microsoft.Xna.Framework.Rectangle]")
;; => ERROR: DOTNET: type not found: System.Nullable`1[Microsoft.Xna.Framework.Rectangle]

DUNGEON-SLIME> (dotnet:is-instance-of (rect:new 0 0 1 1) "Microsoft.Xna.Framework.Rectangle")
;; => T
```

## Root cause, part 1: the type name DotCL is asked to resolve isn't
   resolvable

`.NET`'s `Type.GetType(string)` (which `dotnet:resolve-type` /
`dotnet:is-instance-of` presumably call through to, directly or indirectly)
requires a **closed generic type's argument(s)** to be assembly-qualified
when the argument's defining assembly differs from the assembly containing
the generic type definition (here, `System.Nullable\`1` lives in
`System.Private.CoreLib`, but `Rectangle` lives in `MonoGame.Framework`).
The string the generator emits, `"System.Nullable\`1[Microsoft.Xna.Framework.Rectangle]"`,
has no assembly qualification on the `Rectangle` argument at all, so
resolution fails outright — this isn't a DotCL bug, it's standard, documented
.NET reflection behavior for `Type.GetType`.

This type string comes from `AssemblyToLispy.cs`'s `GetFriendlyTypeName`
(~line 967):

```csharp
private static string GetFriendlyTypeName(Type type) {
    if (type.IsGenericType) {
        string baseName = type.GetGenericTypeDefinition().FullName ?? type.GetGenericTypeDefinition().Name;
        var argNames = type.GetGenericArguments().Select(GetFriendlyTypeName);
        return $"{baseName}[{string.Join(", ", argNames)}]";
    }
    return type.FullName ?? type.Name;
}
```

used by `FormatTypeField` (~line 1005) to populate the `:type` plist key
that `format-param-type-check` (Lisp side) reads. Notably, `FormatTypeField`
*also* emits an `:assembly-qualified-type` key whenever `IsAssemblyQualified`
detects the type needs one:

```csharp
private static string FormatTypeField(string key, Type type) {
    string friendlyName = GetFriendlyTypeName(type);
    string result = $"{key} {EscapeLispString(friendlyName)}";

    if (IsAssemblyQualified(type) && type.AssemblyQualifiedName != null) {
        string aqKey = key == ":return-type" ? ":assembly-qualified-return-type" : ":assembly-qualified-type";
        result += $" {aqKey} {EscapeLispString(type.AssemblyQualifiedName)}";
    }
    return result;
}
```

So the metadata **already carries** a fully resolvable, assembly-qualified
type string for exactly this case — `format-param-type-check`
(`apg-overload-dispatch.lisp`) simply never looks at it; it always reads the
plain `:type` field (via `(cl:getf cm-p :type)` in
`format-master-overload-condition`) and never `:assembly-qualified-type`.

## Root cause, part 2: even a resolvable `Nullable<T>` type check is the
   wrong check

Fixing part 1 alone (e.g. by preferring `:assembly-qualified-type` when
present) is **not sufficient**. `Nullable<T>` has special CLR boxing
semantics: boxing a `Nullable<T>` with `HasValue == true` produces a boxed
`T`, never a boxed `Nullable<T>` — `Nullable<T>` itself can never appear as
the runtime type of a boxed/reference-typed value. (Boxing a
`HasValue == false` `Nullable<T>` produces a null reference instead.) So
`Type.IsInstanceOfType` — and therefore `dotnet:is-instance-of` no matter
how correctly its type string resolves — can **never** return true for a
`Nullable<T>` type argument, for any actual runtime value. The only two
observable states of a `T?` argument crossing this boundary are "null" and
"boxed `T`", and the existing guard already handles the null case via
`(cl:null arg)`; only the non-null case is broken.

**Fix direction**: when the parameter type is a closed
`System.Nullable\`1[...]` generic, the type check must be generated against
the *underlying type* `T`, not `Nullable<T>` itself, e.g. for
`Rectangle? sourceRectangle`:

```lisp
(cl:or (cl:null source-rectangle) (dotnet:is-instance-of source-rectangle "Microsoft.Xna.Framework.Rectangle"))
```

not

```lisp
(cl:or (cl:null source-rectangle) (dotnet:is-instance-of source-rectangle "System.Nullable`1[Microsoft.Xna.Framework.Rectangle]"))
```

This requires the C# side to expose the underlying type distinctly (e.g.
via `Nullable.GetUnderlyingType(type)`, which the codebase already uses
elsewhere for a related reflection quirk — see
`AssemblyToLispy.cs` line 754's `Nullable.GetUnderlyingType(paramType) ??
paramType`, in the DefaultValue-unwrapping code for `Nullable<TEnum>`
default parameters) — most likely as a new plist key (e.g.
`:nullable-underlying-type`, populated only when the parameter type is a
closed `Nullable<T>`), which `format-param-type-check` should prefer over
`:type`/`:assembly-qualified-type` when present, using it (assembly-qualified,
per part 1) as the actual `dotnet:is-instance-of` target.

Once this is fixed, `:assembly-qualified-type` should probably *also* be
preferred over the plain friendly `:type` for the general (non-nullable)
fallback case, since any non-primitive reference type living outside
`mscorlib`/`System.Private.CoreLib` could in principle hit the same
unqualified-resolution failure as `Nullable<T>` did here — `Nullable<T>` is
just the first case this surfaced on, not necessarily the only one. Worth
auditing whether any other closed-generic parameter type (not just
`Nullable<T>`) can currently reach `format-param-type-check`'s fallback
branch and would have the same ":type string isn't resolvable, but
:assembly-qualified-type is" problem, even without the boxing wrinkle.

## Where this was found / local workaround applied

Downstream repo: `dotcl-dungeonslime`, `title-scene.lisp`, in the
title-screen background-tiling draw call (`(sprite-batch:draw sb bg-tex
dest-rect src-rect color:+white+)`, called every frame). Worked around by
bypassing the generated `sprite-batch:draw` wrapper entirely and calling
`Draw` directly via `dotnet:invoke`, matching the pattern already used
elsewhere in that codebase (`texture-region.lisp`'s `tr-draw`, which never
went through the generated wrapper in the first place and was therefore
unaffected):

```lisp
(dotnet:invoke sb "Draw" bg-tex dest-rect src-rect color:+white+)
```

This workaround should be reverted (restoring `(sprite-batch:draw sb bg-tex
dest-rect src-rect color:+white+)`) once this generator bug is fixed and
`cspackages/` is regenerated.

## Suggested regression test

Any class with a method taking a `Nullable<T>` (`T?`) parameter for a
non-primitive value type `T` defined outside `mscorlib`/
`System.Private.CoreLib` (`Rectangle?` on `SpriteBatch.Draw` is a ready-made
real-world fixture) should be exercised with:

1. A call passing `nil`/omitting the argument for that parameter — should
   already work (guarded by `(cl:null arg)`).
2. A call passing an actual, non-null value of type `T` for that parameter
   — should select the correct overload and invoke it successfully, not
   throw `type not found` and not fall through to
   `csharp-overload-not-found`.
