using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using TESVSnip.Collections;

namespace TESVSnip.Model
{
    enum BatchCondRecordType
    {
        NoAction,
        Create,
        Delete,
    }

    enum BatchCondElementType
    {
        Set,
        Add,
        Subtract,
        Multiply,
        Divide,
        BitAnd,
        BitOr,
        Clear,
    }

    class BatchCriteriaSettings
    {
        public string Type;
        public IEnumerable<BatchCriteria> Items;
    }


    abstract class BatchCriteria
    {
        public bool Checked { get; set; }
        public string Name { get; set; }

        public abstract bool Evaluate(Record r);
        public abstract bool Evaluate(Record r, SubRecord sr);
    }

    class BatchSubrecord : BatchCriteria
    {
        public SubrecordStructure Record { get; set; }
        public ICollection<BatchElement> Children { get; set; }
        public BatchCondRecordType Type { get; set; }

        public override bool Evaluate(Record r)
        {
            var sr = r.SubRecords.FirstOrDefault(x => x.Name == this.Record.name);
            return Evaluate(r, sr);
        }
        public override bool Evaluate(Record r, SubRecord sr)
        {
            if (this.Type == BatchCondRecordType.Create)
            {
                if (sr == null)
                {
                    // guess the best insert location
                    int idx = -1;
                    RecordStructure rs;
                    if ( RecordStructure.Records.TryGetValue(r.Name, out rs) )
                    {
                        for ( int i = Array.FindIndex(rs.subrecords, structure => structure.name == this.Record.name) - 1; i >= 0; --i)
                        {
                            var srsname = rs.subrecords[i].name;
                            idx = r.SubRecords.IndexOf(r.SubRecords.FirstOrDefault(x => x.Name == srsname));
                        }
                    }
                    sr = new SubRecord(this.Record);
                    if (idx < 0) r.SubRecords.Add(sr); 
                    else r.SubRecords.Insert(idx+1, sr); 
                }
            }
            else if (this.Type == BatchCondRecordType.Delete)
            {
                while (sr != null)
                {
                    r.SubRecords.Remove(sr);
                    sr = r.SubRecords.FirstOrDefault(x => x.Name == this.Record.name);
                }
            }
            return true;
        }
    }
    class BatchElement : BatchCriteria
    {
        public ElementStructure Record { get; set; }
        public BatchSubrecord Parent { get; set; }
        private BatchCondElementType type;
        public BatchCondElementType Type
        {
            get { return type; }
            set { type = value; this.Checked = true; }
        }

        private object value;
        public object Value
        {
            get { return value; }
            set 
            {
                if (AssignValue(value))
                {
                    this.Checked = true;                    
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

            switch (Record.type)
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
                        if ( float.TryParse(strvalue, NumberStyles.Any, CultureInfo.CurrentCulture, out v) )
                        {
                            this.value = v;
                            return true;
                        }
                    } break;
                case ElementValueType.Int:
                    {
                        int v;
                        if (int.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            this.value = v;
                            return true;
                        }
                    } break;
                case ElementValueType.Short:
                    {
                        short v;
                        if (short.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            this.value = v;
                            return true;
                        }
                    } break;
                case ElementValueType.Byte:
                    {
                        byte v;
                        if (byte.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            this.value = v;
                            return true;
                        }
                    } break;
                case ElementValueType.FormID:
                    {
                        uint v;
                        if (uint.TryParse(strvalue, NumberStyles.HexNumber, CultureInfo.CurrentCulture, out v))
                        {
                            this.value = v;
                            return true;
                        }
                    } break;
                case ElementValueType.Blob:
                    {
                        return false;  // no support yet
                    } 
                case ElementValueType.LString:
                    {
                        uint v;
                        this.value = uint.TryParse(strvalue, NumberStyles.HexNumber, CultureInfo.CurrentCulture, out v)
                                         ? (object) v
                                         : strvalue;
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
                    } break;
                case ElementValueType.UInt:
                    {
                        uint v;
                        if (uint.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            this.value = v;
                            return true;
                        }
                    } break;
                case ElementValueType.SByte:
                    {
                        uint v;
                        if (uint.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            this.value = v;
                            return true;
                        }
                    } break;
            }
            return false;
        }

        public override bool Evaluate(Record r)
        {
            bool any = false;
            foreach (bool value in r.SubRecords.Where(x => x.Name == this.Parent.Record.name).Select(x => Evaluate(r, x)))
            {
                if (!value) return false;
                any = true;
            }
            return any;
        }
        public override bool Evaluate(Record r, SubRecord sr)
        {
            bool any = false;
            foreach (bool value in sr.EnumerateElements().Where(x => x.Structure.name == this.Record.name).Select(x => Evaluate(r, sr, x)))
            {
                if (!value) return false;
                any = true;
            }
            return any;
        }
        public bool Evaluate(Record r, SubRecord sr, Element se)
        {
            if (se == null)
                return false;

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
