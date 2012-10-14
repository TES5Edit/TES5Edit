/*===========================================================================
 *
 * File:	Filebuffer.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	July 27, 2006
 *
 * Used to buffer input from an possibly large file.
 *
 *=========================================================================*/
#ifndef __FILEBUFFER_H
#define __FILEBUFFER_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "stdio.h"
  #include "stdlib.h"
  #include "string.h"
  #include "srtypes.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/



/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Default maximum buffer size in bytes */
  #define FILEBUF_MAXBUFFERSIZE 16000000

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CFileBuffer Definition
 *
 * Used to buffer input from a possibly large file. If the file is small
 * enough it is all loaded into a temporary buffer and data returned from
 * that. For larger files part of the file is loaded into the buffer and that
 * data returned until more is needed.
 *
 *=========================================================================*/
class CFileBuffer {

  /*---------- Begin Private Class Members ----------------------*/
private:
  byte*		m_pBuffer;		/* Current buffered data */
  dword		m_BufferSize;		/* Allocated size in bytes */
  dword		m_MaxBufferSize;	/* Maximum allowed size of buffer */

  dword 	m_BufferIndex;		/* Current location in buffer */
  int64		m_StartIndex;		/* Index of the buffer start in the file */
  int64		m_FileSize;		/* Size of file in bytes */

  FILE*		m_pFile;		/* File the data is coming from */


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Helper input methods */
  dword GetBufferData_Priv (byte* pOutput, const dword Bytes);
  bool  GetBufferByte_Priv (byte& Output);

  	/* Prepares the buffer for reading from the current file */
  bool InitializeBuffer (void);
 
	/* Read data from the file into the buffer */
  bool ReadData_Priv (void);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CFileBuffer (FILE* pFile = NULL, const dword MaxSize = FILEBUF_MAXBUFFERSIZE);
  ~CFileBuffer() { Destroy(); }
  void Destroy (void);

	/* Access data from the current file */
  bool GetData (byte* pOutput, const dword Bytes);
  bool GetByte (byte& Output);
  bool GetChar (char& Output) { return GetByte(*(byte *)&Output); }

	/* Get the current file position */
  int64 GetFilePos (void);

	/* Have we reached the end of the file? */
  bool IsEOF (void);

	/* Checks if the current state is valid or not */
  bool IsValid (void) const { return (m_pFile != NULL); }

	/* Set members */
  void SetFile (FILE* pFile);

 };
/*===========================================================================
 *		End of Class CFileBuffer Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Filebuffer.H
 *=========================================================================*/
