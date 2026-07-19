;;; Generated automatically. Do not edit.
;;; Class: AssemblyToLispyTestTarget.ObsoleteAndTupleFixtures
;;; Generator Version: 54
;;; Creation Date: 2026-07-19T20:42:53Z
;;; Options: (none)

(cl:in-package :assembly-to-lispy-test-target-obsolete-and-tuple-fixtures)

(cl:define-symbol-macro <type> (dotnet:resolve-type "AssemblyToLispyTestTarget.ObsoleteAndTupleFixtures"))
(cl:defconstant <type-str> "AssemblyToLispyTestTarget.ObsoleteAndTupleFixtures")
(cl:defconstant <creation> "2026-07-19T20:42:53Z")
(cl:defconstant <version> 54)

(cl:defun new ()
  (dotnet:new <type-str>))

(cl:defun obsolete-property (obj!)
  "OBSOLETE: use SomethingElse instead
"
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.ObsoleteAndTupleFixtures") obj!) "get_ObsoleteProperty"))

(cl:defun (cl:setf obsolete-property) (new-value obj!)
  "OBSOLETE: use SomethingElse instead
"
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.ObsoleteAndTupleFixtures") obj!) "set_ObsoleteProperty" new-value))

(cl:defun obsolete-field (obj!)
  "OBSOLETE.
"
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.ObsoleteAndTupleFixtures") obj!) "ObsoleteField"))

(cl:defun (cl:setf obsolete-field) (new-value obj!)
  "OBSOLETE.
"
  (cl:setf (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.ObsoleteAndTupleFixtures") obj!) "ObsoleteField") new-value))

(cl:defun get-nested-stats (obj!)
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.ObsoleteAndTupleFixtures") obj!) "GetNestedStats"))

(cl:defun get-partially-named (obj!)
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.ObsoleteAndTupleFixtures") obj!) "GetPartiallyNamed"))

(cl:defun get-stats (obj!)
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.ObsoleteAndTupleFixtures") obj!) "GetStats"))

(cl:defun obsolete-error (obj!)
  "OBSOLETE (error-level): completely gone
"
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.ObsoleteAndTupleFixtures") obj!) "ObsoleteError"))

(cl:defun obsolete-with-message (obj!)
  "OBSOLETE: use PlainObsolete instead
"
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.ObsoleteAndTupleFixtures") obj!) "ObsoleteWithMessage"))

(cl:defun plain-obsolete (obj!)
  "OBSOLETE.
"
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.ObsoleteAndTupleFixtures") obj!) "PlainObsolete"))

(cl:defun take-stats (obj! stats)
  (dotnet:invoke (cl:the (dotnet "AssemblyToLispyTestTarget.ObsoleteAndTupleFixtures") obj!) "TakeStats" stats))

