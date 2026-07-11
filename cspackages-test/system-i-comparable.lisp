;;; Generated automatically. Do not edit.
;;; Class: System.IComparable
;;; Generator Version: 41
;;; Creation Date: 2026-07-11T03:36:09Z

(cl:in-package :system-i-comparable)

(cl:defconstant <type> (dotnet:resolve-type "System.IComparable"))
(cl:defconstant <type-str> "System.IComparable")
(cl:defconstant <creation> "2026-07-11T03:36:09Z")
(cl:defconstant <version> 41)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.IComparable")))

(cl:defun compare-to (obj! obj)
  "Summary: Compares the current instance with another object of the same type and returns an integer that indicates whether the current instance precedes, follows, or occurs in the same position in the sort order as the other object.
Returns: A value that indicates the relative order of the objects being compared. The return value has these meanings: Value Meaning Less than zero This instance precedes obj in the sort order. Zero This instance occurs in the same position in the sort order as obj. Greater than zero This instance follows obj in the sort order.
Parameters:
  - obj (System.Object): An object to compare with this instance.
"
  (dotnet:invoke (cl:the (dotnet "System.IComparable") obj!) "CompareTo" obj))

