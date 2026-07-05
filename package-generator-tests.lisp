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
  (flet ((find-resolved (fq-name resolved)
           (find fq-name resolved
                 :key (lambda (rc) (getf (getf rc :class-plist) :fully-qualified-name))
                 :test #'string=)))
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
        (delete-file fixture-file)))))

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

  ;; 7.1 Writeable static properties and plain mutable static fields:
  ;;     generate-class-file must emit a getter/setf-expander pair for a
  ;;     static read-write property, a set-name function only (no getter,
  ;;     no setf) for a static write-only property, and a getter/setf-
  ;;     expander pair for a plain mutable static field -- all three
  ;;     previously matched no classifier and generated nothing at all
  ;;     (see PLAN.md / FEATURES.md's Unsupported Features). Unlike the
  ;;     instance property/field case, these use dotnet:static directly
  ;;     (no obj! receiver).
  (let* ((class-plist
           '(:fully-qualified-name "Fixture.StaticWriteable"
             :kind :class
             :fields ((:name "Total" :type "System.Int32" :static t
                       :documentation (:summary "A plain mutable static field.")))
             :properties ((:name "Mode" :type "System.Int32" :static t :readable t :writeable t
                           :documentation (:summary "A static read-write property."))
                          (:name "Sink" :type "System.Int32" :static t :writeable t
                           :documentation (:summary "A static write-only property.")))
             :methods nil
             :constructors nil))
         (out-dir (merge-pathnames "package-generator-tests-static-writeable-out/"
                                   (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist out-dir)
          (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
          (let* ((class-file (merge-pathnames "fixture-static-writeable.lisp" out-dir))
                 (contents (uiop:read-file-string class-file)))
            (assert-test (not (null (search "(cl:defun mode ()" contents))) t
                        "generate-class-file emits a getter for a static read-write property")
            (assert-test (not (null (search "(dotnet:static <type-str> \"Mode\"))" contents))) t
                        "generate-class-file's static property getter reads via dotnet:static")
            (assert-test (not (null (search "(cl:defun (cl:setf mode) (new-value)" contents))) t
                        "generate-class-file emits a setf-expander for a static read-write property")
            (assert-test (not (null (search "(cl:setf (dotnet:static <type-str> \"Mode\") new-value))" contents))) t
                        "generate-class-file's static property setter uses the setf-expansion of dotnet:static")
            (assert-test (search "(cl:defun sink ()" contents) nil
                        "generate-class-file emits no getter for a static write-only property")
            (assert-test (not (null (search "(cl:defun set-sink (new-value)" contents))) t
                        "generate-class-file emits a set-name function for a static write-only property")
            (assert-test (not (null (search "(cl:defun total ()" contents))) t
                        "generate-class-file emits a getter for a plain mutable static field")
            (assert-test (not (null (search "(dotnet:static <type-str> \"Total\"))" contents))) t
                        "generate-class-file's static field getter reads via dotnet:static")
            (assert-test (not (null (search "(cl:defun (cl:setf total) (new-value)" contents))) t
                        "generate-class-file emits a setf-expander for a plain mutable static field")
            (assert-test (not (null (search "(cl:setf (dotnet:static <type-str> \"Total\") new-value))" contents))) t
                        "generate-class-file's static field setter uses the setf-expansion of dotnet:static"))
          (multiple-value-bind (exports shadows) (assembly-package-generator::compute-package-exports-and-shadows class-plist nil)
            (declare (ignore shadows))
            (assert-test (and (member "mode" exports :test #'string=) t) t
                        "compute-package-exports-and-shadows exports the read-write static property's plain name")
            (assert-test (and (member "set-sink" exports :test #'string=) t) t
                        "compute-package-exports-and-shadows exports the write-only static property as set-sink")
            (assert-test (and (member "total" exports :test #'string=) t) t
                        "compute-package-exports-and-shadows exports the mutable static field's plain name")))
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

  ;; 13. Instance events: generate-class-file must emit an add-X/remove-X
  ;;     wrapper pair calling dotnet:add-event/dotnet:remove-event, per
  ;;     doc/generator-design-notes.md's Events (Version 32) section.
  (let* ((class-plist
           '(:fully-qualified-name "Fixture.Clickable"
             :kind :class
             :fields nil
             :properties nil
             :methods nil
             :constructors nil
             :events ((:name "Click" :type "System.EventHandler"
                       :add-method "add_Click" :remove-method "remove_Click"
                       :documentation (:summary "Fires on click.")))))
         (out-dir (merge-pathnames "package-generator-tests-events-out/"
                                   (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist out-dir)
          (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
          (let* ((class-file (merge-pathnames "fixture-clickable.lisp" out-dir))
                 (contents (uiop:read-file-string class-file)))
            (assert-test (not (null (search "(cl:defun add-click (obj! handler)" contents))) t
                        "generate-class-file emits an add-X wrapper for an instance event")
            (assert-test (not (null (search "(dotnet:add-event (cl:the (dotnet \"Fixture.Clickable\") obj!) \"Click\" handler))" contents))) t
                        "generate-class-file's add-X wrapper calls dotnet:add-event")
            (assert-test (not (null (search "(cl:defun remove-click (obj! handler)" contents))) t
                        "generate-class-file emits a remove-X wrapper for an instance event")
            (assert-test (not (null (search "(dotnet:remove-event (cl:the (dotnet \"Fixture.Clickable\") obj!) \"Click\" handler))" contents))) t
                        "generate-class-file's remove-X wrapper calls dotnet:remove-event"))
          (multiple-value-bind (exports shadows) (assembly-package-generator::compute-package-exports-and-shadows class-plist nil)
            (declare (ignore shadows))
            (assert-test (and (member "add-click" exports :test #'string=) t) t
                        "compute-package-exports-and-shadows exports add-click")
            (assert-test (and (member "remove-click" exports :test #'string=) t) t
                        "compute-package-exports-and-shadows exports remove-click")))
      (when (probe-file out-dir)
        (uiop:delete-directory-tree out-dir :validate t))))

  ;; 13.1 Event naming-collision fallback: a Click event alongside an
  ;;      unrelated AddClick()/RemoveClick() method pair must escalate to
  ;;      the tier-2 -event-suffixed names, and generate-class-file /
  ;;      compute-package-exports-and-shadows must agree on the result.
  (let* ((class-plist
           '(:fully-qualified-name "Fixture.CollidingClickable"
             :kind :class
             :fields nil
             :properties nil
             :methods ((:name "AddClick" :is-static nil :return-type "System.Void" :parameters nil)
                       (:name "RemoveClick" :is-static nil :return-type "System.Void" :parameters nil))
             :constructors nil
             :events ((:name "Click" :type "System.EventHandler"
                       :add-method "add_Click" :remove-method "remove_Click"))))
         (out-dir (merge-pathnames "package-generator-tests-events-collision-out/"
                                   (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist out-dir)
          (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
          (let* ((class-file (merge-pathnames "fixture-colliding-clickable.lisp" out-dir))
                 (contents (uiop:read-file-string class-file)))
            (assert-test (not (null (search "(cl:defun add-click-event (obj! handler)" contents))) t
                        "generate-class-file falls back to add-click-event when add-click collides with AddClick()")
            (assert-test (not (null (search "(cl:defun remove-click-event (obj! handler)" contents))) t
                        "generate-class-file falls back to remove-click-event when remove-click collides with RemoveClick()")
            (assert-test (search "(cl:defun add-click (obj! handler)" contents) nil
                        "generate-class-file does not also emit the colliding tier-1 add-click"))
          (multiple-value-bind (exports shadows) (assembly-package-generator::compute-package-exports-and-shadows class-plist nil)
            (declare (ignore shadows))
            (assert-test (and (member "add-click-event" exports :test #'string=) t) t
                        "compute-package-exports-and-shadows agrees on the add-click-event fallback")
            (assert-test (and (member "remove-click-event" exports :test #'string=) t) t
                        "compute-package-exports-and-shadows agrees on the remove-click-event fallback")))
      (when (probe-file out-dir)
        (uiop:delete-directory-tree out-dir :validate t))))

  ;; 7. Parents and interfaces: expand-ancestors walks the superclass chain
  ;;    and interfaces across a global metadata index (build-metadata-index),
  ;;    as used by generate-assembly-packages-batch for
  ;;    --export-parents/--export-interfaces/--export-object.
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
                  tbl)))

    ;; 7.1 export-parents alone walks the superclass chain, excluding System.Object by default.
    (multiple-value-bind (ancestors missing)
        (assembly-package-generator::expand-ancestors derived-plist t nil nil index)
      (assert-test missing nil
                  "expand-ancestors finds no missing ancestors when the full chain is in the index")
      (assert-test (mapcar (lambda (a) (getf (car a) :fully-qualified-name)) ancestors)
                  '("Fixture.Mid" "Fixture.Base")
                  "expand-ancestors (export-parents only) walks the superclass chain, excluding System.Object by default"))

    ;; 7.2 export-object also includes System.Object at the top of the chain.
    (multiple-value-bind (ancestors missing)
        (assembly-package-generator::expand-ancestors derived-plist t nil t index)
      (declare (ignore missing))
      (assert-test (mapcar (lambda (a) (getf (car a) :fully-qualified-name)) ancestors)
                  '("Fixture.Mid" "Fixture.Base" "System.Object")
                  "expand-ancestors includes System.Object when export-object is true"))

    ;; 7.3 export-interfaces alone walks only the interfaces list, not the superclass chain.
    (multiple-value-bind (ancestors missing)
        (assembly-package-generator::expand-ancestors derived-plist nil t nil index)
      (declare (ignore missing))
      (assert-test (mapcar (lambda (a) (getf (car a) :fully-qualified-name)) ancestors)
                  '("Fixture.IDerived")
                  "expand-ancestors (export-interfaces only) does not walk the superclass chain"))

    ;; 7.4 both flags together walk both graphs, recursing into each newly-found ancestor's own edges too.
    (multiple-value-bind (ancestors missing)
        (assembly-package-generator::expand-ancestors derived-plist t t nil index)
      (declare (ignore missing))
      (assert-test (sort (mapcar (lambda (a) (getf (car a) :fully-qualified-name)) ancestors) #'string<)
                  (sort (list "Fixture.Mid" "Fixture.Base" "Fixture.IDerived" "Fixture.IMid" "Fixture.IBase") #'string<)
                  "expand-ancestors with both flags walks superclasses and each ancestor's own interfaces"))

    ;; 7.5 An ancestor not present in the index is reported as missing, not silently dropped.
    (let ((sparse-index (let ((tbl (make-hash-table :test #'equal)))
                          (setf (gethash "Fixture.Derived" tbl) (cons derived-plist owning-entry))
                          (setf (gethash "Fixture.Mid" tbl) (cons mid-plist owning-entry))
                          tbl))) ;; Fixture.Base intentionally absent
      (multiple-value-bind (ancestors missing)
          (assembly-package-generator::expand-ancestors derived-plist t nil nil sparse-index)
        (assert-test (mapcar (lambda (a) (getf (car a) :fully-qualified-name)) ancestors)
                    '("Fixture.Mid")
                    "expand-ancestors resolves as much of the chain as it can before hitting a gap")
        (assert-test missing '("Fixture.Base")
                    "expand-ancestors reports an ancestor absent from the index as missing"))))

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
        (uiop:delete-directory-tree out-dir :validate t))))

  ;; 11. Unified Generic Methods (--defgeneric / csharp-generics, Version 34):
  ;;     collect-class-instance-generics must exclude static members and
  ;;     generic/type-parameterized instance methods (their wrapper's
  ;;     lambda list puts the type argument(s) before obj!, disqualifying
  ;;     them), and generate-assembly-packages-batch must only fold
  ;;     :defgeneric-true classes' names into csharp-generics.lisp/
  ;;     packages.lisp/the .asd -- and emit none of the three when no class
  ;;     opts in, for byte-identical-to-before-Version-34 output.
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
        (assembly-package-generator::collect-class-instance-generics class-a)
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

    ;; 11.2 End-to-end: only Fixture.GenA opts into :defgeneric; Fixture.GenB
    ;;      does not, so its "common" wrapper must not become a specializer.
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
              (assert-test (not (null (search "fixture-gen-a:common" generics-contents))) t
                          "csharp-generics.lisp installs a defmethod forwarding to the opted-in class")
              (assert-test (search "fixture-gen-b:common" generics-contents) nil
                          "csharp-generics.lisp installs no defmethod for the non-opted-in class")
              (assert-test (search "static-only" generics-contents) nil
                          "csharp-generics.lisp never mentions the excluded static method")
              (assert-test (search "(cl:defgeneric generic " generics-contents) nil
                          "csharp-generics.lisp never mentions the excluded generic instance method")
              (assert-test (not (null (search "(cl:defgeneric (cl:setf value)" generics-contents))) t
                          "csharp-generics.lisp defines a (cl:setf ...) generic for a writeable property")
              (assert-test (not (null (search "(cl:defpackage :csharp-generics" packages-contents))) t
                          "packages.lisp defines the csharp-generics package")
              (assert-test (not (null (search "\"csharp-generics\"" asd-contents))) t
                          "csharp-assembly-packages.asd includes the csharp-generics component")))
        (when (probe-file fixture-file)
          (delete-file fixture-file))
        (when (probe-file out-dir)
          (uiop:delete-directory-tree out-dir :validate t))))

    ;; 11.3 No class opts in: the whole feature is a no-op -- no
    ;;      csharp-generics.lisp, no defpackage, no .asd component.
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

  (format *error-output* "--- Package Generator Tests Completed ---~%"))
