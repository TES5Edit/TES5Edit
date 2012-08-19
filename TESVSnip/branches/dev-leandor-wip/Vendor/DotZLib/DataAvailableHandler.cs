namespace TESVSnip.DotZLib
{
    /// <summary>
    /// Represents the method that will be called from a codec when new data
    ///   are available.
    /// </summary>
    /// <paramref name="data">The byte array containing the processed data</paramref>
    /// <paramref name="startIndex">The index of the first processed byte in
    ///   <c>data</c>
    /// </paramref>
    /// <paramref name="count">The number of processed bytes available</paramref>
    /// <remarks>
    /// On return from this method, the data may be overwritten, so grab it while you can. 
    ///   You cannot assume that startIndex will be zero.
    /// </remarks>
    public delegate void DataAvailableHandler(byte[] data, int startIndex, int count);
}