using System.IO;

namespace LODGenerator.NifMain
{
    public class BSMultiBoundNode : NiNode
    {
        protected int multiBound;
        protected uint cullMode;

        public BSMultiBoundNode()
        {
            this.multiBound = -1;
            this.cullMode = 0U;
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.multiBound = reader.ReadInt32();
            this.cullMode = reader.ReadUInt32();
        }

        public override void Write(BinaryWriter writer)
        {
            base.Write(writer);
            writer.Write(this.multiBound);
            writer.Write(this.cullMode);
        }

        public override uint GetSize()
        {
            return base.GetSize() + 8U;
        }

        public override string GetClassName()
        {
            return "BSMultiBoundNode";
        }

        public int GetMultiBound()
        {
            return this.multiBound;
        }

        public void SetMultiBound(int value)
        {
            this.multiBound = value;
        }

        public uint GetCullMode()
        {
            return this.cullMode;
        }

        public void SetCullMode(uint value)
        {
            this.cullMode = value;
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "BSMultiBoundNode";
            return flag;
        }
    }
}
