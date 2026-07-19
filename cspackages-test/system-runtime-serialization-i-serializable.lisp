;;; Generated automatically. Do not edit.
;;; Class: System.Runtime.Serialization.ISerializable
;;; Generator Version: 54
;;; Creation Date: 2026-07-19T20:42:53Z
;;; Options: --export-interfaces --export-object --export-parents
;;; Discovered via: --export-parents/--export-interfaces from System.ArgumentOutOfRangeException

(cl:in-package :system-runtime-serialization-i-serializable)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Runtime.Serialization.ISerializable"))
(cl:defconstant <type-str> "System.Runtime.Serialization.ISerializable")
(cl:defconstant <creation> "2026-07-19T20:42:53Z")
(cl:defconstant <version> 54)

(cl:defun get-object-data (obj! info context)
  "OBSOLETE: Formatter-based serialization is obsolete and should not be used.
Summary: Populates a System.Runtime.Serialization.SerializationInfo with the data needed to serialize the target object.
Parameters:
  - info (System.Runtime.Serialization.SerializationInfo): The System.Runtime.Serialization.SerializationInfo to populate with data.
  - context (System.Runtime.Serialization.StreamingContext): The destination (see System.Runtime.Serialization.StreamingContext) for this serialization.
"
  (dotnet:invoke (cl:the (dotnet "System.Runtime.Serialization.ISerializable") obj!) "GetObjectData" info context))

