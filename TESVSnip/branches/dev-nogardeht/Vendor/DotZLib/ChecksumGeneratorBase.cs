// © Copyright Henrik Ravn 2004
// Use, modification and distribution are subject to the Boost Software License, Version 1.0. 
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
namespace TESVSnip.DotZLib
{
    using System;
    using System.Text;

    #region ChecksumGeneratorBase

    /// <summary>
    /// Implements the common functionality needed for all <see cref="ChecksumGenerator"/>s.
    /// </summary>
    /// <example>
    /// </example>
    public abstract class ChecksumGeneratorBase : ChecksumGenerator
    {
        /// <summary>
        /// The value of the current checksum.
        /// </summary>
        protected uint _current;

        /// <summary>
        /// Initializes a new instance of the <see cref="ChecksumGeneratorBase"/> class. 
        ///   Initializes a new instance of the checksum generator base - the current checksum is 
        ///   set to zero.
        /// </summary>
        public ChecksumGeneratorBase()
        {
            this._current = 0;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ChecksumGeneratorBase"/> class. 
        /// Initializes a new instance of the checksum generator basewith a specified value.
        /// </summary>
        /// <param name="initialValue">
        /// The value to set the current checksum to. 
        /// </param>
        public ChecksumGeneratorBase(uint initialValue)
        {
            this._current = initialValue;
        }

        /// <summary>
        /// Gets the current checksum value.
        /// </summary>
        /// <value>
        /// The value.
        /// </value>
        public uint Value
        {
            get
            {
                return this._current;
            }
        }

        /// <summary>
        /// Resets the current checksum to zero.
        /// </summary>
        public void Reset()
        {
            this._current = 0;
        }

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
        /// <exception cref="NullReferenceException">
        /// <c>data</c>
        ///   is a null reference.
        /// </exception>
        /// <exception cref="ArgumentOutOfRangeException">
        /// Offset or count is negative.
        /// </exception>
        /// <remarks>
        /// All the other <c>Update</c> methods are implmeneted in terms of this one. 
        ///   This is therefore the only method a derived class has to implement.
        /// </remarks>
        public abstract void Update(byte[] data, int offset, int count);

        /// <summary>
        /// Updates the current checksum with an array of bytes.
        /// </summary>
        /// <param name="data">
        /// The data to update the checksum with. 
        /// </param>
        public void Update(byte[] data)
        {
            this.Update(data, 0, data.Length);
        }

        /// <summary>
        /// Updates the current checksum with the data from a string.
        /// </summary>
        /// <param name="data">
        /// The string to update the checksum with. 
        /// </param>
        /// <remarks>
        /// The characters in the string are converted by the UTF-8 encoding.
        /// </remarks>
        public void Update(string data)
        {
            this.Update(Encoding.UTF8.GetBytes(data));
        }

        /// <summary>
        /// Updates the current checksum with the data from a string, using a specific encoding.
        /// </summary>
        /// <param name="data">
        /// The string to update the checksum with. 
        /// </param>
        /// <param name="encoding">
        /// The encoding to use. 
        /// </param>
        public void Update(string data, Encoding encoding)
        {
            this.Update(encoding.GetBytes(data));
        }
    }

    #endregion

    #region CRC32

    #endregion

    #region Adler

    #endregion
}
