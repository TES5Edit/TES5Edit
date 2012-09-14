namespace TESVSnip.Domain.Data.RecordStructure
{
    using System;
    using System.Collections.Generic;
    using System.Linq;

    internal class SubrecordStructure : SubrecordBase
    {
        public readonly int CondID;

        public readonly string CondOperand;

        public readonly CondType Condition;

        public readonly bool ContainsConditionals;

        public readonly bool UseHexEditor;

        public readonly ElementStructure[] elements;

        public readonly bool notininfo;

        public readonly int size;

        /// <summary>
        /// Initializes a new instance of the <see cref="SubrecordStructure"/> class. 
        /// Clone structure with optional and repeat values overridden.
        /// </summary>
        /// <param name="src">
        /// </param>
        /// <param name="optional">
        /// </param>
        /// <param name="repeat">
        /// </param>
        public SubrecordStructure(SubrecordStructure src, int optional, int repeat)
            : base(src, optional, repeat)
        {
            this.elements = src.elements;
            this.notininfo = src.notininfo;
            this.size = src.size;
            this.Condition = src.Condition;
            this.CondID = src.CondID;
            this.CondOperand = src.CondOperand;
            this.ContainsConditionals = src.ContainsConditionals;
            this.UseHexEditor = src.UseHexEditor;
        }

        public SubrecordStructure(Subrecord node)
            : base(node)
        {
            this.notininfo = node.notininfo;
            this.size = node.size;
            this.Condition = (!string.IsNullOrEmpty(node.condition)) ? (CondType)Enum.Parse(typeof(CondType), node.condition, true) : CondType.None;
            this.CondID = node.condid;
            this.CondOperand = node.condvalue;
            this.UseHexEditor = node.usehexeditor;

            // if (optional && repeat)
            // {
            // throw new RecordXmlException("repeat and optional must both have the same value if they are non zero");
            // }
            var elements = new List<ElementStructure>();
            foreach (var elem in node.Elements)
            {
                elements.Add(new ElementStructure(elem));
            }

            this.elements = elements.ToArray();

            this.ContainsConditionals = this.elements.Count(x => x.CondID != 0) > 0;
        }
    }
}