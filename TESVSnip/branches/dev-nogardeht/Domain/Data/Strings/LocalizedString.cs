namespace TESVSnip.Domain.Data.Strings
{
    using System.ComponentModel;
    using System.Xml.Serialization;

    /// <summary>
    /// The localized string.
    /// </summary>
    [XmlType(AnonymousType = true)]
    public class LocalizedString
    {
        /// <summary>
        /// The id.
        /// </summary>
        [XmlAttribute]
        public uint ID = 0;

        /// <summary>
        /// The type.
        /// </summary>
        [XmlAttribute]
        [DefaultValue(LocalizedStringFormat.Base)]
        public LocalizedStringFormat Type = LocalizedStringFormat.Base;

        /// <summary>
        /// The value.
        /// </summary>
        [XmlText]
        public string Value;
    }
}
