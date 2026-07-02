# Makefile for dotcl-packagegen
# Copyright 2026 Douglas P. Fields, Jr.

BIN_DIR := $(shell dotnet build dotcl-packagegen.csproj -getProperty:OutputPath)
EXECUTABLE := $(BIN_DIR)dotcl-packagegen
NUPKG_DIR = nupkg
# Tool package version. The minor version tracks assembly-package-generator.lisp's
# internal *generator-version* (currently 18), so they stay visibly in sync.
VERSION = 1.18.0

.PHONY: all clean build test package deploy

all: build test

build:
	# Build the project, compiling both C# and DotCL Common Lisp code in one step.
	dotnet build dotcl-packagegen.csproj -v d -c Debug

test: build
	# Runs the generator's own Lisp unit tests plus the AssemblyToLispy
	# metadata test suite (System.Runtime, System.Console, the synthetic
	# target, and DotCL.Runtime).
	$(EXECUTABLE) --test

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
