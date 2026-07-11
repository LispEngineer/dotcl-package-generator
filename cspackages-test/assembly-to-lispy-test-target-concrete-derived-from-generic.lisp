;;; Generated automatically. Do not edit.
;;; Class: AssemblyToLispyTestTarget.ConcreteDerivedFromGeneric
;;; Generator Version: 42
;;; Creation Date: 2026-07-11T12:55:15Z

(cl:in-package :assembly-to-lispy-test-target-concrete-derived-from-generic)

(cl:define-symbol-macro <type> (dotnet:resolve-type "AssemblyToLispyTestTarget.ConcreteDerivedFromGeneric"))
(cl:defconstant <type-str> "AssemblyToLispyTestTarget.ConcreteDerivedFromGeneric")
(cl:defconstant <creation> "2026-07-11T12:55:15Z")
(cl:defconstant <version> 42)

;; Register C# Type with CLOS
(cl:eval-when (:load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "AssemblyToLispyTestTarget.ConcreteDerivedFromGeneric")))

(cl:defun new ()
  (dotnet:new <type-str>))

