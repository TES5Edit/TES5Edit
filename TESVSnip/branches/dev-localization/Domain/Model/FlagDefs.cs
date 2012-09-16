namespace TESVSnip.Domain.Model
{
    internal static class FlagDefs
    {
        public static readonly string[] RecFlags1 =
            {
                "ESM file", null, null, null, null, "Deleted", null, "Localized", null, "Casts shadows", "Quest item / Persistent reference", "Initially disabled"
                , "Ignored", null, null, "Visible when distant", "Is full LOD", "Dangerous / Off limits (Interior cell)", "Data is compressed", "Can't wait", null
                , null, null, null, null, null, null, null, null, null, null, null, 
            };

        public static string GetRecFlags1Desc(uint flags)
        {
            string desc = string.Empty;
            bool b = false;
            for (int i = 0; i < 32; i++)
            {
                if ((flags & (uint)(1 << i)) > 0)
                {
                    if (b)
                    {
                        desc += ", ";
                    }

                    b = true;
                    desc += RecFlags1[i] == null ? "Unknown (" + ((uint)(1 << i)).ToString("x") + ")" : RecFlags1[i];
                }
            }

            return desc;
        }
    }
}