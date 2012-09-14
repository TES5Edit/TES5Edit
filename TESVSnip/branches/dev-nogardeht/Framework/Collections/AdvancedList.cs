namespace TESVSnip.Framework.Collections
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Linq;
    using System.Runtime.Serialization;

    using TESVSnip.Framework.Persistence;

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
        ///   Deserialization constructor.
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
            if (items != null)
            {
                this.AddRange(items);
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
                return this._allowSort;
            }

            set
            {
                this._allowSort = value;
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
                return this.sorts != null ? this.sorts.Sorts : null;
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
                return this.sorts != null;
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
                return this.sorts == null ? ListSortDirection.Ascending : this.sorts.PrimaryDirection;
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
                return this.sorts == null ? null : this.sorts.PrimaryProperty;
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
                return this._allowSort;
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
            foreach (T item in items)
            {
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
            if (this._allowSort)
            {
                bool oldRaise = RaiseListChangedEvents;
                RaiseListChangedEvents = false;
                try
                {
                    var tmp = new PropertyComparerCollection<T>(sortCollection);
                    var items = new List<T>(this);
                    items.Sort(tmp);
                    int index = 0;
                    foreach (T item in items)
                    {
                        SetItem(index++, item);
                    }

                    this.sorts = tmp;
                }
                finally
                {
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
            foreach (T item in items)
            {
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
            for (int i = 0; i < retval.Length; ++i)
            {
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
            info.AddValue("Items", this.ToArray());
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
            if (this._allowSort)
            {
                ListSortDescription[] arr = { new ListSortDescription(prop, direction) };
                this.ApplySort(new ListSortDescriptionCollection(arr));
            }
        }

        /// <summary>
        /// The remove sort core.
        /// </summary>
        protected override void RemoveSortCore()
        {
            this.sorts = null;
        }
    }
}
