using LODGenerator.Common;
using LODGenerator.NifMain;
using System.Collections.Generic;

namespace LODGenerator
{
    public class ShapeDesc
    {
        public NiTriShape shape;
        public NiTriShapeData data;
        public string material;
        public string[] textures;
        public bool isHighDetail;
        // Shader Flags 2 SLSF2_Vertex_Colors
        public bool hasVertexColor;
        // Shader Flags 2 SLSF2_Double_Sided
        public bool isDoubleSided;
        // clamp mode for atlas
        public uint TextureClampMode;
        public BBox boundingBox;
        // relative x, y for segment
        public float x;
        public float y;
        public List<SegmentDesc> segments;

        public ShapeDesc()
        {
            this.shape = (NiTriShape)null;
            this.data = (NiTriShapeData)null;
            this.textures = new string[2];
            this.boundingBox = new BBox();
            // relative x, y for segment
            this.x = new float();
            this.y = new float();
            this.segments = new List<SegmentDesc>();
        }
    }
}
