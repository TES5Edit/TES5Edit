namespace TESVSnip.DotZLib
{
    /// <summary>
    /// Defines constants for the available compression levels in zlib.
    /// </summary>
    public enum CompressLevel : int
    {
        /// <summary>
        /// The default compression level with a reasonable compromise between compression and speed.
        /// </summary>
        Default = -1, 

        /// <summary>
        /// No compression at all. The data are passed straight through.
        /// </summary>
        None = 0, 

        /// <summary>
        /// The maximum compression rate available.
        /// </summary>
        Best = 9, 

        /// <summary>
        /// The fastest available compression level.
        /// </summary>
        Fastest = 1
    }
}