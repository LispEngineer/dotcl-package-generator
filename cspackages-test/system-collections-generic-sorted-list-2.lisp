;;; Generated automatically. Do not edit.
;;; Class: System.Collections.Generic.SortedList`2
;;; Generator Version: 52
;;; Creation Date: 2026-07-19T15:32:24Z
;;; Options: --defgeneric

(cl:in-package :system-collections-generic-sorted-list-2)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Collections.Generic.SortedList`2"))
(cl:defconstant <type-str> "System.Collections.Generic.SortedList`2")
(cl:defconstant <creation> "2026-07-19T15:32:24Z")
(cl:defconstant <version> 52)

(cl:defun new (cl:&optional (capacity cl:nil supplied-capacity) (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Collections.Generic.SortedList`2 constructor overloads. Dispatches at runtime.

new()
  Summary: Initializes a new instance of the System.Collections.Generic.SortedList`2 class that is empty, has the default initial capacity, and uses the default System.Collections.Generic.IComparer`1.

new(Int32)
  Summary: Initializes a new instance of the System.Collections.Generic.SortedList`2 class that is empty, has the specified initial capacity, and uses the default System.Collections.Generic.IComparer`1.
  Parameters:
    - capacity (System.Int32): The initial number of elements that the System.Collections.Generic.SortedList`2 can contain.

new(IComparer)
  Summary: Initializes a new instance of the System.Collections.Generic.SortedList`2 class that is empty, has the default initial capacity, and uses the specified System.Collections.Generic.IComparer`1.
  Parameters:
    - comparer (System.Collections.Generic.IComparer`1[TKey]): The System.Collections.Generic.IComparer`1 implementation to use when comparing keys. -or- to use the default System.Collections.Generic.Comparer`1 for the type of the key.

new(IDictionary)
  Summary: Initializes a new instance of the System.Collections.Generic.SortedList`2 class that contains elements copied from the specified System.Collections.Generic.IDictionary`2, has sufficient capacity to accommodate the number of elements copied, and uses the default System.Collections.Generic.IComparer`1.
  Parameters:
    - dictionary (System.Collections.Generic.IDictionary`2[TKey, TValue]): The System.Collections.Generic.IDictionary`2 whose elements are copied to the new System.Collections.Generic.SortedList`2.

new(Int32, IComparer)
  Summary: Initializes a new instance of the System.Collections.Generic.SortedList`2 class that is empty, has the specified initial capacity, and uses the specified System.Collections.Generic.IComparer`1.
  Parameters:
    - capacity (System.Int32): The initial number of elements that the System.Collections.Generic.SortedList`2 can contain.
    - comparer (System.Collections.Generic.IComparer`1[TKey]): The System.Collections.Generic.IComparer`1 implementation to use when comparing keys. -or- to use the default System.Collections.Generic.Comparer`1 for the type of the key.

new(IDictionary, IComparer)
  Summary: Initializes a new instance of the System.Collections.Generic.SortedList`2 class that contains elements copied from the specified System.Collections.Generic.IDictionary`2, has sufficient capacity to accommodate the number of elements copied, and uses the specified System.Collections.Generic.IComparer`1.
  Parameters:
    - dictionary (System.Collections.Generic.IDictionary`2[TKey, TValue]): The System.Collections.Generic.IDictionary`2 whose elements are copied to the new System.Collections.Generic.SortedList`2.
    - comparer (System.Collections.Generic.IComparer`1[TKey]): The System.Collections.Generic.IComparer`1 implementation to use when comparing keys. -or- to use the default System.Collections.Generic.Comparer`1 for the type of the key.
"
  (cl:cond
    ((cl:and supplied-capacity (cl:numberp capacity) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IComparer`1[TKey]")))
     (dotnet:new <type-str> capacity comparer))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:is-instance-of capacity "System.Collections.Generic.IDictionary`2[TKey, TValue]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IComparer`1[TKey]")))
     (dotnet:new <type-str> capacity comparer))
    ((cl:and supplied-capacity (cl:numberp capacity) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:is-instance-of capacity "System.Collections.Generic.IComparer`1[TKey]")) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:is-instance-of capacity "System.Collections.Generic.IDictionary`2[TKey, TValue]")) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity))
    ((cl:and (cl:not supplied-capacity) (cl:not supplied-comparer))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-GENERIC-SORTED-LIST-2"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-capacity (cl:list :capacity capacity)) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun capacity (obj!)
  "Gets or sets the number of elements that the System.Collections.Generic.SortedList`2 can contain."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "get_Capacity"))

(cl:defun (cl:setf capacity) (new-value obj!)
  "Gets or sets the number of elements that the System.Collections.Generic.SortedList`2 can contain."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "set_Capacity" new-value))

(cl:defun comparer (obj!)
  "Gets the System.Collections.Generic.IComparer`1 for the sorted list."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "get_Comparer"))

(cl:defun count (obj!)
  "Gets the number of key/value pairs contained in the System.Collections.Generic.SortedList`2."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "get_Count"))

(cl:defun item (obj! key)
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "get_Item" key))

(cl:defun (cl:setf item) (new-value obj! key)
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "set_Item" key new-value))

(cl:defun keys (obj!)
  "Gets a collection containing the keys in the System.Collections.Generic.SortedList`2, in sorted order."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "get_Keys"))

(cl:defun values (obj!)
  "Gets a collection containing the values in the System.Collections.Generic.SortedList`2."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "get_Values"))

(cl:defun add (obj! key value)
  "Summary: Adds an element with the specified key and value into the System.Collections.Generic.SortedList`2.
Parameters:
  - key (TKey): The key of the element to add.
  - value (TValue): The value of the element to add. The value can be for reference types.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "Add" key value))

(cl:defun clear (obj!)
  "Summary: Removes all elements from the System.Collections.Generic.SortedList`2.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "Clear"))

(cl:defun contains-key (obj! key)
  "Summary: Determines whether the System.Collections.Generic.SortedList`2 contains a specific key.
Returns: if the System.Collections.Generic.SortedList`2 contains an element with the specified key; otherwise, .
Parameters:
  - key (TKey): The key to locate in the System.Collections.Generic.SortedList`2.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "ContainsKey" key))

(cl:defun contains-value (obj! value)
  "Summary: Determines whether the System.Collections.Generic.SortedList`2 contains a specific value.
Returns: if the System.Collections.Generic.SortedList`2 contains an element with the specified value; otherwise, .
Parameters:
  - value (TValue): The value to locate in the System.Collections.Generic.SortedList`2. The value can be for reference types.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "ContainsValue" value))

(cl:defun get-enumerator (obj!)
  "Summary: Returns an enumerator that iterates through the System.Collections.Generic.SortedList`2.
Returns: An System.Collections.Generic.IEnumerator`1 of type System.Collections.Generic.KeyValuePair`2 for the System.Collections.Generic.SortedList`2.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "GetEnumerator"))

(cl:defun get-key-at-index (obj! index)
  "Summary: Gets the key corresponding to the specified index.
Returns: The key corresponding to the specified index.
Parameters:
  - index (System.Int32): The zero-based index of the key within the entire System.Collections.Generic.SortedList`2.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "GetKeyAtIndex" index))

(cl:defun get-value-at-index (obj! index)
  "Summary: Gets the value corresponding to the specified index.
Returns: The value corresponding to the specified index.
Parameters:
  - index (System.Int32): The zero-based index of the value within the entire System.Collections.Generic.SortedList`2.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "GetValueAtIndex" index))

(cl:defun index-of-key (obj! key)
  "Summary: Searches for the specified key and returns the zero-based index within the entire System.Collections.Generic.SortedList`2.
Returns: The zero-based index of key within the entire System.Collections.Generic.SortedList`2, if found; otherwise, -1.
Parameters:
  - key (TKey): The key to locate in the System.Collections.Generic.SortedList`2.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "IndexOfKey" key))

(cl:defun index-of-value (obj! value)
  "Summary: Searches for the specified value and returns the zero-based index of the first occurrence within the entire System.Collections.Generic.SortedList`2.
Returns: The zero-based index of the first occurrence of value within the entire System.Collections.Generic.SortedList`2, if found; otherwise, -1.
Parameters:
  - value (TValue): The value to locate in the System.Collections.Generic.SortedList`2. The value can be for reference types.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "IndexOfValue" value))

(cl:defun remove (obj! key)
  "Summary: Removes the element with the specified key from the System.Collections.Generic.SortedList`2.
Returns: if the element is successfully removed; otherwise, . This method also returns if key was not found in the original System.Collections.Generic.SortedList`2.
Parameters:
  - key (TKey): The key of the element to remove.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "Remove" key))

(cl:defun remove-at (obj! index)
  "Summary: Removes the element at the specified index of the System.Collections.Generic.SortedList`2.
Parameters:
  - index (System.Int32): The zero-based index of the element to remove.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "RemoveAt" index))

(cl:defun set-value-at-index (obj! index value)
  "Summary: Updates the value corresponding to the specified index.
Parameters:
  - index (System.Int32): The zero-based index of the value within the entire System.Collections.Generic.SortedList`2.
  - value (TValue): The value with which to replace the entry at the specified index.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "SetValueAtIndex" index value))

(cl:defun trim-excess (obj!)
  "Summary: Sets the capacity to the actual number of elements in the System.Collections.Generic.SortedList`2, if that number is less than 90 percent of current capacity.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.SortedList`2") obj!) "TrimExcess"))

(cl:defun try-get-value (obj! key)
  "Returns (cl:values <primary-return> value) -- TryGetValue(TKey, out TValue&) -> Boolean
Summary: Gets the value associated with the specified key.
Returns: if the System.Collections.Generic.SortedList`2 contains an element with the specified key; otherwise, .
Parameters:
  - key (TKey): The key whose value to get.
"
  (dotnet:call-out obj! "TryGetValue" key))

