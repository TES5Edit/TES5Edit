namespace TESVSnip.Framework.Persistence
{
    /// <summary>
    /// Interface that can be use for serialization callbacks even after IDeserialization.
    /// </summary>
    public interface IPostSerializationCallback
    {
        bool NeedCallback { get; }

        void OnPostSerialization();
    }
}