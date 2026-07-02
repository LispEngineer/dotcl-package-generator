;;; monoutils.lisp — Package definition and shims for custom C# utils.
;;;
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;

(in-package :monoutils)

(format *error-output* "[monoutils.lisp] Loading in package ~S~%" *package*)

(setf (documentation 'monoutils:dotnet-p 'function)
  "Returns T if this is a Lisp-wrapped C#/CLR object")

(setf (documentation 'monoutils:boxed-dotnet-p 'function)
  "Returns T if this is a Lisp Wrapped & Boxed (i.e., type hinted) C#/CLR object.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Type helper functions

;; In C#, calling GetType() on a string can fail for types in external assemblies unless they  
;; are assembly-qualified. I created the DynamicBaseCaller.GetType() method to get
;; around that.
;; TODO: Memoize this function, but only if the type was resolved and it
;;       was a string input.
(defun get-type (obj-or-string)
  "Gets the C# Type object of the specified object, or nil if none. If the
   obj is a Lisp string, it tries to resolve the C# Type with that name."
  ;; TODO: Check if obj is a DotNet object in the future
  (handler-case
    (if (stringp obj-or-string)
      ;; Get the Type from C# using dotcl's built-in resolver.
      (dotnet:resolve-type obj-or-string)
      ;; Get the type from the object itself.
      ;; This call may fail if not a C# object or maybe if nil.
      (object:get-type obj-or-string))
    (error () nil)))

(defun get-type-full-name (obj)
  "Gets the C# string Full Name of the specified object, or nil if none.
   Note, if you pass in a C# Type object, it will probably tell you the name
   System.Type. :)"
  (let ((typ (get-type obj)))
    (when typ
      (handler-case
        (type:full-name typ)
        (error () nil)))))

(eval-when (:load-toplevel :execute)
  (format *error-output* "[monoutils.lisp] Initializing MonoUtilsRegistrar...~%")
  (dotnet:static "MonoUtilsRegistrar" "Initialize"))
