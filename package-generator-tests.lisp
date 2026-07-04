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
            ;; 8. Generic method with arity 3 (e.g. LINQ's Aggregate<TSource,TAccumulate,TResult>)
            (:name "GenericArity3" :is-static t :is-generic t :generic-arity 3 :return-type "T" :parameters nil)
            ;; 9. Malformed: :is-generic t but no (or a non-positive) :generic-arity
            (:name "GenericArityMissing" :is-static t :is-generic t :return-type "T" :parameters nil)
            (:name "GenericArityZero" :is-static t :is-generic t :generic-arity 0 :return-type "T" :parameters nil)
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
                t
                "simple-method-p accepts generic method of arity 2 (arity > 1 is now supported)")

    (assert-test (assembly-package-generator::simple-method-p
                  (nth 8 methods-list)
                  methods-list)
                t
                "simple-method-p accepts generic method of arity 3")

    (assert-test (assembly-package-generator::simple-method-p
                  (nth 9 methods-list)
                  methods-list)
                nil
                "simple-method-p rejects a generic method with a missing :generic-arity")

    (assert-test (assembly-package-generator::simple-method-p
                  (nth 10 methods-list)
                  methods-list)
                nil
                "simple-method-p rejects a generic method with :generic-arity 0"))

  ;; 3.1 Test generic-type-param-names: the arity-1 case keeps the legacy
  ;; single "type" name (so existing arity-1 generated code and callers are
  ;; unaffected), while arity > 1 introduces "type-1".."type-N".
  (assert-test (assembly-package-generator::generic-type-param-names 1)
              '("type")
              "generic-type-param-names 1 returns the legacy singular 'type' name")

  (assert-test (assembly-package-generator::generic-type-param-names 2)
              '("type-1" "type-2")
              "generic-type-param-names 2 returns type-1 and type-2")

  (assert-test (assembly-package-generator::generic-type-param-names 3)
              '("type-1" "type-2" "type-3")
              "generic-type-param-names 3 returns type-1 through type-3")

  ;; 3.2 Test split-by-generic-arity: overloads of the same C# method name
  ;; that disagree on generic arity (e.g. System.Linq.Enumerable's
  ;; Aggregate<TSource>, Aggregate<TSource,TAccumulate>, and
  ;; Aggregate<TSource,TAccumulate,TResult>) must split into separate cells,
  ;; since one Lisp function's lambda list cannot flex between different
  ;; numbers of generic type-argument parameters; overloads sharing an
  ;; arity (or all non-generic) must stay together in one cell.
  (let ((aggregate-like
          (list '(:name "Aggregate" :is-static t :is-generic t :generic-arity 1
                  :return-type "TSource"
                  :parameters ((:name "source" :type "System.Collections.Generic.IEnumerable`1[TSource]")
                               (:name "func" :type "System.Func`3[TSource, TSource, TSource]")))
                '(:name "Aggregate" :is-static t :is-generic t :generic-arity 2
                  :return-type "TAccumulate"
                  :parameters ((:name "source" :type "System.Collections.Generic.IEnumerable`1[TSource]")
                               (:name "seed" :type "TAccumulate")
                               (:name "func" :type "System.Func`3[TAccumulate, TSource, TAccumulate]")))
                '(:name "Aggregate" :is-static t :is-generic t :generic-arity 3
                  :return-type "TResult"
                  :parameters ((:name "source" :type "System.Collections.Generic.IEnumerable`1[TSource]")
                               (:name "seed" :type "TAccumulate")
                               (:name "func" :type "System.Func`3[TAccumulate, TSource, TAccumulate]")
                               (:name "resultSelector" :type "System.Func`2[TAccumulate, TResult]"))))))
    (assert-test (length (assembly-package-generator::split-by-generic-arity aggregate-like))
                3
                "split-by-generic-arity splits Aggregate's arity-1/2/3 overloads into 3 cells")

    (assert-test (mapcar (lambda (cell) (getf (first cell) :generic-arity))
                         (assembly-package-generator::split-by-generic-arity aggregate-like))
                '(1 2 3)
                "split-by-generic-arity preserves first-seen arity order (1, 2, 3)")

    (assert-test (mapcar #'assembly-package-generator::generic-arity-suffix
                         (assembly-package-generator::split-by-generic-arity aggregate-like))
                '("-arity-1" "-arity-2" "-arity-3")
                "generic-arity-suffix names each Aggregate cell distinctly")

    (assert-test (assembly-package-generator::generic-arity-dispatch-mode
                  (assembly-package-generator::split-by-generic-arity aggregate-like))
                :split-all-generic
                "generic-arity-dispatch-mode classifies all-generic multi-arity Aggregate as :split-all-generic")

    (assert-test (assembly-package-generator::method-name-wrapper-names aggregate-like "aggregate")
                '("aggregate")
                "method-name-wrapper-names exports only bare 'aggregate' (the dispatcher) for multi-arity Aggregate, never the internal -arity-N names"))

  ;; 3.2b :split-with-plain -- a non-generic overload coexists with generic
  ;; ones at other arities: two exported names, bare base-name (non-generic
  ;; overload) plus base-name<> (dispatcher over the generic cells).
  (let ((mixed-generic-and-plain
          (list '(:name "Foo" :is-static t :return-type "System.Void"
                  :parameters ((:name "value" :type "System.String")))
                '(:name "Foo" :is-static t :is-generic t :generic-arity 1
                  :return-type "T"
                  :parameters ((:name "value" :type "T"))))))
    (assert-test (assembly-package-generator::generic-arity-dispatch-mode
                  (assembly-package-generator::split-by-generic-arity mixed-generic-and-plain))
                :split-with-plain
                "generic-arity-dispatch-mode classifies a non-generic+generic mix as :split-with-plain")

    (assert-test (assembly-package-generator::method-name-wrapper-names mixed-generic-and-plain "foo")
                '("foo" "foo<>")
                "method-name-wrapper-names exports 'foo' and 'foo<>' when a non-generic overload coexists with generic ones"))

  ;; 3.3 Test split-by-generic-arity / method-name-wrapper-names in the
  ;; common single-arity case (e.g. LINQ's Select<TSource,TResult>, which
  ;; has multiple overloads that all share generic-arity 2): must stay in
  ;; one cell and keep the plain (unsuffixed) base name, exactly as if
  ;; generic-arity splitting didn't exist.
  (let ((select-like
          (list '(:name "Select" :is-static t :is-generic t :generic-arity 2
                  :return-type "System.Collections.Generic.IEnumerable`1[TResult]"
                  :parameters ((:name "source" :type "System.Collections.Generic.IEnumerable`1[TSource]")
                               (:name "selector" :type "System.Func`2[TSource, TResult]")))
                '(:name "Select" :is-static t :is-generic t :generic-arity 2
                  :return-type "System.Collections.Generic.IEnumerable`1[TResult]"
                  :parameters ((:name "source" :type "System.Collections.Generic.IEnumerable`1[TSource]")
                               (:name "selector" :type "System.Func`3[TSource, System.Int32, TResult]"))))))
    (assert-test (length (assembly-package-generator::split-by-generic-arity select-like))
                1
                "split-by-generic-arity keeps same-arity Select overloads in one cell")

    (assert-test (assembly-package-generator::method-name-wrapper-names select-like "select")
                '("select")
                "method-name-wrapper-names keeps the plain base name when there's only one arity cell"))

  ;; 3.4 Non-generic methods of the same name (ordinary overloads) must
  ;; also stay in one cell (nil generic-arity key for all of them).
  (let ((ordinary-overloads
          (list '(:name "Write" :is-static t :return-type "System.Void" :parameters nil)
                '(:name "Write" :is-static t :return-type "System.Void"
                  :parameters ((:name "value" :type "System.String"))))))
    (assert-test (length (assembly-package-generator::split-by-generic-arity ordinary-overloads))
                1
                "split-by-generic-arity keeps non-generic overloads in one cell")
    (assert-test (assembly-package-generator::method-name-wrapper-names ordinary-overloads "write")
                '("write")
                "method-name-wrapper-names keeps the plain base name for non-generic overloads"))

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

  ;; 6. Indexer codegen: generate-class-file must pass a property's own index
  ;;    parameters through to get_Item/set_Item, and must skip (with a
  ;;    documenting comment, not a defun) an indexer overloaded across
  ;;    multiple index-parameter signatures.
  (let* ((class-plist
           '(:fully-qualified-name "Fixture.Indexed"
             :kind :class
             :fields nil
             :properties ((:name "Item" :type "System.Int32" :readable t :writeable t
                           :get-method "get_Item" :set-method "set_Item"
                           :parameters ((:name "index" :type "System.Int32"))))
             :methods nil
             :constructors nil))
         (out-dir (merge-pathnames "package-generator-tests-indexer-out/"
                                   (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist out-dir)
          (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
          (let* ((class-file (merge-pathnames "fixture-indexed.lisp" out-dir))
                 (contents (uiop:read-file-string class-file)))
            (assert-test (not (null (search "(cl:defun item (obj! index)" contents))) t
                        "generate-class-file emits an indexer getter taking the index parameter")
            (assert-test (not (null (search "\"get_Item\" index))" contents))) t
                        "generate-class-file's indexer getter passes the index through to get_Item")
            (assert-test (not (null (search "(cl:defun (cl:setf item) (new-value obj! index)" contents))) t
                        "generate-class-file emits an indexer setter taking new-value and the index parameter")
            (assert-test (not (null (search "\"set_Item\" index new-value))" contents))) t
                        "generate-class-file's indexer setter passes index then new-value to set_Item")))
      (when (probe-file out-dir)
        (uiop:delete-directory-tree out-dir :validate t))))

  ;; 6.1 Overloaded indexer (multiple index-parameter signatures) is not yet
  ;;     supported: it must be documented in a comment, not turned into a
  ;;     (guessed, likely wrong) single defun.
  (let* ((class-plist
           '(:fully-qualified-name "Fixture.OverloadedIndexed"
             :kind :class
             :fields nil
             :properties ((:name "Item" :type "System.Int32" :readable t :writeable t
                           :get-method "get_Item" :set-method "set_Item"
                           :parameters ((:name "index" :type "System.Int32")))
                          (:name "Item" :type "System.Int32" :readable t :writeable t
                           :get-method "get_Item" :set-method "set_Item"
                           :parameters ((:name "key" :type "System.String"))))
             :methods nil
             :constructors nil))
         (out-dir (merge-pathnames "package-generator-tests-indexer-overload-out/"
                                   (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist out-dir)
          (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
          (let* ((class-file (merge-pathnames "fixture-overloaded-indexed.lisp" out-dir))
                 (contents (uiop:read-file-string class-file)))
            (assert-test (not (null (search "not yet supported" contents))) t
                        "generate-class-file documents an overloaded indexer as not yet supported")
            (assert-test (search "(cl:defun item " contents) nil
                        "generate-class-file does not emit a guessing defun for an overloaded indexer")))
      (when (probe-file out-dir)
        (uiop:delete-directory-tree out-dir :validate t))))

  ;; 7. Public instance fields: generate-class-file must emit a getter (and,
  ;;    unless the field is read-only) a setter for every public instance
  ;;    field, using dotnet:invoke's GetField support for the getter and the
  ;;    setf-expansion of dotnet:invoke (documented in
  ;;    doc/dotnet-dotcl-interop.md) for the setter, since fields have no
  ;;    get_Foo/set_Foo accessor methods to invoke by name the way properties do.
  (let* ((class-plist
           '(:fully-qualified-name "Fixture.Fielded"
             :kind :class
             :fields ((:name "Count" :type "System.Int32" :public t
                       :documentation (:summary "A mutable public instance field."))
                      (:name "Id" :type "System.Int32" :public t :init-only t
                       :documentation (:summary "A read-only public instance field.")))
             :properties nil
             :methods nil
             :constructors nil))
         (out-dir (merge-pathnames "package-generator-tests-fields-out/"
                                   (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist out-dir)
          (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
          (let* ((class-file (merge-pathnames "fixture-fielded.lisp" out-dir))
                 (contents (uiop:read-file-string class-file)))
            (assert-test (not (null (search "(cl:defun count (obj!)" contents))) t
                        "generate-class-file emits a getter for a mutable public instance field")
            (assert-test (not (null (search "(dotnet:invoke (cl:the (dotnet \"Fixture.Fielded\") obj!) \"Count\"))" contents))) t
                        "generate-class-file's field getter invokes the field by its C# name")
            (assert-test (not (null (search "(cl:defun (cl:setf count) (new-value obj!)" contents))) t
                        "generate-class-file emits a setter for a mutable public instance field")
            (assert-test (not (null (search "(cl:setf (dotnet:invoke (cl:the (dotnet \"Fixture.Fielded\") obj!) \"Count\") new-value))" contents))) t
                        "generate-class-file's field setter uses the setf-expansion of dotnet:invoke")
            (assert-test (not (null (search "(cl:defun id (obj!)" contents))) t
                        "generate-class-file emits a getter for a read-only public instance field")
            (assert-test (search "(cl:defun (cl:setf id)" contents) nil
                        "generate-class-file emits no setter for a read-only (:init-only) public instance field"))
          (multiple-value-bind (exports shadows) (assembly-package-generator::compute-package-exports-and-shadows class-plist nil)
            (declare (ignore shadows))
            (assert-test (and (member "count" exports :test #'string=) t) t
                        "compute-package-exports-and-shadows exports the mutable field's name")
            (assert-test (and (member "id" exports :test #'string=) t) t
                        "compute-package-exports-and-shadows exports the read-only field's name too (getter only)")))
      (when (probe-file out-dir)
        (uiop:delete-directory-tree out-dir :validate t))))

  ;; 8. Generic method of arity 2, single (non-overloaded) signature: must
  ;;    go through generate-single-overload with two type-argument
  ;;    parameters (type-1, type-2) instead of the legacy single "type".
  (let* ((class-plist
           '(:fully-qualified-name "Fixture.Converter"
             :kind :class
             :fields nil
             :properties nil
             :methods ((:name "Convert" :is-static t :is-generic t :generic-arity 2
                        :return-type "T2"
                        :parameters ((:name "value" :type "T1"))))
             :constructors nil))
         (out-dir (merge-pathnames "package-generator-tests-generic-arity2-out/"
                                   (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist out-dir)
          (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
          (let* ((class-file (merge-pathnames "fixture-converter.lisp" out-dir))
                 (contents (uiop:read-file-string class-file)))
            (assert-test (not (null (search "(cl:defun convert (type-1 type-2 value)" contents))) t
                        "generate-class-file's arity-2 generic method takes type-1 and type-2 parameters")
            (assert-test (not (null (search "(dotnet:static-generic <type-str> \"Convert\" (cl:list type-1 type-2) value))" contents))) t
                        "generate-class-file's arity-2 generic method passes both type arguments to dotnet:static-generic")))
      (when (probe-file out-dir)
        (uiop:delete-directory-tree out-dir :validate t))))

  ;; 9. Generic method of arity 2 with multiple overloads sharing that
  ;;    arity (e.g. LINQ's Select<TSource,TResult>, overloaded on the
  ;;    selector's own parameter count): must produce one Master Wrapper
  ;;    (not two functions), taking type-1/type-2 once, dispatching at
  ;;    runtime between the two clean overloads exactly like a non-generic
  ;;    overloaded method would.
  (let* ((class-plist
           '(:fully-qualified-name "Fixture.Selector"
             :kind :class
             :fields nil
             :properties nil
             :methods ((:name "Select" :is-static t :is-generic t :generic-arity 2
                        :return-type "T2"
                        :parameters ((:name "source" :type "T1") (:name "selector" :type "T2")))
                       (:name "Select" :is-static t :is-generic t :generic-arity 2
                        :return-type "T2"
                        :parameters ((:name "source" :type "T1") (:name "selector" :type "T2") (:name "extra" :type "System.Int32"))))
             :constructors nil))
         (out-dir (merge-pathnames "package-generator-tests-generic-arity2-overload-out/"
                                   (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist out-dir)
          (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
          (let* ((class-file (merge-pathnames "fixture-selector.lisp" out-dir))
                 (contents (uiop:read-file-string class-file)))
            (assert-test (not (null (search "(cl:defun select (type-1 type-2 source selector" contents))) t
                        "generate-class-file's Master Wrapper for overloaded arity-2 generics binds type-1/type-2 once")
            (assert-test (not (null (search "(dotnet:static-generic <type-str> \"Select\" (cl:list type-1 type-2)" contents))) t
                        "generate-class-file's Master Wrapper dispatch action passes both type arguments")
            (assert-test (search "(cl:defun select-arity-2" contents) nil
                        "generate-class-file does not arity-suffix a name with only one generic-arity cell")))
      (when (probe-file out-dir)
        (uiop:delete-directory-tree out-dir :validate t))))

  ;; 10. Same C# method name overloaded across *different* generic arities
  ;;     (System.Linq.Enumerable's real-world Aggregate<TSource>,
  ;;     Aggregate<TSource,TAccumulate>, and
  ;;     Aggregate<TSource,TAccumulate,TResult>): one Lisp function's lambda
  ;;     list can't flex between different type-argument counts, so each
  ;;     arity still gets its own arity-suffixed function body (unchanged
  ;;     from Version 27), but that function is now internal/unexported --
  ;;     the bare "aggregate" name is now a public dispatcher
  ;;     (generate-generic-arity-dispatcher) that resolves the right one at
  ;;     runtime by counting the type argument(s) it's given.
  (let* ((class-plist
           '(:fully-qualified-name "Fixture.Aggregator"
             :kind :class
             :fields nil
             :properties nil
             :methods ((:name "Aggregate" :is-static t :is-generic t :generic-arity 1
                        :return-type "T1"
                        :parameters ((:name "source" :type "T1") (:name "func" :type "System.Object")))
                       (:name "Aggregate" :is-static t :is-generic t :generic-arity 2
                        :return-type "T2"
                        :parameters ((:name "source" :type "T1") (:name "seed" :type "T2") (:name "func" :type "System.Object"))))
             :constructors nil))
         (out-dir (merge-pathnames "package-generator-tests-generic-multi-arity-out/"
                                   (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist out-dir)
          (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
          (let* ((class-file (merge-pathnames "fixture-aggregator.lisp" out-dir))
                 (contents (uiop:read-file-string class-file)))
            (assert-test (not (null (search "(cl:defun aggregate-arity-1 (type source func)" contents))) t
                        "generate-class-file still generates the arity-1 Aggregate overload's body (now internal/unexported)")
            (assert-test (not (null (search "(cl:defun aggregate-arity-2 (type-1 type-2 source seed func)" contents))) t
                        "generate-class-file still generates the arity-2 Aggregate overload's body (now internal/unexported)")
            (assert-test (not (null (search "(cl:defun aggregate (types cl:&rest args)" contents))) t
                        "generate-class-file emits a bare 'aggregate' dispatcher when Aggregate spans multiple arities")
            (assert-test (not (null (search "(cl:case (cl:length type-list)" contents))) t
                        "the aggregate dispatcher dispatches on the count of supplied type arguments")
            (assert-test (not (null (search "(1 (cl:apply (cl:function aggregate-arity-1) (cl:append type-list args)))" contents))) t
                        "the aggregate dispatcher's arity-1 case applies aggregate-arity-1")
            (assert-test (not (null (search "(2 (cl:apply (cl:function aggregate-arity-2) (cl:append type-list args)))" contents))) t
                        "the aggregate dispatcher's arity-2 case applies aggregate-arity-2"))
          (multiple-value-bind (exports shadows) (assembly-package-generator::compute-package-exports-and-shadows class-plist nil)
            (declare (ignore shadows))
            (assert-test (and (member "aggregate-arity-1" exports :test #'string=) t) nil
                        "compute-package-exports-and-shadows no longer exports the internal aggregate-arity-1")
            (assert-test (and (member "aggregate-arity-2" exports :test #'string=) t) nil
                        "compute-package-exports-and-shadows no longer exports the internal aggregate-arity-2")
            (assert-test (and (member "aggregate" exports :test #'string=) t) t
                        "compute-package-exports-and-shadows exports the bare 'aggregate' dispatcher for the multi-arity case")))
      (when (probe-file out-dir)
        (uiop:delete-directory-tree out-dir :validate t))))

  ;; 11. A non-generic overload coexisting with generic ones at other
  ;;     arities (:split-with-plain): base-name handles the non-generic
  ;;     call, base-name<> dispatches the generic cells and falls through to
  ;;     base-name itself when given an empty type list.
  (let* ((class-plist
           '(:fully-qualified-name "Fixture.MixedFoo"
             :kind :class
             :fields nil
             :properties nil
             :methods ((:name "Foo" :is-static t :return-type "System.Void"
                        :parameters ((:name "value" :type "System.String")))
                       (:name "Foo" :is-static t :is-generic t :generic-arity 1
                        :return-type "T"
                        :parameters ((:name "value" :type "T"))))
             :constructors nil))
         (out-dir (merge-pathnames "package-generator-tests-generic-mixed-plain-out/"
                                   (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist out-dir)
          (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
          (let* ((class-file (merge-pathnames "fixture-mixed-foo.lisp" out-dir))
                 (contents (uiop:read-file-string class-file)))
            (assert-test (not (null (search "(cl:defun foo (value)" contents))) t
                        "generate-class-file gives the non-generic Foo overload the bare base name")
            (assert-test (not (null (search "(cl:defun foo<> (types cl:&rest args)" contents))) t
                        "generate-class-file emits a foo<> dispatcher for the generic Foo overload(s)")
            (assert-test (not (null (search "(0 (cl:apply (cl:function foo) args))" contents))) t
                        "the foo<> dispatcher's arity-0 case falls through to the plain foo function"))
          (multiple-value-bind (exports shadows) (assembly-package-generator::compute-package-exports-and-shadows class-plist nil)
            (declare (ignore shadows))
            (assert-test (and (member "foo" exports :test #'string=) t) t
                        "compute-package-exports-and-shadows exports 'foo'")
            (assert-test (and (member "foo<>" exports :test #'string=) t) t
                        "compute-package-exports-and-shadows exports 'foo<>'")))
      (when (probe-file out-dir)
        (uiop:delete-directory-tree out-dir :validate t))))

  ;; 12. Operator overload codegen: mapped operator methods (:name already the
  ;;     clean symbol, e.g. "%" for op_Modulus, per AssemblyToLispy.cs's
  ;;     GetCleanMethodName) flow through the ordinary clean-method pipeline
  ;;     unchanged -- no operator-specific codegen branch exists or is needed.
  ;;     A newly-mapped binary operator (op_Modulus -> "%") and a unary
  ;;     operator sharing another binary operator's symbol via arity
  ;;     (op_UnaryNegation -> "-", alongside a same-named binary "-" for
  ;;     op_Subtraction) must both generate correctly, invoking the real CLR
  ;;     method via :mangled-name rather than the mapped symbol name.
  (let* ((class-plist
           '(:fully-qualified-name "Fixture.OperatorStruct"
             :kind :struct
             :fields nil
             :properties nil
             :methods ((:name "%" :mangled-name "op_Modulus" :is-static t
                        :return-type "Fixture.OperatorStruct"
                        :parameters ((:name "a" :type "Fixture.OperatorStruct")
                                     (:name "b" :type "Fixture.OperatorStruct")))
                       (:name "-" :mangled-name "op_Subtraction" :is-static t
                        :return-type "Fixture.OperatorStruct"
                        :parameters ((:name "a" :type "Fixture.OperatorStruct")
                                     (:name "b" :type "Fixture.OperatorStruct")))
                       (:name "-" :mangled-name "op_UnaryNegation" :is-static t
                        :return-type "Fixture.OperatorStruct"
                        :parameters ((:name "a" :type "Fixture.OperatorStruct"))))
             :constructors nil))
         (out-dir (merge-pathnames "package-generator-tests-operator-out/"
                                   (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist out-dir)
          (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
          (let* ((class-file (merge-pathnames "fixture-operator-struct.lisp" out-dir))
                 (contents (uiop:read-file-string class-file)))
            (assert-test (not (null (search "(cl:defun % (a b)" contents))) t
                        "generate-class-file emits a wrapper for a newly-mapped operator (op_Modulus -> %)")
            (assert-test (not (null (search "\"op_Modulus\"" contents))) t
                        "generate-class-file's % wrapper invokes the real CLR method via :mangled-name")
            (assert-test (not (null (search "\"op_Subtraction\"" contents))) t
                        "generate-class-file's binary - wrapper invokes op_Subtraction")
            (assert-test (not (null (search "\"op_UnaryNegation\"" contents))) t
                        "generate-class-file's unary - wrapper invokes op_UnaryNegation")))
      (when (probe-file out-dir)
        (uiop:delete-directory-tree out-dir :validate t))))

  (format *error-output* "--- Package Generator Tests Completed ---~%"))
