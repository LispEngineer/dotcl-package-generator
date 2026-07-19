;;; Generated automatically. Do not edit.
;;; Class: System.Collections.IEnumerable
;;; Generator Version: 52
;;; Creation Date: 2026-07-19T15:32:24Z
;;; Options: --export-interfaces --export-object --export-parents
;;; Discovered via: --export-parents/--export-interfaces from System.Collections.Specialized.NameValueCollection

(cl:in-package :system-collections-i-enumerable)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Collections.IEnumerable"))
(cl:defconstant <type-str> "System.Collections.IEnumerable")
(cl:defconstant <creation> "2026-07-19T15:32:24Z")
(cl:defconstant <version> 52)

(cl:defun get-enumerator (obj!)
  "Summary: Returns an enumerator that iterates through a collection.
Returns: An System.Collections.IEnumerator object that can be used to iterate through the collection.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.IEnumerable") obj!) "GetEnumerator"))

;; Extension methods (exact match on this == System.Collections.IEnumerable):
;;   System.Linq.Enumerable::Cast(IEnumerable) -> IEnumerable -- skipped (generic type arguments/parameters not yet supported)
;;   System.Linq.Enumerable::OfType(IEnumerable) -> IEnumerable -- skipped (generic type arguments/parameters not yet supported)

