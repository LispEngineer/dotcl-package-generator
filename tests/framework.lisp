;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Base framework and schema/semantic validation for AssemblyToLispy tests

(in-package :package-generator-tests)

(defvar *test-failures* 0)
(defvar *test-count* 0)
(defvar *metadata* nil)

(defmacro deftest (name &body body)
  `(defun ,name ()
     (format *error-output* "~%[TEST] Running ~A...~%" ',name)
     (let ((initial-failures *test-failures*))
       ,@body
       (if (= *test-failures* initial-failures)
           (format *error-output* "[TEST] ~A PASSED~%" ',name)
           (utils:format-red *error-output* "[TEST] ~A FAILED~%" ',name)))))

(defun assert-equal (expected actual msg)
  (incf *test-count*)
  (unless (equal expected actual)
    (incf *test-failures*)
    (utils:format-red *error-output* "  ASSERTION FAILED: ~A~%    Expected: ~S~%    Actual:   ~S~%"
            msg expected actual)))

(defun assert-true (actual msg)
  (incf *test-count*)
  (unless actual
    (incf *test-failures*)
    (utils:format-red *error-output* "  ASSERTION FAILED: ~A~%    Expected: logically true~%    Actual:   ~S~%"
            msg actual)))

(defun assert-not-null (actual msg)
  (incf *test-count*)
  (unless actual
    (incf *test-failures*)
    (utils:format-red *error-output* "  ASSERTION FAILED: ~A~%    Expected: not null~%    Actual:   ~S~%"
            msg actual)))

(deftest test-load-metadata
  (assert-not-null *metadata* "Metadata should be loaded"))

;;; Assembly-specific test registration mapping
(defvar *assembly-tests* (make-hash-table :test #'equal))

(defun register-tests (assembly-name test-fn)
  "Registers a test function to be run when testing the specified assembly."
  (pushnew test-fn (gethash assembly-name *assembly-tests*)))

(defmacro def-assembly-test (assembly-name name &body body)
  "Defines an assembly-specific test and registers it under the target assembly name."
  `(progn
     (deftest ,name ,@body)
     (register-tests ,assembly-name ',name)))

;;; C# BindingFlags representation values for reflection calls:
;;; DeclaredOnly = 2, Instance = 4, Static = 8, Public = 16, NonPublic = 32.
;;; The combination for searching fields, properties, and methods is 62.
;;; The combination for searching constructors is 52.
(defvar *binding-flags-members* 62)
(defvar *binding-flags-constructors* 52)

(defun dotnet-array-to-list (array)
  "Converts a C# array returned by reflection calls into a standard Common Lisp list
   to allow sequence iteration and lookup."
  (let ((len (dotnet:invoke array "Length"))
        (list nil))
    (loop for i from (1- len) downto 0
          do (push (dotnet:invoke array "GetValue" i) list))
    list))

(defun plist-p (obj)
  "Verifies if the given object is a valid property list (plist) by checking that
   it is a list, has an even number of elements, and every key is a keyword."
  (when (listp obj)
    (when (evenp (length obj))
      (loop for (key val) on obj by #'cddr
            always (keywordp key)))))

(defun key-present-p (plist key)
  "Scans the property list to check if the specified key is explicitly present,
   independent of whether its value is nil."
  (loop for (k v) on plist by #'cddr
        when (eq k key) return t))

(defun validate-plist-keys (plist mandatory-keys allowed-keys context)
  "Ensures that all required keywords are present in the plist and that no
   undocumented or unexpected keywords exist. Returns nil on failure."
  (let ((valid t))
    (dolist (key mandatory-keys)
      (when (not (key-present-p plist key))
        (setf valid nil)
        (format *error-output* "[SCHEMA ERROR] ~A: Missing mandatory key ~S~%" context key)))
    (loop for (key val) on plist by #'cddr
          do (when (not (member key allowed-keys))
               (setf valid nil)
               (format *error-output* "[SCHEMA ERROR] ~A: Unknown key ~S with value ~S~%" context key val)))
    valid))

(defun validate-documentation-schema (doc context)
  "Validates the XML documentation sub-plist structure, checking for allowed
   documentation tags and correct type mappings."
  (let ((valid t))
    (when doc
      (if (not (plist-p doc))
          (progn
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: Documentation is not a plist: ~S~%" context doc))
          (progn
            (when (not (validate-plist-keys doc nil '(:summary :returns :parameters) (format nil "~A (Documentation)" context)))
              (setf valid nil))
            (let ((summary (getf doc :summary))
                  (returns (getf doc :returns))
                  (parameters (getf doc :parameters)))
              (when (and summary (not (stringp summary)))
                (setf valid nil)
                (format *error-output* "[SCHEMA ERROR] ~A (Documentation): :summary must be a string, got ~S~%" context summary))
              (when (and returns (not (stringp returns)))
                (setf valid nil)
                (format *error-output* "[SCHEMA ERROR] ~A (Documentation): :returns must be a string, got ~S~%" context returns))
              (when parameters
                (if (not (listp parameters))
                    (progn
                      (setf valid nil)
                      (format *error-output* "[SCHEMA ERROR] ~A (Documentation): :parameters must be a list, got ~S~%" context parameters))
                    (dolist (p parameters)
                      (if (not (plist-p p))
                          (progn
                            (setf valid nil)
                            (format *error-output* "[SCHEMA ERROR] ~A (Documentation): Parameter doc entry is not a plist: ~S~%" context p))
                          (progn
                            (when (not (validate-plist-keys p '(:name :description) '(:name :description) (format nil "~A (Documentation Parameter)" context)))
                              (setf valid nil))
                            (let ((pname (getf p :name))
                                  (pdesc (getf p :description)))
                              (when (and pname (not (stringp pname)))
                                (setf valid nil)
                                (format *error-output* "[SCHEMA ERROR] ~A (Documentation Parameter): :name must be a string, got ~S~%" context pname))
                              (when (and pdesc (not (stringp pdesc)))
                                (setf valid nil)
                                (format *error-output* "[SCHEMA ERROR] ~A (Documentation Parameter): :description must be a string, got ~S~%" context pdesc))))))))))))
    valid))

(defun validate-parameter-schema (param context)
  "Validates a single method or constructor parameter plist, checking for allowed modifier
   flags, expected types, and default value consistency."
  (let ((valid t))
    (if (not (plist-p param))
        (progn
          (setf valid nil)
          (utils:format-red *error-output* "[SCHEMA ERROR] ~A: Parameter is not a plist: ~S~%" context param))
        (progn
          (when (not (validate-plist-keys param '(:name :type)
                                         '(:name :type :assembly-qualified-type :extension-this :out :ref :ref-readonly :scoped :params :has-default :default-value)
                                         context))
            (setf valid nil))
          (let ((pname (getf param :name))
                (ptype (getf param :type))
                (p-aq (getf param :assembly-qualified-type))
                (p-ext (getf param :extension-this))
                (p-out (getf param :out))
                (p-ref (getf param :ref))
                (p-ref-ro (getf param :ref-readonly))
                (p-scoped (getf param :scoped))
                (p-params (getf param :params))
                (p-has-def (getf param :has-default))
                (p-def-val (key-present-p param :default-value)))
            (when (and pname (not (stringp pname)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :name must be a string, got ~S~%" context pname))
            (when (and ptype (not (stringp ptype)))
              (setf valid nil)
              (format *error-output* "[SCHEMA ERROR] ~A: :type must be a string, got ~S~%" context ptype))
            (when (and p-aq (not (stringp p-aq)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :assembly-qualified-type must be a string, got ~S~%" context p-aq))
            (when (and p-ext (not (eq p-ext 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :extension-this must be t, got ~S~%" context p-ext))
            (when (and p-out (not (eq p-out 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :out must be t, got ~S~%" context p-out))
            (when (and p-ref (not (eq p-ref 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :ref must be t, got ~S~%" context p-ref))
            (when (and p-ref-ro (not (eq p-ref-ro 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :ref-readonly must be t, got ~S~%" context p-ref-ro))
            (when (and p-scoped (not (eq p-scoped 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :scoped must be t, got ~S~%" context p-scoped))
            (when (and p-params (not (eq p-params 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :params must be t, got ~S~%" context p-params))
            (when (and p-has-def (not (eq p-has-def 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :has-default must be t, got ~S~%" context p-has-def))
            (when (not (eq (if p-has-def t nil) (if p-def-val t nil)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :has-default is ~S but :default-value presence is ~S~%" context p-has-def p-def-val)))))
    valid))

(defun validate-method-schema (method context c#type)
  "Validates a single method plist and queries the resolved C# Type using reflection
   to confirm the method's clean or mangled name exists."
  (let ((valid t))
    (if (not (plist-p method))
        (progn
          (setf valid nil)
          (utils:format-red *error-output* "[SCHEMA ERROR] ~A: Method entry is not a plist: ~S~%" context method))
        (progn
          (when (not (validate-plist-keys method '(:name :return-type)
                                         '(:name :mangled-name :is-static :extension-method :return-type :assembly-qualified-return-type :parameters :documentation :is-generic :generic-arity)
                                         context))
            (setf valid nil))
          (let ((mname (getf method :name))
                (m-mangled (getf method :mangled-name))
                (m-static (getf method :is-static))
                (m-ext (getf method :extension-method))
                (m-ret (getf method :return-type))
                (m-aq-ret (getf method :assembly-qualified-return-type))
                (m-params (getf method :parameters))
                (m-doc (getf method :documentation)))
            (when (and mname (not (stringp mname)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :name must be a string, got ~S~%" context mname))
            (when (and m-mangled (not (stringp m-mangled)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :mangled-name must be a string, got ~S~%" context m-mangled))
            (when (and m-static (not (eq m-static 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :is-static must be t, got ~S~%" context m-static))
            (when (and m-ext (not (eq m-ext 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :extension-method must be t, got ~S~%" context m-ext))
            (when (and m-ret (not (stringp m-ret)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :return-type must be a string, got ~S~%" context m-ret))
            (when (and m-aq-ret (not (stringp m-aq-ret)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :assembly-qualified-return-type must be a string, got ~S~%" context m-aq-ret))
            (when (and m-params (not (listp m-params)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :parameters must be a list, got ~S~%" context m-params))
            (when m-params
              (dolist (p m-params)
                (when (not (validate-parameter-schema p (format nil "~A (Parameter ~A)" context (getf p :name))))
                  (setf valid nil))))
            (when (not (validate-documentation-schema m-doc context))
              (setf valid nil))
            (when c#type
              (let* ((expected-name (if m-mangled m-mangled mname))
                     (all-methods (dotnet-array-to-list (dotnet:static "MonoUtils" "GetTypeMethods" c#type *binding-flags-members*)))
                     (found (loop for m in all-methods
                                  when (string= expected-name (dotnet:invoke m "Name"))
                                  return t)))
                (when (not found)
                  (setf valid nil)
                  (utils:format-red *error-output* "[SEMANTIC ERROR] ~A: Method ~S does not exist on live type ~S~%"
                          context expected-name (dotnet:invoke c#type "FullName"))))))))
    valid))

(defun validate-constructor-schema (ctor context c#type)
  "Validates a constructor plist and verifies that a constructor with a matching
   parameter count is declared on the live C# Type."
  (let ((valid t))
    (if (not (plist-p ctor))
        (progn
          (setf valid nil)
          (utils:format-red *error-output* "[SCHEMA ERROR] ~A: Constructor entry is not a plist: ~S~%" context ctor))
        (progn
          (when (not (validate-plist-keys ctor nil '(:public :protected :protected-internal :parameters :documentation) context))
            (setf valid nil))
          (let ((c-pub (getf ctor :public))
                (c-prot (getf ctor :protected))
                (c-prot-int (getf ctor :protected-internal))
                (c-params (getf ctor :parameters))
                (c-doc (getf ctor :documentation)))
            (when (and c-pub (not (eq c-pub 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :public must be t, got ~S~%" context c-pub))
            (when (and c-prot (not (eq c-prot 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :protected must be t, got ~S~%" context c-prot))
            (when (and c-prot-int (not (eq c-prot-int 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :protected-internal must be t, got ~S~%" context c-prot-int))
            (when (and c-params (not (listp c-params)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :parameters must be a list, got ~S~%" context c-params))
            (when c-params
              (dolist (p c-params)
                (when (not (validate-parameter-schema p (format nil "~A (Constructor Parameter ~A)" context (getf p :name))))
                  (setf valid nil))))
            (when (not (validate-documentation-schema c-doc context))
              (setf valid nil))
            (when c#type
              (let* ((param-count (length c-params))
                     (all-ctors (dotnet-array-to-list (dotnet:static "MonoUtils" "GetTypeConstructors" c#type *binding-flags-constructors*)))
                     (found (loop for c in all-ctors
                                  when (= param-count (dotnet:invoke (dotnet:invoke c "GetParameters") "Length"))
                                  return t)))
                (when (not found)
                  (setf valid nil)
                  (utils:format-red *error-output* "[SEMANTIC ERROR] ~A: Constructor with parameter count ~D does not exist on live type ~S~%"
                          context param-count (dotnet:invoke c#type "FullName"))))))))
    valid))

(defun validate-property-schema (prop context c#type)
  "Validates a property plist and queries the live C# Type using reflection
   to verify that the property name exists."
  (let ((valid t))
    (if (not (plist-p prop))
        (progn
          (setf valid nil)
          (utils:format-red *error-output* "[SCHEMA ERROR] ~A: Property entry is not a plist: ~S~%" context prop))
        (progn
          (when (not (validate-plist-keys prop '(:name :type)
                                         '(:name :type :assembly-qualified-type :readable :writeable :static :get-method :set-method :parameters :documentation)
                                         context))
            (setf valid nil))
          (let ((pname (getf prop :name))
                (ptype (getf prop :type))
                (p-aq (getf prop :assembly-qualified-type))
                (p-read (getf prop :readable))
                (p-write (getf prop :writeable))
                (p-static (getf prop :static))
                (p-get (getf prop :get-method))
                (p-set (getf prop :set-method))
                (p-params (getf prop :parameters))
                (p-doc (getf prop :documentation)))
            (when (and pname (not (stringp pname)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :name must be a string, got ~S~%" context pname))
            (when (and ptype (not (stringp ptype)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :type must be a string, got ~S~%" context ptype))
            (when (and p-aq (not (stringp p-aq)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :assembly-qualified-type must be a string, got ~S~%" context p-aq))
            (when (and p-read (not (eq p-read 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :readable must be t, got ~S~%" context p-read))
            (when (and p-write (not (eq p-write 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :writeable must be t, got ~S~%" context p-write))
            (when (and p-static (not (eq p-static 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :static must be t, got ~S~%" context p-static))
            (when (and p-get (not (stringp p-get)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :get-method must be a string, got ~S~%" context p-get))
            (when (and p-set (not (stringp p-set)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :set-method must be a string, got ~S~%" context p-set))
            (when (and p-params (not (listp p-params)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :parameters must be a list, got ~S~%" context p-params))
            (when p-params
              (dolist (p p-params)
                (when (not (validate-parameter-schema p (format nil "~A (Indexer Parameter ~A)" context (getf p :name))))
                  (setf valid nil))))
            (when (not (validate-documentation-schema p-doc context))
              (setf valid nil))
            (when c#type
              (let* ((all-props (dotnet-array-to-list (dotnet:static "MonoUtils" "GetTypeProperties" c#type *binding-flags-members*)))
                     (found (loop for p in all-props
                                  when (string= pname (dotnet:invoke p "Name"))
                                  return t)))
                (when (not found)
                  (setf valid nil)
                  (utils:format-red *error-output* "[SEMANTIC ERROR] ~A: Property ~S does not exist on live type ~S~%"
                          context pname (dotnet:invoke c#type "FullName"))))))))
    valid))

(defun validate-event-schema (event context c#type)
  "Validates an event plist and queries the live C# Type using reflection
   to verify that the event name exists."
  (let ((valid t))
    (if (not (plist-p event))
        (progn
          (setf valid nil)
          (utils:format-red *error-output* "[SCHEMA ERROR] ~A: Event entry is not a plist: ~S~%" context event))
        (progn
          (when (not (validate-plist-keys event '(:name :type :add-method :remove-method)
                                         '(:name :type :assembly-qualified-type :add-method :remove-method :documentation)
                                         context))
            (setf valid nil))
          (let ((ename (getf event :name))
                (etype (getf event :type))
                (e-aq (getf event :assembly-qualified-type))
                (e-add (getf event :add-method))
                (e-remove (getf event :remove-method))
                (e-doc (getf event :documentation)))
            (when (and ename (not (stringp ename)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :name must be a string, got ~S~%" context ename))
            (when (and etype (not (stringp etype)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :type must be a string, got ~S~%" context etype))
            (when (and e-aq (not (stringp e-aq)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :assembly-qualified-type must be a string, got ~S~%" context e-aq))
            (when (not (stringp e-add))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :add-method must be a string, got ~S~%" context e-add))
            (when (not (stringp e-remove))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :remove-method must be a string, got ~S~%" context e-remove))
            (when (not (validate-documentation-schema e-doc context))
              (setf valid nil))
            (when c#type
              (let* ((all-events (dotnet-array-to-list (dotnet:static "MonoUtils" "GetTypeEvents" c#type *binding-flags-members*)))
                     (found (loop for e in all-events
                                  when (string= ename (dotnet:invoke e "Name"))
                                  return t)))
                (when (not found)
                  (setf valid nil)
                  (utils:format-red *error-output* "[SEMANTIC ERROR] ~A: Event ~S does not exist on live type ~S~%"
                          context ename (dotnet:invoke c#type "FullName"))))))))
    valid))

(defun validate-field-schema (field context c#type)
  "Validates a field plist and queries the live C# Type using reflection
   to verify that the field name exists."
  (let ((valid t))
    (if (not (plist-p field))
        (progn
          (setf valid nil)
          (utils:format-red *error-output* "[SCHEMA ERROR] ~A: Field entry is not a plist: ~S~%" context field))
        (progn
          (when (not (validate-plist-keys field '(:name :type)
                                         '(:name :type :assembly-qualified-type :static :literal :init-only :public :documentation)
                                         context))
            (setf valid nil))
          (let ((fname (getf field :name))
                (ftype (getf field :type))
                (f-aq (getf field :assembly-qualified-type))
                (f-static (getf field :static))
                (f-literal (getf field :literal))
                (f-init (getf field :init-only))
                (f-pub (getf field :public))
                (f-doc (getf field :documentation)))
            (when (and fname (not (stringp fname)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :name must be a string, got ~S~%" context fname))
            (when (and ftype (not (stringp ftype)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :type must be a string, got ~S~%" context ftype))
            (when (and f-aq (not (stringp f-aq)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :assembly-qualified-type must be a string, got ~S~%" context f-aq))
            (when (and f-static (not (eq f-static 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :static must be t, got ~S~%" context f-static))
            (when (and f-literal (not (eq f-literal 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :literal must be t, got ~S~%" context f-literal))
            (when (and f-init (not (eq f-init 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :init-only must be t, got ~S~%" context f-init))
            (when (and f-pub (not (eq f-pub 't)))
              (setf valid nil)
              (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :public must be t, got ~S~%" context f-pub))
            (when (not (validate-documentation-schema f-doc context))
              (setf valid nil))
            (when c#type
              (let* ((all-fields (dotnet-array-to-list (dotnet:static "MonoUtils" "GetTypeFields" c#type *binding-flags-members*)))
                     (found (loop for f in all-fields
                                  when (string= fname (dotnet:invoke f "Name"))
                                  return t)))
                (when (not found)
                  (setf valid nil)
                  (utils:format-red *error-output* "[SEMANTIC ERROR] ~A: Field ~S does not exist on live type ~S~%"
                          context fname (dotnet:invoke c#type "FullName"))))))))
    valid))

(defun validate-type-schema (type-entry)
  "Main schema validation entry point for a top-level type plist. Validates all plist
   structures recursively and checks that the type and its members exist in the CLR."
  (let ((valid t))
    (if (not (plist-p type-entry))
        (progn
          (setf valid nil)
          (utils:format-red *error-output* "[SCHEMA ERROR] Type entry is not a plist: ~S~%" type-entry))
        (let* ((tname (getf type-entry :name))
               (fqname (getf type-entry :fully-qualified-name))
               (tns (getf type-entry :namespace))
               (tkind (getf type-entry :kind))
               (t-underlying (getf type-entry :enum-underlying-type))
               (t-doc (getf type-entry :documentation))
               (tsuper (getf type-entry :superclass))
               (tsuper-closed (getf type-entry :superclass-closed))
               (t-ifaces (getf type-entry :interfaces))
               (t-ifaces-closed (getf type-entry :interfaces-closed))
               (t-flags (getf type-entry :flags))
               (t-props (getf type-entry :properties))
               (t-fields (getf type-entry :fields))
               (t-ctors (getf type-entry :constructors))
               (t-methods (getf type-entry :methods))
               (t-events (getf type-entry :events))
               (context (format nil "Type '~A'" (if fqname fqname (if tname tname "Unknown")))))

          (when (not (validate-plist-keys type-entry '(:name :fully-qualified-name :kind)
                                         '(:name :fully-qualified-name :namespace :kind :enum-underlying-type :documentation :superclass :superclass-closed :interfaces :interfaces-closed :flags :properties :fields :constructors :methods :events)
                                         context))
            (setf valid nil))
          
          (when (and tname (not (stringp tname)))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :name must be a string, got ~S~%" context tname))
          (when (and fqname (not (stringp fqname)))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :fully-qualified-name must be a string, got ~S~%" context fqname))
          (when (and tns (not (stringp tns)))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :namespace must be a string, got ~S~%" context tns))
          (when (and tkind (not (member tkind '(:class :struct :interface :enum :delegate))))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :kind must be one of (:class :struct :interface :enum :delegate), got ~S~%" context tkind))
          (when (and t-underlying (not (stringp t-underlying)))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :enum-underlying-type must be a string, got ~S~%" context t-underlying))
          (when (and t-underlying (not (eq tkind :enum)))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :enum-underlying-type is present but :kind is ~S (must be :enum)~%" context tkind))
          (when (and tsuper (not (stringp tsuper)))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :superclass must be a string, got ~S~%" context tsuper))
          ;; :superclass-closed (Version 40): the closed/instantiated generic form,
          ;; a sibling of :superclass (which is always the bare, matchable generic
          ;; type DEFINITION identity -- see doc/generator-design-notes.md's
          ;; "Generic Superclass/Interface Identity Matching (Version 40)" section).
          ;; Only ever present alongside a present :superclass.
          (when (and tsuper-closed (not (stringp tsuper-closed)))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :superclass-closed must be a string, got ~S~%" context tsuper-closed))
          (when (and tsuper-closed (not tsuper))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :superclass-closed is present but :superclass is absent~%" context))
          (when (and t-ifaces (not (listp t-ifaces)))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :interfaces must be a list, got ~S~%" context t-ifaces))
          (when t-ifaces
            (dolist (i t-ifaces)
              (when (not (stringp i))
                (setf valid nil)
                (utils:format-red *error-output* "[SCHEMA ERROR] ~A: Interface name in :interfaces must be a string, got ~S~%" context i))))
          ;; :interfaces-closed (Version 40): one (identity closed-1 closed-2 ...) list
          ;; per GENERIC identity in :interfaces only (a non-generic identity's closed
          ;; form would be identical to its identity, already in :interfaces, so it is
          ;; omitted entirely rather than duplicated). More than one closed form under
          ;; the same identity is possible and legal C# (e.g. "class Foo : IEquatable<int>,
          ;; IEquatable<string>" implements the same open IEquatable`1 twice, closed over
          ;; different arguments) -- this is exactly why each entry is a proper list
          ;; (identity . (closed-1 closed-2 ...)), not a single (identity . closed) cons:
          ;; a cons-per-identity representation cannot hold two closed forms under one
          ;; key without one silently shadowing the other in any assoc-style lookup.
          ;; :interfaces itself is deduped by identity (so it never lists the same
          ;; interface identity twice, even when a type implements it multiple times
          ;; closed over different arguments), so every :interfaces-closed identity must
          ;; appear in :interfaces exactly once.
          (when (and t-ifaces-closed (not (listp t-ifaces-closed)))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :interfaces-closed must be a list, got ~S~%" context t-ifaces-closed))
          (when t-ifaces-closed
            (dolist (entry t-ifaces-closed)
              (if (and (consp entry) (stringp (car entry)) (cdr entry)
                       (every #'stringp (cdr entry)))
                  (progn
                    (unless (member (car entry) t-ifaces :test #'string=)
                      (setf valid nil)
                      (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :interfaces-closed identity ~S does not appear in :interfaces~%" context (car entry)))
                    (unless (= 1 (count (car entry) t-ifaces-closed :key #'car :test #'string=))
                      (setf valid nil)
                      (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :interfaces-closed identity ~S appears more than once as a top-level entry (closed forms for one identity must be grouped into a single entry's list, not split across entries)~%" context (car entry))))
                  (progn
                    (setf valid nil)
                    (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :interfaces-closed entry must be a (string string+) list, got ~S~%" context entry)))))
          (when (and t-flags (not (listp t-flags)))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :flags must be a list, got ~S~%" context t-flags))
          (when t-flags
            (dolist (f t-flags)
              (when (not (member f '(:abstract :sealed :import :serializable :generic-type :generic-type-definition :nested)))
                (setf valid nil)
                (utils:format-red *error-output* "[SCHEMA ERROR] ~A: Unknown flag keyword in :flags: ~S~%" context f))))
          (when (and t-props (not (listp t-props)))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :properties must be a list, got ~S~%" context t-props))
          (when (and t-fields (not (listp t-fields)))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :fields must be a list, got ~S~%" context t-fields))
          (when (and t-ctors (not (listp t-ctors)))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :constructors must be a list, got ~S~%" context t-ctors))
          (when (and t-methods (not (listp t-methods)))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :methods must be a list, got ~S~%" context t-methods))
          (when (and t-events (not (listp t-events)))
            (setf valid nil)
            (utils:format-red *error-output* "[SCHEMA ERROR] ~A: :events must be a list, got ~S~%" context t-events))
          
          (when (not (validate-documentation-schema t-doc context))
            (setf valid nil))
          
          (let ((c#type (when fqname (monoutils:get-type fqname))))
            (if (not c#type)
                (progn
                  (setf valid nil)
                  (utils:format-red *error-output* "[SEMANTIC ERROR] ~A: Could not resolve type in live AppDomain~%" context))
                (progn
                  (when t-props
                    (dolist (p t-props)
                      (when (not (validate-property-schema p (format nil "~A (Property ~A)" context (getf p :name)) c#type))
                        (setf valid nil))))
                  (when t-fields
                    (dolist (f t-fields)
                      (when (not (validate-field-schema f (format nil "~A (Field ~A)" context (getf f :name)) c#type))
                        (setf valid nil))))
                  (when t-ctors
                    (dolist (c t-ctors)
                      (when (not (validate-constructor-schema c (format nil "~A (Constructor)" context) c#type))
                        (setf valid nil))))
                  (when t-methods
                    (dolist (m t-methods)
                      (when (not (validate-method-schema m (format nil "~A (Method ~A)" context (getf m :name)) c#type))
                        (setf valid nil))))
                  (when t-events
                    (dolist (e t-events)
                      (when (not (validate-event-schema e (format nil "~A (Event ~A)" context (getf e :name)) c#type))
                        (setf valid nil)))))))))
    valid))

(deftest test-schema-validation
  "Full schema validation test suite that runs over the entire loaded metadata
   collection and asserts that everything matches structurally and semantically."
  (format *error-output* "~%[TEST] Running full schema and semantic validation on loaded metadata...~%")
  (let ((all-valid t))
    (dolist (type-entry *metadata*)
      (when (not (validate-type-schema type-entry))
        (setf all-valid nil)))
    (assert-true all-valid "All items in metadata must adhere to the schema and exist in the CLR runtime")))

(defun run-all-assembly-tests (filename assembly-name)
  "Main entry point for executing Lisp-native test validations on the generated assembly
   metadata. Runs the full schema validation and type resolution suite on every target,
   and dispatches assembly-specific spot checks."
  (format *error-output* "~%==============================~%")
  (format *error-output* "Loading metadata from: ~A (~A)~%" filename assembly-name)
  (setf *metadata* (utils:safe-read-form-from-file filename))
  (format *error-output* "Metadata successfully loaded: ~A items found.~%" (length *metadata*))
  (format *error-output* "==============================~%")
  
  (setf *test-failures* 0)
  (setf *test-count* 0)
  
  (test-load-metadata)
  (test-schema-validation)
  
  ;; Run registered assembly-specific tests
  (let ((tests (gethash assembly-name *assembly-tests*)))
    (dolist (test-fn (reverse tests))
      (funcall test-fn)))
  
  (format *error-output* "~%==============================~%")
  (format *error-output* "TESTS COMPLETE: ~A run, ~A failed.~%" *test-count* *test-failures*)
  (format *error-output* "==============================~%")
  (if (> *test-failures* 0)
      nil
      t))
