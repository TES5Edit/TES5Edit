/*===========================================================================
 *
 * File:		SrSpedSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	11 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRSPEDSUBRECORD_H
#define __SRSPEDSUBRECORD_H


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

  #define SR_SPED_SUBRECORD_SIZE	44

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srspeddata_t 
	{
		float Unknown[11];
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSpedSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrSpedSubrecord : public CSrSubrecord 
{
  DECLARE_SRCLASS(CSrSpedSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srspeddata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SPED_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_SPED_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SPED_SUBRECORD_SIZE) return File.Write(&m_Data, SR_SPED_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	CSrSpedSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrSpedSubrecord* pSubrecord1 = SrCastClassNull(CSrSpedSubrecord, pSubrecord);
		m_RecordSize = SR_SPED_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->m_Data;
		else 
			memset(&m_Data, 0, sizeof(m_Data));

		return (true);
	}

  		/* Create a class instance */
	static CSrSubrecord* Create (void) { return (new CSrSpedSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrSpedSubrecord); }

		/* Get class members */
	srspeddata_t&  GetSpedData  (void) { return (m_Data); }
	virtual byte*  GetData      (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_SPED_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrSpedSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSpedSubrecord.H
 *=========================================================================*/
