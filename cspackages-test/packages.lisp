;;; Generated automatically. Do not edit.
;;; Generator Version: 29
;;; Creation Date: 2026-07-04T14:21:19Z

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
   #:+
   #:=
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
   #:+
   #:=
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
   #:+
   #:=
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
  ))

