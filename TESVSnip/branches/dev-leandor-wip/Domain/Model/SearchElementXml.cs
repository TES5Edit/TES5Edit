namespace TESVSnip.Domain.Model
{
    using System.Xml.Serialization;

    [XmlType(AnonymousType = true)]
    public class SearchElementXml
    {
        [XmlAttribute]
        public string Element;

        [XmlAttribute]
        public string SubRecord;

        [XmlAttribute]
        public SearchCondElementType Type;

        [XmlText]
        public string Value;
    }
}