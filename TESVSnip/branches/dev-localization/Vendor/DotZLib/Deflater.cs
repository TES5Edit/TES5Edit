// © Copyright Henrik Ravn 2004
// Use, modification and distribution are subject to the Boost Software License, Version 1.0. 
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
namespace TESVSnip.DotZLib
{
    using System;
    using System.Runtime.InteropServices;

    /// <summary>
    /// Implements a data compressor, using the deflate algorithm in the ZLib dll.
    /// </summary>
    public sealed class Deflater : CodecBase
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="Deflater"/> class. 
        /// Constructs an new instance of the <c>Deflater</c>.
        /// </summary>
        /// <param name="level">
        /// The compression level to use for this <c>Deflater</c>. 
        /// </param>
        public Deflater(CompressLevel level)
            : base()
        {
            int retval = deflateInit_(ref _ztream, (int)level, Info.Version, Marshal.SizeOf(_ztream));
            if (retval != 0)
            {
                throw new ZLibException(retval, "Could not initialize deflater");
            }

            resetOutput();
        }

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
        public override void Add(byte[] data, int offset, int count)
        {
            if (data == null)
            {
                throw new ArgumentNullException();
            }

            if (offset < 0 || count < 0)
            {
                throw new ArgumentOutOfRangeException();
            }

            if ((offset + count) > data.Length)
            {
                throw new ArgumentException();
            }

            var total = count;
            var inputIndex = offset;

            var err = 0;
            while (err >= 0 && inputIndex < total)
            {
                copyInput(data, inputIndex, Math.Min(total - inputIndex, kBufferSize));
                while (_ztream.avail_in > 0)
                {
                    err = deflate(ref _ztream, (int)FlushTypes.None);
                    if (err < 0)
                    {
                        throw new ZLibException(err, _ztream.msg ?? "deflate failed");
                    }

                    OnDataAvailable();
                    inputIndex += (int)_ztream.total_in;
                }
            }

            setChecksum(_ztream.adler);
        }

        /// <summary>
        /// Finishes up any pending data that needs to be processed and handled.
        /// </summary>
        public override void Finish()
        {
            int err;
            do
            {
                err = deflate(ref _ztream, (int)FlushTypes.Finish);
                OnDataAvailable();
            }
            while (err == 0);
            setChecksum(_ztream.adler);
            deflateReset(ref _ztream);
            resetOutput();
        }

        /// <summary>
        /// Closes the internal zlib deflate stream.
        /// </summary>
        protected override void CleanUp()
        {
            deflateEnd(ref _ztream);
        }

        [DllImport("ZLIB1.dll", CallingConvention = CallingConvention.Cdecl)]
        [return: MarshalAs(UnmanagedType.I4)]
        private static extern int deflate([MarshalAs(UnmanagedType.Struct)] ref ZStream sz, [MarshalAs(UnmanagedType.I4)] int flush);

        [DllImport("ZLIB1.dll", CallingConvention = CallingConvention.Cdecl)]
        [return: MarshalAs(UnmanagedType.I4)]
        private static extern int deflateEnd([MarshalAs(UnmanagedType.Struct)] ref ZStream sz);

        [DllImport("ZLIB1.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        [return: MarshalAs(UnmanagedType.I4)]
        private static extern int deflateInit_(
            [MarshalAs(UnmanagedType.Struct)] ref ZStream sz, [MarshalAs(UnmanagedType.I4)] int level, [MarshalAs(UnmanagedType.LPStr)] string vs, [MarshalAs(UnmanagedType.I4)] int size);

        [DllImport("ZLIB1.dll", CallingConvention = CallingConvention.Cdecl)]
        [return: MarshalAs(UnmanagedType.I4)]
        private static extern int deflateReset([MarshalAs(UnmanagedType.Struct)] ref ZStream sz);
    }
}
