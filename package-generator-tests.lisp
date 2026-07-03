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
           "9.9.9")

          (let ((asd-file (merge-pathnames "csharp-assembly-packages.asd" out-dir)))
            (assert-test (not (null (probe-file asd-file))) t
                        "generate-assembly-packages-batch emits csharp-assembly-packages.asd")

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
                          '("fixture-class-b" "fixture-class-a")
                          "csharp-assembly-packages.asd lists classes as :file components in request order"))))
      (when (probe-file fixture-file)
        (delete-file fixture-file))
      (when (probe-file out-dir)
        (uiop:delete-directory-tree out-dir :validate t))))

  (format *error-output* "--- Package Generator Tests Completed ---~%"))
