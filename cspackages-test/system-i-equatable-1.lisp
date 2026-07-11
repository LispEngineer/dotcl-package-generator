;;; Generated automatically. Do not edit.
;;; Class: System.IEquatable`1
;;; Generator Version: 41
;;; Creation Date: 2026-07-11T03:36:09Z

(cl:in-package :system-i-equatable-1)

(cl:defconstant <type> (dotnet:resolve-type "System.IEquatable`1"))
(cl:defconstant <type-str> "System.IEquatable`1")
(cl:defconstant <creation> "2026-07-11T03:36:09Z")
(cl:defconstant <version> 41)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.IEquatable`1")))

(cl:defun equals (obj! other)
  "Summary: Indicates whether the current object is equal to another object of the same type.
Returns: if the current object is equal to the other parameter; otherwise, .
Parameters:
  - other (T): An object to compare with this object.
"
  (dotnet:invoke (cl:the (dotnet "System.IEquatable`1") obj!) "Equals" other))

