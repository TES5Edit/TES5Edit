/*===========================================================================
 *
 * File:		SrArmorecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrArmoRecord class.
 *
 *=========================================================================*/
#ifndef __SRARMORECORD_H
#define __SRARMORECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridkeyrecord.h"
	#include "../subrecords/srarmodatasubrecord.h"
	#include "../subrecords/srlstringsubrecord.h"
	#include "../subrecords/srbodtsubrecord.h"
	#include "../subrecords/srvmadsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrArmoRecord Definition
 *
 *=========================================================================*/
class CSrArmoRecord : public CSrIdKeyRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrArmoRecord, CSrIdKeyRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrLStringSubrecord*	m_pDescription;
	CSrLStringSubrecord*	m_pItemName;
	
	CSrFormidSubrecord*		m_pImpactData;	
	CSrBodtSubrecord*		m_pBodyData;
	CSrVmadSubrecord*		m_pScriptData;
	CSrArmoDataSubrecord*	m_pArmorData;
	CSrDwordSubrecord*		m_pArmorRating;
	CSrFormidSubrecord*		m_pEnchantment;
	CSrFormidSubrecord*		m_pEquipmentSlot;
	CSrFormidSubrecord*		m_pMaterial;

	CSrFormidSubrecord*		m_pPickupSound;
	CSrFormidSubrecord*		m_pDropSound;
	CSrFormidSubrecord*		m_pRace;
	CSrFormidSubrecord*		m_pTemplate;

	CSrSubrecord*			m_pMo2sData;
	CSrSubrecord*			m_pMo4sData;
	CSrSubrecord*			m_pMod2Data;
	CSrSubrecord*			m_pMo2tData;
	CSrSubrecord*			m_pMo4tData;
	CSrSubrecord*			m_pMod4Data;

	CSrSubrecord*			m_pVmadData;

	CSString				m_BodyPartsString;

	static srarmordata_t s_NullArmorData;
	static srbodtdata_t  s_NullBodtData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
  CSrArmoRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrArmoRecord; }

  srarmordata_t& GetArmorData (void) { return m_pArmorData ? m_pArmorData->GetArmorData() : s_NullArmorData; }
  srbodtdata_t&  GetBodtData  (void) { return m_pBodyData  ? m_pBodyData->GetBodtData()   : s_NullBodtData; }
  dword GetArmorRating (void) { return m_pArmorRating ? m_pArmorRating->GetValue() : 0; }
  bool IsPlayable (void) { return !CheckFlagBits(GetBodtData().Flags, SR_BODT_FLAG_NONPLAYABLE); }  
  const char* GetBodyParts (void) { m_BodyPartsString = GetSrBodyPartFlagString(GetBodtData().BodyParts); return m_BodyPartsString.c_str(); }
  const char* GetArmorType (void) { return GetSrArmorTypeString(GetBodtData().ArmorType); }
  dword GetBodyFlags (void) { return GetBodtData().BodyParts; }

  CSrVmadSubrecord* GetScriptData (void) { return m_pScriptData; }
  dword GetScriptCount (void) { return m_pScriptData ? m_pScriptData->GetScriptCount() : 0; } 

		/* Initialize a new record */
  void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

  void SetArmorRating (const dword Value);
  void SetIsPlayable  (const bool Flag) { FlipFlagBits(GetBodtData().Flags, SR_BODT_FLAG_NONPLAYABLE, !Flag); }
  void SetBodyParts   (const char* pString) { GetSrBodyPartFlagValue(GetBodtData().BodyParts, pString); }
  void SetArmorType   (const char* pString) { GetSrArmorTypeValue(GetBodtData().ArmorType, pString); }


  DECLARE_SRFIELD_DESCRIPTION(CSrArmoRecord, SR_NAME_DESC)
  DECLARE_SRFIELD_ITEMNAME(CSrArmoRecord)

  DECLARE_SRFIELD_DWORD1(CSrArmoRecord, ScriptCount, GetScriptCount(), dword Tmp)
  
  DECLARE_SRFIELD_METHOD(CSrArmoRecord, Type, GetArmorType, SetArmorType)
  DECLARE_SRFIELD_DWORD(CSrArmoRecord, Rating, GetArmorRating, SetArmorRating)
  DECLARE_SRFIELD_DWORD1(CSrArmoRecord, Value, GetArmorData().Value, GetArmorData().Value)
  DECLARE_SRFIELD_FLOAT1(CSrArmoRecord, Weight, GetArmorData().Weight, GetArmorData().Weight)
  DECLARE_SRFIELD_BOOL(CSrArmoRecord, Playable, IsPlayable, SetIsPlayable)
  DECLARE_SRFIELD_METHOD(CSrArmoRecord, BodyParts, GetBodyParts, SetBodyParts)
  
  DECLARE_SRFIELD_EDITORID(CSrArmoRecord, Enchantment, GetEnchantment, SetEnchantment)
  DECLARE_SRFIELD_EDITORID(CSrArmoRecord, EquipmentSlot, GetEquipmentSlot, SetEquipmentSlot)
  DECLARE_SRFIELD_EDITORID(CSrArmoRecord, PickupSound, GetPickupSound, SetPickupSound)
  DECLARE_SRFIELD_EDITORID(CSrArmoRecord, DropSound,   GetDropSound,   SetDropSound)

  DECLARE_SRFIELD_EDITORID(CSrArmoRecord, ImpactData, GetImpactData, SetImpactData)
  DECLARE_SRFIELD_EDITORID(CSrArmoRecord, Material, GetMaterial, SetMaterial)
  DECLARE_SRMETHOD_FORMID(ImpactData, m_pImpactData, SR_NAME_BIDS)
  DECLARE_SRMETHOD_FORMID(Material, m_pMaterial, SR_NAME_BAMT)

  DECLARE_SRFIELD_EDITORID(CSrArmoRecord, Race,   GetRace,   SetRace)
  DECLARE_SRFIELD_EDITORID(CSrArmoRecord, Template,   GetTemplate,   SetTemplate)
  DECLARE_SRMETHOD_FORMID(Race, m_pRace, SR_NAME_RNAM)
  DECLARE_SRMETHOD_FORMID(Template, m_pTemplate, SR_NAME_TNAM)
    
  DECLARE_SRMETHOD_FORMID(Enchantment, m_pEnchantment, SR_NAME_EITM)
  DECLARE_SRMETHOD_FORMID(EquipmentSlot,  m_pEquipmentSlot, SR_NAME_ETYP)
  DECLARE_SRMETHOD_FORMID(PickupSound, m_pPickupSound, SR_NAME_YNAM)
  DECLARE_SRMETHOD_FORMID(DropSound,   m_pDropSound,   SR_NAME_ZNAM)

};
/*===========================================================================
 *		End of Class CSrArmoRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrArmoRecord.H
 *=========================================================================*/
