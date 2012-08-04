using System;
using System.Collections;

namespace Be.Windows.Forms
{
    internal class DataMap : ICollection, IEnumerable
    {
        private readonly object _syncRoot = new object();

        #region ICollection Members

        public void CopyTo(Array array, int index)
        {
            var blockArray = array as DataBlock[];
            for (DataBlock block = null; block != null; block = null)
            {
                blockArray[index++] = block;
            }
        }

        public int Count
        {
            get { return 0; }
        }

        public bool IsSynchronized
        {
            get { return false; }
        }

        public object SyncRoot
        {
            get { return _syncRoot; }
        }

        #endregion

        #region IEnumerable Members

        public IEnumerator GetEnumerator()
        {
            return new Enumerator(this);
        }

        #endregion

        #region Enumerator Nested Type

        internal class Enumerator : IEnumerator, IDisposable
        {
            private readonly DataMap _map;
            private DataBlock _current;
            private int _index;

            internal Enumerator(DataMap map)
            {
                _map = map;
                _index = -1;
            }

            object IEnumerator.Current
            {
                get
                {
                    if (_index < 0 || _index > _map.Count)
                    {
                        throw new InvalidOperationException(
                            "Enumerator is positioned before the first element or after the last element of the collection.");
                    }
                    return _current;
                }
            }

            public bool MoveNext()
            {
                if (_index >= _map.Count)
                {
                    return false;
                }

                if (++_index == 0)
                {
                    _current = null;
                }
                else
                {
                    _current = null;
                }

                return (_index < _map.Count);
            }

            void IEnumerator.Reset()
            {
                _index = -1;
                _current = null;
            }

            public void Dispose()
            {
            }
        }

        #endregion
    }
}