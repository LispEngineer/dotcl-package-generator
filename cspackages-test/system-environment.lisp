;;; Generated automatically. Do not edit.
;;; Class: System.Environment
;;; Generator Version: 42
;;; Creation Date: 2026-07-11T12:55:15Z

(cl:in-package :system-environment)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Environment"))
(cl:defconstant <type-str> "System.Environment")
(cl:defconstant <creation> "2026-07-11T12:55:15Z")
(cl:defconstant <version> 42)

;; Register C# Type with CLOS
(cl:eval-when (:load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Environment")))

(cl:define-symbol-macro command-line (dotnet:static <type-str> "CommandLine"))

(cl:define-symbol-macro cpu-usage (dotnet:static <type-str> "CpuUsage"))

(cl:define-symbol-macro current-managed-thread-id (dotnet:static <type-str> "CurrentManagedThreadId"))

(cl:define-symbol-macro has-shutdown-started (dotnet:static <type-str> "HasShutdownStarted"))

(cl:define-symbol-macro is64-bit-operating-system (dotnet:static <type-str> "Is64BitOperatingSystem"))

(cl:define-symbol-macro is64-bit-process (dotnet:static <type-str> "Is64BitProcess"))

(cl:define-symbol-macro privileged-process? (dotnet:static <type-str> "IsPrivilegedProcess"))

(cl:define-symbol-macro machine-name (dotnet:static <type-str> "MachineName"))

(cl:define-symbol-macro new-line (dotnet:static <type-str> "NewLine"))

(cl:define-symbol-macro os-version (dotnet:static <type-str> "OSVersion"))

(cl:define-symbol-macro process-id (dotnet:static <type-str> "ProcessId"))

(cl:define-symbol-macro processor-count (dotnet:static <type-str> "ProcessorCount"))

(cl:define-symbol-macro process-path (dotnet:static <type-str> "ProcessPath"))

(cl:define-symbol-macro stack-trace (dotnet:static <type-str> "StackTrace"))

(cl:define-symbol-macro system-directory (dotnet:static <type-str> "SystemDirectory"))

(cl:define-symbol-macro system-page-size (dotnet:static <type-str> "SystemPageSize"))

(cl:define-symbol-macro tick-count (dotnet:static <type-str> "TickCount"))

(cl:define-symbol-macro tick-count64 (dotnet:static <type-str> "TickCount64"))

(cl:define-symbol-macro user-domain-name (dotnet:static <type-str> "UserDomainName"))

(cl:define-symbol-macro user-interactive (dotnet:static <type-str> "UserInteractive"))

(cl:define-symbol-macro user-name (dotnet:static <type-str> "UserName"))

(cl:define-symbol-macro version (dotnet:static <type-str> "Version"))

(cl:define-symbol-macro working-set (dotnet:static <type-str> "WorkingSet"))

(cl:defun current-directory ()
  (dotnet:static <type-str> "CurrentDirectory"))

(cl:defun (cl:setf current-directory) (new-value)
  (cl:setf (dotnet:static <type-str> "CurrentDirectory") new-value))

(cl:defun exit-code ()
  (dotnet:static <type-str> "ExitCode"))

(cl:defun (cl:setf exit-code) (new-value)
  (cl:setf (dotnet:static <type-str> "ExitCode") new-value))

(cl:defun exit (exit-code)
  (dotnet:static <type-str> "Exit" (cl:the (dotnet "System.Int32") exit-code)))

(cl:defun expand-environment-variables (name)
  (dotnet:static <type-str> "ExpandEnvironmentVariables" (cl:the (dotnet "System.String") name)))

(cl:defun fail-fast (message cl:&optional (exception cl:nil supplied-exception))
  "Master wrapper for System.Environment.FailFast overloads. Dispatches at runtime.

FailFast(String) -> Void

FailFast(String, Exception) -> Void
"
  (cl:cond
    ((cl:and (cl:stringp message) supplied-exception (cl:or (cl:null exception) (dotnet:object-type exception)))
     (dotnet:static <type-str> "FailFast" message exception))
    ((cl:and (cl:stringp message) (cl:not supplied-exception))
     (dotnet:static <type-str> "FailFast" message))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ENVIRONMENT"
                    :class-name <type-str>
                    :method-name "FailFast"
                    :supplied-args (cl:append (cl:list :message message) (cl:when supplied-exception (cl:list :exception exception)))))))

(cl:defun get-command-line-args ()
  (dotnet:static <type-str> "GetCommandLineArgs"))

(cl:defun get-environment-variable (variable cl:&optional (target cl:nil supplied-target))
  "Master wrapper for System.Environment.GetEnvironmentVariable overloads. Dispatches at runtime.

GetEnvironmentVariable(String) -> String

GetEnvironmentVariable(String, EnvironmentVariableTarget) -> String
"
  (cl:cond
    ((cl:and (cl:stringp variable) supplied-target (cl:or (cl:null target) (dotnet:object-type target)))
     (dotnet:static <type-str> "GetEnvironmentVariable" variable target))
    ((cl:and (cl:stringp variable) (cl:not supplied-target))
     (dotnet:static <type-str> "GetEnvironmentVariable" variable))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ENVIRONMENT"
                    :class-name <type-str>
                    :method-name "GetEnvironmentVariable"
                    :supplied-args (cl:append (cl:list :variable variable) (cl:when supplied-target (cl:list :target target)))))))

(cl:defun get-environment-variables (cl:&optional (target cl:nil supplied-target))
  "Master wrapper for System.Environment.GetEnvironmentVariables overloads. Dispatches at runtime.

GetEnvironmentVariables() -> IDictionary

GetEnvironmentVariables(EnvironmentVariableTarget) -> IDictionary
"
  (cl:cond
    ((cl:and supplied-target (cl:or (cl:null target) (dotnet:object-type target)))
     (dotnet:static <type-str> "GetEnvironmentVariables" target))
    ((cl:and (cl:not supplied-target))
     (dotnet:static <type-str> "GetEnvironmentVariables"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ENVIRONMENT"
                    :class-name <type-str>
                    :method-name "GetEnvironmentVariables"
                    :supplied-args (cl:append (cl:when supplied-target (cl:list :target target)))))))

(cl:defun get-folder-path (folder cl:&optional (option cl:nil supplied-option))
  "Master wrapper for System.Environment.GetFolderPath overloads. Dispatches at runtime.

GetFolderPath(Environment+SpecialFolder) -> String

GetFolderPath(Environment+SpecialFolder, Environment+SpecialFolderOption) -> String
"
  (cl:cond
    ((cl:and (cl:or (cl:null folder) (dotnet:object-type folder)) supplied-option (cl:or (cl:null option) (dotnet:object-type option)))
     (dotnet:static <type-str> "GetFolderPath" folder option))
    ((cl:and (cl:or (cl:null folder) (dotnet:object-type folder)) (cl:not supplied-option))
     (dotnet:static <type-str> "GetFolderPath" folder))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ENVIRONMENT"
                    :class-name <type-str>
                    :method-name "GetFolderPath"
                    :supplied-args (cl:append (cl:list :folder folder) (cl:when supplied-option (cl:list :option option)))))))

(cl:defun get-logical-drives ()
  (dotnet:static <type-str> "GetLogicalDrives"))

(cl:defun set-environment-variable (variable value cl:&optional (target cl:nil supplied-target))
  "Master wrapper for System.Environment.SetEnvironmentVariable overloads. Dispatches at runtime.

SetEnvironmentVariable(String, String) -> Void

SetEnvironmentVariable(String, String, EnvironmentVariableTarget) -> Void
"
  (cl:cond
    ((cl:and (cl:stringp variable) (cl:stringp value) supplied-target (cl:or (cl:null target) (dotnet:object-type target)))
     (dotnet:static <type-str> "SetEnvironmentVariable" variable value target))
    ((cl:and (cl:stringp variable) (cl:stringp value) (cl:not supplied-target))
     (dotnet:static <type-str> "SetEnvironmentVariable" variable value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-ENVIRONMENT"
                    :class-name <type-str>
                    :method-name "SetEnvironmentVariable"
                    :supplied-args (cl:append (cl:list :variable variable) (cl:list :value value) (cl:when supplied-target (cl:list :target target)))))))

