using System.Collections.Generic;
using System.IO;

namespace LODGenerator.NifMain
{
    public class BSSegmentedTriShape : NiTriShape
    {
        protected int numSegments;
        protected List<BSSegment> segments;

        public BSSegmentedTriShape()
        {
            this.numSegments = 0;
            this.segments = new List<BSSegment>();
        }

        public BSSegmentedTriShape(NiGeometry shape)
        {
            this.nameIdx = shape.GetNameIndex();
            this.numExtraData = 0U;
            this.extraData = new List<int>();
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
            this.bsProperties = new int[2];
            for (int index = 0; index < 2; ++index)
                this.bsProperties[index] = shape.GetBSProperty(index);
            this.numSegments = 0;
            this.segments = new List<BSSegment>();
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.numSegments = reader.ReadInt32();
            for (int index = 0; index < this.numSegments; ++index)
                this.segments.Add(new BSSegment(0U, (ushort)0)
                {
                    unknownByte1 = reader.ReadByte(),
                    startTriangle = reader.ReadUInt32(),
                    numTriangles = reader.ReadUInt16(),
                    unknownShort1 = reader.ReadUInt16()
                });
        }

        public override void Write(BinaryWriter writer)
        {
            base.Write(writer);
            writer.Write(this.numSegments);
            for (int index = 0; index < this.numSegments; ++index)
            {
                writer.Write(this.segments[index].unknownByte1);
                writer.Write(this.segments[index].startTriangle);
                writer.Write(this.segments[index].numTriangles);
                writer.Write(this.segments[index].unknownShort1);
            }
        }

        public override uint GetSize()
        {
            return (uint)((int)base.GetSize() + 4 + this.numSegments * 9);
        }

        public override string GetClassName()
        {
            return "BSSegmentedTriShape";
        }

        public int GetNumSegments()
        {
            return this.numSegments;
        }

        public List<BSSegment> GetSegments()
        {
            return this.segments;
        }

        public BSSegment GetSegmentAtIndex(int index)
        {
            return this.segments[index];
        }

        public void SetSegment(int index, BSSegment segment)
        {
            this.segments[index] = segment;
        }

        public void AddSegment(BSSegment segment)
        {
            ++this.numSegments;
            this.segments.Add(segment);
        }

        public void RemoveSegment(int index)
        {
            this.segments.RemoveAt(index);
            --this.numSegments;
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "BSSegmentedTriShape";
            return flag;
        }
    }
}
