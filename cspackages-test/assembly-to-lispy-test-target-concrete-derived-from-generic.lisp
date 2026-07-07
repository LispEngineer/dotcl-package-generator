;;; Generated automatically. Do not edit.
;;; Class: AssemblyToLispyTestTarget.ConcreteDerivedFromGeneric
;;; Generator Version: 40
;;; Creation Date: 2026-07-07T01:02:29Z

(cl:in-package :assembly-to-lispy-test-target-concrete-derived-from-generic)

(cl:defconstant <type> (dotnet:resolve-type "AssemblyToLispyTestTarget.ConcreteDerivedFromGeneric"))
(cl:defconstant <type-str> "AssemblyToLispyTestTarget.ConcreteDerivedFromGeneric")
(cl:defconstant <creation> "2026-07-07T01:02:29Z")
(cl:defconstant <version> 40)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "AssemblyToLispyTestTarget.ConcreteDerivedFromGeneric")))

(cl:defun new ()
  (dotnet:new <type-str>))

