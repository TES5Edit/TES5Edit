using LODGenerator;
using LODGenerator.NifMain;
using System.Collections.Generic;

namespace LODGenerator.Common
{
    public class QuadTree
    {
        public List<Vector3> vertices;
        public QuadTreeNode[] nodes;

        public QuadTree(NiTriShapeData data, BBox boundingBox)
        {
            this.nodes = new QuadTreeNode[4];
            this.vertices = data.GetVertices();
            BBox boundingBox1 = new BBox();
            BBox boundingBox2 = new BBox();
            BBox boundingBox3 = new BBox();
            BBox boundingBox4 = new BBox();
            float num1 = (float)(((double)boundingBox.px2 - (double)boundingBox.px1) / 2.0);
            float num2 = (float)(((double)boundingBox.py2 - (double)boundingBox.py1) / 2.0);
            boundingBox1.Set(boundingBox.px1, boundingBox.px1 + num1, boundingBox.py1, boundingBox.py1 + num2, 0.0f, 0.0f);
            boundingBox2.Set(boundingBox.px1 + num1, boundingBox.px2, boundingBox.py1, boundingBox.py1 + num2, 0.0f, 0.0f);
            boundingBox3.Set(boundingBox.px1, boundingBox.px1 + num1, boundingBox.py1 + num2, boundingBox.py2, 0.0f, 0.0f);
            boundingBox4.Set(boundingBox.px1 + num1, boundingBox.px2, boundingBox.py1 + num2, boundingBox.py2, 0.0f, 0.0f);
            this.nodes[0] = this.CreateQuadNode(data.GetTriangles(), data.GetVertices(), boundingBox1);
            this.nodes[1] = this.CreateQuadNode(data.GetTriangles(), data.GetVertices(), boundingBox2);
            this.nodes[2] = this.CreateQuadNode(data.GetTriangles(), data.GetVertices(), boundingBox3);
            this.nodes[3] = this.CreateQuadNode(data.GetTriangles(), data.GetVertices(), boundingBox4);
        }

        private QuadTreeLeaf CreateQuadLeaf(List<Triangle> tris, BBox boundingBox)
        {
            return new QuadTreeLeaf()
            {
                triangles = tris,
                boundingBox = boundingBox
            };
        }

        private QuadTreeNode CreateQuadNode(List<Triangle> tris, List<Vector3> verts, BBox boundingBox)
        {
            List<Triangle> tris1 = new List<Triangle>();
            QuadTreeNode quadTreeNode = new QuadTreeNode();
            for (int index = 0; index < tris.Count; ++index)
            {
                Triangle triangle = tris[index];
                Vector3 vector3_1 = verts[(int)triangle[0]];
                Vector3 vector3_2 = verts[(int)triangle[1]];
                Vector3 vector3_3 = verts[(int)triangle[2]];
                Vector3 vector3_4 = (vector3_1 + vector3_2 + vector3_3) / 3f;
                if ((double)vector3_1[0] > (double)boundingBox.px1 && (double)vector3_1[0] < (double)boundingBox.px2 && ((double)vector3_1[1] > (double)boundingBox.py1 && (double)vector3_1[1] < (double)boundingBox.py2))
                    tris1.Add(triangle);
                if ((double)vector3_2[0] > (double)boundingBox.px1 && (double)vector3_2[0] < (double)boundingBox.px2 && ((double)vector3_2[1] > (double)boundingBox.py1 && (double)vector3_2[1] < (double)boundingBox.py2))
                    tris1.Add(triangle);
                if ((double)vector3_3[0] > (double)boundingBox.px1 && (double)vector3_3[0] < (double)boundingBox.px2 && ((double)vector3_3[1] > (double)boundingBox.py1 && (double)vector3_3[1] < (double)boundingBox.py2))
                    tris1.Add(triangle);
            }
            if (tris1.Count > 50)
            {
                BBox boundingBox1 = new BBox();
                BBox boundingBox2 = new BBox();
                BBox boundingBox3 = new BBox();
                BBox boundingBox4 = new BBox();
                float num1 = (float)(((double)boundingBox.px2 - (double)boundingBox.px1) / 2.0);
                float num2 = (float)(((double)boundingBox.py2 - (double)boundingBox.py1) / 2.0);
                boundingBox1.Set(boundingBox.px1, boundingBox.px1 + num1, boundingBox.py1, boundingBox.py1 + num2, 0.0f, 0.0f);
                boundingBox2.Set(boundingBox.px1 + num1, boundingBox.px2, boundingBox.py1, boundingBox.py1 + num2, 0.0f, 0.0f);
                boundingBox3.Set(boundingBox.px1, boundingBox.px1 + num1, boundingBox.py1 + num2, boundingBox.py2, 0.0f, 0.0f);
                boundingBox4.Set(boundingBox.px1 + num1, boundingBox.px2, boundingBox.py1 + num2, boundingBox.py2, 0.0f, 0.0f);
                quadTreeNode.children[0] = this.CreateQuadNode(tris, verts, boundingBox1);
                quadTreeNode.children[1] = this.CreateQuadNode(tris, verts, boundingBox2);
                quadTreeNode.children[2] = this.CreateQuadNode(tris, verts, boundingBox3);
                quadTreeNode.children[3] = this.CreateQuadNode(tris, verts, boundingBox4);
                quadTreeNode.boundingBox = boundingBox;
            }
            else
            {
                quadTreeNode.boundingBox = boundingBox;
                quadTreeNode.leaf = this.CreateQuadLeaf(tris1, boundingBox);
            }
            return quadTreeNode;
        }

        private QuadTreeLeaf FindLeaf(QuadTreeNode node, Vector3 pt)
        {
            if (node.leaf != null)
                return node.leaf;
            QuadTreeLeaf quadTreeLeaf = (QuadTreeLeaf)null;
            if ((double)pt[0] > (double)node.children[0].boundingBox.px1 && (double)pt[0] < (double)node.children[0].boundingBox.px2 && ((double)pt[1] > (double)node.children[0].boundingBox.py1 && (double)pt[1] < (double)node.children[0].boundingBox.py2))
                quadTreeLeaf = this.FindLeaf(node.children[0], pt);
            if ((double)pt[0] > (double)node.children[1].boundingBox.px1 && (double)pt[0] < (double)node.children[1].boundingBox.px2 && ((double)pt[1] > (double)node.children[1].boundingBox.py1 && (double)pt[1] < (double)node.children[1].boundingBox.py2))
                quadTreeLeaf = this.FindLeaf(node.children[1], pt);
            if ((double)pt[0] > (double)node.children[2].boundingBox.px1 && (double)pt[0] < (double)node.children[2].boundingBox.px2 && ((double)pt[1] > (double)node.children[2].boundingBox.py1 && (double)pt[1] < (double)node.children[2].boundingBox.py2))
                quadTreeLeaf = this.FindLeaf(node.children[2], pt);
            if ((double)pt[0] > (double)node.children[3].boundingBox.px1 && (double)pt[0] < (double)node.children[3].boundingBox.px2 && ((double)pt[1] > (double)node.children[3].boundingBox.py1 && (double)pt[1] < (double)node.children[3].boundingBox.py2))
                quadTreeLeaf = this.FindLeaf(node.children[3], pt);
            return quadTreeLeaf;
        }

        public QuadTreeLeaf FindLeaf(Vector3 pt)
        {
            QuadTreeLeaf quadTreeLeaf = (QuadTreeLeaf)null;
            if ((double)pt[0] > (double)this.nodes[0].boundingBox.px1 && (double)pt[0] < (double)this.nodes[0].boundingBox.px2 && ((double)pt[1] > (double)this.nodes[0].boundingBox.py1 && (double)pt[1] < (double)this.nodes[0].boundingBox.py2))
                quadTreeLeaf = this.FindLeaf(this.nodes[0], pt);
            if ((double)pt[0] > (double)this.nodes[1].boundingBox.px1 && (double)pt[0] < (double)this.nodes[1].boundingBox.px2 && ((double)pt[1] > (double)this.nodes[1].boundingBox.py1 && (double)pt[1] < (double)this.nodes[1].boundingBox.py2))
                quadTreeLeaf = this.FindLeaf(this.nodes[1], pt);
            if ((double)pt[0] > (double)this.nodes[2].boundingBox.px1 && (double)pt[0] < (double)this.nodes[2].boundingBox.px2 && ((double)pt[1] > (double)this.nodes[2].boundingBox.py1 && (double)pt[1] < (double)this.nodes[2].boundingBox.py2))
                quadTreeLeaf = this.FindLeaf(this.nodes[2], pt);
            if ((double)pt[0] > (double)this.nodes[3].boundingBox.px1 && (double)pt[0] < (double)this.nodes[3].boundingBox.px2 && ((double)pt[1] > (double)this.nodes[3].boundingBox.py1 && (double)pt[1] < (double)this.nodes[3].boundingBox.py2))
                quadTreeLeaf = this.FindLeaf(this.nodes[3], pt);
            return quadTreeLeaf;
        }
    }
}
