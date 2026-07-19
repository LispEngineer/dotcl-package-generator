;;; Douglas P. Fields, Jr. - symbolics@lisp.engineer
;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Developed with Antigravity CLI (Gemini 3.5 Flash and 3.1 Pro)
;;;
;;; C# Assembly Lisp Package Generator -- signature-string and docstring helpers
;;; Split out of the former assembly-package-generator.lisp (pure internal
;;; reorganization; see doc/generator-design-notes.md).

(in-package :assembly-package-generator)


(defun property-signature-str (prop)
  "Return a human-readable signature string for a property or indexer, e.g.
   'Item[Int32] -> String' or 'Length -> Int32'."
  (let* ((name (getf prop :name))
         (return-type (simple-type-name (or (getf prop :type) "void")))
         (params (getf prop :parameters))
         (param-strs (mapcar (lambda (p) (simple-type-name (getf p :type))) params)))
    (if params
        (format nil "~A[~{~A~^, ~}] -> ~A" name param-strs return-type)
        (format nil "~A -> ~A" name return-type))))

(defun format-default-suffix (p)
  "Returns \"\" for a parameter plist P with no default, or a trailing
   \" = <value>\" description of its default for a human-readable signature
   string. A usable default (usable-default-p) renders its actual value; an
   :unrepresentable default -- reflection reporting a non-nullable
   value-type parameter's default(SomeStruct) as null, or a non-null
   struct/object default -- renders a note naming its real C# type and
   value instead, since the generated wrapper cannot supply it and requires
   the caller to pass this argument explicitly (see usable-default-p and
   clean-constructor-p/clean-method-p's docstrings)."
  (if (not (getf p :has-default))
      ""
      (let ((kind (getf p :default-kind))
            (val (getf p :default-value))
            (default-type (getf p :default-type)))
        (case kind
          (:unrepresentable
           (format nil " = ~A [C# default of type ~A -- not representable in Lisp, must be supplied]"
                   val default-type))
          (:null " = null")
          (:string (format nil " = ~S" val))
          (t (format nil " = ~A" val))))))

(defun method-signature-str (method)
  "Return a human-readable signature string for a method, e.g.
   'Contains(ref Rectangle, out bool) -> void' or
   'ScrollIntoView(Object, ScrollIntoViewStyle = BringIntoView) -> void'."
  (let* ((name (getf method :name))
         (return-type (simple-type-name (or (getf method :return-type) "void")))
         (params (getf method :parameters))
         (param-strs (mapcar (lambda (p)
                               (let ((modifier-str (cond
                                                     ((getf p :ref) "ref ")
                                                     ((getf p :out) "out ")
                                                     ((getf p :params) "params ")
                                                     (t "")))
                                     (type-str (simple-type-name (getf p :type))))
                                 (format nil "~A~A~A" modifier-str type-str (format-default-suffix p))))
                             params)))
    (format nil "~A(~{~A~^, ~}) -> ~A" name param-strs return-type)))

(defun constructor-overload-name (ctor)
  "Generate a disambiguated Lisp function name for an overloaded constructor,
   by appending kebab-cased simple parameter type names.
   e.g., ctor(float, float) => \"new-single-single\""
  (let* ((params (getf ctor :parameters))
         (type-suffixes (mapcar (lambda (p)
                                  (camel-to-kebab (simple-type-name (getf p :type))))
                                params)))
    (if type-suffixes
        (format nil "new-~{~A~^-~}" type-suffixes)
        "new")))

(defun constructor-signature-str (ctor)
  "Return a human-readable signature string for a constructor, e.g.
   'new(ref Rectangle, out bool)' or 'new(Boolean = true, SystemManagers = null)'."
  (let* ((params (getf ctor :parameters))
         (param-strs (mapcar (lambda (p)
                               (let ((modifier-str (cond
                                                     ((getf p :ref) "ref ")
                                                     ((getf p :out) "out ")
                                                     ((getf p :params) "params ")
                                                     (t "")))
                                     (type-str (simple-type-name (getf p :type))))
                                 (format nil "~A~A~A" modifier-str type-str (format-default-suffix p))))
                             params)))
    (format nil "new(~{~A~^, ~})" param-strs)))

(defun obsolete-docstring-line (member-plist)
  "Returns an \"OBSOLETE...~%\"-style line for MEMBER-PLIST (a type/method/
   constructor/property/field/event plist) when it carries :obsolete t
   (AssemblyToLispy.cs's [System.Obsolete] reflection, doc/plan-fable-
   detail-16.md's Half A), or \"\" otherwise: \"OBSOLETE.\" with no
   :obsolete-message, \"OBSOLETE: <message>\" with one, and \"OBSOLETE
   (error-level)...\" instead of bare \"OBSOLETE...\" when :obsolete-error
   is also set (a C#-compiler-error-level obsolete member is still
   reflected and still gets a real wrapper here -- this is visibility
   only, never an exclusion)."
  (if (getf member-plist :obsolete)
      (let* ((message (getf member-plist :obsolete-message))
             (label (if (getf member-plist :obsolete-error) "OBSOLETE (error-level)" "OBSOLETE")))
        (if (and message (> (length message) 0))
            (format nil "~A: ~A~%" label message)
            (format nil "~A.~%" label)))
      ""))

(defun build-docstring (summary returns parameters doc-plist &optional member-plist)
  "Builds a formatted docstring from documentation elements. MEMBER-PLIST,
   when supplied, contributes obsolete-docstring-line's own leading
   \"OBSOLETE...\" line ahead of everything else (doc/plan-fable-detail-
   16.md)."
  (with-output-to-string (out)
    (format out "~A" (obsolete-docstring-line member-plist))
    (when (and summary (> (length summary) 0))
      (format out "Summary: ~A~%" summary))
    (when (and returns (> (length returns) 0))
      (format out "Returns: ~A~%" returns))
    (when (and parameters doc-plist)
      (let ((doc-params (getf doc-plist :parameters)))
        (format out "Parameters:~%")
        (dolist (p parameters)
          (let* ((pname (getf p :name))
                 (ptype (getf p :type))
                 (pdoc (find pname doc-params :key (lambda (dp) (getf dp :name)) :test #'string=))
                 (pdesc (if pdoc (getf pdoc :description) "")))
            (format out "  - ~A (~A): ~A~%"
                    (map-param-name pname)
                    ptype
                    pdesc)))))))

(defun format-overload-doc-block (signature-str summary returns parameters doc-plist &optional member-plist)
  "Builds one documentation block for a single overload inside a combined
   master-wrapper docstring: SIGNATURE-STR (from method-signature-str or
   constructor-signature-str) followed by an indented build-docstring block
   (a leading OBSOLETE line when MEMBER-PLIST is obsolete, then Summary/
   Returns/Parameters sourced from the assembly's XML doc comments) when
   any of that was available; omits the indented block entirely when
   there is nothing to show."
  (let ((body (build-docstring summary returns parameters doc-plist member-plist)))
    (with-output-to-string (out)
      (format out "~A~%" signature-str)
      (dolist (line (split-string body #\Newline))
        (when (> (length line) 0)
          (format out "  ~A~%" line))))))

(defun format-combined-overloads-docstring (header signature-fn methods)
  "Builds a combined docstring for a master wrapper dispatching across
   METHODS (method or constructor plists): HEADER, then one
   format-overload-doc-block per method (using SIGNATURE-FN, either
   #'method-signature-str or #'constructor-signature-str, to produce that
   overload's signature line), so the full set of available overloads and
   their XML documentation stays visible even though only one dispatching
   function is generated. Each overload's own :obsolete status (doc/plan-
   fable-detail-16.md) is passed through to format-overload-doc-block, so
   an obsolete overload buried inside a Master Wrapper is still visibly
   flagged in its own indented block."
  (with-output-to-string (out)
    (format out "~A~%" header)
    (dolist (m methods)
      (let* ((m-doc (getf m :documentation))
             (summary (getf m-doc :summary))
             (returns (getf m-doc :returns))
             (params (getf m :parameters))
             (sig (funcall signature-fn m)))
        (format out "~%~A" (format-overload-doc-block sig summary returns params m-doc m))))))
