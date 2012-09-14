namespace TESVSnip.Framework.Services
{
    using System;
    using System.Collections.Generic;

    internal static class Encoding
    {
        private static readonly System.Text.Encoding Cp1252 = System.Text.Encoding.GetEncoding(1252);
        private static readonly System.Text.Encoding Utf8 = System.Text.Encoding.GetEncoding("utf-8");

        private static readonly Dictionary<string, FontLangInfo> LanguageMap = new Dictionary<string, FontLangInfo>(StringComparer.InvariantCultureIgnoreCase);

        private static System.Text.Encoding instance;
        private static bool useUtf8Encoding;

        static Encoding()
        {
            LanguageMap.Add("English", new FontLangInfo(1252, 1033, 0));
            LanguageMap.Add("Czech", new FontLangInfo(1252, 1029, 238));
            LanguageMap.Add("French", new FontLangInfo(1252, 1036, 0));
            LanguageMap.Add("German", new FontLangInfo(1252, 1031, 0));
            LanguageMap.Add("Italian", new FontLangInfo(1252, 1040, 0));
            LanguageMap.Add("Spanish", new FontLangInfo(1252, 1034, 0));
            LanguageMap.Add("Russian", new FontLangInfo(1251, 1049, 204));
            LanguageMap.Add("Polish", new FontLangInfo(1250, 1045, 0));
        }

        public static System.Text.Encoding Instance
        {
            get
            {
                return instance ?? (instance = useUtf8Encoding ? Utf8 : Cp1252);
            }
        }

        public static void Initalize(bool useUtf8)
        {
            useUtf8Encoding = useUtf8;
        }

        internal static bool TryGetFontInfo(string name, out FontLangInfo langInfo)
        {
            return LanguageMap.TryGetValue(name, out langInfo);
        }
    }
}