;;; Generated automatically. Do not edit.
;;; Class: System.Collections.IStructuralComparable
;;; Generator Version: 37
;;; Creation Date: 2026-07-05T18:46:38Z

(cl:in-package :system-collections-i-structural-comparable)

(cl:defconstant <type> (dotnet:resolve-type "System.Collections.IStructuralComparable"))
(cl:defconstant <type-str> "System.Collections.IStructuralComparable")
(cl:defconstant <creation> "2026-07-05T18:46:38Z")
(cl:defconstant <version> 37)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Collections.IStructuralComparable")))

(cl:defun compare-to (obj! other comparer)
  "Summary: Determines whether the current collection object precedes, occurs in the same position as, or follows another object in the sort order.
Returns: A signed integer that indicates the relationship of the current collection object to other in the sort order: - If less than 0, the current instance precedes other. - If 0, the current instance and other are equal. - If greater than 0, the current instance follows other. Return value Description -1 The current instance precedes other. 0 The current instance and other are equal. 1 The current instance follows other.
Parameters:
  - other (System.Object): The object to compare with the current instance.
  - comparer (System.Collections.IComparer): An object that compares members of the current collection object with the corresponding members of other.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.IStructuralComparable") obj!) "CompareTo" other comparer))

