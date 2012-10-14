/*===========================================================================
 *
 * File:		Srarmodatasubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	17 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRARMODATASUBRECORD_H
#define __SRARMODATASUBRECORD_H


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

	/* Standard ARMO-DATA subrecord size in bytes */
  #define SR_ARMODATA_SUBRECORD_SIZE	8

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

  struct srarmordata_t 
  {
	dword	Value;
	float	Weight;
  };

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrArmoDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrArmoDataSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrArmoDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srarmordata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_ARMODATA_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_ARMODATA_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_ARMODATA_SUBRECORD_SIZE) return File.Write(&m_Data, SR_ARMODATA_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrArmoDataSubrecord() { }
  virtual void Destroy (void) { CSrSubrecord::Destroy(); }

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrArmoDataSubrecord* pSubrecord1 = SrCastClassNull(CSrArmoDataSubrecord, pSubrecord);
	m_RecordSize = SR_ARMODATA_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetArmorData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrArmoDataSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrArmoDataSubrecord; }

	/* Get class members */
  srarmordata_t& GetArmorData (void) { return (m_Data); }
  virtual byte*	 GetData      (void) { return (byte *)(&m_Data); }
  
	/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_ARMODATA_SUBRECORD_SIZE; }


   
};
/*===========================================================================
 *		End of Class CSrArmoDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrArmodatasubrecord.H
 *=========================================================================*/
