;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite -- Naming/Mangling cluster.
;;; Split out of the former package-generator-tests.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :package-generator-tests)

(defun run-naming-tests ()
  (format *error-output* "--- Running Naming/Mangling Tests ---~%")

    ;; 1. Test camel-to-kebab
  (assert-test (assembly-package-generator:camel-to-kebab "System.Console")
                "system-console"
                "Convert System.Console to kebab-case")

  (assert-test (assembly-package-generator:camel-to-kebab "System.Collections.ArrayList")
                "system-collections-array-list"
                "Convert System.Collections.ArrayList to kebab-case")

  (assert-test (assembly-package-generator:camel-to-kebab "camelCase")
                "camel-case"
                "Convert camelCase to kebab-case")

  (assert-test (assembly-package-generator:camel-to-kebab "PascalCase")
                "pascal-case"
                "Convert PascalCase to kebab-case")

  (assert-test (assembly-package-generator:camel-to-kebab "SomeMHTMLMethod")
                "some-mhtml-method"
                "Convert SomeMHTMLMethod to kebab-case")

    ;; 1a. Confirm camel-to-kebab itself leaves '+' untouched: it is also
    ;; applied to already-mapped operator/member names, and AssemblyToLispy.cs
    ;; maps the C# '+' operator (op_Addition) to the literal one-character
    ;; Lisp name "+" upstream, so camel-to-kebab must not corrupt it.
  (assert-test (assembly-package-generator:camel-to-kebab "+")
                "+"
                "camel-to-kebab leaves a bare '+' operator name untouched")

    ;; 1b. Test type-fq-name-to-pkg-name on nested-type CIL names (CIL uses
    ;; '+' as the nested-type separator; it must flatten to '-' the same as
    ;; '.', with no doubled hyphen at the boundary), one/two/three levels deep.
  (assert-test (assembly-package-generator:type-fq-name-to-pkg-name "Microsoft.Xna.Framework.Graphics.SpriteFont+Glyph")
                "microsoft-xna-framework-graphics-sprite-font-glyph"
                "Convert one-level-nested SpriteFont+Glyph to a package name")

  (assert-test (assembly-package-generator:type-fq-name-to-pkg-name "A+B+C")
                "a-b-c"
                "Convert two-level-nested A+B+C to a package name")

  (assert-test (assembly-package-generator:type-fq-name-to-pkg-name "Outer+Middle+Inner+Deepest")
                "outer-middle-inner-deepest"
                "Convert three-level-nested Outer+Middle+Inner+Deepest to a package name")

    ;; 1c. Test type-fq-name-to-pkg-name on open-generic-type backtick arity
    ;; suffixes (a raw backtick in a generated symbol/package name is
    ;; misread by the Lisp reader as the backquote macro character), alone
    ;; and combined with nested-type '+'.
  (assert-test (assembly-package-generator:type-fq-name-to-pkg-name "System.Action`4")
                "system-action-4"
                "Convert generic-arity System.Action`4 to a package name")

  (assert-test (assembly-package-generator:type-fq-name-to-pkg-name "System.Collections.Generic.Dictionary`2")
                "system-collections-generic-dictionary-2"
                "Convert generic-arity Dictionary`2 to a package name")

  (assert-test (assembly-package-generator:type-fq-name-to-pkg-name "System.Collections.Generic.Dictionary`2+KeyCollection")
                "system-collections-generic-dictionary-2-key-collection"
                "Convert a nested type inside a generic type (backtick and '+' together) to a package name")

    ;; 2. Test split-string
  (assert-test (assembly-package-generator:split-string "System.Console;System.Math")
                '("System.Console" "System.Math")
                "Split string by semicolon")

  (assert-test (assembly-package-generator:split-string "System.Console")
                '("System.Console")
                "Split single element string")

  (assert-test (assembly-package-generator:split-string "")
                '("")
                "Split empty string"))
