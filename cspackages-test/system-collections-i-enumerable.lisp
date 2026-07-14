;;; Generated automatically. Do not edit.
;;; Class: System.Collections.IEnumerable
;;; Generator Version: 48
;;; Creation Date: 2026-07-14T16:26:13Z

(cl:in-package :system-collections-i-enumerable)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Collections.IEnumerable"))
(cl:defconstant <type-str> "System.Collections.IEnumerable")
(cl:defconstant <creation> "2026-07-14T16:26:13Z")
(cl:defconstant <version> 48)

(cl:defun get-enumerator (obj!)
  "Summary: Returns an enumerator that iterates through a collection.
Returns: An System.Collections.IEnumerator object that can be used to iterate through the collection.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.IEnumerable") obj!) "GetEnumerator"))

;; Extension methods (exact match on this == System.Collections.IEnumerable):
;;   System.Linq.Enumerable::Cast(IEnumerable) -> IEnumerable -- skipped (generic type arguments/parameters not yet supported)
;;   System.Linq.Enumerable::OfType(IEnumerable) -> IEnumerable -- skipped (generic type arguments/parameters not yet supported)

