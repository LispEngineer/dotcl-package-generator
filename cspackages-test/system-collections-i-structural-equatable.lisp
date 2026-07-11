;;; Generated automatically. Do not edit.
;;; Class: System.Collections.IStructuralEquatable
;;; Generator Version: 44
;;; Creation Date: 2026-07-11T16:27:42Z

(cl:in-package :system-collections-i-structural-equatable)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Collections.IStructuralEquatable"))
(cl:defconstant <type-str> "System.Collections.IStructuralEquatable")
(cl:defconstant <creation> "2026-07-11T16:27:42Z")
(cl:defconstant <version> 44)

(cl:defun equals (obj! other comparer)
  "Summary: Determines whether an object is structurally equal to the current instance.
Returns: if the two objects are equal; otherwise, .
Parameters:
  - other (System.Object): The object to compare with the current instance.
  - comparer (System.Collections.IEqualityComparer): An object that determines whether the current instance and other are equal.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.IStructuralEquatable") obj!) "Equals" other comparer))

(cl:defun get-hash-code (obj! comparer)
  "Summary: Returns a hash code for the current instance.
Returns: The hash code for the current instance.
Parameters:
  - comparer (System.Collections.IEqualityComparer): An object that computes the hash code of the current object.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.IStructuralEquatable") obj!) "GetHashCode" comparer))

