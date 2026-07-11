;;; Generated automatically. Do not edit.
;;; Class: System.Collections.IEnumerable
;;; Generator Version: 46
;;; Creation Date: 2026-07-11T19:17:50Z

(cl:in-package :system-collections-i-enumerable)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Collections.IEnumerable"))
(cl:defconstant <type-str> "System.Collections.IEnumerable")
(cl:defconstant <creation> "2026-07-11T19:17:50Z")
(cl:defconstant <version> 46)

(cl:defun get-enumerator (obj!)
  "Summary: Returns an enumerator that iterates through a collection.
Returns: An System.Collections.IEnumerator object that can be used to iterate through the collection.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.IEnumerable") obj!) "GetEnumerator"))

;; Extension methods (exact match on this == System.Collections.IEnumerable):
;;   System.Linq.Enumerable::Cast(IEnumerable) -> IEnumerable -- skipped (generic type arguments/parameters not yet supported)
;;   System.Linq.Enumerable::OfType(IEnumerable) -> IEnumerable -- skipped (generic type arguments/parameters not yet supported)

