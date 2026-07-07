# Package Generator Design Notes

* Author: Douglas P. Fields, Jr. - symbolics@lisp.engineer
* Copyright 2026 Douglas P. Fields, Jr.

**Provenance:** The sections below are excerpts extracted from
`dotcl-dungeonslime/doc/implementation-notes.md` and
`dotcl-dungeonslime/doc/opencode-implementation-notes.md`. Those source files
are mixed-content documents covering both the DungeonSlime *game* and the
package generator *tool*; only the generator-relevant sections were pulled
out here (game-specific chapters, general DotCL/build/ASDF topics, and
DungeonSlime's own migration/refactor logs were intentionally omitted). See
those two source files for full context and the parts not reproduced here.

---

## Generating Constants for Static Properties

*(from implementation-notes.md, "Lisp Packages for C# Classes")*

The `assembly-package-generator.lisp` tool generates Lisp bindings for .NET assemblies.
By default, it generates static properties (like `Vector2.Zero` or `Color.White`) as dynamic
symbol macros via `(define-symbol-macro ...)` since they are technically properties, not
constant fields, and reflection cannot distinguish whether a static read-only property's
value could change.

However, many types like `Microsoft.Xna.Framework.Vector2` and `Microsoft.Xna.Framework.Color`
have properties that act identically to constants. To optimize these, the `--constant-properties`
command-line flag was added to the generator. It accepts a comma-separated list of properties
to treat as compile-time constants (evaluated at macro-expansion load-time in Lisp using
`defconstant`). Passing `*` (e.g., `--constant-properties "*"`) marks all read-only
static properties of the class as constants.

Example Usage:
```bash
dotcl-packagegen --out-dir cspackages --assembly MonoGame.Framework.dll --class Microsoft.Xna.Framework.Color --constant-properties "*"
```

(Current versions of the tool take an assembly `.dll` directly and reflect its metadata as
part of the same invocation; see `README.md`/`CLAUDE.md` for the up-to-date CLI shape.)
This forces properties like `Color.White` to be emitted as `(defconstant +white+ ...)`
instead of `(define-symbol-macro white ...)` improving performance and avoiding repeated
reflection evaluations.

## Direct Method Calls via Type Declarations

*(from implementation-notes.md)*

Starting in DotCL 0.1.11, method calls on C# instances can be optimized to direct
calls (avoiding runtime reflection and boxing/unboxing overhead, resulting in an
approximate 3.5x performance increase) by wrapping the receiver object in a
type declaration using the `the` operator.

The syntax for declaring a .NET type for a receiver is:
```lisp
(the (dotnet "Fully.Qualified.TypeName") receiver-form)
```

For instance, in `assembly-package-generator.lisp`, instance method stubs are
automatically optimized for reference types (classes/interfaces, excluding
structs and enums which are value types and not yet supported by `the` casting)
like so:
```lisp
(defun dispose (obj!)
  (dotnet:invoke (the (dotnet "Microsoft.Xna.Framework.Graphics.SamplerState") obj!) "Dispose"))
```

If the actual object passed at runtime does not match the declared type, DotCL
will raise a `DotCL.LispErrorException` indicating the invalid cast.

## .NET CLOS Integration in DotCL 0.1.9

*(from implementation-notes.md)*

DotCL 0.1.9 introduces the ability for CLOS generic functions (`defgeneric`)
to dispatch natively on instances of C# classes created via `dotnet:define-class`
as well as raw C# framework types (e.g., `Microsoft.Xna.Framework.Vector2`).

### Class Registration and Naming

When DotCL encounters a native C# object for the first time, or when `(class-of obj)`
is explicitly called on it, DotCL lazily creates a CLOS wrapper class for the .NET type.
This wrapper is placed in the `dotcl-internal` package and named after the short name
of the C# class.
For example, `Microsoft.Xna.Framework.Vector2` becomes `dotcl-internal::|Vector2|`.

Internally, this registration happens in the DotCL compiler/runtime source code within
`Runtime.CLOS.cs`, specifically in the `EnsureDotNetTypeClass(Type type)` function.
This function creates a new `LispClass` and inserts it into the global `_classRegistry`
dictionary, mapping the simple C# name (and its uppercase variant) to the CLOS class wrapper.
Because `EnsureDotNetTypeClass` recursively calls itself on the type's `BaseType`, invoking
`class-of` on a C# object recursively creates a Lisp class hierarchy that accurately mirrors
the .NET inheritance tree (e.g. `System.ValueType`, `System.Object`).

**This is directly relevant to the generator**: every generated package registers its
class via `(dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass" (dotnet:resolve-type "..."))`,
so the caveats below apply to anyone writing `defmethod`s against generated packages' types.

To specialize a `defmethod` on a raw C# type, use an internal symbol as the class specializer:
```lisp
(defmethod get-x ((obj dotcl-internal::|Vector2|))
  (dotnet:invoke obj "X"))
```

### Warning: Namespace Collision (Bug?)

Because `EnsureDotNetTypeClass` explicitly uses the *short name* of the C# type
(`type.Name` instead of `type.FullName`), it is impossible to distinguish between
classes with the same name in different namespaces (e.g., `System.Object`
and `Dougs.Special.Object`).

When DotCL encounters the first of these classes, it registers `dotcl-internal::|Object|`
and maps the C# type to it. When it encounters the second class, it queries `_classRegistry`
with the same short name, finds the existing CLOS wrapper, and binds the second C# type to
the exact same CLOS class.

Consequences:
1. **Broken Method Dispatch**: A `defmethod` targeting `dotcl-internal::|Object|` will
   fire indiscriminately for instances of both `System.Object` and `Dougs.Special.Object`.
   It is not possible to specialize methods for one but not the other.
2. **Broken Inheritance**: The `ClassPrecedenceList` in Lisp is evaluated only for the first
   type registered. The second type completely loses its own inheritance tree in the Lisp
   layer and silently adopts the CPL of the first class.

### The Compile-Time Constraint

In Common Lisp, `defmethod` is a macro that expands at compile time. During this
expansion, it calls `find-class` to verify the existence of the class being specialized.

If a top-level `(defmethod ... ((obj dotcl-internal::|Vector2|)) ...)` is included statically
in code compiled by the standalone DotCL compiler (which only loads standard .NET runtime
libraries, not application-specific assemblies like a generated package's target assembly),
the compiler will attempt to resolve `Vector2`, fail to find the assembly, and hard-crash
compilation with `FIND-CLASS: no class named Vector2` or
`DOTNET: type not found: Microsoft.Xna.Framework.Vector2`.

### Workarounds

**Option 1: The `eval` Workaround** — defer the macro-expansion of `defmethod` until
*runtime*, when the target assembly is fully loaded, by quoting the method definition
and passing it to `eval` inside a function:
```lisp
(defun register-clr-methods ()
  ;; 1. Force the registration of the CLOS wrapper class.
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "Microsoft.Xna.Framework.Vector2"))
  ;; 2. Dynamically evaluate the defmethod at runtime.
  (eval '(defmethod get-x ((obj dotcl-internal::|Vector2|))
           (dotnet:invoke obj "X"))))
```

**Option 2: Loading Assemblies at Compile Time** — use `eval-when` to explicitly load the
required assembly `.dll` and register types during both `:compile-toplevel` and
`:load-toplevel` phases, so standard top-level `defmethod` forms work natively:
```lisp
(eval-when (:compile-toplevel)
  (dotnet:load-assembly "/path/to/Assembly.dll")
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
    (dotnet:resolve-type "Microsoft.Xna.Framework.Vector2")))

(eval-when (:load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass" (dotnet:resolve-type "Microsoft.Xna.Framework.Vector2")))

(defmethod get-x ((obj dotcl-internal::|Vector2|))
  (dotnet:invoke obj "X"))
```

### Defining C# Types from Lisp

When defining new C# proxy classes from Lisp using `dotnet:define-class` (or its
underlying components), always pass parameter and field types as fully-qualified strings
(e.g., `"System.Double"`) instead of unquoted symbols (e.g., `System.Double`).
Symbols without string qualification might fail to resolve during macro expansion if the
namespace environment isn't strictly controlled, whereas explicit string declarations
correctly guide DotCL's internal reflection (`dotnet:resolve-type`).

## Parentheses Balance Checking

*(from implementation-notes.md, "Mismatched Parentheses in Common Lisp")*

Mismatched parentheses in Common Lisp can lead to extremely confusing compilation
errors, such as package lookup failures or symbols being reported as not external.
This occurs because an extra or missing parenthesis can cause the Lisp reader
to exit a macro definition or top-level form prematurely, causing subsequent forms
to be parsed in the wrong context or skipped entirely.

As soon as any compilation problems or other errors are encountered, the parentheses
balance of all modified files must be checked individually. See `check_parens.py`
and the `make check-parens` / `make test` targets in this project's own `BUILD.md`
for the tooling that implements this check (ported from `dotcl-dungeonslime`).

## Instance Properties and Struct "Boxing Mutation"

*(originally from implementation-notes.md; corrected in Version 29 — see that section
below for the full story of what was wrong and how it was found)*

The generator (`assembly-package-generator.lisp`) emits accessor (`property-name`)
and mutator (`(setf property-name)`) functions for C# instance properties.

A struct (value type) obtained from Lisp — via `dotnet:new`, `dotnet:static`, a property
getter, or a stored constant — is never a raw unboxed Lisp value; it's a `#<DOTNET ...>`
reference to a boxed CLR object. Invoking a setter on an instance property of that boxed
struct via `dotnet:invoke`'s `setf`-expansion mutates *that exact boxed instance* directly
— it does **not** discard the mutation on some separate throwaway copy. This holds
regardless of how the new value argument is itself produced (`dotnet:box`, a real invoked
conversion call, or a `the`-typed literal all behave identically here).

The practical caveat this leaves is not "the mutation is lost" but the opposite: **if
that boxed instance is aliased anywhere else** — another Lisp variable bound to the same
object, or (much more importantly) a `defconstant` constant that was only ever
one-time-evaluated to that exact box — mutating it through any one alias mutates it for
every other alias too. See the Version 29 section below for why this makes
`--constant-properties`-selected struct constants (e.g. `Vector2.Zero`, `Color.White`)
a genuine hazard, and `FEATURES.md`'s "Struct Boxing Caveat" section for user-facing
guidance.

In addition, Lisp properties with only a setter (write-only properties) are generated
with the name `set-propertyname` and accept the receiver as the first argument:
`(set-propertyname obj! new-value)`.

### Example Transcript

Real, verified `make repl` output against `dotcl-dungeonslime` (loads generated packages
including `color:`):

```lisp
DUNGEON-SLIME> (defparameter x color:+white+)
DUNGEON-SLIME> x
#<DOTNET Microsoft.Xna.Framework.Color {R:255 G:255 B:255 A:255}>
DUNGEON-SLIME> (setf (color:r x) (dotnet:box 37 "System.Byte"))
DUNGEON-SLIME> x
#<DOTNET Microsoft.Xna.Framework.Color {R:37 G:255 B:255 A:255}>
DUNGEON-SLIME> (setf (color:r x) (dotnet:static "System.Convert" "ToByte" 40))
DUNGEON-SLIME> x
#<DOTNET Microsoft.Xna.Framework.Color {R:40 G:255 B:255 A:255}>
DUNGEON-SLIME> (setf (color:r x) (the (dotnet "System.Byte") 55))
DUNGEON-SLIME> x
#<DOTNET Microsoft.Xna.Framework.Color {R:55 G:255 B:255 A:255}>
DUNGEON-SLIME> color:+white+
#<DOTNET Microsoft.Xna.Framework.Color {R:55 G:255 B:255 A:255}>
```

Note the last line: `color:+white+` — a `defconstant` — was itself permanently mutated.
This is the shared-mutable-constant hazard described in the Version 29 section below.

## TimeSpan Standard Operator Dispatchers

*(from implementation-notes.md, "Local Nickname Migration and TimeSpan Operator Dispatchers")*

**Superseded.** This section describes the Version 13 implementation. Two things it
describes no longer exist in current-version generated output: `monoutils:dotnet-p` was
replaced by `dotnet:object-type` in Version 23 (see "Self-Contained Runtime Support"
below), and the separate type-suffixed wrapper functions this section names (e.g.
`+-time-span-time-span`, `*-time-span-double`) were removed entirely in Version 24
("Overload Consolidation," below) — today's Master Wrapper `cond` calls
`dotnet:static`/`dotnet:invoke` directly, inline, with no separate named function per
overload. The dispatch-by-argument-count-and-type *idea* this section describes is still
exactly how operator overloads work today; only the specific named-function mechanism it
describes has changed.

Standard operators like `+`, `-`, `*`, and `/` are overloaded in C#'s
`System.TimeSpan`. The package generator emitted generic runtime dispatchers for
these, passing the operator strings directly to `dotnet:static` (e.g., `(apply
#'dotnet:static <type-str> "+" args)`).

However, .NET static operators compiled in IL have special names (such as
`op_Addition`, `op_UnaryPlus`, `op_Subtraction`, `op_UnaryNegation`,
`op_Multiply`, `op_Division`), so calling `"+"` or `"-"` directly via
`dotnet:static` results in `System.MissingMethodException`.

To fix this, the operators inside a generated `system-time-span.lisp` were
refactored to perform type and argument count dispatching purely in Lisp,
calling the correct typed static method wrapper functions:
* **`-`**: Calls `--time-span-time-span` (`op_Subtraction`) for 2 arguments, or
  `--time-span` (`op_UnaryNegation`) for 1 argument.
* **`+`**: Calls `+-time-span-time-span` (`op_Addition`) for 2 arguments, or
  `+-time-span` (`op_UnaryPlus`) for 1 argument.
* **`*`**: Inspects if the first argument is a C# object (via
  `monoutils:dotnet-p`) to dispatch to `*-time-span-double` (`op_Multiply`) or
  `*-double-time-span` (`op_Multiply`).
* **`/`**: Inspects if the second argument is a C# object (via
  `monoutils:dotnet-p`) to dispatch to `/-time-span-time-span` (`op_Division`)
  or `/-time-span-double` (`op_Division`).

---

# Generator Version History (Detailed Design Notes)

The generator's own `*generator-version*` docstring in `assembly-package-generator.lisp`
has the authoritative one-line-per-version changelog. The sections below are the fuller
design rationale for several versions, extracted from `implementation-notes.md` and
`opencode-implementation-notes.md`.

## C# Assembly Package Generator v10: Method Overload Support

*(from opencode-implementation-notes.md)*

### Overview

This documents the implementation of version 10 of the
`assembly-package-generator.lisp`, which adds automatic generation of
method wrappers for overloaded C# methods. Previously (v9), only
non-overloaded "simple" methods were generated. Methods with multiple
overloads like `Vector2.DistanceSquared`, `Rectangle.Intersects`, and
`Rectangle.Contains` were skipped entirely, requiring hand-written wrappers.

Version 10 introduces a method classification system that categorizes
overloads as "clean" (no ref/out/params/defaults) or "dirty" (has
special parameter modifiers), and generates appropriate wrappers for
each case.

### Method Classification

Four helper functions were added:

- **`clean-method-p`** — Like `simple-method-p` but without the unique-name
  check; returns t if a method has no ref/out/params/defaults/generics.
- **`dirty-method-p`** — Returns t if a method has ref/out/params/defaults.
  Complement to `clean-method-p`.
- **`method-overload-name`** — Generates a disambiguated Lisp function name
  by appending kebab-cased simple parameter type names. E.g.,
  `Contains(Vector2)` → `contains-vector-2`.
- **`method-signature-str`** — Returns a human-readable signature string for
  doc-comments, e.g., `Contains(ref Rectangle, out bool) → void`.

### Overload Handling Categories

Methods are grouped by name. Each group falls into one of four cases:

1. **No clean overloads** (all dirty): Emit a doc-comment listing the
   skipped overloads. No functions generated.
2. **Single clean overload**: Generate a single typed function with
   the base name. Includes `(the (dotnet "Type") obj)` typed-call
   optimization for value type receivers. Emits doc-comment for any
   accompanying dirty overloads.
3. **Multiple clean overloads** (2+): Generate a passthrough &rest
   function that dispatches at runtime via DotCL's overload resolver,
   plus per-overload typed functions with type-suffixed names for
   direct invocation. Emits doc-comment for any dirty overloads.
4. **Operators and accessors**: Unchanged from v9 — handled separately
   by existing `op_`/`get_`/`set_` prefix filtering.

### Value-Type Typed-Call Optimization

In v9, the `(the (dotnet "Type") obj)` wrapper was only emitted for
reference-type (class) receivers. Value types (structs) used bare
`(dotnet:invoke obj ...)`. In v10, the wrapper is emitted for ALL
receivers, including value types. DotCL 0.1.11 supports the
`constrained.` + `callvirt` IL pattern needed for value type virtual
dispatch via typed declarations.

### Static Method Argument Type Hints

For single-clean-overload static methods, the generated code now wraps
each argument in `(the (dotnet "<type>") arg)` to improve DotCL's
caching efficiency.

## C# Generic Method Wrappers (Generator Version 12)

*(from implementation-notes.md, "C# Generic Function Type Checking Refactoring")*

To support invoking generic methods of exactly one type argument from Lisp, the C# Lisp Package Generator has been enhanced:

* **Metadata Extraction**: `AssemblyToLispy.cs` formats generic methods by exporting `:is-generic t` and `:generic-arity [count]` (retrieved via `method.IsGenericMethod` and `method.GetGenericArguments().Length`).
* **Schema Validation**: Updated the testing schema (`tests/framework.lisp` and the metadata test suite) to allow `:is-generic` and `:generic-arity` keywords inside method property lists, preventing validation failures.
* **Method Classification**: Modified `simple-method-p` and `clean-method-p` in `assembly-package-generator.lisp` to support generic methods if their generic arity is exactly 1.
* **Wrapper Generation**: Generated Lisp functions take the `type` parameter (supporting type name string, alias, or System.Type object) as the first argument (or second argument after `obj` for instance methods). The wrapper delegates invocation to DotCL's `dotnet:invoke-generic` or `dotnet:static-generic` interop targets by passing `(list type)` as the type arguments list.

## C# Package Object Constructors (Version 11)

*(from implementation-notes.md, "Chapter 16: SpriteFont Text Rendering")*

### Struct Parameterless Constructor Injection
In .NET Reflection, value types (structs) do not return their implicit parameterless constructor
via `GetConstructors()`. To generate the correct parameterless `new` constructors for value types,
the generator (`assembly-package-generator.lisp`) checks if the type is a struct (`:kind :struct`).
If it is a struct and no zero-parameter constructor is found in the metadata, the generator
injects a default parameterless constructor `(:parameters nil :public t)` into its internal
constructors list.

### Overload Collision Prevention
For types with multiple clean constructors, the generator outputs a runtime dispatch `new`
function using `&rest` arguments. Additionally, type-suffixed constructors (e.g.,
`new-single-single`) are generated for performance or explicit dispatch. However, if a
constructor has zero parameters, its type-suffixed name would be `new`, colliding with and
overwriting the runtime dispatch `new` function.
To resolve this collision, the generator skips creating the type-suffixed function for any
zero-parameter constructor when a type has multiple clean constructors. The runtime dispatch
`new` function handles the parameterless case correctly when called without arguments: `(new)`.

## C# Operator Overload Dispatch in Package Generator (Generator Version 13 & 14)

*(from implementation-notes.md)*

### 1. Type-Based Operator Dispatching (Version 13)
The C# Lisp Package Generator has been enhanced in Version 13 to automatically generate type- and argument-count-aware dispatch wrappers for C# operator overloads (methods whose name starts with `"op_"` in C#, such as `op_Addition` and `op_Subtraction`, which are mapped to Lisp symbols like `+` and `-`):
* **Runtime Dispatch**: For overloaded operators, instead of outputting generic `(apply #'dotnet:static ...)` calls with raw operator symbols (e.g. `"+"` or `"-"`) which fail with `System.MissingMethodException`, the generator now emits a Lisp `cond` block.
* **Overload Selection**: The `cond` block inspects the runtime argument count and types (numbers, booleans, strings, or `.NET` objects) and dispatches the call to the corresponding type-suffixed generated overload functions (e.g. `+-time-span-time-span` or `*-time-span-double`). **Superseded in Version 24** ("Overload Consolidation," below): these separate type-suffixed functions were removed entirely; the same `cond`-based dispatch logic now calls `dotnet:static`/`dotnet:invoke` directly, inline, inside one Master Wrapper.
* **Safe Fallback**: If no overload matches the argument patterns, a descriptive runtime error is thrown.

### 2. Standard Lisp Package Qualification (Version 14)
When standard Lisp operators (like `=`) are shadowed in a generated package (like `:system-time-span` shadowing `=`), any un-qualified calls to `=` in that package will resolve to the shadowed operator rather than the standard Common Lisp comparison function `cl:=`.
* **The Bug**: In Version 13, the generated test conditions (e.g. `(= (length args) 2)`) inside `:system-time-span` resolved to `system-time-span:=`. This caused recursive dispatch attempts with integer arguments (e.g. calling `op_Equality(int, int)`), leading to `MissingMethodException`.
* **The Fix**: In Version 14, the generator qualified all standard Lisp comparison operations in generated tests using the `cl:` package prefix (e.g., `(cl:= (length args) 2)`), ensuring they are evaluated as built-in Lisp functions rather than shadowed operator wrappers.

## Namespace Safety & Standard Lisp Symbol Protection (Version 15)

*(from implementation-notes.md)*

The Lisp Package Generator has been enhanced in Version 15 to establish complete namespace safety, preventing generated wrappers from shadowing critical Lisp syntax symbols and resolving symbol name collisions.

### 1. Mapping Special Forms & Reserved Words
In Common Lisp, symbols like `quote` and `function` are special operators used by reader macros `'` and `#'`. If a package shadows them, reader macros expand to package-local symbols (e.g. `microsoft-xna-framework-vector2:quote`), which crashes Lisp evaluation.
* **The Bug**: When generating wrappers for types containing members named `Quote`, `Function`, `T`, or `Nil`, the generator would output Lisp symbols like `quote` and `function` and place them in the package's `:shadow` list, causing syntax/compilation failures.
* **The Fix**: Version 15 maps C# member names named `Quote`, `Function`, `T`, or `Nil` to safe names `quote!`, `function!`, `t!`, and `nil!` respectively. This keeps them out of the package's `:shadow` list and preserves standard Common Lisp reader behavior.

### 2. Standard Lisp Symbol Qualification
To prevent other shadowed symbols in generated packages (such as `length`, `nth`, `cond`, `and`, `or`, `error`, `setf`, `defun`, `apply`, `function`, `the`, `list`, `numberp`, `typep`, `stringp`, `boolean`, `t`, etc.) from colliding with standard Lisp operators inside generated templates, the generator now qualifies all standard Lisp operators in generated templates with the `cl:` package prefix.
* **Examples**:
  - `(cond ...)` -> `(cl:cond ...)`
  - `(length args)` -> `(cl:length args)`
  - `(and ...)` -> `(cl:and ...)`
  - `(nth idx args)` -> `(cl:nth idx args)`
  - `(defun ...)` -> `(cl:defun ...)`
  - `(apply ...)` -> `(cl:apply ...)`
  - `(the ...)` -> `(cl:the ...)`
  - `(setf ...)` -> `(cl:setf ...)`
  - `(error ...)` -> `(cl:error ...)`
This prevents type-cast exceptions like `Unable to cast object of type 'DotCL.Cons' to type 'DotCL.LispDotNetObject'` when calling generated operator functions.

## Struct Mutation, Boxing, and Overload Resolution (Version 16)

*(from implementation-notes.md — excerpt; the source file's "Workaround" subsection is
DungeonSlime-specific game code and is not reproduced here)*

### 1. Static vs. Instance Method Name Collisions

In C#, a class can define an instance method and a static method with the exact same name. For example, `Microsoft.Xna.Framework.Vector2` defines:
- `public void Normalize()` — an instance method that normalizes the vector in-place (returns `void`).
- `public static Vector2 Normalize(Vector2 value)` — a static method that returns a new normalized vector.

In the Lisp wrapper package generator, methods are grouped by name to generate overload dispatchers. Because both methods are named `Normalize`, they were grouped together. However:
- The generator previously determined if a method group was static based on the first method in that group. Since the instance method `Normalize()` appeared first, the entire group was classified as non-static (`static-p` is `nil`).
- Consequently, the static overload was generated as an instance method `normalize-vector2` (incorrectly expecting an `obj` receiver and using `dotnet:invoke` on it), and the passthrough dispatcher `normalize` was overwritten by a 1-argument instance wrapper `(cl:defun normalize (obj))`.

In Version 16, this was resolved by tracking `is-static-overload-p` per individual clean method overload (via `(getf cm :is-static)`) rather than using the group-wide `static-p`. This ensures that static overloads grouped with instance methods (such as `Vector2.Normalize(Vector2)`) are correctly generated as static wrappers utilizing `dotnet:static` without requiring an implicit `obj` receiver.

### 2. Struct Boxing & In-Place Mutation — CORRECTED (2026-07-04)

**This subsection originally claimed** that calling a struct-mutating instance method
(such as `Vector2.Normalize()`, which mutates in place and returns `void`) only mutates a
throwaway boxed copy on the heap, discarded once the call returns, leaving the original
Lisp reference unmodified — with a worked (but never actually run) example claiming
`(v2:normalize (v2:new normal-x normal-y))` leaves the vector un-normalized.

**A live `make repl` session against `dotcl-dungeonslime` disproved this**, exactly as the
"Instance Properties and Struct 'Boxing Mutation'" section's own claim was disproven (see
its corrected text and the Version 29 section above — this is the same underlying
mechanism, just reached via a mutating method call instead of a property `setf`):
```lisp
DUNGEON-SLIME> (defparameter v (v2:new 3.0 4.0))
V
DUNGEON-SLIME> v
#<DOTNET Microsoft.Xna.Framework.Vector2 {X:3 Y:4}>
DUNGEON-SLIME> (v2:normalize v)
NIL
DUNGEON-SLIME> v
#<DOTNET Microsoft.Xna.Framework.Vector2 {X:0.6 Y:0.8}>
```
`v` **was** normalized in place. `v` is a `#<DOTNET ...>` reference to a boxed CLR object,
not a raw Lisp value; DotCL's typed-receiver invocation path (the
`(the (dotnet "Type") obj!)` wrapper this repo's own Version 10 introduced specifically to
enable the `constrained.`+`callvirt` IL pattern for value-type virtual dispatch — see "Direct
Method Calls via Type Declarations" above) operates on that exact boxed instance. There is
no separate "discard the mutated copy" step for a mutating instance method any more than
there was for a property setter.

`(v2:normalize v)` printing `NIL` is a *separate*, still-true fact, unrelated to whether the
mutation stuck: `Normalize()` returns `void` in C#, so the Lisp wrapper function itself
always evaluates to `nil`. The original text conflated "the expression's return value is
`nil`" with "the mutation was lost" — they are independent facts, and only the first one is
true.

**The one part of the original guidance that remains genuinely useful**: because
`Normalize()` (and any `void`-returning mutating method) evaluates to `nil`, writing
`(setf v (v2:normalize v))` would overwrite `v` with `nil` — a real footgun, just an
unrelated one from the "mutation is lost" claim. Correct usage is `(v2:normalize v)` alone
(mutates `v` in place; discard the `nil` return value), not reassigning `v` from the call's
result.

**Corrected workaround guidance**: preferring a static method that returns a new struct
instance (e.g. `Vector2.Normalize(Vector2)`) is no longer necessary *for correctness* — the
generated instance-method wrapper mutates in place correctly. It may still be a reasonable
*style* preference to avoid surprise mutation-through-aliasing: the same aliasing hazard the
Version 29 section describes for property `setf` applies equally here — if the struct being
mutated is aliased elsewhere (most notably, a `--constant-properties`-cached `defconstant`),
calling a mutating instance method on it mutates that shared instance too, silently and
permanently. But that is a caution about aliasing, not a claim that instance-method mutation
doesn't work.

## Idiomatic Lisp Naming Conventions (Version 17)

*(from implementation-notes.md)*

To make C# package wrappers feel more idiomatic to Common Lisp developers, Version 17 of the C# Lisp Package Generator updates the naming conventions for specific types of methods and fields:

### 1. NaN and IsNaN Mapping
- **`NaN` Constant**: Mapped directly to `"nan"` in `camel-to-kebab` so that constant wrappers for `NaN` (such as `System.Double.NaN`) generate as `+nan+` instead of the literal kebab-case `+na-n+`.
- **`IsNaN` Methods**: Mapped to `"nan?"` instead of the literal `is-na-n`.

### 2. IsSomething Boolean Predicates Suffix
- Any method or property whose C# name starts with `"Is"` followed by an uppercase letter (e.g. `IsEmpty`, `IsActive`, `IsFinite`) is translated to a Lisp predicate ending with a question mark `?` (e.g. `empty?`, `active?`, `finite?`), replacing the `is-` prefix.
- If the name is exactly `"Is"` or does not start with an uppercase letter following "Is" (e.g. `"Issue"`), the name is translated normally without the question mark conversion.

## C# Package Overload Resolution Enhancements (Version 18)

*(from implementation-notes.md)*

To support seamless interop for overloaded C# methods, the Lisp Package Generator implements Version 18 overload resolution rules:

### 1. Index-Based Positional Prefix Determination
Previously, the generator determined the common positional parameter prefix across overloads based on both name matching and lack of default values. However, C# overloads can use different parameter names for the same positional slots (e.g. `FromMilliseconds(double value)` vs `FromMilliseconds(long milliseconds)`).
- **Rule**: The positional prefix is now determined solely by the lack of default values up to `min-len` of the overloads, ignoring parameter names.
- **Variable Mapping**: Positional parameters are mapped in the generated master wrapper lambda list using parameter names from the first overload. During invocation code generation (`format-master-overload-action`), parameters are mapped back by positional index rather than name, ensuring variables are correctly bound and passed to the C# interop.

### 2. Literal Package Names in Fallback Conditions
When an overloaded method call fails to match any valid C# signature at runtime, the generator signals a `csharp-overload-not-found` error.
- **Fix**: The package name parameter is now generated as a literal string constant computed at generation time (e.g. `"MICROSOFT-XNA-FRAMEWORK-VECTOR2"`) rather than querying `(cl:package-name *package*)` at runtime. This guarantees accurate, package-independent diagnostics.

### 3. Optional Positional Overload Dispatch
To support overloaded methods like binary/unary operators (e.g. `TimeSpan.+` and `Vector2.+`) and multi-arity positional methods (e.g., `Rectangle.Contains`), the generator determines optional positional parameters beyond the minimum overload parameter length:
- **Maximum Mandatory Length**: The generator computes `max-mandatory-parameter-len` across all overloads.
- **Optional Parameter Collection**: Positional parameters between `min-len` and `max-mandatory-len` are generated in the master wrapper lambda list using `cl:&optional` (with `supplied-p` variables) instead of keyword arguments.
- **Strict Dispatching**: Master wrapper `cond` clauses evaluate both argument type checks and `supplied-p` presence flags to accurately dispatch to the correct C# overload signature.

## Nested Type Package Naming (Version 19)

C#'s CIL representation separates a nested type from its enclosing type with
a `+` (e.g. `Type.FullName` for `Glyph` nested inside `SpriteFont` is
`Microsoft.Xna.Framework.Graphics.SpriteFont+Glyph`). `AssemblyToLispy.cs`
uses this value verbatim for `:fully-qualified-name`, and it must stay
verbatim there: `monoutils:get-type`, `dotnet:resolve-type`, and `dotnet:the`
type hints all require the literal `+`-form to resolve the live CLR type.

Before Version 19, `camel-to-kebab` — which derives the generated Lisp
package name and output filename from `:fully-qualified-name` — only
special-cased `.` (mapping it to `-`); every other character, including
`+`, was copied through unchanged. This leaked a literal `+` into the
package/file name, plus a spurious extra hyphen from the uppercase-letter
hyphen-insertion logic misreading the `+` as "not already a separator"
(e.g. `microsoft-xna-framework-graphics-sprite-font+-glyph.lisp`).

**First attempt (reverted)**: making `camel-to-kebab` itself treat `+` like
`.` seemed like the obvious fix, but `camel-to-kebab` is *also* applied to
already-mapped member/operator names, not just type names — and
`AssemblyToLispy.cs` maps the C# `+` operator (`op_Addition`) to the
literal one-character Lisp name `"+"` upstream (see its operator-name
mangling table). Passing that already-correct `"+"` through a `+`-aware
`camel-to-kebab` silently turned `System.TimeSpan`'s `(cl:defun + ...)`
master wrapper into `(cl:defun - ...)` — a working operator turned into a
different, wrong one, with no error anywhere. Caught by `make test`'s
`cspackages-test/` diff showing an unrelated-looking change in
`system-time-span.lisp`.

**Actual fix**: a new, narrowly-scoped `type-fq-name-to-pkg-name` helper
wraps `camel-to-kebab`, substituting `+` → `-` in the input *before*
camel-casing — but only at the two call sites that convert a *type's*
`fully-qualified-name` to a display name (`generate-class-file`'s
`pkg-name`/`output-file`, and the `csharp-overload-not-found` condition's
`:package-name` slot). `camel-to-kebab` itself is completely unchanged, so
every other caller (member names, parameter names, and already-mapped
operator symbols like `+`, `-`, `=`) is unaffected:

```
Microsoft.Xna.Framework.Graphics.SpriteFont+Glyph
  -> microsoft-xna-framework-graphics-sprite-font-glyph
AssemblyToLispyTestTarget.NestingContainer+NestedLevel2+NestedLevel3
  -> assembly-to-lispy-test-target-nesting-container-nested-level2-nested-level3
```

Every reflection-facing use of `fq-name` (`<type>`, `<type-str>`,
`dotnet:resolve-type`, `dotnet:the` hints) reads it raw, never through
`type-fq-name-to-pkg-name` or `camel-to-kebab` — a nested type's generated
package still resolves the correct live CLR type via its `+`-separated
`<type-str>`.

## Generic Type Backtick Sanitization (Version 20)

Discovered immediately after Version 19, while adding an open-generic type
(`System.Collections.Generic.Dictionary\`2`) to the checked-in test
packages for the first time: .NET's open-generic-type names carry a
backtick-and-arity suffix (`` `N ``, e.g. `` Dictionary`2 `` or
`` System.Action`4 ``, per `AssemblyToLispy.cs`'s
`GetSimplifiedTypeName`/backtick-formatting helpers — see
`doc/assembly-to-lispy.md`). Like `+`, this backtick was previously copied
through `type-fq-name-to-pkg-name`/`camel-to-kebab` unchanged into the
generated package name and filename.

Unlike `+`, a raw backtick isn't merely an unwanted-but-inert character —
it is a Lisp reader macro character (the backquote/quasiquote prefix).
`(cl:defpackage :system-collections-generic-dictionary\`2 ...)` does
*not* read back as one symbol token followed by `defpackage`'s options
list; the reader stops the symbol token at the backtick and starts a new
backquote form there, so it actually parses as
`(CL:DEFPACKAGE :SYSTEM-COLLECTIONS-GENERIC-DICTIONARY (QUOTE 2) ...)` —
silently corrupting the form (wrong package name, and `(quote 2)` where
`(:use :cl)` was supposed to be) rather than raising an error anywhere. No
existing test caught this because nothing had previously fed a
backtick-bearing type all the way through `generate-class-file`; earlier
uses of backtick names in this codebase were metadata-only string
comparisons (e.g. matching `:name` in `tests/synthetic-target.test.lisp`),
never round-tripped through the Lisp reader.

**Fix**: `type-fq-name-to-pkg-name` now also flattens `` ` `` to `-`,
alongside `+`, before camel-casing. Unlike `+`, backtick is never
legitimately part of a member/operator name anywhere in this codebase
(only `Type.Name`/`Type.FullName` ever carry it, per
`AssemblyToLispy.cs`), so there is no analogous risk of corrupting an
intentional single-character Lisp symbol — the substitution still lives in
`type-fq-name-to-pkg-name` rather than `camel-to-kebab`, to keep all
type-name sanitization in one place:

```
System.Action`4                                        -> system-action-4
System.Collections.Generic.Dictionary`2                 -> system-collections-generic-dictionary-2
System.Collections.Generic.Dictionary`2+KeyCollection    -> system-collections-generic-dictionary-2-key-collection
```

## Batch ASDF System Generation (Version 21)

A single-pass invocation now also writes a `csharp-assembly-packages.asd` into `--out-dir`,
alongside the generated `.lisp` package files, so the whole batch can be loaded with one
`(asdf:load-system "csharp-assembly-packages")` instead of hand-writing a system definition or a
pile of `(load ...)` calls.

`generate-batch-asd-file` (`assembly-package-generator.lisp`) is called from
`generate-assembly-packages-batch` once every requested class's `.lisp` file has been written.
It reuses `type-fq-name-to-pkg-name` — the same function `generate-class-file` uses for the
file's actual name — so each `:components` entry (`(:file "<pkg-name>")`) is guaranteed to match
a real generated file, in the same order the classes were requested on the command line.

* `:version` is the short, 2-digit `*generator-version*` (this generator-behavior-shape version,
  e.g. `"21"`).
* `:long-description` additionally records the full `dotcl-packagegen` CLI/application version
  (obtained via a new `utils:get-system-version`, a non-printing counterpart to the existing
  `utils:print-system-version` used by `--version`), the generation timestamp, and, per assembly,
  each requested class's fully-qualified name, assigned package name, and any
  constant-properties.
* No `:depends-on` is emitted yet, even though every generated package's runtime code needs
  `monoutils`/`utils` (provided by this repo's own `dotcl-packagegen` system) — deferred to a
  later version.

## Consolidated packages.lisp (Version 22)

Class `.lisp` files no longer emit their own `(cl:defpackage ...)`. Instead, a single-pass
invocation writes one `packages.lisp` into `--out-dir` holding every requested class's
`defpackage` form, and each class file keeps only its `(cl:in-package :<pkg-name>)` — the
package must already exist by the time a class file is loaded.

The export/shadow-symbol computation that used to live inline inside `generate-class-file` was
extracted into `compute-package-exports-and-shadows` (same field/property/method-group walk, same
deduplication, same CL-external-symbol shadow detection — no behavior change), so both
`generate-class-file` (which still needs `pkg-name` for its `in-package` form) and the new
`generate-batch-packages-file` share one source of truth for a class's export list.

`generate-batch-packages-file` follows the same accumulate-then-write-once pattern as
`generate-batch-asd-file` (Version 21): it is called from `generate-assembly-packages-batch`
with the full `entries-with-resolved` list, before the per-class `generate-class-file` loop runs,
so `packages.lisp` exists on disk ahead of the files that depend on it. Each package's
`defpackage` form is preceded by a 3-line comment block:

```lisp
;;; Source File: some-class1.lisp
;;; C# Class: Some.Namespace.Type1
;;; Constant Properties: (none)
(cl:defpackage :some-namespace-type1
  ...)
```

`Constant Properties` prints the comma-joined list passed via `--constant-properties` (matching
the format already used in the `.asd`'s `:long-description`), or the literal `(none)` when empty,
so every block has the same 3-line shape regardless of whether constant properties were
requested. One blank line separates each package's block from the next.

Because class files now depend on `packages.lisp` having been loaded first, `generate-batch-asd-file`
(Version 21) was updated to reflect that dependency explicitly rather than relying on component-list
order alone: `csharp-assembly-packages.asd`'s `:components` now lists `(:file "packages")` first,
and every class `:file` entry gains `:depends-on ("packages")`.

## Self-Contained Runtime Support (Version 23)

Generated output previously referenced this tool's own `monoutils`/`utils` packages at three
runtime call sites — but a batch handed to a downstream project never shipped those packages, so
generated code was never actually self-contained, contrary to this repo's stated goal.
Investigation found `monoutils:dotnet-p`/`boxed-dotnet-p` are not portable Lisp at all: they are
native primitives registered into DotCL by this tool's own `MonoUtilsRegistrar.Initialize()`
(`MonoUtils.cs`), unreachable from any host that doesn't happen to load this exact assembly.

Two of the three call sites had a stock-DotCL equivalent already available (DotCL 0.1.15,
`Runtime.DotNet.cs`), so no custom code needs to ship for them at all:

* The per-class `<type>` constant (`(cl:defconstant <type> ...)`) now calls `dotnet:resolve-type`
  directly instead of `monoutils:get-type` — the latter only ever wrapped that same call for a
  string argument, the only way generated code ever invoked it, and `dotnet:resolve-type` is
  already used a few lines later in the same file for CLOS type registration.
* `format-param-type-check`'s fallback for non-primitive C# parameter types now emits
  `(dotnet:object-type arg)` (returns the wrapped `Type`, truthy, if `arg` is a
  `LispDotNetObject`/`LispDotNetBoxed`; `NIL` otherwise) instead of `(monoutils:dotnet-p arg)` —
  an exact drop-in replacement with identical semantics, no native registration required.

The third — the `csharp-overload-not-found` condition raised by master-overload dispatch
fallback clauses — is genuine custom Lisp logic (a `cl:define-condition`) with no stock
equivalent, so it now ships with every batch: a single-pass invocation writes
`csharp-assembly-utils.lisp` into `--out-dir` (`generate-batch-utils-file`, mirroring
`generate-batch-asd-file`'s accumulate-then-write-once shape), and emitted `cl:error` forms
reference `csharp-assembly-utils:csharp-overload-not-found` instead of
`utils:csharp-overload-not-found`.

Following the Version 22 convention that every `defpackage` form lives in `packages.lisp`, the
`csharp-assembly-utils` package's `defpackage` is *not* in `csharp-assembly-utils.lisp` — it's
written into `packages.lisp` (via `generate-batch-packages-file`) ahead of the per-class
`defpackage` loop, and `csharp-assembly-utils.lisp` itself only has `(cl:in-package
:csharp-assembly-utils)` plus the condition definition, exactly the shape every class file
already has relative to `packages.lisp`.

Both pieces of static content — the `defpackage` form and the condition definition — are copied
verbatim from two new, real, hand-written, independently loadable and `check_parens.py`-able
source files: `csharp-assembly-utils-package.template.lisp` and
`csharp-assembly-utils.template.lisp`. `generate-batch-packages-file`/`generate-batch-utils-file`
read them with `uiop:read-file-string` rather than reconstructing their content via `format`
calls, so the actual known-good, testable source is what ships, not a generator-code
approximation of it. Both templates are named with a `.template.lisp` double extension (not bare
`.lisp`) and copied next to the built executable via `dotcl-packagegen.csproj`'s `<Content>`
pattern — the same one already used for `dotcl-packagegen.asd`'s own version introspection —
and `Program.cs` resolves and passes both paths down as two new scalar arguments on the
`RUN-ASSEMBLY-PACKAGE-GENERATOR-BATCH` call.

`csharp-assembly-packages.asd`'s `:components` gained `(:file "csharp-assembly-utils"
:depends-on ("packages"))` (its `in-package` form needs that package to already exist), and
every per-class `:file`'s `:depends-on` became `("packages" "csharp-assembly-utils")`, since
class bodies now reference `csharp-assembly-utils:csharp-overload-not-found`.

## Overload Consolidation (Version 24)

Every overloaded method already got a single dispatching "Master Wrapper" (Version 18) — a
`defun` with `&optional`/`&key (var init supplied-p)` parameters and a `cond` block that
inspects argument types/`supplied-p` flags to invoke the exact right C# overload. But
`generate-class-file` *also* kept emitting one type-suffixed direct-call function per clean
overload alongside that wrapper (e.g. `contains-vector-2`, `get-ambiguous-time-offsets-date-time`),
purely as an optional fast/explicit path — and exporting all of them. For methods with many
overloads this produced exactly the long, ugly export lists `PLAN.md`'s "Overload Consolidation"
section called out. Since the Master Wrapper's `cond` dispatch already selects the correct
overload with full precision, these functions were redundant, not load-bearing, and Version 24
removes their generation and export entirely (`generate-class-file`, `compute-package-exports-and-shadows`).
`method-overload-name`/`constructor-overload-name` remain as internal helper functions (still
exercised directly by `package-generator-tests.lisp`) but are no longer called from the
generation path.

Constructors never had a Master Wrapper — multiple clean constructors instead got a bare
`(cl:defun new (cl:&rest args) (cl:apply #'dotnet:new <type-str> args))` passthrough (relying on
DotCL's own runtime overload resolution) plus the same type-suffixed direct-call functions
(`new-single-single`, etc.). Version 24 gives constructors a real Master Wrapper too
(`generate-constructor-master-wrapper`), built from the same helpers the method wrapper uses
(`common-parameter-prefix`, `max-mandatory-parameter-len`, `collect-optional-positional-params`,
`collect-key-params`, `format-master-overload-condition` — none of which depend on
static/instance-ness or a method name, so they're directly reusable) plus a new
`format-constructor-master-overload-action` that emits `(dotnet:new <type-str> ...)` instead of
`dotnet:invoke`/`dotnet:static`. `master-overload-param-names` was factored out of
`format-master-overload-action` to share the prefix/optional/keyword→positional-index parameter
name mapping between the method and constructor action formatters. This also makes the
Version 11 zero-parameter-constructor-name-collision workaround moot: since there's no longer a
type-suffixed `new` (which is what collided with the dispatcher's own `new` name), there's
nothing left to special-case.

To avoid losing the per-overload documentation that lived in the deleted functions' docstrings,
every Master Wrapper's docstring (method or constructor) now enumerates every overload it covers:
a header line, then one block per overload with that overload's human-readable signature
(`method-signature-str`/`constructor-signature-str`) followed by its own XML-doc-sourced
Summary/Returns/Parameters text (reusing `build-docstring`), indented underneath. Two new helpers
implement this: `format-overload-doc-block` (one overload's block) and
`format-combined-overloads-docstring` (the full docstring, called with `#'method-signature-str`
or `#'constructor-signature-str` depending on which kind of overload group it's covering).

### Positional Parameter Name Collisions (Constructor Master Wrapper)

Giving constructors a Master Wrapper immediately surfaced a latent bug in
`collect-optional-positional-params`, previously unreachable because nothing exercised the
Master Wrapper machinery on an overload group whose arities aren't a single monotonically-growing
family. For each positional dispatch slot beyond the common mandatory prefix, that function picks
its representative parameter from whichever overload happens to be first (in metadata order) with
a parameter present at that index — but nothing guarantees overloads at different indices don't
reuse the same parameter name for unrelated purposes. `System.TimeSpan`'s constructors are a real
example: `new(Int32 hours, Int32 minutes, Int32 seconds)` and
`new(Int32 days, Int32 hours, Int32 minutes, Int32 seconds)` both have a `seconds` parameter, but
at index 2 and index 3 respectively — two genuinely different slots that happened to share a
name. Emitting both as `(cl:defun new (... seconds ... seconds ...))` is an invalid lambda list
(duplicate variable).

`uniquify-positional-params` fixes this generically: given the ordered `prefix` ++ `opt-params`
list, it renames (via a numeric suffix, e.g. `seconds2`) any slot whose mapped Lisp name collides
with an earlier slot's. Both `generate-master-wrapper` (methods) and
`generate-constructor-master-wrapper` (constructors) run their raw `prefix`/`opt-params` through it
before building the lambda list, so every downstream consumer (`format-master-overload-condition`,
`master-overload-param-names`, `format-supplied-args-expr`) sees already-unique names without
needing its own collision logic — this exact latent bug applies equally to methods, not just
constructors, though no case in the checked-in test packages happened to trigger it there.

## Receiver Parameter Renamed to `obj!` (Version 25)

Every instance method/property wrapper's hardcoded receiver parameter was literally named
`obj` (`generate-single-overload`, `generate-master-wrapper`, `format-master-overload-action`,
and the instance-property getter/setter generation in `generate-class-file`). This collides
when the underlying C# method has its own parameter also named `obj` — e.g.
`System.Object.Equals(object obj)` mapped its one C# parameter to the Lisp name `obj` (via
`map-param-name`, which is a near-identity mapping for a name that's already lowercase and has
no reserved-word conflict), producing the invalid lambda list `(cl:defun equals (obj obj) ...)`.

The fix renames the hardcoded receiver to `obj!` everywhere it's emitted. This name is
collision-proof by construction: `map-param-name` (the *only* function that turns a C# parameter
name into a generated Lisp parameter name) only ever kebab-cases the name and, for the two
reserved words it special-cases, appends `-val` (`t` → `t-val`, `nil` → `nil-val`) — it never
appends a trailing `!`. That suffix is only ever produced by `map-member-name`, for *method/property
names*, not parameter names. So no C# parameter, regardless of its name, can ever map to `obj!`.
This mirrors the existing "protect a name the generator itself needs" pattern established in
Version 15 for `quote!`/`function!`/`t!`/`nil!`.

## Indexer Support (Version 26)

Prior to Version 26, `AssemblyToLispy.cs`'s `FormatPropertyPlist` never called
`PropertyInfo.GetIndexParameters()`, so a C# indexer (`this[...]`) reached the generator
indistinguishable from an ordinary parameterless property. `generate-class-file`'s instance-property
loop then emitted a getter/setter taking only the receiver (`obj!`) — e.g.
`Dictionary<TKey,TValue>`'s indexer became `(cl:defun item (obj!) ... "get_Item")`, silently
dropping the required `key` argument. This wasn't just an unimplemented feature: the generated
function *looked* correct (it compiled, exported, and had a plausible name) but could never
actually retrieve or store a value at runtime — calling it would either error out inside
`dotnet:invoke` (wrong arity for `get_Item`) or, worse, silently misbehave.

**The fix, in two parts:**

1. **Reflection (`AssemblyToLispy.cs`)**: `FormatPropertyPlist` now calls
   `prop.GetIndexParameters()` and, when non-empty, formats them via the existing
   `FormatParameterPlist` (the same helper methods and constructors already use) into a
   `:parameters` key on the property plist — structurally identical to how a method's own
   parameters are represented. An ordinary (non-indexer) property still omits `:parameters`
   entirely, so existing consumers of the metadata format are unaffected.

2. **Codegen (`assembly-package-generator.lisp`)**: a property plist carrying `:parameters` is now
   an indexer (`indexer-property-p`). Since ordinary C# properties can never be overloaded but
   indexers can (e.g. `this[int]` alongside `this[string]` on the same class — both reflect as
   distinct `PropertyInfo` entries both named `Item`), instance properties are first grouped by
   name (`group-properties-by-name`, mirroring `method-groups`'s hash-table grouping) before
   generation:
   * A group with exactly one property plist generates as before, except the getter/setter's
     lambda list and `dotnet:invoke` call now thread the index parameter(s) through positionally,
     inserted between the receiver (`obj!`) and, for the setter, the new value — matching C#'s own
     `set_Item(index..., value)` parameter order. An ordinary property (no index parameters) emits
     byte-for-byte the same code as before Version 26, since the conditional `~@[ ... ~]` `format`
     directives contribute nothing when there are no index parameters to insert.
   * A group with two or more property plists (an overloaded indexer) is **not yet supported** —
     picking which signature a single generated function should dispatch to isn't well-defined
     without the same kind of type-based `cond` dispatch overloaded methods already get. Rather
     than guess (and risk silently generating a wrapper for the wrong signature), the generator
     documents every signature in a comment and emits no function at all, mirroring the existing
     dirty-method/dirty-constructor "documented but unsupported" treatment
     (`method-signature-str`/`constructor-signature-str`'s sibling, `property-signature-str`).
   `compute-package-exports-and-shadows` (which independently determines `packages.lisp`'s
   `defpackage` exports without re-running `generate-class-file`'s own body-generation logic)
   received the identical grouping and single-signature-only-exports treatment, so it never
   exports a function name for an overloaded indexer that `generate-class-file` won't actually
   define.

## Public Instance Fields and Multi-Type-Argument Generic Methods (Version 27)

Two capability gaps, both flagged as highest-priority in
`doc/claude-suggested-improvements-20260703.md`, are addressed together in Version 27.

### Public Instance Fields

Prior to Version 27, a public instance field (e.g. a plain mutable field on a simple data-holder
class or struct) generated *nothing at all* — no getter, no setter, not even a documenting
comment the way an unsupported ("dirty") method overload gets. The predicate that should have
driven this, `public-instance-field-p`, existed but was never called anywhere in the file — a
silent, invisible gap, and arguably worse than an unsupported feature that's at least documented
in the generated output.

**Why fields need different codegen than properties.** A C# property has named accessor methods
(`get_Foo`/`set_Foo`) that the existing instance-property codegen simply invokes by name via
`dotnet:invoke`. A field has no such accessor methods — reflection reads/writes it directly.
`dotnet:invoke` (per `doc/dotnet-dotcl-interop.md` and `doc/package-dotnet.md`) does support
reading a field directly by name (its binding flags include `BindingFlags.GetField`), so the
getter is just as simple as a property's:
```lisp
(dotnet:invoke (cl:the (dotnet "Fq.Type") obj!) "FieldName")
```
But `dotnet:invoke` has no field-write equivalent — its own binding flags only cover
`GetProperty`/`GetField`, not `SetField`. Writing a field (or property, or indexer) directly is
instead the job of `dotnet:invoke`'s own `setf`-expansion (`dotnet:%set-invoke` under the hood),
which *does* include `BindingFlags.SetField`. So the setter uses that idiom directly, rather than
invoking a named setter method the way a property's setter does:
```lisp
(cl:setf (dotnet:invoke (cl:the (dotnet "Fq.Type") obj!) "FieldName") new-value)
```

**Read-only fields.** A C# `readonly` instance field reflects with `:init-only t` in the field
plist (the same flag already used for static readonly fields, `runtime-readonly-field-p`).
`InvokeMember`'s `SetField` flag would throw at runtime against a truly readonly field, so the
generator only emits a setter when `:init-only` is absent — mirroring exactly how an instance
property already only gets a setter when `:writeable` is present. The getter is always emitted
(a public field, like a public property, is always at least readable).

**Where it lives:** a new `instance-fields` binding (`(remove-if-not #'public-instance-field-p
fields)`) alongside the existing `instance-props`/`instance-prop-groups` bindings, in both
`generate-class-file` and `compute-package-exports-and-shadows`; a new codegen block placed right
after the Instance Properties block (before Methods) in `generate-class-file`; and a matching
exports-only loop in `compute-package-exports-and-shadows` (a field's getter and setf-able setter
share one Lisp symbol, so only one export entry is needed per field, exactly like properties).

### Generic Methods of Arity > 1

Prior to Version 27, `simple-method-p`/`clean-method-p` hard-restricted generic methods to
`(or (not is-generic) (eql arity 1))` — a method with two or more of its own type parameters (e.g.
LINQ's `Select<TSource,TResult>`, `Join`, `ToDictionary<TSource,TKey,TResult>`) was classified
"dirty" and skipped with a comment, the same treatment as a `ref`/`out`/`params` method. This was
a large practical gap: most of LINQ's `Enumerable` surface is multi-type-argument generic methods.

**Generalizing the wrapper's type-argument parameters.** The arity-1 wrapper (Version 12) hardcoded
a single Lisp parameter literally named `type`, passed to `dotnet:invoke-generic`/
`dotnet:static-generic` as `(cl:list type)`. `generic-type-param-names` generalizes this: arity 1
still returns the single legacy name `("type")` (so existing arity-1 generated code, and any
caller already passing that parameter positionally, is completely unaffected byte-for-byte), while
arity N > 1 returns `("type-1" "type-2" ... "type-N")`, one Lisp parameter per type argument.
`generate-single-overload`, `generate-master-wrapper`, and `format-master-overload-action` all use
this instead of the hardcoded `"type"`/`(cl:list type)`, passing `(cl:list type-1 type-2 ...)` to
`dotnet:invoke-generic`/`dotnet:static-generic` so DotCL can instantiate the method with however
many type arguments it actually needs.

`generic-method-arity-supported-p` replaces the old `(eql arity 1)` check with "any positive
integer arity", used identically by both `simple-method-p` and `clean-method-p`.

**The same-name, different-arity problem (Aggregate).** Generalizing arity alone isn't safe by
itself: C# allows the *same* method name to be overloaded across *different* generic arities.
`System.Linq.Enumerable.Aggregate` is the canonical real-world example — it has three same-named
overloads, of generic arity 1, 2, and 3 respectively. Before Version 27 this was moot, since arity
2 and 3 were simply excluded; but naively accepting all arities and merging same-named overloads
into one wrapper (the existing Master Wrapper machinery groups overloads purely by method name)
would be actively wrong: **one Lisp function's lambda list cannot flex between different numbers of
generic type-argument parameters** — a wrapper that binds `type-1 type-2` has no way to also serve
a 1-type-argument or 3-type-argument call.

The fix splits before generating:
* `method-generic-cell-key` returns a method's generic-arity "cell" identity: `nil` for a
  non-generic method, or its integer `:generic-arity` for a generic one.
* `split-by-generic-arity` partitions a method-name group's (already static/instance-partitioned,
  already "clean") overloads into one ordered sub-list per distinct cell. The overwhelmingly common
  case — every overload non-generic, or every generic overload sharing one arity (e.g. `Select`'s
  two arity-2 overloads, which differ only in an ordinary parameter's type, not generic arity) —
  produces exactly one cell, so nothing changes from how these already worked.
* `generic-arity-suffix` names a cell: `""` for non-generic, `"-arity-N"` for arity N.
* `generate-method-name-wrappers` (which replaces the four near-identical
  single-overload-or-master-wrapper call sites that used to be duplicated across the
  mixed-mode/single-mode `cond` branches in `generate-class-file`'s method loop) generates one
  function per cell, using the plain base name when there's only one cell, or the arity-suffixed
  name when there's more than one. For `Aggregate`, this produces `aggregate-arity-1`,
  `aggregate-arity-2`, and `aggregate-arity-3` instead of one broken merged function — and none of
  them claim the bare `aggregate` name, since which arity "deserves" the unsuffixed name is not
  well-defined.
* `method-name-wrapper-names` mirrors `generate-method-name-wrappers`'s naming decisions (same
  `split-by-generic-arity` call, same suffixing rule) without generating any code, so
  `compute-package-exports-and-shadows` exports exactly the set of names `generate-class-file` will
  actually define.

This same per-cell splitting applies uniformly to the mixed-mode (static + instance overloads
sharing a name) case too: `generate-method-name-wrappers` is called once for the instance-clean
list and once for the static-clean list (with the static base name already `*`-suffixed as before),
each independently split by generic arity.

## Generic-Arity Two-Tier Dispatch (Version 28)

Version 27's `-arity-N` suffixes fully solved the same-name/different-arity correctness problem
(see above), but at the cost of an unbounded public export surface: `Enumerable.Aggregate` exported
three separate names (`aggregate-arity-1`, `aggregate-arity-2`, `aggregate-arity-3`), inconsistent
with Version 24's Overload Consolidation, which keeps every other overloaded method's public surface
to at most two names (`foo`/`foo*` for instance vs. static — see "Master Wrapper with Precise
Dispatch" above). Version 28 brings generic-arity dispatch in line with that precedent: at most one
new exported name, `base-name<>` (or bare `base-name` in one case below), replaces the whole family
of arity-suffixed exports; the old per-arity bodies still exist, verbatim, but only as unexported
internal implementation details.

**Classifying a method name's generic-arity cells.** `generic-arity-dispatch-mode` looks at the
cells `split-by-generic-arity` already computes for one method name (within one static/instance
mode) and returns one of three symbols:

* `:single` — exactly one cell (the overwhelmingly common case: every overload non-generic, or every
  generic overload sharing one arity, e.g. `Select<TSource,TResult>`'s two arity-2 overloads). No
  dispatch is generated at all; `base-name` is the one and only function, byte-identical to Version
  27's (and earlier) output for this case.
* `:split-with-plain` — more than one cell, and one of them is the non-generic (`nil`-keyed) cell:
  a non-generic overload of this name coexists with generic ones at other arities. `base-name`
  handles the non-generic overload(s) only (no type argument); a new `base-name<>` dispatcher handles
  every generic cell.
* `:split-all-generic` — more than one cell, none of them non-generic (the real-world `Aggregate`
  case: arity 1, 2, and 3, with no non-generic overload at all). `base-name` itself becomes the
  dispatcher — no `<>` suffix, since there is no non-generic call form to disambiguate it from.

**The dispatcher.** `generate-generic-arity-dispatcher` emits a function (named `base-name<>` or
bare `base-name`, per the mode above) whose first parameter, `types`, accepts either a single .NET
type (a type-name string, alias, or `System.Type` object — treated as arity 1) or a `cl:list` of
types (arity = its length). `cl:listp` distinguishes the two unambiguously, since a type argument
is itself never a Lisp list. The remaining arguments are forwarded via `&rest`/`apply` straight
through to whichever internal per-arity function (`internal-arity-fn-name`, see below) the resolved
arity names — the dispatcher never needs to know that function's own lambda-list shape, which may
itself be a Master Wrapper's `&optional`/`&key` list (e.g. `group-by-arity-3`, an arity-3 cell that
is itself a 2-overload Master Wrapper). A `cl:t` fallback signals the existing
`csharp-assembly-utils:csharp-overload-not-found` condition (reused, not a new condition type) when
`types`'s length matches none of the method's known arities.

In the `:split-with-plain` case specifically, the dispatcher also accepts an **empty** list (or
`nil`) for `types`, in which case it applies straight through to the plain, non-generic `base-name`
function instead of erroring — so a caller that generically loops over "call this with N type
arguments" doesn't need to special-case N=0 into a differently-named function. This has no analogue
in `:split-all-generic`, since there is no non-generic overload to fall through to there; an empty
`types` list simply falls into the `csharp-overload-not-found` fallback in that case.

**Internal per-arity functions.** The bodies Version 27 generated under `aggregate-arity-1`,
`aggregate-arity-2`, etc. are unchanged — `generate-generic-cell-wrapper` (an extraction of the
single-overload-vs-Master-Wrapper branch that Version 27's `generate-method-name-wrappers` already
had inline) still calls `generate-single-overload`/`generate-master-wrapper` exactly as before per
cell. Only their *export status* changes: `internal-arity-fn-name` (still just
`base-name` + `generic-arity-suffix`, unchanged) names them, but `method-name-wrapper-names` no
longer lists them, so `compute-package-exports-and-shadows` never exports them. They remain
individually reachable/debuggable via `package::aggregate-arity-2` if ever needed. No new "internal"
naming convention (e.g. a `%`-prefix) was introduced for this, since none already existed anywhere
in this file to be consistent with, and reusing the proven Version-27 names/bodies verbatim is the
lowest-risk option.

**Static/instance interaction.** No change was needed to `generate-class-file`'s method loop: it
still calls `generate-method-name-wrappers` once per static/instance mode with the same arguments,
and the static base name is already `*`-suffixed *before* `generate-method-name-wrappers` ever
appends `<>` — so a name that is both mixed static/instance and multi-arity-generic correctly
becomes, e.g., `group-by*<>`, with `*` always ordered before `<>`.

**Export-list drift risk.** `method-name-wrapper-names` must always return exactly the set of names
`generate-method-name-wrappers` actually emits as top-level, non-internal `defun`s — this pairing
(already flagged as a risk point in the Version 27 section above) is the main way this feature could
silently regress: if the two functions' case-dispatch logic diverges, `packages.lisp` would either
under-export (breaking legitimate external callers) or over-export (leaking an internal
`aggregate-arity-N` name). Both functions branch on the exact same `generic-arity-dispatch-mode`
value from the exact same `split-by-generic-arity` call, which keeps them mechanically in sync, but
any future change to one must be mirrored in the other.

## Struct-Boxing Warnings Corrected; Shared-Mutable-Constant Hazard Documented (Version 29)

The "Instance Properties and Struct 'Boxing Mutation'" section above (and the comment the
generator emitted above every struct/enum property/field mutator) claimed that `setf`-mutating a
struct's property "may only mutate a boxed copy, leaving the original unchanged." That transcript
was itself suspect on inspection: it showed `color:+white+` printing as `R:37 G:255 B:255 A:255`
(White should print `R:255 ...`) and used DungeonSlime's own `#!!System.Convert.ToByte`-style
reader-macro shorthand, unavailable in this standalone repo — strong signs it was never actually
run against a live REPL, just carried over from `dotcl-dungeonslime`'s docs uncritically.

A real `make repl` session against `dotcl-dungeonslime` (which loads generated packages including
`color:`) disproved the claim outright: `x` starts as genuine White, and all three ways of
producing the new value (`dotnet:box`, a real invoked `dotnet:static` conversion call, and a
`the`-typed literal) correctly mutate `x` in place, with no error and no silently-discarded
mutation — see the corrected transcript above. **Mutation succeeds.**

**The real, more serious finding** came from one further check: `color:+white+` itself — a
`defconstant` — had been permanently mutated too:
```lisp
DUNGEON-SLIME> color:+white+
#<DOTNET Microsoft.Xna.Framework.Color {R:55 G:255 B:255 A:255}>
```

**Root cause.** `(cl:defconstant +white+ (dotnet:static <type-str> "White"))` evaluates its value
form exactly once; that one call to the real C# `Color.White` getter returns one boxed CLR object,
and that *exact* box is what `+white+` is bound to for the remaining life of the program.
`(defparameter x color:+white+)` binds `x` to the *same* box — Lisp variables holding a `DOTNET`
object hold a reference, not a value-copy. Mutating a property through *either* binding mutates
that one shared box, including every other place in the program that reads `+white+` from then on,
permanently and silently. By contrast, the default (non-`--constant-properties`) path —
`(cl:define-symbol-macro local (dotnet:static <type-str> "Local"))` — re-evaluates `dotnet:static`
on *every* reference, so each access re-invokes the real C# getter, which (ordinary .NET
value-type semantics: every read of a value-type-returning member yields an independent copy)
returns a freshly-boxed instance each time. That path has no sharing hazard.

So the bug is structural to `--constant-properties` (and, in principle, true C# `:literal`/`const`
fields, though C# cannot express a non-primitive `const`, so that path is a no-op safety net in
practice, not a real-world risk today): caching a *mutable value type* into a `defconstant` silently
creates global shared mutable state disguised as an immutable constant — and the flagship examples
this repo's own `CLAUDE.md`/`README.md` give for `--constant-properties` (`Vector2.Zero`,
`Color.White`) are exactly the highest-risk case.

**The fix in this version is documentation-only — no dispatch/codegen behavior changed.**
`defconstant`'s entire point is to avoid re-invoking `dotnet:static` on every access (important for
something as hot as `Vector2.Zero`); falling back to `define-symbol-macro` for struct-typed
constants would eliminate the hazard but at an unacceptable performance cost for exactly the case
people reach for the flag for. Instead:

* The three `is-value-type-p` property/field mutator comment sites in `generate-class-file` were
  reworded to describe the *actual* hazard (in-place mutation of a possibly-aliased boxed instance)
  instead of the disproven "mutation is silently lost" claim.
* A new `emit-shared-mutable-constant-warning` helper emits a detailed warning comment above every
  `literal-fields`/`pure-const-fields`/`pure-const-props` `defconstant` whose type is not a
  known-safe, effectively-immutable primitive (`immutable-primitive-type-p`, checked against a new
  `*immutable-primitive-types*` allowlist of numeric primitives, `System.String`, `System.Char`,
  `System.Boolean`, `System.IntPtr`/`UIntPtr`). This is deliberately a broad allowlist rather than a
  precise per-type mutability check: `generate-class-file` only ever sees one type's own metadata at
  a time, with no cross-type lookup available to determine whether some *other* referenced type
  (e.g. a constant property returning a type declared in a different assembly) has settable
  instance members — so anything not provably safe gets the warning, including every struct with
  settable properties/fields.
* `*generator-version*` bumped 28 → 29 since generated file *text* changes (comments), matching this
  repo's precedent for comment/wording-only version bumps (e.g. Version 25).

**What this version does *not* do**, per explicit user direction: it does not touch the separate,
similar-sounding Version 16 "Struct Mutation, Boxing, and Overload Resolution" section's claim about
struct-mutating *instance methods* (e.g. `Vector2.Normalize()`) discarding their mutation — that
claim was not tested in this investigation (only property `setf` was), and is left as-is pending
independent live verification.

**Real follow-up work, not delivered here:** users currently have no supported way to obtain an
independent, safely-mutable *copy* of a boxed struct (from a constant, a symbol-macro, or any other
source) — see `PLAN.md`'s new struct-cloning TODO item for the tracked follow-up to actually solve
the underlying hazard rather than just warn about it.

## Complete Operator Overload Mapping (Version 30)

`PLAN.md` had a standing TODO, "Add missing operator overload handling," suggesting `AssemblyToLispy.cs`'s
`GetCleanMethodName` (the sole C#-operator-name → Lisp-symbol mapping table) was missing several
standard C# operators. Before extending the table, this version's investigation checked whether
operator *codegen* itself still worked at all, since `assembly-package-generator.lisp`'s
`non-operator-non-accessor-methods` filter and `simple-method-p`/`clean-method-p` all reject any
method whose name has an `"op_"` prefix — a check that, read out of context, looks like it excludes
every operator overload from code generation entirely.

**It does not.** `GetCleanMethodName` runs *before* the generator ever sees the method: it rewrites
a mapped operator's `:name` metadata field to the clean symbol (`"+"`, `"="`, `"implicit-cast"`,
etc.) — only an *unmapped* operator (previously, one of the 8 gaps closed by this version) keeps its
raw `op_Xxx` name. So by the time the generator's `"op_"`-prefix filters run, a mapped operator's
`:name` no longer starts with `"op_"` and sails through the ordinary clean-method / Master Wrapper
pipeline untouched — confirmed directly against real checked-in output in `cspackages-test/`:

```lisp
;; cspackages-test/system-numerics-vector2.lisp
(cl:defun + (value cl:&optional (right cl:nil supplied-right))
  ...
  (dotnet:static <type-str> "op_Addition" value right))
  ...
  (dotnet:static <type-str> "op_UnaryPlus" value))
;; cspackages-test/system-string.lisp
(cl:defun implicit-cast (value)
  (dotnet:static <type-str> "op_Implicit" ...))
```

Unary/binary disambiguation for a symbol shared between two CLR operator names (e.g. `+` covering
both `op_Addition` and `op_UnaryPlus`) already works purely via arity (the Version 13/14 dispatch
machinery's optional second argument with `supplied-p`), and the real CLR method is always invoked
via each overload's `:mangled-name`, never its clean `:name` — so this was never at risk of calling
the wrong operator.

**What this version actually changes**, given the above: only `AssemblyToLispy.cs`'s
`GetCleanMethodName` table, in `assembly-package-generator.lisp`'s package-generator (no
generation-logic changes needed at all):

* The 8 remaining standard C# overloadable operators without a mapping: `op_Modulus` → `%`,
  `op_BitwiseAnd` → `&`, `op_BitwiseOr` → `|`, `op_ExclusiveOr` → `^`, `op_LeftShift` → `<<`,
  `op_RightShift` → `>>`, `op_UnsignedRightShift` → `>>>`, `op_OnesComplement` → `~`.
* C# 11's checked-operator variants, previously entirely unmapped: `op_CheckedAddition` → `+!`,
  `op_CheckedSubtraction` → `-!`, `op_CheckedMultiply` → `*!`, `op_CheckedDivision` → `/!`,
  `op_CheckedUnaryNegation` → `-!` (shared with `op_CheckedSubtraction`, mirroring how unchecked
  `-` is already shared between `op_Subtraction`/`op_UnaryNegation`), `op_CheckedExplicit` →
  `explicit-cast!`. The `!` suffix lets a checked operator coexist on the same type as its
  unchecked counterpart without a naming collision.

Test coverage was also added where none existed before: previously, the only operator exercised by
any test was `op_Addition` on the synthetic `GenericClass<T>` (`AssemblyToLispyTestTarget/EdgeCases.cs`),
and only for metadata `:mangled-name` extraction (`tests/synthetic-target.test.lisp`) — `GenericClass<T>`
being generic means its operator is filtered out of actual code generation by the (unrelated)
generic-type-parameter exclusion, so no test ever exercised generated operator wrapper *code*.
`EdgeCaseStruct` (non-generic) gained a newly-mapped binary operator (`operator %`) and a unary
operator sharing the `-` symbol with a same-named binary operator, and `package-generator-tests.lisp`
gained a synthetic-class-plist codegen test (mirroring its existing indexer/field-codegen tests)
asserting the generated wrapper functions and their `:mangled-name`-based CLR invocations.

## Writeable Static Properties and Mutable Static Fields (Version 31)

`PLAN.md` and `FEATURES.md`'s Unsupported Features section both tracked a genuine silent gap: a
static property that is writeable (read-write or write-only), and a plain mutable static field
(not C# `readonly`, not `const`), matched none of the existing field/property classifiers
(`literal-field-p`, `runtime-readonly-field-p`, `constant-property-p`) and so fell through every
`remove-if`/`remove-if-not` pipeline in both `compute-package-exports-and-shadows` and
`generate-class-file` untouched — no getter, no setter, not even a documentation comment. This
mirrored the bug public instance fields had before Version 27, just never fixed for the static
case, even though the reflected metadata (`:static t` + `:writeable t` on a property; a field with
neither `:literal` nor `:init-only`) already captured these members correctly.

**New classifiers**, added alongside the existing ones:

* `writeable-static-property-p` — `(and (getf prop :static) (getf prop :writeable))`. Disjoint from
  `constant-property-p` (which requires `(not (getf prop :writeable))`), so every static property
  lands in exactly one of the two buckets.
* `mutable-static-field-p` — `(and (getf field :static) (not (getf field :literal)) (not (getf
  field :init-only)))` — the exact complement, within static fields, of `literal-field-p`/
  `runtime-readonly-field-p`.

**Codegen** mirrors the existing instance-property/instance-field shape from Version 9/27
(readable → plain getter; writeable+readable → also a `setf`-expander; writeable-only → a
`set-name` function instead) but targets `dotnet:static` in place of `dotnet:invoke`, with no
`obj!` receiver parameter at all — `dotnet:static`'s own `setf`-expansion (documented in
`doc/dotnet-dotcl-interop.md`, e.g. `(setf (dotnet:static "System.Console" "Title") "...")`)
writes the type's own static storage slot directly:

```lisp
(cl:defun mode ()
  (dotnet:static <type-str> "Mode"))
(cl:defun (cl:setf mode) (new-value)
  (cl:setf (dotnet:static <type-str> "Mode") new-value))

;; write-only:
(cl:defun set-sink (new-value)
  (cl:setf (dotnet:static <type-str> "Sink") new-value))

;; plain mutable static field -- same shape as a read-write property:
(cl:defun total ()
  (dotnet:static <type-str> "Total"))
(cl:defun (cl:setf total) (new-value)
  (cl:setf (dotnet:static <type-str> "Total") new-value))
```

**No struct-boxing-aliasing warning comment is emitted here**, unlike instance property/field
mutators (see the Version 29 section above). That comment exists because an instance mutator's
`obj!` receiver can be an alias of a shared boxed instance (most dangerously a
`--constant-properties`-cached `defconstant`), so mutating through one alias silently mutates every
other alias too. A static member's `setf` has no receiver to alias in the first place — it
reassigns the type's own static slot directly, the same as the doc's own
`(setf (dotnet:static "System.Console" "Title") ...)` example — so the hazard the comment warns
about simply doesn't apply.

`*generator-version*` bumped 30 → 31 since generated file *content* changes (new functions can now
appear for members that previously produced nothing). Test coverage: `AssemblyToLispyTestTarget/
EdgeCases.cs`'s `EdgeCaseStruct` gained a plain mutable static field (`MutableStaticField`), a
static read-write property (`StaticReadWriteProperty`), and a static write-only property
(`StaticWriteOnlyProperty`); `tests/synthetic-target.test.lisp` asserts their reflected metadata
shape, and `package-generator-tests.lisp` gained a synthetic-class-plist codegen test (7.1)
asserting the generated getter/`setf`/`set-name` functions and their exports, mirroring the
existing instance-field codegen test's structure.

## Deriving `*generator-version*` from `dotcl-packagegen.asd` (Version 31 follow-up)

`Makefile`'s `VERSION` (the CLI/tool package version, e.g. `2.31.0`) and
`assembly-package-generator.lisp`'s `*generator-version*` (the generated-file-format version, e.g.
`31`, the minor component of `VERSION`) had to be hand-kept in lockstep across three files
(`Makefile`, `dotcl-packagegen.asd`, and this file's own `defparameter`) — exactly the kind of
duplication that caused a real drift bug (the Version 31 fix itself shipped with `Makefile`'s
`VERSION` and `dotcl-packagegen.asd`'s `:version` left at the stale `2.30.0`). `Makefile`'s `VERSION`
was fixed first, by shelling out to `grep` against the `.asd`'s `:version` line. The natural
next step was to make `*generator-version*` likewise read from `dotcl-packagegen.asd` — via ASDF's
own introspection this time, since the code is already Lisp with ASDF loaded, not a shell script —
so the `.asd` becomes the single source of truth for both.

**The obvious approach doesn't work.** `utils.lisp` already had exactly the right-looking
building block: `utils:qualify-path`, which takes a bare filename, returns it unchanged if it
resolves relative to the current working directory, and otherwise re-resolves it against
`utils:+base-directory+` (the running executable's own directory, where the `.asd` is copied
alongside the compiled fasls — see the `.csproj`'s "Copy for Runtime 'version' Introspection"
`Content` item). Plugging `(utils:qualify-path "dotcl-packagegen.asd")` straight into
`utils:get-system-version` (which wraps `asdf:load-asd` + `asdf:component-version`, the same
mechanism `--version`'s `utils:print-system-version` already used) built and ran fine — until
invoked from within a checkout of this very repo, where `dotcl-packagegen.asd`'s *source* also
happens to exist relative to the current working directory. In that case `qualify-path`'s first
branch matches and hands back the bare relative string `"dotcl-packagegen.asd"` (no directory
component at all), and `asdf:load-asd` cannot cope with that: it fails at load time (not compile
time) with `SIMPLE-ERROR: Invalid relative pathname #P"" for component ("dotcl-packagegen")` — a
classic ASDF complaint that arises when a system ends up with an empty/relative `:pathname`. The
build itself succeeds, since the failing form only runs when the fasl is *loaded* (e.g. by
`dotcl-packagegen --version` or `--test`), not when it's compiled — so this class of bug is easy to
ship without noticing if you only run `make build` and not `make test`.

**The fix**: bypass `qualify-path` entirely and always build an absolute path by combining
`utils:+base-directory+` with the filename directly (`(uiop:native-namestring (utils:path-combine
utils:+base-directory+ "dotcl-packagegen.asd"))`), mirroring what `Program.cs`'s `PrintVersion`
already did in C# (`Path.Combine(AppContext.BaseDirectory, AsdFileName)`) — an absolute path is
required, cwd-relative resolution is never appropriate here, and `qualify-path`'s cwd-preferring
fallback (added for a different scenario: loading this codebase's own game-project sibling,
`dotcl-dungeonslime`, from a `load-repl.lisp` where `+base-directory+` points at the installed
`dotcl` tool's own directory rather than the game's) is actively the wrong tool for a case where
the *correct* file (an absolute, base-directory-relative one) already exists and a *decoy* file
(the bare relative name, coincidentally also readable) is what cwd-preference finds first.

The resulting `*generator-version*` value form:

```lisp
(defparameter *generator-version*
  (let* ((asd-path (uiop:native-namestring
                     (utils:path-combine utils:+base-directory+ "dotcl-packagegen.asd")))
         (version-string (utils:get-system-version asd-path "dotcl-packagegen")))
    (parse-integer (second (uiop:split-string version-string :separator "."))))
  ...)
```

One more ordering pitfall avoided: `assembly-package-generator.lisp` defines its own local
`split-string` (semicolon-splitting helper for `--constant-properties` lists) further down the
same file, *after* `*generator-version*`'s `defparameter`. Reusing that name here would silently
resolve to `cl:nil`/an undefined-function error at load time, since Lisp forms in a file load
strictly top-to-bottom and the local `split-string` wouldn't exist yet — `uiop:split-string`
(already used elsewhere in this file, e.g. via the sibling `uiop:string-prefix-p`) sidesteps the
whole ordering question by not depending on anything defined later in the same file.

## Events (Version 32)

### What changed and why

C# events (`add_X`/`remove_X` accessor pairs) were previously invisible end-to-end. The ordinary
method filter in `AssemblyToLispy.cs` (`(m.IsPublic || m.IsFamily || m.IsFamilyOrAssembly) &&
(!m.IsSpecialName || m.Name.StartsWith("op_")) && ...`) exists to drop the *compiler-generated*
`get_Foo`/`set_Foo` accessor methods that every property already produces (so they don't also show
up as ordinary, separately-callable methods) — but `add_Click`/`remove_Click` are `IsSpecialName`
too, and don't start with `op_`, so the exact same filter silently swallowed them as well. There
was no separate reflection path for events at all: no `Type.GetEvents()` call anywhere in
`AssemblyToLispy.cs`, and no `:events` key in the metadata schema. This was flagged as gap #4 in
`doc/claude-suggested-improvements-20260703.md` ("Events... filtered out before metadata is even
emitted"), rated High priority precisely because events are ubiquitous in UI/notification-style
APIs (the motivating case: Gum UI's `ButtonBase.Click`/`Push`, both plain `EventHandler` events) and
the failure mode was total silence, not a documented skip.

### New metadata shape

Each type plist gains a `:events` key (list of event plists, present only when the type declares
at least one qualifying event — see `doc/assembly-to-lispy.md`'s "Entity Entry Details"). An event
plist has `:name`, `:type` (the delegate type, e.g. `System.EventHandler`), `:add-method`,
`:remove-method`, and optional `:documentation`. `:type` is captured for documentation purposes
only — codegen doesn't need it, because `dotnet:add-event` resolves the correct delegate type from
the live `EventInfo` at runtime (unlike, say, `dotnet:make-delegate`, which needs an explicit type
string up front since it has no `EventInfo` to inspect).

Only **instance** events are captured. `AssemblyToLispy.cs`'s new `:events` collection explicitly
filters out any event whose `AddMethod` is static, and this is by design, not an oversight — see
"Static events are explicitly out of scope" below.

### Why this needed no DotCL runtime changes

`dotnet:add-event`/`dotnet:remove-event` already existed in DotCL and are documented in
`doc/dotnet-dotcl-interop.md` (the `(dotnet:add-event btn "Click" (lambda (sender e) ...))`
example): the runtime already knows how to compile a Lisp closure into the event's actual delegate
type, register it via the event's `add_X` method, and cache the compiled delegate (keyed by the
Lisp handler object, via a weak table) so `remove-event` can look it up again by the same handler.
This was purely a reflection + codegen gap in this repo — nothing on the DotCL interop side needed
to change at all.

### The add-X/remove-X naming convention and identity-based removal

Each instance event `Foo` generates a pair, `add-foo`/`remove-foo`, both taking `(obj! handler)`.
For example, `ButtonBase.Click`:

```lisp
(defparameter *my-click-handler*
  (lambda (sender e) (format t "clicked~%")))

(add-click button *my-click-handler*)
...
(remove-click button *my-click-handler*)
```

The critical, non-obvious gotcha: removal is by Lisp object **identity**, not behavioral
equivalence, because `dotnet:add-event`'s underlying cache is keyed on the exact Lisp function
object originally passed to `add-click` — not on what that function does. Two separately-created
lambdas with identical bodies are two different objects and will never match. Concretely:

```lisp
(add-click button (lambda (sender e) (format t "clicked~%")))
;; There is now no way to remove this handler -- the lambda object was never
;; bound to anything, so nothing can be passed to remove-click to find it again.
```

This mirrors ordinary Lisp idiom elsewhere (e.g. Emacs Lisp's `remove-hook`, or CLOS's
`remove-method`) — it is not a limitation specific to this generator, but it is unfamiliar enough
to first-time callers that the generated `remove-X` docstring calls it out explicitly:
`"Pass the exact same HANDLER object given to add-X -- removal is by identity, not by behavioral
equivalence."`

### The naming-collision policy

Every other exported name in this generator is derived 1:1 from a single C# member name via
`map-member-name` — two members can only collide if C# itself gave them colliding names after
case-folding (already handled: static/instance same-name method collisions get a `*` suffix per
Version 24; CL-reserved-word collisions get `!` suffixes per Version 15). Events are different:
`add-X`/`remove-X` are *synthesized* compound names, not a 1:1 mapping of one existing C#
identifier, so a class can trivially have a genuine, unrelated member that collides with a
synthesized event name — e.g. a `Click` event alongside an unrelated `AddClick()` method, both of
which `map-member-name`-style mapping would turn into `add-click`.

`event-wrapper-names` resolves this with a three-tier escalation, checked against every other
already-decided name in the class (via the new `class-member-names-excluding-events` helper, used
identically by both `compute-package-exports-and-shadows` and `generate-class-file` so the two
functions can never disagree about what a given event's actual wrapper names are) plus any
add-/remove- names already claimed by an earlier event in the same class:

1. `add-click`/`remove-click` — the common case.
2. `add-click-event`/`remove-click-event` — used only if tier 1 collides with something else in
   the class (e.g. the `AddClick()` example above).
3. `add-click!`/`remove-click!` — used only if tier 2 *also* collides (e.g. a class absurdly
   declaring both `AddClick()` and `AddClickEvent()` alongside a `Click` event). This tier falls
   back to the shorter tier-1 base with `!` appended, rather than the tier-2 `-event` name, since
   `!` alone is already sufficient to guarantee uniqueness. Critically, tier 3 is collision-proof
   *by construction*, not just empirically unlikely: the C# compiler's identifier grammar cannot
   produce a `!` character, so no real C# member can ever also produce `add-click!` — the exact
   same by-construction guarantee this generator already relies on for `obj!` (Version 25) and the
   `quote!`/`function!`/`t!`/`nil!` reserved-word mappings (Version 15).

### Static events are explicitly out of scope

Only instance events are supported as of Version 32. Static events (raised via a static
`add_X`/`remove_X` pair with no receiver object) are filtered out entirely at the
`AssemblyToLispy.cs` reflection stage — they never even reach the `:events` metadata key — because
`dotnet:add-event`/`dotnet:remove-event` have no documented or verified calling convention for a
receiverless event: every existing example in `doc/dotnet-dotcl-interop.md` operates on a live
instance. Extending support to static events would need an asymmetric design (there is no receiver
object to key an identity-cache off of the way `dotnet:add-event` does for instances): `add-X`
would need to construct and return a raw `.NET` delegate object (via `dotnet:make-delegate` plus a
direct `dotnet:static` call to the static `add_X` method) for the caller to hold onto and pass back
verbatim to `remove-X`, which is a meaningfully different calling convention from the instance
case above. This is tracked as a follow-up in `PLAN.md` rather than attempted here.

## Parents and Interfaces (Version 33)

### What changed and why

Every class package previously reflected only its own *declared* members
(`BindingFlags.DeclaredOnly` in every `AssemblyToLispy.cs` member query), so a generated package
had no way to reach anything inherited from a super-class or implemented interface — a user had
to separately know about, request, and reach into the ancestor's own package. Version 33 adds
opt-in re-export: `--export-parents`/`--export-interfaces`/`--export-object` (per-class flags,
plus sticky `--export-all-*` CLI defaults) pull in a class's ancestors and re-export their
non-conflicting members into its own package. Full design writeup and rationale:
`doc/parents-and-interfaces-plan.md` (this section summarizes the as-built implementation).

### Ancestor resolution is cross-assembly, via a global index

`build-metadata-index` loads every manifest entry's metadata file once (even if two entries
happen to share one) into a single `fully-qualified-name -> (type-plist . owning-entry)` hash
table. `expand-ancestors` then walks a requested class's ancestor graph against this index, not
just its own assembly's metadata — an ancestor is resolved wherever it lives among every
`--assembly` given on the command line. `:superclass` is walked link-by-link up to
`System.Object` (excluded unless `--export-object`); `:interfaces` is taken as already fully
transitive, since .NET's `Type.GetInterfaces()` includes interfaces implemented via any base
type. An ancestor absent from the index (assembly not provided, or an unresolvable open-generic
base) is collected as *missing*: by default this aborts generation entirely, matching the
existing missing-*requested*-class behavior, before anything is written; `--skip-missing` (a
plain boolean passed as an extra scalar to `RUN-ASSEMBLY-PACKAGE-GENERATOR-BATCH`, not folded
into the manifest, since it is one global flag) downgrades this to a warning and drops just that
ancestor.

Newly-discovered ancestors are folded into the existing per-entry/per-class working set
(`resolved-class` plists, from the new `make-resolved-class` — replacing the old bare
`(class-plist . constant-properties-list)` cons `resolve-batch-entry`/
`generate-batch-packages-file`/`generate-batch-asd-file`/`generate-assembly-packages-batch` all
used to pass around) as **plain packages** (no export flags of their own — they don't recursively
re-export *their* ancestors unless separately, explicitly requested), appended after their owning
assembly's explicitly-requested classes: a stable, minimal reordering of the user's own
command-line order, with no topological sort anywhere in this feature (see below for why the
re-export mechanism itself needs none either). A class both explicitly requested and pulled in as
someone else's ancestor keeps its own explicit flags/constant-properties; no duplicate entry is
generated.

### Re-export is a post-pass, not `:import-from` — deliberately no topological sort

The natural-looking design — each child's own `defpackage` gaining an `:import-from` clause for
every ancestor symbol it draws from — would require the `defpackage` forms themselves to be
topologically ordered (an ancestor's package must be *defined* before a descendant's
`:import-from` clause can reference its symbols). Version 33 avoids this entirely: every
`defpackage` form in `packages.lisp` stays exactly as self-contained as before (own symbols
only), and a separate block of `cl:shadowing-import`/`cl:import`/`cl:export` calls
(`emit-child-reexports`) is appended *after every `defpackage` form in the file*. Since
`shadowing-import`/`import`/`export` only require the ancestor's symbols to already be interned
— which `defpackage` guarantees the moment it runs, regardless of where in the file it sits,
independent of whether the ancestor's actual function *bodies* have loaded yet — the whole
`packages.lisp` file can emit its `defpackage` forms in plain command-line-derived order with no
sort pass at all. The actual function binding for a re-exported symbol arrives later, whenever
the ancestor's own class `.lisp` file loads (any time before the whole ASDF system finishes
loading, which is always before generated code is actually called); `generate-batch-asd-file`
also adds each child's ancestor package files to its own `:file`'s `:depends-on`, making that true
dependency explicit in the system definition even though it isn't strictly required for
correctness once the whole system loads.

### Deciding what to re-export: `compute-reexports`

For a child class, `compute-reexports` is handed the child's own export list (from the existing
`compute-package-exports-and-shadows` — reused, not reimplemented, for both the child and every
ancestor) plus each ancestor's own `(pkg-name exports shadows)` triple, and decides, per
candidate name:

* **Excluded outright**: the four synthetic per-type symbols (`<type>`, `<type-str>`,
  `<creation>`, `<version>`) plus `new` are never re-export candidates at all — they identify the
  *ancestor's own* type/version/construction, not something a descendant logically inherits.
* **Skipped, tagged `:own`**: the child already declares a member of that name itself. This
  covers the common `--export-interfaces` case where a class already implements the interface
  method it would otherwise re-export — verified live against `System.Array`
  (`--export-interfaces`, real `System.Runtime.dll` metadata): `System.Array`'s own
  `synchronized?`/`sync-root`/`copy-to`/`get-enumerator`/`fixed-size?`/`read-only?`/`clear`/
  `index-of`/`clone` are all correctly skipped as `:own`, while genuinely-inherited-only members
  (`item`, `add`, `contains`, `insert`, `remove-at`, `compare-to`, `equals`, `get-hash-code`, plus
  `count`/`remove` needing `cl:shadowing-import` since those two collide with real CL symbols) are
  re-exported.
* **Skipped, tagged `(:ambiguous pkg-name-list)`**: more than one ancestor exports the same name.
  Locked design decision (see `doc/parents-and-interfaces-plan.md`): this is comment-only for now,
  not a renamed re-export (e.g. `interface-name->method`) — that disambiguation is deferred to a
  future version.
* **Re-exported**, via `cl:shadowing-import` if the name collides with a standard CL symbol (per
  that ancestor's own `shadows` list — the same detection `compute-package-exports-and-shadows`
  already performs for the ancestor's own `defpackage :shadow` clause), or plain `cl:import`
  otherwise.

Every skip is documented with a `;;; Skipped (...)` comment in `packages.lisp`, mirroring this
codebase's existing convention of documenting unsupported/skipped cases (dirty overloads,
unsupported indexers) rather than silently dropping them.

### Deferred: virtual/override-aware shadow commentary

`PLAN.md`'s original sketch also wanted a comment distinguishing a *non-virtual* member shadowing
a parent's from an *overriding* one — this needs new `AssemblyToLispy.cs` metadata
(`MethodInfo.IsVirtual`/`GetBaseDefinition()`) not added in Version 33, since it only affects
comment wording, not re-export correctness. Tracked as a future-version follow-up in
`doc/parents-and-interfaces-plan.md`'s Phase 5.

## Unified Generic Methods (Version 34, Dynamic Variant)

### What changed and why

`PLAN.md`'s "Turn Everything into Generic Methods" section asked for every generated instance
member to also be reachable through one shared package of CLOS generic functions dispatching on
the C# runtime type — so, e.g., a caller holding some `#<DOTNET ...>` instance of unknown-to-them
type can call `(csharp-generics-dynamic:length x)` without knowing which per-class package `x`'s
type lives in. Version 34 added this as opt-in: `--defgeneric`/`--no-defgeneric` (per-class,
mirroring `--export-parents`) plus sticky `--enable-defgeneric`/`--no-enable-defgeneric`
(mirroring `--export-all-parents`). **Version 35 renamed this entire mechanism** to
`-dynamic`-suffixed flags/package/functions (see "Unified Generic Methods — Static Variant
(Version 35)" below for why, and for the sibling variant that now uses the original names) —
this section's identifiers reflect the current, post-rename names. Full design writeup, locked
decisions, and the questions/answers that led to them:
`doc/make-everything-defgeneric-dynamic.md` (this section summarizes the as-built
implementation).

### Collecting which members qualify: `collect-class-instance-generics`

Every instance wrapper this generator emits takes its receiver first, as a plain positional
`obj!` — an instance method's Master Wrapper, an instance property/field getter (`(name obj!
...)`), and an instance property/field setter (`(cl:defun (cl:setf name) (new-value obj! ...))`,
receiver as the *second* required argument). That uniformity is what makes one dispatch shape,
`(name obj! cl:&rest args)` (or `((cl:setf name) new-value obj! cl:&rest args)` for a setter),
cover every opted-in class's wildly different real arities via a bare `cl:apply`.

`collect-class-instance-generics` independently re-derives, for one class-plist, exactly which
wrapper names have this shape — reusing `map-member-name`/`method-name-wrapper-names` so the name
computation itself can never drift from `compute-package-exports-and-shadows`/
`generate-class-file` (the same independent-re-derivation convention `class-member-names-
excluding-events` established for events in Version 32). Three categories are deliberately
excluded, all for the same reason — the resulting wrapper's lambda list does not begin with
`obj!`, or has no wrapper at all:

* **Static members** — no `obj!` receiver to dispatch on at all.
* **Generic/type-parameterized instance methods** — a generic method's wrapper puts its type
  argument(s) *before* `obj!` (see "Generic Methods" above), so `obj!` is not the leading
  argument. `collect-class-instance-generics` filters a method-name group's instance-clean
  overloads down to the ones with `:is-generic` nil before calling `method-name-wrapper-names`
  on that subset — which, called on a purely-non-generic subset, always returns exactly
  `(list base-name)` (the `:single`-mode case), so the *shared* generic can only ever be the
  plain, non-generic-dispatching function, never a `<>` dispatcher whose first argument is a
  type.
* **Overloaded indexers** — `generate-class-file` itself already declines to generate any wrapper
  for these (multiple index-parameter signatures on one name), so there is nothing to forward to.

### Why load-time install, not a generation-time `defmethod` specializer

The obvious-looking design — emit `(cl:defmethod name ((obj! |Vector2|) ...) ...)` directly, with
a symbol computed at generation time from the C# type's simple name — is unsound. DotCL's
`EnsureDotNetTypeClass` (`Runtime.CLOS.cs`) names a type's CLOS class by its *simple* name only
when that name is free; if a same-simple-name type from a *different* namespace has already
claimed it (e.g. `System.Threading.Timer` vs. `System.Timers.Timer`), the second one is instead
registered under its unique `FullName` symbol. Which type wins that race depends on load
order — genuinely unknowable at generation time, since it depends on what else is loaded and in
what sequence at runtime. A generation-time-hardcoded specializer symbol would attach to
whichever type happened to win the simple-name race, silently misdirecting dispatch for the loser
in any batch where two opted-in classes share a simple name.

Version 34 sidesteps this by installing every `defmethod` **at load time**, against the class's
own *actual* registered class object, fetched fresh via `EnsureDotNetTypeClass` (idempotent — a
harmless no-op re-registration when the class's own `.lisp` file already registered it, which it
always will have by the time `csharp-generics-dynamic.lisp` loads last) and specialized on that
object's own `(cl:class-name ...)`:

```lisp
(cl:eval-when (:load-toplevel :execute)
  (cl:let* ((cls (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                   (dotnet:resolve-type "System.String")))
            (spec (cl:class-name cls)))
    (cl:eval `(cl:defmethod length ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:length) obj! args)))
    ...))
```

`(cl:class-name cls)` is always the exact symbol DotCL registered for *that specific class*,
whichever one it turned out to be — immune to the naming race by construction, since it asks the
already-resolved class object rather than predicting its name. The `cl:eval` of a backquoted
`cl:defmethod` form (rather than a literal `cl:defmethod` in the source) is required precisely
*because* the specializer symbol (`spec`) is a runtime value, not something `cl:defmethod`'s own
macro-expansion (which needs a literal specializer at compile time) could see.

### Emission and load order

`compute-defgeneric-dynamic-model` (a thin wrapper around the shared internal
`%compute-defgeneric-model`, parameterized on the `:defgeneric-dynamic` resolved-class flag —
see the Version 35 section below) aggregates every opted-in resolved class's collected names
(across the whole batch, not per-assembly) into: the deduped union export/shadow lists for the
`csharp-generics-dynamic` `cl:defpackage` (emitted by `generate-batch-packages-file`, right
after the `csharp-assembly-utils` defpackage — the two are structurally symmetric shared
packages), and a per-class list of participating names for `generate-batch-generics-dynamic-file`
to emit against. Returns `nil` when no class opted in, which every downstream site
(`generate-batch-packages-file`, `generate-batch-generics-dynamic-file`,
`generate-batch-asd-file`) treats as "emit nothing for this variant" — independently of whatever
the sibling static variant is doing in the same batch.

`generate-batch-generics-dynamic-file` (a sibling to `generate-batch-utils-file`) must run
**after** every opted-in class's own `.lisp` file has been generated (its `defmethod` bodies
reference those files' exported functions by name, and its install blocks'
`EnsureDotNetTypeClass` calls are safe no-ops only because those files already performed the
real registration). `generate-batch-asd-file` adds `csharp-generics-dynamic` as a `:file`
component, depending on `"packages"`, `"csharp-assembly-utils"`, and every one of this variant's
opted-in classes' own package files, so ASDF's own dependency graph enforces this load order
rather than relying on component-list position alone.

### Accepted cost: per-call dispatch/apply overhead

Every unified generic forwards via a bare `cl:apply` of the class's own wrapper — no attempt is
made to avoid the extra generic-function dispatch plus `apply` overhead relative to calling the
class's own package function directly. `PLAN.md`'s original sketch explicitly anticipated and
accepted this for a first version ("this does add overhead — we could address that in a later
version if desired"); this variant makes the same call. (The sibling static variant, Version 35,
avoids the `cl:eval`/`cl:eval-when` overhead specifically, but still pays the same
generic-dispatch-plus-`apply` cost — see below.)

## Unified Generic Methods — Static Variant (Version 35)

### What changed and why

Version 34's `cl:eval`-of-a-backquoted-`defmethod` mechanism (above) was judged too ugly to be
the only option — see `PLAN.md`'s "Improve Turn Everything into Generic Methods" section, which
asked for the whole mechanism to be renamed out of the way as `-dynamic`, freeing the original
`--defgeneric`/`csharp-generics` names for a new implementation of the design's other original
option, "Simple + documented caveat": a literal, ordinary top-level `cl:defmethod`, specializing
on a symbol computed at *generation* time rather than resolved at load time. Both variants are
now independent, orthogonal opt-ins (a class may use either, both, or neither); see
`doc/make-everything-defgeneric.md` (this variant) and
`doc/make-everything-defgeneric-dynamic.md` (the renamed Version 34 mechanism) for full
before/after naming maps.

### `dotnet-type-simple-name`: why `simple-type-name` doesn't suffice

The pre-existing `simple-type-name` helper computes a *display-oriented* simple name for
docstrings/comments: it strips the backtick generic-arity suffix (`` List`1 `` → `List`) and
never splits on CIL's `+` nested-type separator. Neither behavior matches what DotCL's
`EnsureDotNetTypeClass` actually keys its simple-name CLOS class registration on —
`Startup.Sym(type.Name)`, i.e. .NET reflection's own `Type.Name`, backtick and all, with nesting
already collapsed to just the innermost segment (`../dotcl/runtime/Startup.cs`). A literal
specializer computed from `simple-type-name`'s output would therefore be *silently wrong* for
any generic or nested type — not a collision risk, an outright bug, since the symbol wouldn't
match what DotCL registers at all. The new `dotnet-type-simple-name` reproduces `Type.Name`
exactly: everything after the last `.` or `+`, keeping any trailing backtick arity. The emitted
specializer is `dotcl-internal::|<dotnet-type-simple-name>|` — pipe-delimited to preserve exact
case and any embedded backtick — interned into `DOTCL-INTERNAL` to match where `Startup.Sym`
places a name not already present in `:cl`.

### The accepted collision caveat

Unlike the dynamic variant, this one cannot be made robust against DotCL's
simple-name/FullName registration race (see the Version 34 section above for the mechanics):
since the specializer symbol is fixed at generation time, it has no way to know, at generation
time, whether some *other* opted-in class in the same batch will collide with it on simple name.
If two `--defgeneric`-opted-in classes share a simple name across different namespaces (e.g.
`System.Threading.Timer` and `System.Timers.Timer`), only one of them keeps the simple-name CLOS
class at load time; the other's `defmethod`s, still specializing on that same symbol, silently
attach to the *wrong* class. This is accepted, not guarded against — a comment is emitted above
every class's `defmethod` block in the generated file, and the `Makefile` smoke test
deliberately opts both real-world `Timer` types into `--defgeneric` to demonstrate the failure
mode actually occurs, rather than leaving it as an unverified claim (see
`doc/make-everything-defgeneric.md`'s "Demonstrated collision" section).

### Sharing logic with the dynamic variant

`collect-class-instance-generics` (which wrapper names are eligible at all — excludes static
members, generic/type-parameterized instance methods, overloaded indexers) is entirely
mechanism-agnostic and reused verbatim by both variants; only the *installation* strategy
differs. `%compute-defgeneric-model`, a new shared internal helper parameterized on the
resolved-class flag key (`:defgeneric` or `:defgeneric-dynamic`), replaces what would otherwise
be near-duplicate aggregation logic between `compute-defgeneric-model` (this variant) and
`compute-defgeneric-dynamic-model` (the dynamic variant) — both produce the identical
`:classes`/`:method-names`/`:setter-names`/`:exports`/`:shadows` plist shape.
`emit-defgeneric-defpackage`, a similar shared helper, emits either variant's `cl:defpackage`
form in `generate-batch-packages-file` from that same plist shape, differing only in package
name/flag name/doc path. `generate-batch-packages-file`/`generate-batch-asd-file`/
`generate-assembly-packages-batch` each now take both models as independent optional arguments,
threading them through in parallel rather than one replacing the other.

## Static Variant's Collision Comment Reports Known Conflicts (Version 36)

### What changed and why

Version 35's static-variant collision comment (above) was a generic, purely hypothetical
warning attached to every opted-in class regardless of whether a real conflict existed. Since
the package generator already has full metadata for every type in every provided assembly (not
just the ones it's asked to generate), it can do better: report *actual, known* conflicts by
name, or say plainly that none are known.

### `build-simple-name-index` and `classify-simple-name-conflicts`

`build-simple-name-index` maps `dotnet-type-simple-name` to the list of every
fully-qualified-name reducing to it, built once from `build-metadata-index`'s output (every
type in every provided assembly's metadata — the same full index `expand-ancestors` already
uses for parent/interface resolution, previously scoped only to Phase B of
`generate-assembly-packages-batch` and now hoisted to that function's outer `let` so it's
available afterward too). `classify-simple-name-conflicts` looks up one class's own simple name
in that index and classifies every sibling (excluding itself) against a hash set of every
fully-qualified-name actually generated as its own package in this batch (`resolved-fq-set`,
built from `all-resolved`):

* **`:actual`** — the sibling is also in `resolved-fq-set`. Its own generated `.lisp` file will
  also call `EnsureDotNetTypeClass` at load time, so the naming race between the two is
  guaranteed to actually happen in this run's own output.
* **`:possible`** — the sibling is only visible in the provided assemblies' metadata, not
  itself generated here. No guaranteed collision from this run alone, but the type exists, so
  the simple name isn't exclusively the generated class's.

Both helpers are pure functions over already-computed data structures — no new file I/O, no
change to what gets generated for the dynamic variant (which doesn't need this at all, since
its load-time `class-name` lookup is already immune to the collision by construction).

### Wiring

`generate-batch-generics-file` gained two new optional parameters,
`simple-name-index`/`resolved-fq-set`; `generate-assembly-packages-batch` builds both once
(the index via the now-outer-scoped `index` local plus `build-simple-name-index`; the set via a
single pass over `all-resolved`) and passes them through. Omitting either falls back to the old
generic hypothetical-warning wording, keeping `generate-batch-generics-file` callable
standalone (e.g. from a test) without requiring the full batch machinery.

Verified against the `Makefile` smoke test's real `System.Threading.Timer`/`System.Timers.Timer`
collision pair: each correctly reports the other as an `ACTUAL` conflict.

## Instance Events Included in the Unified Generics Collector (Version 37)

### What changed and why

`collect-class-instance-generics` (the collector both `--defgeneric` and `--defgeneric-dynamic`
rely on) walked only `:fields`/`:properties`/`:methods` — it never looked at `:events`, so a
class's `add-X`/`remove-X` instance-event wrapper pair (added in Version 32, two versions
before this collector was written in Version 34) was silently missing from both unified-generics
packages, even though `add-X`/`remove-X` already have the exact same `(name obj! ...)` shape
every other collected wrapper has. Reported against a real class from a MonoGameGum-based game
(a `ButtonBase`'s `Click` event missing its `add-click`). The Version 34 changelog's exclusion
list (static members, generic methods, overloaded indexers) never mentioned events — this was
a gap from the collector never being revisited after events were added, not a deliberate
exclusion.

### The correctness-critical part: agreeing with `event-wrapper-names`' collision escalation

`add-X`/`remove-X` fold in as two independent `method-names` entries (never `setter-names` —
neither is a `(cl:setf ...)` counterpart of the other). The subtlety is naming:
`event-wrapper-names`' three-tier collision escalation (`add-X`/`remove-X` →
`add-X-event`/`remove-X-event` → `add-X!`/`remove-X!`) is seeded by every other name the class
package will export, computed via `class-member-names-excluding-events` — the exact same helper
`compute-package-exports-and-shadows`/`generate-class-file` already share so they can never
disagree on this. To avoid ever computing a different escalation tier than what's actually
emitted, `collect-class-instance-generics` now also derives the full non-event context those
two functions do (constructors, literal/const fields, const/writeable static properties, mutable
static fields — mirroring `compute-package-exports-and-shadows`'s own local bindings) purely to
build that taken-names set, even though none of those extra categories themselves become
unified-generics candidates. This requires a class's `constant-properties-list` (needed for the
const-vs-non-const field/property split), which the function did not previously take;
`collect-class-instance-generics` gained a required second parameter, and its sole caller,
`%compute-defgeneric-model`, now passes the resolved-class plist's own `:constant-properties`.

Verified with a dedicated unit test asserting `collect-class-instance-generics` and
`compute-package-exports-and-shadows` *agree* on the escalated name for a `Click` event
colliding with unrelated `AddClick()`/`RemoveClick()` methods, rather than asserting one
hardcoded expected string — this is precisely the class of bug (two functions silently
disagreeing on a name) `class-member-names-excluding-events` was built to prevent.

## Extension Methods (Version 38)

See `doc/plan-v38.md` for the full design document this implements (the "Part A" section).

### What changed and why

A C# extension method — a `static` method on a `static` holder class whose first parameter
carries the `this` modifier — was previously invisible to a generated package: reflection
already captured it (`AssemblyToLispy.cs`'s `:extension-method`/`:extension-this` flags, added
in Phase 2E, long before this version), but nothing in the generator ever read those flags. A
real-world motivating case is MonoGameGum's `GraphicalUiElementExtensionMethods`, a static class
of extension methods meant to be called as if they were instance methods on
`GraphicalUiElement`. Version 38 injects matching extension methods directly into the extended
class's own package, as ordinary `obj!`-first wrapper functions indistinguishable in calling
convention from a real instance method.

### Matching is v1/exact-concrete-only, by design

`build-extension-method-index` (a new global index over every provided assembly's metadata,
mirroring `build-metadata-index`/`build-simple-name-index`'s "scan everything once, bucket by
key" shape) maps each extension method's `this`-parameter type's exact `:fully-qualified-name`
string to a list of `(method-plist holder-plist holder-assembly-name)` entries. A class is only
offered the extension methods bucketed under its own exact FQ name — no base-class, interface,
or open-generic (`this IEnumerable<T>`) matching. This was a locked design decision, not an
oversight: base-class/interface/generic matching is real future work (see `doc/plan-v38.md`'s
"Deferred / Future" section) but was judged too large and too risky to bundle with the first cut.
An open-generic `this` type (e.g. LINQ's `` IEnumerable`1[TSource] ``) is additionally guarded via
`generic-type-p` when building the index, though in practice this is belt-and-suspenders: such a
type string never naturally equals any real type's own `:fully-qualified-name` anyway (a real
open generic type definition's FQ name has no bracketed arguments at all, e.g.
`` System.Collections.Generic.List`1 ``).

### Enabled by default — the one deliberate inconsistency with every other sticky flag

Every other per-class/sticky-default flag pair in this file (`--export-parents`/
`--export-all-parents`, `--defgeneric`/`--enable-defgeneric`, etc.) defaults OFF. Extension-method
injection is the one exception: `--extension-methods`/`--enable-extension-methods` default ON
(`Program.cs`'s `enableExtensionMethods = true`). This was an explicit requirements decision:
injecting a class's own genuinely-applicable extension methods was judged to be the common case a
user would want without having to ask for it, unlike the other opt-ins (which each have real
downsides — larger generated surface, ancestor-graph expansion, CLOS collision risk — that
justify defaulting off). `--no-extension-methods`/`--no-enable-extension-methods` opt back out.

### Three skip passes, in a specific order

`compute-matched-extensions-for-class` applies exactly the precedence `doc/plan-v38.md` specifies,
and no other: (1) a candidate that is dirty (any non-`this` parameter is `ref`/`out`/`params`/has
a default) or generic (the method's own type argument(s), or — a rarer edge case — a non-generic
extension method on a *generic holder class* referencing that class's own open type parameter in
a non-`this` parameter or return type) is skipped individually, before any name-collision
reasoning; (2) of what remains, a candidate whose Lisp name (`map-member-name` of its clean
C# name) collides with the class's own already-declared export set
(`compute-package-exports-and-shadows`, called with no `matched-extensions` of its own — the
question here is only "does the class already have a real member of this name," not "do two
extension methods collide with each other") is skipped, since the class's own member always wins;
(3) of what remains after that, candidates are grouped by Lisp name, and any group of more than
one entry is skipped *in full*, as ambiguous — extension-method overload dispatch (generalizing
the Master Wrapper to dispatch across different holders) is deferred, exactly like a genuinely
dirty overload is today. Each skip is documented with a reason-specific comment in the generated
class file, following this codebase's established "document what can't be safely generated"
convention (dirty overloads, unsupported indexers).

`extension-method-dirty-or-generic-reason` deliberately does not reuse `dirty-method-p`/
`clean-method-p` directly: both operate on a method's *full* `:parameters` list, which for an
extension method includes the `this` parameter at index 0 — a parameter that is never itself
dirty or generic in any real C# extension method, but stripping it correctly before applying the
same checks needed its own small function rather than a call-site hack.

### Wiring: a third slot needing three-way agreement, same shape as Version 32's events

Like Version 32's events (`class-member-names-excluding-events`) and Version 37's fix
(`collect-class-instance-generics` gaining `constant-properties-list`), injecting new exported
names/function bodies requires the same three functions to agree on them:
`compute-package-exports-and-shadows` (defpackage's `:export` list),  `generate-class-file` (the
actual `cl:defun` bodies), and `collect-class-instance-generics` (unified-generics eligibility,
per the Version 37 principle that unification should cover every generated `obj!`-first wrapper,
not just the ones that happen to have started life as a real C# instance method). All three
gained an `&optional matched-extensions` parameter. `generate-assembly-packages-batch` computes
each opted-in resolved-class's `:matched-extensions`/`:skipped-extensions` once, via the new
`compute-matched-extensions-for-class`, and stores both directly onto the resolved-class plist
(mutating the existing `nil`-initialized slots `make-resolved-class` reserves for them) *before*
`packages.lisp`/class-file/generics-file generation runs — all of which read those two slots back
off the plist rather than recomputing anything, so there is exactly one source of truth per class
for "which extension methods actually got injected."

A surviving extension method is emitted calling `dotnet:static` on the *holder* type's FQ name
(a literal string baked into the generated code, e.g. `"MonoGameGum.GraphicalUiElementExtensionMethods"`)
— never `<type-str>`, which names the class *being extended*, not the class that declares the
static method — with `obj!` threaded through as the method's first positional argument, mirroring
exactly how C#'s own extension-method call sugar desugars. The docstring names the holder's FQ
name and owning assembly, so a user reading generated code (or `describe`-ing the function at a
REPL) can tell at a glance that a given function is not really native to the class whose package
it lives in.

## Recursive Related-Class Discovery (Version 39)

See `doc/plan-v38.md`'s Part B for the full design document this implements.

### What changed and why

Version 33 gave a class two ways to reach *upward* — `--export-parents`/`--export-interfaces`
discover a class's ancestors and re-export their non-conflicting members into the requesting
class's own package. Version 39 adds three ways to discover *outward*: `--output-nested`
(types nested inside a class), `--output-children` (subclasses of a class), and
`--output-implementations` (implementers of an interface). All three are deliberately
**generate-only** — a discovered type becomes its own independent package, and the class that
discovered it is never modified. This was a locked requirements decision, not an oversight: an
early draft of this plan proposed also re-exporting a subclass's members up into its base
class's package, but that is semantically backwards (a base class's package re-exporting its own
subclasses' members would make `base:derived-only-method` resolve for every instance of `base`,
including ones that are not actually a `derived`) — the corrected design treats the anchor purely
as a *discovery seed*.

### Flag propagation: the significant behavior change

The other half of Version 39, and the part that actually changes existing generated output for a
class that already used `--export-parents`/`--export-interfaces`: **every discovered class now
carries its discoverer's entire per-class flag set**, not just the two ancestor flags in isolation
and not a flag-less plain package the way a Version 33 ancestor was. Concretely: if `Derived` is
requested with `--export-parents --output-children`, its discovered parent `Base` now *also*
carries `--export-parents` (so `Base` independently re-exports *its own* ancestors into itself)
and `--output-children` (so `Base`'s own subclasses — which may include types other than
`Derived` — are also discovered and added as their own packages). This was an explicit
requirements decision (see `PLAN.md`'s "More Parent & Ancestor stuff" section): "All the
discovered classes should carry the classes from the anchor — so recursive, yes." The only
exception is `--constant-properties`, which names properties specific to one concrete class and
is never propagated; a discovered class's constant-properties is always empty unless it was also
explicitly requested (in which case the explicit request's own flags and constant-properties win
outright, and no duplicate resolved-class entry is created — the pre-existing Version 33 dedup
rule, unchanged).

### Why the ancestor-chain walk stays a single, self-contained call (and why the downward walk doesn't)

The most subtle correctness point in this version: `expand-related` (replacing `expand-ancestors`)
still resolves a single class's *entire* upward ancestor chain in **one self-contained internal
multi-hop call**, exactly reproducing what `expand-ancestors` did before this version — it does
**not** rely on the outer discovery queue for multi-level completeness the way the three new
downward directions do. This is not an arbitrary implementation choice; it is required for
correctness. A class's re-export block (`emit-child-reexports`) is computed **once, statically, at
generation time**, from a flat list of that class's own immediate-plus-transitive ancestors —
each ancestor's *own* exports are read directly off its class metadata plist
(`compute-package-exports-and-shadows`), not off whatever that ancestor's *own* re-export block
might add to it at load time (a `cl:import`/`cl:export` side effect, invisible to the static
generation-time computation of another class's re-export list). If `expand-related` only returned
one hop per call and relied on the outer queue to reach the grandparent — the same way it safely
does for `--output-children` — the child's re-export block would only ever see its immediate
parent's *own* declared members, silently losing every level above that, even though the parent
itself (now also carrying `--export-parents` via propagation) *would* re-export the grandparent's
members into *itself* at load time. The three downward directions have no equivalent correctness
hazard: a discovered nested type/subclass/implementer is only ever its own independent package,
never something whose declared-member list a static computation needs to flatten into someone
else's package, so relying on the outer queue's own recursion (re-invoking `expand-related` on
each newly-discovered class using its now-propagated flags) is completely safe for them, and
avoids duplicating multi-hop logic for three different reverse-index shapes.

### Reverse indexes and the nested-type prefix scan

`build-reverse-indexes` (built once per batch, alongside `build-metadata-index`/
`build-extension-method-index`, over the same global per-batch metadata index) produces two hash
tables in one pass: `subclass-index` (superclass FQ name → direct subclasses only — the
*indirect* subclasses are reached by the outer queue re-invoking `expand-related` on each direct
subclass in turn, which inherits `--output-children` via propagation) and `implementer-index`
(interface FQ name → every implementer, already fully transitive in one lookup, since .NET's
`Type.GetInterfaces()` already includes every interface a type's own base classes implement).
Nested-type discovery needs no precomputed index at all: a type's CIL-native nested-type FQ name
always carries its enclosing type's FQ name as a literal prefix followed by `+` (e.g.
`Outer+Inner+Innermost` starts with both `Outer+` and `Outer+Inner+`), so a single prefix scan
over the metadata index, from the discovering class's own FQ name, already reaches every nesting
depth in one pass — no recursion (internal or via the outer queue) is needed for this direction at
all, though the outer queue harmlessly re-discovers already-visited nested types if a nested
type itself also carries `--output-nested` via propagation (deduplicated the same way everything
else is).

### Fan-out safety

`--output-children`/`--output-implementations` on a widely-derived base class or interface —
especially compounded by flag propagation now recursing into each discovered subclass's *own*
subclasses — can plausibly pull in a very large number of types from a big enough BCL or
third-party assembly. Rather than a hard cap (which would silently produce incomplete,
surprising output), `generate-assembly-packages-batch` counts every class discovered via the
Phase B work queue and prints a warning to `*error-output*` if the total exceeds 200, so an
accidental combinatorial crawl is visible to the user rather than just "the tool is taking a long
time" — the batch itself is never truncated or refused.

## Generic Superclass/Interface Identity Matching (Version 40)

### The bug, and how it was found

Reported live against a real, third-party class hierarchy while verifying Version 39's
`--export-parents`/`--export-interfaces` behavior: generating
`MonoGameGum.GueDeriving.ContainerRuntime` worked correctly, but requesting
`Gum.Collections.GraphicalUiElementCollection` (also from the Gum/MonoGameGum codebase) with
`--export-parents --export-interfaces` failed with:

```
Error: Ancestor class not found in any provided assembly metadata: RenderingLibrary.Graphics.ObservableCollectionNoReset`1[[Gum.Wireframe.GraphicalUiElement, GumCommon, Version=2026.5.8.1, Culture=neutral, PublicKeyToken=null]] (required by Gum.Collections.GraphicalUiElementCollection)
```

— even though `RenderingLibrary.Graphics.ObservableCollectionNoReset\`1` (the class
`GraphicalUiElementCollection` actually derives from, via the closed instantiation
`ObservableCollectionNoReset<GraphicalUiElement>`) was plainly visible, as its own top-level
entry, in the very same batch's reflected metadata.

The root cause is in `AssemblyToLispy.cs`, not this file: `:superclass`/`:interfaces` were
formatted using .NET's raw `Type.FullName`, which behaves very differently for a generic type
than for an ordinary one, in two distinct ways that both produce the same downstream symptom
(the metadata-index lookup in `expand-related`/`build-reverse-indexes` — a plain `gethash` keyed
on `:fully-qualified-name` — silently, or noisily, fails to find an ancestor that is genuinely
present):

1. **Closed generic instantiation** (a base/interface parameterized by concrete type(s), e.g.
   deriving from `ObservableCollectionNoReset<GraphicalUiElement>`): `Type.FullName` returns the
   *specific instantiation's* full, assembly-qualified, bracketed CLR form (the string in the
   error message above). This can never equal the generic type *definition*'s own
   `:fully-qualified-name` (always the bare `` Name`Arity `` form, e.g.
   `` RenderingLibrary.Graphics.ObservableCollectionNoReset`1 ``) — and no arbitrary closed
   instantiation is *ever* itself separately reflected as its own top-level metadata entry (only
   the generic type definition is, when the reflecting assembly enumerates its own types), so a
   closed instantiation was *never* going to resolve, no matter which assemblies were provided.
   This is a hard error (unless `--skip-missing`), so it surfaces loudly.
2. **Generic type referencing its own unresolved type parameter** (a generic type's own base
   class, e.g. `class Derived<T> : Base<T>` — `Derived<T>`'s own `:superclass` reflects `Base<T>`
   where `T` is `Derived`'s own, still-unresolved, type parameter): `Type.FullName` is
   *documented* to return `null` for this case, and the pre-fix code fell back to `Type.Name`,
   silently dropping the namespace entirely (e.g. bare `"ObservableCollection\`1"` instead of
   `"System.Collections.ObjectModel.ObservableCollection\`1"`). Since `--skip-missing`'s warning
   path and its hard-error path both print whatever string ended up in `:superclass`/
   `:interfaces` verbatim, this symptom is easy to mistake for a genuine "wrong assembly"
   problem — which is exactly what happened before this bug was diagnosed: a `Makefile` comment
   from the `--skip-missing`/`ValueTuple` smoke-test example had already flagged
   `System.IComparable\`1`/`System.IEquatable\`1` (`System.ValueTuple\`2`'s own generic
   interfaces) being spuriously reported "missing", attributing it to "the generic-interface-
   name-formatting bug" without yet having traced it to this exact root cause. Both symptoms are
   the same bug.

Since this bug predates Version 38/39 entirely (it was already present in Version 33's original
`expand-ancestors`, unchanged by the rename to `expand-related`), it silently affected *any*
class whose immediate ancestor was a generic type in either of these two shapes — plausibly a
large fraction of real-world `--export-parents`/`--export-interfaces` (and, since Version 39,
`--output-children`/`--output-implementations`) usage against realistic OOP hierarchies (generic
container base classes, `IEquatable<T>`/`IComparable<T>`, etc.), not an edge case.

### The fix

A new `AssemblyToLispy.cs` helper, `GetTypeIdentityFullName`, resolves both cases identically:
for any generic type (`Type.IsGenericType`), use `GetGenericTypeDefinition().FullName` — which is
*never* `null` and *never* assembly-qualified/bracketed, regardless of whether the original type
was closed to concrete arguments or still open on its own declaring type's type parameter — in
place of the type's own `FullName`. A non-generic type is completely unaffected (still
`Type.FullName ?? Type.Name`, as before). `:superclass`/`:interfaces` now always hold this bare,
matchable identity form, used in place of the previous `type.BaseType.FullName ?? type.BaseType.Name`
/ `i.FullName ?? i.Name` at the two call sites (`AssemblyToLispy.cs`'s general-metadata Phase 2A
block).

No change was needed to `assembly-package-generator.lisp`'s own resolution logic
(`expand-related`, `build-metadata-index`, `build-reverse-indexes`) at all — they already assumed
`:superclass`/`:interfaces` were reliable identity-matching keys; the metadata just wasn't
honoring that contract for generic ancestors. This mirrors Version 30's precedent (a metadata-
only `AssemblyToLispy.cs` fix needing zero changes to this file's own code), which is why
`*generator-version*` is still bumped here: real generated output changes for any real assembly
with a generic ancestor in either of the two shapes above (a previously hard-erroring or
falsely-"missing"-reported ancestor now resolves and generates correctly).

### Preserving the discarded closed-instantiation information

Making `:superclass`/`:interfaces` always the bare identity form necessarily *discards* which
concrete type argument(s) a closed generic ancestor actually used (or, in the unresolved-type-
parameter case, that parameter's own name) — information the pre-fix (buggy) format at least
*attempted* to carry, even though it was useless for matching. Rather than lose it outright, two
new sibling metadata keys preserve it, using the exact same simplified backtick/bracket notation
`:type`/`:return-type` already use for the identical purpose (`GetFriendlyTypeName`):

* **`:superclass-closed`** (string, omitted entirely when the superclass is non-generic — i.e.
  whenever it would be textually identical to `:superclass`): the base class with its actual
  generic argument(s) shown, e.g.
  `` "RenderingLibrary.Graphics.ObservableCollectionNoReset`1[Gum.Wireframe.GraphicalUiElement]" ``.
* **`:interfaces-closed`** (list of `(identity closed-1 closed-2 ...)` lists, one per *generic*
  identity in `:interfaces` only — a non-generic interface is never given an entry here, since
  its identity and closed forms are identical and it's already fully captured by `:interfaces`):
  each entry's first element is that interface's own identity string as it appears in
  `:interfaces` (for correlation back to it, guaranteed to appear at most once across
  `:interfaces-closed`'s own entries); the rest of the entry is that identity's closed form(s).

### A same-identity collision this needed a second fix for: implementing one generic interface multiple times

`:interfaces`/`:interfaces-closed` needed one more correction after the initial Version 40 fix
shipped, caught by a follow-up question rather than a fresh bug report: C# permits a type to
implement the *same* open generic interface more than once, each time closed over different
concrete type arguments — `class Foo : System.IEquatable<int>, System.IEquatable<string>`
compiles without complaint (confirmed directly). `GetTypeIdentityFullName` maps *both* of
`Foo`'s `IEquatable<T>` implementations to the exact same identity string
(`"System.IEquatable\`1"`), which is correct in isolation (that's the whole point of the
identity form), but the *first* draft of this fix built `:interfaces`/`:interfaces-closed` by a
naive 1:1 `Select` over `Type.GetInterfaces()` — producing a literal duplicate identity string
in `:interfaces`, and, far worse, two separate `:interfaces-closed` entries sharing the identical
key (`("System.IEquatable\`1" . "...[System.Int32]")` and `("System.IEquatable\`1" .
"...[System.String]")`). A cons-keyed-by-identity representation cannot hold two closed forms
under one key without one silently shadowing the other in any `assoc`-style lookup by identity —
exactly the kind of information loss `:interfaces-closed` exists to prevent in the first place.

The fix: `AssemblyToLispy.cs` now groups `type.GetInterfaces()` by identity (`GroupBy`) before
building either list. `:interfaces` becomes the deduplicated identity set (one entry per group);
`:interfaces-closed` becomes one entry *per identity*, whose remaining elements are *all* of that
identity's closed forms in reflection-discovery order — a proper one-to-many list, not a cons
pair, so a same-identity multiple-instantiation case (rare, but real, and exactly the kind of
gap that would otherwise fail silently rather than loudly) is representable without collision.

Both new keys remain strictly descriptive/documentation-only — nothing in
`assembly-package-generator.lisp` reads either key; ancestor resolution always matches on the
identity form (and correctly needs no per-instantiation distinction, since a class implementing
the same open interface twice is still just one ancestor to discover/re-export from once).
`tests/framework.lisp`'s schema validator checks both keys' shape, that every
`:interfaces-closed` identity actually appears in `:interfaces`, and that no identity appears
more than once as a top-level `:interfaces-closed` entry, and `doc/assembly-to-lispy.md`
documents the exact semantics and omission rules.

### Verification

Confirmed against the real, motivating third-party case:
`Gum.Collections.GraphicalUiElementCollection --export-parents --export-interfaces` (with
`GumCommon.dll`/`MonoGameGum.dll` provided) now correctly generates a package for
`RenderingLibrary.Graphics.ObservableCollectionNoReset\`1` and re-exports its members, instead of
hard-erroring. A dedicated regression fixture was added to
`AssemblyToLispyTestTarget/EdgeCases.cs`: `GenericBaseForSuperclassTest<T>` (whose own base,
`System.Collections.Generic.List<T>`, exercises the unresolved-type-parameter/lost-namespace
case) and `ConcreteDerivedFromGeneric : GenericBaseForSuperclassTest<EdgeCaseStruct>` (whose base
exercises the closed-instantiation/never-matches case), both asserted directly against in
`tests/synthetic-target.test.lisp`, plus an end-to-end `--export-parents` smoke-test invocation
(`Makefile`) confirming real resolution end-to-end, not just the metadata shape.
