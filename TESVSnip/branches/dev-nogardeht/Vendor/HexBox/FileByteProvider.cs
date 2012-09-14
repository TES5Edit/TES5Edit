using System;
using System.Collections;
using System.IO;

namespace Be.Windows.Forms
{
    /// <summary>
    /// Byte provider for (big) files.
    /// </summary>
    internal class FileByteProvider : IByteProvider, IDisposable
    {
        #region WriteCollection class

        /// <summary>
        /// Represents the write buffer class
        /// </summary>
        private class WriteCollection : DictionaryBase
        {
            /// <summary>
            /// Gets or sets a byte in the collection
            /// </summary>
            public byte this[long index]
            {
                get { return (byte) Dictionary[index]; }
                set { Dictionary[index] = value; }
            }

            /// <summary>
            /// Adds a byte into the collection
            /// </summary>
            /// <param name="index">the index of the byte</param>
            /// <param name="value">the value of the byte</param>
            public void Add(long index, byte value)
            {
                Dictionary.Add(index, value);
            }

            /// <summary>
            /// Determines if a byte with the given index exists.
            /// </summary>
            /// <param name="index">the index of the byte</param>
            /// <returns>true, if the is in the collection</returns>
            public bool Contains(long index)
            {
                return Dictionary.Contains(index);
            }
        }

        #endregion

        /// <summary>
        /// Occurs, when the write buffer contains new changes.
        /// </summary>
        public event EventHandler Changed;

        /// <summary>
        /// Contains all changes
        /// </summary>
        private readonly WriteCollection _writes = new WriteCollection();

        /// <summary>
        /// Contains the file stream.
        /// </summary>
        private FileStream _fileStream;

        /// <summary>
        /// Terminates the instance of the FileByteProvider class.
        /// </summary>
        ~FileByteProvider()
        {
            Dispose();
        }

        /// <summary>
        /// Raises the Changed event.
        /// </summary>
        /// <remarks>Never used.</remarks>
        private void OnChanged(EventArgs e)
        {
            if (Changed != null)
                Changed(this, e);
        }

        /// <summary>
        /// Returns a value if there are some changes.
        /// </summary>
        /// <returns>true, if there are some changes</returns>
        public bool HasChanges()
        {
            return (_writes.Count > 0);
        }

        /// <summary>
        /// Updates the file with all changes the write buffer contains.
        /// </summary>
        public void ApplyChanges()
        {
            if (!HasChanges())
                return;

            IDictionaryEnumerator en = _writes.GetEnumerator();
            while (en.MoveNext())
            {
                var index = (long) en.Key;
                var value = (byte) en.Value;
                if (_fileStream.Position != index)
                    _fileStream.Position = index;
                _fileStream.Write(new[] {value}, 0, 1);
            }
            _writes.Clear();
        }

        #region IByteProvider Members

        /// <summary>
        /// Never used.
        /// </summary>
#pragma warning disable 0067
        public event EventHandler LengthChanged;
#pragma warning restore 0067

        /// <summary>
        /// Reads a byte from the file.
        /// </summary>
        /// <param name="index">the index of the byte to read</param>
        /// <returns>the byte</returns>
        public byte ReadByte(long index)
        {
            if (_writes.Contains(index))
                return _writes[index];

            if (_fileStream.Position != index)
                _fileStream.Position = index;

            var res = (byte) _fileStream.ReadByte();
            return res;
        }

        /// <summary>
        /// Gets the length of the file.
        /// </summary>
        public long Length
        {
            get { return _fileStream.Length; }
        }

        /// <summary>
        /// Writes a byte into write buffer
        /// </summary>
        public void WriteByte(long index, byte value)
        {
            if (_writes.Contains(index))
                _writes[index] = value;
            else
                _writes.Add(index, value);

            OnChanged(EventArgs.Empty);
        }

        /// <summary>
        /// Not supported
        /// </summary>
        public void DeleteBytes(long index, long length)
        {
            throw new NotSupportedException("FileByteProvider.DeleteBytes");
        }

        /// <summary>
        /// Not supported
        /// </summary>
        public void InsertBytes(long index, byte[] bs)
        {
            throw new NotSupportedException("FileByteProvider.InsertBytes");
        }

        /// <summary>
        /// Returns true
        /// </summary>
        public bool SupportsWriteByte()
        {
            return true;
        }

        /// <summary>
        /// Returns false
        /// </summary>
        public bool SupportsInsertBytes()
        {
            return false;
        }

        /// <summary>
        /// Returns false
        /// </summary>
        public bool SupportsDeleteBytes()
        {
            return false;
        }

        #endregion

        #region IDisposable Members

        /// <summary>
        /// Releases the file handle used by the FileByteProvider.
        /// </summary>
        public void Dispose()
        {
            if (_fileStream != null)
            {
                _fileStream.Close();
                _fileStream = null;
            }

            GC.SuppressFinalize(this);
        }

        #endregion
    }
}