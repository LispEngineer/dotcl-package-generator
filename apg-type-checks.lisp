;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Developed with Antigravity CLI (Gemini 3.5 Flash and 3.1 Pro)
;;;
;;; C# Assembly Lisp Package Generator -- runtime type-check/guard-string generation
;;; Split out of apg-overload-dispatch.lisp (pure internal reorganization,
;;; doc/plan-fable-detail-09.md; see doc/generator-design-notes.md).

(in-package :assembly-package-generator)


(defun resolvable-type-name-for-check (p &optional (type-key :type) (nullable-key :nullable-underlying-type) (aq-key :assembly-qualified-type))
  "Returns the type-name string a runtime type check/hint against parameter
   (or return-value) plist P should actually resolve, preferring, in order:
   NULLABLE-KEY (P's :nullable-underlying-type -- present only for a closed
   Nullable<T>, whose own name is never a usable check target: a boxed
   Nullable<T> with HasValue==true is never anything but a boxed T, so
   Type.IsInstanceOfType against Nullable<T> itself can never be true, no
   matter how its name resolves -- see
   doc/bug-in-nullable-value-type-dispatch.md); then AQ-KEY (P's
   :assembly-qualified-type -- present for any closed generic type, whose
   plain friendly :type name can fail to resolve at all when a type argument
   lives in a different assembly than the generic definition, e.g.
   System.Nullable`1[Some.Other.Assembly.Foo]); then TYPE-KEY (P's plain
   :type) as the final fallback. TYPE-KEY/NULLABLE-KEY/AQ-KEY are overridable
   for the :return-type family (:nullable-underlying-return-type/
   :assembly-qualified-return-type)."
  (or (getf p nullable-key) (getf p aq-key) (getf p type-key)))

(defparameter *numeric-primitive-check-types*
  '("System.Double" "System.Single" "System.Int32" "System.Int64" "System.Int16" "System.Byte" "System.Decimal")
  "Parameter type names format-param-type-check checks with a bare cl:numberp,
   never wrapped in a (cl:or (cl:null ...) ...) unless the parameter is itself
   a closed Nullable<T> -- an ordinary (non-nullable) System.Int32 etc. can
   never actually be C# null at runtime, so no null-tolerance is needed for
   it. Shared between format-param-type-check's branch dispatch and its
   nullable-wrapping decision so the two can never disagree on which types
   count as 'bare primitive.'")

(defun format-param-type-check (p arg-str)
  "Returns a Lisp type checking expression string for parameter plist P.
   Unwraps a closed Nullable<T> to T first (resolvable-type-name-for-check),
   since T -- never Nullable<T> itself -- is P's only possible non-null
   runtime type; only then dispatches on that effective type name exactly as
   before. The fallback branch (any effective type but the numeric
   primitives, Boolean, or String) uses dotnet:is-instance-of (DotCL >=
   0.1.18, dotcl/dotcl#45) to check ARG-STR is actually an instance of that
   type specifically, rather than merely 'is some wrapped .NET object at
   all' -- the latter can't distinguish two overloads differing only by a
   non-primitive parameter type (e.g. Song vs. SongCollection) at the same
   position; see doc/bug-in-dispatching.md and
   doc/bug-in-nullable-value-type-dispatch.md -- and already null-tolerant
   unconditionally, matching a reference type's own real C# nullability.
   The three bare-primitive branches (numeric/Boolean/String), by contrast,
   never null-guard by default, since an ordinary (non-nullable) primitive
   parameter can never actually be C# null -- but when P was itself a closed
   Nullable<T> (e.g. int?/bool?), the unwrapped EFFECTIVE-TYPE can land in
   one of these branches while the argument genuinely can still be null
   (HasValue == false), so that case gets the same null-tolerant wrapping the
   fallback branch always has."
  (let* ((nullable-p (and (getf p :nullable-underlying-type) t))
         (effective-type (resolvable-type-name-for-check p))
         (bare-check
           (cond
             ((member effective-type *numeric-primitive-check-types* :test #'string=)
              (format nil "(cl:numberp ~A)" arg-str))
             ((string= effective-type "System.Boolean")
              (format nil "(cl:typep ~A 'cl:boolean)" arg-str))
             ((string= effective-type "System.String")
              (format nil "(cl:stringp ~A)" arg-str))
             (t nil))))
    (cond
      ((and bare-check nullable-p)
       (format nil "(cl:or (cl:null ~A) ~A)" arg-str bare-check))
      (bare-check bare-check)
      (t
       (format nil "(cl:or (cl:null ~A) (dotnet:is-instance-of ~A ~S))" arg-str arg-str effective-type)))))
