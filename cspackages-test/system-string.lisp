;;; Generated automatically. Do not edit.
;;; Class: System.String
;;; Generator Version: 32
;;; Creation Date: 2026-07-05T03:30:42Z

(cl:in-package :system-string)

(cl:defconstant <type> (dotnet:resolve-type "System.String"))
(cl:defconstant <type-str> "System.String")
(cl:defconstant <creation> "2026-07-05T03:30:42Z")
(cl:defconstant <version> 32)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.String")))

(cl:defun new (value cl:&optional (count cl:nil supplied-count) (length cl:nil supplied-length) (enc cl:nil supplied-enc))
  "Master wrapper for System.String constructor overloads. Dispatches at runtime.

new(Char[])
  Summary: Initializes a new instance of the System.String class to the Unicode characters indicated in the specified character array.
  Parameters:
    - value (System.Char[]): An array of Unicode characters.

new(Char*)
  Summary: Initializes a new instance of the System.String class to the value indicated by a specified pointer to an array of Unicode characters.
  Parameters:
    - value (System.Char*): A pointer to a null-terminated array of Unicode characters.

new(SByte*)
  Summary: Initializes a new instance of the System.String class to the value indicated by a pointer to an array of 8-bit signed integers.
  Parameters:
    - value (System.SByte*): A pointer to a null-terminated array of 8-bit signed integers. The integers are interpreted using the current system code page encoding on Windows (referred to as CP_ACP) and as UTF-8 encoding on non-Windows.

new(Char])
  Summary: Initializes a new instance of the System.String class to the Unicode characters indicated in the specified read-only span.
  Parameters:
    - value (System.ReadOnlySpan`1[System.Char]): A read-only span of Unicode characters.

new(Char, Int32)
  Summary: Initializes a new instance of the System.String class to the value indicated by a specified Unicode character repeated a specified number of times.
  Parameters:
    - c (System.Char): A Unicode character.
    - count (System.Int32): The number of times c occurs.

new(Char[], Int32, Int32)
  Summary: Initializes a new instance of the System.String class to the value indicated by an array of Unicode characters, a starting character position within that array, and a length.
  Parameters:
    - value (System.Char[]): An array of Unicode characters.
    - start-index (System.Int32): The starting position within value.
    - length (System.Int32): The number of characters within value to use.

new(Char*, Int32, Int32)
  Summary: Initializes a new instance of the System.String class to the value indicated by a specified pointer to an array of Unicode characters, a starting character position within that array, and a length.
  Parameters:
    - value (System.Char*): A pointer to an array of Unicode characters.
    - start-index (System.Int32): The starting position within value.
    - length (System.Int32): The number of characters within value to use.

new(SByte*, Int32, Int32)
  Summary: Initializes a new instance of the System.String class to the value indicated by a specified pointer to an array of 8-bit signed integers, a starting position within that array, and a length.
  Parameters:
    - value (System.SByte*): A pointer to an array of 8-bit signed integers. The integers are interpreted using the current system code page encoding on Windows (referred to as CP_ACP) and as UTF-8 encoding on non-Windows.
    - start-index (System.Int32): The starting position within value.
    - length (System.Int32): The number of sbytes within value to use.

new(SByte*, Int32, Int32, Encoding)
  Summary: Initializes a new instance of the System.String class to the value indicated by a specified pointer to an array of 8-bit signed integers, a starting position within that array, a length, and an System.Text.Encoding object.
  Parameters:
    - value (System.SByte*): A pointer to an array of 8-bit signed integers.
    - start-index (System.Int32): The starting position within value.
    - length (System.Int32): The number of sbytes within value to use.
    - enc (System.Text.Encoding): An object that specifies how the array referenced by value is encoded. If enc is , ANSI encoding is assumed.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-count (cl:numberp count) supplied-length (cl:numberp length) supplied-enc (cl:or (cl:null enc) (dotnet:object-type enc)))
     (dotnet:new <type-str> value count length enc))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-count (cl:numberp count) supplied-length (cl:numberp length) (cl:not supplied-enc))
     (dotnet:new <type-str> value count length))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-count (cl:numberp count) supplied-length (cl:numberp length) (cl:not supplied-enc))
     (dotnet:new <type-str> value count length))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-count (cl:numberp count) supplied-length (cl:numberp length) (cl:not supplied-enc))
     (dotnet:new <type-str> value count length))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-count (cl:numberp count) (cl:not supplied-length) (cl:not supplied-enc))
     (dotnet:new <type-str> value count))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-count) (cl:not supplied-length) (cl:not supplied-enc))
     (dotnet:new <type-str> value))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-count) (cl:not supplied-length) (cl:not supplied-enc))
     (dotnet:new <type-str> value))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-count) (cl:not supplied-length) (cl:not supplied-enc))
     (dotnet:new <type-str> value))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-count) (cl:not supplied-length) (cl:not supplied-enc))
     (dotnet:new <type-str> value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-count (cl:list :count count)) (cl:when supplied-length (cl:list :length length)) (cl:when supplied-enc (cl:list :enc enc)))))))

(cl:define-symbol-macro empty (dotnet:static <type-str> "Empty"))
(cl:setf (cl:documentation (cl:quote empty) (cl:quote cl:variable)) "Represents the empty string. This field is read-only.")

(cl:defun chars (obj! index)
  (dotnet:invoke (cl:the (dotnet "System.String") obj!) "get_Chars" index))

(cl:defun length (obj!)
  "Gets the number of characters in the current System.String object."
  (dotnet:invoke (cl:the (dotnet "System.String") obj!) "get_Length"))

(cl:defun = (a b)
  "Summary: Determines whether two specified strings have the same value.
Returns: if the value of a is the same as the value of b; otherwise, .
Parameters:
  - a (System.String): The first string to compare, or .
  - b (System.String): The second string to compare, or .
"
  (dotnet:static <type-str> "op_Equality" (cl:the (dotnet "System.String") a) (cl:the (dotnet "System.String") b)))

(cl:defun clone (obj!)
  "Summary: Returns a reference to this instance of System.String.
Returns: This instance of System.String.
"
  (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Clone"))

(cl:defun compare (str-a str-b cl:&optional (ignore-case cl:nil supplied-ignore-case) (options cl:nil supplied-options) (length cl:nil supplied-length) (ignore-case2 cl:nil supplied-ignore-case2) (culture cl:nil supplied-culture))
  "Master wrapper for System.String.Compare overloads. Dispatches at runtime.

Compare(String, String) -> Int32
  Summary: Compares two specified System.String objects and returns an integer that indicates their relative position in the sort order.
  Returns: A 32-bit signed integer that indicates the lexical relationship between the two comparands. Value Condition Less than zerostrA precedes strB in the sort order. ZerostrA occurs in the same position as strB in the sort order. Greater than zerostrA follows strB in the sort order.
  Parameters:
    - str-a (System.String): The first string to compare.
    - str-b (System.String): The second string to compare.

Compare(String, String, Boolean) -> Int32
  Summary: Compares two specified System.String objects, ignoring or honoring their case, and returns an integer that indicates their relative position in the sort order.
  Returns: A 32-bit signed integer that indicates the lexical relationship between the two comparands. Value Condition Less than zerostrA precedes strB in the sort order. ZerostrA occurs in the same position as strB in the sort order. Greater than zerostrA follows strB in the sort order.
  Parameters:
    - str-a (System.String): The first string to compare.
    - str-b (System.String): The second string to compare.
    - ignore-case (System.Boolean): to ignore case during the comparison; otherwise, .

Compare(String, String, StringComparison) -> Int32
  Summary: Compares two specified System.String objects using the specified rules, and returns an integer that indicates their relative position in the sort order.
  Returns: A 32-bit signed integer that indicates the lexical relationship between the two comparands. Value Condition Less than zerostrA precedes strB in the sort order. ZerostrA is in the same position as strB in the sort order. Greater than zerostrA follows strB in the sort order.
  Parameters:
    - str-a (System.String): The first string to compare.
    - str-b (System.String): The second string to compare.
    - comparison-type (System.StringComparison): One of the enumeration values that specifies the rules to use in the comparison.

Compare(String, String, CultureInfo, CompareOptions) -> Int32
  Summary: Compares two specified System.String objects using the specified comparison options and culture-specific information to influence the comparison, and returns an integer that indicates the relationship of the two strings to each other in the sort order.
  Returns: A 32-bit signed integer that indicates the lexical relationship between strA and strB, as shown in the following table Value Condition Less than zerostrA precedes strB in the sort order. ZerostrA occurs in the same position as strB in the sort order. Greater than zerostrA follows strB in the sort order.
  Parameters:
    - str-a (System.String): The first string to compare.
    - str-b (System.String): The second string to compare.
    - culture (System.Globalization.CultureInfo): The culture that supplies culture-specific comparison information. If culture is , the current culture is used.
    - options (System.Globalization.CompareOptions): Options to use when performing the comparison (such as ignoring case or symbols).

Compare(String, String, Boolean, CultureInfo) -> Int32
  Summary: Compares two specified System.String objects, ignoring or honoring their case, and using culture-specific information to influence the comparison, and returns an integer that indicates their relative position in the sort order.
  Returns: A 32-bit signed integer that indicates the lexical relationship between the two comparands. Value Condition Less than zerostrA precedes strB in the sort order. ZerostrA occurs in the same position as strB in the sort order. Greater than zerostrA follows strB in the sort order.
  Parameters:
    - str-a (System.String): The first string to compare.
    - str-b (System.String): The second string to compare.
    - ignore-case (System.Boolean): to ignore case during the comparison; otherwise, .
    - culture (System.Globalization.CultureInfo): An object that supplies culture-specific comparison information. If culture is , the current culture is used.

Compare(String, Int32, String, Int32, Int32) -> Int32
  Summary: Compares substrings of two specified System.String objects and returns an integer that indicates their relative position in the sort order.
  Returns: A 32-bit signed integer indicating the lexical relationship between the two comparands. Value Condition Less than zero The substring in strA precedes the substring in strB in the sort order. Zero The substrings occur in the same position in the sort order, or length is zero. Greater than zero The substring in strA follows the substring in strB in the sort order.
  Parameters:
    - str-a (System.String): The first string to use in the comparison.
    - index-a (System.Int32): The position of the substring within strA.
    - str-b (System.String): The second string to use in the comparison.
    - index-b (System.Int32): The position of the substring within strB.
    - length (System.Int32): The maximum number of characters in the substrings to compare.

Compare(String, Int32, String, Int32, Int32, Boolean) -> Int32
  Summary: Compares substrings of two specified System.String objects, ignoring or honoring their case, and returns an integer that indicates their relative position in the sort order.
  Returns: A 32-bit signed integer that indicates the lexical relationship between the two comparands. Value Condition Less than zero The substring in strA precedes the substring in strB in the sort order. Zero The substrings occur in the same position in the sort order, or length is zero. Greater than zero The substring in strA follows the substring in strB in the sort order.
  Parameters:
    - str-a (System.String): The first string to use in the comparison.
    - index-a (System.Int32): The position of the substring within strA.
    - str-b (System.String): The second string to use in the comparison.
    - index-b (System.Int32): The position of the substring within strB.
    - length (System.Int32): The maximum number of characters in the substrings to compare.
    - ignore-case (System.Boolean): to ignore case during the comparison; otherwise, .

Compare(String, Int32, String, Int32, Int32, StringComparison) -> Int32
  Summary: Compares substrings of two specified System.String objects using the specified rules, and returns an integer that indicates their relative position in the sort order.
  Returns: A 32-bit signed integer that indicates the lexical relationship between the two comparands. Value Condition Less than zero The substring in strA precedes the substring in strB in the sort order. Zero The substrings occur in the same position in the sort order, or the length parameter is zero. Greater than zero The substring in strA follows the substring in strB in the sort order.
  Parameters:
    - str-a (System.String): The first string to use in the comparison.
    - index-a (System.Int32): The position of the substring within strA.
    - str-b (System.String): The second string to use in the comparison.
    - index-b (System.Int32): The position of the substring within strB.
    - length (System.Int32): The maximum number of characters in the substrings to compare.
    - comparison-type (System.StringComparison): One of the enumeration values that specifies the rules to use in the comparison.

Compare(String, Int32, String, Int32, Int32, Boolean, CultureInfo) -> Int32
  Summary: Compares substrings of two specified System.String objects, ignoring or honoring their case and using culture-specific information to influence the comparison, and returns an integer that indicates their relative position in the sort order.
  Returns: An integer that indicates the lexical relationship between the two comparands. Value Condition Less than zero The substring in strA precedes the substring in strB in the sort order. Zero The substrings occur in the same position in the sort order, or length is zero. Greater than zero The substring in strA follows the substring in strB in the sort order.
  Parameters:
    - str-a (System.String): The first string to use in the comparison.
    - index-a (System.Int32): The position of the substring within strA.
    - str-b (System.String): The second string to use in the comparison.
    - index-b (System.Int32): The position of the substring within strB.
    - length (System.Int32): The maximum number of characters in the substrings to compare.
    - ignore-case (System.Boolean): to ignore case during the comparison; otherwise, .
    - culture (System.Globalization.CultureInfo): An object that supplies culture-specific comparison information. If culture is , the current culture is used.

Compare(String, Int32, String, Int32, Int32, CultureInfo, CompareOptions) -> Int32
  Summary: Compares substrings of two specified System.String objects using the specified comparison options and culture-specific information to influence the comparison, and returns an integer that indicates the relationship of the two substrings to each other in the sort order.
  Returns: An integer that indicates the lexical relationship between the two substrings, as shown in the following table. Value Condition Less than zero The substring in strA precedes the substring in strB in the sort order. Zero The substrings occur in the same position in the sort order, or length is zero. Greater than zero The substring in strA follows the substring in strB in the sort order.
  Parameters:
    - str-a (System.String): The first string to use in the comparison.
    - index-a (System.Int32): The starting position of the substring within strA.
    - str-b (System.String): The second string to use in the comparison.
    - index-b (System.Int32): The starting position of the substring within strB.
    - length (System.Int32): The maximum number of characters in the substrings to compare.
    - culture (System.Globalization.CultureInfo): An object that supplies culture-specific comparison information. If culture is , the current culture is used.
    - options (System.Globalization.CompareOptions): Options to use when performing the comparison (such as ignoring case or symbols).
"
  (cl:cond
    ((cl:and (cl:stringp str-a) (cl:numberp str-b) supplied-ignore-case (cl:stringp ignore-case) supplied-options (cl:numberp options) supplied-length (cl:numberp length) supplied-ignore-case2 (cl:typep ignore-case2 'cl:boolean) supplied-culture (cl:or (cl:null culture) (dotnet:object-type culture)))
     (dotnet:static <type-str> "Compare" str-a str-b ignore-case options length ignore-case2 culture))
    ((cl:and (cl:stringp str-a) (cl:numberp str-b) supplied-ignore-case (cl:stringp ignore-case) supplied-options (cl:numberp options) supplied-length (cl:numberp length) supplied-ignore-case2 (cl:or (cl:null ignore-case2) (dotnet:object-type ignore-case2)) supplied-culture (cl:or (cl:null culture) (dotnet:object-type culture)))
     (dotnet:static <type-str> "Compare" str-a str-b ignore-case options length ignore-case2 culture))
    ((cl:and (cl:stringp str-a) (cl:numberp str-b) supplied-ignore-case (cl:stringp ignore-case) supplied-options (cl:numberp options) supplied-length (cl:numberp length) supplied-ignore-case2 (cl:typep ignore-case2 'cl:boolean) (cl:not supplied-culture))
     (dotnet:static <type-str> "Compare" str-a str-b ignore-case options length ignore-case2))
    ((cl:and (cl:stringp str-a) (cl:numberp str-b) supplied-ignore-case (cl:stringp ignore-case) supplied-options (cl:numberp options) supplied-length (cl:numberp length) supplied-ignore-case2 (cl:or (cl:null ignore-case2) (dotnet:object-type ignore-case2)) (cl:not supplied-culture))
     (dotnet:static <type-str> "Compare" str-a str-b ignore-case options length ignore-case2))
    ((cl:and (cl:stringp str-a) (cl:numberp str-b) supplied-ignore-case (cl:stringp ignore-case) supplied-options (cl:numberp options) supplied-length (cl:numberp length) (cl:not supplied-ignore-case2) (cl:not supplied-culture))
     (dotnet:static <type-str> "Compare" str-a str-b ignore-case options length))
    ((cl:and (cl:stringp str-a) (cl:stringp str-b) supplied-ignore-case (cl:or (cl:null ignore-case) (dotnet:object-type ignore-case)) supplied-options (cl:or (cl:null options) (dotnet:object-type options)) (cl:not supplied-length) (cl:not supplied-ignore-case2) (cl:not supplied-culture))
     (dotnet:static <type-str> "Compare" str-a str-b ignore-case options))
    ((cl:and (cl:stringp str-a) (cl:stringp str-b) supplied-ignore-case (cl:typep ignore-case 'cl:boolean) supplied-options (cl:or (cl:null options) (dotnet:object-type options)) (cl:not supplied-length) (cl:not supplied-ignore-case2) (cl:not supplied-culture))
     (dotnet:static <type-str> "Compare" str-a str-b ignore-case options))
    ((cl:and (cl:stringp str-a) (cl:stringp str-b) supplied-ignore-case (cl:typep ignore-case 'cl:boolean) (cl:not supplied-options) (cl:not supplied-length) (cl:not supplied-ignore-case2) (cl:not supplied-culture))
     (dotnet:static <type-str> "Compare" str-a str-b ignore-case))
    ((cl:and (cl:stringp str-a) (cl:stringp str-b) supplied-ignore-case (cl:or (cl:null ignore-case) (dotnet:object-type ignore-case)) (cl:not supplied-options) (cl:not supplied-length) (cl:not supplied-ignore-case2) (cl:not supplied-culture))
     (dotnet:static <type-str> "Compare" str-a str-b ignore-case))
    ((cl:and (cl:stringp str-a) (cl:stringp str-b) (cl:not supplied-ignore-case) (cl:not supplied-options) (cl:not supplied-length) (cl:not supplied-ignore-case2) (cl:not supplied-culture))
     (dotnet:static <type-str> "Compare" str-a str-b))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "Compare"
                    :supplied-args (cl:append (cl:list :str-a str-a) (cl:list :str-b str-b) (cl:when supplied-ignore-case (cl:list :ignore-case ignore-case)) (cl:when supplied-options (cl:list :options options)) (cl:when supplied-length (cl:list :length length)) (cl:when supplied-ignore-case2 (cl:list :ignore-case2 ignore-case2)) (cl:when supplied-culture (cl:list :culture culture)))))))

(cl:defun compare-ordinal (str-a str-b cl:&optional (str-b2 cl:nil supplied-str-b2) (index-b cl:nil supplied-index-b) (length cl:nil supplied-length))
  "Master wrapper for System.String.CompareOrdinal overloads. Dispatches at runtime.

CompareOrdinal(String, String) -> Int32
  Summary: Compares two specified System.String objects by evaluating the numeric values of the corresponding System.Char objects in each string.
  Returns: An integer that indicates the lexical relationship between the two comparands. Value Condition Less than zerostrA is less than strB. ZerostrA and strB are equal. Greater than zerostrA is greater than strB.
  Parameters:
    - str-a (System.String): The first string to compare.
    - str-b (System.String): The second string to compare.

CompareOrdinal(String, Int32, String, Int32, Int32) -> Int32
  Summary: Compares substrings of two specified System.String objects by evaluating the numeric values of the corresponding System.Char objects in each substring.
  Returns: A 32-bit signed integer that indicates the lexical relationship between the two comparands. Value Condition Less than zero The substring in strA is less than the substring in strB. Zero The substrings are equal, or length is zero. Greater than zero The substring in strA is greater than the substring in strB.
  Parameters:
    - str-a (System.String): The first string to use in the comparison.
    - index-a (System.Int32): The starting index of the substring in strA.
    - str-b (System.String): The second string to use in the comparison.
    - index-b (System.Int32): The starting index of the substring in strB.
    - length (System.Int32): The maximum number of characters in the substrings to compare.
"
  (cl:cond
    ((cl:and (cl:stringp str-a) (cl:numberp str-b) supplied-str-b2 (cl:stringp str-b2) supplied-index-b (cl:numberp index-b) supplied-length (cl:numberp length))
     (dotnet:static <type-str> "CompareOrdinal" str-a str-b str-b2 index-b length))
    ((cl:and (cl:stringp str-a) (cl:stringp str-b) (cl:not supplied-str-b2) (cl:not supplied-index-b) (cl:not supplied-length))
     (dotnet:static <type-str> "CompareOrdinal" str-a str-b))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "CompareOrdinal"
                    :supplied-args (cl:append (cl:list :str-a str-a) (cl:list :str-b str-b) (cl:when supplied-str-b2 (cl:list :str-b2 str-b2)) (cl:when supplied-index-b (cl:list :index-b index-b)) (cl:when supplied-length (cl:list :length length)))))))

(cl:defun compare-to (obj! value)
  "Master wrapper for System.String.CompareTo overloads. Dispatches at runtime.

CompareTo(Object) -> Int32
  Summary: Compares this instance with a specified System.Object and indicates whether this instance precedes, follows, or appears in the same position in the sort order as the specified System.Object.
  Returns: A 32-bit signed integer that indicates whether this instance precedes, follows, or appears in the same position in the sort order as the value parameter. Value Condition Less than zero This instance precedes value. Zero This instance has the same position in the sort order as value. Greater than zero This instance follows value. -or- value is .
  Parameters:
    - value (System.Object): An object that evaluates to a System.String.

CompareTo(String) -> Int32
  Summary: Compares this instance with a specified System.String object and indicates whether this instance precedes, follows, or appears in the same position in the sort order as the specified string.
  Returns: A 32-bit signed integer that indicates whether this instance precedes, follows, or appears in the same position in the sort order as the strB parameter. Value Condition Less than zero This instance precedes strB. Zero This instance has the same position in the sort order as strB. Greater than zero This instance follows strB. -or- strB is .
  Parameters:
    - str-b (System.String): The string to compare with this instance.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "CompareTo" value))
    ((cl:and (cl:stringp value))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "CompareTo" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "CompareTo"
                    :supplied-args (cl:append (cl:list :value value))))))

(cl:defun concat (arg0 cl:&optional (arg1 cl:nil supplied-arg1) (arg2 cl:nil supplied-arg2) (str3 cl:nil supplied-str3))
  "Master wrapper for System.String.Concat overloads. Dispatches at runtime.

Concat(Object) -> String
  Summary: Creates the string representation of a specified object.
  Returns: The string representation of the value of arg0, or System.String.Empty if arg0 is .
  Parameters:
    - arg0 (System.Object): The object to represent, or .

Concat(Object]) -> String
  Summary: Concatenates the string representations of the elements in a specified span of objects.
  Returns: The concatenated string representations of the values of the elements in args.
  Parameters:
    - args (System.ReadOnlySpan`1[System.Object]): A span of objects that contains the elements to concatenate.

Concat(String]) -> String
  Summary: Concatenates the members of a constructed System.Collections.Generic.IEnumerable`1 collection of type System.String.
  Returns: The concatenated strings in values, or System.String.Empty if values is an empty .
  Parameters:
    - values (System.Collections.Generic.IEnumerable`1[System.String]): A collection object that implements System.Collections.Generic.IEnumerable`1 and whose generic type argument is System.String.

Concat(String]) -> String
  Summary: Concatenates the elements of a specified span of System.String.
  Returns: The concatenated elements of values.
  Parameters:
    - values (System.ReadOnlySpan`1[System.String]): A span of System.String instances.

Concat(Object, Object) -> String
  Summary: Concatenates the string representations of two specified objects.
  Returns: The concatenated string representations of the values of arg0 and arg1.
  Parameters:
    - arg0 (System.Object): The first object to concatenate.
    - arg1 (System.Object): The second object to concatenate.

Concat(String, String) -> String
  Summary: Concatenates two specified instances of System.String.
  Returns: The concatenation of str0 and str1.
  Parameters:
    - str0 (System.String): The first string to concatenate.
    - str1 (System.String): The second string to concatenate.

Concat(Char], Char]) -> String
  Summary: Concatenates the string representations of two specified read-only character spans.
  Returns: The concatenated string representations of the values of str0 and str1.
  Parameters:
    - str0 (System.ReadOnlySpan`1[System.Char]): The first read-only character span to concatenate.
    - str1 (System.ReadOnlySpan`1[System.Char]): The second read-only character span to concatenate.

Concat(Object, Object, Object) -> String
  Summary: Concatenates the string representations of three specified objects.
  Returns: The concatenated string representations of the values of arg0, arg1, and arg2.
  Parameters:
    - arg0 (System.Object): The first object to concatenate.
    - arg1 (System.Object): The second object to concatenate.
    - arg2 (System.Object): The third object to concatenate.

Concat(String, String, String) -> String
  Summary: Concatenates three specified instances of System.String.
  Returns: The concatenation of str0, str1, and str2.
  Parameters:
    - str0 (System.String): The first string to concatenate.
    - str1 (System.String): The second string to concatenate.
    - str2 (System.String): The third string to concatenate.

Concat(Char], Char], Char]) -> String
  Summary: Concatenates the string representations of three specified read-only character spans.
  Returns: The concatenated string representations of the values of str0, str1 and str2.
  Parameters:
    - str0 (System.ReadOnlySpan`1[System.Char]): The first read-only character span to concatenate.
    - str1 (System.ReadOnlySpan`1[System.Char]): The second read-only character span to concatenate.
    - str2 (System.ReadOnlySpan`1[System.Char]): The third read-only character span to concatenate.

Concat(String, String, String, String) -> String
  Summary: Concatenates four specified instances of System.String.
  Returns: The concatenation of str0, str1, str2, and str3.
  Parameters:
    - str0 (System.String): The first string to concatenate.
    - str1 (System.String): The second string to concatenate.
    - str2 (System.String): The third string to concatenate.
    - str3 (System.String): The fourth string to concatenate.

Concat(Char], Char], Char], Char]) -> String
  Summary: Concatenates the string representations of four specified read-only character spans.
  Returns: The concatenated string representations of the values of str0, str1, str2 and str3.
  Parameters:
    - str0 (System.ReadOnlySpan`1[System.Char]): The first read-only character span to concatenate.
    - str1 (System.ReadOnlySpan`1[System.Char]): The second read-only character span to concatenate.
    - str2 (System.ReadOnlySpan`1[System.Char]): The third read-only character span to concatenate.
    - str3 (System.ReadOnlySpan`1[System.Char]): The fourth read-only character span to concatenate.
"
  (cl:cond
    ((cl:and (cl:stringp arg0) supplied-arg1 (cl:stringp arg1) supplied-arg2 (cl:stringp arg2) supplied-str3 (cl:stringp str3))
     (dotnet:static <type-str> "Concat" arg0 arg1 arg2 str3))
    ((cl:and (cl:or (cl:null arg0) (dotnet:object-type arg0)) supplied-arg1 (cl:or (cl:null arg1) (dotnet:object-type arg1)) supplied-arg2 (cl:or (cl:null arg2) (dotnet:object-type arg2)) supplied-str3 (cl:or (cl:null str3) (dotnet:object-type str3)))
     (dotnet:static <type-str> "Concat" arg0 arg1 arg2 str3))
    ((cl:and (cl:or (cl:null arg0) (dotnet:object-type arg0)) supplied-arg1 (cl:or (cl:null arg1) (dotnet:object-type arg1)) supplied-arg2 (cl:or (cl:null arg2) (dotnet:object-type arg2)) (cl:not supplied-str3))
     (dotnet:static <type-str> "Concat" arg0 arg1 arg2))
    ((cl:and (cl:stringp arg0) supplied-arg1 (cl:stringp arg1) supplied-arg2 (cl:stringp arg2) (cl:not supplied-str3))
     (dotnet:static <type-str> "Concat" arg0 arg1 arg2))
    ((cl:and (cl:or (cl:null arg0) (dotnet:object-type arg0)) supplied-arg1 (cl:or (cl:null arg1) (dotnet:object-type arg1)) supplied-arg2 (cl:or (cl:null arg2) (dotnet:object-type arg2)) (cl:not supplied-str3))
     (dotnet:static <type-str> "Concat" arg0 arg1 arg2))
    ((cl:and (cl:or (cl:null arg0) (dotnet:object-type arg0)) supplied-arg1 (cl:or (cl:null arg1) (dotnet:object-type arg1)) (cl:not supplied-arg2) (cl:not supplied-str3))
     (dotnet:static <type-str> "Concat" arg0 arg1))
    ((cl:and (cl:stringp arg0) supplied-arg1 (cl:stringp arg1) (cl:not supplied-arg2) (cl:not supplied-str3))
     (dotnet:static <type-str> "Concat" arg0 arg1))
    ((cl:and (cl:or (cl:null arg0) (dotnet:object-type arg0)) supplied-arg1 (cl:or (cl:null arg1) (dotnet:object-type arg1)) (cl:not supplied-arg2) (cl:not supplied-str3))
     (dotnet:static <type-str> "Concat" arg0 arg1))
    ((cl:and (cl:or (cl:null arg0) (dotnet:object-type arg0)) (cl:not supplied-arg1) (cl:not supplied-arg2) (cl:not supplied-str3))
     (dotnet:static <type-str> "Concat" arg0))
    ((cl:and (cl:or (cl:null arg0) (dotnet:object-type arg0)) (cl:not supplied-arg1) (cl:not supplied-arg2) (cl:not supplied-str3))
     (dotnet:static <type-str> "Concat" arg0))
    ((cl:and (cl:or (cl:null arg0) (dotnet:object-type arg0)) (cl:not supplied-arg1) (cl:not supplied-arg2) (cl:not supplied-str3))
     (dotnet:static <type-str> "Concat" arg0))
    ((cl:and (cl:or (cl:null arg0) (dotnet:object-type arg0)) (cl:not supplied-arg1) (cl:not supplied-arg2) (cl:not supplied-str3))
     (dotnet:static <type-str> "Concat" arg0))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "Concat"
                    :supplied-args (cl:append (cl:list :arg0 arg0) (cl:when supplied-arg1 (cl:list :arg1 arg1)) (cl:when supplied-arg2 (cl:list :arg2 arg2)) (cl:when supplied-str3 (cl:list :str3 str3)))))))

(cl:defun concat-arity-1 (type values)
  "Summary: Concatenates the members of an System.Collections.Generic.IEnumerable`1 implementation.
Returns: The concatenated members in values.
Parameters:
  - values (System.Collections.Generic.IEnumerable`1[T]): A collection object that implements the System.Collections.Generic.IEnumerable`1 interface.
"
  (dotnet:static-generic <type-str> "Concat" (cl:list type) values))

(cl:defun concat<> (types cl:&rest args)
  "Dispatches concat<> by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload.
   Passing cl:nil or an empty list calls the non-generic concat overload(s)."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (0 (cl:apply (cl:function concat) args))
      (1 (cl:apply (cl:function concat-arity-1) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-STRING"
                      :class-name <type-str>
                      :method-name "concat<>"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

;; Note: System.String.Concat also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   Concat(params Object[]) -> String
;;   Concat(params String[]) -> String

(cl:defun contains (obj! value cl:&optional (comparison-type cl:nil supplied-comparison-type))
  "Master wrapper for System.String.Contains overloads. Dispatches at runtime.

Contains(String) -> Boolean
  Summary: Returns a value indicating whether a specified substring occurs within this string.
  Returns: if the value parameter occurs within this string, or if value is the empty string (\"\"); otherwise, .
  Parameters:
    - value (System.String): The string to seek.

Contains(Char) -> Boolean
  Summary: Returns a value indicating whether a specified character occurs within this string.
  Returns: if the value parameter occurs within this string; otherwise, .
  Parameters:
    - value (System.Char): The character to seek.

Contains(String, StringComparison) -> Boolean
  Summary: Returns a value indicating whether a specified string occurs within this string, using the specified comparison rules.
  Returns: if the value parameter occurs within this string, or if value is the empty string (\"\"); otherwise, .
  Parameters:
    - value (System.String): The string to seek.
    - comparison-type (System.StringComparison): One of the enumeration values that specifies the rules to use in the comparison.

Contains(Char, StringComparison) -> Boolean
  Summary: Returns a value indicating whether a specified character occurs within this string, using the specified comparison rules.
  Returns: if the value parameter occurs within this string; otherwise, .
  Parameters:
    - value (System.Char): The character to seek.
    - comparison-type (System.StringComparison): One of the enumeration values that specifies the rules to use in the comparison.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-comparison-type (cl:or (cl:null comparison-type) (dotnet:object-type comparison-type)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Contains" value comparison-type))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-comparison-type (cl:or (cl:null comparison-type) (dotnet:object-type comparison-type)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Contains" value comparison-type))
    ((cl:and (cl:stringp value) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Contains" value))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Contains" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "Contains"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-comparison-type (cl:list :comparison-type comparison-type)))))))

(cl:defun copy (str)
  "Summary: Creates a new instance of System.String with the same value as a specified System.String.
Returns: A new string with the same value as str.
Parameters:
  - str (System.String): The string to copy.
"
  (dotnet:static <type-str> "Copy" (cl:the (dotnet "System.String") str)))

(cl:defun copy-to (obj! destination cl:&optional (destination2 cl:nil supplied-destination2) (destination-index cl:nil supplied-destination-index) (count cl:nil supplied-count))
  "Master wrapper for System.String.CopyTo overloads. Dispatches at runtime.

CopyTo(Char]) -> Void
  Summary: Copies the contents of this string into the destination span.
  Parameters:
    - destination (System.Span`1[System.Char]): The span into which to copy this string's contents.

CopyTo(Int32, Char[], Int32, Int32) -> Void
  Summary: Copies a specified number of characters from a specified position in this instance to a specified position in an array of Unicode characters.
  Parameters:
    - source-index (System.Int32): The index of the first character in this instance to copy.
    - destination (System.Char[]): An array of Unicode characters to which characters in this instance are copied.
    - destination-index (System.Int32): The index in destination at which the copy operation begins.
    - count (System.Int32): The number of characters in this instance to copy to destination.
"
  (cl:cond
    ((cl:and (cl:numberp destination) supplied-destination2 (cl:or (cl:null destination2) (dotnet:object-type destination2)) supplied-destination-index (cl:numberp destination-index) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "CopyTo" destination destination2 destination-index count))
    ((cl:and (cl:or (cl:null destination) (dotnet:object-type destination)) (cl:not supplied-destination2) (cl:not supplied-destination-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "CopyTo" destination))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "CopyTo"
                    :supplied-args (cl:append (cl:list :destination destination) (cl:when supplied-destination2 (cl:list :destination2 destination2)) (cl:when supplied-destination-index (cl:list :destination-index destination-index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun create (type length state action)
  "Summary: Creates a new string with a specific length and initializes it after creation by using the specified callback.
Returns: The created string.
Parameters:
  - length (System.Int32): The length of the string to create.
  - state (TState): The element to pass to action.
  - action (System.Buffers.SpanAction`2[System.Char, TState]): A callback to initialize the string.
"
  (dotnet:static-generic <type-str> "Create" (cl:list type) length state action))

;; Note: System.String.Create also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   Create(IFormatProvider, ref DefaultInterpolatedStringHandler&) -> String
;;   Create(IFormatProvider, Char], ref DefaultInterpolatedStringHandler&) -> String

(cl:defun ends-with (obj! value cl:&optional (comparison-type cl:nil supplied-comparison-type) (culture cl:nil supplied-culture))
  "Master wrapper for System.String.EndsWith overloads. Dispatches at runtime.

EndsWith(String) -> Boolean
  Summary: Determines whether the end of this string instance matches the specified string.
  Returns: if value matches the end of this instance; otherwise, .
  Parameters:
    - value (System.String): The string to compare to the substring at the end of this instance.

EndsWith(Char) -> Boolean
  Summary: Determines whether the end of this string instance matches the specified character.
  Returns: if value matches the end of this instance; otherwise, .
  Parameters:
    - value (System.Char): The character to compare to the character at the end of this instance.

EndsWith(String, StringComparison) -> Boolean
  Summary: Determines whether the end of this string instance matches the specified string when compared using the specified comparison option.
  Returns: if the value parameter matches the end of this string; otherwise, .
  Parameters:
    - value (System.String): The string to compare to the substring at the end of this instance.
    - comparison-type (System.StringComparison): One of the enumeration values that determines how this string and value are compared.

EndsWith(String, Boolean, CultureInfo) -> Boolean
  Summary: Determines whether the end of this string instance matches the specified string when compared using the specified culture.
  Returns: if the value parameter matches the end of this string; otherwise, .
  Parameters:
    - value (System.String): The string to compare to the substring at the end of this instance.
    - ignore-case (System.Boolean): to ignore case during the comparison; otherwise, .
    - culture (System.Globalization.CultureInfo): Cultural information that determines how this instance and value are compared. If culture is , the current culture is used.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-comparison-type (cl:typep comparison-type 'cl:boolean) supplied-culture (cl:or (cl:null culture) (dotnet:object-type culture)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "EndsWith" value comparison-type culture))
    ((cl:and (cl:stringp value) supplied-comparison-type (cl:or (cl:null comparison-type) (dotnet:object-type comparison-type)) (cl:not supplied-culture))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "EndsWith" value comparison-type))
    ((cl:and (cl:stringp value) (cl:not supplied-comparison-type) (cl:not supplied-culture))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "EndsWith" value))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-comparison-type) (cl:not supplied-culture))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "EndsWith" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "EndsWith"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-comparison-type (cl:list :comparison-type comparison-type)) (cl:when supplied-culture (cl:list :culture culture)))))))

(cl:defun enumerate-runes (obj!)
  "Summary: Returns an enumeration of System.Text.Rune from this string.
Returns: A string rune enumerator.
"
  (dotnet:invoke (cl:the (dotnet "System.String") obj!) "EnumerateRunes"))

(cl:defun equals (obj! obj cl:&optional (comparison-type cl:nil supplied-comparison-type))
  "Master wrapper for System.String.Equals overloads. Dispatches at runtime.

Equals(Object) -> Boolean
  Summary: Determines whether this instance and a specified object, which must also be a System.String object, have the same value.
  Returns: if obj is a System.String and its value is the same as this instance; otherwise, . If obj is , the method returns .
  Parameters:
    - obj (System.Object): The string to compare to this instance.

Equals(String) -> Boolean
  Summary: Determines whether this instance and another specified System.String object have the same value.
  Returns: if the value of the value parameter is the same as the value of this instance; otherwise, . If value is , the method returns .
  Parameters:
    - value (System.String): The string to compare to this instance.

Equals(String, StringComparison) -> Boolean
  Summary: Determines whether this string and a specified System.String object have the same value. A parameter specifies the culture, case, and sort rules used in the comparison.
  Returns: if the value of the value parameter is the same as this string; otherwise, .
  Parameters:
    - value (System.String): The string to compare to this instance.
    - comparison-type (System.StringComparison): One of the enumeration values that specifies how the strings will be compared.
"
  (cl:cond
    ((cl:and (cl:stringp obj) supplied-comparison-type (cl:or (cl:null comparison-type) (dotnet:object-type comparison-type)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Equals" obj comparison-type))
    ((cl:and (cl:stringp obj) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Equals" obj))
    ((cl:and (cl:or (cl:null obj) (dotnet:object-type obj)) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Equals" obj))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "Equals"
                    :supplied-args (cl:append (cl:list :obj obj) (cl:when supplied-comparison-type (cl:list :comparison-type comparison-type)))))))

(cl:defun equals* (a b cl:&optional (comparison-type cl:nil supplied-comparison-type))
  "Master wrapper for System.String.Equals overloads. Dispatches at runtime.

Equals(String, String) -> Boolean
  Summary: Determines whether two specified System.String objects have the same value.
  Returns: if the value of a is the same as the value of b; otherwise, . If both a and b are , the method returns .
  Parameters:
    - a (System.String): The first string to compare, or .
    - b (System.String): The second string to compare, or .

Equals(String, String, StringComparison) -> Boolean
  Summary: Determines whether two specified System.String objects have the same value. A parameter specifies the culture, case, and sort rules used in the comparison.
  Returns: if the value of the a parameter is equal to the value of the b parameter; otherwise, .
  Parameters:
    - a (System.String): The first string to compare, or .
    - b (System.String): The second string to compare, or .
    - comparison-type (System.StringComparison): One of the enumeration values that specifies the rules for the comparison.
"
  (cl:cond
    ((cl:and (cl:stringp a) (cl:stringp b) supplied-comparison-type (cl:or (cl:null comparison-type) (dotnet:object-type comparison-type)))
     (dotnet:static <type-str> "Equals" a b comparison-type))
    ((cl:and (cl:stringp a) (cl:stringp b) (cl:not supplied-comparison-type))
     (dotnet:static <type-str> "Equals" a b))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "Equals"
                    :supplied-args (cl:append (cl:list :a a) (cl:list :b b) (cl:when supplied-comparison-type (cl:list :comparison-type comparison-type)))))))

(cl:defun format (format arg0 cl:&optional (arg1 cl:nil supplied-arg1) (arg2 cl:nil supplied-arg2) (arg22 cl:nil supplied-arg22))
  "Master wrapper for System.String.Format overloads. Dispatches at runtime.

Format(String, Object) -> String
  Summary: Replaces one or more format items in a string with the string representation of a specified object.
  Returns: A copy of format in which any format items are replaced by the string representation of arg0.
  Parameters:
    - format (System.String): A composite format string.
    - arg0 (System.Object): The object to format.

Format(String, Object]) -> String
  Summary: Replaces the format item in a specified string with the string representation of a corresponding object in a specified span.
  Returns: A copy of format in which the format items have been replaced by the string representation of the corresponding objects in args.
  Parameters:
    - format (System.String): A composite format string.
    - args (System.ReadOnlySpan`1[System.Object]): An object span that contains zero or more objects to format.

Format(String, Object, Object) -> String
  Summary: Replaces the format items in a string with the string representation of two specified objects.
  Returns: A copy of format in which format items are replaced by the string representations of arg0 and arg1.
  Parameters:
    - format (System.String): A composite format string.
    - arg0 (System.Object): The first object to format.
    - arg1 (System.Object): The second object to format.

Format(IFormatProvider, String, Object) -> String
  Summary: Replaces the format item or items in a specified string with the string representation of the corresponding object. A parameter supplies culture-specific formatting information.
  Returns: A copy of format in which the format item or items have been replaced by the string representation of arg0.
  Parameters:
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
    - format (System.String): A composite format string.
    - arg0 (System.Object): The object to format.

Format(IFormatProvider, String, Object]) -> String
  Summary: Replaces the format items in a string with the string representations of corresponding objects in a specified span. A parameter supplies culture-specific formatting information.
  Returns: A copy of format in which the format items have been replaced by the string representation of the corresponding objects in args.
  Parameters:
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
    - format (System.String): A composite format string.
    - args (System.ReadOnlySpan`1[System.Object]): An object span that contains zero or more objects to format.

Format(IFormatProvider, CompositeFormat, Object]) -> String
  Summary: Replaces the format item or items in a System.Text.CompositeFormat with the string representation of the corresponding objects in the specified format.
  Returns: The formatted string.
  Parameters:
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
    - format (System.Text.CompositeFormat): A System.Text.CompositeFormat.
    - args (System.ReadOnlySpan`1[System.Object]): A span of objects to format.

Format(String, Object, Object, Object) -> String
  Summary: Replaces the format items in a string with the string representation of three specified objects.
  Returns: A copy of format in which the format items have been replaced by the string representations of arg0, arg1, and arg2.
  Parameters:
    - format (System.String): A composite format string.
    - arg0 (System.Object): The first object to format.
    - arg1 (System.Object): The second object to format.
    - arg2 (System.Object): The third object to format.

Format(IFormatProvider, String, Object, Object) -> String
  Summary: Replaces the format items in a string with the string representation of two specified objects. A parameter supplies culture-specific formatting information.
  Returns: A copy of format in which format items are replaced by the string representations of arg0 and arg1.
  Parameters:
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
    - format (System.String): A composite format string.
    - arg0 (System.Object): The first object to format.
    - arg1 (System.Object): The second object to format.

Format(IFormatProvider, String, Object, Object, Object) -> String
  Summary: Replaces the format items in a string with the string representation of three specified objects. A parameter supplies culture-specific formatting information.
  Returns: A copy of format in which the format items have been replaced by the string representations of arg0, arg1, and arg2.
  Parameters:
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
    - format (System.String): A composite format string.
    - arg0 (System.Object): The first object to format.
    - arg1 (System.Object): The second object to format.
    - arg2 (System.Object): The third object to format.
"
  (cl:cond
    ((cl:and (cl:or (cl:null format) (dotnet:object-type format)) (cl:stringp arg0) supplied-arg1 (cl:or (cl:null arg1) (dotnet:object-type arg1)) supplied-arg2 (cl:or (cl:null arg2) (dotnet:object-type arg2)) supplied-arg22 (cl:or (cl:null arg22) (dotnet:object-type arg22)))
     (dotnet:static <type-str> "Format" format arg0 arg1 arg2 arg22))
    ((cl:and (cl:stringp format) (cl:or (cl:null arg0) (dotnet:object-type arg0)) supplied-arg1 (cl:or (cl:null arg1) (dotnet:object-type arg1)) supplied-arg2 (cl:or (cl:null arg2) (dotnet:object-type arg2)) (cl:not supplied-arg22))
     (dotnet:static <type-str> "Format" format arg0 arg1 arg2))
    ((cl:and (cl:or (cl:null format) (dotnet:object-type format)) (cl:stringp arg0) supplied-arg1 (cl:or (cl:null arg1) (dotnet:object-type arg1)) supplied-arg2 (cl:or (cl:null arg2) (dotnet:object-type arg2)) (cl:not supplied-arg22))
     (dotnet:static <type-str> "Format" format arg0 arg1 arg2))
    ((cl:and (cl:stringp format) (cl:or (cl:null arg0) (dotnet:object-type arg0)) supplied-arg1 (cl:or (cl:null arg1) (dotnet:object-type arg1)) (cl:not supplied-arg2) (cl:not supplied-arg22))
     (dotnet:static <type-str> "Format" format arg0 arg1))
    ((cl:and (cl:or (cl:null format) (dotnet:object-type format)) (cl:stringp arg0) supplied-arg1 (cl:or (cl:null arg1) (dotnet:object-type arg1)) (cl:not supplied-arg2) (cl:not supplied-arg22))
     (dotnet:static <type-str> "Format" format arg0 arg1))
    ((cl:and (cl:or (cl:null format) (dotnet:object-type format)) (cl:stringp arg0) supplied-arg1 (cl:or (cl:null arg1) (dotnet:object-type arg1)) (cl:not supplied-arg2) (cl:not supplied-arg22))
     (dotnet:static <type-str> "Format" format arg0 arg1))
    ((cl:and (cl:or (cl:null format) (dotnet:object-type format)) (cl:or (cl:null arg0) (dotnet:object-type arg0)) supplied-arg1 (cl:or (cl:null arg1) (dotnet:object-type arg1)) (cl:not supplied-arg2) (cl:not supplied-arg22))
     (dotnet:static <type-str> "Format" format arg0 arg1))
    ((cl:and (cl:stringp format) (cl:or (cl:null arg0) (dotnet:object-type arg0)) (cl:not supplied-arg1) (cl:not supplied-arg2) (cl:not supplied-arg22))
     (dotnet:static <type-str> "Format" format arg0))
    ((cl:and (cl:stringp format) (cl:or (cl:null arg0) (dotnet:object-type arg0)) (cl:not supplied-arg1) (cl:not supplied-arg2) (cl:not supplied-arg22))
     (dotnet:static <type-str> "Format" format arg0))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "Format"
                    :supplied-args (cl:append (cl:list :format format) (cl:list :arg0 arg0) (cl:when supplied-arg1 (cl:list :arg1 arg1)) (cl:when supplied-arg2 (cl:list :arg2 arg2)) (cl:when supplied-arg22 (cl:list :arg22 arg22)))))))

(cl:defun format-arity-1 (type provider format arg0)
  "Summary: Replaces the format item or items in a System.Text.CompositeFormat with the string representation of the corresponding objects in the specified format.
Returns: The formatted string.
Parameters:
  - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
  - format (System.Text.CompositeFormat): A System.Text.CompositeFormat.
  - arg0 (TArg0): The first object to format.
"
  (dotnet:static-generic <type-str> "Format" (cl:list type) provider format arg0))

(cl:defun format-arity-2 (type-1 type-2 provider format arg0 arg1)
  "Summary: Replaces the format item or items in a System.Text.CompositeFormat with the string representation of the corresponding objects in the specified format.
Returns: The formatted string.
Parameters:
  - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
  - format (System.Text.CompositeFormat): A System.Text.CompositeFormat.
  - arg0 (TArg0): The first object to format.
  - arg1 (TArg1): The second object to format.
"
  (dotnet:static-generic <type-str> "Format" (cl:list type-1 type-2) provider format arg0 arg1))

(cl:defun format-arity-3 (type-1 type-2 type-3 provider format arg0 arg1 arg2)
  "Summary: Replaces the format item or items in a System.Text.CompositeFormat with the string representation of the corresponding objects in the specified format.
Returns: The formatted string.
Parameters:
  - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
  - format (System.Text.CompositeFormat): A System.Text.CompositeFormat.
  - arg0 (TArg0): The first object to format.
  - arg1 (TArg1): The second object to format.
  - arg2 (TArg2): The third object to format.
"
  (dotnet:static-generic <type-str> "Format" (cl:list type-1 type-2 type-3) provider format arg0 arg1 arg2))

(cl:defun format<> (types cl:&rest args)
  "Dispatches format<> by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload.
   Passing cl:nil or an empty list calls the non-generic format overload(s)."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (0 (cl:apply (cl:function format) args))
      (1 (cl:apply (cl:function format-arity-1) (cl:append type-list args)))
      (2 (cl:apply (cl:function format-arity-2) (cl:append type-list args)))
      (3 (cl:apply (cl:function format-arity-3) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-STRING"
                      :class-name <type-str>
                      :method-name "format<>"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

;; Note: System.String.Format also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   Format(String, params Object[]) -> String
;;   Format(IFormatProvider, String, params Object[]) -> String
;;   Format(IFormatProvider, CompositeFormat, params Object[]) -> String

(cl:defun get-enumerator (obj!)
  "Summary: Retrieves an object that can iterate through the individual characters in this string.
Returns: An enumerator object.
"
  (dotnet:invoke (cl:the (dotnet "System.String") obj!) "GetEnumerator"))

(cl:defun get-hash-code (obj! cl:&optional (comparison-type cl:nil supplied-comparison-type))
  "Master wrapper for System.String.GetHashCode overloads. Dispatches at runtime.

GetHashCode() -> Int32
  Summary: Returns the hash code for this string.
  Returns: A 32-bit signed integer hash code.

GetHashCode(StringComparison) -> Int32
  Summary: Returns the hash code for this string using the specified rules.
  Returns: A 32-bit signed integer hash code.
  Parameters:
    - comparison-type (System.StringComparison): One of the enumeration values that specifies the rules to use in the comparison.
"
  (cl:cond
    ((cl:and supplied-comparison-type (cl:or (cl:null comparison-type) (dotnet:object-type comparison-type)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "GetHashCode" comparison-type))
    ((cl:and (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "GetHashCode"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "GetHashCode"
                    :supplied-args (cl:append (cl:when supplied-comparison-type (cl:list :comparison-type comparison-type)))))))

(cl:defun get-hash-code* (value cl:&optional (comparison-type cl:nil supplied-comparison-type))
  "Master wrapper for System.String.GetHashCode overloads. Dispatches at runtime.

GetHashCode(Char]) -> Int32
  Summary: Returns the hash code for the provided read-only character span.
  Returns: A 32-bit signed integer hash code.
  Parameters:
    - value (System.ReadOnlySpan`1[System.Char]): A read-only character span.

GetHashCode(Char], StringComparison) -> Int32
  Summary: Returns the hash code for the provided read-only character span using the specified rules.
  Returns: A 32-bit signed integer hash code.
  Parameters:
    - value (System.ReadOnlySpan`1[System.Char]): A read-only character span.
    - comparison-type (System.StringComparison): One of the enumeration values that specifies the rules to use in the comparison.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-comparison-type (cl:or (cl:null comparison-type) (dotnet:object-type comparison-type)))
     (dotnet:static <type-str> "GetHashCode" value comparison-type))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-comparison-type))
     (dotnet:static <type-str> "GetHashCode" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "GetHashCode"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-comparison-type (cl:list :comparison-type comparison-type)))))))

(cl:defun get-pinnable-reference (obj!)
  "Summary: Returns a reference to the element of the string at index zero. This method is intended to support .NET compilers and is not intended to be called by user code.
Returns: A reference to the first character in the string, or a reference to the string's null terminator if the string is empty.
"
  (dotnet:invoke (cl:the (dotnet "System.String") obj!) "GetPinnableReference"))

(cl:defun get-type-code (obj!)
  "Summary: Returns the System.TypeCode for the System.String class.
Returns: The enumerated constant, System.TypeCode.String.
"
  (dotnet:invoke (cl:the (dotnet "System.String") obj!) "GetTypeCode"))

(cl:defun implicit-cast (value)
  (dotnet:static <type-str> "op_Implicit" (cl:the (dotnet "System.String") value)))

(cl:defun index-of (obj! value cl:&optional (start-index cl:nil supplied-start-index) (count cl:nil supplied-count) (comparison-type cl:nil supplied-comparison-type))
  "Master wrapper for System.String.IndexOf overloads. Dispatches at runtime.

IndexOf(Char) -> Int32
  Summary: Reports the zero-based index of the first occurrence of the specified Unicode character in this string.
  Returns: The zero-based index position of value if that character is found, or -1 if it is not.
  Parameters:
    - value (System.Char): A Unicode character to seek.

IndexOf(String) -> Int32
  Summary: Reports the zero-based index of the first occurrence of the specified string in this instance.
  Returns: The zero-based index position of value if that string is found, or -1 if it is not. If value is System.String.Empty, the return value is 0.
  Parameters:
    - value (System.String): The string to seek.

IndexOf(Char, Int32) -> Int32
  Summary: Reports the zero-based index of the first occurrence of the specified Unicode character in this string. The search starts at a specified character position.
  Returns: The zero-based index position of value from the start of the string if that character is found, or -1 if it is not.
  Parameters:
    - value (System.Char): A Unicode character to seek.
    - start-index (System.Int32): The search starting position.

IndexOf(Char, StringComparison) -> Int32
  Summary: Reports the zero-based index of the first occurrence of the specified Unicode character in this string. A parameter specifies the type of search to use for the specified character.
  Returns: The zero-based index of value if that character is found, or -1 if it is not.
  Parameters:
    - value (System.Char): The character to seek.
    - comparison-type (System.StringComparison): An enumeration value that specifies the rules for the search.

IndexOf(String, Int32) -> Int32
  Summary: Reports the zero-based index of the first occurrence of the specified string in this instance. The search starts at a specified character position.
  Returns: The zero-based index position of value from the start of the current instance if that string is found, or -1 if it is not. If value is System.String.Empty, the return value is startIndex.
  Parameters:
    - value (System.String): The string to seek.
    - start-index (System.Int32): The search starting position.

IndexOf(String, StringComparison) -> Int32
  Summary: Reports the zero-based index of the first occurrence of the specified string in the current System.String object. A parameter specifies the type of search to use for the specified string.
  Returns: The index position of the value parameter if that string is found, or -1 if it is not. If value is System.String.Empty, the return value is 0.
  Parameters:
    - value (System.String): The string to seek.
    - comparison-type (System.StringComparison): One of the enumeration values that specifies the rules for the search.

IndexOf(Char, Int32, Int32) -> Int32
  Summary: Reports the zero-based index of the first occurrence of the specified character in this instance. The search starts at a specified character position and examines a specified number of character positions.
  Returns: The zero-based index position of value from the start of the string if that character is found, or -1 if it is not.
  Parameters:
    - value (System.Char): A Unicode character to seek.
    - start-index (System.Int32): The search starting position.
    - count (System.Int32): The number of character positions to examine.

IndexOf(String, Int32, Int32) -> Int32
  Summary: Reports the zero-based index of the first occurrence of the specified string in this instance. The search starts at a specified character position and examines a specified number of character positions.
  Returns: The zero-based index position of value from the start of the current instance if that string is found, or -1 if it is not. If value is System.String.Empty, the return value is startIndex.
  Parameters:
    - value (System.String): The string to seek.
    - start-index (System.Int32): The search starting position.
    - count (System.Int32): The number of character positions to examine.

IndexOf(String, Int32, StringComparison) -> Int32
  Summary: Reports the zero-based index of the first occurrence of the specified string in the current System.String object. Parameters specify the starting search position in the current string and the type of search to use for the specified string.
  Returns: The zero-based index position of the value parameter from the start of the current instance if that string is found, or -1 if it is not. If value is System.String.Empty, the return value is startIndex.
  Parameters:
    - value (System.String): The string to seek.
    - start-index (System.Int32): The search starting position.
    - comparison-type (System.StringComparison): One of the enumeration values that specifies the rules for the search.

IndexOf(String, Int32, Int32, StringComparison) -> Int32
  Summary: Reports the zero-based index of the first occurrence of the specified string in the current System.String object. Parameters specify the starting search position in the current string, the number of characters in the current string to search, and the type of search to use for the specified string.
  Returns: The zero-based index position of the value parameter from the start of the current instance if that string is found, or -1 if it is not. If value is System.String.Empty, the return value is startIndex.
  Parameters:
    - value (System.String): The string to seek.
    - start-index (System.Int32): The search starting position.
    - count (System.Int32): The number of character positions to examine.
    - comparison-type (System.StringComparison): One of the enumeration values that specifies the rules for the search.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count) supplied-comparison-type (cl:or (cl:null comparison-type) (dotnet:object-type comparison-type)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "IndexOf" value start-index count comparison-type))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "IndexOf" value start-index count))
    ((cl:and (cl:stringp value) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "IndexOf" value start-index count))
    ((cl:and (cl:stringp value) supplied-start-index (cl:numberp start-index) supplied-count (cl:or (cl:null count) (dotnet:object-type count)) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "IndexOf" value start-index count))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:numberp start-index) (cl:not supplied-count) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "IndexOf" value start-index))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:or (cl:null start-index) (dotnet:object-type start-index)) (cl:not supplied-count) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "IndexOf" value start-index))
    ((cl:and (cl:stringp value) supplied-start-index (cl:numberp start-index) (cl:not supplied-count) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "IndexOf" value start-index))
    ((cl:and (cl:stringp value) supplied-start-index (cl:or (cl:null start-index) (dotnet:object-type start-index)) (cl:not supplied-count) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "IndexOf" value start-index))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-start-index) (cl:not supplied-count) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "IndexOf" value))
    ((cl:and (cl:stringp value) (cl:not supplied-start-index) (cl:not supplied-count) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "IndexOf" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "IndexOf"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-start-index (cl:list :start-index start-index)) (cl:when supplied-count (cl:list :count count)) (cl:when supplied-comparison-type (cl:list :comparison-type comparison-type)))))))

(cl:defun index-of-any (obj! any-of cl:&optional (start-index cl:nil supplied-start-index) (count cl:nil supplied-count))
  "Master wrapper for System.String.IndexOfAny overloads. Dispatches at runtime.

IndexOfAny(Char[]) -> Int32
  Summary: Reports the zero-based index of the first occurrence in this instance of any character in a specified array of Unicode characters.
  Returns: The zero-based index position of the first occurrence in this instance where any character in anyOf was found; -1 if no character in anyOf was found.
  Parameters:
    - any-of (System.Char[]): A Unicode character array containing one or more characters to seek.

IndexOfAny(Char[], Int32) -> Int32
  Summary: Reports the zero-based index of the first occurrence in this instance of any character in a specified array of Unicode characters. The search starts at a specified character position.
  Returns: The zero-based index position of the first occurrence in this instance where any character in anyOf was found; -1 if no character in anyOf was found.
  Parameters:
    - any-of (System.Char[]): A Unicode character array containing one or more characters to seek.
    - start-index (System.Int32): The search starting position.

IndexOfAny(Char[], Int32, Int32) -> Int32
  Summary: Reports the zero-based index of the first occurrence in this instance of any character in a specified array of Unicode characters. The search starts at a specified character position and examines a specified number of character positions.
  Returns: The zero-based index position of the first occurrence in this instance where any character in anyOf was found; -1 if no character in anyOf was found.
  Parameters:
    - any-of (System.Char[]): A Unicode character array containing one or more characters to seek.
    - start-index (System.Int32): The search starting position.
    - count (System.Int32): The number of character positions to examine.
"
  (cl:cond
    ((cl:and (cl:or (cl:null any-of) (dotnet:object-type any-of)) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "IndexOfAny" any-of start-index count))
    ((cl:and (cl:or (cl:null any-of) (dotnet:object-type any-of)) supplied-start-index (cl:numberp start-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "IndexOfAny" any-of start-index))
    ((cl:and (cl:or (cl:null any-of) (dotnet:object-type any-of)) (cl:not supplied-start-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "IndexOfAny" any-of))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "IndexOfAny"
                    :supplied-args (cl:append (cl:list :any-of any-of) (cl:when supplied-start-index (cl:list :start-index start-index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun insert (obj! start-index value)
  "Summary: Returns a new string in which a specified string is inserted at a specified index position in this instance.
Returns: A new string that is equivalent to this instance, but with value inserted at position startIndex.
Parameters:
  - start-index (System.Int32): The zero-based index position of the insertion.
  - value (System.String): The string to insert.
"
  (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Insert" start-index value))

(cl:defun intern (str)
  "Summary: Retrieves the system's reference to the specified System.String.
Returns: The system's reference to str, if it is interned; otherwise, a new reference to a string with the value of str.
Parameters:
  - str (System.String): A string to search for in the intern pool.
"
  (dotnet:static <type-str> "Intern" (cl:the (dotnet "System.String") str)))

(cl:defun interned? (str)
  "Summary: Retrieves a reference to a specified System.String.
Returns: A reference to str if it is in the common language runtime intern pool; otherwise, .
Parameters:
  - str (System.String): The string to search for in the intern pool.
"
  (dotnet:static <type-str> "IsInterned" (cl:the (dotnet "System.String") str)))

(cl:defun normalized? (obj! cl:&optional (normalization-form cl:nil supplied-normalization-form))
  "Master wrapper for System.String.IsNormalized overloads. Dispatches at runtime.

IsNormalized() -> Boolean
  Summary: Indicates whether this string is in Unicode normalization form C.
  Returns: if this string is in normalization form C; otherwise, .

IsNormalized(NormalizationForm) -> Boolean
  Summary: Indicates whether this string is in the specified Unicode normalization form.
  Returns: if this string is in the normalization form specified by the normalizationForm parameter; otherwise, .
  Parameters:
    - normalization-form (System.Text.NormalizationForm): A Unicode normalization form.
"
  (cl:cond
    ((cl:and supplied-normalization-form (cl:or (cl:null normalization-form) (dotnet:object-type normalization-form)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "IsNormalized" normalization-form))
    ((cl:and (cl:not supplied-normalization-form))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "IsNormalized"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "IsNormalized"
                    :supplied-args (cl:append (cl:when supplied-normalization-form (cl:list :normalization-form normalization-form)))))))

(cl:defun null-or-empty? (value)
  "Summary: Indicates whether the specified string is or an empty string (\"\").
Returns: if the value parameter is or an empty string (\"\"); otherwise, .
Parameters:
  - value (System.String): The string to test.
"
  (dotnet:static <type-str> "IsNullOrEmpty" (cl:the (dotnet "System.String") value)))

(cl:defun null-or-white-space? (value)
  "Summary: Indicates whether a specified string is , empty, or consists only of white-space characters.
Returns: if the value parameter is or System.String.Empty, or if value consists exclusively of white-space characters.
Parameters:
  - value (System.String): The string to test.
"
  (dotnet:static <type-str> "IsNullOrWhiteSpace" (cl:the (dotnet "System.String") value)))

(cl:defun join (separator value cl:&optional (start-index cl:nil supplied-start-index) (count cl:nil supplied-count))
  "Master wrapper for System.String.Join overloads. Dispatches at runtime.

Join(Char, String]) -> String
  Summary: Concatenates a span of strings, using the specified separator between each member.
  Returns: A string that consists of the elements of value delimited by the separator string. -or- System.String.Empty if value has zero elements.
  Parameters:
    - separator (System.Char): The character to use as a separator. separator is included in the returned string only if value has more than one element.
    - value (System.ReadOnlySpan`1[System.String]): A span that contains the elements to concatenate.

Join(String, String]) -> String
  Summary: Concatenates a span of strings, using the specified separator between each member.
  Returns: A string that consists of the elements of value delimited by the separator string. -or- System.String.Empty if value has zero elements.
  Parameters:
    - separator (System.String): The string to use as a separator. separator is included in the returned string only if value has more than one element.
    - value (System.ReadOnlySpan`1[System.String]): A span that contains the elements to concatenate.

Join(String, String]) -> String
  Summary: Concatenates the members of a constructed System.Collections.Generic.IEnumerable`1 collection of type System.String, using the specified separator between each member.
  Returns: A string that consists of the elements of values delimited by the separator string. -or- System.String.Empty if values has zero elements.
  Parameters:
    - separator (System.String): The string to use as a separator.separator is included in the returned string only if values has more than one element.
    - values (System.Collections.Generic.IEnumerable`1[System.String]): A collection that contains the strings to concatenate.

Join(Char, Object]) -> String
  Summary: Concatenates the string representations of a span of objects, using the specified separator between each member.
  Returns: A string that consists of the elements of values delimited by the separator character. -or- System.String.Empty if values has zero elements.
  Parameters:
    - separator (System.Char): The character to use as a separator. separator is included in the returned string only if value has more than one element.
    - values (System.ReadOnlySpan`1[System.Object]): A span of objects whose string representations will be concatenated.

Join(String, Object]) -> String
  Summary: Concatenates the string representations of a span of objects, using the specified separator between each member.
  Returns: A string that consists of the elements of values delimited by the separator string. -or- System.String.Empty if values has zero elements.
  Parameters:
    - separator (System.String): The string to use as a separator. separator is included in the returned string only if values has more than one element.
    - values (System.ReadOnlySpan`1[System.Object]): A span of objects whose string representations will be concatenated.

Join(Char, String[], Int32, Int32) -> String
  Summary: Concatenates an array of strings, using the specified separator between each member, starting with the element in value located at the startIndex position, and concatenating up to count elements.
  Returns: A string that consists of count elements of value starting at startIndex delimited by the separator character. -or- System.String.Empty if count is zero.
  Parameters:
    - separator (System.Char): Concatenates an array of strings, using the specified separator between each member, starting with the element located at the specified index and including a specified number of elements.
    - value (System.String[]): An array of strings to concatenate.
    - start-index (System.Int32): The first item in value to concatenate.
    - count (System.Int32): The number of elements from value to concatenate, starting with the element in the startIndex position.

Join(String, String[], Int32, Int32) -> String
  Summary: Concatenates the specified elements of a string array, using the specified separator between each element.
  Returns: A string that consists of count elements of value starting at startIndex delimited by the separator character. -or- System.String.Empty if count is zero.
  Parameters:
    - separator (System.String): The string to use as a separator. separator is included in the returned string only if value has more than one element.
    - value (System.String[]): An array that contains the elements to concatenate.
    - start-index (System.Int32): The first element in value to use.
    - count (System.Int32): The number of elements of value to use.
"
  (cl:cond
    ((cl:and (cl:or (cl:null separator) (dotnet:object-type separator)) (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count))
     (dotnet:static <type-str> "Join" separator value start-index count))
    ((cl:and (cl:stringp separator) (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count))
     (dotnet:static <type-str> "Join" separator value start-index count))
    ((cl:and (cl:or (cl:null separator) (dotnet:object-type separator)) (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-start-index) (cl:not supplied-count))
     (dotnet:static <type-str> "Join" separator value))
    ((cl:and (cl:stringp separator) (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-start-index) (cl:not supplied-count))
     (dotnet:static <type-str> "Join" separator value))
    ((cl:and (cl:stringp separator) (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-start-index) (cl:not supplied-count))
     (dotnet:static <type-str> "Join" separator value))
    ((cl:and (cl:or (cl:null separator) (dotnet:object-type separator)) (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-start-index) (cl:not supplied-count))
     (dotnet:static <type-str> "Join" separator value))
    ((cl:and (cl:stringp separator) (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-start-index) (cl:not supplied-count))
     (dotnet:static <type-str> "Join" separator value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "Join"
                    :supplied-args (cl:append (cl:list :separator separator) (cl:list :value value) (cl:when supplied-start-index (cl:list :start-index start-index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun join-arity-1 (type separator values)
  "Master wrapper for System.String.Join overloads. Dispatches at runtime.

Join(Char, IEnumerable) -> String
  Summary: Concatenates the members of a collection, using the specified separator between each member.
  Returns: A string that consists of the members of values delimited by the separator character. -or- System.String.Empty if values has no elements.
  Parameters:
    - separator (System.Char): The character to use as a separator. separator is included in the returned string only if values has more than one element.
    - values (System.Collections.Generic.IEnumerable`1[T]): A collection that contains the objects to concatenate.

Join(String, IEnumerable) -> String
  Summary: Concatenates the members of a collection, using the specified separator between each member.
  Returns: A string that consists of the elements of values delimited by the separator string. -or- System.String.Empty if values has no elements.
  Parameters:
    - separator (System.String): The string to use as a separator. separator is included in the returned string only if values has more than one element.
    - values (System.Collections.Generic.IEnumerable`1[T]): A collection that contains the objects to concatenate.
"
  (cl:cond
    ((cl:and (cl:or (cl:null separator) (dotnet:object-type separator)) (cl:or (cl:null values) (dotnet:object-type values)))
     (dotnet:static-generic <type-str> "Join" (cl:list type) separator values))
    ((cl:and (cl:stringp separator) (cl:or (cl:null values) (dotnet:object-type values)))
     (dotnet:static-generic <type-str> "Join" (cl:list type) separator values))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "Join"
                    :supplied-args (cl:append (cl:list :separator separator) (cl:list :values values))))))

(cl:defun join<> (types cl:&rest args)
  "Dispatches join<> by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload.
   Passing cl:nil or an empty list calls the non-generic join overload(s)."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (0 (cl:apply (cl:function join) args))
      (1 (cl:apply (cl:function join-arity-1) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-STRING"
                      :class-name <type-str>
                      :method-name "join<>"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

;; Note: System.String.Join also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   Join(Char, params String[]) -> String
;;   Join(String, params String[]) -> String
;;   Join(Char, params Object[]) -> String
;;   Join(String, params Object[]) -> String

(cl:defun last-index-of (obj! value cl:&optional (start-index cl:nil supplied-start-index) (count cl:nil supplied-count) (comparison-type cl:nil supplied-comparison-type))
  "Master wrapper for System.String.LastIndexOf overloads. Dispatches at runtime.

LastIndexOf(Char) -> Int32
  Summary: Reports the zero-based index position of the last occurrence of a specified Unicode character within this instance.
  Returns: The zero-based index position of value if that character is found, or -1 if it is not.
  Parameters:
    - value (System.Char): The Unicode character to seek.

LastIndexOf(String) -> Int32
  Summary: Reports the zero-based index position of the last occurrence of a specified string within this instance.
  Returns: The zero-based starting index position of value if that string is found, or -1 if it is not.
  Parameters:
    - value (System.String): The string to seek.

LastIndexOf(Char, Int32) -> Int32
  Summary: Reports the zero-based index position of the last occurrence of a specified Unicode character within this instance. The search starts at a specified character position and proceeds backward toward the beginning of the string.
  Returns: The zero-based index position of value if that character is found, or -1 if it is not found or if the current instance equals System.String.Empty.
  Parameters:
    - value (System.Char): The Unicode character to seek.
    - start-index (System.Int32): The starting position of the search. The search proceeds from startIndex toward the beginning of this instance.

LastIndexOf(String, Int32) -> Int32
  Summary: Reports the zero-based index position of the last occurrence of a specified string within this instance. The search starts at a specified character position and proceeds backward toward the beginning of the string.
  Returns: The zero-based starting index position of value if that string is found, or -1 if it is not found or if the current instance equals System.String.Empty.
  Parameters:
    - value (System.String): The string to seek.
    - start-index (System.Int32): The search starting position. The search proceeds from startIndex toward the beginning of this instance.

LastIndexOf(String, StringComparison) -> Int32
  Summary: Reports the zero-based index of the last occurrence of a specified string within the current System.String object. A parameter specifies the type of search to use for the specified string.
  Returns: The zero-based starting index position of the value parameter if that string is found, or -1 if it is not.
  Parameters:
    - value (System.String): The string to seek.
    - comparison-type (System.StringComparison): One of the enumeration values that specifies the rules for the search.

LastIndexOf(Char, Int32, Int32) -> Int32
  Summary: Reports the zero-based index position of the last occurrence of the specified Unicode character in a substring within this instance. The search starts at a specified character position and proceeds backward toward the beginning of the string for a specified number of character positions.
  Returns: The zero-based index position of value if that character is found, or -1 if it is not found or if the current instance equals System.String.Empty.
  Parameters:
    - value (System.Char): The Unicode character to seek.
    - start-index (System.Int32): The starting position of the search. The search proceeds from startIndex toward the beginning of this instance.
    - count (System.Int32): The number of character positions to examine.

LastIndexOf(String, Int32, Int32) -> Int32
  Summary: Reports the zero-based index position of the last occurrence of a specified string within this instance. The search starts at a specified character position and proceeds backward toward the beginning of the string for a specified number of character positions.
  Returns: The zero-based starting index position of value if that string is found, or -1 if it is not found or if the current instance equals System.String.Empty.
  Parameters:
    - value (System.String): The string to seek.
    - start-index (System.Int32): The search starting position. The search proceeds from startIndex toward the beginning of this instance.
    - count (System.Int32): The number of character positions to examine.

LastIndexOf(String, Int32, StringComparison) -> Int32
  Summary: Reports the zero-based index of the last occurrence of a specified string within the current System.String object. The search starts at a specified character position and proceeds backward toward the beginning of the string. A parameter specifies the type of comparison to perform when searching for the specified string.
  Returns: The zero-based starting index position of the value parameter if that string is found, or -1 if it is not found or if the current instance equals System.String.Empty.
  Parameters:
    - value (System.String): The string to seek.
    - start-index (System.Int32): The search starting position. The search proceeds from startIndex toward the beginning of this instance.
    - comparison-type (System.StringComparison): One of the enumeration values that specifies the rules for the search.

LastIndexOf(String, Int32, Int32, StringComparison) -> Int32
  Summary: Reports the zero-based index position of the last occurrence of a specified string within this instance. The search starts at a specified character position and proceeds backward toward the beginning of the string for the specified number of character positions. A parameter specifies the type of comparison to perform when searching for the specified string.
  Returns: The zero-based starting index position of the value parameter if that string is found, or -1 if it is not found or if the current instance equals System.String.Empty.
  Parameters:
    - value (System.String): The string to seek.
    - start-index (System.Int32): The search starting position. The search proceeds from startIndex toward the beginning of this instance.
    - count (System.Int32): The number of character positions to examine.
    - comparison-type (System.StringComparison): One of the enumeration values that specifies the rules for the search.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count) supplied-comparison-type (cl:or (cl:null comparison-type) (dotnet:object-type comparison-type)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "LastIndexOf" value start-index count comparison-type))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "LastIndexOf" value start-index count))
    ((cl:and (cl:stringp value) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "LastIndexOf" value start-index count))
    ((cl:and (cl:stringp value) supplied-start-index (cl:numberp start-index) supplied-count (cl:or (cl:null count) (dotnet:object-type count)) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "LastIndexOf" value start-index count))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-start-index (cl:numberp start-index) (cl:not supplied-count) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "LastIndexOf" value start-index))
    ((cl:and (cl:stringp value) supplied-start-index (cl:numberp start-index) (cl:not supplied-count) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "LastIndexOf" value start-index))
    ((cl:and (cl:stringp value) supplied-start-index (cl:or (cl:null start-index) (dotnet:object-type start-index)) (cl:not supplied-count) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "LastIndexOf" value start-index))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-start-index) (cl:not supplied-count) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "LastIndexOf" value))
    ((cl:and (cl:stringp value) (cl:not supplied-start-index) (cl:not supplied-count) (cl:not supplied-comparison-type))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "LastIndexOf" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "LastIndexOf"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-start-index (cl:list :start-index start-index)) (cl:when supplied-count (cl:list :count count)) (cl:when supplied-comparison-type (cl:list :comparison-type comparison-type)))))))

(cl:defun last-index-of-any (obj! any-of cl:&optional (start-index cl:nil supplied-start-index) (count cl:nil supplied-count))
  "Master wrapper for System.String.LastIndexOfAny overloads. Dispatches at runtime.

LastIndexOfAny(Char[]) -> Int32
  Summary: Reports the zero-based index position of the last occurrence in this instance of one or more characters specified in a Unicode array.
  Returns: The index position of the last occurrence in this instance where any character in anyOf was found; -1 if no character in anyOf was found.
  Parameters:
    - any-of (System.Char[]): A Unicode character array containing one or more characters to seek.

LastIndexOfAny(Char[], Int32) -> Int32
  Summary: Reports the zero-based index position of the last occurrence in this instance of one or more characters specified in a Unicode array. The search starts at a specified character position and proceeds backward toward the beginning of the string.
  Returns: The index position of the last occurrence in this instance where any character in anyOf was found; -1 if no character in anyOf was found or if the current instance equals System.String.Empty.
  Parameters:
    - any-of (System.Char[]): A Unicode character array containing one or more characters to seek.
    - start-index (System.Int32): The search starting position. The search proceeds from startIndex toward the beginning of this instance.

LastIndexOfAny(Char[], Int32, Int32) -> Int32
  Summary: Reports the zero-based index position of the last occurrence in this instance of one or more characters specified in a Unicode array. The search starts at a specified character position and proceeds backward toward the beginning of the string for a specified number of character positions.
  Returns: The index position of the last occurrence in this instance where any character in anyOf was found; -1 if no character in anyOf was found or if the current instance equals System.String.Empty.
  Parameters:
    - any-of (System.Char[]): A Unicode character array containing one or more characters to seek.
    - start-index (System.Int32): The search starting position. The search proceeds from startIndex toward the beginning of this instance.
    - count (System.Int32): The number of character positions to examine.
"
  (cl:cond
    ((cl:and (cl:or (cl:null any-of) (dotnet:object-type any-of)) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "LastIndexOfAny" any-of start-index count))
    ((cl:and (cl:or (cl:null any-of) (dotnet:object-type any-of)) supplied-start-index (cl:numberp start-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "LastIndexOfAny" any-of start-index))
    ((cl:and (cl:or (cl:null any-of) (dotnet:object-type any-of)) (cl:not supplied-start-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "LastIndexOfAny" any-of))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "LastIndexOfAny"
                    :supplied-args (cl:append (cl:list :any-of any-of) (cl:when supplied-start-index (cl:list :start-index start-index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun normalize (obj! cl:&optional (normalization-form cl:nil supplied-normalization-form))
  "Master wrapper for System.String.Normalize overloads. Dispatches at runtime.

Normalize() -> String
  Summary: Returns a new string whose textual value is the same as this string, but whose binary representation is in Unicode normalization form C.
  Returns: A new, normalized string whose textual value is the same as this string, but whose binary representation is in normalization form C.

Normalize(NormalizationForm) -> String
  Summary: Returns a new string whose textual value is the same as this string, but whose binary representation is in the specified Unicode normalization form.
  Returns: A new string whose textual value is the same as this string, but whose binary representation is in the normalization form specified by the normalizationForm parameter.
  Parameters:
    - normalization-form (System.Text.NormalizationForm): A Unicode normalization form.
"
  (cl:cond
    ((cl:and supplied-normalization-form (cl:or (cl:null normalization-form) (dotnet:object-type normalization-form)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Normalize" normalization-form))
    ((cl:and (cl:not supplied-normalization-form))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Normalize"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "Normalize"
                    :supplied-args (cl:append (cl:when supplied-normalization-form (cl:list :normalization-form normalization-form)))))))

(cl:defun not= (a b)
  "Summary: Determines whether two specified strings have different values.
Returns: if the value of a is different from the value of b; otherwise, .
Parameters:
  - a (System.String): The first string to compare, or .
  - b (System.String): The second string to compare, or .
"
  (dotnet:static <type-str> "op_Inequality" (cl:the (dotnet "System.String") a) (cl:the (dotnet "System.String") b)))

(cl:defun pad-left (obj! total-width cl:&optional (padding-char cl:nil supplied-padding-char))
  "Master wrapper for System.String.PadLeft overloads. Dispatches at runtime.

PadLeft(Int32) -> String
  Summary: Returns a new string that right-aligns the characters in this instance by padding them with spaces on the left, for a specified total length.
  Returns: A new string that is equivalent to this instance, but right-aligned and padded on the left with as many spaces as needed to create a length of totalWidth. However, if totalWidth is less than the length of this instance, the method returns a reference to the existing instance. If totalWidth is equal to the length of this instance, the method returns a new string that is identical to this instance.
  Parameters:
    - total-width (System.Int32): The number of characters in the resulting string, equal to the number of original characters plus any additional padding characters.

PadLeft(Int32, Char) -> String
  Summary: Returns a new string that right-aligns the characters in this instance by padding them on the left with a specified Unicode character, for a specified total length.
  Returns: A new string that is equivalent to this instance, but right-aligned and padded on the left with as many paddingChar characters as needed to create a length of totalWidth. However, if totalWidth is less than the length of this instance, the method returns a reference to the existing instance. If totalWidth is equal to the length of this instance, the method returns a new string that is identical to this instance.
  Parameters:
    - total-width (System.Int32): The number of characters in the resulting string, equal to the number of original characters plus any additional padding characters.
    - padding-char (System.Char): A Unicode padding character.
"
  (cl:cond
    ((cl:and (cl:numberp total-width) supplied-padding-char (cl:or (cl:null padding-char) (dotnet:object-type padding-char)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "PadLeft" total-width padding-char))
    ((cl:and (cl:numberp total-width) (cl:not supplied-padding-char))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "PadLeft" total-width))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "PadLeft"
                    :supplied-args (cl:append (cl:list :total-width total-width) (cl:when supplied-padding-char (cl:list :padding-char padding-char)))))))

(cl:defun pad-right (obj! total-width cl:&optional (padding-char cl:nil supplied-padding-char))
  "Master wrapper for System.String.PadRight overloads. Dispatches at runtime.

PadRight(Int32) -> String
  Summary: Returns a new string that left-aligns the characters in this string by padding them with spaces on the right, for a specified total length.
  Returns: A new string that is equivalent to this instance, but left-aligned and padded on the right with as many spaces as needed to create a length of totalWidth. However, if totalWidth is less than the length of this instance, the method returns a reference to the existing instance. If totalWidth is equal to the length of this instance, the method returns a new string that is identical to this instance.
  Parameters:
    - total-width (System.Int32): The number of characters in the resulting string, equal to the number of original characters plus any additional padding characters.

PadRight(Int32, Char) -> String
  Summary: Returns a new string that left-aligns the characters in this string by padding them on the right with a specified Unicode character, for a specified total length.
  Returns: A new string that is equivalent to this instance, but left-aligned and padded on the right with as many paddingChar characters as needed to create a length of totalWidth. However, if totalWidth is less than the length of this instance, the method returns a reference to the existing instance. If totalWidth is equal to the length of this instance, the method returns a new string that is identical to this instance.
  Parameters:
    - total-width (System.Int32): The number of characters in the resulting string, equal to the number of original characters plus any additional padding characters.
    - padding-char (System.Char): A Unicode padding character.
"
  (cl:cond
    ((cl:and (cl:numberp total-width) supplied-padding-char (cl:or (cl:null padding-char) (dotnet:object-type padding-char)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "PadRight" total-width padding-char))
    ((cl:and (cl:numberp total-width) (cl:not supplied-padding-char))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "PadRight" total-width))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "PadRight"
                    :supplied-args (cl:append (cl:list :total-width total-width) (cl:when supplied-padding-char (cl:list :padding-char padding-char)))))))

(cl:defun remove (obj! start-index cl:&optional (count cl:nil supplied-count))
  "Master wrapper for System.String.Remove overloads. Dispatches at runtime.

Remove(Int32) -> String
  Summary: Returns a new string in which all the characters in the current instance, beginning at a specified position and continuing through the last position, have been deleted.
  Returns: A new string that is equivalent to this string except for the removed characters.
  Parameters:
    - start-index (System.Int32): The zero-based position to begin deleting characters.

Remove(Int32, Int32) -> String
  Summary: Returns a new string in which a specified number of characters in the current instance beginning at a specified position have been deleted.
  Returns: A new string that is equivalent to this instance except for the removed characters.
  Parameters:
    - start-index (System.Int32): The zero-based position to begin deleting characters.
    - count (System.Int32): The number of characters to delete.
"
  (cl:cond
    ((cl:and (cl:numberp start-index) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Remove" start-index count))
    ((cl:and (cl:numberp start-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Remove" start-index))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "Remove"
                    :supplied-args (cl:append (cl:list :start-index start-index) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun replace (obj! old-char new-char cl:&optional (comparison-type cl:nil supplied-comparison-type) (culture cl:nil supplied-culture))
  "Master wrapper for System.String.Replace overloads. Dispatches at runtime.

Replace(Char, Char) -> String
  Summary: Returns a new string in which all occurrences of a specified Unicode character in this instance are replaced with another specified Unicode character.
  Returns: A string that is equivalent to this instance except that all instances of oldChar are replaced with newChar. If oldChar is not found in the current instance, the method returns the current instance unchanged.
  Parameters:
    - old-char (System.Char): The Unicode character to be replaced.
    - new-char (System.Char): The Unicode character to replace all occurrences of oldChar.

Replace(String, String) -> String
  Summary: Returns a new string in which all occurrences of a specified string in the current instance are replaced with another specified string.
  Returns: A string that is equivalent to the current string except that all instances of oldValue are replaced with newValue. If oldValue is not found in the current instance, the method returns the current instance unchanged.
  Parameters:
    - old-value (System.String): The string to be replaced.
    - new-value (System.String): The string to replace all occurrences of oldValue.

Replace(String, String, StringComparison) -> String
  Summary: Returns a new string in which all occurrences of a specified string in the current instance are replaced with another specified string, using the provided comparison type.
  Returns: A string that is equivalent to the current string except that all instances of oldValue are replaced with newValue. If oldValue is not found in the current instance, the method returns the current instance unchanged.
  Parameters:
    - old-value (System.String): The string to be replaced.
    - new-value (System.String): The string to replace all occurrences of oldValue.
    - comparison-type (System.StringComparison): One of the enumeration values that determines how oldValue is searched within this instance.

Replace(String, String, Boolean, CultureInfo) -> String
  Summary: Returns a new string in which all occurrences of a specified string in the current instance are replaced with another specified string, using the provided culture and case sensitivity.
  Returns: A string that is equivalent to the current string except that all instances of oldValue are replaced with newValue. If oldValue is not found in the current instance, the method returns the current instance unchanged.
  Parameters:
    - old-value (System.String): The string to be replaced.
    - new-value (System.String): The string to replace all occurrences of oldValue.
    - ignore-case (System.Boolean): to ignore casing when comparing; otherwise.
    - culture (System.Globalization.CultureInfo): The culture to use when comparing. If culture is , the current culture is used.
"
  (cl:cond
    ((cl:and (cl:stringp old-char) (cl:stringp new-char) supplied-comparison-type (cl:typep comparison-type 'cl:boolean) supplied-culture (cl:or (cl:null culture) (dotnet:object-type culture)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Replace" old-char new-char comparison-type culture))
    ((cl:and (cl:stringp old-char) (cl:stringp new-char) supplied-comparison-type (cl:or (cl:null comparison-type) (dotnet:object-type comparison-type)) (cl:not supplied-culture))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Replace" old-char new-char comparison-type))
    ((cl:and (cl:or (cl:null old-char) (dotnet:object-type old-char)) (cl:or (cl:null new-char) (dotnet:object-type new-char)) (cl:not supplied-comparison-type) (cl:not supplied-culture))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Replace" old-char new-char))
    ((cl:and (cl:stringp old-char) (cl:stringp new-char) (cl:not supplied-comparison-type) (cl:not supplied-culture))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Replace" old-char new-char))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "Replace"
                    :supplied-args (cl:append (cl:list :old-char old-char) (cl:list :new-char new-char) (cl:when supplied-comparison-type (cl:list :comparison-type comparison-type)) (cl:when supplied-culture (cl:list :culture culture)))))))

(cl:defun replace-line-endings (obj! cl:&optional (replacement-text cl:nil supplied-replacement-text))
  "Master wrapper for System.String.ReplaceLineEndings overloads. Dispatches at runtime.

ReplaceLineEndings() -> String
  Summary: Replaces all newline sequences in the current string with System.Environment.NewLine.
  Returns: A string whose contents match the current string, but with all newline sequences replaced with System.Environment.NewLine.

ReplaceLineEndings(String) -> String
  Summary: Replaces all newline sequences in the current string with replacementText.
  Returns: A string whose contents match the current string, but with all newline sequences replaced with replacementText.
  Parameters:
    - replacement-text (System.String): The text to use as replacement.
"
  (cl:cond
    ((cl:and supplied-replacement-text (cl:stringp replacement-text))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "ReplaceLineEndings" replacement-text))
    ((cl:and (cl:not supplied-replacement-text))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "ReplaceLineEndings"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "ReplaceLineEndings"
                    :supplied-args (cl:append (cl:when supplied-replacement-text (cl:list :replacement-text replacement-text)))))))

(cl:defun split (obj! separator cl:&optional (options cl:nil supplied-options) (options2 cl:nil supplied-options2))
  "Master wrapper for System.String.Split overloads. Dispatches at runtime.

Split(Char]) -> String[]
  Summary: Splits a string into substrings based on specified delimiting characters.
  Returns: An array whose elements contain the substrings from this instance that are delimited by one or more characters in separator.
  Parameters:
    - separator (System.ReadOnlySpan`1[System.Char]): A span of delimiting characters, or an empty span that contains no delimiters.

Split(Char, StringSplitOptions) -> String[]
  Summary: Splits a string into substrings based on a specified delimiting character and, optionally, options.
  Returns: An array whose elements contain the substrings from this instance that are delimited by separator.
  Parameters:
    - separator (System.Char): A character that delimits the substrings in this string.
    - options (System.StringSplitOptions): A bitwise combination of the enumeration values that specifies whether to trim substrings and include empty substrings.

Split(Char[], Int32) -> String[]
  Summary: Splits a string into a maximum number of substrings based on specified delimiting characters.
  Returns: An array whose elements contain the substrings in this instance that are delimited by one or more characters in separator. For more information, see the Remarks section.
  Parameters:
    - separator (System.Char[]): An array of characters that delimit the substrings in this string, an empty array that contains no delimiters, or .
    - count (System.Int32): The maximum number of substrings to return.

Split(Char[], StringSplitOptions) -> String[]
  Summary: Splits a string into substrings based on specified delimiting characters and options.
  Returns: An array whose elements contain the substrings in this string that are delimited by one or more characters in separator. For more information, see the Remarks section.
  Parameters:
    - separator (System.Char[]): An array of characters that delimit the substrings in this string, an empty array that contains no delimiters, or .
    - options (System.StringSplitOptions): A bitwise combination of the enumeration values that specifies whether to trim substrings and include empty substrings.

Split(String, StringSplitOptions) -> String[]
  Summary: Splits a string into substrings that are based on the provided string separator.
  Returns: An array whose elements contain the substrings from this instance that are delimited by separator.
  Parameters:
    - separator (System.String): A string that delimits the substrings in this string.
    - options (System.StringSplitOptions): A bitwise combination of the enumeration values that specifies whether to trim substrings and include empty substrings.

Split(String[], StringSplitOptions) -> String[]
  Summary: Splits a string into substrings based on a specified delimiting string and, optionally, options.
  Returns: An array whose elements contain the substrings in this string that are delimited by one or more strings in separator. For more information, see the Remarks section.
  Parameters:
    - separator (System.String[]): An array of strings that delimit the substrings in this string, an empty array that contains no delimiters, or .
    - options (System.StringSplitOptions): A bitwise combination of the enumeration values that specifies whether to trim substrings and include empty substrings.

Split(Char, Int32, StringSplitOptions) -> String[]
  Summary: Splits a string into a maximum number of substrings based on the provided character separator, optionally omitting empty substrings from the result.
  Returns: An array that contains at most count substrings from this instance that are delimited by separator.
  Parameters:
    - separator (System.Char): A character that delimits the substrings in this instance.
    - count (System.Int32): The maximum number of elements expected in the array.
    - options (System.StringSplitOptions): A bitwise combination of the enumeration values that specifies whether to trim substrings and include empty substrings.

Split(Char[], Int32, StringSplitOptions) -> String[]
  Summary: Splits a string into a maximum number of substrings based on specified delimiting characters and, optionally, options.
  Returns: An array that contains the substrings in this string that are delimited by one or more characters in separator. For more information, see the Remarks section.
  Parameters:
    - separator (System.Char[]): An array of characters that delimit the substrings in this string, an empty array that contains no delimiters, or .
    - count (System.Int32): The maximum number of substrings to return.
    - options (System.StringSplitOptions): A bitwise combination of the enumeration values that specifies whether to trim substrings and include empty substrings.

Split(String, Int32, StringSplitOptions) -> String[]
  Summary: Splits a string into a maximum number of substrings based on a specified delimiting string and, optionally, options.
  Returns: An array that contains at most count substrings from this instance that are delimited by separator.
  Parameters:
    - separator (System.String): A string that delimits the substrings in this instance.
    - count (System.Int32): The maximum number of elements expected in the array.
    - options (System.StringSplitOptions): A bitwise combination of the enumeration values that specifies whether to trim substrings and include empty substrings.

Split(String[], Int32, StringSplitOptions) -> String[]
  Summary: Splits a string into a maximum number of substrings based on specified delimiting strings and, optionally, options.
  Returns: An array whose elements contain the substrings in this string that are delimited by one or more strings in separator. For more information, see the Remarks section.
  Parameters:
    - separator (System.String[]): The strings that delimit the substrings in this string, an empty array that contains no delimiters, or .
    - count (System.Int32): The maximum number of substrings to return.
    - options (System.StringSplitOptions): A bitwise combination of the enumeration values that specifies whether to trim substrings and include empty substrings.
"
  (cl:cond
    ((cl:and (cl:or (cl:null separator) (dotnet:object-type separator)) supplied-options (cl:numberp options) supplied-options2 (cl:or (cl:null options2) (dotnet:object-type options2)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Split" separator options options2))
    ((cl:and (cl:or (cl:null separator) (dotnet:object-type separator)) supplied-options (cl:numberp options) supplied-options2 (cl:or (cl:null options2) (dotnet:object-type options2)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Split" separator options options2))
    ((cl:and (cl:stringp separator) supplied-options (cl:numberp options) supplied-options2 (cl:or (cl:null options2) (dotnet:object-type options2)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Split" separator options options2))
    ((cl:and (cl:or (cl:null separator) (dotnet:object-type separator)) supplied-options (cl:numberp options) supplied-options2 (cl:or (cl:null options2) (dotnet:object-type options2)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Split" separator options options2))
    ((cl:and (cl:or (cl:null separator) (dotnet:object-type separator)) supplied-options (cl:or (cl:null options) (dotnet:object-type options)) (cl:not supplied-options2))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Split" separator options))
    ((cl:and (cl:or (cl:null separator) (dotnet:object-type separator)) supplied-options (cl:numberp options) (cl:not supplied-options2))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Split" separator options))
    ((cl:and (cl:or (cl:null separator) (dotnet:object-type separator)) supplied-options (cl:or (cl:null options) (dotnet:object-type options)) (cl:not supplied-options2))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Split" separator options))
    ((cl:and (cl:stringp separator) supplied-options (cl:or (cl:null options) (dotnet:object-type options)) (cl:not supplied-options2))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Split" separator options))
    ((cl:and (cl:or (cl:null separator) (dotnet:object-type separator)) supplied-options (cl:or (cl:null options) (dotnet:object-type options)) (cl:not supplied-options2))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Split" separator options))
    ((cl:and (cl:or (cl:null separator) (dotnet:object-type separator)) (cl:not supplied-options) (cl:not supplied-options2))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Split" separator))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "Split"
                    :supplied-args (cl:append (cl:list :separator separator) (cl:when supplied-options (cl:list :options options)) (cl:when supplied-options2 (cl:list :options2 options2)))))))

;; Note: System.String.Split also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   Split(params Char[]) -> String[]
;;   Split(Char, StringSplitOptions) -> String[]
;;   Split(String, StringSplitOptions) -> String[]
;;   Split(Char, Int32, StringSplitOptions) -> String[]
;;   Split(String, Int32, StringSplitOptions) -> String[]

(cl:defun starts-with (obj! value cl:&optional (comparison-type cl:nil supplied-comparison-type) (culture cl:nil supplied-culture))
  "Master wrapper for System.String.StartsWith overloads. Dispatches at runtime.

StartsWith(String) -> Boolean
  Summary: Determines whether the beginning of this string instance matches the specified string.
  Returns: if value matches the beginning of this string; otherwise, .
  Parameters:
    - value (System.String): The string to compare.

StartsWith(Char) -> Boolean
  Summary: Determines whether this string instance starts with the specified character.
  Returns: if value matches the beginning of this string; otherwise, .
  Parameters:
    - value (System.Char): The character to compare.

StartsWith(String, StringComparison) -> Boolean
  Summary: Determines whether the beginning of this string instance matches the specified string when compared using the specified comparison option.
  Returns: if this instance begins with value; otherwise, .
  Parameters:
    - value (System.String): The string to compare.
    - comparison-type (System.StringComparison): One of the enumeration values that determines how this string and value are compared.

StartsWith(String, Boolean, CultureInfo) -> Boolean
  Summary: Determines whether the beginning of this string instance matches the specified string when compared using the specified culture.
  Returns: if the value parameter matches the beginning of this string; otherwise, .
  Parameters:
    - value (System.String): The string to compare.
    - ignore-case (System.Boolean): to ignore case during the comparison; otherwise, .
    - culture (System.Globalization.CultureInfo): Cultural information that determines how this string and value are compared. If culture is , the current culture is used.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-comparison-type (cl:typep comparison-type 'cl:boolean) supplied-culture (cl:or (cl:null culture) (dotnet:object-type culture)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "StartsWith" value comparison-type culture))
    ((cl:and (cl:stringp value) supplied-comparison-type (cl:or (cl:null comparison-type) (dotnet:object-type comparison-type)) (cl:not supplied-culture))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "StartsWith" value comparison-type))
    ((cl:and (cl:stringp value) (cl:not supplied-comparison-type) (cl:not supplied-culture))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "StartsWith" value))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-comparison-type) (cl:not supplied-culture))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "StartsWith" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "StartsWith"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-comparison-type (cl:list :comparison-type comparison-type)) (cl:when supplied-culture (cl:list :culture culture)))))))

(cl:defun substring (obj! start-index cl:&optional (length cl:nil supplied-length))
  "Master wrapper for System.String.Substring overloads. Dispatches at runtime.

Substring(Int32) -> String
  Summary: Retrieves a substring from this instance. The substring starts at a specified character position and continues to the end of the string.
  Returns: A string that is equivalent to the substring that begins at startIndex in this instance, or System.String.Empty if startIndex is equal to the length of this instance.
  Parameters:
    - start-index (System.Int32): The zero-based starting character position of a substring in this instance.

Substring(Int32, Int32) -> String
  Summary: Retrieves a substring from this instance. The substring starts at a specified character position and has a specified length.
  Returns: A string that is equivalent to the substring of length length that begins at startIndex in this instance, or System.String.Empty if startIndex is equal to the length of this instance and length is zero.
  Parameters:
    - start-index (System.Int32): The zero-based starting character position of a substring in this instance.
    - length (System.Int32): The number of characters in the substring.
"
  (cl:cond
    ((cl:and (cl:numberp start-index) supplied-length (cl:numberp length))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Substring" start-index length))
    ((cl:and (cl:numberp start-index) (cl:not supplied-length))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Substring" start-index))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "Substring"
                    :supplied-args (cl:append (cl:list :start-index start-index) (cl:when supplied-length (cl:list :length length)))))))

(cl:defun to-char-array (obj! cl:&optional (start-index cl:nil supplied-start-index) (length cl:nil supplied-length))
  "Master wrapper for System.String.ToCharArray overloads. Dispatches at runtime.

ToCharArray() -> Char[]
  Summary: Copies the characters in this instance to a Unicode character array.
  Returns: A Unicode character array whose elements are the individual characters of this instance. If this instance is an empty string, the returned array is empty and has a zero length.

ToCharArray(Int32, Int32) -> Char[]
  Summary: Copies the characters in a specified substring in this instance to a Unicode character array.
  Returns: A Unicode character array whose elements are the length number of characters in this instance starting from character position startIndex.
  Parameters:
    - start-index (System.Int32): The starting position of a substring in this instance.
    - length (System.Int32): The length of the substring in this instance.
"
  (cl:cond
    ((cl:and supplied-start-index (cl:numberp start-index) supplied-length (cl:numberp length))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "ToCharArray" start-index length))
    ((cl:and (cl:not supplied-start-index) (cl:not supplied-length))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "ToCharArray"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "ToCharArray"
                    :supplied-args (cl:append (cl:when supplied-start-index (cl:list :start-index start-index)) (cl:when supplied-length (cl:list :length length)))))))

(cl:defun to-lower (obj! cl:&optional (culture cl:nil supplied-culture))
  "Master wrapper for System.String.ToLower overloads. Dispatches at runtime.

ToLower() -> String
  Summary: Returns a copy of this string converted to lowercase.
  Returns: A string in lowercase.

ToLower(CultureInfo) -> String
  Summary: Returns a copy of this string converted to lowercase, using the casing rules of the specified culture.
  Returns: The lowercase equivalent of the current string.
  Parameters:
    - culture (System.Globalization.CultureInfo): An object that supplies culture-specific casing rules. If culture is , the current culture is used.
"
  (cl:cond
    ((cl:and supplied-culture (cl:or (cl:null culture) (dotnet:object-type culture)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "ToLower" culture))
    ((cl:and (cl:not supplied-culture))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "ToLower"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "ToLower"
                    :supplied-args (cl:append (cl:when supplied-culture (cl:list :culture culture)))))))

(cl:defun to-lower-invariant (obj!)
  "Summary: Returns a copy of this System.String object converted to lowercase using the casing rules of the invariant culture.
Returns: The lowercase equivalent of the current string.
"
  (dotnet:invoke (cl:the (dotnet "System.String") obj!) "ToLowerInvariant"))

(cl:defun to-string (obj! cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.String.ToString overloads. Dispatches at runtime.

ToString() -> String
  Summary: Returns this instance of System.String; no actual conversion is performed.
  Returns: The current string.

ToString(IFormatProvider) -> String
  Summary: Returns this instance of System.String; no actual conversion is performed.
  Returns: The current string.
  Parameters:
    - provider (System.IFormatProvider): (Reserved) An object that supplies culture-specific formatting information.
"
  (cl:cond
    ((cl:and supplied-provider (cl:or (cl:null provider) (dotnet:object-type provider)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "ToString" provider))
    ((cl:and (cl:not supplied-provider))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "ToString"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "ToString"
                    :supplied-args (cl:append (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun to-upper (obj! cl:&optional (culture cl:nil supplied-culture))
  "Master wrapper for System.String.ToUpper overloads. Dispatches at runtime.

ToUpper() -> String
  Summary: Returns a copy of this string converted to uppercase.
  Returns: The uppercase equivalent of the current string.

ToUpper(CultureInfo) -> String
  Summary: Returns a copy of this string converted to uppercase, using the casing rules of the specified culture.
  Returns: The uppercase equivalent of the current string.
  Parameters:
    - culture (System.Globalization.CultureInfo): An object that supplies culture-specific casing rules. If culture is , the current culture is used.
"
  (cl:cond
    ((cl:and supplied-culture (cl:or (cl:null culture) (dotnet:object-type culture)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "ToUpper" culture))
    ((cl:and (cl:not supplied-culture))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "ToUpper"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "ToUpper"
                    :supplied-args (cl:append (cl:when supplied-culture (cl:list :culture culture)))))))

(cl:defun to-upper-invariant (obj!)
  "Summary: Returns a copy of this System.String object converted to uppercase using the casing rules of the invariant culture.
Returns: The uppercase equivalent of the current string.
"
  (dotnet:invoke (cl:the (dotnet "System.String") obj!) "ToUpperInvariant"))

(cl:defun trim (obj! cl:&optional (trim-char cl:nil supplied-trim-char))
  "Master wrapper for System.String.Trim overloads. Dispatches at runtime.

Trim() -> String
  Summary: Removes all leading and trailing white-space characters from the current string.
  Returns: The string that remains after all white-space characters are removed from the start and end of the current string. If no characters can be trimmed from the current instance, the method returns the current instance unchanged.

Trim(Char) -> String
  Summary: Removes all leading and trailing instances of a character from the current string.
  Returns: The string that remains after all instances of the trimChar character are removed from the start and end of the current string. If no characters can be trimmed from the current instance, the method returns the current instance unchanged.
  Parameters:
    - trim-char (System.Char): A Unicode character to remove.

Trim(Char]) -> String
"
  (cl:cond
    ((cl:and supplied-trim-char (cl:or (cl:null trim-char) (dotnet:object-type trim-char)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Trim" trim-char))
    ((cl:and supplied-trim-char (cl:or (cl:null trim-char) (dotnet:object-type trim-char)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Trim" trim-char))
    ((cl:and (cl:not supplied-trim-char))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "Trim"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "Trim"
                    :supplied-args (cl:append (cl:when supplied-trim-char (cl:list :trim-char trim-char)))))))

;; Note: System.String.Trim also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   Trim(params Char[]) -> String

(cl:defun trim-end (obj! cl:&optional (trim-char cl:nil supplied-trim-char))
  "Master wrapper for System.String.TrimEnd overloads. Dispatches at runtime.

TrimEnd() -> String
  Summary: Removes all the trailing white-space characters from the current string.
  Returns: The string that remains after all white-space characters are removed from the end of the current string. If no characters can be trimmed from the current instance, the method returns the current instance unchanged.

TrimEnd(Char) -> String
  Summary: Removes all the trailing occurrences of a character from the current string.
  Returns: The string that remains after all occurrences of the trimChar character are removed from the end of the current string. If no characters can be trimmed from the current instance, the method returns the current instance unchanged.
  Parameters:
    - trim-char (System.Char): A Unicode character to remove.

TrimEnd(Char]) -> String
"
  (cl:cond
    ((cl:and supplied-trim-char (cl:or (cl:null trim-char) (dotnet:object-type trim-char)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "TrimEnd" trim-char))
    ((cl:and supplied-trim-char (cl:or (cl:null trim-char) (dotnet:object-type trim-char)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "TrimEnd" trim-char))
    ((cl:and (cl:not supplied-trim-char))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "TrimEnd"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "TrimEnd"
                    :supplied-args (cl:append (cl:when supplied-trim-char (cl:list :trim-char trim-char)))))))

;; Note: System.String.TrimEnd also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   TrimEnd(params Char[]) -> String

(cl:defun trim-start (obj! cl:&optional (trim-char cl:nil supplied-trim-char))
  "Master wrapper for System.String.TrimStart overloads. Dispatches at runtime.

TrimStart() -> String
  Summary: Removes all the leading white-space characters from the current string.
  Returns: The string that remains after all white-space characters are removed from the start of the current string. If no characters can be trimmed from the current instance, the method returns the current instance unchanged.

TrimStart(Char) -> String
  Summary: Removes all the leading occurrences of a specified character from the current string.
  Returns: The string that remains after all occurrences of the trimChar character are removed from the start of the current string. If no characters can be trimmed from the current instance, the method returns the current instance unchanged.
  Parameters:
    - trim-char (System.Char): The Unicode character to remove.

TrimStart(Char]) -> String
"
  (cl:cond
    ((cl:and supplied-trim-char (cl:or (cl:null trim-char) (dotnet:object-type trim-char)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "TrimStart" trim-char))
    ((cl:and supplied-trim-char (cl:or (cl:null trim-char) (dotnet:object-type trim-char)))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "TrimStart" trim-char))
    ((cl:and (cl:not supplied-trim-char))
     (dotnet:invoke (cl:the (dotnet "System.String") obj!) "TrimStart"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-STRING"
                    :class-name <type-str>
                    :method-name "TrimStart"
                    :supplied-args (cl:append (cl:when supplied-trim-char (cl:list :trim-char trim-char)))))))

;; Note: System.String.TrimStart also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   TrimStart(params Char[]) -> String

(cl:defun try-copy-to (obj! destination)
  "Summary: Copies the contents of this string into the destination span.
Returns: if the data was copied; if the destination was too short to fit the contents of the string.
Parameters:
  - destination (System.Span`1[System.Char]): The span into which to copy this string's contents.
"
  (dotnet:invoke (cl:the (dotnet "System.String") obj!) "TryCopyTo" destination))

