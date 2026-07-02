// Copyright 2026 Douglas P. Fields, Jr.
//
// This is the standalone package-generator entry point
// It exposes only two-stage assembly-to-Lisp
// package generator plus its test mode.

using DotCL;
using PackageGenerator;

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
