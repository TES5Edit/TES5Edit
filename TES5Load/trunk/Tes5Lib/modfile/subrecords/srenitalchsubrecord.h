/*===========================================================================
 *
 * File:		Srenitalchsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	12 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRENITALCHSUBRECORD_H
#define __SRENITALCHSUBRECORD_H


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

		/* Standard ENIT subrecord size in bytes */
	#define SRENITALCH_SUBRECORD_SIZE	20

	#define SRENITALCH_FLAG_MANUALCALC	0x00001
	#define SRENITALCH_FLAG_FOOD		0x00002
	#define SRENITALCH_FLAG_MEDICINE	0x10000
	#define SRENITALCH_FLAG_POISON		0x20000

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	/* Alchemy ENIT data structure */
struct srenitalchdata_t 
{
	dword		Value;
	dword		Flags;
	srformid_t	AddictionID;
	dword		AddictionChance;
	srformid_t	UseSoundID;
};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrEnitAlchSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrEnitAlchSubrecord : public CSrSubrecord 
{
	DECLARE_SRCLASS(CSrEnitAlchSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srenitalchdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

		/* Input/output the subrecord data */
	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE_MAX(SRENITALCH_SUBRECORD_SIZE) return File.Read(&m_Data,  m_RecordSize); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE_MAX(SRENITALCH_SUBRECORD_SIZE) return File.Write(&m_Data, m_RecordSize); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrEnitAlchSubrecord() {  }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

			/* Change any matching formid in the subrecord */
	virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
	{
		if (m_Data.UseSoundID == OldID) 
		{
			m_Data.UseSoundID = NewID;
			return 1;
		}

		if (m_Data.AddictionID == OldID) 
		{
			m_Data.AddictionID = NewID;
			return 1;
		}

		return 0;
	}

	virtual dword CountUses (const srformid_t FormID) 
	{
		if (FormID == m_Data.UseSoundID)  return 1;
		if (FormID == m_Data.AddictionID) return 1;
		return 0; 
	}

		/* Fixup the modindex of formids */
	virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) 
	{
		bool Result = SrFixupFormid(m_Data.UseSoundID, m_Data.UseSoundID, FixupArray);
		Result &= SrFixupFormid(m_Data.AddictionID, m_Data.AddictionID, FixupArray);
		return Result;
	}

  		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrEnitAlchSubrecord* pSubrecord1 = SrCastClassNull(CSrEnitAlchSubrecord, pSubrecord);
		m_RecordSize = SRENITALCH_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->m_Data;
		else 
			memset(&m_Data, 0, sizeof(m_Data));

		return (true);
	}

  		/* Create a class instance */
	static  CSrSubrecord* Create  (void) { return new CSrEnitAlchSubrecord; }
	virtual CSrSubrecord* CreateV (void) { return new CSrEnitAlchSubrecord; }

		/* Get class members */
	srenitalchdata_t& GetAlchData	(void) { return (m_Data); }
	virtual byte*	  GetData		(void) { return (byte *)(&m_Data); }
	bool              IsAutoCalc	(void) { return !CheckFlagBits(m_Data.Flags, SRENITALCH_FLAG_MANUALCALC); }
	bool              IsFood		(void) { return CheckFlagBits(m_Data.Flags, SRENITALCH_FLAG_FOOD); }
	bool              IsMedicine	(void) { return CheckFlagBits(m_Data.Flags, SRENITALCH_FLAG_MEDICINE); }
	bool              IsPoison		(void) { return CheckFlagBits(m_Data.Flags, SRENITALCH_FLAG_POISON); }
 	
		/* Initialize a new record */
	void InitializeNew (void)
	{
		CSrSubrecord::InitializeNew(); 
		memset(&m_Data, 0, sizeof(m_Data)); 
		m_RecordSize = SRENITALCH_SUBRECORD_SIZE;
	}

		/* Set class members */
	void SetAutoCalc       (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRENITALCH_FLAG_MANUALCALC, !Flag); }
	void SetFood           (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRENITALCH_FLAG_FOOD, Flag); }
	void SetMedicine       (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRENITALCH_FLAG_MEDICINE, Flag); }
	void SetPoison         (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRENITALCH_FLAG_POISON, Flag); }

};
/*===========================================================================
 *		End of Class CSrEnitAlchSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrEnitAlchsubrecord.H
 *=========================================================================*/
