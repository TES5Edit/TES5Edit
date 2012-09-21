/*===========================================================================
 *
 * File:	SrFile.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Contains the definition for the CSrFile class, a very simple class 
 * encapsulating file access. 
 *
 *=========================================================================*/
#ifndef __SRFILE_H
#define __SRFILE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "sstring.h"
  #include "srerrorhandler.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrFile Definition
 *
 * Encapsulates very basic file access operations (open, read, write).
 * Other file classes will be derived from this.
 *
 *=========================================================================*/
class CSrFile {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  FILE*		m_pFile;		/* File handle for file operations */
  CSString	m_Filename;		/* The currently open file */
  dword		m_LineCount;		/* Used with ReadLine() */


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrFile();
  virtual ~CSrFile();
  virtual void Destroy (void);

	/* Clear file errors */
  virtual void ClearErrors (void) { clearerr(m_pFile); }

	/* Close a currently open file */
  virtual void Close (void);

	/* Get class members */
  virtual const SSCHAR* GetFilename (void) const { return (m_Filename); }

	/* Get the file size */
  virtual bool  GetFileSize   (int& Size);
  virtual bool  GetFileSize64 (int64& Size);
  virtual int   GetFileSize   (void);
  virtual int64 GetFileSize64 (void);

	/* Get class members */
  virtual dword GetLineCount (void) { return (m_LineCount); }

	/* Check class states */
  virtual bool IsOpen   (void) const;
  virtual bool IsEOF    (void) const { return (feof(m_pFile)   != 0); }
  virtual bool HasError (void) const { return (ferror(m_pFile) != 0); }

	/* Attempt to open a file for input or output */
  virtual bool Open (const SSCHAR* pFilename, const SSCHAR* pFileMode);

  virtual bool Printf  (const SSCHAR* pString, ...);
  virtual bool VPrintf (const SSCHAR* pString, va_list Args);

	/* Read a raw buffer of bytes */
  virtual bool Read (void* pBuffer, const int Size);
  virtual bool Read (void* pBuffer, const int Size, dword& InputBytes);

	/* Input a line of text from a text file */
  virtual bool ReadLine (CSString& Buffer);

	/* Shortcut to reading basic types */
  virtual bool ReadByte    (byte&    Value) { return Read(&Value, sizeof(byte)); }
  virtual bool ReadWord    (word&    Value) { return Read(&Value, sizeof(word)); }
  virtual bool ReadDWord   (dword&   Value) { return Read(&Value, sizeof(dword)); }
  virtual bool ReadDWord64 (dword64& Value) { return Read(&Value, sizeof(dword64)); }
  virtual bool ReadFloat   (float&   Value) { return Read(&Value, sizeof(float)); }
  virtual bool ReadDouble  (double&  Value) { return Read(&Value, sizeof(double)); }

	/* Set the file position from start of file */
  virtual bool Seek    (const int   Offset);
  virtual bool SeekCur (const int   Offset);
  virtual bool Seek64  (const int64 Offset);

	/* Get the current file position */
  virtual bool  Tell   (int&   Offset);
  virtual bool  Tell64 (int64& Offset);
  virtual int   Tell   (void) { return ftell(m_pFile); }
  virtual int64 Tell64 (void);

	/* Write a raw buffer of bytes */
  virtual bool Write (const void* pBuffer, const int Size);

	/* Shortcut to writing basic types */
  virtual bool WriteByte    (const byte    Value) { return Write(&Value, sizeof(byte)); }
  virtual bool WriteWord    (const word    Value) { return Write(&Value, sizeof(word)); }
  virtual bool WriteDWord   (const dword   Value) { return Write(&Value, sizeof(dword)); }
  virtual bool WriteDWord64 (const dword64 Value) { return Write(&Value, sizeof(dword64)); }
  virtual bool WriteFloat   (const float   Value) { return Write(&Value, sizeof(float)); }
  virtual bool WriteDouble  (const double  Value) { return Write(&Value, sizeof(double)); }

};
/*===========================================================================
 *		End of Class CSrFile Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin File Related Functions
 *
 *=========================================================================*/

	/* Checks is a file exists */
  bool SrFileExists (const SSCHAR* pFilename);

	/* Checks a file extension */
  bool SrCheckExtension (const SSCHAR* pFilename, const SSCHAR* pExt);
 
  bool          MakePathEx    (const SSCHAR* pPath);
  SSCHAR*       TerminatePath (SSCHAR* pPath);
  const SSCHAR* TerminatePath (CSString& Path);
  bool          FileExists    (const SSCHAR* pFilename);

  int64 GetFileSize (const char* pFilename);
  bool  GetFileSize (int64& FileSize, const char* pFilename);

  bool GetFileInfo (const char* pFilename, int64& Filesize, dword64& Filetime);

/*===========================================================================
 *		End of File Related Functions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrFile.H
 *=========================================================================*/
