;;; Generated automatically. Do not edit.
;;; Class: AssemblyToLispyTestTarget.NestingContainer+NestedLevel2+NestedLevel3
;;; Generator Version: 42
;;; Creation Date: 2026-07-11T12:55:15Z

(cl:in-package :assembly-to-lispy-test-target-nesting-container-nested-level2-nested-level3)

(cl:define-symbol-macro <type> (dotnet:resolve-type "AssemblyToLispyTestTarget.NestingContainer+NestedLevel2+NestedLevel3"))
(cl:defconstant <type-str> "AssemblyToLispyTestTarget.NestingContainer+NestedLevel2+NestedLevel3")
(cl:defconstant <creation> "2026-07-11T12:55:15Z")
(cl:defconstant <version> 42)

;; Register C# Type with CLOS
(cl:eval-when (:load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "AssemblyToLispyTestTarget.NestingContainer+NestedLevel2+NestedLevel3")))

(cl:defun new ()
  (dotnet:new <type-str>))

