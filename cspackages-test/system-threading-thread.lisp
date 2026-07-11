;;; Generated automatically. Do not edit.
;;; Class: System.Threading.Thread
;;; Generator Version: 42
;;; Creation Date: 2026-07-11T12:55:15Z

(cl:in-package :system-threading-thread)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Threading.Thread"))
(cl:defconstant <type-str> "System.Threading.Thread")
(cl:defconstant <creation> "2026-07-11T12:55:15Z")
(cl:defconstant <version> 42)

;; Register C# Type with CLOS
(cl:eval-when (:load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Threading.Thread")))

(cl:defun new (start cl:&optional (max-stack-size cl:nil supplied-max-stack-size))
  "Master wrapper for System.Threading.Thread constructor overloads. Dispatches at runtime.

new(ThreadStart)
  Summary: Initializes a new instance of the System.Threading.Thread class.
  Parameters:
    - start (System.Threading.ThreadStart): A System.Threading.ThreadStart delegate that represents the methods to be invoked when this thread begins executing.

new(ParameterizedThreadStart)
  Summary: Initializes a new instance of the System.Threading.Thread class, specifying a delegate that allows an object to be passed to the thread when the thread is started.
  Parameters:
    - start (System.Threading.ParameterizedThreadStart): A delegate that represents the methods to be invoked when this thread begins executing.

new(ThreadStart, Int32)
  Summary: Initializes a new instance of the System.Threading.Thread class, specifying the maximum stack size for the thread.
  Parameters:
    - start (System.Threading.ThreadStart): A System.Threading.ThreadStart delegate that represents the methods to be invoked when this thread begins executing.
    - max-stack-size (System.Int32): The maximum stack size, in bytes, to be used by the thread, or 0 to use the default maximum stack size specified in the header for the executable. Important For partially trusted code, maxStackSize is ignored if it is greater than the default stack size. No exception is thrown.

new(ParameterizedThreadStart, Int32)
  Summary: Initializes a new instance of the System.Threading.Thread class, specifying a delegate that allows an object to be passed to the thread when the thread is started and specifying the maximum stack size for the thread.
  Parameters:
    - start (System.Threading.ParameterizedThreadStart): A System.Threading.ParameterizedThreadStart delegate that represents the methods to be invoked when this thread begins executing.
    - max-stack-size (System.Int32): The maximum stack size, in bytes, to be used by the thread, or 0 to use the default maximum stack size specified in the header for the executable. Important For partially trusted code, maxStackSize is ignored if it is greater than the default stack size. No exception is thrown.
"
  (cl:cond
    ((cl:and (cl:or (cl:null start) (dotnet:object-type start)) supplied-max-stack-size (cl:numberp max-stack-size))
     (dotnet:new <type-str> start max-stack-size))
    ((cl:and (cl:or (cl:null start) (dotnet:object-type start)) supplied-max-stack-size (cl:numberp max-stack-size))
     (dotnet:new <type-str> start max-stack-size))
    ((cl:and (cl:or (cl:null start) (dotnet:object-type start)) (cl:not supplied-max-stack-size))
     (dotnet:new <type-str> start))
    ((cl:and (cl:or (cl:null start) (dotnet:object-type start)) (cl:not supplied-max-stack-size))
     (dotnet:new <type-str> start))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-THREADING-THREAD"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:list :start start) (cl:when supplied-max-stack-size (cl:list :max-stack-size max-stack-size)))))))

(cl:define-symbol-macro current-thread (dotnet:static <type-str> "CurrentThread"))
(cl:setf (cl:documentation (cl:quote current-thread) (cl:quote cl:variable)) "Gets the currently running thread.")

(cl:defun current-principal ()
  "Gets or sets the thread's current principal (for role-based security)."
  (dotnet:static <type-str> "CurrentPrincipal"))

(cl:defun (cl:setf current-principal) (new-value)
  "Gets or sets the thread's current principal (for role-based security)."
  (cl:setf (dotnet:static <type-str> "CurrentPrincipal") new-value))

(cl:defun apartment-state (obj!)
  "Gets or sets the apartment state of this thread."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "get_ApartmentState"))

(cl:defun (cl:setf apartment-state) (new-value obj!)
  "Gets or sets the apartment state of this thread."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "set_ApartmentState" new-value))

(cl:defun current-culture (obj!)
  "Gets or sets the culture for the current thread."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "get_CurrentCulture"))

(cl:defun (cl:setf current-culture) (new-value obj!)
  "Gets or sets the culture for the current thread."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "set_CurrentCulture" new-value))

(cl:defun current-ui-culture (obj!)
  "Gets or sets the current culture used by the Resource Manager to look up culture-specific resources at run time."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "get_CurrentUICulture"))

(cl:defun (cl:setf current-ui-culture) (new-value obj!)
  "Gets or sets the current culture used by the Resource Manager to look up culture-specific resources at run time."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "set_CurrentUICulture" new-value))

(cl:defun execution-context (obj!)
  "Gets an System.Threading.ExecutionContext object that contains information about the various contexts of the current thread."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "get_ExecutionContext"))

(cl:defun alive? (obj!)
  "Gets a value indicating the execution status of the current thread."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "get_IsAlive"))

(cl:defun background? (obj!)
  "Gets or sets a value indicating whether or not a thread is a background thread."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "get_IsBackground"))

(cl:defun (cl:setf background?) (new-value obj!)
  "Gets or sets a value indicating whether or not a thread is a background thread."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "set_IsBackground" new-value))

(cl:defun thread-pool-thread? (obj!)
  "Gets a value indicating whether or not a thread belongs to the managed thread pool."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "get_IsThreadPoolThread"))

(cl:defun managed-thread-id (obj!)
  "Gets a unique identifier for the current managed thread."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "get_ManagedThreadId"))

(cl:defun name (obj!)
  "Gets or sets the name of the thread."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "get_Name"))

(cl:defun (cl:setf name) (new-value obj!)
  "Gets or sets the name of the thread."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "set_Name" new-value))

(cl:defun priority (obj!)
  "Gets or sets a value indicating the scheduling priority of a thread."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "get_Priority"))

(cl:defun (cl:setf priority) (new-value obj!)
  "Gets or sets a value indicating the scheduling priority of a thread."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "set_Priority" new-value))

(cl:defun thread-state (obj!)
  "Gets a value containing the states of the current thread."
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "get_ThreadState"))

(cl:defun abort (obj! cl:&optional (state-info cl:nil supplied-state-info))
  "Master wrapper for System.Threading.Thread.Abort overloads. Dispatches at runtime.

Abort() -> Void
  Summary: Raises a System.Threading.ThreadAbortException in the thread on which it is invoked, to begin the process of terminating the thread. Calling this method usually terminates the thread.

Abort(Object) -> Void
  Summary: Raises a System.Threading.ThreadAbortException in the thread on which it is invoked, to begin the process of terminating the thread while also providing exception information about the thread termination. Calling this method usually terminates the thread.
  Parameters:
    - state-info (System.Object): An object that contains application-specific information, such as state, which can be used by the thread being aborted.
"
  (cl:cond
    ((cl:and supplied-state-info (cl:or (cl:null state-info) (dotnet:object-type state-info)))
     (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "Abort" state-info))
    ((cl:and (cl:not supplied-state-info))
     (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "Abort"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-THREADING-THREAD"
                    :class-name <type-str>
                    :method-name "Abort"
                    :supplied-args (cl:append (cl:when supplied-state-info (cl:list :state-info state-info)))))))

(cl:defun allocate-data-slot ()
  "Summary: Allocates an unnamed data slot on all the threads. For better performance, use fields that are marked with the System.ThreadStaticAttribute attribute instead.
Returns: The allocated named data slot on all threads.
"
  (dotnet:static <type-str> "AllocateDataSlot"))

(cl:defun allocate-named-data-slot (name)
  "Summary: Allocates a named data slot on all threads. For better performance, use fields that are marked with the System.ThreadStaticAttribute attribute instead.
Returns: The allocated named data slot on all threads.
Parameters:
  - name (System.String): The name of the data slot to be allocated.
"
  (dotnet:static <type-str> "AllocateNamedDataSlot" (cl:the (dotnet "System.String") name)))

(cl:defun begin-critical-region ()
  "Summary: Notifies a host that execution is about to enter a region of code in which the effects of a thread abort or unhandled exception might jeopardize other tasks in the application domain.
"
  (dotnet:static <type-str> "BeginCriticalRegion"))

(cl:defun begin-thread-affinity ()
  "Summary: Notifies a host that managed code is about to execute instructions that depend on the identity of the current physical operating system thread.
"
  (dotnet:static <type-str> "BeginThreadAffinity"))

(cl:defun disable-com-object-eager-cleanup (obj!)
  "Summary: Turns off automatic cleanup of runtime callable wrappers (RCW) for the current thread.
"
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "DisableComObjectEagerCleanup"))

(cl:defun end-critical-region ()
  "Summary: Notifies a host that execution is about to enter a region of code in which the effects of a thread abort or unhandled exception are limited to the current task.
"
  (dotnet:static <type-str> "EndCriticalRegion"))

(cl:defun end-thread-affinity ()
  "Summary: Notifies a host that managed code has finished executing instructions that depend on the identity of the current physical operating system thread.
"
  (dotnet:static <type-str> "EndThreadAffinity"))

(cl:defun finalize (obj!)
  "Summary: Ensures that resources are freed and other cleanup operations are performed when the garbage collector reclaims the System.Threading.Thread object.
"
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "Finalize"))

(cl:defun free-named-data-slot (name)
  "Summary: Eliminates the association between a name and a slot, for all threads in the process. For better performance, use fields that are marked with the System.ThreadStaticAttribute attribute instead.
Parameters:
  - name (System.String): The name of the data slot to be freed.
"
  (dotnet:static <type-str> "FreeNamedDataSlot" (cl:the (dotnet "System.String") name)))

(cl:defun get-apartment-state (obj!)
  "Summary: Returns an System.Threading.ApartmentState value indicating the apartment state.
Returns: One of the System.Threading.ApartmentState values indicating the apartment state of the managed thread. The default is System.Threading.ApartmentState.Unknown.
"
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "GetApartmentState"))

(cl:defun get-compressed-stack (obj!)
  "Summary: Returns a System.Threading.CompressedStack object that can be used to capture the stack for the current thread.
"
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "GetCompressedStack"))

(cl:defun get-current-processor-id ()
  "Summary: Gets an ID used to indicate on which processor the current thread is executing.
Returns: An integer representing the cached processor ID.
"
  (dotnet:static <type-str> "GetCurrentProcessorId"))

(cl:defun get-data (slot)
  "Summary: Retrieves the value from the specified slot on the current thread, within the current thread's current domain. For better performance, use fields that are marked with the System.ThreadStaticAttribute attribute instead.
Returns: The retrieved value.
Parameters:
  - slot (System.LocalDataStoreSlot): The System.LocalDataStoreSlot from which to get the value.
"
  (dotnet:static <type-str> "GetData" (cl:the (dotnet "System.LocalDataStoreSlot") slot)))

(cl:defun get-domain ()
  "Summary: Returns the current domain in which the current thread is running.
Returns: An System.AppDomain representing the current application domain of the running thread.
"
  (dotnet:static <type-str> "GetDomain"))

(cl:defun get-domain-id ()
  "Summary: Returns a unique application domain identifier.
Returns: A 32-bit signed integer uniquely identifying the application domain.
"
  (dotnet:static <type-str> "GetDomainID"))

(cl:defun get-hash-code (obj!)
  "Summary: Returns a hash code for the current thread.
Returns: An integer hash code value.
"
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "GetHashCode"))

(cl:defun get-named-data-slot (name)
  "Summary: Looks up a named data slot. For better performance, use fields that are marked with the System.ThreadStaticAttribute attribute instead.
Returns: A System.LocalDataStoreSlot allocated for this thread.
Parameters:
  - name (System.String): The name of the local data slot.
"
  (dotnet:static <type-str> "GetNamedDataSlot" (cl:the (dotnet "System.String") name)))

(cl:defun interrupt (obj!)
  "Summary: Interrupts a thread that is in the System.Threading.ThreadState.WaitSleepJoin thread state.
"
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "Interrupt"))

(cl:defun join (obj! cl:&optional (milliseconds-timeout cl:nil supplied-milliseconds-timeout))
  "Master wrapper for System.Threading.Thread.Join overloads. Dispatches at runtime.

Join() -> Void
  Summary: Blocks the calling thread until the thread represented by this instance terminates, while continuing to perform standard COM and pumping.

Join(Int32) -> Boolean
  Summary: Blocks the calling thread until the thread represented by this instance terminates or the specified time elapses, while continuing to perform standard COM and SendMessage pumping.
  Returns: if the thread has terminated; if the thread has not terminated after the amount of time specified by the millisecondsTimeout parameter has elapsed.
  Parameters:
    - milliseconds-timeout (System.Int32): The number of milliseconds to wait for the thread to terminate.

Join(TimeSpan) -> Boolean
  Summary: Blocks the calling thread until the thread represented by this instance terminates or the specified time elapses, while continuing to perform standard COM and SendMessage pumping.
  Returns: if the thread terminated; if the thread has not terminated after the amount of time specified by the timeout parameter has elapsed.
  Parameters:
    - timeout (System.TimeSpan): A System.TimeSpan set to the amount of time to wait for the thread to terminate.
"
  (cl:cond
    ((cl:and supplied-milliseconds-timeout (cl:numberp milliseconds-timeout))
     (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "Join" milliseconds-timeout))
    ((cl:and supplied-milliseconds-timeout (cl:or (cl:null milliseconds-timeout) (dotnet:object-type milliseconds-timeout)))
     (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "Join" milliseconds-timeout))
    ((cl:and (cl:not supplied-milliseconds-timeout))
     (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "Join"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-THREADING-THREAD"
                    :class-name <type-str>
                    :method-name "Join"
                    :supplied-args (cl:append (cl:when supplied-milliseconds-timeout (cl:list :milliseconds-timeout milliseconds-timeout)))))))

(cl:defun memory-barrier ()
  "Summary: Synchronizes memory access as follows: The processor executing the current thread cannot reorder instructions in such a way that memory accesses prior to the call to System.Threading.Thread.MemoryBarrier execute after memory accesses that follow the call to System.Threading.Thread.MemoryBarrier.
"
  (dotnet:static <type-str> "MemoryBarrier"))

(cl:defun reset-abort ()
  "Summary: Cancels an System.Threading.Thread.Abort(System.Object) requested for the current thread.
"
  (dotnet:static <type-str> "ResetAbort"))

(cl:defun resume (obj!)
  "Summary: Resumes a thread that has been suspended.
"
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "Resume"))

(cl:defun set-apartment-state (obj! state)
  "Summary: Sets the apartment state of a thread before it is started.
Parameters:
  - state (System.Threading.ApartmentState): The new apartment state.
"
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "SetApartmentState" state))

(cl:defun set-compressed-stack (obj! stack)
  "Summary: Applies a captured System.Threading.CompressedStack to the current thread.
Parameters:
  - stack (System.Threading.CompressedStack): The System.Threading.CompressedStack object to be applied to the current thread.
"
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "SetCompressedStack" stack))

(cl:defun set-data (slot data)
  "Summary: Sets the data in the specified slot on the currently running thread, for that thread's current domain. For better performance, use fields marked with the System.ThreadStaticAttribute attribute instead.
Parameters:
  - slot (System.LocalDataStoreSlot): The System.LocalDataStoreSlot in which to set the value.
  - data (System.Object): The value to be set.
"
  (dotnet:static <type-str> "SetData" (cl:the (dotnet "System.LocalDataStoreSlot") slot) (cl:the (dotnet "System.Object") data)))

(cl:defun sleep (milliseconds-timeout)
  "Master wrapper for System.Threading.Thread.Sleep overloads. Dispatches at runtime.

Sleep(Int32) -> Void
  Summary: Suspends the current thread for the specified number of milliseconds.
  Parameters:
    - milliseconds-timeout (System.Int32): The number of milliseconds for which the thread is suspended. If the value of the millisecondsTimeout argument is zero, the thread relinquishes the remainder of its time slice to any thread of equal priority that is ready to run. If there are no other threads of equal priority that are ready to run, execution of the current thread is not suspended.

Sleep(TimeSpan) -> Void
  Summary: Suspends the current thread for the specified amount of time.
  Parameters:
    - timeout (System.TimeSpan): The amount of time for which the thread is suspended. If the value of the timeout argument is System.TimeSpan.Zero, the thread relinquishes the remainder of its time slice to any thread of equal priority that is ready to run. If there are no other threads of equal priority that are ready to run, execution of the current thread is not suspended.
"
  (cl:cond
    ((cl:and (cl:numberp milliseconds-timeout))
     (dotnet:static <type-str> "Sleep" milliseconds-timeout))
    ((cl:and (cl:or (cl:null milliseconds-timeout) (dotnet:object-type milliseconds-timeout)))
     (dotnet:static <type-str> "Sleep" milliseconds-timeout))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-THREADING-THREAD"
                    :class-name <type-str>
                    :method-name "Sleep"
                    :supplied-args (cl:append (cl:list :milliseconds-timeout milliseconds-timeout))))))

(cl:defun spin-wait (iterations)
  "Summary: Causes a thread to wait the number of times defined by the iterations parameter.
Parameters:
  - iterations (System.Int32): A 32-bit signed integer that defines how long a thread is to wait.
"
  (dotnet:static <type-str> "SpinWait" (cl:the (dotnet "System.Int32") iterations)))

(cl:defun start (obj! cl:&optional (parameter cl:nil supplied-parameter))
  "Master wrapper for System.Threading.Thread.Start overloads. Dispatches at runtime.

Start() -> Void
  Summary: Causes the operating system to change the state of the current instance to System.Threading.ThreadState.Running.

Start(Object) -> Void
  Summary: Causes the operating system to change the state of the current instance to System.Threading.ThreadState.Running, and optionally supplies an object containing data to be used by the method the thread executes.
  Parameters:
    - parameter (System.Object): An object that contains data to be used by the method the thread executes.
"
  (cl:cond
    ((cl:and supplied-parameter (cl:or (cl:null parameter) (dotnet:object-type parameter)))
     (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "Start" parameter))
    ((cl:and (cl:not supplied-parameter))
     (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "Start"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-THREADING-THREAD"
                    :class-name <type-str>
                    :method-name "Start"
                    :supplied-args (cl:append (cl:when supplied-parameter (cl:list :parameter parameter)))))))

(cl:defun suspend (obj!)
  "Summary: Either suspends the thread, or if the thread is already suspended, has no effect.
"
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "Suspend"))

(cl:defun try-set-apartment-state (obj! state)
  "Summary: Sets the apartment state of a thread before it is started.
Returns: if the apartment state is set; otherwise, .
Parameters:
  - state (System.Threading.ApartmentState): The new apartment state.
"
  (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "TrySetApartmentState" state))

(cl:defun unsafe-start (obj! cl:&optional (parameter cl:nil supplied-parameter))
  "Master wrapper for System.Threading.Thread.UnsafeStart overloads. Dispatches at runtime.

UnsafeStart() -> Void
  Summary: Causes the operating system to change the state of the current instance to System.Threading.ThreadState.Running.

UnsafeStart(Object) -> Void
  Summary: Causes the operating system to change the state of the current instance to System.Threading.ThreadState.Running, and optionally supplies an object containing data to be used by the method the thread executes.
  Parameters:
    - parameter (System.Object): An object that contains data to be used by the method the thread executes.
"
  (cl:cond
    ((cl:and supplied-parameter (cl:or (cl:null parameter) (dotnet:object-type parameter)))
     (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "UnsafeStart" parameter))
    ((cl:and (cl:not supplied-parameter))
     (dotnet:invoke (cl:the (dotnet "System.Threading.Thread") obj!) "UnsafeStart"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-THREADING-THREAD"
                    :class-name <type-str>
                    :method-name "UnsafeStart"
                    :supplied-args (cl:append (cl:when supplied-parameter (cl:list :parameter parameter)))))))

;; The following C# System.Threading.Thread.VolatileRead overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   VolatileRead(ref Byte&) -> Byte
;;   VolatileRead(ref Double&) -> Double
;;   VolatileRead(ref Int16&) -> Int16
;;   VolatileRead(ref Int32&) -> Int32
;;   VolatileRead(ref Int64&) -> Int64
;;   VolatileRead(ref IntPtr&) -> IntPtr
;;   VolatileRead(ref Object&) -> Object
;;   VolatileRead(ref SByte&) -> SByte
;;   VolatileRead(ref Single&) -> Single
;;   VolatileRead(ref UInt16&) -> UInt16
;;   VolatileRead(ref UInt32&) -> UInt32
;;   VolatileRead(ref UInt64&) -> UInt64
;;   VolatileRead(ref UIntPtr&) -> UIntPtr

;; The following C# System.Threading.Thread.VolatileWrite overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   VolatileWrite(ref Byte&, Byte) -> Void
;;   VolatileWrite(ref Double&, Double) -> Void
;;   VolatileWrite(ref Int16&, Int16) -> Void
;;   VolatileWrite(ref Int32&, Int32) -> Void
;;   VolatileWrite(ref Int64&, Int64) -> Void
;;   VolatileWrite(ref IntPtr&, IntPtr) -> Void
;;   VolatileWrite(ref Object&, Object) -> Void
;;   VolatileWrite(ref SByte&, SByte) -> Void
;;   VolatileWrite(ref Single&, Single) -> Void
;;   VolatileWrite(ref UInt16&, UInt16) -> Void
;;   VolatileWrite(ref UInt32&, UInt32) -> Void
;;   VolatileWrite(ref UInt64&, UInt64) -> Void
;;   VolatileWrite(ref UIntPtr&, UIntPtr) -> Void

(cl:defun yield ()
  "Summary: Causes the calling thread to yield execution to another thread that is ready to run on the current processor. The operating system selects the thread to yield to.
Returns: if the operating system switched execution to another thread; otherwise, .
"
  (dotnet:static <type-str> "Yield"))

