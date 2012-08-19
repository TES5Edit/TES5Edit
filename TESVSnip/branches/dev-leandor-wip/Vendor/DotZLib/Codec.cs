namespace TESVSnip.DotZLib
{
    /// <summary>
    /// Declares methods and events for implementing compressors/decompressors.
    /// </summary>
    public interface Codec
    {
        /// <summary>
        /// Occurs when more processed data are available.
        /// </summary>
        event DataAvailableHandler DataAvailable;

        /// <summary>
        /// Gets the checksum of the data that has been added so far.
        /// </summary>
        /// <value>
        /// The checksum.
        /// </value>
        uint Checksum { get; }

        /// <summary>
        /// Adds more data to the codec to be processed.
        /// </summary>
        /// <param name="data">
        /// Byte array containing the data to be added to the codec. 
        /// </param>
        /// <remarks>
        /// Adding data may, or may not, raise the <c>DataAvailable</c> event.
        /// </remarks>
        void Add(byte[] data);

        /// <summary>
        /// Adds more data to the codec to be processed.
        /// </summary>
        /// <param name="data">
        /// Byte array containing the data to be added to the codec. 
        /// </param>
        /// <param name="offset">
        /// The index of the first byte to add from <c>data</c>. 
        /// </param>
        /// <param name="count">
        /// The number of bytes to add. 
        /// </param>
        /// <remarks>
        /// Adding data may, or may not, raise the <c>DataAvailable</c> event.
        /// </remarks>
        void Add(byte[] data, int offset, int count);

        /// <summary>
        /// Finishes up any pending data that needs to be processed and handled.
        /// </summary>
        void Finish();
    }
}