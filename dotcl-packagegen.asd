;;; Copyright 2026 Douglas P. Fields, Jr.

(defsystem "dotcl-packagegen"
  :description "DotCL C#-assembly-to-Lisp package generator"
  :version "2.41.2"
  :author "Douglas P. Fields, Jr. <symbolics@lisp.engineer>"
  :license "Apache 2.0; Copyright 2026 Douglas P. Fields, Jr."
  :depends-on ("dotnet-class")
  :components ((:file "packages")
               (:file "utils" :depends-on ("packages"))
               (:file "monoutils" :depends-on ("packages"))
               (:file "apg-naming" :depends-on ("packages" "utils"))
               (:file "apg-member-predicates" :depends-on ("apg-naming"))
               (:file "apg-overload-signatures" :depends-on ("apg-naming" "apg-member-predicates"))
               (:file "apg-overload-dispatch" :depends-on ("apg-overload-signatures"))
               (:file "apg-immutability" :depends-on ("apg-naming"))
               (:file "apg-export-mirrors" :depends-on ("apg-overload-dispatch"))
               (:file "apg-class-file-generator" :depends-on ("apg-export-mirrors" "apg-immutability"))
               (:file "apg-batch-discovery" :depends-on ("apg-export-mirrors"))
               (:file "apg-reexports-and-generics" :depends-on ("apg-batch-discovery"))
               (:file "apg-batch-orchestration" :depends-on ("apg-class-file-generator" "apg-reexports-and-generics"))
               (:file "package-generator-tests-support" :depends-on ("utils" "apg-batch-orchestration"))
               (:file "package-generator-tests-naming" :depends-on ("package-generator-tests-support"))
               (:file "package-generator-tests-overload-classification" :depends-on ("package-generator-tests-support"))
               (:file "package-generator-tests-batch-resolution" :depends-on ("package-generator-tests-support"))
               (:file "package-generator-tests-property-field-codegen" :depends-on ("package-generator-tests-support"))
               (:file "package-generator-tests-generic-method-codegen" :depends-on ("package-generator-tests-support"))
               (:file "package-generator-tests-operator-overloads" :depends-on ("package-generator-tests-support"))
               (:file "package-generator-tests-events" :depends-on ("package-generator-tests-support"))
               (:file "package-generator-tests-parents-interfaces" :depends-on ("package-generator-tests-support"))
               (:file "package-generator-tests-defgeneric" :depends-on ("package-generator-tests-support"))
               (:file "package-generator-tests-extension-methods" :depends-on ("package-generator-tests-support"))
               (:file "package-generator-tests-related-discovery" :depends-on ("package-generator-tests-support"))
               (:file "generator-tests" :depends-on ("package-generator-tests-naming"
                                                      "package-generator-tests-overload-classification"
                                                      "package-generator-tests-batch-resolution"
                                                      "package-generator-tests-property-field-codegen"
                                                      "package-generator-tests-generic-method-codegen"
                                                      "package-generator-tests-operator-overloads"
                                                      "package-generator-tests-events"
                                                      "package-generator-tests-parents-interfaces"
                                                      "package-generator-tests-defgeneric"
                                                      "package-generator-tests-extension-methods"
                                                      "package-generator-tests-related-discovery"))))
