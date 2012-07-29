// ZipFile.cs
//
// Copyright (C) 2001 Mike Krueger
// Copyright (C) 2004 John Reilly
//
// This file was translated from java, it was part of the GNU Classpath
// Copyright (C) 2001 Free Software Foundation, Inc.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
//
// Linking this library statically or dynamically with other modules is
// making a combined work based on this library.  Thus, the terms and
// conditions of the GNU General Public License cover the whole
// combination.
// 
// As a special exception, the copyright holders of this library give you
// permission to link this library with independent modules to produce an
// executable, regardless of the license terms of these independent
// modules, and to copy and distribute the resulting executable under
// terms of your choice, provided that you also meet, for each linked
// independent module, the terms and conditions of the license of that
// module.  An independent module is a module which is not derived from
// or based on this library.  If you modify this library, you may extend
// this exception to your version of the library, but you are not
// obligated to do so.  If you do not wish to do so, delete this
// exception statement from your version.

using System;
using System.Collections;
using System.Globalization;
using System.IO;
using System.Text;
using ICSharpCode.SharpZipLib.Checksums;
using ICSharpCode.SharpZipLib.Core;
using ICSharpCode.SharpZipLib.Zip.Compression;
using ICSharpCode.SharpZipLib.Zip.Compression.Streams;

namespace ICSharpCode.SharpZipLib.Zip
{

    #region Update Definitions

    /// <summary>
    /// The possible ways of <see cref="ZipFile.CommitUpdate()">applying updates</see> to an archive.
    /// </summary>
    internal enum FileUpdateMode
    {
        /// <summary>
        /// Perform all updates on temporary files ensuring that the original file is saved.
        /// </summary>
        Safe,

        /// <summary>
        /// Update the archive directly, which is faster but less safe.
        /// </summary>
        Direct,
    }

    #endregion

    #region ZipFile Class

    /// <summary>
    /// This class represents a Zip archive.  You can ask for the contained
    /// entries, or get an input stream for a file entry.  The entry is
    /// automatically decompressed.
    /// 
    /// You can also update the archive adding or deleting entries.
    /// 
    /// This class is thread safe for input:  You can open input streams for arbitrary
    /// entries in different threads.
    /// <br/>
    /// <br/>Author of the original java version : Jochen Hoenicke
    /// </summary>
    /// <example>
    /// <code>
    /// using System;
    /// using System.Text;
    /// using System.Collections;
    /// using System.IO;
    /// 
    /// using ICSharpCode.SharpZipLib.Zip;
    /// 
    /// class MainClass
    /// {
    /// 	static public void Main(string[] args)
    /// 	{
    /// 		using (ZipFile zFile = new ZipFile(args[0])) {
    /// 			Console.WriteLine("Listing of : " + zFile.Name);
    /// 			Console.WriteLine("");
    /// 			Console.WriteLine("Raw Size    Size      Date     Time     Name");
    /// 			Console.WriteLine("--------  --------  --------  ------  ---------");
    /// 			foreach (ZipEntry e in zFile) {
    /// 				if ( e.IsFile ) {
    /// 					DateTime d = e.DateTime;
    /// 					Console.WriteLine("{0, -10}{1, -10}{2}  {3}   {4}", e.Size, e.CompressedSize,
    /// 						d.ToString("dd-MM-yy"), d.ToString("HH:mm"),
    /// 						e.Name);
    /// 				}
    /// 			}
    /// 		}
    /// 	}
    /// }
    /// </code>
    /// </example>
    internal class ZipFile : IEnumerable, IDisposable
    {
        #region Constructors

        /// <summary>
        /// Opens a Zip file with the given name for reading.
        /// </summary>
        /// <param name="name">The name of the file to open.</param>
        /// <exception cref="ArgumentNullException">The argument supplied is null.</exception>
        /// <exception cref="IOException">
        /// An i/o error occurs
        /// </exception>
        /// <exception cref="ZipException">
        /// The file doesn't contain a valid zip archive.
        /// </exception>
        public ZipFile(string name)
        {
            if (name == null)
            {
                throw new ArgumentNullException("name");
            }

            name_ = name;

            baseStream_ = File.OpenRead(name);
            isStreamOwner = true;

            try
            {
                ReadEntries();
            }
            catch
            {
                DisposeInternal();
                throw;
            }
        }

        /// <summary>
        /// Initialises a default <see cref="ZipFile"/> instance with no entries and no file storage.
        /// </summary>
        internal ZipFile()
        {
            entries_ = new ZipEntry[0];
            isNewArchive_ = true;
        }

        #endregion

        #region Destructors and Closing

        /// <summary>
        /// Finalize this instance.
        /// </summary>
        ~ZipFile()
        {
            Dispose(false);
        }

        /// <summary>
        /// Closes the ZipFile.  If the stream is <see cref="IsStreamOwner">owned</see> then this also closes the underlying input stream.
        /// Once closed, no further instance methods should be called.
        /// </summary>
        /// <exception cref="System.IO.IOException">
        /// An i/o error occurs.
        /// </exception>
        public void Close()
        {
            DisposeInternal();
            GC.SuppressFinalize(this);
        }

        #endregion

        #region Creators

        /// <summary>
        /// Create a new <see cref="ZipFile"/> whose data will be stored on a stream.
        /// </summary>
        /// <param name="outStream">The stream providing data storage.</param>
        /// <returns>Returns the newly created <see cref="ZipFile"/></returns>
        /// <exception cref="ArgumentNullException"><paramref name="outStream"> is null</paramref></exception>
        /// <exception cref="ArgumentException"><paramref name="outStream"> doesnt support writing.</paramref></exception>
        public static ZipFile Create(Stream outStream)
        {
            if (outStream == null)
            {
                throw new ArgumentNullException("outStream");
            }

            if (!outStream.CanWrite)
            {
                throw new ArgumentException("Stream is not writeable", "outStream");
            }

            if (!outStream.CanSeek)
            {
                throw new ArgumentException("Stream is not seekable", "outStream");
            }

            var result = new ZipFile();
            result.baseStream_ = outStream;
            return result;
        }

        #endregion

        #region Properties

        /// <summary>
        /// Get/set a flag indicating if the underlying stream is owned by the ZipFile instance.
        /// If the flag is true then the stream will be closed when <see cref="Close">Close</see> is called.
        /// </summary>
        /// <remarks>
        /// The default value is true in all cases.
        /// </remarks>
        public bool IsStreamOwner
        {
            get { return isStreamOwner; }
        }

        /// <summary>
        /// Get a value indicating wether
        /// this archive is embedded in another file or not.
        /// </summary>
        public bool IsEmbeddedArchive
        {
            // Not strictly correct in all circumstances currently
            get { return offsetOfFirstEntry > 0; }
        }

        /// <summary>
        /// Get a value indicating that this archive is a new one.
        /// </summary>
        public bool IsNewArchive
        {
            get { return isNewArchive_; }
        }

        /// <summary>
        /// Gets the name of this zip file.
        /// </summary>
        public string Name
        {
            get { return name_; }
        }

        #endregion

        #region Input Handling

        /// <summary>
        /// Gets an enumerator for the Zip entries in this Zip file.
        /// </summary>
        /// <returns>Returns an <see cref="IEnumerator"/> for this archive.</returns>
        /// <exception cref="ObjectDisposedException">
        /// The Zip file has been closed.
        /// </exception>
        public IEnumerator GetEnumerator()
        {
            if (isDisposed_)
            {
                throw new ObjectDisposedException("ZipFile");
            }

            return new ZipEntryEnumerator(entries_);
        }

        /// <summary>
        /// Return the index of the entry with a matching name
        /// </summary>
        /// <param name="name">Entry name to find</param>
        /// <param name="ignoreCase">If true the comparison is case insensitive</param>
        /// <returns>The index position of the matching entry or -1 if not found</returns>
        /// <exception cref="ObjectDisposedException">
        /// The Zip file has been closed.
        /// </exception>
        public int FindEntry(string name, bool ignoreCase)
        {
            if (isDisposed_)
            {
                throw new ObjectDisposedException("ZipFile");
            }

            // TODO: This will be slow as the next ice age for huge archives!
            for (int i = 0; i < entries_.Length; i++)
            {
                if (string.Compare(name, entries_[i].Name, ignoreCase, CultureInfo.InvariantCulture) == 0)
                {
                    return i;
                }
            }
            return -1;
        }

        /// <summary>
        /// Searches for a zip entry in this archive with the given name.
        /// String comparisons are case insensitive
        /// </summary>
        /// <param name="name">
        /// The name to find. May contain directory components separated by slashes ('/').
        /// </param>
        /// <returns>
        /// A clone of the zip entry, or null if no entry with that name exists.
        /// </returns>
        /// <exception cref="ObjectDisposedException">
        /// The Zip file has been closed.
        /// </exception>
        public ZipEntry GetEntry(string name)
        {
            if (isDisposed_)
            {
                throw new ObjectDisposedException("ZipFile");
            }

            int index = FindEntry(name, true);
            return (index >= 0) ? (ZipEntry) entries_[index].Clone() : null;
        }

        /// <summary>
        /// Gets an input stream for reading the given zip entry data in an uncompressed form.
        /// Normally the <see cref="ZipEntry"/> should be an entry returned by GetEntry().
        /// </summary>
        /// <param name="entry">The <see cref="ZipEntry"/> to obtain a data <see cref="Stream"/> for</param>
        /// <returns>An input <see cref="Stream"/> containing data for this <see cref="ZipEntry"/></returns>
        /// <exception cref="ObjectDisposedException">
        /// The ZipFile has already been closed
        /// </exception>
        /// <exception cref="ICSharpCode.SharpZipLib.Zip.ZipException">
        /// The compression method for the entry is unknown
        /// </exception>
        /// <exception cref="IndexOutOfRangeException">
        /// The entry is not found in the ZipFile
        /// </exception>
        public Stream GetInputStream(ZipEntry entry)
        {
            if (entry == null)
            {
                throw new ArgumentNullException("entry");
            }

            if (isDisposed_)
            {
                throw new ObjectDisposedException("ZipFile");
            }

            long index = entry.ZipFileIndex;
            if ((index < 0) || (index >= entries_.Length) || (entries_[index].Name != entry.Name))
            {
                index = FindEntry(entry.Name, true);
                if (index < 0)
                {
                    throw new ZipException("Entry cannot be found");
                }
            }
            return GetInputStream(index);
        }

        /// <summary>
        /// Creates an input stream reading a zip entry
        /// </summary>
        /// <param name="entryIndex">The index of the entry to obtain an input stream for.</param>
        /// <returns>
        /// An input <see cref="Stream"/> containing data for this <paramref name="entryIndex"/>
        /// </returns>
        /// <exception cref="ObjectDisposedException">
        /// The ZipFile has already been closed
        /// </exception>
        /// <exception cref="ICSharpCode.SharpZipLib.Zip.ZipException">
        /// The compression method for the entry is unknown
        /// </exception>
        /// <exception cref="IndexOutOfRangeException">
        /// The entry is not found in the ZipFile
        /// </exception>
        public Stream GetInputStream(long entryIndex)
        {
            if (isDisposed_)
            {
                throw new ObjectDisposedException("ZipFile");
            }

            long start = LocateEntry(entries_[entryIndex]);
            CompressionMethod method = entries_[entryIndex].CompressionMethod;
            Stream result = new PartialInputStream(this, start, entries_[entryIndex].CompressedSize);

            switch (method)
            {
                case CompressionMethod.Stored:
                    // read as is.
                    break;

                case CompressionMethod.Deflated:
                    // No need to worry about ownership and closing as underlying stream close does nothing.
                    result = new InflaterInputStream(result, new Inflater(true));
                    break;

                default:
                    throw new ZipException("Unsupported compression method " + method);
            }

            return result;
        }

        #endregion

        #region Archive Testing

        [Flags]
        private enum HeaderTest
        {
            Extract = 0x01, // Check that this header represents an entry whose data can be extracted
            Header = 0x02, // Check that this header contents are valid
        }

        /// <summary>
        /// Test a local header against that provided from the central directory
        /// </summary>
        /// <param name="entry">
        /// The entry to test against
        /// </param>
        /// <param name="tests">The type of <see cref="HeaderTest">tests</see> to carry out.</param>
        /// <returns>The offset of the entries data in the file</returns>
        private long TestLocalHeader(ZipEntry entry, HeaderTest tests)
        {
            lock (baseStream_)
            {
                bool testHeader = (tests & HeaderTest.Header) != 0;
                bool testData = (tests & HeaderTest.Extract) != 0;

                baseStream_.Seek(offsetOfFirstEntry + entry.Offset, SeekOrigin.Begin);
                if ((int) ReadLEUint() != ZipConstants.LocalHeaderSignature)
                {
                    throw new ZipException(string.Format("Wrong local header signature @{0:X}",
                                                         offsetOfFirstEntry + entry.Offset));
                }

                var extractVersion = (short) ReadLEUshort();
                var localFlags = (short) ReadLEUshort();
                var compressionMethod = (short) ReadLEUshort();
                var fileTime = (short) ReadLEUshort();
                var fileDate = (short) ReadLEUshort();
                uint crcValue = ReadLEUint();
                long compressedSize = ReadLEUint();
                long size = ReadLEUint();
                int storedNameLength = ReadLEUshort();
                int extraDataLength = ReadLEUshort();

                var nameData = new byte[storedNameLength];
                StreamUtils.ReadFully(baseStream_, nameData);

                var extraData = new byte[extraDataLength];
                StreamUtils.ReadFully(baseStream_, extraData);

                var localExtraData = new ZipExtraData(extraData);

                // Extra data / zip64 checks
                if (localExtraData.Find(1))
                {
                    // TODO Check for tag values being distinct..  Multiple zip64 tags means what?

                    // Zip64 extra data but 'extract version' is too low
                    if (extractVersion < ZipConstants.VersionZip64)
                    {
                        throw new ZipException(
                            string.Format(
                                "Extra data contains Zip64 information but version {0}.{1} is not high enough",
                                extractVersion/10, extractVersion%10));
                    }

                    // Zip64 extra data but size fields dont indicate its required.
                    if (((uint) size != uint.MaxValue) && ((uint) compressedSize != uint.MaxValue))
                    {
                        throw new ZipException("Entry sizes not correct for Zip64");
                    }

                    size = localExtraData.ReadLong();
                    compressedSize = localExtraData.ReadLong();

                    if ((localFlags & (int) GeneralBitFlags.Descriptor) != 0)
                    {
                        // These may be valid if patched later
                        if ((size != -1) && (size != entry.Size))
                        {
                            throw new ZipException("Size invalid for descriptor");
                        }

                        if ((compressedSize != -1) && (compressedSize != entry.CompressedSize))
                        {
                            throw new ZipException("Compressed size invalid for descriptor");
                        }
                    }
                }
                else
                {
                    // No zip64 extra data but entry requires it.
                    if ((extractVersion >= ZipConstants.VersionZip64) &&
                        (((uint) size == uint.MaxValue) || ((uint) compressedSize == uint.MaxValue)))
                    {
                        throw new ZipException("Required Zip64 extended information missing");
                    }
                }

                if (testData)
                {
                    if (entry.IsFile)
                    {
                        if (!entry.IsCompressionMethodSupported())
                        {
                            throw new ZipException("Compression method not supported");
                        }

                        if ((extractVersion > ZipConstants.VersionMadeBy)
                            || ((extractVersion > 20) && (extractVersion < ZipConstants.VersionZip64)))
                        {
                            throw new ZipException(
                                string.Format("Version required to extract this entry not supported ({0})",
                                              extractVersion));
                        }

                        if ((localFlags &
                             (int)
                             (GeneralBitFlags.Patched | GeneralBitFlags.StrongEncryption |
                              GeneralBitFlags.EnhancedCompress | GeneralBitFlags.HeaderMasked)) != 0)
                        {
                            throw new ZipException(
                                "The library does not support the zip version required to extract this entry");
                        }
                    }
                }

                if (testHeader)
                {
                    if ((extractVersion <= 63) && // Ignore later versions as we dont know about them..
                        (extractVersion != 10) &&
                        (extractVersion != 11) &&
                        (extractVersion != 20) &&
                        (extractVersion != 21) &&
                        (extractVersion != 25) &&
                        (extractVersion != 27) &&
                        (extractVersion != 45) &&
                        (extractVersion != 46) &&
                        (extractVersion != 50) &&
                        (extractVersion != 51) &&
                        (extractVersion != 52) &&
                        (extractVersion != 61) &&
                        (extractVersion != 62) &&
                        (extractVersion != 63)
                        )
                    {
                        throw new ZipException(string.Format("Version required to extract this entry is invalid ({0})",
                                                             extractVersion));
                    }

                    // Local entry flags dont have reserved bit set on.
                    if ((localFlags &
                         (int)
                         (GeneralBitFlags.ReservedPKware4 | GeneralBitFlags.ReservedPkware14 |
                          GeneralBitFlags.ReservedPkware15)) != 0)
                    {
                        throw new ZipException("Reserved bit flags cannot be set.");
                    }

                    // Encryption requires extract version >= 20
                    if (((localFlags & (int) GeneralBitFlags.Encrypted) != 0) && (extractVersion < 20))
                    {
                        throw new ZipException(
                            string.Format("Version required to extract this entry is too low for encryption ({0})",
                                          extractVersion));
                    }

                    // Strong encryption requires encryption flag to be set and extract version >= 50.
                    if ((localFlags & (int) GeneralBitFlags.StrongEncryption) != 0)
                    {
                        if ((localFlags & (int) GeneralBitFlags.Encrypted) == 0)
                        {
                            throw new ZipException("Strong encryption flag set but encryption flag is not set");
                        }

                        if (extractVersion < 50)
                        {
                            throw new ZipException(
                                string.Format("Version required to extract this entry is too low for encryption ({0})",
                                              extractVersion));
                        }
                    }

                    // Patched entries require extract version >= 27
                    if (((localFlags & (int) GeneralBitFlags.Patched) != 0) && (extractVersion < 27))
                    {
                        throw new ZipException(string.Format("Patched data requires higher version than ({0})",
                                                             extractVersion));
                    }

                    // Central header flags match local entry flags.
                    if (localFlags != entry.Flags)
                    {
                        throw new ZipException("Central header/local header flags mismatch");
                    }

                    // Central header compression method matches local entry
                    if (entry.CompressionMethod != (CompressionMethod) compressionMethod)
                    {
                        throw new ZipException("Central header/local header compression method mismatch");
                    }

                    if (entry.Version != extractVersion)
                    {
                        throw new ZipException("Extract version mismatch");
                    }

                    // Strong encryption and extract version match
                    if ((localFlags & (int) GeneralBitFlags.StrongEncryption) != 0)
                    {
                        if (extractVersion < 62)
                        {
                            throw new ZipException("Strong encryption flag set but version not high enough");
                        }
                    }

                    if ((localFlags & (int) GeneralBitFlags.HeaderMasked) != 0)
                    {
                        if ((fileTime != 0) || (fileDate != 0))
                        {
                            throw new ZipException("Header masked set but date/time values non-zero");
                        }
                    }

                    if ((localFlags & (int) GeneralBitFlags.Descriptor) == 0)
                    {
                        if (crcValue != (uint) entry.Crc)
                        {
                            throw new ZipException("Central header/local header crc mismatch");
                        }
                    }

                    // Crc valid for empty entry.
                    // This will also apply to streamed entries where size isnt known and the header cant be patched
                    if ((size == 0) && (compressedSize == 0))
                    {
                        if (crcValue != 0)
                        {
                            throw new ZipException("Invalid CRC for empty entry");
                        }
                    }

                    // TODO: make test more correct...  can't compare lengths as was done originally as this can fail for MBCS strings
                    // Assuming a code page at this point is not valid?  Best is to store the name length in the ZipEntry probably
                    if (entry.Name.Length > storedNameLength)
                    {
                        throw new ZipException("File name length mismatch");
                    }

                    // Name data has already been read convert it and compare.
                    string localName = ZipConstants.ConvertToStringExt(localFlags, nameData);

                    // Central directory and local entry name match
                    if (localName != entry.Name)
                    {
                        throw new ZipException("Central header and local header file name mismatch");
                    }

                    // Directories have zero actual size but can have compressed size
                    if (entry.IsDirectory)
                    {
                        if (size > 0)
                        {
                            throw new ZipException("Directory cannot have size");
                        }

                        // There may be other cases where the compressed size can be greater than this?
                        // If so until details are known we will be strict.
                        if (compressedSize > 2)
                        {
                            // When not compressed the directory size can validly be 2 bytes
                            // if the true size wasnt known when data was originally being written.
                            // NOTE: Versions of the library 0.85.4 and earlier always added 2 bytes
                            throw new ZipException("Directory compressed size invalid");
                        }
                    }

                    if (!ZipNameTransform.IsValidName(localName, true))
                    {
                        throw new ZipException("Name is invalid");
                    }
                }

                // Tests that apply to both data and header.

                // Size can be verified only if it is known in the local header.
                // it will always be known in the central header.
                if (((localFlags & (int) GeneralBitFlags.Descriptor) == 0) ||
                    ((size > 0) || (compressedSize > 0)))
                {
                    if (size != entry.Size)
                    {
                        throw new ZipException(
                            string.Format("Size mismatch between central header({0}) and local header({1})",
                                          entry.Size, size));
                    }

                    if (compressedSize != entry.CompressedSize)
                    {
                        throw new ZipException(
                            string.Format("Compressed size mismatch between central header({0}) and local header({1})",
                                          entry.CompressedSize, compressedSize));
                    }
                }

                int extraLength = storedNameLength + extraDataLength;
                return offsetOfFirstEntry + entry.Offset + ZipConstants.LocalHeaderBaseSize + extraLength;
            }
        }

        #endregion

        #region Updating

        private const int DefaultBufferSize = 4096;

        /// <summary>
        /// The kind of update to apply.
        /// </summary>
        private enum UpdateCommand
        {
            Copy, // Copy original file contents.
            Modify, // Change encryption, compression, attributes, name, time etc, of an existing file.
            Add, // Add a new file to the archive.
        }

        #region Properties

        /// <summary>
        /// Get / set the <see cref="INameTransform"/> to apply to names when updating.
        /// </summary>
        public INameTransform NameTransform
        {
            get { return updateEntryFactory_.NameTransform; }
        }

        /// <summary>
        /// Get/set the <see cref="IEntryFactory"/> used to generate <see cref="ZipEntry"/> values
        /// during updates.
        /// </summary>
        public IEntryFactory EntryFactory
        {
            get { return updateEntryFactory_; }
        }

        /// <summary>
        /// Get / set a value indicating how Zip64 Extension usage is determined when adding entries.
        /// </summary>
        public UseZip64 UseZip64
        {
            get { return useZip64_; }
            set { useZip64_ = value; }
        }

        #endregion

        #region Deferred Updating

        /// <summary>
        /// Begin updating this <see cref="ZipFile"/> archive.
        /// </summary>
        /// <param name="archiveStorage">The <see cref="IArchiveStorage">archive storage</see> for use during the update.</param>
        /// <param name="dataSource">The <see cref="IDynamicDataSource">data source</see> to utilise during updating.</param>
        /// <exception cref="ObjectDisposedException">ZipFile has been closed.</exception>
        /// <exception cref="ArgumentNullException">One of the arguments provided is null</exception>
        /// <exception cref="ObjectDisposedException">ZipFile has been closed.</exception>
        public void BeginUpdate(IArchiveStorage archiveStorage, IDynamicDataSource dataSource)
        {
            if (archiveStorage == null)
            {
                throw new ArgumentNullException("archiveStorage");
            }

            if (dataSource == null)
            {
                throw new ArgumentNullException("dataSource");
            }

            if (isDisposed_)
            {
                throw new ObjectDisposedException("ZipFile");
            }

            if (IsEmbeddedArchive)
            {
                throw new ZipException("Cannot update embedded/SFX archives");
            }

            archiveStorage_ = archiveStorage;
            updateDataSource_ = dataSource;

            // NOTE: the baseStream_ may not currently support writing or seeking.

            updateIndex_ = new Hashtable();

            updates_ = new ArrayList(entries_.Length);
            foreach (ZipEntry entry in entries_)
            {
                int index = updates_.Add(new ZipUpdate(entry));
                updateIndex_.Add(entry.Name, index);
            }

            updateCount_ = updates_.Count;

            contentsEdited_ = false;
        }

        /// <summary>
        /// Begin updating this <see cref="ZipFile"/> archive.
        /// </summary>
        /// <seealso cref="BeginUpdate(IArchiveStorage)"/>
        /// <seealso cref="CommitUpdate"></seealso>
        /// <seealso cref="AbortUpdate"></seealso>
        public void BeginUpdate()
        {
            if (Name == null)
            {
                BeginUpdate(new MemoryArchiveStorage(), new DynamicDiskDataSource());
            }
            else
            {
                BeginUpdate(new DiskArchiveStorage(this), new DynamicDiskDataSource());
            }
        }

        /// <summary>
        /// Commit current updates, updating this archive.
        /// </summary>
        /// <seealso cref="BeginUpdate()"></seealso>
        /// <seealso cref="AbortUpdate"></seealso>
        /// <exception cref="ObjectDisposedException">ZipFile has been closed.</exception>
        public void CommitUpdate()
        {
            if (isDisposed_)
            {
                throw new ObjectDisposedException("ZipFile");
            }

            CheckUpdating();

            try
            {
                updateIndex_.Clear();
                updateIndex_ = null;

                if (contentsEdited_)
                {
                    RunUpdates();
                }
                else
                {
                    // Create an empty archive if none existed originally.
                    if (entries_.Length == 0)
                    {
                        byte[] theComment = ZipConstants.ConvertToArray(comment_);
                        using (var zhs = new ZipHelperStream(baseStream_))
                        {
                            zhs.WriteEndOfCentralDirectory(0, 0, 0, theComment);
                        }
                    }
                }
            }
            finally
            {
                PostUpdateCleanup();
            }
        }

        #endregion

        #region Adding Entries

        private void AddUpdate(ZipUpdate update)
        {
            contentsEdited_ = true;

            int index = FindExistingUpdate(update.Entry.Name);

            if (index >= 0)
            {
                if (updates_[index] == null)
                {
                    updateCount_ += 1;
                }

                // Direct replacement is faster than delete and add.
                updates_[index] = update;
            }
            else
            {
                index = updates_.Add(update);
                updateCount_ += 1;
                updateIndex_.Add(update.Entry.Name, index);
            }
        }

        /// <summary>
        /// Add a file entry with data.
        /// </summary>
        /// <param name="dataSource">The source of the data for this entry.</param>
        /// <param name="entryName">The name to give to the entry.</param>
        public void Add(IStaticDataSource dataSource, string entryName)
        {
            if (dataSource == null)
            {
                throw new ArgumentNullException("dataSource");
            }

            if (entryName == null)
            {
                throw new ArgumentNullException("entryName");
            }

            CheckUpdating();
            AddUpdate(new ZipUpdate(dataSource, EntryFactory.MakeFileEntry(entryName, false)));
        }

        #endregion

        #region Modifying Entries

/* Modify not yet ready for public consumption.
   Direct modification of an entry should not overwrite original data before its read.
   Safe mode is trivial in this sense.
		public void Modify(ZipEntry original, ZipEntry updated)
		{
			if ( original == null ) {
				throw new ArgumentNullException("original");
			}

			if ( updated == null ) {
				throw new ArgumentNullException("updated");
			}

			CheckUpdating();
			contentsEdited_ = true;
			updates_.Add(new ZipUpdate(original, updated));
		}
*/

        #endregion

        #region Deleting Entries

        /// <summary>
        /// Delete a <see cref="ZipEntry"/> from the archive.
        /// </summary>
        /// <param name="entry">The entry to delete.</param>
        public void Delete(ZipEntry entry)
        {
            if (entry == null)
            {
                throw new ArgumentNullException("entry");
            }

            CheckUpdating();

            int index = FindExistingUpdate(entry);
            if (index >= 0)
            {
                contentsEdited_ = true;
                updates_[index] = null;
                updateCount_ -= 1;
            }
            else
            {
                throw new ZipException("Cannot find entry to delete");
            }
        }

        #endregion

        #region Update Support

        #region Writing Values/Headers

        private void WriteLEShort(int value)
        {
            baseStream_.WriteByte((byte) (value & 0xff));
            baseStream_.WriteByte((byte) ((value >> 8) & 0xff));
        }

        /// <summary>
        /// Write an unsigned short in little endian byte order.
        /// </summary>
        private void WriteLEUshort(ushort value)
        {
            baseStream_.WriteByte((byte) (value & 0xff));
            baseStream_.WriteByte((byte) (value >> 8));
        }

        /// <summary>
        /// Write an int in little endian byte order.
        /// </summary>
        private void WriteLEInt(int value)
        {
            WriteLEShort(value & 0xffff);
            WriteLEShort(value >> 16);
        }

        /// <summary>
        /// Write an unsigned int in little endian byte order.
        /// </summary>
        private void WriteLEUint(uint value)
        {
            WriteLEUshort((ushort) (value & 0xffff));
            WriteLEUshort((ushort) (value >> 16));
        }

        /// <summary>
        /// Write a long in little endian byte order.
        /// </summary>
        private void WriteLeLong(long value)
        {
            WriteLEInt((int) (value & 0xffffffff));
            WriteLEInt((int) (value >> 32));
        }

        private void WriteLocalEntryHeader(ZipUpdate update)
        {
            ZipEntry entry = update.OutEntry;

            // TODO: Local offset will require adjusting for multi-disk zip files.
            entry.Offset = baseStream_.Position;

            // TODO: Need to clear any entry flags that dont make sense or throw an exception here.
            if (update.Command != UpdateCommand.Copy)
            {
                if (entry.CompressionMethod == CompressionMethod.Deflated)
                {
                    if (entry.Size == 0)
                    {
                        // No need to compress - no data.
                        entry.CompressedSize = entry.Size;
                        entry.Crc = 0;
                        entry.CompressionMethod = CompressionMethod.Stored;
                    }
                }
                else if (entry.CompressionMethod == CompressionMethod.Stored)
                {
                    entry.Flags &= ~(int) GeneralBitFlags.Descriptor;
                }

                switch (useZip64_)
                {
                    case UseZip64.Dynamic:
                        if (entry.Size < 0)
                        {
                            entry.ForceZip64();
                        }
                        break;

                    case UseZip64.On:
                        entry.ForceZip64();
                        break;

                    case UseZip64.Off:
                        // Do nothing.  The entry itself may be using Zip64 independantly.
                        break;
                }
            }

            // Write the local file header
            WriteLEInt(ZipConstants.LocalHeaderSignature);

            WriteLEShort(entry.Version);
            WriteLEShort(entry.Flags);

            WriteLEShort((byte) entry.CompressionMethod);
            WriteLEInt((int) entry.DosTime);

            if (!entry.HasCrc)
            {
                // Note patch address for updating CRC later.
                update.CrcPatchOffset = baseStream_.Position;
                WriteLEInt(0);
            }
            else
            {
                WriteLEInt(unchecked((int) entry.Crc));
            }

            if (entry.LocalHeaderRequiresZip64)
            {
                WriteLEInt(-1);
                WriteLEInt(-1);
            }
            else
            {
                if ((entry.CompressedSize < 0) || (entry.Size < 0))
                {
                    update.SizePatchOffset = baseStream_.Position;
                }

                WriteLEInt((int) entry.CompressedSize);
                WriteLEInt((int) entry.Size);
            }

            byte[] name = ZipConstants.ConvertToArray(entry.Flags, entry.Name);

            if (name.Length > 0xFFFF)
            {
                throw new ZipException("Entry name too long.");
            }

            var ed = new ZipExtraData(entry.ExtraData);

            if (entry.LocalHeaderRequiresZip64)
            {
                ed.StartNewEntry();

                // Local entry header always includes size and compressed size.
                // NOTE the order of these fields is reversed when compared to the normal headers!
                ed.AddLeLong(entry.Size);
                ed.AddLeLong(entry.CompressedSize);
                ed.AddNewEntry(1);
            }
            else
            {
                ed.Delete(1);
            }

            entry.ExtraData = ed.GetEntryData();

            WriteLEShort(name.Length);
            WriteLEShort(entry.ExtraData.Length);

            if (name.Length > 0)
            {
                baseStream_.Write(name, 0, name.Length);
            }

            if (entry.LocalHeaderRequiresZip64)
            {
                if (!ed.Find(1))
                {
                    throw new ZipException("Internal error cannot find extra data");
                }

                update.SizePatchOffset = baseStream_.Position + ed.CurrentReadIndex;
            }

            if (entry.ExtraData.Length > 0)
            {
                baseStream_.Write(entry.ExtraData, 0, entry.ExtraData.Length);
            }
        }

        private int WriteCentralDirectoryHeader(ZipEntry entry)
        {
            if (entry.CompressedSize < 0)
            {
                throw new ZipException("Attempt to write central directory entry with unknown csize");
            }

            if (entry.Size < 0)
            {
                throw new ZipException("Attempt to write central directory entry with unknown size");
            }

            if (entry.Crc < 0)
            {
                throw new ZipException("Attempt to write central directory entry with unknown crc");
            }

            // Write the central file header
            WriteLEInt(ZipConstants.CentralHeaderSignature);

            // Version made by
            WriteLEShort(ZipConstants.VersionMadeBy);

            // Version required to extract
            WriteLEShort(entry.Version);

            WriteLEShort(entry.Flags);

            unchecked
            {
                WriteLEShort((byte) entry.CompressionMethod);
                WriteLEInt((int) entry.DosTime);
                WriteLEInt((int) entry.Crc);
            }

            if ((entry.IsZip64Forced()) || (entry.CompressedSize >= 0xffffffff))
            {
                WriteLEInt(-1);
            }
            else
            {
                WriteLEInt((int) (entry.CompressedSize & 0xffffffff));
            }

            if ((entry.IsZip64Forced()) || (entry.Size >= 0xffffffff))
            {
                WriteLEInt(-1);
            }
            else
            {
                WriteLEInt((int) entry.Size);
            }

            byte[] name = ZipConstants.ConvertToArray(entry.Flags, entry.Name);

            if (name.Length > 0xFFFF)
            {
                throw new ZipException("Entry name is too long.");
            }

            WriteLEShort(name.Length);

            // Central header extra data is different to local header version so regenerate.
            var ed = new ZipExtraData(entry.ExtraData);

            if (entry.CentralHeaderRequiresZip64)
            {
                ed.StartNewEntry();

                if ((entry.Size >= 0xffffffff) || (useZip64_ == UseZip64.On))
                {
                    ed.AddLeLong(entry.Size);
                }

                if ((entry.CompressedSize >= 0xffffffff) || (useZip64_ == UseZip64.On))
                {
                    ed.AddLeLong(entry.CompressedSize);
                }

                if (entry.Offset >= 0xffffffff)
                {
                    ed.AddLeLong(entry.Offset);
                }

                // Number of disk on which this file starts isnt supported and is never written here.
                ed.AddNewEntry(1);
            }
            else
            {
                // Should have already be done when local header was added.
                ed.Delete(1);
            }

            byte[] centralExtraData = ed.GetEntryData();

            WriteLEShort(centralExtraData.Length);
            WriteLEShort(entry.Comment != null ? entry.Comment.Length : 0);

            WriteLEShort(0); // disk number
            WriteLEShort(0); // internal file attributes

            // External file attributes...
            if (entry.ExternalFileAttributes != -1)
            {
                WriteLEInt(entry.ExternalFileAttributes);
            }
            else
            {
                if (entry.IsDirectory)
                {
                    WriteLEUint(16);
                }
                else
                {
                    WriteLEUint(0);
                }
            }

            if (entry.Offset >= 0xffffffff)
            {
                WriteLEUint(0xffffffff);
            }
            else
            {
                WriteLEUint((uint) (int) entry.Offset);
            }

            if (name.Length > 0)
            {
                baseStream_.Write(name, 0, name.Length);
            }

            if (centralExtraData.Length > 0)
            {
                baseStream_.Write(centralExtraData, 0, centralExtraData.Length);
            }

            byte[] rawComment = (entry.Comment != null) ? Encoding.ASCII.GetBytes(entry.Comment) : new byte[0];

            if (rawComment.Length > 0)
            {
                baseStream_.Write(rawComment, 0, rawComment.Length);
            }

            return ZipConstants.CentralHeaderBaseSize + name.Length + centralExtraData.Length + rawComment.Length;
        }

        #endregion

        private void PostUpdateCleanup()
        {
            if (archiveStorage_ != null)
            {
                archiveStorage_.Dispose();
                archiveStorage_ = null;
            }

            updateDataSource_ = null;
            updates_ = null;
            updateIndex_ = null;
        }

        private string GetTransformedFileName(string name)
        {
            return (NameTransform != null)
                       ? NameTransform.TransformFile(name)
                       : name;
        }

        /// <summary>
        /// Get a raw memory buffer.
        /// </summary>
        /// <returns>Returns a raw memory buffer.</returns>
        private byte[] GetBuffer()
        {
            if (copyBuffer_ == null)
            {
                copyBuffer_ = new byte[bufferSize_];
            }
            return copyBuffer_;
        }

        private void CopyDescriptorBytes(ZipUpdate update, Stream dest, Stream source)
        {
            int bytesToCopy = GetDescriptorSize(update);

            if (bytesToCopy > 0)
            {
                byte[] buffer = GetBuffer();

                while (bytesToCopy > 0)
                {
                    int readSize = Math.Min(buffer.Length, bytesToCopy);

                    int bytesRead = source.Read(buffer, 0, readSize);
                    if (bytesRead > 0)
                    {
                        dest.Write(buffer, 0, bytesRead);
                        bytesToCopy -= bytesRead;
                    }
                    else
                    {
                        throw new ZipException("Unxpected end of stream");
                    }
                }
            }
        }

        private void CopyBytes(ZipUpdate update, Stream destination, Stream source,
                               long bytesToCopy, bool updateCrc)
        {
            if (destination == source)
            {
                throw new InvalidOperationException("Destination and source are the same");
            }

            // NOTE: Compressed size is updated elsewhere.
            var crc = new Crc32();
            byte[] buffer = GetBuffer();

            long targetBytes = bytesToCopy;
            long totalBytesRead = 0;

            int bytesRead;
            do
            {
                int readSize = buffer.Length;

                if (bytesToCopy < readSize)
                {
                    readSize = (int) bytesToCopy;
                }

                bytesRead = source.Read(buffer, 0, readSize);
                if (bytesRead > 0)
                {
                    if (updateCrc)
                    {
                        crc.Update(buffer, 0, bytesRead);
                    }
                    destination.Write(buffer, 0, bytesRead);
                    bytesToCopy -= bytesRead;
                    totalBytesRead += bytesRead;
                }
            } while ((bytesRead > 0) && (bytesToCopy > 0));

            if (totalBytesRead != targetBytes)
            {
                throw new ZipException(string.Format("Failed to copy bytes expected {0} read {1}", targetBytes,
                                                     totalBytesRead));
            }

            if (updateCrc)
            {
                update.OutEntry.Crc = crc.Value;
            }
        }

        /// <summary>
        /// Get the size of the source descriptor for a <see cref="ZipUpdate"/>.
        /// </summary>
        /// <param name="update">The update to get the size for.</param>
        /// <returns>The descriptor size, zero if there isnt one.</returns>
        private static int GetDescriptorSize(ZipUpdate update)
        {
            int result = 0;
            if ((update.Entry.Flags & (int) GeneralBitFlags.Descriptor) != 0)
            {
                result = ZipConstants.DataDescriptorSize - 4;
                if (update.Entry.LocalHeaderRequiresZip64)
                {
                    result = ZipConstants.Zip64DataDescriptorSize - 4;
                }
            }
            return result;
        }

        private void CopyDescriptorBytesDirect(ZipUpdate update, Stream stream, ref long destinationPosition,
                                               long sourcePosition)
        {
            int bytesToCopy = GetDescriptorSize(update);

            while (bytesToCopy > 0)
            {
                int readSize = bytesToCopy;
                byte[] buffer = GetBuffer();

                stream.Position = sourcePosition;
                int bytesRead = stream.Read(buffer, 0, readSize);
                if (bytesRead > 0)
                {
                    stream.Position = destinationPosition;
                    stream.Write(buffer, 0, bytesRead);
                    bytesToCopy -= bytesRead;
                    destinationPosition += bytesRead;
                    sourcePosition += bytesRead;
                }
                else
                {
                    throw new ZipException("Unxpected end of stream");
                }
            }
        }

        private void CopyEntryDataDirect(ZipUpdate update, Stream stream, bool updateCrc, ref long destinationPosition,
                                         ref long sourcePosition)
        {
            long bytesToCopy = update.Entry.CompressedSize;

            // NOTE: Compressed size is updated elsewhere.
            var crc = new Crc32();
            byte[] buffer = GetBuffer();

            long targetBytes = bytesToCopy;
            long totalBytesRead = 0;

            int bytesRead;
            do
            {
                int readSize = buffer.Length;

                if (bytesToCopy < readSize)
                {
                    readSize = (int) bytesToCopy;
                }

                stream.Position = sourcePosition;
                bytesRead = stream.Read(buffer, 0, readSize);
                if (bytesRead > 0)
                {
                    if (updateCrc)
                    {
                        crc.Update(buffer, 0, bytesRead);
                    }
                    stream.Position = destinationPosition;
                    stream.Write(buffer, 0, bytesRead);

                    destinationPosition += bytesRead;
                    sourcePosition += bytesRead;
                    bytesToCopy -= bytesRead;
                    totalBytesRead += bytesRead;
                }
            } while ((bytesRead > 0) && (bytesToCopy > 0));

            if (totalBytesRead != targetBytes)
            {
                throw new ZipException(string.Format("Failed to copy bytes expected {0} read {1}", targetBytes,
                                                     totalBytesRead));
            }

            if (updateCrc)
            {
                update.OutEntry.Crc = crc.Value;
            }
        }

        private int FindExistingUpdate(ZipEntry entry)
        {
            int result = -1;
            string convertedName = GetTransformedFileName(entry.Name);

            if (updateIndex_.ContainsKey(convertedName))
            {
                result = (int) updateIndex_[convertedName];
            }
/*
			// This is slow like the coming of the next ice age but takes less storage and may be useful
			// for CF?
			for (int index = 0; index < updates_.Count; ++index)
			{
				ZipUpdate zu = ( ZipUpdate )updates_[index];
				if ( (zu.Entry.ZipFileIndex == entry.ZipFileIndex) &&
					(string.Compare(convertedName, zu.Entry.Name, true, CultureInfo.InvariantCulture) == 0) ) {
					result = index;
					break;
				}
			}
 */
            return result;
        }

        private int FindExistingUpdate(string fileName)
        {
            int result = -1;

            string convertedName = GetTransformedFileName(fileName);

            if (updateIndex_.ContainsKey(convertedName))
            {
                result = (int) updateIndex_[convertedName];
            }

/*
			// This is slow like the coming of the next ice age but takes less storage and may be useful
			// for CF?
			for ( int index = 0; index < updates_.Count; ++index ) {
				if ( string.Compare(convertedName, (( ZipUpdate )updates_[index]).Entry.Name,
					true, CultureInfo.InvariantCulture) == 0 ) {
					result = index;
					break;
				}
			}
 */

            return result;
        }

        /// <summary>
        /// Get an output stream for the specified <see cref="ZipEntry"/>
        /// </summary>
        /// <param name="entry">The entry to get an output stream for.</param>
        /// <returns>The output stream obtained for the entry.</returns>
        private Stream GetOutputStream(ZipEntry entry)
        {
            Stream result = baseStream_;

            switch (entry.CompressionMethod)
            {
                case CompressionMethod.Stored:
                    result = new UncompressedStream(result);
                    break;

                case CompressionMethod.Deflated:
                    var dos = new DeflaterOutputStream(result, new Deflater(9, true));
                    dos.IsStreamOwner = false;
                    result = dos;
                    break;

                default:
                    throw new ZipException("Unknown compression method " + entry.CompressionMethod);
            }
            return result;
        }

        private void AddEntry(ZipFile workFile, ZipUpdate update)
        {
            Stream source = null;

            if (update.Entry.IsFile)
            {
                source = update.GetSource();

                if (source == null)
                {
                    source = updateDataSource_.GetSource(update.Entry, null);
                }
            }

            if (source != null)
            {
                using (source)
                {
                    long sourceStreamLength = source.Length;
                    if (update.OutEntry.Size < 0)
                    {
                        update.OutEntry.Size = sourceStreamLength;
                    }
                    else
                    {
                        // Check for errant entries.
                        if (update.OutEntry.Size != sourceStreamLength)
                        {
                            throw new ZipException("Entry size/stream size mismatch");
                        }
                    }

                    workFile.WriteLocalEntryHeader(update);

                    long dataStart = workFile.baseStream_.Position;

                    using (Stream output = workFile.GetOutputStream(update.OutEntry))
                    {
                        CopyBytes(update, output, source, sourceStreamLength, true);
                    }

                    long dataEnd = workFile.baseStream_.Position;
                    update.OutEntry.CompressedSize = dataEnd - dataStart;

                    if ((update.OutEntry.Flags & (int) GeneralBitFlags.Descriptor) == (int) GeneralBitFlags.Descriptor)
                    {
                        var helper = new ZipHelperStream(workFile.baseStream_);
                        helper.WriteDataDescriptor(update.OutEntry);
                    }
                }
            }
            else
            {
                workFile.WriteLocalEntryHeader(update);
                update.OutEntry.CompressedSize = 0;
            }
        }

        private static void ModifyEntry(ZipFile workFile, ZipUpdate update)
        {
            workFile.WriteLocalEntryHeader(update);
            long dataStart = workFile.baseStream_.Position;

            long dataEnd = workFile.baseStream_.Position;
            update.Entry.CompressedSize = dataEnd - dataStart;
        }

        private void CopyEntryDirect(ZipFile workFile, ZipUpdate update, ref long destinationPosition)
        {
            bool skipOver = false;
            if (update.Entry.Offset == destinationPosition)
            {
                skipOver = true;
            }

            if (!skipOver)
            {
                baseStream_.Position = destinationPosition;
                workFile.WriteLocalEntryHeader(update);
                destinationPosition = baseStream_.Position;
            }

            long sourcePosition = 0;

            const int NameLengthOffset = 26;

            // TODO: Add base for SFX friendly handling
            long entryDataOffset = update.Entry.Offset + NameLengthOffset;

            baseStream_.Seek(entryDataOffset, SeekOrigin.Begin);

            // Clumsy way of handling retrieving the original name and extra data length for now.
            // TODO: Stop re-reading name and data length in CopyEntryDirect.
            uint nameLength = ReadLEUshort();
            uint extraLength = ReadLEUshort();

            sourcePosition = baseStream_.Position + nameLength + extraLength;

            if (skipOver)
            {
                destinationPosition +=
                    (sourcePosition - entryDataOffset) + NameLengthOffset + // Header size
                    update.Entry.CompressedSize + GetDescriptorSize(update);
            }
            else
            {
                if (update.Entry.CompressedSize > 0)
                {
                    CopyEntryDataDirect(update, baseStream_, false, ref destinationPosition, ref sourcePosition);
                }
                CopyDescriptorBytesDirect(update, baseStream_, ref destinationPosition, sourcePosition);
            }
        }

        private void CopyEntry(ZipFile workFile, ZipUpdate update)
        {
            workFile.WriteLocalEntryHeader(update);

            if (update.Entry.CompressedSize > 0)
            {
                const int NameLengthOffset = 26;

                long entryDataOffset = update.Entry.Offset + NameLengthOffset;

                // TODO: This wont work for SFX files!
                baseStream_.Seek(entryDataOffset, SeekOrigin.Begin);

                uint nameLength = ReadLEUshort();
                uint extraLength = ReadLEUshort();

                baseStream_.Seek(nameLength + extraLength, SeekOrigin.Current);

                CopyBytes(update, workFile.baseStream_, baseStream_, update.Entry.CompressedSize, false);
            }
            CopyDescriptorBytes(update, workFile.baseStream_, baseStream_);
        }

        private void Reopen(Stream source)
        {
            if (source == null)
            {
                throw new ZipException("Failed to reopen archive - no source");
            }

            isNewArchive_ = false;
            baseStream_ = source;
            ReadEntries();
        }

        /// <summary>
        /// Class used to sort updates.
        /// </summary>
        private class UpdateComparer : IComparer
        {
            /// <summary>
            /// Compares two objects and returns a value indicating whether one is 
            /// less than, equal to or greater than the other.
            /// </summary>
            /// <param name="x">First object to compare</param>
            /// <param name="y">Second object to compare.</param>
            /// <returns>Compare result.</returns>
            public int Compare(
                object x,
                object y)
            {
                var zx = x as ZipUpdate;
                var zy = y as ZipUpdate;

                int result;

                if (zx == null)
                {
                    if (zy == null)
                    {
                        result = 0;
                    }
                    else
                    {
                        result = -1;
                    }
                }
                else if (zy == null)
                {
                    result = 1;
                }
                else
                {
                    int xCmdValue = ((zx.Command == UpdateCommand.Copy) || (zx.Command == UpdateCommand.Modify)) ? 0 : 1;
                    int yCmdValue = ((zy.Command == UpdateCommand.Copy) || (zy.Command == UpdateCommand.Modify)) ? 0 : 1;

                    result = xCmdValue - yCmdValue;
                    if (result == 0)
                    {
                        long offsetDiff = zx.Entry.Offset - zy.Entry.Offset;
                        if (offsetDiff < 0)
                        {
                            result = -1;
                        }
                        else if (offsetDiff == 0)
                        {
                            result = 0;
                        }
                        else
                        {
                            result = 1;
                        }
                    }
                }
                return result;
            }
        }

        private void RunUpdates()
        {
            long sizeEntries = 0;
            long endOfStream = 0;
            bool allOk = true;
            bool directUpdate = false;
            long destinationPosition = 0; // NOT SFX friendly

            ZipFile workFile;

            if (IsNewArchive)
            {
                workFile = this;
                workFile.baseStream_.Position = 0;
                directUpdate = true;
            }
            else if (archiveStorage_.UpdateMode == FileUpdateMode.Direct)
            {
                workFile = this;
                workFile.baseStream_.Position = 0;
                directUpdate = true;

                // Sort the updates by offset within copies/modifies, then adds.
                // This ensures that data required by copies will not be overwritten.
                updates_.Sort(new UpdateComparer());
            }
            else
            {
                workFile = Create(archiveStorage_.GetTemporaryOutput());
                workFile.UseZip64 = UseZip64;

                if (key != null)
                {
                    workFile.key = (byte[]) key.Clone();
                }
            }

            try
            {
                foreach (ZipUpdate update in updates_)
                {
                    if (update != null)
                    {
                        switch (update.Command)
                        {
                            case UpdateCommand.Copy:
                                if (directUpdate)
                                {
                                    CopyEntryDirect(workFile, update, ref destinationPosition);
                                }
                                else
                                {
                                    CopyEntry(workFile, update);
                                }
                                break;

                            case UpdateCommand.Modify:
                                // TODO: Direct modifying of an entry will take some legwork.
                                ModifyEntry(workFile, update);
                                break;

                            case UpdateCommand.Add:
                                if (!IsNewArchive && directUpdate)
                                {
                                    workFile.baseStream_.Position = destinationPosition;
                                }

                                AddEntry(workFile, update);

                                if (directUpdate)
                                {
                                    destinationPosition = workFile.baseStream_.Position;
                                }
                                break;
                        }
                    }
                }

                if (!IsNewArchive && directUpdate)
                {
                    workFile.baseStream_.Position = destinationPosition;
                }

                long centralDirOffset = workFile.baseStream_.Position;

                foreach (ZipUpdate update in updates_)
                {
                    if (update != null)
                    {
                        sizeEntries += workFile.WriteCentralDirectoryHeader(update.OutEntry);
                    }
                }

                byte[] theComment = ZipConstants.ConvertToArray(comment_);
                using (var zhs = new ZipHelperStream(workFile.baseStream_))
                {
                    zhs.WriteEndOfCentralDirectory(updateCount_, sizeEntries, centralDirOffset, theComment);
                }

                endOfStream = workFile.baseStream_.Position;

                // And now patch entries...
                foreach (ZipUpdate update in updates_)
                {
                    if (update != null)
                    {
                        // If the size of the entry is zero leave the crc as 0 as well.
                        // The calculated crc will be all bits on...
                        if ((update.CrcPatchOffset > 0) && (update.OutEntry.CompressedSize > 0))
                        {
                            workFile.baseStream_.Position = update.CrcPatchOffset;
                            workFile.WriteLEInt((int) update.OutEntry.Crc);
                        }

                        if (update.SizePatchOffset > 0)
                        {
                            workFile.baseStream_.Position = update.SizePatchOffset;
                            if (update.OutEntry.LocalHeaderRequiresZip64)
                            {
                                workFile.WriteLeLong(update.OutEntry.Size);
                                workFile.WriteLeLong(update.OutEntry.CompressedSize);
                            }
                            else
                            {
                                workFile.WriteLEInt((int) update.OutEntry.CompressedSize);
                                workFile.WriteLEInt((int) update.OutEntry.Size);
                            }
                        }
                    }
                }
            }
            catch (Exception)
            {
                allOk = false;
            }
            finally
            {
                if (directUpdate)
                {
                    if (allOk)
                    {
                        workFile.baseStream_.Flush();
                        workFile.baseStream_.SetLength(endOfStream);
                    }
                }
                else
                {
                    workFile.Close();
                }
            }

            if (allOk)
            {
                if (directUpdate)
                {
                    isNewArchive_ = false;
                    workFile.baseStream_.Flush();
                    ReadEntries();
                }
                else
                {
                    baseStream_.Close();
                    Reopen(archiveStorage_.ConvertTemporaryToFinal());
                }
            }
            else
            {
                workFile.Close();
                if (!directUpdate && (workFile.Name != null))
                {
                    File.Delete(workFile.Name);
                }
            }
        }

        private void CheckUpdating()
        {
            if (updates_ == null)
            {
                throw new InvalidOperationException("BeginUpdate has not been called");
            }
        }

        #endregion

        #region ZipUpdate class

        /// <summary>
        /// Represents a pending update to a Zip file.
        /// </summary>
        private class ZipUpdate
        {
            #region Constructors

            public ZipUpdate(IStaticDataSource dataSource, ZipEntry entry)
            {
                command_ = UpdateCommand.Add;
                entry_ = entry;
                dataSource_ = dataSource;
            }

            public ZipUpdate(UpdateCommand command, ZipEntry entry)
            {
                command_ = command;
                entry_ = (ZipEntry) entry.Clone();
            }


            /// <summary>
            /// Copy an existing entry.
            /// </summary>
            /// <param name="entry">The existing entry to copy.</param>
            public ZipUpdate(ZipEntry entry)
                : this(UpdateCommand.Copy, entry)
            {
                // Do nothing.
            }

            #endregion

            /// <summary>
            /// Get the <see cref="ZipEntry"/> for this update.
            /// </summary>
            /// <remarks>This is the source or original entry.</remarks>
            public ZipEntry Entry
            {
                get { return entry_; }
            }

            /// <summary>
            /// Get the <see cref="ZipEntry"/> that will be written to the updated/new file.
            /// </summary>
            public ZipEntry OutEntry
            {
                get
                {
                    if (outEntry_ == null)
                    {
                        outEntry_ = (ZipEntry) entry_.Clone();
                    }

                    return outEntry_;
                }
            }

            /// <summary>
            /// Get the command for this update.
            /// </summary>
            public UpdateCommand Command
            {
                get { return command_; }
            }

            /// <summary>
            /// Get/set the location of the size patch for this update.
            /// </summary>
            public long SizePatchOffset
            {
                get { return sizePatchOffset_; }
                set { sizePatchOffset_ = value; }
            }

            /// <summary>
            /// Get /set the location of the crc patch for this update.
            /// </summary>
            public long CrcPatchOffset
            {
                get { return crcPatchOffset_; }
                set { crcPatchOffset_ = value; }
            }

            public Stream GetSource()
            {
                Stream result = null;
                if (dataSource_ != null)
                {
                    result = dataSource_.GetSource();
                }

                return result;
            }

            #region Instance Fields

            private readonly ZipEntry entry_;
            private ZipEntry outEntry_;
            private readonly UpdateCommand command_;
            private readonly IStaticDataSource dataSource_;
            private long sizePatchOffset_ = -1;
            private long crcPatchOffset_ = -1;

            #endregion
        }

        #endregion

        #endregion

        #region Disposing

        #region IDisposable Members

        void IDisposable.Dispose()
        {
            Close();
        }

        #endregion

        private void DisposeInternal()
        {
            if (!isDisposed_)
            {
                isDisposed_ = true;
                entries_ = new ZipEntry[0];

                if (IsStreamOwner && (baseStream_ != null))
                {
                    lock (baseStream_)
                    {
                        baseStream_.Close();
                    }
                }

                PostUpdateCleanup();
            }
        }

        /// <summary>
        /// Releases the unmanaged resources used by the this instance and optionally releases the managed resources.
        /// </summary>
        /// <param name="disposing">true to release both managed and unmanaged resources;
        /// false to release only unmanaged resources.</param>
        protected virtual void Dispose(bool disposing)
        {
            DisposeInternal();
        }

        #endregion

        #region Internal routines

        #region Reading

        /// <summary>
        /// Read an unsigned short in little endian byte order.
        /// </summary>
        /// <returns>Returns the value read.</returns>
        /// <exception cref="EndOfStreamException">
        /// The stream ends prematurely
        /// </exception>
        private ushort ReadLEUshort()
        {
            int data1 = baseStream_.ReadByte();

            if (data1 < 0)
            {
                throw new EndOfStreamException("End of stream");
            }

            int data2 = baseStream_.ReadByte();

            if (data2 < 0)
            {
                throw new EndOfStreamException("End of stream");
            }


            return unchecked((ushort) ((ushort) data1 | (ushort) (data2 << 8)));
        }

        /// <summary>
        /// Read a uint in little endian byte order.
        /// </summary>
        /// <returns>Returns the value read.</returns>
        /// <exception cref="IOException">
        /// An i/o error occurs.
        /// </exception>
        /// <exception cref="System.IO.EndOfStreamException">
        /// The file ends prematurely
        /// </exception>
        private uint ReadLEUint()
        {
            return (uint) (ReadLEUshort() | (ReadLEUshort() << 16));
        }

        private ulong ReadLEUlong()
        {
            return ReadLEUint() | ((ulong) ReadLEUint() << 32);
        }

        #endregion

        // NOTE this returns the offset of the first byte after the signature.
        private long LocateBlockWithSignature(int signature, long endLocation, int minimumBlockSize,
                                              int maximumVariableData)
        {
            using (var les = new ZipHelperStream(baseStream_))
            {
                return les.LocateBlockWithSignature(signature, endLocation, minimumBlockSize, maximumVariableData);
            }
        }

        /// <summary>
        /// Search for and read the central directory of a zip file filling the entries array.
        /// </summary>
        /// <exception cref="System.IO.IOException">
        /// An i/o error occurs.
        /// </exception>
        /// <exception cref="ICSharpCode.SharpZipLib.Zip.ZipException">
        /// The central directory is malformed or cannot be found
        /// </exception>
        private void ReadEntries()
        {
            // Search for the End Of Central Directory.  When a zip comment is
            // present the directory will start earlier
            // 
            // The search is limited to 64K which is the maximum size of a trailing comment field to aid speed.
            // This should be compatible with both SFX and ZIP files but has only been tested for Zip files
            // If a SFX file has the Zip data attached as a resource and there are other resources occuring later then
            // this could be invalid.
            // Could also speed this up by reading memory in larger blocks.			

            if (baseStream_.CanSeek == false)
            {
                throw new ZipException("ZipFile stream must be seekable");
            }

            long locatedEndOfCentralDir = LocateBlockWithSignature(ZipConstants.EndOfCentralDirectorySignature,
                                                                   baseStream_.Length,
                                                                   ZipConstants.EndOfCentralRecordBaseSize, 0xffff);

            if (locatedEndOfCentralDir < 0)
            {
                throw new ZipException("Cannot find central directory");
            }

            // Read end of central directory record
            ushort thisDiskNumber = ReadLEUshort();
            ushort startCentralDirDisk = ReadLEUshort();
            ulong entriesForThisDisk = ReadLEUshort();
            ulong entriesForWholeCentralDir = ReadLEUshort();
            ulong centralDirSize = ReadLEUint();
            long offsetOfCentralDir = ReadLEUint();
            uint commentSize = ReadLEUshort();

            if (commentSize > 0)
            {
                var comment = new byte[commentSize];

                StreamUtils.ReadFully(baseStream_, comment);
                comment_ = ZipConstants.ConvertToString(comment);
            }
            else
            {
                comment_ = string.Empty;
            }

            bool isZip64 = false;

            // Check if zip64 header information is required.
            if ((thisDiskNumber == 0xffff) ||
                (startCentralDirDisk == 0xffff) ||
                (entriesForThisDisk == 0xffff) ||
                (entriesForWholeCentralDir == 0xffff) ||
                (centralDirSize == 0xffffffff) ||
                (offsetOfCentralDir == 0xffffffff))
            {
                isZip64 = true;

                long offset = LocateBlockWithSignature(ZipConstants.Zip64CentralDirLocatorSignature,
                                                       locatedEndOfCentralDir, 0, 0x1000);
                if (offset < 0)
                {
                    throw new ZipException("Cannot find Zip64 locator");
                }

                // number of the disk with the start of the zip64 end of central directory 4 bytes 
                // relative offset of the zip64 end of central directory record 8 bytes 
                // total number of disks 4 bytes 
                ReadLEUint(); // startDisk64 is not currently used
                ulong offset64 = ReadLEUlong();
                ReadLEUint();

                baseStream_.Position = (long) offset64;
                long sig64 = ReadLEUint();

                if (sig64 != ZipConstants.Zip64CentralFileHeaderSignature)
                {
                    throw new ZipException(string.Format("Invalid Zip64 Central directory signature at {0:X}", offset64));
                }

                // NOTE: Record size = SizeOfFixedFields + SizeOfVariableData - 12.
                ReadLEUlong();
                ReadLEUshort();
                ReadLEUshort();
                ReadLEUint();
                ReadLEUint();
                entriesForThisDisk = ReadLEUlong();
                entriesForWholeCentralDir = ReadLEUlong();
                centralDirSize = ReadLEUlong();
                offsetOfCentralDir = (long) ReadLEUlong();

                // NOTE: zip64 extensible data sector (variable size) is ignored.
            }

            entries_ = new ZipEntry[entriesForThisDisk];

            // SFX/embedded support, find the offset of the first entry vis the start of the stream
            // This applies to Zip files that are appended to the end of an SFX stub.
            // Or are appended as a resource to an executable.
            // Zip files created by some archivers have the offsets altered to reflect the true offsets
            // and so dont require any adjustment here...
            // TODO: Difficulty with Zip64 and SFX offset handling needs resolution - maths?
            if (!isZip64 && (offsetOfCentralDir < locatedEndOfCentralDir - (4 + (long) centralDirSize)))
            {
                offsetOfFirstEntry = locatedEndOfCentralDir - (4 + (long) centralDirSize + offsetOfCentralDir);
                if (offsetOfFirstEntry <= 0)
                {
                    throw new ZipException("Invalid embedded zip archive");
                }
            }

            baseStream_.Seek(offsetOfFirstEntry + offsetOfCentralDir, SeekOrigin.Begin);

            for (ulong i = 0; i < entriesForThisDisk; i++)
            {
                if (ReadLEUint() != ZipConstants.CentralHeaderSignature)
                {
                    throw new ZipException("Wrong Central Directory signature");
                }

                int versionMadeBy = ReadLEUshort();
                int versionToExtract = ReadLEUshort();
                int bitFlags = ReadLEUshort();
                int method = ReadLEUshort();
                uint dostime = ReadLEUint();
                uint crc = ReadLEUint();
                long csize = ReadLEUint();
                long size = ReadLEUint();
                int nameLen = ReadLEUshort();
                int extraLen = ReadLEUshort();
                int commentLen = ReadLEUshort();

                ReadLEUshort(); // Not currently used
                ReadLEUshort(); // Not currently used

                uint externalAttributes = ReadLEUint();
                long offset = ReadLEUint();

                var buffer = new byte[Math.Max(nameLen, commentLen)];

                StreamUtils.ReadFully(baseStream_, buffer, 0, nameLen);
                string name = ZipConstants.ConvertToStringExt(bitFlags, buffer, nameLen);

                var entry = new ZipEntry(name, versionToExtract, versionMadeBy, (CompressionMethod) method);
                entry.Crc = crc & 0xffffffffL;
                entry.Size = size & 0xffffffffL;
                entry.CompressedSize = csize & 0xffffffffL;
                entry.Flags = bitFlags;
                entry.DosTime = dostime;
                entry.ZipFileIndex = (long) i;
                entry.Offset = offset;
                entry.ExternalFileAttributes = (int) externalAttributes;

                if (extraLen > 0)
                {
                    var extra = new byte[extraLen];
                    StreamUtils.ReadFully(baseStream_, extra);
                    entry.ExtraData = extra;
                }

                entry.ProcessExtraData(false);

                if (commentLen > 0)
                {
                    StreamUtils.ReadFully(baseStream_, buffer, 0, commentLen);
                    entry.Comment = ZipConstants.ConvertToStringExt(bitFlags, buffer, commentLen);
                }

                entries_[i] = entry;
            }
        }

        /// <summary>
        /// Locate the data for a given entry.
        /// </summary>
        /// <returns>
        /// The start offset of the data.
        /// </returns>
        /// <exception cref="System.IO.EndOfStreamException">
        /// The stream ends prematurely
        /// </exception>
        /// <exception cref="ICSharpCode.SharpZipLib.Zip.ZipException">
        /// The local header signature is invalid, the entry and central header file name lengths are different
        /// or the local and entry compression methods dont match
        /// </exception>
        private long LocateEntry(ZipEntry entry)
        {
            return TestLocalHeader(entry, HeaderTest.Extract);
        }

        #endregion

        #region Instance Fields

        private bool isDisposed_;
        private readonly string name_;
        private string comment_;
        private Stream baseStream_;
        private readonly bool isStreamOwner;
        private long offsetOfFirstEntry;
        private ZipEntry[] entries_;
        private byte[] key;
        private bool isNewArchive_;

        // Default is dynamic which is not backwards compatible and can cause problems
        // with XP's built in compression which cant read Zip64 archives.
        // However it does avoid the situation were a large file is added and cannot be completed correctly.
        // Hint: Set always ZipEntry size before they are added to an archive and this setting isnt needed.
        private UseZip64 useZip64_ = UseZip64.Dynamic;

        #region Zip Update Instance Fields

        private ArrayList updates_;
        private long updateCount_; // Count is managed manually as updates_ can contain nulls!
        private Hashtable updateIndex_;
        private IArchiveStorage archiveStorage_;
        private IDynamicDataSource updateDataSource_;
        private bool contentsEdited_;
        private int bufferSize_ = DefaultBufferSize;
        private byte[] copyBuffer_;
        private readonly IEntryFactory updateEntryFactory_ = new ZipEntryFactory();

        #endregion

        #endregion

        #region Support Classes

        /// <summary>
        /// An <see cref="IEnumerator">enumerator</see> for <see cref="ZipEntry">Zip entries</see>
        /// </summary>
        private class ZipEntryEnumerator : IEnumerator
        {
            #region Constructors

            public ZipEntryEnumerator(ZipEntry[] entries)
            {
                array = entries;
            }

            #endregion

            #region IEnumerator Members

            public object Current
            {
                get { return array[index]; }
            }

            public void Reset()
            {
                index = -1;
            }

            public bool MoveNext()
            {
                return (++index < array.Length);
            }

            #endregion

            #region Instance Fields

            private readonly ZipEntry[] array;
            private int index = -1;

            #endregion
        }

        /// <summary>
        /// An <see cref="UncompressedStream"/> is a stream that you can write uncompressed data
        /// to and flush, but cannot read, seek or do anything else to.
        /// </summary>
        private class UncompressedStream : Stream
        {
            #region Constructors

            public UncompressedStream(Stream baseStream)
            {
                baseStream_ = baseStream;
            }

            #endregion

            /// <summary>
            /// Close this stream instance.
            /// </summary>
            public override void Close()
            {
                // Do nothing
            }

            /// <summary>
            /// Gets a value indicating whether the current stream supports reading.
            /// </summary>
            public override bool CanRead
            {
                get { return false; }
            }

            /// <summary>
            /// Write any buffered data to underlying storage.
            /// </summary>
            public override void Flush()
            {
                baseStream_.Flush();
            }

            /// <summary>
            /// Gets a value indicating whether the current stream supports writing.
            /// </summary>
            public override bool CanWrite
            {
                get { return baseStream_.CanWrite; }
            }

            /// <summary>
            /// Gets a value indicating whether the current stream supports seeking.
            /// </summary>
            public override bool CanSeek
            {
                get { return false; }
            }

            /// <summary>
            /// Get the length in bytes of the stream.
            /// </summary>
            public override long Length
            {
                get { return 0; }
            }

            /// <summary>
            /// Gets or sets the position within the current stream.
            /// </summary>
            public override long Position
            {
                get { return baseStream_.Position; }

                set { }
            }

            /// <summary>
            /// Reads a sequence of bytes from the current stream and advances the position within the stream by the number of bytes read.
            /// </summary>
            /// <param name="buffer">An array of bytes. When this method returns, the buffer contains the specified byte array with the values between offset and (offset + count - 1) replaced by the bytes read from the current source.</param>
            /// <param name="offset">The zero-based byte offset in buffer at which to begin storing the data read from the current stream.</param>
            /// <param name="count">The maximum number of bytes to be read from the current stream.</param>
            /// <returns>
            /// The total number of bytes read into the buffer. This can be less than the number of bytes requested if that many bytes are not currently available, or zero (0) if the end of the stream has been reached.
            /// </returns>
            /// <exception cref="T:System.ArgumentException">The sum of offset and count is larger than the buffer length. </exception>
            /// <exception cref="T:System.ObjectDisposedException">Methods were called after the stream was closed. </exception>
            /// <exception cref="T:System.NotSupportedException">The stream does not support reading. </exception>
            /// <exception cref="T:System.ArgumentNullException">buffer is null. </exception>
            /// <exception cref="T:System.IO.IOException">An I/O error occurs. </exception>
            /// <exception cref="T:System.ArgumentOutOfRangeException">offset or count is negative. </exception>
            public override int Read(byte[] buffer, int offset, int count)
            {
                return 0;
            }

            /// <summary>
            /// Sets the position within the current stream.
            /// </summary>
            /// <param name="offset">A byte offset relative to the origin parameter.</param>
            /// <param name="origin">A value of type <see cref="T:System.IO.SeekOrigin"></see> indicating the reference point used to obtain the new position.</param>
            /// <returns>
            /// The new position within the current stream.
            /// </returns>
            /// <exception cref="T:System.IO.IOException">An I/O error occurs. </exception>
            /// <exception cref="T:System.NotSupportedException">The stream does not support seeking, such as if the stream is constructed from a pipe or console output. </exception>
            /// <exception cref="T:System.ObjectDisposedException">Methods were called after the stream was closed. </exception>
            public override long Seek(long offset, SeekOrigin origin)
            {
                return 0;
            }

            /// <summary>
            /// Sets the length of the current stream.
            /// </summary>
            /// <param name="value">The desired length of the current stream in bytes.</param>
            /// <exception cref="T:System.NotSupportedException">The stream does not support both writing and seeking, such as if the stream is constructed from a pipe or console output. </exception>
            /// <exception cref="T:System.IO.IOException">An I/O error occurs. </exception>
            /// <exception cref="T:System.ObjectDisposedException">Methods were called after the stream was closed. </exception>
            public override void SetLength(long value)
            {
            }

            /// <summary>
            /// Writes a sequence of bytes to the current stream and advances the current position within this stream by the number of bytes written.
            /// </summary>
            /// <param name="buffer">An array of bytes. This method copies count bytes from buffer to the current stream.</param>
            /// <param name="offset">The zero-based byte offset in buffer at which to begin copying bytes to the current stream.</param>
            /// <param name="count">The number of bytes to be written to the current stream.</param>
            /// <exception cref="T:System.IO.IOException">An I/O error occurs. </exception>
            /// <exception cref="T:System.NotSupportedException">The stream does not support writing. </exception>
            /// <exception cref="T:System.ObjectDisposedException">Methods were called after the stream was closed. </exception>
            /// <exception cref="T:System.ArgumentNullException">buffer is null. </exception>
            /// <exception cref="T:System.ArgumentException">The sum of offset and count is greater than the buffer length. </exception>
            /// <exception cref="T:System.ArgumentOutOfRangeException">offset or count is negative. </exception>
            public override void Write(byte[] buffer, int offset, int count)
            {
                baseStream_.Write(buffer, offset, count);
            }

            #region Instance Fields

            private readonly Stream baseStream_;

            #endregion
        }

        /// <summary>
        /// A <see cref="PartialInputStream"/> is an <see cref="InflaterInputStream"/>
        /// whose data is only a part or subsection of a file.
        /// </summary>
        private class PartialInputStream : Stream
        {
            #region Constructors

            /// <summary>
            /// Initialise a new instance of the <see cref="PartialInputStream"/> class.
            /// </summary>
            /// <param name="zipFile">The <see cref="ZipFile"/> containing the underlying stream to use for IO.</param>
            /// <param name="start">The start of the partial data.</param>
            /// <param name="length">The length of the partial data.</param>
            public PartialInputStream(ZipFile zipFile, long start, long length)
            {
                start_ = start;
                length_ = length;

                // Although this is the only time the zipfile is used
                // keeping a reference here prevents premature closure of
                // this zip file and thus the baseStream_.

                // Code like this will cause apparently random failures depending
                // on the size of the files and when garbage is collected.
                //
                // ZipFile z = new ZipFile (stream);
                // Stream reader = z.GetInputStream(0);
                // uses reader here....
                zipFile_ = zipFile;
                baseStream_ = zipFile_.baseStream_;
                readPos_ = start;
                end_ = start + length;
            }

            #endregion

            /// <summary>
            /// Read a byte from this stream.
            /// </summary>
            /// <returns>Returns the byte read or -1 on end of stream.</returns>
            public override int ReadByte()
            {
                if (readPos_ >= end_)
                {
                    // -1 is the correct value at end of stream.
                    return -1;
                }

                lock (baseStream_)
                {
                    baseStream_.Seek(readPos_++, SeekOrigin.Begin);
                    return baseStream_.ReadByte();
                }
            }

            /// <summary>
            /// Close this <see cref="PartialInputStream">partial input stream</see>.
            /// </summary>
            /// <remarks>
            /// The underlying stream is not closed.  Close the parent ZipFile class to do that.
            /// </remarks>
            public override void Close()
            {
                // Do nothing at all!
            }

            /// <summary>
            /// Reads a sequence of bytes from the current stream and advances the position within the stream by the number of bytes read.
            /// </summary>
            /// <param name="buffer">An array of bytes. When this method returns, the buffer contains the specified byte array with the values between offset and (offset + count - 1) replaced by the bytes read from the current source.</param>
            /// <param name="offset">The zero-based byte offset in buffer at which to begin storing the data read from the current stream.</param>
            /// <param name="count">The maximum number of bytes to be read from the current stream.</param>
            /// <returns>
            /// The total number of bytes read into the buffer. This can be less than the number of bytes requested if that many bytes are not currently available, or zero (0) if the end of the stream has been reached.
            /// </returns>
            /// <exception cref="T:System.ArgumentException">The sum of offset and count is larger than the buffer length. </exception>
            /// <exception cref="T:System.ObjectDisposedException">Methods were called after the stream was closed. </exception>
            /// <exception cref="T:System.NotSupportedException">The stream does not support reading. </exception>
            /// <exception cref="T:System.ArgumentNullException">buffer is null. </exception>
            /// <exception cref="T:System.IO.IOException">An I/O error occurs. </exception>
            /// <exception cref="T:System.ArgumentOutOfRangeException">offset or count is negative. </exception>
            public override int Read(byte[] buffer, int offset, int count)
            {
                lock (baseStream_)
                {
                    if (count > end_ - readPos_)
                    {
                        count = (int) (end_ - readPos_);
                        if (count == 0)
                        {
                            return 0;
                        }
                    }

                    baseStream_.Seek(readPos_, SeekOrigin.Begin);
                    int readCount = baseStream_.Read(buffer, offset, count);
                    if (readCount > 0)
                    {
                        readPos_ += readCount;
                    }
                    return readCount;
                }
            }

            /// <summary>
            /// Writes a sequence of bytes to the current stream and advances the current position within this stream by the number of bytes written.
            /// </summary>
            /// <param name="buffer">An array of bytes. This method copies count bytes from buffer to the current stream.</param>
            /// <param name="offset">The zero-based byte offset in buffer at which to begin copying bytes to the current stream.</param>
            /// <param name="count">The number of bytes to be written to the current stream.</param>
            /// <exception cref="T:System.IO.IOException">An I/O error occurs. </exception>
            /// <exception cref="T:System.NotSupportedException">The stream does not support writing. </exception>
            /// <exception cref="T:System.ObjectDisposedException">Methods were called after the stream was closed. </exception>
            /// <exception cref="T:System.ArgumentNullException">buffer is null. </exception>
            /// <exception cref="T:System.ArgumentException">The sum of offset and count is greater than the buffer length. </exception>
            /// <exception cref="T:System.ArgumentOutOfRangeException">offset or count is negative. </exception>
            public override void Write(byte[] buffer, int offset, int count)
            {
                throw new NotSupportedException();
            }

            /// <summary>
            /// When overridden in a derived class, sets the length of the current stream.
            /// </summary>
            /// <param name="value">The desired length of the current stream in bytes.</param>
            /// <exception cref="T:System.NotSupportedException">The stream does not support both writing and seeking, such as if the stream is constructed from a pipe or console output. </exception>
            /// <exception cref="T:System.IO.IOException">An I/O error occurs. </exception>
            /// <exception cref="T:System.ObjectDisposedException">Methods were called after the stream was closed. </exception>
            public override void SetLength(long value)
            {
                throw new NotSupportedException();
            }

            /// <summary>
            /// When overridden in a derived class, sets the position within the current stream.
            /// </summary>
            /// <param name="offset">A byte offset relative to the origin parameter.</param>
            /// <param name="origin">A value of type <see cref="T:System.IO.SeekOrigin"></see> indicating the reference point used to obtain the new position.</param>
            /// <returns>
            /// The new position within the current stream.
            /// </returns>
            /// <exception cref="T:System.IO.IOException">An I/O error occurs. </exception>
            /// <exception cref="T:System.NotSupportedException">The stream does not support seeking, such as if the stream is constructed from a pipe or console output. </exception>
            /// <exception cref="T:System.ObjectDisposedException">Methods were called after the stream was closed. </exception>
            public override long Seek(long offset, SeekOrigin origin)
            {
                long newPos = readPos_;

                switch (origin)
                {
                    case SeekOrigin.Begin:
                        newPos = start_ + offset;
                        break;

                    case SeekOrigin.Current:
                        newPos = readPos_ + offset;
                        break;

                    case SeekOrigin.End:
                        newPos = end_ + offset;
                        break;
                }

                if (newPos < start_)
                {
                    throw new ArgumentException("Negative position is invalid");
                }

                if (newPos >= end_)
                {
                    throw new IOException("Cannot seek past end");
                }
                readPos_ = newPos;
                return readPos_;
            }

            /// <summary>
            /// Clears all buffers for this stream and causes any buffered data to be written to the underlying device.
            /// </summary>
            /// <exception cref="T:System.IO.IOException">An I/O error occurs. </exception>
            public override void Flush()
            {
                // Nothing to do.
            }

            /// <summary>
            /// Gets or sets the position within the current stream.
            /// </summary>
            /// <value></value>
            /// <returns>The current position within the stream.</returns>
            /// <exception cref="T:System.IO.IOException">An I/O error occurs. </exception>
            /// <exception cref="T:System.NotSupportedException">The stream does not support seeking. </exception>
            /// <exception cref="T:System.ObjectDisposedException">Methods were called after the stream was closed. </exception>
            public override long Position
            {
                get { return readPos_ - start_; }
                set
                {
                    long newPos = start_ + value;

                    if (newPos < start_)
                    {
                        throw new ArgumentException("Negative position is invalid");
                    }

                    if (newPos >= end_)
                    {
                        throw new InvalidOperationException("Cannot seek past end");
                    }
                    readPos_ = newPos;
                }
            }

            /// <summary>
            /// Gets the length in bytes of the stream.
            /// </summary>
            /// <value></value>
            /// <returns>A long value representing the length of the stream in bytes.</returns>
            /// <exception cref="T:System.NotSupportedException">A class derived from Stream does not support seeking. </exception>
            /// <exception cref="T:System.ObjectDisposedException">Methods were called after the stream was closed. </exception>
            public override long Length
            {
                get { return length_; }
            }

            /// <summary>
            /// Gets a value indicating whether the current stream supports writing.
            /// </summary>
            /// <value>false</value>
            /// <returns>true if the stream supports writing; otherwise, false.</returns>
            public override bool CanWrite
            {
                get { return false; }
            }

            /// <summary>
            /// Gets a value indicating whether the current stream supports seeking.
            /// </summary>
            /// <value>true</value>
            /// <returns>true if the stream supports seeking; otherwise, false.</returns>
            public override bool CanSeek
            {
                get { return true; }
            }

            /// <summary>
            /// Gets a value indicating whether the current stream supports reading.
            /// </summary>
            /// <value>true.</value>
            /// <returns>true if the stream supports reading; otherwise, false.</returns>
            public override bool CanRead
            {
                get { return true; }
            }

#if !NET_1_0 && !NET_1_1 && !NETCF_1_0
            /// <summary>
            /// Gets a value that determines whether the current stream can time out.
            /// </summary>
            /// <value></value>
            /// <returns>A value that determines whether the current stream can time out.</returns>
            public override bool CanTimeout
            {
                get { return baseStream_.CanTimeout; }
            }
#endif

            #region Instance Fields

            private readonly ZipFile zipFile_;
            private readonly Stream baseStream_;
            private readonly long start_;
            private readonly long length_;
            private long readPos_;
            private readonly long end_;

            #endregion
        }

        #endregion
    }

    #endregion

    #region DataSources

    /// <summary>
    /// Provides a static way to obtain a source of data for an entry.
    /// </summary>
    internal interface IStaticDataSource
    {
        /// <summary>
        /// Get a source of data by creating a new stream.
        /// </summary>
        /// <returns>Returns a <see cref="Stream"/> to use for compression input.</returns>
        /// <remarks>Ideally a new stream is created and opened to achieve this, to avoid locking problems.</remarks>
        Stream GetSource();
    }

    /// <summary>
    /// Represents a source of data that can dynamically provide
    /// multiple <see cref="Stream">data sources</see> based on the parameters passed.
    /// </summary>
    internal interface IDynamicDataSource
    {
        /// <summary>
        /// Get a data source.
        /// </summary>
        /// <param name="entry">The <see cref="ZipEntry"/> to get a source for.</param>
        /// <param name="name">The name for data if known.</param>
        /// <returns>Returns a <see cref="Stream"/> to use for compression input.</returns>
        /// <remarks>Ideally a new stream is created and opened to achieve this, to avoid locking problems.</remarks>
        Stream GetSource(ZipEntry entry, string name);
    }

    /// <summary>
    /// Default implementation of <see cref="IDynamicDataSource"/> for files stored on disk.
    /// </summary>
    internal class DynamicDiskDataSource : IDynamicDataSource
    {
        #region IDataSource Members

        /// <summary>
        /// Get a <see cref="Stream"/> providing data for an entry.
        /// </summary>
        /// <param name="entry">The entry to provide data for.</param>
        /// <param name="name">The file name for data if known.</param>
        /// <returns>Returns a stream providing data; or null if not available</returns>
        public Stream GetSource(ZipEntry entry, string name)
        {
            Stream result = null;

            if (name != null)
            {
                result = File.OpenRead(name);
            }

            return result;
        }

        #endregion
    }

    #endregion

    #region Archive Storage

    /// <summary>
    /// Defines facilities for data storage when updating Zip Archives.
    /// </summary>
    internal interface IArchiveStorage
    {
        /// <summary>
        /// Get the <see cref="FileUpdateMode"/> to apply during updates.
        /// </summary>
        FileUpdateMode UpdateMode { get; }

        /// <summary>
        /// Get an empty <see cref="Stream"/> that can be used for temporary output.
        /// </summary>
        /// <returns>Returns a temporary output <see cref="Stream"/></returns>
        /// <seealso cref="ConvertTemporaryToFinal"></seealso>
        Stream GetTemporaryOutput();

        /// <summary>
        /// Convert a temporary output stream to a final stream.
        /// </summary>
        /// <returns>The resulting final <see cref="Stream"/></returns>
        /// <seealso cref="GetTemporaryOutput"/>
        Stream ConvertTemporaryToFinal();

        /// <summary>
        /// Make a temporary copy of the original stream.
        /// </summary>
        /// <param name="stream">The <see cref="Stream"/> to copy.</param>
        /// <returns>Returns a temporary output <see cref="Stream"/> that is a copy of the input.</returns>
        Stream MakeTemporaryCopy(Stream stream);

        /// <summary>
        /// Return a stream suitable for performing direct updates on the original source.
        /// </summary>
        /// <param name="stream">The current stream.</param>
        /// <returns>Returns a stream suitable for direct updating.</returns>
        /// <remarks>This may be the current stream passed.</remarks>
        Stream OpenForDirectUpdate(Stream stream);

        /// <summary>
        /// Dispose of this instance.
        /// </summary>
        void Dispose();
    }

    /// <summary>
    /// An abstract <see cref="IArchiveStorage"/> suitable for extension by inheritance.
    /// </summary>
    internal abstract class BaseArchiveStorage : IArchiveStorage
    {
        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="BaseArchiveStorage"/> class.
        /// </summary>
        /// <param name="updateMode">The update mode.</param>
        protected BaseArchiveStorage(FileUpdateMode updateMode)
        {
            updateMode_ = updateMode;
        }

        #endregion

        #region IArchiveStorage Members

        /// <summary>
        /// Gets a temporary output <see cref="Stream"/>
        /// </summary>
        /// <returns>Returns the temporary output stream.</returns>
        /// <seealso cref="ConvertTemporaryToFinal"></seealso>
        public abstract Stream GetTemporaryOutput();

        /// <summary>
        /// Converts the temporary <see cref="Stream"/> to its final form.
        /// </summary>
        /// <returns>Returns a <see cref="Stream"/> that can be used to read
        /// the final storage for the archive.</returns>
        /// <seealso cref="GetTemporaryOutput"/>
        public abstract Stream ConvertTemporaryToFinal();

        /// <summary>
        /// Make a temporary copy of a <see cref="Stream"/>.
        /// </summary>
        /// <param name="stream">The <see cref="Stream"/> to make a copy of.</param>
        /// <returns>Returns a temporary output <see cref="Stream"/> that is a copy of the input.</returns>
        public abstract Stream MakeTemporaryCopy(Stream stream);

        /// <summary>
        /// Return a stream suitable for performing direct updates on the original source.
        /// </summary>
        /// <param name="stream">The <see cref="Stream"/> to open for direct update.</param>
        /// <returns>Returns a stream suitable for direct updating.</returns>
        public abstract Stream OpenForDirectUpdate(Stream stream);

        /// <summary>
        /// Disposes this instance.
        /// </summary>
        public abstract void Dispose();

        /// <summary>
        /// Gets the update mode applicable.
        /// </summary>
        /// <value>The update mode.</value>
        public FileUpdateMode UpdateMode
        {
            get { return updateMode_; }
        }

        #endregion

        #region Instance Fields

        private readonly FileUpdateMode updateMode_;

        #endregion
    }

    /// <summary>
    /// An <see cref="IArchiveStorage"/> implementation suitable for hard disks.
    /// </summary>
    internal class DiskArchiveStorage : BaseArchiveStorage
    {
        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="DiskArchiveStorage"/> class.
        /// </summary>
        /// <param name="file">The file.</param>
        /// <param name="updateMode">The update mode.</param>
        public DiskArchiveStorage(ZipFile file, FileUpdateMode updateMode)
            : base(updateMode)
        {
            if (file.Name == null)
            {
                throw new ZipException("Cant handle non file archives");
            }

            fileName_ = file.Name;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="DiskArchiveStorage"/> class.
        /// </summary>
        /// <param name="file">The file.</param>
        public DiskArchiveStorage(ZipFile file)
            : this(file, FileUpdateMode.Safe)
        {
        }

        #endregion

        #region IArchiveStorage Members

        /// <summary>
        /// Gets a temporary output <see cref="Stream"/> for performing updates on.
        /// </summary>
        /// <returns>Returns the temporary output stream.</returns>
        public override Stream GetTemporaryOutput()
        {
            if (temporaryName_ != null)
            {
                temporaryName_ = GetTempFileName(temporaryName_, true);
                temporaryStream_ = File.OpenWrite(temporaryName_);
            }
            else
            {
                // Determine where to place files based on internal strategy.
                // Currently this is always done in system temp directory.
                temporaryName_ = Path.GetTempFileName();
                temporaryStream_ = File.OpenWrite(temporaryName_);
            }

            return temporaryStream_;
        }

        /// <summary>
        /// Converts a temporary <see cref="Stream"/> to its final form.
        /// </summary>
        /// <returns>Returns a <see cref="Stream"/> that can be used to read
        /// the final storage for the archive.</returns>
        public override Stream ConvertTemporaryToFinal()
        {
            if (temporaryStream_ == null)
            {
                throw new ZipException("No temporary stream has been created");
            }

            Stream result = null;

            string moveTempName = GetTempFileName(fileName_, false);
            bool newFileCreated = false;

            try
            {
                temporaryStream_.Close();
                File.Move(fileName_, moveTempName);
                File.Move(temporaryName_, fileName_);
                newFileCreated = true;
                File.Delete(moveTempName);

                result = File.OpenRead(fileName_);
            }
            catch (Exception)
            {
                result = null;

                // Try to roll back changes...
                if (!newFileCreated)
                {
                    File.Move(moveTempName, fileName_);
                    File.Delete(temporaryName_);
                }

                throw;
            }

            return result;
        }

        /// <summary>
        /// Make a temporary copy of a stream.
        /// </summary>
        /// <param name="stream">The <see cref="Stream"/> to copy.</param>
        /// <returns>Returns a temporary output <see cref="Stream"/> that is a copy of the input.</returns>
        public override Stream MakeTemporaryCopy(Stream stream)
        {
            stream.Close();

            temporaryName_ = GetTempFileName(fileName_, true);
            File.Copy(fileName_, temporaryName_, true);

            temporaryStream_ = new FileStream(temporaryName_,
                                              FileMode.Open,
                                              FileAccess.ReadWrite);
            return temporaryStream_;
        }

        /// <summary>
        /// Return a stream suitable for performing direct updates on the original source.
        /// </summary>
        /// <param name="stream">The current stream.</param>
        /// <returns>Returns a stream suitable for direct updating.</returns>
        /// <remarks>If the <paramref name="current"/> stream is not null this is used as is.</remarks>
        public override Stream OpenForDirectUpdate(Stream stream)
        {
            Stream result;
            if ((stream == null) || !stream.CanWrite)
            {
                if (stream != null)
                {
                    stream.Close();
                }

                result = new FileStream(fileName_,
                                        FileMode.Open,
                                        FileAccess.ReadWrite);
            }
            else
            {
                result = stream;
            }

            return result;
        }

        /// <summary>
        /// Disposes this instance.
        /// </summary>
        public override void Dispose()
        {
            if (temporaryStream_ != null)
            {
                temporaryStream_.Close();
            }
        }

        #endregion

        #region Internal routines

        private static string GetTempFileName(string original, bool makeTempFile)
        {
            string result = null;

            if (original == null)
            {
                result = Path.GetTempFileName();
            }
            else
            {
                int counter = 0;
                int suffixSeed = DateTime.Now.Second;

                while (result == null)
                {
                    counter += 1;
                    string newName = string.Format("{0}.{1}{2}.tmp", original, suffixSeed, counter);
                    if (!File.Exists(newName))
                    {
                        if (makeTempFile)
                        {
                            try
                            {
                                // Try and create the file.
                                using (FileStream stream = File.Create(newName))
                                {
                                }
                                result = newName;
                            }
                            catch
                            {
                                suffixSeed = DateTime.Now.Second;
                            }
                        }
                        else
                        {
                            result = newName;
                        }
                    }
                }
            }
            return result;
        }

        #endregion

        #region Instance Fields

        private Stream temporaryStream_;
        private readonly string fileName_;
        private string temporaryName_;

        #endregion
    }

    /// <summary>
    /// An <see cref="IArchiveStorage"/> implementation suitable for in memory streams.
    /// </summary>
    internal class MemoryArchiveStorage : BaseArchiveStorage
    {
        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="MemoryArchiveStorage"/> class.
        /// </summary>
        public MemoryArchiveStorage()
            : base(FileUpdateMode.Direct)
        {
        }

        #endregion

        #region IArchiveStorage Members

        /// <summary>
        /// Gets the temporary output <see cref="Stream"/>
        /// </summary>
        /// <returns>Returns the temporary output stream.</returns>
        public override Stream GetTemporaryOutput()
        {
            temporaryStream_ = new MemoryStream();
            return temporaryStream_;
        }

        /// <summary>
        /// Converts the temporary <see cref="Stream"/> to its final form.
        /// </summary>
        /// <returns>Returns a <see cref="Stream"/> that can be used to read
        /// the final storage for the archive.</returns>
        public override Stream ConvertTemporaryToFinal()
        {
            if (temporaryStream_ == null)
            {
                throw new ZipException("No temporary stream has been created");
            }

            finalStream_ = new MemoryStream(temporaryStream_.ToArray());
            return finalStream_;
        }

        /// <summary>
        /// Make a temporary copy of the original stream.
        /// </summary>
        /// <param name="stream">The <see cref="Stream"/> to copy.</param>
        /// <returns>Returns a temporary output <see cref="Stream"/> that is a copy of the input.</returns>
        public override Stream MakeTemporaryCopy(Stream stream)
        {
            temporaryStream_ = new MemoryStream();
            stream.Position = 0;
            StreamUtils.Copy(stream, temporaryStream_, new byte[4096]);
            return temporaryStream_;
        }

        /// <summary>
        /// Return a stream suitable for performing direct updates on the original source.
        /// </summary>
        /// <param name="stream">The original source stream</param>
        /// <returns>Returns a stream suitable for direct updating.</returns>
        /// <remarks>If the <paramref name="stream"/> passed is not null this is used;
        /// otherwise a new <see cref="MemoryStream"/> is returned.</remarks>
        public override Stream OpenForDirectUpdate(Stream stream)
        {
            Stream result;
            if ((stream == null) || !stream.CanWrite)
            {
                result = new MemoryStream();

                if (stream != null)
                {
                    stream.Position = 0;
                    StreamUtils.Copy(stream, result, new byte[4096]);

                    stream.Close();
                }
            }
            else
            {
                result = stream;
            }

            return result;
        }

        /// <summary>
        /// Disposes this instance.
        /// </summary>
        public override void Dispose()
        {
            if (temporaryStream_ != null)
            {
                temporaryStream_.Close();
            }
        }

        #endregion

        #region Instance Fields

        private MemoryStream temporaryStream_;
        private MemoryStream finalStream_;

        #endregion
    }

    #endregion
}