namespace TESVSnip.Domain.Data.Strings
{
    using System.Xml.Serialization;

    /// <summary>
    /// The localized strings.
    /// </summary>
    [XmlRoot("Strings", Namespace = "", IsNullable = false)]
    public class LocalizedStrings
    {
        /// <summary>
        /// The strings.
        /// </summary>
        [XmlElement("String", typeof(LocalizedString))]
        public LocalizedString[] Strings;
    }
}
