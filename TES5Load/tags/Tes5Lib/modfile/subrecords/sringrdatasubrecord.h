/*===========================================================================
 *
 * File:		SrIngrDatasubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	17 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRINGRDATASUBRECORD_H
#define __SRINGRDATASUBRECORD_H


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

	/* Standard Ingrediant DATA subrecord size in bytes */
  #define SR_INGRDATA_SUBRECORD_SIZE	8

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct sringrdata_t 
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
 * Begin Class CSrIngrDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrIngrDataSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrIngrDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	sringrdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_INGRDATA_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_INGRDATA_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_INGRDATA_SUBRECORD_SIZE) return File.Write(&m_Data, SR_INGRDATA_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrIngrDataSubrecord() { }
  virtual void Destroy (void) { CSrSubrecord::Destroy(); }

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrIngrDataSubrecord* pSubrecord1 = SrCastClassNull(CSrIngrDataSubrecord, pSubrecord);
	m_RecordSize = SR_INGRDATA_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetIngrData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrIngrDataSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrIngrDataSubrecord; }

	/* Get class members */
  sringrdata_t&  GetIngrData (void) { return (m_Data); }
  virtual byte*	 GetData      (void) { return (byte *)(&m_Data); }
  
	/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_INGRDATA_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrIngrDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAlchdatasubrecord.H
 *=========================================================================*/
