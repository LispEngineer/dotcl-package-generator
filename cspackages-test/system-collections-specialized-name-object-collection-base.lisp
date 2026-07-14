;;; Generated automatically. Do not edit.
;;; Class: System.Collections.Specialized.NameObjectCollectionBase
;;; Generator Version: 48
;;; Creation Date: 2026-07-14T16:26:13Z

(cl:in-package :system-collections-specialized-name-object-collection-base)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Collections.Specialized.NameObjectCollectionBase"))
(cl:defconstant <type-str> "System.Collections.Specialized.NameObjectCollectionBase")
(cl:defconstant <creation> "2026-07-14T16:26:13Z")
(cl:defconstant <version> 48)

(cl:defun new (cl:&optional (equality-comparer cl:nil supplied-equality-comparer) (equality-comparer2 cl:nil supplied-equality-comparer2) (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Collections.Specialized.NameObjectCollectionBase constructor overloads. Dispatches at runtime.

new()
  Summary: Initializes a new instance of the System.Collections.Specialized.NameObjectCollectionBase class that is empty.

new(IEqualityComparer)
  Summary: Initializes a new instance of the System.Collections.Specialized.NameObjectCollectionBase class that is empty, has the default initial capacity, and uses the specified System.Collections.IEqualityComparer object.
  Parameters:
    - equality-comparer (System.Collections.IEqualityComparer): The System.Collections.IEqualityComparer object to use to determine whether two keys are equal and to generate hash codes for the keys in the collection.

new(Int32)
  Summary: Initializes a new instance of the System.Collections.Specialized.NameObjectCollectionBase class that is empty, has the specified initial capacity, and uses the default hash code provider and the default comparer.
  Parameters:
    - capacity (System.Int32): The approximate number of entries that the System.Collections.Specialized.NameObjectCollectionBase instance can initially contain.

new(Int32, IEqualityComparer)
  Summary: Initializes a new instance of the System.Collections.Specialized.NameObjectCollectionBase class that is empty, has the specified initial capacity, and uses the specified System.Collections.IEqualityComparer object.
  Parameters:
    - capacity (System.Int32): The approximate number of entries that the System.Collections.Specialized.NameObjectCollectionBase object can initially contain.
    - equality-comparer (System.Collections.IEqualityComparer): The System.Collections.IEqualityComparer object to use to determine whether two keys are equal and to generate hash codes for the keys in the collection.

new(IHashCodeProvider, IComparer)
  Summary: Initializes a new instance of the System.Collections.Specialized.NameObjectCollectionBase class that is empty, has the default initial capacity, and uses the specified hash code provider and the specified comparer.
  Parameters:
    - hash-provider (System.Collections.IHashCodeProvider): The System.Collections.IHashCodeProvider that will supply the hash codes for all keys in the System.Collections.Specialized.NameObjectCollectionBase instance.
    - comparer (System.Collections.IComparer): The System.Collections.IComparer to use to determine whether two keys are equal.

new(SerializationInfo, StreamingContext)
  Summary: Initializes a new instance of the System.Collections.Specialized.NameObjectCollectionBase class that is serializable and uses the specified System.Runtime.Serialization.SerializationInfo and System.Runtime.Serialization.StreamingContext.
  Parameters:
    - info (System.Runtime.Serialization.SerializationInfo): A System.Runtime.Serialization.SerializationInfo object that contains the information required to serialize the new System.Collections.Specialized.NameObjectCollectionBase instance.
    - context (System.Runtime.Serialization.StreamingContext): A System.Runtime.Serialization.StreamingContext object that contains the source and destination of the serialized stream associated with the new System.Collections.Specialized.NameObjectCollectionBase instance.

new(Int32, IHashCodeProvider, IComparer)
  Summary: Initializes a new instance of the System.Collections.Specialized.NameObjectCollectionBase class that is empty, has the specified initial capacity and uses the specified hash code provider and the specified comparer.
  Parameters:
    - capacity (System.Int32): The approximate number of entries that the System.Collections.Specialized.NameObjectCollectionBase instance can initially contain.
    - hash-provider (System.Collections.IHashCodeProvider): The System.Collections.IHashCodeProvider that will supply the hash codes for all keys in the System.Collections.Specialized.NameObjectCollectionBase instance.
    - comparer (System.Collections.IComparer): The System.Collections.IComparer to use to determine whether two keys are equal.
"
  (cl:cond
    ((cl:and supplied-equality-comparer (cl:numberp equality-comparer) supplied-equality-comparer2 (cl:or (cl:null equality-comparer2) (dotnet:object-type equality-comparer2)) supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)))
     (dotnet:new <type-str> equality-comparer equality-comparer2 comparer))
    ((cl:and supplied-equality-comparer (cl:numberp equality-comparer) supplied-equality-comparer2 (cl:or (cl:null equality-comparer2) (dotnet:object-type equality-comparer2)) (cl:not supplied-comparer))
     (dotnet:new <type-str> equality-comparer equality-comparer2))
    ((cl:and supplied-equality-comparer (cl:or (cl:null equality-comparer) (dotnet:object-type equality-comparer)) supplied-equality-comparer2 (cl:or (cl:null equality-comparer2) (dotnet:object-type equality-comparer2)) (cl:not supplied-comparer))
     (dotnet:new <type-str> equality-comparer equality-comparer2))
    ((cl:and supplied-equality-comparer (cl:or (cl:null equality-comparer) (dotnet:object-type equality-comparer)) supplied-equality-comparer2 (cl:or (cl:null equality-comparer2) (dotnet:object-type equality-comparer2)) (cl:not supplied-comparer))
     (dotnet:new <type-str> equality-comparer equality-comparer2))
    ((cl:and supplied-equality-comparer (cl:or (cl:null equality-comparer) (dotnet:object-type equality-comparer)) (cl:not supplied-equality-comparer2) (cl:not supplied-comparer))
     (dotnet:new <type-str> equality-comparer))
    ((cl:and supplied-equality-comparer (cl:numberp equality-comparer) (cl:not supplied-equality-comparer2) (cl:not supplied-comparer))
     (dotnet:new <type-str> equality-comparer))
    ((cl:and (cl:not supplied-equality-comparer) (cl:not supplied-equality-comparer2) (cl:not supplied-comparer))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-SPECIALIZED-NAME-OBJECT-COLLECTION-BASE"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-equality-comparer (cl:list :equality-comparer equality-comparer)) (cl:when supplied-equality-comparer2 (cl:list :equality-comparer2 equality-comparer2)) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun count (obj!)
  "Gets the number of key/value pairs contained in the System.Collections.Specialized.NameObjectCollectionBase instance."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "get_Count"))

(cl:defun read-only? (obj!)
  "Gets or sets a value indicating whether the System.Collections.Specialized.NameObjectCollectionBase instance is read-only."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "get_IsReadOnly"))

(cl:defun (cl:setf read-only?) (new-value obj!)
  "Gets or sets a value indicating whether the System.Collections.Specialized.NameObjectCollectionBase instance is read-only."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "set_IsReadOnly" new-value))

(cl:defun keys (obj!)
  "Gets a System.Collections.Specialized.NameObjectCollectionBase.KeysCollection instance that contains all the keys in the System.Collections.Specialized.NameObjectCollectionBase instance."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "get_Keys"))

(cl:defun base-add (obj! name value)
  "Summary: Adds an entry with the specified key and value into the System.Collections.Specialized.NameObjectCollectionBase instance.
Parameters:
  - name (System.String): The System.String key of the entry to add. The key can be .
  - value (System.Object): The System.Object value of the entry to add. The value can be .
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "BaseAdd" name value))

(cl:defun base-clear (obj!)
  "Summary: Removes all entries from the System.Collections.Specialized.NameObjectCollectionBase instance.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "BaseClear"))

(cl:defun base-get (obj! name)
  "Master wrapper for System.Collections.Specialized.NameObjectCollectionBase.BaseGet overloads. Dispatches at runtime.

BaseGet(String) -> Object
  Summary: Gets the value of the first entry with the specified key from the System.Collections.Specialized.NameObjectCollectionBase instance.
  Returns: An System.Object that represents the value of the first entry with the specified key, if found; otherwise, .
  Parameters:
    - name (System.String): The System.String key of the entry to get. The key can be .

BaseGet(Int32) -> Object
  Summary: Gets the value of the entry at the specified index of the System.Collections.Specialized.NameObjectCollectionBase instance.
  Returns: An System.Object that represents the value of the entry at the specified index.
  Parameters:
    - index (System.Int32): The zero-based index of the value to get.
"
  (cl:cond
    ((cl:and (cl:stringp name))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "BaseGet" name))
    ((cl:and (cl:numberp name))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "BaseGet" name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-SPECIALIZED-NAME-OBJECT-COLLECTION-BASE"
                    :class-name <type-str>
                    :method-name "BaseGet"
                    :supplied-args (cl:append (cl:list :name name))))))

(cl:defun base-get-all-keys (obj!)
  "Summary: Returns a System.String array that contains all the keys in the System.Collections.Specialized.NameObjectCollectionBase instance.
Returns: A System.String array that contains all the keys in the System.Collections.Specialized.NameObjectCollectionBase instance.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "BaseGetAllKeys"))

(cl:defun base-get-all-values (obj! cl:&optional (type cl:nil supplied-type))
  "Master wrapper for System.Collections.Specialized.NameObjectCollectionBase.BaseGetAllValues overloads. Dispatches at runtime.

BaseGetAllValues() -> Object[]
  Summary: Returns an System.Object array that contains all the values in the System.Collections.Specialized.NameObjectCollectionBase instance.
  Returns: An System.Object array that contains all the values in the System.Collections.Specialized.NameObjectCollectionBase instance.

BaseGetAllValues(Type) -> Object[]
  Summary: Returns an array of the specified type that contains all the values in the System.Collections.Specialized.NameObjectCollectionBase instance.
  Returns: An array of the specified type that contains all the values in the System.Collections.Specialized.NameObjectCollectionBase instance.
  Parameters:
    - type (System.Type): A System.Type that represents the type of array to return.
"
  (cl:cond
    ((cl:and supplied-type (cl:or (cl:null type) (dotnet:object-type type)))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "BaseGetAllValues" type))
    ((cl:and (cl:not supplied-type))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "BaseGetAllValues"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-SPECIALIZED-NAME-OBJECT-COLLECTION-BASE"
                    :class-name <type-str>
                    :method-name "BaseGetAllValues"
                    :supplied-args (cl:append (cl:when supplied-type (cl:list :type type)))))))

(cl:defun base-get-key (obj! index)
  "Summary: Gets the key of the entry at the specified index of the System.Collections.Specialized.NameObjectCollectionBase instance.
Returns: A System.String that represents the key of the entry at the specified index.
Parameters:
  - index (System.Int32): The zero-based index of the key to get.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "BaseGetKey" index))

(cl:defun base-has-keys (obj!)
  "Summary: Gets a value indicating whether the System.Collections.Specialized.NameObjectCollectionBase instance contains entries whose keys are not .
Returns: if the System.Collections.Specialized.NameObjectCollectionBase instance contains entries whose keys are not ; otherwise, .
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "BaseHasKeys"))

(cl:defun base-remove (obj! name)
  "Summary: Removes the entries with the specified key from the System.Collections.Specialized.NameObjectCollectionBase instance.
Parameters:
  - name (System.String): The System.String key of the entries to remove. The key can be .
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "BaseRemove" name))

(cl:defun base-remove-at (obj! index)
  "Summary: Removes the entry at the specified index of the System.Collections.Specialized.NameObjectCollectionBase instance.
Parameters:
  - index (System.Int32): The zero-based index of the entry to remove.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "BaseRemoveAt" index))

(cl:defun base-set (obj! name value)
  "Master wrapper for System.Collections.Specialized.NameObjectCollectionBase.BaseSet overloads. Dispatches at runtime.

BaseSet(String, Object) -> Void
  Summary: Sets the value of the first entry with the specified key in the System.Collections.Specialized.NameObjectCollectionBase instance, if found; otherwise, adds an entry with the specified key and value into the System.Collections.Specialized.NameObjectCollectionBase instance.
  Parameters:
    - name (System.String): The System.String key of the entry to set. The key can be .
    - value (System.Object): The System.Object that represents the new value of the entry to set. The value can be .

BaseSet(Int32, Object) -> Void
  Summary: Sets the value of the entry at the specified index of the System.Collections.Specialized.NameObjectCollectionBase instance.
  Parameters:
    - index (System.Int32): The zero-based index of the entry to set.
    - value (System.Object): The System.Object that represents the new value of the entry to set. The value can be .
"
  (cl:cond
    ((cl:and (cl:stringp name) (cl:or (cl:null value) (dotnet:object-type value)))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "BaseSet" name value))
    ((cl:and (cl:numberp name) (cl:or (cl:null value) (dotnet:object-type value)))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "BaseSet" name value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-SPECIALIZED-NAME-OBJECT-COLLECTION-BASE"
                    :class-name <type-str>
                    :method-name "BaseSet"
                    :supplied-args (cl:append (cl:list :name name) (cl:list :value value))))))

(cl:defun get-enumerator (obj!)
  "Summary: Returns an enumerator that iterates through the System.Collections.Specialized.NameObjectCollectionBase.
Returns: An System.Collections.IEnumerator for the System.Collections.Specialized.NameObjectCollectionBase instance.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "GetEnumerator"))

(cl:defun get-object-data (obj! info context)
  "Summary: Implements the System.Runtime.Serialization.ISerializable interface and returns the data needed to serialize the System.Collections.Specialized.NameObjectCollectionBase instance.
Parameters:
  - info (System.Runtime.Serialization.SerializationInfo): A System.Runtime.Serialization.SerializationInfo object that contains the information required to serialize the System.Collections.Specialized.NameObjectCollectionBase instance.
  - context (System.Runtime.Serialization.StreamingContext): A System.Runtime.Serialization.StreamingContext object that contains the source and destination of the serialized stream associated with the System.Collections.Specialized.NameObjectCollectionBase instance.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "GetObjectData" info context))

(cl:defun on-deserialization (obj! sender)
  "Summary: Implements the System.Runtime.Serialization.ISerializable interface and raises the deserialization event when the deserialization is complete.
Parameters:
  - sender (System.Object): The source of the deserialization event.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameObjectCollectionBase") obj!) "OnDeserialization" sender))

