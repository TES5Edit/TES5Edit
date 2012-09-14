namespace TESVSnip.DotZLib
{
    using System;
    using System.Runtime.InteropServices;

    /// <summary>
    /// Implements a checksum generator that computes the Adler checksum on data.
    /// </summary>
    public sealed class AdlerChecksum : ChecksumGeneratorBase
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="AdlerChecksum"/> class. 
        ///   Initializes a new instance of the Adler checksum generator.
        /// </summary>
        public AdlerChecksum()
            : base()
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="AdlerChecksum"/> class. 
        /// Initializes a new instance of the Adler checksum generator with a specified value.
        /// </summary>
        /// <param name="initialValue">
        /// The value to set the current checksum to. 
        /// </param>
        public AdlerChecksum(uint initialValue)
            : base(initialValue)
        {
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
        public override void Update(byte[] data, int offset, int count)
        {
            if (offset < 0 || count < 0)
            {
                throw new ArgumentOutOfRangeException();
            }

            if ((offset + count) > data.Length)
            {
                throw new ArgumentException();
            }

            GCHandle hData = GCHandle.Alloc(data, GCHandleType.Pinned);
            try
            {
                _current = adler32(_current, hData.AddrOfPinnedObject().ToInt32() + offset, (uint)count);
            }
            finally
            {
                hData.Free();
            }
        }

        [DllImport("ZLIB1.dll", CallingConvention = CallingConvention.Cdecl)]
        private static extern uint adler32(uint adler, int data, uint length);
    }
}