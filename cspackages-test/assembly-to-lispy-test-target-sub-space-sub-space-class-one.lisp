;;; Generated automatically. Do not edit.
;;; Class: AssemblyToLispyTestTarget.SubSpace.SubSpaceClassOne
;;; Generator Version: 52
;;; Creation Date: 2026-07-19T15:45:00Z
;;; Options: --defgeneric

(cl:in-package :assembly-to-lispy-test-target-sub-space-sub-space-class-one)

(cl:define-symbol-macro <type> (dotnet:resolve-type "AssemblyToLispyTestTarget.SubSpace.SubSpaceClassOne"))
(cl:defconstant <type-str> "AssemblyToLispyTestTarget.SubSpace.SubSpaceClassOne")
(cl:defconstant <creation> "2026-07-19T15:45:00Z")
(cl:defconstant <version> 52)

(cl:defun new ()
  (dotnet:new <type-str>))

(cl:defun kind (obj!)
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.SubSpace.SubSpaceClassOne") obj!) "Kind"))

