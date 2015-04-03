using LODGenerator.Common;
using System;
using System.IO;

namespace LODGenerator.NifMain
{
    public class NiMaterialProperty : NiProperty
    {
        protected Color3 ambientColor;
        protected Color3 diffuseColor;
        protected Color3 specularColor;
        protected Color3 emissiveColor;
        protected float glossiness;
        protected float alpha;
        protected float emitMulti;

        public NiMaterialProperty()
        {
            this.ambientColor = new Color3(0.0f, 0.0f, 0.0f);
            this.diffuseColor = new Color3(0.0f, 0.0f, 0.0f);
            this.specularColor = new Color3(0.0f, 0.0f, 0.0f);
            this.emissiveColor = new Color3(0.0f, 0.0f, 0.0f);
            this.glossiness = 1f;
            this.alpha = 1f;
            this.emitMulti = 1f;
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            if (!((header.GetVersion() == 335675399U) && (header.GetUserVersion() >= 11) && (header.GetUserVersion2() > 21)))
            {
                this.ambientColor = Utils.ReadColor3(reader);
                this.diffuseColor = Utils.ReadColor3(reader);
            }
            this.specularColor = Utils.ReadColor3(reader);
            this.emissiveColor = Utils.ReadColor3(reader);
            this.glossiness = reader.ReadSingle();
            this.alpha = reader.ReadSingle();
            if ((header.GetVersion() == 335675399U) && (header.GetUserVersion() >= 11) && (header.GetUserVersion2() > 21))
            {
                this.emitMulti = reader.ReadSingle();
            }
        }

        public override uint GetSize()
        {
            return base.GetSize() + 56U;
        }

        public override string GetClassName()
        {
            return "NiMaterialProperty";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiMaterialProperty";
            return flag;
        }
    }
}
