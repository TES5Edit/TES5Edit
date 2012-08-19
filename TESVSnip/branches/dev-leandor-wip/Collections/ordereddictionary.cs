namespace TESVSnip.Collections.Generic
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
            _kvp = new List<KeyValuePair<TKey, TItem>>();
            _TKeyComparer = EqualityComparer<TKey>.Default;
            _hash = new Dictionary<TKey, KeyValuePair<TKey, TItem>>(_TKeyComparer);
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="OrderedDictionary{TKey,TItem}"/> class.
        /// </summary>
        /// <param name="KeyComparer">
        /// The key comparer.
        /// </param>
        public OrderedDictionary(IEqualityComparer<TKey> KeyComparer)
        {
            _kvp = new List<KeyValuePair<TKey, TItem>>();
            _TKeyComparer = KeyComparer;
            _hash = new Dictionary<TKey, KeyValuePair<TKey, TItem>>(_TKeyComparer);
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="OrderedDictionary{TKey,TItem}"/> class.
        /// </summary>
        /// <param name="other">
        /// The other.
        /// </param>
        public OrderedDictionary(OrderedDictionary<TKey, TItem> other)
        {
            _kvp = new List<KeyValuePair<TKey, TItem>>(other._kvp);
            _TKeyComparer = other._TKeyComparer;
            _hash = new Dictionary<TKey, KeyValuePair<TKey, TItem>>(_TKeyComparer);
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
                return _kvp.Count;
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
                return Count;
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
                return (ICollection)Keys;
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
                return (ICollection)Values;
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
                return _kvp.Count;
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
                return Keys;
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
                return Values;
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
                if (FindKVP(key, out kvp)) {
                    return kvp.Value;
                }

                throw new KeyNotFoundException(key.ToString());
            }

            set
            {
                Add(key, value);
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
            if (FindKVP(key, out kvp)) {
                if (kvp.Value == null || !kvp.Value.Equals(value)) {
                    kvp = new KeyValuePair<TKey, TItem>(key, value);
                    _hash[key] = kvp;
                    int idx = FindKey(key);
                    if (idx >= 0) {
                        _kvp[idx] = kvp;
                    }
                    else {
                        _kvp.Add(new KeyValuePair<TKey, TItem>(key, value)); // ???? error condition
                    }
                }
            }
            else {
                kvp = new KeyValuePair<TKey, TItem>(key, value);
                _hash[key] = kvp;
                _kvp.Add(new KeyValuePair<TKey, TItem>(key, value));
            }
        }

        /// <summary>
        /// The clear.
        /// </summary>
        public void Clear()
        {
            _kvp.Clear();
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
            if (key == null) {
                throw new ArgumentNullException("key");
            }

            KeyValuePair<TKey, TItem> kvp;
            if (_hash.TryGetValue(key, out kvp)) {
                return true;
            }

            return FindKey(key) >= 0;
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
            if (value == null) {
                throw new ArgumentNullException("key");
            }

            return FindValue(value) >= 0;
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
            return FindKey(match);
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
            for (int idx = 0; idx < _kvp.Count; ++idx) {
                if (_kvp[idx].Value.Equals(value)) {
                    return idx;
                }
            }

            return ~_kvp.Count;
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
            return _kvp[index].Key;
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
            if (!FindKVP(key, out kvp)) {
                kvp = new KeyValuePair<TKey, TItem>(key, value);
                _kvp.Insert(index, kvp);
                _hash[key] = kvp;
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
            if (key == null) {
                throw new ArgumentNullException("key");
            }

            _hash.Remove(key);

            int idx = FindKey(key);
            if (idx >= 0) {
                _kvp.RemoveAt(idx);
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
            if (key == null) {
                throw new ArgumentNullException("key");
            }

            KeyValuePair<TKey, TItem> kvp;
            if (FindKVP(key, out kvp)) {
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
            Add((TKey)key, (TItem)value);
        }

        /// <summary>
        /// The clear.
        /// </summary>
        void IDictionary.Clear()
        {
            Clear();
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
            return ContainsKey((TKey)key);
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
            _kvp.CopyTo((KeyValuePair<TKey, TItem>[])array, index);
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
            Remove((TKey)key);
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
            if (ContainsKey(item.Key)) {
                throw new ArgumentException();
            }

            Add(item.Key, item.Value);
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
            Add(key, value);
        }

        /// <summary>
        /// The clear.
        /// </summary>
        void ICollection<KeyValuePair<TKey, TItem>>.Clear()
        {
            Clear();
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
            foreach (var kvp in _kvp) {
                if (kvp.Key.Equals(item.Key) && kvp.Value.Equals(item.Value)) {
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
            return ContainsKey(key);
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
            _kvp.CopyTo(array, arrayIndex);
        }

        /// <summary>
        /// The get enumerator.
        /// </summary>
        /// <returns>
        /// The System.Collections.Generic.IEnumerator`1[T -&gt; System.Collections.Generic.KeyValuePair`2[TKey -&gt; TKey, TValue -&gt; TItem]].
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
            return Remove(item.Key);
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
            return Remove(key);
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
            return TryGetValue(key, out value);
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
            if (_hash.TryGetValue(key, out kvp)) {
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
            for (int idx = 0; idx < _kvp.Count; ++idx) {
                if (_TKeyComparer.Equals(_kvp[idx].Key, key)) {
                    return idx;
                }
            }

            return ~_kvp.Count;
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
                index = 0;
                current = default(KeyValuePair<TKey, TItem>);
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
                    return current;
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
                    return Current;
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
                    return new DictionaryEntry(current.Key, current.Value);
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
                    return current.Key;
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
                    return current.Value;
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
                if (index < list.Count) {
                    current = list._kvp[index];
                    index++;
                    return true;
                }

                index = list._kvp.Count + 1;
                current = default(KeyValuePair<TKey, TItem>);
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
                return MoveNext();
            }

            /// <summary>
            /// The reset.
            /// </summary>
            void IEnumerator.Reset()
            {
                index = 0;
                current = default(KeyValuePair<TKey, TItem>);
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
                _list = list;
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
                    return _list.Count;
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
                return _list.ContainsKey(item);
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
            /// The System.Collections.Generic.IEnumerator`1[T -&gt; TKey].
            /// </returns>
            public IEnumerator<TKey> GetEnumerator()
            {
                return new Enumerator(_list);
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
                return new Enumerator(_list);
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
                    index = 0;
                    current = default(TKey);
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
                        return current;
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
                        return Current;
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
                    if (index < list.Count) {
                        current = list._kvp[index].Key;
                        index++;
                        return true;
                    }

                    index = list._kvp.Count + 1;
                    current = default(TKey);
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
                    index = 0;
                    current = default(TKey);
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
                _list = list;
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
                    return _list.Count;
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
                return _list.ContainsValue(item);
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
            /// The System.Collections.Generic.IEnumerator`1[T -&gt; TItem].
            /// </returns>
            public IEnumerator<TItem> GetEnumerator()
            {
                return new Enumerator(_list);
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
                return new Enumerator(_list);
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
                    index = 0;
                    current = default(TItem);
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
                        return current;
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
                        return Current;
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
                    if (index < list.Count) {
                        current = list._kvp[index].Value;
                        index++;
                        return true;
                    }

                    index = list._kvp.Count + 1;
                    current = default(TItem);
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
                    index = 0;
                    current = default(TItem);
                }
            }
        }
    }
}
