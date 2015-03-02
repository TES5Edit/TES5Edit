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

        public Vector3 GetCenter()
        {
            return new Vector3((float)(((double)this.px1 + (double)this.px2) / 2.0), (float)(((double)this.py1 + (double)this.py2) / 2.0), (float)(((double)this.pz1 + (double)this.pz2) / 2.0));
        }
    }
}
