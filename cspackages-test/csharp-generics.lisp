;;; Generated automatically. Do not edit.
;;; Generator Version: 51
;;; Creation Date: 2026-07-19T15:11:53Z

(cl:in-package :csharp-generics)

;;; Unified CLOS generic functions dispatching on C# runtime type.
;;; Each defmethod below specializes on #.(dotnet:class-for-type ...),
;;; resolved and registered at read time (DotCL 0.1.17+ required) --
;;; see doc/make-everything-defgeneric.md.

(cl:defgeneric equals (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Object: equals (system-object:equals)
System.String: equals (system-string:equals)
System.Text.StringBuilder: equals (system-text-string-builder:equals)
System.Numerics.Vector3: equals (system-numerics-vector3:equals)
System.Numerics.Vector4: equals (system-numerics-vector4:equals)
"))

(cl:defgeneric finalize (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Object: finalize (system-object:finalize)
"))

(cl:defgeneric get-hash-code (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Object: get-hash-code (system-object:get-hash-code)
System.String: get-hash-code (system-string:get-hash-code)
System.Numerics.Vector3: get-hash-code (system-numerics-vector3:get-hash-code)
System.Numerics.Vector4: get-hash-code (system-numerics-vector4:get-hash-code)
"))

(cl:defgeneric get-type (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Object: get-type (system-object:get-type)
"))

(cl:defgeneric memberwise-clone (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Object: memberwise-clone (system-object:memberwise-clone)
"))

(cl:defgeneric to-string (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Object: to-string (system-object:to-string)
System.String: to-string (system-string:to-string)
System.Text.StringBuilder: to-string (system-text-string-builder:to-string)
System.Numerics.Vector3: to-string (system-numerics-vector3:to-string)
System.Numerics.Vector4: to-string (system-numerics-vector4:to-string)
"))

(cl:defgeneric dummy-extension (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Object: dummy-extension (system-object:dummy-extension)
"))

(cl:defgeneric chars (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: chars (system-string:chars)
System.Text.StringBuilder: chars (system-text-string-builder:chars)
"))

(cl:defgeneric length (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: length (system-string:length)
System.Array: length (system-array:length)
System.Text.StringBuilder: length (system-text-string-builder:length)
System.Numerics.Vector3: length (system-numerics-vector3:length)
System.Numerics.Vector4: length (system-numerics-vector4:length)
"))

(cl:defgeneric clone (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: clone (system-string:clone)
System.Array: clone (system-array:clone)
"))

(cl:defgeneric compare-to (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: compare-to (system-string:compare-to)
"))

(cl:defgeneric contains (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: contains (system-string:contains)
"))

(cl:defgeneric copy-to (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: copy-to (system-string:copy-to)
System.Array: copy-to (system-array:copy-to)
System.Text.StringBuilder: copy-to (system-text-string-builder:copy-to)
System.Numerics.Vector3: copy-to (system-numerics-vector3:copy-to)
System.Numerics.Vector4: copy-to (system-numerics-vector4:copy-to)
"))

(cl:defgeneric ends-with (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: ends-with (system-string:ends-with)
"))

(cl:defgeneric enumerate-runes (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: enumerate-runes (system-string:enumerate-runes)
"))

(cl:defgeneric get-enumerator (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: get-enumerator (system-string:get-enumerator)
System.Array: get-enumerator (system-array:get-enumerator)
System.Collections.Generic.Dictionary`2: get-enumerator (system-collections-generic-dictionary-2:get-enumerator)
System.Collections.Generic.SortedList`2: get-enumerator (system-collections-generic-sorted-list-2:get-enumerator)
"))

(cl:defgeneric get-pinnable-reference (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: get-pinnable-reference (system-string:get-pinnable-reference)
"))

(cl:defgeneric get-type-code (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: get-type-code (system-string:get-type-code)
"))

(cl:defgeneric index-of (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: index-of (system-string:index-of)
"))

(cl:defgeneric index-of-any (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: index-of-any (system-string:index-of-any)
"))

(cl:defgeneric insert (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: insert (system-string:insert)
System.Text.StringBuilder: insert (system-text-string-builder:insert)
"))

(cl:defgeneric normalized? (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: normalized? (system-string:normalized?)
"))

(cl:defgeneric last-index-of (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: last-index-of (system-string:last-index-of)
"))

(cl:defgeneric last-index-of-any (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: last-index-of-any (system-string:last-index-of-any)
"))

(cl:defgeneric normalize (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: normalize (system-string:normalize)
"))

(cl:defgeneric pad-left (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: pad-left (system-string:pad-left)
"))

(cl:defgeneric pad-right (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: pad-right (system-string:pad-right)
"))

(cl:defgeneric remove (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: remove (system-string:remove)
System.Text.StringBuilder: remove (system-text-string-builder:remove)
System.Collections.Generic.Dictionary`2: remove (system-collections-generic-dictionary-2:remove)
System.Collections.Generic.SortedList`2: remove (system-collections-generic-sorted-list-2:remove)
"))

(cl:defgeneric replace (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: replace (system-string:replace)
System.Text.StringBuilder: replace (system-text-string-builder:replace)
"))

(cl:defgeneric replace-line-endings (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: replace-line-endings (system-string:replace-line-endings)
"))

(cl:defgeneric split (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: split (system-string:split)
"))

(cl:defgeneric starts-with (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: starts-with (system-string:starts-with)
"))

(cl:defgeneric substring (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: substring (system-string:substring)
"))

(cl:defgeneric to-char-array (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: to-char-array (system-string:to-char-array)
"))

(cl:defgeneric to-lower (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: to-lower (system-string:to-lower)
"))

(cl:defgeneric to-lower-invariant (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: to-lower-invariant (system-string:to-lower-invariant)
"))

(cl:defgeneric to-upper (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: to-upper (system-string:to-upper)
"))

(cl:defgeneric to-upper-invariant (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: to-upper-invariant (system-string:to-upper-invariant)
"))

(cl:defgeneric trim (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: trim (system-string:trim)
"))

(cl:defgeneric trim-end (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: trim-end (system-string:trim-end)
"))

(cl:defgeneric trim-start (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: trim-start (system-string:trim-start)
"))

(cl:defgeneric try-copy-to (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: try-copy-to (system-string:try-copy-to)
System.Numerics.Vector3: try-copy-to (system-numerics-vector3:try-copy-to)
System.Numerics.Vector4: try-copy-to (system-numerics-vector4:try-copy-to)
"))

(cl:defgeneric fixed-size? (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Array: fixed-size? (system-array:fixed-size?)
"))

(cl:defgeneric read-only? (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Array: read-only? (system-array:read-only?)
"))

(cl:defgeneric synchronized? (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Array: synchronized? (system-array:synchronized?)
"))

(cl:defgeneric long-length (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Array: long-length (system-array:long-length)
"))

(cl:defgeneric rank (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Array: rank (system-array:rank)
"))

(cl:defgeneric sync-root (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Array: sync-root (system-array:sync-root)
"))

(cl:defgeneric get-length (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Array: get-length (system-array:get-length)
"))

(cl:defgeneric get-long-length (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Array: get-long-length (system-array:get-long-length)
"))

(cl:defgeneric get-lower-bound (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Array: get-lower-bound (system-array:get-lower-bound)
"))

(cl:defgeneric get-upper-bound (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Array: get-upper-bound (system-array:get-upper-bound)
"))

(cl:defgeneric get-value (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Array: get-value (system-array:get-value)
"))

(cl:defgeneric initialize (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Array: initialize (system-array:initialize)
"))

(cl:defgeneric set-value (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Array: set-value (system-array:set-value)
"))

(cl:defgeneric capacity (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: capacity (system-text-string-builder:capacity)
System.Collections.Generic.Dictionary`2: capacity (system-collections-generic-dictionary-2:capacity)
System.Collections.Generic.SortedList`2: capacity (system-collections-generic-sorted-list-2:capacity)
"))

(cl:defgeneric max-capacity (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: max-capacity (system-text-string-builder:max-capacity)
"))

(cl:defgeneric append (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: append (system-text-string-builder:append)
"))

(cl:defgeneric append-format (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: append-format (system-text-string-builder:append-format)
"))

(cl:defgeneric append-join (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: append-join (system-text-string-builder:append-join)
"))

(cl:defgeneric append-line (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: append-line (system-text-string-builder:append-line)
"))

(cl:defgeneric clear (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: clear (system-text-string-builder:clear)
System.Collections.Generic.Dictionary`2: clear (system-collections-generic-dictionary-2:clear)
System.Collections.Generic.SortedList`2: clear (system-collections-generic-sorted-list-2:clear)
"))

(cl:defgeneric ensure-capacity (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: ensure-capacity (system-text-string-builder:ensure-capacity)
System.Collections.Generic.Dictionary`2: ensure-capacity (system-collections-generic-dictionary-2:ensure-capacity)
"))

(cl:defgeneric get-chunks (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: get-chunks (system-text-string-builder:get-chunks)
"))

(cl:defgeneric comparer (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: comparer (system-collections-generic-dictionary-2:comparer)
System.Collections.Generic.SortedList`2: comparer (system-collections-generic-sorted-list-2:comparer)
"))

(cl:defgeneric count (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: count (system-collections-generic-dictionary-2:count)
System.Collections.Generic.SortedList`2: count (system-collections-generic-sorted-list-2:count)
"))

(cl:defgeneric item (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: item (system-collections-generic-dictionary-2:item)
System.Collections.Generic.SortedList`2: item (system-collections-generic-sorted-list-2:item)
System.Numerics.Vector3: item (system-numerics-vector3:item)
System.Numerics.Vector4: item (system-numerics-vector4:item)
"))

(cl:defgeneric keys (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: keys (system-collections-generic-dictionary-2:keys)
System.Collections.Generic.SortedList`2: keys (system-collections-generic-sorted-list-2:keys)
"))

(cl:defgeneric values (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: values (system-collections-generic-dictionary-2:values)
System.Collections.Generic.SortedList`2: values (system-collections-generic-sorted-list-2:values)
"))

(cl:defgeneric add (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: add (system-collections-generic-dictionary-2:add)
System.Collections.Generic.SortedList`2: add (system-collections-generic-sorted-list-2:add)
"))

(cl:defgeneric contains-key (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: contains-key (system-collections-generic-dictionary-2:contains-key)
System.Collections.Generic.SortedList`2: contains-key (system-collections-generic-sorted-list-2:contains-key)
"))

(cl:defgeneric contains-value (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: contains-value (system-collections-generic-dictionary-2:contains-value)
System.Collections.Generic.SortedList`2: contains-value (system-collections-generic-sorted-list-2:contains-value)
"))

(cl:defgeneric get-object-data (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: get-object-data (system-collections-generic-dictionary-2:get-object-data)
"))

(cl:defgeneric on-deserialization (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: on-deserialization (system-collections-generic-dictionary-2:on-deserialization)
"))

(cl:defgeneric trim-excess (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: trim-excess (system-collections-generic-dictionary-2:trim-excess)
System.Collections.Generic.SortedList`2: trim-excess (system-collections-generic-sorted-list-2:trim-excess)
"))

(cl:defgeneric try-add (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: try-add (system-collections-generic-dictionary-2:try-add)
"))

(cl:defgeneric get-key-at-index (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.SortedList`2: get-key-at-index (system-collections-generic-sorted-list-2:get-key-at-index)
"))

(cl:defgeneric get-value-at-index (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.SortedList`2: get-value-at-index (system-collections-generic-sorted-list-2:get-value-at-index)
"))

(cl:defgeneric index-of-key (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.SortedList`2: index-of-key (system-collections-generic-sorted-list-2:index-of-key)
"))

(cl:defgeneric index-of-value (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.SortedList`2: index-of-value (system-collections-generic-sorted-list-2:index-of-value)
"))

(cl:defgeneric remove-at (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.SortedList`2: remove-at (system-collections-generic-sorted-list-2:remove-at)
"))

(cl:defgeneric set-value-at-index (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.SortedList`2: set-value-at-index (system-collections-generic-sorted-list-2:set-value-at-index)
"))

(cl:defgeneric x (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: x (system-numerics-vector3:x)
System.Numerics.Vector4: x (system-numerics-vector4:x)
"))

(cl:defgeneric y (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: y (system-numerics-vector3:y)
System.Numerics.Vector4: y (system-numerics-vector4:y)
"))

(cl:defgeneric z (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: z (system-numerics-vector3:z)
System.Numerics.Vector4: z (system-numerics-vector4:z)
"))

(cl:defgeneric length-squared (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: length-squared (system-numerics-vector3:length-squared)
System.Numerics.Vector4: length-squared (system-numerics-vector4:length-squared)
"))

(cl:defgeneric as-vector2 (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: as-vector2 (system-numerics-vector3:as-vector2)
System.Numerics.Vector4: as-vector2 (system-numerics-vector4:as-vector2)
"))

(cl:defgeneric as-vector4 (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: as-vector4 (system-numerics-vector3:as-vector4)
"))

(cl:defgeneric as-vector4-unsafe (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: as-vector4-unsafe (system-numerics-vector3:as-vector4-unsafe)
"))

(cl:defgeneric extract-most-significant-bits (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: extract-most-significant-bits (system-numerics-vector3:extract-most-significant-bits)
System.Numerics.Vector4: extract-most-significant-bits (system-numerics-vector4:extract-most-significant-bits)
"))

(cl:defgeneric get-element (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: get-element (system-numerics-vector3:get-element)
System.Numerics.Vector4: get-element (system-numerics-vector4:get-element)
"))

(cl:defgeneric store (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: store (system-numerics-vector3:store)
System.Numerics.Vector4: store (system-numerics-vector4:store)
"))

(cl:defgeneric store-aligned (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: store-aligned (system-numerics-vector3:store-aligned)
System.Numerics.Vector4: store-aligned (system-numerics-vector4:store-aligned)
"))

(cl:defgeneric store-aligned-non-temporal (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: store-aligned-non-temporal (system-numerics-vector3:store-aligned-non-temporal)
System.Numerics.Vector4: store-aligned-non-temporal (system-numerics-vector4:store-aligned-non-temporal)
"))

(cl:defgeneric to-scalar (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: to-scalar (system-numerics-vector3:to-scalar)
System.Numerics.Vector4: to-scalar (system-numerics-vector4:to-scalar)
"))

(cl:defgeneric with-element (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: with-element (system-numerics-vector3:with-element)
System.Numerics.Vector4: with-element (system-numerics-vector4:with-element)
"))

(cl:defgeneric w (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector4: w (system-numerics-vector4:w)
"))

(cl:defgeneric as-plane (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector4: as-plane (system-numerics-vector4:as-plane)
"))

(cl:defgeneric as-quaternion (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector4: as-quaternion (system-numerics-vector4:as-quaternion)
"))

(cl:defgeneric as-vector3 (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector4: as-vector3 (system-numerics-vector4:as-vector3)
"))

(cl:defgeneric change (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Threading.Timer: change (system-threading-timer:change)
"))

(cl:defgeneric dispose (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Threading.Timer: dispose (system-threading-timer:dispose)
System.Timers.Timer: dispose (system-timers-timer:dispose)
"))

(cl:defgeneric dispose-async (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Threading.Timer: dispose-async (system-threading-timer:dispose-async)
"))

(cl:defgeneric auto-reset (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: auto-reset (system-timers-timer:auto-reset)
"))

(cl:defgeneric enabled (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: enabled (system-timers-timer:enabled)
"))

(cl:defgeneric interval (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: interval (system-timers-timer:interval)
"))

(cl:defgeneric site (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: site (system-timers-timer:site)
"))

(cl:defgeneric synchronizing-object (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: synchronizing-object (system-timers-timer:synchronizing-object)
"))

(cl:defgeneric begin-init (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: begin-init (system-timers-timer:begin-init)
"))

(cl:defgeneric close (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: close (system-timers-timer:close)
"))

(cl:defgeneric end-init (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: end-init (system-timers-timer:end-init)
"))

(cl:defgeneric start (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: start (system-timers-timer:start)
"))

(cl:defgeneric stop (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: stop (system-timers-timer:stop)
"))

(cl:defgeneric add-elapsed (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: add-elapsed (system-timers-timer:add-elapsed)
"))

(cl:defgeneric remove-elapsed (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: remove-elapsed (system-timers-timer:remove-elapsed)
"))

(cl:defgeneric (cl:setf capacity) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: (cl:setf capacity) (cl:setf (system-text-string-builder:capacity ...))
System.Collections.Generic.SortedList`2: (cl:setf capacity) (cl:setf (system-collections-generic-sorted-list-2:capacity ...))
"))

(cl:defgeneric (cl:setf chars) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: (cl:setf chars) (cl:setf (system-text-string-builder:chars ...))
"))

(cl:defgeneric (cl:setf length) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: (cl:setf length) (cl:setf (system-text-string-builder:length ...))
"))

(cl:defgeneric (cl:setf item) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: (cl:setf item) (cl:setf (system-collections-generic-dictionary-2:item ...))
System.Collections.Generic.SortedList`2: (cl:setf item) (cl:setf (system-collections-generic-sorted-list-2:item ...))
System.Numerics.Vector3: (cl:setf item) (cl:setf (system-numerics-vector3:item ...))
System.Numerics.Vector4: (cl:setf item) (cl:setf (system-numerics-vector4:item ...))
"))

(cl:defgeneric (cl:setf x) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: (cl:setf x) (cl:setf (system-numerics-vector3:x ...))
System.Numerics.Vector4: (cl:setf x) (cl:setf (system-numerics-vector4:x ...))
"))

(cl:defgeneric (cl:setf y) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: (cl:setf y) (cl:setf (system-numerics-vector3:y ...))
System.Numerics.Vector4: (cl:setf y) (cl:setf (system-numerics-vector4:y ...))
"))

(cl:defgeneric (cl:setf z) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector3: (cl:setf z) (cl:setf (system-numerics-vector3:z ...))
System.Numerics.Vector4: (cl:setf z) (cl:setf (system-numerics-vector4:z ...))
"))

(cl:defgeneric (cl:setf w) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector4: (cl:setf w) (cl:setf (system-numerics-vector4:w ...))
"))

(cl:defgeneric (cl:setf auto-reset) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: (cl:setf auto-reset) (cl:setf (system-timers-timer:auto-reset ...))
"))

(cl:defgeneric (cl:setf enabled) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: (cl:setf enabled) (cl:setf (system-timers-timer:enabled ...))
"))

(cl:defgeneric (cl:setf interval) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: (cl:setf interval) (cl:setf (system-timers-timer:interval ...))
"))

(cl:defgeneric (cl:setf site) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: (cl:setf site) (cl:setf (system-timers-timer:site ...))
"))

(cl:defgeneric (cl:setf synchronizing-object) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Timers.Timer: (cl:setf synchronizing-object) (cl:setf (system-timers-timer:synchronizing-object ...))
"))

;; System.Object (system-object)
(cl:defmethod equals ((obj! #.(dotnet:class-for-type "System.Object")) cl:&rest args)
  (cl:apply (cl:function system-object:equals) obj! args))
(cl:defmethod finalize ((obj! #.(dotnet:class-for-type "System.Object")) cl:&rest args)
  (cl:apply (cl:function system-object:finalize) obj! args))
(cl:defmethod get-hash-code ((obj! #.(dotnet:class-for-type "System.Object")) cl:&rest args)
  (cl:apply (cl:function system-object:get-hash-code) obj! args))
(cl:defmethod get-type ((obj! #.(dotnet:class-for-type "System.Object")) cl:&rest args)
  (cl:apply (cl:function system-object:get-type) obj! args))
(cl:defmethod memberwise-clone ((obj! #.(dotnet:class-for-type "System.Object")) cl:&rest args)
  (cl:apply (cl:function system-object:memberwise-clone) obj! args))
(cl:defmethod to-string ((obj! #.(dotnet:class-for-type "System.Object")) cl:&rest args)
  (cl:apply (cl:function system-object:to-string) obj! args))
(cl:defmethod dummy-extension ((obj! #.(dotnet:class-for-type "System.Object")) cl:&rest args)
  (cl:apply (cl:function system-object:dummy-extension) obj! args))

;; System.String (system-string)
(cl:defmethod chars ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:chars) obj! args))
(cl:defmethod length ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:length) obj! args))
(cl:defmethod clone ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:clone) obj! args))
(cl:defmethod compare-to ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:compare-to) obj! args))
(cl:defmethod contains ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:contains) obj! args))
(cl:defmethod copy-to ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:copy-to) obj! args))
(cl:defmethod ends-with ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:ends-with) obj! args))
(cl:defmethod enumerate-runes ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:enumerate-runes) obj! args))
(cl:defmethod equals ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:equals) obj! args))
(cl:defmethod get-enumerator ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:get-enumerator) obj! args))
(cl:defmethod get-hash-code ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:get-hash-code) obj! args))
(cl:defmethod get-pinnable-reference ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:get-pinnable-reference) obj! args))
(cl:defmethod get-type-code ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:get-type-code) obj! args))
(cl:defmethod index-of ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:index-of) obj! args))
(cl:defmethod index-of-any ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:index-of-any) obj! args))
(cl:defmethod insert ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:insert) obj! args))
(cl:defmethod normalized? ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:normalized?) obj! args))
(cl:defmethod last-index-of ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:last-index-of) obj! args))
(cl:defmethod last-index-of-any ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:last-index-of-any) obj! args))
(cl:defmethod normalize ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:normalize) obj! args))
(cl:defmethod pad-left ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:pad-left) obj! args))
(cl:defmethod pad-right ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:pad-right) obj! args))
(cl:defmethod remove ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:remove) obj! args))
(cl:defmethod replace ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:replace) obj! args))
(cl:defmethod replace-line-endings ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:replace-line-endings) obj! args))
(cl:defmethod split ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:split) obj! args))
(cl:defmethod starts-with ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:starts-with) obj! args))
(cl:defmethod substring ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:substring) obj! args))
(cl:defmethod to-char-array ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:to-char-array) obj! args))
(cl:defmethod to-lower ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:to-lower) obj! args))
(cl:defmethod to-lower-invariant ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:to-lower-invariant) obj! args))
(cl:defmethod to-string ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:to-string) obj! args))
(cl:defmethod to-upper ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:to-upper) obj! args))
(cl:defmethod to-upper-invariant ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:to-upper-invariant) obj! args))
(cl:defmethod trim ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:trim) obj! args))
(cl:defmethod trim-end ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:trim-end) obj! args))
(cl:defmethod trim-start ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:trim-start) obj! args))
(cl:defmethod try-copy-to ((obj! #.(dotnet:class-for-type "System.String")) cl:&rest args)
  (cl:apply (cl:function system-string:try-copy-to) obj! args))

;; System.Array (system-array)
(cl:defmethod fixed-size? ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:fixed-size?) obj! args))
(cl:defmethod read-only? ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:read-only?) obj! args))
(cl:defmethod synchronized? ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:synchronized?) obj! args))
(cl:defmethod length ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:length) obj! args))
(cl:defmethod long-length ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:long-length) obj! args))
(cl:defmethod rank ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:rank) obj! args))
(cl:defmethod sync-root ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:sync-root) obj! args))
(cl:defmethod clone ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:clone) obj! args))
(cl:defmethod copy-to ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:copy-to) obj! args))
(cl:defmethod get-enumerator ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:get-enumerator) obj! args))
(cl:defmethod get-length ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:get-length) obj! args))
(cl:defmethod get-long-length ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:get-long-length) obj! args))
(cl:defmethod get-lower-bound ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:get-lower-bound) obj! args))
(cl:defmethod get-upper-bound ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:get-upper-bound) obj! args))
(cl:defmethod get-value ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:get-value) obj! args))
(cl:defmethod initialize ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:initialize) obj! args))
(cl:defmethod set-value ((obj! #.(dotnet:class-for-type "System.Array")) cl:&rest args)
  (cl:apply (cl:function system-array:set-value) obj! args))

;; System.Text.StringBuilder (system-text-string-builder)
(cl:defmethod capacity ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:capacity) obj! args))
(cl:defmethod chars ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:chars) obj! args))
(cl:defmethod length ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:length) obj! args))
(cl:defmethod max-capacity ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:max-capacity) obj! args))
(cl:defmethod append ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:append) obj! args))
(cl:defmethod append-format ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:append-format) obj! args))
(cl:defmethod append-join ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:append-join) obj! args))
(cl:defmethod append-line ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:append-line) obj! args))
(cl:defmethod clear ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:clear) obj! args))
(cl:defmethod copy-to ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:copy-to) obj! args))
(cl:defmethod ensure-capacity ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:ensure-capacity) obj! args))
(cl:defmethod equals ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:equals) obj! args))
(cl:defmethod get-chunks ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:get-chunks) obj! args))
(cl:defmethod insert ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:insert) obj! args))
(cl:defmethod remove ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:remove) obj! args))
(cl:defmethod replace ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:replace) obj! args))
(cl:defmethod to-string ((obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:to-string) obj! args))
(cl:defmethod (cl:setf capacity) (new-value (obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-text-string-builder:capacity)) new-value obj! args))
(cl:defmethod (cl:setf chars) (new-value (obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-text-string-builder:chars)) new-value obj! args))
(cl:defmethod (cl:setf length) (new-value (obj! #.(dotnet:class-for-type "System.Text.StringBuilder")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-text-string-builder:length)) new-value obj! args))

;; System.Collections.Generic.Dictionary`2 (system-collections-generic-dictionary-2)
;; SKIPPED: System.Collections.Generic.Dictionary`2 is an open generic type definition -- DotCL cannot
;; dispatch a defmethod on it (its CLOS class is named from its own
;; type PARAMETERS, e.g. Dictionary<TKey,TValue>, which never matches
;; any real closed instance's registered name). See
;; doc/dispatch-on-open-generics.md.

;; System.Collections.Generic.SortedList`2 (system-collections-generic-sorted-list-2)
;; SKIPPED: System.Collections.Generic.SortedList`2 is an open generic type definition -- DotCL cannot
;; dispatch a defmethod on it (its CLOS class is named from its own
;; type PARAMETERS, e.g. Dictionary<TKey,TValue>, which never matches
;; any real closed instance's registered name). See
;; doc/dispatch-on-open-generics.md.

;; System.Numerics.Vector3 (system-numerics-vector3)
(cl:defmethod x ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:x) obj! args))
(cl:defmethod y ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:y) obj! args))
(cl:defmethod z ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:z) obj! args))
(cl:defmethod item ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:item) obj! args))
(cl:defmethod copy-to ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:copy-to) obj! args))
(cl:defmethod equals ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:equals) obj! args))
(cl:defmethod get-hash-code ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:get-hash-code) obj! args))
(cl:defmethod length ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:length) obj! args))
(cl:defmethod length-squared ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:length-squared) obj! args))
(cl:defmethod to-string ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:to-string) obj! args))
(cl:defmethod try-copy-to ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:try-copy-to) obj! args))
(cl:defmethod as-vector2 ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:as-vector2) obj! args))
(cl:defmethod as-vector4 ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:as-vector4) obj! args))
(cl:defmethod as-vector4-unsafe ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:as-vector4-unsafe) obj! args))
(cl:defmethod extract-most-significant-bits ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:extract-most-significant-bits) obj! args))
(cl:defmethod get-element ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:get-element) obj! args))
(cl:defmethod store ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:store) obj! args))
(cl:defmethod store-aligned ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:store-aligned) obj! args))
(cl:defmethod store-aligned-non-temporal ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:store-aligned-non-temporal) obj! args))
(cl:defmethod to-scalar ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:to-scalar) obj! args))
(cl:defmethod with-element ((obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector3:with-element) obj! args))
(cl:defmethod (cl:setf x) (new-value (obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-numerics-vector3:x)) new-value obj! args))
(cl:defmethod (cl:setf y) (new-value (obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-numerics-vector3:y)) new-value obj! args))
(cl:defmethod (cl:setf z) (new-value (obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-numerics-vector3:z)) new-value obj! args))
(cl:defmethod (cl:setf item) (new-value (obj! #.(dotnet:class-for-type "System.Numerics.Vector3")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-numerics-vector3:item)) new-value obj! args))

;; System.Numerics.Vector4 (system-numerics-vector4)
(cl:defmethod w ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:w) obj! args))
(cl:defmethod x ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:x) obj! args))
(cl:defmethod y ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:y) obj! args))
(cl:defmethod z ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:z) obj! args))
(cl:defmethod item ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:item) obj! args))
(cl:defmethod copy-to ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:copy-to) obj! args))
(cl:defmethod equals ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:equals) obj! args))
(cl:defmethod get-hash-code ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:get-hash-code) obj! args))
(cl:defmethod length ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:length) obj! args))
(cl:defmethod length-squared ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:length-squared) obj! args))
(cl:defmethod to-string ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:to-string) obj! args))
(cl:defmethod try-copy-to ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:try-copy-to) obj! args))
(cl:defmethod as-plane ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:as-plane) obj! args))
(cl:defmethod as-quaternion ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:as-quaternion) obj! args))
(cl:defmethod as-vector2 ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:as-vector2) obj! args))
(cl:defmethod as-vector3 ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:as-vector3) obj! args))
(cl:defmethod extract-most-significant-bits ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:extract-most-significant-bits) obj! args))
(cl:defmethod get-element ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:get-element) obj! args))
(cl:defmethod store ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:store) obj! args))
(cl:defmethod store-aligned ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:store-aligned) obj! args))
(cl:defmethod store-aligned-non-temporal ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:store-aligned-non-temporal) obj! args))
(cl:defmethod to-scalar ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:to-scalar) obj! args))
(cl:defmethod with-element ((obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function system-numerics-vector4:with-element) obj! args))
(cl:defmethod (cl:setf w) (new-value (obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-numerics-vector4:w)) new-value obj! args))
(cl:defmethod (cl:setf x) (new-value (obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-numerics-vector4:x)) new-value obj! args))
(cl:defmethod (cl:setf y) (new-value (obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-numerics-vector4:y)) new-value obj! args))
(cl:defmethod (cl:setf z) (new-value (obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-numerics-vector4:z)) new-value obj! args))
(cl:defmethod (cl:setf item) (new-value (obj! #.(dotnet:class-for-type "System.Numerics.Vector4")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-numerics-vector4:item)) new-value obj! args))

;; System.Threading.Timer (system-threading-timer)
;; Register C# Type with CLOS (--ensure-type-in-generic) --
;; :compile-toplevel is required here, unlike --ensure-type's own
;; per-class eval-when: #.(dotnet:class-for-type ...) below is
;; read-time-evaluated, i.e. already resolved at COMPILE time of
;; this file, so influencing same-simple-name collision order
;; relative to it requires running at compile time too. See
;; doc/generator-design-notes.md's Version 45 section.
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Threading.Timer")))

(cl:defmethod change ((obj! #.(dotnet:class-for-type "System.Threading.Timer")) cl:&rest args)
  (cl:apply (cl:function system-threading-timer:change) obj! args))
(cl:defmethod dispose ((obj! #.(dotnet:class-for-type "System.Threading.Timer")) cl:&rest args)
  (cl:apply (cl:function system-threading-timer:dispose) obj! args))
(cl:defmethod dispose-async ((obj! #.(dotnet:class-for-type "System.Threading.Timer")) cl:&rest args)
  (cl:apply (cl:function system-threading-timer:dispose-async) obj! args))

;; System.Timers.Timer (system-timers-timer)
(cl:defmethod auto-reset ((obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:auto-reset) obj! args))
(cl:defmethod enabled ((obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:enabled) obj! args))
(cl:defmethod interval ((obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:interval) obj! args))
(cl:defmethod site ((obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:site) obj! args))
(cl:defmethod synchronizing-object ((obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:synchronizing-object) obj! args))
(cl:defmethod begin-init ((obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:begin-init) obj! args))
(cl:defmethod close ((obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:close) obj! args))
(cl:defmethod dispose ((obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:dispose) obj! args))
(cl:defmethod end-init ((obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:end-init) obj! args))
(cl:defmethod start ((obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:start) obj! args))
(cl:defmethod stop ((obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:stop) obj! args))
(cl:defmethod add-elapsed ((obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:add-elapsed) obj! args))
(cl:defmethod remove-elapsed ((obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:remove-elapsed) obj! args))
(cl:defmethod (cl:setf auto-reset) (new-value (obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-timers-timer:auto-reset)) new-value obj! args))
(cl:defmethod (cl:setf enabled) (new-value (obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-timers-timer:enabled)) new-value obj! args))
(cl:defmethod (cl:setf interval) (new-value (obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-timers-timer:interval)) new-value obj! args))
(cl:defmethod (cl:setf site) (new-value (obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-timers-timer:site)) new-value obj! args))
(cl:defmethod (cl:setf synchronizing-object) (new-value (obj! #.(dotnet:class-for-type "System.Timers.Timer")) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-timers-timer:synchronizing-object)) new-value obj! args))

