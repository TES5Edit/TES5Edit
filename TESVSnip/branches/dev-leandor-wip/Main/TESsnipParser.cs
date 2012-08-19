namespace TESVSnip.Main
{
    using System;
    using System.Collections.Generic;

    using TESVSnip.Model;

    public class TESParserException : Exception
    {
        public TESParserException(string msg)
            : base(msg)
        {
        }
    }

    #region class SelectionContext

    /// <summary>
    /// External state for holding single selection for use with evaluating descriptions and intelligent editors.
    /// </summary>
    public class SelectionContext
    {
        internal Dictionary<int, Conditional> Conditions = new Dictionary<int, Conditional>();

        internal dFormIDLookupI formIDLookup;

        internal dFormIDLookupR formIDLookupR;

        internal dLStringLookup strLookup;

        private Rec record;

        private SubRecord subRecord;

        public event EventHandler RecordChanged;

        public event EventHandler SubRecordChanged;

        public Rec Record
        {
            get
            {
                return this.record;
            }

            set
            {
                if (this.record != value)
                {
                    this.record = value;
                    this.SubRecord = null;
                    this.Conditions.Clear();
                    if (this.RecordChanged != null)
                    {
                        this.RecordChanged(this, EventArgs.Empty);
                    }
                }
            }
        }

        public bool SelectedSubrecord
        {
            get
            {
                return this.SubRecord != null;
            }
        }

        public SubRecord SubRecord
        {
            get
            {
                return this.subRecord;
            }

            set
            {
                if (this.subRecord != value)
                {
                    this.subRecord = value;
                    if (this.SubRecordChanged != null)
                    {
                        this.SubRecordChanged(this, EventArgs.Empty);
                    }
                }
            }
        }

        public SelectionContext Clone()
        {
            var result = (SelectionContext)MemberwiseClone();
            result.RecordChanged = null;
            result.SubRecordChanged = null;
            return result;
        }

        public void Reset()
        {
            this.Record = null;
        }
    }

    #endregion

    #region class Compressor / Decompressor

    internal static class Compressor
    {
        private static readonly string[] autoCompRecList = new string[0];

        public static bool CompressRecord(string name)
        {
            return Array.BinarySearch(autoCompRecList, name) >= 0;
        }
    }

    #endregion

    #region Misc Flag Defs

    internal static class FlagDefs
    {
        public static readonly string[] RecFlags1 =
            {
                "ESM file", null, null, null, null, "Deleted", null, "Localized", null, "Casts shadows", "Quest item / Persistent reference", "Initially disabled"
                , "Ignored", null, null, "Visible when distant", "Is full LOD", "Dangerous / Off limits (Interior cell)", "Data is compressed", "Can't wait", null
                , null, null, null, null, null, null, null, null, null, null, null, 
            };

        public static string GetRecFlags1Desc(uint flags)
        {
            string desc = string.Empty;
            bool b = false;
            for (int i = 0; i < 32; i++)
            {
                if ((flags & (uint)(1 << i)) > 0)
                {
                    if (b)
                    {
                        desc += ", ";
                    }

                    b = true;
                    desc += RecFlags1[i] == null ? "Unknown (" + ((uint)(1 << i)).ToString("x") + ")" : RecFlags1[i];
                }
            }

            return desc;
        }
    }

    #endregion
}
