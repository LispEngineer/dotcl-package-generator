# Makefile for dotcl-packagegen
# Copyright 2026 Douglas P. Fields, Jr.

# On a fully clean checkout, -getProperty:OutputPath can return a mixed-separator
# value (e.g. "bin\Debug/net10.0/"); normalize to forward slashes.
BIN_DIR := $(shell dotnet build dotcl-packagegen.csproj -getProperty:OutputPath | tr '\\' '/')
EXECUTABLE := $(BIN_DIR)dotcl-packagegen
NUPKG_DIR = nupkg

# Tool package version, read from dotcl-packagegen.asd's :version so it is
# only ever defined in one place. The minor version tracks
# assembly-package-generator.lisp's internal *generator-version*, so they
# stay visibly in sync.
VERSION := $(shell grep -m1 -oP ':version\s+"\K[^"]+' dotcl-packagegen.asd)

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
	$(EXECUTABLE) --out-dir $(GEN_TEST_DIR) --no-csharp-generic-in-asd \
   	    --assembly $(REF_DIR)System.Console.dll \
	      --class System.Console \
	    --assembly $(REF_DIR)System.Runtime.dll \
	      --class System.TimeSpan --constant-properties "*" \
	      --class System.Object --defgeneric \
	      --class System.Type \
	      --class System.String --defgeneric \
				--class System.Array --constant-properties "MaxLength" --defgeneric \
	      --class System.TimeZoneInfo \
				--class System.Convert \
				--class System.Text.StringBuilder --defgeneric \
	      --class 'System.TimeZoneInfo+AdjustmentRule' \
				--class 'System.ValueTuple`2' --export-interfaces --skip-missing \
				--class 'System.ValueTuple`3' \
				--class 'System.ValueTuple`4' \
				--class 'System.ValueTuple`5' \
				--class 'System.ValueTuple`6' \
				--class 'System.ValueTuple`7' \
				--class 'System.ValueTuple`8' \
				--class System.ArgumentOutOfRangeException --export-parents --export-interfaces --export-object \
				--class System.Collections.Hashtable --export-all-parents --export-all-interfaces \
				--class System.IO.MemoryStream --export-object \
				--class System.IO.StreamReader \
	    --assembly $(REF_DIR)System.Linq.dll \
	      --class System.Linq.Enumerable --no-export-all-parents --no-export-interfaces \
	    --assembly $(REF_DIR)System.Xml.ReaderWriter.dll \
	      --class System.Xml.XmlReader --no-export-all-interfaces \
	    --assembly $(REF_DIR)System.Collections.dll \
	      --class 'System.Collections.Generic.Dictionary`2' --defgeneric \
	      --class 'System.Collections.Generic.Dictionary`2+KeyCollection' \
	      --class 'System.Collections.Generic.Dictionary`2+ValueCollection' \
	      --class 'System.Collections.Generic.List`1' \
	      --class 'System.Collections.Generic.SortedList`2' --defgeneric \
	    --assembly $(REF_DIR)System.Numerics.Vectors.dll \
	      --class 'System.Numerics.Vector2' --constant-properties "*" --enable-defgeneric \
	      --class 'System.Numerics.Vector3' --constant-properties "*" \
	      --class 'System.Numerics.Vector4' --constant-properties "*" \
	      --no-enable-defgeneric \
	    --assembly $(REF_DIR)System.Threading.Timer.dll \
	      --ensure-type --ensure-type-in-generic \
	      --class System.Threading.Timer --defgeneric \
	      --no-ensure-type --no-ensure-type-in-generic \
	    --assembly $(REF_DIR)System.ComponentModel.TypeConverter.dll \
	      --class System.Timers.Timer --defgeneric \
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
	      --class System.Threading.Thread \
		  --assembly $(REF_DIR)System.Collections.Specialized.dll \
			  --class System.Collections.Specialized.NameValueCollection --export-parents --export-interfaces --export-object \
	    --assembly $(BIN_DIR)AssemblyToLispyTestTarget.dll \
	      --class AssemblyToLispyTestTarget.EventTestClass \
	      --class AssemblyToLispyTestTarget.NestingContainer --output-nested \
	      --class AssemblyToLispyTestTarget.AbstractBase --output-children \
	      --class AssemblyToLispyTestTarget.IDummyInterface --output-implementations \
	      --class AssemblyToLispyTestTarget.ConcreteDerivedFromGeneric --export-parents
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