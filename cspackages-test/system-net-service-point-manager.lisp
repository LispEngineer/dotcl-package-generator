;;; Generated automatically. Do not edit.
;;; Class: System.Net.ServicePointManager
;;; Generator Version: 53
;;; Creation Date: 2026-07-19T16:02:09Z
;;; Options: (none)
;;; OBSOLETE: WebRequest, HttpWebRequest, ServicePoint, and WebClient are obsolete. Use HttpClient instead. Settings on ServicePointManager no longer affect SslStream or HttpClient.

(cl:in-package :system-net-service-point-manager)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Net.ServicePointManager"))
(cl:defconstant <type-str> "System.Net.ServicePointManager")
(cl:defconstant <creation> "2026-07-19T16:02:09Z")
(cl:defconstant <version> 53)

(cl:defvar %default-non-persistent-connection-limit-cache% csharp-assembly-utils:+unbound-marker+)
(cl:define-symbol-macro +default-non-persistent-connection-limit+
  (cl:if (cl:eq %default-non-persistent-connection-limit-cache% csharp-assembly-utils:+unbound-marker+)
      (cl:setf %default-non-persistent-connection-limit-cache% (dotnet:static <type-str> "DefaultNonPersistentConnectionLimit"))
      %default-non-persistent-connection-limit-cache%))

(cl:defvar %default-persistent-connection-limit-cache% csharp-assembly-utils:+unbound-marker+)
(cl:define-symbol-macro +default-persistent-connection-limit+
  (cl:if (cl:eq %default-persistent-connection-limit-cache% csharp-assembly-utils:+unbound-marker+)
      (cl:setf %default-persistent-connection-limit-cache% (dotnet:static <type-str> "DefaultPersistentConnectionLimit"))
      %default-persistent-connection-limit-cache%))

(cl:define-symbol-macro encryption-policy (dotnet:static <type-str> "EncryptionPolicy"))

(cl:defun check-certificate-revocation-list ()
  (dotnet:static <type-str> "CheckCertificateRevocationList"))

(cl:defun (cl:setf check-certificate-revocation-list) (new-value)
  (cl:setf (dotnet:static <type-str> "CheckCertificateRevocationList") new-value))

(cl:defun default-connection-limit ()
  (dotnet:static <type-str> "DefaultConnectionLimit"))

(cl:defun (cl:setf default-connection-limit) (new-value)
  (cl:setf (dotnet:static <type-str> "DefaultConnectionLimit") new-value))

(cl:defun dns-refresh-timeout ()
  (dotnet:static <type-str> "DnsRefreshTimeout"))

(cl:defun (cl:setf dns-refresh-timeout) (new-value)
  (cl:setf (dotnet:static <type-str> "DnsRefreshTimeout") new-value))

(cl:defun enable-dns-round-robin ()
  (dotnet:static <type-str> "EnableDnsRoundRobin"))

(cl:defun (cl:setf enable-dns-round-robin) (new-value)
  (cl:setf (dotnet:static <type-str> "EnableDnsRoundRobin") new-value))

(cl:defun expect100-continue ()
  (dotnet:static <type-str> "Expect100Continue"))

(cl:defun (cl:setf expect100-continue) (new-value)
  (cl:setf (dotnet:static <type-str> "Expect100Continue") new-value))

(cl:defun max-service-point-idle-time ()
  (dotnet:static <type-str> "MaxServicePointIdleTime"))

(cl:defun (cl:setf max-service-point-idle-time) (new-value)
  (cl:setf (dotnet:static <type-str> "MaxServicePointIdleTime") new-value))

(cl:defun max-service-points ()
  (dotnet:static <type-str> "MaxServicePoints"))

(cl:defun (cl:setf max-service-points) (new-value)
  (cl:setf (dotnet:static <type-str> "MaxServicePoints") new-value))

(cl:defun reuse-port ()
  (dotnet:static <type-str> "ReusePort"))

(cl:defun (cl:setf reuse-port) (new-value)
  (cl:setf (dotnet:static <type-str> "ReusePort") new-value))

(cl:defun security-protocol ()
  (dotnet:static <type-str> "SecurityProtocol"))

(cl:defun (cl:setf security-protocol) (new-value)
  (cl:setf (dotnet:static <type-str> "SecurityProtocol") new-value))

(cl:defun server-certificate-validation-callback ()
  (dotnet:static <type-str> "ServerCertificateValidationCallback"))

(cl:defun (cl:setf server-certificate-validation-callback) (new-value)
  (cl:setf (dotnet:static <type-str> "ServerCertificateValidationCallback") new-value))

(cl:defun use-nagle-algorithm ()
  (dotnet:static <type-str> "UseNagleAlgorithm"))

(cl:defun (cl:setf use-nagle-algorithm) (new-value)
  (cl:setf (dotnet:static <type-str> "UseNagleAlgorithm") new-value))

(cl:defun find-service-point (address cl:&optional (proxy cl:nil supplied-proxy))
  "Master wrapper for System.Net.ServicePointManager.FindServicePoint overloads. Dispatches at runtime.

FindServicePoint(Uri) -> ServicePoint

FindServicePoint(String, IWebProxy) -> ServicePoint

FindServicePoint(Uri, IWebProxy) -> ServicePoint
"
  (cl:cond
    ((cl:and (cl:stringp address) supplied-proxy (cl:or (cl:null proxy) (dotnet:is-instance-of proxy "System.Net.IWebProxy")))
     (dotnet:static <type-str> "FindServicePoint" address proxy))
    ((cl:and (cl:or (cl:null address) (dotnet:is-instance-of address "System.Uri")) supplied-proxy (cl:or (cl:null proxy) (dotnet:is-instance-of proxy "System.Net.IWebProxy")))
     (dotnet:static <type-str> "FindServicePoint" address proxy))
    ((cl:and (cl:or (cl:null address) (dotnet:is-instance-of address "System.Uri")) (cl:not supplied-proxy))
     (dotnet:static <type-str> "FindServicePoint" address))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NET-SERVICE-POINT-MANAGER"
                    :class-name <type-str>
                    :method-name "FindServicePoint"
                    :supplied-args (cl:append (cl:list :address address) (cl:when supplied-proxy (cl:list :proxy proxy)))))))

(cl:defun set-tcp-keep-alive (enabled keep-alive-time keep-alive-interval)
  (dotnet:static <type-str> "SetTcpKeepAlive" (cl:the (dotnet "System.Boolean") enabled) (cl:the (dotnet "System.Int32") keep-alive-time) (cl:the (dotnet "System.Int32") keep-alive-interval)))

