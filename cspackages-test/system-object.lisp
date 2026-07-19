;;; Generated automatically. Do not edit.
;;; Class: System.Object
;;; Generator Version: 52
;;; Creation Date: 2026-07-19T15:32:24Z
;;; Options: --defgeneric

(cl:in-package :system-object)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Object"))
(cl:defconstant <type-str> "System.Object")
(cl:defconstant <creation> "2026-07-19T15:32:24Z")
(cl:defconstant <version> 52)

(cl:defun new ()
  "Summary: Initializes a new instance of the System.Object class.
"
  (dotnet:new <type-str>))

(cl:defun equals (obj! obj)
  "Summary: Determines whether the specified object is equal to the current object.
Returns: if the specified object is equal to the current object; otherwise, .
Parameters:
  - obj (System.Object): The object to compare with the current object.
"
  (dotnet:invoke (cl:the (dotnet "System.Object") obj!) "Equals" obj))

(cl:defun equals* (obj-a obj-b)
  "Summary: Determines whether the specified object instances are considered equal.
Returns: if the objects are considered equal; otherwise, . If both objA and objB are null, the method returns .
Parameters:
  - obj-a (System.Object): The first object to compare.
  - obj-b (System.Object): The second object to compare.
"
  (dotnet:static <type-str> "Equals" (cl:the (dotnet "System.Object") obj-a) (cl:the (dotnet "System.Object") obj-b)))

(cl:defun finalize (obj!)
  "Summary: Allows an object to try to free resources and perform other cleanup operations before it is reclaimed by garbage collection.
"
  (dotnet:invoke (cl:the (dotnet "System.Object") obj!) "Finalize"))

(cl:defun get-hash-code (obj!)
  "Summary: Serves as the default hash function.
Returns: A hash code for the current object.
"
  (dotnet:invoke (cl:the (dotnet "System.Object") obj!) "GetHashCode"))

(cl:defun get-type (obj!)
  "Summary: Gets the System.Type of the current instance.
Returns: The exact runtime type of the current instance.
"
  (dotnet:invoke (cl:the (dotnet "System.Object") obj!) "GetType"))

(cl:defun memberwise-clone (obj!)
  "Summary: Creates a shallow copy of the current System.Object.
Returns: A shallow copy of the current System.Object.
"
  (dotnet:invoke (cl:the (dotnet "System.Object") obj!) "MemberwiseClone"))

(cl:defun reference-equals (obj-a obj-b)
  "Summary: Determines whether the specified System.Object instances are the same instance.
Returns: if objA is the same instance as objB or if both are null; otherwise, .
Parameters:
  - obj-a (System.Object): The first object to compare.
  - obj-b (System.Object): The second object to compare.
"
  (dotnet:static <type-str> "ReferenceEquals" (cl:the (dotnet "System.Object") obj-a) (cl:the (dotnet "System.Object") obj-b)))

(cl:defun to-string (obj!)
  "Summary: Returns a string that represents the current object.
Returns: A string that represents the current object.
"
  (dotnet:invoke (cl:the (dotnet "System.Object") obj!) "ToString"))

;; Extension methods (exact match on this == System.Object):
(cl:defun dummy-extension (obj! value)
  "Extension method from AssemblyToLispyTestTarget.Extensions (assembly AssemblyToLispyTestTarget.dll)."
  (dotnet:static "AssemblyToLispyTestTarget.Extensions" "DummyExtension" obj! value))


