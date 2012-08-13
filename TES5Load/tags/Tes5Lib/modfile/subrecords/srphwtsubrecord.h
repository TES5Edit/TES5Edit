/*===========================================================================
 *
 * File:		SrPhwtSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	11 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRPHWTSUBRECORD_H
#define __SRPHWTSUBRECORD_H


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

  #define SR_PHWT_SUBRECORD_SIZE	64

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srphwtdata_t 
	{
		float Unknown[16];
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrPhwtSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrPhwtSubrecord : public CSrSubrecord 
{
  DECLARE_SRCLASS(CSrPhwtSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srphwtdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE_MAX(SR_PHWT_SUBRECORD_SIZE) return File.Read(&m_Data,  m_RecordSize); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE_MAX(SR_PHWT_SUBRECORD_SIZE) return File.Write(&m_Data, m_RecordSize); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	CSrPhwtSubrecord() : m_Data() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrPhwtSubrecord* pSubrecord1 = SrCastClassNull(CSrPhwtSubrecord, pSubrecord);
		m_RecordSize = SR_PHWT_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->m_Data;
		else 
			memset(&m_Data, 0, sizeof(m_Data));

		return (true);
	}

  		/* Create a class instance */
	static CSrSubrecord* Create (void) { return (new CSrPhwtSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrPhwtSubrecord); }

		/* Get class members */
	srphwtdata_t&  GetPhwtData  (void) { return (m_Data); }
	virtual byte*  GetData      (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_PHWT_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrPhwtSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAlchDataSubrecord.H
 *=========================================================================*/
