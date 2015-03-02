using LODGenerator;
using System.Collections.Generic;

namespace LODGenerator.Common
{
    public class QuadTreeLeaf
    {
        public List<Triangle> triangles;
        public BBox boundingBox;
    }
}
