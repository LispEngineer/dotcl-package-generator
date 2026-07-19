;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Developed with Antigravity CLI (Gemini 3.5 Flash and 3.1 Pro)
;;;
;;; C# Assembly Lisp Package Generator -- generate-class-file driver and its emit-* section helpers
;;; Split out of the former assembly-package-generator.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :assembly-package-generator)


(defun emit-class-file-header (stream fq-name pkg-name creation-time &optional options-line discovered-via class-plist)
  "Writes the generated-file header comment block and the cl:in-package
   preamble (the defpackage itself lives in packages.lisp, emitted
   separately by generate-batch-packages-file). OPTIONS-LINE
   (format-class-options-line) and DISCOVERED-VIA (nil for an explicitly-
   requested class) record this class's own effective per-class flags and
   discovery provenance, so a generated file is self-describing even in
   isolation (doc/plan-fable-detail-07.md). CLASS-PLIST, when supplied and
   itself :obsolete (doc/plan-fable-detail-16.md), adds its own
   obsolete-docstring-line as a \";;; OBSOLETE...\" comment line -- type-
   level obsolete is visibility only, same as every member-level one; the
   type is still fully generated."
  (format stream ";;; Generated automatically. Do not edit.~%")
  (format stream ";;; Class: ~A~%" fq-name)
  (format stream ";;; Generator Version: ~D~%" *generator-version*)
  (format stream ";;; Creation Date: ~A~%" creation-time)
  (when options-line
    (format stream ";;; Options: ~A~%" options-line))
  (when discovered-via
    (format stream ";;; Discovered via: ~A~%" discovered-via))
  (when (and class-plist (getf class-plist :obsolete))
    (format stream ";;; ~A" (obsolete-docstring-line class-plist)))
  (format stream "~%(cl:in-package :~A)~%~%" pkg-name))

(defun emit-type-constants-and-clos-registration (stream fq-name creation-time ensure-type)
  "Writes the <type>/<type-str>/<creation>/<version> constants, plus the
   CLOS type-registration eval-when block when ENSURE-TYPE is non-nil.

   <type> is a define-symbol-macro, not a defconstant: resolving a C# type
   via dotnet:resolve-type must happen where the generated package is
   actually LOADED (or its symbol-macro expansion actually USED), not
   wherever its containing .asd's fasl happens to be loaded -- an ASDF
   :depends-on consumer's build process loads a dependency's fasl before
   the target assembly is necessarily in scope, so a defconstant's
   load-time-evaluated init-form can fail there even though the same call
   succeeds once the deployed app actually runs (DotCL.Runtime >= 0.1.17's
   resolve-type auto-loads assemblies from AppContext.BaseDirectory on a
   miss, and memoizes the result after first expansion, so this costs
   nothing after first use). See dotcl/dotcl#49 and
   doc/generator-design-notes.md's Version 42 section.

   The CLOS registration eval-when (ENSURE-TYPE, --ensure-type/
   --no-ensure-type, OFF by default) calls dotnet:static \"DotCL.Runtime\"
   \"EnsureDotNetTypeClass\" eagerly at package-load time. class-of/typep
   on any wrapped .NET object, and dotnet:class-for-type (what
   --defgeneric's generated defmethods use), already lazily register a
   type's CLOS class themselves on first real need -- nothing this
   generator itself emits actually requires this eager call. Its only
   remaining purpose is controlling REGISTRATION ORDER: when two .NET
   types share a simple name across different namespaces, whichever gets
   registered first keeps the friendly dotcl-internal::|Name| CLOS class
   symbol (the other falls back to its assembly-qualified name, with a
   console warning -- DotCL.Runtime >= 0.1.17/dotcl/dotcl#50 -- not a
   silently-shared misdispatching class the way pre-0.1.17 DotCL behaved).
   Eager, generation-order-based registration makes that outcome
   deterministic and reproducible; without it, the winner depends on
   whichever type the running program happens to touch first. This only
   matters for hand-written user code that dispatches via the simple-name
   pattern documented in doc/generator-design-notes.md's \".NET CLOS
   Integration\" section -- --defgeneric is unaffected either way, since
   it dispatches via class-for-type on the exact fully-qualified name. See
   doc/generator-design-notes.md's Version 44 section. When emitted, this
   eval-when is restricted to :load-toplevel/:execute (no :compile-toplevel)
   for the same ASDF-dependency-phase reason as <type> itself -- forcing
   EnsureDotNetTypeClass's own resolve-type call during a dependency's
   compile phase would reintroduce the identical failure."
  (format stream "(cl:define-symbol-macro <type> (dotnet:resolve-type \"~A\"))~%" fq-name)
  (format stream "(cl:defconstant <type-str> \"~A\")~%" fq-name)
  (format stream "(cl:defconstant <creation> \"~A\")~%" creation-time)
  (format stream "(cl:defconstant <version> ~D)~%~%" *generator-version*)
  (when ensure-type
    (format stream ";; Register C# Type with CLOS~%")
    (format stream "(cl:eval-when (:load-toplevel :execute)~%")
    (format stream "  (dotnet:static \"DotCL.Runtime\" \"EnsureDotNetTypeClass\"~%")
    (format stream "                 (dotnet:resolve-type \"~A\")))~%~%" fq-name)))

(defun emit-constructors (stream fq-name clean-ctors dirty-ctors)
  "Writes the 3-way dirty/single-clean/multi-clean constructor dispatch."
  (let ((clean-ctor-count (length clean-ctors))
        (dirty-ctor-count (length dirty-ctors)))
    (cond
      ;; Case 1: No clean constructors - all are dirty
      ((and (> dirty-ctor-count 0) (= clean-ctor-count 0))
       (format stream ";; The following C# ~A constructors have special parameter types~%" fq-name)
       (format stream ";; (ref, out, or params) and are not yet supported:~%")
       (dolist (dc dirty-ctors)
         (format stream ";;   ~A~%" (constructor-signature-str dc)))
       (format stream "~%"))

      ;; Case 2: Single clean constructor with no usable-default parameter
      ;; (complex-group-p is nil -- a plain positional defun suffices; a
      ;; usable default falls through to Case 3's Master Wrapper below,
      ;; since a plain defun has no way to make a parameter optional).
      ((and (= clean-ctor-count 1) (not (complex-group-p clean-ctors)))
       (let* ((c (first clean-ctors))
              (c-doc (getf c :documentation))
              (summary (getf c-doc :summary))
              (returns (getf c-doc :returns))
              (params (getf c :parameters))
              (param-names (mapcar (lambda (p) (map-param-name (getf p :name))) params))
              (args-str (format nil "~{~A~^ ~}" param-names))
              (docstring (build-docstring summary returns params c-doc c))
              (escaped-docstring (escape-lisp-string docstring)))
         (format stream "(cl:defun new (~A)~%" args-str)
         (when (> (length escaped-docstring) 0)
           (format stream "  \"~A\"~%" escaped-docstring))
         (format stream "  (dotnet:new <type-str>~@[ ~{~A~^ ~}~]))~%~%" param-names)
         ;; Emit dirty constructor doc-comments if any
         (when (> dirty-ctor-count 0)
           (format stream ";; Note: ~A also has the following constructors with special~%" fq-name)
           (format stream ";; parameter types (ref, out, or params) that are not~%")
           (format stream ";; yet supported:~%")
           (dolist (dc dirty-ctors)
             (format stream ";;   ~A~%" (constructor-signature-str dc)))
           (format stream "~%"))))

      ;; Case 3: Multiple clean constructors, or a single clean constructor
      ;; with a usable-default parameter (needs the Master Wrapper's
      ;; &optional/&key dispatch to make that parameter optional).
      ((or (>= clean-ctor-count 2)
           (and (= clean-ctor-count 1) (complex-group-p clean-ctors)))
       ;; Generate a single Master Wrapper 'new' dispatching precisely
       ;; across every clean constructor overload.
       (generate-constructor-master-wrapper stream clean-ctors fq-name)
       ;; Emit dirty constructor doc-comments if any
       (when (> dirty-ctor-count 0)
         (format stream ";; Note: ~A also has the following constructors with special~%" fq-name)
         (format stream ";; parameter types (ref, out, or params) that are not~%")
         (format stream ";; yet supported:~%")
         (dolist (dc dirty-ctors)
           (format stream ";;   ~A~%" (constructor-signature-str dc)))
         (format stream "~%"))))))

(defun emit-memoized-constant-binding (stream cname member-name doc-str)
  "Writes a private cache cl:defvar plus a memoizing cl:define-symbol-macro
   binding CNAME to (dotnet:static <type-str> MEMBER-NAME): the dotnet:static
   call runs lazily on first use, never at load time -- fixes
   dotcl/dotcl#49 for these bindings the same way <type> itself was fixed
   (emit-type-constants-and-clos-registration) -- and is cached in a
   private %<name>-cache% variable thereafter, matching cl:defconstant's
   original run-once-then-reuse behavior, including its existing
   shared-boxed-instance aliasing hazard (see
   emit-shared-mutable-constant-warning, still called by every caller of
   this function, unchanged). %<name>-cache%'s '%' earmuffs can never
   collide with a mapped C# member name (C# cannot produce '%' in an
   identifier), the same collision-proofing trick as obj!/quote!, so it is
   safe to leave unexported. See doc/generator-design-notes.md's Version 43
   section. DOC-STR, if non-empty, is attached as CNAME's 'cl:variable
   documentation, exactly as before."
  (let ((cache-var (format nil "%~A-cache%" (string-trim "+" cname))))
    (format stream "(cl:defvar ~A csharp-assembly-utils:+unbound-marker+)~%" cache-var)
    (format stream "(cl:define-symbol-macro ~A~%" cname)
    (format stream "  (cl:if (cl:eq ~A csharp-assembly-utils:+unbound-marker+)~%" cache-var)
    (format stream "      (cl:setf ~A (dotnet:static <type-str> \"~A\"))~%" cache-var member-name)
    (format stream "      ~A))~%" cache-var))
  (if (> (length doc-str) 0)
      (format stream "(cl:setf (cl:documentation (cl:quote ~A) (cl:quote cl:variable)) \"~A\")~%~%" cname doc-str)
      (format stream "~%")))

(defun member-doc-str (member-plist)
  "Returns MEMBER-PLIST's (a field/property/event plist) escaped docstring
   text: obsolete-docstring-line's own leading \"OBSOLETE...\" line (doc/
   plan-fable-detail-16.md), if any, followed by its XML-doc :summary, if
   any -- the shared doc-str computation every plain (non-overload-
   dispatching) property/field/event emit-* helper below uses, factored
   out so each no longer separately re-derives \"(x-doc ...) (doc-str (if
   x-doc (escape-lisp-string x-doc) \"\"))\"."
  (let* ((summary (getf (getf member-plist :documentation) :summary))
         (raw (format nil "~A~A" (obsolete-docstring-line member-plist) (or summary ""))))
    (if (> (length raw) 0) (escape-lisp-string raw) "")))

(defun emit-literal-field-constants (stream literal-fields)
  "Writes memoized-symbol-macro bindings (see emit-memoized-constant-binding)
   for compile-time literal fields."
  (dolist (f literal-fields)
    (let* ((cname (format nil "+~A+" (camel-to-kebab (getf f :name))))
           (doc-str (member-doc-str f)))
      (emit-shared-mutable-constant-warning stream (getf f :type))
      (emit-memoized-constant-binding stream cname (getf f :name) doc-str))))

(defun emit-readonly-fields (stream pure-const-fields dynamic-const-fields)
  "Writes runtime-readonly fields: pure-const-fields as memoized
   symbol-macros (see emit-memoized-constant-binding), dynamic-const-fields
   as plain (re-evaluated) define-symbol-macros."
  ;; Runtime Read-Only Fields (Constants)
  (dolist (f pure-const-fields)
    (let* ((cname (format nil "+~A+" (camel-to-kebab (getf f :name))))
           (doc-str (member-doc-str f)))
      (emit-shared-mutable-constant-warning stream (getf f :type))
      (emit-memoized-constant-binding stream cname (getf f :name) doc-str)))

  ;; Runtime Read-Only Fields (Dynamic)
  (dolist (f dynamic-const-fields)
    (let* ((cname (map-member-name (getf f :name)))
           (doc-str (member-doc-str f)))
      (format stream "(cl:define-symbol-macro ~A (dotnet:static <type-str> \"~A\"))~%" cname (getf f :name))
      (if (> (length doc-str) 0)
          (format stream "(cl:setf (cl:documentation (cl:quote ~A) (cl:quote cl:variable)) \"~A\")~%~%" cname doc-str)
          (format stream "~%")))))

(defun emit-static-properties (stream pure-const-props dynamic-const-props writeable-static-props)
  "Writes static properties: pure-const-props as memoized symbol-macros
   (see emit-memoized-constant-binding), dynamic-const-props as plain
   (re-evaluated) define-symbol-macros, writeable-static-props as
   getter/setter defuns."
  ;; Runtime Read-Only Properties
  ;; Pure Constant Properties
  (dolist (p pure-const-props)
    (let* ((cname (format nil "+~A+" (camel-to-kebab (getf p :name))))
           (doc-str (member-doc-str p)))
      (emit-shared-mutable-constant-warning stream (getf p :type))
      (emit-memoized-constant-binding stream cname (getf p :name) doc-str)))

  ;; Runtime Read-Only Properties
  (dolist (p dynamic-const-props)
    (let* ((cname (map-member-name (getf p :name)))
           (doc-str (member-doc-str p)))
      (format stream "(cl:define-symbol-macro ~A (dotnet:static <type-str> \"~A\"))~%" cname (getf p :name))
      (if (> (length doc-str) 0)
          (format stream "(cl:setf (cl:documentation (cl:quote ~A) (cl:quote cl:variable)) \"~A\")~%~%" cname doc-str)
          (format stream "~%"))))

  ;; Writeable Static Properties (read-write or write-only): unlike
  ;; instance properties, there is no obj! receiver to alias, so no
  ;; struct-boxing-mutation warning is needed here -- setf reassigns
  ;; the type's own static storage slot directly.
  (dolist (p writeable-static-props)
    (let* ((pname (map-member-name (getf p :name)))
           (readable (getf p :readable))
           (doc-str (member-doc-str p)))
      (when readable
        (format stream "(cl:defun ~A ()~%" (safe-symbol-token pname))
        (when (> (length doc-str) 0)
          (format stream "  \"~A\"~%" doc-str))
        (format stream "  (dotnet:static <type-str> \"~A\"))~%~%" (getf p :name)))
      (if readable
          (progn
            (format stream "(cl:defun (cl:setf ~A) (new-value)~%" (safe-symbol-token pname))
            (when (> (length doc-str) 0)
              (format stream "  \"~A\"~%" doc-str))
            (format stream "  (cl:setf (dotnet:static <type-str> \"~A\") new-value))~%~%" (getf p :name)))
          (progn
            (format stream "(cl:defun set-~A (new-value)~%" pname)
            (when (> (length doc-str) 0)
              (format stream "  \"~A\"~%" doc-str))
            (format stream "  (cl:setf (dotnet:static <type-str> \"~A\") new-value))~%~%" (getf p :name)))))))

(defun emit-instance-properties (stream fq-name instance-prop-groups is-value-type-p)
  "Writes instance properties/indexers (C#'s this[...], which carry their
   own index :parameters just like a method does)."
  (dolist (group instance-prop-groups)
    (let ((props (cdr group)))
      (if (> (length props) 1)
          ;; An indexer overloaded across multiple index-parameter
          ;; signatures (e.g. this[int] and this[string]) is not yet
          ;; supported; document the signatures instead of guessing
          ;; which one a single generated function should dispatch to.
          (progn
            (format stream ";; Note: ~A's indexer ~S has multiple overloaded signatures,~%" fq-name (getf (first props) :name))
            (format stream ";; which are not yet supported:~%")
            (dolist (dp props)
              (format stream ";;   ~A~%" (property-signature-str dp)))
            (format stream "~%"))
          (let* ((p (first props))
                 (pname (map-member-name (getf p :name)))
                 (readable (getf p :readable))
                 (writeable (getf p :writeable))
                 (get-method (getf p :get-method))
                 (set-method (getf p :set-method))
                 (index-params (getf p :parameters))
                 (index-param-names (mapcar (lambda (ip) (map-param-name (getf ip :name))) index-params))
                 (doc-str (member-doc-str p)))
            (when readable
              (format stream "(cl:defun ~A (obj!~@[ ~{~A~^ ~}~])~%" (safe-symbol-token pname) index-param-names)
              (when (> (length doc-str) 0)
                (format stream "  \"~A\"~%" doc-str))
              (format stream "  (dotnet:invoke (cl:the (dotnet \"~A\") obj!) \"~A\"~@[ ~{~A~^ ~}~]))~%~%" fq-name get-method index-param-names))
            (when writeable
              (if readable
                  (progn
                    (when is-value-type-p (emit-obj-boxing-mutation-warning stream))
                    (format stream "(cl:defun (cl:setf ~A) (new-value obj!~@[ ~{~A~^ ~}~])~%" (safe-symbol-token pname) index-param-names)
                    (when (> (length doc-str) 0)
                      (format stream "  \"~A\"~%" doc-str))
                    (format stream "  (dotnet:invoke (cl:the (dotnet \"~A\") obj!) \"~A\"~@[ ~{~A~^ ~}~] new-value))~%~%" fq-name set-method index-param-names))
                  (progn
                    (when is-value-type-p (emit-obj-boxing-mutation-warning stream))
                    (format stream "(cl:defun set-~A (obj!~@[ ~{~A~^ ~}~] new-value)~%" pname index-param-names)
                    (when (> (length doc-str) 0)
                      (format stream "  \"~A\"~%" doc-str))
                    (format stream "  (dotnet:invoke (cl:the (dotnet \"~A\") obj!) \"~A\"~@[ ~{~A~^ ~}~] new-value))~%~%" fq-name set-method index-param-names))))))))
  nil)

(defun emit-instance-events (stream fq-name instance-events classification)
  "Writes add-X/remove-X wrapper pairs for CLASS-PLIST's instance events.
   CLASSIFICATION is used to compute the non-event taken-names set
   (class-member-names-excluding-events) that event-wrapper-names'
   collision escalation is checked against; each event's chosen names are
   folded back into that accumulator (locally, via ALL-OTHER-NAMES) as
   they're resolved, so a second colliding event in this same class
   disambiguates against the first one too, not just against non-event
   members. Returns the final accumulated name list (not currently
   consumed by any caller, but kept explicit rather than left as a free
   variable)."
  (let ((all-other-names (class-member-names-excluding-events classification)))
    (dolist (e instance-events)
      (multiple-value-bind (add-name remove-name)
          (event-wrapper-names (getf e :name) all-other-names)
        (push add-name all-other-names)
        (push remove-name all-other-names)
        (let* ((doc-str (member-doc-str e)))
          (format stream "(cl:defun ~A (obj! handler)~%" (safe-symbol-token add-name))
          (when (> (length doc-str) 0)
            (format stream "  \"~A\"~%" doc-str))
          (format stream "  (dotnet:add-event (cl:the (dotnet \"~A\") obj!) \"~A\" handler))~%~%" fq-name (getf e :name))
          (format stream "(cl:defun ~A (obj! handler)~%" (safe-symbol-token remove-name))
          (format stream "  \"Pass the exact same HANDLER object given to ~A -- removal is by identity, not by behavioral equivalence.\"~%" add-name)
          (format stream "  (dotnet:remove-event (cl:the (dotnet \"~A\") obj!) \"~A\" handler))~%~%" fq-name (getf e :name)))))
    all-other-names))

(defun emit-public-instance-fields (stream fq-name instance-fields is-value-type-p)
  "Writes getter/setter defuns for public instance fields. Unlike
   properties (which have named get_Foo/set_Foo accessor methods to
   invoke), a field has no accessor method at all -- dotnet:invoke's
   BindingFlags.GetField lets it read a field by name directly, but there
   is no equivalent SetField-only invoke; the idiomatic DotCL way to write
   a field is the setf-expansion of dotnet:invoke itself (see
   doc/dotnet-dotcl-interop.md), which is what the setter below uses."
  (dolist (f instance-fields)
    (let* ((fname (map-member-name (getf f :name)))
           (writeable (not (getf f :init-only)))
           (doc-str (member-doc-str f)))
      (format stream "(cl:defun ~A (obj!)~%" (safe-symbol-token fname))
      (when (> (length doc-str) 0)
        (format stream "  \"~A\"~%" doc-str))
      (format stream "  (dotnet:invoke (cl:the (dotnet \"~A\") obj!) \"~A\"))~%~%" fq-name (getf f :name))
      (when writeable
        (when is-value-type-p (emit-obj-boxing-mutation-warning stream))
        (format stream "(cl:defun (cl:setf ~A) (new-value obj!)~%" (safe-symbol-token fname))
        (when (> (length doc-str) 0)
          (format stream "  \"~A\"~%" doc-str))
        (format stream "  (cl:setf (dotnet:invoke (cl:the (dotnet \"~A\") obj!) \"~A\") new-value))~%~%" fq-name (getf f :name))))))

(defun emit-mutable-static-fields (stream mutable-static-fields)
  "Writes getter/setter defuns for plain mutable static fields (not
   readonly, not const): mirrors the writeable-static-property shape,
   since a static field has no obj! receiver either -- dotnet:static's
   setf-expansion writes the type's own static storage slot directly."
  (dolist (f mutable-static-fields)
    (let* ((fname (map-member-name (getf f :name)))
           (doc-str (member-doc-str f)))
      (format stream "(cl:defun ~A ()~%" (safe-symbol-token fname))
      (when (> (length doc-str) 0)
        (format stream "  \"~A\"~%" doc-str))
      (format stream "  (dotnet:static <type-str> \"~A\"))~%~%" (getf f :name))
      (format stream "(cl:defun (cl:setf ~A) (new-value)~%" (safe-symbol-token fname))
      (when (> (length doc-str) 0)
        (format stream "  \"~A\"~%" doc-str))
      (format stream "  (cl:setf (dotnet:static <type-str> \"~A\") new-value))~%~%" (getf f :name)))))

(defun emit-methods (stream fq-name method-groups)
  "Writes per-method-group dirty/clean overload dispatch."
  (dolist (group method-groups)
    (let* ((name (car group))
           (group-methods (cdr group))
           (clean-methods (remove-if-not #'clean-method-p group-methods))
           (dirty-methods (remove-if-not #'dirty-method-p group-methods))
           (clean-count (length clean-methods))
           (dirty-count (length dirty-methods))
           (kebab-name (map-member-name name))
           (static-clean (remove-if-not (lambda (m) (getf m :is-static)) clean-methods))
           (instance-clean (remove-if-not (lambda (m) (not (getf m :is-static))) clean-methods))
           (static-count (length static-clean))
           (instance-count (length instance-clean))
           (mixed-mode-p (and (> static-count 0) (> instance-count 0))))

      (cond
        ;; Case 1: No clean overloads - all are dirty (ref/ref-readonly/params
        ;; -- an :out-only overload is no longer dirty, see out-method-groups)
        ((= clean-count 0)
         (format stream ";; The following C# ~A.~A overloads have special parameter types~%" fq-name name)
         (format stream ";; (ref or params) and are not yet supported:~%")
         (dolist (dm dirty-methods)
           (format stream ";;   ~A~%" (method-signature-str dm)))
         (format stream "~%"))

        ;; Case 2: Clean overloads exist
        (t
         (cl:cond
           (mixed-mode-p
            ;; Mixed-Mode: instance name is kebab-name, static name is kebab-name*
            ;; (each further split into per-generic-arity-cell functions
            ;; by generate-method-name-wrappers when needed)
            (cl:let ((static-kebab-name (concatenate 'string kebab-name "*")))
              (generate-method-name-wrappers stream instance-clean name kebab-name fq-name nil)
              (generate-method-name-wrappers stream static-clean name static-kebab-name fq-name t)))
           (t
            ;; Single-Mode: name is kebab-name
            (cl:cond
              ((> static-count 0)
               (generate-method-name-wrappers stream static-clean name kebab-name fq-name t))
              ((> instance-count 0)
               (generate-method-name-wrappers stream instance-clean name kebab-name fq-name nil)))))

         ;; Emit dirty overload doc-comment if any
         (when (> dirty-count 0)
           (format stream ";; Note: ~A.~A also has the following overloads with special~%" fq-name name)
           (format stream ";; parameter types (ref or params) that are not~%")
           (format stream ";; yet supported:~%")
           (dolist (dm dirty-methods)
             (format stream ";;   ~A~%" (method-signature-str dm)))
           (format stream "~%")))))))

(defun emit-out-methods (stream fq-name out-method-groups method-groups)
  "Writes wrapper(s) for out-only method groups (cmc-out-method-groups --
   doc/plan-fable-detail-05.md): a C# method whose only special parameter
   modifier is :out gets a real wrapper here, forwarding to dotnet:call-out/
   dotnet:call-out-generic, with the out parameter(s) returned as additional
   cl:values results instead of appearing in the wrapper's own lambda list.
   Naming mirrors emit-methods' own static/instance split under one C#
   name (static gets a trailing '*', but only when BOTH static and instance
   out-only overloads share this name -- mixed-mode-p, exactly like clean
   methods), and each wrapper's base name additionally gets a '/out' suffix
   whenever a CLEAN overload of the same name/mode already exists in
   METHOD-GROUPS (cmc-method-groups), so e.g. Parse (clean) and Parse/out
   (out-only) can coexist without colliding -- see out-method-wrapper-name."
  (dolist (group out-method-groups)
    (let* ((name (car group))
           (out-methods (cdr group))
           (static-out (remove-if-not (lambda (m) (getf m :is-static)) out-methods))
           (instance-out (remove-if-not (lambda (m) (not (getf m :is-static))) out-methods))
           (mixed-mode-p (and static-out instance-out)))
      (when instance-out
        (generate-out-method-name-wrappers stream instance-out name
                                            (out-method-wrapper-name name nil mixed-mode-p method-groups)
                                            fq-name nil))
      (when static-out
        (generate-out-method-name-wrappers stream static-out name
                                            (out-method-wrapper-name name t mixed-mode-p method-groups)
                                            fq-name t)))))

(defun emit-extension-methods (stream fq-name matched-extensions skipped-extensions)
  "Writes injected extension-method wrappers/skip-comments (Version 38 --
   see doc/plan-v38.md). Both arguments are nil unless this class opted
   into --extension-methods."
  (when (or matched-extensions skipped-extensions)
    (format stream ";; Extension methods (exact match on this == ~A):~%" fq-name)
    (dolist (skip skipped-extensions)
      (destructuring-bind (m holder-plist reason) skip
        (let ((reason-str
                (cond
                  ((eq reason :dirty)
                   "special parameter types (ref/out/params/default) not yet supported")
                  ((eq reason :generic)
                   "generic type arguments/parameters not yet supported")
                  ((eq reason :own)
                   "this class already declares its own member of this name")
                  ((and (consp reason) (eq (first reason) :ambiguous))
                   (format nil "ambiguous -- more than one extension method maps to Lisp name ~A"
                           (second reason)))
                  (t "not supported"))))
          (format stream ";;   ~A::~A -- skipped (~A)~%"
                  (getf holder-plist :fully-qualified-name) (method-signature-str m) reason-str))))
    (dolist (surv matched-extensions)
      (destructuring-bind (m holder-plist holder-assembly) surv
        (let* ((holder-fq (getf holder-plist :fully-qualified-name))
               (mname (map-member-name (getf m :name)))
               (dotnet-method-name (or (getf m :mangled-name) (getf m :name)))
               (params (rest (getf m :parameters)))
               (param-names (mapcar (lambda (p) (map-param-name (getf p :name))) params))
               (m-doc (getf m :documentation))
               (summary (getf m-doc :summary))
               (returns (getf m-doc :returns))
               (docstring (with-output-to-string (out)
                            (format out "Extension method from ~A (assembly ~A)."
                                    holder-fq (or holder-assembly "?"))
                            (let ((body (build-docstring summary returns params m-doc m)))
                              (when (> (length body) 0)
                                (format out "~%~A" body)))))
               (escaped-docstring (escape-lisp-string docstring)))
          (format stream "(cl:defun ~A (obj!~@[ ~{~A~^ ~}~])~%" (safe-symbol-token mname) param-names)
          (when (> (length escaped-docstring) 0)
            (format stream "  \"~A\"~%" escaped-docstring))
          (format stream "  (dotnet:static \"~A\" \"~A\" obj!~@[ ~{~A~^ ~}~]))~%~%"
                  holder-fq dotnet-method-name param-names))))
    (format stream "~%")))

(defun generate-class-file (class-plist output-dir &optional constant-properties-list creation-time
                                                       matched-extensions skipped-extensions
                                                       ensure-type options-line discovered-via)
  "Generates the Lisp source file for a single class plist.
   CREATION-TIME, if supplied, is used verbatim as the file's creation-date
   stamp (so a batch of files generated in one run can share a single
   timestamp); otherwise a fresh timestamp is computed. MATCHED-EXTENSIONS
   and SKIPPED-EXTENSIONS (both from compute-matched-extensions-for-class,
   nil unless this class opted into --extension-methods -- Version 38,
   doc/plan-v38.md) are, respectively, the surviving (method-plist
   holder-plist holder-assembly-name) entries to emit as obj!-first
   wrappers, and the (method-plist holder-plist reason) entries to instead
   document with a skip comment. ENSURE-TYPE (nil unless this class opted
   into --ensure-type -- Version 44) controls whether
   emit-type-constants-and-clos-registration emits the \"Register C# Type
   with CLOS\" eval-when at all. OPTIONS-LINE (format-class-options-line)
   and DISCOVERED-VIA (this resolved-class's own :discovered-via) are
   passed straight through to emit-class-file-header's own \";;; Options:\"/
   \";;; Discovered via:\" comment lines (doc/plan-fable-detail-07.md).
   Driver: classifies CLASS-PLIST's members once (classify-class-members)
   and calls the emit-* section helpers in file order."
  (let* ((fq-name (getf class-plist :fully-qualified-name))
         (pkg-name (type-fq-name-to-pkg-name fq-name))
         (output-file (merge-pathnames (make-pathname :name pkg-name :type "lisp")
                                       (pathname (concatenate 'string output-dir "/"))))
         (kind (getf class-plist :kind))
         (is-value-type-p (or (eq kind :struct) (eq kind :enum)))
         (creation-time (or creation-time (get-iso-8601-time))))

    (ensure-directories-exist output-file :verbose t)

    (let ((classification (classify-class-members class-plist constant-properties-list)))
      (with-open-file (stream output-file :direction :output :if-exists :supersede :if-does-not-exist :create)
        (emit-class-file-header stream fq-name pkg-name creation-time options-line discovered-via class-plist)
        (emit-type-constants-and-clos-registration stream fq-name creation-time ensure-type)
        (emit-constructors stream fq-name (cmc-clean-ctors classification) (cmc-dirty-ctors classification))
        (emit-literal-field-constants stream (cmc-literal-fields classification))
        (emit-readonly-fields stream (cmc-pure-const-fields classification) (cmc-dynamic-const-fields classification))
        (emit-static-properties stream (cmc-pure-const-props classification) (cmc-dynamic-const-props classification)
                                 (cmc-writeable-static-props classification))
        (emit-instance-properties stream fq-name (cmc-instance-prop-groups classification) is-value-type-p)
        (emit-instance-events stream fq-name (cmc-instance-events classification) classification)
        (emit-public-instance-fields stream fq-name (cmc-instance-fields classification) is-value-type-p)
        (emit-mutable-static-fields stream (cmc-mutable-static-fields classification))
        (emit-methods stream fq-name (cmc-method-groups classification))
        (emit-out-methods stream fq-name (cmc-out-method-groups classification) (cmc-method-groups classification))
        (emit-extension-methods stream fq-name matched-extensions skipped-extensions)))))
