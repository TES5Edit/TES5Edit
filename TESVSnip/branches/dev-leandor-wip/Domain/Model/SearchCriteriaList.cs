namespace TESVSnip.Domain.Model
{
    using System.Collections;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Xml.Serialization;

    [XmlRoot("SearchCriteria", Namespace = "", IsNullable = false)]
    public class SearchCriteriaList
    {
        [XmlElement("Search", typeof(SearchCriteriaXmlSettings))]
        public List<SearchCriteriaXmlSettings> Settings = new List<SearchCriteriaXmlSettings>();

        public static SearchCriteriaList Deserialize(Stream stream)
        {
            try
            {
                var xs = new XmlSerializer(typeof(SearchCriteriaList));
                return xs.Deserialize(stream) as SearchCriteriaList;
            }
            catch
            {
            }

            return null;
        }

        public static bool Serialize(Stream stream, SearchCriteriaList items)
        {
            try
            {
                var xs = new XmlSerializer(typeof(SearchCriteriaList));
                xs.Serialize(stream, items);
                return true;
            }
            catch
            {
            }

            return false;
        }

        public static bool Serialize(Stream stream, IEnumerable<SearchCriteriaXmlSettings> items)
        {
            try
            {
                var list = new SearchCriteriaList { Settings = items.ToList() };
                var xs = new XmlSerializer(typeof(SearchCriteriaList));
                xs.Serialize(stream, list);
                return true;
            }
            catch
            {
            }

            return false;
        }

        internal static SearchCriteriaXmlSettings ToXml(SearchCriteriaSettings setting)
        {
            var criteria = new ArrayList();
            foreach (var child in setting.Items.OfType<SearchSubrecord>().Where(x => x.Checked))
            {
                criteria.Add(new SearchSubrecordXml { SubRecord = child.Record.name, Type = child.Type });
            }

            foreach (var elem in setting.Items.OfType<SearchElement>().Where(x => x.Checked))
            {
                var par = elem.Parent;
                criteria.Add(new SearchElementXml { SubRecord = par.Record.name, Element = elem.Record.name, Type = elem.Type, Value = elem.Value != null ? elem.Value.ToString() : null });
            }

            return new SearchCriteriaXmlSettings { Name = setting.ToString(), Type = setting.Type, Items = criteria.ToArray() };
        }
    }
}