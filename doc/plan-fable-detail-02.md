# Detail Plan 02: Runtime Exercise Suite (`make test-runtime`)

* Part of the plan series from `doc/plan-fable-20260718.md` (section 3.1(b)).
* Standalone, but pairs naturally with Plan 01 (read-back check). Do 01 first if
  possible — it's the cheap half of the same verification gap.
* Estimated scope: large (the biggest item in this series). New test project,
  new fixtures, new Makefile target. No generated-output change →
  **no `*generator-version*` bump** (unless fixture work in
  `AssemblyToLispyTestTarget` exposes a bug to fix, which is the point).

## Goal

Actually **execute** generated wrapper code — compile it, load it, and call it against
live .NET objects — as an automated `make` target. This is the structural fix for the
v48–v50 escape class (omitted-optional-passed-as-`nil`, Master Wrapper dispatch
ordering, `Nullable<T>` guards): all three were runtime-dispatch bugs invisible to
string-level assertions and only found downstream in Dungeon Slime.

## Architecture decision (verify before building)

Two candidate architectures; **Step 0 below decides between them**:

* **Architecture A (preferred, mirrors the real consumer):** a new sibling C# project
  `RuntimeExerciseTest/` with its own `.csproj` + `.asd`, exactly like
  `dotcl-dungeonslime` consumes generated packages — DotCL cross-compiles the
  generated `.lisp` during `dotnet build`. This *also* permanently regression-tests
  ASDF-loadability (the dotcl/dotcl#49 class fixed across Versions 42–46), because the
  generated system is consumed as a real ASDF system.
* **Architecture B (fallback):** if DotCL supports runtime `cl:load`/compile-and-load
  of `.lisp` source files from a running host (check `doc/dotnet-dotcl-interop.md` and
  the DotCL runtime source in `../dotcl`), add a `--test-runtime <gen-dir>` mode to
  the existing executable that loads the generated files in `.asd` order and runs the
  assertions. Cheaper, but doesn't exercise the ASDF path.

**Step 0:** spend up to an hour confirming which is feasible; prefer A. If A, model the
new project's `.csproj`/`.asd`/DotCL wiring on `AssemblyToLispyTestTarget/`'s csproj
(for project mechanics) and on the main `dotcl-packagegen.csproj` (for DotCL Lisp
compilation wiring); `dotcl-dungeonslime`'s repo is the reference consumer if
available locally (`../dotcl-dungeonslime`).

## Design (assuming Architecture A)

### Layout

```
RuntimeExerciseTest/
  RuntimeExerciseTest.csproj    # references DotCL, AssemblyToLispyTestTarget
  runtime-exercise.asd          # :depends-on ("csharp-assembly-packages")
  runtime-tests.lisp            # the assertions (framework below)
  gen/                          # OUTPUT of the generation step (gitignored)
```

### Makefile target

```make
test-runtime: build
	rm -rf RuntimeExerciseTest/gen
	$(EXECUTABLE) --out-dir RuntimeExerciseTest/gen \
	    --assembly $(BIN_DIR)AssemblyToLispyTestTarget.dll \
	      --class <fixture classes, see below> ... \
	    --assembly $(REF_DIR)System.Runtime.dll \
	      --class System.TimeSpan --constant-properties "*"
	dotnet build RuntimeExerciseTest/RuntimeExerciseTest.csproj -c Debug
	<run the built test executable; nonzero exit on any failed assertion>
```

Wire `test-runtime` into `all:` (or at least document `make build test test-runtime`
as the full loop). Add `RuntimeExerciseTest/gen/`, `bin/`, `obj/` to `.gitignore` and
`make clean`.

### Assertion framework

A minimal self-contained `deftest`/`assert-equal`-style harness inside
`runtime-tests.lisp` (do NOT reuse `tests/framework.lisp` — that belongs to the
generator's own system and does metadata schema validation; this project must only
depend on the *generated* system plus DotCL). Track pass/fail counts; the C# `Main`
calls the Lisp entry point and exits nonzero if any test failed.

### Test content — one test per historical escape, then breadth

Each item names the bug class it guards (add fixtures to
`AssemblyToLispyTestTarget/EdgeCases.cs` as needed; several already exist from v48/v50
work — `NullableStructParamMethod`, `NullableIntParamMethod`, defaulted-parameter
constructors):

1. **v48 guard — omitted optional arguments.** Call a method/constructor with a
   defaulted parameter, omitting it; assert the callee observed the *actual C#
   default*, not `nil`/`false`/`0`. Fixture: a method
   `string EchoDefaults(int x = 42, string s = "hi", SomeEnum e = SomeEnum.B)`
   returning a string encoding of what it received.
2. **v49 guard — overload dispatch ordering with defaults.** A method overloaded such
   that a shorter-arity call is ambiguous until defaults are considered; assert each
   arity/type combination reaches the right C# overload (fixture returns a
   discriminating string per overload).
3. **v50 guard — `Nullable<T>` arguments.** Call `NullableStructParamMethod` /
   `NullableIntParamMethod` with a real value AND with `nil`; assert both dispatch and
   both produce the right `HasValue` observation. Include a nullable parameter whose
   `T` lives in a *different assembly* than the caller if feasible (the cross-assembly
   resolution half of v50).
4. **Master Wrapper branches.** For one method with 3+ clean overloads
   (string/number/object-typed), call every branch and assert overload identity.
5. **Operators.** `+`, `=`, unary `-`, and one Version 47-renamed operator
   (`bitwise-or!`) on a fixture struct with operator overloads; assert results and
   that the *shadowed* symbols still work inside the package.
6. **Properties/fields/`setf`.** Instance property get/set, public instance field
   get/set, static readonly property, `--constant-properties` memoization (read twice,
   assert same boxed object identity via `cl:eq` — documents the aliasing semantics),
   indexer get/set with an index argument (the v26 bug class).
7. **Events.** Fixture class with an instance event plus a `Raise()` method; add a
   Lisp handler via the generated `add-X`, raise, assert the handler ran; `remove-X`,
   raise, assert it didn't.
8. **`csharp-generics` dispatch.** Generate two fixture classes with `--defgeneric`
   sharing a method name; call the unified generic on instances of each; assert
   correct per-class dispatch.
9. **Generic methods** (own type arguments): call an arity-1 and an arity-2 generic
   method wrapper, and one `name<>` dispatcher (`:split-with-plain` mode).
10. **Struct boxing mutation** (documents current behavior, guards against silent
    change): `setf` a struct property through one alias, assert visible through the
    other alias.

Prefer fixtures in `AssemblyToLispyTestTarget` over BCL types for all assertions
(version-stable, controllable); keep at most one BCL class (`System.TimeSpan`) as a
"real world" smoke.

### Fixture additions to `AssemblyToLispyTestTarget/EdgeCases.cs`

Whatever items 1–10 need that doesn't exist yet (echo-style methods returning
discriminating strings are the pattern: they make assertions trivial). Any new public
fixture member will change the reflected metadata — the existing
`tests/synthetic-target.test.lisp` schema tests and `make test`'s
`cspackages-test/` golden output may need corresponding updates (the smoke test
generates several `AssemblyToLispyTestTarget` classes; check whether the new fixtures
land in already-generated classes or new ones).

## Acceptance criteria

* `make test-runtime` builds, runs, and passes from a clean checkout.
* Reverting the v48 fix (or hand-injecting its bug: make the generated wrapper pass
  `nil` for an omitted optional) makes test 1 fail — verify this once manually to
  prove the suite has teeth.
* `make clean` removes all `RuntimeExerciseTest` build output; `git status` stays
  clean after a full run (gen/ gitignored).

## Documentation updates

* `README.md`/`CLAUDE.md`/`GEMINI.md`/`BUILD.md`: document `make test-runtime` and
  when to run it (before any release; after touching dispatch/codegen).
* `FILES.md`: new project directory.
* `RELEASES.md`: entry for the new target (CLI `VERSION` minor bump).
* `PLAN.md`: mark the "new DotCL application ... runs LOTS of tests" Miscellaneous
  item DONE with a pointer here (append/mark-DONE only — never rewrite existing text).
