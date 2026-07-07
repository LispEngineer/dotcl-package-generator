;;; Generated automatically. Do not edit.
;;; Class: System.SystemException
;;; Generator Version: 40
;;; Creation Date: 2026-07-07T01:02:29Z

(cl:in-package :system-system-exception)

(cl:defconstant <type> (dotnet:resolve-type "System.SystemException"))
(cl:defconstant <type-str> "System.SystemException")
(cl:defconstant <creation> "2026-07-07T01:02:29Z")
(cl:defconstant <version> 40)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.SystemException")))

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
  Summary: Initializes a new instance of the System.SystemException class with serialized data.
  Parameters:
    - info (System.Runtime.Serialization.SerializationInfo): The object that holds the serialized object data.
    - context (System.Runtime.Serialization.StreamingContext): The contextual information about the source or destination.
"
  (cl:cond
    ((cl:and supplied-message (cl:stringp message) supplied-inner-exception (cl:or (cl:null inner-exception) (dotnet:object-type inner-exception)))
     (dotnet:new <type-str> message inner-exception))
    ((cl:and supplied-message (cl:or (cl:null message) (dotnet:object-type message)) supplied-inner-exception (cl:or (cl:null inner-exception) (dotnet:object-type inner-exception)))
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

