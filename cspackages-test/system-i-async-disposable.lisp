;;; Generated automatically. Do not edit.
;;; Class: System.IAsyncDisposable
;;; Generator Version: 38
;;; Creation Date: 2026-07-06T00:35:02Z

(cl:in-package :system-i-async-disposable)

(cl:defconstant <type> (dotnet:resolve-type "System.IAsyncDisposable"))
(cl:defconstant <type-str> "System.IAsyncDisposable")
(cl:defconstant <creation> "2026-07-06T00:35:02Z")
(cl:defconstant <version> 38)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.IAsyncDisposable")))

(cl:defun dispose-async (obj!)
  "Summary: Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources asynchronously.
Returns: A task that represents the asynchronous dispose operation.
"
  (dotnet:invoke (cl:the (dotnet "System.IAsyncDisposable") obj!) "DisposeAsync"))

