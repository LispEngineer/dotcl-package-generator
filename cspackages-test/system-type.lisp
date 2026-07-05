;;; Generated automatically. Do not edit.
;;; Class: System.Type
;;; Generator Version: 36
;;; Creation Date: 2026-07-05T18:30:04Z

(cl:in-package :system-type)

(cl:defconstant <type> (dotnet:resolve-type "System.Type"))
(cl:defconstant <type-str> "System.Type")
(cl:defconstant <creation> "2026-07-05T18:30:04Z")
(cl:defconstant <version> 36)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Type")))

(cl:defun new ()
  "Summary: Initializes a new instance of the System.Type class.
"
  (dotnet:new <type-str>))

(cl:define-symbol-macro delimiter (dotnet:static <type-str> "Delimiter"))
(cl:setf (cl:documentation (cl:quote delimiter) (cl:quote cl:variable)) "Separates names in the namespace of the System.Type. This field is read-only.")

(cl:define-symbol-macro empty-types (dotnet:static <type-str> "EmptyTypes"))
(cl:setf (cl:documentation (cl:quote empty-types) (cl:quote cl:variable)) "Represents an empty array of type System.Type. This field is read-only.")

(cl:define-symbol-macro filter-attribute (dotnet:static <type-str> "FilterAttribute"))
(cl:setf (cl:documentation (cl:quote filter-attribute) (cl:quote cl:variable)) "Represents the member filter used on attributes. This field is read-only.")

(cl:define-symbol-macro filter-name (dotnet:static <type-str> "FilterName"))
(cl:setf (cl:documentation (cl:quote filter-name) (cl:quote cl:variable)) "Represents the case-sensitive member filter used on names. This field is read-only.")

(cl:define-symbol-macro filter-name-ignore-case (dotnet:static <type-str> "FilterNameIgnoreCase"))
(cl:setf (cl:documentation (cl:quote filter-name-ignore-case) (cl:quote cl:variable)) "Represents the case-insensitive member filter used on names. This field is read-only.")

(cl:define-symbol-macro missing (dotnet:static <type-str> "Missing"))
(cl:setf (cl:documentation (cl:quote missing) (cl:quote cl:variable)) "Represents a missing value in the System.Type information. This field is read-only.")

(cl:define-symbol-macro default-binder (dotnet:static <type-str> "DefaultBinder"))
(cl:setf (cl:documentation (cl:quote default-binder) (cl:quote cl:variable)) "Gets a reference to the default binder, which implements internal rules for selecting the appropriate members to be called by System.Type.InvokeMember(System.String,System.Reflection.BindingFlags,System.Reflection.Binder,System.Object,System.Object[],System.Reflection.ParameterModifier[],System.Globalization.CultureInfo,System.String[]).")

(cl:defun assembly (obj!)
  "Gets the System.Reflection.Assembly in which the type is declared. For generic types, gets the System.Reflection.Assembly in which the generic type is defined."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_Assembly"))

(cl:defun assembly-qualified-name (obj!)
  "Gets the assembly-qualified name of the type, which includes the name of the assembly from which this System.Type object was loaded."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_AssemblyQualifiedName"))

(cl:defun attributes (obj!)
  "Gets the attributes associated with the System.Type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_Attributes"))

(cl:defun base-type (obj!)
  "Gets the type from which the current System.Type directly inherits."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_BaseType"))

(cl:defun contains-generic-parameters (obj!)
  "Gets a value indicating whether the current System.Type object has type parameters that have not been replaced by specific types."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_ContainsGenericParameters"))

(cl:defun declaring-method (obj!)
  "Gets a System.Reflection.MethodBase that represents the declaring method, if the current System.Type represents a type parameter of a generic method."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_DeclaringMethod"))

(cl:defun declaring-type (obj!)
  "Gets the type that declares the current nested type or generic type parameter."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_DeclaringType"))

(cl:defun full-name (obj!)
  "Gets the fully qualified name of the type, including its namespace but not its assembly."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_FullName"))

(cl:defun generic-parameter-attributes (obj!)
  "Gets a combination of System.Reflection.GenericParameterAttributes flags that describe the covariance and special constraints of the current generic type parameter."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_GenericParameterAttributes"))

(cl:defun generic-parameter-position (obj!)
  "Gets the position of the type parameter in the type parameter list of the generic type or method that declared the parameter, when the System.Type object represents a type parameter of a generic type or a generic method."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_GenericParameterPosition"))

(cl:defun generic-type-arguments (obj!)
  "Gets an array of the generic type arguments for this type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_GenericTypeArguments"))

(cl:defun guid (obj!)
  "Gets the GUID associated with the System.Type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_GUID"))

(cl:defun has-element-type (obj!)
  "Gets a value indicating whether the current System.Type encompasses or refers to another type; that is, whether the current System.Type is an array, a pointer, or is passed by reference."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_HasElementType"))

(cl:defun abstract? (obj!)
  "Gets a value indicating whether the System.Type is abstract and must be overridden."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsAbstract"))

(cl:defun ansi-class? (obj!)
  "Gets a value indicating whether the string format attribute is selected for the System.Type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsAnsiClass"))

(cl:defun array? (obj!)
  "Gets a value that indicates whether the type is an array."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsArray"))

(cl:defun auto-class? (obj!)
  "Gets a value indicating whether the string format attribute is selected for the System.Type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsAutoClass"))

(cl:defun auto-layout? (obj!)
  "Gets a value indicating whether the fields of the current type are laid out automatically by the common language runtime."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsAutoLayout"))

(cl:defun by-ref? (obj!)
  "Gets a value indicating whether the System.Type is passed by reference."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsByRef"))

(cl:defun by-ref-like? (obj!)
  "Gets a value that indicates whether the type is a byref-like structure."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsByRefLike"))

(cl:defun class? (obj!)
  "Gets a value indicating whether the System.Type is a class or a delegate; that is, not a value type or interface."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsClass"))

(cl:defun com-object? (obj!)
  "Gets a value indicating whether the System.Type is a COM object."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsCOMObject"))

(cl:defun constructed-generic-type? (obj!)
  "Gets a value that indicates whether this object represents a constructed generic type. You can create instances of a constructed generic type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsConstructedGenericType"))

(cl:defun contextful? (obj!)
  "Gets a value indicating whether the System.Type can be hosted in a context."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsContextful"))

(cl:defun enum? (obj!)
  "Gets a value indicating whether the current System.Type represents an enumeration."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsEnum"))

(cl:defun explicit-layout? (obj!)
  "Gets a value indicating whether the fields of the current type are laid out at explicitly specified offsets."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsExplicitLayout"))

(cl:defun function-pointer? (obj!)
  "Gets a value that indicates whether the current System.Type is a function pointer."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsFunctionPointer"))

(cl:defun generic-method-parameter? (obj!)
  "Gets a value that indicates whether the current System.Type represents a type parameter in the definition of a generic method."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsGenericMethodParameter"))

(cl:defun generic-parameter? (obj!)
  "Gets a value indicating whether the current System.Type represents a type parameter in the definition of a generic type or method."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsGenericParameter"))

(cl:defun generic-type? (obj!)
  "Gets a value indicating whether the current type is a generic type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsGenericType"))

(cl:defun generic-type-definition? (obj!)
  "Gets a value indicating whether the current System.Type represents a generic type definition, from which other generic types can be constructed."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsGenericTypeDefinition"))

(cl:defun generic-type-parameter? (obj!)
  "Gets a value that indicates whether the current System.Type represents a type parameter in the definition of a generic type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsGenericTypeParameter"))

(cl:defun import? (obj!)
  "Gets a value indicating whether the System.Type has a System.Runtime.InteropServices.ComImportAttribute attribute applied, indicating that it was imported from a COM type library."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsImport"))

(cl:defun interface? (obj!)
  "Gets a value indicating whether the System.Type is an interface; that is, not a class or a value type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsInterface"))

(cl:defun layout-sequential? (obj!)
  "Gets a value indicating whether the fields of the current type are laid out sequentially, in the order that they were defined or emitted to the metadata."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsLayoutSequential"))

(cl:defun marshal-by-ref? (obj!)
  "Gets a value indicating whether the System.Type is marshaled by reference."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsMarshalByRef"))

(cl:defun nested? (obj!)
  "Gets a value indicating whether the current System.Type object represents a type whose definition is nested inside the definition of another type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsNested"))

(cl:defun nested-assembly? (obj!)
  "Gets a value indicating whether the System.Type is nested and visible only within its own assembly."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsNestedAssembly"))

(cl:defun nested-fam-and-assem? (obj!)
  "Gets a value indicating whether the System.Type is nested and visible only to classes that belong to both its own family and its own assembly."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsNestedFamANDAssem"))

(cl:defun nested-family? (obj!)
  "Gets a value indicating whether the System.Type is nested and visible only within its own family."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsNestedFamily"))

(cl:defun nested-fam-or-assem? (obj!)
  "Gets a value indicating whether the System.Type is nested and visible only to classes that belong to either its own family or to its own assembly."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsNestedFamORAssem"))

(cl:defun nested-private? (obj!)
  "Gets a value indicating whether the System.Type is nested and declared private."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsNestedPrivate"))

(cl:defun nested-public? (obj!)
  "Gets a value indicating whether a class is nested and declared public."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsNestedPublic"))

(cl:defun not-public? (obj!)
  "Gets a value indicating whether the System.Type is not declared public."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsNotPublic"))

(cl:defun pointer? (obj!)
  "Gets a value indicating whether the System.Type is a pointer."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsPointer"))

(cl:defun primitive? (obj!)
  "Gets a value indicating whether the System.Type is one of the primitive types."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsPrimitive"))

(cl:defun public? (obj!)
  "Gets a value indicating whether the System.Type is declared public."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsPublic"))

(cl:defun sealed? (obj!)
  "Gets a value indicating whether the System.Type is declared sealed."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsSealed"))

(cl:defun security-critical? (obj!)
  "Gets a value that indicates whether the current type is security-critical or security-safe-critical at the current trust level, and therefore can perform critical operations."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsSecurityCritical"))

(cl:defun security-safe-critical? (obj!)
  "Gets a value that indicates whether the current type is security-safe-critical at the current trust level; that is, whether it can perform critical operations and can be accessed by transparent code."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsSecuritySafeCritical"))

(cl:defun security-transparent? (obj!)
  "Gets a value that indicates whether the current type is transparent at the current trust level, and therefore cannot perform critical operations."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsSecurityTransparent"))

(cl:defun serializable? (obj!)
  "Gets a value indicating whether the System.Type is binary serializable."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsSerializable"))

(cl:defun signature-type? (obj!)
  "Gets a value that indicates whether the type is a signature type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsSignatureType"))

(cl:defun special-name? (obj!)
  "Gets a value indicating whether the type has a name that requires special handling."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsSpecialName"))

(cl:defun sz-array? (obj!)
  "Gets a value that indicates whether the type is an array type that can represent only a single-dimensional array with a zero lower bound."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsSZArray"))

(cl:defun type-definition? (obj!)
  "Gets a value that indicates whether the type is a type definition."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsTypeDefinition"))

(cl:defun unicode-class? (obj!)
  "Gets a value indicating whether the string format attribute is selected for the System.Type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsUnicodeClass"))

(cl:defun unmanaged-function-pointer? (obj!)
  "Gets a value that indicates whether the current System.Type is an unmanaged function pointer."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsUnmanagedFunctionPointer"))

(cl:defun value-type? (obj!)
  "Gets a value indicating whether the System.Type is a value type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsValueType"))

(cl:defun variable-bound-array? (obj!)
  "Gets a value that indicates whether the type is an array type that can represent a multi-dimensional array or an array with an arbitrary lower bound."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsVariableBoundArray"))

(cl:defun visible? (obj!)
  "Gets a value indicating whether the System.Type can be accessed by code outside the assembly."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_IsVisible"))

(cl:defun member-type (obj!)
  "Gets a System.Reflection.MemberTypes value indicating that this member is a type or a nested type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_MemberType"))

(cl:defun module (obj!)
  "Gets the module (the DLL) in which the current System.Type is defined."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_Module"))

(cl:defun namespace (obj!)
  "Gets the namespace of the System.Type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_Namespace"))

(cl:defun reflected-type (obj!)
  "Gets the class object that was used to obtain this member."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_ReflectedType"))

(cl:defun struct-layout-attribute (obj!)
  "Gets a System.Runtime.InteropServices.StructLayoutAttribute that describes the layout of the current type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_StructLayoutAttribute"))

(cl:defun type-handle (obj!)
  "Gets the handle for the current System.Type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_TypeHandle"))

(cl:defun type-initializer (obj!)
  "Gets the initializer for the type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_TypeInitializer"))

(cl:defun underlying-system-type (obj!)
  "Indicates the type provided by the common language runtime that represents this type."
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "get_UnderlyingSystemType"))

(cl:defun = (left right)
  "Summary: Indicates whether two System.Type objects are equal.
Returns: if left is equal to right; otherwise, .
Parameters:
  - left (System.Type): The first object to compare.
  - right (System.Type): The second object to compare.
"
  (dotnet:static <type-str> "op_Equality" (cl:the (dotnet "System.Type") left) (cl:the (dotnet "System.Type") right)))

(cl:defun equals (obj! o)
  "Master wrapper for System.Type.Equals overloads. Dispatches at runtime.

Equals(Object) -> Boolean
  Summary: Determines if the underlying system type of the current System.Type object is the same as the underlying system type of the specified System.Object.
  Returns: if the underlying system type of o is the same as the underlying system type of the current System.Type; otherwise, . This method also returns if: - o is . - o cannot be cast or converted to a System.Type object.
  Parameters:
    - o (System.Object): The object whose underlying system type is to be compared with the underlying system type of the current System.Type. For the comparison to succeed, o must be able to be cast or converted to an object of type System.Type.

Equals(Type) -> Boolean
  Summary: Determines if the underlying system type of the current System.Type is the same as the underlying system type of the specified System.Type.
  Returns: if the underlying system type of o is the same as the underlying system type of the current System.Type; otherwise, .
  Parameters:
    - o (System.Type): The object whose underlying system type is to be compared with the underlying system type of the current System.Type.
"
  (cl:cond
    ((cl:and (cl:or (cl:null o) (dotnet:object-type o)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "Equals" o))
    ((cl:and (cl:or (cl:null o) (dotnet:object-type o)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "Equals" o))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "Equals"
                    :supplied-args (cl:append (cl:list :o o))))))

(cl:defun find-interfaces (obj! filter filter-criteria)
  "Summary: Returns an array of System.Type objects representing a filtered list of interfaces implemented or inherited by the current System.Type.
Returns: An array of System.Type objects representing a filtered list of the interfaces implemented or inherited by the current System.Type, or an empty array if no interfaces matching the filter are implemented or inherited by the current System.Type.
Parameters:
  - filter (System.Reflection.TypeFilter): The delegate that compares the interfaces against filterCriteria.
  - filter-criteria (System.Object): The search criteria that determines whether an interface should be included in the returned array.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "FindInterfaces" filter filter-criteria))

(cl:defun find-members (obj! member-type binding-attr filter filter-criteria)
  "Summary: Returns a filtered array of System.Reflection.MemberInfo objects of the specified member type.
Returns: A filtered array of System.Reflection.MemberInfo objects of the specified member type. -or- An empty array if the current System.Type does not have members of type memberType that match the filter criteria.
Parameters:
  - member-type (System.Reflection.MemberTypes): A bitwise combination of the enumeration values that indicates the type of member to search for.
  - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
  - filter (System.Reflection.MemberFilter): The delegate that does the comparisons, returning if the member currently being inspected matches the filterCriteria and otherwise.
  - filter-criteria (System.Object): The search criteria that determines whether a member is returned in the array of objects. The fields of , , and can be used in conjunction with the delegate supplied by this class.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "FindMembers" member-type binding-attr filter filter-criteria))

(cl:defun get-array-rank (obj!)
  "Summary: Gets the number of dimensions in an array.
Returns: An integer that contains the number of dimensions in the current type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetArrayRank"))

(cl:defun get-attribute-flags-impl (obj!)
  "Summary: When overridden in a derived class, implements the System.Type.Attributes property and gets a bitwise combination of enumeration values that indicate the attributes associated with the System.Type.
Returns: A System.Reflection.TypeAttributes object representing the attribute set of the System.Type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetAttributeFlagsImpl"))

(cl:defun get-constructor (obj! types cl:&optional (types2 cl:nil supplied-types2) (types3 cl:nil supplied-types3) (modifiers cl:nil supplied-modifiers) (modifiers2 cl:nil supplied-modifiers2))
  "Master wrapper for System.Type.GetConstructor overloads. Dispatches at runtime.

GetConstructor(Type[]) -> ConstructorInfo
  Summary: Searches for a public instance constructor whose parameters match the types in the specified array.
  Returns: An object representing the public instance constructor whose parameters match the types in the parameter type array, if found; otherwise, .
  Parameters:
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the desired constructor. -or- An empty array of System.Type objects, to get a constructor that takes no parameters. Such an empty array is provided by the field System.Type.EmptyTypes.

GetConstructor(BindingFlags, Type[]) -> ConstructorInfo
  Summary: Searches for a constructor whose parameters match the specified argument types, using the specified binding constraints.
  Returns: A System.Reflection.ConstructorInfo object representing the constructor that matches the specified requirements, if found; otherwise, .
  Parameters:
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- Default to return .
    - types (System.Type[]): An array of Type objects representing the number, order, and type of the parameters for the constructor to get. -or- An empty array of the type System.Type (that is, Type[] types = Array.Empty{Type}()) to get a constructor that takes no parameters. -or- System.Type.EmptyTypes.

GetConstructor(BindingFlags, Binder, Type[], ParameterModifier[]) -> ConstructorInfo
  Summary: Searches for a constructor whose parameters match the specified argument types and modifiers, using the specified binding constraints.
  Returns: A System.Reflection.ConstructorInfo object representing the constructor that matches the specified requirements, if found; otherwise, .
  Parameters:
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
    - binder (System.Reflection.Binder): An object that defines a set of properties and enables binding, which can involve selection of an overloaded method, coercion of argument types, and invocation of a member through reflection. -or- A null reference ( in Visual Basic), to use the System.Type.DefaultBinder.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the constructor to get. -or- An empty array of the type System.Type (that is, Type[] types = new Type[0]) to get a constructor that takes no parameters. -or- System.Type.EmptyTypes.
    - modifiers (System.Reflection.ParameterModifier[]): An array of System.Reflection.ParameterModifier objects representing the attributes associated with the corresponding element in the parameter type array. The default binder does not process this parameter.

GetConstructor(BindingFlags, Binder, CallingConventions, Type[], ParameterModifier[]) -> ConstructorInfo
  Summary: Searches for a constructor whose parameters match the specified argument types and modifiers, using the specified binding constraints and the specified calling convention.
  Returns: An object representing the constructor that matches the specified requirements, if found; otherwise, .
  Parameters:
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
    - binder (System.Reflection.Binder): An object that defines a set of properties and enables binding, which can involve selection of an overloaded method, coercion of argument types, and invocation of a member through reflection. -or- A null reference ( in Visual Basic), to use the System.Type.DefaultBinder.
    - call-convention (System.Reflection.CallingConventions): The object that specifies the set of rules to use regarding the order and layout of arguments, how the return value is passed, what registers are used for arguments, and the stack is cleaned up.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the constructor to get. -or- An empty array of the type System.Type (that is, Type[] types = new Type[0]) to get a constructor that takes no parameters.
    - modifiers (System.Reflection.ParameterModifier[]): An array of System.Reflection.ParameterModifier objects representing the attributes associated with the corresponding element in the types array. The default binder does not process this parameter.
"
  (cl:cond
    ((cl:and (cl:or (cl:null types) (dotnet:object-type types)) supplied-types2 (cl:or (cl:null types2) (dotnet:object-type types2)) supplied-types3 (cl:or (cl:null types3) (dotnet:object-type types3)) supplied-modifiers (cl:or (cl:null modifiers) (dotnet:object-type modifiers)) supplied-modifiers2 (cl:or (cl:null modifiers2) (dotnet:object-type modifiers2)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetConstructor" types types2 types3 modifiers modifiers2))
    ((cl:and (cl:or (cl:null types) (dotnet:object-type types)) supplied-types2 (cl:or (cl:null types2) (dotnet:object-type types2)) supplied-types3 (cl:or (cl:null types3) (dotnet:object-type types3)) supplied-modifiers (cl:or (cl:null modifiers) (dotnet:object-type modifiers)) (cl:not supplied-modifiers2))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetConstructor" types types2 types3 modifiers))
    ((cl:and (cl:or (cl:null types) (dotnet:object-type types)) supplied-types2 (cl:or (cl:null types2) (dotnet:object-type types2)) (cl:not supplied-types3) (cl:not supplied-modifiers) (cl:not supplied-modifiers2))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetConstructor" types types2))
    ((cl:and (cl:or (cl:null types) (dotnet:object-type types)) (cl:not supplied-types2) (cl:not supplied-types3) (cl:not supplied-modifiers) (cl:not supplied-modifiers2))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetConstructor" types))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetConstructor"
                    :supplied-args (cl:append (cl:list :types types) (cl:when supplied-types2 (cl:list :types2 types2)) (cl:when supplied-types3 (cl:list :types3 types3)) (cl:when supplied-modifiers (cl:list :modifiers modifiers)) (cl:when supplied-modifiers2 (cl:list :modifiers2 modifiers2)))))))

(cl:defun get-constructor-impl (obj! binding-attr binder call-convention types modifiers)
  "Summary: When overridden in a derived class, searches for a constructor whose parameters match the specified argument types and modifiers, using the specified binding constraints and the specified calling convention.
Returns: A System.Reflection.ConstructorInfo object representing the constructor that matches the specified requirements, if found; otherwise, .
Parameters:
  - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
  - binder (System.Reflection.Binder): An object that defines a set of properties and enables binding, which can involve selection of an overloaded method, coercion of argument types, and invocation of a member through reflection. -or- A null reference ( in Visual Basic), to use the System.Type.DefaultBinder.
  - call-convention (System.Reflection.CallingConventions): The object that specifies the set of rules to use regarding the order and layout of arguments, how the return value is passed, what registers are used for arguments, and the stack is cleaned up.
  - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the constructor to get. -or- An empty array of the type System.Type (that is, Type[] types = new Type[0]) to get a constructor that takes no parameters.
  - modifiers (System.Reflection.ParameterModifier[]): An array of System.Reflection.ParameterModifier objects representing the attributes associated with the corresponding element in the types array. The default binder does not process this parameter.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetConstructorImpl" binding-attr binder call-convention types modifiers))

(cl:defun get-constructors (obj! cl:&optional (binding-attr cl:nil supplied-binding-attr))
  "Master wrapper for System.Type.GetConstructors overloads. Dispatches at runtime.

GetConstructors() -> ConstructorInfo[]
  Summary: Returns all the public constructors defined for the current System.Type.
  Returns: An array of System.Reflection.ConstructorInfo objects representing all the public instance constructors defined for the current System.Type, but not including the type initializer (static constructor). If no public instance constructors are defined for the current System.Type, or if the current System.Type represents a type parameter in the definition of a generic type or generic method, an empty array of type System.Reflection.ConstructorInfo is returned.

GetConstructors(BindingFlags) -> ConstructorInfo[]
  Summary: When overridden in a derived class, searches for the constructors defined for the current System.Type, using the specified .
  Returns: An array of System.Reflection.ConstructorInfo objects representing all constructors defined for the current System.Type that match the specified binding constraints, including the type initializer if it's defined. Returns an empty array of type System.Reflection.ConstructorInfo if no constructors are defined for the current System.Type, if none of the defined constructors match the binding constraints, or if the current System.Type represents a type parameter in the definition of a generic type or generic method.
  Parameters:
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return an empty array.
"
  (cl:cond
    ((cl:and supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetConstructors" binding-attr))
    ((cl:and (cl:not supplied-binding-attr))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetConstructors"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetConstructors"
                    :supplied-args (cl:append (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)))))))

(cl:defun get-default-members (obj!)
  "Summary: Searches for the members defined for the current System.Type whose System.Reflection.DefaultMemberAttribute is set.
Returns: An array of System.Reflection.MemberInfo objects representing all default members of the current System.Type. -or- An empty array of type System.Reflection.MemberInfo, if the current System.Type does not have default members.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetDefaultMembers"))

(cl:defun get-element-type (obj!)
  "Summary: When overridden in a derived class, returns the System.Type of the object encompassed or referred to by the current array, pointer or reference type.
Returns: The System.Type of the object encompassed or referred to by the current array, pointer, or reference type, or if the current System.Type is not an array or a pointer, or is not passed by reference, or represents a generic type or a type parameter in the definition of a generic type or generic method.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetElementType"))

(cl:defun get-enum-name (obj! value)
  "Summary: Returns the name of the constant that has the specified value, for the current enumeration type.
Returns: The name of the member of the current enumeration type that has the specified value, or if no such constant is found.
Parameters:
  - value (System.Object): The value whose name is to be retrieved.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetEnumName" value))

(cl:defun get-enum-names (obj!)
  "Summary: Returns the names of the members of the current enumeration type.
Returns: An array that contains the names of the members of the enumeration.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetEnumNames"))

(cl:defun get-enum-underlying-type (obj!)
  "Summary: Returns the underlying type of the current enumeration type.
Returns: The underlying type of the current enumeration.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetEnumUnderlyingType"))

(cl:defun get-enum-values (obj!)
  "Summary: Returns an array of the values of the constants in the current enumeration type.
Returns: An array that contains the values. The elements of the array are sorted by the binary values (that is, the unsigned values) of the enumeration constants.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetEnumValues"))

(cl:defun get-enum-values-as-underlying-type (obj!)
  "Summary: Retrieves an array of the values of the underlying type constants of this enumeration type.
Returns: An array that contains the values of the underlying type constants in this enumeration type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetEnumValuesAsUnderlyingType"))

(cl:defun get-event (obj! name cl:&optional (binding-attr cl:nil supplied-binding-attr))
  "Master wrapper for System.Type.GetEvent overloads. Dispatches at runtime.

GetEvent(String) -> EventInfo
  Summary: Returns the System.Reflection.EventInfo object representing the specified public event.
  Returns: The object representing the specified public event that is declared or inherited by the current System.Type, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of an event that is declared or inherited by the current System.Type.

GetEvent(String, BindingFlags) -> EventInfo
  Summary: When overridden in a derived class, returns the System.Reflection.EventInfo object representing the specified event, using the specified binding constraints.
  Returns: The object representing the specified event that is declared or inherited by the current System.Type, if found; otherwise, .
  Parameters:
    - name (System.String): The name of an event that is declared or inherited by the current System.Type.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
"
  (cl:cond
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetEvent" name binding-attr))
    ((cl:and (cl:stringp name) (cl:not supplied-binding-attr))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetEvent" name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetEvent"
                    :supplied-args (cl:append (cl:list :name name) (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)))))))

(cl:defun get-events (obj! cl:&optional (binding-attr cl:nil supplied-binding-attr))
  "Master wrapper for System.Type.GetEvents overloads. Dispatches at runtime.

GetEvents() -> EventInfo[]
  Summary: Returns all the public events that are declared or inherited by the current System.Type.
  Returns: An array of System.Reflection.EventInfo objects representing all the public events which are declared or inherited by the current System.Type. -or- An empty array of type System.Reflection.EventInfo, if the current System.Type does not have public events.

GetEvents(BindingFlags) -> EventInfo[]
  Summary: When overridden in a derived class, searches for events that are declared or inherited by the current System.Type, using the specified binding constraints.
  Returns: An array of System.Reflection.EventInfo objects representing all events that are declared or inherited by the current System.Type that match the specified binding constraints. -or- An empty array of type System.Reflection.EventInfo, if the current System.Type does not have events, or if none of the events match the binding constraints.
  Parameters:
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return an empty array.
"
  (cl:cond
    ((cl:and supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetEvents" binding-attr))
    ((cl:and (cl:not supplied-binding-attr))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetEvents"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetEvents"
                    :supplied-args (cl:append (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)))))))

(cl:defun get-field (obj! name cl:&optional (binding-attr cl:nil supplied-binding-attr))
  "Master wrapper for System.Type.GetField overloads. Dispatches at runtime.

GetField(String) -> FieldInfo
  Summary: Searches for the public field with the specified name.
  Returns: An object representing the public field with the specified name, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the data field to get.

GetField(String, BindingFlags) -> FieldInfo
  Summary: Searches for the specified field, using the specified binding constraints.
  Returns: An object representing the field that matches the specified requirements, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the data field to get.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
"
  (cl:cond
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetField" name binding-attr))
    ((cl:and (cl:stringp name) (cl:not supplied-binding-attr))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetField" name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetField"
                    :supplied-args (cl:append (cl:list :name name) (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)))))))

(cl:defun get-fields (obj! cl:&optional (binding-attr cl:nil supplied-binding-attr))
  "Master wrapper for System.Type.GetFields overloads. Dispatches at runtime.

GetFields() -> FieldInfo[]
  Summary: Returns all the public fields of the current System.Type.
  Returns: An array of System.Reflection.FieldInfo objects representing all the public fields defined for the current System.Type. -or- An empty array of type System.Reflection.FieldInfo, if no public fields are defined for the current System.Type.

GetFields(BindingFlags) -> FieldInfo[]
  Summary: When overridden in a derived class, searches for the fields defined for the current System.Type, using the specified binding constraints.
  Returns: An array of System.Reflection.FieldInfo objects representing all fields defined for the current System.Type that match the specified binding constraints. -or- An empty array of type System.Reflection.FieldInfo, if no fields are defined for the current System.Type, or if none of the defined fields match the binding constraints.
  Parameters:
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return an empty array.
"
  (cl:cond
    ((cl:and supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetFields" binding-attr))
    ((cl:and (cl:not supplied-binding-attr))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetFields"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetFields"
                    :supplied-args (cl:append (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)))))))

(cl:defun get-function-pointer-calling-conventions (obj!)
  "Summary: When overridden in a derived class, returns the calling conventions of the current function pointer System.Type.
Returns: An array of System.Type objects representing all the calling conventions for the current function pointer System.Type.-or-An empty array of type System.Type, if no calling conventions are defined for the current function pointer System.Type.-or-An empty array of type System.Type, if the current function pointer System.Type is not a modified System.Type. A modified System.Type is obtained from System.Reflection.FieldInfo.GetModifiedFieldType, System.Reflection.PropertyInfo.GetModifiedPropertyType, or System.Reflection.ParameterInfo.GetModifiedParameterType.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetFunctionPointerCallingConventions"))

(cl:defun get-function-pointer-parameter-types (obj!)
  "Summary: When overridden in a derived class, returns the parameter types of the current function pointer System.Type.
Returns: An array of System.Type objects representing all the parameter types for the current function pointer System.Type.-or-An empty array of type System.Type, if no parameters are defined for the current function pointer System.Type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetFunctionPointerParameterTypes"))

(cl:defun get-function-pointer-return-type (obj!)
  "Summary: When overridden in a derived class, returns the return type of the current function pointer System.Type.
Returns: A System.Type object representing the return type for the current function pointer System.Type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetFunctionPointerReturnType"))

(cl:defun get-generic-arguments (obj!)
  "Summary: Returns an array of System.Type objects that represent the type arguments of a closed generic type or the type parameters of a generic type definition.
Returns: An array of System.Type objects that represent the type arguments of a generic type. Returns an empty array if the current type is not a generic type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetGenericArguments"))

(cl:defun get-generic-parameter-constraints (obj!)
  "Summary: Returns an array of System.Type objects that represent the constraints on the current generic type parameter.
Returns: An array of System.Type objects that represent the constraints on the current generic type parameter.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetGenericParameterConstraints"))

(cl:defun get-generic-type-definition (obj!)
  "Summary: Returns a System.Type object that represents a generic type definition from which the current generic type can be constructed.
Returns: A System.Type object representing a generic type from which the current type can be constructed.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetGenericTypeDefinition"))

(cl:defun get-hash-code (obj!)
  "Summary: Returns the hash code for this instance.
Returns: The hash code for this instance.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetHashCode"))

(cl:defun get-interface (obj! name cl:&optional (ignore-case cl:nil supplied-ignore-case))
  "Master wrapper for System.Type.GetInterface overloads. Dispatches at runtime.

GetInterface(String) -> Type
  Summary: Searches for the interface with the specified name.
  Returns: An object representing the interface with the specified name, implemented or inherited by the current System.Type, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the interface to get. For generic interfaces, this is the mangled name.

GetInterface(String, Boolean) -> Type
  Summary: When overridden in a derived class, searches for the specified interface, specifying whether to do a case-insensitive search for the interface name.
  Returns: An object representing the interface with the specified name, implemented or inherited by the current System.Type, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the interface to get. For generic interfaces, this is the mangled name.
    - ignore-case (System.Boolean): to ignore the case of that part of name that specifies the simple interface name (the part that specifies the namespace must be correctly cased). -or- to perform a case-sensitive search for all parts of name.
"
  (cl:cond
    ((cl:and (cl:stringp name) supplied-ignore-case (cl:typep ignore-case 'cl:boolean))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetInterface" name ignore-case))
    ((cl:and (cl:stringp name) (cl:not supplied-ignore-case))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetInterface" name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetInterface"
                    :supplied-args (cl:append (cl:list :name name) (cl:when supplied-ignore-case (cl:list :ignore-case ignore-case)))))))

(cl:defun get-interface-map (obj! interface-type)
  "Summary: Returns an interface mapping for the specified interface type.
Returns: An object that represents the interface mapping for interfaceType.
Parameters:
  - interface-type (System.Type): The interface type to retrieve a mapping for.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetInterfaceMap" interface-type))

(cl:defun get-interfaces (obj!)
  "Summary: When overridden in a derived class, gets all the interfaces implemented or inherited by the current System.Type.
Returns: An array of System.Type objects representing all the interfaces implemented or inherited by the current System.Type. -or- An empty array of type System.Type, if no interfaces are implemented or inherited by the current System.Type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetInterfaces"))

(cl:defun get-member (obj! name cl:&optional (binding-attr cl:nil supplied-binding-attr) (binding-attr2 cl:nil supplied-binding-attr2))
  "Master wrapper for System.Type.GetMember overloads. Dispatches at runtime.

GetMember(String) -> MemberInfo[]
  Summary: Searches for the public members with the specified name.
  Returns: An array of System.Reflection.MemberInfo objects representing the public members with the specified name, if found; otherwise, an empty array.
  Parameters:
    - name (System.String): The string containing the name of the public members to get.

GetMember(String, BindingFlags) -> MemberInfo[]
  Summary: Searches for the specified members, using the specified binding constraints.
  Returns: An array of System.Reflection.MemberInfo objects representing the public members with the specified name, if found; otherwise, an empty array.
  Parameters:
    - name (System.String): The string containing the name of the members to get.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return an empty array.

GetMember(String, MemberTypes, BindingFlags) -> MemberInfo[]
  Summary: Searches for the specified members of the specified member type, using the specified binding constraints.
  Returns: An array of System.Reflection.MemberInfo objects representing the public members with the specified name, if found; otherwise, an empty array.
  Parameters:
    - name (System.String): The string containing the name of the members to get.
    - type (System.Reflection.MemberTypes): The value to search for.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return an empty array.
"
  (cl:cond
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) supplied-binding-attr2 (cl:or (cl:null binding-attr2) (dotnet:object-type binding-attr2)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMember" name binding-attr binding-attr2))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) (cl:not supplied-binding-attr2))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMember" name binding-attr))
    ((cl:and (cl:stringp name) (cl:not supplied-binding-attr) (cl:not supplied-binding-attr2))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMember" name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetMember"
                    :supplied-args (cl:append (cl:list :name name) (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)) (cl:when supplied-binding-attr2 (cl:list :binding-attr2 binding-attr2)))))))

(cl:defun get-members (obj! cl:&optional (binding-attr cl:nil supplied-binding-attr))
  "Master wrapper for System.Type.GetMembers overloads. Dispatches at runtime.

GetMembers() -> MemberInfo[]
  Summary: Returns all the public members of the current System.Type.
  Returns: An array of System.Reflection.MemberInfo objects representing all the public members of the current System.Type. -or- An empty array of type System.Reflection.MemberInfo, if the current System.Type does not have public members.

GetMembers(BindingFlags) -> MemberInfo[]
  Summary: When overridden in a derived class, searches for the members defined for the current System.Type, using the specified binding constraints.
  Returns: An array of System.Reflection.MemberInfo objects representing all members defined for the current System.Type that match the specified binding constraints. -or- An empty array if no members are defined for the current System.Type, or if none of the defined members match the binding constraints.
  Parameters:
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return an empty array.
"
  (cl:cond
    ((cl:and supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMembers" binding-attr))
    ((cl:and (cl:not supplied-binding-attr))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMembers"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetMembers"
                    :supplied-args (cl:append (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)))))))

(cl:defun get-member-with-same-metadata-definition-as (obj! member)
  "Summary: Searches for the System.Reflection.MemberInfo on the current System.Type that matches the specified System.Reflection.MemberInfo.
Returns: An object representing the member on the current System.Type that matches the specified member.
Parameters:
  - member (System.Reflection.MemberInfo): The System.Reflection.MemberInfo to find on the current System.Type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMemberWithSameMetadataDefinitionAs" member))

(cl:defun get-method (obj! name cl:&optional (binding-attr cl:nil supplied-binding-attr) (types cl:nil supplied-types) (modifiers cl:nil supplied-modifiers) (modifiers2 cl:nil supplied-modifiers2) (modifiers3 cl:nil supplied-modifiers3) (modifiers4 cl:nil supplied-modifiers4))
  "Master wrapper for System.Type.GetMethod overloads. Dispatches at runtime.

GetMethod(String) -> MethodInfo
  Summary: Searches for the public method with the specified name.
  Returns: An object that represents the public method with the specified name, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the public method to get.

GetMethod(String, BindingFlags) -> MethodInfo
  Summary: Searches for the specified method, using the specified binding constraints.
  Returns: An object representing the method that matches the specified requirements, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the method to get.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .

GetMethod(String, Type[]) -> MethodInfo
  Summary: Searches for the specified public method whose parameters match the specified argument types.
  Returns: An object representing the public method whose parameters match the specified argument types, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the public method to get.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the method to get. -or- An empty array of System.Type objects (as provided by the System.Type.EmptyTypes field) to get a method that takes no parameters.

GetMethod(String, BindingFlags, Type[]) -> MethodInfo
  Summary: Searches for the specified method whose parameters match the specified argument types, using the specified binding constraints.
  Returns: An object representing the method that matches the specified requirements, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the method to get.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- Default to return .
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the method to get. -or- An empty array of System.Type objects (as provided by the System.Type.EmptyTypes field) to get a method that takes no parameters.

GetMethod(String, Type[], ParameterModifier[]) -> MethodInfo
  Summary: Searches for the specified public method whose parameters match the specified argument types and modifiers.
  Returns: An object representing the public method that matches the specified requirements, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the public method to get.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the method to get. -or- An empty array of System.Type objects (as provided by the System.Type.EmptyTypes field) to get a method that takes no parameters.
    - modifiers (System.Reflection.ParameterModifier[]): An array of System.Reflection.ParameterModifier objects representing the attributes associated with the corresponding element in the types array. To be only used when calling through COM interop, and only parameters that are passed by reference are handled. The default binder does not process this parameter.

GetMethod(String, Int32, Type[]) -> MethodInfo
  Summary: Searches for the specified public method whose parameters match the specified generic parameter count and argument types.
  Returns: An object representing the public method whose parameters match the specified generic parameter count and argument types, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the public method to get.
    - generic-parameter-count (System.Int32): The number of generic type parameters of the method.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the method to get. -or- An empty array of System.Type objects (as provided by the System.Type.EmptyTypes field) to get a method that takes no parameters.

GetMethod(String, Int32, Type[], ParameterModifier[]) -> MethodInfo
  Summary: Searches for the specified public method whose parameters match the specified generic parameter count, argument types and modifiers.
  Returns: An object representing the public method that matches the specified generic parameter count, argument types and modifiers, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the public method to get.
    - generic-parameter-count (System.Int32): The number of generic type parameters of the method.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the method to get. -or- An empty array of System.Type objects (as provided by the System.Type.EmptyTypes field) to get a method that takes no parameters.
    - modifiers (System.Reflection.ParameterModifier[]): An array of System.Reflection.ParameterModifier objects representing the attributes associated with the corresponding element in the types array. To be only used when calling through COM interop, and only parameters that are passed by reference are handled. The default binder does not process this parameter.

GetMethod(String, Int32, BindingFlags, Type[]) -> MethodInfo
  Summary: Searches for the specified method whose parameters match the specified generic parameter count and argument types, using the specified binding constraints.
  Returns: An object representing the method that matches the specified generic parameter count, argument types, and binding constraints, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the method to get.
    - generic-parameter-count (System.Int32): The number of generic type parameters of the method.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the method to get. -or- An empty array of System.Type objects (as provided by the System.Type.EmptyTypes field) to get a method that takes no parameters.

GetMethod(String, BindingFlags, Binder, Type[], ParameterModifier[]) -> MethodInfo
  Summary: Searches for the specified method whose parameters match the specified argument types and modifiers, using the specified binding constraints.
  Returns: An object representing the method that matches the specified requirements, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the method to get.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
    - binder (System.Reflection.Binder): An object that defines a set of properties and enables binding, which can involve selection of an overloaded method, coercion of argument types, and invocation of a member through reflection. -or- A null reference ( in Visual Basic), to use the System.Type.DefaultBinder.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the method to get. -or- An empty array of System.Type objects (as provided by the System.Type.EmptyTypes field) to get a method that takes no parameters.
    - modifiers (System.Reflection.ParameterModifier[]): An array of System.Reflection.ParameterModifier objects representing the attributes associated with the corresponding element in the types array. To be only used when calling through COM interop, and only parameters that are passed by reference are handled. The default binder does not process this parameter.

GetMethod(String, BindingFlags, Binder, CallingConventions, Type[], ParameterModifier[]) -> MethodInfo
  Summary: Searches for the specified method whose parameters match the specified argument types and modifiers, using the specified binding constraints and the specified calling convention.
  Returns: An object representing the method that matches the specified requirements, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the method to get.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
    - binder (System.Reflection.Binder): An object that defines a set of properties and enables binding, which can involve selection of an overloaded method, coercion of argument types, and invocation of a member through reflection. -or- A null reference ( in Visual Basic), to use the System.Type.DefaultBinder.
    - call-convention (System.Reflection.CallingConventions): The object that specifies the set of rules to use regarding the order and layout of arguments, how the return value is passed, what registers are used for arguments, and how the stack is cleaned up.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the method to get. -or- An empty array of System.Type objects (as provided by the System.Type.EmptyTypes field) to get a method that takes no parameters.
    - modifiers (System.Reflection.ParameterModifier[]): An array of System.Reflection.ParameterModifier objects representing the attributes associated with the corresponding element in the types array. To be only used when calling through COM interop, and only parameters that are passed by reference are handled. The default binder does not process this parameter.

GetMethod(String, Int32, BindingFlags, Binder, Type[], ParameterModifier[]) -> MethodInfo
  Summary: Searches for the specified method whose parameters match the specified generic parameter count, argument types and modifiers, using the specified binding constraints.
  Returns: An object representing the method that matches the specified generic parameter count, argument types, modifiers and binding constraints, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the public method to get.
    - generic-parameter-count (System.Int32): The number of generic type parameters of the method.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
    - binder (System.Reflection.Binder): An object that defines a set of properties and enables binding, which can involve selection of an overloaded method, coercion of argument types, and invocation of a member through reflection. -or- A null reference ( in Visual Basic), to use the System.Type.DefaultBinder.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the method to get. -or- An empty array of System.Type objects (as provided by the System.Type.EmptyTypes field) to get a method that takes no parameters.
    - modifiers (System.Reflection.ParameterModifier[]): An array of System.Reflection.ParameterModifier objects representing the attributes associated with the corresponding element in the types array. To be only used when calling through COM interop, and only parameters that are passed by reference are handled. The default binder does not process this parameter.

GetMethod(String, Int32, BindingFlags, Binder, CallingConventions, Type[], ParameterModifier[]) -> MethodInfo
  Summary: Searches for the specified method whose parameters match the specified generic parameter count, argument types and modifiers, using the specified binding constraints and the specified calling convention.
  Returns: An object representing the method that matches the specified generic parameter count, argument types, modifiers, binding constraints and calling convention, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the public method to get.
    - generic-parameter-count (System.Int32): The number of generic type parameters of the method.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
    - binder (System.Reflection.Binder): An object that defines a set of properties and enables binding, which can involve selection of an overloaded method, coercion of argument types, and invocation of a member through reflection. -or- A null reference ( in Visual Basic), to use the System.Type.DefaultBinder.
    - call-convention (System.Reflection.CallingConventions): The object that specifies the set of rules to use regarding the order and layout of arguments, how the return value is passed, what registers are used for arguments, and how the stack is cleaned up.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the method to get. -or- An empty array of System.Type objects (as provided by the System.Type.EmptyTypes field) to get a method that takes no parameters.
    - modifiers (System.Reflection.ParameterModifier[]): An array of System.Reflection.ParameterModifier objects representing the attributes associated with the corresponding element in the types array. To be only used when calling through COM interop, and only parameters that are passed by reference are handled. The default binder does not process this parameter.
"
  (cl:cond
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:numberp binding-attr) supplied-types (cl:or (cl:null types) (dotnet:object-type types)) supplied-modifiers (cl:or (cl:null modifiers) (dotnet:object-type modifiers)) supplied-modifiers2 (cl:or (cl:null modifiers2) (dotnet:object-type modifiers2)) supplied-modifiers3 (cl:or (cl:null modifiers3) (dotnet:object-type modifiers3)) supplied-modifiers4 (cl:or (cl:null modifiers4) (dotnet:object-type modifiers4)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethod" name binding-attr types modifiers modifiers2 modifiers3 modifiers4))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) supplied-types (cl:or (cl:null types) (dotnet:object-type types)) supplied-modifiers (cl:or (cl:null modifiers) (dotnet:object-type modifiers)) supplied-modifiers2 (cl:or (cl:null modifiers2) (dotnet:object-type modifiers2)) supplied-modifiers3 (cl:or (cl:null modifiers3) (dotnet:object-type modifiers3)) (cl:not supplied-modifiers4))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethod" name binding-attr types modifiers modifiers2 modifiers3))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:numberp binding-attr) supplied-types (cl:or (cl:null types) (dotnet:object-type types)) supplied-modifiers (cl:or (cl:null modifiers) (dotnet:object-type modifiers)) supplied-modifiers2 (cl:or (cl:null modifiers2) (dotnet:object-type modifiers2)) supplied-modifiers3 (cl:or (cl:null modifiers3) (dotnet:object-type modifiers3)) (cl:not supplied-modifiers4))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethod" name binding-attr types modifiers modifiers2 modifiers3))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) supplied-types (cl:or (cl:null types) (dotnet:object-type types)) supplied-modifiers (cl:or (cl:null modifiers) (dotnet:object-type modifiers)) supplied-modifiers2 (cl:or (cl:null modifiers2) (dotnet:object-type modifiers2)) (cl:not supplied-modifiers3) (cl:not supplied-modifiers4))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethod" name binding-attr types modifiers modifiers2))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:numberp binding-attr) supplied-types (cl:or (cl:null types) (dotnet:object-type types)) supplied-modifiers (cl:or (cl:null modifiers) (dotnet:object-type modifiers)) (cl:not supplied-modifiers2) (cl:not supplied-modifiers3) (cl:not supplied-modifiers4))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethod" name binding-attr types modifiers))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:numberp binding-attr) supplied-types (cl:or (cl:null types) (dotnet:object-type types)) supplied-modifiers (cl:or (cl:null modifiers) (dotnet:object-type modifiers)) (cl:not supplied-modifiers2) (cl:not supplied-modifiers3) (cl:not supplied-modifiers4))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethod" name binding-attr types modifiers))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) supplied-types (cl:or (cl:null types) (dotnet:object-type types)) (cl:not supplied-modifiers) (cl:not supplied-modifiers2) (cl:not supplied-modifiers3) (cl:not supplied-modifiers4))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethod" name binding-attr types))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) supplied-types (cl:or (cl:null types) (dotnet:object-type types)) (cl:not supplied-modifiers) (cl:not supplied-modifiers2) (cl:not supplied-modifiers3) (cl:not supplied-modifiers4))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethod" name binding-attr types))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:numberp binding-attr) supplied-types (cl:or (cl:null types) (dotnet:object-type types)) (cl:not supplied-modifiers) (cl:not supplied-modifiers2) (cl:not supplied-modifiers3) (cl:not supplied-modifiers4))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethod" name binding-attr types))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) (cl:not supplied-types) (cl:not supplied-modifiers) (cl:not supplied-modifiers2) (cl:not supplied-modifiers3) (cl:not supplied-modifiers4))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethod" name binding-attr))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) (cl:not supplied-types) (cl:not supplied-modifiers) (cl:not supplied-modifiers2) (cl:not supplied-modifiers3) (cl:not supplied-modifiers4))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethod" name binding-attr))
    ((cl:and (cl:stringp name) (cl:not supplied-binding-attr) (cl:not supplied-types) (cl:not supplied-modifiers) (cl:not supplied-modifiers2) (cl:not supplied-modifiers3) (cl:not supplied-modifiers4))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethod" name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetMethod"
                    :supplied-args (cl:append (cl:list :name name) (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)) (cl:when supplied-types (cl:list :types types)) (cl:when supplied-modifiers (cl:list :modifiers modifiers)) (cl:when supplied-modifiers2 (cl:list :modifiers2 modifiers2)) (cl:when supplied-modifiers3 (cl:list :modifiers3 modifiers3)) (cl:when supplied-modifiers4 (cl:list :modifiers4 modifiers4)))))))

(cl:defun get-method-impl (obj! name binding-attr binder call-convention types modifiers cl:&optional (modifiers2 cl:nil supplied-modifiers2))
  "Master wrapper for System.Type.GetMethodImpl overloads. Dispatches at runtime.

GetMethodImpl(String, BindingFlags, Binder, CallingConventions, Type[], ParameterModifier[]) -> MethodInfo
  Summary: When overridden in a derived class, searches for the specified method whose parameters match the specified argument types and modifiers, using the specified binding constraints and the specified calling convention.
  Returns: An object representing the method that matches the specified requirements, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the method to get.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
    - binder (System.Reflection.Binder): An object that defines a set of properties and enables binding, which can involve selection of an overloaded method, coercion of argument types, and invocation of a member through reflection. -or- A null reference ( in Visual Basic), to use the System.Type.DefaultBinder.
    - call-convention (System.Reflection.CallingConventions): The object that specifies the set of rules to use regarding the order and layout of arguments, how the return value is passed, what registers are used for arguments, and what process cleans up the stack.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the method to get. -or- An empty array of the type System.Type (that is, Type[] types = new Type[0]) to get a method that takes no parameters. -or- . If types is , arguments are not matched.
    - modifiers (System.Reflection.ParameterModifier[]): An array of System.Reflection.ParameterModifier objects representing the attributes associated with the corresponding element in the types array. The default binder does not process this parameter.

GetMethodImpl(String, Int32, BindingFlags, Binder, CallingConventions, Type[], ParameterModifier[]) -> MethodInfo
  Summary: When overridden in a derived class, searches for the specified method whose parameters match the specified generic parameter count, argument types and modifiers, using the specified binding constraints and the specified calling convention.
  Returns: An object representing the method that matches the specified generic parameter count, argument types, modifiers, binding constraints and calling convention, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the method to get.
    - generic-parameter-count (System.Int32): The number of generic type parameters of the method.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
    - binder (System.Reflection.Binder): An object that defines a set of properties and enables binding, which can involve selection of an overloaded method, coercion of argument types, and invocation of a member through reflection. -or- A null reference ( in Visual Basic), to use the System.Type.DefaultBinder.
    - call-convention (System.Reflection.CallingConventions): The object that specifies the set of rules to use regarding the order and layout of arguments, how the return value is passed, what registers are used for arguments, and what process cleans up the stack.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the method to get. -or- An empty array of the type System.Type (that is, Type[] types = new Type[0]) to get a method that takes no parameters. -or- . If types is , arguments are not matched.
    - modifiers (System.Reflection.ParameterModifier[]): An array of System.Reflection.ParameterModifier objects representing the attributes associated with the corresponding element in the types array. The default binder does not process this parameter.
"
  (cl:cond
    ((cl:and (cl:stringp name) (cl:numberp binding-attr) (cl:or (cl:null binder) (dotnet:object-type binder)) (cl:or (cl:null call-convention) (dotnet:object-type call-convention)) (cl:or (cl:null types) (dotnet:object-type types)) (cl:or (cl:null modifiers) (dotnet:object-type modifiers)) supplied-modifiers2 (cl:or (cl:null modifiers2) (dotnet:object-type modifiers2)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethodImpl" name binding-attr binder call-convention types modifiers modifiers2))
    ((cl:and (cl:stringp name) (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) (cl:or (cl:null binder) (dotnet:object-type binder)) (cl:or (cl:null call-convention) (dotnet:object-type call-convention)) (cl:or (cl:null types) (dotnet:object-type types)) (cl:or (cl:null modifiers) (dotnet:object-type modifiers)) (cl:not supplied-modifiers2))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethodImpl" name binding-attr binder call-convention types modifiers))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetMethodImpl"
                    :supplied-args (cl:append (cl:list :name name) (cl:list :binding-attr binding-attr) (cl:list :binder binder) (cl:list :call-convention call-convention) (cl:list :types types) (cl:list :modifiers modifiers) (cl:when supplied-modifiers2 (cl:list :modifiers2 modifiers2)))))))

(cl:defun get-methods (obj! cl:&optional (binding-attr cl:nil supplied-binding-attr))
  "Master wrapper for System.Type.GetMethods overloads. Dispatches at runtime.

GetMethods() -> MethodInfo[]
  Summary: Returns all the public methods of the current System.Type.
  Returns: An array of System.Reflection.MethodInfo objects representing all the public methods defined for the current System.Type. -or- An empty array of type System.Reflection.MethodInfo, if no public methods are defined for the current System.Type.

GetMethods(BindingFlags) -> MethodInfo[]
  Summary: When overridden in a derived class, searches for the methods defined for the current System.Type, using the specified binding constraints.
  Returns: An array of System.Reflection.MethodInfo objects representing all methods defined for the current System.Type that match the specified binding constraints. -or- An empty array of type System.Reflection.MethodInfo, if no methods are defined for the current System.Type, or if none of the defined methods match the binding constraints.
  Parameters:
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return an empty array.
"
  (cl:cond
    ((cl:and supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethods" binding-attr))
    ((cl:and (cl:not supplied-binding-attr))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetMethods"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetMethods"
                    :supplied-args (cl:append (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)))))))

(cl:defun get-nested-type (obj! name cl:&optional (binding-attr cl:nil supplied-binding-attr))
  "Master wrapper for System.Type.GetNestedType overloads. Dispatches at runtime.

GetNestedType(String) -> Type
  Summary: Searches for the public nested type with the specified name.
  Returns: An object representing the public nested type with the specified name, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the nested type to get.

GetNestedType(String, BindingFlags) -> Type
  Summary: When overridden in a derived class, searches for the specified nested type, using the specified binding constraints.
  Returns: An object representing the nested type that matches the specified requirements, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the nested type to get.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
"
  (cl:cond
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetNestedType" name binding-attr))
    ((cl:and (cl:stringp name) (cl:not supplied-binding-attr))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetNestedType" name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetNestedType"
                    :supplied-args (cl:append (cl:list :name name) (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)))))))

(cl:defun get-nested-types (obj! cl:&optional (binding-attr cl:nil supplied-binding-attr))
  "Master wrapper for System.Type.GetNestedTypes overloads. Dispatches at runtime.

GetNestedTypes() -> Type[]
  Summary: Returns the public types nested in the current System.Type.
  Returns: An array of System.Type objects representing the public types nested in the current System.Type (the search is not recursive), or an empty array of type System.Type if no public types are nested in the current System.Type.

GetNestedTypes(BindingFlags) -> Type[]
  Summary: When overridden in a derived class, searches for the types nested in the current System.Type, using the specified binding constraints.
  Returns: An array of System.Type objects representing all the types nested in the current System.Type that match the specified binding constraints (the search is not recursive), or an empty array of type System.Type, if no nested types are found that match the binding constraints.
  Parameters:
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
"
  (cl:cond
    ((cl:and supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetNestedTypes" binding-attr))
    ((cl:and (cl:not supplied-binding-attr))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetNestedTypes"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetNestedTypes"
                    :supplied-args (cl:append (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)))))))

(cl:defun get-optional-custom-modifiers (obj!)
  "Summary: When overridden in a derived class, returns the optional custom modifiers of the current System.Type.
Returns: An array of System.Type objects that identify the optional custom modifiers of the current System.Type. -or- An empty array of type System.Type, if the current System.Type has no custom modifiers. -or- An empty array of type System.Type, if the current System.Type is not a modified System.Type. A modified System.Type is obtained from System.Reflection.FieldInfo.GetModifiedFieldType, System.Reflection.PropertyInfo.GetModifiedPropertyType, or System.Reflection.ParameterInfo.GetModifiedParameterType.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetOptionalCustomModifiers"))

(cl:defun get-properties (obj! cl:&optional (binding-attr cl:nil supplied-binding-attr))
  "Master wrapper for System.Type.GetProperties overloads. Dispatches at runtime.

GetProperties() -> PropertyInfo[]
  Summary: Returns all the public properties of the current System.Type.
  Returns: An array of System.Reflection.PropertyInfo objects representing all public properties of the current System.Type. -or- An empty array of type System.Reflection.PropertyInfo, if the current System.Type does not have public properties.

GetProperties(BindingFlags) -> PropertyInfo[]
  Summary: When overridden in a derived class, searches for the properties of the current System.Type, using the specified binding constraints.
  Returns: An array of objects representing all properties of the current System.Type that match the specified binding constraints. -or- An empty array of type System.Reflection.PropertyInfo, if the current System.Type does not have properties, or if none of the properties match the binding constraints.
  Parameters:
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return an empty array.
"
  (cl:cond
    ((cl:and supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetProperties" binding-attr))
    ((cl:and (cl:not supplied-binding-attr))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetProperties"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetProperties"
                    :supplied-args (cl:append (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)))))))

(cl:defun get-property (obj! name cl:&optional (binding-attr cl:nil supplied-binding-attr) (types cl:nil supplied-types) (modifiers cl:nil supplied-modifiers) (types2 cl:nil supplied-types2) (modifiers2 cl:nil supplied-modifiers2))
  "Master wrapper for System.Type.GetProperty overloads. Dispatches at runtime.

GetProperty(String) -> PropertyInfo
  Summary: Searches for the public property with the specified name.
  Returns: An object representing the public property with the specified name, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the public property to get.

GetProperty(String, BindingFlags) -> PropertyInfo
  Summary: Searches for the specified property, using the specified binding constraints.
  Returns: An object representing the property that matches the specified requirements, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the property to get.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .

GetProperty(String, Type) -> PropertyInfo
  Summary: Searches for the public property with the specified name and return type.
  Returns: An object representing the public property with the specified name, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the public property to get.
    - return-type (System.Type): The return type of the property.

GetProperty(String, Type[]) -> PropertyInfo
  Summary: Searches for the specified public property whose parameters match the specified argument types.
  Returns: An object representing the public property whose parameters match the specified argument types, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the public property to get.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the indexed property to get. -or- An empty array of the type System.Type (that is, Type[] types = new Type[0]) to get a property that is not indexed.

GetProperty(String, Type, Type[]) -> PropertyInfo
  Summary: Searches for the specified public property whose parameters match the specified argument types.
  Returns: An object representing the public property whose parameters match the specified argument types, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the public property to get.
    - return-type (System.Type): The return type of the property.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the indexed property to get. -or- An empty array of the type System.Type (that is, Type[] types = new Type[0]) to get a property that is not indexed.

GetProperty(String, Type, Type[], ParameterModifier[]) -> PropertyInfo
  Summary: Searches for the specified public property whose parameters match the specified argument types and modifiers.
  Returns: An object representing the public property that matches the specified requirements, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the public property to get.
    - return-type (System.Type): The return type of the property.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the indexed property to get. -or- An empty array of the type System.Type (that is, Type[] types = new Type[0]) to get a property that is not indexed.
    - modifiers (System.Reflection.ParameterModifier[]): An array of System.Reflection.ParameterModifier objects representing the attributes associated with the corresponding element in the types array. The default binder does not process this parameter.

GetProperty(String, BindingFlags, Binder, Type, Type[], ParameterModifier[]) -> PropertyInfo
  Summary: Searches for the specified property whose parameters match the specified argument types and modifiers, using the specified binding constraints.
  Returns: An object representing the property that matches the specified requirements, if found; otherwise, .
  Parameters:
    - name (System.String): The string containing the name of the property to get.
    - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
    - binder (System.Reflection.Binder): An object that defines a set of properties and enables binding, which can involve selection of an overloaded method, coercion of argument types, and invocation of a member through reflection. -or- A null reference ( in Visual Basic), to use the System.Type.DefaultBinder.
    - return-type (System.Type): The return type of the property.
    - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the indexed property to get. -or- An empty array of the type System.Type (that is, Type[] types = new Type[0]) to get a property that is not indexed.
    - modifiers (System.Reflection.ParameterModifier[]): An array of System.Reflection.ParameterModifier objects representing the attributes associated with the corresponding element in the types array. The default binder does not process this parameter.
"
  (cl:cond
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) supplied-types (cl:or (cl:null types) (dotnet:object-type types)) supplied-modifiers (cl:or (cl:null modifiers) (dotnet:object-type modifiers)) supplied-types2 (cl:or (cl:null types2) (dotnet:object-type types2)) supplied-modifiers2 (cl:or (cl:null modifiers2) (dotnet:object-type modifiers2)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetProperty" name binding-attr types modifiers types2 modifiers2))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) supplied-types (cl:or (cl:null types) (dotnet:object-type types)) supplied-modifiers (cl:or (cl:null modifiers) (dotnet:object-type modifiers)) (cl:not supplied-types2) (cl:not supplied-modifiers2))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetProperty" name binding-attr types modifiers))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) supplied-types (cl:or (cl:null types) (dotnet:object-type types)) (cl:not supplied-modifiers) (cl:not supplied-types2) (cl:not supplied-modifiers2))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetProperty" name binding-attr types))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) (cl:not supplied-types) (cl:not supplied-modifiers) (cl:not supplied-types2) (cl:not supplied-modifiers2))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetProperty" name binding-attr))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) (cl:not supplied-types) (cl:not supplied-modifiers) (cl:not supplied-types2) (cl:not supplied-modifiers2))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetProperty" name binding-attr))
    ((cl:and (cl:stringp name) supplied-binding-attr (cl:or (cl:null binding-attr) (dotnet:object-type binding-attr)) (cl:not supplied-types) (cl:not supplied-modifiers) (cl:not supplied-types2) (cl:not supplied-modifiers2))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetProperty" name binding-attr))
    ((cl:and (cl:stringp name) (cl:not supplied-binding-attr) (cl:not supplied-types) (cl:not supplied-modifiers) (cl:not supplied-types2) (cl:not supplied-modifiers2))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetProperty" name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetProperty"
                    :supplied-args (cl:append (cl:list :name name) (cl:when supplied-binding-attr (cl:list :binding-attr binding-attr)) (cl:when supplied-types (cl:list :types types)) (cl:when supplied-modifiers (cl:list :modifiers modifiers)) (cl:when supplied-types2 (cl:list :types2 types2)) (cl:when supplied-modifiers2 (cl:list :modifiers2 modifiers2)))))))

(cl:defun get-property-impl (obj! name binding-attr binder return-type types modifiers)
  "Summary: When overridden in a derived class, searches for the specified property whose parameters match the specified argument types and modifiers, using the specified binding constraints.
Returns: An object representing the property that matches the specified requirements, if found; otherwise, .
Parameters:
  - name (System.String): The string containing the name of the property to get.
  - binding-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. -or- System.Reflection.BindingFlags.Default to return .
  - binder (System.Reflection.Binder): An object that defines a set of properties and enables binding, which can involve selection of an overloaded member, coercion of argument types, and invocation of a member through reflection. -or- A null reference ( in Visual Basic), to use the System.Type.DefaultBinder.
  - return-type (System.Type): The return type of the property.
  - types (System.Type[]): An array of System.Type objects representing the number, order, and type of the parameters for the indexed property to get. -or- An empty array of the type System.Type (that is, Type[] types = new Type[0]) to get a property that is not indexed.
  - modifiers (System.Reflection.ParameterModifier[]): An array of System.Reflection.ParameterModifier objects representing the attributes associated with the corresponding element in the types array. The default binder does not process this parameter.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetPropertyImpl" name binding-attr binder return-type types modifiers))

(cl:defun get-required-custom-modifiers (obj!)
  "Summary: When overridden in a derived class, returns the required custom modifiers of the current System.Type.
Returns: An array of System.Type objects that identify the required custom modifiers of the current System.Type. -or- An empty array of type System.Type, if the current System.Type has no custom modifiers. -or- An empty array of type System.Type, if the current System.Type is not a modified System.Type. A modified System.Type is obtained from System.Reflection.FieldInfo.GetModifiedFieldType, System.Reflection.PropertyInfo.GetModifiedPropertyType, or System.Reflection.ParameterInfo.GetModifiedParameterType.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetRequiredCustomModifiers"))

(cl:defun get-type (obj!)
  "Summary: Gets the current System.Type.
Returns: The current System.Type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetType"))

(cl:defun get-type* (type-name cl:&optional (throw-on-error cl:nil supplied-throw-on-error) (ignore-case cl:nil supplied-ignore-case) (throw-on-error2 cl:nil supplied-throw-on-error2) (ignore-case2 cl:nil supplied-ignore-case2))
  "Master wrapper for System.Type.GetType overloads. Dispatches at runtime.

GetType(String) -> Type
  Summary: Gets the System.Type with the specified name, performing a case-sensitive search.
  Returns: The type with the specified name, if found; otherwise, .
  Parameters:
    - type-name (System.String): The assembly-qualified name of the type to get. See System.Type.AssemblyQualifiedName. If the type is in the currently executing assembly or in mscorlib.dll/System.Private.CoreLib.dll, it's sufficient to supply the type name qualified by its namespace.

GetType(String, Boolean) -> Type
  Summary: Gets the System.Type with the specified name, performing a case-sensitive search and specifying whether to throw an exception if the type is not found.
  Returns: The type with the specified name. If the type is not found, the throwOnError parameter specifies whether is returned or an exception is thrown. In some cases, an exception is thrown regardless of the value of throwOnError. See the Exceptions section.
  Parameters:
    - type-name (System.String): The assembly-qualified name of the type to get. See System.Type.AssemblyQualifiedName. If the type is in the currently executing assembly or in mscorlib.dll/System.Private.CoreLib.dll, it's sufficient to supply the type name qualified by its namespace.
    - throw-on-error (System.Boolean): to throw an exception if the type cannot be found; to return . Specifying also suppresses some other exception conditions, but not all of them. See the Exceptions section.

GetType(String, Boolean, Boolean) -> Type
  Summary: Gets the System.Type with the specified name, specifying whether to throw an exception if the type is not found and whether to perform a case-sensitive search.
  Returns: The type with the specified name. If the type is not found, the throwOnError parameter specifies whether is returned or an exception is thrown. In some cases, an exception is thrown regardless of the value of throwOnError. See the Exceptions section.
  Parameters:
    - type-name (System.String): The assembly-qualified name of the type to get. See System.Type.AssemblyQualifiedName. If the type is in the currently executing assembly or in mscorlib.dll/System.Private.CoreLib.dll, it's sufficient to supply the type name qualified by its namespace.
    - throw-on-error (System.Boolean): to throw an exception if the type cannot be found; to return . Specifying also suppresses some other exception conditions, but not all of them. See the Exceptions section.
    - ignore-case (System.Boolean): to perform a case-insensitive search for typeName, to perform a case-sensitive search for typeName.

GetType(String, Assembly], Type]) -> Type
  Summary: Gets the type with the specified name, optionally providing custom methods to resolve the assembly and the type.
  Returns: The type with the specified name, or if the type is not found.
  Parameters:
    - type-name (System.String): The name of the type to get. If the typeResolver parameter is provided, the type name can be any string that typeResolver is capable of resolving. If the assemblyResolver parameter is provided or if standard type resolution is used, typeName must be an assembly-qualified name (see System.Type.AssemblyQualifiedName), unless the type is in the currently executing assembly or in mscorlib.dll/System.Private.CoreLib.dll, in which case it's sufficient to supply the type name qualified by its namespace.
    - assembly-resolver (System.Func`2[System.Reflection.AssemblyName, System.Reflection.Assembly]): A method that locates and returns the assembly that is specified in typeName. The assembly name is passed to assemblyResolver as an System.Reflection.AssemblyName object. If typeName does not contain the name of an assembly, assemblyResolver is not called. If assemblyResolver is not supplied, standard assembly resolution is performed. Caution: Don't pass methods from unknown or untrusted callers. Doing so could result in elevation of privilege for malicious code. Use only methods that you provide or that you are familiar with.
    - type-resolver (System.Func`4[System.Reflection.Assembly, System.String, System.Boolean, System.Type]): A method that locates and returns the type that is specified by typeName from the assembly that is returned by assemblyResolver or by standard assembly resolution. If no assembly is provided, the typeResolver method can provide one. The method also takes a parameter that specifies whether to perform a case-insensitive search; is passed to that parameter. Caution: Don't pass methods from unknown or untrusted callers.

GetType(String, Assembly], Type], Boolean) -> Type
  Summary: Gets the type with the specified name, specifying whether to throw an exception if the type is not found, and optionally providing custom methods to resolve the assembly and the type.
  Returns: The type with the specified name. If the type is not found, the throwOnError parameter specifies whether is returned or an exception is thrown. In some cases, an exception is thrown regardless of the value of throwOnError. See the Exceptions section.
  Parameters:
    - type-name (System.String): The name of the type to get. If the typeResolver parameter is provided, the type name can be any string that typeResolver is capable of resolving. If the assemblyResolver parameter is provided or if standard type resolution is used, typeName must be an assembly-qualified name (see System.Type.AssemblyQualifiedName), unless the type is in the currently executing assembly or in mscorlib.dll/System.Private.CoreLib.dll, in which case it's sufficient to supply the type name qualified by its namespace.
    - assembly-resolver (System.Func`2[System.Reflection.AssemblyName, System.Reflection.Assembly]): A method that locates and returns the assembly that is specified in typeName. The assembly name is passed to assemblyResolver as an System.Reflection.AssemblyName object. If typeName does not contain the name of an assembly, assemblyResolver is not called. If assemblyResolver is not supplied, standard assembly resolution is performed. Caution: Don't pass methods from unknown or untrusted callers. Doing so could result in elevation of privilege for malicious code. Use only methods that you provide or that you are familiar with.
    - type-resolver (System.Func`4[System.Reflection.Assembly, System.String, System.Boolean, System.Type]): A method that locates and returns the type that is specified by typeName from the assembly that is returned by assemblyResolver or by standard assembly resolution. If no assembly is provided, the method can provide one. The method also takes a parameter that specifies whether to perform a case-insensitive search; is passed to that parameter. Caution: Don't pass methods from unknown or untrusted callers.
    - throw-on-error (System.Boolean): to throw an exception if the type cannot be found; to return . Specifying also suppresses some other exception conditions, but not all of them. See the Exceptions section.

GetType(String, Assembly], Type], Boolean, Boolean) -> Type
  Summary: Gets the type with the specified name, specifying whether to perform a case-sensitive search and whether to throw an exception if the type is not found, and optionally providing custom methods to resolve the assembly and the type.
  Returns: The type with the specified name. If the type is not found, the throwOnError parameter specifies whether is returned or an exception is thrown. In some cases, an exception is thrown regardless of the value of throwOnError. See the Exceptions section.
  Parameters:
    - type-name (System.String): The name of the type to get. If the typeResolver parameter is provided, the type name can be any string that typeResolver is capable of resolving. If the assemblyResolver parameter is provided or if standard type resolution is used, typeName must be an assembly-qualified name (see System.Type.AssemblyQualifiedName), unless the type is in the currently executing assembly or in mscorlib.dll/System.Private.CoreLib.dll, in which case it's sufficient to supply the type name qualified by its namespace.
    - assembly-resolver (System.Func`2[System.Reflection.AssemblyName, System.Reflection.Assembly]): A method that locates and returns the assembly that is specified in typeName. The assembly name is passed to assemblyResolver as an System.Reflection.AssemblyName object. If typeName does not contain the name of an assembly, assemblyResolver is not called. If assemblyResolver is not supplied, standard assembly resolution is performed. Caution: Don't pass methods from unknown or untrusted callers. Doing so could result in elevation of privilege for malicious code. Use only methods that you provide or that you are familiar with.
    - type-resolver (System.Func`4[System.Reflection.Assembly, System.String, System.Boolean, System.Type]): A method that locates and returns the type that is specified by typeName from the assembly that is returned by assemblyResolver or by standard assembly resolution. If no assembly is provided, the method can provide one. The method also takes a parameter that specifies whether to perform a case-insensitive search; the value of ignoreCase is passed to that parameter. Caution: Don't pass methods from unknown or untrusted callers.
    - throw-on-error (System.Boolean): to throw an exception if the type cannot be found; to return . Specifying also suppresses some other exception conditions, but not all of them. See the Exceptions section.
    - ignore-case (System.Boolean): to perform a case-insensitive search for typeName, to perform a case-sensitive search for typeName.
"
  (cl:cond
    ((cl:and (cl:stringp type-name) supplied-throw-on-error (cl:or (cl:null throw-on-error) (dotnet:object-type throw-on-error)) supplied-ignore-case (cl:or (cl:null ignore-case) (dotnet:object-type ignore-case)) supplied-throw-on-error2 (cl:typep throw-on-error2 'cl:boolean) supplied-ignore-case2 (cl:typep ignore-case2 'cl:boolean))
     (dotnet:static <type-str> "GetType" type-name throw-on-error ignore-case throw-on-error2 ignore-case2))
    ((cl:and (cl:stringp type-name) supplied-throw-on-error (cl:or (cl:null throw-on-error) (dotnet:object-type throw-on-error)) supplied-ignore-case (cl:or (cl:null ignore-case) (dotnet:object-type ignore-case)) supplied-throw-on-error2 (cl:typep throw-on-error2 'cl:boolean) (cl:not supplied-ignore-case2))
     (dotnet:static <type-str> "GetType" type-name throw-on-error ignore-case throw-on-error2))
    ((cl:and (cl:stringp type-name) supplied-throw-on-error (cl:typep throw-on-error 'cl:boolean) supplied-ignore-case (cl:typep ignore-case 'cl:boolean) (cl:not supplied-throw-on-error2) (cl:not supplied-ignore-case2))
     (dotnet:static <type-str> "GetType" type-name throw-on-error ignore-case))
    ((cl:and (cl:stringp type-name) supplied-throw-on-error (cl:or (cl:null throw-on-error) (dotnet:object-type throw-on-error)) supplied-ignore-case (cl:or (cl:null ignore-case) (dotnet:object-type ignore-case)) (cl:not supplied-throw-on-error2) (cl:not supplied-ignore-case2))
     (dotnet:static <type-str> "GetType" type-name throw-on-error ignore-case))
    ((cl:and (cl:stringp type-name) supplied-throw-on-error (cl:typep throw-on-error 'cl:boolean) (cl:not supplied-ignore-case) (cl:not supplied-throw-on-error2) (cl:not supplied-ignore-case2))
     (dotnet:static <type-str> "GetType" type-name throw-on-error))
    ((cl:and (cl:stringp type-name) (cl:not supplied-throw-on-error) (cl:not supplied-ignore-case) (cl:not supplied-throw-on-error2) (cl:not supplied-ignore-case2))
     (dotnet:static <type-str> "GetType" type-name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetType"
                    :supplied-args (cl:append (cl:list :type-name type-name) (cl:when supplied-throw-on-error (cl:list :throw-on-error throw-on-error)) (cl:when supplied-ignore-case (cl:list :ignore-case ignore-case)) (cl:when supplied-throw-on-error2 (cl:list :throw-on-error2 throw-on-error2)) (cl:when supplied-ignore-case2 (cl:list :ignore-case2 ignore-case2)))))))

(cl:defun get-type-array (args)
  "Summary: Gets the types of the objects in the specified array.
Returns: An array of System.Type objects representing the types of the corresponding elements in args.
Parameters:
  - args (System.Object[]): An array of objects whose types to determine.
"
  (dotnet:static <type-str> "GetTypeArray" (cl:the (dotnet "System.Object[]") args)))

(cl:defun get-type-code (type)
  "Summary: Gets the underlying type code of the specified System.Type.
Returns: The code of the underlying type, or System.TypeCode.Empty if type is .
Parameters:
  - type (System.Type): The type whose underlying type code to get.
"
  (dotnet:static <type-str> "GetTypeCode" (cl:the (dotnet "System.Type") type)))

(cl:defun get-type-code-impl (obj!)
  "Summary: Returns the underlying type code of this System.Type instance.
Returns: The type code of the underlying type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "GetTypeCodeImpl"))

(cl:defun get-type-from-clsid (clsid cl:&optional (throw-on-error cl:nil supplied-throw-on-error) (throw-on-error2 cl:nil supplied-throw-on-error2))
  "Master wrapper for System.Type.GetTypeFromCLSID overloads. Dispatches at runtime.

GetTypeFromCLSID(Guid) -> Type
  Summary: Gets the type associated with the specified class identifier (CLSID).
  Returns: regardless of whether the CLSID is valid.
  Parameters:
    - clsid (System.Guid): The CLSID of the type to get.

GetTypeFromCLSID(Guid, Boolean) -> Type
  Summary: Gets the type associated with the specified class identifier (CLSID), specifying whether to throw an exception if an error occurs while loading the type.
  Returns: regardless of whether the CLSID is valid.
  Parameters:
    - clsid (System.Guid): The CLSID of the type to get.
    - throw-on-error (System.Boolean): to throw any exception that occurs. -or- to ignore any exception that occurs.

GetTypeFromCLSID(Guid, String) -> Type
  Summary: Gets the type associated with the specified class identifier (CLSID) from the specified server.
  Returns: regardless of whether the CLSID is valid.
  Parameters:
    - clsid (System.Guid): The CLSID of the type to get.
    - server (System.String): The server from which to load the type. If the server name is , this method automatically reverts to the local machine.

GetTypeFromCLSID(Guid, String, Boolean) -> Type
  Summary: Gets the type associated with the specified class identifier (CLSID) from the specified server, specifying whether to throw an exception if an error occurs while loading the type.
  Returns: regardless of whether the CLSID is valid.
  Parameters:
    - clsid (System.Guid): The CLSID of the type to get.
    - server (System.String): The server from which to load the type. If the server name is , this method automatically reverts to the local machine.
    - throw-on-error (System.Boolean): to throw any exception that occurs. -or- to ignore any exception that occurs.
"
  (cl:cond
    ((cl:and (cl:or (cl:null clsid) (dotnet:object-type clsid)) supplied-throw-on-error (cl:stringp throw-on-error) supplied-throw-on-error2 (cl:typep throw-on-error2 'cl:boolean))
     (dotnet:static <type-str> "GetTypeFromCLSID" clsid throw-on-error throw-on-error2))
    ((cl:and (cl:or (cl:null clsid) (dotnet:object-type clsid)) supplied-throw-on-error (cl:typep throw-on-error 'cl:boolean) (cl:not supplied-throw-on-error2))
     (dotnet:static <type-str> "GetTypeFromCLSID" clsid throw-on-error))
    ((cl:and (cl:or (cl:null clsid) (dotnet:object-type clsid)) supplied-throw-on-error (cl:stringp throw-on-error) (cl:not supplied-throw-on-error2))
     (dotnet:static <type-str> "GetTypeFromCLSID" clsid throw-on-error))
    ((cl:and (cl:or (cl:null clsid) (dotnet:object-type clsid)) (cl:not supplied-throw-on-error) (cl:not supplied-throw-on-error2))
     (dotnet:static <type-str> "GetTypeFromCLSID" clsid))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetTypeFromCLSID"
                    :supplied-args (cl:append (cl:list :clsid clsid) (cl:when supplied-throw-on-error (cl:list :throw-on-error throw-on-error)) (cl:when supplied-throw-on-error2 (cl:list :throw-on-error2 throw-on-error2)))))))

(cl:defun get-type-from-handle (handle)
  "Summary: Gets the type referenced by the specified type handle.
Returns: The type referenced by the specified System.RuntimeTypeHandle, or if the System.RuntimeTypeHandle.Value property of handle is .
Parameters:
  - handle (System.RuntimeTypeHandle): The object that refers to the type.
"
  (dotnet:static <type-str> "GetTypeFromHandle" (cl:the (dotnet "System.RuntimeTypeHandle") handle)))

(cl:defun get-type-from-prog-id (prog-id cl:&optional (throw-on-error cl:nil supplied-throw-on-error) (throw-on-error2 cl:nil supplied-throw-on-error2))
  "Master wrapper for System.Type.GetTypeFromProgID overloads. Dispatches at runtime.

GetTypeFromProgID(String) -> Type
  Summary: Gets the type associated with the specified program identifier (ProgID), returning null if an error is encountered while loading the System.Type.
  Returns: The type associated with the specified ProgID, if progID is a valid entry in the registry and a type is associated with it; otherwise, .
  Parameters:
    - prog-id (System.String): The ProgID of the type to get.

GetTypeFromProgID(String, Boolean) -> Type
  Summary: Gets the type associated with the specified program identifier (ProgID), specifying whether to throw an exception if an error occurs while loading the type.
  Returns: The type associated with the specified program identifier (ProgID), if progID is a valid entry in the registry and a type is associated with it; otherwise, .
  Parameters:
    - prog-id (System.String): The ProgID of the type to get.
    - throw-on-error (System.Boolean): to throw any exception that occurs. -or- to ignore any exception that occurs.

GetTypeFromProgID(String, String) -> Type
  Summary: Gets the type associated with the specified program identifier (progID) from the specified server, returning null if an error is encountered while loading the type.
  Returns: The type associated with the specified program identifier (progID), if progID is a valid entry in the registry and a type is associated with it; otherwise, .
  Parameters:
    - prog-id (System.String): The progID of the type to get.
    - server (System.String): The server from which to load the type. If the server name is , this method automatically reverts to the local machine.

GetTypeFromProgID(String, String, Boolean) -> Type
  Summary: Gets the type associated with the specified program identifier (progID) from the specified server, specifying whether to throw an exception if an error occurs while loading the type.
  Returns: The type associated with the specified program identifier (progID), if progID is a valid entry in the registry and a type is associated with it; otherwise, .
  Parameters:
    - prog-id (System.String): The progID of the System.Type to get.
    - server (System.String): The server from which to load the type. If the server name is , this method automatically reverts to the local machine.
    - throw-on-error (System.Boolean): to throw any exception that occurs. -or- to ignore any exception that occurs.
"
  (cl:cond
    ((cl:and (cl:stringp prog-id) supplied-throw-on-error (cl:stringp throw-on-error) supplied-throw-on-error2 (cl:typep throw-on-error2 'cl:boolean))
     (dotnet:static <type-str> "GetTypeFromProgID" prog-id throw-on-error throw-on-error2))
    ((cl:and (cl:stringp prog-id) supplied-throw-on-error (cl:typep throw-on-error 'cl:boolean) (cl:not supplied-throw-on-error2))
     (dotnet:static <type-str> "GetTypeFromProgID" prog-id throw-on-error))
    ((cl:and (cl:stringp prog-id) supplied-throw-on-error (cl:stringp throw-on-error) (cl:not supplied-throw-on-error2))
     (dotnet:static <type-str> "GetTypeFromProgID" prog-id throw-on-error))
    ((cl:and (cl:stringp prog-id) (cl:not supplied-throw-on-error) (cl:not supplied-throw-on-error2))
     (dotnet:static <type-str> "GetTypeFromProgID" prog-id))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "GetTypeFromProgID"
                    :supplied-args (cl:append (cl:list :prog-id prog-id) (cl:when supplied-throw-on-error (cl:list :throw-on-error throw-on-error)) (cl:when supplied-throw-on-error2 (cl:list :throw-on-error2 throw-on-error2)))))))

(cl:defun get-type-handle (o)
  "Summary: Gets the handle for the System.Type of a specified object.
Returns: The handle for the System.Type of the specified System.Object.
Parameters:
  - o (System.Object): The object for which to get the type handle.
"
  (dotnet:static <type-str> "GetTypeHandle" (cl:the (dotnet "System.Object") o)))

(cl:defun has-element-type-impl (obj!)
  "Summary: When overridden in a derived class, implements the System.Type.HasElementType property and determines whether the current System.Type encompasses or refers to another type; that is, whether the current System.Type is an array, a pointer, or is passed by reference.
Returns: if the System.Type is an array, a pointer, or is passed by reference; otherwise, .
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "HasElementTypeImpl"))

(cl:defun invoke-member (obj! name invoke-attr binder target args cl:&optional (culture cl:nil supplied-culture) (culture2 cl:nil supplied-culture2) (named-parameters cl:nil supplied-named-parameters))
  "Master wrapper for System.Type.InvokeMember overloads. Dispatches at runtime.

InvokeMember(String, BindingFlags, Binder, Object, Object[]) -> Object
  Summary: Invokes the specified member, using the specified binding constraints and matching the specified argument list.
  Returns: An object representing the return value of the invoked member.
  Parameters:
    - name (System.String): The string containing the name of the constructor, method, property, or field member to invoke. -or- An empty string (\"\") to invoke the default member. -or- For members, a string representing the DispID, for example \"[DispID=3]\".
    - invoke-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. The access can be one of the such as , , , , , and so on. The type of lookup need not be specified. If the type of lookup is omitted, | | are used.
    - binder (System.Reflection.Binder): An object that defines a set of properties and enables binding, which can involve selection of an overloaded method, coercion of argument types, and invocation of a member through reflection. -or- A null reference ( in Visual Basic), to use the System.Type.DefaultBinder. Note that explicitly defining a System.Reflection.Binder object may be required for successfully invoking method overloads with variable arguments.
    - target (System.Object): The object on which to invoke the specified member.
    - args (System.Object[]): An array containing the arguments to pass to the member to invoke.

InvokeMember(String, BindingFlags, Binder, Object, Object[], CultureInfo) -> Object
  Summary: Invokes the specified member, using the specified binding constraints and matching the specified argument list and culture.
  Returns: An object representing the return value of the invoked member.
  Parameters:
    - name (System.String): The string containing the name of the constructor, method, property, or field member to invoke. -or- An empty string (\"\") to invoke the default member. -or- For members, a string representing the DispID, for example \"[DispID=3]\".
    - invoke-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. The access can be one of the such as , , , , , and so on. The type of lookup need not be specified. If the type of lookup is omitted, | | are used.
    - binder (System.Reflection.Binder): An object that defines a set of properties and enables binding, which can involve selection of an overloaded method, coercion of argument types, and invocation of a member through reflection. -or- A null reference ( in Visual Basic), to use the System.Type.DefaultBinder. Note that explicitly defining a System.Reflection.Binder object may be required for successfully invoking method overloads with variable arguments.
    - target (System.Object): The object on which to invoke the specified member.
    - args (System.Object[]): An array containing the arguments to pass to the member to invoke.
    - culture (System.Globalization.CultureInfo): The object representing the globalization locale to use, which may be necessary for locale-specific conversions, such as converting a numeric System.String to a System.Double. -or- A null reference ( in Visual Basic) to use the current thread's System.Globalization.CultureInfo.

InvokeMember(String, BindingFlags, Binder, Object, Object[], ParameterModifier[], CultureInfo, String[]) -> Object
  Summary: When overridden in a derived class, invokes the specified member, using the specified binding constraints and matching the specified argument list, modifiers and culture.
  Returns: An object representing the return value of the invoked member.
  Parameters:
    - name (System.String): The string containing the name of the constructor, method, property, or field member to invoke. -or- An empty string (\"\") to invoke the default member. -or- For members, a string representing the DispID, for example \"[DispID=3]\".
    - invoke-attr (System.Reflection.BindingFlags): A bitwise combination of the enumeration values that specify how the search is conducted. The access can be one of the such as , , , , , and so on. The type of lookup need not be specified. If the type of lookup is omitted, | | are used.
    - binder (System.Reflection.Binder): An object that defines a set of properties and enables binding, which can involve selection of an overloaded method, coercion of argument types, and invocation of a member through reflection. -or- A null reference (Nothing in Visual Basic), to use the System.Type.DefaultBinder. Note that explicitly defining a System.Reflection.Binder object may be required for successfully invoking method overloads with variable arguments.
    - target (System.Object): The object on which to invoke the specified member.
    - args (System.Object[]): An array containing the arguments to pass to the member to invoke.
    - modifiers (System.Reflection.ParameterModifier[]): An array of System.Reflection.ParameterModifier objects representing the attributes associated with the corresponding element in the args array. A parameter's associated attributes are stored in the member's signature. The default binder processes this parameter only when calling a COM component.
    - culture (System.Globalization.CultureInfo): The System.Globalization.CultureInfo object representing the globalization locale to use, which may be necessary for locale-specific conversions, such as converting a numeric String to a Double. -or- A null reference ( in Visual Basic) to use the current thread's System.Globalization.CultureInfo.
    - named-parameters (System.String[]): An array containing the names of the parameters to which the values in the args array are passed.
"
  (cl:cond
    ((cl:and (cl:stringp name) (cl:or (cl:null invoke-attr) (dotnet:object-type invoke-attr)) (cl:or (cl:null binder) (dotnet:object-type binder)) (cl:or (cl:null target) (dotnet:object-type target)) (cl:or (cl:null args) (dotnet:object-type args)) supplied-culture (cl:or (cl:null culture) (dotnet:object-type culture)) supplied-culture2 (cl:or (cl:null culture2) (dotnet:object-type culture2)) supplied-named-parameters (cl:or (cl:null named-parameters) (dotnet:object-type named-parameters)))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "InvokeMember" name invoke-attr binder target args culture culture2 named-parameters))
    ((cl:and (cl:stringp name) (cl:or (cl:null invoke-attr) (dotnet:object-type invoke-attr)) (cl:or (cl:null binder) (dotnet:object-type binder)) (cl:or (cl:null target) (dotnet:object-type target)) (cl:or (cl:null args) (dotnet:object-type args)) supplied-culture (cl:or (cl:null culture) (dotnet:object-type culture)) (cl:not supplied-culture2) (cl:not supplied-named-parameters))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "InvokeMember" name invoke-attr binder target args culture))
    ((cl:and (cl:stringp name) (cl:or (cl:null invoke-attr) (dotnet:object-type invoke-attr)) (cl:or (cl:null binder) (dotnet:object-type binder)) (cl:or (cl:null target) (dotnet:object-type target)) (cl:or (cl:null args) (dotnet:object-type args)) (cl:not supplied-culture) (cl:not supplied-culture2) (cl:not supplied-named-parameters))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "InvokeMember" name invoke-attr binder target args))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "InvokeMember"
                    :supplied-args (cl:append (cl:list :name name) (cl:list :invoke-attr invoke-attr) (cl:list :binder binder) (cl:list :target target) (cl:list :args args) (cl:when supplied-culture (cl:list :culture culture)) (cl:when supplied-culture2 (cl:list :culture2 culture2)) (cl:when supplied-named-parameters (cl:list :named-parameters named-parameters)))))))

(cl:defun array-impl? (obj!)
  "Summary: When overridden in a derived class, implements the System.Type.IsArray property and determines whether the System.Type is an array.
Returns: if the System.Type is an array; otherwise, .
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "IsArrayImpl"))

(cl:defun assignable-from? (obj! c)
  "Summary: Determines whether an instance of a specified type c can be assigned to a variable of the current type.
Returns: if any of the following conditions is true: - c and the current instance represent the same type. - c is derived either directly or indirectly from the current instance. c is derived directly from the current instance if it inherits from the current instance; c is derived indirectly from the current instance if it inherits from a succession of one or more classes that inherit from the current instance. - The current instance is an interface that c implements. - c is a generic type parameter, and the current instance represents one of the constraints of c. - c represents a value type, and the current instance represents Nullable<c> (Nullable(Of c) in Visual Basic). if none of these conditions are true, or if c is .
Parameters:
  - c (System.Type): The type to compare with the current type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "IsAssignableFrom" c))

(cl:defun assignable-to? (obj! target-type)
  "Summary: Determines whether the current type can be assigned to a variable of the specified targetType.
Returns: if any of the following conditions is true: - The current instance and targetType represent the same type. - The current type is derived either directly or indirectly from targetType. The current type is derived directly from targetType if it inherits from targetType; the current type is derived indirectly from targetType if it inherits from a succession of one or more classes that inherit from targetType. - targetType is an interface that the current type implements. - The current type is a generic type parameter, and targetType represents one of the constraints of the current type. - The current type represents a value type, and targetType represents Nullable<c> (Nullable(Of c) in Visual Basic). if none of these conditions are true, or if targetType is .
Parameters:
  - target-type (System.Type): The type to compare with the current type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "IsAssignableTo" target-type))

(cl:defun by-ref-impl? (obj!)
  "Summary: When overridden in a derived class, implements the System.Type.IsByRef property and determines whether the System.Type is passed by reference.
Returns: if the System.Type is passed by reference; otherwise, .
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "IsByRefImpl"))

(cl:defun com-object-impl? (obj!)
  "Summary: When overridden in a derived class, implements the System.Type.IsCOMObject property and determines whether the System.Type is a COM object.
Returns: if the System.Type is a COM object; otherwise, .
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "IsCOMObjectImpl"))

(cl:defun contextful-impl? (obj!)
  "Summary: Implements the System.Type.IsContextful property and determines whether the System.Type can be hosted in a context.
Returns: if the System.Type can be hosted in a context; otherwise, .
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "IsContextfulImpl"))

(cl:defun enum-defined? (obj! value)
  "Summary: Returns a value that indicates whether the specified value exists in the current enumeration type.
Returns: if the specified value is a member of the current enumeration type; otherwise, .
Parameters:
  - value (System.Object): The value to be tested.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "IsEnumDefined" value))

(cl:defun equivalent-to? (obj! other)
  "Summary: Determines whether two COM types have the same identity and are eligible for type equivalence.
Returns: if the COM types are equivalent; otherwise, . This method also returns if one type is in an assembly that is loaded for execution, and the other is in an assembly that is loaded into the reflection-only context.
Parameters:
  - other (System.Type): The COM type that is tested for equivalence with the current type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "IsEquivalentTo" other))

(cl:defun instance-of-type? (obj! o)
  "Summary: Determines whether the specified object is an instance of the current System.Type.
Returns: if the current is in the inheritance hierarchy of the object represented by o, or if the current is an interface that o implements. if neither of these conditions is the case, if o is , or if the current is an open generic type (that is, System.Type.ContainsGenericParameters returns ).
Parameters:
  - o (System.Object): The object to compare with the current type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "IsInstanceOfType" o))

(cl:defun marshal-by-ref-impl? (obj!)
  "Summary: Implements the System.Type.IsMarshalByRef property and determines whether the System.Type is marshaled by reference.
Returns: if the System.Type is marshaled by reference; otherwise, .
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "IsMarshalByRefImpl"))

(cl:defun pointer-impl? (obj!)
  "Summary: When overridden in a derived class, implements the System.Type.IsPointer property and determines whether the System.Type is a pointer.
Returns: if the System.Type is a pointer; otherwise, .
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "IsPointerImpl"))

(cl:defun primitive-impl? (obj!)
  "Summary: When overridden in a derived class, implements the System.Type.IsPrimitive property and determines whether the System.Type is one of the primitive types.
Returns: if the System.Type is one of the primitive types; otherwise, .
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "IsPrimitiveImpl"))

(cl:defun subclass-of? (obj! c)
  "Summary: Determines whether the current System.Type derives from the specified System.Type.
Returns: if the current derives from c; otherwise, . This method also returns if c and the current are equal.
Parameters:
  - c (System.Type): The type to compare with the current type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "IsSubclassOf" c))

(cl:defun value-type-impl? (obj!)
  "Summary: Implements the System.Type.IsValueType property and determines whether the System.Type is a value type; that is, not a class or an interface.
Returns: if the System.Type is a value type; otherwise, .
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "IsValueTypeImpl"))

(cl:defun make-array-type (obj! cl:&optional (rank cl:nil supplied-rank))
  "Master wrapper for System.Type.MakeArrayType overloads. Dispatches at runtime.

MakeArrayType() -> Type
  Summary: Returns a System.Type object representing a one-dimensional array of the current type, with a lower bound of zero.
  Returns: A System.Type object representing a one-dimensional array of the current type, with a lower bound of zero.

MakeArrayType(Int32) -> Type
  Summary: Returns a System.Type object representing an array of the current type, with the specified number of dimensions.
  Returns: An object representing an array of the current type, with the specified number of dimensions.
  Parameters:
    - rank (System.Int32): The number of dimensions for the array. This number must be less than or equal to 32.
"
  (cl:cond
    ((cl:and supplied-rank (cl:numberp rank))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "MakeArrayType" rank))
    ((cl:and (cl:not supplied-rank))
     (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "MakeArrayType"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-TYPE"
                    :class-name <type-str>
                    :method-name "MakeArrayType"
                    :supplied-args (cl:append (cl:when supplied-rank (cl:list :rank rank)))))))

(cl:defun make-by-ref-type (obj!)
  "Summary: Returns a System.Type object that represents the current type when passed as a parameter ( parameter in Visual Basic).
Returns: A System.Type object that represents the current type when passed as a parameter ( parameter in Visual Basic).
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "MakeByRefType"))

(cl:defun make-generic-method-parameter (position)
  "Summary: Returns a signature type object that can be passed into the Type[] array parameter of a System.Type.GetMethod method to represent a generic parameter reference.
Returns: A signature type object that can be passed into the Type[] array parameter of a System.Type.GetMethod method to represent a generic parameter reference.
Parameters:
  - position (System.Int32): The typed parameter position.
"
  (dotnet:static <type-str> "MakeGenericMethodParameter" (cl:the (dotnet "System.Int32") position)))

;; The following C# System.Type.MakeGenericSignatureType overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   MakeGenericSignatureType(Type, params Type[]) -> Type

;; The following C# System.Type.MakeGenericType overloads have special parameter types
;; (ref, out, params, or defaults) and are not yet supported:
;;   MakeGenericType(params Type[]) -> Type

(cl:defun make-pointer-type (obj!)
  "Summary: Returns a System.Type object that represents a pointer to the current type.
Returns: A System.Type object that represents a pointer to the current type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "MakePointerType"))

(cl:defun not= (left right)
  "Summary: Indicates whether two System.Type objects are not equal.
Returns: if left is not equal to right; otherwise, .
Parameters:
  - left (System.Type): The first object to compare.
  - right (System.Type): The second object to compare.
"
  (dotnet:static <type-str> "op_Inequality" (cl:the (dotnet "System.Type") left) (cl:the (dotnet "System.Type") right)))

(cl:defun reflection-only-get-type (type-name throw-if-not-found ignore-case)
  "Summary: Gets the System.Type with the specified name, specifying whether to perform a case-sensitive search and whether to throw an exception if the type is not found. The type is loaded for reflection only, not for execution.
Returns: The type with the specified name, if found; otherwise, . If the type is not found, the throwIfNotFound parameter specifies whether is returned or an exception is thrown. In some cases, an exception is thrown regardless of the value of throwIfNotFound. See the Exceptions section.
Parameters:
  - type-name (System.String): The assembly-qualified name of the System.Type to get.
  - throw-if-not-found (System.Boolean): to throw a System.TypeLoadException if the type cannot be found; to return if the type cannot be found. Specifying also suppresses some other exception conditions, but not all of them. See the Exceptions section.
  - ignore-case (System.Boolean): to perform a case-insensitive search for typeName; to perform a case-sensitive search for typeName.
"
  (dotnet:static <type-str> "ReflectionOnlyGetType" (cl:the (dotnet "System.String") type-name) (cl:the (dotnet "System.Boolean") throw-if-not-found) (cl:the (dotnet "System.Boolean") ignore-case)))

(cl:defun to-string (obj!)
  "Summary: Returns a representing the name of the current .
Returns: A System.String representing the name of the current System.Type.
"
  (dotnet:invoke (cl:the (dotnet "System.Type") obj!) "ToString"))

