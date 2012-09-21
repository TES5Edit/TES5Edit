/*===========================================================================
 *
 * File:		SrDnamsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	17 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRDNAMSUBRECORD_H
#define __SRDNAMSUBRECORD_H


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

	#define SR_DNAM_SUBRECORD_SIZE	8

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srdnamdata_t 
	{
		float		Scale;
		srformid_t	MaterialID;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrDnamSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrDnamSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrDnamSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srdnamdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_DNAM_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_DNAM_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_DNAM_SUBRECORD_SIZE) return File.Write(&m_Data, SR_DNAM_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrDnamSubrecord() { }
  virtual void Destroy (void) { CSrSubrecord::Destroy(); }

    	/* Change any matching formid in the subrecord */
  virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
  {
	if (m_Data.MaterialID == OldID) {
	  m_Data.MaterialID = NewID;
	  return (1);
	}
	return (0); 
  }

  virtual dword CountUses (const srformid_t FormID) 
  {
	  return (FormID == m_Data.MaterialID );
  }
	
  	/* Fixup the modindex of formids */
  virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) 
  {
	return SrFixupFormid(m_Data.MaterialID, m_Data.MaterialID , FixupArray);
  }


 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrDnamSubrecord* pSubrecord1 = SrCastClassNull(CSrDnamSubrecord, pSubrecord);
	m_RecordSize = SR_DNAM_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetDnamData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrDnamSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrDnamSubrecord; }

	/* Get class members */
  srdnamdata_t&  GetDnamData (void) { return (m_Data); }
  virtual byte*	 GetData      (void) { return (byte *)(&m_Data); }
  
	/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_DNAM_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrDnamSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrDnamsubrecord.H
 *=========================================================================*/
