using System.IO;

namespace LODGenerator.NifMain
{
    public class BSLODTriShape : NiTriBasedGeom
    {
        protected uint level0Size;
        protected uint level1Size;
        protected uint level2Size;

        public BSLODTriShape()
        {
            this.level0Size = 0U;
            this.level1Size = 0U;
            this.level2Size = 0U;
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.level0Size = reader.ReadUInt32();
            this.level1Size = reader.ReadUInt32();
            this.level2Size = reader.ReadUInt32();
        }

        public override string GetClassName()
        {
            return "BSLODTriShape";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "BSLODTriShape";
            return flag;
        }
    }
}
