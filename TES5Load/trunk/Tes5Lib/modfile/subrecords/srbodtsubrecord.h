/*===========================================================================
 *
 * File:		SrBodtsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	17 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRBODTSUBRECORD_H
#define __SRBODTSUBRECORD_H


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

		/* Standard BODT subrecord size in bytes */
	#define SR_BODT_SUBRECORD_SIZE	12

	#define SR_BODT_FLAG_NONPLAYABLE 0x10

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

  struct srbodtdata_t 
  {
		dword	BodyParts;
		dword	Flags;
		int  	ArmorType;
  };

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrBodtSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrBodtSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrBodtSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srbodtdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { m_Data.ArmorType = 0; SR_VERIFY_SUBRECORDSIZE_MAX(SR_BODT_SUBRECORD_SIZE) return File.Read(&m_Data, GetRecordSize()); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE_MAX(SR_BODT_SUBRECORD_SIZE) return File.Write(&m_Data, GetRecordSize()); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrBodtSubrecord() { }
  virtual void Destroy (void) { CSrSubrecord::Destroy(); }

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrBodtSubrecord* pSubrecord1 = SrCastClassNull(CSrBodtSubrecord, pSubrecord);
	m_RecordSize = pSubrecord->GetRecordSize();

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetBodtData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrBodtSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrBodtSubrecord; }

	/* Get class members */
  srbodtdata_t& GetBodtData  (void) { return (m_Data); }
  virtual byte*	GetData      (void) { return (byte *)(&m_Data); }
  
	/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_BODT_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrBodtSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrBodtSubrecord.H
 *=========================================================================*/
