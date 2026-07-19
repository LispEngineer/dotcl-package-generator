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

        /// <summary>
        /// A read-write instance property, to give the runtime exercise suite
        /// (doc/plan-fable-detail-02.md) a settable instance property to prove the
        /// "struct boxing mutation" aliasing behavior documented in
        /// doc/generator-design-notes.md's "Instance Properties and Struct 'Boxing
        /// Mutation'" section: a setf through one Lisp-level alias of a boxed
        /// EdgeCaseStruct must be visible when read back through a second alias
        /// bound to the same boxed instance.
        /// </summary>
        public int MutableProperty { get; set; }

        /// <summary>
        /// An explicit constructor, so the runtime exercise suite can obtain a
        /// boxed EdgeCaseStruct instance via a generated <c>new</c> wrapper (a
        /// struct with no declared constructor gets no clean-constructor Master
        /// Wrapper at all -- see emit-constructors's "Case 1: No clean
        /// constructors" in apg-class-file-generator.lisp).
        /// </summary>
        /// <param name="publicField">Initial value for PublicField.</param>
        public EdgeCaseStruct(int publicField) : this()
        {
            PublicField = publicField;
            _items = new int[10];
        }

        private readonly int[] _items;

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

        /// <summary>
        /// A method taking a nullable (<c>Nullable&lt;T&gt;</c>) parameter for a
        /// non-primitive value type, with a usable default on a trailing parameter so
        /// this single (non-overloaded) method still reaches the Master Wrapper
        /// dispatch/type-check path (complex-group-p) rather than generate-single-
        /// overload's untyped passthrough. Regression fixture for
        /// doc/bug-in-nullable-value-type-dispatch.md: a boxed EdgeCaseStruct?'s
        /// HasValue==true value is always really a boxed EdgeCaseStruct, never a boxed
        /// Nullable&lt;EdgeCaseStruct&gt;, so the generated guard must check against
        /// EdgeCaseStruct, not the closed Nullable`1[...] type name.
        /// </summary>
        /// <param name="nullableStruct">A nullable EdgeCaseStruct argument.</param>
        /// <param name="extra">A usable default, forcing this method through the Master Wrapper's dispatch/type-check path.</param>
        public void NullableStructParamMethod(EdgeCaseStruct? nullableStruct, int extra = 0)
        {
        }

        /// <summary>
        /// Same shape as <see cref="NullableStructParamMethod"/>, but for a nullable
        /// numeric primitive (<c>int?</c>): its :type is
        /// "System.Nullable`1[System.Int32]", which does not string-match the plain
        /// "System.Int32" primitive check, so without unwrapping to the underlying
        /// type first, this would wrongly fall into the non-primitive
        /// dotnet:is-instance-of fallback (against the wrong, never-matching
        /// Nullable&lt;Int32&gt; type) instead of the correct cl:numberp check.
        /// </summary>
        /// <param name="nullableInt">A nullable int argument.</param>
        /// <param name="extra">A usable default, forcing this method through the Master Wrapper's dispatch/type-check path.</param>
        public void NullableIntParamMethod(int? nullableInt, int extra = 0)
        {
        }
    }

    /// <summary>
    /// A class exercising the various :default-kind shapes a defaulted parameter can take,
    /// including a constructor whose every parameter has a default (the MonoGameGum
    /// TextRuntime shape that motivated this test class), an enum default, an
    /// unrepresentable default(struct) default, and defaults mixed with an overload whose
    /// own trailing parameters are mandatory.
    /// </summary>
    public class DefaultParameterTestClass
    {
        /// <summary>
        /// A constructor with no default-free overload at all: every parameter defaults.
        /// </summary>
        /// <param name="fullInstantiation">A bool default.</param>
        /// <param name="label">A string default.</param>
        public DefaultParameterTestClass(bool fullInstantiation = true, string label = "")
        {
        }

        /// <summary>
        /// An overload of the same constructor with one mandatory leading parameter, so the
        /// two overloads together exercise a mixed mandatory/defaulted Master Wrapper.
        /// </summary>
        /// <param name="id">A mandatory parameter.</param>
        /// <param name="fullInstantiation">A bool default.</param>
        public DefaultParameterTestClass(int id, bool fullInstantiation = true)
        {
        }

        /// <summary>
        /// A method with an enum-typed default parameter.
        /// </summary>
        /// <param name="mode">An enum default.</param>
        public void EnumDefaultMethod(ByteEnum mode = ByteEnum.Second)
        {
        }

        /// <summary>
        /// A method with a nullable-enum-typed default parameter.
        /// </summary>
        /// <param name="mode">A nullable enum default.</param>
        public void NullableEnumDefaultMethod(ByteEnum? mode = ByteEnum.First)
        {
        }

        /// <summary>
        /// A method with a non-nullable value-type parameter defaulting to
        /// <c>default(EdgeCaseStruct)</c> -- reflection reports this as a null
        /// DefaultValue indistinguishable, by value alone, from a real reference-type
        /// null default; must be tagged :unrepresentable, not :null.
        /// </summary>
        /// <param name="value">An unrepresentable struct default.</param>
        public void StructDefaultMethod(EdgeCaseStruct value = default)
        {
        }
    }

    /// <summary>
    /// Two unrelated reference types used only by
    /// <see cref="MasterWrapperDispatchOrderTestClass"/>, to exercise a Master Wrapper's
    /// dispatch order/type-check guards without either type carrying any other meaning.
    /// </summary>
    public class DispatchOrderTestTypeA
    {
    }

    /// <summary>
    /// See <see cref="DispatchOrderTestTypeA"/>.
    /// </summary>
    public class DispatchOrderTestTypeB
    {
    }

    /// <summary>
    /// Reproduces the exact shape of the real-world bug documented in
    /// doc/bug-in-dispatching.md (Microsoft.Xna.Framework.Media.MediaPlayer.Play): two
    /// overloads of one method name share a 1-parameter required prefix, but one overload
    /// is fully required at that arity while the other has a defaulted trailing parameter,
    /// and the discriminating parameter type in both cases is a non-primitive reference
    /// type (exercising format-param-type-check's weak fallback branch, not one of the
    /// numeric/Boolean/String types it special-cases). A correct Master Wrapper must route
    /// a single-argument call to Go(DispatchOrderTestTypeA), never
    /// Go(DispatchOrderTestTypeB, 0) -- the bug this class exists to catch.
    /// </summary>
    public class MasterWrapperDispatchOrderTestClass
    {
        /// <summary>
        /// The fully-required, 1-parameter overload -- the one the caller actually wants
        /// when calling with a single DispatchOrderTestTypeA argument.
        /// </summary>
        /// <param name="a">A DispatchOrderTestTypeA argument.</param>
        public void Go(DispatchOrderTestTypeA a)
        {
        }

        /// <summary>
        /// A 2-parameter overload whose trailing parameter has a usable default, so its
        /// effective minimum arity (1) ties with the overload above's raw arity. Its own
        /// discriminating parameter is a DIFFERENT reference type, so a call passing a
        /// DispatchOrderTestTypeA must never match this overload at all.
        /// </summary>
        /// <param name="b">A DispatchOrderTestTypeB argument.</param>
        /// <param name="extra">A usable int default, making this overload's effective
        /// minimum arity 1, tied with the overload above.</param>
        public void Go(DispatchOrderTestTypeB b, int extra = 0)
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

    /// <summary>
    /// Echo-style fixtures for the runtime exercise suite (doc/plan-fable-detail-02.md,
    /// RuntimeExerciseTest/): each method returns a string that discriminates exactly
    /// which C# overload/default/nullable-state was actually observed, so a Lisp-side
    /// call-through assertion is a single string comparison. These guard the v48-v50
    /// escape class (omitted-optional-passed-as-nil, Master Wrapper dispatch ordering,
    /// Nullable&lt;T&gt; guards) at the actual runtime-dispatch level, not just string-level
    /// codegen assertions.
    /// </summary>
    public class RuntimeExerciseFixtures
    {
        /// <summary>
        /// v48 guard: omitting a defaulted parameter must observe the real C# default,
        /// never a Lisp nil/false/0 substitute.
        /// </summary>
        public string EchoDefaults(int x = 42, string s = "hi", ByteEnum e = ByteEnum.Second)
        {
            return $"{x}|{s}|{e}";
        }

        /// <summary>
        /// v49 guard, overload 1 of 2: a single-int-argument call must reach this
        /// overload, not the string overload's defaulted-extra-parameter form.
        /// </summary>
        public string Discriminate(int a) => $"int:{a}";

        /// <summary>
        /// v49 guard, overload 2 of 2: same arity-1 call shape once the trailing
        /// default is considered, but a different (and discriminable) parameter type.
        /// </summary>
        public string Discriminate(string a, int extra = 0) => $"string:{a}:{extra}";

        /// <summary>
        /// v50 guard: a real value must dispatch with HasValue true and the actual
        /// value observed.
        /// </summary>
        public string EchoNullableStruct(EdgeCaseStruct? s, int extra = 0)
            => s.HasValue ? $"has:{s.Value.PublicField}:{extra}" : $"none:{extra}";

        /// <summary>
        /// v50 guard, numeric-primitive-nullable sibling of
        /// <see cref="EchoNullableStruct"/>.
        /// </summary>
        public string EchoNullableInt(int? n, int extra = 0)
            => n.HasValue ? $"has:{n}:{extra}" : $"none:{extra}";

        /// <summary>
        /// v50 guard, cross-assembly sibling of <see cref="EchoNullableStruct"/>: T
        /// (System.TimeSpan) is declared in a different assembly (System.Runtime.dll)
        /// than this class (AssemblyToLispyTestTarget.dll), exercising the
        /// cross-assembly type-resolution half of the v50 bug class.
        /// </summary>
        public string EchoNullableTimeSpan(System.TimeSpan? t, int extra = 0)
            => t.HasValue ? $"has:{t.Value.Ticks}:{extra}" : $"none:{extra}";

        /// <summary>Master Wrapper branch 1 of 3: string-typed.</summary>
        public string WhichOverload(string s) => "string";

        /// <summary>Master Wrapper branch 2 of 3: number-typed.</summary>
        public string WhichOverload(int n) => "int";

        /// <summary>Master Wrapper branch 3 of 3: object-typed (the weak fallback).</summary>
        public string WhichOverload(object o) => "object";

        /// <summary>
        /// A static, get-only property always returning the same underlying CLR
        /// object, to test <c>--constant-properties</c> memoization: without
        /// memoization, each Lisp-level read re-crosses the C#/Lisp boundary and
        /// receives a freshly-boxed <c>#&lt;DOTNET ...&gt;</c> wrapper around the same
        /// CLR object (not <c>cl:eq</c> to a prior read); with memoization, the
        /// generated wrapper caches the first box and returns that same box on every
        /// subsequent read (<c>cl:eq</c> holds).
        /// </summary>
        public static object SharedSingleton { get; } = new object();

        /// <summary>
        /// v51 guard: a single out parameter on a static method with no clean
        /// overload of the same name, mirroring the ubiquitous Try* pattern
        /// (int.TryParse) -- exercises the plain-name (no /out suffix) case.
        /// </summary>
        public static bool TryGetThing(string key, out int value)
        {
            if (key == "found")
            {
                value = 42;
                return true;
            }
            value = 0;
            return false;
        }

        /// <summary>
        /// v51 guard: two out parameters, in C# declaration order, on an
        /// instance method.
        /// </summary>
        public bool TryGetPair(int input, out int doubled, out string label)
        {
            doubled = input * 2;
            label = input >= 0 ? "non-negative" : "negative";
            return input != 0;
        }

        /// <summary>
        /// v51 guard: a clean overload sharing a C# name with an out-only
        /// overload below.
        /// </summary>
        public string Locate(int id) => $"id:{id}";

        /// <summary>
        /// v51 guard: out-only overload sharing a name with the clean
        /// Locate(int) above -- must be named locate/out, not locate, so the
        /// two coexist without colliding. Deliberately takes a DIFFERENT
        /// number of non-out (in) arguments (2, vs. Locate(int)'s 1) than the
        /// clean overload: DotCL's dotnet:call-out resolves an overload by
        /// in-argument count alone (FindOutMethod, Runtime.DotNet.cs), not by
        /// argument type, so a same-in-arg-count clean/out-only pair sharing
        /// one name would be genuinely ambiguous at the call-out layer itself
        /// -- a real limitation of that primitive, not exercised by this
        /// fixture.
        /// </summary>
        public bool Locate(string key, int extra, out int id)
        {
            id = key.Length + extra;
            return key.Length > 0;
        }
    }

    /// <summary>
    /// A struct with a representative set of operator overloads (binary +, binary and
    /// unary -, equality, and bitwise-or -- the Version 47-renamed <c>bitwise-or!</c>
    /// operator), for the runtime exercise suite to call and assert both the results
    /// and that the shadowed CL symbols (<c>+</c>/<c>-</c>/<c>=</c>) still work correctly
    /// inside the generated package.
    /// </summary>
    public struct RuntimeOpStruct
    {
        /// <summary>The struct's sole payload, for assertions.</summary>
        public int Value;

        /// <summary>Constructs an instance with a given <see cref="Value"/>.</summary>
        public RuntimeOpStruct(int value) : this()
        {
            Value = value;
        }

        /// <summary>Binary addition.</summary>
        public static RuntimeOpStruct operator +(RuntimeOpStruct a, RuntimeOpStruct b)
            => new RuntimeOpStruct(a.Value + b.Value);

        /// <summary>Unary negation.</summary>
        public static RuntimeOpStruct operator -(RuntimeOpStruct a)
            => new RuntimeOpStruct(-a.Value);

        /// <summary>Bitwise OR (mangled to <c>bitwise-or!</c> since Version 47).</summary>
        public static RuntimeOpStruct operator |(RuntimeOpStruct a, RuntimeOpStruct b)
            => new RuntimeOpStruct(a.Value | b.Value);

        /// <summary>Value equality, paired with the required <see cref="operator !="/>.</summary>
        public static bool operator ==(RuntimeOpStruct a, RuntimeOpStruct b) => a.Value == b.Value;

        /// <summary>Required pairing for <see cref="operator =="/>.</summary>
        public static bool operator !=(RuntimeOpStruct a, RuntimeOpStruct b) => !(a == b);

        /// <inheritdoc/>
        public override bool Equals(object? obj) => obj is RuntimeOpStruct r && r.Value == Value;

        /// <inheritdoc/>
        public override int GetHashCode() => Value;
    }

    /// <summary>
    /// Two unrelated fixture classes sharing an instance method name, both intended to
    /// be generated with <c>--defgeneric</c>, so the runtime exercise suite can call the
    /// unified <c>csharp-generics</c> CLOS generic function on instances of each and
    /// assert dispatch reaches the correct per-class method body.
    /// </summary>
    public class GenericDispatchFixtureA
    {
        /// <summary>Returns a value identifying this class, for dispatch assertions.</summary>
        public string Kind() => "A";
    }

    /// <summary>See <see cref="GenericDispatchFixtureA"/>.</summary>
    public class GenericDispatchFixtureB
    {
        /// <summary>Returns a value identifying this class, for dispatch assertions.</summary>
        public string Kind() => "B";
    }

    /// <summary>
    /// An obsolete type (doc/plan-fable-detail-16.md, Half A) -- a bare [Obsolete], no
    /// message and not error-level.
    /// </summary>
    [Obsolete]
    public class ObsoleteType
    {
    }

    /// <summary>
    /// Fixtures for [Obsolete] (Half A) and [TupleElementNames] (Half B) metadata
    /// reflection, doc/plan-fable-detail-16.md.
    /// </summary>
    public class ObsoleteAndTupleFixtures
    {
        /// <summary>A bare [Obsolete] method -- no message, not error-level.</summary>
        [Obsolete]
        public void PlainObsolete()
        {
        }

        /// <summary>An [Obsolete] method with a message.</summary>
        [Obsolete("use PlainObsolete instead")]
        public void ObsoleteWithMessage()
        {
        }

        /// <summary>An [Obsolete] method with a message, marked error-level.</summary>
        [Obsolete("completely gone", true)]
        public void ObsoleteError()
        {
        }

        /// <summary>An [Obsolete] property.</summary>
        [Obsolete("use SomethingElse instead")]
        public int ObsoleteProperty { get; set; }

        /// <summary>An [Obsolete] field.</summary>
        [Obsolete]
        public int ObsoleteField;

        /// <summary>A method returning a simple (non-nested), fully-named tuple.</summary>
        public (int Count, string Name) GetStats() => (1, "one");

        /// <summary>A method taking a simple, fully-named tuple parameter.</summary>
        public void TakeStats((int Count, string Name) stats)
        {
        }

        /// <summary>A method returning a tuple where only one element is named.</summary>
        public (int Count, string) GetPartiallyNamed() => (1, "one");

        /// <summary>
        /// A method returning a NESTED named tuple -- doc/plan-fable-detail-16.md's Half
        /// B v1 explicitly emits no :tuple-element-return-names key here at all (the
        /// TransformNames count would not match the outer tuple's own arity).
        /// </summary>
        public (int Count, (string First, string Last) Name) GetNestedStats() => (1, ("a", "b"));
    }

    // A small, deliberately-isolated sub-namespace (doc/plan-fable-detail-12.md) for a
    // precise --all-classes/--all-classes-recursive smoke-test demonstration --
    // AssemblyToLispyTestTarget.SubSpace has exactly the two classes below, so
    // `--all-classes 'AssemblyToLispyTestTarget.SubSpace'` in the Makefile's smoke
    // invocation expands to a known, stable set (unlike the enclosing
    // AssemblyToLispyTestTarget namespace itself, which has many classes already
    // individually exercised elsewhere in the smoke test).
    namespace SubSpace
    {
        /// <summary>The first of SubSpace's two classes.</summary>
        public class SubSpaceClassOne
        {
            /// <summary>Returns a value identifying this class.</summary>
            public string Kind() => "One";
        }

        /// <summary>The second of SubSpace's two classes.</summary>
        public class SubSpaceClassTwo
        {
            /// <summary>Returns a value identifying this class.</summary>
            public string Kind() => "Two";
        }
    }
}
