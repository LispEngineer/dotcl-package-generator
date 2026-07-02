using System;
using System.Linq;
using DotCL;

// Copyright 2026 Douglas P. Fields, Jr.

/** A variety of C# functions that are exposed as part of a Lisp package
 * called "MONOUTILS" - defined in monoutils.lisp. */
public static class MonoUtils {

    /** Proof of concept C# method that adds three lisp Numbers.
     * Throws an error if any argument is not a number. 
     * The error is a LispErrorException wrapping a LispProgramError.
     * (No idea if that is the correct thing to do.)
     */
    public static LispObject AddThree(LispObject[] args) {
        // 1. Validate argument count
        if (args.Length != 3) {
            throw new LispErrorException(
                new LispProgramError("ADD3: wrong number of arguments (expected 3)")
            );
        }

        // 2. Validate and cast arguments using AsNumber (throws Lisp TYPE-ERROR automatically on failure)
        Number n1 = Runtime.AsNumber(args[0]);
        Number n2 = Runtime.AsNumber(args[1]);
        Number n3 = Runtime.AsNumber(args[2]);

        // 3. Add them using dotcl's polymorphic generic addition
        LispObject sumOfTwo = Runtime.Add(n1, n2);
        LispObject totalSum = Runtime.Add(sumOfTwo, n3);

        return totalSum;
    } // AddThree

    /** This is a C# equivalent to dotnet::%resolve-type in DotCL.
     * This looks up the specified typeName parameter in the
     * dotnet:*type-aliases* hashtable and returns the expanded
     * type name, if found. It looks up both the uppercased version
     * using (ToUpperInvariant()) as well as the originally passed
     * in string. */
    private static string ResolveTypeAlias(string typeName) {
        try {
            Symbol typeAliasesSym = Startup.SymInPkg("*TYPE-ALIASES*", "DOTNET");
            if (typeAliasesSym == null || typeAliasesSym.Value == null) {
                return typeName;
            }
            LispObject val = DynamicBindings.Get(typeAliasesSym);
            if (val is LispHashTable ht) {
                string upperName = typeName.ToUpperInvariant();
                LispObject mapped = ht.Get(new LispString(upperName), Nil.Instance);
                if (mapped is LispString ls) {
                    return ls.Value;
                } else if (mapped is Symbol sym) {
                    return sym.Name;
                }

                mapped = ht.Get(new LispString(typeName), Nil.Instance);
                if (mapped is LispString ls2) {
                    return ls2.Value;
                } else if (mapped is Symbol sym2) {
                    return sym2.Name;
                }
            }
        } catch {
            // Fall back to original typeName if lookups fail or are not bound yet
            // TODO: Log something?
        }
        return typeName;
    } // ResolveTypeAlias


    /// <summary>
    /// <lispdoc>(monoutils:dotnet-p object) -- Returns T if the object is a LispDotNetObject (a wrapper for a .NET instance), NIL otherwise.</lispdoc>
    /// Checks if the provided LispObject is a wrapper for a .NET object.
    /// This includes Boxed wrappers.
    /// </summary>
    /// <param name="args">A LispObject array where args[0] is the object to test.</param>
    /// <returns>T.Instance if it is a LispDotNetObject, otherwise Nil.Instance.</returns>
    public static LispObject IsDotNetObject(LispObject[] args) {
        if (args == null) { return Nil.Instance; }
        if (args.Length < 1) { return Nil.Instance; }

        var obj = args[0];

        // TODO: Multiple value return saying if it is boxed?
        return obj is LispDotNetObject ? T.Instance : Nil.Instance;
    } // Is DotNetObject

    /// <summary>
    /// <lispdoc>(monoutils:boxed-dotnet-p object) -- Returns T if the object is a LispDotNetBoxed (a .NET object wrapper with an explicit type hint), NIL otherwise.</lispdoc>
    /// Checks if the provided LispObject is a LispDotNetBoxed instance.
    /// </summary>
    /// <param name="args">A LispObject array where args[0] is the object to test.</param>
    /// <returns>T.Instance if it is a LispDotNetBoxed, otherwise Nil.Instance.</returns>
    public static LispObject IsBoxedDotNetObject(LispObject[] args) {
        if (args == null) { return Nil.Instance; }
        if (args.Length < 1) { return Nil.Instance; }

        var obj = args[0];

        return obj is LispDotNetBoxed ? T.Instance : Nil.Instance;
    } // Is DotNetObject

    /// <summary>
    ///   Retrieves the methods of the specified Type using the provided binding flags.
    /// </summary>
    /// <param name="type">The type to reflect on.</param>
    /// <param name="bindingFlags">The integer representation of BindingFlags.</param>
    /// <returns>An array of MethodInfo objects.</returns>
    public static System.Reflection.MethodInfo[] GetTypeMethods(Type type, int bindingFlags) {
        return type.GetMethods((System.Reflection.BindingFlags)bindingFlags);
    }

    /// <summary>
    ///   Retrieves the properties of the specified Type using the provided binding flags.
    /// </summary>
    /// <param name="type">The type to reflect on.</param>
    /// <param name="bindingFlags">The integer representation of BindingFlags.</param>
    /// <returns>An array of PropertyInfo objects.</returns>
    public static System.Reflection.PropertyInfo[] GetTypeProperties(Type type, int bindingFlags) {
        return type.GetProperties((System.Reflection.BindingFlags)bindingFlags);
    }

    /// <summary>
    ///   Retrieves the fields of the specified Type using the provided binding flags.
    /// </summary>
    /// <param name="type">The type to reflect on.</param>
    /// <param name="bindingFlags">The integer representation of BindingFlags.</param>
    /// <returns>An array of FieldInfo objects.</returns>
    public static System.Reflection.FieldInfo[] GetTypeFields(Type type, int bindingFlags) {
        return type.GetFields((System.Reflection.BindingFlags)bindingFlags);
    }

    /// <summary>
    ///   Retrieves the constructors of the specified Type using the provided binding flags.
    /// </summary>
    /// <param name="type">The type to reflect on.</param>
    /// <param name="bindingFlags">The integer representation of BindingFlags.</param>
    /// <returns>An array of ConstructorInfo objects.</returns>
    public static System.Reflection.ConstructorInfo[] GetTypeConstructors(Type type, int bindingFlags) {
        return type.GetConstructors((System.Reflection.BindingFlags)bindingFlags);
    }
} // MonoUtils

/** Register the various functions in the MONOUTILS package
 * by finding or creating the package, adding the necessary new
 * symbols, and setting their function slots.
 *
 * This should be called before doing anything else in Lisp.
 */
public static class MonoUtilsRegistrar {
    public static void Initialize() {
        // Find or create the Lisp package named "MONOUTILS"
        Package? pkg = Package.FindPackage("MONOUTILS");
        pkg ??= new Package("MONOUTILS");

        // Intern and export "ADD3"
        var (sym1, _) = pkg.Intern("ADD3"); // Intern the symbol in the "MONOUTILS" package
        pkg.Export(sym1); // Export the symbol so it is public
        // Assign the C# method to the symbol's Function slot
        sym1.Function = new LispFunction(MonoUtils.AddThree, "ADD3", arity: 3);

        // Intern and export "DOTNET-P"
        var (sym3, _) = pkg.Intern("DOTNET-P");
        pkg.Export(sym3);
        sym3.Function = new LispFunction(MonoUtils.IsDotNetObject, "DOTNET-P", arity: 1);

        // Intern and export "BOXED-DOTNET-P"
        var (sym4, _) = pkg.Intern("BOXED-DOTNET-P");
        pkg.Export(sym4);
        sym4.Function = new LispFunction(MonoUtils.IsBoxedDotNetObject, "BOXED-DOTNET-P", arity: 1);
    }
}
