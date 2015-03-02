namespace LODGenerator.Common
{
    public class TexDesc
    {
        public int source;
        public uint clampMode;
        public uint filterMode;
        public uint uvSet;
        public bool hasTextureTransform;
        public UVCoord translation;
        public UVCoord tiling;
        public float wRotation;
        public uint transformType;
        public UVCoord centerOffset;
    }
}
