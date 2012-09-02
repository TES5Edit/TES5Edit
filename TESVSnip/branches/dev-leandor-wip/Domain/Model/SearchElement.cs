namespace TESVSnip.Domain.Model
{
    using System;
    using System.Globalization;
    using System.Linq;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Framework.Collections;

    #region XML Serialization

    #endregion

    internal class SearchElement : SearchCriteria
    {
        private ElementStructure record;

        private SearchCondElementType type;

        private object value;

        public SearchSubrecord Parent { get; set; }

        public ElementStructure Record
        {
            get
            {
                return this.record;
            }

            set
            {
                this.record = value;
                if (value != null)
                {
                    Name = value.name;
                }
            }
        }

        public SearchCondElementType Type
        {
            get
            {
                return this.type;
            }

            set
            {
                if (this.type != value)
                {
                    this.type = value;
                    Checked = true;
                }
            }
        }

        public object Value
        {
            get
            {
                return this.value;
            }

            set
            {
                this.value = value;
                Checked = true;
                if (value != null && this.type == SearchCondElementType.Exists)
                {
                    this.type = SearchCondElementType.Equal;
                }
            }
        }

        public override bool Match(Record r)
        {
            bool any = false;
            foreach (bool value in r.SubRecords.Where(x => x.Name == this.Parent.Record.name).Select(x => this.Match(r, x)))
            {
                if (!value)
                {
                    return false;
                }

                any = true;
            }

            return any;
        }

        public override bool Match(Record r, SubRecord sr)
        {
            bool any = false;
            foreach (bool value in sr.EnumerateElements().Where(x => x.Structure.name == this.Record.name).Select(x => this.Match(r, sr, x)))
            {
                if (!value)
                {
                    return false;
                }

                any = true;
            }

            return any;
        }

        public override bool Match(Record r, SubRecord sr, Element se)
        {
            if (this.Type == SearchCondElementType.Exists && se != null)
            {
                return true;
            }

            if (this.Type == SearchCondElementType.Missing && se == null)
            {
                return true;
            }

            if (se == null)
            {
                return false;
            }

            var value = sr.GetCompareValue(se);
            int diff = ValueComparer.Compare(value, this.Value);
            switch (this.Type)
            {
                case SearchCondElementType.Equal:
                    return diff == 0;
                case SearchCondElementType.Not:
                    return diff != 0;
                case SearchCondElementType.Greater:
                    return diff > 0;
                case SearchCondElementType.Less:
                    return diff < 0;
                case SearchCondElementType.GreaterEqual:
                    return diff >= 0;
                case SearchCondElementType.LessEqual:
                    return diff <= 0;
                case SearchCondElementType.StartsWith:
                    if (diff == 0)
                    {
                        return true;
                    }

                    if (value != null && this.Value != null)
                    {
                        return value.ToString().StartsWith(this.Value.ToString(), StringComparison.CurrentCultureIgnoreCase);
                    }

                    break;
                case SearchCondElementType.EndsWith:
                    if (diff == 0)
                    {
                        return true;
                    }

                    if (value != null && this.Value != null)
                    {
                        return value.ToString().EndsWith(this.Value.ToString(), StringComparison.CurrentCultureIgnoreCase);
                    }

                    break;
                case SearchCondElementType.Contains:
                    if (diff == 0)
                    {
                        return true;
                    }

                    if (value != null && this.Value != null)
                    {
                        return value.ToString().IndexOf(this.Value.ToString(), StringComparison.CurrentCultureIgnoreCase) >= 0;
                    }

                    break;
            }

            return false;
        }

        public bool ValidateValue(object value)
        {
            if (value == null)
            {
                return true;
            }

            var strvalue = value.ToString();
            var numText = strvalue;

            var numStyle = NumberStyles.Any;
            if (numText.StartsWith("0x"))
            {
                numStyle = NumberStyles.HexNumber;
                numText = strvalue.Substring(2);
            }

            switch (this.Record.type)
            {
                case ElementValueType.String:
                case ElementValueType.BString:
                case ElementValueType.IString:
                case ElementValueType.Str4:
                    return true;
                case ElementValueType.Float:
                    {
                        float v;
                        if (float.TryParse(strvalue, NumberStyles.Any, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
                case ElementValueType.Int:
                    {
                        int v;
                        if (int.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
                case ElementValueType.Short:
                    {
                        short v;
                        if (short.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
                case ElementValueType.Byte:
                    {
                        byte v;
                        if (byte.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
                case ElementValueType.FormID:
                    {
                        uint v;
                        if (uint.TryParse(strvalue, NumberStyles.HexNumber, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
                case ElementValueType.Blob:
                    {
                        return false; // no support yet
                    }

                case ElementValueType.LString:
                    {
                        return true;
                    }

                case ElementValueType.UShort:
                    {
                        ushort v;
                        if (ushort.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
                case ElementValueType.UInt:
                    {
                        uint v;
                        if (uint.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
                case ElementValueType.SByte:
                    {
                        uint v;
                        if (uint.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
            }

            return false;
        }
    }
}
