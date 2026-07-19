# Gemini and Antigravity Instructions

* Review `README.md` for general overview of this repository.
* Review `CLAUDE.md` for Claude Code's self-generated initialization file.


# General Instructions

* You will **never** use git to stage or commit any changes.
  You must **only** use git for read-only commands.
* Do include detailed comments with any code written,
  or changes to code made.
* Update documentation with any changes, especially these files:
  * Update the `README.md` file with documentation on new features.
  * Update `implementation-notes.md` with anything that may be a bit
    tricky to understand or reimplement/reuse later.
  * Update `FILES.md` with a brief description of any new files,
    or significant changes to the content of files.
  * Update `antigravity-log.md` with any explanation you provide me,
    and a log of any changes you make to any files. Do not edit old
    entries; treat this as an append (or insert) only file.
    * Create this file if it does not exist
* Do NOT make any changes to other packages source code unless
  explicitly directed by the user. 
  All the work for this project is to be done in this code only.
* Questions about *how* to do something should be answered with
  an explanation on how to accomplish the thing requested, without
  you making any changes to any files or executing any commands that
  could change files.
* When writing comments or documentation, do *not* use personal
  pronouns such as "we" or "I." 
  * For example, instead of saying
    "We still capture this metadata for our Lisp packaging..."
    say instead "This metadata is still captured for the Lisp packaging..."
  * It is fine to use the passive voice to avoid using personal pronouns.
* Any command that is run regularly should be built into a `Makefile`
  target.
  * Any capability provided by `Makefile` targets should be used over
    building custom commands.

## Temporary Files

* Use the `scratch/` directory to store temporary files, such as to explore
  how things work. These are not committed to Git so do not put anything
  important or durable in there!
* Any generated test/execution run log files (such as `run_out*` files or `repl_out*` files)
  in the root directory should be cleaned up / deleted before ending the session.


# Useful Commands

* Run a blank dotcl REPL: `dotcl`


# Code Style Instructions

## Testing

All new code must have tests. However:
* There is no test framework in use, so use language-native capabilities.
* Print the results of tests on error output.
* Tests should either run:
  * With a command line flag like `--test`
  * Every time the program starts

## C# Code Style

* You must keep an open brace of a block on the same line as
  what preceeds it, rather than alone on a new line, separated by
  exactly one space.
* Every block on an `if` or `else` must be surrounded by braces.
* The `else` clause in an `if` statment should have the close and
  open brace on the same line as the `else`, each separated by 
  exactly one space.

## Common Lisp Code Style

* Do not use the short-circuit binary operators `and` and `or` as
  flow control mechanisms. In other words, do *not* write code
  like this:
  ```lisp
  (and arg-type
       spec-type
    (dotnet:invoke spec-type "IsAssignableFrom" arg-type))
  ```
  But rather, write code like this:
  ```lisp
  (when (and arg-type spec-type)
    (dotnet:invoke spec-type "IsAssignableFrom" arg-type))
  ```
## Markdown

1. Don't put gratuitous spaces in markdown files; use the minimal 
   synctactally correct whitespace
   * Example: Never have two spaces where one is semantically all
     that is necessary
2. Wrap markdown lines between 80 and 100 characters long except when
   not syntactically possible.
3. If you are backtick-quoting something that contains a (single) backtick,
   you must use two leading and trailing backticks. Then, the single
   backtick can be left alone (that is, unduplicated).
   * Example: ``List`1``
   * If the backtick is the first item that is in the backtick-quoted
     expression, just add a preceeding space for now.


# Build Problems

## Lisp Build Problems

When parentheses are mismatched, the build will break with errors that often have
nothing to do with the problem (of mismatched parentheses). If the DotCL portion
fails with an output similar to this: (from DotCL 0.1.8)

```
/home/dfields/src/cl/dotcl/runtime/build/Dotcl.targets(143,5): error MSB3073: The command "dotnet run --project "/home/dfields/src/cl/dotcl-dungeonslime/../dotcl/runtime/runtime.csproj" -- --compile-project "/home/dfields/src/cl/dotcl-dungeonslime/dungeon-slime.asd" --output "obj/Debug/net10.0/ubuntu.24.04-x64/dotcl-fasl/dungeon-slime.fasl"" exited with code 134.
```

then always double (or even triple) check any changes to Lisp code for mismatched
parentheses.

* As soon as any compilation problems or other errors are encountered, check the parentheses 
  balance of *all* modified files individually.
* A target `check-parens` in the `Makefile` runs `check_parens.py` against each 
  `.lisp` file and the `.asd` file. Run `make check-parens` to verify parentheses balance.
* `make test` also runs `--read-check` against the generated `cspackages-test/` output: a
  real Lisp reader read-back (see `read-check.lisp`) that catches invalid-token bugs (e.g.
  an unescaped `#:|` export) which balanced-parens checking alone cannot see.
* `make test-runtime` (`RuntimeExerciseTest/`) goes one step further than either of the
  above: it actually compiles, loads, and calls the generated wrapper functions against
  live .NET objects — including real-world MonoGame and Gum classes (the same libraries
  `dotcl-dungeonslime` consumes), staged from the local NuGet cache — catching
  runtime-dispatch bugs (omitted-optional-passed-as-`nil`,
  Master Wrapper dispatch ordering, `Nullable<T>` guards) that neither paren-balance
  checking nor read-back checking can see, since both only validate the *shape* of
  generated code, never that calling it produces correct results. See
  `doc/plan-fable-detail-02.md`.


# Language

This software targets the [dotcl](https://github.com/dotcl/dotcl)
Common Lisp environment on top of the [DotNet CLR](https://learn.microsoft.com/en-us/dotnet/standard/clr).

This application is targeting the .Net (DotNet) 10 release, and will
likely target a newer .Net release when available.

This code is written primarily in Common Lisp. Additional utilities
are written in C# to ease the interface between the DotCL Common
Lisp environment and C#/MonoGame.

It is running on Arch EndeavorOS Linux on the x86_64 platform. When possible,
try to keep the code cross-platform, at least so it can be built and
run on Windows 11 as well.

This project is publicly available on [GitHub](TODO:ADD_URL).

Some useful Common Lisp documentation:
* [Common Lisp HyperSpec](https://www.lispworks.com/documentation/HyperSpec/Front/index.htm)
* [Common Lisp Nova Spec](https://novaspec.org/cl/)
* [Practical Common Lisp](https://gigamonkeys.com/book/)
* [Common Lisp Cookbook](https://lispcookbook.github.io/cl-cookbook/)
* [Common Lisp Recipes]() is not available in HTML format online.
* [Common Lisp: The Language](https://www.cs.cmu.edu/Groups/AI/html/cltl/cltl2.html)
* [Lisp Games](https://github.com/lispgames/lispgames.github.io/wiki/Lisp-Games)
  * [Common Lisp Game Notes](https://github.com/lispgames/lispgames.github.io/wiki/Common-Lisp)
  * [Free Game Assets](https://github.com/lispgames/lispgames.github.io/wiki/Assets)

.NET (DotNet) information:
* [.NET Site](https://dotnet.microsoft.com/en-us/)
* [.NET Docs](https://learn.microsoft.com/en-us/dotnet/?WT.mc_id=dotnet-35129-website)
* [.NET API Docs](https://learn.microsoft.com/en-us/dotnet/api/?view=net-10.0)
* [C# Language Reference](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/)
* [CLR Introduction](https://github.com/dotnet/runtime/blob/main/docs/design/coreclr/botr/intro-to-clr.md)
* [.NET Runtime GitHub Repo](https://github.com/dotnet/runtime)
* [Local DotNet Runtime Source](../dotnet-runtime) - sibling to this directory

dotcl information:
* [dotcl GitHub Repo](https://github.com/dotcl/dotcl)
* [Local possibly edited dotcl Source](../dotcl) - sibling to this directory
* [Local unedited dotcl Source](../dotcl-clean) - sibling to this directory


# Libraries

The Common Lisp libraries in use are:
* Package management: [ASDF GitHub](https://github.com/fare/asdf)
  * [ASDF Site](https://asdf.common-lisp.dev/)
  * [ASDF Manual - HTML](https://asdf.common-lisp.dev/asdf.html)
  * [ASDF Manual - PDF](https://asdf.common-lisp.dev/asdf.pdf)
  * [ASDF Best Practices](https://gitlab.common-lisp.net/asdf/asdf/blob/master/doc/best_practices.md)
  * [UIOP Readme](https://gitlab.common-lisp.net/asdf/asdf/blob/master/uiop/README.md)
  * [UIOP Manual - HTML](https://asdf.common-lisp.dev/uiop.html)
  * [UIOP Manual - PDF](https://asdf.common-lisp.dev/uiop.pdf)
  * This is provided by DotCL
