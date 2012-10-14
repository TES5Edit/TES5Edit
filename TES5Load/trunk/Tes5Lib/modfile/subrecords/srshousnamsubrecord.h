/*===========================================================================
 *
 * File:		SrShouSnamSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	2 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRSHOUSNAMSUBRECORD_H
#define __SRSHOUSNAMSUBRECORD_H


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

	#define SR_SHOUSNAM_SUBRECORD_SIZE	12

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srshousnamdata_t 
	{
		srformid_t	WordofPowerID;
		srformid_t	SpellID;
		float		RechargeTime;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrShouSnamSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrShouSnamSubrecord : public CSrSubrecord 
{
	DECLARE_SRCLASS(CSrShouSnamSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srshousnamdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

		/* Input/output the subrecord data */
	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SHOUSNAM_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_SHOUSNAM_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SHOUSNAM_SUBRECORD_SIZE) return File.Write(&m_Data, SR_SHOUSNAM_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrShouSnamSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) {
		CSrShouSnamSubrecord* pSubrecord1 = SrCastClassNull(CSrShouSnamSubrecord, pSubrecord);
		m_RecordSize = SR_SHOUSNAM_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
		{
			m_Data = pSubrecord1->GetShoutData();
		}
		else 
		{
		memset(&m_Data, 0, sizeof(m_Data));
		}

		return (true);
	}

	virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
	{
		if (m_Data.WordofPowerID == OldID) 
		{
			m_Data.WordofPowerID = NewID;
			return 1;
		}

		if (m_Data.SpellID == OldID) 
		{
			m_Data.SpellID = NewID;
			return 1;
		}

		return 0; 
	}

	virtual dword CountUses (const srformid_t FormID) 
	{
		return (dword)(FormID == m_Data.WordofPowerID ) + (dword)(FormID == m_Data.SpellID );
	}

	virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) 
	{
		bool Result = SrFixupFormid(m_Data.WordofPowerID, m_Data.WordofPowerID, FixupArray);
		Result &= SrFixupFormid(m_Data.SpellID, m_Data.SpellID, FixupArray);
		return Result;
	}

	 	/* Create a class instance */
	static CSrSubrecord* Create (void) { return (new CSrShouSnamSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrShouSnamSubrecord); }

		/* Get class members */
	srshousnamdata_t&  GetShoutData (void) { return (m_Data); }
	virtual byte*	     GetData      (void) { return (byte *)(&m_Data); }
	 
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_SHOUSNAM_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrShouSnamSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrShouSnamSubrecord.H
 *=========================================================================*/
