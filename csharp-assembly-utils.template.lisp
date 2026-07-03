;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Shared runtime support used by every dotcl-packagegen-generated C# class
;;; package. Copied verbatim (see GENERATE-BATCH-UTILS-FILE in
;;; assembly-package-generator.lisp) into every generated batch's
;;; csharp-assembly-utils.lisp, after a standard 3-line header. Assumes the
;;; CSHARP-ASSEMBLY-UTILS package (see csharp-assembly-utils-package.template.lisp,
;;; copied into packages.lisp) is already defined.

(cl:in-package :csharp-assembly-utils)

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
