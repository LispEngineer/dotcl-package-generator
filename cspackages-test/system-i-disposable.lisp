;;; Generated automatically. Do not edit.
;;; Class: System.IDisposable
;;; Generator Version: 53
;;; Creation Date: 2026-07-19T16:02:09Z
;;; Options: --export-interfaces --export-object --export-parents
;;; Discovered via: --export-parents/--export-interfaces from System.IO.MemoryStream

(cl:in-package :system-i-disposable)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.IDisposable"))
(cl:defconstant <type-str> "System.IDisposable")
(cl:defconstant <creation> "2026-07-19T16:02:09Z")
(cl:defconstant <version> 53)

(cl:defun dispose (obj!)
  "Summary: Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources.
"
  (dotnet:invoke (cl:the (dotnet "System.IDisposable") obj!) "Dispose"))

