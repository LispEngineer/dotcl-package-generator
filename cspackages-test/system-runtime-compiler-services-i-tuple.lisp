;;; Generated automatically. Do not edit.
;;; Class: System.Runtime.CompilerServices.ITuple
;;; Generator Version: 51
;;; Creation Date: 2026-07-19T15:11:53Z

(cl:in-package :system-runtime-compiler-services-i-tuple)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Runtime.CompilerServices.ITuple"))
(cl:defconstant <type-str> "System.Runtime.CompilerServices.ITuple")
(cl:defconstant <creation> "2026-07-19T15:11:53Z")
(cl:defconstant <version> 51)

(cl:defun item (obj! index)
  (dotnet:invoke (cl:the (dotnet "System.Runtime.CompilerServices.ITuple") obj!) "get_Item" index))

(cl:defun length (obj!)
  "Gets the number of elements in this instance."
  (dotnet:invoke (cl:the (dotnet "System.Runtime.CompilerServices.ITuple") obj!) "get_Length"))

