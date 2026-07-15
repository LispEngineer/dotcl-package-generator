;;; Generated automatically. Do not edit.
;;; Class: System.IAsyncDisposable
;;; Generator Version: 50
;;; Creation Date: 2026-07-15T12:15:32Z

(cl:in-package :system-i-async-disposable)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.IAsyncDisposable"))
(cl:defconstant <type-str> "System.IAsyncDisposable")
(cl:defconstant <creation> "2026-07-15T12:15:32Z")
(cl:defconstant <version> 50)

(cl:defun dispose-async (obj!)
  "Summary: Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources asynchronously.
Returns: A task that represents the asynchronous dispose operation.
"
  (dotnet:invoke (cl:the (dotnet "System.IAsyncDisposable") obj!) "DisposeAsync"))

;; Extension methods (exact match on this == System.IAsyncDisposable):
(cl:defun configure-await (obj! continue-on-captured-context)
  "Extension method from System.Threading.Tasks.TaskAsyncEnumerableExtensions (assembly System.Runtime.dll).
Summary: Configures how awaits on the tasks returned from an async disposable will be performed.
Returns: The configured async disposable.
Parameters:
  - continue-on-captured-context (System.Boolean): Whether to capture and marshal back to the current context.
"
  (dotnet:static "System.Threading.Tasks.TaskAsyncEnumerableExtensions" "ConfigureAwait" obj! continue-on-captured-context))


