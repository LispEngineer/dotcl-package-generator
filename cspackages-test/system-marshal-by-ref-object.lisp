;;; Generated automatically. Do not edit.
;;; Class: System.MarshalByRefObject
;;; Generator Version: 49
;;; Creation Date: 2026-07-15T02:38:57Z

(cl:in-package :system-marshal-by-ref-object)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.MarshalByRefObject"))
(cl:defconstant <type-str> "System.MarshalByRefObject")
(cl:defconstant <creation> "2026-07-15T02:38:57Z")
(cl:defconstant <version> 49)

(cl:defun new ()
  "Summary: Initializes a new instance of the System.MarshalByRefObject class.
"
  (dotnet:new <type-str>))

(cl:defun get-lifetime-service (obj!)
  "Summary: Retrieves the current lifetime service object that controls the lifetime policy for this instance.
Returns: An object of type System.Runtime.Remoting.Lifetime.ILease used to control the lifetime policy for this instance.
"
  (dotnet:invoke (cl:the (dotnet "System.MarshalByRefObject") obj!) "GetLifetimeService"))

(cl:defun initialize-lifetime-service (obj!)
  "Summary: Obtains a lifetime service object to control the lifetime policy for this instance.
Returns: An object of type System.Runtime.Remoting.Lifetime.ILease used to control the lifetime policy for this instance. This is the current lifetime service object for this instance if one exists; otherwise, a new lifetime service object initialized to the value of the System.Runtime.Remoting.Lifetime.LifetimeServices.LeaseManagerPollTime property.
"
  (dotnet:invoke (cl:the (dotnet "System.MarshalByRefObject") obj!) "InitializeLifetimeService"))

(cl:defun memberwise-clone (obj! clone-identity)
  "Summary: Creates a shallow copy of the current System.MarshalByRefObject object.
Returns: A shallow copy of the current System.MarshalByRefObject object.
Parameters:
  - clone-identity (System.Boolean): to delete the current System.MarshalByRefObject object's identity, which will cause the object to be assigned a new identity when it is marshaled across a remoting boundary. A value of is usually appropriate. to copy the current System.MarshalByRefObject object's identity to its clone, which will cause remoting client calls to be routed to the remote server object.
"
  (dotnet:invoke (cl:the (dotnet "System.MarshalByRefObject") obj!) "MemberwiseClone" clone-identity))

