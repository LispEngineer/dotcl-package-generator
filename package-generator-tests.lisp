;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite
;;;
;;; This file contains unit tests for the assembly-package-generator.
;;; Tests are run when this file is loaded.

(in-package :package-generator-tests)

(defun run-package-generator-tests ()
  (format *error-output* "--- Running Package Generator Tests ---~%")

  ;; Helper assertion macro
  (defmacro assert-test (form expected-value description)
    `(let ((result ,form))
      (if (equal result ,expected-value)
          (format *error-output* "[package-generator-tests] PASS ~A: ~S -> ~S~%" ,description result result)
          (progn
            (utils:format-red *error-output* "[package-generator-tests] FAIL ~A: Expected ~S but got ~S~%" ,description ,expected-value result)
            (error "Test failure: ~A" ,description)))))

  ;; 1. Test camel-to-kebab
  (assert-test (assembly-package-generator:camel-to-kebab "System.Console")
              "system-console"
              "Convert System.Console to kebab-case")

  (assert-test (assembly-package-generator:camel-to-kebab "System.Collections.ArrayList")
              "system-collections-array-list"
              "Convert System.Collections.ArrayList to kebab-case")

  (assert-test (assembly-package-generator:camel-to-kebab "camelCase")
              "camel-case"
              "Convert camelCase to kebab-case")

  (assert-test (assembly-package-generator:camel-to-kebab "PascalCase")
              "pascal-case"
              "Convert PascalCase to kebab-case")

  (assert-test (assembly-package-generator:camel-to-kebab "SomeMHTMLMethod")
              "some-mhtml-method"
              "Convert SomeMHTMLMethod to kebab-case")

  ;; 1a. Confirm camel-to-kebab itself leaves '+' untouched: it is also
  ;; applied to already-mapped operator/member names, and AssemblyToLispy.cs
  ;; maps the C# '+' operator (op_Addition) to the literal one-character
  ;; Lisp name "+" upstream, so camel-to-kebab must not corrupt it.
  (assert-test (assembly-package-generator:camel-to-kebab "+")
              "+"
              "camel-to-kebab leaves a bare '+' operator name untouched")

  ;; 1b. Test type-fq-name-to-pkg-name on nested-type CIL names (CIL uses
  ;; '+' as the nested-type separator; it must flatten to '-' the same as
  ;; '.', with no doubled hyphen at the boundary), one/two/three levels deep.
  (assert-test (assembly-package-generator:type-fq-name-to-pkg-name "Microsoft.Xna.Framework.Graphics.SpriteFont+Glyph")
              "microsoft-xna-framework-graphics-sprite-font-glyph"
              "Convert one-level-nested SpriteFont+Glyph to a package name")

  (assert-test (assembly-package-generator:type-fq-name-to-pkg-name "A+B+C")
              "a-b-c"
              "Convert two-level-nested A+B+C to a package name")

  (assert-test (assembly-package-generator:type-fq-name-to-pkg-name "Outer+Middle+Inner+Deepest")
              "outer-middle-inner-deepest"
              "Convert three-level-nested Outer+Middle+Inner+Deepest to a package name")

  ;; 1c. Test type-fq-name-to-pkg-name on open-generic-type backtick arity
  ;; suffixes (a raw backtick in a generated symbol/package name is
  ;; misread by the Lisp reader as the backquote macro character), alone
  ;; and combined with nested-type '+'.
  (assert-test (assembly-package-generator:type-fq-name-to-pkg-name "System.Action`4")
              "system-action-4"
              "Convert generic-arity System.Action`4 to a package name")

  (assert-test (assembly-package-generator:type-fq-name-to-pkg-name "System.Collections.Generic.Dictionary`2")
              "system-collections-generic-dictionary-2"
              "Convert generic-arity Dictionary`2 to a package name")

  (assert-test (assembly-package-generator:type-fq-name-to-pkg-name "System.Collections.Generic.Dictionary`2+KeyCollection")
              "system-collections-generic-dictionary-2-key-collection"
              "Convert a nested type inside a generic type (backtick and '+' together) to a package name")


  ;; 2. Test split-string
  (assert-test (assembly-package-generator:split-string "System.Console;System.Math")
              '("System.Console" "System.Math")
              "Split string by semicolon")

  (assert-test (assembly-package-generator:split-string "System.Console")
              '("System.Console")
              "Split single element string")

  (assert-test (assembly-package-generator:split-string "")
              '("")
              "Split empty string")


  ;; 3. Test simple-method-p and classification helper logic using mock plists
  (let ((methods-list
          '(
            ;; 1. Simple valid method
            (:name "WriteLine" :is-static t :return-type "System.Void" :parameters nil)
            ;; 2. Overloaded method (two of this name)
            (:name "Write" :is-static t :return-type "System.Void" :parameters nil)
            (:name "Write" :is-static t :return-type "System.Void" :parameters ((:name "value" :type "System.String")))
            ;; 3. Generic method
            (:name "GenericMethod" :is-static t :return-type "!!0" :parameters nil)
            ;; 4. Method with ref parameter
            (:name "RefMethod" :is-static t :return-type "System.Void" :parameters ((:name "value" :type "System.Int32" :ref t)))
            ;; 5. Property accessor
            (:name "get_Title" :is-static t :return-type "System.String" :parameters nil)
            ;; 6. Generic method with arity 1
            (:name "GenericArity1" :is-static t :is-generic t :generic-arity 1 :return-type "T" :parameters nil)
            ;; 7. Generic method with arity 2
            (:name "GenericArity2" :is-static t :is-generic t :generic-arity 2 :return-type "T" :parameters nil)
            )))

    (assert-test (assembly-package-generator::simple-method-p
                  (first methods-list)
                  methods-list)
                t
                "simple-method-p accepts simple non-overloaded method")

    (assert-test (assembly-package-generator::simple-method-p
                  (second methods-list)
                  methods-list)
                nil
                "simple-method-p rejects overloaded method (Write)")

    (assert-test (assembly-package-generator::simple-method-p
                  (fourth methods-list)
                  methods-list)
                nil
                "simple-method-p rejects generic method (GenericMethod)")

    (assert-test (assembly-package-generator::simple-method-p
                  (fifth methods-list)
                  methods-list)
                nil
                "simple-method-p rejects method with ref parameter (RefMethod)")

    (assert-test (assembly-package-generator::simple-method-p
                  (sixth methods-list)
                  methods-list)
                nil
                "simple-method-p rejects property getter method (get_Title)")

    (assert-test (assembly-package-generator::simple-method-p
                  (nth 6 methods-list)
                  methods-list)
                t
                "simple-method-p accepts generic method of arity 1")

    (assert-test (assembly-package-generator::simple-method-p
                  (nth 7 methods-list)
                  methods-list)
                nil
                "simple-method-p rejects generic method of arity 2"))

  ;; 3.5 Test clean-constructor-p and constructor-overload-name helper logic using mock plists
  (let ((ctors-list
          '(
            ;; 1. Simple clean constructor with no parameters
            (:parameters nil :public t)
            ;; 2. Clean constructor with parameters
            (:parameters ((:name "x" :type "System.Single") (:name "y" :type "System.Single")) :public t)
            ;; 3. Constructor with ref parameter (dirty)
            (:parameters ((:name "value" :type "System.Int32" :ref t)) :public t)
            )))

    (assert-test (assembly-package-generator::clean-constructor-p (first ctors-list))
                t
                "clean-constructor-p accepts clean parameterless constructor")

    (assert-test (assembly-package-generator::clean-constructor-p (second ctors-list))
                t
                "clean-constructor-p accepts clean parameterized constructor")

    (assert-test (assembly-package-generator::clean-constructor-p (third ctors-list))
                nil
                "clean-constructor-p rejects constructor with ref parameter")

    (assert-test (assembly-package-generator::constructor-overload-name (first ctors-list))
                "new"
                "constructor-overload-name for parameterless constructor is new")

    (assert-test (assembly-package-generator::constructor-overload-name (second ctors-list))
                "new-single-single"
                "constructor-overload-name for parameterized constructor matches types"))

  ;; 3.6 Regression test for the positional-parameter-name-collision bug found
  ;; while implementing Overload Consolidation (generator v24, PLAN.md): two
  ;; overloads of unrelated arity can coincidentally reuse the same parameter
  ;; name at two different positional dispatch slots (e.g. System.TimeSpan's
  ;; 3-arg and 4-arg constructors each have an unrelated "Seconds" parameter,
  ;; at slot index 2 and 3 respectively), which previously produced an
  ;; invalid duplicate-variable lambda list.
  (let ((params (list '(:name "Ticks" :type "System.Int64")
                       '(:name "Seconds" :type "System.Int32")
                       '(:name "Seconds" :type "System.Int32")
                       '(:name "Milliseconds" :type "System.Int32"))))
    (assert-test (mapcar (lambda (p) (getf p :name))
                          (assembly-package-generator::uniquify-positional-params params))
                '("Ticks" "Seconds" "Seconds2" "Milliseconds")
                "uniquify-positional-params disambiguates a repeated positional parameter name")

    (assert-test (mapcar (lambda (p) (getf p :name))
                          (assembly-package-generator::uniquify-positional-params
                           (list '(:name "X" :type "System.Single")
                                 '(:name "Y" :type "System.Single"))))
                '("X" "Y")
                "uniquify-positional-params leaves already-distinct names untouched"))

  ;; 3.7 Regression test: generate-constructor-master-wrapper's emitted lambda
  ;; list must never contain a duplicate variable name, even for a
  ;; System.TimeSpan-shaped set of constructor overloads (0, 1, 3, and 4
  ;; mandatory parameters, with an unrelated "seconds" parameter shared by
  ;; the 3-arg and 4-arg overloads at different positions).
  (let* ((ctors-list
           '((:parameters nil :public t)
             (:parameters ((:name "ticks" :type "System.Int64")) :public t)
             (:parameters ((:name "hours" :type "System.Int32")
                           (:name "minutes" :type "System.Int32")
                           (:name "seconds" :type "System.Int32")) :public t)
             (:parameters ((:name "days" :type "System.Int32")
                           (:name "hours" :type "System.Int32")
                           (:name "minutes" :type "System.Int32")
                           (:name "seconds" :type "System.Int32")) :public t)))
         (output (with-output-to-string (s)
                   (assembly-package-generator::generate-constructor-master-wrapper
                    s ctors-list "System.TimeSpan")))
         (defun-line (first (assembly-package-generator::split-string output #\Newline))))

    (assert-test (not (null (search "(seconds cl:nil supplied-seconds)" defun-line)))
                t
                "constructor master wrapper keeps the first colliding 'seconds' slot name as-is")

    (assert-test (not (null (search "(seconds2 cl:nil supplied-seconds2)" defun-line)))
                t
                "constructor master wrapper disambiguates the second colliding 'seconds' slot")

    (let* ((form (read-from-string (concatenate 'string defun-line ")")))
           (arglist (third form))
           (var-names (mapcar (lambda (a) (if (consp a) (first a) a)) arglist))
           (var-names (remove-if (lambda (s) (member s '(cl:&optional cl:&key cl:&rest))) var-names)))
      (assert-test (length var-names)
                  (length (remove-duplicates var-names))
                  "constructor master wrapper's lambda list has no duplicate parameter names (would be an invalid defun)")))

  ;; 3.8 Regression test: compute-package-exports-and-shadows no longer
  ;; exports type-suffixed overload names for multi-overload methods or
  ;; multi-overload constructors (Overload Consolidation, generator v24) --
  ;; only the Master Wrapper name(s) (plus a mixed-mode "*"-suffixed static
  ;; name, for methods) should be exported.
  (let ((class-plist
          '(:fields nil
            :properties nil
            :kind :class
            :constructors ((:parameters nil :public t)
                           (:parameters ((:name "x" :type "System.Single")) :public t))
            :methods ((:name "Foo" :is-static t :return-type "System.Void" :parameters nil)
                      (:name "Foo" :is-static t :return-type "System.Void"
                       :parameters ((:name "x" :type "System.Single")))))))
    (multiple-value-bind (exports shadows)
        (assembly-package-generator::compute-package-exports-and-shadows class-plist nil)
      (declare (ignore shadows))
      (assert-test (and (member "new" exports :test #'string=) t)
                  t
                  "compute-package-exports-and-shadows exports 'new' for a multi-overload constructor")
      (assert-test (and (member "foo" exports :test #'string=) t)
                  t
                  "compute-package-exports-and-shadows exports the Master Wrapper name for a multi-overload method")
      (assert-test (and (member "new-single" exports :test #'string=) t)
                  nil
                  "compute-package-exports-and-shadows no longer exports type-suffixed constructor names")
      (assert-test (and (member "foo-single" exports :test #'string=) t)
                  nil
                  "compute-package-exports-and-shadows no longer exports type-suffixed method names")))

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
            (assert-test (cdr (assoc "Fixture.ClassA" resolved
                                     :key (lambda (cls) (getf cls :fully-qualified-name))
                                     :test #'string=))
                        '("*")
                        "resolve-batch-entry keeps ClassA's own constant-properties")
            (assert-test (cdr (assoc "Fixture.ClassB" resolved
                                     :key (lambda (cls) (getf cls :fully-qualified-name))
                                     :test #'string=))
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

  (format *error-output* "--- Package Generator Tests Completed ---~%"))
