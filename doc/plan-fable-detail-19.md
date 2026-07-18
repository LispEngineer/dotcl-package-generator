# Detail Plan 19: Curated "Lispy Standard Library" Layer

* Part of the plan series from `doc/plan-fable-20260718.md` (section 5.5); builds on
  the existing sketch in `doc/lispy-csharp-standard-library.md` (read it first — it
  is the seed of this plan and its ideas take precedence where they conflict).
* Standalone, but its value multiplies after Plans 02 (runtime suite — shared
  testing infrastructure), 05 (`out`→values — `Try*` ergonomics), and 17
  (closed-generic members — collections usability). Doing it last among the series
  is reasonable; doing a thin v1 earlier is also defensible.
* Estimated scope: large, open-ended — this plan deliberately defines a **small v1**
  with a growth path, not the whole library.

## Goal

Generated packages are faithful but mechanical — DotCL is *possible*, not yet
*pleasant*. A thin, hand-written, tested layer over the most common BCL surface
makes idiomatic Lisp out of idiomatic .NET. It also becomes a permanent, growing
consumer of generated packages: every stdlib function exercises generator output by
construction (the durable home for runtime verification pressure).

## Decision 0 — Where does it live?

Recommend: **a new sibling repository** (working name `lispy-dotnet`), NOT this
repo. Rationale: different release cadence, different dependency direction (it
*consumes* `dotcl-packagegen` output + DotCL; the generator must never depend on
it), and this repo's identity as a focused tool. This plan then delivers, in THIS
repo: the design document + the generation recipe the new repo will use; and, in
the new repo: the v1 skeleton. If the user prefers in-repo (a `stdlib/`
subdirectory + separate `.asd`), everything below still applies — ask before
scaffolding. **This is the one plan in the series with a real user decision up
front.**

## v1 scope (small, high-leverage)

### Layer 1 — generated foundation

A checked-in, versioned generation config (an options file, once Plan 07 lands)
producing packages for the core types the stdlib wraps: `System.String`,
`System.Text.StringBuilder`, `System.Convert`, `System.Math`, `System.DateTime`/
`TimeSpan`/`DateTimeOffset`, `System.IO.File`/`Directory`/`Path`,
`System.Collections.Generic.List\`1`/`Dictionary\`2`, `System.Linq.Enumerable`,
`System.Text.RegularExpressions.Regex`. Regenerated deliberately (a `make
regen` target), diffs reviewed — same philosophy as `cspackages-test/` but as a
real dependency.

### Layer 2 — hand-written idiomatic API (the actual library)

Package `lispy-dotnet` (plus per-domain packages if it grows). v1 modules, each
~10–20 functions, each function: docstring, tests, consistent conventions
(conventions doc first — naming, nil vs condition on failure, sequence-return
types):

1. **`ld-seq`** — the flagship: bridge `IEnumerable` ↔ Lisp sequences.
   `(ld:seq->list enumerable)`, `(ld:list->list-of "System.Int32" lisp-list)`,
   `(ld:do-enumerable (x enum) ...)` (macro over `GetEnumerator`/`MoveNext`/
   `Current`), `map-enumerable`, `filter-enumerable` — pure-Lisp iteration first
   (no LINQ dependency), LINQ-backed variants only where they win. This module's
   feasibility gates on closed-generic member access (Plan 17) for `List<T>`
   construction/`Add`; if Plan 17 hasn't landed, v1 iterates via the non-generic
   `System.Collections.IEnumerator` interface (no `T` in signatures — works today;
   verify against current generated packages).
2. **`ld-string`** — `split`/`join`/`trim`/`starts-with?` etc. delegating to
   `System.String` wrappers but taking/returning Lisp strings and lists;
   `format-net` (composite formatting).
3. **`ld-io`** — `read-file-string`, `write-file-string`, `with-net-stream`
   (unwind-protect'd `Dispose` — the general `with-disposable` macro belongs here
   and may be the single most valuable form in the library: `IDisposable` handling
   is currently raw).
4. **`ld-time`** — `now`, `utc-now`, DateTime ↔ universal-time conversion,
   timespan arithmetic sugar.
5. **`ld-convert`** — boxing/unboxing helpers, `->int`/`->string`-style
   conversions with clear failure conditions (folding in `Try*` once Plan 05
   lands).

### Layer 3 — tests

The library's own test suite (reuse the `deftest` shape from Plan 02's harness or
`tests/framework.lisp`'s DSL style) — every exported function called against live
objects. This is where "stdlib tests permanently exercise the generator" is
realized: run it in CI/`make test` of the stdlib repo against freshly regenerated
packages, so a generator regression breaks the stdlib build visibly.

## Deliverables of this task

1. `doc/lispy-stdlib-design.md` in this repo (or a major extension of
   `doc/lispy-csharp-standard-library.md` — prefer extending the existing doc, per
   repo convention of evolving named docs): conventions, module list, the
   Decision-0 recommendation, the Layer-1 generation config, the Plan-17/05
   dependency notes, and the v1 function inventory with signatures.
2. After the user confirms Decision 0: scaffold the repo/directory — `.csproj` +
   `.asd` + generation config + `ld-seq` and `ld-io` implemented and tested as the
   proof modules (the other three modules can be follow-ups; two real modules
   prove the architecture).
3. `PLAN.md`: appended pointer; `FILES.md` if in-repo.

## Acceptance criteria (v1)

* Design doc reviewed/merged; conventions section exists and every implemented
  function follows it.
* `ld-seq`: `(ld:seq->list ...)` works on a `List` and on a LINQ result;
  `with-disposable` provably disposes (test with a fixture IDisposable that
  records disposal).
* The stdlib's `make test` regenerates Layer 1 and passes end-to-end from clean
  checkout.
