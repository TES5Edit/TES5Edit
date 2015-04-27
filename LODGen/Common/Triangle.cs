namespace LODGenerator.Common
{
    public class Triangle
    {
        private ushort v1;
        private ushort v2;
        private ushort v3;

        public ushort this[int i]
        {
            get
            {
                switch (i)
                {
                    case 0:
                        return this.v1;
                    case 1:
                        return this.v2;
                    case 2:
                        return this.v3;
                    default:
                        return (ushort)0;
                }
            }
            set
            {
                switch (i)
                {
                    case 0:
                        this.v1 = value;
                        break;
                    case 1:
                        this.v2 = value;
                        break;
                    case 2:
                        this.v3 = value;
                        break;
                }
            }
        }

        public Triangle(ushort _v1, ushort _v2, ushort _v3)
        {
            this.v1 = _v1;
            this.v2 = _v2;
            this.v3 = _v3;
        }

        public override string ToString()
        {
            return this.v1.ToString() + ", " + this.v2.ToString() + ", " + this.v3.ToString();
        }
    }
}
