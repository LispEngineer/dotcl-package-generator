;;; Generated automatically. Do not edit.
;;; Class: System.Numerics.Vector4
;;; Generator Version: 30
;;; Creation Date: 2026-07-04T15:28:03Z

(cl:in-package :system-numerics-vector4)

(cl:defconstant <type> (dotnet:resolve-type "System.Numerics.Vector4"))
(cl:defconstant <type-str> "System.Numerics.Vector4")
(cl:defconstant <creation> "2026-07-04T15:28:03Z")
(cl:defconstant <version> 30)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Numerics.Vector4")))

(cl:defun new (cl:&optional (value cl:nil supplied-value) (w cl:nil supplied-w) (w2 cl:nil supplied-w2) (w3 cl:nil supplied-w3))
  "Master wrapper for System.Numerics.Vector4 constructor overloads. Dispatches at runtime.

new()

new(Single)
  Summary: Creates a new System.Numerics.Vector4 object whose four elements have the same value.
  Parameters:
    - value (System.Single): The value to assign to all four elements.

new(Single])
  Summary: Constructs a vector from the given System.ReadOnlySpan`1. The span must contain at least 4 elements.
  Parameters:
    - values (System.ReadOnlySpan`1[System.Single]): The span of elements to assign to the vector.

new(Vector3, Single)
  Summary: Constructs a new System.Numerics.Vector4 object from the specified System.Numerics.Vector3 object and a W component.
  Parameters:
    - value (System.Numerics.Vector3): The vector to use for the X, Y, and Z components.
    - w (System.Single): The W component.

new(Vector2, Single, Single)
  Summary: Creates a new System.Numerics.Vector4 object from the specified System.Numerics.Vector2 object and a Z and a W component.
  Parameters:
    - value (System.Numerics.Vector2): The vector to use for the X and Y components.
    - z (System.Single): The Z component.
    - w (System.Single): The W component.

new(Single, Single, Single, Single)
  Summary: Creates a vector whose elements have the specified values.
  Parameters:
    - x (System.Single): The value to assign to the System.Numerics.Vector4.X field.
    - y (System.Single): The value to assign to the System.Numerics.Vector4.Y field.
    - z (System.Single): The value to assign to the System.Numerics.Vector4.Z field.
    - w (System.Single): The value to assign to the System.Numerics.Vector4.W field.
"
  (cl:cond
    ((cl:and supplied-value (cl:numberp value) supplied-w (cl:numberp w) supplied-w2 (cl:numberp w2) supplied-w3 (cl:numberp w3))
     (dotnet:new <type-str> value w w2 w3))
    ((cl:and supplied-value (cl:or (cl:null value) (dotnet:object-type value)) supplied-w (cl:numberp w) supplied-w2 (cl:numberp w2) (cl:not supplied-w3))
     (dotnet:new <type-str> value w w2))
    ((cl:and supplied-value (cl:or (cl:null value) (dotnet:object-type value)) supplied-w (cl:numberp w) (cl:not supplied-w2) (cl:not supplied-w3))
     (dotnet:new <type-str> value w))
    ((cl:and supplied-value (cl:numberp value) (cl:not supplied-w) (cl:not supplied-w2) (cl:not supplied-w3))
     (dotnet:new <type-str> value))
    ((cl:and supplied-value (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-w) (cl:not supplied-w2) (cl:not supplied-w3))
     (dotnet:new <type-str> value))
    ((cl:and (cl:not supplied-value) (cl:not supplied-w) (cl:not supplied-w2) (cl:not supplied-w3))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR4"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-value (cl:list :value value)) (cl:when supplied-w (cl:list :w w)) (cl:when supplied-w2 (cl:list :w2 w2)) (cl:when supplied-w3 (cl:list :w3 w3)))))))

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector4 is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +all-bits-set+ (dotnet:static <type-str> "AllBitsSet"))
(cl:setf (cl:documentation (cl:quote +all-bits-set+) (cl:quote cl:variable)) "Gets a vector where all bits are set to 1.")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector4 is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +e+ (dotnet:static <type-str> "E"))
(cl:setf (cl:documentation (cl:quote +e+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.E.")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector4 is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +epsilon+ (dotnet:static <type-str> "Epsilon"))
(cl:setf (cl:documentation (cl:quote +epsilon+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.Epsilon.")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector4 is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +nan+ (dotnet:static <type-str> "NaN"))
(cl:setf (cl:documentation (cl:quote +nan+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.NaN.")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector4 is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +negative-infinity+ (dotnet:static <type-str> "NegativeInfinity"))
(cl:setf (cl:documentation (cl:quote +negative-infinity+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.NegativeInfinity.")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector4 is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +negative-zero+ (dotnet:static <type-str> "NegativeZero"))
(cl:setf (cl:documentation (cl:quote +negative-zero+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.NegativeZero.")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector4 is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +one+ (dotnet:static <type-str> "One"))
(cl:setf (cl:documentation (cl:quote +one+) (cl:quote cl:variable)) "Gets a vector whose 4 elements are equal to one.")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector4 is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +pi+ (dotnet:static <type-str> "Pi"))
(cl:setf (cl:documentation (cl:quote +pi+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.Pi.")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector4 is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +positive-infinity+ (dotnet:static <type-str> "PositiveInfinity"))
(cl:setf (cl:documentation (cl:quote +positive-infinity+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.PositiveInfinity.")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector4 is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +tau+ (dotnet:static <type-str> "Tau"))
(cl:setf (cl:documentation (cl:quote +tau+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.Tau.")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector4 is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +unit-w+ (dotnet:static <type-str> "UnitW"))
(cl:setf (cl:documentation (cl:quote +unit-w+) (cl:quote cl:variable)) "Gets the vector (0,0,0,1).")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector4 is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +unit-x+ (dotnet:static <type-str> "UnitX"))
(cl:setf (cl:documentation (cl:quote +unit-x+) (cl:quote cl:variable)) "Gets the vector (1,0,0,0).")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector4 is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +unit-y+ (dotnet:static <type-str> "UnitY"))
(cl:setf (cl:documentation (cl:quote +unit-y+) (cl:quote cl:variable)) "Gets the vector (0,1,0,0).")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector4 is a mutable
;; value type (struct) with settable properties/fields, mutating this
;; object -- through this binding, or through ANY other reference that
;; aliases the same boxed instance -- permanently corrupts it for every
;; future reference to this constant, for the life of the program.
;; There is currently no supported way to obtain an independent,
;; safely-mutable copy of this value from Lisp; construct a fresh
;; instance via the type's own constructor (new) if you need to mutate
;; a copy. See FEATURES.md's "Static Constants and Symbol Macros"
;; section and doc/generator-design-notes.md for the full explanation.
(cl:defconstant +unit-z+ (dotnet:static <type-str> "UnitZ"))
(cl:setf (cl:documentation (cl:quote +unit-z+) (cl:quote cl:variable)) "Gets the vector (0,0,1,0).")

;; WARNING: this is a single, permanently-cached boxed .NET object --
;; the defconstant form below only runs once. If System.Numerics.Vector4 is a mutable
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
(cl:setf (cl:documentation (cl:quote +zero+) (cl:quote cl:variable)) "Gets a vector whose 4 elements are equal to zero.")

(cl:defun item (obj! index)
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "get_Item" index))

;; Note: obj! here is a boxed reference to a .NET value type (struct).
;; This setf mutates that exact boxed instance in place -- it does NOT
;; silently discard the change. However, if obj! is an alias of a shared
;; or cached value (e.g. a constant defined via defconstant), this mutates
;; that shared instance for every other reference to it too. See
;; FEATURES.md's "Struct Boxing Caveat" section for details.
(cl:defun (cl:setf item) (new-value obj! index)
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "set_Item" index new-value))

(cl:defun w (obj!)
  "The W component of the vector."
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "W"))

;; Note: obj! here is a boxed reference to a .NET value type (struct).
;; This setf mutates that exact boxed instance in place -- it does NOT
;; silently discard the change. However, if obj! is an alias of a shared
;; or cached value (e.g. a constant defined via defconstant), this mutates
;; that shared instance for every other reference to it too. See
;; FEATURES.md's "Struct Boxing Caveat" section for details.
(cl:defun (cl:setf w) (new-value obj!)
  "The W component of the vector."
  (cl:setf (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "W") new-value))

(cl:defun x (obj!)
  "The X component of the vector."
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "X"))

;; Note: obj! here is a boxed reference to a .NET value type (struct).
;; This setf mutates that exact boxed instance in place -- it does NOT
;; silently discard the change. However, if obj! is an alias of a shared
;; or cached value (e.g. a constant defined via defconstant), this mutates
;; that shared instance for every other reference to it too. See
;; FEATURES.md's "Struct Boxing Caveat" section for details.
(cl:defun (cl:setf x) (new-value obj!)
  "The X component of the vector."
  (cl:setf (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "X") new-value))

(cl:defun y (obj!)
  "The Y component of the vector."
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "Y"))

;; Note: obj! here is a boxed reference to a .NET value type (struct).
;; This setf mutates that exact boxed instance in place -- it does NOT
;; silently discard the change. However, if obj! is an alias of a shared
;; or cached value (e.g. a constant defined via defconstant), this mutates
;; that shared instance for every other reference to it too. See
;; FEATURES.md's "Struct Boxing Caveat" section for details.
(cl:defun (cl:setf y) (new-value obj!)
  "The Y component of the vector."
  (cl:setf (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "Y") new-value))

(cl:defun z (obj!)
  "The Z component of the vector."
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "Z"))

;; Note: obj! here is a boxed reference to a .NET value type (struct).
;; This setf mutates that exact boxed instance in place -- it does NOT
;; silently discard the change. However, if obj! is an alias of a shared
;; or cached value (e.g. a constant defined via defconstant), this mutates
;; that shared instance for every other reference to it too. See
;; FEATURES.md's "Struct Boxing Caveat" section for details.
(cl:defun (cl:setf z) (new-value obj!)
  "The Z component of the vector."
  (cl:setf (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "Z") new-value))

(cl:defun - (value cl:&optional (right cl:nil supplied-right))
  "Master wrapper for System.Numerics.Vector4.- overloads. Dispatches at runtime.

-(Vector4) -> Vector4
  Summary: Negates the specified vector.
  Returns: The negated vector.
  Parameters:
    - value (System.Numerics.Vector4): The vector to negate.

-(Vector4, Vector4) -> Vector4
  Summary: Subtracts the second vector from the first.
  Returns: The vector that results from subtracting right from left.
  Parameters:
    - left (System.Numerics.Vector4): The first vector.
    - right (System.Numerics.Vector4): The second vector.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-right (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "op_Subtraction" value right))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-right))
     (dotnet:static <type-str> "op_UnaryNegation" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR4"
                    :class-name <type-str>
                    :method-name "-"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-right (cl:list :right right)))))))

(cl:defun * (left right)
  "Master wrapper for System.Numerics.Vector4.* overloads. Dispatches at runtime.

*(Vector4, Vector4) -> Vector4
  Summary: Returns a new vector whose values are the product of each pair of elements in two specified vectors.
  Returns: The element-wise product vector.
  Parameters:
    - left (System.Numerics.Vector4): The first vector.
    - right (System.Numerics.Vector4): The second vector.

*(Vector4, Single) -> Vector4
  Summary: Multiples the specified vector by the specified scalar value.
  Returns: The scaled vector.
  Parameters:
    - left (System.Numerics.Vector4): The vector.
    - right (System.Single): The scalar value.

*(Single, Vector4) -> Vector4
  Summary: Multiples the scalar value by the specified vector.
  Returns: The scaled vector.
  Parameters:
    - left (System.Single): The vector.
    - right (System.Numerics.Vector4): The scalar value.
"
  (cl:cond
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "op_Multiply" left right))
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:numberp right))
     (dotnet:static <type-str> "op_Multiply" left right))
    ((cl:and (cl:numberp left) (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "op_Multiply" left right))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR4"
                    :class-name <type-str>
                    :method-name "*"
                    :supplied-args (cl:append (cl:list :left left) (cl:list :right right))))))

(cl:defun / (left right)
  "Master wrapper for System.Numerics.Vector4./ overloads. Dispatches at runtime.

/(Vector4, Vector4) -> Vector4
  Summary: Divides the first vector by the second.
  Returns: The vector that results from dividing left by right.
  Parameters:
    - left (System.Numerics.Vector4): The first vector.
    - right (System.Numerics.Vector4): The second vector.

/(Vector4, Single) -> Vector4
  Summary: Divides the specified vector by a specified scalar value.
  Returns: The result of the division.
  Parameters:
    - value1 (System.Numerics.Vector4): The vector.
    - value2 (System.Single): The scalar value.
"
  (cl:cond
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "op_Division" left right))
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:numberp right))
     (dotnet:static <type-str> "op_Division" left right))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR4"
                    :class-name <type-str>
                    :method-name "/"
                    :supplied-args (cl:append (cl:list :left left) (cl:list :right right))))))

(cl:defun & (left right)
  "Summary: Computes the bitwise-and of two vectors.
Returns: The bitwise-and of left and right.
Parameters:
  - left (System.Numerics.Vector4): The vector to bitwise-and with right.
  - right (System.Numerics.Vector4): The vector to bitwise-and with left.
"
  (dotnet:static <type-str> "op_BitwiseAnd" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun ^ (left right)
  "Summary: Computes the exclusive-or of two vectors.
Returns: The exclusive-or of left and right.
Parameters:
  - left (System.Numerics.Vector4): The vector to exclusive-or with right.
  - right (System.Numerics.Vector4): The vector to exclusive-or with left.
"
  (dotnet:static <type-str> "op_ExclusiveOr" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun + (value cl:&optional (right cl:nil supplied-right))
  "Master wrapper for System.Numerics.Vector4.+ overloads. Dispatches at runtime.

+(Vector4) -> Vector4
  Summary: Returns a given vector unchanged.
  Returns: value
  Parameters:
    - value (System.Numerics.Vector4): The vector.

+(Vector4, Vector4) -> Vector4
  Summary: Adds two vectors together.
  Returns: The summed vector.
  Parameters:
    - left (System.Numerics.Vector4): The first vector to add.
    - right (System.Numerics.Vector4): The second vector to add.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-right (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "op_Addition" value right))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-right))
     (dotnet:static <type-str> "op_UnaryPlus" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR4"
                    :class-name <type-str>
                    :method-name "+"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-right (cl:list :right right)))))))

(cl:defun << (value shift-amount)
  "Summary: Shifts each element of a vector left by the specified amount.
Returns: A vector whose elements where shifted left by shiftCount.
Parameters:
  - value (System.Numerics.Vector4): The vector whose elements are to be shifted.
  - shift-amount (System.Int32): 
"
  (dotnet:static <type-str> "op_LeftShift" (cl:the (dotnet "System.Numerics.Vector4") value) (cl:the (dotnet "System.Int32") shift-amount)))

(cl:defun = (left right)
  "Summary: Returns a value that indicates whether each pair of elements in two specified vectors is equal.
Returns: if left and right are equal; otherwise, .
Parameters:
  - left (System.Numerics.Vector4): The first vector to compare.
  - right (System.Numerics.Vector4): The second vector to compare.
"
  (dotnet:static <type-str> "op_Equality" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun >> (value shift-amount)
  "Summary: Shifts (signed) each element of a vector right by the specified amount.
Returns: A vector whose elements where shifted right by shiftCount.
Parameters:
  - value (System.Numerics.Vector4): The vector whose elements are to be shifted.
  - shift-amount (System.Int32): 
"
  (dotnet:static <type-str> "op_RightShift" (cl:the (dotnet "System.Numerics.Vector4") value) (cl:the (dotnet "System.Int32") shift-amount)))

(cl:defun >>> (value shift-amount)
  "Summary: Shifts (unsigned) each element of a vector right by the specified amount.
Returns: A vector whose elements where shifted right by shiftCount.
Parameters:
  - value (System.Numerics.Vector4): The vector whose elements are to be shifted.
  - shift-amount (System.Int32): 
"
  (dotnet:static <type-str> "op_UnsignedRightShift" (cl:the (dotnet "System.Numerics.Vector4") value) (cl:the (dotnet "System.Int32") shift-amount)))

(cl:defun | (left right)
  "Summary: Computes the bitwise-or of two vectors.
Returns: The bitwise-or of left and right.
Parameters:
  - left (System.Numerics.Vector4): The vector to bitwise-or with right.
  - right (System.Numerics.Vector4): The vector to bitwise-or with left.
"
  (dotnet:static <type-str> "op_BitwiseOr" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun ~ (value)
  "Summary: Computes the ones-complement of a vector.
Returns: A vector whose elements are the ones-complement of the corresponding elements in vector.
Parameters:
  - value (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "op_OnesComplement" (cl:the (dotnet "System.Numerics.Vector4") value)))

(cl:defun abs (value)
  "Summary: Returns a vector whose elements are the absolute values of each of the specified vector's elements.
Returns: The absolute value vector.
Parameters:
  - value (System.Numerics.Vector4): A vector.
"
  (dotnet:static <type-str> "Abs" (cl:the (dotnet "System.Numerics.Vector4") value)))

(cl:defun add (left right)
  "Summary: Adds two vectors together.
Returns: The summed vector.
Parameters:
  - left (System.Numerics.Vector4): The first vector to add.
  - right (System.Numerics.Vector4): The second vector to add.
"
  (dotnet:static <type-str> "Add" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun all (vector value)
  "Parameters:
  - vector (System.Numerics.Vector4): 
  - value (System.Single): 
"
  (dotnet:static <type-str> "All" (cl:the (dotnet "System.Numerics.Vector4") vector) (cl:the (dotnet "System.Single") value)))

(cl:defun all-where-all-bits-set (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "AllWhereAllBitsSet" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun and-not (left right)
  "Summary: Computes the bitwise-and of a given vector and the ones complement of another vector.
Returns: The bitwise-and of left and the ones-complement of right.
Parameters:
  - left (System.Numerics.Vector4): The vector to bitwise-and with right.
  - right (System.Numerics.Vector4): The vector to that is ones-complemented before being bitwise-and with left.
"
  (dotnet:static <type-str> "AndNot" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun any (vector value)
  "Parameters:
  - vector (System.Numerics.Vector4): 
  - value (System.Single): 
"
  (dotnet:static <type-str> "Any" (cl:the (dotnet "System.Numerics.Vector4") vector) (cl:the (dotnet "System.Single") value)))

(cl:defun any-where-all-bits-set (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "AnyWhereAllBitsSet" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun bitwise-and (left right)
  "Summary: Computes the bitwise-and of two vectors.
Returns: The bitwise-and of left and right.
Parameters:
  - left (System.Numerics.Vector4): The vector to bitwise-and with right.
  - right (System.Numerics.Vector4): The vector to bitwise-and with left.
"
  (dotnet:static <type-str> "BitwiseAnd" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun bitwise-or (left right)
  "Summary: Computes the bitwise-or of two vectors.
Returns: The bitwise-or of left and right.
Parameters:
  - left (System.Numerics.Vector4): The vector to bitwise-or with right.
  - right (System.Numerics.Vector4): The vector to bitwise-or with left.
"
  (dotnet:static <type-str> "BitwiseOr" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun clamp (value1 min max)
  "Summary: Restricts a vector between a minimum and a maximum value.
Returns: The restricted vector.
Parameters:
  - value1 (System.Numerics.Vector4): The vector to restrict.
  - min (System.Numerics.Vector4): The minimum value.
  - max (System.Numerics.Vector4): The maximum value.
"
  (dotnet:static <type-str> "Clamp" (cl:the (dotnet "System.Numerics.Vector4") value1) (cl:the (dotnet "System.Numerics.Vector4") min) (cl:the (dotnet "System.Numerics.Vector4") max)))

(cl:defun clamp-native (value1 min max)
  "Summary: Restricts a vector between a minimum and a maximum value using platform specific behavior for NaN and NegativeZero..
Returns: The restricted vector.
Parameters:
  - value1 (System.Numerics.Vector4): 
  - min (System.Numerics.Vector4): The minimum value.
  - max (System.Numerics.Vector4): The maximum value.
"
  (dotnet:static <type-str> "ClampNative" (cl:the (dotnet "System.Numerics.Vector4") value1) (cl:the (dotnet "System.Numerics.Vector4") min) (cl:the (dotnet "System.Numerics.Vector4") max)))

(cl:defun conditional-select (condition left right)
  "Summary: Conditionally selects a value from two vectors on a bitwise basis.
Returns: A vector whose bits come from left or right based on the value of condition.
Parameters:
  - condition (System.Numerics.Vector4): The mask that is used to select a value from left or right.
  - left (System.Numerics.Vector4): The vector that is selected when the corresponding bit in condition is one.
  - right (System.Numerics.Vector4): The vector that is selected when the corresponding bit in condition is zero.
"
  (dotnet:static <type-str> "ConditionalSelect" (cl:the (dotnet "System.Numerics.Vector4") condition) (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun copy-sign (value sign)
  "Summary: Copies the per-element sign of a vector to the per-element sign of another vector.
Returns: A vector with the magnitude of value and the sign of sign.
Parameters:
  - value (System.Numerics.Vector4): The vector whose magnitude is used in the result.
  - sign (System.Numerics.Vector4): The vector whose sign is used in the result.
"
  (dotnet:static <type-str> "CopySign" (cl:the (dotnet "System.Numerics.Vector4") value) (cl:the (dotnet "System.Numerics.Vector4") sign)))

(cl:defun copy-to (obj! array cl:&optional (index cl:nil supplied-index))
  "Master wrapper for System.Numerics.Vector4.CopyTo overloads. Dispatches at runtime.

CopyTo(Single[]) -> Void
  Summary: Copies the elements of the vector to a specified array.
  Parameters:
    - array (System.Single[]): The destination array.

CopyTo(Single]) -> Void
  Summary: Copies the vector to the given System.Span`1. The length of the destination span must be at least 4.
  Parameters:
    - destination (System.Span`1[System.Single]): The destination span which the values are copied into.

CopyTo(Single[], Int32) -> Void
  Summary: Copies the elements of the vector to a specified array starting at a specified index position.
  Parameters:
    - array (System.Single[]): The destination array.
    - index (System.Int32): The index at which to copy the first element of the vector.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-index (cl:numberp index))
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "CopyTo" array index))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:not supplied-index))
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "CopyTo" array))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:not supplied-index))
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "CopyTo" array))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR4"
                    :class-name <type-str>
                    :method-name "CopyTo"
                    :supplied-args (cl:append (cl:list :array array) (cl:when supplied-index (cl:list :index index)))))))

(cl:defun cos (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "Cos" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun count (vector value)
  "Parameters:
  - vector (System.Numerics.Vector4): 
  - value (System.Single): 
"
  (dotnet:static <type-str> "Count" (cl:the (dotnet "System.Numerics.Vector4") vector) (cl:the (dotnet "System.Single") value)))

(cl:defun count-where-all-bits-set (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "CountWhereAllBitsSet" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun create (value cl:&optional (w cl:nil supplied-w) (w2 cl:nil supplied-w2) (w3 cl:nil supplied-w3))
  "Master wrapper for System.Numerics.Vector4.Create overloads. Dispatches at runtime.

Create(Single) -> Vector4
  Summary: Creates a new System.Numerics.Vector4 object whose four elements have the same value.
  Returns: A new System.Numerics.Vector4 whose four elements have the same value.
  Parameters:
    - value (System.Single): The value to assign to all four elements.

Create(Single]) -> Vector4
  Summary: Constructs a vector from the given System.ReadOnlySpan`1. The span must contain at least 4 elements.
  Returns: A new System.Numerics.Vector4 whose elements have the specified values.
  Parameters:
    - values (System.ReadOnlySpan`1[System.Single]): The span of elements to assign to the vector.

Create(Vector3, Single) -> Vector4
  Summary: Constructs a new System.Numerics.Vector4 object from the specified System.Numerics.Vector3 object and a W component.
  Returns: A new System.Numerics.Vector4 from the specified System.Numerics.Vector3 object and a W component.
  Parameters:
    - vector (System.Numerics.Vector3): The vector to use for the X, Y, and Z components.
    - w (System.Single): The W component.

Create(Vector2, Single, Single) -> Vector4
  Summary: Creates a new System.Numerics.Vector4 object from the specified System.Numerics.Vector2 object and a Z and a W component.
  Returns: A new System.Numerics.Vector4 from the specified System.Numerics.Vector2 object and a Z and a W component.
  Parameters:
    - vector (System.Numerics.Vector2): The vector to use for the X and Y components.
    - z (System.Single): The Z component.
    - w (System.Single): The W component.

Create(Single, Single, Single, Single) -> Vector4
  Summary: Creates a vector whose elements have the specified values.
  Returns: A new System.Numerics.Vector4 whose elements have the specified values.
  Parameters:
    - x (System.Single): The value to assign to the System.Numerics.Vector4.X field.
    - y (System.Single): The value to assign to the System.Numerics.Vector4.Y field.
    - z (System.Single): The value to assign to the System.Numerics.Vector4.Z field.
    - w (System.Single): The value to assign to the System.Numerics.Vector4.W field.
"
  (cl:cond
    ((cl:and (cl:numberp value) supplied-w (cl:numberp w) supplied-w2 (cl:numberp w2) supplied-w3 (cl:numberp w3))
     (dotnet:static <type-str> "Create" value w w2 w3))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-w (cl:numberp w) supplied-w2 (cl:numberp w2) (cl:not supplied-w3))
     (dotnet:static <type-str> "Create" value w w2))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-w (cl:numberp w) (cl:not supplied-w2) (cl:not supplied-w3))
     (dotnet:static <type-str> "Create" value w))
    ((cl:and (cl:numberp value) (cl:not supplied-w) (cl:not supplied-w2) (cl:not supplied-w3))
     (dotnet:static <type-str> "Create" value))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-w) (cl:not supplied-w2) (cl:not supplied-w3))
     (dotnet:static <type-str> "Create" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR4"
                    :class-name <type-str>
                    :method-name "Create"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-w (cl:list :w w)) (cl:when supplied-w2 (cl:list :w2 w2)) (cl:when supplied-w3 (cl:list :w3 w3)))))))

(cl:defun create-scalar (x)
  "Summary: Creates a vector with System.Numerics.Vector4.X initialized to the specified value and the remaining elements initialized to zero.
Returns: A System.Numerics.Vector4 with System.Numerics.Vector4.X initialized x and the remaining elements initialized to zero.
Parameters:
  - x (System.Single): The value to assign to the System.Numerics.Vector4.X field.
"
  (dotnet:static <type-str> "CreateScalar" (cl:the (dotnet "System.Single") x)))

(cl:defun create-scalar-unsafe (x)
  "Summary: Creates a vector with System.Numerics.Vector4.X initialized to the specified value and the remaining elements left uninitialized.
Returns: A System.Numerics.Vector4 with System.Numerics.Vector4.X initialized x and the remaining elements left uninitialized.
Parameters:
  - x (System.Single): The value to assign to the System.Numerics.Vector4.X field.
"
  (dotnet:static <type-str> "CreateScalarUnsafe" (cl:the (dotnet "System.Single") x)))

(cl:defun cross (vector1 vector2)
  "Summary: Computes the cross product of two vectors. For homogeneous coordinates, the product of the weights is the new weight for the resulting product.
Returns: The cross product.
Parameters:
  - vector1 (System.Numerics.Vector4): The first vector.
  - vector2 (System.Numerics.Vector4): The second vector.
"
  (dotnet:static <type-str> "Cross" (cl:the (dotnet "System.Numerics.Vector4") vector1) (cl:the (dotnet "System.Numerics.Vector4") vector2)))

(cl:defun degrees-to-radians (degrees)
  "Parameters:
  - degrees (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "DegreesToRadians" (cl:the (dotnet "System.Numerics.Vector4") degrees)))

(cl:defun distance (value1 value2)
  "Summary: Computes the Euclidean distance between the two given points.
Returns: The distance.
Parameters:
  - value1 (System.Numerics.Vector4): The first point.
  - value2 (System.Numerics.Vector4): The second point.
"
  (dotnet:static <type-str> "Distance" (cl:the (dotnet "System.Numerics.Vector4") value1) (cl:the (dotnet "System.Numerics.Vector4") value2)))

(cl:defun distance-squared (value1 value2)
  "Summary: Returns the Euclidean distance squared between two specified points.
Returns: The distance squared.
Parameters:
  - value1 (System.Numerics.Vector4): The first point.
  - value2 (System.Numerics.Vector4): The second point.
"
  (dotnet:static <type-str> "DistanceSquared" (cl:the (dotnet "System.Numerics.Vector4") value1) (cl:the (dotnet "System.Numerics.Vector4") value2)))

(cl:defun divide (left right)
  "Master wrapper for System.Numerics.Vector4.Divide overloads. Dispatches at runtime.

Divide(Vector4, Vector4) -> Vector4
  Summary: Divides the first vector by the second.
  Returns: The vector resulting from the division.
  Parameters:
    - left (System.Numerics.Vector4): The first vector.
    - right (System.Numerics.Vector4): The second vector.

Divide(Vector4, Single) -> Vector4
  Summary: Divides the specified vector by a specified scalar value.
  Returns: The vector that results from the division.
  Parameters:
    - left (System.Numerics.Vector4): The vector.
    - divisor (System.Single): The scalar value.
"
  (cl:cond
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "Divide" left right))
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:numberp right))
     (dotnet:static <type-str> "Divide" left right))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR4"
                    :class-name <type-str>
                    :method-name "Divide"
                    :supplied-args (cl:append (cl:list :left left) (cl:list :right right))))))

(cl:defun dot (vector1 vector2)
  "Summary: Returns the dot product of two vectors.
Returns: The dot product.
Parameters:
  - vector1 (System.Numerics.Vector4): The first vector.
  - vector2 (System.Numerics.Vector4): The second vector.
"
  (dotnet:static <type-str> "Dot" (cl:the (dotnet "System.Numerics.Vector4") vector1) (cl:the (dotnet "System.Numerics.Vector4") vector2)))

(cl:defun equals (obj! other)
  "Master wrapper for System.Numerics.Vector4.Equals overloads. Dispatches at runtime.

Equals(Vector4) -> Boolean
  Summary: Returns a value that indicates whether this instance and another vector are equal.
  Returns: if the two vectors are equal; otherwise, .
  Parameters:
    - other (System.Numerics.Vector4): The other vector.

Equals(Object) -> Boolean
  Summary: Returns a value that indicates whether this instance and a specified object are equal.
  Returns: if the current instance and obj are equal; otherwise, . If obj is , the method returns .
  Parameters:
    - obj (System.Object): The object to compare with the current instance.
"
  (cl:cond
    ((cl:and (cl:or (cl:null other) (dotnet:object-type other)))
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "Equals" other))
    ((cl:and (cl:or (cl:null other) (dotnet:object-type other)))
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "Equals" other))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR4"
                    :class-name <type-str>
                    :method-name "Equals"
                    :supplied-args (cl:append (cl:list :other other))))))

(cl:defun equals* (left right)
  "Summary: Compares two vectors to determine if they are equal on a per-element basis.
Returns: A vector whose elements are all-bits-set or zero, depending on if the corresponding elements in left and right were equal.
Parameters:
  - left (System.Numerics.Vector4): The vector to compare with right.
  - right (System.Numerics.Vector4): The vector to compare with left.
"
  (dotnet:static <type-str> "Equals" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun equals-all (left right)
  "Summary: Compares two vectors to determine if all elements are equal.
Returns: true if all elements in left were equal to the corresponding element in right.
Parameters:
  - left (System.Numerics.Vector4): The vector to compare with right.
  - right (System.Numerics.Vector4): The vector to compare with left.
"
  (dotnet:static <type-str> "EqualsAll" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun equals-any (left right)
  "Summary: Compares two vectors to determine if any elements are equal.
Returns: true if any elements in left was equal to the corresponding element in right.
Parameters:
  - left (System.Numerics.Vector4): The vector to compare with right.
  - right (System.Numerics.Vector4): The vector to compare with left.
"
  (dotnet:static <type-str> "EqualsAny" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun exp (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "Exp" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun fused-multiply-add (left right addend)
  "Parameters:
  - left (System.Numerics.Vector4): 
  - right (System.Numerics.Vector4): 
  - addend (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "FusedMultiplyAdd" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right) (cl:the (dotnet "System.Numerics.Vector4") addend)))

(cl:defun get-hash-code (obj!)
  "Summary: Returns the hash code for this instance.
Returns: The hash code.
"
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "GetHashCode"))

(cl:defun greater-than (left right)
  "Summary: Compares two vectors to determine which is greater on a per-element basis.
Returns: A vector whose elements are all-bits-set or zero, depending on if which of the corresponding elements in left and right were greater.
Parameters:
  - left (System.Numerics.Vector4): The vector to compare with left.
  - right (System.Numerics.Vector4): The vector to compare with right.
"
  (dotnet:static <type-str> "GreaterThan" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun greater-than-all (left right)
  "Summary: Compares two vectors to determine if all elements are greater.
Returns: true if all elements in left were greater than the corresponding element in right.
Parameters:
  - left (System.Numerics.Vector4): The vector to compare with right.
  - right (System.Numerics.Vector4): The vector to compare with left.
"
  (dotnet:static <type-str> "GreaterThanAll" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun greater-than-any (left right)
  "Summary: Compares two vectors to determine if any elements are greater.
Returns: true if any elements in left was greater than the corresponding element in right.
Parameters:
  - left (System.Numerics.Vector4): The vector to compare with right.
  - right (System.Numerics.Vector4): The vector to compare with left.
"
  (dotnet:static <type-str> "GreaterThanAny" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun greater-than-or-equal (left right)
  "Summary: Compares two vectors to determine which is greater or equal on a per-element basis.
Returns: A vector whose elements are all-bits-set or zero, depending on if which of the corresponding elements in left and right were greater or equal.
Parameters:
  - left (System.Numerics.Vector4): The vector to compare with left.
  - right (System.Numerics.Vector4): The vector to compare with right.
"
  (dotnet:static <type-str> "GreaterThanOrEqual" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun greater-than-or-equal-all (left right)
  "Summary: Compares two vectors to determine if all elements are greater or equal.
Returns: true if all elements in left were greater than or equal to the corresponding element in right.
Parameters:
  - left (System.Numerics.Vector4): The vector to compare with right.
  - right (System.Numerics.Vector4): The vector to compare with left.
"
  (dotnet:static <type-str> "GreaterThanOrEqualAll" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun greater-than-or-equal-any (left right)
  "Summary: Compares two vectors to determine if any elements are greater or equal.
Returns: true if any elements in left was greater than or equal to the corresponding element in right.
Parameters:
  - left (System.Numerics.Vector4): The vector to compare with right.
  - right (System.Numerics.Vector4): The vector to compare with left.
"
  (dotnet:static <type-str> "GreaterThanOrEqualAny" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun hypot (x y)
  "Parameters:
  - x (System.Numerics.Vector4): 
  - y (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "Hypot" (cl:the (dotnet "System.Numerics.Vector4") x) (cl:the (dotnet "System.Numerics.Vector4") y)))

(cl:defun index-of (vector value)
  "Parameters:
  - vector (System.Numerics.Vector4): 
  - value (System.Single): 
"
  (dotnet:static <type-str> "IndexOf" (cl:the (dotnet "System.Numerics.Vector4") vector) (cl:the (dotnet "System.Single") value)))

(cl:defun index-of-where-all-bits-set (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "IndexOfWhereAllBitsSet" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun even-integer? (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "IsEvenInteger" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun finite? (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "IsFinite" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun infinity? (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "IsInfinity" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun integer? (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "IsInteger" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun nan? (vector)
  "Summary: Determines which elements in a vector are NaN.
Returns: A vector whose elements are all-bits-set or zero, depending on if the corresponding elements in vector were NaN.
Parameters:
  - vector (System.Numerics.Vector4): The vector to be checked.
"
  (dotnet:static <type-str> "IsNaN" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun negative? (vector)
  "Summary: Determines which elements in a vector represents negative real numbers.
Returns: A vector whose elements are all-bits-set or zero, depending on if the corresponding elements in vector were negative.
Parameters:
  - vector (System.Numerics.Vector4): The vector to be checked.
"
  (dotnet:static <type-str> "IsNegative" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun negative-infinity? (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "IsNegativeInfinity" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun normal? (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "IsNormal" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun odd-integer? (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "IsOddInteger" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun positive? (vector)
  "Summary: Determines which elements in a vector represents positive real numbers.
Returns: A vector whose elements are all-bits-set or zero, depending on if the corresponding elements in vector were positive.
Parameters:
  - vector (System.Numerics.Vector4): The vector to be checked.
"
  (dotnet:static <type-str> "IsPositive" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun positive-infinity? (vector)
  "Summary: Determines which elements in a vector are positive infinity.
Returns: A vector whose elements are all-bits-set or zero, depending on if the corresponding elements in vector were positive infinity.
Parameters:
  - vector (System.Numerics.Vector4): The vector to be checked.
"
  (dotnet:static <type-str> "IsPositiveInfinity" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun subnormal? (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "IsSubnormal" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun zero? (vector)
  "Summary: Determines which elements in a vector are zero.
Returns: A vector whose elements are all-bits-set or zero, depending on if the corresponding elements in vector were zero.
Parameters:
  - vector (System.Numerics.Vector4): The vector to be checked.
"
  (dotnet:static <type-str> "IsZero" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun last-index-of (vector value)
  "Parameters:
  - vector (System.Numerics.Vector4): 
  - value (System.Single): 
"
  (dotnet:static <type-str> "LastIndexOf" (cl:the (dotnet "System.Numerics.Vector4") vector) (cl:the (dotnet "System.Single") value)))

(cl:defun last-index-of-where-all-bits-set (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "LastIndexOfWhereAllBitsSet" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun length (obj!)
  "Summary: Returns the length of this vector object.
Returns: The vector's length.
"
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "Length"))

(cl:defun length-squared (obj!)
  "Summary: Returns the length of the vector squared.
Returns: The vector's length squared.
"
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "LengthSquared"))

(cl:defun lerp (value1 value2 amount)
  "Master wrapper for System.Numerics.Vector4.Lerp overloads. Dispatches at runtime.

Lerp(Vector4, Vector4, Single) -> Vector4
  Summary: Performs a linear interpolation between two vectors based on the given weighting.
  Returns: The interpolated vector.
  Parameters:
    - value1 (System.Numerics.Vector4): The first vector.
    - value2 (System.Numerics.Vector4): The second vector.
    - amount (System.Single): A value between 0 and 1 that indicates the weight of value2.

Lerp(Vector4, Vector4, Vector4) -> Vector4
  Parameters:
    - value1 (System.Numerics.Vector4): 
    - value2 (System.Numerics.Vector4): 
    - amount (System.Numerics.Vector4): 
"
  (cl:cond
    ((cl:and (cl:or (cl:null value1) (dotnet:object-type value1)) (cl:or (cl:null value2) (dotnet:object-type value2)) (cl:numberp amount))
     (dotnet:static <type-str> "Lerp" value1 value2 amount))
    ((cl:and (cl:or (cl:null value1) (dotnet:object-type value1)) (cl:or (cl:null value2) (dotnet:object-type value2)) (cl:or (cl:null amount) (dotnet:object-type amount)))
     (dotnet:static <type-str> "Lerp" value1 value2 amount))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR4"
                    :class-name <type-str>
                    :method-name "Lerp"
                    :supplied-args (cl:append (cl:list :value1 value1) (cl:list :value2 value2) (cl:list :amount amount))))))

(cl:defun less-than (left right)
  "Summary: Compares two vectors to determine which is less on a per-element basis.
Returns: A vector whose elements are all-bits-set or zero, depending on if which of the corresponding elements in left and right were less.
Parameters:
  - left (System.Numerics.Vector4): The vector to compare with left.
  - right (System.Numerics.Vector4): The vector to compare with right.
"
  (dotnet:static <type-str> "LessThan" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun less-than-all (left right)
  "Summary: Compares two vectors to determine if all elements are less.
Returns: true if all elements in left were less than the corresponding element in right.
Parameters:
  - left (System.Numerics.Vector4): The vector to compare with right.
  - right (System.Numerics.Vector4): The vector to compare with left.
"
  (dotnet:static <type-str> "LessThanAll" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun less-than-any (left right)
  "Summary: Compares two vectors to determine if any elements are less.
Returns: true if any elements in left was less than the corresponding element in right.
Parameters:
  - left (System.Numerics.Vector4): The vector to compare with right.
  - right (System.Numerics.Vector4): The vector to compare with left.
"
  (dotnet:static <type-str> "LessThanAny" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun less-than-or-equal (left right)
  "Summary: Compares two vectors to determine which is less or equal on a per-element basis.
Returns: A vector whose elements are all-bits-set or zero, depending on if which of the corresponding elements in left and right were less or equal.
Parameters:
  - left (System.Numerics.Vector4): The vector to compare with left.
  - right (System.Numerics.Vector4): The vector to compare with right.
"
  (dotnet:static <type-str> "LessThanOrEqual" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun less-than-or-equal-all (left right)
  "Summary: Compares two vectors to determine if all elements are less or equal.
Returns: true if all elements in left were less than or equal to the corresponding element in right.
Parameters:
  - left (System.Numerics.Vector4): The vector to compare with right.
  - right (System.Numerics.Vector4): The vector to compare with left.
"
  (dotnet:static <type-str> "LessThanOrEqualAll" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun less-than-or-equal-any (left right)
  "Summary: Compares two vectors to determine if any elements are less or equal.
Returns: true if any elements in left was less than or equal to the corresponding element in right.
Parameters:
  - left (System.Numerics.Vector4): The vector to compare with right.
  - right (System.Numerics.Vector4): The vector to compare with left.
"
  (dotnet:static <type-str> "LessThanOrEqualAny" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun load (source)
  "Summary: Loads a vector from the given source.
Returns: The vector loaded from source.
Parameters:
  - source (System.Single*): The source from which the vector will be loaded.
"
  (dotnet:static <type-str> "Load" (cl:the (dotnet "System.Single*") source)))

(cl:defun load-aligned (source)
  "Summary: Loads a vector from the given aligned source.
Returns: The vector loaded from source.
Parameters:
  - source (System.Single*): The aligned source from which the vector will be loaded.
"
  (dotnet:static <type-str> "LoadAligned" (cl:the (dotnet "System.Single*") source)))

(cl:defun load-aligned-non-temporal (source)
  "Summary: Loads a vector from the given aligned source.
Returns: The vector loaded from source.
Parameters:
  - source (System.Single*): The aligned source from which the vector will be loaded.
"
  (dotnet:static <type-str> "LoadAlignedNonTemporal" (cl:the (dotnet "System.Single*") source)))

;; The following C# System.Numerics.Vector4.LoadUnsafe overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   LoadUnsafe(ref Single&) -> Vector4
;;   LoadUnsafe(ref Single&, UIntPtr) -> Vector4

(cl:defun log (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "Log" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun log2 (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "Log2" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun max (value1 value2)
  "Summary: Returns a vector whose elements are the maximum of each of the pairs of elements in two specified vectors.
Returns: The maximized vector.
Parameters:
  - value1 (System.Numerics.Vector4): The first vector.
  - value2 (System.Numerics.Vector4): The second vector.
"
  (dotnet:static <type-str> "Max" (cl:the (dotnet "System.Numerics.Vector4") value1) (cl:the (dotnet "System.Numerics.Vector4") value2)))

(cl:defun max-magnitude (value1 value2)
  "Summary: Compares two vectors to compute which has the greater magnitude on a per-element basis.
Returns: A vector where the corresponding element comes from left if it has a greater magnitude than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector4): 
  - value2 (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "MaxMagnitude" (cl:the (dotnet "System.Numerics.Vector4") value1) (cl:the (dotnet "System.Numerics.Vector4") value2)))

(cl:defun max-magnitude-number (value1 value2)
  "Summary: Compares two vectors, on a per-element basis, to compute which has the greater magnitude and returning the other value if an input is NaN.
Returns: A vector where the corresponding element comes from left if it has a greater magnitude than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector4): 
  - value2 (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "MaxMagnitudeNumber" (cl:the (dotnet "System.Numerics.Vector4") value1) (cl:the (dotnet "System.Numerics.Vector4") value2)))

(cl:defun max-native (value1 value2)
  "Summary: Compare two vectors to determine which is greater on a per-element basis using platform specific behavior for NaN and NegativeZero.
Returns: A vector where the corresponding element comes from left if it is greater than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector4): 
  - value2 (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "MaxNative" (cl:the (dotnet "System.Numerics.Vector4") value1) (cl:the (dotnet "System.Numerics.Vector4") value2)))

(cl:defun max-number (value1 value2)
  "Summary: Compares two vectors, on a per-element basis, to compute which is greater and returning the other value if an element is NaN.
Returns: A vector where the corresponding element comes from left if it is greater than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector4): 
  - value2 (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "MaxNumber" (cl:the (dotnet "System.Numerics.Vector4") value1) (cl:the (dotnet "System.Numerics.Vector4") value2)))

(cl:defun min (value1 value2)
  "Summary: Returns a vector whose elements are the minimum of each of the pairs of elements in two specified vectors.
Returns: The minimized vector.
Parameters:
  - value1 (System.Numerics.Vector4): The first vector.
  - value2 (System.Numerics.Vector4): The second vector.
"
  (dotnet:static <type-str> "Min" (cl:the (dotnet "System.Numerics.Vector4") value1) (cl:the (dotnet "System.Numerics.Vector4") value2)))

(cl:defun min-magnitude (value1 value2)
  "Summary: Compares two vectors to compute which has the lesser magnitude on a per-element basis.
Returns: A vector where the corresponding element comes from left if it has a lesser magnitude than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector4): 
  - value2 (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "MinMagnitude" (cl:the (dotnet "System.Numerics.Vector4") value1) (cl:the (dotnet "System.Numerics.Vector4") value2)))

(cl:defun min-magnitude-number (value1 value2)
  "Summary: Compares two vectors, on a per-element basis, to compute which has the lesser magnitude and returning the other value if an input is NaN.
Returns: A vector where the corresponding element comes from left if it has a lesser magnitude than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector4): 
  - value2 (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "MinMagnitudeNumber" (cl:the (dotnet "System.Numerics.Vector4") value1) (cl:the (dotnet "System.Numerics.Vector4") value2)))

(cl:defun min-native (value1 value2)
  "Summary: Compare two vectors to determine which is lesser on a per-element basis using platform specific behavior for NaN and NegativeZero.
Returns: A vector where the corresponding element comes from left if it is lesser than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector4): 
  - value2 (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "MinNative" (cl:the (dotnet "System.Numerics.Vector4") value1) (cl:the (dotnet "System.Numerics.Vector4") value2)))

(cl:defun min-number (value1 value2)
  "Summary: Compares two vectors, on a per-element basis, to compute which is lesser and returning the other value if an element is NaN.
Returns: A vector where the corresponding element comes from left if it is lesser than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector4): 
  - value2 (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "MinNumber" (cl:the (dotnet "System.Numerics.Vector4") value1) (cl:the (dotnet "System.Numerics.Vector4") value2)))

(cl:defun multiply (left right)
  "Master wrapper for System.Numerics.Vector4.Multiply overloads. Dispatches at runtime.

Multiply(Vector4, Vector4) -> Vector4
  Summary: Returns a new vector whose values are the product of each pair of elements in two specified vectors.
  Returns: The element-wise product vector.
  Parameters:
    - left (System.Numerics.Vector4): The first vector.
    - right (System.Numerics.Vector4): The second vector.

Multiply(Vector4, Single) -> Vector4
  Summary: Multiplies a vector by a specified scalar.
  Returns: The scaled vector.
  Parameters:
    - left (System.Numerics.Vector4): The vector to multiply.
    - right (System.Single): The scalar value.

Multiply(Single, Vector4) -> Vector4
  Summary: Multiplies a scalar value by a specified vector.
  Returns: The scaled vector.
  Parameters:
    - left (System.Single): The scaled value.
    - right (System.Numerics.Vector4): The vector.
"
  (cl:cond
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "Multiply" left right))
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:numberp right))
     (dotnet:static <type-str> "Multiply" left right))
    ((cl:and (cl:numberp left) (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "Multiply" left right))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR4"
                    :class-name <type-str>
                    :method-name "Multiply"
                    :supplied-args (cl:append (cl:list :left left) (cl:list :right right))))))

(cl:defun multiply-add-estimate (left right addend)
  "Parameters:
  - left (System.Numerics.Vector4): 
  - right (System.Numerics.Vector4): 
  - addend (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "MultiplyAddEstimate" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right) (cl:the (dotnet "System.Numerics.Vector4") addend)))

(cl:defun negate (value)
  "Summary: Negates a specified vector.
Returns: The negated vector.
Parameters:
  - value (System.Numerics.Vector4): The vector to negate.
"
  (dotnet:static <type-str> "Negate" (cl:the (dotnet "System.Numerics.Vector4") value)))

(cl:defun none (vector value)
  "Parameters:
  - vector (System.Numerics.Vector4): 
  - value (System.Single): 
"
  (dotnet:static <type-str> "None" (cl:the (dotnet "System.Numerics.Vector4") vector) (cl:the (dotnet "System.Single") value)))

(cl:defun none-where-all-bits-set (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "NoneWhereAllBitsSet" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun normalize (vector)
  "Summary: Returns a vector with the same direction as the specified vector, but with a length of one.
Returns: The normalized vector.
Parameters:
  - vector (System.Numerics.Vector4): The vector to normalize.
"
  (dotnet:static <type-str> "Normalize" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun not= (left right)
  "Summary: Returns a value that indicates whether two specified vectors are not equal.
Returns: if left and right are not equal; otherwise, .
Parameters:
  - left (System.Numerics.Vector4): The first vector to compare.
  - right (System.Numerics.Vector4): The second vector to compare.
"
  (dotnet:static <type-str> "op_Inequality" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun ones-complement (value)
  "Summary: Computes the ones-complement of a vector.
Returns: A vector whose elements are the ones-complement of the corresponding elements in vector.
Parameters:
  - value (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "OnesComplement" (cl:the (dotnet "System.Numerics.Vector4") value)))

(cl:defun radians-to-degrees (radians)
  "Parameters:
  - radians (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "RadiansToDegrees" (cl:the (dotnet "System.Numerics.Vector4") radians)))

(cl:defun round (vector cl:&optional (mode cl:nil supplied-mode))
  "Master wrapper for System.Numerics.Vector4.Round overloads. Dispatches at runtime.

Round(Vector4) -> Vector4
  Parameters:
    - vector (System.Numerics.Vector4): 

Round(Vector4, MidpointRounding) -> Vector4
  Parameters:
    - vector (System.Numerics.Vector4): 
    - mode (System.MidpointRounding): 
"
  (cl:cond
    ((cl:and (cl:or (cl:null vector) (dotnet:object-type vector)) supplied-mode (cl:or (cl:null mode) (dotnet:object-type mode)))
     (dotnet:static <type-str> "Round" vector mode))
    ((cl:and (cl:or (cl:null vector) (dotnet:object-type vector)) (cl:not supplied-mode))
     (dotnet:static <type-str> "Round" vector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR4"
                    :class-name <type-str>
                    :method-name "Round"
                    :supplied-args (cl:append (cl:list :vector vector) (cl:when supplied-mode (cl:list :mode mode)))))))

(cl:defun shuffle (vector x-index y-index z-index w-index)
  "Summary: Creates a new vector by selecting values from an input vector using a set of indices.
Returns: A new vector containing the values from vector selected by the given indices.
Parameters:
  - vector (System.Numerics.Vector4): The input vector from which values are selected.
  - x-index (System.Byte): The index used to select a value from vector to be used as the value of System.Numerics.Vector4.X in the result.
  - y-index (System.Byte): The index used to select a value from vector to be used as the value of System.Numerics.Vector4.Y in the result
  - z-index (System.Byte): The index used to select a value from vector to be used as the value of System.Numerics.Vector4.Z in the result
  - w-index (System.Byte): The index used to select a value from vector to be used as the value of System.Numerics.Vector4.W in the result
"
  (dotnet:static <type-str> "Shuffle" (cl:the (dotnet "System.Numerics.Vector4") vector) (cl:the (dotnet "System.Byte") x-index) (cl:the (dotnet "System.Byte") y-index) (cl:the (dotnet "System.Byte") z-index) (cl:the (dotnet "System.Byte") w-index)))

(cl:defun sin (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "Sin" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun sin-cos (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "SinCos" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun square-root (value)
  "Summary: Returns a vector whose elements are the square root of each of a specified vector's elements.
Returns: The square root vector.
Parameters:
  - value (System.Numerics.Vector4): A vector.
"
  (dotnet:static <type-str> "SquareRoot" (cl:the (dotnet "System.Numerics.Vector4") value)))

(cl:defun subtract (left right)
  "Summary: Subtracts the second vector from the first.
Returns: The difference vector.
Parameters:
  - left (System.Numerics.Vector4): The first vector.
  - right (System.Numerics.Vector4): The second vector.
"
  (dotnet:static <type-str> "Subtract" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

(cl:defun sum (value)
  "Summary: Computes the sum of all elements in a vector.
Returns: The sum of all elements in vector.
Parameters:
  - value (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "Sum" (cl:the (dotnet "System.Numerics.Vector4") value)))

(cl:defun to-string (obj! cl:&optional (format cl:nil supplied-format) (format-provider cl:nil supplied-format-provider))
  "Master wrapper for System.Numerics.Vector4.ToString overloads. Dispatches at runtime.

ToString() -> String
  Summary: Returns the string representation of the current instance using default formatting.
  Returns: The string representation of the current instance.

ToString(String) -> String
  Summary: Returns the string representation of the current instance using the specified format string to format individual elements.
  Returns: The string representation of the current instance.
  Parameters:
    - format (System.String): A standard or custom numeric format string that defines the format of individual elements.

ToString(String, IFormatProvider) -> String
  Summary: Returns the string representation of the current instance using the specified format string to format individual elements and the specified format provider to define culture-specific formatting.
  Returns: The string representation of the current instance.
  Parameters:
    - format (System.String): A standard or custom numeric format string that defines the format of individual elements.
    - format-provider (System.IFormatProvider): A format provider that supplies culture-specific formatting information.
"
  (cl:cond
    ((cl:and supplied-format (cl:stringp format) supplied-format-provider (cl:or (cl:null format-provider) (dotnet:object-type format-provider)))
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "ToString" format format-provider))
    ((cl:and supplied-format (cl:stringp format) (cl:not supplied-format-provider))
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "ToString" format))
    ((cl:and (cl:not supplied-format) (cl:not supplied-format-provider))
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "ToString"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR4"
                    :class-name <type-str>
                    :method-name "ToString"
                    :supplied-args (cl:append (cl:when supplied-format (cl:list :format format)) (cl:when supplied-format-provider (cl:list :format-provider format-provider)))))))

(cl:defun transform (position matrix)
  "Master wrapper for System.Numerics.Vector4.Transform overloads. Dispatches at runtime.

Transform(Vector2, Matrix4x4) -> Vector4
  Summary: Transforms a two-dimensional vector by a specified 4x4 matrix.
  Returns: The transformed vector.
  Parameters:
    - position (System.Numerics.Vector2): The vector to transform.
    - matrix (System.Numerics.Matrix4x4): The transformation matrix.

Transform(Vector2, Quaternion) -> Vector4
  Summary: Transforms a two-dimensional vector by the specified Quaternion rotation value.
  Returns: The transformed vector.
  Parameters:
    - value (System.Numerics.Vector2): The vector to rotate.
    - rotation (System.Numerics.Quaternion): The rotation to apply.

Transform(Vector3, Matrix4x4) -> Vector4
  Summary: Transforms a three-dimensional vector by a specified 4x4 matrix.
  Returns: The transformed vector.
  Parameters:
    - position (System.Numerics.Vector3): The vector to transform.
    - matrix (System.Numerics.Matrix4x4): The transformation matrix.

Transform(Vector3, Quaternion) -> Vector4
  Summary: Transforms a three-dimensional vector by the specified Quaternion rotation value.
  Returns: The transformed vector.
  Parameters:
    - value (System.Numerics.Vector3): The vector to rotate.
    - rotation (System.Numerics.Quaternion): The rotation to apply.

Transform(Vector4, Matrix4x4) -> Vector4
  Summary: Transforms a four-dimensional vector by a specified 4x4 matrix.
  Returns: The transformed vector.
  Parameters:
    - vector (System.Numerics.Vector4): The vector to transform.
    - matrix (System.Numerics.Matrix4x4): The transformation matrix.

Transform(Vector4, Quaternion) -> Vector4
  Summary: Transforms a four-dimensional vector by the specified Quaternion rotation value.
  Returns: The transformed vector.
  Parameters:
    - value (System.Numerics.Vector4): The vector to rotate.
    - rotation (System.Numerics.Quaternion): The rotation to apply.
"
  (cl:cond
    ((cl:and (cl:or (cl:null position) (dotnet:object-type position)) (cl:or (cl:null matrix) (dotnet:object-type matrix)))
     (dotnet:static <type-str> "Transform" position matrix))
    ((cl:and (cl:or (cl:null position) (dotnet:object-type position)) (cl:or (cl:null matrix) (dotnet:object-type matrix)))
     (dotnet:static <type-str> "Transform" position matrix))
    ((cl:and (cl:or (cl:null position) (dotnet:object-type position)) (cl:or (cl:null matrix) (dotnet:object-type matrix)))
     (dotnet:static <type-str> "Transform" position matrix))
    ((cl:and (cl:or (cl:null position) (dotnet:object-type position)) (cl:or (cl:null matrix) (dotnet:object-type matrix)))
     (dotnet:static <type-str> "Transform" position matrix))
    ((cl:and (cl:or (cl:null position) (dotnet:object-type position)) (cl:or (cl:null matrix) (dotnet:object-type matrix)))
     (dotnet:static <type-str> "Transform" position matrix))
    ((cl:and (cl:or (cl:null position) (dotnet:object-type position)) (cl:or (cl:null matrix) (dotnet:object-type matrix)))
     (dotnet:static <type-str> "Transform" position matrix))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR4"
                    :class-name <type-str>
                    :method-name "Transform"
                    :supplied-args (cl:append (cl:list :position position) (cl:list :matrix matrix))))))

(cl:defun truncate (vector)
  "Parameters:
  - vector (System.Numerics.Vector4): 
"
  (dotnet:static <type-str> "Truncate" (cl:the (dotnet "System.Numerics.Vector4") vector)))

(cl:defun try-copy-to (obj! destination)
  "Summary: Attempts to copy the vector to the given System.Span`1. The length of the destination span must be at least 4.
Returns: if the source vector was successfully copied to destination. if destination is not large enough to hold the source vector.
Parameters:
  - destination (System.Span`1[System.Single]): The destination span which the values are copied into.
"
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector4") obj!) "TryCopyTo" destination))

(cl:defun xor (left right)
  "Summary: Computes the exclusive-or of two vectors.
Returns: The exclusive-or of left and right.
Parameters:
  - left (System.Numerics.Vector4): The vector to exclusive-or with right.
  - right (System.Numerics.Vector4): The vector to exclusive-or with left.
"
  (dotnet:static <type-str> "Xor" (cl:the (dotnet "System.Numerics.Vector4") left) (cl:the (dotnet "System.Numerics.Vector4") right)))

