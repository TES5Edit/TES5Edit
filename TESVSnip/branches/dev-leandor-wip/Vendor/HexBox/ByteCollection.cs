using System.Collections;

namespace Be.Windows.Forms
{
    /// <summary>
    /// Represents a collection of bytes.
    /// </summary>
    internal class ByteCollection : CollectionBase
    {
        /// <summary>
        /// Initializes a new instance of ByteCollection class.
        /// </summary>
        public ByteCollection()
        {
        }

        /// <summary>
        /// Initializes a new instance of ByteCollection class.
        /// </summary>
        /// <param name="bs">an array of bytes to add to collection</param>
        public ByteCollection(byte[] bs)
        {
            AddRange(bs);
        }

        /// <summary>
        /// Gets or sets the value of a byte
        /// </summary>
        public byte this[int index]
        {
            get { return (byte) List[index]; }
            set { List[index] = value; }
        }

        /// <summary>
        /// Adds a range of bytes to the collection.
        /// </summary>
        /// <param name="bs">the bytes to add</param>
        public void AddRange(byte[] bs)
        {
            InnerList.AddRange(bs);
        }

        /// <summary>
        /// Removes a range of bytes from the collection.
        /// </summary>
        /// <param name="index">the index of the start byte</param>
        /// <param name="count">the count of the bytes to remove</param>
        public void RemoveRange(int index, int count)
        {
            InnerList.RemoveRange(index, count);
        }

        /// <summary>
        /// Inserts a range of bytes to the collection.
        /// </summary>
        /// <param name="index">the index of start byte</param>
        /// <param name="bs">an array of bytes to insert</param>
        public void InsertRange(int index, byte[] bs)
        {
            InnerList.InsertRange(index, bs);
        }

        /// <summary>
        /// Gets all bytes in the array
        /// </summary>
        /// <returns>an array of bytes.</returns>
        public byte[] GetBytes()
        {
            var bytes = new byte[Count];
            InnerList.CopyTo(0, bytes, 0, bytes.Length);
            return bytes;
        }
    }
}