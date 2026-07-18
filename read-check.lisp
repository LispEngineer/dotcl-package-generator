;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Read-back verification of generated output: reads every generated .lisp
;;; and .asd file in a directory through a real Common Lisp reader, so that
;;; syntactically-invalid tokens (e.g. the Version 47 bare "#:|" export bug)
;;; can never again escape to a released package undetected -- paren-balance
;;; checking (check_parens.py) cannot see this class of bug. See
;;; doc/generator-design-notes.md's Version 47 section and
;;; doc/plan-fable-detail-01.md for the full rationale/design.
;;;
;;; This is a verification tool, not part of the generator itself -- hence
;;; its own package (read-check), not another apg- module.

(in-package :read-check)

(defvar *read-check-scratch-counter* 0
  "Monotonic counter used to name a fresh, disposable scratch package for
   every file read, so successive files (or successive test runs within the
   same process) never collide on package name.")

(defun make-scratch-package ()
  "Creates and returns a fresh package that :use's nothing, so that reading
   plain (unqualified) symbols in a generated file never accidentally
   resolves against CL or any generated package's exports."
  (make-package (format nil "READ-CHECK-SCRATCH-~D" (incf *read-check-scratch-counter*))
                :use nil))

(defun make-neutralized-readtable ()
  "Returns a fresh readtable (copied from the standard one) in which #.
   (read-time evaluation) reads and discards its subform instead of
   evaluating it. Generated csharp-generics.lisp files use
   #.(dotnet:class-for-type \"...\") -- evaluating that here would require
   the target assembly to be loaded, which read-check deliberately does not
   do. Reading (rather than skipping) the subform still validates that the
   subform itself is well-formed Lisp."
  (let ((rt (copy-readtable nil)))
    (set-dispatch-macro-character
     #\# #\.
     (lambda (stream subchar narg)
       (declare (ignore subchar narg))
       (read stream t nil t)
       nil)
     rt)
    rt))

(defun list-target-files (directory)
  "Returns the list of .lisp/.asd files under DIRECTORY to read-check, with
   packages.lisp (if present) forced first -- it creates every generated
   package, so everything else must be read after it. Remaining .lisp files,
   then .asd files, are each sorted by name for deterministic output."
  (let* ((dir (uiop:ensure-directory-pathname directory))
         (lisp-files (sort (directory (merge-pathnames "*.lisp" dir))
                            #'string< :key #'namestring))
         (asd-files (sort (directory (merge-pathnames "*.asd" dir))
                           #'string< :key #'namestring))
         (packages-file (find "packages" lisp-files
                               :key #'pathname-name :test #'string-equal))
         (other-lisp-files (remove packages-file lisp-files)))
    (append (when packages-file (list packages-file))
            other-lisp-files
            asd-files)))

(defun top-level-form-head-name-p (form name)
  "True if FORM is a cons whose car is a symbol named NAME (case-insensitive,
   package-agnostic -- generated files consistently emit cl:defpackage/
   cl:in-package, but this matches on symbol-name alone so it is robust to
   either qualified or unqualified forms)."
  (and (consp form)
       (symbolp (car form))
       (string-equal (symbol-name (car form)) name)))

(defun read-check-file (path readtable)
  "Reads every top-level form in PATH using READTABLE, evaluating only
   defpackage and in-package forms (defpackage creates the package being
   referenced by later files/forms; in-package tracks *package* the same way
   the real generated-file loading process would). Returns the number of
   forms read. Signals an error naming PATH and the failing form's 1-based
   index (plus stream byte offset) on any reader error, or on an in-package
   naming an unknown package."
  (let ((*readtable* readtable)
        (*read-eval* nil)
        (*package* (make-scratch-package))
        (form-index 0))
    (with-open-file (stream path :direction :input)
      (loop
        (let (form)
          (handler-case
              (setf form (read stream nil :eof))
            (error (e)
              (error "read-check: failed to read form #~D of ~A (byte offset ~D): ~A"
                     (1+ form-index) path (file-position stream) e)))
          (when (eq form :eof)
            (return form-index))
          (incf form-index)
          (cond
            ((top-level-form-head-name-p form "DEFPACKAGE")
             (eval form))
            ((top-level-form-head-name-p form "IN-PACKAGE")
             (let ((pkg (find-package (second form))))
               (unless pkg
                 (error "read-check: form #~D of ~A names unknown package ~S via IN-PACKAGE"
                        form-index path (second form)))
               (setf *package* pkg)))
            (t nil)))))))

(defun run-read-check (directory)
  "Reads every generated .lisp/.asd file in DIRECTORY through a real Common
   Lisp reader (see READ-CHECK-FILE/MAKE-NEUTRALIZED-READTABLE for exactly
   what that means and does not mean), erroring on the first unreadable
   form. Returns the total number of forms read across all files. Any
   package created during the check (both the per-file scratch packages and
   every defpackage encountered in the generated files themselves) is
   deleted again before returning, so the check is side-effect-free from the
   caller's point of view."
  (let ((readtable (make-neutralized-readtable))
        (packages-before (list-all-packages))
        (total-forms 0))
    (unwind-protect
        (dolist (path (list-target-files directory) total-forms)
          (format *error-output* "[read-check] Reading ~A...~%" path)
          (incf total-forms (read-check-file path readtable)))
      (dolist (pkg (list-all-packages))
        (unless (member pkg packages-before)
          (delete-package pkg))))))
