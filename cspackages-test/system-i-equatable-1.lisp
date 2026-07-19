;;; Generated automatically. Do not edit.
;;; Class: System.IEquatable`1
;;; Generator Version: 51
;;; Creation Date: 2026-07-19T15:11:53Z

(cl:in-package :system-i-equatable-1)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.IEquatable`1"))
(cl:defconstant <type-str> "System.IEquatable`1")
(cl:defconstant <creation> "2026-07-19T15:11:53Z")
(cl:defconstant <version> 51)

(cl:defun equals (obj! other)
  "Summary: Indicates whether the current object is equal to another object of the same type.
Returns: if the current object is equal to the other parameter; otherwise, .
Parameters:
  - other (T): An object to compare with this object.
"
  (dotnet:invoke (cl:the (dotnet "System.IEquatable`1") obj!) "Equals" other))

