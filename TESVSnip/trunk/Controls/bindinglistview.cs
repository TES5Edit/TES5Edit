using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace TESVSnip.Windows.Controls
{
    /// <summary>
    /// Summary description for BindingListView.
    /// </summary>
    public class BindingListView : VirtualListView
    {
        private IList _data;

        private int lvcacheStart = -1;
        private int lvcacheEnd = -1;
        private readonly List<ListViewItem> lvcache = new List<ListViewItem>();

        public BindingListView()
        {
            InitializeComponent();

            FullRowSelect = true;
            HideSelection = false;
            View = View.Details;
            base.QueryItemText += BindingListView_QueryItemText;
            base.CacheVirtualItems += BindingListView_CacheVirtualItems;
            base.RetrieveVirtualItem += BindingListView_RetrieveVirtualItem;
        }

        [DllImport("uxtheme.dll", CharSet = CharSet.Unicode, ExactSpelling = true)]
        internal static extern int SetWindowTheme(IntPtr hWnd, string appName, string partList);

        // You can subclass ListView and override this method
        protected override void OnHandleCreated(EventArgs e)
        {
            base.OnHandleCreated(e);
            SetWindowTheme(Handle, "explorer", null);
        }

        private ListViewItem CreateBlankListViewItem()
        {
            var subItems = new ListViewItem.ListViewSubItem[Columns.Count];
            for (int i = 0; i < subItems.Length; ++i)
                subItems[i] = new ListViewItem.ListViewSubItem();
            return new ListViewItem(subItems, -1);
        }

        private void FillListViewItem(ListViewItem lvItem, int index)
        {
            if (index >= 0 && _data != null && index < _data.Count)
            {
                object item = _data[index];
                for (int i = 0; i < lvItem.SubItems.Count; ++i)
                {
                    var header = Columns[i] as ColumnBinding;
                    var subItem = lvItem.SubItems[i];
                    if (header != null)
                    {
                        object value = header.GetPropertyValue(item);
                        if (value != null) subItem.Text = value.ToString();
                    }
                }
            }
        }

        private void BindingListView_RetrieveVirtualItem(object sender, RetrieveVirtualItemEventArgs e)
        {
            if (e.ItemIndex >= lvcacheStart && e.ItemIndex <= lvcacheEnd)
            {
                e.Item = lvcache[e.ItemIndex - lvcacheStart];
            }
            else
            {
                e.Item = CreateBlankListViewItem();
                FillListViewItem(e.Item, e.ItemIndex);
            }
        }

        private void BindingListView_CacheVirtualItems(object sender, CacheVirtualItemsEventArgs e)
        {
            int len = e.EndIndex - e.StartIndex + 1;
            lvcacheStart = e.StartIndex;
            if (len != lvcache.Count)
            {
                if (lvcache.Capacity < len)
                    lvcache.Capacity = len;
                while (lvcache.Count < len)
                    lvcache.Add(CreateBlankListViewItem());
                if (lvcache.Count > len)
                    lvcache.RemoveRange(len, lvcache.Count - len);
            }
            for (int i = 0; i < lvcache.Count; ++i)
            {
                FillListViewItem(lvcache[i], e.StartIndex + i);
            }
        }

        private event QueryItemTextHandler _QueryItemText;

        public new event QueryItemTextHandler QueryItemText
        {
            add { _QueryItemText += value; }
            remove { _QueryItemText -= value; }
        }


        public new IList Items
        {
            get { return _data; }
        }


        public ColumnBinding AddBindingColumn<T, TResult>(string PropertyName, string DisplayName)
        {
            var column = new ColumnBinding();
            column.Text = DisplayName;
            column.Property = new ColumnPropertyDescriptor<T, TResult>(PropertyName, null);
            Columns.Add(column);
            return column;
        }

        public ColumnBinding AddBindingColumn<T, TResult>(string PropertyName, string DisplayName, int width)
        {
            ColumnBinding column = AddBindingColumn<T, TResult>(PropertyName, DisplayName);
            column.Width = width;
            return column;
        }

        public ColumnBinding AddBindingColumn<T, TResult>(string PropertyName, string DisplayName, int width,
                                                          Delegate transform)
        {
            ColumnBinding column = AddBindingColumn<T, TResult>(PropertyName, DisplayName, width);
            column.Property = new ColumnPropertyDescriptor<T, TResult>(PropertyName, transform);
            return column;
        }

        public ColumnBinding AddBindingColumn<T, TResult>(string PropertyName, string DisplayName, int width,
                                                          HorizontalAlignment textAlign)
        {
            ColumnBinding column = AddBindingColumn<T, TResult>(PropertyName, DisplayName, width);
            column.TextAlign = textAlign;
            return column;
        }

        public ColumnBinding AddBindingColumn<T, TResult>(string PropertyName, string DisplayName, int width,
                                                          HorizontalAlignment textAlign, Delegate transform)
        {
            ColumnBinding column = AddBindingColumn<T, TResult>(PropertyName, DisplayName, width, textAlign);
            column.Property = new ColumnPropertyDescriptor<T, TResult>(PropertyName, transform);
            return column;
        }

        public ColumnBinding AddBindingColumn(string PropertyName, string DisplayName)
        {
            var column = new ColumnBinding();
            column.Text = DisplayName;
            column.Property = new ColumnPropertyDescriptor<object, string>(PropertyName, null);
            Columns.Add(column);
            return column;
        }

        public ColumnBinding AddBindingColumn(string PropertyName, string DisplayName, int width)
        {
            ColumnBinding column = AddBindingColumn(PropertyName, DisplayName);
            column.Width = width;
            return column;
        }

        public ColumnBinding AddBindingColumn(string PropertyName, string DisplayName, int width, Delegate transform)
        {
            ColumnBinding column = AddBindingColumn(PropertyName, DisplayName, width);
            column.Property = new ColumnPropertyDescriptor<object, string>(PropertyName, transform);
            return column;
        }

        public ColumnBinding AddBindingColumn(string PropertyName, string DisplayName, int width,
                                              HorizontalAlignment textAlign)
        {
            ColumnBinding column = AddBindingColumn(PropertyName, DisplayName, width);
            column.TextAlign = textAlign;
            return column;
        }

        public ColumnBinding AddBindingColumn(string PropertyName, string DisplayName, int width,
                                              HorizontalAlignment textAlign, Delegate transform)
        {
            ColumnBinding column = AddBindingColumn(PropertyName, DisplayName, width, textAlign);
            column.Property = new ColumnPropertyDescriptor<object, string>(PropertyName, transform);
            return column;
        }

        public void AddBindingColumn(PropertyDescriptor property)
        {
            var column = new ColumnBinding();
            column.Text = property.DisplayName;
            column.Property = property;
            Columns.Add(column);
        }

        public void AddBindingColumn(PropertyDescriptor property, string DisplayName)
        {
            var column = new ColumnBinding();
            column.Text = DisplayName;
            column.Property = property;
            Columns.Add(column);
        }

        public void AddBindingColumn(PropertyDescriptor property, string DisplayName, int width)
        {
            var column = new ColumnBinding();
            column.Text = DisplayName;
            column.Property = property;
            column.Width = width;
            Columns.Add(column);
        }

        public void AddBindingColumn(PropertyDescriptor property, string DisplayName, int width,
                                     HorizontalAlignment textAlign)
        {
            var column = new ColumnBinding();
            column.Text = DisplayName;
            column.Property = property;
            column.Width = width;
            column.TextAlign = textAlign;
            Columns.Add(column);
        }

        public void RemoveBindingColumns(string PropertyName)
        {
            foreach (ColumnBinding column in Columns)
            {
                if ((column.Property != null && column.Property.Name == PropertyName)
                    || (column.FieldName == PropertyName)
                    )
                {
                    Columns.Remove(column);
                    break;
                }
            }
        }

        public ColumnBinding GetColumnBinding(int column)
        {
            return (column >= 0 && column < Columns.Count) ? Columns[column] as ColumnBinding : null;
        }

        public void ClearBindingColumns()
        {
            Columns.Clear();
        }

        public IList DataSource
        {
            get { return _data; }
            set
            {
                if (_data != value)
                {
                    var list = _data as IBindingList;
                    if (list != null) list.ListChanged -= DataSource_ListChanged;

                    _data = value;

                    list = _data as IBindingList;
                    if (list != null) list.ListChanged += DataSource_ListChanged;

                    if (Columns.Count == 0 && _data is ITypedList)
                    {
                        var typedList = _data as ITypedList;
                        PropertyDescriptorCollection properties = typedList.GetItemProperties(null);
                        if (properties != null)
                        {
                            foreach (PropertyDescriptor pd in properties)
                            {
                                var column = new ColumnBinding();
                                column.Text = pd.DisplayName;
                                column.Property = pd;
                                Columns.Add(column);
                            }
                        }
                    }
                    ItemCount = (_data == null) ? 0 : _data.Count;
                }
            }
        }

        private void BindingListView_QueryItemText(int item, int subItem, out string text)
        {
            text = string.Empty;
            try
            {
                if (_QueryItemText != null)
                {
                    _QueryItemText(item, subItem, out text);
                }
                else if (DataSource != null && item < DataSource.Count)
                {
                    var header = Columns[subItem] as ColumnBinding;
                    if (header != null)
                    {
                        object value = header.GetPropertyValue(DataSource[item]);
                        if (value != null) text = value.ToString();
                    }
                }
            }
            catch
            {
            }
        }

        private void DataSource_ListChanged(object sender, ListChangedEventArgs e)
        {
            switch (e.ListChangedType)
            {
                case ListChangedType.ItemAdded:
                    goto case ListChangedType.Reset;
                case ListChangedType.ItemChanged:
                    goto case ListChangedType.Reset;
                case ListChangedType.ItemDeleted:
                    goto case ListChangedType.Reset;
                case ListChangedType.ItemMoved:
                    goto case ListChangedType.Reset;
                case ListChangedType.Reset:
                    ItemCount = (_data == null) ? 0 : _data.Count;
                    Invalidate();
                    break;
            }
        }

        private void InitializeComponent()
        {
            SuspendLayout();
            // 
            // BindingListView
            // 
            KeyDown += BindingListView_KeyDown;
            CustomSort += BindingListView_CustomSort;
            ResumeLayout(false);
        }

        protected override void Dispose(bool disposing)
        {
            base.QueryItemText -= BindingListView_QueryItemText;
            DataSource = null;
            base.Dispose(disposing);
        }

        #region ColumnPropertyDescriptor

        /// <summary>
        /// Custom column property descriptor
        /// </summary>
        private class ColumnPropertyDescriptor<T, TResult>
            : PropertyDescriptor
        {
            #region Fields

            private readonly Delegate _propValueCast;

            #endregion

            #region Constructors

            /// <summary>
            /// Initializes a new instance of the CsvPropertyDescriptor class.
            /// </summary>
            /// <param name="fieldName">The field name.</param>
            /// <param name="index">The field index.</param>
            public ColumnPropertyDescriptor(string fieldName, Delegate propertyFunction)
                : base(fieldName, null)
            {
                _propValueCast = propertyFunction;
            }

            #endregion


            #region Overrides

            public override bool CanResetValue(object component)
            {
                return false;
            }

            public override object GetValue(object item)
            {
                object value = null;
                if (_propValueCast != null)
                {
                    try
                    {
                        value = _propValueCast.DynamicInvoke(item);
                    }
                    catch
                    {
                    }
                }
                else if (string.IsNullOrEmpty(Name))
                {
                    value = item;
                }
                else
                {
                    if (Name.IndexOf(".") > 0)
                    {
                        string[] fields = Name.Split('.');
                        object context = item;
                        foreach (string field in fields)
                        {
                            PropertyInfo prop = context.GetType().GetProperty(field);
                            if (prop == null)
                            {
                                context = null;
                                break;
                            }
                            context = prop.GetValue(context, new object[0]);
                        }
                        value = context;
                    }
                    else
                    {
                        PropertyInfo prop = item.GetType().GetProperty(Name);
                        if (prop != null)
                        {
                            value = prop.GetValue(item, new object[0]);
                        }
                        else
                        {
                            foreach (PropertyDescriptor pd in TypeDescriptor.GetProperties(item))
                            {
                                if (pd.Name == Name)
                                {
                                    value = pd.GetValue(item);
                                    break;
                                }
                            }
                        }
                    }
                }
                return value;
            }

            public override void ResetValue(object component)
            {
            }

            public override void SetValue(object component, object value)
            {
            }

            public override bool ShouldSerializeValue(object component)
            {
                return false;
            }

            public override Type ComponentType
            {
                get { return typeof (T); }
            }

            public override bool IsReadOnly
            {
                get { return true; }
            }

            public override Type PropertyType
            {
                get { return typeof (TResult); }
            }

            #endregion
        }

        #endregion

        #region class ColumnBinding

        public class ColumnBinding : ColumnHeader
        {
            private PropertyDescriptor _propDesc;
            //string _propName = string.Empty;
            //Delegate _propValueCast = null;

            public string FieldName
            {
                get { return _propDesc.Name; }
            }

            public PropertyDescriptor Property
            {
                get { return _propDesc; }
                set { _propDesc = value; }
            }

            public object GetPropertyValue(object item)
            {
                object value = null;
                if (_propDesc != null)
                {
                    object entry = item;
                    if (item is ICustomTypeDescriptor)
                    {
                        entry = (item as ICustomTypeDescriptor).GetPropertyOwner(_propDesc);
                        if (entry == null)
                            entry = item;
                    }
                    value = _propDesc.GetValue(entry);
                }
                return value;
            }
        }

        #endregion

        private void BindingListView_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Control && !e.Shift && !e.Alt && e.KeyValue == 'C')
            {
                Copy();
            }
            else if (e.Control && !e.Shift && !e.Alt && e.KeyValue == 'A')
            {
                SelectAll();
            }
        }


        private void BindingListView_CustomSort(int iColumn)
        {
            if (DataSource != null && iColumn >= 0 && iColumn < Columns.Count)
            {
                var header = Columns[iColumn] as ColumnBinding;
                if (header != null)
                {
                    var view = DataSource as IBindingListView;
                    if (view != null)
                    {
                        string fieldName = header.Property != null ? header.Property.Name : header.FieldName;
                        if (!string.IsNullOrEmpty(fieldName))
                        {
                            // handle existing sorts
                            if (view.IsSorted)
                            {
                                var arr = new ListSortDescription[view.SortDescriptions.Count];
                                view.SortDescriptions.CopyTo(arr, 0);
                                bool found = false;
                                for (int idx = 0; idx < arr.Length; ++idx)
                                {
                                    ListSortDescription desc = arr[idx];
                                    if (desc.PropertyDescriptor.Name == fieldName)
                                    {
                                        found = true;
                                        if (idx == 0)
                                        {
                                            if (desc.SortDirection == ListSortDirection.Descending)
                                            {
                                                desc.SortDirection = ListSortDirection.Ascending;
                                            }
                                            else
                                            {
                                                var list = new List<ListSortDescription>(arr);
                                                list.Remove(desc);
                                                arr = list.ToArray();
                                            }
                                        }
                                        else
                                        {
                                            var list = new List<ListSortDescription>(arr);
                                            list.Remove(desc);
                                            list.Insert(0, desc);
                                            desc.SortDirection = ListSortDirection.Ascending;
                                            arr = list.ToArray();
                                        }
                                        break;
                                    }
                                }
                                if (!found)
                                {
                                    var list = new List<ListSortDescription>(arr);
                                    list.Insert(0,
                                                new ListSortDescription(header.Property, ListSortDirection.Descending));
                                    while (list.Count > 3)
                                        list.RemoveAt(list.Count - 1);
                                    arr = list.ToArray();
                                }
                                view.ApplySort(new ListSortDescriptionCollection(arr));
                            }
                            else
                            {
                                view.ApplySort(header.Property, ListSortDirection.Ascending);
                            }
                        }
                    }
                }
            }
        }
    }
}