;;; Generated automatically. Do not edit.
;;; Class: AssemblyToLispyTestTarget.GenericBaseForSuperclassTest`1
;;; Generator Version: 41
;;; Creation Date: 2026-07-11T03:36:09Z

(cl:in-package :assembly-to-lispy-test-target-generic-base-for-superclass-test-1)

(cl:defconstant <type> (dotnet:resolve-type "AssemblyToLispyTestTarget.GenericBaseForSuperclassTest`1"))
(cl:defconstant <type-str> "AssemblyToLispyTestTarget.GenericBaseForSuperclassTest`1")
(cl:defconstant <creation> "2026-07-11T03:36:09Z")
(cl:defconstant <version> 41)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "AssemblyToLispyTestTarget.GenericBaseForSuperclassTest`1")))

(cl:defun new ()
  (dotnet:new <type-str>))

(cl:defun generic-base-method (obj!)
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.GenericBaseForSuperclassTest`1") obj!) "GenericBaseMethod"))

