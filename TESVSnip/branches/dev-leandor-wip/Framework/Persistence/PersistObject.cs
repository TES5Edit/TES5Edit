namespace TESVSnip.Framework.Persistence
{
    using System;
    using System.Runtime.Serialization;

    /// <summary>
    /// </summary>
    [Persistable(Flags = PersistType.DeclaredOnly)]
    [Serializable]
    public class PersistObject : Object, ISerializable
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="PersistObject"/> class. 
        /// </summary>
        public PersistObject()
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="PersistObject"/> class. 
        /// Deserialization constructor.
        /// </summary>
        /// <param name="info">
        /// The info.
        /// </param>
        /// <param name="context">
        /// The context.
        /// </param>
        protected PersistObject(SerializationInfo info, StreamingContext context)
        {
            PersistAssist.Deserialize(this, info, context);
        }

        void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
        {
            PersistAssist.Serialize(this, info, context);
        }
    }
}