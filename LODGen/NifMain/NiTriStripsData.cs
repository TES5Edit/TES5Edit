using LODGenerator.Common;
using System.Collections.Generic;
using System.IO;

namespace LODGenerator.NifMain
{
    public class NiTriStripsData : NiTriBasedGeomData
    {
        protected ushort numStrips;
        protected List<ushort> stripLengths;
        protected bool hasPoints;
        protected List<List<ushort>> points;

        public NiTriStripsData()
        {
            this.numStrips = (ushort)0;
            this.stripLengths = new List<ushort>();
            this.hasPoints = false;
            this.points = new List<List<ushort>>();
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.numStrips = reader.ReadUInt16();
            for (int index = 0; index < (int)this.numStrips; ++index)
                this.stripLengths.Add(reader.ReadUInt16());
            this.hasPoints = Utils.ReadBool(reader);
            if (!this.hasPoints)
                return;
            for (int index1 = 0; index1 < (int)this.numStrips; ++index1)
            {
                this.points.Add(new List<ushort>());
                for (int index2 = 0; index2 < (int)this.stripLengths[index1]; ++index2)
                    this.points[index1].Add(reader.ReadUInt16());
            }
        }

        public ushort GetNumStrips()
        {
            return this.numStrips;
        }

        public List<ushort> GetStripLengths()
        {
            return this.stripLengths;
        }

        public bool HasPoints()
        {
            return this.hasPoints;
        }

        public ushort GetStripLengthAtIndex(int index)
        {
            return this.stripLengths[index];
        }

        public List<ushort> GetPointsAtIndex(int index)
        {
            return this.points[index];
        }

        public override uint GetSize()
        {
            return base.GetSize();
        }

        public override string GetClassName()
        {
            return "NiTriStripsData";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiTriStripsData";
            return flag;
        }
    }
}
