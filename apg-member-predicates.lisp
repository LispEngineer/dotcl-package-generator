;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Developed with Antigravity CLI (Gemini 3.5 Flash and 3.1 Pro)
;;;
;;; C# Assembly Lisp Package Generator -- member-classification predicates and classify-class-members
;;; Split out of the former assembly-package-generator.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :assembly-package-generator)


(defun literal-field-p (field)
  "Checks if a field plist defines a static literal/constant field."
  (and (getf field :static)
       (getf field :literal)))

(defun runtime-readonly-field-p (field)
  "Checks if a field plist defines a static init-only field that is not literal."
  (and (getf field :static)
       (getf field :init-only)
       (not (getf field :literal))))

(defun constant-property-p (prop)
  "Checks if a property plist defines a static read-only property."
  (and (getf prop :static)
       (getf prop :readable)
       (not (getf prop :writeable))))

(defun writeable-static-property-p (prop)
  "Checks if a property plist defines a static writeable (read-write or
   write-only) property. Disjoint from constant-property-p, which requires
   the property to NOT be writeable."
  (and (getf prop :static)
       (getf prop :writeable)))

(defun mutable-static-field-p (field)
  "Checks if a field plist defines a plain mutable static field: static,
   but neither a compile-time literal/const (literal-field-p) nor a
   runtime-readonly field (runtime-readonly-field-p)."
  (and (getf field :static)
       (not (getf field :literal))
       (not (getf field :init-only))))

(defun instance-property-p (prop)
  "Checks if a property plist defines an instance property."
  (not (getf prop :static)))

(defun static-method-p (method)
  "Checks if a method plist defines a static method."
  (getf method :is-static))

(defun instance-event-p (event)
  "Checks if an event plist defines an instance event. Mirrors instance-property-p;
   trivially true for every event today, since AssemblyToLispy.cs's :events collection
   only ever reflects instance events -- static events have no verified DotCL calling
   convention yet (see doc/generator-design-notes.md's Events (Version 32) section)."
  (not (getf event :static)))

(defun public-instance-field-p (field)
  "Checks if a field plist defines a public instance field."
  (and (not (getf field :static))
       (getf field :public)))

(defun indexer-property-p (prop)
  "Checks if a property plist represents a C# indexer (this[...]), i.e. it
   carries its own index :parameters, the same way a method carries its
   parameters."
  (and (getf prop :parameters) t))

(defun generic-type-p (type-str)
  "Checks if a C# type signature string represents an uninstantiated generic type parameter (contains an exclamation point)."
  (and type-str (find #\! type-str)))

(defun generic-method-arity-supported-p (is-generic arity)
  "Returns t if a generic method's ARITY is one this generator can wrap: any
   method is fine if it isn't generic at all (IS-GENERIC nil); a generic
   method needs a positive integer ARITY (one Lisp type-argument parameter
   is generated per type argument -- see generic-type-param-names)."
  (or (not is-generic)
      (and (integerp arity) (> arity 0))))

(defun usable-default-p (param)
  "Returns t if parameter plist PARAM has a default value the generator can
   actually emit as a Lisp literal (see :default-kind in
   doc/assembly-to-lispy.md). An :unrepresentable default -- reflection
   reporting a non-nullable value-type parameter's default(SomeStruct) as
   null, or a non-null struct/object default -- cannot be spliced into a
   lambda list, so such a parameter is treated everywhere as if it had no
   default at all, i.e. mandatory in the generated wrapper."
  (and (getf param :has-default)
       (not (eq (getf param :default-kind) :unrepresentable))))

(defun simple-method-p (method all-methods)
  "Returns t if the method qualifies for Phase 1 compilation.
   Criteria:
   - No overloads (exactly one method signature with this name in the class).
   - No generic parameters/return type (or any positive number of generic type arguments).
   - No default parameter values.
   - No special parameter modifiers (ref, out, ref-readonly, params).
   - No operator overloads.
   - No property accessors (get_/set_)."
  (let* ((name (getf method :name))
         (params (getf method :parameters))
         (static-p (getf method :is-static))
         (is-generic (getf method :is-generic))
         (arity (getf method :generic-arity)))
    (declare (ignore static-p))
    (and name
         ;; Exclude operators and property accessors
         (not (uiop:string-prefix-p "op_" name))
         (not (uiop:string-prefix-p "get_" name))
         (not (uiop:string-prefix-p "set_" name))
         ;; Check for no overloads in the class
         (= 1 (count name all-methods :key (lambda (m) (getf m :name)) :test #'string=))
         ;; Support generic methods of any positive arity
         (generic-method-arity-supported-p is-generic arity)
         ;; Check return type for generic markers
         (not (generic-type-p (getf method :return-type)))
         ;; Check all parameters
         (every (lambda (p)
                  (and (not (getf p :has-default))
                       (not (getf p :out))
                       (not (getf p :ref))
                       (not (getf p :ref-readonly))
                       (not (getf p :params))
                       (not (generic-type-p (getf p :type)))))
                 params))))

(defun clean-method-p (method)
  "Returns t if the method is 'clean' (no ref/out/params/defaults, and any
   generic type arguments have a supported positive arity).
   Unlike simple-method-p, this does NOT check for uniqueness of the method name,
   allowing it to be used for overloaded methods."
  (let* ((name (getf method :name))
         (params (getf method :parameters))
         (is-generic (getf method :is-generic))
         (arity (getf method :generic-arity)))
    (and name
         (not (uiop:string-prefix-p "op_" name))
         (not (uiop:string-prefix-p "get_" name))
         (not (uiop:string-prefix-p "set_" name))
         ;; Support generic methods of any positive arity
         (generic-method-arity-supported-p is-generic arity)
         (not (generic-type-p (getf method :return-type)))
         (every (lambda (p)
                  (and (not (getf p :out))
                       (not (getf p :ref))
                       (not (getf p :ref-readonly))
                       (not (getf p :params))
                       (not (generic-type-p (getf p :type)))))
                params))))

(defun dirty-method-p (method)
  "Returns t if the method has any special parameter modifiers still
   unsupported (ref, ref-readonly, or params). Complement to clean-method-p
   for everything except a lone :out modifier (see out-only-method-p, which
   is checked separately and takes priority -- a method with an :out
   parameter and nothing else dirty is no longer routed here at all). A
   method may be neither clean, dirty, nor out-only if it is an operator or
   accessor. A defaulted parameter no longer makes a method dirty (regardless
   of usable-default-p): a usable default is fully handled by the Master
   Wrapper's &optional/&key dispatch, and an unrepresentable one is simply
   treated as mandatory -- clean-method-p already accepts both, so flagging
   :has-default here would only produce the same method listed as both clean
   (with a real wrapper) and dirty (in the 'not yet supported' comment)."
  (let ((params (getf method :parameters)))
    (some (lambda (p)
            (or (getf p :ref)
                (getf p :ref-readonly)
                (getf p :params)))
          params)))

(defun out-only-method-p (method)
  "Returns t if METHOD's only special parameter modifier is :out (at least
   one parameter), with no :ref/:ref-readonly/:params anywhere -- the v1
   scope for out-parameter support (doc/plan-fable-detail-05.md): `out` maps
   cleanly to an extra Lisp return value via dotnet:call-out/
   dotnet:call-out-generic, but `ref`/`ref readonly`/`params` do not (a
   `ref`/`in` parameter still needs an INPUT value, which dotnet:call-out
   does not accept -- see doc/dotnet-dotcl-interop.md -- and `params` has no
   defined interaction with the out-args protocol at all), so a method
   mixing :out with any of those stays dirty (dirty-method-p), unaffected by
   this predicate. Mirrors clean-method-p/dirty-method-p's other exclusions
   (operators, accessors, unsupported generic arity, the class's own open
   generic type parameter)."
  (let* ((name (getf method :name))
         (params (getf method :parameters))
         (is-generic (getf method :is-generic))
         (arity (getf method :generic-arity)))
    (and name
         (not (uiop:string-prefix-p "op_" name))
         (not (uiop:string-prefix-p "get_" name))
         (not (uiop:string-prefix-p "set_" name))
         (generic-method-arity-supported-p is-generic arity)
         (not (generic-type-p (getf method :return-type)))
         (some (lambda (p) (getf p :out)) params)
         (every (lambda (p)
                  (and (not (getf p :ref))
                       (not (getf p :ref-readonly))
                       (not (getf p :params))
                       (not (generic-type-p (getf p :type)))))
                params))))

(defun clean-constructor-p (ctor)
  "Returns t if the constructor is 'clean' (no ref/out/params/generics).
   A defaulted parameter (usable or :unrepresentable) does not disqualify a
   constructor -- see usable-default-p and dirty-method-p's docstring for
   why this mirrors clean-method-p's existing treatment of defaults."
  (let ((params (getf ctor :parameters)))
    (every (lambda (p)
             (and (not (getf p :out))
                  (not (getf p :ref))
                  (not (getf p :ref-readonly))
                  (not (getf p :params))
                  (not (generic-type-p (getf p :type)))))
           params)))

(defun dirty-constructor-p (ctor)
  "Returns t if the constructor has any special parameter modifiers (ref, out, or params)."
  (let ((params (getf ctor :parameters)))
    (some (lambda (p)
            (or (getf p :out)
                (getf p :ref)
                (getf p :ref-readonly)
                (getf p :params)))
          params)))

(defstruct (class-member-classification (:conc-name cmc-))
  "The result of classify-class-members: every filtered/grouped view of a
   class-plist's fields/properties/methods/constructors/events that
   compute-package-exports-and-shadows, collect-class-instance-generics, and
   generate-class-file each need -- previously reimplemented verbatim,
   independently, in all three. A struct (not a plist) since these fields
   always travel together, are accessed heavily, and struct accessors catch
   typos a getf would silently swallow."
  literal-fields
  pure-const-fields
  dynamic-const-fields
  instance-fields
  mutable-static-fields
  pure-const-props
  dynamic-const-props
  instance-prop-groups
  writeable-static-props
  method-groups
  out-method-groups
  clean-ctors
  dirty-ctors
  instance-events)

(defun group-methods-by-name (methods)
  "Groups method plists by :name, preserving first-seen order (both across
   groups and within each group) -- the same shape method-groups has always
   used, factored out so out-method-groups (doc/plan-fable-detail-05.md)
   groups its own, disjoint, out-only methods identically without
   duplicating the hash-table walk."
  (let ((table (make-hash-table :test #'equal)))
    (dolist (m methods)
      (push m (gethash (getf m :name) table)))
    (let ((groups nil))
      (maphash (lambda (name ms)
                 (push (cons name (nreverse ms)) groups))
               table)
      (nreverse groups))))

(defun classify-class-members (class-plist constant-properties-list)
  "Classifies CLASS-PLIST's fields/properties/methods/constructors/events
   into a CLASS-MEMBER-CLASSIFICATION struct, given CONSTANT-PROPERTIES-LIST
   (the --constant-properties split for this class -- see
   compute-package-exports-and-shadows's docstring). This is the single
   shared implementation of a filtering/grouping walk previously duplicated
   verbatim in compute-package-exports-and-shadows,
   collect-class-instance-generics, and generate-class-file; all three now
   call this once and read the returned struct's accessors."
  (let* ((fields (getf class-plist :fields))
         (properties (getf class-plist :properties))
         (methods (getf class-plist :methods))
         (kind (getf class-plist :kind))
         (raw-ctors (getf class-plist :constructors))
         ;; Structs (value types) in C# have an implicit parameterless
         ;; constructor; if no parameterless constructor is in raw-ctors,
         ;; inject one.
         (ctors (if (and (eq kind :struct)
                         (not (some (lambda (ctor) (null (getf ctor :parameters))) raw-ctors)))
                    (cons '(:parameters nil :public t) raw-ctors)
                    raw-ctors))
         (literal-fields (remove-if-not #'literal-field-p fields))
         (runtime-fields-all (remove-if-not #'runtime-readonly-field-p fields))
         (pure-const-fields (remove-if-not (lambda (f) (or (member "*" constant-properties-list :test #'string=) (member (getf f :name) constant-properties-list :test #'string-equal))) runtime-fields-all))
         (dynamic-const-fields (remove-if (lambda (f) (or (member "*" constant-properties-list :test #'string=) (member (getf f :name) constant-properties-list :test #'string-equal))) runtime-fields-all))
         (instance-fields (remove-if-not #'public-instance-field-p fields))
         (mutable-static-fields (remove-if-not #'mutable-static-field-p fields))
         (const-props (remove-if-not #'constant-property-p properties))
         (pure-const-props (remove-if-not (lambda (p) (or (member "*" constant-properties-list :test #'string=) (member (getf p :name) constant-properties-list :test #'string-equal))) const-props))
         (dynamic-const-props (remove-if (lambda (p) (or (member "*" constant-properties-list :test #'string=) (member (getf p :name) constant-properties-list :test #'string-equal))) const-props))
         (instance-props (remove-if-not #'instance-property-p properties))
         (instance-prop-groups (group-properties-by-name instance-props))
         (writeable-static-props (remove-if-not #'writeable-static-property-p properties))
         (non-operator-non-accessor-methods
           (remove-if (lambda (m)
                        (or (uiop:string-prefix-p "op_" (getf m :name))
                            (uiop:string-prefix-p "get_" (getf m :name))
                            (uiop:string-prefix-p "set_" (getf m :name))
                            (generic-type-p (getf m :return-type))
                            (some (lambda (p) (generic-type-p (getf p :type)))
                                  (getf m :parameters))
                            (out-only-method-p m)))
                      methods))
         (method-groups (group-methods-by-name non-operator-non-accessor-methods))
         ;; Out-only methods (out-only-method-p) are pulled out of the same
         ;; op_/get_/set_/open-generic-excluded pool above, disjoint from
         ;; method-groups, and grouped by name the same way -- see
         ;; doc/plan-fable-detail-05.md.
         (out-only-methods
           (remove-if (lambda (m)
                        (or (uiop:string-prefix-p "op_" (getf m :name))
                            (uiop:string-prefix-p "get_" (getf m :name))
                            (uiop:string-prefix-p "set_" (getf m :name))
                            (not (out-only-method-p m))))
                      methods))
         (out-method-groups (group-methods-by-name out-only-methods))
         (clean-ctors (remove-if-not #'clean-constructor-p ctors))
         (dirty-ctors (remove-if-not #'dirty-constructor-p ctors))
         (instance-events (remove-if-not #'instance-event-p (getf class-plist :events))))
    (make-class-member-classification
     :literal-fields literal-fields
     :pure-const-fields pure-const-fields
     :dynamic-const-fields dynamic-const-fields
     :instance-fields instance-fields
     :mutable-static-fields mutable-static-fields
     :pure-const-props pure-const-props
     :dynamic-const-props dynamic-const-props
     :instance-prop-groups instance-prop-groups
     :writeable-static-props writeable-static-props
     :method-groups method-groups
     :out-method-groups out-method-groups
     :clean-ctors clean-ctors
     :dirty-ctors dirty-ctors
     :instance-events instance-events)))
