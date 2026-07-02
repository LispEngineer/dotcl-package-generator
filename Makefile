# Makefile for dotcl-packagegen
# Copyright 2026 Douglas P. Fields, Jr.

# On a fully clean checkout, -getProperty:OutputPath can return a mixed-separator
# value (e.g. "bin\Debug/net10.0/"); normalize to forward slashes.
BIN_DIR := $(shell dotnet build dotcl-packagegen.csproj -getProperty:OutputPath | tr '\\' '/')
EXECUTABLE := $(BIN_DIR)dotcl-packagegen
NUPKG_DIR = nupkg

# Tool package version. The minor version tracks assembly-package-generator.lisp's
# internal *generator-version* (currently 18), so they stay visibly in sync.
VERSION = 1.18.1

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
	# Exercise Stage 1 + Stage 2 generation end-to-end on a couple of
	# representative standard-.NET classes, then verify the emitted Lisp
	# is syntactically well-formed (balanced parentheses) before trusting
	# it. This catches code-emission regressions that unit tests miss,
	# since the generator produces its output via textual templating.
	rm -rf $(GEN_TEST_DIR)
	mkdir -p $(GEN_TEST_DIR)
	$(EXECUTABLE) --assembly $(REF_DIR)System.Runtime.dll --output $(GEN_TEST_DIR)/System.Runtime.lispy.metadata
	$(EXECUTABLE) --assembly-metadata $(GEN_TEST_DIR)/System.Runtime.lispy.metadata --class System.TimeSpan --output $(GEN_TEST_DIR) --constant-properties "*"
	$(EXECUTABLE) --assembly-metadata $(GEN_TEST_DIR)/System.Runtime.lispy.metadata --class System.Object --output $(GEN_TEST_DIR)
	$(EXECUTABLE) --assembly-metadata $(GEN_TEST_DIR)/System.Runtime.lispy.metadata --class System.Type --output $(GEN_TEST_DIR)
	$(EXECUTABLE) --assembly-metadata $(GEN_TEST_DIR)/System.Runtime.lispy.metadata --class System.String --output $(GEN_TEST_DIR)
	# Others for future: System.Globalization.CultureInfo, DateTimeFormatInfo; System.Convert
	#
	$(EXECUTABLE) --assembly $(REF_DIR)System.Linq.dll --output $(GEN_TEST_DIR)/System.Linq.lispy.metadata
	$(EXECUTABLE) --assembly-metadata $(GEN_TEST_DIR)/System.Linq.lispy.metadata --class System.Linq.Enumerable --output $(GEN_TEST_DIR)
	#
	$(EXECUTABLE) --assembly $(REF_DIR)System.Xml.ReaderWriter.dll --output $(GEN_TEST_DIR)/System.Xml.ReaderWriter.lispy.metadata
	$(EXECUTABLE) --assembly-metadata $(GEN_TEST_DIR)/System.Xml.ReaderWriter.lispy.metadata --class System.Xml.XmlReader --output $(GEN_TEST_DIR)
	python3 check_parens.py $(GEN_TEST_DIR)/*.lisp

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
