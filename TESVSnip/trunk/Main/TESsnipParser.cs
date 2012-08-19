using System;
using System.Collections.Generic;

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
        private static string[] autoCompRecList = new string[0];

        public static bool CompressRecord(string name)
        {
            return Array.BinarySearch(autoCompRecList, name) >= 0;
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