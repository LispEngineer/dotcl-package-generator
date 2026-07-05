;;; Generated automatically. Do not edit.
;;; Class: System.ArgumentOutOfRangeException
;;; Generator Version: 34
;;; Creation Date: 2026-07-05T17:20:43Z

(cl:in-package :system-argument-out-of-range-exception)

(cl:defconstant <type> (dotnet:resolve-type "System.ArgumentOutOfRangeException"))
(cl:defconstant <type-str> "System.ArgumentOutOfRangeException")
(cl:defconstant <creation> "2026-07-05T17:20:43Z")
(cl:defconstant <version> 34)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.ArgumentOutOfRangeException")))

(cl:defun new (cl:&optional (param-name cl:nil supplied-param-name) (message cl:nil supplied-message) (message2 cl:nil supplied-message2))
  "Master wrapper for System.ArgumentOutOfRangeException constructor overloads. Dispatches at runtime.

new()
  Summary: Initializes a new instance of the System.ArgumentOutOfRangeException class.

new(String)
  Summary: Initializes a new instance of the System.ArgumentOutOfRangeException class with the name of the parameter that causes this exception.
  Parameters:
    - param-name (System.String): The name of the parameter that causes this exception.

new(String, String)
  Summary: Initializes a new instance of the System.ArgumentOutOfRangeException class with the name of the parameter that causes this exception and a specified error message.
  Parameters:
    - param-name (System.String): The name of the parameter that caused the exception.
    - message (System.String): The message that describes the error.

new(String, Exception)
  Summary: Initializes a new instance of the System.ArgumentOutOfRangeException class with a specified error message and the exception that is the cause of this exception.
  Parameters:
    - message (System.String): The error message that explains the reason for this exception.
    - inner-exception (System.Exception): The exception that is the cause of the current exception, or a null reference ( in Visual Basic) if no inner exception is specified.

new(SerializationInfo, StreamingContext)
  Summary: Initializes a new instance of the System.ArgumentOutOfRangeException class with serialized data.
  Parameters:
    - info (System.Runtime.Serialization.SerializationInfo): The object that holds the serialized object data.
    - context (System.Runtime.Serialization.StreamingContext): An object that describes the source or destination of the serialized data.

new(String, Object, String)
  Summary: Initializes a new instance of the System.ArgumentOutOfRangeException class with the parameter name, the value of the argument, and a specified error message.
  Parameters:
    - param-name (System.String): The name of the parameter that caused the exception.
    - actual-value (System.Object): The value of the argument that causes this exception.
    - message (System.String): The message that describes the error.
"
  (cl:cond
    ((cl:and supplied-param-name (cl:stringp param-name) supplied-message (cl:or (cl:null message) (dotnet:object-type message)) supplied-message2 (cl:stringp message2))
     (dotnet:new <type-str> param-name message message2))
    ((cl:and supplied-param-name (cl:stringp param-name) supplied-message (cl:stringp message) (cl:not supplied-message2))
     (dotnet:new <type-str> param-name message))
    ((cl:and supplied-param-name (cl:stringp param-name) supplied-message (cl:or (cl:null message) (dotnet:object-type message)) (cl:not supplied-message2))
     (dotnet:new <type-str> param-name message))
    ((cl:and supplied-param-name (cl:or (cl:null param-name) (dotnet:object-type param-name)) supplied-message (cl:or (cl:null message) (dotnet:object-type message)) (cl:not supplied-message2))
     (dotnet:new <type-str> param-name message))
    ((cl:and supplied-param-name (cl:stringp param-name) (cl:not supplied-message) (cl:not supplied-message2))
     (dotnet:new <type-str> param-name))
    ((cl:and (cl:not supplied-param-name) (cl:not supplied-message) (cl:not supplied-message2))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARGUMENT-OUT-OF-RANGE-EXCEPTION"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-param-name (cl:list :param-name param-name)) (cl:when supplied-message (cl:list :message message)) (cl:when supplied-message2 (cl:list :message2 message2)))))))

(cl:defun actual-value (obj!)
  "Gets the argument value that causes this exception."
  (dotnet:invoke (cl:the (dotnet "System.ArgumentOutOfRangeException") obj!) "get_ActualValue"))

(cl:defun message (obj!)
  "Gets the error message and the string representation of the invalid argument value, or only the error message if the argument value is null."
  (dotnet:invoke (cl:the (dotnet "System.ArgumentOutOfRangeException") obj!) "get_Message"))

(cl:defun get-object-data (obj! info context)
  "Summary: Sets the System.Runtime.Serialization.SerializationInfo object with the invalid argument value and additional exception information.
Parameters:
  - info (System.Runtime.Serialization.SerializationInfo): The object that holds the serialized object data.
  - context (System.Runtime.Serialization.StreamingContext): An object that describes the source or destination of the serialized data.
"
  (dotnet:invoke (cl:the (dotnet "System.ArgumentOutOfRangeException") obj!) "GetObjectData" info context))

(cl:defun throw-if-equal (type value other cl:&key (param-name cl:nil supplied-param-name))
  "Master wrapper for System.ArgumentOutOfRangeException.ThrowIfEqual overloads. Dispatches at runtime.

ThrowIfEqual(T, T, String) -> Void
  Summary: Throws an System.ArgumentOutOfRangeException if value is equal to other.
  Parameters:
    - value (T): The argument to validate as not equal to other.
    - other (T): The value to compare with value.
    - param-name (System.String): The name of the parameter with which value corresponds.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:or (cl:null other) (dotnet:object-type other)) (cl:stringp param-name))
     (dotnet:static-generic <type-str> "ThrowIfEqual" (cl:list type) value other param-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARGUMENT-OUT-OF-RANGE-EXCEPTION"
                    :class-name <type-str>
                    :method-name "ThrowIfEqual"
                    :supplied-args (cl:append (cl:list :value value) (cl:list :other other) (cl:when supplied-param-name (cl:list :param-name param-name)))))))

;; Note: System.ArgumentOutOfRangeException.ThrowIfEqual also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   ThrowIfEqual(T, T, String) -> Void

(cl:defun throw-if-greater-than (type value other cl:&key (param-name cl:nil supplied-param-name))
  "Master wrapper for System.ArgumentOutOfRangeException.ThrowIfGreaterThan overloads. Dispatches at runtime.

ThrowIfGreaterThan(T, T, String) -> Void
  Summary: Throws an System.ArgumentOutOfRangeException if value is greater than other.
  Parameters:
    - value (T): The argument to validate as less than or equal to other.
    - other (T): The value to compare with value.
    - param-name (System.String): The name of the parameter with which value corresponds.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:or (cl:null other) (dotnet:object-type other)) (cl:stringp param-name))
     (dotnet:static-generic <type-str> "ThrowIfGreaterThan" (cl:list type) value other param-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARGUMENT-OUT-OF-RANGE-EXCEPTION"
                    :class-name <type-str>
                    :method-name "ThrowIfGreaterThan"
                    :supplied-args (cl:append (cl:list :value value) (cl:list :other other) (cl:when supplied-param-name (cl:list :param-name param-name)))))))

;; Note: System.ArgumentOutOfRangeException.ThrowIfGreaterThan also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   ThrowIfGreaterThan(T, T, String) -> Void

(cl:defun throw-if-greater-than-or-equal (type value other cl:&key (param-name cl:nil supplied-param-name))
  "Master wrapper for System.ArgumentOutOfRangeException.ThrowIfGreaterThanOrEqual overloads. Dispatches at runtime.

ThrowIfGreaterThanOrEqual(T, T, String) -> Void
  Summary: Throws an System.ArgumentOutOfRangeException if value is greater than or equal to other.
  Parameters:
    - value (T): The argument to validate as less than other.
    - other (T): The value to compare with value.
    - param-name (System.String): The name of the parameter with which value corresponds.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:or (cl:null other) (dotnet:object-type other)) (cl:stringp param-name))
     (dotnet:static-generic <type-str> "ThrowIfGreaterThanOrEqual" (cl:list type) value other param-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARGUMENT-OUT-OF-RANGE-EXCEPTION"
                    :class-name <type-str>
                    :method-name "ThrowIfGreaterThanOrEqual"
                    :supplied-args (cl:append (cl:list :value value) (cl:list :other other) (cl:when supplied-param-name (cl:list :param-name param-name)))))))

;; Note: System.ArgumentOutOfRangeException.ThrowIfGreaterThanOrEqual also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   ThrowIfGreaterThanOrEqual(T, T, String) -> Void

(cl:defun throw-if-less-than (type value other cl:&key (param-name cl:nil supplied-param-name))
  "Master wrapper for System.ArgumentOutOfRangeException.ThrowIfLessThan overloads. Dispatches at runtime.

ThrowIfLessThan(T, T, String) -> Void
  Summary: Throws an System.ArgumentOutOfRangeException if value is less than other.
  Parameters:
    - value (T): The argument to validate as greater than or equal to other.
    - other (T): The value to compare with value.
    - param-name (System.String): The name of the parameter with which value corresponds.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:or (cl:null other) (dotnet:object-type other)) (cl:stringp param-name))
     (dotnet:static-generic <type-str> "ThrowIfLessThan" (cl:list type) value other param-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARGUMENT-OUT-OF-RANGE-EXCEPTION"
                    :class-name <type-str>
                    :method-name "ThrowIfLessThan"
                    :supplied-args (cl:append (cl:list :value value) (cl:list :other other) (cl:when supplied-param-name (cl:list :param-name param-name)))))))

;; Note: System.ArgumentOutOfRangeException.ThrowIfLessThan also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   ThrowIfLessThan(T, T, String) -> Void

(cl:defun throw-if-less-than-or-equal (type value other cl:&key (param-name cl:nil supplied-param-name))
  "Master wrapper for System.ArgumentOutOfRangeException.ThrowIfLessThanOrEqual overloads. Dispatches at runtime.

ThrowIfLessThanOrEqual(T, T, String) -> Void
  Summary: Throws an System.ArgumentOutOfRangeException if value is less than or equal to other.
  Parameters:
    - value (T): The argument to validate as greater than other.
    - other (T): The value to compare with value.
    - param-name (System.String): The name of the parameter with which value corresponds.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:or (cl:null other) (dotnet:object-type other)) (cl:stringp param-name))
     (dotnet:static-generic <type-str> "ThrowIfLessThanOrEqual" (cl:list type) value other param-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARGUMENT-OUT-OF-RANGE-EXCEPTION"
                    :class-name <type-str>
                    :method-name "ThrowIfLessThanOrEqual"
                    :supplied-args (cl:append (cl:list :value value) (cl:list :other other) (cl:when supplied-param-name (cl:list :param-name param-name)))))))

;; Note: System.ArgumentOutOfRangeException.ThrowIfLessThanOrEqual also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   ThrowIfLessThanOrEqual(T, T, String) -> Void

(cl:defun throw-if-negative (type value cl:&key (param-name cl:nil supplied-param-name))
  "Master wrapper for System.ArgumentOutOfRangeException.ThrowIfNegative overloads. Dispatches at runtime.

ThrowIfNegative(T, String) -> Void
  Summary: Throws an System.ArgumentOutOfRangeException if value is negative.
  Parameters:
    - value (T): The argument to validate as non-negative.
    - param-name (System.String): The name of the parameter with which value corresponds.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:stringp param-name))
     (dotnet:static-generic <type-str> "ThrowIfNegative" (cl:list type) value param-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARGUMENT-OUT-OF-RANGE-EXCEPTION"
                    :class-name <type-str>
                    :method-name "ThrowIfNegative"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-param-name (cl:list :param-name param-name)))))))

;; Note: System.ArgumentOutOfRangeException.ThrowIfNegative also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   ThrowIfNegative(T, String) -> Void

(cl:defun throw-if-negative-or-zero (type value cl:&key (param-name cl:nil supplied-param-name))
  "Master wrapper for System.ArgumentOutOfRangeException.ThrowIfNegativeOrZero overloads. Dispatches at runtime.

ThrowIfNegativeOrZero(T, String) -> Void
  Summary: Throws an System.ArgumentOutOfRangeException if value is negative or zero.
  Parameters:
    - value (T): The argument to validate as non-zero and non-negative.
    - param-name (System.String): The name of the parameter with which value corresponds.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:stringp param-name))
     (dotnet:static-generic <type-str> "ThrowIfNegativeOrZero" (cl:list type) value param-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARGUMENT-OUT-OF-RANGE-EXCEPTION"
                    :class-name <type-str>
                    :method-name "ThrowIfNegativeOrZero"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-param-name (cl:list :param-name param-name)))))))

;; Note: System.ArgumentOutOfRangeException.ThrowIfNegativeOrZero also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   ThrowIfNegativeOrZero(T, String) -> Void

(cl:defun throw-if-not-equal (type value other cl:&key (param-name cl:nil supplied-param-name))
  "Master wrapper for System.ArgumentOutOfRangeException.ThrowIfNotEqual overloads. Dispatches at runtime.

ThrowIfNotEqual(T, T, String) -> Void
  Summary: Throws an System.ArgumentOutOfRangeException if value is not equal to other.
  Parameters:
    - value (T): The argument to validate as equal to other.
    - other (T): The value to compare with value.
    - param-name (System.String): The name of the parameter with which value corresponds.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:or (cl:null other) (dotnet:object-type other)) (cl:stringp param-name))
     (dotnet:static-generic <type-str> "ThrowIfNotEqual" (cl:list type) value other param-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARGUMENT-OUT-OF-RANGE-EXCEPTION"
                    :class-name <type-str>
                    :method-name "ThrowIfNotEqual"
                    :supplied-args (cl:append (cl:list :value value) (cl:list :other other) (cl:when supplied-param-name (cl:list :param-name param-name)))))))

;; Note: System.ArgumentOutOfRangeException.ThrowIfNotEqual also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   ThrowIfNotEqual(T, T, String) -> Void

(cl:defun throw-if-zero (type value cl:&key (param-name cl:nil supplied-param-name))
  "Master wrapper for System.ArgumentOutOfRangeException.ThrowIfZero overloads. Dispatches at runtime.

ThrowIfZero(T, String) -> Void
  Summary: Throws an System.ArgumentOutOfRangeException if value is zero.
  Parameters:
    - value (T): The argument to validate as non-zero.
    - param-name (System.String): The name of the parameter with which value corresponds.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:stringp param-name))
     (dotnet:static-generic <type-str> "ThrowIfZero" (cl:list type) value param-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARGUMENT-OUT-OF-RANGE-EXCEPTION"
                    :class-name <type-str>
                    :method-name "ThrowIfZero"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-param-name (cl:list :param-name param-name)))))))

;; Note: System.ArgumentOutOfRangeException.ThrowIfZero also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   ThrowIfZero(T, String) -> Void

