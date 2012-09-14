namespace TESVSnip.Framework.Collections
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Diagnostics;

    // Summary:
    // Represents a strongly typed list of objects that can be accessed by index.
    // Provides methods to search, sort, and manipulate lists.
    /// <summary>
    /// The ordered dictionary.
    /// </summary>
    /// <typeparam name="TKey">
    /// </typeparam>
    /// <typeparam name="TItem">
    /// </typeparam>
    [DebuggerDisplay("Count = {Count}")]
    public class OrderedDictionary<TKey, TItem> : IDictionary<TKey, TItem>, IDictionary, ICollection<KeyValuePair<TKey, TItem>>, IEnumerable<KeyValuePair<TKey, TItem>>
    {
        /// <summary>
        /// The _ t key comparer.
        /// </summary>
        private readonly IEqualityComparer<TKey> _TKeyComparer;

        /// <summary>
        /// The _hash.
        /// </summary>
        private readonly Dictionary<TKey, KeyValuePair<TKey, TItem>> _hash;

        /// <summary>
        /// The _kvp.
        /// </summary>
        private readonly List<KeyValuePair<TKey, TItem>> _kvp;

        // Summary:
        // Initializes a new instance of the System.Collections.Generic.List<T> class
        // that is empty and has the default initial capacity.
        /// <summary>
        /// Initializes a new instance of the <see cref="OrderedDictionary{TKey,TItem}"/> class.
        /// </summary>
        public OrderedDictionary()
        {
            this._kvp = new List<KeyValuePair<TKey, TItem>>();
            this._TKeyComparer = EqualityComparer<TKey>.Default;
            this._hash = new Dictionary<TKey, KeyValuePair<TKey, TItem>>(this._TKeyComparer);
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="OrderedDictionary{TKey,TItem}"/> class.
        /// </summary>
        /// <param name="KeyComparer">
        /// The key comparer. 
        /// </param>
        public OrderedDictionary(IEqualityComparer<TKey> KeyComparer)
        {
            this._kvp = new List<KeyValuePair<TKey, TItem>>();
            this._TKeyComparer = KeyComparer;
            this._hash = new Dictionary<TKey, KeyValuePair<TKey, TItem>>(this._TKeyComparer);
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="OrderedDictionary{TKey,TItem}"/> class.
        /// </summary>
        /// <param name="other">
        /// The other. 
        /// </param>
        public OrderedDictionary(OrderedDictionary<TKey, TItem> other)
        {
            this._kvp = new List<KeyValuePair<TKey, TItem>>(other._kvp);
            this._TKeyComparer = other._TKeyComparer;
            this._hash = new Dictionary<TKey, KeyValuePair<TKey, TItem>>(this._TKeyComparer);
        }

        /// <summary>
        /// Gets the count.
        /// </summary>
        /// <value>
        /// The count. 
        /// </value>
        public int Count
        {
            get
            {
                return this._kvp.Count;
            }
        }

        /// <summary>
        /// Gets the keys.
        /// </summary>
        /// <value>
        /// The keys. 
        /// </value>
        public ICollection<TKey> Keys
        {
            get
            {
                return new OrderedKeyCollection(this);
            }
        }

        /// <summary>
        /// Gets the values.
        /// </summary>
        /// <value>
        /// The values. 
        /// </value>
        public ICollection<TItem> Values
        {
            get
            {
                return new OrderedValueCollection(this);
            }
        }

        /// <summary>
        /// Gets the count.
        /// </summary>
        /// <value>
        /// The count. 
        /// </value>
        int ICollection.Count
        {
            get
            {
                return this.Count;
            }
        }

        /// <summary>
        /// Gets a value indicating whether is fixed size.
        /// </summary>
        /// <value>
        /// The is fixed size. 
        /// </value>
        /// <exception cref="Exception">
        /// </exception>
        bool IDictionary.IsFixedSize
        {
            get
            {
                throw new Exception("The method or operation is not implemented.");
            }
        }

        /// <summary>
        /// Gets a value indicating whether is read only.
        /// </summary>
        /// <value>
        /// The is read only. 
        /// </value>
        bool IDictionary.IsReadOnly
        {
            get
            {
                return true;
            }
        }

        /// <summary>
        /// Gets a value indicating whether is synchronized.
        /// </summary>
        /// <value>
        /// The is synchronized. 
        /// </value>
        bool ICollection.IsSynchronized
        {
            get
            {
                return false;
            }
        }

        /// <summary>
        /// Gets the keys.
        /// </summary>
        /// <value>
        /// The keys. 
        /// </value>
        ICollection IDictionary.Keys
        {
            get
            {
                return (ICollection)this.Keys;
            }
        }

        /// <summary>
        /// Gets the sync root.
        /// </summary>
        /// <value>
        /// The sync root. 
        /// </value>
        object ICollection.SyncRoot
        {
            get
            {
                return null;
            }
        }

        /// <summary>
        /// Gets the values.
        /// </summary>
        /// <value>
        /// The values. 
        /// </value>
        ICollection IDictionary.Values
        {
            get
            {
                return (ICollection)this.Values;
            }
        }

        /// <summary>
        /// Gets the count.
        /// </summary>
        /// <value>
        /// The count. 
        /// </value>
        int ICollection<KeyValuePair<TKey, TItem>>.Count
        {
            get
            {
                return this._kvp.Count;
            }
        }

        /// <summary>
        /// Gets a value indicating whether is read only.
        /// </summary>
        /// <value>
        /// The is read only. 
        /// </value>
        bool ICollection<KeyValuePair<TKey, TItem>>.IsReadOnly
        {
            get
            {
                return false;
            }
        }

        /// <summary>
        /// Gets the keys.
        /// </summary>
        /// <value>
        /// The keys. 
        /// </value>
        ICollection<TKey> IDictionary<TKey, TItem>.Keys
        {
            get
            {
                return this.Keys;
            }
        }

        /// <summary>
        /// Gets the values.
        /// </summary>
        /// <value>
        /// The values. 
        /// </value>
        ICollection<TItem> IDictionary<TKey, TItem>.Values
        {
            get
            {
                return this.Values;
            }
        }

        /// <summary>
        /// The this.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <exception cref="KeyNotFoundException">
        /// </exception>
        /// <returns>
        /// The TItem. 
        /// </returns>
        public TItem this[TKey key]
        {
            get
            {
                KeyValuePair<TKey, TItem> kvp;
                if (this.FindKVP(key, out kvp))
                {
                    return kvp.Value;
                }

                throw new KeyNotFoundException(key.ToString());
            }

            set
            {
                this.Add(key, value);
            }
        }

        /// <summary>
        /// The i dictionary.this.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <returns>
        /// The System.Object. 
        /// </returns>
        object IDictionary.this[object key]
        {
            get
            {
                return this[(TKey)key];
            }

            set
            {
                this[(TKey)key] = (TItem)value;
            }
        }

        /// <summary>
        /// The i dictionary&lt; t key, t item&gt;.this.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <returns>
        /// The TItem. 
        /// </returns>
        TItem IDictionary<TKey, TItem>.this[TKey key]
        {
            get
            {
                return this[key];
            }

            set
            {
                this[key] = value;
            }
        }

        /// <summary>
        /// The add.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <param name="value">
        /// The value. 
        /// </param>
        public void Add(TKey key, TItem value)
        {
            KeyValuePair<TKey, TItem> kvp;
            if (this.FindKVP(key, out kvp))
            {
                if (kvp.Value == null || !kvp.Value.Equals(value))
                {
                    kvp = new KeyValuePair<TKey, TItem>(key, value);
                    this._hash[key] = kvp;
                    int idx = this.FindKey(key);
                    if (idx >= 0)
                    {
                        this._kvp[idx] = kvp;
                    }
                    else
                    {
                        this._kvp.Add(new KeyValuePair<TKey, TItem>(key, value)); // ???? error condition
                    }
                }
            }
            else
            {
                kvp = new KeyValuePair<TKey, TItem>(key, value);
                this._hash[key] = kvp;
                this._kvp.Add(new KeyValuePair<TKey, TItem>(key, value));
            }
        }

        /// <summary>
        /// The clear.
        /// </summary>
        public void Clear()
        {
            this._kvp.Clear();
        }

        // Summary:
        // Determines whether the TESsnip.Collections.Generic.KeyList<TKey,T>
        // contains the specified key.
        // Parameters:
        // key:
        // The key to locate in the TESsnip.Collections.Generic.KeyList<TKey,T>.
        // Returns:
        // true if the TESsnip.Collections.Generic.KeyList<TKey,T> contains an
        // element with the specified key; otherwise, false.
        // Exceptions:
        // System.ArgumentNullException:
        // key is null.
        /// <summary>
        /// The contains key.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <returns>
        /// The System.Boolean. 
        /// </returns>
        /// <exception cref="ArgumentNullException">
        /// </exception>
        public bool ContainsKey(TKey key)
        {
            if (key == null)
            {
                throw new ArgumentNullException("key");
            }

            KeyValuePair<TKey, TItem> kvp;
            if (this._hash.TryGetValue(key, out kvp))
            {
                return true;
            }

            return this.FindKey(key) >= 0;
        }

        /// <summary>
        /// The contains value.
        /// </summary>
        /// <param name="value">
        /// The value. 
        /// </param>
        /// <returns>
        /// The System.Boolean. 
        /// </returns>
        /// <exception cref="ArgumentNullException">
        /// </exception>
        public bool ContainsValue(TItem value)
        {
            if (value == null)
            {
                throw new ArgumentNullException("key");
            }

            return this.FindValue(value) >= 0;
        }

        // Summary:
        // Removes the value with the specified key from the TESsnip.Collections.Generic.KeyList<TKey,T>.
        // Parameters:
        // key:
        // The key of the element to remove.
        // Returns:
        // true if the element is successfully found and removed; otherwise, false.
        // This method returns false if key is not found in the TESsnip.Collections.Generic.KeyList<TKey,T>.
        // Exceptions:
        // System.ArgumentNullException:
        // key is null.

        // public TItem this[int index]
        // {
        // get
        // {
        // return _kvp[index].Value;
        // }
        // set
        // {
        // KeyValuePair<TKey, TItem> item = _kvp[index];
        // if ( item.Value == null || !item.Value.Equals(value) )
        // _kvp[index] = new KeyValuePair<TKey, TItem>(item.Key, value);
        // }
        // }

        // Summary:
        // Searches for an element that matches the conditions defined by the specified
        // predicate, and returns the zero-based index of the first occurrence within
        // the entire System.Collections.Generic.List<T>.
        // Parameters:
        // match:
        // The System.Predicate<T> delegate that defines the conditions of the element
        // to search for.
        // Returns:
        // The zero-based index of the first occurrence of an element that matches the
        // conditions defined by match, if found; otherwise, –1.
        // Exceptions:
        // System.ArgumentNullException:
        // match is null.
        /// <summary>
        /// The find index.
        /// </summary>
        /// <param name="match">
        /// The match. 
        /// </param>
        /// <returns>
        /// The System.Int32. 
        /// </returns>
        public int FindIndex(TKey match)
        {
            return this.FindKey(match);
        }

        /// <summary>
        /// The find value.
        /// </summary>
        /// <param name="value">
        /// The value. 
        /// </param>
        /// <returns>
        /// The System.Int32. 
        /// </returns>
        public int FindValue(TItem value)
        {
            for (int idx = 0; idx < this._kvp.Count; ++idx)
            {
                if (this._kvp[idx].Value.Equals(value))
                {
                    return idx;
                }
            }

            return ~this._kvp.Count;
        }

        /// <summary>
        /// The get enumerator.
        /// </summary>
        /// <returns>
        /// The TESVSnip.Collections.Generic.OrderedDictionary`2+Enumerator. 
        /// </returns>
        public Enumerator GetEnumerator()
        {
            return new Enumerator(this);
        }

        /// <summary>
        /// The get key.
        /// </summary>
        /// <param name="index">
        /// The index. 
        /// </param>
        /// <returns>
        /// The TKey. 
        /// </returns>
        public TKey GetKey(int index)
        {
            return this._kvp[index].Key;
        }

        /// <summary>
        /// The insert.
        /// </summary>
        /// <param name="index">
        /// The index. 
        /// </param>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <param name="value">
        /// The value. 
        /// </param>
        /// <exception cref="KeyNotFoundException">
        /// </exception>
        public void Insert(int index, TKey key, TItem value)
        {
            KeyValuePair<TKey, TItem> kvp;
            if (!this.FindKVP(key, out kvp))
            {
                kvp = new KeyValuePair<TKey, TItem>(key, value);
                this._kvp.Insert(index, kvp);
                this._hash[key] = kvp;
                return;
            }

            throw new KeyNotFoundException();
        }

        /// <summary>
        /// The remove.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <returns>
        /// The System.Boolean. 
        /// </returns>
        /// <exception cref="ArgumentNullException">
        /// </exception>
        public bool Remove(TKey key)
        {
            if (key == null)
            {
                throw new ArgumentNullException("key");
            }

            this._hash.Remove(key);

            int idx = this.FindKey(key);
            if (idx >= 0)
            {
                this._kvp.RemoveAt(idx);
                return true;
            }

            return false;
        }

        /// <summary>
        /// The try get value.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <param name="value">
        /// The value. 
        /// </param>
        /// <returns>
        /// The System.Boolean. 
        /// </returns>
        /// <exception cref="ArgumentNullException">
        /// </exception>
        public bool TryGetValue(TKey key, out TItem value)
        {
            if (key == null)
            {
                throw new ArgumentNullException("key");
            }

            KeyValuePair<TKey, TItem> kvp;
            if (this.FindKVP(key, out kvp))
            {
                value = kvp.Value;
                return true;
            }

            value = default(TItem);
            return false;
        }

        /// <summary>
        /// The add.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <param name="value">
        /// The value. 
        /// </param>
        void IDictionary.Add(object key, object value)
        {
            this.Add((TKey)key, (TItem)value);
        }

        /// <summary>
        /// The clear.
        /// </summary>
        void IDictionary.Clear()
        {
            this.Clear();
        }

        /// <summary>
        /// The contains.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <returns>
        /// The System.Boolean. 
        /// </returns>
        bool IDictionary.Contains(object key)
        {
            return this.ContainsKey((TKey)key);
        }

        /// <summary>
        /// The copy to.
        /// </summary>
        /// <param name="array">
        /// The array. 
        /// </param>
        /// <param name="index">
        /// The index. 
        /// </param>
        void ICollection.CopyTo(Array array, int index)
        {
            this._kvp.CopyTo((KeyValuePair<TKey, TItem>[])array, index);
        }

        /// <summary>
        /// The get enumerator.
        /// </summary>
        /// <returns>
        /// The System.Collections.IDictionaryEnumerator. 
        /// </returns>
        IDictionaryEnumerator IDictionary.GetEnumerator()
        {
            return new Enumerator(this);
        }

        /// <summary>
        /// The remove.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        void IDictionary.Remove(object key)
        {
            this.Remove((TKey)key);
        }

        /// <summary>
        /// The add.
        /// </summary>
        /// <param name="item">
        /// The item. 
        /// </param>
        /// <exception cref="ArgumentException">
        /// </exception>
        void ICollection<KeyValuePair<TKey, TItem>>.Add(KeyValuePair<TKey, TItem> item)
        {
            if (this.ContainsKey(item.Key))
            {
                throw new ArgumentException();
            }

            this.Add(item.Key, item.Value);
        }

        /// <summary>
        /// The add.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <param name="value">
        /// The value. 
        /// </param>
        void IDictionary<TKey, TItem>.Add(TKey key, TItem value)
        {
            this.Add(key, value);
        }

        /// <summary>
        /// The clear.
        /// </summary>
        void ICollection<KeyValuePair<TKey, TItem>>.Clear()
        {
            this.Clear();
        }

        /// <summary>
        /// The contains.
        /// </summary>
        /// <param name="item">
        /// The item. 
        /// </param>
        /// <returns>
        /// The System.Boolean. 
        /// </returns>
        bool ICollection<KeyValuePair<TKey, TItem>>.Contains(KeyValuePair<TKey, TItem> item)
        {
            foreach (var kvp in this._kvp)
            {
                if (kvp.Key.Equals(item.Key) && kvp.Value.Equals(item.Value))
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>
        /// The contains key.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <returns>
        /// The System.Boolean. 
        /// </returns>
        bool IDictionary<TKey, TItem>.ContainsKey(TKey key)
        {
            return this.ContainsKey(key);
        }

        /// <summary>
        /// The copy to.
        /// </summary>
        /// <param name="array">
        /// The array. 
        /// </param>
        /// <param name="arrayIndex">
        /// The array index. 
        /// </param>
        void ICollection<KeyValuePair<TKey, TItem>>.CopyTo(KeyValuePair<TKey, TItem>[] array, int arrayIndex)
        {
            this._kvp.CopyTo(array, arrayIndex);
        }

        /// <summary>
        /// The get enumerator.
        /// </summary>
        /// <returns>
        /// The System.Collections.Generic.IEnumerator`1[T - &gt; System.Collections.Generic.KeyValuePair`2[TKey - &gt; TKey, TValue - &gt; TItem]]. 
        /// </returns>
        IEnumerator<KeyValuePair<TKey, TItem>> IEnumerable<KeyValuePair<TKey, TItem>>.GetEnumerator()
        {
            return new Enumerator(this);
        }

        /// <summary>
        /// The get enumerator.
        /// </summary>
        /// <returns>
        /// The System.Collections.IEnumerator. 
        /// </returns>
        IEnumerator IEnumerable.GetEnumerator()
        {
            return new Enumerator(this);
        }

        /// <summary>
        /// The remove.
        /// </summary>
        /// <param name="item">
        /// The item. 
        /// </param>
        /// <returns>
        /// The System.Boolean. 
        /// </returns>
        bool ICollection<KeyValuePair<TKey, TItem>>.Remove(KeyValuePair<TKey, TItem> item)
        {
            return this.Remove(item.Key);
        }

        /// <summary>
        /// The remove.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <returns>
        /// The System.Boolean. 
        /// </returns>
        bool IDictionary<TKey, TItem>.Remove(TKey key)
        {
            return this.Remove(key);
        }

        /// <summary>
        /// The try get value.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <param name="value">
        /// The value. 
        /// </param>
        /// <returns>
        /// The System.Boolean. 
        /// </returns>
        bool IDictionary<TKey, TItem>.TryGetValue(TKey key, out TItem value)
        {
            return this.TryGetValue(key, out value);
        }

        /// <summary>
        /// The find kvp.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <param name="kvp">
        /// The kvp. 
        /// </param>
        /// <returns>
        /// The System.Boolean. 
        /// </returns>
        private bool FindKVP(TKey key, out KeyValuePair<TKey, TItem> kvp)
        {
            if (this._hash.TryGetValue(key, out kvp))
            {
                return true;
            }

            kvp = default(KeyValuePair<TKey, TItem>);
            return false;
        }

        /// <summary>
        /// The find key.
        /// </summary>
        /// <param name="key">
        /// The key. 
        /// </param>
        /// <returns>
        /// The System.Int32. 
        /// </returns>
        private int FindKey(TKey key)
        {
            for (int idx = 0; idx < this._kvp.Count; ++idx)
            {
                if (this._TKeyComparer.Equals(this._kvp[idx].Key, key))
                {
                    return idx;
                }
            }

            return ~this._kvp.Count;
        }

        /// <summary>
        /// The enumerator.
        /// </summary>
        public struct Enumerator : IDictionaryEnumerator, IEnumerator<KeyValuePair<TKey, TItem>>, IEnumerator, IDisposable
        {
            /// <summary>
            /// The list.
            /// </summary>
            private readonly OrderedDictionary<TKey, TItem> list;

            /// <summary>
            /// The current.
            /// </summary>
            private KeyValuePair<TKey, TItem> current;

            /// <summary>
            /// The index.
            /// </summary>
            private int index;

            /// <summary>
            /// Initializes a new instance of the <see cref="Enumerator"/> struct.
            /// </summary>
            /// <param name="list">
            /// The list. 
            /// </param>
            internal Enumerator(OrderedDictionary<TKey, TItem> list)
            {
                this.list = list;
                this.index = 0;
                this.current = default(KeyValuePair<TKey, TItem>);
            }

            /// <summary>
            /// Gets the current.
            /// </summary>
            /// <value>
            /// The current. 
            /// </value>
            public KeyValuePair<TKey, TItem> Current
            {
                get
                {
                    return this.current;
                }
            }

            /// <summary>
            /// Gets the current.
            /// </summary>
            /// <value>
            /// The current. 
            /// </value>
            object IEnumerator.Current
            {
                get
                {
                    return this.Current;
                }
            }

            /// <summary>
            /// Gets the entry.
            /// </summary>
            /// <value>
            /// The entry. 
            /// </value>
            DictionaryEntry IDictionaryEnumerator.Entry
            {
                get
                {
                    return new DictionaryEntry(this.current.Key, this.current.Value);
                }
            }

            /// <summary>
            /// Gets the key.
            /// </summary>
            /// <value>
            /// The key. 
            /// </value>
            object IDictionaryEnumerator.Key
            {
                get
                {
                    return this.current.Key;
                }
            }

            /// <summary>
            /// Gets the value.
            /// </summary>
            /// <value>
            /// The value. 
            /// </value>
            object IDictionaryEnumerator.Value
            {
                get
                {
                    return this.current.Value;
                }
            }

            /// <summary>
            /// The move next.
            /// </summary>
            /// <returns>
            /// The System.Boolean. 
            /// </returns>
            public bool MoveNext()
            {
                if (this.index < this.list.Count)
                {
                    this.current = this.list._kvp[this.index];
                    this.index++;
                    return true;
                }

                this.index = this.list._kvp.Count + 1;
                this.current = default(KeyValuePair<TKey, TItem>);
                return false;
            }

            /// <summary>
            /// The move next.
            /// </summary>
            /// <returns>
            /// The System.Boolean. 
            /// </returns>
            bool IEnumerator.MoveNext()
            {
                return this.MoveNext();
            }

            /// <summary>
            /// The reset.
            /// </summary>
            void IEnumerator.Reset()
            {
                this.index = 0;
                this.current = default(KeyValuePair<TKey, TItem>);
            }

            /// <summary>
            /// The dispose.
            /// </summary>
            void IDisposable.Dispose()
            {
            }
        }

        /// <summary>
        /// The ordered key collection.
        /// </summary>
        private class OrderedKeyCollection : ICollection<TKey>, ICollection
        {
            /// <summary>
            /// The _list.
            /// </summary>
            private readonly OrderedDictionary<TKey, TItem> _list;

            /// <summary>
            /// Initializes a new instance of the <see cref="OrderedKeyCollection"/> class.
            /// </summary>
            /// <param name="list">
            /// The list. 
            /// </param>
            internal OrderedKeyCollection(OrderedDictionary<TKey, TItem> list)
            {
                this._list = list;
            }

            /// <summary>
            /// Gets the count.
            /// </summary>
            /// <value>
            /// The count. 
            /// </value>
            public int Count
            {
                get
                {
                    return this._list.Count;
                }
            }

            /// <summary>
            /// Gets a value indicating whether is read only.
            /// </summary>
            /// <value>
            /// The is read only. 
            /// </value>
            public bool IsReadOnly
            {
                get
                {
                    return true;
                }
            }

            /// <summary>
            /// Gets the count.
            /// </summary>
            /// <value>
            /// The count. 
            /// </value>
            int ICollection.Count
            {
                get
                {
                    return this.Count;
                }
            }

            /// <summary>
            /// Gets a value indicating whether is synchronized.
            /// </summary>
            /// <value>
            /// The is synchronized. 
            /// </value>
            bool ICollection.IsSynchronized
            {
                get
                {
                    return false;
                }
            }

            /// <summary>
            /// Gets the sync root.
            /// </summary>
            /// <value>
            /// The sync root. 
            /// </value>
            object ICollection.SyncRoot
            {
                get
                {
                    return null;
                }
            }

            /// <summary>
            /// The add.
            /// </summary>
            /// <param name="item">
            /// The item. 
            /// </param>
            /// <exception cref="Exception">
            /// </exception>
            public void Add(TKey item)
            {
                throw new Exception("Class is readonly.");
            }

            /// <summary>
            /// The clear.
            /// </summary>
            /// <exception cref="Exception">
            /// </exception>
            public void Clear()
            {
                throw new Exception("Class is readonly.");
            }

            /// <summary>
            /// The contains.
            /// </summary>
            /// <param name="item">
            /// The item. 
            /// </param>
            /// <returns>
            /// The System.Boolean. 
            /// </returns>
            public bool Contains(TKey item)
            {
                return this._list.ContainsKey(item);
            }

            /// <summary>
            /// The copy to.
            /// </summary>
            /// <param name="array">
            /// The array. 
            /// </param>
            /// <param name="arrayIndex">
            /// The array index. 
            /// </param>
            /// <exception cref="Exception">
            /// </exception>
            public void CopyTo(TKey[] array, int arrayIndex)
            {
                throw new Exception("Class is readonly.");
            }

            /// <summary>
            /// The get enumerator.
            /// </summary>
            /// <returns>
            /// The System.Collections.Generic.IEnumerator`1[T - &gt; TKey]. 
            /// </returns>
            public IEnumerator<TKey> GetEnumerator()
            {
                return new Enumerator(this._list);
            }

            /// <summary>
            /// The remove.
            /// </summary>
            /// <param name="item">
            /// The item. 
            /// </param>
            /// <returns>
            /// The System.Boolean. 
            /// </returns>
            /// <exception cref="Exception">
            /// </exception>
            public bool Remove(TKey item)
            {
                throw new Exception("Class is readonly.");
            }

            /// <summary>
            /// The copy to.
            /// </summary>
            /// <param name="array">
            /// The array. 
            /// </param>
            /// <param name="index">
            /// The index. 
            /// </param>
            void ICollection.CopyTo(Array array, int index)
            {
                this.CopyTo((TKey[])array, index);
            }

            /// <summary>
            /// The get enumerator.
            /// </summary>
            /// <returns>
            /// The System.Collections.IEnumerator. 
            /// </returns>
            IEnumerator IEnumerable.GetEnumerator()
            {
                return new Enumerator(this._list);
            }

            /// <summary>
            /// The enumerator.
            /// </summary>
            public struct Enumerator : IEnumerator<TKey>, IEnumerator, IDisposable
            {
                /// <summary>
                /// The list.
                /// </summary>
                private readonly OrderedDictionary<TKey, TItem> list;

                /// <summary>
                /// The current.
                /// </summary>
                private TKey current;

                /// <summary>
                /// The index.
                /// </summary>
                private int index;

                /// <summary>
                /// Initializes a new instance of the <see cref="Enumerator"/> struct.
                /// </summary>
                /// <param name="list">
                /// The list. 
                /// </param>
                internal Enumerator(OrderedDictionary<TKey, TItem> list)
                {
                    this.list = list;
                    this.index = 0;
                    this.current = default(TKey);
                }

                /// <summary>
                /// Gets the current.
                /// </summary>
                /// <value>
                /// The current. 
                /// </value>
                public TKey Current
                {
                    get
                    {
                        return this.current;
                    }
                }

                /// <summary>
                /// Gets the current.
                /// </summary>
                /// <value>
                /// The current. 
                /// </value>
                object IEnumerator.Current
                {
                    get
                    {
                        return this.Current;
                    }
                }

                /// <summary>
                /// The move next.
                /// </summary>
                /// <returns>
                /// The System.Boolean. 
                /// </returns>
                public bool MoveNext()
                {
                    if (this.index < this.list.Count)
                    {
                        this.current = this.list._kvp[this.index].Key;
                        this.index++;
                        return true;
                    }

                    this.index = this.list._kvp.Count + 1;
                    this.current = default(TKey);
                    return false;
                }

                /// <summary>
                /// The dispose.
                /// </summary>
                void IDisposable.Dispose()
                {
                }

                /// <summary>
                /// The reset.
                /// </summary>
                void IEnumerator.Reset()
                {
                    this.index = 0;
                    this.current = default(TKey);
                }
            }
        }

        /// <summary>
        /// The ordered value collection.
        /// </summary>
        private class OrderedValueCollection : ICollection<TItem>, ICollection
        {
            /// <summary>
            /// The _list.
            /// </summary>
            private readonly OrderedDictionary<TKey, TItem> _list;

            /// <summary>
            /// Initializes a new instance of the <see cref="OrderedValueCollection"/> class.
            /// </summary>
            /// <param name="list">
            /// The list. 
            /// </param>
            internal OrderedValueCollection(OrderedDictionary<TKey, TItem> list)
            {
                this._list = list;
            }

            /// <summary>
            /// Gets the count.
            /// </summary>
            /// <value>
            /// The count. 
            /// </value>
            public int Count
            {
                get
                {
                    return this._list.Count;
                }
            }

            /// <summary>
            /// Gets a value indicating whether is read only.
            /// </summary>
            /// <value>
            /// The is read only. 
            /// </value>
            public bool IsReadOnly
            {
                get
                {
                    return true;
                }
            }

            /// <summary>
            /// Gets the count.
            /// </summary>
            /// <value>
            /// The count. 
            /// </value>
            int ICollection.Count
            {
                get
                {
                    return this.Count;
                }
            }

            /// <summary>
            /// Gets a value indicating whether is synchronized.
            /// </summary>
            /// <value>
            /// The is synchronized. 
            /// </value>
            bool ICollection.IsSynchronized
            {
                get
                {
                    return false;
                }
            }

            /// <summary>
            /// Gets the sync root.
            /// </summary>
            /// <value>
            /// The sync root. 
            /// </value>
            object ICollection.SyncRoot
            {
                get
                {
                    return null;
                }
            }

            /// <summary>
            /// The add.
            /// </summary>
            /// <param name="item">
            /// The item. 
            /// </param>
            /// <exception cref="Exception">
            /// </exception>
            public void Add(TItem item)
            {
                throw new Exception("Class is readonly.");
            }

            /// <summary>
            /// The clear.
            /// </summary>
            /// <exception cref="Exception">
            /// </exception>
            public void Clear()
            {
                throw new Exception("Class is readonly.");
            }

            /// <summary>
            /// The contains.
            /// </summary>
            /// <param name="item">
            /// The item. 
            /// </param>
            /// <returns>
            /// The System.Boolean. 
            /// </returns>
            public bool Contains(TItem item)
            {
                return this._list.ContainsValue(item);
            }

            /// <summary>
            /// The copy to.
            /// </summary>
            /// <param name="array">
            /// The array. 
            /// </param>
            /// <param name="arrayIndex">
            /// The array index. 
            /// </param>
            /// <exception cref="Exception">
            /// </exception>
            public void CopyTo(TItem[] array, int arrayIndex)
            {
                throw new Exception("Class is readonly.");
            }

            /// <summary>
            /// The get enumerator.
            /// </summary>
            /// <returns>
            /// The System.Collections.Generic.IEnumerator`1[T - &gt; TItem]. 
            /// </returns>
            public IEnumerator<TItem> GetEnumerator()
            {
                return new Enumerator(this._list);
            }

            /// <summary>
            /// The remove.
            /// </summary>
            /// <param name="item">
            /// The item. 
            /// </param>
            /// <returns>
            /// The System.Boolean. 
            /// </returns>
            /// <exception cref="Exception">
            /// </exception>
            public bool Remove(TItem item)
            {
                throw new Exception("Class is readonly.");
            }

            /// <summary>
            /// The copy to.
            /// </summary>
            /// <param name="array">
            /// The array. 
            /// </param>
            /// <param name="index">
            /// The index. 
            /// </param>
            void ICollection.CopyTo(Array array, int index)
            {
                this.CopyTo((TItem[])array, index);
            }

            /// <summary>
            /// The get enumerator.
            /// </summary>
            /// <returns>
            /// The System.Collections.IEnumerator. 
            /// </returns>
            IEnumerator IEnumerable.GetEnumerator()
            {
                return new Enumerator(this._list);
            }

            /// <summary>
            /// The enumerator.
            /// </summary>
            public struct Enumerator : IEnumerator<TItem>, IEnumerator, IDisposable
            {
                /// <summary>
                /// The list.
                /// </summary>
                private readonly OrderedDictionary<TKey, TItem> list;

                /// <summary>
                /// The current.
                /// </summary>
                private TItem current;

                /// <summary>
                /// The index.
                /// </summary>
                private int index;

                /// <summary>
                /// Initializes a new instance of the <see cref="Enumerator"/> struct.
                /// </summary>
                /// <param name="list">
                /// The list. 
                /// </param>
                internal Enumerator(OrderedDictionary<TKey, TItem> list)
                {
                    this.list = list;
                    this.index = 0;
                    this.current = default(TItem);
                }

                /// <summary>
                /// Gets the current.
                /// </summary>
                /// <value>
                /// The current. 
                /// </value>
                public TItem Current
                {
                    get
                    {
                        return this.current;
                    }
                }

                /// <summary>
                /// Gets the current.
                /// </summary>
                /// <value>
                /// The current. 
                /// </value>
                object IEnumerator.Current
                {
                    get
                    {
                        return this.Current;
                    }
                }

                /// <summary>
                /// The move next.
                /// </summary>
                /// <returns>
                /// The System.Boolean. 
                /// </returns>
                public bool MoveNext()
                {
                    if (this.index < this.list.Count)
                    {
                        this.current = this.list._kvp[this.index].Value;
                        this.index++;
                        return true;
                    }

                    this.index = this.list._kvp.Count + 1;
                    this.current = default(TItem);
                    return false;
                }

                /// <summary>
                /// The dispose.
                /// </summary>
                void IDisposable.Dispose()
                {
                }

                /// <summary>
                /// The reset.
                /// </summary>
                void IEnumerator.Reset()
                {
                    this.index = 0;
                    this.current = default(TItem);
                }
            }
        }
    }
}
