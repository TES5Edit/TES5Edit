using System.Collections.Generic;
using System.Xml.Serialization;
using TESVSnip.Collections.Generic;
using TESVSnip.Model;
using System.ComponentModel;

namespace TESVSnip
{
    public enum LocalizedStringFormat
    {
        Base,
        DL,
        IL,
    }

    public class LocalizedStringDict : OrderedDictionary<uint, string>
    {
    }


    [XmlRoot("Strings", Namespace = "", IsNullable = false)]
    public class LocalizedStrings
    {
        [XmlElement("String", typeof(LocalizedString))]
        public LocalizedString[] Strings;
    }

    [XmlType(AnonymousType = true)]
    public class LocalizedString
    {
        [XmlAttribute]
        public uint ID = 0;
        [XmlAttribute, DefaultValue(LocalizedStringFormat.Base)]
        public LocalizedStringFormat Type = LocalizedStringFormat.Base;
        [XmlText]
        public string Value;
    }
}