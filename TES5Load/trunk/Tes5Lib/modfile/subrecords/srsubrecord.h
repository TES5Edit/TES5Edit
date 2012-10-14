/*===========================================================================
 *
 * File:	SrSubrecord.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRSUBRECORD_H
#define __SRSUBRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "../../common/srfile.h"
  #include "../../common/srlogfile.h"
  #include "../srmoddefs.h"
  #include "../srfields.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Subrecord header size in bytes */
  #define SR_SUBRECORD_HEADERSIZE 6

#ifdef _DEBUG

  #define SR_VERIFY_SUBRECORDSIZE(REQSIZE) if (m_RecordSize != REQSIZE) { \
						return AddSrUserError(SRERR_USER_BADINPUT, "0x%08X: Bad subrecord size for %4.4s! Expected %d but found %d bytes!", File.Tell(), m_RecordType.Name, REQSIZE, m_RecordSize); }

  #define SR_VERIFY_SUBRECORDSIZE_MAX(REQSIZE) if (m_RecordSize > REQSIZE) { \
						return AddSrUserError(SRERR_USER_BADINPUT, "0x%08X: Bad subrecord size for %4.4s! Expected %d or less but found %d bytes!", File.Tell(), m_RecordType.Name, REQSIZE, m_RecordSize); } \
						else if (m_RecordSize != REQSIZE) { \
							SystemLog.Printf("0x%08X: Warning: Bad subrecord size for %4.4s! Expected %d but found %d bytes!", File.Tell(), m_RecordType.Name, REQSIZE, m_RecordSize); }

#else

  #define SR_VERIFY_SUBRECORDSIZE(REQSIZE) if (m_RecordSize != REQSIZE) { \
						return AddSrUserError(SRERR_USER_BADINPUT, "0x%08X: Bad subrecord size for %4.4s! Expected %d but found %d bytes!", File.Tell(), m_RecordType.Name, REQSIZE, m_RecordSize); }

  #define SR_VERIFY_SUBRECORDSIZE_MAX(REQSIZE) if (m_RecordSize > REQSIZE) { \
						return AddSrUserError(SRERR_USER_BADINPUT, "0x%08X: Bad subrecord size for %4.4s! Expected %d or less but found %d bytes!", File.Tell(), m_RecordType.Name, REQSIZE, m_RecordSize); }

#endif

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

  class CSrRecordHandler;
  class CSrStringFile;

#pragma pack(push, 1)

	/* Subrecord header type */
  struct srsubrecheader_t 
  {
	srrectype_t	Type;
	word		Size;
  };

#pragma pack(pop)

	/* Pointer to a class method to create a sub-record object */
  class CSrSubrecord;
  typedef CSrSubrecord* (*SRSUBREC_CREATEFUNC) (void);

	/* Structure to hold information on subrecord creation */
  struct srsubrecentries_t
  {
	const srrectype_t*	pName;
	SRSUBREC_CREATEFUNC	CreateMethod;
  };

  struct srsubreccreate_t
  {
	const srsubreccreate_t*  pBaseCreate;
	const srsubrecentries_t* pEntries;
  };

	/* Shortcut comparison operators */
  inline bool operator== (const srsubrecentries_t& Rec, const srrectype_t& Type) { return (Rec.pName != NULL && *Rec.pName == Type); }
   
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrSubrecord {
  DECLARE_SRBASE(CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  srrectype_t	m_RecordType;			/* Subrecord header data */
  dword			m_RecordSize;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Output the raw subrecord data */
  virtual bool ReadData  (CSrFile& File);
  virtual bool WriteData (CSrFile& File);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrSubrecord();
  virtual ~CSrSubrecord();
  virtual void Destroy (void);

	/* Change any matching formid in the subrecord */
  virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) { return (0); }

	/* Compare two subrecord fields */
  virtual bool CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord);

	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord);

  virtual bool CopyFull (CSrSubrecord* pSubrecord)
  {
	  if (pSubrecord == NULL) return false;
	  m_RecordSize = pSubrecord->GetRecordSize();
	  m_RecordType = pSubrecord->GetRecordType();
	  return Copy(pSubrecord);
  }
  
  virtual CSrSubrecord* CreateV (void) = 0;

  virtual CSrSubrecord* CreateCopy (void)
  {
		CSrSubrecord* pNew = CreateV();
		pNew->m_RecordSize = this->m_RecordSize;
		pNew->m_RecordType = this->m_RecordType;
		pNew->Copy(this);
		return pNew;
  }

	/* Count uses of the given form */
  virtual dword CountUses (const srformid_t FormID) { return (0); }

	/* Create a class instance */
  //static CSrSubrecord* Create (void) { return (new CSrSubrecord); }

	/* Find data in the subrecord */
  virtual dword Search     (srfinddata_t& FindData);
  virtual dword SearchText (srfinddata_t& FindData);

	/* Fix any form id in the subrecord */
  virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) { return (true); }

  	/* Used when reading records */
  void Initialize (const srsubrecheader_t Header) { m_RecordType = Header.Type; m_RecordSize = Header.Size; }
  void Initialize (const srrectype_t Type, const dword Size) { m_RecordType = Type; m_RecordSize = Size; }

  	/* Get a string representation of a subrecord field */
  virtual bool GetField (CSString& Buffer, const int FieldID);

	/* Get size when output to file */
  virtual dword GetOutputSize (void) { return (GetRecordSize() + SR_SUBRECORD_HEADERSIZE); }

	/* Get class members */
  srrectype_t	GetRecordType (void)       { return (m_RecordType); }
  virtual dword	GetRecordSize (void) const { return (m_RecordSize); }
  virtual byte*	GetData       (void)       { return (NULL); }

	/* Initialize a new record */
  virtual void InitializeNew (void) { }
  void InitializeNew (const srrectype_t Type, const dword Size) { m_RecordType = Type; m_RecordSize = Size; InitializeNew(); }

  virtual void LoadLocalStrings (CSrRecordHandler* pHandler) { }
  virtual void SetLoadLocalString (const bool LoadLocal) { }
 
	/* Input/Output the subrecord to a file */
  virtual bool Read  (CSrFile& File);
  virtual bool Write (CSrFile& File);
  
	/* Set class members */
  void SetSpecialSize (const dword Size = 0) { m_RecordSize = Size; }

  virtual void UpdateLocalStrings(CSrStringFile& StringFile, srlstringid_t& NextStringID) { }

};

  typedef CSrPtrArray<CSrSubrecord>    CSrSubrecordArray;
  typedef CSrRefPtrArray<CSrSubrecord> CSrRefSubrecordArray;

/*===========================================================================
 *		End of Class CSrSubrecord Definition
 *=========================================================================*/
 

/*===========================================================================
 *
 * Begin Function Definitions
 *
 *=========================================================================*/

  bool ReadSrSubRecordHeader (CSrFile& File, srsubrecheader_t& Header);

/*===========================================================================
 *		End of Function Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSubRecord.H
 *=========================================================================*/
