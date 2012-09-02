namespace TESVSnip.Domain.Model
{
    using System.Collections;
    using System.Collections.Generic;

    internal interface IGroupRecord : IRecord
    {
        IList Records { get; }

        void AddRecord(BaseRecord br);

        void AddRecords(IEnumerable<BaseRecord> br);

        bool DeleteRecord(BaseRecord br);

        bool DeleteRecords(IEnumerable<BaseRecord> br);

        int IndexOf(BaseRecord br);

        void InsertRecord(int index, BaseRecord br);

        void InsertRecords(int index, IEnumerable<BaseRecord> br);
    }
}
