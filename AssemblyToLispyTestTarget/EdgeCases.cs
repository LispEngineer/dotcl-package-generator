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
    /// A class with a plain instance EventHandler event, to test that events (previously
    /// invisible entirely, since add_X/remove_X accessors are filtered out by the ordinary
    /// method IsSpecialName filter) are now reflected into a new :events metadata key and
    /// generate add-X/remove-X wrapper functions via dotnet:add-event/dotnet:remove-event.
    /// </summary>
    public class EventTestClass
    {
        /// <summary>
        /// Fires when something interesting happens.
        /// </summary>
        public event EventHandler SomethingHappened = delegate { };

        /// <summary>
        /// Raises SomethingHappened, so the synthetic event has a way to be exercised
        /// end-to-end from a live-CLR test.
        /// </summary>
        public void RaiseSomethingHappened()
        {
            SomethingHappened?.Invoke(this, EventArgs.Empty);
        }
    }

    /// <summary>
    /// Extension methods targeting EventTestClass, to test Version 38's extension-method
    /// injection end-to-end against a real, generated package: one clean survivor
    /// (Describe), one dirty skip (AdjustCount takes a ref parameter), two overloaded
    /// (ambiguous) skips (Frob), and one whose name collides with EventTestClass's own
    /// declared RaiseSomethingHappened method (the class's own member must win).
    /// </summary>
    public static class EventTestClassExtensions
    {
        /// <summary>
        /// A clean extension method with no special parameter modifiers -- should be
        /// injected into EventTestClass's generated package as an obj!-first wrapper.
        /// </summary>
        /// <param name="e">The instance being extended.</param>
        /// <param name="prefix">A prefix to include in the description.</param>
        public static string Describe(this EventTestClass e, string prefix)
        {
            return prefix;
        }

        /// <summary>
        /// A dirty extension method (a ref parameter) -- should be skipped with a
        /// documenting comment, not generated.
        /// </summary>
        /// <param name="e">The instance being extended.</param>
        /// <param name="amount">A ref parameter, making this overload dirty.</param>
        public static void AdjustCount(this EventTestClass e, ref int amount)
        {
        }

        /// <summary>
        /// Overload 1 of 2 of an ambiguous extension-method name -- both overloads should
        /// be skipped with a documenting comment, since extension-method overload dispatch
        /// is not yet supported.
        /// </summary>
        /// <param name="e">The instance being extended.</param>
        public static void Frob(this EventTestClass e)
        {
        }

        /// <summary>
        /// Overload 2 of 2 of the same ambiguous extension-method name.
        /// </summary>
        /// <param name="e">The instance being extended.</param>
        /// <param name="amount">An extra parameter distinguishing this overload.</param>
        public static void Frob(this EventTestClass e, int amount)
        {
        }

        /// <summary>
        /// An extension method whose name collides with EventTestClass's own declared
        /// RaiseSomethingHappened method -- the class's own member must win; this extension
        /// should be skipped with a documenting comment.
        /// </summary>
        /// <param name="e">The instance being extended.</param>
        public static void RaiseSomethingHappened(this EventTestClass e)
        {
        }
    }

    /// <summary>
    /// A class with both a Click event and an unrelated method AddClick(), to test the
    /// event-wrapper naming-collision fallback (add-click/remove-click would collide with
    /// the mapped name of AddClick(), so this exercises the tier-2 -event-suffixed fallback).
    /// </summary>
    public class EventNameCollisionTestClass
    {
        /// <summary>
        /// An event whose synthesized add-click/remove-click wrapper names collide with
        /// the AddClick()/RemoveClick() methods below.
        /// </summary>
#pragma warning disable CS0067 // deliberately never raised; only its add/remove wrapper naming collision with AddClick()/RemoveClick() is under test
        public event EventHandler Click = delegate { };
#pragma warning restore CS0067

        /// <summary>
        /// An unrelated method that happens to map to the same Lisp name (add-click) that
        /// the Click event above would otherwise synthesize.
        /// </summary>
        public void AddClick()
        {
        }

        /// <summary>
        /// An unrelated method that happens to map to the same Lisp name (remove-click) that
        /// the Click event above would otherwise synthesize.
        /// </summary>
        public void RemoveClick()
        {
        }
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

        /// <summary>
        /// A binary operator exercising a newly-mapped operator symbol (op_Modulus -> %).
        /// </summary>
        public static EdgeCaseStruct operator %(EdgeCaseStruct a, EdgeCaseStruct b)
        {
            return new EdgeCaseStruct();
        }

        /// <summary>
        /// A unary operator sharing this type's other operator's arity-1 call shape,
        /// to exercise arity-based unary/binary disambiguation for a non-generic type.
        /// </summary>
        public static EdgeCaseStruct operator -(EdgeCaseStruct a)
        {
            return a;
        }

        /// <summary>
        /// A plain mutable static field (not readonly, not const), to test
        /// that the generator emits both a getter and a setter for it.
        /// </summary>
        public static int MutableStaticField;

        /// <summary>
        /// A static read-write property, to test that the generator emits
        /// both a getter and a setf-able setter for it.
        /// </summary>
        public static int StaticReadWriteProperty { get; set; }

        /// <summary>
        /// A static write-only property, to test that the generator emits
        /// only a set-name function (no getter, no setf) for it.
        /// </summary>
        public static int StaticWriteOnlyProperty { set { } }
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
    /// A generic base class whose own base class (System.Collections.Generic.List&lt;T&gt;)
    /// references ITS OWN unresolved generic type parameter, to test Version 40's
    /// :superclass/:interfaces fix: previously, Type.FullName for a generic type
    /// parameterized by an unresolved type parameter (rather than a closed, concrete
    /// type) returns null, silently losing the namespace when the code fell back to
    /// Type.Name (producing bare "List`1" instead of
    /// "System.Collections.Generic.List`1"). GetTypeIdentityFullName's
    /// GetGenericTypeDefinition().FullName fix handles this case identically to the
    /// closed-generic case below, since both need only the generic type DEFINITION's
    /// identity, never the specific instantiation.
    /// </summary>
    /// <typeparam name="T">A generic type parameter, passed through unresolved to the base class.</typeparam>
    public class GenericBaseForSuperclassTest<T> : System.Collections.Generic.List<T>
    {
        /// <summary>
        /// A method of its own, so --export-parents/--export-children has something
        /// concrete to re-export/discover in end-to-end tests.
        /// </summary>
        public T GenericBaseMethod()
        {
            return default(T)!;
        }
    }

    /// <summary>
    /// A concrete (non-generic) class deriving from a CLOSED instantiation of
    /// GenericBaseForSuperclassTest -- to test Version 40's fix for the OTHER half of
    /// the same bug: previously, a closed generic base's :superclass was the full,
    /// assembly-qualified CLR form (e.g.
    /// "AssemblyToLispyTestTarget.GenericBaseForSuperclassTest`1[[...]]"), which could
    /// never string-match GenericBaseForSuperclassTest`1's own bare
    /// :fully-qualified-name, so --export-parents could never resolve it. Also
    /// exercises the new :superclass-closed sibling key, which preserves the
    /// discarded closed-instantiation information (here,
    /// "...GenericBaseForSuperclassTest`1[AssemblyToLispyTestTarget.EdgeCaseStruct]").
    /// </summary>
    public class ConcreteDerivedFromGeneric : GenericBaseForSuperclassTest<EdgeCaseStruct>
    {
    }

    /// <summary>
    /// A class implementing the SAME open generic interface (IEquatable&lt;T&gt;) more than
    /// once, closed over different type arguments -- legal C# (confirmed to compile
    /// directly). This is the specific case Version 40's :interfaces/:interfaces-closed
    /// identity-grouping fix exists to handle without collision: without grouping,
    /// :interfaces would contain "System.IEquatable`1" twice, and :interfaces-closed would
    /// have two entries sharing that same key, silently losing one closed form to any
    /// assoc-style lookup by identity. See doc/generator-design-notes.md's "Generic
    /// Superclass/Interface Identity Matching (Version 40)" section's "A same-identity
    /// collision this needed a second fix for" discussion.
    /// </summary>
    public class MultiEquatable : System.IEquatable<int>, System.IEquatable<string>
    {
        /// <summary>Implements IEquatable&lt;int&gt;.</summary>
        public bool Equals(int other) => false;

        /// <summary>Implements IEquatable&lt;string&gt;.</summary>
        public bool Equals(string? other) => false;
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
