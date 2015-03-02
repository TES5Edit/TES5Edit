using System;

namespace LODGenerator.Common
{
    public class Quaternion
    {
        private float w;
        private float x;
        private float y;
        private float z;

        public float this[int i]
        {
            get
            {
                switch (i)
                {
                    case 0:
                        return this.w;
                    case 1:
                        return this.x;
                    case 2:
                        return this.y;
                    case 3:
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
                        this.w = value;
                        break;
                    case 1:
                        this.x = value;
                        break;
                    case 2:
                        this.y = value;
                        break;
                    case 3:
                        this.z = value;
                        break;
                }
            }
        }

        public Quaternion(float _w, float _x, float _y, float _z)
        {
            this.w = _w;
            this.x = _x;
            this.y = _y;
            this.z = _z;
        }

        public Quaternion(Matrix33 m)
        {
            float[] numArray1 = new float[4];
            int[] numArray2 = new int[3]
      {
        1,
        2,
        0
      };
            float num1 = m[0][0] + m[1][1] + m[2][2];
            if ((double)num1 > 0.0)
            {
                float num2 = (float)Math.Sqrt((double)num1 + 1.0);
                this.w = num2 / 2f;
                float num3 = 0.5f / num2;
                this.x = (m[1][2] - m[2][1]) * num3;
                this.y = (m[2][0] - m[0][2]) * num3;
                this.z = (m[0][1] - m[1][0]) * num3;
            }
            else
            {
                int index1 = 0;
                if ((double)m[1][1] > (double)m[0][0])
                    index1 = 1;
                if ((double)m[2][2] > (double)m[index1][index1])
                    index1 = 2;
                int index2 = numArray2[index1];
                int index3 = numArray2[index2];
                float num2 = (float)Math.Sqrt((double)m[index1][index1] - ((double)m[index2][index2] + (double)m[index3][index3]) + 1.0);
                numArray1[index1] = num2 * 0.5f;
                if ((double)num2 != 0.0)
                    num2 = 0.5f / num2;
                numArray1[3] = (m[index2][index3] - m[index3][index2]) * num2;
                numArray1[index2] = (m[index1][index2] + m[index2][index1]) * num2;
                numArray1[index3] = (m[index1][index3] + m[index3][index1]) * num2;
                this.x = numArray1[0];
                this.y = numArray1[1];
                this.z = numArray1[2];
                this.w = numArray1[3];
            }
        }
    }
}
