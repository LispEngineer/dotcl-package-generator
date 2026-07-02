;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Define all the packages and exports of this software.
;;;
;;; This is the trimmed package set for the standalone dotcl-packagegen tool,
;;; extracted from the DungeonSlime repository's packages.lisp. Only the
;;; packages the generator itself, its runtime support (utils/monoutils), and
;;; its System.*-only tests need are declared here.

(format *error-output* "[packages.lisp] Loading beginning.~%" *package*)
(in-package :cl-user)
(require "asdf") ;; Load uiop library (needed by utils.lisp / assembly-package-generator.lisp)
(format *error-output* "[packages.lisp] Defining packages in package ~S~%" *package*)

;; Pre-declare empty C# packages so local-nicknames doesn't crash.
(defpackage :system-io-path)
(defpackage :system-app-domain)
(defpackage :system-object)
(defpackage :system-type)

;; Some special packages
(defpackage :system-object
  (:export #:get-type))
(defpackage :system-type
  (:export #:full-name))

(defpackage :utils
  (:use :cl)
  (:local-nicknames
    (:path :system-io-path)
    (:app-domain :system-app-domain))
  (:export #:safe-read-form-from-file
            #:+base-directory+
            #:format-red
            #:path-combine
            #:file-exists-and-readable-p
            #:qualify-path
            #:csharp-overload-not-found
            #:csharp-overload-package-name
            #:csharp-overload-class-name
            #:csharp-overload-method-name
            #:csharp-overload-supplied-args))

(defpackage :monoutils
  (:use :cl)
  (:local-nicknames
    (:object :system-object)
    (:type :system-type))
  (:export #:add3
            #:dotnet-p
            #:boxed-dotnet-p
            #:get-type
            #:get-type-full-name))

(defpackage :assembly-package-generator
  (:use :cl)
  (:export #:run-assembly-package-generator
            #:generate-assembly-packages
            #:camel-to-kebab
            #:split-string))

(defpackage :package-generator-tests
  (:use :cl :assembly-package-generator :utils :monoutils)
  (:export
    #:run-generator-tests
    #:run-package-generator-tests))
