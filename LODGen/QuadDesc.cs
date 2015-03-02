using LODGenerator.Common;
using System.Collections.Generic;

namespace LODGenerator
{
    public struct QuadDesc
    {
        public int x;
        public int y;
        public List<StaticDesc> statics;
        public QuadTree terrainQuadTree;
        public QuadTree waterQuadTree;
        public bool hasTerrainVertices;
        public BBox boundingBox;
        public OutDesc outValues;

        public override string ToString()
        {
            return "(" + (object)this.x.ToString() + ", " + this.y.ToString() + "): " + (string)(object)this.statics.Count + " statics";
        }
    }
}
