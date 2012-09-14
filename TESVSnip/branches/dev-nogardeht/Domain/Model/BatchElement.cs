namespace TESVSnip.Domain.Model
{
    using System;
    using System.Globalization;
    using System.Linq;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Framework.Collections;

    internal class BatchElement : BatchCriteria
    {
        private BatchCondElementType type;

        private object value;

        public BatchSubrecord Parent { get; set; }

        public ElementStructure Record { get; set; }

        public BatchCondElementType Type
        {
            get
            {
                return this.type;
            }

            set
            {
                this.type = value;
                Checked = true;
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
                if (this.AssignValue(value))
                {
                    Checked = true;
                }
            }
        }

        public bool AssignValue(object value)
        {
            if (value == null)
            {
                this.value = value;
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
                    this.value = strvalue;
                    return true;
                case ElementValueType.Float:
                    {
                        float v;
                        if (float.TryParse(strvalue, NumberStyles.Any, CultureInfo.CurrentCulture, out v))
                        {
                            this.value = v;
                            return true;
                        }
                    }

                    break;
                case ElementValueType.Int:
                    {
                        int v;
                        if (int.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            this.value = v;
                            return true;
                        }
                    }

                    break;
                case ElementValueType.Short:
                    {
                        short v;
                        if (short.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            this.value = v;
                            return true;
                        }
                    }

                    break;
                case ElementValueType.Byte:
                    {
                        byte v;
                        if (byte.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            this.value = v;
                            return true;
                        }
                    }

                    break;
                case ElementValueType.FormID:
                    {
                        uint v;
                        if (uint.TryParse(strvalue, NumberStyles.HexNumber, CultureInfo.CurrentCulture, out v))
                        {
                            this.value = v;
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
                        uint v;
                        this.value = uint.TryParse(strvalue, NumberStyles.HexNumber, CultureInfo.CurrentCulture, out v) ? (object)v : strvalue;
                        return true;
                    }

                case ElementValueType.UShort:
                    {
                        ushort v;
                        if (ushort.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            this.value = v;
                            return true;
                        }
                    }

                    break;
                case ElementValueType.UInt:
                    {
                        uint v;
                        if (uint.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            this.value = v;
                            return true;
                        }
                    }

                    break;
                case ElementValueType.SByte:
                    {
                        uint v;
                        if (uint.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            this.value = v;
                            return true;
                        }
                    }

                    break;
            }

            return false;
        }

        public override bool Evaluate(Record r)
        {
            bool any = false;
            foreach (bool value in r.SubRecords.Where(x => x.Name == this.Parent.Record.name).Select(x => this.Evaluate(r, x)))
            {
                if (!value)
                {
                    return false;
                }

                any = true;
            }

            return any;
        }

        public override bool Evaluate(Record r, SubRecord sr)
        {
            bool any = false;
            foreach (bool value in sr.EnumerateElements().Where(x => x.Structure.name == this.Record.name).Select(x => this.Evaluate(r, sr, x)))
            {
                if (!value)
                {
                    return false;
                }

                any = true;
            }

            return any;
        }

        public bool Evaluate(Record r, SubRecord sr, Element se)
        {
            if (se == null)
            {
                return false;
            }

            var value = sr.GetCompareValue(se);
            int diff = ValueComparer.Compare(value, this.Value);
            switch (this.Type)
            {
                case BatchCondElementType.Set:
                    break;
                case BatchCondElementType.Add:
                    break;
                case BatchCondElementType.Subtract:
                    break;
                case BatchCondElementType.Multiply:
                    break;
                case BatchCondElementType.Divide:
                    break;
                case BatchCondElementType.Clear:
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }

            return false;
        }
    }
}
