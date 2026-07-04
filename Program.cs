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
            currentClass = new ClassSpec { Name = args[i + 1] };
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
                manifest.Append(" :constant-properties \"").Append(EscapeLispString(cls.ConstantProperties)).Append("\")");
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
                            utilsPackageTemplatePath, utilsTemplatePath);
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
}
