// © Copyright Henrik Ravn 2004
// Use, modification and distribution are subject to the Boost Software License, Version 1.0. 
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
namespace TESVSnip.DotZLib
{
    using System;
    using System.Runtime.InteropServices;

    /// <summary>
    /// Implements the common functionality needed for all <see cref="Codec"/>s.
    /// </summary>
    public abstract class CodecBase : Codec, IDisposable
    {
        /// <summary>
        /// The size of the internal buffers.
        /// </summary>
        protected const int kBufferSize = 16384;

        /// <summary>
        /// Instance of the internal zlib buffer structure that is 
        ///   passed to all functions in the zlib dll.
        /// </summary>
        internal ZStream _ztream = new ZStream();

        /// <summary>
        /// True if the object instance has been disposed, false otherwise.
        /// </summary>
        protected bool _isDisposed = false;

        private readonly byte[] _inBuffer = new byte[kBufferSize];

        private readonly byte[] _outBuffer = new byte[kBufferSize];

        private uint _checksum = 0;

        private GCHandle _hInput;

        private GCHandle _hOutput;

        /// <summary>
        /// Initializes a new instance of the <see cref="CodecBase"/> class. 
        ///   Initializes a new instance of the <c>CodeBase</c> class.
        /// </summary>
        public CodecBase()
        {
            try
            {
                this._hInput = GCHandle.Alloc(this._inBuffer, GCHandleType.Pinned);
                this._hOutput = GCHandle.Alloc(this._outBuffer, GCHandleType.Pinned);
            }
            catch (Exception)
            {
                this.CleanUp(false);
                throw;
            }
        }

        /// <summary>
        /// Finalizes an instance of the <see cref="CodecBase"/> class. 
        /// Destroys this instance.
        /// </summary>
        ~CodecBase()
        {
            this.CleanUp(false);
        }

        /// <summary>
        /// Occurs when more processed data are available.
        /// </summary>
        public event DataAvailableHandler DataAvailable;

        /// <summary>
        /// Gets the checksum of the data that has been added so far.
        /// </summary>
        /// <value>
        /// The checksum.
        /// </value>
        public uint Checksum
        {
            get
            {
                return this._checksum;
            }
        }

        /// <summary>
        /// Adds more data to the codec to be processed.
        /// </summary>
        /// <param name="data">
        /// Byte array containing the data to be added to the codec. 
        /// </param>
        /// <remarks>
        /// Adding data may, or may not, raise the <c>DataAvailable</c> event.
        /// </remarks>
        public void Add(byte[] data)
        {
            this.Add(data, 0, data.Length);
        }

        /// <summary>
        /// Adds more data to the codec to be processed.
        /// </summary>
        /// <param name="data">
        /// Byte array containing the data to be added to the codec. 
        /// </param>
        /// <param name="offset">
        /// The index of the first byte to add from <c>data</c>. 
        /// </param>
        /// <param name="count">
        /// The number of bytes to add. 
        /// </param>
        /// <remarks>
        /// Adding data may, or may not, raise the <c>DataAvailable</c> event.
        /// </remarks>
        /// <remarks>
        /// This must be implemented by a derived class.
        /// </remarks>
        public abstract void Add(byte[] data, int offset, int count);

        /// <summary>
        /// Releases any unmanaged resources and calls the <see cref="CleanUp()"/> method of the derived class.
        /// </summary>
        public void Dispose()
        {
            this.Finish();
            this.CleanUp(true);
        }

        /// <summary>
        /// Finishes up any pending data that needs to be processed and handled.
        /// </summary>
        /// <remarks>
        /// This must be implemented by a derived class.
        /// </remarks>
        public abstract void Finish();

        /// <summary>
        /// Performs any codec specific cleanup.
        /// </summary>
        /// <remarks>
        /// This must be implemented by a derived class.
        /// </remarks>
        protected abstract void CleanUp();

        /// <summary>
        /// Fires the <see cref="DataAvailable"/> event.
        /// </summary>
        protected void OnDataAvailable()
        {
            if (this._ztream.total_out > 0)
            {
                if (this.DataAvailable != null)
                {
                    this.DataAvailable(this._outBuffer, 0, (int)this._ztream.total_out);
                }

                this.resetOutput();
            }
        }

        // performs the release of the handles and calls the dereived CleanUp()

        /// <summary>
        /// Copies a number of bytes to the internal codec buffer - ready for proccesing.
        /// </summary>
        /// <param name="data">
        /// The byte array that contains the data to copy. 
        /// </param>
        /// <param name="startIndex">
        /// The index of the first byte to copy. 
        /// </param>
        /// <param name="count">
        /// The number of bytes to copy from <c>data</c>. 
        /// </param>
        protected void copyInput(byte[] data, int startIndex, int count)
        {
            Array.Copy(data, startIndex, this._inBuffer, 0, count);
            this._ztream.next_in = this._hInput.AddrOfPinnedObject();
            this._ztream.total_in = 0;
            this._ztream.avail_in = (uint)count;
        }

        /// <summary>
        /// Resets the internal output buffers to a known state - ready for processing.
        /// </summary>
        protected void resetOutput()
        {
            this._ztream.total_out = 0;
            this._ztream.avail_out = kBufferSize;
            this._ztream.next_out = this._hOutput.AddrOfPinnedObject();
        }

        /// <summary>
        /// Updates the running checksum property.
        /// </summary>
        /// <param name="newSum">
        /// The new checksum value. 
        /// </param>
        protected void setChecksum(uint newSum)
        {
            this._checksum = newSum;
        }

        private void CleanUp(bool isDisposing)
        {
            if (!this._isDisposed)
            {
                this.CleanUp();
                if (this._hInput.IsAllocated)
                {
                    this._hInput.Free();
                }

                if (this._hOutput.IsAllocated)
                {
                    this._hOutput.Free();
                }

                this._isDisposed = true;
            }
        }
    }
}
