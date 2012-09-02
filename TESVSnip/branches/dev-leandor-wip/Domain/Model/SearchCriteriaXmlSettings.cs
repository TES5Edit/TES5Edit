namespace TESVSnip.Domain.Model
{
    using System.Xml.Serialization;

    [XmlType(AnonymousType = true)]
    public class SearchCriteriaXmlSettings
    {
        [XmlElement("Subrecord", typeof(SearchSubrecordXml))]
        [XmlElement("Element", typeof(SearchElementXml))]
        public object[] Items = new object[0];

        [XmlAttribute]
        public string Name;

        [XmlAttribute]
        public string Type;

        public override string ToString()
        {
            return this.Name;
        }
    }
}