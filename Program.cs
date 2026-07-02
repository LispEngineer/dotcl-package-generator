// Copyright 2026 Douglas P. Fields, Jr.
//
// This is the standalone package-generator entry point
// It exposes only two-stage assembly-to-Lisp
// package generator plus its test mode.

using DotCL;
using PackageGenerator;
using System.Text.RegularExpressions;

const string AsdFileName = "dotcl-packagegen.asd";

if (args.Contains("--help")) {
    PrintHelp();
    return;
}

if (args.Contains("--version")) {
    PrintVersion();
    return;
}

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

DotclHost.Initialize();

// Register the custom C#-implemented Lisp package with DotCL's
// package registry.
MonoUtilsRegistrar.Initialize();

if (hasAssemblyMetadata && !string.IsNullOrEmpty(assemblyMetadataFile)) {
    Console.WriteLine("[Program.cs] Running assembly package generator...");
    try {
        var generatorManifestPath = Path.Combine(AppContext.BaseDirectory, "dotcl-fasl", "dotcl-deps.txt");
        DotclHost.LoadFromManifest(generatorManifestPath);
        DotclHost.Call("RUN-ASSEMBLY-PACKAGE-GENERATOR", assemblyMetadataFile, classFilter ?? "", outputDir ?? "", constantProperties ?? "");
    } catch (Exception ex) {
        Console.Error.WriteLine($"[Program.cs] Error in assembly package generator: {ex.Message}");
        Console.Error.WriteLine(ex.StackTrace);
        Environment.Exit(1);
    }
    Console.WriteLine("[Program.cs] ...assembly package generator complete.");
    return;
}

var manifestPath = Path.Combine(
    AppContext.BaseDirectory, "dotcl-fasl", "dotcl-deps.txt");
Console.WriteLine($"[Program.cs] manifest: {manifestPath}");
var loaded = DotclHost.LoadFromManifest(manifestPath);
Console.WriteLine($"[Program.cs] LoadFromManifest loaded {loaded} fasls");

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

Console.Error.WriteLine("[Program.cs] No action specified. Use --assembly, --assembly-metadata, or --test.");
Environment.Exit(1);

//////////////////////////////////////////////////////////////////////////////
// --version / --help

// Reads the :description/:version/:author/:license fields and the leading
// ";;; Copyright ..." comment straight out of dotcl-packagegen.asd, so
// `--version` never drifts from the system definition (the canonical
// version source per BUILD.md). This is a plain textual scan rather than a
// full Lisp reader; it is only expected to handle the simple, unescaped
// string literals this project's own .asd actually uses.
static (string? Copyright, string? Description, string? Version, string? Author, string? License) ReadAsdMetadata() {
    string asdPath = Path.Combine(AppContext.BaseDirectory, AsdFileName);
    if (!File.Exists(asdPath)) {
        return (null, null, null, null, null);
    }

    string text = File.ReadAllText(asdPath);

    string? Field(string key) {
        var m = Regex.Match(text, $@":{key}\s+""([^""]*)""");
        return m.Success ? m.Groups[1].Value : null;
    }

    string? copyright = null;
    var copyrightMatch = Regex.Match(text, @"^;;;\s*(Copyright.*)$", RegexOptions.Multiline);
    if (copyrightMatch.Success) {
        copyright = copyrightMatch.Groups[1].Value.Trim();
    }

    return (copyright, Field("description"), Field("version"), Field("author"), Field("license"));
}

void PrintVersion() {
    var (copyright, description, version, author, license) = ReadAsdMetadata();
    Console.WriteLine($"dotcl-packagegen {version ?? "(version unknown: dotcl-packagegen.asd not found)"}");
    if (description != null) Console.WriteLine(description);
    if (author != null) Console.WriteLine($"Author: {author}");
    if (license != null) Console.WriteLine($"License: {license}");
    if (copyright != null) Console.WriteLine(copyright);
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
