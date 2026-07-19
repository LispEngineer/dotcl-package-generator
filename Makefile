# Makefile for dotcl-packagegen
# Copyright 2026 Douglas P. Fields, Jr.

# Some installs (notably Arch, whose dotnet-sdk package is rolling-release)
# end up with a workload-set manifest that references packages package
# management has since removed, breaking every `dotnet build`/`dotnet pack`
# invocation with "SDK Resolver Failure ... Workload set version ... has
# missing manifests" -- even `dotnet workload repair` reports "No workloads
# are installed, nothing to repair", since the failure is in resolving the
# workload SDK resolver itself, not in any actual installed workload. This
# project uses no workloads (no mobile/wasm/MAUI targets), so disabling
# workload resolution entirely is safe here.
export MSBuildEnableWorkloadResolver := false

# On a fully clean checkout, -getProperty:OutputPath can return a mixed-separator
# value (e.g. "bin\Debug/net10.0/"); normalize to forward slashes.
BIN_DIR := $(shell dotnet build dotcl-packagegen.csproj -getProperty:OutputPath | tr '\\' '/')
EXECUTABLE := $(BIN_DIR)dotcl-packagegen
NUPKG_DIR = nupkg

# Tool package version, read from dotcl-packagegen.asd's :version so it is
# only ever defined in one place. The minor version tracks
# apg-naming.lisp's internal *generator-version*, so they
# stay visibly in sync.
VERSION := $(shell grep -m1 -oP ':version\s+"\K[^"]+' dotcl-packagegen.asd)

# Reference assembly directory for the standard .NET metadata used by `test`
# to exercise Stage 1/Stage 2 generation end-to-end. Auto-discovered across
# both the Arch (/usr/share/dotnet/...) and Ubuntu (/usr/lib/dotnet/...) pack
# layouts (see dotcl-dungeonslime's Makefile for the same distinction),
# picking the highest reference-pack version whose major matches the target
# framework below -- no longer a hardcoded, SDK-patch-version-fragile
# constant (doc/plan-fable-detail-08.md). Override explicitly with
# `make test REF_DIR=...` if auto-discovery picks the wrong one, or set
# DOTCL_PACKAGEGEN_REF_DIR for the same effect on the C# test suite alone.
TARGET_FRAMEWORK_MAJOR := $(shell grep -oP '<TargetFramework>net\K[0-9]+' dotcl-packagegen.csproj)
ifndef REF_DIR
ifdef DOTCL_PACKAGEGEN_REF_DIR
REF_DIR := $(DOTCL_PACKAGEGEN_REF_DIR)
else
REF_DIR := $(shell ls -d /usr/share/dotnet/packs/Microsoft.NETCore.App.Ref/$(TARGET_FRAMEWORK_MAJOR).*/ref/net*/ \
                         /usr/lib/dotnet/packs/Microsoft.NETCore.App.Ref/$(TARGET_FRAMEWORK_MAJOR).*/ref/net*/ 2>/dev/null \
                    | sort -V | tail -1)
endif
endif

# The generated test directory is kept, and even checked in to version control,
# so we can see how the output changes over time.
GEN_TEST_DIR = cspackages-test

# Third-party assemblies for the runtime exercise suite (`test-runtime`):
# MonoGame + Gum, the same real-world libraries dotcl-dungeonslime consumes
# (where the v48-v50 escapes were originally found downstream). Reflection
# needs each assembly's dependencies loadable from the SAME directory, so
# they are staged together into $(RT_REFS) before generation (the NuGet
# cache keeps every package in its own directory). Versions are pinned and
# must match RuntimeExerciseTest.csproj's PackageReference versions, which
# put these same assemblies in the test project's output directory for
# DotCL compile time and runtime.
NUGET_DIR = $(HOME)/.nuget/packages
MONOGAME_VER = 3.8.5
GUM_VER = 2026.5.8.1
INTERP_VER = 2025.4.22.1
TEXTCOPY_VER = 6.2.1
RT_REFS = RuntimeExerciseTest/refs

.PHONY: all clean build test test-runtime check-parens package deploy

all: build test

build:
	# Build the project, compiling both C# and DotCL Common Lisp code in one step.
	dotnet build dotcl-packagegen.csproj -v d -c Debug

test: build
	# Runs the generator's own Lisp unit tests plus the AssemblyToLispy
	# metadata test suite (System.Runtime, System.Console, the synthetic
	# target, and DotCL.Runtime).
	@test -n "$(REF_DIR)" || (echo "REF_DIR not found; set REF_DIR=... explicitly" >&2 && exit 1)
	DOTCL_PACKAGEGEN_REF_DIR=$(REF_DIR) $(EXECUTABLE) --test
	# Exercise the single-pass generator end-to-end (metadata reflection +
	# package generation for a couple of representative standard-.NET
	# classes, all in one invocation), then verify the emitted Lisp is
	# syntactically well-formed (balanced parentheses) before trusting it.
	# This catches code-emission regressions that unit tests miss, since
	# the generator produces its output via textual templating.
	# 
	# Some of these things are also in System.Runtime:
	# System.AppDomain System.Diagnostics.Debug System.Environment System.Globalization.CultureInfo
	rm -rf $(GEN_TEST_DIR)
	mkdir -p $(GEN_TEST_DIR)
	# The smoke invocation itself lives in test-options.txt.in (doc/plan-
	# fable-detail-07.md's --options-file response-file front end) --
	# substitute REF_DIR/BIN_DIR (Make variables an options file can't
	# expand itself) into a real file, then pass that via --options-file.
	sed -e "s|@REF_DIR@|$(REF_DIR)|g" -e "s|@BIN_DIR@|$(BIN_DIR)|g" \
	    test-options.txt.in > $(BIN_DIR)test-options.txt
	$(EXECUTABLE) --out-dir $(GEN_TEST_DIR) --no-csharp-generic-in-asd \
	    --options-file $(BIN_DIR)test-options.txt
	# EventTestClass demonstrates Version 38's extension-method injection
	# (--extension-methods, ON by default) against a real, generated package:
	# see EventTestClassExtensions in AssemblyToLispyTestTarget/EdgeCases.cs
	# for the one clean survivor (Describe) plus the dirty/ambiguous/own-
	# collision skip cases.
	# NestingContainer/AbstractBase/IDummyInterface demonstrate Version 39's
	# --output-nested/--output-children/--output-implementations: NestingContainer
	# pulls in its own NestedLevel2/NestedLevel3 in one prefix scan; AbstractBase
	# and IDummyInterface both independently discover GenericClass`1 (which extends
	# the former and implements the latter) as its own package, deduplicated.
	# ConcreteDerivedFromGeneric demonstrates Version 40's :superclass/:interfaces
	# generic-identity fix: its superclass is a CLOSED instantiation
	# (GenericBaseForSuperclassTest<EdgeCaseStruct>) of a generic type defined in
	# this same assembly -- before the fix, --export-parents could never resolve
	# a closed-generic superclass at all (see doc/generator-design-notes.md's
	# "Generic Superclass/Interface Identity Matching (Version 40)" section).
	# System.Threading.Timer/System.Timers.Timer (the deliberate same-simple-name
	# collision pair from Version 35/36/41's own verification) demonstrates
	# Version 44's --ensure-type and Version 45's --ensure-type-in-generic:
	# only Timer opts into both, so its own class file emits the "Register C#
	# Type with CLOS" eval-when (Version 44) AND csharp-generics.lisp emits a
	# second copy (with :compile-toplevel, Version 45) immediately before
	# Timer's own --defgeneric defmethod block there; Timers.Timer (also
	# --defgeneric, but neither --ensure-type flag) gets neither (both sticky
	# defaults are turned back off immediately after Timer).
	# The whole invocation also passes Version 46's --no-csharp-generic-in-asd
	# (global, not per-class), so csharp-assembly-packages.asd's own
	# csharp-generics.lisp :file component is written out as a comment
	# instead of an active component -- demonstrating the flag's OFF path;
	# every prior version's golden output already demonstrates the ON
	# (default) path.
	# Others for future: System.Globalization.CultureInfo, DateTimeFormatInfo;
	# System.Collections.Generic.List, SortedList; System.Text.StringBuilder;
	# System.Drawing.Point/F; Size/F
	# Undo any changes that only changed typestamp
	./revert-cspackages-timestamps.sh
	python3 check_parens.py $(GEN_TEST_DIR)/*.lisp $(GEN_TEST_DIR)/*.asd
	# Full-reader validation: every generated file must be readable by the
	# real Lisp reader (catches invalid symbol tokens, bad string escapes,
	# and reader-macro breakage that paren-balance checking cannot see --
	# see doc/generator-design-notes.md's Version 47 section for the bug
	# class this exists to catch).
	$(EXECUTABLE) --read-check $(GEN_TEST_DIR)

test-runtime: build
	# Runtime exercise suite (doc/plan-fable-detail-02.md, RuntimeExerciseTest/):
	# actually compiles, loads, and CALLS generated wrapper code against live
	# .NET objects -- the structural fix for the v48-v50 escape class
	# (omitted-optional-passed-as-nil, Master Wrapper dispatch ordering,
	# Nullable<T> guards), all of which were runtime-dispatch bugs invisible
	# to `test`'s string-level (paren-balance/read-back) assertions above.
	rm -rf RuntimeExerciseTest/gen
	# Stage the MonoGame/Gum assemblies (plus their own dependencies) into one
	# directory so reflection can resolve cross-assembly references -- see the
	# RT_REFS comment near the top of this file.
	mkdir -p $(RT_REFS)
	cp $(NUGET_DIR)/monogame.framework.desktopgl/$(MONOGAME_VER)/lib/net8.0/MonoGame.Framework.dll \
	   $(NUGET_DIR)/monogame.framework.desktopgl/$(MONOGAME_VER)/lib/net8.0/MonoGame.Framework.xml \
	   $(NUGET_DIR)/flatredball.gumcommon/$(GUM_VER)/lib/net8.0/GumCommon.dll \
	   $(NUGET_DIR)/flatredball.gumcommon/$(GUM_VER)/lib/net8.0/GumCommon.xml \
	   $(NUGET_DIR)/flatredball.interpolationcore/$(INTERP_VER)/lib/netstandard2.0/FlatRedBall.InterpolationCore.dll \
	   $(NUGET_DIR)/gum.monogame/$(GUM_VER)/lib/net8.0/MonoGameGum.dll \
	   $(NUGET_DIR)/textcopy/$(TEXTCOPY_VER)/lib/net6.0/TextCopy.dll \
	   $(RT_REFS)/
	$(EXECUTABLE) --out-dir RuntimeExerciseTest/gen \
	    --assembly $(REF_DIR)System.Runtime.dll \
	      --class System.TimeSpan --constant-properties "*" \
	      --class System.DateTime \
	      --class System.Text.StringBuilder --defgeneric \
	    --assembly $(RT_REFS)/MonoGame.Framework.dll \
	      --class Microsoft.Xna.Framework.Vector2 --constant-properties "*" --defgeneric \
	      --class Microsoft.Xna.Framework.Color --constant-properties "*" \
	      --class Microsoft.Xna.Framework.Point --constant-properties "*" \
	      --class Microsoft.Xna.Framework.Rectangle --constant-properties "*" \
	      --class Microsoft.Xna.Framework.MathHelper \
	      --class Microsoft.Xna.Framework.GameTime \
	      --class Microsoft.Xna.Framework.Input.Keys \
	    --assembly $(RT_REFS)/GumCommon.dll \
	      --class Gum.DataTypes.DimensionUnitType \
	    --assembly $(RT_REFS)/MonoGameGum.dll \
	      --class MonoGameGum.GueDeriving.TextRuntime \
	      --class Gum.Forms.Controls.KeyCombo \
	    --assembly $(BIN_DIR)AssemblyToLispyTestTarget.dll \
	      --class AssemblyToLispyTestTarget.RuntimeExerciseFixtures --constant-properties "SharedSingleton" \
	      --class AssemblyToLispyTestTarget.EdgeCaseStruct \
	      --class AssemblyToLispyTestTarget.RuntimeOpStruct \
	      --class AssemblyToLispyTestTarget.GenericDispatchFixtureA --defgeneric \
	      --class AssemblyToLispyTestTarget.GenericDispatchFixtureB --defgeneric \
	      --class AssemblyToLispyTestTarget.EventTestClass \
	      --class AssemblyToLispyTestTarget.GenericMethodTestClass
	# DotCL cross-compiles gen/'s generated .lisp during this dotnet build,
	# exactly as a real downstream consumer (dotcl-dungeonslime) would --
	# this also permanently regression-tests ASDF-loadability (the
	# dotcl/dotcl#49 class fixed across Versions 42-46).
	# The dotcl-fasl bundle must be cleared first: MSBuild's incremental
	# inputs for the DotCL dependency-resolution target track only the .asd/
	# build-init/search-path items, not gen/'s regenerated contents, so a
	# stale csharp-assembly-packages fasl would otherwise be reused.
	rm -rf RuntimeExerciseTest/obj/Debug/net10.0/dotcl-fasl
	dotnet build RuntimeExerciseTest/RuntimeExerciseTest.csproj -c Debug
	dotnet run --no-build --project RuntimeExerciseTest/RuntimeExerciseTest.csproj -c Debug

check-parens:
	# Verifies balanced parentheses in every source .lisp/.asd file in the
	# repository (excludes build output and the local NuGet feed).
	find . -type f \( -name "*.lisp" -o -name "*.asd" \) ! -path "*/obj/*" ! -path "*/bin/*" ! -path "*/.git/*" ! -path "*/nupkg/*" | xargs python3 check_parens.py

package:
	# Builds Release binaries for every RuntimeIdentifier and produces the
	# installable NuGet package(s) (per-RID packages plus the meta package
	# that dispatches to them) in $(NUPKG_DIR)/, stamped with $(VERSION).
	@test -n "$(VERSION)" || (echo "VERSION could not be read from dotcl-packagegen.asd" >&2 && exit 1)
	dotnet pack dotcl-packagegen.csproj -c Release -o $(NUPKG_DIR) -p:PackageVersion=$(VERSION)

deploy: package
	# Installs (or reinstalls, if already present) dotcl-packagegen as a
	# global dotnet tool at $(VERSION) from the package(s) just built, making
	# the `dotcl-packagegen` executable available on PATH.
	-dotnet tool uninstall --global dotcl-packagegen
	dotnet tool install --global --add-source $(NUPKG_DIR) --version $(VERSION) dotcl-packagegen

clean:
	dotnet clean dotcl-packagegen.csproj
	rm -rf bin obj AssemblyToLispyTestTarget/bin AssemblyToLispyTestTarget/obj $(NUPKG_DIR)
	rm -rf RuntimeExerciseTest/bin RuntimeExerciseTest/obj RuntimeExerciseTest/gen RuntimeExerciseTest/refs

version:
	echo $(VERSION)

# I wanted a good example of --skip-missing, but:
# The best candidate: System.ValueTuple (already in the Makefile — zero new classes needed)
#
# System.ValueTuple\2through`8`` all implement System.IValueTupleInternal, an **internal BCL interface that doesn't exist in any public reference assembly** — not "missing because you forgot an assembly," but genuinely unresolvable no matter what you add. This makes it a clean, honest demonstration of --skip-missing's real purpose, using types you already generate:
#
# --class 'System.ValueTuple`2' --export-interfaces --skip-missing
#
# produces (post-Version-40 -- see below):
# Warning: Ancestor class not found in any provided assembly metadata (skipped): System.IValueTupleInternal
# Generating package for C# Class: System.Collections.IStructuralComparable
# Generating package for C# Class: System.Collections.IStructuralEquatable
# Generating package for C# Class: System.IComparable
# Generating package for C# Class: System.IComparable`1
# Generating package for C# Class: System.IEquatable`1
# Generating package for C# Class: System.Runtime.CompilerServices.ITuple
#
# Six real public interfaces resolve and generate fine; IValueTupleInternal is warned-and-dropped. Without --skip-missing, the same run correctly hard-errors and writes nothing. I'd suggest adding --export-interfaces --skip-missing to just one of the existing ValueTuple\N`` entries (not all 7 — no need to bloat the smoke test with duplicate coverage).
#
# A formerly-open caveat, now fixed (Version 40)
#
# Before Version 40, IComparable\1/IEquatable`1 (System.ValueTuple`2's own generic interfaces) were ALSO incorrectly reported "missing" alongside the genuinely-missing IValueTupleInternal — not a real missing-assembly case, but a :interfaces-formatting bug (a generic interface reference lost its namespace, so it could never match its own type's :fully-qualified-name; see doc/generator-design-notes.md's "Generic Superclass/Interface Identity Matching (Version 40)" section, and AssemblyToLispyTestTarget/EdgeCases.cs's GenericBaseForSuperclassTest/ConcreteDerivedFromGeneric for the dedicated regression test). It affected nearly every generic-interface/superclass reference in this whole assembly set (Dictionary<K,V>, List<T>, Vector2/3/4, TimeSpan, String, etc. all showed the same symptom) -- all now resolve correctly. ValueTuple remains a good demonstration spot precisely because it has *both* kinds side by side: a real --skip-missing case (IValueTupleInternal) and, historically, the now-fixed generic-formatting case.
#
# A genuine "real assembly not provided" example, if you want that flavor instead
#
# System.Xml.Schema.XmlSchemaObjectCollection (in System.Xml.ReaderWriter.dll, not currently requested) has :superclass "System.Collections.CollectionBase", which lives in System.Collections.NonGeneric.dll — an assembly genuinely absent from the current Makefile set. This would require adding one new --class plus optionally the new assembly to see it resolve when you did add it, so it's a bit more setup than the ValueTuple option, but it demonstrates the "you just forgot to pass the right --assembly" case rather than an inherently-unresolvable internal type. Let me know if you'd like me to make either edit to the Makefile.