using LODGenerator.Common;
using System.Collections.Generic;
using System.IO;

namespace LODGenerator.NifMain
{
    public class NiObjectNET : NiObject
    {
        protected int nameIdx;
        protected string name;
        protected uint numExtraData;
        protected List<int> extraData;
        protected int controller;

        public NiObjectNET()
        {
            this.nameIdx = -1;
            this.numExtraData = 0U;
            this.extraData = new List<int>();
            this.controller = -1;
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            Utils.ReadString(reader, header.GetVersion(), out this.nameIdx, out this.name);
            this.numExtraData = reader.ReadUInt32();
            for (int index = 0; (long)index < (long)this.numExtraData; ++index)
                this.extraData.Add(reader.ReadInt32());
            this.controller = reader.ReadInt32();
        }

        public override void Write(BinaryWriter writer)
        {
            base.Write(writer);
            writer.Write(this.nameIdx);
            writer.Write(this.numExtraData);
            for (int index = 0; (long)index < (long)this.numExtraData; ++index)
                writer.Write(this.extraData[index]);
            writer.Write(this.controller);
        }

        public override uint GetSize()
        {
            return (uint)((int)base.GetSize() + 12 + 4 * (int)this.numExtraData);
        }

        public override string GetClassName()
        {
            return "NiObjectNET";
        }

        public string GetName()
        {
            return this.name;
        }

        public int GetNameIndex()
        {
            return this.nameIdx;
        }

        public void SetNameIndex(int value)
        {
            this.nameIdx = value;
        }

        public uint GetNumExtraData()
        {
            return this.numExtraData;
        }

        public List<int> GetExtraData()
        {
            return this.extraData;
        }

        public int GetController()
        {
            return this.controller;
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiObjectNET";
            return flag;
        }
    }
}
