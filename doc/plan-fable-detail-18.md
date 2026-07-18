# Detail Plan 18: Upstream Proposal — CLOS→C# Proxies (Lisp-Implemented Interfaces)

* Part of the plan series from `doc/plan-fable-20260718.md` (section 5.1); addresses
  `PLAN.md`'s "Implement a system to convert a CLOS class to a CLR/C# class"
  noodling item.
* Standalone **proposal-writing task**: the deliverable is
  `doc/proposal-clos-csharp-proxy.md`, an upstream-ready design proposal for the
  DotCL runtime (`../dotcl`), plus the generator-side surface sketch. No code in
  this repo changes. This repo's proposal→upstream-release→generator-adopt loop has
  worked twice (0.1.17 generics; the pending `dotnet:clone`); follow the same form.
* Estimated scope: medium (research + writing; requires reading DotCL runtime
  source).

## The capability gap

The bridge is one-directional: Lisp calls .NET; .NET calls Lisp only through
delegates (`dotnet:make-delegate`, event handlers). Real framework integration
eventually needs a .NET **object** whose interface/virtual methods dispatch into
CLOS: `IComparer<T>` for sorting, `IEnumerable<T>` from Lisp data,
MonoGame/Gum callback interfaces, `INotifyPropertyChanged`, etc. Today a user must
write a C# shim class per interface by hand.

## Research phase (read before writing)

1. **DotCL runtime** (`../dotcl`): how delegates into Lisp work today
   (`dotnet:make-delegate`'s implementation — marshaling, GC rooting of the Lisp
   function, thread considerations); whether any proxy machinery exists; how
   `LispObject`s are kept alive across .NET boundaries. Cite files/lines the way
   `PLAN.md`'s Option B research pass did.
2. **Mechanism candidates** (evaluate against DotCL's actual runtime constraints —
   e.g. does it run where `Reflection.Emit` is available? AOT?):
   * `System.Reflection.DispatchProxy` — stdlib, easy, but **interfaces only** and
     needs a parameterless-constructible proxy type per interface; no virtual-class
     proxying.
   * `Reflection.Emit` dynamic type — full power (interfaces + abstract classes +
     virtual overrides), highest complexity, JIT-only.
   * Source-generated shims (a C# generic `LispCallbackProxy<TInterface>` emitted
     per interface by *this* generator, compiled by the consuming project) — no
     runtime codegen at all; heavier consumer build integration.
   Recommend one primary (+ fallback); a sensible expected outcome is
   **DispatchProxy for v1 (interfaces only)**, Reflection.Emit as v2 for abstract
   classes — but let the research decide.
3. **Prior art**: how other Lisp/.NET or dynamic-language bridges did it (IronPython
   `object` subclassing, Clojure CLR `proxy`/`reify` — Clojure's `reify` is the
   ergonomic north star and worth citing).

## Proposal content (`doc/proposal-clos-csharp-proxy.md`)

1. **Motivation** with 2–3 concrete Dungeon Slime / Gum examples (find a real
   interface from MonoGameGum the user would plausibly implement — e.g. a Gum
   forms/controls callback interface — and show the today-impossible code).
2. **Proposed Lisp API** (runtime primitive, DotCL-side):
   ```lisp
   (dotnet:implement "Some.Namespace.IComparer`1[System.String]"
     "Compare" (lambda (proxy a b) ...)
     ...)
   ;; => a .NET object implementing the interface, passable anywhere .NET
   ;;    expects that interface type
   ```
   Specify: multiple interfaces?; unimplemented-member behavior (throw
   NotImplemented vs required-complete at construction — recommend construction
   error, matching this ecosystem's fail-early style); `Equals`/`GetHashCode`/
   `ToString` defaults; how the receiver (`proxy`) appears to Lisp; lifetime/GC
   rooting semantics; thread-safety statement; exception mapping (Lisp condition ↔
   .NET exception at the boundary, both directions).
3. **Generator-side surface** (this repo, future): for an interface package
   generated with a new flag (e.g. `--implementable`), emit a
   `define-implementation` macro wrapping `dotnet:implement` with the interface's
   exact member names/signatures spelled out — compile-time completeness checking
   and docstrings for free, reusing existing metadata. Include a worked expansion
   example. Also sketch the CLOS-integration layer (`defmethod`-based:
   an `implement-with-generic-functions` variant that builds the lambda table from
   existing generic functions specialized on a marker class) — this is the "base
   CLOS class that implements functionality to create that proxy on the fly" idea
   from `PLAN.md`, addressed to its author.
4. **Staged scope**: v1 interfaces-only/DispatchProxy; v2 abstract-class overrides;
   explicit non-goals (structs, sealed types, performance-critical hot paths — note
   delegate-marshaling overhead per call).
5. **Compatibility/risks**: AOT, GC rooting, re-entrancy (Lisp → .NET → Lisp),
   what happens when .NET calls the proxy on a foreign thread.

## Integration steps (this repo, part of this task)

* Add a summary + link in `doc/dotnet-dotcl-interop.md`'s "Missing Interoperability
  Capabilities & Proposed Enhancements" section.
* `PLAN.md`: append a pointer under the CLOS→CLR noodling item.
* `FILES.md`: list the new doc.

## Acceptance criteria

* The proposal is self-contained enough to file upstream (as a dotcl/dotcl issue or
  PR-attached design doc) without this repo's context; mechanism recommendation is
  evidence-based (cites DotCL source locations); the Lisp API is fully specified
  including error/lifetime semantics; the generator-side sketch shows one complete
  worked example.
