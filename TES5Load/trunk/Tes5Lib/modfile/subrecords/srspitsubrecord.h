/*===========================================================================
 *
 * File:		Srspitsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	12 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRSPITSUBRECORD_H
#define __SRSPITSUBRECORD_H


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

	#define SRSPIT_SUBRECORD_SIZE	36

	#define SRSPIT_FLAG_MANUALCALC			0x00000001
	#define SRSPIT_FLAG_PCSTARTSPELL		0x00020000
	#define SRSPIT_FLAG_AREAIGNORESLOS		0x00080000
	#define SRSPIT_FLAG_IGNORERESIST		0x00100000
	#define SRSPIT_FLAG_NOABSORBREFLECT		0x00200000
	#define SRSPIT_FLAG_NODUALCASTMODS		0x00800000

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srspitdata_t 
	{
		dword		BaseCost;
		dword		Flags;
		int			SpellType;
		float		ChargeTime;
		int			CastType;
		int			TargetType;
		float		CastDuration;
		float		Range;
		srformid_t	PerkID;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSpitSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrSpitSubrecord : public CSrSubrecord 
{
	DECLARE_SRCLASS(CSrSpitSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srspitdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

		/* Input/output the subrecord data */
	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SRSPIT_SUBRECORD_SIZE) return File.Read(&m_Data,  m_RecordSize); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SRSPIT_SUBRECORD_SIZE) return File.Write(&m_Data, m_RecordSize); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrSpitSubrecord();
	virtual void Destroy (void);

		/* Change any matching formid in the subrecord */
	virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
	{
		if (m_Data.PerkID == OldID) 
		{
			m_Data.PerkID = NewID;
			return (1);
		}

		return (0); 
	}

	virtual dword CountUses (const srformid_t FormID) 
	{
		return (FormID == m_Data.PerkID);
	}

	virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) 
	{
		return SrFixupFormid(m_Data.PerkID, m_Data.PerkID, FixupArray);
	}

		/* Compare two subrecord fields */
	virtual bool CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord);

  		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrSpitSubrecord* pSubrecord1 = SrCastClassNull(CSrSpitSubrecord, pSubrecord);
		m_RecordSize = SRSPIT_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->m_Data;
		else 
			memset(&m_Data, 0, sizeof(m_Data));

		return (true);
	}

  		/* Create a class instance */
	static  CSrSubrecord* Create  (void) { return new CSrSpitSubrecord; }
	virtual CSrSubrecord* CreateV (void) { return new CSrSpitSubrecord; }

		/* Get class members */
	srspitdata_t& GetSpellData		(void) { return (m_Data); }
	virtual byte* GetData			(void) { return (byte *)(&m_Data); }
	bool          IsAutoCalc		(void) { return !CheckFlagBits(m_Data.Flags, SRSPIT_FLAG_MANUALCALC); }
	bool          IsAreaIgnoresLOS	(void) { return CheckFlagBits(m_Data.Flags, SRSPIT_FLAG_AREAIGNORESLOS); }
	bool          IsPCStartSpell	(void) { return CheckFlagBits(m_Data.Flags, SRSPIT_FLAG_PCSTARTSPELL); }
	bool          IsNoAbsorbReflect	(void) { return CheckFlagBits(m_Data.Flags, SRSPIT_FLAG_NOABSORBREFLECT); }
	bool          IsIgnoreResist	(void) { return CheckFlagBits(m_Data.Flags, SRSPIT_FLAG_IGNORERESIST); }
	bool          IsNoDualCastMods	(void) { return CheckFlagBits(m_Data.Flags, SRSPIT_FLAG_NODUALCASTMODS); }

  		/* Get a string representation of a subrecord field */
	bool GetField (CSString& Buffer, const int FieldID);
  	
		/* Initialize a new record */
	void InitializeNew (void);

		/* Set class members */
	void SetAutoCalc        (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRSPIT_FLAG_MANUALCALC, !Flag); }
	void SetAreaIgnoresLOS  (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRSPIT_FLAG_AREAIGNORESLOS, Flag); }
	void SetPCStartSpell    (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRSPIT_FLAG_PCSTARTSPELL, Flag); }
	void SetNoAbsorbReflect (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRSPIT_FLAG_NOABSORBREFLECT, Flag); }
	void SetIgnoreResist    (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRSPIT_FLAG_IGNORERESIST, Flag); }
	void SetNoDualCastMods  (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRSPIT_FLAG_NODUALCASTMODS, Flag); }

};
/*===========================================================================
 *		End of Class CSrSpitSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srenitsubrecord.H
 *=========================================================================*/
