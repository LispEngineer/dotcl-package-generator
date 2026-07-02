;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Utilities package

(in-package :utils)

(defun safe-read-form-from-file (filepath)
  "To safely load (or read) a single form from a file in Common Lisp,
   you must prevent read-time code execution, isolate symbol resolution,
   and handle potential errors or end-of-file situations gracefully."
  (with-open-file (stream filepath :direction :input)
    (let ((*read-eval* nil)                    ; 1. Disable read-time execution (#.)
          (*readtable* (copy-readtable nil))   ; 2. Use the standard standard readtable
          (*package* (find-package :cl-user))) ; 3. Control package context
      (read stream nil :eof))))                ; 4. Graceful EOF handling

(defconstant +base-directory+
  (dotnet:invoke (dotnet:static "System.AppDomain" "CurrentDomain") "get_BaseDirectory")
  "Get the C# base directory of this current executable")

;; I have no idea why, but this stopped working...?
;; %Unhandled exception. System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation.
;;  ---> System.MissingMethodException: Method 'System.IO.Path.Combine' not found.

#|
(defun path-combine (part1 part2 &optional (part3 nil part3-p) (part4 nil part4-p))
  "Calls the C# Path Combining logic with 2-4 parameters."
  (format *error-output* "[path-combine] part1 = ~A, part2 = ~A, part3 = ~A, part4 = ~A, part3-p = ~A, part4-p = ~A%"
          part1 part2 part3 part4 part3-p part4-p)
  (cond
   (part4-p
    ;; Could use combine-string-string-string-string too
    (path:combine part1 part2 part3 part4))
   (part3-p
    (path:combine part1 part2 part3))
   (t
    (path:combine part1 part2))))
|#

;; UIOP version
(defun path-combine (part1 part2 &optional (part3 nil part3-p) (part4 nil part4-p))
  "Calls the UIOP Path Combining logic with 2-4 parameters."
  (format *error-output* "[path-combine] part1 = ~A, part2 = ~A, part3 = ~A, part4 = ~A, part3-p = ~A, part4-p = ~A~%"
          part1 part2 part3 part4 part3-p part4-p)
  (cond
   (part4-p
    (uiop:subpathname*  part1 part2 part3 part4))
   (part3-p
    (uiop:subpathname*  part1 part2 part3))
   (t
    (uiop:subpathname*  part1 part2))))

#|
(defun file-exists-and-readable-p (filename)
  "Returns T if the file exists and can be successfully opened for reading."
  (let ((path (probe-file filename)))
    (when path
      ;; If probe-file found it, try to actually open it to test readability
      (handler-case
        (with-open-file (stream path :direction :input) t) ; Successfully opened! Return T
        (file-error () nil))))) ; Catch OS permission/read errors and return NIL
|#
(defun file-exists-and-readable-p (filename)
  "Returns T if the file exists and can be successfully opened for reading."
  (let ((it (probe-file filename)))
    (when it
      ;; If probe-file found it, try to actually open it to test readability
      (handler-case
        (with-open-file (stream it :direction :input) t) ; Successfully opened! Return T
        (file-error () nil))))) ; Catch OS permission/read errors and return NIL

(defun qualify-path (filename)
  "Checks if we can read filename as it is, and returns it. Otherwise,
   checks if it can be read after combining with +base-directory+ and then
   will return that. Otherwise, just returns the original filename."
  ;; This is necessary because when we (load "load-repl.lisp") to load the
  ;; entire game from the REPL, DotCL doesn't actually set the
  ;; +base-directory+ to a reasonable setting:
  ;; [texture-atlas.lisp] +base-directory+ =
  ;;   /home/dfields/.dotnet/tools/.store/dotcl/0.1.8/dotcl.linux-x64/0.1.8/tools/net10.0/linux-x64/
  ; (format *error-output* "[qualify-path] filename = ~A, +base-directory+ = ~A~%" filename +base-directory+)
  (let ((combined (path-combine +base-directory+ filename)))
    ; (format *error-output* "[qualify-path] combined = ~A~%" combined)
    (cond
      ((file-exists-and-readable-p filename)
      ;  (format *error-output* "[qualify-path] exists~A")
       filename)
      ((file-exists-and-readable-p combined)
      ;  (format *error-output* "[qualify-path] exists with +base-directory+ = ~S~A" combined)
       (uiop:native-namestring combined))
      (t
      ;  (format *error-output* "[qualify-path] neither~A")
       filename))))

(defun format-red (destination control-string &rest args)
  "Formats output wrapped in ANSI RED color escape sequences."
  (if (null destination)
    (let ((formatted (apply #'format nil control-string args)))
      (format nil "~C[31m~A~C[0m" #\Esc formatted #\Esc))
    (progn
      (format destination "~C[31m" #\Esc)
      (apply #'format destination control-string args)
      (format destination "~C[0m" #\Esc))))

(defun print-gf-methods (gf-name)
  "Prints information about a DotCL Generic Function, including docstrings."

  (when (not (fboundp gf-name))
    (format *error-output* "~&Generic Function ~S not yet defined.~%" gf-name)
    (return-from print-gf-methods))

  (let* ((gf (symbol-function gf-name))
         ;; Retrieve the documentation string of the generic function if it exists.
         (gf-doc (documentation gf 'function))
         (methods (dotcl-mop:generic-function-methods gf)))
    (format *error-output* "~&Generic Function ~S has ~D method(s):~%" gf-name (length methods))
    (when gf-doc
      (format *error-output* "  Docstring: ~S~%" gf-doc))
    (dolist (m methods)
      (let ((qualifiers (dotcl-mop:method-qualifiers m))
            (specializers (mapcar (lambda (spec)
                                    (if (typep spec 'class)
                                        (class-name spec)
                                        spec))
                                  (dotcl-mop:method-specializers m)))
            ;; Retrieve the documentation string of the method object.
            (m-doc (documentation m t)))
        (format *error-output* "  Method qualifiers: ~A, Specializers: ~A~%" 
                qualifiers specializers)
        (when m-doc
          (format *error-output* "    Doc: ~S~%" m-doc))))))

;;; Condition signaled when a generated C# wrapper function's dispatcher
;;; fails to find a matching method overload at runtime.
(cl:define-condition csharp-overload-not-found (cl:error)
  ((package-name :initarg :package-name :reader csharp-overload-package-name)
   (class-name :initarg :class-name :reader csharp-overload-class-name)
   (method-name :initarg :method-name :reader csharp-overload-method-name)
   (supplied-args :initarg :supplied-args :reader csharp-overload-supplied-args))
  (:report (cl:lambda (condition stream)
             (cl:format stream "No matching C# overload found for method ~A.~A in package ~A with supplied arguments:~%~{  ~S: ~S~%~}"
                        (csharp-overload-class-name condition)
                        (csharp-overload-method-name condition)
                        (csharp-overload-package-name condition)
                        (csharp-overload-supplied-args condition)))))
