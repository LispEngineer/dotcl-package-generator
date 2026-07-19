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
;;;
;;; STYLE NOTE -- why every standard CL symbol here is cl:-qualified:
;;; This file constantly mixes generated C# wrappers whose exported names
;;; shadow standard CL symbols (sb:append, sb:length, xv2:+, xv2:-, xv2:=,
;;; dt:-, dt:=, mh:min, mh:max, ecs:item, ros:+, ...) with the real CL
;;; originals, often in the same expression -- e.g.
;;; (cl:= 7 (ts:days (dt:- d1 d2))). Qualifying EVERYTHING makes it visually
;;; unambiguous at every call site which of the two worlds a symbol comes
;;; from, makes an accidental unqualified length/append/= impossible to
;;; write without noticing, and keeps this file immune if the defpackage
;;; below ever grows direct imports from the generated packages (whose
;;; class files never :use :cl at all, for exactly this shadowing reason --
;;; see CLAUDE.md's "Key conventions when touching the generator").
;;; Strictly, (:use :cl) with no shadows would let defun/let/etc. resolve
;;; unqualified today -- the qualification is deliberate defense and
;;; two-namespace clarity, not a current necessity. Contrast
;;; read-check.lisp, which has no generated-package interaction and so uses
;;; plain unqualified CL.

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
  (cl:rename-package :system-time-span :system-time-span '("TS"))
  ;; BCL additions
  (cl:rename-package :system-date-time :system-date-time '("DT"))
  (cl:rename-package :system-text-string-builder :system-text-string-builder '("SB"))
  ;; MonoGame (the same real-world library dotcl-dungeonslime consumes)
  (cl:rename-package :microsoft-xna-framework-vector2 :microsoft-xna-framework-vector2 '("XV2"))
  (cl:rename-package :microsoft-xna-framework-color :microsoft-xna-framework-color '("XCOLOR"))
  (cl:rename-package :microsoft-xna-framework-point :microsoft-xna-framework-point '("XPOINT"))
  (cl:rename-package :microsoft-xna-framework-rectangle :microsoft-xna-framework-rectangle '("XRECT"))
  (cl:rename-package :microsoft-xna-framework-math-helper :microsoft-xna-framework-math-helper '("MH"))
  (cl:rename-package :microsoft-xna-framework-game-time :microsoft-xna-framework-game-time '("XGT"))
  (cl:rename-package :microsoft-xna-framework-input-keys :microsoft-xna-framework-input-keys '("XKEYS"))
  ;; Gum
  (cl:rename-package :gum-data-types-dimension-unit-type :gum-data-types-dimension-unit-type '("DUT"))
  (cl:rename-package :gum-forms-controls-key-combo :gum-forms-controls-key-combo '("KC"))
  (cl:rename-package :mono-game-gum-gue-deriving-text-runtime
                      :mono-game-gum-gue-deriving-text-runtime '("TR")))

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

(cl:defmacro check-near (description expected-form actual-form)
  "Floating-point comparison with a small absolute tolerance, for
single-float results (e.g. Vector2 normalization) where cl:equal's exact
comparison would be brittle."
  `(cl:handler-case
       (cl:let ((expected ,expected-form) (actual ,actual-form))
         (cl:if (cl:< (cl:abs (cl:- expected actual)) 0.001)
             (record-pass)
             (record-failure ,description expected actual)))
     (cl:error (e) (record-failure ,description "(no error)" (cl:format cl:nil "signaled: ~A" e)))))

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
;;; BCL breadth: System.DateTime (ctor Master Wrapper across many arities,
;;; struct operators returning a different struct type)

(cl:defun test-datetime ()
  (cl:let ((d1 (dt:new 2026 7 18))
           (d2 (dt:new 2026 7 11)))
    (check-true "DateTime ctor: year" (cl:= 2026 (dt:year d1)))
    (check-true "DateTime ctor: month" (cl:= 7 (dt:month d1)))
    (check-true "DateTime ctor: day" (cl:= 18 (dt:day d1)))
    (check-true "DateTime operator - returns TimeSpan" (cl:= 7 (ts:days (dt:- d1 d2))))
    (check-true "DateTime operator =, equal" (dt:= d1 (dt:new 2026 7 18)))
    (check-true "DateTime operator =, not equal" (cl:not (dt:= d1 d2)))))

;;; ---------------------------------------------------------------------
;;; BCL breadth: System.Text.StringBuilder (many-overload Append Master
;;; Wrapper, indexer, --defgeneric participation)

(cl:defun test-string-builder ()
  (cl:let ((sb (sb:new)))
    (sb:append sb "Hello")
    (sb:append sb 42)
    (check-equal "StringBuilder append string+int" "Hello42" (sb:to-string sb))
    (check-equal "StringBuilder chars indexer" #\H (sb:chars sb 0))
    (check-true "StringBuilder length" (cl:= 7 (sb:length sb)))))

;;; ---------------------------------------------------------------------
;;; MonoGame: Vector2 -- the actual library where the historical struct
;;; boxing mutation / constant-memoization / dispatch bugs were found
;;; downstream (see doc/generator-design-notes.md's Version 16/29 sections)

(cl:defun test-monogame-vector2 ()
  ;; --constant-properties memoization on a real MonoGame constant
  (cl:let ((a xv2:+zero+) (b xv2:+zero+))
    (check-true "Vector2.Zero memoization (cl:eq)" (cl:eq a b))
    (check-near "Vector2.Zero.X" 0.0 (xv2:x a)))
  (cl:let ((v (xv2:new 3.0 4.0)))
    (check-near "Vector2 ctor + X accessor" 3.0 (xv2:x v))
    (check-near "Vector2.Length()" 5.0 (xv2:length v))
    ;; The exact documented Dungeon Slime transcript case: Normalize()
    ;; mutates the boxed instance in place (and returns nil, since the C#
    ;; method returns void)
    (xv2:normalize v)
    (check-near "Vector2.Normalize() mutates in place: X" 0.6 (xv2:x v))
    (check-near "Vector2.Normalize() mutates in place: Y" 0.8 (xv2:y v))
    (cl:setf (xv2:x v) 9.0)
    (check-near "Vector2 setf X" 9.0 (xv2:x v)))
  (cl:let ((v1 (xv2:new 1.0 2.0)) (v2 (xv2:new 10.0 20.0)))
    (check-near "Vector2 operator +" 11.0 (xv2:x (xv2:+ v1 v2)))
    (check-true "Vector2 operator =, equal" (xv2:= v1 (xv2:new 1.0 2.0)))
    (check-true "Vector2 operator =, not equal" (cl:not (xv2:= v1 v2)))
    ;; --defgeneric: the unified generic dispatches on the MonoGame type too
    (check-near "csharp-generics x dispatch on Vector2" 1.0 (csharp-generics:x v1))))

;;; ---------------------------------------------------------------------
;;; MonoGame: Color (constants + int-ctor Master Wrapper + byte accessors)

(cl:defun test-monogame-color ()
  (check-true "Color.White.R" (cl:= 255 (xcolor:r xcolor:+white+)))
  (cl:let ((c (xcolor:new 10 20 30)))
    (check-true "Color ctor RGB: R" (cl:= 10 (xcolor:r c)))
    (check-true "Color ctor RGB: G" (cl:= 20 (xcolor:g c)))
    (check-true "Color ctor RGB: B" (cl:= 30 (xcolor:b c)))
    (check-true "Color ctor RGB: A defaults opaque" (cl:= 255 (xcolor:a c)))
    (check-true "Color operator =" (xcolor:= c (xcolor:new 10 20 30)))))

;;; ---------------------------------------------------------------------
;;; MonoGame: Point / Rectangle (int structs, methods taking other structs)

(cl:defun test-monogame-point-rectangle ()
  (cl:let ((p (xpoint:new 3 4)))
    (check-true "Point ctor: X" (cl:= 3 (xpoint:x p)))
    (check-true "Point ctor: Y" (cl:= 4 (xpoint:y p)))
    (check-true "Point.Zero.X" (cl:= 0 (xpoint:x xpoint:+zero+))))
  (cl:let ((r (xrect:new 1 2 30 40)))
    (check-true "Rectangle ctor: X" (cl:= 1 (xrect:x r)))
    (check-true "Rectangle ctor: Width" (cl:= 30 (xrect:width r)))
    (check-true "Rectangle.Contains(x, y) inside" (xrect:contains r 5 5))
    (check-true "Rectangle.Contains(x, y) outside" (cl:not (xrect:contains r 100 100)))
    (check-true "Rectangle.Intersects(Rectangle)" (xrect:intersects r (xrect:new 20 30 10 10)))))

;;; ---------------------------------------------------------------------
;;; MonoGame: MathHelper (pure static methods) and GameTime (class ctor
;;; taking struct arguments)

(cl:defun test-monogame-mathhelper-gametime ()
  (check-near "MathHelper.Clamp above range" 1.0 (mh:clamp 5.0 0.0 1.0))
  (check-near "MathHelper.Lerp midpoint" 5.0 (mh:lerp 0.0 10.0 0.5))
  (check-near "MathHelper.ToDegrees(Pi)" 180.0 (mh:to-degrees mh:+pi+))
  (cl:let ((gt (xgt:new (ts:from-hours 1) (ts:from-seconds 30))))
    (check-true "GameTime ctor + TotalGameTime"
                (cl:= 3600 (ts:total-seconds (xgt:total-game-time gt))))
    (check-true "GameTime ElapsedGameTime"
                (cl:= 30 (ts:total-seconds (xgt:elapsed-game-time gt))))))

;;; ---------------------------------------------------------------------
;;; Gum: enum constants, REAL-WORLD extension-method injection (the v38
;;; feature against actual Gum code, not just the synthetic fixture), the
;;; Is*->? predicate renaming, and nullable-enum struct fields

(cl:defun test-gum ()
  ;; DimensionUnitType: enum constants + GumCommon's own
  ;; DimensionUnitTypeExtensions injected as obj!-first wrappers
  (check-true "Gum enum constant non-nil" (cl:not (cl:null dut:+absolute+)))
  (check-true "Gum extension method: Absolute is pixel-based"
              (dut:get-is-pixel-based dut:+absolute+))
  (check-true "Gum extension method: PercentageOfParent is not pixel-based"
              (cl:not (dut:get-is-pixel-based dut:+percentage-of-parent+)))
  ;; KeyCombo: struct with nullable-enum (Keys?) fields; MonoGameGum's own
  ;; KeyComboExtensions also inject here (combo-down? etc.), though calling
  ;; those needs live keyboard state, so only field access is exercised
  (cl:let ((kc (kc:new)))
    (check-true "KeyCombo Keys field initially None (0)"
                (cl:= 0 (xkeys:value__ (kc:pushed-key kc))))
    (cl:setf (kc:pushed-key kc) xkeys:+space+)
    (check-true "KeyCombo nullable Keys field set + read back (Space = 32)"
                (cl:= 32 (xkeys:value__ (kc:pushed-key kc))))
    (cl:setf (kc:triggered-on-repeat? kc) cl:t)
    (check-true "KeyCombo Is*->? renamed bool field" (kc:triggered-on-repeat? kc))))

;;; ---------------------------------------------------------------------
;;; v51 guard: out-parameter support (doc/plan-fable-detail-05.md) --
;;; dotnet:call-out/dotnet:call-out-generic-backed wrappers for methods
;;; whose only special modifier is C#'s `out`.

(cl:defun test-out-parameters ()
  (cl:let ((f (ref:new)))
    ;; Static method, single out parameter, no clean overload of the same
    ;; name -- plain try-get-thing (no /out suffix).
    (cl:multiple-value-bind (ok value) (ref:try-get-thing "found")
      (check-true "v51: try-get-thing found -> t" (cl:eq ok cl:t))
      (check-equal "v51: try-get-thing found value" 42 value))
    (cl:multiple-value-bind (ok value) (ref:try-get-thing "missing")
      (check-true "v51: try-get-thing missing -> nil" (cl:null ok))
      (check-equal "v51: try-get-thing missing value" 0 value))
    ;; Instance method, two out parameters, in C# declaration order.
    (cl:multiple-value-bind (ok doubled label) (ref:try-get-pair f 5)
      (check-true "v51: try-get-pair(5) -> t" (cl:eq ok cl:t))
      (check-equal "v51: try-get-pair(5) doubled" 10 doubled)
      (check-equal "v51: try-get-pair(5) label" "non-negative" label))
    (cl:multiple-value-bind (ok doubled label) (ref:try-get-pair f -3)
      (check-true "v51: try-get-pair(-3) -> t" (cl:eq ok cl:t))
      (check-equal "v51: try-get-pair(-3) doubled" -6 doubled)
      (check-equal "v51: try-get-pair(-3) label" "negative" label))
    ;; Clean Locate(int) vs. out-only Locate(string,int,out int) sharing one
    ;; C# name -- the out-only overload must be named locate/out.
    (check-equal "v51: locate (clean int overload)" "id:7" (ref:locate f 7))
    (cl:multiple-value-bind (ok id) (ref:locate/out f "abc" 10)
      (check-true "v51: locate/out(\"abc\", 10) -> t" (cl:eq ok cl:t))
      (check-equal "v51: locate/out(\"abc\", 10) id" 13 id))))

;;; ---------------------------------------------------------------------
;;; Gum: TextRuntime -- the exact all-parameters-defaulted constructor shape
;;; that motivated the v48 fix (DefaultParameterTestClass mirrors it
;;; synthetically; this is the real one). Constructed with
;;; :full-instantiation nil since full instantiation requires an initialized
;;; Gum/graphics environment this headless test process does not have.

(cl:defun test-gum-text-runtime ()
  (check-true "TextRuntime construction (fullInstantiation: false)"
              (cl:not (cl:null (tr:new :full-instantiation cl:nil)))))

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
  (test-datetime)
  (test-string-builder)
  (test-monogame-vector2)
  (test-monogame-color)
  (test-monogame-point-rectangle)
  (test-monogame-mathhelper-gametime)
  (test-gum)
  (test-gum-text-runtime)
  (test-out-parameters)
  (cl:format cl:t "~&[runtime-tests] ~D passed, ~D failed.~%" *pass-count* (cl:length *failures*))
  (cl:dolist (f (cl:reverse *failures*))
    (cl:format cl:t "[runtime-tests] FAIL: ~A~%" f))
  (cl:length *failures*))
