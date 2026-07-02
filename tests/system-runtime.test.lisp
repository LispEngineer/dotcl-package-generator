;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Tests for System.Runtime.dll metadata

(in-package :package-generator-tests)

(def-assembly-test "System.Runtime.dll" test-array-list
  (let ((al (find-if (lambda (cls) (string= (getf cls :name) "ArrayList")) *metadata*)))
    (assert-not-null al "Should find ArrayList class")
    (when al
      (assert-equal "System.Collections.ArrayList" (getf al :fully-qualified-name) "ArrayList fully qualified name")
      (assert-equal "System.Collections" (getf al :namespace) "ArrayList namespace")
      (assert-equal :class (getf al :kind) "ArrayList is a class")
      (assert-equal "System.Object" (getf al :superclass) "ArrayList superclass")
      (assert-true (find-if (lambda (i) (string= i "System.Collections.IList")) (getf al :interfaces))
                   "ArrayList interfaces should contain System.Collections.IList"))))
