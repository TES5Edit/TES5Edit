using System;
using System.Collections.Generic;
using BSAList = System.Collections.Generic.List<LODGenerator.Common.BSAArchive>;
using StringList = System.Collections.Generic.List<string>;
using System.IO;
using System.IO.Compression;

namespace LODGenerator.Common
{
    class BSAArchive
    {
        private string name;
        private bool defaultCompressed;
        private static readonly BSAList LoadedArchives = new BSAList();
        private static readonly Dictionary<string, BSAArchiveFileInfo> FileList = new Dictionary<string, BSAArchiveFileInfo>();

        public struct BSAArchiveFileInfo
        {
            public readonly BSAArchive bsa;
            public readonly int offset;
            public readonly int size;
            public readonly bool compressed;

            public BSAArchiveFileInfo(BSAArchive _bsa, int _offset, int _size)
            {
                bsa = _bsa;
                offset = _offset;
                size = _size;
                if ((size & (1 << 30)) != 0)
                {
                    size ^= 1 << 30;
                    compressed = !bsa.defaultCompressed;
                }
                else
                {
                    compressed = bsa.defaultCompressed;
                }

                //Console.WriteLine(bsa.name + " " + size);

            }

            public byte[] GetData()
            {
                FileInfo file = new FileInfo(bsa.name);
                BinaryReader binary = new BinaryReader(file.Open(FileMode.Open, FileAccess.Read, FileShare.ReadWrite), System.Text.Encoding.Default);
                binary.BaseStream.Seek(offset, SeekOrigin.Begin);
                if (compressed)
                {
                    //Console.WriteLine(bsa.name + " compressed " + size);
                    byte[] b = new byte[size - 4];
                    byte[] output = new byte[binary.ReadUInt32()];
                    binary.Read(b, 0, size - 4);
                    ICSharpCode.SharpZipLib.Zip.Compression.Inflater inf = new ICSharpCode.SharpZipLib.Zip.Compression.Inflater();
                    inf.SetInput(b, 0, b.Length);
                    inf.Inflate(output);
                    binary.Close();
                    return output;
                }
                else
                {
                    //Console.WriteLine(bsa.name + " not compressed "+ size);
                    byte[] output = binary.ReadBytes(size);
                    binary.Close();
                    return output;
                }
            }
        }

        private struct BSAHeader
        {
            public readonly uint bsaVersion;
            public readonly int directorySize;
            public readonly int archiveFlags;
            public readonly int folderCount;
            public readonly int fileCount;
            public readonly int totalFolderNameLength;
            public readonly int totalFileNameLength;
            public readonly int fileFlags;

            public BSAHeader(BinaryReader binary)
            {
                binary.BaseStream.Position += 4;
                bsaVersion = binary.ReadUInt32();
                directorySize = binary.ReadInt32();
                archiveFlags = binary.ReadInt32();
                folderCount = binary.ReadInt32();
                fileCount = binary.ReadInt32();
                totalFolderNameLength = binary.ReadInt32();
                totalFileNameLength = binary.ReadInt32();
                fileFlags = binary.ReadInt32();
            }
        }

        private struct BSAFolderInfo
        {
            public string path;
            public readonly ulong hash;
            public readonly int count;
            public int offset;
            public BSAFolderInfo(BinaryReader binary)
            {
                path = null;
                offset = 0;
                hash = binary.ReadUInt64();
                count = binary.ReadInt32();
                binary.BaseStream.Position += 4;
            }
        }

        private struct BSAFileInfo
        {
            public string path;
            public readonly ulong hash;
            public readonly int size;
            public readonly uint offset;

            public BSAFileInfo(BinaryReader binary, bool defaultCompressed)
            {
                path = null;
                hash = binary.ReadUInt64();
                size = binary.ReadInt32();
                offset = binary.ReadUInt32();
                //if (defaultCompressed)
                //{
                //    size ^= (1 << 30);
                //}
            }
        }

        private BSAArchive(string archivepath, LogFile theLog, bool verbose)
        {
            if (!File.Exists(archivepath))
            {
                theLog.WriteLog("Archive not found " + archivepath);
                return;
            }
            if (verbose)
            {
                theLog.WriteLog("Using " + archivepath);
            }
            BSAHeader header;
            name = archivepath.ToLower();
            FileInfo file = new FileInfo(archivepath);
            BinaryReader binary = new BinaryReader(file.Open(FileMode.Open, FileAccess.Read, FileShare.ReadWrite), System.Text.Encoding.Default);
            header = new BSAHeader(binary);
            if (header.bsaVersion != 0x67 && header.bsaVersion != 0x68)
            {
                theLog.WriteLog("Unknown BSA version " + archivepath);
                binary.Close();
                return;
            }
            defaultCompressed = false;
            if ((header.archiveFlags & 0x4) > 0) 
            {
                defaultCompressed = true;
            }
            if ((header.archiveFlags & 0x100) > 0)
            {
                defaultCompressed = true;
            }
            //theLog.WriteLog(name + " is compressed? " + defaultCompressed + " flags " + header.archiveFlags);
            BSAFolderInfo[] folderInfo = new BSAFolderInfo[header.folderCount];
            BSAFileInfo[] fileInfo = new BSAFileInfo[header.fileCount];
            for (int index = 0; index < header.folderCount; index++)
            {
                folderInfo[index] = new BSAFolderInfo(binary);
            }
            int count = 0;
            for (uint index = 0; index < header.folderCount; index++)
            {
                byte b = binary.ReadByte();
                if (b > 0)
                {
                    folderInfo[index].path = new string(binary.ReadChars(b - 1));
                }
                else
                {
                    folderInfo[index].path = "";
                }
                binary.BaseStream.Position++;
                folderInfo[index].offset = count;
                for (int index2 = 0; index2 < folderInfo[index].count; index2++)
                {
                    fileInfo[count + index2] = new BSAFileInfo(binary, defaultCompressed);
                }
                count += folderInfo[index].count;
            }
            for (uint index = 0; index < header.fileCount; index++)
            {
                fileInfo[index].path = "";
                char c;
                while ((c = binary.ReadChar()) != '\0') fileInfo[index].path += c;
            }
            binary.Close();

            for (int index = 0; index < header.folderCount; index++)
            {
                for (int index2 = 0; index2 < folderInfo[index].count; index2++)
                {
                    BSAFileInfo bsaFileInfo = fileInfo[folderInfo[index].offset + index2];
                    BSAArchiveFileInfo bsaArchiveFileInfo = new BSAArchiveFileInfo(this, (int)bsaFileInfo.offset, bsaFileInfo.size);
                    string filepath = Path.Combine(folderInfo[index].path, bsaFileInfo.path);
                    //theLog.WriteLog("file in BSA " + filepath + " off = " + bsaFileInfo.offset + " size = " + bsaFileInfo.size); // + " compressed "  + bsaFileInfo.compressed);
                    FileList[filepath.ToLower()] = bsaArchiveFileInfo;
                }
            }
            LoadedArchives.Add(this);
        }

        public static void Load(StringList files, LogFile theLog, bool verbose)
        {
            foreach (string s in files)
            {
                new BSAArchive(s, theLog, verbose);
            }
        }

        public static bool FileExists(string path)
        {
            return FileList.ContainsKey(path.ToLower());
        }

        public static byte[] GetFile(string path)
        {
            return FileList[path.ToLower()].GetData();
        }
    }
}