using System;

// Copyright 2026 Douglas P. Fields, Jr.

/** A variety of C# reflection helpers exposed to Lisp for use by this repo's own test
 * suite (tests/framework.lisp), invoked via plain `dotnet:static "MonoUtils" "..."`
 * reflection calls -- not through any Lisp-package-symbol registration. */
public static class MonoUtils {

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
