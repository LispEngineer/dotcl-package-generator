# Generated Package Features

* Author: Douglas P. Fields, Jr. - symbolics@lisp.engineer
* Copyright 2026 Douglas P. Fields, Jr.

This document describes, feature by feature, how `dotcl-packagegen` translates a C#
class/struct/interface/enum/delegate's members into the Lisp constructs of a generated
package. For the CLI itself, see `README.md`/`CLAUDE.md`; for the reflected metadata schema
those translations read from, see `doc/assembly-to-lispy.md`; for the full per-version
design rationale behind each rule below, see `doc/generator-design-notes.md`.

The final section, **Unsupported Features**, lists C# and CIL features this tool does not
yet translate — including a few real silent gaps, not just documented TODOs.



## Conventions

**Summary:** Lisp names are kebab-case derived from C# PascalCase/camelCase; a handful of
names are remapped to avoid colliding with Lisp syntax or reading better as Lisp idioms;
every overloaded member collapses to at most one or two exported names regardless of how
many C# overloads exist; every class gets a fixed 4-constant header and one CLOS
registration form.

### Name casing: `camel-to-kebab`

Every C# identifier (type, member, or parameter name) is converted from
PascalCase/camelCase to kebab-case: an uppercase letter starts a new word (hyphen-inserted)
unless it's already at a word boundary or is part of a run of capitals immediately followed
by a lowercase letter (so `IOStream`-style runs don't get hyphenated letter-by-letter).
`NaN` is special-cased to `"nan"` (not the literal `"na-n"`). A `.` (only ever seen in a
*type's* fully-qualified name) also maps to `-`.

```
Vector2       -> vector2   (no internal hyphen: no case-transition inside "Vector2")
DistanceSquared -> distance-squared
IsNaN         -> is-na-n   (handled specially before this, see below)
```

### Type/package naming: `type-fq-name-to-pkg-name`

A type's Lisp package name and output filename are derived from its
`:fully-qualified-name` by first flattening two CIL-only characters that `camel-to-kebab`
itself must never touch (because it's also applied to already-mapped operator names that
legitimately reuse `+`) — CIL's nested-type separator `+` and the open-generic-type arity
backtick `` ` `` — to `-`, then kebab-casing the result:

```
Microsoft.Xna.Framework.Graphics.SpriteFont+Glyph
  -> microsoft-xna-framework-graphics-sprite-font-glyph
System.Collections.Generic.Dictionary`2
  -> system-collections-generic-dictionary-2
```

The type's *reflection-facing* fully-qualified name (used for `dotnet:resolve-type`,
`(the (dotnet "...") ...)` hints, etc.) is never touched by this — only the generated
package/file name is.

### Member naming: `map-member-name` (methods, properties, fields)

Kebab-cases the name, then applies two special-purpose rewrites, in this order:

1. **`IsSomething` → `something?`.** A name starting with `Is` followed by an uppercase
   letter drops the `Is` prefix and appends `?` (e.g. `IsEmpty` → `empty?`,
   `IsNaN` → `nan?`). This is deliberately `something?`, not Lisp's usual `-p` suffix.
2. **Reserved-symbol protection.** A resulting name equal to `quote`, `function`, `t`, or
   `nil` gets a trailing `!` (`quote!`, `function!`, `t!`, `nil!`) instead of being emitted
   as-is — these are Common Lisp reader/special-operator names that would otherwise corrupt
   reader macros (`'`, `#'`) or collide with the constants `t`/`nil` if left bare.

### Parameter naming: `map-param-name`

Kebab-cases the name; a result equal to `t` or `nil` gets a `-val` suffix (`t-val`,
`nil-val`) instead of `!` — parameters are never read-macro-sensitive the way member names
can be, so a plain non-colliding rename suffices. See `+`'s generated wrapper below for a
real example (`TimeSpan.op_UnaryPlus`'s parameter, literally named `t` in C#, becomes
`t-val`).

### Receiver parameter: `obj!`

Every instance method/property/field wrapper's implicit receiver parameter is always
named `obj!` (never bare `obj`) — `map-param-name` can never itself produce `obj!` (it
never appends `!`), so no C# parameter, however named, can ever collide with it.

### Operator overloads

C#'s IL-mangled operator method names (`op_Addition`, `op_Equality`, etc.) are mapped to
idiomatic Lisp operator symbols before any of the above naming rules ever see them:

| C# / CIL              | Lisp   | C# / CIL              | Lisp   |
|-----------------------|--------|-----------------------|--------|
| `op_Addition`         | `+`    | `op_LessThan`         | `<`    |
| `op_Subtraction`      | `-`    | `op_GreaterThan`      | `>`    |
| `op_Multiply`         | `*`    | `op_LessThanOrEqual`  | `<=`   |
| `op_Division`         | `/`    | `op_GreaterThanOrEqual`| `>=`  |
| `op_Equality`         | `=`    | `op_UnaryPlus`        | `+`    |
| `op_Inequality`       | `not=` | `op_UnaryNegation`    | `-`    |
| `op_LogicalNot`       | `not`  | `op_Increment`        | `1+`   |
| `op_True`             | `true` | `op_Decrement`        | `1-`   |
| `op_False`            | `false`| `op_Implicit`         | `implicit-cast` |
| `op_Explicit`         | `explicit-cast` | | |

These mapped names then flow through the ordinary method-overload machinery below (they
are frequently overloaded, e.g. unary vs. binary `+`/`-`, or `+`/`-` across several
argument-type combinations), and any that collide with a standard Common Lisp external
symbol (`+`, `-`, `*`, `/`, `=`, `<`, `>`, etc.) are automatically added to the package's
`:shadow` list. Generated templates always call the *real* CL functions with an explicit
`cl:` prefix (`cl:cond`, `cl:length`, `cl:apply`, ...) specifically so this shadowing never
breaks the generator's own dispatch logic.

### At most one or two exported names per member group

No matter how many raw C# overloads/arities a method name has, generated packages export
at most:
* `name` and `name*` — instance vs. static, only when both exist for the same name
  (the `*` suffix marks the static counterpart).
* `name` and/or `name<>` — non-generic vs. generic-with-type-argument, only when needed
  (see "Generic Methods" below); combined with the above as `name*<>` when a method is
  both mixed static/instance *and* multi-arity-generic (`*` always precedes `<>`).

A single dispatching "Master Wrapper" function selects the right underlying C# overload
at runtime by inspecting argument count/types (see "Method Overloads" below) — there are
no separate type-suffixed direct-call functions (e.g. no `contains-vector2`) since
Version 24.

### Per-class header

Every generated `.lisp` file starts with the same four constants and one CLOS
registration form, regardless of the C# type's kind:

```lisp
(cl:defconstant <type> (dotnet:resolve-type "System.Numerics.Vector2"))
(cl:defconstant <type-str> "System.Numerics.Vector2")
(cl:defconstant <creation> "2026-07-04T12:18:00Z")
(cl:defconstant <version> 28)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Numerics.Vector2")))
```

`<type>`/`<type-str>` are used throughout the rest of the file for `dotnet:static`,
`dotnet:new`, and `(the (dotnet ...) ...)` type hints; `<creation>`/`<version>` just record
provenance (all files from one CLI invocation share one `<creation>` timestamp). The CLOS
registration makes the type dispatchable by `defgeneric`/`defmethod` via DotCL's
`dotcl-internal` class wrappers (see `doc/generator-design-notes.md`'s ".NET CLOS
Integration" section for the namespace-collision caveat this carries: CLOS registration
keys only on the type's *short* name, so two same-named types in different namespaces
share one CLOS class).



## Constructors

**Summary:** every C# constructor overload collapses into one `new` function per class
(none, if the class has no usable/clean constructor).

* **No usable ("clean" — see below) constructor**: no `new` is generated; every
  constructor's signature is instead listed in a comment.
* **Exactly one clean constructor**: `new` takes its parameters positionally, e.g.
  `(cl:defun new (value y) ... (dotnet:new <type-str> value y))`.
* **Two or more clean constructors**: a single Master Wrapper `new` (see "Method
  Overloads" below for the dispatch mechanism) covers all of them, e.g.
  `System.TimeSpan`'s six constructor overloads collapse into one `new` with
  `&optional (ticks) (minutes) (seconds) (seconds2) (milliseconds) (microseconds)` slots,
  each `cond` clause dispatching on which optional args were actually supplied.
* **Structs' implicit parameterless constructor**: .NET reflection never returns a
  struct's implicit default constructor via `GetConstructors()`. If a struct (`:kind
  :struct`) has no explicit zero-parameter constructor in its metadata, the generator
  injects one, so `(new)` always works for a struct.
* A constructor with `ref`/`out`/`ref readonly`/`params`/default-valued parameters is
  "dirty" (see "Method Overloads") and is documented in a comment rather than generated.

Constructor visibility (public/protected) is not itself checked by the generator — any
constructor present in the reflected metadata gets a wrapper, including a protected one
(useful on an abstract base class if you need it for subclassing scenarios in Lisp, but
not directly instantiable at runtime the normal way).



## Static Constants and Symbol Macros

**Summary:** a static, read-only field or property becomes either a `defconstant`
(compile-time constant) or a `define-symbol-macro` (re-evaluated dynamic property/field
access on every reference), depending on whether it's a true CIL constant, a read-only
field, or a property — and, for properties/fields specifically, whether `--constant-properties`
opted it in as a constant.

* **Compile-time literal fields** (`:literal t` — C#'s `const`, always a static field):
  always `defconstant`, since these are baked into the IL at compile time and genuinely
  never change. This is also how **enum members** are generated — a C# enum's members
  reflect as static literal fields of the enum type, so `System.DayOfWeek.Monday` becomes
  `(cl:defconstant +monday+ (dotnet:static <type-str> "Monday"))` with no special-casing
  needed anywhere in the generator.
  ```lisp
  (cl:defconstant +zero+ (dotnet:static <type-str> "Zero"))
  (cl:setf (cl:documentation (cl:quote +zero+) (cl:quote cl:variable))
           "Returns a vector whose 2 elements are equal to zero.")
  ```
* **Static read-only fields/properties** (a static field with `:init-only` but not
  `:literal`, or any static property that is readable and not writeable): reflection
  cannot tell whether such a property's value could ever change at runtime, so by default
  these become `define-symbol-macro` — re-evaluated on every access:
  ```lisp
  (cl:define-symbol-macro local (dotnet:static <type-str> "Local"))
  ```
  Passing `--constant-properties` with the field/property's name (or `"*"` for all) forces
  it to `defconstant` instead. Despite the flag's name, it applies identically to matching
  *fields* as well as properties.

* Both forms get a `cl:setf (cl:documentation ...)` line attaching the XML-doc summary
  (if any) as the symbol's Lisp `variable` documentation.

**⚠️ `--constant-properties` hazard for struct-typed constants.** `defconstant`'s value
form runs exactly *once*, and `dotnet:static` returns a *reference* to a boxed CLR object,
not a value-copied Lisp datum — so a `--constant-properties`-selected field/property whose
type is a mutable struct (e.g. `Vector2.Zero`, `Color.White` — the exact examples this
tool's own README/CLAUDE.md use to demonstrate the flag!) becomes a single boxed instance
shared and re-returned by *every* reference to that constant for the remaining life of the
program. Mutating it — through the constant directly, or through any other Lisp binding
that happens to alias the same boxed instance — silently corrupts it everywhere, forever.
The default `define-symbol-macro` path has no such hazard, since it re-invokes
`dotnet:static` (and thus the real C# getter, which per ordinary value-type semantics
returns an independent copy every time) on every single reference.

Because of this, the generator now emits a detailed warning comment above every
`--constant-properties`-selected `defconstant` (and above true C# literal/`const`-field
`defconstant`s, applied uniformly, though C# cannot express a non-primitive `const` so
that path is a no-op safety net in practice) whose type is not a recognized safe,
effectively-immutable primitive:
```lisp
;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector2 is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +zero+ (dotnet:static <type-str> "Zero"))
```
This is a deliberately broad allowlist-based check (numeric primitives, `System.String`,
`System.Char`, `System.Boolean`, `System.IntPtr`/`UIntPtr` are considered safe; everything
else gets the warning), not a precise per-type mutability check — the generator only ever
sees one type's own metadata at a time, with no cross-type lookup available to confirm
whether some *other* referenced type actually has settable instance members. See
`doc/generator-design-notes.md`'s Version 29 section for the full incident writeup
(including the live REPL transcript that surfaced this) and `PLAN.md` for the tracked
follow-up work (a safe way to *clone* a boxed struct, which would actually solve this
rather than just warn about it).

**Not handled — see Unsupported Features:** any static property or field that is
*writeable* (settable) generates nothing at all, regardless of whether it's also
readable.



## Instance Properties (including Indexers)

**Summary:** a readable instance property becomes a plain accessor function; a writeable
one becomes either a `setf`-expander (if also readable) or a `set-name` function (if
write-only); a C# indexer (`this[...]`) threads its index parameter(s) through
positionally, unless the indexer itself is overloaded, in which case it is unsupported.

```lisp
(cl:defun item (obj! key)
  (dotnet:invoke (cl:the (dotnet "...Dictionary`2") obj!) "get_Item" key))
(cl:defun (cl:setf item) (new-value obj! key)
  (dotnet:invoke (cl:the (dotnet "...Dictionary`2") obj!) "set_Item" key new-value))
```

* Read-only: `(name obj! ...index-params)`.
* Read-write: `(name obj! ...index-params)` getter plus a `(setf (name obj! ...index-params) new-value)` setter.
* Write-only: `(set-name obj! ...index-params new-value)` — write-only properties never
  get a `setf` form, since there's no getter for `setf`'s expansion to pair with.
* An **overloaded indexer** (distinct index-parameter signatures on the same name, e.g.
  `this[int]` alongside `this[string]`) is not yet supported — no function is generated;
  every signature is instead listed in a comment (see Unsupported Features).
* Mutating a **struct's** (value type's) property via the generated `setf` mutates the
  exact boxed `.NET` instance `obj!` refers to, in place — a comment noting this, and its
  real caveat (aliasing, not data loss — see below), is automatically inserted above
  every struct property mutator:
  ```lisp
  ;; Note: obj! here is a boxed reference to a .NET value type (struct).
  ;; This setf mutates that exact boxed instance in place -- it does NOT
  ;; silently discard the change. However, if obj! is an alias of a shared
  ;; or cached value (e.g. a constant defined via defconstant), this mutates
  ;; that shared instance for every other reference to it too. See
  ;; FEATURES.md's "Struct Boxing Caveat" section for details.
  ```
  Reference types (classes) never suffer from any special caveat here; only struct/enum
  (`:kind :struct`/`:enum`, `is-value-type-p`) receivers get the comment (though, as the
  comment notes, reference-type aliasing has the exact same "shared object" property in
  ordinary C#/Lisp too — it just isn't singled out with a comment here).

### Struct Boxing Caveat

**Summary:** setting a struct's property/field via the generated `setf` mutator
**succeeds**, in place, on the exact boxed `.NET` object the receiver refers to —
regardless of how the new value argument was produced (`dotnet:box`, a real invoked
conversion call, and a `the`-typed literal all behave identically). The real caveat isn't
data loss; it's **aliasing**: if that boxed object is shared by more than one Lisp
binding — most dangerously, a `--constant-properties`-cached `defconstant` — mutating it
through any one alias mutates it for every other alias too, including the "constant."

A struct obtained from Lisp (via `dotnet:new`, `dotnet:static`, a property getter, or a
stored constant) is never a raw unboxed Lisp value — it's a `#<DOTNET ...>` reference to
a boxed CLR object. `dotnet:invoke`'s `setf`-expansion mutates that exact object directly.
A real, verified `make repl` transcript against `dotcl-dungeonslime` demonstrates this,
and then reveals the actual hazard:
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
`color:+white+` — a `defconstant` — was permanently mutated, because `x` was bound to the
*exact same box* `+white+` had always pointed to (`defconstant`'s value form runs once and
is cached forever; `defparameter x color:+white+` just copies that reference, not the
struct's contents). See "Static Constants and Symbol Macros" above for the full mechanism
and why `define-symbol-macro`-based constants don't share this hazard.

**No workaround currently exists** to safely obtain an independent, mutable copy of a
cached struct constant from Lisp — this is tracked as a prioritized follow-up in
`PLAN.md` (a safe struct-clone capability), not solved in this pass. In the meantime,
avoid retaining a direct reference to a `--constant-properties`-cached constant anywhere
you intend to mutate it; construct a fresh instance via the type's own constructor
(`new`) instead.

This same finding extends to struct-mutating **instance methods**, not just property
`setf`: a live REPL check confirmed calling a `void`-returning mutating instance method
(e.g. `Vector2.Normalize()`) also mutates the receiver in place, correctly — the
similar-sounding claim in `doc/generator-design-notes.md`'s "Struct Mutation, Boxing, and
Overload Resolution (Version 16)" section has been corrected accordingly. The one real
caveat there: since such a method returns `void`/`nil`, never write `(setf v
(v2:normalize v))` — that overwrites `v` with `nil`. Call `(v2:normalize v)` alone and let
it mutate `v` in place. The same aliasing hazard described above applies here too: if the
struct is aliased elsewhere (e.g. a cached constant), the mutation is visible through
every alias.



## Instance Fields

**Summary:** a public instance field gets a getter always, plus a `setf`-expander unless
the field is C#'s `readonly`.

Unlike a property, a field has no `get_Foo`/`set_Foo` accessor method to invoke by name —
the getter uses `dotnet:invoke`'s built-in field-read support (passing the bare field
name); the setter uses the `setf`-expansion of `dotnet:invoke` itself, since `dotnet:invoke`
has no direct field-write equivalent:

```lisp
(cl:defun field-name (obj!)
  (dotnet:invoke (cl:the (dotnet "Fq.Type") obj!) "FieldName"))
(cl:defun (cl:setf field-name) (new-value obj!)
  (cl:setf (dotnet:invoke (cl:the (dotnet "Fq.Type") obj!) "FieldName") new-value))
```

The same corrected struct-boxing comment as instance properties (see "Struct Boxing
Caveat" above) is emitted above the setter for value-type fields.

**Not handled — see Unsupported Features:** a plain mutable *static* field (not
`readonly`, not `const`) generates nothing at all.



## Methods and Method Overloads

**Summary:** a method with no overloads (of any kind) generates a single typed function;
a name with two or more usable overloads collapses into one runtime-dispatching "Master
Wrapper"; methods using `ref`/`out`/`ref readonly`/`params`/default parameters, or the
declaring generic type's own (as opposed to the method's own) unresolved type parameter,
are not generated at all — only documented in a comment (or, for the latter, silently
excluded — see Unsupported Features).

* **Single clean overload**: a direct typed wrapper, e.g.
  `(cl:defun dispose (obj!) (dotnet:invoke (the (dotnet "...") obj!) "Dispose"))`. For a
  value-type (struct) receiver, this still uses the same `(the (dotnet "Type") obj!)`
  optimization as a reference type (DotCL 0.1.11+ supports the boxing/`constrained.`
  pattern needed for this).
* **Two or more clean overloads (a "Master Wrapper")**: one function whose lambda list
  merges every overload's parameters — a common mandatory prefix, then `&optional
  (param nil supplied-param)` slots for parameters some (not all) overloads have
  mandatorily, then `&key (param default supplied-param)` slots for anything past that —
  and whose body is a `cond` that inspects each `supplied-param` flag plus each supplied
  argument's runtime type (`numberp`/`stringp`/`typep ... 'boolean`/`dotnet:object-type`)
  to pick and invoke the exact matching C# overload. No overload match falls through to a
  `cl:error` signaling `csharp-assembly-utils:csharp-overload-not-found`. Example (a
  reserved-word parameter, `t`, renamed per the Parameter Naming convention above):
  ```lisp
  (cl:defun + (t-val cl:&optional (t2 cl:nil supplied-t2))
    "Master wrapper for System.TimeSpan.+ overloads. Dispatches at runtime.
  ...")
  ```
* **Static + instance overloads sharing one name** (e.g. `Vector2.Normalize()` instance
  vs. `Vector2.Normalize(Vector2)` static): generate as two independent functions, `name`
  (instance) and `name*` (static) — see Conventions above. Each is independently
  single/Master-Wrapper-dispatched as above.
* **No clean overloads (all "dirty")**: no function at all; every dirty overload's
  human-readable signature is listed in a comment instead.
* Every Master Wrapper's docstring enumerates every overload it covers — its
  human-readable signature plus that overload's own XML-doc Summary/Returns/Parameters —
  so the full set of available overloads stays documented on the one function.



## Generic Methods

**Summary:** a generic method's own type argument(s) become the wrapper's leading
parameter(s); when the same method name is overloaded across *different* generic
arities, at most one extra dispatcher function (`name<>`) resolves which arity to use by
counting the type argument(s) it's given.

* **A method with exactly one type argument** takes it as parameter `type`:
  `(cl:defun of (type value) ... (dotnet:static-generic <type-str> "Of" (cl:list type) value))`.
* **A method with more than one type argument** (e.g. `Select<TSource,TResult>`) takes
  `type-1 type-2 ... type-N`, one Lisp parameter per type argument, passed to
  `dotnet:invoke-generic`/`dotnet:static-generic` as `(cl:list type-1 type-2 ...)`.
* **The same method name overloaded across different arities** (the canonical example:
  `System.Linq.Enumerable.Aggregate`, with generic-arity-1/2/3 overloads) can't share one
  Lisp function — a lambda list can't flex between different counts of type-argument
  parameters. Instead:
  * If a non-generic overload of the name also exists, `name` handles that non-generic
    call and `name<>` dispatches the generic arities.
  * If every overload of the name is generic (just at different arities, as with
    `Aggregate`), `name` itself becomes the dispatcher (no `<>` needed — there's no
    non-generic form to disambiguate against).
  * The dispatcher's first parameter, `types`, accepts either a single .NET type (arity 1)
    or a `cl:list` of types (arity = its length), told apart via `cl:listp` (a type
    argument is itself never a Lisp list). It applies the rest of its arguments straight
    through to an internal, **unexported** per-arity function (still named
    `name-arity-N` internally, unchanged since Version 27 — only its export status
    changed in Version 28):
    ```lisp
    (cl:defun aggregate (types cl:&rest args)
      (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
        (cl:case (cl:length type-list)
          (1 (cl:apply (cl:function aggregate-arity-1) (cl:append type-list args)))
          (2 (cl:apply (cl:function aggregate-arity-2) (cl:append type-list args)))
          (3 (cl:apply (cl:function aggregate-arity-3) (cl:append type-list args)))
          (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found ...)))))
    ```
  * When `name` also has a non-generic form, passing an empty type list (or `nil`) to
    `name<>` falls straight through to plain `name` instead of erroring.

See `doc/generator-design-notes.md`'s Version 27/28 sections for the full history of this
feature (arity-1-only → any arity → the current two-tier dispatch).



## Type Kind (class / struct / interface / enum / delegate)

**Summary:** every kind is generated through the exact same code path; `:kind` only
affects two things — struct constructor injection (above), and whether a `the`-typed
receiver is treated as a value type for the boxing-mutation warning comment.

* **Classes and interfaces** are generated identically — an interface's own members
  (typically abstract, no CIL body) reflect and generate wrappers the same way a class's
  do; calling one only makes sense against an actual implementing instance at runtime.
* **Enums** need no special generation code at all: their members are ordinary static
  literal fields (see "Static Constants and Symbol Macros" above), and their kind
  (`:enum`) only marks them as a value type for the boxing-mutation comment.
* **Structs** additionally get an injected parameterless constructor when needed (see
  "Constructors") and are marked as a value type for the boxing-mutation comment.
* **Delegates** are generated like any other class — a delegate type's public members
  (`Invoke`, `BeginInvoke`, `EndInvoke`, etc.) generate ordinary method wrappers; nothing
  currently treats a delegate as a first-class Lisp function value.



## Nested and Generic Types

**Summary:** a nested type's `+`-separated name and an open generic type's backtick
arity suffix are both flattened to `-` only in the generated package/file name — the
type's own reflection-facing identity (`<type-str>`, CLOS registration, etc.) is left
completely untouched.

```
Microsoft.Xna.Framework.Graphics.SpriteFont+Glyph -> microsoft-xna-framework-graphics-sprite-font-glyph

System.Collections.Generic.Dictionary`2 ->
system-collections-generic-dictionary-2
```

A generic type's *own* type parameters (e.g. `List<T>`'s `T`) are a different matter from
a generic *method's* type parameters (above) — see Unsupported Features: a member whose
signature mentions the enclosing type's own open type parameter is silently excluded, not
generated at all.



## Documentation

**Summary:** XML doc comments (`<summary>`, `<returns>`, `<param>`) become the generated
function's Lisp docstring (or, for constants/symbol-macros, a `(cl:documentation ...)`
`setf` form), when present in the assembly's sidecar `.xml` file.



# Unsupported Features

## C# Features

* **Static settable properties/fields.** Any static property that is writeable (whether
  read-write or write-only) generates *nothing* — no getter, no setter, no comment. The
  same is true of a plain mutable static field (not `readonly`, not `const`). This is a
  genuine silent gap, not merely an unimplemented-but-documented case (unlike the dirty
  overload comment below) — it mirrors the bug public instance fields had before
  Version 27, just not yet fixed for the static case.

* **A generic type's own type parameters.** A member whose parameter or return type
  mentions the *declaring* generic type's own unresolved type parameter (e.g.
  `List<T>.Add(T item)`, as opposed to a generic *method's* own type parameter, which
  *is* supported — see "Generic Methods" above) is silently excluded from the method
  list entirely, with no comment. Only members whose signature doesn't reference the
  enclosing type's open parameters are considered at all.

* **Overloaded indexers.** A C# indexer overloaded across distinct index-parameter
  signatures (e.g. `this[int]` alongside `this[string]`) generates no function — every
  signature is documented in a comment, since picking which one a single generated
  function should dispatch to isn't well-defined without a full type-based `cond`
  dispatch (the same treatment overloaded methods get, but not yet extended to
  indexers).

* **Dirty method/constructor/indexer overloads** — any overload using `ref`, `out`,
  `ref readonly`/`in`, `params`, or a default parameter value — is not generated; its
  signature is documented in a comment. (Explicitly planned future work per `PLAN.md`:
  a `-ref` suffix naming convention with `out` → multiple Lisp return values.)

* **Events** are not reflected at all — no `:events` key exists in the metadata schema,
  and `AssemblyToLispy.cs` never calls `Type.GetEvents()`.
  * The `AddHandler`/`RemoveHandler`/backing-delegate-field accessor methods of an event
    are typically compiler-generated and filtered out at the reflection stage anyway
    (see `doc/assembly-to-lispy.md`'s `CompilerGeneratedAttribute` filtering).

* **Generic constraints** (`where T : ...`) are not reflected — no `:generic-constraints`
  key exists yet (tracked as Phase 4 future work in `doc/assembly-to-lispy.md`).

* **Custom attributes** (`[Obsolete]`, `[Serializable]`'s value, custom attributes, etc.)
  are not reflected as data — no `:attributes` key exists yet, beyond the handful of
  type-level boolean `:flags` already captured (`:abstract`, `:sealed`, `:serializable`,
  etc.).

* **Extension methods** are flagged in the metadata (`:extension-method`,
  `:extension-this`) but the generator does not yet do anything special with that
  information — an extension method still generates as an ordinary static method on its
  declaring (usually `static`) class, with the extended type as an ordinary leading
  parameter, not as a method callable on the extended type's own receiver.

* **Operator overload rough edges.** Conversion operators (`op_Implicit`/`op_Explicit`,
  mapped to `implicit-cast`/`explicit-cast`) and some multi-branch operator dispatch
  (e.g. `Enumerable.Average()`'s generated `cond` has many branches that are all
  identical because the dispatcher only ever distinguishes ".NET object vs. not") are
  known-rough areas flagged as ongoing work in `PLAN.md`'s Miscellaneous section, not
  fully polished yet.

* **Explicit interface implementations** (a method implementing `IFoo.Bar()` while also
  exposing a different `Bar()` publicly) are not specifically detected or disambiguated
  from an ordinary method of the same clean name.

* **Static abstract/virtual interface members** (C# 11 "generic math" feature) are
  reflected like any other member, but invoking a wrapper for one only makes sense
  through a concrete implementing type — there is no special dispatch support for
  resolving the implementation from an interface-typed reference.

## CIL Features (not necessarily surfaced by C#)

* **Non-public members.** Only `public` and `protected` members are ever reflected —
  `private`/`internal`/`private protected` members are invisible to this tool by design,
  at the `AssemblyToLispy.cs` reflection stage, not the generator.

* **Pointers and unsafe code** (`void*`, function pointers, `stackalloc`, etc.) have no
  interop story here — no pointer-typed parameter/return value gets any special dotnet
  interop treatment; a member using one would need to be excluded or would generate
  broken code.

* **Ref returns** (`ref T Method()`) are not specially detected or represented in the
  metadata — no `:ref-return` flag exists, unlike `ref`/`out`/`in` *parameters*, which are
  captured.

* **Multi-dimensional and jagged array nuances** beyond simple parameter/return typing
  are not specially modeled — an array-typed member is reflected and generated the same
  as any other type, relying entirely on DotCL's own generic `dotnet:invoke` machinery to
  handle the actual array object at runtime.

* **By-ref locals, `stackalloc`, and other IL-only value-lifetime constructs** are
  compiler-internal and never surface through .NET reflection metadata to begin with, so
  there is nothing for this tool to translate.

