/*===========================================================================
 *
 * File:		SrArmaDnamSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	1 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRARMADNAMSUBRECORD_H
#define __SRARMADNAMSUBRECORD_H


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

	#define SR_ARMADNAM_SUBRECORD_SIZE	12

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srarmadnamdata_t 
	{
		dword	Unknown1;
		dword	Unknown2;
		float	Unknown3;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrArmaDnamSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrArmaDnamSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrArmaDnamSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srarmadnamdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_ARMADNAM_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_ARMADNAM_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_ARMADNAM_SUBRECORD_SIZE) return File.Write(&m_Data, SR_ARMADNAM_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrArmaDnamSubrecord() { }
  virtual void Destroy (void) { CSrSubrecord::Destroy(); }

    	/* Change any matching formid in the subrecord */
  virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
  {
	return (0); 
  }

  virtual dword CountUses (const srformid_t FormID) 
  {
	  return 0;
  }
	
  	/* Fixup the modindex of formids */
  virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) 
  {
	return true;
  }


 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrArmaDnamSubrecord* pSubrecord1 = SrCastClassNull(CSrArmaDnamSubrecord, pSubrecord);
	m_RecordSize = SR_ARMADNAM_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetDnamData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrArmaDnamSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return (new CSrArmaDnamSubrecord); }

	/* Get class members */
  srarmadnamdata_t&  GetDnamData (void) { return (m_Data); }
  virtual byte*	     GetData      (void) { return (byte *)(&m_Data); }
  
	/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_ARMADNAM_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrArmaDnamSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrDnamsubrecord.H
 *=========================================================================*/
