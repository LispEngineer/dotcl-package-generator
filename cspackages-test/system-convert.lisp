;;; Generated automatically. Do not edit.
;;; Class: System.Convert
;;; Generator Version: 53
;;; Creation Date: 2026-07-19T16:02:09Z
;;; Options: (none)

(cl:in-package :system-convert)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Convert"))
(cl:defconstant <type-str> "System.Convert")
(cl:defconstant <creation> "2026-07-19T16:02:09Z")
(cl:defconstant <version> 53)

(cl:define-symbol-macro db-null (dotnet:static <type-str> "DBNull"))
(cl:setf (cl:documentation (cl:quote db-null) (cl:quote cl:variable)) "A constant that represents a database column that is absent of data; that is, database null.")

(cl:defun change-type (value type-code cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ChangeType overloads. Dispatches at runtime.

ChangeType(Object, TypeCode) -> Object
  Summary: Returns an object of the specified type whose value is equivalent to the specified object.
  Returns: An object whose underlying type is typeCode and whose value is equivalent to value. -or- A null reference ( in Visual Basic), if value is and typeCode is System.TypeCode.Empty, System.TypeCode.String, or System.TypeCode.Object.
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - type-code (System.TypeCode): The type of object to return.

ChangeType(Object, Type) -> Object
  Summary: Returns an object of the specified type and whose value is equivalent to the specified object.
  Returns: An object whose type is conversionType and whose value is equivalent to value. -or- A null reference ( in Visual Basic), if value is and conversionType is not a value type.
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - conversion-type (System.Type): The type of object to return.

ChangeType(Object, TypeCode, IFormatProvider) -> Object
  Summary: Returns an object of the specified type whose value is equivalent to the specified object. A parameter supplies culture-specific formatting information.
  Returns: An object whose underlying type is typeCode and whose value is equivalent to value. -or- A null reference ( in Visual Basic), if value is and typeCode is System.TypeCode.Empty, System.TypeCode.String, or System.TypeCode.Object.
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - type-code (System.TypeCode): The type of object to return.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ChangeType(Object, Type, IFormatProvider) -> Object
  Summary: Returns an object of the specified type whose value is equivalent to the specified object. A parameter supplies culture-specific formatting information.
  Returns: An object whose type is conversionType and whose value is equivalent to value. -or- value, if the System.Type of value and conversionType are equal. -or- A null reference ( in Visual Basic), if value is and conversionType is not a value type.
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - conversion-type (System.Type): The type of object to return.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:or (cl:null type-code) (dotnet:is-instance-of type-code "System.TypeCode")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ChangeType" value type-code provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:or (cl:null type-code) (dotnet:is-instance-of type-code "System.Type")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ChangeType" value type-code provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:or (cl:null type-code) (dotnet:is-instance-of type-code "System.TypeCode")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ChangeType" value type-code))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:or (cl:null type-code) (dotnet:is-instance-of type-code "System.Type")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ChangeType" value type-code))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ChangeType"
                    :supplied-args (cl:append (cl:list :value value) (cl:list :type-code type-code) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun from-base64-char-array (in-array offset length)
  "Summary: Converts a subset of a Unicode character array, which encodes binary data as base-64 digits, to an equivalent 8-bit unsigned integer array. Parameters specify the subset in the input array and the number of elements to convert.
Returns: An array of 8-bit unsigned integers equivalent to length elements at position offset in inArray.
Parameters:
  - in-array (System.Char[]): A Unicode character array.
  - offset (System.Int32): A position within inArray.
  - length (System.Int32): The number of elements in inArray to convert.
"
  (dotnet:static <type-str> "FromBase64CharArray" (cl:the (dotnet "System.Char[]") in-array) (cl:the (dotnet "System.Int32") offset) (cl:the (dotnet "System.Int32") length)))

(cl:defun from-base64-string (s)
  "Summary: Converts the specified string, which encodes binary data as base-64 digits, to an equivalent 8-bit unsigned integer array.
Returns: An array of 8-bit unsigned integers that is equivalent to s.
Parameters:
  - s (System.String): The string to convert.
"
  (dotnet:static <type-str> "FromBase64String" (cl:the (dotnet "System.String") s)))

(cl:defun from-hex-string (s)
  "Master wrapper for System.Convert.FromHexString overloads. Dispatches at runtime.

FromHexString(String) -> Byte[]
  Summary: Converts the specified string, which encodes binary data as hex characters, to an equivalent 8-bit unsigned integer array.
  Returns: An array of 8-bit unsigned integers that is equivalent to s.
  Parameters:
    - s (System.String): The string to convert.

FromHexString(Char]) -> Byte[]
  Summary: Converts the span, which encodes binary data as hex characters, to an equivalent 8-bit unsigned integer array.
  Returns: An array of 8-bit unsigned integers that is equivalent to chars.
  Parameters:
    - chars (System.ReadOnlySpan`1[System.Char]): The span to convert.

FromHexString(Byte]) -> Byte[]
  Summary: Converts the span, which encodes binary data as hex characters, to an equivalent 8-bit unsigned integer array.
  Returns: An array of 8-bit unsigned integers that is equivalent to utf8Source.
  Parameters:
    - utf8-source (System.ReadOnlySpan`1[System.Byte]): The UTF-8 span to convert.
"
  (cl:cond
    ((cl:and (cl:stringp s))
     (dotnet:static <type-str> "FromHexString" s))
    ((cl:and (cl:or (cl:null s) (dotnet:is-instance-of s "System.ReadOnlySpan`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "FromHexString" s))
    ((cl:and (cl:or (cl:null s) (dotnet:is-instance-of s "System.ReadOnlySpan`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "FromHexString" s))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "FromHexString"
                    :supplied-args (cl:append (cl:list :s s))))))

(cl:defun get-type-code (value)
  "Summary: Returns the System.TypeCode for the specified object.
Returns: The System.TypeCode for value, or System.TypeCode.Empty if value is .
Parameters:
  - value (System.Object): An object that implements the System.IConvertible interface.
"
  (dotnet:static <type-str> "GetTypeCode" (cl:the (dotnet "System.Object") value)))

(cl:defun db-null? (value)
  "Summary: Returns an indication whether the specified object is of type System.DBNull.
Returns: if value is of type System.DBNull; otherwise, .
Parameters:
  - value (System.Object): An object.
"
  (dotnet:static <type-str> "IsDBNull" (cl:the (dotnet "System.Object") value)))

(cl:defun to-base64-char-array (in-array offset-in length out-array offset-out cl:&optional (options cl:nil supplied-options))
  "Master wrapper for System.Convert.ToBase64CharArray overloads. Dispatches at runtime.

ToBase64CharArray(Byte[], Int32, Int32, Char[], Int32) -> Int32
  Summary: Converts a subset of an 8-bit unsigned integer array to an equivalent subset of a Unicode character array encoded with base-64 digits. Parameters specify the subsets as offsets in the input and output arrays, and the number of elements in the input array to convert.
  Returns: A 32-bit signed integer containing the number of bytes in outArray.
  Parameters:
    - in-array (System.Byte[]): An input array of 8-bit unsigned integers.
    - offset-in (System.Int32): A position within inArray.
    - length (System.Int32): The number of elements of inArray to convert.
    - out-array (System.Char[]): An output array of Unicode characters.
    - offset-out (System.Int32): A position within outArray.

ToBase64CharArray(Byte[], Int32, Int32, Char[], Int32, Base64FormattingOptions) -> Int32
  Summary: Converts a subset of an 8-bit unsigned integer array to an equivalent subset of a Unicode character array encoded with base-64 digits. Parameters specify the subsets as offsets in the input and output arrays, the number of elements in the input array to convert, and whether line breaks are inserted in the output array.
  Returns: A 32-bit signed integer containing the number of bytes in outArray.
  Parameters:
    - in-array (System.Byte[]): An input array of 8-bit unsigned integers.
    - offset-in (System.Int32): A position within inArray.
    - length (System.Int32): The number of elements of inArray to convert.
    - out-array (System.Char[]): An output array of Unicode characters.
    - offset-out (System.Int32): A position within outArray.
    - options (System.Base64FormattingOptions): System.Base64FormattingOptions.InsertLineBreaks to insert a line break every 76 characters, or System.Base64FormattingOptions.None to not insert line breaks.
"
  (cl:cond
    ((cl:and (cl:or (cl:null in-array) (dotnet:is-instance-of in-array "System.Byte[]")) (cl:numberp offset-in) (cl:numberp length) (cl:or (cl:null out-array) (dotnet:is-instance-of out-array "System.Char[]")) (cl:numberp offset-out) supplied-options (cl:or (cl:null options) (dotnet:is-instance-of options "System.Base64FormattingOptions")))
     (dotnet:static <type-str> "ToBase64CharArray" in-array offset-in length out-array offset-out options))
    ((cl:and (cl:or (cl:null in-array) (dotnet:is-instance-of in-array "System.Byte[]")) (cl:numberp offset-in) (cl:numberp length) (cl:or (cl:null out-array) (dotnet:is-instance-of out-array "System.Char[]")) (cl:numberp offset-out) (cl:not supplied-options))
     (dotnet:static <type-str> "ToBase64CharArray" in-array offset-in length out-array offset-out))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToBase64CharArray"
                    :supplied-args (cl:append (cl:list :in-array in-array) (cl:list :offset-in offset-in) (cl:list :length length) (cl:list :out-array out-array) (cl:list :offset-out offset-out) (cl:when supplied-options (cl:list :options options)))))))

(cl:defun to-base64-string (in-array cl:&optional (options cl:nil supplied-options) (length cl:nil supplied-length) (options2 cl:nil supplied-options2))
  "Master wrapper for System.Convert.ToBase64String overloads. Dispatches at runtime.

ToBase64String(Byte[]) -> String
  Summary: Converts an array of 8-bit unsigned integers to its equivalent string representation that is encoded with base-64 digits.
  Returns: The string representation, in base 64, of the contents of inArray.
  Parameters:
    - in-array (System.Byte[]): An array of 8-bit unsigned integers.

ToBase64String(Byte[], Base64FormattingOptions) -> String
  Summary: Converts an array of 8-bit unsigned integers to its equivalent string representation that is encoded with base-64 digits. You can specify whether to insert line breaks in the return value.
  Returns: The string representation in base 64 of the elements in inArray.
  Parameters:
    - in-array (System.Byte[]): An array of 8-bit unsigned integers.
    - options (System.Base64FormattingOptions): System.Base64FormattingOptions.InsertLineBreaks to insert a line break every 76 characters, or System.Base64FormattingOptions.None to not insert line breaks.

ToBase64String(Byte], Base64FormattingOptions = None) -> String
  Summary: Converts the 8-bit unsigned integers inside the specified read-only span into their equivalent string representation that is encoded with base-64 digits. You can optionally specify whether to insert line breaks in the return value.
  Returns: The string representation in base 64 of the elements in bytes. If the length of bytes is 0, an empty string is returned.
  Parameters:
    - bytes (System.ReadOnlySpan`1[System.Byte]): A read-only span of 8-bit unsigned integers.
    - options (System.Base64FormattingOptions): One of the enumeration values that specify whether to insert line breaks in the return value. The default value is System.Base64FormattingOptions.None.

ToBase64String(Byte[], Int32, Int32) -> String
  Summary: Converts a subset of an array of 8-bit unsigned integers to its equivalent string representation that is encoded with base-64 digits. Parameters specify the subset as an offset in the input array, and the number of elements in the array to convert.
  Returns: The string representation in base 64 of length elements of inArray, starting at position offset.
  Parameters:
    - in-array (System.Byte[]): An array of 8-bit unsigned integers.
    - offset (System.Int32): An offset in inArray.
    - length (System.Int32): The number of elements of inArray to convert.

ToBase64String(Byte[], Int32, Int32, Base64FormattingOptions) -> String
  Summary: Converts a subset of an array of 8-bit unsigned integers to its equivalent string representation that is encoded with base-64 digits. Parameters specify the subset as an offset in the input array, the number of elements in the array to convert, and whether to insert line breaks in the return value.
  Returns: The string representation in base 64 of length elements of inArray, starting at position offset.
  Parameters:
    - in-array (System.Byte[]): An array of 8-bit unsigned integers.
    - offset (System.Int32): An offset in inArray.
    - length (System.Int32): The number of elements of inArray to convert.
    - options (System.Base64FormattingOptions): System.Base64FormattingOptions.InsertLineBreaks to insert a line break every 76 characters, or System.Base64FormattingOptions.None to not insert line breaks.
"
  (cl:cond
    ((cl:and (cl:or (cl:null in-array) (dotnet:is-instance-of in-array "System.Byte[]")) supplied-options (cl:numberp options) supplied-length (cl:numberp length) supplied-options2 (cl:or (cl:null options2) (dotnet:is-instance-of options2 "System.Base64FormattingOptions")))
     (dotnet:static <type-str> "ToBase64String" in-array options length options2))
    ((cl:and (cl:or (cl:null in-array) (dotnet:is-instance-of in-array "System.Byte[]")) supplied-options (cl:numberp options) supplied-length (cl:numberp length) (cl:not supplied-options2))
     (dotnet:static <type-str> "ToBase64String" in-array options length))
    ((cl:and (cl:or (cl:null in-array) (dotnet:is-instance-of in-array "System.Byte[]")) supplied-options (cl:or (cl:null options) (dotnet:is-instance-of options "System.Base64FormattingOptions")) (cl:not supplied-length) (cl:not supplied-options2))
     (dotnet:static <type-str> "ToBase64String" in-array options))
    ((cl:and (cl:or (cl:null in-array) (dotnet:is-instance-of in-array "System.Byte[]")) (cl:not supplied-options) (cl:not supplied-length) (cl:not supplied-options2))
     (dotnet:static <type-str> "ToBase64String" in-array))
    ((cl:and (cl:or (cl:null in-array) (dotnet:is-instance-of in-array "System.ReadOnlySpan`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:not supplied-options) (cl:or (cl:null options) (dotnet:is-instance-of options "System.Base64FormattingOptions"))) (cl:not supplied-length) (cl:not supplied-options2))
     (dotnet:static <type-str> "ToBase64String" in-array (cl:if supplied-options options (dotnet:enum-or "System.Base64FormattingOptions" "None"))))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToBase64String"
                    :supplied-args (cl:append (cl:list :in-array in-array) (cl:when supplied-options (cl:list :options options)) (cl:when supplied-length (cl:list :length length)) (cl:when supplied-options2 (cl:list :options2 options2)))))))

(cl:defun to-boolean (value cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ToBoolean overloads. Dispatches at runtime.

ToBoolean(Object) -> Boolean
  Summary: Converts the value of a specified object to an equivalent Boolean value.
  Returns: or , which reflects the value returned by invoking the System.IConvertible.ToBoolean(System.IFormatProvider) method for the underlying type of value. If value is , the method returns .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface, or .

ToBoolean(Boolean) -> Boolean
  Summary: Returns the specified Boolean value; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.Boolean): The Boolean value to return.

ToBoolean(SByte) -> Boolean
  Summary: Converts the value of the specified 8-bit signed integer to an equivalent Boolean value.
  Returns: if value is not zero; otherwise, .
  Parameters:
    - value (System.SByte): The 8-bit signed integer to convert.

ToBoolean(Char) -> Boolean
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Char): The Unicode character to convert.

ToBoolean(Byte) -> Boolean
  Summary: Converts the value of the specified 8-bit unsigned integer to an equivalent Boolean value.
  Returns: if value is not zero; otherwise, .
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.

ToBoolean(Int16) -> Boolean
  Summary: Converts the value of the specified 16-bit signed integer to an equivalent Boolean value.
  Returns: if value is not zero; otherwise, .
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.

ToBoolean(UInt16) -> Boolean
  Summary: Converts the value of the specified 16-bit unsigned integer to an equivalent Boolean value.
  Returns: if value is not zero; otherwise, .
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to convert.

ToBoolean(Int32) -> Boolean
  Summary: Converts the value of the specified 32-bit signed integer to an equivalent Boolean value.
  Returns: if value is not zero; otherwise, .
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.

ToBoolean(UInt32) -> Boolean
  Summary: Converts the value of the specified 32-bit unsigned integer to an equivalent Boolean value.
  Returns: if value is not zero; otherwise, .
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to convert.

ToBoolean(Int64) -> Boolean
  Summary: Converts the value of the specified 64-bit signed integer to an equivalent Boolean value.
  Returns: if value is not zero; otherwise, .
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.

ToBoolean(UInt64) -> Boolean
  Summary: Converts the value of the specified 64-bit unsigned integer to an equivalent Boolean value.
  Returns: if value is not zero; otherwise, .
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to convert.

ToBoolean(String) -> Boolean
  Summary: Converts the specified string representation of a logical value to its Boolean equivalent.
  Returns: if value equals System.Boolean.TrueString, or if value equals System.Boolean.FalseString or .
  Parameters:
    - value (System.String): A string that contains the value of either System.Boolean.TrueString or System.Boolean.FalseString.

ToBoolean(Single) -> Boolean
  Summary: Converts the value of the specified single-precision floating-point number to an equivalent Boolean value.
  Returns: if value is not zero; otherwise, .
  Parameters:
    - value (System.Single): The single-precision floating-point number to convert.

ToBoolean(Double) -> Boolean
  Summary: Converts the value of the specified double-precision floating-point number to an equivalent Boolean value.
  Returns: if value is not zero; otherwise, .
  Parameters:
    - value (System.Double): The double-precision floating-point number to convert.

ToBoolean(Decimal) -> Boolean
  Summary: Converts the value of the specified decimal number to an equivalent Boolean value.
  Returns: if value is not zero; otherwise, .
  Parameters:
    - value (System.Decimal): The number to convert.

ToBoolean(DateTime) -> Boolean
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.DateTime): The date and time value to convert.

ToBoolean(Object, IFormatProvider) -> Boolean
  Summary: Converts the value of the specified object to an equivalent Boolean value, using the specified culture-specific formatting information.
  Returns: or , which reflects the value returned by invoking the System.IConvertible.ToBoolean(System.IFormatProvider) method for the underlying type of value. If value is , the method returns .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface, or .
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToBoolean(String, IFormatProvider) -> Boolean
  Summary: Converts the specified string representation of a logical value to its Boolean equivalent, using the specified culture-specific formatting information.
  Returns: if value equals System.Boolean.TrueString, or if value equals System.Boolean.FalseString or .
  Parameters:
    - value (System.String): A string that contains the value of either System.Boolean.TrueString or System.Boolean.FalseString.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information. This parameter is ignored.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToBoolean" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToBoolean" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    ((cl:and (cl:stringp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToBoolean" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToBoolean"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun to-byte (value cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ToByte overloads. Dispatches at runtime.

ToByte(Object) -> Byte
  Summary: Converts the value of the specified object to an 8-bit unsigned integer.
  Returns: An 8-bit unsigned integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface, or .

ToByte(Boolean) -> Byte
  Summary: Converts the specified Boolean value to the equivalent 8-bit unsigned integer.
  Returns: The number 1 if value is ; otherwise, 0.
  Parameters:
    - value (System.Boolean): The Boolean value to convert.

ToByte(Byte) -> Byte
  Summary: Returns the specified 8-bit unsigned integer; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to return.

ToByte(Char) -> Byte
  Summary: Converts the value of the specified Unicode character to the equivalent 8-bit unsigned integer.
  Returns: An 8-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Char): The Unicode character to convert.

ToByte(SByte) -> Byte
  Summary: Converts the value of the specified 8-bit signed integer to an equivalent 8-bit unsigned integer.
  Returns: An 8-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.SByte): The 8-bit signed integer to be converted.

ToByte(Int16) -> Byte
  Summary: Converts the value of the specified 16-bit signed integer to an equivalent 8-bit unsigned integer.
  Returns: An 8-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.

ToByte(UInt16) -> Byte
  Summary: Converts the value of the specified 16-bit unsigned integer to an equivalent 8-bit unsigned integer.
  Returns: An 8-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to convert.

ToByte(Int32) -> Byte
  Summary: Converts the value of the specified 32-bit signed integer to an equivalent 8-bit unsigned integer.
  Returns: An 8-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.

ToByte(UInt32) -> Byte
  Summary: Converts the value of the specified 32-bit unsigned integer to an equivalent 8-bit unsigned integer.
  Returns: An 8-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to convert.

ToByte(Int64) -> Byte
  Summary: Converts the value of the specified 64-bit signed integer to an equivalent 8-bit unsigned integer.
  Returns: An 8-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.

ToByte(UInt64) -> Byte
  Summary: Converts the value of the specified 64-bit unsigned integer to an equivalent 8-bit unsigned integer.
  Returns: An 8-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to convert.

ToByte(Single) -> Byte
  Summary: Converts the value of the specified single-precision floating-point number to an equivalent 8-bit unsigned integer.
  Returns: value, rounded to the nearest 8-bit unsigned integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Single): A single-precision floating-point number.

ToByte(Double) -> Byte
  Summary: Converts the value of the specified double-precision floating-point number to an equivalent 8-bit unsigned integer.
  Returns: value, rounded to the nearest 8-bit unsigned integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Double): The double-precision floating-point number to convert.

ToByte(Decimal) -> Byte
  Summary: Converts the value of the specified decimal number to an equivalent 8-bit unsigned integer.
  Returns: value, rounded to the nearest 8-bit unsigned integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Decimal): The number to convert.

ToByte(String) -> Byte
  Summary: Converts the specified string representation of a number to an equivalent 8-bit unsigned integer.
  Returns: An 8-bit unsigned integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.

ToByte(DateTime) -> Byte
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.DateTime): The date and time value to convert.

ToByte(Object, IFormatProvider) -> Byte
  Summary: Converts the value of the specified object to an 8-bit unsigned integer, using the specified culture-specific formatting information.
  Returns: An 8-bit unsigned integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToByte(String, IFormatProvider) -> Byte
  Summary: Converts the specified string representation of a number to an equivalent 8-bit unsigned integer, using specified culture-specific formatting information.
  Returns: An 8-bit unsigned integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToByte(String, Int32) -> Byte
  Summary: Converts the string representation of a number in a specified base to an equivalent 8-bit unsigned integer.
  Returns: An 8-bit unsigned integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - from-base (System.Int32): The base of the number in value, which must be 2, 8, 10, or 16.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-provider (cl:numberp provider))
     (dotnet:static <type-str> "ToByte" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToByte" value provider))
    ((cl:and (cl:stringp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToByte" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    ((cl:and (cl:stringp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToByte" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToByte"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun to-char (value cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ToChar overloads. Dispatches at runtime.

ToChar(Object) -> Char
  Summary: Converts the value of the specified object to a Unicode character.
  Returns: A Unicode character that is equivalent to value, or System.Char.MinValue if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.

ToChar(Boolean) -> Char
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Boolean): The Boolean value to convert.

ToChar(Char) -> Char
  Summary: Returns the specified Unicode character value; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.Char): The Unicode character to return.

ToChar(SByte) -> Char
  Summary: Converts the value of the specified 8-bit signed integer to its equivalent Unicode character.
  Returns: A Unicode character that is equivalent to value.
  Parameters:
    - value (System.SByte): The 8-bit signed integer to convert.

ToChar(Byte) -> Char
  Summary: Converts the value of the specified 8-bit unsigned integer to its equivalent Unicode character.
  Returns: A Unicode character that is equivalent to value.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.

ToChar(Int16) -> Char
  Summary: Converts the value of the specified 16-bit signed integer to its equivalent Unicode character.
  Returns: A Unicode character that is equivalent to value.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.

ToChar(UInt16) -> Char
  Summary: Converts the value of the specified 16-bit unsigned integer to its equivalent Unicode character.
  Returns: A Unicode character that is equivalent to value.
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to convert.

ToChar(Int32) -> Char
  Summary: Converts the value of the specified 32-bit signed integer to its equivalent Unicode character.
  Returns: A Unicode character that is equivalent to value.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.

ToChar(UInt32) -> Char
  Summary: Converts the value of the specified 32-bit unsigned integer to its equivalent Unicode character.
  Returns: A Unicode character that is equivalent to value.
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to convert.

ToChar(Int64) -> Char
  Summary: Converts the value of the specified 64-bit signed integer to its equivalent Unicode character.
  Returns: A Unicode character that is equivalent to value.
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.

ToChar(UInt64) -> Char
  Summary: Converts the value of the specified 64-bit unsigned integer to its equivalent Unicode character.
  Returns: A Unicode character that is equivalent to value.
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to convert.

ToChar(String) -> Char
  Summary: Converts the first character of a specified string to a Unicode character.
  Returns: A Unicode character that is equivalent to the first and only character in value.
  Parameters:
    - value (System.String): A string of length 1.

ToChar(Single) -> Char
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Single): The single-precision floating-point number to convert.

ToChar(Double) -> Char
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Double): The double-precision floating-point number to convert.

ToChar(Decimal) -> Char
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Decimal): The decimal number to convert.

ToChar(DateTime) -> Char
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.DateTime): The date and time value to convert.

ToChar(Object, IFormatProvider) -> Char
  Summary: Converts the value of the specified object to its equivalent Unicode character, using the specified culture-specific formatting information.
  Returns: A Unicode character that is equivalent to value, or System.Char.MinValue if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToChar(String, IFormatProvider) -> Char
  Summary: Converts the first character of a specified string to a Unicode character, using specified culture-specific formatting information.
  Returns: A Unicode character that is equivalent to the first and only character in value.
  Parameters:
    - value (System.String): A string of length 1 or .
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information. This parameter is ignored.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToChar" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToChar" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    ((cl:and (cl:stringp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToChar" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToChar"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun to-date-time (value cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ToDateTime overloads. Dispatches at runtime.

ToDateTime(DateTime) -> DateTime
  Summary: Returns the specified System.DateTime object; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.DateTime): A date and time value.

ToDateTime(Object) -> DateTime
  Summary: Converts the value of the specified object to a System.DateTime object.
  Returns: The date and time equivalent of the value of value, or a date and time equivalent of System.DateTime.MinValue if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface, or .

ToDateTime(String) -> DateTime
  Summary: Converts the specified string representation of a date and time to an equivalent date and time value.
  Returns: The date and time equivalent of the value of value, or the date and time equivalent of System.DateTime.MinValue if value is .
  Parameters:
    - value (System.String): The string representation of a date and time.

ToDateTime(SByte) -> DateTime
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.SByte): The 8-bit signed integer to convert.

ToDateTime(Byte) -> DateTime
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.

ToDateTime(Int16) -> DateTime
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.

ToDateTime(UInt16) -> DateTime
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to convert.

ToDateTime(Int32) -> DateTime
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.

ToDateTime(UInt32) -> DateTime
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to convert.

ToDateTime(Int64) -> DateTime
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.

ToDateTime(UInt64) -> DateTime
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to convert.

ToDateTime(Boolean) -> DateTime
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Boolean): The Boolean value to convert.

ToDateTime(Char) -> DateTime
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Char): The Unicode character to convert.

ToDateTime(Single) -> DateTime
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Single): The single-precision floating-point value to convert.

ToDateTime(Double) -> DateTime
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Double): The double-precision floating-point value to convert.

ToDateTime(Decimal) -> DateTime
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Decimal): The number to convert.

ToDateTime(Object, IFormatProvider) -> DateTime
  Summary: Converts the value of the specified object to a System.DateTime object, using the specified culture-specific formatting information.
  Returns: The date and time equivalent of the value of value, or the date and time equivalent of System.DateTime.MinValue if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToDateTime(String, IFormatProvider) -> DateTime
  Summary: Converts the specified string representation of a number to an equivalent date and time, using the specified culture-specific formatting information.
  Returns: The date and time equivalent of the value of value, or the date and time equivalent of System.DateTime.MinValue if value is .
  Parameters:
    - value (System.String): A string that contains a date and time to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToDateTime" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToDateTime" value provider))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    ((cl:and (cl:stringp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDateTime" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToDateTime"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun to-decimal (value cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ToDecimal overloads. Dispatches at runtime.

ToDecimal(Object) -> Decimal
  Summary: Converts the value of the specified object to an equivalent decimal number.
  Returns: A decimal number that is equivalent to value, or 0 (zero) if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface, or .

ToDecimal(SByte) -> Decimal
  Summary: Converts the value of the specified 8-bit signed integer to the equivalent decimal number.
  Returns: A decimal number that is equivalent to value.
  Parameters:
    - value (System.SByte): The 8-bit signed integer to convert.

ToDecimal(Byte) -> Decimal
  Summary: Converts the value of the specified 8-bit unsigned integer to the equivalent decimal number.
  Returns: The decimal number that is equivalent to value.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.

ToDecimal(Char) -> Decimal
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Char): The Unicode character to convert.

ToDecimal(Int16) -> Decimal
  Summary: Converts the value of the specified 16-bit signed integer to an equivalent decimal number.
  Returns: A decimal number that is equivalent to value.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.

ToDecimal(UInt16) -> Decimal
  Summary: Converts the value of the specified 16-bit unsigned integer to an equivalent decimal number.
  Returns: The decimal number that is equivalent to value.
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to convert.

ToDecimal(Int32) -> Decimal
  Summary: Converts the value of the specified 32-bit signed integer to an equivalent decimal number.
  Returns: A decimal number that is equivalent to value.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.

ToDecimal(UInt32) -> Decimal
  Summary: Converts the value of the specified 32-bit unsigned integer to an equivalent decimal number.
  Returns: A decimal number that is equivalent to value.
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to convert.

ToDecimal(Int64) -> Decimal
  Summary: Converts the value of the specified 64-bit signed integer to an equivalent decimal number.
  Returns: A decimal number that is equivalent to value.
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.

ToDecimal(UInt64) -> Decimal
  Summary: Converts the value of the specified 64-bit unsigned integer to an equivalent decimal number.
  Returns: A decimal number that is equivalent to value.
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to convert.

ToDecimal(Single) -> Decimal
  Summary: Converts the value of the specified single-precision floating-point number to the equivalent decimal number.
  Returns: A decimal number that is equivalent to value.
  Parameters:
    - value (System.Single): The single-precision floating-point number to convert.

ToDecimal(Double) -> Decimal
  Summary: Converts the value of the specified double-precision floating-point number to an equivalent decimal number.
  Returns: A decimal number that is equivalent to value.
  Parameters:
    - value (System.Double): The double-precision floating-point number to convert.

ToDecimal(String) -> Decimal
  Summary: Converts the specified string representation of a number to an equivalent decimal number.
  Returns: A decimal number that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains a number to convert.

ToDecimal(Decimal) -> Decimal
  Summary: Returns the specified decimal number; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.Decimal): A decimal number.

ToDecimal(Boolean) -> Decimal
  Summary: Converts the specified Boolean value to the equivalent decimal number.
  Returns: The number 1 if value is ; otherwise, 0.
  Parameters:
    - value (System.Boolean): The Boolean value to convert.

ToDecimal(DateTime) -> Decimal
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.DateTime): The date and time value to convert.

ToDecimal(Object, IFormatProvider) -> Decimal
  Summary: Converts the value of the specified object to an equivalent decimal number, using the specified culture-specific formatting information.
  Returns: A decimal number that is equivalent to value, or 0 (zero) if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToDecimal(String, IFormatProvider) -> Decimal
  Summary: Converts the specified string representation of a number to an equivalent decimal number, using the specified culture-specific formatting information.
  Returns: A decimal number that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains a number to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToDecimal" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToDecimal" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    ((cl:and (cl:stringp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDecimal" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToDecimal"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun to-double (value cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ToDouble overloads. Dispatches at runtime.

ToDouble(Object) -> Double
  Summary: Converts the value of the specified object to a double-precision floating-point number.
  Returns: A double-precision floating-point number that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface, or .

ToDouble(SByte) -> Double
  Summary: Converts the value of the specified 8-bit signed integer to the equivalent double-precision floating-point number.
  Returns: The 8-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.SByte): The 8-bit signed integer to convert.

ToDouble(Byte) -> Double
  Summary: Converts the value of the specified 8-bit unsigned integer to the equivalent double-precision floating-point number.
  Returns: The double-precision floating-point number that is equivalent to value.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.

ToDouble(Int16) -> Double
  Summary: Converts the value of the specified 16-bit signed integer to an equivalent double-precision floating-point number.
  Returns: A double-precision floating-point number equivalent to value.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.

ToDouble(Char) -> Double
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Char): The Unicode character to convert.

ToDouble(UInt16) -> Double
  Summary: Converts the value of the specified 16-bit unsigned integer to the equivalent double-precision floating-point number.
  Returns: A double-precision floating-point number that is equivalent to value.
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to convert.

ToDouble(Int32) -> Double
  Summary: Converts the value of the specified 32-bit signed integer to an equivalent double-precision floating-point number.
  Returns: A double-precision floating-point number that is equivalent to value.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.

ToDouble(UInt32) -> Double
  Summary: Converts the value of the specified 32-bit unsigned integer to an equivalent double-precision floating-point number.
  Returns: A double-precision floating-point number that is equivalent to value.
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to convert.

ToDouble(Int64) -> Double
  Summary: Converts the value of the specified 64-bit signed integer to an equivalent double-precision floating-point number.
  Returns: A double-precision floating-point number that is equivalent to value.
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.

ToDouble(UInt64) -> Double
  Summary: Converts the value of the specified 64-bit unsigned integer to an equivalent double-precision floating-point number.
  Returns: A double-precision floating-point number that is equivalent to value.
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to convert.

ToDouble(Single) -> Double
  Summary: Converts the value of the specified single-precision floating-point number to an equivalent double-precision floating-point number.
  Returns: A double-precision floating-point number that is equivalent to value.
  Parameters:
    - value (System.Single): The single-precision floating-point number.

ToDouble(Double) -> Double
  Summary: Returns the specified double-precision floating-point number; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.Double): The double-precision floating-point number to return.

ToDouble(Decimal) -> Double
  Summary: Converts the value of the specified decimal number to an equivalent double-precision floating-point number.
  Returns: A double-precision floating-point number that is equivalent to value.
  Parameters:
    - value (System.Decimal): The decimal number to convert.

ToDouble(String) -> Double
  Summary: Converts the specified string representation of a number to an equivalent double-precision floating-point number.
  Returns: A double-precision floating-point number that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.

ToDouble(Boolean) -> Double
  Summary: Converts the specified Boolean value to the equivalent double-precision floating-point number.
  Returns: The number 1 if value is ; otherwise, 0.
  Parameters:
    - value (System.Boolean): The Boolean value to convert.

ToDouble(DateTime) -> Double
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.DateTime): The date and time value to convert.

ToDouble(Object, IFormatProvider) -> Double
  Summary: Converts the value of the specified object to an double-precision floating-point number, using the specified culture-specific formatting information.
  Returns: A double-precision floating-point number that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToDouble(String, IFormatProvider) -> Double
  Summary: Converts the specified string representation of a number to an equivalent double-precision floating-point number, using the specified culture-specific formatting information.
  Returns: A double-precision floating-point number that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToDouble" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToDouble" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    ((cl:and (cl:stringp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToDouble" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToDouble"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun to-hex-string (in-array cl:&optional (offset cl:nil supplied-offset) (length cl:nil supplied-length))
  "Master wrapper for System.Convert.ToHexString overloads. Dispatches at runtime.

ToHexString(Byte[]) -> String
  Summary: Converts an array of 8-bit unsigned integers to its equivalent string representation that is encoded with uppercase hex characters.
  Returns: The string representation in hex of the elements in inArray.
  Parameters:
    - in-array (System.Byte[]): An array of 8-bit unsigned integers.

ToHexString(Byte]) -> String
  Summary: Converts a span of 8-bit unsigned integers to its equivalent string representation that is encoded with uppercase hex characters.
  Returns: The string representation in hex of the elements in bytes.
  Parameters:
    - bytes (System.ReadOnlySpan`1[System.Byte]): A span of 8-bit unsigned integers.

ToHexString(Byte[], Int32, Int32) -> String
  Summary: Converts a subset of an array of 8-bit unsigned integers to its equivalent string representation that is encoded with uppercase hex characters. Parameters specify the subset as an offset in the input array and the number of elements in the array to convert.
  Returns: The string representation in hex of length elements of inArray, starting at position offset.
  Parameters:
    - in-array (System.Byte[]): An array of 8-bit unsigned integers.
    - offset (System.Int32): An offset in inArray.
    - length (System.Int32): The number of elements of inArray to convert.
"
  (cl:cond
    ((cl:and (cl:or (cl:null in-array) (dotnet:is-instance-of in-array "System.Byte[]")) supplied-offset (cl:numberp offset) supplied-length (cl:numberp length))
     (dotnet:static <type-str> "ToHexString" in-array offset length))
    ((cl:and (cl:or (cl:null in-array) (dotnet:is-instance-of in-array "System.ReadOnlySpan`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-offset) (cl:not supplied-length))
     (dotnet:static <type-str> "ToHexString" in-array))
    ((cl:and (cl:or (cl:null in-array) (dotnet:is-instance-of in-array "System.Byte[]")) (cl:not supplied-offset) (cl:not supplied-length))
     (dotnet:static <type-str> "ToHexString" in-array))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToHexString"
                    :supplied-args (cl:append (cl:list :in-array in-array) (cl:when supplied-offset (cl:list :offset offset)) (cl:when supplied-length (cl:list :length length)))))))

(cl:defun to-hex-string-lower (in-array cl:&optional (offset cl:nil supplied-offset) (length cl:nil supplied-length))
  "Master wrapper for System.Convert.ToHexStringLower overloads. Dispatches at runtime.

ToHexStringLower(Byte[]) -> String
  Summary: Converts an array of 8-bit unsigned integers to its equivalent string representation that is encoded with lowercase hex characters.
  Returns: The string representation in hex of the elements in inArray.
  Parameters:
    - in-array (System.Byte[]): An array of 8-bit unsigned integers.

ToHexStringLower(Byte]) -> String
  Summary: Converts a span of 8-bit unsigned integers to its equivalent string representation that is encoded with lowercase hex characters.
  Returns: The string representation in hex of the elements in bytes.
  Parameters:
    - bytes (System.ReadOnlySpan`1[System.Byte]): A span of 8-bit unsigned integers.

ToHexStringLower(Byte[], Int32, Int32) -> String
  Summary: Converts a subset of an array of 8-bit unsigned integers to its equivalent string representation that is encoded with lowercase hex characters. Parameters specify the subset as an offset in the input array and the number of elements in the array to convert.
  Returns: The string representation in hex of length elements of inArray, starting at position offset.
  Parameters:
    - in-array (System.Byte[]): An array of 8-bit unsigned integers.
    - offset (System.Int32): An offset in inArray.
    - length (System.Int32): The number of elements of inArray to convert.
"
  (cl:cond
    ((cl:and (cl:or (cl:null in-array) (dotnet:is-instance-of in-array "System.Byte[]")) supplied-offset (cl:numberp offset) supplied-length (cl:numberp length))
     (dotnet:static <type-str> "ToHexStringLower" in-array offset length))
    ((cl:and (cl:or (cl:null in-array) (dotnet:is-instance-of in-array "System.ReadOnlySpan`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-offset) (cl:not supplied-length))
     (dotnet:static <type-str> "ToHexStringLower" in-array))
    ((cl:and (cl:or (cl:null in-array) (dotnet:is-instance-of in-array "System.Byte[]")) (cl:not supplied-offset) (cl:not supplied-length))
     (dotnet:static <type-str> "ToHexStringLower" in-array))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToHexStringLower"
                    :supplied-args (cl:append (cl:list :in-array in-array) (cl:when supplied-offset (cl:list :offset offset)) (cl:when supplied-length (cl:list :length length)))))))

(cl:defun to-int16 (value cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ToInt16 overloads. Dispatches at runtime.

ToInt16(Object) -> Int16
  Summary: Converts the value of the specified object to a 16-bit signed integer.
  Returns: A 16-bit signed integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface, or .

ToInt16(Boolean) -> Int16
  Summary: Converts the specified Boolean value to the equivalent 16-bit signed integer.
  Returns: The number 1 if value is ; otherwise, 0.
  Parameters:
    - value (System.Boolean): The Boolean value to convert.

ToInt16(Char) -> Int16
  Summary: Converts the value of the specified Unicode character to the equivalent 16-bit signed integer.
  Returns: A 16-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Char): The Unicode character to convert.

ToInt16(SByte) -> Int16
  Summary: Converts the value of the specified 8-bit signed integer to the equivalent 16-bit signed integer.
  Returns: A 8-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.SByte): The 8-bit signed integer to convert.

ToInt16(Byte) -> Int16
  Summary: Converts the value of the specified 8-bit unsigned integer to the equivalent 16-bit signed integer.
  Returns: A 16-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.

ToInt16(UInt16) -> Int16
  Summary: Converts the value of the specified 16-bit unsigned integer to the equivalent 16-bit signed integer.
  Returns: A 16-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to convert.

ToInt16(Int32) -> Int16
  Summary: Converts the value of the specified 32-bit signed integer to an equivalent 16-bit signed integer.
  Returns: The 16-bit signed integer equivalent of value.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.

ToInt16(UInt32) -> Int16
  Summary: Converts the value of the specified 32-bit unsigned integer to an equivalent 16-bit signed integer.
  Returns: A 16-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to convert.

ToInt16(Int16) -> Int16
  Summary: Returns the specified 16-bit signed integer; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to return.

ToInt16(Int64) -> Int16
  Summary: Converts the value of the specified 64-bit signed integer to an equivalent 16-bit signed integer.
  Returns: A 16-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.

ToInt16(UInt64) -> Int16
  Summary: Converts the value of the specified 64-bit unsigned integer to an equivalent 16-bit signed integer.
  Returns: A 16-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to convert.

ToInt16(Single) -> Int16
  Summary: Converts the value of the specified single-precision floating-point number to an equivalent 16-bit signed integer.
  Returns: value, rounded to the nearest 16-bit signed integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Single): The single-precision floating-point number to convert.

ToInt16(Double) -> Int16
  Summary: Converts the value of the specified double-precision floating-point number to an equivalent 16-bit signed integer.
  Returns: value, rounded to the nearest 16-bit signed integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Double): The double-precision floating-point number to convert.

ToInt16(Decimal) -> Int16
  Summary: Converts the value of the specified decimal number to an equivalent 16-bit signed integer.
  Returns: value, rounded to the nearest 16-bit signed integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Decimal): The decimal number to convert.

ToInt16(String) -> Int16
  Summary: Converts the specified string representation of a number to an equivalent 16-bit signed integer.
  Returns: A 16-bit signed integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.

ToInt16(DateTime) -> Int16
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.DateTime): The date and time value to convert.

ToInt16(Object, IFormatProvider) -> Int16
  Summary: Converts the value of the specified object to a 16-bit signed integer, using the specified culture-specific formatting information.
  Returns: A 16-bit signed integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToInt16(String, IFormatProvider) -> Int16
  Summary: Converts the specified string representation of a number to an equivalent 16-bit signed integer, using the specified culture-specific formatting information.
  Returns: A 16-bit signed integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToInt16(String, Int32) -> Int16
  Summary: Converts the string representation of a number in a specified base to an equivalent 16-bit signed integer.
  Returns: A 16-bit signed integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - from-base (System.Int32): The base of the number in value, which must be 2, 8, 10, or 16.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-provider (cl:numberp provider))
     (dotnet:static <type-str> "ToInt16" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToInt16" value provider))
    ((cl:and (cl:stringp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToInt16" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    ((cl:and (cl:stringp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt16" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToInt16"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun to-int32 (value cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ToInt32 overloads. Dispatches at runtime.

ToInt32(Object) -> Int32
  Summary: Converts the value of the specified object to a 32-bit signed integer.
  Returns: A 32-bit signed integer equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface, or .

ToInt32(Boolean) -> Int32
  Summary: Converts the specified Boolean value to the equivalent 32-bit signed integer.
  Returns: The number 1 if value is ; otherwise, 0.
  Parameters:
    - value (System.Boolean): The Boolean value to convert.

ToInt32(Char) -> Int32
  Summary: Converts the value of the specified Unicode character to the equivalent 32-bit signed integer.
  Returns: A 32-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Char): The Unicode character to convert.

ToInt32(SByte) -> Int32
  Summary: Converts the value of the specified 8-bit signed integer to the equivalent 32-bit signed integer.
  Returns: A 8-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.SByte): The 8-bit signed integer to convert.

ToInt32(Byte) -> Int32
  Summary: Converts the value of the specified 8-bit unsigned integer to the equivalent 32-bit signed integer.
  Returns: A 32-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.

ToInt32(Int16) -> Int32
  Summary: Converts the value of the specified 16-bit signed integer to an equivalent 32-bit signed integer.
  Returns: A 32-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.

ToInt32(UInt16) -> Int32
  Summary: Converts the value of the specified 16-bit unsigned integer to the equivalent 32-bit signed integer.
  Returns: A 32-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to convert.

ToInt32(UInt32) -> Int32
  Summary: Converts the value of the specified 32-bit unsigned integer to an equivalent 32-bit signed integer.
  Returns: A 32-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to convert.

ToInt32(Int32) -> Int32
  Summary: Returns the specified 32-bit signed integer; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to return.

ToInt32(Int64) -> Int32
  Summary: Converts the value of the specified 64-bit signed integer to an equivalent 32-bit signed integer.
  Returns: A 32-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.

ToInt32(UInt64) -> Int32
  Summary: Converts the value of the specified 64-bit unsigned integer to an equivalent 32-bit signed integer.
  Returns: A 32-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to convert.

ToInt32(Single) -> Int32
  Summary: Converts the value of the specified single-precision floating-point number to an equivalent 32-bit signed integer.
  Returns: value, rounded to the nearest 32-bit signed integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Single): The single-precision floating-point number to convert.

ToInt32(Double) -> Int32
  Summary: Converts the value of the specified double-precision floating-point number to an equivalent 32-bit signed integer.
  Returns: value, rounded to the nearest 32-bit signed integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Double): The double-precision floating-point number to convert.

ToInt32(Decimal) -> Int32
  Summary: Converts the value of the specified decimal number to an equivalent 32-bit signed integer.
  Returns: value, rounded to the nearest 32-bit signed integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Decimal): The decimal number to convert.

ToInt32(String) -> Int32
  Summary: Converts the specified string representation of a number to an equivalent 32-bit signed integer.
  Returns: A 32-bit signed integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.

ToInt32(DateTime) -> Int32
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.DateTime): The date and time value to convert.

ToInt32(Object, IFormatProvider) -> Int32
  Summary: Converts the value of the specified object to a 32-bit signed integer, using the specified culture-specific formatting information.
  Returns: A 32-bit signed integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToInt32(String, IFormatProvider) -> Int32
  Summary: Converts the specified string representation of a number to an equivalent 32-bit signed integer, using the specified culture-specific formatting information.
  Returns: A 32-bit signed integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToInt32(String, Int32) -> Int32
  Summary: Converts the string representation of a number in a specified base to an equivalent 32-bit signed integer.
  Returns: A 32-bit signed integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - from-base (System.Int32): The base of the number in value, which must be 2, 8, 10, or 16.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-provider (cl:numberp provider))
     (dotnet:static <type-str> "ToInt32" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToInt32" value provider))
    ((cl:and (cl:stringp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToInt32" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    ((cl:and (cl:stringp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt32" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToInt32"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun to-int64 (value cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ToInt64 overloads. Dispatches at runtime.

ToInt64(Object) -> Int64
  Summary: Converts the value of the specified object to a 64-bit signed integer.
  Returns: A 64-bit signed integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface, or .

ToInt64(Boolean) -> Int64
  Summary: Converts the specified Boolean value to the equivalent 64-bit signed integer.
  Returns: The number 1 if value is ; otherwise, 0.
  Parameters:
    - value (System.Boolean): The Boolean value to convert.

ToInt64(Char) -> Int64
  Summary: Converts the value of the specified Unicode character to the equivalent 64-bit signed integer.
  Returns: A 64-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Char): The Unicode character to convert.

ToInt64(SByte) -> Int64
  Summary: Converts the value of the specified 8-bit signed integer to the equivalent 64-bit signed integer.
  Returns: A 64-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.SByte): The 8-bit signed integer to convert.

ToInt64(Byte) -> Int64
  Summary: Converts the value of the specified 8-bit unsigned integer to the equivalent 64-bit signed integer.
  Returns: A 64-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.

ToInt64(Int16) -> Int64
  Summary: Converts the value of the specified 16-bit signed integer to an equivalent 64-bit signed integer.
  Returns: A 64-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.

ToInt64(UInt16) -> Int64
  Summary: Converts the value of the specified 16-bit unsigned integer to the equivalent 64-bit signed integer.
  Returns: A 64-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to convert.

ToInt64(Int32) -> Int64
  Summary: Converts the value of the specified 32-bit signed integer to an equivalent 64-bit signed integer.
  Returns: A 64-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.

ToInt64(UInt32) -> Int64
  Summary: Converts the value of the specified 32-bit unsigned integer to an equivalent 64-bit signed integer.
  Returns: A 64-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to convert.

ToInt64(UInt64) -> Int64
  Summary: Converts the value of the specified 64-bit unsigned integer to an equivalent 64-bit signed integer.
  Returns: A 64-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to convert.

ToInt64(Int64) -> Int64
  Summary: Returns the specified 64-bit signed integer; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.Int64): A 64-bit signed integer.

ToInt64(Single) -> Int64
  Summary: Converts the value of the specified single-precision floating-point number to an equivalent 64-bit signed integer.
  Returns: value, rounded to the nearest 64-bit signed integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Single): The single-precision floating-point number to convert.

ToInt64(Double) -> Int64
  Summary: Converts the value of the specified double-precision floating-point number to an equivalent 64-bit signed integer.
  Returns: value, rounded to the nearest 64-bit signed integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Double): The double-precision floating-point number to convert.

ToInt64(Decimal) -> Int64
  Summary: Converts the value of the specified decimal number to an equivalent 64-bit signed integer.
  Returns: value, rounded to the nearest 64-bit signed integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Decimal): The decimal number to convert.

ToInt64(String) -> Int64
  Summary: Converts the specified string representation of a number to an equivalent 64-bit signed integer.
  Returns: A 64-bit signed integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains a number to convert.

ToInt64(DateTime) -> Int64
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.DateTime): The date and time value to convert.

ToInt64(Object, IFormatProvider) -> Int64
  Summary: Converts the value of the specified object to a 64-bit signed integer, using the specified culture-specific formatting information.
  Returns: A 64-bit signed integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToInt64(String, IFormatProvider) -> Int64
  Summary: Converts the specified string representation of a number to an equivalent 64-bit signed integer, using the specified culture-specific formatting information.
  Returns: A 64-bit signed integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToInt64(String, Int32) -> Int64
  Summary: Converts the string representation of a number in a specified base to an equivalent 64-bit signed integer.
  Returns: A 64-bit signed integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - from-base (System.Int32): The base of the number in value, which must be 2, 8, 10, or 16.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-provider (cl:numberp provider))
     (dotnet:static <type-str> "ToInt64" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToInt64" value provider))
    ((cl:and (cl:stringp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToInt64" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    ((cl:and (cl:stringp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToInt64" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToInt64"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun to-s-byte (value cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ToSByte overloads. Dispatches at runtime.

ToSByte(Object) -> SByte
  Summary: Converts the value of the specified object to an 8-bit signed integer.
  Returns: An 8-bit signed integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface, or .

ToSByte(Boolean) -> SByte
  Summary: Converts the specified Boolean value to the equivalent 8-bit signed integer.
  Returns: The number 1 if value is ; otherwise, 0.
  Parameters:
    - value (System.Boolean): The Boolean value to convert.

ToSByte(SByte) -> SByte
  Summary: Returns the specified 8-bit signed integer; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.SByte): The 8-bit signed integer to return.

ToSByte(Char) -> SByte
  Summary: Converts the value of the specified Unicode character to the equivalent 8-bit signed integer.
  Returns: An 8-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Char): The Unicode character to convert.

ToSByte(Byte) -> SByte
  Summary: Converts the value of the specified 8-bit unsigned integer to the equivalent 8-bit signed integer.
  Returns: An 8-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.

ToSByte(Int16) -> SByte
  Summary: Converts the value of the specified 16-bit signed integer to the equivalent 8-bit signed integer.
  Returns: An 8-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.

ToSByte(UInt16) -> SByte
  Summary: Converts the value of the specified 16-bit unsigned integer to the equivalent 8-bit signed integer.
  Returns: An 8-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to convert.

ToSByte(Int32) -> SByte
  Summary: Converts the value of the specified 32-bit signed integer to an equivalent 8-bit signed integer.
  Returns: An 8-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.

ToSByte(UInt32) -> SByte
  Summary: Converts the value of the specified 32-bit unsigned integer to an equivalent 8-bit signed integer.
  Returns: An 8-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to convert.

ToSByte(Int64) -> SByte
  Summary: Converts the value of the specified 64-bit signed integer to an equivalent 8-bit signed integer.
  Returns: An 8-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.

ToSByte(UInt64) -> SByte
  Summary: Converts the value of the specified 64-bit unsigned integer to an equivalent 8-bit signed integer.
  Returns: An 8-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to convert.

ToSByte(Single) -> SByte
  Summary: Converts the value of the specified single-precision floating-point number to an equivalent 8-bit signed integer.
  Returns: value, rounded to the nearest 8-bit signed integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Single): The single-precision floating-point number to convert.

ToSByte(Double) -> SByte
  Summary: Converts the value of the specified double-precision floating-point number to an equivalent 8-bit signed integer.
  Returns: value, rounded to the nearest 8-bit signed integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Double): The double-precision floating-point number to convert.

ToSByte(Decimal) -> SByte
  Summary: Converts the value of the specified decimal number to an equivalent 8-bit signed integer.
  Returns: value, rounded to the nearest 8-bit signed integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Decimal): The decimal number to convert.

ToSByte(String) -> SByte
  Summary: Converts the specified string representation of a number to an equivalent 8-bit signed integer.
  Returns: An 8-bit signed integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.

ToSByte(DateTime) -> SByte
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.DateTime): The date and time value to convert.

ToSByte(Object, IFormatProvider) -> SByte
  Summary: Converts the value of the specified object to an 8-bit signed integer, using the specified culture-specific formatting information.
  Returns: An 8-bit signed integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToSByte(String, IFormatProvider) -> SByte
  Summary: Converts the specified string representation of a number to an equivalent 8-bit signed integer, using the specified culture-specific formatting information.
  Returns: An 8-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToSByte(String, Int32) -> SByte
  Summary: Converts the string representation of a number in a specified base to an equivalent 8-bit signed integer.
  Returns: An 8-bit signed integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - from-base (System.Int32): The base of the number in value, which must be 2, 8, 10, or 16.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-provider (cl:numberp provider))
     (dotnet:static <type-str> "ToSByte" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToSByte" value provider))
    ((cl:and (cl:stringp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToSByte" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    ((cl:and (cl:stringp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSByte" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToSByte"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun to-single (value cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ToSingle overloads. Dispatches at runtime.

ToSingle(Object) -> Single
  Summary: Converts the value of the specified object to a single-precision floating-point number.
  Returns: A single-precision floating-point number that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface, or .

ToSingle(SByte) -> Single
  Summary: Converts the value of the specified 8-bit signed integer to the equivalent single-precision floating-point number.
  Returns: An 8-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.SByte): The 8-bit signed integer to convert.

ToSingle(Byte) -> Single
  Summary: Converts the value of the specified 8-bit unsigned integer to the equivalent single-precision floating-point number.
  Returns: A single-precision floating-point number that is equivalent to value.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.

ToSingle(Char) -> Single
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.Char): The Unicode character to convert.

ToSingle(Int16) -> Single
  Summary: Converts the value of the specified 16-bit signed integer to an equivalent single-precision floating-point number.
  Returns: A single-precision floating-point number that is equivalent to value.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.

ToSingle(UInt16) -> Single
  Summary: Converts the value of the specified 16-bit unsigned integer to the equivalent single-precision floating-point number.
  Returns: A single-precision floating-point number that is equivalent to value.
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to convert.

ToSingle(Int32) -> Single
  Summary: Converts the value of the specified 32-bit signed integer to an equivalent single-precision floating-point number.
  Returns: A single-precision floating-point number that is equivalent to value.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.

ToSingle(UInt32) -> Single
  Summary: Converts the value of the specified 32-bit unsigned integer to an equivalent single-precision floating-point number.
  Returns: A single-precision floating-point number that is equivalent to value.
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to convert.

ToSingle(Int64) -> Single
  Summary: Converts the value of the specified 64-bit signed integer to an equivalent single-precision floating-point number.
  Returns: A single-precision floating-point number that is equivalent to value.
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.

ToSingle(UInt64) -> Single
  Summary: Converts the value of the specified 64-bit unsigned integer to an equivalent single-precision floating-point number.
  Returns: A single-precision floating-point number that is equivalent to value.
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to convert.

ToSingle(Single) -> Single
  Summary: Returns the specified single-precision floating-point number; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.Single): The single-precision floating-point number to return.

ToSingle(Double) -> Single
  Summary: Converts the value of the specified double-precision floating-point number to an equivalent single-precision floating-point number.
  Returns: A single-precision floating-point number that is equivalent to value. value is rounded using rounding to nearest. For example, when rounded to two decimals, the value 2.345 becomes 2.34 and the value 2.355 becomes 2.36.
  Parameters:
    - value (System.Double): The double-precision floating-point number to convert.

ToSingle(Decimal) -> Single
  Summary: Converts the value of the specified decimal number to an equivalent single-precision floating-point number.
  Returns: A single-precision floating-point number that is equivalent to value. value is rounded using rounding to nearest. For example, when rounded to two decimals, the value 2.345 becomes 2.34 and the value 2.355 becomes 2.36.
  Parameters:
    - value (System.Decimal): The decimal number to convert.

ToSingle(String) -> Single
  Summary: Converts the specified string representation of a number to an equivalent single-precision floating-point number.
  Returns: A single-precision floating-point number that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.

ToSingle(Boolean) -> Single
  Summary: Converts the specified Boolean value to the equivalent single-precision floating-point number.
  Returns: The number 1 if value is ; otherwise, 0.
  Parameters:
    - value (System.Boolean): The Boolean value to convert.

ToSingle(DateTime) -> Single
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.DateTime): The date and time value to convert.

ToSingle(Object, IFormatProvider) -> Single
  Summary: Converts the value of the specified object to an single-precision floating-point number, using the specified culture-specific formatting information.
  Returns: A single-precision floating-point number that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToSingle(String, IFormatProvider) -> Single
  Summary: Converts the specified string representation of a number to an equivalent single-precision floating-point number, using the specified culture-specific formatting information.
  Returns: A single-precision floating-point number that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToSingle" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToSingle" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    ((cl:and (cl:stringp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToSingle" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToSingle"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun to-string (value cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ToString overloads. Dispatches at runtime.

ToString(Object) -> String
  Summary: Converts the value of the specified object to its equivalent string representation.
  Returns: The string representation of value, or System.String.Empty if value is .
  Parameters:
    - value (System.Object): An object that supplies the value to convert, or .

ToString(Boolean) -> String
  Summary: Converts the specified Boolean value to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.Boolean): The Boolean value to convert.

ToString(Char) -> String
  Summary: Converts the value of the specified Unicode character to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.Char): The Unicode character to convert.

ToString(SByte) -> String
  Summary: Converts the value of the specified 8-bit signed integer to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.SByte): The 8-bit signed integer to convert.

ToString(Byte) -> String
  Summary: Converts the value of the specified 8-bit unsigned integer to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.

ToString(Int16) -> String
  Summary: Converts the value of the specified 16-bit signed integer to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.

ToString(UInt16) -> String
  Summary: Converts the value of the specified 16-bit unsigned integer to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to convert.

ToString(Int32) -> String
  Summary: Converts the value of the specified 32-bit signed integer to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.

ToString(UInt32) -> String
  Summary: Converts the value of the specified 32-bit unsigned integer to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to convert.

ToString(Int64) -> String
  Summary: Converts the value of the specified 64-bit signed integer to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.

ToString(UInt64) -> String
  Summary: Converts the value of the specified 64-bit unsigned integer to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to convert.

ToString(Single) -> String
  Summary: Converts the value of the specified single-precision floating-point number to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.Single): The single-precision floating-point number to convert.

ToString(Double) -> String
  Summary: Converts the value of the specified double-precision floating-point number to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.Double): The double-precision floating-point number to convert.

ToString(Decimal) -> String
  Summary: Converts the value of the specified decimal number to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.Decimal): The decimal number to convert.

ToString(DateTime) -> String
  Summary: Converts the value of the specified System.DateTime to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.DateTime): The date and time value to convert.

ToString(String) -> String
  Summary: Returns the specified string instance; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.String): The string to return.

ToString(Object, IFormatProvider) -> String
  Summary: Converts the value of the specified object to its equivalent string representation using the specified culture-specific formatting information.
  Returns: The string representation of value, or System.String.Empty if value is an object whose value is . If value is , the method returns .
  Parameters:
    - value (System.Object): An object that supplies the value to convert, or .
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToString(Boolean, IFormatProvider) -> String
  Summary: Converts the specified Boolean value to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.Boolean): The Boolean value to convert.
    - provider (System.IFormatProvider): An instance of an object. This parameter is ignored.

ToString(Char, IFormatProvider) -> String
  Summary: Converts the value of the specified Unicode character to its equivalent string representation, using the specified culture-specific formatting information.
  Returns: The string representation of value.
  Parameters:
    - value (System.Char): The Unicode character to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information. This parameter is ignored.

ToString(SByte, IFormatProvider) -> String
  Summary: Converts the value of the specified 8-bit signed integer to its equivalent string representation, using the specified culture-specific formatting information.
  Returns: The string representation of value.
  Parameters:
    - value (System.SByte): The 8-bit signed integer to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToString(Byte, IFormatProvider) -> String
  Summary: Converts the value of the specified 8-bit unsigned integer to its equivalent string representation, using the specified culture-specific formatting information.
  Returns: The string representation of value.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToString(Int16, IFormatProvider) -> String
  Summary: Converts the value of the specified 16-bit signed integer to its equivalent string representation, using the specified culture-specific formatting information.
  Returns: The string representation of value.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToString(UInt16, IFormatProvider) -> String
  Summary: Converts the value of the specified 16-bit unsigned integer to its equivalent string representation, using the specified culture-specific formatting information.
  Returns: The string representation of value.
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToString(Int32, IFormatProvider) -> String
  Summary: Converts the value of the specified 32-bit signed integer to its equivalent string representation, using the specified culture-specific formatting information.
  Returns: The string representation of value.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToString(UInt32, IFormatProvider) -> String
  Summary: Converts the value of the specified 32-bit unsigned integer to its equivalent string representation, using the specified culture-specific formatting information.
  Returns: The string representation of value.
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToString(Int64, IFormatProvider) -> String
  Summary: Converts the value of the specified 64-bit signed integer to its equivalent string representation, using the specified culture-specific formatting information.
  Returns: The string representation of value.
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToString(UInt64, IFormatProvider) -> String
  Summary: Converts the value of the specified 64-bit unsigned integer to its equivalent string representation, using the specified culture-specific formatting information.
  Returns: The string representation of value.
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToString(Single, IFormatProvider) -> String
  Summary: Converts the value of the specified single-precision floating-point number to its equivalent string representation, using the specified culture-specific formatting information.
  Returns: The string representation of value.
  Parameters:
    - value (System.Single): The single-precision floating-point number to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToString(Double, IFormatProvider) -> String
  Summary: Converts the value of the specified double-precision floating-point number to its equivalent string representation.
  Returns: The string representation of value.
  Parameters:
    - value (System.Double): The double-precision floating-point number to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToString(Decimal, IFormatProvider) -> String
  Summary: Converts the value of the specified decimal number to its equivalent string representation, using the specified culture-specific formatting information.
  Returns: The string representation of value.
  Parameters:
    - value (System.Decimal): The decimal number to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToString(DateTime, IFormatProvider) -> String
  Summary: Converts the value of the specified System.DateTime to its equivalent string representation, using the specified culture-specific formatting information.
  Returns: The string representation of value.
  Parameters:
    - value (System.DateTime): The date and time value to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToString(String, IFormatProvider) -> String
  Summary: Returns the specified string instance; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.String): The string to return.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information. This parameter is ignored.

ToString(Byte, Int32) -> String
  Summary: Converts the value of an 8-bit unsigned integer to its equivalent string representation in a specified base.
  Returns: The string representation of value in base toBase.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.
    - to-base (System.Int32): The base of the return value, which must be 2, 8, 10, or 16.

ToString(Int16, Int32) -> String
  Summary: Converts the value of a 16-bit signed integer to its equivalent string representation in a specified base.
  Returns: The string representation of value in base toBase.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.
    - to-base (System.Int32): The base of the return value, which must be 2, 8, 10, or 16.

ToString(Int32, Int32) -> String
  Summary: Converts the value of a 32-bit signed integer to its equivalent string representation in a specified base.
  Returns: The string representation of value in base toBase.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.
    - to-base (System.Int32): The base of the return value, which must be 2, 8, 10, or 16.

ToString(Int64, Int32) -> String
  Summary: Converts the value of a 64-bit signed integer to its equivalent string representation in a specified base.
  Returns: The string representation of value in base toBase.
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.
    - to-base (System.Int32): The base of the return value, which must be 2, 8, 10, or 16.
"
  (cl:cond
    ((cl:and (cl:typep value 'cl:boolean) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:numberp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:numberp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:numberp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:numberp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:numberp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:numberp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:stringp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:numberp value) supplied-provider (cl:numberp provider))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:numberp value) supplied-provider (cl:numberp provider))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:numberp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:numberp value) supplied-provider (cl:numberp provider))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:numberp value) supplied-provider (cl:numberp provider))
     (dotnet:static <type-str> "ToString" value provider))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    ((cl:and (cl:stringp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToString" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToString"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun to-u-int16 (value cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ToUInt16 overloads. Dispatches at runtime.

ToUInt16(Object) -> UInt16
  Summary: Converts the value of the specified object to a 16-bit unsigned integer.
  Returns: A 16-bit unsigned integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface, or .

ToUInt16(Boolean) -> UInt16
  Summary: Converts the specified Boolean value to the equivalent 16-bit unsigned integer.
  Returns: The number 1 if value is ; otherwise, 0.
  Parameters:
    - value (System.Boolean): The Boolean value to convert.

ToUInt16(Char) -> UInt16
  Summary: Converts the value of the specified Unicode character to the equivalent 16-bit unsigned integer.
  Returns: The 16-bit unsigned integer equivalent to value.
  Parameters:
    - value (System.Char): The Unicode character to convert.

ToUInt16(SByte) -> UInt16
  Summary: Converts the value of the specified 8-bit signed integer to the equivalent 16-bit unsigned integer.
  Returns: A 16-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.SByte): The 8-bit signed integer to convert.

ToUInt16(Byte) -> UInt16
  Summary: Converts the value of the specified 8-bit unsigned integer to the equivalent 16-bit unsigned integer.
  Returns: A 16-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.

ToUInt16(Int16) -> UInt16
  Summary: Converts the value of the specified 16-bit signed integer to the equivalent 16-bit unsigned integer.
  Returns: A 16-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.

ToUInt16(Int32) -> UInt16
  Summary: Converts the value of the specified 32-bit signed integer to an equivalent 16-bit unsigned integer.
  Returns: A 16-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.

ToUInt16(UInt16) -> UInt16
  Summary: Returns the specified 16-bit unsigned integer; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to return.

ToUInt16(UInt32) -> UInt16
  Summary: Converts the value of the specified 32-bit unsigned integer to an equivalent 16-bit unsigned integer.
  Returns: A 16-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to convert.

ToUInt16(Int64) -> UInt16
  Summary: Converts the value of the specified 64-bit signed integer to an equivalent 16-bit unsigned integer.
  Returns: A 16-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.

ToUInt16(UInt64) -> UInt16
  Summary: Converts the value of the specified 64-bit unsigned integer to an equivalent 16-bit unsigned integer.
  Returns: A 16-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to convert.

ToUInt16(Single) -> UInt16
  Summary: Converts the value of the specified single-precision floating-point number to an equivalent 16-bit unsigned integer.
  Returns: value, rounded to the nearest 16-bit unsigned integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Single): The single-precision floating-point number to convert.

ToUInt16(Double) -> UInt16
  Summary: Converts the value of the specified double-precision floating-point number to an equivalent 16-bit unsigned integer.
  Returns: value, rounded to the nearest 16-bit unsigned integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Double): The double-precision floating-point number to convert.

ToUInt16(Decimal) -> UInt16
  Summary: Converts the value of the specified decimal number to an equivalent 16-bit unsigned integer.
  Returns: value, rounded to the nearest 16-bit unsigned integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Decimal): The decimal number to convert.

ToUInt16(String) -> UInt16
  Summary: Converts the specified string representation of a number to an equivalent 16-bit unsigned integer.
  Returns: A 16-bit unsigned integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.

ToUInt16(DateTime) -> UInt16
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.DateTime): The date and time value to convert.

ToUInt16(Object, IFormatProvider) -> UInt16
  Summary: Converts the value of the specified object to a 16-bit unsigned integer, using the specified culture-specific formatting information.
  Returns: A 16-bit unsigned integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToUInt16(String, IFormatProvider) -> UInt16
  Summary: Converts the specified string representation of a number to an equivalent 16-bit unsigned integer, using the specified culture-specific formatting information.
  Returns: A 16-bit unsigned integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToUInt16(String, Int32) -> UInt16
  Summary: Converts the string representation of a number in a specified base to an equivalent 16-bit unsigned integer.
  Returns: A 16-bit unsigned integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - from-base (System.Int32): The base of the number in value, which must be 2, 8, 10, or 16.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-provider (cl:numberp provider))
     (dotnet:static <type-str> "ToUInt16" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToUInt16" value provider))
    ((cl:and (cl:stringp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToUInt16" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    ((cl:and (cl:stringp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt16" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToUInt16"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun to-u-int32 (value cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ToUInt32 overloads. Dispatches at runtime.

ToUInt32(Object) -> UInt32
  Summary: Converts the value of the specified object to a 32-bit unsigned integer.
  Returns: A 32-bit unsigned integer that is equivalent to value, or 0 (zero) if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface, or .

ToUInt32(Boolean) -> UInt32
  Summary: Converts the specified Boolean value to the equivalent 32-bit unsigned integer.
  Returns: The number 1 if value is ; otherwise, 0.
  Parameters:
    - value (System.Boolean): The Boolean value to convert.

ToUInt32(Char) -> UInt32
  Summary: Converts the value of the specified Unicode character to the equivalent 32-bit unsigned integer.
  Returns: A 32-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Char): The Unicode character to convert.

ToUInt32(SByte) -> UInt32
  Summary: Converts the value of the specified 8-bit signed integer to the equivalent 32-bit unsigned integer.
  Returns: A 32-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.SByte): The 8-bit signed integer to convert.

ToUInt32(Byte) -> UInt32
  Summary: Converts the value of the specified 8-bit unsigned integer to the equivalent 32-bit unsigned integer.
  Returns: A 32-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.

ToUInt32(Int16) -> UInt32
  Summary: Converts the value of the specified 16-bit signed integer to the equivalent 32-bit unsigned integer.
  Returns: A 32-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.

ToUInt32(UInt16) -> UInt32
  Summary: Converts the value of the specified 16-bit unsigned integer to the equivalent 32-bit unsigned integer.
  Returns: A 32-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to convert.

ToUInt32(Int32) -> UInt32
  Summary: Converts the value of the specified 32-bit signed integer to an equivalent 32-bit unsigned integer.
  Returns: A 32-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.

ToUInt32(UInt32) -> UInt32
  Summary: Returns the specified 32-bit unsigned integer; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to return.

ToUInt32(Int64) -> UInt32
  Summary: Converts the value of the specified 64-bit signed integer to an equivalent 32-bit unsigned integer.
  Returns: A 32-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.

ToUInt32(UInt64) -> UInt32
  Summary: Converts the value of the specified 64-bit unsigned integer to an equivalent 32-bit unsigned integer.
  Returns: A 32-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to convert.

ToUInt32(Single) -> UInt32
  Summary: Converts the value of the specified single-precision floating-point number to an equivalent 32-bit unsigned integer.
  Returns: value, rounded to the nearest 32-bit unsigned integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Single): The single-precision floating-point number to convert.

ToUInt32(Double) -> UInt32
  Summary: Converts the value of the specified double-precision floating-point number to an equivalent 32-bit unsigned integer.
  Returns: value, rounded to the nearest 32-bit unsigned integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Double): The double-precision floating-point number to convert.

ToUInt32(Decimal) -> UInt32
  Summary: Converts the value of the specified decimal number to an equivalent 32-bit unsigned integer.
  Returns: value, rounded to the nearest 32-bit unsigned integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Decimal): The decimal number to convert.

ToUInt32(String) -> UInt32
  Summary: Converts the specified string representation of a number to an equivalent 32-bit unsigned integer.
  Returns: A 32-bit unsigned integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.

ToUInt32(DateTime) -> UInt32
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.DateTime): The date and time value to convert.

ToUInt32(Object, IFormatProvider) -> UInt32
  Summary: Converts the value of the specified object to a 32-bit unsigned integer, using the specified culture-specific formatting information.
  Returns: A 32-bit unsigned integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToUInt32(String, IFormatProvider) -> UInt32
  Summary: Converts the specified string representation of a number to an equivalent 32-bit unsigned integer, using the specified culture-specific formatting information.
  Returns: A 32-bit unsigned integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToUInt32(String, Int32) -> UInt32
  Summary: Converts the string representation of a number in a specified base to an equivalent 32-bit unsigned integer.
  Returns: A 32-bit unsigned integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - from-base (System.Int32): The base of the number in value, which must be 2, 8, 10, or 16.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-provider (cl:numberp provider))
     (dotnet:static <type-str> "ToUInt32" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToUInt32" value provider))
    ((cl:and (cl:stringp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToUInt32" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    ((cl:and (cl:stringp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt32" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToUInt32"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun to-u-int64 (value cl:&optional (provider cl:nil supplied-provider))
  "Master wrapper for System.Convert.ToUInt64 overloads. Dispatches at runtime.

ToUInt64(Object) -> UInt64
  Summary: Converts the value of the specified object to a 64-bit unsigned integer.
  Returns: A 64-bit unsigned integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface, or .

ToUInt64(Boolean) -> UInt64
  Summary: Converts the specified Boolean value to the equivalent 64-bit unsigned integer.
  Returns: The number 1 if value is ; otherwise, 0.
  Parameters:
    - value (System.Boolean): The Boolean value to convert.

ToUInt64(Char) -> UInt64
  Summary: Converts the value of the specified Unicode character to the equivalent 64-bit unsigned integer.
  Returns: A 64-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Char): The Unicode character to convert.

ToUInt64(SByte) -> UInt64
  Summary: Converts the value of the specified 8-bit signed integer to the equivalent 64-bit unsigned integer.
  Returns: A 64-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.SByte): The 8-bit signed integer to convert.

ToUInt64(Byte) -> UInt64
  Summary: Converts the value of the specified 8-bit unsigned integer to the equivalent 64-bit unsigned integer.
  Returns: A 64-bit signed integer that is equivalent to value.
  Parameters:
    - value (System.Byte): The 8-bit unsigned integer to convert.

ToUInt64(Int16) -> UInt64
  Summary: Converts the value of the specified 16-bit signed integer to the equivalent 64-bit unsigned integer.
  Returns: A 64-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Int16): The 16-bit signed integer to convert.

ToUInt64(UInt16) -> UInt64
  Summary: Converts the value of the specified 16-bit unsigned integer to the equivalent 64-bit unsigned integer.
  Returns: A 64-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.UInt16): The 16-bit unsigned integer to convert.

ToUInt64(Int32) -> UInt64
  Summary: Converts the value of the specified 32-bit signed integer to an equivalent 64-bit unsigned integer.
  Returns: A 64-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Int32): The 32-bit signed integer to convert.

ToUInt64(UInt32) -> UInt64
  Summary: Converts the value of the specified 32-bit unsigned integer to an equivalent 64-bit unsigned integer.
  Returns: A 64-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.UInt32): The 32-bit unsigned integer to convert.

ToUInt64(Int64) -> UInt64
  Summary: Converts the value of the specified 64-bit signed integer to an equivalent 64-bit unsigned integer.
  Returns: A 64-bit unsigned integer that is equivalent to value.
  Parameters:
    - value (System.Int64): The 64-bit signed integer to convert.

ToUInt64(UInt64) -> UInt64
  Summary: Returns the specified 64-bit unsigned integer; no actual conversion is performed.
  Returns: value is returned unchanged.
  Parameters:
    - value (System.UInt64): The 64-bit unsigned integer to return.

ToUInt64(Single) -> UInt64
  Summary: Converts the value of the specified single-precision floating-point number to an equivalent 64-bit unsigned integer.
  Returns: value, rounded to the nearest 64-bit unsigned integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Single): The single-precision floating-point number to convert.

ToUInt64(Double) -> UInt64
  Summary: Converts the value of the specified double-precision floating-point number to an equivalent 64-bit unsigned integer.
  Returns: value, rounded to the nearest 64-bit unsigned integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Double): The double-precision floating-point number to convert.

ToUInt64(Decimal) -> UInt64
  Summary: Converts the value of the specified decimal number to an equivalent 64-bit unsigned integer.
  Returns: value, rounded to the nearest 64-bit unsigned integer. If value is halfway between two whole numbers, the even number is returned; that is, 4.5 is converted to 4, and 5.5 is converted to 6.
  Parameters:
    - value (System.Decimal): The decimal number to convert.

ToUInt64(String) -> UInt64
  Summary: Converts the specified string representation of a number to an equivalent 64-bit unsigned integer.
  Returns: A 64-bit signed integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.

ToUInt64(DateTime) -> UInt64
  Summary: Calling this method always throws System.InvalidCastException.
  Returns: This conversion is not supported. No value is returned.
  Parameters:
    - value (System.DateTime): The date and time value to convert.

ToUInt64(Object, IFormatProvider) -> UInt64
  Summary: Converts the value of the specified object to a 64-bit unsigned integer, using the specified culture-specific formatting information.
  Returns: A 64-bit unsigned integer that is equivalent to value, or zero if value is .
  Parameters:
    - value (System.Object): An object that implements the System.IConvertible interface.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToUInt64(String, IFormatProvider) -> UInt64
  Summary: Converts the specified string representation of a number to an equivalent 64-bit unsigned integer, using the specified culture-specific formatting information.
  Returns: A 64-bit unsigned integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

ToUInt64(String, Int32) -> UInt64
  Summary: Converts the string representation of a number in a specified base to an equivalent 64-bit unsigned integer.
  Returns: A 64-bit unsigned integer that is equivalent to the number in value, or 0 (zero) if value is .
  Parameters:
    - value (System.String): A string that contains the number to convert.
    - from-base (System.Int32): The base of the number in value, which must be 2, 8, 10, or 16.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-provider (cl:numberp provider))
     (dotnet:static <type-str> "ToUInt64" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToUInt64" value provider))
    ((cl:and (cl:stringp value) supplied-provider (cl:or (cl:null provider) (dotnet:is-instance-of provider "System.IFormatProvider")))
     (dotnet:static <type-str> "ToUInt64" value provider))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.DateTime")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    ((cl:and (cl:stringp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt64")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt16")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    ((cl:and (cl:numberp value) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.SByte")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Char")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.UInt32")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    ((cl:and (cl:or (cl:null value) (dotnet:is-instance-of value "System.Object")) (cl:not supplied-provider))
     (dotnet:static <type-str> "ToUInt64" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "ToUInt64"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-provider (cl:list :provider provider)))))))

(cl:defun from-hex-string/out (source destination)
  "Master wrapper for System.Convert.FromHexString out-only overloads. Dispatches at runtime. Each out parameter is returned as an additional cl:values result (after the primary return value), in C# declaration order.

FromHexString(String, Byte], out Int32&, out Int32&) -> OperationStatus
  Summary: Converts the string, which encodes binary data as hex characters, to an equivalent 8-bit unsigned integer span.
  Returns: An System.Buffers.OperationStatus describing the result of the operation.
  Parameters:
    - source (System.String): The string to convert.
    - destination (System.Span`1[System.Byte]): The span in which to write the converted 8-bit unsigned integers. When this method returns value different than System.Buffers.OperationStatus.Done, either the span remains unmodified or contains an incomplete conversion of source, up to the last valid character.
    - chars-consumed (System.Int32&): When this method returns, contains the number of characters that were consumed from source.
    - bytes-written (System.Int32&): When this method returns, contains the number of bytes that were written to destination.

FromHexString(Char], Byte], out Int32&, out Int32&) -> OperationStatus
  Summary: Converts the span of chars, which encodes binary data as hex characters, to an equivalent 8-bit unsigned integer span.
  Returns: An System.Buffers.OperationStatus describing the result of the operation.
  Parameters:
    - source (System.ReadOnlySpan`1[System.Char]): The span to convert.
    - destination (System.Span`1[System.Byte]): The span in which to write the converted 8-bit unsigned integers. When this method returns value different than System.Buffers.OperationStatus.Done, either the span remains unmodified or contains an incomplete conversion of source, up to the last valid character.
    - chars-consumed (System.Int32&): When this method returns, contains the number of characters that were consumed from source.
    - bytes-written (System.Int32&): When this method returns, contains the number of bytes that were written to destination.

FromHexString(Byte], Byte], out Int32&, out Int32&) -> OperationStatus
  Summary: Converts the span of UTF-8 chars, which encodes binary data as hex characters, to an equivalent 8-bit unsigned integer span.
  Returns: An System.Buffers.OperationStatus describing the result of the operation.
  Parameters:
    - utf8-source (System.ReadOnlySpan`1[System.Byte]): The span to convert.
    - destination (System.Span`1[System.Byte]): The span in which to write the converted 8-bit unsigned integers.
    - bytes-consumed (System.Int32&): When this method returns, contains the number of bytes that were consumed from utf8Source.
    - bytes-written (System.Int32&): When this method returns, contains the number of bytes that were written to destination.
"
  (cl:cond
    ((cl:and (cl:stringp source) (cl:or (cl:null destination) (dotnet:is-instance-of destination "System.Span`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:call-out <type-str> "FromHexString" source destination))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.ReadOnlySpan`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null destination) (dotnet:is-instance-of destination "System.Span`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:call-out <type-str> "FromHexString" source destination))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.ReadOnlySpan`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null destination) (dotnet:is-instance-of destination "System.Span`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:call-out <type-str> "FromHexString" source destination))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "FromHexString"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :destination destination))))))

(cl:defun try-from-base64-chars (chars bytes)
  "Returns (cl:values <primary-return> bytes-written) -- TryFromBase64Chars(Char], Byte], out Int32&) -> Boolean
Summary: Tries to convert the specified span containing a string representation that is encoded with base-64 digits into a span of 8-bit unsigned integers.
Returns: if the conversion was successful; otherwise, .
Parameters:
  - chars (System.ReadOnlySpan`1[System.Char]): A span containing the string representation that is encoded with base-64 digits.
  - bytes (System.Span`1[System.Byte]): The span in which to write the converted 8-bit unsigned integers. If this method returns , either the span remains unmodified or contains an incomplete conversion of chars, up to the last valid character.
"
  (dotnet:call-out <type-str> "TryFromBase64Chars" chars bytes))

(cl:defun try-from-base64-string (s bytes)
  "Returns (cl:values <primary-return> bytes-written) -- TryFromBase64String(String, Byte], out Int32&) -> Boolean
Summary: Tries to convert the specified string representation that is encoded with base-64 digits into a span of 8-bit unsigned integers.
Returns: if the conversion was successful; otherwise, .
Parameters:
  - s (System.String): The string representation that is encoded with base-64 digits.
  - bytes (System.Span`1[System.Byte]): The span in which to write the converted 8-bit unsigned integers. When this method returns , either the span remains unmodified or contains an incomplete conversion of s, up to the last valid character.
"
  (dotnet:call-out <type-str> "TryFromBase64String" s bytes))

(cl:defun try-to-base64-chars (bytes chars cl:&key (options (dotnet:enum-or "System.Base64FormattingOptions" "None") supplied-options))
  "Master wrapper for System.Convert.TryToBase64Chars out-only overloads. Dispatches at runtime. Each out parameter is returned as an additional cl:values result (after the primary return value), in C# declaration order.

TryToBase64Chars(Byte], Char], out Int32&, Base64FormattingOptions = None) -> Boolean
  Summary: Tries to convert the 8-bit unsigned integers inside the specified read-only span into their equivalent string representation that is encoded with base-64 digits. You can optionally specify whether to insert line breaks in the return value.
  Returns: if the conversion is successful; otherwise, .
  Parameters:
    - bytes (System.ReadOnlySpan`1[System.Byte]): A read-only span of 8-bit unsigned integers.
    - chars (System.Span`1[System.Char]): The span in which to write the string representation in base 64 of the elements in bytes. If the length of bytes is 0, or when this method returns , nothing is written into this parameter.
    - chars-written (System.Int32&): When this method returns, contains the total number of characters written into chars.
    - options (System.Base64FormattingOptions): One of the enumeration values that specify whether to insert line breaks in the return value. The default value is System.Base64FormattingOptions.None.
"
  (cl:cond
    ((cl:and (cl:or (cl:null bytes) (dotnet:is-instance-of bytes "System.ReadOnlySpan`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null chars) (dotnet:is-instance-of chars "System.Span`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:not supplied-options) (cl:or (cl:null options) (dotnet:is-instance-of options "System.Base64FormattingOptions"))))
     (dotnet:call-out <type-str> "TryToBase64Chars" bytes chars (cl:if supplied-options options (dotnet:enum-or "System.Base64FormattingOptions" "None"))))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "TryToBase64Chars"
                    :supplied-args (cl:append (cl:list :bytes bytes) (cl:list :chars chars) (cl:when supplied-options (cl:list :options options)))))))

(cl:defun try-to-hex-string (source destination)
  "Master wrapper for System.Convert.TryToHexString out-only overloads. Dispatches at runtime. Each out parameter is returned as an additional cl:values result (after the primary return value), in C# declaration order.

TryToHexString(Byte], Char], out Int32&) -> Boolean
  Summary: Converts a span of 8-bit unsigned integers to its equivalent span representation that is encoded with uppercase hex characters.
  Returns: if the conversion was successful; otherwise, .
  Parameters:
    - source (System.ReadOnlySpan`1[System.Byte]): A span of 8-bit unsigned integers.
    - destination (System.Span`1[System.Char]): The span representation in hex of the elements in source.
    - chars-written (System.Int32&): When this method returns, contains the number of chars that were written in destination.

TryToHexString(Byte], Byte], out Int32&) -> Boolean
  Summary: Converts a span of 8-bit unsigned integers to its equivalent UTF-8 span representation that is encoded with uppercase hex characters.
  Returns: if the conversion was successful; otherwise, .
  Parameters:
    - source (System.ReadOnlySpan`1[System.Byte]): A span of 8-bit unsigned integers.
    - utf8-destination (System.Span`1[System.Byte]): The UTF-8 span representation in hex of the elements in source.
    - bytes-written (System.Int32&): When this method returns, contains the number of bytes that were written in utf8Destination.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.ReadOnlySpan`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null destination) (dotnet:is-instance-of destination "System.Span`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:call-out <type-str> "TryToHexString" source destination))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.ReadOnlySpan`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null destination) (dotnet:is-instance-of destination "System.Span`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:call-out <type-str> "TryToHexString" source destination))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "TryToHexString"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :destination destination))))))

(cl:defun try-to-hex-string-lower (source destination)
  "Master wrapper for System.Convert.TryToHexStringLower out-only overloads. Dispatches at runtime. Each out parameter is returned as an additional cl:values result (after the primary return value), in C# declaration order.

TryToHexStringLower(Byte], Char], out Int32&) -> Boolean
  Summary: Converts a span of 8-bit unsigned integers to its equivalent span representation that is encoded with lowercase hex characters.
  Returns: if the conversion was successful; otherwise, .
  Parameters:
    - source (System.ReadOnlySpan`1[System.Byte]): A span of 8-bit unsigned integers.
    - destination (System.Span`1[System.Char]): The span representation in hex of the elements in source.
    - chars-written (System.Int32&): When this method returns, contains the number of chars that were written in destination.

TryToHexStringLower(Byte], Byte], out Int32&) -> Boolean
  Summary: Converts a span of 8-bit unsigned integers to its equivalent UTF-8 span representation that is encoded with lowercase hex characters.
  Returns: if the conversion was successful; otherwise, .
  Parameters:
    - source (System.ReadOnlySpan`1[System.Byte]): A span of 8-bit unsigned integers.
    - utf8-destination (System.Span`1[System.Byte]): The UTF-8 span representation in hex of the elements in source.
    - bytes-written (System.Int32&): When this method returns, contains the number of bytes that were written in utf8Destination.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.ReadOnlySpan`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null destination) (dotnet:is-instance-of destination "System.Span`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:call-out <type-str> "TryToHexStringLower" source destination))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.ReadOnlySpan`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null destination) (dotnet:is-instance-of destination "System.Span`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:call-out <type-str> "TryToHexStringLower" source destination))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONVERT"
                    :class-name <type-str>
                    :method-name "TryToHexStringLower"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :destination destination))))))

