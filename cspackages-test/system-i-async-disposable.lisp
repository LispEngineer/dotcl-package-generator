;;; Generated automatically. Do not edit.
;;; Class: System.IAsyncDisposable
;;; Generator Version: 36
;;; Creation Date: 2026-07-05T18:30:04Z

(cl:in-package :system-i-async-disposable)

(cl:defconstant <type> (dotnet:resolve-type "System.IAsyncDisposable"))
(cl:defconstant <type-str> "System.IAsyncDisposable")
(cl:defconstant <creation> "2026-07-05T18:30:04Z")
(cl:defconstant <version> 36)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.IAsyncDisposable")))

(cl:defun dispose-async (obj!)
  "Summary: Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources asynchronously.
Returns: A task that represents the asynchronous dispose operation.
"
  (dotnet:invoke (cl:the (dotnet "System.IAsyncDisposable") obj!) "DisposeAsync"))

