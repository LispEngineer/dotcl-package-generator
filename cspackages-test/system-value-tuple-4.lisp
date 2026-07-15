;;; Generated automatically. Do not edit.
;;; Class: System.ValueTuple`4
;;; Generator Version: 49
;;; Creation Date: 2026-07-15T02:38:57Z

(cl:in-package :system-value-tuple-4)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.ValueTuple`4"))
(cl:defconstant <type-str> "System.ValueTuple`4")
(cl:defconstant <creation> "2026-07-15T02:38:57Z")
(cl:defconstant <version> 49)

(cl:defun new (cl:&optional (item1 cl:nil supplied-item1) (item2 cl:nil supplied-item2) (item3 cl:nil supplied-item3) (item4 cl:nil supplied-item4))
  "Master wrapper for System.ValueTuple`4 constructor overloads. Dispatches at runtime.

new()

new(T1, T2, T3, T4)
  Summary: Initializes a new System.ValueTuple`4 instance.
  Parameters:
    - item1 (T1): The value tuple's first element.
    - item2 (T2): The value tuple's second element.
    - item3 (T3): The value tuple's third element.
    - item4 (T4): The value tuple's fourth element.
"
  (cl:cond
    ((cl:and supplied-item1 (cl:or (cl:null item1) (dotnet:is-instance-of item1 "T1")) supplied-item2 (cl:or (cl:null item2) (dotnet:is-instance-of item2 "T2")) supplied-item3 (cl:or (cl:null item3) (dotnet:is-instance-of item3 "T3")) supplied-item4 (cl:or (cl:null item4) (dotnet:is-instance-of item4 "T4")))
     (dotnet:new <type-str> item1 item2 item3 item4))
    ((cl:and (cl:not supplied-item1) (cl:not supplied-item2) (cl:not supplied-item3) (cl:not supplied-item4))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-VALUE-TUPLE-4"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-item1 (cl:list :item1 item1)) (cl:when supplied-item2 (cl:list :item2 item2)) (cl:when supplied-item3 (cl:list :item3 item3)) (cl:when supplied-item4 (cl:list :item4 item4)))))))

(cl:defun item1 (obj!)
  "Gets the value of the current System.ValueTuple`4 instance's first element."
  (dotnet:invoke (cl:the (dotnet "System.ValueTuple`4") obj!) "Item1"))

;; Note: obj! here is a boxed reference to a .NET value type (struct).
;; This setf mutates that exact boxed instance in place -- it does NOT
;; silently discard the change. However, if obj! is an alias of a shared
;; or cached value (e.g. a memoized constant binding), this mutates
;; that shared instance for every other reference to it too. See
;; FEATURES.md's "Struct Boxing Caveat" section for details.
(cl:defun (cl:setf item1) (new-value obj!)
  "Gets the value of the current System.ValueTuple`4 instance's first element."
  (cl:setf (dotnet:invoke (cl:the (dotnet "System.ValueTuple`4") obj!) "Item1") new-value))

(cl:defun item2 (obj!)
  "Gets the value of the current System.ValueTuple`4 instance's second element."
  (dotnet:invoke (cl:the (dotnet "System.ValueTuple`4") obj!) "Item2"))

;; Note: obj! here is a boxed reference to a .NET value type (struct).
;; This setf mutates that exact boxed instance in place -- it does NOT
;; silently discard the change. However, if obj! is an alias of a shared
;; or cached value (e.g. a memoized constant binding), this mutates
;; that shared instance for every other reference to it too. See
;; FEATURES.md's "Struct Boxing Caveat" section for details.
(cl:defun (cl:setf item2) (new-value obj!)
  "Gets the value of the current System.ValueTuple`4 instance's second element."
  (cl:setf (dotnet:invoke (cl:the (dotnet "System.ValueTuple`4") obj!) "Item2") new-value))

(cl:defun item3 (obj!)
  "Gets the value of the current System.ValueTuple`4 instance's third element."
  (dotnet:invoke (cl:the (dotnet "System.ValueTuple`4") obj!) "Item3"))

;; Note: obj! here is a boxed reference to a .NET value type (struct).
;; This setf mutates that exact boxed instance in place -- it does NOT
;; silently discard the change. However, if obj! is an alias of a shared
;; or cached value (e.g. a memoized constant binding), this mutates
;; that shared instance for every other reference to it too. See
;; FEATURES.md's "Struct Boxing Caveat" section for details.
(cl:defun (cl:setf item3) (new-value obj!)
  "Gets the value of the current System.ValueTuple`4 instance's third element."
  (cl:setf (dotnet:invoke (cl:the (dotnet "System.ValueTuple`4") obj!) "Item3") new-value))

(cl:defun item4 (obj!)
  "Gets the value of the current System.ValueTuple`4 instance's fourth element."
  (dotnet:invoke (cl:the (dotnet "System.ValueTuple`4") obj!) "Item4"))

;; Note: obj! here is a boxed reference to a .NET value type (struct).
;; This setf mutates that exact boxed instance in place -- it does NOT
;; silently discard the change. However, if obj! is an alias of a shared
;; or cached value (e.g. a memoized constant binding), this mutates
;; that shared instance for every other reference to it too. See
;; FEATURES.md's "Struct Boxing Caveat" section for details.
(cl:defun (cl:setf item4) (new-value obj!)
  "Gets the value of the current System.ValueTuple`4 instance's fourth element."
  (cl:setf (dotnet:invoke (cl:the (dotnet "System.ValueTuple`4") obj!) "Item4") new-value))

(cl:defun compare-to (obj! other)
  "Summary: Compares the current System.ValueTuple`4 instance to a specified System.ValueTuple`4 instance.
Returns: A signed integer that indicates the relative position of this instance and other in the sort order, as shown in the following table. Value Description A negative integer This instance precedes other. Zero This instance and other have the same position in the sort order. A positive integer This instance follows other.
Parameters:
  - other (System.ValueTuple`4[T1, T2, T3, T4]): The tuple to compare with this instance.
"
  (dotnet:invoke (cl:the (dotnet "System.ValueTuple`4") obj!) "CompareTo" other))

(cl:defun equals (obj! obj)
  "Master wrapper for System.ValueTuple`4.Equals overloads. Dispatches at runtime.

Equals(Object) -> Boolean
  Summary: Returns a value that indicates whether the current System.ValueTuple`4 instance is equal to a specified object.
  Returns: if the current instance is equal to the specified object; otherwise, .
  Parameters:
    - obj (System.Object): The object to compare with this instance.

Equals(ValueTuple) -> Boolean
  Summary: Returns a value that indicates whether the current System.ValueTuple`4 instance is equal to a specified System.ValueTuple`4 instance.
  Returns: if the current instance is equal to the specified tuple; otherwise, .
  Parameters:
    - other (System.ValueTuple`4[T1, T2, T3, T4]): The value tuple to compare with this instance.
"
  (cl:cond
    ((cl:and (cl:or (cl:null obj) (dotnet:is-instance-of obj "System.Object")))
     (dotnet:invoke (cl:the (dotnet "System.ValueTuple`4") obj!) "Equals" obj))
    ((cl:and (cl:or (cl:null obj) (dotnet:is-instance-of obj "System.ValueTuple`4[T1, T2, T3, T4]")))
     (dotnet:invoke (cl:the (dotnet "System.ValueTuple`4") obj!) "Equals" obj))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-VALUE-TUPLE-4"
                    :class-name <type-str>
                    :method-name "Equals"
                    :supplied-args (cl:append (cl:list :obj obj))))))

(cl:defun get-hash-code (obj!)
  "Summary: Calculates the hash code for the current System.ValueTuple`4 instance.
Returns: The hash code for the current System.ValueTuple`4 instance.
"
  (dotnet:invoke (cl:the (dotnet "System.ValueTuple`4") obj!) "GetHashCode"))

(cl:defun to-string (obj!)
  "Summary: Returns a string that represents the value of this System.ValueTuple`4 instance.
Returns: The string representation of this System.ValueTuple`4 instance.
"
  (dotnet:invoke (cl:the (dotnet "System.ValueTuple`4") obj!) "ToString"))

