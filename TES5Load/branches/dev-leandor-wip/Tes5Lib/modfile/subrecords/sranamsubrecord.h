/*===========================================================================
 *
 * File:		SrAnamSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	17 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRANAMSUBRECORD_H
#define __SRANAMSUBRECORD_H


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

	#define SR_ANAM_SUBRECORD_SIZE	3

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct sranamdata_t 
	{
		dword	Unknown;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrAnamSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrAnamSubrecord : public CSrSubrecord 
{
	DECLARE_SRCLASS(CSrAnamSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	sranamdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { m_Data.Unknown = 0; SR_VERIFY_SUBRECORDSIZE(SR_ANAM_SUBRECORD_SIZE) return File.Read(&m_Data, SR_ANAM_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_ANAM_SUBRECORD_SIZE) return File.Write(&m_Data, SR_ANAM_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	CSrAnamSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrAnamSubrecord* pSubrecord1 = SrCastClassNull(CSrAnamSubrecord, pSubrecord);
		m_RecordSize = SR_ANAM_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
		{
			m_Data.Unknown = 0;
			m_Data = pSubrecord1->m_Data;
		}
		else 
			memset(&m_Data, 0, sizeof(m_Data));

		return (true);
	}

  		/* Create a class instance */
	static  CSrSubrecord* Create  (void) { return (new CSrAnamSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrAnamSubrecord); }

		/* Get class members */
	sranamdata_t&  GetAnamData  (void) { return (m_Data); }
	virtual byte*  GetData      (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_ANAM_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrAnamSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAnamSubrecord.H
 *=========================================================================*/
