namespace TESVSnip.Framework.Services
{
    internal struct FontLangInfo
    {
        public readonly ushort CodePage;
        public readonly ushort lcid;
        public readonly byte charset;

        public FontLangInfo(ushort CodePage, ushort lcid, byte charset)
        {
            this.CodePage = CodePage;
            this.lcid = lcid;
            this.charset = charset;
        }
    }
}