;;; Generated automatically. Do not edit.
;;; Class: AssemblyToLispyTestTarget.IDummyInterface
;;; Generator Version: 51
;;; Creation Date: 2026-07-19T15:11:53Z

(cl:in-package :assembly-to-lispy-test-target-i-dummy-interface)

(cl:define-symbol-macro <type> (dotnet:resolve-type "AssemblyToLispyTestTarget.IDummyInterface"))
(cl:defconstant <type-str> "AssemblyToLispyTestTarget.IDummyInterface")
(cl:defconstant <creation> "2026-07-19T15:11:53Z")
(cl:defconstant <version> 51)

(cl:defun interface-method (obj!)
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.IDummyInterface") obj!) "InterfaceMethod"))

