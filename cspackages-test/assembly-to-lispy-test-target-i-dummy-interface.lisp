;;; Generated automatically. Do not edit.
;;; Class: AssemblyToLispyTestTarget.IDummyInterface
;;; Generator Version: 39
;;; Creation Date: 2026-07-06T00:55:09Z

(cl:in-package :assembly-to-lispy-test-target-i-dummy-interface)

(cl:defconstant <type> (dotnet:resolve-type "AssemblyToLispyTestTarget.IDummyInterface"))
(cl:defconstant <type-str> "AssemblyToLispyTestTarget.IDummyInterface")
(cl:defconstant <creation> "2026-07-06T00:55:09Z")
(cl:defconstant <version> 39)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "AssemblyToLispyTestTarget.IDummyInterface")))

(cl:defun interface-method (obj!)
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.IDummyInterface") obj!) "InterfaceMethod"))

