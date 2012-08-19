namespace TESVSnip.Framework.Persistence
{
    using System;

    /// <summary>
    /// Additional context states for persisting variables.
    /// </summary>
    /// <remarks>
    /// Defaults to saving in all contexts.
    /// </remarks>
    [Flags]
    public enum PersistContextStates
    {
        /// <summary>
        /// Persisted in all contexts.
        /// </summary>
        ExcludeNone = 0, 

        /// <summary>
        /// Value is excluded when serializing normally.
        /// </summary>
        ExcludeNormal = 0x1, 

        /// <summary>
        /// Value is excluded when serializing to clipboard.
        /// </summary>
        ExcludeClipboard = 0x2, 

        /// <summary>
        /// Excluded in all contexts.
        /// </summary>
        ExcludeAll = unchecked((int)0xFFFFFFFF), 
    }
}