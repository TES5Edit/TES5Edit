namespace TESVSnip.Domain.Model
{
    using System;
    using System.Runtime.Serialization;

    using TESVSnip.Framework.Persistence;

    [Persistable(Flags = PersistType.DeclaredOnly)]
    [Serializable]
    public abstract class Rec : BaseRecord
    {
        [Persistable]
        protected string descriptiveName;

        private BaseRecord parent;

        protected Rec()
        {
        }

        protected Rec(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
        }

        public override string DescriptiveName
        {
            get
            {
                return this.descriptiveName == null ? Name : (Name + this.descriptiveName);
            }

            // set { descriptiveName = value; }
        }

        public override BaseRecord Parent
        {
            get
            {
                return this.parent;
            }

            internal set
            {
                this.parent = value;
            }
        }

        public override void SetDescription(string value)
        {
            this.descriptiveName = value;
        }

        public override void UpdateShortDescription()
        {
            this.descriptiveName = string.Empty;
        }

        internal int CountRecords()
        {
            if (this is Record)
            {
                return 1;
            }
            
            int i = 1;
            foreach (Rec r2 in Records)
            {
                i += r2.CountRecords();
            }

            return i;
        }
    }
}
