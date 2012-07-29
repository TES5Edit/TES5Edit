using System.Collections;
using System.Collections.Generic;

namespace TESVSnip
{
    internal interface IGroupRecord : IRecord
    {
        void AddRecord(BaseRecord br);
        bool DeleteRecord(BaseRecord br);
        void InsertRecord(int index, BaseRecord br);
        int IndexOf(BaseRecord br);

        void AddRecords(IEnumerable<BaseRecord> br);
        bool DeleteRecords(IEnumerable<BaseRecord> br);
        void InsertRecords(int index, IEnumerable<BaseRecord> br);

        IList Records { get; }
    }
}