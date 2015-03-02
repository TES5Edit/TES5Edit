using System.Collections.Generic;
using System.IO;

namespace LODGenerator.NifMain
{
    public class NiBinaryExtraData : NiExtraData
    {
        protected uint binarySize;
        protected List<byte> binaryData;

        public NiBinaryExtraData()
        {
            this.binarySize = 0U;
            this.binaryData = new List<byte>();
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.binarySize = reader.ReadUInt32();
            for (int index = 0; (long)index < (long)this.binarySize; ++index)
                this.binaryData.Add(reader.ReadByte());
        }

        public override uint GetSize()
        {
            return (uint)((int)base.GetSize() + 4 + this.binaryData.Count);
        }

        public override string GetClassName()
        {
            return "NiBinaryExtraData";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiBinaryExtraData";
            return flag;
        }
    }
}
