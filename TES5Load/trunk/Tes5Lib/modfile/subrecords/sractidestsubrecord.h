/*===========================================================================
 *
 * File:		SrActiDestSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	1 January 2021
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRACTIDESTSUBRECORD_H
#define __SRACTIDESTSUBRECORD_H


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

		/* Standard  subrecord size in bytes */
	#define SR_ACTIDEST_SUBRECORD_SIZE	8

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct sractidestdata_t 
	{
		dword		Unknown1;
		word		Unknown2;
		word		Unknown3;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrActiDestSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrActiDestSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrActiDestSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	sractidestdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

		/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_ACTIDEST_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_ACTIDEST_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_ACTIDEST_SUBRECORD_SIZE) return File.Write(&m_Data, SR_ACTIDEST_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
  CSrActiDestSubrecord() { }
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
  virtual bool Copy (CSrSubrecord* pSubrecord) 
  {
	CSrActiDestSubrecord* pSubrecord1 = SrCastClassNull(CSrActiDestSubrecord, pSubrecord);
	m_RecordSize = SR_ACTIDEST_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetDestData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  		/* Create a class instance */
  static CSrSubrecord*  Create  (void) { return (new CSrActiDestSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrActiDestSubrecord; }

		/* Get class members */
  sractidestdata_t& GetDestData   (void) { return (m_Data); }
  virtual byte*	    GetData       (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_ACTIDEST_SUBRECORD_SIZE; }
  
   
};
/*===========================================================================
 *		End of Class CSrActiDestSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrActiDestSubrecord.H
 *=========================================================================*/
