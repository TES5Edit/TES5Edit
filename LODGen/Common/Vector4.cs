namespace LODGenerator.Common
{
    public class Vector4
    {
        private float x;
        private float y;
        private float z;
        private float w;

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
                    case 3:
                        return this.w;
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
                    case 3:
                        this.w = value;
                        break;
                }
            }
        }

        public Vector4()
        {
            this.x = this.y = this.z = this.w = 0.0f;
        }

        public Vector4(Vector3 val)
        {
            this.x = val[0];
            this.y = val[1];
            this.z = val[2];
            this.w = 1f;
        }

        public Vector4(float _x, float _y, float _z, float _w)
        {
            this.x = _x;
            this.y = _y;
            this.z = _z;
            this.w = _w;
        }

        public static Vector4 Transform(Vector4 v, Matrix44 m)
        {
            Vector4 vector4_1 = new Vector4();
            for (int index = 0; index < 4; ++index)
                vector4_1[index] = (float)((double)v[0] * (double)m[0][index] + (double)v[1] * (double)m[1][index] + (double)v[2] * (double)m[2][index] + (double)v[3] * (double)m[3][index]);
            Vector4 vector4_2;
            (vector4_2 = vector4_1)[0] = vector4_2[0] / vector4_1[3];
            Vector4 vector4_3;
            (vector4_3 = vector4_1)[1] = vector4_3[1] / vector4_1[3];
            Vector4 vector4_4;
            (vector4_4 = vector4_1)[2] = vector4_4[2] / vector4_1[3];
            return vector4_1;
        }
    }
}
