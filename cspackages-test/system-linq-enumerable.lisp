;;; Generated automatically. Do not edit.
;;; Class: System.Linq.Enumerable
;;; Generator Version: 54
;;; Creation Date: 2026-07-19T20:42:53Z
;;; Options: --export-parents

(cl:in-package :system-linq-enumerable)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Linq.Enumerable"))
(cl:defconstant <type-str> "System.Linq.Enumerable")
(cl:defconstant <creation> "2026-07-19T20:42:53Z")
(cl:defconstant <version> 54)

(cl:defun aggregate-arity-1 (type source func)
  "Summary: Applies an accumulator function over a sequence.
Returns: The final accumulator value.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to aggregate over.
  - func (System.Func`3[TSource, TSource, TSource]): An accumulator function to be invoked on each element.
"
  (dotnet:static-generic <type-str> "Aggregate" (cl:list type) source func))

(cl:defun aggregate-arity-2 (type-1 type-2 source seed func)
  "Summary: Applies an accumulator function over a sequence. The specified seed value is used as the initial accumulator value.
Returns: The final accumulator value.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to aggregate over.
  - seed (TAccumulate): The initial accumulator value.
  - func (System.Func`3[TAccumulate, TSource, TAccumulate]): An accumulator function to be invoked on each element.
"
  (dotnet:static-generic <type-str> "Aggregate" (cl:list type-1 type-2) source seed func))

(cl:defun aggregate-arity-3 (type-1 type-2 type-3 source seed func result-selector)
  "Summary: Applies an accumulator function over a sequence. The specified seed value is used as the initial accumulator value, and the specified function is used to select the result value.
Returns: The transformed final accumulator value.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to aggregate over.
  - seed (TAccumulate): The initial accumulator value.
  - func (System.Func`3[TAccumulate, TSource, TAccumulate]): An accumulator function to be invoked on each element.
  - result-selector (System.Func`2[TAccumulate, TResult]): A function to transform the final accumulator value into the result value.
"
  (dotnet:static-generic <type-str> "Aggregate" (cl:list type-1 type-2 type-3) source seed func result-selector))

(cl:defun aggregate (types cl:&rest args)
  "Dispatches aggregate by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (1 (cl:apply (cl:function aggregate-arity-1) (cl:append type-list args)))
      (2 (cl:apply (cl:function aggregate-arity-2) (cl:append type-list args)))
      (3 (cl:apply (cl:function aggregate-arity-3) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-LINQ-ENUMERABLE"
                      :class-name <type-str>
                      :method-name "aggregate"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

(cl:defun aggregate-by (type-1 type-2 type-3 source key-selector seed func cl:&key (key-comparer cl:nil supplied-key-comparer))
  "Master wrapper for System.Linq.Enumerable.AggregateBy overloads. Dispatches at runtime.

AggregateBy(IEnumerable, Func, TAccumulate, Func, IEqualityComparer = null) -> KeyValuePair
  Summary: Applies an accumulator function over a sequence, grouping results by key.
  Returns: An enumerable containing the aggregates corresponding to each key deriving from source.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to aggregate over.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - seed (TAccumulate): The initial accumulator value.
    - func (System.Func`3[TAccumulate, TSource, TAccumulate]): An accumulator function to be invoked on each element.
    - key-comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to compare keys with.

AggregateBy(IEnumerable, Func, Func, Func, IEqualityComparer = null) -> KeyValuePair
  Summary: Applies an accumulator function over a sequence, grouping results by key.
  Returns: An enumerable containing the aggregates corresponding to each key deriving from source.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to aggregate over.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - seed-selector (System.Func`2[TKey, TAccumulate]): A factory for the initial accumulator value.
    - func (System.Func`3[TAccumulate, TSource, TAccumulate]): An accumulator function to be invoked on each element.
    - key-comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to compare keys with.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:or (cl:null seed) (dotnet:is-instance-of seed "TAccumulate")) (cl:or (cl:null func) (dotnet:is-instance-of func "System.Func`3[TAccumulate, TSource, TAccumulate]")) (cl:or (cl:not supplied-key-comparer) (cl:or (cl:null key-comparer) (dotnet:is-instance-of key-comparer "System.Collections.Generic.IEqualityComparer`1[TKey]"))))
     (dotnet:static-generic <type-str> "AggregateBy" (cl:list type-1 type-2 type-3) source key-selector seed func (cl:if supplied-key-comparer key-comparer cl:nil)))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:or (cl:null seed) (dotnet:is-instance-of seed "System.Func`2[TKey, TAccumulate]")) (cl:or (cl:null func) (dotnet:is-instance-of func "System.Func`3[TAccumulate, TSource, TAccumulate]")) (cl:or (cl:not supplied-key-comparer) (cl:or (cl:null key-comparer) (dotnet:is-instance-of key-comparer "System.Collections.Generic.IEqualityComparer`1[TKey]"))))
     (dotnet:static-generic <type-str> "AggregateBy" (cl:list type-1 type-2 type-3) source key-selector seed func (cl:if supplied-key-comparer key-comparer cl:nil)))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "AggregateBy"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :key-selector key-selector) (cl:list :seed seed) (cl:list :func func) (cl:when supplied-key-comparer (cl:list :key-comparer key-comparer)))))))

(cl:defun all (type source predicate)
  "Summary: Determines whether all elements of a sequence satisfy a condition.
Returns: if every element of the source sequence passes the test in the specified predicate, or if the sequence is empty; otherwise, .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 that contains the elements to apply the predicate to.
  - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (dotnet:static-generic <type-str> "All" (cl:list type) source predicate))

(cl:defun any (type source cl:&optional (predicate cl:nil supplied-predicate))
  "Master wrapper for System.Linq.Enumerable.Any overloads. Dispatches at runtime.

Any(IEnumerable) -> Boolean
  Summary: Determines whether a sequence contains any elements.
  Returns: if the source sequence contains any elements; otherwise, .
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The System.Collections.Generic.IEnumerable`1 to check for emptiness.

Any(IEnumerable, Boolean]) -> Boolean
  Summary: Determines whether any element of a sequence satisfies a condition.
  Returns: if the source sequence is not empty and at least one of its elements passes the test in the specified predicate; otherwise, .
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements to apply the predicate to.
    - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-predicate (cl:or (cl:null predicate) (dotnet:is-instance-of predicate "System.Func`2[TSource, System.Boolean]")))
     (dotnet:static-generic <type-str> "Any" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-predicate))
     (dotnet:static-generic <type-str> "Any" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Any"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-predicate (cl:list :predicate predicate)))))))

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

(cl:defun average (source)
  "Master wrapper for System.Linq.Enumerable.Average overloads. Dispatches at runtime.

Average(Int32]) -> Double
  Summary: Computes the average of a sequence of System.Int32 values.
  Returns: The average of the sequence of values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Int32]): A sequence of System.Int32 values to calculate the average of.

Average(Int64]) -> Double
  Summary: Computes the average of a sequence of System.Int64 values.
  Returns: The average of the sequence of values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Int64]): A sequence of System.Int64 values to calculate the average of.

Average(Single]) -> Single
  Summary: Computes the average of a sequence of System.Single values.
  Returns: The average of the sequence of values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Single]): A sequence of System.Single values to calculate the average of.

Average(Double]) -> Double
  Summary: Computes the average of a sequence of System.Double values.
  Returns: The average of the sequence of values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Double]): A sequence of System.Double values to calculate the average of.

Average(Decimal]) -> Decimal
  Summary: Computes the average of a sequence of System.Decimal values.
  Returns: The average of the sequence of values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Decimal]): A sequence of System.Decimal values to calculate the average of.

Average(Int32]]) -> Double]
  Summary: Computes the average of a sequence of nullable System.Int32 values.
  Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int32]]): A sequence of nullable System.Int32 values to calculate the average of.

Average(Int64]]) -> Double]
  Summary: Computes the average of a sequence of nullable System.Int64 values.
  Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int64]]): A sequence of nullable System.Int64 values to calculate the average of.

Average(Single]]) -> Single]
  Summary: Computes the average of a sequence of nullable System.Single values.
  Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Single]]): A sequence of nullable System.Single values to calculate the average of.

Average(Double]]) -> Double]
  Summary: Computes the average of a sequence of nullable System.Double values.
  Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Double]]): A sequence of nullable System.Double values to calculate the average of.

Average(Decimal]]) -> Decimal]
  Summary: Computes the average of a sequence of nullable System.Decimal values.
  Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Decimal]]): A sequence of nullable System.Decimal values to calculate the average of.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Int32, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Int64, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Single, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Double, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Decimal, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Int32, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Int64, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Single, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Double, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Average" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Decimal, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Average" source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Average"
                    :supplied-args (cl:append (cl:list :source source))))))

(cl:defun average-arity-1 (type source selector)
  "Master wrapper for System.Linq.Enumerable.Average overloads. Dispatches at runtime.

Average(IEnumerable, Int32]) -> Double
  Summary: Computes the average of a sequence of System.Int32 values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The average of the sequence of values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
    - selector (System.Func`2[TSource, System.Int32]): A transform function to apply to each element.

Average(IEnumerable, Int64]) -> Double
  Summary: Computes the average of a sequence of System.Int64 values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The average of the sequence of values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
    - selector (System.Func`2[TSource, System.Int64]): A transform function to apply to each element.

Average(IEnumerable, Single]) -> Single
  Summary: Computes the average of a sequence of System.Single values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The average of the sequence of values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
    - selector (System.Func`2[TSource, System.Single]): A transform function to apply to each element.

Average(IEnumerable, Double]) -> Double
  Summary: Computes the average of a sequence of System.Double values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The average of the sequence of values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
    - selector (System.Func`2[TSource, System.Double]): A transform function to apply to each element.

Average(IEnumerable, Decimal]) -> Decimal
  Summary: Computes the average of a sequence of System.Decimal values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The average of the sequence of values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate an average.
    - selector (System.Func`2[TSource, System.Decimal]): A transform function to apply to each element.

Average(IEnumerable, Int32]]) -> Double]
  Summary: Computes the average of a sequence of nullable System.Int32 values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Int32]]): A transform function to apply to each element.

Average(IEnumerable, Int64]]) -> Double]
  Summary: Computes the average of a sequence of nullable System.Int64 values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Int64]]): A transform function to apply to each element.

Average(IEnumerable, Single]]) -> Single]
  Summary: Computes the average of a sequence of nullable System.Single values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Single]]): A transform function to apply to each element.

Average(IEnumerable, Double]]) -> Double]
  Summary: Computes the average of a sequence of nullable System.Double values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Double]]): A transform function to apply to each element.

Average(IEnumerable, Decimal]]) -> Decimal]
  Summary: Computes the average of a sequence of nullable System.Decimal values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The average of the sequence of values, or if the source sequence is empty or contains only values that are .
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to calculate the average of.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Decimal]]): A transform function to apply to each element.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Int32]")))
     (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Int64]")))
     (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Single]")))
     (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Double]")))
     (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Decimal]")))
     (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Nullable`1[System.Int32]]")))
     (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Nullable`1[System.Int64]]")))
     (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Nullable`1[System.Single]]")))
     (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Nullable`1[System.Double]]")))
     (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Nullable`1[System.Decimal]]")))
     (dotnet:static-generic <type-str> "Average" (cl:list type) source selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Average"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :selector selector))))))

(cl:defun average<> (types cl:&rest args)
  "Dispatches average<> by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload.
   Passing cl:nil or an empty list calls the non-generic average overload(s)."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (0 (cl:apply (cl:function average) args))
      (1 (cl:apply (cl:function average-arity-1) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-LINQ-ENUMERABLE"
                      :class-name <type-str>
                      :method-name "average<>"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

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
  "Master wrapper for System.Linq.Enumerable.Contains overloads. Dispatches at runtime.

Contains(IEnumerable, TSource) -> Boolean
  Summary: Determines whether a sequence contains a specified element by using the default equality comparer.
  Returns: if the source sequence contains an element that has the specified value; otherwise, .
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence in which to locate a value.
    - value (TSource): The value to locate in the sequence.

Contains(IEnumerable, TSource, IEqualityComparer) -> Boolean
  Summary: Determines whether a sequence contains a specified element by using a specified System.Collections.Generic.IEqualityComparer`1.
  Returns: if the source sequence contains an element that has the specified value; otherwise, .
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence in which to locate a value.
    - value (TSource): The value to locate in the sequence.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TSource]): An equality comparer to compare values.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null value) (dotnet:is-instance-of value "TSource")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TSource]")))
     (dotnet:static-generic <type-str> "Contains" (cl:list type) source value comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null value) (dotnet:is-instance-of value "TSource")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "Contains" (cl:list type) source value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Contains"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :value value) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun count (type source cl:&optional (predicate cl:nil supplied-predicate))
  "Master wrapper for System.Linq.Enumerable.Count overloads. Dispatches at runtime.

Count(IEnumerable) -> Int32
  Summary: Returns the number of elements in a sequence.
  Returns: The number of elements in the input sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence that contains elements to be counted.

Count(IEnumerable, Boolean]) -> Int32
  Summary: Returns a number that represents how many elements in the specified sequence satisfy a condition.
  Returns: A number that represents how many elements in the sequence satisfy the condition in the predicate function.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence that contains elements to be tested and counted.
    - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-predicate (cl:or (cl:null predicate) (dotnet:is-instance-of predicate "System.Func`2[TSource, System.Boolean]")))
     (dotnet:static-generic <type-str> "Count" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-predicate))
     (dotnet:static-generic <type-str> "Count" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Count"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-predicate (cl:list :predicate predicate)))))))

(cl:defun count-by (type-1 type-2 source key-selector cl:&key (key-comparer cl:nil supplied-key-comparer))
  "Master wrapper for System.Linq.Enumerable.CountBy overloads. Dispatches at runtime.

CountBy(IEnumerable, Func, IEqualityComparer = null) -> Int32]]
  Summary: Returns the count of elements in the source sequence grouped by key.
  Returns: An enumerable containing the frequencies of each key occurrence in source.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence that contains elements to be counted.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - key-comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to compare keys with.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:or (cl:not supplied-key-comparer) (cl:or (cl:null key-comparer) (dotnet:is-instance-of key-comparer "System.Collections.Generic.IEqualityComparer`1[TKey]"))))
     (dotnet:static-generic <type-str> "CountBy" (cl:list type-1 type-2) source key-selector (cl:if supplied-key-comparer key-comparer cl:nil)))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "CountBy"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :key-selector key-selector) (cl:when supplied-key-comparer (cl:list :key-comparer key-comparer)))))))

(cl:defun default-if-empty (type source cl:&optional (default-value cl:nil supplied-default-value))
  "Master wrapper for System.Linq.Enumerable.DefaultIfEmpty overloads. Dispatches at runtime.

DefaultIfEmpty(IEnumerable) -> IEnumerable
  Summary: Returns the elements of the specified sequence or the type parameter's default value in a singleton collection if the sequence is empty.
  Returns: An System.Collections.Generic.IEnumerable`1 object that contains the default value for the type if source is empty; otherwise, source.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to return a default value for if it is empty.

DefaultIfEmpty(IEnumerable, TSource) -> IEnumerable
  Summary: Returns the elements of the specified sequence or the specified value in a singleton collection if the sequence is empty.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains defaultValue if source is empty; otherwise, source.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to return the specified value for if it is empty.
    - default-value (TSource): The value to return if the sequence is empty.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-default-value (cl:or (cl:null default-value) (dotnet:is-instance-of default-value "TSource")))
     (dotnet:static-generic <type-str> "DefaultIfEmpty" (cl:list type) source default-value))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-default-value))
     (dotnet:static-generic <type-str> "DefaultIfEmpty" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "DefaultIfEmpty"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-default-value (cl:list :default-value default-value)))))))

(cl:defun distinct (type source cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.Distinct overloads. Dispatches at runtime.

Distinct(IEnumerable) -> IEnumerable
  Summary: Returns distinct elements from a sequence by using the default equality comparer to compare values.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains distinct elements from the source sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to remove duplicate elements from.

Distinct(IEnumerable, IEqualityComparer) -> IEnumerable
  Summary: Returns distinct elements from a sequence by using a specified System.Collections.Generic.IEqualityComparer`1 to compare values.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains distinct elements from the source sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to remove duplicate elements from.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TSource]): An System.Collections.Generic.IEqualityComparer`1 to compare values.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TSource]")))
     (dotnet:static-generic <type-str> "Distinct" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "Distinct" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Distinct"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun distinct-by (type-1 type-2 source key-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.DistinctBy overloads. Dispatches at runtime.

DistinctBy(IEnumerable, Func) -> IEnumerable
  Summary: Returns distinct elements from a sequence according to a specified key selector function.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains distinct elements from the source sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to remove duplicate elements from.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.

DistinctBy(IEnumerable, Func, IEqualityComparer) -> IEnumerable
  Summary: Returns distinct elements from a sequence according to a specified key selector function and using a specified comparer to compare keys.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains distinct elements from the source sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to remove duplicate elements from.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "DistinctBy" (cl:list type-1 type-2) source key-selector comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "DistinctBy" (cl:list type-1 type-2) source key-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "DistinctBy"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :key-selector key-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun element-at (type source index)
  "Master wrapper for System.Linq.Enumerable.ElementAt overloads. Dispatches at runtime.

ElementAt(IEnumerable, Int32) -> TSource
  Summary: Returns the element at a specified index in a sequence.
  Returns: The element at the specified position in the source sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
    - index (System.Int32): The zero-based index of the element to retrieve.

ElementAt(IEnumerable, Index) -> TSource
  Summary: Returns the element at a specified index in a sequence.
  Returns: The element at the specified position in the source sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
    - index (System.Index): The index of the element to retrieve, which is either from the beginning or the end of the sequence.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:numberp index))
     (dotnet:static-generic <type-str> "ElementAt" (cl:list type) source index))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null index) (dotnet:is-instance-of index "System.Index")))
     (dotnet:static-generic <type-str> "ElementAt" (cl:list type) source index))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "ElementAt"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :index index))))))

(cl:defun element-at-or-default (type source index)
  "Master wrapper for System.Linq.Enumerable.ElementAtOrDefault overloads. Dispatches at runtime.

ElementAtOrDefault(IEnumerable, Int32) -> TSource
  Summary: Returns the element at a specified index in a sequence or a default value if the index is out of range.
  Returns: () if the index is outside the bounds of the source sequence; otherwise, the element at the specified position in the source sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
    - index (System.Int32): The zero-based index of the element to retrieve.

ElementAtOrDefault(IEnumerable, Index) -> TSource
  Summary: Returns the element at a specified index in a sequence or a default value if the index is out of range.
  Returns: if index is outside the bounds of the source sequence; otherwise, the element at the specified position in the source sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
    - index (System.Index): The index of the element to retrieve, which is either from the beginning or the end of the sequence.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:numberp index))
     (dotnet:static-generic <type-str> "ElementAtOrDefault" (cl:list type) source index))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null index) (dotnet:is-instance-of index "System.Index")))
     (dotnet:static-generic <type-str> "ElementAtOrDefault" (cl:list type) source index))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "ElementAtOrDefault"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :index index))))))

(cl:defun empty (type)
  "Summary: Returns an empty System.Collections.Generic.IEnumerable`1 that has the specified type argument.
Returns: An empty System.Collections.Generic.IEnumerable`1 whose type argument is .
"
  (dotnet:static-generic <type-str> "Empty" (cl:list type)))

(cl:defun except (type first second cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.Except overloads. Dispatches at runtime.

Except(IEnumerable, IEnumerable) -> IEnumerable
  Summary: Produces the set difference of two sequences by using the default equality comparer to compare values.
  Returns: A sequence that contains the set difference of the elements of two sequences.
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements that are not also in second will be returned.
    - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements that also occur in the first sequence will cause those elements to be removed from the returned sequence.

Except(IEnumerable, IEnumerable, IEqualityComparer) -> IEnumerable
  Summary: Produces the set difference of two sequences by using the specified System.Collections.Generic.IEqualityComparer`1 to compare values.
  Returns: A sequence that contains the set difference of the elements of two sequences.
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements that are not also in second will be returned.
    - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements that also occur in the first sequence will cause those elements to be removed from the returned sequence.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TSource]): An System.Collections.Generic.IEqualityComparer`1 to compare values.
"
  (cl:cond
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TSource]")))
     (dotnet:static-generic <type-str> "Except" (cl:list type) first second comparer))
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "Except" (cl:list type) first second))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Except"
                    :supplied-args (cl:append (cl:list :first first) (cl:list :second second) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun except-by (type-1 type-2 first second key-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.ExceptBy overloads. Dispatches at runtime.

ExceptBy(IEnumerable, IEnumerable, Func) -> IEnumerable
  Summary: Produces the set difference of two sequences according to a specified key selector function.
  Returns: A sequence that contains the set difference of the elements of two sequences.
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose keys that are not also in second will be returned.
    - second (System.Collections.Generic.IEnumerable`1[TKey]): An System.Collections.Generic.IEnumerable`1 whose keys that also occur in the first sequence will cause those elements to be removed from the returned sequence.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.

ExceptBy(IEnumerable, IEnumerable, Func, IEqualityComparer) -> IEnumerable
  Summary: Produces the set difference of two sequences according to a specified key selector function.
  Returns: A sequence that contains the set difference of the elements of two sequences.
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose keys that are not also in second will be returned.
    - second (System.Collections.Generic.IEnumerable`1[TKey]): An System.Collections.Generic.IEnumerable`1 whose keys that also occur in the first sequence will cause those elements to be removed from the returned sequence.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): The System.Collections.Generic.IEqualityComparer`1 to compare values.
"
  (cl:cond
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TKey]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "ExceptBy" (cl:list type-1 type-2) first second key-selector comparer))
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TKey]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "ExceptBy" (cl:list type-1 type-2) first second key-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "ExceptBy"
                    :supplied-args (cl:append (cl:list :first first) (cl:list :second second) (cl:list :key-selector key-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun first (type source cl:&optional (predicate cl:nil supplied-predicate))
  "Master wrapper for System.Linq.Enumerable.First overloads. Dispatches at runtime.

First(IEnumerable) -> TSource
  Summary: Returns the first element of a sequence.
  Returns: The first element in the specified sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The System.Collections.Generic.IEnumerable`1 to return the first element of.

First(IEnumerable, Boolean]) -> TSource
  Summary: Returns the first element in a sequence that satisfies a specified condition.
  Returns: The first element in the sequence that passes the test in the specified predicate function.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
    - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-predicate (cl:or (cl:null predicate) (dotnet:is-instance-of predicate "System.Func`2[TSource, System.Boolean]")))
     (dotnet:static-generic <type-str> "First" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-predicate))
     (dotnet:static-generic <type-str> "First" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "First"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-predicate (cl:list :predicate predicate)))))))

(cl:defun first-or-default (type source cl:&optional (default-value cl:nil supplied-default-value) (default-value2 cl:nil supplied-default-value2))
  "Master wrapper for System.Linq.Enumerable.FirstOrDefault overloads. Dispatches at runtime.

FirstOrDefault(IEnumerable) -> TSource
  Summary: Returns the first element of a sequence, or a default value if the sequence contains no elements.
  Returns: () if source is empty; otherwise, the first element in source.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The System.Collections.Generic.IEnumerable`1 to return the first element of.

FirstOrDefault(IEnumerable, TSource) -> TSource
  Summary: Returns the first element of a sequence, or a specified default value if the sequence contains no elements.
  Returns: defaultValue if source is empty; otherwise, the first element in source.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The System.Collections.Generic.IEnumerable`1 to return the first element of.
    - default-value (TSource): The default value to return if the sequence is empty.

FirstOrDefault(IEnumerable, Boolean]) -> TSource
  Summary: Returns the first element of the sequence that satisfies a condition or a default value if no such element is found.
  Returns: () if source is empty or if no element passes the test specified by predicate; otherwise, the first element in source that passes the test specified by predicate.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
    - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.

FirstOrDefault(IEnumerable, Boolean], TSource) -> TSource
  Summary: Returns the first element of the sequence that satisfies a condition, or a specified default value if no such element is found.
  Returns: defaultValue if source is empty or if no element passes the test specified by predicate; otherwise, the first element in source that passes the test specified by predicate.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
    - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
    - default-value (TSource): The default value to return if the sequence is empty.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-default-value (cl:or (cl:null default-value) (dotnet:is-instance-of default-value "System.Func`2[TSource, System.Boolean]")) supplied-default-value2 (cl:or (cl:null default-value2) (dotnet:is-instance-of default-value2 "TSource")))
     (dotnet:static-generic <type-str> "FirstOrDefault" (cl:list type) source default-value default-value2))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-default-value (cl:or (cl:null default-value) (dotnet:is-instance-of default-value "TSource")) (cl:not supplied-default-value2))
     (dotnet:static-generic <type-str> "FirstOrDefault" (cl:list type) source default-value))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-default-value (cl:or (cl:null default-value) (dotnet:is-instance-of default-value "System.Func`2[TSource, System.Boolean]")) (cl:not supplied-default-value2))
     (dotnet:static-generic <type-str> "FirstOrDefault" (cl:list type) source default-value))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-default-value) (cl:not supplied-default-value2))
     (dotnet:static-generic <type-str> "FirstOrDefault" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "FirstOrDefault"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-default-value (cl:list :default-value default-value)) (cl:when supplied-default-value2 (cl:list :default-value2 default-value2)))))))

(cl:defun group-by-arity-2 (type-1 type-2 source key-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.GroupBy overloads. Dispatches at runtime.

GroupBy(IEnumerable, Func) -> IGrouping
  Summary: Groups the elements of a sequence according to a specified key selector function.
  Returns: An IEnumerable<IGrouping<TKey, TSource>> in C# or IEnumerable(Of IGrouping(Of TKey, TSource)) in Visual Basic where each System.Linq.IGrouping`2 object contains a sequence of objects and a key.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements to group.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.

GroupBy(IEnumerable, Func, IEqualityComparer) -> IGrouping
  Summary: Groups the elements of a sequence according to a specified key selector function and compares the keys by using a specified comparer.
  Returns: An IEnumerable<IGrouping<TKey, TSource>> in C# or IEnumerable(Of IGrouping(Of TKey, TSource)) in Visual Basic where each System.Linq.IGrouping`2 object contains a collection of objects and a key.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements to group.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "GroupBy" (cl:list type-1 type-2) source key-selector comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "GroupBy" (cl:list type-1 type-2) source key-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "GroupBy"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :key-selector key-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun group-by-arity-3 (type-1 type-2 type-3 source key-selector element-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.GroupBy overloads. Dispatches at runtime.

GroupBy(IEnumerable, Func, Func) -> IGrouping
  Summary: Groups the elements of a sequence according to a specified key selector function and projects the elements for each group by using a specified function.
  Returns: An IEnumerable<IGrouping<TKey, TElement>> in C# or IEnumerable(Of IGrouping(Of TKey, TElement)) in Visual Basic where each System.Linq.IGrouping`2 object contains a collection of objects of type and a key.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements to group.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - element-selector (System.Func`2[TSource, TElement]): A function to map each source element to an element in the System.Linq.IGrouping`2.

GroupBy(IEnumerable, Func, IEnumerable) -> IEnumerable
  Summary: Groups the elements of a sequence according to a specified key selector function and creates a result value from each group and its key.
  Returns: A collection of elements of type where each element represents a projection over a group and its key.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements to group.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - result-selector (System.Func`3[TKey, System.Collections.Generic.IEnumerable`1[TSource], TResult]): A function to create a result value from each group.

GroupBy(IEnumerable, Func, Func, IEqualityComparer) -> IGrouping
  Summary: Groups the elements of a sequence according to a key selector function. The keys are compared by using a comparer and each group's elements are projected by using a specified function.
  Returns: An IEnumerable<IGrouping<TKey, TElement>> in C# or IEnumerable(Of IGrouping(Of TKey, TElement)) in Visual Basic where each System.Linq.IGrouping`2 object contains a collection of objects of type and a key.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements to group.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - element-selector (System.Func`2[TSource, TElement]): A function to map each source element to an element in an System.Linq.IGrouping`2.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to compare keys.

GroupBy(IEnumerable, Func, IEnumerable, IEqualityComparer) -> IEnumerable
  Summary: Groups the elements of a sequence according to a specified key selector function and creates a result value from each group and its key. The keys are compared by using a specified comparer.
  Returns: A collection of elements of type where each element represents a projection over a group and its key.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements to group.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - result-selector (System.Func`3[TKey, System.Collections.Generic.IEnumerable`1[TSource], TResult]): A function to create a result value from each group.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to compare keys with.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:or (cl:null element-selector) (dotnet:is-instance-of element-selector "System.Func`2[TSource, TElement]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "GroupBy" (cl:list type-1 type-2 type-3) source key-selector element-selector comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:or (cl:null element-selector) (dotnet:is-instance-of element-selector "System.Func`3[TKey, System.Collections.Generic.IEnumerable`1[TSource], TResult]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "GroupBy" (cl:list type-1 type-2 type-3) source key-selector element-selector comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:or (cl:null element-selector) (dotnet:is-instance-of element-selector "System.Func`2[TSource, TElement]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "GroupBy" (cl:list type-1 type-2 type-3) source key-selector element-selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:or (cl:null element-selector) (dotnet:is-instance-of element-selector "System.Func`3[TKey, System.Collections.Generic.IEnumerable`1[TSource], TResult]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "GroupBy" (cl:list type-1 type-2 type-3) source key-selector element-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "GroupBy"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :key-selector key-selector) (cl:list :element-selector element-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun group-by-arity-4 (type-1 type-2 type-3 type-4 source key-selector element-selector result-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.GroupBy overloads. Dispatches at runtime.

GroupBy(IEnumerable, Func, Func, IEnumerable) -> IEnumerable
  Summary: Groups the elements of a sequence according to a specified key selector function and creates a result value from each group and its key. The elements of each group are projected by using a specified function.
  Returns: A collection of elements of type where each element represents a projection over a group and its key.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements to group.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - element-selector (System.Func`2[TSource, TElement]): A function to map each source element to an element in an System.Linq.IGrouping`2.
    - result-selector (System.Func`3[TKey, System.Collections.Generic.IEnumerable`1[TElement], TResult]): A function to create a result value from each group.

GroupBy(IEnumerable, Func, Func, IEnumerable, IEqualityComparer) -> IEnumerable
  Summary: Groups the elements of a sequence according to a specified key selector function and creates a result value from each group and its key. Key values are compared by using a specified comparer, and the elements of each group are projected by using a specified function.
  Returns: A collection of elements of type where each element represents a projection over a group and its key.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose elements to group.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - element-selector (System.Func`2[TSource, TElement]): A function to map each source element to an element in an System.Linq.IGrouping`2.
    - result-selector (System.Func`3[TKey, System.Collections.Generic.IEnumerable`1[TElement], TResult]): A function to create a result value from each group.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to compare keys with.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:or (cl:null element-selector) (dotnet:is-instance-of element-selector "System.Func`2[TSource, TElement]")) (cl:or (cl:null result-selector) (dotnet:is-instance-of result-selector "System.Func`3[TKey, System.Collections.Generic.IEnumerable`1[TElement], TResult]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "GroupBy" (cl:list type-1 type-2 type-3 type-4) source key-selector element-selector result-selector comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:or (cl:null element-selector) (dotnet:is-instance-of element-selector "System.Func`2[TSource, TElement]")) (cl:or (cl:null result-selector) (dotnet:is-instance-of result-selector "System.Func`3[TKey, System.Collections.Generic.IEnumerable`1[TElement], TResult]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "GroupBy" (cl:list type-1 type-2 type-3 type-4) source key-selector element-selector result-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "GroupBy"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :key-selector key-selector) (cl:list :element-selector element-selector) (cl:list :result-selector result-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun group-by (types cl:&rest args)
  "Dispatches group-by by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (2 (cl:apply (cl:function group-by-arity-2) (cl:append type-list args)))
      (3 (cl:apply (cl:function group-by-arity-3) (cl:append type-list args)))
      (4 (cl:apply (cl:function group-by-arity-4) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-LINQ-ENUMERABLE"
                      :class-name <type-str>
                      :method-name "group-by"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

(cl:defun group-join (type-1 type-2 type-3 type-4 outer inner outer-key-selector inner-key-selector result-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.GroupJoin overloads. Dispatches at runtime.

GroupJoin(IEnumerable, IEnumerable, Func, Func, IEnumerable) -> IEnumerable
  Summary: Correlates the elements of two sequences based on equality of keys and groups the results. The default equality comparer is used to compare keys.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains elements of type that are obtained by performing a grouped join on two sequences.
  Parameters:
    - outer (System.Collections.Generic.IEnumerable`1[TOuter]): The first sequence to join.
    - inner (System.Collections.Generic.IEnumerable`1[TInner]): The sequence to join to the first sequence.
    - outer-key-selector (System.Func`2[TOuter, TKey]): A function to extract the join key from each element of the first sequence.
    - inner-key-selector (System.Func`2[TInner, TKey]): A function to extract the join key from each element of the second sequence.
    - result-selector (System.Func`3[TOuter, System.Collections.Generic.IEnumerable`1[TInner], TResult]): A function to create a result element from an element from the first sequence and a collection of matching elements from the second sequence.

GroupJoin(IEnumerable, IEnumerable, Func, Func, IEnumerable, IEqualityComparer) -> IEnumerable
  Summary: Correlates the elements of two sequences based on key equality and groups the results. A specified System.Collections.Generic.IEqualityComparer`1 is used to compare keys.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains elements of type that are obtained by performing a grouped join on two sequences.
  Parameters:
    - outer (System.Collections.Generic.IEnumerable`1[TOuter]): The first sequence to join.
    - inner (System.Collections.Generic.IEnumerable`1[TInner]): The sequence to join to the first sequence.
    - outer-key-selector (System.Func`2[TOuter, TKey]): A function to extract the join key from each element of the first sequence.
    - inner-key-selector (System.Func`2[TInner, TKey]): A function to extract the join key from each element of the second sequence.
    - result-selector (System.Func`3[TOuter, System.Collections.Generic.IEnumerable`1[TInner], TResult]): A function to create a result element from an element from the first sequence and a collection of matching elements from the second sequence.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to hash and compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null outer) (dotnet:is-instance-of outer "System.Collections.Generic.IEnumerable`1[TOuter]")) (cl:or (cl:null inner) (dotnet:is-instance-of inner "System.Collections.Generic.IEnumerable`1[TInner]")) (cl:or (cl:null outer-key-selector) (dotnet:is-instance-of outer-key-selector "System.Func`2[TOuter, TKey]")) (cl:or (cl:null inner-key-selector) (dotnet:is-instance-of inner-key-selector "System.Func`2[TInner, TKey]")) (cl:or (cl:null result-selector) (dotnet:is-instance-of result-selector "System.Func`3[TOuter, System.Collections.Generic.IEnumerable`1[TInner], TResult]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "GroupJoin" (cl:list type-1 type-2 type-3 type-4) outer inner outer-key-selector inner-key-selector result-selector comparer))
    ((cl:and (cl:or (cl:null outer) (dotnet:is-instance-of outer "System.Collections.Generic.IEnumerable`1[TOuter]")) (cl:or (cl:null inner) (dotnet:is-instance-of inner "System.Collections.Generic.IEnumerable`1[TInner]")) (cl:or (cl:null outer-key-selector) (dotnet:is-instance-of outer-key-selector "System.Func`2[TOuter, TKey]")) (cl:or (cl:null inner-key-selector) (dotnet:is-instance-of inner-key-selector "System.Func`2[TInner, TKey]")) (cl:or (cl:null result-selector) (dotnet:is-instance-of result-selector "System.Func`3[TOuter, System.Collections.Generic.IEnumerable`1[TInner], TResult]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "GroupJoin" (cl:list type-1 type-2 type-3 type-4) outer inner outer-key-selector inner-key-selector result-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "GroupJoin"
                    :supplied-args (cl:append (cl:list :outer outer) (cl:list :inner inner) (cl:list :outer-key-selector outer-key-selector) (cl:list :inner-key-selector inner-key-selector) (cl:list :result-selector result-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

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
  "Master wrapper for System.Linq.Enumerable.Intersect overloads. Dispatches at runtime.

Intersect(IEnumerable, IEnumerable) -> IEnumerable
  Summary: Produces the set intersection of two sequences by using the default equality comparer to compare values.
  Returns: A sequence that contains the elements that form the set intersection of two sequences.
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements that also appear in second will be returned.
    - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements that also appear in the first sequence will be returned.

Intersect(IEnumerable, IEnumerable, IEqualityComparer) -> IEnumerable
  Summary: Produces the set intersection of two sequences by using the specified System.Collections.Generic.IEqualityComparer`1 to compare values.
  Returns: A sequence that contains the elements that form the set intersection of two sequences.
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements that also appear in second will be returned.
    - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements that also appear in the first sequence will be returned.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TSource]): An System.Collections.Generic.IEqualityComparer`1 to compare values.
"
  (cl:cond
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TSource]")))
     (dotnet:static-generic <type-str> "Intersect" (cl:list type) first second comparer))
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "Intersect" (cl:list type) first second))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Intersect"
                    :supplied-args (cl:append (cl:list :first first) (cl:list :second second) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun intersect-by (type-1 type-2 first second key-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.IntersectBy overloads. Dispatches at runtime.

IntersectBy(IEnumerable, IEnumerable, Func) -> IEnumerable
  Summary: Produces the set intersection of two sequences according to a specified key selector function.
  Returns: A sequence that contains the elements that form the set intersection of two sequences.
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements that also appear in second will be returned.
    - second (System.Collections.Generic.IEnumerable`1[TKey]): An System.Collections.Generic.IEnumerable`1 whose distinct elements that also appear in the first sequence will be returned.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.

IntersectBy(IEnumerable, IEnumerable, Func, IEqualityComparer) -> IEnumerable
  Summary: Produces the set intersection of two sequences according to a specified key selector function.
  Returns: A sequence that contains the elements that form the set intersection of two sequences.
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements that also appear in second will be returned.
    - second (System.Collections.Generic.IEnumerable`1[TKey]): An System.Collections.Generic.IEnumerable`1 whose distinct elements that also appear in the first sequence will be returned.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TKey]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "IntersectBy" (cl:list type-1 type-2) first second key-selector comparer))
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TKey]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "IntersectBy" (cl:list type-1 type-2) first second key-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "IntersectBy"
                    :supplied-args (cl:append (cl:list :first first) (cl:list :second second) (cl:list :key-selector key-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun join (type-1 type-2 type-3 type-4 outer inner outer-key-selector inner-key-selector result-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.Join overloads. Dispatches at runtime.

Join(IEnumerable, IEnumerable, Func, Func, Func) -> IEnumerable
  Summary: Correlates the elements of two sequences based on matching keys. The default equality comparer is used to compare keys.
  Returns: An System.Collections.Generic.IEnumerable`1 that has elements of type that are obtained by performing an inner join on two sequences.
  Parameters:
    - outer (System.Collections.Generic.IEnumerable`1[TOuter]): The first sequence to join.
    - inner (System.Collections.Generic.IEnumerable`1[TInner]): The sequence to join to the first sequence.
    - outer-key-selector (System.Func`2[TOuter, TKey]): A function to extract the join key from each element of the first sequence.
    - inner-key-selector (System.Func`2[TInner, TKey]): A function to extract the join key from each element of the second sequence.
    - result-selector (System.Func`3[TOuter, TInner, TResult]): A function to create a result element from two matching elements.

Join(IEnumerable, IEnumerable, Func, Func, Func, IEqualityComparer) -> IEnumerable
  Summary: Correlates the elements of two sequences based on matching keys. A specified System.Collections.Generic.IEqualityComparer`1 is used to compare keys.
  Returns: An System.Collections.Generic.IEnumerable`1 that has elements of type that are obtained by performing an inner join on two sequences.
  Parameters:
    - outer (System.Collections.Generic.IEnumerable`1[TOuter]): The first sequence to join.
    - inner (System.Collections.Generic.IEnumerable`1[TInner]): The sequence to join to the first sequence.
    - outer-key-selector (System.Func`2[TOuter, TKey]): A function to extract the join key from each element of the first sequence.
    - inner-key-selector (System.Func`2[TInner, TKey]): A function to extract the join key from each element of the second sequence.
    - result-selector (System.Func`3[TOuter, TInner, TResult]): A function to create a result element from two matching elements.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to hash and compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null outer) (dotnet:is-instance-of outer "System.Collections.Generic.IEnumerable`1[TOuter]")) (cl:or (cl:null inner) (dotnet:is-instance-of inner "System.Collections.Generic.IEnumerable`1[TInner]")) (cl:or (cl:null outer-key-selector) (dotnet:is-instance-of outer-key-selector "System.Func`2[TOuter, TKey]")) (cl:or (cl:null inner-key-selector) (dotnet:is-instance-of inner-key-selector "System.Func`2[TInner, TKey]")) (cl:or (cl:null result-selector) (dotnet:is-instance-of result-selector "System.Func`3[TOuter, TInner, TResult]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "Join" (cl:list type-1 type-2 type-3 type-4) outer inner outer-key-selector inner-key-selector result-selector comparer))
    ((cl:and (cl:or (cl:null outer) (dotnet:is-instance-of outer "System.Collections.Generic.IEnumerable`1[TOuter]")) (cl:or (cl:null inner) (dotnet:is-instance-of inner "System.Collections.Generic.IEnumerable`1[TInner]")) (cl:or (cl:null outer-key-selector) (dotnet:is-instance-of outer-key-selector "System.Func`2[TOuter, TKey]")) (cl:or (cl:null inner-key-selector) (dotnet:is-instance-of inner-key-selector "System.Func`2[TInner, TKey]")) (cl:or (cl:null result-selector) (dotnet:is-instance-of result-selector "System.Func`3[TOuter, TInner, TResult]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "Join" (cl:list type-1 type-2 type-3 type-4) outer inner outer-key-selector inner-key-selector result-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Join"
                    :supplied-args (cl:append (cl:list :outer outer) (cl:list :inner inner) (cl:list :outer-key-selector outer-key-selector) (cl:list :inner-key-selector inner-key-selector) (cl:list :result-selector result-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun last (type source cl:&optional (predicate cl:nil supplied-predicate))
  "Master wrapper for System.Linq.Enumerable.Last overloads. Dispatches at runtime.

Last(IEnumerable) -> TSource
  Summary: Returns the last element of a sequence.
  Returns: The value at the last position in the source sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return the last element of.

Last(IEnumerable, Boolean]) -> TSource
  Summary: Returns the last element of a sequence that satisfies a specified condition.
  Returns: The last element in the sequence that passes the test in the specified predicate function.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
    - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-predicate (cl:or (cl:null predicate) (dotnet:is-instance-of predicate "System.Func`2[TSource, System.Boolean]")))
     (dotnet:static-generic <type-str> "Last" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-predicate))
     (dotnet:static-generic <type-str> "Last" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Last"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-predicate (cl:list :predicate predicate)))))))

(cl:defun last-or-default (type source cl:&optional (default-value cl:nil supplied-default-value) (default-value2 cl:nil supplied-default-value2))
  "Master wrapper for System.Linq.Enumerable.LastOrDefault overloads. Dispatches at runtime.

LastOrDefault(IEnumerable) -> TSource
  Summary: Returns the last element of a sequence, or a default value if the sequence contains no elements.
  Returns: () if the source sequence is empty; otherwise, the last element in the System.Collections.Generic.IEnumerable`1.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return the last element of.

LastOrDefault(IEnumerable, TSource) -> TSource
  Summary: Returns the last element of a sequence, or a specified default value if the sequence contains no elements.
  Returns: defaultValue if the source sequence is empty; otherwise, the last element in the System.Collections.Generic.IEnumerable`1.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return the last element of.
    - default-value (TSource): The default value to return if the sequence is empty.

LastOrDefault(IEnumerable, Boolean]) -> TSource
  Summary: Returns the last element of a sequence that satisfies a condition or a default value if no such element is found.
  Returns: () if the sequence is empty or if no elements pass the test in the predicate function; otherwise, the last element that passes the test in the predicate function.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
    - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.

LastOrDefault(IEnumerable, Boolean], TSource) -> TSource
  Summary: Returns the last element of a sequence that satisfies a condition, or a specified default value if no such element is found.
  Returns: defaultValue if the sequence is empty or if no elements pass the test in the predicate function; otherwise, the last element that passes the test in the predicate function.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return an element from.
    - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
    - default-value (TSource): The default value to return if the sequence is empty.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-default-value (cl:or (cl:null default-value) (dotnet:is-instance-of default-value "System.Func`2[TSource, System.Boolean]")) supplied-default-value2 (cl:or (cl:null default-value2) (dotnet:is-instance-of default-value2 "TSource")))
     (dotnet:static-generic <type-str> "LastOrDefault" (cl:list type) source default-value default-value2))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-default-value (cl:or (cl:null default-value) (dotnet:is-instance-of default-value "TSource")) (cl:not supplied-default-value2))
     (dotnet:static-generic <type-str> "LastOrDefault" (cl:list type) source default-value))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-default-value (cl:or (cl:null default-value) (dotnet:is-instance-of default-value "System.Func`2[TSource, System.Boolean]")) (cl:not supplied-default-value2))
     (dotnet:static-generic <type-str> "LastOrDefault" (cl:list type) source default-value))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-default-value) (cl:not supplied-default-value2))
     (dotnet:static-generic <type-str> "LastOrDefault" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "LastOrDefault"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-default-value (cl:list :default-value default-value)) (cl:when supplied-default-value2 (cl:list :default-value2 default-value2)))))))

(cl:defun left-join (type-1 type-2 type-3 type-4 outer inner outer-key-selector inner-key-selector result-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.LeftJoin overloads. Dispatches at runtime.

LeftJoin(IEnumerable, IEnumerable, Func, Func, Func) -> IEnumerable
  Summary: Correlates the elements of two sequences based on matching keys. The default equality comparer is used to compare keys.
  Returns: An System.Collections.Generic.IEnumerable`1 that has elements of type that are obtained by performing a left outer join on two sequences.
  Parameters:
    - outer (System.Collections.Generic.IEnumerable`1[TOuter]): The first sequence to join.
    - inner (System.Collections.Generic.IEnumerable`1[TInner]): The sequence to join to the first sequence.
    - outer-key-selector (System.Func`2[TOuter, TKey]): A function to extract the join key from each element of the first sequence.
    - inner-key-selector (System.Func`2[TInner, TKey]): A function to extract the join key from each element of the second sequence.
    - result-selector (System.Func`3[TOuter, TInner, TResult]): A function to create a result element from two matching elements.

LeftJoin(IEnumerable, IEnumerable, Func, Func, Func, IEqualityComparer) -> IEnumerable
  Summary: Correlates the elements of two sequences based on matching keys. A specified System.Collections.Generic.IEqualityComparer`1 is used to compare keys.
  Returns: An System.Collections.Generic.IEnumerable`1 that has elements of type that are obtained by performing a left outer join on two sequences.
  Parameters:
    - outer (System.Collections.Generic.IEnumerable`1[TOuter]): The first sequence to join.
    - inner (System.Collections.Generic.IEnumerable`1[TInner]): The sequence to join to the first sequence.
    - outer-key-selector (System.Func`2[TOuter, TKey]): A function to extract the join key from each element of the first sequence.
    - inner-key-selector (System.Func`2[TInner, TKey]): A function to extract the join key from each element of the second sequence.
    - result-selector (System.Func`3[TOuter, TInner, TResult]): A function to create a result element from two matching elements.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to hash and compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null outer) (dotnet:is-instance-of outer "System.Collections.Generic.IEnumerable`1[TOuter]")) (cl:or (cl:null inner) (dotnet:is-instance-of inner "System.Collections.Generic.IEnumerable`1[TInner]")) (cl:or (cl:null outer-key-selector) (dotnet:is-instance-of outer-key-selector "System.Func`2[TOuter, TKey]")) (cl:or (cl:null inner-key-selector) (dotnet:is-instance-of inner-key-selector "System.Func`2[TInner, TKey]")) (cl:or (cl:null result-selector) (dotnet:is-instance-of result-selector "System.Func`3[TOuter, TInner, TResult]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "LeftJoin" (cl:list type-1 type-2 type-3 type-4) outer inner outer-key-selector inner-key-selector result-selector comparer))
    ((cl:and (cl:or (cl:null outer) (dotnet:is-instance-of outer "System.Collections.Generic.IEnumerable`1[TOuter]")) (cl:or (cl:null inner) (dotnet:is-instance-of inner "System.Collections.Generic.IEnumerable`1[TInner]")) (cl:or (cl:null outer-key-selector) (dotnet:is-instance-of outer-key-selector "System.Func`2[TOuter, TKey]")) (cl:or (cl:null inner-key-selector) (dotnet:is-instance-of inner-key-selector "System.Func`2[TInner, TKey]")) (cl:or (cl:null result-selector) (dotnet:is-instance-of result-selector "System.Func`3[TOuter, TInner, TResult]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "LeftJoin" (cl:list type-1 type-2 type-3 type-4) outer inner outer-key-selector inner-key-selector result-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "LeftJoin"
                    :supplied-args (cl:append (cl:list :outer outer) (cl:list :inner inner) (cl:list :outer-key-selector outer-key-selector) (cl:list :inner-key-selector inner-key-selector) (cl:list :result-selector result-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun long-count (type source cl:&optional (predicate cl:nil supplied-predicate))
  "Master wrapper for System.Linq.Enumerable.LongCount overloads. Dispatches at runtime.

LongCount(IEnumerable) -> Int64
  Summary: Returns an System.Int64 that represents the total number of elements in a sequence.
  Returns: The number of elements in the source sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 that contains the elements to be counted.

LongCount(IEnumerable, Boolean]) -> Int64
  Summary: Returns an System.Int64 that represents how many elements in a sequence satisfy a condition.
  Returns: A number that represents how many elements in the sequence satisfy the condition in the predicate function.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 that contains the elements to be counted.
    - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-predicate (cl:or (cl:null predicate) (dotnet:is-instance-of predicate "System.Func`2[TSource, System.Boolean]")))
     (dotnet:static-generic <type-str> "LongCount" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-predicate))
     (dotnet:static-generic <type-str> "LongCount" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "LongCount"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-predicate (cl:list :predicate predicate)))))))

(cl:defun max (source)
  "Master wrapper for System.Linq.Enumerable.Max overloads. Dispatches at runtime.

Max(Int32]) -> Int32
  Summary: Returns the maximum value in a sequence of System.Int32 values.
  Returns: The maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Int32]): A sequence of System.Int32 values to determine the maximum value of.

Max(Int64]) -> Int64
  Summary: Returns the maximum value in a sequence of System.Int64 values.
  Returns: The maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Int64]): A sequence of System.Int64 values to determine the maximum value of.

Max(Int32]]) -> Int32]
  Summary: Returns the maximum value in a sequence of nullable System.Int32 values.
  Returns: A value of type Nullable<Int32> in C# or Nullable(Of Int32) in Visual Basic that corresponds to the maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int32]]): A sequence of nullable System.Int32 values to determine the maximum value of.

Max(Int64]]) -> Int64]
  Summary: Returns the maximum value in a sequence of nullable System.Int64 values.
  Returns: A value of type Nullable<Int64> in C# or Nullable(Of Int64) in Visual Basic that corresponds to the maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int64]]): A sequence of nullable System.Int64 values to determine the maximum value of.

Max(Double]) -> Double
  Summary: Returns the maximum value in a sequence of System.Double values.
  Returns: The maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Double]): A sequence of System.Double values to determine the maximum value of.

Max(Double]]) -> Double]
  Summary: Returns the maximum value in a sequence of nullable System.Double values.
  Returns: A value of type Nullable<Double> in C# or Nullable(Of Double) in Visual Basic that corresponds to the maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Double]]): A sequence of nullable System.Double values to determine the maximum value of.

Max(Single]) -> Single
  Summary: Returns the maximum value in a sequence of System.Single values.
  Returns: The maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Single]): A sequence of System.Single values to determine the maximum value of.

Max(Single]]) -> Single]
  Summary: Returns the maximum value in a sequence of nullable System.Single values.
  Returns: A value of type Nullable<Single> in C# or Nullable(Of Single) in Visual Basic that corresponds to the maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Single]]): A sequence of nullable System.Single values to determine the maximum value of.

Max(Decimal]) -> Decimal
  Summary: Returns the maximum value in a sequence of System.Decimal values.
  Returns: The maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Decimal]): A sequence of System.Decimal values to determine the maximum value of.

Max(Decimal]]) -> Decimal]
  Summary: Returns the maximum value in a sequence of nullable System.Decimal values.
  Returns: A value of type Nullable<Decimal> in C# or Nullable(Of Decimal) in Visual Basic that corresponds to the maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Decimal]]): A sequence of nullable System.Decimal values to determine the maximum value of.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Int32, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Int64, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Int32, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Int64, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Double, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Double, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Single, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Single, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Decimal, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Max" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Decimal, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Max" source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Max"
                    :supplied-args (cl:append (cl:list :source source))))))

(cl:defun max-arity-1 (type source cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.Max overloads. Dispatches at runtime.

Max(IEnumerable) -> TSource
  Summary: Returns the maximum value in a generic sequence.
  Returns: The maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.

Max(IEnumerable, IComparer) -> TSource
  Summary: Returns the maximum value in a generic sequence.
  Returns: The maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
    - comparer (System.Collections.Generic.IComparer`1[TSource]): The System.Collections.Generic.IComparer`1 to compare values.

Max(IEnumerable, Int32]) -> Int32
  Summary: Invokes a transform function on each element of a sequence and returns the maximum System.Int32 value.
  Returns: The maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
    - selector (System.Func`2[TSource, System.Int32]): A transform function to apply to each element.

Max(IEnumerable, Int32]]) -> Int32]
  Summary: Invokes a transform function on each element of a sequence and returns the maximum nullable System.Int32 value.
  Returns: The value of type Nullable<Int32> in C# or Nullable(Of Int32) in Visual Basic that corresponds to the maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Int32]]): A transform function to apply to each element.

Max(IEnumerable, Int64]) -> Int64
  Summary: Invokes a transform function on each element of a sequence and returns the maximum System.Int64 value.
  Returns: The maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
    - selector (System.Func`2[TSource, System.Int64]): A transform function to apply to each element.

Max(IEnumerable, Int64]]) -> Int64]
  Summary: Invokes a transform function on each element of a sequence and returns the maximum nullable System.Int64 value.
  Returns: The value that corresponds to the maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Int64]]): A transform function to apply to each element.

Max(IEnumerable, Single]) -> Single
  Summary: Invokes a transform function on each element of a sequence and returns the maximum System.Single value.
  Returns: The maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
    - selector (System.Func`2[TSource, System.Single]): A transform function to apply to each element.

Max(IEnumerable, Single]]) -> Single]
  Summary: Invokes a transform function on each element of a sequence and returns the maximum nullable System.Single value.
  Returns: The value that corresponds to the maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Single]]): A transform function to apply to each element.

Max(IEnumerable, Double]) -> Double
  Summary: Invokes a transform function on each element of a sequence and returns the maximum System.Double value.
  Returns: The maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
    - selector (System.Func`2[TSource, System.Double]): A transform function to apply to each element.

Max(IEnumerable, Double]]) -> Double]
  Summary: Invokes a transform function on each element of a sequence and returns the maximum nullable System.Double value.
  Returns: The value of type Nullable<Double> in C# or Nullable(Of Double) in Visual Basic that corresponds to the maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Double]]): A transform function to apply to each element.

Max(IEnumerable, Decimal]) -> Decimal
  Summary: Invokes a transform function on each element of a sequence and returns the maximum System.Decimal value.
  Returns: The maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
    - selector (System.Func`2[TSource, System.Decimal]): A transform function to apply to each element.

Max(IEnumerable, Decimal]]) -> Decimal]
  Summary: Invokes a transform function on each element of a sequence and returns the maximum nullable System.Decimal value.
  Returns: The value of type Nullable<Decimal> in C# or Nullable(Of Decimal) in Visual Basic that corresponds to the maximum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Decimal]]): A transform function to apply to each element.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IComparer`1[TSource]")))
     (dotnet:static-generic <type-str> "Max" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Int32]")))
     (dotnet:static-generic <type-str> "Max" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Nullable`1[System.Int32]]")))
     (dotnet:static-generic <type-str> "Max" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Int64]")))
     (dotnet:static-generic <type-str> "Max" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Nullable`1[System.Int64]]")))
     (dotnet:static-generic <type-str> "Max" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Single]")))
     (dotnet:static-generic <type-str> "Max" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Nullable`1[System.Single]]")))
     (dotnet:static-generic <type-str> "Max" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Double]")))
     (dotnet:static-generic <type-str> "Max" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Nullable`1[System.Double]]")))
     (dotnet:static-generic <type-str> "Max" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Decimal]")))
     (dotnet:static-generic <type-str> "Max" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Nullable`1[System.Decimal]]")))
     (dotnet:static-generic <type-str> "Max" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "Max" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Max"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun max-arity-2 (type-1 type-2 source selector)
  "Summary: Invokes a transform function on each element of a generic sequence and returns the maximum resulting value.
Returns: The maximum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
  - selector (System.Func`2[TSource, TResult]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Max" (cl:list type-1 type-2) source selector))

(cl:defun max<> (types cl:&rest args)
  "Dispatches max<> by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload.
   Passing cl:nil or an empty list calls the non-generic max overload(s)."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (0 (cl:apply (cl:function max) args))
      (1 (cl:apply (cl:function max-arity-1) (cl:append type-list args)))
      (2 (cl:apply (cl:function max-arity-2) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-LINQ-ENUMERABLE"
                      :class-name <type-str>
                      :method-name "max<>"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

(cl:defun max-by (type-1 type-2 source key-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.MaxBy overloads. Dispatches at runtime.

MaxBy(IEnumerable, Func) -> TSource
  Summary: Returns the maximum value in a generic sequence according to a specified key selector function.
  Returns: The value with the maximum key in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.

MaxBy(IEnumerable, Func, IComparer) -> TSource
  Summary: Returns the maximum value in a generic sequence according to a specified key selector function and key comparer.
  Returns: The value with the maximum key in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the maximum value of.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - comparer (System.Collections.Generic.IComparer`1[TKey]): The System.Collections.Generic.IComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "MaxBy" (cl:list type-1 type-2) source key-selector comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "MaxBy" (cl:list type-1 type-2) source key-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "MaxBy"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :key-selector key-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun min (source)
  "Master wrapper for System.Linq.Enumerable.Min overloads. Dispatches at runtime.

Min(Int32]) -> Int32
  Summary: Returns the minimum value in a sequence of System.Int32 values.
  Returns: The minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Int32]): A sequence of System.Int32 values to determine the minimum value of.

Min(Int64]) -> Int64
  Summary: Returns the minimum value in a sequence of System.Int64 values.
  Returns: The minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Int64]): A sequence of System.Int64 values to determine the minimum value of.

Min(Int32]]) -> Int32]
  Summary: Returns the minimum value in a sequence of nullable System.Int32 values.
  Returns: The value that corresponds to the minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int32]]): A sequence of nullable System.Int32 values to determine the minimum value of.

Min(Int64]]) -> Int64]
  Summary: Returns the minimum value in a sequence of nullable System.Int64 values.
  Returns: The value that corresponds to the minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int64]]): A sequence of nullable System.Int64 values to determine the minimum value of.

Min(Single]) -> Single
  Summary: Returns the minimum value in a sequence of System.Single values.
  Returns: The minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Single]): A sequence of System.Single values to determine the minimum value of.

Min(Single]]) -> Single]
  Summary: Returns the minimum value in a sequence of nullable System.Single values.
  Returns: The value that corresponds to the minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Single]]): A sequence of nullable System.Single values to determine the minimum value of.

Min(Double]) -> Double
  Summary: Returns the minimum value in a sequence of System.Double values.
  Returns: The minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Double]): A sequence of System.Double values to determine the minimum value of.

Min(Double]]) -> Double]
  Summary: Returns the minimum value in a sequence of nullable System.Double values.
  Returns: The value that corresponds to the minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Double]]): A sequence of nullable System.Double values to determine the minimum value of.

Min(Decimal]) -> Decimal
  Summary: Returns the minimum value in a sequence of System.Decimal values.
  Returns: The minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Decimal]): A sequence of System.Decimal values to determine the minimum value of.

Min(Decimal]]) -> Decimal]
  Summary: Returns the minimum value in a sequence of nullable System.Decimal values.
  Returns: The value that corresponds to the minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Decimal]]): A sequence of nullable System.Decimal values to determine the minimum value of.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Int32, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Int64, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Int32, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Int64, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Single, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Single, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Double, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Double, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Decimal, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Min" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Decimal, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Min" source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Min"
                    :supplied-args (cl:append (cl:list :source source))))))

(cl:defun min-arity-1 (type source cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.Min overloads. Dispatches at runtime.

Min(IEnumerable) -> TSource
  Summary: Returns the minimum value in a generic sequence.
  Returns: The minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.

Min(IEnumerable, IComparer) -> TSource
  Summary: Returns the minimum value in a generic sequence.
  Returns: The minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
    - comparer (System.Collections.Generic.IComparer`1[TSource]): The System.Collections.Generic.IComparer`1 to compare values.

Min(IEnumerable, Int32]) -> Int32
  Summary: Invokes a transform function on each element of a sequence and returns the minimum System.Int32 value.
  Returns: The minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
    - selector (System.Func`2[TSource, System.Int32]): A transform function to apply to each element.

Min(IEnumerable, Int32]]) -> Int32]
  Summary: Invokes a transform function on each element of a sequence and returns the minimum nullable System.Int32 value.
  Returns: The value that corresponds to the minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Int32]]): A transform function to apply to each element.

Min(IEnumerable, Int64]) -> Int64
  Summary: Invokes a transform function on each element of a sequence and returns the minimum System.Int64 value.
  Returns: The minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
    - selector (System.Func`2[TSource, System.Int64]): A transform function to apply to each element.

Min(IEnumerable, Int64]]) -> Int64]
  Summary: Invokes a transform function on each element of a sequence and returns the minimum nullable System.Int64 value.
  Returns: The value that corresponds to the minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Int64]]): A transform function to apply to each element.

Min(IEnumerable, Single]) -> Single
  Summary: Invokes a transform function on each element of a sequence and returns the minimum System.Single value.
  Returns: The minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
    - selector (System.Func`2[TSource, System.Single]): A transform function to apply to each element.

Min(IEnumerable, Single]]) -> Single]
  Summary: Invokes a transform function on each element of a sequence and returns the minimum nullable System.Single value.
  Returns: The value that corresponds to the minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Single]]): A transform function to apply to each element.

Min(IEnumerable, Double]) -> Double
  Summary: Invokes a transform function on each element of a sequence and returns the minimum System.Double value.
  Returns: The minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
    - selector (System.Func`2[TSource, System.Double]): A transform function to apply to each element.

Min(IEnumerable, Double]]) -> Double]
  Summary: Invokes a transform function on each element of a sequence and returns the minimum nullable System.Double value.
  Returns: The value that corresponds to the minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Double]]): A transform function to apply to each element.

Min(IEnumerable, Decimal]) -> Decimal
  Summary: Invokes a transform function on each element of a sequence and returns the minimum System.Decimal value.
  Returns: The minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
    - selector (System.Func`2[TSource, System.Decimal]): A transform function to apply to each element.

Min(IEnumerable, Decimal]]) -> Decimal]
  Summary: Invokes a transform function on each element of a sequence and returns the minimum nullable System.Decimal value.
  Returns: The value that corresponds to the minimum value in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Decimal]]): A transform function to apply to each element.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IComparer`1[TSource]")))
     (dotnet:static-generic <type-str> "Min" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Int32]")))
     (dotnet:static-generic <type-str> "Min" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Nullable`1[System.Int32]]")))
     (dotnet:static-generic <type-str> "Min" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Int64]")))
     (dotnet:static-generic <type-str> "Min" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Nullable`1[System.Int64]]")))
     (dotnet:static-generic <type-str> "Min" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Single]")))
     (dotnet:static-generic <type-str> "Min" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Nullable`1[System.Single]]")))
     (dotnet:static-generic <type-str> "Min" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Double]")))
     (dotnet:static-generic <type-str> "Min" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Nullable`1[System.Double]]")))
     (dotnet:static-generic <type-str> "Min" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Decimal]")))
     (dotnet:static-generic <type-str> "Min" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, System.Nullable`1[System.Decimal]]")))
     (dotnet:static-generic <type-str> "Min" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "Min" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Min"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun min-arity-2 (type-1 type-2 source selector)
  "Summary: Invokes a transform function on each element of a generic sequence and returns the minimum resulting value.
Returns: The minimum value in the sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
  - selector (System.Func`2[TSource, TResult]): A transform function to apply to each element.
"
  (dotnet:static-generic <type-str> "Min" (cl:list type-1 type-2) source selector))

(cl:defun min<> (types cl:&rest args)
  "Dispatches min<> by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload.
   Passing cl:nil or an empty list calls the non-generic min overload(s)."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (0 (cl:apply (cl:function min) args))
      (1 (cl:apply (cl:function min-arity-1) (cl:append type-list args)))
      (2 (cl:apply (cl:function min-arity-2) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-LINQ-ENUMERABLE"
                      :class-name <type-str>
                      :method-name "min<>"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

(cl:defun min-by (type-1 type-2 source key-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.MinBy overloads. Dispatches at runtime.

MinBy(IEnumerable, Func) -> TSource
  Summary: Returns the minimum value in a generic sequence according to a specified key selector function.
  Returns: The value with the minimum key in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.

MinBy(IEnumerable, Func, IComparer) -> TSource
  Summary: Returns the minimum value in a generic sequence according to a specified key selector function and key comparer.
  Returns: The value with the minimum key in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to determine the minimum value of.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - comparer (System.Collections.Generic.IComparer`1[TKey]): The System.Collections.Generic.IComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "MinBy" (cl:list type-1 type-2) source key-selector comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "MinBy" (cl:list type-1 type-2) source key-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "MinBy"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :key-selector key-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun of-type (type source)
  "Summary: Filters the elements of an System.Collections.IEnumerable based on a specified type.
Returns: An System.Collections.Generic.IEnumerable`1 that contains elements from the input sequence of type .
Parameters:
  - source (System.Collections.IEnumerable): The System.Collections.IEnumerable whose elements to filter.
"
  (dotnet:static-generic <type-str> "OfType" (cl:list type) source))

(cl:defun order (type source cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.Order overloads. Dispatches at runtime.

Order(IEnumerable) -> IOrderedEnumerable
  Summary: Sorts the elements of a sequence in ascending order.
  Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[T]): A sequence of values to order.

Order(IEnumerable, IComparer) -> IOrderedEnumerable
  Summary: Sorts the elements of a sequence in ascending order.
  Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[T]): A sequence of values to order.
    - comparer (System.Collections.Generic.IComparer`1[T]): An System.Collections.Generic.IComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[T]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IComparer`1[T]")))
     (dotnet:static-generic <type-str> "Order" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[T]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "Order" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Order"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun order-by (type-1 type-2 source key-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.OrderBy overloads. Dispatches at runtime.

OrderBy(IEnumerable, Func) -> IOrderedEnumerable
  Summary: Sorts the elements of a sequence in ascending order according to a key.
  Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted according to a key.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to order.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from an element.

OrderBy(IEnumerable, Func, IComparer) -> IOrderedEnumerable
  Summary: Sorts the elements of a sequence in ascending order by using a specified comparer.
  Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted according to a key.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to order.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from an element.
    - comparer (System.Collections.Generic.IComparer`1[TKey]): An System.Collections.Generic.IComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "OrderBy" (cl:list type-1 type-2) source key-selector comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "OrderBy" (cl:list type-1 type-2) source key-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "OrderBy"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :key-selector key-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun order-by-descending (type-1 type-2 source key-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.OrderByDescending overloads. Dispatches at runtime.

OrderByDescending(IEnumerable, Func) -> IOrderedEnumerable
  Summary: Sorts the elements of a sequence in descending order according to a key.
  Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted in descending order according to a key.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to order.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from an element.

OrderByDescending(IEnumerable, Func, IComparer) -> IOrderedEnumerable
  Summary: Sorts the elements of a sequence in descending order by using a specified comparer.
  Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted in descending order according to a key.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to order.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from an element.
    - comparer (System.Collections.Generic.IComparer`1[TKey]): An System.Collections.Generic.IComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "OrderByDescending" (cl:list type-1 type-2) source key-selector comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "OrderByDescending" (cl:list type-1 type-2) source key-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "OrderByDescending"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :key-selector key-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun order-descending (type source cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.OrderDescending overloads. Dispatches at runtime.

OrderDescending(IEnumerable) -> IOrderedEnumerable
  Summary: Sorts the elements of a sequence in descending order.
  Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[T]): A sequence of values to order.

OrderDescending(IEnumerable, IComparer) -> IOrderedEnumerable
  Summary: Sorts the elements of a sequence in descending order.
  Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[T]): A sequence of values to order.
    - comparer (System.Collections.Generic.IComparer`1[T]): An System.Collections.Generic.IComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[T]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IComparer`1[T]")))
     (dotnet:static-generic <type-str> "OrderDescending" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[T]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "OrderDescending" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "OrderDescending"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

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
  "Master wrapper for System.Linq.Enumerable.Reverse overloads. Dispatches at runtime.

Reverse(IEnumerable) -> IEnumerable
  Summary: Inverts the order of the elements in a sequence.
  Returns: A sequence whose elements correspond to those of the input sequence in reverse order.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to reverse.

Reverse(TSource[]) -> IEnumerable
  Parameters:
    - source (TSource[]): 
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")))
     (dotnet:static-generic <type-str> "Reverse" (cl:list type) source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "TSource[]")))
     (dotnet:static-generic <type-str> "Reverse" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Reverse"
                    :supplied-args (cl:append (cl:list :source source))))))

(cl:defun right-join (type-1 type-2 type-3 type-4 outer inner outer-key-selector inner-key-selector result-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.RightJoin overloads. Dispatches at runtime.

RightJoin(IEnumerable, IEnumerable, Func, Func, Func) -> IEnumerable
  Summary: Correlates the elements of two sequences based on matching keys. The default equality comparer is used to compare keys.
  Returns: An System.Collections.Generic.IEnumerable`1 that has elements of type that are obtained by performing a right outer join on two sequences.
  Parameters:
    - outer (System.Collections.Generic.IEnumerable`1[TOuter]): The first sequence to join.
    - inner (System.Collections.Generic.IEnumerable`1[TInner]): The sequence to join to the first sequence.
    - outer-key-selector (System.Func`2[TOuter, TKey]): A function to extract the join key from each element of the first sequence.
    - inner-key-selector (System.Func`2[TInner, TKey]): A function to extract the join key from each element of the second sequence.
    - result-selector (System.Func`3[TOuter, TInner, TResult]): A function to create a result element from two matching elements.

RightJoin(IEnumerable, IEnumerable, Func, Func, Func, IEqualityComparer) -> IEnumerable
  Summary: Correlates the elements of two sequences based on matching keys. A specified System.Collections.Generic.IEqualityComparer`1 is used to compare keys.
  Returns: An System.Collections.Generic.IEnumerable`1 that has elements of type that are obtained by performing a right outer join on two sequences.
  Parameters:
    - outer (System.Collections.Generic.IEnumerable`1[TOuter]): The first sequence to join.
    - inner (System.Collections.Generic.IEnumerable`1[TInner]): The sequence to join to the first sequence.
    - outer-key-selector (System.Func`2[TOuter, TKey]): A function to extract the join key from each element of the first sequence.
    - inner-key-selector (System.Func`2[TInner, TKey]): A function to extract the join key from each element of the second sequence.
    - result-selector (System.Func`3[TOuter, TInner, TResult]): A function to create a result element from two matching elements.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to hash and compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null outer) (dotnet:is-instance-of outer "System.Collections.Generic.IEnumerable`1[TOuter]")) (cl:or (cl:null inner) (dotnet:is-instance-of inner "System.Collections.Generic.IEnumerable`1[TInner]")) (cl:or (cl:null outer-key-selector) (dotnet:is-instance-of outer-key-selector "System.Func`2[TOuter, TKey]")) (cl:or (cl:null inner-key-selector) (dotnet:is-instance-of inner-key-selector "System.Func`2[TInner, TKey]")) (cl:or (cl:null result-selector) (dotnet:is-instance-of result-selector "System.Func`3[TOuter, TInner, TResult]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "RightJoin" (cl:list type-1 type-2 type-3 type-4) outer inner outer-key-selector inner-key-selector result-selector comparer))
    ((cl:and (cl:or (cl:null outer) (dotnet:is-instance-of outer "System.Collections.Generic.IEnumerable`1[TOuter]")) (cl:or (cl:null inner) (dotnet:is-instance-of inner "System.Collections.Generic.IEnumerable`1[TInner]")) (cl:or (cl:null outer-key-selector) (dotnet:is-instance-of outer-key-selector "System.Func`2[TOuter, TKey]")) (cl:or (cl:null inner-key-selector) (dotnet:is-instance-of inner-key-selector "System.Func`2[TInner, TKey]")) (cl:or (cl:null result-selector) (dotnet:is-instance-of result-selector "System.Func`3[TOuter, TInner, TResult]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "RightJoin" (cl:list type-1 type-2 type-3 type-4) outer inner outer-key-selector inner-key-selector result-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "RightJoin"
                    :supplied-args (cl:append (cl:list :outer outer) (cl:list :inner inner) (cl:list :outer-key-selector outer-key-selector) (cl:list :inner-key-selector inner-key-selector) (cl:list :result-selector result-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun select (type-1 type-2 source selector)
  "Master wrapper for System.Linq.Enumerable.Select overloads. Dispatches at runtime.

Select(IEnumerable, Func) -> IEnumerable
  Summary: Projects each element of a sequence into a new form.
  Returns: An System.Collections.Generic.IEnumerable`1 whose elements are the result of invoking the transform function on each element of source.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to invoke a transform function on.
    - selector (System.Func`2[TSource, TResult]): A transform function to apply to each element.

Select(IEnumerable, Int32, TResult]) -> IEnumerable
  Summary: Projects each element of a sequence into a new form by incorporating the element's index.
  Returns: An System.Collections.Generic.IEnumerable`1 whose elements are the result of invoking the transform function on each element of source.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to invoke a transform function on.
    - selector (System.Func`3[TSource, System.Int32, TResult]): A transform function to apply to each source element; the second parameter of the function represents the index of the source element.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, TResult]")))
     (dotnet:static-generic <type-str> "Select" (cl:list type-1 type-2) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`3[TSource, System.Int32, TResult]")))
     (dotnet:static-generic <type-str> "Select" (cl:list type-1 type-2) source selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Select"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :selector selector))))))

(cl:defun select-many-arity-2 (type-1 type-2 source selector)
  "Master wrapper for System.Linq.Enumerable.SelectMany overloads. Dispatches at runtime.

SelectMany(IEnumerable, IEnumerable) -> IEnumerable
  Summary: Projects each element of a sequence to an System.Collections.Generic.IEnumerable`1 and flattens the resulting sequences into one sequence.
  Returns: An System.Collections.Generic.IEnumerable`1 whose elements are the result of invoking the one-to-many transform function on each element of the input sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to project.
    - selector (System.Func`2[TSource, System.Collections.Generic.IEnumerable`1[TResult]]): A transform function to apply to each element.

SelectMany(IEnumerable, IEnumerable) -> IEnumerable
  Summary: Projects each element of a sequence to an System.Collections.Generic.IEnumerable`1, and flattens the resulting sequences into one sequence. The index of each source element is used in the projected form of that element.
  Returns: An System.Collections.Generic.IEnumerable`1 whose elements are the result of invoking the one-to-many transform function on each element of an input sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to project.
    - selector (System.Func`3[TSource, System.Int32, System.Collections.Generic.IEnumerable`1[TResult]]): A transform function to apply to each source element; the second parameter of the function represents the index of the source element.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Collections.Generic.IEnumerable`1[TResult]]")))
     (dotnet:static-generic <type-str> "SelectMany" (cl:list type-1 type-2) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`3[TSource, System.Int32, System.Collections.Generic.IEnumerable`1[TResult]]")))
     (dotnet:static-generic <type-str> "SelectMany" (cl:list type-1 type-2) source selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "SelectMany"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :selector selector))))))

(cl:defun select-many-arity-3 (type-1 type-2 type-3 source collection-selector result-selector)
  "Master wrapper for System.Linq.Enumerable.SelectMany overloads. Dispatches at runtime.

SelectMany(IEnumerable, IEnumerable, Func) -> IEnumerable
  Summary: Projects each element of a sequence to an System.Collections.Generic.IEnumerable`1, flattens the resulting sequences into one sequence, and invokes a result selector function on each element therein. The index of each source element is used in the intermediate projected form of that element.
  Returns: An System.Collections.Generic.IEnumerable`1 whose elements are the result of invoking the one-to-many transform function collectionSelector on each element of source and then mapping each of those sequence elements and their corresponding source element to a result element.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to project.
    - collection-selector (System.Func`3[TSource, System.Int32, System.Collections.Generic.IEnumerable`1[TCollection]]): A transform function to apply to each source element; the second parameter of the function represents the index of the source element.
    - result-selector (System.Func`3[TSource, TCollection, TResult]): A transform function to apply to each element of the intermediate sequence.

SelectMany(IEnumerable, IEnumerable, Func) -> IEnumerable
  Summary: Projects each element of a sequence to an System.Collections.Generic.IEnumerable`1, flattens the resulting sequences into one sequence, and invokes a result selector function on each element therein.
  Returns: An System.Collections.Generic.IEnumerable`1 whose elements are the result of invoking the one-to-many transform function collectionSelector on each element of source and then mapping each of those sequence elements and their corresponding source element to a result element.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to project.
    - collection-selector (System.Func`2[TSource, System.Collections.Generic.IEnumerable`1[TCollection]]): A transform function to apply to each element of the input sequence.
    - result-selector (System.Func`3[TSource, TCollection, TResult]): A transform function to apply to each element of the intermediate sequence.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null collection-selector) (dotnet:is-instance-of collection-selector "System.Func`3[TSource, System.Int32, System.Collections.Generic.IEnumerable`1[TCollection]]")) (cl:or (cl:null result-selector) (dotnet:is-instance-of result-selector "System.Func`3[TSource, TCollection, TResult]")))
     (dotnet:static-generic <type-str> "SelectMany" (cl:list type-1 type-2 type-3) source collection-selector result-selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null collection-selector) (dotnet:is-instance-of collection-selector "System.Func`2[TSource, System.Collections.Generic.IEnumerable`1[TCollection]]")) (cl:or (cl:null result-selector) (dotnet:is-instance-of result-selector "System.Func`3[TSource, TCollection, TResult]")))
     (dotnet:static-generic <type-str> "SelectMany" (cl:list type-1 type-2 type-3) source collection-selector result-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "SelectMany"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :collection-selector collection-selector) (cl:list :result-selector result-selector))))))

(cl:defun select-many (types cl:&rest args)
  "Dispatches select-many by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (2 (cl:apply (cl:function select-many-arity-2) (cl:append type-list args)))
      (3 (cl:apply (cl:function select-many-arity-3) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-LINQ-ENUMERABLE"
                      :class-name <type-str>
                      :method-name "select-many"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

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
  "Master wrapper for System.Linq.Enumerable.SequenceEqual overloads. Dispatches at runtime.

SequenceEqual(IEnumerable, IEnumerable) -> Boolean
  Summary: Determines whether two sequences are equal by comparing the elements by using the default equality comparer for their type.
  Returns: if the two source sequences are of equal length and their corresponding elements are equal according to the default equality comparer for their type; otherwise, .
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to compare to second.
    - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to compare to the first sequence.

SequenceEqual(IEnumerable, IEnumerable, IEqualityComparer) -> Boolean
  Summary: Determines whether two sequences are equal by comparing their elements by using a specified System.Collections.Generic.IEqualityComparer`1.
  Returns: if the two source sequences are of equal length and their corresponding elements compare equal according to comparer; otherwise, .
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to compare to second.
    - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to compare to the first sequence.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TSource]): An System.Collections.Generic.IEqualityComparer`1 to use to compare elements.
"
  (cl:cond
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TSource]")))
     (dotnet:static-generic <type-str> "SequenceEqual" (cl:list type) first second comparer))
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "SequenceEqual" (cl:list type) first second))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "SequenceEqual"
                    :supplied-args (cl:append (cl:list :first first) (cl:list :second second) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun shuffle (type source)
  "Summary: Shuffles the order of the elements of a sequence.
Returns: A sequence whose elements correspond to those of the input sequence in randomized order.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values to shuffle.
"
  (dotnet:static-generic <type-str> "Shuffle" (cl:list type) source))

(cl:defun single (type source cl:&optional (predicate cl:nil supplied-predicate))
  "Master wrapper for System.Linq.Enumerable.Single overloads. Dispatches at runtime.

Single(IEnumerable) -> TSource
  Summary: Returns the only element of a sequence, and throws an exception if there is not exactly one element in the sequence.
  Returns: The single element of the input sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return the single element of.

Single(IEnumerable, Boolean]) -> TSource
  Summary: Returns the only element of a sequence that satisfies a specified condition, and throws an exception if more than one such element exists.
  Returns: The single element of the input sequence that satisfies a condition.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return a single element from.
    - predicate (System.Func`2[TSource, System.Boolean]): A function to test an element for a condition.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-predicate (cl:or (cl:null predicate) (dotnet:is-instance-of predicate "System.Func`2[TSource, System.Boolean]")))
     (dotnet:static-generic <type-str> "Single" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-predicate))
     (dotnet:static-generic <type-str> "Single" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Single"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-predicate (cl:list :predicate predicate)))))))

(cl:defun single-or-default (type source cl:&optional (default-value cl:nil supplied-default-value) (default-value2 cl:nil supplied-default-value2))
  "Master wrapper for System.Linq.Enumerable.SingleOrDefault overloads. Dispatches at runtime.

SingleOrDefault(IEnumerable) -> TSource
  Summary: Returns the only element of a sequence, or a default value if the sequence is empty; this method throws an exception if there is more than one element in the sequence.
  Returns: The single element of the input sequence, or () if the sequence contains no elements.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return the single element of.

SingleOrDefault(IEnumerable, TSource) -> TSource
  Summary: Returns the only element of a sequence, or a specified default value if the sequence is empty; this method throws an exception if there is more than one element in the sequence.
  Returns: The single element of the input sequence, or defaultValue if the sequence contains no elements.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return the single element of.
    - default-value (TSource): The default value to return if the sequence is empty.

SingleOrDefault(IEnumerable, Boolean]) -> TSource
  Summary: Returns the only element of a sequence that satisfies a specified condition or a default value if no such element exists; this method throws an exception if more than one element satisfies the condition.
  Returns: The single element of the input sequence that satisfies the condition, or () if no such element is found.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return a single element from.
    - predicate (System.Func`2[TSource, System.Boolean]): A function to test an element for a condition.

SingleOrDefault(IEnumerable, Boolean], TSource) -> TSource
  Summary: Returns the only element of a sequence that satisfies a specified condition, or a specified default value if no such element exists; this method throws an exception if more than one element satisfies the condition.
  Returns: The single element of the input sequence that satisfies the condition, or defaultValue if no such element is found.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return a single element from.
    - predicate (System.Func`2[TSource, System.Boolean]): A function to test an element for a condition.
    - default-value (TSource): The default value to return if the sequence is empty.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-default-value (cl:or (cl:null default-value) (dotnet:is-instance-of default-value "System.Func`2[TSource, System.Boolean]")) supplied-default-value2 (cl:or (cl:null default-value2) (dotnet:is-instance-of default-value2 "TSource")))
     (dotnet:static-generic <type-str> "SingleOrDefault" (cl:list type) source default-value default-value2))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-default-value (cl:or (cl:null default-value) (dotnet:is-instance-of default-value "TSource")) (cl:not supplied-default-value2))
     (dotnet:static-generic <type-str> "SingleOrDefault" (cl:list type) source default-value))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-default-value (cl:or (cl:null default-value) (dotnet:is-instance-of default-value "System.Func`2[TSource, System.Boolean]")) (cl:not supplied-default-value2))
     (dotnet:static-generic <type-str> "SingleOrDefault" (cl:list type) source default-value))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-default-value) (cl:not supplied-default-value2))
     (dotnet:static-generic <type-str> "SingleOrDefault" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "SingleOrDefault"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-default-value (cl:list :default-value default-value)) (cl:when supplied-default-value2 (cl:list :default-value2 default-value2)))))))

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
  "Master wrapper for System.Linq.Enumerable.SkipWhile overloads. Dispatches at runtime.

SkipWhile(IEnumerable, Boolean]) -> IEnumerable
  Summary: Bypasses elements in a sequence as long as a specified condition is true and then returns the remaining elements.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains the elements from the input sequence starting at the first element in the linear series that does not pass the test specified by predicate.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return elements from.
    - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.

SkipWhile(IEnumerable, Boolean]) -> IEnumerable
  Summary: Bypasses elements in a sequence as long as a specified condition is true and then returns the remaining elements. The element's index is used in the logic of the predicate function.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains the elements from the input sequence starting at the first element in the linear series that does not pass the test specified by predicate.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to return elements from.
    - predicate (System.Func`3[TSource, System.Int32, System.Boolean]): A function to test each source element for a condition; the second parameter of the function represents the index of the source element.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null predicate) (dotnet:is-instance-of predicate "System.Func`2[TSource, System.Boolean]")))
     (dotnet:static-generic <type-str> "SkipWhile" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null predicate) (dotnet:is-instance-of predicate "System.Func`3[TSource, System.Int32, System.Boolean]")))
     (dotnet:static-generic <type-str> "SkipWhile" (cl:list type) source predicate))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "SkipWhile"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :predicate predicate))))))

(cl:defun sum (source)
  "Master wrapper for System.Linq.Enumerable.Sum overloads. Dispatches at runtime.

Sum(Int32]) -> Int32
  Summary: Computes the sum of a sequence of System.Int32 values.
  Returns: The sum of the values in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Int32]): A sequence of System.Int32 values to calculate the sum of.

Sum(Int64]) -> Int64
  Summary: Computes the sum of a sequence of System.Int64 values.
  Returns: The sum of the values in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Int64]): A sequence of System.Int64 values to calculate the sum of.

Sum(Single]) -> Single
  Summary: Computes the sum of a sequence of System.Single values.
  Returns: The sum of the values in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Single]): A sequence of System.Single values to calculate the sum of.

Sum(Double]) -> Double
  Summary: Computes the sum of a sequence of System.Double values.
  Returns: The sum of the values in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Double]): A sequence of System.Double values to calculate the sum of.

Sum(Decimal]) -> Decimal
  Summary: Computes the sum of a sequence of System.Decimal values.
  Returns: The sum of the values in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Decimal]): A sequence of System.Decimal values to calculate the sum of.

Sum(Int32]]) -> Int32]
  Summary: Computes the sum of a sequence of nullable System.Int32 values.
  Returns: The sum of the values in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int32]]): A sequence of nullable System.Int32 values to calculate the sum of.

Sum(Int64]]) -> Int64]
  Summary: Computes the sum of a sequence of nullable System.Int64 values.
  Returns: The sum of the values in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Int64]]): A sequence of nullable System.Int64 values to calculate the sum of.

Sum(Single]]) -> Single]
  Summary: Computes the sum of a sequence of nullable System.Single values.
  Returns: The sum of the values in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Single]]): A sequence of nullable System.Single values to calculate the sum of.

Sum(Double]]) -> Double]
  Summary: Computes the sum of a sequence of nullable System.Double values.
  Returns: The sum of the values in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Double]]): A sequence of nullable System.Double values to calculate the sum of.

Sum(Decimal]]) -> Decimal]
  Summary: Computes the sum of a sequence of nullable System.Decimal values.
  Returns: The sum of the values in the sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Nullable`1[System.Decimal]]): A sequence of nullable System.Decimal values to calculate the sum of.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Int32, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Int64, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Single, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Double, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Decimal, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Int32, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Int64, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Single, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Double, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Sum" source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[[System.Nullable`1[[System.Decimal, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")))
     (dotnet:static <type-str> "Sum" source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Sum"
                    :supplied-args (cl:append (cl:list :source source))))))

(cl:defun sum-arity-1 (type source selector)
  "Master wrapper for System.Linq.Enumerable.Sum overloads. Dispatches at runtime.

Sum(IEnumerable, Int32]) -> Int32
  Summary: Computes the sum of the sequence of System.Int32 values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The sum of the projected values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
    - selector (System.Func`2[TSource, System.Int32]): A transform function to apply to each element.

Sum(IEnumerable, Int64]) -> Int64
  Summary: Computes the sum of the sequence of System.Int64 values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The sum of the projected values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
    - selector (System.Func`2[TSource, System.Int64]): A transform function to apply to each element.

Sum(IEnumerable, Single]) -> Single
  Summary: Computes the sum of the sequence of System.Single values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The sum of the projected values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
    - selector (System.Func`2[TSource, System.Single]): A transform function to apply to each element.

Sum(IEnumerable, Double]) -> Double
  Summary: Computes the sum of the sequence of System.Double values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The sum of the projected values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
    - selector (System.Func`2[TSource, System.Double]): A transform function to apply to each element.

Sum(IEnumerable, Decimal]) -> Decimal
  Summary: Computes the sum of the sequence of System.Decimal values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The sum of the projected values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
    - selector (System.Func`2[TSource, System.Decimal]): A transform function to apply to each element.

Sum(IEnumerable, Int32]]) -> Int32]
  Summary: Computes the sum of the sequence of nullable System.Int32 values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The sum of the projected values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Int32]]): A transform function to apply to each element.

Sum(IEnumerable, Int64]]) -> Int64]
  Summary: Computes the sum of the sequence of nullable System.Int64 values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The sum of the projected values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Int64]]): A transform function to apply to each element.

Sum(IEnumerable, Single]]) -> Single]
  Summary: Computes the sum of the sequence of nullable System.Single values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The sum of the projected values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Single]]): A transform function to apply to each element.

Sum(IEnumerable, Double]]) -> Double]
  Summary: Computes the sum of the sequence of nullable System.Double values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The sum of the projected values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Double]]): A transform function to apply to each element.

Sum(IEnumerable, Decimal]]) -> Decimal]
  Summary: Computes the sum of the sequence of nullable System.Decimal values that are obtained by invoking a transform function on each element of the input sequence.
  Returns: The sum of the projected values.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence of values that are used to calculate a sum.
    - selector (System.Func`2[TSource, System.Nullable`1[System.Decimal]]): A transform function to apply to each element.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Int32]")))
     (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Int64]")))
     (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Single]")))
     (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Double]")))
     (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Decimal]")))
     (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Nullable`1[System.Int32]]")))
     (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Nullable`1[System.Int64]]")))
     (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Nullable`1[System.Single]]")))
     (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Nullable`1[System.Double]]")))
     (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null selector) (dotnet:is-instance-of selector "System.Func`2[TSource, System.Nullable`1[System.Decimal]]")))
     (dotnet:static-generic <type-str> "Sum" (cl:list type) source selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Sum"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :selector selector))))))

(cl:defun sum<> (types cl:&rest args)
  "Dispatches sum<> by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload.
   Passing cl:nil or an empty list calls the non-generic sum overload(s)."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (0 (cl:apply (cl:function sum) args))
      (1 (cl:apply (cl:function sum-arity-1) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-LINQ-ENUMERABLE"
                      :class-name <type-str>
                      :method-name "sum<>"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

(cl:defun take (type source count)
  "Master wrapper for System.Linq.Enumerable.Take overloads. Dispatches at runtime.

Take(IEnumerable, Int32) -> IEnumerable
  Summary: Returns a specified number of contiguous elements from the start of a sequence.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains the specified number of elements from the start of the input sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to return elements from.
    - count (System.Int32): The number of elements to return.

Take(IEnumerable, Range) -> IEnumerable
  Summary: Returns a specified range of contiguous elements from a sequence.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains the specified range of elements from the source sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to return elements from.
    - range (System.Range): The range of elements to return, which has start and end indexes either from the beginning or the end of the sequence.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:numberp count))
     (dotnet:static-generic <type-str> "Take" (cl:list type) source count))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null count) (dotnet:is-instance-of count "System.Range")))
     (dotnet:static-generic <type-str> "Take" (cl:list type) source count))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Take"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :count count))))))

(cl:defun take-last (type source count)
  "Summary: Returns a new enumerable collection that contains the last count elements from source.
Returns: A new enumerable collection that contains the last count elements from source.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An enumerable collection instance.
  - count (System.Int32): The number of elements to take from the end of the collection.
"
  (dotnet:static-generic <type-str> "TakeLast" (cl:list type) source count))

(cl:defun take-while (type source predicate)
  "Master wrapper for System.Linq.Enumerable.TakeWhile overloads. Dispatches at runtime.

TakeWhile(IEnumerable, Boolean]) -> IEnumerable
  Summary: Returns elements from a sequence as long as a specified condition is true.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains the elements from the input sequence that occur before the element at which the test no longer passes.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence to return elements from.
    - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.

TakeWhile(IEnumerable, Boolean]) -> IEnumerable
  Summary: Returns elements from a sequence as long as a specified condition is true. The element's index is used in the logic of the predicate function.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains elements from the input sequence that occur before the element at which the test no longer passes.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The sequence to return elements from.
    - predicate (System.Func`3[TSource, System.Int32, System.Boolean]): A function to test each source element for a condition; the second parameter of the function represents the index of the source element.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null predicate) (dotnet:is-instance-of predicate "System.Func`2[TSource, System.Boolean]")))
     (dotnet:static-generic <type-str> "TakeWhile" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null predicate) (dotnet:is-instance-of predicate "System.Func`3[TSource, System.Int32, System.Boolean]")))
     (dotnet:static-generic <type-str> "TakeWhile" (cl:list type) source predicate))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "TakeWhile"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :predicate predicate))))))

(cl:defun then-by (type-1 type-2 source key-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.ThenBy overloads. Dispatches at runtime.

ThenBy(IOrderedEnumerable, Func) -> IOrderedEnumerable
  Summary: Performs a subsequent ordering of the elements in a sequence in ascending order according to a key.
  Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted according to a key.
  Parameters:
    - source (System.Linq.IOrderedEnumerable`1[TSource]): An System.Linq.IOrderedEnumerable`1 that contains elements to sort.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from each element.

ThenBy(IOrderedEnumerable, Func, IComparer) -> IOrderedEnumerable
  Summary: Performs a subsequent ordering of the elements in a sequence in ascending order by using a specified comparer.
  Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted according to a key.
  Parameters:
    - source (System.Linq.IOrderedEnumerable`1[TSource]): An System.Linq.IOrderedEnumerable`1 that contains elements to sort.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from each element.
    - comparer (System.Collections.Generic.IComparer`1[TKey]): An System.Collections.Generic.IComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Linq.IOrderedEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "ThenBy" (cl:list type-1 type-2) source key-selector comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Linq.IOrderedEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "ThenBy" (cl:list type-1 type-2) source key-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "ThenBy"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :key-selector key-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun then-by-descending (type-1 type-2 source key-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.ThenByDescending overloads. Dispatches at runtime.

ThenByDescending(IOrderedEnumerable, Func) -> IOrderedEnumerable
  Summary: Performs a subsequent ordering of the elements in a sequence in descending order, according to a key.
  Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted in descending order according to a key.
  Parameters:
    - source (System.Linq.IOrderedEnumerable`1[TSource]): An System.Linq.IOrderedEnumerable`1 that contains elements to sort.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from each element.

ThenByDescending(IOrderedEnumerable, Func, IComparer) -> IOrderedEnumerable
  Summary: Performs a subsequent ordering of the elements in a sequence in descending order by using a specified comparer.
  Returns: An System.Linq.IOrderedEnumerable`1 whose elements are sorted in descending order according to a key.
  Parameters:
    - source (System.Linq.IOrderedEnumerable`1[TSource]): An System.Linq.IOrderedEnumerable`1 that contains elements to sort.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from each element.
    - comparer (System.Collections.Generic.IComparer`1[TKey]): An System.Collections.Generic.IComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Linq.IOrderedEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "ThenByDescending" (cl:list type-1 type-2) source key-selector comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Linq.IOrderedEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "ThenByDescending" (cl:list type-1 type-2) source key-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "ThenByDescending"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :key-selector key-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun to-array (type source)
  "Summary: Creates an array from a System.Collections.Generic.IEnumerable`1.
Returns: An array that contains the elements from the input sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to create an array from.
"
  (dotnet:static-generic <type-str> "ToArray" (cl:list type) source))

(cl:defun to-dictionary-arity-2 (type-1 type-2 source cl:&optional (comparer cl:nil supplied-comparer) (comparer2 cl:nil supplied-comparer2))
  "Master wrapper for System.Linq.Enumerable.ToDictionary overloads. Dispatches at runtime.

ToDictionary(KeyValuePair) -> Dictionary
  Summary: Creates a dictionary from an enumeration according to the default comparer for the key type.
  Returns: A dictionary that contains keys and values from source and uses the default comparer for the key type.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Collections.Generic.KeyValuePair`2[TKey, TValue]]): The enumeration to create a dictionary from.

ToDictionary(ValueTuple) -> Dictionary
  Summary: Creates a dictionary from an enumeration according to the default comparer for the key type.
  Returns: A dictionary that contains keys and values from source and uses default comparer for the key type.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.ValueTuple`2[TKey, TValue]]): The enumeration to create a dictionary from.

ToDictionary(KeyValuePair, IEqualityComparer) -> Dictionary
  Summary: Creates a dictionary from an enumeration according to specified key comparer.
  Returns: A dictionary that contains keys and values from source.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.Collections.Generic.KeyValuePair`2[TKey, TValue]]): The enumeration to create a dictionary from.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An equality comparer to compare keys.

ToDictionary(ValueTuple, IEqualityComparer) -> Dictionary
  Summary: Creates a dictionary from an enumeration according to specified key equality comparer.
  Returns: A dictionary that contains keys and values from source.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[System.ValueTuple`2[TKey, TValue]]): The enumeration to create a dictionary from.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An equality comparer to compare keys.

ToDictionary(IEnumerable, Func) -> Dictionary
  Summary: Creates a System.Collections.Generic.Dictionary`2 from an System.Collections.Generic.IEnumerable`1 according to a specified key selector function.
  Returns: A System.Collections.Generic.Dictionary`2 that contains keys and values. The values within each group are in the same order as in source.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to create a System.Collections.Generic.Dictionary`2 from.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from each element.

ToDictionary(IEnumerable, Func, IEqualityComparer) -> Dictionary
  Summary: Creates a System.Collections.Generic.Dictionary`2 from an System.Collections.Generic.IEnumerable`1 according to a specified key selector function and key comparer.
  Returns: A System.Collections.Generic.Dictionary`2 that contains keys and values. The values within each group are in the same order as in source.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to create a System.Collections.Generic.Dictionary`2 from.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from each element.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, TKey]")) supplied-comparer2 (cl:or (cl:null comparer2) (dotnet:is-instance-of comparer2 "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "ToDictionary" (cl:list type-1 type-2) source comparer comparer2))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[System.Collections.Generic.KeyValuePair`2[TKey, TValue]]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")) (cl:not supplied-comparer2))
     (dotnet:static-generic <type-str> "ToDictionary" (cl:list type-1 type-2) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[System.ValueTuple`2[TKey, TValue]]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")) (cl:not supplied-comparer2))
     (dotnet:static-generic <type-str> "ToDictionary" (cl:list type-1 type-2) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Func`2[TSource, TKey]")) (cl:not supplied-comparer2))
     (dotnet:static-generic <type-str> "ToDictionary" (cl:list type-1 type-2) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[System.Collections.Generic.KeyValuePair`2[TKey, TValue]]")) (cl:not supplied-comparer) (cl:not supplied-comparer2))
     (dotnet:static-generic <type-str> "ToDictionary" (cl:list type-1 type-2) source))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[System.ValueTuple`2[TKey, TValue]]")) (cl:not supplied-comparer) (cl:not supplied-comparer2))
     (dotnet:static-generic <type-str> "ToDictionary" (cl:list type-1 type-2) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "ToDictionary"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-comparer (cl:list :comparer comparer)) (cl:when supplied-comparer2 (cl:list :comparer2 comparer2)))))))

(cl:defun to-dictionary-arity-3 (type-1 type-2 type-3 source key-selector element-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.ToDictionary overloads. Dispatches at runtime.

ToDictionary(IEnumerable, Func, Func) -> Dictionary
  Summary: Creates a System.Collections.Generic.Dictionary`2 from an System.Collections.Generic.IEnumerable`1 according to specified key selector and element selector functions.
  Returns: A System.Collections.Generic.Dictionary`2 that contains values of type selected from the input sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to create a System.Collections.Generic.Dictionary`2 from.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from each element.
    - element-selector (System.Func`2[TSource, TElement]): A transform function to produce a result element value from each element.

ToDictionary(IEnumerable, Func, Func, IEqualityComparer) -> Dictionary
  Summary: Creates a System.Collections.Generic.Dictionary`2 from an System.Collections.Generic.IEnumerable`1 according to a specified key selector function, a comparer, and an element selector function.
  Returns: A System.Collections.Generic.Dictionary`2 that contains values of type selected from the input sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to create a System.Collections.Generic.Dictionary`2 from.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from each element.
    - element-selector (System.Func`2[TSource, TElement]): A transform function to produce a result element value from each element.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:or (cl:null element-selector) (dotnet:is-instance-of element-selector "System.Func`2[TSource, TElement]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "ToDictionary" (cl:list type-1 type-2 type-3) source key-selector element-selector comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:or (cl:null element-selector) (dotnet:is-instance-of element-selector "System.Func`2[TSource, TElement]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "ToDictionary" (cl:list type-1 type-2 type-3) source key-selector element-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "ToDictionary"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :key-selector key-selector) (cl:list :element-selector element-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun to-dictionary (types cl:&rest args)
  "Dispatches to-dictionary by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (2 (cl:apply (cl:function to-dictionary-arity-2) (cl:append type-list args)))
      (3 (cl:apply (cl:function to-dictionary-arity-3) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-LINQ-ENUMERABLE"
                      :class-name <type-str>
                      :method-name "to-dictionary"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

(cl:defun to-hash-set (type source cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.ToHashSet overloads. Dispatches at runtime.

ToHashSet(IEnumerable) -> HashSet
  Summary: Creates a System.Collections.Generic.HashSet`1 from an System.Collections.Generic.IEnumerable`1.
  Returns: A System.Collections.Generic.HashSet`1 that contains values of type selected from the input sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to create a System.Collections.Generic.HashSet`1 from.

ToHashSet(IEnumerable, IEqualityComparer) -> HashSet
  Summary: Creates a System.Collections.Generic.HashSet`1 from an System.Collections.Generic.IEnumerable`1 using the comparer to compare keys.
  Returns: A System.Collections.Generic.HashSet`1 that contains values of type selected from the input sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to create a System.Collections.Generic.HashSet`1 from.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TSource]): An System.Collections.Generic.IEqualityComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TSource]")))
     (dotnet:static-generic <type-str> "ToHashSet" (cl:list type) source comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "ToHashSet" (cl:list type) source))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "ToHashSet"
                    :supplied-args (cl:append (cl:list :source source) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun to-list (type source)
  "Summary: Creates a System.Collections.Generic.List`1 from an System.Collections.Generic.IEnumerable`1.
Returns: A System.Collections.Generic.List`1 that contains elements from the input sequence.
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): The System.Collections.Generic.IEnumerable`1 to create a System.Collections.Generic.List`1 from.
"
  (dotnet:static-generic <type-str> "ToList" (cl:list type) source))

(cl:defun to-lookup-arity-2 (type-1 type-2 source key-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.ToLookup overloads. Dispatches at runtime.

ToLookup(IEnumerable, Func) -> ILookup
  Summary: Creates a System.Linq.Lookup`2 from an System.Collections.Generic.IEnumerable`1 according to a specified key selector function.
  Returns: A System.Linq.Lookup`2 that contains keys and values. The values within each group are in the same order as in source.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The System.Collections.Generic.IEnumerable`1 to create a System.Linq.Lookup`2 from.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from each element.

ToLookup(IEnumerable, Func, IEqualityComparer) -> ILookup
  Summary: Creates a System.Linq.Lookup`2 from an System.Collections.Generic.IEnumerable`1 according to a specified key selector function and key comparer.
  Returns: A System.Linq.Lookup`2 that contains keys and values. The values within each group are in the same order as in source.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The System.Collections.Generic.IEnumerable`1 to create a System.Linq.Lookup`2 from.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from each element.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "ToLookup" (cl:list type-1 type-2) source key-selector comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "ToLookup" (cl:list type-1 type-2) source key-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "ToLookup"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :key-selector key-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun to-lookup-arity-3 (type-1 type-2 type-3 source key-selector element-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.ToLookup overloads. Dispatches at runtime.

ToLookup(IEnumerable, Func, Func) -> ILookup
  Summary: Creates a System.Linq.Lookup`2 from an System.Collections.Generic.IEnumerable`1 according to specified key selector and element selector functions.
  Returns: A System.Linq.Lookup`2 that contains values of type selected from the input sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The System.Collections.Generic.IEnumerable`1 to create a System.Linq.Lookup`2 from.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from each element.
    - element-selector (System.Func`2[TSource, TElement]): A transform function to produce a result element value from each element.

ToLookup(IEnumerable, Func, Func, IEqualityComparer) -> ILookup
  Summary: Creates a System.Linq.Lookup`2 from an System.Collections.Generic.IEnumerable`1 according to a specified key selector function, a comparer and an element selector function.
  Returns: A System.Linq.Lookup`2 that contains values of type selected from the input sequence.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): The System.Collections.Generic.IEnumerable`1 to create a System.Linq.Lookup`2 from.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract a key from each element.
    - element-selector (System.Func`2[TSource, TElement]): A transform function to produce a result element value from each element.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): An System.Collections.Generic.IEqualityComparer`1 to compare keys.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:or (cl:null element-selector) (dotnet:is-instance-of element-selector "System.Func`2[TSource, TElement]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "ToLookup" (cl:list type-1 type-2 type-3) source key-selector element-selector comparer))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:or (cl:null element-selector) (dotnet:is-instance-of element-selector "System.Func`2[TSource, TElement]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "ToLookup" (cl:list type-1 type-2 type-3) source key-selector element-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "ToLookup"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :key-selector key-selector) (cl:list :element-selector element-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun to-lookup (types cl:&rest args)
  "Dispatches to-lookup by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (2 (cl:apply (cl:function to-lookup-arity-2) (cl:append type-list args)))
      (3 (cl:apply (cl:function to-lookup-arity-3) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-LINQ-ENUMERABLE"
                      :class-name <type-str>
                      :method-name "to-lookup"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

(cl:defun union (type first second cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.Union overloads. Dispatches at runtime.

Union(IEnumerable, IEnumerable) -> IEnumerable
  Summary: Produces the set union of two sequences by using the default equality comparer.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains the elements from both input sequences, excluding duplicates.
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements form the first set for the union.
    - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements form the second set for the union.

Union(IEnumerable, IEnumerable, IEqualityComparer) -> IEnumerable
  Summary: Produces the set union of two sequences by using a specified System.Collections.Generic.IEqualityComparer`1.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains the elements from both input sequences, excluding duplicates.
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements form the first set for the union.
    - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements form the second set for the union.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TSource]): The System.Collections.Generic.IEqualityComparer`1 to compare values.
"
  (cl:cond
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TSource]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TSource]")))
     (dotnet:static-generic <type-str> "Union" (cl:list type) first second comparer))
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "Union" (cl:list type) first second))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Union"
                    :supplied-args (cl:append (cl:list :first first) (cl:list :second second) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun union-by (type-1 type-2 first second key-selector cl:&optional (comparer cl:nil supplied-comparer))
  "Master wrapper for System.Linq.Enumerable.UnionBy overloads. Dispatches at runtime.

UnionBy(IEnumerable, IEnumerable, Func) -> IEnumerable
  Summary: Produces the set union of two sequences according to a specified key selector function.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains the elements from both input sequences, excluding duplicates.
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements form the first set for the union.
    - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements form the second set for the union.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.

UnionBy(IEnumerable, IEnumerable, Func, IEqualityComparer) -> IEnumerable
  Summary: Produces the set union of two sequences according to a specified key selector function.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains the elements from both input sequences, excluding duplicates.
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements form the first set for the union.
    - second (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 whose distinct elements form the second set for the union.
    - key-selector (System.Func`2[TSource, TKey]): A function to extract the key for each element.
    - comparer (System.Collections.Generic.IEqualityComparer`1[TKey]): The System.Collections.Generic.IEqualityComparer`1 to compare values.
"
  (cl:cond
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) supplied-comparer (cl:or (cl:null comparer) (dotnet:is-instance-of comparer "System.Collections.Generic.IEqualityComparer`1[TKey]")))
     (dotnet:static-generic <type-str> "UnionBy" (cl:list type-1 type-2) first second key-selector comparer))
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null key-selector) (dotnet:is-instance-of key-selector "System.Func`2[TSource, TKey]")) (cl:not supplied-comparer))
     (dotnet:static-generic <type-str> "UnionBy" (cl:list type-1 type-2) first second key-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "UnionBy"
                    :supplied-args (cl:append (cl:list :first first) (cl:list :second second) (cl:list :key-selector key-selector) (cl:when supplied-comparer (cl:list :comparer comparer)))))))

(cl:defun where (type source predicate)
  "Master wrapper for System.Linq.Enumerable.Where overloads. Dispatches at runtime.

Where(IEnumerable, Boolean]) -> IEnumerable
  Summary: Filters a sequence of values based on a predicate.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains elements from the input sequence that satisfy the condition.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to filter.
    - predicate (System.Func`2[TSource, System.Boolean]): A function to test each element for a condition.

Where(IEnumerable, Boolean]) -> IEnumerable
  Summary: Filters a sequence of values based on a predicate. Each element's index is used in the logic of the predicate function.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains elements from the input sequence that satisfy the condition.
  Parameters:
    - source (System.Collections.Generic.IEnumerable`1[TSource]): An System.Collections.Generic.IEnumerable`1 to filter.
    - predicate (System.Func`3[TSource, System.Int32, System.Boolean]): A function to test each source element for a condition; the second parameter of the function represents the index of the source element.
"
  (cl:cond
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null predicate) (dotnet:is-instance-of predicate "System.Func`2[TSource, System.Boolean]")))
     (dotnet:static-generic <type-str> "Where" (cl:list type) source predicate))
    ((cl:and (cl:or (cl:null source) (dotnet:is-instance-of source "System.Collections.Generic.IEnumerable`1[TSource]")) (cl:or (cl:null predicate) (dotnet:is-instance-of predicate "System.Func`3[TSource, System.Int32, System.Boolean]")))
     (dotnet:static-generic <type-str> "Where" (cl:list type) source predicate))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Where"
                    :supplied-args (cl:append (cl:list :source source) (cl:list :predicate predicate))))))

(cl:defun zip-arity-2 (type-1 type-2 first second)
  "Summary: Produces a sequence of tuples with elements from the two specified sequences.
Returns: A sequence of tuples with elements taken from the first and second sequences, in that order.
Parameters:
  - first (System.Collections.Generic.IEnumerable`1[TFirst]): The first sequence to merge.
  - second (System.Collections.Generic.IEnumerable`1[TSecond]): The second sequence to merge.
"
  (dotnet:static-generic <type-str> "Zip" (cl:list type-1 type-2) first second))

(cl:defun zip-arity-3 (type-1 type-2 type-3 first second result-selector)
  "Master wrapper for System.Linq.Enumerable.Zip overloads. Dispatches at runtime.

Zip(IEnumerable, IEnumerable, Func) -> IEnumerable
  Summary: Applies a specified function to the corresponding elements of two sequences, producing a sequence of the results.
  Returns: An System.Collections.Generic.IEnumerable`1 that contains merged elements of two input sequences.
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TFirst]): The first sequence to merge.
    - second (System.Collections.Generic.IEnumerable`1[TSecond]): The second sequence to merge.
    - result-selector (System.Func`3[TFirst, TSecond, TResult]): A function that specifies how to merge the elements from the two sequences.

Zip(IEnumerable, IEnumerable, IEnumerable) -> ValueTuple
  Summary: Produces a sequence of tuples with elements from the three specified sequences.
  Returns: A sequence of tuples with elements taken from the first, second, and third sequences, in that order.
  Parameters:
    - first (System.Collections.Generic.IEnumerable`1[TFirst]): The first sequence to merge.
    - second (System.Collections.Generic.IEnumerable`1[TSecond]): The second sequence to merge.
    - third (System.Collections.Generic.IEnumerable`1[TThird]): The third sequence to merge.
"
  (cl:cond
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TFirst]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TSecond]")) (cl:or (cl:null result-selector) (dotnet:is-instance-of result-selector "System.Func`3[TFirst, TSecond, TResult]")))
     (dotnet:static-generic <type-str> "Zip" (cl:list type-1 type-2 type-3) first second result-selector))
    ((cl:and (cl:or (cl:null first) (dotnet:is-instance-of first "System.Collections.Generic.IEnumerable`1[TFirst]")) (cl:or (cl:null second) (dotnet:is-instance-of second "System.Collections.Generic.IEnumerable`1[TSecond]")) (cl:or (cl:null result-selector) (dotnet:is-instance-of result-selector "System.Collections.Generic.IEnumerable`1[TThird]")))
     (dotnet:static-generic <type-str> "Zip" (cl:list type-1 type-2 type-3) first second result-selector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-LINQ-ENUMERABLE"
                    :class-name <type-str>
                    :method-name "Zip"
                    :supplied-args (cl:append (cl:list :first first) (cl:list :second second) (cl:list :result-selector result-selector))))))

(cl:defun zip (types cl:&rest args)
  "Dispatches zip by the generic type argument(s) in TYPES: pass a
   single .NET type (a type-name string, alias, or System.Type object) to
   select the single-type-argument overload, or a cl:list of types to
   select the overload taking that many type arguments; ARGS are the
   remaining arguments, forwarded unchanged to the resolved overload."
  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))
    (cl:case (cl:length type-list)
      (2 (cl:apply (cl:function zip-arity-2) (cl:append type-list args)))
      (3 (cl:apply (cl:function zip-arity-3) (cl:append type-list args)))
      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                      :package-name "SYSTEM-LINQ-ENUMERABLE"
                      :class-name <type-str>
                      :method-name "zip"
                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))

(cl:defun try-get-non-enumerated-count (type source)
  "Returns (cl:values <primary-return> count) -- TryGetNonEnumeratedCount(IEnumerable, out Int32&) -> Boolean
Summary: Attempts to determine the number of elements in a sequence without forcing an enumeration.
Returns: if the count of source can be determined without enumeration; otherwise, .
Parameters:
  - source (System.Collections.Generic.IEnumerable`1[TSource]): A sequence that contains elements to be counted.
"
  (dotnet:call-out-generic <type-str> "TryGetNonEnumeratedCount" (cl:list type) source))

