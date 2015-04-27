using LODGenerator;
using LODGenerator.NifMain;
using System.Collections.Generic;
using System;

namespace LODGenerator.Common
{
    public class QuadTree
    {
        public List<Vector3> vertices;
        public BBox boundingBox;
        public QuadTreeLeaf[] segments;
        public QuadTreeLeaf entirequad;
        public float sampleSize;
        public bool isLand;

        public QuadTree(NiTriShapeData data, int quadLevel)
        {
            this.sampleSize = Game.sampleSize;
            // water
            if (data.GetBSNumUVSets() == 0)
            {
                this.sampleSize = 1;
                this.isLand = false;
            }
            else
            {
                isLand = true;
            }
            this.vertices = data.GetVertices();
            this.boundingBox = new BBox();
            this.boundingBox.Set(float.MaxValue, float.MinValue, float.MaxValue, float.MinValue, float.MaxValue, float.MinValue);
            this.segments = new QuadTreeLeaf[(int)(this.sampleSize * quadLevel * this.sampleSize * quadLevel)];
            for (int index = 0; index < (this.sampleSize * quadLevel) * (this.sampleSize * quadLevel); index++)
            {
                this.segments[index] = this.CreateSegment(index, quadLevel, data.GetTriangles(), data.GetVertices());
                boundingBox.GrowByBox(this.segments[index].boundingBox);
            }
            QuadTreeLeaf quadTreeLeaf = new QuadTreeLeaf();
            List<Triangle> triangles = data.GetTriangles();
            quadTreeLeaf.boundingBox.GrowByBox(boundingBox);
            quadTreeLeaf.triangles = triangles;
            this.entirequad = quadTreeLeaf;
        }

        public List<Triangle> GetSegment(Vector3 vertex, int quadLevel)
        {
            int cursegment = 0;
            float x = vertex[0];
            float y = vertex[1];
            float z = vertex[2];
            QuadTreeLeaf quadTreeLeaf = new QuadTreeLeaf();
            quadLevel = (int)(this.sampleSize * quadLevel);
            int num1 = (int)(x / (4096 / quadLevel));
            int num2 = (int)(y / (4096 / quadLevel));
            if (num1 >= quadLevel)
                num1 = quadLevel - 1;
            if (num1 < 0)
                num1 = 0;
            if (num2 >= quadLevel)
                num2 = quadLevel - 1;
            if (num2 < 0)
                num2 = 0;
            cursegment = (quadLevel * num1) + num2;
            quadTreeLeaf = this.segments[cursegment];
            List<Triangle> triangles = new List<Triangle>();
            triangles = quadTreeLeaf.triangles;
            // x/y inside box
            if (x >= quadTreeLeaf.boundingBox.px1 && x <= quadTreeLeaf.boundingBox.px2 && y >= quadTreeLeaf.boundingBox.py1 && y <= quadTreeLeaf.boundingBox.py2)
            {
                if (isLand && z < quadTreeLeaf.boundingBox.pz1)
                {
                    // z under box
                    return null;
                }
                return triangles;
            }
            return new List<Triangle>();
            //return this.entirequad.triangles;
        }

        private QuadTreeLeaf CreateSegment(int segmentnumber, int quadLevel, List<Triangle> triangles, List<Vector3> vertices)
        {
            quadLevel = (int)(this.sampleSize * quadLevel);
            QuadTreeLeaf quadTreeLeaf = new QuadTreeLeaf();
            List<Triangle> triangles1 = new List<Triangle>();
            int segmentx = segmentnumber / quadLevel;
            int segmenty = segmentnumber - (segmentx * quadLevel);
            quadTreeLeaf.boundingBox.Set(float.MaxValue, float.MinValue, float.MaxValue, float.MinValue, float.MaxValue, float.MinValue);
            BBox bbox = new BBox();
            bbox.Set((float)segmentx / quadLevel * 4096, ((float)segmentx + 1) / quadLevel * 4096, (float)segmenty / quadLevel * 4096, ((float)segmenty + 1) / quadLevel * 4096, 0f, 0f);
            for (int index = 0; index < triangles.Count; index++)
            {
                BBox tbox = new BBox(float.MaxValue, float.MinValue, float.MaxValue, float.MinValue, float.MaxValue, float.MinValue);
                for (int index2 = 0; index2 < 3; index2++)
                {
                    Vector3 vertex = vertices[triangles[index][index2]];
                    tbox.GrowByVertex(vertex);
                }
                if (tbox.px2 >= bbox.px1 && tbox.px1 <= bbox.px2 && tbox.py2 >= bbox.py1 && tbox.py1 <= bbox.py2)
                {
                    triangles1.Add(triangles[index]);
                    quadTreeLeaf.boundingBox.GrowByBox(tbox);
                }
            }
            quadTreeLeaf.triangles = triangles1;
            return quadTreeLeaf;
        }
    }
}