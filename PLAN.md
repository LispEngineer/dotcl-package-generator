# DotCL Package Generator Plans

* Author: Douglas P. Fields, Jr. - symbolics@lisp.engineer
* Copyright 2026 Douglas P. Fields, Jr.



# Add More to Generated `.lisp` Files

TODO
* Add Constant Properties as structured `<constant-properties>`
  * A Lisp list of all the selected properties (strings); 
    could also just be `"*"` as a single entry.
* Add the Assembly as `<assembly>`
* Add the Assembly to the per-package comment in `packages.lisp`


# Miscellaneous

* **HIGH PRIORITY**: Provide a safe way to **clone/copy a boxed struct instance** (e.g.
  one obtained from a `--constant-properties` constant, a `define-symbol-macro` constant,
  or an ordinary property/method return) so users can get an independent, freely-mutable
  copy without corrupting shared state.
  * Motivation: a struct obtained from Lisp is a `#<DOTNET ...>` reference to a boxed CLR
    object, not a value-copied Lisp datum. `dotnet:invoke`'s `setf`-expansion mutates
    that exact boxed object in place. For a `--constant-properties`-cached `defconstant`
    (whose value form runs exactly once and is reused forever), this means mutating the
    "constant" through *any* alias corrupts it permanently, program-wide — confirmed via
    a live REPL session where mutating a `color:r`-aliased local (`x`, bound via
    `(defparameter x color:+white+)`) also permanently mutated `color:+white+` itself.
    See `doc/generator-design-notes.md`'s Version 29 section and `FEATURES.md`'s "Static
    Constants and Symbol Macros" / "Struct Boxing Caveat" sections for the full incident
    writeup — this item is that investigation's tracked follow-up fix, not yet
    implemented (Version 29 was documentation-only, by explicit decision, to avoid the
    performance cost of abandoning `defconstant` caching for hot constants like
    `Vector2.Zero`).
  * No clone/copy-struct primitive is currently documented in
    `doc/dotnet-dotcl-interop.md`. Two possible directions:
    1. A new DotCL-side primitive (e.g. unbox-then-rebox a value type, or a generic
       `MemberwiseClone`-style call DotCL exposes to Lisp) — would need to originate in
       DotCL itself, a separate project.
    2. A generator-emitted per-type helper built from the struct's own
       constructor/settable-property-and-field values (e.g. a generated `clone-vector2`
       that reads every settable property/field off the source instance and passes them
       to `new`) — implementable entirely in this repo, though it needs to handle
       structs whose full state isn't reconstructible via a public constructor plus
       public settable members.

* Implement read/write for static properties and fields per this:
  * any static property or field that is
    *writeable* (settable) generates nothing at all, regardless of whether it's also
    readable.
  * **Not handled — see Unsupported Features:** a plain mutable *static* field (not
    `readonly`, not `const`) generates nothing at all.

* Handle overloaded indexers, per:
  * C# indexer (`this[...]`) threads its index parameter(s) through
    positionally, unless the indexer itself is overloaded, in which case it is unsupported.
  * An **overloaded indexer** (distinct index-parameter signatures on the same name, e.g.
    `this[int]` alongside `this[string]`) is not yet supported — no function is generated;
    every signature is instead listed in a comment (see Unsupported Features).

* Handle all the remaining ("dirty") overload cases.

* See if there is some way to programmatically figure out the `--constant-properties`
  but I really think it requires looking at the source code (or disassembly).

* Check the generated code for `System.Linq.Enumerable.Average()`. It has
  a cond with a ton of branches that are *literally all identical* because
  the system only checks if it's a dotnet object. This can be
  simplified or improved.

* Handle generic classes name mangling using backticks more elegantly.
  * Backticks have special meaning in Lisp so we cannot include them in the
    package names, for example.
  * The ugly workaround in v20 would make it hard for users, who are not
    typically aware of the generic arity of the classes they use and might
    not easily guess the package name.

* Make a `FILES.md`
* Make `Makefile` introspect the `.asd` for the version number.
* Make a new DotCL application with its own .csproj and .asd
  that uses generated packages and runs LOTS of tests (such as the
  ones recently removed for TimeStamp) with all those generated packages,
  testing every possible method with every possible set of parameters.
  * This can be run with make test-packages and should be run after make-test passes.
* Make a utilities template and copy it to the generated directory
* Do multiple assemblies and classes at the same time
* Generate a packages.lisp as well

* Improve C# class package generator:
  * Handle dirty overloads (ref/out) with -ref suffix naming and
    out→multiple-values mapping in a future version.
  * Consider casting mutator parameters to the correct type, e.g.,
    `(#!!System.Convert.ToByte 37)`, or `(dotnet:box 37 "System.Byte")`
    in the mutator function implementation
    * **RESOLVED/MOOT (2026-07-04)**: a live REPL check showed a plain `(dotnet:box 37
      "System.Byte")` value already mutates a struct property correctly with no special
      casting needed — `dotnet:box`, a real invoked conversion call, and a `the`-typed
      literal all behaved identically. No casting is required for correctness here. See
      `doc/generator-design-notes.md`'s Version 29 section. (The struct-mutation
      *aliasing* hazard this same investigation uncovered is a separate, unrelated issue
      — tracked as this section's new struct-cloning TODO item above.)
  * Add documentation comments that indicate the return type and
    expected input type(s) of any parameters.
  * Change IsSomething methods to `something?` methods
  * Change `ToSomething` methods to `->something`
  * Handle multiple classes at a time for a single assembly
  * Add the assembly version (and other versions?) from which the class package was made
  * Change `GetSomething` methods to ???
  * Make operator overloads take N parameters - assuming they are all the same type
    * This needs more consideration

* Make the `AssemblyToLispy` tests less fragile
  * I upgraded from DotNet 10.0.8 to 10.0.9 and the tests broke.
  * Remove hardcoded paths and find the assemblies in some automated fashion?

* Implement a system to convert a CLOS class to a CLR/C# class somehow,
  or really, create a C# proxy for the CLOS class.
  (I'm still noodling ways to do that.)
  * Make it as generic as possible.
  * Maybe a base CLOS class that implements functionality to create that
    proxy on the fly, and has a reference to the proxy for reuse.


---

# **DONE** Multi-Type Arity Improvements

* Reconsider the multi-arity overloads with suffix `arity-#` naming
  convention. Maybe have a suffix like `<>` which indicates that it
  takes a type parameter. Example: `aggregate<>` or `aggregate<2>`?

* Take type arguments in two forms:
  * A single type
  * A list of types (or other sequence)
  * This would allow the multi-arity overloads to use a single type specified
    version, e.g., just `aggregate<>` for all possible arities.

## Implementation Notes

**DONE** in generator version 28 (2.28.0). Replaced the `-arity-N` suffix scheme with a two-tier
dispatch mirroring the Version 24 Overload Consolidation's `*` static/instance convention, so a
method-name group's public surface stays at most two names. `generic-arity-dispatch-mode`
classifies a method name's generic-arity cells as `:single` (the common case -- generates bare
`base-name`, unchanged), `:split-with-plain` (a non-generic overload coexists with generic ones --
generates `base-name` plus a `base-name<>` dispatcher), or `:split-all-generic` (every overload is
generic but at different arities, e.g. `Enumerable.Aggregate`'s arity-1/2/3 overloads -- `base-name`
itself becomes the dispatcher, no `<>` needed). The dispatcher takes the type argument(s) as its
first parameter -- a single type, or a `cl:list` of types (arity = its length), distinguished via
`cl:listp` -- and applies the rest of its arguments through to an internal, unexported per-arity
function (the old `-arity-N` bodies, reused verbatim). In the `:split-with-plain` case, an empty
type list/`nil` falls through to the plain `base-name` function instead of erroring. See
`doc/generator-design-notes.md`'s "Generic-Arity Two-Tier Dispatch (Version 28)" section and
`RELEASES.md`'s `2.28.0` entry.


# **DONE** Overload Consolidation

Consolidate all method overloads into at most two functions:
* One for a class instance method
* One for a static method
* If there are no overloads that are both instance and static, just
  emit one function. If there are both, emit a second function with
  a `*` suffix for the static version.
* This would reduce the potentially long list of functions like these:
  ```
  #:get-ambiguous-time-offsets
  #:get-ambiguous-time-offsets-date-time-offset
  #:get-ambiguous-time-offsets-date-time
  ```
  whose naming is actually pretty ugly too.

Obviously, this requires updating the version number.

## Implementation Notes

**DONE** in generator version 24 (2.24.0). Type-suffixed per-overload direct-call functions
(for both methods and constructors) are no longer generated or exported; each overloaded
method/constructor now emits only its Master Wrapper (`name`, plus `name*` when a name is
overloaded as both instance and static). Constructors, which previously had no Master Wrapper
at all (just a bare `&rest` passthrough), gained one too. See `doc/generator-design-notes.md`'s
"Overload Consolidation (Version 24)" section and `RELEASES.md`'s `2.24.0` entry.

Extending the Master Wrapper to constructors surfaced a latent bug (see the Miscellaneous
section below for the follow-up item) in how positional dispatch-slot parameter names are
picked when overloads have unrelated arities; `uniquify-positional-params` was added to fix it
for the specific case of two different slots coincidentally choosing the same parameter name.


# **DONE** Make `csharp-assembly-utils.lisp` and Package

The generated packages have a number of dependencies on other code.
Currently this is not handled by the package generator.
However, this needs to change, such that the generated packages are
entirely self contained and can be used in any project.
Toward that end, I want to extract all the utility functions into their
own Lisp package and file that is included in the generated directory,
and have the generated packages/files use that utility package
(in a fully qualified, non-nicknamed manner so as to avoid shadowing issues).

See [`doc/package-generator-dependencies.md`](docs/package-generator-dependencies.md)
for previously identified dependencies. Do not assume this file is up to date and
confirm said dependencies are full and complete.

Key Design Decisions:
* Utility package name: `csharp-assembly-utils`
* Utility package filename: `csharp-assembly-utils.lisp`

Considerations:
* Add the `:depends-on` for this package utility to the other `:file`s in the generated `.asd`.
* Should we `(require "asdf")` in the utility package `.lisp` file? If so, should it be
  included in an `eval-when` block? This is because some UIOP functions may be used.

## Open Questions

Since these utility functions are static, how should we handle them?
* Option 1: Template files `template-csharp-assembly-utils.lisp` and `template-csau-packages.lisp`
  plus system-generated headers (the standard 3 line comment we've been generated)?
* Option 2: Have the code directly generate the files? Seems sort of ugly and harder
  to test/verify, since the utility code is static.

If we also use these functions in the package generator's code, then we could
include the templates in our `.asd` and use them directly. This would mean the
code is also known-good.

How do we include the template files (if chosen) in the deployed application?
* Consider the `.asd` `:static-file` option to include the templates in the build
  so the deployed package generator can access them. Not sure how that would work
  in DotCL though.

## Old Misc

* **DONE** Have the package generator do two more things:
  * Generate a packages.lisp file with all the package information separate from the
    generated packages.
  * Generate a `utils.lisp` in its own namespace which can be used by all the
    other packages (in the target directory).
    * This could contain any helper methods that would have been elsewhere.
    * This could be stored in a `cspackages-utils.lisp-template` (so it doesn't
      get compiled by accident).
    * This should have its own version number.


# **DONE** Make `packages.lisp`

Currently, each generated `.lisp` file has a `cl:defpackage` at the top.
A common convention is to define all packages in a single location,
the `packages.lisp` file. Let's make the generator work that way as well.

At the top of the generated `packages.lisp` the same comments should be
included as in the other generated `.lisp` files.

As each class is generated, append to the `packages.lisp` file the
appropriate `cl:defpackage` section. Preceed the `defpackage` with
comments indicating:
* The source file this package corresponds to
* The C# class (in C# format) this package corresponds to
* The Constant Properties defined for this package.

Leave a line of whitespace between each package definition.

Do not generate the `defpackage` in the package's `.lisp` file anymore.


# **DONE** Make ASDF System

**DONE** in 2.21.0. `:depends-on` was intentionally left out of the generated system for
now (further plans for it will come in a later change) — everything else below was
implemented as specified.

To make it easier to load all the generated packages, the package system
will create an ASDF system defintion file, an `.asd` file. The system will
reference each generated file as a component, and have general metadata.

The metadata to set are:
* `:author`: Set this to "DotCL C# Assembly Package Generator"
* `:version`: Set this to the assembly version (e.g., 21), as a string
* `:homepage`: This should be the GitHub repository for the package generator,
  which currently is https://github.com/LispEngineer/dotcl-package-generator .
* `:description`: Set this to the fixed, one-line text
  "Lisp packages enabling ease-of-interoperation with selected C# classes
   and objects."
* `:long-description`: Set this to a multi-line, indented detailed explanation of
  the generator version and the packages included.
  * Generator information: Exact version of the generator used (e.g., 2.21.3),
    and the generation date and time.
  * Details of packages included:
    * Top level of indentation: The assembly (without pathname) from which it drew
      the classes.
    * First indent: The fully-qualified C# style class name & it's assigned package name
    * Second indent: (if not blank) the Constant Properties defined for the class

The components (`:components`) to include are:
* `:file` for each generated `.lisp` package file
  * There are no cross-dependencies so order does not matter.
    Just use the same order as the command line arguments for simplicity.

The name of the generated `.asd` file should be `csharp-assembly-packages.asd`.


# **DONE** Single Pass Generator

Modify the program such that it generates all the files in a single execution.
The execution could look like this, but all on a single command line:
(separated here for ease of understanding)

```
dotcl-packagegen
--out-dir some/directory
--assembly path/to/Some.Assembly.dll
--class Some.Class1 --constant-properties "*"
--class Some.Class2
--class Some.Class3
--assembly path/to/Some.Other.Assembly.dll
--class Some.Other.Class4 --constant-properties ""
--class Some.Other.Class5 --constant-properties "*"
```

This will then generate the metadata for the assemblies,
named as `Some.Assembly.metadata`, and then immediately
generate the class packages `some-class1.lisp` and so forth,
all in the `some/directory` as specified.

All `--classes` are referencing the most recent `--assembly`.
The `--constant-properties` references the most recent `--class`.

## Thoughts on Implementation

In C#:

* Record the invocation timestamp for use in the
  output files.

* Create a list of everything to do, a 3-tuple:
  * Assembly
  * Class
  * Constant Properties

* Find all the assemblies, give an error if any can't be found.

* Load all the assemblies, and give an error if any class mentioned
  cannot be found in the loaded assemblies.
  * (What about the `.xml` files adjacent to the assemblies?)

* Generate all the assembly metadata files.

In Lisp:

* Pass the list of 3-tuples, enhanced with the location of the
  generated metadata files, to Lisp from C#.

* Load all the metadata files. Stop if there are any errors
  upon attempting to load them.

* Generate each package. Use the same timestamp for all generated
  files, as recorded above.

Throughout:

* Output messages indicating to the user what is going on.
  * Any error messages should be output in red color.

## Next Steps

Once there is a single-pass generator in place, the generator
can be extended to do more interesting things mentioned above,
such as creating a unified ASDF system `.asd` file, creating a
unified `packages.lisp` file, adding shared utilities. So this
is a really foundational change that will help a lot in the future.


# DONE

* Add missing operator overload handling.
  * DONE (2026-07-04): `AssemblyToLispy.cs`'s `GetCleanMethodName` now maps the 8 remaining
    standard operators (`%`,`&`,`|`,`^`,`<<`,`>>`,`>>>`,`~`) plus C# 11's checked-operator
    variants (suffixed `!`). Existing operator codegen (Master Wrapper dispatch, unary/binary
    arity disambiguation, `:mangled-name`-based invocation) already handled any mapped operator
    correctly and needed no changes — see `doc/generator-design-notes.md`'s Version 30 section.
    Generator version bumped 29 → 30; CLI `VERSION` bumped 2.29.1 → 2.30.0.

* Public instance fields (e.g. a plain mutable field on a simple data-holder class or struct)
  generated nothing at all — no getter, no setter, no comment. `public-instance-field-p` existed
  but was never called anywhere.
  * DONE (Generator Version 27): public instance fields now generate a getter always, and (unless
    the field is C#'s `readonly`, reflected as `:init-only`) a setter. Since a field has no
    `get_Foo`/`set_Foo` accessor method the way a property does, the getter uses `dotnet:invoke`'s
    built-in field-read support directly, and the setter uses the `setf`-expansion of
    `dotnet:invoke` itself (the idiomatic way to write a field/property/indexer directly per
    `doc/dotnet-dotcl-interop.md`), since `dotnet:invoke` has no field-write equivalent. See
    `doc/generator-design-notes.md`'s "Public Instance Fields and Multi-Type-Argument Generic
    Methods (Version 27)" section and `RELEASES.md`'s 2.27.0 entry.

* Generic methods with more than one of their own type argument (e.g. LINQ's
  `Select<TSource,TResult>`, `Join`, `ToDictionary<TSource,TKey,TResult>`) were excluded entirely —
  the generator only supported exactly one type argument (Generator Version 12).
  * DONE (Generator Version 27): any positive generic arity is now supported
    (`generic-method-arity-supported-p`), generalizing the previous single hardcoded `type`
    parameter to `type-1`..`type-N` (`generic-type-param-names`; arity 1 keeps the legacy bare
    `type` name, so existing arity-1 generated code and callers are unaffected). Handled as a
    special case: the same C# method name overloaded across *different* generic arities (e.g.
    `System.Linq.Enumerable.Aggregate`'s arity-1/2/3 overloads) can't share one Lisp function's
    lambda list, so each arity now gets its own arity-suffixed function (`aggregate-arity-1`,
    `aggregate-arity-2`, ...) instead of being incorrectly merged
    (`split-by-generic-arity`/`generate-method-name-wrappers`). See
    `doc/generator-design-notes.md`'s "Public Instance Fields and Multi-Type-Argument Generic
    Methods (Version 27)" section and `RELEASES.md`'s 2.27.0 entry.

* Indexers (C#'s `this[...]`, e.g. `Dictionary<TKey,TValue>`'s `Item`) generated a getter/setter
  taking only the receiver `obj!`, with no index/key argument at all — `AssemblyToLispy.cs` never
  captured a property's own index parameters, so the generated wrapper could compile and export
  but could never actually retrieve or store a value at runtime.
  * DONE (Generator Version 26): `FormatPropertyPlist` now captures index parameters via
    `PropertyInfo.GetIndexParameters()` under a `:parameters` key, formatted identically to a
    method's own parameters. The generator threads them through to `get_Item`/`set_Item`
    positionally (index parameter(s) first, then the new value on the setter). An indexer
    overloaded across multiple index-parameter signatures is documented in a comment rather than
    guessed at, the same treatment dirty method/constructor overloads already get. See
    `doc/generator-design-notes.md`'s "Indexer Support (Version 26)" section and `RELEASES.md`'s
    2.26.0 entry.

* Copy the `revert-cspackages-timestamps.sh` from DungeonSlime to here,
  and use it in the `cspackages-test` directory for the `make test` target.
  * Extended it to the other date in `.asd` file too.

* `generate-single-overload`/`generate-master-wrapper` hardcode the receiver parameter 
  name as literal `obj`, which collides when a C# method's own parameter is also named obj, e.g. 
  `System.Object.Equals(object obj)` generates `(cl:defun equals (obj obj) ...)`, 
  an invalid lambda list.
  * Suggestion: change the name of `obj` to something that C# cannot generate, such as
    `obj*` `obj!` `<obj>`, etc.
  * DONE (Generator Version 25): renamed the hardcoded receiver to `obj!` everywhere it's
    emitted (methods, master wrappers, instance property getters/setters). `map-param-name`
    never appends a trailing `!` to a mapped C# parameter name, so `obj!` can never collide.
    See `doc/generator-design-notes.md`'s "Receiver Parameter Renamed to `obj!` (Version 25)"
    section and `RELEASES.md`'s 2.25.0 entry.

* Have it generate a whole ASDF system, with its own `.asd` file,
  its own `packages.lisp`, its shared code (e.g., `csharp-assembly-utils.lisp`)
  and of course all the actual packages.
  * Only if it is then possible for the main `.asd` file to reference
    that `.asd` file easily.

* Add a `make test-packages` that creates packages in a cspackage-test
  and then creates several packages from several standard assemblies

* Set up an `AGENTS.md`
  * Tell the agent never to assume that the files have not changed.
* Set up `RELEASES.md`

* Copy documentation from dotcl-dungeonslime
* Add a --version and --help command line options
* Lisp paren checker
* Add Apache 2.0 License
* Change version to 1.18.0

## Older DONE

* **DONE** Version 10: Added method overload support with clean/dirty classification,
  type-suffixed naming, passthrough &rest dispatch, value-type typed-call optimization,
  and dirty overload documentation.
* **DONE** Version 11: Make constructors work in the package generator code, using the name `new` with support for overload resolution (passthrough + type-suffixed functions) and struct parameterless constructor injection.
* **DONE** Change `/=` to `not=` in the Lispy style
* **DONE** Register classes/types with DotCL's CLOS dispatch system

