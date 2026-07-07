;;; Generated automatically. Do not edit.
;;; Class: AssemblyToLispyTestTarget.NestingContainer+NestedLevel2
;;; Generator Version: 40
;;; Creation Date: 2026-07-07T01:02:29Z

(cl:in-package :assembly-to-lispy-test-target-nesting-container-nested-level2)

(cl:defconstant <type> (dotnet:resolve-type "AssemblyToLispyTestTarget.NestingContainer+NestedLevel2"))
(cl:defconstant <type-str> "AssemblyToLispyTestTarget.NestingContainer+NestedLevel2")
(cl:defconstant <creation> "2026-07-07T01:02:29Z")
(cl:defconstant <version> 40)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "AssemblyToLispyTestTarget.NestingContainer+NestedLevel2")))

(cl:defun new ()
  (dotnet:new <type-str>))

