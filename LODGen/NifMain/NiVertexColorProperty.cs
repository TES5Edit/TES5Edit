using System.IO;

namespace LODGenerator.NifMain
{
    public class NiVertexColorProperty : NiProperty
    {
        protected ushort flags;
        protected uint vertexMode;
        protected uint lightingMode;

        public NiVertexColorProperty()
        {
            this.flags = (ushort)0;
            this.vertexMode = 0U;
            this.lightingMode = 0U;
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.flags = reader.ReadUInt16();
            this.vertexMode = reader.ReadUInt32();
            this.lightingMode = reader.ReadUInt32();
        }

        public override string GetClassName()
        {
            return "NiVertexColorProperty";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiVertexColorProperty";
            return flag;
        }
    }
}
