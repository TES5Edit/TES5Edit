namespace TESVSnip.DotZLib
{
    /// <summary>
    /// Defines constants for the various flush types used with zlib.
    /// </summary>
    internal enum FlushTypes
    {
        None, 

        Partial, 

        Sync, 

        Full, 

        Finish, 

        Block
    }
}