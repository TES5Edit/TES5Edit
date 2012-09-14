namespace TESVSnip.Framework.Persistence
{
    using System.Runtime.Serialization;

    public class PersistSurrogate : ISerializationSurrogate
    {
        public void GetObjectData(object obj, SerializationInfo info, StreamingContext context)
        {
            PersistAssist.Serialize(obj, info, context);
        }

        public object SetObjectData(object obj, SerializationInfo info, StreamingContext context, ISurrogateSelector selector)
        {
            PersistAssist.Deserialize(obj, info, context);
            return obj;
        }
    }
}