/*===========================================================================
 *
 * File:		Srbsafilerecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRBSAFILERECORD_H
#define __SRBSAFILERECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "../common/srfile.h"
  #include "../common/srptrarray.h"
  #include "../common/sstring.h"
  #include "../common/srlogfile.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Bitmasks for the size field in the header */
  #define SR_BSAFILEREC_SIZEMASK 0x7fffffff
  #define SR_BSAFILEREC_FLAGMASK 0xC0000000

	/* Record flags */
  #define SR_BSAFILEREC_FLAG_COMPRESS	0x80000000

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
  struct srbsafileheader_t
  {
	int64		NameHash;
	dword		Filesize;
	dword		Offset;
  };

#pragma pack(pop)

	/* Forward class definition */
  class CSrBsaFolder;
  class CSrBsaFile;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrBsaFileRecord Definition
 *
 *=========================================================================*/
class CSrBsaFileRecord {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSString			m_Filename;
  srbsafileheader_t	m_Header;
  CSrBsaFolder*		m_pFolder;

  CSString			m_TmpFilename;

  dword				m_InputOffset;
  dword				m_Filesize;
  dword				m_Flags;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Helper input/output methods */
  bool ReadHeader  (CSrFile& File);
  bool WriteHeader (CSrFile& File);

  bool SaveFileData           (CSrFile& OutputFile, CSrFile& InputFile);
  bool SaveCompressedFileData (CSrFile& OutputFile, CSrFile& InputFile);
  bool MakeTempFilename       (CSString& OutputFilename, const char* pTempPath);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrBsaFileRecord();
  virtual ~CSrBsaFileRecord() { Destroy(); }
  virtual void Destroy (void);

	/* Get class members */
  dword64		GetFiletime		(void);
  dword         GetFilesize      (void) { return (m_Filesize); }
  const char*   GetFilename      (void) { return (m_Filename); }
  const char*   GetTmpFilename   (void) { return (m_TmpFilename); }
  dword			GetFilenameSize  (void) { return (m_Filename.GetLength()); }
  bool          IsCompressToggle (void) { return (m_Flags & SR_BSAFILEREC_FLAG_COMPRESS) != 0; }
  CSrBsaFolder* GetFolder        (void) { return (m_pFolder); }
  CSrBsaFile*   GetParentFile    (void);
  const char*   GetFullFilename  (void);
  const char*   GetFullPath      (void);
  dword			GetOffset        (void) { return (m_Header.Offset); }
  dword			GetInputOffset   (void) { return (m_InputOffset); }

	/* Is the file data compressed or not */
  bool IsCompressed (void);

	/* Set class members */
  void SetCompressToggle (const bool     Flag) { if (Flag) {m_Flags |= SR_BSAFILEREC_FLAG_COMPRESS; } else { m_Flags &= ~SR_BSAFILEREC_FLAG_COMPRESS; } }
  void SetFilename       (const char* pString) { m_Filename = pString; }
  void SetTmpFilename    (const char* pString) { m_TmpFilename = pString; }
  void SetFolder         (CSrBsaFolder* pFold) { m_pFolder  = pFold; }
  void SetOffset         (const dword  Offset) { m_Header.Offset = Offset; }
  void SetInputOffset    (const dword  Offset) { m_InputOffset   = Offset; }

	/* Input/output record */
  bool Read  (CSrFile& File);
  bool Write (CSrFile& File);

	/* Output a BSA record to a seperate file */
  bool SaveFile            (const char* pOutput);
  bool SaveTempFile        (CSString& OutputFilename, const char* pTempPath);
  bool GetExistingTempFile (CSString& Filename, const char* pTempPath);

};

	/* Array of file pointers */
  typedef CSrPtrArray<CSrBsaFileRecord> CSrBsaFileRecArray;

/*===========================================================================
 *		End of Class CSrBsaFileRecord Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/
  int64 SrHashString64 (const char* pString);

  bool SrReadBString  (CSString& String, CSrFile& File);
  bool SrWriteBString (CSString& String, CSrFile& File);

  bool GetFileInfo (const char* pFilename, int64& Filesize, dword64& Filetime);

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srbsafilerecord.H
 *=========================================================================*/
