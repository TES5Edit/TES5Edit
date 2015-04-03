using LODGenerator.Common;
using System;
using System.IO;

namespace LODGenerator.NifMain
{
    public class BSEffectShaderProperty : NiProperty
    {
        protected uint shaderFlags1;
        protected uint shaderFlags2;
        protected UVCoord uvOffset;
        protected UVCoord uvScale;
        protected string sourceTexture;
        protected uint textureClampMode;
        protected float falloffStartAngle;
        protected float falloffStopAngle;
        protected float falloffStartOpacity;
        protected float falloffStopOpacity;
        protected Color4 emissiveColor;
        protected float emissiveMultiple;
        protected float softFalloffDepth;
        protected string greyscaleTexture;

        public BSEffectShaderProperty()
        {
            this.shaderFlags1 = 0U;
            this.shaderFlags2 = 0U;
            this.uvOffset = new UVCoord(0.0f, 0.0f);
            this.uvScale = new UVCoord(1f, 1f);
            this.sourceTexture = "";
            this.textureClampMode = 0U;
            this.falloffStartAngle = 0.0f;
            this.falloffStopAngle = 0.0f;
            this.falloffStartOpacity = 1f;
            this.falloffStopOpacity = 1f;
            this.emissiveColor = new Color4(0.0f, 0.0f, 0.0f, 0.0f);
            this.emissiveMultiple = 1f;
            this.softFalloffDepth = 0.0f;
            this.greyscaleTexture = "";
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.shaderFlags1 = reader.ReadUInt32();
            this.shaderFlags2 = reader.ReadUInt32();
            this.uvOffset = Utils.ReadUVCoord(reader);
            this.uvScale = Utils.ReadUVCoord(reader);
            this.sourceTexture = Utils.ReadSizedString(reader);
            this.textureClampMode = reader.ReadUInt32();
            this.falloffStartAngle = reader.ReadSingle();
            this.falloffStopAngle = reader.ReadSingle();
            this.falloffStartOpacity = reader.ReadSingle();
            this.falloffStopOpacity = reader.ReadSingle();
            this.emissiveColor = Utils.ReadColor4(reader);
            this.emissiveMultiple = reader.ReadSingle();
            this.softFalloffDepth = reader.ReadSingle();
            this.greyscaleTexture = Utils.ReadSizedString(reader);
        }

        public string GetSourceTexture()
        {
            return this.sourceTexture;
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "BSEffectShaderProperty";
            return flag;
        }

        // get ShaderFlags2;
        public uint GetShaderFlags1()
        {
            return this.shaderFlags1;
        }

        // get ShaderFlags2;
        public uint GetShaderFlags2()
        {
            return this.shaderFlags2;
        }

        // get ClampMode;
        public uint GetTextureClampMode()
        {
            return this.textureClampMode;
        }
    }
}
