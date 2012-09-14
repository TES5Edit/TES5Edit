namespace TESVSnip.Domain.Model
{
    using System;

    internal interface IRecord : ICloneable
    {
        string DescriptiveName { get; }

        string Name { get; set; }

        BaseRecord Parent { get; }

        long Size { get; }

        long Size2 { get; }
    }
}
