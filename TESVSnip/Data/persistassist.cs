using System;
using System.Collections;
using System.Collections.Specialized;
using System.Reflection;
using System.Runtime.Serialization;
using TESVSnip.Data.Persistance;

namespace TESVSnip.Data
{

    #region enum PersistType

    /// <summary>
    /// PersistType indicates the available actions for a Persistable 
    /// </summary>
    [Flags]
    public enum PersistType
    {
        /// <summary>Indicates that this class may not be persisted.</summary>
        None = 0x0,

        /// <summary>
        /// Flag to indicate that the field or property has an assignable default.  
        /// For classes, it indicates that PersistAssist.Initialize may be caused to set default values.
        /// </summary>
        Initializable = 0x1,

        /// <summary>
        /// InitializeNew indicates that the object should be constructed from its default constructor.
        /// </summary>
        InitializeNew = 0x2 | Initializable,

        /// <summary>Indicates that only declared fields or properties should be persisted.</summary>
        DeclaredOnly = 0x4,

        /// <summary>Indicates that public fields or properties on this class should be persisted automatically.</summary>
        Public = 0x10,

        /// <summary>Indicates that non-public fields or properties on this class should be persisted automatically.</summary>
        NonPublic = 0x20,

        /// <summary>Indicates that instance fields or properties should be persisted automatically.</summary>
        Instance = 0x40,

        /// <summary>Indicates that static fields or properties on this class should be persisted automatically.</summary>
        Static = 0x80,

        /// <summary>Indicates that fields on this class should be persisted automatically.</summary>
        Fields = 0x100,

        /// <summary>Indicates that properties on this class should be persisted automatically.</summary>
        Properties = 0x200,

        /// <summary>Default persist type</summary>
        ClassDefault = DeclaredOnly,

        /// <summary>Default persist type (Public and Private Instance Fields)</summary>
        Default = Public | NonPublic | Fields | Instance,
    }

    #endregion enum PersistType

    #region enum PersistContextStates

    /// <summary>
    /// Additional context states for persisting variables.
    /// </summary>
    /// <remarks>Defaults to saving in all contexts. </remarks>
    [Flags]
    public enum PersistContextStates
    {
        /// <summary>Persisted in all contexts</summary>
        ExcludeNone = 0,

        /// <summary>Value is excluded when serializing normally.</summary>
        ExcludeNormal = 0x1,

        /// <summary>Value is excluded when serializing to clipboard.</summary>
        ExcludeClipboard = 0x2,

        /// <summary>Excluded in all contexts</summary>
        ExcludeAll = unchecked((int) 0xFFFFFFFF),
    }

    #endregion enum PersistContextStates

    #region class PersistContext

    /// <summary>
    /// 
    /// </summary>
    public class PersistContext : IDisposable
    {
        private object _root;
        private readonly PersistContextStates _context;
        private readonly int _savecount;
        private Hashtable _infoTypeCache;
        private ArrayList _postSerializeCallbacks;

        public PersistContext(object root, PersistContextStates context, int SaveCount)
        {
            _root = root;
            _context = context;
            _savecount = SaveCount;
            _infoTypeCache = new Hashtable();
        }

        public PersistContext(object root, PersistContextStates context)
        {
            _root = root;
            _context = context;
            _savecount = 0;
            _infoTypeCache = new Hashtable();
        }

        ~PersistContext()
        {
            Dispose(false);
        }

        public object Root
        {
            get { return _root; }
        }

        public PersistContextStates Context
        {
            get { return _context; }
        }

        public int SaveCount
        {
            get { return _savecount; }
        }

        public bool StoreCacheInfo(object obj, SerializationInfo info)
        {
            Type t = obj.GetType();
            var objmap = _infoTypeCache[t] as Hashtable;
            if (objmap == null)
            {
                objmap = new Hashtable();
                _infoTypeCache[t] = objmap;
            }
            var data = objmap[obj] as SerializationInfoCacheList;
            if (data == null)
            {
                data = new SerializationInfoCacheList(info.MemberCount);
                objmap[obj] = data;
            }

            SerializationInfoEnumerator itr = info.GetEnumerator();
            while (itr.MoveNext())
                data.Add(new SerializationInfoCache(itr.Name, itr.Value, itr.ObjectType));

            return true;
        }

        public bool RetrieveCacheInfo(object obj, SerializationInfo info)
        {
            Type t = obj.GetType();
            var objmap = _infoTypeCache[t] as Hashtable;
            if (objmap != null)
            {
                var data = objmap[obj] as SerializationInfoCacheList;
                if (data != null)
                {
                    IEnumerator itr = ((IEnumerable) data).GetEnumerator();
                    while (itr.MoveNext())
                    {
                        var cache = itr.Current as SerializationInfoCache;
                        if (cache != null)
                            info.AddValue(cache.Name, cache.Value, cache.ObjectType);
                    }
                    return true;
                }
            }
            return false;
        }

        public void AddPostSerializationCallback(IPostSerializationCallback callback)
        {
            if (callback == null) return;
            if (callback.NeedCallback == false) return;

            if (_postSerializeCallbacks == null)
                _postSerializeCallbacks = new ArrayList();
            _postSerializeCallbacks.Add(callback);
        }

        public void RaisePostSerializationCallbacks()
        {
            if (_postSerializeCallbacks != null)
            {
                foreach (IPostSerializationCallback callback in _postSerializeCallbacks)
                    callback.OnPostSerialization();
                _postSerializeCallbacks.Clear();
                _postSerializeCallbacks = null;
            }
        }

        #region IDisposable Members

        public void Dispose()
        {
            Dispose(true);
        }

        private void Dispose(bool disposing)
        {
            _root = null;
            if (Disposed != null)
                Disposed(this, EventArgs.Empty);
            if (_infoTypeCache != null)
            {
                _infoTypeCache.Clear();
                _infoTypeCache = null;
            }
            if (_postSerializeCallbacks != null)
            {
                _postSerializeCallbacks.Clear();
                _postSerializeCallbacks = null;
            }
            if (disposing) GC.SuppressFinalize(this);
        }

        public event EventHandler Disposed;

        #endregion
    }

    #endregion class PersistContext

    #region class PersistableAttribute

    /// <summary>
    /// The Persistable attribute is similar to Serializable as it tags classes, fields or properties 
    /// as persistable.  It is used in conjunction with .
    /// </summary>
    /// <remarks>
    /// This class is used with PersistAssist for semi-automated persistance.  
    /// Its intended to minimize boiler plate serialization.
    /// </remarks>
    [AttributeUsage(
        AttributeTargets.Struct | AttributeTargets.Class | AttributeTargets.Field | AttributeTargets.Property)]
    public sealed class PersistableAttribute : Attribute
    {
        private PersistType _type = PersistType.Default;
        private PersistContextStates _context = PersistContextStates.ExcludeNone;

        /// <summary>
        /// Gets or sets the intended persistance defaults
        /// </summary>
        public PersistType Flags
        {
            get { return _type; }
            set { _type = value; }
        }

        /// <summary>
        /// Gets or sets the version of a class, field or property.
        /// </summary>
        /// <remarks>
        /// If a higher version is encountered then the current version then value is not set.
        /// If the value has a default that is used to initialize the field or property if the value cannot be set
        /// (this is independent of the Initializable flag usage).
        /// </remarks>
        public int Version { get; set; }

        /// <summary>
        /// Gets or sets the default value of a field or property.
        /// </summary>
        /// <remarks>
        /// If deserialization fails due to version this value will be used if available or if Intializable is set.
        /// If Intializable is set then the default value can be used to intialize a value even if null.
        /// </remarks>
        public object Default { get; set; }

        /// <summary>
        /// Gets or sets the Context states when this values is persisted.
        /// </summary>
        public PersistContextStates Context
        {
            get { return _context; }
            set { _context = value; }
        }
    }

//	/// <summary>
//	/// The NonPersistable attribute is similar to NonSerializable as it tags fields or properties 
//	/// as not persistable.  It is used in conjunction with the Peristable attribute when applied to a class.
//	/// </summary>
//	/// <remarks>This class is used with PersistAssist for excluding certain fields from being saved.</remarks>
//	[AttributeUsage(AttributeTargets.Field|AttributeTargets.Property)]
//	public sealed class NonPersistable : System.Attribute
//	{
//	}

    #endregion class PersistableAttribute

    #region class PersistAssist

    /// <summary>
    /// The PersistAssist class contains serialization helper classes.
    /// 
    /// </summary>
    public class PersistAssist
    {
        private static readonly Hashtable _PersistableAttributeOnTypeCache = new Hashtable();

        /// <exclude/>
        private PersistAssist()
        {
        }

        /// <summary>
        /// Initialize a class based on PersistableAttribute settings.
        /// </summary>
        /// <param name="obj">Class instance that is to be initialized.</param>
        public static void Initialize(object obj)
        {
            Initialize(obj, false);
        }

        /// <summary>
        /// Initialize a class based on PersistableAttribute settings.
        /// </summary>
        /// <param name="obj">Class instance that is to be initialized.</param>
        /// <param name="force">Whether to force initialization regardless of the PersistableAttribute</param>
        public static void Initialize(object obj, bool force)
        {
            Type type = obj.GetType();
            PersistableAttribute pattr = GetPersistableAttribute(type);
            if (pattr == null || pattr.Flags == PersistType.None) return;

            if ((pattr.Flags & PersistType.DeclaredOnly | PersistType.Properties) != 0)
            {
                var indicies = new object[] {};
                foreach (PropertyInfo pi in GetProperties(type, pattr.Flags))
                    SetDefaultValue(obj, pi, false);
            }
            if ((pattr.Flags & PersistType.DeclaredOnly | PersistType.Fields) != 0)
            {
                foreach (FieldInfo fi in GetFields(type, pattr.Flags))
                    SetDefaultValue(obj, fi, false);
            }
        }

        private static PersistableAttribute GetPersistableAttribute(Type type)
        {
            if (_PersistableAttributeOnTypeCache.ContainsKey(type))
                return _PersistableAttributeOnTypeCache[type] as PersistableAttribute;
            object[] attrs = type.GetCustomAttributes(typeof (PersistableAttribute), false);
            if (attrs.Length == 0)
            {
                _PersistableAttributeOnTypeCache[type] = null;
                return null;
            }
            _PersistableAttributeOnTypeCache[type] = attrs[0];
            return attrs[0] as PersistableAttribute;
        }

        /// <summary>
        /// Set the default value for a property based on a PersistableAttribute
        /// </summary>
        /// <param name="obj">Class instance that is to be initialized.</param>
        /// <param name="pi">PropertyInfo that describes the property to set.</param>
        /// <param name="force">Whether to force initialization regardless of the PersistableAttribute</param>
        private static void SetDefaultValue(object obj, PropertyInfo pi, bool force)
        {
            try
            {
                object value = null;
                object[] attrs = pi.GetCustomAttributes(typeof (PersistableAttribute), false);
                if (attrs.Length != 0)
                {
                    var pattr = attrs[0] as PersistableAttribute;
                    if (force || (pattr.Flags & PersistType.Initializable) == 0) return;
                    if ((pattr.Flags & PersistType.InitializeNew) == PersistType.InitializeNew)
                    {
                        ConstructorInfo ci = pi.PropertyType.GetConstructor(Type.EmptyTypes);
                        value = ci.Invoke(null);
                    }
                    else
                    {
                        value = pattr.Default;
                    }
                }
                else if (!force)
                {
                    return; // exit if it does not have a persistableattribute and is not being forced.
                }
                if (value == null && pi.PropertyType.IsValueType)
                    value = Activator.CreateInstance(pi.PropertyType);

                var indicies = new object[] {};
                pi.SetValue(obj, value, indicies);
            }
            catch
            {
            }
        }

        /// <summary>
        /// Set the default value for a property based on a PersistableAttribute
        /// </summary>
        /// <param name="obj">Class instance that is to be initialized.</param>
        /// <param name="fi">FieldInfo that describes the field to set.</param>
        /// <param name="force">Whether to force initialization regardless of the PersistableAttribute</param>
        private static void SetDefaultValue(object obj, FieldInfo fi, bool force)
        {
            try
            {
                object value = null;
                object[] attrs = fi.GetCustomAttributes(typeof (PersistableAttribute), false);
                if (attrs.Length != 0)
                {
                    var pattr = attrs[0] as PersistableAttribute;
                    if (force || (pattr.Flags & PersistType.Initializable) == 0) return;
                    if ((pattr.Flags & PersistType.InitializeNew) == PersistType.InitializeNew)
                    {
                        ConstructorInfo ci = fi.FieldType.GetConstructor(Type.EmptyTypes);
                        value = ci.Invoke(null);
                    }
                    else
                    {
                        value = pattr.Default;
                    }
                }
                else if (!force)
                {
                    return; // exit if it does not have a persistableattribute and is not being forced.
                }
                if (value == null && fi.FieldType.IsValueType)
                    value = Activator.CreateInstance(fi.FieldType);

                fi.SetValue(obj, value);
            }
            catch
            {
            }
        }

        /// <summary>
        /// Return Properties which match the PeristType search criteria.
        /// </summary>
        /// <param name="type"></param>
        /// <param name="searchType"></param>
        /// <returns></returns>
        private static PropertyInfo[] GetProperties(Type type, PersistType searchType)
        {
            // remove flags not meaningful for comparisons
            PersistType modSearchType = searchType &
                                        ~(PersistType.DeclaredOnly | PersistType.Properties | PersistType.Fields);

            var props = new ArrayList();
            BindingFlags bi = BindingFlags.SetProperty;
            if ((searchType & PersistType.DeclaredOnly) != 0) // Only get declared properties
            {
                bi |= BindingFlags.Public | BindingFlags.NonPublic
                      | BindingFlags.Static | BindingFlags.Instance
                    ;

                foreach (PropertyInfo pi in type.GetProperties(bi))
                {
                    object[] attrs = pi.GetCustomAttributes(typeof (PersistableAttribute), false);
                    if (attrs.Length == 0) continue;

                    var pattr = attrs[0] as PersistableAttribute;
                    if (pattr.Flags == PersistType.None) continue;

                    if (modSearchType == PersistType.None || ((pattr.Flags & modSearchType) == modSearchType))
                        props.Add(pi);
                }
            }
            else
            {
                if ((searchType & PersistType.Public) != 0) bi |= BindingFlags.Public;
                if ((searchType & PersistType.NonPublic) != 0) bi |= BindingFlags.NonPublic;
                if ((searchType & PersistType.Static) != 0) bi |= BindingFlags.Static;
                if ((searchType & PersistType.Instance) != 0) bi |= BindingFlags.Instance;

                foreach (PropertyInfo pi in type.GetProperties(bi))
                {
                    object[] attrs = pi.GetCustomAttributes(typeof (PersistableAttribute), false);
                    if (attrs.Length > 0)
                    {
                        var pattr = attrs[0] as PersistableAttribute;
                        if (pattr.Flags == PersistType.None)
                            continue;
                    }
                    props.Add(pi);
                }
            }
            return (PropertyInfo[]) props.ToArray(typeof (PropertyInfo));
        }

        /// <summary>
        /// Return Properties which match the PeristType search criteria.
        /// </summary>
        /// <param name="type"></param>
        /// <param name="searchType"></param>
        /// <returns></returns>
        private static FieldInfo[] GetFields(Type type, PersistType searchType)
        {
            // remove flags not meaningful for comparisons
            PersistType modSearchType = searchType &
                                        ~(PersistType.DeclaredOnly | PersistType.Fields | PersistType.Fields);

            var fields = new ArrayList();
            BindingFlags bi = BindingFlags.SetField;
            if ((searchType & PersistType.DeclaredOnly) != 0) // Only get declared Fields
            {
                bi |= BindingFlags.Public | BindingFlags.NonPublic
                      | BindingFlags.Static | BindingFlags.Instance
                    ;

                while (type != typeof (object))
                {
                    foreach (FieldInfo fi in type.GetFields(bi))
                    {
                        object[] attrs = fi.GetCustomAttributes(typeof (PersistableAttribute), false);
                        if (attrs.Length == 0) continue;

                        var pattr = attrs[0] as PersistableAttribute;
                        if (pattr.Flags == PersistType.None) continue;

                        if (modSearchType == PersistType.None || ((pattr.Flags & modSearchType) == modSearchType))
                        {
                            bool found = false;
                            foreach (FieldInfo fi2 in fields)
                            {
                                if (fi2.Name == fi.Name)
                                {
                                    found = true;
                                    break;
                                }
                            }
                            if (!found) fields.Add(fi);
                        }
                    }
                    type = type.BaseType;
                }
            }
            else
            {
                if ((searchType & PersistType.Public) != 0) bi |= BindingFlags.Public;
                if ((searchType & PersistType.NonPublic) != 0) bi |= BindingFlags.NonPublic;
                if ((searchType & PersistType.Static) != 0) bi |= BindingFlags.Static;
                if ((searchType & PersistType.Instance) != 0) bi |= BindingFlags.Instance;

                while (type != typeof (object))
                {
                    foreach (FieldInfo fi in type.GetFields(bi))
                    {
                        object[] attrs = fi.GetCustomAttributes(typeof (PersistableAttribute), false);
                        if (attrs.Length > 0)
                        {
                            var pattr = attrs[0] as PersistableAttribute;
                            if (pattr.Flags == PersistType.None)
                                continue;
                        }
                        bool found = false;
                        foreach (FieldInfo fi2 in fields)
                        {
                            if (fi2.Name == fi.Name)
                            {
                                found = true;
                                break;
                            }
                        }
                        if (!found) fields.Add(fi);
                    }
                    type = type.BaseType;
                }
            }
            return (FieldInfo[]) fields.ToArray(typeof (FieldInfo));
        }


        /// <summary>
        /// Serializes a property on a object using PersistableAttribute attributes
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="pi"></param>
        /// <param name="info"></param>
        /// <param name="context"></param>
        private static void SerializeValue(object obj, PropertyInfo pi, SerializationInfo info, StreamingContext context)
        {
            try
            {
                PersistContext persistContext = (context.Context != null && context.Context is PersistContext)
                                                    ? context.Context as PersistContext
                                                    : null;
                PersistContextStates excludeContext = (persistContext != null)
                                                          ? persistContext.Context
                                                          : PersistContextStates.ExcludeNormal;

                var indicies = new object[] {};
                object[] attrs = pi.GetCustomAttributes(typeof (PersistableAttribute), false);
                if (attrs.Length != 0)
                {
                    var pattr = attrs[0] as PersistableAttribute;
                    if (pattr.Flags == PersistType.None)
                        return;
                    if ((pattr.Context & excludeContext) != 0) // exclude context matches
                        return;
                    object value = pi.GetValue(obj, indicies);
                    try
                    {
                        info.AddValue(pi.Name, value);
                        if (pattr.Version != 0)
                            info.AddValue(string.Concat(pi.Name, ".Version"), pattr.Version);
                    }
                    catch (SerializationException)
                    {
                        // discard serialization exceptions as the same member may be added twice
                    }
                }
                else
                {
                    try
                    {
                        info.AddValue(pi.Name, pi.GetValue(obj, indicies));
                    }
                    catch (SerializationException)
                    {
                        // discard serialization exceptions as the same member may be added twice
                    }
                }
            }
            catch
            {
            }
        }

        /// <summary>
        /// Serializes a field on a object using PersistableAttribute attributes
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="fi"></param>
        /// <param name="info"></param>
        /// <param name="context"></param>
        private static void SerializeValue(object obj, FieldInfo fi, SerializationInfo info, StreamingContext context)
        {
            try
            {
                PersistContext persistContext = (context.Context != null && context.Context is PersistContext)
                                                    ? context.Context as PersistContext
                                                    : null;
                PersistContextStates excludeContext = (persistContext != null)
                                                          ? persistContext.Context
                                                          : PersistContextStates.ExcludeNormal;

                object[] attrs = fi.GetCustomAttributes(typeof (PersistableAttribute), false);
                if (attrs.Length != 0)
                {
                    var pattr = attrs[0] as PersistableAttribute;
                    if (pattr.Flags == PersistType.None)
                        return;
                    if ((pattr.Context & excludeContext) != 0) // exclude context matches
                        return;
                    var indicies = new object[] {};
                    object value = fi.GetValue(obj);
                    try
                    {
                        info.AddValue(fi.Name, value);
                        if (pattr.Version != 0)
                            info.AddValue(string.Concat(fi.Name, ".Version"), pattr.Version);
                    }
                    catch (SerializationException)
                    {
                        // discard serialization exceptions as the same member may be added twice
                    }
                }
                else
                {
                    try
                    {
                        info.AddValue(fi.Name, fi.GetValue(obj));
                    }
                    catch (SerializationException)
                    {
                        // discard serialization exceptions as the same member may be added twice
                    }
                }
            }
            catch
            {
            }
        }

        /// <summary>
        /// Serializes a field on a object using PersistableAttribute attributes
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="fi"></param>
        /// <param name="info"></param>
        /// <param name="context"></param>
        public static void SerializeValue(string name, object obj, SerializationInfo info, StreamingContext context)
        {
            try
            {
                if (obj != null)
                {
                    try
                    {
                        info.AddValue(name, obj);
                    }
                    catch (SerializationException)
                    {
                        // discard serialization exceptions as the same member may be added twice
                    }
                }
            }
            catch
            {
            }
        }

        /// <summary>
        /// Deserializes a property on a object using PersistableAttribute attributes
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="pi"></param>
        /// <param name="info"></param>
        /// <param name="context"></param>
        private static void DeserializeValue(object obj, PropertyInfo pi, SerializationInfo info,
                                             StreamingContext context)
        {
            try
            {
                PersistContext persistContext = (context.Context != null && context.Context is PersistContext)
                                                    ? context.Context as PersistContext
                                                    : null;
                PersistContextStates excludeContext = (persistContext != null)
                                                          ? persistContext.Context
                                                          : PersistContextStates.ExcludeNormal;

                int curVersion = 0;
                bool canInit = false;
                object[] attrs = pi.GetCustomAttributes(typeof (PersistableAttribute), false);
                if (attrs.Length != 0)
                {
                    var pattr = attrs[0] as PersistableAttribute;
                    if (pattr.Flags == PersistType.None)
                        return;
                    if ((pattr.Context & excludeContext) != 0) // exclude context matches
                        return;
                    curVersion = pattr.Version;
                    canInit = ((pattr.Flags & PersistType.Initializable) != 0);
                }

                int version = 0;
                string name = pi.Name;
                string ver = string.Concat(pi.Name, ".Version");
                object value = null;
                Type type = null;

                // Use enum to avoid exceptions
                SerializationInfoEnumerator siEnum = info.GetEnumerator();
                while (siEnum.MoveNext())
                {
                    if (siEnum.Name == ver)
                        version = (int) siEnum.Value;
                    if (siEnum.Name == name)
                    {
                        value = siEnum.Value;
                        type = siEnum.ObjectType;
                    }
                }
                if ((type == null) || ((version > 0) && (curVersion < version)))
                {
                    if (canInit) SetDefaultValue(obj, pi, false);
                    return;
                }
                var indicies = new object[] {};
                pi.SetValue(obj, value, indicies);
            }
            catch
            {
            }
        }

        /// <summary>
        /// Deserializes a field on a object using PersistableAttribute attributes
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="fi"></param>
        /// <param name="info"></param>
        /// <param name="context"></param>
        private static void DeserializeValue(object obj, FieldInfo fi, SerializationInfo info, StreamingContext context)
        {
            try
            {
                PersistContext persistContext = (context.Context != null && context.Context is PersistContext)
                                                    ? context.Context as PersistContext
                                                    : null;
                PersistContextStates excludeContext = (persistContext != null)
                                                          ? persistContext.Context
                                                          : PersistContextStates.ExcludeNormal;

                int curVersion = 0;
                bool canInit = false;
                object[] attrs = fi.GetCustomAttributes(typeof (PersistableAttribute), false);
                if (attrs.Length != 0)
                {
                    var pattr = attrs[0] as PersistableAttribute;
                    if (pattr.Flags == PersistType.None)
                        return;
                    if ((pattr.Context & excludeContext) != 0) // exclude context matches
                        return;
                    curVersion = pattr.Version;
                    canInit = ((pattr.Flags & PersistType.Initializable) != 0);
                }

                int version = 0;
                string name = fi.Name;
                string ver = string.Concat(fi.Name, ".Version");
                object value = null;
                Type type = null;

                // Use enum to avoid exceptions
                SerializationInfoEnumerator siEnum = info.GetEnumerator();
                while (siEnum.MoveNext())
                {
                    if (siEnum.Name == ver)
                        version = (int) siEnum.Value;
                    if (siEnum.Name == name)
                    {
                        value = siEnum.Value;
                        type = siEnum.ObjectType;
                    }
                }
                if ((type == null) || ((version > 0) && (curVersion < version)))
                {
                    if (canInit) SetDefaultValue(obj, fi, false);
                    return;
                }
                fi.SetValue(obj, value);
            }
            catch
            {
            }
        }

        /// <summary>
        /// Deserializes a field on a object using PersistableAttribute attributes
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="fi"></param>
        /// <param name="info"></param>
        /// <param name="context"></param>
        public static object DeserializeValue(string name, SerializationInfo info, StreamingContext context)
        {
            try
            {
                object value = null;
                Type type = null;

                // Use enum to avoid exceptions
                SerializationInfoEnumerator siEnum = info.GetEnumerator();
                while (siEnum.MoveNext())
                {
                    if (siEnum.Name == name)
                    {
                        value = siEnum.Value;
                        type = siEnum.ObjectType;
                    }
                }
                return value;
            }
            catch
            {
            }
            return null;
        }

        /// <summary>
        /// Serializes an object using PersistableAttribute attributes
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="info"></param>
        /// <param name="context"></param>
        public static void Serialize(object obj, SerializationInfo info, StreamingContext context)
        {
            PersistContext persistContext = (context.Context != null && context.Context is PersistContext)
                                                ? context.Context as PersistContext
                                                : null;
            if (persistContext != null)
            {
                if (persistContext.RetrieveCacheInfo(obj, info))
                    return;
            }

            Type type = obj.GetType();
            PersistableAttribute pattr = GetPersistableAttribute(type);
            PersistType persistType = (pattr == null) ? PersistType.ClassDefault : pattr.Flags;

            if (pattr != null && pattr.Version != 0)
                info.AddValue("PersistVersion", pattr.Version);

            foreach (PropertyInfo pi in GetProperties(type, persistType))
                SerializeValue(obj, pi, info, context);

            foreach (FieldInfo fi in GetFields(type, persistType))
                SerializeValue(obj, fi, info, context);

            if (persistContext != null)
            {
                persistContext.StoreCacheInfo(obj, info);
            }
        }

        /// <summary>
        /// Deserializes an object using PersistableAttribute attributes
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="info"></param>
        /// <param name="context"></param>
        public static void Deserialize(object obj, SerializationInfo info, StreamingContext context)
        {
            Type type = obj.GetType();
            PersistableAttribute pattr = GetPersistableAttribute(type);
            PersistType persistType = (pattr == null) ? PersistType.ClassDefault : pattr.Flags;

            foreach (PropertyInfo pi in GetProperties(type, persistType))
                DeserializeValue(obj, pi, info, context);

            foreach (FieldInfo fi in GetFields(type, persistType))
                DeserializeValue(obj, fi, info, context);

            #region Queue PostSerialization Callbacks

            if (typeof (IPostSerializationCallback).IsInstanceOfType(obj))
            {
                PersistContext persistContext = (context.Context != null && context.Context is PersistContext)
                                                    ? context.Context as PersistContext
                                                    : null;
                if (persistContext != null)
                    persistContext.AddPostSerializationCallback((IPostSerializationCallback) obj);
            }

            #endregion
        }

        /// <summary>
        /// Get saved version of object
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="info"></param>
        /// <param name="context"></param>
        /// <returns></returns>
        public static int GetPersistVersion(object obj, SerializationInfo info, StreamingContext context)
        {
            // Use enum to avoid exceptions
            SerializationInfoEnumerator siEnum = info.GetEnumerator();
            while (siEnum.MoveNext())
            {
                if (siEnum.Name == "PersistVersion")
                    return (int) siEnum.Value;
            }
            return 0;
        }


        /// <summary>
        /// Get a single object which represents the persistable members of the given object.
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        /// <remarks>Basically for serialize members without needing ISerialize interface.</remarks>
        public static object GetSerializationSurrogate(object obj)
        {
            Type type = obj.GetType();
            PersistableAttribute pattr = GetPersistableAttribute(type);
            PersistType persistType = (pattr == null) ? PersistType.ClassDefault : pattr.Flags;
            return GetSerializationSurrogate(obj, persistType);
        }

        /// <summary>
        /// Get a single object which represents the persistable members of the given object.
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="persistType"></param>
        /// <returns></returns>
        public static object GetSerializationSurrogate(object obj, PersistType persistType)
        {
            Type type = obj.GetType();
            IDictionary dict = new ListDictionary();
            foreach (PropertyInfo pi in GetProperties(type, persistType))
                dict[pi.Name] = pi.GetValue(obj, null);

            foreach (FieldInfo fi in GetFields(type, persistType))
                dict[fi.Name] = fi.GetValue(obj);

            return dict;
        }


        /// <summary>
        /// Get a single object which represents the persistable members of the given object.
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        /// <remarks>Basically for serialize members without needing ISerialize interface.</remarks>
        public static void DeserializationFromSurrogate(object obj, object values)
        {
            if (obj == null) throw new ArgumentNullException("obj");

            var dict = values as ListDictionary;
            if (dict == null) throw new ArgumentException("Values should be a Dictionary", "values");

            Type type = obj.GetType();
            PersistableAttribute pattr = GetPersistableAttribute(type);
            if (pattr == null || pattr.Flags == PersistType.None) return;

            DeserializationFromSurrogate(obj, values, pattr.Flags);
        }

        /// <summary>
        /// Get a single object which represents the persistable members of the given object.
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        /// <remarks>Basically for serialize members without needing ISerialize interface.</remarks>
        public static void DeserializationFromSurrogate(object obj, object values, PersistType persistType)
        {
            if (obj == null) throw new ArgumentNullException("obj");

            var dict = values as ListDictionary;
            if (dict == null) throw new ArgumentException("Values should be a Dictionary", "values");

            Type type = obj.GetType();

            foreach (PropertyInfo pi in GetProperties(type, persistType))
            {
                object value = null;
                if (dict.Contains(pi.Name))
                    value = dict[pi.Name];

                if (value == null)
                    SetDefaultValue(obj, pi, false);
                else
                    pi.SetValue(obj, value, null);
            }
            foreach (FieldInfo fi in GetFields(type, persistType))
            {
                object value = null;
                if (dict.Contains(fi.Name))
                    value = dict[fi.Name];

                if (value == null)
                    SetDefaultValue(obj, fi, false);
                else
                    fi.SetValue(obj, value);
            }
        }
    }

    #endregion class PersistAssist

    #region class PersistSurrogate

    public class PersistSurrogate : ISerializationSurrogate
    {
        #region ISerializationSurrogate Members

        public void GetObjectData(object obj, SerializationInfo info, StreamingContext context)
        {
            PersistAssist.Serialize(obj, info, context);
        }

        public object SetObjectData(object obj, SerializationInfo info, StreamingContext context,
                                    ISurrogateSelector selector)
        {
            PersistAssist.Deserialize(obj, info, context);
            return obj;
        }

        #endregion
    }

    #endregion class PersistSurrogate

    #region interface IPostSerializationCallback

    /// <summary>
    /// Interface that can be use for serialization callbacks even after IDeserialization
    /// </summary>
    public interface IPostSerializationCallback
    {
        bool NeedCallback { get; }
        void OnPostSerialization();
    }

    #endregion

    #region class PersistObject

    /// <summary>
    /// 
    /// </summary>
    [Persistable(Flags = PersistType.DeclaredOnly), Serializable]
    public class PersistObject : Object, ISerializable
    {
        /// <summary>
        /// 
        /// </summary>
        public PersistObject()
        {
        }

        /// <summary>
        ///	Deserialization constructor
        /// </summary>
        protected PersistObject(SerializationInfo info, StreamingContext context)
        {
            PersistAssist.Deserialize(this, info, context);
        }

        #region ISerializable Members

        void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
        {
            PersistAssist.Serialize(this, info, context);
        }

        #endregion
    }

    #endregion
}