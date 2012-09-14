namespace TESVSnip.Framework.Collections
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.ComponentModel;

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
            if (property == null)
            {
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
                return this.@descending;
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
                return this.property;
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
            int value = Comparer.Default.Compare(this.property.GetValue(x), this.property.GetValue(y));
            return this.@descending ? -value : value;
        }
    }
}
