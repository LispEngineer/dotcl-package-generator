;;; Generated automatically. Do not edit.
;;; Class: System.Collections.Hashtable
;;; Generator Version: 33
;;; Creation Date: 2026-07-05T13:49:48Z

(cl:in-package :system-collections-hashtable)

(cl:defconstant <type> (dotnet:resolve-type "System.Collections.Hashtable"))
(cl:defconstant <type-str> "System.Collections.Hashtable")
(cl:defconstant <creation> "2026-07-05T13:49:48Z")
(cl:defconstant <version> 33)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Collections.Hashtable")))

(cl:defun new (cl:&optional (capacity cl:nil supplied-capacity) (load-factor cl:nil supplied-load-factor) (equality-comparer cl:nil supplied-equality-comparer) (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Collections.Hashtable constructor overloads. Dispatches at runtime.

new()
  Summary: Initializes a new, empty instance of the System.Collections.Hashtable class using the default initial capacity, load factor, hash code provider, and comparer.

new(Int32)
  Summary: Initializes a new, empty instance of the System.Collections.Hashtable class using the specified initial capacity, and the default load factor, hash code provider, and comparer.
  Parameters:
    - capacity (System.Int32): The approximate number of elements that the System.Collections.Hashtable object can initially contain.

new(IEqualityComparer)
  Summary: Initializes a new, empty instance of the System.Collections.Hashtable class using the default initial capacity and load factor, and the specified System.Collections.IEqualityComparer object.
  Parameters:
    - equality-comparer (System.Collections.IEqualityComparer): The System.Collections.IEqualityComparer object that defines the hash code provider and the comparer to use with the System.Collections.Hashtable object. -or- to use the default hash code provider and the default comparer. The default hash code provider is each key's implementation of System.Object.GetHashCode and the default comparer is each key's implementation of System.Object.Equals(System.Object).

new(IDictionary)
  Summary: Initializes a new instance of the System.Collections.Hashtable class by copying the elements from the specified dictionary to the new System.Collections.Hashtable object. The new System.Collections.Hashtable object has an initial capacity equal to the number of elements copied, and uses the default load factor, hash code provider, and comparer.
  Parameters:
    - d (System.Collections.IDictionary): The System.Collections.IDictionary object to copy to a new System.Collections.Hashtable object.

new(Int32, Single)
  Summary: Initializes a new, empty instance of the System.Collections.Hashtable class using the specified initial capacity and load factor, and the default hash code provider and comparer.
  Parameters:
    - capacity (System.Int32): The approximate number of elements that the System.Collections.Hashtable object can initially contain.
    - load-factor (System.Single): A number in the range from 0.1 through 1.0 that is multiplied by the default value that provides the best performance. The result is the maximum ratio of elements to buckets.

new(IHashCodeProvider, IComparer)
  Summary: Initializes a new, empty instance of the System.Collections.Hashtable class using the default initial capacity and load factor, and the specified hash code provider and comparer.
  Parameters:
    - hcp (System.Collections.IHashCodeProvider): The System.Collections.IHashCodeProvider object that supplies the hash codes for all keys in the System.Collections.Hashtable object. -or- to use the default hash code provider, which is each key's implementation of System.Object.GetHashCode.
    - comparer (System.Collections.IComparer): The System.Collections.IComparer object to use to determine whether two keys are equal. -or- to use the default comparer, which is each key's implementation of System.Object.Equals(System.Object).

new(Int32, IEqualityComparer)
  Summary: Initializes a new, empty instance of the System.Collections.Hashtable class using the specified initial capacity and System.Collections.IEqualityComparer, and the default load factor.
  Parameters:
    - capacity (System.Int32): The approximate number of elements that the System.Collections.Hashtable object can initially contain.
    - equality-comparer (System.Collections.IEqualityComparer): The System.Collections.IEqualityComparer object that defines the hash code provider and the comparer to use with the System.Collections.Hashtable. -or- to use the default hash code provider and the default comparer. The default hash code provider is each key's implementation of System.Object.GetHashCode and the default comparer is each key's implementation of System.Object.Equals(System.Object).

new(IDictionary, Single)
  Summary: Initializes a new instance of the System.Collections.Hashtable class by copying the elements from the specified dictionary to the new System.Collections.Hashtable object. The new System.Collections.Hashtable object has an initial capacity equal to the number of elements copied, and uses the specified load factor, and the default hash code provider and comparer.
  Parameters:
    - d (System.Collections.IDictionary): The System.Collections.IDictionary object to copy to a new System.Collections.Hashtable object.
    - load-factor (System.Single): A number in the range from 0.1 through 1.0 that is multiplied by the default value that provides the best performance. The result is the maximum ratio of elements to buckets.

new(IDictionary, IEqualityComparer)
  Summary: Initializes a new instance of the System.Collections.Hashtable class by copying the elements from the specified dictionary to a new System.Collections.Hashtable object. The new System.Collections.Hashtable object has an initial capacity equal to the number of elements copied, and uses the default load factor and the specified System.Collections.IEqualityComparer object.
  Parameters:
    - d (System.Collections.IDictionary): The System.Collections.IDictionary object to copy to a new System.Collections.Hashtable object.
    - equality-comparer (System.Collections.IEqualityComparer): The System.Collections.IEqualityComparer object that defines the hash code provider and the comparer to use with the System.Collections.Hashtable. -or- to use the default hash code provider and the default comparer. The default hash code provider is each key's implementation of System.Object.GetHashCode and the default comparer is each key's implementation of System.Object.Equals(System.Object).

new(SerializationInfo, StreamingContext)
  Summary: Initializes a new, empty instance of the System.Collections.Hashtable class that is serializable using the specified System.Runtime.Serialization.SerializationInfo and System.Runtime.Serialization.StreamingContext objects.
  Parameters:
    - info (System.Runtime.Serialization.SerializationInfo): A System.Runtime.Serialization.SerializationInfo object containing the information required to serialize the System.Collections.Hashtable object.
    - context (System.Runtime.Serialization.StreamingContext): A System.Runtime.Serialization.StreamingContext object containing the source and destination of the serialized stream associated with the System.Collections.Hashtable.

new(Int32, Single, IEqualityComparer)
  Summary: Initializes a new, empty instance of the System.Collections.Hashtable class using the specified initial capacity, load factor, and System.Collections.IEqualityComparer object.
  Parameters:
    - capacity (System.Int32): The approximate number of elements that the System.Collections.Hashtable object can initially contain.
    - load-factor (System.Single): A number in the range from 0.1 through 1.0 that is multiplied by the default value that provides the best performance. The result is the maximum ratio of elements to buckets.
    - equality-comparer (System.Collections.IEqualityComparer): The System.Collections.IEqualityComparer object that defines the hash code provider and the comparer to use with the System.Collections.Hashtable. -or- to use the default hash code provider and the default comparer. The default hash code provider is each key's implementation of System.Object.GetHashCode and the default comparer is each key's implementation of System.Object.Equals(System.Object).

new(Int32, IHashCodeProvider, IComparer)
  Summary: Initializes a new, empty instance of the System.Collections.Hashtable class using the specified initial capacity, hash code provider, comparer, and the default load factor.
  Parameters:
    - capacity (System.Int32): The approximate number of elements that the System.Collections.Hashtable object can initially contain.
    - hcp (System.Collections.IHashCodeProvider): The System.Collections.IHashCodeProvider object that supplies the hash codes for all keys in the System.Collections.Hashtable. -or- to use the default hash code provider, which is each key's implementation of System.Object.GetHashCode.
    - comparer (System.Collections.IComparer): The System.Collections.IComparer object to use to determine whether two keys are equal. -or- to use the default comparer, which is each key's implementation of System.Object.Equals(System.Object).

new(IDictionary, IHashCodeProvider, IComparer)
  Summary: Initializes a new instance of the System.Collections.Hashtable class by copying the elements from the specified dictionary to the new System.Collections.Hashtable object. The new System.Collections.Hashtable object has an initial capacity equal to the number of elements copied, and uses the default load factor, and the specified hash code provider and comparer. This API is obsolete. For an alternative, see System.Collections.Hashtable.#ctor(System.Collections.IDictionary,System.Collections.IEqualityComparer).
  Parameters:
    - d (System.Collections.IDictionary): The System.Collections.IDictionary object to copy to a new System.Collections.Hashtable object.
    - hcp (System.Collections.IHashCodeProvider): The System.Collections.IHashCodeProvider object that supplies the hash codes for all keys in the System.Collections.Hashtable. -or- to use the default hash code provider, which is each key's implementation of System.Object.GetHashCode.
    - comparer (System.Collections.IComparer): The System.Collections.IComparer object to use to determine whether two keys are equal. -or- to use the default comparer, which is each key's implementation of System.Object.Equals(System.Object).

new(IDictionary, Single, IEqualityComparer)
  Summary: Initializes a new instance of the System.Collections.Hashtable class by copying the elements from the specified dictionary to the new System.Collections.Hashtable object. The new System.Collections.Hashtable object has an initial capacity equal to the number of elements copied, and uses the specified load factor and System.Collections.IEqualityComparer object.
  Parameters:
    - d (System.Collections.IDictionary): The System.Collections.IDictionary object to copy to a new System.Collections.Hashtable object.
    - load-factor (System.Single): A number in the range from 0.1 through 1.0 that is multiplied by the default value that provides the best performance. The result is the maximum ratio of elements to buckets.
    - equality-comparer (System.Collections.IEqualityComparer): The System.Collections.IEqualityComparer object that defines the hash code provider and the comparer to use with the System.Collections.Hashtable. -or- to use the default hash code provider and the default comparer. The default hash code provider is each key's implementation of System.Object.GetHashCode and the default comparer is each key's implementation of System.Object.Equals(System.Object).

new(Int32, Single, IHashCodeProvider, IComparer)
  Summary: Initializes a new, empty instance of the System.Collections.Hashtable class using the specified initial capacity, load factor, hash code provider, and comparer.
  Parameters:
    - capacity (System.Int32): The approximate number of elements that the System.Collections.Hashtable object can initially contain.
    - load-factor (System.Single): A number in the range from 0.1 through 1.0 that is multiplied by the default value that provides the best performance. The result is the maximum ratio of elements to buckets.
    - hcp (System.Collections.IHashCodeProvider): The System.Collections.IHashCodeProvider object that supplies the hash codes for all keys in the System.Collections.Hashtable. -or- to use the default hash code provider, which is each key's implementation of System.Object.GetHashCode.
    - comparer (System.Collections.IComparer): The System.Collections.IComparer object to use to determine whether two keys are equal. -or- to use the default comparer, which is each key's implementation of System.Object.Equals(System.Object).

new(IDictionary, Single, IHashCodeProvider, IComparer)
  Summary: Initializes a new instance of the System.Collections.Hashtable class by copying the elements from the specified dictionary to the new System.Collections.Hashtable object. The new System.Collections.Hashtable object has an initial capacity equal to the number of elements copied, and uses the specified load factor, hash code provider, and comparer.
  Parameters:
    - d (System.Collections.IDictionary): The System.Collections.IDictionary object to copy to a new System.Collections.Hashtable object.
    - load-factor (System.Single): A number in the range from 0.1 through 1.0 that is multiplied by the default value that provides the best performance. The result is the maximum ratio of elements to buckets.
    - hcp (System.Collections.IHashCodeProvider): The System.Collections.IHashCodeProvider object that supplies the hash codes for all keys in the System.Collections.Hashtable. -or- to use the default hash code provider, which is each key's implementation of System.Object.GetHashCode.
    - comparer (System.Collections.IComparer): The System.Collections.IComparer object to use to determine whether two keys are equal. -or- to use the default comparer, which is each key's implementation of System.Object.Equals(System.Object).
"
  (cl:cond
    ((cl:and supplied-capacity (cl:numberp capacity) supplied-load-factor (cl:numberp load-factor) supplied-equality-comparer (cl:or (cl:null equality-comparer) (dotnet:object-type equality-comparer)) supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)))
     (dotnet:new <type-str> capacity load-factor equality-comparer comparer))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)) supplied-load-factor (cl:numberp load-factor) supplied-equality-comparer (cl:or (cl:null equality-comparer) (dotnet:object-type equality-comparer)) supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)))
     (dotnet:new <type-str> capacity load-factor equality-comparer comparer))
    ((cl:and supplied-capacity (cl:numberp capacity) supplied-load-factor (cl:numberp load-factor) supplied-equality-comparer (cl:or (cl:null equality-comparer) (dotnet:object-type equality-comparer)) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity load-factor equality-comparer))
    ((cl:and supplied-capacity (cl:numberp capacity) supplied-load-factor (cl:or (cl:null load-factor) (dotnet:object-type load-factor)) supplied-equality-comparer (cl:or (cl:null equality-comparer) (dotnet:object-type equality-comparer)) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity load-factor equality-comparer))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)) supplied-load-factor (cl:or (cl:null load-factor) (dotnet:object-type load-factor)) supplied-equality-comparer (cl:or (cl:null equality-comparer) (dotnet:object-type equality-comparer)) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity load-factor equality-comparer))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)) supplied-load-factor (cl:numberp load-factor) supplied-equality-comparer (cl:or (cl:null equality-comparer) (dotnet:object-type equality-comparer)) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity load-factor equality-comparer))
    ((cl:and supplied-capacity (cl:numberp capacity) supplied-load-factor (cl:numberp load-factor) (cl:not supplied-equality-comparer) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity load-factor))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)) supplied-load-factor (cl:or (cl:null load-factor) (dotnet:object-type load-factor)) (cl:not supplied-equality-comparer) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity load-factor))
    ((cl:and supplied-capacity (cl:numberp capacity) supplied-load-factor (cl:or (cl:null load-factor) (dotnet:object-type load-factor)) (cl:not supplied-equality-comparer) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity load-factor))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)) supplied-load-factor (cl:numberp load-factor) (cl:not supplied-equality-comparer) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity load-factor))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)) supplied-load-factor (cl:or (cl:null load-factor) (dotnet:object-type load-factor)) (cl:not supplied-equality-comparer) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity load-factor))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)) supplied-load-factor (cl:or (cl:null load-factor) (dotnet:object-type load-factor)) (cl:not supplied-equality-comparer) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity load-factor))
    ((cl:and supplied-capacity (cl:numberp capacity) (cl:not supplied-load-factor) (cl:not supplied-equality-comparer) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)) (cl:not supplied-load-factor) (cl:not supplied-equality-comparer) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)) (cl:not supplied-load-factor) (cl:not supplied-equality-comparer) (cl:not supplied-comparer))
     (dotnet:new <type-str> capacity))
    ((cl:and (cl:not supplied-capacity) (cl:not supplied-load-factor) (cl:not supplied-equality-comparer) (cl:not supplied-comparer))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-HASHTABLE"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-capacity (cl:list :capacity capacity)) (cl:when supplied-load-factor (cl:list :load-factor load-factor)) (cl:when supplied-equality-comparer (cl:list :equality-comparer equality-comparer)) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun comparer (obj!)
  "Gets or sets the System.Collections.IComparer to use for the System.Collections.Hashtable."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "get_comparer"))

(cl:defun (cl:setf comparer) (new-value obj!)
  "Gets or sets the System.Collections.IComparer to use for the System.Collections.Hashtable."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "set_comparer" new-value))

(cl:defun count (obj!)
  "Gets the number of key/value pairs contained in the System.Collections.Hashtable."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "get_Count"))

(cl:defun equality-comparer (obj!)
  "Gets the System.Collections.IEqualityComparer to use for the System.Collections.Hashtable."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "get_EqualityComparer"))

(cl:defun hcp (obj!)
  "Gets or sets the object that can dispense hash codes."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "get_hcp"))

(cl:defun (cl:setf hcp) (new-value obj!)
  "Gets or sets the object that can dispense hash codes."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "set_hcp" new-value))

(cl:defun fixed-size? (obj!)
  "Gets a value indicating whether the System.Collections.Hashtable has a fixed size."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "get_IsFixedSize"))

(cl:defun read-only? (obj!)
  "Gets a value indicating whether the System.Collections.Hashtable is read-only."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "get_IsReadOnly"))

(cl:defun synchronized? (obj!)
  "Gets a value indicating whether access to the System.Collections.Hashtable is synchronized (thread safe)."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "get_IsSynchronized"))

(cl:defun item (obj! key)
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "get_Item" key))

(cl:defun (cl:setf item) (new-value obj! key)
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "set_Item" key new-value))

(cl:defun keys (obj!)
  "Gets an System.Collections.ICollection containing the keys in the System.Collections.Hashtable."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "get_Keys"))

(cl:defun sync-root (obj!)
  "Gets an object that can be used to synchronize access to the System.Collections.Hashtable."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "get_SyncRoot"))

(cl:defun values (obj!)
  "Gets an System.Collections.ICollection containing the values in the System.Collections.Hashtable."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "get_Values"))

(cl:defun add (obj! key value)
  "Summary: Adds an element with the specified key and value into the System.Collections.Hashtable.
Parameters:
  - key (System.Object): The key of the element to add.
  - value (System.Object): The value of the element to add. The value can be .
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "Add" key value))

(cl:defun clear (obj!)
  "Summary: Removes all elements from the System.Collections.Hashtable.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "Clear"))

(cl:defun clone (obj!)
  "Summary: Creates a shallow copy of the System.Collections.Hashtable.
Returns: A shallow copy of the System.Collections.Hashtable.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "Clone"))

(cl:defun contains (obj! key)
  "Summary: Determines whether the System.Collections.Hashtable contains a specific key.
Returns: if the System.Collections.Hashtable contains an element with the specified key; otherwise, .
Parameters:
  - key (System.Object): The key to locate in the System.Collections.Hashtable.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "Contains" key))

(cl:defun contains-key (obj! key)
  "Summary: Determines whether the System.Collections.Hashtable contains a specific key.
Returns: if the System.Collections.Hashtable contains an element with the specified key; otherwise, .
Parameters:
  - key (System.Object): The key to locate in the System.Collections.Hashtable.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "ContainsKey" key))

(cl:defun contains-value (obj! value)
  "Summary: Determines whether the System.Collections.Hashtable contains a specific value.
Returns: if the System.Collections.Hashtable contains an element with the specified value; otherwise, .
Parameters:
  - value (System.Object): The value to locate in the System.Collections.Hashtable. The value can be .
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "ContainsValue" value))

(cl:defun copy-to (obj! array array-index)
  "Summary: Copies the System.Collections.Hashtable elements to a one-dimensional System.Array instance at the specified index.
Parameters:
  - array (System.Array): The one-dimensional System.Array that is the destination of the System.Collections.DictionaryEntry objects copied from System.Collections.Hashtable. The System.Array must have zero-based indexing.
  - array-index (System.Int32): The zero-based index in array at which copying begins.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "CopyTo" array array-index))

(cl:defun get-enumerator (obj!)
  "Summary: Returns an System.Collections.IDictionaryEnumerator that iterates through the System.Collections.Hashtable.
Returns: An System.Collections.IDictionaryEnumerator for the System.Collections.Hashtable.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "GetEnumerator"))

(cl:defun get-hash (obj! key)
  "Summary: Returns the hash code for the specified key.
Returns: The hash code for key.
Parameters:
  - key (System.Object): The System.Object for which a hash code is to be returned.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "GetHash" key))

(cl:defun get-object-data (obj! info context)
  "Summary: Implements the System.Runtime.Serialization.ISerializable interface and returns the data needed to serialize the System.Collections.Hashtable.
Parameters:
  - info (System.Runtime.Serialization.SerializationInfo): A System.Runtime.Serialization.SerializationInfo object containing the information required to serialize the System.Collections.Hashtable.
  - context (System.Runtime.Serialization.StreamingContext): A System.Runtime.Serialization.StreamingContext object containing the source and destination of the serialized stream associated with the System.Collections.Hashtable.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "GetObjectData" info context))

(cl:defun key-equals (obj! item key)
  "Summary: Compares a specific System.Object with a specific key in the System.Collections.Hashtable.
Returns: if item and key are equal; otherwise, .
Parameters:
  - item (System.Object): The System.Object to compare with key.
  - key (System.Object): The key in the System.Collections.Hashtable to compare with item.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "KeyEquals" item key))

(cl:defun on-deserialization (obj! sender)
  "Summary: Implements the System.Runtime.Serialization.ISerializable interface and raises the deserialization event when the deserialization is complete.
Parameters:
  - sender (System.Object): The source of the deserialization event.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "OnDeserialization" sender))

(cl:defun remove (obj! key)
  "Summary: Removes the element with the specified key from the System.Collections.Hashtable.
Parameters:
  - key (System.Object): The key of the element to remove.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Hashtable") obj!) "Remove" key))

(cl:defun synchronized (table)
  "Summary: Returns a synchronized (thread-safe) wrapper for the System.Collections.Hashtable.
Returns: A synchronized (thread-safe) wrapper for the System.Collections.Hashtable.
Parameters:
  - table (System.Collections.Hashtable): The System.Collections.Hashtable to synchronize.
"
  (dotnet:static <type-str> "Synchronized" (cl:the (dotnet "System.Collections.Hashtable") table)))

