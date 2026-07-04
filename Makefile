# Makefile for dotcl-packagegen
# Copyright 2026 Douglas P. Fields, Jr.

# On a fully clean checkout, -getProperty:OutputPath can return a mixed-separator
# value (e.g. "bin\Debug/net10.0/"); normalize to forward slashes.
BIN_DIR := $(shell dotnet build dotcl-packagegen.csproj -getProperty:OutputPath | tr '\\' '/')
EXECUTABLE := $(BIN_DIR)dotcl-packagegen
NUPKG_DIR = nupkg

# Tool package version. The minor version tracks assembly-package-generator.lisp's
# internal *generator-version* (currently 30), so they stay visibly in sync.
VERSION = 2.30.0

# Reference assembly directory for the standard .NET metadata used by `test`
# to exercise Stage 1/Stage 2 generation end-to-end. This is the Arch Linux
# path; on Ubuntu it is /usr/lib/dotnet/packs/Microsoft.NETCore.App.Ref/10.0.9/ref/net10.0/
# (see dotcl-dungeonslime's Makefile for the same distinction).
REF_DIR = /usr/share/dotnet/packs/Microsoft.NETCore.App.Ref/10.0.9/ref/net10.0/

# The generated test directory is kept, and even checked in to version control,
# so we can see how the output changes over time.
GEN_TEST_DIR = cspackages-test

.PHONY: all clean build test check-parens package deploy

all: build test

build:
	# Build the project, compiling both C# and DotCL Common Lisp code in one step.
	dotnet build dotcl-packagegen.csproj -v d -c Debug

test: build
	# Runs the generator's own Lisp unit tests plus the AssemblyToLispy
	# metadata test suite (System.Runtime, System.Console, the synthetic
	# target, and DotCL.Runtime).
	$(EXECUTABLE) --test
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
	$(EXECUTABLE) --out-dir $(GEN_TEST_DIR) \
   	    --assembly $(REF_DIR)System.Console.dll \
	      --class System.Console \
	    --assembly $(REF_DIR)System.Runtime.dll \
	      --class System.TimeSpan --constant-properties "*" \
	      --class System.Object \
	      --class System.Type \
	      --class System.String \
				--class System.Array --constant-properties "MaxLength" \
	      --class System.TimeZoneInfo \
				--class System.Convert \
				--class System.Text.StringBuilder \
	      --class 'System.TimeZoneInfo+AdjustmentRule' \
				--class 'System.ValueTuple`2' \
				--class 'System.ValueTuple`3' \
				--class 'System.ValueTuple`4' \
				--class 'System.ValueTuple`5' \
				--class 'System.ValueTuple`6' \
				--class 'System.ValueTuple`7' \
				--class 'System.ValueTuple`8' \
	    --assembly $(REF_DIR)System.Linq.dll \
	      --class System.Linq.Enumerable \
	    --assembly $(REF_DIR)System.Xml.ReaderWriter.dll \
	      --class System.Xml.XmlReader \
	    --assembly $(REF_DIR)System.Collections.dll \
	      --class 'System.Collections.Generic.Dictionary`2' \
	      --class 'System.Collections.Generic.Dictionary`2+KeyCollection' \
	      --class 'System.Collections.Generic.Dictionary`2+ValueCollection' \
	      --class 'System.Collections.Generic.List`1' \
	      --class 'System.Collections.Generic.SortedList`2' \
	    --assembly $(REF_DIR)System.Numerics.Vectors.dll \
	      --class 'System.Numerics.Vector2' --constant-properties "*" \
	      --class 'System.Numerics.Vector3' --constant-properties "*" \
	      --class 'System.Numerics.Vector4' --constant-properties "*" \
	    --assembly $(REF_DIR)System.Diagnostics.Debug.dll \
	      --class System.Diagnostics.Debug \
	    --assembly $(REF_DIR)System.Globalization.dll \
	      --class System.Globalization.CultureInfo \
	    --assembly $(REF_DIR)System.Net.ServicePoint.dll \
	      --class System.Net.ServicePointManager \
	    --assembly $(REF_DIR)System.Runtime.Extensions.dll \
	      --class System.Environment \
	      --class System.AppDomain \
	    --assembly $(REF_DIR)System.Threading.Thread.dll \
	      --class System.Threading.Thread
	# Others for future: System.Globalization.CultureInfo, DateTimeFormatInfo;
	# System.Collections.Generic.List, SortedList; System.Text.StringBuilder;
	# System.Drawing.Point/F; Size/F
	# Undo any changes that only changed typestamp
	./revert-cspackages-timestamps.sh
	python3 check_parens.py $(GEN_TEST_DIR)/*.lisp $(GEN_TEST_DIR)/*.asd

check-parens:
	# Verifies balanced parentheses in every source .lisp/.asd file in the
	# repository (excludes build output and the local NuGet feed).
	find . -type f \( -name "*.lisp" -o -name "*.asd" \) ! -path "*/obj/*" ! -path "*/bin/*" ! -path "*/.git/*" ! -path "*/nupkg/*" | xargs python3 check_parens.py

package:
	# Builds Release binaries for every RuntimeIdentifier and produces the
	# installable NuGet package(s) (per-RID packages plus the meta package
	# that dispatches to them) in $(NUPKG_DIR)/, stamped with $(VERSION).
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
