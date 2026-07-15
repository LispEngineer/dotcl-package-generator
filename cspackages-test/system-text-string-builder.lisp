;;; Generated automatically. Do not edit.
;;; Class: System.Text.StringBuilder
;;; Generator Version: 50
;;; Creation Date: 2026-07-15T12:15:32Z

(cl:in-package :system-text-string-builder)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Text.StringBuilder"))
(cl:defconstant <type-str> "System.Text.StringBuilder")
(cl:defconstant <creation> "2026-07-15T12:15:32Z")
(cl:defconstant <version> 50)

(cl:defun new (cl:&optional (capacity cl:nil supplied-capacity) (capacity2 cl:nil supplied-capacity2) (length cl:nil supplied-length) (capacity3 cl:nil supplied-capacity3))
  "Master wrapper for System.Text.StringBuilder constructor overloads. Dispatches at runtime.

new()
  Summary: Initializes a new instance of the System.Text.StringBuilder class.

new(Int32)
  Summary: Initializes a new instance of the System.Text.StringBuilder class using the specified capacity.
  Parameters:
    - capacity (System.Int32): The suggested starting size of this instance.

new(String)
  Summary: Initializes a new instance of the System.Text.StringBuilder class using the specified string.
  Parameters:
    - value (System.String): The string used to initialize the value of the instance. If value is , the new System.Text.StringBuilder will contain the empty string (that is, it contains System.String.Empty).

new(String, Int32)
  Summary: Initializes a new instance of the System.Text.StringBuilder class using the specified string and capacity.
  Parameters:
    - value (System.String): The string used to initialize the value of the instance. If value is , the new System.Text.StringBuilder will contain the empty string (that is, it contains System.String.Empty).
    - capacity (System.Int32): The suggested starting size of the System.Text.StringBuilder.

new(Int32, Int32)
  Summary: Initializes a new instance of the System.Text.StringBuilder class that starts with a specified capacity and can grow to a specified maximum.
  Parameters:
    - capacity (System.Int32): The suggested starting size of the System.Text.StringBuilder.
    - max-capacity (System.Int32): The maximum number of characters the current string can contain.

new(String, Int32, Int32, Int32)
  Summary: Initializes a new instance of the System.Text.StringBuilder class from the specified substring and capacity.
  Parameters:
    - value (System.String): The string that contains the substring used to initialize the value of this instance. If value is , the new System.Text.StringBuilder will contain the empty string (that is, it contains System.String.Empty).
    - start-index (System.Int32): The position within value where the substring begins.
    - length (System.Int32): The number of characters in the substring.
    - capacity (System.Int32): The suggested starting size of the System.Text.StringBuilder.
"
  (cl:cond
    ((cl:and supplied-capacity (cl:stringp capacity) supplied-capacity2 (cl:numberp capacity2) supplied-length (cl:numberp length) supplied-capacity3 (cl:numberp capacity3))
     (dotnet:new <type-str> capacity capacity2 length capacity3))
    ((cl:and supplied-capacity (cl:stringp capacity) supplied-capacity2 (cl:numberp capacity2) (cl:not supplied-length) (cl:not supplied-capacity3))
     (dotnet:new <type-str> capacity capacity2))
    ((cl:and supplied-capacity (cl:numberp capacity) supplied-capacity2 (cl:numberp capacity2) (cl:not supplied-length) (cl:not supplied-capacity3))
     (dotnet:new <type-str> capacity capacity2))
    ((cl:and supplied-capacity (cl:numberp capacity) (cl:not supplied-capacity2) (cl:not supplied-length) (cl:not supplied-capacity3))
     (dotnet:new <type-str> capacity))
    ((cl:and supplied-capacity (cl:stringp capacity) (cl:not supplied-capacity2) (cl:not supplied-length) (cl:not supplied-capacity3))
     (dotnet:new <type-str> capacity))
    ((cl:and (cl:not supplied-capacity) (cl:not supplied-capacity2) (cl:not supplied-length) (cl:not supplied-capacity3))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TEXT-STRING-BUILDER"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-capacity (cl:list :capacity capacity)) (cl:when supplied-capacity2 (cl:list :capacity2 capacity2)) (cl:when supplied-length (cl:list :length length)) (cl:when supplied-capacity3 (cl:list :capacity3 capacity3)))))))

(cl:defun capacity (obj!)
  "Gets or sets the maximum number of characters that can be contained in the memory allocated by the current instance."
  (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "get_Capacity"))

(cl:defun (cl:setf capacity) (new-value obj!)
  "Gets or sets the maximum number of characters that can be contained in the memory allocated by the current instance."
  (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "set_Capacity" new-value))

(cl:defun chars (obj! index)
  (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "get_Chars" index))

(cl:defun (cl:setf chars) (new-value obj! index)
  (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "set_Chars" index new-value))

(cl:defun length (obj!)
  "Gets or sets the length of the current System.Text.StringBuilder object."
  (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "get_Length"))

(cl:defun (cl:setf length) (new-value obj!)
  "Gets or sets the length of the current System.Text.StringBuilder object."
  (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "set_Length" new-value))

(cl:defun max-capacity (obj!)
  "Gets the maximum capacity of this instance."
  (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "get_MaxCapacity"))

(cl:defun append (obj! value cl:&optional (repeat-count cl:nil supplied-repeat-count) (char-count cl:nil supplied-char-count))
  "Master wrapper for System.Text.StringBuilder.Append overloads. Dispatches at runtime.

Append(String) -> StringBuilder
  Summary: Appends a copy of the specified string to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.String): The string to append.

Append(StringBuilder) -> StringBuilder
  Summary: Appends the string representation of a specified string builder to this instance.
  Returns: A reference to this instance after the append operation is completed.
  Parameters:
    - value (System.Text.StringBuilder): The string builder to append.

Append(Boolean) -> StringBuilder
  Summary: Appends the string representation of a specified Boolean value to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.Boolean): The Boolean value to append.

Append(Char) -> StringBuilder
  Summary: Appends the string representation of a specified System.Char object to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.Char): The UTF-16-encoded code unit to append.

Append(SByte) -> StringBuilder
  Summary: Appends the string representation of a specified 8-bit signed integer to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.SByte): The value to append.

Append(Byte) -> StringBuilder
  Summary: Appends the string representation of a specified 8-bit unsigned integer to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.Byte): The value to append.

Append(Int16) -> StringBuilder
  Summary: Appends the string representation of a specified 16-bit signed integer to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.Int16): The value to append.

Append(Int32) -> StringBuilder
  Summary: Appends the string representation of a specified 32-bit signed integer to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.Int32): The value to append.

Append(Int64) -> StringBuilder
  Summary: Appends the string representation of a specified 64-bit signed integer to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.Int64): The value to append.

Append(Single) -> StringBuilder
  Summary: Appends the string representation of a specified single-precision floating-point number to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.Single): The value to append.

Append(Double) -> StringBuilder
  Summary: Appends the string representation of a specified double-precision floating-point number to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.Double): The value to append.

Append(Decimal) -> StringBuilder
  Summary: Appends the string representation of a specified decimal number to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.Decimal): The value to append.

Append(UInt16) -> StringBuilder
  Summary: Appends the string representation of a specified 16-bit unsigned integer to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.UInt16): The value to append.

Append(UInt32) -> StringBuilder
  Summary: Appends the string representation of a specified 32-bit unsigned integer to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.UInt32): The value to append.

Append(UInt64) -> StringBuilder
  Summary: Appends the string representation of a specified 64-bit unsigned integer to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.UInt64): The value to append.

Append(Object) -> StringBuilder
  Summary: Appends the string representation of a specified object to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.Object): The object to append.

Append(Char[]) -> StringBuilder
  Summary: Appends the string representation of the Unicode characters in a specified array to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.Char[]): The array of characters to append.

Append(Char]) -> StringBuilder
  Summary: Appends the string representation of a specified read-only character span to this instance.
  Returns: A reference to this instance after the append operation is completed.
  Parameters:
    - value (System.ReadOnlySpan`1[System.Char]): The read-only character span to append.

Append(Char]) -> StringBuilder
  Summary: Appends the string representation of a specified read-only character memory region to this instance.
  Returns: A reference to this instance after the append operation is completed.
  Parameters:
    - value (System.ReadOnlyMemory`1[System.Char]): The read-only character memory region to append.

Append(Char, Int32) -> StringBuilder
  Summary: Appends a specified number of copies of the string representation of a Unicode character to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.Char): The character to append.
    - repeat-count (System.Int32): The number of times to append value.

Append(Char*, Int32) -> StringBuilder
  Summary: Appends an array of Unicode characters starting at a specified address to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.Char*): A pointer to an array of characters.
    - value-count (System.Int32): The number of characters in the array.

Append(Char[], Int32, Int32) -> StringBuilder
  Summary: Appends the string representation of a specified subarray of Unicode characters to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.Char[]): A character array.
    - start-index (System.Int32): The starting position in value.
    - char-count (System.Int32): The number of characters to append.

Append(String, Int32, Int32) -> StringBuilder
  Summary: Appends a copy of a specified substring to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.String): The string that contains the substring to append.
    - start-index (System.Int32): The starting position of the substring within value.
    - count (System.Int32): The number of characters in value to append.

Append(StringBuilder, Int32, Int32) -> StringBuilder
  Summary: Appends a copy of a substring within a specified string builder to this instance.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.Text.StringBuilder): The string builder that contains the substring to append.
    - start-index (System.Int32): The starting position of the substring within value.
    - count (System.Int32): The number of characters in value to append.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Text.StringBuilder")) supplied-repeat-count (cl:numberp repeat-count) supplied-char-count (cl:numberp char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value repeat-count char-count))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char[]")) supplied-repeat-count (cl:numberp repeat-count) supplied-char-count (cl:numberp char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value repeat-count char-count))
    ((cl:and (cl:stringp value) supplied-repeat-count (cl:numberp repeat-count) supplied-char-count (cl:numberp char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value repeat-count char-count))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char*")) supplied-repeat-count (cl:numberp repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value repeat-count))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) supplied-repeat-count (cl:numberp repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value repeat-count))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.ReadOnlyMemory`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.ReadOnlySpan`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char[]")) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:numberp value) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:numberp value) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:numberp value) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:numberp value) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:numberp value) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:numberp value) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Text.StringBuilder")) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:numberp value) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    ((cl:and (cl:stringp value) (cl:not supplied-repeat-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Append" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TEXT-STRING-BUILDER"
                    :class-name <type-str>
                    :method-name "Append"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-repeat-count (cl:list :repeat-count repeat-count)) (cl:when supplied-char-count (cl:list :char-count char-count)))))))

;; Note: System.Text.StringBuilder.Append also has the following overloads with special
;; parameter types (ref, out, or params) that are not
;; yet supported:
;;   Append(ref StringBuilder+AppendInterpolatedStringHandler&) -> StringBuilder
;;   Append(IFormatProvider, ref StringBuilder+AppendInterpolatedStringHandler&) -> StringBuilder

(cl:defun append-format (obj! format arg0 cl:&optional (arg1 cl:nil supplied-arg1) (arg2 cl:nil supplied-arg2) (arg22 cl:nil supplied-arg22))
  "Master wrapper for System.Text.StringBuilder.AppendFormat overloads. Dispatches at runtime.

AppendFormat(String, Object) -> StringBuilder
  Summary: Appends the string returned by processing a composite format string, which contains zero or more format items, to this instance. Each format item is replaced by the string representation of a single argument.
  Returns: A reference to this instance with format appended. Each format item in format is replaced by the string representation of arg0.
  Parameters:
    - format (System.String): A composite format string.
    - arg0 (System.Object): An object to format.

AppendFormat(String, Object]) -> StringBuilder
  Summary: Appends the string returned by processing a composite format string, which contains zero or more format items, to this instance. Each format item is replaced by the string representation of a corresponding argument in a parameter span.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - format (System.String): A composite format string.
    - args (System.ReadOnlySpan`1[System.Object]): A span of objects to format.

AppendFormat(String, Object, Object) -> StringBuilder
  Summary: Appends the string returned by processing a composite format string, which contains zero or more format items, to this instance. Each format item is replaced by the string representation of either of two arguments.
  Returns: A reference to this instance with format appended. Each format item in format is replaced by the string representation of the corresponding object argument.
  Parameters:
    - format (System.String): A composite format string.
    - arg0 (System.Object): The first object to format.
    - arg1 (System.Object): The second object to format.

AppendFormat(IFormatProvider, String, Object) -> StringBuilder
  Summary: Appends the string returned by processing a composite format string, which contains zero or more format items, to this instance. Each format item is replaced by the string representation of a single argument using a specified format provider.
  Returns: A reference to this instance after the append operation has completed. After the append operation, this instance contains any data that existed before the operation, suffixed by a copy of format in which any format specification is replaced by the string representation of arg0.
  Parameters:
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
    - format (System.String): A composite format string.
    - arg0 (System.Object): The object to format.

AppendFormat(IFormatProvider, String, Object]) -> StringBuilder
  Summary: Appends the string returned by processing a composite format string, which contains zero or more format items, to this instance. Each format item is replaced by the string representation of a corresponding argument in a parameter span using a specified format provider.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
    - format (System.String): A composite format string.
    - args (System.ReadOnlySpan`1[System.Object]): A span of objects to format.

AppendFormat(IFormatProvider, CompositeFormat, Object]) -> StringBuilder
  Summary: Appends the string returned by processing a composite format string, which contains zero or more format items, to this instance. Each format item is replaced by the string representation of any of the arguments using a specified format provider.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
    - format (System.Text.CompositeFormat): A System.Text.CompositeFormat.
    - args (System.ReadOnlySpan`1[System.Object]): A span of objects to format.

AppendFormat(String, Object, Object, Object) -> StringBuilder
  Summary: Appends the string returned by processing a composite format string, which contains zero or more format items, to this instance. Each format item is replaced by the string representation of either of three arguments.
  Returns: A reference to this instance with format appended. Each format item in format is replaced by the string representation of the corresponding object argument.
  Parameters:
    - format (System.String): A composite format string.
    - arg0 (System.Object): The first object to format.
    - arg1 (System.Object): The second object to format.
    - arg2 (System.Object): The third object to format.

AppendFormat(IFormatProvider, String, Object, Object) -> StringBuilder
  Summary: Appends the string returned by processing a composite format string, which contains zero or more format items, to this instance. Each format item is replaced by the string representation of either of two arguments using a specified format provider.
  Returns: A reference to this instance after the append operation has completed. After the append operation, this instance contains any data that existed before the operation, suffixed by a copy of format where any format specification is replaced by the string representation of the corresponding object argument.
  Parameters:
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
    - format (System.String): A composite format string.
    - arg0 (System.Object): The first object to format.
    - arg1 (System.Object): The second object to format.

AppendFormat(IFormatProvider, String, Object, Object, Object) -> StringBuilder
  Summary: Appends the string returned by processing a composite format string, which contains zero or more format items, to this instance. Each format item is replaced by the string representation of either of three arguments using a specified format provider.
  Returns: A reference to this instance after the append operation has completed. After the append operation, this instance contains any data that existed before the operation, suffixed by a copy of format where any format specification is replaced by the string representation of the corresponding object argument.
  Parameters:
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
    - format (System.String): A composite format string.
    - arg0 (System.Object): The first object to format.
    - arg1 (System.Object): The second object to format.
    - arg2 (System.Object): The third object to format.
"
  (cl:cond
    ((cl:and (cl:or (cl:null format) (dotnet:is-instance-of format "System.IFormatProvider")) (cl:stringp arg0) supplied-arg1 (cl:or (cl:null arg1) (dotnet:is-instance-of arg1 "System.Object")) supplied-arg2 (cl:or (cl:null arg2) (dotnet:is-instance-of arg2 "System.Object")) supplied-arg22 (cl:or (cl:null arg22) (dotnet:is-instance-of arg22 "System.Object")))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendFormat" format arg0 arg1 arg2 arg22))
    ((cl:and (cl:stringp format) (cl:or (cl:null arg0) (dotnet:is-instance-of arg0 "System.Object")) supplied-arg1 (cl:or (cl:null arg1) (dotnet:is-instance-of arg1 "System.Object")) supplied-arg2 (cl:or (cl:null arg2) (dotnet:is-instance-of arg2 "System.Object")) (cl:not supplied-arg22))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendFormat" format arg0 arg1 arg2))
    ((cl:and (cl:or (cl:null format) (dotnet:is-instance-of format "System.IFormatProvider")) (cl:stringp arg0) supplied-arg1 (cl:or (cl:null arg1) (dotnet:is-instance-of arg1 "System.Object")) supplied-arg2 (cl:or (cl:null arg2) (dotnet:is-instance-of arg2 "System.Object")) (cl:not supplied-arg22))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendFormat" format arg0 arg1 arg2))
    ((cl:and (cl:stringp format) (cl:or (cl:null arg0) (dotnet:is-instance-of arg0 "System.Object")) supplied-arg1 (cl:or (cl:null arg1) (dotnet:is-instance-of arg1 "System.Object")) (cl:not supplied-arg2) (cl:not supplied-arg22))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendFormat" format arg0 arg1))
    ((cl:and (cl:or (cl:null format) (dotnet:is-instance-of format "System.IFormatProvider")) (cl:stringp arg0) supplied-arg1 (cl:or (cl:null arg1) (dotnet:is-instance-of arg1 "System.Object")) (cl:not supplied-arg2) (cl:not supplied-arg22))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendFormat" format arg0 arg1))
    ((cl:and (cl:or (cl:null format) (dotnet:is-instance-of format "System.IFormatProvider")) (cl:stringp arg0) supplied-arg1 (cl:or (cl:null arg1) (dotnet:is-instance-of arg1 "System.ReadOnlySpan`1[[System.Object, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-arg2) (cl:not supplied-arg22))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendFormat" format arg0 arg1))
    ((cl:and (cl:or (cl:null format) (dotnet:is-instance-of format "System.IFormatProvider")) (cl:or (cl:null arg0) (dotnet:is-instance-of arg0 "System.Text.CompositeFormat")) supplied-arg1 (cl:or (cl:null arg1) (dotnet:is-instance-of arg1 "System.ReadOnlySpan`1[[System.Object, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-arg2) (cl:not supplied-arg22))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendFormat" format arg0 arg1))
    ((cl:and (cl:stringp format) (cl:or (cl:null arg0) (dotnet:is-instance-of arg0 "System.Object")) (cl:not supplied-arg1) (cl:not supplied-arg2) (cl:not supplied-arg22))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendFormat" format arg0))
    ((cl:and (cl:stringp format) (cl:or (cl:null arg0) (dotnet:is-instance-of arg0 "System.ReadOnlySpan`1[[System.Object, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-arg1) (cl:not supplied-arg2) (cl:not supplied-arg22))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendFormat" format arg0))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TEXT-STRING-BUILDER"
                    :class-name <type-str>
                    :method-name "AppendFormat"
                    :supplied-args (cl:append (cl:list :format format) (cl:list :arg0 arg0) (cl:when supplied-arg1 (cl:list :arg1 arg1)) (cl:when supplied-arg2 (cl:list :arg2 arg2)) (cl:when supplied-arg22 (cl:list :arg22 arg22)))))))

(cl:defun append-format-arity-1 (type obj! provider format arg0)
  "Summary: Appends the string returned by processing a composite format string, which contains zero or more format items, to this instance. Each format item is replaced by the string representation of any of the arguments using a specified format provider.
Returns: A reference to this instance after the append operation has completed.
Parameters:
  - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
  - format (System.Text.CompositeFormat): A System.Text.CompositeFormat.
  - arg0 (TArg0): The first object to format.
"
  (dotnet:invoke-generic (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendFormat" (cl:list type) provider format arg0))

(cl:defun append-format-arity-2 (type-1 type-2 obj! provider format arg0 arg1)
  "Summary: Appends the string returned by processing a composite format string, which contains zero or more format items, to this instance. Each format item is replaced by the string representation of any of the arguments using a specified format provider.
Returns: A reference to this instance after the append operation has completed.
Parameters:
  - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
  - format (System.Text.CompositeFormat): A System.Text.CompositeFormat.
  - arg0 (TArg0): The first object to format.
  - arg1 (TArg1): The second object to format.
"
  (dotnet:invoke-generic (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendFormat" (cl:list type-1 type-2) provider format arg0 arg1))

(cl:defun append-format-arity-3 (type-1 type-2 type-3 obj! provider format arg0 arg1 arg2)
  "Summary: Appends the string returned by processing a composite format string, which contains zero or more format items, to this instance. Each format item is replaced by the string representation of any of the arguments using a specified format provider.
Returns: A reference to this instance after the append operation has completed.
Parameters:
  - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
  - format (System.Text.CompositeFormat): A System.Text.CompositeFormat.
  - arg0 (TArg0): The first object to format.
  - arg1 (TArg1): The second object to format.
  - arg2 (TArg2): The third object to format.
"
  (dotnet:invoke-generic (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendFormat" (cl:list type-1 type-2 type-3) provider format arg0 arg1 arg2))

(cl:defun append-format<> (types cl:&rest args)
  "Dispatches append-format<> by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload.
   Passing cl:nil or an empty list calls the non-generic append-format overload(s)."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (0 (cl:apply (cl:function append-format) args))
      (1 (cl:apply (cl:function append-format-arity-1) (cl:append type-list args)))
      (2 (cl:apply (cl:function append-format-arity-2) (cl:append type-list args)))
      (3 (cl:apply (cl:function append-format-arity-3) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-TEXT-STRING-BUILDER"
                      :class-name <type-str>
                      :method-name "append-format<>"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

;; Note: System.Text.StringBuilder.AppendFormat also has the following overloads with special
;; parameter types (ref, out, or params) that are not
;; yet supported:
;;   AppendFormat(String, params Object[]) -> StringBuilder
;;   AppendFormat(IFormatProvider, String, params Object[]) -> StringBuilder
;;   AppendFormat(IFormatProvider, CompositeFormat, params Object[]) -> StringBuilder

(cl:defun append-join (obj! separator values)
  "Master wrapper for System.Text.StringBuilder.AppendJoin overloads. Dispatches at runtime.

AppendJoin(String, Object]) -> StringBuilder
  Summary: Concatenates the string representations of the elements in the provided span of objects, using the specified separator between each member, then appends the result to the current instance of the string builder.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - separator (System.String): The string to use as a separator. separator is included in the joined strings only if values has more than one element.
    - values (System.ReadOnlySpan`1[System.Object]): A span that contains the strings to concatenate and append to the current instance of the string builder.

AppendJoin(String, String]) -> StringBuilder
  Summary: Concatenates the strings of the provided span, using the specified separator between each string, then appends the result to the current instance of the string builder.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - separator (System.String): The string to use as a separator. separator is included in the joined strings only if values has more than one element.
    - values (System.ReadOnlySpan`1[System.String]): A span that contains the strings to concatenate and append to the current instance of the string builder.

AppendJoin(Char, Object]) -> StringBuilder
  Summary: Concatenates the string representations of the elements in the provided span of objects, using the specified char separator between each member, then appends the result to the current instance of the string builder.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - separator (System.Char): The character to use as a separator. separator is included in the joined strings only if values has more than one element.
    - values (System.ReadOnlySpan`1[System.Object]): A span that contains the strings to concatenate and append to the current instance of the string builder.

AppendJoin(Char, String]) -> StringBuilder
  Summary: Concatenates the strings of the provided span, using the specified char separator between each string, then appends the result to the current instance of the string builder.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - separator (System.Char): The character to use as a separator. separator is included in the joined strings only if values has more than one element.
    - values (System.ReadOnlySpan`1[System.String]): A span that contains the strings to concatenate and append to the current instance of the string builder.
"
  (cl:cond
    ((cl:and (cl:stringp separator) (cl:or (cl:null values) (dotnet:is-instance-of values "System.ReadOnlySpan`1[[System.Object, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendJoin" separator values))
    ((cl:and (cl:stringp separator) (cl:or (cl:null values) (dotnet:is-instance-of values "System.ReadOnlySpan`1[[System.String, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendJoin" separator values))
    ((cl:and (cl:or (cl:null separator) (dotnet:is-instance-of separator "System.Char")) (cl:or (cl:null values) (dotnet:is-instance-of values "System.ReadOnlySpan`1[[System.Object, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendJoin" separator values))
    ((cl:and (cl:or (cl:null separator) (dotnet:is-instance-of separator "System.Char")) (cl:or (cl:null values) (dotnet:is-instance-of values "System.ReadOnlySpan`1[[System.String, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendJoin" separator values))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TEXT-STRING-BUILDER"
                    :class-name <type-str>
                    :method-name "AppendJoin"
                    :supplied-args (cl:append (cl:list :separator separator) (cl:list :values values))))))

(cl:defun append-join-arity-1 (type obj! separator values)
  "Master wrapper for System.Text.StringBuilder.AppendJoin overloads. Dispatches at runtime.

AppendJoin(String, IEnumerable) -> StringBuilder
  Summary: Concatenates and appends the members of a collection, using the specified separator between each member.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - separator (System.String): The string to use as a separator. separator is included in the concatenated and appended strings only if values has more than one element.
    - values (System.Collections.Generic.IEnumerable`1[T]): A collection that contains the objects to concatenate and append to the current instance of the string builder.

AppendJoin(Char, IEnumerable) -> StringBuilder
  Summary: Concatenates and appends the members of a collection, using the specified char separator between each member.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - separator (System.Char): The character to use as a separator. separator is included in the concatenated and appended strings only if values has more than one element.
    - values (System.Collections.Generic.IEnumerable`1[T]): A collection that contains the objects to concatenate and append to the current instance of the string builder.
"
  (cl:cond
    ((cl:and (cl:stringp separator) (cl:or (cl:null values) (dotnet:is-instance-of values "System.Collections.Generic.IEnumerable`1[T]")))
     (dotnet:invoke-generic (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendJoin" (cl:list type) separator values))
    ((cl:and (cl:or (cl:null separator) (dotnet:is-instance-of separator "System.Char")) (cl:or (cl:null values) (dotnet:is-instance-of values "System.Collections.Generic.IEnumerable`1[T]")))
     (dotnet:invoke-generic (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendJoin" (cl:list type) separator values))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TEXT-STRING-BUILDER"
                    :class-name <type-str>
                    :method-name "AppendJoin"
                    :supplied-args (cl:append (cl:list :separator separator) (cl:list :values values))))))

(cl:defun append-join<> (types cl:&rest args)
  "Dispatches append-join<> by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload.
   Passing cl:nil or an empty list calls the non-generic append-join overload(s)."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (0 (cl:apply (cl:function append-join) args))
      (1 (cl:apply (cl:function append-join-arity-1) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-TEXT-STRING-BUILDER"
                      :class-name <type-str>
                      :method-name "append-join<>"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

;; Note: System.Text.StringBuilder.AppendJoin also has the following overloads with special
;; parameter types (ref, out, or params) that are not
;; yet supported:
;;   AppendJoin(String, params Object[]) -> StringBuilder
;;   AppendJoin(String, params String[]) -> StringBuilder
;;   AppendJoin(Char, params Object[]) -> StringBuilder
;;   AppendJoin(Char, params String[]) -> StringBuilder

(cl:defun append-line (obj! cl:&optional (value cl:nil supplied-value))
  "Master wrapper for System.Text.StringBuilder.AppendLine overloads. Dispatches at runtime.

AppendLine() -> StringBuilder
  Summary: Appends the default line terminator to the end of the current System.Text.StringBuilder object.
  Returns: A reference to this instance after the append operation has completed.

AppendLine(String) -> StringBuilder
  Summary: Appends a copy of the specified string followed by the default line terminator to the end of the current System.Text.StringBuilder object.
  Returns: A reference to this instance after the append operation has completed.
  Parameters:
    - value (System.String): The string to append.
"
  (cl:cond
    ((cl:and supplied-value (cl:stringp value))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendLine" value))
    ((cl:and (cl:not supplied-value))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "AppendLine"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TEXT-STRING-BUILDER"
                    :class-name <type-str>
                    :method-name "AppendLine"
                    :supplied-args (cl:append (cl:when supplied-value (cl:list :value value)))))))

;; Note: System.Text.StringBuilder.AppendLine also has the following overloads with special
;; parameter types (ref, out, or params) that are not
;; yet supported:
;;   AppendLine(ref StringBuilder+AppendInterpolatedStringHandler&) -> StringBuilder
;;   AppendLine(IFormatProvider, ref StringBuilder+AppendInterpolatedStringHandler&) -> StringBuilder

(cl:defun clear (obj!)
  "Summary: Removes all characters from the current System.Text.StringBuilder instance.
Returns: An object whose System.Text.StringBuilder.Length is 0 (zero).
"
  (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Clear"))

(cl:defun copy-to (obj! source-index destination count cl:&optional (count2 cl:nil supplied-count2))
  "Master wrapper for System.Text.StringBuilder.CopyTo overloads. Dispatches at runtime.

CopyTo(Int32, Char], Int32) -> Void
  Summary: Copies the characters from a specified segment of this instance to a destination System.Char span.
  Parameters:
    - source-index (System.Int32): The starting position in this instance where characters will be copied from. The index is zero-based.
    - destination (System.Span`1[System.Char]): The writable span where characters will be copied.
    - count (System.Int32): The number of characters to be copied.

CopyTo(Int32, Char[], Int32, Int32) -> Void
  Summary: Copies the characters from a specified segment of this instance to a specified segment of a destination System.Char array.
  Parameters:
    - source-index (System.Int32): The starting position in this instance where characters will be copied from. The index is zero-based.
    - destination (System.Char[]): The array where characters will be copied.
    - destination-index (System.Int32): The starting position in destination where characters will be copied. The index is zero-based.
    - count (System.Int32): The number of characters to be copied.
"
  (cl:cond
    ((cl:and (cl:numberp source-index) (cl:or (cl:null destination) (dotnet:is-instance-of destination "System.Char[]")) (cl:numberp count) supplied-count2 (cl:numberp count2))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "CopyTo" source-index destination count count2))
    ((cl:and (cl:numberp source-index) (cl:or (cl:null destination) (dotnet:is-instance-of destination "System.Span`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:numberp count) (cl:not supplied-count2))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "CopyTo" source-index destination count))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TEXT-STRING-BUILDER"
                    :class-name <type-str>
                    :method-name "CopyTo"
                    :supplied-args (cl:append (cl:list :source-index source-index) (cl:list :destination destination) (cl:list :count count) (cl:when supplied-count2 (cl:list :count2 count2)))))))

(cl:defun ensure-capacity (obj! capacity)
  "Summary: Ensures that the capacity of this instance of System.Text.StringBuilder is at least the specified value.
Returns: The new capacity of this instance.
Parameters:
  - capacity (System.Int32): The minimum capacity to ensure.
"
  (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "EnsureCapacity" capacity))

(cl:defun equals (obj! sb)
  "Master wrapper for System.Text.StringBuilder.Equals overloads. Dispatches at runtime.

Equals(StringBuilder) -> Boolean
  Summary: Returns a value indicating whether this instance is equal to a specified object.
  Returns: if this instance and sb have equal string, System.Text.StringBuilder.Capacity, and System.Text.StringBuilder.MaxCapacity values; otherwise, .
  Parameters:
    - sb (System.Text.StringBuilder): An object to compare with this instance, or .

Equals(Char]) -> Boolean
  Summary: Returns a value indicating whether the characters in this instance are equal to the characters in a specified read-only character span.
  Returns: if the characters in this instance and span are the same; otherwise, .
  Parameters:
    - span (System.ReadOnlySpan`1[System.Char]): The character span to compare with the current instance.
"
  (cl:cond
    ((cl:and (cl:or (cl:null sb) (dotnet:is-instance-of sb "System.Text.StringBuilder")))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Equals" sb))
    ((cl:and (cl:or (cl:null sb) (dotnet:is-instance-of sb "System.ReadOnlySpan`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Equals" sb))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TEXT-STRING-BUILDER"
                    :class-name <type-str>
                    :method-name "Equals"
                    :supplied-args (cl:append (cl:list :sb sb))))))

(cl:defun get-chunks (obj!)
  "Summary: Returns an object that can be used to iterate through the chunks of characters represented in a created from this System.Text.StringBuilder instance.
Returns: An enumerator for the chunks in the .
"
  (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "GetChunks"))

(cl:defun insert (obj! index value cl:&optional (count cl:nil supplied-count) (char-count cl:nil supplied-char-count))
  "Master wrapper for System.Text.StringBuilder.Insert overloads. Dispatches at runtime.

Insert(Int32, String) -> StringBuilder
  Summary: Inserts a string into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.String): The string to insert.

Insert(Int32, Boolean) -> StringBuilder
  Summary: Inserts the string representation of a Boolean value into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.Boolean): The value to insert.

Insert(Int32, SByte) -> StringBuilder
  Summary: Inserts the string representation of a specified 8-bit signed integer into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.SByte): The value to insert.

Insert(Int32, Byte) -> StringBuilder
  Summary: Inserts the string representation of a specified 8-bit unsigned integer into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.Byte): The value to insert.

Insert(Int32, Int16) -> StringBuilder
  Summary: Inserts the string representation of a specified 16-bit signed integer into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.Int16): The value to insert.

Insert(Int32, Char) -> StringBuilder
  Summary: Inserts the string representation of a specified Unicode character into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.Char): The value to insert.

Insert(Int32, Char[]) -> StringBuilder
  Summary: Inserts the string representation of a specified array of Unicode characters into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.Char[]): The character array to insert.

Insert(Int32, Int32) -> StringBuilder
  Summary: Inserts the string representation of a specified 32-bit signed integer into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.Int32): The value to insert.

Insert(Int32, Int64) -> StringBuilder
  Summary: Inserts the string representation of a 64-bit signed integer into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.Int64): The value to insert.

Insert(Int32, Single) -> StringBuilder
  Summary: Inserts the string representation of a single-precision floating point number into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.Single): The value to insert.

Insert(Int32, Double) -> StringBuilder
  Summary: Inserts the string representation of a double-precision floating-point number into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.Double): The value to insert.

Insert(Int32, Decimal) -> StringBuilder
  Summary: Inserts the string representation of a decimal number into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.Decimal): The value to insert.

Insert(Int32, UInt16) -> StringBuilder
  Summary: Inserts the string representation of a 16-bit unsigned integer into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.UInt16): The value to insert.

Insert(Int32, UInt32) -> StringBuilder
  Summary: Inserts the string representation of a 32-bit unsigned integer into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.UInt32): The value to insert.

Insert(Int32, UInt64) -> StringBuilder
  Summary: Inserts the string representation of a 64-bit unsigned integer into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.UInt64): The value to insert.

Insert(Int32, Object) -> StringBuilder
  Summary: Inserts the string representation of an object into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.Object): The object to insert, or .

Insert(Int32, Char]) -> StringBuilder
  Summary: Inserts the sequence of characters into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.ReadOnlySpan`1[System.Char]): The character span to insert.

Insert(Int32, String, Int32) -> StringBuilder
  Summary: Inserts one or more copies of a specified string into this instance at the specified character position.
  Returns: A reference to this instance after insertion has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.String): The string to insert.
    - count (System.Int32): The number of times to insert value.

Insert(Int32, Char[], Int32, Int32) -> StringBuilder
  Summary: Inserts the string representation of a specified subarray of Unicode characters into this instance at the specified character position.
  Returns: A reference to this instance after the insert operation has completed.
  Parameters:
    - index (System.Int32): The position in this instance where insertion begins.
    - value (System.Char[]): A character array.
    - start-index (System.Int32): The starting index within value.
    - char-count (System.Int32): The number of characters to insert.
"
  (cl:cond
    ((cl:and (cl:numberp index) (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char[]")) supplied-count (cl:numberp count) supplied-char-count (cl:numberp char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value count char-count))
    ((cl:and (cl:numberp index) (cl:stringp value) supplied-count (cl:numberp count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value count))
    ((cl:and (cl:numberp index) (cl:or (cl:null value) (dotnet:is-instance-of value "System.ReadOnlySpan`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:numberp value) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:numberp value) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:numberp value) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:numberp value) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char[]")) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:numberp value) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:numberp value) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:typep value 'cl:boolean) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:numberp value) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    ((cl:and (cl:numberp index) (cl:stringp value) (cl:not supplied-count) (cl:not supplied-char-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Insert" index value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TEXT-STRING-BUILDER"
                    :class-name <type-str>
                    :method-name "Insert"
                    :supplied-args (cl:append (cl:list :index index) (cl:list :value value) (cl:when supplied-count (cl:list :count count)) (cl:when supplied-char-count (cl:list :char-count char-count)))))))

(cl:defun remove (obj! start-index length)
  "Summary: Removes the specified range of characters from this instance.
Returns: A reference to this instance after the excise operation has completed.
Parameters:
  - start-index (System.Int32): The zero-based position in this instance where removal begins.
  - length (System.Int32): The number of characters to remove.
"
  (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Remove" start-index length))

(cl:defun replace (obj! old-value new-value cl:&optional (start-index cl:nil supplied-start-index) (count cl:nil supplied-count))
  "Master wrapper for System.Text.StringBuilder.Replace overloads. Dispatches at runtime.

Replace(String, String) -> StringBuilder
  Summary: Replaces all occurrences of a specified string in this instance with another specified string.
  Returns: A reference to this instance with all instances of oldValue replaced by newValue.
  Parameters:
    - old-value (System.String): The string to replace.
    - new-value (System.String): The string that replaces oldValue, or .

Replace(Char], Char]) -> StringBuilder
  Summary: Replaces all instances of one read-only character span with another in this builder.
  Returns: A reference to this instance with oldValue replaced by newValue.
  Parameters:
    - old-value (System.ReadOnlySpan`1[System.Char]): The read-only character span to replace.
    - new-value (System.ReadOnlySpan`1[System.Char]): The read-only character span to replace oldValue with.

Replace(Char, Char) -> StringBuilder
  Summary: Replaces all occurrences of a specified character in this instance with another specified character.
  Returns: A reference to this instance with oldChar replaced by newChar.
  Parameters:
    - old-char (System.Char): The character to replace.
    - new-char (System.Char): The character that replaces oldChar.

Replace(String, String, Int32, Int32) -> StringBuilder
  Summary: Replaces, within a substring of this instance, all occurrences of a specified string with another specified string.
  Returns: A reference to this instance with all instances of oldValue replaced by newValue in the range from startIndex to startIndex + count - 1.
  Parameters:
    - old-value (System.String): The string to replace.
    - new-value (System.String): The string that replaces oldValue, or .
    - start-index (System.Int32): The position in this instance where the substring begins.
    - count (System.Int32): The length of the substring.

Replace(Char], Char], Int32, Int32) -> StringBuilder
  Summary: Replaces all instances of one read-only character span with another in part of this builder.
  Returns: A reference to this instance with oldValue replaced by newValue.
  Parameters:
    - old-value (System.ReadOnlySpan`1[System.Char]): The read-only character span to replace.
    - new-value (System.ReadOnlySpan`1[System.Char]): The read-only character span to replace oldValue with.
    - start-index (System.Int32): The index to start in this builder.
    - count (System.Int32): The number of characters to read in this builder.

Replace(Char, Char, Int32, Int32) -> StringBuilder
  Summary: Replaces, within a substring of this instance, all occurrences of a specified character with another specified character.
  Returns: A reference to this instance with oldChar replaced by newChar in the range from startIndex to startIndex + count -1.
  Parameters:
    - old-char (System.Char): The character to replace.
    - new-char (System.Char): The character that replaces oldChar.
    - start-index (System.Int32): The position in this instance where the substring begins.
    - count (System.Int32): The length of the substring.
"
  (cl:cond
    ((cl:and (cl:stringp old-value) (cl:stringp new-value) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Replace" old-value new-value start-index count))
    ((cl:and (cl:or (cl:null old-value) (dotnet:is-instance-of old-value "System.ReadOnlySpan`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null new-value) (dotnet:is-instance-of new-value "System.ReadOnlySpan`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Replace" old-value new-value start-index count))
    ((cl:and (cl:or (cl:null old-value) (dotnet:is-instance-of old-value "System.Char")) (cl:or (cl:null new-value) (dotnet:is-instance-of new-value "System.Char")) supplied-start-index (cl:numberp start-index) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Replace" old-value new-value start-index count))
    ((cl:and (cl:stringp old-value) (cl:stringp new-value) (cl:not supplied-start-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Replace" old-value new-value))
    ((cl:and (cl:or (cl:null old-value) (dotnet:is-instance-of old-value "System.ReadOnlySpan`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null new-value) (dotnet:is-instance-of new-value "System.ReadOnlySpan`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-start-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Replace" old-value new-value))
    ((cl:and (cl:or (cl:null old-value) (dotnet:is-instance-of old-value "System.Char")) (cl:or (cl:null new-value) (dotnet:is-instance-of new-value "System.Char")) (cl:not supplied-start-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "Replace" old-value new-value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TEXT-STRING-BUILDER"
                    :class-name <type-str>
                    :method-name "Replace"
                    :supplied-args (cl:append (cl:list :old-value old-value) (cl:list :new-value new-value) (cl:when supplied-start-index (cl:list :start-index start-index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun to-string (obj! cl:&optional (start-index cl:nil supplied-start-index) (length cl:nil supplied-length))
  "Master wrapper for System.Text.StringBuilder.ToString overloads. Dispatches at runtime.

ToString() -> String
  Summary: Converts the value of this instance to a System.String.
  Returns: A string whose value is the same as this instance.

ToString(Int32, Int32) -> String
  Summary: Converts the value of a substring of this instance to a System.String.
  Returns: A string whose value is the same as the specified substring of this instance.
  Parameters:
    - start-index (System.Int32): The starting position of the substring in this instance.
    - length (System.Int32): The length of the substring.
"
  (cl:cond
    ((cl:and supplied-start-index (cl:numberp start-index) supplied-length (cl:numberp length))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "ToString" start-index length))
    ((cl:and (cl:not supplied-start-index) (cl:not supplied-length))
     (dotnet:invoke (cl:the (dotnet "System.Text.StringBuilder") obj!) "ToString"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TEXT-STRING-BUILDER"
                    :class-name <type-str>
                    :method-name "ToString"
                    :supplied-args (cl:append (cl:when supplied-start-index (cl:list :start-index start-index)) (cl:when supplied-length (cl:list :length length)))))))

