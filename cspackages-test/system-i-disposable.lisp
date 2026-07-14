;;; Generated automatically. Do not edit.
;;; Class: System.IDisposable
;;; Generator Version: 48
;;; Creation Date: 2026-07-14T16:26:13Z

(cl:in-package :system-i-disposable)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.IDisposable"))
(cl:defconstant <type-str> "System.IDisposable")
(cl:defconstant <creation> "2026-07-14T16:26:13Z")
(cl:defconstant <version> 48)

(cl:defun dispose (obj!)
  "Summary: Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources.
"
  (dotnet:invoke (cl:the (dotnet "System.IDisposable") obj!) "Dispose"))

