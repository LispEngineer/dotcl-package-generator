;;; Generated automatically. Do not edit.
;;; Class: System.Collections.Specialized.NameValueCollection
;;; Generator Version: 52
;;; Creation Date: 2026-07-19T15:32:24Z
;;; Options: --export-interfaces --export-object --export-parents

(cl:in-package :system-collections-specialized-name-value-collection)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Collections.Specialized.NameValueCollection"))
(cl:defconstant <type-str> "System.Collections.Specialized.NameValueCollection")
(cl:defconstant <creation> "2026-07-19T15:32:24Z")
(cl:defconstant <version> 52)

(cl:defun new (cl:&optional (col cl:nil supplied-col) (comparer cl:nil supplied-comparer) (comparer2 cl:nil supplied-comparer2))
  "Master wrapper for System.Collections.Specialized.NameValueCollection constructor overloads. Dispatches at runtime.

new()
  Summary: Initializes a new instance of the System.Collections.Specialized.NameValueCollection class that is empty, has the default initial capacity and uses the default case-insensitive hash code provider and the default case-insensitive comparer.

new(NameValueCollection)
  Summary: Copies the entries from the specified System.Collections.Specialized.NameValueCollection to a new System.Collections.Specialized.NameValueCollection with the same initial capacity as the number of entries copied and using the same hash code provider and the same comparer as the source collection.
  Parameters:
    - col (System.Collections.Specialized.NameValueCollection): The System.Collections.Specialized.NameValueCollection to copy to the new System.Collections.Specialized.NameValueCollection instance.

new(Int32)
  Summary: Initializes a new instance of the System.Collections.Specialized.NameValueCollection class that is empty, has the specified initial capacity and uses the default case-insensitive hash code provider and the default case-insensitive comparer.
  Parameters:
    - capacity (System.Int32): The initial number of entries that the System.Collections.Specialized.NameValueCollection can contain.

new(IEqualityComparer)
  Summary: Initializes a new instance of the System.Collections.Specialized.NameValueCollection class that is empty, has the default initial capacity, and uses the specified System.Collections.IEqualityComparer object.
  Parameters:
    - equality-comparer (System.Collections.IEqualityComparer): The System.Collections.IEqualityComparer object to use to determine whether two keys are equal and to generate hash codes for the keys in the collection.

new(IHashCodeProvider, IComparer)
  Summary: Initializes a new instance of the System.Collections.Specialized.NameValueCollection class that is empty, has the default initial capacity and uses the specified hash code provider and the specified comparer.
  Parameters:
    - hash-provider (System.Collections.IHashCodeProvider): The System.Collections.IHashCodeProvider that will supply the hash codes for all keys in the System.Collections.Specialized.NameValueCollection.
    - comparer (System.Collections.IComparer): The System.Collections.IComparer to use to determine whether two keys are equal.

new(Int32, IEqualityComparer)
  Summary: Initializes a new instance of the System.Collections.Specialized.NameValueCollection class that is empty, has the specified initial capacity, and uses the specified System.Collections.IEqualityComparer object.
  Parameters:
    - capacity (System.Int32): The initial number of entries that the System.Collections.Specialized.NameValueCollection object can contain.
    - equality-comparer (System.Collections.IEqualityComparer): The System.Collections.IEqualityComparer object to use to determine whether two keys are equal and to generate hash codes for the keys in the collection.

new(Int32, NameValueCollection)
  Summary: Copies the entries from the specified System.Collections.Specialized.NameValueCollection to a new System.Collections.Specialized.NameValueCollection with the specified initial capacity or the same initial capacity as the number of entries copied, whichever is greater, and using the default case-insensitive hash code provider and the default case-insensitive comparer.
  Parameters:
    - capacity (System.Int32): The initial number of entries that the System.Collections.Specialized.NameValueCollection can contain.
    - col (System.Collections.Specialized.NameValueCollection): The System.Collections.Specialized.NameValueCollection to copy to the new System.Collections.Specialized.NameValueCollection instance.

new(SerializationInfo, StreamingContext)
  Summary: Initializes a new instance of the System.Collections.Specialized.NameValueCollection class that is serializable and uses the specified System.Runtime.Serialization.SerializationInfo and System.Runtime.Serialization.StreamingContext.
  Parameters:
    - info (System.Runtime.Serialization.SerializationInfo): A System.Runtime.Serialization.SerializationInfo object that contains the information required to serialize the new System.Collections.Specialized.NameValueCollection instance.
    - context (System.Runtime.Serialization.StreamingContext): A System.Runtime.Serialization.StreamingContext object that contains the source and destination of the serialized stream associated with the new System.Collections.Specialized.NameValueCollection instance.

new(Int32, IHashCodeProvider, IComparer)
  Summary: Initializes a new instance of the System.Collections.Specialized.NameValueCollection class that is empty, has the specified initial capacity and uses the specified hash code provider and the specified comparer.
  Parameters:
    - capacity (System.Int32): The initial number of entries that the System.Collections.Specialized.NameValueCollection can contain.
    - hash-provider (System.Collections.IHashCodeProvider): The System.Collections.IHashCodeProvider that will supply the hash codes for all keys in the System.Collections.Specialized.NameValueCollection.
    - comparer (System.Collections.IComparer): The System.Collections.IComparer to use to determine whether two keys are equal.
"
  (cl:cond
    ((cl:and supplied-col (cl:numberp col) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.IHashCodeProvider")) supplied-comparer2 (cl:or (cl:null comparer2) (dotnet:is-instance-of comparer2 "System.Collections.IComparer")))
     (dotnet:new <type-str> col comparer comparer2))
    ((cl:and supplied-col (cl:or (cl:null col) (dotnet:is-instance-of col "System.Collections.IHashCodeProvider")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.IComparer")) (cl:not supplied-comparer2))
     (dotnet:new <type-str> col comparer))
    ((cl:and supplied-col (cl:numberp col) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.IEqualityComparer")) (cl:not supplied-comparer2))
     (dotnet:new <type-str> col comparer))
    ((cl:and supplied-col (cl:numberp col) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Specialized.NameValueCollection")) (cl:not supplied-comparer2))
     (dotnet:new <type-str> col comparer))
    ((cl:and supplied-col (cl:or (cl:null col) (dotnet:is-instance-of col "System.Runtime.Serialization.SerializationInfo")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Runtime.Serialization.StreamingContext")) (cl:not supplied-comparer2))
     (dotnet:new <type-str> col comparer))
    ((cl:and supplied-col (cl:or (cl:null col) (dotnet:is-instance-of col "System.Collections.Specialized.NameValueCollection")) (cl:not supplied-comparer) (cl:not supplied-comparer2))
     (dotnet:new <type-str> col))
    ((cl:and supplied-col (cl:numberp col) (cl:not supplied-comparer) (cl:not supplied-comparer2))
     (dotnet:new <type-str> col))
    ((cl:and supplied-col (cl:or (cl:null col) (dotnet:is-instance-of col "System.Collections.IEqualityComparer")) (cl:not supplied-comparer) (cl:not supplied-comparer2))
     (dotnet:new <type-str> col))
    ((cl:and (cl:not supplied-col) (cl:not supplied-comparer) (cl:not supplied-comparer2))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-SPECIALIZED-NAME-VALUE-COLLECTION"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-col (cl:list :col col)) (cl:when supplied-comparer (cl:list :comparer comparer)) (cl:when supplied-comparer2 (cl:list :comparer2 comparer2)))))))

(cl:defun all-keys (obj!)
  "Gets all the keys in the System.Collections.Specialized.NameValueCollection."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameValueCollection") obj!) "get_AllKeys"))

;; Note: System.Collections.Specialized.NameValueCollection's indexer "Item" has multiple overloaded signatures,
;; which are not yet supported:
;;   Item[String] -> String
;;   Item[Int32] -> String

(cl:defun add (obj! c cl:&optional (value cl:nil supplied-value))
  "Master wrapper for System.Collections.Specialized.NameValueCollection.Add overloads. Dispatches at runtime.

Add(NameValueCollection) -> Void
  Summary: Copies the entries in the specified System.Collections.Specialized.NameValueCollection to the current System.Collections.Specialized.NameValueCollection.
  Parameters:
    - c (System.Collections.Specialized.NameValueCollection): The System.Collections.Specialized.NameValueCollection to copy to the current System.Collections.Specialized.NameValueCollection.

Add(String, String) -> Void
  Summary: Adds an entry with the specified name and value to the System.Collections.Specialized.NameValueCollection.
  Parameters:
    - name (System.String): The System.String key of the entry to add. The key can be .
    - value (System.String): The System.String value of the entry to add. The value can be .
"
  (cl:cond
    ((cl:and (cl:stringp c) supplied-value (cl:stringp value))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameValueCollection") obj!) "Add" c value))
    ((cl:and (cl:or (cl:null c) (dotnet:is-instance-of c "System.Collections.Specialized.NameValueCollection")) (cl:not supplied-value))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameValueCollection") obj!) "Add" c))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-SPECIALIZED-NAME-VALUE-COLLECTION"
                    :class-name <type-str>
                    :method-name "Add"
                    :supplied-args (cl:append (cl:list :c c) (cl:when supplied-value (cl:list :value value)))))))

(cl:defun clear (obj!)
  "Summary: Invalidates the cached arrays and removes all entries from the System.Collections.Specialized.NameValueCollection.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameValueCollection") obj!) "Clear"))

(cl:defun copy-to (obj! dest index)
  "Summary: Copies the entire System.Collections.Specialized.NameValueCollection to a compatible one-dimensional System.Array, starting at the specified index of the target array.
Parameters:
  - dest (System.Array): The one-dimensional System.Array that is the destination of the elements copied from System.Collections.Specialized.NameValueCollection. The System.Array must have zero-based indexing.
  - index (System.Int32): The zero-based index in dest at which copying begins.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameValueCollection") obj!) "CopyTo" dest index))

(cl:defun get (obj! name)
  "Master wrapper for System.Collections.Specialized.NameValueCollection.Get overloads. Dispatches at runtime.

Get(String) -> String
  Summary: Gets the values associated with the specified key from the System.Collections.Specialized.NameValueCollection combined into one comma-separated list.
  Returns: A System.String that contains a comma-separated list of the values associated with the specified key from the System.Collections.Specialized.NameValueCollection, if found; otherwise, .
  Parameters:
    - name (System.String): The System.String key of the entry that contains the values to get. The key can be .

Get(Int32) -> String
  Summary: Gets the values at the specified index of the System.Collections.Specialized.NameValueCollection combined into one comma-separated list.
  Returns: A System.String that contains a comma-separated list of the values at the specified index of the System.Collections.Specialized.NameValueCollection, if found; otherwise, .
  Parameters:
    - index (System.Int32): The zero-based index of the entry that contains the values to get from the collection.
"
  (cl:cond
    ((cl:and (cl:stringp name))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameValueCollection") obj!) "Get" name))
    ((cl:and (cl:numberp name))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameValueCollection") obj!) "Get" name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-SPECIALIZED-NAME-VALUE-COLLECTION"
                    :class-name <type-str>
                    :method-name "Get"
                    :supplied-args (cl:append (cl:list :name name))))))

(cl:defun get-key (obj! index)
  "Summary: Gets the key at the specified index of the System.Collections.Specialized.NameValueCollection.
Returns: A System.String that contains the key at the specified index of the System.Collections.Specialized.NameValueCollection, if found; otherwise, .
Parameters:
  - index (System.Int32): The zero-based index of the key to get from the collection.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameValueCollection") obj!) "GetKey" index))

(cl:defun get-values (obj! name)
  "Master wrapper for System.Collections.Specialized.NameValueCollection.GetValues overloads. Dispatches at runtime.

GetValues(String) -> String[]
  Summary: Gets the values associated with the specified key from the System.Collections.Specialized.NameValueCollection.
  Returns: A System.String array that contains the values associated with the specified key from the System.Collections.Specialized.NameValueCollection, if found; otherwise, .
  Parameters:
    - name (System.String): The System.String key of the entry that contains the values to get. The key can be .

GetValues(Int32) -> String[]
  Summary: Gets the values at the specified index of the System.Collections.Specialized.NameValueCollection.
  Returns: A System.String array that contains the values at the specified index of the System.Collections.Specialized.NameValueCollection, if found; otherwise, .
  Parameters:
    - index (System.Int32): The zero-based index of the entry that contains the values to get from the collection.
"
  (cl:cond
    ((cl:and (cl:stringp name))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameValueCollection") obj!) "GetValues" name))
    ((cl:and (cl:numberp name))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameValueCollection") obj!) "GetValues" name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-SPECIALIZED-NAME-VALUE-COLLECTION"
                    :class-name <type-str>
                    :method-name "GetValues"
                    :supplied-args (cl:append (cl:list :name name))))))

(cl:defun has-keys (obj!)
  "Summary: Gets a value indicating whether the System.Collections.Specialized.NameValueCollection contains keys that are not .
Returns: if the System.Collections.Specialized.NameValueCollection contains keys that are not ; otherwise, .
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameValueCollection") obj!) "HasKeys"))

(cl:defun invalidate-cached-arrays (obj!)
  "Summary: Resets the cached arrays of the collection to .
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameValueCollection") obj!) "InvalidateCachedArrays"))

(cl:defun remove (obj! name)
  "Summary: Removes the entries with the specified key from the System.Collections.Specialized.NameObjectCollectionBase instance.
Parameters:
  - name (System.String): The System.String key of the entry to remove. The key can be .
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameValueCollection") obj!) "Remove" name))

(cl:defun set (obj! name value)
  "Summary: Sets the value of an entry in the System.Collections.Specialized.NameValueCollection.
Parameters:
  - name (System.String): The System.String key of the entry to add the new value to. The key can be .
  - value (System.String): The System.Object that represents the new value to add to the specified entry. The value can be .
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Specialized.NameValueCollection") obj!) "Set" name value))

