# Detail Plan 13: Async Method Convenience Wrappers (`name-await`)

* Part of the plan series from `doc/plan-fable-20260718.md` (section 5.4 item 1);
  addresses `doc/claude-suggested-improvements-20260703.md`'s item 17.
* Standalone. Output shape change → `*generator-version*` bump + design-notes +
  `FEATURES.md` + `RELEASES.md`.
* Estimated scope: medium. Includes a mandatory live-verification phase.

## Goal

`Task`-returning methods are a huge fraction of modern .NET surface area. Today they
generate ordinary wrappers returning a raw `Task` object the Lisp caller can do
little with. v1 goal (deliberately modest): alongside the existing wrapper, generate
a **blocking** `name-await` variant that synchronously waits and returns the task's
result — with honest documentation that it blocks. A real cooperative-async story is
a DotCL-upstream conversation, out of scope (note it in
`doc/dotnet-dotcl-interop.md`'s enhancements section as a closing step).

## Phase 0 — Live verification (REPL, before any codegen work)

Verify the invocation chain DotCL-side against a real async method (fixture below,
or `System.IO.File.ReadAllTextAsync` via reflection):

1. `(dotnet:invoke task "GetAwaiter")` — `TaskAwaiter`/`TaskAwaiter<T>` and
   `ValueTask`'s awaiters are **structs**; confirm DotCL boxes and can invoke
   `GetResult` on them.
2. Alternative, likely simpler chain: `Task.Result` property /
   `(dotnet:invoke task "Wait")` then `"Result"` — but `.Result`/`.Wait()` wrap
   exceptions in `AggregateException`, while `GetAwaiter().GetResult()` unwraps —
   prefer the awaiter chain if it works; record which was chosen and why.
3. Non-generic `Task` (void async): confirm `GetResult` returns something
   nil-mappable.
4. `ValueTask`/`ValueTask<T>`: separate check (`GetAwaiter` exists; the struct
   boxing question applies doubly). If problematic, scope v1 to `Task`/`Task<T>`
   only and document `ValueTask` as unsupported.
5. Exception path: a faulted task — confirm the .NET exception surfaces as a
   catchable Lisp condition rather than corrupting the host.

Record all findings in the design-notes section; adjust the emitted chain to match.

## Design

### Detection (metadata is sufficient — no `AssemblyToLispy.cs` change)

A method is async-wrappable when its `:return-type` string is exactly
`"System.Threading.Tasks.Task"` / `"System.Threading.Tasks.ValueTask"` or starts
with `"System.Threading.Tasks.Task\`1["` / `"...ValueTask\`1["` (verify exact
spelling against real metadata — check `cspackages-test/*.lispy.metadata` for a
Task-returning member, e.g. on `System.IO.MemoryStream`/`StreamReader` which the
smoke test already generates: `ReadAsync`, `ReadToEndAsync`). Predicate
`task-return-type-p` in `apg-member-predicates.lisp` returning `:task`/`:task-of`/
`:value-task`/`:value-task-of`/`nil`.

### Emission

For each generated method wrapper (simple, Master Wrapper, generic-arity — audit
each emission path) whose return type is task-like, additionally emit:

```lisp
(cl:defun read-to-end-async-await (obj!)
  "Calls read-to-end-async and BLOCKS until the task completes, returning its
   result (or nil for a plain Task). Wraps <C# sig>. NOTE: synchronous wait --
   do not call from contexts where blocking the thread is unacceptable."
  (cl:let ((task (read-to-end-async obj!)))
    (dotnet:invoke (dotnet:invoke task "GetAwaiter") "GetResult")))
```

Key decisions:

* The `-await` wrapper **delegates to the existing wrapper** (same lambda list,
  including `&optional`/`&key` shapes for Master Wrappers — it must pass through
  `cl:&rest`-style: for Master Wrappers use
  `(cl:defun name-await (cl:&rest args) ... (cl:apply (cl:function name) args) ...)`
  to avoid duplicating complex lambda lists; for simple wrappers mirror the simple
  lambda list for better arglist documentation). Never re-implements dispatch.
* Naming: `-await` suffix on the *mapped* name (`read-to-end-async` →
  `read-to-end-async-await`). Do NOT strip `-async` (tempting but collides when a
  sync `ReadToEnd` also exists — which it usually does). Collision check against
  the export universe like every other synthesized name; on collision, skip with a
  comment.
* Static methods (`name*` variants) and extension methods get the same treatment;
  instance events/properties cannot be task-returning in a way that matters —
  properties of type `Task` exist but awaiting a property's stored task is a
  caller decision; **methods only** in v1 (document).
* `csharp-generics` unification: exclude `-await` names in v1 (keep the diff
  contained); note as follow-up.

### Integration

* Export the new names (`compute-package-exports-and-shadows` — same shared-naming
  discipline as always: one function decides the name + inclusion, called by both
  the exporter and the emitter).
* Emission lives beside each wrapper's emission site in
  `apg-class-file-generator.lisp` / dispatch code; keep it a single helper
  `emit-await-variant (stream base-name lambda-shape)`.

## Testing

1. Fixture: add to `AssemblyToLispyTestTarget/EdgeCases.cs` —
   `Task<int> ComputeAsync(int x)` (returns `Task.FromResult(x * 2)`),
   `Task DoNothingAsync()`, `Task<string> FailAsync()` (returns
   `Task.FromException<string>(...)`), `ValueTask<int> ComputeValueAsync(int)`.
   Update `tests/synthetic-target.test.lisp` schema expectations.
2. Unit: predicate tests (exact/generic/ValueTask/non-task strings); codegen text
   tests (await variant present, delegation form, docstring, collision-skip case).
3. Smoke: `cspackages-test/` diff — `MemoryStream`/`StreamReader`/`XmlReader` gain
   `-await` variants; review.
4. **Runtime (Plan 02 suite — effectively required for this plan):**
   `(compute-async-await obj 21)` ⇒ 42; `do-nothing-async-await` ⇒ nil;
   `fail-async-await` signals a catchable condition. If Plan 02 isn't landed yet,
   do these by hand in a REPL and paste the transcript into the design-notes
   section (the Version 29 verified-transcript convention).
5. `make check-parens`; full `make test`.

## Documentation

* `*generator-version*` bump + changelog; design-notes section (Phase 0 findings,
  chain choice, naming rationale, v1 exclusions).
* `FEATURES.md`: new "Async Methods" section; remove/amend the Unsupported item.
* `doc/dotnet-dotcl-interop.md`: enhancements section gains the "real cooperative
  async" upstream note.
* `RELEASES.md` + CLI `VERSION` minor bump.
