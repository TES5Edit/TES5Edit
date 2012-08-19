namespace TESVSnip.DotZLib
{
    using System.Runtime.InteropServices;

    /// <summary>
    /// Encapsulates general information about the ZLib library.
    /// </summary>
    public class Info
    {
        private readonly uint _flags;

        // helper function that unpacks a bitsize mask

        /// <summary>
        /// Initializes a new instance of the <see cref="Info"/> class. 
        ///   Constructs an instance of the <c>Info</c> class.
        /// </summary>
        public Info()
        {
            this._flags = zlibCompileFlags();
        }

        /// <summary>
        /// Gets the version of ZLib as a string, e.g. "1.2.1".
        /// </summary>
        /// <value>
        /// The version.
        /// </value>
        public static string Version
        {
            get
            {
                return zlibVersion();
            }
        }

        /// <summary>
        /// True if the library is compiled with debug info.
        /// </summary>
        /// <value>
        /// The has debug info.
        /// </value>
        public bool HasDebugInfo
        {
            get
            {
                return 0 != (this._flags & 0x100);
            }
        }

        /// <summary>
        /// Gets the size of the z_off_t type that was compiled into Zlib.
        /// </summary>
        /// <value>
        /// The size of offset.
        /// </value>
        public int SizeOfOffset
        {
            get
            {
                return bitSize((this._flags >> 6) & 3);
            }
        }

        /// <summary>
        /// Gets the size of the pointers that were compiled into Zlib.
        /// </summary>
        /// <value>
        /// The size of pointer.
        /// </value>
        public int SizeOfPointer
        {
            get
            {
                return bitSize((this._flags >> 4) & 3);
            }
        }

        /// <summary>
        /// Gets the size of the unsigned int that was compiled into Zlib.
        /// </summary>
        /// <value>
        /// The size of u int.
        /// </value>
        public int SizeOfUInt
        {
            get
            {
                return bitSize(this._flags & 3);
            }
        }

        /// <summary>
        /// Gets the size of the unsigned long that was compiled into Zlib.
        /// </summary>
        /// <value>
        /// The size of u long.
        /// </value>
        public int SizeOfULong
        {
            get
            {
                return bitSize((this._flags >> 2) & 3);
            }
        }

        /// <summary>
        /// True if the library is compiled with assembly optimizations.
        /// </summary>
        /// <value>
        /// The uses assembly code.
        /// </value>
        public bool UsesAssemblyCode
        {
            get
            {
                return 0 != (this._flags & 0x200);
            }
        }

        private static int bitSize(uint bits)
        {
            switch (bits)
            {
                case 0:
                    return 16;
                case 1:
                    return 32;
                case 2:
                    return 64;
            }

            return -1;
        }

        [DllImport("ZLIB1.dll", CallingConvention = CallingConvention.Cdecl)]
        [return: MarshalAs(UnmanagedType.U4)]
        private static extern uint zlibCompileFlags();

        [DllImport("ZLIB1.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        [return: MarshalAs(UnmanagedType.LPStr)]
        private static extern string zlibVersion();
    }
}