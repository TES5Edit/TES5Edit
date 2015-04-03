using LODGenerator.Common;
using System;
using System.Collections.Generic;
using System.IO;

namespace LODGenerator.NifMain
{
    internal class BSShaderTextureSet : NiObject
    {
        protected int numTextures;
        protected List<string> textures;

        public BSShaderTextureSet()
        {
            this.numTextures = 0;
            this.textures = new List<string>();
        }

        public BSShaderTextureSet(int value)
        {
            this.numTextures = value;
            this.textures = new List<string>(this.numTextures);
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.numTextures = reader.ReadInt32();
            for (int index = 0; index < this.numTextures; ++index)
                this.textures.Add(Utils.ReadSizedString(reader));
        }

        public override void Write(BinaryWriter writer)
        {
            base.Write(writer);
            writer.Write(this.numTextures);
            for (int index = 0; index < this.numTextures; ++index)
                Utils.WriteSizedString(writer, this.textures[index]);
        }

        public override uint GetSize()
        {
            uint num = base.GetSize() + 4U;
            for (int index = 0; index < this.numTextures; ++index)
                num += (uint)(4 + this.textures[index].Length);
            return num;
        }

        public int GetNumTextures()
        {
            return this.numTextures;
        }

        public void SetNumTextures(int value)
        {
            this.numTextures = value;
            if (this.numTextures <= this.textures.Count)
                return;
            for (int count = this.textures.Count; count < this.numTextures; ++count)
                this.textures.Add("");
        }

        public string GetTexture(int index)
        {
            return this.textures[index];
        }

        public void SetTexture(int index, string texture)
        {
            this.textures[index] = texture;
        }

        public override string GetClassName()
        {
            return "BSShaderTextureSet";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "BSShaderTextureSet";
            return flag;
        }
    }
}
