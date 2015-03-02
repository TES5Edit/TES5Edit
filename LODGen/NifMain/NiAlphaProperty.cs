using System.IO;

namespace LODGenerator.NifMain
{
    public class NiAlphaProperty : NiProperty
    {
        private ushort flags;
        private byte threshold;

        public NiAlphaProperty()
        {
            this.flags = (ushort)236;
            this.threshold = (byte)0;
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.flags = reader.ReadUInt16();
            this.threshold = reader.ReadByte();
        }

        public override void Write(BinaryWriter writer)
        {
            base.Write(writer);
            writer.Write(this.flags);
            writer.Write(this.threshold);
        }

        public override uint GetSize()
        {
            return base.GetSize() + 3U;
        }

        public override string GetClassName()
        {
            return "NiAlphaProperty";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiAlphaProperty";
            return flag;
        }
    }
}
