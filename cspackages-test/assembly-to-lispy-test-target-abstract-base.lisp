;;; Generated automatically. Do not edit.
;;; Class: AssemblyToLispyTestTarget.AbstractBase
;;; Generator Version: 39
;;; Creation Date: 2026-07-06T00:55:09Z

(cl:in-package :assembly-to-lispy-test-target-abstract-base)

(cl:defconstant <type> (dotnet:resolve-type "AssemblyToLispyTestTarget.AbstractBase"))
(cl:defconstant <type-str> "AssemblyToLispyTestTarget.AbstractBase")
(cl:defconstant <creation> "2026-07-06T00:55:09Z")
(cl:defconstant <version> 39)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "AssemblyToLispyTestTarget.AbstractBase")))

(cl:defun new ()
  (dotnet:new <type-str>))

