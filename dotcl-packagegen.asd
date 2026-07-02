;;; Copyright 2026 Douglas P. Fields, Jr.

(defsystem "dotcl-packagegen"
  :description "DotCL C#-assembly-to-Lisp package generator"
  :version "1.18.2"
  :author "Douglas P. Fields, Jr. <symbolics@lisp.engineer>"
  :license "Apache 2.0; Copyright 2026 Douglas P. Fields, Jr."
  :depends-on ("dotnet-class")
  :components ((:file "packages")
               (:file "utils" :depends-on ("packages"))
               (:file "monoutils" :depends-on ("packages"))
               (:file "assembly-package-generator" :depends-on ("packages" "utils"))
               (:file "package-generator-tests" :depends-on ("utils" "assembly-package-generator"))
               (:file "generator-tests" :depends-on ("package-generator-tests"))))
