;;; Generated automatically. Do not edit.
;;; Generator Version: 51
;;; Creation Date: 2026-07-19T15:11:53Z

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

;;; Sentinel marking a not-yet-computed memoized constant (see
;;; emit-memoized-constant-binding in the generator's
;;; apg-class-file-generator.lisp). Guaranteed distinguishable via cl:eq
;;; from any real dotnet:static return value (DotCL never returns a bare
;;; cons), and reload-safe -- the cl:boundp check means loading this file
;;; twice in the same image does not signal a "constant redefined to a
;;; non-eql value" error the way a plain (cl:list ...) defconstant would.
(cl:defconstant +unbound-marker+
  (cl:if (cl:boundp '+unbound-marker+)
         (cl:symbol-value '+unbound-marker+)
         (cl:list :csharp-assembly-utils-unbound-marker)))

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

