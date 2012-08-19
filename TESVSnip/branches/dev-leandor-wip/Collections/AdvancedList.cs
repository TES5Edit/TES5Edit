namespace TESVSnip.Collections.Generic
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Linq;
    using System.Runtime.Serialization;

    using TESVSnip.Data;

    /// <summary>
    /// The advanced list.
    /// </summary>
    /// <typeparam name="T">
    /// </typeparam>
    [Persistable(Flags = PersistType.DeclaredOnly)]
    [Serializable]
    public class AdvancedList<T> : BindingList<T>, IBindingListView, ISerializable, IPostSerializationCallback
    {
        /// <summary>
        /// The _allow sort.
        /// </summary>
        private bool _allowSort = true;

        /// <summary>
        /// The sorts.
        /// </summary>
        private PropertyComparerCollection<T> sorts;

        /// <summary>
        /// Initializes a new instance of the <see cref="AdvancedList{T}"/> class.
        /// </summary>
        public AdvancedList()
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="AdvancedList{T}"/> class.
        /// </summary>
        /// <param name="capacity">
        /// The capacity.
        /// </param>
        public AdvancedList(int capacity)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="AdvancedList{T}"/> class.
        /// </summary>
        /// <param name="list">
        /// The list.
        /// </param>
        public AdvancedList(IList<T> list)
                : base(list ?? new T[0])
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="AdvancedList{T}"/> class.
        /// </summary>
        /// <param name="list">
        /// The list.
        /// </param>
        public AdvancedList(IEnumerable<T> list)
                : base(list != null ? (IList<T>)list.ToList() : new T[0])
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="AdvancedList{T}"/> class. 
        /// Deserialization constructor.
        /// </summary>
        /// <param name="info">
        /// The info.
        /// </param>
        /// <param name="context">
        /// The context.
        /// </param>
        protected AdvancedList(SerializationInfo info, StreamingContext context)
        {
            var items = info.GetValue("Items", typeof(T[])) as T[];
            if (items != null) {
                AddRange(items);
            }

            PersistAssist.Deserialize(this, info, context);
        }

        /// <summary>
        /// Gets or sets a value indicating whether allow sorting.
        /// </summary>
        /// <value>
        /// The allow sorting.
        /// </value>
        public virtual bool AllowSorting
        {
            get
            {
                return _allowSort;
            }

            set
            {
                _allowSort = value;
            }
        }

        /// <summary>
        /// Gets or sets the filter.
        /// </summary>
        /// <value>
        /// The filter.
        /// </value>
        /// <exception cref="NotImplementedException">
        /// </exception>
        string IBindingListView.Filter
        {
            get
            {
                throw new NotImplementedException();
            }

            set
            {
                throw new NotImplementedException();
            }
        }

        /// <summary>
        /// Gets the sort descriptions.
        /// </summary>
        /// <value>
        /// The sort descriptions.
        /// </value>
        ListSortDescriptionCollection IBindingListView.SortDescriptions
        {
            get
            {
                return sorts != null ? sorts.Sorts : null;
            }
        }

        /// <summary>
        /// Gets a value indicating whether supports advanced sorting.
        /// </summary>
        /// <value>
        /// The supports advanced sorting.
        /// </value>
        bool IBindingListView.SupportsAdvancedSorting
        {
            get
            {
                return true;
            }
        }

        /// <summary>
        /// Gets a value indicating whether supports filtering.
        /// </summary>
        /// <value>
        /// The supports filtering.
        /// </value>
        bool IBindingListView.SupportsFiltering
        {
            get
            {
                return false;
            }
        }

        /// <summary>
        /// Gets a value indicating whether need callback.
        /// </summary>
        /// <value>
        /// The need callback.
        /// </value>
        bool IPostSerializationCallback.NeedCallback
        {
            get
            {
                return true;
            }
        }

        /// <summary>
        /// Gets a value indicating whether is sorted core.
        /// </summary>
        /// <value>
        /// The is sorted core.
        /// </value>
        protected override bool IsSortedCore
        {
            get
            {
                return sorts != null;
            }
        }

        /// <summary>
        /// Gets the sort direction core.
        /// </summary>
        /// <value>
        /// The sort direction core.
        /// </value>
        protected override ListSortDirection SortDirectionCore
        {
            get
            {
                return sorts == null ? ListSortDirection.Ascending : sorts.PrimaryDirection;
            }
        }

        /// <summary>
        /// Gets the sort property core.
        /// </summary>
        /// <value>
        /// The sort property core.
        /// </value>
        protected override PropertyDescriptor SortPropertyCore
        {
            get
            {
                return sorts == null ? null : sorts.PrimaryProperty;
            }
        }

        /// <summary>
        /// Gets a value indicating whether supports sorting core.
        /// </summary>
        /// <value>
        /// The supports sorting core.
        /// </value>
        protected override bool SupportsSortingCore
        {
            get
            {
                return _allowSort;
            }
        }

        /// <summary>
        /// The add range.
        /// </summary>
        /// <param name="items">
        /// The items.
        /// </param>
        public void AddRange(ICollection<T> items)
        {
            foreach (T item in items) {
                Add(item);
            }
        }

        /// <summary>
        /// The apply sort.
        /// </summary>
        /// <param name="sortCollection">
        /// The sort collection.
        /// </param>
        public void ApplySort(ListSortDescriptionCollection sortCollection)
        {
            if (_allowSort) {
                bool oldRaise = RaiseListChangedEvents;
                RaiseListChangedEvents = false;
                try {
                    var tmp = new PropertyComparerCollection<T>(sortCollection);
                    var items = new List<T>(this);
                    items.Sort(tmp);
                    int index = 0;
                    foreach (T item in items) {
                        SetItem(index++, item);
                    }

                    sorts = tmp;
                }
                finally {
                    RaiseListChangedEvents = oldRaise;
                    ResetBindings();
                }
            }
        }

        /// <summary>
        /// The insert range.
        /// </summary>
        /// <param name="index">
        /// The index.
        /// </param>
        /// <param name="items">
        /// The items.
        /// </param>
        public void InsertRange(int index, ICollection<T> items)
        {
            foreach (T item in items) {
                InsertItem(index, item);
            }
        }

        /// <summary>
        /// The remove range.
        /// </summary>
        /// <param name="items">
        /// The items.
        /// </param>
        /// <returns>
        /// The System.Boolean.
        /// </returns>
        public virtual bool RemoveRange(IEnumerable<T> items)
        {
            return items.Aggregate(false, (current, item) => current | Remove(item));
        }

        /// <summary>
        /// The to array.
        /// </summary>
        /// <returns>
        /// The T[].
        /// </returns>
        public T[] ToArray()
        {
            var retval = new T[Items.Count];
            for (int i = 0; i < retval.Length; ++i) {
                retval[i] = Items[i];
            }

            return retval;
        }

        /// <summary>
        /// The remove filter.
        /// </summary>
        /// <exception cref="NotImplementedException">
        /// </exception>
        void IBindingListView.RemoveFilter()
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// The on post serialization.
        /// </summary>
        void IPostSerializationCallback.OnPostSerialization()
        {
        }

        /// <summary>
        /// The get object data.
        /// </summary>
        /// <param name="info">
        /// The info.
        /// </param>
        /// <param name="context">
        /// The context.
        /// </param>
        void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
        {
            info.AddValue("Items", ToArray());
            PersistAssist.Serialize(this, info, context);
        }

        /// <summary>
        /// The apply sort core.
        /// </summary>
        /// <param name="prop">
        /// The prop.
        /// </param>
        /// <param name="direction">
        /// The direction.
        /// </param>
        protected override void ApplySortCore(PropertyDescriptor prop, ListSortDirection direction)
        {
            if (_allowSort) {
                ListSortDescription[] arr = { new ListSortDescription(prop, direction) };
                ApplySort(new ListSortDescriptionCollection(arr));
            }
        }

        /// <summary>
        /// The remove sort core.
        /// </summary>
        protected override void RemoveSortCore()
        {
            sorts = null;
        }
    }

    /// <summary>
    /// The property comparer collection.
    /// </summary>
    /// <typeparam name="T">
    /// </typeparam>
    public class PropertyComparerCollection<T> : IComparer<T>
    {
        /// <summary>
        /// The comparers.
        /// </summary>
        private readonly PropertyComparer<T>[] comparers;

        /// <summary>
        /// The sorts.
        /// </summary>
        private readonly ListSortDescriptionCollection sorts;

        /// <summary>
        /// Initializes a new instance of the <see cref="PropertyComparerCollection{T}"/> class.
        /// </summary>
        /// <param name="sorts">
        /// The sorts.
        /// </param>
        /// <exception cref="ArgumentNullException">
        /// </exception>
        public PropertyComparerCollection(ListSortDescriptionCollection sorts)
        {
            if (sorts == null) {
                throw new ArgumentNullException("sorts");
            }

            this.sorts = sorts;
            var list = new List<PropertyComparer<T>>();
            foreach (ListSortDescription item in sorts) {
                list.Add(new PropertyComparer<T>(item.PropertyDescriptor, item.SortDirection == ListSortDirection.Descending));
            }

            comparers = list.ToArray();
        }

        /// <summary>
        /// Gets the primary direction.
        /// </summary>
        /// <value>
        /// The primary direction.
        /// </value>
        public ListSortDirection PrimaryDirection
        {
            get
            {
                return comparers.Length == 0 ? ListSortDirection.Ascending : comparers[0].Descending ? ListSortDirection.Descending : ListSortDirection.Ascending;
            }
        }

        /// <summary>
        /// Gets the primary property.
        /// </summary>
        /// <value>
        /// The primary property.
        /// </value>
        public PropertyDescriptor PrimaryProperty
        {
            get
            {
                return comparers.Length == 0 ? null : comparers[0].Property;
            }
        }

        /// <summary>
        /// Gets the sorts.
        /// </summary>
        /// <value>
        /// The sorts.
        /// </value>
        public ListSortDescriptionCollection Sorts
        {
            get
            {
                return sorts;
            }
        }

        /// <summary>
        /// The compare.
        /// </summary>
        /// <param name="x">
        /// The x.
        /// </param>
        /// <param name="y">
        /// The y.
        /// </param>
        /// <returns>
        /// The System.Int32.
        /// </returns>
        int IComparer<T>.Compare(T x, T y)
        {
            int result = 0;
            for (int i = 0; i < comparers.Length; i++) {
                result = comparers[i].Compare(x, y);
                if (result != 0) {
                    break;
                }
            }

            return result;
        }
    }

    /// <summary>
    /// The property comparer.
    /// </summary>
    /// <typeparam name="T">
    /// </typeparam>
    public class PropertyComparer<T> : IComparer<T>
    {
        /// <summary>
        /// The descending.
        /// </summary>
        private readonly bool descending;

        /// <summary>
        /// The property.
        /// </summary>
        private readonly PropertyDescriptor property;

        /// <summary>
        /// Initializes a new instance of the <see cref="PropertyComparer{T}"/> class.
        /// </summary>
        /// <param name="property">
        /// The property.
        /// </param>
        /// <param name="descending">
        /// The descending.
        /// </param>
        /// <exception cref="ArgumentNullException">
        /// </exception>
        public PropertyComparer(PropertyDescriptor property, bool descending)
        {
            if (property == null) {
                throw new ArgumentNullException("property");
            }

            this.descending = descending;
            this.property = property;
        }

        /// <summary>
        /// Gets a value indicating whether descending.
        /// </summary>
        /// <value>
        /// The descending.
        /// </value>
        public bool Descending
        {
            get
            {
                return descending;
            }
        }

        /// <summary>
        /// Gets the property.
        /// </summary>
        /// <value>
        /// The property.
        /// </value>
        public PropertyDescriptor Property
        {
            get
            {
                return property;
            }
        }

        /// <summary>
        /// The compare.
        /// </summary>
        /// <param name="x">
        /// The x.
        /// </param>
        /// <param name="y">
        /// The y.
        /// </param>
        /// <returns>
        /// The System.Int32.
        /// </returns>
        public int Compare(T x, T y)
        {
            // todo; some null cases
            int value = Comparer.Default.Compare(property.GetValue(x), property.GetValue(y));
            return descending ? -value : value;
        }
    }
}
