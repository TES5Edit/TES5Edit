/*===========================================================================
 *
 * File:		SrSndrBnamSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	7 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRSNDRBNAMSUBRECORD_H
#define __SRSNDRBNAMSUBRECORD_H


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

	#define SR_SNDRBNAM_SUBRECORD_SIZE	6

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srsndrbnamdata_t 
	{
		word	Unknown1;
		word	Unknown2;
		word	Unknown3;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSndrBnamSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrSndrBnamSubrecord : public CSrSubrecord 
{
	DECLARE_SRCLASS(CSrSndrBnamSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srsndrbnamdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SNDRBNAM_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_SNDRBNAM_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SNDRBNAM_SUBRECORD_SIZE) return File.Write(&m_Data, SR_SNDRBNAM_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrSndrBnamSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }
  
 		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrSndrBnamSubrecord* pSubrecord1 = SrCastClassNull(CSrSndrBnamSubrecord, pSubrecord);
		m_RecordSize = SR_SNDRBNAM_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL)
			m_Data = pSubrecord1->m_Data;
		else
			memset(&m_Data, 0, sizeof(m_Data));

		return (true);
	}

  		/* Create a class instance */
	static CSrSubrecord* Create   (void) { return (new CSrSndrBnamSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrSndrBnamSubrecord); }

		/* Get class members */
	srsndrbnamdata_t&  GetSndrData (void) { return (m_Data); }
	virtual byte*	   GetData     (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_SNDRBNAM_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrSndrBnamSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSndrBnamSubrecord.H
 *=========================================================================*/
