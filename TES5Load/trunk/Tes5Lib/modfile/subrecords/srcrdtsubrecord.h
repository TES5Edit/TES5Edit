/*===========================================================================
 *
 * File:		SrCrdtSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	21 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRCRDTSUBRECORD_H
#define __SRCRDTSUBRECORD_H


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

  #define SR_CRDT_SUBRECORD_SIZE	16

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

  struct srcrdtdata_t 
  {
	  dword Unknown1;
	  float Unknown2;
	  int   Unknown3;
	  dword Unknown4;
  };

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrCrdtSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrCrdtSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrCrdtSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srcrdtdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { m_Data.Unknown4 = 0; SR_VERIFY_SUBRECORDSIZE_MAX(SR_CRDT_SUBRECORD_SIZE) return File.Read(&m_Data,  m_RecordSize); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE_MAX(SR_CRDT_SUBRECORD_SIZE) return File.Write(&m_Data, m_RecordSize); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrCrdtSubrecord() { }
  virtual void Destroy (void) { CSrSubrecord::Destroy(); }

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrCrdtSubrecord* pSubrecord1 = SrCastClassNull(CSrCrdtSubrecord, pSubrecord);
	m_RecordSize = SR_CRDT_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetCrdtData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrCrdtSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrCrdtSubrecord; }

	/* Get class members */
  srcrdtdata_t& GetCrdtData   (void) { return (m_Data); }
  virtual byte*	GetData       (void) { return (byte *)(&m_Data); }
  
	/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_CRDT_SUBRECORD_SIZE; }
     
};
/*===========================================================================
 *		End of Class CSrCrdtSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrCrdtsubrecord.H
 *=========================================================================*/
