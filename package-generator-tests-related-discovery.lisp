;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite -- Recursive Related-Class Downward-Graph Discovery cluster.
;;; Split out of the former package-generator-tests.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :package-generator-tests)

(defun run-related-discovery-tests ()
  (format *error-output* "--- Running Recursive Related-Class Downward-Graph Discovery Tests ---~%")

    ;; 15. Recursive Related-Class Discovery (Version 39, doc/plan-v38.md's Part
    ;;     B): build-reverse-indexes and expand-related's downward directions,
    ;;     plus an end-to-end check of flag propagation and the generate-only
    ;;     (never re-export) guarantee for --output-children/--output-nested/
    ;;     --output-implementations.
  (let* ((anchor-plist '(:fully-qualified-name "Fixture.Rel.Anchor" :kind :class
                            :superclass nil :interfaces nil))
           (child1-plist '(:fully-qualified-name "Fixture.Rel.Child1" :kind :class
                           :superclass "Fixture.Rel.Anchor" :interfaces ("Fixture.Rel.IChild")))
           (child2-plist '(:fully-qualified-name "Fixture.Rel.Child2" :kind :class
                           :superclass "Fixture.Rel.Anchor" :interfaces nil))
           (grandchild-plist '(:fully-qualified-name "Fixture.Rel.GrandChild" :kind :class
                               :superclass "Fixture.Rel.Child1" :interfaces nil))
           (ichild-plist '(:fully-qualified-name "Fixture.Rel.IChild" :kind :interface
                           :superclass nil :interfaces nil
                           :methods ((:name "ChildIfaceMethod" :is-static nil
                                      :return-type "System.Void" :parameters nil))))
           (iface-plist '(:fully-qualified-name "Fixture.Rel.IFace" :kind :interface
                          :superclass nil :interfaces nil))
           (impl1-plist '(:fully-qualified-name "Fixture.Rel.Impl1" :kind :class
                          :superclass nil :interfaces ("Fixture.Rel.IFace")))
           (impl2-plist '(:fully-qualified-name "Fixture.Rel.Impl2" :kind :class
                          :superclass nil :interfaces ("Fixture.Rel.IFace")))
           (nested-plist '(:fully-qualified-name "Fixture.Rel.Anchor+Nested" :name "Nested"
                           :namespace "Fixture.Rel" :kind :class :superclass nil :interfaces nil))
           (deep-plist '(:fully-qualified-name "Fixture.Rel.Anchor+Nested+Deep" :name "Deep"
                         :namespace "Fixture.Rel" :kind :class :superclass nil :interfaces nil))
           (owning-entry (list :assembly-name "Fixture.Rel.dll"))
           (index (let ((tbl (make-hash-table :test #'equal)))
                    (dolist (p (list anchor-plist child1-plist child2-plist grandchild-plist
                                     ichild-plist iface-plist impl1-plist impl2-plist
                                     nested-plist deep-plist))
                      (setf (gethash (getf p :fully-qualified-name) tbl) (cons p owning-entry)))
                    tbl)))

      ;; 15.1 build-reverse-indexes: subclass-index is DIRECT subclasses only
      ;;      (GrandChild lands under Child1, not Anchor); implementer-index is
      ;;      every implementer (already transitive, so no multi-hop distinction
      ;;      to test here).
      (multiple-value-bind (subclass-index implementer-index)
          (assembly-package-generator::build-reverse-indexes index)
        (assert-test (sort (mapcar (lambda (p) (getf (car p) :fully-qualified-name))
                                   (gethash "Fixture.Rel.Anchor" subclass-index))
                           #'string<)
                    (sort (list "Fixture.Rel.Child1" "Fixture.Rel.Child2") #'string<)
                    "build-reverse-indexes' subclass-index buckets Anchor's direct subclasses only")
        (assert-test (mapcar (lambda (p) (getf (car p) :fully-qualified-name))
                             (gethash "Fixture.Rel.Child1" subclass-index))
                    '("Fixture.Rel.GrandChild")
                    "build-reverse-indexes' subclass-index buckets Child1's own direct subclass separately (one hop)")
        (assert-test (sort (mapcar (lambda (p) (getf (car p) :fully-qualified-name))
                                   (gethash "Fixture.Rel.IFace" implementer-index))
                           #'string<)
                    (sort (list "Fixture.Rel.Impl1" "Fixture.Rel.Impl2") #'string<)
                    "build-reverse-indexes' implementer-index buckets every implementer")

        ;; 15.2 expand-related's downward directions: output-children is
        ;;      single-hop per call (GrandChild excluded from Anchor's own
        ;;      call); output-implementations is fully transitive in one
        ;;      lookup; output-nested reaches every nesting depth in one call.
        (multiple-value-bind (ancestor downward missing)
            (assembly-package-generator::expand-related anchor-plist nil nil nil nil t nil
                                                          index subclass-index implementer-index)
          (assert-test ancestor nil "expand-related's downward-only call returns no ancestor-discovered")
          (assert-test missing nil "expand-related's downward directions never report missing")
          (assert-test (sort (mapcar (lambda (p) (getf (car p) :fully-qualified-name)) downward) #'string<)
                      (sort (list "Fixture.Rel.Child1" "Fixture.Rel.Child2") #'string<)
                      "expand-related's output-children returns only Anchor's direct subclasses"))

        (multiple-value-bind (ancestor downward missing)
            (assembly-package-generator::expand-related iface-plist nil nil nil nil nil t
                                                          index subclass-index implementer-index)
          (declare (ignore ancestor missing))
          (assert-test (sort (mapcar (lambda (p) (getf (car p) :fully-qualified-name)) downward) #'string<)
                      (sort (list "Fixture.Rel.Impl1" "Fixture.Rel.Impl2") #'string<)
                      "expand-related's output-implementations returns every implementer"))

        (multiple-value-bind (ancestor downward missing)
            (assembly-package-generator::expand-related anchor-plist nil nil nil t nil nil
                                                          index subclass-index implementer-index)
          (declare (ignore ancestor missing))
          (assert-test (sort (mapcar (lambda (p) (getf (car p) :fully-qualified-name)) downward) #'string<)
                      (sort (list "Fixture.Rel.Anchor+Nested" "Fixture.Rel.Anchor+Nested+Deep") #'string<)
                      "expand-related's output-nested reaches every nesting depth in one call")))

      ;; 15.3 End-to-end via generate-assembly-packages-batch: requesting only
      ;;      Anchor with --output-children --export-interfaces must (a) pull in
      ;;      Child1/Child2 (direct) and GrandChild (transitively, via the outer
      ;;      queue re-invoking expand-related on the propagated-flags Child1),
      ;;      (b) propagate --export-interfaces to Child1, which independently
      ;;      discovers and re-exports its own IChild interface into ITSELF
      ;;      (never into Anchor), and (c) never add a re-export section for
      ;;      Anchor itself (Anchor implements no interfaces of its own).
      (let* ((fixture-metadata (list anchor-plist child1-plist child2-plist grandchild-plist ichild-plist))
             (fixture-file (merge-pathnames "package-generator-tests-related-fixture.lispy-metadata"
                                            (uiop:temporary-directory)))
             (out-dir (merge-pathnames "package-generator-tests-related-out/"
                                       (uiop:temporary-directory)))
             (anchor-pkg (assembly-package-generator::type-fq-name-to-pkg-name "Fixture.Rel.Anchor"))
             (child1-pkg (assembly-package-generator::type-fq-name-to-pkg-name "Fixture.Rel.Child1"))
             (child2-pkg (assembly-package-generator::type-fq-name-to-pkg-name "Fixture.Rel.Child2"))
             (grandchild-pkg (assembly-package-generator::type-fq-name-to-pkg-name "Fixture.Rel.GrandChild"))
             (ichild-pkg (assembly-package-generator::type-fq-name-to-pkg-name "Fixture.Rel.IChild")))
        (unwind-protect
            (progn
              (with-open-file (s fixture-file :direction :output :if-exists :supersede :if-does-not-exist :create)
                (prin1 fixture-metadata s))
              (ensure-directories-exist out-dir)
              (assembly-package-generator:generate-assembly-packages-batch
               (list (list :metadata-file (namestring fixture-file)
                           :assembly-name "Fixture.Rel.dll"
                           :classes (list (list :name "Fixture.Rel.Anchor" :constant-properties ""
                                                :output-children t :export-interfaces t))))
               (namestring out-dir)
               "2026-07-06T00:00:00Z"
               "9.9.9"
               (utils:qualify-path "csharp-assembly-utils-package.template.lisp")
               (utils:qualify-path "csharp-assembly-utils.template.lisp")
               nil)
              (let* ((asd-file (merge-pathnames "csharp-assembly-packages.asd" out-dir))
                     (asd-contents (uiop:read-file-string asd-file))
                     (packages-file (merge-pathnames "packages.lisp" out-dir))
                     (packages-contents (uiop:read-file-string packages-file)))
                (dolist (pkg (list child1-pkg child2-pkg grandchild-pkg ichild-pkg))
                  (assert-test (not (null (search (format nil "\"~A\"" pkg) asd-contents))) t
                              (format nil "csharp-assembly-packages.asd lists ~A as its own :file component" pkg)))
                (assert-test (not (null (search (format nil "~A: re-exports inherited members from ~A" child1-pkg ichild-pkg)
                                                packages-contents)))
                            t
                            "packages.lisp shows Child1 (propagated --export-interfaces) re-exporting from its own IChild")
                (assert-test (search (format nil "~A: re-exports" anchor-pkg) packages-contents) nil
                            "packages.lisp never adds a re-export section for Anchor itself (Anchor has no interfaces)")
                (assert-test (search (format nil "~A: re-exports" grandchild-pkg) packages-contents) nil
                            "packages.lisp never adds a re-export section for GrandChild (discovered generate-only, no interfaces)")))
          (when (probe-file fixture-file)
            (delete-file fixture-file))
          (when (probe-file out-dir)
            (uiop:delete-directory-tree out-dir :validate t))))))
