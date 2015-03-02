using LODGenerator.Common;
using System.IO;

namespace LODGenerator.NifMain
{
    public class NiExtraData : NiObject
    {
        protected string name;
        protected int nameIdx;

        public NiExtraData()
        {
            this.name = "";
            this.nameIdx = -1;
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            if (header.GetVersion() > 335544325U)
                this.nameIdx = reader.ReadInt32();
            else
                this.name = Utils.ReadSizedString(reader);
        }

        public override uint GetSize()
        {
            return base.GetSize() + 4U;
        }

        public override string GetClassName()
        {
            return "NiExtraData";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiExtraData";
            return flag;
        }
    }
}
