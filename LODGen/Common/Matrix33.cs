using System;

namespace LODGenerator.Common
{
    public class Matrix33
    {
        private float[] m1;
        private float[] m2;
        private float[] m3;

        public float[] this[int i]
        {
            get
            {
                switch (i)
                {
                    case 0:
                        return this.m1;
                    case 1:
                        return this.m2;
                    case 2:
                        return this.m3;
                    default:
                        return (float[])null;
                }
            }
        }

        public Matrix33(Matrix33 val)
        {
            this.m1 = new float[3];
            this.m2 = new float[3];
            this.m3 = new float[3];
            this.m1[0] = val[0][0];
            this.m1[1] = val[0][1];
            this.m1[2] = val[0][2];
            this.m2[0] = val[1][0];
            this.m2[1] = val[1][1];
            this.m2[2] = val[1][2];
            this.m3[0] = val[2][0];
            this.m3[1] = val[2][1];
            this.m3[2] = val[2][2];
        }

        public Matrix33(bool isIdentity)
        {
            this.m1 = new float[3];
            this.m2 = new float[3];
            this.m3 = new float[3];
            if (isIdentity)
            {
                this.Identity();
            }
            else
            {
                this.m1[0] = this.m1[1] = this.m1[2] = 0.0f;
                this.m2[0] = this.m2[1] = this.m2[2] = 0.0f;
                this.m3[0] = this.m3[1] = this.m3[2] = 0.0f;
            }
        }

        public Matrix33(float _m11, float _m12, float _m13, float _m21, float _m22, float _m23, float _m31, float _m32, float _m33)
        {
            this.m1 = new float[3];
            this.m2 = new float[3];
            this.m3 = new float[3];
            this.m1[0] = _m11;
            this.m1[1] = _m12;
            this.m1[2] = _m13;
            this.m2[0] = _m21;
            this.m2[1] = _m22;
            this.m2[2] = _m23;
            this.m3[0] = _m31;
            this.m3[1] = _m32;
            this.m3[2] = _m33;
        }

        public static Matrix33 operator *(Matrix33 a, Matrix33 b)
        {
            Matrix33 matrix33 = new Matrix33(true);
            for (int index1 = 0; index1 < 3; ++index1)
            {
                for (int index2 = 0; index2 < 3; ++index2)
                    matrix33[index1][index2] = (float)((double)a[index1][0] * (double)b[0][index2] + (double)a[index1][1] * (double)b[1][index2] + (double)a[index1][2] * (double)b[2][index2]);
            }
            return matrix33;
        }

        public void Transpose()
        {
            this.m1[0] = this.m1[0];
            this.m1[1] = this.m2[0];
            this.m1[2] = this.m3[0];
            this.m2[0] = this.m1[1];
            this.m2[1] = this.m2[1];
            this.m2[2] = this.m3[1];
            this.m3[0] = this.m1[2];
            this.m3[1] = this.m2[2];
            this.m3[2] = this.m3[2];
        }

        public void Identity()
        {
            this.m1[0] = 1f;
            this.m1[1] = 0.0f;
            this.m1[2] = 0.0f;
            this.m2[0] = 0.0f;
            this.m2[1] = 1f;
            this.m2[2] = 0.0f;
            this.m3[0] = 0.0f;
            this.m3[1] = 0.0f;
            this.m3[2] = 1f;
        }

        public void SetRotationX(float value)
        {
            this.m2[1] = (float)Math.Cos((double)value);
            this.m3[1] = (float)Math.Sin((double)value);
            this.m2[2] = (float)-Math.Sin((double)value);
            this.m3[2] = (float)Math.Cos((double)value);
        }

        public void SetRotationY(float value)
        {
            this.m1[0] = (float)Math.Cos((double)value);
            this.m3[0] = (float)-Math.Sin((double)value);
            this.m1[2] = (float)Math.Sin((double)value);
            this.m3[2] = (float)Math.Cos((double)value);
        }

        public void SetRotationZ(float value)
        {
            this.m1[0] = (float)Math.Cos((double)value);
            this.m2[0] = (float)Math.Sin((double)value);
            this.m1[1] = (float)-Math.Sin((double)value);
            this.m2[1] = (float)Math.Cos((double)value);
        }

        public override string ToString()
        {
            return "[" + (object)this.m1[0] + ", " + (string)(object)this.m1[1] + ", " + (string)(object)this.m1[2] + "] [" + (string)(object)this.m2[0] + ", " + (string)(object)this.m2[1] + ", " + (string)(object)this.m2[2] + "] [" + (string)(object)this.m3[0] + ", " + (string)(object)this.m3[1] + ", " + (string)(object)this.m3[2] + "]";
        }
    }
}
