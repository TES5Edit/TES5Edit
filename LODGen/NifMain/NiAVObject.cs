using LODGenerator.Common;
using System;
using System.Collections.Generic;
using System.IO;

namespace LODGenerator.NifMain
{
    public class NiAVObject : NiObjectNET
    {
        protected ushort flags;
        protected ushort flags2;
        protected Vector3 translation;
        protected Matrix33 rotation;
        protected float scale;
        protected uint numProperties;
        protected List<int> properties;
        protected int collisionObject;

        public NiAVObject()
        {
            if (Game.Mode == "fnv")
            {
                this.flags = (ushort)2062;
                this.flags2 = (ushort)8;
            }
            else
            {
                this.flags = (ushort)14;
                this.flags2 = (ushort)0;
            }
            this.translation = new Vector3(0.0f, 0.0f, 0.0f);
            this.rotation = new Matrix33(true);
            this.scale = 1f;
            this.numProperties = 0U;
            this.properties = new List<int>();
            this.collisionObject = -1;
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.flags = reader.ReadUInt16();
            if ((header.GetUserVersion() >= 11U) && (header.GetUserVersion2() >= 26U))
                this.flags2 = reader.ReadUInt16();
            this.translation = Utils.ReadVector3(reader);
            this.rotation = Utils.ReadMatrix33(reader);
            this.scale = reader.ReadSingle();
            if ((header.GetVersion() <= 335544325U) || (header.GetUserVersion() <= 11U))
            {
                this.numProperties = reader.ReadUInt32();
                for (int index = 0; (long)index < (long)this.numProperties; ++index)
                    this.properties.Add(reader.ReadInt32());
            }
            else
            {
            }
            this.collisionObject = reader.ReadInt32();

        }

        public override void Write(BinaryWriter writer)
        {
            base.Write(writer);
            writer.Write(this.flags);
            writer.Write(this.flags2);
            Utils.WriteVector3(writer, this.translation);
            Utils.WriteMatrix33(writer, this.rotation);
            writer.Write(this.scale);
            if (Game.Mode == "fnv")
            {
                writer.Write((uint)this.properties.Count);
                for (int index = 0; (long)index < this.properties.Count; ++index)
                    writer.Write(this.properties[index]);
            }
            writer.Write(this.collisionObject);
        }

        public override uint GetSize()
        {
            if (Game.Mode == "fnv")
            {
                return base.GetSize() + 60U + 4 + 4 * (uint) this.properties.Count;
            }
            else
            {
                return base.GetSize() + 60U;
            }
        }

        public override string GetClassName()
        {
            return "NiAVObject";
        }

        public ushort GetFlags()
        {
            return this.flags;
        }

        public void SetFlags(ushort value)
        {
            this.flags = value;
        }

        public bool IsHidden()
        {
            return ((int)this.flags & 1) == 1;
        }

        public ushort GetFlags2()
        {
            return this.flags2;
        }

        public void SetFlags2(ushort value)
        {
            this.flags2 = value;
        }

        public Vector3 GetTranslation()
        {
            return this.translation;
        }

        public void SetTranslation(Vector3 trans)
        {
            this.translation = trans;
        }

        public Matrix33 GetRotation()
        {
            return this.rotation;
        }

        public void SetRotation(Matrix33 rot)
        {
            this.rotation = rot;
        }

        public float GetScale()
        {
            return this.scale;
        }

        public void SetScale(float value)
        {
            this.scale = value;
        }

        public uint GetNumProperties()
        {
            return this.numProperties;
        }

        public void SetNumProperties(uint value)
        {
            this.numProperties = value;
        }

        public void SetProperties(int value)
        {
            this.properties.Add(value);
        }

        public int GetProperty(int index)
        {
            return this.properties[index];
        }

        public int GetCollisionObject()
        {
            return this.collisionObject;
        }

        public Matrix44 GetTransform()
        {
            return new Matrix44(this.rotation, this.translation, 1f);
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiAVObject";
            return flag;
        }
    }
}
