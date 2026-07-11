;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite -- Unified Generics / --defgeneric cluster.
;;; Split out of the former package-generator-tests.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :package-generator-tests)

(defun run-defgeneric-tests ()
  (format *error-output* "--- Running Unified Generics / --defgeneric Tests ---~%")

    ;; 11. Unified Generic Methods (Version 41): collect-class-instance-generics
    ;;     must exclude static members and generic/type-parameterized instance
    ;;     methods (their wrapper's lambda list puts the type argument(s)
    ;;     before obj!, disqualifying them).
  (let ((class-a
            '(:fully-qualified-name "Fixture.GenA" :kind :class
              :methods ((:name "Common" :is-static nil :parameters nil :return-type "System.Void")
                        (:name "OnlyA" :is-static nil :parameters nil :return-type "System.Void")
                        (:name "StaticOnly" :is-static t :parameters nil :return-type "System.Void")
                        (:name "Generic" :is-static nil :is-generic t :generic-arity 1
                         :parameters nil :return-type "System.Void"))
              :properties ((:name "Value" :static nil :readable t :writeable t :type "System.Int32"))
              :fields nil :constructors nil))
          (class-b
            '(:fully-qualified-name "Fixture.GenB" :kind :class
              :methods ((:name "Common" :is-static nil :parameters nil :return-type "System.Void"))
              :properties nil :fields nil :constructors nil)))

      ;; 11.1 collect-class-instance-generics on class-a in isolation.
      (multiple-value-bind (method-names setter-names)
          (assembly-package-generator::collect-class-instance-generics class-a nil)
        (assert-test (and (member "common" method-names :test #'string=) t) t
                    "collect-class-instance-generics includes a plain instance method")
        (assert-test (and (member "only-a" method-names :test #'string=) t) t
                    "collect-class-instance-generics includes another plain instance method")
        (assert-test (and (member "value" method-names :test #'string=) t) t
                    "collect-class-instance-generics includes a readable instance property's getter")
        (assert-test (and (member "value" setter-names :test #'string=) t) t
                    "collect-class-instance-generics includes a writeable instance property's setter")
        (assert-test (member "static-only" method-names :test #'string=) nil
                    "collect-class-instance-generics excludes a static method (no obj! receiver)")
        (assert-test (member "generic" method-names :test #'string=) nil
                    "collect-class-instance-generics excludes a generic instance method (type argument precedes obj!)"))

      ;; 11.2 generic-arity-fq-name-p distinguishes an open generic type
      ;;      definition (.NET's backtick arity suffix) from a plain type --
      ;;      classes for which --defgeneric dispatch must be skipped (DotCL
      ;;      cannot dispatch a defmethod on an open generic's own type; see
      ;;      doc/dispatch-on-open-generics.md).
      (assert-test (assembly-package-generator::generic-arity-fq-name-p "System.Collections.Generic.List`1") t
                  "generic-arity-fq-name-p is true for an open generic type definition")
      (assert-test (assembly-package-generator::generic-arity-fq-name-p "Fixture.GenA") nil
                  "generic-arity-fq-name-p is false for a non-generic type")

      ;; 11.3 End-to-end, --defgeneric (Version 41: DotCL 0.1.17's
      ;;      dotnet:class-for-type plus its new defmethod class-object-
      ;;      specializer support). Only Fixture.GenA opts in; Fixture.GenB
      ;;      does not, so its "common" wrapper must not become a
      ;;      specializer. Must contain an ordinary top-level cl:defmethod (no
      ;;      cl:eval/eval-when/backquote) specializing on
      ;;      #.(dotnet:class-for-type "Fixture.GenA").
      (let* ((fixture-metadata (list class-a class-b))
             (fixture-file (merge-pathnames "package-generator-tests-defgeneric-fixture.lispy-metadata"
                                            (uiop:temporary-directory)))
             (out-dir (merge-pathnames "package-generator-tests-defgeneric-out/"
                                       (uiop:temporary-directory))))
        (unwind-protect
            (progn
              (with-open-file (s fixture-file :direction :output :if-exists :supersede :if-does-not-exist :create)
                (prin1 fixture-metadata s))
              (ensure-directories-exist out-dir)
              (assembly-package-generator:generate-assembly-packages-batch
               (list (list :metadata-file (namestring fixture-file)
                           :assembly-name "Fixture.dll"
                           :classes (list (list :name "Fixture.GenA" :constant-properties "" :defgeneric t)
                                          (list :name "Fixture.GenB" :constant-properties "" :defgeneric nil))))
               (namestring out-dir)
               "2026-07-05T00:00:00Z"
               "9.9.9"
               (utils:qualify-path "csharp-assembly-utils-package.template.lisp")
               (utils:qualify-path "csharp-assembly-utils.template.lisp")
               nil)
              (let* ((generics-file (merge-pathnames "csharp-generics.lisp" out-dir))
                     (packages-file (merge-pathnames "packages.lisp" out-dir))
                     (asd-file (merge-pathnames "csharp-assembly-packages.asd" out-dir))
                     (generics-contents (uiop:read-file-string generics-file))
                     (packages-contents (uiop:read-file-string packages-file))
                     (asd-contents (uiop:read-file-string asd-file)))
                (assert-test (not (null (search "(cl:defgeneric common (obj! cl:&rest args)" generics-contents))) t
                            "csharp-generics.lisp defines a generic for the shared method name")
                (assert-test (search "cl:eval" generics-contents) nil
                            "csharp-generics.lisp contains no cl:eval anywhere -- ordinary top-level forms only")
                (assert-test (search "eval-when" generics-contents) nil
                            "csharp-generics.lisp contains no eval-when anywhere")
                (assert-test (not (null (search "(cl:defmethod common ((obj! #.(dotnet:class-for-type \"Fixture.GenA\")) cl:&rest args)" generics-contents))) t
                            "csharp-generics.lisp emits a literal defmethod specializing on #.(dotnet:class-for-type ...)")
                (assert-test (not (null (search "(cl:apply (cl:function fixture-gen-a:common) obj! args))" generics-contents))) t
                            "csharp-generics.lisp's defmethod forwards via cl:apply to the opted-in class")
                (assert-test (search "fixture-gen-b:common" generics-contents) nil
                            "csharp-generics.lisp installs no defmethod for the non-opted-in class")
                (assert-test (search "static-only" generics-contents) nil
                            "csharp-generics.lisp never mentions the excluded static method")
                (assert-test (search "(cl:defgeneric generic " generics-contents) nil
                            "csharp-generics.lisp never mentions the excluded generic instance method")
                (assert-test (not (null (search "(cl:defgeneric (cl:setf value)" generics-contents))) t
                            "csharp-generics.lisp defines a (cl:setf ...) generic for a writeable property")
                (assert-test (not (null (search "(cl:defmethod (cl:setf value) (new-value (obj! #.(dotnet:class-for-type \"Fixture.GenA\"))" generics-contents))) t
                            "csharp-generics.lisp emits a literal (cl:setf ...) defmethod for a writeable property")
                (assert-test (not (null (search "(cl:defpackage :csharp-generics" packages-contents))) t
                            "packages.lisp defines the csharp-generics package")
                (assert-test (not (null (search "\"csharp-generics\"" asd-contents))) t
                            "csharp-assembly-packages.asd includes the csharp-generics component")))
          (when (probe-file fixture-file)
            (delete-file fixture-file))
          (when (probe-file out-dir)
            (uiop:delete-directory-tree out-dir :validate t))))

      ;; 11.4 A generic-arity class (an open generic type definition, e.g.
      ;;      Fixture.GenC`1) opted into --defgeneric is SKIPPED with an
      ;;      explanatory comment rather than emitting a defmethod that could
      ;;      never fire -- DotCL's DotNetTypeDisplayName names an open
      ;;      generic's CLOS class from its own type PARAMETERS, which never
      ;;      matches any real closed instance's registered name. See
      ;;      doc/dispatch-on-open-generics.md.
      (let* ((generic-class
               '(:fully-qualified-name "Fixture.GenC`1" :kind :class
                 :methods ((:name "Common" :is-static nil :parameters nil :return-type "System.Void"))
                 :properties nil :fields nil :constructors nil))
             (fixture-metadata (list generic-class))
             (fixture-file (merge-pathnames "package-generator-tests-defgeneric-generic-arity-fixture.lispy-metadata"
                                            (uiop:temporary-directory)))
             (out-dir (merge-pathnames "package-generator-tests-defgeneric-generic-arity-out/"
                                       (uiop:temporary-directory))))
        (unwind-protect
            (progn
              (with-open-file (s fixture-file :direction :output :if-exists :supersede :if-does-not-exist :create)
                (prin1 fixture-metadata s))
              (ensure-directories-exist out-dir)
              (assembly-package-generator:generate-assembly-packages-batch
               (list (list :metadata-file (namestring fixture-file)
                           :assembly-name "Fixture.dll"
                           :classes (list (list :name "Fixture.GenC`1" :constant-properties "" :defgeneric t))))
               (namestring out-dir)
               "2026-07-05T00:00:00Z"
               "9.9.9"
               (utils:qualify-path "csharp-assembly-utils-package.template.lisp")
               (utils:qualify-path "csharp-assembly-utils.template.lisp")
               nil)
              (let* ((generics-file (merge-pathnames "csharp-generics.lisp" out-dir))
                     (contents (uiop:read-file-string generics-file)))
                (assert-test (not (null (search "SKIPPED" contents))) t
                            "csharp-generics.lisp skips a generic-arity class's dispatch block with an explanatory comment")
                (assert-test (search "(cl:defmethod common ((obj!" contents) nil
                            "csharp-generics.lisp emits no defmethod for the skipped generic-arity class")))
          (when (probe-file fixture-file)
            (delete-file fixture-file))
          (when (probe-file out-dir)
            (uiop:delete-directory-tree out-dir :validate t))))

      ;; 11.5 No class opts into --defgeneric: the whole feature is a no-op --
      ;;      no csharp-generics.lisp, no defpackage, no .asd component.
      (let* ((fixture-metadata (list class-a class-b))
             (fixture-file (merge-pathnames "package-generator-tests-no-defgeneric-fixture.lispy-metadata"
                                            (uiop:temporary-directory)))
             (out-dir (merge-pathnames "package-generator-tests-no-defgeneric-out/"
                                       (uiop:temporary-directory))))
        (unwind-protect
            (progn
              (with-open-file (s fixture-file :direction :output :if-exists :supersede :if-does-not-exist :create)
                (prin1 fixture-metadata s))
              (ensure-directories-exist out-dir)
              (assembly-package-generator:generate-assembly-packages-batch
               (list (list :metadata-file (namestring fixture-file)
                           :assembly-name "Fixture.dll"
                           :classes (list (list :name "Fixture.GenA" :constant-properties "")
                                          (list :name "Fixture.GenB" :constant-properties ""))))
               (namestring out-dir)
               "2026-07-05T00:00:00Z"
               "9.9.9"
               (utils:qualify-path "csharp-assembly-utils-package.template.lisp")
               (utils:qualify-path "csharp-assembly-utils.template.lisp")
               nil)
              (let* ((packages-file (merge-pathnames "packages.lisp" out-dir))
                     (asd-file (merge-pathnames "csharp-assembly-packages.asd" out-dir))
                     (packages-contents (uiop:read-file-string packages-file))
                     (asd-contents (uiop:read-file-string asd-file)))
                (assert-test (null (probe-file (merge-pathnames "csharp-generics.lisp" out-dir))) t
                            "generate-assembly-packages-batch writes no csharp-generics.lisp when no class opts in")
                (assert-test (search "csharp-generics" packages-contents) nil
                            "packages.lisp has no csharp-generics defpackage when no class opts in")
                (assert-test (search "csharp-generics" asd-contents) nil
                            "csharp-assembly-packages.asd has no csharp-generics component when no class opts in")))
          (when (probe-file fixture-file)
            (delete-file fixture-file))
          (when (probe-file out-dir)
            (uiop:delete-directory-tree out-dir :validate t)))))

    ;; 12. Version 41: the simple-name/FullName class-naming race the old
    ;;     static --defgeneric variant had to document as an accepted caveat
    ;;     no longer applies, since each class's #.(dotnet:class-for-type ...)
    ;;     specializer resolves by its own fully-qualified name directly,
    ;;     never a guessed simple-name symbol -- two classes sharing a simple
    ;;     name across different namespaces (both named "Thing", from
    ;;     different namespaces) now each get their own correct, independent
    ;;     specializer and no collision-caveat comment.
  (let* ((conflict-a
             '(:fully-qualified-name "Fixture.ConflictA.Thing" :kind :class
               :methods ((:name "Ping" :is-static nil :parameters nil :return-type "System.Void"))
               :properties nil :fields nil :constructors nil))
           (conflict-b
             '(:fully-qualified-name "Fixture.ConflictB.Thing" :kind :class
               :methods ((:name "Ping" :is-static nil :parameters nil :return-type "System.Void"))
               :properties nil :fields nil :constructors nil))
           (fixture-metadata (list conflict-a conflict-b))
           (fixture-file (merge-pathnames "package-generator-tests-defgeneric-no-collision-fixture.lispy-metadata"
                                          (uiop:temporary-directory)))
           (out-dir (merge-pathnames "package-generator-tests-defgeneric-no-collision-out/"
                                     (uiop:temporary-directory))))
      (unwind-protect
          (progn
            (with-open-file (s fixture-file :direction :output :if-exists :supersede :if-does-not-exist :create)
              (prin1 fixture-metadata s))
            (ensure-directories-exist out-dir)
            (assembly-package-generator:generate-assembly-packages-batch
             (list (list :metadata-file (namestring fixture-file)
                         :assembly-name "Fixture.dll"
                         :classes (list (list :name "Fixture.ConflictA.Thing" :constant-properties "" :defgeneric t)
                                        (list :name "Fixture.ConflictB.Thing" :constant-properties "" :defgeneric t))))
             (namestring out-dir)
             "2026-07-05T00:00:00Z"
             "9.9.9"
             (utils:qualify-path "csharp-assembly-utils-package.template.lisp")
             (utils:qualify-path "csharp-assembly-utils.template.lisp")
             nil)
            (let* ((generics-file (merge-pathnames "csharp-generics.lisp" out-dir))
                   (contents (uiop:read-file-string generics-file)))
              (assert-test (not (null (search "#.(dotnet:class-for-type \"Fixture.ConflictA.Thing\")" contents))) t
                          "csharp-generics.lisp specializes Fixture.ConflictA.Thing's defmethod on its own fully-qualified name")
              (assert-test (not (null (search "#.(dotnet:class-for-type \"Fixture.ConflictB.Thing\")" contents))) t
                          "csharp-generics.lisp specializes Fixture.ConflictB.Thing's defmethod on its own fully-qualified name")
              (assert-test (search "ACTUAL" contents) nil
                          "csharp-generics.lisp no longer reports any ACTUAL simple-name conflict comment")
              (assert-test (search "POSSIBLE" contents) nil
                          "csharp-generics.lisp no longer reports any POSSIBLE simple-name conflict comment")
              (assert-test (search "simple-name" contents) nil
                          "csharp-generics.lisp no longer mentions simple-name conflicts at all")))
        (when (probe-file fixture-file)
          (delete-file fixture-file))
        (when (probe-file out-dir)
          (uiop:delete-directory-tree out-dir :validate t)))))
