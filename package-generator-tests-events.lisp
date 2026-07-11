;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Package Generator Test Suite -- Events cluster.
;;; Split out of the former package-generator-tests.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :package-generator-tests)

(defun run-events-tests ()
  (format *error-output* "--- Running Events Tests ---~%")

    ;; 13. Instance events: generate-class-file must emit an add-X/remove-X
    ;;     wrapper pair calling dotnet:add-event/dotnet:remove-event, per
    ;;     doc/generator-design-notes.md's Events (Version 32) section.
  (let* ((class-plist
             '(:fully-qualified-name "Fixture.Clickable"
               :kind :class
               :fields nil
               :properties nil
               :methods nil
               :constructors nil
               :events ((:name "Click" :type "System.EventHandler"
                         :add-method "add_Click" :remove-method "remove_Click"
                         :documentation (:summary "Fires on click.")))))
           (out-dir (merge-pathnames "package-generator-tests-events-out/"
                                     (uiop:temporary-directory))))
      (unwind-protect
          (progn
            (ensure-directories-exist out-dir)
            (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
            (let* ((class-file (merge-pathnames "fixture-clickable.lisp" out-dir))
                   (contents (uiop:read-file-string class-file)))
              (assert-test (not (null (search "(cl:defun add-click (obj! handler)" contents))) t
                          "generate-class-file emits an add-X wrapper for an instance event")
              (assert-test (not (null (search "(dotnet:add-event (cl:the (dotnet \"Fixture.Clickable\") obj!) \"Click\" handler))" contents))) t
                          "generate-class-file's add-X wrapper calls dotnet:add-event")
              (assert-test (not (null (search "(cl:defun remove-click (obj! handler)" contents))) t
                          "generate-class-file emits a remove-X wrapper for an instance event")
              (assert-test (not (null (search "(dotnet:remove-event (cl:the (dotnet \"Fixture.Clickable\") obj!) \"Click\" handler))" contents))) t
                          "generate-class-file's remove-X wrapper calls dotnet:remove-event"))
            (multiple-value-bind (exports shadows) (assembly-package-generator::compute-package-exports-and-shadows class-plist nil)
              (declare (ignore shadows))
              (assert-test (and (member "add-click" exports :test #'string=) t) t
                          "compute-package-exports-and-shadows exports add-click")
              (assert-test (and (member "remove-click" exports :test #'string=) t) t
                          "compute-package-exports-and-shadows exports remove-click")))
        (when (probe-file out-dir)
          (uiop:delete-directory-tree out-dir :validate t))))

    ;; 13.1 Event naming-collision fallback: a Click event alongside an
    ;;      unrelated AddClick()/RemoveClick() method pair must escalate to
    ;;      the tier-2 -event-suffixed names, and generate-class-file /
    ;;      compute-package-exports-and-shadows must agree on the result.
  (let* ((class-plist
             '(:fully-qualified-name "Fixture.CollidingClickable"
               :kind :class
               :fields nil
               :properties nil
               :methods ((:name "AddClick" :is-static nil :return-type "System.Void" :parameters nil)
                         (:name "RemoveClick" :is-static nil :return-type "System.Void" :parameters nil))
               :constructors nil
               :events ((:name "Click" :type "System.EventHandler"
                         :add-method "add_Click" :remove-method "remove_Click"))))
           (out-dir (merge-pathnames "package-generator-tests-events-collision-out/"
                                     (uiop:temporary-directory))))
      (unwind-protect
          (progn
            (ensure-directories-exist out-dir)
            (assembly-package-generator:generate-class-file class-plist (namestring out-dir))
            (let* ((class-file (merge-pathnames "fixture-colliding-clickable.lisp" out-dir))
                   (contents (uiop:read-file-string class-file)))
              (assert-test (not (null (search "(cl:defun add-click-event (obj! handler)" contents))) t
                          "generate-class-file falls back to add-click-event when add-click collides with AddClick()")
              (assert-test (not (null (search "(cl:defun remove-click-event (obj! handler)" contents))) t
                          "generate-class-file falls back to remove-click-event when remove-click collides with RemoveClick()")
              (assert-test (search "(cl:defun add-click (obj! handler)" contents) nil
                          "generate-class-file does not also emit the colliding tier-1 add-click"))
            (multiple-value-bind (exports shadows) (assembly-package-generator::compute-package-exports-and-shadows class-plist nil)
              (declare (ignore shadows))
              (assert-test (and (member "add-click-event" exports :test #'string=) t) t
                          "compute-package-exports-and-shadows agrees on the add-click-event fallback")
              (assert-test (and (member "remove-click-event" exports :test #'string=) t) t
                          "compute-package-exports-and-shadows agrees on the remove-click-event fallback")))
        (when (probe-file out-dir)
          (uiop:delete-directory-tree out-dir :validate t))))

    ;; 13.2 collect-class-instance-generics (the --defgeneric unified-generics
    ;;      collector) must include instance events, exactly
    ;;      as add-X/remove-X method-names entries -- this is the regression
    ;;      test for the "add-click missing from generics" bug report (see
    ;;      PLAN.md's "Enhance Generics with Event Methods" section). Reuses
    ;;      the same Fixture.Clickable/Fixture.CollidingClickable shapes as
    ;;      tests 13/13.1 above.
  (let ((clickable
            '(:fully-qualified-name "Fixture.Clickable"
              :kind :class
              :fields nil :properties nil :methods nil :constructors nil
              :events ((:name "Click" :type "System.EventHandler"
                        :add-method "add_Click" :remove-method "remove_Click"))))
          (colliding-clickable
            '(:fully-qualified-name "Fixture.CollidingClickable"
              :kind :class
              :fields nil :properties nil
              :methods ((:name "AddClick" :is-static nil :return-type "System.Void" :parameters nil)
                        (:name "RemoveClick" :is-static nil :return-type "System.Void" :parameters nil))
              :constructors nil
              :events ((:name "Click" :type "System.EventHandler"
                        :add-method "add_Click" :remove-method "remove_Click")))))
      (multiple-value-bind (method-names setter-names)
          (assembly-package-generator::collect-class-instance-generics clickable nil)
        (assert-test (and (member "add-click" method-names :test #'string=) t) t
                    "collect-class-instance-generics includes an event's add-X wrapper")
        (assert-test (and (member "remove-click" method-names :test #'string=) t) t
                    "collect-class-instance-generics includes an event's remove-X wrapper")
        (assert-test (member "add-click" setter-names :test #'string=) nil
                    "collect-class-instance-generics never puts an event's add-X into setter-names"))
      ;; The actual regression: when add-click/remove-click collide with an
      ;; unrelated AddClick()/RemoveClick() method pair, collect-class-instance-
      ;; generics must escalate to the exact same tier-2 names generate-class-
      ;; file/compute-package-exports-and-shadows do -- never a hardcoded
      ;; expectation, an agreement check, so the two can never drift apart.
      (multiple-value-bind (collector-method-names collector-setter-names)
          (assembly-package-generator::collect-class-instance-generics colliding-clickable nil)
        (declare (ignore collector-setter-names))
        (multiple-value-bind (exports shadows) (assembly-package-generator::compute-package-exports-and-shadows colliding-clickable nil)
          (declare (ignore shadows))
          (assert-test (and (member "add-click-event" collector-method-names :test #'string=) t) t
                      "collect-class-instance-generics escalates to add-click-event on collision")
          (assert-test (and (member "remove-click-event" collector-method-names :test #'string=) t) t
                      "collect-class-instance-generics escalates to remove-click-event on collision")
          ;; "add-click"/"remove-click" ARE still expected here -- they're the
          ;; unrelated AddClick()/RemoveClick() *methods'* own wrapper names
          ;; (zero-arg, no handler), not the event's tier-1 name (which was
          ;; correctly escalated away from that collision, to add-click-event).
          (assert-test (list (and (member "add-click-event" exports :test #'string=) t)
                             (and (member "add-click-event" collector-method-names :test #'string=) t))
                      '(t t)
                      "collect-class-instance-generics and compute-package-exports-and-shadows agree on the add-click-event escalation")
          (assert-test (list (and (member "remove-click-event" exports :test #'string=) t)
                             (and (member "remove-click-event" collector-method-names :test #'string=) t))
                      '(t t)
                      "collect-class-instance-generics and compute-package-exports-and-shadows agree on the remove-click-event escalation"))))

    ;; 13.3 End-to-end: a --defgeneric-opted-in class with an event must get
    ;;      add-X/remove-X cl:defgeneric/cl:defmethod forms in the generated
    ;;      csharp-generics.lisp, forwarding correctly.
  (let* ((fixture-metadata
             (list '(:fully-qualified-name "Fixture.EventGeneric"
                     :kind :class
                     :fields nil :properties nil :methods nil :constructors nil
                     :events ((:name "Click" :type "System.EventHandler"
                               :add-method "add_Click" :remove-method "remove_Click")))))
           (fixture-file (merge-pathnames "package-generator-tests-event-generics-fixture.lispy-metadata"
                                          (uiop:temporary-directory)))
           (out-dir (merge-pathnames "package-generator-tests-event-generics-out/"
                                     (uiop:temporary-directory))))
      (unwind-protect
          (progn
            (with-open-file (s fixture-file :direction :output :if-exists :supersede :if-does-not-exist :create)
              (prin1 fixture-metadata s))
            (ensure-directories-exist out-dir)
            (assembly-package-generator:generate-assembly-packages-batch
             (list (list :metadata-file (namestring fixture-file)
                         :assembly-name "Fixture.dll"
                         :classes (list (list :name "Fixture.EventGeneric" :constant-properties "" :defgeneric t))))
             (namestring out-dir)
             "2026-07-05T00:00:00Z"
             "9.9.9"
             (utils:qualify-path "csharp-assembly-utils-package.template.lisp")
             (utils:qualify-path "csharp-assembly-utils.template.lisp")
             nil)
            (let* ((generics-file (merge-pathnames "csharp-generics.lisp" out-dir))
                   (contents (uiop:read-file-string generics-file)))
              (assert-test (not (null (search "(cl:defgeneric add-click (obj! cl:&rest args)" contents))) t
                          "csharp-generics.lisp defines a generic for an event's add-X wrapper")
              (assert-test (not (null (search "(cl:defgeneric remove-click (obj! cl:&rest args)" contents))) t
                          "csharp-generics.lisp defines a generic for an event's remove-X wrapper")
              (assert-test (not (null (search "(cl:defmethod add-click ((obj! #.(dotnet:class-for-type \"Fixture.EventGeneric\")) cl:&rest args)" contents))) t
                          "csharp-generics.lisp emits a literal defmethod for the add-X wrapper")
              (assert-test (not (null (search "(cl:apply (cl:function fixture-event-generic:add-click) obj! args))" contents))) t
                          "csharp-generics.lisp's add-X defmethod forwards via cl:apply to the opted-in class")))
        (when (probe-file fixture-file)
          (delete-file fixture-file))
        (when (probe-file out-dir)
          (uiop:delete-directory-tree out-dir :validate t)))))
