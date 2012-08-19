namespace TESVSnip.Framework.Persistence
{
    using System;

    internal class SerializationInfoCache
    {
        public string Name;

        public Type ObjectType;

        public object Value;

        public SerializationInfoCache(string Name, object Value, Type ObjectType)
        {
            this.Name = Name;
            this.Value = Value;
            this.ObjectType = ObjectType;
        }
    }
}