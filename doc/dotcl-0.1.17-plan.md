# Consolidate `--defgeneric`/`--defgeneric-dynamic` using DotCL 0.1.17

## Context

`dotcl-packagegen` currently ships two independent, orthogonal mechanisms for
generating a package of CLOS generic functions that dispatch on C# runtime type
(`csharp-generics` via `--defgeneric`, `csharp-generics-dynamic` via
`--defgeneric-dynamic`). They exist as a deliberate simple/robust tradeoff pair:
the static variant emits plain literal `defmethod` forms but carries a
documented load-order-dependent specializer-symbol collision risk; the dynamic
variant is robust (resolves the real registered CLOS class at load time) but
its generated code is ugly (`eval-when` + `cl:eval` of backquoted `defmethod`
forms per member).

DotCL just shipped 0.1.17, which — per its `RELEASES.md`, crediting this
project's own prior research doc
(`doc/dotcl-0.1.16-defgeneric-csharp-generic-notes.md`) — adds exactly the
primitives that doc's "Suggestions for DotCL" appendix asked for:

1. **`dotnet:class-for-type`** (`runtime/Runtime.DotNet.cs:1027-1034`) — public,
   idempotent lookup: given a `System.Type` or type-name string, returns (and
   lazily registers) the CLOS class DotCL uses for that .NET type. Documented
   for direct use as a `defmethod` specializer via read-time `#.`.
2. **`DotNetTypeDisplayName`** (`runtime/Runtime.CLOS.cs:212-227`) — closed
   generics now register under a distinct, readable name (`List<Int32>` vs
   `List<String>`) instead of colliding on the bare backtick form (`` List`1 ``).
3. **`defmethod` now accepts a class object as a specializer**
   (`compiler/cil-macros.lisp:3291-3307`) — so `#.(dotnet:class-for-type "fq.Name")`
   can be written directly in specializer position.

Together these make `(cl:defmethod foo ((obj! #.(dotnet:class-for-type "fq.Name")) cl:&rest args) ...)`
a legal, ordinary, plain top-level `defmethod` — no `eval`/`eval-when`/backquote
— that resolves the *exact* intended type by its fully-qualified name at read
time, immune to the old symbol-guessing collision race. This mechanism
strictly dominates both existing variants (as simple as static, as robust as
dynamic) for non-generic-arity classes, so **this plan retires both existing
mechanisms and replaces them with one**, driven by a single `--defgeneric` flag.

**Important limitation (verified against DotCL source, not just docs):**
`DotNetTypeDisplayName` recurses over `t.GetGenericArguments()`; for an *open*
generic type (what `dotnet:resolve-type "System.Collections.Generic.Dictionary\`2"`
returns — the only form `--class` accepts today), those are the generic type
*parameters* (`TKey`,`TValue`), producing `Dictionary<TKey,TValue>` — a name
that will never match any real closed instance (`Dictionary<String,Int32>`).
DotCL 0.1.17 did **not** implement the prior doc's suggestion #3 (an
open-generic marker class in the CPL), which is the actual fix for this. So
for generic-arity classes, the new mechanism must **not** silently emit a
dead `defmethod`.

Per user decision: two additional resolutions—
- **Clean break**: `--defgeneric-dynamic`/`--enable-defgeneric-dynamic` and all
  dynamic-variant machinery are deleted outright, not aliased/deprecated.
- **Generic-arity classes**: skip with a loud generated comment (don't error),
  *and* write a new detailed doc, `doc/dispatch-on-open-generics.md`, proposing
  how DotCL could support this (open-generic marker class in the CPL, or other
  approaches) and what's needed from DotCL to unblock it.

## Implementation

### 1. `dotcl-packagegen.csproj`
Bump `<PackageReference Include="DotCL.Runtime" Version="0.1.15" />` → `"0.1.17"`
(line 59). Required — without it `dotnet:class-for-type` doesn't exist.

### 2. `assembly-package-generator.lisp` — core rewrite
- **`generate-batch-generics-file`** (~2878-3013): rewrite per-class emission.
  Replace the literal-symbol specializer
  (`(format nil "dotcl-internal::|~A|" (dotnet-type-simple-name fq-name))`)
  with `(format nil "#.(dotnet:class-for-type ~S)" fq-name)` used directly in
  the `defmethod` specializer position. Drop the `simple-name-index`/
  `resolved-fq-set` optional args and the whole collision-comment branch
  (see below) — the old caveat no longer applies, since `class-for-type`
  resolves the exact FQ name, never a guessed simple-name symbol.
- **Generic-arity guard**: before emitting a class's defmethod block, check
  arity (reuse `generic-type-p`, ~line 308, or check for `` ` `` in `fq-name`).
  If arity > 0, skip the block and emit a comment explaining why (open-generic
  dispatch isn't supported by DotCL yet — reference the new
  `doc/dispatch-on-open-generics.md`), rather than a dead/wrong `defmethod`.
- **Delete outright** (dead code once the static/dynamic split collapses to one
  mechanism): `generate-batch-generics-dynamic-file` (2755-2848),
  `compute-defgeneric-dynamic-model`/`*csharp-generics-dynamic-package-name*`
  (~2551-2626), `dotnet-type-simple-name` (500-542), `build-simple-name-index`
  (2296), `classify-simple-name-conflicts` (2850-2876). Grep-confirmed: no
  other callers of any of these outside this call chain.
- **`generate-assembly-packages-batch`** (~3266-3320): drop the
  `defgeneric-dynamic-model`/`simple-name-index`/`resolved-fq-set` plumbing;
  single `generate-batch-generics-file` call remains.
- **`generate-batch-asd-file`**: drop the second `:file` component block for
  the dynamic package (~3086-3093).
- **`generate-batch-packages-file`**: drop the second `emit-defgeneric-defpackage`
  call for `csharp-generics-dynamic` (~2695-2698).
- **`%compute-defgeneric-model`, `emit-defgeneric-defpackage`,
  `collect-class-instance-generics`**: unchanged — reusable as-is.
- **`*generator-version*`** (line 13): bump 40→41, add a one-line changelog
  entry in its docstring matching the style of Versions 34-38.
- **`dotcl-packagegen.asd`**: bump `:version` `"2.40.2"` → `"2.41.0"` (Makefile's
  `VERSION` auto-derives, no separate edit needed).

### 3. `Program.cs`
- Remove `--defgeneric-dynamic`/`--enable-defgeneric-dynamic`/
  `--no-enable-defgeneric-dynamic` flag parsing (~lines 155-176, 219-225) and
  their manifest emission (`:defgeneric-dynamic` key, ~305-306) — clean break,
  no shim.
- Update `--help` text (~488-530) to describe the single mechanism.

### 4. `Makefile` smoke test
Replace every `--defgeneric-dynamic`/`--enable-defgeneric-dynamic`/
`--no-enable-defgeneric-dynamic` with `--defgeneric`/`--enable-defgeneric`/
`--no-enable-defgeneric` (lines 55,57,58,61,79,83,85,88,90,92), removing
redundant duplicate flags on the same class (e.g. line 57 currently has both).
For `Dictionary\`2`/`SortedList\`2` (lines 79,83 — generic-arity, now
unsupported), keep the `--defgeneric` opt-in so the smoke test exercises and
confirms the skip-with-comment path, rather than removing it.

### 5. New doc: `doc/dispatch-on-open-generics.md`
Detailed write-up (mirroring the quality/structure of
`doc/dotcl-0.1.16-defgeneric-csharp-generic-notes.md`) covering:
- Why open-generic dispatch doesn't work today (the `DotNetTypeDisplayName`
  type-parameter-vs-type-argument mechanism, verified against
  `Runtime.CLOS.cs:212-227`).
- What DotCL 0.1.17 implemented (suggestions #1/#2 from the prior doc) vs. what
  it didn't (#3 — an open-generic marker class in the CPL).
- A concrete proposal for DotCL: register a marker class for the open generic
  definition on first closed-instantiation encounter, insert it into every
  closed instantiation's CPL, so `defmethod` can specialize on "any closing of
  `Dictionary<TKey,TValue>`". Discuss alternatives (e.g. a public
  `dotnet:generic-definition-class-for-type` wildcard lookup) and tradeoffs.
- What package-generator would do once available (lift the arity>0 skip guard,
  emit defmethods against the marker class).

### 5b. New doc: `doc/post-dotcl-0.1.17-generic-enhancements.md`
Broader companion to `doc/dispatch-on-open-generics.md` (which is scoped
narrowly to the CLOS-dispatch/marker-class proposal). This doc surveys the
*full* remaining gap between what DotCL 0.1.17 now provides and what
package-generator would ideally have for generic .NET types, covering both
open and closed generics comprehensively:
- Inventory of what 0.1.17 fixed (`class-for-type`, `DotNetTypeDisplayName`,
  class-object specializers) vs. what's still missing or awkward, e.g.:
  - No way to request/reflect an arbitrary *closed* instantiation as its own
    metadata entry today (per `doc/generator-design-notes.md`'s Version 40
    note that "no arbitrary closed instantiation is ever itself separately
    reflected as its own top-level metadata entry") — should the generator
    gain a way to opt a specific closing (e.g. `List<Int32>`) into full
    package generation, not just dispatch?
  - Whether `DotNetTypeDisplayName`'s collision warning (fires to stderr on a
    genuine cross-namespace simple-name clash) should be surfaced/logged by
    package-generator itself, or left to DotCL.
  - Any remaining friction in `dotnet:resolve-type`'s lazy PackageReference
    assembly-loading (new in 0.1.17) relative to this tool's own explicit
    assembly-loading sequencing.
  - Cross-reference and fold in the open-generic marker-class proposal from
    `doc/dispatch-on-open-generics.md` as one item in this broader list,
    rather than duplicating its detail.
- A prioritized list of suggested DotCL enhancements (mirroring the "Appendix:
  Suggestions for DotCL" style of `doc/dotcl-0.1.16-defgeneric-csharp-generic-notes.md`),
  each tagged with what it would unblock in package-generator specifically.
- Status tracking: this doc is meant to be the living follow-up to the 0.1.16
  notes doc now that 0.1.17 has landed — future DotCL releases' relevant
  changes should be checked off here.

### 6. Doc updates
- `doc/make-everything-defgeneric.md`: rewrite — merge in the dynamic variant's
  robustness properties (now true of the one remaining mechanism), replace the
  "Static specializer collision caveat" section with a short note that
  `class-for-type` resolution eliminates it, add a "Known Limitation:
  generic-arity classes" section pointing at `doc/dispatch-on-open-generics.md`.
- `doc/make-everything-defgeneric-dynamic.md`: delete (mechanism removed), or
  reduce to a short historical stub pointing at the merged doc above — prefer
  deleting per the clean-break decision.
- `doc/generator-design-notes.md`: add a Version 41 section describing the
  consolidation; leave Versions 34/35/36 sections as historical record with a
  forward-pointer note.
- `FEATURES.md`: rewrite "Unified Generic Methods" section (~561-627) — collapse
  static/dynamic subsections into one, drop the collision-caveat bullet, add
  the generic-arity-unsupported bullet with a link to the new doc.
- `doc/dotcl-0.1.16-defgeneric-csharp-generic-notes.md`: add a follow-up section
  noting DotCL 0.1.17 implemented suggestions #1/#2 but not #3, pointing to
  `doc/post-dotcl-0.1.17-generic-enhancements.md` as its living successor
  (which in turn points to `doc/dispatch-on-open-generics.md` for the
  open-generic dispatch detail).
- `RELEASES.md`: new top entry — DotCL 0.1.17 requirement bump, flag
  consolidation (breaking: `--defgeneric-dynamic` removed), generic-arity
  limitation.
- `CLAUDE.md`: rewrite the "unifying its instance methods..." paragraph
  (~138-149) to describe one mechanism/one flag pair, note the generic-arity
  exclusion and pointer to `doc/dispatch-on-open-generics.md` and
  `doc/post-dotcl-0.1.17-generic-enhancements.md`.

### 7. `package-generator-tests.lisp`
Rewrite tests 11.3/11.4/11.5/12/13.2 (~979-1670): merge into a single
`--defgeneric` test set, delete dynamic-only assertions, delete/replace the
collision-comment test (~1588-1664) with one asserting the old comment text is
*absent*, add a test asserting generic-arity classes are skipped with the
expected comment rather than emitting a defmethod.

## Verification

1. `make build test` (after the csproj/Makefile edits).
2. Review `cspackages-test/csharp-generics.lisp` diff: confirm
   `System.Threading.Timer`/`System.Timers.Timer` (the deliberate
   same-simple-name collision pair) each get a plain
   `#.(dotnet:class-for-type "...")`-specialized `defmethod` with no collision
   comment — this is the regression check for the exact bug 0.1.17 fixes.
3. Confirm `Dictionary\`2`/`SortedList\`2` are skipped with the expected
   comment, not emitting dead/wrong defmethods.
4. Confirm `csharp-generics-dynamic.lisp` no longer appears in
   `cspackages-test/`, and `csharp-assembly-packages.asd` no longer references
   the dynamic package.
5. `make check-parens`.
6. Run the rewritten `package-generator-tests.lisp` suite (via `make test`) and
   confirm all pass, including the new generic-arity-skip test.
