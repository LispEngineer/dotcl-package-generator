;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Developed with Antigravity CLI (Gemini 3.5 Flash and 3.1 Pro)
;;;
;;; C# Assembly Lisp Package Generator -- batch entry resolution and related-class discovery
;;; Split out of the former assembly-package-generator.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :assembly-package-generator)


(defun make-resolved-class (class-plist constant-properties
                             &optional export-parents export-interfaces export-object
                               defgeneric extension-methods
                               output-nested output-children output-implementations
                               ensure-type)
  "Builds a resolved-class plist: the unit of work generate-class-file,
   generate-batch-packages-file, generate-batch-asd-file, and the
   parents/interfaces re-export machinery all operate on. CLASS-PLIST is
   the type's metadata plist; CONSTANT-PROPERTIES is the split
   constant-properties-list (or nil, and always nil for a class pulled in
   only via discovery -- see EXPAND-RELATED / GENERATE-ASSEMBLY-PACKAGES-
   BATCH's Version 39 work-queue Phase B, doc/plan-v38.md's Part B).
   EXPORT-PARENTS/EXPORT-INTERFACES/EXPORT-OBJECT/OUTPUT-NESTED/OUTPUT-
   CHILDREN/OUTPUT-IMPLEMENTATIONS (all nil for a class not itself
   requesting any discovery) mirror the manifest's per-class flags of the
   same names; as of Version 39 a class discovered via any of them carries
   the *entire* flag set (all six of these, plus DEFGENERIC/EXTENSION-
   METHODS/ENSURE-TYPE below) of the class that discovered it, propagated
   verbatim by GENERATE-ASSEMBLY-PACKAGES-BATCH's work queue, so
   discovery/re-export cascades recursively through the whole connected
   component a flag reaches -- see PLAN.md's \"Recursive Related-Class
   Discovery\" section. DEFGENERIC (nil unless requested or propagated)
   mirrors the manifest's per-class :defgeneric flag -- opts a class into
   the shared CSHARP-GENERICS package of unified CLOS generic functions
   (see doc/make-everything-defgeneric.md). EXTENSION-METHODS (nil unless
   requested or propagated; defaults to t at the CLI level for an
   explicitly-requested class -- see Program.cs's enableExtensionMethods)
   mirrors the manifest's per-class :extension-methods flag (Version 38,
   doc/plan-v38.md) -- whether this class's package should have matching
   C# extension methods injected as obj!-first wrappers. ENSURE-TYPE (nil
   unless requested or propagated; defaults to nil at the CLI level -- see
   Program.cs's ensureType) mirrors the manifest's per-class :ensure-type
   flag (Version 44, doc/generator-design-notes.md) -- whether
   generate-class-file should emit the \"Register C# Type with CLOS\"
   eval-when (EnsureDotNetTypeClass) at all; see
   emit-type-constants-and-clos-registration. The stored
   :matched-extensions/:skipped-extensions slots (initially nil) are
   filled in separately by GENERATE-ASSEMBLY-PACKAGES-BATCH once the whole
   working set and the extension-method index are available -- see
   COMPUTE-MATCHED-EXTENSIONS-FOR-CLASS."
  (list :class-plist class-plist
        :constant-properties constant-properties
        :export-parents export-parents
        :export-interfaces export-interfaces
        :export-object export-object
        :output-nested output-nested
        :output-children output-children
        :output-implementations output-implementations
        :defgeneric defgeneric
        :extension-methods extension-methods
        :ensure-type ensure-type
        :matched-extensions nil
        :skipped-extensions nil))

(defun resolve-batch-entry (entry)
  "Loads ENTRY's :metadata-file and resolves each of its :classes by
   :fully-qualified-name against the loaded metadata. Returns two values:
   a list of resolved-class plists (see make-resolved-class) ready for
   generate-class-file, and a list of class names from :classes that could
   not be found in the metadata (empty if all resolved, or if :classes was
   empty, which is a valid metadata-only request)."
  (let* ((metadata-file (getf entry :metadata-file))
         (classes (getf entry :classes)))
    (unless (probe-file metadata-file)
      (error "Metadata file not found: ~A" metadata-file))
    (let ((metadata (utils:safe-read-form-from-file metadata-file))
          (resolved nil)
          (not-found nil))
      (dolist (class-entry classes)
        (let* ((cname (getf class-entry :name))
               (cprops-str (getf class-entry :constant-properties))
               (cprops (and cprops-str (> (length cprops-str) 0) (split-string cprops-str #\,)))
               (cls (find cname metadata :key (lambda (c) (getf c :fully-qualified-name)) :test #'string=)))
          (if cls
              (push (make-resolved-class cls cprops
                                          (getf class-entry :export-parents)
                                          (getf class-entry :export-interfaces)
                                          (getf class-entry :export-object)
                                          (getf class-entry :defgeneric)
                                          (getf class-entry :extension-methods)
                                          (getf class-entry :output-nested)
                                          (getf class-entry :output-children)
                                          (getf class-entry :output-implementations)
                                          (getf class-entry :ensure-type))
                    resolved)
              (push cname not-found))))
      (values (nreverse resolved) (nreverse not-found)))))

(defun build-metadata-index (assembly-entries)
  "Loads every entry's :metadata-file once (even when shared by more than
   one entry) and returns a hash table mapping each type's
   :fully-qualified-name (string) to (cons type-plist owning-entry), where
   OWNING-ENTRY is the ASSEMBLY-ENTRIES element whose metadata file the type
   was read from. Used by expand-related to resolve a class's
   superclasses/interfaces across every assembly provided on the command
   line, not just the one the requesting class belongs to."
  (let ((index (make-hash-table :test #'equal))
        (loaded (make-hash-table :test #'equal)))
    (dolist (entry assembly-entries)
      (let ((metadata-file (getf entry :metadata-file)))
        (unless (gethash metadata-file loaded)
          (setf (gethash metadata-file loaded) t)
          (unless (probe-file metadata-file)
            (error "Metadata file not found: ~A" metadata-file))
          (let ((metadata (utils:safe-read-form-from-file metadata-file)))
            (dolist (type-plist metadata)
              (let ((fq-name (getf type-plist :fully-qualified-name)))
                (unless (gethash fq-name index)
                  (setf (gethash fq-name index) (cons type-plist entry)))))))))
    index))

(defun build-reverse-indexes (metadata-index)
  "Given METADATA-INDEX (from build-metadata-index -- every distinct type
   across every provided assembly), returns (values subclass-index
   implementer-index), the two downward-discovery indexes Version 39's
   --output-children/--output-implementations need (doc/plan-v38.md's Part
   B): SUBCLASS-INDEX maps a superclass fully-qualified-name (string) to a
   list of (type-plist . owning-entry) conses -- one per type whose own
   :superclass is exactly that name (a DIRECT subclass only; transitive
   subclasses are reached by EXPAND-RELATED re-querying this index for each
   newly-discovered subclass in turn, the same work-queue recursion
   EXPAND-ANCESTORS already uses for the upward directions).
   IMPLEMENTER-INDEX maps an interface fully-qualified-name to a list of
   (type-plist . owning-entry) conses -- one per type whose :interfaces
   list contains that name; since .NET's Type.GetInterfaces() is already
   transitive (an implementing subclass's own :interfaces already includes
   every interface its base classes implement too), no further recursion
   is needed on this side -- every direct or indirect implementer is found
   in one pass. Both indexes are built directly from METADATA-INDEX's own
   values, preserving first-seen order per bucket, exactly like
   BUILD-EXTENSION-METHOD-INDEX. Nested-type discovery (--output-nested)
   needs no precomputed index at all -- see EXPAND-RELATED's own prefix
   scan over METADATA-INDEX's keys."
  (let ((subclass-index (make-hash-table :test #'equal))
        (implementer-index (make-hash-table :test #'equal)))
    (maphash (lambda (fq-name pair)
               (declare (ignore fq-name))
               (let* ((type-plist (car pair))
                      (super (getf type-plist :superclass)))
                 (when super
                   (setf (gethash super subclass-index)
                         (nconc (gethash super subclass-index) (list pair))))
                 (dolist (iface (getf type-plist :interfaces))
                   (setf (gethash iface implementer-index)
                         (nconc (gethash iface implementer-index) (list pair))))))
             metadata-index)
    (values subclass-index implementer-index)))

(defun build-extension-method-index (metadata-index)
  "Given METADATA-INDEX (from build-metadata-index -- every distinct type
   across every provided assembly), returns a hash table mapping each
   extension method's exact, concrete 'this'-type fully-qualified-name
   (string) to a list of (method-plist holder-plist holder-assembly-name)
   entries, in first-seen order -- one entry per C# extension method (a
   static method, on a static holder type, whose first parameter carries
   :extension-this t) found anywhere in the provided assemblies.

   Version 38's matching rule is v1/exact-concrete-only (see PLAN.md and
   doc/plan-v38.md): a method whose :extension-this parameter's :type is an
   open generic (checked defensively via GENERIC-TYPE-P, though in practice
   the '!' marker it looks for never appears in this repo's real metadata)
   is excluded here so it can never coincidentally string= a concrete
   class's :fully-qualified-name; an open-generic 'this' type's formatted
   string (e.g. \"System.Collections.Generic.IEnumerable`1[TSource]\") also
   never naturally matches any real type's own :fully-qualified-name (which
   for an open generic type definition has no bracketed arguments at all,
   e.g. \"System.Collections.Generic.List`1\"), so this guard is belt-and-
   suspenders documentation of intent rather than the sole safeguard.
   Base-class/interface 'this'-type matching is out of scope for Version 38
   -- see doc/plan-v38.md's \"Deferred / Future\" section."
  (let ((index (make-hash-table :test #'equal)))
    (maphash (lambda (fq-name pair)
               (declare (ignore fq-name))
               (let* ((holder-plist (car pair))
                      (owning-entry (cdr pair))
                      (assembly-name (getf owning-entry :assembly-name)))
                 (dolist (m (getf holder-plist :methods))
                   (when (getf m :extension-method)
                     (let* ((params (getf m :parameters))
                            (this-param (first params)))
                       (when (and this-param (getf this-param :extension-this))
                         (let ((this-type (getf this-param :type)))
                           (unless (generic-type-p this-type)
                             (setf (gethash this-type index)
                                   (nconc (gethash this-type index)
                                          (list (list m holder-plist assembly-name))))))))))))
             metadata-index)
    index))

(defun extension-method-dirty-or-generic-reason (method-plist)
  "Returns :dirty, :generic, or nil for METHOD-PLIST (an extension-method
   candidate from build-extension-method-index), checking only its non-
   'this' parameters -- the first parameter (:extension-this t) is the
   receiver being matched against a class's :fully-qualified-name and is
   never itself dirty/generic in practice, so it is deliberately excluded
   from these checks. Mirrors dirty-method-p's parameter-modifier checks
   and clean-method-p's generic-type-p checks, but is not defined in terms
   of either since both operate on a method's full :parameters list
   including the 'this' parameter this function must skip. :generic covers
   both the method's own generic type argument(s) (:is-generic t -- its
   wrapper would need type-argument parameter(s) before obj!, breaking the
   uniform obj!-first instance-style shape every other injected wrapper
   shares) and the rarer case of a non-generic extension method on a
   generic holder class referencing that class's own open type parameter in
   a non-'this' parameter or the return type."
  (let ((params (rest (getf method-plist :parameters))))
    (cond
      ((getf method-plist :is-generic) :generic)
      ((some (lambda (p) (or (getf p :has-default) (getf p :out)
                              (getf p :ref) (getf p :ref-readonly) (getf p :params)))
             params)
       :dirty)
      ((or (generic-type-p (getf method-plist :return-type))
           (some (lambda (p) (generic-type-p (getf p :type))) params))
       :generic)
      (t nil))))

(defun compute-matched-extensions-for-class (class-plist constant-properties-list extension-index)
  "Given CLASS-PLIST, its CONSTANT-PROPERTIES-LIST, and EXTENSION-INDEX
   (from build-extension-method-index), returns (values survivors skipped)
   for this class's exact-concrete-match extension-method candidates (see
   doc/plan-v38.md's \"Per-candidate skip rules\"):

   SURVIVORS is a list of (method-plist holder-plist holder-assembly-name)
   entries (build-extension-method-index's own element shape) to actually
   generate obj!-first wrappers for, in first-seen order.

   SKIPPED is a list of (method-plist holder-plist reason) entries for
   comment generation, where REASON is :dirty, :generic, :own (the class
   already declares a member mapping to the same Lisp name -- the class's
   own member wins), or (:ambiguous lisp-name) (more than one surviving
   candidate maps to the same Lisp name -- extension-method overload
   dispatch is deferred, see doc/plan-v38.md's \"Deferred / Future\").

   Applied in three passes, matching the plan's stated precedence: (1)
   dirty/generic candidates are skipped individually and never considered
   for the later passes; (2) of what remains, any whose Lisp name collides
   with CLASS-PLIST's own declared export set (compute-package-exports-and-
   shadows, called here with no matched-extensions of its own -- an
   extension wrapper never collides with another extension wrapper's own
   existence, only with a declared member) is skipped; (3) of what remains
   after that, candidates are grouped by Lisp name and any group of more
   than one entry is skipped in full as ambiguous."
  (let ((candidates (gethash (getf class-plist :fully-qualified-name) extension-index)))
    (if (null candidates)
        (values nil nil)
        (multiple-value-bind (own-exports own-shadows)
            (compute-package-exports-and-shadows class-plist constant-properties-list)
          (declare (ignore own-shadows))
          (let ((skipped nil)
                (ok-candidates nil))
            ;; Pass 1: dirty/generic exclusion.
            (dolist (c candidates)
              (let* ((method-plist (first c))
                     (reason (extension-method-dirty-or-generic-reason method-plist)))
                (if reason
                    (push (list method-plist (second c) reason) skipped)
                    (push c ok-candidates))))
            (setf ok-candidates (nreverse ok-candidates))
            ;; Pass 2: name collision with the class's own declared members.
            (let ((remaining nil))
              (dolist (c ok-candidates)
                (let* ((method-plist (first c))
                       (lisp-name (map-member-name (getf method-plist :name))))
                  (if (member lisp-name own-exports :test #'string=)
                      (push (list method-plist (second c) :own) skipped)
                      (push (cons lisp-name c) remaining))))
              (setf remaining (nreverse remaining))
              ;; Pass 3: group by Lisp name; a group of exactly one survives,
              ;; a group of more than one is ambiguous and fully skipped.
              (let ((tally (make-hash-table :test #'equal))
                    (order nil)
                    (survivors nil))
                (dolist (r remaining)
                  (let ((lisp-name (car r)))
                    (unless (gethash lisp-name tally) (push lisp-name order))
                    (push (cdr r) (gethash lisp-name tally))))
                (dolist (lisp-name (nreverse order))
                  (let ((group (nreverse (gethash lisp-name tally))))
                    (if (> (length group) 1)
                        (dolist (c group)
                          (push (list (first c) (second c) (list :ambiguous lisp-name)) skipped))
                        (push (first group) survivors))))
                (values (nreverse survivors) (nreverse skipped)))))))))

(defun expand-related (class-plist export-parents export-interfaces export-object
                        output-nested output-children output-implementations
                        index subclass-index implementer-index)
  "Given CLASS-PLIST and its own carried per-class direction flags, returns
   (values ancestor-discovered downward-discovered missing).

   ANCESTOR-DISCOVERED is CLASS-PLIST's COMPLETE, already-flattened,
   multi-level ancestor closure -- a list of (type-plist . owning-entry)
   conses, in first-seen (breadth-first) order, computed via this
   function's own SELF-CONTAINED internal work queue (mirroring exactly
   what the pre-Version-39 EXPAND-ANCESTORS did): EXPORT-PARENTS walks the
   :superclass chain link-by-link up to System.Object (excluded unless
   EXPORT-OBJECT; a nil :superclass ends that branch); EXPORT-INTERFACES
   walks :interfaces (already fully transitive per type, since .NET's
   Type.GetInterfaces() includes every base type's own interfaces); each
   newly-found ancestor's own :superclass/:interfaces are queued too, under
   the same two flags, so a grandparent's members are reached in the SAME
   single call. This completeness is required for re-export correctness:
   CLASS-PLIST's re-export block is computed once, from ANCESTOR-DISCOVERED
   as a flat list (see EMIT-CHILD-REEXPORTS) -- it does not itself see
   whatever an ancestor may separately re-export from further up the chain
   (that ancestor's own re-export block is a load-time cl:import/cl:export
   side effect, invisible to this generation-time computation), so
   ANCESTOR-DISCOVERED must already include every level itself, not just
   the immediate parent. This is a per-class computation, independent of
   any outer recursion -- unlike DOWNWARD-DISCOVERED below, whose multi-hop
   completeness comes entirely from the caller's own outer work queue.

   DOWNWARD-DISCOVERED is a list of (type-plist . owning-entry) conses from
   OUTPUT-NESTED (every type in INDEX whose fully-qualified-name has
   CLASS-PLIST's own fully-qualified-name plus \"+\" as a prefix -- a single
   scan already reaches every nesting depth, since a nested-of-nested
   type's FQ name also carries the outer type's FQ name as a prefix),
   OUTPUT-CHILDREN (SUBCLASS-INDEX's DIRECT-subclass bucket for CLASS-
   PLIST's own fully-qualified-name ONLY -- indirect/transitive subclasses
   are reached only when the caller's OUTER work queue later re-invokes
   this function on each direct subclass, which inherits OUTPUT-CHILDREN
   via flag propagation), and/or OUTPUT-IMPLEMENTATIONS (IMPLEMENTER-
   INDEX's bucket for CLASS-PLIST's own fully-qualified-name, already fully
   transitive per .NET's Type.GetInterfaces()). These three are always
   GENERATE-ONLY: never a re-export source for anything (CLASS-PLIST is
   only ever a *discovery seed* for them, never something they feed
   members back into), so unlike ANCESTOR-DISCOVERED there is no static
   flattening-correctness requirement -- each discovered type simply
   becomes its own independent package, so relying on the outer queue's
   own recursion for OUTPUT-CHILDREN's transitivity is safe. The caller
   must never fold DOWNWARD-DISCOVERED into child-ancestor-fqs.

   MISSING is a list of (fq-name . from-fq-name) conses, exactly as the
   pre-Version-39 EXPAND-ANCESTORS produced -- only EXPORT-PARENTS/
   EXPORT-INTERFACES have a 'missing' concept (a named ancestor INDEX
   cannot resolve, anywhere in the chain); the three downward directions
   merely enumerate whatever concretely exists in INDEX/SUBCLASS-INDEX/
   IMPLEMENTER-INDEX, so there is nothing that can be 'missing' for them.

   See doc/plan-v38.md's Part B and PLAN.md's \"Recursive Related-Class
   Discovery\" section: GENERATE-ASSEMBLY-PACKAGES-BATCH's outer work queue
   calls this function once per class (seeded by every explicitly-requested
   class, then again for every newly-discovered one, carrying that
   discoverer's ENTIRE flag set verbatim), folding both return lists'
   not-yet-seen entries into the working set -- but only ANCESTOR-DISCOVERED
   into child-ancestor-fqs."
  (let ((self-fq (getf class-plist :fully-qualified-name))
        (downward-discovered nil))
    (multiple-value-bind (ancestor-discovered missing)
        (when (or export-parents export-interfaces)
          (let ((local-visited (make-hash-table :test #'equal))
                (queue nil)
                (ancestors nil)
                (local-missing nil))
            (setf (gethash self-fq local-visited) t)
            (flet ((enqueue (fq from)
                     (unless (gethash fq local-visited)
                       (setf (gethash fq local-visited) t)
                       (setf queue (nconc queue (list (cons fq from)))))))
              (when export-parents
                (let ((super (getf class-plist :superclass)))
                  (when super (enqueue super self-fq))))
              (when export-interfaces
                (dolist (iface (getf class-plist :interfaces))
                  (enqueue iface self-fq)))
              (loop while queue
                    do (let* ((entry (pop queue))
                              (fq (car entry))
                              (from (cdr entry)))
                         (unless (and (string= fq "System.Object") (not export-object))
                           (let ((found (gethash fq index)))
                             (if (null found)
                                 (push (cons fq from) local-missing)
                                 (let ((ancestor-plist (car found)))
                                   (push found ancestors)
                                   (when export-parents
                                     (let ((super (getf ancestor-plist :superclass)))
                                       (when super (enqueue super fq))))
                                   (when export-interfaces
                                     (dolist (iface (getf ancestor-plist :interfaces))
                                       (enqueue iface fq))))))))))
            (values (nreverse ancestors) (nreverse local-missing))))
      (when output-nested
        (let ((prefix (concatenate 'string self-fq "+")))
          (maphash (lambda (fq pair)
                     (when (and (>= (length fq) (length prefix))
                                (string= fq prefix :end1 (length prefix)))
                       (push pair downward-discovered)))
                   index)))
      (when output-children
        (dolist (pair (gethash self-fq subclass-index))
          (push pair downward-discovered)))
      (when output-implementations
        (dolist (pair (gethash self-fq implementer-index))
          (push pair downward-discovered)))
      (values ancestor-discovered (nreverse downward-discovered) missing))))
