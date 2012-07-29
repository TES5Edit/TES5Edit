using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;

namespace TESVSnip.Collections.Generic
{
    // Summary:
    //     Represents a strongly typed list of objects that can be accessed by index.
    //     Provides methods to search, sort, and manipulate lists.
    [DebuggerDisplay("Count = {Count}")]
    public class OrderedDictionary<TKey, TItem> : IDictionary<TKey, TItem>, IDictionary,
                                                  ICollection<KeyValuePair<TKey, TItem>>,
                                                  IEnumerable<KeyValuePair<TKey, TItem>>
    {
        private readonly List<KeyValuePair<TKey, TItem>> _kvp;
        private readonly Dictionary<TKey, KeyValuePair<TKey, TItem>> _hash;

        #region TKey Helper Routines

        private int FindKey(TKey key)
        {
            for (int idx = 0; idx < _kvp.Count; ++idx)
            {
                if (_TKeyComparer.Equals(_kvp[idx].Key, key))
                    return idx;
            }
            return ~(_kvp.Count);
        }

        public int FindValue(TItem value)
        {
            for (int idx = 0; idx < _kvp.Count; ++idx)
            {
                if (_kvp[idx].Value.Equals(value))
                    return idx;
            }
            return ~(_kvp.Count);
        }

        private bool FindKVP(TKey key, out KeyValuePair<TKey, TItem> kvp)
        {
            if (_hash.TryGetValue(key, out kvp))
                return true;
            kvp = default(KeyValuePair<TKey, TItem>);
            return false;
        }

        #endregion

        private readonly IEqualityComparer<TKey> _TKeyComparer;

        // Summary:
        //     Initializes a new instance of the System.Collections.Generic.List<T> class
        //     that is empty and has the default initial capacity.
        public OrderedDictionary()
        {
            _kvp = new List<KeyValuePair<TKey, TItem>>();
            _TKeyComparer = EqualityComparer<TKey>.Default;
            _hash = new Dictionary<TKey, KeyValuePair<TKey, TItem>>(_TKeyComparer);
        }

        public OrderedDictionary(IEqualityComparer<TKey> KeyComparer)
        {
            _kvp = new List<KeyValuePair<TKey, TItem>>();
            _TKeyComparer = KeyComparer;
            _hash = new Dictionary<TKey, KeyValuePair<TKey, TItem>>(_TKeyComparer);
        }

        public OrderedDictionary(OrderedDictionary<TKey, TItem> other)
        {
            _kvp = new List<KeyValuePair<TKey, TItem>>(other._kvp);
            _TKeyComparer = other._TKeyComparer;
            _hash = new Dictionary<TKey, KeyValuePair<TKey, TItem>>(_TKeyComparer);
        }

        //
        // Summary:
        //     Determines whether the TESsnip.Collections.Generic.KeyList<TKey,T>
        //     contains the specified key.
        //
        // Parameters:
        //   key:
        //     The key to locate in the TESsnip.Collections.Generic.KeyList<TKey,T>.
        //
        // Returns:
        //     true if the TESsnip.Collections.Generic.KeyList<TKey,T> contains an
        //     element with the specified key; otherwise, false.
        //
        // Exceptions:
        //   System.ArgumentNullException:
        //     key is null.
        public bool ContainsKey(TKey key)
        {
            if (key == null) throw new ArgumentNullException("key");

            KeyValuePair<TKey, TItem> kvp;
            if (_hash.TryGetValue(key, out kvp))
                return true;
            return FindKey(key) >= 0;
        }

        public bool ContainsValue(TItem value)
        {
            if (value == null) throw new ArgumentNullException("key");
            return FindValue(value) >= 0;
        }

        //
        // Summary:
        //     Removes the value with the specified key from the TESsnip.Collections.Generic.KeyList<TKey,T>.
        //
        // Parameters:
        //   key:
        //     The key of the element to remove.
        //
        // Returns:
        //     true if the element is successfully found and removed; otherwise, false.
        //      This method returns false if key is not found in the TESsnip.Collections.Generic.KeyList<TKey,T>.
        //
        // Exceptions:
        //   System.ArgumentNullException:
        //     key is null.
        public bool Remove(TKey key)
        {
            if (key == null) throw new ArgumentNullException("key");

            _hash.Remove(key);

            int idx = FindKey(key);
            if (idx >= 0)
            {
                _kvp.RemoveAt(idx);
                return true;
            }
            return false;
        }

        // Summary:
        //     Gets or sets the value associated with the specified key.
        //
        // Parameters:
        //   key:
        //     The key of the value to get or set.
        //
        // Returns:
        //     The value associated with the specified key. If the specified key is not
        //     found, a get operation throws a System.Collections.Generic.KeyNotFoundException,
        //     and a set operation creates a new element with the specified key.
        //
        // Exceptions:
        //   System.ArgumentNullException:
        //     key is null.
        //
        //   System.Collections.Generic.KeyNotFoundException:
        //     The property is retrieved and key does not exist in the collection.
        public TItem this[TKey key]
        {
            get
            {
                KeyValuePair<TKey, TItem> kvp;
                if (FindKVP(key, out kvp)) return kvp.Value;
                throw new KeyNotFoundException(key.ToString());
            }
            set { Add(key, value); }
        }

        //public TItem this[int index]
        //{
        //    get
        //    {
        //        return _kvp[index].Value;
        //    }
        //    set
        //    {
        //        KeyValuePair<TKey, TItem> item = _kvp[index];
        //        if ( item.Value == null || !item.Value.Equals(value) )
        //            _kvp[index] = new KeyValuePair<TKey, TItem>(item.Key, value);
        //    }
        //}

        //
        // Summary:
        //     Searches for an element that matches the conditions defined by the specified
        //     predicate, and returns the zero-based index of the first occurrence within
        //     the entire System.Collections.Generic.List<T>.
        //
        // Parameters:
        //   match:
        //     The System.Predicate<T> delegate that defines the conditions of the element
        //     to search for.
        //
        // Returns:
        //     The zero-based index of the first occurrence of an element that matches the
        //     conditions defined by match, if found; otherwise, –1.
        //
        // Exceptions:
        //   System.ArgumentNullException:
        //     match is null.
        public int FindIndex(TKey match)
        {
            return FindKey(match);
        }

        public TKey GetKey(int index)
        {
            return _kvp[index].Key;
        }

        public bool TryGetValue(TKey key, out TItem value)
        {
            if (key == null) throw new ArgumentNullException("key");
            KeyValuePair<TKey, TItem> kvp;
            if (FindKVP(key, out kvp))
            {
                value = kvp.Value;
                return true;
            }
            value = default(TItem);
            return false;
        }

        public int Count
        {
            get { return _kvp.Count; }
        }

        public void Clear()
        {
            _kvp.Clear();
        }


        public void Insert(int index, TKey key, TItem value)
        {
            KeyValuePair<TKey, TItem> kvp;
            if (!FindKVP(key, out kvp))
            {
                kvp = new KeyValuePair<TKey, TItem>(key, value);
                _kvp.Insert(index, kvp);
                _hash[key] = kvp;
                return;
            }
            throw new KeyNotFoundException();
        }

        #region IDictionary<TKey,T> Members

        public void Add(TKey key, TItem value)
        {
            KeyValuePair<TKey, TItem> kvp;
            if (FindKVP(key, out kvp))
            {
                if (kvp.Value == null || !kvp.Value.Equals(value))
                {
                    kvp = new KeyValuePair<TKey, TItem>(key, value);
                    _hash[key] = kvp;
                    int idx = FindKey(key);
                    if (idx >= 0)
                        _kvp[idx] = kvp;
                    else
                        _kvp.Add(new KeyValuePair<TKey, TItem>(key, value)); // ???? error condition
                }
            }
            else
            {
                kvp = new KeyValuePair<TKey, TItem>(key, value);
                _hash[key] = kvp;
                _kvp.Add(new KeyValuePair<TKey, TItem>(key, value));
            }
        }

        public ICollection<TKey> Keys
        {
            get { return new OrderedKeyCollection(this); }
        }

        public ICollection<TItem> Values
        {
            get { return new OrderedValueCollection(this); }
        }

        #endregion

        #region ICollection<KeyValuePair<TKey,T>> Members

        void ICollection<KeyValuePair<TKey, TItem>>.Add(KeyValuePair<TKey, TItem> item)
        {
            if (ContainsKey(item.Key))
                throw new ArgumentException();
            Add(item.Key, item.Value);
        }

        void ICollection<KeyValuePair<TKey, TItem>>.Clear()
        {
            Clear();
        }

        bool ICollection<KeyValuePair<TKey, TItem>>.Contains(KeyValuePair<TKey, TItem> item)
        {
            foreach (KeyValuePair<TKey, TItem> kvp in _kvp)
            {
                if (kvp.Key.Equals(item.Key) && kvp.Value.Equals(item.Value))
                    return true;
            }
            return false;
        }

        void ICollection<KeyValuePair<TKey, TItem>>.CopyTo(KeyValuePair<TKey, TItem>[] array, int arrayIndex)
        {
            _kvp.CopyTo(array, arrayIndex);
        }

        int ICollection<KeyValuePair<TKey, TItem>>.Count
        {
            get { return _kvp.Count; }
        }

        bool ICollection<KeyValuePair<TKey, TItem>>.IsReadOnly
        {
            get { return false; }
        }

        bool ICollection<KeyValuePair<TKey, TItem>>.Remove(KeyValuePair<TKey, TItem> item)
        {
            return Remove(item.Key);
        }

        #endregion

        #region IEnumerable<KeyValuePair<TKey,T>> Members

        IEnumerator<KeyValuePair<TKey, TItem>> IEnumerable<KeyValuePair<TKey, TItem>>.GetEnumerator()
        {
            return new Enumerator(this);
        }

        #endregion

        #region IEnumerable Members

        IEnumerator IEnumerable.GetEnumerator()
        {
            return new Enumerator(this);
        }

        #endregion

        public Enumerator GetEnumerator()
        {
            return new Enumerator(this);
        }

        // Nested Types
        public struct Enumerator : IDictionaryEnumerator, IEnumerator<KeyValuePair<TKey, TItem>>, IEnumerator,
                                   IDisposable
        {
            private readonly OrderedDictionary<TKey, TItem> list;
            private int index;
            private KeyValuePair<TKey, TItem> current;

            internal Enumerator(OrderedDictionary<TKey, TItem> list)
            {
                this.list = list;
                index = 0;
                current = default(KeyValuePair<TKey, TItem>);
            }

            public bool MoveNext()
            {
                if (index < list.Count)
                {
                    current = list._kvp[index];
                    index++;
                    return true;
                }
                index = list._kvp.Count + 1;
                current = default(KeyValuePair<TKey, TItem>);
                return false;
            }

            public KeyValuePair<TKey, TItem> Current
            {
                get { return current; }
            }

            object IEnumerator.Current
            {
                get { return Current; }
            }

            void IEnumerator.Reset()
            {
                index = 0;
                current = default(KeyValuePair<TKey, TItem>);
            }

            #region IDisposable Members

            void IDisposable.Dispose()
            {
            }

            #endregion

            #region IDictionaryEnumerator Members

            DictionaryEntry IDictionaryEnumerator.Entry
            {
                get { return new DictionaryEntry(current.Key, current.Value); }
            }

            object IDictionaryEnumerator.Key
            {
                get { return current.Key; }
            }

            object IDictionaryEnumerator.Value
            {
                get { return current.Value; }
            }

            #endregion

            #region IEnumerator Members

            bool IEnumerator.MoveNext()
            {
                return MoveNext();
            }

            #endregion
        }

        #region IDictionary<TKey,TItem> Members

        void IDictionary<TKey, TItem>.Add(TKey key, TItem value)
        {
            Add(key, value);
        }

        bool IDictionary<TKey, TItem>.ContainsKey(TKey key)
        {
            return ContainsKey(key);
        }

        ICollection<TKey> IDictionary<TKey, TItem>.Keys
        {
            get { return Keys; }
        }

        bool IDictionary<TKey, TItem>.Remove(TKey key)
        {
            return Remove(key);
        }

        bool IDictionary<TKey, TItem>.TryGetValue(TKey key, out TItem value)
        {
            return TryGetValue(key, out value);
        }

        ICollection<TItem> IDictionary<TKey, TItem>.Values
        {
            get { return Values; }
        }

        TItem IDictionary<TKey, TItem>.this[TKey key]
        {
            get { return this[key]; }
            set { this[key] = value; }
        }

        #endregion

        #region class OrderedKeyCollection

        private class OrderedKeyCollection : ICollection<TKey>, ICollection
        {
            private readonly OrderedDictionary<TKey, TItem> _list;

            internal OrderedKeyCollection(OrderedDictionary<TKey, TItem> list)
            {
                _list = list;
            }

            #region ICollection<TKey> Members

            public void Add(TKey item)
            {
                throw new Exception("Class is readonly.");
            }

            public void Clear()
            {
                throw new Exception("Class is readonly.");
            }

            public bool Contains(TKey item)
            {
                return _list.ContainsKey(item);
            }

            public void CopyTo(TKey[] array, int arrayIndex)
            {
                throw new Exception("Class is readonly.");
            }

            public int Count
            {
                get { return _list.Count; }
            }

            public bool IsReadOnly
            {
                get { return true; }
            }

            public bool Remove(TKey item)
            {
                throw new Exception("Class is readonly.");
            }

            #endregion

            #region IEnumerable<TKey> Members

            public IEnumerator<TKey> GetEnumerator()
            {
                return new Enumerator(_list);
            }

            #endregion

            #region IEnumerable Members

            IEnumerator IEnumerable.GetEnumerator()
            {
                return new Enumerator(_list);
            }

            #endregion

            public struct Enumerator : IEnumerator<TKey>, IEnumerator, IDisposable
            {
                private readonly OrderedDictionary<TKey, TItem> list;
                private int index;
                private TKey current;

                internal Enumerator(OrderedDictionary<TKey, TItem> list)
                {
                    this.list = list;
                    index = 0;
                    current = default(TKey);
                }

                public bool MoveNext()
                {
                    if (index < list.Count)
                    {
                        current = list._kvp[index].Key;
                        index++;
                        return true;
                    }
                    index = list._kvp.Count + 1;
                    current = default(TKey);
                    return false;
                }

                public TKey Current
                {
                    get { return current; }
                }

                object IEnumerator.Current
                {
                    get { return Current; }
                }

                void IEnumerator.Reset()
                {
                    index = 0;
                    current = default(TKey);
                }

                #region IDisposable Members

                void IDisposable.Dispose()
                {
                }

                #endregion
            }

            #region ICollection Members

            void ICollection.CopyTo(Array array, int index)
            {
                (this).CopyTo((TKey[]) array, index);
            }

            int ICollection.Count
            {
                get { return (this).Count; }
            }

            bool ICollection.IsSynchronized
            {
                get { return false; }
            }

            object ICollection.SyncRoot
            {
                get { return null; }
            }

            #endregion
        }

        #endregion

        #region class OrderedValueCollection

        private class OrderedValueCollection : ICollection<TItem>, ICollection
        {
            private readonly OrderedDictionary<TKey, TItem> _list;

            internal OrderedValueCollection(OrderedDictionary<TKey, TItem> list)
            {
                _list = list;
            }

            #region ICollection<TItem> Members

            public void Add(TItem item)
            {
                throw new Exception("Class is readonly.");
            }

            public void Clear()
            {
                throw new Exception("Class is readonly.");
            }

            public bool Contains(TItem item)
            {
                return _list.ContainsValue(item);
            }

            public void CopyTo(TItem[] array, int arrayIndex)
            {
                throw new Exception("Class is readonly.");
            }

            public int Count
            {
                get { return _list.Count; }
            }

            public bool IsReadOnly
            {
                get { return true; }
            }

            public bool Remove(TItem item)
            {
                throw new Exception("Class is readonly.");
            }

            #endregion

            #region IEnumerable<TItem> Members

            public IEnumerator<TItem> GetEnumerator()
            {
                return new Enumerator(_list);
            }

            #endregion

            #region IEnumerable Members

            IEnumerator IEnumerable.GetEnumerator()
            {
                return new Enumerator(_list);
            }

            #endregion

            #region ICollection Members

            void ICollection.CopyTo(Array array, int index)
            {
                (this).CopyTo((TItem[]) array, index);
            }

            int ICollection.Count
            {
                get { return (this).Count; }
            }

            bool ICollection.IsSynchronized
            {
                get { return false; }
            }

            object ICollection.SyncRoot
            {
                get { return null; }
            }

            #endregion

            public struct Enumerator : IEnumerator<TItem>, IEnumerator, IDisposable
            {
                private readonly OrderedDictionary<TKey, TItem> list;
                private int index;
                private TItem current;

                internal Enumerator(OrderedDictionary<TKey, TItem> list)
                {
                    this.list = list;
                    index = 0;
                    current = default(TItem);
                }

                public bool MoveNext()
                {
                    if (index < list.Count)
                    {
                        current = list._kvp[index].Value;
                        index++;
                        return true;
                    }
                    index = list._kvp.Count + 1;
                    current = default(TItem);
                    return false;
                }

                public TItem Current
                {
                    get { return current; }
                }

                object IEnumerator.Current
                {
                    get { return Current; }
                }

                void IEnumerator.Reset()
                {
                    index = 0;
                    current = default(TItem);
                }

                #region IDisposable Members

                void IDisposable.Dispose()
                {
                }

                #endregion
            }
        }

        #endregion

        #region IDictionary Members

        void IDictionary.Add(object key, object value)
        {
            Add((TKey) key, (TItem) value);
        }

        void IDictionary.Clear()
        {
            Clear();
        }

        bool IDictionary.Contains(object key)
        {
            return ContainsKey((TKey) key);
        }

        IDictionaryEnumerator IDictionary.GetEnumerator()
        {
            return new Enumerator(this);
        }

        bool IDictionary.IsFixedSize
        {
            get { throw new Exception("The method or operation is not implemented."); }
        }

        bool IDictionary.IsReadOnly
        {
            get { return true; }
        }

        ICollection IDictionary.Keys
        {
            get { return (ICollection) Keys; }
        }

        void IDictionary.Remove(object key)
        {
            Remove((TKey) key);
        }

        ICollection IDictionary.Values
        {
            get { return (ICollection) Values; }
        }

        object IDictionary.this[object key]
        {
            get { return this[(TKey) key]; }
            set { this[(TKey) key] = (TItem) value; }
        }

        #endregion

        #region ICollection Members

        void ICollection.CopyTo(Array array, int index)
        {
            _kvp.CopyTo((KeyValuePair<TKey, TItem>[]) array, index);
        }

        int ICollection.Count
        {
            get { return Count; }
        }

        bool ICollection.IsSynchronized
        {
            get { return false; }
        }

        object ICollection.SyncRoot
        {
            get { return null; }
        }

        #endregion
    }
}