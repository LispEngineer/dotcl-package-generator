;;; Generated automatically. Do not edit.
;;; Class: System.Collections.Generic.Dictionary`2+KeyCollection
;;; Generator Version: 42
;;; Creation Date: 2026-07-11T12:55:15Z

(cl:in-package :system-collections-generic-dictionary-2-key-collection)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Collections.Generic.Dictionary`2+KeyCollection"))
(cl:defconstant <type-str> "System.Collections.Generic.Dictionary`2+KeyCollection")
(cl:defconstant <creation> "2026-07-11T12:55:15Z")
(cl:defconstant <version> 42)

;; Register C# Type with CLOS
(cl:eval-when (:load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Collections.Generic.Dictionary`2+KeyCollection")))

(cl:defun new (dictionary)
  "Summary: Initializes a new instance of the System.Collections.Generic.Dictionary`2.KeyCollection class that reflects the keys in the specified System.Collections.Generic.Dictionary`2.
Parameters:
  - dictionary (System.Collections.Generic.Dictionary`2[TKey, TValue]): The System.Collections.Generic.Dictionary`2 whose keys are reflected in the new System.Collections.Generic.Dictionary`2.KeyCollection.
"
  (dotnet:new <type-str> dictionary))

(cl:defun count (obj!)
  "Gets the number of elements contained in the System.Collections.Generic.Dictionary`2.KeyCollection."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2+KeyCollection") obj!) "get_Count"))

(cl:defun contains (obj! item)
  "Summary: Determines whether the System.Collections.Generic.ICollection`1 contains a specific value.
Returns: if item is found in the System.Collections.Generic.ICollection`1; otherwise, .
Parameters:
  - item (TKey): The object to locate in the System.Collections.Generic.ICollection`1.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2+KeyCollection") obj!) "Contains" item))

(cl:defun copy-to (obj! array index)
  "Summary: Copies the System.Collections.Generic.Dictionary`2.KeyCollection elements to an existing one-dimensional System.Array, starting at the specified array index.
Parameters:
  - array (TKey[]): The one-dimensional System.Array that is the destination of the elements copied from System.Collections.Generic.Dictionary`2.KeyCollection. The System.Array must have zero-based indexing.
  - index (System.Int32): The zero-based index in array at which copying begins.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2+KeyCollection") obj!) "CopyTo" array index))

(cl:defun get-enumerator (obj!)
  "Summary: Returns an enumerator that iterates through the System.Collections.Generic.Dictionary`2.KeyCollection.
Returns: A System.Collections.Generic.Dictionary`2.KeyCollection.Enumerator for the System.Collections.Generic.Dictionary`2.KeyCollection.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2+KeyCollection") obj!) "GetEnumerator"))

