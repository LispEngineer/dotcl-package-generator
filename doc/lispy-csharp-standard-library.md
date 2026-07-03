# Creating a Lispy C# Standard Library

* Author: Douglas P. Fields, Jr. - symbolics@lisp.engineer
* Last updated: 2026-06-06

DotCL projects will likely do a lot of things using C# Standard Library classes,
methods, etc. Each one will be hard to type check and verify because they are
just strings for classes, methods, properties, events, etc.

I propose building something that parses the C# standard library and outputs
very lispy function libraries of the C# standard library. This can then be
extended to any other C# library to provide a lispy interface.

Names can be converted from CamelCase to snake-case automatically, although
I would have an override list of names. Conventions can be converted, e.g.,
boolean returning functions named `Is` could be changed to have a `-p` or `?`
suffix. (The latter is my preferred, but that is probably because of recent
usage of Clojure.) Things like "to" or "from" methods, type conversions,
could use things like `->` and `<-`.

## References

* [assembly-to-lispy.md](assembly-to-lispy.md): Documents the mechanism by which
  C# Assembly information is turned into a Lispy s-expression format for processing
  by Common Lisp code.
  * `AssemblyToLispy.cs` implements this specification.

* [lisp-assemblies.md](lisp-assemblies.md): Documents how the above metadata is
  used to generate Lisp packages for these assemblies.


# Implementation Options

There are several possible ways to do this:

## Option 1: Package per Class

Make a package for each class.
* Example: `System.Timespan` or `csharp/System.Timespan`
* Each method can have one function that checks its arguments and
  calls the proper overloaded method with the correct number of arguments.
* Package local nicknames can be used for easy of development
  * Example: `ts` for `csharp/System.Timespan`

Pros:
* Easiest to implement
* Easiest to use (probably?)
* Each package is very clean


Cons:
* Tons and tons of packages
* Large number of symbols/code, most of which won't be useful
  for any given project
* Large `.fasls`
* Lots of memory usage for all the symbols, etc. 

### Option 1A (and 2A): Macro Package

Have another package of the same exact (function)
symbols but make them macros instead, to shave a tiny
bit of efficiency, for things that just turn into
simple `dotnet:invoke` (etc.) type calls.

Load this package, which will transitively load
the original package as well (not exporting its
conflicting symbols).

Use the original function package so I'll get
nice stack traces for debugging. (Not that DotCL
does that yet, but you get what I'm saying.)

## Option 2: Package per Namespace - Class Name Prefixes

Abbreviate the class names (e.g., `TimeStamp` becomes `ts-`) and
prefix each function with this abbreviation. Then, I need only
one package for each part of the C# namespace.

Thoughts:
* There may be some disambiguation necessary

Pros:
* Fewer packages

Cons:
* More verbose due to the class name (or abbreviation) prefixes
* Possible abbreviation collisions (requiring disambiguition)

### Option 2A: See Above for 1A

## Option 3: CLOS integration

Once C# classes are integrated into the CLOS type hiearachy,
I can define C# generic methods for all methods, and specialize
them for each set of parameters. This way, there would be one
(DotCL C# library) package with all the overloaded generics
and each C# class that is specialized in

Refer to [abcl-java-interop](abcl-java-interop.md) for a discussion
of how ABCL integrated Java classes into its CLOS & MOP.

Consider extending the operators from CL-Generics for operator
overloads in the C# standard library.

Pros:

Cons:

## Option 4: On-Demand Package Creation

If I pre-generate the entire C# standard library stubs (or other large
library, e.g., MonoGame), this will make an enormous number of
Lisp files, a huge number of packages and a ton of symbols.
This will in turn slow down compilation, loading, execution,
create large `.fasl` files, and use lots of memory unecessarily.

Once I can automate the creation of the Lisp source (e.g., in Options
1 or 2 above), I could turn this into a compile-time event instead.
* Macro: `(csharp:with-types "System.IO" ...)`
* Reader macro: `#cs(System.IO)`
Have the compiler then generate all the material for the requested
class, package, namespace, whatever, and make it available only
after that.

This could possibly be made into an ASDF extension.

Thoughts:
* How to handle things that span assemblies (like extensions or partial classes)?
* How to identify everything relevant at runtime? (Dynamically load
  all possible assemblies?)
* How to handle the same thing attempted to be loaded multiple times?
  (Like in different source files or even when called from DotCL Lisp
  libraries being used either from ASDF or NuGet?)

## Option 5: `.csproj` Build Time Package Creation

As Option 4 above, but have a stage in the `dotnet build` cycle
which generates the stubs for the desired set of C# classes.
After all, this stage will also know all about everything else
the project needs (i.e., all the Assemblies), so it could
also call the Lispy-C#-package-builder to generate the `.lisp`
source files, `.asd` ASDF system definitions, or whatever else,
on the fly. It could also cache this (by storing the version
of the assemblies from which it generated the code) so it would
only need to do it once in a while.

Later in the project, these same files could be automatically added
to the generated output (preferably as `.fasl`), addressing one
of the headaches I've encountered. (See, for instance, the mess
I had to deal with in getting `anaphora` into this project's "binary" in a
way that could be sent to another computer.)

Thoughts:
* How does it know what classes to generate Lisp interfaces for?
  * Explicit list in `.csproj` or pointer to another file?
  * Search the `.lisp` or `.asd` files for something that compiles
    into a Lisp no-op? (`(with-c#-stubs ..)`)
* How to handle recursive needs (e.g., how to package DotCL libraries
  that use this capability and use them in other projects)?

## Option N: (Other ideas?)

TODO


# Implementation Concerns / Ideas

## Phasing

The first implementation should be very simple:
* Pick a simple C# Standard Library Class
  * Simple meaning, doesn't use a lot of C# features, maybe just
    basic fields, properties and methods
  * Doesn't use generic type system
* Implement the parser for that class (see below)
* Implement all the abbreviations, convention conversions, etc.
* Output the DotCL Common Lisp code for that simple example class

The second implementation should iterate all the classes
and indicate which are compatible with the first implementation,
and then output the packages (or whatever implementation option
is chosen) for that.

The third implementation could try another important library
(e.g., MonoGame like I'm using here) and make sure that the
capabilities can be used beyond the .Net C# standard library
initially targeted.

The fourth implementation could output packages skipping any
as yet unsupported feature, so that I could at least get some
partial value out of classes with unsupported features.

From there, each subsequent version should add capabilities until I have
implemented everything possible. :) These versions should also add
optimizations as well as supported features.

## Creating the Library

To get the raw data to convert to DotCL Common Lisp:
* Parse the source files of the C# standard library
* Parse the compiled Assembly files and PDB files
  of the C# standard library
  * Use the `.pdb` (Program Database) debugging symbols somehow?
* Use reflection to learn everything about loaded assemblies
  and classes and do the work that way?
* Parse C# documentation XML files
  * `<GenerateDocumentationFile>true</GenerateDocumentationFile>`

Thoughts:
* Handling extension methods
  * Put these in the target type's package/organization
* Handling partial classes (I shouldn't have to care?)

### Applicable Tools

C# source and assemblies:
* [`System.Reflection.MetadataLoadContext`](https://learn.microsoft.com/en-us/dotnet/standard/assembly/inspect-contents-using-metadataloadcontext)
* `System.Reflection.Metadata`
* [`Mono.Cecil`](https://www.mono-project.com/docs/tools+libraries/libraries/Mono.Cecil/)
* [`dnlib`](https://github.com/0xd4d/dnlib)
* Roslyn compiler & `Microsoft.CodeAnalysis`
* [ILSpy](https://github.com/icsharpcode/ilspy)
* [DocFX](https://dotnet.github.io/docfx/)
  * This can output detailed YAML files from an assembly
    * The format is [documented here](https://dotnet.github.io/docfx/docs/dotnet-yaml-format.html)
      (see `### YamlMime:ManagedReference` in the top line of an output file)
  * A tool like [yq](https://github.com/mikefarah/yq) can convert to JSON
  * A Lisp library like [Yamson](https://github.com/bohonghuang/yamson)
    can read YAML (and might even work in DotCL, but it relies on several
    other libraries transitively)
  * [docfx JSON](https://github.com/dotnet/docfx/blob/main/docs/reference/docfx-json-reference.md/)
    input file format

C# documentation XML files:
* [NuDoq](https://github.com/devlooped/NuDoq)
* [DocXml](https://github.com/loxsmoke/DocXml)
* [Namotion.Reflection](https://github.com/RicoSuter/Namotion.Reflection)
* Roslyn again (for source with `///` documentation)
* [MDoc](https://www.mono-project.com/docs/tools+libraries/tools/mdoc/)

C# Project files: (MSBuild projects)
* [Microsoft.Build.Locator](https://github.com/microsoft/MSBuildLocator)

### Library Files

Look around `~/.dotnet` which has way, way too many files...

Core library:
* `System.Private.CoreLib.dll` is private, OS-specific code
* `System.Runtime.dll` and `netstandard.dll` are the things I
  actually link against, which calls the above.

The Base Class Library (BCL) has many other assemblies, over 100.
Some include:
* `System.Collections.dll` and its ilk
* `System.Net.Http.dll` for `HttpClient` and other `System.Net` assemblies
* `System.Linq.dll` for LINQ (probably don't need this if I have CL!)
* `System.Console.dll`
* `System.IO.dll` and its related assemblies

### AOT

What if all I have is AOT (ahead of time) compiled assemblies?
Shoudln't worry about this for now...

## Type Library

Create a package (library) of Type constants:

* Since symbols can have any value, I can do things like: `+type-System.TimeSpan+`.
  * Come up with a nice naming convention, that sort of looks ugly, maybe
    with different earmuffs and using a package instead of `type-` in the name?
* I could have a method that gets a specialized generic type,
  or constructed type, e.g.,
  `(get-type "System.Collections.ArrayList<string>")`, but that also
  could also add `+type-System.Collections.ArrayList<string>+` to the same
  package, and dynamically look that up using it as a cache.
* Could have a `get-type` that takes all the type specifiers as arguments.
  `(get-type "System.Collections.ArrayList" "string")`.
  * If the sub-types have type specifiers, it could be handled with lists, like
    `(get-type "ArrayList" '("List "string"))`
* Can also deal with unbound types, like `List<>` or `Dictionary<,>`

## Improved Efficiency

Since these stubs will have a lot of details about the invocations,
it might be possible to compile into much more efficient calls than
using `dotnet:invoke`, `dotnet:static`, `dotnet:static-generic`, and
my own `monoutils:invoke-generic`.

## DocStrings

Output docstrings that include:
* Original C# documentation (if any/available)
* Detailed types of all parameters/overloads
* Attributes
* Version information?
* ...?

Cons:
* Would make the memory footprint much larger
* Would potentially slow down compilation

So, make this optional?

## Version Information

Include any version information from the source files or compiled
CIL files (Assembly files) in the Lisp packages. If not available to get in an
automated fashion, get it from the environment (e.g., like
`dotnet --version`) or from the user
as an input.

Have startup checks that check the loaded assembly versions against
the Lisp compiled versions and output warnings if they differ?

* `System.Runtime.InteropServices.RuntimeInformation.FrameworkDescription`
* `Environment.Version`
* `AssemblyVersion`
* `AssemblyFileVersion`
* `AssemblyInformationalVersion`

```c#
// Get the assembly that contains the base 'object' type
Assembly coreLibrary = typeof(object).Assembly;

// Extract its version
Version coreVersion = coreLibrary.GetName().Version;
Console.WriteLine($"Core Library Version: {coreVersion}");
```

## Anonymous Types

Maybe map anonymous types to Lisp plists (or alists)?

Consider mapping these back to
[`System.Dynamic.ExpandoObject`](https://learn.microsoft.com/en-us/dotnet/api/system.dynamic.expandoobject?view=net-10.0)?
Would that even be useful?

## LINQ

LINQ is not really needed while writing Lisp, but if I really want
to do something, maybe make a DSL as a macro that will output
a LINQ expression tree?
(c.f. [`System.Linq.Expressions.Expression`](https://learn.microsoft.com/en-us/dotnet/api/system.linq.expressions.expression?view=net-10.0))
After all, Common Lisp is *the* programmable language. :)

This could be used for remote data providers like EF.

```lisp
(csharp:query (db-context users)
  (where (user) (> (age user) 18))
  (select (user) (name user)))
```


# Handling C# Capabilities

## Constructors

Thoughts:
* `make-<class-name>` is a Lispy convention
* Use/allow keyword arguments instead of (or in addition to?)
  positional arguments

## Generic Types

How to handle C# generics
* Classes, interfaces with type parameters
* Structs, records with type parameters
* Methods with type parameters

## Parameters Defaults

Thoughts:
* See assembly metadata, `ParameterInfo.DefaultValue`
* Map this to `&optional` and/or `&key` parameters

## `params`

Thoughts:
* Map these to an `&rest` argument
  * Allocate a C# array of an appropriate type to hold the values
* For overloaded methods, handle/check all the other overloads first

## `out` / `ref` Parameters

### Option 1: Multiple Values

(I believe this is similar to what DotCL already does.)

Map `out` / `ref` parameters to Common Lisp multiple return values.
The primary return value is the C# method's return value,
followed by the updated `ref` and `out` arguments in declaration order.

```lisp
;; C#: bool TryGetValue(TKey key, out TValue value)
(multiple-value-bind (found-p value) (try-get-value dict key)
  (when found-p
    (format t "Found: ~A~%" value)))
```

### Option 2: Reference Container

Pass a reference container object that holds the value. Not exactly
sure what would work nicely here, but something like this?

For an `out` parameter:
```lisp
(let ((out-cell (csharp:ref-cell)))
  (try-get-value dict key out-cell)
  (value out-cell))
```

For a `ref`, specify the initial value:
(note that this is not a good example since `try-get-value` uses an `out`)
```lisp
(let ((ref-cell (csharp:ref-cell initial-input-value)))
  (try-get-value dict key ref-cell)
  (value ref-cell))
```

## `in` Parameters

## Records

Treat the same as classes? Implement special equality capabilities?

Make a Lispy version of `with`? Implement as a macro?
* C#: `var newPerson = person with { Age = 30 };`
* Lisp: `(setf new-person (with-record-update person :age 30))`

## Value Types

* Primitives
  * `native int` (signed/unsigned)
* Structs
  * `ref struct`s, e.g., `Span<T>`
* `enum`s
* Tuples (C# 7's `System.ValueTuple`, not the `System.Tuple` class)
* Nullable value types
* Unsafe C#
  * Data pointers (e.g., `T*`)
  * Function pointers (e.g., `delegate*`)

## `ref struct`, `stackalloc` and Other Stack-Allocated Things

Do something akin to Common Lisp's `dynamic-extent`, but force
allocation on the stack? How to prevent escapes?

## Enumerations

Thoughts:
* Use the integral types (integer types) in the Lisp definitions?
* How to deal with `[Flags]` specially?
  * Not really necessary, they're still integral numeric types?
* `ToString`, `Parse` and `TryParse`

## Indexers

Thoughts:
* Translated into a property called `Item` (or whatever `[IndexerName]` says)
* `get_Item`, `set_Item`
* Can be overloaded like any other C# method
* DotCL already handles these

## Fields, Properties

Fields:
* Instance fields
* Static fields
* Constant fields (`const`) - inlined, `literal`
* Read-only fields (`readonly`)
* Volatile fields - `modreq`

Properties:
* Just methods with `set_` and `get_` names and (possibly) a backing field.
* `init` - Init-only properties (uses `modreq`)
* `required` - `[RequiredMemberAttribute]`

Thoughts:
* `setf` forms for fields & properties
  * Already handled by DotCL

## Operator Overloading

When a C#-respecting defgeneric is available, this system can also use
something like [CL Generics](https://github.com/alex-gutev/generic-cl)
and add specialized methods for the C# operators. These are, after all,
just static methods with names like `op_addition`.

## Attributes

* CIL `CustomAttribute` table
* [Pseudo-attributes](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/attributes/pseudo-attributes)
* C# Roslyn [Well-known Attributes](https://github.com/dotnet/roslyn)?

Do I even care about attributes in our Lispy versions?
If so, what limited subset do I care about?
Probably at most the same ones the Roslyn compiler would care about.

## Nullability

* `Nullable<T>`
* `T?`

## Events

Events in C# often have handlers added and removed using
`+=` and `-=`. A more lispy version would be to have functions
like `add-handler` and `remove-handler`.
* `(add-handler obj 'event-name handler)`
* `(add-handler obj 'event-name (lambda ...))`

## Delegates

Thoughts:
* Handle Lisp closures when passing to C# methods?

## `async`

...and `await`.

Maybe omit doing anything about this for now, because the C#
compiler turns these "methods" into a "mess."
(My thoughts trying to figure out how to reverse engineer it 
for use in this case -
it's actually a kind of state machine.)

Leave it for a very late implementation phase.

## Superclass Methods & Default Interface Methods

Should the interface and super class methods be included in the
class's methods directly? Or should they be just `use`d in the 
package?


# Other C# Considerations

## Resource Management

Consider how to handle a Lispy version of `using` or `IDisposable` constructs.
* Make a `with-disposable` macro that calls `Dispose()` in an `unwind-protect`?

# Handling CIL Capabilities

C# is just one language on top of the Common Language Runtime (CIL).
The Common Intermediate Language (CIL) offers many other capabilities
that I might have to deal with if I parse the CIL directly.

## CIL Global Methods & Fields

Make these top-level Lisp global variables and functions in a
`cil-globals` (`csharp-globals`?) package?

## CIL Method Overloading by Return Type

These may need to be handled by having a return type parameter
specifier in the method, e.g., `&key (return-type ...)`?

## CIL Array Indexing

In CIL, arrays can be multi-dimensional and can have arbitrary lower bounds.
(Hey Matlab, I could compile your 1-indexed arrays to CIL nicely, LOL.)

## Other CIL Stuff

This stuff probably isn't relevant to us, but CIL also supports
these things that C# doesn't leverage.
* Tail Call Optimization (TCO)
* `fault` blocks (beyond `try` - `catch` - `finally`)
* Custom Modifiers (`modreq`, `modopt`)


# Other Lisp Considerations

Thoughts:
* With so many symbols/packages, how would auto-complete capabilities
  in tools like SLIME or Alive work - when/if they ever come to DotCL?
  * What about "go to defintion" capabilities?
* Many C# functions have names that exist in the `:cl` package already
  (at least when folded in to camel-case). So, be careful in using these
  packages lest the CL standard names be shadowed.

# Other Libraries

This same treatment can be done for any other C# library.

Some early possibilities:
* MonoGame (of course!)
* Godot
  * Unity, if I want to support a commerical project
* ASP.NET (DotCL Sample)
* MAUI (DotCL Sample)

If the generation could be fully automated and implemented
from compiled CIL, then creating the Lispy Stubds could become
a standard `dotnet tool` that could take any NuGet package
and output the Lispy interface packages.


# Future Directions

## Other Language Targets

DotCL targets the CLR. So, the Haskeller in me thinks I should look
at supporting F# capabilities in DotCL as well.
(Talk about scope creep!)

There's also [IronScheme](https://github.com/IronScheme/IronScheme),
which targets the CLR. It would be interesting to have a CLR-based
Scheme (R6RS) to Common Lisp interoperability...

