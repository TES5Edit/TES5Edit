using System.IO;

namespace LODGenerator.NifMain
{
    public class BSXFlags : NiIntegerExtraData
    {
        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
        }

        public override string GetClassName()
        {
            return "BSXFlags";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "BSXFlags";
            return flag;
        }
    }
}
