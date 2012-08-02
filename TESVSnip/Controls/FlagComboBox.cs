#region License

// Original Source:
//  http://www.codeproject.com/KB/combobox/checkedcombobox.aspx
//
// The Code Project Open License (CPOL) 1.02
//   http://www.codeproject.com/info/cpol10.aspx

#endregion

using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;

namespace TESVSnip.Windows.Controls
{
    public partial class FlagComboBox : CheckedComboBox
    {
        public class CCBoxItem
        {
            public CCBoxItem()
                : this(null, 0)
            {
            }

            public CCBoxItem(string name, uint val)
            {
                Name = name;
                Value = val;
                this.IsRaw = false;
            }
            public CCBoxItem(string name, uint val, bool isRaw)
            {
                Name = name;
                Value = val;
                this.IsRaw = isRaw;
            }

            public string Name { get; set; }
            public uint Value { get; set; }
            internal bool IsRaw { get; set; }

            public override string ToString()
            {
                return string.Format(string.IsNullOrEmpty(Name) ? "{1}" : "'{0}' : {1}", Name, Value);
            }
        }

        private readonly List<CCBoxItem> items = new List<CCBoxItem>();

        public FlagComboBox()
        {
            ValueSeparator = ",";
            DataSource = null;
        }

        public void SetItemsFromType(Type t)
        {
            string[] names = Enum.GetNames(t);
            Array values = Enum.GetValues(t);
            SetItems(names, 4, (uint[]) values);
        }

        public void SetItems(string[] names, byte flagSize)
        {
            if (names == null || names.Length == 0)
            {
                DataSource = null;
                return;
            }
            var values = new uint[names.Length];
            for (int i = 0; i < names.Length; ++i)
                values[i] = (uint) 1 << i;
            SetItems(names, flagSize, values);
        }

        public void SetItems(string[] names, byte flagSize, uint[] values)
        {
            if (names == null || names.Length == 0 || values == null || values.Length == 0 ||
                names.Length != values.Length)
            {
                DataSource = null;
                return;
            }
            items.Clear();
            uint maxValue = 0;
            for (int i = 0; i < names.Length; ++i)
            {
                string s = names[i];
                if (values[i] > maxValue) maxValue = values[i];
                if (string.IsNullOrEmpty(s)) continue;
                items.Add(new CCBoxItem(s, values[i]));
            }
            //int bits = (int)Math.Ceiling(Math.Log(maxValue)/Math.Log(2.0f));
            //int bytes = (bits/4) + (((bits%4)!=0) ? 1 : 0);
            //bytes = ((bytes/2) + ((bytes%2 != 0) ? 1 : 0))*2;
            //string format = "X" + bytes.ToString();
            string format = "X8";
            int numBits = 32;
            switch (flagSize)
            {
                case 1:
                    format = "X2";
                    numBits = 8;
                    break;
                case 2:
                    format = "X4";
                    numBits = 16;
                    break;
            }
            for (int i = 0; i < names.Length; ++i)
            {
                string s = names[i];
                if (!string.IsNullOrEmpty(s)) continue;
                items.Add(new CCBoxItem(values[i].ToString(format), values[i], true));
            }
            for (int i = names.Length; i < numBits; ++i) // add missing items
            {
                var value = (uint) 1 << i;
                items.Add(new CCBoxItem(value.ToString(format), value, true));
            }

            MaxDropDownItems = Math.Min(values.Length, 16);
            DisplayMember = "Name";
            ValueSeparator = ",";
            //this.ValueMember = "Value";

            Items.Clear();
            foreach (var item in items) Items.Add(item);
        }

        public void SetState(uint value)
        {
            for (int i = 0; i < items.Count; ++i)
            {
                SetItemChecked(i, ((value & items[i].Value) == items[i].Value));
            }
        }

        public uint GetState()
        {
            uint value = 0;

            for (int i = 0; i < items.Count; ++i)
            {
                var state = GetItemCheckState(i);
                if (state != CheckState.Unchecked)
                    value |= items[i].Value;
            }
            return value;
        }
        public override string GetCheckedItemsStringValue()
        {
            var sb = new StringBuilder("");
            var cclb = dropdown.List;
            uint raw = 0;
            foreach (CCBoxItem t in cclb.CheckedItems)
            {
                if (t.IsRaw)
                {
                    raw |= t.Value;
                }
                else
                {
                    if (sb.Length > 0) sb.Append(this.ValueSeparator);
                    sb.Append(cclb.GetItemText(t));                    
                }
            }
            if (raw != 0)
            {
                int bits = (int)Math.Ceiling(Math.Log(raw) / Math.Log(2.0f));
                int bytes = (bits / 4) + (((bits % 4) != 0) ? 1 : 0);
                bytes = ((bytes / 2) + ((bytes % 2 != 0) ? 1 : 0)) * 2;
                string format = "X" + bytes.ToString();

                if (sb.Length > 0) sb.Append(this.ValueSeparator);
                sb.Append(raw.ToString(format));                
            }
            return sb.ToString();
        }
    }

    // end public class CheckedComboBox
}