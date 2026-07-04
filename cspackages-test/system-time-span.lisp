;;; Generated automatically. Do not edit.
;;; Class: System.TimeSpan
;;; Generator Version: 31
;;; Creation Date: 2026-07-04T16:50:34Z

(cl:in-package :system-time-span)

(cl:defconstant <type> (dotnet:resolve-type "System.TimeSpan"))
(cl:defconstant <type-str> "System.TimeSpan")
(cl:defconstant <creation> "2026-07-04T16:50:34Z")
(cl:defconstant <version> 31)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.TimeSpan")))

(cl:defun new (cl:&optional (ticks cl:nil supplied-ticks) (minutes cl:nil supplied-minutes) (seconds cl:nil supplied-seconds) (seconds2 cl:nil supplied-seconds2) (milliseconds cl:nil supplied-milliseconds) (microseconds cl:nil supplied-microseconds))
  "Master wrapper for System.TimeSpan constructor overloads. Dispatches at runtime.

new()

new(Int64)
  Summary: Initializes a new instance of the System.TimeSpan structure to the specified number of ticks.
  Parameters:
    - ticks (System.Int64): A time period expressed in 100-nanosecond units.

new(Int32, Int32, Int32)
  Summary: Initializes a new instance of the System.TimeSpan structure to a specified number of hours, minutes, and seconds.
  Parameters:
    - hours (System.Int32): Number of hours.
    - minutes (System.Int32): Number of minutes.
    - seconds (System.Int32): Number of seconds.

new(Int32, Int32, Int32, Int32)
  Summary: Initializes a new instance of the System.TimeSpan structure to a specified number of days, hours, minutes, and seconds.
  Parameters:
    - days (System.Int32): Number of days.
    - hours (System.Int32): Number of hours.
    - minutes (System.Int32): Number of minutes.
    - seconds (System.Int32): Number of seconds.

new(Int32, Int32, Int32, Int32, Int32)
  Summary: Initializes a new instance of the System.TimeSpan structure to a specified number of days, hours, minutes, seconds, and milliseconds.
  Parameters:
    - days (System.Int32): Number of days.
    - hours (System.Int32): Number of hours.
    - minutes (System.Int32): Number of minutes.
    - seconds (System.Int32): Number of seconds.
    - milliseconds (System.Int32): Number of milliseconds.

new(Int32, Int32, Int32, Int32, Int32, Int32)
  Summary: Initializes a new instance of the System.TimeSpan structure to a specified number of days, hours, minutes, seconds, milliseconds, and microseconds.
  Parameters:
    - days (System.Int32): Number of days.
    - hours (System.Int32): Number of hours.
    - minutes (System.Int32): Number of minutes.
    - seconds (System.Int32): Number of seconds.
    - milliseconds (System.Int32): Number of milliseconds.
    - microseconds (System.Int32): Number of microseconds.
"
  (cl:cond
    ((cl:and supplied-ticks (cl:numberp ticks) supplied-minutes (cl:numberp minutes) supplied-seconds (cl:numberp seconds) supplied-seconds2 (cl:numberp seconds2) supplied-milliseconds (cl:numberp milliseconds) supplied-microseconds (cl:numberp microseconds))
     (dotnet:new <type-str> ticks minutes seconds seconds2 milliseconds microseconds))
    ((cl:and supplied-ticks (cl:numberp ticks) supplied-minutes (cl:numberp minutes) supplied-seconds (cl:numberp seconds) supplied-seconds2 (cl:numberp seconds2) supplied-milliseconds (cl:numberp milliseconds) (cl:not supplied-microseconds))
     (dotnet:new <type-str> ticks minutes seconds seconds2 milliseconds))
    ((cl:and supplied-ticks (cl:numberp ticks) supplied-minutes (cl:numberp minutes) supplied-seconds (cl:numberp seconds) supplied-seconds2 (cl:numberp seconds2) (cl:not supplied-milliseconds) (cl:not supplied-microseconds))
     (dotnet:new <type-str> ticks minutes seconds seconds2))
    ((cl:and supplied-ticks (cl:numberp ticks) supplied-minutes (cl:numberp minutes) supplied-seconds (cl:numberp seconds) (cl:not supplied-seconds2) (cl:not supplied-milliseconds) (cl:not supplied-microseconds))
     (dotnet:new <type-str> ticks minutes seconds))
    ((cl:and supplied-ticks (cl:numberp ticks) (cl:not supplied-minutes) (cl:not supplied-seconds) (cl:not supplied-seconds2) (cl:not supplied-milliseconds) (cl:not supplied-microseconds))
     (dotnet:new <type-str> ticks))
    ((cl:and (cl:not supplied-ticks) (cl:not supplied-minutes) (cl:not supplied-seconds) (cl:not supplied-seconds2) (cl:not supplied-milliseconds) (cl:not supplied-microseconds))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-ticks (cl:list :ticks ticks)) (cl:when supplied-minutes (cl:list :minutes minutes)) (cl:when supplied-seconds (cl:list :seconds seconds)) (cl:when supplied-seconds2 (cl:list :seconds2 seconds2)) (cl:when supplied-milliseconds (cl:list :milliseconds milliseconds)) (cl:when supplied-microseconds (cl:list :microseconds microseconds)))))))

(cl:defconstant +hours-per-day+ (dotnet:static <type-str> "HoursPerDay"))
(cl:setf (cl:documentation (cl:quote +hours-per-day+) (cl:quote cl:variable)) "Represents the number of hours in 1 day. This field is constant.")

(cl:defconstant +microseconds-per-day+ (dotnet:static <type-str> "MicrosecondsPerDay"))
(cl:setf (cl:documentation (cl:quote +microseconds-per-day+) (cl:quote cl:variable)) "Represents the number of microseconds in 1 day. This field is constant.")

(cl:defconstant +microseconds-per-hour+ (dotnet:static <type-str> "MicrosecondsPerHour"))
(cl:setf (cl:documentation (cl:quote +microseconds-per-hour+) (cl:quote cl:variable)) "Represents the number of microseconds in 1 hour. This field is constant.")

(cl:defconstant +microseconds-per-millisecond+ (dotnet:static <type-str> "MicrosecondsPerMillisecond"))
(cl:setf (cl:documentation (cl:quote +microseconds-per-millisecond+) (cl:quote cl:variable)) "Represents the number of microseconds in 1 millisecond. This field is constant.")

(cl:defconstant +microseconds-per-minute+ (dotnet:static <type-str> "MicrosecondsPerMinute"))
(cl:setf (cl:documentation (cl:quote +microseconds-per-minute+) (cl:quote cl:variable)) "Represents the number of microseconds in 1 minute. This field is constant.")

(cl:defconstant +microseconds-per-second+ (dotnet:static <type-str> "MicrosecondsPerSecond"))
(cl:setf (cl:documentation (cl:quote +microseconds-per-second+) (cl:quote cl:variable)) "Represents the number of microseconds in 1 second. This field is constant.")

(cl:defconstant +milliseconds-per-day+ (dotnet:static <type-str> "MillisecondsPerDay"))
(cl:setf (cl:documentation (cl:quote +milliseconds-per-day+) (cl:quote cl:variable)) "Represents the number of milliseconds in 1 day. This field is constant.")

(cl:defconstant +milliseconds-per-hour+ (dotnet:static <type-str> "MillisecondsPerHour"))
(cl:setf (cl:documentation (cl:quote +milliseconds-per-hour+) (cl:quote cl:variable)) "Represents the number of milliseconds in 1 hour. This field is constant.")

(cl:defconstant +milliseconds-per-minute+ (dotnet:static <type-str> "MillisecondsPerMinute"))
(cl:setf (cl:documentation (cl:quote +milliseconds-per-minute+) (cl:quote cl:variable)) "Represents the number of milliseconds in 1 minute. This field is constant.")

(cl:defconstant +milliseconds-per-second+ (dotnet:static <type-str> "MillisecondsPerSecond"))
(cl:setf (cl:documentation (cl:quote +milliseconds-per-second+) (cl:quote cl:variable)) "Represents the number of milliseconds in 1 second. This field is constant.")

(cl:defconstant +minutes-per-day+ (dotnet:static <type-str> "MinutesPerDay"))
(cl:setf (cl:documentation (cl:quote +minutes-per-day+) (cl:quote cl:variable)) "Represents the number of minutes in 1 day. This field is constant.")

(cl:defconstant +minutes-per-hour+ (dotnet:static <type-str> "MinutesPerHour"))
(cl:setf (cl:documentation (cl:quote +minutes-per-hour+) (cl:quote cl:variable)) "Represents the number of minutes in 1 hour. This field is constant.")

(cl:defconstant +nanoseconds-per-tick+ (dotnet:static <type-str> "NanosecondsPerTick"))
(cl:setf (cl:documentation (cl:quote +nanoseconds-per-tick+) (cl:quote cl:variable)) "Represents the number of nanoseconds per tick. This field is constant.")

(cl:defconstant +seconds-per-day+ (dotnet:static <type-str> "SecondsPerDay"))
(cl:setf (cl:documentation (cl:quote +seconds-per-day+) (cl:quote cl:variable)) "Represents the number of seconds in 1 day. This field is constant.")

(cl:defconstant +seconds-per-hour+ (dotnet:static <type-str> "SecondsPerHour"))
(cl:setf (cl:documentation (cl:quote +seconds-per-hour+) (cl:quote cl:variable)) "Represents the number of seconds in 1 hour. This field is constant.")

(cl:defconstant +seconds-per-minute+ (dotnet:static <type-str> "SecondsPerMinute"))
(cl:setf (cl:documentation (cl:quote +seconds-per-minute+) (cl:quote cl:variable)) "Represents the number of seconds in 1 minute. This field is constant.")

(cl:defconstant +ticks-per-day+ (dotnet:static <type-str> "TicksPerDay"))
(cl:setf (cl:documentation (cl:quote +ticks-per-day+) (cl:quote cl:variable)) "Represents the number of ticks in 1 day. This field is constant.")

(cl:defconstant +ticks-per-hour+ (dotnet:static <type-str> "TicksPerHour"))
(cl:setf (cl:documentation (cl:quote +ticks-per-hour+) (cl:quote cl:variable)) "Represents the number of ticks in 1 hour. This field is constant.")

(cl:defconstant +ticks-per-microsecond+ (dotnet:static <type-str> "TicksPerMicrosecond"))
(cl:setf (cl:documentation (cl:quote +ticks-per-microsecond+) (cl:quote cl:variable)) "Represents the number of ticks in 1 microsecond. This field is constant.")

(cl:defconstant +ticks-per-millisecond+ (dotnet:static <type-str> "TicksPerMillisecond"))
(cl:setf (cl:documentation (cl:quote +ticks-per-millisecond+) (cl:quote cl:variable)) "Represents the number of ticks in 1 millisecond. This field is constant.")

(cl:defconstant +ticks-per-minute+ (dotnet:static <type-str> "TicksPerMinute"))
(cl:setf (cl:documentation (cl:quote +ticks-per-minute+) (cl:quote cl:variable)) "Represents the number of ticks in 1 minute. This field is constant.")

(cl:defconstant +ticks-per-second+ (dotnet:static <type-str> "TicksPerSecond"))
(cl:setf (cl:documentation (cl:quote +ticks-per-second+) (cl:quote cl:variable)) "Represents the number of ticks in 1 second.")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.TimeSpan is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +max-value+ (dotnet:static <type-str> "MaxValue"))
(cl:setf (cl:documentation (cl:quote +max-value+) (cl:quote cl:variable)) "Represents the maximum System.TimeSpan value. This field is read-only.")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.TimeSpan is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +min-value+ (dotnet:static <type-str> "MinValue"))
(cl:setf (cl:documentation (cl:quote +min-value+) (cl:quote cl:variable)) "Represents the minimum System.TimeSpan value. This field is read-only.")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.TimeSpan is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +zero+ (dotnet:static <type-str> "Zero"))
(cl:setf (cl:documentation (cl:quote +zero+) (cl:quote cl:variable)) "Represents the zero System.TimeSpan value. This field is read-only.")

(cl:defun days (obj!)
  "Gets the days component of the time interval represented by the current System.TimeSpan structure."
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "get_Days"))

(cl:defun hours (obj!)
  "Gets the hours component of the time interval represented by the current System.TimeSpan structure."
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "get_Hours"))

(cl:defun microseconds (obj!)
  "Gets the microseconds component of the time interval represented by the current System.TimeSpan structure."
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "get_Microseconds"))

(cl:defun milliseconds (obj!)
  "Gets the milliseconds component of the time interval represented by the current System.TimeSpan structure."
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "get_Milliseconds"))

(cl:defun minutes (obj!)
  "Gets the minutes component of the time interval represented by the current System.TimeSpan structure."
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "get_Minutes"))

(cl:defun nanoseconds (obj!)
  "Gets the nanoseconds component of the time interval represented by the current System.TimeSpan structure."
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "get_Nanoseconds"))

(cl:defun seconds (obj!)
  "Gets the seconds component of the time interval represented by the current System.TimeSpan structure."
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "get_Seconds"))

(cl:defun ticks (obj!)
  "Gets the number of ticks that represent the value of the current System.TimeSpan structure."
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "get_Ticks"))

(cl:defun total-days (obj!)
  "Gets the value of the current System.TimeSpan structure expressed in whole and fractional days."
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "get_TotalDays"))

(cl:defun total-hours (obj!)
  "Gets the value of the current System.TimeSpan structure expressed in whole and fractional hours."
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "get_TotalHours"))

(cl:defun total-microseconds (obj!)
  "Gets the value of the current System.TimeSpan structure expressed in whole and fractional microseconds."
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "get_TotalMicroseconds"))

(cl:defun total-milliseconds (obj!)
  "Gets the value of the current System.TimeSpan structure expressed in whole and fractional milliseconds."
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "get_TotalMilliseconds"))

(cl:defun total-minutes (obj!)
  "Gets the value of the current System.TimeSpan structure expressed in whole and fractional minutes."
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "get_TotalMinutes"))

(cl:defun total-nanoseconds (obj!)
  "Gets the value of the current System.TimeSpan structure expressed in whole and fractional nanoseconds."
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "get_TotalNanoseconds"))

(cl:defun total-seconds (obj!)
  "Gets the value of the current System.TimeSpan structure expressed in whole and fractional seconds."
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "get_TotalSeconds"))

(cl:defun - (t-val cl:&optional (t2 cl:nil supplied-t2))
  "Master wrapper for System.TimeSpan.- overloads. Dispatches at runtime.

-(TimeSpan) -> TimeSpan
  Summary: Returns a System.TimeSpan whose value is the negated value of the specified instance.
  Returns: An object that has the same numeric value as this instance, but the opposite sign.
  Parameters:
    - t-val (System.TimeSpan): The time interval to be negated.

-(TimeSpan, TimeSpan) -> TimeSpan
  Summary: Subtracts a specified System.TimeSpan from another specified System.TimeSpan.
  Returns: An object whose value is the result of the value of t1 minus the value of t2.
  Parameters:
    - t1 (System.TimeSpan): The minuend.
    - t2 (System.TimeSpan): The subtrahend.
"
  (cl:cond
    ((cl:and (cl:or (cl:null t-val) (dotnet:object-type t-val)) supplied-t2 (cl:or (cl:null t2) (dotnet:object-type t2)))
     (dotnet:static <type-str> "op_Subtraction" t-val t2))
    ((cl:and (cl:or (cl:null t-val) (dotnet:object-type t-val)) (cl:not supplied-t2))
     (dotnet:static <type-str> "op_UnaryNegation" t-val))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "-"
                    :supplied-args (cl:append (cl:list :t-val t-val) (cl:when supplied-t2 (cl:list :t2 t2)))))))

(cl:defun * (time-span factor)
  "Master wrapper for System.TimeSpan.* overloads. Dispatches at runtime.

*(TimeSpan, Double) -> TimeSpan
  Summary: Returns a new System.TimeSpan object whose value is the result of multiplying the specified timeSpan instance and the specified factor.
  Returns: A new object that represents the value of the specified timeSpan instance multiplied by the value of the specified factor.
  Parameters:
    - time-span (System.TimeSpan): The value to be multiplied.
    - factor (System.Double): The value to be multiplied by.

*(Double, TimeSpan) -> TimeSpan
  Summary: Returns a new System.TimeSpan object whose value is the result of multiplying the specified factor and the specified timeSpan instance.
  Returns: A new object that represents the value of the specified factor multiplied by the value of the specified timeSpan instance.
  Parameters:
    - factor (System.Double): The value to be multiplied by.
    - time-span (System.TimeSpan): The value to be multiplied.
"
  (cl:cond
    ((cl:and (cl:or (cl:null time-span) (dotnet:object-type time-span)) (cl:numberp factor))
     (dotnet:static <type-str> "op_Multiply" time-span factor))
    ((cl:and (cl:numberp time-span) (cl:or (cl:null factor) (dotnet:object-type factor)))
     (dotnet:static <type-str> "op_Multiply" time-span factor))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "*"
                    :supplied-args (cl:append (cl:list :time-span time-span) (cl:list :factor factor))))))

(cl:defun / (time-span divisor)
  "Master wrapper for System.TimeSpan./ overloads. Dispatches at runtime.

/(TimeSpan, Double) -> TimeSpan
  Summary: Returns a new System.TimeSpan object whose value is the result of dividing the specified timeSpan by the specified divisor.
  Returns: A new object that represents the value of timeSpan divided by the value of divisor.
  Parameters:
    - time-span (System.TimeSpan): The dividend or value to be divided.
    - divisor (System.Double): The divisor or value to be divided by.

/(TimeSpan, TimeSpan) -> Double
  Summary: Returns a new System.Double value that's the result of dividing t1 by t2.
  Returns: A new value that represents result of dividing t1 by the value of t2.
  Parameters:
    - t1 (System.TimeSpan): The dividend or value to be divided.
    - t2 (System.TimeSpan): The divisor or value to be divided by.
"
  (cl:cond
    ((cl:and (cl:or (cl:null time-span) (dotnet:object-type time-span)) (cl:numberp divisor))
     (dotnet:static <type-str> "op_Division" time-span divisor))
    ((cl:and (cl:or (cl:null time-span) (dotnet:object-type time-span)) (cl:or (cl:null divisor) (dotnet:object-type divisor)))
     (dotnet:static <type-str> "op_Division" time-span divisor))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "/"
                    :supplied-args (cl:append (cl:list :time-span time-span) (cl:list :divisor divisor))))))

(cl:defun + (t-val cl:&optional (t2 cl:nil supplied-t2))
  "Master wrapper for System.TimeSpan.+ overloads. Dispatches at runtime.

+(TimeSpan) -> TimeSpan
  Summary: Returns the specified instance of System.TimeSpan.
  Returns: The time interval specified by t.
  Parameters:
    - t-val (System.TimeSpan): The time interval to return.

+(TimeSpan, TimeSpan) -> TimeSpan
  Summary: Adds two specified System.TimeSpan instances.
  Returns: An object whose value is the sum of the values of t1 and t2.
  Parameters:
    - t1 (System.TimeSpan): The first time interval to add.
    - t2 (System.TimeSpan): The second time interval to add.
"
  (cl:cond
    ((cl:and (cl:or (cl:null t-val) (dotnet:object-type t-val)) supplied-t2 (cl:or (cl:null t2) (dotnet:object-type t2)))
     (dotnet:static <type-str> "op_Addition" t-val t2))
    ((cl:and (cl:or (cl:null t-val) (dotnet:object-type t-val)) (cl:not supplied-t2))
     (dotnet:static <type-str> "op_UnaryPlus" t-val))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "+"
                    :supplied-args (cl:append (cl:list :t-val t-val) (cl:when supplied-t2 (cl:list :t2 t2)))))))

(cl:defun < (t1 t2)
  "Summary: Indicates whether a specified System.TimeSpan is less than another specified System.TimeSpan.
Returns: if the value of t1 is less than the value of t2; otherwise, .
Parameters:
  - t1 (System.TimeSpan): The first time interval to compare.
  - t2 (System.TimeSpan): The second time interval to compare.
"
  (dotnet:static <type-str> "op_LessThan" (cl:the (dotnet "System.TimeSpan") t1) (cl:the (dotnet "System.TimeSpan") t2)))

(cl:defun <= (t1 t2)
  "Summary: Indicates whether a specified System.TimeSpan is less than or equal to another specified System.TimeSpan.
Returns: if the value of t1 is less than or equal to the value of t2; otherwise, .
Parameters:
  - t1 (System.TimeSpan): The first time interval to compare.
  - t2 (System.TimeSpan): The second time interval to compare.
"
  (dotnet:static <type-str> "op_LessThanOrEqual" (cl:the (dotnet "System.TimeSpan") t1) (cl:the (dotnet "System.TimeSpan") t2)))

(cl:defun = (t1 t2)
  "Summary: Indicates whether two System.TimeSpan instances are equal.
Returns: if the values of t1 and t2 are equal; otherwise, .
Parameters:
  - t1 (System.TimeSpan): The first time interval to compare.
  - t2 (System.TimeSpan): The second time interval to compare.
"
  (dotnet:static <type-str> "op_Equality" (cl:the (dotnet "System.TimeSpan") t1) (cl:the (dotnet "System.TimeSpan") t2)))

(cl:defun > (t1 t2)
  "Summary: Indicates whether a specified System.TimeSpan is greater than another specified System.TimeSpan.
Returns: if the value of t1 is greater than the value of t2; otherwise, .
Parameters:
  - t1 (System.TimeSpan): The first time interval to compare.
  - t2 (System.TimeSpan): The second time interval to compare.
"
  (dotnet:static <type-str> "op_GreaterThan" (cl:the (dotnet "System.TimeSpan") t1) (cl:the (dotnet "System.TimeSpan") t2)))

(cl:defun >= (t1 t2)
  "Summary: Indicates whether a specified System.TimeSpan is greater than or equal to another specified System.TimeSpan.
Returns: if the value of t1 is greater than or equal to the value of t2; otherwise, .
Parameters:
  - t1 (System.TimeSpan): The first time interval to compare.
  - t2 (System.TimeSpan): The second time interval to compare.
"
  (dotnet:static <type-str> "op_GreaterThanOrEqual" (cl:the (dotnet "System.TimeSpan") t1) (cl:the (dotnet "System.TimeSpan") t2)))

(cl:defun add (obj! ts)
  "Summary: Returns a new System.TimeSpan object whose value is the sum of the specified System.TimeSpan object and this instance.
Returns: A new object that represents the value of this instance plus the value of ts.
Parameters:
  - ts (System.TimeSpan): The time interval to add.
"
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "Add" ts))

(cl:defun compare (t1 t2)
  "Summary: Compares two System.TimeSpan values and returns an integer that indicates whether the first value is shorter than, equal to, or longer than the second value.
Returns: One of the following values. Value Description -1t1 is shorter than t2. 0t1 is equal to t2. 1t1 is longer than t2.
Parameters:
  - t1 (System.TimeSpan): The first time interval to compare.
  - t2 (System.TimeSpan): The second time interval to compare.
"
  (dotnet:static <type-str> "Compare" (cl:the (dotnet "System.TimeSpan") t1) (cl:the (dotnet "System.TimeSpan") t2)))

(cl:defun compare-to (obj! value)
  "Master wrapper for System.TimeSpan.CompareTo overloads. Dispatches at runtime.

CompareTo(Object) -> Int32
  Summary: Compares this instance to a specified object and returns an integer that indicates whether this instance is shorter than, equal to, or longer than the specified object.
  Returns: One of the following values. Value Description -1 This instance is shorter than value. 0 This instance is equal to value. 1 This instance is longer than value, or value is .
  Parameters:
    - value (System.Object): An object to compare, or .

CompareTo(TimeSpan) -> Int32
  Summary: Compares this instance to a specified System.TimeSpan object and returns an integer that indicates whether this instance is shorter than, equal to, or longer than the System.TimeSpan object.
  Returns: A signed number indicating the relative values of this instance and value. Value Description A negative integer This instance is shorter than value. Zero This instance is equal to value. A positive integer This instance is longer than value.
  Parameters:
    - value (System.TimeSpan): An object to compare to this instance.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)))
     (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "CompareTo" value))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)))
     (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "CompareTo" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "CompareTo"
                    :supplied-args (cl:append (cl:list :value value))))))

(cl:defun divide (obj! divisor)
  "Master wrapper for System.TimeSpan.Divide overloads. Dispatches at runtime.

Divide(Double) -> TimeSpan
  Summary: Returns a new System.TimeSpan object whose value is the result of dividing this instance by the specified divisor.
  Returns: A new object that represents the value of this instance divided by the value of divisor.
  Parameters:
    - divisor (System.Double): The divisor or value to be divided by.

Divide(TimeSpan) -> Double
  Summary: Returns a new System.Double value that's the result of dividing this instance by ts.
  Returns: A new value that represents result of dividing this instance by the value of ts.
  Parameters:
    - ts (System.TimeSpan): The value to be divided by.
"
  (cl:cond
    ((cl:and (cl:numberp divisor))
     (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "Divide" divisor))
    ((cl:and (cl:or (cl:null divisor) (dotnet:object-type divisor)))
     (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "Divide" divisor))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "Divide"
                    :supplied-args (cl:append (cl:list :divisor divisor))))))

(cl:defun duration (obj!)
  "Summary: Returns a new System.TimeSpan object whose value is the absolute value of the current System.TimeSpan object.
Returns: A new object whose value is the absolute value of the current System.TimeSpan object.
"
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "Duration"))

(cl:defun equals (obj! value)
  "Master wrapper for System.TimeSpan.Equals overloads. Dispatches at runtime.

Equals(Object) -> Boolean
  Summary: Returns a value indicating whether this instance is equal to a specified object.
  Returns: if value is a System.TimeSpan object that represents the same time interval as the current System.TimeSpan structure; otherwise, .
  Parameters:
    - value (System.Object): An object to compare with this instance.

Equals(TimeSpan) -> Boolean
  Summary: Returns a value indicating whether this instance is equal to a specified System.TimeSpan object.
  Returns: if obj represents the same time interval as this instance; otherwise, .
  Parameters:
    - obj (System.TimeSpan): An object to compare with this instance.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)))
     (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "Equals" value))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)))
     (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "Equals" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "Equals"
                    :supplied-args (cl:append (cl:list :value value))))))

(cl:defun equals* (t1 t2)
  "Summary: Returns a value that indicates whether two specified instances of System.TimeSpan are equal.
Returns: if the values of t1 and t2 are equal; otherwise, .
Parameters:
  - t1 (System.TimeSpan): The first time interval to compare.
  - t2 (System.TimeSpan): The second time interval to compare.
"
  (dotnet:static <type-str> "Equals" (cl:the (dotnet "System.TimeSpan") t1) (cl:the (dotnet "System.TimeSpan") t2)))

(cl:defun from-days (value cl:&key (hours cl:nil supplied-hours) (minutes cl:nil supplied-minutes) (seconds cl:nil supplied-seconds) (milliseconds cl:nil supplied-milliseconds) (microseconds cl:nil supplied-microseconds))
  "Master wrapper for System.TimeSpan.FromDays overloads. Dispatches at runtime.

FromDays(Double) -> TimeSpan
  Summary: Returns a System.TimeSpan that represents a specified number of days, where the specification is accurate to the nearest millisecond.
  Returns: An object that represents value.
  Parameters:
    - value (System.Double): A number of days, accurate to the nearest millisecond.

FromDays(Int32) -> TimeSpan
  Summary: Initializes a new instance of the System.TimeSpan structure to a specified number of days.
  Returns: Returns a System.TimeSpan that represents a specified number of days.
  Parameters:
    - days (System.Int32): Number of days.

FromDays(Int32, Int32, Int64, Int64, Int64, Int64) -> TimeSpan
  Summary: Initializes a new instance of the System.TimeSpan structure to a specified number of days, hours, minutes, seconds, milliseconds, and microseconds.
  Returns: Returns a System.TimeSpan that represents a specified number of days, hours, minutes, seconds, milliseconds, and microseconds.
  Parameters:
    - days (System.Int32): Number of days.
    - hours (System.Int32): Number of hours.
    - minutes (System.Int64): Number of minutes.
    - seconds (System.Int64): Number of seconds.
    - milliseconds (System.Int64): Number of milliseconds.
    - microseconds (System.Int64): Number of microseconds.
"
  (cl:cond
    ((cl:and (cl:numberp value) (cl:numberp hours) (cl:numberp minutes) (cl:numberp seconds) (cl:numberp milliseconds) (cl:numberp microseconds))
     (dotnet:static <type-str> "FromDays" value hours minutes seconds milliseconds microseconds))
    ((cl:and (cl:numberp value) (cl:not supplied-hours) (cl:not supplied-minutes) (cl:not supplied-seconds) (cl:not supplied-milliseconds) (cl:not supplied-microseconds))
     (dotnet:static <type-str> "FromDays" value))
    ((cl:and (cl:numberp value) (cl:not supplied-hours) (cl:not supplied-minutes) (cl:not supplied-seconds) (cl:not supplied-milliseconds) (cl:not supplied-microseconds))
     (dotnet:static <type-str> "FromDays" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "FromDays"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-hours (cl:list :hours hours)) (cl:when supplied-minutes (cl:list :minutes minutes)) (cl:when supplied-seconds (cl:list :seconds seconds)) (cl:when supplied-milliseconds (cl:list :milliseconds milliseconds)) (cl:when supplied-microseconds (cl:list :microseconds microseconds)))))))

;; Note: System.TimeSpan.FromDays also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   FromDays(Int32, Int32, Int64, Int64, Int64, Int64) -> TimeSpan

(cl:defun from-hours (hours cl:&key (minutes cl:nil supplied-minutes) (seconds cl:nil supplied-seconds) (milliseconds cl:nil supplied-milliseconds) (microseconds cl:nil supplied-microseconds))
  "Master wrapper for System.TimeSpan.FromHours overloads. Dispatches at runtime.

FromHours(Int32) -> TimeSpan
  Summary: Initializes a new instance of the System.TimeSpan structure to a specified number of hours.
  Returns: Returns a System.TimeSpan that represents a specified number of hours.
  Parameters:
    - hours (System.Int32): Number of hours.

FromHours(Double) -> TimeSpan
  Summary: Returns a System.TimeSpan that represents a specified number of hours, where the specification is accurate to the nearest millisecond.
  Returns: An object that represents value.
  Parameters:
    - value (System.Double): A number of hours accurate to the nearest millisecond.

FromHours(Int32, Int64, Int64, Int64, Int64) -> TimeSpan
  Summary: Initializes a new instance of the System.TimeSpan structure to a specified number of hours, minutes, seconds, milliseconds, and microseconds.
  Returns: Returns a System.TimeSpan that represents a specified number of hours, minutes, seconds, milliseconds, and microseconds.
  Parameters:
    - hours (System.Int32): Number of hours.
    - minutes (System.Int64): Number of minutes.
    - seconds (System.Int64): Number of seconds.
    - milliseconds (System.Int64): Number of milliseconds.
    - microseconds (System.Int64): Number of microseconds.
"
  (cl:cond
    ((cl:and (cl:numberp hours) (cl:numberp minutes) (cl:numberp seconds) (cl:numberp milliseconds) (cl:numberp microseconds))
     (dotnet:static <type-str> "FromHours" hours minutes seconds milliseconds microseconds))
    ((cl:and (cl:numberp hours) (cl:not supplied-minutes) (cl:not supplied-seconds) (cl:not supplied-milliseconds) (cl:not supplied-microseconds))
     (dotnet:static <type-str> "FromHours" hours))
    ((cl:and (cl:numberp hours) (cl:not supplied-minutes) (cl:not supplied-seconds) (cl:not supplied-milliseconds) (cl:not supplied-microseconds))
     (dotnet:static <type-str> "FromHours" hours))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "FromHours"
                    :supplied-args (cl:append (cl:list :hours hours) (cl:when supplied-minutes (cl:list :minutes minutes)) (cl:when supplied-seconds (cl:list :seconds seconds)) (cl:when supplied-milliseconds (cl:list :milliseconds milliseconds)) (cl:when supplied-microseconds (cl:list :microseconds microseconds)))))))

;; Note: System.TimeSpan.FromHours also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   FromHours(Int32, Int64, Int64, Int64, Int64) -> TimeSpan

(cl:defun from-microseconds (microseconds)
  "Master wrapper for System.TimeSpan.FromMicroseconds overloads. Dispatches at runtime.

FromMicroseconds(Int64) -> TimeSpan
  Summary: Initializes a new instance of the System.TimeSpan structure to a specified number of microseconds.
  Returns: Returns a System.TimeSpan that represents a specified number of microseconds.
  Parameters:
    - microseconds (System.Int64): Number of microseconds.

FromMicroseconds(Double) -> TimeSpan
  Summary: Returns a System.TimeSpan that represents a specified number of microseconds.
  Returns: An object that represents value.
  Parameters:
    - value (System.Double): A number of microseconds.
"
  (cl:cond
    ((cl:and (cl:numberp microseconds))
     (dotnet:static <type-str> "FromMicroseconds" microseconds))
    ((cl:and (cl:numberp microseconds))
     (dotnet:static <type-str> "FromMicroseconds" microseconds))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "FromMicroseconds"
                    :supplied-args (cl:append (cl:list :microseconds microseconds))))))

(cl:defun from-milliseconds (milliseconds cl:&optional (microseconds cl:nil supplied-microseconds))
  "Master wrapper for System.TimeSpan.FromMilliseconds overloads. Dispatches at runtime.

FromMilliseconds(Int64) -> TimeSpan
  Summary: Initializes a new instance of the System.TimeSpan structure to a specified number of milliseconds.
  Returns: Returns a System.TimeSpan that represents a specified number of milliseconds.
  Parameters:
    - milliseconds (System.Int64): The number of milliseconds.

FromMilliseconds(Double) -> TimeSpan
  Summary: Returns a System.TimeSpan that represents a specified number of milliseconds.
  Returns: An object that represents value.
  Parameters:
    - value (System.Double): A number of milliseconds.

FromMilliseconds(Int64, Int64) -> TimeSpan
  Summary: Initializes a new instance of the System.TimeSpan structure to a specified number of milliseconds, and microseconds.
  Returns: Returns a System.TimeSpan that represents a specified number of milliseconds, and microseconds.
  Parameters:
    - milliseconds (System.Int64): Number of milliseconds.
    - microseconds (System.Int64): Number of microseconds.
"
  (cl:cond
    ((cl:and (cl:numberp milliseconds) supplied-microseconds (cl:numberp microseconds))
     (dotnet:static <type-str> "FromMilliseconds" milliseconds microseconds))
    ((cl:and (cl:numberp milliseconds) (cl:not supplied-microseconds))
     (dotnet:static <type-str> "FromMilliseconds" milliseconds))
    ((cl:and (cl:numberp milliseconds) (cl:not supplied-microseconds))
     (dotnet:static <type-str> "FromMilliseconds" milliseconds))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "FromMilliseconds"
                    :supplied-args (cl:append (cl:list :milliseconds milliseconds) (cl:when supplied-microseconds (cl:list :microseconds microseconds)))))))

(cl:defun from-minutes (minutes cl:&key (seconds cl:nil supplied-seconds) (milliseconds cl:nil supplied-milliseconds) (microseconds cl:nil supplied-microseconds))
  "Master wrapper for System.TimeSpan.FromMinutes overloads. Dispatches at runtime.

FromMinutes(Int64) -> TimeSpan
  Summary: Initializes a new instance of the System.TimeSpan structure to a specified number of minutes.
  Returns: Returns a System.TimeSpan that represents a specified number of minutes.
  Parameters:
    - minutes (System.Int64): Number of minutes.

FromMinutes(Double) -> TimeSpan
  Summary: Returns a System.TimeSpan that represents a specified number of minutes, where the specification is accurate to the nearest millisecond.
  Returns: An object that represents value.
  Parameters:
    - value (System.Double): A number of minutes, accurate to the nearest millisecond.

FromMinutes(Int64, Int64, Int64, Int64) -> TimeSpan
  Summary: Initializes a new instance of the System.TimeSpan structure to a specified number of minutes, seconds, milliseconds, and microseconds.
  Returns: Returns a System.TimeSpan that represents a specified number of minutes, seconds, milliseconds, and microseconds.
  Parameters:
    - minutes (System.Int64): Number of minutes.
    - seconds (System.Int64): Number of seconds.
    - milliseconds (System.Int64): Number of milliseconds.
    - microseconds (System.Int64): Number of microseconds.
"
  (cl:cond
    ((cl:and (cl:numberp minutes) (cl:numberp seconds) (cl:numberp milliseconds) (cl:numberp microseconds))
     (dotnet:static <type-str> "FromMinutes" minutes seconds milliseconds microseconds))
    ((cl:and (cl:numberp minutes) (cl:not supplied-seconds) (cl:not supplied-milliseconds) (cl:not supplied-microseconds))
     (dotnet:static <type-str> "FromMinutes" minutes))
    ((cl:and (cl:numberp minutes) (cl:not supplied-seconds) (cl:not supplied-milliseconds) (cl:not supplied-microseconds))
     (dotnet:static <type-str> "FromMinutes" minutes))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "FromMinutes"
                    :supplied-args (cl:append (cl:list :minutes minutes) (cl:when supplied-seconds (cl:list :seconds seconds)) (cl:when supplied-milliseconds (cl:list :milliseconds milliseconds)) (cl:when supplied-microseconds (cl:list :microseconds microseconds)))))))

;; Note: System.TimeSpan.FromMinutes also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   FromMinutes(Int64, Int64, Int64, Int64) -> TimeSpan

(cl:defun from-seconds (seconds cl:&key (milliseconds cl:nil supplied-milliseconds) (microseconds cl:nil supplied-microseconds))
  "Master wrapper for System.TimeSpan.FromSeconds overloads. Dispatches at runtime.

FromSeconds(Int64) -> TimeSpan
  Summary: Initializes a new instance of the System.TimeSpan structure to a specified number of seconds.
  Returns: Returns a System.TimeSpan that represents a specified number of seconds.
  Parameters:
    - seconds (System.Int64): Number of seconds.

FromSeconds(Double) -> TimeSpan
  Summary: Returns a System.TimeSpan that represents a specified number of seconds, where the specification is accurate to the nearest millisecond.
  Returns: An object that represents value.
  Parameters:
    - value (System.Double): A number of seconds, accurate to the nearest millisecond.

FromSeconds(Int64, Int64, Int64) -> TimeSpan
  Summary: Initializes a new instance of the System.TimeSpan structure to a specified number of seconds, milliseconds, and microseconds.
  Returns: Returns a System.TimeSpan that represents a specified number of seconds, milliseconds, and microseconds.
  Parameters:
    - seconds (System.Int64): Number of seconds.
    - milliseconds (System.Int64): Number of milliseconds.
    - microseconds (System.Int64): Number of microseconds.
"
  (cl:cond
    ((cl:and (cl:numberp seconds) (cl:numberp milliseconds) (cl:numberp microseconds))
     (dotnet:static <type-str> "FromSeconds" seconds milliseconds microseconds))
    ((cl:and (cl:numberp seconds) (cl:not supplied-milliseconds) (cl:not supplied-microseconds))
     (dotnet:static <type-str> "FromSeconds" seconds))
    ((cl:and (cl:numberp seconds) (cl:not supplied-milliseconds) (cl:not supplied-microseconds))
     (dotnet:static <type-str> "FromSeconds" seconds))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "FromSeconds"
                    :supplied-args (cl:append (cl:list :seconds seconds) (cl:when supplied-milliseconds (cl:list :milliseconds milliseconds)) (cl:when supplied-microseconds (cl:list :microseconds microseconds)))))))

;; Note: System.TimeSpan.FromSeconds also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   FromSeconds(Int64, Int64, Int64) -> TimeSpan

(cl:defun from-ticks (value)
  "Summary: Returns a System.TimeSpan that represents a specified time, where the specification is in units of ticks.
Returns: An object that represents value.
Parameters:
  - value (System.Int64): A number of ticks that represent a time.
"
  (dotnet:static <type-str> "FromTicks" (cl:the (dotnet "System.Int64") value)))

(cl:defun get-hash-code (obj!)
  "Summary: Returns a hash code for this instance.
Returns: A 32-bit signed integer hash code.
"
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "GetHashCode"))

(cl:defun multiply (obj! factor)
  "Summary: Returns a new System.TimeSpan object which value is the result of multiplication of this instance and the specified factor.
Returns: A new object that represents the value of this instance multiplied by the value of factor.
Parameters:
  - factor (System.Double): The value to be multiplied by.
"
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "Multiply" factor))

(cl:defun negate (obj!)
  "Summary: Returns a new System.TimeSpan object whose value is the negated value of this instance.
Returns: A new object with the same numeric value as this instance, but with the opposite sign.
"
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "Negate"))

(cl:defun not= (t1 t2)
  "Summary: Indicates whether two System.TimeSpan instances are not equal.
Returns: if the values of t1 and t2 are not equal; otherwise, .
Parameters:
  - t1 (System.TimeSpan): The first time interval to compare.
  - t2 (System.TimeSpan): The second time interval to compare.
"
  (dotnet:static <type-str> "op_Inequality" (cl:the (dotnet "System.TimeSpan") t1) (cl:the (dotnet "System.TimeSpan") t2)))

(cl:defun parse (s cl:&optional (format-provider cl:nil supplied-format-provider))
  "Master wrapper for System.TimeSpan.Parse overloads. Dispatches at runtime.

Parse(String) -> TimeSpan
  Summary: Converts the string representation of a time interval to its System.TimeSpan equivalent.
  Returns: A time interval that corresponds to s.
  Parameters:
    - s (System.String): A string that specifies the time interval to convert.

Parse(String, IFormatProvider) -> TimeSpan
  Summary: Converts the string representation of a time interval to its System.TimeSpan equivalent by using the specified culture-specific format information.
  Returns: A time interval that corresponds to input, as specified by formatProvider.
  Parameters:
    - input (System.String): A string that specifies the time interval to convert.
    - format-provider (System.IFormatProvider): An object that supplies culture-specific formatting information.

Parse(Char], IFormatProvider) -> TimeSpan
  Summary: Converts the span representation of a time interval to its System.TimeSpan equivalent by using the specified culture-specific format information.
  Returns: A time interval that corresponds to input, as specified by formatProvider.
  Parameters:
    - input (System.ReadOnlySpan`1[System.Char]): A span containing the characters that represent the time interval to convert.
    - format-provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
"
  (cl:cond
    ((cl:and (cl:stringp s) supplied-format-provider (cl:or (cl:null format-provider) (dotnet:object-type format-provider)))
     (dotnet:static <type-str> "Parse" s format-provider))
    ((cl:and (cl:or (cl:null s) (dotnet:object-type s)) supplied-format-provider (cl:or (cl:null format-provider) (dotnet:object-type format-provider)))
     (dotnet:static <type-str> "Parse" s format-provider))
    ((cl:and (cl:stringp s) (cl:not supplied-format-provider))
     (dotnet:static <type-str> "Parse" s))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "Parse"
                    :supplied-args (cl:append (cl:list :s s) (cl:when supplied-format-provider (cl:list :format-provider format-provider)))))))

;; Note: System.TimeSpan.Parse also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   Parse(Char], IFormatProvider) -> TimeSpan

(cl:defun parse-exact (input format format-provider cl:&optional (styles cl:nil supplied-styles))
  "Master wrapper for System.TimeSpan.ParseExact overloads. Dispatches at runtime.

ParseExact(String, String, IFormatProvider) -> TimeSpan
  Summary: Converts the string representation of a time interval to its System.TimeSpan equivalent by using the specified format and culture-specific format information. The format of the string representation must match the specified format exactly.
  Returns: A time interval that corresponds to input, as specified by format and formatProvider.
  Parameters:
    - input (System.String): A string that specifies the time interval to convert.
    - format (System.String): A standard or custom format string that defines the required format of input.
    - format-provider (System.IFormatProvider): An object that provides culture-specific formatting information.

ParseExact(String, String[], IFormatProvider) -> TimeSpan
  Summary: Converts the string representation of a time interval to its System.TimeSpan equivalent by using the specified array of format strings and culture-specific format information. The format of the string representation must match one of the specified formats exactly.
  Returns: A time interval that corresponds to input, as specified by formats and formatProvider.
  Parameters:
    - input (System.String): A string that specifies the time interval to convert.
    - formats (System.String[]): An array of standard or custom format strings that defines the required format of input.
    - format-provider (System.IFormatProvider): An object that provides culture-specific formatting information.

ParseExact(String, String, IFormatProvider, TimeSpanStyles) -> TimeSpan
  Summary: Converts the string representation of a time interval to its System.TimeSpan equivalent by using the specified format, culture-specific format information, and styles. The format of the string representation must match the specified format exactly.
  Returns: A time interval that corresponds to input, as specified by format, formatProvider, and styles.
  Parameters:
    - input (System.String): A string that specifies the time interval to convert.
    - format (System.String): A standard or custom format string that defines the required format of input.
    - format-provider (System.IFormatProvider): An object that provides culture-specific formatting information.
    - styles (System.Globalization.TimeSpanStyles): A bitwise combination of enumeration values that defines the style elements that may be present in input.

ParseExact(Char], Char], IFormatProvider, TimeSpanStyles) -> TimeSpan
  Summary: Converts the char span of a time interval to its System.TimeSpan equivalent by using the specified format and culture-specific format information. The format of the string representation must match the specified format exactly.
  Returns: A time interval that corresponds to input, as specified by format and formatProvider.
  Parameters:
    - input (System.ReadOnlySpan`1[System.Char]): A span that specifies the time interval to convert.
    - format (System.ReadOnlySpan`1[System.Char]): A standard or custom format string that defines the required format of input.
    - format-provider (System.IFormatProvider): An object that provides culture-specific formatting information.
    - styles (System.Globalization.TimeSpanStyles): A bitwise combination of enumeration values that defines the style elements that may be present in input.

ParseExact(String, String[], IFormatProvider, TimeSpanStyles) -> TimeSpan
  Summary: Converts the string representation of a time interval to its System.TimeSpan equivalent by using the specified formats, culture-specific format information, and styles. The format of the string representation must match one of the specified formats exactly.
  Returns: A time interval that corresponds to input, as specified by formats, formatProvider, and styles.
  Parameters:
    - input (System.String): A string that specifies the time interval to convert.
    - formats (System.String[]): An array of standard or custom format strings that define the required format of input.
    - format-provider (System.IFormatProvider): An object that provides culture-specific formatting information.
    - styles (System.Globalization.TimeSpanStyles): A bitwise combination of enumeration values that defines the style elements that may be present in input.

ParseExact(Char], String[], IFormatProvider, TimeSpanStyles) -> TimeSpan
  Summary: Converts the string representation of a time interval to its System.TimeSpan equivalent by using the specified formats, culture-specific format information, and styles. The format of the string representation must match one of the specified formats exactly.
  Returns: A time interval that corresponds to input, as specified by formats, formatProvider, and styles.
  Parameters:
    - input (System.ReadOnlySpan`1[System.Char]): A span that specifies the time interval to convert.
    - formats (System.String[]): An array of standard or custom format strings that define the required format of input.
    - format-provider (System.IFormatProvider): An object that provides culture-specific formatting information.
    - styles (System.Globalization.TimeSpanStyles): A bitwise combination of enumeration values that defines the style elements that may be present in input.
"
  (cl:cond
    ((cl:and (cl:stringp input) (cl:stringp format) (cl:or (cl:null format-provider) (dotnet:object-type format-provider)) supplied-styles (cl:or (cl:null styles) (dotnet:object-type styles)))
     (dotnet:static <type-str> "ParseExact" input format format-provider styles))
    ((cl:and (cl:or (cl:null input) (dotnet:object-type input)) (cl:or (cl:null format) (dotnet:object-type format)) (cl:or (cl:null format-provider) (dotnet:object-type format-provider)) supplied-styles (cl:or (cl:null styles) (dotnet:object-type styles)))
     (dotnet:static <type-str> "ParseExact" input format format-provider styles))
    ((cl:and (cl:stringp input) (cl:or (cl:null format) (dotnet:object-type format)) (cl:or (cl:null format-provider) (dotnet:object-type format-provider)) supplied-styles (cl:or (cl:null styles) (dotnet:object-type styles)))
     (dotnet:static <type-str> "ParseExact" input format format-provider styles))
    ((cl:and (cl:or (cl:null input) (dotnet:object-type input)) (cl:or (cl:null format) (dotnet:object-type format)) (cl:or (cl:null format-provider) (dotnet:object-type format-provider)) supplied-styles (cl:or (cl:null styles) (dotnet:object-type styles)))
     (dotnet:static <type-str> "ParseExact" input format format-provider styles))
    ((cl:and (cl:stringp input) (cl:stringp format) (cl:or (cl:null format-provider) (dotnet:object-type format-provider)) (cl:not supplied-styles))
     (dotnet:static <type-str> "ParseExact" input format format-provider))
    ((cl:and (cl:stringp input) (cl:or (cl:null format) (dotnet:object-type format)) (cl:or (cl:null format-provider) (dotnet:object-type format-provider)) (cl:not supplied-styles))
     (dotnet:static <type-str> "ParseExact" input format format-provider))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "ParseExact"
                    :supplied-args (cl:append (cl:list :input input) (cl:list :format format) (cl:list :format-provider format-provider) (cl:when supplied-styles (cl:list :styles styles)))))))

;; Note: System.TimeSpan.ParseExact also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   ParseExact(Char], Char], IFormatProvider, TimeSpanStyles) -> TimeSpan
;;   ParseExact(Char], String[], IFormatProvider, TimeSpanStyles) -> TimeSpan

(cl:defun subtract (obj! ts)
  "Summary: Returns a new System.TimeSpan object whose value is the difference between the specified System.TimeSpan object and this instance.
Returns: A new time interval whose value is the result of the value of this instance minus the value of ts.
Parameters:
  - ts (System.TimeSpan): The time interval to be subtracted.
"
  (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "Subtract" ts))

(cl:defun to-string (obj! cl:&optional (format cl:nil supplied-format) (format-provider cl:nil supplied-format-provider))
  "Master wrapper for System.TimeSpan.ToString overloads. Dispatches at runtime.

ToString() -> String
  Summary: Converts the value of the current System.TimeSpan object to its equivalent string representation.
  Returns: The string representation of the current System.TimeSpan value.

ToString(String) -> String
  Summary: Converts the value of the current System.TimeSpan object to its equivalent string representation by using the specified format.
  Returns: The string representation of the current System.TimeSpan value in the format specified by the format parameter.
  Parameters:
    - format (System.String): A standard or custom System.TimeSpan format string.

ToString(String, IFormatProvider) -> String
  Summary: Converts the value of the current System.TimeSpan object to its equivalent string representation by using the specified format and culture-specific formatting information.
  Returns: The string representation of the current System.TimeSpan value, as specified by format and formatProvider.
  Parameters:
    - format (System.String): A standard or custom System.TimeSpan format string.
    - format-provider (System.IFormatProvider): An object that supplies culture-specific formatting information.
"
  (cl:cond
    ((cl:and supplied-format (cl:stringp format) supplied-format-provider (cl:or (cl:null format-provider) (dotnet:object-type format-provider)))
     (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "ToString" format format-provider))
    ((cl:and supplied-format (cl:stringp format) (cl:not supplied-format-provider))
     (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "ToString" format))
    ((cl:and (cl:not supplied-format) (cl:not supplied-format-provider))
     (dotnet:invoke (cl:the (dotnet "System.TimeSpan") obj!) "ToString"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TIME-SPAN"
                    :class-name <type-str>
                    :method-name "ToString"
                    :supplied-args (cl:append (cl:when supplied-format (cl:list :format format)) (cl:when supplied-format-provider (cl:list :format-provider format-provider)))))))

;; The following C# System.TimeSpan.TryFormat overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   TryFormat(Char], out Int32&, Char], IFormatProvider) -> Boolean
;;   TryFormat(Byte], out Int32&, Char], IFormatProvider) -> Boolean

;; The following C# System.TimeSpan.TryParse overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   TryParse(String, out TimeSpan&) -> Boolean
;;   TryParse(Char], out TimeSpan&) -> Boolean
;;   TryParse(String, IFormatProvider, out TimeSpan&) -> Boolean
;;   TryParse(Char], IFormatProvider, out TimeSpan&) -> Boolean

;; The following C# System.TimeSpan.TryParseExact overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   TryParseExact(String, String, IFormatProvider, out TimeSpan&) -> Boolean
;;   TryParseExact(Char], Char], IFormatProvider, out TimeSpan&) -> Boolean
;;   TryParseExact(String, String[], IFormatProvider, out TimeSpan&) -> Boolean
;;   TryParseExact(Char], String[], IFormatProvider, out TimeSpan&) -> Boolean
;;   TryParseExact(String, String, IFormatProvider, TimeSpanStyles, out TimeSpan&) -> Boolean
;;   TryParseExact(Char], Char], IFormatProvider, TimeSpanStyles, out TimeSpan&) -> Boolean
;;   TryParseExact(String, String[], IFormatProvider, TimeSpanStyles, out TimeSpan&) -> Boolean
;;   TryParseExact(Char], String[], IFormatProvider, TimeSpanStyles, out TimeSpan&) -> Boolean

