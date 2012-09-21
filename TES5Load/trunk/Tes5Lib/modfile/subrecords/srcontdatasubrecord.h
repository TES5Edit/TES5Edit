/*===========================================================================
 *
 * File:		SrContdatasubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	17 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRCONTDATASUBRECORD_H
#define __SRCONTDATASUBRECORD_H


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

	#define SR_CONTDATA_SUBRECORD_SIZE	5

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srcontdata_t 
	{
		int 	Type;
		byte	Padding;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrContDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrContDataSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrContDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srcontdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

		/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { if (m_RecordSize != SR_CONTDATA_SUBRECORD_SIZE) return false; return File.Read(&m_Data,  SR_CONTDATA_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { if (m_RecordSize != SR_CONTDATA_SUBRECORD_SIZE) return false; return File.Write(&m_Data, SR_CONTDATA_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
  CSrContDataSubrecord() { }
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
	CSrContDataSubrecord* pSubrecord1 = SrCastClassNull(CSrContDataSubrecord, pSubrecord);
	m_RecordSize = SR_CONTDATA_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetContData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  		/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrContDataSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return (new CSrContDataSubrecord); }  

		/* Get class members */
  srcontdata_t& GetContData   (void) { return (m_Data); }
  virtual byte*	GetData       (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_CONTDATA_SUBRECORD_SIZE; }
  
   
};
/*===========================================================================
 *		End of Class CSrContDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrContDataSubrecord.H
 *=========================================================================*/
