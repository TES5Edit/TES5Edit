namespace TESVSnip.Domain.Data.RecordStructure
{
    using System;

    internal class RecordXmlException : Exception
    {
        public RecordXmlException(string msg)
            : base(msg)
        {
        }
    }
}