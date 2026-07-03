# Code repository analysis

* Copyright 2026 Douglas P. Fields, Jr.

Opencode info:
* **Session ID:** ses_0e06c2f37ffeXE22gQavMjlk2F
* **Created:** 7/1/2026, 5:26:48 PM
* **Updated:** 7/1/2026, 9:00:49 PM

## User

Please analyze the C# Lisp Package generator. I'd like your thoughts on how we can extend this to handle methods with a lot of overloads like the SpriteBatch.Begin() method.

---

### Why this is the best approach for us:
*   **Zero DotCL changes:** It only changes the text produced by your existing C# and Lisp tools.
*   **High Performance:** It uses native Lisp `cond` and type-checking, which is extremely fast, rather than iterating through a lookup table at runtime.
*   **Maximum Ergonomics:** The user gets a single, clean function with keyword arguments that "just works," regardless of which overload they actually need.
*   **Self-Contained:** All the "intelligence" required to navigate the C# overloads is baked directly into the Lisp package for that specific class.

---

**Example of a Mixed-Mode Wrapper (`normalize`):**

```lisp
;; --- Instance Wrapper ---
(defun normalize (obj &optional &key (rotation 0.0f0 supplied-rotation) ...)
  "Master wrapper for Vector2.Normalize instance overloads."
  (cond
    ((and supplied-rotation ...) 
     (dotnet:invoke obj "Normalize" rotation ...))
    (t (error "No matching instance overload found."))))

;; --- Static Wrapper ---
(defun normalize* (&optional &key (rotation 0.0f0 supplied-rotation) ...)
  "Master wrapper for Vector2.Normalize static overloads."
  (cond
    ((and supplied-rotation ...) 
     (dotnet:static "Vector2" "Normalize" rotation ...))
    (t (error "No matching static overload found."))))
```

---


### 1. Detection (Generator)
The `assembly-package-generator.lisp` will analyze method groups (methods sharing the same name) and classify them:
*   **Complex Method Group**: A group with a threshold of overloads (e.g., 3+).
*   **Mode Classification**:
    *   **Instance-Only**: All methods in the group are instance methods.
    *   **Static-Only**: All methods in the group are static methods.
    *   **Mixed-Mode**: The group contains both instance and static methods.

### 2. Parameterization (Generator)
For any **Complex Method Group**, the generator will:
1.  **Union Parameters**: Collect the union of all parameter names across all overloads in the group.
2.  **Resolve Defaults**: For every parameter in the union, determine its `initial-value` and `type` from the metadata.

### 3. Hybrid Signature (Generator)
To ensure both ease of use and precision, all generated wrappers will use a **Hybrid Signature**:
*   **Positional Prefix**: The longest sequence of parameters that appear in the same order across the majority of overloads will be emitted as standard `&optional` arguments.
*   **Keyword Suffix**: All remaining parameters will be emitted using the `&key (var initial-val supplied-p)` pattern.

### 4. Naming & Wrapper Generation
The generator will emit the following based on the classification:

| Classification | Instance Wrapper Name | Static Wrapper Name |
| :--- | :--- | :--- |
| **Instance-Only** | `method-name` | N/A |
| **Static-Only** | N/A | `method-name` |
| **Mixed-Mode** | `method-name` | `method-name*` |

**Wrapper Implementation**:
*   All Complex Group wrappers will use a `cond` block for runtime dispatch.
*   The `cond` branches will use the `supplied-p` flags to ensure the arguments provided by the user match the **exact** C# signature of that overload.

### 5. Example Scenarios

**Scenario A: `Vector2.Normalize` (Static-Only, Complex)**
*   Generates: `(defun normalize (&optional ... &key ...) ...)`
*   Uses `cond` to dispatch to the correct static C# overload.

**Scenario B: `SpriteBatch.Begin` (Mixed-Mode, Complex)**
*   Generates Instance: `(defun begin (obj &optional ... &key ...) ...)`
*   Generates Static: `(defun begin* (&optional ... &key ...) ...)`
*   Both use `cond` to dispatch to their respective C# overloads.

**Scenario C: `SimpleMethod` (Instance-Only, Simple/Not Complex)**
*   Generates: `(defun simple-method (obj arg1 arg2) ...)` (Standard behavior).

---

**I am ready to begin implementation. Please let me know if I have your approval!**

---

## User

This is a nice plan. Please implement it. Make sure to write tests for the new cases that will ensure the disambiguation is working properly. Make sure to update the generator version and document the changes in the generator documentation. Make sure to update the README.md and implementation-notes.md and any other applicable documentation. Of course, ensure that the build compiles cleanly and the tests run cleanly. Also, since we're changing the normalize function which was used, that call will need to be updated in the actual game. Thanks! Go to it.
