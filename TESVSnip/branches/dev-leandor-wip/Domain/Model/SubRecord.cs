namespace TESVSnip.Domain.Model
{
    using System;
    using System.Collections.Generic;
    using System.Drawing;
    using System.Globalization;
    using System.IO;
    using System.Linq;
    using System.Runtime.Serialization;
    using System.Text;
    using System.Windows.Forms;

    using RTF;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Framework;
    using TESVSnip.Framework.Persistence;

    using Encoding = TESVSnip.Framework.Services.Encoding;

    [Persistable(Flags = PersistType.DeclaredOnly)]
    [Serializable]
    public sealed class SubRecord : BaseRecord
    {
        [Persistable]
        private byte[] Data;

        private Record Owner;

        public SubRecord()
        {
            Name = "NEW_";
            this.Data = new byte[0];
            this.Owner = null;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="SubRecord"/> class. 
        /// Create new subrecord using Structure as template
        /// </summary>
        /// <param name="srs">
        /// </param>
        internal SubRecord(SubrecordStructure srs)
            : this()
        {
            if (srs != null)
            {
                Name = srs.name;
                int size = 0;
                if (srs.size > 0)
                {
                    size = srs.size;
                }
                else
                {
                    foreach (var elem in srs.elements)
                    {
                        if (!elem.optional || elem.repeat == 0)
                        {
                            switch (elem.type)
                            {
                                case ElementValueType.FormID:
                                case ElementValueType.LString:
                                case ElementValueType.Int:
                                case ElementValueType.UInt:
                                case ElementValueType.Float:
                                case ElementValueType.Str4:
                                case ElementValueType.IString:
                                    size += 4;
                                    break;
                                case ElementValueType.BString:
                                case ElementValueType.Short:
                                case ElementValueType.UShort:
                                    size += 2;
                                    break;
                                case ElementValueType.String:
                                case ElementValueType.Byte:
                                case ElementValueType.SByte:
                                    size += 1;
                                    break;
                            }
                        }
                    }
                }

                this.Data = new byte[size];

                // TODO: populate with defaults if provided...
            }
        }

        internal SubRecord(Record rec, string name, BinaryReader br, uint size)
        {
            this.Owner = rec;
            Name = name;
            this.Data = new byte[size];
            br.Read(this.Data, 0, this.Data.Length);
        }

        private SubRecord(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
        }

        private SubRecord(SubRecord sr)
        {
            this.Owner = null;
            Name = sr.Name;
            this.Data = (byte[])sr.Data.Clone();
        }

        public string Description
        {
            get
            {
                return this.Structure != null ? this.Structure.desc : string.Empty;
            }
        }

        public override string DescriptiveName
        {
            get
            {
                if (string.IsNullOrEmpty(this.Description) && this.Description != Name)
                {
                    return Name;
                }

                return string.Format("{0}: {1}", Name, this.Description);
            }
        }

        public bool IsValid
        {
            get
            {
                return this.Structure != null && (this.Structure.size == 0 || this.Structure.size == this.Size);
            }
        }

        public override BaseRecord Parent
        {
            get
            {
                return this.Owner;
            }

            internal set
            {
                this.Owner = value as Record;
            }
        }

        public override long Size
        {
            get
            {
                return this.Data.Length;
            }
        }

        public override long Size2
        {
            get
            {
                return 6 + this.Data.Length + (this.Data.Length > ushort.MaxValue ? 10 : 0);
            }
        }

        internal SubrecordStructure Structure { get; private set; }

        public static RTFBuilderbase AppendLink(RTFBuilderbase s, string text, string hyperlink)
        {
            if (Properties.Settings.Default.DisableHyperlinks)
            {
                s.Append(text);
            }
            else
            {
                s.AppendLink(text, hyperlink);
            }

            return s;
        }

        public override void AddRecord(BaseRecord br)
        {
            throw new TESParserException("Subrecords cannot contain additional data.");
        }

        public override BaseRecord Clone()
        {
            return new SubRecord(this);
        }

        public override bool DeleteRecord(BaseRecord br)
        {
            return false;
        }

        public byte[] GetData()
        {
            return (byte[])this.Data.Clone();
        }

        public override string GetDesc()
        {
            return "[Subrecord]" + Environment.NewLine + "Name: " + Name + Environment.NewLine + "Size: " + this.Size.ToString() + " bytes (Excluding header)";
        }

        public override void GetFormattedData(StringBuilder s)
        {
            SubrecordStructure ss = this.Structure;
            if (ss == null)
            {
                return;
            }

            var p = this.GetPlugin();
            dFormIDLookupI formIDLookup = p.LookupFormID;
            dLStringLookup strLookup = p.LookupFormStrings;
            dFormIDLookupR formIDLookupR = p.GetRecordByID;

            int offset = 0;
            s.AppendFormat("{0} ({1})", ss.name, ss.desc);
            s.AppendLine();
            try
            {
                for (int eidx = 0, elen = 1; eidx < ss.elements.Length; eidx += elen)
                {
                    var sselem = ss.elements[eidx];
                    bool repeat = sselem.repeat > 0;
                    elen = sselem.repeat > 1 ? sselem.repeat : 1;
                    do
                    {
                        for (int eoff = 0; eoff < elen && offset < this.Data.Length; ++eoff)
                        {
                            sselem = ss.elements[eidx + eoff];

                            if (offset == this.Data.Length && eidx == ss.elements.Length - 1 && sselem.optional)
                            {
                                break;
                            }

                            if (!sselem.notininfo)
                            {
                                s.Append(sselem.name).Append(": ");
                            }

                            switch (sselem.type)
                            {
                                case ElementValueType.Int:
                                    {
                                        string tmps = TypeConverter.h2si(this.Data[offset], this.Data[offset + 1], this.Data[offset + 2], this.Data[offset + 3]).ToString();
                                        if (!sselem.notininfo)
                                        {
                                            if (sselem.hexview)
                                            {
                                                s.Append(TypeConverter.h2i(this.Data[offset], this.Data[offset + 1], this.Data[offset + 2], this.Data[offset + 3]).ToString("X8"));
                                            }
                                            else
                                            {
                                                s.Append(tmps);
                                            }

                                            if (sselem.options != null && sselem.options.Length > 0)
                                            {
                                                for (int k = 0; k < sselem.options.Length; k += 2)
                                                {
                                                    if (tmps == sselem.options[k + 1])
                                                    {
                                                        s.AppendFormat(" ({0})", sselem.options[k]);
                                                    }
                                                }
                                            }
                                            else if (sselem.flags != null && sselem.flags.Length > 0)
                                            {
                                                uint val = TypeConverter.h2i(this.Data[offset], this.Data[offset + 1], this.Data[offset + 2], this.Data[offset + 3]);
                                                var tmp2 = new StringBuilder();
                                                for (int k = 0; k < sselem.flags.Length; k++)
                                                {
                                                    if ((val & (1 << k)) != 0)
                                                    {
                                                        if (tmp2.Length > 0)
                                                        {
                                                            tmp2.Append(", ");
                                                        }

                                                        tmp2.Append(sselem.flags[k]);
                                                    }
                                                }

                                                if (tmp2.Length > 0)
                                                {
                                                    s.AppendFormat(" ({0})", tmp2);
                                                }
                                            }
                                        }

                                        offset += 4;
                                    }

                                    break;
                                case ElementValueType.UInt:
                                    {
                                        string tmps = TypeConverter.h2i(this.Data[offset], this.Data[offset + 1], this.Data[offset + 2], this.Data[offset + 3]).ToString();
                                        if (!sselem.notininfo)
                                        {
                                            if (sselem.hexview)
                                            {
                                                s.Append(TypeConverter.h2i(this.Data[offset], this.Data[offset + 1], this.Data[offset + 2], this.Data[offset + 3]).ToString("X8"));
                                            }
                                            else
                                            {
                                                s.Append(tmps);
                                            }

                                            if (sselem.options != null && sselem.options.Length > 0)
                                            {
                                                for (int k = 0; k < sselem.options.Length; k += 2)
                                                {
                                                    if (tmps == sselem.options[k + 1])
                                                    {
                                                        s.AppendFormat(" ({0})", sselem.options[k]);
                                                    }
                                                }
                                            }
                                            else if (sselem.flags != null && sselem.flags.Length > 0)
                                            {
                                                uint val = TypeConverter.h2i(this.Data[offset], this.Data[offset + 1], this.Data[offset + 2], this.Data[offset + 3]);
                                                var tmp2 = new StringBuilder();
                                                for (int k = 0; k < sselem.flags.Length; k++)
                                                {
                                                    if ((val & (1 << k)) != 0)
                                                    {
                                                        if (tmp2.Length > 0)
                                                        {
                                                            tmp2.Append(", ");
                                                        }

                                                        tmp2.Append(sselem.flags[k]);
                                                    }
                                                }

                                                if (tmp2.Length > 0)
                                                {
                                                    s.AppendFormat(" ({0})", tmp2);
                                                }
                                            }
                                        }

                                        offset += 4;
                                    }

                                    break;
                                case ElementValueType.Short:
                                    {
                                        string tmps = TypeConverter.h2ss(this.Data[offset], this.Data[offset + 1]).ToString();
                                        if (!sselem.notininfo)
                                        {
                                            if (sselem.hexview)
                                            {
                                                s.Append(TypeConverter.h2ss(this.Data[offset], this.Data[offset + 1]).ToString("X4"));
                                            }
                                            else
                                            {
                                                s.Append(tmps);
                                            }

                                            if (sselem.options != null && sselem.options.Length > 0)
                                            {
                                                for (int k = 0; k < sselem.options.Length; k += 2)
                                                {
                                                    if (tmps == sselem.options[k + 1])
                                                    {
                                                        s.AppendFormat(" ({0})", sselem.options[k]);
                                                    }
                                                }
                                            }
                                            else if (sselem.flags != null && sselem.flags.Length > 0)
                                            {
                                                uint val = TypeConverter.h2s(this.Data[offset], this.Data[offset + 1]);
                                                var tmp2 = new StringBuilder();
                                                for (int k = 0; k < sselem.flags.Length; k++)
                                                {
                                                    if ((val & (1 << k)) != 0)
                                                    {
                                                        if (tmp2.Length > 0)
                                                        {
                                                            tmp2.Append(", ");
                                                        }

                                                        tmp2.Append(sselem.flags[k]);
                                                    }
                                                }

                                                if (tmp2.Length > 0)
                                                {
                                                    s.AppendFormat(" ({0})", tmp2);
                                                }
                                            }
                                        }

                                        offset += 2;
                                    }

                                    break;
                                case ElementValueType.UShort:
                                    {
                                        string tmps = TypeConverter.h2s(this.Data[offset], this.Data[offset + 1]).ToString();
                                        if (!sselem.notininfo)
                                        {
                                            if (sselem.hexview)
                                            {
                                                s.Append(TypeConverter.h2s(this.Data[offset], this.Data[offset + 1]).ToString("X4"));
                                            }
                                            else
                                            {
                                                s.Append(tmps);
                                            }

                                            if (sselem.options != null && sselem.options.Length > 0)
                                            {
                                                for (int k = 0; k < sselem.options.Length; k += 2)
                                                {
                                                    if (tmps == sselem.options[k + 1])
                                                    {
                                                        s.Append(" (").Append(sselem.options[k]).Append(")");
                                                    }
                                                }
                                            }
                                            else if (sselem.flags != null && sselem.flags.Length > 0)
                                            {
                                                uint val = TypeConverter.h2s(this.Data[offset], this.Data[offset + 1]);
                                                var tmp2 = new StringBuilder();
                                                for (int k = 0; k < sselem.flags.Length; k++)
                                                {
                                                    if ((val & (1 << k)) != 0)
                                                    {
                                                        if (tmp2.Length > 0)
                                                        {
                                                            tmp2.Append(", ");
                                                        }

                                                        tmp2.Append(sselem.flags[k]);
                                                    }
                                                }

                                                if (tmp2.Length > 0)
                                                {
                                                    s.AppendFormat(" ({0})", tmp2);
                                                }
                                            }
                                        }

                                        offset += 2;
                                    }

                                    break;
                                case ElementValueType.Byte:
                                    {
                                        string tmps = this.Data[offset].ToString();
                                        if (!sselem.notininfo)
                                        {
                                            if (sselem.hexview)
                                            {
                                                s.Append(this.Data[offset].ToString("X2"));
                                            }
                                            else
                                            {
                                                s.Append(tmps);
                                            }

                                            if (sselem.options != null && sselem.options.Length > 0)
                                            {
                                                for (int k = 0; k < sselem.options.Length; k += 2)
                                                {
                                                    if (tmps == sselem.options[k + 1])
                                                    {
                                                        s.AppendFormat(" ({0})", sselem.options[k]);
                                                    }
                                                }
                                            }
                                            else if (sselem.flags != null && sselem.flags.Length > 0)
                                            {
                                                int val = this.Data[offset];
                                                var tmp2 = new StringBuilder();
                                                for (int k = 0; k < sselem.flags.Length; k++)
                                                {
                                                    if ((val & (1 << k)) != 0)
                                                    {
                                                        if (tmp2.Length > 0)
                                                        {
                                                            tmp2.Append(", ");
                                                        }

                                                        tmp2.Append(sselem.flags[k]);
                                                    }
                                                }

                                                if (tmp2.Length > 0)
                                                {
                                                    s.AppendFormat(" ({0})", tmp2);
                                                }
                                            }
                                        }

                                        offset++;
                                    }

                                    break;
                                case ElementValueType.SByte:
                                    {
                                        string tmps = ((sbyte)this.Data[offset]).ToString();
                                        if (!sselem.notininfo)
                                        {
                                            if (sselem.hexview)
                                            {
                                                s.Append(this.Data[offset].ToString("X2"));
                                            }
                                            else
                                            {
                                                s.Append(tmps);
                                            }

                                            if (sselem.options != null && sselem.options.Length > 0)
                                            {
                                                for (int k = 0; k < sselem.options.Length; k += 2)
                                                {
                                                    if (tmps == sselem.options[k + 1])
                                                    {
                                                        s.AppendFormat(" ({0})", sselem.options[k]);
                                                    }
                                                }
                                            }
                                            else if (sselem.flags != null && sselem.flags.Length > 0)
                                            {
                                                int val = this.Data[offset];
                                                var tmp2 = new StringBuilder();
                                                for (int k = 0; k < sselem.flags.Length; k++)
                                                {
                                                    if ((val & (1 << k)) != 0)
                                                    {
                                                        if (tmp2.Length > 0)
                                                        {
                                                            tmp2.Append(", ");
                                                        }

                                                        tmp2.Append(sselem.flags[k]);
                                                    }
                                                }

                                                if (tmp2.Length > 0)
                                                {
                                                    s.AppendFormat(" ({0})", tmp2);
                                                }
                                            }
                                        }

                                        offset++;
                                    }

                                    break;
                                case ElementValueType.FormID:
                                    {
                                        uint id = TypeConverter.h2i(this.Data[offset], this.Data[offset + 1], this.Data[offset + 2], this.Data[offset + 3]);
                                        if (!sselem.notininfo)
                                        {
                                            s.Append(id.ToString("X8"));
                                        }

                                        if (id != 0 && formIDLookup != null)
                                        {
                                            s.Append(": ").Append(formIDLookup(id));
                                        }

                                        offset += 4;
                                    }

                                    break;
                                case ElementValueType.Float:
                                    if (!sselem.notininfo)
                                    {
                                        s.Append(TypeConverter.h2f(this.Data[offset], this.Data[offset + 1], this.Data[offset + 2], this.Data[offset + 3]));
                                    }

                                    offset += 4;
                                    break;
                                case ElementValueType.String:
                                    if (!sselem.notininfo)
                                    {
                                        while (this.Data[offset] != 0)
                                        {
                                            s.Append((char)this.Data[offset++]);
                                        }
                                    }
                                    else
                                    {
                                        while (this.Data[offset] != 0)
                                        {
                                            offset++;
                                        }
                                    }

                                    offset++;
                                    break;
                                case ElementValueType.Blob:
                                    if (!sselem.notininfo)
                                    {
                                        s.Append(TypeConverter.GetHexData(this.Data, offset, this.Data.Length - offset));
                                    }

                                    offset += this.Data.Length - offset;
                                    break;
                                case ElementValueType.BString:
                                    {
                                        int len = TypeConverter.h2s(this.Data[offset], this.Data[offset + 1]);
                                        if (!sselem.notininfo)
                                        {
                                            s.Append(Encoding.Instance.GetString(this.Data, offset + 2, len));
                                        }

                                        offset += 2 + len;
                                    }

                                    break;
                                case ElementValueType.IString:
                                    {
                                        int len = TypeConverter.h2si(this.Data[offset], this.Data[offset + 1], this.Data[offset + 2], this.Data[offset + 3]);
                                        if (!sselem.notininfo)
                                        {
                                            s.Append(Encoding.Instance.GetString(this.Data, offset + 4, len));
                                        }

                                        offset += 4 + len;
                                    }

                                    break;
                                case ElementValueType.LString:
                                    {
                                        // Try to guess if string or string index.  Do not know if the external string checkbox is set or not in this code
                                        int left = this.Data.Length - offset;
                                        var data = new ArraySegment<byte>(this.Data, offset, left);
                                        bool isString = TypeConverter.IsLikelyString(data);
                                        uint id = TypeConverter.h2i(data);
                                        string lvalue = strLookup(id);
                                        if (!string.IsNullOrEmpty(lvalue) || !isString)
                                        {
                                            if (!sselem.notininfo)
                                            {
                                                s.Append(id.ToString("X8"));
                                            }

                                            if (strLookup != null)
                                            {
                                                s.Append(": ").Append(lvalue);
                                            }

                                            offset += 4;
                                        }
                                        else
                                        {
                                            if (!sselem.notininfo)
                                            {
                                                while (this.Data[offset] != 0)
                                                {
                                                    s.Append((char)this.Data[offset++]);
                                                }
                                            }
                                            else
                                            {
                                                while (this.Data[offset] != 0)
                                                {
                                                    offset++;
                                                }
                                            }

                                            offset++;
                                        }
                                    }

                                    break;
                                case ElementValueType.Str4:
                                    {
                                        if (!sselem.notininfo)
                                        {
                                            s.Append(Encoding.Instance.GetString(this.Data, offset, 4));
                                        }

                                        offset += 4;
                                    }

                                    break;
                                default:
                                    throw new ApplicationException();
                            }

                            if (!sselem.notininfo)
                            {
                                s.AppendLine();
                            }
                        }
                    }
                    while (repeat && offset < this.Data.Length);
                }

                if (offset < this.Data.Length)
                {
                    s.AppendLine();
                    s.AppendLine("Remaining Data: ");
                    s.Append(TypeConverter.GetHexData(this.Data, offset, this.Data.Length - offset));
                }
            }
            catch
            {
                s.AppendLine("Warning: Subrecord doesn't seem to match the expected structure");
            }
        }

        public override void GetFormattedData(RTFBuilder s)
        {
            SubrecordStructure ss = this.Structure;
            if (ss == null || ss.elements == null)
            {
                s.Append("String:\t").AppendLine(this.GetStrData()).AppendLine();
                s.Append("Hex: \t").AppendLine(this.GetHexData());
                s.AppendPara();
                return;
            }

            bool addTerminatingParagraph = false;
            try
            {
                var p = this.GetPlugin();

                dFormIDLookupI formIDLookup = p.LookupFormID;
                dLStringLookup strLookup = p.LookupFormStrings;
                dFormIDLookupR formIDLookupR = p.GetRecordByID;

                // Table of items
                var table = new List<List<RTFCellDefinition>>();

                // set up elements
                float maxWidth = 0;
                int maxFirstCellWidth = 0;

                var elems = this.EnumerateElements(true).Where(x => x.Structure != null && !x.Structure.notininfo).ToList();
                if (elems.Count == 0)
                {
                    return;
                }

                foreach (var element in elems)
                {
                    Size sz = s.MeasureText(element.Structure.name);
                    int width = Math.Max(sz.Width / 11, 10);

                    // approximate convert pixels to twips as the rtflib has crap documentation
                    if (width > maxFirstCellWidth)
                    {
                        maxFirstCellWidth = width;
                    }
                }

                foreach (var element in elems)
                {
                    var row = new List<RTFCellDefinition>();
                    table.Add(row);
                    var sselem = element.Structure;
                    bool hasOptions = sselem.options != null && sselem.options.Length > 0;
                    bool hasFlags = sselem.flags != null && sselem.flags.Length > 1;

                    // setup borders for header
                    var value = element.Value;
                    var nameCell = new RTFCellDefinition(maxFirstCellWidth, RTFAlignment.MiddleLeft, RTFBorderSide.Default, 15, Color.DarkGray, Padding.Empty);
                    row.Add(nameCell);
                    switch (sselem.type)
                    {
                        case ElementValueType.FormID:
                            row.Add(new RTFCellDefinition(12, RTFAlignment.MiddleLeft, RTFBorderSide.Default, 15, Color.DarkGray, Padding.Empty));
                            row.Add(new RTFCellDefinition(30, RTFAlignment.MiddleLeft, RTFBorderSide.Default, 15, Color.DarkGray, Padding.Empty));

                            // Optional Add cell for 
                            break;
                        case ElementValueType.LString:
                            row.Add(new RTFCellDefinition(12, RTFAlignment.MiddleLeft, RTFBorderSide.Default, 15, Color.DarkGray, Padding.Empty));
                            row.Add(new RTFCellDefinition(30, RTFAlignment.MiddleLeft, RTFBorderSide.Default, 15, Color.DarkGray, Padding.Empty));
                            break;

                        case ElementValueType.BString:
                        case ElementValueType.IString:
                        case ElementValueType.String:
                            row.Add(new RTFCellDefinition(42, RTFAlignment.MiddleLeft, RTFBorderSide.Default, 15, Color.DarkGray, Padding.Empty));
                            break;
                        case ElementValueType.Int:
                        case ElementValueType.UInt:
                        case ElementValueType.Byte:
                        case ElementValueType.SByte:
                        case ElementValueType.Short:
                        case ElementValueType.UShort:
                        case ElementValueType.Float:
                            row.Add(new RTFCellDefinition(12, RTFAlignment.MiddleLeft, RTFBorderSide.Default, 15, Color.DarkGray, Padding.Empty));
                            row.Add(new RTFCellDefinition(30, RTFAlignment.MiddleLeft, RTFBorderSide.Default, 15, Color.DarkGray, Padding.Empty));
                            break;
                        case ElementValueType.Blob:
                            row.Add(new RTFCellDefinition(42, RTFAlignment.MiddleLeft, RTFBorderSide.Default, 15, Color.DarkGray, Padding.Empty));
                            break;
                        case ElementValueType.Str4:
                            row.Add(new RTFCellDefinition(42, RTFAlignment.MiddleLeft, RTFBorderSide.Default, 15, Color.DarkGray, Padding.Empty));
                            break;
                        default:
                            row.Add(new RTFCellDefinition(42, RTFAlignment.MiddleLeft, RTFBorderSide.Default, 15, Color.DarkGray, Padding.Empty));
                            break;
                    }

                    maxWidth = Math.Max(maxWidth, row.Sum(x => x.CellWidthRaw));
                }

                var rowWidth = (int)(maxWidth * 100.0f);
                var pd = new Padding { All = 50 };

                var hdrd = new RTFRowDefinition(rowWidth, RTFAlignment.TopLeft, RTFBorderSide.Default, 15, SystemColors.WindowText, pd);
                var hdrcds = new[] { new RTFCellDefinition(rowWidth, RTFAlignment.MiddleLeft, RTFBorderSide.Default, 15, Color.DarkGray, Padding.Empty) };

                addTerminatingParagraph = true;
                s.Reset();
                using (IRTFRow ie = s.CreateRow(hdrd, hdrcds))
                {
                    foreach (var item in ie)
                    {
                        var rb = item.Content;
                        item.Content.FontSize(s.DefaultFontSize + 1).FontStyle(FontStyle.Bold).ForeColor(KnownColor.DarkCyan).AppendFormat("{0} ({1})", ss.name, ss.desc);
                    }
                }

                for (int rowIdx = 0; rowIdx < elems.Count; ++rowIdx)
                {
                    var rd = new RTFRowDefinition(rowWidth, RTFAlignment.TopLeft, RTFBorderSide.Default, 15, SystemColors.WindowText, pd);
                    var cds = table[rowIdx];
                    var elem = elems[rowIdx];
                    var sselem = elem.Structure;
                    var value = elem.Value;
                    string recprefix = null;
                    Record rec = null;
                    string strValue = null; // value to display
                    string strDesc = null; // first description
                    string strDesc2 = null; // second description
                    bool hasOptions = sselem.options != null && sselem.options.Length > 0;
                    bool hasFlags = sselem.flags != null && sselem.flags.Length > 1;

                    // Pre row write caching to avoid expensive duplicate calls between cells
                    switch (sselem.type)
                    {
                        case ElementValueType.FormID:
                            {
                                var id = (uint)value;
                                strValue = id.ToString("X8");
                                if (id != 0)
                                {
                                    rec = formIDLookupR != null ? formIDLookupR(id) : null;
                                }

                                if (rec != null)
                                {
                                    var pref = rec.GetPlugin();
                                    recprefix = pref != null ? string.Format("{0}@{1}", pref.Name, rec.Name) : rec.Name;
                                    strDesc = rec.DescriptiveName;
                                    var full = rec.SubRecords.FirstOrDefault(x => x.Name == "FULL");
                                    if (full != null)
                                    {
                                        // split the cell 2 in 2 if full name found
                                        var data = new ArraySegment<byte>(full.Data, 0, full.Data.Length);
                                        bool isString = TypeConverter.IsLikelyString(data);
                                        string lvalue = isString ? full.GetStrData() : strLookup != null ? strLookup(TypeConverter.h2i(data)) : null;
                                        if (!string.IsNullOrEmpty(lvalue))
                                        {
                                            var first = cds[cds.Count - 1];
                                            Size sz = s.MeasureText(lvalue);
                                            int width = Math.Min(40, Math.Max(sz.Width / 12, 10));

                                            // approximate convert pixels to twips as the rtflib has crap documentation
                                            var second = new RTFCellDefinition(width, RTFAlignment.MiddleLeft, RTFBorderSide.Default, 0, Color.DarkGray, Padding.Empty);
                                            cds.Add(second);
                                            strDesc2 = lvalue;
                                        }
                                    }
                                }
                            }

                            break;
                        case ElementValueType.LString:
                            {
                                if (elem.Type == ElementValueType.String)
                                {
                                    strValue = string.Empty;
                                    strDesc = value.ToString();
                                }
                                else if (TypeConverter.IsLikelyString(elem.Data))
                                {
                                    strValue = string.Empty;
                                    strDesc = TypeConverter.GetString(elem.Data);
                                }
                                else
                                {
                                    uint id = TypeConverter.h2i(elem.Data);
                                    strValue = id.ToString("X8");
                                    strDesc = strLookup != null ? strLookup(id) : null;
                                }
                            }

                            break;
                        case ElementValueType.Blob:
                            strValue = TypeConverter.GetHexData(elem.Data);
                            break;
                        case ElementValueType.SByte:
                        case ElementValueType.Int:
                        case ElementValueType.Short:
                            {
                                if (sselem.hexview || hasFlags)
                                {
                                    strValue = string.Format(string.Format("{{0:X{0}}}", elem.Data.Count * 2), value);
                                }
                                else
                                {
                                    strValue = value == null ? string.Empty : value.ToString();
                                }

                                if (hasOptions)
                                {
                                    int intVal = Convert.ToInt32(value);
                                    for (int k = 0; k < sselem.options.Length; k += 2)
                                    {
                                        int intValOption;
                                        if (int.TryParse(sselem.options[k + 1], out intValOption) && intVal == intValOption)
                                        {
                                            strDesc = sselem.options[k];
                                        }
                                    }
                                }
                                else if (hasFlags)
                                {
                                    int intVal = Convert.ToInt32(value);
                                    var tmp2 = new StringBuilder();
                                    for (int k = 0; k < sselem.flags.Length; k++)
                                    {
                                        if ((intVal & (1 << k)) != 0)
                                        {
                                            if (tmp2.Length > 0)
                                            {
                                                tmp2.Append(", ");
                                            }

                                            tmp2.Append(sselem.flags[k]);
                                        }
                                    }

                                    strDesc = tmp2.ToString();
                                }
                            }

                            break;

                        case ElementValueType.UInt:
                        case ElementValueType.Byte:
                        case ElementValueType.UShort:
                            {
                                if (sselem.hexview || hasFlags)
                                {
                                    strValue = string.Format(string.Format("{{0:X{0}}}", elem.Data.Count * 2), value);
                                }
                                else
                                {
                                    strValue = value == null ? string.Empty : value.ToString();
                                }

                                if (hasOptions)
                                {
                                    uint intVal = Convert.ToUInt32(value);
                                    for (int k = 0; k < sselem.options.Length; k += 2)
                                    {
                                        if (intVal == uint.Parse(sselem.options[k + 1]))
                                        {
                                            strDesc = sselem.options[k];
                                        }
                                    }
                                }
                                else if (hasFlags)
                                {
                                    uint intVal = Convert.ToUInt32(value);
                                    var tmp2 = new StringBuilder();
                                    for (int k = 0; k < sselem.flags.Length; k++)
                                    {
                                        if ((intVal & (1 << k)) != 0)
                                        {
                                            if (tmp2.Length > 0)
                                            {
                                                tmp2.Append(", ");
                                            }

                                            tmp2.Append(sselem.flags[k]);
                                        }
                                    }

                                    strDesc = tmp2.ToString();
                                }
                            }

                            break;
                        case ElementValueType.Str4:
                            strValue = TypeConverter.GetString(elem.Data);
                            break;
                        case ElementValueType.BString:
                            strValue = TypeConverter.GetBString(elem.Data);
                            break;
                        case ElementValueType.IString:
                            strValue = TypeConverter.GetIString(elem.Data);
                            break;
                        default:
                            strValue = value == null ? string.Empty : value.ToString();
                            break;
                    }

                    // Now create row and fill in cells
                    using (IRTFRow ie = s.CreateRow(rd, cds))
                    {
                        int colIdx = 0;
                        IEnumerator<IBuilderContent> ie2 = ie.GetEnumerator();
                        for (bool ok = ie2.MoveNext(); ok; ok = ie2.MoveNext(), ++colIdx)
                        {
                            using (var item = ie2.Current)
                            {
                                var rb = item.Content;
                                if (colIdx == 0)
                                {
                                    // name
                                    rb.FontStyle(FontStyle.Bold).Append(sselem.name);
                                }
                                else if (colIdx == 1)
                                {
                                    // value
                                    switch (sselem.type)
                                    {
                                        case ElementValueType.FormID:
                                            if (((uint)value) == 0)
                                            {
                                                rb.Append(strValue);
                                            }
                                            else if (rec != null)
                                            {
                                                AppendLink(rb, strValue, rec.GetLink());
                                            }
                                            else if (!string.IsNullOrEmpty(sselem.FormIDType))
                                            {
                                                AppendLink(rb, strValue, string.Format("{0}:{1}", sselem.FormIDType, strValue));
                                            }
                                            else
                                            {
                                                AppendLink(rb, strValue, string.Format("XXXX:{0}", strValue));
                                            }

                                            break;
                                        default:
                                            rb.Append(strValue);
                                            break;
                                    }
                                }
                                else if (colIdx == 2)
                                {
                                    // desc
                                    if (!string.IsNullOrEmpty(strDesc))
                                    {
                                        rb.Append(strDesc);
                                    }
                                }
                                else if (colIdx == 3)
                                {
                                    // desc2
                                    if (!string.IsNullOrEmpty(strDesc2))
                                    {
                                        rb.Append(strDesc2);
                                    }
                                }
                            }
                        }
                    }
                }
            }
            catch
            {
                s.AppendLine("Warning: Subrecord doesn't seem to match the expected structure");
            }
            finally
            {
                if (addTerminatingParagraph)
                {
                    s.Reset();
                    s.AppendPara();
                }
            }
        }

        public override void GetFormattedHeader(RTFBuilder s)
        {
            s.FontStyle(FontStyle.Bold).FontSize(s.DefaultFontSize + 4).ForeColor(KnownColor.DarkGray).AppendLine("[Subrecord data]");
        }

        public string GetHexData()
        {
            string s = string.Empty;
            foreach (byte b in this.Data)
            {
                s += b.ToString("X").PadLeft(2, '0') + " ";
            }

            return s;
        }

        public string GetLString()
        {
            var data = new ArraySegment<byte>(this.GetReadonlyData());
            bool isString = (data.Count != 4) || TypeConverter.IsLikelyString(data);
            if (isString)
            {
                return TypeConverter.GetString(data);
            }
            else
            {
                uint id = TypeConverter.h2i(data);
                var p = this.GetPlugin();
                return p != null ? p.LookupFormStrings(id) : null;
            }
        }

        public Plugin GetPlugin()
        {
            BaseRecord tn = this.Owner;
            while (!(tn is Plugin) && tn != null)
            {
                tn = tn.Parent;
            }

            if (tn != null)
            {
                return tn as Plugin;
            }

            return null;
        }

        public string GetStrData()
        {
            string s = string.Empty;
            foreach (byte b in this.Data)
            {
                if (b == 0)
                {
                    break;
                }

                s += (char)b;
            }

            return s;
        }

        public string GetStrData(int id)
        {
            string s = string.Empty;
            foreach (byte b in this.Data)
            {
                if (b == 0)
                {
                    break;
                }

                s += (char)b;
            }

            return s;
        }

        public T GetValue<T>(int offset)
        {
            T value;
            if (!this.TryGetValue(offset, out value))
            {
                value = default(T);
            }

            return value;
        }

        public void SetData(byte[] data)
        {
            this.Data = (byte[])data.Clone();
        }

        public void SetStrData(string s, bool nullTerminate)
        {
            if (nullTerminate)
            {
                s += '\0';
            }

            this.Data = System.Text.Encoding.Default.GetBytes(s);
        }

        public bool TryGetValue<T>(int offset, out T value)
        {
            value = (T)TypeConverter.GetObject<T>(this.Data, offset);
            return true;
        }

        internal void AttachStructure(SubrecordStructure ss)
        {
            this.Structure = ss;
        }

        internal void DetachStructure()
        {
            this.Structure = null;
        }

        internal IEnumerable<Element> EnumerateElements()
        {
            return this.EnumerateElements(false);
        }

        /// <summary>
        /// </summary>
        /// <param name="rawData">
        /// Retain raw data instead of converting to more usuable form 
        /// </param>
        /// <returns>
        /// The System.Collections.Generic.IEnumerable`1[T -&gt; TESVSnip.Element].
        /// </returns>
        internal IEnumerable<Element> EnumerateElements(bool rawData)
        {
            if (this.Structure == null)
            {
                yield return new Element(new ElementStructure(), new ArraySegment<byte>(this.GetData()));
            }
            else
            {
                byte[] data = this.GetReadonlyData();
                var ss = this.Structure;
                int offset = 0;
                foreach (var es in ss.elements)
                {
                    while (true)
                    {
                        int startoffset = offset;
                        int maxlen = data.Length - offset;
                        if ((es.optional || es.repeat > 0) && maxlen == 0)
                        {
                            break;
                        }

                        var elem = Element.CreateElement(es, data, ref offset, rawData);
                        yield return elem;
                        if (es.repeat > 0 && startoffset < offset)
                        {
                            continue;
                        }

                        break;
                    }
                }
            }
        }

        internal IEnumerable<Element> EnumerateElements(Dictionary<int, Conditional> conditions)
        {
            foreach (var elem in this.EnumerateElements())
            {
                if (elem != null && elem.Structure != null)
                {
                    var es = elem.Structure;
                    var essCondID = es.CondID;
                    if (essCondID != 0)
                    {
                        conditions[essCondID] = new Conditional(elem.Type, elem.Value);
                    }
                }

                yield return elem;
            }
        }

        internal object GetCompareValue(Element se)
        {
            object value = se.Value;
            switch (se.Structure.type)
            {
                case ElementValueType.LString:
                    if (value is uint)
                    {
                        var p = this.GetPlugin();
                        if (p != null)
                        {
                            value = p.LookupFormStrings((uint)value) ?? value;
                        }
                    }

                    break;
            }

            return value;
        }

        internal object GetDisplayValue(Element elem)
        {
            object value = elem.Value;

            var sselem = elem.Structure;
            Record rec = null;
            string strValue = null; // value to display
            bool hasOptions = sselem.options != null && sselem.options.Length > 0;
            bool hasFlags = sselem.flags != null && sselem.flags.Length > 1;
            var p = this.GetPlugin();

            switch (elem.Structure.type)
            {
                case ElementValueType.FormID:
                    {
                        var id = (uint)value;
                        strValue = id.ToString("X8");
                        if (id != 0)
                        {
                            rec = p.GetRecordByID(id);
                            if (rec != null)
                            {
                                strValue = string.Format("{0}: {1}", strValue, rec.DescriptiveName);
                            }
                        }

                        value = strValue;
                    }

                    break;
                case ElementValueType.LString:
                    if (value is uint)
                    {
                        if (p != null)
                        {
                            value = p.LookupFormStrings((uint)value) ?? value;
                        }
                    }

                    break;
                case ElementValueType.Blob:
                    value = TypeConverter.GetHexData(elem.Data);
                    break;
                case ElementValueType.SByte:
                case ElementValueType.Int:
                case ElementValueType.Short:
                    {
                        if (sselem.hexview || hasFlags)
                        {
                            value = string.Format(string.Format("{{0:X{0}}}", elem.Data.Count * 2), value);
                        }
                        else
                        {
                            value = value ?? string.Empty;
                        }

                        if (hasOptions)
                        {
                            int intVal;
                            if (sselem.hexview || hasFlags)
                            {
                                intVal = int.Parse(value.ToString(), NumberStyles.HexNumber);
                            }
                            else
                            {
                                intVal = Convert.ToInt32(value);
                            }

                            for (int k = 0; k < sselem.options.Length; k += 2)
                            {
                                if (intVal == int.Parse(sselem.options[k + 1]))
                                {
                                    value = sselem.options[k];
                                }
                            }
                        }
                        else if (hasFlags)
                        {
                            int intVal = int.Parse(value.ToString(), NumberStyles.HexNumber);
                            var tmp2 = new StringBuilder();
                            for (int k = 0; k < sselem.flags.Length; k++)
                            {
                                if ((intVal & (1 << k)) != 0)
                                {
                                    if (tmp2.Length > 0)
                                    {
                                        tmp2.Append(", ");
                                    }

                                    tmp2.Append(sselem.flags[k]);
                                }
                            }

                            tmp2.Insert(0, ": ");
                            tmp2.Insert(0, value.ToString());
                            value = tmp2.ToString();
                        }
                    }

                    break;
                case ElementValueType.UInt:
                case ElementValueType.Byte:
                case ElementValueType.UShort:
                    {
                        if (sselem.hexview || hasFlags)
                        {
                            value = string.Format(string.Format("{{0:X{0}}}", elem.Data.Count * 2), value);
                        }
                        else
                        {
                            value = value ?? string.Empty;
                        }

                        if (hasOptions)
                        {
                            uint intVal;
                            if (sselem.hexview || hasFlags)
                            {
                                intVal = uint.Parse(value.ToString(), NumberStyles.HexNumber);
                            }
                            else
                            {
                                intVal = Convert.ToUInt32(value);
                            }

                            for (int k = 0; k < sselem.options.Length; k += 2)
                            {
                                if (intVal == uint.Parse(sselem.options[k + 1]))
                                {
                                    value = sselem.options[k];
                                }
                            }
                        }
                        else if (hasFlags)
                        {
                            uint intVal = uint.Parse(value.ToString(), NumberStyles.HexNumber);
                            var tmp2 = new StringBuilder();
                            for (int k = 0; k < sselem.flags.Length; k++)
                            {
                                if ((intVal & (1 << k)) != 0)
                                {
                                    if (tmp2.Length > 0)
                                    {
                                        tmp2.Append(", ");
                                    }

                                    tmp2.Append(sselem.flags[k]);
                                }
                            }

                            tmp2.Insert(0, ": ");
                            tmp2.Insert(0, value.ToString());
                            value = tmp2.ToString();
                        }
                    }

                    break;
                case ElementValueType.Str4:
                    strValue = TypeConverter.GetString(elem.Data);
                    break;
                case ElementValueType.BString:
                    strValue = TypeConverter.GetBString(elem.Data);
                    break;
                case ElementValueType.IString:
                    strValue = TypeConverter.GetIString(elem.Data);
                    break;
                default:
                    strValue = value == null ? string.Empty : value.ToString();
                    break;
            }

            return value;
        }

        internal string GetFormattedData()
        {
            var sb = new StringBuilder();
            this.GetFormattedData(sb);
            return sb.ToString();
        }

        internal override List<string> GetIDs(bool lower)
        {
            var list = new List<string>();
            if (Name == "EDID")
            {
                if (lower)
                {
                    list.Add(this.GetStrData().ToLower());
                }
                else
                {
                    list.Add(this.GetStrData());
                }
            }

            return list;
        }

        internal byte[] GetReadonlyData()
        {
            return this.Data;
        }

        internal override void SaveData(BinaryWriter writer)
        {
            if (this.Data.Length > ushort.MaxValue)
            {
                WriteString(writer, "XXXX");
                writer.Write((ushort)4);
                writer.Write(this.Data.Length);
                WriteString(writer, Name);
                writer.Write((ushort)0);
                writer.Write(this.Data, 0, this.Data.Length);
            }
            else
            {
                WriteString(writer, Name);
                writer.Write((ushort)this.Data.Length);
                writer.Write(this.Data, 0, this.Data.Length);
            }
        }
    }
}
