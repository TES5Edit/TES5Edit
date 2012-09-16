namespace TESVSnip.Domain.Services
{
    using System;

    internal static class Compressor
    {
        private static readonly string[] autoCompRecList = new string[0];

        public static bool CompressRecord(string name)
        {
            return Array.BinarySearch(autoCompRecList, name) >= 0;
        }
    }
}