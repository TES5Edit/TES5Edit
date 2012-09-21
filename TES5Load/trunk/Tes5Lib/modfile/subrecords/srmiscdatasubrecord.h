/*===========================================================================
 *
 * File:		SrMiscDatasubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	17 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRMISCDATASUBRECORD_H
#define __SRMISCDATASUBRECORD_H


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

  #define SR_MISCDATA_SUBRECORD_SIZE	8

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srmiscdata_t 
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
 * Begin Class CSrMiscDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrMiscDataSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrMiscDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srmiscdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { if (m_RecordSize != SR_MISCDATA_SUBRECORD_SIZE) return false; return File.Read(&m_Data, SR_MISCDATA_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { if (m_RecordSize != SR_MISCDATA_SUBRECORD_SIZE) return false;return File.Write(&m_Data, SR_MISCDATA_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrMiscDataSubrecord() { }
  virtual void Destroy (void) { CSrSubrecord::Destroy(); }

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrMiscDataSubrecord* pSubrecord1 = SrCastClassNull(CSrMiscDataSubrecord, pSubrecord);
	m_RecordSize = SR_MISCDATA_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetMiscData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrMiscDataSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return (new CSrMiscDataSubrecord); }

	/* Get class members */
  srmiscdata_t&  GetMiscData (void) { return (m_Data); }
  virtual byte*	 GetData      (void) { return (byte *)(&m_Data); }
  
	/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_MISCDATA_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrMiscDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrMiscDatasubrecord.H
 *=========================================================================*/
