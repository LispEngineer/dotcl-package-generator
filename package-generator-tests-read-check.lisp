;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite -- Read-Check cluster.
;;; Exercises read-check:run-read-check (see read-check.lisp /
;;; doc/plan-fable-detail-01.md), including a regression test recreating the
;;; exact Version 47 bug shape (a bare, unescaped "#:|" export token) that
;;; motivated read-check in the first place.

(in-package :package-generator-tests)

(defun run-read-check-tests ()
  (format *error-output* "--- Running Read-Check Tests ---~%")

    ;; 1. Positive: a correctly-escaped "#:\|" operator export (the v47 shape,
    ;;    but properly escaped this time) plus a second file exercising #.
    ;;    read-time-eval neutralization. run-read-check must succeed and
    ;;    report a positive form count.
  (let ((dir (merge-pathnames "read-check-tests-good/" (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist dir)
          (with-open-file (s (merge-pathnames "packages.lisp" dir)
                              :direction :output :if-exists :supersede :if-does-not-exist :create)
            (write-string "(cl:defpackage :read-check-test-fixture-good" s) (terpri s)
            (write-string "  (:use :cl)" s) (terpri s)
            (write-string "  (:export #:\\|))" s) (terpri s))
          (with-open-file (s (merge-pathnames "read-check-test-fixture-good-class.lisp" dir)
                              :direction :output :if-exists :supersede :if-does-not-exist :create)
            (write-string "(cl:in-package :read-check-test-fixture-good)" s) (terpri s)
            (write-string "(cl:defun some-fn () #.(cl:+ 1 2))" s) (terpri s))

          (let ((form-count (read-check:run-read-check (namestring dir))))
            (assert-test (> form-count 0) t
                        "run-read-check succeeds and reports a positive form count on well-formed input")))
      (when (probe-file dir)
        (uiop:delete-directory-tree dir :validate t))))

    ;; 2. Negative: the exact Version 47 bug shape -- a bare, unescaped "#:|"
    ;;    export token (rather than the correctly-escaped "#:\|" above). This
    ;;    is the regression test proving run-read-check catches the bug class
    ;;    that shipped undetected for three generator versions.
  (let ((dir (merge-pathnames "read-check-tests-bad-token/" (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist dir)
          (with-open-file (s (merge-pathnames "packages.lisp" dir)
                              :direction :output :if-exists :supersede :if-does-not-exist :create)
            (write-string "(cl:defpackage :read-check-test-fixture-bad-token" s) (terpri s)
            (write-string "  (:use :cl)" s) (terpri s)
            (write-string "  (:export #:|" s) (terpri s)
            (write-string "  ))" s) (terpri s))

          (let ((signaled nil) (names-file nil))
            (handler-case
                (read-check:run-read-check (namestring dir))
              (error (e)
                (setf signaled t)
                (setf names-file (not (null (search "packages.lisp" (format nil "~A" e)))))))
            (assert-test signaled t
                        "run-read-check signals an error on the unescaped #:| bug shape")
            (assert-test names-file t
                        "run-read-check names the offending file when it hits the unescaped #:| bug shape")))
      (when (probe-file dir)
        (uiop:delete-directory-tree dir :validate t))))

    ;; 3. Negative: an unterminated string literal -- proves read-check catches
    ;;    reader errors beyond what check_parens.py's paren-balance check can see.
  (let ((dir (merge-pathnames "read-check-tests-bad-string/" (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist dir)
          (with-open-file (s (merge-pathnames "unterminated-string.lisp" dir)
                              :direction :output :if-exists :supersede :if-does-not-exist :create)
            (write-string "(cl:defvar *x* \"unterminated)" s) (terpri s))

          (let ((signaled nil) (names-file nil))
            (handler-case
                (read-check:run-read-check (namestring dir))
              (error (e)
                (setf signaled t)
                (setf names-file (not (null (search "unterminated-string.lisp" (format nil "~A" e)))))))
            (assert-test signaled t
                        "run-read-check signals an error on an unterminated string literal")
            (assert-test names-file t
                        "run-read-check names the offending file when it hits an unterminated string")))
      (when (probe-file dir)
        (uiop:delete-directory-tree dir :validate t)))))
