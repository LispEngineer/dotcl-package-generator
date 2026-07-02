// Copyright 2026 Douglas P. Fields, Jr.
//
// This is the standalone package-generator entry point
// It exposes only two-stage assembly-to-Lisp
// package generator plus its test mode.

using DotCL;
using PackageGenerator;

const string AsdFileName = "dotcl-packagegen.asd";
const string SystemName = "dotcl-packagegen";

string? assemblyFile = null;
string? outputFile = null;
bool hasAssembly = false;
bool hasOutput = false;

string? assemblyMetadataFile = null;
string? classFilter = null;
string? outputDir = null;
bool hasAssemblyMetadata = false;
string? constantProperties = null;
var isTestMode = false;
var printHelp = false;
var printVersion = false;

////////////////////////////////////////////////////////////////////////////
// Parse arguments

if (args.Contains("--help")) {
    printHelp = true;
}

if (args.Contains("--version")) {
    printVersion = true;
}

for (int i = 0; i < args.Length; i++) {
    if (args[i] == "--assembly" && i + 1 < args.Length) {
        assemblyFile = args[i + 1];
        hasAssembly = true;
        i++;
    } else if (args[i] == "--assembly-metadata" && i + 1 < args.Length) {
        assemblyMetadataFile = args[i + 1];
        hasAssemblyMetadata = true;
        i++;
    } else if (args[i] == "--class" && i + 1 < args.Length) {
        classFilter = args[i + 1];
        i++;
    } else if (args[i] == "--output" && i + 1 < args.Length) {
        outputFile = args[i + 1];
        outputDir = args[i + 1];
        hasOutput = true;
        i++;
    } else if (args[i] == "--output") {
        outputFile = "-";
        hasOutput = true;
    } else if (args[i] == "--constant-properties" && i + 1 < args.Length) {
        constantProperties = args[i + 1];
        i++;
    } else if (args[i] == "--test") {
        isTestMode = true;
    }
}

//////////////////////////////////////////////////////////////////////////
// Handle all the run modes

// FIRST: Run modes that do not need DotCL

if (printHelp) {
    PrintHelp();
    return;
}

if (hasAssembly && !string.IsNullOrEmpty(assemblyFile)) {
    Console.Error.WriteLine($"[Program.cs] Generating assembly metadata...");
    if (!hasOutput || string.IsNullOrEmpty(outputFile)) {
        outputFile = "-";
    }
    if (outputFile == "-") {
        PackageGenerator.AssemblyToLispy.RedirectLogsToError = true;
    }
    try {
        string fullAssemblyPath = Path.GetFullPath(assemblyFile);
        string inputDir = Path.GetDirectoryName(fullAssemblyPath) ?? Directory.GetCurrentDirectory();
        string inputAssemblyFile = Path.GetFileName(fullAssemblyPath);
        PackageGenerator.AssemblyToLispy.GenerateLispyMetadata(inputDir, inputAssemblyFile, outputFile);
    } catch (Exception ex) {
        Console.Error.WriteLine($"[Program.cs] Error generating metadata: {ex.Message}");
        Console.Error.WriteLine(ex.StackTrace);
        Environment.Exit(1);
    }
    Console.Error.WriteLine($"[Program.cs] ...assembly metadata generation complete.");
    return;
}

// NEXT: Program invocations that require DotCL to be running

DotclHost.Initialize();

// Register the custom C#-implemented Lisp package with DotCL's
// package registry.
MonoUtilsRegistrar.Initialize();

// FIXME: This seems awfully fragile. Is there some way we can make these come in
// from the build process?
var manifestPath = Path.Combine(
    AppContext.BaseDirectory, "dotcl-fasl", "dotcl-deps.txt");
Console.WriteLine($"[Program.cs] manifest: {manifestPath}");
var loaded = DotclHost.LoadFromManifest(manifestPath);
Console.WriteLine($"[Program.cs] LoadFromManifest loaded {loaded} fasls");


if (printVersion) {
    PrintVersion();
    return;
}

if (hasAssemblyMetadata && !string.IsNullOrEmpty(assemblyMetadataFile)) {
    Console.WriteLine("[Program.cs] Running assembly package generator...");
    try {
        DotclHost.Call("RUN-ASSEMBLY-PACKAGE-GENERATOR", assemblyMetadataFile, classFilter ?? "", outputDir ?? "", constantProperties ?? "");
    } catch (Exception ex) {
        Console.Error.WriteLine($"[Program.cs] Error in assembly package generator: {ex.Message}");
        Console.Error.WriteLine(ex.StackTrace);
        Environment.Exit(1);
    }
    Console.WriteLine("[Program.cs] ...assembly package generator complete.");
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

    Console.WriteLine("Usage: dotcl-packagegen [options]");
    Console.WriteLine();
    Console.WriteLine("Stage 1 - extract assembly metadata:");
    Opt("--assembly <path>", "Reflect over the given .NET assembly and emit Lisp",
        "S-expression metadata describing its public types.");
    Opt("--output <path|->", "Destination for the metadata (default '-', meaning",
        "stdout; diagnostics always go to stderr so the payload",
        "stays clean).");
    Console.WriteLine();
    Console.WriteLine("Stage 2 - generate Lisp package(s) from metadata:");
    Opt("--assembly-metadata <path>", "Metadata file produced by Stage 1.");
    Opt("--class <name>", "Fully-qualified C# class name to generate a Lisp",
        "package for.");
    Opt("--output <dir>", "Destination directory for the generated .lisp",
        "package file(s).");
    Opt("--constant-properties <spec>", "Comma/semicolon-separated static property names",
        "(or \"*\" for all) to emit as Lisp constants instead",
        "of re-evaluated accessors.");
    Console.WriteLine();
    Console.WriteLine("Other:");
    Opt("--test", "Run the generator's own Lisp unit tests plus the",
        "AssemblyToLispy metadata test suite.");
    Opt("--version", "Show version, author, license, and copyright",
        "information (read from dotcl-packagegen.asd).");
    Opt("--help", "Show this help message.");
    Console.WriteLine();
    Console.WriteLine("Examples:");
    Console.WriteLine("  dotcl-packagegen --assembly MonoGame.Framework.dll \\");
    Console.WriteLine("      --output /tmp/mg.lispy.metadata");
    Console.WriteLine();
    Console.WriteLine("  dotcl-packagegen --assembly-metadata /tmp/mg.lispy.metadata \\");
    Console.WriteLine("      --class Microsoft.Xna.Framework.Vector2 \\");
    Console.WriteLine("      --output ./cspackages --constant-properties \"*\"");
}
