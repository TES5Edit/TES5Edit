namespace TESVSnip.Framework
{
    using System;

    internal static partial class Extensions
    {
        internal static T CastValue<T>(object value)
        {
            return CastValue<T>(value, default(T));
        }

        internal static T CastValue<T>(object value, T defaultValue)
        {
            if (value != null && !(value is DBNull))
            {
                try
                {
                    Type t0 = typeof(T);
                    Type t = value.GetType();
                    if (t0 == t)
                    {
                        return (T)value;
                    }

                    if (t0.IsEnum && !t.IsEnum)
                    {
                        value = Enum.Parse(t0, value.ToString());
                    }
                    else if (t0 == typeof(bool) && value is string)
                    {
                        bool boolResult;
                        if (bool.TryParse(value.ToString(), out boolResult))
                        {
                            return (T)(object)boolResult;
                        }

                        float floatResult;
                        if (float.TryParse(value.ToString(), out floatResult))
                        {
                            return (T)(object)(floatResult != default(float));
                        }
                    }

                    return (T)Convert.ChangeType(value, t0);
                }
                catch
                {
                }
            }

            return default(T);
        }

        internal static object CastValue(object value, Type type)
        {
            if (value != null && !(value is DBNull))
            {
                try
                {
                    bool isNullable = type.IsGenericType && type.GetGenericTypeDefinition() == typeof(Nullable<>);
                    if (isNullable)
                    {
                        type = Nullable.GetUnderlyingType(type);
                    }

                    if (type.IsEnum && !value.GetType().IsEnum)
                    {
                        value = Enum.Parse(type, value.ToString());
                    }
                    else if (type == typeof(bool) && value is string)
                    {
                        bool boolResult;
                        if (bool.TryParse(value.ToString(), out boolResult))
                        {
                            return boolResult;
                        }

                        float floatResult;
                        if (float.TryParse(value.ToString(), out floatResult))
                        {
                            return floatResult != default(float);
                        }
                    }

                    return Convert.ChangeType(value, type);
                }
                catch
                {
                }
            }

            return null;
        }
    }
}
