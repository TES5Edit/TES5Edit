using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TESVSnip.Collections;

namespace TESVSnip.Model
{
    class ColumnSettings
    {
        public string Type;
        public IEnumerable<ColumnCriteria> Items;
    }


    abstract class ColumnCriteria
    {
        public bool Checked { get; set; }
        public string Name { get; set; }
    }

    class ColumnSubrecord : ColumnCriteria
    {
        public SubrecordStructure Record { get; set; }
        public ICollection<ColumnElement> Children { get; set; }
    }

    class ColumnElement : ColumnCriteria
    {
        public ElementStructure Record { get; set; }
        public ColumnSubrecord Parent { get; set; }
    }
}
