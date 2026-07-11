;;; Generated automatically. Do not edit.
;;; Class: System.ArgumentException
;;; Generator Version: 47
;;; Creation Date: 2026-07-11T23:06:47Z

(cl:in-package :system-argument-exception)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.ArgumentException"))
(cl:defconstant <type-str> "System.ArgumentException")
(cl:defconstant <creation> "2026-07-11T23:06:47Z")
(cl:defconstant <version> 47)

(cl:defun new (cl:&optional (message cl:nil supplied-message) (inner-exception cl:nil supplied-inner-exception) (inner-exception2 cl:nil supplied-inner-exception2))
  "Master wrapper for System.ArgumentException constructor overloads. Dispatches at runtime.

new()
  Summary: Initializes a new instance of the System.ArgumentException class.

new(String)
  Summary: Initializes a new instance of the System.ArgumentException class with a specified error message.
  Parameters:
    - message (System.String): The error message that explains the reason for the exception.

new(String, Exception)
  Summary: Initializes a new instance of the System.ArgumentException class with a specified error message and a reference to the inner exception that is the cause of this exception.
  Parameters:
    - message (System.String): The error message that explains the reason for the exception.
    - inner-exception (System.Exception): The exception that is the cause of the current exception. If the innerException parameter is not a null reference, the current exception is raised in a block that handles the inner exception.

new(String, String)
  Summary: Initializes a new instance of the System.ArgumentException class with a specified error message and the name of the parameter that causes this exception.
  Parameters:
    - message (System.String): The error message that explains the reason for the exception.
    - param-name (System.String): The name of the parameter that caused the current exception.

new(SerializationInfo, StreamingContext)
  Summary: Initializes a new instance of the System.ArgumentException class with serialized data.
  Parameters:
    - info (System.Runtime.Serialization.SerializationInfo): The object that holds the serialized object data.
    - context (System.Runtime.Serialization.StreamingContext): The contextual information about the source or destination.

new(String, String, Exception)
  Summary: Initializes a new instance of the System.ArgumentException class with a specified error message, the parameter name, and a reference to the inner exception that is the cause of this exception.
  Parameters:
    - message (System.String): The error message that explains the reason for the exception.
    - param-name (System.String): The name of the parameter that caused the current exception.
    - inner-exception (System.Exception): The exception that is the cause of the current exception. If the innerException parameter is not a null reference, the current exception is raised in a block that handles the inner exception.
"
  (cl:cond
    ((cl:and supplied-message (cl:stringp message) supplied-inner-exception (cl:stringp inner-exception) supplied-inner-exception2 (cl:or (cl:null inner-exception2) (dotnet:object-type inner-exception2)))
     (dotnet:new <type-str> message inner-exception inner-exception2))
    ((cl:and supplied-message (cl:stringp message) supplied-inner-exception (cl:or (cl:null inner-exception) (dotnet:object-type inner-exception)) (cl:not supplied-inner-exception2))
     (dotnet:new <type-str> message inner-exception))
    ((cl:and supplied-message (cl:stringp message) supplied-inner-exception (cl:stringp inner-exception) (cl:not supplied-inner-exception2))
     (dotnet:new <type-str> message inner-exception))
    ((cl:and supplied-message (cl:or (cl:null message) (dotnet:object-type message)) supplied-inner-exception (cl:or (cl:null inner-exception) (dotnet:object-type inner-exception)) (cl:not supplied-inner-exception2))
     (dotnet:new <type-str> message inner-exception))
    ((cl:and supplied-message (cl:stringp message) (cl:not supplied-inner-exception) (cl:not supplied-inner-exception2))
     (dotnet:new <type-str> message))
    ((cl:and (cl:not supplied-message) (cl:not supplied-inner-exception) (cl:not supplied-inner-exception2))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARGUMENT-EXCEPTION"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-message (cl:list :message message)) (cl:when supplied-inner-exception (cl:list :inner-exception inner-exception)) (cl:when supplied-inner-exception2 (cl:list :inner-exception2 inner-exception2)))))))

(cl:defun message (obj!)
  "Gets the error message and the parameter name, or only the error message if no parameter name is set."
  (dotnet:invoke (cl:the (dotnet "System.ArgumentException") obj!) "get_Message"))

(cl:defun param-name (obj!)
  "Gets the name of the parameter that causes this exception."
  (dotnet:invoke (cl:the (dotnet "System.ArgumentException") obj!) "get_ParamName"))

(cl:defun get-object-data (obj! info context)
  "Summary: Sets the System.Runtime.Serialization.SerializationInfo object with the parameter name and additional exception information.
Parameters:
  - info (System.Runtime.Serialization.SerializationInfo): The object that holds the serialized object data.
  - context (System.Runtime.Serialization.StreamingContext): The contextual information about the source or destination.
"
  (dotnet:invoke (cl:the (dotnet "System.ArgumentException") obj!) "GetObjectData" info context))

(cl:defun throw-if-null-or-empty (argument cl:&key (param-name cl:nil supplied-param-name))
  "Master wrapper for System.ArgumentException.ThrowIfNullOrEmpty overloads. Dispatches at runtime.

ThrowIfNullOrEmpty(String, String) -> Void
  Summary: Throws an exception if argument is or empty.
  Parameters:
    - argument (System.String): The string argument to validate as non- and non-empty.
    - param-name (System.String): The name of the parameter with which argument corresponds.
"
  (cl:cond
    ((cl:and (cl:stringp argument) (cl:stringp param-name))
     (dotnet:static <type-str> "ThrowIfNullOrEmpty" argument param-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARGUMENT-EXCEPTION"
                    :class-name <type-str>
                    :method-name "ThrowIfNullOrEmpty"
                    :supplied-args (cl:append (cl:list :argument argument) (cl:when supplied-param-name (cl:list :param-name param-name)))))))

;; Note: System.ArgumentException.ThrowIfNullOrEmpty also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   ThrowIfNullOrEmpty(String, String) -> Void

(cl:defun throw-if-null-or-white-space (argument cl:&key (param-name cl:nil supplied-param-name))
  "Master wrapper for System.ArgumentException.ThrowIfNullOrWhiteSpace overloads. Dispatches at runtime.

ThrowIfNullOrWhiteSpace(String, String) -> Void
  Summary: Throws an exception if argument is , empty, or consists only of white-space characters.
  Parameters:
    - argument (System.String): The string argument to validate.
    - param-name (System.String): The name of the parameter with which argument corresponds.
"
  (cl:cond
    ((cl:and (cl:stringp argument) (cl:stringp param-name))
     (dotnet:static <type-str> "ThrowIfNullOrWhiteSpace" argument param-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ARGUMENT-EXCEPTION"
                    :class-name <type-str>
                    :method-name "ThrowIfNullOrWhiteSpace"
                    :supplied-args (cl:append (cl:list :argument argument) (cl:when supplied-param-name (cl:list :param-name param-name)))))))

;; Note: System.ArgumentException.ThrowIfNullOrWhiteSpace also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   ThrowIfNullOrWhiteSpace(String, String) -> Void

