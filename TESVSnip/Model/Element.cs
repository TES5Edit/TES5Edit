using System;

namespace TESVSnip
{
    enum ElementAssignmentType
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


    /// <summary>
    /// Helper for reference to Element structure including data
    /// </summary>
    internal sealed class Element
    {
        private readonly ElementValueType type = ElementValueType.Blob;

        public Element()
        {
        }

        public static Element CreateElement(ElementStructure es, byte[] data, ref int offset, bool rawData)
        {
            int maxlen = data.Length - offset;
            Element elem = null;
            try
            {
                int len;
                switch (es.type)
                {
                    case ElementValueType.Int:
                        len = maxlen >= sizeof (int) ? sizeof (int) : maxlen;
                        elem = new Element(es, ElementValueType.Int, new ArraySegment<byte>(data, offset, len));
                        offset += len;
                        break;
                    case ElementValueType.UInt:
                    case ElementValueType.FormID:
                        len = maxlen >= sizeof (uint) ? sizeof (uint) : maxlen;
                        elem = new Element(es, ElementValueType.UInt, new ArraySegment<byte>(data, offset, len));
                        offset += len;
                        break;
                    case ElementValueType.Float:
                        len = maxlen >= sizeof (float) ? sizeof (float) : maxlen;
                        elem = new Element(es, ElementValueType.Float, new ArraySegment<byte>(data, offset, len));
                        offset += len;
                        break;
                    case ElementValueType.Short:
                        len = maxlen >= sizeof (short) ? sizeof (short) : maxlen;
                        elem = new Element(es, ElementValueType.Short, new ArraySegment<byte>(data, offset, len));
                        offset += len;
                        break;
                    case ElementValueType.UShort:
                        len = maxlen >= sizeof (ushort) ? sizeof (ushort) : maxlen;
                        elem = new Element(es, ElementValueType.UShort, new ArraySegment<byte>(data, offset, len));
                        offset += len;
                        break;
                    case ElementValueType.SByte:
                        len = maxlen >= sizeof (sbyte) ? sizeof (sbyte) : maxlen;
                        elem = new Element(es, ElementValueType.SByte, new ArraySegment<byte>(data, offset, len));
                        offset += len;
                        break;
                    case ElementValueType.Byte:
                        len = maxlen >= sizeof (byte) ? sizeof (byte) : maxlen;
                        elem = new Element(es, ElementValueType.Byte, new ArraySegment<byte>(data, offset, len));
                        offset += len;
                        break;
                    case ElementValueType.String:
                        len = 0;
                        for (int i = offset; i < data.Length && data[i] != 0; ++i, ++len) ;
                        if (rawData) // raw form includes the zero termination byte
                        {
                            len = (len == 0 ? 0 : len + 1);
                            elem = new Element(es, ElementValueType.String, new ArraySegment<byte>(data, offset, len));
                            offset += len;
                        }
                        else
                        {
                            elem = new Element(es, ElementValueType.String, new ArraySegment<byte>(data, offset, len));
                            offset += (len == 0 ? 0 : len + 1);
                        }
                        break;
                    case ElementValueType.BString:
                        if (maxlen >= sizeof (ushort))
                        {
                            len = TypeConverter.h2s(data[offset], data[offset + 1]);
                            len = (len < maxlen - 2) ? len : maxlen - 2;
                            if (rawData) // raw data includes short prefix
                            {
                                elem = new Element(es, ElementValueType.BString,
                                                   new ArraySegment<byte>(data, offset, len + 2));
                                offset += (len + 2);
                            }
                            else
                            {
                                elem = new Element(es, ElementValueType.String,
                                                   new ArraySegment<byte>(data, offset + 2, len));
                                offset += (len + 2);
                            }
                        }
                        else
                        {
                            if (rawData)
                                elem = new Element(es, ElementValueType.BString,
                                                   new ArraySegment<byte>(new byte[2] {0, 0}));
                            else
                                elem = new Element(es, ElementValueType.String, new ArraySegment<byte>(new byte[0]));
                            offset += maxlen;
                        }
                        break;
                    case ElementValueType.IString:
                        if (maxlen >= sizeof(int))
                        {
                            len = TypeConverter.h2si(data[offset], data[offset + 1], data[offset + 2], data[offset + 3]);
                            len = (len < maxlen - 4) ? len : maxlen - 4;
                            if (rawData) // raw data includes int prefix
                            {
                                elem = new Element(es, ElementValueType.IString,
                                                   new ArraySegment<byte>(data, offset, len + 4));
                                offset += (len + 4);
                            }
                            else
                            {
                                elem = new Element(es, ElementValueType.String,
                                                   new ArraySegment<byte>(data, offset + 4, len));
                                offset += (len + 4);
                            }
                        }
                        else
                        {
                            if (rawData)
                                elem = new Element(es, ElementValueType.IString,
                                                   new ArraySegment<byte>(new byte[4] { 0, 0, 0, 0 }));
                            else
                                elem = new Element(es, ElementValueType.String, new ArraySegment<byte>(new byte[0]));
                            offset += maxlen;
                        }
                        break;
                    case ElementValueType.Str4:
                        len = maxlen >= 4 ? 4 : maxlen;
                        if (rawData)
                            elem = new Element(es, ElementValueType.Str4, new ArraySegment<byte>(data, offset, len));
                        else
                            elem = new Element(es, ElementValueType.String, new ArraySegment<byte>(data, offset, len));
                        offset += len;
                        break;

                    case ElementValueType.LString:
                        if (maxlen < sizeof (int))
                        {
                            elem = new Element(es, ElementValueType.String, new ArraySegment<byte>(data, offset, maxlen));
                            offset += maxlen;
                        }
                        else
                        {
                            len = maxlen;
                            var blob = new ArraySegment<byte>(data, offset, len);
                            bool isString = TypeConverter.IsLikelyString(blob);
                            if (!isString)
                            {
                                elem = new Element(es, ElementValueType.UInt, new ArraySegment<byte>(data, offset, len));
                                offset += 4;
                            }
                            else
                            {
                                len = 0;
                                for (int i = offset; i < data.Length && data[i] != 0; ++i, ++len) ;
                                if (rawData) // lstring as raw string includes the terminating null
                                {
                                    len = (len == 0 ? 0 : len + 1);
                                    elem = new Element(es, ElementValueType.LString,
                                                       new ArraySegment<byte>(data, offset, len));
                                    offset += len;
                                }
                                else
                                {
                                    elem = new Element(es, ElementValueType.String,
                                                       new ArraySegment<byte>(data, offset, len));
                                    offset += (len == 0 ? 0 : len + 1);
                                }
                            }
                        }
                        break;

                    default:
                        elem = new Element(es, ElementValueType.Blob, new ArraySegment<byte>(data, offset, maxlen));
                        offset += maxlen;
                        break;
                }
            }
            catch
            {
            }
            finally
            {
                if (offset > data.Length) offset = data.Length;
            }
            return elem;
        }

        public Element(ElementStructure es, byte[] data, int offset, int count)
            : this(es, new ArraySegment<byte>(data, offset, count))
        {
        }

        public Element(ElementStructure es, ArraySegment<byte> data)
        {
            Structure = es;
            Data = data;
        }

        public Element(ElementStructure es, ElementValueType vt, ArraySegment<byte> data)
        {
            Structure = es;
            Data = data;
            type = vt;
        }

        public ElementValueType Type
        {
            get { return Structure == null && type == ElementValueType.Blob ? Structure.type : type; }
        }

        public ArraySegment<byte> Data { get; private set; }

        public ElementStructure Structure { get; private set; }

        public bool Modified { get; private set; }

        // layout changed i.e. no inplace assignment possible
        public bool Changed { get; private set; }

        public object Value
        {
            get
            {
                switch (Type)
                {
                    case ElementValueType.Int:
                        return TypeConverter.h2si(Data);
                    case ElementValueType.UInt:
                    case ElementValueType.FormID:
                        return TypeConverter.h2i(Data);
                    case ElementValueType.Float:
                        return TypeConverter.h2f(Data);
                    case ElementValueType.Short:
                        return TypeConverter.h2ss(Data);
                    case ElementValueType.UShort:
                        return TypeConverter.h2s(Data);
                    case ElementValueType.SByte:
                        return TypeConverter.h2sb(Data);
                    case ElementValueType.Byte:
                        return TypeConverter.h2b(Data);
                    case ElementValueType.String:
                        return TypeConverter.GetString(Data);
                    default:
                        if (Data.Offset == 0 && Data.Count == Data.Array.Length)
                            return Data.Array;
                        var b = new byte[Data.Count];
                        Array.Copy(Data.Array, Data.Offset, b, 0, Data.Count);
                        return b;
                }
            }
        }
        #region Assign Value
        internal bool AssignValue<T>(object val)
        {
            if (TypeConverter.TrySetValue<T>(this.Data, val))
            {
                this.Modified = true;
            }
            else
            {
                this.Data = TypeConverter.GetData<T>(val);
                this.Modified = true;
                this.Changed = true;
            }
            return true;
        }

        internal bool AssignValue(ElementAssignmentType elemType, object val)
        {
            switch (this.Structure.type)
            {
                case ElementValueType.String:
                    {
                        var str1 = TESVSnip.Extensions.CastValue<string>(this.Value);
                        switch (elemType)
                        {
                            case ElementAssignmentType.Set: return AssignValue<string>(val); 
                            case ElementAssignmentType.Add: return AssignValue<string>(str1 + TESVSnip.Extensions.CastValue<string>(val)); 
                            case ElementAssignmentType.Clear: return AssignValue<string>(default(string)); 
                        }
                    }
                    break;

                case ElementValueType.FormID:
                    {
                        if (this.Value is uint && val is uint)
                        {
                            var u1 = (uint)this.Value;
                            var u2 = (uint)val;
                            switch (elemType)
                            {
                                case ElementAssignmentType.Set: return AssignValue<uint>(u2); 
                                case ElementAssignmentType.Add: return AssignValue<uint>(u1 + u2); 
                                case ElementAssignmentType.Subtract: return AssignValue<uint>(u1 - u2); 
                                case ElementAssignmentType.Multiply: return AssignValue<uint>(u1 * u2); 
                                case ElementAssignmentType.Divide: return AssignValue<uint>(u1 / u2); 
                                case ElementAssignmentType.BitAnd: return AssignValue<uint>(u1 & u2); 
                                case ElementAssignmentType.BitOr: return AssignValue<uint>(u1 | u2); 
                                case ElementAssignmentType.Clear: return AssignValue<uint>(default(uint)); 
                            }
                        }
                    }
                    break;

                case ElementValueType.Blob:
                    break;

                case ElementValueType.LString:
                    if (this.Value is string && val is string)
                    {
                        var s1 = (string)this.Value;
                        var s2 = (string)val;
                        switch (elemType)
                        {
                            case ElementAssignmentType.Set: return AssignValue<string>(s2); 
                            case ElementAssignmentType.Add: return AssignValue<string>(s1 + s2); 
                            case ElementAssignmentType.Clear: return AssignValue<string>(default(string)); 
                        }
                    }
                    break;

                case ElementValueType.BString:
                case ElementValueType.IString:
                    break;

                case ElementValueType.Str4:
                    {
                        var str2 = TESVSnip.Extensions.CastValue<string>(val);
                        if (this.Data.Count == 4 && str2.Length == 4)
                        {
                            switch (elemType)
                            {
                                case ElementAssignmentType.Set: return AssignValue<string>(str2); 
                                case ElementAssignmentType.Clear: return AssignValue<string>("    "); 
                            }                            
                        }
                        
                    }
                    break;
                case ElementValueType.Float:
                    {
                        var val1 = TESVSnip.Extensions.CastValue<float>(this.Value);
                        switch (elemType)
                        {
                            case ElementAssignmentType.Set: return AssignValue<float>(val); 
                            case ElementAssignmentType.Add: return AssignValue<float>(val1 + TESVSnip.Extensions.CastValue<float>(val)); 
                            case ElementAssignmentType.Subtract: return AssignValue<float>(val1 - TESVSnip.Extensions.CastValue<float>(val)); 
                            case ElementAssignmentType.Multiply: return AssignValue<float>(val1 * TESVSnip.Extensions.CastValue<float>(val)); 
                            case ElementAssignmentType.Divide: return AssignValue<float>(val1 / TESVSnip.Extensions.CastValue<float>(val)); 
                            case ElementAssignmentType.BitAnd: return AssignValue<float>(TESVSnip.Extensions.CastValue<int>(val1) & TESVSnip.Extensions.CastValue<int>(val)); 
                            case ElementAssignmentType.BitOr: return AssignValue<float>(TESVSnip.Extensions.CastValue<int>(val1) | TESVSnip.Extensions.CastValue<int>(val)); 
                            case ElementAssignmentType.Clear: return AssignValue<float>(default(float)); 
                        }
                    } break;
                case ElementValueType.Int:
                    {
                        var val1 = TESVSnip.Extensions.CastValue<int>(this.Value);
                        switch (elemType)
                        {
                            case ElementAssignmentType.Set: return AssignValue<int>(val); 
                            case ElementAssignmentType.Add: return AssignValue<int>(val1 + TESVSnip.Extensions.CastValue<int>(val)); 
                            case ElementAssignmentType.Subtract: return AssignValue<int>(val1 - TESVSnip.Extensions.CastValue<int>(val)); 
                            case ElementAssignmentType.Multiply: return AssignValue<int>(val1 * TESVSnip.Extensions.CastValue<int>(val)); 
                            case ElementAssignmentType.Divide: return AssignValue<int>(val1 / TESVSnip.Extensions.CastValue<int>(val)); 
                            case ElementAssignmentType.BitAnd: return AssignValue<int>(val1 & TESVSnip.Extensions.CastValue<int>(val)); 
                            case ElementAssignmentType.BitOr: return AssignValue<int>(val1 | TESVSnip.Extensions.CastValue<int>(val)); 
                            case ElementAssignmentType.Clear: return AssignValue<int>(default(int)); 
                        }
                    } break;
                case ElementValueType.Short:
                    {
                        var val1 = TESVSnip.Extensions.CastValue<short>(this.Value);
                        switch (elemType)
                        {
                            case ElementAssignmentType.Set: return AssignValue<short>(val); 
                            case ElementAssignmentType.Add: return AssignValue<short>(val1 + TESVSnip.Extensions.CastValue<short>(val)); 
                            case ElementAssignmentType.Subtract: return AssignValue<short>(val1 - TESVSnip.Extensions.CastValue<short>(val)); 
                            case ElementAssignmentType.Multiply: return AssignValue<short>(val1 * TESVSnip.Extensions.CastValue<short>(val)); 
                            case ElementAssignmentType.Divide: return AssignValue<short>(val1 / TESVSnip.Extensions.CastValue<short>(val)); 
                            case ElementAssignmentType.BitAnd: return AssignValue<short>(val1 & TESVSnip.Extensions.CastValue<short>(val)); 
                            case ElementAssignmentType.BitOr: return AssignValue<short>(val1 | TESVSnip.Extensions.CastValue<short>(val)); 
                            case ElementAssignmentType.Clear: return AssignValue<short>(default(short)); 
                        }
                    } break;
                case ElementValueType.Byte:
                    {
                        var val1 = TESVSnip.Extensions.CastValue<byte>(this.Value);
                        switch (elemType)
                        {
                            case ElementAssignmentType.Set: return AssignValue<byte>(val); 
                            case ElementAssignmentType.Add: return AssignValue<byte>(val1 + TESVSnip.Extensions.CastValue<byte>(val)); 
                            case ElementAssignmentType.Subtract: return AssignValue<byte>(val1 - TESVSnip.Extensions.CastValue<byte>(val)); 
                            case ElementAssignmentType.Multiply: return AssignValue<byte>(val1 * TESVSnip.Extensions.CastValue<byte>(val)); 
                            case ElementAssignmentType.Divide: return AssignValue<byte>(val1 / TESVSnip.Extensions.CastValue<byte>(val)); 
                            case ElementAssignmentType.BitAnd: return AssignValue<byte>(val1 & TESVSnip.Extensions.CastValue<byte>(val)); 
                            case ElementAssignmentType.BitOr: return AssignValue<byte>(val1 | TESVSnip.Extensions.CastValue<byte>(val)); 
                            case ElementAssignmentType.Clear: return AssignValue<byte>(default(byte)); 
                        }
                    } break;
                case ElementValueType.UShort:
                    {
                        var val1 = TESVSnip.Extensions.CastValue<ushort>(this.Value);
                        switch (elemType)
                        {
                            case ElementAssignmentType.Set: return AssignValue<ushort>(val); 
                            case ElementAssignmentType.Add: return AssignValue<ushort>(val1 + TESVSnip.Extensions.CastValue<ushort>(val)); 
                            case ElementAssignmentType.Subtract: return AssignValue<ushort>(val1 - TESVSnip.Extensions.CastValue<ushort>(val)); 
                            case ElementAssignmentType.Multiply: return AssignValue<ushort>(val1 * TESVSnip.Extensions.CastValue<ushort>(val)); 
                            case ElementAssignmentType.Divide: return AssignValue<ushort>(val1 / TESVSnip.Extensions.CastValue<ushort>(val)); 
                            case ElementAssignmentType.BitAnd: return AssignValue<ushort>(val1 & TESVSnip.Extensions.CastValue<ushort>(val)); 
                            case ElementAssignmentType.BitOr: return AssignValue<ushort>(val1 | TESVSnip.Extensions.CastValue<ushort>(val)); 
                            case ElementAssignmentType.Clear: return AssignValue<ushort>(default(ushort)); 
                        }
                    } break;
                case ElementValueType.UInt:
                    {
                        var val1 = TESVSnip.Extensions.CastValue<uint>(this.Value);
                        switch (elemType)
                        {
                            case ElementAssignmentType.Set: return AssignValue<uint>(val); 
                            case ElementAssignmentType.Add: return AssignValue<uint>(val1 + TESVSnip.Extensions.CastValue<uint>(val)); 
                            case ElementAssignmentType.Subtract: return AssignValue<uint>(val1 - TESVSnip.Extensions.CastValue<uint>(val)); 
                            case ElementAssignmentType.Multiply: return AssignValue<uint>(val1 * TESVSnip.Extensions.CastValue<uint>(val)); 
                            case ElementAssignmentType.Divide: return AssignValue<uint>(val1 / TESVSnip.Extensions.CastValue<uint>(val)); 
                            case ElementAssignmentType.BitAnd: return AssignValue<uint>(val1 & TESVSnip.Extensions.CastValue<uint>(val)); 
                            case ElementAssignmentType.BitOr: return AssignValue<uint>(val1 | TESVSnip.Extensions.CastValue<uint>(val)); 
                            case ElementAssignmentType.Clear: return AssignValue<uint>(default(uint)); 
                        }
                    } break;
                case ElementValueType.SByte:
                    {
                        var val1 = TESVSnip.Extensions.CastValue<sbyte>(this.Value);
                        switch (elemType)
                        {
                            case ElementAssignmentType.Set: return AssignValue<sbyte>(val); 
                            case ElementAssignmentType.Add: return AssignValue<sbyte>(val1 + TESVSnip.Extensions.CastValue<sbyte>(val)); 
                            case ElementAssignmentType.Subtract: return AssignValue<sbyte>(val1 - TESVSnip.Extensions.CastValue<sbyte>(val)); 
                            case ElementAssignmentType.Multiply: return AssignValue<sbyte>(val1 * TESVSnip.Extensions.CastValue<sbyte>(val)); 
                            case ElementAssignmentType.Divide: return AssignValue<sbyte>(val1 / TESVSnip.Extensions.CastValue<sbyte>(val)); 
                            case ElementAssignmentType.BitAnd: return AssignValue<sbyte>(val1 & TESVSnip.Extensions.CastValue<sbyte>(val)); 
                            case ElementAssignmentType.BitOr: return AssignValue<sbyte>(val1 | TESVSnip.Extensions.CastValue<sbyte>(val)); 
                            case ElementAssignmentType.Clear: return AssignValue<sbyte>(default(sbyte)); 
                        }
                    } break;
            }
            return false;
        }
        #endregion
    }
}