using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TESVSnip.Collections
{
    public class ValueComparer : IComparer
    {
        static readonly ValueComparer defaultComparer;
        static ValueComparer()
        {
            defaultComparer = new ValueComparer();
        }

        public static ValueComparer Default
        {
            get { return defaultComparer; }
        }

        int IComparer.Compare(Object x, Object y)
        {
            return Compare(x, y);
        }
        static bool IsEmpty(object obj)
        {
            return (obj == null
                   || obj == DBNull.Value
                   || (obj is string && ((string)obj).Length == 0));
        }
        public static int Compare(object x, object y)
        {
            bool xEmpty = IsEmpty(x);
            bool yEmpty = IsEmpty(y);
            if (xEmpty) return (yEmpty) ? 0 : -1; else if (yEmpty) return 1;

            try
            {
                Type tx = x.GetType();
                Type ty = y.GetType();
                if (tx == ty)
                {
                    if (x is IComparable)
                        return (x as IComparable).CompareTo(y);
                }

                if ((IsNumeric(x) && IsNumericOrString(y)) || (IsNumeric(y) && IsNumericOrString(x)))
                {
                    Type tt = IsNumeric(x) ? x.GetType() : y.GetType();
                    if (tt == typeof(int))
                    {
                        int dx = Convert.ToInt32(x);
                        int dy = Convert.ToInt32(y);
                        return dx == dy ? 0 : dx < dy ? -1 : 1;
                    }
                    else if (tt == typeof(double))
                    {
                        double dx = Convert.ToDouble(x);
                        double dy = Convert.ToDouble(y);
                        double diff = dx - dy;
                        if (Math.Abs(diff) <= float.Epsilon)
                            return 0;
                        if ((double.IsNaN(dx) && double.IsNaN(dy))
                            || (double.IsInfinity(dx) && double.IsInfinity(dy)))
                            return 0;
                        return (diff < 0 ? -1 : 1);
                    }
                    else if (tt == typeof(float))
                    {
                        float dx = Convert.ToSingle(x);
                        float dy = Convert.ToSingle(y);
                        float diff = dx - dy;
                        if (Math.Abs(diff) <= float.Epsilon)
                            return 0;
                        if ((float.IsNaN(dx) && float.IsNaN(dy))
                            || (float.IsInfinity(dx) && float.IsInfinity(dy)))
                            return 0;
                        return (diff < 0 ? -1 : 1);
                    }
                    else if (tt == typeof(uint))
                    {
                        var dx = Convert.ToUInt32(x);
                        var dy = Convert.ToUInt32(y);
                        return dx == dy ? 0 : dx < dy ? -1 : 1;
                    }
                    else if (tt == typeof(byte))
                    {
                        var dx = Convert.ToByte(x);
                        var dy = Convert.ToByte(y);
                        return dx == dy ? 0 : dx < dy ? -1 : 1;
                    }
                    else if (tt == typeof(sbyte))
                    {
                        var dx = Convert.ToSByte(x);
                        var dy = Convert.ToSByte(y);
                        return dx == dy ? 0 : dx < dy ? -1 : 1;
                    }
                    else if (tt == typeof(short))
                    {
                        var dx = Convert.ToInt16(x);
                        var dy = Convert.ToInt16(y);
                        return dx == dy ? 0 : dx < dy ? -1 : 1;
                    }
                    else if (tt == typeof(ushort))
                    {
                        var dx = Convert.ToUInt16(x);
                        var dy = Convert.ToUInt16(y);
                        return dx == dy ? 0 : dx < dy ? -1 : 1;
                    }
                    else if (tt == typeof(decimal))
                    {
                        var dx = Convert.ToDecimal(x);
                        var dy = Convert.ToDecimal(y);
                        return dx == dy ? 0 : dx < dy ? -1 : 1;
                    }
                }

                //handle string separately first
                if (x is IComparable && y is string)
                {
                    object oy = Convert.ChangeType(y, tx);
                    if (oy != null)
                        return (x as IComparable).CompareTo(oy);
                }
                else if (y is IComparable && x is string)
                {
                    object ox = Convert.ChangeType(x, ty);
                    if (ox is IComparable)
                    {
                        return ((IComparable)ox).CompareTo(y);
                    }
                }
                if (tx.IsPrimitive && ty.IsPrimitive)
                {
                    // more generic convert and test
                    if (x is IComparable && y is IConvertible)
                    {
                        object oy = Convert.ChangeType(y, tx);
                        if (oy is IComparable)
                            return ((IComparable)x).CompareTo(oy);
                    }
                    else if (y is IComparable && x is IConvertible)
                    {
                        object ox = Convert.ChangeType(x, ty);
                        if (ox != null)
                        {
                            if (x is IComparable)
                                return ((IComparable) ox).CompareTo(y);
                            else
                                return -((y as IComparable).CompareTo(ox));
                        }
                    }
                }
            }
            catch
            {
            }
            try { return System.Collections.Comparer.Default.Compare(x, y); }
            catch { return -1; }
        }
        static bool IsNumeric(object t)
        {
            TypeCode code = Convert.GetTypeCode(t);
            switch (code)
            {
                case TypeCode.Boolean:
                case TypeCode.DateTime:
                case TypeCode.Empty:
                case TypeCode.Object:
                case TypeCode.String:
                    return false;
            }
            return true;
        }
        public static bool IsNumericOrString(object t)
        {
            return IsNumeric(t) || (t is string);
        }

        public static int Compare(object x, object y, object tolerance)
        {
            if (tolerance == null) return Compare(x, y);

            bool xEmpty = IsEmpty(x);
            bool yEmpty = IsEmpty(y);
            if (xEmpty) return (yEmpty) ? 0 : -1; else if (yEmpty) return 1;

            try
            {
                if (IsNumeric(x) && IsNumericOrString(y) && IsNumericOrString(tolerance))
                {
                    Type tt = tolerance.GetType();
                    if (tt == typeof(double))
                    {
                        double dx = Convert.ToDouble(x);
                        double dy = Convert.ToDouble(y);
                        double tol = (double)tolerance;
                        double diff = dx - dy;
                        if (diff == 0.0 || Math.Abs(diff) <= tol)
                            return 0;
                        if ((double.IsNaN(dx) && double.IsNaN(dy))
                            || (double.IsInfinity(dx) && double.IsInfinity(dy)))
                            return 0;
                        return (diff < 0 ? -1 : 1);
                    }
                    else if (tt == typeof(int))
                    {
                        int dx = Convert.ToInt32(x);
                        int dy = Convert.ToInt32(y);
                        int tol = (int)tolerance;
                        int diff = dx - dy;
                        if (diff == 0 || Math.Abs(diff) <= tol)
                            return 0;
                        return (diff < 0 ? -1 : 1);
                    }
                    else if (tt == typeof(decimal))
                    {
                        decimal dx = Convert.ToDecimal(x);
                        decimal dy = Convert.ToDecimal(y);
                        decimal tol = (decimal)tolerance;
                        decimal diff = dx - dy;
                        if (diff == 0 || Math.Abs(diff) <= tol)
                            return 0;
                        return (diff < 0 ? -1 : 1);
                    }
                    else if (tt == typeof(float))
                    {
                        float dx = Convert.ToSingle(x);
                        float dy = Convert.ToSingle(y);
                        float tol = (float)tolerance;
                        float diff = dx - dy;
                        if (diff == 0.0 || Math.Abs(diff) <= tol)
                            return 0;
                        if ((float.IsNaN(dx) && float.IsNaN(dy))
                            || (float.IsInfinity(dx) && float.IsInfinity(dy)))
                            return 0;
                        return (diff < 0 ? -1 : 1);
                    }
                    else if (tt == typeof(uint))
                    {
                        uint dx = Convert.ToUInt32(x);
                        uint dy = Convert.ToUInt32(y);
                        uint tol = (uint)tolerance;
                        uint diff = dx - dy;
                        if (diff == 0 || Math.Abs(diff) <= tol)
                            return 0;
                        return (diff < 0 ? -1 : 1);
                    }
                    else
                    {
                        double dx = Convert.ToDouble(x);
                        double dy = Convert.ToDouble(y);
                        double tol = Convert.ToDouble(tolerance);
                        double diff = dx - dy;
                        if (diff == 0.0 || Math.Abs(diff) <= tol)
                            return 0;
                        return (diff < 0 ? -1 : 1);
                    }
                }
                return Compare(x, y);
            }
            catch { }
            try { return System.Collections.Comparer.Default.Compare(x, y); }
            catch { return -1; }
        }
    }
}
