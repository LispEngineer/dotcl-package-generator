;;; Generated automatically. Do not edit.
;;; Class: System.Globalization.CultureInfo
;;; Generator Version: 39
;;; Creation Date: 2026-07-06T00:55:09Z

(cl:in-package :system-globalization-culture-info)

(cl:defconstant <type> (dotnet:resolve-type "System.Globalization.CultureInfo"))
(cl:defconstant <type-str> "System.Globalization.CultureInfo")
(cl:defconstant <creation> "2026-07-06T00:55:09Z")
(cl:defconstant <version> 39)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Globalization.CultureInfo")))

(cl:defun new (name cl:&optional (use-user-override cl:nil supplied-use-user-override))
  "Master wrapper for System.Globalization.CultureInfo constructor overloads. Dispatches at runtime.

new(String)

new(Int32)

new(String, Boolean)

new(Int32, Boolean)
"
  (cl:cond
    ((cl:and (cl:stringp name) supplied-use-user-override (cl:typep use-user-override 'cl:boolean))
     (dotnet:new <type-str> name use-user-override))
    ((cl:and (cl:numberp name) supplied-use-user-override (cl:typep use-user-override 'cl:boolean))
     (dotnet:new <type-str> name use-user-override))
    ((cl:and (cl:stringp name) (cl:not supplied-use-user-override))
     (dotnet:new <type-str> name))
    ((cl:and (cl:numberp name) (cl:not supplied-use-user-override))
     (dotnet:new <type-str> name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-GLOBALIZATION-CULTURE-INFO"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:list :name name) (cl:when supplied-use-user-override (cl:list :use-user-override use-user-override)))))))

(cl:define-symbol-macro installed-ui-culture (dotnet:static <type-str> "InstalledUICulture"))

(cl:define-symbol-macro invariant-culture (dotnet:static <type-str> "InvariantCulture"))

(cl:defun current-culture ()
  (dotnet:static <type-str> "CurrentCulture"))

(cl:defun (cl:setf current-culture) (new-value)
  (cl:setf (dotnet:static <type-str> "CurrentCulture") new-value))

(cl:defun current-ui-culture ()
  (dotnet:static <type-str> "CurrentUICulture"))

(cl:defun (cl:setf current-ui-culture) (new-value)
  (cl:setf (dotnet:static <type-str> "CurrentUICulture") new-value))

(cl:defun default-thread-current-culture ()
  (dotnet:static <type-str> "DefaultThreadCurrentCulture"))

(cl:defun (cl:setf default-thread-current-culture) (new-value)
  (cl:setf (dotnet:static <type-str> "DefaultThreadCurrentCulture") new-value))

(cl:defun default-thread-current-ui-culture ()
  (dotnet:static <type-str> "DefaultThreadCurrentUICulture"))

(cl:defun (cl:setf default-thread-current-ui-culture) (new-value)
  (cl:setf (dotnet:static <type-str> "DefaultThreadCurrentUICulture") new-value))

(cl:defun calendar (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_Calendar"))

(cl:defun compare-info (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_CompareInfo"))

(cl:defun culture-types (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_CultureTypes"))

(cl:defun date-time-format (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_DateTimeFormat"))

(cl:defun (cl:setf date-time-format) (new-value obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "set_DateTimeFormat" new-value))

(cl:defun display-name (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_DisplayName"))

(cl:defun english-name (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_EnglishName"))

(cl:defun ietf-language-tag (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_IetfLanguageTag"))

(cl:defun neutral-culture? (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_IsNeutralCulture"))

(cl:defun read-only? (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_IsReadOnly"))

(cl:defun keyboard-layout-id (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_KeyboardLayoutId"))

(cl:defun lcid (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_LCID"))

(cl:defun name (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_Name"))

(cl:defun native-name (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_NativeName"))

(cl:defun number-format (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_NumberFormat"))

(cl:defun (cl:setf number-format) (new-value obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "set_NumberFormat" new-value))

(cl:defun optional-calendars (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_OptionalCalendars"))

(cl:defun parent (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_Parent"))

(cl:defun text-info (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_TextInfo"))

(cl:defun three-letter-iso-language-name (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_ThreeLetterISOLanguageName"))

(cl:defun three-letter-windows-language-name (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_ThreeLetterWindowsLanguageName"))

(cl:defun two-letter-iso-language-name (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_TwoLetterISOLanguageName"))

(cl:defun use-user-override (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "get_UseUserOverride"))

(cl:defun clear-cached-data (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "ClearCachedData"))

(cl:defun clone (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "Clone"))

(cl:defun create-specific-culture (name)
  (dotnet:static <type-str> "CreateSpecificCulture" (cl:the (dotnet "System.String") name)))

(cl:defun equals (obj! value)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "Equals" value))

(cl:defun get-console-fallback-ui-culture (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "GetConsoleFallbackUICulture"))

(cl:defun get-culture-info (culture cl:&optional (alt-name cl:nil supplied-alt-name))
  "Master wrapper for System.Globalization.CultureInfo.GetCultureInfo overloads. Dispatches at runtime.

GetCultureInfo(Int32) -> CultureInfo

GetCultureInfo(String) -> CultureInfo

GetCultureInfo(String, String) -> CultureInfo

GetCultureInfo(String, Boolean) -> CultureInfo
"
  (cl:cond
    ((cl:and (cl:stringp culture) supplied-alt-name (cl:stringp alt-name))
     (dotnet:static <type-str> "GetCultureInfo" culture alt-name))
    ((cl:and (cl:stringp culture) supplied-alt-name (cl:typep alt-name 'cl:boolean))
     (dotnet:static <type-str> "GetCultureInfo" culture alt-name))
    ((cl:and (cl:numberp culture) (cl:not supplied-alt-name))
     (dotnet:static <type-str> "GetCultureInfo" culture))
    ((cl:and (cl:stringp culture) (cl:not supplied-alt-name))
     (dotnet:static <type-str> "GetCultureInfo" culture))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-GLOBALIZATION-CULTURE-INFO"
                    :class-name <type-str>
                    :method-name "GetCultureInfo"
                    :supplied-args (cl:append (cl:list :culture culture) (cl:when supplied-alt-name (cl:list :alt-name alt-name)))))))

(cl:defun get-culture-info-by-ietf-language-tag (name)
  (dotnet:static <type-str> "GetCultureInfoByIetfLanguageTag" (cl:the (dotnet "System.String") name)))

(cl:defun get-cultures (types)
  (dotnet:static <type-str> "GetCultures" (cl:the (dotnet "System.Globalization.CultureTypes") types)))

(cl:defun get-format (obj! format-type)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "GetFormat" format-type))

(cl:defun get-hash-code (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "GetHashCode"))

(cl:defun read-only (ci)
  (dotnet:static <type-str> "ReadOnly" (cl:the (dotnet "System.Globalization.CultureInfo") ci)))

(cl:defun to-string (obj!)
  (dotnet:invoke (cl:the (dotnet "System.Globalization.CultureInfo") obj!) "ToString"))

