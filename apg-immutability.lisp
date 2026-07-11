;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Developed with Antigravity CLI (Gemini 3.5 Flash and 3.1 Pro)
;;;
;;; C# Assembly Lisp Package Generator -- immutable-primitive-type tracking and mutation warnings
;;; Split out of the former assembly-package-generator.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :assembly-package-generator)


(defparameter *immutable-primitive-types*
  '("System.Boolean" "System.Byte" "System.SByte" "System.Int16" "System.UInt16"
    "System.Int32" "System.UInt32" "System.Int64" "System.UInt64" "System.Single"
    "System.Double" "System.Decimal" "System.Char" "System.String" "System.IntPtr"
    "System.UIntPtr")
  "Fully-qualified C# type names with no settable instance state reachable from Lisp,
   safe to cache once in a defconstant with no shared-mutable-state hazard. Deliberately
   a broad allowlist rather than a precise per-type mutability check (see
   immutable-primitive-type-p): this repo has no cross-type metadata available at
   generation time to determine whether some *other* type has settable members, so
   anything not on this list -- including every struct with settable properties/fields,
   e.g. System.Numerics.Vector2 or Microsoft.Xna.Framework.Color -- is treated as
   potentially unsafe to cache, and gets a warning comment (see
   literal-fields/pure-const-fields/pure-const-props generation in generate-class-file).")

(defun immutable-primitive-type-p (type-str)
  "Returns t if TYPE-STR (a field/property's fully-qualified C# type) is a known-safe,
   effectively immutable primitive -- see *immutable-primitive-types*."
  (and type-str (member type-str *immutable-primitive-types* :test #'string=) t))

(defun emit-shared-mutable-constant-warning (stream type-str)
  "Writes a warning comment to STREAM above a defconstant for a field/property of
   TYPE-STR, unless TYPE-STR is a known-safe immutable-primitive-type-p type. A
   defconstant's value form runs exactly once, so this constant is a single boxed .NET
   object shared and re-returned on every reference to it for the life of the program;
   if TYPE-STR is a mutable value type (a struct with settable properties/fields, e.g.
   System.Numerics.Vector2 or Microsoft.Xna.Framework.Color), mutating this object --
   through this constant, or through ANY other Lisp/C# reference that aliases the same
   boxed instance -- permanently corrupts it for every future reference, since the same
   box is shared, not freshly re-fetched the way a define-symbol-macro constant is. See
   FEATURES.md's \"Static Constants and Symbol Macros\" section for the full
   explanation and worked example of this hazard."
  (unless (immutable-primitive-type-p type-str)
    (format stream ";; WARNING: this is a single, permanently-cached boxed .NET object --~%")
    (format stream ";; the defconstant form below only runs once. If ~A is a mutable~%" type-str)
    (format stream ";; value type (struct) with settable properties/fields, mutating this~%")
    (format stream ";; object -- through this binding, or through ANY other reference that~%")
    (format stream ";; aliases the same boxed instance -- permanently corrupts it for every~%")
    (format stream ";; future reference to this constant, for the life of the program.~%")
    (format stream ";; There is currently no supported way to obtain an independent,~%")
    (format stream ";; safely-mutable copy of this value from Lisp; construct a fresh~%")
    (format stream ";; instance via the type's own constructor (new) if you need to mutate~%")
    (format stream ";; a copy. See FEATURES.md's \"Static Constants and Symbol Macros\"~%")
    (format stream ";; section and doc/generator-design-notes.md for the full explanation.~%")))

(defun emit-obj-boxing-mutation-warning (stream)
  "Writes the boxed-obj!-mutation warning comment above a value-type
   instance property/field setf mutator -- a distinct hazard from
   emit-shared-mutable-constant-warning's defconstant-caching warning
   (this one is about obj! itself potentially being an alias of a shared
   value, e.g. a defconstant, at the CALL site, not about caching).
   Previously duplicated verbatim at 3 sites inside generate-class-file's
   instance-property and public-instance-field setf-mutator emission."
  (format stream ";; Note: obj! here is a boxed reference to a .NET value type (struct).~%")
  (format stream ";; This setf mutates that exact boxed instance in place -- it does NOT~%")
  (format stream ";; silently discard the change. However, if obj! is an alias of a shared~%")
  (format stream ";; or cached value (e.g. a constant defined via defconstant), this mutates~%")
  (format stream ";; that shared instance for every other reference to it too. See~%")
  (format stream ";; FEATURES.md's \"Struct Boxing Caveat\" section for details.~%"))
