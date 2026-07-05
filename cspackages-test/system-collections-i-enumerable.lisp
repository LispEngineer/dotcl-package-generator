;;; Generated automatically. Do not edit.
;;; Class: System.Collections.IEnumerable
;;; Generator Version: 36
;;; Creation Date: 2026-07-05T18:30:04Z

(cl:in-package :system-collections-i-enumerable)

(cl:defconstant <type> (dotnet:resolve-type "System.Collections.IEnumerable"))
(cl:defconstant <type-str> "System.Collections.IEnumerable")
(cl:defconstant <creation> "2026-07-05T18:30:04Z")
(cl:defconstant <version> 36)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Collections.IEnumerable")))

(cl:defun get-enumerator (obj!)
  "Summary: Returns an enumerator that iterates through a collection.
Returns: An System.Collections.IEnumerator object that can be used to iterate through the collection.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.IEnumerable") obj!) "GetEnumerator"))

