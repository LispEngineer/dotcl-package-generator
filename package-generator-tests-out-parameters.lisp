;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite -- Out-Parameter Support cluster
;;; (doc/plan-fable-detail-05.md).

(in-package :package-generator-tests)

(defun run-out-parameter-tests ()
  (format *error-output* "--- Running Out-Parameter Support Tests ---~%")

  ;; 1. Classification: out-only-method-p/dirty-method-p/clean-method-p using
  ;;    mock method plists.
  (let ((clean-method '(:name "Parse" :is-static t :return-type "System.Int32"
                         :parameters ((:name "s" :type "System.String"))))
        (out-only-method '(:name "TryParse" :is-static t :return-type "System.Boolean"
                            :parameters ((:name "s" :type "System.String")
                                         (:name "result" :type "System.Int32" :out t))))
        (out-plus-ref-method '(:name "MixedModifiers" :is-static t :return-type "System.Void"
                                :parameters ((:name "a" :type "System.Int32" :out t)
                                              (:name "b" :type "System.Int32" :ref t))))
        (out-only-generic-return-method '(:name "TryGetGeneric" :is-static t :return-type "!0"
                                           :parameters ((:name "result" :type "System.Int32" :out t)))))

    (assert-test (assembly-package-generator::out-only-method-p clean-method) nil
                 "out-only-method-p rejects a clean method (Parse)")
    (assert-test (assembly-package-generator::out-only-method-p out-only-method) t
                 "out-only-method-p accepts a method whose only special modifier is :out (TryParse)")
    (assert-test (assembly-package-generator::clean-method-p out-only-method) nil
                 "clean-method-p still rejects an :out-bearing method (TryParse)")
    (assert-test (assembly-package-generator::dirty-method-p out-only-method) nil
                 "dirty-method-p no longer flags a method whose only special modifier is :out (TryParse)")

    (assert-test (assembly-package-generator::out-only-method-p out-plus-ref-method) nil
                 "out-only-method-p rejects a method mixing :out with :ref (MixedModifiers)")
    (assert-test (assembly-package-generator::dirty-method-p out-plus-ref-method) t
                 "dirty-method-p still flags a method mixing :out with :ref (MixedModifiers)")

    (assert-test (assembly-package-generator::out-only-method-p out-only-generic-return-method) nil
                 "out-only-method-p rejects an :out method whose return type mentions the declaring generic type's own open type parameter"))

  ;; 2. Naming: out-method-wrapper-name/out-method-group-names.
  (let ((method-groups-with-clean '(("Locate" . ((:name "Locate" :is-static nil :return-type "System.String"
                                                   :parameters ((:name "id" :type "System.Int32"))))))))
    (assert-test (assembly-package-generator::out-method-wrapper-name "TryParse" nil nil nil)
                 "try-parse"
                 "out-method-wrapper-name uses the plain mapped name when no clean overload of the same name/mode exists, and not mixed-mode")
    (assert-test (assembly-package-generator::out-method-wrapper-name "Locate" nil nil method-groups-with-clean)
                 "locate/out"
                 "out-method-wrapper-name appends /out when a clean instance overload of the same name exists")
    (assert-test (assembly-package-generator::out-method-wrapper-name "Locate" t nil method-groups-with-clean)
                 "locate"
                 "out-method-wrapper-name adds no '*' for a static-only (not mixed-mode) out-only group, and no /out since the clean overload of the same name is instance-mode (different mode)")
    (assert-test (assembly-package-generator::out-method-wrapper-name "Locate" t t method-groups-with-clean)
                 "locate*"
                 "out-method-wrapper-name adds '*' for the static side of a mixed-mode (both static and instance out-only overloads) group"))

  ;; 3. Codegen: generate-class-file must emit a real wrapper (not a dirty
  ;;    comment) for an out-only method, omitting the out parameter from the
  ;;    lambda list and forwarding to dotnet:call-out.
  (let* ((class-plist
           '(:fully-qualified-name "Fixture.OutOnly"
             :kind :class
             :fields nil
             :properties nil
             :methods ((:name "TryGetValue" :is-static t :return-type "System.Boolean"
                        :parameters ((:name "key" :type "System.String")
                                     (:name "value" :type "System.Int32" :out t))))
             :constructors nil))
         (out-dir (merge-pathnames "package-generator-tests-out-only-out/"
                                   (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist out-dir)
          (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
          (let* ((class-file (merge-pathnames "fixture-out-only.lisp" out-dir))
                 (contents (uiop:read-file-string class-file)))
            (assert-test (not (null (search "(cl:defun try-get-value (key)" contents))) t
                         "generate-class-file emits an out-only wrapper omitting the out parameter from its lambda list")
            (assert-test (not (null (search "(dotnet:call-out <type-str> \"TryGetValue\" key))" contents))) t
                         "generate-class-file's out-only wrapper forwards to dotnet:call-out with only the in-argument")
            (assert-test (null (search "not yet supported" contents)) t
                         "generate-class-file no longer documents a lone out-only method as unsupported")))
      (when (probe-file out-dir)
        (uiop:delete-directory-tree out-dir :validate t))))

  ;; 4. Codegen: an out-only method mixing with a clean overload of the same
  ;;    name gets the /out-suffixed wrapper name, and both wrappers coexist.
  (let* ((class-plist
           '(:fully-qualified-name "Fixture.OutAndClean"
             :kind :class
             :fields nil
             :properties nil
             :methods ((:name "Locate" :is-static nil :return-type "System.String"
                        :parameters ((:name "id" :type "System.Int32")))
                       (:name "Locate" :is-static nil :return-type "System.Boolean"
                        :parameters ((:name "key" :type "System.String")
                                     (:name "id" :type "System.Int32" :out t))))
             :constructors nil))
         (out-dir (merge-pathnames "package-generator-tests-out-and-clean-out/"
                                   (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist out-dir)
          (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
          (let* ((class-file (merge-pathnames "fixture-out-and-clean.lisp" out-dir))
                 (contents (uiop:read-file-string class-file)))
            (assert-test (not (null (search "(cl:defun locate (obj! id)" contents))) t
                         "generate-class-file emits the clean Locate(int) overload under the plain name")
            (assert-test (not (null (search "(cl:defun locate/out (obj! key)" contents))) t
                         "generate-class-file emits the out-only Locate(string,out) overload as locate/out")
            (assert-test (not (null (search "(dotnet:call-out obj! \"Locate\" key))" contents))) t
                         "generate-class-file's locate/out wrapper forwards to dotnet:call-out with obj! and the in-argument")))
      (when (probe-file out-dir)
        (uiop:delete-directory-tree out-dir :validate t)))))
