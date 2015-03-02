namespace LODGenerator.Common
{
    public class Color3
    {
        private float r;
        private float g;
        private float b;

        public float this[int i]
        {
            get
            {
                switch (i)
                {
                    case 0:
                        return this.r;
                    case 1:
                        return this.g;
                    case 2:
                        return this.b;
                    default:
                        return float.NaN;
                }
            }
            set
            {
                switch (i)
                {
                    case 0:
                        this.r = value;
                        break;
                    case 1:
                        this.g = value;
                        break;
                    case 2:
                        this.b = value;
                        break;
                }
            }
        }

        public Color3(float _r, float _g, float _b)
        {
            this.r = _r;
            this.g = _g;
            this.b = _b;
        }
    }
}
