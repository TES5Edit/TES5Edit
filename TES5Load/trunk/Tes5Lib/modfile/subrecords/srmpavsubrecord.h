/*===========================================================================
 *
 * File:		SrMpavSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	11 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRMPAVSUBRECORD_H
#define __SRMPAVSUBRECORD_H


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

  #define SR_MPAV_SUBRECORD_SIZE	32

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srmpavdata_t 
	{
		dword Unknown[8];
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrMpavSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrMpavSubrecord : public CSrSubrecord 
{
  DECLARE_SRCLASS(CSrMpavSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srmpavdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_MPAV_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_MPAV_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_MPAV_SUBRECORD_SIZE) return File.Write(&m_Data, SR_MPAV_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	CSrMpavSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrMpavSubrecord* pSubrecord1 = SrCastClassNull(CSrMpavSubrecord, pSubrecord);
		m_RecordSize = SR_MPAV_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->m_Data;
		else 
			memset(&m_Data, 0, sizeof(m_Data));

		return (true);
	}

  		/* Create a class instance */
	static CSrSubrecord* Create (void) { return (new CSrMpavSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrMpavSubrecord); }

		/* Get class members */
	srmpavdata_t&  GetMpavData  (void) { return (m_Data); }
	virtual byte*  GetData      (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_MPAV_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrMpavSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAlchDataSubrecord.H
 *=========================================================================*/
