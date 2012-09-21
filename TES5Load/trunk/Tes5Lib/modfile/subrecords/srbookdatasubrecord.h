/*===========================================================================
 *
 * File:		SrBookDatasubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	17 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRBOOKDATASUBRECORD_H
#define __SRBOOKDATASUBRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "srsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	#define SR_BOOKDATA_SUBRECORD_SIZE	16

	#define SR_BOOKFLAG_SKILL		0x0001
	#define SR_BOOKFLAG_SPELLTOME	0x0004
	#define SR_BOOKFLAG_SCROLL		0xFF00

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srbookdata_t 
	{
		dword	Flags;
		int 	SkillID;
		dword	Value;
		float	Weight;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrBookDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrBookDataSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrBookDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srbookdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_BOOKDATA_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_BOOKDATA_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_BOOKDATA_SUBRECORD_SIZE) return File.Write(&m_Data, SR_BOOKDATA_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrBookDataSubrecord() { }
  virtual void Destroy (void) { CSrSubrecord::Destroy(); }

		/* Change any matching formid in the subrecord */
  virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
  {
	if ((m_Data.Flags & SR_BOOKFLAG_SPELLTOME) == 0) return 0;

	if (m_Data.SkillID == OldID) 
	{
	  m_Data.SkillID = NewID;
	  return (1);
	}

	return (0); 
  }
  
  virtual dword CountUses (const srformid_t FormID) 
  {
	  if ((m_Data.Flags & SR_BOOKFLAG_SPELLTOME) != 0 && FormID == m_Data.SkillID) return 1;
	  return 0; 
  }

		/* Fixup the modindex of formids */
  virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) 
  {
	if ((m_Data.Flags & SR_BOOKFLAG_SPELLTOME) == 0) return false;
	return SrFixupFormid(*(srformid_t *)&m_Data.SkillID, m_Data.SkillID, FixupArray);
  }

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrBookDataSubrecord* pSubrecord1 = SrCastClassNull(CSrBookDataSubrecord, pSubrecord);
	m_RecordSize = SR_BOOKDATA_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetBookData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrBookDataSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrBookDataSubrecord; }

	/* Get class members */
  srbookdata_t&  GetBookData (void) { return (m_Data); }
  virtual byte*	 GetData      (void) { return (byte *)(&m_Data); }
  
	/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_BOOKDATA_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrBookDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrBookDatasubrecord.H
 *=========================================================================*/
