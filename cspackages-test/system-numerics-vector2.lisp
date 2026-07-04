;;; Generated automatically. Do not edit.
;;; Class: System.Numerics.Vector2
;;; Generator Version: 28
;;; Creation Date: 2026-07-04T03:03:10Z

(cl:in-package :system-numerics-vector2)

(cl:defconstant <type> (dotnet:resolve-type "System.Numerics.Vector2"))
(cl:defconstant <type-str> "System.Numerics.Vector2")
(cl:defconstant <creation> "2026-07-04T03:03:10Z")
(cl:defconstant <version> 28)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Numerics.Vector2")))

(cl:defun new (cl:&optional (value cl:nil supplied-value) (y cl:nil supplied-y))
  "Master wrapper for System.Numerics.Vector2 constructor overloads. Dispatches at runtime.

new()

new(Single)
  Summary: Creates a new System.Numerics.Vector2 object whose two elements have the same value.
  Parameters:
    - value (System.Single): The value to assign to both elements.

new(Single])
  Summary: Constructs a vector from the given System.ReadOnlySpan`1. The span must contain at least two elements.
  Parameters:
    - values (System.ReadOnlySpan`1[System.Single]): The span of elements to assign to the vector.

new(Single, Single)
  Summary: Creates a vector whose elements have the specified values.
  Parameters:
    - x (System.Single): The value to assign to the System.Numerics.Vector2.X field.
    - y (System.Single): The value to assign to the System.Numerics.Vector2.Y field.
"
  (cl:cond
    ((cl:and supplied-value (cl:numberp value) supplied-y (cl:numberp y))
     (dotnet:new <type-str> value y))
    ((cl:and supplied-value (cl:numberp value) (cl:not supplied-y))
     (dotnet:new <type-str> value))
    ((cl:and supplied-value (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-y))
     (dotnet:new <type-str> value))
    ((cl:and (cl:not supplied-value) (cl:not supplied-y))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR2"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-value (cl:list :value value)) (cl:when supplied-y (cl:list :y y)))))))

(cl:defconstant +all-bits-set+ (dotnet:static <type-str> "AllBitsSet"))
(cl:setf (cl:documentation (cl:quote +all-bits-set+) (cl:quote cl:variable)) "Gets a vector where all bits are set to 1.")

(cl:defconstant +e+ (dotnet:static <type-str> "E"))
(cl:setf (cl:documentation (cl:quote +e+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.E.")

(cl:defconstant +epsilon+ (dotnet:static <type-str> "Epsilon"))
(cl:setf (cl:documentation (cl:quote +epsilon+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.Epsilon.")

(cl:defconstant +nan+ (dotnet:static <type-str> "NaN"))
(cl:setf (cl:documentation (cl:quote +nan+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.NaN.")

(cl:defconstant +negative-infinity+ (dotnet:static <type-str> "NegativeInfinity"))
(cl:setf (cl:documentation (cl:quote +negative-infinity+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.NegativeInfinity.")

(cl:defconstant +negative-zero+ (dotnet:static <type-str> "NegativeZero"))
(cl:setf (cl:documentation (cl:quote +negative-zero+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.NegativeZero.")

(cl:defconstant +one+ (dotnet:static <type-str> "One"))
(cl:setf (cl:documentation (cl:quote +one+) (cl:quote cl:variable)) "Gets a vector whose 2 elements are equal to one.")

(cl:defconstant +pi+ (dotnet:static <type-str> "Pi"))
(cl:setf (cl:documentation (cl:quote +pi+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.Pi.")

(cl:defconstant +positive-infinity+ (dotnet:static <type-str> "PositiveInfinity"))
(cl:setf (cl:documentation (cl:quote +positive-infinity+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.PositiveInfinity.")

(cl:defconstant +tau+ (dotnet:static <type-str> "Tau"))
(cl:setf (cl:documentation (cl:quote +tau+) (cl:quote cl:variable)) "Gets a vector whose elements are equal to System.Single.Tau.")

(cl:defconstant +unit-x+ (dotnet:static <type-str> "UnitX"))
(cl:setf (cl:documentation (cl:quote +unit-x+) (cl:quote cl:variable)) "Gets the vector (1,0).")

(cl:defconstant +unit-y+ (dotnet:static <type-str> "UnitY"))
(cl:setf (cl:documentation (cl:quote +unit-y+) (cl:quote cl:variable)) "Gets the vector (0,1).")

(cl:defconstant +zero+ (dotnet:static <type-str> "Zero"))
(cl:setf (cl:documentation (cl:quote +zero+) (cl:quote cl:variable)) "Returns a vector whose 2 elements are equal to zero.")

(cl:defun item (obj! index)
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "get_Item" index))

;; Note: Modifying a property of a value type (struct) via setf may only mutate
;; a boxed copy, leaving the original unchanged. Use caution with structs.
(cl:defun (cl:setf item) (new-value obj! index)
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "set_Item" index new-value))

(cl:defun x (obj!)
  "The X component of the vector."
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "X"))

;; Note: Modifying a field of a value type (struct) via setf may only mutate
;; a boxed copy, leaving the original unchanged. Use caution with structs.
(cl:defun (cl:setf x) (new-value obj!)
  "The X component of the vector."
  (cl:setf (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "X") new-value))

(cl:defun y (obj!)
  "The Y component of the vector."
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "Y"))

;; Note: Modifying a field of a value type (struct) via setf may only mutate
;; a boxed copy, leaving the original unchanged. Use caution with structs.
(cl:defun (cl:setf y) (new-value obj!)
  "The Y component of the vector."
  (cl:setf (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "Y") new-value))

(cl:defun - (value cl:&optional (right cl:nil supplied-right))
  "Master wrapper for System.Numerics.Vector2.- overloads. Dispatches at runtime.

-(Vector2) -> Vector2
  Summary: Negates the specified vector.
  Returns: The negated vector.
  Parameters:
    - value (System.Numerics.Vector2): The vector to negate.

-(Vector2, Vector2) -> Vector2
  Summary: Subtracts the second vector from the first.
  Returns: The vector that results from subtracting right from left.
  Parameters:
    - left (System.Numerics.Vector2): The first vector.
    - right (System.Numerics.Vector2): The second vector.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-right (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "op_Subtraction" value right))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-right))
     (dotnet:static <type-str> "op_UnaryNegation" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR2"
                    :class-name <type-str>
                    :method-name "-"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-right (cl:list :right right)))))))

(cl:defun * (left right)
  "Master wrapper for System.Numerics.Vector2.* overloads. Dispatches at runtime.

*(Vector2, Vector2) -> Vector2
  Summary: Returns a new vector whose values are the product of each pair of elements in two specified vectors.
  Returns: The element-wise product vector.
  Parameters:
    - left (System.Numerics.Vector2): The first vector.
    - right (System.Numerics.Vector2): The second vector.

*(Vector2, Single) -> Vector2
  Summary: Multiples the specified vector by the specified scalar value.
  Returns: The scaled vector.
  Parameters:
    - left (System.Numerics.Vector2): The vector.
    - right (System.Single): The scalar value.

*(Single, Vector2) -> Vector2
  Summary: Multiples the scalar value by the specified vector.
  Returns: The scaled vector.
  Parameters:
    - left (System.Single): The vector.
    - right (System.Numerics.Vector2): The scalar value.
"
  (cl:cond
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "op_Multiply" left right))
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:numberp right))
     (dotnet:static <type-str> "op_Multiply" left right))
    ((cl:and (cl:numberp left) (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "op_Multiply" left right))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR2"
                    :class-name <type-str>
                    :method-name "*"
                    :supplied-args (cl:append (cl:list :left left) (cl:list :right right))))))

(cl:defun / (left right)
  "Master wrapper for System.Numerics.Vector2./ overloads. Dispatches at runtime.

/(Vector2, Vector2) -> Vector2
  Summary: Divides the first vector by the second.
  Returns: The vector that results from dividing left by right.
  Parameters:
    - left (System.Numerics.Vector2): The first vector.
    - right (System.Numerics.Vector2): The second vector.

/(Vector2, Single) -> Vector2
  Summary: Divides the specified vector by a specified scalar value.
  Returns: The result of the division.
  Parameters:
    - value1 (System.Numerics.Vector2): The vector.
    - value2 (System.Single): The scalar value.
"
  (cl:cond
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "op_Division" left right))
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:numberp right))
     (dotnet:static <type-str> "op_Division" left right))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR2"
                    :class-name <type-str>
                    :method-name "/"
                    :supplied-args (cl:append (cl:list :left left) (cl:list :right right))))))

(cl:defun + (value cl:&optional (right cl:nil supplied-right))
  "Master wrapper for System.Numerics.Vector2.+ overloads. Dispatches at runtime.

+(Vector2) -> Vector2
  Parameters:
    - value (System.Numerics.Vector2): 

+(Vector2, Vector2) -> Vector2
  Summary: Adds two vectors together.
  Returns: The summed vector.
  Parameters:
    - left (System.Numerics.Vector2): The first vector to add.
    - right (System.Numerics.Vector2): The second vector to add.
"
  (cl:cond
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-right (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "op_Addition" value right))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-right))
     (dotnet:static <type-str> "op_UnaryPlus" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR2"
                    :class-name <type-str>
                    :method-name "+"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-right (cl:list :right right)))))))

(cl:defun = (left right)
  "Summary: Returns a value that indicates whether each pair of elements in two specified vectors is equal.
Returns: if left and right are equal; otherwise, .
Parameters:
  - left (System.Numerics.Vector2): The first vector to compare.
  - right (System.Numerics.Vector2): The second vector to compare.
"
  (dotnet:static <type-str> "op_Equality" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun abs (value)
  "Summary: Returns a vector whose elements are the absolute values of each of the specified vector's elements.
Returns: The absolute value vector.
Parameters:
  - value (System.Numerics.Vector2): A vector.
"
  (dotnet:static <type-str> "Abs" (cl:the (dotnet "System.Numerics.Vector2") value)))

(cl:defun add (left right)
  "Summary: Adds two vectors together.
Returns: The summed vector.
Parameters:
  - left (System.Numerics.Vector2): The first vector to add.
  - right (System.Numerics.Vector2): The second vector to add.
"
  (dotnet:static <type-str> "Add" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun all (vector value)
  "Parameters:
  - vector (System.Numerics.Vector2): 
  - value (System.Single): 
"
  (dotnet:static <type-str> "All" (cl:the (dotnet "System.Numerics.Vector2") vector) (cl:the (dotnet "System.Single") value)))

(cl:defun all-where-all-bits-set (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "AllWhereAllBitsSet" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun and-not (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "AndNot" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun any (vector value)
  "Parameters:
  - vector (System.Numerics.Vector2): 
  - value (System.Single): 
"
  (dotnet:static <type-str> "Any" (cl:the (dotnet "System.Numerics.Vector2") vector) (cl:the (dotnet "System.Single") value)))

(cl:defun any-where-all-bits-set (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "AnyWhereAllBitsSet" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun bitwise-and (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "BitwiseAnd" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun bitwise-or (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "BitwiseOr" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun clamp (value1 min max)
  "Summary: Restricts a vector between a minimum and a maximum value.
Returns: The restricted vector.
Parameters:
  - value1 (System.Numerics.Vector2): The vector to restrict.
  - min (System.Numerics.Vector2): The minimum value.
  - max (System.Numerics.Vector2): The maximum value.
"
  (dotnet:static <type-str> "Clamp" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") min) (cl:the (dotnet "System.Numerics.Vector2") max)))

(cl:defun clamp-native (value1 min max)
  "Summary: Restricts a vector between a minimum and a maximum value using platform specific behavior for NaN and NegativeZero..
Returns: The restricted vector.
Parameters:
  - value1 (System.Numerics.Vector2): 
  - min (System.Numerics.Vector2): The minimum value.
  - max (System.Numerics.Vector2): The maximum value.
"
  (dotnet:static <type-str> "ClampNative" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") min) (cl:the (dotnet "System.Numerics.Vector2") max)))

(cl:defun conditional-select (condition left right)
  "Parameters:
  - condition (System.Numerics.Vector2): 
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "ConditionalSelect" (cl:the (dotnet "System.Numerics.Vector2") condition) (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun copy-sign (value sign)
  "Summary: Copies the per-element sign of a vector to the per-element sign of another vector.
Returns: A vector with the magnitude of value and the sign of sign.
Parameters:
  - value (System.Numerics.Vector2): The vector whose magnitude is used in the result.
  - sign (System.Numerics.Vector2): The vector whose sign is used in the result.
"
  (dotnet:static <type-str> "CopySign" (cl:the (dotnet "System.Numerics.Vector2") value) (cl:the (dotnet "System.Numerics.Vector2") sign)))

(cl:defun copy-to (obj! array cl:&optional (index cl:nil supplied-index))
  "Master wrapper for System.Numerics.Vector2.CopyTo overloads. Dispatches at runtime.

CopyTo(Single[]) -> Void
  Summary: Copies the elements of the vector to a specified array.
  Parameters:
    - array (System.Single[]): The destination array.

CopyTo(Single]) -> Void
  Summary: Copies the vector to the given System.Span`1.The length of the destination span must be at least 2.
  Parameters:
    - destination (System.Span`1[System.Single]): The destination span into which the values are copied.

CopyTo(Single[], Int32) -> Void
  Summary: Copies the elements of the vector to a specified array starting at a specified index position.
  Parameters:
    - array (System.Single[]): The destination array.
    - index (System.Int32): The index at which to copy the first element of the vector.
"
  (cl:cond
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) supplied-index (cl:numberp index))
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "CopyTo" array index))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:not supplied-index))
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "CopyTo" array))
    ((cl:and (cl:or (cl:null array) (dotnet:object-type array)) (cl:not supplied-index))
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "CopyTo" array))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR2"
                    :class-name <type-str>
                    :method-name "CopyTo"
                    :supplied-args (cl:append (cl:list :array array) (cl:when supplied-index (cl:list :index index)))))))

(cl:defun cos (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "Cos" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun count (vector value)
  "Parameters:
  - vector (System.Numerics.Vector2): 
  - value (System.Single): 
"
  (dotnet:static <type-str> "Count" (cl:the (dotnet "System.Numerics.Vector2") vector) (cl:the (dotnet "System.Single") value)))

(cl:defun count-where-all-bits-set (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "CountWhereAllBitsSet" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun create (value cl:&optional (y cl:nil supplied-y))
  "Master wrapper for System.Numerics.Vector2.Create overloads. Dispatches at runtime.

Create(Single) -> Vector2
  Summary: Creates a new System.Numerics.Vector2 object whose two elements have the same value.
  Returns: A new System.Numerics.Vector2 whose two elements have the same value.
  Parameters:
    - value (System.Single): The value to assign to all two elements.

Create(Single]) -> Vector2
  Summary: Constructs a vector from the given System.ReadOnlySpan`1. The span must contain at least 2 elements.
  Returns: A new System.Numerics.Vector2 whose elements have the specified values.
  Parameters:
    - values (System.ReadOnlySpan`1[System.Single]): The span of elements to assign to the vector.

Create(Single, Single) -> Vector2
  Summary: Creates a vector whose elements have the specified values.
  Returns: A new System.Numerics.Vector2 whose elements have the specified values.
  Parameters:
    - x (System.Single): The value to assign to the System.Numerics.Vector2.X field.
    - y (System.Single): The value to assign to the System.Numerics.Vector2.Y field.
"
  (cl:cond
    ((cl:and (cl:numberp value) supplied-y (cl:numberp y))
     (dotnet:static <type-str> "Create" value y))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-y))
     (dotnet:static <type-str> "Create" value))
    ((cl:and (cl:numberp value) (cl:not supplied-y))
     (dotnet:static <type-str> "Create" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR2"
                    :class-name <type-str>
                    :method-name "Create"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-y (cl:list :y y)))))))

(cl:defun create-scalar (x)
  "Summary: Creates a vector with System.Numerics.Vector2.X initialized to the specified value and the remaining elements initialized to zero.
Returns: A new System.Numerics.Vector2 with System.Numerics.Vector2.X initialized x and the remaining elements initialized to zero.
Parameters:
  - x (System.Single): The value to assign to the System.Numerics.Vector2.X field.
"
  (dotnet:static <type-str> "CreateScalar" (cl:the (dotnet "System.Single") x)))

(cl:defun create-scalar-unsafe (x)
  "Summary: Creates a vector with System.Numerics.Vector2.X initialized to the specified value and the remaining elements left uninitialized.
Returns: A new System.Numerics.Vector2 with System.Numerics.Vector2.X initialized x and the remaining elements left uninitialized.
Parameters:
  - x (System.Single): The value to assign to the System.Numerics.Vector2.X field.
"
  (dotnet:static <type-str> "CreateScalarUnsafe" (cl:the (dotnet "System.Single") x)))

(cl:defun cross (value1 value2)
  "Summary: Returns the z-value of the cross product of two vectors.Since the Vector2 is in the x-y plane, a 3D cross product only produces the z-value.
Returns: The value of the z-coordinate from the cross product.
Parameters:
  - value1 (System.Numerics.Vector2): The first vector.
  - value2 (System.Numerics.Vector2): The second vector.
"
  (dotnet:static <type-str> "Cross" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") value2)))

(cl:defun degrees-to-radians (degrees)
  "Parameters:
  - degrees (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "DegreesToRadians" (cl:the (dotnet "System.Numerics.Vector2") degrees)))

(cl:defun distance (value1 value2)
  "Summary: Computes the Euclidean distance between the two given points.
Returns: The distance.
Parameters:
  - value1 (System.Numerics.Vector2): The first point.
  - value2 (System.Numerics.Vector2): The second point.
"
  (dotnet:static <type-str> "Distance" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") value2)))

(cl:defun distance-squared (value1 value2)
  "Summary: Returns the Euclidean distance squared between two specified points.
Returns: The distance squared.
Parameters:
  - value1 (System.Numerics.Vector2): The first point.
  - value2 (System.Numerics.Vector2): The second point.
"
  (dotnet:static <type-str> "DistanceSquared" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") value2)))

(cl:defun divide (left right)
  "Master wrapper for System.Numerics.Vector2.Divide overloads. Dispatches at runtime.

Divide(Vector2, Vector2) -> Vector2
  Summary: Divides the first vector by the second.
  Returns: The vector resulting from the division.
  Parameters:
    - left (System.Numerics.Vector2): The first vector.
    - right (System.Numerics.Vector2): The second vector.

Divide(Vector2, Single) -> Vector2
  Summary: Divides the specified vector by a specified scalar value.
  Returns: The vector that results from the division.
  Parameters:
    - left (System.Numerics.Vector2): The vector.
    - divisor (System.Single): The scalar value.
"
  (cl:cond
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "Divide" left right))
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:numberp right))
     (dotnet:static <type-str> "Divide" left right))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR2"
                    :class-name <type-str>
                    :method-name "Divide"
                    :supplied-args (cl:append (cl:list :left left) (cl:list :right right))))))

(cl:defun dot (value1 value2)
  "Summary: Returns the dot product of two vectors.
Returns: The dot product.
Parameters:
  - value1 (System.Numerics.Vector2): The first vector.
  - value2 (System.Numerics.Vector2): The second vector.
"
  (dotnet:static <type-str> "Dot" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") value2)))

(cl:defun equals (obj! obj)
  "Master wrapper for System.Numerics.Vector2.Equals overloads. Dispatches at runtime.

Equals(Object) -> Boolean
  Summary: Returns a value that indicates whether this instance and a specified object are equal.
  Returns: if the current instance and obj are equal; otherwise, . If obj is , the method returns .
  Parameters:
    - obj (System.Object): The object to compare with the current instance.

Equals(Vector2) -> Boolean
  Summary: Returns a value that indicates whether this instance and another vector are equal.
  Returns: if the two vectors are equal; otherwise, .
  Parameters:
    - other (System.Numerics.Vector2): The other vector.
"
  (cl:cond
    ((cl:and (cl:or (cl:null obj) (dotnet:object-type obj)))
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "Equals" obj))
    ((cl:and (cl:or (cl:null obj) (dotnet:object-type obj)))
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "Equals" obj))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR2"
                    :class-name <type-str>
                    :method-name "Equals"
                    :supplied-args (cl:append (cl:list :obj obj))))))

(cl:defun equals* (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "Equals" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun equals-all (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "EqualsAll" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun equals-any (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "EqualsAny" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun exp (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "Exp" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun fused-multiply-add (left right addend)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
  - addend (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "FusedMultiplyAdd" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right) (cl:the (dotnet "System.Numerics.Vector2") addend)))

(cl:defun get-hash-code (obj!)
  "Summary: Returns the hash code for this instance.
Returns: The hash code.
"
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "GetHashCode"))

(cl:defun greater-than (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "GreaterThan" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun greater-than-all (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "GreaterThanAll" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun greater-than-any (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "GreaterThanAny" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun greater-than-or-equal (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "GreaterThanOrEqual" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun greater-than-or-equal-all (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "GreaterThanOrEqualAll" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun greater-than-or-equal-any (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "GreaterThanOrEqualAny" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun hypot (x y)
  "Parameters:
  - x (System.Numerics.Vector2): 
  - y (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "Hypot" (cl:the (dotnet "System.Numerics.Vector2") x) (cl:the (dotnet "System.Numerics.Vector2") y)))

(cl:defun index-of (vector value)
  "Parameters:
  - vector (System.Numerics.Vector2): 
  - value (System.Single): 
"
  (dotnet:static <type-str> "IndexOf" (cl:the (dotnet "System.Numerics.Vector2") vector) (cl:the (dotnet "System.Single") value)))

(cl:defun index-of-where-all-bits-set (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "IndexOfWhereAllBitsSet" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun even-integer? (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "IsEvenInteger" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun finite? (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "IsFinite" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun infinity? (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "IsInfinity" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun integer? (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "IsInteger" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun nan? (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "IsNaN" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun negative? (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "IsNegative" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun negative-infinity? (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "IsNegativeInfinity" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun normal? (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "IsNormal" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun odd-integer? (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "IsOddInteger" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun positive? (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "IsPositive" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun positive-infinity? (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "IsPositiveInfinity" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun subnormal? (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "IsSubnormal" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun zero? (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "IsZero" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun last-index-of (vector value)
  "Parameters:
  - vector (System.Numerics.Vector2): 
  - value (System.Single): 
"
  (dotnet:static <type-str> "LastIndexOf" (cl:the (dotnet "System.Numerics.Vector2") vector) (cl:the (dotnet "System.Single") value)))

(cl:defun last-index-of-where-all-bits-set (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "LastIndexOfWhereAllBitsSet" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun length (obj!)
  "Summary: Returns the length of the vector.
Returns: The vector's length.
"
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "Length"))

(cl:defun length-squared (obj!)
  "Summary: Returns the length of the vector squared.
Returns: The vector's length squared.
"
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "LengthSquared"))

(cl:defun lerp (value1 value2 amount)
  "Master wrapper for System.Numerics.Vector2.Lerp overloads. Dispatches at runtime.

Lerp(Vector2, Vector2, Single) -> Vector2
  Summary: Performs a linear interpolation between two vectors based on the given weighting.
  Returns: The interpolated vector.
  Parameters:
    - value1 (System.Numerics.Vector2): The first vector.
    - value2 (System.Numerics.Vector2): The second vector.
    - amount (System.Single): A value between 0 and 1 that indicates the weight of value2.

Lerp(Vector2, Vector2, Vector2) -> Vector2
  Parameters:
    - value1 (System.Numerics.Vector2): 
    - value2 (System.Numerics.Vector2): 
    - amount (System.Numerics.Vector2): 
"
  (cl:cond
    ((cl:and (cl:or (cl:null value1) (dotnet:object-type value1)) (cl:or (cl:null value2) (dotnet:object-type value2)) (cl:numberp amount))
     (dotnet:static <type-str> "Lerp" value1 value2 amount))
    ((cl:and (cl:or (cl:null value1) (dotnet:object-type value1)) (cl:or (cl:null value2) (dotnet:object-type value2)) (cl:or (cl:null amount) (dotnet:object-type amount)))
     (dotnet:static <type-str> "Lerp" value1 value2 amount))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR2"
                    :class-name <type-str>
                    :method-name "Lerp"
                    :supplied-args (cl:append (cl:list :value1 value1) (cl:list :value2 value2) (cl:list :amount amount))))))

(cl:defun less-than (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "LessThan" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun less-than-all (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "LessThanAll" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun less-than-any (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "LessThanAny" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun less-than-or-equal (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "LessThanOrEqual" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun less-than-or-equal-all (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "LessThanOrEqualAll" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun less-than-or-equal-any (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "LessThanOrEqualAny" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun load (source)
  "Parameters:
  - source (System.Single*): 
"
  (dotnet:static <type-str> "Load" (cl:the (dotnet "System.Single*") source)))

(cl:defun load-aligned (source)
  "Parameters:
  - source (System.Single*): 
"
  (dotnet:static <type-str> "LoadAligned" (cl:the (dotnet "System.Single*") source)))

(cl:defun load-aligned-non-temporal (source)
  "Parameters:
  - source (System.Single*): 
"
  (dotnet:static <type-str> "LoadAlignedNonTemporal" (cl:the (dotnet "System.Single*") source)))

;; The following C# System.Numerics.Vector2.LoadUnsafe overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   LoadUnsafe(ref Single&) -> Vector2
;;   LoadUnsafe(ref Single&, UIntPtr) -> Vector2

(cl:defun log (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "Log" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun log2 (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "Log2" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun max (value1 value2)
  "Summary: Returns a vector whose elements are the maximum of each of the pairs of elements in two specified vectors.
Returns: The maximized vector.
Parameters:
  - value1 (System.Numerics.Vector2): The first vector.
  - value2 (System.Numerics.Vector2): The second vector.
"
  (dotnet:static <type-str> "Max" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") value2)))

(cl:defun max-magnitude (value1 value2)
  "Summary: Compares two vectors to compute which has the greater magnitude on a per-element basis.
Returns: A vector where the corresponding element comes from left if it has a greater magnitude than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector2): 
  - value2 (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "MaxMagnitude" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") value2)))

(cl:defun max-magnitude-number (value1 value2)
  "Summary: Compares two vectors, on a per-element basis, to compute which has the greater magnitude and returning the other value if an input is NaN.
Returns: A vector where the corresponding element comes from left if it has a greater magnitude than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector2): 
  - value2 (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "MaxMagnitudeNumber" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") value2)))

(cl:defun max-native (value1 value2)
  "Summary: Compare two vectors to determine which is greater on a per-element basis using platform specific behavior for NaN and NegativeZero.
Returns: A vector where the corresponding element comes from left if it is greater than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector2): 
  - value2 (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "MaxNative" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") value2)))

(cl:defun max-number (value1 value2)
  "Summary: Compares two vectors, on a per-element basis, to compute which is greater and returning the other value if an element is NaN.
Returns: A vector where the corresponding element comes from left if it is greater than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector2): 
  - value2 (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "MaxNumber" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") value2)))

(cl:defun min (value1 value2)
  "Summary: Returns a vector whose elements are the minimum of each of the pairs of elements in two specified vectors.
Returns: The minimized vector.
Parameters:
  - value1 (System.Numerics.Vector2): The first vector.
  - value2 (System.Numerics.Vector2): The second vector.
"
  (dotnet:static <type-str> "Min" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") value2)))

(cl:defun min-magnitude (value1 value2)
  "Summary: Compares two vectors to compute which has the lesser magnitude on a per-element basis.
Returns: A vector where the corresponding element comes from left if it has a lesser magnitude than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector2): 
  - value2 (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "MinMagnitude" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") value2)))

(cl:defun min-magnitude-number (value1 value2)
  "Summary: Compares two vectors, on a per-element basis, to compute which has the lesser magnitude and returning the other value if an input is NaN.
Returns: A vector where the corresponding element comes from left if it has a lesser magnitude than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector2): 
  - value2 (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "MinMagnitudeNumber" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") value2)))

(cl:defun min-native (value1 value2)
  "Summary: Compare two vectors to determine which is lesser on a per-element basis using platform specific behavior for NaN and NegativeZero.
Returns: A vector where the corresponding element comes from left if it is lesser than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector2): 
  - value2 (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "MinNative" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") value2)))

(cl:defun min-number (value1 value2)
  "Summary: Compares two vectors, on a per-element basis, to compute which is lesser and returning the other value if an element is NaN.
Returns: A vector where the corresponding element comes from left if it is lesser than right; otherwise, right.
Parameters:
  - value1 (System.Numerics.Vector2): 
  - value2 (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "MinNumber" (cl:the (dotnet "System.Numerics.Vector2") value1) (cl:the (dotnet "System.Numerics.Vector2") value2)))

(cl:defun multiply (left right)
  "Master wrapper for System.Numerics.Vector2.Multiply overloads. Dispatches at runtime.

Multiply(Vector2, Vector2) -> Vector2
  Summary: Returns a new vector whose values are the product of each pair of elements in two specified vectors.
  Returns: The element-wise product vector.
  Parameters:
    - left (System.Numerics.Vector2): The first vector.
    - right (System.Numerics.Vector2): The second vector.

Multiply(Vector2, Single) -> Vector2
  Summary: Multiplies a vector by a specified scalar.
  Returns: The scaled vector.
  Parameters:
    - left (System.Numerics.Vector2): The vector to multiply.
    - right (System.Single): The scalar value.

Multiply(Single, Vector2) -> Vector2
  Summary: Multiplies a scalar value by a specified vector.
  Returns: The scaled vector.
  Parameters:
    - left (System.Single): The scaled value.
    - right (System.Numerics.Vector2): The vector.
"
  (cl:cond
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "Multiply" left right))
    ((cl:and (cl:or (cl:null left) (dotnet:object-type left)) (cl:numberp right))
     (dotnet:static <type-str> "Multiply" left right))
    ((cl:and (cl:numberp left) (cl:or (cl:null right) (dotnet:object-type right)))
     (dotnet:static <type-str> "Multiply" left right))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR2"
                    :class-name <type-str>
                    :method-name "Multiply"
                    :supplied-args (cl:append (cl:list :left left) (cl:list :right right))))))

(cl:defun multiply-add-estimate (left right addend)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
  - addend (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "MultiplyAddEstimate" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right) (cl:the (dotnet "System.Numerics.Vector2") addend)))

(cl:defun negate (value)
  "Summary: Negates a specified vector.
Returns: The negated vector.
Parameters:
  - value (System.Numerics.Vector2): The vector to negate.
"
  (dotnet:static <type-str> "Negate" (cl:the (dotnet "System.Numerics.Vector2") value)))

(cl:defun none (vector value)
  "Parameters:
  - vector (System.Numerics.Vector2): 
  - value (System.Single): 
"
  (dotnet:static <type-str> "None" (cl:the (dotnet "System.Numerics.Vector2") vector) (cl:the (dotnet "System.Single") value)))

(cl:defun none-where-all-bits-set (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "NoneWhereAllBitsSet" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun normalize (value)
  "Summary: Returns a vector with the same direction as the specified vector, but with a length of one.
Returns: The normalized vector.
Parameters:
  - value (System.Numerics.Vector2): The vector to normalize.
"
  (dotnet:static <type-str> "Normalize" (cl:the (dotnet "System.Numerics.Vector2") value)))

(cl:defun not= (left right)
  "Summary: Returns a value that indicates whether two specified vectors are not equal.
Returns: if left and right are not equal; otherwise, .
Parameters:
  - left (System.Numerics.Vector2): The first vector to compare.
  - right (System.Numerics.Vector2): The second vector to compare.
"
  (dotnet:static <type-str> "op_Inequality" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun ones-complement (value)
  "Parameters:
  - value (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "OnesComplement" (cl:the (dotnet "System.Numerics.Vector2") value)))

(cl:defun radians-to-degrees (radians)
  "Parameters:
  - radians (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "RadiansToDegrees" (cl:the (dotnet "System.Numerics.Vector2") radians)))

(cl:defun reflect (vector normal)
  "Summary: Returns the reflection of a vector off a surface that has the specified normal.
Returns: The reflected vector.
Parameters:
  - vector (System.Numerics.Vector2): The source vector.
  - normal (System.Numerics.Vector2): The normal of the surface being reflected off.
"
  (dotnet:static <type-str> "Reflect" (cl:the (dotnet "System.Numerics.Vector2") vector) (cl:the (dotnet "System.Numerics.Vector2") normal)))

(cl:defun round (vector cl:&optional (mode cl:nil supplied-mode))
  "Master wrapper for System.Numerics.Vector2.Round overloads. Dispatches at runtime.

Round(Vector2) -> Vector2
  Parameters:
    - vector (System.Numerics.Vector2): 

Round(Vector2, MidpointRounding) -> Vector2
  Parameters:
    - vector (System.Numerics.Vector2): 
    - mode (System.MidpointRounding): 
"
  (cl:cond
    ((cl:and (cl:or (cl:null vector) (dotnet:object-type vector)) supplied-mode (cl:or (cl:null mode) (dotnet:object-type mode)))
     (dotnet:static <type-str> "Round" vector mode))
    ((cl:and (cl:or (cl:null vector) (dotnet:object-type vector)) (cl:not supplied-mode))
     (dotnet:static <type-str> "Round" vector))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR2"
                    :class-name <type-str>
                    :method-name "Round"
                    :supplied-args (cl:append (cl:list :vector vector) (cl:when supplied-mode (cl:list :mode mode)))))))

(cl:defun shuffle (vector x-index y-index)
  "Summary: Creates a new vector by selecting values from an input vector using a set of indices.
Returns: A new vector containing the values from vector selected by the given indices.
Parameters:
  - vector (System.Numerics.Vector2): The input vector from which values are selected.
  - x-index (System.Byte): The index used to select a value from vector to be used as the value of System.Numerics.Vector2.X in the result.
  - y-index (System.Byte): The index used to select a value from vector to be used as the value of System.Numerics.Vector2.Y in the result
"
  (dotnet:static <type-str> "Shuffle" (cl:the (dotnet "System.Numerics.Vector2") vector) (cl:the (dotnet "System.Byte") x-index) (cl:the (dotnet "System.Byte") y-index)))

(cl:defun sin (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "Sin" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun sin-cos (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "SinCos" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun square-root (value)
  "Summary: Returns a vector whose elements are the square root of each of a specified vector's elements.
Returns: The square root vector.
Parameters:
  - value (System.Numerics.Vector2): A vector.
"
  (dotnet:static <type-str> "SquareRoot" (cl:the (dotnet "System.Numerics.Vector2") value)))

(cl:defun subtract (left right)
  "Summary: Subtracts the second vector from the first.
Returns: The difference vector.
Parameters:
  - left (System.Numerics.Vector2): The first vector.
  - right (System.Numerics.Vector2): The second vector.
"
  (dotnet:static <type-str> "Subtract" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

(cl:defun sum (value)
  "Parameters:
  - value (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "Sum" (cl:the (dotnet "System.Numerics.Vector2") value)))

(cl:defun to-string (obj! cl:&optional (format cl:nil supplied-format) (format-provider cl:nil supplied-format-provider))
  "Master wrapper for System.Numerics.Vector2.ToString overloads. Dispatches at runtime.

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
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "ToString" format format-provider))
    ((cl:and supplied-format (cl:stringp format) (cl:not supplied-format-provider))
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "ToString" format))
    ((cl:and (cl:not supplied-format) (cl:not supplied-format-provider))
     (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "ToString"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR2"
                    :class-name <type-str>
                    :method-name "ToString"
                    :supplied-args (cl:append (cl:when supplied-format (cl:list :format format)) (cl:when supplied-format-provider (cl:list :format-provider format-provider)))))))

(cl:defun transform (position matrix)
  "Master wrapper for System.Numerics.Vector2.Transform overloads. Dispatches at runtime.

Transform(Vector2, Matrix3x2) -> Vector2
  Summary: Transforms a vector by a specified 3x2 matrix.
  Returns: The transformed vector.
  Parameters:
    - position (System.Numerics.Vector2): The vector to transform.
    - matrix (System.Numerics.Matrix3x2): The transformation matrix.

Transform(Vector2, Matrix4x4) -> Vector2
  Summary: Transforms a vector by a specified 4x4 matrix.
  Returns: The transformed vector.
  Parameters:
    - position (System.Numerics.Vector2): The vector to transform.
    - matrix (System.Numerics.Matrix4x4): The transformation matrix.

Transform(Vector2, Quaternion) -> Vector2
  Summary: Transforms a vector by the specified Quaternion rotation value.
  Returns: The transformed vector.
  Parameters:
    - value (System.Numerics.Vector2): The vector to rotate.
    - rotation (System.Numerics.Quaternion): The rotation to apply.
"
  (cl:cond
    ((cl:and (cl:or (cl:null position) (dotnet:object-type position)) (cl:or (cl:null matrix) (dotnet:object-type matrix)))
     (dotnet:static <type-str> "Transform" position matrix))
    ((cl:and (cl:or (cl:null position) (dotnet:object-type position)) (cl:or (cl:null matrix) (dotnet:object-type matrix)))
     (dotnet:static <type-str> "Transform" position matrix))
    ((cl:and (cl:or (cl:null position) (dotnet:object-type position)) (cl:or (cl:null matrix) (dotnet:object-type matrix)))
     (dotnet:static <type-str> "Transform" position matrix))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR2"
                    :class-name <type-str>
                    :method-name "Transform"
                    :supplied-args (cl:append (cl:list :position position) (cl:list :matrix matrix))))))

(cl:defun transform-normal (normal matrix)
  "Master wrapper for System.Numerics.Vector2.TransformNormal overloads. Dispatches at runtime.

TransformNormal(Vector2, Matrix3x2) -> Vector2
  Summary: Transforms a vector normal by the given 3x2 matrix.
  Returns: The transformed vector.
  Parameters:
    - normal (System.Numerics.Vector2): The source vector.
    - matrix (System.Numerics.Matrix3x2): The matrix.

TransformNormal(Vector2, Matrix4x4) -> Vector2
  Summary: Transforms a vector normal by the given 4x4 matrix.
  Returns: The transformed vector.
  Parameters:
    - normal (System.Numerics.Vector2): The source vector.
    - matrix (System.Numerics.Matrix4x4): The matrix.
"
  (cl:cond
    ((cl:and (cl:or (cl:null normal) (dotnet:object-type normal)) (cl:or (cl:null matrix) (dotnet:object-type matrix)))
     (dotnet:static <type-str> "TransformNormal" normal matrix))
    ((cl:and (cl:or (cl:null normal) (dotnet:object-type normal)) (cl:or (cl:null matrix) (dotnet:object-type matrix)))
     (dotnet:static <type-str> "TransformNormal" normal matrix))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-NUMERICS-VECTOR2"
                    :class-name <type-str>
                    :method-name "TransformNormal"
                    :supplied-args (cl:append (cl:list :normal normal) (cl:list :matrix matrix))))))

(cl:defun truncate (vector)
  "Parameters:
  - vector (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "Truncate" (cl:the (dotnet "System.Numerics.Vector2") vector)))

(cl:defun try-copy-to (obj! destination)
  "Summary: Attempts to copy the vector to the given System.Span`1. The length of the destination span must be at least 2.
Returns: if the source vector was successfully copied to destination. if destination is not large enough to hold the source vector.
Parameters:
  - destination (System.Span`1[System.Single]): The destination span into which the values are copied.
"
  (dotnet:invoke (cl:the (dotnet "System.Numerics.Vector2") obj!) "TryCopyTo" destination))

(cl:defun xor (left right)
  "Parameters:
  - left (System.Numerics.Vector2): 
  - right (System.Numerics.Vector2): 
"
  (dotnet:static <type-str> "Xor" (cl:the (dotnet "System.Numerics.Vector2") left) (cl:the (dotnet "System.Numerics.Vector2") right)))

