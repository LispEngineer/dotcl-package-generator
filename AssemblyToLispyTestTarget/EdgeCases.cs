using System;
using System.Runtime.CompilerServices;

namespace AssemblyToLispyTestTarget
{
    /// <summary>
    /// This static class provides extension methods to test the :extension-method and :extension-this keywords.
    /// </summary>
    public static class Extensions
    {
        /// <summary>
        /// A sample extension method.
        /// </summary>
        /// <param name="obj">The object being extended.</param>
        /// <param name="value">A value to add.</param>
        public static void DummyExtension(this object obj, int value)
        {
        }
    }

    /// <summary>
    /// An enum to test enum extraction, including the base type which is byte here instead of the default int.
    /// </summary>
    public enum ByteEnum : byte
    {
        /// <summary>
        /// The first value.
        /// </summary>
        First = 1,
        
        /// <summary>
        /// The second value.
        /// </summary>
        Second = 2
    }

    /// <summary>
    /// An interface to test interface metadata extraction.
    /// </summary>
    public interface IDummyInterface
    {
        /// <summary>
        /// A method required by the interface.
        /// </summary>
        void InterfaceMethod();
    }

    /// <summary>
    /// An abstract base class with a protected constructor.
    /// </summary>
    public abstract class AbstractBase
    {
        /// <summary>
        /// A protected constructor to verify the :protected keyword.
        /// </summary>
        protected AbstractBase()
        {
        }
    }

    /// <summary>
    /// A generic class that inherits from an abstract base and implements an interface.
    /// This tests generics, inheritance, and interface implementation.
    /// </summary>
    /// <typeparam name="T">A generic type parameter.</typeparam>
    public class GenericClass<T> : AbstractBase, IDummyInterface
    {
        /// <summary>
        /// Implements the interface method.
        /// </summary>
        public void InterfaceMethod()
        {
        }

        /// <summary>
        /// An overloaded operator to verify op_Addition mangled name extraction.
        /// </summary>
        /// <param name="a">Left operand.</param>
        /// <param name="b">Right operand.</param>
        /// <returns>A new instance.</returns>
        public static GenericClass<T> operator +(GenericClass<T> a, GenericClass<T> b)
        {
            return new GenericClass<T>();
        }
    }

    /// <summary>
    /// A struct to test value types and various parameter modifiers (ref, out, in).
    /// </summary>
    public struct EdgeCaseStruct
    {
        /// <summary>
        /// A public field.
        /// </summary>
        public int PublicField;

        /// <summary>
        /// A read-only property.
        /// </summary>
        public string ReadOnlyProperty { get; }

        /// <summary>
        /// A method with many parameter modifiers.
        /// </summary>
        /// <param name="outParam">An out parameter.</param>
        /// <param name="refParam">A ref parameter.</param>
        /// <param name="inParam">An in (ref readonly) parameter.</param>
        /// <param name="paramsArray">A params array parameter.</param>
        public void ModifierMethod(out int outParam, ref string refParam, in double inParam, params object[] paramsArray)
        {
            outParam = 0;
        }

        /// <summary>
        /// A method testing default parameter literal values.
        /// </summary>
        /// <param name="strVal">A string default.</param>
        /// <param name="intVal">An int default.</param>
        /// <param name="nullVal">A null object default.</param>
        /// <param name="charVal">A char default.</param>
        public void DefaultsMethod(string strVal = "hello", int intVal = 42, object? nullVal = null, char charVal = 'A')
        {
        }
    }

    /// <summary>
    /// A class containing generic methods of one type argument for testing.
    /// </summary>
    public class GenericMethodTestClass
    {
        /// <summary>
        /// A generic instance method of one type argument.
        /// </summary>
        public T Load<T>(string name)
        {
            return default(T)!;
        }

        /// <summary>
        /// A generic static method of one type argument.
        /// </summary>
        public static T Create<T>()
        {
            return default(T)!;
        }
    }
}
