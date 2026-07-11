;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite -- Parents/Interfaces Upward-Graph Export cluster.
;;; Split out of the former package-generator-tests.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :package-generator-tests)

(defun run-parents-interfaces-tests ()
  (format *error-output* "--- Running Parents/Interfaces Upward-Graph Export Tests ---~%")

    ;; 7. Parents and interfaces: expand-related's own internal multi-hop walk
    ;;    resolves the full superclass chain and interfaces in ONE call
    ;;    across a global metadata index (build-metadata-index), as used by
    ;;    generate-assembly-packages-batch for --export-parents/
    ;;    --export-interfaces/--export-object. (downward-discovered/
    ;;    subclass-index/implementer-index are exercised separately in
    ;;    section 15 below -- pass nil/empty tables here since these tests
    ;;    only exercise the upward directions.)
  (let* ((object-plist '(:fully-qualified-name "System.Object" :kind :class :superclass nil :interfaces nil))
           (base-plist '(:fully-qualified-name "Fixture.Base" :kind :class
                         :superclass "System.Object" :interfaces ("Fixture.IBase")))
           (mid-plist '(:fully-qualified-name "Fixture.Mid" :kind :class
                        :superclass "Fixture.Base" :interfaces ("Fixture.IMid")))
           (derived-plist '(:fully-qualified-name "Fixture.Derived" :kind :class
                            :superclass "Fixture.Mid" :interfaces ("Fixture.IDerived")))
           (ibase-plist '(:fully-qualified-name "Fixture.IBase" :kind :interface :superclass nil :interfaces nil))
           (imid-plist '(:fully-qualified-name "Fixture.IMid" :kind :interface :superclass nil :interfaces nil))
           (iderived-plist '(:fully-qualified-name "Fixture.IDerived" :kind :interface :superclass nil :interfaces nil))
           (owning-entry (list :assembly-name "Fixture.dll"))
           (index (let ((tbl (make-hash-table :test #'equal)))
                    (dolist (p (list object-plist base-plist mid-plist derived-plist
                                     ibase-plist imid-plist iderived-plist))
                      (setf (gethash (getf p :fully-qualified-name) tbl) (cons p owning-entry)))
                    tbl))
           (no-subclass-index (make-hash-table :test #'equal))
           (no-implementer-index (make-hash-table :test #'equal)))

      ;; 7.1 export-parents alone walks the superclass chain, excluding System.Object by default.
      (multiple-value-bind (ancestors downward missing)
          (assembly-package-generator::expand-related derived-plist t nil nil nil nil nil
                                                        index no-subclass-index no-implementer-index)
        (declare (ignore downward))
        (assert-test missing nil
                    "expand-related finds no missing ancestors when the full chain is in the index")
        (assert-test (mapcar (lambda (a) (getf (car a) :fully-qualified-name)) ancestors)
                    '("Fixture.Mid" "Fixture.Base")
                    "expand-related (export-parents only) walks the superclass chain, excluding System.Object by default"))

      ;; 7.2 export-object also includes System.Object at the top of the chain.
      (multiple-value-bind (ancestors downward missing)
          (assembly-package-generator::expand-related derived-plist t nil t nil nil nil
                                                        index no-subclass-index no-implementer-index)
        (declare (ignore downward missing))
        (assert-test (mapcar (lambda (a) (getf (car a) :fully-qualified-name)) ancestors)
                    '("Fixture.Mid" "Fixture.Base" "System.Object")
                    "expand-related includes System.Object when export-object is true"))

      ;; 7.3 export-interfaces alone walks only the interfaces list, not the superclass chain.
      (multiple-value-bind (ancestors downward missing)
          (assembly-package-generator::expand-related derived-plist nil t nil nil nil nil
                                                        index no-subclass-index no-implementer-index)
        (declare (ignore downward missing))
        (assert-test (mapcar (lambda (a) (getf (car a) :fully-qualified-name)) ancestors)
                    '("Fixture.IDerived")
                    "expand-related (export-interfaces only) does not walk the superclass chain"))

      ;; 7.4 both flags together walk both graphs, recursing into each newly-found ancestor's own edges too.
      (multiple-value-bind (ancestors downward missing)
          (assembly-package-generator::expand-related derived-plist t t nil nil nil nil
                                                        index no-subclass-index no-implementer-index)
        (declare (ignore downward missing))
        (assert-test (sort (mapcar (lambda (a) (getf (car a) :fully-qualified-name)) ancestors) #'string<)
                    (sort (list "Fixture.Mid" "Fixture.Base" "Fixture.IDerived" "Fixture.IMid" "Fixture.IBase") #'string<)
                    "expand-related with both flags walks superclasses and each ancestor's own interfaces"))

      ;; 7.5 An ancestor not present in the index is reported as missing, not silently dropped.
      (let ((sparse-index (let ((tbl (make-hash-table :test #'equal)))
                            (setf (gethash "Fixture.Derived" tbl) (cons derived-plist owning-entry))
                            (setf (gethash "Fixture.Mid" tbl) (cons mid-plist owning-entry))
                            tbl))) ;; Fixture.Base intentionally absent
        (multiple-value-bind (ancestors downward missing)
            (assembly-package-generator::expand-related derived-plist t nil nil nil nil nil
                                                          sparse-index no-subclass-index no-implementer-index)
          (declare (ignore downward))
          (assert-test (mapcar (lambda (a) (getf (car a) :fully-qualified-name)) ancestors)
                      '("Fixture.Mid")
                      "expand-related resolves as much of the chain as it can before hitting a gap")
          (assert-test missing '(("Fixture.Base" . "Fixture.Mid"))
                      "expand-related reports an ancestor absent from the index as missing, along with the class that required it"))))

    ;; 8. compute-reexports decides which ancestor-exported names to re-export
    ;;    into a child package: skip a name the child already declares itself
    ;;    (child wins), skip a name more than one ancestor exports (ambiguous --
    ;;    see doc/parents-and-interfaces-plan.md for why this is a comment, not
    ;;    a renamed re-export), never re-export the synthetic per-type symbols,
    ;;    and flag a surviving re-export as needing cl:shadowing-import when the
    ;;    ancestor itself had to shadow that name (a CL-symbol collision).
  (let ((child-exports '("do-thing" "<type>" "<type-str>" "<creation>" "<version>" "new")))

      ;; 8.1 A name the child already exports itself is skipped, not re-exported.
      (multiple-value-bind (reexports skipped)
          (assembly-package-generator::compute-reexports
           child-exports
           (list (list "fixture-base" '("do-thing" "other-thing") nil)))
        (assert-test reexports (list (list "fixture-base" "other-thing" nil))
                    "compute-reexports re-exports a name only the ancestor declares")
        (assert-test skipped (list (list "do-thing" :own))
                    "compute-reexports skips a name the child already declares itself, tagged :own"))

      ;; 8.2 A name exported by more than one ancestor is ambiguous and skipped by both.
      (multiple-value-bind (reexports skipped)
          (assembly-package-generator::compute-reexports
           child-exports
           (list (list "fixture-iface-a" '("shared-thing") nil)
                 (list "fixture-iface-b" '("shared-thing") nil)))
        (assert-test reexports nil
                    "compute-reexports re-exports nothing when the only candidate name is ambiguous")
        (assert-test skipped (list (list "shared-thing" (list :ambiguous '("fixture-iface-a" "fixture-iface-b"))))
                    "compute-reexports flags a multi-ancestor name as ambiguous, listing every exporting package"))

      ;; 8.3 The synthetic per-type symbols are never candidates for re-export.
      (multiple-value-bind (reexports skipped)
          (assembly-package-generator::compute-reexports
           child-exports
           (list (list "fixture-base" '("<type>" "<type-str>" "<creation>" "<version>" "new") nil)))
        (assert-test reexports nil
                    "compute-reexports never re-exports the synthetic per-type symbols")
        (assert-test skipped nil
                    "compute-reexports does not even mention the synthetic per-type symbols as skipped"))

      ;; 8.4 A re-exported name that the ancestor itself had to shadow (a CL-symbol
      ;;     collision, e.g. length) is flagged as needing cl:shadowing-import.
      (multiple-value-bind (reexports skipped)
          (assembly-package-generator::compute-reexports
           child-exports
           (list (list "fixture-base" '("length" "other-thing") '("length"))))
        (declare (ignore skipped))
        (assert-test (find "length" reexports :key #'second :test #'string=)
                    (list "fixture-base" "length" t)
                    "compute-reexports flags a CL-shadowed ancestor export as needing shadowing-import")
        (assert-test (find "other-thing" reexports :key #'second :test #'string=)
                    (list "fixture-base" "other-thing" nil)
                    "compute-reexports leaves a non-colliding ancestor export as a plain import")))

    ;; 9. End-to-end parents/interfaces re-export: generate-assembly-packages-batch,
    ;;    given --export-parents/--export-interfaces flags on a requested class,
    ;;    pulls in its ancestors, generates their packages too, and appends a
    ;;    re-export post-pass to packages.lisp after every defpackage form (no
    ;;    topological sort of the defpackage forms themselves -- see
    ;;    doc/parents-and-interfaces-plan.md).
  (let* ((fixture-metadata
             '((:fully-qualified-name "Fixture.PBase" :kind :class
                :superclass "System.Object" :interfaces nil
                :fields nil :properties nil :constructors nil
                :methods ((:name "Speak" :is-static nil :return-type "System.Void" :parameters nil)
                          (:name "Shout" :is-static nil :return-type "System.Void" :parameters nil)))
               (:fully-qualified-name "Fixture.IGreeter" :kind :interface
                :superclass nil :interfaces nil
                :fields nil :properties nil :constructors nil
                :methods ((:name "Greet" :is-static nil :return-type "System.Void" :parameters nil)))
               (:fully-qualified-name "Fixture.PChild" :kind :class
                :superclass "Fixture.PBase" :interfaces ("Fixture.IGreeter")
                :fields nil :properties nil :constructors nil
                :methods ((:name "Shout" :is-static nil :return-type "System.Void" :parameters nil)))))
           (fixture-file (merge-pathnames "package-generator-tests-parents-fixture.lispy-metadata"
                                          (uiop:temporary-directory)))
           (out-dir (merge-pathnames "package-generator-tests-parents-out/"
                                     (uiop:temporary-directory))))
      (unwind-protect
          (progn
            (with-open-file (s fixture-file :direction :output :if-exists :supersede :if-does-not-exist :create)
              (prin1 fixture-metadata s))
            (ensure-directories-exist out-dir)

            (assembly-package-generator:generate-assembly-packages-batch
             (list (list :metadata-file (namestring fixture-file)
                         :assembly-name "Fixture.dll"
                         :classes (list (list :name "Fixture.PChild" :constant-properties ""
                                              :export-parents t :export-interfaces t :export-object nil))))
             (namestring out-dir)
             "2026-07-05T00:00:00Z"
             "9.9.9"
             (utils:qualify-path "csharp-assembly-utils-package.template.lisp")
             (utils:qualify-path "csharp-assembly-utils.template.lisp"))

            (dolist (f (list "fixture-p-base.lisp" "fixture-i-greeter.lisp" "fixture-p-child.lisp"))
              (assert-test (not (null (probe-file (merge-pathnames f out-dir)))) t
                          (format nil "generate-assembly-packages-batch also generates ~A for a pulled-in ancestor" f)))

            (let* ((packages-file (merge-pathnames "packages.lisp" out-dir))
                   (packages-contents (uiop:read-file-string packages-file))
                   (asd-file (merge-pathnames "csharp-assembly-packages.asd" out-dir))
                   (asd-contents (uiop:read-file-string asd-file)))
              (assert-test (not (null (search "Re-exports from parent/interface packages" packages-contents))) t
                          "packages.lisp emits the re-export post-pass section header")
              (assert-test (not (null (search "(cl:import '(" packages-contents))) t
                          "packages.lisp emits a cl:import re-export call")
              (assert-test (not (null (search "fixture-p-base::speak" packages-contents))) t
                          "packages.lisp re-exports the inherited 'speak' from the super-class package")
              (assert-test (not (null (search "fixture-i-greeter::greet" packages-contents))) t
                          "packages.lisp re-exports 'greet' from the implemented interface package")
              (assert-test (not (null (search "Skipped (fixture-p-child declares its own): shout" packages-contents))) t
                          "packages.lisp documents (not silently drops) a name the child already declares itself")
              (assert-test (search "fixture-p-base::shout" packages-contents) nil
                          "packages.lisp does not re-export a name the child already declares itself")

              (assert-test (not (null (search "(:file \"fixture-p-child\" :depends-on (\"packages\" \"csharp-assembly-utils\" \"fixture-p-base\" \"fixture-i-greeter\"))"
                                               asd-contents)))
                          t
                          "csharp-assembly-packages.asd adds fixture-p-child's ancestor packages to its own :depends-on")))
        (when (probe-file fixture-file)
          (delete-file fixture-file))
        (when (probe-file out-dir)
          (uiop:delete-directory-tree out-dir :validate t))))

    ;; 10. Missing ancestor: by default, an unresolvable parent/interface is a
    ;;     hard error (aborts before generating anything); passing SKIP-MISSING
    ;;     downgrades it to a warning and generation proceeds without it.
  (let* ((fixture-metadata
             '((:fully-qualified-name "Fixture.OnlyChild" :kind :class
                :superclass "Fixture.GhostBase" :interfaces nil
                :fields nil :properties nil :constructors nil
                :methods nil)))
           (fixture-file (merge-pathnames "package-generator-tests-missing-ancestor-fixture.lispy-metadata"
                                          (uiop:temporary-directory)))
           (out-dir (merge-pathnames "package-generator-tests-missing-ancestor-out/"
                                     (uiop:temporary-directory))))
      (unwind-protect
          (progn
            (with-open-file (s fixture-file :direction :output :if-exists :supersede :if-does-not-exist :create)
              (prin1 fixture-metadata s))
            (ensure-directories-exist out-dir)

            ;; 10.1 Without skip-missing, an unresolvable ancestor aborts generation
            ;;      before packages.lisp is ever written.
            (let ((errored nil))
              (handler-case
                  (assembly-package-generator:generate-assembly-packages-batch
                   (list (list :metadata-file (namestring fixture-file)
                               :assembly-name "Fixture.dll"
                               :classes (list (list :name "Fixture.OnlyChild" :constant-properties ""
                                                    :export-parents t :export-interfaces nil :export-object nil))))
                   (namestring out-dir)
                   "2026-07-05T00:00:00Z"
                   "9.9.9"
                   (utils:qualify-path "csharp-assembly-utils-package.template.lisp")
                   (utils:qualify-path "csharp-assembly-utils.template.lisp")
                   nil)
                (error () (setf errored t)))
              (assert-test errored t
                          "generate-assembly-packages-batch signals an error when an ancestor cannot be resolved and skip-missing is nil"))
            (assert-test (null (probe-file (merge-pathnames "packages.lisp" out-dir))) t
                        "generate-assembly-packages-batch writes nothing when a required ancestor is missing")

            ;; 10.2 With skip-missing, generation proceeds without the unresolvable ancestor.
            (assembly-package-generator:generate-assembly-packages-batch
             (list (list :metadata-file (namestring fixture-file)
                         :assembly-name "Fixture.dll"
                         :classes (list (list :name "Fixture.OnlyChild" :constant-properties ""
                                              :export-parents t :export-interfaces nil :export-object nil))))
             (namestring out-dir)
             "2026-07-05T00:00:00Z"
             "9.9.9"
             (utils:qualify-path "csharp-assembly-utils-package.template.lisp")
             (utils:qualify-path "csharp-assembly-utils.template.lisp")
             t)
            (assert-test (not (null (probe-file (merge-pathnames "packages.lisp" out-dir)))) t
                        "generate-assembly-packages-batch, with skip-missing, still writes packages.lisp"))
        (when (probe-file fixture-file)
          (delete-file fixture-file))
        (when (probe-file out-dir)
          (uiop:delete-directory-tree out-dir :validate t)))))
