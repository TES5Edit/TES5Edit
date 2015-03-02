using System;

namespace LODGenerator.Common
{
    public class Vector2
    {
        private float x;
        private float y;

        public float Length
        {
            get
            {
                return (float)Math.Sqrt((double)this.x * (double)this.x + (double)this.y * (double)this.y);
            }
        }

        public float this[int i]
        {
            get
            {
                switch (i)
                {
                    case 0:
                        return this.x;
                    case 1:
                        return this.y;
                    default:
                        return float.NaN;
                }
            }
            set
            {
                switch (i)
                {
                    case 0:
                        this.x = value;
                        break;
                    case 1:
                        this.y = value;
                        break;
                }
            }
        }

        public Vector2()
        {
            this.x = 0.0f;
            this.y = 0.0f;
        }

        public Vector2(float _x, float _y)
        {
            this.x = _x;
            this.y = _y;
        }

        public static Vector2 operator -(Vector2 a, Vector2 b)
        {
            return new Vector2(a[0] - b[0], a[1] - b[1]);
        }

        public static float Dot(Vector2 A, Vector2 B)
        {
            return (float)((double)A[0] * (double)B[0] + (double)A[1] * (double)B[1]);
        }

        public void Normalize()
        {
            this.x = this.x / this.Length;
            this.y = this.y / this.Length;
        }

        public override string ToString()
        {
            return this.x.ToString() + ", " + this.y.ToString();
        }
    }
}
