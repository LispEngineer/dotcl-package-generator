# Detail Plan 03: Documentation Sync After the Modularization Refactor

* Part of the plan series from `doc/plan-fable-20260718.md` (section 3.7).
* Standalone; zero code change, zero version bump. Do early — every other plan's
  implementer benefits.
* Estimated scope: small (an afternoon).

## Goal

Bring all prose documentation in line with the July 2026 refactor (commit `6a47c35`)
that split the monolithic `assembly-package-generator.lisp` into the ten `apg-*.lisp`
modules and eleven `package-generator-tests-*.lisp` files. Today, `CLAUDE.md`,
`GEMINI.md`, and several `doc/`/`PLAN.md` passages still describe the old single-file
layout, including dead line-number references — actively misleading for both humans
and AI agents (which navigate this repo by its docs).

## Inventory of known-stale references (verify each; find more)

Run these to build the full worklist:

```sh
grep -rn "assembly-package-generator\.lisp" --include="*.md" .
grep -rn "assembly-package-generator\.lisp:[0-9]" --include="*.md" .
```

Known items from analysis:

1. **`CLAUDE.md`** — the "Architecture map" bullet for
   `assembly-package-generator.lisp` ("the code generator proper ...
   `generate-class-file` (~1000 lines; the bulk of the file)") describes a file that
   no longer exists. Also: "Bump `*generator-version*` (top of file)" — it now lives
   in `apg-naming.lisp`. Also the `make build` description lists
   `assembly-package-generator.lisp`, `package-generator-tests.lisp` as compiled
   sources — the `.asd` component list is now entirely different.
2. **`GEMINI.md`** — audit for the same (CLAUDE.md says "See also GEMINI.md"; keep the
   two consistent).
3. **`AGENTS.md`** — audit likewise.
4. **`PLAN.md`** — the "Clone a Boxed Struct" Implementation Options section cites
   `assembly-package-generator.lisp:1272`, `:202-213`, `:1468-1553`, `:543-578`,
   `:905`, `:1266-1271`. Per the user's standing rule (see auto-memory:
   PLAN.md is append/mark-DONE only — do not rewrite the original text), **do not
   edit those historical citations in place**; instead append a short dated note at
   the end of that section mapping old references to current locations (see mapping
   below).
5. **`doc/package-generator-dependencies.md`**, **`doc/generator-design-notes.md`**,
   **`doc/parents-and-interfaces-plan.md`**, **`doc/plan-v38.md`**, etc. — historical
   design docs may mention the old file. Do NOT rewrite history in the versioned
   design log; where a doc is *operative* (tells you where code lives today), fix it;
   where it is a dated historical record, leave it (optionally add a one-line
   "(since split into apg-*.lisp — see FILES.md)" note at first mention).
6. **`Makefile`** — the comment "The minor version tracks
   assembly-package-generator.lisp's internal `*generator-version*`" → now
   `apg-naming.lisp`.
7. **`RELEASES.md`** header — "see `assembly-package-generator.lisp`'s docstring" for
   generator version history → `*generator-version*`'s docstring in `apg-naming.lisp`.

## The replacement architecture map (for CLAUDE.md/GEMINI.md)

Replace the single `assembly-package-generator.lisp` bullet with a module map (verify
line counts/roles against current source before writing):

* `apg-naming.lisp` — `*generator-version*` (bump-here location + changelog
  docstring), `camel-to-kebab`, `type-fq-name-to-pkg-name`, `map-member-name`,
  `map-param-name`, `safe-symbol-token`, `escape-lisp-string`, `simple-type-name`.
* `apg-member-predicates.lisp` — clean/dirty/simple method+ctor predicates,
  `usable-default-p`, `classify-class-members` → `class-member-classification`
  struct (the single shared member-filtering walk).
* `apg-overload-signatures.lisp` — signature strings + docstring builders.
* `apg-overload-dispatch.lisp` — the Master Wrapper machinery:
  `format-param-type-check`, `resolvable-type-name-for-check`,
  generic-arity dispatch (`generic-arity-dispatch-mode` etc.),
  `generate-method-name-wrappers`. Largest and highest-risk module.
* `apg-immutability.lisp` — struct-boxing/shared-constant warning comment emitters.
* `apg-export-mirrors.lisp` — `compute-package-exports-and-shadows`,
  `event-wrapper-names`, `collect-class-instance-generics`.
* `apg-class-file-generator.lisp` — `generate-class-file` driver + per-section
  `emit-*` helpers (constructors, properties, fields, events, methods, extension
  methods, CLOS registration).
* `apg-batch-discovery.lisp` — `resolve-batch-entry`, metadata/reverse/extension
  indexes, `expand-related` (the six-direction discovery work queue).
* `apg-reexports-and-generics.lisp` — re-exports, `packages.lisp` and
  `csharp-generics.lisp` and utils-file generation.
* `apg-batch-orchestration.lisp` — `run-assembly-package-generator-batch` /
  `generate-assembly-packages-batch` / `.asd` generation.

Also update the test-suite description: Lisp unit tests live in
`package-generator-tests-*.lisp` (registered in `generator-tests.lisp`'s
`run-generator-tests`), not a single `package-generator-tests.lisp`.

## Method

1. Build the grep worklist; classify each hit as *operative* (fix) vs *historical*
   (leave, or annotate).
2. Cross-check every claim you write against the actual source (`grep -n "defun ..."`)
   — do not copy from this plan blindly; the code may have moved again
   (per `CLAUDE.md`: never assume files are unchanged between sessions).
3. Check `FILES.md` (created 2026-07-11, likely already correct) and treat it as the
   canonical per-file inventory; make CLAUDE.md's map summarize and link to it rather
   than duplicating detail.
4. Run `make check-parens` is unnecessary (no `.lisp` edits) — but run `make test`
   once to confirm nothing was accidentally touched.

## Acceptance criteria

* `grep -rn "assembly-package-generator.lisp" --include="*.md"` returns only
  historical-context mentions (design-note history, PLAN.md's original text with the
  appended mapping note, refactor references like "the former ...").
* CLAUDE.md's architecture map names the module that actually owns each concept a
  future session will search for: `*generator-version*`, `format-param-type-check`,
  `generate-class-file`, `expand-related`, `classify-class-members`.
* No `.lisp`, `.cs`, `.asd`, or `Makefile` *behavior* change (Makefile comment fix
  only). `RELEASES.md`: no entry needed (docs-only), or a one-line note — either is
  acceptable.
