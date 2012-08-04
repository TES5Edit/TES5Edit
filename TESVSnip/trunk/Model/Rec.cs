using System;
using System.Runtime.Serialization;
using TESVSnip.Data;

namespace TESVSnip
{
    [Persistable(Flags = PersistType.DeclaredOnly), Serializable]
    public abstract class Rec : BaseRecord
    {
        private BaseRecord parent;

        protected Rec()
        {
        }

        protected Rec(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
        }

        [Persistable] protected string descriptiveName;

        public override string DescriptiveName
        {
            get { return descriptiveName == null ? Name : (Name + descriptiveName); }
            //set { descriptiveName = value; }
        }

        public override void SetDescription(string value)
        {
            descriptiveName = value;
        }

        public override void UpdateShortDescription()
        {
            descriptiveName = "";
        }

        public override BaseRecord Parent
        {
            get { return parent; }
            internal set { parent = value; }
        }
    }
}