;;; Generated automatically. Do not edit.
;;; Class: AssemblyToLispyTestTarget.NestingContainer
;;; Generator Version: 41
;;; Creation Date: 2026-07-11T03:36:09Z

(cl:in-package :assembly-to-lispy-test-target-nesting-container)

(cl:defconstant <type> (dotnet:resolve-type "AssemblyToLispyTestTarget.NestingContainer"))
(cl:defconstant <type-str> "AssemblyToLispyTestTarget.NestingContainer")
(cl:defconstant <creation> "2026-07-11T03:36:09Z")
(cl:defconstant <version> 41)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "AssemblyToLispyTestTarget.NestingContainer")))

(cl:defun new ()
  (dotnet:new <type-str>))

