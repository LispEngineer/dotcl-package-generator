;;; Generated automatically. Do not edit.
;;; Class: System.TimeZoneInfo+AdjustmentRule
;;; Generator Version: 28
;;; Creation Date: 2026-07-04T03:03:10Z

(cl:in-package :system-time-zone-info-adjustment-rule)

(cl:defconstant <type> (dotnet:resolve-type "System.TimeZoneInfo+AdjustmentRule"))
(cl:defconstant <type-str> "System.TimeZoneInfo+AdjustmentRule")
(cl:defconstant <creation> "2026-07-04T03:03:10Z")
(cl:defconstant <version> 28)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.TimeZoneInfo+AdjustmentRule")))

(cl:defun base-utc-offset-delta (obj!)
  "Gets the time difference with the base UTC offset for the time zone during the adjustment-rule period."
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo+AdjustmentRule") obj!) "get_BaseUtcOffsetDelta"))

(cl:defun date-end (obj!)
  "Gets the date when the adjustment rule ceases to be in effect."
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo+AdjustmentRule") obj!) "get_DateEnd"))

(cl:defun date-start (obj!)
  "Gets the date when the adjustment rule takes effect."
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo+AdjustmentRule") obj!) "get_DateStart"))

(cl:defun daylight-delta (obj!)
  "Gets the amount of time that is required to form the time zone's daylight saving time. This amount of time is added to the time zone's offset from Coordinated Universal Time (UTC)."
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo+AdjustmentRule") obj!) "get_DaylightDelta"))

(cl:defun daylight-transition-end (obj!)
  "Gets information about the annual transition from daylight saving time back to standard time."
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo+AdjustmentRule") obj!) "get_DaylightTransitionEnd"))

(cl:defun daylight-transition-start (obj!)
  "Gets information about the annual transition from standard time to daylight saving time."
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo+AdjustmentRule") obj!) "get_DaylightTransitionStart"))

(cl:defun create-adjustment-rule (date-start date-end daylight-delta daylight-transition-start daylight-transition-end cl:&optional (base-utc-offset-delta cl:nil supplied-base-utc-offset-delta))
  "Master wrapper for System.TimeZoneInfo+AdjustmentRule.CreateAdjustmentRule overloads. Dispatches at runtime.

CreateAdjustmentRule(DateTime, DateTime, TimeSpan, TimeZoneInfo+TransitionTime, TimeZoneInfo+TransitionTime) -> TimeZoneInfo+AdjustmentRule
  Summary: Creates a new adjustment rule for a particular time zone.
  Returns: An object that represents the new adjustment rule.
  Parameters:
    - date-start (System.DateTime): The effective date of the adjustment rule. If the value of the dateStart parameter is , this is the first adjustment rule in effect for a time zone.
    - date-end (System.DateTime): The last date that the adjustment rule is in force. If the value of the dateEnd parameter is , the adjustment rule has no end date.
    - daylight-delta (System.TimeSpan): The time change that results from the adjustment. This value is added to the time zone's System.TimeZoneInfo.BaseUtcOffset property to obtain the correct daylight offset from Coordinated Universal Time (UTC). This value can range from -14 to 14.
    - daylight-transition-start (System.TimeZoneInfo+TransitionTime): An object that defines the start of daylight saving time.
    - daylight-transition-end (System.TimeZoneInfo+TransitionTime): An object that defines the end of daylight saving time.

CreateAdjustmentRule(DateTime, DateTime, TimeSpan, TimeZoneInfo+TransitionTime, TimeZoneInfo+TransitionTime, TimeSpan) -> TimeZoneInfo+AdjustmentRule
  Summary: Creates a new adjustment rule for a particular time zone.
  Returns: The new adjustment rule.
  Parameters:
    - date-start (System.DateTime): The effective date of the adjustment rule. If the value is DateTime.MinValue.Date, this is the first adjustment rule in effect for a time zone.
    - date-end (System.DateTime): The last date that the adjustment rule is in force. If the value is DateTime.MaxValue.Date, the adjustment rule has no end date.
    - daylight-delta (System.TimeSpan): The time change that results from the adjustment. This value is added to the time zone's System.TimeZoneInfo.BaseUtcOffset and System.TimeZoneInfo.AdjustmentRule.BaseUtcOffsetDelta properties to obtain the correct daylight offset from Coordinated Universal Time (UTC). This value can range from -14 to 14.
    - daylight-transition-start (System.TimeZoneInfo+TransitionTime): The start of daylight saving time.
    - daylight-transition-end (System.TimeZoneInfo+TransitionTime): The end of daylight saving time.
    - base-utc-offset-delta (System.TimeSpan): The time difference with the base UTC offset for the time zone during the adjustment-rule period.
"
  (cl:cond
    ((cl:and (cl:or (cl:null date-start) (dotnet:object-type date-start)) (cl:or (cl:null date-end) (dotnet:object-type date-end)) (cl:or (cl:null daylight-delta) (dotnet:object-type daylight-delta)) (cl:or (cl:null daylight-transition-start) (dotnet:object-type daylight-transition-start)) (cl:or (cl:null daylight-transition-end) (dotnet:object-type daylight-transition-end)) supplied-base-utc-offset-delta (cl:or (cl:null base-utc-offset-delta) (dotnet:object-type base-utc-offset-delta)))
     (dotnet:static <type-str> "CreateAdjustmentRule" date-start date-end daylight-delta daylight-transition-start daylight-transition-end base-utc-offset-delta))
    ((cl:and (cl:or (cl:null date-start) (dotnet:object-type date-start)) (cl:or (cl:null date-end) (dotnet:object-type date-end)) (cl:or (cl:null daylight-delta) (dotnet:object-type daylight-delta)) (cl:or (cl:null daylight-transition-start) (dotnet:object-type daylight-transition-start)) (cl:or (cl:null daylight-transition-end) (dotnet:object-type daylight-transition-end)) (cl:not supplied-base-utc-offset-delta))
     (dotnet:static <type-str> "CreateAdjustmentRule" date-start date-end daylight-delta daylight-transition-start daylight-transition-end))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-ZONE-INFO-ADJUSTMENT-RULE"
                    :class-name <type-str>
                    :method-name "CreateAdjustmentRule"
                    :supplied-args (cl:append (cl:list :date-start date-start) (cl:list :date-end date-end) (cl:list :daylight-delta daylight-delta) (cl:list :daylight-transition-start daylight-transition-start) (cl:list :daylight-transition-end daylight-transition-end) (cl:when supplied-base-utc-offset-delta (cl:list :base-utc-offset-delta base-utc-offset-delta)))))))

(cl:defun equals (obj! other)
  "Master wrapper for System.TimeZoneInfo+AdjustmentRule.Equals overloads. Dispatches at runtime.

Equals(TimeZoneInfo+AdjustmentRule) -> Boolean
  Summary: Determines whether the current System.TimeZoneInfo.AdjustmentRule object is equal to a second System.TimeZoneInfo.AdjustmentRule object.
  Returns: if both System.TimeZoneInfo.AdjustmentRule objects have equal values; otherwise, .
  Parameters:
    - other (System.TimeZoneInfo+AdjustmentRule): The object to compare with the current object.

Equals(Object) -> Boolean
  Summary: Indicates whether the current instance is equal to another instance.
  Returns: if the current instance is equal to the other instance; otherwise, .
  Parameters:
    - obj (System.Object): An instance to compare with this instance.
"
  (cl:cond
    ((cl:and (cl:or (cl:null other) (dotnet:object-type other)))
     (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo+AdjustmentRule") obj!) "Equals" other))
    ((cl:and (cl:or (cl:null other) (dotnet:object-type other)))
     (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo+AdjustmentRule") obj!) "Equals" other))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-ZONE-INFO-ADJUSTMENT-RULE"
                    :class-name <type-str>
                    :method-name "Equals"
                    :supplied-args (cl:append (cl:list :other other))))))

(cl:defun get-hash-code (obj!)
  "Summary: Serves as a hash function for hashing algorithms and data structures such as hash tables.
Returns: A 32-bit signed integer that serves as the hash code for the current System.TimeZoneInfo.AdjustmentRule object.
"
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo+AdjustmentRule") obj!) "GetHashCode"))

