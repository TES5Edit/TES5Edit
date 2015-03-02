using LODGenerator.Common;
using System.IO;

namespace LODGenerator.NifMain
{
    public class BSMultiBoundAABB : BSMultiBoundData
    {
        protected Vector3 position;
        protected Vector3 extent;

        public BSMultiBoundAABB()
        {
            this.position = new Vector3();
            this.extent = new Vector3();
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.position = Utils.ReadVector3(reader);
            this.extent = Utils.ReadVector3(reader);
        }

        public override void Write(BinaryWriter writer)
        {
            base.Write(writer);
            Utils.WriteVector3(writer, this.position);
            Utils.WriteVector3(writer, this.extent);
        }

        public override uint GetSize()
        {
            return base.GetSize() + 24U;
        }

        public override string GetClassName()
        {
            return "BSMultiBoundAABB";
        }

        public Vector3 GetPosition()
        {
            return this.position;
        }

        public void SetPosition(Vector3 value)
        {
            this.position = value;
        }

        public Vector3 GetExtent()
        {
            return this.extent;
        }

        public void SetExtent(Vector3 value)
        {
            this.extent = value;
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "BSMultiBoundAABB";
            return flag;
        }
    }
}
