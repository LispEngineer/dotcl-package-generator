;;; Generated automatically. Do not edit.
;;; Class: System.SystemException
;;; Generator Version: 53
;;; Creation Date: 2026-07-19T16:02:09Z
;;; Options: --export-interfaces --export-object --export-parents
;;; Discovered via: --export-parents/--export-interfaces from System.ArgumentOutOfRangeException

(cl:in-package :system-system-exception)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.SystemException"))
(cl:defconstant <type-str> "System.SystemException")
(cl:defconstant <creation> "2026-07-19T16:02:09Z")
(cl:defconstant <version> 53)

(cl:defun new (cl:&optional (message cl:nil supplied-message) (inner-exception cl:nil supplied-inner-exception))
  "Master wrapper for System.SystemException constructor overloads. Dispatches at runtime.

new()
  Summary: Initializes a new instance of the System.SystemException class.

new(String)
  Summary: Initializes a new instance of the System.SystemException class with a specified error message.
  Parameters:
    - message (System.String): The message that describes the error.

new(String, Exception)
  Summary: Initializes a new instance of the System.SystemException class with a specified error message and a reference to the inner exception that is the cause of this exception.
  Parameters:
    - message (System.String): The error message that explains the reason for the exception.
    - inner-exception (System.Exception): The exception that is the cause of the current exception. If the innerException parameter is not a null reference ( in Visual Basic), the current exception is raised in a block that handles the inner exception.

new(SerializationInfo, StreamingContext)
  OBSOLETE: This API supports obsolete formatter-based serialization. It should not be called or extended by application code.
  Summary: Initializes a new instance of the System.SystemException class with serialized data.
  Parameters:
    - info (System.Runtime.Serialization.SerializationInfo): The object that holds the serialized object data.
    - context (System.Runtime.Serialization.StreamingContext): The contextual information about the source or destination.
"
  (cl:cond
    ((cl:and supplied-message (cl:stringp message) supplied-inner-exception (cl:or (cl:null inner-exception) (dotnet:is-instance-of inner-exception "System.Exception")))
     (dotnet:new <type-str> message inner-exception))
    ((cl:and supplied-message (cl:or (cl:null message) (dotnet:is-instance-of message "System.Runtime.Serialization.SerializationInfo")) supplied-inner-exception (cl:or (cl:null inner-exception) (dotnet:is-instance-of inner-exception "System.Runtime.Serialization.StreamingContext")))
     (dotnet:new <type-str> message inner-exception))
    ((cl:and supplied-message (cl:stringp message) (cl:not supplied-inner-exception))
     (dotnet:new <type-str> message))
    ((cl:and (cl:not supplied-message) (cl:not supplied-inner-exception))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-SYSTEM-EXCEPTION"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-message (cl:list :message message)) (cl:when supplied-inner-exception (cl:list :inner-exception inner-exception)))))))

