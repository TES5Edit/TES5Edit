using System.IO;

namespace LODGenerator.NifMain
{
    public class NiTexture : NiObjectNET
    {
        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
        }

        public override uint GetSize()
        {
            return base.GetSize();
        }

        public override string GetClassName()
        {
            return "NiTexture";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiTexture";
            return flag;
        }
    }
}
