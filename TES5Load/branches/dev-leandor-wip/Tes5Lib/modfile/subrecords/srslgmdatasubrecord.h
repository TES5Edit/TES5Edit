/*===========================================================================
 *
 * File:		SrSlgmDataSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	1 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRSLGMDATASUBRECORD_H
#define __SRSLGMDATASUBRECORD_H


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

  #define SR_SLGMDATA_SUBRECORD_SIZE	8

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

  struct srslgmdata_t 
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
 * Begin Class CSrSlgmDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrSlgmDataSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrSlgmDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srslgmdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SLGMDATA_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_SLGMDATA_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SLGMDATA_SUBRECORD_SIZE) return File.Write(&m_Data, SR_SLGMDATA_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrSlgmDataSubrecord() { }
  virtual void Destroy (void) { CSrSubrecord::Destroy(); }

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrSlgmDataSubrecord* pSubrecord1 = SrCastClassNull(CSrSlgmDataSubrecord, pSubrecord);
	m_RecordSize = SR_SLGMDATA_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetSlgmData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrSlgmDataSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrSlgmDataSubrecord; }

	/* Get class members */
  srslgmdata_t&  GetSlgmData (void) { return (m_Data); }
  virtual byte*	 GetData     (void) { return (byte *)(&m_Data); }
  
	/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_SLGMDATA_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrSlgmDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSlgmDatasubrecord.H
 *=========================================================================*/
