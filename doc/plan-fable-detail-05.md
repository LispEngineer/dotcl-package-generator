# Detail Plan 05: `out`-Parameter Support (`out` → `cl:values`)

* Part of the plan series from `doc/plan-fable-20260718.md` (section 3.3).
* Standalone, but do Plan 02 (runtime suite) first if at all possible — this feature
  is exactly the kind of runtime-dispatch behavior that has historically shipped
  broken without it.
* Estimated scope: large, and **possibly upstream-blocked** (see Phase 0).
* Output shape changes → `*generator-version*` bump, design-notes section,
  `FEATURES.md` and `RELEASES.md` updates, `doc/assembly-to-lispy.md` untouched
  (metadata already captures `:out`/`:ref`/`:ref-readonly`).

## Goal

Generate real wrappers for the ubiquitous .NET `Try*` pattern —
`bool TryParse(string s, out T result)`, `Dictionary.TryGetValue(K, out V)` — mapping
`out` parameters to additional Lisp return values:

```lisp
(cl:multiple-value-bind (ok result) (int:try-parse "42")
  ...)
```

Scope for v1: **overloads whose only byref parameters are `out`** (no `ref`, no
`ref readonly`/`in`, no `params`). `ref` (in+out) is deferred — it needs an input
value AND a returned update, a clumsier shape; `in` is semantically pass-by-value for
the caller and could later be treated as a plain parameter, but is out of scope here.

## Phase 0 — Feasibility verification (do first; may end the plan)

The entire feature hinges on whether DotCL's invocation path can observe
`out`-parameter writebacks. .NET reflection's `MethodInfo.Invoke(obj, args)` writes
`out`/`ref` results back into the `args` array — the question is whether DotCL
exposes that.

1. Read `doc/dotnet-dotcl-interop.md` for any byref mention; then read the actual
   DotCL runtime source (`../dotcl`, `runtime/Runtime.DotNet.cs` — the
   `dotnet:invoke`/`dotnet:static` implementation and its argument-marshaling path)
   to determine: (a) does overload binding even *select* a method with an `out`
   parameter given N-1 or N args? (b) after `Invoke`, is the modified args array
   readable from Lisp in any form?
2. Live-verify in a REPL against a real method (`System.Int32.TryParse` or a
   fixture in `AssemblyToLispyTestTarget`): try `(dotnet:static "System.Int32"
   "TryParse" "42" <something>)` with candidate placeholder values.
3. **Decision gate:**
   * If DotCL can already do it (unlikely but check), proceed to Phase 1.
   * If not: write the upstream proposal instead — add a section to
     `doc/dotnet-dotcl-interop.md`'s "Missing Interoperability Capabilities &
     Proposed Enhancements" specifying a new primitive, e.g.
     `dotnet:invoke-with-out` / `dotnet:static-with-out` returning
     `(cl:values return-value out-1 out-2 ...)`, with exact semantics (arg-array
     writeback, which positions are outs, null handling), following the precedent of
     this repo's successful 0.1.17 proposal loop. **Then stop; the rest of this plan
     resumes when the DotCL release ships.** Record the blocked state in `PLAN.md`
     (append-only) with a pointer here.

## Phase 1 — Codegen design (once invocation exists)

### Classification

`apg-member-predicates.lisp`:

* New predicate `out-only-method-p` (and `out-only-constructor-p` if constructors are
  included — recommend **methods only** for v1; `out` constructors are rare): every
  byref parameter is `:out` (none `:ref`/`:ref-readonly`), no `:params`, generic
  arity supported, not an operator/accessor.
* `dirty-method-p` currently sweeps these into the "not yet supported" comment; an
  out-only method must move out of the dirty bucket into a new classification slot
  (`out-methods` on `class-member-classification`). A method that is *both* (e.g.
  one `out` plus one `ref` param) stays dirty.

### Naming

Decision (recommended): the out-wrapper uses the **plain mapped name** when no clean
overload of that name exists (the common `Try*` case — `TryParse` has no clean
overload, so `try-parse` is free). When the name group *also* has clean overloads
(e.g. `Parse` clean + hypothetical `Parse(out ...)`), the out variant gets a `&out`
suffix... — no. Keep it simpler and lispier: suffix `-out` is ambiguous with real C#
names. Use `/out` (`parse/out`) — `/` never appears in a mapped member name
(`camel-to-kebab` never emits it; the only `/` in the operator table is division,
which is an operator group, never mixed with named methods). Document the choice in
the design-notes section. If multiple out-only overloads share a name, they go
through the same Master Wrapper dispatch machinery as clean overloads (guards built
from the non-out parameters only).

### Wrapper shape

For `static bool TryParse(string s, out int result)`:

```lisp
(cl:defun try-parse (s)
  "docstring: notes the C# signature, that 'result' is returned as the
   second value, and the raw return as the first."
  (dotnet:static-with-out <type-str> "TryParse" '(1) s))  ; exact form per Phase 0's primitive
```

Key details to specify against the real primitive: how out positions are declared,
what placeholder (if any) occupies the out slot, and multiple-value ordering —
**primary return first, then each `out` in C# parameter order** (document in
`FEATURES.md`). Instance methods take `obj!` first as usual. The `out` parameters are
*omitted* from the wrapper lambda list entirely.

### Integration points

* `classify-class-members` → new slot; `compute-package-exports-and-shadows` must
  export the new names; `collect-class-instance-generics` should include instance
  out-methods in the unified generics (same shape: `obj!`-first) — or explicitly
  exclude with a rationale, decided during implementation.
* `emit-methods` (`apg-class-file-generator.lisp`) → new emission branch.
* Dirty-comment emitters: an out-only method must no longer appear in the "not yet
  supported" comment (it's supported now); `ref`-involving overloads still do —
  update the comment's wording ("ref or params" instead of "ref, out, or params")
  everywhere it is emitted (constructors: `emit-constructors` cases 1–3; methods:
  wherever `format-overload-doc-block`/dirty comments are emitted).

## Testing

1. Unit: mock plists → classification (out-only vs still-dirty mixed ref+out),
   naming (bare vs `/out`), emitted wrapper text.
2. Fixtures: `AssemblyToLispyTestTarget/EdgeCases.cs` already has `scoped`/`ref`
   coverage; add `bool TryGetThing(string key, out int value)` and a
   two-out method. Schema tests in `tests/synthetic-target.test.lisp` updated.
3. Smoke: the `Makefile` invocation already generates `Dictionary`\`2 — but note
   `TryGetValue(K, out V)` *also* trips the open-generic-parameter exclusion (Plan
   04's territory), so the visible BCL win there arrives only after Plan 17;
   `System.TimeSpan`/`System.Int32`-style `TryParse` in already-generated classes is
   the observable smoke-test change. Review the `cspackages-test/` diff.
4. **Runtime** (Plan 02 suite, if present): call `try-parse` on a good and a bad
   string; assert `(values t 42)` / `(values nil 0)`. This is the must-have test.
5. `make check-parens`; full `make test`.

## Acceptance criteria

* Phase 0's findings written into `doc/dotnet-dotcl-interop.md` regardless of
  outcome.
* If unblocked: `try-parse`-style wrappers generated, exported, documented; dirty
  comments no longer list out-only overloads; all tests green.
* `FEATURES.md` gains an "Out Parameters" section (value ordering, naming rule,
  v1 scope exclusions: `ref`, `in`, constructors, `params`).
