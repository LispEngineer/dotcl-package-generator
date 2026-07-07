# Assembly Metadata in Lispy Format

* Copyright 2026 Douglas P. Fields, Jr.

## Overview

A program that reads information about an assembly (its `.dll` and associated
documentation `.xml` file) and outputs information that will be used to
generate DotCL Lisp packages. The output will be in a Common Lisp compatible
s-expression format.

There are several reasonable approaches to doing this:
* Use DocFX on the assembly to generate YAML
  * Then convert the YAML
* Use Roslyn/Microsoft Code Analysis tools in C#
  * Directly output s-expressions

## References

References:
* [DotNet YAML Format](https://dotnet.github.io/docfx/docs/dotnet-yaml-format.html)
* [DocFX Metadata Format](https://dotnet.github.io/docfx/spec/metadata_format_spec.html)
* [DocFX CLI](https://dotnet.github.io/docfx/reference/docfx-cli-reference/overview.html)
* [Microsoft.CodeAnalysis](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/overview?tabs=net-10)
* [C# S-Expression Code](https://rosettacode.org/wiki/S-expressions#C#)

## Details

What we care about:
* Methods, including:
  * Operator overloads
  * Accessors
* Properties & Fields
* Constructors
* Namespace
* Name
* Type: Class, Struct, etc.
* Superclasses
* Interfaces
* Static or not
* Generic Parameters

For methods, constructors and anything else that takes parameters:
* Parameter lists
* Parameter types (fully qualified)
* Parameter names
* Parameter defaults

For methods and the constructors, outputa single top level entry
with the name of the method (or the constructor), and a list of
all the overloads.

For anything which will have its name mangled in the CIL version
(e.g., `operator +` becomes `op_Addition`), include the mangled
version of the name which is what would need to be called by
DotCL's `invoke`.

# Details of Output Format

The general format is a Common Lisp s-expression.

To ensure compatibility with Common Lisp readers and environments, the output
file is encoded in UTF-8 without a Byte Order Mark (BOM).

The top-level form is a list containing one entry per class (or other C# entity) being documented.

Each entry is a Common Lisp plist with keys that are keywords. All keys are Common Lisp keywords.

> [!IMPORTANT]
> This section must be kept updated with any future changes to the `AssemblyToLispy` code and metadata output structure.

## Entity Entry Details

Each type entry plist contains the following entries, by key:

* `:name` (String): The simple name of the type (e.g., `ArrayList` or ``Action`4``).
  For a nested type this is just its own simple name (e.g. `Glyph`), never including
  any enclosing type.
* `:fully-qualified-name` (String): The fully qualified name of the type, including
  the namespace (e.g., `System.Collections.ArrayList` or ``System.Action`4``). For a
  nested type, this is CIL's native `Type.FullName`, which separates the type from
  its enclosing type(s) with `+` rather than `.` (e.g.
  `Microsoft.Xna.Framework.Graphics.SpriteFont+Glyph`) — this value is used verbatim,
  unmodified, since it is what live .NET reflection APIs (`monoutils:get-type`,
  `dotnet:resolve-type`, `dotnet:the` type hints) require to resolve the type. See
  `doc/generator-design-notes.md`'s "Nested Type Package Naming (Version 19)" section
  for how the *generator* derives a human-friendly Lisp package/file name from this
  value (it flattens `+` the same way it flattens namespace `.`, rather than leaking
  the literal `+` into the generated name). The same applies to the backtick-arity
  suffix an open generic type's name carries (e.g. `` Dictionary`2 ``, `` System.Action`4 ``)
  — see that doc's "Generic Type Backtick Sanitization (Version 20)" section for why a
  raw backtick is unsafe to leave in a generated Lisp symbol/package name.
* `:namespace` (String): The namespace in which the type is defined 
  (e.g., `System.Collections` or `System`).
* `:kind` (Keyword): The classification of the C# entity. Must be one of the following:
  * `:class` (a class type)
  * `:struct` (a value type that is not an enum)
  * `:interface` (an interface type)
  * `:enum` (an enumeration type)
  * `:delegate` (a delegate type)
* `:enum-underlying-type` (String or omitted): Present only when `:kind` is `:enum`; the
  fully qualified name of the enum's underlying integral type (e.g. `"System.Int32"`, via
  `Enum.GetUnderlyingType(type)`). Omitted for every other `:kind`.
* `:documentation` (Documentation Plist or omitted): A plist containing the type-level XML
  documentation summary. Omitted if no documentation is found.
* `:superclass` (String or `nil`): The fully qualified name of the base class. 
  If there is no base class (such as for interfaces or `System.Object`), 
  this value is `nil`. **When the base class is a generic type** (whether closed to
  concrete type arguments, e.g. `List<int>`, or still parameterized by this type's own
  unresolved type parameter, e.g. `class Derived<T> : Base<T>`), this value is always
  the generic type *definition*'s own identity — the same bare, unqualified
  `` Name`Arity `` form under which that type is separately reflected as its own
  top-level entry's `:fully-qualified-name` (e.g. `` System.Collections.Generic.List`1 ``)
  — **never** a specific instantiation's closed/assembly-qualified form. This is
  deliberate (Version 40 of the package generator; see
  `doc/generator-design-notes.md`'s "Generic Superclass/Interface Identity Matching
  (Version 40)" section): `:superclass` exists so downstream tooling can match a
  type's base against another type's own `:fully-qualified-name`, and no arbitrary
  closed generic instantiation is ever itself a separately reflected type — only the
  open generic type definition is. See `:superclass-closed` below for the discarded
  closed-instantiation information, preserved under a sibling key.
* `:superclass-closed` (String or omitted): Present only when `:superclass` is present
  **and** the base class is a generic type (in either sense above) — i.e. omitted
  whenever it would be textually identical to `:superclass` (a non-generic base).
  The base class formatted with simplified generic-argument bracket notation (the same
  notation `:type`/`:return-type` use, via the recursive backtick/bracket formatter —
  see Phase 2C's "Simplified Generic Type Formatting" below), preserving which concrete
  type argument(s) (or, in the unresolved-type-parameter case, the parameter's own name)
  the base class actually uses. This is descriptive/documentation-only — nothing in this
  generator needs it, since ancestor resolution always matches on `:superclass`'s bare
  identity form instead.
* `:interfaces` (List of Strings or `nil`): An alphabetically sorted, **deduplicated** list of
  the fully qualified names of all interfaces implemented by this type. If no interfaces are 
  implemented, this value is `nil`. Exactly like `:superclass` above, a **generic**
  interface reference (closed or still parameterized by this type's own unresolved type
  parameter) is always the generic type definition's own bare identity, never a specific
  instantiation's closed/assembly-qualified form — see `:interfaces-closed` below for the
  discarded per-interface closed-instantiation information. Deduplication matters here
  specifically because C# permits a type to implement the *same* open generic interface more
  than once, closed over different type arguments (e.g. `class Foo : IEquatable<int>,
  IEquatable<string>`, which compiles) — without deduplication this list would contain the
  same identity string twice.
* `:interfaces-closed` (Plist or omitted): Maps each identity in `:interfaces` that is
  actually a generic interface to a list of that identity's simplified-bracket-notation
  closed form(s), exactly as `:superclass-closed` computes each one — one key/value pair
  per generic identity, in the plist form used everywhere else in this schema (`:name`,
  `:kind`, etc. are all plist keys too). A value list has more than one element only in
  the rare case where a type implements the *same* open generic interface more than once,
  closed over different type arguments (legal C#, e.g. `class Foo : IEquatable<int>,
  IEquatable<string>`, confirmed to compile) — this is exactly why each key's value is a
  *list* of closed forms, not a single string:
  ```lisp
  :interfaces-closed
    ("System.IEquatable`1" ("System.IEquatable`1[System.Int32]" "System.IEquatable`1[System.String]"))
  ```
  A **non**-generic interface is never given a key here at all (its identity and closed
  form are identical, already fully captured by `:interfaces`) — so this whole key is
  omitted when no implemented interface is generic. Descriptive/documentation-only, like
  `:superclass-closed`.

  > [!IMPORTANT]
  > **This plist's keys are strings, not symbols — do not look them up with `GETF`.**
  > Common Lisp's `GETF` is specified to compare keys with `EQ`, and a string freshly
  > read from a metadata file via `READ` is never `EQ` to a string literal you type in
  > your own code, even when the two are `STRING=`. `(getf interfaces-closed
  > "System.IEquatable\`1")` is not guaranteed to find the entry above. Instead, look up
  > an identity with `MEMBER` and take the second element of what it returns:
  > ```lisp
  > (second (member "System.IEquatable`1" interfaces-closed :test #'string=))
  > ;; => ("System.IEquatable`1[System.Int32]" "System.IEquatable`1[System.String]")
  > ```
* `:flags` (List of Keywords or `nil`): A list of active boolean type flags, converted
  to Lisp-friendly kebab-case keywords. If no flags are active, this value is `nil`.
  Supported flag keywords are:
  * `:abstract` (the type is abstract)
  * `:sealed` (the type is sealed)
  * `:import` (the type is imported from a COM type library)
  * `:serializable` (the type has the `[Serializable]` attribute)
  * `:generic-type` (the type is a generic type)
  * `:generic-type-definition` (the type is a generic type definition)
  * `:nested` (the type is nested inside another type)
* `:properties` (List of Property Plists or omitted): A list of plists containing
  details of public or protected properties declared directly on the type. If no
  properties are declared, this key is omitted. Each property plist contains:
  * `:name` (String): The name of the property.
  * `:type` (String): The fully qualified type of the property (using simplified
    backtick notation for generic types).
  * `:assembly-qualified-type` (String or omitted): The full assembly-qualified name
    of the property type. Omitted unless the type is assembly-qualified.
  * `:readable` (Keyword `t` or omitted): Omitted if the property is not
    readable; otherwise `t`.
  * `:writeable` (Keyword `t` or omitted): Omitted if the property is not
    writeable; otherwise `t`.
  * `:static` (Keyword `t` or omitted): Omitted if the property is not static;
    otherwise `t`.
  * `:get-method` (String or omitted): Omitted if there is no visible getter;
    otherwise the name of the getter method.
  * `:set-method` (String or omitted): Omitted if there is no visible setter;
    otherwise the name of the setter method.
  * `:parameters` (List of Parameter Plists or omitted): An ordered list of plists for
    each index parameter, formatted identically to a method's own `:parameters`. Present
    only for an indexer (C#'s `this[...]`); omitted for an ordinary property, which has
    no index parameters.
  * `:documentation` (Documentation Plist or omitted): Omitted if no documentation is
    found; otherwise a plist containing property documentation.
* `:fields` (List of Field Plists or omitted): A list of plists containing
  details of public or protected fields declared directly on the type. If no
  fields are declared, this key is omitted. Each field plist contains:
  * `:name` (String): The name of the field.
  * `:type` (String): The fully qualified type of the field (using simplified
    backtick notation for generic types).
  * `:assembly-qualified-type` (String or omitted): The full assembly-qualified name
    of the field type. Omitted unless the type is assembly-qualified.
  * `:static` (Keyword `t` or omitted): Omitted if the field is not static;
    otherwise `t`.
  * `:literal` (Keyword `t` or omitted): Omitted if the field is not a
    compile-time constant; otherwise `t`.
  * `:init-only` (Keyword `t` or omitted): Omitted if the field is not
    read-only; otherwise `t`.
  * `:public` (Keyword `t` or omitted): Omitted if the field is not public;
    otherwise `t`.
  * `:documentation` (Documentation Plist or omitted): Omitted if no documentation is
    found; otherwise a plist containing field documentation.
* `:constructors` (List of Constructor Plists or omitted): A list of plists containing
  details of public or protected constructors declared directly on the type. If no
  constructors are declared, this key is omitted. Each constructor plist contains:
  * `:public` (Keyword `t` or omitted): Omitted if the constructor is not public;
    otherwise `t`.
  * `:protected` (Keyword `t` or omitted): Omitted if the constructor is not protected;
    otherwise `t`.
  * `:protected-internal` (Keyword `t` or omitted): Omitted if the constructor is
    not protected internal; otherwise `t`.
  * `:parameters` (List of Parameter Plists or omitted): An ordered list of plists
    for each parameter. If the constructor takes no parameters, this key is omitted.
  * `:documentation` (Documentation Plist or omitted): Omitted if no documentation is
    found; otherwise a plist containing constructor documentation.
* `:methods` (List of Method Plists or omitted): A list of plists containing
  details of public or protected methods declared directly on the type. If no
  methods are declared, this key is omitted. Each method plist contains:
  * `:name` (String): The clean name of the method (mathematical/logical operator
    symbols are used for C# operator overloads).
  * `:mangled-name` (String or omitted): The CIL runtime name of the method. Omitted
    if the clean name is identical to the mangled name.
  * `:is-static` (Keyword `t` or omitted): Omitted if the method is not static;
    otherwise `t`.
  * `:extension-method` (Keyword `t` or omitted): Omitted if the method is not an extension
    method; otherwise `t`.
  * `:is-generic` (Keyword `t` or omitted): Omitted if the method has no generic type
    arguments of its own; otherwise `t`.
  * `:generic-arity` (Integer or omitted): The method's own number of generic type
    arguments (via `MethodInfo.GetGenericArguments().Length`). Present only when
    `:is-generic` is `t`; omitted for a non-generic method.
  * `:return-type` (String): The fully qualified return type of the method (using
    simplified backtick notation for generic types).
  * `:assembly-qualified-return-type` (String or omitted): The full assembly-qualified
    name of the return type. Omitted unless the type is assembly-qualified.
  * `:parameters` (List of Parameter Plists or omitted): An ordered list of plists
    for each parameter. If the method takes no parameters, this key is omitted.
  * `:documentation` (Documentation Plist or omitted): Omitted if no documentation is
    found; otherwise a plist containing method documentation.
* `:events` (List of Event Plists or omitted): A list of plists containing details of
  public or protected **instance** events (`add_X`/`remove_X` accessor pairs) declared
  directly on the type. If no instance events are declared, this key is omitted. Static
  events (raised via a static `add_X`/`remove_X` pair with no receiver object) are never
  included here -- they are filtered out entirely at reflection time, since there is no
  documented/verified DotCL calling convention for a receiverless event yet (see
  `doc/generator-design-notes.md`'s "Events (Version 32)" section and `PLAN.md`). Each
  event plist contains:
  * `:name` (String): The name of the event.
  * `:type` (String): The fully qualified delegate type of the event (e.g.
    `System.EventHandler`), using simplified backtick notation for generic delegate
    types. This is descriptive/documentation-only -- the generator does not need it,
    since `dotnet:add-event`/`dotnet:remove-event` resolve the correct delegate type from
    the live `EventInfo` at runtime.
  * `:add-method` (String): The name of the compiler-generated `add_X` accessor method.
  * `:remove-method` (String): The name of the compiler-generated `remove_X` accessor
    method.
  * `:documentation` (Documentation Plist or omitted): Omitted if no documentation is
    found; otherwise a plist containing event documentation.

### Parameter Plist Details

Each parameter plist contains:
* `:name` (String): The name of the parameter.
* `:type` (String): The fully qualified type of the parameter (using simplified
  backtick notation for generic types).
* `:assembly-qualified-type` (String or omitted): The full assembly-qualified
  name of the parameter type. Omitted unless the type is assembly-qualified.
* `:extension-this` (Keyword `t` or omitted): Omitted if this is not the `this` parameter
  of an extension method; otherwise `t`.
* `:out` (Keyword `t` or omitted): Omitted if the parameter is not an `out` parameter; otherwise `t`.
* `:ref` (Keyword `t` or omitted): Omitted if the parameter is not a `ref` parameter; otherwise `t`.
* `:ref-readonly` (Keyword `t` or omitted): Omitted if the parameter is not an `in` or `ref readonly` parameter; otherwise `t`. Both C# `in` and `ref readonly` map to this identical keyword.
* `:scoped` (Keyword `t` or omitted): Omitted if the parameter is not a `scoped` parameter; otherwise `t`.
* `:params` (Keyword `t` or omitted): Omitted if the parameter is not a `params` array; otherwise `t`.
* `:has-default` (Keyword `t` or omitted): Omitted if the parameter has no
  default value; otherwise `t`.
* `:default-value` (Lisp value or omitted): Omitted if `:has-default` is omitted;
  otherwise the formatted default value as a valid Common Lisp literal.


### Documentation Plist Details

Each documentation plist contains:
* `:summary` (String or omitted): The cleaned description of the entity.
* `:returns` (String or omitted): The cleaned description of the returned value (for
  properties and methods).
* `:parameters` (List of Parameter Doc Plists or omitted): A list of plists for each
  documented parameter. If there are no parameters, this key is omitted.
  Each parameter doc plist contains:
  * `:name` (String): The name of the parameter.
  * `:description` (String): The description text for the parameter.


# Implementation Phases

This will be implemented in phases.

## Phase 1: Roslyn / Microsoft Code Analysis

* Read an assembly
  * Input: Assembly directory, filename of `.dll`
  * Output: Destination filename

* Output format: 
  * A single Common Lisp List in S-expression format
  * Each entry in the list is a Common Lisp plist
    containing information about one entry in the Assembly
  * Plist keys: Common Lisp keywords (e.g., :methods)
  * Plist values: As necessary:
    * Common Lisp Strings
    * Common Lisp Lists
    * Common Lisp PLists

* Console output: Have the class write information to the
  console about what it's doing, at least for each
  entry of the assembly level.
  * Each line written should include a prefix that shows what
    part of the code is executing, e.g., `[OutputClass] Processing class: System.Collections.ArrayList`

* For each item in assembly, output to the output file:
  * Name of the class/struct/whatever
  * Fully qualified name
  * Namespace
  * List of methods (one per override)

No parameters, nothing else. Just very basic information, to
prove that we can read it and output a well-fromatted
Common Lisp s-expression.

### Notes on Output

* **Names with backticks**: If a name has a backtick followed by a number,
  that indicates the number of generic parameters that  class has.
  For example, ``Tuple`3`` means a `Tuple` with 3 generic arguments.

## Phase 2: Detailed Metadata and Documentation

Phase 2 is divided into five sequential sub-phases:

* **Phase 2A**: Add general metadata
* **Phase 2B**: Add details on fields and properties
* **Phase 2C**: Add details on the methods and constructors
* **Phase 2D**: Add documentation information
* **Phase 2E**: Add remaining Phase 2 capabilities (generic constraints, attributes, etc.)

### Phase 2A: Add General Metadata

This sub-phase extracts top-level type kind and classification properties:
* **Kind of Type**: Output a `:kind` key (e.g., `:class`, `:struct`, 
  `:interface`, `:enum`, `:delegate`).
* **Inheritance**:
  * `:superclass`: Fully qualified name of the base class -- always the bare generic
    type DEFINITION identity for a generic base (never a closed/assembly-qualified
    instantiation; see `:superclass-closed`, Version 40).
  * `:interfaces`: A list of fully qualified names of implemented interfaces --
    likewise always each interface's bare generic type DEFINITION identity when
    generic (see `:interfaces-closed`, Version 40).
* **Type Flags**: Convert standard boolean reflection checks (`IsSealed`, `IsAbstract`, 
  etc.) to Lisp-friendly keywords, mapped under a `:flags` key, e.g. 
  `(:flags (:sealed :abstract))`.
* **Kebab-Case Utility**: Implement a `CamelCaseToKebabCase` string helper 
  (converts PascalCase/camelCase to kebab-case keywords, e.g., `:is-value-type`).

### Phase 2B: Add Details on Fields and Properties

This sub-phase extracts member variables and metadata accessors:

* **Properties**:
  * Extract using `type.GetProperties()`.
  * Format each property as a plist:
    * `:name`: Property name.
    * `:type`: Fully qualified property type.
    * `:readable`: `t` or `nil`.
    * `:writeable`: `t` or `nil`.
    * `:static`: `t` or `nil`.
    * The names of the get and set methods (if any)
    * `:parameters`: for an indexer (`this[...]`), the index parameters (via
      `PropertyInfo.GetIndexParameters()`), formatted the same way as a method's
      parameters; omitted for an ordinary property.
    * Any other relevant information from `PropertyInfo`
* **Fields**:
  * Extract using `type.GetFields()`.
  * Format each field as a plist:
    * `:name`: Field name.
    * `:type`: Fully qualified type.
    * `:static`: `t` or `nil`.
    * `:literal`: `t` or `nil` (for constants).
    * `:init-only`: `t` or `nil` (for read-only fields).
    * `:public`: `t` or `nil`.

* **Filtering of Compiler-Generated Members**:
  * Members marked with `System.Runtime.CompilerServices.CompilerGeneratedAttribute`
    are skipped to avoid cluttering the metadata with internal implementation
    details (such as auto-property backing fields, iterator state machines, or
    closures) that are not part of the developer-authored API.
  * Fields starting with `<` (e.g., `<MyProperty>k__BackingField`) are omitted
    because they represent internal backing fields for auto-implemented properties.
    Access to these states is intended via public property accessor methods
    (e.g., `get_MyProperty`), and their CIL names contain characters invalid in C#
    identifiers.

Any value that is `nil` should have its key omitted, as `getf` will
default to `nil` anyway.

### Phase 2C: Add Details on Methods and Constructors

This sub-phase extracts detailed signatures for methods, constructors, and parameter lists:

* **Constructors**:
  * Extract using `type.GetConstructors()`.
  * Format under a `:constructors` list as a plist containing `:parameters` 
    (ordered list of parameter plists).

* **Methods (including Operator Overloads)**: Group methods by clean name 
  under `:methods`. For each method, generate a plist:
  * `:name`: Clean name.
  * `:mangled-name`: Real CIL name (e.g., `op_Addition` for operator overloads).
  * `:is-static`: `t` or `nil`.
  * `:return-type`: Fully qualified name of the return type.
  * `:parameters`: List of parameter plists (ordered).

* **Parameters**: For each parameter, capture a plist:
  * `:name`: Parameter name.
  * `:type`: Fully qualified parameter type.
  * `:has-default`: `t` or `nil`.
  * `:default-value`: Formatted default value representation (e.g. string, number, or `:nil`).

Continue the "omit `nil`s" convention from Phase 2B.

* **Implementation Choices for Phase 2C**:
  * **Overloads Handling**: Each overload is output as an individual plist inside
    the `:methods` list. The `:methods` list is grouped (sorted) consecutively
    first by clean name, and then by parameter count.
  * **Accessor Filtering**: Property getters and setters, as well as event
    accessors, are filtered out from the general `:methods` list (via checking
    `method.IsSpecialName && !method.Name.StartsWith("op_")`) to prevent
    duplicate method definitions.
  * **Operator Overload Mapping**: Clean names for operator overloads are mapped
    to standard mathematical/logical symbols (e.g. `+` for `op_Addition`, `<`
    for `op_LessThan`), while `:mangled-name` captures the CIL runtime name
    (`op_Addition`).
  * **Mangled Name Omission**: If the clean name of a method is identical to its
    mangled CIL name, the `:mangled-name` key is omitted from the plist.
  * **Default Values Formatting**: Default values are formatted to ensure valid,
    interpretable Common Lisp literals:
    * `null`: Formatted as the Lisp symbol `nil`.
    * `bool`: Formatted as `t` or `nil`.
    * Integers: Formatted as raw integer strings (e.g. `123`).
    * Single-floats: Formatted with the single-float exponent indicator `f` (e.g.
      `1.5f0` or `0.000123f0`), leveraging DotCL's `SingleFloat` representation.
    * Double-floats: Formatted with the double-float exponent indicator `d` (e.g.
      `1.5d0` or `0.000123d0`), leveraging DotCL's `DoubleFloat` representation.
    * Decimals: Integral decimal values are formatted as integers. Fractional
      decimal values are serialized as simplified ratio literals (e.g. `5/4`)
      using GCD reduction.
    * Characters: Formatted as Common Lisp character literals (e.g. `#\Space`,
      `#\Newline`, or `#\LATIN CAPITAL LETTER A`) leveraging DotCL's `LispChar`
      definition.
    * Enums, structs, and custom objects: Formatted as escaped Lisp strings
      (e.g. `"AllowThousands, Float"`), ensuring they parse as valid Lisp string
      literals.
  * **Simplified Generic Type Formatting**: Closed generic types are formatted
    using Option 2 (simplified backtick syntax: `Name`Arity[Args...]`),
    recursively omitting assembly name, version, culture, and token attributes
    for all generic type parameters.
  * **Programmatic Assembly-Qualified Name Detection**: A type's name is detected
    as assembly-qualified if it recursively contains any closed generic type
    (using a helper that checks ``type.IsGenericType && !type.IsGenericTypeDefinition``
    on the type and its elements or generic parameters).
  * **Assembly-Qualified Sibling Fields**: When a type is programmatically
    identified as assembly-qualified, an additional sibling field
    (`:assembly-qualified-type` or `:assembly-qualified-return-type` for return
    values) is output containing the complete assembly-qualified type string,
    preserving full metadata details for future FFI use.

### Phase 2D: Add Documentation Information

This sub-phase integrates assembly XML documentation comments into the metadata output:
* **Parsing Options**:
  * **Option A (Direct Parsing)**: Load and parse the associated `.xml` file directly using
    `System.Xml.Linq.XDocument`. This is self-contained and lightweight.
    * *Implementation Choice*: Option A was chosen to avoid taking a dependency on the heavy
      `Microsoft.CodeAnalysis` library for XML document loading. The target assembly path has its
      extension changed to `.xml` (e.g. `System.Runtime.xml`), which is then loaded via
      `XDocument.Load()`.
  * **Option B (Roslyn Provider)**: Use
    `Microsoft.CodeAnalysis.XmlDocumentationProvider.CreateFromFile(xmlPath)` to obtain the
    documentation. Note that while this manages file loading/caching, it still returns raw XML
    strings (e.g., `<member name="...">...</member>`), requiring custom XML parsing to extract clean
    text. It also adds a dependency on the `Microsoft.CodeAnalysis` NuGet package.
* **Signature Mapping**: Match reflection signatures to XML documentation keys:
  * Types: `T:Namespace.TypeName`
    * Replacing inner class nested separator `+` with `.`.
  * Methods: `M:Namespace.TypeName.MethodName(Args...)`
    * Generic methods use `` `generic_count`` suffix (e.g., `` `1``).
    * If generic arguments are nested or parameter types are generic, they 
      are mapped to `` `index``
      (declaring class generic parameters) or `` `index`` (declaring method generic parameters).
    * Array parameter types use suffix brackets `[]`.
    * By-ref parameter types append a `@` decorator.
    * Pointer parameter types append a `*` decorator.
    * Closed generic parameters use curly braces `{}` (e.g.,
      `System.Collections.Generic.List{System.Int32}`).
  * Properties: `P:Namespace.TypeName.PropertyName`
  * Fields: `F:Namespace.TypeName.FieldName`
* **Text Cleaning**:
  * Inline XML tags like `<see cref="..."/>` and `<paramref name="..."/>` are parsed and
    replaced with their plain text name.
  * Extraneous and multiple whitespaces/newlines are consolidated into single space characters,
    with trailing spaces trimmed.
* **Output**: Build a dictionary lookup of XML comments, and append a `:documentation` key to the
  corresponding type/member/property plist containing the summary text and parameter descriptions.
  * Note: For property, field, constructor, and method plists, the `:documentation` key is
    appended at the very end of their respective plist to preserve backwards compatibility of
    prefix substring checking in tests.

### Phase 2E: Parameter types & extension methods

This phase adds information about each parameter as to whether or not
any of these parameter modifiers apply:
* `ref`
* `out`
* `ref readonly`
* `in`
* `scoped`
* `params`

This phase also adds information as to whether a given method is
an Extension Method. If it is an extension method, the first
parameter is clearly labeled as the `this` object of an extension
method.

* **Implementation Choices for Phase 2E**:
  * **Parameter Modifiers**: Reflection attributes are converted to boolean Lisp keywords (`:out t`, `:ref t`, `:scoped t`, `:params t`) added to the parameter's plist.
  * **in / ref readonly**: In .NET reflection, both `in` and `ref readonly` parameters are represented identically (as by-reference types with `IsReadOnlyAttribute`). Therefore, both are mapped to a single identical keyword `:ref-readonly t` with no distinction made between them.
  * **Extension Methods**: The method's plist receives an `:extension-method t` flag based on the presence of `ExtensionAttribute`. The first parameter of such a method is explicitly labeled with `:extension-this t`.

### Phase 3: Testing Infrastructure Improvements

Phase 3 is dedicated to replacing the fragile string-based tests with
a robust, native Lisp testing framework that validates the S-expression output.

#### Phase 3A: Improved Tests & Lisp Utilities

*Original Plan (Option considered but refined):*
Since this is are running in a DotCL environment, for tests, implement them in this way:
* Create an `assembly-to-lispy-tests.lisp` DotCL Common Lisp file.
* In the C# `AssemblyToLispy.cs`, build a test that loads the `.lisp` file
  above and executes the tests in there, passing the filename of the generated output file.
* The tests safely load the output file and ensure it is properly formatted. Look for 
  correct class entries using `find-if`, `getf`, etc.
* Many more tests should be made to cover every single possible output case by picking 
  classes from the C# assembly. If an edge case isn't found in `System.Runtime.dll`, 
  Antigravity should inform the user.

*Revised Plan (To be implemented):*
* **Utility Extraction**: Extract the existing `safe-read-form-from-file` and
  `file-exists-and-readable-p` functions from `texture-atlas.lisp` into a new
  `utils.lisp` file. Create a new `utils` package in `packages.lisp` and 
  register it in the `.asd` file. This makes safe loading globally accessible.
* **Lisp Testing Script**: Create `assembly-to-lispy-tests.lisp` using
   `utils:safe-read-form-from-file`. Implement a minimal testing DSL (e.g., 
   `deftest`, `assert-equal`) to cleanly report failures.
* **Spot Checks**: Reimplement the spot-checks for `System.Runtime.dll` using Lisp.
* **C# Test Runner Interop**: Modify the test runner in `AssemblyToLispy.cs` 
  to execute the Lisp script and accurately bubble up success/failure status to C#.

#### Phase 3B: Synthetic Test Assembly Target (DONE)

* **Dedicated Test Assembly**: Instead of hoping to find every edge case 
  in `System.Runtime.dll`, create a minimal C# project (e.g., 
  `MGLD.AssemblyTestTarget.csproj`) explicitly authored to contain every
  single metadata edge case (`scoped`, `ref readonly`, complex generic constraints).
* Generating metadata for this synthetic assembly guarantees 100% test coverage 
  for complex reflections.

#### Phase 3C: Comprehensive Schema Validation (DONE)

A strict, recursive Lisp validation engine has been implemented in
[assembly-to-lispy-tests.lisp](../assembly-to-lispy-tests.lisp) -
may have been renamed to
[assembly-to-lispy-tests-final.lisp](../assembly-to-lispy-tests-final.lisp) -
that walks the entire generated metadata tree to perform both structural
schema validation and semantic CLR reflection verification.

*   **Structural Schema Checks**: Every plist level (types, properties, fields,
    constructors, methods, parameters, and documentation elements) is recursively
    validated to ensure all mandatory keys are present, no unknown keys are included,
    and all values have the correct data types.
*   **Semantic CLR Verification**: For every type entry, the validator attempts to resolve
    its `:fully-qualified-name` inside the live AppDomain using `monoutils:get-type`.
    If resolved, it queries the loaded type's members (using C# helper methods exposed
    in `MonoUtils.cs` to bypass dynamic invocation type casting issues) and confirms
    that every property, field, method, and constructor documented in the metadata
    actually exists on the C# type.

#### Phase 3D: Test Real-World Assemblies (DONE)

Testing has been expanded beyond standard libraries to run full schema validation
and semantic reflection checks against the exact assemblies this project actively uses:

*   **Target Assemblies**: The test pipeline generates and validates metadata for:
    *   `System.Runtime.dll`
    *   `System.Console.dll`
    *   `AssemblyToLispyTestTarget.dll`
    *   `MonoGame.Framework.dll`
    *   `DotCL.Runtime.dll`
    *   `DungeonSlime.dll`
    *   `NVorbis.dll`
*   **Recursive Schema and Semantic Validation**: All generated metadata files are parsed
    in Common Lisp, recursively validated against the structural schema, and checked via
    CLR reflection for type and member existence.
*   **Targeted Spot Checks**: Native Lisp spot checks verify key classes and methods (e.g.
    `System.Console.WriteLine`, `Microsoft.Xna.Framework.Game.Run`) are correctly represented
    in the metadata.

#### Phase 3E: Modular Test Discovery (DONE)

*   **Extensible Test Runner**: The monolithic test suite has been split and moved to a dedicated
    `tests/` directory:
    *   `tests/framework.lisp`: Hosts the common testing DSL (`deftest`, `assert-equal`, etc.),
        the recursive schema and CLR semantic validation engines, and the registry mechanism.
    *   `tests/*.test.lisp`: Individual test files mapping to target assemblies (e.g.,
        `tests/system-runtime.test.lisp`, `tests/nvorbis.test.lisp`) that use
        `def-assembly-test` to self-register under their target assembly names.
*   **Dynamic Test Discovery**: Modified the C# runner in `AssemblyToLispy.cs` to dynamically
    load `tests/framework.lisp` first, then locate all `*.test.lisp` files in the `tests/`
    directory, evaluating them dynamically before running the test dispatcher.


### Phase 4: Remaining Capabilities

This sub-phase implements advanced type-system characteristics:
* **Generic Constraints**:
  * Extract constraints on generic parameters (e.g., `where T : class`, `new()`, base-type, or interface constraints) using `Type.GetGenericParameterConstraints()`.
  * Format under `:generic-constraints` in the plist to support type-dispatching and constraints validation in the generated Lisp packages.
* **Attributes**:
  * Extract custom attributes applied to types or members (e.g., `[Obsolete]`, `[Extension]`, or custom attributes) using `GetCustomAttributes()`.
  * Format under `:attributes` to enable detection of extension methods and lifecycle/deprecated annotations.

## Phase N: Future

* Handle Extension Methods
  * Even if they're defined in other assemblies
  * How to find and enumerate them?

* Handle the `implicit` keyword in C#

* (done) Antigravity's tests are extremely fragile
  * Checking string output in the manner it does can find spurious matches
    * Parse the S-expression in C# and check the results that way?
    * Load the S-expression in a Lisp session and check results that way?
      * `(defparameter x (with-open-file (stream "/tmp/System.Runtime.lispy.metadata.tmp" :direction :input) (let ((*read-eval* nil)(*readtable* (copy-readtable nil))(*package* (find-package :cl-user)))(read stream nil :eof))))` loads the test output file into a Lisp REPL as `x`
      * Regular Lisp expressions can then find what should be checked, e.g.,
        `(find-if (lambda (item) (string= (getf item :name) "ArrayList")) x)` grabs the
        `ArrayList` entry.
  * Identify the location of the System.Runtime.dll programmatically and
    read it that way?
