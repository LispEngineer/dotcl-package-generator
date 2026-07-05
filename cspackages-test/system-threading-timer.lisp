;;; Generated automatically. Do not edit.
;;; Class: System.Threading.Timer
;;; Generator Version: 36
;;; Creation Date: 2026-07-05T18:30:04Z

(cl:in-package :system-threading-timer)

(cl:defconstant <type> (dotnet:resolve-type "System.Threading.Timer"))
(cl:defconstant <type-str> "System.Threading.Timer")
(cl:defconstant <creation> "2026-07-05T18:30:04Z")
(cl:defconstant <version> 36)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Threading.Timer")))

(cl:defun new (callback cl:&optional (state cl:nil supplied-state) (due-time cl:nil supplied-due-time) (period cl:nil supplied-period))
  "Master wrapper for System.Threading.Timer constructor overloads. Dispatches at runtime.

new(TimerCallback)

new(TimerCallback, Object, Int32, Int32)

new(TimerCallback, Object, TimeSpan, TimeSpan)

new(TimerCallback, Object, UInt32, UInt32)

new(TimerCallback, Object, Int64, Int64)
"
  (cl:cond
    ((cl:and (cl:or (cl:null callback) (dotnet:object-type callback)) supplied-state (cl:or (cl:null state) (dotnet:object-type state)) supplied-due-time (cl:numberp due-time) supplied-period (cl:numberp period))
     (dotnet:new <type-str> callback state due-time period))
    ((cl:and (cl:or (cl:null callback) (dotnet:object-type callback)) supplied-state (cl:or (cl:null state) (dotnet:object-type state)) supplied-due-time (cl:or (cl:null due-time) (dotnet:object-type due-time)) supplied-period (cl:or (cl:null period) (dotnet:object-type period)))
     (dotnet:new <type-str> callback state due-time period))
    ((cl:and (cl:or (cl:null callback) (dotnet:object-type callback)) supplied-state (cl:or (cl:null state) (dotnet:object-type state)) supplied-due-time (cl:or (cl:null due-time) (dotnet:object-type due-time)) supplied-period (cl:or (cl:null period) (dotnet:object-type period)))
     (dotnet:new <type-str> callback state due-time period))
    ((cl:and (cl:or (cl:null callback) (dotnet:object-type callback)) supplied-state (cl:or (cl:null state) (dotnet:object-type state)) supplied-due-time (cl:numberp due-time) supplied-period (cl:numberp period))
     (dotnet:new <type-str> callback state due-time period))
    ((cl:and (cl:or (cl:null callback) (dotnet:object-type callback)) (cl:not supplied-state) (cl:not supplied-due-time) (cl:not supplied-period))
     (dotnet:new <type-str> callback))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-THREADING-TIMER"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:list :callback callback) (cl:when supplied-state (cl:list :state state)) (cl:when supplied-due-time (cl:list :due-time due-time)) (cl:when supplied-period (cl:list :period period)))))))

(cl:define-symbol-macro active-count (dotnet:static <type-str> "ActiveCount"))

(cl:defun change (obj! due-time period)
  "Master wrapper for System.Threading.Timer.Change overloads. Dispatches at runtime.

Change(Int32, Int32) -> Boolean

Change(TimeSpan, TimeSpan) -> Boolean

Change(UInt32, UInt32) -> Boolean

Change(Int64, Int64) -> Boolean
"
  (cl:cond
    ((cl:and (cl:numberp due-time) (cl:numberp period))
     (dotnet:invoke (cl:the (dotnet "System.Threading.Timer") obj!) "Change" due-time period))
    ((cl:and (cl:or (cl:null due-time) (dotnet:object-type due-time)) (cl:or (cl:null period) (dotnet:object-type period)))
     (dotnet:invoke (cl:the (dotnet "System.Threading.Timer") obj!) "Change" due-time period))
    ((cl:and (cl:or (cl:null due-time) (dotnet:object-type due-time)) (cl:or (cl:null period) (dotnet:object-type period)))
     (dotnet:invoke (cl:the (dotnet "System.Threading.Timer") obj!) "Change" due-time period))
    ((cl:and (cl:numberp due-time) (cl:numberp period))
     (dotnet:invoke (cl:the (dotnet "System.Threading.Timer") obj!) "Change" due-time period))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-THREADING-TIMER"
                    :class-name <type-str>
                    :method-name "Change"
                    :supplied-args (cl:append (cl:list :due-time due-time) (cl:list :period period))))))

(cl:defun dispose (obj! cl:&optional (notify-object cl:nil supplied-notify-object))
  "Master wrapper for System.Threading.Timer.Dispose overloads. Dispatches at runtime.

Dispose() -> Void

Dispose(WaitHandle) -> Boolean
"
  (cl:cond
    ((cl:and supplied-notify-object (cl:or (cl:null notify-object) (dotnet:object-type notify-object)))
     (dotnet:invoke (cl:the (dotnet "System.Threading.Timer") obj!) "Dispose" notify-object))
    ((cl:and (cl:not supplied-notify-object))
     (dotnet:invoke (cl:the (dotnet "System.Threading.Timer") obj!) "Dispose"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-THREADING-TIMER"
                    :class-name <type-str>
                    :method-name "Dispose"
                    :supplied-args (cl:append (cl:when supplied-notify-object (cl:list :notify-object notify-object)))))))

(cl:defun dispose-async (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Threading.Timer") obj!) "DisposeAsync"))

