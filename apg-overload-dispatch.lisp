;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Developed with Antigravity CLI (Gemini 3.5 Flash and 3.1 Pro)
;;;
;;; C# Assembly Lisp Package Generator -- overload/generic-arity dispatch engine
;;; Split out of the former assembly-package-generator.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :assembly-package-generator)


(defun group-properties-by-name (properties)
  "Groups property plists by :name, preserving first-seen order. Ordinary
   C# properties are never overloaded, but indexers (this[...]) can be, so a
   group may contain more than one property plist."
  (let ((table (make-hash-table :test #'equal))
        (order nil))
    (dolist (p properties)
      (let ((name (getf p :name)))
        (unless (gethash name table)
          (push name order))
        (push p (gethash name table))))
    (mapcar (lambda (name) (cons name (nreverse (gethash name table))))
            (nreverse order))))

(defun generic-type-param-names (arity)
  "Returns ARITY distinct Lisp parameter names for a generic method's type
   arguments (each bound by the caller to a .NET type -- a type-name string,
   alias, or System.Type object -- for dotnet:invoke-generic/static-generic
   to instantiate the method with). ARITY 1 keeps the single legacy name
   \"type\" (pre-dating support for arity > 1, and still the common case);
   ARITY > 1 uses \"type-1\" through \"type-ARITY\" so each type argument
   gets its own binding."
  (if (= arity 1)
      (list "type")
      (loop for i from 1 to arity collect (format nil "type-~D" i))))

(defun method-generic-cell-key (m)
  "Returns a key identifying method plist M's generic-arity 'cell': nil for
   a non-generic method, or its (integer) :generic-arity for a generic one.
   See split-by-generic-arity."
  (and (getf m :is-generic) (getf m :generic-arity)))

(defun split-by-generic-arity (methods)
  "Partitions METHODS (already-clean method plists sharing one C# method
   name and one static/instance mode) into an ordered list of sub-lists,
   one per distinct generic-arity 'cell' (method-generic-cell-key),
   preserving first-seen order within each cell and across cells.

   A single generated Lisp function can only bind one fixed number of
   generic type-argument parameters (one Lisp parameter per type argument --
   see generic-type-param-names), so overloads of the same C# method name
   that disagree on generic arity cannot share one wrapper's lambda list.
   The canonical real-world example is System.Linq.Enumerable's Aggregate,
   which has three same-named overloads of generic arity 1, 2, and 3
   respectively: METHODS (Aggregate's clean, e.g. all-static, overloads)
   would split into three single-method cells here, one per arity, so each
   gets generated as its own function (see generate-method-name-wrappers)
   instead of being incorrectly merged into one.

   The overwhelmingly common case -- a non-generic method, or a generic
   method whose every overload shares the same arity -- returns a single
   one-cell list, so callers can treat \"only one cell\" as \"nothing
   changes from before generic-arity splitting existed.\""
  (let ((table (make-hash-table :test #'eql))
        (order nil))
    (dolist (m methods)
      (let ((key (method-generic-cell-key m)))
        (unless (nth-value 1 (gethash key table))
          (push key order))
        (push m (gethash key table))))
    (mapcar (lambda (key) (nreverse (gethash key table))) (nreverse order))))

(defun generic-arity-suffix (cell)
  "Returns \"\" for a non-generic CELL (a list of method plists sharing one
   method-generic-cell-key, from split-by-generic-arity), or \"-arity-N\"
   for a generic CELL of arity N. Used only to name the internal
   (unexported) per-arity function generate-generic-cell-wrapper defines
   for CELL when a method name splits into more than one cell -- see
   internal-arity-fn-name and generate-method-name-wrappers's Version 28
   two-tier dispatch (generic-arity-dispatch-mode)."
  (let ((m (first cell)))
    (if (getf m :is-generic)
        (format nil "-arity-~D" (getf m :generic-arity))
        "")))

(defun generic-arity-dispatch-mode (cells)
  "Returns one of :single, :split-with-plain, or :split-all-generic,
   describing how CELLS (from split-by-generic-arity -- one per distinct
   generic-arity 'cell' of a method name's clean overloads within one
   static/instance mode) should be exposed publicly:

   :single -- exactly one cell (the non-generic cell alone, or one generic
   arity alone, e.g. Select<TSource,TResult>'s overloads, which all share
   arity 2): no dispatch is needed; BASE-NAME is the one and only function,
   exactly as if generic-arity splitting didn't exist.

   :split-with-plain -- more than one cell, and one of them is the
   non-generic cell: BASE-NAME handles only that non-generic cell (no type
   argument); a new BASE-NAME<> dispatcher handles all the generic cells,
   resolving which one to call by counting the type argument(s) it's given
   (and falling through to BASE-NAME itself when given an empty list).

   :split-all-generic -- more than one cell, none of them non-generic (e.g.
   System.Linq.Enumerable.Aggregate, overloaded at generic arity 1, 2, and
   3, with no non-generic overload at all): BASE-NAME itself becomes the
   dispatcher (no <> suffix -- there is no non-generic call form it would
   otherwise need to be disambiguated from)."
  (cond
    ((<= (length cells) 1) :single)
    ((some (lambda (cell) (null (method-generic-cell-key (first cell)))) cells)
     :split-with-plain)
    (t :split-all-generic)))

(defun internal-arity-fn-name (base-name cell)
  "Returns the (unexported) Lisp function name generate-generic-cell-wrapper
   uses for one generic-arity CELL of BASE-NAME's overloads when more than
   one cell exists for this name (generic-arity-dispatch-mode is not
   :single): BASE-NAME suffixed by generic-arity-suffix, e.g.
   \"aggregate-arity-2\". Never itself exported -- see
   method-name-wrapper-names / compute-package-exports-and-shadows, which
   list only BASE-NAME and/or BASE-NAME<>."
  (concatenate 'string base-name (generic-arity-suffix cell)))

(defun method-name-wrapper-names (clean-methods base-name)
  "Returns the list of Lisp function name(s) generate-method-name-wrappers
   will EXPORT for CLEAN-METHODS (already static/instance-partitioned
   overloads of one C# method name) under BASE-NAME: (list BASE-NAME) in
   the common single-cell case (generic-arity-dispatch-mode :single,
   covering all non-generic methods and single-generic-arity methods
   alike); (list BASE-NAME (concatenate BASE-NAME \"<>\")) when a
   non-generic overload coexists with generic ones at other arities
   (:split-with-plain); or (list BASE-NAME) again when every overload is
   generic but at different arities (:split-all-generic), since BASE-NAME
   itself becomes the dispatcher then. The internal per-arity functions
   generate-generic-cell-wrapper defines under internal-arity-fn-name are
   deliberately never included here -- they stay unexported. Kept separate
   from generate-method-name-wrappers so compute-package-exports-and-shadows
   can list exactly the same names packages.lisp should export without
   re-running the actual code-generation logic. IMPORTANT: this must always
   mirror exactly what generate-method-name-wrappers emits as exported
   top-level defuns -- the main drift risk in this file."
  (let* ((cells (split-by-generic-arity clean-methods))
         (mode (generic-arity-dispatch-mode cells)))
    (case mode
      (:split-with-plain (list base-name (concatenate 'string base-name "<>")))
      (t (list base-name)))))

(cl:defun complex-group-p (clean-methods)
  "Returns t if the group of clean methods requires a master wrapper dispatch (either multiple overloads or presence of a usable default argument)."
  (cl:or (cl:>= (cl:length clean-methods) 2)
         (cl:some (cl:lambda (m)
                    (cl:some #'usable-default-p (cl:getf m :parameters)))
                  clean-methods)))

(cl:defun collect-key-params (methods prefix-len &optional excluded-mapped-names)
  "Collects the union of all keyword parameters from methods beyond
   prefix-len (an index into each overload's :parameters list -- despite
   the name, callers pass the combined prefix + optional-positional slot
   count, i.e. every overload's parameters from that index onward are
   candidate keyword parameters), skipping any parameter whose *mapped*
   Lisp name collides with one already bound earlier in the lambda list
   (EXCLUDED-MAPPED-NAMES -- the wrapper's own positional/optional slot
   names). Without this, two unrelated overloads whose parameters
   map-param-name to the same Lisp name at different lambda-list positions
   (one a positional/optional slot's arbitrarily-chosen representative, one
   a &key slot) would produce an invalid lambda list with a duplicate bound
   variable -- e.g. System.IO.Stream.ReadExactlyAsync's CancellationToken
   parameter, present at different indices across its overloads."
  (cl:let ((key-params nil)
           (seen-mapped-names (cl:copy-list excluded-mapped-names)))
    (cl:dolist (m methods)
      (cl:let ((params (cl:nthcdr prefix-len (cl:getf m :parameters))))
        (cl:dolist (p params)
          (cl:let ((mapped (map-param-name (cl:getf p :name))))
            (cl:unless (cl:member mapped seen-mapped-names :test #'cl:string=)
              (cl:push mapped seen-mapped-names)
              (cl:push p key-params))))))
    (cl:nreverse key-params)))

(cl:defun format-default-literal (p)
  "Returns the Lisp source-text literal string to splice into a generated
   &optional/&key lambda-list default-value form for parameter plist P,
   which must satisfy usable-default-p. P's :default-value has already been
   parsed into an actual Lisp datum by the metadata reader
   (utils:safe-read-form-from-file), so printing it back correctly per its
   :default-kind (rather than assuming :default-value is itself source
   text) is required: a bare string or character datum has no surrounding
   quote/#\\ syntax of its own. :enum is the one kind whose :default-value
   is not a value of the target type at all -- it's the enum member
   name(s) as a string (comma-separated for a [Flags] combination, e.g.
   \"AllowThousands, Float\") -- so it constructs a boxed enum value via
   dotnet:enum-or (see doc/dotnet-dotcl-interop.md) instead."
  (cl:let ((kind (cl:getf p :default-kind))
           (val (cl:getf p :default-value)))
    (cl:case kind
      (:null "cl:nil")
      (:bool (cl:if val "cl:t" "cl:nil"))
      (:number (cl:format nil "~A" val))
      ((:char :string) (cl:format nil "~S" val))
      (:enum
       (cl:let* ((default-type (cl:getf p :default-type))
                 (member-names (cl:mapcar (cl:lambda (part) (cl:string-trim " " part))
                                           (uiop:split-string val :separator ","))))
         (cl:format nil "(dotnet:enum-or ~S ~{~S~^ ~})" default-type member-names)))
      (cl:t "cl:nil"))))

(cl:defun find-parameter-default-str (pname methods)
  "Locates parameter PNAME's usable default (usable-default-p) across
   METHODS (a method or constructor plist list) and returns its Lisp
   literal source text (format-default-literal), or \"cl:nil\" if none of
   METHODS' overloads declares a usable default for it -- matching a bare
   &key slot's ordinary CL default-of-nil semantics."
  (cl:dolist (m methods)
    (cl:let ((p (cl:find pname (cl:getf m :parameters) :key (cl:lambda (param) (cl:getf param :name)) :test #'cl:string=)))
      (cl:when (cl:and p (usable-default-p p))
        (cl:return-from find-parameter-default-str (format-default-literal p)))))
  "cl:nil")

(cl:defun common-parameter-prefix (methods)
  "Determines the maximum common positional parameter prefix across methods based on lack of a usable default value."
  (cl:let* ((param-lists (cl:mapcar (cl:lambda (m) (cl:getf m :parameters)) methods))
            (min-len (cl:reduce #'cl:min (cl:mapcar #'cl:length param-lists)))
            (prefix nil))
    (cl:loop for idx from 0 to (cl:1- min-len) do
      (cl:let* ((first-param (cl:nth idx (cl:first param-lists)))
                ;; A parameter cannot be positional if it has a usable default value in any overload.
                (no-default-p (cl:every (cl:lambda (pl)
                                          (cl:let ((p (cl:nth idx pl)))
                                            (cl:not (usable-default-p p))))
                                        param-lists)))
        (cl:if no-default-p
            (cl:push first-param prefix)
            (cl:loop-finish))))
    (cl:nreverse prefix)))

(cl:defun mandatory-param-count (m)
  "Returns the number of leading parameters of method/constructor plist M
   with no usable default (usable-default-p) -- M's effective minimum call
   arity. Used both by max-mandatory-parameter-len (across a whole group)
   and by master-wrapper-more-specific-p (per overload, for Master Wrapper
   cond-clause ordering)."
  (cl:loop for p in (cl:getf m :parameters)
           while (cl:not (usable-default-p p))
           count t))

(cl:defun max-mandatory-parameter-len (methods)
  "Returns the maximum number of mandatory parameters (parameters without a usable default) in any single overload."
  (cl:reduce #'cl:max (cl:mapcar #'mandatory-param-count methods) :initial-value 0))

(cl:defun master-wrapper-more-specific-p (a b)
  "Returns t if overload/constructor plist A's Master Wrapper cond clause
   must be tried before B's. Sorts by effective minimum (mandatory) arity
   descending first, so a call supplying fewer arguments only ever matches
   an overload whose mandatory arity is at most that many; among overloads
   tied on mandatory arity, sorts by raw parameter count ascending, so an
   overload with no trailing default (an exact match for a call that omits
   the tied slot(s) entirely) is tried before one whose tied slot(s) are
   filled by a defaulted trailing parameter instead. Fixes the bug documented
   in doc/bug-in-dispatching.md, where sorting by raw parameter count alone
   let a same-effective-arity overload with a defaulted trailing parameter
   permanently shadow a shorter, fully-required overload's cond clause."
  (cl:let ((ma (mandatory-param-count a))
           (mb (mandatory-param-count b)))
    (cl:if (cl:/= ma mb)
        (cl:> ma mb)
        (cl:< (cl:length (cl:getf a :parameters)) (cl:length (cl:getf b :parameters))))))

(cl:defun collect-optional-positional-params (methods prefix-len max-mand-len)
  "Collects parameter descriptors for optional positional parameters from index prefix-len to max-mand-len."
  (cl:let ((opt-params nil))
    (cl:loop for idx from prefix-len to (cl:1- max-mand-len) do
      (cl:let ((found-param nil))
        (cl:dolist (m methods)
          (cl:let ((params (cl:getf m :parameters)))
            (cl:when (cl:< idx (cl:length params))
              (cl:setf found-param (cl:nth idx params))
              (cl:return))))
        (cl:when found-param
          (cl:push found-param opt-params))))
    (cl:nreverse opt-params)))

(cl:defun uniquify-positional-params (params)
  "Given the ordered list of positional dispatch-slot parameter plists
   (PREFIX appended with OPT-PARAMS), returns a copy where any :name whose
   mapped Lisp name collides with an earlier slot's gets a numeric suffix, so
   every slot binds a distinct lambda-list variable. Each slot's
   representative parameter is picked arbitrarily from whichever overload
   happens to have one there (see collect-optional-positional-params), so two
   unrelated overloads can coincidentally share a parameter name at different
   positional slots (e.g. TimeSpan's 3-arg ctor's 'seconds' at index 2 vs. its
   4-arg ctor's unrelated 'seconds' at index 3)."
  (cl:let ((seen nil))
    (cl:mapcar (cl:lambda (p)
                 (cl:let* ((base-name (cl:getf p :name))
                           (final-name base-name)
                           (suffix 2))
                   (cl:loop while (cl:member (map-param-name final-name) seen :test #'cl:string=) do
                     (cl:setf final-name (cl:format nil "~A~D" base-name suffix))
                     (cl:incf suffix))
                   (cl:push (map-param-name final-name) seen)
                   (cl:list* :name final-name p)))
               params)))

(cl:defun format-master-overload-condition (cm prefix opt-params key-params)
  "Generates Lisp conditional test expression checking supplied-p flags and parameter types for cm."
  (cl:let* ((cond-parts nil)
            (cm-params (cl:getf cm :parameters))
            (prefix-len (cl:length prefix))
            (max-mand-len (+ prefix-len (cl:length opt-params))))
    ;; 1. Check positional prefix types by position index
    (cl:loop for pp in prefix
             for idx from 0 do
      (cl:let* ((lpname (map-param-name (cl:getf pp :name)))
                (cm-p (cl:nth idx cm-params))
                (type-check (format-param-type-check cm-p lpname)))
        (cl:push type-check cond-parts)))
    ;; 2. Check optional positional parameters presence and types. When CM's
    ;;    own parameter at this slot has a usable default, this clause may
    ;;    match whether or not the caller supplied it -- only type-check it
    ;;    if they did (master-overload-param-names substitutes CM's real
    ;;    default when they didn't). Otherwise (no parameter here at all, or
    ;;    one with no usable default -- including :unrepresentable, which is
    ;;    effectively mandatory) behavior is unchanged from before.
    (cl:loop for op in opt-params
             for idx from prefix-len to (cl:1- max-mand-len) do
      (cl:let* ((op-name (map-param-name (cl:getf op :name)))
                (supplied-var (cl:format nil "supplied-~A" op-name))
                (cm-p (cl:nth idx cm-params)))
        (cl:cond
          ((cl:null cm-p)
           (cl:push (cl:format nil "(cl:not ~A)" supplied-var) cond-parts))
          ((usable-default-p cm-p)
           (cl:push (cl:format nil "(cl:or (cl:not ~A) ~A)" supplied-var (format-param-type-check cm-p op-name)) cond-parts))
          (cl:t
           (cl:push supplied-var cond-parts)
           (cl:push (format-param-type-check cm-p op-name) cond-parts)))))
    ;; 3. Check keyword parameters presence and types. Same usable-default-p
    ;;    softening as (2) above, keyed to CM's own parameter, not the
    ;;    slot's arbitrarily-chosen representative KP.
    (cl:dolist (kp key-params)
      (cl:let* ((pname (cl:getf kp :name))
             (lpname (map-param-name pname))
             (supplied-var (cl:format nil "supplied-~A" lpname))
             (cm-p (cl:find pname cm-params :key (cl:lambda (p) (cl:getf p :name)) :test #'cl:string=)))
        (cl:cond
          ((cl:null cm-p)
           (cl:push (cl:format nil "(cl:not ~A)" supplied-var) cond-parts))
          ((usable-default-p cm-p)
           (cl:push (cl:format nil "(cl:or (cl:not ~A) ~A)" supplied-var (format-param-type-check cm-p lpname)) cond-parts))
          (cl:t
           (cl:push supplied-var cond-parts)
           (cl:push (format-param-type-check cm-p lpname) cond-parts)))))
    (cl:format nil "(cl:and ~{~A~^ ~})" (cl:nreverse cond-parts))))

(cl:defun master-overload-param-names (cm prefix opt-params key-params)
  "Maps CM's (a method or constructor plist) parameters to the master
   wrapper's invocation-argument expressions by positional index: the
   wrapper's own bound variable name (mapped from PREFIX for positional
   args, from OPT-PARAMS for optional positional args beyond that, or CM's
   own mapped parameter name for anything past that, i.e. keyword args) --
   except when CM's own parameter at that index has a usable default
   (usable-default-p) and lands in an optional-positional or keyword slot:
   there, format-master-overload-condition only requires this clause's
   supplied-p flag to be true when the caller actually supplied a value
   (cl:or (cl:not supplied-x) ...), so the slot's shared CL:NIL
   &optional/&key init form is not necessarily CM's real C# default, and the
   expression passed to CM must instead be
   (cl:if supplied-x x <CM's own default literal>). A prefix slot, or any
   slot where CM's own parameter has no usable default, is unconditionally
   required by that same cond clause, so the plain variable already holds
   CM's real supplied value there.

   Every parameter landing at idx >= (length prefix)+(length opt-params) --
   the keyword zone -- necessarily has a usable default (a non-defaulted
   parameter can never sort later than max-mandatory-parameter-len, by C#'s
   own mandatory-before-optional parameter ordering rule), but collect-
   key-params may have excluded CM's own occurrence of it entirely: if its
   mapped name collides with a DIFFERENT, unrelated parameter that some
   other overload's positional/optional slot arbitrarily chose as that
   slot's representative name (e.g. one overload's leading mandatory 'id'
   landing in the same lambda-list slot, by index, as another overload's
   leading defaulted 'fullInstantiation'), reusing that slot's variable
   here would silently pass CM the WRONG overload's value. KEY-PARAMS (the
   same list threaded through the lambda list and format-master-overload-
   condition) is consulted to detect this: only when CM's own parameter
   name is actually among KEY-PARAMS' bound names is the ordinary
   supplied-p-guarded variable reference used; otherwise (excluded by that
   collision) the bare default literal is emitted unconditionally, since no
   binding exists through which a caller could ever supply a different
   value for this specific occurrence -- correct, if narrower, for this
   narrow, self-colliding edge case."
  (cl:let* ((cm-params (cl:getf cm :parameters))
            (prefix-len (cl:length prefix))
            (max-mand-len (+ prefix-len (cl:length opt-params)))
            (key-param-names (cl:mapcar (cl:lambda (kp) (map-param-name (cl:getf kp :name))) key-params)))
    (cl:loop for p in cm-params
             for idx from 0
             collect (cl:cond
                       ((cl:< idx prefix-len)
                        (map-param-name (cl:getf (cl:nth idx prefix) :name)))
                       ((cl:< idx max-mand-len)
                        (cl:let ((var (map-param-name (cl:getf (cl:nth (- idx prefix-len) opt-params) :name))))
                          (cl:if (usable-default-p p)
                              (cl:format nil "(cl:if supplied-~A ~A ~A)" var var (format-default-literal p))
                              var)))
                       (cl:t
                        (cl:let ((var (map-param-name (cl:getf p :name))))
                          (cl:cond
                            ((cl:not (cl:member var key-param-names :test #'cl:string=))
                             (format-default-literal p))
                            ((usable-default-p p)
                             (cl:format nil "(cl:if supplied-~A ~A ~A)" var var (format-default-literal p)))
                            (cl:t var))))))))

(cl:defun format-invocation-expr (fq-name dotnet-method-name static-p is-generic-p generic-type-args-str param-names
                                   &optional static-typed-args)
  "Builds the 4-way static/instance x generic/non-generic
   dotnet:static/dotnet:static-generic/dotnet:invoke/dotnet:invoke-generic
   call-expression string, shared by generate-single-overload and
   format-master-overload-action (previously duplicated between the two).
   STATIC-TYPED-ARGS, if supplied (generate-single-overload's own
   typed-call optimization for value-type static receiver-less params --
   never used by the Master Wrapper action), overrides PARAM-NAMES in the
   static, non-generic branch."
  (cl:cond
    ((cl:and static-p is-generic-p)
     (cl:format nil "(dotnet:static-generic <type-str> \"~A\" (cl:list ~A)~@[ ~{~A~^ ~}~])" dotnet-method-name generic-type-args-str param-names))
    (static-p
     (cl:if static-typed-args
         (cl:format nil "(dotnet:static <type-str> \"~A\"~@[~{ ~A~}~])" dotnet-method-name static-typed-args)
         (cl:format nil "(dotnet:static <type-str> \"~A\"~@[ ~{~A~^ ~}~])" dotnet-method-name param-names)))
    (is-generic-p
     (cl:format nil "(dotnet:invoke-generic (cl:the (dotnet \"~A\") obj!) \"~A\" (cl:list ~A)~@[ ~{~A~^ ~}~])" fq-name dotnet-method-name generic-type-args-str param-names))
    (cl:t
     (cl:format nil "(dotnet:invoke (cl:the (dotnet \"~A\") obj!) \"~A\"~@[ ~{~A~^ ~}~])" fq-name dotnet-method-name param-names))))

(cl:defun format-master-overload-action (cm fq-name name static-p is-generic-p generic-type-names prefix opt-params key-params)
  "Generates C# invocation code for cm, mapping parameter names to the
   master wrapper's bound variables. GENERIC-TYPE-NAMES (from
   generic-type-param-names) is the ordered list of Lisp type-argument
   variable names bound by the wrapper's own lambda list; ignored unless
   IS-GENERIC-P."
  (cl:let* ((param-names (master-overload-param-names cm prefix opt-params key-params))
            (dotnet-method-name (cl:or (cl:getf cm :mangled-name) name))
            (type-args-str (cl:format nil "~{~A~^ ~}" generic-type-names)))
    (format-invocation-expr fq-name dotnet-method-name static-p is-generic-p type-args-str param-names)))

(cl:defun format-supplied-args-expr (prefix opt-params key-params)
  "Generates Lisp expression constructing a plist of supplied arguments at runtime."
  (cl:let ((parts nil))
    (cl:dolist (pp prefix)
      (cl:let ((lpname (map-param-name (cl:getf pp :name))))
        (cl:push (cl:format nil "(cl:list :~A ~A)" lpname lpname) parts)))
    (cl:dolist (op opt-params)
      (cl:let* ((lpname (map-param-name (cl:getf op :name)))
                (supplied-var (cl:format nil "supplied-~A" lpname)))
        (cl:push (cl:format nil "(cl:when ~A (cl:list :~A ~A))" supplied-var lpname lpname) parts)))
    (cl:dolist (kp key-params)
      (cl:let* ((lpname (map-param-name (cl:getf kp :name)))
             (supplied-var (cl:format nil "supplied-~A" lpname)))
        (cl:push (cl:format nil "(cl:when ~A (cl:list :~A ~A))" supplied-var lpname lpname) parts)))
    (cl:format nil "(cl:append ~{~A~^ ~})" (cl:nreverse parts))))

(cl:defun generate-master-wrapper (stream methods name mname fq-name static-p is-generic-p)
  "Generates Master Wrapper defun with precise dispatch cond block and fallback error signaling.
   When IS-GENERIC-P, every method in METHODS is assumed to share the same
   :generic-arity (the arity of the first is used to compute the wrapper's
   type-argument parameter names -- see generic-type-param-names)."
  (cl:let* ((generic-arity (cl:and is-generic-p (cl:getf (cl:first methods) :generic-arity)))
            (generic-type-names (cl:and is-generic-p (generic-type-param-names generic-arity)))
            (raw-prefix (common-parameter-prefix methods))
            (prefix-len (cl:length raw-prefix))
            (max-mand-len (max-mandatory-parameter-len methods))
            (raw-opt-params (collect-optional-positional-params methods prefix-len max-mand-len))
            (uniquified (uniquify-positional-params (cl:append raw-prefix raw-opt-params)))
            (prefix (cl:subseq uniquified 0 prefix-len))
            (opt-params (cl:nthcdr prefix-len uniquified))
            (prefix-names (cl:mapcar (cl:lambda (p) (map-param-name (cl:getf p :name))) prefix))
            (opt-param-names (cl:mapcar (cl:lambda (p) (map-param-name (cl:getf p :name))) opt-params))
            (key-params (collect-key-params methods max-mand-len (cl:append prefix-names opt-param-names)))
            (args-list nil))
    (cl:when is-generic-p
      (cl:setf args-list (cl:append args-list generic-type-names)))
    (cl:unless static-p
      (cl:setf args-list (cl:append args-list (cl:list "obj!"))))
    (cl:setf args-list (cl:append args-list prefix-names))
    (cl:when opt-params
      (cl:setf args-list (cl:append args-list (cl:list "cl:&optional")))
      (cl:dolist (op opt-params)
        (cl:let* ((op-name (map-param-name (cl:getf op :name)))
                  (supplied-var (cl:format nil "supplied-~A" op-name)))
          (cl:setf args-list (cl:append args-list (cl:list (cl:format nil "(~A cl:nil ~A)" op-name supplied-var)))))))
    (cl:when key-params
      (cl:setf args-list (cl:append args-list (cl:list "cl:&key")))
      (cl:dolist (kp key-params)
        (cl:let* ((kp-name (map-param-name (cl:getf kp :name)))
               (kp-default (find-parameter-default-str (cl:getf kp :name) methods))
               (supplied-var (cl:format nil "supplied-~A" kp-name)))
          (cl:setf args-list (cl:append args-list (cl:list (cl:format nil "(~A ~A ~A)" kp-name kp-default supplied-var)))))))
    
    (cl:format stream "(cl:defun ~A (~{~A~^ ~})~%" (safe-symbol-token mname) args-list)
    (cl:let* ((header (cl:format nil "Master wrapper for ~A.~A overloads. Dispatches at runtime." fq-name name))
              (docstring (format-combined-overloads-docstring header #'method-signature-str methods))
              (escaped-docstring (escape-lisp-string docstring)))
      (cl:format stream "  \"~A\"~%" escaped-docstring))
    (cl:format stream "  (cl:cond~%")

    ;; Sort methods by effective (mandatory) arity for specificity -- see
    ;; master-wrapper-more-specific-p.
    (cl:let ((sorted-methods (cl:sort (cl:copy-list methods) #'master-wrapper-more-specific-p)))
      (cl:dolist (cm sorted-methods)
        (cl:let ((cond-str (format-master-overload-condition cm prefix opt-params key-params))
              (action-str (format-master-overload-action cm fq-name name static-p is-generic-p generic-type-names prefix opt-params key-params)))
          (cl:format stream "    (~A~%" cond-str)
          (cl:format stream "     ~A)~%" action-str))))

    (cl:let ((supplied-args-expr (format-supplied-args-expr prefix opt-params key-params)))
      (cl:format stream "    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found~%")
      (cl:format stream "                    :package-name \"~A\"~%" (cl:string-upcase (type-fq-name-to-pkg-name fq-name)))
      (cl:format stream "                    :class-name <type-str>~%")
      (cl:format stream "                    :method-name \"~A\"~%" name)
      (cl:format stream "                    :supplied-args ~A))))~%~%" supplied-args-expr))))

(cl:defun format-constructor-master-overload-action (cm prefix opt-params key-params)
  "Generates C# constructor invocation code for cm (a constructor plist),
   mapping parameter names to the master wrapper's bound variables."
  (cl:let ((param-names (master-overload-param-names cm prefix opt-params key-params)))
    (cl:format nil "(dotnet:new <type-str>~@[ ~{~A~^ ~}~])" param-names)))

(cl:defun generate-constructor-master-wrapper (stream ctors fq-name)
  "Generates a Master Wrapper 'new' defun with precise dispatch cond block
   and fallback error signaling, covering all clean constructor overloads.
   Constructors have no static/instance split (unlike generate-master-wrapper),
   so exactly one 'new' function is always emitted here."
  (cl:let* ((raw-prefix (common-parameter-prefix ctors))
            (prefix-len (cl:length raw-prefix))
            (max-mand-len (max-mandatory-parameter-len ctors))
            (raw-opt-params (collect-optional-positional-params ctors prefix-len max-mand-len))
            (uniquified (uniquify-positional-params (cl:append raw-prefix raw-opt-params)))
            (prefix (cl:subseq uniquified 0 prefix-len))
            (opt-params (cl:nthcdr prefix-len uniquified))
            (prefix-names (cl:mapcar (cl:lambda (p) (map-param-name (cl:getf p :name))) prefix))
            (opt-param-names (cl:mapcar (cl:lambda (p) (map-param-name (cl:getf p :name))) opt-params))
            (key-params (collect-key-params ctors max-mand-len (cl:append prefix-names opt-param-names)))
            (args-list prefix-names))
    (cl:when opt-params
      (cl:setf args-list (cl:append args-list (cl:list "cl:&optional")))
      (cl:dolist (op opt-params)
        (cl:let* ((op-name (map-param-name (cl:getf op :name)))
                  (supplied-var (cl:format nil "supplied-~A" op-name)))
          (cl:setf args-list (cl:append args-list (cl:list (cl:format nil "(~A cl:nil ~A)" op-name supplied-var)))))))
    (cl:when key-params
      (cl:setf args-list (cl:append args-list (cl:list "cl:&key")))
      (cl:dolist (kp key-params)
        (cl:let* ((kp-name (map-param-name (cl:getf kp :name)))
               (kp-default (find-parameter-default-str (cl:getf kp :name) ctors))
               (supplied-var (cl:format nil "supplied-~A" kp-name)))
          (cl:setf args-list (cl:append args-list (cl:list (cl:format nil "(~A ~A ~A)" kp-name kp-default supplied-var)))))))

    (cl:format stream "(cl:defun new (~{~A~^ ~})~%" args-list)
    (cl:let* ((header (cl:format nil "Master wrapper for ~A constructor overloads. Dispatches at runtime." fq-name))
              (docstring (format-combined-overloads-docstring header #'constructor-signature-str ctors))
              (escaped-docstring (escape-lisp-string docstring)))
      (cl:format stream "  \"~A\"~%" escaped-docstring))
    (cl:format stream "  (cl:cond~%")

    ;; Sort constructors by effective (mandatory) arity for specificity --
    ;; see master-wrapper-more-specific-p.
    (cl:let ((sorted-ctors (cl:sort (cl:copy-list ctors) #'master-wrapper-more-specific-p)))
      (cl:dolist (cm sorted-ctors)
        (cl:let ((cond-str (format-master-overload-condition cm prefix opt-params key-params))
                 (action-str (format-constructor-master-overload-action cm prefix opt-params key-params)))
          (cl:format stream "    (~A~%" cond-str)
          (cl:format stream "     ~A)~%" action-str))))

    (cl:let ((supplied-args-expr (format-supplied-args-expr prefix opt-params key-params)))
      (cl:format stream "    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found~%")
      (cl:format stream "                    :package-name \"~A\"~%" (cl:string-upcase (type-fq-name-to-pkg-name fq-name)))
      (cl:format stream "                    :class-name <type-str>~%")
      (cl:format stream "                    :method-name \"new\"~%")
      (cl:format stream "                    :supplied-args ~A))))~%~%" supplied-args-expr))))

(cl:defun generate-single-overload (stream m mname fq-name static-p)
  "Generates Lisp wrapper function for a single clean C# overload."
  (cl:let* ((m-doc (cl:getf m :documentation))
            (summary (cl:getf m-doc :summary))
            (returns (cl:getf m-doc :returns))
            (params (cl:getf m :parameters))
            (is-generic-p (cl:getf m :is-generic))
            (generic-type-names (cl:and is-generic-p (generic-type-param-names (cl:getf m :generic-arity))))
            (generic-type-args-str (cl:format nil "~{~A~^ ~}" generic-type-names))
            (param-names (cl:mapcar (cl:lambda (p) (map-param-name (cl:getf p :name))) params))
            (args-str (cl:cond
                        ((cl:and static-p is-generic-p)
                         (cl:format nil "~A~@[ ~{~A~^ ~}~]" generic-type-args-str param-names))
                        (static-p
                         (cl:format nil "~{~A~^ ~}" param-names))
                        (is-generic-p
                         (cl:format nil "~A obj!~@[ ~{~A~^ ~}~]" generic-type-args-str param-names))
                        (cl:t
                         (cl:format nil "obj!~@[ ~{~A~^ ~}~]" param-names))))
            (docstring (build-docstring summary returns params m-doc m))
            (escaped-docstring (escape-lisp-string docstring))
            (dotnet-method-name (cl:or (cl:getf m :mangled-name) (cl:getf m :name)))
            ;; For static method params, add (the (dotnet "Type") arg) hints.
            ;; Uses resolvable-type-name-for-check (not the bare :type) for the
            ;; same reason format-param-type-check does: a closed Nullable<T>'s
            ;; own name is never actually resolvable/meaningful as a type hint
            ;; (a boxed Nullable<T> is always really a boxed T), and any other
            ;; closed generic parameter type can likewise fail to resolve when
            ;; a type argument lives in a different assembly than the generic
            ;; definition -- see doc/bug-in-nullable-value-type-dispatch.md.
            (static-typed-args
              (cl:if static-p
                  (cl:mapcar (cl:lambda (pn pt)
                            (cl:format nil "(cl:the (dotnet \"~A\") ~A)" pt pn))
                          param-names
                          (cl:mapcar #'resolvable-type-name-for-check params))
                  nil)))
       
       (cl:format stream "(cl:defun ~A (~A)~%" (safe-symbol-token mname) args-str)
       (cl:when (cl:> (cl:length escaped-docstring) 0)
         (cl:format stream "  \"~A\"~%" escaped-docstring))
       (cl:format stream "  ~A)~%~%"
                  (format-invocation-expr fq-name dotnet-method-name static-p is-generic-p generic-type-args-str param-names static-typed-args))))

(defun generate-generic-cell-wrapper (stream cell name mname fq-name static-p)
  "Generates the Lisp wrapper function for one generic-arity CELL (a list
   of method plists sharing one method-generic-cell-key, from
   split-by-generic-arity) under name MNAME: generate-single-overload for a
   lone non-complex overload, generate-master-wrapper (unchanged runtime
   type/optional/key dispatch) for a complex overload group sharing that
   arity -- e.g. group-by-arity-3's 2 overloads differing by an optional
   trailing comparer. This existing inner dispatch is unaffected by, and
   sits underneath, any outer generic-arity dispatch
   generate-method-name-wrappers adds via generate-generic-arity-dispatcher."
  (if (and (= (length cell) 1) (not (complex-group-p cell)))
      (generate-single-overload stream (first cell) mname fq-name static-p)
      (generate-master-wrapper stream cell name mname fq-name static-p (getf (first cell) :is-generic))))

(defun generate-generic-arity-dispatcher (stream cells base-name dispatcher-name fq-name
                                           &optional plain-fallback-name)
  "Generates the DISPATCHER-NAME function (either BASE-NAME<> or, when
   every overload of this name is generic, bare BASE-NAME itself -- see
   generic-arity-dispatch-mode) that resolves which of CELLS' internal
   per-generic-arity functions (internal-arity-fn-name, already emitted by
   generate-generic-cell-wrapper and never exported) to call at runtime, by
   counting the type argument(s) passed as its first parameter: a bare
   (non-list) type selects the arity-1 cell, a cl:list of N types selects
   the arity-N cell. Type arguments themselves are never Lisp lists, so
   cl:listp on that first argument unambiguously distinguishes the two
   calling conventions. The remaining arguments are forwarded verbatim (via
   &rest/apply) to the resolved internal function, so this dispatcher never
   needs to know that function's own lambda-list shape (which may itself be
   a Master Wrapper's &optional/&key lambda list).

   When PLAIN-FALLBACK-NAME is supplied (the :split-with-plain case, set to
   BASE-NAME), an empty list/nil TYPES argument dispatches straight through
   to PLAIN-FALLBACK-NAME (the non-generic overload(s)) instead of
   erroring."
  (format stream "(cl:defun ~A (types cl:&rest args)~%" (safe-symbol-token dispatcher-name))
  (format stream "  \"Dispatches ~A by the generic type argument(s) in TYPES: pass a~%" dispatcher-name)
  (format stream "   single .NET type (a type-name string, alias, or System.Type object) to~%")
  (format stream "   select the single-type-argument overload, or a cl:list of types to~%")
  (format stream "   select the overload taking that many type arguments; ARGS are the~%")
  (format stream "   remaining arguments, forwarded unchanged to the resolved overload.~@[~%   Passing cl:nil or an empty list calls the non-generic ~A overload(s).~]\"~%"
          plain-fallback-name plain-fallback-name)
  (format stream "  (cl:let* ((type-list (cl:if (cl:listp types) types (cl:list types))))~%")
  (format stream "    (cl:case (cl:length type-list)~%")
  (when plain-fallback-name
    (format stream "      (0 (cl:apply (cl:function ~A) args))~%" (safe-symbol-token plain-fallback-name)))
  (dolist (cell cells)
    (let* ((m (first cell))
           (arity (getf m :generic-arity))
           (internal-name (internal-arity-fn-name base-name cell)))
      (format stream "      (~D (cl:apply (cl:function ~A) (cl:append type-list args)))~%" arity (safe-symbol-token internal-name))))
  (format stream "      (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found~%")
  (format stream "                      :package-name \"~A\"~%" (string-upcase (type-fq-name-to-pkg-name fq-name)))
  (format stream "                      :class-name <type-str>~%")
  (format stream "                      :method-name \"~A\"~%" dispatcher-name)
  (format stream "                      :supplied-args (cl:list :type-count (cl:length type-list) :types type-list))))))~%~%"))

(defun generate-method-name-wrappers (stream clean-methods name base-name fq-name static-p)
  "Generates the public Lisp wrapper function(s) for one C# method NAME's
   already static/instance-partitioned CLEAN-METHODS, under BASE-NAME.

   generic-arity-dispatch-mode determines the shape:
   :single (the overwhelmingly common case -- non-generic, or every
   overload shares one generic arity) generates exactly BASE-NAME, exactly
   as if generic-arity splitting didn't exist.
   :split-with-plain (a non-generic overload coexists with generic ones at
   other arities) generates BASE-NAME for the non-generic cell alone, an
   internal (unexported) function per generic cell (internal-arity-fn-name),
   and a BASE-NAME<> dispatcher (generate-generic-arity-dispatcher) that
   picks among them by counting type arguments at runtime (falling through
   to BASE-NAME on an empty type list).
   :split-all-generic (every overload is generic, just at different
   arities, e.g. Enumerable.Aggregate's arity-1/2/3 overloads) generates an
   internal function per cell plus BASE-NAME itself as the dispatcher (no
   <> suffix needed since there's no non-generic form to disambiguate).

   method-name-wrapper-names computes the same exported name(s) without
   generating any code, for compute-package-exports-and-shadows."
  (let* ((cells (split-by-generic-arity clean-methods))
         (mode (generic-arity-dispatch-mode cells)))
    (case mode
      (:single
       (generate-generic-cell-wrapper stream (first cells) name base-name fq-name static-p))
      (:split-with-plain
       (let* ((plain-cell (find-if (lambda (c) (null (method-generic-cell-key (first c)))) cells))
              (generic-cells (remove plain-cell cells)))
         (generate-generic-cell-wrapper stream plain-cell name base-name fq-name static-p)
         (dolist (cell generic-cells)
           (generate-generic-cell-wrapper stream cell name (internal-arity-fn-name base-name cell) fq-name static-p))
         (generate-generic-arity-dispatcher stream generic-cells base-name
                                             (concatenate 'string base-name "<>") fq-name base-name)))
      (:split-all-generic
       (dolist (cell cells)
         (generate-generic-cell-wrapper stream cell name (internal-arity-fn-name base-name cell) fq-name static-p))
       (generate-generic-arity-dispatcher stream cells base-name base-name fq-name)))))


;;; Out-parameter support (doc/plan-fable-detail-05.md): a method whose only
;;; special parameter modifier is :out (out-only-method-p, apg-member-
;;; predicates.lisp) gets a real wrapper here instead of a dirty comment,
;;; forwarding to DotCL's dotnet:call-out/dotnet:call-out-generic (see
;;; doc/dotnet-dotcl-interop.md), which already returns (cl:values
;;; primary-return out-1 out-2 ...) itself -- the out parameter(s) are
;;; simply omitted from the wrapper's own lambda list entirely. `ref`/
;;; `ref readonly`/`params` overloads remain unsupported (dirty-method-p).

(defun out-method-collides-with-clean-p (name is-static-p method-groups)
  "Returns t if METHOD-GROUPS (cmc-method-groups) already has a CLEAN
   overload of C# method NAME in the same static/instance mode as
   IS-STATIC-P -- see out-method-wrapper-name."
  (let ((group (cdr (assoc name method-groups :test #'string=))))
    (some (lambda (m) (and (clean-method-p m) (eq (not (getf m :is-static)) (not is-static-p))))
          group)))

(defun out-method-wrapper-name (name is-static-p mixed-mode-p method-groups)
  "Returns the Lisp wrapper base name for out-only overloads of C# method
   NAME in the given static/instance mode: the plain mapped name -- e.g.
   TryParse has no clean overload, so it becomes plain try-parse -- unless
   MIXED-MODE-P (this out-method-group has BOTH static and instance out-only
   overloads under the same C# name), in which case the static mode's name
   is suffixed with \"*\" instead, exactly mirroring emit-methods' own
   static/instance mixed-mode convention for clean methods. Either form is
   further suffixed with \"/out\" when a clean overload of the same C# name
   already exists in this same static/instance mode (so a hypothetical
   clean Parse and out-only Parse(out ...) can coexist as parse and
   parse/out). \"/\" never appears in an ordinary mapped member name
   (camel-to-kebab never emits it, and the only \"/\" in the operator table
   is division, always alone in its own operator group), so this suffix can
   never collide with a real C# name. See doc/plan-fable-detail-05.md."
  (let* ((kebab-name (map-member-name name))
         (candidate (if (and is-static-p mixed-mode-p) (concatenate 'string kebab-name "*") kebab-name)))
    (if (out-method-collides-with-clean-p name is-static-p method-groups)
        (concatenate 'string candidate "/out")
        candidate)))

(defun out-method-group-names (name out-methods method-groups)
  "Returns the wrapper name(s) (0-2: one per static/instance mode actually
   present in OUT-METHODS) generate-out-method-name-wrappers will
   define/export for C# method NAME's out-only overloads OUT-METHODS
   (cmc-out-method-groups' entry for NAME), given METHOD-GROUPS
   (cmc-method-groups, for out-method-wrapper-name's collision check).
   Shared between emit-out-methods and compute-package-exports-and-shadows/
   class-member-names-excluding-events so the two can never disagree."
  (let* ((static-out (remove-if-not (lambda (m) (getf m :is-static)) out-methods))
         (instance-out (remove-if-not (lambda (m) (not (getf m :is-static))) out-methods))
         (mixed-mode-p (and static-out instance-out))
         (names nil))
    (when instance-out (push (out-method-wrapper-name name nil mixed-mode-p method-groups) names))
    (when static-out (push (out-method-wrapper-name name t mixed-mode-p method-groups) names))
    (nreverse names)))

(defun format-call-out-invocation-expr (fq-name dotnet-method-name static-p is-generic-p generic-type-args-str param-names)
  "Builds the dotnet:call-out/dotnet:call-out-generic invocation-expression
   string for an out-only method -- mirrors format-invocation-expr's 4-way
   static/instance x generic/non-generic shape, but PARAM-NAMES here are
   only the non-out (in) arguments (see make-filtered-out-method), and the
   callee is dotnet:call-out(-generic) instead of dotnet:invoke/static,
   since dotnet:call-out already returns (cl:values primary-return out-1
   out-2 ...) itself -- no separate values-wrapping is needed. The first
   argument is <type-str> for a static call or obj! for an instance call,
   exactly like dotnet:static/dotnet:invoke's own receiver convention."
  (let ((receiver (if static-p "<type-str>" "obj!")))
    (if is-generic-p
        (format nil "(dotnet:call-out-generic ~A \"~A\" (cl:list ~A)~@[ ~{~A~^ ~}~])"
                receiver dotnet-method-name generic-type-args-str param-names)
        (format nil "(dotnet:call-out ~A \"~A\"~@[ ~{~A~^ ~}~])"
                receiver dotnet-method-name param-names))))

(defun generate-single-out-overload (stream m mname fq-name static-p)
  "Generates the Lisp wrapper function for a single out-only C# overload
   (out-only-method-p) -- mirrors generate-single-overload, but every :out
   parameter is omitted from the lambda list entirely and the body forwards
   to dotnet:call-out/dotnet:call-out-generic, which returns the method's
   own return value as the primary value followed by each out parameter's
   final value, in C# declaration order (documented in the generated
   docstring, ahead of the ordinary summary/returns/parameters block)."
  (let* ((m-doc (getf m :documentation))
         (summary (getf m-doc :summary))
         (returns (getf m-doc :returns))
         (all-params (getf m :parameters))
         (in-params (remove-if (lambda (p) (getf p :out)) all-params))
         (out-param-names (mapcar (lambda (p) (map-param-name (getf p :name)))
                                   (remove-if-not (lambda (p) (getf p :out)) all-params)))
         (is-generic-p (getf m :is-generic))
         (generic-type-names (and is-generic-p (generic-type-param-names (getf m :generic-arity))))
         (generic-type-args-str (format nil "~{~A~^ ~}" generic-type-names))
         (param-names (mapcar (lambda (p) (map-param-name (getf p :name))) in-params))
         (args-str (cond
                     ((and static-p is-generic-p)
                      (format nil "~A~@[ ~{~A~^ ~}~]" generic-type-args-str param-names))
                     (static-p
                      (format nil "~{~A~^ ~}" param-names))
                     (is-generic-p
                      (format nil "~A obj!~@[ ~{~A~^ ~}~]" generic-type-args-str param-names))
                     (t
                      (format nil "obj!~@[ ~{~A~^ ~}~]" param-names))))
         (out-note (format nil "Returns (cl:values <primary-return> ~{~A~^ ~}) -- ~A"
                            out-param-names (method-signature-str m)))
         (body (build-docstring summary returns in-params m-doc m))
         (docstring (if (> (length body) 0)
                        (format nil "~A~%~A" out-note body)
                        out-note))
         (escaped-docstring (escape-lisp-string docstring))
         (dotnet-method-name (or (getf m :mangled-name) (getf m :name))))
    (format stream "(cl:defun ~A (~A)~%" (safe-symbol-token mname) args-str)
    (when (> (length escaped-docstring) 0)
      (format stream "  \"~A\"~%" escaped-docstring))
    (format stream "  ~A)~%~%"
            (format-call-out-invocation-expr fq-name dotnet-method-name static-p is-generic-p generic-type-args-str param-names))))

(defun make-filtered-out-method (m)
  "Returns a shallow copy of method plist M with :parameters replaced by
   only its non-out parameters, preserving relative order -- the parameter
   view every Master Wrapper helper (common-parameter-prefix,
   format-master-overload-condition, master-overload-param-names, etc.)
   should see for an out-only overload, since dotnet:call-out's in-args
   must be supplied in this same relative order and never include an out
   slot at all."
  (let ((copy (copy-list m))
        (in-params (remove-if (lambda (p) (getf p :out)) (getf m :parameters))))
    (setf (getf copy :parameters) in-params)
    copy))

(defun generate-out-master-wrapper (stream methods name mname fq-name static-p is-generic-p)
  "Generates a Master-Wrapper-style out-only dispatcher for multiple
   out-only overloads of one C# method NAME, mirroring generate-master-
   wrapper's dispatch/&optional/&key machinery exactly (via the same shared
   helpers, operating on each overload's non-out parameters only -- see
   make-filtered-out-method), but each cond clause's action calls
   dotnet:call-out/dotnet:call-out-generic (format-call-out-invocation-
   expr) instead of dotnet:invoke/static, since dotnet:call-out already
   returns every out parameter as an additional value. All of METHODS is
   assumed to share one generic arity -- an out-only method name overloaded
   across different generic arities has no two-tier generic-arity dispatch
   here (unlike generate-method-name-wrappers); this v1 scope is documented
   in doc/plan-fable-detail-05.md."
  (let* ((filtered (mapcar #'make-filtered-out-method methods))
         (generic-arity (and is-generic-p (getf (first methods) :generic-arity)))
         (generic-type-names (and is-generic-p (generic-type-param-names generic-arity)))
         (raw-prefix (common-parameter-prefix filtered))
         (prefix-len (length raw-prefix))
         (max-mand-len (max-mandatory-parameter-len filtered))
         (raw-opt-params (collect-optional-positional-params filtered prefix-len max-mand-len))
         (uniquified (uniquify-positional-params (append raw-prefix raw-opt-params)))
         (prefix (subseq uniquified 0 prefix-len))
         (opt-params (nthcdr prefix-len uniquified))
         (prefix-names (mapcar (lambda (p) (map-param-name (getf p :name))) prefix))
         (opt-param-names (mapcar (lambda (p) (map-param-name (getf p :name))) opt-params))
         (key-params (collect-key-params filtered max-mand-len (append prefix-names opt-param-names)))
         (args-list nil))
    (when is-generic-p
      (setf args-list (append args-list generic-type-names)))
    (unless static-p
      (setf args-list (append args-list (list "obj!"))))
    (setf args-list (append args-list prefix-names))
    (when opt-params
      (setf args-list (append args-list (list "cl:&optional")))
      (dolist (op opt-params)
        (let* ((op-name (map-param-name (getf op :name)))
               (supplied-var (format nil "supplied-~A" op-name)))
          (setf args-list (append args-list (list (format nil "(~A cl:nil ~A)" op-name supplied-var)))))))
    (when key-params
      (setf args-list (append args-list (list "cl:&key")))
      (dolist (kp key-params)
        (let* ((kp-name (map-param-name (getf kp :name)))
               (kp-default (find-parameter-default-str (getf kp :name) filtered))
               (supplied-var (format nil "supplied-~A" kp-name)))
          (setf args-list (append args-list (list (format nil "(~A ~A ~A)" kp-name kp-default supplied-var)))))))

    (format stream "(cl:defun ~A (~{~A~^ ~})~%" (safe-symbol-token mname) args-list)
    (let* ((header (format nil "Master wrapper for ~A.~A out-only overloads. Dispatches at runtime. Each out parameter is returned as an additional cl:values result (after the primary return value), in C# declaration order." fq-name name))
           (docstring (format-combined-overloads-docstring header #'method-signature-str methods))
           (escaped-docstring (escape-lisp-string docstring)))
      (format stream "  \"~A\"~%" escaped-docstring))
    (format stream "  (cl:cond~%")

    ;; Sort by effective (mandatory) arity for specificity, exactly like
    ;; generate-master-wrapper -- comparing each pair's FILTERED (non-out)
    ;; parameter list, since that's the arity that actually governs dispatch
    ;; here, while still emitting the ORIGINAL method plist's own
    ;; :mangled-name/:name for the call.
    (let ((sorted-pairs (sort (mapcar #'cons methods filtered) #'master-wrapper-more-specific-p :key #'cdr)))
      (dolist (pair sorted-pairs)
        (let* ((cm-orig (car pair))
               (cm-filtered (cdr pair))
               (cond-str (format-master-overload-condition cm-filtered prefix opt-params key-params))
               (call-param-names (master-overload-param-names cm-filtered prefix opt-params key-params))
               (dotnet-method-name (or (getf cm-orig :mangled-name) name))
               (type-args-str (format nil "~{~A~^ ~}" generic-type-names))
               (action-str (format-call-out-invocation-expr fq-name dotnet-method-name static-p is-generic-p type-args-str call-param-names)))
          (format stream "    (~A~%" cond-str)
          (format stream "     ~A)~%" action-str))))

    (let ((supplied-args-expr (format-supplied-args-expr prefix opt-params key-params)))
      (format stream "    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found~%")
      (format stream "                    :package-name \"~A\"~%" (string-upcase (type-fq-name-to-pkg-name fq-name)))
      (format stream "                    :class-name <type-str>~%")
      (format stream "                    :method-name \"~A\"~%" name)
      (format stream "                    :supplied-args ~A))))~%~%" supplied-args-expr))))

(defun generate-out-method-name-wrappers (stream out-methods name mname fq-name static-p)
  "Generates the public Lisp wrapper function for one C# method NAME's
   already static/instance-partitioned OUT-METHODS (out-only-method-p),
   under MNAME (out-method-wrapper-name): generate-single-out-overload for
   a lone non-complex overload, generate-out-master-wrapper (mirroring
   generate-master-wrapper's dispatch, but via dotnet:call-out) for a
   complex group of out-only overloads sharing this name. Complex here uses
   the same complex-group-p test clean overloads do (more than one
   overload, or a single overload with a usable-default parameter)."
  (if (and (= (length out-methods) 1) (not (complex-group-p out-methods)))
      (generate-single-out-overload stream (first out-methods) mname fq-name static-p)
      (generate-out-master-wrapper stream out-methods name mname fq-name static-p (getf (first out-methods) :is-generic))))
