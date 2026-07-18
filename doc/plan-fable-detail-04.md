# Detail Plan 04: Document Silently-Dropped Generic-Type-Parameter Members

* Part of the plan series from `doc/plan-fable-20260718.md` (section 3.2).
* Standalone. Changes generated-output shape → **bump `*generator-version*`**
  (`apg-naming.lisp`) with a changelog docstring line, plus a
  `doc/generator-design-notes.md` section and `RELEASES.md` entry per repo convention.
* Estimated scope: small-medium.
* This is the *visibility* fix only. Actually supporting these members is Plan 17's
  investigation (closed-generic instance dispatch) — deliberately out of scope here.

## Goal

Members that mention the **declaring generic type's own type parameter** (e.g.
`List<T>.Add(T item)`, `Dictionary<K,V>.ContainsKey(K key)`) are today dropped with
**no trace whatsoever** in the generated package. A user of
`system-collections-generic-list-1` sees no `add` and has no way to know why. Fix:
emit the same style of documenting comment that dirty (`ref`/`out`/`params`) overloads
already get, listing every skipped member with its signature and the reason. This
honors the project's own stated principle (`FEATURES.md`: "silent omission is worse
than a documented skip").

## Where the drops happen (current code)

The metadata stage does NOT drop these — `AssemblyToLispy.cs` reflects all members;
an unresolved type parameter appears in `:type`/`:return-type` as a `!`-marked token
(`generic-type-p` in `apg-member-predicates.lisp` tests for `#\!`). The drops are all
Lisp-side:

1. **`classify-class-members`** (`apg-member-predicates.lisp`):
   `non-operator-non-accessor-methods` filters out any method whose `:return-type` or
   any parameter `:type` satisfies `generic-type-p` — these methods never enter
   `method-groups`, hence never reach `emit-methods`, never get a comment.
2. **`clean-method-p` / `simple-method-p`**: also reject `generic-type-p` params —
   but methods failing only there while passing the classify filter would land in the
   dirty path; the classify-level drop (item 1) happens first, so it is the silent
   one.
3. **Audit required — properties, fields, events, constructors, indexers:** determine
   what currently happens to e.g. `List<T>.this[int] → T` (indexer with generic value
   type), a field of type `T`, an event of a generic delegate type, a constructor
   taking `T`. Grep each `emit-*` path in `apg-class-file-generator.lisp` and the
   predicates for `generic-type-p` usage; any member kind that generates *broken*
   code (a wrapper that can't work) rather than being dropped is a separate bug —
   note it in the design-notes section and either fix to skip-with-comment in this
   change or file it in `PLAN.md`.
   (`clean-constructor-p` already rejects `generic-type-p` params → such ctors flow
   into neither clean nor dirty lists → also silently dropped; include them.)

## Design

### 1. Capture instead of discard

In `classify-class-members`, split the current filter into two lists:

* `method-groups` — unchanged semantics.
* New classification slot `open-generic-methods` on
  `class-member-classification` (`cmc-open-generic-methods`): every
  non-operator/non-accessor method excluded because `:return-type` or a parameter
  `:type` is `generic-type-p`. Preserve metadata order.

Similarly, if the audit (item 3 above) finds silently-dropped constructors
(`generic-type-p` param, neither clean nor dirty), add
`open-generic-ctors`; same for any other member kind found.

### 2. Emit the comment block

In `emit-methods` (`apg-class-file-generator.lisp`) — or a new small
`emit-open-generic-skips` helper called from `generate-class-file` right after the
methods section — emit, when the list is non-empty:

```lisp
;; The following C# members mention the declaring generic type's own type
;; parameter(s) (e.g. T in List<T>) and are not yet supported -- no wrapper
;; is generated. See FEATURES.md's "Unsupported Features" section.
;;   Add(!0 item) -> System.Void
;;   ...
```

Reuse `method-signature-str` / `constructor-signature-str`
(`apg-overload-signatures.lisp`) for the signature text so the format matches the
existing dirty-overload comments exactly. Note: those signature strings will show the
raw `!0`-style tokens from the metadata; if a friendlier rendering is cheap (the
metadata may carry the original `T`-style name — check `doc/assembly-to-lispy.md`'s
schema for how type parameters are spelled in `:type`), prefer it, but do not build a
reverse-mapping just for cosmetics.

Placement decision: one consolidated block (recommended — mirrors the dirty-ctor
block's placement convention) rather than interleaved per-name.

### 3. Version + docs

* Bump `*generator-version*` (→ next integer) in `apg-naming.lisp`, add changelog
  docstring line.
* `doc/generator-design-notes.md`: new version section — what was silently dropped,
  where, and the audit's findings for non-method member kinds.
* `FEATURES.md`: update the "Unsupported Features" first bullet ("A generic type's own
  type parameters") — it currently says "silently excluded ... with no comment";
  change to describe the new documented-skip behavior.
* `RELEASES.md`: new entry; bump CLI `VERSION` (minor) in `dotcl-packagegen.asd`
  keeping Makefile/asd lockstep per `BUILD.md`.

## Testing

1. **Unit tests** (`package-generator-tests-overload-classification.lisp` or a new
   file): mock class plist with a method taking a `!0`-typed parameter → assert it
   lands in `cmc-open-generic-methods` and NOT in `method-groups`; mock with a
   `!0` return type likewise; assert a normal method is unaffected.
2. **Codegen test** (`package-generator-tests-property-field-codegen.lisp` pattern:
   generate into a string stream): assert the emitted class text contains the skip
   comment listing the method, and contains no `defun` for it.
3. **Smoke test**: `make test` — the checked-in `cspackages-test/` diff is itself the
   review artifact: `system-collections-generic-list-1.lisp`,
   `system-collections-generic-dictionary-2.lisp`, and the `ValueTuple` files should
   gain skip-comment blocks naming `Add`, `ContainsKey`, etc. Eyeball that diff
   carefully; it is the acceptance evidence.
4. `make check-parens` after all Lisp edits.

## Acceptance criteria

* Every member dropped for open-generic-type-parameter reasons appears in exactly one
  comment block in its class's generated file; zero behavior change to any generated
  wrapper.
* The audit's conclusion for properties/fields/events/constructors/indexers is
  written down in the design-notes section (even if the answer is "already handled" /
  "separately broken, filed in PLAN.md").
* Full `make test` green; `cspackages-test/` diff shows only added comments (plus
  version-number lines).
