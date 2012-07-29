using System;

namespace TESVSnip
{
    internal interface IRecord : ICloneable
    {
        string Name { get; set; }
        string DescriptiveName { get; }
        BaseRecord Parent { get; }
        long Size { get; }
        long Size2 { get; }
    }
}