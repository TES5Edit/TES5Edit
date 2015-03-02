using System.IO;

namespace LODGenerator.NifMain
{
    public class NiProperty : NiObjectNET
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
            return "NiProperty";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiProperty";
            return flag;
        }
    }
}
