using System.IO;

namespace LODGenerator.NifMain
{
    public class NiStencilProperty : NiProperty
    {
        protected ushort flags;
        protected byte stencilEnabled;
        protected uint stencilFunction;
        protected uint stencilRef;
        protected uint stencilMask;
        protected uint failAction;
        protected uint zFailAction;
        protected uint passAction;
        protected uint drawMode;

        public NiStencilProperty()
        {
            this.flags = 19840;
            this.stencilEnabled = (byte)0;
            this.stencilFunction = 0U;
            this.stencilRef = 0U;
            this.stencilMask = 4294967295U;
            this.failAction = 0U;
            this.zFailAction = 0U;
            this.passAction = 0U;
            this.drawMode = 0U;
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            if (header.GetVersion() <= 335544325U)
            {
                this.stencilEnabled = reader.ReadByte();
                this.stencilFunction = reader.ReadUInt32();
                this.stencilRef = reader.ReadUInt32();
                this.stencilMask = reader.ReadUInt32();
                this.failAction = reader.ReadUInt32();
                this.zFailAction = reader.ReadUInt32();
                this.passAction = reader.ReadUInt32();
                this.drawMode = reader.ReadUInt32();
            }
            if (header.GetVersion() >= 335609859U)
            {
                this.flags = reader.ReadUInt16();
                this.stencilRef = reader.ReadUInt32();
                this.stencilMask = reader.ReadUInt32();
            }
        }

        public override string GetClassName()
        {
            return "NiStencilProperty";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiStencilProperty";
            return flag;
        }
    }
}
