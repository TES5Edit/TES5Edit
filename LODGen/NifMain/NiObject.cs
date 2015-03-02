using System.IO;

namespace LODGenerator.NifMain
{
    public class NiObject
    {
        public virtual void Read(NiHeader header, BinaryReader reader)
        {
        }

        public virtual void Write(BinaryWriter writer)
        {
        }

        public virtual string GetClassName()
        {
            return "NiObject";
        }

        public virtual uint GetSize()
        {
            return 0U;
        }

        public virtual bool IsDerivedType(string type)
        {
            return type == "NiObject";
        }
    }
}
