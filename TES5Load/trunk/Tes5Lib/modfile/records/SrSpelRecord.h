/*===========================================================================
 *
 * File:		SrSpelrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrSpelRecord class.
 *
 *=========================================================================*/
#ifndef __SRSPELRECORD_H
#define __SRSPELRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srformidsubrecord.h"
	#include "../subrecords/srspitsubrecord.h"
    #include "../subrecords/srlstringsubrecord.h"
	#include "../subrecords/srefitsubrecord.h"
	#include "../subrecords/srctdasubrecord.h"
	#include "../subrecords/srboundssubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSpelRecord Definition
 *
 *=========================================================================*/
class CSrSpelRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrSpelRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrFormidSubrecord*		m_pEquipSlot;
	CSrBoundsSubrecord*		m_pBoundsData;
	CSrLStringSubrecord*	m_pItemName;
	CSrLStringSubrecord*	m_pDescription;
	CSrSpitSubrecord*		m_pSpellData;
	CSrFormidSubrecord*		m_pInventoryModel;

	static srspitdata_t	s_NullSpellData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrSpelRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrSpelRecord; }

		/* Get class members */
	srspitdata_t& GetSpellData (void) { return m_pSpellData ? m_pSpellData->GetSpellData() : s_NullSpellData; }

	dword       GetEffectCount  (void) { return CountSubrecords(SR_NAME_EFID); }
	const char* GetCastType     (void) { return GetSrEffectCastTypeString(GetSpellData().CastType); }
	const char* GetSpellType    (void) { return GetSrSpellTypeString(GetSpellData().SpellType); }
	const char* GetDeliveryType (void) { return GetSrMagicDeliveryTypeString(GetSpellData().TargetType); }

	bool IsAutoCalc			(void) { return m_pSpellData ? m_pSpellData->IsAutoCalc() : false; }
	bool IsAreaIgnoresLOS	(void) { return m_pSpellData ? m_pSpellData->IsAreaIgnoresLOS() : false; }
	bool IsPCStartSpell		(void) { return m_pSpellData ? m_pSpellData->IsPCStartSpell() : false; }
	bool IsNoAbsorbReflect	(void) { return m_pSpellData ? m_pSpellData->IsNoAbsorbReflect() : false; }
	bool IsIgnoreResist		(void) { return m_pSpellData ? m_pSpellData->IsIgnoreResist() : false; }
	bool IsNoDualCastMods	(void) { return m_pSpellData ? m_pSpellData->IsNoDualCastMods() : false; }

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

		/* Set class members */
	void SetCastType     (const char* pString) { GetSrEffectCastTypeValue(GetSpellData().CastType, pString); }
	void SetSpellType    (const char* pString) { GetSrSpellTypeValue(GetSpellData().SpellType, pString); }
	void SetDeliveryType (const char* pString) { GetSrMagicDeliveryTypeValue(GetSpellData().TargetType, pString); }

	void SetAutoCalc        (const bool Flag) { if (m_pSpellData) m_pSpellData->SetAutoCalc(Flag); }
	void SetAreaIgnoresLOS  (const bool Flag) { if (m_pSpellData) m_pSpellData->SetAreaIgnoresLOS(Flag); }
	void SetPCStartSpell    (const bool Flag) { if (m_pSpellData) m_pSpellData->SetPCStartSpell(Flag); }
	void SetNoAbsorbReflect (const bool Flag) { if (m_pSpellData) m_pSpellData->SetNoAbsorbReflect(Flag); }
	void SetIgnoreResist    (const bool Flag) { if (m_pSpellData) m_pSpellData->SetIgnoreResist(Flag); }
	void SetNoDualCastMods  (const bool Flag) { if (m_pSpellData) m_pSpellData->SetNoDualCastMods(Flag); }

		/* Begin field method definitions */
	DECLARE_SRFIELD_FULLNAME(CSrSpelRecord);
	DECLARE_SRFIELD_DESCRIPTION(CSrSpelRecord, SR_NAME_DESC);

	DECLARE_SRFIELD_DWORD1(CSrSpelRecord, EffectCount, GetEffectCount(), dword Tmp)
	DECLARE_SRFIELD_DWORD1(CSrSpelRecord, BaseCost, GetSpellData().BaseCost, GetSpellData().BaseCost)
	DECLARE_SRFIELD_DWORDFLAG1(CSrSpelRecord, SpellFlags, GetSpellData().Flags, GetSpellData().Flags)
	DECLARE_SRFIELD_FLOAT1(CSrSpelRecord, CastDuration, GetSpellData().CastDuration, GetSpellData().CastDuration)
	DECLARE_SRFIELD_FLOAT1(CSrSpelRecord, ChargeTime, GetSpellData().ChargeTime, GetSpellData().ChargeTime)
	DECLARE_SRFIELD_FLOAT1(CSrSpelRecord, Range, GetSpellData().Range, GetSpellData().Range)

	DECLARE_SRFIELD_METHOD(CSrSpelRecord, SpellType, GetSpellType, SetSpellType)
	DECLARE_SRFIELD_METHOD(CSrSpelRecord, CastType, GetCastType, SetCastType)
	DECLARE_SRFIELD_METHOD(CSrSpelRecord, DeliveryType, GetDeliveryType, SetDeliveryType)

	DECLARE_SRFIELD_BOOL(CSrSpelRecord, AutoCalc, IsAutoCalc, SetAutoCalc)
	DECLARE_SRFIELD_BOOL(CSrSpelRecord, AreaIgnoresLOS, IsAreaIgnoresLOS, SetAreaIgnoresLOS)
	DECLARE_SRFIELD_BOOL(CSrSpelRecord, PCStartSpell, IsPCStartSpell, SetPCStartSpell)
	DECLARE_SRFIELD_BOOL(CSrSpelRecord, NoAbsorbReflect, IsNoAbsorbReflect, SetNoAbsorbReflect)
	DECLARE_SRFIELD_BOOL(CSrSpelRecord, IgnoreResist, IsIgnoreResist, SetIgnoreResist)
	DECLARE_SRFIELD_BOOL(CSrSpelRecord, NoDualCastMods, IsNoDualCastMods, SetNoDualCastMods)

	DECLARE_SRFIELD_EDITORID2(CSrSpelRecord, Perk, GetSpellData().PerkID)
	DECLARE_SRFIELD_EDITORID1(CSrSpelRecord, InventoryModel, SR_NAME_MDOB)
	DECLARE_SRFIELD_EDITORID1(CSrSpelRecord, EquipSlot, SR_NAME_ETYP)

};
/*===========================================================================
 *		End of Class CSrSpelRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSpelRecord.H
 *=========================================================================*/
