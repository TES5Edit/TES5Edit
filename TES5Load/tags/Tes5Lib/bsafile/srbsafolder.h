/*===========================================================================
 *
 * File:		Srbsafolder.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRBSAFOLDER_H
#define __SRBSAFOLDER_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srbsafilerecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	/* BSA file header */
  struct srbsafolderheader_t 
  {
	int64		NameHash;
	dword		FileCount;
	dword		Offset;
  };

#pragma pack(pop)

	/* Used to iterate through files */
  struct BSAPOSITION 
  {
	int	FolderIndex;
	int	FileIndex;
  };

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrBsaFolder Definition
 *
 *=========================================================================*/
class CSrBsaFolder {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  srbsafolderheader_t	m_Header;
  CSString				m_FolderName;

  CSrBsaFileRecArray	m_Files;

  CSrBsaFile*			m_pBsaFile;		/* Parent file */


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Helper input/output methods */
  bool ReadHeader  (CSrFile& File);
  bool WriteHeader (CSrFile& File);
  bool ReadFiles   (CSrFile& File);
  bool WriteFiles  (CSrFile& File);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrBsaFolder();
  virtual ~CSrBsaFolder() { Destroy(); }
  virtual void Destroy (void);

	/* Get class members */
  dword         GetOffset         (void) { return (m_Header.Offset); }
  const char*   GetFolderName     (void) { return (m_FolderName); }
  dword         GetFolderNameSize (void) { return (m_FolderName.GetLength()); }
  CSrBsaFile*   GetBsaFile        (void) { return (m_pBsaFile); }
  dword64       GetFiletime       (void);

	/* Iterate through records */
  CSrBsaFileRecord* GetNextFile (BSAPOSITION& Position);

	/* Set class members */
  void SetOffset  (const dword     Value) { m_Header.Offset = Value; }
  void SetBsaFile (CSrBsaFile*     pFile) { m_pBsaFile      = pFile; }

	/* Input/output the folder data */
  bool Read          (CSrFile& File);
  bool Write         (CSrFile& File);
  bool ReadContents  (CSrFile& File);
  bool WriteContents (CSrFile& File);


};

	/* Array of folder pointers */
  typedef CSrPtrArray<CSrBsaFolder> CSrBsaFolderRecord;

/*===========================================================================
 *		End of Class CSrBsaFolder Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srbsafolder.H
 *=========================================================================*/
