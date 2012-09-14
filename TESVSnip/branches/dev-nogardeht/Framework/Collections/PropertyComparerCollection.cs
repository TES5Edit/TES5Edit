namespace TESVSnip.Framework.Collections
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;

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
            if (sorts == null)
            {
                throw new ArgumentNullException("sorts");
            }

            this.sorts = sorts;
            var list = new List<PropertyComparer<T>>();
            foreach (ListSortDescription item in sorts)
            {
                list.Add(new PropertyComparer<T>(item.PropertyDescriptor, item.SortDirection == ListSortDirection.Descending));
            }

            this.comparers = list.ToArray();
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
                return this.comparers.Length == 0 ? ListSortDirection.Ascending : this.comparers[0].Descending ? ListSortDirection.Descending : ListSortDirection.Ascending;
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
                return this.comparers.Length == 0 ? null : this.comparers[0].Property;
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
                return this.sorts;
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
            for (int i = 0; i < this.comparers.Length; i++)
            {
                result = this.comparers[i].Compare(x, y);
                if (result != 0)
                {
                    break;
                }
            }

            return result;
        }
    }
}
