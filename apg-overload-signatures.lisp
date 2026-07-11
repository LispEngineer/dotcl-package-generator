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

(defun method-signature-str (method)
  "Return a human-readable signature string for a method, e.g.
   'Contains(ref Rectangle, out bool) -> void'."
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
                                 (format nil "~A~A" modifier-str type-str)))
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
   'new(ref Rectangle, out bool)'."
  (let* ((params (getf ctor :parameters))
         (param-strs (mapcar (lambda (p)
                               (let ((modifier-str (cond
                                                     ((getf p :ref) "ref ")
                                                     ((getf p :out) "out ")
                                                     ((getf p :params) "params ")
                                                     (t "")))
                                     (type-str (simple-type-name (getf p :type))))
                                 (format nil "~A~A" modifier-str type-str)))
                             params)))
    (format nil "new(~{~A~^, ~})" param-strs)))

(defun build-docstring (summary returns parameters doc-plist)
  "Builds a formatted docstring from documentation elements."
  (with-output-to-string (out)
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

(defun format-overload-doc-block (signature-str summary returns parameters doc-plist)
  "Builds one documentation block for a single overload inside a combined
   master-wrapper docstring: SIGNATURE-STR (from method-signature-str or
   constructor-signature-str) followed by an indented build-docstring block
   (Summary/Returns/Parameters, sourced from the assembly's XML doc comments)
   when any of that was available; omits the indented block entirely when
   there is nothing to show."
  (let ((body (build-docstring summary returns parameters doc-plist)))
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
   function is generated."
  (with-output-to-string (out)
    (format out "~A~%" header)
    (dolist (m methods)
      (let* ((m-doc (getf m :documentation))
             (summary (getf m-doc :summary))
             (returns (getf m-doc :returns))
             (params (getf m :parameters))
             (sig (funcall signature-fn m)))
        (format out "~%~A" (format-overload-doc-block sig summary returns params m-doc))))))
