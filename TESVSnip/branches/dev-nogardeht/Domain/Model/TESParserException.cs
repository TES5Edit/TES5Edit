namespace TESVSnip.Domain.Model
{
    using System;

    public class TESParserException : Exception
    {
        public TESParserException(string msg)
            : base(msg)
        {
        }
    }
}
