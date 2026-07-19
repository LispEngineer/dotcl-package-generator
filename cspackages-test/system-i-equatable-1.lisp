;;; Generated automatically. Do not edit.
;;; Class: System.IEquatable`1
;;; Generator Version: 52
;;; Creation Date: 2026-07-19T15:32:24Z
;;; Options: --export-interfaces
;;; Discovered via: --export-interfaces from System.ValueTuple`2

(cl:in-package :system-i-equatable-1)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.IEquatable`1"))
(cl:defconstant <type-str> "System.IEquatable`1")
(cl:defconstant <creation> "2026-07-19T15:32:24Z")
(cl:defconstant <version> 52)

(cl:defun equals (obj! other)
  "Summary: Indicates whether the current object is equal to another object of the same type.
Returns: if the current object is equal to the other parameter; otherwise, .
Parameters:
  - other (T): An object to compare with this object.
"
  (dotnet:invoke (cl:the (dotnet "System.IEquatable`1") obj!) "Equals" other))

