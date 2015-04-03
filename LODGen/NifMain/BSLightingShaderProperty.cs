using LODGenerator.Common;
using System;
using System.IO;

namespace LODGenerator.NifMain
{
    public class BSLightingShaderProperty : NiProperty
    {
        protected uint shaderType;
        protected uint shaderFlags1;
        protected uint shaderFlags2;
        protected UVCoord uvOffset;
        protected UVCoord uvScale;
        protected int textureSet;
        protected Color3 emissiveColor;
        protected float emissiveMultiplier;
        protected uint textureClampMode;
        protected float alpha;
        protected float unknownFloat2;
        protected float glossiness;
        protected Color3 specularColor;
        protected float specularStrength;
        protected float lightingEffect1;
        protected float lightingEffect2;
        protected float environmentMapScale;
        protected Color3 skinTintColor;
        protected Color3 hairTintColor;
        protected float maxPasses;
        protected float scale;
        protected float parallaxInnerLayerThickness;
        protected float parallaxRefractionScale;
        protected UVCoord parallaxInnerLayerTextureScale;
        protected float parallaxEnvmapStrength;
        protected Vector4 sparkleParameters;
        protected float eyeCubemapScale;
        protected Vector3 leftEyeReflectionCenter;
        protected Vector3 rightEyeReflectionCenter;

        public BSLightingShaderProperty()
        {
            this.shaderType = 0U;
            this.shaderFlags1 = 2185233152U;
            this.shaderFlags2 = 32801U;
            this.uvOffset = new UVCoord(0.0f, 0.0f);
            this.uvScale = new UVCoord(1f, 1f);
            this.textureSet = -1;
            this.emissiveColor = new Color3(0.0f, 0.0f, 0.0f);
            this.emissiveMultiplier = 1f;
            this.textureClampMode = 3U;
            this.alpha = 1f;
            this.unknownFloat2 = 0.0f;
            this.glossiness = 80f;
            this.specularColor = new Color3(1f, 1f, 1f);
            this.specularStrength = 1f;
            this.lightingEffect1 = 0.3f;
            this.lightingEffect2 = 2f;
        }

        public override void Write(BinaryWriter writer)
        {
            writer.Write(this.shaderType);
            base.Write(writer);
            writer.Write(this.shaderFlags1);
            writer.Write(this.shaderFlags2);
            Utils.WriteUVCoord(writer, this.uvOffset);
            Utils.WriteUVCoord(writer, this.uvScale);
            writer.Write(this.textureSet);
            Utils.WriteColor3(writer, this.emissiveColor);
            writer.Write(this.emissiveMultiplier);
            writer.Write(this.textureClampMode);
            writer.Write(this.alpha);
            writer.Write(this.unknownFloat2);
            writer.Write(this.glossiness);
            Utils.WriteColor3(writer, this.specularColor);
            writer.Write(this.specularStrength);
            writer.Write(this.lightingEffect1);
            writer.Write(this.lightingEffect2);
            if ((int)this.shaderType == 1)
                writer.Write(this.environmentMapScale);
            else if ((int)this.shaderType == 5)
                Utils.WriteColor3(writer, this.skinTintColor);
            else if ((int)this.shaderType == 6)
                Utils.WriteColor3(writer, this.hairTintColor);
            else if ((int)this.shaderType == 7)
            {
                writer.Write(this.maxPasses);
                writer.Write(this.scale);
            }
            else if ((int)this.shaderType == 11)
            {
                writer.Write(this.parallaxInnerLayerThickness);
                writer.Write(this.parallaxRefractionScale);
                Utils.WriteUVCoord(writer, this.parallaxInnerLayerTextureScale);
                writer.Write(this.parallaxEnvmapStrength);
            }
            else if ((int)this.shaderType == 14)
            {
                Utils.WriteVector4(writer, this.sparkleParameters);
            }
            else
            {
                if ((int)this.shaderType != 16)
                    return;
                writer.Write(this.eyeCubemapScale);
                Utils.WriteVector3(writer, this.leftEyeReflectionCenter);
                Utils.WriteVector3(writer, this.rightEyeReflectionCenter);
            }
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            this.shaderType = reader.ReadUInt32();
            base.Read(header, reader);
            this.shaderFlags1 = reader.ReadUInt32();
            this.shaderFlags2 = reader.ReadUInt32();
            this.uvOffset = Utils.ReadUVCoord(reader);
            this.uvScale = Utils.ReadUVCoord(reader);
            this.textureSet = reader.ReadInt32();
            this.emissiveColor = Utils.ReadColor3(reader);
            this.emissiveMultiplier = reader.ReadSingle();
            this.textureClampMode = reader.ReadUInt32();
            this.alpha = reader.ReadSingle();
            this.unknownFloat2 = reader.ReadSingle();
            this.glossiness = reader.ReadSingle();
            this.specularColor = Utils.ReadColor3(reader);
            this.specularStrength = reader.ReadSingle();
            this.lightingEffect1 = reader.ReadSingle();
            this.lightingEffect2 = reader.ReadSingle();
            if ((int)this.shaderType == 1)
                this.environmentMapScale = reader.ReadSingle();
            else if ((int)this.shaderType == 5)
                this.skinTintColor = Utils.ReadColor3(reader);
            else if ((int)this.shaderType == 6)
                this.hairTintColor = Utils.ReadColor3(reader);
            else if ((int)this.shaderType == 7)
            {
                this.maxPasses = reader.ReadSingle();
                this.scale = reader.ReadSingle();
            }
            else if ((int)this.shaderType == 11)
            {
                this.parallaxInnerLayerThickness = reader.ReadSingle();
                this.parallaxRefractionScale = reader.ReadSingle();
                this.parallaxInnerLayerTextureScale = Utils.ReadUVCoord(reader);
                this.parallaxEnvmapStrength = reader.ReadSingle();
            }
            else if ((int)this.shaderType == 14)
            {
                this.sparkleParameters = Utils.ReadVector4(reader);
            }
            else
            {
                if ((int)this.shaderType != 16)
                    return;
                this.eyeCubemapScale = reader.ReadSingle();
                this.leftEyeReflectionCenter = Utils.ReadVector3(reader);
                this.rightEyeReflectionCenter = Utils.ReadVector3(reader);
            }
        }

        public override uint GetSize()
        {
            uint num = base.GetSize() + 88U;
            if ((int)this.shaderType == 1)
                num += 4U;
            else if ((int)this.shaderType == 5)
                num += 12U;
            else if ((int)this.shaderType == 6)
                num += 12U;
            else if ((int)this.shaderType == 7)
                num += 8U;
            else if ((int)this.shaderType == 11)
                num += 20U;
            else if ((int)this.shaderType == 14)
                num += 16U;
            else if ((int)this.shaderType == 16)
                num += 28U;
            return num;
        }

        public override string GetClassName()
        {
            return "BSLightingShaderProperty";
        }

        public uint GetShaderType()
        {
            return this.shaderType;
        }

        public void SetShaderType(uint value)
        {
            this.shaderType = value;
        }

        public uint GetShaderFlags1()
        {
            return this.shaderFlags1;
        }

        public void SetShaderFlags1(uint value)
        {
            this.shaderFlags1 = value;
        }

        public uint GetShaderFlags2()
        {
            return this.shaderFlags2;
        }

        public void SetShaderFlags2(uint value)
        {
            this.shaderFlags2 = value;
        }

        public UVCoord GetUVOffset()
        {
            return this.uvOffset;
        }

        public void SetUVOffset(UVCoord value)
        {
            this.uvOffset = value;
        }

        public UVCoord GetUVScale()
        {
            return this.uvScale;
        }

        public void SetUVScale(UVCoord value)
        {
            this.uvScale = value;
        }

        public int GetTextureSet()
        {
            return this.textureSet;
        }

        public void SetTextureSet(int value)
        {
            this.textureSet = value;
        }

        public Color3 GetEmissiveColor()
        {
            return this.emissiveColor;
        }

        public void SetEmissiveColor(Color3 value)
        {
            this.emissiveColor = value;
        }

        public float GetEmissiveMultiplier()
        {
            return this.emissiveMultiplier;
        }

        public void SetEmissiveMultiplier(float value)
        {
            this.emissiveMultiplier = value;
        }

        public uint GetTextureClampMode()
        {
            return this.textureClampMode;
        }

        public void SetTextureClampMode(uint value)
        {
            this.textureClampMode = value;
        }

        public float GetAlpha()
        {
            return this.alpha;
        }

        public void SetAlpha(float value)
        {
            this.alpha = value;
        }

        public float GetUnknownFloat2()
        {
            return this.unknownFloat2;
        }

        public void SetUnknownFloat2(float value)
        {
            this.unknownFloat2 = value;
        }

        public float GetGlossiness()
        {
            return this.glossiness;
        }

        public void SetGlossiness(float value)
        {
            this.glossiness = value;
        }

        public Color3 GetSpecularColor()
        {
            return this.specularColor;
        }

        public void SetSpecularColor(Color3 value)
        {
            this.specularColor = value;
        }

        public float GetSpecularStrength()
        {
            return this.specularStrength;
        }

        public void SetSpecularStrength(float value)
        {
            this.specularStrength = value;
        }

        public float GetLightingEffect1()
        {
            return this.lightingEffect1;
        }

        public void SetLightingEffect1(float value)
        {
            this.lightingEffect1 = value;
        }

        public float GetLightingEffect2()
        {
            return this.lightingEffect2;
        }

        public void SetLightingEffect2(float value)
        {
            this.lightingEffect2 = value;
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "BSLightingShaderProperty";
            return flag;
        }
    }
}
