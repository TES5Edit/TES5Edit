using System.IO;

namespace LODGenerator.NifMain
{
    public class BSMultiBoundData : NiObject
    {
        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
        }

        public override void Write(BinaryWriter writer)
        {
            base.Write(writer);
        }

        public override uint GetSize()
        {
            return base.GetSize();
        }

        public override string GetClassName()
        {
            return "BSMultiBoundData";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "BSMultiBoundData";
            return flag;
        }
    }
}
