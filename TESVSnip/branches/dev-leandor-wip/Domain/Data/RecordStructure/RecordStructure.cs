namespace TESVSnip.Domain.Data.RecordStructure
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Xml.Serialization;

    using TESVSnip.Domain.Services;

    internal class RecordStructure
    {
        public static Dictionary<string, RecordStructure> Records = new Dictionary<string, RecordStructure>(StringComparer.InvariantCultureIgnoreCase);

        private static readonly string xmlPath = Path.Combine(Options.Value.SettingsDirectory, @"RecordStructure.xml");

        private static bool loaded;

        public readonly string description;

        public readonly string name;

        public readonly SubrecordBase[] subrecordTree;

        public readonly SubrecordStructure[] subrecords;

        private RecordStructure(RecordsRecord rec, SubrecordBase[] subrecordTree, SubrecordStructure[] subrecords)
        {
            this.name = rec.name;
            this.description = rec.desc;
            this.subrecordTree = subrecordTree;
            this.subrecords = subrecords;
        }

        public static bool Loaded
        {
            get
            {
                return loaded;
            }
        }

        public static void Load()
        {
            if (loaded)
            {
                Records.Clear();
            }
            else
            {
                loaded = true;
            }

            var xs = new XmlSerializer(typeof(Records));
            using (FileStream fs = File.OpenRead(xmlPath))
            {
                var baseRec = xs.Deserialize(fs) as Records;
                var groups = baseRec.Items.OfType<Group>().ToDictionary(x => x.id, StringComparer.InvariantCultureIgnoreCase);
                foreach (var rec in baseRec.Items.OfType<RecordsRecord>())
                {
                    List<SubrecordBase> subrecords = GetSubrecordStructures(rec.Items, groups);
                    var sss = BuildSubrecordStructure(subrecords);
                    Records[rec.name] = new RecordStructure(rec, subrecords.ToArray(), sss.ToArray());
                }
            }
        }

        public override string ToString()
        {
            if (string.IsNullOrEmpty(this.description) && this.description != this.name)
            {
                return this.name;
            }

            return string.Format("{0}: {1}", this.name, this.description);
        }

        /// <summary>
        /// Build the Subrecord array with groups expanded.
        /// </summary>
        /// <param name="list">
        /// The list.
        /// </param>
        /// <returns>
        /// The System.Collections.Generic.List`1[T -&gt; TESVSnip.SubrecordStructure].
        /// </returns>
        private static List<SubrecordStructure> BuildSubrecordStructure(IEnumerable<SubrecordBase> list)
        {
            var subrecords = new List<SubrecordStructure>();
            foreach (var sr in list)
            {
                if (sr is SubrecordStructure)
                {
                    subrecords.Add((SubrecordStructure)sr);
                }
                else if (sr is SubrecordGroup)
                {
                    var sg = sr as SubrecordGroup;
                    List<SubrecordStructure> sss = BuildSubrecordStructure(sg.elements);
                    if (sss.Count > 0)
                    {
                        if (sg.repeat > 0)
                        {
                            sss[0] = new SubrecordStructure(sss[0], sss.Count, sss.Count); // replace
                        }
                        else if (sg.optional > 0)
                        {
                            sss[0] = new SubrecordStructure(sss[0], sss.Count, 0); // optional
                        }
                    }

                    subrecords.AddRange(sss);
                }
            }

            return subrecords;
        }

        private static List<SubrecordBase> GetSubrecordStructures(ICollection items, Dictionary<string, Group> dict)
        {
            var subrecords = new List<SubrecordBase>();
            foreach (var sr in items)
            {
                if (sr is Subrecord)
                {
                    subrecords.Add(new SubrecordStructure((Subrecord)sr));
                }
                else if (sr is Group)
                {
                    var g = sr as Group;
                    var ssr = GetSubrecordStructures((g.Items.Count > 0) ? g.Items : dict[g.id].Items, dict);
                    if (ssr.Count > 0)
                    {
                        // if (!ssr[0].IsGroup && (ssr[0].optional || ssr[0].repeat))
                        // {
                        // throw new RecordXmlException("repeat and optional cannot be specified on first subrecord of a group");
                        // }
                        subrecords.Add(new SubrecordGroup(g, ssr.ToArray()));
                    }
                }
            }

            return subrecords;
        }
    }
}
