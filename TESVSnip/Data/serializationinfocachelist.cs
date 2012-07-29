using System;
using System.Collections.Generic;

namespace TESVSnip.Data.Persistance
{

    #region class SerializationInfoCache

    internal class SerializationInfoCache
    {
        public SerializationInfoCache(string Name, object Value, Type ObjectType)
        {
            this.Name = Name;
            this.Value = Value;
            this.ObjectType = ObjectType;
        }

        public string Name;
        public Type ObjectType;
        public object Value;
    }

    #endregion

    #region class SerializationInfoCacheList

    internal class SerializationInfoCacheList : List<SerializationInfoCache>
    {
        #region Public Constructors

        #region SerializationInfoCacheList()

        /// <overloads>
        /// Initializes a new instance of the <see cref="SerializationInfoCacheList"/> class.
        /// </overloads>
        /// <summary>
        /// Initializes a new instance of the <see cref="SerializationInfoCacheList"/> class
        /// that is empty and has the default initial capacity.
        /// </summary>
        /// <remarks>Please refer to <see cref="ArrayList()"/> for details.</remarks>
        public SerializationInfoCacheList()
        {
        }

        #endregion

        #region SerializationInfoCacheList(Int32)

        /// <summary>
        /// Initializes a new instance of the <see cref="SerializationInfoCacheList"/> class
        /// that is empty and has the specified initial capacity.
        /// </summary>
        /// <param name="capacity">The number of elements that the new
        /// <see cref="SerializationInfoCacheList"/> is initially capable of storing.</param>
        /// <exception cref="ArgumentOutOfRangeException">
        /// <paramref name="capacity"/> is less than zero.</exception>
        /// <remarks>Please refer to <see cref="ArrayList(Int32)"/> for details.</remarks>
        public SerializationInfoCacheList(int capacity) : base(capacity)
        {
        }

        #endregion

        #region SerializationInfoCacheList(SerializationInfoCache[])

        /// <summary>
        /// Initializes a new instance of the <see cref="SerializationInfoCacheList"/> class
        /// that contains elements copied from the specified <see cref="SerializationInfoCache"/>
        /// array and that has the same initial capacity as the number of elements copied.
        /// </summary>
        /// <param name="array">An <see cref="Array"/> of <see cref="SerializationInfoCache"/>
        /// elements that are copied to the new collection.</param>
        /// <exception cref="ArgumentNullException">
        /// <paramref name="array"/> is a null reference.</exception>
        /// <remarks>Please refer to <see cref="ArrayList(ICollection)"/> for details.</remarks>
        public SerializationInfoCacheList(IEnumerable<SerializationInfoCache> array) : base(array)
        {
        }

        #endregion

        #endregion
    }

    #endregion
}