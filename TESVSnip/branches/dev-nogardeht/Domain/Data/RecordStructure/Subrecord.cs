namespace TESVSnip.Domain.Data.RecordStructure
{
    using System;
    using System.CodeDom.Compiler;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Diagnostics;
    using System.Xml.Schema;
    using System.Xml.Serialization;

    /// <summary>
    /// The subrecord.
    /// </summary>
    /// <remarks>
    /// </remarks>
    [GeneratedCode("xsd", "4.0.30319.1")]
    [Serializable]
    [DebuggerStepThrough]
    [DesignerCategory("code")]
    [XmlType(AnonymousType = true)]
    [XmlRoot(Namespace = "", IsNullable = false)]
    public class Subrecord
    {
        /// <summary>
        /// The elements.
        /// </summary>
        /// <remarks>
        /// </remarks>
        [XmlElement("Element", Form = XmlSchemaForm.Unqualified)]
        public List<SubrecordElement> Elements = new List<SubrecordElement>();

        /// <summary>
        /// The condid.
        /// </summary>
        /// <remarks>
        /// </remarks>
        [XmlAttribute]
        [DefaultValue(0)]
        public int condid;

        /// <summary>
        /// The condition.
        /// </summary>
        /// <remarks>
        /// </remarks>
        [XmlAttribute]
        [DefaultValue("")]
        public string condition;

        /// <summary>
        /// The condvalue.
        /// </summary>
        /// <remarks>
        /// </remarks>
        [XmlAttribute]
        [DefaultValue("")]
        public string condvalue;

        /// <summary>
        /// The desc.
        /// </summary>
        /// <remarks>
        /// </remarks>
        [XmlAttribute]
        [DefaultValue("")]
        public string desc;

        /// <summary>
        /// The name.
        /// </summary>
        /// <remarks>
        /// </remarks>
        [XmlAttribute]
        public string name;

        /// <summary>
        /// The notininfo.
        /// </summary>
        /// <remarks>
        /// </remarks>
        [XmlAttribute]
        [DefaultValue(false)]
        public bool notininfo;

        /// <summary>
        /// The optional.
        /// </summary>
        /// <remarks>
        /// </remarks>
        [XmlAttribute]
        [DefaultValue(0)]
        public int optional;

        /// <summary>
        /// The repeat.
        /// </summary>
        /// <remarks>
        /// </remarks>
        [XmlAttribute]
        [DefaultValue(0)]
        public int repeat;

        [XmlAttribute]
        [DefaultValue(0)]
        public int size;

        [XmlIgnore]
        [DefaultValue(false)]
        public bool usehexeditor;

        public Subrecord()
        {
            this.desc = string.Empty;
            this.optional = 0;
            this.repeat = 0;
            this.notininfo = false;
            this.condid = 0;
            this.condition = string.Empty;
            this.condvalue = string.Empty;
            this.size = 0;
        }
    }
}