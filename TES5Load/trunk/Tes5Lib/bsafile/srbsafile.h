/*===========================================================================
 *
 * File:		Srbsafile.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrBsaFile class for handling BSA files.
 *
 *=========================================================================*/
#ifndef __SRBSAFILE_H
#define __SRBSAFILE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srbsafolder.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Default header data */
  #define SR_BSAHEADER_FILEID	"BSA\0"
  #define SR_BSAHEADER_VERSION	0x67

	/* Archive flags */
  #define SR_BSAARCHIVE_PATHNAMES	1
  #define SR_BSAARCHIVE_FILENAMES	2
  #define SR_BSAARCHIVE_COMPRESSFILES	4

	/* File flags */
  #define SR_BSAFILE_NIF	0x0001
  #define SR_BSAFILE_DDS	0x0002
  #define SR_BSAFILE_XML	0x0004
  #define SR_BSAFILE_WAV	0x0008
  #define SR_BSAFILE_MP3	0x0010
  #define SR_BSAFILE_TXT	0x0020
  #define SR_BSAFILE_HTML	0x0020
  #define SR_BSAFILE_BAT	0x0020
  #define SR_BSAFILE_SCC	0x0020
  #define SR_BSAFILE_SPT	0x0040
  #define SR_BSAFILE_TEX	0x0080
  #define SR_BSAFILE_FNT	0x0080
  #define SR_BSAFILE_CTL	0x0100

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	/* BSA file header */
  struct srbsaheader_t
  {
	char		FileID[4];		/* BSA\0 */
	dword		Version;
	dword		FolderRecordOffset;
	dword		ArchiveFlags;
	dword		FolderCount;
	dword		FileCount;
	dword		FolderNameLength;
	dword		FileNameLength;
	dword		FileFlags;
  };

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrBsaFile Definition
 *
 *=========================================================================*/
class CSrBsaFile {

  /*---------- Begin Private Class Members ----------------------*/
private:
  srbsaheader_t			m_Header;

  CSrBsaFolderRecord	m_Folders;

  int					m_FilenameOffset;
  int					m_FileDataOffset;

  dword64				m_Filetime;
  int64					m_Filesize;
 
  CSString				m_Filename;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Helper input/output methods */
  bool ReadHeader          (CSrFile& File);
  bool WriteHeader         (CSrFile& File);
  bool ReadFolders         (CSrFile& File);
  bool WriteFolders        (CSrFile& File);
  bool WriteFolderHeaders  (CSrFile& File);
  bool ReadFilenames       (CSrFile& File);
  bool WriteFilenames      (CSrFile& File);
  bool WriteData           (CSrFile& File);
  void UpdateFileOffsets   (void);
  void UpdateFolderOffsets (void);

  bool CopyFileData (CSrBsaFileRecord* pFile, CSrFile& InputFile, CSrFile& OutputFile);
  

  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrBsaFile();
  virtual ~CSrBsaFile() { Destroy(); }
  virtual void Destroy (void);

	/* Iterate through files */
  CSrBsaFileRecord* GetFirstFile (BSAPOSITION& Position) { Position.FolderIndex = 0; Position.FileIndex = -1; return GetNextFile(Position); }
  CSrBsaFileRecord* GetNextFile  (BSAPOSITION& Position);

	/* Get class members */
  dword64     GetFiletime  (void) { return (m_Filetime); }
  const char* GetFilename  (void) { return (m_Filename); }
  bool        IsCompressed (void) { return ((m_Header.ArchiveFlags & SR_BSAARCHIVE_COMPRESSFILES) != 0); }

  bool Load  (const char* pFilename);
  bool Save  (const char* pFilename);
  bool Read  (CSrFile& File);
  bool Write (CSrFile& File);

};

	/* Arrays of BSA files */
  typedef CSrPtrArray<CSrBsaFile>    CSrBsaFileArray;
  typedef CSrRefPtrArray<CSrBsaFile> CSrRefBsaFileArray;

/*===========================================================================
 *		End of Class CSrBsaFile Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/

  void SrBsaDefaultHeader (srbsaheader_t& Header);

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srbsafile.H
 *=========================================================================*/
