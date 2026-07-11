;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite -- Overload/Generic-Arity Classification cluster.
;;; Split out of the former package-generator-tests.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :package-generator-tests)

(defun run-overload-classification-tests ()
  (format *error-output* "--- Running Overload/Generic-Arity Classification Tests ---~%")

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
                    "compute-package-exports-and-shadows no longer exports type-suffixed method names"))))
