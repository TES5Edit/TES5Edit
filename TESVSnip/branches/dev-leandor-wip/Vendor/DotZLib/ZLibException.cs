namespace TESVSnip.DotZLib
{
    using System;

    /// <summary>
    /// The exception that is thrown when an error occurs on the zlib dll.
    /// </summary>
    public class ZLibException : ApplicationException
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="ZLibException"/> class with a specified 
        ///   error message and error code.
        /// </summary>
        /// <param name="errorCode">
        /// The zlib error code that caused the exception. 
        /// </param>
        /// <param name="msg">
        /// A message that (hopefully) describes the error. 
        /// </param>
        public ZLibException(int errorCode, string msg)
            : base(string.Format("ZLib error {0} {1}", errorCode, msg))
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ZLibException"/> class with a specified 
        ///   error code.
        /// </summary>
        /// <param name="errorCode">
        /// The zlib error code that caused the exception. 
        /// </param>
        public ZLibException(int errorCode)
            : base(string.Format("ZLib error {0}", errorCode))
        {
        }
    }
}