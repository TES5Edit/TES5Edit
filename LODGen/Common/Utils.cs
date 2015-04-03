using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace LODGenerator.Common
{
    public static class Game
    {
        static string _mode;
        public static bool Testing;

        public static string Mode
        {
            get
            {
                return _mode;
            }
            set
            {
                _mode = value;
            }
        }
    }

    public static class Utils
    {

        public static string ReadShortString(BinaryReader NifReader)
        {
            byte num = NifReader.ReadByte();
            string str = "";
            for (int index = 0; index < (int)num; ++index)
                str = str + (object)(char)NifReader.ReadByte();
            return str;
        }

        public static void WriteShortString(BinaryWriter writer, string value)
        {
            writer.Write((byte)value.Length);
            for (int index = 0; index < value.Length; ++index)
                writer.Write((byte)Enumerable.ElementAt<char>((IEnumerable<char>)value, index));
        }

        public static string ReadSizedString(BinaryReader NifReader)
        {
            uint num = NifReader.ReadUInt32();
            string str = "";
            for (int index = 0; (long)index < (long)num; ++index)
                str = str + (object)(char)NifReader.ReadByte();
            return str;
        }

        public static void ReadString(BinaryReader NifReader, uint version, out int StringIdx, out string StringValue)
        {
            StringIdx = -1;
            StringValue = (string)null;
            if (version > 335544325U)
                StringIdx = NifReader.ReadInt32();
            else
                StringValue = Utils.ReadSizedString(NifReader);
        }

        public static void WriteSizedString(BinaryWriter writer, string value)
        {
            writer.Write((uint)value.Length);
            for (int index = 0; index < value.Length; ++index)
                writer.Write((byte)Enumerable.ElementAt<char>((IEnumerable<char>)value, index));
        }

        public static Vector3 ReadVector3(BinaryReader NifReader)
        {
            return new Vector3(NifReader.ReadSingle(), NifReader.ReadSingle(), NifReader.ReadSingle());
        }

        public static void WriteVector3(BinaryWriter writer, Vector3 value)
        {
            writer.Write(value[0]);
            writer.Write(value[1]);
            writer.Write(value[2]);
        }

        public static Vector4 ReadVector4(BinaryReader NifReader)
        {
            return new Vector4(NifReader.ReadSingle(), NifReader.ReadSingle(), NifReader.ReadSingle(), NifReader.ReadSingle());
        }

        public static void WriteVector4(BinaryWriter writer, Vector4 value)
        {
            writer.Write(value[0]);
            writer.Write(value[1]);
            writer.Write(value[2]);
            writer.Write(value[3]);
        }

        public static Matrix33 ReadMatrix33(BinaryReader NifReader)
        {
            return new Matrix33(NifReader.ReadSingle(), NifReader.ReadSingle(), NifReader.ReadSingle(), NifReader.ReadSingle(), NifReader.ReadSingle(), NifReader.ReadSingle(), NifReader.ReadSingle(), NifReader.ReadSingle(), NifReader.ReadSingle());
        }

        public static void WriteMatrix33(BinaryWriter writer, Matrix33 value)
        {
            for (int index1 = 0; index1 < 3; ++index1)
            {
                for (int index2 = 0; index2 < 3; ++index2)
                    writer.Write(value[index1][index2]);
            }
        }

        public static bool ReadBool(BinaryReader NifReader)
        {
            return (int)NifReader.ReadByte() != 0;
        }

        public static void WriteBool(BinaryWriter writer, bool value)
        {
            writer.Write(value ? (byte)1 : (byte)0);
        }

        public static Color4 ReadColor4(BinaryReader NifReader)
        {
            return new Color4(NifReader.ReadSingle(), NifReader.ReadSingle(), NifReader.ReadSingle(), NifReader.ReadSingle());
        }

        public static void WriteColor4(BinaryWriter writer, Color4 value)
        {
            writer.Write(value[0]);
            writer.Write(value[1]);
            writer.Write(value[2]);
            writer.Write(value[3]);
        }

        public static Color3 ReadColor3(BinaryReader NifReader)
        {
            return new Color3(NifReader.ReadSingle(), NifReader.ReadSingle(), NifReader.ReadSingle());
        }

        public static void WriteColor3(BinaryWriter writer, Color3 value)
        {
            writer.Write(value[0]);
            writer.Write(value[1]);
            writer.Write(value[2]);
        }

        public static UVCoord ReadUVCoord(BinaryReader NifReader)
        {
            return new UVCoord(NifReader.ReadSingle(), NifReader.ReadSingle());
        }

        public static void WriteUVCoord(BinaryWriter writer, UVCoord value)
        {
            writer.Write(value[0]);
            writer.Write(value[1]);
        }

        public static Triangle ReadTriangle(BinaryReader NifReader)
        {
            return new Triangle(NifReader.ReadUInt16(), NifReader.ReadUInt16(), NifReader.ReadUInt16());
        }

        public static void WriteTriangle(BinaryWriter writer, Triangle value)
        {
            writer.Write(value[0]);
            writer.Write(value[1]);
            writer.Write(value[2]);
        }

        public static TexDesc ReadTexDesc(BinaryReader NifReader)
        {
            TexDesc texDesc = new TexDesc();
            texDesc.source = NifReader.ReadInt32();
            texDesc.clampMode = NifReader.ReadUInt32();
            texDesc.filterMode = NifReader.ReadUInt32();
            texDesc.uvSet = NifReader.ReadUInt32();
            texDesc.hasTextureTransform = Utils.ReadBool(NifReader);
            if (texDesc.hasTextureTransform)
            {
                texDesc.translation = Utils.ReadUVCoord(NifReader);
                texDesc.tiling = Utils.ReadUVCoord(NifReader);
                texDesc.wRotation = NifReader.ReadSingle();
                texDesc.transformType = NifReader.ReadUInt32();
                texDesc.centerOffset = Utils.ReadUVCoord(NifReader);
            }
            return texDesc;
        }

        public static float ToRadians(float val)
        {
            return (float)((double)val * 3.14159274101257 / 180.0);
        }

        public static bool PointInTriangle(Vector2 p, Vector2 t1, Vector2 t2, Vector2 t3, out float u, out float v)
        {
            Vector2 vector2_1 = t3 - t1;
            Vector2 vector2_2 = t2 - t1;
            Vector2 B = p - t1;
            float num1 = Vector2.Dot(vector2_1, vector2_1);
            float num2 = Vector2.Dot(vector2_1, vector2_2);
            float num3 = Vector2.Dot(vector2_1, B);
            float num4 = Vector2.Dot(vector2_2, vector2_2);
            float num5 = Vector2.Dot(vector2_2, B);
            float num6 = (float)(1.0 / ((double)num1 * (double)num4 - (double)num2 * (double)num2));
            u = (float)((double)num4 * (double)num3 - (double)num2 * (double)num5) * num6;
            v = (float)((double)num1 * (double)num5 - (double)num2 * (double)num3) * num6;
            if ((double)u >= 0.0 && (double)v >= 0.0)
                return (double)u + (double)v < 1.0;
            else
                return false;
        }

        public static FileStream GetFileStream(FileInfo file, LogFile logFile)
        {
            try
            {
                return file.Open(FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
            }
            catch (IOException ex)
            {
                logFile.WriteLog(ex.Message);
                logFile.Close();
                System.Environment.Exit(404);
                return (FileStream)null;
            }
        }
    }
}
