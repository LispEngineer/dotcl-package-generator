;;; Generated automatically. Do not edit.
;;; Generator Version: 38
;;; Creation Date: 2026-07-06T00:35:02Z

(cl:in-package :cl-user)

;;; Source File: csharp-assembly-utils.lisp
;;; Purpose: shared runtime support for generated packages
;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package definition for the CSHARP-ASSEMBLY-UTILS package: shared runtime
;;; support that every batch of dotcl-packagegen-generated C# class packages
;;; depends on. Copied verbatim (see GENERATE-BATCH-PACKAGES-FILE in
;;; assembly-package-generator.lisp) into every generated packages.lisp,
;;; ahead of the per-class defpackage forms. Standalone-loadable on its own.

(cl:defpackage :csharp-assembly-utils
  (:use :cl)
  (:export #:csharp-overload-not-found
           #:csharp-overload-package-name
           #:csharp-overload-class-name
           #:csharp-overload-method-name
           #:csharp-overload-supplied-args))

;;; Source File: csharp-generics.lisp
;;; Purpose: unified CLOS generic functions dispatching on C# runtime
;;; type, across every --defgeneric-opted-in class in this batch
;;; (see doc/make-everything-defgeneric.md)
(cl:defpackage :csharp-generics
  (:use :cl)
  (:shadow
   #:length
   #:remove
   #:replace
   #:append
   #:close
  )
  (:export
   #:chars
   #:length
   #:clone
   #:compare-to
   #:contains
   #:copy-to
   #:ends-with
   #:enumerate-runes
   #:equals
   #:get-enumerator
   #:get-hash-code
   #:get-pinnable-reference
   #:get-type-code
   #:index-of
   #:index-of-any
   #:insert
   #:normalized?
   #:last-index-of
   #:last-index-of-any
   #:normalize
   #:pad-left
   #:pad-right
   #:remove
   #:replace
   #:replace-line-endings
   #:split
   #:starts-with
   #:substring
   #:to-char-array
   #:to-lower
   #:to-lower-invariant
   #:to-string
   #:to-upper
   #:to-upper-invariant
   #:trim
   #:trim-end
   #:trim-start
   #:try-copy-to
   #:capacity
   #:max-capacity
   #:append
   #:append-format
   #:append-join
   #:append-line
   #:clear
   #:ensure-capacity
   #:get-chunks
   #:change
   #:dispose
   #:dispose-async
   #:auto-reset
   #:enabled
   #:interval
   #:site
   #:synchronizing-object
   #:begin-init
   #:close
   #:end-init
   #:start
   #:stop
   #:add-elapsed
   #:remove-elapsed
  ))

;;; Source File: csharp-generics-dynamic.lisp
;;; Purpose: unified CLOS generic functions dispatching on C# runtime
;;; type, across every --defgeneric-dynamic-opted-in class in this batch
;;; (see doc/make-everything-defgeneric-dynamic.md)
(cl:defpackage :csharp-generics-dynamic
  (:use :cl)
  (:shadow
   #:length
   #:remove
   #:replace
   #:count
   #:values
  )
  (:export
   #:equals
   #:finalize
   #:get-hash-code
   #:get-type
   #:memberwise-clone
   #:to-string
   #:dummy-extension
   #:chars
   #:length
   #:clone
   #:compare-to
   #:contains
   #:copy-to
   #:ends-with
   #:enumerate-runes
   #:get-enumerator
   #:get-pinnable-reference
   #:get-type-code
   #:index-of
   #:index-of-any
   #:insert
   #:normalized?
   #:last-index-of
   #:last-index-of-any
   #:normalize
   #:pad-left
   #:pad-right
   #:remove
   #:replace
   #:replace-line-endings
   #:split
   #:starts-with
   #:substring
   #:to-char-array
   #:to-lower
   #:to-lower-invariant
   #:to-upper
   #:to-upper-invariant
   #:trim
   #:trim-end
   #:trim-start
   #:try-copy-to
   #:fixed-size?
   #:read-only?
   #:synchronized?
   #:long-length
   #:rank
   #:sync-root
   #:get-length
   #:get-long-length
   #:get-lower-bound
   #:get-upper-bound
   #:get-value
   #:initialize
   #:set-value
   #:capacity
   #:comparer
   #:count
   #:item
   #:keys
   #:values
   #:add
   #:clear
   #:contains-key
   #:contains-value
   #:ensure-capacity
   #:get-object-data
   #:on-deserialization
   #:trim-excess
   #:try-add
   #:get-key-at-index
   #:get-value-at-index
   #:index-of-key
   #:index-of-value
   #:remove-at
   #:set-value-at-index
   #:x
   #:y
   #:z
   #:length-squared
   #:as-vector2
   #:as-vector4
   #:as-vector4-unsafe
   #:extract-most-significant-bits
   #:get-element
   #:store
   #:store-aligned
   #:store-aligned-non-temporal
   #:to-scalar
   #:with-element
   #:w
   #:as-plane
   #:as-quaternion
   #:as-vector3
  ))

;;; Source File: system-console.lisp
;;; C# Class: System.Console
;;; Constant Properties: (none)
(cl:defpackage :system-console
  (:use :cl)
  (:shadow
   #:error
   #:read
   #:read-line
   #:write
   #:write-line
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:caps-lock
   #:error
   #:in
   #:error-redirected?
   #:input-redirected?
   #:output-redirected?
   #:key-available
   #:largest-window-height
   #:largest-window-width
   #:number-lock
   #:out
   #:background-color
   #:buffer-height
   #:buffer-width
   #:cursor-left
   #:cursor-size
   #:cursor-top
   #:cursor-visible
   #:foreground-color
   #:input-encoding
   #:output-encoding
   #:title
   #:treat-control-c-as-input
   #:window-height
   #:window-left
   #:window-top
   #:window-width
   #:beep
   #:clear
   #:get-cursor-position
   #:move-buffer-area
   #:open-standard-error
   #:open-standard-input
   #:open-standard-output
   #:read
   #:read-key
   #:read-line
   #:reset-color
   #:set-buffer-size
   #:set-cursor-position
   #:set-error
   #:set-in
   #:set-out
   #:set-window-position
   #:set-window-size
   #:write
   #:write-line
  ))

;;; Source File: system-time-span.lisp
;;; C# Class: System.TimeSpan
;;; Constant Properties: *
(cl:defpackage :system-time-span
  (:use :cl)
  (:shadow
   #:-
   #:*
   #:/
   #:+
   #:<
   #:<=
   #:=
   #:>
   #:>=
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:+hours-per-day+
   #:+microseconds-per-day+
   #:+microseconds-per-hour+
   #:+microseconds-per-millisecond+
   #:+microseconds-per-minute+
   #:+microseconds-per-second+
   #:+milliseconds-per-day+
   #:+milliseconds-per-hour+
   #:+milliseconds-per-minute+
   #:+milliseconds-per-second+
   #:+minutes-per-day+
   #:+minutes-per-hour+
   #:+nanoseconds-per-tick+
   #:+seconds-per-day+
   #:+seconds-per-hour+
   #:+seconds-per-minute+
   #:+ticks-per-day+
   #:+ticks-per-hour+
   #:+ticks-per-microsecond+
   #:+ticks-per-millisecond+
   #:+ticks-per-minute+
   #:+ticks-per-second+
   #:+max-value+
   #:+min-value+
   #:+zero+
   #:days
   #:hours
   #:microseconds
   #:milliseconds
   #:minutes
   #:nanoseconds
   #:seconds
   #:ticks
   #:total-days
   #:total-hours
   #:total-microseconds
   #:total-milliseconds
   #:total-minutes
   #:total-nanoseconds
   #:total-seconds
   #:-
   #:*
   #:/
   #:+
   #:<
   #:<=
   #:=
   #:>
   #:>=
   #:add
   #:compare
   #:compare-to
   #:divide
   #:duration
   #:equals
   #:equals*
   #:from-days
   #:from-hours
   #:from-microseconds
   #:from-milliseconds
   #:from-minutes
   #:from-seconds
   #:from-ticks
   #:get-hash-code
   #:multiply
   #:negate
   #:not=
   #:parse
   #:parse-exact
   #:subtract
   #:to-string
  ))

;;; Source File: system-object.lisp
;;; C# Class: System.Object
;;; Constant Properties: (none)
(cl:defpackage :system-object
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:equals
   #:equals*
   #:finalize
   #:get-hash-code
   #:get-type
   #:memberwise-clone
   #:reference-equals
   #:to-string
   #:dummy-extension
  ))

;;; Source File: system-type.lisp
;;; C# Class: System.Type
;;; Constant Properties: (none)
(cl:defpackage :system-type
  (:use :cl)
  (:shadow
   #:=
   #:get-properties
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:delimiter
   #:empty-types
   #:filter-attribute
   #:filter-name
   #:filter-name-ignore-case
   #:missing
   #:default-binder
   #:assembly
   #:assembly-qualified-name
   #:attributes
   #:base-type
   #:contains-generic-parameters
   #:declaring-method
   #:declaring-type
   #:full-name
   #:generic-parameter-attributes
   #:generic-parameter-position
   #:generic-type-arguments
   #:guid
   #:has-element-type
   #:abstract?
   #:ansi-class?
   #:array?
   #:auto-class?
   #:auto-layout?
   #:by-ref?
   #:by-ref-like?
   #:class?
   #:com-object?
   #:constructed-generic-type?
   #:contextful?
   #:enum?
   #:explicit-layout?
   #:function-pointer?
   #:generic-method-parameter?
   #:generic-parameter?
   #:generic-type?
   #:generic-type-definition?
   #:generic-type-parameter?
   #:import?
   #:interface?
   #:layout-sequential?
   #:marshal-by-ref?
   #:nested?
   #:nested-assembly?
   #:nested-fam-and-assem?
   #:nested-family?
   #:nested-fam-or-assem?
   #:nested-private?
   #:nested-public?
   #:not-public?
   #:pointer?
   #:primitive?
   #:public?
   #:sealed?
   #:security-critical?
   #:security-safe-critical?
   #:security-transparent?
   #:serializable?
   #:signature-type?
   #:special-name?
   #:sz-array?
   #:type-definition?
   #:unicode-class?
   #:unmanaged-function-pointer?
   #:value-type?
   #:variable-bound-array?
   #:visible?
   #:member-type
   #:module
   #:namespace
   #:reflected-type
   #:struct-layout-attribute
   #:type-handle
   #:type-initializer
   #:underlying-system-type
   #:=
   #:equals
   #:find-interfaces
   #:find-members
   #:get-array-rank
   #:get-attribute-flags-impl
   #:get-constructor
   #:get-constructor-impl
   #:get-constructors
   #:get-default-members
   #:get-element-type
   #:get-enum-name
   #:get-enum-names
   #:get-enum-underlying-type
   #:get-enum-values
   #:get-enum-values-as-underlying-type
   #:get-event
   #:get-events
   #:get-field
   #:get-fields
   #:get-function-pointer-calling-conventions
   #:get-function-pointer-parameter-types
   #:get-function-pointer-return-type
   #:get-generic-arguments
   #:get-generic-parameter-constraints
   #:get-generic-type-definition
   #:get-hash-code
   #:get-interface
   #:get-interface-map
   #:get-interfaces
   #:get-member
   #:get-members
   #:get-member-with-same-metadata-definition-as
   #:get-method
   #:get-method-impl
   #:get-methods
   #:get-nested-type
   #:get-nested-types
   #:get-optional-custom-modifiers
   #:get-properties
   #:get-property
   #:get-property-impl
   #:get-required-custom-modifiers
   #:get-type
   #:get-type*
   #:get-type-array
   #:get-type-code
   #:get-type-code-impl
   #:get-type-from-clsid
   #:get-type-from-handle
   #:get-type-from-prog-id
   #:get-type-handle
   #:has-element-type-impl
   #:invoke-member
   #:array-impl?
   #:assignable-from?
   #:assignable-to?
   #:by-ref-impl?
   #:com-object-impl?
   #:contextful-impl?
   #:enum-defined?
   #:equivalent-to?
   #:instance-of-type?
   #:marshal-by-ref-impl?
   #:pointer-impl?
   #:primitive-impl?
   #:subclass-of?
   #:value-type-impl?
   #:make-array-type
   #:make-by-ref-type
   #:make-generic-method-parameter
   #:make-pointer-type
   #:not=
   #:reflection-only-get-type
   #:to-string
   #:get-type-info
   #:get-runtime-event
   #:get-runtime-events
   #:get-runtime-field
   #:get-runtime-fields
   #:get-runtime-method
   #:get-runtime-methods
   #:get-runtime-properties
   #:get-runtime-property
  ))

;;; Source File: system-string.lisp
;;; C# Class: System.String
;;; Constant Properties: (none)
(cl:defpackage :system-string
  (:use :cl)
  (:shadow
   #:length
   #:=
   #:format
   #:intern
   #:remove
   #:replace
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:empty
   #:chars
   #:length
   #:=
   #:clone
   #:compare
   #:compare-ordinal
   #:compare-to
   #:concat
   #:concat<>
   #:contains
   #:copy
   #:copy-to
   #:create
   #:ends-with
   #:enumerate-runes
   #:equals
   #:equals*
   #:format
   #:format<>
   #:get-enumerator
   #:get-hash-code
   #:get-hash-code*
   #:get-pinnable-reference
   #:get-type-code
   #:implicit-cast
   #:index-of
   #:index-of-any
   #:insert
   #:intern
   #:interned?
   #:normalized?
   #:null-or-empty?
   #:null-or-white-space?
   #:join
   #:join<>
   #:last-index-of
   #:last-index-of-any
   #:normalize
   #:not=
   #:pad-left
   #:pad-right
   #:remove
   #:replace
   #:replace-line-endings
   #:split
   #:starts-with
   #:substring
   #:to-char-array
   #:to-lower
   #:to-lower-invariant
   #:to-string
   #:to-upper
   #:to-upper-invariant
   #:trim
   #:trim-end
   #:trim-start
   #:try-copy-to
  ))

;;; Source File: system-array.lisp
;;; C# Class: System.Array
;;; Constant Properties: MaxLength
(cl:defpackage :system-array
  (:use :cl)
  (:shadow
   #:length
   #:fill
   #:find
   #:reverse
   #:sort
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:+max-length+
   #:fixed-size?
   #:read-only?
   #:synchronized?
   #:length
   #:long-length
   #:rank
   #:sync-root
   #:as-read-only
   #:binary-search
   #:binary-search<>
   #:clear
   #:clone
   #:constrained-copy
   #:convert-all
   #:copy
   #:copy-to
   #:create-instance
   #:create-instance-from-array-type
   #:empty
   #:exists
   #:fill
   #:find
   #:find-all
   #:find-index
   #:find-last
   #:find-last-index
   #:for-each
   #:get-enumerator
   #:get-length
   #:get-long-length
   #:get-lower-bound
   #:get-upper-bound
   #:get-value
   #:index-of
   #:index-of<>
   #:initialize
   #:last-index-of
   #:last-index-of<>
   #:reverse
   #:reverse<>
   #:set-value
   #:sort
   #:sort<>
   #:true-for-all
  ))

;;; Source File: system-time-zone-info.lisp
;;; C# Class: System.TimeZoneInfo
;;; Constant Properties: (none)
(cl:defpackage :system-time-zone-info
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:local
   #:utc
   #:base-utc-offset
   #:daylight-name
   #:display-name
   #:has-iana-id
   #:id
   #:standard-name
   #:supports-daylight-saving-time
   #:clear-cached-data
   #:convert-time
   #:convert-time-by-system-time-zone-id
   #:convert-time-from-utc
   #:convert-time-to-utc
   #:create-custom-time-zone
   #:equals
   #:find-system-time-zone-by-id
   #:from-serialized-string
   #:get-adjustment-rules
   #:get-ambiguous-time-offsets
   #:get-hash-code
   #:get-system-time-zones
   #:get-utc-offset
   #:has-same-rules
   #:ambiguous-time?
   #:daylight-saving-time?
   #:invalid-time?
   #:to-serialized-string
   #:to-string
  ))

;;; Source File: system-convert.lisp
;;; C# Class: System.Convert
;;; Constant Properties: (none)
(cl:defpackage :system-convert
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:db-null
   #:change-type
   #:from-base64-char-array
   #:from-base64-string
   #:from-hex-string
   #:get-type-code
   #:db-null?
   #:to-base64-char-array
   #:to-base64-string
   #:to-boolean
   #:to-byte
   #:to-char
   #:to-date-time
   #:to-decimal
   #:to-double
   #:to-hex-string
   #:to-hex-string-lower
   #:to-int16
   #:to-int32
   #:to-int64
   #:to-s-byte
   #:to-single
   #:to-string
   #:to-u-int16
   #:to-u-int32
   #:to-u-int64
  ))

;;; Source File: system-text-string-builder.lisp
;;; C# Class: System.Text.StringBuilder
;;; Constant Properties: (none)
(cl:defpackage :system-text-string-builder
  (:use :cl)
  (:shadow
   #:length
   #:append
   #:remove
   #:replace
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:capacity
   #:chars
   #:length
   #:max-capacity
   #:append
   #:append-format
   #:append-format<>
   #:append-join
   #:append-join<>
   #:append-line
   #:clear
   #:copy-to
   #:ensure-capacity
   #:equals
   #:get-chunks
   #:insert
   #:remove
   #:replace
   #:to-string
  ))

;;; Source File: system-time-zone-info-adjustment-rule.lisp
;;; C# Class: System.TimeZoneInfo+AdjustmentRule
;;; Constant Properties: (none)
(cl:defpackage :system-time-zone-info-adjustment-rule
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:base-utc-offset-delta
   #:date-end
   #:date-start
   #:daylight-delta
   #:daylight-transition-end
   #:daylight-transition-start
   #:create-adjustment-rule
   #:equals
   #:get-hash-code
  ))

;;; Source File: system-value-tuple-2.lisp
;;; C# Class: System.ValueTuple`2
;;; Constant Properties: (none)
(cl:defpackage :system-value-tuple-2
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:item1
   #:item2
   #:compare-to
   #:equals
   #:get-hash-code
   #:to-string
  ))

;;; Source File: system-value-tuple-3.lisp
;;; C# Class: System.ValueTuple`3
;;; Constant Properties: (none)
(cl:defpackage :system-value-tuple-3
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:item1
   #:item2
   #:item3
   #:compare-to
   #:equals
   #:get-hash-code
   #:to-string
  ))

;;; Source File: system-value-tuple-4.lisp
;;; C# Class: System.ValueTuple`4
;;; Constant Properties: (none)
(cl:defpackage :system-value-tuple-4
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:item1
   #:item2
   #:item3
   #:item4
   #:compare-to
   #:equals
   #:get-hash-code
   #:to-string
  ))

;;; Source File: system-value-tuple-5.lisp
;;; C# Class: System.ValueTuple`5
;;; Constant Properties: (none)
(cl:defpackage :system-value-tuple-5
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:item1
   #:item2
   #:item3
   #:item4
   #:item5
   #:compare-to
   #:equals
   #:get-hash-code
   #:to-string
  ))

;;; Source File: system-value-tuple-6.lisp
;;; C# Class: System.ValueTuple`6
;;; Constant Properties: (none)
(cl:defpackage :system-value-tuple-6
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:item1
   #:item2
   #:item3
   #:item4
   #:item5
   #:item6
   #:compare-to
   #:equals
   #:get-hash-code
   #:to-string
  ))

;;; Source File: system-value-tuple-7.lisp
;;; C# Class: System.ValueTuple`7
;;; Constant Properties: (none)
(cl:defpackage :system-value-tuple-7
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:item1
   #:item2
   #:item3
   #:item4
   #:item5
   #:item6
   #:item7
   #:compare-to
   #:equals
   #:get-hash-code
   #:to-string
  ))

;;; Source File: system-value-tuple-8.lisp
;;; C# Class: System.ValueTuple`8
;;; Constant Properties: (none)
(cl:defpackage :system-value-tuple-8
  (:use :cl)
  (:shadow
   #:rest
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:item1
   #:item2
   #:item3
   #:item4
   #:item5
   #:item6
   #:item7
   #:rest
   #:compare-to
   #:equals
   #:get-hash-code
   #:to-string
  ))

;;; Source File: system-argument-out-of-range-exception.lisp
;;; C# Class: System.ArgumentOutOfRangeException
;;; Constant Properties: (none)
(cl:defpackage :system-argument-out-of-range-exception
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:actual-value
   #:message
   #:get-object-data
   #:throw-if-equal
   #:throw-if-greater-than
   #:throw-if-greater-than-or-equal
   #:throw-if-less-than
   #:throw-if-less-than-or-equal
   #:throw-if-negative
   #:throw-if-negative-or-zero
   #:throw-if-not-equal
   #:throw-if-zero
  ))

;;; Source File: system-collections-hashtable.lisp
;;; C# Class: System.Collections.Hashtable
;;; Constant Properties: (none)
(cl:defpackage :system-collections-hashtable
  (:use :cl)
  (:shadow
   #:count
   #:values
   #:remove
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:comparer
   #:count
   #:equality-comparer
   #:hcp
   #:fixed-size?
   #:read-only?
   #:synchronized?
   #:item
   #:keys
   #:sync-root
   #:values
   #:add
   #:clear
   #:clone
   #:contains
   #:contains-key
   #:contains-value
   #:copy-to
   #:get-enumerator
   #:get-hash
   #:get-object-data
   #:key-equals
   #:on-deserialization
   #:remove
   #:synchronized
  ))

;;; Source File: system-io-memory-stream.lisp
;;; C# Class: System.IO.MemoryStream
;;; Constant Properties: (none)
(cl:defpackage :system-io-memory-stream
  (:use :cl)
  (:shadow
   #:length
   #:position
   #:read
   #:read-byte
   #:write
   #:write-byte
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:can-read
   #:can-seek
   #:can-write
   #:capacity
   #:length
   #:position
   #:copy-to
   #:copy-to-async
   #:dispose
   #:flush
   #:flush-async
   #:get-buffer
   #:read
   #:read-async
   #:read-byte
   #:seek
   #:set-length
   #:to-array
   #:write
   #:write-async
   #:write-byte
   #:write-to
  ))

;;; Source File: system-io-stream-reader.lisp
;;; C# Class: System.IO.StreamReader
;;; Constant Properties: (none)
(cl:defpackage :system-io-stream-reader
  (:use :cl)
  (:shadow
   #:null
   #:close
   #:read
   #:read-line
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:null
   #:base-stream
   #:current-encoding
   #:end-of-stream
   #:close
   #:discard-buffered-data
   #:dispose
   #:peek
   #:read
   #:read-async
   #:read-block
   #:read-block-async
   #:read-line
   #:read-line-async
   #:read-to-end
   #:read-to-end-async
  ))

;;; Source File: system-collections-i-structural-comparable.lisp
;;; C# Class: System.Collections.IStructuralComparable
;;; Constant Properties: (none)
(cl:defpackage :system-collections-i-structural-comparable
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:compare-to
  ))

;;; Source File: system-collections-i-structural-equatable.lisp
;;; C# Class: System.Collections.IStructuralEquatable
;;; Constant Properties: (none)
(cl:defpackage :system-collections-i-structural-equatable
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:equals
   #:get-hash-code
  ))

;;; Source File: system-i-comparable.lisp
;;; C# Class: System.IComparable
;;; Constant Properties: (none)
(cl:defpackage :system-i-comparable
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:compare-to
  ))

;;; Source File: system-runtime-compiler-services-i-tuple.lisp
;;; C# Class: System.Runtime.CompilerServices.ITuple
;;; Constant Properties: (none)
(cl:defpackage :system-runtime-compiler-services-i-tuple
  (:use :cl)
  (:shadow
   #:length
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:item
   #:length
  ))

;;; Source File: system-argument-exception.lisp
;;; C# Class: System.ArgumentException
;;; Constant Properties: (none)
(cl:defpackage :system-argument-exception
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:message
   #:param-name
   #:get-object-data
   #:throw-if-null-or-empty
   #:throw-if-null-or-white-space
  ))

;;; Source File: system-runtime-serialization-i-serializable.lisp
;;; C# Class: System.Runtime.Serialization.ISerializable
;;; Constant Properties: (none)
(cl:defpackage :system-runtime-serialization-i-serializable
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:get-object-data
  ))

;;; Source File: system-system-exception.lisp
;;; C# Class: System.SystemException
;;; Constant Properties: (none)
(cl:defpackage :system-system-exception
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
  ))

;;; Source File: system-exception.lisp
;;; C# Class: System.Exception
;;; Constant Properties: (none)
(cl:defpackage :system-exception
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:data
   #:help-link
   #:h-result
   #:inner-exception
   #:message
   #:source
   #:stack-trace
   #:target-site
   #:get-base-exception
   #:get-object-data
   #:get-type
   #:to-string
   #:add-serialize-object-state
   #:remove-serialize-object-state
  ))

;;; Source File: system-io-stream.lisp
;;; C# Class: System.IO.Stream
;;; Constant Properties: (none)
(cl:defpackage :system-io-stream
  (:use :cl)
  (:shadow
   #:null
   #:length
   #:position
   #:close
   #:read
   #:read-byte
   #:write
   #:write-byte
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:null
   #:can-read
   #:can-seek
   #:can-timeout
   #:can-write
   #:length
   #:position
   #:read-timeout
   #:write-timeout
   #:begin-read
   #:begin-write
   #:close
   #:copy-to
   #:copy-to-async
   #:create-wait-handle
   #:dispose
   #:dispose-async
   #:end-read
   #:end-write
   #:flush
   #:flush-async
   #:object-invariant
   #:read
   #:read-async
   #:read-at-least
   #:read-at-least-async
   #:read-byte
   #:read-exactly
   #:read-exactly-async
   #:seek
   #:set-length
   #:synchronized
   #:validate-buffer-arguments
   #:validate-copy-to-arguments
   #:write
   #:write-async
   #:write-byte
  ))

;;; Source File: system-i-async-disposable.lisp
;;; C# Class: System.IAsyncDisposable
;;; Constant Properties: (none)
(cl:defpackage :system-i-async-disposable
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:dispose-async
  ))

;;; Source File: system-i-disposable.lisp
;;; C# Class: System.IDisposable
;;; Constant Properties: (none)
(cl:defpackage :system-i-disposable
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:dispose
  ))

;;; Source File: system-marshal-by-ref-object.lisp
;;; C# Class: System.MarshalByRefObject
;;; Constant Properties: (none)
(cl:defpackage :system-marshal-by-ref-object
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:get-lifetime-service
   #:initialize-lifetime-service
   #:memberwise-clone
  ))

;;; Source File: system-io-text-reader.lisp
;;; C# Class: System.IO.TextReader
;;; Constant Properties: (none)
(cl:defpackage :system-io-text-reader
  (:use :cl)
  (:shadow
   #:null
   #:close
   #:read
   #:read-line
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:null
   #:close
   #:dispose
   #:peek
   #:read
   #:read-async
   #:read-block
   #:read-block-async
   #:read-line
   #:read-line-async
   #:read-to-end
   #:read-to-end-async
   #:synchronized
  ))

;;; Source File: system-collections-i-collection.lisp
;;; C# Class: System.Collections.ICollection
;;; Constant Properties: (none)
(cl:defpackage :system-collections-i-collection
  (:use :cl)
  (:shadow
   #:count
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:count
   #:synchronized?
   #:sync-root
   #:copy-to
  ))

;;; Source File: system-collections-i-enumerable.lisp
;;; C# Class: System.Collections.IEnumerable
;;; Constant Properties: (none)
(cl:defpackage :system-collections-i-enumerable
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:get-enumerator
  ))

;;; Source File: system-runtime-serialization-i-deserialization-callback.lisp
;;; C# Class: System.Runtime.Serialization.IDeserializationCallback
;;; Constant Properties: (none)
(cl:defpackage :system-runtime-serialization-i-deserialization-callback
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:on-deserialization
  ))

;;; Source File: system-linq-enumerable.lisp
;;; C# Class: System.Linq.Enumerable
;;; Constant Properties: (none)
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
   #:aggregate-by
   #:all
   #:any
   #:append
   #:as-enumerable
   #:average
   #:average<>
   #:cast
   #:chunk
   #:concat
   #:contains
   #:count
   #:count-by
   #:default-if-empty
   #:distinct
   #:distinct-by
   #:element-at
   #:element-at-or-default
   #:empty
   #:except
   #:except-by
   #:first
   #:first-or-default
   #:group-by
   #:group-join
   #:index
   #:infinite-sequence
   #:intersect
   #:intersect-by
   #:join
   #:last
   #:last-or-default
   #:left-join
   #:long-count
   #:max
   #:max<>
   #:max-by
   #:min
   #:min<>
   #:min-by
   #:of-type
   #:order
   #:order-by
   #:order-by-descending
   #:order-descending
   #:prepend
   #:range
   #:repeat
   #:reverse
   #:right-join
   #:select
   #:select-many
   #:sequence
   #:sequence-equal
   #:shuffle
   #:single
   #:single-or-default
   #:skip
   #:skip-last
   #:skip-while
   #:sum
   #:sum<>
   #:take
   #:take-last
   #:take-while
   #:then-by
   #:then-by-descending
   #:to-array
   #:to-dictionary
   #:to-hash-set
   #:to-list
   #:to-lookup
   #:union
   #:union-by
   #:where
   #:zip
  ))

;;; Source File: system-xml-xml-reader.lisp
;;; C# Class: System.Xml.XmlReader
;;; Constant Properties: (none)
(cl:defpackage :system-xml-xml-reader
  (:use :cl)
  (:shadow
   #:close
   #:read
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:attribute-count
   #:base-uri
   #:can-read-binary-content
   #:can-read-value-chunk
   #:can-resolve-entity
   #:depth
   #:eof
   #:has-attributes
   #:has-value
   #:default?
   #:empty-element?
   #:local-name
   #:name
   #:namespace-uri
   #:name-table
   #:node-type
   #:prefix
   #:quote-char
   #:read-state
   #:schema-info
   #:settings
   #:value
   #:value-type
   #:xml-lang
   #:xml-space
   #:close
   #:create
   #:dispose
   #:get-attribute
   #:get-value-async
   #:name?
   #:name-token?
   #:start-element?
   #:lookup-namespace
   #:move-to-attribute
   #:move-to-content
   #:move-to-content-async
   #:move-to-element
   #:move-to-first-attribute
   #:move-to-next-attribute
   #:read
   #:read-async
   #:read-attribute-value
   #:read-content-as
   #:read-content-as-async
   #:read-content-as-base64
   #:read-content-as-base64-async
   #:read-content-as-bin-hex
   #:read-content-as-bin-hex-async
   #:read-content-as-boolean
   #:read-content-as-date-time
   #:read-content-as-date-time-offset
   #:read-content-as-decimal
   #:read-content-as-double
   #:read-content-as-float
   #:read-content-as-int
   #:read-content-as-long
   #:read-content-as-object
   #:read-content-as-object-async
   #:read-content-as-string
   #:read-content-as-string-async
   #:read-element-content-as
   #:read-element-content-as-async
   #:read-element-content-as-base64
   #:read-element-content-as-base64-async
   #:read-element-content-as-bin-hex
   #:read-element-content-as-bin-hex-async
   #:read-element-content-as-boolean
   #:read-element-content-as-date-time
   #:read-element-content-as-decimal
   #:read-element-content-as-double
   #:read-element-content-as-float
   #:read-element-content-as-int
   #:read-element-content-as-long
   #:read-element-content-as-object
   #:read-element-content-as-object-async
   #:read-element-content-as-string
   #:read-element-content-as-string-async
   #:read-element-string
   #:read-end-element
   #:read-inner-xml
   #:read-inner-xml-async
   #:read-outer-xml
   #:read-outer-xml-async
   #:read-start-element
   #:read-string
   #:read-subtree
   #:read-to-descendant
   #:read-to-following
   #:read-to-next-sibling
   #:read-value-chunk
   #:read-value-chunk-async
   #:resolve-entity
   #:skip
   #:skip-async
  ))

;;; Source File: system-collections-generic-dictionary-2.lisp
;;; C# Class: System.Collections.Generic.Dictionary`2
;;; Constant Properties: (none)
(cl:defpackage :system-collections-generic-dictionary-2
  (:use :cl)
  (:shadow
   #:count
   #:values
   #:remove
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:capacity
   #:comparer
   #:count
   #:item
   #:keys
   #:values
   #:add
   #:clear
   #:contains-key
   #:contains-value
   #:ensure-capacity
   #:get-alternate-lookup
   #:get-enumerator
   #:get-object-data
   #:on-deserialization
   #:remove
   #:trim-excess
   #:try-add
  ))

;;; Source File: system-collections-generic-dictionary-2-key-collection.lisp
;;; C# Class: System.Collections.Generic.Dictionary`2+KeyCollection
;;; Constant Properties: (none)
(cl:defpackage :system-collections-generic-dictionary-2-key-collection
  (:use :cl)
  (:shadow
   #:count
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:count
   #:contains
   #:copy-to
   #:get-enumerator
  ))

;;; Source File: system-collections-generic-dictionary-2-value-collection.lisp
;;; C# Class: System.Collections.Generic.Dictionary`2+ValueCollection
;;; Constant Properties: (none)
(cl:defpackage :system-collections-generic-dictionary-2-value-collection
  (:use :cl)
  (:shadow
   #:count
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:count
   #:copy-to
   #:get-enumerator
  ))

;;; Source File: system-collections-generic-list-1.lisp
;;; C# Class: System.Collections.Generic.List`1
;;; Constant Properties: (none)
(cl:defpackage :system-collections-generic-list-1
  (:use :cl)
  (:shadow
   #:count
   #:find
   #:remove
   #:reverse
   #:sort
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:capacity
   #:count
   #:item
   #:add
   #:add-range
   #:as-read-only
   #:binary-search
   #:clear
   #:contains
   #:convert-all
   #:copy-to
   #:ensure-capacity
   #:exists
   #:find
   #:find-all
   #:find-index
   #:find-last
   #:find-last-index
   #:for-each
   #:get-enumerator
   #:get-range
   #:index-of
   #:insert
   #:insert-range
   #:last-index-of
   #:remove
   #:remove-all
   #:remove-at
   #:remove-range
   #:reverse
   #:slice
   #:sort
   #:to-array
   #:trim-excess
   #:true-for-all
  ))

;;; Source File: system-collections-generic-sorted-list-2.lisp
;;; C# Class: System.Collections.Generic.SortedList`2
;;; Constant Properties: (none)
(cl:defpackage :system-collections-generic-sorted-list-2
  (:use :cl)
  (:shadow
   #:count
   #:values
   #:remove
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:capacity
   #:comparer
   #:count
   #:item
   #:keys
   #:values
   #:add
   #:clear
   #:contains-key
   #:contains-value
   #:get-enumerator
   #:get-key-at-index
   #:get-value-at-index
   #:index-of-key
   #:index-of-value
   #:remove
   #:remove-at
   #:set-value-at-index
   #:trim-excess
  ))

;;; Source File: system-numerics-vector2.lisp
;;; C# Class: System.Numerics.Vector2
;;; Constant Properties: *
(cl:defpackage :system-numerics-vector2
  (:use :cl)
  (:shadow
   #:-
   #:*
   #:/
   #:+
   #:=
   #:abs
   #:cos
   #:count
   #:exp
   #:length
   #:load
   #:log
   #:max
   #:min
   #:round
   #:sin
   #:truncate
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:x
   #:y
   #:+all-bits-set+
   #:+e+
   #:+epsilon+
   #:+nan+
   #:+negative-infinity+
   #:+negative-zero+
   #:+one+
   #:+pi+
   #:+positive-infinity+
   #:+tau+
   #:+unit-x+
   #:+unit-y+
   #:+zero+
   #:item
   #:-
   #:*
   #:/
   #:&
   #:^
   #:+
   #:<<
   #:=
   #:>>
   #:>>>
   #:|
   #:~
   #:abs
   #:add
   #:all
   #:all-where-all-bits-set
   #:and-not
   #:any
   #:any-where-all-bits-set
   #:bitwise-and
   #:bitwise-or
   #:clamp
   #:clamp-native
   #:conditional-select
   #:copy-sign
   #:copy-to
   #:cos
   #:count
   #:count-where-all-bits-set
   #:create
   #:create-scalar
   #:create-scalar-unsafe
   #:cross
   #:degrees-to-radians
   #:distance
   #:distance-squared
   #:divide
   #:dot
   #:equals
   #:equals*
   #:equals-all
   #:equals-any
   #:exp
   #:fused-multiply-add
   #:get-hash-code
   #:greater-than
   #:greater-than-all
   #:greater-than-any
   #:greater-than-or-equal
   #:greater-than-or-equal-all
   #:greater-than-or-equal-any
   #:hypot
   #:index-of
   #:index-of-where-all-bits-set
   #:even-integer?
   #:finite?
   #:infinity?
   #:integer?
   #:nan?
   #:negative?
   #:negative-infinity?
   #:normal?
   #:odd-integer?
   #:positive?
   #:positive-infinity?
   #:subnormal?
   #:zero?
   #:last-index-of
   #:last-index-of-where-all-bits-set
   #:length
   #:length-squared
   #:lerp
   #:less-than
   #:less-than-all
   #:less-than-any
   #:less-than-or-equal
   #:less-than-or-equal-all
   #:less-than-or-equal-any
   #:load
   #:load-aligned
   #:load-aligned-non-temporal
   #:log
   #:log2
   #:max
   #:max-magnitude
   #:max-magnitude-number
   #:max-native
   #:max-number
   #:min
   #:min-magnitude
   #:min-magnitude-number
   #:min-native
   #:min-number
   #:multiply
   #:multiply-add-estimate
   #:negate
   #:none
   #:none-where-all-bits-set
   #:normalize
   #:not=
   #:ones-complement
   #:radians-to-degrees
   #:reflect
   #:round
   #:shuffle
   #:sin
   #:sin-cos
   #:square-root
   #:subtract
   #:sum
   #:to-string
   #:transform
   #:transform-normal
   #:truncate
   #:try-copy-to
   #:xor
   #:as-vector3
   #:as-vector3-unsafe
   #:as-vector4
   #:as-vector4-unsafe
   #:extract-most-significant-bits
   #:get-element
   #:store
   #:store-aligned
   #:store-aligned-non-temporal
   #:to-scalar
   #:with-element
  ))

;;; Source File: system-numerics-vector3.lisp
;;; C# Class: System.Numerics.Vector3
;;; Constant Properties: *
(cl:defpackage :system-numerics-vector3
  (:use :cl)
  (:shadow
   #:-
   #:*
   #:/
   #:+
   #:=
   #:abs
   #:cos
   #:count
   #:exp
   #:length
   #:load
   #:log
   #:max
   #:min
   #:round
   #:sin
   #:truncate
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:x
   #:y
   #:z
   #:+all-bits-set+
   #:+e+
   #:+epsilon+
   #:+nan+
   #:+negative-infinity+
   #:+negative-zero+
   #:+one+
   #:+pi+
   #:+positive-infinity+
   #:+tau+
   #:+unit-x+
   #:+unit-y+
   #:+unit-z+
   #:+zero+
   #:item
   #:-
   #:*
   #:/
   #:&
   #:^
   #:+
   #:<<
   #:=
   #:>>
   #:>>>
   #:|
   #:~
   #:abs
   #:add
   #:all
   #:all-where-all-bits-set
   #:and-not
   #:any
   #:any-where-all-bits-set
   #:bitwise-and
   #:bitwise-or
   #:clamp
   #:clamp-native
   #:conditional-select
   #:copy-sign
   #:copy-to
   #:cos
   #:count
   #:count-where-all-bits-set
   #:create
   #:create-scalar
   #:create-scalar-unsafe
   #:cross
   #:degrees-to-radians
   #:distance
   #:distance-squared
   #:divide
   #:dot
   #:equals
   #:equals*
   #:equals-all
   #:equals-any
   #:exp
   #:fused-multiply-add
   #:get-hash-code
   #:greater-than
   #:greater-than-all
   #:greater-than-any
   #:greater-than-or-equal
   #:greater-than-or-equal-all
   #:greater-than-or-equal-any
   #:hypot
   #:index-of
   #:index-of-where-all-bits-set
   #:even-integer?
   #:finite?
   #:infinity?
   #:integer?
   #:nan?
   #:negative?
   #:negative-infinity?
   #:normal?
   #:odd-integer?
   #:positive?
   #:positive-infinity?
   #:subnormal?
   #:zero?
   #:last-index-of
   #:last-index-of-where-all-bits-set
   #:length
   #:length-squared
   #:lerp
   #:less-than
   #:less-than-all
   #:less-than-any
   #:less-than-or-equal
   #:less-than-or-equal-all
   #:less-than-or-equal-any
   #:load
   #:load-aligned
   #:load-aligned-non-temporal
   #:log
   #:log2
   #:max
   #:max-magnitude
   #:max-magnitude-number
   #:max-native
   #:max-number
   #:min
   #:min-magnitude
   #:min-magnitude-number
   #:min-native
   #:min-number
   #:multiply
   #:multiply-add-estimate
   #:negate
   #:none
   #:none-where-all-bits-set
   #:normalize
   #:not=
   #:ones-complement
   #:radians-to-degrees
   #:reflect
   #:round
   #:shuffle
   #:sin
   #:sin-cos
   #:square-root
   #:subtract
   #:sum
   #:to-string
   #:transform
   #:transform-normal
   #:truncate
   #:try-copy-to
   #:xor
   #:as-vector2
   #:as-vector4
   #:as-vector4-unsafe
   #:extract-most-significant-bits
   #:get-element
   #:store
   #:store-aligned
   #:store-aligned-non-temporal
   #:to-scalar
   #:with-element
  ))

;;; Source File: system-numerics-vector4.lisp
;;; C# Class: System.Numerics.Vector4
;;; Constant Properties: *
(cl:defpackage :system-numerics-vector4
  (:use :cl)
  (:shadow
   #:-
   #:*
   #:/
   #:+
   #:=
   #:abs
   #:cos
   #:count
   #:exp
   #:length
   #:load
   #:log
   #:max
   #:min
   #:round
   #:sin
   #:truncate
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:w
   #:x
   #:y
   #:z
   #:+all-bits-set+
   #:+e+
   #:+epsilon+
   #:+nan+
   #:+negative-infinity+
   #:+negative-zero+
   #:+one+
   #:+pi+
   #:+positive-infinity+
   #:+tau+
   #:+unit-w+
   #:+unit-x+
   #:+unit-y+
   #:+unit-z+
   #:+zero+
   #:item
   #:-
   #:*
   #:/
   #:&
   #:^
   #:+
   #:<<
   #:=
   #:>>
   #:>>>
   #:|
   #:~
   #:abs
   #:add
   #:all
   #:all-where-all-bits-set
   #:and-not
   #:any
   #:any-where-all-bits-set
   #:bitwise-and
   #:bitwise-or
   #:clamp
   #:clamp-native
   #:conditional-select
   #:copy-sign
   #:copy-to
   #:cos
   #:count
   #:count-where-all-bits-set
   #:create
   #:create-scalar
   #:create-scalar-unsafe
   #:cross
   #:degrees-to-radians
   #:distance
   #:distance-squared
   #:divide
   #:dot
   #:equals
   #:equals*
   #:equals-all
   #:equals-any
   #:exp
   #:fused-multiply-add
   #:get-hash-code
   #:greater-than
   #:greater-than-all
   #:greater-than-any
   #:greater-than-or-equal
   #:greater-than-or-equal-all
   #:greater-than-or-equal-any
   #:hypot
   #:index-of
   #:index-of-where-all-bits-set
   #:even-integer?
   #:finite?
   #:infinity?
   #:integer?
   #:nan?
   #:negative?
   #:negative-infinity?
   #:normal?
   #:odd-integer?
   #:positive?
   #:positive-infinity?
   #:subnormal?
   #:zero?
   #:last-index-of
   #:last-index-of-where-all-bits-set
   #:length
   #:length-squared
   #:lerp
   #:less-than
   #:less-than-all
   #:less-than-any
   #:less-than-or-equal
   #:less-than-or-equal-all
   #:less-than-or-equal-any
   #:load
   #:load-aligned
   #:load-aligned-non-temporal
   #:log
   #:log2
   #:max
   #:max-magnitude
   #:max-magnitude-number
   #:max-native
   #:max-number
   #:min
   #:min-magnitude
   #:min-magnitude-number
   #:min-native
   #:min-number
   #:multiply
   #:multiply-add-estimate
   #:negate
   #:none
   #:none-where-all-bits-set
   #:normalize
   #:not=
   #:ones-complement
   #:radians-to-degrees
   #:round
   #:shuffle
   #:sin
   #:sin-cos
   #:square-root
   #:subtract
   #:sum
   #:to-string
   #:transform
   #:truncate
   #:try-copy-to
   #:xor
   #:as-plane
   #:as-quaternion
   #:as-vector2
   #:as-vector3
   #:extract-most-significant-bits
   #:get-element
   #:store
   #:store-aligned
   #:store-aligned-non-temporal
   #:to-scalar
   #:with-element
  ))

;;; Source File: system-threading-timer.lisp
;;; C# Class: System.Threading.Timer
;;; Constant Properties: (none)
(cl:defpackage :system-threading-timer
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:active-count
   #:change
   #:dispose
   #:dispose-async
  ))

;;; Source File: system-timers-timer.lisp
;;; C# Class: System.Timers.Timer
;;; Constant Properties: (none)
(cl:defpackage :system-timers-timer
  (:use :cl)
  (:shadow
   #:close
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:auto-reset
   #:enabled
   #:interval
   #:site
   #:synchronizing-object
   #:begin-init
   #:close
   #:dispose
   #:end-init
   #:start
   #:stop
   #:add-elapsed
   #:remove-elapsed
  ))

;;; Source File: system-diagnostics-debug.lisp
;;; C# Class: System.Diagnostics.Debug
;;; Constant Properties: (none)
(cl:defpackage :system-diagnostics-debug
  (:use :cl)
  (:shadow
   #:assert
   #:close
   #:print
   #:write
   #:write-line
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:auto-flush
   #:indent-level
   #:indent-size
   #:assert
   #:close
   #:fail
   #:flush
   #:indent
   #:print
   #:set-provider
   #:unindent
   #:write
   #:write-if
   #:write-line
   #:write-line-if
  ))

;;; Source File: system-globalization-culture-info.lisp
;;; C# Class: System.Globalization.CultureInfo
;;; Constant Properties: (none)
(cl:defpackage :system-globalization-culture-info
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:installed-ui-culture
   #:invariant-culture
   #:current-culture
   #:current-ui-culture
   #:default-thread-current-culture
   #:default-thread-current-ui-culture
   #:calendar
   #:compare-info
   #:culture-types
   #:date-time-format
   #:display-name
   #:english-name
   #:ietf-language-tag
   #:neutral-culture?
   #:read-only?
   #:keyboard-layout-id
   #:lcid
   #:name
   #:native-name
   #:number-format
   #:optional-calendars
   #:parent
   #:text-info
   #:three-letter-iso-language-name
   #:three-letter-windows-language-name
   #:two-letter-iso-language-name
   #:use-user-override
   #:clear-cached-data
   #:clone
   #:create-specific-culture
   #:equals
   #:get-console-fallback-ui-culture
   #:get-culture-info
   #:get-culture-info-by-ietf-language-tag
   #:get-cultures
   #:get-format
   #:get-hash-code
   #:read-only
   #:to-string
  ))

;;; Source File: system-net-service-point-manager.lisp
;;; C# Class: System.Net.ServicePointManager
;;; Constant Properties: (none)
(cl:defpackage :system-net-service-point-manager
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:+default-non-persistent-connection-limit+
   #:+default-persistent-connection-limit+
   #:encryption-policy
   #:check-certificate-revocation-list
   #:default-connection-limit
   #:dns-refresh-timeout
   #:enable-dns-round-robin
   #:expect100-continue
   #:max-service-point-idle-time
   #:max-service-points
   #:reuse-port
   #:security-protocol
   #:server-certificate-validation-callback
   #:use-nagle-algorithm
   #:find-service-point
   #:set-tcp-keep-alive
  ))

;;; Source File: system-environment.lisp
;;; C# Class: System.Environment
;;; Constant Properties: (none)
(cl:defpackage :system-environment
  (:use :cl)
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:command-line
   #:cpu-usage
   #:current-managed-thread-id
   #:has-shutdown-started
   #:is64-bit-operating-system
   #:is64-bit-process
   #:privileged-process?
   #:machine-name
   #:new-line
   #:os-version
   #:process-id
   #:processor-count
   #:process-path
   #:stack-trace
   #:system-directory
   #:system-page-size
   #:tick-count
   #:tick-count64
   #:user-domain-name
   #:user-interactive
   #:user-name
   #:version
   #:working-set
   #:current-directory
   #:exit-code
   #:exit
   #:expand-environment-variables
   #:fail-fast
   #:get-command-line-args
   #:get-environment-variable
   #:get-environment-variables
   #:get-folder-path
   #:get-logical-drives
   #:set-environment-variable
  ))

;;; Source File: system-app-domain.lisp
;;; C# Class: System.AppDomain
;;; Constant Properties: (none)
(cl:defpackage :system-app-domain
  (:use :cl)
  (:shadow
   #:load
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:current-domain
   #:monitoring-survived-process-memory-size
   #:monitoring-is-enabled
   #:base-directory
   #:dynamic-directory
   #:friendly-name
   #:id
   #:fully-trusted?
   #:homogenous?
   #:monitoring-survived-memory-size
   #:monitoring-total-allocated-memory-size
   #:monitoring-total-processor-time
   #:permission-set
   #:relative-search-path
   #:setup-information
   #:shadow-copy-files
   #:append-private-path
   #:apply-policy
   #:clear-private-path
   #:clear-shadow-copy-path
   #:create-domain
   #:create-instance
   #:create-instance-and-unwrap
   #:create-instance-from
   #:create-instance-from-and-unwrap
   #:execute-assembly
   #:execute-assembly-by-name
   #:get-assemblies
   #:get-current-thread-id
   #:get-data
   #:compatibility-switch-set?
   #:default-app-domain?
   #:finalizing-for-unload?
   #:load
   #:reflection-only-get-assemblies
   #:set-cache-path
   #:set-data
   #:set-dynamic-base
   #:set-principal-policy
   #:set-shadow-copy-files
   #:set-shadow-copy-path
   #:set-thread-principal
   #:to-string
   #:unload
   #:add-assembly-load
   #:remove-assembly-load
   #:add-assembly-resolve
   #:remove-assembly-resolve
   #:add-domain-unload
   #:remove-domain-unload
   #:add-first-chance-exception
   #:remove-first-chance-exception
   #:add-process-exit
   #:remove-process-exit
   #:add-reflection-only-assembly-resolve
   #:remove-reflection-only-assembly-resolve
   #:add-resource-resolve
   #:remove-resource-resolve
   #:add-type-resolve
   #:remove-type-resolve
   #:add-unhandled-exception
   #:remove-unhandled-exception
  ))

;;; Source File: system-threading-thread.lisp
;;; C# Class: System.Threading.Thread
;;; Constant Properties: (none)
(cl:defpackage :system-threading-thread
  (:use :cl)
  (:shadow
   #:abort
   #:sleep
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:current-thread
   #:current-principal
   #:apartment-state
   #:current-culture
   #:current-ui-culture
   #:execution-context
   #:alive?
   #:background?
   #:thread-pool-thread?
   #:managed-thread-id
   #:name
   #:priority
   #:thread-state
   #:abort
   #:allocate-data-slot
   #:allocate-named-data-slot
   #:begin-critical-region
   #:begin-thread-affinity
   #:disable-com-object-eager-cleanup
   #:end-critical-region
   #:end-thread-affinity
   #:finalize
   #:free-named-data-slot
   #:get-apartment-state
   #:get-compressed-stack
   #:get-current-processor-id
   #:get-data
   #:get-domain
   #:get-domain-id
   #:get-hash-code
   #:get-named-data-slot
   #:interrupt
   #:join
   #:memory-barrier
   #:reset-abort
   #:resume
   #:set-apartment-state
   #:set-compressed-stack
   #:set-data
   #:sleep
   #:spin-wait
   #:start
   #:suspend
   #:try-set-apartment-state
   #:unsafe-start
   #:yield
  ))

;;; Source File: system-collections-specialized-name-value-collection.lisp
;;; C# Class: System.Collections.Specialized.NameValueCollection
;;; Constant Properties: (none)
(cl:defpackage :system-collections-specialized-name-value-collection
  (:use :cl)
  (:shadow
   #:get
   #:remove
   #:set
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:all-keys
   #:add
   #:clear
   #:copy-to
   #:get
   #:get-key
   #:get-values
   #:has-keys
   #:invalidate-cached-arrays
   #:remove
   #:set
  ))

;;; Source File: system-collections-specialized-name-object-collection-base.lisp
;;; C# Class: System.Collections.Specialized.NameObjectCollectionBase
;;; Constant Properties: (none)
(cl:defpackage :system-collections-specialized-name-object-collection-base
  (:use :cl)
  (:shadow
   #:count
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:count
   #:read-only?
   #:keys
   #:base-add
   #:base-clear
   #:base-get
   #:base-get-all-keys
   #:base-get-all-values
   #:base-get-key
   #:base-has-keys
   #:base-remove
   #:base-remove-at
   #:base-set
   #:get-enumerator
   #:get-object-data
   #:on-deserialization
  ))

;;; Source File: assembly-to-lispy-test-target-event-test-class.lisp
;;; C# Class: AssemblyToLispyTestTarget.EventTestClass
;;; Constant Properties: (none)
(cl:defpackage :assembly-to-lispy-test-target-event-test-class
  (:use :cl)
  (:shadow
   #:describe
  )
  (:export
   #:<type>
   #:<type-str>
   #:<creation>
   #:<version>
   #:new
   #:raise-something-happened
   #:add-something-happened
   #:remove-something-happened
   #:describe
  ))

;;; ===== Re-exports from parent/interface packages =====

;;; system-value-tuple-2: re-exports inherited members from system-collections-i-structural-comparable, system-collections-i-structural-equatable, system-i-comparable, system-runtime-compiler-services-i-tuple
;;; Skipped (system-value-tuple-2 declares its own): compare-to
;;; Skipped (system-value-tuple-2 declares its own): equals
;;; Skipped (system-value-tuple-2 declares its own): get-hash-code
(cl:shadowing-import '(system-runtime-compiler-services-i-tuple::length) ':system-value-tuple-2)
(cl:import '(system-runtime-compiler-services-i-tuple::item) ':system-value-tuple-2)
(cl:export '(system-value-tuple-2::item system-value-tuple-2::length) ':system-value-tuple-2)

;;; system-argument-out-of-range-exception: re-exports inherited members from system-argument-exception, system-runtime-serialization-i-serializable, system-system-exception, system-exception, system-object
;;; Skipped (system-argument-out-of-range-exception declares its own): message
;;; Skipped (system-argument-out-of-range-exception declares its own): get-object-data
;;; Skipped (ambiguous across ancestors: system-exception, system-object): get-type
;;; Skipped (ambiguous across ancestors: system-exception, system-object): to-string
(cl:import '(system-argument-exception::param-name system-argument-exception::throw-if-null-or-empty system-argument-exception::throw-if-null-or-white-space system-exception::data system-exception::help-link system-exception::h-result system-exception::inner-exception system-exception::source system-exception::stack-trace system-exception::target-site system-exception::get-base-exception system-exception::add-serialize-object-state system-exception::remove-serialize-object-state system-object::equals system-object::equals* system-object::finalize system-object::get-hash-code system-object::memberwise-clone system-object::reference-equals system-object::dummy-extension) ':system-argument-out-of-range-exception)
(cl:export '(system-argument-out-of-range-exception::param-name system-argument-out-of-range-exception::throw-if-null-or-empty system-argument-out-of-range-exception::throw-if-null-or-white-space system-argument-out-of-range-exception::data system-argument-out-of-range-exception::help-link system-argument-out-of-range-exception::h-result system-argument-out-of-range-exception::inner-exception system-argument-out-of-range-exception::source system-argument-out-of-range-exception::stack-trace system-argument-out-of-range-exception::target-site system-argument-out-of-range-exception::get-base-exception system-argument-out-of-range-exception::add-serialize-object-state system-argument-out-of-range-exception::remove-serialize-object-state system-argument-out-of-range-exception::equals system-argument-out-of-range-exception::equals* system-argument-out-of-range-exception::finalize system-argument-out-of-range-exception::get-hash-code system-argument-out-of-range-exception::memberwise-clone system-argument-out-of-range-exception::reference-equals system-argument-out-of-range-exception::dummy-extension) ':system-argument-out-of-range-exception)

;;; system-io-memory-stream: re-exports inherited members from system-io-stream, system-i-async-disposable, system-i-disposable, system-marshal-by-ref-object, system-object
;;; Skipped (system-io-memory-stream declares its own): can-read
;;; Skipped (system-io-memory-stream declares its own): can-seek
;;; Skipped (system-io-memory-stream declares its own): can-write
;;; Skipped (system-io-memory-stream declares its own): length
;;; Skipped (system-io-memory-stream declares its own): position
;;; Skipped (system-io-memory-stream declares its own): copy-to
;;; Skipped (system-io-memory-stream declares its own): copy-to-async
;;; Skipped (system-io-memory-stream declares its own): dispose
;;; Skipped (ambiguous across ancestors: system-io-stream, system-i-async-disposable): dispose-async
;;; Skipped (system-io-memory-stream declares its own): flush
;;; Skipped (system-io-memory-stream declares its own): flush-async
;;; Skipped (system-io-memory-stream declares its own): read
;;; Skipped (system-io-memory-stream declares its own): read-async
;;; Skipped (system-io-memory-stream declares its own): read-byte
;;; Skipped (system-io-memory-stream declares its own): seek
;;; Skipped (system-io-memory-stream declares its own): set-length
;;; Skipped (system-io-memory-stream declares its own): write
;;; Skipped (system-io-memory-stream declares its own): write-async
;;; Skipped (system-io-memory-stream declares its own): write-byte
;;; Skipped (ambiguous across ancestors: system-marshal-by-ref-object, system-object): memberwise-clone
(cl:shadowing-import '(system-io-stream::null system-io-stream::close) ':system-io-memory-stream)
(cl:import '(system-io-stream::can-timeout system-io-stream::read-timeout system-io-stream::write-timeout system-io-stream::begin-read system-io-stream::begin-write system-io-stream::create-wait-handle system-io-stream::end-read system-io-stream::end-write system-io-stream::object-invariant system-io-stream::read-at-least system-io-stream::read-at-least-async system-io-stream::read-exactly system-io-stream::read-exactly-async system-io-stream::synchronized system-io-stream::validate-buffer-arguments system-io-stream::validate-copy-to-arguments system-marshal-by-ref-object::get-lifetime-service system-marshal-by-ref-object::initialize-lifetime-service system-object::equals system-object::equals* system-object::finalize system-object::get-hash-code system-object::get-type system-object::reference-equals system-object::to-string system-object::dummy-extension) ':system-io-memory-stream)
(cl:export '(system-io-memory-stream::null system-io-memory-stream::can-timeout system-io-memory-stream::read-timeout system-io-memory-stream::write-timeout system-io-memory-stream::begin-read system-io-memory-stream::begin-write system-io-memory-stream::close system-io-memory-stream::create-wait-handle system-io-memory-stream::end-read system-io-memory-stream::end-write system-io-memory-stream::object-invariant system-io-memory-stream::read-at-least system-io-memory-stream::read-at-least-async system-io-memory-stream::read-exactly system-io-memory-stream::read-exactly-async system-io-memory-stream::synchronized system-io-memory-stream::validate-buffer-arguments system-io-memory-stream::validate-copy-to-arguments system-io-memory-stream::get-lifetime-service system-io-memory-stream::initialize-lifetime-service system-io-memory-stream::equals system-io-memory-stream::equals* system-io-memory-stream::finalize system-io-memory-stream::get-hash-code system-io-memory-stream::get-type system-io-memory-stream::reference-equals system-io-memory-stream::to-string system-io-memory-stream::dummy-extension) ':system-io-memory-stream)

;;; system-io-stream-reader: re-exports inherited members from system-io-text-reader, system-i-disposable, system-marshal-by-ref-object
;;; Skipped (system-io-stream-reader declares its own): null
;;; Skipped (system-io-stream-reader declares its own): close
;;; Skipped (system-io-stream-reader declares its own): dispose
;;; Skipped (system-io-stream-reader declares its own): peek
;;; Skipped (system-io-stream-reader declares its own): read
;;; Skipped (system-io-stream-reader declares its own): read-async
;;; Skipped (system-io-stream-reader declares its own): read-block
;;; Skipped (system-io-stream-reader declares its own): read-block-async
;;; Skipped (system-io-stream-reader declares its own): read-line
;;; Skipped (system-io-stream-reader declares its own): read-line-async
;;; Skipped (system-io-stream-reader declares its own): read-to-end
;;; Skipped (system-io-stream-reader declares its own): read-to-end-async
(cl:import '(system-io-text-reader::synchronized system-marshal-by-ref-object::get-lifetime-service system-marshal-by-ref-object::initialize-lifetime-service system-marshal-by-ref-object::memberwise-clone) ':system-io-stream-reader)
(cl:export '(system-io-stream-reader::synchronized system-io-stream-reader::get-lifetime-service system-io-stream-reader::initialize-lifetime-service system-io-stream-reader::memberwise-clone) ':system-io-stream-reader)

;;; system-xml-xml-reader: re-exports inherited members from system-i-disposable
;;; Skipped (system-xml-xml-reader declares its own): dispose

;;; system-collections-specialized-name-value-collection: re-exports inherited members from system-collections-specialized-name-object-collection-base, system-collections-i-collection, system-collections-i-enumerable, system-runtime-serialization-i-deserialization-callback, system-runtime-serialization-i-serializable, system-object
;;; Skipped (ambiguous across ancestors: system-collections-specialized-name-object-collection-base, system-collections-i-collection): count
;;; Skipped (ambiguous across ancestors: system-collections-specialized-name-object-collection-base, system-collections-i-enumerable): get-enumerator
;;; Skipped (ambiguous across ancestors: system-collections-specialized-name-object-collection-base, system-runtime-serialization-i-serializable): get-object-data
;;; Skipped (ambiguous across ancestors: system-collections-specialized-name-object-collection-base, system-runtime-serialization-i-deserialization-callback): on-deserialization
;;; Skipped (system-collections-specialized-name-value-collection declares its own): copy-to
(cl:import '(system-collections-specialized-name-object-collection-base::read-only? system-collections-specialized-name-object-collection-base::keys system-collections-specialized-name-object-collection-base::base-add system-collections-specialized-name-object-collection-base::base-clear system-collections-specialized-name-object-collection-base::base-get system-collections-specialized-name-object-collection-base::base-get-all-keys system-collections-specialized-name-object-collection-base::base-get-all-values system-collections-specialized-name-object-collection-base::base-get-key system-collections-specialized-name-object-collection-base::base-has-keys system-collections-specialized-name-object-collection-base::base-remove system-collections-specialized-name-object-collection-base::base-remove-at system-collections-specialized-name-object-collection-base::base-set system-collections-i-collection::synchronized? system-collections-i-collection::sync-root system-object::equals system-object::equals* system-object::finalize system-object::get-hash-code system-object::get-type system-object::memberwise-clone system-object::reference-equals system-object::to-string system-object::dummy-extension) ':system-collections-specialized-name-value-collection)
(cl:export '(system-collections-specialized-name-value-collection::read-only? system-collections-specialized-name-value-collection::keys system-collections-specialized-name-value-collection::base-add system-collections-specialized-name-value-collection::base-clear system-collections-specialized-name-value-collection::base-get system-collections-specialized-name-value-collection::base-get-all-keys system-collections-specialized-name-value-collection::base-get-all-values system-collections-specialized-name-value-collection::base-get-key system-collections-specialized-name-value-collection::base-has-keys system-collections-specialized-name-value-collection::base-remove system-collections-specialized-name-value-collection::base-remove-at system-collections-specialized-name-value-collection::base-set system-collections-specialized-name-value-collection::synchronized? system-collections-specialized-name-value-collection::sync-root system-collections-specialized-name-value-collection::equals system-collections-specialized-name-value-collection::equals* system-collections-specialized-name-value-collection::finalize system-collections-specialized-name-value-collection::get-hash-code system-collections-specialized-name-value-collection::get-type system-collections-specialized-name-value-collection::memberwise-clone system-collections-specialized-name-value-collection::reference-equals system-collections-specialized-name-value-collection::to-string system-collections-specialized-name-value-collection::dummy-extension) ':system-collections-specialized-name-value-collection)

