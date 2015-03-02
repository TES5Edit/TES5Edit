using System;
using System.Collections.Generic;
using System.Globalization;

namespace LODGenerator.Common
{
    public static class CmdArgs
    {
        public static CultureInfo ci = new CultureInfo("en-US");

        public static bool GetBool(Dictionary<string, string> args, string key, bool defValue = false)
        {
            if (!args.ContainsKey(key.ToLower()))
                return defValue;
            else
                return true;
        }

        public static float GetFloat(Dictionary<string, string> args, string key, float defValue = 0.0f)
        {
            float result = defValue;
            if (!args.ContainsKey(key.ToLower()) || !float.TryParse(args[key.ToLower()], NumberStyles.Any, (IFormatProvider)CmdArgs.ci, out result))
                return defValue;
            else
                return result;
        }

        public static int GetInt(Dictionary<string, string> args, string key, int defValue = -1)
        {
            int result = defValue;
            if (!args.ContainsKey(key.ToLower()) || !int.TryParse(args[key.ToLower()], NumberStyles.Integer, (IFormatProvider)CmdArgs.ci, out result))
                return defValue;
            else
                return result;
        }
    }
}
