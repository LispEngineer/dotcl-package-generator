;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Runtime exercise suite (doc/plan-fable-detail-02.md): actually loads and
;;; calls the freshly-generated "csharp-assembly-packages" system (produced
;;; into gen/ by `make test-runtime` before this system is compiled) against
;;; live .NET objects, guarding the v48-v50 runtime-dispatch escape class that
;;; string-level codegen assertions cannot see.

(asdf:defsystem "runtime-exercise"
  :description "Runtime call-through exercise suite for dotcl-packagegen's generated output"
  :author "Douglas P. Fields, Jr. <symbolics@lisp.engineer>"
  :license "Apache 2.0; Copyright 2026 Douglas P. Fields, Jr."
  :depends-on ("csharp-assembly-packages")
  :components ((:file "runtime-tests")))
