using LODGenerator.Common;
using System;
using System.IO;

namespace LODGenerator.NifMain
{
    public class BSShaderPPLightingProperty : NiProperty
    {
        protected ushort Flags;
        protected uint shaderType;
        protected uint shaderFlags;
        protected int unknownInt2;
        protected float envmapScale;
        protected int unknownInt3;
        protected int textureSet;
        protected float unknownFloat2;
        protected int refractionPeriod;
        protected float unknownFloat4;
        protected float unknownFloat5;

        public BSShaderPPLightingProperty()
        {
            this.Flags = 1;
            this.shaderType = 1U;
            this.shaderFlags = 8192U;
            this.unknownInt2 = 4;
            this.envmapScale = 1.0f;
            this.unknownInt3 = 0;
            this.unknownFloat2 = 0.0f;
            this.refractionPeriod = 0;
            this.unknownFloat4 = 8.0f;
            this.unknownFloat5 = 1.0f;
        }

        public override void Write(BinaryWriter writer)
        {
            base.Write(writer);
            writer.Write(this.Flags);
            writer.Write(this.shaderType);
            writer.Write(this.shaderFlags);
            writer.Write(this.unknownInt2);
            writer.Write(this.envmapScale);
            writer.Write(this.unknownInt3);
            writer.Write(this.textureSet);
            writer.Write(this.unknownFloat2);
            writer.Write(this.refractionPeriod);
            writer.Write(this.unknownFloat4);
            writer.Write(this.unknownFloat5);
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.Flags = reader.ReadUInt16();
            this.shaderType = reader.ReadUInt32();
            this.shaderFlags = reader.ReadUInt32();
            this.unknownInt2 = reader.ReadInt32();
            this.envmapScale = reader.ReadSingle();
            this.unknownInt3 = reader.ReadInt32();
            this.textureSet = reader.ReadInt32();
            this.unknownFloat2 = reader.ReadSingle();
            this.refractionPeriod = reader.ReadInt32();
            this.unknownFloat4 = reader.ReadSingle();
            this.unknownFloat5 = reader.ReadSingle();
        }

        public override uint GetSize()
        {
            return base.GetSize() + 42U;
        }

        public override string GetClassName()
        {
            return "BSShaderPPLightingProperty";
        }

        public uint GetShaderType()
        {
            return this.shaderType;
        }

        public void SetShaderType(uint value)
        {
            this.shaderType = value;
        }

        public uint GetShaderFlags()
        {
            return this.shaderFlags;
        }

        public void SetShaderFlags(uint value)
        {
            this.shaderFlags = value;
        }

        public int GetTextureSet()
        {
            return this.textureSet;
        }

        public void SetTextureSet(int value)
        {
            this.textureSet = value;
        }

        public float GetUnknownFloat2()
        {
            return this.unknownFloat2;
        }

        public void SetUnknownFloat2(float value)
        {
            this.unknownFloat2 = value;
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "BSShaderPPLightingProperty";
            return flag;
        }
    }
}
