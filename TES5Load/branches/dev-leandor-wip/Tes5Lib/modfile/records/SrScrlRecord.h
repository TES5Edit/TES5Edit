/*===========================================================================
 *
 * File:		SrScrlrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrScrlRecord class.
 *
 *=========================================================================*/
#ifndef __SRSCRLRECORD_H
#define __SRSCRLRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sritem1record.h"
	#include "../subrecords/srlstringsubrecord.h"
	#include "../subrecords/srscrlspitsubrecord.h"
	#include "../subrecords/srscrldatasubrecord.h"
	#include "../subrecords/srefitsubrecord.h"
	#include "../subrecords/srctdasubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrScrlRecord Definition
 *
 *=========================================================================*/
class CSrScrlRecord : public CSrItem1Record 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrScrlRecord, CSrItem1Record)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrFormidSubrecord*		m_pEquipSlot;
	CSrLStringSubrecord*	m_pDescription;
	CSrFormidSubrecord*		m_pInventoryModel;
	CSrScrlDataSubrecord*	m_pScrlData;
	CSrScrlSpitSubrecord*	m_pSpitData;

	static srscrldata_t	    s_NullScrollData;
	static srscrlspitdata_t	s_NullSpitData;
	

  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:
	
		/* Class Constructors/Destructors */
	CSrScrlRecord();
	virtual void Destroy (void);
	
	   	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrScrlRecord; }
	
		/* Get class members */
	srscrldata_t&     GetScrollData (void) { return m_pScrlData ? m_pScrlData->GetScrlData()   : s_NullScrollData; }
	srscrlspitdata_t& GetSpitData   (void) { return m_pSpitData ? m_pSpitData->GetScrollData() : s_NullSpitData; }
	dword GetEffectCount (void) { return CountSubrecords(SR_NAME_EFID); }

	const char* GetDeliveryType (void) { return GetSrMagicDeliveryTypeString(GetSpitData().TargetType); }
	const char* GetCastType     (void) { return GetSrEffectCastTypeString(GetSpitData().CastType); }

	bool IsAutoCalc				(void) { return m_pSpitData ? m_pSpitData->IsAutoCalc() : false; }
	bool IsAreaIgnoresLOS		(void) { return m_pSpitData ? m_pSpitData->IsAreaIgnoresLOS() : false; }
	bool IsNoAbsorbReflect		(void) { return m_pSpitData ? m_pSpitData->IsNoAbsorbReflect() : false; }
	bool IsScriptAlwaysApplies	(void) { return m_pSpitData ? m_pSpitData->IsScriptAlwaysApplies() : false; }
	bool IsForceExplode    		(void) { return m_pSpitData ? m_pSpitData->IsForceExplode() : false; }

  		/* Initialize a new record */
	void InitializeNew (void);
	
		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

		/* Set class members */
	void SetDeliveryType (const char* pString) { GetSrMagicDeliveryTypeValue(GetSpitData().TargetType, pString); }
	void SetCastType     (const char* pString) { GetSrEffectCastTypeValue(GetSpitData().CastType, pString); }
	
	void SetAutoCalc            (const bool  Flag)  { if (m_pSpitData) m_pSpitData->SetAutoCalc(Flag); }
	void SetAreaIgnoresLOS      (const bool  Flag)  { if (m_pSpitData) m_pSpitData->SetAreaIgnoresLOS(Flag); }
	void SetNoAbsorbReflect     (const bool  Flag)  { if (m_pSpitData) m_pSpitData->SetNoAbsorbReflect(Flag); }
	void SetScriptAlwaysApplies (const bool  Flag)  { if (m_pSpitData) m_pSpitData->SetScriptAlwaysApplies(Flag); }
	void SetForceExplode        (const bool  Flag)  { if (m_pSpitData) m_pSpitData->SetForceExplode(Flag); }

		/* Begin field method definitions */
	DECLARE_SRFIELD_DESCRIPTION(CSrScrlRecord, SR_NAME_DESC)

	DECLARE_SRFIELD_DWORD1(CSrScrlRecord, EffectCount, GetEffectCount(), dword Tmp);
	DECLARE_SRFIELD_DWORD1(CSrScrlRecord, Value, GetScrollData().Value, GetScrollData().Value)
	DECLARE_SRFIELD_FLOAT1(CSrScrlRecord, Range, GetSpitData().Range, GetSpitData().Range)
	DECLARE_SRFIELD_FLOAT1(CSrScrlRecord, Weight, GetScrollData().Weight, GetScrollData().Weight)
	DECLARE_SRFIELD_DWORD1(CSrScrlRecord, BaseCost, GetSpitData().BaseCost, GetSpitData().BaseCost)
	DECLARE_SRFIELD_FLOAT1(CSrScrlRecord, ChargeTime, GetSpitData().ChargeTime, GetSpitData().ChargeTime)
	DECLARE_SRFIELD_DWORD1(CSrScrlRecord, CastDuration, GetSpitData().CastDuration, GetSpitData().CastDuration)

	DECLARE_SRFIELD_METHOD(CSrScrlRecord, DeliveryType, GetDeliveryType, SetDeliveryType)
	DECLARE_SRFIELD_METHOD(CSrScrlRecord, CastType, GetCastType, SetCastType)

	DECLARE_SRFIELD_BOOL(CSrScrlRecord, AutoCalc, IsAutoCalc, SetAutoCalc)
	DECLARE_SRFIELD_BOOL(CSrScrlRecord, AreaIgnoresLOS, IsAreaIgnoresLOS, SetAreaIgnoresLOS)
	DECLARE_SRFIELD_BOOL(CSrScrlRecord, NoAbsorbReflect, IsNoAbsorbReflect, SetNoAbsorbReflect)
	DECLARE_SRFIELD_BOOL(CSrScrlRecord, ScriptAlwaysApplies, IsScriptAlwaysApplies, SetScriptAlwaysApplies)
	DECLARE_SRFIELD_BOOL(CSrScrlRecord, ForceExplode, IsForceExplode, SetForceExplode)
	
	DECLARE_SRFIELD_EDITORID1(CSrScrlRecord, EquipSlot, SR_NAME_ETYP)
	DECLARE_SRFIELD_EDITORID1(CSrScrlRecord, InventoryModel, SR_NAME_MDOB)
	
};
/*===========================================================================
 *		End of Class CSrScrlRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrScrlRecord.H
 *=========================================================================*/
