/*===========================================================================
 *
 * File:		SrAlchdatasubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	17 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRALCHDATASUBRECORD_H
#define __SRALCHDATASUBRECORD_H


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
  #define SR_ALCHDATA_SUBRECORD_SIZE	4

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

  struct sralchdata_t 
  {
	float	Weight;
  };

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrAlchDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrAlchDataSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrAlchDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	sralchdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_ALCHDATA_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_ALCHDATA_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_ALCHDATA_SUBRECORD_SIZE) return File.Write(&m_Data, SR_ALCHDATA_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrAlchDataSubrecord() { }
  virtual void Destroy (void) { CSrSubrecord::Destroy(); }

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrAlchDataSubrecord* pSubrecord1 = SrCastClassNull(CSrAlchDataSubrecord, pSubrecord);
	m_RecordSize = SR_ALCHDATA_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetAlchData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrAlchDataSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrAlchDataSubrecord; }

	/* Get class members */
  sralchdata_t&  GetAlchData (void) { return (m_Data); }
  virtual byte*	 GetData      (void) { return (byte *)(&m_Data); }
  
	/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_ALCHDATA_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrAlchDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAlchdatasubrecord.H
 *=========================================================================*/
