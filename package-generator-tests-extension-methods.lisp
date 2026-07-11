;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite -- Extension Methods cluster.
;;; Split out of the former package-generator-tests.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :package-generator-tests)

(defun run-extension-methods-tests ()
  (format *error-output* "--- Running Extension Methods Tests ---~%")

    ;; 14. Extension Methods (Version 38, doc/plan-v38.md): --extension-methods
    ;;     injects a matching C# extension method into the extended class's own
    ;;     package as an obj!-first wrapper. Fixture.Ext.Target is the class
    ;;     under test; Fixture.Ext.Holder is a static holder class present in
    ;;     the same fixture metadata (as build-extension-method-index scans
    ;;     every type across the whole metadata index, not just requested
    ;;     ones) declaring five candidate extension methods exercising every
    ;;     skip path plus one survivor.
  (let ((target
            '(:fully-qualified-name "Fixture.Ext.Target" :name "Target" :namespace "Fixture.Ext"
              :kind :class :fields nil :properties nil :constructors nil
              :methods ((:name "CollidingMethod" :is-static nil :return-type "System.Void" :parameters nil))))
          (holder
            '(:fully-qualified-name "Fixture.Ext.Holder" :name "Holder" :namespace "Fixture.Ext"
              :kind :class :flags (:sealed) :fields nil :properties nil :constructors nil
              :methods
              ((:name "CleanExt" :is-static t :extension-method t :return-type "System.Void"
                :parameters ((:name "target" :type "Fixture.Ext.Target" :extension-this t)
                             (:name "amount" :type "System.Int32")))
               (:name "DirtyExt" :is-static t :extension-method t :return-type "System.Void"
                :parameters ((:name "target" :type "Fixture.Ext.Target" :extension-this t)
                             (:name "amount" :type "System.Int32" :ref t)))
               (:name "Frob" :is-static t :extension-method t :return-type "System.Void"
                :parameters ((:name "target" :type "Fixture.Ext.Target" :extension-this t)))
               (:name "Frob" :is-static t :extension-method t :return-type "System.Void"
                :parameters ((:name "target" :type "Fixture.Ext.Target" :extension-this t)
                             (:name "amount" :type "System.Int32")))
               (:name "CollidingMethod" :is-static t :extension-method t :return-type "System.Void"
                :parameters ((:name "target" :type "Fixture.Ext.Target" :extension-this t)))))))

      ;; 14.1 build-extension-method-index / compute-matched-extensions-for-class
      ;;      directly, against a hand-built metadata-index (same shape
      ;;      build-metadata-index itself produces).
      (let ((owning-entry '(:assembly-name "Fixture.Ext.dll"))
            (metadata-index (make-hash-table :test #'equal)))
        (dolist (tp (list target holder))
          (setf (gethash (getf tp :fully-qualified-name) metadata-index) (cons tp owning-entry)))
        (let ((extension-index (assembly-package-generator::build-extension-method-index metadata-index)))
          (assert-test (length (gethash "Fixture.Ext.Target" extension-index)) 5
                      "build-extension-method-index buckets all 5 candidates under Target's exact FQ name")
          (multiple-value-bind (survivors skipped)
              (assembly-package-generator::compute-matched-extensions-for-class target nil extension-index)
            (assert-test (length survivors) 1
                        "compute-matched-extensions-for-class keeps exactly one survivor")
            (assert-test (getf (first (first survivors)) :name) "CleanExt"
                        "compute-matched-extensions-for-class's survivor is CleanExt")
            (assert-test (length skipped) 4
                        "compute-matched-extensions-for-class skips the other 4 candidates")
            (let ((reasons (mapcar (lambda (s) (cons (getf (first s) :name) (third s))) skipped)))
              (assert-test (cdr (assoc "DirtyExt" reasons :test #'string=)) :dirty
                          "DirtyExt is skipped as :dirty (ref parameter)")
              (assert-test (cdr (assoc "CollidingMethod" reasons :test #'string=)) :own
                          "CollidingMethod is skipped as :own (Target already declares this name)")
              (let ((frob-reasons (remove "Frob" reasons :key #'car :test-not #'string=)))
                (assert-test (length frob-reasons) 2
                            "both Frob overloads are skipped")
                (assert-test (every (lambda (r) (and (consp (cdr r)) (eq (second r) :ambiguous))) frob-reasons) t
                            "both Frob overloads are skipped as :ambiguous"))))))

      ;; 14.2 End-to-end: generate-assembly-packages-batch with :extension-methods
      ;;      t on Target only (Holder is never itself requested as a --class)
      ;;      must emit clean-ext into fixture-ext-target.lisp, must not emit
      ;;      dirty-ext or frob, and must not overwrite CollidingMethod's real
      ;;      wrapper with the extension version.
      (let* ((fixture-metadata (list target holder))
             (fixture-file (merge-pathnames "package-generator-tests-extension-fixture.lispy-metadata"
                                            (uiop:temporary-directory)))
             (out-dir (merge-pathnames "package-generator-tests-extension-out/"
                                       (uiop:temporary-directory))))
        (unwind-protect
            (progn
              (with-open-file (s fixture-file :direction :output :if-exists :supersede :if-does-not-exist :create)
                (prin1 fixture-metadata s))
              (ensure-directories-exist out-dir)
              (assembly-package-generator:generate-assembly-packages-batch
               (list (list :metadata-file (namestring fixture-file)
                           :assembly-name "Fixture.Ext.dll"
                           :classes (list (list :name "Fixture.Ext.Target" :constant-properties ""
                                                :extension-methods t))))
               (namestring out-dir)
               "2026-07-05T00:00:00Z"
               "9.9.9"
               (utils:qualify-path "csharp-assembly-utils-package.template.lisp")
               (utils:qualify-path "csharp-assembly-utils.template.lisp")
               nil)
              (let* ((class-file (merge-pathnames "fixture-ext-target.lisp" out-dir))
                     (contents (uiop:read-file-string class-file))
                     (packages-file (merge-pathnames "packages.lisp" out-dir))
                     (packages-contents (uiop:read-file-string packages-file)))
                (assert-test (not (null (search "(cl:defun clean-ext (obj! amount)" contents))) t
                            "generate-class-file emits the surviving CleanExt as an obj!-first wrapper")
                (assert-test (not (null (search "(dotnet:static \"Fixture.Ext.Holder\" \"CleanExt\" obj! amount))" contents))) t
                            "clean-ext forwards to dotnet:static on the holder type, not <type-str>")
                (assert-test (search "(cl:defun dirty-ext" contents) nil
                            "generate-class-file does not emit the dirty DirtyExt")
                (assert-test (search "(cl:defun frob" contents) nil
                            "generate-class-file does not emit either ambiguous Frob overload")
                (assert-test (not (null (search "#:clean-ext" packages-contents))) t
                            "packages.lisp exports clean-ext for fixture-ext-target")
                (assert-test (search "#:frob" packages-contents) nil
                            "packages.lisp does not export the skipped, ambiguous frob")))
          (when (probe-file fixture-file)
            (delete-file fixture-file))
          (when (probe-file out-dir)
            (uiop:delete-directory-tree out-dir :validate t))))))
