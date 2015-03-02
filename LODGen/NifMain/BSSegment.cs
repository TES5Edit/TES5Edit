namespace LODGenerator.NifMain
{
    public class BSSegment
    {
        public byte unknownByte1;
        public uint startTriangle;
        public ushort numTriangles;
        public ushort unknownShort1;

        public BSSegment(uint sTriangle, ushort nTriangle)
        {
            this.unknownByte1 = (byte)0;
            this.startTriangle = sTriangle;
            this.numTriangles = nTriangle;
            this.unknownShort1 = (ushort)0;
        }
    }
}
