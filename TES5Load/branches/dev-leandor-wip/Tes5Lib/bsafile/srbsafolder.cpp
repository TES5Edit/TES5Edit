/*===========================================================================
 *
 * File:		Srbsafolder.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srbsafolder.h"
#include "srbsafile.h"


/*===========================================================================
 *
 * Class CSrBsaFolder Constructor
 *
 *=========================================================================*/
CSrBsaFolder::CSrBsaFolder() 
{
  m_Header.FileCount = 0;
  m_Header.NameHash  = 0;
  m_Header.Offset    = 0;
  m_pBsaFile         = NULL;
}
/*===========================================================================
 *		End of Class CSrBsaFolder Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFolder Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrBsaFolder::Destroy (void) 
{
  m_Header.FileCount = 0;
  m_Header.NameHash  = 0;
  m_Header.Offset    = 0;
  m_pBsaFile         = NULL;

  m_FolderName.Empty();
  m_Files.Destroy();
}
/*===========================================================================
 *		End of Class Method CSrBsaFolder::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFolder Method - uint64 GetFiletime (void);
 *
 *=========================================================================*/
dword64 CSrBsaFolder::GetFiletime (void) {
  if (m_pBsaFile == NULL) return (0);
  return (m_pBsaFile->GetFiletime());
}
/*===========================================================================
 *		End of Class Method CSrBsaFolder::GetFiletime()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFolder Method - CSrBsaFileRecord* GetNextFile (Position);
 *
 *=========================================================================*/
CSrBsaFileRecord* CSrBsaFolder::GetNextFile (BSAPOSITION& Position) {

  ++Position.FileIndex;
  if (Position.FileIndex >= (int) m_Files.GetSize()) return (NULL);

  return m_Files[Position.FileIndex];
}
/*===========================================================================
 *		End of Class Method CSrBsaFolder::GetNextFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFolder Method - bool ReadHeader (File);
 *
 *=========================================================================*/
bool CSrBsaFolder::ReadHeader (CSrFile& File) {
  return File.Read((char *)&m_Header, sizeof(m_Header));
}
/*===========================================================================
 *		End of Class Method CSrBsaFolder::ReadHeader()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFolder Method - bool Read (File);
 *
 *=========================================================================*/
bool CSrBsaFolder::Read (CSrFile& File) {
  bool Result;

  Result = ReadHeader(File);
  if (!Result) return (false);

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrBsaFolder::Read()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFolder Method - bool ReadContents (File);
 *
 *=========================================================================*/
bool CSrBsaFolder::ReadContents (CSrFile& File) {
  bool Result;

  Result = SrReadBString(m_FolderName, File);
  if (!Result) return (false);

  Result = ReadFiles(File);
  if (!Result) return (false);

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrBsaFolder::ReadContents()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFolder Method - bool ReadFiles (File);
 *
 *=========================================================================*/
bool CSrBsaFolder::ReadFiles (CSrFile& File) {
  CSrBsaFileRecord* pFile;
  dword		    Index;
  bool		    Result;

  for (Index = 0; Index < m_Header.FileCount; ++Index) {
    pFile = new CSrBsaFileRecord;
    m_Files.Add(pFile);

    pFile->SetFolder(this);

    Result = pFile->Read(File);
    if (!Result) return (false);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrBsaFolder::ReadFiles()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFolder Method - bool WriteFiles (File);
 *
 *=========================================================================*/
bool CSrBsaFolder::WriteFiles (CSrFile& File) {
  dword		    Index;
  bool		    Result;
  
  for (Index = 0; Index < m_Header.FileCount; ++Index) {
    Result = m_Files[Index]->Write(File);
    if (!Result) return (false);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrBsaFolder::WriteFiles()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFolder Method - bool Write (File);
 *
 *=========================================================================*/
bool CSrBsaFolder::Write (CSrFile& File) {
  bool Result;

  //m_Header.NameHash = ObHashString64(m_FolderName);

  Result = WriteHeader(File);
  if (!Result) return (false);

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrBsaFolder::Write()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFolder Method - bool WriteContents (File);
 *
 *=========================================================================*/
bool CSrBsaFolder::WriteContents (CSrFile& File) {
  bool Result;

  Result = SrWriteBString(m_FolderName, File);
  if (!Result) return (false);

  Result = WriteFiles(File);
  if (!Result) return (false);

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrBsaFolder::WriteContents()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFolder Method - bool WriteHeader (File);
 *
 *=========================================================================*/
bool CSrBsaFolder::WriteHeader (CSrFile& File) {
  return File.Write((char *)&m_Header, sizeof(m_Header));
}
/*===========================================================================
 *		End of Class Method CSrBsaFolder::WriteHeader()
 *=========================================================================*/
