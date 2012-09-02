namespace TESVSnip.Domain.Model
{
    using System.Xml.Serialization;

    [XmlType(AnonymousType = true)]
    public class SearchSubrecordXml
    {
        [XmlAttribute]
        public string SubRecord;

        [XmlAttribute]
        public SearchCondRecordType Type;
    }
}