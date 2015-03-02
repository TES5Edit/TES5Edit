using System;

namespace LODGenerator.Common
{
    public class Matrix44
    {
        private float[] m1;
        private float[] m2;
        private float[] m3;
        private float[] m4;

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
                    case 3:
                        return this.m4;
                    default:
                        return (float[])null;
                }
            }
        }

        public Matrix44(bool IsIdentity)
        {
            this.m1 = new float[4];
            this.m2 = new float[4];
            this.m3 = new float[4];
            this.m4 = new float[4];
            if (IsIdentity)
            {
                this.m1[0] = 1f;
                this.m1[1] = 0.0f;
                this.m1[2] = 0.0f;
                this.m1[3] = 0.0f;
                this.m2[0] = 0.0f;
                this.m2[1] = 1f;
                this.m2[2] = 0.0f;
                this.m2[3] = 0.0f;
                this.m3[0] = 0.0f;
                this.m3[1] = 0.0f;
                this.m3[2] = 1f;
                this.m3[3] = 0.0f;
                this.m4[0] = 0.0f;
                this.m4[1] = 0.0f;
                this.m4[2] = 0.0f;
                this.m4[3] = 1f;
            }
            else
            {
                this.m1[0] = this.m1[1] = this.m1[2] = this.m1[3] = 0.0f;
                this.m2[0] = this.m2[1] = this.m2[2] = this.m2[3] = 0.0f;
                this.m3[0] = this.m3[1] = this.m3[2] = this.m3[3] = 0.0f;
                this.m4[0] = this.m4[1] = this.m4[2] = this.m4[3] = 0.0f;
            }
        }

        public Matrix44()
        {
            this.m1 = new float[4];
            this.m2 = new float[4];
            this.m3 = new float[4];
            this.m4 = new float[4];
            this.m1[0] = this.m1[1] = this.m1[2] = this.m1[3] = 0.0f;
            this.m2[0] = this.m2[1] = this.m2[2] = this.m2[3] = 0.0f;
            this.m3[0] = this.m3[1] = this.m3[2] = this.m3[3] = 0.0f;
            this.m4[0] = this.m4[1] = this.m4[2] = this.m4[3] = 0.0f;
        }

        public Matrix44(Matrix33 rot, Vector3 pos, float scale)
        {
            Matrix44 matrix44_1 = new Matrix44();
            matrix44_1[0][0] = rot[0][0];
            matrix44_1[0][1] = rot[1][0];
            matrix44_1[0][2] = rot[2][0];
            matrix44_1[0][3] = 0.0f;
            matrix44_1[1][0] = rot[0][1];
            matrix44_1[1][1] = rot[1][1];
            matrix44_1[1][2] = rot[2][1];
            matrix44_1[1][3] = 0.0f;
            matrix44_1[2][0] = rot[0][2];
            matrix44_1[2][1] = rot[1][2];
            matrix44_1[2][2] = rot[2][2];
            matrix44_1[2][3] = 0.0f;
            matrix44_1[3][0] = pos[0];
            matrix44_1[3][1] = pos[1];
            matrix44_1[3][2] = pos[2];
            matrix44_1[3][3] = 1f;
            Matrix44 matrix44_2 = new Matrix44();
            matrix44_2[0][0] = scale;
            matrix44_2[0][1] = 0.0f;
            matrix44_2[0][2] = 0.0f;
            matrix44_2[0][3] = 0.0f;
            matrix44_2[1][0] = 0.0f;
            matrix44_2[1][1] = scale;
            matrix44_2[1][2] = 0.0f;
            matrix44_2[1][3] = 0.0f;
            matrix44_2[2][0] = 0.0f;
            matrix44_2[2][1] = 0.0f;
            matrix44_2[2][2] = scale;
            matrix44_2[2][3] = 0.0f;
            matrix44_2[3][0] = 0.0f;
            matrix44_2[3][1] = 0.0f;
            matrix44_2[3][2] = 0.0f;
            matrix44_2[3][3] = 1f;
            Matrix44 matrix44_3 = matrix44_1 * matrix44_2;
            this.m1 = new float[4];
            this.m2 = new float[4];
            this.m3 = new float[4];
            this.m4 = new float[4];
            this.m1[0] = matrix44_3[0][0];
            this.m1[1] = matrix44_3[0][1];
            this.m1[2] = matrix44_3[0][2];
            this.m1[3] = matrix44_3[0][3];
            this.m2[0] = matrix44_3[1][0];
            this.m2[1] = matrix44_3[1][1];
            this.m2[2] = matrix44_3[1][2];
            this.m2[3] = matrix44_3[1][3];
            this.m3[0] = matrix44_3[2][0];
            this.m3[1] = matrix44_3[2][1];
            this.m3[2] = matrix44_3[2][2];
            this.m3[3] = matrix44_3[2][3];
            this.m4[0] = matrix44_3[3][0];
            this.m4[1] = matrix44_3[3][1];
            this.m4[2] = matrix44_3[3][2];
            this.m4[3] = matrix44_3[3][3];
        }

        public static Matrix44 operator *(Matrix44 a, Matrix44 b)
        {
            Matrix44 matrix44 = new Matrix44();
            for (int index1 = 0; index1 < 4; ++index1)
            {
                for (int index2 = 0; index2 < 4; ++index2)
                {
                    float num = 0.0f;
                    for (int index3 = 0; index3 < 4; ++index3)
                        num += a[index1][index3] * b[index3][index2];
                    matrix44[index1][index2] = num;
                }
            }
            return matrix44;
        }

        public void SetTranslation(float x, float y, float z)
        {
            this.m4[0] = x;
            this.m4[1] = y;
            this.m4[2] = z;
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

        public Matrix44 RemoveTranslation()
        {
            Matrix44 matrix44 = new Matrix44(true);
            matrix44[0][0] = this.m1[0];
            matrix44[0][1] = this.m1[1];
            matrix44[0][2] = this.m1[2];
            matrix44[1][0] = this.m2[0];
            matrix44[1][1] = this.m2[1];
            matrix44[1][2] = this.m2[2];
            matrix44[2][0] = this.m3[0];
            matrix44[2][1] = this.m3[1];
            matrix44[2][2] = this.m3[2];
            return matrix44;
        }
    }
}
