/*===========================================================================
 *
 * File:		SrSopmSnamSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	7 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRSOPMSNAMSUBRECORD_H
#define __SRSOPMSNAMSUBRECORD_H


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

	#define SR_SOPMSNAM_SUBRECORD_SIZE	16

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srsopmsnamdata_t 
	{
		byte	Unknown[16];
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSopmSnamSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrSopmSnamSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrSopmSnamSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srsopmsnamdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SOPMSNAM_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_SOPMSNAM_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SOPMSNAM_SUBRECORD_SIZE) return File.Write(&m_Data, SR_SOPMSNAM_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrSopmSnamSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

 		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrSopmSnamSubrecord* pSubrecord1 = SrCastClassNull(CSrSopmSnamSubrecord, pSubrecord);
		m_RecordSize = SR_SOPMSNAM_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->m_Data;
		else
			memset(&m_Data, 0, sizeof(m_Data));
	
		return (true);
	}

  		/* Create a class instance */
	static CSrSubrecord* Create (void) { return (new CSrSopmSnamSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrSopmSnamSubrecord); }

		/* Get class members */
	srsopmsnamdata_t&  GetSopmData (void) { return (m_Data); }
	virtual byte*	   GetData     (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_SOPMSNAM_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrSopmSnamSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSopmSnamSubrecord.H
 *=========================================================================*/
