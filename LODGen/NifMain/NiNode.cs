using System.Collections.Generic;
using System.IO;

namespace LODGenerator.NifMain
{
    public class NiNode : NiAVObject
    {
        protected uint numChildren;
        protected List<int> children;
        protected uint numEffects;
        protected List<int> effects;

        public NiNode()
        {
            this.numChildren = 0U;
            this.children = new List<int>();
            this.numEffects = 0U;
            this.effects = new List<int>();
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.numChildren = reader.ReadUInt32();
            for (int index = 0; (long)index < (long)this.numChildren; ++index)
                this.children.Add(reader.ReadInt32());
            this.numEffects = reader.ReadUInt32();
            for (int index = 0; (long)index < (long)this.numEffects; ++index)
                this.effects.Add(reader.ReadInt32());
        }

        public override void Write(BinaryWriter writer)
        {
            base.Write(writer);
            writer.Write(this.numChildren);
            for (int index = 0; (long)index < (long)this.numChildren; ++index)
                writer.Write(this.children[index]);
            writer.Write(this.numEffects);
            for (int index = 0; (long)index < (long)this.numEffects; ++index)
                writer.Write(this.effects[index]);
        }

        public void AddChild(int reference)
        {
            this.children.Add(reference);
            ++this.numChildren;
        }

        public int GetChildAtIndex(int index)
        {
            return this.children[index];
        }

        public uint GetNumChildren()
        {
            return this.numChildren;
        }

        public override uint GetSize()
        {
            return (uint)((int)base.GetSize() + 4 + 4 * (int)this.numChildren + 4 + 4 * (int)this.numEffects);
        }

        public override string GetClassName()
        {
            return "NiNode";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiNode";
            return flag;
        }
    }
}
