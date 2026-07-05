;;; Generated automatically. Do not edit.
;;; Class: System.Runtime.Serialization.ISerializable
;;; Generator Version: 37
;;; Creation Date: 2026-07-05T18:46:38Z

(cl:in-package :system-runtime-serialization-i-serializable)

(cl:defconstant <type> (dotnet:resolve-type "System.Runtime.Serialization.ISerializable"))
(cl:defconstant <type-str> "System.Runtime.Serialization.ISerializable")
(cl:defconstant <creation> "2026-07-05T18:46:38Z")
(cl:defconstant <version> 37)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Runtime.Serialization.ISerializable")))

(cl:defun get-object-data (obj! info context)
  "Summary: Populates a System.Runtime.Serialization.SerializationInfo with the data needed to serialize the target object.
Parameters:
  - info (System.Runtime.Serialization.SerializationInfo): The System.Runtime.Serialization.SerializationInfo to populate with data.
  - context (System.Runtime.Serialization.StreamingContext): The destination (see System.Runtime.Serialization.StreamingContext) for this serialization.
"
  (dotnet:invoke (cl:the (dotnet "System.Runtime.Serialization.ISerializable") obj!) "GetObjectData" info context))

