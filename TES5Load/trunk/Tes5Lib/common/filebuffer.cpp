/*===========================================================================
 *
 * File:	Filebuffer.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	July 27, 2006
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "filebuffer.h"
#include "io.h"
#include "stddef.h"


/*===========================================================================
 *
 * Class CFileBuffer Constructor
 *
 *=========================================================================*/
CFileBuffer::CFileBuffer (FILE* pFile, const dword MaxSize) {

  m_pBuffer       = NULL;
  m_BufferSize    = 0;
  m_MaxBufferSize = MaxSize;

  m_BufferIndex   = 0;
  m_StartIndex    = 0;
  m_FileSize      = 0;

  m_pFile         = pFile;

}
/*===========================================================================
 *		End of Class CFileBuffer Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CFileBuffer Method - void Destroy (void);
 *
 *=========================================================================*/
void CFileBuffer::Destroy (void) {
  
	/* File doesn't belong to us so just clear it */
  m_pFile = NULL;

  m_BufferSize    = 0;
  m_BufferIndex   = 0;
  m_StartIndex    = 0;
  m_FileSize      = 0;

	/* Unallocate the buffer */
  if (m_pBuffer != NULL) {
    delete[] m_pBuffer;
    m_pBuffer = NULL;
  }

}
/*===========================================================================
 *		End of Class Method CFileBuffer::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CFileBuffer Method - bool GetBufferByte_Priv (Output);
 *
 *=========================================================================*/
bool CFileBuffer::GetBufferByte_Priv (byte& Output) {

    	/* No data is available in the buffer */
  if (m_BufferIndex >= m_BufferSize) return (false);
  
	/* Copy the requested byte */
  Output = m_pBuffer[m_BufferIndex];
  ++m_BufferIndex;
  return (true);
}
/*===========================================================================
 *		End of Class Method CFileBuffer::GetBufferByte_Priv()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CFileBuffer Method - dword GetBufferData_Priv (pOutput, Bytes);
 *
 * Private method that attempts to read the given amount of buffered data and
 * saves it to the given pointer. On success the return value will equal to
 * Bytes. If not enough buffered data is available the return value will be 
 * the amount of data copied.
 *
 *=========================================================================*/
dword CFileBuffer::GetBufferData_Priv (byte* pOutput, const dword Bytes) {
  dword AvailableBytes = m_BufferSize - m_BufferIndex;

    	/* No data is available in the buffer */
  if (AvailableBytes == 0) return (0);

	/* Does current buffer have more than enough data in it? */
  if (AvailableBytes >= Bytes) AvailableBytes = Bytes;
  
	/* Copy the requested data as possible */
  memcpy(pOutput, m_pBuffer + m_BufferIndex, AvailableBytes);
  m_BufferIndex += AvailableBytes;
  return (AvailableBytes);
}
/*===========================================================================
 *		End of Class Method CFileBuffer::GetBufferData_Priv()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CFileBuffer Method - bool GetByte (Output);
 *
 *=========================================================================*/
bool CFileBuffer::GetByte (byte& Output) {

	/* Check object state and inputs */
  if (!IsValid()) return (false);
  
	/* Read more data if needed */
  if (m_BufferIndex >= m_BufferSize) {
    if (!ReadData_Priv()) return (false);
  }

	/* Get data from current buffer */
  return GetBufferByte_Priv(Output);
}
/*===========================================================================
 *		End of Class Method CFileBuffer::GetByte()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CFileBuffer Method - bool GetBufferData_Priv (byte* pOutput, const dword Bytes);
 *
 * Request a block of data from the file. Returns false on any error.
 *
 *=========================================================================*/
bool CFileBuffer::GetData (byte* pOutput, const dword Bytes) {
  dword NeededBytes;
  dword OutputBytes;
  bool  Result;

	/* Check object state and inputs */
  if (!IsValid())      return (false);
  if (pOutput == NULL) return (false);
  if (Bytes   == 0)    return (true);

  NeededBytes = Bytes;

	/* Request and read data until we have the amount requested */
  while (NeededBytes > 0) {

		/* Get data from current buffer */
    OutputBytes  = GetBufferData_Priv(pOutput, NeededBytes);
    NeededBytes -= OutputBytes;

		/* Read more data if needed */
    if (NeededBytes > 0) {
      Result = ReadData_Priv();
      if (!Result) return (false);
    }
  }

  return (NeededBytes == 0);
}
/*===========================================================================
 *		End of Class Method CFileBuffer::GetData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CFileBuffer Method - int64 GetFilePos (void);
 *
 * Returns the current position in the file (byte position).
 *
 *=========================================================================*/
int64 CFileBuffer::GetFilePos (void) {
  return ((int64)m_BufferIndex + m_StartIndex);
}
/*===========================================================================
 *		End of Class Method CFileBuffer::GetFilePos()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CFileBuffer Method - bool InitializeBuffer (void);
 *
 * Initializes the buffer to prepare it for reading from the current
 * file. Returns false on any error.
 *
 *=========================================================================*/
bool CFileBuffer::InitializeBuffer (void) {
  size_t BytesRead;

	/* Ignore if the current file is invalid */
  if (!IsValid()) return (false);

	/* Get the current file position */
  m_StartIndex = SrFtell64(m_pFile);

  if (m_StartIndex < 0) {
    m_StartIndex = 0;
    return (false);
  }

	/* Find the file size */
  m_FileSize = SrFseek64(m_pFile, 0, SEEK_END);

  if (m_FileSize < 0) {
    m_FileSize = 0;
    return (false);
  }

  	/* Return to the initial file position */
  if (SrFseek64(m_pFile, m_StartIndex, SEEK_SET) < 0) return (false);

	/* Determine the buffer size to use */
  if (m_FileSize > (int64)m_MaxBufferSize) {
    m_BufferSize = m_MaxBufferSize;
  }
  else {
    m_BufferSize = (dword) m_FileSize;
  }

	/* Delete the current buffer if required */
  if (m_pBuffer != NULL) {
    delete[] m_pBuffer;
    m_pBuffer = NULL;
  }

	/* Allocate the buffer */
  m_pBuffer = new byte[m_BufferSize + 64];
  m_BufferIndex = 0;

	/* Read data into the buffer */
  BytesRead = fread(m_pBuffer, 1, m_BufferSize, m_pFile);
  if (BytesRead == m_BufferSize) return (true);

  m_BufferSize = (dword) BytesRead;
  return (false);
}
/*===========================================================================
 *		End of Class Method CFileBuffer::InitializeBuffer()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CFileBuffer Method - bool IsEOF (void);
 *
 *=========================================================================*/
bool CFileBuffer::IsEOF (void) {

	/* Check for valid object state */
  if (!IsValid()) return (true);

  return (GetFilePos() >= m_FileSize);
}
/*===========================================================================
 *		End of Class Method CFileBuffer::IsEOF()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CFileBuffer Method - bool ReadData_Priv (void);
 *
 * Reads the next chunk of buffered data from the file. Returns false
 * on any error.
 *
 *=========================================================================*/
bool CFileBuffer::ReadData_Priv (void) {
  bool  Result;
  dword BytesRead;
  dword BytesNeeded;

	/* Initialize the buffer if needed */
  if (m_pBuffer == NULL) {
    Result = InitializeBuffer();
    return (Result);
  }

	/* Ignore if we're already at the end of file */
  if (IsEOF()) return (false);

	/* Move file pointer to start of next section */
  m_StartIndex += m_BufferSize;

	/* Read up to the end of file */
  if (m_StartIndex + m_BufferSize > m_FileSize) {
    BytesNeeded = (dword) (m_FileSize - m_StartIndex);
  }
  else {
    BytesNeeded = m_BufferSize;
  }

	/* Read the data into the buffer */
  BytesRead = (dword) fread(m_pBuffer, 1, BytesNeeded, m_pFile);
  m_BufferSize = BytesRead;
  m_BufferIndex = 0;
  return (BytesNeeded == BytesRead);
}
/*===========================================================================
 *		End of Class Method CFileBuffer::ReadData_Priv()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CFileBuffer Method - void SetFile (pFile);
 *
 *=========================================================================*/
void CFileBuffer::SetFile (FILE* pFile) {

  Destroy();

  m_pFile = pFile;
}
/*===========================================================================
 *		End of Class Method CFileBuffer::SetFile()
 *=========================================================================*/
