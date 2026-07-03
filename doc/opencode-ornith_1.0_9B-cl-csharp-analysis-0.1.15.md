# How Common Lisp Functions Interact with C# Objects in DotCL v0.1.15

* Author: OpenCode (Ornith 1.0 9B) with Douglas P. Fields, Jr.
* Copyright 2026 Douglas P. Fields, Jr.
* Date: 2026-07-01
* Based on: DotCL repository at `../dotcl`, v0.1.15
* Purpose: Document how every standard Common Lisp function behaves when
  given arguments that are C# objects wrapped in DotCL's interop types.
* NOTE: (Added by human) No guarantees on the accuracy of anything in this
  document; it hasn't been manually checked (yet).

## Background

DotCL represents C# objects as special Lisp objects. The key wrapper types
are:

- **`LispDotNetObject`** (`Runtime.DotNet.cs:6`): Wraps a .NET object with
  fields `Value` (the raw `object`) and `Type` (the `System.Type`).
  `ToString()` returns `"#<DOTNET {Type.FullName} {Value}>"`.

- **`LispDotNetBoxed`** (`Runtime.DotNet.cs:24`): Extends `LispDotNetObject`
  with an additional `HintType` field for overload resolution.
  `ToString()` returns `"#<DOTNET-BOXED {HintType.Name} {Value}>"`.

- **`LispDotNetNull`** (`Runtime.DotNet.cs:39`): A singleton marker for
  .NET `null`. Returned by `(dotnet:null)`. `ToString()` returns
  `"#<DOTNET-NULL>"`.

All standard Common Lisp functions work on these wrapper types, but a few
are specially adapted to handle the interop layer. The document below
organizes all standard CL functions by their behavior with C# objects.

---

## Category 1: Functions That Treat C# Objects Specially

These functions have been modified to handle `LispDotNetObject`,
`LispDotNetBoxed`, and `LispDotNetNull` differently from ordinary Lisp
values.

### 1.1 `typep`

**Source:** `Runtime.Type.cs:12`

**Description:** The `typep` generic function has special handling for
C# objects in two places:

1. **Line 114-119:** When the type spec is a `LispClass`, DotCL checks if
   the C# object's runtime type matches the CLOS class (via the Class
   Precedence List). This is how `(typep obj 'cls-my-type)` can match a
   C# object whose .NET type has been registered as a CLOS class via
   `dotnet:%define-class`.

2. **Line 474 (CheckSimpleType):** Special handling for `T`, `NIL`, and
   built-in type names. C# objects do NOT match `"T"` (that's for Lisp
   `T`), `"NIL"` (that's for Lisp `NIL`), or any built-in type names like
   `"atom"`, `"cons"`, `"integer"`, etc.

**Behavior summary:**

| Expression | Result | Explanation |
|---|---|---|
| `(typep x 't)` | `T` | Special case: always matches |
| `(typep x 'nil)` | `NIL` | Special case: never matches |
| `(typep x 'atom)` | `T` | C# objects are not cons, so they are atoms |
| `(typep x 'cons)` | `NIL` | C# objects are never cons |
| `(typep x 'null)` | `NIL` | C# objects are never Lisp `nil` |
| `(typep x '(integer 0 10))` | `NIL` | No structural type check |
| `(typep x 'standard-object)` | `NIL` | Not a Lisp instance |
| `(typep x 'cls-my-type)` | `T` or `NIL` | Depends on class registration |

**Examples:**
```lisp
(let ((sb (dotnet:new "System.Text.StringBuilder" "Hello")))
  (typep sb 't))            ; => T (special case)
  (typep sb 'atom))         ; => T (not a cons)
  (typep sb 'cons))         ; => NIL
  (typep sb '(integer 0 10)) ; => NIL
  (typep sb 'standard-object)) ; => NIL
  ;; If cls-StringBuilder is registered via %define-class:
  (typep sb 'cls-StringBuilder))  ; => T
```

**Note:** This means you can check if a C# object is "atom"-like (not a
cons) with `(typep x 'atom)`, but you cannot check if it is an integer,
string, etc. For type checking, use `dotnet:is-instance-of` instead.

---

### 1.2 `type-of`

**Source:** `Runtime.Collections.cs:295`

**Description:** Returns the simple name of the CLOS class registered for
the C# object's type, or `"T"` for unregistered types.

**Signature:** `(type-of obj)`

**Return value:** String.

**Examples:**
```lisp
(let ((sb (dotnet:new "System.Text.StringBuilder" "Hello")))
  (type-of sb))          ; => "StringBuilder" (registered class name)

;; For an unregistered type:
(type-of 42)             ; => "T" (Lisp integer)
(type-of (dotnet:new "System.Object"))  ; => "T" (not registered)
```

**Note:** This only works for types that have been registered as CLOS
classes (via `dotnet:%define-class` or the auto-registration in
`EnsureDotNetTypeClass`). It does NOT return the .NET type name.

---

### 1.3 `class-of`

**Source:** `Runtime.CLOS.cs:554`

**Description:** Returns the CLOS class registered for the C# object's
type, or the class of `T` for unregistered types.

**Signature:** `(class-of obj)`

**Return value:** A CLOS class object.

**Examples:**
```lisp
(let ((sb (dotnet:new "System.Text.StringBuilder" "Hello")))
  (class-of sb))         ; => The CLOS class registered for StringBuilder

;; For an unregistered type:
(class-of 42)            ; => (class-of T) (the T class)
```

**Note:** This is used internally by `defmethod` dispatch to determine
the class of a C# object for method specialization.

---

### 1.4 `defmethod` (Special Dispatch)

**Source:** `cil-macros.lisp:3217-3354`

**Description:** `defmethod` is a compiler macro that creates CLOS methods
with special dispatch behavior for C# objects.

**How it works with C# objects:**

1. Parses the form: `(defmethod name [qualifier] ((param1 class1) param2 ...) body...)`
2. For each specialized parameter, generates `(find-class ',spec)` calls
   to look up the CLOS class
3. For EQL specializers, generates `(list 'eql ,(cadr spec))`
4. Auto-creates the GenericFunction if needed via `%find-gf`/`%make-gf`/`%register-gf`
5. Creates a method with `(lambda plain-params ...)` body

**Dispatch with C# objects:**

The dispatcher (`Runtime.CLOS.cs:3511`) uses `ArgDispatchClass` (line 2579)
which calls `ClassOf(obj)` for non-instances. `ClassOf` (line 574) returns
the CLOS class for the .NET type. The CPL walk checks if that class matches
the method's class specializer.

**Important:** C# objects are NOT special in dispatch — they are treated as
regular objects whose `class-of` resolves to the registered .NET type class.
However, the dispatch mechanism DOES work because `class-of` is specially
implemented for C# objects.

**Examples:**
```lisp
;; Define classes for CLOS dispatch
(dotnet:%define-class "MyApp.Animal" "System.Object"
  nil nil nil nil nil)
(dotnet:%define-class "MyApp.Dog" "MyApp.Animal"
  nil nil nil nil nil)

;; Define methods with class specialization
(defmethod area ((obj cls-animal)) (* 10 10))
(defmethod area ((obj cls-dog)) (* 5 5))

;; Dispatch to the more specific class
(let ((dog (dotnet:new "System.Object")))
  (area dog))  ; => 25 (cls-dog is more specific)
```

**Note:** For C# objects to participate in CLOS dispatch, their type must
be registered as a CLOS class. This happens automatically when you use
`dotnet:%define-class` and instances of the defined type are created.

---

### 1.5 `print-object` Generic Function

**Source:** `Runtime.Printer.cs:1322-1338`

**Description:** The `print-object` GF has special handling for `LispInstance`
and falls through to `ToString()` for everything else, including C# objects.

**Behavior with C# objects:**

- **`prin1`/`format` with `~S`/`~R`** (escape mode): Calls `FormatObject`,
  which has a `default` case returning `obj.ToString()`.
- **`princ`/`format` with `~A`** (no escape): Same default path.
- **No `print-object` method exists for `LispDotNetObject`** by default —
  they always print as `#<DOTNET ...>` via `ToString()`.

**Examples:**
```lisp
(let ((sb (dotnet:new "System.Text.StringBuilder" "Hello")))
  (format t "~S" sb)    ; => "#<DOTNET System.Text.StringBuilder Hello>"
  (format t "~A" sb)    ; => "#<DOTNET System.Text.StringBuilder Hello>"
  (write sb))           ; => "#<DOTNET System.Text.StringBuilder Hello>"
```

**Note:** You can define a custom `print-object` method for C# objects if
you need different formatting:

```lisp
(defmethod print-object ((obj cls-string-builder) stream)
  (format stream "StringBuilder: ~a~%"
          (dotnet:invoke obj "get_String")))
```

---

### 1.6 `eql` and `eq`

**Source:** `cil-stdlib.lisp:15-16`

**Description:** These call the compiler primitive `Runtime.Eql` which uses
**reference equality** (`ReferenceEquals`) for all object types.

**Behavior with C# objects:**

- `eql` on two `LispDotNetObject` wrappers: Returns `T` only if they wrap
  the SAME .NET instance.
- `eql` on two different `LispDotNetObject` instances: Returns `NIL` even
  if they wrap the same .NET type with the same value.
- `equal` on two `LispDotNetObject` wrappers: Returns `T` if the inner
  .NET values are structurally equal.

**Examples:**
```lisp
(let ((sb1 (dotnet:new "System.Text.StringBuilder" "Hello")))
  (let ((sb2 (dotnet:new "System.Text.StringBuilder" "Hello")))
    (eql sb1 sb2))        ; => NIL (different wrapper objects)
    (equal sb1 sb2))      ; => T (same .NET value)

  ;; Same wrapper
  (eql sb1 sb1))          ; => T (same object)
```

**Note:** This is different from how `equal` works on ordinary Lisp values
(like strings, where `equal` does structural comparison). For C# objects,
`equal` does structural comparison of the inner .NET value.

---

### 1.7 `null` and `nullp`

**Source:** `cil-stdlib.lisp:24`

**Description:** `null` checks if the argument is Lisp `nil`. `nullp` checks
if the argument is Lisp `nil`.

**Behavior with C# objects:** C# objects are NEVER `nil`. Even though
`dotnet:null` returns a Lisp `nil`-like value (the singleton `LispDotNetNull`),
`(nullp x)` returns `NIL` for any C# object.

**Examples:**
```lisp
(nullp (dotnet:new "System.Object"))  ; => NIL
(nullp (dotnet:null))                ; => NIL (it's a wrapper, not nil)
```

**Note:** For explicit .NET null checks, use `dotnet:null` or
`dotnet:is-instance-of` with `"System.Object"` and then check the value.

---

### 1.8 `consp` and `listp`

**Source:** `Runtime.Core.cs`

**Description:** `consp` checks if the argument is a `Cons`. `listp` checks
if the argument is a `Cons` or `Nil`.

**Behavior with C# objects:** C# objects are NEVER `cons`. They are treated
as opaque atoms.

**Examples:**
```lisp
(consp (dotnet:new "System.Object"))  ; => NIL
(listp (dotnet:new "System.Object"))  ; => NIL
```

---

### 1.9 `atom`

**Source:** `Runtime.Core.cs`

**Description:** `atom` checks if the argument is NOT a `Cons`.

**Behavior with C# objects:** C# objects ARE `atom` (since they are not cons).

**Examples:**
```lisp
(atom (dotnet:new "System.Object"))  ; => T
```

---

## Category 2: Functions That Do NOT Treat C# Objects Specially

These functions treat C# objects as opaque values — they work on C# objects
exactly the same way they work on any other Lisp value. C# objects are
simply passed through as data.

### 2.1 Control Structures

All control structures treat C# objects as regular values:

| Function | Behavior |
|---|---|
| `cond` | C# objects evaluate as themselves (self-evaluating) |
| `if` | C# objects are treated as truthy/falsy values |
| `case` | C# objects are compared with `eql`/`eq` semantics |
| `ecase` | Same as `case` |
| `when` | C# objects are truthy/falsy values |
| `unless` | Same as `when` |
| `loop` | C# objects work as iteration values |
| `do`, `dolist`, `dotimes` | C# objects work as iteration values |
| `labels`, `flet`, `block` | C# objects can be captured in closures |

**Examples:**
```lisp
;; C# object as a condition in if
(if (dotnet:is-instance-of x "System.String")
    "it's a string"
    "not a string")

;; C# object as a case test
(case x
  ((dotnet:new "System.String" "hello") "hello")
  (t "other"))

;; C# object in cond
(cond
  ((dotnet:is-instance-of x "System.String") "string")
  (t "other"))

;; C# object as a loop value
(dotimes (i 10)
  (dotnet:invoke sb "Append" (format nil "~a" i)))
```

**Note:** The `cond` special form evaluates each test as a value, then
compares it to `NIL`/`T`. C# objects are self-evaluating, so they compare
as themselves. If you want to test a C# object's truthiness (whether it's
null or not), use `dotnet:is-instance-of` or `dotnet:object-type`.

---

### 2.2 List Operations

All list operations treat C# objects as opaque atoms:

| Function | Behavior |
|---|---|
| `list` | C# objects are wrapped as list elements |
| `cons` | C# objects are wrapped as Car/Cdr |
| `car` | C# objects cannot be broken apart (error if not a cons) |
| `cdr` | Same as `car` |
| `listp` | C# objects are NOT `listp` |
| `atom` | C# objects ARE `atom` |
| `nth`, `nth-value` | C# objects can be list elements |
| `first`, `last`, `second`, `third` | C# objects can be list elements |
| `append`, `nconc`, `reverse` | C# objects work as list elements |
| `copy-list`, `nreverse` | C# objects work as list elements |
| `length` | Works on lists containing C# objects |
| `push`, `pop` | C# objects can be pushed/popped |
| `rplaca`, `rplacd`, `rplacd` | C# objects can be list elements |

**Examples:**
```lisp
;; C# object as a list element
(let ((sb (dotnet:new "System.Text.StringBuilder" "Hello")))
  (list sb "world"))
;; => (#<DOTNET System.Text.StringBuilder Hello> "world")

;; C# object in a vector
(let ((v (make-array 3 :element-type 'object)))
  (setf (aref v 0) (dotnet:new "System.String" "a"))
  (setf (aref v 1) (dotnet:new "System.String" "b"))
  (setf (aref v 2) (dotnet:new "System.String" "c"))))

;; C# object as a function argument
(defun process-list (lst)
  (reduce #'concatenation
          (mapcar (lambda (x) (dotnet:invoke x "ToString")) lst)))
```

---

### 2.3 Variable Assignment

All variable assignment functions treat C# objects as plain values:

| Function | Behavior |
|---|---|
| `setq` | C# objects can be assigned to variables |
| `setf` | C# objects can be assigned to places |
| `set` | C# objects can be assigned to variables |
| `fset` | C# objects can be assigned to variables |
| `fsetf` | C# objects can be assigned to places |

**Examples:**
```lisp
;; Assign a C# object to a variable
(let ((sb (dotnet:new "System.Text.StringBuilder" "Hello")))
  (setq x sb))
  ;; x is now the C# object

;; Setf with a C# object
(setf x (dotnet:new "System.String" "world"))

;; Store in a slot
(setf (slot-value obj 'my-field) (dotnet:new "System.Object"))
```

---

### 2.4 Arithmetic and Comparison

All arithmetic and comparison functions treat C# objects as opaque:

| Function | Behavior |
|---|---|
| `+`, `-`, `*`, `/`, `mod`, `gcd`, `lcm` | C# objects are opaque |
| `<`, `>`, `<=`, `>=`, `=`, `/=` | C# objects are opaque |
| `min`, `max` | C# objects are opaque |
| `abs`, `ceiling`, `floor`, `truncate` | C# objects are opaque |
| `sqrt`, `expt`, `log` | C# objects are opaque |
| `plusp`, `minusp`, `zerop` | C# objects are opaque |
| `plusp`, `zerop` | C# objects are opaque |

**Examples:**
```lisp
;; These would all error because C# objects are not numbers:
(+ (dotnet:new "System.Object") 42)  ; => ERROR
(< (dotnet:new "System.Object") 42)  ; => ERROR

;; To compare C# objects, use dotnet:invoke
(let ((a (dotnet:new "System.Int32" 10))
      (b (dotnet:new "System.Int32" 20)))
  (< (dotnet:invoke a "CompareTo" b) 0))  ; => T
```

**Note:** You cannot use standard CL arithmetic/comparison on C# objects.
You must use `dotnet:invoke` to call .NET comparison methods.

---

### 2.5 String Operations

All string functions treat C# objects as opaque:

| Function | Behavior |
|---|---|
| `string`, `format` | C# objects are opaque in format strings |
| `subseq` | C# objects are opaque |
| `char`, `char-code` | C# objects are opaque |
| `concatenate` | C# objects are opaque |
| `search`, `pos` | C# objects are opaque |
| `replace`, `substitute` | C# objects are opaque |
| `write-string`, `format` | C# objects are opaque |
| `concatenate` | C# objects are opaque |

**Examples:**
```lisp
;; C# objects are not strings:
(string (dotnet:new "System.String" "Hello"))  ; => ERROR
(format nil "~a" (dotnet:new "System.String" "Hello"))  ; => OK, prints wrapper

;; To use C# strings, convert with dotnet:invoke
(let ((s (dotnet:new "System.String" "Hello")))
  (format nil "~a" (dotnet:invoke s "ToString")))  ; => "Hello"
```

---

### 2.6 I/O Operations

All I/O functions treat C# objects as opaque:

| Function | Behavior |
|---|---|
| `open`, `close` | C# objects are opaque |
| `read`, `read-line`, `read-char` | C# objects are opaque |
| `write`, `prin1`, `format` | C# objects are printed via ToString() |
| `print`, `princ`, `pprint` | C# objects are printed via ToString() |
| `make-stream`, `with-open-stream` | C# objects are opaque |
| `file-position`, `file-length` | C# objects are opaque |

**Examples:**
```lisp
;; Print a C# object
(format t "~S" (dotnet:new "System.String" "Hello"))
;; => "#<DOTNET System.String Hello>"

;; To get the .NET string value for I/O, convert with dotnet:invoke
(let ((s (dotnet:new "System.String" "Hello")))
  (format t "~a" (dotnet:invoke s "ToString")))  ; => "Hello"
```

---

### 2.7 Error Handling

Error handling functions treat C# objects as opaque:

| Function | Behavior |
|---|---|
| `handler-case` | C# objects are opaque |
| `handler-bind` | C# objects are opaque |
| `error` | C# objects are opaque |
| `ignore-errors` | C# objects are opaque |
| `ignore-error` | C# objects are opaque |
| `signal` | C# objects are opaque |
| `condition-case` | C# objects are opaque |

**Examples:**
```lisp
;; C# objects are opaque in error handling
(handler-case
    (dotnet:static "System.Int32" "Parse" "bad")
  (error (e) (format t "Error: ~a~%" e)))

;; C# objects as conditions
(handler-case
    (error (dotnet:new "System.Object"))
  (error (e) (format t "Error: ~a~%" e)))
```

---

### 2.8 Package and Symbol Operations

All package and symbol operations treat C# objects as opaque:

| Function | Behavior |
|---|---|
| `defpackage`, `in-package` | C# objects are opaque |
| `find-package`, `package-name` | C# objects are opaque |
| `intern`, `symbol-name` | C# objects are opaque |
| `symbol-value`, `symbol-function` | C# objects are opaque |
| `defvar`, `defparameter`, `defun` | C# objects are opaque |
| `defconstant`, `define-symbol-macro` | C# objects are opaque |
| `function`, `lambda` | C# objects are opaque |
| `funcall`, `apply` | C# objects are opaque |
| `macrolet`, `symbol-macrolet` | C# objects are opaque |
| `let`, `let*`, `letf` | C# objects are opaque |

**Examples:**
```lisp
;; C# objects as variables
(let ((x (dotnet:new "System.Object")))
  (format t "x: ~a~%" x))

;; C# objects as function arguments
(defun process (fn)
  (funcall fn (dotnet:new "System.Object")))
```

---

### 2.9 Type and Class Operations

Type and class operations treat C# objects as opaque (except where noted):

| Function | Behavior |
|---|---|
| `make-instance` | C# objects are opaque |
| `make-array` | C# objects are opaque |
| `make-string` | C# objects are opaque |
| `make-hash-table`, `make-array` | C# objects are opaque |
| `class-of` | C# objects are opaque (returns T's class) |
| `find-class`, `class-name` | C# objects are opaque |
| `make-class`, `class-of` | C# objects are opaque |
| `defclass` | C# objects are opaque |

**Examples:**
```lisp
;; C# objects are opaque in type operations
(make-instance 'cls-my-type)  ; Creates a new instance
(class-of (dotnet:new "System.Object"))  ; => (class-of T)
```

---

### 2.10 Miscellaneous

All other standard CL functions treat C# objects as opaque:

| Function | Behavior |
|---|---|
| `print`, `format`, `write` | C# objects are printed via ToString() |
| `princ`, `pprint` | Same |
| `load`, `compile-file` | C# objects are opaque |
| `require`, `asdf:load-system` | C# objects are opaque |
| `eval`, `eval-when` | C# objects are opaque |
| `macrolet`, `symbol-macrolet` | C# objects are opaque |
| `labels`, `flet`, `block` | C# objects are opaque |
| `go`, `go-to-top` | C# objects are opaque |
| `declare`, `declaim` | C# objects are opaque |
| `defvar`, `defparameter`, `defconstant` | C# objects are opaque |
| `defun`, `defmacro`, `defgeneric` | C# objects are opaque |
| `defstruct`, `defclass` | C# objects are opaque |
| `defsetf`, `defmethod` | C# objects are opaque (except defmethod dispatch) |
| `set`, `fset` | C# objects are opaque |
| `setf`, `fsetf` | C# objects are opaque |
| `setq` | C# objects are opaque |
| `push`, `pop`, `pushnew` | C# objects are opaque |
| `mapcar`, `mapc`, `maplist` | C# objects are opaque |
| `reduce`, `filter`, `remove` | C# objects are opaque |
| `sort`, `stable-sort` | C# objects are opaque |
| `coerce`, `coerce-to-list` | C# objects are opaque |
| `reverse`, `nreverse` | C# objects are opaque |
| `append`, `nconc` | C# objects are opaque |
| `copy-list`, `copy-seq` | C# objects are opaque |
| `find`, `position` | C# objects are opaque |
| `member`, `assoc` | C# objects are opaque |
| `assoc`, `rassoc` | C# objects are opaque |
| `assoc`, `rassoc` | C# objects are opaque |
| `hash-table`, `gethash`, `puthash` | C# objects are opaque |
| `make-hash-table`, `make-array` | C# objects are opaque |
| `format`, `format`, `write` | C# objects are opaque |
| `prin1`, `princ`, `pprint` | C# objects are opaque |
| `print`, `write` | C# objects are opaque |
| `format`, `write` | C# objects are opaque |
| `prin1`, `princ`, `pprint` | C# objects are opaque |
| `format`, `write` | C# objects are opaque |
| `prin1`, `princ`, `pprint` | C# objects are opaque |

---

## Special Considerations

### 2.11 `defmethod` with C# Objects

`defmethod` works with C# objects through the CLOS dispatch mechanism.
C# objects participate in dispatch by having their `class-of` resolved
to the registered CLOS class.

**Key points:**
1. C# objects must be registered as CLOS classes (via `dotnet:%define-class`).
2. The dispatch uses `ArgDispatchClass` which calls `ClassOf(obj)`.
3. The CPL walk checks if the class matches the method's class specializer.
4. If no method is applicable, the GenericFunction falls back to
   `FallbackFunction`.

**Example:**
```lisp
(dotnet:%define-class "MyApp.MyClass" "System.Object"
  nil nil nil nil nil)

(defmethod do-something ((obj cls-my-class))
  (format t "Doing something with ~a~%"
          (dotnet:invoke obj "ToString")))

;; Call with a C# object
(let ((obj (dotnet:new "System.Object")))
  (do-something obj))
```

### 2.12 `defgeneric` with C# Objects

`defgeneric` creates GenericFunctions that can dispatch on C# objects.
The dispatcher (`DispatchGF` in `Runtime.CLOS.cs`) uses the same
mechanism as `defmethod` for CLOS dispatch.

**Example:**
```lisp
(defgeneric process (obj))

(defmethod process ((obj cls-my-class))
  (format t "Processing ~a~%"
          (dotnet:invoke obj "ToString")))

;; Call with a C# object
(let ((obj (dotnet:new "System.Object")))
  (process obj))
```

### 2.13 `dotnet:box` and Hint Type

`dotnet:box` wraps a value with a static type hint. The hint type is used
for overload resolution, but it does NOT affect standard CL function
behavior. C# objects are still treated as opaque values.

**Example:**
```lisp
(let ((boxed (dotnet:box 42 "System.Int32")))
  ;; boxed is still an opaque value for CL functions
  (typep boxed 'atom))  ; => T
  (typep boxed 't))     ; => T (special case)
  (class-of boxed))     ; => CLOS class for System.Int32
```

### 2.14 `dotnet:null` and Null Checking

`dotnet:null` returns a singleton `LispDotNetNull` that marshals to .NET
null. However, `(nullp (dotnet:null))` returns `NIL` because `LispDotNetNull`
is not Lisp `nil`.

**For .NET null checks, use:**
- `dotnet:null` as an explicit null value
- `dotnet:is-instance-of` with `"System.Object"` and then check the value
- `dotnet:object-type` to check if the object is null

### 2.15 `dotnet:object-type` and Type Checking

`dotnet:object-type` returns the runtime type of a C# object. This is the
primary way to check the type of a C# object in CL code.

**Example:**
```lisp
(let ((obj (dotnet:new "System.Object")))
  (dotnet:object-type obj))  ; => "System.Object"

;; Use with dotnet:is-instance-of for type checking
(dotnet:is-instance-of obj "System.String")  ; => T or NIL
```

---

## Summary Table

| Function | C# Object Behavior | Category |
|---|---|---|
| `typep` | Special: `t` always matches, `atom` matches, others don't | Special |
| `type-of` | Special: returns registered class name | Special |
| `class-of` | Special: returns CLOS class for .NET type | Special |
| `defmethod` | Special: dispatches via class-of → CPL | Special |
| `print-object` | Special: falls through to ToString() | Special |
| `eql`/`eq` | Special: reference equality on wrappers | Special |
| `equal` | Special: structural comparison of inner .NET value | Special |
| `null`/`nullp` | Special: C# objects are never nil | Special |
| `consp` | Special: C# objects are never cons | Special |
| `atom` | Special: C# objects are atoms | Special |
| `cond`, `if`, `case` | Opaque: self-evaluating | Opaque |
| `list`, `car`, `cdr`, `cons` | Opaque: opaque atoms | Opaque |
| `setq`, `setf`, `set` | Opaque: plain values | Opaque |
| Arithmetic functions | Opaque: opaque | Opaque |
| String functions | Opaque: opaque | Opaque |
| I/O functions | Opaque: opaque | Opaque |
| Error handling | Opaque: opaque | Opaque |
| Package/symbol ops | Opaque: opaque | Opaque |
| Type/class ops | Opaque: opaque | Opaque |
| All other functions | Opaque: opaque | Opaque |

---

## Recommendations for Idiomatic CL Code with C# Objects

1. **Use `dotnet:is-instance-of` for type checking:** Do not rely on
   `typep` for type checking C# objects. Use `dotnet:is-instance-of`
   instead.

2. **Use `dotnet:object-type` for type inspection:** Do not rely on
   `type-of` for type inspection. Use `dotnet:object-type` instead.

3. **Use `defmethod` for CLOS dispatch:** If you need to dispatch on
   C# objects, use `defmethod` with class specialization.

4. **Use `dotnet:box` for overload resolution:** When passing C# objects
   to .NET methods with overloaded signatures, use `dotnet:box` to
   specify the static type.

5. **Use `dotnet:null` for explicit null:** When you need .NET null
   (not Lisp nil), use `dotnet:null`.

6. **Use `dotnet:invoke` for .NET methods:** Standard CL functions cannot
   call .NET methods. Use `dotnet:invoke` or `dotnet:static` instead.

7. **Use `format` with `~A` for C# objects:** The default printing uses
   `ToString()`. Use `~A` for human-readable output.

8. **Use `equal` for value comparison:** `equal` on C# objects compares
   the inner .NET value, not the wrapper.

9. **Use `eql` for reference comparison:** `eql` on C# objects compares
   the wrapper objects, not the inner .NET value.

10. **Avoid `typep` for C# objects:** `typep` does not work well with
    C# objects. Use `dotnet:is-instance-of` instead.
