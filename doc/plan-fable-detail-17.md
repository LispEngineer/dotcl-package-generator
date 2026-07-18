# Detail Plan 17: Investigation — Closed-Generic Instance Member Support

* Part of the plan series from `doc/plan-fable-20260718.md` (section 5.2).
* Standalone **research task**: the deliverable is a findings document
  (`doc/closed-generic-instance-members.md`) with a go/no-go design sketch — NOT an
  implementation. Plan 04 (documented skips) is the visibility companion; if the
  outcome here is "go", a future implementation plan supersedes those skip comments
  for the supported subset.
* Estimated scope: small-medium (a structured REPL session + write-up).
* No version bumps; no generated-output change.

## The question

Members mentioning the declaring generic type's own type parameter —
`List<T>.Add(T)`, `Dictionary<K,V>.TryGetValue`, `List<T>` indexer's `T` value —
are skipped today (see `classify-class-members`'s `generic-type-p` filter and
FEATURES.md's first Unsupported bullet). But **every live receiver is a closed
type** (`List<int>`, never open `List<T>`), so at runtime the member's signature is
fully concrete. Can DotCL's `dotnet:invoke` late-bound path already call these
members on a closed receiver, with the wrapper never naming `T` at all? If yes, the
generated wrapper for `add` could be a plain guard-less (or weakly-guarded)
`(dotnet:invoke obj! "Add" item)` — transforming collection packages, currently the
emptiest relative to their C# surface.

## Experiment protocol

Run in a live DotCL REPL (the `dotcl-dungeonslime` `make repl` environment, or
whichever host is most convenient; record which). Save the raw transcript; the
findings doc quotes it (the Version 29 verified-transcript convention). Number every
experiment; for each record: form evaluated, result/condition, conclusion.

### Group 1 — plain instance methods on a closed generic receiver

1. Construct `(defparameter lst (dotnet:new "System.Collections.Generic.List`1[System.Int32]"))`
   — first confirm construction syntax for a closed generic via `dotnet:new` at all
   (check `doc/dotnet-dotcl-interop.md` for closed-generic construction and
   `dotnet:make-generic` or equivalent; this is itself a finding: how do users GET
   closed-generic instances today? Likely: returned from BCL/framework calls).
2. `(dotnet:invoke lst "Add" 42)` — the central experiment.
3. `(dotnet:invoke lst "get_Item" 0)` / indexer read; `set_Item` write.
4. `Count` property read (already generated today? no — `Count` doesn't mention
   `T`... verify: does the current generator emit `count` for `List\`1`? Check
   `cspackages-test/system-collections-generic-list-1.lisp`. Members NOT mentioning
   `T` should already work — establish the exact current baseline first).
5. `(dotnet:invoke lst "Contains" 42)`, `"Remove"`, `"IndexOf"` — methods taking `T`.
6. A `T`-returning method through a variable: `(dotnet:invoke lst "Find" pred)` —
   also probes delegate marshaling with a generic delegate type
   (`Predicate<int>`); if delegates complicate, defer to a Group 4 note.

### Group 2 — overload interaction

7. `List<T>.Remove(T)` vs other same-name members;
   `Dictionary<K,V>.Remove(K)` / `Remove(K, out V)`: how does DotCL's runtime
   overload binding behave when several closed-signature overloads exist? Wrong-type
   argument: what condition surfaces? (This determines whether Master-Wrapper-style
   guards are needed or `dotnet:invoke`'s own binding suffices.)

### Group 3 — reference-type and struct type arguments

8. Repeat 2/5 with `List<string>` (reference type arg) and a `List<SomeStruct>`
   (boxing interaction).
9. `Dictionary<string,int>`: `Add`, `get_Item`, `ContainsKey`, and (if Plan 05 has
   shipped an out-primitive) `TryGetValue`.

### Group 4 — the hard edges (bound the design, don't solve)

10. Static members of generic types (`List<T>` has few; use
    `System.Collections.Generic.EqualityComparer\`1`'s static `Default` — a static
    on an OPEN generic type needs the closed type named explicitly: what string does
    `dotnet:static` accept?). This is the case a receiver can't disambiguate.
11. Generic methods OF generic types (`List<T>.ConvertAll<TOutput>`).
12. `dotnet:class-for-type`/`--defgeneric` interaction: can a closed generic
    instance dispatch through `csharp-generics` defmethods specialized on the OPEN
    type? (Ties to `doc/dispatch-on-open-generics.md` /
    `doc/post-dotcl-0.1.17-generic-enhancements.md` — read both before starting;
    they already cover adjacent ground and must be cross-referenced, not
    contradicted.)

## Deliverable: `doc/closed-generic-instance-members.md`

Structure:

1. **Baseline** — what generated `List\`1`/`Dictionary\`2` packages contain today
   and exactly which member classes are skipped (link Plan 04's comments once
   landed).
2. **Findings** — the numbered experiment results with transcript excerpts.
3. **Go/No-Go design sketch** — if instance members work (expected): proposed
   generation rule, e.g. "a member whose signature mentions only the *declaring*
   type's parameters generates an unguarded/weakly-guarded `dotnet:invoke`
   passthrough wrapper, documented as late-bound; excluded from Master Wrapper
   typed dispatch; static members and generic-methods-of-generic-types remain
   skipped (Group 4)". Include: naming (no change — same mapped names), overload
   handling per Group 2's findings, `csharp-generics` inclusion per experiment 12,
   what guards (if any) are safe (v49/v50 lesson: no guard is better than a wrong
   guard — a `csharp-overload-not-found`-style late error from DotCL itself may be
   the correct v1 behavior).
4. **Upstream asks**, if any surfaced (e.g. closed-generic `dotnet:new` ergonomics,
   `dotnet:static` closed-type strings) → also append to
   `doc/dotnet-dotcl-interop.md`'s enhancements section.
5. **Effort estimate** for the implementation plan.

## Acceptance criteria

* The findings doc exists, every Group 1–3 experiment has a recorded result, and
  the go/no-go recommendation is explicit.
* `PLAN.md` gains an appended pointer to the findings doc under a suitable
  heading (new section at top per its conventions).
* `FILES.md` lists the new doc.
