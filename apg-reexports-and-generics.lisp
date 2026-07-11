;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Developed with Antigravity CLI (Gemini 3.5 Flash and 3.1 Pro)
;;;
;;; C# Assembly Lisp Package Generator -- ancestor re-exports and unified --defgeneric generics
;;; Split out of the former assembly-package-generator.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :assembly-package-generator)


(defparameter *reexport-excluded-symbols*
  '("<type>" "<type-str>" "<creation>" "<version>" "new")
  "Synthetic per-type symbols compute-package-exports-and-shadows always
   exports that must never be re-exported from an ancestor into a child
   package: they identify the ANCESTOR's own type/creation-timestamp/
   generator-version or construct an instance of the ANCESTOR itself, none
   of which a child logically inherits.")

(defun compute-reexports (child-exports ancestor-specs)
  "CHILD-EXPORTS is the child's own export list (strings, from
   compute-package-exports-and-shadows). ANCESTOR-SPECS is a list of
   (pkg-name exports shadows) lists, one per ancestor package the child may
   draw re-exports from, in ancestor-discovery order; EXPORTS/SHADOWS are
   that ancestor's own compute-package-exports-and-shadows results.

   Returns (values reexports skipped):
   REEXPORTS is a list of (pkg-name symbol-name needs-shadowing-import-p)
   lists to import (or shadowing-import) and export into the child, in
   first-seen order across ANCESTOR-SPECS.
   SKIPPED is a list of (symbol-name reason) pairs for comment generation,
   where REASON is :own (the child already declares this name -- child
   wins) or (:ambiguous pkg-name-list) (more than one ancestor exports this
   name, so none of them is re-exported; see doc/parents-and-interfaces-plan.md
   for why this is deliberately deferred to a comment rather than a renamed
   re-export)."
  (let ((order nil)
        (tally (make-hash-table :test #'equal))
        (shadow-flag (make-hash-table :test #'equal))
        (reexports nil)
        (skipped nil))
    (dolist (spec ancestor-specs)
      (destructuring-bind (pkg-name exports shadows) spec
        (dolist (sym exports)
          (unless (member sym *reexport-excluded-symbols* :test #'string=)
            (unless (gethash sym tally)
              (push sym order))
            (push pkg-name (gethash sym tally))
            (when (member sym shadows :test #'string=)
              (setf (gethash sym shadow-flag) t))))))
    (dolist (sym (nreverse order))
      (let ((pkgs (nreverse (gethash sym tally))))
        (cond
          ((member sym child-exports :test #'string=)
           (push (list sym :own) skipped))
          ((> (length pkgs) 1)
           (push (list sym (list :ambiguous pkgs)) skipped))
          (t
           (push (list (first pkgs) sym (gethash sym shadow-flag)) reexports)))))
    (values (nreverse reexports) (nreverse skipped))))

(defun emit-child-reexports (stream child-plist child-cprops child-matched-extensions ancestor-fqs fq->resolved)
  "Computes and writes CHILD-PLIST's re-export post-pass block to STREAM:
   the cl:shadowing-import/cl:import/cl:export calls drawing non-conflicting
   members from ANCESTOR-FQS (CHILD-PLIST's already-resolved ancestor
   fully-qualified-name list, from expand-related via
   GENERATE-ASSEMBLY-PACKAGES-BATCH's child-ancestor-fqs table), plus
   comments documenting any skipped (conflicting/ambiguous) names.
   FQ->RESOLVED maps every resolved class's fully-qualified-name back to its
   resolved-class plist, so each ancestor's own :constant-properties and
   :matched-extensions are used when computing its exports (an ancestor
   pulled in only for this purpose has neither, but an ancestor that was
   ALSO explicitly requested keeps its own -- see doc/plan-v38.md).
   CHILD-MATCHED-EXTENSIONS is CHILD-PLIST's own survivors (nil unless the
   child opted into --extension-methods), needed so an injected extension
   wrapper's name is correctly counted among the child's own exports (and
   therefore never re-exported a second time from an ancestor under the
   same name).
   See doc/parents-and-interfaces-plan.md: this whole block runs after every
   defpackage form in the file, so no topological ordering of those forms is
   required -- shadowing-import/import/export only need the ancestor
   packages and their exported symbols to already be interned (done at
   defpackage time), not their function bodies (loaded later, from each
   class's own .lisp file)."
  (let* ((child-fq (getf child-plist :fully-qualified-name))
         (child-pkg (type-fq-name-to-pkg-name child-fq)))
    (multiple-value-bind (child-exports child-shadows)
        (compute-package-exports-and-shadows child-plist child-cprops child-matched-extensions)
      (declare (ignore child-shadows))
      (let ((ancestor-specs
              (mapcar (lambda (anc-fq)
                        (let* ((anc-rc (gethash anc-fq fq->resolved))
                               (anc-plist (getf anc-rc :class-plist))
                               (anc-cprops (getf anc-rc :constant-properties))
                               (anc-matched-extensions (getf anc-rc :matched-extensions))
                               (anc-pkg (type-fq-name-to-pkg-name anc-fq)))
                          (multiple-value-bind (anc-exports anc-shadows)
                              (compute-package-exports-and-shadows anc-plist anc-cprops anc-matched-extensions)
                            (list anc-pkg anc-exports anc-shadows))))
                      ancestor-fqs)))
        (multiple-value-bind (reexports skipped) (compute-reexports child-exports ancestor-specs)
          (format stream ";;; ~A: re-exports inherited members from ~{~A~^, ~}~%"
                  child-pkg (remove-duplicates (mapcar #'first ancestor-specs) :test #'string= :from-end t))
          (dolist (skip skipped)
            (destructuring-bind (sym reason) skip
              (if (eq reason :own)
                  (format stream ";;; Skipped (~A declares its own): ~A~%" child-pkg sym)
                  (format stream ";;; Skipped (ambiguous across ancestors: ~{~A~^, ~}): ~A~%"
                          (second reason) sym))))
          (let ((shadowing-syms (remove-if-not #'third reexports))
                (plain-syms (remove-if #'third reexports)))
            (when shadowing-syms
              (format stream "(cl:shadowing-import '(~{~A~^ ~}) ':~A)~%"
                      (mapcar (lambda (r) (format nil "~A::~A" (first r) (second r))) shadowing-syms)
                      child-pkg))
            (when plain-syms
              (format stream "(cl:import '(~{~A~^ ~}) ':~A)~%"
                      (mapcar (lambda (r) (format nil "~A::~A" (first r) (second r))) plain-syms)
                      child-pkg))
            (when reexports
              (format stream "(cl:export '(~{~A~^ ~}) ':~A)~%"
                      (mapcar (lambda (r) (format nil "~A::~A" child-pkg (second r))) reexports)
                      child-pkg)))
          (format stream "~%"))))))

(defparameter *csharp-generics-package-name* "csharp-generics"
  "Name of the shared package holding every unified CLOS generic function
   whose defmethods dispatch on C# runtime type (the --defgeneric flag; see
   doc/make-everything-defgeneric.md). Sits alongside the existing
   csharp-assembly-utils shared package.")

(defun compute-defgeneric-model (all-resolved)
  "Aggregates the --defgeneric-opted-in subset of ALL-RESOLVED (every
   resolved-class plist in this batch -- generate-assembly-packages-batch's
   own flat list) into a plist for GENERATE-BATCH-GENERICS-FILE to install
   defmethods against (*CSHARP-GENERICS-PACKAGE-NAME*) -- see
   doc/make-everything-defgeneric.md. Returns nil if no class in
   ALL-RESOLVED has :defgeneric true (the whole feature is then a no-op: no
   package, no file, no .asd component):
     :classes       -- one entry per opted-in class, in ALL-RESOLVED order:
                       (:pkg-name .. :fq-name .. :method-names (...)
                        :setter-names (...)) -- see
                        collect-class-instance-generics.
     :method-names  -- the deduped union of every opted-in class's
                       method-names, in first-seen order.
     :setter-names  -- likewise for setter-names.
     :exports       -- the deduped union of :method-names and
                       :setter-names (a setter's exported symbol name is
                       the same as its getter's, so this is one list, not
                       two) -- the defpackage's :export list.
     :shadows       -- the subset of :exports colliding with a
                       :common-lisp external symbol, mirroring
                       compute-package-exports-and-shadows."
  (let ((opted-in (remove-if-not (lambda (rc) (getf rc :defgeneric)) all-resolved)))
    (when opted-in
      (let ((classes nil)
            (all-methods nil)
            (all-setters nil))
        (dolist (rc opted-in)
          (let* ((cls (getf rc :class-plist))
                 (fq-name (getf cls :fully-qualified-name))
                 (pkg-name (type-fq-name-to-pkg-name fq-name)))
            (multiple-value-bind (method-names setter-names)
                (collect-class-instance-generics cls (getf rc :constant-properties)
                                                  (getf rc :matched-extensions))
              (push (list :pkg-name pkg-name :fq-name fq-name
                          :method-names method-names :setter-names setter-names)
                    classes)
              (dolist (n method-names) (push n all-methods))
              (dolist (n setter-names) (push n all-setters)))))
        (setf classes (nreverse classes))
        (setf all-methods (remove-duplicates (nreverse all-methods) :test #'string= :from-end t))
        (setf all-setters (remove-duplicates (nreverse all-setters) :test #'string= :from-end t))
        (let ((exports (remove-duplicates (append all-methods all-setters) :test #'string= :from-end t))
              (shadows nil))
          (dolist (exp exports)
            (multiple-value-bind (sym status) (find-symbol (string-upcase exp) :common-lisp)
              (when (and sym (eq status :external))
                (push exp shadows))))
          (setf shadows (remove-duplicates (nreverse shadows) :test #'string= :from-end t))
          (list :classes classes :method-names all-methods :setter-names all-setters
                :exports exports :shadows shadows))))))

(defun emit-defgeneric-defpackage (stream pkg-name model flag-name doc-path)
  "Writes PKG-NAME's cl:defpackage form (plus its preceding source-file
   comment block) to STREAM if MODEL is non-nil, or nothing at all
   otherwise -- called by GENERATE-BATCH-PACKAGES-FILE for the
   *CSHARP-GENERICS-PACKAGE-NAME* package."
  (when model
    (format stream ";;; Source File: ~A.lisp~%" pkg-name)
    (format stream ";;; Purpose: unified CLOS generic functions dispatching on C# runtime~%")
    (format stream ";;; type, across every ~A-opted-in class in this batch~%" flag-name)
    (format stream ";;; (see ~A)~%" doc-path)
    (format stream "(cl:defpackage :~A~%" pkg-name)
    (format stream "  (:use :cl)~%")
    (when (getf model :shadows)
      (format stream "  (:shadow~%")
      (dolist (shad (getf model :shadows))
        (format stream "   #:~A~%" shad))
      (format stream "  )~%"))
    (format stream "  (:export~%")
    (dolist (exp (getf model :exports))
      (format stream "   #:~A~%" exp))
    (format stream "  ))~%~%")))

(defun generate-batch-packages-file (entries-with-resolved output-dir creation-time package-template-path
                                      child-ancestor-fqs &optional defgeneric-model)
  "Writes packages.lisp into OUTPUT-DIR: first the CSHARP-ASSEMBLY-UTILS
   defpackage form, copied verbatim from PACKAGE-TEMPLATE-PATH (a real,
   standalone-loadable .lisp file -- see csharp-assembly-utils-package.template.lisp),
   then one cl:defpackage per resolved class (from ENTRIES-WITH-RESOLVED, in
   the same command-line order GENERATE-BATCH-ASD-FILE consumes), each
   preceded by a comment block naming its source .lisp file, its C# class,
   and its constant properties. Individual class .lisp files no longer emit
   their own defpackage (see COMPUTE-PACKAGE-EXPORTS-AND-SHADOWS /
   GENERATE-CLASS-FILE); this file must be loaded before any of them, as
   well as before csharp-assembly-utils.lisp (GENERATE-BATCH-UTILS-FILE).

   After every defpackage form, if CHILD-ANCESTOR-FQS (a hash table mapping
   a child's fully-qualified-name to its expand-related-resolved ancestor
   fully-qualified-name list, built by GENERATE-ASSEMBLY-PACKAGES-BATCH) has
   any entries, a re-export post-pass follows (see EMIT-CHILD-REEXPORTS):
   one block per child with a non-empty ancestor list, importing and
   re-exporting each ancestor's non-conflicting members. See
   doc/parents-and-interfaces-plan.md.

   DEFGENERIC-MODEL, if non-nil (see COMPUTE-DEFGENERIC-MODEL), also emits
   the *CSHARP-GENERICS-PACKAGE-NAME* defpackage (its :export/:shadow lists
   coming straight from its model), right after the CSHARP-ASSEMBLY-UTILS
   defpackage and before any per-class one -- see
   doc/make-everything-defgeneric.md."
  (let ((output-file (merge-pathnames (make-pathname :name "packages" :type "lisp")
                                       (pathname (concatenate 'string output-dir "/"))))
        (fq->resolved (make-hash-table :test #'equal)))
    (dolist (pair entries-with-resolved)
      (dolist (rc (cdr pair))
        (setf (gethash (getf (getf rc :class-plist) :fully-qualified-name) fq->resolved) rc)))
    (with-open-file (stream output-file :direction :output :if-exists :supersede :if-does-not-exist :create)
      (format stream ";;; Generated automatically. Do not edit.~%")
      (format stream ";;; Generator Version: ~D~%" *generator-version*)
      (format stream ";;; Creation Date: ~A~%~%" creation-time)
      (format stream "(cl:in-package :cl-user)~%~%")
      (format stream ";;; Source File: csharp-assembly-utils.lisp~%")
      (format stream ";;; Purpose: shared runtime support for generated packages~%")
      (format stream "~A~%" (uiop:read-file-string package-template-path))
      (emit-defgeneric-defpackage stream *csharp-generics-package-name* defgeneric-model
                                   "--defgeneric" "doc/make-everything-defgeneric.md")
      (dolist (pair entries-with-resolved)
        (dolist (rc (cdr pair))
          (let* ((cls (getf rc :class-plist))
                 (cprops (getf rc :constant-properties))
                 (fq-name (getf cls :fully-qualified-name))
                 (pkg-name (type-fq-name-to-pkg-name fq-name)))
            (multiple-value-bind (exports shadows)
                (compute-package-exports-and-shadows cls cprops (getf rc :matched-extensions))
              (format stream ";;; Source File: ~A.lisp~%" pkg-name)
              (format stream ";;; C# Class: ~A~%" fq-name)
              (format stream ";;; Constant Properties: ~:[(none)~;~:*~{~A~^, ~}~]~%" cprops)
              (format stream "(cl:defpackage :~A~%" pkg-name)
              (format stream "  (:use :cl)~%")
              (when shadows
                (format stream "  (:shadow~%")
                (dolist (shad shadows)
                  (format stream "   #:~A~%" shad))
                (format stream "  )~%"))
              (format stream "  (:export~%")
              (dolist (exp exports)
                (format stream "   #:~A~%" exp))
              (format stream "  ))~%~%")))))

      (when (some (lambda (pair)
                    (some (lambda (rc)
                            (gethash (getf (getf rc :class-plist) :fully-qualified-name) child-ancestor-fqs))
                          (cdr pair)))
                  entries-with-resolved)
        (format stream ";;; ===== Re-exports from parent/interface packages =====~%~%")
        (dolist (pair entries-with-resolved)
          (dolist (rc (cdr pair))
            (let* ((cls (getf rc :class-plist))
                   (child-fq (getf cls :fully-qualified-name))
                   (ancestor-fqs (gethash child-fq child-ancestor-fqs)))
              (when ancestor-fqs
                (emit-child-reexports stream cls (getf rc :constant-properties)
                                       (getf rc :matched-extensions)
                                       ancestor-fqs fq->resolved)))))))
    output-file))

(defun generate-batch-utils-file (output-dir creation-time utils-template-path)
  "Writes csharp-assembly-utils.lisp into OUTPUT-DIR: the standard 3-line
   header followed by UTILS-TEMPLATE-PATH's content, copied verbatim (a
   real .lisp file -- see csharp-assembly-utils.template.lisp -- containing
   cl:in-package plus the csharp-overload-not-found condition). Must run
   after GENERATE-BATCH-PACKAGES-FILE, since this file's cl:in-package form
   needs the CSHARP-ASSEMBLY-UTILS package already defined in packages.lisp."
  (let ((output-file (merge-pathnames (make-pathname :name "csharp-assembly-utils" :type "lisp")
                                       (pathname (concatenate 'string output-dir "/")))))
    (with-open-file (stream output-file :direction :output :if-exists :supersede :if-does-not-exist :create)
      (format stream ";;; Generated automatically. Do not edit.~%")
      (format stream ";;; Generator Version: ~D~%" *generator-version*)
      (format stream ";;; Creation Date: ~A~%~%" creation-time)
      (format stream "~A~%" (uiop:read-file-string utils-template-path)))
    output-file))

(defun generate-batch-generics-file (output-dir creation-time defgeneric-model)
  "Writes *CSHARP-GENERICS-PACKAGE-NAME*.lisp into OUTPUT-DIR (one
   cl:defgeneric per DEFGENERIC-MODEL :method-names/:setter-names entry,
   plus a per-opted-in-class block of literal, ordinary top-level
   cl:defmethod forms), or does nothing (returns nil) if DEFGENERIC-MODEL
   is nil -- see COMPUTE-DEFGENERIC-MODEL and
   doc/make-everything-defgeneric.md. Must run after
   GENERATE-BATCH-PACKAGES-FILE (needs the package already defined in
   packages.lisp) and after every opted-in class's own .lisp file (each
   defmethod forwards to that class's own file's exported function).

   Every instance-method/getter generic is (name obj! cl:&rest args); every
   setter generic is ((cl:setf name) new-value obj! cl:&rest args) -- see
   collect-class-instance-generics. Each opted-in class contributes one
   plain top-level cl:defmethod per generic it participates in, forwarding
   via cl:apply to that class's own already-generated wrapper function.

   Each defmethod specializes on #.(dotnet:class-for-type \"<fq-name>\") --
   DotCL 0.1.17's dotnet:class-for-type, read-time-evaluated via #. and
   used directly as a defmethod specializer (both new in DotCL 0.1.17;
   Runtime.DotNet.cs's DotNetClassForType and cil-macros.lisp's defmethod
   specializer-parsing accepting a class object rather than only a class-
   name symbol). This resolves and registers the EXACT type named by
   FQ-NAME at read time and hands back its real, already-assigned CLOS
   class object -- no cl:eval, no cl:eval-when, no backquote, no runtime
   class-object lookup wrapped around a defmethod, AND immune to the
   pre-0.1.17 load-order-dependent simple-name/FullName naming race that
   the previous --defgeneric implementation (a literal
   dotcl-internal::|<simple-name>| symbol computed at generation time) had
   to document as an accepted collision caveat: since #.(dotnet:class-for-type
   ...) always resolves by FQ-NAME directly, never a guessed simple-name
   symbol, that caveat no longer applies (empirically confirmed against the
   Makefile smoke test's System.Threading.Timer/System.Timers.Timer
   same-simple-name pair -- both now dispatch correctly with no caveat
   comment). See doc/generator-design-notes.md's Version 41 section.

   GENERIC-ARITY-FQ-NAME-P classes (an open generic type definition, e.g.
   \"System.Collections.Generic.Dictionary`2\" -- the only form :--class
   accepts for a generic type) are SKIPPED, with an explanatory comment
   instead of a defmethod block: DotCL's DotNetTypeDisplayName names an
   open generic's CLOS class from its own type PARAMETERS (e.g.
   \"Dictionary<TKey,TValue>\"), which never matches any real closed
   instance's registered name, so a defmethod specializing on the open
   type would never fire. See doc/dispatch-on-open-generics.md."
  (when defgeneric-model
    (let ((output-file (merge-pathnames (make-pathname :name *csharp-generics-package-name* :type "lisp")
                                         (pathname (concatenate 'string output-dir "/"))))
          (classes (getf defgeneric-model :classes)))
      (with-open-file (stream output-file :direction :output :if-exists :supersede :if-does-not-exist :create)
        (format stream ";;; Generated automatically. Do not edit.~%")
        (format stream ";;; Generator Version: ~D~%" *generator-version*)
        (format stream ";;; Creation Date: ~A~%~%" creation-time)
        (format stream "(cl:in-package :~A)~%~%" *csharp-generics-package-name*)
        (format stream ";;; Unified CLOS generic functions dispatching on C# runtime type.~%")
        (format stream ";;; Each defmethod below specializes on #.(dotnet:class-for-type ...),~%")
        (format stream ";;; resolved and registered at read time (DotCL 0.1.17+ required) --~%")
        (format stream ";;; see doc/make-everything-defgeneric.md.~%~%")

        ;; One cl:defgeneric per unified method/getter name, documenting
        ;; which classes' own packages specialize it.
        (dolist (name (getf defgeneric-model :method-names))
          (let ((specializers (remove-if-not
                                (lambda (c) (member name (getf c :method-names) :test #'string=))
                                classes)))
            (format stream "(cl:defgeneric ~A (obj! cl:&rest args)~%" name)
            (format stream "  (:documentation \"Dispatches on the C# runtime type of OBJ!. Specialized by:~%")
            (dolist (c specializers)
              (format stream "~A: ~A (~A:~A)~%" (getf c :fq-name) name (getf c :pkg-name) name))
            (format stream "\"))~%~%")))

        ;; One cl:defgeneric per unified setter name.
        (dolist (name (getf defgeneric-model :setter-names))
          (let ((specializers (remove-if-not
                                (lambda (c) (member name (getf c :setter-names) :test #'string=))
                                classes)))
            (format stream "(cl:defgeneric (cl:setf ~A) (new-value obj! cl:&rest args)~%" name)
            (format stream "  (:documentation \"Dispatches on the C# runtime type of OBJ!. Specialized by:~%")
            (dolist (c specializers)
              (format stream "~A: (cl:setf ~A) (cl:setf (~A:~A ...))~%" (getf c :fq-name) name (getf c :pkg-name) name))
            (format stream "\"))~%~%")))

        ;; Per opted-in class: either a flat block of literal cl:defmethod
        ;; forms specializing on #.(dotnet:class-for-type fq-name), or (for
        ;; a generic-arity class) a skip comment -- see docstring above and
        ;; doc/dispatch-on-open-generics.md.
        (dolist (c classes)
          (let* ((pkg-name (getf c :pkg-name))
                 (fq-name (getf c :fq-name))
                 (method-names (getf c :method-names))
                 (setter-names (getf c :setter-names)))
            (format stream ";; ~A (~A)~%" fq-name pkg-name)
            (if (generic-arity-fq-name-p fq-name)
                (progn
                  (format stream ";; SKIPPED: ~A is an open generic type definition -- DotCL cannot~%" fq-name)
                  (format stream ";; dispatch a defmethod on it (its CLOS class is named from its own~%")
                  (format stream ";; type PARAMETERS, e.g. Dictionary<TKey,TValue>, which never matches~%")
                  (format stream ";; any real closed instance's registered name). See~%")
                  (format stream ";; doc/dispatch-on-open-generics.md.~%~%"))
                (let ((spec (format nil "#.(dotnet:class-for-type ~S)" fq-name)))
                  (dolist (name method-names)
                    (format stream "(cl:defmethod ~A ((obj! ~A) cl:&rest args)~%" name spec)
                    (format stream "  (cl:apply (cl:function ~A:~A) obj! args))~%" pkg-name name))
                  (dolist (name setter-names)
                    (format stream "(cl:defmethod (cl:setf ~A) (new-value (obj! ~A) cl:&rest args)~%" name spec)
                    (format stream "  (cl:apply (cl:function (cl:setf ~A:~A)) new-value obj! args))~%" pkg-name name))
                  (format stream "~%"))))))
      output-file)))
