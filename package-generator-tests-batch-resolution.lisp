;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite -- Batch Resolution/Orchestration cluster.
;;; Split out of the former package-generator-tests.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :package-generator-tests)

(defun run-batch-resolution-tests ()
  (format *error-output* "--- Running Batch Resolution/Orchestration Tests ---~%")

    ;; Functional/operator-overload testing of generated packages (e.g. the old
    ;; TimeSpan operator checks that used to live here) is now handled by the
    ;; `make test` target, which generates a range of standard-.NET classes into
    ;; cspackages-test/ and validates them with check_parens.py.
  
    ;; 4. Single-pass batch generation: resolve-batch-entry / generate-assembly-packages-batch
  (let* ((fixture-metadata
             '((:fully-qualified-name "Fixture.ClassA" :kind :class :fields nil :properties nil :methods nil :constructors nil)
               (:fully-qualified-name "Fixture.ClassB" :kind :class :fields nil :properties nil :methods nil :constructors nil)))
           (fixture-file (merge-pathnames "package-generator-tests-fixture.lispy-metadata"
                                          (uiop:temporary-directory))))
      (unwind-protect
          (progn
            (with-open-file (s fixture-file :direction :output :if-exists :supersede :if-does-not-exist :create)
              (prin1 fixture-metadata s))

            ;; 4.1 All requested classes resolve; per-class constant-properties stay isolated.
            (multiple-value-bind (resolved not-found)
                (assembly-package-generator:resolve-batch-entry
                 (list :metadata-file (namestring fixture-file)
                       :classes (list (list :name "Fixture.ClassA" :constant-properties "*")
                                      (list :name "Fixture.ClassB" :constant-properties ""))))
              (assert-test (length not-found) 0
                          "resolve-batch-entry finds no missing classes when all names are valid")
              (assert-test (length resolved) 2
                          "resolve-batch-entry resolves every requested class")
              (assert-test (getf (find-resolved "Fixture.ClassA" resolved) :constant-properties)
                          '("*")
                          "resolve-batch-entry keeps ClassA's own constant-properties")
              (assert-test (getf (find-resolved "Fixture.ClassB" resolved) :constant-properties)
                          nil
                          "resolve-batch-entry does not leak ClassA's constant-properties onto ClassB"))

            ;; 4.2 An empty :classes list is valid (metadata-only request), not an error.
            (multiple-value-bind (resolved not-found)
                (assembly-package-generator:resolve-batch-entry
                 (list :metadata-file (namestring fixture-file) :classes nil))
              (assert-test resolved nil
                          "resolve-batch-entry returns no pairs for an empty :classes list")
              (assert-test not-found nil
                          "resolve-batch-entry treats an empty :classes list as valid, not missing"))

            ;; 4.3 A class name absent from the metadata is reported as not-found.
            (multiple-value-bind (resolved not-found)
                (assembly-package-generator:resolve-batch-entry
                 (list :metadata-file (namestring fixture-file)
                       :classes (list (list :name "Fixture.DoesNotExist" :constant-properties ""))))
              (declare (ignore resolved))
              (assert-test not-found '("Fixture.DoesNotExist")
                          "resolve-batch-entry reports classes missing from the metadata")))
        (when (probe-file fixture-file)
          (delete-file fixture-file))))

    ;; 5. End-to-end batch generation: generate-assembly-packages-batch also emits
    ;;    csharp-assembly-packages.asd, listing every generated class in request order.
  (let* ((fixture-metadata
             '((:fully-qualified-name "Fixture.ClassA" :kind :class :fields nil :properties nil :methods nil :constructors nil)
               (:fully-qualified-name "Fixture.ClassB" :kind :class :fields nil :properties nil :methods nil :constructors nil)))
           (fixture-file (merge-pathnames "package-generator-tests-asd-fixture.lispy-metadata"
                                          (uiop:temporary-directory)))
           (out-dir (merge-pathnames "package-generator-tests-asd-out/"
                                     (uiop:temporary-directory))))
      (unwind-protect
          (progn
            (with-open-file (s fixture-file :direction :output :if-exists :supersede :if-does-not-exist :create)
              (prin1 fixture-metadata s))
            (ensure-directories-exist out-dir)

            (assembly-package-generator:generate-assembly-packages-batch
             (list (list :metadata-file (namestring fixture-file)
                         :assembly-name "Fixture.dll"
                         :classes (list (list :name "Fixture.ClassB" :constant-properties "")
                                        (list :name "Fixture.ClassA" :constant-properties "*"))))
             (namestring out-dir)
             "2026-07-03T00:00:00Z"
             "9.9.9"
             (utils:qualify-path "csharp-assembly-utils-package.template.lisp")
             (utils:qualify-path "csharp-assembly-utils.template.lisp"))

            (let ((asd-file (merge-pathnames "csharp-assembly-packages.asd" out-dir))
                  (utils-file (merge-pathnames "csharp-assembly-utils.lisp" out-dir))
                  (packages-file (merge-pathnames "packages.lisp" out-dir)))
              (assert-test (not (null (probe-file asd-file))) t
                          "generate-assembly-packages-batch emits csharp-assembly-packages.asd")
              (assert-test (not (null (probe-file utils-file))) t
                          "generate-assembly-packages-batch emits csharp-assembly-utils.lisp")

              (assert-test (not (null (search "csharp-overload-not-found"
                                               (uiop:read-file-string utils-file))))
                          t
                          "csharp-assembly-utils.lisp defines the csharp-overload-not-found condition")

              (assert-test (not (null (search "(cl:defpackage :csharp-assembly-utils"
                                               (uiop:read-file-string packages-file))))
                          t
                          "packages.lisp includes the csharp-assembly-utils defpackage ahead of the class packages")

              (dolist (class-file (list (merge-pathnames "fixture-class-a.lisp" out-dir)
                                         (merge-pathnames "fixture-class-b.lisp" out-dir)))
                (assert-test (search "monoutils:" (uiop:read-file-string class-file)) nil
                            "generated class file no longer references monoutils:"))

              (asdf:load-asd asd-file)
              (let ((sys (asdf:find-system "csharp-assembly-packages" nil)))
                (assert-test (not (null sys)) t
                            "csharp-assembly-packages.asd defines a loadable ASDF system")
                (assert-test (asdf:component-version sys)
                            (format nil "~D" assembly-package-generator::*generator-version*)
                            "csharp-assembly-packages.asd :version is the short generator-version")
                (assert-test (asdf:system-depends-on sys) nil
                            "csharp-assembly-packages.asd has no :depends-on yet")
                (assert-test (mapcar #'asdf:component-name (asdf:component-children sys))
                            '("packages" "csharp-assembly-utils" "fixture-class-b" "fixture-class-a")
                            "csharp-assembly-packages.asd lists packages, then csharp-assembly-utils, then classes as :file components in request order"))))
        (when (probe-file fixture-file)
          (delete-file fixture-file))
        (when (probe-file out-dir)
          (uiop:delete-directory-tree out-dir :validate t))))

    ;; 6. Invocation echo (doc/plan-fable-detail-07.md's Part B): every
    ;;    class's non-default per-class flags and discovery provenance are
    ;;    recorded in csharp-assembly-packages.asd, packages.lisp, and the
    ;;    class file's own header, so a generated directory alone is
    ;;    reconstructable back into the invocation that produced it.
  (let* ((fixture-metadata
             '((:fully-qualified-name "Fixture.Child" :kind :class :superclass "Fixture.Parent"
                :fields nil :properties nil :methods nil :constructors nil :interfaces nil)
               (:fully-qualified-name "Fixture.Parent" :kind :class :superclass nil
                :fields nil :properties nil :methods nil :constructors nil :interfaces nil)))
           (fixture-file (merge-pathnames "package-generator-tests-echo-fixture.lispy-metadata"
                                          (uiop:temporary-directory)))
           (out-dir (merge-pathnames "package-generator-tests-echo-out/"
                                     (uiop:temporary-directory))))
      (unwind-protect
          (progn
            (with-open-file (s fixture-file :direction :output :if-exists :supersede :if-does-not-exist :create)
              (prin1 fixture-metadata s))
            (ensure-directories-exist out-dir)

            (assembly-package-generator:generate-assembly-packages-batch
             (list (list :metadata-file (namestring fixture-file)
                         :assembly-name "Fixture.dll"
                         :classes (list (list :name "Fixture.Child" :constant-properties ""
                                               :export-parents t :defgeneric t))))
             (namestring out-dir)
             "2026-07-19T00:00:00Z"
             "9.9.9"
             (utils:qualify-path "csharp-assembly-utils-package.template.lisp")
             (utils:qualify-path "csharp-assembly-utils.template.lisp")
             t)

            (let ((asd-contents (uiop:read-file-string (merge-pathnames "csharp-assembly-packages.asd" out-dir)))
                  (packages-contents (uiop:read-file-string (merge-pathnames "packages.lisp" out-dir)))
                  (child-contents (uiop:read-file-string (merge-pathnames "fixture-child.lisp" out-dir)))
                  (parent-contents (uiop:read-file-string (merge-pathnames "fixture-parent.lisp" out-dir))))
              (assert-test (not (null (search "Global flags: --skip-missing --csharp-generic-in-asd" asd-contents))) t
                          "csharp-assembly-packages.asd's long-description records the global (whole-invocation) flags")
              (assert-test (not (null (search "Options: --defgeneric --export-parents" asd-contents))) t
                          "csharp-assembly-packages.asd's per-class listing records Fixture.Child's own non-default flags")
              (assert-test (not (null (search ";;; Options: --defgeneric --export-parents" packages-contents))) t
                          "packages.lisp's per-package comment records Fixture.Child's own non-default flags")
              (assert-test (not (null (search ";;; Options: --defgeneric --export-parents" child-contents))) t
                          "fixture-child.lisp's own header records its non-default flags")
              (assert-test (null (search "Discovered via" child-contents)) t
                          "an explicitly-requested class's header has no Discovered via line")
              (assert-test (not (null (search ";;; Options: --defgeneric --export-parents" parent-contents))) t
                          "fixture-parent.lisp (discovered via --export-parents) inherits its discoverer Fixture.Child's entire flag set (Version 39 cascading-discovery rule)")
              (assert-test (not (null (search ";;; Discovered via: --export-parents from Fixture.Child" parent-contents))) t
                          "fixture-parent.lisp's header records it was discovered via --export-parents from Fixture.Child")))
        (when (probe-file fixture-file)
          (delete-file fixture-file))
        (when (probe-file out-dir)
          (uiop:delete-directory-tree out-dir :validate t)))))
