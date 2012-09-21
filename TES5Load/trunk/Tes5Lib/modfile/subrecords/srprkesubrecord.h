/*===========================================================================
 *
 * File:		SrPrksSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	2 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRPRKESUBRECORD_H
#define __SRPRKESUBRECORD_H


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

	#define SR_PRKE_SUBRECORD_SIZE	3

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srprkedata_t 
	{
		byte	Type;
		byte	Rank;
		byte	Priority;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrPrkeSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrPrkeSubrecord : public CSrSubrecord {
	DECLARE_SRCLASS(CSrPrkeSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srprkedata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

		/* Input/output the subrecord data */
	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_PRKE_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_PRKE_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_PRKE_SUBRECORD_SIZE) return File.Write(&m_Data, SR_PRKE_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrPrkeSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

 		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrPrkeSubrecord* pSubrecord1 = SrCastClassNull(CSrPrkeSubrecord, pSubrecord);
		m_RecordSize = SR_PRKE_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->GetPrkeData();
		else
			memset(&m_Data, 0, sizeof(m_Data));
	
		return (true);
	}

  		/* Create a class instance */
	static CSrSubrecord* Create (void) { return (new CSrPrkeSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return new CSrPrkeSubrecord; }

		/* Get class members */
	srprkedata_t&  GetPrkeData (void) { return (m_Data); }
	virtual byte*  GetData     (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_PRKE_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrPrkeSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrPrkeSubrecord.H
 *=========================================================================*/
