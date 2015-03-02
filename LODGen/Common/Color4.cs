namespace LODGenerator.Common
{
    public class Color4
    {
        private float r;
        private float g;
        private float b;
        private float a;

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
                    case 3:
                        return this.a;
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
                    case 3:
                        this.a = value;
                        break;
                }
            }
        }

        public Color4(float _r, float _g, float _b, float _a)
        {
            this.r = _r;
            this.g = _g;
            this.b = _b;
            this.a = _a;
        }
    }
}
