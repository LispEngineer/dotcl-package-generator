;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite -- Property/Field/Indexer Codegen cluster.
;;; Split out of the former package-generator-tests.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :package-generator-tests)

(defun run-property-field-codegen-tests ()
  (format *error-output* "--- Running Property/Field/Indexer Codegen Tests ---~%")

    ;; 6. Indexer codegen: generate-class-file must pass a property's own index
    ;;    parameters through to get_Item/set_Item, and must skip (with a
    ;;    documenting comment, not a defun) an indexer overloaded across
    ;;    multiple index-parameter signatures.
  (let* ((class-plist
             '(:fully-qualified-name "Fixture.Indexed"
               :kind :class
               :fields nil
               :properties ((:name "Item" :type "System.Int32" :readable t :writeable t
                             :get-method "get_Item" :set-method "set_Item"
                             :parameters ((:name "index" :type "System.Int32"))))
               :methods nil
               :constructors nil))
           (out-dir (merge-pathnames "package-generator-tests-indexer-out/"
                                     (uiop:temporary-directory))))
      (unwind-protect
          (progn
            (ensure-directories-exist out-dir)
            (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
            (let* ((class-file (merge-pathnames "fixture-indexed.lisp" out-dir))
                   (contents (uiop:read-file-string class-file)))
              (assert-test (not (null (search "(cl:defun item (obj! index)" contents))) t
                          "generate-class-file emits an indexer getter taking the index parameter")
              (assert-test (not (null (search "\"get_Item\" index))" contents))) t
                          "generate-class-file's indexer getter passes the index through to get_Item")
              (assert-test (not (null (search "(cl:defun (cl:setf item) (new-value obj! index)" contents))) t
                          "generate-class-file emits an indexer setter taking new-value and the index parameter")
              (assert-test (not (null (search "\"set_Item\" index new-value))" contents))) t
                          "generate-class-file's indexer setter passes index then new-value to set_Item")))
        (when (probe-file out-dir)
          (uiop:delete-directory-tree out-dir :validate t))))

    ;; 6.1 Overloaded indexer (multiple index-parameter signatures) is not yet
    ;;     supported: it must be documented in a comment, not turned into a
    ;;     (guessed, likely wrong) single defun.
  (let* ((class-plist
             '(:fully-qualified-name "Fixture.OverloadedIndexed"
               :kind :class
               :fields nil
               :properties ((:name "Item" :type "System.Int32" :readable t :writeable t
                             :get-method "get_Item" :set-method "set_Item"
                             :parameters ((:name "index" :type "System.Int32")))
                            (:name "Item" :type "System.Int32" :readable t :writeable t
                             :get-method "get_Item" :set-method "set_Item"
                             :parameters ((:name "key" :type "System.String"))))
               :methods nil
               :constructors nil))
           (out-dir (merge-pathnames "package-generator-tests-indexer-overload-out/"
                                     (uiop:temporary-directory))))
      (unwind-protect
          (progn
            (ensure-directories-exist out-dir)
            (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
            (let* ((class-file (merge-pathnames "fixture-overloaded-indexed.lisp" out-dir))
                   (contents (uiop:read-file-string class-file)))
              (assert-test (not (null (search "not yet supported" contents))) t
                          "generate-class-file documents an overloaded indexer as not yet supported")
              (assert-test (search "(cl:defun item " contents) nil
                          "generate-class-file does not emit a guessing defun for an overloaded indexer")))
        (when (probe-file out-dir)
          (uiop:delete-directory-tree out-dir :validate t))))

    ;; 7. Public instance fields: generate-class-file must emit a getter (and,
    ;;    unless the field is read-only) a setter for every public instance
    ;;    field, using dotnet:invoke's GetField support for the getter and the
    ;;    setf-expansion of dotnet:invoke (documented in
    ;;    doc/dotnet-dotcl-interop.md) for the setter, since fields have no
    ;;    get_Foo/set_Foo accessor methods to invoke by name the way properties do.
  (let* ((class-plist
             '(:fully-qualified-name "Fixture.Fielded"
               :kind :class
               :fields ((:name "Count" :type "System.Int32" :public t
                         :documentation (:summary "A mutable public instance field."))
                        (:name "Id" :type "System.Int32" :public t :init-only t
                         :documentation (:summary "A read-only public instance field.")))
               :properties nil
               :methods nil
               :constructors nil))
           (out-dir (merge-pathnames "package-generator-tests-fields-out/"
                                     (uiop:temporary-directory))))
      (unwind-protect
          (progn
            (ensure-directories-exist out-dir)
            (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
            (let* ((class-file (merge-pathnames "fixture-fielded.lisp" out-dir))
                   (contents (uiop:read-file-string class-file)))
              (assert-test (not (null (search "(cl:defun count (obj!)" contents))) t
                          "generate-class-file emits a getter for a mutable public instance field")
              (assert-test (not (null (search "(dotnet:invoke (cl:the (dotnet \"Fixture.Fielded\") obj!) \"Count\"))" contents))) t
                          "generate-class-file's field getter invokes the field by its C# name")
              (assert-test (not (null (search "(cl:defun (cl:setf count) (new-value obj!)" contents))) t
                          "generate-class-file emits a setter for a mutable public instance field")
              (assert-test (not (null (search "(cl:setf (dotnet:invoke (cl:the (dotnet \"Fixture.Fielded\") obj!) \"Count\") new-value))" contents))) t
                          "generate-class-file's field setter uses the setf-expansion of dotnet:invoke")
              (assert-test (not (null (search "(cl:defun id (obj!)" contents))) t
                          "generate-class-file emits a getter for a read-only public instance field")
              (assert-test (search "(cl:defun (cl:setf id)" contents) nil
                          "generate-class-file emits no setter for a read-only (:init-only) public instance field"))
            (multiple-value-bind (exports shadows) (assembly-package-generator::compute-package-exports-and-shadows class-plist nil)
              (declare (ignore shadows))
              (assert-test (and (member "count" exports :test #'string=) t) t
                          "compute-package-exports-and-shadows exports the mutable field's name")
              (assert-test (and (member "id" exports :test #'string=) t) t
                          "compute-package-exports-and-shadows exports the read-only field's name too (getter only)")))
        (when (probe-file out-dir)
          (uiop:delete-directory-tree out-dir :validate t))))

    ;; 7.1 Writeable static properties and plain mutable static fields:
    ;;     generate-class-file must emit a getter/setf-expander pair for a
    ;;     static read-write property, a set-name function only (no getter,
    ;;     no setf) for a static write-only property, and a getter/setf-
    ;;     expander pair for a plain mutable static field -- all three
    ;;     previously matched no classifier and generated nothing at all
    ;;     (see PLAN.md / FEATURES.md's Unsupported Features). Unlike the
    ;;     instance property/field case, these use dotnet:static directly
    ;;     (no obj! receiver).
  (let* ((class-plist
             '(:fully-qualified-name "Fixture.StaticWriteable"
               :kind :class
               :fields ((:name "Total" :type "System.Int32" :static t
                         :documentation (:summary "A plain mutable static field.")))
               :properties ((:name "Mode" :type "System.Int32" :static t :readable t :writeable t
                             :documentation (:summary "A static read-write property."))
                            (:name "Sink" :type "System.Int32" :static t :writeable t
                             :documentation (:summary "A static write-only property.")))
               :methods nil
               :constructors nil))
           (out-dir (merge-pathnames "package-generator-tests-static-writeable-out/"
                                     (uiop:temporary-directory))))
      (unwind-protect
          (progn
            (ensure-directories-exist out-dir)
            (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
            (let* ((class-file (merge-pathnames "fixture-static-writeable.lisp" out-dir))
                   (contents (uiop:read-file-string class-file)))
              (assert-test (not (null (search "(cl:defun mode ()" contents))) t
                          "generate-class-file emits a getter for a static read-write property")
              (assert-test (not (null (search "(dotnet:static <type-str> \"Mode\"))" contents))) t
                          "generate-class-file's static property getter reads via dotnet:static")
              (assert-test (not (null (search "(cl:defun (cl:setf mode) (new-value)" contents))) t
                          "generate-class-file emits a setf-expander for a static read-write property")
              (assert-test (not (null (search "(cl:setf (dotnet:static <type-str> \"Mode\") new-value))" contents))) t
                          "generate-class-file's static property setter uses the setf-expansion of dotnet:static")
              (assert-test (search "(cl:defun sink ()" contents) nil
                          "generate-class-file emits no getter for a static write-only property")
              (assert-test (not (null (search "(cl:defun set-sink (new-value)" contents))) t
                          "generate-class-file emits a set-name function for a static write-only property")
              (assert-test (not (null (search "(cl:defun total ()" contents))) t
                          "generate-class-file emits a getter for a plain mutable static field")
              (assert-test (not (null (search "(dotnet:static <type-str> \"Total\"))" contents))) t
                          "generate-class-file's static field getter reads via dotnet:static")
              (assert-test (not (null (search "(cl:defun (cl:setf total) (new-value)" contents))) t
                          "generate-class-file emits a setf-expander for a plain mutable static field")
              (assert-test (not (null (search "(cl:setf (dotnet:static <type-str> \"Total\") new-value))" contents))) t
                          "generate-class-file's static field setter uses the setf-expansion of dotnet:static"))
            (multiple-value-bind (exports shadows) (assembly-package-generator::compute-package-exports-and-shadows class-plist nil)
              (declare (ignore shadows))
              (assert-test (and (member "mode" exports :test #'string=) t) t
                          "compute-package-exports-and-shadows exports the read-write static property's plain name")
              (assert-test (and (member "set-sink" exports :test #'string=) t) t
                          "compute-package-exports-and-shadows exports the write-only static property as set-sink")
              (assert-test (and (member "total" exports :test #'string=) t) t
                          "compute-package-exports-and-shadows exports the mutable static field's plain name")))
        (when (probe-file out-dir)
          (uiop:delete-directory-tree out-dir :validate t)))))
