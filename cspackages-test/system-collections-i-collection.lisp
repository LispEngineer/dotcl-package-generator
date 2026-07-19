;;; Generated automatically. Do not edit.
;;; Class: System.Collections.ICollection
;;; Generator Version: 51
;;; Creation Date: 2026-07-19T15:11:53Z

(cl:in-package :system-collections-i-collection)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Collections.ICollection"))
(cl:defconstant <type-str> "System.Collections.ICollection")
(cl:defconstant <creation> "2026-07-19T15:11:53Z")
(cl:defconstant <version> 51)

(cl:defun count (obj!)
  "Gets the number of elements contained in the System.Collections.ICollection."
  (dotnet:invoke (cl:the (dotnet "System.Collections.ICollection") obj!) "get_Count"))

(cl:defun synchronized? (obj!)
  "Gets a value indicating whether access to the System.Collections.ICollection is synchronized (thread safe)."
  (dotnet:invoke (cl:the (dotnet "System.Collections.ICollection") obj!) "get_IsSynchronized"))

(cl:defun sync-root (obj!)
  "Gets an object that can be used to synchronize access to the System.Collections.ICollection."
  (dotnet:invoke (cl:the (dotnet "System.Collections.ICollection") obj!) "get_SyncRoot"))

(cl:defun copy-to (obj! array index)
  "Summary: Copies the elements of the System.Collections.ICollection to an System.Array, starting at a particular System.Array index.
Parameters:
  - array (System.Array): The one-dimensional System.Array that is the destination of the elements copied from System.Collections.ICollection. The System.Array must have zero-based indexing.
  - index (System.Int32): The zero-based index in array at which copying begins.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.ICollection") obj!) "CopyTo" array index))

