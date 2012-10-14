/*===========================================================================
 *
 * File:	Srmemfile.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srmemfile.h"



/*===========================================================================
 *
 * Class CSrMemFile Constructor
 *
 *=========================================================================*/
CSrMemFile::CSrMemFile () {

  m_pBuffer    = NULL;
  m_BufferSize = 0;
  m_Position   = 0;
  m_ErrorCount = 0;

 }

CSrMemFile::CSrMemFile (const dword Size) {

  m_pBuffer    = NULL;
  m_BufferSize = 0;
  m_Position   = 0;
  m_ErrorCount = 0;

  Open(Size);
 }
/*===========================================================================
 *		End of Class CSrMemFile Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMemFile Destructor
 *
 *=========================================================================*/
CSrMemFile::~CSrMemFile () {

  if (m_pBuffer != NULL) {
    delete[] m_pBuffer;
   }

 }
/*===========================================================================
 *		End of Class CSrMemFile Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMemFile Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrMemFile::Destroy (void) {
  Close();
 }
/*===========================================================================
 *		End of Class Method CSrMemFile::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMemFile Method - void Close (void);
 *
 *=========================================================================*/
void CSrMemFile::Close (void) {

  if (m_pBuffer != NULL) {
    delete[] m_pBuffer;
    m_pBuffer = NULL;
   }

  m_BufferSize = 0;
  m_Position   = 0;
  m_ErrorCount = 0;
 }
/*===========================================================================
 *		End of Class Method CSrMemFile::Close()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMemFile Method - bool Open (BufferSize);
 *
 * Main open method for the memory mapped buffer. Creates a buffer the
 * given size.
 *
 *=========================================================================*/
bool CSrMemFile::Open (const dword BufferSize) {

	/* Close an open file */
  Close();

  m_pBuffer    = new byte[BufferSize + 4];
  m_BufferSize = BufferSize;
  m_Position   = 0;

  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrMemFile::Open()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMemFile Method - bool Open (pFilename, pFileMode);
 *
 *=========================================================================*/
bool CSrMemFile::Open (const SSCHAR*, const SSCHAR*) {
  return AddSrUserError(SRERR_USER_BADINPUT, "Open(pFilename, pFileMode) not valid for a memory buffer file!");
 }
/*===========================================================================
 *		End of Class Method CSrMemFile::Open()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMemFile Method - bool Read (pBuffer, Size);
 *
 * Reads bytes from the memory buffer.
 *
 *=========================================================================*/
bool CSrMemFile::Read (void* pBuffer, const int Size) {
  int ReadSize;

	/* Ignore if not open */
  if (!IsOpen()) {
    ++m_ErrorCount;
    return AddSrUserError(SRERR_USER_NOTOPEN);
   }

  ReadSize = Size;
  if (ReadSize + m_Position > m_BufferSize) ReadSize = m_BufferSize - m_Position;

	/* Abort if not enough bytes to read */
  if (ReadSize != Size) {
    if (ReadSize > 0) memmove(pBuffer, m_pBuffer + m_Position, ReadSize);
    ++m_ErrorCount;
    m_Position += ReadSize;
    return AddSrSystemError("Failed to read data from memory buffer! Only %d of %d bytes input.", ReadSize, Size);
   }

  memmove(pBuffer, m_pBuffer + m_Position, ReadSize);
  m_Position += ReadSize;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrMemFile::Read()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMemFile Method - bool Save (pFilename);
 *
 * Dump the current memory buffer to the given file.
 *
 *=========================================================================*/
bool CSrMemFile::Save (const char* pFilename) {
  CSrFile NewFile;
  bool    Result;

	/* Ignore if not open */
  if (!IsOpen()) {
    ++m_ErrorCount;
    return AddSrUserError(SRERR_USER_NOTOPEN);
   }

  Result = NewFile.Open(pFilename, "wb");
  if (!Result) return (false);

  Result = NewFile.Write(m_pBuffer, m_BufferSize);
  return (Result);
 }
/*===========================================================================
 *		End of Class Method CSrMemFile::Save()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMemFile Method - bool Seek (Offset);
 *
 * Description
 *
 *=========================================================================*/
bool CSrMemFile::Seek (const int Offset) {

  if (!IsOpen()) return AddSrUserError(SRERR_USER_NOTOPEN);
  if (Offset > (int) m_BufferSize) return AddSrSystemError("Failed to set the memory file absolute position to %lu!", Offset);

  m_Position = Offset;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrMemFile::Seek()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMemFile Method - bool SeekCur (Offset);
 *
 *=========================================================================*/
bool CSrMemFile::SeekCur (const int Offset) {
  int NewPos = Offset + m_Position;

  if (!IsOpen()) return AddSrUserError(SRERR_USER_NOTOPEN);
  if (NewPos > (int) m_BufferSize || NewPos < 0) return AddSrSystemError("Failed to set the memory file relative position to %lu!", Offset);

  m_Position = NewPos;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrMemFile::SeekCur()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMemFile Method - bool Seek64 (Offset);
 *
 * Description
 *
 *=========================================================================*/
bool CSrMemFile::Seek64 (const int64 Offset) {

  if (!IsOpen()) return AddSrUserError(SRERR_USER_NOTOPEN);
  if (Offset > m_BufferSize) return AddSrSystemError("Failed to set the memory file position to %lu!", Offset);

  m_Position = (dword) (dword64) Offset;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrMemFile::Seek()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMemFile Method - bool Write (pBuffer, Size);
 *
 * Write bytes to the memory buffer.
 *
 *=========================================================================*/
bool CSrMemFile::Write (const void* pBuffer, const int Size) {
  int WriteSize;

	/* Ignore if not open */
  if (!IsOpen()) {
    ++m_ErrorCount;
    return AddSrUserError(SRERR_USER_NOTOPEN);
   }

  WriteSize = Size;
  if (WriteSize + m_Position > m_BufferSize) WriteSize = m_BufferSize - m_Position;

	/* Abort if not enough bytes to read */
  if (WriteSize != Size) {
    if (WriteSize > 0) memmove(m_pBuffer + m_Position, pBuffer, WriteSize);
    ++m_ErrorCount;
    m_Position += WriteSize;
    return AddSrSystemError("Failed to write data to memory buffer! Only %d of %d bytes output.", WriteSize, Size);
   }

  memmove(m_pBuffer + m_Position, pBuffer, WriteSize);
  m_Position += WriteSize;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrMemFile::Write()
 *=========================================================================*/

