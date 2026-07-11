// Copyright 2026 Douglas P. Fields, Jr.
//
// This is the standalone package-generator entry point. It exposes a
// single-pass assembly-metadata-plus-package generator (one or more
// assemblies, each with zero or more classes, in one invocation) plus its
// test mode.

using System.Text;
using DotCL;
using PackageGenerator;

const string AsdFileName = "dotcl-packagegen.asd";
const string SystemName = "dotcl-packagegen";
const string UtilsPackageTemplateFileName = "csharp-assembly-utils-package.template.lisp";
const string UtilsTemplateFileName = "csharp-assembly-utils.template.lisp";

var isTestMode = false;
var printHelp = false;
var printVersion = false;

string? outDir = null;
var groups = new List<AssemblyGroup>();
AssemblyGroup? currentGroup = null;
ClassSpec? currentClass = null;
var argErrors = new List<string>();
bool exportAllParents = false;
bool exportAllInterfaces = false;
bool exportAllObject = false;
bool outputAllNested = false;
bool outputAllChildren = false;
bool outputAllImplementations = false;
bool skipMissing = false;
bool enableDefgenericStatic = false;
bool enableExtensionMethods = true;
bool ensureType = false;

////////////////////////////////////////////////////////////////////////////
// Parse arguments

if (args.Contains("--help")) {
    printHelp = true;
}

if (args.Contains("--version")) {
    printVersion = true;
}

for (int i = 0; i < args.Length; i++) {
    if (args[i] == "--out-dir" && i + 1 < args.Length) {
        outDir = args[i + 1];
        i++;
    } else if (args[i] == "--assembly" && i + 1 < args.Length) {
        currentGroup = new AssemblyGroup { DllPath = args[i + 1] };
        groups.Add(currentGroup);
        currentClass = null;
        i++;
    } else if (args[i] == "--class" && i + 1 < args.Length) {
        if (currentGroup == null) {
            argErrors.Add("--class specified before any --assembly.");
        } else {
            currentClass = new ClassSpec {
                Name = args[i + 1],
                ExportParents = exportAllParents,
                ExportInterfaces = exportAllInterfaces,
                ExportObject = exportAllObject,
                OutputNested = outputAllNested,
                OutputChildren = outputAllChildren,
                OutputImplementations = outputAllImplementations,
                DefGenericStatic = enableDefgenericStatic,
                ExtensionMethods = enableExtensionMethods,
                EnsureType = ensureType,
            };
            currentGroup.Classes.Add(currentClass);
        }
        i++;
    } else if (args[i] == "--constant-properties" && i + 1 < args.Length) {
        if (currentClass == null) {
            argErrors.Add("--constant-properties specified before any --class.");
        } else {
            currentClass.ConstantProperties = args[i + 1];
        }
        i++;
    } else if (args[i] == "--export-parents") {
        if (currentClass == null) {
            argErrors.Add("--export-parents specified before any --class.");
        } else {
            currentClass.ExportParents = true;
        }
    } else if (args[i] == "--no-export-parents") {
        if (currentClass == null) {
            argErrors.Add("--no-export-parents specified before any --class.");
        } else {
            currentClass.ExportParents = false;
        }
    } else if (args[i] == "--export-interfaces") {
        if (currentClass == null) {
            argErrors.Add("--export-interfaces specified before any --class.");
        } else {
            currentClass.ExportInterfaces = true;
        }
    } else if (args[i] == "--no-export-interfaces") {
        if (currentClass == null) {
            argErrors.Add("--no-export-interfaces specified before any --class.");
        } else {
            currentClass.ExportInterfaces = false;
        }
    } else if (args[i] == "--export-object") {
        if (currentClass == null) {
            argErrors.Add("--export-object specified before any --class.");
        } else {
            currentClass.ExportObject = true;
        }
    } else if (args[i] == "--no-export-object") {
        if (currentClass == null) {
            argErrors.Add("--no-export-object specified before any --class.");
        } else {
            currentClass.ExportObject = false;
        }
    } else if (args[i] == "--output-nested") {
        if (currentClass == null) {
            argErrors.Add("--output-nested specified before any --class.");
        } else {
            currentClass.OutputNested = true;
        }
    } else if (args[i] == "--no-output-nested") {
        if (currentClass == null) {
            argErrors.Add("--no-output-nested specified before any --class.");
        } else {
            currentClass.OutputNested = false;
        }
    } else if (args[i] == "--output-children") {
        if (currentClass == null) {
            argErrors.Add("--output-children specified before any --class.");
        } else {
            currentClass.OutputChildren = true;
        }
    } else if (args[i] == "--no-output-children") {
        if (currentClass == null) {
            argErrors.Add("--no-output-children specified before any --class.");
        } else {
            currentClass.OutputChildren = false;
        }
    } else if (args[i] == "--output-implementations") {
        if (currentClass == null) {
            argErrors.Add("--output-implementations specified before any --class.");
        } else {
            currentClass.OutputImplementations = true;
        }
    } else if (args[i] == "--no-output-implementations") {
        if (currentClass == null) {
            argErrors.Add("--no-output-implementations specified before any --class.");
        } else {
            currentClass.OutputImplementations = false;
        }
    } else if (args[i] == "--defgeneric") {
        if (currentClass == null) {
            argErrors.Add("--defgeneric specified before any --class.");
        } else {
            currentClass.DefGenericStatic = true;
        }
    } else if (args[i] == "--no-defgeneric") {
        if (currentClass == null) {
            argErrors.Add("--no-defgeneric specified before any --class.");
        } else {
            currentClass.DefGenericStatic = false;
        }
    } else if (args[i] == "--extension-methods") {
        if (currentClass == null) {
            argErrors.Add("--extension-methods specified before any --class.");
        } else {
            currentClass.ExtensionMethods = true;
        }
    } else if (args[i] == "--no-extension-methods") {
        if (currentClass == null) {
            argErrors.Add("--no-extension-methods specified before any --class.");
        } else {
            currentClass.ExtensionMethods = false;
        }
    } else if (args[i] == "--export-all-parents") {
        exportAllParents = true;
    } else if (args[i] == "--no-export-all-parents") {
        exportAllParents = false;
    } else if (args[i] == "--export-all-interfaces") {
        exportAllInterfaces = true;
    } else if (args[i] == "--no-export-all-interfaces") {
        exportAllInterfaces = false;
    } else if (args[i] == "--export-all-object") {
        exportAllObject = true;
    } else if (args[i] == "--no-export-all-object") {
        exportAllObject = false;
    } else if (args[i] == "--output-all-nested") {
        outputAllNested = true;
    } else if (args[i] == "--no-output-all-nested") {
        outputAllNested = false;
    } else if (args[i] == "--output-all-children") {
        outputAllChildren = true;
    } else if (args[i] == "--no-output-all-children") {
        outputAllChildren = false;
    } else if (args[i] == "--output-all-implementations") {
        outputAllImplementations = true;
    } else if (args[i] == "--no-output-all-implementations") {
        outputAllImplementations = false;
    } else if (args[i] == "--skip-missing") {
        skipMissing = true;
    } else if (args[i] == "--no-skip-missing") {
        skipMissing = false;
    } else if (args[i] == "--enable-defgeneric") {
        enableDefgenericStatic = true;
    } else if (args[i] == "--no-enable-defgeneric") {
        enableDefgenericStatic = false;
    } else if (args[i] == "--enable-extension-methods") {
        enableExtensionMethods = true;
    } else if (args[i] == "--no-enable-extension-methods") {
        enableExtensionMethods = false;
    } else if (args[i] == "--ensure-type") {
        ensureType = true;
    } else if (args[i] == "--no-ensure-type") {
        ensureType = false;
    } else if (args[i] == "--test") {
        isTestMode = true;
    }
}

//////////////////////////////////////////////////////////////////////////
// Handle all the run modes

if (printHelp) {
    PrintHelp();
    return;
}

// FIRST: the single-pass generator. Stage 1 (metadata reflection) needs no
// DotCL, so it all happens before DotclHost.Initialize() runs below.

if (!isTestMode && !printVersion && (outDir != null || groups.Count > 0 || argErrors.Count > 0)) {
    if (argErrors.Count > 0) {
        foreach (var msg in argErrors) {
            WriteRed(msg);
        }
        Environment.Exit(1);
    }

    if (string.IsNullOrEmpty(outDir)) {
        WriteRed("Error: --out-dir is required.");
        Environment.Exit(1);
    }

    if (groups.Count == 0) {
        WriteRed("Error: at least one --assembly is required.");
        Environment.Exit(1);
    }

    var missing = groups
        .Select(g => Path.GetFullPath(g.DllPath))
        .Where(p => !File.Exists(p))
        .ToList();
    if (missing.Count > 0) {
        foreach (var m in missing) {
            WriteRed($"Error: Assembly file not found: {m}");
        }
        Environment.Exit(1);
    }

    Directory.CreateDirectory(outDir);

    string creationTime = DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ssZ");
    var manifest = new StringBuilder();
    manifest.Append('(');

    try {
        foreach (var group in groups) {
            string fullAssemblyPath = Path.GetFullPath(group.DllPath);
            string inputDir = Path.GetDirectoryName(fullAssemblyPath) ?? Directory.GetCurrentDirectory();
            string inputAssemblyFile = Path.GetFileName(fullAssemblyPath);
            string assemblyBaseName = Path.GetFileNameWithoutExtension(inputAssemblyFile);
            string metadataFilePath = Path.Combine(outDir, assemblyBaseName + ".lispy.metadata");

            Console.Error.WriteLine($"[Program.cs] Generating assembly metadata for {inputAssemblyFile}...");
            AssemblyToLispy.GenerateLispyMetadata(inputDir, inputAssemblyFile, metadataFilePath);

            manifest.Append("(:metadata-file \"").Append(EscapeLispString(metadataFilePath)).Append("\"\n");
            manifest.Append(" :assembly-name \"").Append(EscapeLispString(inputAssemblyFile)).Append("\"\n");
            manifest.Append(" :classes (");
            foreach (var cls in group.Classes) {
                manifest.Append("(:name \"").Append(EscapeLispString(cls.Name)).Append('"');
                manifest.Append(" :constant-properties \"").Append(EscapeLispString(cls.ConstantProperties)).Append('"');
                manifest.Append(" :export-parents ").Append(cls.ExportParents ? "t" : "nil");
                manifest.Append(" :export-interfaces ").Append(cls.ExportInterfaces ? "t" : "nil");
                manifest.Append(" :export-object ").Append(cls.ExportObject ? "t" : "nil");
                manifest.Append(" :output-nested ").Append(cls.OutputNested ? "t" : "nil");
                manifest.Append(" :output-children ").Append(cls.OutputChildren ? "t" : "nil");
                manifest.Append(" :output-implementations ").Append(cls.OutputImplementations ? "t" : "nil");
                manifest.Append(" :defgeneric ").Append(cls.DefGenericStatic ? "t" : "nil");
                manifest.Append(" :extension-methods ").Append(cls.ExtensionMethods ? "t" : "nil");
                manifest.Append(" :ensure-type ").Append(cls.EnsureType ? "t" : "nil");
                manifest.Append(')');
            }
            manifest.Append("))\n");
        }
    } catch (Exception ex) {
        WriteRed($"Error generating metadata: {ex.Message}");
        Console.Error.WriteLine(ex.StackTrace);
        Environment.Exit(1);
    }

    manifest.Append(')');

    string manifestFile = Path.GetTempFileName();
    try {
        File.WriteAllText(manifestFile, manifest.ToString());

        DotclHost.Initialize();
        LoadDotclManifest();

        string asdPath = Path.Combine(AppContext.BaseDirectory, AsdFileName);
        string cliVersion = DotclHost.ToClr<string>(
            DotclHost.Call("GET-SYSTEM-VERSION", asdPath, SystemName));
        string utilsPackageTemplatePath = Path.Combine(AppContext.BaseDirectory, UtilsPackageTemplateFileName);
        string utilsTemplatePath = Path.Combine(AppContext.BaseDirectory, UtilsTemplateFileName);

        Console.WriteLine("[Program.cs] Running assembly package generator...");
        try {
            DotclHost.Call("RUN-ASSEMBLY-PACKAGE-GENERATOR-BATCH", manifestFile, outDir, creationTime, cliVersion,
                            utilsPackageTemplatePath, utilsTemplatePath, skipMissing);
        } catch (Exception ex) {
            Console.Error.WriteLine($"[Program.cs] Error in assembly package generator: {ex.Message}");
            Console.Error.WriteLine(ex.StackTrace);
            Environment.Exit(1);
        }
        Console.WriteLine("[Program.cs] ...assembly package generator complete.");
    } finally {
        File.Delete(manifestFile);
    }

    return;
}

// NEXT: Program invocations that require DotCL to be running

DotclHost.Initialize();
LoadDotclManifest();

if (printVersion) {
    PrintVersion();
    return;
}

//////////////////////////////////////////////////////////////////////////////
// Tests

if (isTestMode) {
    Console.WriteLine($"[Program.cs] Running Lisp generator tests...");
    DotclHost.Call("RUN-GENERATOR-TESTS");

    Console.WriteLine($"[Program.cs] Running assembly-to-lispy tests...");
    PackageGenerator.AssemblyToLispyTest.RunTests();

    Console.WriteLine($"[Program.cs] Done.");
    return;
}

Console.Error.WriteLine("[Program.cs] No action specified. Run with --help to see options.");
Environment.Exit(1);

//////////////////////////////////////////////////////////////////////////////
// Helpers

void LoadDotclManifest() {
    // FIXME: This seems awfully fragile. Is there some way we can make these come in
    // from the build process?
    var manifestPath = Path.Combine(
        AppContext.BaseDirectory, "dotcl-fasl", "dotcl-deps.txt");
    Console.WriteLine($"[Program.cs] manifest: {manifestPath}");
    var loaded = DotclHost.LoadFromManifest(manifestPath);
    Console.WriteLine($"[Program.cs] LoadFromManifest loaded {loaded} fasls");
}

void WriteRed(string message) {
    Console.Error.WriteLine($"\x1b[31m{message}\x1b[0m");
}

string EscapeLispString(string str) {
    var sb = new StringBuilder();
    foreach (char c in str) {
        if (c == '"' || c == '\\') {
            sb.Append('\\');
        }
        sb.Append(c);
    }
    return sb.ToString();
}

//////////////////////////////////////////////////////////////////////////////
// --version / --help

// Boots DotCL and calls into Lisp (utils:print-system-version) to load
// dotcl-packagegen.asd via ASDF's own asdf:load-asd and report its version,
// description, author, and license through ASDF's system introspection API
// (asdf:component-version, asdf:system-author, asdf:system-license, etc.)
// rather than parsing the .asd file by hand. This is the canonical version
// source per BUILD.md, so it can never drift from the system definition.
void PrintVersion() {
    string asdPath = Path.Combine(AppContext.BaseDirectory, AsdFileName);
    DotclHost.Call("PRINT-SYSTEM-VERSION", asdPath, SystemName);
}

void PrintHelp() {
    // Column where option descriptions start; computed rather than
    // hand-aligned so it stays correct regardless of flag name length.
    const int descColumn = 33;

    void Opt(string flag, params string[] descLines) {
        string pad = new string(' ', Math.Max(1, descColumn - 2 - flag.Length));
        Console.WriteLine($"  {flag}{pad}{descLines[0]}");
        for (int i = 1; i < descLines.Length; i++) {
            Console.WriteLine(new string(' ', descColumn) + descLines[i]);
        }
    }

    Console.WriteLine("Usage: dotcl-packagegen --out-dir <dir> --assembly <path> [--class <name>");
    Console.WriteLine("           [--constant-properties <spec>]]... [--assembly <path> ...]...");
    Console.WriteLine();
    Console.WriteLine("Single-pass generator: reflects one or more .NET assemblies and generates");
    Console.WriteLine("Lisp package(s) for the requested classes, all in one invocation.");
    Console.WriteLine();
    Opt("--out-dir <dir>", "Destination directory for generated metadata and .lisp",
        "package file(s).");
    Opt("--assembly <path>", "A .NET assembly to reflect. Repeatable; starts a new",
        "group that subsequent --class options attach to. An",
        "--assembly with no --class options still emits its",
        "metadata file, generating no packages.");
    Opt("--class <name>", "Fully-qualified C# class name to generate a Lisp",
        "package for, in the most recently given --assembly.",
        "Repeatable.");
    Opt("--constant-properties <spec>", "Comma/semicolon-separated static property names",
        "(or \"*\" for all) to emit as Lisp constants instead",
        "of re-evaluated accessors, for the most recently given",
        "--class.");
    Console.WriteLine();
    Console.WriteLine("Parents, interfaces, and related-class discovery (per-class, attach to the most");
    Console.WriteLine("recently given --class); each has a --no- counterpart that turns it back off for");
    Console.WriteLine("just that one class, overriding a --export-all-*/--output-all-* sticky default in");
    Console.WriteLine("effect (see below). A class discovered via any of these flags carries the");
    Console.WriteLine("discovering class's own complete flag set (all --export-*/--output-*/--defgeneric*/");
    Console.WriteLine("--extension-methods flags) and is itself processed the same way, so discovery/");
    Console.WriteLine("re-export cascades recursively through the whole connected component:");
    Opt("--export-parents / --no-export-parents", "Also generate packages for, and re-export",
        "non-conflicting members from, every super-class",
        "of the most recently given --class (excluding",
        "System.Object unless --export-object is also given).");
    Opt("--export-interfaces / --no-export-interfaces", "Also generate packages for, and re-export",
        "non-conflicting members from, every interface",
        "implemented by the most recently given --class.");
    Opt("--export-object / --no-export-object", "When combined with --export-parents, also",
        "generate a package for, and re-export from,",
        "System.Object.");
    Opt("--output-nested / --no-output-nested", "Also generate packages for every type nested",
        "inside the most recently given --class (and,",
        "recursively, types nested inside those). Unlike",
        "--export-parents/--export-interfaces, discovered",
        "types are only added to the batch as their own",
        "packages -- nothing is re-exported into this",
        "class's own package.");
    Opt("--output-children / --no-output-children", "Also generate packages for every direct and",
        "indirect subclass of the most recently given",
        "--class found in any provided assembly. Generate-",
        "only, like --output-nested -- never re-exported",
        "into this class's own package. Can pull in a very",
        "large number of types from a widely-derived base",
        "class; a warning is printed if the total discovered",
        "class count is large.");
    Opt("--output-implementations / --no-output-implementations", "Also generate packages for every type",
        "(found in any provided assembly) that implements",
        "the most recently given --class, if it is an",
        "interface. Generate-only, like --output-nested.");
    Opt("--defgeneric / --no-defgeneric", "Also contribute the most recently given",
        "--class's instance methods and instance",
        "property/field accessors to the shared",
        "CSHARP-GENERICS package of unified CLOS generic",
        "functions, each specializing on",
        "#.(dotnet:class-for-type ...) (requires DotCL",
        ">= 0.1.17) -- resolved by fully-qualified name",
        "at read time, so no naming-collision caveat",
        "applies. A generic-arity class (e.g.",
        "Dictionary`2) is skipped with a comment instead:",
        "DotCL cannot yet dispatch on an open generic",
        "type. See doc/make-everything-defgeneric.md and",
        "doc/dispatch-on-open-generics.md.");
    Opt("--extension-methods / --no-extension-methods", "Inject C# extension methods (found anywhere in",
        "the provided assemblies) whose 'this' parameter",
        "type is exactly the most recently given --class",
        "into that class's own package, as ordinary obj!-",
        "first instance-style wrappers. Only an exact,",
        "concrete 'this' type match is supported (no base-",
        "class/interface/open-generic matching); an",
        "overloaded, dirty (ref/out/params/default), or",
        "generic extension method is skipped with a",
        "comment instead. ON by default.");
    Console.WriteLine();
    Console.WriteLine("Sticky defaults (change the default for the current and every subsequent --class,");
    Console.WriteLine("in command-line order; a class's own --export-*/--output-*/--no-export-*/");
    Console.WriteLine("--no-output-*/--defgeneric* flags above always override these, for that one");
    Console.WriteLine("class only -- except --ensure-type/--no-ensure-type, which has no dedicated");
    Console.WriteLine("per-class override and applies directly, like the others below it):");
    Opt("--export-all-parents / --no-export-all-parents", "Default --export-parents on/off.");
    Opt("--export-all-interfaces / --no-export-all-interfaces", "Default --export-interfaces on/off.");
    Opt("--export-all-object / --no-export-all-object", "Default --export-object on/off.");
    Opt("--output-all-nested / --no-output-all-nested", "Default --output-nested on/off.");
    Opt("--output-all-children / --no-output-all-children", "Default --output-children on/off.");
    Opt("--output-all-implementations / --no-output-all-implementations", "Default --output-implementations on/off.");
    Opt("--enable-defgeneric / --no-enable-defgeneric", "Default --defgeneric on/off.");
    Opt("--enable-extension-methods / --no-enable-extension-methods", "Default --extension-methods on/off.",
        "Defaults to ON (unlike the other sticky flags",
        "above), so extension-method injection happens",
        "for every --class unless disabled.");
    Opt("--ensure-type / --no-ensure-type", "Emit the per-class 'Register C# Type with",
        "CLOS' eval-when (EnsureDotNetTypeClass) for the",
        "current and every subsequent --class, so a",
        "same-simple-name collision's generation-time",
        "load order deterministically decides which type",
        "keeps the friendly dotcl-internal::|Name| CLOS",
        "class symbol (see doc/generator-design-notes.md's",
        "\".NET CLOS Integration\" section). No dedicated",
        "per-class override exists for this one -- unlike",
        "the flags above, it applies directly to the",
        "current and all following classes. OFF by default:",
        "class-of/typep/dotnet:class-for-type already",
        "register a type's CLOS class lazily on first real",
        "need, so this is unnecessary for anything this",
        "generator itself emits (including --defgeneric,",
        "which dispatches via class-for-type on the exact",
        "fully-qualified name, immune to the naming race",
        "entirely); it only matters for hand-written code",
        "that dispatches on a generated type's simple-name",
        "CLOS symbol directly.");
    Console.WriteLine();
    Console.WriteLine("Global:");
    Opt("--skip-missing / --no-skip-missing", "When a requested parent/interface ancestor",
        "cannot be found in any provided assembly, warn",
        "and drop it (--skip-missing) instead of the",
        "default: stop with an error (--no-skip-missing).");
    Console.WriteLine();
    Console.WriteLine("Other:");
    Opt("--test", "Run the generator's own Lisp unit tests plus the",
        "AssemblyToLispy metadata test suite.");
    Opt("--version", "Show version, author, license, and copyright",
        "information (read from dotcl-packagegen.asd).");
    Opt("--help", "Show this help message.");
    Console.WriteLine();
    Console.WriteLine("Example:");
    Console.WriteLine("  dotcl-packagegen --out-dir ./cspackages \\");
    Console.WriteLine("      --assembly Some.Assembly.dll \\");
    Console.WriteLine("        --class Some.Class1 --constant-properties \"*\" \\");
    Console.WriteLine("        --class Some.Class2 \\");
    Console.WriteLine("      --assembly Some.Other.Assembly.dll \\");
    Console.WriteLine("        --class Some.Other.Class3 --constant-properties \"*\"");
}

class AssemblyGroup {
    public required string DllPath;
    public List<ClassSpec> Classes = new();
}

class ClassSpec {
    public required string Name;
    public string ConstantProperties = "";
    public bool ExportParents;
    public bool ExportInterfaces;
    public bool ExportObject;
    public bool OutputNested;
    public bool OutputChildren;
    public bool OutputImplementations;
    public bool DefGenericStatic;
    public bool ExtensionMethods;
    public bool EnsureType;
}
