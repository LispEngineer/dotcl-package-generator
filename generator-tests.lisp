;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Harness invoked from Program.cs (--test mode) as RUN-GENERATOR-TESTS.

(in-package :package-generator-tests)

(format *error-output* "[generator-tests.lisp] Loading in package ~S~%" *package*)

(defun run-generator-tests ()
  "Runs all the Lisp-level generator unit tests that don't have their own harness."
  (format *error-output* "[generator-tests.lisp] Running all tests...~%")

  (format *error-output* "[generator-tests.lisp] Running Package Generator tests...~%")
  (run-naming-tests)
  (run-overload-classification-tests)
  (run-batch-resolution-tests)
  (run-property-field-codegen-tests)
  (run-generic-method-codegen-tests)
  (run-operator-overload-tests)
  (run-out-parameter-tests)
  (run-events-tests)
  (run-parents-interfaces-tests)
  (run-defgeneric-tests)
  (run-extension-methods-tests)
  (run-related-discovery-tests)
  (run-read-check-tests)

  (format *error-output* "[generator-tests.lisp] ...tests complete.~%"))
