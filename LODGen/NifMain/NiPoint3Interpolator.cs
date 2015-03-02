using System.Collections.Generic;
using System.IO;

namespace LODGenerator.NifMain
{
    public class NiPoint3Interpolator : NiObject
    {
        private List<byte> data;

        public NiPoint3Interpolator()
        {
            this.data = new List<byte>();
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            for (int index = 0; index < 16; ++index)
                this.data.Add(reader.ReadByte());
        }

        public override string GetClassName()
        {
            return "NiPoint3Interpolator";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiPoint3Interpolator";
            return flag;
        }
    }
}
