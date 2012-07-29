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
        public static BinaryReader Decompress(MemoryStream stream, uint inputSize, uint outputSize)
        {
            if (stream == null) {
                throw new ArgumentNullException("stream");
            }

            var inputBuffer = new byte[inputSize];
            var outputBuffer = new byte[outputSize];

            int totalBytes;
            if ((totalBytes = stream.Read(inputBuffer, 0, inputBuffer.Length)) != inputBuffer.Length) {
                throw new InvalidDataException(string.Format("Failed to read the whole buffer from input. Required = {0} Read = {1}", inputBuffer.Length, totalBytes));
            }

            var inflater = new Inflater(false);
            inflater.SetInput(inputBuffer, 0, inputBuffer.Length);
            if ((totalBytes = inflater.Inflate(outputBuffer, 0, outputBuffer.Length)) != outputBuffer.Length) {
                throw new InvalidDataException(string.Format("Failed to inflate compressed data. Compressed Size = {0} Inflated = {1}", outputBuffer.Length, totalBytes));
            }

            var memoryStream = new MemoryStream(outputBuffer, 0, outputBuffer.Length);
            return new BinaryReader(memoryStream);
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
                                                        null,
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