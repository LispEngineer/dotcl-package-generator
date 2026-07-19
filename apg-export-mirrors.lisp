;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Developed with Antigravity CLI (Gemini 3.5 Flash and 3.1 Pro)
;;;
;;; C# Assembly Lisp Package Generator -- package export-list computation shared with generate-class-file
;;; Split out of the former assembly-package-generator.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :assembly-package-generator)


(defun class-member-names-excluding-events (classification)
  "Returns every Lisp name a class's non-event members (constructors, fields,
   properties, methods) would produce, given CLASSIFICATION (a
   class-member-classification -- see classify-class-members).
   compute-package-exports-and-shadows, collect-class-instance-generics, and
   generate-class-file each call classify-class-members once and pass the
   same struct here, so the three can never disagree on an event's
   collision-check TAKEN-NAMES."
  (let ((names nil)
        (literal-fields (cmc-literal-fields classification))
        (pure-const-fields (cmc-pure-const-fields classification))
        (dynamic-const-fields (cmc-dynamic-const-fields classification))
        (instance-fields (cmc-instance-fields classification))
        (mutable-static-fields (cmc-mutable-static-fields classification))
        (pure-const-props (cmc-pure-const-props classification))
        (dynamic-const-props (cmc-dynamic-const-props classification))
        (writeable-static-props (cmc-writeable-static-props classification))
        (instance-prop-groups (cmc-instance-prop-groups classification))
        (method-groups (cmc-method-groups classification))
        (out-method-groups (cmc-out-method-groups classification)))
    (when (> (length (cmc-clean-ctors classification)) 0) (push "new" names))
    (dolist (f literal-fields) (push (format nil "+~A+" (camel-to-kebab (getf f :name))) names))
    (dolist (f pure-const-fields) (push (format nil "+~A+" (camel-to-kebab (getf f :name))) names))
    (dolist (f dynamic-const-fields) (push (map-member-name (getf f :name)) names))
    (dolist (f instance-fields) (push (map-member-name (getf f :name)) names))
    (dolist (f mutable-static-fields) (push (map-member-name (getf f :name)) names))
    (dolist (p pure-const-props) (push (format nil "+~A+" (camel-to-kebab (getf p :name))) names))
    (dolist (p dynamic-const-props) (push (map-member-name (getf p :name)) names))
    (dolist (p writeable-static-props)
      (let* ((pname (map-member-name (getf p :name)))
             (readable (getf p :readable)))
        (push (if readable pname (format nil "set-~A" pname)) names)))
    (dolist (group instance-prop-groups)
      (let ((props (cdr group)))
        (when (= (length props) 1)
          (let* ((p (first props))
                 (pname (map-member-name (getf p :name)))
                 (readable (getf p :readable)))
            (push (if readable pname (format nil "set-~A" pname)) names)))))
    (dolist (group method-groups)
      (let* ((name (car group))
             (clean-methods (remove-if-not #'clean-method-p (cdr group)))
             (kebab-name (map-member-name name))
             (static-clean (remove-if-not (lambda (m) (getf m :is-static)) clean-methods))
             (instance-clean (remove-if-not (lambda (m) (not (getf m :is-static))) clean-methods))
             (static-count (length static-clean))
             (instance-count (length instance-clean))
             (mixed-mode-p (and (> static-count 0) (> instance-count 0))))
        (cond
          (mixed-mode-p
           (let ((static-kebab-name (concatenate 'string kebab-name "*")))
             (dolist (n (method-name-wrapper-names instance-clean kebab-name)) (push n names))
             (dolist (n (method-name-wrapper-names static-clean static-kebab-name)) (push n names))))
          ((> static-count 0)
           (dolist (n (method-name-wrapper-names static-clean kebab-name)) (push n names)))
          ((> instance-count 0)
           (dolist (n (method-name-wrapper-names instance-clean kebab-name)) (push n names))))))
    (dolist (group out-method-groups)
      (dolist (n (out-method-group-names (car group) (cdr group) method-groups)) (push n names)))
    names))

(defun event-wrapper-names (event-name taken-names)
  "Returns (values add-name remove-name) for EVENT-NAME, given TAKEN-NAMES (every
   other already-decided name in this class -- see
   class-member-names-excluding-events -- plus any add-/remove- names already
   assigned to earlier events in this same class). Escalates through three tiers
   until landing on a pair that collides with nothing in TAKEN-NAMES:
     1. add-<event>/remove-<event>                (the common case)
     2. add-<event>-event/remove-<event>-event     (event collides with e.g. a
                                                     same-named method, such as an
                                                     AddClick() alongside a Click event)
     3. add-<event>!/remove-<event>!               (guaranteed unique: C# cannot emit
                                                     '!' in an identifier, the same
                                                     by-construction guarantee obj! and
                                                     quote!/function!/t!/nil! already
                                                     rely on -- falls back to the
                                                     shorter tier-1 base with '!' rather
                                                     than the tier-2 '-event' name,
                                                     since '!' alone already guarantees
                                                     uniqueness)
   Tier 3 is reached only if a class independently declares members named, absurdly,
   both AddClick() and AddClickEvent() alongside a Click event -- vanishingly
   unlikely, but unlike tier 2, tier 3 requires no such assumption: it is unique by
   construction."
  (let* ((base (map-member-name event-name))
         (tier1-add (format nil "add-~A" base))
         (tier1-remove (format nil "remove-~A" base))
         (tier2-add (format nil "add-~A-event" base))
         (tier2-remove (format nil "remove-~A-event" base)))
    (cond
      ((not (or (member tier1-add taken-names :test #'string=)
                (member tier1-remove taken-names :test #'string=)))
       (values tier1-add tier1-remove))
      ((not (or (member tier2-add taken-names :test #'string=)
                (member tier2-remove taken-names :test #'string=)))
       (values tier2-add tier2-remove))
      (t (values (format nil "~A!" tier1-add) (format nil "~A!" tier1-remove))))))

(defun compute-package-exports-and-shadows (class-plist constant-properties-list &optional matched-extensions)
  "Returns (values exports shadows) for CLASS-PLIST given
   CONSTANT-PROPERTIES-LIST, deduped, with CL-symbol conflicts detected in
   SHADOWS. This mirrors the field/property/method-group walk
   generate-class-file performs for its own body generation, but exists
   separately so packages.lisp (via generate-batch-packages-file) can build
   each class's defpackage form without generate-class-file emitting one
   itself. MATCHED-EXTENSIONS (see compute-matched-extensions-for-class,
   nil unless this class opted into --extension-methods -- Version 38,
   doc/plan-v38.md), when supplied, contributes each surviving injected
   extension wrapper's own Lisp name to EXPORTS, exactly as generate-
   class-file emits it, so the two can never disagree on a class's actual
   export list."
  (let* ((classification (classify-class-members class-plist constant-properties-list))
         (literal-fields (cmc-literal-fields classification))
         (pure-const-fields (cmc-pure-const-fields classification))
         (dynamic-const-fields (cmc-dynamic-const-fields classification))
         (instance-fields (cmc-instance-fields classification))
         (mutable-static-fields (cmc-mutable-static-fields classification))
         (pure-const-props (cmc-pure-const-props classification))
         (dynamic-const-props (cmc-dynamic-const-props classification))
         (instance-prop-groups (cmc-instance-prop-groups classification))
         (writeable-static-props (cmc-writeable-static-props classification))
         (method-groups (cmc-method-groups classification))
         (out-method-groups (cmc-out-method-groups classification))
         (clean-ctor-count (length (cmc-clean-ctors classification)))
         (instance-events (cmc-instance-events classification))
         (exports nil)
         (shadows nil))

    ;; Collect all exports
    (push "<type>" exports)
    (push "<type-str>" exports)
    (push "<creation>" exports)
    (push "<version>" exports)

    ;; Collect constructor exports
    (when (> clean-ctor-count 0)
      (push "new" exports))

    (dolist (f literal-fields)
      (push (format nil "+~A+" (camel-to-kebab (getf f :name))) exports))
    (dolist (f pure-const-fields)
      (push (format nil "+~A+" (camel-to-kebab (getf f :name))) exports))
    (dolist (f dynamic-const-fields)
      (push (map-member-name (getf f :name)) exports))
    ;; Public instance fields: a getter is always exported (all public
    ;; instance fields are readable); the setf-able name is the same
    ;; symbol, so it needs no separate export entry -- omitted only when
    ;; the field is read-only (:init-only), matching how instance
    ;; properties only export a plain setf-able name when :writeable.
    (dolist (f instance-fields)
      (push (map-member-name (getf f :name)) exports))
    ;; Plain mutable static fields: always both readable and writeable, so
    ;; the getter/setf-able name is always exported (no set-name variant,
    ;; matching how instance fields never need one either).
    (dolist (f mutable-static-fields)
      (push (map-member-name (getf f :name)) exports))
    (dolist (p pure-const-props)
      (push (format nil "+~A+" (camel-to-kebab (getf p :name))) exports))
    (dolist (p dynamic-const-props)
      (push (map-member-name (getf p :name)) exports))
    ;; Writeable static properties: mirrors the instance-property-group
    ;; export logic below (plain name if readable, set-name if write-only),
    ;; but static properties are never indexers so no grouping is needed.
    (dolist (p writeable-static-props)
      (let* ((pname (map-member-name (getf p :name)))
             (readable (getf p :readable)))
        (if readable
            (push pname exports)
            (push (format nil "set-~A" pname) exports))))
    (dolist (group instance-prop-groups)
      (let ((props (cdr group)))
        ;; A group with more than one property plist is an overloaded
        ;; indexer (this[...] with distinct index-parameter signatures),
        ;; which is not yet supported (see generate-class-file); skip it
        ;; here too so packages.lisp never exports a function that
        ;; generate-class-file won't actually define.
        (when (= (length props) 1)
          (let* ((p (first props))
                 (pname (map-member-name (getf p :name)))
                 (readable (getf p :readable)))
            (if readable
                (push pname exports)
                (push (format nil "set-~A" pname) exports))))))
    ;; Collect method exports from method groups. Mirrors
    ;; generate-method-name-wrappers' own naming exactly (via
    ;; method-name-wrapper-names) so a method name split into multiple
    ;; generic-arity-suffixed functions (e.g. Enumerable.Aggregate's arity
    ;; 1/2/3 overloads) exports every one of them, not just a bare name.
    (dolist (group method-groups)
      (let* ((name (car group))
             (clean-methods (remove-if-not #'clean-method-p (cdr group)))
             (kebab-name (map-member-name name))
             (static-clean (remove-if-not (lambda (m) (getf m :is-static)) clean-methods))
             (instance-clean (remove-if-not (lambda (m) (not (getf m :is-static))) clean-methods))
             (static-count (length static-clean))
             (instance-count (length instance-clean))
             (mixed-mode-p (and (> static-count 0) (> instance-count 0))))
        (cond
          (mixed-mode-p
           (let ((static-kebab-name (concatenate 'string kebab-name "*")))
             (dolist (n (method-name-wrapper-names instance-clean kebab-name)) (push n exports))
             (dolist (n (method-name-wrapper-names static-clean static-kebab-name)) (push n exports))))
          ((> static-count 0)
           (dolist (n (method-name-wrapper-names static-clean kebab-name)) (push n exports)))
          ((> instance-count 0)
           (dolist (n (method-name-wrapper-names instance-clean kebab-name)) (push n exports))))))

    ;; Collect out-only method exports (doc/plan-fable-detail-05.md) --
    ;; mirrors emit-out-methods' own naming exactly (via
    ;; out-method-group-names) so a class's out-only overloads are always
    ;; exported under the same name(s) generate-class-file actually defines.
    (dolist (group out-method-groups)
      (dolist (n (out-method-group-names (car group) (cdr group) method-groups)) (push n exports)))

    ;; Collect event exports (add-X/remove-X pairs). Processed last so
    ;; event-wrapper-names' collision check sees every other member's
    ;; already-decided export name; each event's chosen add-/remove- names
    ;; are pushed into EXPORTS before the next event is resolved, so two
    ;; colliding events in the same class also disambiguate against each
    ;; other, not just against non-event members.
    (dolist (e instance-events)
      (multiple-value-bind (add-name remove-name) (event-wrapper-names (getf e :name) exports)
        (push add-name exports)
        (push remove-name exports)))

    ;; Collect injected extension-method wrapper exports (Version 38). These
    ;; already survived compute-matched-extensions-for-class's own-member
    ;; collision check (against this exact export set, sans extensions), so
    ;; no further collision handling is needed here -- just export them.
    (dolist (ext matched-extensions)
      (push (map-member-name (getf (first ext) :name)) exports))

    ;; Remove duplicates from exports while preserving order
    (setf exports (remove-duplicates (nreverse exports) :test #'string= :from-end t))

    ;; Identify exported symbols that conflict with CL and must be shadowed
    (dolist (exp exports)
      (multiple-value-bind (sym status) (find-symbol (string-upcase exp) :common-lisp)
        (when (and sym (eq status :external))
          (push exp shadows))))
    ;; Remove duplicates from shadows while preserving order
    (setf shadows (remove-duplicates (nreverse shadows) :test #'string= :from-end t))

    (values exports shadows)))

(defun collect-class-instance-generics (class-plist constant-properties-list &optional matched-extensions)
  "Returns (values method-names setter-names) -- the wrapper names
   CLASS-PLIST's own generated package exports whose Lisp signature begins
   with obj! as the sole/first required argument, and which are therefore
   eligible to be folded into the shared CSHARP-GENERICS unification (see
   doc/make-everything-defgeneric.md and generate-batch-generics-file).
   METHOD-NAMES covers instance methods, instance property/field getters,
   instance indexer getters, instance event add-X/remove-X pairs (each
   (name obj! &rest args)), and injected extension-method wrappers (also
   (name obj! &rest args) -- see MATCHED-EXTENSIONS below); SETTER-NAMES
   covers the (cl:setf name) counterpart for writeable instance
   properties/fields/indexers.
   Deliberately excludes: static members (no obj! receiver -- see
   doc/make-everything-defgeneric.md's excluded categories),
   generic/type-parameterized instance methods (their wrapper's lambda
   list puts the type argument(s) before obj!, so obj! is not the leading
   argument), overloaded indexers (already unimplemented by
   generate-class-file itself, so no wrapper function exists to forward
   to), and instance out-only methods (cmc-out-method-groups,
   doc/plan-fable-detail-05.md) -- deliberately excluded rather than
   included: a --defgeneric dispatch defmethod's body is just a forwarding
   call to the underlying obj!-first wrapper, and CL does propagate that
   call's multiple values through as the defmethod's own return values, but
   this hasn't been separately verified against DotCL's generic-function
   dispatch machinery, so out-only methods are left out of unification for
   this v1 pending that verification (a follow-up, not a correctness bug --
   an out-only method's own directly-generated wrapper is unaffected either
   way).
   Independently filters FIELDS/PROPERTIES/METHODS the same way
   generate-class-file and compute-package-exports-and-shadows do (this
   file's existing duplication convention -- see
   class-member-names-excluding-events's docstring), but reuses
   map-member-name/method-name-wrapper-names so the actual NAME computation
   can never drift from what those two functions emit.
   CONSTANT-PROPERTIES-LIST (the same split constant-properties-list
   compute-package-exports-and-shadows/generate-class-file take) is
   required here too: resolving an event's add-X/remove-X name requires
   the exact same non-event taken-names set those two functions compute
   (via CLASS-MEMBER-NAMES-EXCLUDING-EVENTS) -- including the
   constant-vs-non-constant field/property split, which depends on
   CONSTANT-PROPERTIES-LIST -- so EVENT-WRAPPER-NAMES' three-tier collision
   escalation (add-X/remove-X -> add-X-event/remove-X-event -> add-X!/
   remove-X!) can never choose a different tier than what generate-class-
   file actually emits. MATCHED-EXTENSIONS (from
   compute-matched-extensions-for-class, nil unless this class opted into
   --extension-methods -- Version 38, doc/plan-v38.md) is folded into
   method-names verbatim (never setter-names -- an injected extension
   wrapper is never a (cl:setf ...) counterpart of anything)."
  (let* ((classification (classify-class-members class-plist constant-properties-list))
         (instance-fields (cmc-instance-fields classification))
         (instance-prop-groups (cmc-instance-prop-groups classification))
         (method-groups (cmc-method-groups classification))
         (instance-events (cmc-instance-events classification))
         (method-names nil)
         (setter-names nil))
    ;; Public instance fields.
    (dolist (f instance-fields)
      (let ((fname (map-member-name (getf f :name))))
        (push fname method-names)
        (unless (getf f :init-only)
          (push fname setter-names))))
    ;; Instance properties/indexers -- single-signature groups only
    ;; (an overloaded indexer has no generated wrapper to forward to).
    (dolist (group instance-prop-groups)
      (let ((props (cdr group)))
        (when (= (length props) 1)
          (let* ((p (first props))
                 (pname (map-member-name (getf p :name)))
                 (readable (getf p :readable))
                 (writeable (getf p :writeable)))
            (when readable (push pname method-names))
            (when writeable (push pname setter-names))))))
    ;; Instance methods -- only the non-generic overloads of each method
    ;; name, since a generic method's wrapper puts its type argument(s)
    ;; before obj!, disqualifying it from the uniform (name obj! &rest
    ;; args) shape every generic method here relies on.
    (dolist (group method-groups)
      (let* ((name (car group))
             (clean-methods (remove-if-not #'clean-method-p (cdr group)))
             (instance-clean (remove-if-not (lambda (m) (not (getf m :is-static))) clean-methods))
             (non-generic-instance-clean (remove-if (lambda (m) (getf m :is-generic)) instance-clean))
             (kebab-name (map-member-name name)))
        (when non-generic-instance-clean
          (dolist (n (method-name-wrapper-names non-generic-instance-clean kebab-name))
            (push n method-names)))))
    ;; Instance events (add-X/remove-X pairs) -- both names go into
    ;; method-names, since neither is a (cl:setf ...) counterpart of the
    ;; other; both are plain (name obj! handler) functions. Resolved last,
    ;; against the full non-event taken-names set (mirroring
    ;; generate-class-file's own "Instance Events" block and
    ;; compute-package-exports-and-shadows), so this can never choose a
    ;; different collision-escalation tier than what's actually emitted.
    (let ((all-other-names (class-member-names-excluding-events classification)))
      (dolist (e instance-events)
        (multiple-value-bind (add-name remove-name)
            (event-wrapper-names (getf e :name) all-other-names)
          (push add-name all-other-names)
          (push remove-name all-other-names)
          (push add-name method-names)
          (push remove-name method-names))))
    ;; Injected extension-method wrappers (Version 38) -- always obj!-first
    ;; instance-style, so always eligible.
    (dolist (ext matched-extensions)
      (push (map-member-name (getf (first ext) :name)) method-names))
    (values (remove-duplicates (nreverse method-names) :test #'string= :from-end t)
            (remove-duplicates (nreverse setter-names) :test #'string= :from-end t))))
