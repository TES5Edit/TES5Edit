namespace TESVSnip.Domain.Data.RecordStructure
{
    using System;
    using System.CodeDom.Compiler;
    using System.Collections;
    using System.ComponentModel;
    using System.Diagnostics;
    using System.Xml.Schema;
    using System.Xml.Serialization;

    /// <summary>
    /// The records.
    /// </summary>
    /// <remarks>
    /// </remarks>
    [GeneratedCode("xsd", "4.0.30319.1")]
    [Serializable]
    [DebuggerStepThrough]
    [DesignerCategory("code")]
    [XmlType(AnonymousType = true)]
    [XmlRoot(Namespace = "", IsNullable = false)]
    public class Records
    {
        /// <summary>
        /// The items.
        /// </summary>
        /// <remarks>
        /// </remarks>
        [XmlElement("Group", typeof(Group))]
        [XmlElement("Record", typeof(RecordsRecord), Form = XmlSchemaForm.Unqualified)]
        [XmlElement("Subrecord", typeof(Subrecord))]
        public ArrayList Items = new ArrayList();
    }
}