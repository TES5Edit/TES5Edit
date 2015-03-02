using LODGenerator.Common;
using System.Collections.Generic;
using System.IO;

namespace LODGenerator.NifMain
{
    public class NiTexturingProperty : NiProperty
    {
        protected uint applyMode;
        protected uint textureCount;
        protected bool hasBaseTexture;
        protected TexDesc baseTexture;
        protected bool hasDarkTexture;
        protected TexDesc darkTexture;
        protected bool hasDetailTexture;
        protected TexDesc detailTexture;
        protected bool hasGlossTexture;
        protected TexDesc glossTexture;
        protected bool hasGlowTexture;
        protected TexDesc glowTexture;
        protected bool hasBumpMapTexture;
        protected TexDesc bumpMapTexture;
        protected float bumpMapLumaScale;
        protected float bumpMapLumaOffset;
        protected float[][] bumpMapMatrix;
        protected bool hasDecalTexture0;
        protected TexDesc decalTexture0;
        protected bool hasDecalTexture1;
        protected TexDesc decalTexture1;
        protected bool hasDecalTexture2;
        protected TexDesc decalTexture2;
        protected bool hasDecalTexture3;
        protected TexDesc decalTexture3;
        protected uint numShaderTextures;
        protected List<ShaderTexDesc> shaderTextures;

        public NiTexturingProperty()
        {
            this.applyMode = 0U;
            this.textureCount = 0U;
            this.hasBaseTexture = false;
            this.baseTexture = (TexDesc)null;
            this.hasDarkTexture = false;
            this.darkTexture = (TexDesc)null;
            this.hasDetailTexture = false;
            this.detailTexture = (TexDesc)null;
            this.hasGlossTexture = false;
            this.glossTexture = (TexDesc)null;
            this.hasGlowTexture = false;
            this.glowTexture = (TexDesc)null;
            this.hasBumpMapTexture = false;
            this.bumpMapTexture = (TexDesc)null;
            this.bumpMapLumaScale = 0.0f;
            this.bumpMapLumaOffset = 0.0f;
            this.bumpMapMatrix = (float[][])null;
            this.hasDecalTexture0 = false;
            this.decalTexture0 = (TexDesc)null;
            this.hasDecalTexture1 = false;
            this.decalTexture1 = (TexDesc)null;
            this.hasDecalTexture2 = false;
            this.decalTexture2 = (TexDesc)null;
            this.hasDecalTexture3 = false;
            this.decalTexture3 = (TexDesc)null;
            this.numShaderTextures = 0U;
            this.shaderTextures = new List<ShaderTexDesc>();
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.applyMode = reader.ReadUInt32();
            this.textureCount = reader.ReadUInt32();
            this.hasBaseTexture = Utils.ReadBool(reader);
            this.baseTexture = this.hasBaseTexture ? Utils.ReadTexDesc(reader) : (TexDesc)null;
            this.hasDarkTexture = Utils.ReadBool(reader);
            this.darkTexture = this.hasDarkTexture ? Utils.ReadTexDesc(reader) : (TexDesc)null;
            this.hasDetailTexture = Utils.ReadBool(reader);
            this.detailTexture = this.hasDetailTexture ? Utils.ReadTexDesc(reader) : (TexDesc)null;
            this.hasGlossTexture = Utils.ReadBool(reader);
            this.glossTexture = this.hasGlossTexture ? Utils.ReadTexDesc(reader) : (TexDesc)null;
            this.hasGlowTexture = Utils.ReadBool(reader);
            this.glowTexture = this.hasGlowTexture ? Utils.ReadTexDesc(reader) : (TexDesc)null;
            this.hasBumpMapTexture = Utils.ReadBool(reader);
            if (this.hasBumpMapTexture)
            {
                this.bumpMapTexture = Utils.ReadTexDesc(reader);
                this.bumpMapLumaScale = reader.ReadSingle();
                this.bumpMapLumaOffset = reader.ReadSingle();
                this.bumpMapMatrix = (float[][])null;
            }
            this.hasDecalTexture0 = Utils.ReadBool(reader);
            this.decalTexture0 = this.hasDecalTexture0 ? Utils.ReadTexDesc(reader) : (TexDesc)null;
            if (this.textureCount >= 8U)
            {
                this.hasDecalTexture1 = Utils.ReadBool(reader);
                this.decalTexture1 = this.hasDecalTexture1 ? Utils.ReadTexDesc(reader) : (TexDesc)null;
                if (this.textureCount >= 9U)
                {
                    this.hasDecalTexture2 = Utils.ReadBool(reader);
                    this.decalTexture2 = this.hasDecalTexture2 ? Utils.ReadTexDesc(reader) : (TexDesc)null;
                    if (this.textureCount >= 10U)
                    {
                        this.hasDecalTexture3 = Utils.ReadBool(reader);
                        this.decalTexture3 = this.hasDecalTexture3 ? Utils.ReadTexDesc(reader) : (TexDesc)null;
                    }
                }
            }
            this.numShaderTextures = reader.ReadUInt32();
            for (int index = 0; (long)index < (long)this.numShaderTextures; ++index)
                this.shaderTextures.Add(new ShaderTexDesc()
                {
                    isUsed = Utils.ReadBool(reader),
                    textureData = Utils.ReadTexDesc(reader),
                    mapIndex = reader.ReadUInt32()
                });
        }

        public override uint GetSize()
        {
            return base.GetSize();
        }

        public bool HasBaseTexture()
        {
            return this.hasBaseTexture;
        }

        public TexDesc GetBaseTextureDesc()
        {
            return this.baseTexture;
        }

        public bool HasDetailTexture()
        {
            return this.hasDetailTexture;
        }

        public TexDesc GetDetailTexture()
        {
            return this.detailTexture;
        }

        public override string GetClassName()
        {
            return "NiTexturingProperty";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiTexturingProperty";
            return flag;
        }
    }
}
