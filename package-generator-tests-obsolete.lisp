;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite -- [Obsolete] Surfacing cluster
;;; (doc/plan-fable-detail-16.md's Half A). Half B ([TupleElementNames]) is
;;; metadata-only in this version (no codegen consumes it yet), so it is
;;; covered by tests/framework.lisp's schema validator alone, not here.

(in-package :package-generator-tests)

(defun run-obsolete-tests ()
  (format *error-output* "--- Running [Obsolete] Surfacing Tests ---~%")

  ;; 1. obsolete-docstring-line's three flavors, using mock plists.
  (assert-test (assembly-package-generator::obsolete-docstring-line '(:name "Plain")) ""
               "obsolete-docstring-line returns an empty string for a non-obsolete member")
  (assert-test (assembly-package-generator::obsolete-docstring-line '(:name "Plain" :obsolete t))
               (format nil "OBSOLETE.~%")
               "obsolete-docstring-line renders a bare 'OBSOLETE.' with no message")
  (assert-test (assembly-package-generator::obsolete-docstring-line
                '(:name "WithMessage" :obsolete t :obsolete-message "use X instead"))
               (format nil "OBSOLETE: use X instead~%")
               "obsolete-docstring-line renders 'OBSOLETE: <message>' when a message is present")
  (assert-test (assembly-package-generator::obsolete-docstring-line
                '(:name "ErrorLevel" :obsolete t :obsolete-message "gone" :obsolete-error t))
               (format nil "OBSOLETE (error-level): gone~%")
               "obsolete-docstring-line renders 'OBSOLETE (error-level): <message>' when :obsolete-error is set")

  ;; 2. Codegen: an obsolete method's generated wrapper docstring, an
  ;;    obsolete type's header comment, and packages.lisp's per-package
  ;;    comment, all carry the marker.
  (let* ((class-plist
           '(:fully-qualified-name "Fixture.ObsoleteFixture"
             :kind :class
             :obsolete t
             :obsolete-message "use Fixture.NewFixture instead"
             :fields nil
             :properties nil
             :methods ((:name "OldMethod" :is-static t :return-type "System.Void"
                        :obsolete t :obsolete-message "use NewMethod instead"
                        :parameters nil))
             :constructors nil))
         (out-dir (merge-pathnames "package-generator-tests-obsolete-out/"
                                   (uiop:temporary-directory))))
    (unwind-protect
        (progn
          (ensure-directories-exist out-dir)
          (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
          (let* ((class-file (merge-pathnames "fixture-obsolete-fixture.lisp" out-dir))
                 (contents (uiop:read-file-string class-file)))
            (assert-test (not (null (search "OBSOLETE: use Fixture.NewFixture instead" contents))) t
                         "generate-class-file's header comment carries an obsolete type's OBSOLETE line")
            (assert-test (not (null (search "\"OBSOLETE: use NewMethod instead" contents))) t
                         "generate-class-file's obsolete method wrapper docstring carries its own OBSOLETE line")))
      (when (probe-file out-dir)
        (uiop:delete-directory-tree out-dir :validate t)))))
