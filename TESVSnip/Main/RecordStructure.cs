using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Xml.Serialization;
using TESVSnip.Data;

namespace TESVSnip
{
    internal class RecordXmlException : Exception
    {
        public RecordXmlException(string msg) : base(msg)
        {
        }
    }

    public enum ElementValueType
    {
        String,
        Float,
        Int,
        Short,
        Byte,
        FormID,
        Blob,
        LString,
        BString,
        UShort,
        UInt,
        SByte,
        Str4,
        IString
    }

    public enum CondType
    {
        None,
        Equal,
        Not,
        Greater,
        Less,
        GreaterEqual,
        LessEqual,
        StartsWith,
        EndsWith,
        Contains,
        Exists,
        Missing
    }

    public struct Conditional
    {
        public readonly ElementValueType type;
        public readonly object value;

        public Conditional(ElementValueType type, object value)
        {
            this.type = type;
            this.value = value;
        }
    }


    internal class SubrecordBase
    {
        protected SubrecordBase(SubrecordBase src, int optional, int repeat)
        {
            if (src.name.StartsWith("&#x"))
            {
                string[] val = src.name.Split(new[] {';'}, 2, StringSplitOptions.None);
                var c = (char) int.Parse(val[0].Substring(3), NumberStyles.HexNumber, null);
                name = c + val[1];
            }
            else
                name = src.name;
            desc = src.desc;
            this.optional = optional;
            this.repeat = repeat;
        }

        protected SubrecordBase(Subrecord node)
        {
            if (node.name.StartsWith("&#x"))
            {
                string[] val = node.name.Split(new[] {';'}, 2, StringSplitOptions.None);
                var c = (char) int.Parse(val[0].Substring(3), NumberStyles.HexNumber, null);
                name = c + val[1];
            }
            else
                name = node.name;
            repeat = node.repeat;
            optional = node.optional;
            desc = node.desc;
        }

        protected SubrecordBase(Group node)
        {
            if (node.name.StartsWith("&#x"))
            {
                string[] val = node.name.Split(new[] {';'}, 2, StringSplitOptions.None);
                var c = (char) int.Parse(val[0].Substring(3), NumberStyles.HexNumber, null);
                name = c + val[1];
            }
            else
                name = node.name;
            repeat = node.repeat;
            optional = node.optional;
            desc = node.desc;
        }

        public readonly string name;
        public readonly string desc;
        public readonly int repeat;
        public readonly int optional;

        public virtual bool IsGroup
        {
            get { return false; }
        }

        public override string ToString()
        {
            if (string.IsNullOrEmpty(desc) || name == desc)
                return name;
            return string.Format("{0}: {1}", name, desc);
        }
    }

    internal class SubrecordGroup : SubrecordBase
    {
        public SubrecordGroup(Group node, SubrecordBase[] items) : base(node)
        {
            elements = items;
        }

        public override bool IsGroup
        {
            get { return true; }
        }

        public readonly SubrecordBase[] elements;
    }

    internal class SubrecordStructure : SubrecordBase
    {
        public readonly ElementStructure[] elements;
        public readonly bool notininfo;
        public readonly int size;

        public readonly CondType Condition;
        public readonly int CondID;
        public readonly string CondOperand;
        public readonly bool ContainsConditionals;
        public readonly bool UseHexEditor;

        /// <summary>
        /// Clone structure with optional and repeat values overridden
        /// </summary>
        /// <param name="src"></param>
        /// <param name="optional"></param>
        /// <param name="repeat"></param>
        public SubrecordStructure(SubrecordStructure src, int optional, int repeat) : base(src, optional, repeat)
        {
            elements = src.elements;
            notininfo = src.notininfo;
            size = src.size;
            Condition = src.Condition;
            CondID = src.CondID;
            CondOperand = src.CondOperand;
            ContainsConditionals = src.ContainsConditionals;
            UseHexEditor = src.UseHexEditor;
        }

        public SubrecordStructure(Subrecord node) : base(node)
        {
            notininfo = node.notininfo;
            size = node.size;
            Condition = (!string.IsNullOrEmpty(node.condition))
                            ? (CondType) Enum.Parse(typeof (CondType), node.condition, true)
                            : CondType.None;
            CondID = node.condid;
            CondOperand = node.condvalue;
            UseHexEditor = node.usehexeditor;
            //if (optional && repeat)
            //{
            //    throw new RecordXmlException("repeat and optional must both have the same value if they are non zero");
            //}

            var elements = new List<ElementStructure>();
            foreach (var elem in node.Elements)
                elements.Add(new ElementStructure(elem));
            this.elements = elements.ToArray();

            ContainsConditionals = this.elements.Count(x => x.CondID != 0) > 0;
        }
    }

    internal class ElementStructure
    {
        public readonly string name;
        public readonly string desc;
        public readonly int group;
        public readonly ElementValueType type;
        public readonly string FormIDType;
        public readonly string[] options;
        public readonly int CondID;
        public readonly bool notininfo;
        public readonly bool multiline;
        public readonly int repeat;
        public readonly bool optional;
        public readonly bool hexview;
        public readonly string[] flags;

        public ElementStructure()
        {
            name = "DATA";
            desc = "Data";
            @group = 0;
            hexview = true;
            notininfo = true;
            optional = false;
            options = null;
            flags = null;
            repeat = 0;
            CondID = 0;
            FormIDType = null;
            multiline = false;
            type = ElementValueType.Blob;
        }

        public ElementStructure(SubrecordElement node)
        {
            name = node.name;
            desc = node.desc;
            @group = node.group;
            hexview = node.hexview;
            notininfo = node.notininfo;
            optional = node.optional != 0;
            options = node.options == null
                          ? new string[0]
                          : node.options.Split(new[] {';'}, StringSplitOptions.RemoveEmptyEntries);
            flags = node.flags == null ? new string[0] : node.flags.Split(new[] {';'});
            repeat = node.repeat;
            CondID = node.condid;
            if (optional || repeat > 0)
            {
                if (group != 0)
                    throw new RecordXmlException("Elements with a group attribute cant be marked optional or repeat");
            }
            FormIDType = null;
            multiline = node.multiline;
            type = (ElementValueType) Enum.Parse(typeof (ElementValueType), node.type, true);
            switch (type)
            {
                case ElementValueType.FormID:
                    FormIDType = node.reftype;
                    break;
                case ElementValueType.Blob:
                    if (repeat > 0 || optional)
                        throw new RecordXmlException(
                            "blob type elements can't be marked with repeat or optional");
                    break;
            }
        }

        public override string ToString()
        {
            if (string.IsNullOrEmpty(desc) || desc == name)
                return name;
            return string.Format("{0}: {1}", name, desc);
        }
    }

    internal class RecordStructure
    {
        #region Static

        private static bool loaded;

        public static bool Loaded
        {
            get { return loaded; }
        }

        public static Dictionary<string, RecordStructure> Records =
            new Dictionary<string, RecordStructure>(StringComparer.InvariantCultureIgnoreCase);

        private static readonly string xmlPath = Path.Combine(Program.settingsDir, @"RecordStructure.xml");

        private RecordStructure(RecordsRecord rec, SubrecordBase[] subrecordTree, SubrecordStructure[] subrecords)
        {
            name = rec.name;
            description = rec.desc;
            this.subrecordTree = subrecordTree;
            this.subrecords = subrecords;
        }

        private static List<SubrecordBase> GetSubrecordStructures(ICollection items, Dictionary<string, Group> dict)
        {
            var subrecords = new List<SubrecordBase>();
            foreach (var sr in items)
            {
                if (sr is Subrecord)
                {
                    subrecords.Add(new SubrecordStructure((Subrecord) sr));
                }
                else if (sr is Group)
                {
                    var g = sr as Group;
                    var ssr = GetSubrecordStructures((g.Items.Count > 0) ? g.Items : dict[g.id].Items, dict);
                    if (ssr.Count > 0)
                    {
                        //if (!ssr[0].IsGroup && (ssr[0].optional || ssr[0].repeat))
                        //{
                        //    throw new RecordXmlException("repeat and optional cannot be specified on first subrecord of a group");
                        //}
                        subrecords.Add(new SubrecordGroup(g, ssr.ToArray()));
                    }
                }
            }
            return subrecords;
        }

        /// <summary>
        /// Build the Subrecord array with groups expanded
        /// </summary>
        /// <param name="?"></param>
        /// <returns></returns>
        private static List<SubrecordStructure> BuildSubrecordStructure(IEnumerable<SubrecordBase> list)
        {
            var subrecords = new List<SubrecordStructure>();
            foreach (var sr in list)
            {
                if (sr is SubrecordStructure)
                {
                    subrecords.Add((SubrecordStructure) sr);
                }
                else if (sr is SubrecordGroup)
                {
                    var sg = sr as SubrecordGroup;
                    List<SubrecordStructure> sss = BuildSubrecordStructure(sg.elements);
                    if (sss.Count > 0)
                    {
                        if (sg.repeat > 0)
                            sss[0] = new SubrecordStructure(sss[0], sss.Count, sss.Count); // replace
                        else if (sg.optional > 0)
                            sss[0] = new SubrecordStructure(sss[0], sss.Count, 0); // optional
                    }
                    subrecords.AddRange(sss);
                }
            }
            return subrecords;
        }

        public static void Load()
        {
            if (loaded)
            {
                Records.Clear();
            }
            else loaded = true;


            var xs = new XmlSerializer(typeof (Records));
            using (FileStream fs = File.OpenRead(xmlPath))
            {
                var baseRec = xs.Deserialize(fs) as Records;
                var groups = baseRec.Items.OfType<Group>().ToDictionary(x => x.id,
                                                                        StringComparer.InvariantCultureIgnoreCase);
                foreach (var rec in baseRec.Items.OfType<RecordsRecord>())
                {
                    List<SubrecordBase> subrecords = GetSubrecordStructures(rec.Items, groups);
                    var sss = BuildSubrecordStructure(subrecords);
                    Records[rec.name] = new RecordStructure(rec, subrecords.ToArray(), sss.ToArray());
                }
            }
        }

        #endregion

        //public readonly SubrecordBase[] subrecords;
        public readonly SubrecordBase[] subrecordTree;
        public readonly SubrecordStructure[] subrecords;
        public readonly string description;
        public readonly string name;

        public override string ToString()
        {
            if (string.IsNullOrEmpty(description) && description != name)
                return name;
            return string.Format("{0}: {1}", name, description);
        }
    }
}