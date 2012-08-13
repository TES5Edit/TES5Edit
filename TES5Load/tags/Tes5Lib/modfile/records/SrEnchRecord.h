/*===========================================================================
 *
 * File:		SrEnchrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrEnchRecord class.
 *
 *=========================================================================*/
#ifndef __SRENCHRECORD_H
#define __SRENCHRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srctdasubrecord.h"
	#include "../subrecords/srenitsubrecord.h"
	#include "../subrecords/srefitsubrecord.h"
	#include "../subrecords/srlstringsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrEnchRecord Definition
 *
 *=========================================================================*/
class CSrEnchRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrEnchRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrLStringSubrecord*	m_pItemName;
	CSrEnitSubrecord*		m_pEffectData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:
	static srenitdata_t	s_NullEffectData;


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrEnchRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrEnchRecord; }

		/* Get class members */
	srenitdata_t& GetEnchantData (void) { return m_pEffectData ? m_pEffectData->GetEnchantData() : s_NullEffectData; }

	dword		GetEffectCount   (void) { return CountSubrecords(SR_NAME_EFIT); }
	const char* GetEnchantType   (void) { return GetSrEnchantmentTypeString(GetEnchantData().EnchantType); }
	const char* GetCastType      (void) { return GetSrEffectCastTypeString(GetEnchantData().CastType); }
	const char* GetDeliveryType  (void) { return GetSrMagicDeliveryTypeString(GetEnchantData().DeliveryType); }
	bool	    IsAutoCalc       (void) { return m_pEffectData ? m_pEffectData->IsAutoCalc() : false; }	
	bool	    IsExtendDuration (void) { return m_pEffectData ? m_pEffectData->IsExtendDuration() : false; }	
	
		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

		/* Set class members */
	void SetEnchantType    (const char* pString) { GetSrEnchantmentTypeValue(GetEnchantData().EnchantType, pString); }
	void SetCastType       (const char* pString) { GetSrEffectCastTypeValue(GetEnchantData().CastType, pString); }
	void SetDeliveryType   (const char* pString) { GetSrMagicDeliveryTypeValue(GetEnchantData().DeliveryType, pString); }
	void SetAutoCalc       (const bool     Flag) { if (m_pEffectData) m_pEffectData->SetAutoCalc(Flag); }
	void SetExtendDuration (const bool     Flag) { if (m_pEffectData) m_pEffectData->SetExtendDuration(Flag); }

		/* Begin field method definitions */
	DECLARE_SRFIELD_DWORD1(CSrEnchRecord, EffectCount, GetEffectCount(), dword Tmp)
	DECLARE_SRFIELD_DWORD1(CSrEnchRecord, ChargeAmount, GetEnchantData().ChargeAmount, GetEnchantData().ChargeAmount)
	DECLARE_SRFIELD_DWORD1(CSrEnchRecord, EnchantCost, GetEnchantData().EnchantCost, GetEnchantData().EnchantCost)
	DECLARE_SRFIELD_FLOAT1(CSrEnchRecord, ChargeTime, GetEnchantData().ChargeTime, GetEnchantData().ChargeTime)

	DECLARE_SRFIELD_DWORDFLAG1(CSrEnchRecord, MagicFlags, GetEnchantData().Flags, GetEnchantData().Flags)

	DECLARE_SRFIELD_BOOL(CSrEnchRecord, AutoCalc, IsAutoCalc, SetAutoCalc)
	DECLARE_SRFIELD_BOOL(CSrEnchRecord, ExtendDuration, IsExtendDuration, SetExtendDuration)

	DECLARE_SRFIELD_EDITORID2(CSrEnchRecord, BaseEnchant, GetEnchantData().BaseEnchantID)
	DECLARE_SRFIELD_EDITORID2(CSrEnchRecord, ItemTypes,   GetEnchantData().ItemTypesID)

	DECLARE_SRFIELD_METHOD(CSrEnchRecord, EnchantType,  GetEnchantType,  SetEnchantType)
	DECLARE_SRFIELD_METHOD(CSrEnchRecord, CastType,     GetCastType,     SetCastType)
	DECLARE_SRFIELD_METHOD(CSrEnchRecord, DeliveryType, GetDeliveryType, SetDeliveryType)

	DECLARE_SRFIELD_CONDITION(CSrEnchRecord);
	DECLARE_SRFIELD_FULLNAME(CSrEnchRecord);
	
};
/*===========================================================================
 *		End of Class CSrEnchRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrEnchRecord.H
 *=========================================================================*/
