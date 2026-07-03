# Handling C# Method Overloads in Lisp: Taxonomy & Phased Plan

Handling overloaded methods and operators from C# in Common Lisp is a complex mapping problem because C# relies on static type dispatch (resolved at compile time by the C# compiler based on argument types) while Lisp primarily relies on dynamic typing. 

Below is a taxonomy of how methods can be overloaded in C#, how we can map them to Lisp, and a phased plan to implement these mappings in the generator.

## 1. Taxonomy of C# Overloads

### A. Operator Overloads
**Description**: Static methods with specific names like `op_Addition` (`+`), `op_Multiply` (`*`), `op_Equality` (`==`), `op_Implicit`, etc.
**Characteristics**:
- Always static.
- Usually have exactly 1 or 2 parameters.
- Often have multiple overloads (e.g., `Vector2 * float`, `Vector2 * Vector2`).
- Sometimes map to native Lisp functions (`+`, `*`, `=`, `not=`).

### B. Arity-Based Overloads (Differing Parameter Counts)
**Description**: Methods with the same name but different numbers of parameters.
- Example: `Write(string)` vs `Write(string, object)`.
**Characteristics**:
- Can be resolved purely by counting the number of arguments passed at runtime.
- Extremely common in the .NET Framework (e.g., `Console.WriteLine`).

### C. Type-Based Overloads (Same Parameter Count, Different Types)
**Description**: Methods with the same name and the exact same number of arguments, but differing parameter types.
- Example: `Console.Write(int)` vs `Console.Write(float)`.
**Characteristics**:
- Cannot be resolved purely by argument count.
- `dotnet:invoke` does not currently perform complex runtime overload resolution. It relies heavily on exact type matching or explicit `(the (dotnet "Type") obj)` declarations.

### D. Generic Overloads
**Description**: Methods that take generic type parameters.
- Example: `GetComponent<T>()` vs `GetComponent(Type)`.
**Characteristics**:
- Requires passing generic type arguments (e.g., `[System.Int32]`) via string signatures, which DotCL does not yet natively wrap cleanly in the generator.

### E. Modifiers (`out`, `ref`, `params`)
**Description**: Methods overloaded by or utilizing special argument modifiers.
- Example: `Dictionary.TryGetValue(key, out value)`.
**Characteristics**:
- Lisp does not have pass-by-reference out parameters in the same way. DotCL requires specific boxing or array wrapping to capture `out` parameters.

---

## 2. Complexity Analysis & Applicability

### Easiest Cases to Handle:
1. **Arity-Based Overloads**: Because Lisp supports `&optional` and `&rest` parameters, we can generate a single Lisp function that accepts varying argument counts and manually dispatches to the correct `dotnet:invoke` based on the `(length args)`.
2. **Type-Based Overloads via CLOS `defmethod`**: Since DotCL 0.1.9 supports `defmethod` on native C# objects, we can leverage CLOS generic functions to do the type-dispatching for us!

### Most Complex Cases:
1. **Generic Methods**: Syntax for invoking generic methods via `dotnet:invoke` is verbose and requires full type strings.
2. **`out` / `ref` Parameters**: Requires returning multiple values (`values`) in Lisp, which fundamentally changes the method signature.

### Applicability to Current Classes:
- `System.Console`: Heavily relies on **Type-Based** and **Arity-Based** overloads (e.g., 17 overloads of `Write`).
- `Vector2` / `Color`: Heavily relies on **Operator Overloads** and **Type-Based** overloads (e.g., `Add(Vector2, Vector2)` vs `Add(Vector2, float)`).
- `GraphicsDevice`: Relies on **Arity-Based** overloads.

---

## 3. Phased Implementation Plan

I propose a **4-Phase Deliberate Approach** to safely introduce these methods to the generator without breaking existing code.

### Phase 1: Graceful Degradation & Feedback (Immediate Next Step)
Currently, if a method has overloads, it is silently dropped (`simple-method-p` filters it out).
**Action**: We should partially handle these methods by emitting a commented-out Lisp stub or a `error` throwing function into the generated package, alerting the user to what is missing.
**Example generated output**:
```lisp
;; OVERLOADED METHOD: write
;; This method has 17 overloads in C# and is not yet supported by the generator.
(defun write (&rest args)
  (error "The method 'write' is overloaded in C# and cannot be safely invoked via this generated wrapper yet."))
```
*Benefit*: Developers using the package will get immediate feedback in their IDE/REPL rather than wondering why `console:write` doesn't exist.

### Phase 2: Operator Overloads (The lowest hanging fruit for MonoGame)
Operators are a special case of Type/Arity overloads that have standard names. 
**Action**: Map C# operators to Lisp operators. We can map `op_Addition` to a Lisp function named `add` or `+`. Since `+` is in the `cl` package, we might want to shadow it, or better, just export it as `add`.
To handle the overloads, since operators are static methods, we can generate a single Lisp function using `&rest` and let `dotnet:invoke` attempt to resolve it, OR use CLOS `defmethod`.
*Applicability*: Massive improvement for `Vector2`, `Point`, `Color`.

### Phase 3: Arity-Based Dispatch (Handling `Console`)
When a method has overloads, but all overloads have *different* numbers of arguments.
**Action**: The generator will group all overloads of `WriteLine` by parameter count. It will emit a single Lisp function using `&rest args`. Inside the function, a `cond` statement will check `(length args)` and call the exact `dotnet:invoke` signature needed.
*Applicability*: Will unlock a large portion of `System.Console` and standard library methods.

### Phase 4: Type-Based Dispatch via CLOS `defmethod`
When methods share the same name and arity, but differ by type (e.g., `Write(int)` vs `Write(float)`).
**Action**: The generator will emit a CLOS `defgeneric` for the method. It will then emit multiple `defmethod` forms, specializing the arguments on the generated CLOS wrappers for the C# types (`dotcl-internal::|Int32|`, `dotcl-internal::|Single|`).
*Applicability*: The "holy grail" of Lisp-C# interop. It allows seamless, native-feeling method calls.
