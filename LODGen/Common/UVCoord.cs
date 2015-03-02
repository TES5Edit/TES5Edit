namespace LODGenerator.Common
{
    public class UVCoord
    {
        private float u;
        private float v;

        public float this[int i]
        {
            get
            {
                switch (i)
                {
                    case 0:
                        return this.u;
                    case 1:
                        return this.v;
                    default:
                        return float.NaN;
                }
            }
            set
            {
                switch (i)
                {
                    case 0:
                        this.u = value;
                        break;
                    case 1:
                        this.v = value;
                        break;
                }
            }
        }

        public UVCoord(float _u, float _v)
        {
            this.u = _u;
            this.v = _v;
        }
    }
}
