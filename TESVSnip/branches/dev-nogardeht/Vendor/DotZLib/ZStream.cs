// © Copyright Henrik Ravn 2004
// Use, modification and distribution are subject to the Boost Software License, Version 1.0. 
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
namespace TESVSnip.DotZLib
{
    using System;
    using System.Runtime.InteropServices;

    #region Internal types

    #region ZStream structure

    // internal mapping of the zlib zstream structure for marshalling
    [StructLayout(LayoutKind.Sequential, Pack = 4, Size = 0, CharSet = CharSet.Ansi)]
    internal struct ZStream
    {
        public IntPtr next_in;

        public uint avail_in;

        public uint total_in;

        public IntPtr next_out;

        public uint avail_out;

        public uint total_out;

        [MarshalAs(UnmanagedType.LPStr)]
        public string msg;

        private readonly uint state;

        private readonly uint zalloc;

        private readonly uint zfree;

        private readonly uint opaque;

        private readonly int data_type;

        public uint adler;

        private readonly uint reserved;
    }

    #endregion

    #endregion

    #region Public enums

    #endregion

    #region Exception classes

    #endregion

    #region Interfaces

    #endregion

    #region Classes

    #endregion
}
