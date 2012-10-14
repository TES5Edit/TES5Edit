/*===========================================================================
 *
 * File:		SrAtkdSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	11 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRATKDSUBRECORD_H
#define __SRATKDSUBRECORD_H


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

  #define SR_ATKD_SUBRECORD_SIZE	44

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct sratkddata_t 
	{
		float		Unknown1;
		float		Unknown2;
		float		Unknown3;
		dword		Unknown4;
		float		Unknown5;
		float		Unknown6;
		float		Unknown7;
		srformid_t	Keyword;
		float		Unknown8;
		float		Unknown9;
		float		Unknown10;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrAtkdSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrAtkdSubrecord : public CSrSubrecord 
{
  DECLARE_SRCLASS(CSrAtkdSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	sratkddata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_ATKD_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_ATKD_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_ATKD_SUBRECORD_SIZE) return File.Write(&m_Data, SR_ATKD_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	CSrAtkdSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrAtkdSubrecord* pSubrecord1 = SrCastClassNull(CSrAtkdSubrecord, pSubrecord);
		m_RecordSize = SR_ATKD_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->m_Data;
		else 
			memset(&m_Data, 0, sizeof(m_Data));

		return (true);
	}

	 virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
	 {

		if (m_Data.Keyword == OldID) 
		{
			m_Data.Keyword = NewID;
			return 1;
		}

		return 0; 
	}

	virtual dword CountUses (const srformid_t FormID) 
	{
		return FormID == m_Data.Keyword;
	}

	virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) 
	{
		return SrFixupFormid(m_Data.Keyword, m_Data.Keyword, FixupArray);
	}

  		/* Create a class instance */
	static  CSrSubrecord* Create  (void) { return (new CSrAtkdSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrAtkdSubrecord); }

		/* Get class members */
	sratkddata_t&  GetAttackData  (void) { return (m_Data); }
	virtual byte*  GetData        (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_ATKD_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrAtkdSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAlchDataSubrecord.H
 *=========================================================================*/
