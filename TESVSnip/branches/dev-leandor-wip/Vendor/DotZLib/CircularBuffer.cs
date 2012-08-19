// © Copyright Henrik Ravn 2004
// Use, modification and distribution are subject to the Boost Software License, Version 1.0. 
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
namespace TESVSnip.DotZLib
{
    using System;
    using System.Diagnostics;

    /// <summary>
    /// This class implements a circular buffer.
    /// </summary>
    internal class CircularBuffer
    {
        private readonly byte[] _buffer;

        private readonly int _capacity;

        private int _head;

        private int _size;

        private int _tail;

        public CircularBuffer(int capacity)
        {
            Debug.Assert(capacity > 0);
            this._buffer = new byte[capacity];
            this._capacity = capacity;
            this._head = 0;
            this._tail = 0;
            this._size = 0;
        }

        public int Size
        {
            get
            {
                return this._size;
            }
        }

        public int Get(byte[] destination, int offset, int count)
        {
            int trueCount = Math.Min(count, this.Size);
            for (int i = 0; i < trueCount; ++i)
            {
                destination[offset + i] = this._buffer[(this._head + i) % this._capacity];
            }

            this._head += trueCount;
            this._head %= this._capacity;
            this._size -= trueCount;
            return trueCount;
        }

        public int Get()
        {
            if (this.Size == 0)
            {
                return -1;
            }

            var result = (int)this._buffer[this._head++ % this._capacity];
            --this._size;
            return result;
        }

        public int Put(byte[] source, int offset, int count)
        {
            Debug.Assert(count > 0);
            int trueCount = Math.Min(count, this._capacity - this.Size);
            for (int i = 0; i < trueCount; ++i)
            {
                this._buffer[(this._tail + i) % this._capacity] = source[offset + i];
            }

            this._tail += trueCount;
            this._tail %= this._capacity;
            this._size += trueCount;
            return trueCount;
        }

        public bool Put(byte b)
        {
            if (this.Size == this._capacity)
            {
                // no room
                return false;
            }

            this._buffer[this._tail++] = b;
            this._tail %= this._capacity;
            ++this._size;
            return true;
        }
    }
}
