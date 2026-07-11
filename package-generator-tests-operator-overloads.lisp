;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite -- Operator Overload Codegen cluster.
;;; Split out of the former package-generator-tests.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :package-generator-tests)

(defun run-operator-overload-tests ()
  (format *error-output* "--- Running Operator Overload Codegen Tests ---~%")

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
          (uiop:delete-directory-tree out-dir :validate t)))))
