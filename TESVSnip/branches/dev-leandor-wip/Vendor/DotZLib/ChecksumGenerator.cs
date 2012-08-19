namespace TESVSnip.DotZLib
{
    using System;
    using System.Text;

    /// <summary>
    /// Declares methods and properties that enables a running checksum to be calculated.
    /// </summary>
    public interface ChecksumGenerator
    {
        /// <summary>
        /// Gets the current value of the checksum.
        /// </summary>
        /// <value>
        /// The value.
        /// </value>
        uint Value { get; }

        /// <summary>
        /// Clears the current checksum to 0.
        /// </summary>
        void Reset();

        /// <summary>
        /// Updates the current checksum with an array of bytes.
        /// </summary>
        /// <param name="data">
        /// The data to update the checksum with. 
        /// </param>
        void Update(byte[] data);

        /// <summary>
        /// Updates the current checksum with part of an array of bytes.
        /// </summary>
        /// <param name="data">
        /// The data to update the checksum with. 
        /// </param>
        /// <param name="offset">
        /// Where in <c>data</c> to start updating. 
        /// </param>
        /// <param name="count">
        /// The number of bytes from <c>data</c> to use. 
        /// </param>
        /// <exception cref="ArgumentException">
        /// The sum of offset and count is larger than the length of
        ///   <c>data</c>.
        /// </exception>
        /// <exception cref="ArgumentNullException">
        /// <c>data</c>
        ///   is a null reference.
        /// </exception>
        /// <exception cref="ArgumentOutOfRangeException">
        /// Offset or count is negative.
        /// </exception>
        void Update(byte[] data, int offset, int count);

        /// <summary>
        /// Updates the current checksum with the data from a string.
        /// </summary>
        /// <param name="data">
        /// The string to update the checksum with. 
        /// </param>
        /// <remarks>
        /// The characters in the string are converted by the UTF-8 encoding.
        /// </remarks>
        void Update(string data);

        /// <summary>
        /// Updates the current checksum with the data from a string, using a specific encoding.
        /// </summary>
        /// <param name="data">
        /// The string to update the checksum with. 
        /// </param>
        /// <param name="encoding">
        /// The encoding to use. 
        /// </param>
        void Update(string data, Encoding encoding);
    }
}