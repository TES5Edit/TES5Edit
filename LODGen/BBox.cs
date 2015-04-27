using LODGenerator.Common;

namespace LODGenerator
{
    public struct BBox
    {
        public float px1;
        public float px2;
        public float py1;
        public float py2;
        public float pz1;
        public float pz2;

        public BBox(float x1, float x2, float y1, float y2, float z1, float z2)
        {
            this.px1 = x1;
            this.px2 = x2;
            this.py1 = y1;
            this.py2 = y2;
            this.pz1 = z1;
            this.pz2 = z2;
        }

        public void Set(float x1, float x2, float y1, float y2, float z1, float z2)
        {
            this.px1 = x1;
            this.px2 = x2;
            this.py1 = y1;
            this.py2 = y2;
            this.pz1 = z1;
            this.pz2 = z2;
        }

        public override string ToString()
        {
            return "BBox: " + this.px1 + ", " + this.py1 + ", " + this.pz1 + "   " + this.px2 + ", " + this.py2 + ", " + this.pz2;
        }

        public Vector3 GetCenter()
        {
            return new Vector3((float)(((double)this.px1 + (double)this.px2) / 2.0), (float)(((double)this.py1 + (double)this.py2) / 2.0), (float)(((double)this.pz1 + (double)this.pz2) / 2.0));
        }

        public bool VertexInBox(Vector3 vertex)
        {
            if (vertex[0] >= this.px1 && vertex[0] <= this.px2 && vertex[1] >= this.py1 && vertex[1] <= this.py2 && vertex[3] >= this.pz1 && vertex[3] <= this.pz2)
            {
                return true;
            }
            return false;
        }

        public bool VertexInSquare(Vector3 vertex)
        {
            if (vertex[0] >= this.px1 && vertex[0] <= this.px2 && vertex[1] >= this.py1 && vertex[1] <= this.py2)
            {
                return true;
            }
            return false;
        }

        public void ShrinkByVertex(Vector3 vertex)
        {
            if (vertex[0] > this.px1)
            {
                this.px1 = vertex[0];
            }
            if (vertex[0] < this.px2)
            {
                this.px2 = vertex[0];
            }
            if (vertex[1] > this.py1)
            {
                this.py1 = vertex[1];
            }
            if (vertex[1] < this.py2)
            {
                this.py2 = vertex[1];
            }
            if (vertex[2] > this.pz1)
            {
                this.pz1 = vertex[2];
            }
            if (vertex[2] < this.pz2)
            {
                this.pz2 = vertex[2];
            }
        }

        public void GrowByVertex(Vector3 vertex)
        {
            if (vertex[0] < this.px1)
            {
                this.px1 = vertex[0];
            }
            if (vertex[0] > this.px2)
            {
                this.px2 = vertex[0];
            }
            if (vertex[1] < this.py1)
            {
                this.py1 = vertex[1];
            }
            if (vertex[1] > this.py2)
            {
                this.py2 = vertex[1];
            }
            if (vertex[2] < this.pz1)
            {
                this.pz1 = vertex[2];
            }
            if (vertex[2] > this.pz2)
            {
                this.pz2 = vertex[2];
            }
        }

        public void ShrinkByBox(BBox boundingBox)
        {
            if (boundingBox.px1 > this.px1)
            {
                this.px1 = boundingBox.px1;
            }
            if (boundingBox.px2 < this.px2)
            {
                this.px2 = boundingBox.px2;
            }
            if (boundingBox.py1 > this.py1)
            {
                this.py1 = boundingBox.py1;
            }
            if (boundingBox.py2 < this.py2)
            {
                this.py2 = boundingBox.py2;
            }
            if (boundingBox.pz1 > this.pz1)
            {
                this.pz1 = boundingBox.pz1;
            }
            if (boundingBox.pz2 < this.pz2)
            {
                this.pz2 = boundingBox.pz2;
            }
        }

        public void GrowByBox(BBox boundingBox)
        {
            if (boundingBox.px1 < this.px1)
            {
                this.px1 = boundingBox.px1;
            }
            if (boundingBox.px2 > this.px2)
            {
                this.px2 = boundingBox.px2;
            }
            if (boundingBox.py1 < this.py1)
            {
                this.py1 = boundingBox.py1;
            }
            if (boundingBox.py2 > this.py2)
            {
                this.py2 = boundingBox.py2;
            }
            if (boundingBox.pz1 < this.pz1)
            {
                this.pz1 = boundingBox.pz1;
            }
            if (boundingBox.pz2 > this.pz2)
            {
                this.pz2 = boundingBox.pz2;
            }
        }
    }
}
