using System;
using System.Runtime.InteropServices;
using System.Text;

namespace TESVSnip
{
    [StructLayout(LayoutKind.Explicit)]
    internal struct TypeConverter
    {
        [FieldOffset(0)] private uint i;
        [FieldOffset(0)] private int si;
        [FieldOffset(0)] private ushort s;
        [FieldOffset(0)] private short ss;
        [FieldOffset(0)] private float f;
        [FieldOffset(0)] private byte b1;
        [FieldOffset(1)] private byte b2;
        [FieldOffset(2)] private byte b3;
        [FieldOffset(3)] private byte b4;
        [FieldOffset(0)] private readonly sbyte sb1;

        private static TypeConverter tc;
        private static readonly byte[] bytes = new byte[4];

        /*public static float i2f(uint i) {
            tc.i=i;
            return tc.f;
        }*/
        /*public static uint f2i(float f) {
            tc.f=f;
            return tc.i;
        }*/

        public static float h2f(byte b1, byte b2, byte b3, byte b4)
        {
            tc.b1 = b1;
            tc.b2 = b2;
            tc.b3 = b3;
            tc.b4 = b4;
            return tc.f;
        }

        public static object GetObject<T>(byte[] data, int offset)
        {
            return (T)GetObject<T>(new ArraySegment<byte>(data, offset, data.Length - offset));
        }
        
        public static object GetObject<T>(ArraySegment<byte> data)
        {
            T result = default(T);
            if (result is float) return h2f(data);
            if (result is int) return h2si(data);
            if (result is uint) return h2i(data);
            if (result is short) return h2ss(data);
            if (result is ushort) return h2s(data);
            if (result is sbyte) return h2sb(data);
            if (result is byte) return h2b(data);
            if (result is string) return GetString(data);
            return default(T);
        }

        public static object GetValue<T>(ArraySegment<byte> data)
        {
            return (T) GetObject<T>(data);
        }

        public static bool TryGetObject<T>(byte[] data, int offset, out object result)
        {
            result = GetObject<T>(new ArraySegment<byte>(data, offset, data.Length - offset));
            return true;
        }

        public static ArraySegment<byte> GetData<T>(object value)
        {
            Type t = typeof (T);
            if (t == typeof(float)) return new ArraySegment<byte>(f2h(TESVSnip.Extensions.CastValue<float>(value)), 0, 4);
            if (t == typeof(int)) return new ArraySegment<byte>(si2h(TESVSnip.Extensions.CastValue<int>(value)), 0, 4);
            if (t == typeof(uint)) return new ArraySegment<byte>(i2h(TESVSnip.Extensions.CastValue<uint>(value)), 0, 4);
            if (t == typeof(short)) return new ArraySegment<byte>(ss2h(TESVSnip.Extensions.CastValue<short>(value)), 0, 2);
            if (t == typeof(ushort)) return new ArraySegment<byte>(s2h(TESVSnip.Extensions.CastValue<ushort>(value)), 0, 2);
            if (t == typeof(sbyte)) return new ArraySegment<byte>(sb2h(TESVSnip.Extensions.CastValue<sbyte>(value)), 0, 1);
            if (t == typeof(byte)) return new ArraySegment<byte>(si2h(TESVSnip.Extensions.CastValue<byte>(value)), 0, 1);
            if (t == typeof(string)) return new ArraySegment<byte>(str2h(TESVSnip.Extensions.CastValue<string>(value)));
            if (t == typeof(ArraySegment<byte>)) return (ArraySegment<byte>)value; 
            return new ArraySegment<byte>(new byte[0]);
        }

        public static bool TrySetValue<T>(ArraySegment<byte> data, object value)
        {
            var seg = GetData<T>(value);
            if (seg.Count == data.Count)
            {
                Array.Copy(seg.Array, seg.Offset, data.Array, data.Offset, data.Count);
                return true;
            }
            return false;
        }

        public static float h2f(byte[] data, int offset)
        {
            if (offset + sizeof (float) > data.Length)
                return default(float);
            tc.b1 = data[offset + 0];
            tc.b2 = data[offset + 1];
            tc.b3 = data[offset + 2];
            tc.b4 = data[offset + 3];
            return tc.f;
        }

        public static float h2f(ArraySegment<byte> data)
        {
            if (data.Count >= 4)
            {
                tc.b1 = data.Array[data.Offset + 0];
                tc.b2 = data.Array[data.Offset + 1];
                tc.b3 = data.Array[data.Offset + 2];
                tc.b4 = data.Array[data.Offset + 3];
                return tc.f;
            }
            return default(float);
        }

        public static uint h2i(byte b1, byte b2, byte b3, byte b4)
        {
            tc.b1 = b1;
            tc.b2 = b2;
            tc.b3 = b3;
            tc.b4 = b4;
            return tc.i;
        }

        public static uint h2i(ArraySegment<byte> data)
        {
            if (data.Count >= 4)
            {
                tc.b1 = data.Array[data.Offset + 0];
                tc.b2 = data.Array[data.Offset + 1];
                tc.b3 = data.Array[data.Offset + 2];
                tc.b4 = data.Array[data.Offset + 3];
                return tc.i;
            }
            return 0;
        }

        public static int h2si(byte b1, byte b2, byte b3, byte b4)
        {
            tc.b1 = b1;
            tc.b2 = b2;
            tc.b3 = b3;
            tc.b4 = b4;
            return tc.si;
        }

        public static int h2si(byte[] data, int offset)
        {
            if (data.Length >= 4)
            {
                tc.b1 = data[offset + 0];
                tc.b2 = data[offset + 1];
                tc.b3 = data[offset + 2];
                tc.b4 = data[offset + 3];
                return tc.si;
            }
            return 0;
        }

        public static int h2si(ArraySegment<byte> data)
        {
            if (data.Count >= 4)
            {
                tc.b1 = data.Array[data.Offset + 0];
                tc.b2 = data.Array[data.Offset + 1];
                tc.b3 = data.Array[data.Offset + 2];
                tc.b4 = data.Array[data.Offset + 3];
                return tc.si;
            }
            return 0;
        }

        public static ushort h2s(byte b1, byte b2)
        {
            tc.b1 = b1;
            tc.b2 = b2;
            return tc.s;
        }

        public static ushort h2s(ArraySegment<byte> data)
        {
            if (data.Count >= 2)
            {
                tc.b1 = data.Array[data.Offset + 0];
                tc.b2 = data.Array[data.Offset + 1];
                return tc.s;
            }
            return default(ushort);
        }

        public static short h2ss(byte b1, byte b2)
        {
            tc.b1 = b1;
            tc.b2 = b2;
            return tc.ss;
        }

        public static short h2ss(ArraySegment<byte> data)
        {
            if (data.Count >= 2)
            {
                tc.b1 = data.Array[data.Offset + 0];
                tc.b2 = data.Array[data.Offset + 1];
                return tc.ss;
            }
            return default(short);
        }

        public static byte h2b(ArraySegment<byte> data)
        {
            if (data.Count >= 1)
            {
                return data.Array[data.Offset + 0];
            }
            return default(byte);
        }

        public static sbyte h2sb(ArraySegment<byte> data)
        {
            if (data.Count >= 1)
            {
                tc.b1 = data.Array[data.Offset + 0];
                return tc.sb1;
            }
            return default(sbyte);
        }

        private static byte[] UpdateBytes()
        {
            bytes[0] = tc.b1;
            bytes[1] = tc.b2;
            bytes[2] = tc.b3;
            bytes[3] = tc.b4;
            return bytes;
        }

        public static byte[] f2h(float f)
        {
            tc.f = f;
            return UpdateBytes();
        }

        public static byte[] i2h(uint i)
        {
            tc.i = i;
            return UpdateBytes();
        }

        public static byte[] si2h(int si)
        {
            tc.si = si;
            return UpdateBytes();
        }

        public static byte[] ss2h(short ss)
        {
            tc.ss = ss;
            return new[] {tc.b1, tc.b2};
        }

        public static byte[] s2h(ushort ss)
        {
            tc.s = ss;
            return new[] {tc.b1, tc.b2};
        }

        /*public static void f2h(float f, byte[] data, int offset) {
            tc.f=f;
            data[offset+0]=tc.b1;
            data[offset+1]=tc.b2;
            data[offset+2]=tc.b3;
            data[offset+3]=tc.b4;
        }*/

        public static void i2h(uint i, byte[] data, int offset)
        {
            tc.i = i;
            data[offset + 0] = tc.b1;
            data[offset + 1] = tc.b2;
            data[offset + 2] = tc.b3;
            data[offset + 3] = tc.b4;
        }

        public static void si2h(int si, byte[] data, int offset)
        {
            tc.si = si;
            data[offset + 0] = tc.b1;
            data[offset + 1] = tc.b2;
            data[offset + 2] = tc.b3;
            data[offset + 3] = tc.b4;
        }

        public static void ss2h(short ss, byte[] data, int offset)
        {
            tc.ss = ss;
            data[offset + 0] = tc.b1;
            data[offset + 1] = tc.b2;
        }

        public static void s2h(ushort ss, byte[] data, int offset)
        {
            tc.s = ss;
            data[offset + 0] = tc.b1;
            data[offset + 1] = tc.b2;
        }

        public static bool IsLikelyString(ArraySegment<byte> data)
        {
            bool isValid = true;
            for (int i = 0; i < data.Count - 1 && isValid; ++i)
            {
                var c = (char) data.Array[data.Offset + i];
                //if (c == 0) return (i > 0);
                isValid = !Char.IsControl(c) || (c == 0x0D) || (c == 0x0A) || (c == 0x09) || (Properties.Settings.Default.UseUTF8 && ((c & 0x80) != 0)); // Include CR, LF and TAB as normal characters to allow multiline strings + Allow Multibyte UTF-8
            }
            return (isValid && data.Array[data.Count - 1] == 0);
        }

        public static string GetZString(ArraySegment<byte> data)
        {
            var sb = new StringBuilder();
            for (int i = 0; i < data.Count; ++i)
            {
                var c = (char) data.Array[data.Offset + i];
                if (c == 0) return sb.ToString();
                sb.Append(c);
            }
            return sb.ToString();
        }

        public static string GetBString(ArraySegment<byte> data)
        {
            ushort len = h2s(data);
            if (len > 0 && len <= data.Count + 2)
                return Encoding.CP1252.GetString(data.Array, data.Offset + 2, len);
            return "";
        }

        public static string GetIString(ArraySegment<byte> data)
        {
            int len = h2si(data);
            if (len > 0 && len <= data.Count + 4)
                return Encoding.CP1252.GetString(data.Array, data.Offset + 4, len);
            return "";
        }

        public static string GetString(ArraySegment<byte> data)
        {
            // remove the tailing null
            int len = data.Count > 0 && data.Array[data.Count - 1] == 0 ? data.Count - 1 : data.Count;
            return Encoding.CP1252.GetString(data.Array, data.Offset, len);
        }

        public static string GetHexData(byte[] data, int offset, int count)
        {
            var sb = new StringBuilder();
            for (int i = 0; i < count && (offset + i) < data.Length; ++i)
                sb.Append(data[offset + i].ToString("X2")).Append(" ");
            return sb.ToString();
        }

        public static string GetHexData(ArraySegment<byte> data)
        {
            return GetHexData(data.Array, data.Offset, data.Count);
        }

        /// <summary>
        /// Encode string including null termination character
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static byte[] str2h(string str)
        {
            int len = Encoding.CP1252.GetByteCount(str);
            var data = new byte[len + 1];
            Encoding.CP1252.GetBytes(str).CopyTo(data,0);
            data[len] = 0;
            return data;
        }

        /// <summary>
        /// Encode short byte length prefixed string
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static byte[] bstr2h(string str)
        {
            int len = Encoding.CP1252.GetByteCount(str);
            var data = new byte[2 + len];
            Array.Copy(s2h((ushort) len), 0, data, 0, 2);
            Array.Copy(Encoding.CP1252.GetBytes(str), 0, data, 2, len);
            return data;
        }

        /// <summary>
        /// Encode int length prefixed string
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static byte[] istr2h(string str)
        {
            int len = Encoding.CP1252.GetByteCount(str);
            var data = new byte[4 + len];
            Array.Copy(si2h(len), 0, data, 0, 4);
            Array.Copy(Encoding.CP1252.GetBytes(str), 0, data, 4, len);
            return data;
        }

        public static byte[] b2h(byte i)
        {
            return new[] {i};
        }

        public static byte[] sb2h(sbyte i)
        {
            return new[] {(byte) i};
        }
    }
}