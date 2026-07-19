;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Build-time Lisp initialization, loaded by the DotCL MSBuild task before both
;;; ASDF dependency resolution (_DotCLResolveDeps) and root compilation
;;; (_DotCLCompileRoot) -- see <DotclBuildInit> in RuntimeExerciseTest.csproj.
;;;
;;; The generated csharp-generics.lisp (produced for any --defgeneric class)
;;; contains read-time-evaluated #.(dotnet:class-for-type "...") forms. Those
;;; run inside the MSBuild process itself, whose AppContext.BaseDirectory is
;;; the MSBuild/SDK install directory, not this project's own output directory
;;; -- so dotnet:resolve-type's usual "probe every .dll next to the running
;;; app" fallback (which works fine at ordinary application runtime) can never
;;; find AssemblyToLispyTestTarget.dll here. Load it explicitly by the path
;;; WriteOutDirForLisp already computes for this exact purpose (see
;;; obj/dotcl-outdir.txt), mirroring dotcl-packagegen.csproj/DungeonSlime.csproj's
;;; comment about needing referenced assemblies present before Lisp dependency
;;; resolution runs.

(cl:in-package :cl-user)

(cl:let ((outdir-file "obj/dotcl-outdir.txt"))
  (cl:when (cl:probe-file outdir-file)
    (cl:let* ((outdir (cl:with-open-file (s outdir-file) (cl:read-line s cl:nil "")))
              (dll (cl:merge-pathnames "AssemblyToLispyTestTarget.dll" outdir)))
      (cl:when (cl:probe-file dll)
        (cl:format cl:t "~&[build-setup.lisp] Loading ~A...~%" dll)
        (dotnet:load-assembly (cl:namestring dll))
        ;; Also eagerly register the CLOS class for every --defgeneric fixture
        ;; class: FIND-CLASS (used when a dependency fasl referencing that
        ;; class's #.(dotnet:class-for-type ...) form is later loaded, whether
        ;; in this same MSBuild process or a fresh one) needs the class to
        ;; already exist by name -- merely loading the assembly is not enough,
        ;; since EnsureDotNetTypeClass only runs when something actually calls
        ;; dotnet:class-for-type on that specific type.
        (dotnet:class-for-type "AssemblyToLispyTestTarget.GenericDispatchFixtureA")
        (dotnet:class-for-type "AssemblyToLispyTestTarget.GenericDispatchFixtureB")))))
