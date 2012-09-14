namespace TESVSnip.UI
{
    using System;
    using System.Collections.Generic;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Domain.Model;
    using TESVSnip.Framework;

    /// <summary>
    /// External state for holding single selection for use with evaluating descriptions and intelligent editors.
    /// </summary>
    public class SelectionContext : ISelectionContext
    {
        internal dFormIDLookupI formIDLookup;

        internal dFormIDLookupR formIDLookupR;

        internal dLStringLookup strLookup;

        private Rec record;

        private SubRecord subRecord;

        public SelectionContext()
        {
            this.Conditions = new Dictionary<int, Conditional>();
        }

        public event EventHandler RecordChanged;

        public event EventHandler SubRecordChanged;

        public Dictionary<int, Conditional> Conditions { get; private set; }

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

        object ICloneable.Clone()
        {
            return this.Clone();
        }

        ISelectionContext ICloneable<ISelectionContext>.Clone()
        {
            return this.Clone();
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
            this.Conditions.Clear();
            this.SubRecord = null;
            this.Record = null;
        }
    }
}