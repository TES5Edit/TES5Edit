using LODGenerator;

namespace LODGenerator.Common
{
    public class QuadTreeNode
    {
        public QuadTreeNode[] children;
        public QuadTreeLeaf leaf;
        public BBox boundingBox;

        public QuadTreeNode()
        {
            this.children = new QuadTreeNode[4];
        }
    }
}
