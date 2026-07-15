;;; Generated automatically. Do not edit.
;;; Class: System.IDisposable
;;; Generator Version: 49
;;; Creation Date: 2026-07-15T02:38:57Z

(cl:in-package :system-i-disposable)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.IDisposable"))
(cl:defconstant <type-str> "System.IDisposable")
(cl:defconstant <creation> "2026-07-15T02:38:57Z")
(cl:defconstant <version> 49)

(cl:defun dispose (obj!)
  "Summary: Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources.
"
  (dotnet:invoke (cl:the (dotnet "System.IDisposable") obj!) "Dispose"))

