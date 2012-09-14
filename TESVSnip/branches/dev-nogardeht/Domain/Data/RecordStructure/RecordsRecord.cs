namespace TESVSnip.Domain.Data.RecordStructure
{
    using System;
    using System.CodeDom.Compiler;
    using System.Collections;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Diagnostics;
    using System.Linq;
    using System.Xml.Serialization;

    /// <summary>
    /// The records record.
    /// </summary>
    /// <remarks>
    /// </remarks>
    [GeneratedCode("xsd", "4.0.30319.1")]
    [Serializable]
    [DebuggerStepThrough]
    [DesignerCategory("code")]
    [XmlType(AnonymousType = true)]
    public class RecordsRecord
    {
        ///// <remarks/>
        // [System.Xml.Serialization.XmlElementAttribute("Subrecord")]
        // public List<Subrecord> Subrecords = new List<Subrecord>();
        ///// <remarks/>
        // [System.Xml.Serialization.XmlElementAttribute("Group")]
        // public List<Group> Groups = new List<Group>();
        [XmlElement("Group", typeof(Group))]
        [XmlElement("Subrecord", typeof(Subrecord))]
        public ArrayList Items = new ArrayList();

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

        public RecordsRecord()
        {
            this.desc = string.Empty;
        }

        [XmlIgnore]
        public IEnumerable<Subrecord> AllSubrecords
        {
            get
            {
                return GetSubrecords(this.Items);
            }
        }

        [XmlIgnore]
        public IEnumerable<Group> Groups
        {
            get
            {
                return this.Items.OfType<Group>();
            }
        }

        [XmlIgnore]
        public IEnumerable<Subrecord> Subrecords
        {
            get
            {
                return this.Items.OfType<Subrecord>();
            }
        }

        private static IEnumerable<Subrecord> GetSubrecords(ICollection itr)
        {
            foreach (var item in itr)
            {
                if (item is Subrecord)
                {
                    yield return (Subrecord)item;
                }
                else if (item is Group)
                {
                    foreach (var itm in GetSubrecords(((Group)item).Items))
                    {
                        yield return itm;
                    }
                }
            }
        }
    }
}