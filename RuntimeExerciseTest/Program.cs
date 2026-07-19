// Copyright 2026 Douglas P. Fields, Jr.
//
// Entry point for the runtime exercise suite (doc/plan-fable-detail-02.md):
// boots DotCL, loads the cross-compiled runtime-exercise system (which
// depends on the freshly-generated csharp-assembly-packages system in
// gen/), calls into RUN-RUNTIME-EXERCISE-TESTS, and exits nonzero if any
// assertion failed.

using System;
using System.IO;
using DotCL;

DotclHost.Initialize();

// The generated csharp-generics.fasl (from --defgeneric) embeds a
// #.(dotnet:class-for-type "...") CLOS class reference resolved at COMPILE
// time in a different process (the MSBuild task). Loading that fasl here
// requires the identically-named CLOS class to already exist in THIS
// process too -- pre-register it for every --defgeneric fixture class
// before loading the manifest below.
DotclHost.Call("CLASS-FOR-TYPE", "AssemblyToLispyTestTarget.GenericDispatchFixtureA");
DotclHost.Call("CLASS-FOR-TYPE", "AssemblyToLispyTestTarget.GenericDispatchFixtureB");

var manifestPath = Path.Combine(AppContext.BaseDirectory, "dotcl-fasl", "dotcl-deps.txt");
Console.WriteLine($"[RuntimeExerciseTest] manifest: {manifestPath}");
int loaded = DotclHost.LoadFromManifest(manifestPath);
Console.WriteLine($"[RuntimeExerciseTest] LoadFromManifest loaded {loaded} fasls");

int failCount = DotclHost.ToClr<int>(DotclHost.Call("RUN-RUNTIME-EXERCISE-TESTS"));

if (failCount != 0) {
    Console.Error.WriteLine($"[RuntimeExerciseTest] {failCount} test(s) failed.");
    Environment.Exit(1);
}

Console.WriteLine("[RuntimeExerciseTest] All tests passed.");
