;;; Generated automatically. Do not edit.
;;; Class: System.Collections.Generic.Dictionary`2+ValueCollection
;;; Generator Version: 45
;;; Creation Date: 2026-07-11T18:35:30Z

(cl:in-package :system-collections-generic-dictionary-2-value-collection)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Collections.Generic.Dictionary`2+ValueCollection"))
(cl:defconstant <type-str> "System.Collections.Generic.Dictionary`2+ValueCollection")
(cl:defconstant <creation> "2026-07-11T18:35:30Z")
(cl:defconstant <version> 45)

(cl:defun new (dictionary)
  "Summary: Initializes a new instance of the System.Collections.Generic.Dictionary`2.ValueCollection class that reflects the values in the specified System.Collections.Generic.Dictionary`2.
Parameters:
  - dictionary (System.Collections.Generic.Dictionary`2[TKey, TValue]): The System.Collections.Generic.Dictionary`2 whose values are reflected in the new System.Collections.Generic.Dictionary`2.ValueCollection.
"
  (dotnet:new <type-str> dictionary))

(cl:defun count (obj!)
  "Gets the number of elements contained in the System.Collections.Generic.Dictionary`2.ValueCollection."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2+ValueCollection") obj!) "get_Count"))

(cl:defun copy-to (obj! array index)
  "Summary: Copies the System.Collections.Generic.Dictionary`2.ValueCollection elements to an existing one-dimensional System.Array, starting at the specified array index.
Parameters:
  - array (TValue[]): The one-dimensional System.Array that is the destination of the elements copied from System.Collections.Generic.Dictionary`2.ValueCollection. The System.Array must have zero-based indexing.
  - index (System.Int32): The zero-based index in array at which copying begins.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2+ValueCollection") obj!) "CopyTo" array index))

(cl:defun get-enumerator (obj!)
  "Summary: Returns an enumerator that iterates through the System.Collections.Generic.Dictionary`2.ValueCollection.
Returns: A System.Collections.Generic.Dictionary`2.ValueCollection.Enumerator for the System.Collections.Generic.Dictionary`2.ValueCollection.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2+ValueCollection") obj!) "GetEnumerator"))

