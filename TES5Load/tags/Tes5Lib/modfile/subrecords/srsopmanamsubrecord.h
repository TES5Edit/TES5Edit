/*===========================================================================
 *
 * File:		SrSopmAnamSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	7 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRSOPMANAMSUBRECORD_H
#define __SRSOPMANAMSUBRECORD_H


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

	#define SR_SOPMANAM_SUBRECORD_SIZE	20

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srsopmanamdata_t 
	{
		dword	Unknown1;
		float	Unknown2;
		float	Unknown3;
		dword	Unknown4;
		dword	Unknown5;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSopmAnamSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrSopmAnamSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrSopmAnamSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srsopmanamdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SOPMANAM_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_SOPMANAM_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SOPMANAM_SUBRECORD_SIZE) return File.Write(&m_Data, SR_SOPMANAM_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrSopmAnamSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

 		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrSopmAnamSubrecord* pSubrecord1 = SrCastClassNull(CSrSopmAnamSubrecord, pSubrecord);
		m_RecordSize = SR_SOPMANAM_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->m_Data;
		else
			memset(&m_Data, 0, sizeof(m_Data));
	
		return (true);
	}

  		/* Create a class instance */
	static CSrSubrecord* Create (void) { return (new CSrSopmAnamSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrSopmAnamSubrecord); }

		/* Get class members */
	srsopmanamdata_t&  GetSopmData (void) { return (m_Data); }
	virtual byte*	   GetData     (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_SOPMANAM_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrSopmAnamSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSopmAnamSubrecord.H
 *=========================================================================*/
