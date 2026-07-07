;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Tests for AssemblyToLispyTestTarget.dll metadata

(in-package :package-generator-tests)

(def-assembly-test "AssemblyToLispyTestTarget.dll" test-synthetic-target
  ;; Test ByteEnum
  (let ((enm (find-if (lambda (cls) (string= (getf cls :name) "ByteEnum")) *metadata*)))
    (assert-not-null enm "Should find ByteEnum")
    (when enm
      (assert-equal :enum (getf enm :kind) "ByteEnum is an enum")
      (assert-equal "System.Byte" (getf enm :enum-underlying-type) "ByteEnum underlying type is byte")))

  ;; Test IDummyInterface
  (let ((iface (find-if (lambda (cls) (string= (getf cls :name) "IDummyInterface")) *metadata*)))
    (assert-not-null iface "Should find IDummyInterface")
    (when iface
      (assert-equal :interface (getf iface :kind) "IDummyInterface is an interface")
      (assert-true (member :abstract (getf iface :flags)) "Interfaces should be abstract")))

  ;; Test AbstractBase
  (let ((abs (find-if (lambda (cls) (string= (getf cls :name) "AbstractBase")) *metadata*)))
    (assert-not-null abs "Should find AbstractBase")
    (when abs
      (assert-equal :class (getf abs :kind) "AbstractBase is a class")
      (assert-true (member :abstract (getf abs :flags)) "AbstractBase should be abstract")
      (let ((ctors (getf abs :constructors)))
        (assert-true (> (length ctors) 0) "Should have a constructor")
        (assert-true (getf (car ctors) :protected) "Constructor should be protected"))))

  ;; Test GenericClass
  (let ((gen (find-if (lambda (cls) (string= (getf cls :name) "GenericClass`1")) *metadata*)))
    (assert-not-null gen "Should find GenericClass`1")
    (when gen
      (assert-equal "AssemblyToLispyTestTarget.AbstractBase" (getf gen :superclass) "GenericClass superclass")
      (assert-true (find-if (lambda (i) (string= i "AssemblyToLispyTestTarget.IDummyInterface")) (getf gen :interfaces))
                   "GenericClass interfaces should contain IDummyInterface")
      (let ((op (find-if (lambda (m) (string= (getf m :name) "+")) (getf gen :methods))))
        (assert-not-null op "Should find overloaded operator +")
        (when op
          (assert-equal "op_Addition" (getf op :mangled-name) "+ should have mangled name op_Addition")
          (assert-true (getf op :is-static) "Operator should be static")))))

  ;; Test EdgeCaseStruct
  (let ((strc (find-if (lambda (cls) (string= (getf cls :name) "EdgeCaseStruct")) *metadata*)))
    (assert-not-null strc "Should find EdgeCaseStruct")
    (when strc
      (assert-equal :struct (getf strc :kind) "EdgeCaseStruct is a struct")
      ;; Test modifiers
      (let ((mod-method (find-if (lambda (m) (string= (getf m :name) "ModifierMethod")) (getf strc :methods))))
        (assert-not-null mod-method "Should find ModifierMethod")
        (when mod-method
          (let ((params (getf mod-method :parameters)))
            (assert-equal 4 (length params) "ModifierMethod should have 4 parameters")
            (assert-true (getf (nth 0 params) :out) "First param should be out")
            (assert-true (getf (nth 1 params) :ref) "Second param should be ref")
            (assert-true (getf (nth 2 params) :ref-readonly) "Third param should be ref readonly (in)")
            (assert-true (getf (nth 3 params) :params) "Fourth param should be params array"))))
      
      ;; Test defaults
      (let ((def-method (find-if (lambda (m) (string= (getf m :name) "DefaultsMethod")) (getf strc :methods))))
        (assert-not-null def-method "Should find DefaultsMethod")
        (when def-method
          (let ((params (getf def-method :parameters)))
            (assert-equal "hello" (getf (nth 0 params) :default-value) "First default is string hello")
            (assert-equal 42 (getf (nth 1 params) :default-value) "Second default is int 42")
            (assert-equal nil (getf (nth 2 params) :default-value) "Third default is null (nil)")
            (assert-equal #\A (getf (nth 3 params) :default-value) "Fourth default is char A"))))

      ;; Test the indexer (this[int]): it must be captured with its own
      ;; :parameters (index parameters), the same way a method's parameters
      ;; are captured, so downstream codegen can pass the index argument(s)
      ;; through to get_Item/set_Item.
      (let ((indexer (find-if (lambda (p) (string= (getf p :name) "Item")) (getf strc :properties))))
        (assert-not-null indexer "Should find the Item indexer property")
        (when indexer
          (assert-true (getf indexer :readable) "Indexer should be readable")
          (assert-true (getf indexer :writeable) "Indexer should be writeable")
          (let ((params (getf indexer :parameters)))
            (assert-equal 1 (length params) "Indexer should have exactly 1 index parameter")
            (assert-equal "index" (getf (nth 0 params) :name) "Indexer's index parameter is named index")
            (assert-equal "System.Int32" (getf (nth 0 params) :type) "Indexer's index parameter is System.Int32"))))

      ;; Test public instance fields: PublicField is mutable, ReadOnlyField
      ;; is readonly. Both must be captured as public, non-static fields;
      ;; only ReadOnlyField carries :init-only, which downstream codegen
      ;; uses to decide whether to emit a setter.
      (let ((pub-field (find-if (lambda (f) (string= (getf f :name) "PublicField")) (getf strc :fields))))
        (assert-not-null pub-field "Should find PublicField")
        (when pub-field
          (assert-true (getf pub-field :public) "PublicField should be public")
          (assert-equal nil (getf pub-field :static) "PublicField should not be static")
          (assert-equal nil (getf pub-field :init-only) "PublicField should not be init-only (it's mutable)")))
      (let ((ro-field (find-if (lambda (f) (string= (getf f :name) "ReadOnlyField")) (getf strc :fields))))
        (assert-not-null ro-field "Should find ReadOnlyField")
        (when ro-field
          (assert-true (getf ro-field :public) "ReadOnlyField should be public")
          (assert-equal nil (getf ro-field :static) "ReadOnlyField should not be static")
          (assert-true (getf ro-field :init-only) "ReadOnlyField should be init-only (it's C# readonly)")))

      ;; Test a plain mutable static field: static, but neither literal
      ;; (const) nor init-only (readonly) -- previously fell through every
      ;; classifier and generated nothing at all.
      (let ((mut-field (find-if (lambda (f) (string= (getf f :name) "MutableStaticField")) (getf strc :fields))))
        (assert-not-null mut-field "Should find MutableStaticField")
        (when mut-field
          (assert-true (getf mut-field :static) "MutableStaticField should be static")
          (assert-equal nil (getf mut-field :literal) "MutableStaticField should not be literal/const")
          (assert-equal nil (getf mut-field :init-only) "MutableStaticField should not be init-only")))

      ;; Test a static read-write property and a static write-only
      ;; property: both are :static and :writeable, previously falling
      ;; through every classifier (constant-property-p requires NOT
      ;; writeable) and generating nothing at all.
      (let ((rw-prop (find-if (lambda (p) (string= (getf p :name) "StaticReadWriteProperty")) (getf strc :properties))))
        (assert-not-null rw-prop "Should find StaticReadWriteProperty")
        (when rw-prop
          (assert-true (getf rw-prop :static) "StaticReadWriteProperty should be static")
          (assert-true (getf rw-prop :readable) "StaticReadWriteProperty should be readable")
          (assert-true (getf rw-prop :writeable) "StaticReadWriteProperty should be writeable")))
      (let ((wo-prop (find-if (lambda (p) (string= (getf p :name) "StaticWriteOnlyProperty")) (getf strc :properties))))
        (assert-not-null wo-prop "Should find StaticWriteOnlyProperty")
        (when wo-prop
          (assert-true (getf wo-prop :static) "StaticWriteOnlyProperty should be static")
          (assert-equal nil (getf wo-prop :readable) "StaticWriteOnlyProperty should not be readable")
          (assert-true (getf wo-prop :writeable) "StaticWriteOnlyProperty should be writeable")))))

  ;; Test Extensions
  (let ((ext (find-if (lambda (cls) (string= (getf cls :name) "Extensions")) *metadata*)))
    (assert-not-null ext "Should find Extensions class")
    (when ext
      (let ((ext-method (find-if (lambda (m) (string= (getf m :name) "DummyExtension")) (getf ext :methods))))
        (assert-not-null ext-method "Should find DummyExtension")
        (when ext-method
          (assert-true (getf ext-method :extension-method) "Method should have :extension-method flag")
          (let ((params (getf ext-method :parameters)))
            (assert-true (getf (nth 0 params) :extension-this) "First parameter should be tagged as :extension-this"))))))

  ;; Test GenericMethodTestClass
  (let ((gmc (find-if (lambda (cls) (string= (getf cls :name) "GenericMethodTestClass")) *metadata*)))
    (assert-not-null gmc "Should find GenericMethodTestClass")
    (when gmc
      (let ((load-method (find-if (lambda (m) (string= (getf m :name) "Load")) (getf gmc :methods))))
        (assert-not-null load-method "Should find Load method")
        (when load-method
          (assert-true (getf load-method :is-generic) "Load method should be generic")
          (assert-equal 1 (getf load-method :generic-arity) "Load generic-arity should be 1")
          (assert-equal nil (getf load-method :is-static) "Load method should be instance")))
      (let ((create-method (find-if (lambda (m) (string= (getf m :name) "Create")) (getf gmc :methods))))
        (assert-not-null create-method "Should find Create method")
        (when create-method
          (assert-true (getf create-method :is-generic) "Create method should be generic")
          (assert-equal 1 (getf create-method :generic-arity) "Create generic-arity should be 1")
          (assert-true (getf create-method :is-static) "Create method should be static")))

      ;; Test generic methods with more than one type argument (the
      ;; capability being added alongside arity-1 support): Convert<T1,T2>
      ;; and Zip<T1,T2,T3> must both reflect a positive :generic-arity
      ;; matching their declared number of type parameters.
      (let ((convert-method (find-if (lambda (m) (string= (getf m :name) "Convert")) (getf gmc :methods))))
        (assert-not-null convert-method "Should find Convert method")
        (when convert-method
          (assert-true (getf convert-method :is-generic) "Convert method should be generic")
          (assert-equal 2 (getf convert-method :generic-arity) "Convert generic-arity should be 2")
          (assert-equal nil (getf convert-method :is-static) "Convert method should be instance")))
      (let ((zip-method (find-if (lambda (m) (string= (getf m :name) "Zip")) (getf gmc :methods))))
        (assert-not-null zip-method "Should find Zip method")
        (when zip-method
          (assert-true (getf zip-method :is-generic) "Zip method should be generic")
          (assert-equal 3 (getf zip-method :generic-arity) "Zip generic-arity should be 3")
          (assert-true (getf zip-method :is-static) "Zip method should be static")))

      ;; Test the same method name overloaded across *different* generic
      ;; arities (Combine<T1> vs Combine<T1,T2>, mirroring
      ;; System.Linq.Enumerable's real-world Aggregate): both overloads must
      ;; be present in :methods with their own distinct :generic-arity, so
      ;; the generator can split them into separately-named wrappers
      ;; (see split-by-generic-arity in package-generator-tests.lisp).
      (let ((combine-methods (remove-if-not (lambda (m) (string= (getf m :name) "Combine")) (getf gmc :methods))))
        (assert-equal 2 (length combine-methods) "Should find exactly 2 Combine overloads")
        (assert-true (find 1 combine-methods :key (lambda (m) (getf m :generic-arity)))
                     "One Combine overload should have generic-arity 1")
        (assert-true (find 2 combine-methods :key (lambda (m) (getf m :generic-arity)))
                     "The other Combine overload should have generic-arity 2"))))

  ;; Test nested types (NestingContainer+NestedLevel2 and
  ;; NestingContainer+NestedLevel2+NestedLevel3): the CIL '+' separator
  ;; must survive verbatim in :fully-qualified-name (needed for live type
  ;; resolution via monoutils:get-type), and the type must be tagged :nested.
  (let ((lvl2 (find-if (lambda (cls)
                          (string= (getf cls :fully-qualified-name)
                                   "AssemblyToLispyTestTarget.NestingContainer+NestedLevel2"))
                        *metadata*)))
    (assert-not-null lvl2 "Should find NestingContainer+NestedLevel2 by its CIL-separated fully-qualified-name")
    (when lvl2
      (assert-equal "NestedLevel2" (getf lvl2 :name) "NestedLevel2's :name is its simple name, without '+'")
      (assert-true (member :nested (getf lvl2 :flags)) "NestedLevel2 should have the :nested flag")))

  (let ((lvl3 (find-if (lambda (cls)
                          (string= (getf cls :fully-qualified-name)
                                   "AssemblyToLispyTestTarget.NestingContainer+NestedLevel2+NestedLevel3"))
                        *metadata*)))
    (assert-not-null lvl3 "Should find NestingContainer+NestedLevel2+NestedLevel3 (two levels of '+' nesting)")
    (when lvl3
      (assert-equal "NestedLevel3" (getf lvl3 :name) "NestedLevel3's :name is its simple name, without '+'")
      (assert-true (member :nested (getf lvl3 :flags)) "NestedLevel3 should have the :nested flag")))

  ;; Test Version 40's :superclass/:interfaces generic-identity fix (see
  ;; doc/generator-design-notes.md's "Generic Superclass/Interface Identity
  ;; Matching (Version 40)" section):
  ;;
  ;; GenericBaseForSuperclassTest<T>'s own base is System.Collections.Generic.List<T>,
  ;; referencing GenericBaseForSuperclassTest's OWN unresolved type parameter --
  ;; Type.FullName is documented to return null for this case, and the pre-fix
  ;; code fell back to Type.Name, silently losing the "System.Collections.Generic."
  ;; namespace prefix (producing bare "List`1"). :superclass must be the full,
  ;; correctly-namespaced generic type DEFINITION identity.
  (let ((gbfst (find-if (lambda (cls)
                          (string= (getf cls :fully-qualified-name)
                                   "AssemblyToLispyTestTarget.GenericBaseForSuperclassTest`1"))
                        *metadata*)))
    (assert-not-null gbfst "Should find GenericBaseForSuperclassTest`1")
    (when gbfst
      (assert-equal "System.Collections.Generic.List`1" (getf gbfst :superclass)
                    "GenericBaseForSuperclassTest`1's :superclass must keep its full namespace, not fall back to a bare Type.Name")
      ;; List<T> here is itself parameterized by GenericBaseForSuperclassTest's
      ;; own (still unresolved) type parameter, so GetFriendlyTypeName still
      ;; renders it with a bracketed argument -- :superclass-closed is present
      ;; but is not expected to equal the bare identity form.
      (assert-not-null (getf gbfst :superclass-closed)
                        "GenericBaseForSuperclassTest`1's :superclass-closed should be present (its base is generic)")))

  ;; ConcreteDerivedFromGeneric derives from a CLOSED instantiation
  ;; (GenericBaseForSuperclassTest<EdgeCaseStruct>) of a generic type DEFINED IN
  ;; THIS SAME ASSEMBLY. Before the fix, :superclass would have been the full,
  ;; assembly-qualified CLR form of that closed instantiation -- unable to
  ;; string-match GenericBaseForSuperclassTest`1's own bare
  ;; :fully-qualified-name above, so --export-parents could never resolve it.
  (let ((cdfg (find-if (lambda (cls)
                         (string= (getf cls :fully-qualified-name)
                                  "AssemblyToLispyTestTarget.ConcreteDerivedFromGeneric"))
                       *metadata*)))
    (assert-not-null cdfg "Should find ConcreteDerivedFromGeneric")
    (when cdfg
      (assert-equal "AssemblyToLispyTestTarget.GenericBaseForSuperclassTest`1" (getf cdfg :superclass)
                    "ConcreteDerivedFromGeneric's :superclass must be the bare generic type DEFINITION identity, matching GenericBaseForSuperclassTest`1's own :fully-qualified-name exactly")
      (assert-equal "AssemblyToLispyTestTarget.GenericBaseForSuperclassTest`1[AssemblyToLispyTestTarget.EdgeCaseStruct]"
                    (getf cdfg :superclass-closed)
                    "ConcreteDerivedFromGeneric's :superclass-closed preserves the closed instantiation's concrete type argument")))

  ;; MultiEquatable implements the SAME open generic interface (IEquatable<T>) twice,
  ;; closed over different type arguments -- legal C#. Before the identity-grouping
  ;; follow-up fix, :interfaces would have contained "System.IEquatable`1" TWICE, and
  ;; :interfaces-closed would have had two entries sharing that one key (a real
  ;; collision, silently losing one closed form to any lookup by identity).
  ;;
  ;; :interfaces-closed is a PLIST, but its keys are STRINGS -- GETF is specified to
  ;; compare keys with EQ, which a freshly-READ string is never guaranteed to be
  ;; relative to a string literal in this test, even when STRING=. So the lookup below
  ;; deliberately uses (second (member identity interfaces-closed :test #'string=)),
  ;; never GETF -- this is the correct, documented access pattern (see
  ;; doc/assembly-to-lispy.md's :interfaces-closed schema entry), demonstrated live here
  ;; rather than just described in prose.
  (let ((me (find-if (lambda (cls)
                       (string= (getf cls :fully-qualified-name)
                                "AssemblyToLispyTestTarget.MultiEquatable"))
                     *metadata*)))
    (assert-not-null me "Should find MultiEquatable")
    (when me
      (assert-equal 1 (count "System.IEquatable`1" (getf me :interfaces) :test #'string=)
                    ":interfaces must list System.IEquatable`1 exactly once, even though MultiEquatable implements it twice (deduplicated by identity)")
      (let ((closed-forms (second (member "System.IEquatable`1" (getf me :interfaces-closed) :test #'string=))))
        (assert-not-null closed-forms
                          ":interfaces-closed must have an entry for System.IEquatable`1 (looked up via MEMBER, not GETF)")
        (when closed-forms
          (assert-equal 2 (length closed-forms)
                        "That one entry's value must group BOTH closed instantiations together")
          (assert-true (member "System.IEquatable`1[System.Int32]" closed-forms :test #'string=)
                      "The IEquatable<int> closed form must be present")
          (assert-true (member "System.IEquatable`1[System.String]" closed-forms :test #'string=)
                      "The IEquatable<string> closed form must be present"))))))
