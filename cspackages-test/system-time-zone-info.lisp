;;; Generated automatically. Do not edit.
;;; Class: System.TimeZoneInfo
;;; Generator Version: 40
;;; Creation Date: 2026-07-07T01:02:29Z

(cl:in-package :system-time-zone-info)

(cl:defconstant <type> (dotnet:resolve-type "System.TimeZoneInfo"))
(cl:defconstant <type-str> "System.TimeZoneInfo")
(cl:defconstant <creation> "2026-07-07T01:02:29Z")
(cl:defconstant <version> 40)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.TimeZoneInfo")))

(cl:define-symbol-macro local (dotnet:static <type-str> "Local"))
(cl:setf (cl:documentation (cl:quote local) (cl:quote cl:variable)) "Gets a System.TimeZoneInfo object that represents the local time zone.")

(cl:define-symbol-macro utc (dotnet:static <type-str> "Utc"))
(cl:setf (cl:documentation (cl:quote utc) (cl:quote cl:variable)) "Gets a System.TimeZoneInfo object that represents the Coordinated Universal Time (UTC) zone.")

(cl:defun base-utc-offset (obj!)
  "Gets the time difference between the current time zone's standard time and Coordinated Universal Time (UTC)."
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "get_BaseUtcOffset"))

(cl:defun daylight-name (obj!)
  "Gets the display name for the current time zone's daylight saving time."
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "get_DaylightName"))

(cl:defun display-name (obj!)
  "Gets the general display name that represents the time zone."
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "get_DisplayName"))

(cl:defun has-iana-id (obj!)
  "Returns if this TimeZoneInfo object has an IANA ID."
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "get_HasIanaId"))

(cl:defun id (obj!)
  "Gets the time zone identifier."
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "get_Id"))

(cl:defun standard-name (obj!)
  "Gets the display name for the time zone's standard time."
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "get_StandardName"))

(cl:defun supports-daylight-saving-time (obj!)
  "Gets a value indicating whether the time zone has any daylight saving time rules."
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "get_SupportsDaylightSavingTime"))

(cl:defun clear-cached-data ()
  "Summary: Clears cached time zone data.
"
  (dotnet:static <type-str> "ClearCachedData"))

(cl:defun convert-time (date-time-offset destination-time-zone cl:&optional (destination-time-zone2 cl:nil supplied-destination-time-zone2))
  "Master wrapper for System.TimeZoneInfo.ConvertTime overloads. Dispatches at runtime.

ConvertTime(DateTimeOffset, TimeZoneInfo) -> DateTimeOffset
  Summary: Converts a time to the time in a particular time zone.
  Returns: The date and time in the destination time zone.
  Parameters:
    - date-time-offset (System.DateTimeOffset): The date and time to convert.
    - destination-time-zone (System.TimeZoneInfo): The time zone to convert dateTimeOffset to.

ConvertTime(DateTime, TimeZoneInfo) -> DateTime
  Summary: Converts a time to the time in a particular time zone.
  Returns: The date and time in the destination time zone.
  Parameters:
    - date-time (System.DateTime): The date and time to convert.
    - destination-time-zone (System.TimeZoneInfo): The time zone to convert dateTime to.

ConvertTime(DateTime, TimeZoneInfo, TimeZoneInfo) -> DateTime
  Summary: Converts a time from one time zone to another.
  Returns: The date and time in the destination time zone that corresponds to the dateTime parameter in the source time zone.
  Parameters:
    - date-time (System.DateTime): The date and time to convert.
    - source-time-zone (System.TimeZoneInfo): The time zone of dateTime.
    - destination-time-zone (System.TimeZoneInfo): The time zone to convert dateTime to.
"
  (cl:cond
    ((cl:and (cl:or (cl:null date-time-offset) (dotnet:object-type date-time-offset)) (cl:or (cl:null destination-time-zone) (dotnet:object-type destination-time-zone)) supplied-destination-time-zone2 (cl:or (cl:null destination-time-zone2) (dotnet:object-type destination-time-zone2)))
     (dotnet:static <type-str> "ConvertTime" date-time-offset destination-time-zone destination-time-zone2))
    ((cl:and (cl:or (cl:null date-time-offset) (dotnet:object-type date-time-offset)) (cl:or (cl:null destination-time-zone) (dotnet:object-type destination-time-zone)) (cl:not supplied-destination-time-zone2))
     (dotnet:static <type-str> "ConvertTime" date-time-offset destination-time-zone))
    ((cl:and (cl:or (cl:null date-time-offset) (dotnet:object-type date-time-offset)) (cl:or (cl:null destination-time-zone) (dotnet:object-type destination-time-zone)) (cl:not supplied-destination-time-zone2))
     (dotnet:static <type-str> "ConvertTime" date-time-offset destination-time-zone))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-ZONE-INFO"
                    :class-name <type-str>
                    :method-name "ConvertTime"
                    :supplied-args (cl:append (cl:list :date-time-offset date-time-offset) (cl:list :destination-time-zone destination-time-zone) (cl:when supplied-destination-time-zone2 (cl:list :destination-time-zone2 destination-time-zone2)))))))

(cl:defun convert-time-by-system-time-zone-id (date-time-offset destination-time-zone-id cl:&optional (destination-time-zone-id2 cl:nil supplied-destination-time-zone-id2))
  "Master wrapper for System.TimeZoneInfo.ConvertTimeBySystemTimeZoneId overloads. Dispatches at runtime.

ConvertTimeBySystemTimeZoneId(DateTimeOffset, String) -> DateTimeOffset
  Summary: Converts a time to the time in another time zone based on the time zone's identifier.
  Returns: The date and time in the destination time zone.
  Parameters:
    - date-time-offset (System.DateTimeOffset): The date and time to convert.
    - destination-time-zone-id (System.String): The identifier of the destination time zone.

ConvertTimeBySystemTimeZoneId(DateTime, String) -> DateTime
  Summary: Converts a time to the time in another time zone based on the time zone's identifier.
  Returns: The date and time in the destination time zone.
  Parameters:
    - date-time (System.DateTime): The date and time to convert.
    - destination-time-zone-id (System.String): The identifier of the destination time zone.

ConvertTimeBySystemTimeZoneId(DateTime, String, String) -> DateTime
  Summary: Converts a time from one time zone to another based on time zone identifiers.
  Returns: The date and time in the destination time zone that corresponds to the dateTime parameter in the source time zone.
  Parameters:
    - date-time (System.DateTime): The date and time to convert.
    - source-time-zone-id (System.String): The identifier of the source time zone.
    - destination-time-zone-id (System.String): The identifier of the destination time zone.
"
  (cl:cond
    ((cl:and (cl:or (cl:null date-time-offset) (dotnet:object-type date-time-offset)) (cl:stringp destination-time-zone-id) supplied-destination-time-zone-id2 (cl:stringp destination-time-zone-id2))
     (dotnet:static <type-str> "ConvertTimeBySystemTimeZoneId" date-time-offset destination-time-zone-id destination-time-zone-id2))
    ((cl:and (cl:or (cl:null date-time-offset) (dotnet:object-type date-time-offset)) (cl:stringp destination-time-zone-id) (cl:not supplied-destination-time-zone-id2))
     (dotnet:static <type-str> "ConvertTimeBySystemTimeZoneId" date-time-offset destination-time-zone-id))
    ((cl:and (cl:or (cl:null date-time-offset) (dotnet:object-type date-time-offset)) (cl:stringp destination-time-zone-id) (cl:not supplied-destination-time-zone-id2))
     (dotnet:static <type-str> "ConvertTimeBySystemTimeZoneId" date-time-offset destination-time-zone-id))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-ZONE-INFO"
                    :class-name <type-str>
                    :method-name "ConvertTimeBySystemTimeZoneId"
                    :supplied-args (cl:append (cl:list :date-time-offset date-time-offset) (cl:list :destination-time-zone-id destination-time-zone-id) (cl:when supplied-destination-time-zone-id2 (cl:list :destination-time-zone-id2 destination-time-zone-id2)))))))

(cl:defun convert-time-from-utc (date-time destination-time-zone)
  "Summary: Converts a Coordinated Universal Time (UTC) to the time in a specified time zone.
Returns: The date and time in the destination time zone. Its System.DateTime.Kind property is System.DateTimeKind.Utc if destinationTimeZone is System.TimeZoneInfo.Utc; otherwise, its System.DateTime.Kind property is System.DateTimeKind.Unspecified.
Parameters:
  - date-time (System.DateTime): The Coordinated Universal Time (UTC).
  - destination-time-zone (System.TimeZoneInfo): The time zone to convert dateTime to.
"
  (dotnet:static <type-str> "ConvertTimeFromUtc" (cl:the (dotnet "System.DateTime") date-time) (cl:the (dotnet "System.TimeZoneInfo") destination-time-zone)))

(cl:defun convert-time-to-utc (date-time cl:&optional (source-time-zone cl:nil supplied-source-time-zone))
  "Master wrapper for System.TimeZoneInfo.ConvertTimeToUtc overloads. Dispatches at runtime.

ConvertTimeToUtc(DateTime) -> DateTime
  Summary: Converts the specified date and time to Coordinated Universal Time (UTC).
  Returns: The Coordinated Universal Time (UTC) that corresponds to the dateTime parameter. The System.DateTime value's System.DateTime.Kind property is always set to System.DateTimeKind.Utc.
  Parameters:
    - date-time (System.DateTime): The date and time to convert.

ConvertTimeToUtc(DateTime, TimeZoneInfo) -> DateTime
  Summary: Converts the time in a specified time zone to Coordinated Universal Time (UTC).
  Returns: The Coordinated Universal Time (UTC) that corresponds to the dateTime parameter. The System.DateTime object's System.DateTime.Kind property is always set to System.DateTimeKind.Utc.
  Parameters:
    - date-time (System.DateTime): The date and time to convert.
    - source-time-zone (System.TimeZoneInfo): The time zone of dateTime.
"
  (cl:cond
    ((cl:and (cl:or (cl:null date-time) (dotnet:object-type date-time)) supplied-source-time-zone (cl:or (cl:null source-time-zone) (dotnet:object-type source-time-zone)))
     (dotnet:static <type-str> "ConvertTimeToUtc" date-time source-time-zone))
    ((cl:and (cl:or (cl:null date-time) (dotnet:object-type date-time)) (cl:not supplied-source-time-zone))
     (dotnet:static <type-str> "ConvertTimeToUtc" date-time))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-ZONE-INFO"
                    :class-name <type-str>
                    :method-name "ConvertTimeToUtc"
                    :supplied-args (cl:append (cl:list :date-time date-time) (cl:when supplied-source-time-zone (cl:list :source-time-zone source-time-zone)))))))

(cl:defun create-custom-time-zone (id base-utc-offset display-name standard-display-name cl:&optional (daylight-display-name cl:nil supplied-daylight-display-name) (adjustment-rules cl:nil supplied-adjustment-rules) (disable-daylight-saving-time cl:nil supplied-disable-daylight-saving-time))
  "Master wrapper for System.TimeZoneInfo.CreateCustomTimeZone overloads. Dispatches at runtime.

CreateCustomTimeZone(String, TimeSpan, String, String) -> TimeZoneInfo
  Summary: Creates a custom time zone with a specified identifier, an offset from Coordinated Universal Time (UTC), a display name, and a standard time display name.
  Returns: The new time zone.
  Parameters:
    - id (System.String): The time zone's identifier.
    - base-utc-offset (System.TimeSpan): An object that represents the time difference between this time zone and Coordinated Universal Time (UTC).
    - display-name (System.String): The display name of the new time zone.
    - standard-display-name (System.String): The name of the new time zone's standard time.

CreateCustomTimeZone(String, TimeSpan, String, String, String, TimeZoneInfo+AdjustmentRule[]) -> TimeZoneInfo
  Summary: Creates a custom time zone with a specified identifier, an offset from Coordinated Universal Time (UTC), a display name, a standard time name, a daylight saving time name, and daylight saving time rules.
  Returns: A System.TimeZoneInfo object that represents the new time zone.
  Parameters:
    - id (System.String): The time zone's identifier.
    - base-utc-offset (System.TimeSpan): An object that represents the time difference between this time zone and Coordinated Universal Time (UTC).
    - display-name (System.String): The display name of the new time zone.
    - standard-display-name (System.String): The new time zone's standard time name.
    - daylight-display-name (System.String): The daylight saving time name of the new time zone.
    - adjustment-rules (System.TimeZoneInfo+AdjustmentRule[]): An array that augments the base UTC offset for a particular period.

CreateCustomTimeZone(String, TimeSpan, String, String, String, TimeZoneInfo+AdjustmentRule[], Boolean) -> TimeZoneInfo
  Summary: Creates a custom time zone with a specified identifier, an offset from Coordinated Universal Time (UTC), a display name, a standard time name, a daylight saving time name, daylight saving time rules, and a value that indicates whether the returned object reflects daylight saving time information.
  Returns: The new time zone. If the disableDaylightSavingTime parameter is , the returned object has no daylight saving time data.
  Parameters:
    - id (System.String): The time zone's identifier.
    - base-utc-offset (System.TimeSpan): A System.TimeSpan object that represents the time difference between this time zone and Coordinated Universal Time (UTC).
    - display-name (System.String): The display name of the new time zone.
    - standard-display-name (System.String): The standard time name of the new time zone.
    - daylight-display-name (System.String): The daylight saving time name of the new time zone.
    - adjustment-rules (System.TimeZoneInfo+AdjustmentRule[]): An array of System.TimeZoneInfo.AdjustmentRule objects that augment the base UTC offset for a particular period.
    - disable-daylight-saving-time (System.Boolean): to discard any daylight saving time-related information present in adjustmentRules with the new object; otherwise, .
"
  (cl:cond
    ((cl:and (cl:stringp id) (cl:or (cl:null base-utc-offset) (dotnet:object-type base-utc-offset)) (cl:stringp display-name) (cl:stringp standard-display-name) supplied-daylight-display-name (cl:stringp daylight-display-name) supplied-adjustment-rules (cl:or (cl:null adjustment-rules) (dotnet:object-type adjustment-rules)) supplied-disable-daylight-saving-time (cl:typep disable-daylight-saving-time 'cl:boolean))
     (dotnet:static <type-str> "CreateCustomTimeZone" id base-utc-offset display-name standard-display-name daylight-display-name adjustment-rules disable-daylight-saving-time))
    ((cl:and (cl:stringp id) (cl:or (cl:null base-utc-offset) (dotnet:object-type base-utc-offset)) (cl:stringp display-name) (cl:stringp standard-display-name) supplied-daylight-display-name (cl:stringp daylight-display-name) supplied-adjustment-rules (cl:or (cl:null adjustment-rules) (dotnet:object-type adjustment-rules)) (cl:not supplied-disable-daylight-saving-time))
     (dotnet:static <type-str> "CreateCustomTimeZone" id base-utc-offset display-name standard-display-name daylight-display-name adjustment-rules))
    ((cl:and (cl:stringp id) (cl:or (cl:null base-utc-offset) (dotnet:object-type base-utc-offset)) (cl:stringp display-name) (cl:stringp standard-display-name) (cl:not supplied-daylight-display-name) (cl:not supplied-adjustment-rules) (cl:not supplied-disable-daylight-saving-time))
     (dotnet:static <type-str> "CreateCustomTimeZone" id base-utc-offset display-name standard-display-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-ZONE-INFO"
                    :class-name <type-str>
                    :method-name "CreateCustomTimeZone"
                    :supplied-args (cl:append (cl:list :id id) (cl:list :base-utc-offset base-utc-offset) (cl:list :display-name display-name) (cl:list :standard-display-name standard-display-name) (cl:when supplied-daylight-display-name (cl:list :daylight-display-name daylight-display-name)) (cl:when supplied-adjustment-rules (cl:list :adjustment-rules adjustment-rules)) (cl:when supplied-disable-daylight-saving-time (cl:list :disable-daylight-saving-time disable-daylight-saving-time)))))))

(cl:defun equals (obj! other)
  "Master wrapper for System.TimeZoneInfo.Equals overloads. Dispatches at runtime.

Equals(TimeZoneInfo) -> Boolean
  Summary: Determines whether the current System.TimeZoneInfo object and another System.TimeZoneInfo object are equal.
  Returns: if the two System.TimeZoneInfo objects are equal; otherwise, .
  Parameters:
    - other (System.TimeZoneInfo): A second object to compare with the current object.

Equals(Object) -> Boolean
  Summary: Determines whether the current System.TimeZoneInfo object and another object are equal.
  Returns: if obj is a System.TimeZoneInfo object that is equal to the current instance; otherwise, .
  Parameters:
    - obj (System.Object): A second object to compare with the current object.
"
  (cl:cond
    ((cl:and (cl:or (cl:null other) (dotnet:object-type other)))
     (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "Equals" other))
    ((cl:and (cl:or (cl:null other) (dotnet:object-type other)))
     (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "Equals" other))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-ZONE-INFO"
                    :class-name <type-str>
                    :method-name "Equals"
                    :supplied-args (cl:append (cl:list :other other))))))

(cl:defun find-system-time-zone-by-id (id)
  "Summary: Returns a System.TimeZoneInfo object based on its identifier.
Returns: An object whose identifier is the value of the id parameter.
Parameters:
  - id (System.String): The time zone identifier, which corresponds to the System.TimeZoneInfo.Id property.
"
  (dotnet:static <type-str> "FindSystemTimeZoneById" (cl:the (dotnet "System.String") id)))

(cl:defun from-serialized-string (source)
  "Summary: Deserializes a string to re-create an original serialized System.TimeZoneInfo object.
Returns: The original serialized object.
Parameters:
  - source (System.String): The string representation of the serialized System.TimeZoneInfo object.
"
  (dotnet:static <type-str> "FromSerializedString" (cl:the (dotnet "System.String") source)))

(cl:defun get-adjustment-rules (obj!)
  "Summary: Retrieves an array of System.TimeZoneInfo.AdjustmentRule objects that apply to the current System.TimeZoneInfo object.
Returns: An array of objects for this time zone.
"
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "GetAdjustmentRules"))

(cl:defun get-ambiguous-time-offsets (obj! date-time-offset)
  "Master wrapper for System.TimeZoneInfo.GetAmbiguousTimeOffsets overloads. Dispatches at runtime.

GetAmbiguousTimeOffsets(DateTimeOffset) -> TimeSpan[]
  Summary: Returns information about the possible dates and times that an ambiguous date and time can be mapped to.
  Returns: An array of objects that represents possible Coordinated Universal Time (UTC) offsets that a particular date and time can be mapped to.
  Parameters:
    - date-time-offset (System.DateTimeOffset): A date and time.

GetAmbiguousTimeOffsets(DateTime) -> TimeSpan[]
  Summary: Returns information about the possible dates and times that an ambiguous date and time can be mapped to.
  Returns: An array of objects that represents possible Coordinated Universal Time (UTC) offsets that a particular date and time can be mapped to.
  Parameters:
    - date-time (System.DateTime): A date and time.
"
  (cl:cond
    ((cl:and (cl:or (cl:null date-time-offset) (dotnet:object-type date-time-offset)))
     (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "GetAmbiguousTimeOffsets" date-time-offset))
    ((cl:and (cl:or (cl:null date-time-offset) (dotnet:object-type date-time-offset)))
     (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "GetAmbiguousTimeOffsets" date-time-offset))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-ZONE-INFO"
                    :class-name <type-str>
                    :method-name "GetAmbiguousTimeOffsets"
                    :supplied-args (cl:append (cl:list :date-time-offset date-time-offset))))))

(cl:defun get-hash-code (obj!)
  "Summary: Serves as a hash function for hashing algorithms and data structures such as hash tables.
Returns: A 32-bit signed integer that serves as the hash code for this System.TimeZoneInfo object.
"
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "GetHashCode"))

(cl:defun get-system-time-zones (cl:&optional (skip-sorting cl:nil supplied-skip-sorting))
  "Master wrapper for System.TimeZoneInfo.GetSystemTimeZones overloads. Dispatches at runtime.

GetSystemTimeZones() -> TimeZoneInfo]
  Summary: Returns a sorted collection of all the time zones about which information is available on the local system.
  Returns: A read-only collection of System.TimeZoneInfo objects.

GetSystemTimeZones(Boolean) -> TimeZoneInfo]
  Summary: Returns a System.Collections.ObjectModel.ReadOnlyCollection`1 containing all valid TimeZone's from the local machine. This method does not throw TimeZoneNotFoundException or InvalidTimeZoneException.
  Parameters:
    - skip-sorting (System.Boolean): If , The collection returned may not necessarily be sorted.
"
  (cl:cond
    ((cl:and supplied-skip-sorting (cl:typep skip-sorting 'cl:boolean))
     (dotnet:static <type-str> "GetSystemTimeZones" skip-sorting))
    ((cl:and (cl:not supplied-skip-sorting))
     (dotnet:static <type-str> "GetSystemTimeZones"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-ZONE-INFO"
                    :class-name <type-str>
                    :method-name "GetSystemTimeZones"
                    :supplied-args (cl:append (cl:when supplied-skip-sorting (cl:list :skip-sorting skip-sorting)))))))

(cl:defun get-utc-offset (obj! date-time-offset)
  "Master wrapper for System.TimeZoneInfo.GetUtcOffset overloads. Dispatches at runtime.

GetUtcOffset(DateTimeOffset) -> TimeSpan
  Summary: Calculates the offset or difference between the time in this time zone and Coordinated Universal Time (UTC) for a particular date and time.
  Returns: An object that indicates the time difference between Coordinated Universal Time (UTC) and the current time zone.
  Parameters:
    - date-time-offset (System.DateTimeOffset): The date and time to determine the offset for.

GetUtcOffset(DateTime) -> TimeSpan
  Summary: Calculates the offset or difference between the time in this time zone and Coordinated Universal Time (UTC) for a particular date and time.
  Returns: An object that indicates the time difference between the two time zones.
  Parameters:
    - date-time (System.DateTime): The date and time to determine the offset for.
"
  (cl:cond
    ((cl:and (cl:or (cl:null date-time-offset) (dotnet:object-type date-time-offset)))
     (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "GetUtcOffset" date-time-offset))
    ((cl:and (cl:or (cl:null date-time-offset) (dotnet:object-type date-time-offset)))
     (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "GetUtcOffset" date-time-offset))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-ZONE-INFO"
                    :class-name <type-str>
                    :method-name "GetUtcOffset"
                    :supplied-args (cl:append (cl:list :date-time-offset date-time-offset))))))

(cl:defun has-same-rules (obj! other)
  "Summary: Indicates whether the current object and another System.TimeZoneInfo object have the same adjustment rules.
Returns: if the two time zones have identical adjustment rules and an identical base offset; otherwise, .
Parameters:
  - other (System.TimeZoneInfo): A second object to compare with the current System.TimeZoneInfo object.
"
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "HasSameRules" other))

(cl:defun ambiguous-time? (obj! date-time-offset)
  "Master wrapper for System.TimeZoneInfo.IsAmbiguousTime overloads. Dispatches at runtime.

IsAmbiguousTime(DateTimeOffset) -> Boolean
  Summary: Determines whether a particular date and time in a particular time zone is ambiguous and can be mapped to two or more Coordinated Universal Time (UTC) times.
  Returns: if the dateTimeOffset parameter is ambiguous in the current time zone; otherwise, .
  Parameters:
    - date-time-offset (System.DateTimeOffset): A date and time.

IsAmbiguousTime(DateTime) -> Boolean
  Summary: Determines whether a particular date and time in a particular time zone is ambiguous and can be mapped to two or more Coordinated Universal Time (UTC) times.
  Returns: if the dateTime parameter is ambiguous; otherwise, .
  Parameters:
    - date-time (System.DateTime): A date and time value.
"
  (cl:cond
    ((cl:and (cl:or (cl:null date-time-offset) (dotnet:object-type date-time-offset)))
     (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "IsAmbiguousTime" date-time-offset))
    ((cl:and (cl:or (cl:null date-time-offset) (dotnet:object-type date-time-offset)))
     (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "IsAmbiguousTime" date-time-offset))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-ZONE-INFO"
                    :class-name <type-str>
                    :method-name "IsAmbiguousTime"
                    :supplied-args (cl:append (cl:list :date-time-offset date-time-offset))))))

(cl:defun daylight-saving-time? (obj! date-time-offset)
  "Master wrapper for System.TimeZoneInfo.IsDaylightSavingTime overloads. Dispatches at runtime.

IsDaylightSavingTime(DateTimeOffset) -> Boolean
  Summary: Indicates whether a specified date and time falls in the range of daylight saving time for the time zone of the current System.TimeZoneInfo object.
  Returns: if the dateTimeOffset parameter is a daylight saving time; otherwise, .
  Parameters:
    - date-time-offset (System.DateTimeOffset): A date and time value.

IsDaylightSavingTime(DateTime) -> Boolean
  Summary: Indicates whether a specified date and time falls in the range of daylight saving time for the time zone of the current System.TimeZoneInfo object.
  Returns: if the dateTime parameter is a daylight saving time; otherwise, .
  Parameters:
    - date-time (System.DateTime): A date and time value.
"
  (cl:cond
    ((cl:and (cl:or (cl:null date-time-offset) (dotnet:object-type date-time-offset)))
     (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "IsDaylightSavingTime" date-time-offset))
    ((cl:and (cl:or (cl:null date-time-offset) (dotnet:object-type date-time-offset)))
     (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "IsDaylightSavingTime" date-time-offset))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-ZONE-INFO"
                    :class-name <type-str>
                    :method-name "IsDaylightSavingTime"
                    :supplied-args (cl:append (cl:list :date-time-offset date-time-offset))))))

(cl:defun invalid-time? (obj! date-time)
  "Summary: Indicates whether a particular date and time is invalid.
Returns: if dateTime is invalid; otherwise, .
Parameters:
  - date-time (System.DateTime): A date and time value.
"
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "IsInvalidTime" date-time))

(cl:defun to-serialized-string (obj!)
  "Summary: Converts the current System.TimeZoneInfo object to a serialized string.
Returns: A string that represents the current System.TimeZoneInfo object.
"
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "ToSerializedString"))

(cl:defun to-string (obj!)
  "Summary: Returns the current System.TimeZoneInfo object's display name.
Returns: The value of the System.TimeZoneInfo.DisplayName property of the current System.TimeZoneInfo object.
"
  (dotnet:invoke (cl:the (dotnet "System.TimeZoneInfo") obj!) "ToString"))

;; The following C# System.TimeZoneInfo.TryConvertIanaIdToWindowsId overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   TryConvertIanaIdToWindowsId(String, out String&) -> Boolean

;; The following C# System.TimeZoneInfo.TryConvertWindowsIdToIanaId overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   TryConvertWindowsIdToIanaId(String, out String&) -> Boolean
;;   TryConvertWindowsIdToIanaId(String, String, out String&) -> Boolean

;; The following C# System.TimeZoneInfo.TryFindSystemTimeZoneById overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   TryFindSystemTimeZoneById(String, out TimeZoneInfo&) -> Boolean

