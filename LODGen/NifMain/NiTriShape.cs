using System.Collections.Generic;
using System.IO;

namespace LODGenerator.NifMain
{
    public class NiTriShape : NiTriBasedGeom
    {
        public NiTriShape()
        {
        }

        public NiTriShape(NiTriBasedGeom shape)
        {
            this.name = "";
            this.nameIdx = -1;
            this.numExtraData = shape.GetNumExtraData();
            this.extraData = shape.GetExtraData();
            this.controller = shape.GetController();
            this.flags = shape.GetFlags();
            this.flags2 = shape.GetFlags2();
            this.translation = shape.GetTranslation();
            this.rotation = shape.GetRotation();
            this.scale = shape.GetScale();
            this.collisionObject = shape.GetCollisionObject();
            this.data = shape.GetData();
            this.skinInstance = shape.GetSkinInstance();
            this.numMaterials = shape.GetNumMaterials();
            this.materialNames = shape.GetMaterialNames();
            this.materialExtraData = shape.GetMaterialExtraData();
            this.activeMaterial = shape.GetActiveMaterial();
            this.dirtyFlag = shape.GetDirtyFlag();
            this.numProperties = shape.GetNumProperties();
            this.properties = new List<int>();
            for (int index = 0; (long)index < (long)this.numProperties; ++index)
                this.properties.Add(shape.GetProperty(index));
            this.bsProperties = new int[2];
            for (int index = 0; index < 2; ++index)
                this.bsProperties[index] = shape.GetBSProperty(index);
        }

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
            return "NiTriShape";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiTriShape";
            return flag;
        }
    }
}
