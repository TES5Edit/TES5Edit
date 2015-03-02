using System.IO;

namespace LODGenerator.NifMain
{
    public class NiTriBasedGeom : NiGeometry
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
            return "NiTriBasedGeom";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiTriBasedGeom";
            return flag;
        }
    }
}
