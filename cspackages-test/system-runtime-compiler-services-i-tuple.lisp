;;; Generated automatically. Do not edit.
;;; Class: System.Runtime.CompilerServices.ITuple
;;; Generator Version: 38
;;; Creation Date: 2026-07-06T00:35:02Z

(cl:in-package :system-runtime-compiler-services-i-tuple)

(cl:defconstant <type> (dotnet:resolve-type "System.Runtime.CompilerServices.ITuple"))
(cl:defconstant <type-str> "System.Runtime.CompilerServices.ITuple")
(cl:defconstant <creation> "2026-07-06T00:35:02Z")
(cl:defconstant <version> 38)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Runtime.CompilerServices.ITuple")))

(cl:defun item (obj! index)
  (dotnet:invoke (cl:the (dotnet "System.Runtime.CompilerServices.ITuple") obj!) "get_Item" index))

(cl:defun length (obj!)
  "Gets the number of elements in this instance."
  (dotnet:invoke (cl:the (dotnet "System.Runtime.CompilerServices.ITuple") obj!) "get_Length"))

