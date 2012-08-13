/*===========================================================================
 *
 * File:		SrEcznDataSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	9 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRECZNDATASUBRECORD_H
#define __SRECZNDATASUBRECORD_H


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

	#define SR_ECZNDATA_SUBRECORD_SIZE	12

	#define SR_ENCOUNTERFLAG_RESET		0x01
	#define SR_ENCOUNTERFLAG_UNKNOWN1	0x02
	#define SR_ENCOUNTERFLAG_UNKNOWN2	0x04

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct sreczndata_t 
	{
		srformid_t	FactionID;
		srformid_t	LocationID;
		byte		Rank;
		byte		MinLevel;
		byte		Flags;
		byte		Unknown;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrEcznDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrEcznDataSubrecord : public CSrSubrecord 
{
	DECLARE_SRCLASS(CSrEcznDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	sreczndata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE_MAX(SR_ECZNDATA_SUBRECORD_SIZE) return File.Read(&m_Data,  m_RecordSize); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE_MAX(SR_ECZNDATA_SUBRECORD_SIZE) return File.Write(&m_Data, m_RecordSize); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrEcznDataSubrecord() { memset(&m_Data, 0, sizeof(m_Data)); }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

	  	/* Change any matching formid in the subrecord */
	virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
	{
		if (m_Data.LocationID == OldID)
		{
			m_Data.LocationID = NewID;
			return 1;
		}
		else if (m_Data.FactionID == OldID)
		{
			m_Data.FactionID = NewID;
			return 1;
		}

		return 0; 
	}

	virtual dword CountUses (const srformid_t FormID) 
	{
		if (m_Data.LocationID == FormID) return 1;
		if (m_Data.FactionID  == FormID) return 1;
		return 0;
	}

		/* Fixup the modindex of formids */
	virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) 
	{
		bool Result;
		Result  = SrFixupFormid(m_Data.LocationID, m_Data.LocationID, FixupArray);
		Result &= SrFixupFormid(m_Data.FactionID,  m_Data.FactionID,  FixupArray);
		return Result;
	}


	/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrEcznDataSubrecord* pSubrecord1 = SrCastClassNull(CSrEcznDataSubrecord, pSubrecord);
		m_RecordSize = SR_ECZNDATA_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->m_Data;	
		else
			memset(&m_Data, 0, sizeof(m_Data));
	
		return (true);
	}

  		/* Create a class instance */
	static CSrSubrecord* Create (void) { return (new CSrEcznDataSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrEcznDataSubrecord); }

		/* Get class members */
	sreczndata_t&  GetEncounterData (void) { return (m_Data); }
	virtual byte*  GetData          (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_ECZNDATA_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrEcznDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrEcznDataSubrecord.H
 *=========================================================================*/
