/*===========================================================================
 *
 * File:	Srmemfile.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Defines the CSrMemFile class.
 *
 *=========================================================================*/
#ifndef __OBMEMFILE_H
#define __OBMEMFILE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srfile.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrMemFile Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrMemFile : public virtual CSrFile {

  /*---------- Begin Private Class Members ----------------------*/
private:
  byte*		m_pBuffer;
  dword		m_BufferSize;
  dword		m_Position;
  dword		m_ErrorCount;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrMemFile();
  CSrMemFile(const dword Size);
  virtual ~CSrMemFile();
  virtual void Destroy (void);

  	/* Clear file errors */
  virtual void ClearErrors (void) { m_ErrorCount = 0; }

	/* Close a currently open file */
  virtual void Close (void);

	/* Get class members */
  byte* GetBuffer     (void)        { return (m_pBuffer); }
  dword GetBufferSize (void) const  { return (m_BufferSize); }
  bool  GetFileSize   (int&   Size) { Size = m_BufferSize; return (true); }
  bool  GetFileSize64 (int64& Size) { Size = m_BufferSize; return (true); }

	/* Check class states */
  virtual bool IsOpen   (void) const { return (m_pBuffer != NULL); }
  virtual bool IsEOF    (void) const { return (m_Position >= m_BufferSize); }
  virtual bool HasError (void) const { return (m_ErrorCount > 0); }

  virtual bool Open (const dword BufferSize);
  virtual bool Open (const SSCHAR* pFilename, const SSCHAR* pFileMode);

	/* Read a raw buffer of bytes */
  virtual bool Read (void* pBuffer, const int Size);

	/* Save the current buffer to a file */
  virtual bool Save (const char* pFilename);
  
  	/* Set the file position from start of file */
  virtual bool Seek    (const int Offset);
  virtual bool SeekCur (const int Offset);
  virtual bool Seek64  (const int64 Offset);

	/* Get the current file position */
  virtual bool  Tell   (int& Offset) { Offset = m_Position; return (true); }
  virtual int   Tell   (void) { return (m_Position); }
  virtual bool  Tell64 (int64& Offset) { Offset = m_Position; return (true); }
  virtual int64 Tell64 (void) { return (m_Position); }

	/* Write a raw buffer of bytes */
  virtual bool Write (const void* pBuffer, const int Size);
  

 };
/*===========================================================================
 *		End of Class CSrMemFile Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Obmemfile.H
 *=========================================================================*/
