# DotCL Package Generator Plans

* Author: Douglas P. Fields, Jr. - symbolics@lisp.engineer
* Copyright 2026 Douglas P. Fields, Jr.


# Miscellaneous

* Make a `FILES.md`
* Make `Makefile` introspect the `.asd` for the version number.
* Make a new DotCL application with its own .csproj and .asd
  that uses generated packages and runs LOTS of tests (such as the
  ones recently removed for TimeStamp) with all those generated packages,
  testing every possible method with every possible set of parameters.
  * This can be run with make test-packages and should be run after make-test passes.
* Add a `make test-packages` that creates packages in a cspackage-test
  and then creates several packages from several standard assemblies
* Make a utilities template and copy it to the generated directory
* Do multiple assemblies and classes at the same time
* Generate a packages.lisp as well
* Set up an `AGENTS.md`
  * Tell the agent never to assume that the files have not changed.
* Set up `RELEASES.md`

* Have it generate a whole ASDF system, with its own `.asd` file,
  its own `packages.lisp`, its shared code (e.g., `csharp-assembly-utils.lisp`)
  and of course all the actual packages.
  * Only if it is then possible for the main `.asd` file to reference
    that `.asd` file easily.

* Have the package generator do two more things:
  * Generate a packages.lisp file with all the package information separate from the
    generated packages.
  * Generate a `utils.lisp` in its own namespace which can be used by all the
    other packages (in the target directory).
    * This could contain any helper methods that would have been elsewhere.
    * This could be stored in a `cspackages-utils.lisp-template` (so it doesn't
      get compiled by accident).
    * This should have its own version number.

* Improve C# class package generator:
  * **DONE** Version 10: Added method overload support with clean/dirty classification,
    type-suffixed naming, passthrough &rest dispatch, value-type typed-call optimization,
    and dirty overload documentation.
  * Handle dirty overloads (ref/out) with -ref suffix naming and
    out→multiple-values mapping in a future version.
  * **DONE** Version 11: Make constructors work in the package generator code, using the name `new` with support for overload resolution (passthrough + type-suffixed functions) and struct parameterless constructor injection.
  * **DONE** Change `/=` to `not=` in the Lispy style
  * Consider casting mutator parameters to the correct type, e.g.,
    `(#!!System.Convert.ToByte 37)`, or `(dotnet:box 37 "System.Byte")`
    in the mutator function implementation
  * Add documentation comments that indicate the return type and
    expected input type(s) of any parameters.
  * Change IsSomething methods to `something?` methods
  * Change `ToSomething` methods to `->something`
  * Handle multiple classes at a time for a single assembly
  * **DONE** Register classes/types with DotCL's CLOS dispatch system
  * Add the assembly version (and other versions?) from which the class package was made
  * Change `GetSomething` methods to ???
  * Make operator overloads take N parameters - assuming they are all the same type
    * This needs more consideration

* Make the `AssemblyToLispy` tests less fragile
  * I upgraded from 10.0.8 to 10.0.9 DotNet and the tests broke.
  * Remove hardcoded paths and find the assemblies in some automated fashion?


* Implement a system to convert a CLOS class to a CLR/C# class somehow,
  or really, create a C# proxy for the CLOS class.
  (I'm still noodling ways to do that.)
  * Make it as generic as possible.
  * Maybe a base CLOS class that implements functionality to create that
    proxy on the fly, and has a reference to the proxy for reuse.


# Single Pass Generator

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

* Copy documentation from dotcl-dungeonslime
* Add a --version and --help command line options
* Lisp paren checker
* Add Apache 2.0 License
* Change version to 1.18.0
