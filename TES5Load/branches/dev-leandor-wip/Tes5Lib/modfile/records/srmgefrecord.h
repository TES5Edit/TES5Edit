/*===========================================================================
 *
 * File:		SrMgefRecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	1 December 2011
 *
 * Defines the CSrMgefRecord class for magic effect records.
 *
 *=========================================================================*/
#ifndef __SRMGEFRECORD_H
#define __SRMGEFRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridkeyrecord.h"
	#include "../subrecords/srmgefdatasubrecord.h"
	#include "../subrecords/srlstringsubrecord.h"
	#include "../subrecords/srctdasubrecord.h"
	#include "../subrecords/srmgefsnddsubrecord.h"
	#include "../subrecords/srvmadsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrMgefRecord Definition
 *
 * Holds magic effect data.
 *
 *=========================================================================*/
class CSrMgefRecord : public CSrIdKeyRecord {
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrMgefRecord, CSrIdKeyRecord)
  
  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrMgefDataSubrecord*		m_pData;
  CSrLStringSubrecord*		m_pItemName;
  CSrLStringSubrecord*		m_pDescription;
  CSrMgefSnddSubrecord*		m_pSoundData;
  CSrFormidSubrecord*		m_pMenu;

  static srmgefdata_t s_SrNullEffectData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
  CSrMgefRecord();
  virtual void Destroy (void);

  		/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrMgefRecord; }

		/* Get class members */
  srmgefdata_t& GetEffectData         (void) { return m_pData ? m_pData->GetEffectData() : s_SrNullEffectData; }
  dword			GetConditionCount     (void) { return CountSubrecords(SR_NAME_CTDA); }
  dword			GetCounterEffectCount (void) { return CountSubrecords(SR_NAME_ESCE); }
  dword			GetSoundCount         (void) { return m_pSoundData ? m_pSoundData->GetSoundCount(): 0; }
  
  CSrMgefSnddArray* GetSoundArray (void) { return m_pSoundData ? &m_pSoundData->GetSnddArray() : NULL; }

  const char*   GetCastType       (void) { return GetSrEffectCastTypeString(GetEffectData().CastType); }
  const char*   GetActorValue     (void) { return GetSrActorValueString(GetEffectData().ActorValue); }
  const char*   GetActorValue2    (void) { return GetSrActorValueString(GetEffectData().ActorValue2); }
  const char*   GetEffectType     (void) { return GetSrMagicEffectTypeString(GetEffectData().EffectType); }
  const char*   GetResistType     (void) { return GetSrMagicResistTypeString(GetEffectData().ResistType); }
  const char*   GetSchool         (void) { return GetSrMagicSchoolString(GetEffectData().School); }
  const char*   GetDeliveryType   (void) { return GetSrMagicDeliveryTypeString(GetEffectData().DeliveryType); }
  const char*   GetSoundVolume    (void) { return GetSrSoundVolumeString(GetEffectData().SoundVolume); }

		/* Initialize a new record */
  void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

		/* Set class members */
  void SetSounds       (CSrMgefSnddArray& Sounds);
  void SetCastType     (const char* pString) { GetSrEffectCastTypeValue(GetEffectData().CastType, pString); }
  void SetActorValue   (const char* pString) { GetSrActorValueValue(GetEffectData().ActorValue, pString); }
  void SetActorValue2  (const char* pString) { GetSrActorValueValue(GetEffectData().ActorValue2, pString); }
  void SetEffectType   (const char* pString) { GetSrMagicEffectTypeValue(GetEffectData().EffectType, pString); }
  void SetResistType   (const char* pString) { GetSrMagicResistTypeValue(GetEffectData().ResistType, pString); }
  void SetSchool       (const char* pString) { GetSrMagicSchoolValue(GetEffectData().School, pString); }
  void SetDeliveryType (const char* pString) { GetSrMagicDeliveryTypeValue(GetEffectData().DeliveryType, pString); }
  void SetSoundVolume  (const char* pString) { GetSrSoundVolumeValue(GetEffectData().SoundVolume, pString); }

  static srrectype_t GetEffectObjectRecordType (const int EffectType);


  		/* Begin field method definitions */
	DECLARE_SRFIELD_FULLNAME(CSrMgefRecord)
	DECLARE_SRFIELD_DESCRIPTION(CSrMgefRecord, SR_NAME_DNAM)

	DECLARE_SRFIELD_DWORD1(CSrMgefRecord, SoundCount, GetSoundCount(), dword Tmp)
	DECLARE_SRFIELD_DWORD1(CSrMgefRecord, ConditionCount, GetConditionCount(), dword Tmp)
	DECLARE_SRFIELD_DWORD1(CSrMgefRecord, CounterEffectCount, GetCounterEffectCount(), dword Tmp)

	DECLARE_SRFIELD_DWORDFLAG1(CSrMgefRecord, MagicFlags, GetEffectData().Flags, GetEffectData().Flags)
	DECLARE_SRFIELD_FLOAT1(CSrMgefRecord, BaseCost, GetEffectData().BaseCost, GetEffectData().BaseCost)
	DECLARE_SRFIELD_DWORD1(CSrMgefRecord, Area, GetEffectData().Area, GetEffectData().Area)
	DECLARE_SRFIELD_DWORD1(CSrMgefRecord, SkillLevel, GetEffectData().SkillLevel, GetEffectData().SkillLevel)
	DECLARE_SRFIELD_FLOAT1(CSrMgefRecord, SkillUsageMult, GetEffectData().SkillUsageMult, GetEffectData().SkillUsageMult)
	DECLARE_SRFIELD_FLOAT1(CSrMgefRecord, DualCastScale, GetEffectData().DualCastScale, GetEffectData().DualCastScale)
	DECLARE_SRFIELD_FLOAT1(CSrMgefRecord, CastingDelay, GetEffectData().CastingDelay, GetEffectData().CastingDelay)
	DECLARE_SRFIELD_FLOAT1(CSrMgefRecord, SecondAVWeight, GetEffectData().SecondAVWeight, GetEffectData().SecondAVWeight)
	DECLARE_SRFIELD_FLOAT1(CSrMgefRecord, TaperWeight, GetEffectData().TaperWeight, GetEffectData().TaperWeight)
	DECLARE_SRFIELD_FLOAT1(CSrMgefRecord, TaperCurve, GetEffectData().TaperCurve, GetEffectData().TaperCurve)
	DECLARE_SRFIELD_FLOAT1(CSrMgefRecord, TaperDuration, GetEffectData().TaperDuration, GetEffectData().TaperDuration)
	DECLARE_SRFIELD_FLOAT1(CSrMgefRecord, ScriptAIDataScore, GetEffectData().ScriptAIDataScore, GetEffectData().ScriptAIDataScore)
	DECLARE_SRFIELD_FLOAT1(CSrMgefRecord, ScriptAIDataDelay, GetEffectData().ScipreAIDataDelay, GetEffectData().ScipreAIDataDelay)

	DECLARE_SRFIELD_EDITORID2(CSrMgefRecord, EffectObject, GetEffectData().ObjectID)
	DECLARE_SRFIELD_EDITORID2(CSrMgefRecord, Light, GetEffectData().LightID)
	DECLARE_SRFIELD_EDITORID2(CSrMgefRecord, HitShader, GetEffectData().HitShaderID)
	DECLARE_SRFIELD_EDITORID2(CSrMgefRecord, EnchantShader, GetEffectData().EnchantShaderID)
	DECLARE_SRFIELD_EDITORID2(CSrMgefRecord, Projectile, GetEffectData().ProjectileID)
	DECLARE_SRFIELD_EDITORID2(CSrMgefRecord, Explosion, GetEffectData().ExplosionID)
	DECLARE_SRFIELD_EDITORID2(CSrMgefRecord, DualCast, GetEffectData().DualCastID)
	DECLARE_SRFIELD_EDITORID2(CSrMgefRecord, ImpactSet, GetEffectData().ImpactSetID)
	DECLARE_SRFIELD_EDITORID2(CSrMgefRecord, ImageSpaceMod, GetEffectData().ImageSpaceModID)
	DECLARE_SRFIELD_EDITORID2(CSrMgefRecord, HitEffectArt, GetEffectData().HitEffectArtID)
	DECLARE_SRFIELD_EDITORID2(CSrMgefRecord, EnchantArt, GetEffectData().EnchantArtID)
	DECLARE_SRFIELD_EDITORID2(CSrMgefRecord, CastingArt, GetEffectData().CastingArtID)
	DECLARE_SRFIELD_EDITORID2(CSrMgefRecord, EquipAbility, GetEffectData().EquipAbilityID)
	DECLARE_SRFIELD_EDITORID2(CSrMgefRecord, Perk, GetEffectData().PerkID)
	DECLARE_SRFIELD_EDITORID1(CSrMgefRecord, Menu, SR_NAME_MDOB)

	DECLARE_SRFIELD_METHOD(CSrMgefRecord, ActorValue, GetActorValue, SetActorValue)
	DECLARE_SRFIELD_METHOD(CSrMgefRecord, ActorValue2, GetActorValue2, SetActorValue2)
	DECLARE_SRFIELD_METHOD(CSrMgefRecord, CastType, GetCastType, SetCastType)
	DECLARE_SRFIELD_METHOD(CSrMgefRecord, SoundVolume, GetSoundVolume, SetSoundVolume)
	DECLARE_SRFIELD_METHOD(CSrMgefRecord, School, GetSchool, SetSchool)
	DECLARE_SRFIELD_METHOD(CSrMgefRecord, DeliveryType, GetDeliveryType, SetDeliveryType)
	DECLARE_SRFIELD_METHOD(CSrMgefRecord, EffectType, GetEffectType, SetEffectType)
	DECLARE_SRFIELD_METHOD(CSrMgefRecord, ResistType, GetResistType, SetResistType)

	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, Hostile, GetEffectData().Flags, SR_MGEFFLAG_HOSTILE)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, Recover, GetEffectData().Flags, SR_MGEFFLAG_RECOVER)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, Detrimental, GetEffectData().Flags, SR_MGEFFLAG_DETRIMENTAL)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, NoHitEvent, GetEffectData().Flags, SR_MGEFFLAG_NOHITEVENT)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, SnapToNavMesh, GetEffectData().Flags, SR_MGEFFLAG_SNAPTONAVMESH)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, DispelEffects, GetEffectData().Flags, SR_MGEFFLAG_DISPELLEFFECTS)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, NoDuration, GetEffectData().Flags, SR_MGEFFLAG_NODURATION)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, NoMagnitude, GetEffectData().Flags, SR_MGEFFLAG_NOMAGNITUDE)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, NoArea, GetEffectData().Flags, SR_MGEFFLAG_NOAREA)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, FXPersist, GetEffectData().Flags, SR_MGEFFLAG_FXPERSIST)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, NoRecast, GetEffectData().Flags, SR_MGEFFLAG_NORECAST)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, GoryVisual, GetEffectData().Flags, SR_MGEFFLAG_GORYVISUAL)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, HideInUI, GetEffectData().Flags, SR_MGEFFLAG_HIDEINUI)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, PowerMagnitude, GetEffectData().Flags, SR_MGEFFLAG_POWERMAGNITUDE)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, Painless, GetEffectData().Flags, SR_MGEFFLAG_PAINLESS)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, PowerDuration, GetEffectData().Flags, SR_MGEFFLAG_POWERDURATION)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, NoHitEffect, GetEffectData().Flags, SR_MGEFFLAG_NOHITEFFECT)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, NoDeathDispell, GetEffectData().Flags, SR_MGEFFLAG_NODEATHDISPELL)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, Ward, GetEffectData().Flags, SR_MGEFFLAG_WARD)
	DECLARE_SRFIELD_BOOL1(CSrMgefRecord, UnknownFlag1, GetEffectData().Flags, SR_MGEFFLAG_80000000)				
  
};
/*===========================================================================
 *		End of Class CSrMgefRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrMgefRecord.H
 *=========================================================================*/
