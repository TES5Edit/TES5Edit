/*===========================================================================
 *
 * File:		SrScrlatasubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	17 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRSCRLDATASUBRECORD_H
#define __SRSCRLDATASUBRECORD_H


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

	#define SR_SCRLDATA_SUBRECORD_SIZE	8

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

  struct srscrldata_t 
  {
	dword   Value;
	float	Weight;
  };

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrScrlDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrScrlDataSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrScrlDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srscrldata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SCRLDATA_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_SCRLDATA_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SCRLDATA_SUBRECORD_SIZE) return File.Write(&m_Data, SR_SCRLDATA_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrScrlDataSubrecord() { }
  virtual void Destroy (void) { CSrSubrecord::Destroy(); }

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrScrlDataSubrecord* pSubrecord1 = SrCastClassNull(CSrScrlDataSubrecord, pSubrecord);
	m_RecordSize = SR_SCRLDATA_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetScrlData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrScrlDataSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrScrlDataSubrecord; }

	/* Get class members */
  srscrldata_t&  GetScrlData (void) { return (m_Data); }
  virtual byte*	 GetData     (void) { return (byte *)(&m_Data); }
  
	/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_SCRLDATA_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrScrlDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrScrlDatasubrecord.H
 *=========================================================================*/
