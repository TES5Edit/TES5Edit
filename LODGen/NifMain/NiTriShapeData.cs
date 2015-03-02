using LODGenerator.Common;
using System.Collections.Generic;
using System.IO;

namespace LODGenerator.NifMain
{
    public class NiTriShapeData : NiTriBasedGeomData
    {
        protected uint numTrianglePoints;
        protected bool hasTriangles;
        protected List<Triangle> triangles;
        protected ushort numMatchGroups;
        protected List<MatchGroup> matchGroups;

        public NiTriShapeData()
        {
            this.numTrianglePoints = 0U;
            this.hasTriangles = false;
            this.triangles = new List<Triangle>();
            this.numMatchGroups = (ushort)0;
            this.matchGroups = new List<MatchGroup>();
        }

        public NiTriShapeData(NiTriStripsData data)
        {
            this.unknownInt = data.GetUnknownInt();
            this.numVertices = data.GetNumVertices();
            this.hasVertices = data.HasVertices();
            this.vertices = data.GetVertices();
            this.bsNumUVSets = data.GetBSNumUVSets();
            this.unknownInt2 = data.GetUnknownInt2();
            this.hasNormals = data.HasNormals();
            this.normals = data.GetNormals();
            this.tangents = data.GetTangents();
            this.bitangents = data.GetBitangents();
            this.center = data.GetCenter();
            this.radius = data.GetRadius();
            this.hasVertexColors = data.HasVertexColors();
            this.vertexColors = data.GetVertexColors();
            this.uvCoords = data.GetUVCoords();
            this.consistencyFlags = data.GetConsistencyFlags();
            this.additionalData = data.GetAdditionalData();
            this.hasTriangles = true;
            this.numTriangles = data.GetNumTriangles();
            this.numTrianglePoints = (uint)data.GetNumTriangles() * 3U;
            this.triangles = new List<Triangle>();
            for (int index1 = 0; index1 < (int)data.GetNumStrips(); ++index1)
            {
                ushort stripLengthAtIndex = data.GetStripLengthAtIndex(index1);
                List<ushort> pointsAtIndex = data.GetPointsAtIndex(index1);
                for (int index2 = 0; index2 < (int)stripLengthAtIndex - 2; ++index2)
                {
                    ushort _v1;
                    ushort _v2;
                    ushort _v3;
                    if ((index2 + 1) % 2 == 0)
                    {
                        _v1 = pointsAtIndex[index2 + 2];
                        _v2 = pointsAtIndex[index2 + 1];
                        _v3 = pointsAtIndex[index2];
                    }
                    else
                    {
                        _v1 = pointsAtIndex[index2];
                        _v2 = pointsAtIndex[index2 + 1];
                        _v3 = pointsAtIndex[index2 + 2];
                    }
                    this.triangles.Add(new Triangle(_v1, _v2, _v3));
                }
            }
            this.numMatchGroups = (ushort)0;
            this.matchGroups = new List<MatchGroup>();
        }

        public override void Read(NiHeader header, BinaryReader reader)
        {
            base.Read(header, reader);
            this.numTrianglePoints = reader.ReadUInt32();
            this.hasTriangles = Utils.ReadBool(reader);
            if (this.hasTriangles)
            {
                for (int index = 0; index < (int)this.GetNumTriangles(); ++index)
                    this.triangles.Add(Utils.ReadTriangle(reader));
            }
            this.numMatchGroups = reader.ReadUInt16();
            for (int index1 = 0; index1 < (int)this.numMatchGroups; ++index1)
            {
                MatchGroup matchGroup = new MatchGroup();
                matchGroup.numVertices = reader.ReadUInt16();
                matchGroup.vertexIndices = new List<ushort>();
                for (int index2 = 0; index2 < (int)matchGroup.numVertices; ++index2)
                    matchGroup.vertexIndices.Add(reader.ReadUInt16());
                this.matchGroups.Add(matchGroup);
            }
        }

        public override void Write(BinaryWriter writer)
        {
            base.Write(writer);
            writer.Write(this.numTrianglePoints);
            Utils.WriteBool(writer, this.hasTriangles);
            if (this.hasTriangles)
            {
                for (int index = 0; index < this.triangles.Count; ++index)
                    Utils.WriteTriangle(writer, this.triangles[index]);
            }
            writer.Write(this.numMatchGroups);
            for (int index1 = 0; index1 < (int)this.numMatchGroups; ++index1)
            {
                writer.Write(this.matchGroups[index1].numVertices);
                for (int index2 = 0; index2 < (int)this.matchGroups[index1].numVertices; ++index2)
                    writer.Write(this.matchGroups[index1].vertexIndices[index2]);
            }
        }

        public override uint GetSize()
        {
            uint num = base.GetSize() + 7U + 6U * (uint)this.GetNumTriangles();
            for (int index = 0; index < (int)this.numMatchGroups; ++index)
                num += (uint)(2 + 2 * (int)this.matchGroups[index].numVertices);
            return num;
        }

        public void AppendTriangles(List<Triangle> tris)
        {
            this.triangles.AddRange((IEnumerable<Triangle>)tris);
            this.numTriangles += (ushort)(uint)(ushort)tris.Count;
            this.numTrianglePoints += (uint)(ushort)(tris.Count * 3);
            this.hasTriangles = true;
        }

        public void SetTriangles(List<Triangle> tris)
        {
            this.triangles = tris;
            this.numTriangles = (ushort)tris.Count;
            this.numTrianglePoints = (uint)(tris.Count * 3);
            this.hasTriangles = true;
        }

        public List<Triangle> GetTriangles()
        {
            return this.triangles;
        }

        public uint GetNumTrianglePoints()
        {
            return this.numTrianglePoints;
        }

        public override string GetClassName()
        {
            return "NiTriShapeData";
        }

        public override bool IsDerivedType(string type)
        {
            bool flag = base.IsDerivedType(type);
            if (!flag)
                flag = type == "NiTriShapeData";
            return flag;
        }
    }
}
