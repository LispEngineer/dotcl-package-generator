;;; Generated automatically. Do not edit.
;;; Generator Version: 36
;;; Creation Date: 2026-07-05T18:30:04Z

(cl:in-package :csharp-generics-dynamic)

;;; Unified CLOS generic functions dispatching on C# runtime type.
;;; Each defmethod is installed at load time against each class's
;;; actual runtime CLOS class object -- see doc/make-everything-defgeneric-dynamic.md.

(cl:defgeneric equals (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Object: equals (system-object:equals)
System.String: equals (system-string:equals)
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
System.Numerics.Vector3: to-string (system-numerics-vector3:to-string)
System.Numerics.Vector4: to-string (system-numerics-vector4:to-string)
"))

(cl:defgeneric chars (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: chars (system-string:chars)
"))

(cl:defgeneric length (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: length (system-string:length)
System.Array: length (system-array:length)
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
System.Collections.Generic.Dictionary`2: remove (system-collections-generic-dictionary-2:remove)
System.Collections.Generic.SortedList`2: remove (system-collections-generic-sorted-list-2:remove)
"))

(cl:defgeneric replace (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: replace (system-string:replace)
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
System.Collections.Generic.Dictionary`2: capacity (system-collections-generic-dictionary-2:capacity)
System.Collections.Generic.SortedList`2: capacity (system-collections-generic-sorted-list-2:capacity)
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

(cl:defgeneric clear (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: clear (system-collections-generic-dictionary-2:clear)
System.Collections.Generic.SortedList`2: clear (system-collections-generic-sorted-list-2:clear)
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

(cl:defgeneric ensure-capacity (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: ensure-capacity (system-collections-generic-dictionary-2:ensure-capacity)
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

(cl:defgeneric w (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Numerics.Vector4: w (system-numerics-vector4:w)
"))

(cl:defgeneric (cl:setf item) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.Dictionary`2: (cl:setf item) (cl:setf (system-collections-generic-dictionary-2:item ...))
System.Collections.Generic.SortedList`2: (cl:setf item) (cl:setf (system-collections-generic-sorted-list-2:item ...))
System.Numerics.Vector3: (cl:setf item) (cl:setf (system-numerics-vector3:item ...))
System.Numerics.Vector4: (cl:setf item) (cl:setf (system-numerics-vector4:item ...))
"))

(cl:defgeneric (cl:setf capacity) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Collections.Generic.SortedList`2: (cl:setf capacity) (cl:setf (system-collections-generic-sorted-list-2:capacity ...))
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

;; System.Object (system-object)
(cl:eval-when (:load-toplevel :execute)
  (cl:let* ((cls (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                  (dotnet:resolve-type "System.Object")))
            (spec (cl:class-name cls)))
    (cl:eval `(cl:defmethod equals ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-object:equals) obj! args)))
    (cl:eval `(cl:defmethod finalize ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-object:finalize) obj! args)))
    (cl:eval `(cl:defmethod get-hash-code ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-object:get-hash-code) obj! args)))
    (cl:eval `(cl:defmethod get-type ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-object:get-type) obj! args)))
    (cl:eval `(cl:defmethod memberwise-clone ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-object:memberwise-clone) obj! args)))
    (cl:eval `(cl:defmethod to-string ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-object:to-string) obj! args)))
    ))

;; System.String (system-string)
(cl:eval-when (:load-toplevel :execute)
  (cl:let* ((cls (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                  (dotnet:resolve-type "System.String")))
            (spec (cl:class-name cls)))
    (cl:eval `(cl:defmethod chars ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:chars) obj! args)))
    (cl:eval `(cl:defmethod length ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:length) obj! args)))
    (cl:eval `(cl:defmethod clone ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:clone) obj! args)))
    (cl:eval `(cl:defmethod compare-to ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:compare-to) obj! args)))
    (cl:eval `(cl:defmethod contains ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:contains) obj! args)))
    (cl:eval `(cl:defmethod copy-to ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:copy-to) obj! args)))
    (cl:eval `(cl:defmethod ends-with ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:ends-with) obj! args)))
    (cl:eval `(cl:defmethod enumerate-runes ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:enumerate-runes) obj! args)))
    (cl:eval `(cl:defmethod equals ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:equals) obj! args)))
    (cl:eval `(cl:defmethod get-enumerator ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:get-enumerator) obj! args)))
    (cl:eval `(cl:defmethod get-hash-code ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:get-hash-code) obj! args)))
    (cl:eval `(cl:defmethod get-pinnable-reference ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:get-pinnable-reference) obj! args)))
    (cl:eval `(cl:defmethod get-type-code ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:get-type-code) obj! args)))
    (cl:eval `(cl:defmethod index-of ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:index-of) obj! args)))
    (cl:eval `(cl:defmethod index-of-any ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:index-of-any) obj! args)))
    (cl:eval `(cl:defmethod insert ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:insert) obj! args)))
    (cl:eval `(cl:defmethod normalized? ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:normalized?) obj! args)))
    (cl:eval `(cl:defmethod last-index-of ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:last-index-of) obj! args)))
    (cl:eval `(cl:defmethod last-index-of-any ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:last-index-of-any) obj! args)))
    (cl:eval `(cl:defmethod normalize ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:normalize) obj! args)))
    (cl:eval `(cl:defmethod pad-left ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:pad-left) obj! args)))
    (cl:eval `(cl:defmethod pad-right ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:pad-right) obj! args)))
    (cl:eval `(cl:defmethod remove ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:remove) obj! args)))
    (cl:eval `(cl:defmethod replace ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:replace) obj! args)))
    (cl:eval `(cl:defmethod replace-line-endings ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:replace-line-endings) obj! args)))
    (cl:eval `(cl:defmethod split ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:split) obj! args)))
    (cl:eval `(cl:defmethod starts-with ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:starts-with) obj! args)))
    (cl:eval `(cl:defmethod substring ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:substring) obj! args)))
    (cl:eval `(cl:defmethod to-char-array ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:to-char-array) obj! args)))
    (cl:eval `(cl:defmethod to-lower ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:to-lower) obj! args)))
    (cl:eval `(cl:defmethod to-lower-invariant ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:to-lower-invariant) obj! args)))
    (cl:eval `(cl:defmethod to-string ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:to-string) obj! args)))
    (cl:eval `(cl:defmethod to-upper ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:to-upper) obj! args)))
    (cl:eval `(cl:defmethod to-upper-invariant ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:to-upper-invariant) obj! args)))
    (cl:eval `(cl:defmethod trim ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:trim) obj! args)))
    (cl:eval `(cl:defmethod trim-end ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:trim-end) obj! args)))
    (cl:eval `(cl:defmethod trim-start ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:trim-start) obj! args)))
    (cl:eval `(cl:defmethod try-copy-to ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-string:try-copy-to) obj! args)))
    ))

;; System.Array (system-array)
(cl:eval-when (:load-toplevel :execute)
  (cl:let* ((cls (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                  (dotnet:resolve-type "System.Array")))
            (spec (cl:class-name cls)))
    (cl:eval `(cl:defmethod fixed-size? ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:fixed-size?) obj! args)))
    (cl:eval `(cl:defmethod read-only? ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:read-only?) obj! args)))
    (cl:eval `(cl:defmethod synchronized? ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:synchronized?) obj! args)))
    (cl:eval `(cl:defmethod length ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:length) obj! args)))
    (cl:eval `(cl:defmethod long-length ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:long-length) obj! args)))
    (cl:eval `(cl:defmethod rank ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:rank) obj! args)))
    (cl:eval `(cl:defmethod sync-root ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:sync-root) obj! args)))
    (cl:eval `(cl:defmethod clone ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:clone) obj! args)))
    (cl:eval `(cl:defmethod copy-to ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:copy-to) obj! args)))
    (cl:eval `(cl:defmethod get-enumerator ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:get-enumerator) obj! args)))
    (cl:eval `(cl:defmethod get-length ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:get-length) obj! args)))
    (cl:eval `(cl:defmethod get-long-length ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:get-long-length) obj! args)))
    (cl:eval `(cl:defmethod get-lower-bound ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:get-lower-bound) obj! args)))
    (cl:eval `(cl:defmethod get-upper-bound ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:get-upper-bound) obj! args)))
    (cl:eval `(cl:defmethod get-value ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:get-value) obj! args)))
    (cl:eval `(cl:defmethod initialize ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:initialize) obj! args)))
    (cl:eval `(cl:defmethod set-value ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-array:set-value) obj! args)))
    ))

;; System.Collections.Generic.Dictionary`2 (system-collections-generic-dictionary-2)
(cl:eval-when (:load-toplevel :execute)
  (cl:let* ((cls (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                  (dotnet:resolve-type "System.Collections.Generic.Dictionary`2")))
            (spec (cl:class-name cls)))
    (cl:eval `(cl:defmethod capacity ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:capacity) obj! args)))
    (cl:eval `(cl:defmethod comparer ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:comparer) obj! args)))
    (cl:eval `(cl:defmethod count ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:count) obj! args)))
    (cl:eval `(cl:defmethod item ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:item) obj! args)))
    (cl:eval `(cl:defmethod keys ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:keys) obj! args)))
    (cl:eval `(cl:defmethod values ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:values) obj! args)))
    (cl:eval `(cl:defmethod add ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:add) obj! args)))
    (cl:eval `(cl:defmethod clear ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:clear) obj! args)))
    (cl:eval `(cl:defmethod contains-key ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:contains-key) obj! args)))
    (cl:eval `(cl:defmethod contains-value ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:contains-value) obj! args)))
    (cl:eval `(cl:defmethod ensure-capacity ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:ensure-capacity) obj! args)))
    (cl:eval `(cl:defmethod get-enumerator ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:get-enumerator) obj! args)))
    (cl:eval `(cl:defmethod get-object-data ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:get-object-data) obj! args)))
    (cl:eval `(cl:defmethod on-deserialization ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:on-deserialization) obj! args)))
    (cl:eval `(cl:defmethod remove ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:remove) obj! args)))
    (cl:eval `(cl:defmethod trim-excess ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:trim-excess) obj! args)))
    (cl:eval `(cl:defmethod try-add ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-dictionary-2:try-add) obj! args)))
    (cl:eval `(cl:defmethod (cl:setf item) (new-value (obj! ,spec) cl:&rest args)
                (cl:apply (cl:function (cl:setf system-collections-generic-dictionary-2:item)) new-value obj! args)))
    ))

;; System.Collections.Generic.SortedList`2 (system-collections-generic-sorted-list-2)
(cl:eval-when (:load-toplevel :execute)
  (cl:let* ((cls (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                  (dotnet:resolve-type "System.Collections.Generic.SortedList`2")))
            (spec (cl:class-name cls)))
    (cl:eval `(cl:defmethod capacity ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:capacity) obj! args)))
    (cl:eval `(cl:defmethod comparer ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:comparer) obj! args)))
    (cl:eval `(cl:defmethod count ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:count) obj! args)))
    (cl:eval `(cl:defmethod item ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:item) obj! args)))
    (cl:eval `(cl:defmethod keys ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:keys) obj! args)))
    (cl:eval `(cl:defmethod values ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:values) obj! args)))
    (cl:eval `(cl:defmethod add ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:add) obj! args)))
    (cl:eval `(cl:defmethod clear ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:clear) obj! args)))
    (cl:eval `(cl:defmethod contains-key ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:contains-key) obj! args)))
    (cl:eval `(cl:defmethod contains-value ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:contains-value) obj! args)))
    (cl:eval `(cl:defmethod get-enumerator ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:get-enumerator) obj! args)))
    (cl:eval `(cl:defmethod get-key-at-index ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:get-key-at-index) obj! args)))
    (cl:eval `(cl:defmethod get-value-at-index ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:get-value-at-index) obj! args)))
    (cl:eval `(cl:defmethod index-of-key ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:index-of-key) obj! args)))
    (cl:eval `(cl:defmethod index-of-value ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:index-of-value) obj! args)))
    (cl:eval `(cl:defmethod remove ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:remove) obj! args)))
    (cl:eval `(cl:defmethod remove-at ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:remove-at) obj! args)))
    (cl:eval `(cl:defmethod set-value-at-index ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:set-value-at-index) obj! args)))
    (cl:eval `(cl:defmethod trim-excess ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-collections-generic-sorted-list-2:trim-excess) obj! args)))
    (cl:eval `(cl:defmethod (cl:setf capacity) (new-value (obj! ,spec) cl:&rest args)
                (cl:apply (cl:function (cl:setf system-collections-generic-sorted-list-2:capacity)) new-value obj! args)))
    (cl:eval `(cl:defmethod (cl:setf item) (new-value (obj! ,spec) cl:&rest args)
                (cl:apply (cl:function (cl:setf system-collections-generic-sorted-list-2:item)) new-value obj! args)))
    ))

;; System.Numerics.Vector3 (system-numerics-vector3)
(cl:eval-when (:load-toplevel :execute)
  (cl:let* ((cls (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                  (dotnet:resolve-type "System.Numerics.Vector3")))
            (spec (cl:class-name cls)))
    (cl:eval `(cl:defmethod x ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector3:x) obj! args)))
    (cl:eval `(cl:defmethod y ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector3:y) obj! args)))
    (cl:eval `(cl:defmethod z ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector3:z) obj! args)))
    (cl:eval `(cl:defmethod item ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector3:item) obj! args)))
    (cl:eval `(cl:defmethod copy-to ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector3:copy-to) obj! args)))
    (cl:eval `(cl:defmethod equals ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector3:equals) obj! args)))
    (cl:eval `(cl:defmethod get-hash-code ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector3:get-hash-code) obj! args)))
    (cl:eval `(cl:defmethod length ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector3:length) obj! args)))
    (cl:eval `(cl:defmethod length-squared ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector3:length-squared) obj! args)))
    (cl:eval `(cl:defmethod to-string ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector3:to-string) obj! args)))
    (cl:eval `(cl:defmethod try-copy-to ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector3:try-copy-to) obj! args)))
    (cl:eval `(cl:defmethod (cl:setf x) (new-value (obj! ,spec) cl:&rest args)
                (cl:apply (cl:function (cl:setf system-numerics-vector3:x)) new-value obj! args)))
    (cl:eval `(cl:defmethod (cl:setf y) (new-value (obj! ,spec) cl:&rest args)
                (cl:apply (cl:function (cl:setf system-numerics-vector3:y)) new-value obj! args)))
    (cl:eval `(cl:defmethod (cl:setf z) (new-value (obj! ,spec) cl:&rest args)
                (cl:apply (cl:function (cl:setf system-numerics-vector3:z)) new-value obj! args)))
    (cl:eval `(cl:defmethod (cl:setf item) (new-value (obj! ,spec) cl:&rest args)
                (cl:apply (cl:function (cl:setf system-numerics-vector3:item)) new-value obj! args)))
    ))

;; System.Numerics.Vector4 (system-numerics-vector4)
(cl:eval-when (:load-toplevel :execute)
  (cl:let* ((cls (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                  (dotnet:resolve-type "System.Numerics.Vector4")))
            (spec (cl:class-name cls)))
    (cl:eval `(cl:defmethod w ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector4:w) obj! args)))
    (cl:eval `(cl:defmethod x ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector4:x) obj! args)))
    (cl:eval `(cl:defmethod y ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector4:y) obj! args)))
    (cl:eval `(cl:defmethod z ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector4:z) obj! args)))
    (cl:eval `(cl:defmethod item ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector4:item) obj! args)))
    (cl:eval `(cl:defmethod copy-to ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector4:copy-to) obj! args)))
    (cl:eval `(cl:defmethod equals ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector4:equals) obj! args)))
    (cl:eval `(cl:defmethod get-hash-code ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector4:get-hash-code) obj! args)))
    (cl:eval `(cl:defmethod length ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector4:length) obj! args)))
    (cl:eval `(cl:defmethod length-squared ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector4:length-squared) obj! args)))
    (cl:eval `(cl:defmethod to-string ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector4:to-string) obj! args)))
    (cl:eval `(cl:defmethod try-copy-to ((obj! ,spec) cl:&rest args)
                (cl:apply (cl:function system-numerics-vector4:try-copy-to) obj! args)))
    (cl:eval `(cl:defmethod (cl:setf w) (new-value (obj! ,spec) cl:&rest args)
                (cl:apply (cl:function (cl:setf system-numerics-vector4:w)) new-value obj! args)))
    (cl:eval `(cl:defmethod (cl:setf x) (new-value (obj! ,spec) cl:&rest args)
                (cl:apply (cl:function (cl:setf system-numerics-vector4:x)) new-value obj! args)))
    (cl:eval `(cl:defmethod (cl:setf y) (new-value (obj! ,spec) cl:&rest args)
                (cl:apply (cl:function (cl:setf system-numerics-vector4:y)) new-value obj! args)))
    (cl:eval `(cl:defmethod (cl:setf z) (new-value (obj! ,spec) cl:&rest args)
                (cl:apply (cl:function (cl:setf system-numerics-vector4:z)) new-value obj! args)))
    (cl:eval `(cl:defmethod (cl:setf item) (new-value (obj! ,spec) cl:&rest args)
                (cl:apply (cl:function (cl:setf system-numerics-vector4:item)) new-value obj! args)))
    ))

