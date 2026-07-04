;;; Generated automatically. Do not edit.
;;; Class: System.Diagnostics.Debug
;;; Generator Version: 31
;;; Creation Date: 2026-07-04T16:50:34Z

(cl:in-package :system-diagnostics-debug)

(cl:defconstant <type> (dotnet:resolve-type "System.Diagnostics.Debug"))
(cl:defconstant <type-str> "System.Diagnostics.Debug")
(cl:defconstant <creation> "2026-07-04T16:50:34Z")
(cl:defconstant <version> 31)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Diagnostics.Debug")))

(cl:defun auto-flush ()
  (dotnet:static <type-str> "AutoFlush"))

(cl:defun (cl:setf auto-flush) (new-value)
  (cl:setf (dotnet:static <type-str> "AutoFlush") new-value))

(cl:defun indent-level ()
  (dotnet:static <type-str> "IndentLevel"))

(cl:defun (cl:setf indent-level) (new-value)
  (cl:setf (dotnet:static <type-str> "IndentLevel") new-value))

(cl:defun indent-size ()
  (dotnet:static <type-str> "IndentSize"))

(cl:defun (cl:setf indent-size) (new-value)
  (cl:setf (dotnet:static <type-str> "IndentSize") new-value))

(cl:defun assert (condition cl:&optional (message cl:nil supplied-message) (detail-message cl:nil supplied-detail-message))
  "Master wrapper for System.Diagnostics.Debug.Assert overloads. Dispatches at runtime.

Assert(Boolean) -> Void

Assert(Boolean, String) -> Void

Assert(Boolean, String, String) -> Void
"
  (cl:cond
    ((cl:and (cl:typep condition 'cl:boolean) supplied-message (cl:stringp message) supplied-detail-message (cl:stringp detail-message))
     (dotnet:static <type-str> "Assert" condition message detail-message))
    ((cl:and (cl:typep condition 'cl:boolean) supplied-message (cl:stringp message) (cl:not supplied-detail-message))
     (dotnet:static <type-str> "Assert" condition message))
    ((cl:and (cl:typep condition 'cl:boolean) (cl:not supplied-message) (cl:not supplied-detail-message))
     (dotnet:static <type-str> "Assert" condition))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-DIAGNOSTICS-DEBUG"
                    :class-name <type-str>
                    :method-name "Assert"
                    :supplied-args (cl:append (cl:list :condition condition) (cl:when supplied-message (cl:list :message message)) (cl:when supplied-detail-message (cl:list :detail-message detail-message)))))))

;; Note: System.Diagnostics.Debug.Assert also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   Assert(Boolean, String) -> Void
;;   Assert(Boolean, ref Debug+AssertInterpolatedStringHandler&) -> Void
;;   Assert(Boolean, ref Debug+AssertInterpolatedStringHandler&, ref Debug+AssertInterpolatedStringHandler&) -> Void
;;   Assert(Boolean, String, String, params Object[]) -> Void

(cl:defun close ()
  (dotnet:static <type-str> "Close"))

(cl:defun fail (message cl:&optional (detail-message cl:nil supplied-detail-message))
  "Master wrapper for System.Diagnostics.Debug.Fail overloads. Dispatches at runtime.

Fail(String) -> Void

Fail(String, String) -> Void
"
  (cl:cond
    ((cl:and (cl:stringp message) supplied-detail-message (cl:stringp detail-message))
     (dotnet:static <type-str> "Fail" message detail-message))
    ((cl:and (cl:stringp message) (cl:not supplied-detail-message))
     (dotnet:static <type-str> "Fail" message))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-DIAGNOSTICS-DEBUG"
                    :class-name <type-str>
                    :method-name "Fail"
                    :supplied-args (cl:append (cl:list :message message) (cl:when supplied-detail-message (cl:list :detail-message detail-message)))))))

(cl:defun flush ()
  (dotnet:static <type-str> "Flush"))

(cl:defun indent ()
  (dotnet:static <type-str> "Indent"))

(cl:defun print (message)
  (dotnet:static <type-str> "Print" (cl:the (dotnet "System.String") message)))

;; Note: System.Diagnostics.Debug.Print also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   Print(String, params Object[]) -> Void

(cl:defun set-provider (provider)
  (dotnet:static <type-str> "SetProvider" (cl:the (dotnet "System.Diagnostics.DebugProvider") provider)))

(cl:defun unindent ()
  (dotnet:static <type-str> "Unindent"))

(cl:defun write (message cl:&optional (category cl:nil supplied-category))
  "Master wrapper for System.Diagnostics.Debug.Write overloads. Dispatches at runtime.

Write(String) -> Void

Write(Object) -> Void

Write(String, String) -> Void

Write(Object, String) -> Void
"
  (cl:cond
    ((cl:and (cl:stringp message) supplied-category (cl:stringp category))
     (dotnet:static <type-str> "Write" message category))
    ((cl:and (cl:or (cl:null message) (dotnet:object-type message)) supplied-category (cl:stringp category))
     (dotnet:static <type-str> "Write" message category))
    ((cl:and (cl:stringp message) (cl:not supplied-category))
     (dotnet:static <type-str> "Write" message))
    ((cl:and (cl:or (cl:null message) (dotnet:object-type message)) (cl:not supplied-category))
     (dotnet:static <type-str> "Write" message))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-DIAGNOSTICS-DEBUG"
                    :class-name <type-str>
                    :method-name "Write"
                    :supplied-args (cl:append (cl:list :message message) (cl:when supplied-category (cl:list :category category)))))))

(cl:defun write-if (condition message cl:&optional (category cl:nil supplied-category))
  "Master wrapper for System.Diagnostics.Debug.WriteIf overloads. Dispatches at runtime.

WriteIf(Boolean, String) -> Void

WriteIf(Boolean, Object) -> Void

WriteIf(Boolean, String, String) -> Void

WriteIf(Boolean, Object, String) -> Void
"
  (cl:cond
    ((cl:and (cl:typep condition 'cl:boolean) (cl:stringp message) supplied-category (cl:stringp category))
     (dotnet:static <type-str> "WriteIf" condition message category))
    ((cl:and (cl:typep condition 'cl:boolean) (cl:or (cl:null message) (dotnet:object-type message)) supplied-category (cl:stringp category))
     (dotnet:static <type-str> "WriteIf" condition message category))
    ((cl:and (cl:typep condition 'cl:boolean) (cl:stringp message) (cl:not supplied-category))
     (dotnet:static <type-str> "WriteIf" condition message))
    ((cl:and (cl:typep condition 'cl:boolean) (cl:or (cl:null message) (dotnet:object-type message)) (cl:not supplied-category))
     (dotnet:static <type-str> "WriteIf" condition message))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-DIAGNOSTICS-DEBUG"
                    :class-name <type-str>
                    :method-name "WriteIf"
                    :supplied-args (cl:append (cl:list :condition condition) (cl:list :message message) (cl:when supplied-category (cl:list :category category)))))))

;; Note: System.Diagnostics.Debug.WriteIf also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   WriteIf(Boolean, ref Debug+WriteIfInterpolatedStringHandler&) -> Void
;;   WriteIf(Boolean, ref Debug+WriteIfInterpolatedStringHandler&, String) -> Void

(cl:defun write-line (message cl:&optional (category cl:nil supplied-category))
  "Master wrapper for System.Diagnostics.Debug.WriteLine overloads. Dispatches at runtime.

WriteLine(String) -> Void

WriteLine(Object) -> Void

WriteLine(Object, String) -> Void

WriteLine(String, String) -> Void
"
  (cl:cond
    ((cl:and (cl:or (cl:null message) (dotnet:object-type message)) supplied-category (cl:stringp category))
     (dotnet:static <type-str> "WriteLine" message category))
    ((cl:and (cl:stringp message) supplied-category (cl:stringp category))
     (dotnet:static <type-str> "WriteLine" message category))
    ((cl:and (cl:stringp message) (cl:not supplied-category))
     (dotnet:static <type-str> "WriteLine" message))
    ((cl:and (cl:or (cl:null message) (dotnet:object-type message)) (cl:not supplied-category))
     (dotnet:static <type-str> "WriteLine" message))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-DIAGNOSTICS-DEBUG"
                    :class-name <type-str>
                    :method-name "WriteLine"
                    :supplied-args (cl:append (cl:list :message message) (cl:when supplied-category (cl:list :category category)))))))

;; Note: System.Diagnostics.Debug.WriteLine also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   WriteLine(String, params Object[]) -> Void

(cl:defun write-line-if (condition value cl:&optional (category cl:nil supplied-category))
  "Master wrapper for System.Diagnostics.Debug.WriteLineIf overloads. Dispatches at runtime.

WriteLineIf(Boolean, Object) -> Void

WriteLineIf(Boolean, String) -> Void

WriteLineIf(Boolean, Object, String) -> Void

WriteLineIf(Boolean, String, String) -> Void
"
  (cl:cond
    ((cl:and (cl:typep condition 'cl:boolean) (cl:or (cl:null value) (dotnet:object-type value)) supplied-category (cl:stringp category))
     (dotnet:static <type-str> "WriteLineIf" condition value category))
    ((cl:and (cl:typep condition 'cl:boolean) (cl:stringp value) supplied-category (cl:stringp category))
     (dotnet:static <type-str> "WriteLineIf" condition value category))
    ((cl:and (cl:typep condition 'cl:boolean) (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-category))
     (dotnet:static <type-str> "WriteLineIf" condition value))
    ((cl:and (cl:typep condition 'cl:boolean) (cl:stringp value) (cl:not supplied-category))
     (dotnet:static <type-str> "WriteLineIf" condition value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-DIAGNOSTICS-DEBUG"
                    :class-name <type-str>
                    :method-name "WriteLineIf"
                    :supplied-args (cl:append (cl:list :condition condition) (cl:list :value value) (cl:when supplied-category (cl:list :category category)))))))

;; Note: System.Diagnostics.Debug.WriteLineIf also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   WriteLineIf(Boolean, ref Debug+WriteIfInterpolatedStringHandler&) -> Void
;;   WriteLineIf(Boolean, ref Debug+WriteIfInterpolatedStringHandler&, String) -> Void

