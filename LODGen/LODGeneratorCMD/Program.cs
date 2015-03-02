using LODGenerator;
using LODGenerator.Common;
using System;
using System.Collections.Generic;
using StringList = System.Collections.Generic.List<string>;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Threading;
using Ini;

namespace LODGeneratorCMD
{
    internal class Program
    {
        private static Dictionary<string, string> CollectCmdArgs(string[] args)
        {
            Dictionary<string, string> dictionary = new Dictionary<string, string>();
            for (int index = 2; index < Enumerable.Count<string>((IEnumerable<string>)args); ++index)
            {
                string str = "";
                string key = args[index].Remove(0, 2).ToLower();
                if (index + 1 < Enumerable.Count<string>((IEnumerable<string>)args) && !args[index + 1].StartsWith("--"))
                    str = args[++index];
                dictionary.Add(key, str);
            }
            return dictionary;
        }

        private static void PrintCmdArgs(LogFile theLog, Dictionary<string, string> cmdArgs)
        {
            int int1 = CmdArgs.GetInt(cmdArgs, "lodLevel", -1);
            int int2 = CmdArgs.GetInt(cmdArgs, "x", -1);
            int int3 = CmdArgs.GetInt(cmdArgs, "y", -1);
            theLog.WriteLog("Fix tangents: " + (!CmdArgs.GetBool(cmdArgs, "dontFixTangents", false) ? "True" : "False"));
            theLog.WriteLog("Generate tangents: " + (!CmdArgs.GetBool(cmdArgs, "dontGenerateTangents", false) ? "True" : "False"));
            theLog.WriteLog("Generate Vertex Colors: " + (!CmdArgs.GetBool(cmdArgs, "dontGenerateVertexColors", false) ? "True" : "False"));
            theLog.WriteLog("Merge meshes: " + (CmdArgs.GetBool(cmdArgs, "mergeShapes", true) ? "True" : "False"));
            theLog.WriteLog("Remove Faces under Terrain: " + (CmdArgs.GetBool(cmdArgs, "removeUnseenFaces", true) ? "True" : "False"));
            theLog.WriteLog("Remove Faces under Water: " + (!CmdArgs.GetBool(cmdArgs, "ignoreWater", false) ? "True" : "False"));
            theLog.WriteLog("Use HD LOD: " + (CmdArgs.GetBool(cmdArgs, "useHDLOD", false) ? "True" : "False"));
            theLog.WriteLog("Ignore Materials: " + (CmdArgs.GetBool(cmdArgs, "ignoreMaterial", false) ? "True" : "False"));
            theLog.WriteLog("Global scale: " + string.Format("{0:0.00}", (object)CmdArgs.GetFloat(cmdArgs, "globalScale", 1f)));
            theLog.WriteLog("Specific level: " + (int1 != -1 ? int1.ToString() : "No"));
            if (int2 != -1 && int3 == -1)
                theLog.WriteLog("Specific quad: [" + (object)int2.ToString() + ", X]");
            else if (int2 == -1 && int3 != -1)
                theLog.WriteLog("Specific quad: [X, " + (object)int3.ToString() + "]");
            else if (int2 != -1 && int3 != -1)
                theLog.WriteLog("Specific quad: [" + (object)int2.ToString() + ", " + (string)(object)int3.ToString() + "]");
            else
                theLog.WriteLog("Specific quad: No");
        }

        private static int Main(string[] args)
        {
            LogFile theLog = new LogFile();
            if (Enumerable.Count<string>((IEnumerable<string>)args) < 1)
            {
                theLog.WriteLog("Nothing to do");
                theLog.Close();
                return -1;
            }

            Dictionary<string, string> cmdArgs = Program.CollectCmdArgs(args);
            string path = args[0];
            if (!File.Exists(path))
            {
                theLog.WriteLog("No input file " + path);
                theLog.Close();
                return -1;
            }
            Program.PrintCmdArgs(theLog, cmdArgs);
            CultureInfo cultureInfo = CmdArgs.ci;
            StreamReader streamReader = new StreamReader(path, System.Text.Encoding.Default, true);
            List<StaticDesc> statics = new List<StaticDesc>();
            StringList BSAFiles = new StringList();
            StringList ignoreList = new StringList();
            int counter = 0;
            string worldspaceName = "";
            string skyrimDir = "";
            string outputDir = "";
            string uvfile = "";
            float southWestX = 0;
            float southWestY = 0;
            float atlasTolerance = 0.2f;
            while (!streamReader.EndOfStream)
            {
                string[] strArray2 = streamReader.ReadLine().Split('=');
                if (strArray2.Length == 2)
                {
                    ++counter;
                    if (strArray2[0].ToLower() == "worldspace")
                    {
                        worldspaceName = strArray2[1];
                    }
                    if (strArray2[0].ToLower() == "cellsw")
                    {
                        string[] strArray1 = strArray2[1].Split(' ');
                        southWestX = float.Parse(strArray1[0], (IFormatProvider)cultureInfo);
                        southWestY = float.Parse(strArray1[1], (IFormatProvider)cultureInfo);
                    }
                    if (strArray2[0].ToLower() == "pathdata")
                    {
                        skyrimDir = strArray2[1].ToLower();
                        if (!Directory.Exists(skyrimDir))
                        {
                            theLog.WriteLog("No Data directory " + skyrimDir);
                            theLog.Close();
                            return -1;
                        }
                    }
                    if (strArray2[0].ToLower() == "pathoutput")
                    {
                        outputDir = strArray2[1];
                        if (!Directory.Exists(outputDir))
                        {
                            Directory.CreateDirectory(outputDir);
                        }
                    }
                    if (strArray2[0].ToLower() == "textureatlasmap")
                    {
                        uvfile = strArray2[1];
                    }
                    if (strArray2[0].ToLower() == "resource")
                    {
                        if (File.Exists(strArray2[1]))
                        {
                            BSAFiles.Add(strArray2[1].ToLower());
                        }
                    }
                    if (strArray2[0].ToLower() == "atlastolerance")
                    {
                        atlasTolerance = float.Parse(strArray2[1], (IFormatProvider)cultureInfo);
                    }
                    if (strArray2[0].ToLower() == "ignoretranslation")
                    {
                        ignoreList.Add(strArray2[1].ToLower());
                    }
                }
                else
                {
                    break;
                }
            }
            streamReader.Close();
            if (worldspaceName == "")
            {
                theLog.WriteLog("No Worldspace");
                theLog.Close();
                return -1;
            }
            if (outputDir == "")
            {
                theLog.WriteLog("No PathOutput");
                theLog.Close();
                return -1;
            }
            /*IniFile ini = new IniFile(Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments), "My games\\skyrim\\skyrim.ini"));
            if (ini.IniReadValue("Archive", "sResourceArchiveList").ToLower().Contains("aaa"))
            {
                string archiveList1 = ini.IniReadValue("Archive", "sResourceArchiveList").ToLower();
                string archiveList2 = ini.IniReadValue("Archive", "sResourceArchiveList2").ToLower();
                if (archiveList2.Length > 0)
                {
                    archiveList1 += "," + archiveList2;
                }
                BSAFiles.Clear();
                BSAFiles.AddRange(archiveList1.Split(','));
                for (int index = 0; index < BSAFiles.Count; ++index)
                {
                    if (File.Exists(Path.Combine(skyrimDir, BSAFiles[index].Trim())))
                    {
                        BSAFiles[index] = Path.Combine(skyrimDir, BSAFiles[index].Trim());
                    }
                }
            }*/
            BSAArchive.Load(BSAFiles, theLog, (CmdArgs.GetBool(cmdArgs, "verbose", false)));
            streamReader = new StreamReader(path);
            for (int index = 0; index < counter; ++index)
            {
                streamReader.ReadLine();
            }
            while (!streamReader.EndOfStream)
            {
                StaticDesc staticDesc = new StaticDesc();
                string[] strArray2 = streamReader.ReadLine().Split('\t');
                staticDesc.refID = strArray2[0];
                //theLog.WriteLog(staticDesc.refID);
                staticDesc.staticFlags = int.Parse(strArray2[1], NumberStyles.HexNumber, (IFormatProvider)cultureInfo);
                staticDesc.x = float.Parse(strArray2[2], (IFormatProvider)cultureInfo);
                staticDesc.y = float.Parse(strArray2[3], (IFormatProvider)cultureInfo);
                staticDesc.z = float.Parse(strArray2[4], (IFormatProvider)cultureInfo);
                staticDesc.rotX = float.Parse(strArray2[5], (IFormatProvider)cultureInfo);
                staticDesc.rotY = float.Parse(strArray2[6], (IFormatProvider)cultureInfo);
                staticDesc.rotZ = float.Parse(strArray2[7], (IFormatProvider)cultureInfo);
                staticDesc.scale = float.Parse(strArray2[8], (IFormatProvider)cultureInfo);
                staticDesc.staticName = strArray2[9];
                staticDesc.refFlags = int.Parse(strArray2[10], NumberStyles.HexNumber, (IFormatProvider)cultureInfo);
                staticDesc.materialName = strArray2[11];
                staticDesc.staticFullModel = strArray2[12];
                if (strArray2.Length >= 16)
                {
                    staticDesc.staticModels = new string[3];
                    for (int index = 0; index < 3; ++index)
                    {
                        string str = strArray2[13 + index];
                        staticDesc.staticModels[index] = str.ToLower();
                        if (str.Length > 0 && !File.Exists(skyrimDir + str))
                        {
                            if (!BSAArchive.FileExists(str))
                            {
                                theLog.WriteLog("file not found " + skyrimDir + str);
                                theLog.Close();
                                System.Environment.Exit(404);
                            }
                        }
                    }
                    statics.Add(staticDesc);
                }
            }
            streamReader.Close();
            theLog.WriteLog("the file: " + uvfile);
            if (File.Exists(uvfile))
            {
                theLog.WriteLog("Using UV Atlas: " + uvfile);
                streamReader = new StreamReader(uvfile);
                while (!streamReader.EndOfStream)
                {
                    string[] strArray2 = streamReader.ReadLine().Split('\t');
                    AtlasDesc atlasDesc = new AtlasDesc();
                    if (strArray2.Length >= 8)
                    {
                        atlasDesc.SourceTexture = strArray2[0].ToLower();
                        int textureWidth = int.Parse(strArray2[1], (IFormatProvider)cultureInfo);
                        int textureHeight = int.Parse(strArray2[2], (IFormatProvider)cultureInfo);
                        int textureX = int.Parse(strArray2[3], (IFormatProvider)cultureInfo);
                        int textureY = int.Parse(strArray2[4], (IFormatProvider)cultureInfo);
                        int atlasWidth = int.Parse(strArray2[6], (IFormatProvider)cultureInfo);
                        int atlasHeight = int.Parse(strArray2[7], (IFormatProvider)cultureInfo);
                        atlasDesc.scaleU = (float) textureWidth / (float) atlasWidth;
                        atlasDesc.scaleV = (float) textureHeight / (float)atlasHeight;
                        atlasDesc.posU = (float)textureX / (float) atlasWidth;
                        atlasDesc.posV = (float)textureY / (float) atlasHeight;
                        atlasDesc.AtlasTexture = strArray2[5].ToLower();
                        atlasDesc.AtlasTextureN = strArray2[5].ToLower().Replace(".dds", "_n.dds");
                        //theLog.WriteLog(atlasDesc.SourceTexture + "\t" + atlasDesc.AtlasTexture + "\t" + atlasDesc.scaleU + "\t" + atlasDesc.scaleV + "\t" + atlasDesc.posU + "\t" + atlasDesc.posV);
                        AtlasList.Set(atlasDesc.SourceTexture, atlasDesc);
                    }
                }
                streamReader.Close();
            }
            theLog.WriteLog("Output: " + outputDir);
            theLog.WriteLog("Generating LOD for worldspace " + worldspaceName);
            List<Thread> list1 = new List<Thread>();
            int num = 1;
            int index1 = 0;
            while (num <= 4)
            {
                list1.Add(new Thread((ParameterizedThreadStart)(state =>
                {
                    List<int> list2 = (List<int>)state;
                    new LODApp(worldspaceName, outputDir, skyrimDir, theLog)
                    {
                        verbose = (CmdArgs.GetBool(cmdArgs, "verbose", false)),
                        fixTangents = (!CmdArgs.GetBool(cmdArgs, "dontFixTangents", false)),
                        generateTangents = (!CmdArgs.GetBool(cmdArgs, "dontGenerateTangents", false)),
                        generateVertexColors = (!CmdArgs.GetBool(cmdArgs, "dontGenerateVertexColors", false)),
                        mergeShapes = (!CmdArgs.GetBool(cmdArgs, "dontMerge", false)),
                        useHDFlag = CmdArgs.GetBool(cmdArgs, "useHDLOD", false),
                        useFadeNode = CmdArgs.GetBool(cmdArgs, "useFadeNode", false),
                        removeUnseenFaces = CmdArgs.GetBool(cmdArgs, "removeUnseenFaces", false),
                        globalScale = CmdArgs.GetFloat(cmdArgs, "globalScale", 1f),
                        lodLevelToGenerate = CmdArgs.GetInt(cmdArgs, "lodLevel", -1),
                        lodX = CmdArgs.GetInt(cmdArgs, "x", -1),
                        lodY = CmdArgs.GetInt(cmdArgs, "y", -1),
                        southWestX = ((int)southWestX),
                        southWestY = ((int)southWestY),
                        atlasToleranceMin = ((float)atlasTolerance) * -1f,
                        atlasToleranceMax = ((float)atlasTolerance) + 1f,
                        removeUnderwaterFaces = (!CmdArgs.GetBool(cmdArgs, "ignoreWater", false)),
                        ignoreMaterial = CmdArgs.GetBool(cmdArgs, "ignoreMaterial", false),
                        skyblivionTexPath = CmdArgs.GetBool(cmdArgs, "skyblivionTexPath", false),
                        ignoreTransRot = ignoreList
                    }.GenerateLOD(list2[1], list2[0], statics);
                })));
                list1[index1].Start((object)new List<int>()
                {
                    num,
                    index1
                });
                num <<= 1;
                ++index1;
            }
            while (list1.Count > 0)
            {
                for (int index2 = 0; index2 < list1.Count; ++index2)
                {
                    if (!list1[index2].IsAlive)
                    {
                        list1.RemoveAt(index2);
                        --index2;
                    }
                }
                Thread.Sleep(100);
            }
            theLog.Close();
            return 0;
        }
    }
}