/*===========================================================================
 *
 * File:		SrCoedSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	16 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRCOEDSUBRECORD_H
#define __SRCOEDSUBRECORD_H


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

  #define SR_COED_SUBRECORD_SIZE	12

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srcoeddata_t 
	{
		srformid_t	FactionID;
		dword		MinRank;
		float		Condition;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrCoedSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrCoedSubrecord : public CSrSubrecord 
{
  DECLARE_SRCLASS(CSrCoedSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srcoeddata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_COED_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_COED_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_COED_SUBRECORD_SIZE) return File.Write(&m_Data, SR_COED_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	CSrCoedSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrCoedSubrecord* pSubrecord1 = SrCastClassNull(CSrCoedSubrecord, pSubrecord);
		m_RecordSize = SR_COED_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->m_Data;
		else 
			memset(&m_Data, 0, sizeof(m_Data));

		return (true);
	}

	 virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
	 {

		if (m_Data.FactionID == OldID) 
		{
			m_Data.FactionID = NewID;
			return 1;
		}

		return 0; 
	}

	virtual dword CountUses (const srformid_t FormID) 
	{
		return FormID == m_Data.FactionID;
	}

	virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) 
	{
		return SrFixupFormid(m_Data.FactionID, m_Data.FactionID, FixupArray);
	}

  		/* Create a class instance */
	static  CSrSubrecord* Create  (void) { return (new CSrCoedSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrCoedSubrecord); }

		/* Get class members */
	srcoeddata_t&  GetCoedData  (void) { return (m_Data); }
	virtual byte*  GetData      (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_COED_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrCoedSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAlchDataSubrecord.H
 *=========================================================================*/
