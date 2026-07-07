;;; Generated automatically. Do not edit.
;;; Generator Version: 40
;;; Creation Date: 2026-07-07T01:02:29Z

(cl:in-package :csharp-generics)

;;; Unified CLOS generic functions dispatching on C# runtime type.
;;; Each defmethod below specializes on a literal simple-name symbol
;;; computed at generation time -- see doc/make-everything-defgeneric.md's
;;; "Static specializer collision caveat" before relying on this with
;;; two same-simple-name classes in one batch.

(cl:defgeneric chars (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: chars (system-string:chars)
System.Text.StringBuilder: chars (system-text-string-builder:chars)
"))

(cl:defgeneric length (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: length (system-string:length)
System.Text.StringBuilder: length (system-text-string-builder:length)
"))

(cl:defgeneric clone (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: clone (system-string:clone)
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
System.Text.StringBuilder: copy-to (system-text-string-builder:copy-to)
"))

(cl:defgeneric ends-with (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: ends-with (system-string:ends-with)
"))

(cl:defgeneric enumerate-runes (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: enumerate-runes (system-string:enumerate-runes)
"))

(cl:defgeneric equals (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: equals (system-string:equals)
System.Text.StringBuilder: equals (system-text-string-builder:equals)
"))

(cl:defgeneric get-enumerator (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: get-enumerator (system-string:get-enumerator)
"))

(cl:defgeneric get-hash-code (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: get-hash-code (system-string:get-hash-code)
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

(cl:defgeneric to-string (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.String: to-string (system-string:to-string)
System.Text.StringBuilder: to-string (system-text-string-builder:to-string)
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
"))

(cl:defgeneric capacity (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: capacity (system-text-string-builder:capacity)
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
"))

(cl:defgeneric ensure-capacity (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: ensure-capacity (system-text-string-builder:ensure-capacity)
"))

(cl:defgeneric get-chunks (obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: get-chunks (system-text-string-builder:get-chunks)
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
"))

(cl:defgeneric (cl:setf chars) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: (cl:setf chars) (cl:setf (system-text-string-builder:chars ...))
"))

(cl:defgeneric (cl:setf length) (new-value obj! cl:&rest args)
  (:documentation "Dispatches on the C# runtime type of OBJ!. Specialized by:
System.Text.StringBuilder: (cl:setf length) (cl:setf (system-text-string-builder:length ...))
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

;; System.String (system-string)
;; NOTE: specializes on the simple-name CLOS class dotcl-internal::|String|.
;; No known simple-name conflicts: no other type reflected across the
;; provided assemblies reduces to this same simple name.
;; See doc/make-everything-defgeneric.md's "Static specializer collision
;; caveat" for the full mechanism and a worked example.
(cl:defmethod chars ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:chars) obj! args))
(cl:defmethod length ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:length) obj! args))
(cl:defmethod clone ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:clone) obj! args))
(cl:defmethod compare-to ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:compare-to) obj! args))
(cl:defmethod contains ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:contains) obj! args))
(cl:defmethod copy-to ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:copy-to) obj! args))
(cl:defmethod ends-with ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:ends-with) obj! args))
(cl:defmethod enumerate-runes ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:enumerate-runes) obj! args))
(cl:defmethod equals ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:equals) obj! args))
(cl:defmethod get-enumerator ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:get-enumerator) obj! args))
(cl:defmethod get-hash-code ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:get-hash-code) obj! args))
(cl:defmethod get-pinnable-reference ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:get-pinnable-reference) obj! args))
(cl:defmethod get-type-code ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:get-type-code) obj! args))
(cl:defmethod index-of ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:index-of) obj! args))
(cl:defmethod index-of-any ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:index-of-any) obj! args))
(cl:defmethod insert ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:insert) obj! args))
(cl:defmethod normalized? ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:normalized?) obj! args))
(cl:defmethod last-index-of ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:last-index-of) obj! args))
(cl:defmethod last-index-of-any ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:last-index-of-any) obj! args))
(cl:defmethod normalize ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:normalize) obj! args))
(cl:defmethod pad-left ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:pad-left) obj! args))
(cl:defmethod pad-right ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:pad-right) obj! args))
(cl:defmethod remove ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:remove) obj! args))
(cl:defmethod replace ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:replace) obj! args))
(cl:defmethod replace-line-endings ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:replace-line-endings) obj! args))
(cl:defmethod split ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:split) obj! args))
(cl:defmethod starts-with ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:starts-with) obj! args))
(cl:defmethod substring ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:substring) obj! args))
(cl:defmethod to-char-array ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:to-char-array) obj! args))
(cl:defmethod to-lower ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:to-lower) obj! args))
(cl:defmethod to-lower-invariant ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:to-lower-invariant) obj! args))
(cl:defmethod to-string ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:to-string) obj! args))
(cl:defmethod to-upper ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:to-upper) obj! args))
(cl:defmethod to-upper-invariant ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:to-upper-invariant) obj! args))
(cl:defmethod trim ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:trim) obj! args))
(cl:defmethod trim-end ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:trim-end) obj! args))
(cl:defmethod trim-start ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:trim-start) obj! args))
(cl:defmethod try-copy-to ((obj! dotcl-internal::|String|) cl:&rest args)
  (cl:apply (cl:function system-string:try-copy-to) obj! args))

;; System.Text.StringBuilder (system-text-string-builder)
;; NOTE: specializes on the simple-name CLOS class dotcl-internal::|StringBuilder|.
;; No known simple-name conflicts: no other type reflected across the
;; provided assemblies reduces to this same simple name.
;; See doc/make-everything-defgeneric.md's "Static specializer collision
;; caveat" for the full mechanism and a worked example.
(cl:defmethod capacity ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:capacity) obj! args))
(cl:defmethod chars ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:chars) obj! args))
(cl:defmethod length ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:length) obj! args))
(cl:defmethod max-capacity ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:max-capacity) obj! args))
(cl:defmethod append ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:append) obj! args))
(cl:defmethod append-format ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:append-format) obj! args))
(cl:defmethod append-join ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:append-join) obj! args))
(cl:defmethod append-line ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:append-line) obj! args))
(cl:defmethod clear ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:clear) obj! args))
(cl:defmethod copy-to ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:copy-to) obj! args))
(cl:defmethod ensure-capacity ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:ensure-capacity) obj! args))
(cl:defmethod equals ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:equals) obj! args))
(cl:defmethod get-chunks ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:get-chunks) obj! args))
(cl:defmethod insert ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:insert) obj! args))
(cl:defmethod remove ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:remove) obj! args))
(cl:defmethod replace ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:replace) obj! args))
(cl:defmethod to-string ((obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function system-text-string-builder:to-string) obj! args))
(cl:defmethod (cl:setf capacity) (new-value (obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-text-string-builder:capacity)) new-value obj! args))
(cl:defmethod (cl:setf chars) (new-value (obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-text-string-builder:chars)) new-value obj! args))
(cl:defmethod (cl:setf length) (new-value (obj! dotcl-internal::|StringBuilder|) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-text-string-builder:length)) new-value obj! args))

;; System.Threading.Timer (system-threading-timer)
;; NOTE: specializes on the simple-name CLOS class dotcl-internal::|Timer|.
;; Known simple-name conflict(s) among the types visible to the package
;; generator (ACTUAL = also generated in this batch, so DotCL's
;; simple-name/FullName naming race is guaranteed to happen; POSSIBLE =
;; merely seen in the provided assemblies' metadata, not generated here):
;;   ACTUAL: System.Timers.Timer
;; See doc/make-everything-defgeneric.md's "Static specializer collision
;; caveat" for the full mechanism and a worked example.
(cl:defmethod change ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-threading-timer:change) obj! args))
(cl:defmethod dispose ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-threading-timer:dispose) obj! args))
(cl:defmethod dispose-async ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-threading-timer:dispose-async) obj! args))

;; System.Timers.Timer (system-timers-timer)
;; NOTE: specializes on the simple-name CLOS class dotcl-internal::|Timer|.
;; Known simple-name conflict(s) among the types visible to the package
;; generator (ACTUAL = also generated in this batch, so DotCL's
;; simple-name/FullName naming race is guaranteed to happen; POSSIBLE =
;; merely seen in the provided assemblies' metadata, not generated here):
;;   ACTUAL: System.Threading.Timer
;; See doc/make-everything-defgeneric.md's "Static specializer collision
;; caveat" for the full mechanism and a worked example.
(cl:defmethod auto-reset ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:auto-reset) obj! args))
(cl:defmethod enabled ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:enabled) obj! args))
(cl:defmethod interval ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:interval) obj! args))
(cl:defmethod site ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:site) obj! args))
(cl:defmethod synchronizing-object ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:synchronizing-object) obj! args))
(cl:defmethod begin-init ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:begin-init) obj! args))
(cl:defmethod close ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:close) obj! args))
(cl:defmethod dispose ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:dispose) obj! args))
(cl:defmethod end-init ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:end-init) obj! args))
(cl:defmethod start ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:start) obj! args))
(cl:defmethod stop ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:stop) obj! args))
(cl:defmethod add-elapsed ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:add-elapsed) obj! args))
(cl:defmethod remove-elapsed ((obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function system-timers-timer:remove-elapsed) obj! args))
(cl:defmethod (cl:setf auto-reset) (new-value (obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-timers-timer:auto-reset)) new-value obj! args))
(cl:defmethod (cl:setf enabled) (new-value (obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-timers-timer:enabled)) new-value obj! args))
(cl:defmethod (cl:setf interval) (new-value (obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-timers-timer:interval)) new-value obj! args))
(cl:defmethod (cl:setf site) (new-value (obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-timers-timer:site)) new-value obj! args))
(cl:defmethod (cl:setf synchronizing-object) (new-value (obj! dotcl-internal::|Timer|) cl:&rest args)
  (cl:apply (cl:function (cl:setf system-timers-timer:synchronizing-object)) new-value obj! args))

