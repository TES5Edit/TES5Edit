namespace TESVSnip.Domain.Data.RecordStructure
{
    using System;

    internal class ElementStructure
    {
        public readonly int CondID;

        public readonly string FormIDType;

        public readonly string desc;

        public readonly string[] flags;

        public readonly int group;

        public readonly bool hexview;

        public readonly bool multiline;

        public readonly string name;

        public readonly bool notininfo;

        public readonly bool optional;

        public readonly string[] options;

        public readonly int repeat;

        public readonly ElementValueType type;

        public ElementStructure()
        {
            this.name = "DATA";
            this.desc = "Data";
            this.@group = 0;
            this.hexview = true;
            this.notininfo = true;
            this.optional = false;
            this.options = null;
            this.flags = null;
            this.repeat = 0;
            this.CondID = 0;
            this.FormIDType = null;
            this.multiline = false;
            this.type = ElementValueType.Blob;
        }

        public ElementStructure(SubrecordElement node)
        {
            this.name = node.name;
            this.desc = node.desc;
            this.@group = node.group;
            this.hexview = node.hexview;
            this.notininfo = node.notininfo;
            this.optional = node.optional != 0;
            this.options = node.options == null ? new string[0] : node.options.Split(new[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
            this.flags = node.flags == null ? new string[0] : node.flags.Split(new[] { ';' });
            this.repeat = node.repeat;
            this.CondID = node.condid;
            if (this.optional || this.repeat > 0)
            {
                if (this.@group != 0)
                {
                    throw new RecordXmlException("Elements with a group attribute cant be marked optional or repeat");
                }
            }

            this.FormIDType = null;
            this.multiline = node.multiline;
            this.type = (ElementValueType)Enum.Parse(typeof(ElementValueType), node.type, true);
            switch (this.type)
            {
                case ElementValueType.FormID:
                    this.FormIDType = node.reftype;
                    break;
                case ElementValueType.Blob:
                    if (this.repeat > 0 || this.optional)
                    {
                        throw new RecordXmlException("blob type elements can't be marked with repeat or optional");
                    }

                    break;
            }
        }

        public override string ToString()
        {
            if (string.IsNullOrEmpty(this.desc) || this.desc == this.name)
            {
                return this.name;
            }

            return string.Format("{0}: {1}", this.name, this.desc);
        }
    }
}