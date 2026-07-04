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
        /// A public read-only field, to test that the generator only emits a
        /// getter (no setter) for a public instance field marked readonly.
        /// </summary>
        public readonly int ReadOnlyField;

        /// <summary>
        /// A read-only property.
        /// </summary>
        public string ReadOnlyProperty { get; }

#pragma warning disable CS0649 // never assigned; only its indexer accessors' existence is under test, not their behavior
        private readonly int[] _items;
#pragma warning restore CS0649

        /// <summary>
        /// An indexer to test capture of a property's own index parameters,
        /// as distinct from an ordinary method's parameters.
        /// </summary>
        /// <param name="index">The index to access.</param>
        public int this[int index]
        {
            get => _items[index];
            set => _items[index] = value;
        }

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
    /// A class containing generic methods of one or more type arguments for testing.
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

        /// <summary>
        /// A generic instance method of two type arguments, to test support
        /// for generic methods with more than one type argument.
        /// </summary>
        public T2 Convert<T1, T2>(T1 value)
        {
            return default(T2)!;
        }

        /// <summary>
        /// A generic static method of three type arguments (mirrors the
        /// shape of System.Linq.Enumerable's 3-type-argument Aggregate
        /// overload).
        /// </summary>
        public static T3 Zip<T1, T2, T3>(T1 a, T2 b)
        {
            return default(T3)!;
        }

        /// <summary>
        /// Overload 1 of 2: same name as below, but generic arity 1 --
        /// mirrors System.Linq.Enumerable's Aggregate, which has same-named
        /// overloads of generic arity 1, 2, and 3. The generator must treat
        /// these as distinct, separately-named wrappers rather than merging
        /// them into one (a single Lisp function's lambda list can't flex
        /// between different numbers of generic type-argument parameters).
        /// </summary>
        public static T1 Combine<T1>(T1 a, T1 b)
        {
            return a;
        }

        /// <summary>
        /// Overload 2 of 2: same name as above, but generic arity 2.
        /// </summary>
        public static T2 Combine<T1, T2>(T1 a, T2 seed)
        {
            return seed;
        }
    }

    /// <summary>
    /// A class with public types nested three levels deep, to test that the CIL
    /// nested-type separator '+' (e.g. NestingContainer+NestedLevel2) is handled
    /// correctly in :fully-qualified-name and in the derived Lisp package name.
    /// </summary>
    public class NestingContainer
    {
        /// <summary>
        /// A public type nested one level inside NestingContainer.
        /// </summary>
        public class NestedLevel2
        {
            /// <summary>
            /// A public type nested two levels inside NestingContainer.
            /// </summary>
            public class NestedLevel3
            {
            }
        }
    }
}
