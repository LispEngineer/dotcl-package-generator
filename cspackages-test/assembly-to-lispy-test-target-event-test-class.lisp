;;; Generated automatically. Do not edit.
;;; Class: AssemblyToLispyTestTarget.EventTestClass
;;; Generator Version: 47
;;; Creation Date: 2026-07-11T23:06:47Z

(cl:in-package :assembly-to-lispy-test-target-event-test-class)

(cl:define-symbol-macro <type> (dotnet:resolve-type "AssemblyToLispyTestTarget.EventTestClass"))
(cl:defconstant <type-str> "AssemblyToLispyTestTarget.EventTestClass")
(cl:defconstant <creation> "2026-07-11T23:06:47Z")
(cl:defconstant <version> 47)

(cl:defun new ()
  (dotnet:new <type-str>))

(cl:defun add-something-happened (obj! handler)
  (dotnet:add-event (cl:the (dotnet "AssemblyToLispyTestTarget.EventTestClass") obj!) "SomethingHappened" handler))

(cl:defun remove-something-happened (obj! handler)
  "Pass the exact same HANDLER object given to add-something-happened -- removal is by identity, not by behavioral equivalence."
  (dotnet:remove-event (cl:the (dotnet "AssemblyToLispyTestTarget.EventTestClass") obj!) "SomethingHappened" handler))

(cl:defun raise-something-happened (obj!)
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.EventTestClass") obj!) "RaiseSomethingHappened"))

;; Extension methods (exact match on this == AssemblyToLispyTestTarget.EventTestClass):
;;   AssemblyToLispyTestTarget.EventTestClassExtensions::AdjustCount(EventTestClass, ref Int32&) -> Void -- skipped (special parameter types (ref/out/params/default) not yet supported)
;;   AssemblyToLispyTestTarget.EventTestClassExtensions::RaiseSomethingHappened(EventTestClass) -> Void -- skipped (this class already declares its own member of this name)
;;   AssemblyToLispyTestTarget.EventTestClassExtensions::Frob(EventTestClass) -> Void -- skipped (ambiguous -- more than one extension method maps to Lisp name frob)
;;   AssemblyToLispyTestTarget.EventTestClassExtensions::Frob(EventTestClass, Int32) -> Void -- skipped (ambiguous -- more than one extension method maps to Lisp name frob)
(cl:defun describe (obj! prefix)
  "Extension method from AssemblyToLispyTestTarget.EventTestClassExtensions (assembly AssemblyToLispyTestTarget.dll)."
  (dotnet:static "AssemblyToLispyTestTarget.EventTestClassExtensions" "Describe" obj! prefix))


