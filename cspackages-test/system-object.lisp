;;; Generated automatically. Do not edit.
;;; Class: System.Object
;;; Generator Version: 18
;;; Creation Date: 2026-07-02T22:15:29Z

(cl:in-package :cl-user)

(cl:defpackage :system-object
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:equals
   #:equals*
   #:equals-object
   #:equals-object-object
   #:finalize
   #:get-hash-code
   #:get-type
   #:memberwise-clone
   #:reference-equals
   #:to-string
  ))

(cl:in-package :system-object)

(cl:defconstant <type> (monoutils:get-type "System.Object"))
(cl:defconstant <type-str> "System.Object")
(cl:defconstant <creation> "2026-07-02T22:15:29Z")
(cl:defconstant <version> 18)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Object")))

(cl:defun new ()
  "Summary: Initializes a new instance of the System.Object class.
"
  (dotnet:new <type-str>))

(cl:defun equals (obj obj)
  "Summary: Determines whether the specified object is equal to the current object.
Returns: if the specified object is equal to the current object; otherwise, .
Parameters:
  - obj (System.Object): The object to compare with the current object.
"
  (dotnet:invoke (cl:the (dotnet "System.Object") obj) "Equals" obj))

(cl:defun equals* (obj-a obj-b)
  "Summary: Determines whether the specified object instances are considered equal.
Returns: if the objects are considered equal; otherwise, . If both objA and objB are null, the method returns .
Parameters:
  - obj-a (System.Object): The first object to compare.
  - obj-b (System.Object): The second object to compare.
"
  (dotnet:static <type-str> "Equals" (cl:the (dotnet "System.Object") obj-a) (cl:the (dotnet "System.Object") obj-b)))

(cl:defun equals-object (obj obj)
  "Calls System.Object.Equals Equals(Object) -> Boolean. Summary: Determines whether the specified object is equal to the current object.
Returns: if the specified object is equal to the current object; otherwise, .
Parameters:
  - obj (System.Object): The object to compare with the current object.
"
  (dotnet:invoke (cl:the (dotnet "System.Object") obj) "Equals" obj))

(cl:defun equals-object-object (obj-a obj-b)
  "Calls System.Object.Equals Equals(Object, Object) -> Boolean. Summary: Determines whether the specified object instances are considered equal.
Returns: if the objects are considered equal; otherwise, . If both objA and objB are null, the method returns .
Parameters:
  - obj-a (System.Object): The first object to compare.
  - obj-b (System.Object): The second object to compare.
"
  (dotnet:static <type-str> "Equals" (cl:the (dotnet "System.Object") obj-a) (cl:the (dotnet "System.Object") obj-b)))

(cl:defun finalize (obj)
  "Summary: Allows an object to try to free resources and perform other cleanup operations before it is reclaimed by garbage collection.
"
  (dotnet:invoke (cl:the (dotnet "System.Object") obj) "Finalize"))

(cl:defun get-hash-code (obj)
  "Summary: Serves as the default hash function.
Returns: A hash code for the current object.
"
  (dotnet:invoke (cl:the (dotnet "System.Object") obj) "GetHashCode"))

(cl:defun get-type (obj)
  "Summary: Gets the System.Type of the current instance.
Returns: The exact runtime type of the current instance.
"
  (dotnet:invoke (cl:the (dotnet "System.Object") obj) "GetType"))

(cl:defun memberwise-clone (obj)
  "Summary: Creates a shallow copy of the current System.Object.
Returns: A shallow copy of the current System.Object.
"
  (dotnet:invoke (cl:the (dotnet "System.Object") obj) "MemberwiseClone"))

(cl:defun reference-equals (obj-a obj-b)
  "Summary: Determines whether the specified System.Object instances are the same instance.
Returns: if objA is the same instance as objB or if both are null; otherwise, .
Parameters:
  - obj-a (System.Object): The first object to compare.
  - obj-b (System.Object): The second object to compare.
"
  (dotnet:static <type-str> "ReferenceEquals" (cl:the (dotnet "System.Object") obj-a) (cl:the (dotnet "System.Object") obj-b)))

(cl:defun to-string (obj)
  "Summary: Returns a string that represents the current object.
Returns: A string that represents the current object.
"
  (dotnet:invoke (cl:the (dotnet "System.Object") obj) "ToString"))

