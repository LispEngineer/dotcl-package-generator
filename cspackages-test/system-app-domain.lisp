;;; Generated automatically. Do not edit.
;;; Class: System.AppDomain
;;; Generator Version: 37
;;; Creation Date: 2026-07-05T18:46:38Z

(cl:in-package :system-app-domain)

(cl:defconstant <type> (dotnet:resolve-type "System.AppDomain"))
(cl:defconstant <type-str> "System.AppDomain")
(cl:defconstant <creation> "2026-07-05T18:46:38Z")
(cl:defconstant <version> 37)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.AppDomain")))

(cl:define-symbol-macro current-domain (dotnet:static <type-str> "CurrentDomain"))

(cl:define-symbol-macro monitoring-survived-process-memory-size (dotnet:static <type-str> "MonitoringSurvivedProcessMemorySize"))

(cl:defun monitoring-is-enabled ()
  (dotnet:static <type-str> "MonitoringIsEnabled"))

(cl:defun (cl:setf monitoring-is-enabled) (new-value)
  (cl:setf (dotnet:static <type-str> "MonitoringIsEnabled") new-value))

(cl:defun base-directory (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "get_BaseDirectory"))

(cl:defun dynamic-directory (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "get_DynamicDirectory"))

(cl:defun friendly-name (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "get_FriendlyName"))

(cl:defun id (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "get_Id"))

(cl:defun fully-trusted? (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "get_IsFullyTrusted"))

(cl:defun homogenous? (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "get_IsHomogenous"))

(cl:defun monitoring-survived-memory-size (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "get_MonitoringSurvivedMemorySize"))

(cl:defun monitoring-total-allocated-memory-size (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "get_MonitoringTotalAllocatedMemorySize"))

(cl:defun monitoring-total-processor-time (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "get_MonitoringTotalProcessorTime"))

(cl:defun permission-set (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "get_PermissionSet"))

(cl:defun relative-search-path (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "get_RelativeSearchPath"))

(cl:defun setup-information (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "get_SetupInformation"))

(cl:defun shadow-copy-files (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "get_ShadowCopyFiles"))

(cl:defun add-assembly-load (obj! handler)
  (dotnet:add-event (cl:the (dotnet "System.AppDomain") obj!) "AssemblyLoad" handler))

(cl:defun remove-assembly-load (obj! handler)
  "Pass the exact same HANDLER object given to add-assembly-load -- removal is by identity, not by behavioral equivalence."
  (dotnet:remove-event (cl:the (dotnet "System.AppDomain") obj!) "AssemblyLoad" handler))

(cl:defun add-assembly-resolve (obj! handler)
  (dotnet:add-event (cl:the (dotnet "System.AppDomain") obj!) "AssemblyResolve" handler))

(cl:defun remove-assembly-resolve (obj! handler)
  "Pass the exact same HANDLER object given to add-assembly-resolve -- removal is by identity, not by behavioral equivalence."
  (dotnet:remove-event (cl:the (dotnet "System.AppDomain") obj!) "AssemblyResolve" handler))

(cl:defun add-domain-unload (obj! handler)
  (dotnet:add-event (cl:the (dotnet "System.AppDomain") obj!) "DomainUnload" handler))

(cl:defun remove-domain-unload (obj! handler)
  "Pass the exact same HANDLER object given to add-domain-unload -- removal is by identity, not by behavioral equivalence."
  (dotnet:remove-event (cl:the (dotnet "System.AppDomain") obj!) "DomainUnload" handler))

(cl:defun add-first-chance-exception (obj! handler)
  (dotnet:add-event (cl:the (dotnet "System.AppDomain") obj!) "FirstChanceException" handler))

(cl:defun remove-first-chance-exception (obj! handler)
  "Pass the exact same HANDLER object given to add-first-chance-exception -- removal is by identity, not by behavioral equivalence."
  (dotnet:remove-event (cl:the (dotnet "System.AppDomain") obj!) "FirstChanceException" handler))

(cl:defun add-process-exit (obj! handler)
  (dotnet:add-event (cl:the (dotnet "System.AppDomain") obj!) "ProcessExit" handler))

(cl:defun remove-process-exit (obj! handler)
  "Pass the exact same HANDLER object given to add-process-exit -- removal is by identity, not by behavioral equivalence."
  (dotnet:remove-event (cl:the (dotnet "System.AppDomain") obj!) "ProcessExit" handler))

(cl:defun add-reflection-only-assembly-resolve (obj! handler)
  (dotnet:add-event (cl:the (dotnet "System.AppDomain") obj!) "ReflectionOnlyAssemblyResolve" handler))

(cl:defun remove-reflection-only-assembly-resolve (obj! handler)
  "Pass the exact same HANDLER object given to add-reflection-only-assembly-resolve -- removal is by identity, not by behavioral equivalence."
  (dotnet:remove-event (cl:the (dotnet "System.AppDomain") obj!) "ReflectionOnlyAssemblyResolve" handler))

(cl:defun add-resource-resolve (obj! handler)
  (dotnet:add-event (cl:the (dotnet "System.AppDomain") obj!) "ResourceResolve" handler))

(cl:defun remove-resource-resolve (obj! handler)
  "Pass the exact same HANDLER object given to add-resource-resolve -- removal is by identity, not by behavioral equivalence."
  (dotnet:remove-event (cl:the (dotnet "System.AppDomain") obj!) "ResourceResolve" handler))

(cl:defun add-type-resolve (obj! handler)
  (dotnet:add-event (cl:the (dotnet "System.AppDomain") obj!) "TypeResolve" handler))

(cl:defun remove-type-resolve (obj! handler)
  "Pass the exact same HANDLER object given to add-type-resolve -- removal is by identity, not by behavioral equivalence."
  (dotnet:remove-event (cl:the (dotnet "System.AppDomain") obj!) "TypeResolve" handler))

(cl:defun add-unhandled-exception (obj! handler)
  (dotnet:add-event (cl:the (dotnet "System.AppDomain") obj!) "UnhandledException" handler))

(cl:defun remove-unhandled-exception (obj! handler)
  "Pass the exact same HANDLER object given to add-unhandled-exception -- removal is by identity, not by behavioral equivalence."
  (dotnet:remove-event (cl:the (dotnet "System.AppDomain") obj!) "UnhandledException" handler))

(cl:defun append-private-path (obj! path)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "AppendPrivatePath" path))

(cl:defun apply-policy (obj! assembly-name)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "ApplyPolicy" assembly-name))

(cl:defun clear-private-path (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "ClearPrivatePath"))

(cl:defun clear-shadow-copy-path (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "ClearShadowCopyPath"))

(cl:defun create-domain (friendly-name)
  (dotnet:static <type-str> "CreateDomain" (cl:the (dotnet "System.String") friendly-name)))

(cl:defun create-instance (obj! assembly-name type-name cl:&optional (activation-attributes cl:nil supplied-activation-attributes) (binding-attr cl:nil supplied-binding-attr) (binder cl:nil supplied-binder) (args cl:nil supplied-args) (culture cl:nil supplied-culture) (activation-attributes2 cl:nil supplied-activation-attributes2))
  "Master wrapper for System.AppDomain.CreateInstance overloads. Dispatches at runtime.

CreateInstance(String, String) -> ObjectHandle

CreateInstance(String, String, Object[]) -> ObjectHandle

CreateInstance(String, String, Boolean, BindingFlags, Binder, Object[], CultureInfo, Object[]) -> ObjectHandle
"
  (cl:cond
    ((cl:and (cl:stringp assembly-name) (cl:stringp type-name) supplied-activation-attributes (cl:typep activation-attributes 'cl:boolean) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) supplied-binder (cl:or (cl:null binder) (dotnet:object-type binder)) supplied-args (cl:or (cl:null args) (dotnet:object-type args)) supplied-culture (cl:or (cl:null culture) (dotnet:object-type culture)) supplied-activation-attributes2 (cl:or (cl:null activation-attributes2) (dotnet:object-type activation-attributes2)))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "CreateInstance" assembly-name type-name activation-attributes binding-attr binder args culture activation-attributes2))
    ((cl:and (cl:stringp assembly-name) (cl:stringp type-name) supplied-activation-attributes (cl:or (cl:null activation-attributes) (dotnet:object-type activation-attributes)) (cl:not supplied-binding-attr) (cl:not supplied-binder) (cl:not supplied-args) (cl:not supplied-culture) (cl:not supplied-activation-attributes2))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "CreateInstance" assembly-name type-name activation-attributes))
    ((cl:and (cl:stringp assembly-name) (cl:stringp type-name) (cl:not supplied-activation-attributes) (cl:not supplied-binding-attr) (cl:not supplied-binder) (cl:not supplied-args) (cl:not supplied-culture) (cl:not supplied-activation-attributes2))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "CreateInstance" assembly-name type-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-APP-DOMAIN"
                    :class-name <type-str>
                    :method-name "CreateInstance"
                    :supplied-args (cl:append (cl:list :assembly-name assembly-name) (cl:list :type-name type-name) (cl:when supplied-activation-attributes (cl:list :activation-attributes activation-attributes)) (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)) (cl:when supplied-binder (cl:list :binder binder)) (cl:when supplied-args (cl:list :args args)) (cl:when supplied-culture (cl:list :culture culture)) (cl:when supplied-activation-attributes2 (cl:list :activation-attributes2 activation-attributes2)))))))

(cl:defun create-instance-and-unwrap (obj! assembly-name type-name cl:&optional (activation-attributes cl:nil supplied-activation-attributes) (binding-attr cl:nil supplied-binding-attr) (binder cl:nil supplied-binder) (args cl:nil supplied-args) (culture cl:nil supplied-culture) (activation-attributes2 cl:nil supplied-activation-attributes2))
  "Master wrapper for System.AppDomain.CreateInstanceAndUnwrap overloads. Dispatches at runtime.

CreateInstanceAndUnwrap(String, String) -> Object

CreateInstanceAndUnwrap(String, String, Object[]) -> Object

CreateInstanceAndUnwrap(String, String, Boolean, BindingFlags, Binder, Object[], CultureInfo, Object[]) -> Object
"
  (cl:cond
    ((cl:and (cl:stringp assembly-name) (cl:stringp type-name) supplied-activation-attributes (cl:typep activation-attributes 'cl:boolean) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) supplied-binder (cl:or (cl:null binder) (dotnet:object-type binder)) supplied-args (cl:or (cl:null args) (dotnet:object-type args)) supplied-culture (cl:or (cl:null culture) (dotnet:object-type culture)) supplied-activation-attributes2 (cl:or (cl:null activation-attributes2) (dotnet:object-type activation-attributes2)))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "CreateInstanceAndUnwrap" assembly-name type-name activation-attributes binding-attr binder args culture activation-attributes2))
    ((cl:and (cl:stringp assembly-name) (cl:stringp type-name) supplied-activation-attributes (cl:or (cl:null activation-attributes) (dotnet:object-type activation-attributes)) (cl:not supplied-binding-attr) (cl:not supplied-binder) (cl:not supplied-args) (cl:not supplied-culture) (cl:not supplied-activation-attributes2))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "CreateInstanceAndUnwrap" assembly-name type-name activation-attributes))
    ((cl:and (cl:stringp assembly-name) (cl:stringp type-name) (cl:not supplied-activation-attributes) (cl:not supplied-binding-attr) (cl:not supplied-binder) (cl:not supplied-args) (cl:not supplied-culture) (cl:not supplied-activation-attributes2))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "CreateInstanceAndUnwrap" assembly-name type-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-APP-DOMAIN"
                    :class-name <type-str>
                    :method-name "CreateInstanceAndUnwrap"
                    :supplied-args (cl:append (cl:list :assembly-name assembly-name) (cl:list :type-name type-name) (cl:when supplied-activation-attributes (cl:list :activation-attributes activation-attributes)) (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)) (cl:when supplied-binder (cl:list :binder binder)) (cl:when supplied-args (cl:list :args args)) (cl:when supplied-culture (cl:list :culture culture)) (cl:when supplied-activation-attributes2 (cl:list :activation-attributes2 activation-attributes2)))))))

(cl:defun create-instance-from (obj! assembly-file type-name cl:&optional (activation-attributes cl:nil supplied-activation-attributes) (binding-attr cl:nil supplied-binding-attr) (binder cl:nil supplied-binder) (args cl:nil supplied-args) (culture cl:nil supplied-culture) (activation-attributes2 cl:nil supplied-activation-attributes2))
  "Master wrapper for System.AppDomain.CreateInstanceFrom overloads. Dispatches at runtime.

CreateInstanceFrom(String, String) -> ObjectHandle

CreateInstanceFrom(String, String, Object[]) -> ObjectHandle

CreateInstanceFrom(String, String, Boolean, BindingFlags, Binder, Object[], CultureInfo, Object[]) -> ObjectHandle
"
  (cl:cond
    ((cl:and (cl:stringp assembly-file) (cl:stringp type-name) supplied-activation-attributes (cl:typep activation-attributes 'cl:boolean) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) supplied-binder (cl:or (cl:null binder) (dotnet:object-type binder)) supplied-args (cl:or (cl:null args) (dotnet:object-type args)) supplied-culture (cl:or (cl:null culture) (dotnet:object-type culture)) supplied-activation-attributes2 (cl:or (cl:null activation-attributes2) (dotnet:object-type activation-attributes2)))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "CreateInstanceFrom" assembly-file type-name activation-attributes binding-attr binder args culture activation-attributes2))
    ((cl:and (cl:stringp assembly-file) (cl:stringp type-name) supplied-activation-attributes (cl:or (cl:null activation-attributes) (dotnet:object-type activation-attributes)) (cl:not supplied-binding-attr) (cl:not supplied-binder) (cl:not supplied-args) (cl:not supplied-culture) (cl:not supplied-activation-attributes2))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "CreateInstanceFrom" assembly-file type-name activation-attributes))
    ((cl:and (cl:stringp assembly-file) (cl:stringp type-name) (cl:not supplied-activation-attributes) (cl:not supplied-binding-attr) (cl:not supplied-binder) (cl:not supplied-args) (cl:not supplied-culture) (cl:not supplied-activation-attributes2))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "CreateInstanceFrom" assembly-file type-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-APP-DOMAIN"
                    :class-name <type-str>
                    :method-name "CreateInstanceFrom"
                    :supplied-args (cl:append (cl:list :assembly-file assembly-file) (cl:list :type-name type-name) (cl:when supplied-activation-attributes (cl:list :activation-attributes activation-attributes)) (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)) (cl:when supplied-binder (cl:list :binder binder)) (cl:when supplied-args (cl:list :args args)) (cl:when supplied-culture (cl:list :culture culture)) (cl:when supplied-activation-attributes2 (cl:list :activation-attributes2 activation-attributes2)))))))

(cl:defun create-instance-from-and-unwrap (obj! assembly-file type-name cl:&optional (activation-attributes cl:nil supplied-activation-attributes) (binding-attr cl:nil supplied-binding-attr) (binder cl:nil supplied-binder) (args cl:nil supplied-args) (culture cl:nil supplied-culture) (activation-attributes2 cl:nil supplied-activation-attributes2))
  "Master wrapper for System.AppDomain.CreateInstanceFromAndUnwrap overloads. Dispatches at runtime.

CreateInstanceFromAndUnwrap(String, String) -> Object

CreateInstanceFromAndUnwrap(String, String, Object[]) -> Object

CreateInstanceFromAndUnwrap(String, String, Boolean, BindingFlags, Binder, Object[], CultureInfo, Object[]) -> Object
"
  (cl:cond
    ((cl:and (cl:stringp assembly-file) (cl:stringp type-name) supplied-activation-attributes (cl:typep activation-attributes 'cl:boolean) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) supplied-binder (cl:or (cl:null binder) (dotnet:object-type binder)) supplied-args (cl:or (cl:null args) (dotnet:object-type args)) supplied-culture (cl:or (cl:null culture) (dotnet:object-type culture)) supplied-activation-attributes2 (cl:or (cl:null activation-attributes2) (dotnet:object-type activation-attributes2)))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "CreateInstanceFromAndUnwrap" assembly-file type-name activation-attributes binding-attr binder args culture activation-attributes2))
    ((cl:and (cl:stringp assembly-file) (cl:stringp type-name) supplied-activation-attributes (cl:or (cl:null activation-attributes) (dotnet:object-type activation-attributes)) (cl:not supplied-binding-attr) (cl:not supplied-binder) (cl:not supplied-args) (cl:not supplied-culture) (cl:not supplied-activation-attributes2))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "CreateInstanceFromAndUnwrap" assembly-file type-name activation-attributes))
    ((cl:and (cl:stringp assembly-file) (cl:stringp type-name) (cl:not supplied-activation-attributes) (cl:not supplied-binding-attr) (cl:not supplied-binder) (cl:not supplied-args) (cl:not supplied-culture) (cl:not supplied-activation-attributes2))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "CreateInstanceFromAndUnwrap" assembly-file type-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-APP-DOMAIN"
                    :class-name <type-str>
                    :method-name "CreateInstanceFromAndUnwrap"
                    :supplied-args (cl:append (cl:list :assembly-file assembly-file) (cl:list :type-name type-name) (cl:when supplied-activation-attributes (cl:list :activation-attributes activation-attributes)) (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)) (cl:when supplied-binder (cl:list :binder binder)) (cl:when supplied-args (cl:list :args args)) (cl:when supplied-culture (cl:list :culture culture)) (cl:when supplied-activation-attributes2 (cl:list :activation-attributes2 activation-attributes2)))))))

(cl:defun execute-assembly (obj! assembly-file cl:&optional (args cl:nil supplied-args) (hash-value cl:nil supplied-hash-value) (hash-algorithm cl:nil supplied-hash-algorithm))
  "Master wrapper for System.AppDomain.ExecuteAssembly overloads. Dispatches at runtime.

ExecuteAssembly(String) -> Int32

ExecuteAssembly(String, String[]) -> Int32

ExecuteAssembly(String, String[], Byte[], AssemblyHashAlgorithm) -> Int32
"
  (cl:cond
    ((cl:and (cl:stringp assembly-file) supplied-args (cl:or (cl:null args) (dotnet:object-type args)) supplied-hash-value (cl:or (cl:null hash-value) (dotnet:object-type hash-value)) supplied-hash-algorithm (cl:or (cl:null hash-algorithm) (dotnet:object-type hash-algorithm)))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "ExecuteAssembly" assembly-file args hash-value hash-algorithm))
    ((cl:and (cl:stringp assembly-file) supplied-args (cl:or (cl:null args) (dotnet:object-type args)) (cl:not supplied-hash-value) (cl:not supplied-hash-algorithm))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "ExecuteAssembly" assembly-file args))
    ((cl:and (cl:stringp assembly-file) (cl:not supplied-args) (cl:not supplied-hash-value) (cl:not supplied-hash-algorithm))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "ExecuteAssembly" assembly-file))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-APP-DOMAIN"
                    :class-name <type-str>
                    :method-name "ExecuteAssembly"
                    :supplied-args (cl:append (cl:list :assembly-file assembly-file) (cl:when supplied-args (cl:list :args args)) (cl:when supplied-hash-value (cl:list :hash-value hash-value)) (cl:when supplied-hash-algorithm (cl:list :hash-algorithm hash-algorithm)))))))

(cl:defun execute-assembly-by-name (obj! assembly-name)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "ExecuteAssemblyByName" assembly-name))

;; Note: System.AppDomain.ExecuteAssemblyByName also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   ExecuteAssemblyByName(AssemblyName, params String[]) -> Int32
;;   ExecuteAssemblyByName(String, params String[]) -> Int32

(cl:defun get-assemblies (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "GetAssemblies"))

(cl:defun get-current-thread-id ()
  (dotnet:static <type-str> "GetCurrentThreadId"))

(cl:defun get-data (obj! name)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "GetData" name))

(cl:defun compatibility-switch-set? (obj! value)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "IsCompatibilitySwitchSet" value))

(cl:defun default-app-domain? (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "IsDefaultAppDomain"))

(cl:defun finalizing-for-unload? (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "IsFinalizingForUnload"))

(cl:defun load (obj! raw-assembly cl:&optional (raw-symbol-store cl:nil supplied-raw-symbol-store))
  "Master wrapper for System.AppDomain.Load overloads. Dispatches at runtime.

Load(Byte[]) -> Assembly

Load(AssemblyName) -> Assembly

Load(String) -> Assembly

Load(Byte[], Byte[]) -> Assembly
"
  (cl:cond
    ((cl:and (cl:or (cl:null raw-assembly) (dotnet:object-type raw-assembly)) supplied-raw-symbol-store (cl:or (cl:null raw-symbol-store) (dotnet:object-type raw-symbol-store)))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "Load" raw-assembly raw-symbol-store))
    ((cl:and (cl:or (cl:null raw-assembly) (dotnet:object-type raw-assembly)) (cl:not supplied-raw-symbol-store))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "Load" raw-assembly))
    ((cl:and (cl:or (cl:null raw-assembly) (dotnet:object-type raw-assembly)) (cl:not supplied-raw-symbol-store))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "Load" raw-assembly))
    ((cl:and (cl:stringp raw-assembly) (cl:not supplied-raw-symbol-store))
     (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "Load" raw-assembly))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-APP-DOMAIN"
                    :class-name <type-str>
                    :method-name "Load"
                    :supplied-args (cl:append (cl:list :raw-assembly raw-assembly) (cl:when supplied-raw-symbol-store (cl:list :raw-symbol-store raw-symbol-store)))))))

(cl:defun reflection-only-get-assemblies (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "ReflectionOnlyGetAssemblies"))

(cl:defun set-cache-path (obj! path)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "SetCachePath" path))

(cl:defun set-data (obj! name data)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "SetData" name data))

(cl:defun set-dynamic-base (obj! path)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "SetDynamicBase" path))

(cl:defun set-principal-policy (obj! policy)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "SetPrincipalPolicy" policy))

(cl:defun set-shadow-copy-files (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "SetShadowCopyFiles"))

(cl:defun set-shadow-copy-path (obj! path)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "SetShadowCopyPath" path))

(cl:defun set-thread-principal (obj! principal)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "SetThreadPrincipal" principal))

(cl:defun to-string (obj!)
  (dotnet:invoke (cl:the (dotnet "System.AppDomain") obj!) "ToString"))

(cl:defun unload (domain)
  (dotnet:static <type-str> "Unload" (cl:the (dotnet "System.AppDomain") domain)))

