# Package Documentation for `dotnet`

This document provides detailed documentation for the symbols exported by the `DOTNET` package in the DotCL Common Lisp environment. These functions provide the core interop capabilities between Common Lisp and the .NET Common Language Runtime (CLR), as well as low-level native Foreign Function Interface (FFI) memory and function calling capabilities.

All symbols in the `DOTNET` package are registered at runtime by the C# engine (specifically in `Startup.cs`) and backed by static methods in the `DotCL.Runtime`, `DotCL.DotNetEvents`, `DotCL.DotNetNuGet`, and `DotCL.DotNetWinForms` classes.

---

## Index of Symbols (Grouped by Purpose)

### Assembly & Package Management
* [`DOTNET:LOAD-ASSEMBLY`](#dotnetload-assembly)
* [`DOTNET:REQUIRE`](#dotnetrequire)

### Object Creation & Class Definition
* [`DOTNET:NEW`](#dotnetnew)
* [`DOTNET:MAKE-ARRAY`](#dotnetmake-array)
* [`DOTNET:NEW-ARRAY`](#dotnetnew-array)
* [`DOTNET:MAKE-GENERIC-TYPE`](#dotnetmake-generic-type)
* [`DOTNET:%DEFINE-CLASS`](#dotnetdefine-class)

### Member Invocation & Property Access
* [`DOTNET:INVOKE`](#dotnetinvoke)
* [`DOTNET:INVOKE-GENERIC`](#dotnetinvoke-generic)
* [`DOTNET:%SET-INVOKE`](#dotnetset-invoke)
* [`DOTNET:STATIC`](#dotnetstatic)
* [`DOTNET:%SET-STATIC`](#dotnetset-static)
* [`DOTNET:CALL-BASE`](#dotnetcall-base)
* [`DOTNET:CALL-OUT`](#dotnetcall-out)
* [`DOTNET:CALL-OUT-GENERIC`](#dotnetcall-out-generic)
* [`DOTNET:STATIC-GENERIC`](#dotnetstatic-generic)
* [`DOTNET:BOX`](#dotnetbox)
* [`DOTNET:HINT-TYPE`](#dotnethint-type)
* [`DOTNET:OBJECT-TYPE`](#dotnetobject-type)
* [`DOTNET:RESOLVE-TYPE`](#dotnetresolve-type)
* [`DOTNET:IS-INSTANCE-OF`](#dotnetis-instance-of)
* [`DOTNET:CAST`](#dotnetcast)
* [`DOTNET:NULL`](#dotnetnull)
* [`DOTNET:AWAIT`](#dotnetawait)
* [`DOTNET:ENUM-OR`](#dotnetenum-or)

### Event Handling & Delegates
* [`DOTNET:ADD-EVENT`](#dotnetadd-event)
* [`DOTNET:REMOVE-EVENT`](#dotnetremove-event)
* [`DOTNET:MAKE-DELEGATE`](#dotnetmake-delegate)

### Exception Handling
* [`DOTNET:HANDLER-BIND`](#dotnethandler-bind)
* [`DOTNET:EXCEPTION-TYPEP`](#dotnetexception-typep)
* [`DOTNET:EXCEPTION-TYPE`](#dotnetexception-type)

### Stream Wrapping
* [`DOTNET:TO-STREAM`](#dotnetto-stream)

### Unmanaged Memory & Native FFI
* [`DOTNET:%FFI-CALL`](#dotnetffi-call)
* [`DOTNET:%FFI-CALL-PTR`](#dotnetffi-call-ptr)
* [`DOTNET:FFI`](#dotnetffi)
* [`DOTNET:ALLOC-MEM`](#dotnetalloc-mem)
* [`DOTNET:FREE-MEM`](#dotnetfree-mem)
* [`DOTNET:MEM-READ`](#dotnetmem-read)
* [`DOTNET:MEM-WRITE`](#dotnetmem-write)
* [`DOTNET:TYPE-SIZE`](#dotnettype-size)
* [`DOTNET:TYPE-ALIGN`](#dotnettype-align)
* [`DOTNET:LOAD-LIBRARY`](#dotnetload-library)
* [`DOTNET:FREE-LIBRARY`](#dotnetfree-library)
* [`DOTNET:FIND-SYMBOL`](#dotnetfind-symbol)
* [`DOTNET:FIND-SYMBOL-ANY`](#dotnetfind-symbol-any)
* [`DOTNET:LIBRARY-PATH`](#dotnetlibrary-path)

---

### `DOTNET:%DEFINE-CLASS`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:%define-class full-name &optional base-type-name field-specs attr-specs method-specs ctor-body property-specs interface-specs event-specs ctor-param-types base-ctor-arg-indices)
  ```
* **Description:** Emits a named public .NET class at runtime using dynamic IL generation. This allows Lisp code to subclass existing non-sealed .NET classes, implement interfaces, add custom fields, properties, events, and define Lisp closures as method handlers.
* **Parameters:**
  * `full-name` (String): The fully-qualified name of the class to emit (e.g. `"MyNamespace.MyClass"`).
  * `base-type-name` (String, optional): The fully-qualified name of the base class. Defaults to `"System.Object"`. Must not be a sealed type.
  * `field-specs` (List, optional): List of field specifications of the format `("FieldName" "TypeName")`.
  * `attr-specs` (List, optional): List of custom attribute specifications of the format `("AttributeTypeName" ctor-arguments...)` to apply to the class.
  * `method-specs` (List, optional): List of method specifications of the format `("MethodName" "ReturnTypeName" ("ParamTypeName"...) lisp-function &optional override-flag)`. If `override-flag` is true, the method is emitted as an override of a virtual method in the base class.
  * `ctor-body` (Function, optional): A 1-argument Lisp function called with the instance (`self`) after the base class constructor executes.
  * `property-specs` (List, optional): List of properties of the format `("PropertyName" "TypeName" &optional notify-flag)`. If `notify-flag` is true, setter calls `OnPropertyChanged` (requires a PropertyChanged event).
  * `interface-specs` (List, optional): List of fully qualified interface type names implemented by the class.
  * `event-specs` (List, optional): List of event definitions of the format `("EventName" "DelegateTypeName")`.
  * `ctor-param-types` (List, optional): List of type name strings for custom constructor parameters.
  * `base-ctor-arg-indices` (List, optional): Indices of parameters passed to the base class constructor.
* **Implementation Details:** Under the hood, this calls `Runtime.DotNetDefineClass` in `Runtime.DotNet.cs`. It uses `System.Reflection.Emit` to build a dynamic assembly, module, and type. It builds constructors, fields, properties, events, and overrides. Lisp closures are wrapped and registered to be dispatched dynamically when the .NET methods are invoked.
* **Usage Example:**
  ```lisp
  ;; Define a custom subclass of System.Object with a Greet method and a value field
  (dotnet:%define-class "DotclTest.CustomGreeter"
                        "System.Object"
                        '(("Value" "System.Int32"))
                        nil
                        '(("Greet" "System.String" nil
                           (lambda (self)
                             (declare (ignore self))
                             "Hello from dynamic class!"))))
  ```

---

### `DOTNET:%FFI-CALL`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:%ffi-call dll func arg-types ret-type &rest args)
  ```
* **Description:** Low-level native Foreign Function Interface (FFI) call. Directly invokes a function exported from a native shared library using standard platform calling conventions.
* **Parameters:**
  * `dll` (String): The path or name of the native shared library (`.so`, `.dll`, or `.dylib`).
  * `func` (String): The name of the exported native function.
  * `arg-types` (List): A list of keywords representing the parameter types (e.g., `(:int :pointer :float :double)`).
  * `ret-type` (Keyword): The return type of the function, or `nil`/`:void`.
  * `args` (Rest): The arguments to pass to the native function.
* **Implementation Details:** Backed by `Runtime.FfiCall` in `Runtime.FFI.cs`. It uses `NativeLibrary.Load` to load the library and `NativeLibrary.GetExport` to locate the symbol address. It compiles a `DynamicMethod` utilizing `OpCodes.Calli` with `CallingConvention.StdCall` to invoke the raw pointer, and caches the emitted method by signature to optimize future calls.
* **Usage Example:**
  ```lisp
  ;; Call the standard puts function from libc to write to stdout
  (let ((msg (dotnet:alloc-mem 10)))
    ;; write string bytes or read it...
    (dotnet:%ffi-call "libc" "puts" '(:pointer) :int msg)
    (dotnet:free-mem msg))
  ```

---

### `DOTNET:%FFI-CALL-PTR`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:%ffi-call-ptr func-ptr arg-types ret-type &rest args)
  ```
* **Description:** Invokes a native function pointer address directly without needing to resolve a library handle or symbol name at invocation time.
* **Parameters:**
  * `func-ptr` (Integer): The memory address of the target native function.
  * `arg-types` (List): List of keywords representing parameter types.
  * `ret-type` (Keyword): Return type keyword or `nil`/`:void`.
  * `args` (Rest): The argument values to pass.
* **Implementation Details:** Backed by `Runtime.FfiCallPtr` in `Runtime.Memory.cs` and `NativeFFI.CallPtr` in `Runtime.FFI.cs`. It bypasses library resolution and dynamically emits a `Calli` instruction passing the provided function pointer address as the target, caching the emitted delegate type for performance.
* **Usage Example:**
  ```lisp
  (let* ((libc (dotnet:load-library "libc"))
         (puts-ptr (dotnet:find-symbol "puts" libc)))
    (when puts-ptr
      (dotnet:%ffi-call-ptr puts-ptr '(:pointer) :int (dotnet:alloc-mem 6))))
  ```

---

### `DOTNET:%SET-INVOKE`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:%set-invoke object member-name &rest indexer-args value)
  ```
* **Description:** Mutator function that assigns a value to an instance property, field, or indexer on a .NET object. Idiomatically, you should use `(setf (dotnet:invoke object member-name &rest indexer-args) value)` instead, which macro-expands into this function.
* **Parameters:**
  * `object` (LispDotNetObject): The target .NET object wrapper.
  * `member-name` (String): The name of the property, field, or indexer to set.
  * `indexer-args` (Rest): Optional arguments preceding the value, used for indexers.
  * `value` (Object): The value to assign (always the last argument in the call).
* **Implementation Details:** Backed by `Runtime.DotNetSetInvoke` in `Runtime.DotNet.cs`. It converts Lisp arguments to .NET types using generic conversions and executes `Type.InvokeMember` using `BindingFlags.SetProperty | BindingFlags.SetField | BindingFlags.Instance | BindingFlags.Public`.
* **Usage Example:**
  ```lisp
  (let ((sb (dotnet:new "System.Text.StringBuilder" "Hello")))
    ;; Set the Length property to truncate the string using idiomatic setf
    (setf (dotnet:invoke sb "Length") 3)
    ;; Which expands to: (dotnet:%set-invoke sb "Length" 3)
    (dotnet:invoke sb "ToString")) ; Returns "Hel"
  ```

---

### `DOTNET:%SET-STATIC`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:%set-static type-name member-name &rest indexer-args value)
  ```
* **Description:** Mutator function that assigns a value to a static property or field on a .NET type. Idiomatically, you should use `(setf (dotnet:static type-name member-name &rest indexer-args) value)` instead, which macro-expands into this function.
* **Parameters:**
  * `type-name` (String): The fully-qualified name of the .NET type.
  * `member-name` (String): The name of the static property or field to set.
  * `indexer-args` (Rest): Optional arguments preceding the value, used for static indexers.
  * `value` (Object): The value to assign (always the last argument).
* **Implementation Details:** Backed by `Runtime.DotNetSetStatic` in `Runtime.DotNet.cs`. It resolves the type using `Type.GetType` or searching loaded assemblies, converts the arguments, and calls `Type.InvokeMember` using `BindingFlags.SetProperty | BindingFlags.SetField | BindingFlags.Static | BindingFlags.Public`.
* **Usage Example:**
  ```lisp
  ;; Set the title of the current console window using idiomatic setf
  (setf (dotnet:static "System.Console" "Title") "My DotCL Game")
  ;; Which expands to: (dotnet:%set-static "System.Console" "Title" "My DotCL Game")
  ```

---

### `DOTNET:ADD-EVENT`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:add-event object event-name handler)
  ```
* **Description:** Registers a Common Lisp function as a callback handler for a .NET object's event.
* **Parameters:**
  * `object` (LispDotNetObject): The target .NET object instance.
  * `event-name` (String): The name of the event (e.g. `"Click"`).
  * `handler` (Function): A Lisp lambda or function to execute when the event fires.
* **Implementation Details:** Backed by `DotNetEvents.AddEvent` in `Runtime.Events.cs`. It queries the event's delegate type via `GetEvent`, dynamically compiles a wrapping .NET `Delegate` using `Expression.Lambda` (which routes arguments via `DotNetEvents.DispatchEvent` into the Lisp function), and registers it via the event's add method. The delegate is stored in a weak-keyed `ConditionalWeakTable` using the Lisp handler as the key so it is cached for later detachment and can be garbage collected when the handler is no longer referenced.
* **Usage Example:**
  ```lisp
  (let ((btn (dotnet:new "System.Windows.Forms.Button")))
    (dotnet:add-event btn "Click"
      (lambda (sender e)
        (declare (ignore sender e))
        (format t "Button was clicked!~%"))))
  ```

---

### `DOTNET:ALLOC-MEM`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:alloc-mem size)
  ```
* **Description:** Allocates a block of unmanaged native memory outside the garbage-collected .NET heap.
* **Parameters:**
  * `size` (Integer): The size of the memory block in bytes.
* **Returns:** An integer representing the raw memory address (pointer) to the allocated block.
* **Implementation Details:** Backed by `Runtime.AllocMem` in `Runtime.Memory.cs`. It calls `Marshal.AllocHGlobal(size)` to allocate heap memory, returning the resulting pointer's address as a `Fixnum`.
* **Usage Example:**
  ```lisp
  (let ((ptr (dotnet:alloc-mem 64)))
    ;; Use the pointer address for native FFI operations...
    (dotnet:free-mem ptr))
  ```

---

### `DOTNET:BOX`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:box value type-name)
  ```
* **Description:** Explicitly boxes a Lisp value into a .NET type wrapper. This is used when calling overloaded methods where the exact argument type must be declared to resolve constructor or method signatures.
* **Parameters:**
  * `value` (Object): The Lisp value to convert/box.
  * `type-name` (String): The target .NET type name (e.g. `"System.Int16"`).
* **Returns:** A `LispDotNetBoxed` object wrapping the value.
* **Implementation Details:** Backed by `Runtime.DotNetBox` in `Runtime.DotNet.cs`. It calls `LispToDotNet` to perform type conversion and wraps it in a `LispDotNetBoxed` instance, which is handled specially by the method binder during overload resolution.
* **Usage Example:**
  ```lisp
  ;; Explicitly box integer to short to resolve overloaded method target
  (let ((boxed-val (dotnet:box 42 "System.Int16")))
    (dotnet:static "SomeNamespace.MathLibrary" "Compute" boxed-val))
  ```

---

### `DOTNET:CALL-BASE`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:call-base self method-name &rest args)
  ```
* **Description:** Invokes the base class implementation of a virtual method non-virtually on an instance of a dynamically emitted class. Equivalent to C# `base.Method(args)`.
* **Parameters:**
  * `self` (LispDotNetObject): An instance of a type defined using `dotnet:%define-class`.
  * `method-name` (String): The name of the virtual base method to invoke.
  * `args` (Rest): Arguments to pass.
* **Implementation Details:** Backed by `Runtime.DotNetCallBase` in `Runtime.DotNet.cs`. It reflects on the base type of the object, finds the matching method signature, and emits a `DynamicMethod` that uses `OpCodes.Call` (non-virtual instruction) instead of `OpCodes.Callvirt` to bypass the virtual method table override, caching the compiler result.
* **Usage Example:**
  ```lisp
  ;; Within a subclass override definition, call base method:
  (dotnet:call-base self "ToString")
  ```

---

### `DOTNET:CALL-OUT`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:call-out type-or-obj method-name &rest in-args)
  ```
* **Description:** Calls a .NET method that has `out` or `ref` parameter modifiers. The Lisp code provides only the input arguments, and the function returns the method's return value along with the output arguments. *(Note: This function does not support calling generic methods.)*
* **Parameters:**
  * `type-or-obj` (String or LispDotNetObject): A type name string for static calls, or a .NET object wrapper for instance calls.
  * `method-name` (String): The name of the method to call.
  * `in-args` (Rest): Only the input (non-out) arguments.
* **Returns:** Multiple values: first is the method's return value (or `t` if void), followed by the values of each `out` or `ref` parameter in declaration order.
* **Implementation Details:** Backed by `Runtime.DotNetCallOut` in `Runtime.DotNet.cs`. It reflects on the method to detect `IsOut` or `IsByRef` parameter flags, prepares a parameters array with placeholders for output positions, invokes the method, and extracts the results to return as a Lisp multiple value list. Because the resolution logic looks for concrete type matching and does not include `MakeGenericMethod` logic, `call-out` cannot be used on generic method definitions.
* **Usage Example:**
  ```lisp
  (multiple-value-bind (success result)
      (dotnet:call-out "System.Int32" "TryParse" "98765")
    (when success
      (format t "Parsed value: ~A~%" result)))
  ```

---

### `DOTNET:FFI`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:ffi dll func :args '(type-keyword ...) :ret ret-type-keyword &rest args)
  ```
* **Description:** A keyword-argument-based wrapper around `%FFI-CALL`. Simplifies native library calls by specifying arguments and returns using keyword variables.
* **Parameters:**
  * `dll` (String): The name/path of the shared library.
  * `func` (String): The name of the exported native symbol.
  * `:args` (List): Keyword listing parameter types.
  * `:ret` (Keyword): Keyword listing return type.
  * `args` (Rest): Argument values to pass.
* **Implementation Details:** Backed by `Runtime.FfiCallKeyword` in `Runtime.FFI.cs`. It parses the keyword arguments `:args` and `:ret` and delegates the call to the low-level `NativeFFI.Call` method.
* **Usage Example:**
  ```lisp
  (dotnet:ffi "libc" "abs" :args '(:int) :ret :int -99) ; Returns 99
  ```

---

### `DOTNET:FIND-SYMBOL`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:find-symbol func-name library-handle)
  ```
* **Description:** Resolves the memory address pointer of an exported native symbol within a specific loaded library.
* **Parameters:**
  * `func-name` (String): The name of the exported symbol.
  * `library-handle` (Integer): The integer OS library handle returned by `load-library`.
* **Returns:** An integer representing the address pointer, or `nil` if the symbol was not found.
* **Implementation Details:** Backed by `Runtime.FindSymbolInLib` in `Runtime.Memory.cs`. It calls `NativeLibrary.TryGetExport` with the loaded handle and returns the resulting `IntPtr` address as a `Fixnum`.
* **Usage Example:**
  ```lisp
  (let* ((lib (dotnet:load-library "libc"))
         (addr (dotnet:find-symbol "printf" lib)))
    (format t "printf address is: ~X~%" addr))
  ```

---

### `DOTNET:FIND-SYMBOL-ANY`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:find-symbol-any func-name)
  ```
* **Description:** Searches across all currently loaded native libraries to locate the address of an exported symbol.
* **Parameters:**
  * `func-name` (String): The name of the exported symbol.
* **Returns:** Integer address pointer or `nil` if not found.
* **Implementation Details:** Backed by `Runtime.FindSymbolAny` in `Runtime.Memory.cs`. It locks the internal library cache `_cffiLibHandles` and loops through all loaded handles to search via `NativeLibrary.TryGetExport`.
* **Usage Example:**
  ```lisp
  (let ((addr (dotnet:find-symbol-any "malloc")))
    (when addr
      (format t "Found malloc pointer: ~A~%" addr)))
  ```

---

### `DOTNET:FREE-LIBRARY`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:free-library library-handle)
  ```
* **Description:** Unloads and frees a native library handle loaded via `load-library`.
* **Parameters:**
  * `library-handle` (Integer): The handle representing the library to unload.
* **Implementation Details:** Backed by `Runtime.FreeLibrary` in `Runtime.Memory.cs`. It removes the handle reference from internal tracking maps (`_cffiLibHandles` and `_cffiHandleToPaths`) and calls `NativeLibrary.Free(handle)`.
* **Usage Example:**
  ```lisp
  (let ((lib (dotnet:load-library "libtest.so")))
    ;; perform operations...
    (dotnet:free-library lib))
  ```

---

### `DOTNET:FREE-MEM`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:free-mem address)
  ```
* **Description:** Releases an unmanaged native memory block allocated with `alloc-mem`.
* **Parameters:**
  * `address` (Integer): The raw memory address to free.
* **Implementation Details:** Backed by `Runtime.FreeMem` in `Runtime.Memory.cs`. It converts the address integer to an `IntPtr` and calls `Marshal.FreeHGlobal(IntPtr)`.
* **Usage Example:**
  ```lisp
  (let ((ptr (dotnet:alloc-mem 1024)))
    ;; use memory...
    (dotnet:free-mem ptr))
  ```

---

### `DOTNET:HINT-TYPE`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:hint-type obj)
  ```
* **Description:** For a `dotnet:box` value, returns its hint type (the user-supplied static type used to choose overloads) as a `System.Type`. Returns `nil` if `obj` carries no hint. See `dotnet:object-type` for the actual runtime type.

---

### `DOTNET:INVOKE`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:invoke object member-name &rest args)
  ```
* **Description:** Invokes an instance method, gets a property/field, or accesses COM properties on a .NET object.
* **Parameters:**
  * `object` (LispDotNetObject): The target .NET object.
  * `member-name` (String): The name of the method, property, or field.
  * `args` (Rest): Arguments to pass to the method.
* **Implementation Details:** Backed by `Runtime.DotNetInvoke` in `Runtime.DotNet.cs`. It handles C# arrays specially (routing `"get_Item"` or `"set_Item"` requests to `Array.GetValue` or `Array.SetValue` since they are not exposed as named properties). Otherwise, it delegates to `Type.InvokeMember` using instance read flags (`BindingFlags.Instance | BindingFlags.Public | BindingFlags.InvokeMethod | BindingFlags.GetProperty | BindingFlags.GetField`).
* **Usage Example:**
  ```lisp
  (let ((sb (dotnet:new "System.Text.StringBuilder" "Hello")))
    (dotnet:invoke sb "Append" " World")
    (dotnet:invoke sb "ToString")) ; Returns "Hello World"
  ```

---

### `DOTNET:INVOKE-GENERIC`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:invoke-generic object method-name type-args-list &rest args)
  ```
* **Description:** Instance counterpart of `dotnet:static-generic`: invoke a generic instance method on an object, instantiating it with the given type-argument name strings before the call.
* **Usage Example:**
  ```lisp
  (dotnet:invoke-generic cm "Load" '("Texture2D") "images/logo")
  ```

---

### `DOTNET:LIBRARY-PATH`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:library-path library-handle)
  ```
* **Description:** Retrieves the original library file path string associated with a loaded library handle.
* **Parameters:**
  * `library-handle` (Integer): The integer OS library handle.
* **Returns:** A string containing the original path, or `nil` if not found.
* **Implementation Details:** Backed by `Runtime.LibraryPath` in `Runtime.Memory.cs`. It queries the `_cffiHandleToPaths` dictionary mapping handles back to the string path used during loading.
* **Usage Example:**
  ```lisp
  (let ((lib (dotnet:load-library "libc")))
    (dotnet:library-path lib)) ; Returns e.g. "libc"
  ```

---

### `DOTNET:LOAD-ASSEMBLY`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:load-assembly path-or-name)
  ```
* **Description:** Loads a .NET assembly into the application domain, making its types resolvable by `dotnet:new`, `dotnet:static`, and class definitions.
* **Parameters:**
  * `path-or-name` (String): The assembly name (e.g. `"System.Windows.Forms"`) or a path to a `.dll` file.
* **Returns:** A string containing the FullName of the loaded assembly.
* **Implementation Details:** Backed by `Runtime.DotNetLoadAssembly` in `Runtime.DotNet.cs`. If the argument has no path separators and does not end in `.dll`, it attempts `Assembly.Load(name)` first, then searches SDK directories for framework assemblies. Otherwise, it calls `Assembly.LoadFrom(path)` (allowing dependencies in the same directory to resolve transitively).
* **Usage Example:**
  ```lisp
  (dotnet:load-assembly "System.Text.Json")
  ```

---

### `DOTNET:LOAD-LIBRARY`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:load-library path)
  ```
* **Description:** Loads a native dynamic shared library (`.dll`, `.so`, or `.dylib`) into the process address space.
* **Parameters:**
  * `path` (String): File name or path of the library.
* **Returns:** An integer representing the OS library handle address.
* **Implementation Details:** Backed by `Runtime.LoadLibrary` in `Runtime.Memory.cs`. It calls `NativeLibrary.Load(path)` and registers the path and handle in local cache dictionaries.
* **Usage Example:**
  ```lisp
  (defvar *libcrypto* (dotnet:load-library "libcrypto"))
  ```

---

### `DOTNET:MAKE-DELEGATE`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:make-delegate type-name function)
  ```
* **Description:** Wraps a Common Lisp function as a concrete .NET `Delegate` (e.g. `System.Func` or `System.Action`), enabling Lisp callbacks to be passed directly into .NET methods.
* **Parameters:**
  * `type-name` (String): The fully-qualified delegate signature type (e.g. `"System.Func`2[System.String,System.Boolean]"`).
  * `function` (Function): The Lisp closure/lambda.
* **Returns:** A `LispDotNetObject` wrapping the compiled .NET delegate.
* **Implementation Details:** Backed by `Runtime.DotNetMakeDelegate` and `Runtime.CreateLispDelegate` in `Runtime.DotNet.cs`. It resolves the delegate type and uses `System.Linq.Expressions` to build a dynamic delegate matching the signature. When invoked from .NET, the delegate converts inputs via `DotNetToLisp`, invokes the Lisp function, and marshals the result back to the delegate's return type.
* **Usage Example:**
  ```lisp
  (let ((predicate (dotnet:make-delegate
                    "System.Func`2[System.Int32,System.Boolean]"
                    (lambda (x) (> x 5)))))
    (dotnet:static-generic "System.Linq.Enumerable" "Where"
                           '("System.Int32") my-list predicate))
  ```

---

### `DOTNET:MEM-READ`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:mem-read type address &optional offset)
  ```
* **Description:** Reads a primitive value from an unmanaged native memory address.
* **Parameters:**
  * `type` (Keyword/Symbol): The data type to read (e.g. `:char`, `:int8`, `:uint8`, `:short`, `:int16`, `:uint16`, `:int`, `:int32`, `:long`, `:int64`, `:float`, `:double`, `:pointer`).
  * `address` (Integer): The base address pointer.
  * `offset` (Integer, optional): An offset in bytes to add to the base address. Defaults to 0.
* **Returns:** The Lisp representation of the read value.
* **Implementation Details:** Backed by `Runtime.MemRead` in `Runtime.Memory.cs`. It calculates the offset address and performs native memory reads using `Marshal` methods (e.g. `Marshal.ReadByte`, `Marshal.ReadInt32`, `Marshal.ReadIntPtr`), converting float/double bits using `BitConverter`.
* **Usage Example:**
  ```lisp
  (let ((val (dotnet:mem-read :int addr 8)))
    (format t "Value at addr+8 is: ~A~%" val))
  ```

---

### `DOTNET:MEM-WRITE`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:mem-write value type address &optional offset)
  ```
* **Description:** Writes a primitive value to an unmanaged native memory address.
* **Parameters:**
  * `value` (Object): The Lisp value to write.
  * `type` (Keyword/Symbol): The primitive type to write (e.g. `:int`, `:float`, `:double`, `:pointer`).
  * `address` (Integer): The base address pointer.
  * `offset` (Integer, optional): An offset in bytes. Defaults to 0.
* **Returns:** The value that was written.
* **Implementation Details:** Backed by `Runtime.MemWrite` in `Runtime.Memory.cs`. It writes values using `Marshal.WriteInt32`, `Marshal.WriteInt64`, or `Marshal.WriteIntPtr` depending on type mappings. Float/double values are converted to raw bits via `BitConverter` before writing.
* **Usage Example:**
  ```lisp
  (let ((ptr (dotnet:alloc-mem 4)))
    (dotnet:mem-write 100 :int ptr)
    (dotnet:free-mem ptr))
  ```

---

### `DOTNET:NEW`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:new type-name &rest args)
  ```
* **Description:** Instantiates a new instance of a .NET class by invoking a matching constructor.
* **Parameters:**
  * `type-name` (String): The name of the class to instantiate.
  * `args` (Rest): Constructor arguments.
* **Returns:** A `LispDotNetObject` wrapping the new instance.
* **Implementation Details:** Backed by `Runtime.DotNetNew` in `Runtime.DotNet.cs`. If called with no arguments, it uses `Activator.CreateInstance`. Otherwise, it finds all constructors matching the parameter count, scores them based on parameter type compatibility (preferring close primitive conversions like Fixnum to `int` or `long`), converts Lisp arguments, and invokes `ConstructorInfo.Invoke`.
* **Usage Example:**
  ```lisp
  (let ((sb (dotnet:new "System.Text.StringBuilder" "Hello World")))
    (dotnet:invoke sb "ToString"))
  ```

---

### `DOTNET:OBJECT-TYPE`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:object-type obj)
  ```
* **Description:** Returns the actual runtime type of a .NET object as a `System.Type`. Returns `nil` if `obj` is not a .NET object. For a `dotnet:box` value this may differ from `dotnet:hint-type`.

---

### `DOTNET:REMOVE-EVENT`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:remove-event object event-name handler)
  ```
* **Description:** Unregisters/detaches an event handler callback that was registered via `add-event`.
* **Parameters:**
  * `object` (LispDotNetObject): The target .NET object instance.
  * `event-name` (String): The name of the event.
  * `handler` (Function or LispDotNetObject): The original Lisp function closure or a wrapped Delegate instance.
* **Implementation Details:** Backed by `DotNetEvents.RemoveEvent` in `Runtime.Events.cs`. It checks the cache `_delegateCache` to retrieve the compiled Delegate associated with the Lisp function, and invokes the event's remove method using reflection.
* **Usage Example:**
  ```lisp
  (dotnet:remove-event btn "Click" click-handler)
  ```

---

### `DOTNET:REQUIRE`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:require package-id &optional version)
  ```
* **Description:** Dynamically downloads, extracts, and references NuGet packages at runtime, resolving dependencies and loading their assemblies.
* **Parameters:**
  * `package-id` (String): The NuGet package identifier (e.g. `"Newtonsoft.Json"`).
  * `version` (String, optional): The specific package version. If omitted, resolves and downloads the latest stable version.
* **Returns:** A string naming the loaded package and resolved version (e.g. `"Newtonsoft.Json/13.0.3"`).
* **Implementation Details:** Backed by `DotNetNuGet.Require` in `Runtime.NuGet.cs`. It checks the local NuGet global packages folder (`~/.nuget/packages`). If missing, it queries the NuGet v3 HTTP API, downloads the `.nupkg` file, extracts runtime-compatible assemblies (checking TFM chains like `net10.0`, `net9.0`, `netstandard2.0` in order), and loads them into the current `AppDomain` using `Assembly.LoadFrom`.
* **Usage Example:**
  ```lisp
  (dotnet:require "Newtonsoft.Json" "13.0.3")
  ```

---

### `DOTNET:RESOLVE-TYPE`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:resolve-type type-name)
  ```
* **Description:** Resolves a .NET `System.Type` from a name string, searching loaded assemblies (loading by namespace prefix, and COM ProgIDs on Windows). The result can be inspected or passed anywhere a `System.Type` is expected. Errors if not found.

---

### `DOTNET:STATIC`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:static type-name member-name &rest args)
  ```
* **Description:** Invokes a static method, gets a static property, or gets a static field on a .NET type.
* **Parameters:**
  * `type-name` (String): The fully-qualified name of the .NET type.
  * `member-name` (String): The static method, property, or field name.
  * `args` (Rest): Arguments to pass if invoking a method.
* **Implementation Details:** Backed by `Runtime.DotNetStatic` in `Runtime.DotNet.cs`. It resolves the Type, marshals arguments, and calls `Type.InvokeMember` using `BindingFlags.Static | BindingFlags.Public | BindingFlags.InvokeMethod | BindingFlags.GetProperty | BindingFlags.GetField`.
* **Usage Example:**
  ```lisp
  (let ((current-time (dotnet:static "System.DateTime" "get_Now")))
    (dotnet:invoke current-time "ToString"))
  ```

---

### `DOTNET:STATIC-GENERIC`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:static-generic type-name method-name type-args-list &rest args)
  ```
* **Description:** Calls a static generic method on a .NET type, passing explicit type arguments.
* **Parameters:**
  * `type-name` (String): Fully-qualified type name.
  * `method-name` (String): Name of the generic static method.
  * `type-args-list` (List): List of strings indicating the type arguments (e.g., `'("System.String")`).
  * `args` (Rest): Parameters for the method call.
* **Implementation Details:** Backed by `Runtime.DotNetStaticGeneric` in `Runtime.DotNet.cs`. It locates the generic method definition, resolves the concrete type arguments, generates the concrete method using `MakeGenericMethod`, converts Lisp arguments (automatically marshaling Lisp functions to delegates), and invokes it.
* **Usage Example:**
  ```lisp
  (dotnet:static-generic "System.Linq.Enumerable" "Empty" '("System.Int32"))
  ```

---

### `DOTNET:TO-STREAM`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:to-stream net-stream &key binary)
  ```
* **Description:** Wraps a .NET `System.IO.Stream` into a Common Lisp stream object, enabling standard Lisp stream functions (`read-char`, `write-line`, `read-byte`, etc.) to operate on it.
* **Parameters:**
  * `net-stream` (LispDotNetObject): A wrapped `System.IO.Stream`.
  * `:binary` (Boolean, keyword): If true, creates a binary stream (`LispBinaryStream`). Otherwise, creates a character stream (`LispBidirectionalStream` utilizing `StreamReader` and `StreamWriter`).
* **Returns:** A Common Lisp stream object.
* **Implementation Details:** Backed by `Runtime.DotNetToStream` in `Runtime.DotNet.cs`. Validates the stream type and returns a subclass of `LispStream` tailored for binary or UTF-8 character operations.
* **Usage Example:**
  ```lisp
  (let* ((net-stream (dotnet:static "System.IO.File" "OpenRead" "data.txt"))
         (cl-stream (dotnet:to-stream net-stream)))
    (unwind-protect
         (read-line cl-stream)
      (close cl-stream)))
  ```

---

### `DOTNET:TYPE-ALIGN`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:type-align type-keyword)
  ```
* **Description:** Returns the memory alignment requirement (in bytes) for a primitive native data type.
* **Parameters:**
  * `type-keyword` (Keyword/Symbol): The data type keyword (e.g. `:int`, `:double`).
* **Returns:** Integer alignment value.
* **Implementation Details:** Backed by `Runtime.TypeAlign` in `Runtime.Memory.cs`. It maps type keywords to sizes, returning alignment size equal to size for primitive types on x64 platforms.
* **Usage Example:**
  ```lisp
  (dotnet:type-align :double) ; Returns 8
  ```

---

### `DOTNET:TYPE-SIZE`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:type-size type-keyword)
  ```
* **Description:** Returns the size (in bytes) of a primitive native data type.
* **Parameters:**
  * `type-keyword` (Keyword/Symbol): The data type keyword.
* **Returns:** Integer byte size.
* **Implementation Details:** Backed by `Runtime.TypeSize` in `Runtime.Memory.cs`. It uses a size map dictionary (`_typeSizes`) which resolves pointers (`:pointer`/`:ptr`) dynamically using `IntPtr.Size` (8 on 64-bit systems).
* **Usage Example:**
  ```lisp
  (dotnet:type-size :pointer) ; Returns 8 on x64 systems
  ```

---

### `DOTNET:AWAIT`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:await awaitable)
  ```
* **Description:** Block until a .NET `Task`, `Task<T>`, `ValueTask`, or `ValueTask<T>` completes and return its result marshalled to Lisp (returns `nil` for a void/non-generic awaitable). A faulted awaitable rethrows its inner exception so `handler-case` or `handler-bind` sees the real condition. Holds the calling thread, so run it on a worker thread when the caller must stay responsive.

---

### `DOTNET:CALL-OUT-GENERIC`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:call-out-generic type-or-obj method-name type-args-list &rest in-args)
  ```
* **Description:** Generic counterpart of `dotnet:call-out`: instantiate an open generic method with the given type-argument name strings (`MakeGenericMethod`), then invoke it handling out/ref parameters.
* **Parameters:**
  * `type-or-obj` (String or LispDotNetObject): A type name string (static) or a .NET object (instance).
  * `method-name` (String): The name of the method to call.
  * `type-args-list` (List): List of strings indicating the generic type arguments.
  * `in-args` (Rest): Only the input (non-out) arguments.
* **Returns:** Multiple values: first is the method's return value (or `t` if void), followed by the values of each `out` or `ref` parameter.
* **Usage Example:**
  ```lisp
  (multiple-value-bind (ok day) (dotnet:call-out-generic "System.Enum" "TryParse" '("System.DayOfWeek") "Monday") ...)
  ```

---

### `DOTNET:CAST`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:cast obj type-name)
  ```
* **Description:** Reference cast: verify `obj` is an instance of `type-name` (error if not) and return it re-wrapped carrying `type-name` as its static hint. This ensures that later `dotnet:invoke` or `dotnet:new` overload resolution treats it as `type-name` (useful for upcasting to a base class/interface). For value-type conversions use `dotnet:box` instead.

---

### `DOTNET:ENUM-OR`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:enum-or enum-type &rest members)
  ```
* **Description:** Combine `[Flags]` enum members with bitwise OR. `enum-type` is a type-name string/symbol or `System.Type`. Each member is a member-name string/symbol (case-insensitive), an integer, or an existing enum value of the type.
* **Usage Example:**
  ```lisp
  (dotnet:enum-or "System.IO.FileAccess" "Read" "Write")
  ```

---

### `DOTNET:EXCEPTION-TYPE`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:exception-type condition)
  ```
* **Description:** For a condition wrapping a raw .NET exception (e.g. caught in `handler-case`), return the original CLR exception `System.Type`; returns `nil` for an ordinary Lisp condition.

---

### `DOTNET:EXCEPTION-TYPEP`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:exception-typep condition type-name)
  ```
* **Description:** Returns `t` if `condition` wraps a raw .NET exception whose CLR type is `type-name` or a subtype (`Type.IsAssignableFrom`). `type-name` is a type-name string/symbol or `System.Type`. This is the matcher `dotnet:handler-bind` uses.

---

### `DOTNET:HANDLER-BIND`

* **Type:** Macro
* **Syntax:**
  ```lisp
  (dotnet:handler-bind ((type-name handler) ...) body...)
  ```
* **Description:** A dedicated macro that wraps Lisp `handler-bind` to catch specific .NET exceptions. It unwraps the condition and matches the .NET type using `dotnet:exception-typep`.

---

### `DOTNET:IS-INSTANCE-OF`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:is-instance-of obj type-name)
  ```
* **Description:** Return `t` if `obj` is an instance of `type-name` (a type-name string/symbol or `System.Type`), else `nil`. `obj` may be a wrapped .NET object or a plain Lisp value (marshalled to its natural .NET type first). Replaces manual `Type.IsAssignableFrom` checks.

---

### `DOTNET:MAKE-ARRAY`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:make-array element-type &rest dimensions)
  ```
* **Description:** Create a typed .NET array of `element-type` sized by `dimensions`, filled with the element type's default. One dimension creates a 1-D array; several creates a multi-dimensional array. `element-type` is a type-name string/symbol or a resolved `System.Type`. Access elements via `(dotnet:invoke arr "get_Item"/"set_Item" idx... [val])`.
* **Usage Example:**
  ```lisp
  (dotnet:make-array "System.Int32" 100)
  (dotnet:make-array "System.Single" 10 20)
  ```

---

### `DOTNET:MAKE-GENERIC-TYPE`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:make-generic-type open-type type-args-list)
  ```
* **Description:** Construct a closed generic `System.Type` from an open generic type definition and a list of type-argument names. `open-type` may carry the CLR backtick-arity suffix (e.g. `"...Dictionary\`2"`) or omit it (arity inferred from the list). The result is usable with `dotnet:new` and other type args.
* **Usage Example:**
  ```lisp
  (dotnet:make-generic-type "System.Collections.Generic.Dictionary" '("System.String" "System.Int32"))
  ```

---

### `DOTNET:NEW-ARRAY`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:new-array element-type &rest elements)
  ```
* **Description:** Create a typed .NET array (element-type[]) filled with the marshalled `elements`. `element-type` is a type-name string/symbol or a resolved `System.Type`. A Lisp list or vector is also auto-marshalled to an array-typed parameter or property natively, but this allows explicit creation.

---

### `DOTNET:NULL`

* **Type:** Function
* **Syntax:**
  ```lisp
  (dotnet:null)
  ```
* **Description:** Return a marker that marshals to an explicit .NET `null`, for a reference or `Nullable<T>` parameter. Distinct from Lisp `nil`, which marshals to `false` for a `bool` / `Nullable<bool>` target.
