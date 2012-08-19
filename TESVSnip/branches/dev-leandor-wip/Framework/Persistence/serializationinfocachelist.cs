namespace TESVSnip.Framework.Persistence
{
    using System;
    using System.Collections;
    using System.Collections.Generic;

    internal class SerializationInfoCacheList : List<SerializationInfoCache>
    {
        /// <overloads>
        /// Initializes a new instance of the
        ///   <see cref="SerializationInfoCacheList"/>
        ///   class.
        /// </overloads>
        /// <summary>
        /// Initializes a new instance of the <see cref="SerializationInfoCacheList"/> class. 
        ///   Initializes a new instance of the <see cref="SerializationInfoCacheList"/> class
        ///   that is empty and has the default initial capacity.
        /// </summary>
        /// <remarks>
        /// Please refer to <see cref="ArrayList"/> for details.
        /// </remarks>
        public SerializationInfoCacheList()
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="SerializationInfoCacheList"/> class
        ///   that is empty and has the specified initial capacity.
        /// </summary>
        /// <param name="capacity">
        /// The number of elements that the new <see cref="SerializationInfoCacheList"/> is initially capable of storing. 
        /// </param>
        /// <exception cref="ArgumentOutOfRangeException">
        /// <paramref name="capacity"/>
        ///   is less than zero.
        /// </exception>
        /// <remarks>
        /// Please refer to <see cref="ArrayList(int)"/> for details.
        /// </remarks>
        public SerializationInfoCacheList(int capacity)
            : base(capacity)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="SerializationInfoCacheList"/> class
        ///   that contains elements copied from the specified <see cref="SerializationInfoCache"/>
        ///   array and that has the same initial capacity as the number of elements copied.
        /// </summary>
        /// <param name="array">
        /// An <see cref="Array"/> of <see cref="SerializationInfoCache"/> elements that are copied to the new collection. 
        /// </param>
        /// <exception cref="ArgumentNullException">
        /// <paramref name="array"/>
        ///   is a null reference.
        /// </exception>
        /// <remarks>
        /// Please refer to <see cref="ArrayList(ICollection)"/> for details.
        /// </remarks>
        public SerializationInfoCacheList(IEnumerable<SerializationInfoCache> array)
            : base(array)
        {
        }
    }
}
