using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace TESVSnip
{
    /// <summary>
    /// Master Plugin Handler
    /// </summary>
    internal class PluginList : BaseRecord, IGroupRecord
    {
        private readonly List<Plugin> pluginList = new List<Plugin>();
        private static readonly PluginList plugins = new PluginList();

        public static PluginList All
        {
            get { return plugins; }
        }

        public override BaseRecord Parent
        {
            get { return null; }
            internal set { }
        }

        public override long Size
        {
            get { return pluginList.Sum(x => x.Size2); }
        }

        public override long Size2
        {
            get { return pluginList.Sum(x => x.Size2); }
        }

        public override string GetDesc()
        {
            return "Master List";
        }

        public override bool DeleteRecord(BaseRecord br)
        {
            var p = br as Plugin;
            if (p != null)
            {
                p.Parent = null;
                bool ok = pluginList.Remove(p);
                FireRecordListUpdate(this, this);
                return ok;
            }
            return false;
        }

        public override void AddRecord(BaseRecord br)
        {
            var p = br as Plugin;
            if (p != null)
            {
                p.Parent = this;
                pluginList.Add(p);
            }
            FireRecordListUpdate(this, null);
        }

        public override void InsertRecord(int idx, BaseRecord br)
        {
            var r = br as Plugin;
            r.Parent = this;
            if (idx < 0 || idx > pluginList.Count)
                idx = pluginList.Count;
            pluginList.Insert(idx, r);
            FireRecordListUpdate(this, null);
        }

        public override int IndexOf(BaseRecord br)
        {
            return pluginList.IndexOf(br as Plugin);
        }

        public void Clear()
        {
            pluginList.Clear();
        }

        public static void FixMasters()
        {
            var plugins = All.Records.OfType<Plugin>().ToArray();
            foreach (var plugin in All.Records.OfType<Plugin>())
                plugin.UpdateReferences(plugins);
        }


        internal override List<string> GetIDs(bool lower)
        {
            throw new NotImplementedException();
        }

        internal override void SaveData(BinaryWriter writer)
        {
            throw new NotImplementedException();
        }

        public override BaseRecord Clone()
        {
            throw new NotImplementedException();
        }

        public override IList Records
        {
            get { return pluginList; }
        }

        public override bool While(Predicate<BaseRecord> action)
        {
            foreach (BaseRecord r in Records)
                if (!r.While(action))
                    return false;
            return true;
        }

        public override void ForEach(Action<BaseRecord> action)
        {
            foreach (BaseRecord r in Records) r.ForEach(action);
        }

        public override IEnumerable<BaseRecord> Enumerate(Predicate<BaseRecord> match)
        {
            foreach (BaseRecord r in Records)
                foreach (var itm in r.Enumerate(match))
                    yield return itm;
        }
    }
}