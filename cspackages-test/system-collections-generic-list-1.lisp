;;; Generated automatically. Do not edit.
;;; Class: System.Collections.Generic.List`1
;;; Generator Version: 29
;;; Creation Date: 2026-07-04T14:21:19Z

(cl:in-package :system-collections-generic-list-1)

(cl:defconstant <type> (dotnet:resolve-type "System.Collections.Generic.List`1"))
(cl:defconstant <type-str> "System.Collections.Generic.List`1")
(cl:defconstant <creation> "2026-07-04T14:21:19Z")
(cl:defconstant <version> 29)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Collections.Generic.List`1")))

(cl:defun new (cl:&optional (capacity cl:nil supplied-capacity))
  "Master wrapper for System.Collections.Generic.List`1 constructor overloads. Dispatches at runtime.

new()
  Summary: Initializes a new instance of the System.Collections.Generic.List`1 class that is empty and has the default initial capacity.

new(Int32)
  Summary: Initializes a new instance of the System.Collections.Generic.List`1 class that is empty and has the specified initial capacity.
  Parameters:
    - capacity (System.Int32): The number of elements that the new list can initially store.

new(IEnumerable)
  Summary: Initializes a new instance of the System.Collections.Generic.List`1 class that contains elements copied from the specified collection and has sufficient capacity to accommodate the number of elements copied.
  Parameters:
    - collection (System.Collections.Generic.IEnumerable`1[T]): The collection whose elements are copied to the new list.
"
  (cl:cond
    ((cl:and supplied-capacity (cl:numberp capacity))
     (dotnet:new <type-str> capacity))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:object-type capacity)))
     (dotnet:new <type-str> capacity))
    ((cl:and (cl:not supplied-capacity))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-GENERIC-LIST-1"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-capacity (cl:list :capacity capacity)))))))

(cl:defun capacity (obj!)
  "Gets or sets the total number of elements the internal data structure can hold without resizing."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "get_Capacity"))

(cl:defun (cl:setf capacity) (new-value obj!)
  "Gets or sets the total number of elements the internal data structure can hold without resizing."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "set_Capacity" new-value))

(cl:defun count (obj!)
  "Gets the number of elements contained in the System.Collections.Generic.List`1."
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "get_Count"))

(cl:defun item (obj! index)
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "get_Item" index))

(cl:defun (cl:setf item) (new-value obj! index)
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "set_Item" index new-value))

(cl:defun add (obj! item)
  "Summary: Adds an object to the end of the System.Collections.Generic.List`1.
Parameters:
  - item (T): The object to be added to the end of the System.Collections.Generic.List`1. The value can be for reference types.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "Add" item))

(cl:defun add-range (obj! collection)
  "Summary: Adds the elements of the specified collection to the end of the System.Collections.Generic.List`1.
Parameters:
  - collection (System.Collections.Generic.IEnumerable`1[T]): The collection whose elements should be added to the end of the System.Collections.Generic.List`1. The collection itself cannot be , but it can contain elements that are , if type T is a reference type.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "AddRange" collection))

(cl:defun as-read-only (obj!)
  "Summary: Returns a read-only System.Collections.ObjectModel.ReadOnlyCollection`1 wrapper for the current collection.
Returns: An object that acts as a read-only wrapper around the current System.Collections.Generic.List`1.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "AsReadOnly"))

(cl:defun binary-search (obj! item cl:&optional (comparer cl:nil supplied-comparer) (item2 cl:nil supplied-item2) (comparer2 cl:nil supplied-comparer2))
  "Master wrapper for System.Collections.Generic.List`1.BinarySearch overloads. Dispatches at runtime.

BinarySearch(T) -> Int32
  Summary: Searches the entire sorted System.Collections.Generic.List`1 for an element using the default comparer and returns the zero-based index of the element.
  Returns: The zero-based index of item in the sorted System.Collections.Generic.List`1, if item is found; otherwise, a negative number that is the bitwise complement of the index of the next element that is larger than item or, if there is no larger element, the bitwise complement of System.Collections.Generic.List`1.Count.
  Parameters:
    - item (T): The object to locate. The value can be for reference types.

BinarySearch(T, IComparer) -> Int32
  Summary: Searches the entire sorted System.Collections.Generic.List`1 for an element using the specified comparer and returns the zero-based index of the element.
  Returns: The zero-based index of item in the sorted System.Collections.Generic.List`1, if item is found; otherwise, a negative number that is the bitwise complement of the index of the next element that is larger than item or, if there is no larger element, the bitwise complement of System.Collections.Generic.List`1.Count.
  Parameters:
    - item (T): The object to locate. The value can be for reference types.
    - comparer (System.Collections.Generic.IComparer`1[T]): The System.Collections.Generic.IComparer`1 implementation to use when comparing elements. -or- to use the default comparer System.Collections.Generic.Comparer`1.Default.

BinarySearch(Int32, Int32, T, IComparer) -> Int32
  Summary: Searches a range of elements in the sorted System.Collections.Generic.List`1 for an element using the specified comparer and returns the zero-based index of the element.
  Returns: The zero-based index of item in the sorted System.Collections.Generic.List`1, if item is found; otherwise, a negative number that is the bitwise complement of the index of the next element that is larger than item or, if there is no larger element, the bitwise complement of System.Collections.Generic.List`1.Count.
  Parameters:
    - index (System.Int32): The zero-based starting index of the range to search.
    - count (System.Int32): The length of the range to search.
    - item (T): The object to locate. The value can be for reference types.
    - comparer (System.Collections.Generic.IComparer`1[T]): The System.Collections.Generic.IComparer`1 implementation to use when comparing elements, or to use the default comparer System.Collections.Generic.Comparer`1.Default.
"
  (cl:cond
    ((cl:and (cl:numberp item) supplied-comparer (cl:numberp comparer) supplied-item2 (cl:or (cl:null item2) (dotnet:object-type item2)) supplied-comparer2 (cl:or (cl:null comparer2) (dotnet:object-type comparer2)))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "BinarySearch" item comparer item2 comparer2))
    ((cl:and (cl:or (cl:null item) (dotnet:object-type item)) supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)) (cl:not supplied-item2) (cl:not supplied-comparer2))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "BinarySearch" item comparer))
    ((cl:and (cl:or (cl:null item) (dotnet:object-type item)) (cl:not supplied-comparer) (cl:not supplied-item2) (cl:not supplied-comparer2))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "BinarySearch" item))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-GENERIC-LIST-1"
                    :class-name <type-str>
                    :method-name "BinarySearch"
                    :supplied-args (cl:append (cl:list :item item) (cl:when supplied-comparer (cl:list :comparer comparer)) (cl:when supplied-item2 (cl:list :item2 item2)) (cl:when supplied-comparer2 (cl:list :comparer2 comparer2)))))))

(cl:defun clear (obj!)
  "Summary: Removes all elements from the System.Collections.Generic.List`1.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "Clear"))

(cl:defun contains (obj! item)
  "Summary: Determines whether an element is in the System.Collections.Generic.List`1.
Returns: if item is found in the System.Collections.Generic.List`1; otherwise, .
Parameters:
  - item (T): The object to locate in the System.Collections.Generic.List`1. The value can be for reference types.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "Contains" item))

(cl:defun convert-all (type obj! converter)
  "Summary: Converts the elements in the current System.Collections.Generic.List`1 to another type, and returns a list containing the converted elements.
Returns: A System.Collections.Generic.List`1 of the target type containing the converted elements from the current System.Collections.Generic.List`1.
Parameters:
  - converter (System.Converter`2[T, TOutput]): A System.Converter`2 delegate that converts each element from one type to another type.
"
  (dotnet:invoke-generic (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "ConvertAll" (cl:list type) converter))

(cl:defun copy-to (obj! array cl:&optional (array-index cl:nil supplied-array-index) (array-index2 cl:nil supplied-array-index2) (count cl:nil supplied-count))
  "Master wrapper for System.Collections.Generic.List`1.CopyTo overloads. Dispatches at runtime.

CopyTo(T[]) -> Void
  Summary: Copies the entire System.Collections.Generic.List`1 to a compatible one-dimensional array, starting at the beginning of the target array.
  Parameters:
    - array (T[]): The one-dimensional System.Array that is the destination of the elements copied from System.Collections.Generic.List`1. The System.Array must have zero-based indexing.

CopyTo(T[], Int32) -> Void
  Summary: Copies the entire System.Collections.Generic.List`1 to a compatible one-dimensional array, starting at the specified index of the target array.
  Parameters:
    - array (T[]): The one-dimensional System.Array that is the destination of the elements copied from System.Collections.Generic.List`1. The System.Array must have zero-based indexing.
    - array-index (System.Int32): The zero-based index in array at which copying begins.

CopyTo(Int32, T[], Int32, Int32) -> Void
  Summary: Copies a range of elements from the System.Collections.Generic.List`1 to a compatible one-dimensional array, starting at the specified index of the target array.
  Parameters:
    - index (System.Int32): The zero-based index in the source System.Collections.Generic.List`1 at which copying begins.
    - array (T[]): The one-dimensional System.Array that is the destination of the elements copied from System.Collections.Generic.List`1. The System.Array must have zero-based indexing.
    - array-index (System.Int32): The zero-based index in array at which copying begins.
    - count (System.Int32): The number of elements to copy.
"
  (cl:cond
    ((cl:and (cl:numberp array) supplied-array-index (cl:or (cl:null array-index) (dotnet:object-type array-index)) supplied-array-index2 (cl:numberp array-index2) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "CopyTo" array array-index array-index2 count))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-array-index (cl:numberp array-index) (cl:not supplied-array-index2) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "CopyTo" array array-index))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:not supplied-array-index) (cl:not supplied-array-index2) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "CopyTo" array))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-GENERIC-LIST-1"
                    :class-name <type-str>
                    :method-name "CopyTo"
                    :supplied-args (cl:append (cl:list :array array) (cl:when supplied-array-index (cl:list :array-index array-index)) (cl:when supplied-array-index2 (cl:list :array-index2 array-index2)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun ensure-capacity (obj! capacity)
  "Summary: Ensures that the capacity of this list is at least the specified capacity. If the current capacity is less than capacity, it is increased to at least the specified capacity.
Returns: The new capacity of this list.
Parameters:
  - capacity (System.Int32): The minimum capacity to ensure.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "EnsureCapacity" capacity))

(cl:defun exists (obj! match)
  "Summary: Determines whether the System.Collections.Generic.List`1 contains elements that match the conditions defined by the specified predicate.
Returns: if the System.Collections.Generic.List`1 contains one or more elements that match the conditions defined by the specified predicate; otherwise, .
Parameters:
  - match (System.Predicate`1[T]): The System.Predicate`1 delegate that defines the conditions of the elements to search for.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "Exists" match))

(cl:defun find (obj! match)
  "Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the first occurrence within the entire System.Collections.Generic.List`1.
Returns: The first element that matches the conditions defined by the specified predicate, if found; otherwise, the default value for type T.
Parameters:
  - match (System.Predicate`1[T]): The System.Predicate`1 delegate that defines the conditions of the element to search for.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "Find" match))

(cl:defun find-all (obj! match)
  "Summary: Retrieves all the elements that match the conditions defined by the specified predicate.
Returns: A System.Collections.Generic.List`1 containing all the elements that match the conditions defined by the specified predicate, if found; otherwise, an empty System.Collections.Generic.List`1.
Parameters:
  - match (System.Predicate`1[T]): The System.Predicate`1 delegate that defines the conditions of the elements to search for.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "FindAll" match))

(cl:defun find-index (obj! match cl:&optional (match2 cl:nil supplied-match2) (match3 cl:nil supplied-match3))
  "Master wrapper for System.Collections.Generic.List`1.FindIndex overloads. Dispatches at runtime.

FindIndex(Predicate) -> Int32
  Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the zero-based index of the first occurrence within the entire System.Collections.Generic.List`1.
  Returns: The zero-based index of the first occurrence of an element that matches the conditions defined by match, if found; otherwise, -1.
  Parameters:
    - match (System.Predicate`1[T]): The System.Predicate`1 delegate that defines the conditions of the element to search for.

FindIndex(Int32, Predicate) -> Int32
  Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the zero-based index of the first occurrence within the range of elements in the System.Collections.Generic.List`1 that extends from the specified index to the last element.
  Returns: The zero-based index of the first occurrence of an element that matches the conditions defined by match, if found; otherwise, -1.
  Parameters:
    - start-index (System.Int32): The zero-based starting index of the search.
    - match (System.Predicate`1[T]): The System.Predicate`1 delegate that defines the conditions of the element to search for.

FindIndex(Int32, Int32, Predicate) -> Int32
  Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the zero-based index of the first occurrence within the range of elements in the System.Collections.Generic.List`1 that starts at the specified index and contains the specified number of elements.
  Returns: The zero-based index of the first occurrence of an element that matches the conditions defined by match, if found; otherwise, -1.
  Parameters:
    - start-index (System.Int32): The zero-based starting index of the search.
    - count (System.Int32): The number of elements in the section to search.
    - match (System.Predicate`1[T]): The System.Predicate`1 delegate that defines the conditions of the element to search for.
"
  (cl:cond
    ((cl:and (cl:numberp match) supplied-match2 (cl:numberp match2) supplied-match3 (cl:or (cl:null match3) (dotnet:object-type match3)))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "FindIndex" match match2 match3))
    ((cl:and (cl:numberp match) supplied-match2 (cl:or (cl:null match2) (dotnet:object-type match2)) (cl:not supplied-match3))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "FindIndex" match match2))
    ((cl:and (cl:or (cl:null match) (dotnet:object-type match)) (cl:not supplied-match2) (cl:not supplied-match3))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "FindIndex" match))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-GENERIC-LIST-1"
                    :class-name <type-str>
                    :method-name "FindIndex"
                    :supplied-args (cl:append (cl:list :match match) (cl:when supplied-match2 (cl:list :match2 match2)) (cl:when supplied-match3 (cl:list :match3 match3)))))))

(cl:defun find-last (obj! match)
  "Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the last occurrence within the entire System.Collections.Generic.List`1.
Returns: The last element that matches the conditions defined by the specified predicate, if found; otherwise, the default value for type T.
Parameters:
  - match (System.Predicate`1[T]): The System.Predicate`1 delegate that defines the conditions of the element to search for.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "FindLast" match))

(cl:defun find-last-index (obj! match cl:&optional (match2 cl:nil supplied-match2) (match3 cl:nil supplied-match3))
  "Master wrapper for System.Collections.Generic.List`1.FindLastIndex overloads. Dispatches at runtime.

FindLastIndex(Predicate) -> Int32
  Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the zero-based index of the last occurrence within the entire System.Collections.Generic.List`1.
  Returns: The zero-based index of the last occurrence of an element that matches the conditions defined by match, if found; otherwise, -1.
  Parameters:
    - match (System.Predicate`1[T]): The System.Predicate`1 delegate that defines the conditions of the element to search for.

FindLastIndex(Int32, Predicate) -> Int32
  Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the zero-based index of the last occurrence within the range of elements in the System.Collections.Generic.List`1 that extends from the first element to the specified index.
  Returns: The zero-based index of the last occurrence of an element that matches the conditions defined by match, if found; otherwise, -1.
  Parameters:
    - start-index (System.Int32): The zero-based starting index of the backward search.
    - match (System.Predicate`1[T]): The System.Predicate`1 delegate that defines the conditions of the element to search for.

FindLastIndex(Int32, Int32, Predicate) -> Int32
  Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the zero-based index of the last occurrence within the range of elements in the System.Collections.Generic.List`1 that contains the specified number of elements and ends at the specified index.
  Returns: The zero-based index of the last occurrence of an element that matches the conditions defined by match, if found; otherwise, -1.
  Parameters:
    - start-index (System.Int32): The zero-based starting index of the backward search.
    - count (System.Int32): The number of elements in the section to search.
    - match (System.Predicate`1[T]): The System.Predicate`1 delegate that defines the conditions of the element to search for.
"
  (cl:cond
    ((cl:and (cl:numberp match) supplied-match2 (cl:numberp match2) supplied-match3 (cl:or (cl:null match3) (dotnet:object-type match3)))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "FindLastIndex" match match2 match3))
    ((cl:and (cl:numberp match) supplied-match2 (cl:or (cl:null match2) (dotnet:object-type match2)) (cl:not supplied-match3))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "FindLastIndex" match match2))
    ((cl:and (cl:or (cl:null match) (dotnet:object-type match)) (cl:not supplied-match2) (cl:not supplied-match3))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "FindLastIndex" match))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-GENERIC-LIST-1"
                    :class-name <type-str>
                    :method-name "FindLastIndex"
                    :supplied-args (cl:append (cl:list :match match) (cl:when supplied-match2 (cl:list :match2 match2)) (cl:when supplied-match3 (cl:list :match3 match3)))))))

(cl:defun for-each (obj! action)
  "Summary: Performs the specified action on each element of the System.Collections.Generic.List`1.
Parameters:
  - action (System.Action`1[T]): The System.Action`1 delegate to perform on each element of the System.Collections.Generic.List`1.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "ForEach" action))

(cl:defun get-enumerator (obj!)
  "Summary: Returns an enumerator that iterates through the System.Collections.Generic.List`1.
Returns: A System.Collections.Generic.List`1.Enumerator for the System.Collections.Generic.List`1.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "GetEnumerator"))

(cl:defun get-range (obj! index count)
  "Summary: Creates a shallow copy of a range of elements in the source System.Collections.Generic.List`1.
Returns: A shallow copy of a range of elements in the source System.Collections.Generic.List`1.
Parameters:
  - index (System.Int32): The zero-based System.Collections.Generic.List`1 index at which the range starts.
  - count (System.Int32): The number of elements in the range.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "GetRange" index count))

(cl:defun index-of (obj! item cl:&optional (index cl:nil supplied-index) (count cl:nil supplied-count))
  "Master wrapper for System.Collections.Generic.List`1.IndexOf overloads. Dispatches at runtime.

IndexOf(T) -> Int32
  Summary: Searches for the specified object and returns the zero-based index of the first occurrence within the entire System.Collections.Generic.List`1.
  Returns: The zero-based index of the first occurrence of item within the entire System.Collections.Generic.List`1, if found; otherwise, -1.
  Parameters:
    - item (T): The object to locate in the System.Collections.Generic.List`1. The value can be for reference types.

IndexOf(T, Int32) -> Int32
  Summary: Searches for the specified object and returns the zero-based index of the first occurrence within the range of elements in the System.Collections.Generic.List`1 that extends from the specified index to the last element.
  Returns: The zero-based index of the first occurrence of item within the range of elements in the System.Collections.Generic.List`1 that extends from index to the last element, if found; otherwise, -1.
  Parameters:
    - item (T): The object to locate in the System.Collections.Generic.List`1. The value can be for reference types.
    - index (System.Int32): The zero-based starting index of the search. 0 (zero) is valid in an empty list.

IndexOf(T, Int32, Int32) -> Int32
  Summary: Searches for the specified object and returns the zero-based index of the first occurrence within the range of elements in the System.Collections.Generic.List`1 that starts at the specified index and contains the specified number of elements.
  Returns: The zero-based index of the first occurrence of item within the range of elements in the System.Collections.Generic.List`1 that starts at index and contains count number of elements, if found; otherwise, -1.
  Parameters:
    - item (T): The object to locate in the System.Collections.Generic.List`1. The value can be for reference types.
    - index (System.Int32): The zero-based starting index of the search. 0 (zero) is valid in an empty list.
    - count (System.Int32): The number of elements in the section to search.
"
  (cl:cond
    ((cl:and (cl:or (cl:null item) (dotnet:object-type item)) supplied-index (cl:numberp index) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "IndexOf" item index count))
    ((cl:and (cl:or (cl:null item) (dotnet:object-type item)) supplied-index (cl:numberp index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "IndexOf" item index))
    ((cl:and (cl:or (cl:null item) (dotnet:object-type item)) (cl:not supplied-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "IndexOf" item))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-GENERIC-LIST-1"
                    :class-name <type-str>
                    :method-name "IndexOf"
                    :supplied-args (cl:append (cl:list :item item) (cl:when supplied-index (cl:list :index index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun insert (obj! index item)
  "Summary: Inserts an element into the System.Collections.Generic.List`1 at the specified index.
Parameters:
  - index (System.Int32): The zero-based index at which item should be inserted.
  - item (T): The object to insert. The value can be for reference types.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "Insert" index item))

(cl:defun insert-range (obj! index collection)
  "Summary: Inserts the elements of a collection into the System.Collections.Generic.List`1 at the specified index.
Parameters:
  - index (System.Int32): The zero-based index at which the new elements should be inserted.
  - collection (System.Collections.Generic.IEnumerable`1[T]): The collection whose elements should be inserted into the System.Collections.Generic.List`1. The collection itself cannot be , but it can contain elements that are , if type T is a reference type.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "InsertRange" index collection))

(cl:defun last-index-of (obj! item cl:&optional (index cl:nil supplied-index) (count cl:nil supplied-count))
  "Master wrapper for System.Collections.Generic.List`1.LastIndexOf overloads. Dispatches at runtime.

LastIndexOf(T) -> Int32
  Summary: Searches for the specified object and returns the zero-based index of the last occurrence within the entire System.Collections.Generic.List`1.
  Returns: The zero-based index of the last occurrence of item within the entire the System.Collections.Generic.List`1, if found; otherwise, -1.
  Parameters:
    - item (T): The object to locate in the System.Collections.Generic.List`1. The value can be for reference types.

LastIndexOf(T, Int32) -> Int32
  Summary: Searches for the specified object and returns the zero-based index of the last occurrence within the range of elements in the System.Collections.Generic.List`1 that extends from the first element to the specified index.
  Returns: The zero-based index of the last occurrence of item within the range of elements in the System.Collections.Generic.List`1 that extends from the first element to index, if found; otherwise, -1.
  Parameters:
    - item (T): The object to locate in the System.Collections.Generic.List`1. The value can be for reference types.
    - index (System.Int32): The zero-based starting index of the backward search.

LastIndexOf(T, Int32, Int32) -> Int32
  Summary: Searches for the specified object and returns the zero-based index of the last occurrence within the range of elements in the System.Collections.Generic.List`1 that contains the specified number of elements and ends at the specified index.
  Returns: The zero-based index of the last occurrence of item within the range of elements in the System.Collections.Generic.List`1 that contains count number of elements and ends at index, if found; otherwise, -1.
  Parameters:
    - item (T): The object to locate in the System.Collections.Generic.List`1. The value can be for reference types.
    - index (System.Int32): The zero-based starting index of the backward search.
    - count (System.Int32): The number of elements in the section to search.
"
  (cl:cond
    ((cl:and (cl:or (cl:null item) (dotnet:object-type item)) supplied-index (cl:numberp index) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "LastIndexOf" item index count))
    ((cl:and (cl:or (cl:null item) (dotnet:object-type item)) supplied-index (cl:numberp index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "LastIndexOf" item index))
    ((cl:and (cl:or (cl:null item) (dotnet:object-type item)) (cl:not supplied-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "LastIndexOf" item))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-GENERIC-LIST-1"
                    :class-name <type-str>
                    :method-name "LastIndexOf"
                    :supplied-args (cl:append (cl:list :item item) (cl:when supplied-index (cl:list :index index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun remove (obj! item)
  "Summary: Removes the first occurrence of a specific object from the System.Collections.Generic.List`1.
Returns: if item is successfully removed; otherwise, . This method also returns if item was not found in the System.Collections.Generic.List`1.
Parameters:
  - item (T): The object to remove from the System.Collections.Generic.List`1. The value can be for reference types.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "Remove" item))

(cl:defun remove-all (obj! match)
  "Summary: Removes all the elements that match the conditions defined by the specified predicate.
Returns: The number of elements removed from the System.Collections.Generic.List`1.
Parameters:
  - match (System.Predicate`1[T]): The System.Predicate`1 delegate that defines the conditions of the elements to remove.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "RemoveAll" match))

(cl:defun remove-at (obj! index)
  "Summary: Removes the element at the specified index of the System.Collections.Generic.List`1.
Parameters:
  - index (System.Int32): The zero-based index of the element to remove.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "RemoveAt" index))

(cl:defun remove-range (obj! index count)
  "Summary: Removes a range of elements from the System.Collections.Generic.List`1.
Parameters:
  - index (System.Int32): The zero-based starting index of the range of elements to remove.
  - count (System.Int32): The number of elements to remove.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "RemoveRange" index count))

(cl:defun reverse (obj! cl:&optional (index cl:nil supplied-index) (count cl:nil supplied-count))
  "Master wrapper for System.Collections.Generic.List`1.Reverse overloads. Dispatches at runtime.

Reverse() -> Void
  Summary: Reverses the order of the elements in the entire System.Collections.Generic.List`1.

Reverse(Int32, Int32) -> Void
  Summary: Reverses the order of the elements in the specified range.
  Parameters:
    - index (System.Int32): The zero-based starting index of the range to reverse.
    - count (System.Int32): The number of elements in the range to reverse.
"
  (cl:cond
    ((cl:and supplied-index (cl:numberp index) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "Reverse" index count))
    ((cl:and (cl:not supplied-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "Reverse"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-GENERIC-LIST-1"
                    :class-name <type-str>
                    :method-name "Reverse"
                    :supplied-args (cl:append (cl:when supplied-index (cl:list :index index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun slice (obj! start length)
  "Summary: Creates a shallow copy of a range of elements in the source System.Collections.Generic.List`1.
Returns: A shallow copy of a range of elements in the source System.Collections.Generic.List`1.
Parameters:
  - start (System.Int32): The zero-based System.Collections.Generic.List`1 index at which the range starts.
  - length (System.Int32): The length of the range.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "Slice" start length))

(cl:defun sort (obj! cl:&optional (comparer cl:nil supplied-comparer) (count cl:nil supplied-count) (comparer2 cl:nil supplied-comparer2))
  "Master wrapper for System.Collections.Generic.List`1.Sort overloads. Dispatches at runtime.

Sort() -> Void
  Summary: Sorts the elements in the entire System.Collections.Generic.List`1 using the default comparer.

Sort(IComparer) -> Void
  Summary: Sorts the elements in the entire System.Collections.Generic.List`1 using the specified comparer.
  Parameters:
    - comparer (System.Collections.Generic.IComparer`1[T]): The System.Collections.Generic.IComparer`1 implementation to use when comparing elements, or to use the default comparer System.Collections.Generic.Comparer`1.Default.

Sort(Comparison) -> Void
  Summary: Sorts the elements in the entire System.Collections.Generic.List`1 using the specified System.Comparison`1.
  Parameters:
    - comparison (System.Comparison`1[T]): The System.Comparison`1 to use when comparing elements.

Sort(Int32, Int32, IComparer) -> Void
  Summary: Sorts the elements in a range of elements in System.Collections.Generic.List`1 using the specified comparer.
  Parameters:
    - index (System.Int32): The zero-based starting index of the range to sort.
    - count (System.Int32): The length of the range to sort.
    - comparer (System.Collections.Generic.IComparer`1[T]): The System.Collections.Generic.IComparer`1 implementation to use when comparing elements, or to use the default comparer System.Collections.Generic.Comparer`1.Default.
"
  (cl:cond
    ((cl:and supplied-comparer (cl:numberp comparer) supplied-count (cl:numberp count) supplied-comparer2 (cl:or (cl:null comparer2) (dotnet:object-type comparer2)))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "Sort" comparer count comparer2))
    ((cl:and supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)) (cl:not supplied-count) (cl:not supplied-comparer2))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "Sort" comparer))
    ((cl:and supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)) (cl:not supplied-count) (cl:not supplied-comparer2))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "Sort" comparer))
    ((cl:and (cl:not supplied-comparer) (cl:not supplied-count) (cl:not supplied-comparer2))
     (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "Sort"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-COLLECTIONS-GENERIC-LIST-1"
                    :class-name <type-str>
                    :method-name "Sort"
                    :supplied-args (cl:append (cl:when supplied-comparer (cl:list :comparer comparer)) (cl:when supplied-count (cl:list :count count)) (cl:when supplied-comparer2 (cl:list :comparer2 comparer2)))))))

(cl:defun to-array (obj!)
  "Summary: Copies the elements of the System.Collections.Generic.List`1 to a new array.
Returns: An array containing copies of the elements of the System.Collections.Generic.List`1.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "ToArray"))

(cl:defun trim-excess (obj!)
  "Summary: Sets the capacity to the actual number of elements in the System.Collections.Generic.List`1, if that number is less than a threshold value.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "TrimExcess"))

(cl:defun true-for-all (obj! match)
  "Summary: Determines whether every element in the System.Collections.Generic.List`1 matches the conditions defined by the specified predicate.
Returns: if every element in the System.Collections.Generic.List`1 matches the conditions defined by the specified predicate; otherwise, . If the list has no elements, the return value is .
Parameters:
  - match (System.Predicate`1[T]): The System.Predicate`1 delegate that defines the conditions to check against the elements.
"
  (dotnet:invoke (cl:the (dotnet "System.Collections.Generic.List`1") obj!) "TrueForAll" match))

