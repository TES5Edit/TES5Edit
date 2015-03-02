using LODGenerator.Common;
using LODGenerator.NifMain;
using System;
using System.Collections.Generic;
using System.IO;

namespace LODGenerator
{
    public class NiFile
    {
        private static Dictionary<string, Type> classTypes = new Dictionary<string, Type>()
        {
            {
            "BSFadeNode",
            typeof (BSFadeNode)
            },
            {
            "NiTriShape",
            typeof (NiTriShape)
            },
            {
                "NiTriShapeData",
                typeof (NiTriShapeData)
            },
            {
                "BSLightingShaderProperty",
                typeof (BSLightingShaderProperty)
            },
            {
                "BSShaderTextureSet",
                typeof (BSShaderTextureSet)
            },
            {
                "NiNode",
                typeof (NiNode)
            },
            {
                "NiMaterialProperty",
                typeof (NiMaterialProperty)
            },
            {
                "NiTexturingProperty",
                typeof (NiTexturingProperty)
            },
            {
                "NiSourceTexture",
                typeof (NiSourceTexture)
            },
            {
                "NiTriStrips",
                typeof (NiTriStrips)
            },
            {
                "NiTriStripsData",
                typeof (NiTriStripsData)
            },
            {
                "NiStringExtraData",
                typeof (NiStringExtraData)
            },
            {
                "BSEffectShaderProperty",
                typeof (BSEffectShaderProperty)
            },
            {
                "NiStencilProperty",
                typeof (NiStencilProperty)
            },
            {
                "NiBinaryExtraData",
                typeof (NiBinaryExtraData)
            },
            {
                "NiVertexColorProperty",
                typeof (NiVertexColorProperty)
            },
            {
                "NiMaterialColorController",
                typeof (NiMaterialColorController)
            },
            {
                "NiPoint3Interpolator",
                typeof (NiPoint3Interpolator)
            },
            {
                "NiPosData",
                typeof (NiPosData)
            },
            {
                "NiIntegerExtraData",
                typeof (NiIntegerExtraData)
            },
            {
                "BSXFlags",
                typeof (BSXFlags)
            },
            {
                "NiAlphaProperty",
                typeof (NiAlphaProperty)
            },
            {
                "BSMultiBoundNode",
                typeof (BSMultiBoundNode)
            },
            {
                "BSLODTriShape",
                typeof (BSLODTriShape)
            },
            {
                "BSOrderedNode",
                typeof (BSOrderedNode)
            },
            {
                "BSMultiBound",
                typeof (BSMultiBound)
            },
            {
                "BSMultiBoundAABB",
                typeof (BSMultiBoundAABB)
            },
            {
                "BSSegmentedTriShape",
                typeof (BSSegmentedTriShape)
            }
        };
        private NiHeader header;
        private List<NiObject> blocks;

        public NiFile()
        {
            this.header = new NiHeader();
            this.blocks = new List<NiObject>();
        }

        public void Read(string skyrimDir, string fileName, LogFile logFile)
        {
            MemoryStream memoryStream = new MemoryStream();
            if (File.Exists(skyrimDir + fileName))
            {
                try
                {
                    FileStream fileStream = (FileStream)null;
                    while (fileStream == null)
                    {
                        fileStream = Utils.GetFileStream(new FileInfo(skyrimDir + fileName), logFile);
                    }
                    BinaryReader binaryReader = new BinaryReader((Stream)fileStream);
                    long length = binaryReader.BaseStream.Length;
                    memoryStream.Write(binaryReader.ReadBytes((int)length), 0, (int)length);
                    binaryReader.Close();
                    //logFile.WriteLog(" read " + fileName + " " + length);
                }
                catch (Exception ex)
                {
                    logFile.WriteLog("Error reading " + fileName + " " + ex.Message);
                    logFile.Close();
                    System.Environment.Exit(500);
                }
            }
            else if (BSAArchive.FileExists(fileName))
            {
                try
                {
                    //logFile.Console.WriteLine(" reading " + fileName + " from BSA");
                    byte[] newfile = BSAArchive.GetFile(fileName);
                    int length = newfile.Length;
                    memoryStream.Write(newfile, 0, length);
                    //logFile.WriteLog(" read " + fileName + " " + length + " from BSA");
                }
                catch (Exception ex)
                {
                    logFile.WriteLog("Error reading " + fileName + " from BSA " + ex.Message);
                    logFile.Close();
                    System.Environment.Exit(500);
                }
            }
            else
            {
                logFile.WriteLog(fileName + " not found");
                logFile.Close();
                System.Environment.Exit(404);
            }
            memoryStream.Position = 0L;
            //Console.WriteLine("Reading " + fileName);
            BinaryReader reader = new BinaryReader((Stream)memoryStream);
            this.header.Read(reader);
            for (int index = 0; (long)index < (long)this.header.GetNumBlocks(); ++index)
            {
                if (NiFile.classTypes.ContainsKey(this.header.GetBlockTypeAtIndex(index)))
                {
                    NiObject niObject = (NiObject)Activator.CreateInstance(NiFile.classTypes[this.header.GetBlockTypeAtIndex(index)]);
                    niObject.Read(this.header, reader);
                    this.blocks.Add(niObject);
                }
                else
                {
                    uint blockSizeAtIndex = this.header.GetBlockSizeAtIndex(index);
                    reader.ReadBytes((int)blockSizeAtIndex);
                    this.blocks.Add((NiObject)null);
                }
            }
            reader.Close();
            //Console.WriteLine("done " + fileName);
        }

        public void Write(string fileName)
        {
            BinaryWriter writer = new BinaryWriter((Stream)new FileStream(fileName, FileMode.Create));
            this.header.Update(this.blocks);
            this.header.Write(writer);
            for (int index = 0; (long)index < (long)this.header.GetNumBlocks(); ++index)
                this.blocks[index].Write(writer);
            writer.Write(1);
            writer.Write(0);
            writer.Close();
        }

        public int GetNumBlocks()
        {
            return this.blocks.Count;
        }

        public NiObject GetBlockAtIndex(int index)
        {
            return this.blocks[index];
        }

        public string GetStringAtIndex(int index)
        {
            return this.header.GetString((uint)index);
        }

        public uint GetVersion()
        {
            return this.header.GetVersion();
        }

        public int AddBlock(NiObject obj)
        {
            this.blocks.Add(obj);
            this.header.AddBlock(obj);
            return this.blocks.Count - 1;
        }

        public int AddString(string str)
        {
            return this.header.AddString(str);
        }
    }
}
