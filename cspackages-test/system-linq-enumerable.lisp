;;; Generated automatically. Do not edit.
;;; Class: System.Linq.Enumerable
;;; Generator Version: 18
;;; Creation Date: 2026-07-02T22:15:33Z

(cl:in-package :cl-user)

(cl:defpackage :system-linq-enumerable
  (:use :cl)
  (:shadow
   #:append
   #:count
   #:first
   #:last
   #:max
   #:min
   #:reverse
   #:sequence
   #:union
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:aggregate
   #:all
   #:any
   #:any-i-enumerable
   #:any-i-enumerable-boolean]
   #:append
   #:as-enumerable
   #:average
   #:average-int32]
   #:average-int64]
   #:average-single]
   #:average-double]
   #:average-decimal]
   #:average-int32]]
   #:average-int64]]
   #:average-single]]
   #:average-double]]
   #:average-decimal]]
   #:average-i-enumerable-int32]
   #:average-i-enumerable-int64]
   #:average-i-enumerable-single]
   #:average-i-enumerable-double]
   #:average-i-enumerable-decimal]
   #:average-i-enumerable-int32]]
   #:average-i-enumerable-int64]]
   #:average-i-enumerable-single]]
   #:average-i-enumerable-double]]
   #:average-i-enumerable-decimal]]
   #:cast
   #:chunk
   #:concat
   #:contains
   #:contains-i-enumerable-t-source
   #:contains-i-enumerable-t-source-i-equality-comparer
   #:count
   #:count-i-enumerable
   #:count-i-enumerable-boolean]
   #:default-if-empty
   #:default-if-empty-i-enumerable
   #:default-if-empty-i-enumerable-t-source
   #:distinct
   #:distinct-i-enumerable
   #:distinct-i-enumerable-i-equality-comparer
   #:element-at
   #:element-at-i-enumerable-int32
   #:element-at-i-enumerable-index
   #:element-at-or-default
   #:element-at-or-default-i-enumerable-int32
   #:element-at-or-default-i-enumerable-index
   #:empty
   #:except
   #:except-i-enumerable-i-enumerable
   #:except-i-enumerable-i-enumerable-i-equality-comparer
   #:first
   #:first-i-enumerable
   #:first-i-enumerable-boolean]
   #:first-or-default
   #:first-or-default-i-enumerable
   #:first-or-default-i-enumerable-t-source
   #:first-or-default-i-enumerable-boolean]
   #:first-or-default-i-enumerable-boolean]-t-source
   #:index
   #:infinite-sequence
   #:intersect
   #:intersect-i-enumerable-i-enumerable
   #:intersect-i-enumerable-i-enumerable-i-equality-comparer
   #:last
   #:last-i-enumerable
   #:last-i-enumerable-boolean]
   #:last-or-default
   #:last-or-default-i-enumerable
   #:last-or-default-i-enumerable-t-source
   #:last-or-default-i-enumerable-boolean]
   #:last-or-default-i-enumerable-boolean]-t-source
   #:long-count
   #:long-count-i-enumerable
   #:long-count-i-enumerable-boolean]
   #:max
   #:max-int32]
   #:max-int64]
   #:max-int32]]
   #:max-int64]]
   #:max-double]
   #:max-double]]
   #:max-single]
   #:max-single]]
   #:max-decimal]
   #:max-decimal]]
   #:max-i-enumerable
   #:max-i-enumerable-i-comparer
   #:max-i-enumerable-int32]
   #:max-i-enumerable-int32]]
   #:max-i-enumerable-int64]
   #:max-i-enumerable-int64]]
   #:max-i-enumerable-single]
   #:max-i-enumerable-single]]
   #:max-i-enumerable-double]
   #:max-i-enumerable-double]]
   #:max-i-enumerable-decimal]
   #:max-i-enumerable-decimal]]
   #:min
   #:min-int32]
   #:min-int64]
   #:min-int32]]
   #:min-int64]]
   #:min-single]
   #:min-single]]
   #:min-double]
   #:min-double]]
   #:min-decimal]
   #:min-decimal]]
   #:min-i-enumerable
   #:min-i-enumerable-i-comparer
   #:min-i-enumerable-int32]
   #:min-i-enumerable-int32]]
   #:min-i-enumerable-int64]
   #:min-i-enumerable-int64]]
   #:min-i-enumerable-single]
   #:min-i-enumerable-single]]
   #:min-i-enumerable-double]
   #:min-i-enumerable-double]]
   #:min-i-enumerable-decimal]
   #:min-i-enumerable-decimal]]
   #:of-type
   #:order
   #:order-i-enumerable
   #:order-i-enumerable-i-comparer
   #:order-descending
   #:order-descending-i-enumerable
   #:order-descending-i-enumerable-i-comparer
   #:prepend
   #:range
   #:repeat
   #:reverse
   #:reverse-i-enumerable
   #:reverse-t-source[]
   #:sequence
   #:sequence-equal
   #:sequence-equal-i-enumerable-i-enumerable
   #:sequence-equal-i-enumerable-i-enumerable-i-equality-comparer
   #:shuffle
   #:single
   #:single-i-enumerable
   #:single-i-enumerable-boolean]
   #:single-or-default
   #:single-or-default-i-enumerable
   #:single-or-default-i-enumerable-t-source
   #:single-or-default-i-enumerable-boolean]
   #:single-or-default-i-enumerable-boolean]-t-source
   #:skip
   #:skip-last
   #:skip-while
   #:skip-while-i-enumerable-boolean]
   #:sum
   #:sum-int32]
   #:sum-int64]
   #:sum-single]
   #:sum-double]
   #:sum-decimal]
   #:sum-int32]]
   #:sum-int64]]
   #:sum-single]]
   #:sum-double]]
   #:sum-decimal]]
   #:sum-i-enumerable-int32]
   #:sum-i-enumerable-int64]
   #:sum-i-enumerable-single]
   #:sum-i-enumerable-double]
   #:sum-i-enumerable-decimal]
   #:sum-i-enumerable-int32]]
   #:sum-i-enumerable-int64]]
   #:sum-i-enumerable-single]]
   #:sum-i-enumerable-double]]
   #:sum-i-enumerable-decimal]]
   #:take
   #:take-i-enumerable-int32
   #:take-i-enumerable-range
   #:take-last
   #:take-while
   #:take-while-i-enumerable-boolean]
   #:to-array
   #:to-hash-set
   #:to-hash-set-i-enumerable
   #:to-hash-set-i-enumerable-i-equality-comparer
   #:to-list
   #:union
   #:union-i-enumerable-i-enumerable
   #:union-i-enumerable-i-enumerable-i-equality-comparer
   #:where
   #:where-i-enumerable-boolean]
  ))

(cl:in-package :system-linq-enumerable)

(cl:defconstant <type> (monoutils:get-type "System.Linq.Enumerable"))
(cl:defconstant <type-str> "System.Linq.Enumerable")
(cl:defconstant <creation> "2026-07-02T22:15:33Z")
(cl:defconstant <version> 18)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Linq.Enumerable")))

(cl:defun aggregate (type source func)
  "Summary: Applies an accumulator function over a sequence.
Returns: The final accumulator value.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to aggregate over.
  - func (System.Func`3[TSource, TSource, TSource]): An accumulator function to be invoked on each element.
"
  (dotnet:static-generic <type-str> "Aggregate" (cl:list type) source func))

;; The following C# System.Linq.Enumerable.AggregateBy overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   AggregateBy(IEnumerable, Func, TAccumulate, Func, IEqualityComparer) -> KeyValuePair
;;   AggregateBy(IEnumerable, Func, Func, Func, IEqualityComparer) -> KeyValuePair

(cl:defun all (type source predicate)
  "Summary: Determines whether all elements of a sequence satisfy a condition.
Returns: if every element of the source sequence passes the test in the specified predicate, or if the sequence is empty; otherwise, .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 that contains the elements to apply the predicate to.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (dotnet:static-generic <type-str> "All" (cl:list type) source predicate))

(cl:defun any (type source cl:&optional (predicate cl:nil supplied-predicate))
  "Master wrapper for System.Linq.Enumerable.Any overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-predicate (cl:or (cl:null predicate) (monoutils:dotnet-p predicate)))
     (dotnet:static-generic <type-str> "Any" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-predicate))
     (dotnet:static-generic <type-str> "Any" (cl:list type) source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Any"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-predicate (cl:list :predicate predicate)))))))

(cl:defun any-i-enumerable (type source)
  "Calls System.Linq.Enumerable.Any Any(IEnumerable) -> Boolean. Summary: Determines whether a sequence contains any elements.
Returns: if the source sequence contains any elements; otherwise, .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): The System.Collections.Generic.IEnumerable`1 to check for emptiness.
"
  (dotnet:static-generic <type-str> "Any" (cl:list type) source))

(cl:defun any-i-enumerable-boolean] (type source predicate)
  "Calls System.Linq.Enumerable.Any Any(IEnumerable, Boolean]) -> Boolean. Summary: Determines whether any element of a sequence satisfies a condition.
Returns: if the source sequence is not empty and at least one of its elements passes the test in the specified predicate; otherwise, .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements to apply the predicate to.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (dotnet:static-generic <type-str> "Any" (cl:list type) source predicate))

(cl:defun append (type source element)
  "Summary: Appends a value to the end of the sequence.
Returns: A new sequence that ends with element.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values.
  - element (TSource): The value to append to source.
"
  (dotnet:static-generic <type-str> "Append" (cl:list type) source element))

(cl:defun as-enumerable (type source)
  "Summary: Returns the input typed as System.Collections.Generic.IEnumerable`1.
Returns: The input sequence typed as System.Collections.Generic.IEnumerable`1.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to type as System.Collections.Generic.IEnumerable`1.
"
  (dotnet:static-generic <type-str> "AsEnumerable" (cl:list type) source))

(cl:defun average (source cl:&optional (selector cl:nil supplied-selector))
  "Master wrapper for System.Linq.Enumerable.Average overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Average" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Average" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Average" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Average" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Average" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Average" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Average" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Average" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Average" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Average" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Average" source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Average"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-selector (cl:list :selector selector)))))))

(cl:defun average-int32] (source)
  "Calls System.Linq.Enumerable.Average Average(Int32]) -> Double. Summary: Computes the average of a sequence of System.Int32 values.
Returns: The average of the sequence of values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Int32]): A sequence of System.Int32 values to calculate the average of.
"
  (dotnet:static <type-str> "Average" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Int32]") source)))

(cl:defun average-int64] (source)
  "Calls System.Linq.Enumerable.Average Average(Int64]) -> Double. Summary: Computes the average of a sequence of System.Int64 values.
Returns: The average of the sequence of values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Int64]): A sequence of System.Int64 values to calculate the average of.
"
  (dotnet:static <type-str> "Average" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Int64]") source)))

(cl:defun average-single] (source)
  "Calls System.Linq.Enumerable.Average Average(Single]) -> Single. Summary: Computes the average of a sequence of System.Single values.
Returns: The average of the sequence of values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Single]): A sequence of System.Single values to calculate the average of.
"
  (dotnet:static <type-str> "Average" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Single]") source)))

(cl:defun average-double] (source)
  "Calls System.Linq.Enumerable.Average Average(Double]) -> Double. Summary: Computes the average of a sequence of System.Double values.
Returns: The average of the sequence of values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Double]): A sequence of System.Double values to calculate the average of.
"
  (dotnet:static <type-str> "Average" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Double]") source)))

(cl:defun average-decimal] (source)
  "Calls System.Linq.Enumerable.Average Average(Decimal]) -> Decimal. Summary: Computes the average of a sequence of System.Decimal values.
Returns: The average of the sequence of values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Decimal]): A sequence of System.Decimal values to calculate the average of.
"
  (dotnet:static <type-str> "Average" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Decimal]") source)))

(cl:defun average-int32]] (source)
  "Calls System.Linq.Enumerable.Average Average(Int32]]) -> Double]. Summary: Computes the average of a sequence of nullable System.Int32 values.
Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int32]]): A sequence of nullable System.Int32 values to calculate the average of.
"
  (dotnet:static <type-str> "Average" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int32]]") source)))

(cl:defun average-int64]] (source)
  "Calls System.Linq.Enumerable.Average Average(Int64]]) -> Double]. Summary: Computes the average of a sequence of nullable System.Int64 values.
Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int64]]): A sequence of nullable System.Int64 values to calculate the average of.
"
  (dotnet:static <type-str> "Average" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int64]]") source)))

(cl:defun average-single]] (source)
  "Calls System.Linq.Enumerable.Average Average(Single]]) -> Single]. Summary: Computes the average of a sequence of nullable System.Single values.
Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Single]]): A sequence of nullable System.Single values to calculate the average of.
"
  (dotnet:static <type-str> "Average" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Single]]") source)))

(cl:defun average-double]] (source)
  "Calls System.Linq.Enumerable.Average Average(Double]]) -> Double]. Summary: Computes the average of a sequence of nullable System.Double values.
Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Double]]): A sequence of nullable System.Double values to calculate the average of.
"
  (dotnet:static <type-str> "Average" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Double]]") source)))

(cl:defun average-decimal]] (source)
  "Calls System.Linq.Enumerable.Average Average(Decimal]]) -> Decimal]. Summary: Computes the average of a sequence of nullable System.Decimal values.
Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Decimal]]): A sequence of nullable System.Decimal values to calculate the average of.
"
  (dotnet:static <type-str> "Average" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Decimal]]") source)))

(cl:defun average-i-enumerable-int32] (type source selector)
  "Calls System.Linq.Enumerable.Average Average(IEnumerable, Int32]) -> Double. Summary: Computes the average of a sequence of System.Int32 values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The average of the sequence of values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
  - selector (System.Func`2[TSource, System.Int32]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))

(cl:defun average-i-enumerable-int64] (type source selector)
  "Calls System.Linq.Enumerable.Average Average(IEnumerable, Int64]) -> Double. Summary: Computes the average of a sequence of System.Int64 values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The average of the sequence of values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
  - selector (System.Func`2[TSource, System.Int64]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))

(cl:defun average-i-enumerable-single] (type source selector)
  "Calls System.Linq.Enumerable.Average Average(IEnumerable, Single]) -> Single. Summary: Computes the average of a sequence of System.Single values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The average of the sequence of values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
  - selector (System.Func`2[TSource, System.Single]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))

(cl:defun average-i-enumerable-double] (type source selector)
  "Calls System.Linq.Enumerable.Average Average(IEnumerable, Double]) -> Double. Summary: Computes the average of a sequence of System.Double values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The average of the sequence of values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
  - selector (System.Func`2[TSource, System.Double]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))

(cl:defun average-i-enumerable-decimal] (type source selector)
  "Calls System.Linq.Enumerable.Average Average(IEnumerable, Decimal]) -> Decimal. Summary: Computes the average of a sequence of System.Decimal values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The average of the sequence of values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate an average.
  - selector (System.Func`2[TSource, System.Decimal]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))

(cl:defun average-i-enumerable-int32]] (type source selector)
  "Calls System.Linq.Enumerable.Average Average(IEnumerable, Int32]]) -> Double]. Summary: Computes the average of a sequence of nullable System.Int32 values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Int32]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))

(cl:defun average-i-enumerable-int64]] (type source selector)
  "Calls System.Linq.Enumerable.Average Average(IEnumerable, Int64]]) -> Double]. Summary: Computes the average of a sequence of nullable System.Int64 values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Int64]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))

(cl:defun average-i-enumerable-single]] (type source selector)
  "Calls System.Linq.Enumerable.Average Average(IEnumerable, Single]]) -> Single]. Summary: Computes the average of a sequence of nullable System.Single values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Single]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))

(cl:defun average-i-enumerable-double]] (type source selector)
  "Calls System.Linq.Enumerable.Average Average(IEnumerable, Double]]) -> Double]. Summary: Computes the average of a sequence of nullable System.Double values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Double]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))

(cl:defun average-i-enumerable-decimal]] (type source selector)
  "Calls System.Linq.Enumerable.Average Average(IEnumerable, Decimal]]) -> Decimal]. Summary: Computes the average of a sequence of nullable System.Decimal values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Decimal]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))

(cl:defun cast (type source)
  "Summary: Casts the elements of an System.Collections.IEnumerable to the specified type.
Returns: An System.Collections.Generic.IEnumerable`1 that contains each element of the source sequence cast to the specified type.
Parameters:
  - source (System.Collections.IEnumerable): The System.Collections.IEnumerable that contains the elements to be cast to type .
"
  (dotnet:static-generic <type-str> "Cast" (cl:list type) source))

(cl:defun chunk (type source size)
  "Summary: Splits the elements of a sequence into chunks of size at most size.
Returns: An System.Collections.Generic.IEnumerable`1 that contains the elements the input sequence split into chunks of size size.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements to chunk.
  - size (System.Int32): The maximum size of each chunk.
"
  (dotnet:static-generic <type-str> "Chunk" (cl:list type) source size))

(cl:defun concat (type first second)
  "Summary: Concatenates two sequences.
Returns: An System.Collections.Generic.IEnumerable`1 that contains the concatenated elements of the two input sequences.
Parameters:
  - first (System.Collections.Generic.IEnumerable`1[TSource]): The first sequence to concatenate.
  - second (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to concatenate to the first sequence.
"
  (dotnet:static-generic <type-str> "Concat" (cl:list type) first second))

(cl:defun contains (type source value cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.Contains overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:or (cl:null value) (monoutils:dotnet-p value)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static-generic <type-str> "Contains" (cl:list type) source value comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:or (cl:null value) (monoutils:dotnet-p value)) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "Contains" (cl:list type) source value))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Contains"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :value value) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun contains-i-enumerable-t-source (type source value)
  "Calls System.Linq.Enumerable.Contains Contains(IEnumerable, TSource) -> Boolean. Summary: Determines whether a sequence contains a specified element by using the default equality comparer.
Returns: if the source sequence contains an element that has the specified value; otherwise, .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence in which to locate a value.
  - value (TSource): The value to locate in the sequence.
"
  (dotnet:static-generic <type-str> "Contains" (cl:list type) source value))

(cl:defun contains-i-enumerable-t-source-i-equality-comparer (type source value comparer)
  "Calls System.Linq.Enumerable.Contains Contains(IEnumerable, TSource, IEqualityComparer) -> Boolean. Summary: Determines whether a sequence contains a specified element by using a specified System.Collections.Generic.IEqualityComparer`1.
Returns: if the source sequence contains an element that has the specified value; otherwise, .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence in which to locate a value.
  - value (TSource): The value to locate in the sequence.
  - comparer (System.Collections.Generic.IEqualityComparer`1[TSource]): An equality comparer to compare values.
"
  (dotnet:static-generic <type-str> "Contains" (cl:list type) source value comparer))

(cl:defun count (type source cl:&optional (predicate cl:nil supplied-predicate))
  "Master wrapper for System.Linq.Enumerable.Count overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-predicate (cl:or (cl:null predicate) (monoutils:dotnet-p predicate)))
     (dotnet:static-generic <type-str> "Count" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-predicate))
     (dotnet:static-generic <type-str> "Count" (cl:list type) source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Count"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-predicate (cl:list :predicate predicate)))))))

(cl:defun count-i-enumerable (type source)
  "Calls System.Linq.Enumerable.Count Count(IEnumerable) -> Int32. Summary: Returns the number of elements in a sequence.
Returns: The number of elements in the input sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence that contains elements to be counted.
"
  (dotnet:static-generic <type-str> "Count" (cl:list type) source))

(cl:defun count-i-enumerable-boolean] (type source predicate)
  "Calls System.Linq.Enumerable.Count Count(IEnumerable, Boolean]) -> Int32. Summary: Returns a number that represents how many elements in the specified sequence satisfy a condition.
Returns: A number that represents how many elements in the sequence satisfy the condition in the predicate function.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence that contains elements to be tested and counted.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (dotnet:static-generic <type-str> "Count" (cl:list type) source predicate))

;; The following C# System.Linq.Enumerable.CountBy overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   CountBy(IEnumerable, Func, IEqualityComparer) -> Int32]]

(cl:defun default-if-empty (type source cl:&optional (default-value cl:nil supplied-default-value))
  "Master wrapper for System.Linq.Enumerable.DefaultIfEmpty overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-default-value (cl:or (cl:null default-value) (monoutils:dotnet-p default-value)))
     (dotnet:static-generic <type-str> "DefaultIfEmpty" (cl:list type) source default-value))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-default-value))
     (dotnet:static-generic <type-str> "DefaultIfEmpty" (cl:list type) source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "DefaultIfEmpty"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-default-value (cl:list :default-value default-value)))))))

(cl:defun default-if-empty-i-enumerable (type source)
  "Calls System.Linq.Enumerable.DefaultIfEmpty DefaultIfEmpty(IEnumerable) -> IEnumerable. Summary: Returns the elements of the specified sequence or the type parameter's default value in a singleton collection if the sequence is empty.
Returns: An System.Collections.Generic.IEnumerable`1 object that contains the default value for the type if source is empty; otherwise, source.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to return a default value for if it is empty.
"
  (dotnet:static-generic <type-str> "DefaultIfEmpty" (cl:list type) source))

(cl:defun default-if-empty-i-enumerable-t-source (type source default-value)
  "Calls System.Linq.Enumerable.DefaultIfEmpty DefaultIfEmpty(IEnumerable, TSource) -> IEnumerable. Summary: Returns the elements of the specified sequence or the specified value in a singleton collection if the sequence is empty.
Returns: An System.Collections.Generic.IEnumerable`1 that contains defaultValue if source is empty; otherwise, source.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to return the specified value for if it is empty.
  - default-value (TSource): The value to return if the sequence is empty.
"
  (dotnet:static-generic <type-str> "DefaultIfEmpty" (cl:list type) source default-value))

(cl:defun distinct (type source cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.Distinct overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static-generic <type-str> "Distinct" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "Distinct" (cl:list type) source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Distinct"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun distinct-i-enumerable (type source)
  "Calls System.Linq.Enumerable.Distinct Distinct(IEnumerable) -> IEnumerable. Summary: Returns distinct elements from a sequence by using the default equality comparer to compare values.
Returns: An System.Collections.Generic.IEnumerable`1 that contains distinct elements from the source sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to remove duplicate elements from.
"
  (dotnet:static-generic <type-str> "Distinct" (cl:list type) source))

(cl:defun distinct-i-enumerable-i-equality-comparer (type source comparer)
  "Calls System.Linq.Enumerable.Distinct Distinct(IEnumerable, IEqualityComparer) -> IEnumerable. Summary: Returns distinct elements from a sequence by using a specified System.Collections.Generic.IEqualityComparer`1 to compare values.
Returns: An System.Collections.Generic.IEnumerable`1 that contains distinct elements from the source sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to remove duplicate elements from.
  - comparer (System.Collections.Generic.IEqualityComparer`1[TSource]): An System.Collections.Generic.IEqualityComparer`1 to compare values.
"
  (dotnet:static-generic <type-str> "Distinct" (cl:list type) source comparer))

;; The following C# System.Linq.Enumerable.DistinctBy overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

(cl:defun element-at (type source index)
  "Master wrapper for System.Linq.Enumerable.ElementAt overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:numberp index))
     (dotnet:static-generic <type-str> "ElementAt" (cl:list type) source index))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:or (cl:null index) (monoutils:dotnet-p index)))
     (dotnet:static-generic <type-str> "ElementAt" (cl:list type) source index))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "ElementAt"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :index index))))))

(cl:defun element-at-i-enumerable-int32 (type source index)
  "Calls System.Linq.Enumerable.ElementAt ElementAt(IEnumerable, Int32) -> TSource. Summary: Returns the element at a specified index in a sequence.
Returns: The element at the specified position in the source sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
  - index (System.Int32): The zero-based index of the element to retrieve.
"
  (dotnet:static-generic <type-str> "ElementAt" (cl:list type) source index))

(cl:defun element-at-i-enumerable-index (type source index)
  "Calls System.Linq.Enumerable.ElementAt ElementAt(IEnumerable, Index) -> TSource. Summary: Returns the element at a specified index in a sequence.
Returns: The element at the specified position in the source sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
  - index (System.Index): The index of the element to retrieve, which is either from the beginning or the end of the sequence.
"
  (dotnet:static-generic <type-str> "ElementAt" (cl:list type) source index))

(cl:defun element-at-or-default (type source index)
  "Master wrapper for System.Linq.Enumerable.ElementAtOrDefault overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:numberp index))
     (dotnet:static-generic <type-str> "ElementAtOrDefault" (cl:list type) source index))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:or (cl:null index) (monoutils:dotnet-p index)))
     (dotnet:static-generic <type-str> "ElementAtOrDefault" (cl:list type) source index))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "ElementAtOrDefault"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :index index))))))

(cl:defun element-at-or-default-i-enumerable-int32 (type source index)
  "Calls System.Linq.Enumerable.ElementAtOrDefault ElementAtOrDefault(IEnumerable, Int32) -> TSource. Summary: Returns the element at a specified index in a sequence or a default value if the index is out of range.
Returns: () if the index is outside the bounds of the source sequence; otherwise, the element at the specified position in the source sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
  - index (System.Int32): The zero-based index of the element to retrieve.
"
  (dotnet:static-generic <type-str> "ElementAtOrDefault" (cl:list type) source index))

(cl:defun element-at-or-default-i-enumerable-index (type source index)
  "Calls System.Linq.Enumerable.ElementAtOrDefault ElementAtOrDefault(IEnumerable, Index) -> TSource. Summary: Returns the element at a specified index in a sequence or a default value if the index is out of range.
Returns: if index is outside the bounds of the source sequence; otherwise, the element at the specified position in the source sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
  - index (System.Index): The index of the element to retrieve, which is either from the beginning or the end of the sequence.
"
  (dotnet:static-generic <type-str> "ElementAtOrDefault" (cl:list type) source index))

(cl:defun empty (type)
  "Summary: Returns an empty System.Collections.Generic.IEnumerable`1 that has the specified type argument.
Returns: An empty System.Collections.Generic.IEnumerable`1 whose type argument is .
"
  (dotnet:static-generic <type-str> "Empty" (cl:list type)))

(cl:defun except (type first second cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.Except overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null first) (monoutils:dotnet-p first)) (cl:or (cl:null second) (monoutils:dotnet-p second)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static-generic <type-str> "Except" (cl:list type) first second comparer))
    ((cl:and (cl:or (cl:null first) (monoutils:dotnet-p first)) (cl:or (cl:null second) (monoutils:dotnet-p second)) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "Except" (cl:list type) first second))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Except"
                    :supplied-args (cl:append (cl:list :first first) (cl:list :second second) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun except-i-enumerable-i-enumerable (type first second)
  "Calls System.Linq.Enumerable.Except Except(IEnumerable, IEnumerable) -> IEnumerable. Summary: Produces the set difference of two sequences by using the default equality comparer to compare values.
Returns: A sequence that contains the set difference of the elements of two sequences.
Parameters:
  - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements that are not also in second will be returned.
  - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements that also occur in the first sequence will cause those elements to be removed from the returned sequence.
"
  (dotnet:static-generic <type-str> "Except" (cl:list type) first second))

(cl:defun except-i-enumerable-i-enumerable-i-equality-comparer (type first second comparer)
  "Calls System.Linq.Enumerable.Except Except(IEnumerable, IEnumerable, IEqualityComparer) -> IEnumerable. Summary: Produces the set difference of two sequences by using the specified System.Collections.Generic.IEqualityComparer`1 to compare values.
Returns: A sequence that contains the set difference of the elements of two sequences.
Parameters:
  - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements that are not also in second will be returned.
  - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements that also occur in the first sequence will cause those elements to be removed from the returned sequence.
  - comparer (System.Collections.Generic.IEqualityComparer`1[TSource]): An System.Collections.Generic.IEqualityComparer`1 to compare values.
"
  (dotnet:static-generic <type-str> "Except" (cl:list type) first second comparer))

;; The following C# System.Linq.Enumerable.ExceptBy overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

(cl:defun first (type source cl:&optional (predicate cl:nil supplied-predicate))
  "Master wrapper for System.Linq.Enumerable.First overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-predicate (cl:or (cl:null predicate) (monoutils:dotnet-p predicate)))
     (dotnet:static-generic <type-str> "First" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-predicate))
     (dotnet:static-generic <type-str> "First" (cl:list type) source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "First"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-predicate (cl:list :predicate predicate)))))))

(cl:defun first-i-enumerable (type source)
  "Calls System.Linq.Enumerable.First First(IEnumerable) -> TSource. Summary: Returns the first element of a sequence.
Returns: The first element in the specified sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): The System.Collections.Generic.IEnumerable`1 to return the first element of.
"
  (dotnet:static-generic <type-str> "First" (cl:list type) source))

(cl:defun first-i-enumerable-boolean] (type source predicate)
  "Calls System.Linq.Enumerable.First First(IEnumerable, Boolean]) -> TSource. Summary: Returns the first element in a sequence that satisfies a specified condition.
Returns: The first element in the sequence that passes the test in the specified predicate function.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (dotnet:static-generic <type-str> "First" (cl:list type) source predicate))

(cl:defun first-or-default (type source cl:&optional (default-value cl:nil supplied-default-value) (default-value cl:nil supplied-default-value))
  "Master wrapper for System.Linq.Enumerable.FirstOrDefault overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-default-value (cl:or (cl:null default-value) (monoutils:dotnet-p default-value)) supplied-default-value (cl:or (cl:null default-value) (monoutils:dotnet-p default-value)))
     (dotnet:static-generic <type-str> "FirstOrDefault" (cl:list type) source default-value default-value))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-default-value (cl:or (cl:null default-value) (monoutils:dotnet-p default-value)) (cl:not supplied-default-value))
     (dotnet:static-generic <type-str> "FirstOrDefault" (cl:list type) source default-value))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-default-value (cl:or (cl:null default-value) (monoutils:dotnet-p default-value)) (cl:not supplied-default-value))
     (dotnet:static-generic <type-str> "FirstOrDefault" (cl:list type) source default-value))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-default-value) (cl:not supplied-default-value))
     (dotnet:static-generic <type-str> "FirstOrDefault" (cl:list type) source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "FirstOrDefault"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-default-value (cl:list :default-value default-value)) (cl:when supplied-default-value (cl:list :default-value default-value)))))))

(cl:defun first-or-default-i-enumerable (type source)
  "Calls System.Linq.Enumerable.FirstOrDefault FirstOrDefault(IEnumerable) -> TSource. Summary: Returns the first element of a sequence, or a default value if the sequence contains no elements.
Returns: () if source is empty; otherwise, the first element in source.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): The System.Collections.Generic.IEnumerable`1 to return the first element of.
"
  (dotnet:static-generic <type-str> "FirstOrDefault" (cl:list type) source))

(cl:defun first-or-default-i-enumerable-t-source (type source default-value)
  "Calls System.Linq.Enumerable.FirstOrDefault FirstOrDefault(IEnumerable, TSource) -> TSource. Summary: Returns the first element of a sequence, or a specified default value if the sequence contains no elements.
Returns: defaultValue if source is empty; otherwise, the first element in source.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): The System.Collections.Generic.IEnumerable`1 to return the first element of.
  - default-value (TSource): The default value to return if the sequence is empty.
"
  (dotnet:static-generic <type-str> "FirstOrDefault" (cl:list type) source default-value))

(cl:defun first-or-default-i-enumerable-boolean] (type source predicate)
  "Calls System.Linq.Enumerable.FirstOrDefault FirstOrDefault(IEnumerable, Boolean]) -> TSource. Summary: Returns the first element of the sequence that satisfies a condition or a default value if no such element is found.
Returns: () if source is empty or if no element passes the test specified by predicate; otherwise, the first element in source that passes the test specified by predicate.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (dotnet:static-generic <type-str> "FirstOrDefault" (cl:list type) source predicate))

(cl:defun first-or-default-i-enumerable-boolean]-t-source (type source predicate default-value)
  "Calls System.Linq.Enumerable.FirstOrDefault FirstOrDefault(IEnumerable, Boolean], TSource) -> TSource. Summary: Returns the first element of the sequence that satisfies a condition, or a specified default value if no such element is found.
Returns: defaultValue if source is empty or if no element passes the test specified by predicate; otherwise, the first element in source that passes the test specified by predicate.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
  - default-value (TSource): The default value to return if the sequence is empty.
"
  (dotnet:static-generic <type-str> "FirstOrDefault" (cl:list type) source predicate default-value))

;; The following C# System.Linq.Enumerable.GroupBy overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

;; The following C# System.Linq.Enumerable.GroupJoin overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

(cl:defun index (type source)
  "Summary: Returns an enumerable that incorporates the element's index into a tuple.
Returns: An enumerable that incorporates each element index into a tuple.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): The source enumerable providing the elements.
"
  (dotnet:static-generic <type-str> "Index" (cl:list type) source))

(cl:defun infinite-sequence (type start step)
  "Summary: Generates an infinite sequence that begins with start and yields additional values each incremented by step.
Returns: An System.Collections.Generic.IEnumerable`1 that contains the sequence.
Parameters:
  - start (T): The starting value.
  - step (T): The amount by which the next yielded value should be incremented from the previous yielded value.
"
  (dotnet:static-generic <type-str> "InfiniteSequence" (cl:list type) start step))

(cl:defun intersect (type first second cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.Intersect overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null first) (monoutils:dotnet-p first)) (cl:or (cl:null second) (monoutils:dotnet-p second)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static-generic <type-str> "Intersect" (cl:list type) first second comparer))
    ((cl:and (cl:or (cl:null first) (monoutils:dotnet-p first)) (cl:or (cl:null second) (monoutils:dotnet-p second)) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "Intersect" (cl:list type) first second))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Intersect"
                    :supplied-args (cl:append (cl:list :first first) (cl:list :second second) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun intersect-i-enumerable-i-enumerable (type first second)
  "Calls System.Linq.Enumerable.Intersect Intersect(IEnumerable, IEnumerable) -> IEnumerable. Summary: Produces the set intersection of two sequences by using the default equality comparer to compare values.
Returns: A sequence that contains the elements that form the set intersection of two sequences.
Parameters:
  - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements that also appear in second will be returned.
  - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements that also appear in the first sequence will be returned.
"
  (dotnet:static-generic <type-str> "Intersect" (cl:list type) first second))

(cl:defun intersect-i-enumerable-i-enumerable-i-equality-comparer (type first second comparer)
  "Calls System.Linq.Enumerable.Intersect Intersect(IEnumerable, IEnumerable, IEqualityComparer) -> IEnumerable. Summary: Produces the set intersection of two sequences by using the specified System.Collections.Generic.IEqualityComparer`1 to compare values.
Returns: A sequence that contains the elements that form the set intersection of two sequences.
Parameters:
  - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements that also appear in second will be returned.
  - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements that also appear in the first sequence will be returned.
  - comparer (System.Collections.Generic.IEqualityComparer`1[TSource]): An System.Collections.Generic.IEqualityComparer`1 to compare values.
"
  (dotnet:static-generic <type-str> "Intersect" (cl:list type) first second comparer))

;; The following C# System.Linq.Enumerable.IntersectBy overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

;; The following C# System.Linq.Enumerable.Join overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

(cl:defun last (type source cl:&optional (predicate cl:nil supplied-predicate))
  "Master wrapper for System.Linq.Enumerable.Last overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-predicate (cl:or (cl:null predicate) (monoutils:dotnet-p predicate)))
     (dotnet:static-generic <type-str> "Last" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-predicate))
     (dotnet:static-generic <type-str> "Last" (cl:list type) source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Last"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-predicate (cl:list :predicate predicate)))))))

(cl:defun last-i-enumerable (type source)
  "Calls System.Linq.Enumerable.Last Last(IEnumerable) -> TSource. Summary: Returns the last element of a sequence.
Returns: The value at the last position in the source sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return the last element of.
"
  (dotnet:static-generic <type-str> "Last" (cl:list type) source))

(cl:defun last-i-enumerable-boolean] (type source predicate)
  "Calls System.Linq.Enumerable.Last Last(IEnumerable, Boolean]) -> TSource. Summary: Returns the last element of a sequence that satisfies a specified condition.
Returns: The last element in the sequence that passes the test in the specified predicate function.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (dotnet:static-generic <type-str> "Last" (cl:list type) source predicate))

(cl:defun last-or-default (type source cl:&optional (default-value cl:nil supplied-default-value) (default-value cl:nil supplied-default-value))
  "Master wrapper for System.Linq.Enumerable.LastOrDefault overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-default-value (cl:or (cl:null default-value) (monoutils:dotnet-p default-value)) supplied-default-value (cl:or (cl:null default-value) (monoutils:dotnet-p default-value)))
     (dotnet:static-generic <type-str> "LastOrDefault" (cl:list type) source default-value default-value))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-default-value (cl:or (cl:null default-value) (monoutils:dotnet-p default-value)) (cl:not supplied-default-value))
     (dotnet:static-generic <type-str> "LastOrDefault" (cl:list type) source default-value))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-default-value (cl:or (cl:null default-value) (monoutils:dotnet-p default-value)) (cl:not supplied-default-value))
     (dotnet:static-generic <type-str> "LastOrDefault" (cl:list type) source default-value))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-default-value) (cl:not supplied-default-value))
     (dotnet:static-generic <type-str> "LastOrDefault" (cl:list type) source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "LastOrDefault"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-default-value (cl:list :default-value default-value)) (cl:when supplied-default-value (cl:list :default-value default-value)))))))

(cl:defun last-or-default-i-enumerable (type source)
  "Calls System.Linq.Enumerable.LastOrDefault LastOrDefault(IEnumerable) -> TSource. Summary: Returns the last element of a sequence, or a default value if the sequence contains no elements.
Returns: () if the source sequence is empty; otherwise, the last element in the System.Collections.Generic.IEnumerable`1.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return the last element of.
"
  (dotnet:static-generic <type-str> "LastOrDefault" (cl:list type) source))

(cl:defun last-or-default-i-enumerable-t-source (type source default-value)
  "Calls System.Linq.Enumerable.LastOrDefault LastOrDefault(IEnumerable, TSource) -> TSource. Summary: Returns the last element of a sequence, or a specified default value if the sequence contains no elements.
Returns: defaultValue if the source sequence is empty; otherwise, the last element in the System.Collections.Generic.IEnumerable`1.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return the last element of.
  - default-value (TSource): The default value to return if the sequence is empty.
"
  (dotnet:static-generic <type-str> "LastOrDefault" (cl:list type) source default-value))

(cl:defun last-or-default-i-enumerable-boolean] (type source predicate)
  "Calls System.Linq.Enumerable.LastOrDefault LastOrDefault(IEnumerable, Boolean]) -> TSource. Summary: Returns the last element of a sequence that satisfies a condition or a default value if no such element is found.
Returns: () if the sequence is empty or if no elements pass the test in the predicate function; otherwise, the last element that passes the test in the predicate function.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (dotnet:static-generic <type-str> "LastOrDefault" (cl:list type) source predicate))

(cl:defun last-or-default-i-enumerable-boolean]-t-source (type source predicate default-value)
  "Calls System.Linq.Enumerable.LastOrDefault LastOrDefault(IEnumerable, Boolean], TSource) -> TSource. Summary: Returns the last element of a sequence that satisfies a condition, or a specified default value if no such element is found.
Returns: defaultValue if the sequence is empty or if no elements pass the test in the predicate function; otherwise, the last element that passes the test in the predicate function.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
  - default-value (TSource): The default value to return if the sequence is empty.
"
  (dotnet:static-generic <type-str> "LastOrDefault" (cl:list type) source predicate default-value))

;; The following C# System.Linq.Enumerable.LeftJoin overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

(cl:defun long-count (type source cl:&optional (predicate cl:nil supplied-predicate))
  "Master wrapper for System.Linq.Enumerable.LongCount overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-predicate (cl:or (cl:null predicate) (monoutils:dotnet-p predicate)))
     (dotnet:static-generic <type-str> "LongCount" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-predicate))
     (dotnet:static-generic <type-str> "LongCount" (cl:list type) source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "LongCount"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-predicate (cl:list :predicate predicate)))))))

(cl:defun long-count-i-enumerable (type source)
  "Calls System.Linq.Enumerable.LongCount LongCount(IEnumerable) -> Int64. Summary: Returns an System.Int64 that represents the total number of elements in a sequence.
Returns: The number of elements in the source sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 that contains the elements to be counted.
"
  (dotnet:static-generic <type-str> "LongCount" (cl:list type) source))

(cl:defun long-count-i-enumerable-boolean] (type source predicate)
  "Calls System.Linq.Enumerable.LongCount LongCount(IEnumerable, Boolean]) -> Int64. Summary: Returns an System.Int64 that represents how many elements in a sequence satisfy a condition.
Returns: A number that represents how many elements in the sequence satisfy the condition in the predicate function.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 that contains the elements to be counted.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (dotnet:static-generic <type-str> "LongCount" (cl:list type) source predicate))

(cl:defun max (source cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.Max overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Max" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Max" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Max" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Max" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Max" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Max" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Max" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Max" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Max" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Max" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Max" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Max" source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Max"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun max-int32] (source)
  "Calls System.Linq.Enumerable.Max Max(Int32]) -> Int32. Summary: Returns the maximum value in a sequence of System.Int32 values.
Returns: The maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Int32]): A sequence of System.Int32 values to determine the maximum value of.
"
  (dotnet:static <type-str> "Max" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Int32]") source)))

(cl:defun max-int64] (source)
  "Calls System.Linq.Enumerable.Max Max(Int64]) -> Int64. Summary: Returns the maximum value in a sequence of System.Int64 values.
Returns: The maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Int64]): A sequence of System.Int64 values to determine the maximum value of.
"
  (dotnet:static <type-str> "Max" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Int64]") source)))

(cl:defun max-int32]] (source)
  "Calls System.Linq.Enumerable.Max Max(Int32]]) -> Int32]. Summary: Returns the maximum value in a sequence of nullable System.Int32 values.
Returns: A value of type Nullable<Int32> in C# or Nullable(Of Int32) in Visual Basic that corresponds to the maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int32]]): A sequence of nullable System.Int32 values to determine the maximum value of.
"
  (dotnet:static <type-str> "Max" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int32]]") source)))

(cl:defun max-int64]] (source)
  "Calls System.Linq.Enumerable.Max Max(Int64]]) -> Int64]. Summary: Returns the maximum value in a sequence of nullable System.Int64 values.
Returns: A value of type Nullable<Int64> in C# or Nullable(Of Int64) in Visual Basic that corresponds to the maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int64]]): A sequence of nullable System.Int64 values to determine the maximum value of.
"
  (dotnet:static <type-str> "Max" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int64]]") source)))

(cl:defun max-double] (source)
  "Calls System.Linq.Enumerable.Max Max(Double]) -> Double. Summary: Returns the maximum value in a sequence of System.Double values.
Returns: The maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Double]): A sequence of System.Double values to determine the maximum value of.
"
  (dotnet:static <type-str> "Max" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Double]") source)))

(cl:defun max-double]] (source)
  "Calls System.Linq.Enumerable.Max Max(Double]]) -> Double]. Summary: Returns the maximum value in a sequence of nullable System.Double values.
Returns: A value of type Nullable<Double> in C# or Nullable(Of Double) in Visual Basic that corresponds to the maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Double]]): A sequence of nullable System.Double values to determine the maximum value of.
"
  (dotnet:static <type-str> "Max" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Double]]") source)))

(cl:defun max-single] (source)
  "Calls System.Linq.Enumerable.Max Max(Single]) -> Single. Summary: Returns the maximum value in a sequence of System.Single values.
Returns: The maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Single]): A sequence of System.Single values to determine the maximum value of.
"
  (dotnet:static <type-str> "Max" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Single]") source)))

(cl:defun max-single]] (source)
  "Calls System.Linq.Enumerable.Max Max(Single]]) -> Single]. Summary: Returns the maximum value in a sequence of nullable System.Single values.
Returns: A value of type Nullable<Single> in C# or Nullable(Of Single) in Visual Basic that corresponds to the maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Single]]): A sequence of nullable System.Single values to determine the maximum value of.
"
  (dotnet:static <type-str> "Max" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Single]]") source)))

(cl:defun max-decimal] (source)
  "Calls System.Linq.Enumerable.Max Max(Decimal]) -> Decimal. Summary: Returns the maximum value in a sequence of System.Decimal values.
Returns: The maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Decimal]): A sequence of System.Decimal values to determine the maximum value of.
"
  (dotnet:static <type-str> "Max" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Decimal]") source)))

(cl:defun max-decimal]] (source)
  "Calls System.Linq.Enumerable.Max Max(Decimal]]) -> Decimal]. Summary: Returns the maximum value in a sequence of nullable System.Decimal values.
Returns: A value of type Nullable<Decimal> in C# or Nullable(Of Decimal) in Visual Basic that corresponds to the maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Decimal]]): A sequence of nullable System.Decimal values to determine the maximum value of.
"
  (dotnet:static <type-str> "Max" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Decimal]]") source)))

(cl:defun max-i-enumerable (type source)
  "Calls System.Linq.Enumerable.Max Max(IEnumerable) -> TSource. Summary: Returns the maximum value in a generic sequence.
Returns: The maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
"
  (dotnet:static-generic <type-str> "Max" (cl:list type) source))

(cl:defun max-i-enumerable-i-comparer (type source comparer)
  "Calls System.Linq.Enumerable.Max Max(IEnumerable, IComparer) -> TSource. Summary: Returns the maximum value in a generic sequence.
Returns: The maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
  - comparer (System.Collections.Generic.IComparer`1[TSource]): The System.Collections.Generic.IComparer`1 to compare values.
"
  (dotnet:static-generic <type-str> "Max" (cl:list type) source comparer))

(cl:defun max-i-enumerable-int32] (type source selector)
  "Calls System.Linq.Enumerable.Max Max(IEnumerable, Int32]) -> Int32. Summary: Invokes a transform function on each element of a sequence and returns the maximum System.Int32 value.
Returns: The maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
  - selector (System.Func`2[TSource, System.Int32]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Max" (cl:list type) source selector))

(cl:defun max-i-enumerable-int32]] (type source selector)
  "Calls System.Linq.Enumerable.Max Max(IEnumerable, Int32]]) -> Int32]. Summary: Invokes a transform function on each element of a sequence and returns the maximum nullable System.Int32 value.
Returns: The value of type Nullable<Int32> in C# or Nullable(Of Int32) in Visual Basic that corresponds to the maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Int32]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Max" (cl:list type) source selector))

(cl:defun max-i-enumerable-int64] (type source selector)
  "Calls System.Linq.Enumerable.Max Max(IEnumerable, Int64]) -> Int64. Summary: Invokes a transform function on each element of a sequence and returns the maximum System.Int64 value.
Returns: The maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
  - selector (System.Func`2[TSource, System.Int64]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Max" (cl:list type) source selector))

(cl:defun max-i-enumerable-int64]] (type source selector)
  "Calls System.Linq.Enumerable.Max Max(IEnumerable, Int64]]) -> Int64]. Summary: Invokes a transform function on each element of a sequence and returns the maximum nullable System.Int64 value.
Returns: The value that corresponds to the maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Int64]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Max" (cl:list type) source selector))

(cl:defun max-i-enumerable-single] (type source selector)
  "Calls System.Linq.Enumerable.Max Max(IEnumerable, Single]) -> Single. Summary: Invokes a transform function on each element of a sequence and returns the maximum System.Single value.
Returns: The maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
  - selector (System.Func`2[TSource, System.Single]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Max" (cl:list type) source selector))

(cl:defun max-i-enumerable-single]] (type source selector)
  "Calls System.Linq.Enumerable.Max Max(IEnumerable, Single]]) -> Single]. Summary: Invokes a transform function on each element of a sequence and returns the maximum nullable System.Single value.
Returns: The value that corresponds to the maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Single]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Max" (cl:list type) source selector))

(cl:defun max-i-enumerable-double] (type source selector)
  "Calls System.Linq.Enumerable.Max Max(IEnumerable, Double]) -> Double. Summary: Invokes a transform function on each element of a sequence and returns the maximum System.Double value.
Returns: The maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
  - selector (System.Func`2[TSource, System.Double]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Max" (cl:list type) source selector))

(cl:defun max-i-enumerable-double]] (type source selector)
  "Calls System.Linq.Enumerable.Max Max(IEnumerable, Double]]) -> Double]. Summary: Invokes a transform function on each element of a sequence and returns the maximum nullable System.Double value.
Returns: The value of type Nullable<Double> in C# or Nullable(Of Double) in Visual Basic that corresponds to the maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Double]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Max" (cl:list type) source selector))

(cl:defun max-i-enumerable-decimal] (type source selector)
  "Calls System.Linq.Enumerable.Max Max(IEnumerable, Decimal]) -> Decimal. Summary: Invokes a transform function on each element of a sequence and returns the maximum System.Decimal value.
Returns: The maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
  - selector (System.Func`2[TSource, System.Decimal]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Max" (cl:list type) source selector))

(cl:defun max-i-enumerable-decimal]] (type source selector)
  "Calls System.Linq.Enumerable.Max Max(IEnumerable, Decimal]]) -> Decimal]. Summary: Invokes a transform function on each element of a sequence and returns the maximum nullable System.Decimal value.
Returns: The value of type Nullable<Decimal> in C# or Nullable(Of Decimal) in Visual Basic that corresponds to the maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Decimal]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Max" (cl:list type) source selector))

;; The following C# System.Linq.Enumerable.MaxBy overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

(cl:defun min (source cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.Min overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Min" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Min" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Min" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Min" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Min" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Min" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Min" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Min" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Min" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Min" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static <type-str> "Min" source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static <type-str> "Min" source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Min"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun min-int32] (source)
  "Calls System.Linq.Enumerable.Min Min(Int32]) -> Int32. Summary: Returns the minimum value in a sequence of System.Int32 values.
Returns: The minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Int32]): A sequence of System.Int32 values to determine the minimum value of.
"
  (dotnet:static <type-str> "Min" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Int32]") source)))

(cl:defun min-int64] (source)
  "Calls System.Linq.Enumerable.Min Min(Int64]) -> Int64. Summary: Returns the minimum value in a sequence of System.Int64 values.
Returns: The minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Int64]): A sequence of System.Int64 values to determine the minimum value of.
"
  (dotnet:static <type-str> "Min" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Int64]") source)))

(cl:defun min-int32]] (source)
  "Calls System.Linq.Enumerable.Min Min(Int32]]) -> Int32]. Summary: Returns the minimum value in a sequence of nullable System.Int32 values.
Returns: The value that corresponds to the minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int32]]): A sequence of nullable System.Int32 values to determine the minimum value of.
"
  (dotnet:static <type-str> "Min" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int32]]") source)))

(cl:defun min-int64]] (source)
  "Calls System.Linq.Enumerable.Min Min(Int64]]) -> Int64]. Summary: Returns the minimum value in a sequence of nullable System.Int64 values.
Returns: The value that corresponds to the minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int64]]): A sequence of nullable System.Int64 values to determine the minimum value of.
"
  (dotnet:static <type-str> "Min" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int64]]") source)))

(cl:defun min-single] (source)
  "Calls System.Linq.Enumerable.Min Min(Single]) -> Single. Summary: Returns the minimum value in a sequence of System.Single values.
Returns: The minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Single]): A sequence of System.Single values to determine the minimum value of.
"
  (dotnet:static <type-str> "Min" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Single]") source)))

(cl:defun min-single]] (source)
  "Calls System.Linq.Enumerable.Min Min(Single]]) -> Single]. Summary: Returns the minimum value in a sequence of nullable System.Single values.
Returns: The value that corresponds to the minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Single]]): A sequence of nullable System.Single values to determine the minimum value of.
"
  (dotnet:static <type-str> "Min" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Single]]") source)))

(cl:defun min-double] (source)
  "Calls System.Linq.Enumerable.Min Min(Double]) -> Double. Summary: Returns the minimum value in a sequence of System.Double values.
Returns: The minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Double]): A sequence of System.Double values to determine the minimum value of.
"
  (dotnet:static <type-str> "Min" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Double]") source)))

(cl:defun min-double]] (source)
  "Calls System.Linq.Enumerable.Min Min(Double]]) -> Double]. Summary: Returns the minimum value in a sequence of nullable System.Double values.
Returns: The value that corresponds to the minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Double]]): A sequence of nullable System.Double values to determine the minimum value of.
"
  (dotnet:static <type-str> "Min" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Double]]") source)))

(cl:defun min-decimal] (source)
  "Calls System.Linq.Enumerable.Min Min(Decimal]) -> Decimal. Summary: Returns the minimum value in a sequence of System.Decimal values.
Returns: The minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Decimal]): A sequence of System.Decimal values to determine the minimum value of.
"
  (dotnet:static <type-str> "Min" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Decimal]") source)))

(cl:defun min-decimal]] (source)
  "Calls System.Linq.Enumerable.Min Min(Decimal]]) -> Decimal]. Summary: Returns the minimum value in a sequence of nullable System.Decimal values.
Returns: The value that corresponds to the minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Decimal]]): A sequence of nullable System.Decimal values to determine the minimum value of.
"
  (dotnet:static <type-str> "Min" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Decimal]]") source)))

(cl:defun min-i-enumerable (type source)
  "Calls System.Linq.Enumerable.Min Min(IEnumerable) -> TSource. Summary: Returns the minimum value in a generic sequence.
Returns: The minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
"
  (dotnet:static-generic <type-str> "Min" (cl:list type) source))

(cl:defun min-i-enumerable-i-comparer (type source comparer)
  "Calls System.Linq.Enumerable.Min Min(IEnumerable, IComparer) -> TSource. Summary: Returns the minimum value in a generic sequence.
Returns: The minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
  - comparer (System.Collections.Generic.IComparer`1[TSource]): The System.Collections.Generic.IComparer`1 to compare values.
"
  (dotnet:static-generic <type-str> "Min" (cl:list type) source comparer))

(cl:defun min-i-enumerable-int32] (type source selector)
  "Calls System.Linq.Enumerable.Min Min(IEnumerable, Int32]) -> Int32. Summary: Invokes a transform function on each element of a sequence and returns the minimum System.Int32 value.
Returns: The minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
  - selector (System.Func`2[TSource, System.Int32]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Min" (cl:list type) source selector))

(cl:defun min-i-enumerable-int32]] (type source selector)
  "Calls System.Linq.Enumerable.Min Min(IEnumerable, Int32]]) -> Int32]. Summary: Invokes a transform function on each element of a sequence and returns the minimum nullable System.Int32 value.
Returns: The value that corresponds to the minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Int32]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Min" (cl:list type) source selector))

(cl:defun min-i-enumerable-int64] (type source selector)
  "Calls System.Linq.Enumerable.Min Min(IEnumerable, Int64]) -> Int64. Summary: Invokes a transform function on each element of a sequence and returns the minimum System.Int64 value.
Returns: The minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
  - selector (System.Func`2[TSource, System.Int64]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Min" (cl:list type) source selector))

(cl:defun min-i-enumerable-int64]] (type source selector)
  "Calls System.Linq.Enumerable.Min Min(IEnumerable, Int64]]) -> Int64]. Summary: Invokes a transform function on each element of a sequence and returns the minimum nullable System.Int64 value.
Returns: The value that corresponds to the minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Int64]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Min" (cl:list type) source selector))

(cl:defun min-i-enumerable-single] (type source selector)
  "Calls System.Linq.Enumerable.Min Min(IEnumerable, Single]) -> Single. Summary: Invokes a transform function on each element of a sequence and returns the minimum System.Single value.
Returns: The minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
  - selector (System.Func`2[TSource, System.Single]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Min" (cl:list type) source selector))

(cl:defun min-i-enumerable-single]] (type source selector)
  "Calls System.Linq.Enumerable.Min Min(IEnumerable, Single]]) -> Single]. Summary: Invokes a transform function on each element of a sequence and returns the minimum nullable System.Single value.
Returns: The value that corresponds to the minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Single]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Min" (cl:list type) source selector))

(cl:defun min-i-enumerable-double] (type source selector)
  "Calls System.Linq.Enumerable.Min Min(IEnumerable, Double]) -> Double. Summary: Invokes a transform function on each element of a sequence and returns the minimum System.Double value.
Returns: The minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
  - selector (System.Func`2[TSource, System.Double]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Min" (cl:list type) source selector))

(cl:defun min-i-enumerable-double]] (type source selector)
  "Calls System.Linq.Enumerable.Min Min(IEnumerable, Double]]) -> Double]. Summary: Invokes a transform function on each element of a sequence and returns the minimum nullable System.Double value.
Returns: The value that corresponds to the minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Double]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Min" (cl:list type) source selector))

(cl:defun min-i-enumerable-decimal] (type source selector)
  "Calls System.Linq.Enumerable.Min Min(IEnumerable, Decimal]) -> Decimal. Summary: Invokes a transform function on each element of a sequence and returns the minimum System.Decimal value.
Returns: The minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
  - selector (System.Func`2[TSource, System.Decimal]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Min" (cl:list type) source selector))

(cl:defun min-i-enumerable-decimal]] (type source selector)
  "Calls System.Linq.Enumerable.Min Min(IEnumerable, Decimal]]) -> Decimal]. Summary: Invokes a transform function on each element of a sequence and returns the minimum nullable System.Decimal value.
Returns: The value that corresponds to the minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Decimal]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Min" (cl:list type) source selector))

;; The following C# System.Linq.Enumerable.MinBy overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

(cl:defun of-type (type source)
  "Summary: Filters the elements of an System.Collections.IEnumerable based on a specified type.
Returns: An System.Collections.Generic.IEnumerable`1 that contains elements from the input sequence of type .
Parameters:
  - source (System.Collections.IEnumerable): The System.Collections.IEnumerable whose elements to filter.
"
  (dotnet:static-generic <type-str> "OfType" (cl:list type) source))

(cl:defun order (type source cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.Order overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static-generic <type-str> "Order" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "Order" (cl:list type) source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Order"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun order-i-enumerable (type source)
  "Calls System.Linq.Enumerable.Order Order(IEnumerable) -> IOrderedEnumerable. Summary: Sorts the elements of a sequence in ascending order.
Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[T]): A sequence of values to order.
"
  (dotnet:static-generic <type-str> "Order" (cl:list type) source))

(cl:defun order-i-enumerable-i-comparer (type source comparer)
  "Calls System.Linq.Enumerable.Order Order(IEnumerable, IComparer) -> IOrderedEnumerable. Summary: Sorts the elements of a sequence in ascending order.
Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[T]): A sequence of values to order.
  - comparer (System.Collections.Generic.IComparer`1[T]): An System.Collections.Generic.IComparer`1 to compare keys.
"
  (dotnet:static-generic <type-str> "Order" (cl:list type) source comparer))

;; The following C# System.Linq.Enumerable.OrderBy overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

;; The following C# System.Linq.Enumerable.OrderByDescending overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

(cl:defun order-descending (type source cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.OrderDescending overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static-generic <type-str> "OrderDescending" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "OrderDescending" (cl:list type) source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "OrderDescending"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun order-descending-i-enumerable (type source)
  "Calls System.Linq.Enumerable.OrderDescending OrderDescending(IEnumerable) -> IOrderedEnumerable. Summary: Sorts the elements of a sequence in descending order.
Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[T]): A sequence of values to order.
"
  (dotnet:static-generic <type-str> "OrderDescending" (cl:list type) source))

(cl:defun order-descending-i-enumerable-i-comparer (type source comparer)
  "Calls System.Linq.Enumerable.OrderDescending OrderDescending(IEnumerable, IComparer) -> IOrderedEnumerable. Summary: Sorts the elements of a sequence in descending order.
Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[T]): A sequence of values to order.
  - comparer (System.Collections.Generic.IComparer`1[T]): An System.Collections.Generic.IComparer`1 to compare keys.
"
  (dotnet:static-generic <type-str> "OrderDescending" (cl:list type) source comparer))

(cl:defun prepend (type source element)
  "Summary: Adds a value to the beginning of the sequence.
Returns: A new sequence that begins with element.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values.
  - element (TSource): The value to prepend to source.
"
  (dotnet:static-generic <type-str> "Prepend" (cl:list type) source element))

(cl:defun range (start count)
  "Summary: Generates a sequence of integral numbers within a specified range.
Returns: An IEnumerable<Int32> in C# or IEnumerable(Of Int32) in Visual Basic that contains a range of sequential integral numbers.
Parameters:
  - start (System.Int32): The value of the first integer in the sequence.
  - count (System.Int32): The number of sequential integers to generate.
"
  (dotnet:static <type-str> "Range" (cl:the (dotnet "System.Int32") start) (cl:the (dotnet "System.Int32") count)))

(cl:defun repeat (type element count)
  "Summary: Generates a sequence that contains one repeated value.
Returns: An System.Collections.Generic.IEnumerable`1 that contains a repeated value.
Parameters:
  - element (TResult): The value to be repeated.
  - count (System.Int32): The number of times to repeat the value in the generated sequence.
"
  (dotnet:static-generic <type-str> "Repeat" (cl:list type) element count))

(cl:defun reverse (type source)
  "Master wrapper for System.Linq.Enumerable.Reverse overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)))
     (dotnet:static-generic <type-str> "Reverse" (cl:list type) source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)))
     (dotnet:static-generic <type-str> "Reverse" (cl:list type) source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Reverse"
                    :supplied-args (cl:append (cl:list :source source))))))

(cl:defun reverse-i-enumerable (type source)
  "Calls System.Linq.Enumerable.Reverse Reverse(IEnumerable) -> IEnumerable. Summary: Inverts the order of the elements in a sequence.
Returns: A sequence whose elements correspond to those of the input sequence in reverse order.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to reverse.
"
  (dotnet:static-generic <type-str> "Reverse" (cl:list type) source))

(cl:defun reverse-t-source[] (type source)
  "Calls System.Linq.Enumerable.Reverse Reverse(TSource[]) -> IEnumerable. Parameters:
  - source (TSource[]): 
"
  (dotnet:static-generic <type-str> "Reverse" (cl:list type) source))

;; The following C# System.Linq.Enumerable.RightJoin overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

;; The following C# System.Linq.Enumerable.Select overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

;; The following C# System.Linq.Enumerable.SelectMany overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

(cl:defun sequence (type start end-inclusive step)
  "Summary: Generates a sequence that begins with start and yields additional values each incremented by step until endInclusive is reached.
Returns: An System.Collections.Generic.IEnumerable`1 that contains the sequence.
Parameters:
  - start (T): The starting value. This value will always be included in the resulting sequence.
  - end-inclusive (T): The ending bound beyond which values will not be included in the sequence.
  - step (T): The amount by which the next value in the sequence should be incremented from the previous value.
"
  (dotnet:static-generic <type-str> "Sequence" (cl:list type) start end-inclusive step))

(cl:defun sequence-equal (type first second cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.SequenceEqual overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null first) (monoutils:dotnet-p first)) (cl:or (cl:null second) (monoutils:dotnet-p second)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static-generic <type-str> "SequenceEqual" (cl:list type) first second comparer))
    ((cl:and (cl:or (cl:null first) (monoutils:dotnet-p first)) (cl:or (cl:null second) (monoutils:dotnet-p second)) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "SequenceEqual" (cl:list type) first second))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "SequenceEqual"
                    :supplied-args (cl:append (cl:list :first first) (cl:list :second second) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun sequence-equal-i-enumerable-i-enumerable (type first second)
  "Calls System.Linq.Enumerable.SequenceEqual SequenceEqual(IEnumerable, IEnumerable) -> Boolean. Summary: Determines whether two sequences are equal by comparing the elements by using the default equality comparer for their type.
Returns: if the two source sequences are of equal length and their corresponding elements are equal according to the default equality comparer for their type; otherwise, .
Parameters:
  - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to compare to second.
  - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to compare to the first sequence.
"
  (dotnet:static-generic <type-str> "SequenceEqual" (cl:list type) first second))

(cl:defun sequence-equal-i-enumerable-i-enumerable-i-equality-comparer (type first second comparer)
  "Calls System.Linq.Enumerable.SequenceEqual SequenceEqual(IEnumerable, IEnumerable, IEqualityComparer) -> Boolean. Summary: Determines whether two sequences are equal by comparing their elements by using a specified System.Collections.Generic.IEqualityComparer`1.
Returns: if the two source sequences are of equal length and their corresponding elements compare equal according to comparer; otherwise, .
Parameters:
  - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to compare to second.
  - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to compare to the first sequence.
  - comparer (System.Collections.Generic.IEqualityComparer`1[TSource]): An System.Collections.Generic.IEqualityComparer`1 to use to compare elements.
"
  (dotnet:static-generic <type-str> "SequenceEqual" (cl:list type) first second comparer))

(cl:defun shuffle (type source)
  "Summary: Shuffles the order of the elements of a sequence.
Returns: A sequence whose elements correspond to those of the input sequence in randomized order.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to shuffle.
"
  (dotnet:static-generic <type-str> "Shuffle" (cl:list type) source))

(cl:defun single (type source cl:&optional (predicate cl:nil supplied-predicate))
  "Master wrapper for System.Linq.Enumerable.Single overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-predicate (cl:or (cl:null predicate) (monoutils:dotnet-p predicate)))
     (dotnet:static-generic <type-str> "Single" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-predicate))
     (dotnet:static-generic <type-str> "Single" (cl:list type) source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Single"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-predicate (cl:list :predicate predicate)))))))

(cl:defun single-i-enumerable (type source)
  "Calls System.Linq.Enumerable.Single Single(IEnumerable) -> TSource. Summary: Returns the only element of a sequence, and throws an exception if there is not exactly one element in the sequence.
Returns: The single element of the input sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return the single element of.
"
  (dotnet:static-generic <type-str> "Single" (cl:list type) source))

(cl:defun single-i-enumerable-boolean] (type source predicate)
  "Calls System.Linq.Enumerable.Single Single(IEnumerable, Boolean]) -> TSource. Summary: Returns the only element of a sequence that satisfies a specified condition, and throws an exception if more than one such element exists.
Returns: The single element of the input sequence that satisfies a condition.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return a single element from.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test an element for a condition.
"
  (dotnet:static-generic <type-str> "Single" (cl:list type) source predicate))

(cl:defun single-or-default (type source cl:&optional (default-value cl:nil supplied-default-value) (default-value cl:nil supplied-default-value))
  "Master wrapper for System.Linq.Enumerable.SingleOrDefault overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-default-value (cl:or (cl:null default-value) (monoutils:dotnet-p default-value)) supplied-default-value (cl:or (cl:null default-value) (monoutils:dotnet-p default-value)))
     (dotnet:static-generic <type-str> "SingleOrDefault" (cl:list type) source default-value default-value))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-default-value (cl:or (cl:null default-value) (monoutils:dotnet-p default-value)) (cl:not supplied-default-value))
     (dotnet:static-generic <type-str> "SingleOrDefault" (cl:list type) source default-value))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-default-value (cl:or (cl:null default-value) (monoutils:dotnet-p default-value)) (cl:not supplied-default-value))
     (dotnet:static-generic <type-str> "SingleOrDefault" (cl:list type) source default-value))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-default-value) (cl:not supplied-default-value))
     (dotnet:static-generic <type-str> "SingleOrDefault" (cl:list type) source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "SingleOrDefault"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-default-value (cl:list :default-value default-value)) (cl:when supplied-default-value (cl:list :default-value default-value)))))))

(cl:defun single-or-default-i-enumerable (type source)
  "Calls System.Linq.Enumerable.SingleOrDefault SingleOrDefault(IEnumerable) -> TSource. Summary: Returns the only element of a sequence, or a default value if the sequence is empty; this method throws an exception if there is more than one element in the sequence.
Returns: The single element of the input sequence, or () if the sequence contains no elements.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return the single element of.
"
  (dotnet:static-generic <type-str> "SingleOrDefault" (cl:list type) source))

(cl:defun single-or-default-i-enumerable-t-source (type source default-value)
  "Calls System.Linq.Enumerable.SingleOrDefault SingleOrDefault(IEnumerable, TSource) -> TSource. Summary: Returns the only element of a sequence, or a specified default value if the sequence is empty; this method throws an exception if there is more than one element in the sequence.
Returns: The single element of the input sequence, or defaultValue if the sequence contains no elements.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return the single element of.
  - default-value (TSource): The default value to return if the sequence is empty.
"
  (dotnet:static-generic <type-str> "SingleOrDefault" (cl:list type) source default-value))

(cl:defun single-or-default-i-enumerable-boolean] (type source predicate)
  "Calls System.Linq.Enumerable.SingleOrDefault SingleOrDefault(IEnumerable, Boolean]) -> TSource. Summary: Returns the only element of a sequence that satisfies a specified condition or a default value if no such element exists; this method throws an exception if more than one element satisfies the condition.
Returns: The single element of the input sequence that satisfies the condition, or () if no such element is found.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return a single element from.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test an element for a condition.
"
  (dotnet:static-generic <type-str> "SingleOrDefault" (cl:list type) source predicate))

(cl:defun single-or-default-i-enumerable-boolean]-t-source (type source predicate default-value)
  "Calls System.Linq.Enumerable.SingleOrDefault SingleOrDefault(IEnumerable, Boolean], TSource) -> TSource. Summary: Returns the only element of a sequence that satisfies a specified condition, or a specified default value if no such element exists; this method throws an exception if more than one element satisfies the condition.
Returns: The single element of the input sequence that satisfies the condition, or defaultValue if no such element is found.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return a single element from.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test an element for a condition.
  - default-value (TSource): The default value to return if the sequence is empty.
"
  (dotnet:static-generic <type-str> "SingleOrDefault" (cl:list type) source predicate default-value))

(cl:defun skip (type source count)
  "Summary: Bypasses a specified number of elements in a sequence and then returns the remaining elements.
Returns: An System.Collections.Generic.IEnumerable`1 that contains the elements that occur after the specified index in the input sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return elements from.
  - count (System.Int32): The number of elements to skip before returning the remaining elements.
"
  (dotnet:static-generic <type-str> "Skip" (cl:list type) source count))

(cl:defun skip-last (type source count)
  "Summary: Returns a new enumerable collection that contains the elements from source with the last count elements of the source collection omitted.
Returns: A new enumerable collection that contains the elements from source minus count elements from the end of the collection.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An enumerable collection instance.
  - count (System.Int32): The number of elements to omit from the end of the collection.
"
  (dotnet:static-generic <type-str> "SkipLast" (cl:list type) source count))

(cl:defun skip-while (type source predicate)
  "Master wrapper for System.Linq.Enumerable.SkipWhile overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:or (cl:null predicate) (monoutils:dotnet-p predicate)))
     (dotnet:static-generic <type-str> "SkipWhile" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:or (cl:null predicate) (monoutils:dotnet-p predicate)))
     (dotnet:static-generic <type-str> "SkipWhile" (cl:list type) source predicate))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "SkipWhile"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :predicate predicate))))))

(cl:defun skip-while-i-enumerable-boolean] (type source predicate)
  "Calls System.Linq.Enumerable.SkipWhile SkipWhile(IEnumerable, Boolean]) -> IEnumerable. Summary: Bypasses elements in a sequence as long as a specified condition is true and then returns the remaining elements.
Returns: An System.Collections.Generic.IEnumerable`1 that contains the elements from the input sequence starting at the first element in the linear series that does not pass the test specified by predicate.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return elements from.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (dotnet:static-generic <type-str> "SkipWhile" (cl:list type) source predicate))

(cl:defun skip-while-i-enumerable-boolean] (type source predicate)
  "Calls System.Linq.Enumerable.SkipWhile SkipWhile(IEnumerable, Boolean]) -> IEnumerable. Summary: Bypasses elements in a sequence as long as a specified condition is true and then returns the remaining elements. The element's index is used in the logic of the predicate function.
Returns: An System.Collections.Generic.IEnumerable`1 that contains the elements from the input sequence starting at the first element in the linear series that does not pass the test specified by predicate.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return elements from.
  - predicate (System.Func`3[TSource, System.Int32, System.Boolean]): A function to test each source element for a condition; the second parameter of the function represents the index of the source element.
"
  (dotnet:static-generic <type-str> "SkipWhile" (cl:list type) source predicate))

(cl:defun sum (source cl:&optional (selector cl:nil supplied-selector))
  "Master wrapper for System.Linq.Enumerable.Sum overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Sum" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Sum" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Sum" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Sum" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Sum" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Sum" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Sum" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Sum" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Sum" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-selector (cl:or (cl:null selector) (monoutils:dotnet-p selector)))
     (dotnet:static <type-str> "Sum" source selector))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-selector))
     (dotnet:static <type-str> "Sum" source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Sum"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-selector (cl:list :selector selector)))))))

(cl:defun sum-int32] (source)
  "Calls System.Linq.Enumerable.Sum Sum(Int32]) -> Int32. Summary: Computes the sum of a sequence of System.Int32 values.
Returns: The sum of the values in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Int32]): A sequence of System.Int32 values to calculate the sum of.
"
  (dotnet:static <type-str> "Sum" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Int32]") source)))

(cl:defun sum-int64] (source)
  "Calls System.Linq.Enumerable.Sum Sum(Int64]) -> Int64. Summary: Computes the sum of a sequence of System.Int64 values.
Returns: The sum of the values in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Int64]): A sequence of System.Int64 values to calculate the sum of.
"
  (dotnet:static <type-str> "Sum" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Int64]") source)))

(cl:defun sum-single] (source)
  "Calls System.Linq.Enumerable.Sum Sum(Single]) -> Single. Summary: Computes the sum of a sequence of System.Single values.
Returns: The sum of the values in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Single]): A sequence of System.Single values to calculate the sum of.
"
  (dotnet:static <type-str> "Sum" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Single]") source)))

(cl:defun sum-double] (source)
  "Calls System.Linq.Enumerable.Sum Sum(Double]) -> Double. Summary: Computes the sum of a sequence of System.Double values.
Returns: The sum of the values in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Double]): A sequence of System.Double values to calculate the sum of.
"
  (dotnet:static <type-str> "Sum" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Double]") source)))

(cl:defun sum-decimal] (source)
  "Calls System.Linq.Enumerable.Sum Sum(Decimal]) -> Decimal. Summary: Computes the sum of a sequence of System.Decimal values.
Returns: The sum of the values in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Decimal]): A sequence of System.Decimal values to calculate the sum of.
"
  (dotnet:static <type-str> "Sum" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Decimal]") source)))

(cl:defun sum-int32]] (source)
  "Calls System.Linq.Enumerable.Sum Sum(Int32]]) -> Int32]. Summary: Computes the sum of a sequence of nullable System.Int32 values.
Returns: The sum of the values in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int32]]): A sequence of nullable System.Int32 values to calculate the sum of.
"
  (dotnet:static <type-str> "Sum" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int32]]") source)))

(cl:defun sum-int64]] (source)
  "Calls System.Linq.Enumerable.Sum Sum(Int64]]) -> Int64]. Summary: Computes the sum of a sequence of nullable System.Int64 values.
Returns: The sum of the values in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int64]]): A sequence of nullable System.Int64 values to calculate the sum of.
"
  (dotnet:static <type-str> "Sum" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int64]]") source)))

(cl:defun sum-single]] (source)
  "Calls System.Linq.Enumerable.Sum Sum(Single]]) -> Single]. Summary: Computes the sum of a sequence of nullable System.Single values.
Returns: The sum of the values in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Single]]): A sequence of nullable System.Single values to calculate the sum of.
"
  (dotnet:static <type-str> "Sum" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Single]]") source)))

(cl:defun sum-double]] (source)
  "Calls System.Linq.Enumerable.Sum Sum(Double]]) -> Double]. Summary: Computes the sum of a sequence of nullable System.Double values.
Returns: The sum of the values in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Double]]): A sequence of nullable System.Double values to calculate the sum of.
"
  (dotnet:static <type-str> "Sum" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Double]]") source)))

(cl:defun sum-decimal]] (source)
  "Calls System.Linq.Enumerable.Sum Sum(Decimal]]) -> Decimal]. Summary: Computes the sum of a sequence of nullable System.Decimal values.
Returns: The sum of the values in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Decimal]]): A sequence of nullable System.Decimal values to calculate the sum of.
"
  (dotnet:static <type-str> "Sum" (cl:the (dotnet "System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Decimal]]") source)))

(cl:defun sum-i-enumerable-int32] (type source selector)
  "Calls System.Linq.Enumerable.Sum Sum(IEnumerable, Int32]) -> Int32. Summary: Computes the sum of the sequence of System.Int32 values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The sum of the projected values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
  - selector (System.Func`2[TSource, System.Int32]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))

(cl:defun sum-i-enumerable-int64] (type source selector)
  "Calls System.Linq.Enumerable.Sum Sum(IEnumerable, Int64]) -> Int64. Summary: Computes the sum of the sequence of System.Int64 values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The sum of the projected values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
  - selector (System.Func`2[TSource, System.Int64]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))

(cl:defun sum-i-enumerable-single] (type source selector)
  "Calls System.Linq.Enumerable.Sum Sum(IEnumerable, Single]) -> Single. Summary: Computes the sum of the sequence of System.Single values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The sum of the projected values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
  - selector (System.Func`2[TSource, System.Single]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))

(cl:defun sum-i-enumerable-double] (type source selector)
  "Calls System.Linq.Enumerable.Sum Sum(IEnumerable, Double]) -> Double. Summary: Computes the sum of the sequence of System.Double values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The sum of the projected values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
  - selector (System.Func`2[TSource, System.Double]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))

(cl:defun sum-i-enumerable-decimal] (type source selector)
  "Calls System.Linq.Enumerable.Sum Sum(IEnumerable, Decimal]) -> Decimal. Summary: Computes the sum of the sequence of System.Decimal values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The sum of the projected values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
  - selector (System.Func`2[TSource, System.Decimal]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))

(cl:defun sum-i-enumerable-int32]] (type source selector)
  "Calls System.Linq.Enumerable.Sum Sum(IEnumerable, Int32]]) -> Int32]. Summary: Computes the sum of the sequence of nullable System.Int32 values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The sum of the projected values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Int32]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))

(cl:defun sum-i-enumerable-int64]] (type source selector)
  "Calls System.Linq.Enumerable.Sum Sum(IEnumerable, Int64]]) -> Int64]. Summary: Computes the sum of the sequence of nullable System.Int64 values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The sum of the projected values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Int64]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))

(cl:defun sum-i-enumerable-single]] (type source selector)
  "Calls System.Linq.Enumerable.Sum Sum(IEnumerable, Single]]) -> Single]. Summary: Computes the sum of the sequence of nullable System.Single values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The sum of the projected values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Single]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))

(cl:defun sum-i-enumerable-double]] (type source selector)
  "Calls System.Linq.Enumerable.Sum Sum(IEnumerable, Double]]) -> Double]. Summary: Computes the sum of the sequence of nullable System.Double values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The sum of the projected values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Double]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))

(cl:defun sum-i-enumerable-decimal]] (type source selector)
  "Calls System.Linq.Enumerable.Sum Sum(IEnumerable, Decimal]]) -> Decimal]. Summary: Computes the sum of the sequence of nullable System.Decimal values that are obtained by invoking a transform function on each element of the input sequence.
Returns: The sum of the projected values.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
  - selector (System.Func`2[TSource, System.Nullable`1[System.Decimal]]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))

(cl:defun take (type source count)
  "Master wrapper for System.Linq.Enumerable.Take overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:numberp count))
     (dotnet:static-generic <type-str> "Take" (cl:list type) source count))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:or (cl:null count) (monoutils:dotnet-p count)))
     (dotnet:static-generic <type-str> "Take" (cl:list type) source count))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Take"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :count count))))))

(cl:defun take-i-enumerable-int32 (type source count)
  "Calls System.Linq.Enumerable.Take Take(IEnumerable, Int32) -> IEnumerable. Summary: Returns a specified number of contiguous elements from the start of a sequence.
Returns: An System.Collections.Generic.IEnumerable`1 that contains the specified number of elements from the start of the input sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to return elements from.
  - count (System.Int32): The number of elements to return.
"
  (dotnet:static-generic <type-str> "Take" (cl:list type) source count))

(cl:defun take-i-enumerable-range (type source range)
  "Calls System.Linq.Enumerable.Take Take(IEnumerable, Range) -> IEnumerable. Summary: Returns a specified range of contiguous elements from a sequence.
Returns: An System.Collections.Generic.IEnumerable`1 that contains the specified range of elements from the source sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to return elements from.
  - range (System.Range): The range of elements to return, which has start and end indexes either from the beginning or the end of the sequence.
"
  (dotnet:static-generic <type-str> "Take" (cl:list type) source range))

(cl:defun take-last (type source count)
  "Summary: Returns a new enumerable collection that contains the last count elements from source.
Returns: A new enumerable collection that contains the last count elements from source.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An enumerable collection instance.
  - count (System.Int32): The number of elements to take from the end of the collection.
"
  (dotnet:static-generic <type-str> "TakeLast" (cl:list type) source count))

(cl:defun take-while (type source predicate)
  "Master wrapper for System.Linq.Enumerable.TakeWhile overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:or (cl:null predicate) (monoutils:dotnet-p predicate)))
     (dotnet:static-generic <type-str> "TakeWhile" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:or (cl:null predicate) (monoutils:dotnet-p predicate)))
     (dotnet:static-generic <type-str> "TakeWhile" (cl:list type) source predicate))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "TakeWhile"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :predicate predicate))))))

(cl:defun take-while-i-enumerable-boolean] (type source predicate)
  "Calls System.Linq.Enumerable.TakeWhile TakeWhile(IEnumerable, Boolean]) -> IEnumerable. Summary: Returns elements from a sequence as long as a specified condition is true.
Returns: An System.Collections.Generic.IEnumerable`1 that contains the elements from the input sequence that occur before the element at which the test no longer passes.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence to return elements from.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (dotnet:static-generic <type-str> "TakeWhile" (cl:list type) source predicate))

(cl:defun take-while-i-enumerable-boolean] (type source predicate)
  "Calls System.Linq.Enumerable.TakeWhile TakeWhile(IEnumerable, Boolean]) -> IEnumerable. Summary: Returns elements from a sequence as long as a specified condition is true. The element's index is used in the logic of the predicate function.
Returns: An System.Collections.Generic.IEnumerable`1 that contains elements from the input sequence that occur before the element at which the test no longer passes.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to return elements from.
  - predicate (System.Func`3[TSource, System.Int32, System.Boolean]): A function to test each source element for a condition; the second parameter of the function represents the index of the source element.
"
  (dotnet:static-generic <type-str> "TakeWhile" (cl:list type) source predicate))

;; The following C# System.Linq.Enumerable.ThenBy overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

;; The following C# System.Linq.Enumerable.ThenByDescending overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

(cl:defun to-array (type source)
  "Summary: Creates an array from a System.Collections.Generic.IEnumerable`1.
Returns: An array that contains the elements from the input sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to create an array from.
"
  (dotnet:static-generic <type-str> "ToArray" (cl:list type) source))

;; The following C# System.Linq.Enumerable.ToDictionary overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

(cl:defun to-hash-set (type source cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.ToHashSet overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static-generic <type-str> "ToHashSet" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "ToHashSet" (cl:list type) source))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "ToHashSet"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun to-hash-set-i-enumerable (type source)
  "Calls System.Linq.Enumerable.ToHashSet ToHashSet(IEnumerable) -> HashSet. Summary: Creates a System.Collections.Generic.HashSet`1 from an System.Collections.Generic.IEnumerable`1.
Returns: A System.Collections.Generic.HashSet`1 that contains values of type selected from the input sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to create a System.Collections.Generic.HashSet`1 from.
"
  (dotnet:static-generic <type-str> "ToHashSet" (cl:list type) source))

(cl:defun to-hash-set-i-enumerable-i-equality-comparer (type source comparer)
  "Calls System.Linq.Enumerable.ToHashSet ToHashSet(IEnumerable, IEqualityComparer) -> HashSet. Summary: Creates a System.Collections.Generic.HashSet`1 from an System.Collections.Generic.IEnumerable`1 using the comparer to compare keys.
Returns: A System.Collections.Generic.HashSet`1 that contains values of type selected from the input sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to create a System.Collections.Generic.HashSet`1 from.
  - comparer (System.Collections.Generic.IEqualityComparer`1[TSource]): An System.Collections.Generic.IEqualityComparer`1 to compare keys.
"
  (dotnet:static-generic <type-str> "ToHashSet" (cl:list type) source comparer))

(cl:defun to-list (type source)
  "Summary: Creates a System.Collections.Generic.List`1 from an System.Collections.Generic.IEnumerable`1.
Returns: A System.Collections.Generic.List`1 that contains elements from the input sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): The System.Collections.Generic.IEnumerable`1 to create a System.Collections.Generic.List`1 from.
"
  (dotnet:static-generic <type-str> "ToList" (cl:list type) source))

;; The following C# System.Linq.Enumerable.ToLookup overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

;; The following C# System.Linq.Enumerable.TryGetNonEnumeratedCount overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   TryGetNonEnumeratedCount(IEnumerable, out Int32&) -> Boolean

(cl:defun union (type first second cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.Union overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null first) (monoutils:dotnet-p first)) (cl:or (cl:null second) (monoutils:dotnet-p second)) supplied-comparer (cl:or (cl:null comparer) (monoutils:dotnet-p comparer)))
     (dotnet:static-generic <type-str> "Union" (cl:list type) first second comparer))
    ((cl:and (cl:or (cl:null first) (monoutils:dotnet-p first)) (cl:or (cl:null second) (monoutils:dotnet-p second)) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "Union" (cl:list type) first second))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Union"
                    :supplied-args (cl:append (cl:list :first first) (cl:list :second second) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun union-i-enumerable-i-enumerable (type first second)
  "Calls System.Linq.Enumerable.Union Union(IEnumerable, IEnumerable) -> IEnumerable. Summary: Produces the set union of two sequences by using the default equality comparer.
Returns: An System.Collections.Generic.IEnumerable`1 that contains the elements from both input sequences, excluding duplicates.
Parameters:
  - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements form the first set for the union.
  - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements form the second set for the union.
"
  (dotnet:static-generic <type-str> "Union" (cl:list type) first second))

(cl:defun union-i-enumerable-i-enumerable-i-equality-comparer (type first second comparer)
  "Calls System.Linq.Enumerable.Union Union(IEnumerable, IEnumerable, IEqualityComparer) -> IEnumerable. Summary: Produces the set union of two sequences by using a specified System.Collections.Generic.IEqualityComparer`1.
Returns: An System.Collections.Generic.IEnumerable`1 that contains the elements from both input sequences, excluding duplicates.
Parameters:
  - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements form the first set for the union.
  - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements form the second set for the union.
  - comparer (System.Collections.Generic.IEqualityComparer`1[TSource]): The System.Collections.Generic.IEqualityComparer`1 to compare values.
"
  (dotnet:static-generic <type-str> "Union" (cl:list type) first second comparer))

;; The following C# System.Linq.Enumerable.UnionBy overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

(cl:defun where (type source predicate)
  "Master wrapper for System.Linq.Enumerable.Where overloads. Dispatches at runtime."
  (cl:cond
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:or (cl:null predicate) (monoutils:dotnet-p predicate)))
     (dotnet:static-generic <type-str> "Where" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (monoutils:dotnet-p source)) (cl:or (cl:null predicate) (monoutils:dotnet-p predicate)))
     (dotnet:static-generic <type-str> "Where" (cl:list type) source predicate))
    (cl:t (cl:error 'utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Where"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :predicate predicate))))))

(cl:defun where-i-enumerable-boolean] (type source predicate)
  "Calls System.Linq.Enumerable.Where Where(IEnumerable, Boolean]) -> IEnumerable. Summary: Filters a sequence of values based on a predicate.
Returns: An System.Collections.Generic.IEnumerable`1 that contains elements from the input sequence that satisfy the condition.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to filter.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (dotnet:static-generic <type-str> "Where" (cl:list type) source predicate))

(cl:defun where-i-enumerable-boolean] (type source predicate)
  "Calls System.Linq.Enumerable.Where Where(IEnumerable, Boolean]) -> IEnumerable. Summary: Filters a sequence of values based on a predicate. Each element's index is used in the logic of the predicate function.
Returns: An System.Collections.Generic.IEnumerable`1 that contains elements from the input sequence that satisfy the condition.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to filter.
  - predicate (System.Func`3[TSource, System.Int32, System.Boolean]): A function to test each source element for a condition; the second parameter of the function represents the index of the source element.
"
  (dotnet:static-generic <type-str> "Where" (cl:list type) source predicate))

;; The following C# System.Linq.Enumerable.Zip overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:

