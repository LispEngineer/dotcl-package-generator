;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite -- shared support cluster.
;;; Split out of the former package-generator-tests.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :package-generator-tests)

(defmacro assert-test (form expected-value description)
    `(let ((result ,form))
      (if (equal result ,expected-value)
          (format *error-output* "[package-generator-tests] PASS ~A: ~S -> ~S~%" ,description result result)
          (progn
            (utils:format-red *error-output* "[package-generator-tests] FAIL ~A: Expected ~S but got ~S~%" ,description ,expected-value result)
            (error "Test failure: ~A" ,description)))))

(defun find-resolved (fq-name resolved)
  "Finds RESOLVED-CLASS plist for FQ-NAME within RESOLVED (a list of
   resolved-class plists, e.g. from resolve-batch-entry / all-resolved in
   generate-assembly-packages-batch). Promoted to top-level (was previously
   a local FLET inside one test section) so any cluster file can use it."
  (find fq-name resolved
        :key (lambda (rc) (getf (getf rc :class-plist) :fully-qualified-name))
        :test #'string=))

