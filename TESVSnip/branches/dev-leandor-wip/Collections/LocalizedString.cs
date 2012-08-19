namespace TESVSnip
{
    using System.ComponentModel;
    using System.Xml.Serialization;

    using TESVSnip.Collections.Generic;

    /// <summary>
    /// The localized string format.
    /// </summary>
    public enum LocalizedStringFormat
    {
        /// <summary>
        /// The base.
        /// </summary>
        Base, 

        /// <summary>
        /// The dl.
        /// </summary>
        DL, 

        /// <summary>
        /// The il.
        /// </summary>
        IL, 
    }

    /// <summary>
    /// The localized string dict.
    /// </summary>
    public class LocalizedStringDict : OrderedDictionary<uint, string>
    {
    }

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
