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

  ;; 13.2 collect-class-instance-generics (the --defgeneric unified-generics
  ;;      collector) must include instance events, exactly
  ;;      as add-X/remove-X method-names entries -- this is the regression
  ;;      test for the "add-click missing from generics" bug report (see
  ;;      PLAN.md's "Enhance Generics with Event Methods" section). Reuses
  ;;      the same Fixture.Clickable/Fixture.CollidingClickable shapes as
  ;;      tests 13/13.1 above.
  (let ((clickable
          '(:fully-qualified-name "Fixture.Clickable"
            :kind :class
            :fields nil :properties nil :methods nil :constructors nil
            :events ((:name "Click" :type "System.EventHandler"
                      :add-method "add_Click" :remove-method "remove_Click"))))
        (colliding-clickable
          '(:fully-qualified-name "Fixture.CollidingClickable"
            :kind :class
            :fields nil :properties nil
            :methods ((:name "AddClick" :is-static nil :return-type "System.Void" :parameters nil)
                      (:name "RemoveClick" :is-static nil :return-type "System.Void" :parameters nil))
            :constructors nil
            :events ((:name "Click" :type "System.EventHandler"
                      :add-method "add_Click" :remove-method "remove_Click")))))
    (multiple-value-bind (method-names setter-names)
        (assembly-package-generator::collect-class-instance-generics clickable nil)
      (assert-test (and (member "add-click" method-names :test #'string=) t) t
                  "collect-class-instance-generics includes an event's add-X wrapper")
      (assert-test (and (member "remove-click" method-names :test #'string=) t) t
                  "collect-class-instance-generics includes an event's remove-X wrapper")
      (assert-test (member "add-click" setter-names :test #'string=) nil
                  "collect-class-instance-generics never puts an event's add-X into setter-names"))
    ;; The actual regression: when add-click/remove-click collide with an
    ;; unrelated AddClick()/RemoveClick() method pair, collect-class-instance-
    ;; generics must escalate to the exact same tier-2 names generate-class-
    ;; file/compute-package-exports-and-shadows do -- never a hardcoded
    ;; expectation, an agreement check, so the two can never drift apart.
    (multiple-value-bind (collector-method-names collector-setter-names)
        (assembly-package-generator::collect-class-instance-generics colliding-clickable nil)
      (declare (ignore collector-setter-names))
      (multiple-value-bind (exports shadows) (assembly-package-generator::compute-package-exports-and-shadows colliding-clickable nil)
        (declare (ignore shadows))
        (assert-test (and (member "add-click-event" collector-method-names :test #'string=) t) t
                    "collect-class-instance-generics escalates to add-click-event on collision")
        (assert-test (and (member "remove-click-event" collector-method-names :test #'string=) t) t
                    "collect-class-instance-generics escalates to remove-click-event on collision")
        ;; "add-click"/"remove-click" ARE still expected here -- they're the
        ;; unrelated AddClick()/RemoveClick() *methods'* own wrapper names
        ;; (zero-arg, no handler), not the event's tier-1 name (which was
        ;; correctly escalated away from that collision, to add-click-event).
        (assert-test (list (and (member "add-click-event" exports :test #'string=) t)
                           (and (member "add-click-event" collector-method-names :test #'string=) t))
                    '(t t)
                    "collect-class-instance-generics and compute-package-exports-and-shadows agree on the add-click-event escalation")
        (assert-test (list (and (member "remove-click-event" exports :test #'string=) t)
                           (and (member "remove-click-event" collector-method-names :test #'string=) t))
                    '(t t)
                    "collect-class-instance-generics and compute-package-exports-and-shadows agree on the remove-click-event escalation"))))

  ;; 13.3 End-to-end: a --defgeneric-opted-in class with an event must get
  ;;      add-X/remove-X cl:defgeneric/cl:defmethod forms in the generated
  ;;      csharp-generics.lisp, forwarding correctly.
  (let* ((fixture-metadata
           (list '(:fully-qualified-name "Fixture.EventGeneric"
                   :kind :class
                   :fields nil :properties nil :methods nil :constructors nil
                   :events ((:name "Click" :type "System.EventHandler"
                             :add-method "add_Click" :remove-method "remove_Click")))))
         (fixture-file (merge-pathnames "package-generator-tests-event-generics-fixture.lispy-metadata"
                                        (uiop:temporary-directory)))
         (out-dir (merge-pathnames "package-generator-tests-event-generics-out/"
                                   (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (with-open-file (s fixture-file :direction :output :if-exists :supersede :if-does-not-exist :create)
            (prin1 fixture-metadata s))
          (ensure-directories-exist out-dir)
          (assembly-package-generator:generate-assembly-packages-batch
           (list (list :metadata-file (namestring fixture-file)
                       :assembly-name "Fixture.dll"
                       :classes (list (list :name "Fixture.EventGeneric" :constant-properties "" :defgeneric t))))
           (namestring out-dir)
           "2026-07-05T00:00:00Z"
           "9.9.9"
           (utils:qualify-path "csharp-assembly-utils-package.template.lisp")
           (utils:qualify-path "csharp-assembly-utils.template.lisp")
           nil)
          (let* ((generics-file (merge-pathnames "csharp-generics.lisp" out-dir))
                 (contents (uiop:read-file-string generics-file)))
            (assert-test (not (null (search "(cl:defgeneric add-click (obj! cl:&rest args)" contents))) t
                        "csharp-generics.lisp defines a generic for an event's add-X wrapper")
            (assert-test (not (null (search "(cl:defgeneric remove-click (obj! cl:&rest args)" contents))) t
                        "csharp-generics.lisp defines a generic for an event's remove-X wrapper")
            (assert-test (not (null (search "(cl:defmethod add-click ((obj! #.(dotnet:class-for-type \"Fixture.EventGeneric\")) cl:&rest args)" contents))) t
                        "csharp-generics.lisp emits a literal defmethod for the add-X wrapper")
            (assert-test (not (null (search "(cl:apply (cl:function fixture-event-generic:add-click) obj! args))" contents))) t
                        "csharp-generics.lisp's add-X defmethod forwards via cl:apply to the opted-in class")))
      (when (probe-file fixture-file)
        (delete-file fixture-file))
      (when (probe-file out-dir)
        (uiop:delete-directory-tree out-dir :validate t))))

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
        (uiop:delete-directory-tree out-dir :validate t))))

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
        (uiop:delete-directory-tree out-dir :validate t))))

  ;; 14. Extension Methods (Version 38, doc/plan-v38.md): --extension-methods
  ;;     injects a matching C# extension method into the extended class's own
  ;;     package as an obj!-first wrapper. Fixture.Ext.Target is the class
  ;;     under test; Fixture.Ext.Holder is a static holder class present in
  ;;     the same fixture metadata (as build-extension-method-index scans
  ;;     every type across the whole metadata index, not just requested
  ;;     ones) declaring five candidate extension methods exercising every
  ;;     skip path plus one survivor.
  (let ((target
          '(:fully-qualified-name "Fixture.Ext.Target" :name "Target" :namespace "Fixture.Ext"
            :kind :class :fields nil :properties nil :constructors nil
            :methods ((:name "CollidingMethod" :is-static nil :return-type "System.Void" :parameters nil))))
        (holder
          '(:fully-qualified-name "Fixture.Ext.Holder" :name "Holder" :namespace "Fixture.Ext"
            :kind :class :flags (:sealed) :fields nil :properties nil :constructors nil
            :methods
            ((:name "CleanExt" :is-static t :extension-method t :return-type "System.Void"
              :parameters ((:name "target" :type "Fixture.Ext.Target" :extension-this t)
                           (:name "amount" :type "System.Int32")))
             (:name "DirtyExt" :is-static t :extension-method t :return-type "System.Void"
              :parameters ((:name "target" :type "Fixture.Ext.Target" :extension-this t)
                           (:name "amount" :type "System.Int32" :ref t)))
             (:name "Frob" :is-static t :extension-method t :return-type "System.Void"
              :parameters ((:name "target" :type "Fixture.Ext.Target" :extension-this t)))
             (:name "Frob" :is-static t :extension-method t :return-type "System.Void"
              :parameters ((:name "target" :type "Fixture.Ext.Target" :extension-this t)
                           (:name "amount" :type "System.Int32")))
             (:name "CollidingMethod" :is-static t :extension-method t :return-type "System.Void"
              :parameters ((:name "target" :type "Fixture.Ext.Target" :extension-this t)))))))

    ;; 14.1 build-extension-method-index / compute-matched-extensions-for-class
    ;;      directly, against a hand-built metadata-index (same shape
    ;;      build-metadata-index itself produces).
    (let ((owning-entry '(:assembly-name "Fixture.Ext.dll"))
          (metadata-index (make-hash-table :test #'equal)))
      (dolist (tp (list target holder))
        (setf (gethash (getf tp :fully-qualified-name) metadata-index) (cons tp owning-entry)))
      (let ((extension-index (assembly-package-generator::build-extension-method-index metadata-index)))
        (assert-test (length (gethash "Fixture.Ext.Target" extension-index)) 5
                    "build-extension-method-index buckets all 5 candidates under Target's exact FQ name")
        (multiple-value-bind (survivors skipped)
            (assembly-package-generator::compute-matched-extensions-for-class target nil extension-index)
          (assert-test (length survivors) 1
                      "compute-matched-extensions-for-class keeps exactly one survivor")
          (assert-test (getf (first (first survivors)) :name) "CleanExt"
                      "compute-matched-extensions-for-class's survivor is CleanExt")
          (assert-test (length skipped) 4
                      "compute-matched-extensions-for-class skips the other 4 candidates")
          (let ((reasons (mapcar (lambda (s) (cons (getf (first s) :name) (third s))) skipped)))
            (assert-test (cdr (assoc "DirtyExt" reasons :test #'string=)) :dirty
                        "DirtyExt is skipped as :dirty (ref parameter)")
            (assert-test (cdr (assoc "CollidingMethod" reasons :test #'string=)) :own
                        "CollidingMethod is skipped as :own (Target already declares this name)")
            (let ((frob-reasons (remove "Frob" reasons :key #'car :test-not #'string=)))
              (assert-test (length frob-reasons) 2
                          "both Frob overloads are skipped")
              (assert-test (every (lambda (r) (and (consp (cdr r)) (eq (second r) :ambiguous))) frob-reasons) t
                          "both Frob overloads are skipped as :ambiguous"))))))

    ;; 14.2 End-to-end: generate-assembly-packages-batch with :extension-methods
    ;;      t on Target only (Holder is never itself requested as a --class)
    ;;      must emit clean-ext into fixture-ext-target.lisp, must not emit
    ;;      dirty-ext or frob, and must not overwrite CollidingMethod's real
    ;;      wrapper with the extension version.
    (let* ((fixture-metadata (list target holder))
           (fixture-file (merge-pathnames "package-generator-tests-extension-fixture.lispy-metadata"
                                          (uiop:temporary-directory)))
           (out-dir (merge-pathnames "package-generator-tests-extension-out/"
                                     (uiop:temporary-directory))))
      (unwind-protect
          (progn
            (with-open-file (s fixture-file :direction :output :if-exists :supersede :if-does-not-exist :create)
              (prin1 fixture-metadata s))
            (ensure-directories-exist out-dir)
            (assembly-package-generator:generate-assembly-packages-batch
             (list (list :metadata-file (namestring fixture-file)
                         :assembly-name "Fixture.Ext.dll"
                         :classes (list (list :name "Fixture.Ext.Target" :constant-properties ""
                                              :extension-methods t))))
             (namestring out-dir)
             "2026-07-05T00:00:00Z"
             "9.9.9"
             (utils:qualify-path "csharp-assembly-utils-package.template.lisp")
             (utils:qualify-path "csharp-assembly-utils.template.lisp")
             nil)
            (let* ((class-file (merge-pathnames "fixture-ext-target.lisp" out-dir))
                   (contents (uiop:read-file-string class-file))
                   (packages-file (merge-pathnames "packages.lisp" out-dir))
                   (packages-contents (uiop:read-file-string packages-file)))
              (assert-test (not (null (search "(cl:defun clean-ext (obj! amount)" contents))) t
                          "generate-class-file emits the surviving CleanExt as an obj!-first wrapper")
              (assert-test (not (null (search "(dotnet:static \"Fixture.Ext.Holder\" \"CleanExt\" obj! amount))" contents))) t
                          "clean-ext forwards to dotnet:static on the holder type, not <type-str>")
              (assert-test (search "(cl:defun dirty-ext" contents) nil
                          "generate-class-file does not emit the dirty DirtyExt")
              (assert-test (search "(cl:defun frob" contents) nil
                          "generate-class-file does not emit either ambiguous Frob overload")
              (assert-test (not (null (search "#:clean-ext" packages-contents))) t
                          "packages.lisp exports clean-ext for fixture-ext-target")
              (assert-test (search "#:frob" packages-contents) nil
                          "packages.lisp does not export the skipped, ambiguous frob")))
        (when (probe-file fixture-file)
          (delete-file fixture-file))
        (when (probe-file out-dir)
          (uiop:delete-directory-tree out-dir :validate t)))))

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
          (uiop:delete-directory-tree out-dir :validate t)))))

  (format *error-output* "--- Package Generator Tests Completed ---~%"))
