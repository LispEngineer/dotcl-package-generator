;;; Generated automatically. Do not edit.
;;; Class: System.Collections.Generic.Dictionary`2
;;; Generator Version: 47
;;; Creation Date: 2026-07-11T23:06:47Z

(cl:in-package :system-collections-generic-dictionary-2)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Collections.Generic.Dictionary`2"))
(cl:defconstant <type-str> "System.Collections.Generic.Dictionary`2")
(cl:defconstant <creation> "2026-07-11T23:06:47Z")
(cl:defconstant <version> 47)

(cl:defun new (cl:&optional (capacity cl:nil supplied-capacity) (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Collections.Generic.Dictionary`2 constructor overloads. Dispatches at runtime.

new()
  Summary: Initializes a new instance of the System.Collections.Generic.Dictionary`2 class that is empty, has the default initial capacity, and uses the default equality comparer for the key type.

new(Int32)
  Summary: Initializes a new instance of the System.Collections.Generic.Dictionary`2 class that is empty, has the specified initial capacity, and uses the default equality comparer for the key type.
  Parameters:
    - capacity (System.Int32): The initial number of elements that the System.Collections.Generic.Dictionary`2 can contain.

new(IEqualityComparer)
  Summary: Initializes a new instance of the System.Collections.Generic.Dictionary`2 class that is empty, has the default initial capacity, and uses the specified System.Collections.Generic.IEqualityComparer`1.
  Parameters:
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): The System.Collections.Generic.IEqualityComparer`1 implementation to use when comparing keys, or to use the default System.Collections.Generic.EqualityComparer`1 for the type of the key.

new(IDictionary)
  Summary: Initializes a new instance of the System.Collections.Generic.Dictionary`2 class that contains elements copied from the specified System.Collections.Generic.IDictionary`2 and uses the default equality comparer for the key type.
  Parameters:
    - dictionary (System.Collections.Generic.IDictionary`2[TKey, TValue]): The System.Collections.Generic.IDictionary`2 whose elements are copied to the new System.Collections.Generic.Dictionary`2.

new(KeyValuePair)
  Summary: Initializes a new instance of the System.Collections.Generic.Dictionary`2 class that contains elements copied from the specified System.Collections.Generic.IEnumerable`1.
  Parameters:
    - collection (System.Collections.Generic.IEnumerable`1[System.Collections.Generic.KeyValuePair`2[TKey, TValue]]): The System.Collections.Generic.IEnumerable`1 whose elements are copied to the new System.Collections.Generic.Dictionary`2.

new(Int32, IEqualityComparer)
  Summary: Initializes a new instance of the System.Collections.Generic.Dictionary`2 class that is empty, has the specified initial capacity, and uses the specified System.Collections.Generic.IEqualityComparer`1.
  Parameters:
    - capacity (System.Int32): The initial number of elements that the System.Collections.Generic.Dictionary`2 can contain.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): The System.Collections.Generic.IEqualityComparer`1 implementation to use when comparing keys, or to use the default System.Collections.Generic.EqualityComparer`1 for the type of the key.

new(IDictionary, IEqualityComparer)
  Summary: Initializes a new instance of the System.Collections.Generic.Dictionary`2 class that contains elements copied from the specified System.Collections.Generic.IDictionary`2 and uses the specified System.Collections.Generic.IEqualityComparer`1.
  Parameters:
    - dictionary (System.Collections.Generic.IDictionary`2[TKey, TValue]): The System.Collections.Generic.IDictionary`2 whose elements are copied to the new System.Collections.Generic.Dictionary`2.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): The System.Collections.Generic.IEqualityComparer`1 implementation to use when comparing keys, or to use the default System.Collections.Generic.EqualityComparer`1 for the type of the key.

new(KeyValuePair, IEqualityComparer)
  Summary: Initializes a new instance of the System.Collections.Generic.Dictionary`2 class that contains elements copied from the specified System.Collections.Generic.IEnumerable`1 and uses the specified System.Collections.Generic.IEqualityComparer`1.
  Parameters:
    - collection (System.Collections.Generic.IEnumerable`1[System.Collections.Generic.KeyValuePair`2[TKey, TValue]]): The System.Collections.Generic.IEnumerable`1 whose elements are copied to the new System.Collections.Generic.Dictionary`2.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): The System.Collections.Generic.IEqualityComparer`1 implementation to use when comparing keys, or to use the default System.Collections.Generic.EqualityComparer`1 for the type of the key.

new(SerializationInfo, StreamingContext)
  Summary: Initializes a new instance of the System.Collections.Generic.Dictionary`2 class with serialized data.
  Parameters:
    - info (System.Runtime.Serialization.SerializationInfo): A System.Runtime.Serialization.SerializationInfo object containing the information required to serialize the System.Collections.Generic.Dictionary`2.
    - context (System.Runtime.Serialization.StreamingContext): A System.Runtime.Serialization.StreamingContext structure containing the source and destination of the serialized stream associated with the System.Collections.Generic.Dictionary`2.
"
  (cl:cond
    ((cl:and supplied-capacity (cl:numberp capacity) supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)))
     (dotnet:new <type-str> capacity comparer))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)) supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)))
     (dotnet:new <type-str> capacity comparer))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)) supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)))
     (dotnet:new <type-str> capacity comparer))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)) supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)))
     (dotnet:new <type-str> capacity comparer))
    ((cl:and supplied-capacity (cl:numberp capacity) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity))
    ((cl:and (cl:not supplied-capacity) (cl:not supplied-comparer))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-GENERIC-DICTIONARY-2"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-capacity (cl:list :capacity capacity)) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun capacity (obj!)
  "Gets the total numbers of elements the internal data structure can hold without resizing."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "get_Capacity"))

(cl:defun comparer (obj!)
  "Gets the System.Collections.Generic.IEqualityComparer`1 that is used to determine equality of keys for the dictionary."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "get_Comparer"))

(cl:defun count (obj!)
  "Gets the number of key/value pairs contained in the System.Collections.Generic.Dictionary`2."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "get_Count"))

(cl:defun item (obj! key)
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "get_Item" key))

(cl:defun (cl:setf item) (new-value obj! key)
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "set_Item" key new-value))

(cl:defun keys (obj!)
  "Gets a collection containing the keys in the System.Collections.Generic.Dictionary`2."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "get_Keys"))

(cl:defun values (obj!)
  "Gets a collection containing the values in the System.Collections.Generic.Dictionary`2."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "get_Values"))

(cl:defun add (obj! key value)
  "Summary: Adds the specified key and value to the dictionary.
Parameters:
  - key (TKey): The key of the element to add.
  - value (TValue): The value of the element to add. The value can be for reference types.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "Add" key value))

(cl:defun clear (obj!)
  "Summary: Removes all keys and values from the System.Collections.Generic.Dictionary`2.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "Clear"))

(cl:defun contains-key (obj! key)
  "Summary: Determines whether the System.Collections.Generic.Dictionary`2 contains the specified key.
Returns: if the System.Collections.Generic.Dictionary`2 contains an element with the specified key; otherwise, .
Parameters:
  - key (TKey): The key to locate in the System.Collections.Generic.Dictionary`2.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "ContainsKey" key))

(cl:defun contains-value (obj! value)
  "Summary: Determines whether the System.Collections.Generic.Dictionary`2 contains a specific value.
Returns: if the System.Collections.Generic.Dictionary`2 contains an element with the specified value; otherwise, .
Parameters:
  - value (TValue): The value to locate in the System.Collections.Generic.Dictionary`2. The value can be for reference types.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "ContainsValue" value))

(cl:defun ensure-capacity (obj! capacity)
  "Summary: Ensures that the dictionary can hold up to a specified number of entries without any further expansion of its backing storage.
Returns: The current capacity of the System.Collections.Generic.Dictionary`2.
Parameters:
  - capacity (System.Int32): The number of entries.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "EnsureCapacity" capacity))

(cl:defun get-alternate-lookup (type obj!)
  "Summary: Gets an instance of a type that can be used to perform operations on the current System.Collections.Generic.Dictionary`2 using a as a key instead of a .
Returns: The created lookup instance.
"
  (dotnet:invoke-generic (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "GetAlternateLookup" (cl:list type)))

(cl:defun get-enumerator (obj!)
  "Summary: Returns an enumerator that iterates through the System.Collections.Generic.Dictionary`2.
Returns: A System.Collections.Generic.Dictionary`2.Enumerator structure for the System.Collections.Generic.Dictionary`2.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "GetEnumerator"))

(cl:defun get-object-data (obj! info context)
  "Summary: Implements the System.Runtime.Serialization.ISerializable interface and returns the data needed to serialize the System.Collections.Generic.Dictionary`2 instance.
Parameters:
  - info (System.Runtime.Serialization.SerializationInfo): A System.Runtime.Serialization.SerializationInfo object that contains the information required to serialize the System.Collections.Generic.Dictionary`2 instance.
  - context (System.Runtime.Serialization.StreamingContext): A System.Runtime.Serialization.StreamingContext structure that contains the source and destination of the serialized stream associated with the System.Collections.Generic.Dictionary`2 instance.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "GetObjectData" info context))

(cl:defun on-deserialization (obj! sender)
  "Summary: Implements the System.Runtime.Serialization.ISerializable interface and raises the deserialization event when the deserialization is complete.
Parameters:
  - sender (System.Object): The source of the deserialization event.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "OnDeserialization" sender))

(cl:defun remove (obj! key)
  "Summary: Removes the value with the specified key from the System.Collections.Generic.Dictionary`2.
Returns: if the element is successfully found and removed; otherwise, . This method returns if key is not found in the System.Collections.Generic.Dictionary`2.
Parameters:
  - key (TKey): The key of the element to remove.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "Remove" key))

;; Note: System.Collections.Generic.Dictionary`2.Remove also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   Remove(TKey, out TValue&) -> Boolean

(cl:defun trim-excess (obj! cl:&optional (capacity cl:nil supplied-capacity))
  "Master wrapper for System.Collections.Generic.Dictionary`2.TrimExcess overloads. Dispatches at runtime.

TrimExcess() -> Void
  Summary: Sets the capacity of this dictionary to what it would be if it had been originally initialized with all its entries.

TrimExcess(Int32) -> Void
  Summary: Sets the capacity of this dictionary to hold up a specified number of entries without any further expansion of its backing storage.
  Parameters:
    - capacity (System.Int32): The new capacity.
"
  (cl:cond
    ((cl:and supplied-capacity (cl:numberp capacity))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "TrimExcess" capacity))
    ((cl:and (cl:not supplied-capacity))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "TrimExcess"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-GENERIC-DICTIONARY-2"
                    :class-name <type-str>
                    :method-name "TrimExcess"
                    :supplied-args (cl:append (cl:when supplied-capacity (cl:list :capacity capacity)))))))

(cl:defun try-add (obj! key value)
  "Summary: Attempts to add the specified key and value to the dictionary.
Returns: if the key/value pair was added to the dictionary successfully; otherwise, .
Parameters:
  - key (TKey): The key of the element to add.
  - value (TValue): The value of the element to add. It can be .
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.Dictionary`2") obj!) "TryAdd" key value))

;; The following C# System.Collections.Generic.Dictionary`2.TryGetAlternateLookup overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   TryGetAlternateLookup(out AlternateLookup) -> Boolean

;; The following C# System.Collections.Generic.Dictionary`2.TryGetValue overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   TryGetValue(TKey, out TValue&) -> Boolean

