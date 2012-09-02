namespace TESVSnip.Domain.Model
{
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;

    internal class SearchCriteriaSettings
    {
        public IEnumerable<SearchCriteria> Items;

        public string Type;

        public static string GetDisplayString(SearchCondRecordType type)
        {
            switch (type)
            {
                case SearchCondRecordType.Exists:
                    return "Exists";
                case SearchCondRecordType.Missing:
                    return "Missing";
            }

            return string.Empty;
        }

        public static string GetFormatString(SearchCondElementType type)
        {
            switch (type)
            {
                case SearchCondElementType.Equal:
                    return "{0} = {1}";
                case SearchCondElementType.Not:
                    return "Not {0}";
                case SearchCondElementType.Greater:
                    return "{0} > {1}";
                case SearchCondElementType.Less:
                    return "{0} < {1}";
                case SearchCondElementType.GreaterEqual:
                    return "{0} >= {1}";
                case SearchCondElementType.LessEqual:
                    return "{0} <= {1}";
                case SearchCondElementType.StartsWith:
                    return "{0} like '{1}%'";
                case SearchCondElementType.EndsWith:
                    return "{0} like '%{1}'";
                case SearchCondElementType.Contains:
                    return "{0} like '%{1}%'";
                case SearchCondElementType.Exists:
                    return "{0} Exists";
                case SearchCondElementType.Missing:
                    return "{0} Missing";
            }

            return string.Empty;
        }

        public override string ToString()
        {
            var sb = new StringBuilder();
            sb.AppendFormat("({0}) ", this.Type);

            foreach (var kvp in this.Items.GroupBy(
                x => {
                    if (x is SearchSubrecord)
                    {
                        return ((SearchSubrecord)x).Record;
                    }

                    if (x is SearchElement)
                    {
                        return ((SearchElement)x).Parent.Record;
                    }

                    return null;
                }))
            {
                if (kvp.Key == null)
                {
                    continue;
                }

                sb.AppendFormat("[{0}: ", kvp.Key.name);
                bool first = true;
                foreach (var item in kvp.OfType<SearchSubrecord>())
                {
                    if (!first)
                    {
                        sb.Append(",");
                    }

                    sb.Append(item.Type.ToString());
                    first = false;
                }

                foreach (var item in kvp.OfType<SearchElement>())
                {
                    if (!first)
                    {
                        sb.Append(" && ");
                    }

                    sb.AppendFormat(GetFormatString(item.Type), item.Name, item.Value);
                    first = false;
                }

                sb.Append("]");
            }

            return sb.ToString();
        }
    }
}