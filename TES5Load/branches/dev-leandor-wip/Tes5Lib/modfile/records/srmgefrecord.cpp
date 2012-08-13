/*===========================================================================
 *
 * File:		SrMgefRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	1 December 2011
 *
 * Implements the CSrMgefRecord class for land texture records.
 *
 *=========================================================================*/

	/* Include Files */
#include "srmgefrecord.h"


	/* Static class members */
srmgefdata_t CSrMgefRecord::s_SrNullEffectData = { 0 };


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrMgefRecord, CSrIdKeyRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrMgefDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrCtdaSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNDD, CSrMgefSnddSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrVmadSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MDOB, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ESCE, CSrFormidSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrMgefRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrMgefRecord, CSrIdKeyRecord)
	ADD_SRFIELDALL("FullName",			SR_FIELD_FULLNAME,			0, CSrMgefRecord, FieldItemName)
	ADD_SRFIELDALL("Description",		SR_FIELD_DESCRIPTION,		0, CSrMgefRecord, FieldDescription)
	ADD_SRFIELDALL("School",			SR_FIELD_SCHOOL,			0, CSrMgefRecord, FieldSchool)
	ADD_SRFIELDALL("CastType",			SR_FIELD_CASTTYPE,			0, CSrMgefRecord, FieldCastType)
	ADD_SRFIELDALL("DeliveryType",		SR_FIELD_DELIVERYTYPE,		0, CSrMgefRecord, FieldDeliveryType)
	ADD_SRFIELDALL("ResistType",		SR_FIELD_RESISTTYPE,		0, CSrMgefRecord, FieldResistType)
	ADD_SRFIELDALL("EffectType",		SR_FIELD_EFFECTTYPE,		0, CSrMgefRecord, FieldEffectType)
	ADD_SRFIELDALL("SoundCount",		SR_FIELD_SOUNDCOUNT,		0, CSrMgefRecord, FieldSoundCount)
	ADD_SRFIELDALL("SoundVolume",		SR_FIELD_SOUNDVOLUME,		0, CSrMgefRecord, FieldSoundVolume)
	ADD_SRFIELDALL("ConditionCount",	SR_FIELD_CONDITIONCOUNT,	0, CSrMgefRecord, FieldConditionCount)
	ADD_SRFIELDALL("CounterEffectCount",SR_FIELD_COUNTEREFFECTCOUNT,0, CSrMgefRecord, FieldCounterEffectCount)
	ADD_SRFIELDALL("SkillLevel",		SR_FIELD_SKILLLEVEL,		0, CSrMgefRecord, FieldSkillLevel)
	ADD_SRFIELDALL("CastingDelay",		SR_FIELD_CASTINGDELAY,		0, CSrMgefRecord, FieldCastingDelay)
	ADD_SRFIELDALL("BaseCost",			SR_FIELD_BASECOST,			0, CSrMgefRecord, FieldBaseCost)
	ADD_SRFIELDALL("Area",				SR_FIELD_AREA,				0, CSrMgefRecord, FieldArea)
	ADD_SRFIELDALL("MagicFlags",		SR_FIELD_MAGICFLAGS,		0, CSrMgefRecord, FieldMagicFlags)
	ADD_SRFIELDALL("TaperWeight",		SR_FIELD_TAPERWEIGHT,		0, CSrMgefRecord, FieldTaperWeight)
	ADD_SRFIELDALL("TaperDuration",		SR_FIELD_TAPERDURATION,		0, CSrMgefRecord, FieldTaperDuration)
	ADD_SRFIELDALL("TaperCurve",		SR_FIELD_TAPERCURVE,		0, CSrMgefRecord, FieldTaperCurve)
	ADD_SRFIELDALL("CastingDelay",		SR_FIELD_CASTINGDELAY,		0, CSrMgefRecord, FieldCastingDelay)
	ADD_SRFIELDALL("DualCastScale",		SR_FIELD_DUALCASTSCALE,		0, CSrMgefRecord, FieldDualCastScale)

	ADD_SRFIELDALL("Light",				SR_FIELD_LIGHT,				0, CSrMgefRecord, FieldLight)
	ADD_SRFIELDALL("HitShader",			SR_FIELD_HITSHADER,			0, CSrMgefRecord, FieldHitShader)
	ADD_SRFIELDALL("EnchantShader",		SR_FIELD_ENCHANTSHADER,		0, CSrMgefRecord, FieldEnchantShader)
	ADD_SRFIELDALL("CastingArt",		SR_FIELD_CASTINGART,		0, CSrMgefRecord, FieldCastingArt)
	ADD_SRFIELDALL("HitEffectArt",		SR_FIELD_HITEFFECTART,		0, CSrMgefRecord, FieldHitEffectArt)	
	ADD_SRFIELDALL("EnchantArt",		SR_FIELD_ENCHANTART,		0, CSrMgefRecord, FieldEnchantArt)	
	ADD_SRFIELDALL("EquipAbility",		SR_FIELD_EQUIPABILITY,		0, CSrMgefRecord, FieldEquipAbility)	
	ADD_SRFIELDALL("ImpactSet",			SR_FIELD_IMPACTSET,			0, CSrMgefRecord, FieldImpactSet)
	ADD_SRFIELDALL("ImageSpaceMod",		SR_FIELD_IMAGESPACEMOD,		0, CSrMgefRecord, FieldImageSpaceMod)
	ADD_SRFIELDALL("Perk",				SR_FIELD_PERK,				0, CSrMgefRecord, FieldPerk)
	ADD_SRFIELDALL("Explosion",			SR_FIELD_EXPLOSION,			0, CSrMgefRecord, FieldExplosion)
	ADD_SRFIELDALL("DualCast",			SR_FIELD_DUALCAST,			0, CSrMgefRecord, FieldDualCast)
	ADD_SRFIELDALL("EffectObject",		SR_FIELD_EFFECTOBJECT,		0, CSrMgefRecord, FieldEffectObject)
	ADD_SRFIELDALL("Projectile",		SR_FIELD_PROJECTILE,		0, CSrMgefRecord, FieldProjectile)
	ADD_SRFIELDALL("Menu",				SR_FIELD_MENU,				0, CSrMgefRecord, FieldMenu)

	ADD_SRFIELDALL("SkillUsageMult",	SR_FIELD_SKILLUSAGEMULT,	0, CSrMgefRecord, FieldSkillUsageMult)
	ADD_SRFIELDALL("ActorValue",		SR_FIELD_ACTORVALUE,		0, CSrMgefRecord, FieldActorValue)
	ADD_SRFIELDALL("ActorValue2",		SR_FIELD_ACTORVALUE2,		0, CSrMgefRecord, FieldActorValue2)
	ADD_SRFIELDALL("SecondAVWeight",	SR_FIELD_SECONDAVWEIGHT,	0, CSrMgefRecord, FieldSecondAVWeight)
	ADD_SRFIELDALL("ScriptAIDataScore",	SR_FIELD_SCRIPTAIDATASCORE,	0, CSrMgefRecord, FieldScriptAIDataScore)
	ADD_SRFIELDALL("ScriptAIDataDelay",	SR_FIELD_SCRIPTAIDATADELAY,	0, CSrMgefRecord, FieldScriptAIDataDelay)
	
	ADD_SRFIELDALL("Hostile",			SR_FIELD_HOSTILE,			0, CSrMgefRecord, FieldHostile)
	ADD_SRFIELDALL("Recover",			SR_FIELD_RECOVER,			0, CSrMgefRecord, FieldRecover)
	ADD_SRFIELDALL("Detrimental",		SR_FIELD_DETRIMENTAL,		0, CSrMgefRecord, FieldDetrimental)
	ADD_SRFIELDALL("NoHitEvent",		SR_FIELD_NOHITEVENT,		0, CSrMgefRecord, FieldNoHitEvent)
	ADD_SRFIELDALL("SnapToNavMesh",		SR_FIELD_SNAPTONAVMESH,		0, CSrMgefRecord, FieldSnapToNavMesh)
	ADD_SRFIELDALL("DispelEffects",		SR_FIELD_DISPELEFFECTS,		0, CSrMgefRecord, FieldDispelEffects)
	ADD_SRFIELDALL("NoDuration",		SR_FIELD_NODURATION,		0, CSrMgefRecord, FieldNoDuration)
	ADD_SRFIELDALL("NoArea",			SR_FIELD_NOAREA,			0, CSrMgefRecord, FieldNoArea)
	ADD_SRFIELDALL("NoMagnitude",		SR_FIELD_NOMAGNITUDE,		0, CSrMgefRecord, FieldNoMagnitude)
	ADD_SRFIELDALL("FXPersist",			SR_FIELD_FXPERSIST,			0, CSrMgefRecord, FieldFXPersist)
	ADD_SRFIELDALL("NoRecast",			SR_FIELD_NORECAST,			0, CSrMgefRecord, FieldNoRecast)
	ADD_SRFIELDALL("GoryVisual",		SR_FIELD_GORYVISUAL,		0, CSrMgefRecord, FieldGoryVisual)
	ADD_SRFIELDALL("HideInUI",			SR_FIELD_HIDEINUI,			0, CSrMgefRecord, FieldHideInUI)
	ADD_SRFIELDALL("PowerMagnitude",	SR_FIELD_POWERMAGNITUDE,	0, CSrMgefRecord, FieldPowerMagnitude)
	ADD_SRFIELDALL("Painless",			SR_FIELD_PAINLESS,			0, CSrMgefRecord, FieldPainless)
	ADD_SRFIELDALL("PowerDuration",		SR_FIELD_POWERDURATION,		0, CSrMgefRecord, FieldPowerDuration)
	ADD_SRFIELDALL("NoHitEffect",		SR_FIELD_NOHITEFFECT,		0, CSrMgefRecord, FieldNoHitEffect)
	ADD_SRFIELDALL("NoDeathDispell",	SR_FIELD_NODEATHDISPELL,	0, CSrMgefRecord, FieldNoDeathDispell)
	ADD_SRFIELDALL("Ward",				SR_FIELD_WARD,				0, CSrMgefRecord, FieldWard)
	ADD_SRFIELDALL("UnknownFlag1",		SR_FIELD_UNKNOWNFLAG1,		0, CSrMgefRecord, FieldUnknownFlag1)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CSrMgefRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMgefRecord Constructor
 *
 *=========================================================================*/
CSrMgefRecord::CSrMgefRecord () 
{
	m_pData			= NULL;
	m_pItemName		= NULL;
	m_pDescription	= NULL;
	m_pSoundData    = NULL;
	m_pMenu         = NULL;
}
/*===========================================================================
 *		End of Class CSrMgefRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMgefRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrMgefRecord::Destroy (void) 
{
	m_pData        = NULL;
	m_pItemName    = NULL;
	m_pDescription = NULL;
	m_pSoundData   = NULL;
	m_pMenu        = NULL;

	CSrIdKeyRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrMgefRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMgefRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrMgefRecord::InitializeNew (void) 
{

	/* Call the base class method first */
  CSrIdKeyRecord::InitializeNew();

  AddNewSubrecord(SR_NAME_FULL);
  if (m_pItemName != NULL) m_pItemName->InitializeNew();

  AddNewSubrecord(SR_NAME_DATA);
  if (m_pData != NULL) m_pData->InitializeNew();

  AddNewSubrecord(SR_NAME_DNAM);
  if (m_pDescription != NULL) m_pDescription->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrMgefRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMgefRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrMgefRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) 
{

	if (pSubrecord->GetRecordType() == SR_NAME_DATA) 
	{
		m_pData = SrCastClass(CSrMgefDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL) 
	{
		m_pItemName = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM) 
	{
		m_pDescription = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNDD) 
	{
		m_pSoundData = SrCastClass(CSrMgefSnddSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MDOB) 
	{
		m_pMenu = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else 
	{
		CSrIdKeyRecord::OnAddSubrecord(pSubrecord);
	}
	
}
/*===========================================================================
 *		End of Class Event CSrMgefRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMgefRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrMgefRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) 
{

	if (m_pData == pSubrecord) 
	    m_pData = NULL;
	else if (m_pItemName == pSubrecord) 
		m_pItemName = NULL;
	else if (m_pDescription == pSubrecord) 
		m_pDescription = NULL;
	else if (m_pSoundData == pSubrecord) 
		m_pSoundData = NULL;
	else if (m_pMenu == pSubrecord) 
		m_pMenu = NULL;
	else 
		CSrIdKeyRecord::OnDeleteSubrecord(pSubrecord);  

}
/*===========================================================================
 *		End of Class Event CSrMgefRecord::OnDeleteSubrecord()
 *=========================================================================*/


void CSrMgefRecord::SetSounds (CSrMgefSnddArray& Sounds)
{
	if (m_pSoundData == NULL)
	{
		if (Sounds.GetSize() == 0) return;

		AddNewSubrecord(SR_NAME_SNDD);
		if (m_pSoundData == NULL) return;
		m_pSoundData->InitializeNew();
	}
	else if (Sounds.GetSize() == 0) 
	{
		DeleteSubrecords(SR_NAME_SNDD);
		return;
	}

	m_pSoundData->GetSnddArray() = Sounds;
}


srrectype_t CSrMgefRecord::GetEffectObjectRecordType (const int EffectType)
{
	switch (EffectType)
	{
		case 12: return SR_NAME_LIGH;
		case 17: return SR_NAME_WEAP;
		case 18: return SR_NAME_NPC_;
		case 25: return SR_NAME_HAZD;
		case 34: return SR_NAME_KYWD;
		case 35: return SR_NAME_SPEL;
		case 36: return SR_NAME_RACE;
		case 39: return SR_NAME_ENCH;
		case 40: return SR_NAME_HAZD;
	}

	return SR_NAME_NULL;
}


