;;; Generated automatically. Do not edit.
;;; Class: System.Runtime.Serialization.IDeserializationCallback
;;; Generator Version: 50
;;; Creation Date: 2026-07-15T12:15:32Z

(cl:in-package :system-runtime-serialization-i-deserialization-callback)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Runtime.Serialization.IDeserializationCallback"))
(cl:defconstant <type-str> "System.Runtime.Serialization.IDeserializationCallback")
(cl:defconstant <creation> "2026-07-15T12:15:32Z")
(cl:defconstant <version> 50)

(cl:defun on-deserialization (obj! sender)
  "Summary: Runs when the entire object graph has been deserialized.
Parameters:
  - sender (System.Object): The object that initiated the callback. The functionality for this parameter is not currently implemented.
"
  (dotnet:invoke (cl:the (dotnet "System.Runtime.Serialization.IDeserializationCallback") obj!) "OnDeserialization" sender))

