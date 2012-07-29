// FileSystemScanner.cs
//
// Copyright 2005 John Reilly
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
using System.IO;

namespace ICSharpCode.SharpZipLib.Core
{

    #region EventArgs

    /// <summary>
    /// Event arguments for scanning.
    /// </summary>
    internal class ScanEventArgs : EventArgs
    {
        #region Constructors

        /// <summary>
        /// Initialise a new instance of <see cref="ScanEventArgs"/>
        /// </summary>
        /// <param name="name">The file or directory name.</param>
        public ScanEventArgs(string name)
        {
            name_ = name;
        }

        #endregion

        /// <summary>
        /// The file or directory name for this event.
        /// </summary>
        public string Name
        {
            get { return name_; }
        }

        /// <summary>
        /// Get set a value indicating if scanning should continue or not.
        /// </summary>
        public bool ContinueRunning
        {
            get { return continueRunning_; }
        }

        #region Instance Fields

        private readonly string name_;
        private bool continueRunning_ = true;

        #endregion
    }

    #endregion

    #region Delegates

    /// <summary>
    /// Delegate invoked before starting to process a file.
    /// </summary>
    /// <param name="sender">The source of the event</param>
    /// <param name="e">The event arguments.</param>
    internal delegate void ProcessFileHandler(object sender, ScanEventArgs e);

    /// <summary>
    /// Delegate invoked when a file has been completely processed.
    /// </summary>
    /// <param name="sender">The source of the event</param>
    /// <param name="e">The event arguments.</param>
    internal delegate void CompletedFileHandler(object sender, ScanEventArgs e);

    #endregion

    /// <summary>
    /// FileSystemScanner provides facilities scanning of files and directories.
    /// </summary>
    internal class FileSystemScanner
    {
        #region Constructors

        /// <summary>
        /// Initialise a new instance of <see cref="FileSystemScanner"></see>
        /// </summary>
        /// <param name="fileFilter">The <see cref="PathFilter">file filter</see> to apply.</param>
        /// <param name="directoryFilter">The <see cref="PathFilter"> directory filter</see> to apply.</param>
        public FileSystemScanner(string fileFilter, string directoryFilter)
        {
            fileFilter_ = new PathFilter(fileFilter);
            directoryFilter_ = new PathFilter(directoryFilter);
        }

        #endregion

        #region Delegates

        /// <summary>
        /// Delegate to invoke when a file is processed.
        /// </summary>
        public ProcessFileHandler ProcessFile;

        #endregion

        /// <summary>
        /// Raise the ProcessFile event.
        /// </summary>
        /// <param name="file">The file name.</param>
        private void OnProcessFile(string file)
        {
            ProcessFileHandler handler = ProcessFile;

            if (handler != null)
            {
                var args = new ScanEventArgs(file);
                handler(this, args);
                alive_ = args.ContinueRunning;
            }
        }

        /// <summary>
        /// Scan a directory.
        /// </summary>
        /// <param name="directory">The base directory to scan.</param>
        /// <param name="recurse">True to recurse subdirectories, false to scan a single directory.</param>
        public void Scan(string directory, bool recurse)
        {
            alive_ = true;
            ScanDir(directory, recurse);
        }

        private void ScanDir(string directory, bool recurse)
        {
            string[] names = Directory.GetFiles(directory);
            bool hasMatch = false;
            for (int fileIndex = 0; fileIndex < names.Length; ++fileIndex)
            {
                if (!fileFilter_.IsMatch(names[fileIndex]))
                {
                    names[fileIndex] = null;
                }
                else
                {
                    hasMatch = true;
                }
            }

            if (alive_ && hasMatch)
            {
                foreach (string fileName in names)
                {
                    if (fileName != null)
                    {
                        OnProcessFile(fileName);
                        if (!alive_)
                        {
                            break;
                        }
                    }
                }
            }

            if (alive_ && recurse)
            {
                names = Directory.GetDirectories(directory);
                foreach (string fulldir in names)
                {
                    if ((directoryFilter_ == null) || (directoryFilter_.IsMatch(fulldir)))
                    {
                        ScanDir(fulldir, true);
                        if (!alive_)
                        {
                            break;
                        }
                    }
                }
            }
        }

        #region Instance Fields

        /// <summary>
        /// The file filter currently in use.
        /// </summary>
        private readonly IScanFilter fileFilter_;

        /// <summary>
        /// The directory filter currently in use.
        /// </summary>
        private readonly IScanFilter directoryFilter_;

        /// <summary>
        /// Flag indicating if scanning should continue running.
        /// </summary>
        private bool alive_;

        #endregion
    }
}