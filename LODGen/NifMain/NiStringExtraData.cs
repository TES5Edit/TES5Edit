using LODGenerator.Common;
using System.IO;

namespace LODGenerator.NifMain
{
    public class NiStringExtraData : NiExtraData
    {
        protected string stringData;
        protected int stringDataIdx;

        public NiStringExtraData()
        {
            this.stringData = "";
            this.stringDataIdx = -1;
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            if (header.GetVersion() > 335544325U)
                this.stringDataIdx = reader.ReadInt32();
            else
                this.stringData = Utils.ReadSizedString(reader);
        }

        public override uint GetSize()
        {
            return base.GetSize() + 4U;
        }

        public override string GetClassName()
        {
            return "NiStringExtraData";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiStringExtraData";
            return flag;
        }
    }
}
