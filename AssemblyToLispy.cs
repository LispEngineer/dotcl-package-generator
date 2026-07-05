using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Xml.Linq;

// Douglas P. Fields, Jr. - symbolics@lisp.engineer
// Copyright 2026 Douglas P. Fields, Jr.
// Created: 2026-06-08
// ML assistance: Antigravity CLI, v1.0.6, Gemini Flash 3.5 (Medium), Ubuntu 24.04

/* Original prompt used for Phase 1:

Please review doc/assembly-to-lispy.md.

I would like you to create a new .cs file (exactly one)
that implements "Phase 1" as per that document.
The entry point should be a static method with three
parameters: the input directory, the input assembly file,
and the output file.

There should also be a test class or method that
takes a well known assembly (e.g., "System.Runtime.dll"
from the C# runtime, located in directory
"/usr/lib/dotnet/packs/Microsoft.NETCore.App.Ref/10.0.9/ref/net10.0/"
on Ubuntu, but at 
"/usr/share/dotnet/packs/Microsoft.NETCore.App.Ref/10.0.9/ref/net10.0/"
on Arch Linux)
and ensures that the output is correct for a few items,
such as "System.Collections.ArrayList".

Please ensure that the code is very clean, extensible,
and well documented with comments and complete triple-slash
comments on the classes.
*/

namespace PackageGenerator {

    /// <summary>
    ///   Provides functionality to extract metadata from .NET assemblies and export it in Common Lisp S-expression format.
    ///   This implements Phase 1 of the assembly-to-lispy specification.
    /// </summary>
    public static class AssemblyToLispy {

        /// <summary>
        ///   Generates Common Lisp S-expression metadata for the specified assembly and writes it to the output file.
        /// </summary>
        /// <param name="inputDirectory">The directory containing the assembly and its dependencies.</param>
        /// <param name="inputAssemblyFile">The filename of the target assembly .dll.</param>
        /// <param name="outputFile">The destination path for the generated Lisp file.</param>
        /// <exception cref="ArgumentException">Thrown when input paths are null or empty.</exception>
        /// <exception cref="FileNotFoundException">Thrown when the target assembly file cannot be found.</exception>
        public static void GenerateLispyMetadata(string inputDirectory, string inputAssemblyFile, string outputFile) {
            if (string.IsNullOrEmpty(inputDirectory)) {
                throw new ArgumentException("Input directory cannot be null or empty.", nameof(inputDirectory));
            }
            if (string.IsNullOrEmpty(inputAssemblyFile)) {
                throw new ArgumentException("Input assembly file cannot be null or empty.", nameof(inputAssemblyFile));
            }
            if (string.IsNullOrEmpty(outputFile)) {
                throw new ArgumentException("Output file path cannot be null or empty.", nameof(outputFile));
            }

            string assemblyPath = Path.Combine(inputDirectory, inputAssemblyFile);
            if (!File.Exists(assemblyPath)) {
                throw new FileNotFoundException($"Target assembly file not found: {assemblyPath}");
            }

            WriteLog($"[AssemblyToLispy] Starting metadata extraction for: {assemblyPath}");

            // Load XML documentation if available (Phase 2D)
            string xmlPath = Path.ChangeExtension(assemblyPath, ".xml");
            var xmlDocDict = LoadXmlDocumentation(xmlPath);

            // Set up custom resolver to find dependencies in the same directory
            ResolveEventHandler resolver = (sender, args) => {
                var assemblyName = new AssemblyName(args.Name).Name;
                var dependencyPath = Path.Combine(inputDirectory, assemblyName + ".dll");
                if (File.Exists(dependencyPath)) {
                    WriteLog($"[AssemblyResolver] Resolving dependency: {assemblyName} from {dependencyPath}");
                    return Assembly.LoadFrom(dependencyPath);
                }
                return null;
            };

            AppDomain.CurrentDomain.AssemblyResolve += resolver;

            try {
                Assembly assembly = Assembly.LoadFrom(assemblyPath);
                var allTypes = new List<Type>();

                // Retrieve defined types
                try {
                    allTypes.AddRange(assembly.GetExportedTypes());
                } catch (ReflectionTypeLoadException ex) {
                    WriteLog("[AssemblyToLispy] ReflectionTypeLoadException encountered. Retrieving successfully loaded types.");
                    foreach (var loaderEx in ex.LoaderExceptions) {
                        if (loaderEx != null) {
                            WriteLog($"[AssemblyToLispy] Loader Exception: {loaderEx.Message}");
                        }
                    }
                    allTypes.AddRange(ex.Types.OfType<Type>());
                }

                // Retrieve forwarded types (critical for facades like System.Runtime.dll)
                try {
                    Type[] forwarded = assembly.GetForwardedTypes();
                    if (forwarded != null) {
                        allTypes.AddRange(forwarded);
                    }
                } catch (Exception ex) {
                    WriteLog($"[AssemblyToLispy] Warning: Could not retrieve forwarded types: {ex.Message}");
                }

                // Filter and sort the unique list of public types
                var types = allTypes
                    .Where(t => IsPublicType(t))
                    .GroupBy(t => t.FullName)
                    .Select(g => g.First())
                    .OrderBy(t => t.FullName)
                    .ToList();

                var plistStrings = new List<string>();

                foreach (Type type in types) {
                    string typeName = type.Name;
                    string fullName = type.FullName ?? typeName;
                    string ns = type.Namespace ?? "";

                    // WriteLog($"[OutputClass] Processing class: {fullName}");

                    // Phase 2C: Retrieve constructors
                    var constructors = type.GetConstructors(BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance)
                        .Where(c => c.IsPublic || c.IsFamily || c.IsFamilyOrAssembly)
                        .OrderBy(c => c.GetParameters().Length)
                        .Select(c => FormatConstructorPlist(c, xmlDocDict))
                        .ToList();

                    // Phase 2C: Retrieve methods
                    var methodsList = type.GetMethods(BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Static | BindingFlags.DeclaredOnly)
                        .Where(m => (m.IsPublic || m.IsFamily || m.IsFamilyOrAssembly)
                                    && (!m.IsSpecialName || m.Name.StartsWith("op_"))
                                    && !m.IsDefined(typeof(System.Runtime.CompilerServices.CompilerGeneratedAttribute), false))
                        .OrderBy(m => GetCleanMethodName(m))
                        .ThenBy(m => m.GetParameters().Length)
                        .Select(m => FormatMethodPlist(m, xmlDocDict))
                        .ToList();

                    // Phase 2A: Retrieve type kind, superclass, interfaces, and flags
                    string kindStr = GetTypeKind(type);
                    string superclassStr = type.BaseType != null ? EscapeLispString(type.BaseType.FullName ?? type.BaseType.Name) : "nil";
                    var interfaces = type.GetInterfaces().Select(i => i.FullName ?? i.Name).OrderBy(name => name).ToList();
                    string flagsStr = GetTypeFlags(type);

                    // Phase 2B: Retrieve properties and fields
                    var properties = type.GetProperties(BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Static | BindingFlags.DeclaredOnly)
                        .Where(p => {
                            var getMethod = p.GetMethod;
                            var setMethod = p.SetMethod;
                            bool hasVisibleAccessor = (getMethod != null && (getMethod.IsPublic || getMethod.IsFamily || getMethod.IsFamilyOrAssembly))
                                                   || (setMethod != null && (setMethod.IsPublic || setMethod.IsFamily || setMethod.IsFamilyOrAssembly));
                            return hasVisibleAccessor && !p.IsDefined(typeof(System.Runtime.CompilerServices.CompilerGeneratedAttribute), false);
                        })
                        .OrderBy(p => p.Name)
                        .Select(p => FormatPropertyPlist(p, xmlDocDict))
                        .ToList();

                    var fields = type.GetFields(BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Static | BindingFlags.DeclaredOnly)
                        .Where(f => (f.IsPublic || f.IsFamily || f.IsFamilyOrAssembly)
                                    && !f.IsDefined(typeof(System.Runtime.CompilerServices.CompilerGeneratedAttribute), false)
                                    && !f.Name.StartsWith("<"))
                        .OrderBy(f => f.Name)
                        .Select(f => FormatFieldPlist(f, xmlDocDict))
                        .ToList();

                    // Events: add_X/remove_X accessor pairs, previously invisible entirely since
                    // the method filter above drops IsSpecialName methods. Only instance events
                    // are captured for now -- static events have no verified DotCL calling
                    // convention (see doc/generator-design-notes.md's Events (Version 32) section).
                    var events = type.GetEvents(BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.DeclaredOnly)
                        .Where(e => {
                            var addMethod = e.AddMethod;
                            var removeMethod = e.RemoveMethod;
                            bool hasVisibleAccessor = addMethod != null && (addMethod.IsPublic || addMethod.IsFamily || addMethod.IsFamilyOrAssembly)
                                                   && removeMethod != null && (removeMethod.IsPublic || removeMethod.IsFamily || removeMethod.IsFamilyOrAssembly);
                            return hasVisibleAccessor
                                   && !addMethod!.IsStatic
                                   && !e.IsDefined(typeof(System.Runtime.CompilerServices.CompilerGeneratedAttribute), false);
                        })
                        .OrderBy(e => e.Name)
                        .Select(e => FormatEventPlist(e, xmlDocDict))
                        .ToList();

                    // Build plist dynamically to omit keys with nil values
                    var parts = new List<string>();
                    parts.Add($":name {EscapeLispString(typeName)}");
                    parts.Add($":fully-qualified-name {EscapeLispString(fullName)}");
                    if (!string.IsNullOrEmpty(ns)) {
                        parts.Add($":namespace {EscapeLispString(ns)}");
                    }
                    parts.Add($":kind {kindStr}");
                    if (type.IsEnum) {
                        string underlyingTypeName = Enum.GetUnderlyingType(type).FullName ?? Enum.GetUnderlyingType(type).Name;
                        parts.Add($":enum-underlying-type {EscapeLispString(underlyingTypeName)}");
                    }

                    // Phase 2D: Retrieve type documentation
                    string typeDocKey = GetXmlDocMemberName(type);
                    if (xmlDocDict.TryGetValue(typeDocKey, out var typeElement)) {
                        string docPlist = FormatDocumentationPlist(typeElement);
                        if (docPlist != "nil") {
                            parts.Add($":documentation {docPlist}");
                        }
                    }

                    if (superclassStr != "nil") {
                        parts.Add($":superclass {superclassStr}");
                    }
                    if (interfaces.Any()) {
                        parts.Add($":interfaces {FormatLispList(interfaces)}");
                    }
                    if (flagsStr != "nil") {
                        parts.Add($":flags {flagsStr}");
                    }
                    if (properties.Any()) {
                        parts.Add($":properties ({string.Join(" ", properties)})");
                    }
                    if (fields.Any()) {
                        parts.Add($":fields ({string.Join(" ", fields)})");
                    }
                    if (events.Any()) {
                        parts.Add($":events ({string.Join(" ", events)})");
                    }
                    if (constructors.Any()) {
                        parts.Add($":constructors ({string.Join(" ", constructors)})");
                    }
                    if (methodsList.Any()) {
                        parts.Add($":methods ({string.Join(" ", methodsList)})");
                    }

                    string plistStr = "(" + string.Join(" ", parts) + ")";
                    plistStrings.Add(plistStr);
                }

                var sb = new StringBuilder();
                sb.AppendLine("(");
                foreach (string plistStr in plistStrings) {
                    sb.AppendLine($"  {plistStr}");
                }
                sb.AppendLine(")");

                if (outputFile == "-") {
                    Console.Write(sb.ToString());
                } else {
                    string? outputDirectory = Path.GetDirectoryName(outputFile);
                    if (!string.IsNullOrEmpty(outputDirectory) && !Directory.Exists(outputDirectory)) {
                        Directory.CreateDirectory(outputDirectory);
                    }

                    // Write the output file using a UTF-8 encoding without a Byte Order Mark (BOM),
                    // as some Common Lisp readers and environments cannot process leading BOM characters.
                    var utf8WithoutBom = new UTF8Encoding(false);
                    File.WriteAllText(outputFile, sb.ToString(), utf8WithoutBom);
                    WriteLog($"[AssemblyToLispy] Successfully wrote metadata to {outputFile}");
                }

            } finally {
                AppDomain.CurrentDomain.AssemblyResolve -= resolver;
            }
        }

        /// <summary>
        ///   Checks if the given type is publicly visible, including parent declaring types for nested types.
        /// </summary>
        /// <param name="type">The System.Type to check.</param>
        /// <returns>True if the type is public; otherwise, false.</returns>
        private static bool IsPublicType(Type type) {
            if (type.IsGenericParameter) {
                return false;
            }
            Type? current = type;
            while (current != null) {
                if (!current.IsPublic && !current.IsNestedPublic) {
                    return false;
                }
                current = current.DeclaringType;
            }
            return true;
        }

        /// <summary>
        ///   Escapes a string to make it compatible with Common Lisp string literals.
        /// </summary>
        /// <param name="str">The input string to escape.</param>
        /// <returns>The escaped string wrapped in double quotes, or "nil" if the input is null.</returns>
        private static string EscapeLispString(string str) {
            if (str == null) {
                return "nil";
            }
            var sb = new StringBuilder();
            sb.Append('"');
            foreach (char c in str) {
                if (c == '"') {
                    sb.Append("\\\"");
                } else if (c == '\\') {
                    sb.Append("\\\\");
                } else {
                    sb.Append(c);
                }
            }
            sb.Append('"');
            return sb.ToString();
        }

        /// <summary>
        ///   Formats a collection of strings as a space-separated Common Lisp list.
        /// </summary>
        /// <param name="items">The items to format.</param>
        /// <returns>A string representation of the Common Lisp list, or "nil" if empty.</returns>
        private static string FormatLispList(IEnumerable<string> items) {
            if (items == null || !items.Any()) {
                return "nil";
            }
            return "(" + string.Join(" ", items.Select(EscapeLispString)) + ")";
        }

        /// <summary>
        ///   Converts a PascalCase or camelCase string to a Lisp kebab-case string.
        /// </summary>
        /// <param name="name">The PascalCase/camelCase string.</param>
        /// <returns>A kebab-case representation.</returns>
        public static string CamelCaseToKebabCase(string name) {
            if (string.IsNullOrEmpty(name)) {
                return string.Empty;
            }
            var sb = new StringBuilder();
            for (int i = 0; i < name.Length; i++) {
                char c = name[i];
                if (char.IsUpper(c)) {
                    if (i > 0 && name[i - 1] != '-' && (!char.IsUpper(name[i - 1]) || (i + 1 < name.Length && char.IsLower(name[i + 1])))) {
                        sb.Append('-');
                    }
                    sb.Append(char.ToLower(c));
                } else {
                    sb.Append(c);
                }
            }
            return sb.ToString();
        }

        /// <summary>
        ///   Determines the Common Lisp kind symbol of a type (e.g., :class, :struct, :interface, :enum, :delegate).
        /// </summary>
        /// <param name="type">The System.Type to analyze.</param>
        /// <returns>A string representation of the Lisp keyword kind.</returns>
        private static string GetTypeKind(Type type) {
            if (type.IsEnum) {
                return ":enum";
            }
            if (type.IsInterface) {
                return ":interface";
            }
            if (typeof(Delegate).IsAssignableFrom(type)) {
                return ":delegate";
            }
            if (type.IsValueType) {
                return ":struct";
            }
            return ":class";
        }

        /// <summary>
        ///   Evaluates standard boolean reflection flags for a type and formats them as a list of Lisp keywords.
        /// </summary>
        /// <param name="type">The System.Type to inspect.</param>
        /// <returns>A string representing the Lisp list of keywords, or "nil" if empty.</returns>
        private static string GetTypeFlags(Type type) {
            var flags = new List<string>();
            if (type.IsAbstract) {
                flags.Add(":" + CamelCaseToKebabCase("Abstract"));
            }
            if (type.IsSealed) {
                flags.Add(":" + CamelCaseToKebabCase("Sealed"));
            }
            if (type.IsImport) {
                flags.Add(":" + CamelCaseToKebabCase("Import"));
            }
            // We use '#pragma warning disable SYSLIB0050' because the 'Type.IsSerializable' property has been
            // marked obsolete starting in .NET 8.0 due to legacy formatter-based serialization being deprecated.
            // However, this metadata is still highly valuable for our Common Lisp integration to identify types that
            // support serialization (e.g. for object marshalling or deep copies). To achieve a clean, warning-free
            // build (0 warnings/errors) while still retrieving this property, we wrap the access in a pragma warning
            // disable/restore block. This disables warning SYSLIB0050 specifically for this expression, and immediately
            // restores it to prevent silencing any other deprecated API usage elsewhere in our code.
#pragma warning disable SYSLIB0050
            if (type.IsSerializable) {
                flags.Add(":" + CamelCaseToKebabCase("Serializable"));
            }
#pragma warning restore SYSLIB0050
            if (type.IsGenericType) {
                flags.Add(":" + CamelCaseToKebabCase("GenericType"));
            }
            if (type.IsGenericTypeDefinition) {
                flags.Add(":" + CamelCaseToKebabCase("GenericTypeDefinition"));
            }
            if (type.IsNested) {
                flags.Add(":" + CamelCaseToKebabCase("Nested"));
            }
            if (flags.Count == 0) {
                return "nil";
            }
            return "(" + string.Join(" ", flags) + ")";
        }

        /// <summary>
        ///   Formats the metadata of a property as a Common Lisp property plist string.
        ///   The plist contains the property name, type information, readability/writeability,
        ///   static modifier, accessor names, optional index parameters (for indexers, i.e.
        ///   C#'s this[...]), and optional XML documentation.
        /// </summary>
        /// <param name="prop">The property reflection metadata info.</param>
        /// <param name="xmlDoc">The dictionary of XML documentation elements mapped by member name.</param>
        /// <returns>A plist string representation of the property.</returns>
        private static string FormatPropertyPlist(PropertyInfo prop, Dictionary<string, XElement> xmlDoc) {
            var parts = new List<string>();
            parts.Add($":name {EscapeLispString(prop.Name)}");
            parts.Add(FormatTypeField(":type", prop.PropertyType));

            // Indexers (C#'s this[...]) carry index parameters on the property itself,
            // just like a method's parameters; capture them the same way so callers
            // (get_Item/set_Item) can be generated with the index argument(s) intact.
            var indexParameters = prop.GetIndexParameters();
            if (indexParameters.Length > 0) {
                var indexParamPlists = indexParameters.Select(p => FormatParameterPlist(p)).ToList();
                parts.Add($":parameters ({string.Join(" ", indexParamPlists)})");
            }

            var getMethod = prop.GetMethod;
            var setMethod = prop.SetMethod;

            bool isGetVisible = getMethod != null && (getMethod.IsPublic || getMethod.IsFamily || getMethod.IsFamilyOrAssembly);
            bool isSetVisible = setMethod != null && (setMethod.IsPublic || setMethod.IsFamily || setMethod.IsFamilyOrAssembly);

            if (isGetVisible) {
                parts.Add(":readable t");
            }
            if (isSetVisible) {
                parts.Add(":writeable t");
            }

            bool isStatic = (isGetVisible && getMethod!.IsStatic) || (isSetVisible && setMethod!.IsStatic);
            if (isStatic) {
                parts.Add(":static t");
            }

            if (isGetVisible) {
                parts.Add($":get-method {EscapeLispString(getMethod!.Name)}");
            }
            if (isSetVisible) {
                parts.Add($":set-method {EscapeLispString(setMethod!.Name)}");
            }

            // Phase 2D: Retrieve property documentation (moved to end of plist)
            string docKey = GetXmlDocMemberName(prop);
            if (xmlDoc.TryGetValue(docKey, out var memberElement)) {
                string docPlist = FormatDocumentationPlist(memberElement);
                if (docPlist != "nil") {
                    parts.Add($":documentation {docPlist}");
                }
            }

            return "(" + string.Join(" ", parts) + ")";
        }

        /// <summary>
        ///   Formats the metadata of an event as a Common Lisp event plist string. The plist
        ///   contains the event name, its delegate type (for documentation purposes only --
        ///   codegen does not need it, since dotnet:add-event resolves the delegate type from
        ///   the live EventInfo at runtime), the add_/remove_ accessor method names, and
        ///   optional XML documentation. Only instance events reach this function -- static
        ///   events are filtered out by the caller, since DotCL's dotnet:add-event/remove-event
        ///   have no documented/verified calling convention for a receiverless static event.
        /// </summary>
        /// <param name="evt">The event reflection metadata info.</param>
        /// <param name="xmlDoc">The dictionary of XML documentation elements mapped by member name.</param>
        /// <returns>A plist string representation of the event.</returns>
        private static string FormatEventPlist(EventInfo evt, Dictionary<string, XElement> xmlDoc) {
            var parts = new List<string>();
            parts.Add($":name {EscapeLispString(evt.Name)}");
            parts.Add(FormatTypeField(":type", evt.EventHandlerType!));
            parts.Add($":add-method {EscapeLispString(evt.AddMethod!.Name)}");
            parts.Add($":remove-method {EscapeLispString(evt.RemoveMethod!.Name)}");

            // Phase 2D: Retrieve event documentation (moved to end of plist)
            string docKey = GetXmlDocMemberName(evt);
            if (xmlDoc.TryGetValue(docKey, out var memberElement)) {
                string docPlist = FormatDocumentationPlist(memberElement);
                if (docPlist != "nil") {
                    parts.Add($":documentation {docPlist}");
                }
            }

            return "(" + string.Join(" ", parts) + ")";
        }

        /// <summary>
        ///   Formats the metadata of a field as a Common Lisp field plist string.
        ///   The plist contains the field name, type information, static/literal/init-only flags,
        ///   public visibility, and optional XML documentation.
        /// </summary>
        /// <param name="field">The field reflection metadata info.</param>
        /// <param name="xmlDoc">The dictionary of XML documentation elements mapped by member name.</param>
        /// <returns>A plist string representation of the field.</returns>
        private static string FormatFieldPlist(FieldInfo field, Dictionary<string, XElement> xmlDoc) {
            var parts = new List<string>();
            parts.Add($":name {EscapeLispString(field.Name)}");
            parts.Add(FormatTypeField(":type", field.FieldType));

            if (field.IsStatic) {
                parts.Add(":static t");
            }
            if (field.IsLiteral) {
                parts.Add(":literal t");
            }
            if (field.IsInitOnly) {
                parts.Add(":init-only t");
            }
            if (field.IsPublic) {
                parts.Add(":public t");
            }

            // Phase 2D: Retrieve field documentation (moved to end of plist)
            string docKey = GetXmlDocMemberName(field);
            if (xmlDoc.TryGetValue(docKey, out var memberElement)) {
                string docPlist = FormatDocumentationPlist(memberElement);
                if (docPlist != "nil") {
                    parts.Add($":documentation {docPlist}");
                }
            }

            return "(" + string.Join(" ", parts) + ")";
        }

        /// <summary>
        ///   Formats the metadata of a constructor as a Common Lisp constructor plist string.
        ///   The plist contains visibility details, parameter specifications, and optional XML documentation.
        /// </summary>
        /// <param name="ctor">The constructor reflection metadata info.</param>
        /// <param name="xmlDoc">The dictionary of XML documentation elements mapped by member name.</param>
        /// <returns>A plist string representation of the constructor.</returns>
        private static string FormatConstructorPlist(ConstructorInfo ctor, Dictionary<string, XElement> xmlDoc) {
            var parts = new List<string>();
            if (ctor.IsPublic) {
                parts.Add(":public t");
            } else if (ctor.IsFamily) {
                parts.Add(":protected t");
            } else if (ctor.IsFamilyOrAssembly) {
                parts.Add(":protected-internal t");
            }

            var parameters = ctor.GetParameters();
            if (parameters.Length > 0) {
                var paramPlists = parameters.Select(p => FormatParameterPlist(p)).ToList();
                parts.Add($":parameters ({string.Join(" ", paramPlists)})");
            }

            // Phase 2D: Retrieve constructor documentation (moved to end of plist)
            string docKey = GetXmlDocMemberName(ctor);
            if (xmlDoc.TryGetValue(docKey, out var memberElement)) {
                string docPlist = FormatDocumentationPlist(memberElement);
                if (docPlist != "nil") {
                    parts.Add($":documentation {docPlist}");
                }
            }

            return "(" + string.Join(" ", parts) + ")";
        }

        /// <summary>
        ///   Formats the metadata of a method as a Common Lisp method plist string.
        ///   The plist contains the method's clean and mangled names, static modifier, return type,
        ///   parameter lists, and optional XML documentation.
        /// </summary>
        /// <param name="method">The method reflection metadata info.</param>
        /// <param name="xmlDoc">The dictionary of XML documentation elements mapped by member name.</param>
        /// <returns>A plist string representation of the method.</returns>
        private static string FormatMethodPlist(MethodInfo method, Dictionary<string, XElement> xmlDoc) {
            var parts = new List<string>();
            string cleanName = GetCleanMethodName(method);
            parts.Add($":name {EscapeLispString(cleanName)}");

            if (method.Name != cleanName) {
                parts.Add($":mangled-name {EscapeLispString(method.Name)}");
            }

            if (method.IsGenericMethod) {
                parts.Add(":is-generic t");
                parts.Add($":generic-arity {method.GetGenericArguments().Length}");
            }

            if (method.IsStatic) {
                parts.Add(":is-static t");
            }

            bool isExtensionMethod = method.IsDefined(typeof(System.Runtime.CompilerServices.ExtensionAttribute), false);
            if (isExtensionMethod) {
                parts.Add(":extension-method t");
            }

            parts.Add(FormatTypeField(":return-type", method.ReturnType));

            var parameters = method.GetParameters();
            if (parameters.Length > 0) {
                var paramPlists = parameters.Select((p, i) => FormatParameterPlist(p, isExtensionMethod && i == 0)).ToList();
                parts.Add($":parameters ({string.Join(" ", paramPlists)})");
            }

            // Phase 2D: Retrieve method documentation (moved to end of plist)
            string docKey = GetXmlDocMemberName(method);
            if (xmlDoc.TryGetValue(docKey, out var memberElement)) {
                string docPlist = FormatDocumentationPlist(memberElement);
                if (docPlist != "nil") {
                    parts.Add($":documentation {docPlist}");
                }
            }

            return "(" + string.Join(" ", parts) + ")";
        }

        /// <summary>
        ///   Formats a parameter as a plist including name, type, and default value.
        /// </summary>
        /// <param name="param">The parameter info.</param>
        /// <param name="extensionThis">Whether this is the 'this' parameter of an extension method.</param>
        /// <returns>A plist string representation of the parameter.</returns>
        private static string FormatParameterPlist(ParameterInfo param, bool extensionThis = false) {
            var parts = new List<string>();
            parts.Add($":name {EscapeLispString(param.Name ?? "")}");
            parts.Add(FormatTypeField(":type", param.ParameterType));

            if (extensionThis) {
                parts.Add(":extension-this t");
            }

            if (param.IsOut) {
                parts.Add(":out t");
            } else if (param.ParameterType.IsByRef) {
                bool isReadOnly = param.CustomAttributes.Any(a => a.AttributeType.FullName == "System.Runtime.CompilerServices.IsReadOnlyAttribute");
                if (isReadOnly) {
                    parts.Add(":ref-readonly t");
                } else {
                    parts.Add(":ref t");
                }
            }

            if (param.CustomAttributes.Any(a => a.AttributeType.FullName == "System.Runtime.CompilerServices.ScopedRefAttribute")) {
                parts.Add(":scoped t");
            }

            if (param.IsDefined(typeof(ParamArrayAttribute), false)) {
                parts.Add(":params t");
            }

            if (param.HasDefaultValue) {
                parts.Add(":has-default t");
                parts.Add($":default-value {FormatDefaultValue(param.DefaultValue)}");
            }

            return "(" + string.Join(" ", parts) + ")";
        }

        /// <summary>
        ///   Formats a parameter's default value representation for Common Lisp.
        /// </summary>
        /// <param name="val">The default value object.</param>
        /// <returns>A formatted representation string.</returns>
        internal static string FormatDefaultValue(object? val) {
            // 1. Serialize null as nil
            if (val == null) {
                return "nil";
            }
            if (val is string s) {
                return EscapeLispString(s);
            }
            if (val is bool b) {
                return b ? "t" : "nil";
            }
            // 6. Format character as a Common Lisp character using DotCL's LispChar representation
            if (val is char c) {
                return DotCL.LispChar.Make(c).ToString();
            }

            // 3. Handle single-float format using DotCL's SingleFloat printer representation
            if (val is float f) {
                if (float.IsNaN(f) || float.IsInfinity(f)) {
                    return EscapeLispString(f.ToString());
                }
                string sFloat = new DotCL.SingleFloat(f).ToString();
                if (sFloat.StartsWith("#.SINGLE-FLOAT-")) {
                    return sFloat;
                }
                if (sFloat.Contains("E") || sFloat.Contains("e")) {
                    sFloat = sFloat.Replace("E", "f").Replace("e", "f").Replace("f+", "f");
                } else {
                    if (!sFloat.Contains(".")) {
                        sFloat += ".0";
                    }
                    sFloat += "f0";
                }
                return sFloat;
            }

            // 4. Handle double-float format using DotCL's DoubleFloat printer representation directly
            if (val is double d) {
                return new DotCL.DoubleFloat(d).ToString();
            }

            // 5. Handle decimal formats: integral values as integers, fractional as ratio literals (numerator/denominator)
            if (val is decimal dec) {
                if (dec % 1 == 0) {
                    return dec.ToString("0", System.Globalization.CultureInfo.InvariantCulture);
                }
                
                int[] bits = decimal.GetBits(dec);
                var low = (uint)bits[0];
                var mid = (uint)bits[1];
                var high = (uint)bits[2];
                var scale = (bits[3] >> 16) & 0x7F;
                bool isNegative = (bits[3] & 0x80000000) != 0;

                var numerator = new System.Numerics.BigInteger(low) 
                              | (new System.Numerics.BigInteger(mid) << 32) 
                              | (new System.Numerics.BigInteger(high) << 64);
                if (isNegative) {
                    numerator = -numerator;
                }
                var denominator = System.Numerics.BigInteger.Pow(10, scale);
                var gcd = System.Numerics.BigInteger.GreatestCommonDivisor(numerator, denominator);
                numerator /= gcd;
                denominator /= gcd;

                return $"{numerator}/{denominator}";
            }

            // 2. Handle integers
            if (val is int || val is uint || val is long || val is ulong || 
                val is short || val is ushort || val is byte || val is sbyte) {
                return val.ToString() ?? "0";
            }

            // Fallback for enums, structs, and any other types: serializing as escaped string
            return EscapeLispString(val.ToString() ?? "");
        }

        /// <summary>
        ///   Translates C# operator names into standard Lisp operator symbols, returning normal names unchanged.
        /// </summary>
        /// <param name="method">The method info to retrieve name for.</param>
        /// <returns>The clean method name string.</returns>
        private static string GetCleanMethodName(MethodInfo method) {
            string name = method.Name;
            if (name.StartsWith("op_")) {
                switch (name) {
                    case "op_Addition": return "+";
                    case "op_Subtraction": return "-";
                    case "op_Multiply": return "*";
                    case "op_Division": return "/";
                    case "op_Equality": return "=";
                    case "op_Inequality": return "not=";
                    case "op_LessThan": return "<";
                    case "op_GreaterThan": return ">";
                    case "op_LessThanOrEqual": return "<=";
                    case "op_GreaterThanOrEqual": return ">=";
                    case "op_UnaryPlus": return "+";
                    case "op_UnaryNegation": return "-";
                    case "op_LogicalNot": return "not";
                    case "op_Increment": return "1+";
                    case "op_Decrement": return "1-";
                    case "op_True": return "true";
                    case "op_False": return "false";
                    case "op_Implicit": return "implicit-cast";
                    case "op_Explicit": return "explicit-cast";
                    case "op_Modulus": return "%";
                    case "op_BitwiseAnd": return "&";
                    case "op_BitwiseOr": return "|";
                    case "op_ExclusiveOr": return "^";
                    case "op_LeftShift": return "<<";
                    case "op_RightShift": return ">>";
                    case "op_UnsignedRightShift": return ">>>";
                    case "op_OnesComplement": return "~";
                    case "op_CheckedAddition": return "+!";
                    case "op_CheckedSubtraction": return "-!";
                    case "op_CheckedMultiply": return "*!";
                    case "op_CheckedDivision": return "/!";
                    case "op_CheckedUnaryNegation": return "-!";
                    case "op_CheckedExplicit": return "explicit-cast!";
                }
            }
            return name;
        }

        /// <summary>
        ///   Gets a simplified CLR backtick name for a type, recursively formatting generic arguments.
        /// </summary>
        /// <param name="type">The type to format.</param>
        /// <returns>A simplified backtick type name string.</returns>
        private static string GetFriendlyTypeName(Type type) {
            if (type.IsGenericType) {
                string baseName = type.GetGenericTypeDefinition().FullName ?? type.GetGenericTypeDefinition().Name;
                var argNames = type.GetGenericArguments().Select(GetFriendlyTypeName);
                return $"{baseName}[{string.Join(", ", argNames)}]";
            }
            return type.FullName ?? type.Name;
        }

        /// <summary>
        ///   Programmatically determines if a type's FullName contains assembly qualifications by checking
        ///   recursively if the type or any of its components is a closed generic type.
        /// </summary>
        /// <param name="type">The type to check.</param>
        /// <returns>True if the type's FullName is assembly-qualified; otherwise, false.</returns>
        private static bool IsAssemblyQualified(Type type) {
            if (type.IsGenericType && !type.IsGenericTypeDefinition) {
                return true;
            }
            if (type.HasElementType) {
                return IsAssemblyQualified(type.GetElementType()!);
            }
            if (type.IsGenericType) {
                foreach (var arg in type.GetGenericArguments()) {
                    if (IsAssemblyQualified(arg)) {
                        return true;
                    }
                }
            }
            return false;
        }

        /// <summary>
        ///   Formats a type field key-value pair, appending the assembly-qualified sibling if the type is programmatically assembly-qualified.
        /// </summary>
        /// <param name="key">The plist key (e.g. :type or :return-type).</param>
        /// <param name="type">The type to format.</param>
        /// <returns>The formatted key-value pair strings.</returns>
        private static string FormatTypeField(string key, Type type) {
            string friendlyName = GetFriendlyTypeName(type);
            string result = $"{key} {EscapeLispString(friendlyName)}";

            if (IsAssemblyQualified(type) && type.AssemblyQualifiedName != null) {
                string aqKey = key == ":return-type" ? ":assembly-qualified-return-type" : ":assembly-qualified-type";
                result += $" {aqKey} {EscapeLispString(type.AssemblyQualifiedName)}";
            }
            return result;
        }

        /// <summary>
        ///   Loads and parses the XML documentation file into a dictionary of member elements.
        /// </summary>
        /// <param name="xmlPath">The path to the XML documentation file.</param>
        /// <returns>A dictionary mapping member names to their XML elements.</returns>
        private static Dictionary<string, XElement> LoadXmlDocumentation(string xmlPath) {
            var dict = new Dictionary<string, XElement>();
            if (!File.Exists(xmlPath)) {
                WriteLog($"[AssemblyToLispy] Warning: XML documentation file not found: {xmlPath}");
                return dict;
            }

            try {
                XDocument doc = XDocument.Load(xmlPath);
                var members = doc.Root?.Element("members")?.Elements("member");
                if (members != null) {
                    foreach (var member in members) {
                        string? nameAttr = member.Attribute("name")?.Value;
                        if (nameAttr != null) {
                            dict[nameAttr] = member;
                        }
                    }
                }
                WriteLog($"[AssemblyToLispy] Successfully loaded XML documentation: {xmlPath}");
            } catch (Exception ex) {
                WriteLog($"[AssemblyToLispy] Warning: Failed to parse XML documentation: {ex.Message}");
            }
            return dict;
        }

        /// <summary>
        ///   Computes the XML documentation member name for a given reflection member.
        /// </summary>
        /// <param name="member">The reflection member.</param>
        /// <returns>The XML documentation key string.</returns>
        private static string GetXmlDocMemberName(MemberInfo member) {
            if (member is Type t) {
                return "T:" + GetXmlDocTypeName(t);
            }
            if (member is FieldInfo f) {
                return "F:" + GetXmlDocTypeName(f.DeclaringType!) + "." + f.Name;
            }
            if (member is PropertyInfo p) {
                return "P:" + GetXmlDocTypeName(p.DeclaringType!) + "." + p.Name;
            }
            if (member is EventInfo ev) {
                return "E:" + GetXmlDocTypeName(ev.DeclaringType!) + "." + ev.Name;
            }
            if (member is ConstructorInfo c) {
                string baseName = "M:" + GetXmlDocTypeName(c.DeclaringType!) + ".#ctor";
                var parameters = c.GetParameters();
                if (parameters.Length > 0) {
                    var paramTypes = parameters.Select(p => GetXmlDocParameterTypeName(p.ParameterType)).ToArray();
                    return baseName + "(" + string.Join(",", paramTypes) + ")";
                }
                return baseName;
            }
            if (member is MethodInfo m) {
                string baseName = "M:" + GetXmlDocTypeName(m.DeclaringType!) + "." + m.Name;
                if (m.IsGenericMethod) {
                    baseName += "``" + m.GetGenericArguments().Length;
                }
                var parameters = m.GetParameters();
                if (parameters.Length > 0) {
                    var paramTypes = parameters.Select(p => GetXmlDocParameterTypeName(p.ParameterType)).ToArray();
                    return baseName + "(" + string.Join(",", paramTypes) + ")";
                }
                return baseName;
            }
            return "";
        }

        /// <summary>
        ///   Formats a type name for XML documentation keys, replacing inner class pluses with dots.
        /// </summary>
        /// <param name="type">The type to format.</param>
        /// <returns>A formatted type name string.</returns>
        private static string GetXmlDocTypeName(Type type) {
            string fullName = type.FullName ?? type.Name;
            return fullName.Replace('+', '.');
        }

        /// <summary>
        ///   Recursively formats a parameter type name for XML documentation keys.
        /// </summary>
        /// <param name="type">The parameter type.</param>
        /// <returns>A formatted type string.</returns>
        private static string GetXmlDocParameterTypeName(Type type) {
            if (type.IsGenericParameter) {
                if (type.DeclaringMethod != null) {
                    int index = Array.IndexOf(type.DeclaringMethod.GetGenericArguments(), type);
                    return "``" + index;
                } else {
                    int index = Array.IndexOf(type.DeclaringType!.GetGenericArguments(), type);
                    return "`" + index;
                }
            }

            if (type.HasElementType) {
                string elementTypeName = GetXmlDocParameterTypeName(type.GetElementType()!);
                if (type.IsArray) {
                    int rank = type.GetArrayRank();
                    string brackets = "[" + new string(',', rank - 1) + "]";
                    return elementTypeName + brackets;
                }
                if (type.IsByRef) {
                    return elementTypeName + "@";
                }
                if (type.IsPointer) {
                    return elementTypeName + "*";
                }
            }

            if (type.IsGenericType) {
                string baseName = type.GetGenericTypeDefinition().FullName ?? type.GetGenericTypeDefinition().Name;
                int backtickIndex = baseName.IndexOf('`');
                if (backtickIndex >= 0) {
                    baseName = baseName.Substring(0, backtickIndex);
                }
                baseName = baseName.Replace('+', '.');
                var argNames = type.GetGenericArguments().Select(GetXmlDocParameterTypeName);
                return $"{baseName}{{{string.Join(",", argNames)}}}";
            }

            string fullName = type.FullName ?? type.Name;
            return fullName.Replace('+', '.');
        }

        /// <summary>
        ///   Cleans and normalizes text from XML nodes, replacing inline see and paramref tags.
        /// </summary>
        /// <param name="xml">The raw XML inner text.</param>
        /// <returns>A cleaned and normalized text string.</returns>
        private static string CleanXmlText(string xml) {
            if (string.IsNullOrEmpty(xml)) {
                return string.Empty;
            }
            try {
                var element = XElement.Parse("<root>" + xml + "</root>");
                foreach (var see in element.Descendants("see").ToList()) {
                    string? cref = see.Attribute("cref")?.Value;
                    if (cref != null) {
                        int colonIdx = cref.IndexOf(':');
                        see.ReplaceWith(new XText(colonIdx >= 0 ? cref.Substring(colonIdx + 1) : cref));
                    }
                }
                foreach (var paramref in element.Descendants("paramref").ToList()) {
                    string? name = paramref.Attribute("name")?.Value;
                    if (name != null) {
                        paramref.ReplaceWith(new XText(name));
                    }
                }
                return System.Text.RegularExpressions.Regex.Replace(element.Value, @"\s+", " ").Trim();
            } catch {
                return System.Text.RegularExpressions.Regex.Replace(xml, @"\s+", " ").Trim();
            }
        }

        /// <summary>
        ///   Formats XML member node content into a Common Lisp documentation plist.
        /// </summary>
        /// <param name="memberElement">The XML member element.</param>
        /// <returns>A formatted documentation plist string, or "nil" if empty.</returns>
        private static string FormatDocumentationPlist(XElement memberElement) {
            var parts = new List<string>();

            // Extract summary node
            var summaryElement = memberElement.Element("summary");
            if (summaryElement != null) {
                string summaryRaw = summaryElement.Nodes().Aggregate("", (s, n) => s + n.ToString());
                string summaryClean = CleanXmlText(summaryRaw);
                if (!string.IsNullOrEmpty(summaryClean)) {
                    parts.Add($":summary {EscapeLispString(summaryClean)}");
                }
            }

            // Extract returns node
            var returnsElement = memberElement.Element("returns");
            if (returnsElement != null) {
                string returnsRaw = returnsElement.Nodes().Aggregate("", (s, n) => s + n.ToString());
                string returnsClean = CleanXmlText(returnsRaw);
                if (!string.IsNullOrEmpty(returnsClean)) {
                    parts.Add($":returns {EscapeLispString(returnsClean)}");
                }
            }

            // Extract parameter descriptions
            var paramsElements = memberElement.Elements("param").ToList();
            if (paramsElements.Any()) {
                var paramPlists = new List<string>();
                foreach (var p in paramsElements) {
                    string? name = p.Attribute("name")?.Value;
                    string desc = CleanXmlText(p.Nodes().Aggregate("", (s, n) => s + n.ToString()));
                    if (!string.IsNullOrEmpty(name)) {
                        paramPlists.Add($"(:name {EscapeLispString(name)} :description {EscapeLispString(desc)})");
                    }
                }
                if (paramPlists.Any()) {
                    parts.Add($":parameters ({string.Join(" ", paramPlists)})");
                }
            }

            if (parts.Count == 0) {
                return "nil";
            }
            return "(" + string.Join(" ", parts) + ")";
        }

        /// <summary>
        ///   Gets or sets a value indicating whether diagnostic logs should be redirected to standard error.
        ///   This is useful when standard output is used for the metadata payload.
        /// </summary>
        public static bool RedirectLogsToError { get; set; }

        /// <summary>
        ///   Writes a log message to either standard output or standard error depending on RedirectLogsToError.
        /// </summary>
        /// <param name="message">The log message to write.</param>
        private static void WriteLog(string message) {
            if (RedirectLogsToError) {
                Console.Error.WriteLine(message);
            } else {
                Console.WriteLine(message);
            }
        }
    }

    /// <summary>
    ///   Contains test suites for verifying the correctness of the AssemblyToLispy generator.
    /// </summary>
    public static class AssemblyToLispyTest {

        // FIXME: Have the system tell us where these are somehow?
        // This is for Arch Linux
        // Ubuntu is at: /usr/lib/dotnet/packs/Microsoft.NETCore.App.Ref/10.0.9/ref/net10.0/
        public const string AssemblyDirectory = "/usr/share/dotnet/packs/Microsoft.NETCore.App.Ref/10.0.9/ref/net10.0/";

        /// <summary>
        ///   Runs the AssemblyToLispy test case on System.Runtime.dll and validates the generated plist data.
        /// </summary>
        /// <exception cref="Exception">Thrown when a test assertion fails.</exception>
        public static void RunTests() {
            try {
                // Test the system runtime assembly
                RunTestOnAssembly(AssemblyDirectory, "System.Runtime.dll");

                // Test the system console assembly
                RunTestOnAssembly(AssemblyDirectory, "System.Console.dll");

                // Test our synthetic edge cases target.
                // The built DLL will reside in the output folder alongside the generator executable
                RunTestOnAssembly(AppDomain.CurrentDomain.BaseDirectory, "AssemblyToLispyTestTarget.dll");

                // Test the DotCL runtime assembly
                RunTestOnAssembly(AppDomain.CurrentDomain.BaseDirectory, "DotCL.Runtime.dll");

                // Verify FormatDefaultValue behavior directly for different Common Lisp types
                AssertDefaultValue(null, "nil");
                AssertDefaultValue("hello", "\"hello\"");
                AssertDefaultValue(true, "t");
                AssertDefaultValue(false, "nil");
                AssertDefaultValue('A', "#\\LATIN CAPITAL LETTER A");
                AssertDefaultValue(' ', "#\\Space");
                AssertDefaultValue('\n', "#\\Newline");
                AssertDefaultValue(123, "123");
                AssertDefaultValue(-45L, "-45");
                AssertDefaultValue(1.5f, "1.5f0");
                AssertDefaultValue(1.23E-4f, "0.000123f0");
                AssertDefaultValue(1.5d, "1.5d0");
                AssertDefaultValue(1.23E-4d, "0.000123d0");
                AssertDefaultValue(123.0m, "123");
                AssertDefaultValue(1.25m, "5/4");
                AssertDefaultValue(-0.05m, "-1/20");
                AssertDefaultValue(System.IO.FileMode.Create, "\"Create\""); // Enum fallback

                Console.WriteLine("[AssemblyToLispyTest] All tests PASSED successfully!");

            } catch (Exception ex) {
                Console.Error.WriteLine($"[AssemblyToLispyTest] TEST FAILED: {ex.Message}");
                Console.Error.WriteLine(ex.StackTrace);
                throw;
            }
        }

        private static void RunTestOnAssembly(string inputDir, string assemblyName) {
            string tempOutputFile = Path.Combine(Path.GetTempPath(), $"{assemblyName}.lispy.metadata.tmp");

            try {
                Console.WriteLine($"[AssemblyToLispyTest] Starting test run on {assemblyName}...");
                AssemblyToLispy.GenerateLispyMetadata(inputDir, assemblyName, tempOutputFile);

                if (!File.Exists(tempOutputFile)) {
                    throw new Exception($"Test failed: Output file was not created at {tempOutputFile}");
                }

                // Verify that the file does not begin with a UTF-8 Byte Order Mark (BOM)
                byte[] fileBytes = File.ReadAllBytes(tempOutputFile);
                if (fileBytes.Length >= 3 && fileBytes[0] == 0xEF && fileBytes[1] == 0xBB && fileBytes[2] == 0xBF) {
                    throw new Exception("Test failed: Output file starts with a UTF-8 Byte Order Mark (BOM).");
                }

                string content = File.ReadAllText(tempOutputFile);

                // Execute the Lisp-native test suite
                Console.WriteLine($"[AssemblyToLispyTest] Executing Lisp-native test suite for {assemblyName}...");
                string testsDir = Path.GetFullPath("tests");
                string frameworkFile = Path.Combine(testsDir, "framework.lisp");

                string lispLoadFramework = $"(load \"{frameworkFile.Replace("\\", "/")}\")";
                DotCL.DotclHost.EvalString(lispLoadFramework);

                // Discover all *.test.lisp files and load them into the environment
                string[] testFiles = Directory.GetFiles(testsDir, "*.test.lisp");
                foreach (string testFile in testFiles) {
                    string lispLoadTest = $"(load \"{testFile.Replace("\\", "/")}\")";
                    DotCL.DotclHost.EvalString(lispLoadTest);
                }

                object result = DotCL.DotclHost.Call("RUN-ALL-ASSEMBLY-TESTS", tempOutputFile, assemblyName);

                bool success = false;
                if (result is bool b) {
                    success = b;
                } else if (result != null) {
                    string resStr = result.ToString() ?? "";
                    if (resStr.Equals("T", StringComparison.OrdinalIgnoreCase)) {
                        success = true;
                    }
                }

                if (!success) {
                    throw new Exception($"Test failed: Lisp-native test suite reported failures for {assemblyName}.");
                }

            } finally {
                if (File.Exists(tempOutputFile)) {
                    Console.WriteLine($"[AssemblyToLispyTest] Test output file: {tempOutputFile}");
                    // File.Delete(tempOutputFile);
                }
            }
        }

        /// <summary>
        ///   Asserts that the formatted default value of an object matches the expected Lisp literal representation.
        /// </summary>
        /// <param name="value">The raw default value object.</param>
        /// <param name="expected">The expected Lisp literal string representation.</param>
        /// <exception cref="Exception">Thrown when the formatting does not match the expected value.</exception>
        private static void AssertDefaultValue(object? value, string expected) {
            string actual = AssemblyToLispy.FormatDefaultValue(value);
            if (actual != expected) {
                throw new Exception($"FormatDefaultValue assertion failed. Value: {value ?? "null"}, Expected: {expected}, Actual: {actual}");
            }
        }
    }
}
