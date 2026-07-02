;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Tests for DotCL.Runtime.dll metadata

(in-package :package-generator-tests)

(def-assembly-test "DotCL.Runtime.dll" test-dotcl-runtime
  (let ((rt (find-if (lambda (cls) (string= (getf cls :fully-qualified-name) "DotCL.Runtime")) *metadata*)))
    (assert-not-null rt "Should find DotCL.Runtime type")
    (when rt
      (assert-equal :class (getf rt :kind) "Runtime is a class")
      (assert-true (find-if (lambda (m) (string= (getf m :name) "Load")) (getf rt :methods))
                   "Runtime should contain Load method"))))
