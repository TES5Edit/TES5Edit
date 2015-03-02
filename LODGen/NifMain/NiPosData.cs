using System.Collections.Generic;
using System.IO;

namespace LODGenerator.NifMain
{
    public class NiPosData : NiObject
    {
        private List<byte> data;

        public NiPosData()
        {
            this.data = new List<byte>();
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            uint num1 = reader.ReadUInt32();
            uint num2 = reader.ReadUInt32();
            for (int index = 0; (long)index < (long)num1; ++index)
            {
                double num3 = (double)reader.ReadSingle();
                double num4 = (double)reader.ReadSingle();
                double num5 = (double)reader.ReadSingle();
                double num6 = (double)reader.ReadSingle();
                if ((int)num2 == 2)
                {
                    double num7 = (double)reader.ReadSingle();
                    double num8 = (double)reader.ReadSingle();
                    double num9 = (double)reader.ReadSingle();
                    double num10 = (double)reader.ReadSingle();
                    double num11 = (double)reader.ReadSingle();
                    double num12 = (double)reader.ReadSingle();
                }
                else if ((int)num2 == 3)
                {
                    double num7 = (double)reader.ReadSingle();
                    double num8 = (double)reader.ReadSingle();
                    double num9 = (double)reader.ReadSingle();
                }
            }
        }

        public override string GetClassName()
        {
            return "NiPosData";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiPosData";
            return flag;
        }
    }
}
