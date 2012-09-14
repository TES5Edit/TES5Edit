namespace TESVSnip.Domain.Model
{
    using System;

    internal class RecordChangeEventArgs : EventArgs
    {
        private readonly BaseRecord record;

        public RecordChangeEventArgs(BaseRecord rec)
        {
            this.record = rec;
        }

        public BaseRecord Record
        {
            get
            {
                return this.record;
            }
        }
    }
}