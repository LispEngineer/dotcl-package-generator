;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite -- Generic-Method Codegen cluster.
;;; Split out of the former package-generator-tests.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :package-generator-tests)

(defun run-generic-method-codegen-tests ()
  (format *error-output* "--- Running Generic-Method Codegen Tests ---~%")

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
          (uiop:delete-directory-tree out-dir :validate t)))))
