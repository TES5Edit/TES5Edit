namespace TESVSnip.ZLibInterface
{
    using System;
    using System.IO;
    using DotZLib;

    public static class ZLib
    {
        public static BinaryReader Decompress(MemoryStream input, long offset = 0, long size = 0)
        {
            if (input == null) {
                throw new ArgumentNullException("input");
            }

            if (size == 0) {
                size = input.Length;
            }

            if (offset > 0) {
                var position = input.Position;
                input.Position = position + offset;
            }

            var buffer = new byte[size];
            //var inflater = new Inflater(input.)
        }
    }
}