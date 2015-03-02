using System.Collections.Generic;
using System.IO;

namespace LODGenerator.NifMain
{
    public class NiMaterialColorController : NiObject
    {
        private List<byte> data;

        public NiMaterialColorController()
        {
            this.data = new List<byte>();
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            for (int index = 0; index < 32; ++index)
                this.data.Add(reader.ReadByte());
        }

        public override string GetClassName()
        {
            return "NiMaterialColorController";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiMaterialColorController";
            return flag;
        }
    }
}
