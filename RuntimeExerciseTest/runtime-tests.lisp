;;; Copyright 2026 Douglas P. Fields, Jr.
;;;
;;; Runtime exercise suite (doc/plan-fable-detail-02.md): actually calls the
;;; freshly-generated wrapper functions in RuntimeExerciseTest/gen/ against
;;; live .NET objects, guarding the v48-v50 runtime-dispatch escape class
;;; (omitted-optional-passed-as-nil, Master Wrapper dispatch ordering,
;;; Nullable<T> guards) that string-level codegen assertions cannot see.
;;;
;;; Deliberately self-contained -- does NOT reuse tests/framework.lisp (that
;;; belongs to the generator's own system and does metadata schema
;;; validation); this project depends only on the generated
;;; csharp-assembly-packages system plus DotCL.

(cl:defpackage :runtime-exercise
  (:use :cl)
  (:export #:run-runtime-exercise-tests))

(cl:in-package :runtime-exercise)

;; Short nicknames for the generated packages under test, for readability.
;; Wrapped in eval-when so the nicknames also exist at compile time -- the
;; reader needs them to resolve ref:/ecs:/etc. package-qualified symbols
;; later in THIS same file, and a bare top-level form is only executed at
;; load time, not while the file is being compiled.
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (cl:rename-package :assembly-to-lispy-test-target-runtime-exercise-fixtures
                      :assembly-to-lispy-test-target-runtime-exercise-fixtures '("REF"))
  (cl:rename-package :assembly-to-lispy-test-target-edge-case-struct
                      :assembly-to-lispy-test-target-edge-case-struct '("ECS"))
  (cl:rename-package :assembly-to-lispy-test-target-runtime-op-struct
                      :assembly-to-lispy-test-target-runtime-op-struct '("ROS"))
  (cl:rename-package :assembly-to-lispy-test-target-generic-dispatch-fixture-a
                      :assembly-to-lispy-test-target-generic-dispatch-fixture-a '("GDA"))
  (cl:rename-package :assembly-to-lispy-test-target-generic-dispatch-fixture-b
                      :assembly-to-lispy-test-target-generic-dispatch-fixture-b '("GDB"))
  (cl:rename-package :assembly-to-lispy-test-target-event-test-class
                      :assembly-to-lispy-test-target-event-test-class '("ETC"))
  (cl:rename-package :assembly-to-lispy-test-target-generic-method-test-class
                      :assembly-to-lispy-test-target-generic-method-test-class '("GMTC"))
  (cl:rename-package :system-time-span :system-time-span '("TS")))

;;; ---------------------------------------------------------------------
;;; Minimal assertion framework

(cl:defvar *pass-count* 0)
(cl:defvar *failures* cl:nil)

(cl:defun record-pass ()
  (cl:incf *pass-count*))

(cl:defun record-failure (description expected actual)
  (cl:push (cl:format cl:nil "~A: expected ~S, got ~S" description expected actual) *failures*))

(cl:defmacro check-equal (description expected-form actual-form)
  `(cl:handler-case
       (cl:let ((expected ,expected-form) (actual ,actual-form))
         (cl:if (cl:equal expected actual)
             (record-pass)
             (record-failure ,description expected actual)))
     (cl:error (e) (record-failure ,description "(no error)" (cl:format cl:nil "signaled: ~A" e)))))

(cl:defmacro check-true (description form)
  `(cl:handler-case
       (cl:if ,form
           (record-pass)
           (record-failure ,description cl:t cl:nil))
     (cl:error (e) (record-failure ,description cl:t (cl:format cl:nil "signaled: ~A" e)))))

;;; ---------------------------------------------------------------------
;;; 1. v48 guard: omitted optional arguments

(cl:defun test-omitted-defaults ()
  (cl:let ((f (ref:new)))
    (check-equal "v48: all defaults omitted" "42|hi|Second" (ref:echo-defaults f))
    (check-equal "v48: one supplied, rest defaulted" "7|hi|Second" (ref:echo-defaults f :x 7))))

;;; ---------------------------------------------------------------------
;;; 2. v49 guard: overload dispatch ordering with defaults

(cl:defun test-dispatch-ordering ()
  (cl:let ((f (ref:new)))
    (check-equal "v49: int arm" "int:5" (ref:discriminate f 5))
    (check-equal "v49: string arm, default extra" "string:yo:0" (ref:discriminate f "yo"))
    (check-equal "v49: string arm, explicit extra" "string:yo:9" (ref:discriminate f "yo" :extra 9))))

;;; ---------------------------------------------------------------------
;;; 3. v50 guard: Nullable<T> arguments (struct, primitive, cross-assembly)

(cl:defun test-nullable-arguments ()
  (cl:let ((f (ref:new)) (s (ecs:new 7)))
    (check-equal "v50: nullable struct, has value" "has:7:0" (ref:echo-nullable-struct f s))
    (check-equal "v50: nullable struct, none" "none:0" (ref:echo-nullable-struct f cl:nil))
    (check-equal "v50: nullable int, has value" "has:9:0" (ref:echo-nullable-int f 9))
    (check-equal "v50: nullable int, none" "none:0" (ref:echo-nullable-int f cl:nil))
    (check-equal "v50: nullable cross-assembly TimeSpan, has value"
                 "has:100:0" (ref:echo-nullable-time-span f (ts:new 100)))
    (check-equal "v50: nullable cross-assembly TimeSpan, none"
                 "none:0" (ref:echo-nullable-time-span f cl:nil))))

;;; ---------------------------------------------------------------------
;;; 4. Master Wrapper branches: string/number/object

(cl:defun test-master-wrapper-branches ()
  (cl:let ((f (ref:new)) (obj (ecs:new 1)))
    (check-equal "master wrapper: string branch" "string" (ref:which-overload f "abc"))
    (check-equal "master wrapper: int branch" "int" (ref:which-overload f 5))
    (check-equal "master wrapper: object branch" "object" (ref:which-overload f obj))))

;;; ---------------------------------------------------------------------
;;; 5. Operators: +, =, unary -, bitwise-or!

(cl:defun test-operators ()
  (cl:let ((a (ros:new 3)) (b (ros:new 4)))
    (check-equal "operator +" 7 (ros:value (ros:+ a b)))
    (check-true "operator =, equal" (ros:= a a))
    (check-true "operator =, not equal" (cl:not (ros:= a b)))
    (check-equal "operator unary -" -3 (ros:value (ros:- a)))
    (check-equal "operator bitwise-or!" 7 (ros:value (ros:bitwise-or! a b)))))

;;; ---------------------------------------------------------------------
;;; 6. Properties/fields/setf, indexer, static memoization

(cl:defun test-properties-fields-setf ()
  (cl:let ((s (ecs:new 5)))
    (check-equal "instance field get" 5 (ecs:public-field s))
    (cl:setf (ecs:public-field s) 99)
    (check-equal "instance field set" 99 (ecs:public-field s))
    (check-equal "instance property initial" 0 (ecs:mutable-property s))
    (cl:setf (ecs:mutable-property s) 42)
    (check-equal "instance property set" 42 (ecs:mutable-property s))
    (cl:setf (ecs:item s 2) 77)
    (check-equal "indexer get/set" 77 (ecs:item s 2))
    (cl:setf (ecs:static-read-write-property) 123)
    (check-equal "static read-write property" 123 (ecs:static-read-write-property)))
  ;; --constant-properties memoization: two reads of a get-only static
  ;; property must be the exact same boxed .NET object (cl:eq), not merely
  ;; equal values -- see doc/generator-design-notes.md's "Static Constants
  ;; and Symbol Macros" discussion.
  (cl:let ((a ref:+shared-singleton+) (b ref:+shared-singleton+))
    (check-true "constant-properties memoization (cl:eq)" (cl:eq a b))))

;;; ---------------------------------------------------------------------
;;; 7. Events

(cl:defun test-events ()
  (cl:let* ((et (etc:new))
            (fired (cl:list cl:nil))
            (handler (cl:lambda (sender args)
                       (cl:declare (cl:ignore sender args))
                       (cl:setf (cl:first fired) cl:t))))
    (etc:add-something-happened et handler)
    (etc:raise-something-happened et)
    (check-true "event handler ran after add" (cl:first fired))
    (cl:setf (cl:first fired) cl:nil)
    (etc:remove-something-happened et handler)
    (etc:raise-something-happened et)
    (check-true "event handler did not run after remove" (cl:not (cl:first fired)))))

;;; ---------------------------------------------------------------------
;;; 8. csharp-generics unified dispatch

(cl:defun test-defgeneric-dispatch ()
  (cl:let ((a (gda:new)) (b (gdb:new)))
    (check-equal "csharp-generics dispatch, class A" "A" (csharp-generics:kind a))
    (check-equal "csharp-generics dispatch, class B" "B" (csharp-generics:kind b))))

;;; ---------------------------------------------------------------------
;;; 9. Generic methods (own type arguments): arity-1, arity-2, name<> dispatcher

(cl:defun test-generic-methods ()
  (cl:let ((g (gmtc:new)))
    (check-equal "generic static method, arity 1 (Create<T>)" 0 (gmtc:create "System.Int32"))
    (check-equal "generic instance method, arity 2 (Convert<T1,T2>)"
                 0 (gmtc:convert "System.Int32" "System.Int32" g 5))
    (check-equal "generic name<> dispatcher, arity 1 (Combine<T1>)"
                 3 (gmtc:combine "System.Int32" 3 4))
    (check-equal "generic name<> dispatcher, arity 2 (Combine<T1,T2>)"
                 7 (gmtc:combine (cl:list "System.String" "System.Int32") "ignored" 7))))

;;; ---------------------------------------------------------------------
;;; 10. Struct boxing mutation (documents current behavior)

(cl:defun test-struct-boxing-mutation ()
  (cl:let* ((s1 (ecs:new 1)) (s2 s1))
    (cl:setf (ecs:mutable-property s2) 55)
    (check-equal "struct boxing mutation visible through alias" 55 (ecs:mutable-property s1))))

;;; ---------------------------------------------------------------------
;;; BCL smoke test: System.TimeSpan

(cl:defun test-bcl-smoke ()
  (cl:let ((ts (ts:from-hours 2)))
    (check-true "BCL smoke: TimeSpan.FromHours(2).TotalSeconds == 7200" (cl:= 7200 (ts:total-seconds ts)))))

;;; ---------------------------------------------------------------------
;;; Entry point

(cl:defun run-runtime-exercise-tests ()
  (cl:setf *pass-count* 0)
  (cl:setf *failures* cl:nil)
  (test-omitted-defaults)
  (test-dispatch-ordering)
  (test-nullable-arguments)
  (test-master-wrapper-branches)
  (test-operators)
  (test-properties-fields-setf)
  (test-events)
  (test-defgeneric-dispatch)
  (test-generic-methods)
  (test-struct-boxing-mutation)
  (test-bcl-smoke)
  (cl:format cl:t "~&[runtime-tests] ~D passed, ~D failed.~%" *pass-count* (cl:length *failures*))
  (cl:dolist (f (cl:reverse *failures*))
    (cl:format cl:t "[runtime-tests] FAIL: ~A~%" f))
  (cl:length *failures*))
