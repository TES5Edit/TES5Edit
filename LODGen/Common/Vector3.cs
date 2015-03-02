using System;

namespace LODGenerator.Common
{
    public class Vector3
    {
        private float x;
        private float y;
        private float z;

        public float Length
        {
            get
            {
                return (float)Math.Sqrt((double)this.x * (double)this.x + (double)this.y * (double)this.y + (double)this.z * (double)this.z);
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
                    case 2:
                        return this.z;
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
                    case 2:
                        this.z = value;
                        break;
                }
            }
        }

        public Vector3()
        {
            this.x = 0.0f;
            this.y = 0.0f;
            this.z = 0.0f;
        }

        public Vector3(float _x, float _y, float _z)
        {
            this.x = _x;
            this.y = _y;
            this.z = _z;
        }

        public static Vector3 operator *(Vector3 v, Matrix44 m)
        {
            Vector3 vector3 = new Vector3();
            vector3[0] = (float)((double)v[0] * (double)m[0][0] + (double)v[1] * (double)m[1][0] + (double)v[2] * (double)m[2][0]) + m[3][0];
            vector3[1] = (float)((double)v[0] * (double)m[0][1] + (double)v[1] * (double)m[1][1] + (double)v[2] * (double)m[2][1]) + m[3][1];
            vector3[2] = (float)((double)v[0] * (double)m[0][2] + (double)v[1] * (double)m[1][2] + (double)v[2] * (double)m[2][2]) + m[3][2];
            return vector3;
        }

        public static Vector3 operator *(Vector3 v, float f)
        {
            Vector3 vector3 = new Vector3();
            vector3[0] = v[0] * f;
            vector3[1] = v[1] * f;
            vector3[2] = v[2] * f;
            return vector3;
        }

        public static Vector3 operator /(Vector3 i, float v)
        {
            Vector3 vector3 = new Vector3();
            vector3[0] = i[0] / v;
            vector3[1] = i[1] / v;
            vector3[2] = i[2] / v;
            return vector3;
        }

        public static Vector3 operator -(Vector3 a, Vector3 b)
        {
            return new Vector3(a.x - b.x, a.y - b.y, a.z - b.z);
        }

        public static Vector3 operator +(Vector3 a, Vector3 b)
        {
            return new Vector3(a.x + b.x, a.y + b.y, a.z + b.z);
        }

        public static Vector3 Cross(Vector3 A, Vector3 B)
        {
            Vector3 vector3 = new Vector3();
            vector3[0] = (float)((double)A[1] * (double)B[2] - (double)A[2] * (double)B[1]);
            vector3[1] = (float)((double)A[2] * (double)B[0] - (double)A[0] * (double)B[2]);
            vector3[2] = (float)((double)A[0] * (double)B[1] - (double)A[1] * (double)B[0]);
            return vector3;
        }

        public static float Dot(Vector3 A, Vector3 B)
        {
            return (float)((double)A[0] * (double)B[0] + (double)A[1] * (double)B[1] + (double)A[2] * (double)B[2]);
        }

        public void Normalize()
        {
            this.x = this.x / this.Length;
            this.y = this.y / this.Length;
            this.z = this.z / this.Length;
        }

        public override string ToString()
        {
            return this.x.ToString() + ", " + this.y.ToString() + ", " + this.z.ToString();
        }
    }
}
