;;; Copyright 2026 Douglas P. Fields, Jr.

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter *cspackages-components*
    (let* ((base-dir (uiop:pathname-directory-pathname
                      (cond (*load-pathname* *load-pathname*)
                            (*load-truename* *load-truename*)
                            (t *default-pathname-defaults*))))
           (cspackages-dir (uiop:subpathname base-dir "cspackages/")))
      (if (uiop:directory-exists-p cspackages-dir)
          (mapcar (lambda (file)
                    (let ((name (pathname-name file)))
                      (list :file (concatenate 'string "cspackages/" name)
                            :pathname (uiop:subpathname cspackages-dir (concatenate 'string name ".lisp"))
                            :depends-on '("packages" "utils" "monoutils"))))
                  (remove-if-not (lambda (file)
                                   (string-equal (pathname-type file) "lisp"))
                                 (uiop:directory-files cspackages-dir)))
          nil))))

(defsystem "dotcl-packagegen"
  :description "DotCL C#-assembly-to-Lisp package generator"
  :version "1.18.0"
  :author "Douglas P. Fields, Jr. <symbolics@lisp.engineer>"
  :license "Apache 2.0"
  :depends-on ("dotnet-class")
  ;; Do not include any of the "depends-on" stuff above in the "depends-on"
  ;; clauses in the components!
  :components #.(append
                 '((:file "packages")
                   (:file "utils" :depends-on ("packages"))
                   (:file "monoutils" :depends-on ("packages")))
                 *cspackages-components*
                 (list
                  '(:file "assembly-package-generator" :depends-on ("packages" "utils"))
                  `(:file "package-generator-tests" :depends-on ("utils" "assembly-package-generator"
                                                                 ,@(mapcar (lambda (comp) (second comp)) *cspackages-components*)))
                  '(:file "generator-tests" :depends-on ("package-generator-tests")))))
