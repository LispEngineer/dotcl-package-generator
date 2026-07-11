;;; Generated automatically. Do not edit.
;;; Class: AssemblyToLispyTestTarget.GenericClass`1
;;; Generator Version: 42
;;; Creation Date: 2026-07-11T12:55:15Z

(cl:in-package :assembly-to-lispy-test-target-generic-class-1)

(cl:define-symbol-macro <type> (dotnet:resolve-type "AssemblyToLispyTestTarget.GenericClass`1"))
(cl:defconstant <type-str> "AssemblyToLispyTestTarget.GenericClass`1")
(cl:defconstant <creation> "2026-07-11T12:55:15Z")
(cl:defconstant <version> 42)

;; Register C# Type with CLOS
(cl:eval-when (:load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "AssemblyToLispyTestTarget.GenericClass`1")))

(cl:defun new ()
  (dotnet:new <type-str>))

(cl:defun + (a b)
  (dotnet:static <type-str> "op_Addition" (cl:the (dotnet "AssemblyToLispyTestTarget.GenericClass`1[T]") a) (cl:the (dotnet "AssemblyToLispyTestTarget.GenericClass`1[T]") b)))

(cl:defun interface-method (obj!)
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.GenericClass`1") obj!) "InterfaceMethod"))

