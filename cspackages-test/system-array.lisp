;;; Generated automatically. Do not edit.
;;; Class: System.Array
;;; Generator Version: 28
;;; Creation Date: 2026-07-04T03:03:10Z

(cl:in-package :system-array)

(cl:defconstant <type> (dotnet:resolve-type "System.Array"))
(cl:defconstant <type-str> "System.Array")
(cl:defconstant <creation> "2026-07-04T03:03:10Z")
(cl:defconstant <version> 28)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Array")))

(cl:defconstant +max-length+ (dotnet:static <type-str> "MaxLength"))
(cl:setf (cl:documentation (cl:quote +max-length+) (cl:quote cl:variable)) "Gets the maximum number of elements that may be contained in an array.")

(cl:defun fixed-size? (obj!)
  "Gets a value indicating whether the System.Array has a fixed size."
  (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "get_IsFixedSize"))

(cl:defun read-only? (obj!)
  "Gets a value indicating whether the System.Array is read-only."
  (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "get_IsReadOnly"))

(cl:defun synchronized? (obj!)
  "Gets a value indicating whether access to the System.Array is synchronized (thread safe)."
  (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "get_IsSynchronized"))

(cl:defun length (obj!)
  "Gets the total number of elements in all the dimensions of the System.Array."
  (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "get_Length"))

(cl:defun long-length (obj!)
  "Gets a 64-bit integer that represents the total number of elements in all the dimensions of the System.Array."
  (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "get_LongLength"))

(cl:defun rank (obj!)
  "Gets the rank (number of dimensions) of the System.Array. For example, a one-dimensional array returns 1, a two-dimensional array returns 2, and so on."
  (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "get_Rank"))

(cl:defun sync-root (obj!)
  "Gets an object that can be used to synchronize access to the System.Array."
  (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "get_SyncRoot"))

(cl:defun as-read-only (type array)
  "Summary: Returns a read-only wrapper for the specified array.
Returns: A read-only System.Collections.ObjectModel.ReadOnlyCollection`1 wrapper for the specified array.
Parameters:
  - array (T[]): The one-dimensional, zero-based array to wrap in a read-only System.Collections.ObjectModel.ReadOnlyCollection`1 wrapper.
"
  (dotnet:static-generic <type-str> "AsReadOnly" (cl:list type) array))

(cl:defun binary-search (array value cl:&optional (comparer cl:nil supplied-comparer) (value2 cl:nil supplied-value2) (comparer2 cl:nil supplied-comparer2))
  "Master wrapper for System.Array.BinarySearch overloads. Dispatches at runtime.

BinarySearch(Array, Object) -> Int32
  Summary: Searches an entire one-dimensional sorted array for a specific element, using the System.IComparable interface implemented by each element of the array and by the specified object.
  Returns: The index of the specified value in the specified array, if value is found; otherwise, a negative number. If value is not found and value is less than one or more elements in array, the negative number returned is the bitwise complement of the index of the first element that is larger than value. If value is not found and value is greater than all elements in array, the negative number returned is the bitwise complement of (the index of the last element plus 1). If this method is called with a non-sorted array, the return value can be incorrect and a negative number could be returned, even if value is present in array.
  Parameters:
    - array (System.Array): The sorted one-dimensional System.Array to search.
    - value (System.Object): The object to search for.

BinarySearch(Array, Object, IComparer) -> Int32
  Summary: Searches an entire one-dimensional sorted array for a value using the specified System.Collections.IComparer interface.
  Returns: The index of the specified value in the specified array, if value is found; otherwise, a negative number. If value is not found and value is less than one or more elements in array, the negative number returned is the bitwise complement of the index of the first element that is larger than value. If value is not found and value is greater than all elements in array, the negative number returned is the bitwise complement of (the index of the last element plus 1). If this method is called with a non-sorted array, the return value can be incorrect and a negative number could be returned, even if value is present in array.
  Parameters:
    - array (System.Array): The sorted one-dimensional System.Array to search.
    - value (System.Object): The object to search for.
    - comparer (System.Collections.IComparer): The System.Collections.IComparer implementation to use when comparing elements. -or- to use the System.IComparable implementation of each element.

BinarySearch(Array, Int32, Int32, Object) -> Int32
  Summary: Searches a range of elements in a one-dimensional sorted array for a value, using the System.IComparable interface implemented by each element of the array and by the specified value.
  Returns: The index of the specified value in the specified array, if value is found; otherwise, a negative number. If value is not found and value is less than one or more elements in array, the negative number returned is the bitwise complement of the index of the first element that is larger than value. If value is not found and value is greater than all elements in array, the negative number returned is the bitwise complement of (the index of the last element plus 1). If this method is called with a non-sorted array, the return value can be incorrect and a negative number could be returned, even if value is present in array.
  Parameters:
    - array (System.Array): The sorted one-dimensional System.Array to search.
    - index (System.Int32): The starting index of the range to search.
    - length (System.Int32): The length of the range to search.
    - value (System.Object): The object to search for.

BinarySearch(Array, Int32, Int32, Object, IComparer) -> Int32
  Summary: Searches a range of elements in a one-dimensional sorted array for a value, using the specified System.Collections.IComparer interface.
  Returns: The index of the specified value in the specified array, if value is found; otherwise, a negative number. If value is not found and value is less than one or more elements in array, the negative number returned is the bitwise complement of the index of the first element that is larger than value. If value is not found and value is greater than all elements in array, the negative number returned is the bitwise complement of (the index of the last element plus 1). If this method is called with a non-sorted array, the return value can be incorrect and a negative number could be returned, even if value is present in array.
  Parameters:
    - array (System.Array): The sorted one-dimensional System.Array to search.
    - index (System.Int32): The starting index of the range to search.
    - length (System.Int32): The length of the range to search.
    - value (System.Object): The object to search for.
    - comparer (System.Collections.IComparer): The System.Collections.IComparer implementation to use when comparing elements. -or- to use the System.IComparable implementation of each element.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:numberp value) supplied-comparer (cl:numberp comparer) supplied-value2 (cl:or (cl:null value2) (dotnet:object-type value2)) supplied-comparer2 (cl:or (cl:null comparer2) (dotnet:object-type comparer2)))
     (dotnet:static <type-str> "BinarySearch" array value comparer value2 comparer2))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:numberp value) supplied-comparer (cl:numberp comparer) supplied-value2 (cl:or (cl:null value2) (dotnet:object-type value2)) (cl:not supplied-comparer2))
     (dotnet:static <type-str> "BinarySearch" array value comparer value2))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)) (cl:not supplied-value2) (cl:not supplied-comparer2))
     (dotnet:static <type-str> "BinarySearch" array value comparer))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-comparer) (cl:not supplied-value2) (cl:not supplied-comparer2))
     (dotnet:static <type-str> "BinarySearch" array value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "BinarySearch"
                    :supplied-args (cl:append (cl:list :array array) (cl:list :value value) (cl:when supplied-comparer (cl:list :comparer comparer)) (cl:when supplied-value2 (cl:list :value2 value2)) (cl:when supplied-comparer2 (cl:list :comparer2 comparer2)))))))

(cl:defun binary-search-arity-1 (type array value cl:&optional (comparer cl:nil supplied-comparer) (value2 cl:nil supplied-value2) (comparer2 cl:nil supplied-comparer2))
  "Master wrapper for System.Array.BinarySearch overloads. Dispatches at runtime.

BinarySearch(T[], T) -> Int32
  Summary: Searches an entire one-dimensional sorted array for a specific element, using the System.IComparable`1 generic interface implemented by each element of the System.Array and by the specified object.
  Returns: The index of the specified value in the specified array, if value is found; otherwise, a negative number. If value is not found and value is less than one or more elements in array, the negative number returned is the bitwise complement of the index of the first element that is larger than value. If value is not found and value is greater than all elements in array, the negative number returned is the bitwise complement of (the index of the last element plus 1). If this method is called with a non-sorted array, the return value can be incorrect and a negative number could be returned, even if value is present in array.
  Parameters:
    - array (T[]): The sorted one-dimensional, zero-based System.Array to search.
    - value (T): The object to search for.

BinarySearch(T[], T, IComparer) -> Int32
  Summary: Searches an entire one-dimensional sorted array for a value using the specified System.Collections.Generic.IComparer`1 generic interface.
  Returns: The index of the specified value in the specified array, if value is found; otherwise, a negative number. If value is not found and value is less than one or more elements in array, the negative number returned is the bitwise complement of the index of the first element that is larger than value. If value is not found and value is greater than all elements in array, the negative number returned is the bitwise complement of (the index of the last element plus 1). If this method is called with a non-sorted array, the return value can be incorrect and a negative number could be returned, even if value is present in array.
  Parameters:
    - array (T[]): The sorted one-dimensional, zero-based System.Array to search.
    - value (T): The object to search for.
    - comparer (System.Collections.Generic.IComparer`1[T]): The System.Collections.Generic.IComparer`1 implementation to use when comparing elements. -or- to use the System.IComparable`1 implementation of each element.

BinarySearch(T[], Int32, Int32, T) -> Int32
  Summary: Searches a range of elements in a one-dimensional sorted array for a value, using the System.IComparable`1 generic interface implemented by each element of the System.Array and by the specified value.
  Returns: The index of the specified value in the specified array, if value is found; otherwise, a negative number. If value is not found and value is less than one or more elements in array, the negative number returned is the bitwise complement of the index of the first element that is larger than value. If value is not found and value is greater than all elements in array, the negative number returned is the bitwise complement of (the index of the last element plus 1). If this method is called with a non-sorted array, the return value can be incorrect and a negative number could be returned, even if value is present in array.
  Parameters:
    - array (T[]): The sorted one-dimensional, zero-based System.Array to search.
    - index (System.Int32): The starting index of the range to search.
    - length (System.Int32): The length of the range to search.
    - value (T): The object to search for.

BinarySearch(T[], Int32, Int32, T, IComparer) -> Int32
  Summary: Searches a range of elements in a one-dimensional sorted array for a value, using the specified System.Collections.Generic.IComparer`1 generic interface.
  Returns: The index of the specified value in the specified array, if value is found; otherwise, a negative number. If value is not found and value is less than one or more elements in array, the negative number returned is the bitwise complement of the index of the first element that is larger than value. If value is not found and value is greater than all elements in array, the negative number returned is the bitwise complement of (the index of the last element plus 1). If this method is called with a non-sorted array, the return value can be incorrect and a negative number could be returned, even if value is present in array.
  Parameters:
    - array (T[]): The sorted one-dimensional, zero-based System.Array to search.
    - index (System.Int32): The starting index of the range to search.
    - length (System.Int32): The length of the range to search.
    - value (T): The object to search for.
    - comparer (System.Collections.Generic.IComparer`1[T]): The System.Collections.Generic.IComparer`1 implementation to use when comparing elements. -or- to use the System.IComparable`1 implementation of each element.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:numberp value) supplied-comparer (cl:numberp comparer) supplied-value2 (cl:or (cl:null value2) (dotnet:object-type value2)) supplied-comparer2 (cl:or (cl:null comparer2) (dotnet:object-type comparer2)))
     (dotnet:static-generic <type-str> "BinarySearch" (cl:list type) array value comparer value2 comparer2))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:numberp value) supplied-comparer (cl:numberp comparer) supplied-value2 (cl:or (cl:null value2) (dotnet:object-type value2)) (cl:not supplied-comparer2))
     (dotnet:static-generic <type-str> "BinarySearch" (cl:list type) array value comparer value2))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)) (cl:not supplied-value2) (cl:not supplied-comparer2))
     (dotnet:static-generic <type-str> "BinarySearch" (cl:list type) array value comparer))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-comparer) (cl:not supplied-value2) (cl:not supplied-comparer2))
     (dotnet:static-generic <type-str> "BinarySearch" (cl:list type) array value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "BinarySearch"
                    :supplied-args (cl:append (cl:list :array array) (cl:list :value value) (cl:when supplied-comparer (cl:list :comparer comparer)) (cl:when supplied-value2 (cl:list :value2 value2)) (cl:when supplied-comparer2 (cl:list :comparer2 comparer2)))))))

(cl:defun binary-search<> (types cl:&rest args)
  "Dispatches binary-search<> by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload.
   Passing cl:nil or an empty list calls the non-generic binary-search overload(s)."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (0 (cl:apply (cl:function binary-search) args))
      (1 (cl:apply (cl:function binary-search-arity-1) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-ARRAY"
                      :class-name <type-str>
                      :method-name "binary-search<>"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

(cl:defun clear (array cl:&optional (index cl:nil supplied-index) (length cl:nil supplied-length))
  "Master wrapper for System.Array.Clear overloads. Dispatches at runtime.

Clear(Array) -> Void
  Summary: Clears the contents of an array.
  Parameters:
    - array (System.Array): The array to clear.

Clear(Array, Int32, Int32) -> Void
  Summary: Sets a range of elements in an array to the default value of each element type.
  Parameters:
    - array (System.Array): The array whose elements need to be cleared.
    - index (System.Int32): The starting index of the range of elements to clear.
    - length (System.Int32): The number of elements to clear.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-index (cl:numberp index) supplied-length (cl:numberp length))
     (dotnet:static <type-str> "Clear" array index length))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:not supplied-index) (cl:not supplied-length))
     (dotnet:static <type-str> "Clear" array))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "Clear"
                    :supplied-args (cl:append (cl:list :array array) (cl:when supplied-index (cl:list :index index)) (cl:when supplied-length (cl:list :length length)))))))

(cl:defun clone (obj!)
  "Summary: Creates a shallow copy of the System.Array.
Returns: A shallow copy of the System.Array.
"
  (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "Clone"))

(cl:defun constrained-copy (source-array source-index destination-array destination-index length)
  "Summary: Copies a range of elements from an System.Array starting at the specified source index and pastes them to another System.Array starting at the specified destination index. Guarantees that all changes are undone if the copy does not succeed completely.
Parameters:
  - source-array (System.Array): The System.Array that contains the data to copy.
  - source-index (System.Int32): A 32-bit integer that represents the index in sourceArray at which copying begins.
  - destination-array (System.Array): The System.Array that receives the data.
  - destination-index (System.Int32): A 32-bit integer that represents the index in destinationArray at which storing begins.
  - length (System.Int32): A 32-bit integer that represents the number of elements to copy.
"
  (dotnet:static <type-str> "ConstrainedCopy" (cl:the (dotnet "System.Array") source-array) (cl:the (dotnet "System.Int32") source-index) (cl:the (dotnet "System.Array") destination-array) (cl:the (dotnet "System.Int32") destination-index) (cl:the (dotnet "System.Int32") length)))

(cl:defun convert-all (type-1 type-2 array converter)
  "Summary: Converts an array of one type to an array of another type.
Returns: An array of the target type containing the converted elements from the source array.
Parameters:
  - array (TInput[]): The one-dimensional, zero-based System.Array to convert to a target type.
  - converter (System.Converter`2[TInput, TOutput]): A System.Converter`2 that converts each element from one type to another type.
"
  (dotnet:static-generic <type-str> "ConvertAll" (cl:list type-1 type-2) array converter))

(cl:defun copy (source-array destination-array length cl:&optional (destination-index cl:nil supplied-destination-index) (length2 cl:nil supplied-length2))
  "Master wrapper for System.Array.Copy overloads. Dispatches at runtime.

Copy(Array, Array, Int64) -> Void
  Summary: Copies a range of elements from an System.Array starting at the first element and pastes them into another System.Array starting at the first element. The length is specified as a 64-bit integer.
  Parameters:
    - source-array (System.Array): The System.Array that contains the data to copy.
    - destination-array (System.Array): The System.Array that receives the data.
    - length (System.Int64): A 64-bit integer that represents the number of elements to copy. The integer must be between zero and System.Int32.MaxValue, inclusive.

Copy(Array, Array, Int32) -> Void
  Summary: Copies a range of elements from an System.Array starting at the first element and pastes them into another System.Array starting at the first element. The length is specified as a 32-bit integer.
  Parameters:
    - source-array (System.Array): The System.Array that contains the data to copy.
    - destination-array (System.Array): The System.Array that receives the data.
    - length (System.Int32): A 32-bit integer that represents the number of elements to copy.

Copy(Array, Int64, Array, Int64, Int64) -> Void
  Summary: Copies a range of elements from an System.Array starting at the specified source index and pastes them to another System.Array starting at the specified destination index. The length and the indexes are specified as 64-bit integers.
  Parameters:
    - source-array (System.Array): The System.Array that contains the data to copy.
    - source-index (System.Int64): A 64-bit integer that represents the index in sourceArray at which copying begins.
    - destination-array (System.Array): The System.Array that receives the data.
    - destination-index (System.Int64): A 64-bit integer that represents the index in destinationArray at which storing begins.
    - length (System.Int64): A 64-bit integer that represents the number of elements to copy. The integer must be between zero and System.Int32.MaxValue, inclusive.

Copy(Array, Int32, Array, Int32, Int32) -> Void
  Summary: Copies a range of elements from an System.Array starting at the specified source index and pastes them to another System.Array starting at the specified destination index. The length and the indexes are specified as 32-bit integers.
  Parameters:
    - source-array (System.Array): The System.Array that contains the data to copy.
    - source-index (System.Int32): A 32-bit integer that represents the index in sourceArray at which copying begins.
    - destination-array (System.Array): The System.Array that receives the data.
    - destination-index (System.Int32): A 32-bit integer that represents the index in destinationArray at which storing begins.
    - length (System.Int32): A 32-bit integer that represents the number of elements to copy.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source-array) (dotnet:object-type source-array)) (cl:numberp destination-array) (cl:or (cl:null length) (dotnet:object-type length)) supplied-destination-index (cl:numberp destination-index) supplied-length2 (cl:numberp length2))
     (dotnet:static <type-str> "Copy" source-array destination-array length destination-index length2))
    ((cl:and (cl:or (cl:null source-array) (dotnet:object-type source-array)) (cl:numberp destination-array) (cl:or (cl:null length) (dotnet:object-type length)) supplied-destination-index (cl:numberp destination-index) supplied-length2 (cl:numberp length2))
     (dotnet:static <type-str> "Copy" source-array destination-array length destination-index length2))
    ((cl:and (cl:or (cl:null source-array) (dotnet:object-type source-array)) (cl:or (cl:null destination-array) (dotnet:object-type destination-array)) (cl:numberp length) (cl:not supplied-destination-index) (cl:not supplied-length2))
     (dotnet:static <type-str> "Copy" source-array destination-array length))
    ((cl:and (cl:or (cl:null source-array) (dotnet:object-type source-array)) (cl:or (cl:null destination-array) (dotnet:object-type destination-array)) (cl:numberp length) (cl:not supplied-destination-index) (cl:not supplied-length2))
     (dotnet:static <type-str> "Copy" source-array destination-array length))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "Copy"
                    :supplied-args (cl:append (cl:list :source-array source-array) (cl:list :destination-array destination-array) (cl:list :length length) (cl:when supplied-destination-index (cl:list :destination-index destination-index)) (cl:when supplied-length2 (cl:list :length2 length2)))))))

(cl:defun copy-to (obj! array index)
  "Master wrapper for System.Array.CopyTo overloads. Dispatches at runtime.

CopyTo(Array, Int32) -> Void
  Summary: Copies all the elements of the current one-dimensional array to the specified one-dimensional array starting at the specified destination array index. The index is specified as a 32-bit integer.
  Parameters:
    - array (System.Array): The one-dimensional array that is the destination of the elements copied from the current array.
    - index (System.Int32): A 32-bit integer that represents the index in the destination array at which copying begins.

CopyTo(Array, Int64) -> Void
  Summary: Copies all the elements of the current one-dimensional array to the specified one-dimensional array starting at the specified destination array index. The index is specified as a 64-bit integer.
  Parameters:
    - array (System.Array): The one-dimensional array that is the destination of the elements copied from the current array.
    - index (System.Int64): A 64-bit integer that represents the index in the destination array at which copying begins.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:numberp index))
     (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "CopyTo" array index))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:numberp index))
     (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "CopyTo" array index))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "CopyTo"
                    :supplied-args (cl:append (cl:list :array array) (cl:list :index index))))))

(cl:defun create-instance (element-type length cl:&optional (length2 cl:nil supplied-length2) (length3 cl:nil supplied-length3))
  "Master wrapper for System.Array.CreateInstance overloads. Dispatches at runtime.

CreateInstance(Type, Int32) -> Array
  Summary: Creates a one-dimensional System.Array of the specified System.Type and length, with zero-based indexing.
  Returns: A new one-dimensional System.Array of the specified System.Type with the specified length, using zero-based indexing.
  Parameters:
    - element-type (System.Type): The System.Type of the System.Array to create.
    - length (System.Int32): The size of the System.Array to create.

CreateInstance(Type, Int32, Int32) -> Array
  Summary: Creates a two-dimensional System.Array of the specified System.Type and dimension lengths, with zero-based indexing.
  Returns: A new two-dimensional System.Array of the specified System.Type with the specified length for each dimension, using zero-based indexing.
  Parameters:
    - element-type (System.Type): The System.Type of the System.Array to create.
    - length1 (System.Int32): The size of the first dimension of the System.Array to create.
    - length2 (System.Int32): The size of the second dimension of the System.Array to create.

CreateInstance(Type, Int32[], Int32[]) -> Array
  Summary: Creates a multidimensional System.Array of the specified System.Type and dimension lengths, with the specified lower bounds.
  Returns: A new multidimensional System.Array of the specified System.Type with the specified length and lower bound for each dimension.
  Parameters:
    - element-type (System.Type): The System.Type of the System.Array to create.
    - lengths (System.Int32[]): A one-dimensional array that contains the size of each dimension of the System.Array to create.
    - lower-bounds (System.Int32[]): A one-dimensional array that contains the lower bound (starting index) of each dimension of the System.Array to create.

CreateInstance(Type, Int32, Int32, Int32) -> Array
  Summary: Creates a three-dimensional System.Array of the specified System.Type and dimension lengths, with zero-based indexing.
  Returns: A new three-dimensional System.Array of the specified System.Type with the specified length for each dimension, using zero-based indexing.
  Parameters:
    - element-type (System.Type): The System.Type of the System.Array to create.
    - length1 (System.Int32): The size of the first dimension of the System.Array to create.
    - length2 (System.Int32): The size of the second dimension of the System.Array to create.
    - length3 (System.Int32): The size of the third dimension of the System.Array to create.
"
  (cl:cond
    ((cl:and (cl:or (cl:null element-type) (dotnet:object-type element-type)) (cl:numberp length) supplied-length2 (cl:numberp length2) supplied-length3 (cl:numberp length3))
     (dotnet:static <type-str> "CreateInstance" element-type length length2 length3))
    ((cl:and (cl:or (cl:null element-type) (dotnet:object-type element-type)) (cl:numberp length) supplied-length2 (cl:numberp length2) (cl:not supplied-length3))
     (dotnet:static <type-str> "CreateInstance" element-type length length2))
    ((cl:and (cl:or (cl:null element-type) (dotnet:object-type element-type)) (cl:or (cl:null length) (dotnet:object-type length)) supplied-length2 (cl:or (cl:null length2) (dotnet:object-type length2)) (cl:not supplied-length3))
     (dotnet:static <type-str> "CreateInstance" element-type length length2))
    ((cl:and (cl:or (cl:null element-type) (dotnet:object-type element-type)) (cl:numberp length) (cl:not supplied-length2) (cl:not supplied-length3))
     (dotnet:static <type-str> "CreateInstance" element-type length))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "CreateInstance"
                    :supplied-args (cl:append (cl:list :element-type element-type) (cl:list :length length) (cl:when supplied-length2 (cl:list :length2 length2)) (cl:when supplied-length3 (cl:list :length3 length3)))))))

;; Note: System.Array.CreateInstance also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   CreateInstance(Type, params Int32[]) -> Array
;;   CreateInstance(Type, params Int64[]) -> Array

(cl:defun create-instance-from-array-type (array-type length cl:&optional (lower-bounds cl:nil supplied-lower-bounds))
  "Master wrapper for System.Array.CreateInstanceFromArrayType overloads. Dispatches at runtime.

CreateInstanceFromArrayType(Type, Int32) -> Array
  Summary: Creates a one-dimensional System.Array of the specified array type and length, with zero-based indexing.
  Returns: A new one-dimensional System.Array of the specified System.Type with the specified length.
  Parameters:
    - array-type (System.Type): The type of the array (not of the array element type).
    - length (System.Int32): The size of the System.Array to create.

CreateInstanceFromArrayType(Type, Int32[], Int32[]) -> Array
  Summary: Creates a multidimensional System.Array of the specified System.Type and dimension lengths, with the specified lower bounds.
  Returns: A new multidimensional System.Array of the specified System.Type with the specified length and lower bound for each dimension.
  Parameters:
    - array-type (System.Type): The type of the array (not of the array element type).
    - lengths (System.Int32[]): The dimension lengths, specified in an array of 32-bit integers.
    - lower-bounds (System.Int32[]): A one-dimensional array that contains the lower bound (starting index) of each dimension of the System.Array to create.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array-type) (dotnet:object-type array-type)) (cl:or (cl:null length) (dotnet:object-type length)) supplied-lower-bounds (cl:or (cl:null lower-bounds) (dotnet:object-type lower-bounds)))
     (dotnet:static <type-str> "CreateInstanceFromArrayType" array-type length lower-bounds))
    ((cl:and (cl:or (cl:null array-type) (dotnet:object-type array-type)) (cl:numberp length) (cl:not supplied-lower-bounds))
     (dotnet:static <type-str> "CreateInstanceFromArrayType" array-type length))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "CreateInstanceFromArrayType"
                    :supplied-args (cl:append (cl:list :array-type array-type) (cl:list :length length) (cl:when supplied-lower-bounds (cl:list :lower-bounds lower-bounds)))))))

;; Note: System.Array.CreateInstanceFromArrayType also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   CreateInstanceFromArrayType(Type, params Int32[]) -> Array

(cl:defun empty (type)
  "Summary: Returns an empty array.
Returns: An empty array.
"
  (dotnet:static-generic <type-str> "Empty" (cl:list type)))

(cl:defun exists (type array match)
  "Summary: Determines whether the specified array contains elements that match the conditions defined by the specified predicate.
Returns: if array contains one or more elements that match the conditions defined by the specified predicate; otherwise, .
Parameters:
  - array (T[]): The one-dimensional, zero-based System.Array to search.
  - match (System.Predicate`1[T]): The System.Predicate`1 that defines the conditions of the elements to search for.
"
  (dotnet:static-generic <type-str> "Exists" (cl:list type) array match))

(cl:defun fill (type array value cl:&optional (start-index cl:nil supplied-start-index) (count cl:nil supplied-count))
  "Master wrapper for System.Array.Fill overloads. Dispatches at runtime.

Fill(T[], T) -> Void
  Summary: Assigns the given value of type to each element of the specified array.
  Parameters:
    - array (T[]): The array to be filled.
    - value (T): The value to assign to each array element.

Fill(T[], T, Int32, Int32) -> Void
  Summary: Assigns the given value of type to the elements of the specified array that are within the range of startIndex (inclusive) and the next count number of indices.
  Parameters:
    - array (T[]): The array to be filled.
    - value (T): The new value for the elements in the specified range.
    - start-index (System.Int32): A 32-bit integer that represents the index in array at which filling begins.
    - count (System.Int32): The number of elements to copy.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count))
     (dotnet:static-generic <type-str> "Fill" (cl:list type) array value start-index count))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-start-index) (cl:not supplied-count))
     (dotnet:static-generic <type-str> "Fill" (cl:list type) array value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "Fill"
                    :supplied-args (cl:append (cl:list :array array) (cl:list :value value) (cl:when supplied-start-index (cl:list :start-index start-index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun find (type array match)
  "Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the first occurrence within the entire System.Array.
Returns: The first element that matches the conditions defined by the specified predicate, if found; otherwise, the default value for type .
Parameters:
  - array (T[]): The one-dimensional, zero-based array to search.
  - match (System.Predicate`1[T]): The predicate that defines the conditions of the element to search for.
"
  (dotnet:static-generic <type-str> "Find" (cl:list type) array match))

(cl:defun find-all (type array match)
  "Summary: Retrieves all the elements that match the conditions defined by the specified predicate.
Returns: An System.Array containing all the elements that match the conditions defined by the specified predicate, if found; otherwise, an empty System.Array.
Parameters:
  - array (T[]): The one-dimensional, zero-based System.Array to search.
  - match (System.Predicate`1[T]): The System.Predicate`1 that defines the conditions of the elements to search for.
"
  (dotnet:static-generic <type-str> "FindAll" (cl:list type) array match))

(cl:defun find-index (type array match cl:&optional (match2 cl:nil supplied-match2) (match3 cl:nil supplied-match3))
  "Master wrapper for System.Array.FindIndex overloads. Dispatches at runtime.

FindIndex(T[], Predicate) -> Int32
  Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the zero-based index of the first occurrence within the entire System.Array.
  Returns: The zero-based index of the first occurrence of an element that matches the conditions defined by match, if found; otherwise, -1.
  Parameters:
    - array (T[]): The one-dimensional, zero-based System.Array to search.
    - match (System.Predicate`1[T]): The System.Predicate`1 that defines the conditions of the element to search for.

FindIndex(T[], Int32, Predicate) -> Int32
  Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the zero-based index of the first occurrence within the range of elements in the System.Array that extends from the specified index to the last element.
  Returns: The zero-based index of the first occurrence of an element that matches the conditions defined by match, if found; otherwise, -1.
  Parameters:
    - array (T[]): The one-dimensional, zero-based System.Array to search.
    - start-index (System.Int32): The zero-based starting index of the search.
    - match (System.Predicate`1[T]): The System.Predicate`1 that defines the conditions of the element to search for.

FindIndex(T[], Int32, Int32, Predicate) -> Int32
  Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the zero-based index of the first occurrence within the range of elements in the System.Array that starts at the specified index and contains the specified number of elements.
  Returns: The zero-based index of the first occurrence of an element that matches the conditions defined by match, if found; otherwise, -1.
  Parameters:
    - array (T[]): The one-dimensional, zero-based System.Array to search.
    - start-index (System.Int32): The zero-based starting index of the search.
    - count (System.Int32): The number of elements in the section to search.
    - match (System.Predicate`1[T]): The System.Predicate`1 that defines the conditions of the element to search for.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:numberp match) supplied-match2 (cl:numberp match2) supplied-match3 (cl:or (cl:null match3) (dotnet:object-type match3)))
     (dotnet:static-generic <type-str> "FindIndex" (cl:list type) array match match2 match3))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:numberp match) supplied-match2 (cl:or (cl:null match2) (dotnet:object-type match2)) (cl:not supplied-match3))
     (dotnet:static-generic <type-str> "FindIndex" (cl:list type) array match match2))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null match) (dotnet:object-type match)) (cl:not supplied-match2) (cl:not supplied-match3))
     (dotnet:static-generic <type-str> "FindIndex" (cl:list type) array match))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "FindIndex"
                    :supplied-args (cl:append (cl:list :array array) (cl:list :match match) (cl:when supplied-match2 (cl:list :match2 match2)) (cl:when supplied-match3 (cl:list :match3 match3)))))))

(cl:defun find-last (type array match)
  "Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the last occurrence within the entire System.Array.
Returns: The last element that matches the conditions defined by the specified predicate, if found; otherwise, the default value for type .
Parameters:
  - array (T[]): The one-dimensional, zero-based System.Array to search.
  - match (System.Predicate`1[T]): The System.Predicate`1 that defines the conditions of the element to search for.
"
  (dotnet:static-generic <type-str> "FindLast" (cl:list type) array match))

(cl:defun find-last-index (type array match cl:&optional (match2 cl:nil supplied-match2) (match3 cl:nil supplied-match3))
  "Master wrapper for System.Array.FindLastIndex overloads. Dispatches at runtime.

FindLastIndex(T[], Predicate) -> Int32
  Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the zero-based index of the last occurrence within the entire System.Array.
  Returns: The zero-based index of the last occurrence of an element that matches the conditions defined by match, if found; otherwise, -1.
  Parameters:
    - array (T[]): The one-dimensional, zero-based System.Array to search.
    - match (System.Predicate`1[T]): The System.Predicate`1 that defines the conditions of the element to search for.

FindLastIndex(T[], Int32, Predicate) -> Int32
  Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the zero-based index of the last occurrence within the range of elements in the System.Array that extends from the first element to the specified index.
  Returns: The zero-based index of the last occurrence of an element that matches the conditions defined by match, if found; otherwise, -1.
  Parameters:
    - array (T[]): The one-dimensional, zero-based System.Array to search.
    - start-index (System.Int32): The zero-based starting index of the backward search.
    - match (System.Predicate`1[T]): The System.Predicate`1 that defines the conditions of the element to search for.

FindLastIndex(T[], Int32, Int32, Predicate) -> Int32
  Summary: Searches for an element that matches the conditions defined by the specified predicate, and returns the zero-based index of the last occurrence within the range of elements in the System.Array that contains the specified number of elements and ends at the specified index.
  Returns: The zero-based index of the last occurrence of an element that matches the conditions defined by match, if found; otherwise, -1.
  Parameters:
    - array (T[]): The one-dimensional, zero-based System.Array to search.
    - start-index (System.Int32): The zero-based starting index of the backward search.
    - count (System.Int32): The number of elements in the section to search.
    - match (System.Predicate`1[T]): The System.Predicate`1 that defines the conditions of the element to search for.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:numberp match) supplied-match2 (cl:numberp match2) supplied-match3 (cl:or (cl:null match3) (dotnet:object-type match3)))
     (dotnet:static-generic <type-str> "FindLastIndex" (cl:list type) array match match2 match3))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:numberp match) supplied-match2 (cl:or (cl:null match2) (dotnet:object-type match2)) (cl:not supplied-match3))
     (dotnet:static-generic <type-str> "FindLastIndex" (cl:list type) array match match2))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null match) (dotnet:object-type match)) (cl:not supplied-match2) (cl:not supplied-match3))
     (dotnet:static-generic <type-str> "FindLastIndex" (cl:list type) array match))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "FindLastIndex"
                    :supplied-args (cl:append (cl:list :array array) (cl:list :match match) (cl:when supplied-match2 (cl:list :match2 match2)) (cl:when supplied-match3 (cl:list :match3 match3)))))))

(cl:defun for-each (type array action)
  "Summary: Performs the specified action on each element of the specified array.
Parameters:
  - array (T[]): The one-dimensional, zero-based System.Array on whose elements the action is to be performed.
  - action (System.Action`1[T]): The System.Action`1 to perform on each element of array.
"
  (dotnet:static-generic <type-str> "ForEach" (cl:list type) array action))

(cl:defun get-enumerator (obj!)
  "Summary: Returns an System.Collections.IEnumerator for the System.Array.
Returns: An System.Collections.IEnumerator for the System.Array.
"
  (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "GetEnumerator"))

(cl:defun get-length (obj! dimension)
  "Summary: Gets a 32-bit integer that represents the number of elements in the specified dimension of the System.Array.
Returns: A 32-bit integer that represents the number of elements in the specified dimension.
Parameters:
  - dimension (System.Int32): A zero-based dimension of the System.Array whose length needs to be determined.
"
  (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "GetLength" dimension))

(cl:defun get-long-length (obj! dimension)
  "Summary: Gets a 64-bit integer that represents the number of elements in the specified dimension of the System.Array.
Returns: A 64-bit integer that represents the number of elements in the specified dimension.
Parameters:
  - dimension (System.Int32): A zero-based dimension of the System.Array whose length needs to be determined.
"
  (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "GetLongLength" dimension))

(cl:defun get-lower-bound (obj! dimension)
  "Summary: Gets the index of the first element of the specified dimension in the array.
Returns: The index of the first element of the specified dimension in the array.
Parameters:
  - dimension (System.Int32): A zero-based dimension of the array whose starting index needs to be determined.
"
  (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "GetLowerBound" dimension))

(cl:defun get-upper-bound (obj! dimension)
  "Summary: Gets the index of the last element of the specified dimension in the array.
Returns: The index of the last element of the specified dimension in the array, or -1 if the specified dimension is empty.
Parameters:
  - dimension (System.Int32): A zero-based dimension of the array whose upper bound needs to be determined.
"
  (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "GetUpperBound" dimension))

(cl:defun get-value (obj! index cl:&optional (index2 cl:nil supplied-index2) (index3 cl:nil supplied-index3))
  "Master wrapper for System.Array.GetValue overloads. Dispatches at runtime.

GetValue(Int32) -> Object
  Summary: Gets the value at the specified position in the one-dimensional System.Array. The index is specified as a 32-bit integer.
  Returns: The value at the specified position in the one-dimensional System.Array.
  Parameters:
    - index (System.Int32): A 32-bit integer that represents the position of the System.Array element to get.

GetValue(Int64) -> Object
  Summary: Gets the value at the specified position in the one-dimensional System.Array. The index is specified as a 64-bit integer.
  Returns: The value at the specified position in the one-dimensional System.Array.
  Parameters:
    - index (System.Int64): A 64-bit integer that represents the position of the System.Array element to get.

GetValue(Int32, Int32) -> Object
  Summary: Gets the value at the specified position in the two-dimensional System.Array. The indexes are specified as 32-bit integers.
  Returns: The value at the specified position in the two-dimensional System.Array.
  Parameters:
    - index1 (System.Int32): A 32-bit integer that represents the first-dimension index of the System.Array element to get.
    - index2 (System.Int32): A 32-bit integer that represents the second-dimension index of the System.Array element to get.

GetValue(Int64, Int64) -> Object
  Summary: Gets the value at the specified position in the two-dimensional System.Array. The indexes are specified as 64-bit integers.
  Returns: The value at the specified position in the two-dimensional System.Array.
  Parameters:
    - index1 (System.Int64): A 64-bit integer that represents the first-dimension index of the System.Array element to get.
    - index2 (System.Int64): A 64-bit integer that represents the second-dimension index of the System.Array element to get.

GetValue(Int32, Int32, Int32) -> Object
  Summary: Gets the value at the specified position in the three-dimensional System.Array. The indexes are specified as 32-bit integers.
  Returns: The value at the specified position in the three-dimensional System.Array.
  Parameters:
    - index1 (System.Int32): A 32-bit integer that represents the first-dimension index of the System.Array element to get.
    - index2 (System.Int32): A 32-bit integer that represents the second-dimension index of the System.Array element to get.
    - index3 (System.Int32): A 32-bit integer that represents the third-dimension index of the System.Array element to get.

GetValue(Int64, Int64, Int64) -> Object
  Summary: Gets the value at the specified position in the three-dimensional System.Array. The indexes are specified as 64-bit integers.
  Returns: The value at the specified position in the three-dimensional System.Array.
  Parameters:
    - index1 (System.Int64): A 64-bit integer that represents the first-dimension index of the System.Array element to get.
    - index2 (System.Int64): A 64-bit integer that represents the second-dimension index of the System.Array element to get.
    - index3 (System.Int64): A 64-bit integer that represents the third-dimension index of the System.Array element to get.
"
  (cl:cond
    ((cl:and (cl:numberp index) supplied-index2 (cl:numberp index2) supplied-index3 (cl:numberp index3))
     (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "GetValue" index index2 index3))
    ((cl:and (cl:numberp index) supplied-index2 (cl:numberp index2) supplied-index3 (cl:numberp index3))
     (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "GetValue" index index2 index3))
    ((cl:and (cl:numberp index) supplied-index2 (cl:numberp index2) (cl:not supplied-index3))
     (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "GetValue" index index2))
    ((cl:and (cl:numberp index) supplied-index2 (cl:numberp index2) (cl:not supplied-index3))
     (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "GetValue" index index2))
    ((cl:and (cl:numberp index) (cl:not supplied-index2) (cl:not supplied-index3))
     (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "GetValue" index))
    ((cl:and (cl:numberp index) (cl:not supplied-index2) (cl:not supplied-index3))
     (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "GetValue" index))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "GetValue"
                    :supplied-args (cl:append (cl:list :index index) (cl:when supplied-index2 (cl:list :index2 index2)) (cl:when supplied-index3 (cl:list :index3 index3)))))))

;; Note: System.Array.GetValue also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   GetValue(params Int32[]) -> Object
;;   GetValue(params Int64[]) -> Object

(cl:defun index-of (array value cl:&optional (start-index cl:nil supplied-start-index) (count cl:nil supplied-count))
  "Master wrapper for System.Array.IndexOf overloads. Dispatches at runtime.

IndexOf(Array, Object) -> Int32
  Summary: Searches for the specified object and returns the index of its first occurrence in a one-dimensional array.
  Returns: The index of the first occurrence of value in array, if found; otherwise, the lower bound of the array minus 1.
  Parameters:
    - array (System.Array): The one-dimensional array to search.
    - value (System.Object): The object to locate in array.

IndexOf(Array, Object, Int32) -> Int32
  Summary: Searches for the specified object in a range of elements of a one-dimensional array, and returns the index of its first occurrence. The range extends from a specified index to the end of the array.
  Returns: The index of the first occurrence of value, if it's found, within the range of elements in array that extends from startIndex to the last element; otherwise, the lower bound of the array minus 1.
  Parameters:
    - array (System.Array): The one-dimensional array to search.
    - value (System.Object): The object to locate in array.
    - start-index (System.Int32): The starting index of the search. 0 (zero) is valid in an empty array.

IndexOf(Array, Object, Int32, Int32) -> Int32
  Summary: Searches for the specified object in a range of elements of a one-dimensional array, and returns the index of ifs first occurrence. The range extends from a specified index for a specified number of elements.
  Returns: The index of the first occurrence of value, if it's found in the array from index startIndex to startIndex + count - 1; otherwise, the lower bound of the array minus 1.
  Parameters:
    - array (System.Array): The one-dimensional array to search.
    - value (System.Object): The object to locate in array.
    - start-index (System.Int32): The starting index of the search. 0 (zero) is valid in an empty array.
    - count (System.Int32): The number of elements to search.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count))
     (dotnet:static <type-str> "IndexOf" array value start-index count))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:numberp start-index) (cl:not supplied-count))
     (dotnet:static <type-str> "IndexOf" array value start-index))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-start-index) (cl:not supplied-count))
     (dotnet:static <type-str> "IndexOf" array value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "IndexOf"
                    :supplied-args (cl:append (cl:list :array array) (cl:list :value value) (cl:when supplied-start-index (cl:list :start-index start-index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun index-of-arity-1 (type array value cl:&optional (start-index cl:nil supplied-start-index) (count cl:nil supplied-count))
  "Master wrapper for System.Array.IndexOf overloads. Dispatches at runtime.

IndexOf(T[], T) -> Int32
  Summary: Searches for the specified object and returns the index of its first occurrence in a one-dimensional array.
  Returns: The zero-based index of the first occurrence of value in the entire array, if found; otherwise, -1.
  Parameters:
    - array (T[]): The one-dimensional, zero-based array to search.
    - value (T): The object to locate in array.

IndexOf(T[], T, Int32) -> Int32
  Summary: Searches for the specified object in a range of elements of a one dimensional array, and returns the index of its first occurrence. The range extends from a specified index to the end of the array.
  Returns: The zero-based index of the first occurrence of value within the range of elements in array that extends from startIndex to the last element, if found; otherwise, -1.
  Parameters:
    - array (T[]): The one-dimensional, zero-based array to search.
    - value (T): The object to locate in array.
    - start-index (System.Int32): The zero-based starting index of the search. 0 (zero) is valid in an empty array.

IndexOf(T[], T, Int32, Int32) -> Int32
  Summary: Searches for the specified object in a range of elements of a one-dimensional array, and returns the index of its first occurrence. The range extends from a specified index for a specified number of elements.
  Returns: The zero-based index of the first occurrence of value within the range of elements in array that starts at startIndex and contains the number of elements specified in count, if found; otherwise, -1.
  Parameters:
    - array (T[]): The one-dimensional, zero-based array to search.
    - value (T): The object to locate in array.
    - start-index (System.Int32): The zero-based starting index of the search. 0 (zero) is valid in an empty array.
    - count (System.Int32): The number of elements in the section to search.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count))
     (dotnet:static-generic <type-str> "IndexOf" (cl:list type) array value start-index count))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:numberp start-index) (cl:not supplied-count))
     (dotnet:static-generic <type-str> "IndexOf" (cl:list type) array value start-index))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-start-index) (cl:not supplied-count))
     (dotnet:static-generic <type-str> "IndexOf" (cl:list type) array value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "IndexOf"
                    :supplied-args (cl:append (cl:list :array array) (cl:list :value value) (cl:when supplied-start-index (cl:list :start-index start-index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun index-of<> (types cl:&rest args)
  "Dispatches index-of<> by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload.
   Passing cl:nil or an empty list calls the non-generic index-of overload(s)."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (0 (cl:apply (cl:function index-of) args))
      (1 (cl:apply (cl:function index-of-arity-1) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-ARRAY"
                      :class-name <type-str>
                      :method-name "index-of<>"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

(cl:defun initialize (obj!)
  "Summary: Initializes every element of the value-type System.Array by calling the parameterless constructor of the value type.
"
  (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "Initialize"))

(cl:defun last-index-of (array value cl:&optional (start-index cl:nil supplied-start-index) (count cl:nil supplied-count))
  "Master wrapper for System.Array.LastIndexOf overloads. Dispatches at runtime.

LastIndexOf(Array, Object) -> Int32
  Summary: Searches for the specified object and returns the index of the last occurrence within the entire one-dimensional System.Array.
  Returns: The index of the last occurrence of value within the entire array, if found; otherwise, the lower bound of the array minus 1.
  Parameters:
    - array (System.Array): The one-dimensional System.Array to search.
    - value (System.Object): The object to locate in array.

LastIndexOf(Array, Object, Int32) -> Int32
  Summary: Searches for the specified object and returns the index of the last occurrence within the range of elements in the one-dimensional System.Array that extends from the first element to the specified index.
  Returns: The index of the last occurrence of value within the range of elements in array that extends from the first element to startIndex, if found; otherwise, the lower bound of the array minus 1.
  Parameters:
    - array (System.Array): The one-dimensional System.Array to search.
    - value (System.Object): The object to locate in array.
    - start-index (System.Int32): The starting index of the backward search.

LastIndexOf(Array, Object, Int32, Int32) -> Int32
  Summary: Searches for the specified object and returns the index of the last occurrence within the range of elements in the one-dimensional System.Array that contains the specified number of elements and ends at the specified index.
  Returns: The index of the last occurrence of value within the range of elements in array that contains the number of elements specified in count and ends at startIndex, if found; otherwise, the lower bound of the array minus 1.
  Parameters:
    - array (System.Array): The one-dimensional System.Array to search.
    - value (System.Object): The object to locate in array.
    - start-index (System.Int32): The starting index of the backward search.
    - count (System.Int32): The number of elements in the section to search.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count))
     (dotnet:static <type-str> "LastIndexOf" array value start-index count))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:numberp start-index) (cl:not supplied-count))
     (dotnet:static <type-str> "LastIndexOf" array value start-index))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-start-index) (cl:not supplied-count))
     (dotnet:static <type-str> "LastIndexOf" array value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "LastIndexOf"
                    :supplied-args (cl:append (cl:list :array array) (cl:list :value value) (cl:when supplied-start-index (cl:list :start-index start-index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun last-index-of-arity-1 (type array value cl:&optional (start-index cl:nil supplied-start-index) (count cl:nil supplied-count))
  "Master wrapper for System.Array.LastIndexOf overloads. Dispatches at runtime.

LastIndexOf(T[], T) -> Int32
  Summary: Searches for the specified object and returns the index of the last occurrence within the entire System.Array.
  Returns: The zero-based index of the last occurrence of value within the entire array, if found; otherwise, -1.
  Parameters:
    - array (T[]): The one-dimensional, zero-based System.Array to search.
    - value (T): The object to locate in array.

LastIndexOf(T[], T, Int32) -> Int32
  Summary: Searches for the specified object and returns the index of the last occurrence within the range of elements in the System.Array that extends from the first element to the specified index.
  Returns: The zero-based index of the last occurrence of value within the range of elements in array that extends from the first element to startIndex, if found; otherwise, -1.
  Parameters:
    - array (T[]): The one-dimensional, zero-based System.Array to search.
    - value (T): The object to locate in array.
    - start-index (System.Int32): The zero-based starting index of the backward search.

LastIndexOf(T[], T, Int32, Int32) -> Int32
  Summary: Searches for the specified object and returns the index of the last occurrence within the range of elements in the System.Array that contains the specified number of elements and ends at the specified index.
  Returns: The zero-based index of the last occurrence of value within the range of elements in array that contains the number of elements specified in count and ends at startIndex, if found; otherwise, -1.
  Parameters:
    - array (T[]): The one-dimensional, zero-based System.Array to search.
    - value (T): The object to locate in array.
    - start-index (System.Int32): The zero-based starting index of the backward search.
    - count (System.Int32): The number of elements in the section to search.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count))
     (dotnet:static-generic <type-str> "LastIndexOf" (cl:list type) array value start-index count))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:numberp start-index) (cl:not supplied-count))
     (dotnet:static-generic <type-str> "LastIndexOf" (cl:list type) array value start-index))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-start-index) (cl:not supplied-count))
     (dotnet:static-generic <type-str> "LastIndexOf" (cl:list type) array value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "LastIndexOf"
                    :supplied-args (cl:append (cl:list :array array) (cl:list :value value) (cl:when supplied-start-index (cl:list :start-index start-index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun last-index-of<> (types cl:&rest args)
  "Dispatches last-index-of<> by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload.
   Passing cl:nil or an empty list calls the non-generic last-index-of overload(s)."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (0 (cl:apply (cl:function last-index-of) args))
      (1 (cl:apply (cl:function last-index-of-arity-1) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-ARRAY"
                      :class-name <type-str>
                      :method-name "last-index-of<>"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

;; The following C# System.Array.Resize overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   Resize(ref T[]&, Int32) -> Void

(cl:defun reverse (array cl:&optional (index cl:nil supplied-index) (length cl:nil supplied-length))
  "Master wrapper for System.Array.Reverse overloads. Dispatches at runtime.

Reverse(Array) -> Void
  Summary: Reverses the sequence of the elements in the entire one-dimensional System.Array.
  Parameters:
    - array (System.Array): The one-dimensional System.Array to reverse.

Reverse(Array, Int32, Int32) -> Void
  Summary: Reverses the sequence of a subset of the elements in the one-dimensional System.Array.
  Parameters:
    - array (System.Array): The one-dimensional System.Array to reverse.
    - index (System.Int32): The starting index of the section to reverse.
    - length (System.Int32): The number of elements in the section to reverse.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-index (cl:numberp index) supplied-length (cl:numberp length))
     (dotnet:static <type-str> "Reverse" array index length))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:not supplied-index) (cl:not supplied-length))
     (dotnet:static <type-str> "Reverse" array))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "Reverse"
                    :supplied-args (cl:append (cl:list :array array) (cl:when supplied-index (cl:list :index index)) (cl:when supplied-length (cl:list :length length)))))))

(cl:defun reverse-arity-1 (type array cl:&optional (index cl:nil supplied-index) (length cl:nil supplied-length))
  "Master wrapper for System.Array.Reverse overloads. Dispatches at runtime.

Reverse(T[]) -> Void
  Summary: Reverses the sequence of the elements in the one-dimensional generic array.
  Parameters:
    - array (T[]): The one-dimensional array of elements to reverse.

Reverse(T[], Int32, Int32) -> Void
  Summary: Reverses the sequence of a subset of the elements in the one-dimensional generic array.
  Parameters:
    - array (T[]): The one-dimensional array of elements to reverse.
    - index (System.Int32): The starting index of the section to reverse.
    - length (System.Int32): The number of elements in the section to reverse.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-index (cl:numberp index) supplied-length (cl:numberp length))
     (dotnet:static-generic <type-str> "Reverse" (cl:list type) array index length))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:not supplied-index) (cl:not supplied-length))
     (dotnet:static-generic <type-str> "Reverse" (cl:list type) array))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "Reverse"
                    :supplied-args (cl:append (cl:list :array array) (cl:when supplied-index (cl:list :index index)) (cl:when supplied-length (cl:list :length length)))))))

(cl:defun reverse<> (types cl:&rest args)
  "Dispatches reverse<> by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload.
   Passing cl:nil or an empty list calls the non-generic reverse overload(s)."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (0 (cl:apply (cl:function reverse) args))
      (1 (cl:apply (cl:function reverse-arity-1) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-ARRAY"
                      :class-name <type-str>
                      :method-name "reverse<>"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

(cl:defun set-value (obj! value index cl:&optional (index2 cl:nil supplied-index2) (index3 cl:nil supplied-index3))
  "Master wrapper for System.Array.SetValue overloads. Dispatches at runtime.

SetValue(Object, Int32) -> Void
  Summary: Sets a value to the element at the specified position in the one-dimensional System.Array. The index is specified as a 32-bit integer.
  Parameters:
    - value (System.Object): The new value for the specified element.
    - index (System.Int32): A 32-bit integer that represents the position of the System.Array element to set.

SetValue(Object, Int64) -> Void
  Summary: Sets a value to the element at the specified position in the one-dimensional System.Array. The index is specified as a 64-bit integer.
  Parameters:
    - value (System.Object): The new value for the specified element.
    - index (System.Int64): A 64-bit integer that represents the position of the System.Array element to set.

SetValue(Object, Int32, Int32) -> Void
  Summary: Sets a value to the element at the specified position in the two-dimensional System.Array. The indexes are specified as 32-bit integers.
  Parameters:
    - value (System.Object): The new value for the specified element.
    - index1 (System.Int32): A 32-bit integer that represents the first-dimension index of the System.Array element to set.
    - index2 (System.Int32): A 32-bit integer that represents the second-dimension index of the System.Array element to set.

SetValue(Object, Int64, Int64) -> Void
  Summary: Sets a value to the element at the specified position in the two-dimensional System.Array. The indexes are specified as 64-bit integers.
  Parameters:
    - value (System.Object): The new value for the specified element.
    - index1 (System.Int64): A 64-bit integer that represents the first-dimension index of the System.Array element to set.
    - index2 (System.Int64): A 64-bit integer that represents the second-dimension index of the System.Array element to set.

SetValue(Object, Int32, Int32, Int32) -> Void
  Summary: Sets a value to the element at the specified position in the three-dimensional System.Array. The indexes are specified as 32-bit integers.
  Parameters:
    - value (System.Object): The new value for the specified element.
    - index1 (System.Int32): A 32-bit integer that represents the first-dimension index of the System.Array element to set.
    - index2 (System.Int32): A 32-bit integer that represents the second-dimension index of the System.Array element to set.
    - index3 (System.Int32): A 32-bit integer that represents the third-dimension index of the System.Array element to set.

SetValue(Object, Int64, Int64, Int64) -> Void
  Summary: Sets a value to the element at the specified position in the three-dimensional System.Array. The indexes are specified as 64-bit integers.
  Parameters:
    - value (System.Object): The new value for the specified element.
    - index1 (System.Int64): A 64-bit integer that represents the first-dimension index of the System.Array element to set.
    - index2 (System.Int64): A 64-bit integer that represents the second-dimension index of the System.Array element to set.
    - index3 (System.Int64): A 64-bit integer that represents the third-dimension index of the System.Array element to set.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:numberp index) supplied-index2 (cl:numberp index2) supplied-index3 (cl:numberp index3))
     (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "SetValue" value index index2 index3))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:numberp index) supplied-index2 (cl:numberp index2) supplied-index3 (cl:numberp index3))
     (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "SetValue" value index index2 index3))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:numberp index) supplied-index2 (cl:numberp index2) (cl:not supplied-index3))
     (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "SetValue" value index index2))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:numberp index) supplied-index2 (cl:numberp index2) (cl:not supplied-index3))
     (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "SetValue" value index index2))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:numberp index) (cl:not supplied-index2) (cl:not supplied-index3))
     (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "SetValue" value index))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:numberp index) (cl:not supplied-index2) (cl:not supplied-index3))
     (dotnet:invoke (cl:the (dotnet "System.Array") obj!) "SetValue" value index))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "SetValue"
                    :supplied-args (cl:append (cl:list :value value) (cl:list :index index) (cl:when supplied-index2 (cl:list :index2 index2)) (cl:when supplied-index3 (cl:list :index3 index3)))))))

;; Note: System.Array.SetValue also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   SetValue(Object, params Int32[]) -> Void
;;   SetValue(Object, params Int64[]) -> Void

(cl:defun sort (array cl:&optional (items cl:nil supplied-items) (length cl:nil supplied-length) (length2 cl:nil supplied-length2) (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Array.Sort overloads. Dispatches at runtime.

Sort(Array) -> Void
  Summary: Sorts the elements in an entire one-dimensional System.Array using the System.IComparable implementation of each element of the System.Array.
  Parameters:
    - array (System.Array): The one-dimensional System.Array to sort.

Sort(Array, Array) -> Void
  Summary: Sorts a pair of one-dimensional System.Array objects (one contains the keys and the other contains the corresponding items) based on the keys in the first System.Array using the System.IComparable implementation of each key.
  Parameters:
    - keys (System.Array): The one-dimensional System.Array that contains the keys to sort.
    - items (System.Array): The one-dimensional System.Array that contains the items that correspond to each of the keys in the keysSystem.Array. -or- to sort only the keysSystem.Array.

Sort(Array, IComparer) -> Void
  Summary: Sorts the elements in a one-dimensional System.Array using the specified System.Collections.IComparer.
  Parameters:
    - array (System.Array): The one-dimensional array to sort.
    - comparer (System.Collections.IComparer): The implementation to use when comparing elements. -or- to use the System.IComparable implementation of each element.

Sort(Array, Int32, Int32) -> Void
  Summary: Sorts the elements in a range of elements in a one-dimensional System.Array using the System.IComparable implementation of each element of the System.Array.
  Parameters:
    - array (System.Array): The one-dimensional System.Array to sort.
    - index (System.Int32): The starting index of the range to sort.
    - length (System.Int32): The number of elements in the range to sort.

Sort(Array, Array, IComparer) -> Void
  Summary: Sorts a pair of one-dimensional System.Array objects (one contains the keys and the other contains the corresponding items) based on the keys in the first System.Array using the specified System.Collections.IComparer.
  Parameters:
    - keys (System.Array): The one-dimensional System.Array that contains the keys to sort.
    - items (System.Array): The one-dimensional System.Array that contains the items that correspond to each of the keys in the keysSystem.Array. -or- to sort only the keysSystem.Array.
    - comparer (System.Collections.IComparer): The System.Collections.IComparer implementation to use when comparing elements. -or- to use the System.IComparable implementation of each element.

Sort(Array, Array, Int32, Int32) -> Void
  Summary: Sorts a range of elements in a pair of one-dimensional System.Array objects (one contains the keys and the other contains the corresponding items) based on the keys in the first System.Array using the System.IComparable implementation of each key.
  Parameters:
    - keys (System.Array): The one-dimensional System.Array that contains the keys to sort.
    - items (System.Array): The one-dimensional System.Array that contains the items that correspond to each of the keys in the keysSystem.Array. -or- to sort only the keysSystem.Array.
    - index (System.Int32): The starting index of the range to sort.
    - length (System.Int32): The number of elements in the range to sort.

Sort(Array, Int32, Int32, IComparer) -> Void
  Summary: Sorts the elements in a range of elements in a one-dimensional System.Array using the specified System.Collections.IComparer.
  Parameters:
    - array (System.Array): The one-dimensional System.Array to sort.
    - index (System.Int32): The starting index of the range to sort.
    - length (System.Int32): The number of elements in the range to sort.
    - comparer (System.Collections.IComparer): The System.Collections.IComparer implementation to use when comparing elements. -or- to use the System.IComparable implementation of each element.

Sort(Array, Array, Int32, Int32, IComparer) -> Void
  Summary: Sorts a range of elements in a pair of one-dimensional System.Array objects (one contains the keys and the other contains the corresponding items) based on the keys in the first System.Array using the specified System.Collections.IComparer.
  Parameters:
    - keys (System.Array): The one-dimensional System.Array that contains the keys to sort.
    - items (System.Array): The one-dimensional System.Array that contains the items that correspond to each of the keys in the keysSystem.Array. -or- to sort only the keysSystem.Array.
    - index (System.Int32): The starting index of the range to sort.
    - length (System.Int32): The number of elements in the range to sort.
    - comparer (System.Collections.IComparer): The System.Collections.IComparer implementation to use when comparing elements. -or- to use the System.IComparable implementation of each element.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-items (cl:or (cl:null items) (dotnet:object-type items)) supplied-length (cl:numberp length) supplied-length2 (cl:numberp length2) supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)))
     (dotnet:static <type-str> "Sort" array items length length2 comparer))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-items (cl:or (cl:null items) (dotnet:object-type items)) supplied-length (cl:numberp length) supplied-length2 (cl:numberp length2) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Sort" array items length length2))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-items (cl:numberp items) supplied-length (cl:numberp length) supplied-length2 (cl:or (cl:null length2) (dotnet:object-type length2)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Sort" array items length length2))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-items (cl:numberp items) supplied-length (cl:numberp length) (cl:not supplied-length2) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Sort" array items length))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-items (cl:or (cl:null items) (dotnet:object-type items)) supplied-length (cl:or (cl:null length) (dotnet:object-type length)) (cl:not supplied-length2) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Sort" array items length))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-items (cl:or (cl:null items) (dotnet:object-type items)) (cl:not supplied-length) (cl:not supplied-length2) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Sort" array items))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-items (cl:or (cl:null items) (dotnet:object-type items)) (cl:not supplied-length) (cl:not supplied-length2) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Sort" array items))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:not supplied-items) (cl:not supplied-length) (cl:not supplied-length2) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Sort" array))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "Sort"
                    :supplied-args (cl:append (cl:list :array array) (cl:when supplied-items (cl:list :items items)) (cl:when supplied-length (cl:list :length length)) (cl:when supplied-length2 (cl:list :length2 length2)) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun sort-arity-1 (type array cl:&optional (comparer cl:nil supplied-comparer) (length cl:nil supplied-length) (comparer2 cl:nil supplied-comparer2))
  "Master wrapper for System.Array.Sort overloads. Dispatches at runtime.

Sort(T[]) -> Void
  Summary: Sorts the elements in an entire System.Array using the System.IComparable`1 generic interface implementation of each element of the System.Array.
  Parameters:
    - array (T[]): The one-dimensional, zero-based System.Array to sort.

Sort(T[], IComparer) -> Void
  Summary: Sorts the elements in an System.Array using the specified System.Collections.Generic.IComparer`1 generic interface.
  Parameters:
    - array (T[]): The one-dimensional, zero-base System.Array to sort.
    - comparer (System.Collections.Generic.IComparer`1[T]): The System.Collections.Generic.IComparer`1 generic interface implementation to use when comparing elements, or to use the System.IComparable`1 generic interface implementation of each element.

Sort(T[], Comparison) -> Void
  Summary: Sorts the elements in an System.Array using the specified System.Comparison`1.
  Parameters:
    - array (T[]): The one-dimensional, zero-based System.Array to sort.
    - comparison (System.Comparison`1[T]): The System.Comparison`1 to use when comparing elements.

Sort(T[], Int32, Int32) -> Void
  Summary: Sorts the elements in a range of elements in an System.Array using the System.IComparable`1 generic interface implementation of each element of the System.Array.
  Parameters:
    - array (T[]): The one-dimensional, zero-based System.Array to sort.
    - index (System.Int32): The starting index of the range to sort.
    - length (System.Int32): The number of elements in the range to sort.

Sort(T[], Int32, Int32, IComparer) -> Void
  Summary: Sorts the elements in a range of elements in an System.Array using the specified System.Collections.Generic.IComparer`1 generic interface.
  Parameters:
    - array (T[]): The one-dimensional, zero-based System.Array to sort.
    - index (System.Int32): The starting index of the range to sort.
    - length (System.Int32): The number of elements in the range to sort.
    - comparer (System.Collections.Generic.IComparer`1[T]): The System.Collections.Generic.IComparer`1 generic interface implementation to use when comparing elements, or to use the System.IComparable`1 generic interface implementation of each element.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-comparer (cl:numberp comparer) supplied-length (cl:numberp length) supplied-comparer2 (cl:or (cl:null comparer2) (dotnet:object-type comparer2)))
     (dotnet:static-generic <type-str> "Sort" (cl:list type) array comparer length comparer2))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-comparer (cl:numberp comparer) supplied-length (cl:numberp length) (cl:not supplied-comparer2))
     (dotnet:static-generic <type-str> "Sort" (cl:list type) array comparer length))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)) (cl:not supplied-length) (cl:not supplied-comparer2))
     (dotnet:static-generic <type-str> "Sort" (cl:list type) array comparer))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)) (cl:not supplied-length) (cl:not supplied-comparer2))
     (dotnet:static-generic <type-str> "Sort" (cl:list type) array comparer))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:not supplied-comparer) (cl:not supplied-length) (cl:not supplied-comparer2))
     (dotnet:static-generic <type-str> "Sort" (cl:list type) array))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "Sort"
                    :supplied-args (cl:append (cl:list :array array) (cl:when supplied-comparer (cl:list :comparer comparer)) (cl:when supplied-length (cl:list :length length)) (cl:when supplied-comparer2 (cl:list :comparer2 comparer2)))))))

(cl:defun sort-arity-2 (type-1 type-2 keys items cl:&optional (comparer cl:nil supplied-comparer) (length cl:nil supplied-length) (comparer2 cl:nil supplied-comparer2))
  "Master wrapper for System.Array.Sort overloads. Dispatches at runtime.

Sort(TKey[], TValue[]) -> Void
  Summary: Sorts a pair of System.Array objects (one contains the keys and the other contains the corresponding items) based on the keys in the first System.Array using the System.IComparable`1 generic interface implementation of each key.
  Parameters:
    - keys (TKey[]): The one-dimensional, zero-based System.Array that contains the keys to sort.
    - items (TValue[]): The one-dimensional, zero-based System.Array that contains the items that correspond to the keys in keys, or to sort only keys.

Sort(TKey[], TValue[], IComparer) -> Void
  Summary: Sorts a pair of System.Array objects (one contains the keys and the other contains the corresponding items) based on the keys in the first System.Array using the specified System.Collections.Generic.IComparer`1 generic interface.
  Parameters:
    - keys (TKey[]): The one-dimensional, zero-based System.Array that contains the keys to sort.
    - items (TValue[]): The one-dimensional, zero-based System.Array that contains the items that correspond to the keys in keys, or to sort only keys.
    - comparer (System.Collections.Generic.IComparer`1[TKey]): The System.Collections.Generic.IComparer`1 generic interface implementation to use when comparing elements, or to use the System.IComparable`1 generic interface implementation of each element.

Sort(TKey[], TValue[], Int32, Int32) -> Void
  Summary: Sorts a range of elements in a pair of System.Array objects (one contains the keys and the other contains the corresponding items) based on the keys in the first System.Array using the System.IComparable`1 generic interface implementation of each key.
  Parameters:
    - keys (TKey[]): The one-dimensional, zero-based System.Array that contains the keys to sort.
    - items (TValue[]): The one-dimensional, zero-based System.Array that contains the items that correspond to the keys in keys, or to sort only keys.
    - index (System.Int32): The starting index of the range to sort.
    - length (System.Int32): The number of elements in the range to sort.

Sort(TKey[], TValue[], Int32, Int32, IComparer) -> Void
  Summary: Sorts a range of elements in a pair of System.Array objects (one contains the keys and the other contains the corresponding items) based on the keys in the first System.Array using the specified System.Collections.Generic.IComparer`1 generic interface.
  Parameters:
    - keys (TKey[]): The one-dimensional, zero-based System.Array that contains the keys to sort.
    - items (TValue[]): The one-dimensional, zero-based System.Array that contains the items that correspond to the keys in keys, or to sort only keys.
    - index (System.Int32): The starting index of the range to sort.
    - length (System.Int32): The number of elements in the range to sort.
    - comparer (System.Collections.Generic.IComparer`1[TKey]): The System.Collections.Generic.IComparer`1 generic interface implementation to use when comparing elements, or to use the System.IComparable`1 generic interface implementation of each element.
"
  (cl:cond
    ((cl:and (cl:or (cl:null keys) (dotnet:object-type keys)) (cl:or (cl:null items) (dotnet:object-type items)) supplied-comparer (cl:numberp comparer) supplied-length (cl:numberp length) supplied-comparer2 (cl:or (cl:null comparer2) (dotnet:object-type comparer2)))
     (dotnet:static-generic <type-str> "Sort" (cl:list type-1 type-2) keys items comparer length comparer2))
    ((cl:and (cl:or (cl:null keys) (dotnet:object-type keys)) (cl:or (cl:null items) (dotnet:object-type items)) supplied-comparer (cl:numberp comparer) supplied-length (cl:numberp length) (cl:not supplied-comparer2))
     (dotnet:static-generic <type-str> "Sort" (cl:list type-1 type-2) keys items comparer length))
    ((cl:and (cl:or (cl:null keys) (dotnet:object-type keys)) (cl:or (cl:null items) (dotnet:object-type items)) supplied-comparer (cl:or (cl:null comparer) (dotnet:object-type comparer)) (cl:not supplied-length) (cl:not supplied-comparer2))
     (dotnet:static-generic <type-str> "Sort" (cl:list type-1 type-2) keys items comparer))
    ((cl:and (cl:or (cl:null keys) (dotnet:object-type keys)) (cl:or (cl:null items) (dotnet:object-type items)) (cl:not supplied-comparer) (cl:not supplied-length) (cl:not supplied-comparer2))
     (dotnet:static-generic <type-str> "Sort" (cl:list type-1 type-2) keys items))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARRAY"
                    :class-name <type-str>
                    :method-name "Sort"
                    :supplied-args (cl:append (cl:list :keys keys) (cl:list :items items) (cl:when supplied-comparer (cl:list :comparer comparer)) (cl:when supplied-length (cl:list :length length)) (cl:when supplied-comparer2 (cl:list :comparer2 comparer2)))))))

(cl:defun sort<> (types cl:&rest args)
  "Dispatches sort<> by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload.
   Passing cl:nil or an empty list calls the non-generic sort overload(s)."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (0 (cl:apply (cl:function sort) args))
      (1 (cl:apply (cl:function sort-arity-1) (cl:append type-list args)))
      (2 (cl:apply (cl:function sort-arity-2) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-ARRAY"
                      :class-name <type-str>
                      :method-name "sort<>"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

(cl:defun true-for-all (type array match)
  "Summary: Determines whether every element in the array matches the conditions defined by the specified predicate.
Returns: if every element in array matches the conditions defined by the specified predicate; otherwise, . If there are no elements in the array, the return value is .
Parameters:
  - array (T[]): The one-dimensional, zero-based System.Array to check against the conditions.
  - match (System.Predicate`1[T]): The predicate that defines the conditions to check against the elements.
"
  (dotnet:static-generic <type-str> "TrueForAll" (cl:list type) array match))

