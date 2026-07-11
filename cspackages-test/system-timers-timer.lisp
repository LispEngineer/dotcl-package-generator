;;; Generated automatically. Do not edit.
;;; Class: System.Timers.Timer
;;; Generator Version: 41
;;; Creation Date: 2026-07-11T03:36:09Z

(cl:in-package :system-timers-timer)

(cl:defconstant <type> (dotnet:resolve-type "System.Timers.Timer"))
(cl:defconstant <type-str> "System.Timers.Timer")
(cl:defconstant <creation> "2026-07-11T03:36:09Z")
(cl:defconstant <version> 41)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Timers.Timer")))

(cl:defun new (cl:&optional (interval cl:nil supplied-interval))
  "Master wrapper for System.Timers.Timer constructor overloads. Dispatches at runtime.

new()
  Summary: Initializes a new instance of the System.Timers.Timer class, and sets all the properties to their initial values.

new(Double)
  Summary: Initializes a new instance of the System.Timers.Timer class, and sets the System.Timers.Timer.Interval property to the specified number of milliseconds.
  Parameters:
    - interval (System.Double): The time, in milliseconds, between events. The value must be greater than zero and less than or equal to System.Int32.MaxValue.

new(TimeSpan)
  Summary: Initializes a new instance of the System.Timers.Timer class, setting the System.Timers.Timer.Interval property to the specified period.
  Parameters:
    - interval (System.TimeSpan): The time between events. The value in milliseconds must be greater than zero and less than or equal to System.Int32.MaxValue.
"
  (cl:cond
    ((cl:and supplied-interval (cl:numberp interval))
     (dotnet:new <type-str> interval))
    ((cl:and supplied-interval (cl:or (cl:null interval) (dotnet:object-type interval)))
     (dotnet:new <type-str> interval))
    ((cl:and (cl:not supplied-interval))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIMERS-TIMER"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-interval (cl:list :interval interval)))))))

(cl:defun auto-reset (obj!)
  "Gets or sets a Boolean indicating whether the System.Timers.Timer should raise the System.Timers.Timer.Elapsed event only once () or repeatedly ()."
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "get_AutoReset"))

(cl:defun (cl:setf auto-reset) (new-value obj!)
  "Gets or sets a Boolean indicating whether the System.Timers.Timer should raise the System.Timers.Timer.Elapsed event only once () or repeatedly ()."
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "set_AutoReset" new-value))

(cl:defun enabled (obj!)
  "Gets or sets a value indicating whether the System.Timers.Timer should raise the System.Timers.Timer.Elapsed event."
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "get_Enabled"))

(cl:defun (cl:setf enabled) (new-value obj!)
  "Gets or sets a value indicating whether the System.Timers.Timer should raise the System.Timers.Timer.Elapsed event."
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "set_Enabled" new-value))

(cl:defun interval (obj!)
  "Gets or sets the interval, expressed in milliseconds, at which to raise the System.Timers.Timer.Elapsed event."
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "get_Interval"))

(cl:defun (cl:setf interval) (new-value obj!)
  "Gets or sets the interval, expressed in milliseconds, at which to raise the System.Timers.Timer.Elapsed event."
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "set_Interval" new-value))

(cl:defun site (obj!)
  "Gets or sets the site that binds the System.Timers.Timer to its container in design mode."
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "get_Site"))

(cl:defun (cl:setf site) (new-value obj!)
  "Gets or sets the site that binds the System.Timers.Timer to its container in design mode."
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "set_Site" new-value))

(cl:defun synchronizing-object (obj!)
  "Gets or sets the object used to marshal event-handler calls that are issued when an interval has elapsed."
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "get_SynchronizingObject"))

(cl:defun (cl:setf synchronizing-object) (new-value obj!)
  "Gets or sets the object used to marshal event-handler calls that are issued when an interval has elapsed."
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "set_SynchronizingObject" new-value))

(cl:defun add-elapsed (obj! handler)
  "Occurs when the interval elapses."
  (dotnet:add-event (cl:the (dotnet "System.Timers.Timer") obj!) "Elapsed" handler))

(cl:defun remove-elapsed (obj! handler)
  "Pass the exact same HANDLER object given to add-elapsed -- removal is by identity, not by behavioral equivalence."
  (dotnet:remove-event (cl:the (dotnet "System.Timers.Timer") obj!) "Elapsed" handler))

(cl:defun begin-init (obj!)
  "Summary: Begins the run-time initialization of a System.Timers.Timer that is used on a form or by another component.
"
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "BeginInit"))

(cl:defun close (obj!)
  "Summary: Releases the resources used by the System.Timers.Timer.
"
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "Close"))

(cl:defun dispose (obj! disposing)
  "Summary: Releases all resources used by the current System.Timers.Timer.
Parameters:
  - disposing (System.Boolean): to release both managed and unmanaged resources; to release only unmanaged resources.
"
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "Dispose" disposing))

(cl:defun end-init (obj!)
  "Summary: Ends the run-time initialization of a System.Timers.Timer that is used on a form or by another component.
"
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "EndInit"))

(cl:defun start (obj!)
  "Summary: Starts raising the System.Timers.Timer.Elapsed event by setting System.Timers.Timer.Enabled to .
"
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "Start"))

(cl:defun stop (obj!)
  "Summary: Stops raising the System.Timers.Timer.Elapsed event by setting System.Timers.Timer.Enabled to .
"
  (dotnet:invoke (cl:the (dotnet "System.Timers.Timer") obj!) "Stop"))

