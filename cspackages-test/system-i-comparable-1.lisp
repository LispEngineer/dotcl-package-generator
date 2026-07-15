;;; Generated automatically. Do not edit.
;;; Class: System.IComparable`1
;;; Generator Version: 50
;;; Creation Date: 2026-07-15T12:15:32Z

(cl:in-package :system-i-comparable-1)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.IComparable`1"))
(cl:defconstant <type-str> "System.IComparable`1")
(cl:defconstant <creation> "2026-07-15T12:15:32Z")
(cl:defconstant <version> 50)

(cl:defun compare-to (obj! other)
  "Summary: Compares the current instance with another object of the same type and returns an integer that indicates whether the current instance precedes, follows, or occurs in the same position in the sort order as the other object.
Returns: A value that indicates the relative order of the objects being compared. The return value has these meanings: Value Meaning Less than zero This instance precedes other in the sort order. Zero This instance occurs in the same position in the sort order as other. Greater than zero This instance follows other in the sort order.
Parameters:
  - other (T): An object to compare with this instance.
"
  (dotnet:invoke (cl:the (dotnet "System.IComparable`1") obj!) "CompareTo" other))

