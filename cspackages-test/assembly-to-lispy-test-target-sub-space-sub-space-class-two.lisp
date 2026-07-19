;;; Generated automatically. Do not edit.
;;; Class: AssemblyToLispyTestTarget.SubSpace.SubSpaceClassTwo
;;; Generator Version: 52
;;; Creation Date: 2026-07-19T15:45:00Z
;;; Options: --defgeneric

(cl:in-package :assembly-to-lispy-test-target-sub-space-sub-space-class-two)

(cl:define-symbol-macro <type> (dotnet:resolve-type "AssemblyToLispyTestTarget.SubSpace.SubSpaceClassTwo"))
(cl:defconstant <type-str> "AssemblyToLispyTestTarget.SubSpace.SubSpaceClassTwo")
(cl:defconstant <creation> "2026-07-19T15:45:00Z")
(cl:defconstant <version> 52)

(cl:defun new ()
  (dotnet:new <type-str>))

(cl:defun kind (obj!)
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.SubSpace.SubSpaceClassTwo") obj!) "Kind"))

