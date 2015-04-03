using LODGenerator.Common;
using System.Collections.Generic;
using System.IO;

namespace LODGenerator.NifMain
{
    public class NiGeometryData : NiObject
    {
        protected int unknownInt;
        protected ushort numVertices;
        protected byte keepFlags;
        protected byte compressFlags;
        protected bool hasVertices;
        protected List<Vector3> vertices;
        protected ushort bsNumUVSets;
        protected uint skyrimMaterial;
        protected bool hasNormals;
        protected List<Vector3> normals;
        protected List<Vector3> tangents;
        protected List<Vector3> bitangents;
        protected Vector3 center;
        protected float radius;
        protected bool hasVertexColors;
        protected List<Color4> vertexColors;
        protected List<UVCoord> uvCoords;
        protected ushort consistencyFlags;
        protected int additionalData;

        public NiGeometryData()
        {
            this.unknownInt = 0;
            this.numVertices = (ushort)0;
            this.keepFlags = (byte)0;
            this.compressFlags = (byte)0;
            this.hasVertices = false;
            this.vertices = new List<Vector3>();
            this.bsNumUVSets = (ushort)0;
            this.skyrimMaterial = 0U;
            this.hasNormals = false;
            this.normals = new List<Vector3>();
            this.tangents = new List<Vector3>();
            this.bitangents = new List<Vector3>();
            this.center = new Vector3();
            this.radius = 0.0f;
            this.hasVertexColors = false;
            this.vertexColors = new List<Color4>();
            this.uvCoords = new List<UVCoord>();
            this.consistencyFlags = (ushort)0;
            this.additionalData = -1;
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.unknownInt = reader.ReadInt32();
            this.numVertices = reader.ReadUInt16();
            this.keepFlags = reader.ReadByte();
            this.compressFlags = reader.ReadByte();
            this.hasVertices = Utils.ReadBool(reader);
            if (this.hasVertices)
            {
                for (int index = 0; index < (int)this.numVertices; ++index)
                    this.vertices.Add(Utils.ReadVector3(reader));
            }
            this.bsNumUVSets = reader.ReadUInt16();
            if (header.GetUserVersion() == 12U)
                this.skyrimMaterial = reader.ReadUInt32();
            this.hasNormals = Utils.ReadBool(reader);
            if (this.hasNormals)
            {
                for (int index = 0; index < (int)this.numVertices; ++index)
                    this.normals.Add(Utils.ReadVector3(reader));
                if ((int)this.bsNumUVSets >= 4096)
                {
                    for (int index = 0; index < (int)this.numVertices; ++index)
                        this.tangents.Add(Utils.ReadVector3(reader));
                    for (int index = 0; index < (int)this.numVertices; ++index)
                        this.bitangents.Add(Utils.ReadVector3(reader));
                }
            }
            this.center = Utils.ReadVector3(reader);
            this.radius = reader.ReadSingle();
            this.hasVertexColors = Utils.ReadBool(reader);
            if (this.hasVertexColors)
            {
                for (int index = 0; index < (int)this.numVertices; ++index)
                    this.vertexColors.Add(Utils.ReadColor4(reader));
            }
            if (((int)this.bsNumUVSets & 1) == 1)
            {
                for (int index = 0; index < (int)this.numVertices; ++index)
                    this.uvCoords.Add(Utils.ReadUVCoord(reader));
            }
            this.consistencyFlags = reader.ReadUInt16();
            this.additionalData = reader.ReadInt32();
        }

        public override void Write(BinaryWriter writer)
        {
            base.Write(writer);
            writer.Write(this.unknownInt);
            writer.Write(this.numVertices);
            writer.Write(this.keepFlags);
            writer.Write(this.compressFlags);
            Utils.WriteBool(writer, this.hasVertices);
            if (this.hasVertices)
            {
                for (int index = 0; index < (int)this.numVertices; ++index)
                    Utils.WriteVector3(writer, this.vertices[index]);
            }
            writer.Write(this.bsNumUVSets);
            if (Game.Mode != "fnv")
            {
                writer.Write(this.skyrimMaterial);
            }
            if (this.hasNormals && this.normals.Count == 0)
            {
                for (int index = 0; index < (int)this.numVertices; ++index)
                    this.normals.Add(new Vector3(0.0f, 0.0f, 0.0f));
            }
            Utils.WriteBool(writer, this.hasNormals);
            if (this.hasNormals)
            {
                for (int index = 0; index < (int)this.numVertices; ++index)
                    Utils.WriteVector3(writer, this.normals[index]);
                if ((int)this.bsNumUVSets >= 4096)
                {
                    for (int index = 0; index < (int)this.numVertices; ++index)
                        Utils.WriteVector3(writer, this.tangents[index]);
                    for (int index = 0; index < (int)this.numVertices; ++index)
                        Utils.WriteVector3(writer, this.bitangents[index]);
                }
            }
            Utils.WriteVector3(writer, this.center);
            writer.Write(this.radius);
            Utils.WriteBool(writer, this.hasVertexColors);
            if (this.hasVertexColors)
            {
                for (int index = 0; index < (int)this.numVertices; ++index)
                    Utils.WriteColor4(writer, this.vertexColors[index]);
            }
            if (((int)this.bsNumUVSets & 1) == 1)
            {
                for (int index = 0; index < (int)this.numVertices; ++index)
                    Utils.WriteUVCoord(writer, this.uvCoords[index]);
            }
            writer.Write(this.consistencyFlags);
            writer.Write(this.additionalData);
        }

        public override uint GetSize()
        {
            if (Game.Mode == "fnv")
            {
                return (uint)((int)(base.GetSize() + 35U) + (this.hasVertices ? 12 * (int)this.numVertices : 0) + (this.hasNormals ? 12 * (int)this.numVertices : 0) + (!this.hasNormals || (int)this.bsNumUVSets < 4096 ? 0 : 12 * (int)this.numVertices) + (!this.hasNormals || (int)this.bsNumUVSets < 4096 ? 0 : 12 * (int)this.numVertices) + (this.hasVertexColors ? 16 * (int)this.numVertices : 0) + (((int)this.bsNumUVSets & 1) == 1 ? 8 * (int)this.numVertices : 0));
            }
            else
            {
                return (uint)((int)(base.GetSize() + 39U) + (this.hasVertices ? 12 * (int)this.numVertices : 0) + (this.hasNormals ? 12 * (int)this.numVertices : 0) + (!this.hasNormals || (int)this.bsNumUVSets < 4096 ? 0 : 12 * (int)this.numVertices) + (!this.hasNormals || (int)this.bsNumUVSets < 4096 ? 0 : 12 * (int)this.numVertices) + (this.hasVertexColors ? 16 * (int)this.numVertices : 0) + (((int)this.bsNumUVSets & 1) == 1 ? 8 * (int)this.numVertices : 0));
            }
        }

        public int GetUnknownInt()
        {
            return this.unknownInt;
        }

        public ushort GetNumVertices()
        {
            return this.numVertices;
        }

        public void SetNumVertices(ushort value)
        {
            this.numVertices = value;
        }

        public bool HasVertices()
        {
            return this.hasVertices;
        }

        public void SetHasVertices(bool value)
        {
            this.hasVertices = value;
        }

        public List<Vector3> GetVertices()
        {
            return this.vertices;
        }

        public void SetVertices(List<Vector3> value)
        {
            this.vertices = value;
            this.numVertices = (ushort)this.vertices.Count;
        }

        public bool HasNormals()
        {
            return this.hasNormals;
        }

        public void SetHasNormals(bool value)
        {
            this.hasNormals = value;
        }

        public List<Vector3> GetNormals()
        {
            return this.normals;
        }

        public void SetNormals(List<Vector3> value)
        {
            this.normals = value;
            this.numVertices = (ushort)this.normals.Count;
        }

        public List<Vector3> GetTangents()
        {
            return this.tangents;
        }

        public void SetTangents(List<Vector3> value)
        {
            this.tangents = value;
            this.numVertices = (ushort)this.tangents.Count;
            this.SetHasTangents(true);
        }

        public List<Vector3> GetBitangents()
        {
            return this.bitangents;
        }

        public void SetBitangents(List<Vector3> value)
        {
            this.bitangents = value;
            this.numVertices = (ushort)this.bitangents.Count;
            this.SetHasTangents(true);
        }

        public List<Color4> GetVertexColors()
        {
            return this.vertexColors;
        }

        // added for remove unseen
        public void SetVertexColors(List<Color4> value)
        {
            this.vertexColors = value;
            this.numVertices = (ushort)this.vertexColors.Count;
        }

        public List<UVCoord> GetUVCoords()
        {
            return this.uvCoords;
        }

        // added for remove unseen
        public void SetUVCoords(List<UVCoord> value)
        {
            this.uvCoords = value;
            this.numVertices = (ushort)this.uvCoords.Count;
        }

        public Vector3 GetCenter()
        {
            return this.center;
        }

        public void SetCenter(Vector3 value)
        {
            this.center = value;
        }

        public ushort GetConsistencyFlags()
        {
            return this.consistencyFlags;
        }

        public void SetConsistencyFlags(ushort value)
        {
            this.consistencyFlags = value;
        }

        public byte GetKeepFlags()
        {
            return this.keepFlags;
        }

        public void SetKeepFlags(byte value)
        {
            this.keepFlags = value;
        }

        public uint GetSkyrimMaterial()
        {
            return this.skyrimMaterial;
        }

        public void SetSkyrimMaterial(uint value)
        {
            this.skyrimMaterial = value;
        }

        public bool HasVertexColors()
        {
            return this.hasVertexColors;
        }

        public void SetHasVertexColors(bool value)
        {
            this.hasVertexColors = value;
        }

        public ushort GetBSNumUVSets()
        {
            return this.bsNumUVSets;
        }

        public float GetRadius()
        {
            return this.radius;
        }

        public void SetRadius(float value)
        {
            this.radius = value;
        }

        public int GetAdditionalData()
        {
            return this.additionalData;
        }

        public void SetNumUVSets(ushort value)
        {
            int num = (int)this.bsNumUVSets;
            this.bsNumUVSets = (ushort)0;
            if (num >= 4096)
                this.bsNumUVSets = (ushort)4096;
            this.bsNumUVSets += value;
        }

        public void SetHasTangents(bool value)
        {
            int num = (int)this.bsNumUVSets & 1;
            this.bsNumUVSets = (ushort)0;
            if (value)
                this.bsNumUVSets = (ushort)4096;
            this.bsNumUVSets += (ushort)num;
        }

        public void AppendVertices(List<Vector3> verts)
        {
            this.vertices.AddRange((IEnumerable<Vector3>)verts);
            this.numVertices += (ushort)verts.Count;
            this.hasVertices = true;
        }

        public void AppendVertexColors(List<Color4> colors)
        {
            this.vertexColors.AddRange((IEnumerable<Color4>)colors);
            this.hasVertexColors = true;
        }

        public void AppendNormals(List<Vector3> norms)
        {
            this.normals.AddRange((IEnumerable<Vector3>)norms);
            this.hasNormals = true;
        }

        public void AppendTangents(List<Vector3> tans)
        {
            this.tangents.AddRange((IEnumerable<Vector3>)tans);
            this.SetHasTangents(true);
        }

        public void AppendBitangents(List<Vector3> bitans)
        {
            this.bitangents.AddRange((IEnumerable<Vector3>)bitans);
            this.SetHasTangents(true);
        }

        public void AppendUVCoords(List<UVCoord> uvs)
        {
            this.uvCoords.AddRange((IEnumerable<UVCoord>)uvs);
            this.SetNumUVSets((ushort)1);
        }

        public override string GetClassName()
        {
            return "NiGeometryData";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiGeometryData";
            return flag;
        }
    }
}
