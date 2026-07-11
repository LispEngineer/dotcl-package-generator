# Dispatch on Open Generic .NET Types

* Status: PROPOSAL (not implemented — this document describes a gap left by DotCL 0.1.17 and
  a concrete design for closing it, for DotCL's maintainers to evaluate).
* Related: `doc/dotcl-0.1.16-defgeneric-csharp-generic-notes.md` (the prior-cycle research this
  document follows up on — its Appendix suggestion #3 is the gap this document expands on),
  `doc/post-dotcl-0.1.17-generic-enhancements.md` (broader post-0.1.17 follow-up survey, of
  which this is one item), `doc/make-everything-defgeneric.md` (the `--defgeneric` mechanism
  this gap directly affects), `doc/generator-design-notes.md`'s Version 41 section.

## The gap

DotCL 0.1.17 added `dotnet:class-for-type` (a public, lazily-registering lookup for a .NET
type's CLOS class) and `defmethod` support for a class *object* as a specializer via read-time
`#.`. Together these let `dotcl-packagegen`'s `--defgeneric` mechanism emit a plain
`(cl:defmethod foo ((obj! #.(dotnet:class-for-type "fq.Name")) cl:&rest args) ...)` that
resolves the *exact* named type at read time and is immune to the old
load-order-dependent simple-name/FullName registration race (see
`doc/generator-design-notes.md`'s Version 41 section for the full before/after).

This works perfectly for a **non-generic** type, and for a specific **closed** generic
instantiation if you happen to already have its exact closed `System.Type` in hand. It does
**not** work for dispatching on an **open generic type definition** — which is the only form
`dotcl-packagegen`'s `--class` flag can ever name for a generic type, since no arbitrary closed
instantiation is itself separately reflected as its own top-level metadata entry (see
`doc/generator-design-notes.md`'s Version 40 note). Concretely: a class opted into
`--defgeneric` whose fully-qualified name is generic (e.g.
`System.Collections.Generic.Dictionary\`2`) cannot get a working dispatch defmethod today.

### Why, mechanically

`DotCL.Runtime.CLOS.cs`'s `DotNetTypeDisplayName` (the naming function `EnsureDotNetTypeClass`
uses to pick a CLOS class's symbol) recurses over `Type.GetGenericArguments()`:

```csharp
internal static string DotNetTypeDisplayName(Type t)
{
    if (!t.IsGenericType) return t.Name;
    var name = t.Name;
    int tick = name.IndexOf('`');
    if (tick >= 0) name = name.Substring(0, tick);
    var args = string.Join(",", t.GetGenericArguments().Select(DotNetTypeDisplayName));
    return name + "<" + args + ">";
}
```

For a **closed** instantiation (`typeof(Dictionary<string,int>)`), `GetGenericArguments()`
returns the closing type arguments (`String`, `Int32`), so the display name is
`Dictionary<String,Int32>` — distinct and readable per closing, exactly what DotCL 0.1.17 fixed.

For the **open generic type definition** itself
(`dotnet:resolve-type "System.Collections.Generic.Dictionary\`2"` — a bare
`Type.GetType`/`Assembly.GetType` lookup, never a closing — confirmed via
`Runtime.DotNet.cs`'s `ResolveDotNetType`/`SearchDotNetType`), `GetGenericArguments()` instead
returns the generic type **parameters** (`TKey`, `TValue`), which are themselves ordinary
(non-generic) `Type` objects with their own `.Name`. The resulting display name is
`Dictionary<TKey,TValue>` — a symbol that will **never** equal any real closed instance's
registered name. A `defmethod` built from
`#.(dotnet:class-for-type "System.Collections.Generic.Dictionary\`2")` therefore installs
against a CLOS class that no real `Dictionary<K,V>` object at runtime is ever an instance of:
the defmethod is syntactically valid but semantically dead — it will simply never fire.

This is not a regression introduced by 0.1.17; it was already true before (the prior 0.1.16
research doc documents the same fact under the old naming scheme — see its "Short answer" and
"Worked example" sections). 0.1.17 fixed the *closed-instantiation* naming collision but left
open-generic dispatch exactly where it was: unsupported. DotCL 0.1.17's "Appendix: Suggestions
for DotCL" (in the 0.1.16 notes doc) had three suggestions; 0.1.17 implemented #1
(`dotnet:class-for-type`) and #2 (class-object specializer support) but not #3 (an open-generic
marker class in the CPL) — this document expands #3 into a concrete design.

## Current mitigation in `dcl-packagegen`

`generate-batch-generics-file` (Version 41) detects a generic-arity `--defgeneric`-opted-in
class via `generic-arity-fq-name-p` (checks for .NET's backtick arity suffix in the
fully-qualified name) and **skips** emitting a dispatch block for it, replacing it with an
explanatory comment:

```lisp
;; System.Collections.Generic.Dictionary`2 (system-collections-generic-dictionary-2)
;; SKIPPED: System.Collections.Generic.Dictionary`2 is an open generic type definition -- DotCL cannot
;; dispatch a defmethod on it (its CLOS class is named from its own
;; type PARAMETERS, e.g. Dictionary<TKey,TValue>, which never matches
;; any real closed instance's registered name). See
;; doc/dispatch-on-open-generics.md.
```

This is correct and honest (no dead code silently emitted) but means `--defgeneric` simply
does not cover generic-arity classes at all today. The class's own ordinary package (e.g.
`system-collections-generic-dictionary-2`) is unaffected — only the *unified generic dispatch*
package (`csharp-generics`) omits it.

## Proposed fix: an open-generic marker class in the CPL

The core idea (suggestion #3 from the 0.1.16 notes doc, expanded here): when
`EnsureDotNetTypeClass` first encounters **any** closed instantiation of an open generic
definition, also register (once, lazily, on first encounter) a CLOS class for the **open
generic definition itself**, and insert it into every closed instantiation's class precedence
list (CPL) as a shared ancestor. A `defmethod` specializing on that marker class then fires for
*any* closing of the generic — directly answering "can it dispatch on the open type" with yes,
without disturbing per-closed-instantiation dispatch (an already-registered closed-instance
class keeps its own identity; the marker is purely an added ancestor).

### Sketch

```csharp
// Runtime.CLOS.cs, inside EnsureDotNetTypeClass, when `type` is generic and CLOSED
// (type.IsGenericType && !type.IsGenericTypeDefinition):
if (type.IsGenericType && !type.IsGenericTypeDefinition)
{
    var openDef = type.GetGenericTypeDefinition();
    var markerCls = EnsureDotNetTypeClass(openDef); // recursive call resolves/creates the
                                                      // open-definition's own marker class,
                                                      // memoized in _dotNetTypeRegistry keyed
                                                      // by the open Type object itself
    // ... insert markerCls into `cpl` (the new closed class's own CPL), positioned after
    // baseCls (the CLR base type chain) but before Object, mirroring how an interface
    // would be threaded in -- exact MOP placement TBD by DotCL's own CPL-linearization
    // rules.
}
```

The open generic type definition (`Dictionary\`2`) is itself a legitimate `Type` object
(`type.IsGenericTypeDefinition` is true for it), so `EnsureDotNetTypeClass(openDef)` recurses
into the *existing* non-generic path and gets a perfectly ordinary CLOS class — no new
machinery needed there. `DotNetTypeDisplayName(openDef)` already produces `Dictionary<TKey,TValue>`
for it today (since `GetGenericArguments()` on an open definition returns its own type
parameters) — this display name becomes meaningful for the first time under this proposal,
since a `defmethod` specializing on it would now actually match every closed instantiation.

### What this unblocks in `dcl-packagegen`

Once available, `generate-batch-generics-file`'s generic-arity guard could be lifted for
classes explicitly requesting this — likely via the *same* `#.(dotnet:class-for-type fq-name)`
call, since `fq-name` for a generic class is always the open definition's own bare name (per
Version 40's `GetTypeIdentityFullName` convention) — `dotnet:class-for-type` would simply need
to route an open-definition `Type`/name to the marker-class path above instead of erroring or
producing a class nothing is ever `typep` of. No change to `dcl-packagegen`'s own metadata
reflection or manifest schema would be required; only the generic-arity skip guard would be
removed.

## Alternatives considered

1. **A public wildcard-lookup API instead of CPL injection** — e.g.
   `dotnet:generic-definition-class-for-type`, returning a class that is *not* actually in any
   closed instantiation's CPL but that some new dispatch primitive treats specially (a
   "generic-family" specializer, analogous to CLOS's `eql` specializers but for "any instance of
   this parametric family"). This would require a new kind of specializer recognized by
   `compute-applicable-methods`/`compute-discriminating-function`, not just an ordinary
   `find-class`-style lookup — meaningfully more invasive than the CPL-injection approach, since
   ordinary CLOS class-based dispatch (which the 0.1.15 AMOP work already exposes hooks for,
   per DotCL's RELEASES.md) would need a genuinely new specializer *kind*, not just a new class.
   The CPL-injection approach reuses ordinary single-inheritance class dispatch entirely — no
   MOP changes to dispatch machinery itself, only to `EnsureDotNetTypeClass`'s registration
   logic. Rejected in favor of the simpler mechanism.
2. **Do nothing; require dispatch per-closed-instantiation.** Already the status quo (and what
   `dcl-packagegen`'s Version 41 skip-guard falls back to). Workable for code that only ever
   touches specific closings it can name in advance (mirroring the 0.1.16 notes doc's
   "Recommended robust pattern": construct the closed type via `dotnet:make-generic-type`,
   resolve its class, `eval` a defmethod against it) — but doesn't help
   `dcl-packagegen`'s batch-generation use case, where the whole point of `--defgeneric` is
   generation-time-complete coverage without hand-enumerating every closing a caller might use
   at runtime.

## Recommendation

Pursue the CPL-injection marker-class approach in DotCL. It is additive (no existing
`EnsureDotNetTypeClass` behavior changes for non-generic or already-closed types), requires no
new specializer machinery, and directly restores `--defgeneric`'s "opt in, get complete
dispatch coverage" contract for generic-arity classes — the same guarantee it already provides
for non-generic ones.
