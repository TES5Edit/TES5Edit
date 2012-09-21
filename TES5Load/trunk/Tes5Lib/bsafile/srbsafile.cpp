/*===========================================================================
 *
 * File:		Srbsafile.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srbsafile.h"


/*===========================================================================
 *
 * Class CSrBsaFile Constructor
 *
 *=========================================================================*/
CSrBsaFile::CSrBsaFile() {
  SrBsaDefaultHeader(m_Header);

  m_FilenameOffset = 0;
  m_FileDataOffset = 0;

  m_Filetime       = 0;
  m_Filesize       = 0;
}
/*===========================================================================
 *		End of Class CSrBsaFile Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrBsaFile::Destroy (void) {
  SrBsaDefaultHeader(m_Header);

  m_FilenameOffset = 0;
  m_FileDataOffset = 0;

  m_Filetime       = 0;
  m_Filesize       = 0;
}
/*===========================================================================
 *		End of Class Method CSrBsaFile::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - CSrBsaFileRecord* GetNextFile (Position);
 *
 *=========================================================================*/
CSrBsaFileRecord* CSrBsaFile::GetNextFile (BSAPOSITION& Position) {
  CSrBsaFileRecord* pFile;

  if (Position.FolderIndex >= (int) m_Folders.GetSize()) return (NULL);
  
  do {
    pFile = m_Folders[Position.FolderIndex]->GetNextFile(Position);
    if (pFile != NULL) return (pFile);

    ++Position.FolderIndex;
    Position.FileIndex = -1;
  } while (Position.FolderIndex < (int) m_Folders.GetSize());

  return (NULL);
}
/*===========================================================================
 *		End of Class Method CSrBsaFile::GetNextFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - bool Load (pFilename);
 *
 *=========================================================================*/
bool CSrBsaFile::Load (const char* pFilename) {
  CSrFile  File;
  bool     Result;

  Destroy();

  Result = File.Open(pFilename, "rb");
  if (!Result) return (false);

  Result = Read(File);
  File.Close();

  if (Result) {
    m_Filename = pFilename;
    GetFileInfo(pFilename, m_Filesize, m_Filetime);
  }

  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrBsaFile::Load()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - bool Save (pFilename);
 *
 *=========================================================================*/
bool CSrBsaFile::Save (const char* pFilename) {
  CSrFile File;
  bool     Result;

  Result = File.Open(pFilename, "wb");
  if (!Result) return (false);

  Result = Write(File);

  if (Result) m_Filename = pFilename;
  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrBsaFile::Save()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - bool ReadHeader (File);
 *
 *=========================================================================*/
bool CSrBsaFile::ReadHeader (CSrFile& File) {
  return File.Read((char *)&m_Header, sizeof(m_Header));
}
/*===========================================================================
 *		End of Class Method CSrBsaFile::ReadHeader()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - bool Read (File);
 *
 *=========================================================================*/
bool CSrBsaFile::Read (CSrFile& File) {
  bool Result;

  Result = ReadHeader(File);
  if (!Result) return (false);

  Result = ReadFolders(File);
  if (!Result) return (false);

  Result = ReadFilenames(File);
  if (!Result) return (false);

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrBsaFile::Read()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - bool ReadFilenames (File);
 *
 *=========================================================================*/
bool CSrBsaFile::ReadFilenames (CSrFile& File) {
  CSrBsaFolder*     pFolder;
  CSrBsaFileRecord* pFile;
  BSAPOSITION	    FilePos;
  char*				pBuffer;
  char*				pParse;
  dword				Index;
  dword				TotalLength;
  int				Length;
  bool              Result;
  bool				ReturnResult;

  if (m_Header.FileNameLength == 0) return (true);

  Result = File.Seek(m_FilenameOffset);
  if (!Result) return (false);

	/* Read the entire filename buffer */
  pBuffer = new char[m_Header.FileNameLength + 8];
  Result = File.Read(pBuffer, m_Header.FileNameLength);

  if (!Result) {
    delete[] pBuffer;
    return (false);
  }

  pParse       = pBuffer;
  TotalLength  = 0;
  ReturnResult = true;
  pFolder      = NULL;

  pFile = GetFirstFile(FilePos);
 
	/* Parse the filename buffer */
  for (Index = 0; Index < m_Header.FileCount; ++Index) {

    if (pFile == NULL) {
      AddSrGeneralError("Mismatch of filename and file record counts!");
      ReturnResult = false;
      break;
    }

    if (TotalLength >= m_Header.FileNameLength) {
      AddSrGeneralError("Exceeded the filename buffer size!");
      ReturnResult = false;
      break;
    }

    Length = (int) strlen(pParse);
    pFile->SetFilename(pParse);
    //SystemLog.Printf("File: '%s', %d", pFile->GetFilename(), pFile->GetFilenameSize() + 1);

    TotalLength += Length + 1;
    pParse      += Length + 1;
   
    pFile = GetNextFile(FilePos);
  }

  File.Tell(m_FileDataOffset);

  delete[] pBuffer;
  return (ReturnResult);
}
/*===========================================================================
 *		End of Class Method CSrBsaFile::ReadFilenames()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - bool ReadFolders (File);
 *
 *=========================================================================*/
bool CSrBsaFile::ReadFolders (CSrFile& File) {
  CSrBsaFolder* pFolder;
  dword		Index;
  int		LastPos;
  bool          Result;

	/* Jump to start of folder record data */
  Result = File.Seek(m_Header.FolderRecordOffset);
  if (!Result) return (false);

	/* Read the folder headers */
  for (Index = 0; Index < m_Header.FolderCount; ++Index) {
    pFolder = new CSrBsaFolder;
    m_Folders.Add(pFolder);
    pFolder->SetBsaFile(this);

    Result = pFolder->Read(File);
    if (!Result) return (false);
  }

  m_FilenameOffset = 0;

	/* Read the folder contents */
  for (Index = 0; Index < m_Header.FolderCount; ++Index) {
    pFolder = m_Folders[Index];
    if (pFolder == NULL) return (false);

    if (pFolder->GetOffset() < m_Header.FileNameLength) {
      AddSrGeneralError("Bad folder offset in BSA file!");
      return (false);
    }

    Result = File.Seek(pFolder->GetOffset() - m_Header.FileNameLength);
    if (!Result) return (false);
   
    Result = pFolder->ReadContents(File);
    if (!Result) return (false);

    Result = File.Tell(LastPos);
    if (!Result) return (false);

    if (m_FilenameOffset < LastPos) m_FilenameOffset = LastPos;
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrBsaFile::ReadFolders()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - bool Write (File);
 *
 *=========================================================================*/
bool CSrBsaFile::Write (CSrFile& File) {
  bool Result;

  m_Header.FileCount          = 0;
  m_Header.FileNameLength     = 0;
  m_Header.FolderCount        = m_Folders.GetSize();
  m_Header.FolderNameLength   = 0;

  Result = WriteHeader(File);
  if (!Result) return (false);

  Result = WriteFolders(File);
  if (!Result) return (false);

  Result = WriteFilenames(File);
  if (!Result) return (false);
  	
	/* Update the header again */
  Result = File.Seek(0);
  if (!Result) return (false);

  Result = WriteHeader(File);
  if (!Result) return (false);

	/* Output the file data */
  Result = WriteData(File);
  if (!Result) return (false);

	/* Update the file/folder offset data */
  UpdateFolderOffsets();
  Result = WriteFolders(File);
  if (!Result) return (false);

  UpdateFileOffsets();
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrBsaFile::Write()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - void UpdateFileOffsets (void);
 *
 *=========================================================================*/
void CSrBsaFile::UpdateFileOffsets (void) {
  CSrBsaFileRecord* pFile;
  BSAPOSITION       FilePos;
  
  pFile = GetFirstFile(FilePos);

  while (pFile != NULL) {
    pFile->SetInputOffset(pFile->GetOffset());  
    pFile = GetNextFile(FilePos);
  }

}
/*===========================================================================
 *		End of Class Method CSrBsaFile::UpdateFileOffsets()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - bool WriteData (File);
 *
 *=========================================================================*/
bool CSrBsaFile::WriteData (CSrFile& File) {
  CSrFile	    InputFile;
  CSrBsaFileRecord* pFile;
  BSAPOSITION       FilePos;
  bool	            Result;

  Result = InputFile.Open(m_Filename, "rb");

  if (!Result) {
    AddSrGeneralError("Failed to open the source BSA file!");
    return (false);
  }

	/* Jump to start of file data output */
  Result = File.Seek(m_FileDataOffset);
  if (!Result) return (false);

  pFile = GetFirstFile(FilePos);

  while (pFile != NULL) {
        
    Result = CopyFileData(pFile, InputFile, File);
    if (!Result) return (false);

    pFile = GetNextFile(FilePos);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrBsaFile::WriteData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - bool CopyFileData (pFile, InputFile, OutputFile);
 *
 *=========================================================================*/
bool CSrBsaFile::CopyFileData (CSrBsaFileRecord* pFile, CSrFile& InputFile, CSrFile& OutputFile) {
  static char s_Buffer[32100];
  int   Offset;
  int   Size;
  dword TotalOutput;
  bool  Result;

  Result = OutputFile.Tell(Offset);
  if (!Result) return (false);

  pFile->SetOffset((dword)Offset);

  Result = InputFile.Seek(pFile->GetInputOffset());
  if (!Result) return (false);

  TotalOutput = 0;

  while (TotalOutput < pFile->GetFilesize()) {
    Size = 32000;
    if (TotalOutput + Size > pFile->GetFilesize()) Size = pFile->GetFilesize() - TotalOutput;

    Result = InputFile.Read(s_Buffer, Size);
    if (!Result) return (false);

    Result = OutputFile.Write(s_Buffer, Size);
    if (!Result) return (false);

   TotalOutput += Size;
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrBsaFile::CopyFileData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - bool WriteFolderHeaders (File);
 *
 *=========================================================================*/
bool CSrBsaFile::WriteFolderHeaders (CSrFile& File) {
  CSrBsaFolder* pFolder;
  dword	        Index;
  bool	        Result;

	/* Jump to start of folder record data */
  Result = File.Seek(m_Header.FolderRecordOffset);
  if (!Result) return (false);

	/* Write the folder headers */
  for (Index = 0; Index < m_Folders.GetSize(); ++Index) {
    pFolder = m_Folders[Index];

    Result = pFolder->Write(File);
    if (!Result) return (false);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrBsaFile::WriteFolderHeaders()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - bool WriteFolders (File);
 *
 *=========================================================================*/
bool CSrBsaFile::WriteFolders (CSrFile& File) {
  CSrBsaFolder* pFolder;
  dword		Index;
  bool          Result;

	/* Output the initial header data */	
  Result = WriteFolderHeaders(File);
  if (!Result) return (false);

  Result = File.Tell(m_FilenameOffset);
  if (!Result) return (false);

	/* Write the folder contents */
  for (Index = 0; Index < m_Folders.GetSize(); ++Index) {
    pFolder = m_Folders[Index];
    if (pFolder == NULL) return (false);

    m_Header.FolderNameLength += (int) pFolder->GetFolderNameSize() + 1;
    pFolder->SetOffset((dword)m_FilenameOffset);

    Result = pFolder->WriteContents(File);
    if (!Result) return (false);

    Result = File.Tell(m_FilenameOffset);
    if (!Result) return (false);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrBsaFile::WriteFolders()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - void UpdateFolderOffsets (void);
 *
 *=========================================================================*/
void CSrBsaFile::UpdateFolderOffsets (void) {
  CSrBsaFolder* pFolder;
  dword		Index;
  
  for (Index = 0; Index < m_Folders.GetSize(); ++Index) {
    pFolder = m_Folders[Index];
    pFolder->SetOffset(pFolder->GetOffset() + m_Header.FileNameLength);
  }

}
/*===========================================================================
 *		End of Class Method CSrBsaFile::UpdateFolderOffsets()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - bool WriteFilenames (File);
 *
 *=========================================================================*/
bool CSrBsaFile::WriteFilenames (CSrFile& File) {
  CSrBsaFileRecord* pFile;
  BSAPOSITION       FilePos;
  bool		    Result;

	/* Jump to start of filename data */
  Result = File.Seek(m_FilenameOffset);
  if (!Result) return (false);

  m_Header.FileCount      = 0;
  m_Header.FileNameLength = 0;
  pFile = GetFirstFile(FilePos);

  while (pFile != NULL) {
    ++m_Header.FileCount;
    m_Header.FileNameLength += pFile->GetFilenameSize() + 1;
    //SystemLog.Printf("File: '%s', %d", pFile->GetFilename(), pFile->GetFilenameSize() + 1);

    Result = File.Write(pFile->GetFilename(), pFile->GetFilenameSize() + 1);
    if (!Result) return (false);

    pFile = GetNextFile(FilePos);
  }

  File.Tell(m_FileDataOffset);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrBsaFile::WriteFilenames()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBsaFile Method - bool WriteHeader (File);
 *
 *=========================================================================*/
bool CSrBsaFile::WriteHeader (CSrFile& File) {
  return File.Write((char *)&m_Header, sizeof(m_Header));
}
/*===========================================================================
 *		End of Class Method CSrBsaFile::WriteHeader()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void SrBsaDefaultHeader (Header);
 *
 *=========================================================================*/
void SrBsaDefaultHeader (srbsaheader_t& Header) {
  memcpy(&Header.FileID, SR_BSAHEADER_FILEID, 4);

  Header.Version            = SR_BSAHEADER_VERSION;
  Header.FolderRecordOffset = sizeof(Header);
  Header.ArchiveFlags       = 0;
  Header.FolderCount        = 0;
  Header.FileCount          = 0;
  Header.FolderNameLength   = 0;
  Header.FileNameLength     = 0;
  Header.FileFlags          = 0;
}
/*===========================================================================
 *		End of Function SrBsaDefaultHeader()
 *=========================================================================*/

