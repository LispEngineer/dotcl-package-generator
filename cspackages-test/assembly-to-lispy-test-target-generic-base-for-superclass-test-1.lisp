;;; Generated automatically. Do not edit.
;;; Class: AssemblyToLispyTestTarget.GenericBaseForSuperclassTest`1
;;; Generator Version: 47
;;; Creation Date: 2026-07-11T23:06:47Z

(cl:in-package :assembly-to-lispy-test-target-generic-base-for-superclass-test-1)

(cl:define-symbol-macro <type> (dotnet:resolve-type "AssemblyToLispyTestTarget.GenericBaseForSuperclassTest`1"))
(cl:defconstant <type-str> "AssemblyToLispyTestTarget.GenericBaseForSuperclassTest`1")
(cl:defconstant <creation> "2026-07-11T23:06:47Z")
(cl:defconstant <version> 47)

(cl:defun new ()
  (dotnet:new <type-str>))

(cl:defun generic-base-method (obj!)
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.GenericBaseForSuperclassTest`1") obj!) "GenericBaseMethod"))

