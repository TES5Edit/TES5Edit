/*===========================================================================
 *
 * File:		SrSopmOnamSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	7 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRSOPMONAMSUBRECORD_H
#define __SRSOPMONAMSUBRECORD_H


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

	#define SR_SOPMONAM_SUBRECORD_SIZE	24

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srsopmonamdata_t 
	{
		byte	Unknown[24];
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSopmOnamSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrSopmOnamSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrSopmOnamSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srsopmonamdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SOPMONAM_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_SOPMONAM_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SOPMONAM_SUBRECORD_SIZE) return File.Write(&m_Data, SR_SOPMONAM_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrSopmOnamSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

 		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrSopmOnamSubrecord* pSubrecord1 = SrCastClassNull(CSrSopmOnamSubrecord, pSubrecord);
		m_RecordSize = SR_SOPMONAM_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->m_Data;
		else
			memset(&m_Data, 0, sizeof(m_Data));
	
		return (true);
	}

  		/* Create a class instance */
	static CSrSubrecord* Create (void) { return (new CSrSopmOnamSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrSopmOnamSubrecord); }

		/* Get class members */
	srsopmonamdata_t&  GetSopmData (void) { return (m_Data); }
	virtual byte*	   GetData     (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_SOPMONAM_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrSopmOnamSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSopmOnamSubrecord.H
 *=========================================================================*/
