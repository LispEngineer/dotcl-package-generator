;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Tests for System.Console.dll metadata

(in-package :package-generator-tests)

(def-assembly-test "System.Console.dll" test-system-console
  (let ((con (find-if (lambda (cls) (string= (getf cls :fully-qualified-name) "System.Console")) *metadata*)))
    (assert-not-null con "Should find System.Console type")
    (when con
      (assert-equal :class (getf con :kind) "Console is a class")
      (assert-true (member :abstract (getf con :flags)) "Console should be abstract")
      (assert-true (member :sealed (getf con :flags)) "Console should be sealed")
      (assert-true (find-if (lambda (m) (string= (getf m :name) "WriteLine")) (getf con :methods))
                   "Console should contain WriteLine method"))))
