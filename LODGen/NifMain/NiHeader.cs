using LODGenerator.Common;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace LODGenerator.NifMain
{
    public class NiHeader
    {
        private string headerString;
        private uint version;
        private byte endianType;
        private uint userVersion;
        private uint numBlocks;
        private uint userVersion2;
        private string creator;
        private string exportInfo1;
        private string exportInfo2;
        private ushort numBlockTypes;
        private List<string> blockTypes;
        private List<ushort> blockTypeIndices;
        private List<uint> blockSizes;
        private uint numStrings;
        private uint maxStringLength;
        private List<string> strings;
        private uint unknownInt2;

        public NiHeader()
        {
            this.blockTypes = new List<string>();
            this.blockTypeIndices = new List<ushort>();
            this.blockSizes = new List<uint>();
            this.strings = new List<string>();
            this.headerString = "Gamebryo File Format, Version 20.2.0.7";
            this.version = 335675399U;
            this.endianType = (byte)1;
            if (Game.Mode == "fnv")
            {
                this.userVersion = 11U;
                this.userVersion2 = 34U;
            }
            else
            {
                this.userVersion = 12U;
                this.userVersion2 = 83U;
            }
            this.unknownInt2 = 0U;
            this.creator = ""; //LODGen";
            this.exportInfo1 = "";
            this.exportInfo2 = "";
        }

        public void Read(BinaryReader reader)
        {
            this.headerString = "";
            byte num;
            while ((int)(num = reader.ReadByte()) != 10)
            {
                NiHeader niHeader = this;
                string str = niHeader.headerString + (object)(char)num;
                niHeader.headerString = str;
            }
            this.version = reader.ReadUInt32();
            this.endianType = reader.ReadByte();
            this.userVersion = reader.ReadUInt32();
            this.numBlocks = reader.ReadUInt32();
            this.userVersion2 = reader.ReadUInt32();
            this.creator = Utils.ReadShortString(reader);
            this.exportInfo1 = Utils.ReadShortString(reader);
            this.exportInfo2 = Utils.ReadShortString(reader);
            this.numBlockTypes = reader.ReadUInt16();
            for (int index = 0; index < (int)this.numBlockTypes; ++index)
                this.blockTypes.Add(Utils.ReadSizedString(reader));
            for (int index = 0; (long)index < (long)this.numBlocks; ++index)
                this.blockTypeIndices.Add(reader.ReadUInt16());
            if (this.version > 335544325U)
            {
                for (int index = 0; (long)index < (long)this.numBlocks; ++index)
                    this.blockSizes.Add(reader.ReadUInt32());
                this.numStrings = reader.ReadUInt32();
                this.maxStringLength = reader.ReadUInt32();
                for (int index = 0; (long)index < (long)this.numStrings; ++index)
                    this.strings.Add(Utils.ReadSizedString(reader));
            }
            this.unknownInt2 = reader.ReadUInt32();
        }

        public void Update(List<NiObject> blocks)
        {
            for (int index = 0; index < blocks.Count; ++index)
                this.blockSizes[index] = blocks[index].GetSize();
        }

        public void Write(BinaryWriter writer)
        {
            for (int index = 0; index < this.headerString.Length; ++index)
                writer.Write((byte)Enumerable.ElementAt<char>((IEnumerable<char>)this.headerString, index));
            writer.Write((byte)10);
            writer.Write(this.version);
            writer.Write(this.endianType);
            writer.Write(this.userVersion);
            writer.Write(this.numBlocks);
            writer.Write(this.userVersion2);
            Utils.WriteShortString(writer, this.creator);
            Utils.WriteShortString(writer, this.exportInfo1);
            Utils.WriteShortString(writer, this.exportInfo2);
            writer.Write(this.numBlockTypes);
            for (int index = 0; index < (int)this.numBlockTypes; ++index)
                Utils.WriteSizedString(writer, this.blockTypes[index]);
            for (int index = 0; (long)index < (long)this.numBlocks; ++index)
                writer.Write(this.blockTypeIndices[index]);
            for (int index = 0; (long)index < (long)this.numBlocks; ++index)
                writer.Write(this.blockSizes[index]);
            writer.Write(this.numStrings);
            writer.Write(this.maxStringLength);
            for (int index = 0; (long)index < (long)this.numStrings; ++index)
                Utils.WriteSizedString(writer, this.strings[index]);
            writer.Write(this.unknownInt2);
        }

        public uint GetVersion()
        {
            return this.version;
        }

        public uint GetUserVersion()
        {
            return this.userVersion;
        }

        public uint GetUserVersion2()
        {
            return this.userVersion2;
        }

        public uint GetNumBlocks()
        {
            return this.numBlocks;
        }

        public string GetBlockTypeAtIndex(int index)
        {
            return this.blockTypes[(int)this.blockTypeIndices[index]];
        }

        public uint GetBlockSizeAtIndex(int index)
        {
            return this.blockSizes[index];
        }

        public string GetString(uint index)
        {
            return this.strings[(int)index];
        }

        public void AddBlock(NiObject obj)
        {
            int num;
            if (this.blockTypes.Contains(obj.GetClassName()))
            {
                num = this.blockTypes.IndexOf(obj.GetClassName());
            }
            else
            {
                this.blockTypes.Add(obj.GetClassName());
                num = this.blockTypes.Count - 1;
                ++this.numBlockTypes;
            }
            this.blockTypeIndices.Add((ushort)num);
            this.blockSizes.Add(obj.GetSize());
            ++this.numBlocks;
        }

        public int AddString(string str)
        {
            if (this.strings.Contains(str))
                return this.strings.IndexOf(str);
            this.strings.Add(str);
            ++this.numStrings;
            if ((long)str.Length > (long)this.maxStringLength)
                this.maxStringLength = (uint)str.Length;
            return this.strings.Count - 1;
        }
    }
}
