namespace TESVSnip.Main
{
    using System;
    using System.Collections.Generic;

    using TESVSnip.Model;
    using TESVSnip.UI;

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
}