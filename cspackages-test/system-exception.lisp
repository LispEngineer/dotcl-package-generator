;;; Generated automatically. Do not edit.
;;; Class: System.Exception
;;; Generator Version: 37
;;; Creation Date: 2026-07-05T18:46:38Z

(cl:in-package :system-exception)

(cl:defconstant <type> (dotnet:resolve-type "System.Exception"))
(cl:defconstant <type-str> "System.Exception")
(cl:defconstant <creation> "2026-07-05T18:46:38Z")
(cl:defconstant <version> 37)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Exception")))

(cl:defun new (cl:&optional (message cl:nil supplied-message) (inner-exception cl:nil supplied-inner-exception))
  "Master wrapper for System.Exception constructor overloads. Dispatches at runtime.

new()
  Summary: Initializes a new instance of the System.Exception class.

new(String)
  Summary: Initializes a new instance of the System.Exception class with a specified error message.
  Parameters:
    - message (System.String): The message that describes the error.

new(String, Exception)
  Summary: Initializes a new instance of the System.Exception class with a specified error message and a reference to the inner exception that is the cause of this exception.
  Parameters:
    - message (System.String): The error message that explains the reason for the exception.
    - inner-exception (System.Exception): The exception that is the cause of the current exception, or a null reference ( in Visual Basic) if no inner exception is specified.

new(SerializationInfo, StreamingContext)
  Summary: Initializes a new instance of the System.Exception class with serialized data.
  Parameters:
    - info (System.Runtime.Serialization.SerializationInfo): The System.Runtime.Serialization.SerializationInfo that holds the serialized object data about the exception being thrown.
    - context (System.Runtime.Serialization.StreamingContext): The System.Runtime.Serialization.StreamingContext that contains contextual information about the source or destination.
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
                    :package-name "SYSTEM-EXCEPTION"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-message (cl:list :message message)) (cl:when supplied-inner-exception (cl:list :inner-exception inner-exception)))))))

(cl:defun data (obj!)
  "Gets a collection of key/value pairs that provide additional user-defined information about the exception."
  (dotnet:invoke (cl:the (dotnet "System.Exception") obj!) "get_Data"))

(cl:defun help-link (obj!)
  "Gets or sets a link to the help file associated with this exception."
  (dotnet:invoke (cl:the (dotnet "System.Exception") obj!) "get_HelpLink"))

(cl:defun (cl:setf help-link) (new-value obj!)
  "Gets or sets a link to the help file associated with this exception."
  (dotnet:invoke (cl:the (dotnet "System.Exception") obj!) "set_HelpLink" new-value))

(cl:defun h-result (obj!)
  "Gets or sets HRESULT, a coded numerical value that is assigned to a specific exception."
  (dotnet:invoke (cl:the (dotnet "System.Exception") obj!) "get_HResult"))

(cl:defun (cl:setf h-result) (new-value obj!)
  "Gets or sets HRESULT, a coded numerical value that is assigned to a specific exception."
  (dotnet:invoke (cl:the (dotnet "System.Exception") obj!) "set_HResult" new-value))

(cl:defun inner-exception (obj!)
  "Gets the System.Exception instance that caused the current exception."
  (dotnet:invoke (cl:the (dotnet "System.Exception") obj!) "get_InnerException"))

(cl:defun message (obj!)
  "Gets a message that describes the current exception."
  (dotnet:invoke (cl:the (dotnet "System.Exception") obj!) "get_Message"))

(cl:defun source (obj!)
  "Gets or sets the name of the application or the object that causes the error."
  (dotnet:invoke (cl:the (dotnet "System.Exception") obj!) "get_Source"))

(cl:defun (cl:setf source) (new-value obj!)
  "Gets or sets the name of the application or the object that causes the error."
  (dotnet:invoke (cl:the (dotnet "System.Exception") obj!) "set_Source" new-value))

(cl:defun stack-trace (obj!)
  "Gets a string representation of the immediate frames on the call stack."
  (dotnet:invoke (cl:the (dotnet "System.Exception") obj!) "get_StackTrace"))

(cl:defun target-site (obj!)
  "Gets the method that throws the current exception."
  (dotnet:invoke (cl:the (dotnet "System.Exception") obj!) "get_TargetSite"))

(cl:defun add-serialize-object-state (obj! handler)
  "Occurs when an exception is serialized to create an exception state object that contains serialized data about the exception."
  (dotnet:add-event (cl:the (dotnet "System.Exception") obj!) "SerializeObjectState" handler))

(cl:defun remove-serialize-object-state (obj! handler)
  "Pass the exact same HANDLER object given to add-serialize-object-state -- removal is by identity, not by behavioral equivalence."
  (dotnet:remove-event (cl:the (dotnet "System.Exception") obj!) "SerializeObjectState" handler))

(cl:defun get-base-exception (obj!)
  "Summary: When overridden in a derived class, returns the System.Exception that is the root cause of one or more subsequent exceptions.
Returns: The first exception thrown in a chain of exceptions. If the System.Exception.InnerException property of the current exception is a null reference ( in Visual Basic), this property returns the current exception.
"
  (dotnet:invoke (cl:the (dotnet "System.Exception") obj!) "GetBaseException"))

(cl:defun get-object-data (obj! info context)
  "Summary: When overridden in a derived class, sets the System.Runtime.Serialization.SerializationInfo with information about the exception.
Parameters:
  - info (System.Runtime.Serialization.SerializationInfo): The System.Runtime.Serialization.SerializationInfo that holds the serialized object data about the exception being thrown.
  - context (System.Runtime.Serialization.StreamingContext): The System.Runtime.Serialization.StreamingContext that contains contextual information about the source or destination.
"
  (dotnet:invoke (cl:the (dotnet "System.Exception") obj!) "GetObjectData" info context))

(cl:defun get-type (obj!)
  "Summary: Gets the runtime type of the current instance.
Returns: A System.Type object that represents the exact runtime type of the current instance.
"
  (dotnet:invoke (cl:the (dotnet "System.Exception") obj!) "GetType"))

(cl:defun to-string (obj!)
  "Summary: Creates and returns a string representation of the current exception.
Returns: A string representation of the current exception.
"
  (dotnet:invoke (cl:the (dotnet "System.Exception") obj!) "ToString"))

