using System;
using System.Collections.Generic;
using System.IO;
using ICSharpCode.SharpZipLib.Zip.Compression;
using ICSharpCode.SharpZipLib.Zip.Compression.Streams;

namespace TESVSnip
{
    public class TESParserException : Exception
    {
        public TESParserException(string msg) : base(msg)
        {
        }
    }

    #region class SelectionContext

    /// <summary>
    /// External state for holding single selection for use with evaluating descriptions and intelligent editors
    /// </summary>
    public class SelectionContext
    {
        private Rec record;
        private SubRecord subRecord;

        public Rec Record
        {
            get { return record; }
            set
            {
                if (record != value)
                {
                    record = value;
                    SubRecord = null;
                    Conditions.Clear();
                    if (RecordChanged != null)
                        RecordChanged(this, EventArgs.Empty);
                }
            }
        }

        public SubRecord SubRecord
        {
            get { return subRecord; }
            set
            {
                if (subRecord != value)
                {
                    subRecord = value;
                    if (SubRecordChanged != null)
                        SubRecordChanged(this, EventArgs.Empty);
                }
            }
        }

        internal Dictionary<int, Conditional> Conditions = new Dictionary<int, Conditional>();
        internal dFormIDLookupI formIDLookup;
        internal dLStringLookup strLookup;
        internal dFormIDLookupR formIDLookupR;

        public bool SelectedSubrecord
        {
            get { return SubRecord != null; }
        }

        public void Reset()
        {
            Record = null;
        }

        public event EventHandler RecordChanged;
        public event EventHandler SubRecordChanged;

        public SelectionContext Clone()
        {
            var result = (SelectionContext) MemberwiseClone();
            result.RecordChanged = null;
            result.SubRecordChanged = null;
            return result;
        }
    }

    #endregion

    #region class Compressor / Decompressor

    internal static class Compressor
    {
        private static byte[] buffer;
        private static MemoryStream ms;
        private static Deflater def;
        private static DeflaterOutputStream defstr;
        private static string[] autoCompRecList = new string[0];


        public static Stream GetSharedStream()
        {
            ms.SetLength(0);
            ms.Position = 0;
            return ms;
        }

        public static BinaryWriter AllocWriter(Stream s)
        {
            int compressLevel = 9;
            def = new Deflater(compressLevel, false);
            defstr = new DeflaterOutputStream(ms, def);
            defstr.IsStreamOwner = false;
            return new BinaryWriter(defstr);
        }

        public static void CopyTo(BinaryWriter output, Stream input)
        {
            long left = input.Length;
            while (left > 0)
            {
                int nread = input.Read(buffer, 0, buffer.Length);
                if (nread == 0) break;
                output.Write(buffer, 0, nread);
            }
        }

        public static void Init()
        {
            ms = new MemoryStream();
            buffer = new byte[0x4000];

            // bit of a hack to avoid rebuilding this look up index
            autoCompRecList = Properties.Settings.Default.AutoCompressRecords != null
                                  ? Properties.Settings.Default.AutoCompressRecords.Trim().Split(new[] {';', ','},
                                                                                                 StringSplitOptions.
                                                                                                     RemoveEmptyEntries)
                                  : new string[0];
            Array.Sort(autoCompRecList);
        }

        public static bool CompressRecord(string name)
        {
            return Array.BinarySearch(autoCompRecList, name) >= 0;
        }

        public static void Close()
        {
            def = null;
            buffer = null;
            if (ms != null) ms.Dispose();
            ms = null;
        }
    }

    internal static class Decompressor
    {
        private static byte[] input;
        private static byte[] output;
        private static MemoryStream ms;
        private static BinaryReader compReader;
        private static Inflater inf;

        public static BinaryReader Decompress(BinaryReader br, int size, int outsize)
        {
            if (input.Length < size)
            {
                input = new byte[size];
            }
            if (output.Length+16 < outsize)
            {
                output = new byte[outsize + 16]; // Add 16 extra bytes to be able to detect uncompression overrun.
            }
            br.Read(input, 0, size);
            inf.Reset();
            inf.SetInput(input, 0, size);
            int decompressedSize = inf.Inflate(output);
            inf.Reset();

            ms.Position = 0;
            ms.Write(output, 0, outsize);
            ms.Position = 0;

            if (decompressedSize != outsize) // Check the size of the uncompressed data against what we expected
            {
                throw new Exception(String.Format("Unexpected Decompressed data size! CompressedSize={2:D} DecompressedSize={0:D} Expected Size={1:D}", decompressedSize, outsize, size));
            }

            return compReader;
        }

        public static void Init()
        {
            inf = new Inflater(false);
            ms = new MemoryStream();
            compReader = new BinaryReader(ms);
            input = new byte[0x1000];
            output = new byte[0x4000];
        }

        public static void Close()
        {
            compReader.Close();
            compReader = null;
            inf = null;
            input = null;
            output = null;
            ms = null;
        }
    }

    #endregion

    #region Misc Flag Defs

    internal static class FlagDefs
    {
        public static readonly string[] RecFlags1 = {
                                                        "ESM file",
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        "Deleted",
                                                        null,
                                                        "Localized",
                                                        null,
                                                        "Casts shadows",
                                                        "Quest item / Persistent reference",
                                                        "Initially disabled",
                                                        "Ignored",
                                                        null,
                                                        null,
                                                        "Visible when distant",
                                                        "Is full LOD",
                                                        "Dangerous / Off limits (Interior cell)",
                                                        "Data is compressed",
                                                        "Can't wait",
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                    };

        public static string GetRecFlags1Desc(uint flags)
        {
            string desc = "";
            bool b = false;
            for (int i = 0; i < 32; i++)
            {
                if ((flags & (uint) (1 << i)) > 0)
                {
                    if (b) desc += ", ";
                    b = true;
                    desc += (RecFlags1[i] == null ? "Unknown (" + ((uint) (1 << i)).ToString("x") + ")" : RecFlags1[i]);
                }
            }
            return desc;
        }
    }

    #endregion
}