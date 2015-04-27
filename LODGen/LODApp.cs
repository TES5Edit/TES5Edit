using LODGenerator.Common;
using LODGenerator.NifMain;
using System;
using System.Collections.Generic;
using StringList = System.Collections.Generic.List<string>;
using System.IO;
using System.Threading;
using System.Linq;

namespace LODGenerator
{
    public class LODApp
    {
        private string worldspaceName;
        private string outputDir;
        private string terrainDir;
        private string gameDir;
        private LogFile logFile;
        public List<QuadDesc> quadList;
        public bool verbose;
        public bool fixTangents;
        public bool generateTangents;
        public bool generateVertexColors;
        public bool mergeShapes;
        public bool useHDFlag;
        public bool useOptimizer;
        public bool useFadeNode;
        public bool removeUnseenFaces;
        public bool removeUnderwaterFaces;
        public bool ignoreMaterial;
        public bool skyblivionTexPath;
        public float globalScale;
        public float eliminateSize;
        public int southWestX;
        public int southWestY;
        public float atlasToleranceMin;
        public float atlasToleranceMax;
        public int lodLevelToGenerate;
        public int lodX;
        public int lodY;
        public StringList ignoreTransRot;
        public StringList HDTextureList;
        public StringList notHDTextureList;
        public StringList HDMeshList;
        public StringList notHDMeshList;
        private int quadLevel;
        private int quadIndex;
        private float quadOffset;

        public LODApp(string wsn, string od, string sd, LogFile lf)
        {
            this.worldspaceName = wsn;
            this.outputDir = od;
            this.terrainDir = od + "\\..";
            this.gameDir = sd;
            this.logFile = lf;
            this.quadList = new List<QuadDesc>();
            this.verbose = false;
            this.fixTangents = false;
            this.generateTangents = true;
            this.generateVertexColors = true;
            this.mergeShapes = true;
            this.useHDFlag = false;
            this.useFadeNode = false;
            this.removeUnseenFaces = false;
            this.globalScale = 1f;
            this.eliminateSize = 0.0f;
            this.lodLevelToGenerate = -1;
        }

        private int cellquad(float pos, int southWest)
        {
            // properly address offset world coordinates to match CK
            double xoffset = pos - ((southWest % 4) * 4096);
            int num1 = (int)((double)xoffset / (double)this.quadOffset);
            if ((double)xoffset < 0.0)
                --num1;
            int num3 = num1 * this.quadLevel;
            if (southWest % 4 != 0)
                num3 += southWest % 4;
            return num3;
        }

        private List<QuadDesc> SortMeshesIntoQuads(List<StaticDesc> statics)
        {
            List<QuadDesc> list = new List<QuadDesc>();
            bool flag = false;
            foreach (StaticDesc staticDesc in statics)
            {
                int num3 = cellquad(staticDesc.x, this.southWestX);
                int num4 = cellquad(staticDesc.y, this.southWestY);
                for (int index = 0; index < list.Count; ++index)
                {
                    if (num3 == list[index].x && num4 == list[index].y)
                    {
                        list[index].statics.Add(staticDesc);
                        flag = true;
                        break;
                    }
                }
                if (!flag)
                {
                    QuadDesc quadDesc = new QuadDesc();
                    quadDesc.x = num3;
                    quadDesc.y = num4;
                    quadDesc.statics = new List<StaticDesc>();
                    quadDesc.statics.Add(staticDesc);
                    quadDesc.outValues = new OutDesc();
                    quadDesc.outValues.totalTriCount = 0;
                    quadDesc.outValues.reducedTriCount = 0;
                    list.Add(quadDesc);
                }
                flag = false;
            }
            return list;
        }

        private void GenerateMultibound(NiFile file, BSMultiBoundNode node, QuadDesc curQuad, BBox bb)
        {
            if ((Game.Mode != "fnv") || (Game.Mode == "fnv" && node.GetMultiBound() == -1))
            {
                BSMultiBound bsMultiBound = new BSMultiBound();
                node.SetMultiBound(file.AddBlock((NiObject)bsMultiBound));
                BSMultiBoundAABB bsMultiBoundAabb = new BSMultiBoundAABB();
                bsMultiBound.SetData(file.AddBlock((NiObject)bsMultiBoundAabb));
                float num1 = (float)curQuad.x * 4096f;
                float num2 = (float)curQuad.y * 4096f;
                bsMultiBoundAabb.SetPosition(new Vector3((float)(((double)num1 + (double)bb.px1 + ((double)num1 + (double)bb.px2)) / 2.0), (float)(((double)num2 + (double)bb.py1 + ((double)num2 + (double)bb.py2)) / 2.0), (float)(((double)bb.pz1 + (double)bb.pz2) / 2.0)));
                bsMultiBoundAabb.SetExtent(new Vector3((float)(((double)bb.px2 - (double)bb.px1) / 2.0), (float)(((double)bb.py2 - (double)bb.py1) / 2.0), (float)(((double)bb.pz2 - (double)bb.pz1) / 2.0)));
            }
        }

        // get Clamp_Mode
        private uint GetTextureClampMode(NiFile file, NiTriShape shape)
        {
            uint flags = 3U;
            if (file.GetVersion() > 335544325U)
            {
                if (shape.GetBSProperty(0) != -1)
                {
                    if (file.GetBlockAtIndex(shape.GetBSProperty(0)).GetType() == typeof(BSLightingShaderProperty))
                    {
                        BSLightingShaderProperty lightingShaderProperty = (BSLightingShaderProperty)file.GetBlockAtIndex(shape.GetBSProperty(0));
                        flags = lightingShaderProperty.GetTextureClampMode();
                    }
                    else
                    {
                        BSEffectShaderProperty effectShaderProperty = (BSEffectShaderProperty)file.GetBlockAtIndex(shape.GetBSProperty(0));
                        flags = effectShaderProperty.GetTextureClampMode();
                    }
                }
            }
            return flags;
        }

        // get ShaderFlags1
        private uint GetShaderFlags1(NiFile file, NiTriShape shape)
        {
            uint flags = 0;
            if (file.GetVersion() > 335544325U)
            {
                if (shape.GetBSProperty(0) != -1)
                {
                    if (file.GetBlockAtIndex(shape.GetBSProperty(0)).GetType() == typeof(BSLightingShaderProperty))
                    {
                        BSLightingShaderProperty lightingShaderProperty = (BSLightingShaderProperty)file.GetBlockAtIndex(shape.GetBSProperty(0));
                        flags = lightingShaderProperty.GetShaderFlags1();
                    }
                    else
                    {
                        BSEffectShaderProperty effectShaderProperty = (BSEffectShaderProperty)file.GetBlockAtIndex(shape.GetBSProperty(0));
                        flags = effectShaderProperty.GetShaderFlags1();
                    }
                }
            }
            return flags;
        }

        // get ShaderFlags2 to test for double-sided
        private uint GetShaderFlags2(NiFile file, NiTriShape shape)
        {
            uint flags = 0;
            if (file.GetVersion() > 335544325U)
            {
                if (shape.GetBSProperty(0) != -1)
                {
                    if (file.GetBlockAtIndex(shape.GetBSProperty(0)).GetType() == typeof(BSLightingShaderProperty))
                    {
                        BSLightingShaderProperty lightingShaderProperty = (BSLightingShaderProperty)file.GetBlockAtIndex(shape.GetBSProperty(0));
                        flags = lightingShaderProperty.GetShaderFlags2();
                    }
                    else
                    {
                        BSEffectShaderProperty effectShaderProperty = (BSEffectShaderProperty)file.GetBlockAtIndex(shape.GetBSProperty(0));
                        flags = effectShaderProperty.GetShaderFlags2();
                    }
                }
            }
            return flags;
        }

        private string[] GetMeshTextures(NiFile file, NiTriShape shape)
        {
            string[] strArray = new string[2];
            if ((file.GetVersion() > 335544325U) && (file.GetUserVersion() > 11U))
            {
                if (shape.GetBSProperty(0) != -1)
                {
                    if (file.GetBlockAtIndex(shape.GetBSProperty(0)).GetType() == typeof(BSLightingShaderProperty))
                    {
                        BSLightingShaderProperty lightingShaderProperty = (BSLightingShaderProperty)file.GetBlockAtIndex(shape.GetBSProperty(0));
                        BSShaderTextureSet shaderTextureSet = (BSShaderTextureSet)file.GetBlockAtIndex(lightingShaderProperty.GetTextureSet());
                        strArray[0] = shaderTextureSet.GetTexture(0).ToLower();
                        strArray[1] = shaderTextureSet.GetTexture(1).ToLower();
                    }
                    else
                    {
                        BSEffectShaderProperty effectShaderProperty = (BSEffectShaderProperty)file.GetBlockAtIndex(shape.GetBSProperty(0));
                        strArray[0] = effectShaderProperty.GetSourceTexture().ToLower();
                        strArray[1] = "textures\\default_n.dds";
                    }
                }
                else
                {
                    strArray[0] = "textures\\defaultdiffuse.dds";
                    strArray[1] = "textures\\default_n.dds";
                }
            }
            else
            {
                NiTexturingProperty texturingProperty = (NiTexturingProperty)null;
                for (int index = 0; (long)index < (long)shape.GetNumProperties(); ++index)
                {
                    NiProperty niProperty = (NiProperty)file.GetBlockAtIndex(shape.GetProperty(index));
                    if (niProperty.GetType() == typeof(BSShaderPPLightingProperty))
                    {
                        BSShaderPPLightingProperty lightingShaderProperty = (BSShaderPPLightingProperty)file.GetBlockAtIndex(shape.GetProperty(index));
                        BSShaderTextureSet shaderTextureSet = (BSShaderTextureSet)file.GetBlockAtIndex(lightingShaderProperty.GetTextureSet());
                        strArray[0] = shaderTextureSet.GetTexture(0).ToLower();
                        strArray[1] = shaderTextureSet.GetTexture(1).ToLower();
                        break;
                    }
                    if (niProperty.GetType() == typeof(NiTexturingProperty))
                    {
                        texturingProperty = (NiTexturingProperty)niProperty;
                        string str1 = "textures\\defaultdiffuse.dds";
                        string str2 = "textures\\default_n.dds";
                        if (texturingProperty != null && texturingProperty.HasBaseTexture())
                        {
                            TexDesc baseTextureDesc = texturingProperty.GetBaseTextureDesc();
                            NiSourceTexture niSourceTexture = (NiSourceTexture)null;
                            if (baseTextureDesc.source != -1)
                                niSourceTexture = (NiSourceTexture)file.GetBlockAtIndex(baseTextureDesc.source);
                            else if (texturingProperty.HasDetailTexture())
                            {
                                TexDesc detailTexture = texturingProperty.GetDetailTexture();
                                if (detailTexture.source != -1)
                                    niSourceTexture = (NiSourceTexture)file.GetBlockAtIndex(detailTexture.source);
                            }
                            if (this.skyblivionTexPath)
                            {
                                str1 = niSourceTexture.GetFileName().ToLower().Replace("textures", "textures\\tes4");
                                str2 = str1.Replace(".dds", "_n.dds");
                            }
                            else
                            {
                                str1 = niSourceTexture.GetFileName().ToLower();
                                str2 = str1.Replace(".dds", "_n.dds");
                            }
                        }
                        strArray[0] = str1.ToLower();
                        strArray[1] = str2.ToLower();
                        break;
                    }
                    strArray[0] = "textures\\defaultdiffuse.dds";
                    strArray[1] = "textures\\default_n.dds";
                }
            }
            if (strArray[0].Contains("textures\\"))
            {
                strArray[0] = strArray[0].Remove(0, strArray[0].IndexOf("textures\\"));
            }
            if (strArray[1].Contains("textures\\"))
            {
                strArray[1] = strArray[1].Remove(0, strArray[1].IndexOf("textures\\"));
            }
            return strArray;
        }

        private void GenerateSegments(QuadDesc curQuad, ref ShapeDesc shape)
        {
            // use x, y of object instead of boundingbox center to determine segment
            int num1 = (int)((double)shape.x / ((double)this.quadOffset / 4.0));
            int num2 = (int)((double)shape.y / ((double)this.quadOffset / 4.0));
            if (num1 > 3)
                num1 = 3;
            if (num1 < 0)
                num1 = 0;
            if (num2 > 3)
                num2 = 3;
            if (num2 < 0)
                num2 = 0;
            SegmentDesc segmentDesc = new SegmentDesc();
            segmentDesc.id = 4 * num1 + num2;
            segmentDesc.startTriangle = 0U;
            segmentDesc.numTriangles = shape.data.GetNumTriangles();
            shape.segments = new List<SegmentDesc>();
            shape.segments.Add(segmentDesc);
        }

        private List<ShapeDesc> IterateNodes(QuadDesc quad, StaticDesc stat, int level, NiFile file, NiNode parentNode, Matrix44 parentTransform, float parentScale)
        {
            List<ShapeDesc> list = new List<ShapeDesc>();
            if (parentNode == null || parentNode.IsHidden())
                return list;
            int nameIndex = parentNode.GetNameIndex();
            string str = nameIndex != -1 ? file.GetStringAtIndex(nameIndex) : parentNode.GetName();
            if (str != null && str.ToLower().Contains("editormarker"))
                return list;
            Matrix44 parentTransform1 = parentNode.GetTransform() * parentTransform;
            if (ignoreTransRot.Any(stat.staticModels[level].Contains))
            {
                parentTransform1 = parentTransform;
            }
            float parentScale1 = parentNode.GetScale() * parentScale;
            uint numChildren = parentNode.GetNumChildren();
            for (int index = 0; (long)index < (long)numChildren; ++index)
            {
                NiObject blockAtIndex = file.GetBlockAtIndex(parentNode.GetChildAtIndex(index));
                if (blockAtIndex != null)
                {
                    if (blockAtIndex.IsDerivedType("NiNode"))
                    {
                        list.AddRange((IEnumerable<ShapeDesc>)this.IterateNodes(quad, stat, level, file, (NiNode)blockAtIndex, parentTransform1, parentScale1));
                    }
                    else if (blockAtIndex.IsDerivedType("NiTriBasedGeom"))
                    {
                        NiTriBasedGeom geomOld = (NiTriBasedGeom)blockAtIndex;
                        if (index + 1 < numChildren)
                        {
                            NiObject blockAtIndexNext = file.GetBlockAtIndex(parentNode.GetChildAtIndex(index + 1));
                            if (blockAtIndexNext.IsDerivedType("NiTriBasedGeom"))
                            {
                                NiTriBasedGeom geomOld2 = (NiTriBasedGeom)blockAtIndexNext;
                                if (geomOld.GetData() == geomOld2.GetData())
                                {
                                    //Console.WriteLine(geomOld.GetData() + " = " + geomOld2.GetData());
                                    NiTriBasedGeom geomNew = new NiTriBasedGeom();
                                    geomNew.SetFlags(14);
                                    geomNew.SetTranslation(geomOld.GetTranslation());
                                    geomNew.SetRotation(geomOld.GetRotation());
                                    geomNew.SetScale(geomOld.GetScale());
                                    geomNew.SetNumProperties(geomOld.GetNumProperties());
                                    for (int index2 = 0; (long)index2 < (long)geomOld.GetNumProperties(); ++index2)
                                    {
                                        geomNew.SetProperties(geomOld.GetProperty(index2));
                                    }
                                    NiTriShapeData dataOld = (NiTriShapeData)file.GetBlockAtIndex(geomOld.GetData());
                                    NiTriShapeData dataNew = new NiTriShapeData();
                                    dataNew.SetNumVertices(dataOld.GetNumVertices());
                                    dataNew.SetHasVertices(dataOld.HasVertices());
                                    dataNew.SetVertices(new List<Vector3>(dataOld.GetVertices()));
                                    dataNew.SetNumUVSets(dataOld.GetBSNumUVSets());
                                    dataNew.SetHasNormals(dataOld.HasNormals());
                                    dataNew.SetNormals(new List<Vector3>(dataOld.GetNormals()));
                                    dataNew.SetTangents(new List<Vector3>(dataOld.GetTangents()));
                                    dataNew.SetBitangents(new List<Vector3>(dataOld.GetBitangents()));
                                    dataNew.SetCenter(dataOld.GetCenter());
                                    dataNew.SetRadius(dataOld.GetRadius());
                                    dataNew.SetHasVertexColors(dataOld.HasVertexColors());
                                    dataNew.SetVertexColors(dataOld.GetVertexColors());
                                    dataNew.SetUVCoords(dataOld.GetUVCoords());
                                    dataNew.SetConsistencyFlags(dataOld.GetConsistencyFlags());
                                    dataNew.SetNumTriangles(dataOld.GetNumTriangles());
                                    dataNew.SetNumTrianglePoints(dataOld.GetNumTrianglePoints());
                                    dataNew.SetHasTriangles(dataOld.HasTriangles());
                                    dataNew.SetTriangles(new List<Triangle>(dataOld.GetTriangles()));
                                    int newdata = file.AddBlock(dataNew);
                                    geomNew.SetData(newdata);
                                    int newblock = file.AddBlock(geomNew);
                                    blockAtIndex = file.GetBlockAtIndex(newblock);
                                    //Console.WriteLine("New block " + newdata + " = " + newblock);
                                }
                            }
                        }

                        ShapeDesc shapeDesc = this.TransformShape(quad, stat, file, (NiTriBasedGeom)blockAtIndex, parentTransform1, parentScale1);
                        if (shapeDesc != null && shapeDesc.shape != null)
                        {
                            list.Add(shapeDesc);
                        }
                    }
                }
            }
            /* 
            if (useOptimizer)
            {
                List<ShapeDesc> list2 = new List<ShapeDesc>();
                for (int shapeIndex = 0; shapeIndex < list.Count; shapeIndex++)
                {
                    ShapeDesc shapeDesc = list[shapeIndex];
                    NiTriShapeData data = shapeDesc.data;
                    List<Triangle> triangles = data.GetTriangles();
                    if (data.HasVertexColors() && triangles.Count != 0)
                    {
                        NiTriShapeData data1 = new NiTriShapeData();
                        NiTriShapeData data2 = new NiTriShapeData();
                        List<Color4> vertexcolors = data.GetVertexColors();
                        bool vertexcolors_white = true;
                        bool vertexcolors_colors = true;
                        if (vertexcolors_white && vertexcolors_colors)
                        {
                            Dictionary<ushort, ushort>[] dictionary = new Dictionary<ushort, ushort>[] { new Dictionary<ushort, ushort>(), new Dictionary<ushort, ushort>() };
                            List<Vector3> vertices = data.GetVertices();
                            List<UVCoord> uvcoords = data.GetUVCoords();
                            List<Vector3> normals = data.GetNormals();
                            List<Vector3> tangents = data.GetTangents();
                            List<Vector3> bitangents = data.GetBitangents();
                            List<Triangle>[] triangles1 = new List<Triangle>[] { new List<Triangle>(), new List<Triangle>() };
                            List<Vector3>[] vertices1 = new List<Vector3>[] { new List<Vector3>(), new List<Vector3>() };
                            List<UVCoord>[] uvcoords1 = new List<UVCoord>[] { new List<UVCoord>(), new List<UVCoord>() };
                            List<Color4>[] vertexcolors1 = new List<Color4>[] { new List<Color4>(), new List<Color4>() };
                            List<Vector3>[] normals1 = new List<Vector3>[] { new List<Vector3>(), new List<Vector3>() };
                            List<Vector3>[] tangents1 = new List<Vector3>[] { new List<Vector3>(), new List<Vector3>() };
                            List<Vector3>[] bitangents1 = new List<Vector3>[] { new List<Vector3>(), new List<Vector3>() };
                            UInt16[] index2 = new UInt16[] { 0, 0 };

                            for (int index = 0; index < triangles.Count; ++index)
                            {
                                ushort indexA = triangles[index][0];
                                ushort indexB = triangles[index][1];
                                ushort indexC = triangles[index][2];
                                float colorA = vertexcolors[indexA][0] + vertexcolors[indexA][1] + vertexcolors[indexA][2];
                                float colorB = vertexcolors[indexB][0] + vertexcolors[indexB][1] + vertexcolors[indexB][2];
                                float colorC = vertexcolors[indexC][0] + vertexcolors[indexC][1] + vertexcolors[indexC][2];

                                int shapeSplit = new int();
                                if (colorA > 2.6f && colorB > 2.6f && colorC > 2.6f)
                                {
                                    shapeSplit = 0;
                                }
                                else
                                {
                                    shapeSplit = 1;
                                }
                                if (!dictionary[shapeSplit].ContainsKey(indexA))
                                {
                                    dictionary[shapeSplit].Add(indexA, index2[shapeSplit]);
                                    vertices1[shapeSplit].Add(vertices[indexA]);
                                    if (uvcoords.Count != 0)
                                    {
                                        uvcoords1[shapeSplit].Add(uvcoords[indexA]);
                                    }
                                    if (shapeSplit == 1 && vertexcolors.Count != 0)
                                    {
                                        vertexcolors1[shapeSplit].Add(vertexcolors[indexA]);
                                    }
                                    if (normals.Count != 0)
                                    {
                                        normals1[shapeSplit].Add(normals[indexA]);
                                    }
                                    if (tangents.Count != 0)
                                    {
                                        tangents1[shapeSplit].Add(tangents[indexA]);
                                    }
                                    if (bitangents.Count != 0)
                                    {
                                        bitangents1[shapeSplit].Add(bitangents[indexA]);
                                    }
                                    indexA = index2[shapeSplit];
                                    ++index2[shapeSplit];
                                }
                                else
                                {
                                    indexA = dictionary[shapeSplit][indexA];
                                }
                                if (!dictionary[shapeSplit].ContainsKey(indexB))
                                {
                                    dictionary[shapeSplit].Add(indexB, index2[shapeSplit]);
                                    vertices1[shapeSplit].Add(vertices[indexB]);
                                    if (uvcoords.Count != 0)
                                    {
                                        uvcoords1[shapeSplit].Add(uvcoords[indexB]);
                                    }
                                    if (shapeSplit == 1 && vertexcolors.Count != 0)
                                    {
                                        vertexcolors1[shapeSplit].Add(vertexcolors[indexB]);
                                    }
                                    if (normals.Count != 0)
                                    {
                                        normals1[shapeSplit].Add(normals[indexB]);
                                    }
                                    if (tangents.Count != 0)
                                    {
                                        tangents1[shapeSplit].Add(tangents[indexB]);
                                    }
                                    if (bitangents.Count != 0)
                                    {
                                        bitangents1[shapeSplit].Add(bitangents[indexB]);
                                    }
                                    indexB = index2[shapeSplit];
                                    ++index2[shapeSplit];
                                }
                                else
                                {
                                    indexB = dictionary[shapeSplit][indexB];
                                }
                                if (!dictionary[shapeSplit].ContainsKey(indexC))
                                {
                                    dictionary[shapeSplit].Add(indexC, index2[shapeSplit]);
                                    vertices1[shapeSplit].Add(vertices[indexC]);
                                    if (uvcoords.Count != 0)
                                    {
                                        uvcoords1[shapeSplit].Add(uvcoords[indexC]);
                                    }
                                    if (shapeSplit == 1 && vertexcolors.Count != 0)
                                    {
                                        vertexcolors1[shapeSplit].Add(vertexcolors[indexC]);
                                    }
                                    if (normals.Count != 0)
                                    {
                                        normals1[shapeSplit].Add(normals[indexC]);
                                    }
                                    if (tangents.Count != 0)
                                    {
                                        tangents1[shapeSplit].Add(tangents[indexC]);
                                    }
                                    if (bitangents.Count != 0)
                                    {
                                        bitangents1[shapeSplit].Add(bitangents[indexC]);
                                    }
                                    indexC = index2[shapeSplit];
                                    ++index2[shapeSplit];
                                }
                                else
                                {
                                    indexC = dictionary[shapeSplit][indexC];
                                }
                                triangles1[shapeSplit].Add(new Triangle(indexA, indexB, indexC));
                            }

                            if (triangles1[0].Count != 0)
                            {
                                ShapeDesc shapeDesc1 = new ShapeDesc();
                                shapeDesc1.shape = shapeDesc.shape;
                                shapeDesc1.material = shapeDesc.material;
                                shapeDesc1.textures = shapeDesc.textures;
                                shapeDesc1.isHighDetail = shapeDesc.isHighDetail;
                                shapeDesc1.hasVertexColor = false;
                                shapeDesc1.isDoubleSided = shapeDesc.isDoubleSided;
                                shapeDesc1.TextureClampMode = shapeDesc.TextureClampMode;
                                shapeDesc1.boundingBox = shapeDesc.boundingBox;
                                shapeDesc1.x = shapeDesc.x;
                                shapeDesc1.y = shapeDesc.y;
                                shapeDesc1.segments = shapeDesc.segments;
                                data1.SetNumVertices((ushort)vertices1[0].Count);
                                data1.SetHasVertices(true);
                                data1.SetNumUVSets(4097);
                                data1.SetHasNormals(true);
                                data1.SetCenter(data.GetCenter());
                                data1.SetRadius(data.GetRadius());
                                data1.SetConsistencyFlags(data.GetConsistencyFlags());
                                data1.SetNumTriangles((ushort)triangles1[0].Count);
                                data1.SetNumTrianglePoints((uint)triangles1[0].Count * 3);
                                data1.SetHasTriangles(true);
                                data1.SetHasVertexColors(false);
                                data1.SetVertices(vertices1[0]);
                                data1.SetNormals(normals1[0]);
                                data1.SetTangents(tangents1[0]);
                                data1.SetBitangents(bitangents1[0]);
                                data1.SetUVCoords(uvcoords1[0]);
                                //data1.SetVertexColors(vertexcolors1[0]);
                                data1.SetTriangles(triangles1[0]);
                                shapeDesc1.data = data1;
                                list2.Add(shapeDesc1);
                            }
                            if (triangles1[1].Count != 0)
                            {
                                ShapeDesc shapeDesc2 = new ShapeDesc();
                                shapeDesc2.shape = shapeDesc.shape;
                                shapeDesc2.material = shapeDesc.material;
                                shapeDesc2.textures = shapeDesc.textures;
                                shapeDesc2.isHighDetail = shapeDesc.isHighDetail;
                                shapeDesc2.hasVertexColor = true;
                                shapeDesc2.isDoubleSided = shapeDesc.isDoubleSided;
                                shapeDesc2.TextureClampMode = shapeDesc.TextureClampMode;
                                shapeDesc2.boundingBox = shapeDesc.boundingBox;
                                shapeDesc2.x = shapeDesc.x;
                                shapeDesc2.y = shapeDesc.y;
                                shapeDesc2.segments = shapeDesc.segments;
                                data2.SetNumVertices((ushort)vertices1[0].Count);
                                data2.SetHasVertices(true);
                                data2.SetNumUVSets(4097);
                                data2.SetHasNormals(true);
                                data2.SetCenter(data.GetCenter());
                                data2.SetRadius(data.GetRadius());
                                data2.SetConsistencyFlags(data.GetConsistencyFlags());
                                data2.SetNumTriangles((ushort)triangles1[0].Count);
                                data2.SetNumTrianglePoints((uint)triangles1[0].Count * 3);
                                data2.SetHasTriangles(true);
                                data2.SetHasVertexColors(true);
                                data2.SetVertices(vertices1[1]);
                                data2.SetNormals(normals1[1]);
                                data2.SetTangents(tangents1[1]);
                                data2.SetBitangents(bitangents1[1]);
                                data2.SetUVCoords(uvcoords1[1]);
                                data2.SetVertexColors(vertexcolors1[1]);
                                data2.SetTriangles(triangles1[1]);
                                shapeDesc2.data = data2;
                                list2.Add(shapeDesc2);
                            }
                        }
                        else
                        {
                            list2.Add(shapeDesc);
                        }
                    }
                    else
                    {
                        list2.Add(shapeDesc);
                    }
                }
                return list2;
            }*/
            return list;
        }

        private ShapeDesc TransformShape(QuadDesc quad, StaticDesc stat, NiFile file, NiTriBasedGeom geom, Matrix44 parentTransform, float parentScale)
        {
            BBox bbox = new BBox(float.MaxValue, float.MinValue, float.MaxValue, float.MinValue, float.MaxValue, float.MinValue);
            ShapeDesc shape1 = new ShapeDesc();
            NiTriShape shape2;
            NiTriShapeData data = new NiTriShapeData();
            //Console.WriteLine("Reading block #" + geom.GetData());
            if (geom.GetClassName() == "NiTriStrips")
            {
                shape2 = new NiTriShape(geom);
                data = new NiTriShapeData((NiTriStripsData)file.GetBlockAtIndex(geom.GetData()));
            }
            else if (geom.GetClassName() == "BSLODTriShape")
            {
                shape2 = new NiTriShape(geom);
                data = (NiTriShapeData)file.GetBlockAtIndex(geom.GetData());
            }
            else
            {
                shape2 = new NiTriShape(geom);
                data = (NiTriShapeData)file.GetBlockAtIndex(geom.GetData());
            }
            if (verbose && !data.HasVertexColors() && ((this.GetShaderFlags2(file, shape2) & 32) == 32))
            {
                if (!stat.staticModels[this.quadIndex].Contains("glacierrubbletrim0"))
                {
                    logFile.WriteLog("Vertex Colors Flag, but no vertex colors in " + stat.staticModels[this.quadIndex]);
                }
            }
            if (((int)data.GetBSNumUVSets() & 1) == 0)
                return shape1;
            float _x = stat.x - (float)quad.x * 4096f;
            float _y = stat.y - (float)quad.y * 4096f;
            Matrix33 matrix33_1 = new Matrix33(true);
            Matrix33 matrix33_2 = new Matrix33(true);
            Matrix33 matrix33_3 = new Matrix33(true);
            matrix33_1.SetRotationX(Utils.ToRadians(-stat.rotX));
            matrix33_2.SetRotationY(Utils.ToRadians(-stat.rotY));
            matrix33_3.SetRotationZ(Utils.ToRadians(-stat.rotZ));
            Matrix44 matrix44 = new Matrix44(new Matrix33(true) * matrix33_1 * matrix33_2 * matrix33_3, new Vector3(_x, _y, stat.z), 1f);
            List<Vector3> vertices = new List<Vector3>(data.GetVertices());
            List<Vector3> normals = new List<Vector3>(data.GetNormals());
            List<Vector3> tangents = new List<Vector3>(data.GetTangents());
            List<Vector3> bitangents = new List<Vector3>(data.GetBitangents());
            // generate tangents independent of fix tangents setting
            bool newtangents = false;
            bool newbitangents = false;
            if (this.generateTangents && data.HasNormals())
            {
                if (tangents.Count == 0)
                {
                    newtangents = true;
                    for (int index = 0; index < vertices.Count; ++index)
                        tangents.Add(new Vector3(0.0f, 0.0f, 0.0f));
                }
                if (bitangents.Count == 0)
                {
                    newbitangents = true;
                    for (int index = 0; index < vertices.Count; ++index)
                        bitangents.Add(new Vector3(0.0f, 0.0f, 0.0f));
                }
            }
            for (int index = 0; index < vertices.Count; ++index)
            {
                vertices[index] *= shape2.GetScale() * parentScale;
                vertices[index] *= shape2.GetTransform() * parentTransform;
                vertices[index] *= stat.scale;
                vertices[index] *= matrix44;
                if (data.HasNormals())
                {
                    normals[index] *= parentTransform.RemoveTranslation() * shape2.GetTransform().RemoveTranslation();
                    normals[index] *= matrix44.RemoveTranslation();
                    // adjust tangents as well
                    if (tangents.Count != 0)
                    {
                        tangents[index] *= parentTransform.RemoveTranslation() * shape2.GetTransform().RemoveTranslation();
                        tangents[index] *= matrix44.RemoveTranslation();
                    }
                    // adjust bitangents as well
                    if (bitangents.Count != 0)
                    {
                        bitangents[index] *= parentTransform.RemoveTranslation() * shape2.GetTransform().RemoveTranslation();
                        bitangents[index] *= matrix44.RemoveTranslation();
                    }
                    // fix tangents when they were newly generated
                    if (newtangents || newbitangents || this.fixTangents)
                    {
                        Vector3 vector3_1 = Vector3.Cross(normals[index], new Vector3(0.0f, 0.0f, 1f));
                        Vector3 vector3_2 = Vector3.Cross(normals[index], new Vector3(0.0f, 1f, 0.0f));
                        if (newtangents)
                        {
                            tangents[index] = (double)vector3_1.Length > (double)vector3_2.Length ? vector3_1 : vector3_2;
                            tangents[index].Normalize();
                        }
                        if (newbitangents)
                        {
                            bitangents[index] = Vector3.Cross(normals[index], tangents[index]);
                            bitangents[index].Normalize();
                        }
                    }
                }
                bbox.GrowByVertex(vertices[index]);
                vertices[index] /= (float)this.quadLevel;
            }
            data.SetVertices(vertices);
            if (data.HasNormals())
            {
                data.SetNormals(normals);
                data.SetHasTangents(false);
            }
            data.SetCenter(new Vector3((float)(((double)bbox.px1 + (double)bbox.px2) / 2.0), (float)(((double)bbox.py1 + (double)bbox.py2) / 2.0), (float)(((double)bbox.pz1 + (double)bbox.pz2) / 2.0)) / (float)this.quadLevel);
            data.SetRadius(this.CalcRadius(data));
            data.SetConsistencyFlags((ushort)0);
            data.SetKeepFlags((byte)51);
            data.SetSkyrimMaterial(0U);
            shape1.shape = shape2;
            shape1.data = data;
            // relative x, y for segment
            shape1.x = _x;
            shape1.y = _y;
            shape1.boundingBox = bbox;
            //Console.WriteLine(stat.staticName + " 2 " + stat.refID + " " + file + " " + shape2.GetName() + " ");
            shape1.textures = this.GetMeshTextures(file, shape2);
            shape1.material = stat.materialName;
            shape1.isHighDetail = false;
            if (useHDFlag)
            {
                if ((stat.refFlags & 131072) == 131072)
                {
                    if (HDMeshList.Any(stat.staticModels[this.quadIndex].ToLower().Contains))
                    {
                        shape1.isHighDetail = true;
                    }
                    else if (notHDMeshList.Any(stat.staticModels[this.quadIndex].ToLower().Contains))
                    {
                        shape1.isHighDetail = false;
                    }
                    else
                    {
                        shape1.isHighDetail = true;
                    }
                }
            }
            // Shader Flags 2 SLSF2_Double_Sided
            shape1.isDoubleSided = (this.GetShaderFlags2(file, shape2) & 16) == 16;
            // clamp mode for atlas
            shape1.TextureClampMode = this.GetTextureClampMode(file, shape2);
            /*if ((this.GetShaderFlags1(file, shape2) & 1) == 1)
            {
                //logFile.WriteLog("Specular" + stat.staticModels[this.quadIndex]);
            }*/
            if (AtlasList.Contains(shape1.textures[0]))
            {
                if (this.UVAtlas(data, shape1.textures[0], stat))
                {
                    string[] strArray = new string[2];
                    strArray[0] = AtlasList.Get(shape1.textures[0]).AtlasTexture;
                    strArray[1] = AtlasList.Get(shape1.textures[0]).AtlasTextureN;
                    shape1.textures = strArray;
                    shape1.TextureClampMode = 0U;
                    shape1.isHighDetail = false;
                }
            }
            else
            {
                if (useOptimizer && quadLevel != 4 && shape1.textures[0].ToLower().Contains("mountainslab01"))
                {
                    string[] strArray = new string[2];
                    strArray[0] = "textures\\landscape\\mountains\\mountainslab02.dds";
                    strArray[1] = "textures\\landscape\\mountains\\mountainslab02_n.dds";
                    shape1.textures = strArray;
                }
                if (notHDTextureList.Any(shape1.textures[0].Contains))
                {
                    if (this.verbose)
                    {
                        logFile.WriteLog("No atlas for " + shape1.textures[0] + " in " + stat.staticModels[this.quadIndex]);
                    }
                }
                else
                {
                    if (!useHDFlag)
                    {
                        shape1.isHighDetail = true;
                    }
                }
            }
            if (notHDTextureList.Any(shape1.textures[0].Contains))
            {
                shape1.isHighDetail = false;
            }
            if (HDTextureList.Any(shape1.textures[0].Contains))
            {
                shape1.isHighDetail = true;
            }
            if (shape1.textures[0].Contains("dyndolod\\lod"))
            {
                shape1.TextureClampMode = 0U;
                shape1.isHighDetail = false;
            }
            if (!this.generateVertexColors || (this.quadLevel != 4 && !shape1.isHighDetail))
            {
                data.SetHasVertexColors(false);
                shape1.hasVertexColor = false;
            }
            if (this.generateTangents)
            {
                //shape1.material.Length != 0
                if (!useOptimizer || (useOptimizer && (this.quadLevel == 4 || shape1.isHighDetail)))
                {
                    data.SetTangents(tangents);
                    data.SetBitangents(bitangents);
                }
            }
            if (this.removeUnseenFaces && quad.hasTerrainVertices)
            {
                this.RemoveUnseenFaces(quad, data, shape1);
                if ((int)data.GetNumTriangles() == 0)
                    return (ShapeDesc)null;
            }
            else
            {
                quad.outValues.totalTriCount += data.GetNumTriangles();
                quad.outValues.reducedTriCount += data.GetNumTriangles();
            }
            this.GenerateSegments(quad, ref shape1);
            return shape1;
        }

        private bool UVAtlas(NiTriShapeData data, string texture, StaticDesc stat)
        {
            List<UVCoord> uvcoords = data.GetUVCoords();
            List<UVCoord> uvcoords2 = new List<UVCoord>();
            for (int index = 0; index < uvcoords.Count; ++index)
            {
                float u = uvcoords[index][0];
                float v = uvcoords[index][1];
                if (u < atlasToleranceMin || u > atlasToleranceMax || v < atlasToleranceMin || u > atlasToleranceMax)
                {
                    if (this.verbose && !texture.Contains("glacierslablod"))
                    {
                        logFile.WriteLog("Out of range " + atlasToleranceMin + " <= " + u + ", " + v + " <= " + atlasToleranceMax + " for " + texture + " in " + stat.staticModels[this.quadIndex]);
                    }
                    return false;
                }
                u = Math.Max(u, 0);
                v = Math.Max(v, 0);
                u = Math.Min(u, 1);
                v = Math.Min(v, 1);
                u *= AtlasList.Get(texture).scaleU;
                v *= AtlasList.Get(texture).scaleV;
                u += AtlasList.Get(texture).posU;
                v += AtlasList.Get(texture).posV;
                UVCoord coords = new UVCoord(u, v);
                uvcoords2.Add(coords);
            }
            data.SetUVCoords(uvcoords2);
            return true;
        }

        private float GetTriangleHeight(List<Vector3> verts, List<Triangle> tris, Vector3 pt)
        {
            for (int index = 0; index < tris.Count; ++index)
            {
                Triangle triangle = tris[index];
                float u;
                float v;
                if (Utils.PointInTriangle(new Vector2(pt[0], pt[1]),
                    new Vector2(verts[(int)triangle[0]][0], verts[(int)triangle[0]][1]),
                    new Vector2(verts[(int)triangle[1]][0], verts[(int)triangle[1]][1]),
                    new Vector2(verts[(int)triangle[2]][0], verts[(int)triangle[2]][1]), out u, out v))
                {
                    Vector3 vector3_1 = verts[(int)triangle[0]];
                    Vector3 vector3_2 = verts[(int)triangle[1]];
                    Vector3 vector3_3 = verts[(int)triangle[2]];
                    return (vector3_2[2] - vector3_1[2]) * v + vector3_1[2] + ((vector3_3[2] - vector3_1[2]) * u + vector3_1[2]) - vector3_1[2];
                }
            }
            return float.MinValue;
        }

        private void RemoveUnseenFaces(QuadDesc quad, NiTriShapeData data, ShapeDesc shape)
        {
            List<Triangle> triangles = data.GetTriangles();
            List<Vector3> vertices = data.GetVertices();
            int count = triangles.Count;
            quad.outValues.totalTriCount += count;
            int loops = 0;
            if (this.removeUnderwaterFaces)
            {
                loops = 1;
            }
            for (int loop = 0; loop <= loops; loop++)
            {
                for (int index = 0; index < triangles.Count; ++index)
                {
                    QuadDesc quadCurrent = new QuadDesc();
                    List<Triangle> trianglesCompare = new List<Triangle>();
                    List<Vector3> verticesCompare = new List<Vector3>();
                    bool[] vertexBelow = new bool[3];
                    for (int index1 = 0; index1 < 3; index1++)
                    {
                        Vector3 vertex = vertices[triangles[index][index1]];
                        float x = vertex[0];
                        float y = vertex[1];
                        int vertexQuadx = quad.x + cellquad(x * quadLevel, southWestX);
                        int vertexQuady = quad.y + cellquad(y * quadLevel, southWestY);
                        if (quad.x != vertexQuadx || quad.y != vertexQuady)
                        {
                            for (int index3 = 0; index3 < this.quadList.Count; ++index3)
                            {
                                if (vertexQuadx == this.quadList[index3].x && vertexQuady == this.quadList[index3].y)
                                {
                                    quadCurrent = this.quadList[index3];
                                    x -= (vertexQuadx - quad.x) / quadLevel * 4096;
                                    y -= (vertexQuady - quad.y) / quadLevel * 4096;
                                    break;
                                }
                            }
                        }
                        else
                        {
                            quadCurrent = quad;
                        }
                        if (!quadCurrent.hasTerrainVertices)
                        {
                            continue;
                        }
                        Vector3 vertex1 = new Vector3(x, y, vertex[2]);
                        List<Triangle> trianglesTerrain = new List<Triangle>();
                        List<Vector3> verticesTerrain = new List<Vector3>();
                        if (this.removeUnderwaterFaces && loop == 0)
                        {
                            if (quadCurrent.waterQuadTree != null)
                            {
                                trianglesTerrain = quadCurrent.waterQuadTree.entirequad.triangles;
                                verticesTerrain = quadCurrent.waterQuadTree.vertices;
                            }
                        }
                        else
                        {
                            trianglesTerrain = quadCurrent.terrainQuadTree.GetSegment(vertex1, quadLevel);
                            verticesTerrain = quadCurrent.terrainQuadTree.vertices;
                        }
                        if (trianglesTerrain == null)
                        {
                            vertexBelow[index1] = true;
                        }
                        else
                        {
                            if (trianglesTerrain.Count != 0)
                            {
                                float num1 = float.MaxValue;
                                num1 = GetTriangleHeight(verticesTerrain, trianglesTerrain, vertex1);
                                if (vertex1[2] < num1)
                                {
                                    vertexBelow[index1] = true;
                                }
                            }
                        }
                    }
                    if (vertexBelow[0] && vertexBelow[1] && vertexBelow[2])
                    {
                        triangles.RemoveAt(index);
                        --index;
                    }
                }
            }
 
            // remove elements from other lists too
            if (triangles.Count != 0 && triangles.Count != count)
            {
                Dictionary<ushort, ushort> dictionary = new Dictionary<ushort, ushort>();
                List<Vector3> vertices2 = new List<Vector3>();
                List<UVCoord> uvcoords = data.GetUVCoords();
                List<UVCoord> uvcoords2 = new List<UVCoord>();
                List<Color4> vertexcolors = data.GetVertexColors();
                List<Color4> vertexcolors2 = new List<Color4>();
                List<Vector3> normals = data.GetNormals();
                List<Vector3> normals2 = new List<Vector3>();
                List<Vector3> tangents = data.GetTangents();
                List<Vector3> tangents2 = new List<Vector3>();
                List<Vector3> bitangents = data.GetBitangents();
                List<Vector3> bitangents2 = new List<Vector3>();
                ushort index2 = 0;
                bool vertexcolors_allwhite = true;
                for (int index = 0; index < triangles.Count; ++index)
                {
                    for (int index3 = 0; index3 < 3; ++index3)
                    {
                        ushort v1 = triangles[index][index3];
                        if (!dictionary.ContainsKey(v1))
                        {
                            dictionary.Add(v1, index2);
                            ++index2;
                            if (vertices.Count != 0)
                            {
                                vertices2.Add(vertices[v1]);
                            }
                            if (uvcoords.Count != 0)
                            {
                                uvcoords2.Add(uvcoords[v1]);
                            }
                            if (vertexcolors.Count != 0)
                            {
                                float r = vertexcolors[v1][0];
                                float g = vertexcolors[v1][1];
                                float b = vertexcolors[v1][2];
                                if (r != 1f || b != 1f || g != 1f)
                                {
                                    vertexcolors_allwhite = false;
                                }
                                vertexcolors2.Add(vertexcolors[v1]);
                            }
                            if (normals.Count != 0)
                            {
                                normals2.Add(normals[v1]);
                            }
                            if (tangents.Count != 0)
                            {
                                tangents2.Add(tangents[v1]);
                            }
                            if (bitangents.Count != 0)
                            {
                                bitangents2.Add(bitangents[v1]);
                            }
                        }
                    }
                }
                // update indexes of triangles
                for (int index = 0; index < triangles.Count; ++index)
                {
                    for (int index3 = 0; index3 < 3; ++index3)
                    {
                        ushort key = triangles[index][index3];
                        if (!dictionary.ContainsKey(key))
                        {
                            this.logFile.WriteLog("no index for " + key);
                        }
                        ushort v1 = dictionary[key];
                        Triangle triangle;
                        (triangle = triangles[index])[index3] = (v1);
                    }
                }
                if (vertices2.Count != 0)
                {
                    data.SetVertices(vertices2);
                }
                if (uvcoords2.Count != 0)
                {
                    data.SetUVCoords(uvcoords2);
                }
                if (vertexcolors2.Count != 0)
                {
                    if (vertexcolors_allwhite)
                    {
                        data.SetHasVertexColors(false);
                        shape.hasVertexColor = false;
                    }
                    else
                    {
                        data.SetHasVertexColors(true);
                        shape.hasVertexColor = true;
                        data.SetVertexColors(vertexcolors2);
                    }
                }
                if (normals2.Count != 0)
                {
                    data.SetNormals(normals2);
                }
                if (tangents2.Count != 0)
                {
                    data.SetTangents(tangents2);
                }
                if (bitangents2.Count != 0)
                {
                    data.SetBitangents(bitangents2);
                }
            }
            quad.outValues.reducedTriCount += triangles.Count;
            data.SetTriangles(triangles);
        }

        private List<ShapeDesc> ParseNif(QuadDesc quad, StaticDesc curStat, int level, NiFile file, NiNode rootNode)
        {
            NiFile file1 = new NiFile();
            file1.Read(this.gameDir, curStat.staticModels[level], this.logFile);
            return this.IterateNodes(quad, curStat, level, file1, (NiNode)file1.GetBlockAtIndex(0), new Matrix44(true), 1f);
        }

        private void CreateLODNodes(NiFile file, NiNode rootNode, QuadDesc quad, List<ShapeDesc> shapes)
        {
            foreach (ShapeDesc shapeDesc in shapes)
            {
                BSMultiBoundNode node = new BSMultiBoundNode();
                rootNode.AddChild(file.AddBlock((NiObject)node));
                BSSegmentedTriShape segmentedTriShape = new BSSegmentedTriShape((NiGeometry)shapeDesc.shape);
                node.AddChild(file.AddBlock((NiObject)segmentedTriShape));
                node.SetCullMode(1U);
                string str = "obj";
                // use material name from list file, Snow/Ash
                if (!this.ignoreMaterial && shapeDesc.material != "")
                {
                    str = str + shapeDesc.material;
                }
                // only level 4 should have HD
                if (shapeDesc.isHighDetail && (this.quadLevel == 4 || this.useHDFlag))
                {
                    str = str + "HD";
                }
                segmentedTriShape.SetNameIndex(file.AddString(str));
                segmentedTriShape.SetFlags((ushort)14);
                segmentedTriShape.SetFlags2((ushort)8320);
                segmentedTriShape.SetData(file.AddBlock((NiObject)shapeDesc.data));
                segmentedTriShape.SetBSProperty(1, -1);
                segmentedTriShape.SetScale((float)this.quadLevel);
                segmentedTriShape.SetRotation(new Matrix33(true));
                segmentedTriShape.SetTranslation(new Vector3((float)quad.x * 4096f, (float)quad.y * 4096f, 0.0f));
                for (int index = 0; index < 16; ++index)
                {
                    segmentedTriShape.AddSegment(new BSSegment(0U, (ushort)0));
                }
                for (int index = 0; index < shapeDesc.segments.Count; ++index)
                {
                    BSSegment segmentAtIndex = segmentedTriShape.GetSegmentAtIndex(shapeDesc.segments[index].id);
                    segmentAtIndex.startTriangle = shapeDesc.segments[index].startTriangle;
                    segmentAtIndex.numTriangles = shapeDesc.segments[index].numTriangles;
                    segmentedTriShape.SetSegment(shapeDesc.segments[index].id, segmentAtIndex);
                }
                for (int index = 15; index >= 0 && (int)segmentedTriShape.GetSegmentAtIndex(index).numTriangles == 0; --index)
                {
                    segmentedTriShape.RemoveSegment(index);
                }
                BSShaderTextureSet shaderTextureSet = new BSShaderTextureSet();
                BSLightingShaderProperty lightingShaderProperty = new BSLightingShaderProperty();
                segmentedTriShape.SetBSProperty(0, file.AddBlock((NiObject)lightingShaderProperty));
                lightingShaderProperty.SetTextureSet(file.AddBlock((NiObject)shaderTextureSet));
                lightingShaderProperty.SetLightingEffect1(0.0f);
                lightingShaderProperty.SetLightingEffect2(0.0f);
                lightingShaderProperty.SetGlossiness(1f);
                lightingShaderProperty.SetTextureClampMode(shapeDesc.TextureClampMode);
                uint num1 = 2151677952U;
                /*if (this.quadLevel == 4)
                {
                    num1 = 2151678720U; // Recieve/Cast Shadows - no worky :(
                }*/
                uint num3 = 1U; // ZBuffer_Write
                if (shapeDesc.isHighDetail && (this.quadLevel == 4 || this.useHDFlag))
                {
                    num3 |= 2147483648U; //HD_LOD_Objects
                }
                else
                {
                    num3 |= 4U; //LOD_Objects
                }
                if (shapeDesc.data.HasVertexColors())
                    num3 |= 32U;
                // set double-sided flag
                if (shapeDesc.isDoubleSided)
                    num3 |= 16;
                lightingShaderProperty.SetShaderFlags1(num1);
                lightingShaderProperty.SetShaderFlags2(num3);
                shaderTextureSet.SetNumTextures(9);
                shaderTextureSet.SetTexture(0, shapeDesc.textures[0]);
                shaderTextureSet.SetTexture(1, shapeDesc.textures[1]);
                this.GenerateMultibound(file, node, quad, shapeDesc.boundingBox);
            }
        }

        private void CreateLODNodesFNV(NiFile file, BSMultiBoundNode node, QuadDesc quad, List<ShapeDesc> shapes)
        {
            foreach (ShapeDesc shapeDesc in shapes)
            {
                BSSegmentedTriShape segmentedTriShape = new BSSegmentedTriShape((NiGeometry)shapeDesc.shape);
                node.AddChild(file.AddBlock((NiObject)segmentedTriShape));
                node.SetCullMode(1U);
                string str = "obj";
                // use material name from list file, Snow/Ash
                if (!this.ignoreMaterial && shapeDesc.material != "")
                    str = str + shapeDesc.material;
                // only level 4 should have HD
                if (shapeDesc.isHighDetail && (this.quadLevel == 4 || useHDFlag))
                {
                    str = str + "HD";
                }
                //segmentedTriShape.SetNameIndex(file.AddString(str));
                segmentedTriShape.SetFlags((ushort)14);
                segmentedTriShape.SetFlags2((ushort)8);
                //segmentedTriShape.SetBSProperty(1, -1);
                segmentedTriShape.SetTranslation(new Vector3((float)quad.x * 4096f, (float)quad.y * 4096f, 0.0f));
                segmentedTriShape.SetRotation(new Matrix33(true));
                segmentedTriShape.SetScale((float)this.quadLevel);

                BSShaderTextureSet shaderTextureSet = new BSShaderTextureSet();
                BSShaderPPLightingProperty lightingShaderProperty = new BSShaderPPLightingProperty();
                segmentedTriShape.SetProperties(file.AddBlock((NiObject)lightingShaderProperty));
                lightingShaderProperty.SetTextureSet(file.AddBlock((NiObject)shaderTextureSet));
                shaderTextureSet.SetNumTextures(6);
                shaderTextureSet.SetTexture(0, shapeDesc.textures[0]);
                shaderTextureSet.SetTexture(1, shapeDesc.textures[1]);
                segmentedTriShape.SetData(file.AddBlock((NiObject)shapeDesc.data));
                for (int index = 0; index < 16; ++index)
                    segmentedTriShape.AddSegment(new BSSegment(0U, (ushort)0));
                for (int index = 0; index < shapeDesc.segments.Count; ++index)
                {
                    BSSegment segmentAtIndex = segmentedTriShape.GetSegmentAtIndex(shapeDesc.segments[index].id);
                    segmentAtIndex.startTriangle = shapeDesc.segments[index].startTriangle;
                    segmentAtIndex.numTriangles = shapeDesc.segments[index].numTriangles;
                    segmentedTriShape.SetSegment(shapeDesc.segments[index].id, segmentAtIndex);
                }
                for (int index = 15; index >= 0 && (int)segmentedTriShape.GetSegmentAtIndex(index).numTriangles == 0; --index)
                {
                    segmentedTriShape.RemoveSegment(index);
                }
                this.GenerateMultibound(file, node, quad, shapeDesc.boundingBox);
            }
        }

        private void MergeNodes(List<ShapeDesc> shapes)
        {
            int count = shapes.Count;
            Dictionary<string, List<ShapeDesc>> dictionary = new Dictionary<string, List<ShapeDesc>>();
            for (int index = 0; index < shapes.Count; ++index)
            {
                ShapeDesc shape = new ShapeDesc();
                shape = shapes[index];
                string key = shape.textures[0].ToLower();
                // use vertex color flag to seperate?
                // less draw calls more important than reducing a few bytes?
                // overall it is not even reducing bytes... so no
                /*if (useOptimizer && shape.data.HasVertexColors())
                {
                    key = key + "_VC";
                }*/
                // use material name from list file, Snow/Ash
                if (!this.ignoreMaterial && shape.material != "")
                {
                    key = key + "_" + shape.material;
                }
                // only level 4 should have HD
                if (shape.isHighDetail && (this.quadLevel == 4 || useHDFlag))
                {
                    key = key + "_HD";
                }
                // double-sided
                if (shape.isDoubleSided)
                {
                    key = key + "_DS";
                }
                // clamp mode
                key = key + "_" + shape.TextureClampMode;
                if (dictionary.ContainsKey(key))
                {
                    dictionary[key].Add(shape);
                }
                else
                {
                    dictionary.Add(key, new List<ShapeDesc>());
                    dictionary[key].Add(shape);
                }
            }
            shapes.Clear();
            foreach (KeyValuePair<string, List<ShapeDesc>> keyValuePair in dictionary)
            {
                if (keyValuePair.Value.Count == 1)
                {
                    shapes.Add(keyValuePair.Value[0]);
                }
                else
                {
                    SegmentDesc segmentDesc = (SegmentDesc)null;
                    uint num1 = 0U;
                    uint num2 = 0U;
                    int num3 = -1;
                    NiTriShape niTriShape = new NiTriShape();
                    NiTriShapeData data = new NiTriShapeData();
                    List<ShapeDesc> list = keyValuePair.Value;
                    string str1 = list[0].textures[0];
                    string str2 = list[0].textures[1];
                    string str3 = list[0].material;
                    //bool isVC = list[0].hasVertexColor;
                    bool isHD = list[0].isHighDetail;
                    // double-sided
                    bool isDS = list[0].isDoubleSided;
                    // clamp mode
                    uint clampmode = list[0].TextureClampMode;
                    bool allwhite = true;
                    list.Sort((Comparison<ShapeDesc>)((a, b) =>
                    {
                        if (a.segments[0].id > b.segments[0].id)
                            return 1;
                        return a.segments[0].id < b.segments[0].id ? -1 : 0;
                    }));
                    ShapeDesc shapeDesc = new ShapeDesc();
                    shapeDesc.boundingBox.Set(float.MaxValue, float.MinValue, float.MaxValue, float.MinValue, float.MaxValue, float.MinValue);
                    for (int index1 = 0; index1 < list.Count; ++index1)
                    {
                        NiTriShapeData niTriShapeData = list[index1].data;
                        List<Vector3> vertices = niTriShapeData.GetVertices();
                        List<Triangle> triangles = new List<Triangle>(niTriShapeData.GetTriangles());
                        if ((uint)data.GetNumVertices() + (uint)vertices.Count > (uint)ushort.MaxValue || (uint)data.GetNumTriangles() + (uint)triangles.Count > (uint)ushort.MaxValue)
                        {
                            data.SetCenter(shapeDesc.boundingBox.GetCenter() / (float)this.quadLevel);
                            data.SetRadius(this.CalcRadius(data));
                            shapeDesc.segments.Add(segmentDesc);
                            shapeDesc.shape = niTriShape;
                            shapeDesc.data = data;
                            shapeDesc.textures = new string[2];
                            shapeDesc.textures[0] = str1;
                            shapeDesc.textures[1] = str2;
                            shapeDesc.material = str3;
                            shapeDesc.isHighDetail = isHD;
                            //shapeDesc.hasVertexColor = isVC;
                            // double-sided
                            shapeDesc.isDoubleSided = isDS;
                            //clamp mode
                            shapeDesc.TextureClampMode = clampmode;
                            shapes.Add(shapeDesc);
                            shapeDesc = new ShapeDesc();
                            shapeDesc.boundingBox.Set(float.MaxValue, float.MinValue, float.MaxValue, float.MinValue, float.MaxValue, float.MinValue);
                            niTriShape = new NiTriShape();
                            data = new NiTriShapeData();
                            num1 = 0U;
                            num2 = 0U;
                            num3 = -1;
                        }
                        for (int index2 = 0; index2 < (int)niTriShapeData.GetNumVertices(); ++index2)
                        {
                            Vector3 vector3 = vertices[index2] * (float)this.quadLevel;
                            shapeDesc.boundingBox.GrowByVertex(vector3);
                        }
                        data.AppendVertices(niTriShapeData.GetVertices());
                        data.AppendNormals(niTriShapeData.GetNormals());
                        data.AppendUVCoords(niTriShapeData.GetUVCoords());
                        if (this.generateTangents)
                        {
                            //str3.Length != 0
                            if (!useOptimizer || (useOptimizer && (this.quadLevel == 4 || isHD)))
                            {
                                data.AppendTangents(niTriShapeData.GetTangents());
                                data.AppendBitangents(niTriShapeData.GetBitangents());
                            }
                        }
                        // only level 4 should have vertex colors
                        if (this.generateVertexColors && (this.quadLevel == 4 || isHD))
                        {
                            List<Color4> colors = new List<Color4>();
                            if (niTriShapeData.HasVertexColors())
                            {
                                colors = niTriShapeData.GetVertexColors();
                                data.AppendVertexColors(colors);
                                for (int index2 = 0; index2 < colors.Count; index2++)
                                {
                                    if (colors[index2][0] != 1f || colors[index2][2] != 1f || colors[index2][2] != 1f)
                                    {
                                        allwhite = false;
                                        break;
                                    }
                                }
                            }
                            else
                            {
                                for (int index2 = 0; index2 < vertices.Count; ++index2)
                                {
                                    colors.Add(new Color4(1f, 1f, 1f, 1f));
                                }
                                data.AppendVertexColors(colors);
                            }
                        }
                        List<Triangle> trianglesNew = new List<Triangle>();
                        for (int index2 = 0; index2 < (int)niTriShapeData.GetNumTriangles(); ++index2)
                        {
                            trianglesNew.Add(new Triangle((ushort)(triangles[index2][0] + num1), (ushort)(triangles[index2][1] + num1), (ushort)(triangles[index2][2] + num1)));
                        }
                        data.AppendTriangles(trianglesNew);
                        num1 += (uint)niTriShapeData.GetNumVertices();
                        if (list[index1].segments[0].id != num3)
                        {
                            if (num3 != -1)
                            {
                                num2 += (uint)segmentDesc.numTriangles * 3U;
                                shapeDesc.segments.Add(segmentDesc);
                            }
                            segmentDesc = new SegmentDesc();
                            segmentDesc.id = list[index1].segments[0].id;
                            segmentDesc.startTriangle = num2;
                            segmentDesc.numTriangles = list[index1].segments[0].numTriangles;
                            num3 = list[index1].segments[0].id;
                        }
                        else
                            segmentDesc.numTriangles += list[index1].data.GetNumTriangles();
                    }
                    data.SetCenter(shapeDesc.boundingBox.GetCenter() / (float)this.quadLevel);
                    data.SetRadius(this.CalcRadius(data));
                    shapeDesc.segments.Add(segmentDesc);
                    shapeDesc.shape = niTriShape;
                    shapeDesc.data = data;
                    shapeDesc.textures = new string[2];
                    shapeDesc.textures[0] = str1;
                    shapeDesc.textures[1] = str2;
                    shapeDesc.material = str3;
                    //shapeDesc.hasVertexColor = isVC;
                    shapeDesc.isHighDetail = isHD;
                    // double-sided
                    shapeDesc.isDoubleSided = isDS;
                    // clamp mode
                    shapeDesc.TextureClampMode = clampmode;
                    if (allwhite)
                    {
                        shapeDesc.data.SetHasVertexColors(false);
                        shapeDesc.hasVertexColor = false;
                    }
                    else
                    {
                        shapeDesc.data.SetHasVertexColors(true);
                        shapeDesc.hasVertexColor = true;
                    }
                    shapes.Add(shapeDesc);
                }
            }
        }

        private float CalcRadius(NiTriShapeData data)
        {
            float num1 = float.MinValue;
            for (int index = 0; index < (int)data.GetNumVertices(); ++index)
            {
                Vector3 vector3_1 = data.GetVertices()[index];
                Vector3 vector3_2 = data.GetCenter() - vector3_1;
                float num2 = (float)((double)vector3_2[0] * (double)vector3_2[0] + (double)vector3_2[1] * (double)vector3_2[1] + (double)vector3_2[2] * (double)vector3_2[2]);
                if ((double)num2 > (double)num1)
                    num1 = num2;
            }
            return (float)Math.Sqrt((double)num1);
        }

        private bool LoadTerrainQuad(QuadDesc quad, out QuadTree qt, out QuadTree waterQt, out BBox boundingBox)
        {
            bool flag = false;
            string str = "";
            if (Game.Mode == "fnv")
            {
                str = "meshes\\landscape\\lod\\" + this.worldspaceName + "\\" + this.worldspaceName + ".Level" + this.quadLevel.ToString() + ".X" + quad.x.ToString() + ".Y" + quad.y.ToString() + ".nif";
            }
            else
            {
                str = "meshes\\terrain\\" + this.worldspaceName + "\\" + this.worldspaceName + "." + this.quadLevel.ToString() + "." + quad.x.ToString() + "." + quad.y.ToString() + ".btr";
            }
            boundingBox = new BBox();
            qt = (QuadTree)null;
            waterQt = (QuadTree)null;
            if (!File.Exists(this.gameDir + str) && !BSAArchive.FileExists(str))
            {
                if (this.verbose)
                {
                    this.logFile.WriteLog("terrain file not found " + str);
                }
            }
            else
            {
                //Console.WriteLine("Doing " + str);
                //logFile.WriteLog("Doing " + str);
                NiFile niFile = new NiFile();
                niFile.Read(this.gameDir, str, logFile);
                BSMultiBoundNode bsMultiBoundNode1 = (BSMultiBoundNode)niFile.GetBlockAtIndex(0);
                if (bsMultiBoundNode1 != null && bsMultiBoundNode1.GetNumChildren() > 0U)
                {
                    BSMultiBound bsMultiBound1 = (BSMultiBound)niFile.GetBlockAtIndex(bsMultiBoundNode1.GetMultiBound());
                    BSMultiBoundAABB bsMultiBoundAabb1 = bsMultiBound1 != null ? (BSMultiBoundAABB)niFile.GetBlockAtIndex(bsMultiBound1.GetData()) : (BSMultiBoundAABB)null;
                    if (bsMultiBound1 != null && bsMultiBoundAabb1 != null)
                    {
                        NiTriShape niTriShape = (NiTriShape)niFile.GetBlockAtIndex(bsMultiBoundNode1.GetChildAtIndex(0));
                        if (niTriShape != null)
                        {
                            NiTriShapeData data = (NiTriShapeData)niFile.GetBlockAtIndex(niTriShape.GetData());
                            Vector3 vector3_1 = bsMultiBoundAabb1.GetPosition() / 4;
                            Vector3 vector3_2 = bsMultiBoundAabb1.GetExtent() / 4;
                            boundingBox.Set(vector3_1[0] - vector3_2[0], vector3_1[0] + vector3_2[0], vector3_1[1] - vector3_2[1], vector3_1[1] + vector3_2[1], vector3_1[2] - vector3_2[2], vector3_1[2] + vector3_2[2]);
                            List<Vector3> vertices = data.GetVertices();
                            if (Game.Mode == "fnv")
                            {
                                for (int index = 0; index < vertices.Count; index++)
                                {
                                    vertices[index] = vertices[index] / quadLevel;
                                }
                            }
                            List<Triangle> triangles = data.GetTriangles();
                            for (int index = 0; index < triangles.Count; index++)
                            {
                                Vector3 vertA = vertices[triangles[index][0]];
                                Vector3 vertB = vertices[triangles[index][1]];
                                Vector3 vertC = vertices[triangles[index][2]];
                                if ((vertA[0] == 0 && vertB[0] == 0 && vertC[0] == 0) || (vertA[0] == 4096 && vertB[0] == 4096 && vertC[0] == 4096) || (vertA[1] == 0 && vertB[1] == 0 && vertC[1] == 0) || (vertA[1] == 4096 && vertB[1] == 4096 && vertC[1] == 4096))
                                {
                                    triangles.RemoveAt(index);
                                    --index;
                                }
                            }
                            data.SetVertices(vertices);
                            data.SetTriangles(triangles);
                            qt = new QuadTree(data, quadLevel);
                            if (qt != null)
                                flag = true;
                        }
                    }
                    if (Game.Mode != "fnv" && this.removeUnderwaterFaces && bsMultiBoundNode1.GetNumChildren() > 1U)
                    {
                        BSMultiBoundNode bsMultiBoundNode2 = (BSMultiBoundNode)niFile.GetBlockAtIndex(bsMultiBoundNode1.GetChildAtIndex(1));
                        if (bsMultiBoundNode2 != null)
                        {
                            BSMultiBound bsMultiBound2 = (BSMultiBound)niFile.GetBlockAtIndex(bsMultiBoundNode2.GetMultiBound());
                            BSMultiBoundAABB bsMultiBoundAabb2 = (BSMultiBoundAABB)niFile.GetBlockAtIndex(bsMultiBound2.GetData());
                            NiTriShapeData datacombined = new NiTriShapeData();
                            ushort numVertices = 0;
                            for (int index = 0; index < bsMultiBoundNode2.GetNumChildren(); index++)
                            {
                                NiObject blockAtIndex = niFile.GetBlockAtIndex(bsMultiBoundNode2.GetChildAtIndex(index));
                                if (blockAtIndex != null)
                                {
                                    NiTriShapeData data;
                                    if (blockAtIndex.GetClassName() == "BSSegmentedTriShape")
                                    {
                                        BSSegmentedTriShape segmentedTriShape = (BSSegmentedTriShape)blockAtIndex;
                                        data = (NiTriShapeData)niFile.GetBlockAtIndex(segmentedTriShape.GetData());
                                    }
                                    else
                                    {
                                        NiTriShape niTriShape = (NiTriShape)blockAtIndex;
                                        data = (NiTriShapeData)niFile.GetBlockAtIndex(niTriShape.GetData());
                                    }
                                    if (index == 0)
                                    {
                                        datacombined = data;
                                        numVertices += data.GetNumVertices();
                                    }
                                    else
                                    {
                                        datacombined.AppendVertices(data.GetVertices());
                                        List<Triangle> triangles = new List<Triangle>(data.GetTriangles());
                                        for (int index2 = 0; index2 < triangles.Count; ++index2)
                                        {
                                            triangles[index2][0] += numVertices;
                                            triangles[index2][1] += numVertices;
                                            triangles[index2][2] += numVertices;
                                        }
                                        datacombined.AppendTriangles(triangles);
                                        numVertices += data.GetNumVertices();
                                    }
                                }
                            }
                            Vector3 vector3_1 = bsMultiBoundAabb2.GetPosition() / 4;
                            Vector3 vector3_2 = bsMultiBoundAabb2.GetExtent() / 4;
                            BBox boundingBox1 = new BBox(vector3_1[0] - vector3_2[0], vector3_1[0] + vector3_2[0], vector3_1[1] - vector3_2[1], vector3_1[1] + vector3_2[1], vector3_1[2] - vector3_2[2], vector3_1[2] + vector3_2[2]);
                            waterQt = new QuadTree(datacombined, quadLevel);
                        }
                    }
                }
            }
            return flag;
        }

        public void GenerateLOD(int index, int level, List<StaticDesc> statics)
        {
            this.quadIndex = index;
            if (Game.Mode == "fnv")
            {
                this.quadLevel = 4;
                this.quadOffset = 16384f;
                if (level == 4)
                {
                    return;
                }
            }
            else
            {
                this.quadLevel = level * 4;
                this.quadOffset = (float)level * 16384f;
            }
            if (this.lodLevelToGenerate != -1 && this.lodLevelToGenerate != this.quadLevel)
                return;
            //Console.WriteLine("Level=" + LODLevel + " quadLevel=" + quadLevel + " offset=" + quadOffset);
            List<QuadDesc> list1 = this.SortMeshesIntoQuads(statics);
            if (this.removeUnseenFaces)
            {
                for (int index1 = 0; index1 < list1.Count; index1++)
                {
                    QuadDesc quad = list1[index1];
                    if (this.LoadTerrainQuad(quad, out quad.terrainQuadTree, out quad.waterQuadTree, out quad.boundingBox))
                    {
                        quad.hasTerrainVertices = true;
                        list1[index1] = quad;
                    }
                }
            }
            this.quadList = list1;
            List<Thread> list2 = new List<Thread>();
            for (int index1 = 0; index1 < list1.Count; ++index1)
            {
                QuadDesc quadDesc = list1[index1];
                if ((this.lodX == -1 || this.lodX == quadDesc.x) && (this.lodY == -1 || this.lodY == quadDesc.y))
                {
                    while (list2.Count == 8)
                    {
                        for (int index2 = 0; index2 < list2.Count; ++index2)
                        {
                            if (!list2[index2].IsAlive)
                            {
                                list2.RemoveAt(index2);
                                --index2;
                            }
                        }
                    }
                    list2.Add(new Thread((ParameterizedThreadStart)(state =>
                    {
                        QuadDesc quad = (QuadDesc)state;
                        if (this.verbose)
                        {
                            this.logFile.WriteLog("Started LOD level " + this.quadLevel.ToString() + " coord [" + quad.x.ToString() + ", " + quad.y.ToString() + "]");
                        }
                        NiFile file = new NiFile();
                        NiNode rootNiNode = new NiNode();
                        BSMultiBoundNode rootBSMultiBoundNode = new BSMultiBoundNode();
                        if (Game.Mode != "fnv")
                        {
                            file.AddBlock((NiObject)rootNiNode);
                            rootNiNode.SetNameIndex(file.AddString("obj"));
                        }
                        else
                        {
                            file.AddBlock((NiObject)rootBSMultiBoundNode);
                        }
                        List<ShapeDesc> shapes = new List<ShapeDesc>();
                        for (int index11 = 0; index11 < quad.statics.Count; ++index11)
                        {
                            if (!(quad.statics[index11].staticModels[index] == ""))
                            {
                                if (Game.Mode == "fnv")
                                {
                                    shapes.AddRange((IEnumerable<ShapeDesc>)this.ParseNif(quad, quad.statics[index11], index, file, rootNiNode));
                                }
                                else
                                {
                                    shapes.AddRange((IEnumerable<ShapeDesc>)this.ParseNif(quad, quad.statics[index11], index, file, rootBSMultiBoundNode));
                                }
                            }
                        }
                        if (this.mergeShapes)
                            this.MergeNodes(shapes);
                        if (Game.Mode != "fnv")
                        {
                            this.CreateLODNodes(file, rootNiNode, quad, shapes);
                            if ((int)rootNiNode.GetNumChildren() == 0)
                            {
                                //logFile.WriteLog("quad empty " + quadLevel + " " + quad.x + ", " + quad.y);
                                //return;
                            }
                        }
                        else
                        {
                            this.CreateLODNodesFNV(file, rootBSMultiBoundNode, quad, shapes);
                            if ((int)rootBSMultiBoundNode.GetNumChildren() == 0)
                            {
                                //logFile.WriteLog("quad empty " + quadLevel + " " + quad.x + ", " + quad.y);
                                return;
                            }
                        }

                        if (Game.Mode == "fnv")
                        {
                            if (level == 1)
                            {
                                file.Write(this.outputDir + (object)"\\" + this.worldspaceName + ".Level4.X" + quad.x.ToString() + ".Y" + quad.y.ToString() + ".nif", logFile);
                            }
                            else
                            {
                                file.Write(this.outputDir + (object)"\\" + this.worldspaceName + ".Level4.High.X" + quad.x.ToString() + ".Y" + quad.y.ToString() + ".nif", logFile);
                            }
                        }
                        else
                        {
                            file.Write(this.outputDir + (object)"\\" + this.worldspaceName + "." + this.quadLevel.ToString() + "." + quad.x.ToString() + "." + quad.y.ToString() + ".bto", logFile);
                        }
                        this.logFile.WriteLog("Finished LOD level " + (object)this.quadLevel.ToString() + " coord [" + quad.x.ToString() + ", " + quad.y.ToString() + "] [" + quad.outValues.totalTriCount.ToString() + "/" + quad.outValues.reducedTriCount.ToString() + "]");
                    })));
                    list2[list2.Count - 1].Start((object)quadDesc);
                }
            }
            while (list2.Count > 0)
            {
                for (int index1 = 0; index1 < list2.Count; ++index1)
                {
                    if (!list2[index1].IsAlive)
                    {
                        list2.RemoveAt(index1);
                        --index1;
                    }
                }
            }
            int num1 = 0;
            int num2 = 0;
            foreach (QuadDesc quadDesc in list1)
            {
                num1 += quadDesc.outValues.totalTriCount;
                num2 += quadDesc.outValues.reducedTriCount;
            }
            this.logFile.WriteLog("LOD level " + this.quadLevel.ToString() + " total triangles " + num1.ToString() + " reduced to " + num2.ToString());
        }

        public void GenerateTest(string strfile, LogFile logFile)
        {
            NiFile file = new NiFile();
            NiNode rootNode = new NiNode();
            file.AddBlock((NiObject)rootNode);
            this.quadLevel = 4;
            this.quadOffset = 16384f;
            QuadDesc quad = new QuadDesc();
            quad.x = 0;
            quad.y = 0;
            quad.statics = new List<StaticDesc>();
            StaticDesc curStat = new StaticDesc();
            curStat.refID = "0";
            curStat.rotX = 0.0f;
            curStat.rotY = 0.0f;
            curStat.rotZ = 0.0f;
            curStat.scale = 1f;
            curStat.x = 0.0f;
            curStat.y = 0.0f;
            curStat.z = 0.0f;
            curStat.staticName = "Test";
            curStat.staticFullModel = strfile;
            curStat.staticModels = new string[3];
            curStat.staticModels[0] = strfile;
            curStat.staticModels[1] = strfile;
            curStat.staticModels[2] = strfile;
            quad.statics.Add(curStat);
            List<ShapeDesc> shapes = this.ParseNif(quad, curStat, 0, file, rootNode);
            this.MergeNodes(shapes);
            for (int index = 0; index < shapes.Count; ++index)
            {
                BSSegmentedTriShape segmentedTriShape = new BSSegmentedTriShape((NiGeometry)shapes[index].shape);
                segmentedTriShape.SetRotation(new Matrix33(true));
                segmentedTriShape.SetTranslation(new Vector3(0.0f, 0.0f, 0.0f));
                rootNode.AddChild(file.AddBlock((NiObject)segmentedTriShape));
                segmentedTriShape.SetData(file.AddBlock((NiObject)shapes[index].data));
            }
            file.Write(this.outputDir + "\\" + this.worldspaceName + ".test.nif", logFile);
        }
    }
}