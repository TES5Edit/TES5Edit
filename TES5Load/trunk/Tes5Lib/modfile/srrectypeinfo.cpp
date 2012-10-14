#include "srespfile.h"
#include "srrectypeinfo.h"
#include "common/dl_map.h"


srrectypeinfo_t g_RecTypeInfos[] =
{
	{ SR_NAME_AACT, "Action",				SRCLASS_CSrAactRecord, CSrAactRecord::s_FieldMap, CSrAactRecord::Create },
	{ SR_NAME_ACHR, "ActorReference",		SRCLASS_CSrAchrRecord, CSrAchrRecord::s_FieldMap, CSrAchrRecord::Create },
	{ SR_NAME_ACTI, "Activator",			SRCLASS_CSrActiRecord, CSrActiRecord::s_FieldMap, CSrActiRecord::Create },
	{ SR_NAME_ADDN, "AddonNode",			SRCLASS_CSrAddnRecord, CSrAddnRecord::s_FieldMap, CSrAddnRecord::Create },
	{ SR_NAME_ALCH, "Potion",				SRCLASS_CSrAlchRecord, CSrAlchRecord::s_FieldMap, CSrAlchRecord::Create },
	{ SR_NAME_AMMO, "Ammunition",			SRCLASS_CSrAmmoRecord, CSrAmmoRecord::s_FieldMap, CSrAmmoRecord::Create },
	{ SR_NAME_ANIO, "AnimatedObject",		SRCLASS_CSrAnioRecord, CSrAnioRecord::s_FieldMap, CSrAnioRecord::Create },
	{ SR_NAME_APPA, "Apparatus",			SRCLASS_CSrAppaRecord, CSrAppaRecord::s_FieldMap, CSrAppaRecord::Create },
	{ SR_NAME_ARMA, "Armature",				SRCLASS_CSrArmaRecord, CSrArmaRecord::s_FieldMap, CSrArmaRecord::Create },
	{ SR_NAME_ARMO, "Armor",				SRCLASS_CSrArmoRecord, CSrArmoRecord::s_FieldMap, CSrArmoRecord::Create },
	{ SR_NAME_ARTO, "ArtObject",			SRCLASS_CSrArtoRecord, CSrArtoRecord::s_FieldMap, CSrArtoRecord::Create },
	{ SR_NAME_ASPC, "AcousticSpace",		SRCLASS_CSrAspcRecord, CSrAspcRecord::s_FieldMap, CSrAspcRecord::Create },
	{ SR_NAME_ASTP, "AssociationType",      SRCLASS_CSrAstpRecord, CSrAstpRecord::s_FieldMap, CSrAstpRecord::Create },
	{ SR_NAME_AVIF, "AvtorValue",			SRCLASS_CSrAvifRecord, CSrAvifRecord::s_FieldMap, CSrAvifRecord::Create },
	{ SR_NAME_BOOK, "Book",					SRCLASS_CSrBookRecord, CSrBookRecord::s_FieldMap, CSrBookRecord::Create },
	{ SR_NAME_BPTD, "BodyPartData",			SRCLASS_CSrBptdRecord, CSrBptdRecord::s_FieldMap, CSrBptdRecord::Create },
	{ SR_NAME_CAMS, "CameraShot",			SRCLASS_CSrCamsRecord, CSrCamsRecord::s_FieldMap, CSrCamsRecord::Create },
	{ SR_NAME_CELL, "Cell",					SRCLASS_CSrCellRecord, CSrCellRecord::s_FieldMap, CSrCellRecord::Create },
	{ SR_NAME_CLAS, "Class",				SRCLASS_CSrClasRecord, CSrClasRecord::s_FieldMap, CSrClasRecord::Create },
	{ SR_NAME_CLFM, "Color",				SRCLASS_CSrClfmRecord, CSrClfmRecord::s_FieldMap, CSrClfmRecord::Create },
	{ SR_NAME_CLMT, "Climate",				SRCLASS_CSrClmtRecord, CSrClmtRecord::s_FieldMap, CSrClmtRecord::Create },
	{ SR_NAME_COBJ, "Recipe",				SRCLASS_CSrCobjRecord, CSrCobjRecord::s_FieldMap, CSrCobjRecord::Create },
	{ SR_NAME_COLL, "CollisionLayer",		SRCLASS_CSrCollRecord, CSrCollRecord::s_FieldMap, CSrCollRecord::Create },
	{ SR_NAME_CONT, "Container",			SRCLASS_CSrContRecord, CSrContRecord::s_FieldMap, CSrContRecord::Create },
	{ SR_NAME_CPTH, "CameraPath",			SRCLASS_CSrCpthRecord, CSrCpthRecord::s_FieldMap, CSrCpthRecord::Create },
	{ SR_NAME_CSTY, "CombatStyle",			SRCLASS_CSrCstyRecord, CSrCstyRecord::s_FieldMap, CSrCstyRecord::Create },
	{ SR_NAME_DEBR, "Debris",				SRCLASS_CSrDebrRecord, CSrDebrRecord::s_FieldMap, CSrDebrRecord::Create },
	{ SR_NAME_DIAL, "DialogTopic",			SRCLASS_CSrDialRecord, CSrDialRecord::s_FieldMap, CSrDialRecord::Create },
	{ SR_NAME_DLBR, "DialogBranch",			SRCLASS_CSrDlbrRecord, CSrDlbrRecord::s_FieldMap, CSrDlbrRecord::Create },
	{ SR_NAME_DLVW, "DialogView",			SRCLASS_CSrDlvwRecord, CSrDlvwRecord::s_FieldMap, CSrDlvwRecord::Create },
	{ SR_NAME_DOBJ, "DynamicObject",		SRCLASS_CSrDobjRecord, CSrDobjRecord::s_FieldMap, CSrDobjRecord::Create },
	{ SR_NAME_DOOR, "Door",					SRCLASS_CSrDoorRecord, CSrDoorRecord::s_FieldMap, CSrDoorRecord::Create },
	{ SR_NAME_DUAL, "DualCast",				SRCLASS_CSrDualRecord, CSrDualRecord::s_FieldMap, CSrDualRecord::Create },
	{ SR_NAME_ECZN, "EncounterZone",		SRCLASS_CSrEcznRecord, CSrEcznRecord::s_FieldMap, CSrEcznRecord::Create },
	{ SR_NAME_EFSH, "EffectShader",			SRCLASS_CSrEfshRecord, CSrEfshRecord::s_FieldMap, CSrEfshRecord::Create },
	{ SR_NAME_ENCH, "Enchantment",			SRCLASS_CSrEnchRecord, CSrEnchRecord::s_FieldMap, CSrEnchRecord::Create },
	{ SR_NAME_EQUP, "EquipmentSlot",		SRCLASS_CSrEqupRecord, CSrEqupRecord::s_FieldMap, CSrEqupRecord::Create },
	{ SR_NAME_EXPL, "Explosion",			SRCLASS_CSrExplRecord, CSrExplRecord::s_FieldMap, CSrExplRecord::Create },
	{ SR_NAME_EYES, "Eyes",					SRCLASS_CSrEyesRecord, CSrEyesRecord::s_FieldMap, CSrEyesRecord::Create },
	{ SR_NAME_FACT, "Faction",				SRCLASS_CSrFactRecord, CSrFactRecord::s_FieldMap, CSrFactRecord::Create },
	{ SR_NAME_FLOR, "Flora",				SRCLASS_CSrFlorRecord, CSrFlorRecord::s_FieldMap, CSrFlorRecord::Create },
	{ SR_NAME_FLST, "FormList",				SRCLASS_CSrFlstRecord, CSrFlstRecord::s_FieldMap, CSrFlstRecord::Create },
	{ SR_NAME_FSTP, "FootStep",				SRCLASS_CSrFstpRecord, CSrFstpRecord::s_FieldMap, CSrFstpRecord::Create },
	{ SR_NAME_FSTS, "FootStepSet",			SRCLASS_CSrFstsRecord, CSrFstsRecord::s_FieldMap, CSrFstsRecord::Create },
	{ SR_NAME_FURN, "Furniture",			SRCLASS_CSrFurnRecord, CSrFurnRecord::s_FieldMap, CSrFurnRecord::Create },
	{ SR_NAME_GLOB, "Global",				SRCLASS_CSrGlobRecord, CSrGlobRecord::s_FieldMap, CSrGlobRecord::Create },
	{ SR_NAME_GMST, "GameSetting",			SRCLASS_CSrGmstRecord, CSrGmstRecord::s_FieldMap, CSrGmstRecord::Create },
	{ SR_NAME_GRAS, "Grass",				SRCLASS_CSrGrasRecord, CSrGrasRecord::s_FieldMap, CSrGrasRecord::Create },
	{ SR_NAME_HAZD, "Hazard",				SRCLASS_CSrHazdRecord, CSrHazdRecord::s_FieldMap, CSrHazdRecord::Create },
	{ SR_NAME_HDPT, "HeadPart",				SRCLASS_CSrHdptRecord, CSrHdptRecord::s_FieldMap, CSrHdptRecord::Create },
	{ SR_NAME_IDLE, "Idle",					SRCLASS_CSrIdleRecord, CSrIdleRecord::s_FieldMap, CSrIdleRecord::Create },
	{ SR_NAME_IDLM, "IdleMarker",			SRCLASS_CSrIdlmRecord, CSrIdlmRecord::s_FieldMap, CSrIdlmRecord::Create },
	{ SR_NAME_IMAD, "ImageSpaceModifier",   SRCLASS_CSrImadRecord, CSrImadRecord::s_FieldMap, CSrImadRecord::Create },
	{ SR_NAME_IMGS, "ImageSpace",			SRCLASS_CSrImgsRecord, CSrImgsRecord::s_FieldMap, CSrImgsRecord::Create },
	{ SR_NAME_INFO, "DialogInfo",			SRCLASS_CSrInfoRecord, CSrInfoRecord::s_FieldMap, CSrInfoRecord::Create },
	{ SR_NAME_INGR, "Ingrediant",			SRCLASS_CSrIngrRecord, CSrIngrRecord::s_FieldMap, CSrIngrRecord::Create },
	{ SR_NAME_IPCT, "ImpactData",			SRCLASS_CSrIpctRecord, CSrIpctRecord::s_FieldMap, CSrIpctRecord::Create },
	{ SR_NAME_IPDS, "ImpactDataSet",		SRCLASS_CSrIpdsRecord, CSrIpdsRecord::s_FieldMap, CSrIpdsRecord::Create },
	{ SR_NAME_KEYM, "Key",					SRCLASS_CSrKeymRecord, CSrKeymRecord::s_FieldMap, CSrKeymRecord::Create },
	{ SR_NAME_KYWD, "Keyword",				SRCLASS_CSrKywdRecord, CSrKywdRecord::s_FieldMap, CSrKywdRecord::Create },
	{ SR_NAME_LAND, "Land",					SRCLASS_CSrLandRecord, CSrLandRecord::s_FieldMap, CSrLandRecord::Create },
	{ SR_NAME_LCRT, "LocationRefType",      SRCLASS_CSrLcrtRecord, CSrLcrtRecord::s_FieldMap, CSrLcrtRecord::Create },
	{ SR_NAME_LCTN, "Location",				SRCLASS_CSrLctnRecord, CSrLctnRecord::s_FieldMap, CSrLctnRecord::Create },
	{ SR_NAME_LGTM, "LightingTemplate",     SRCLASS_CSrLgtmRecord, CSrLgtmRecord::s_FieldMap, CSrLgtmRecord::Create },
	{ SR_NAME_LIGH, "Light",				SRCLASS_CSrLighRecord, CSrLighRecord::s_FieldMap, CSrLighRecord::Create },
	{ SR_NAME_LSCR, "LoadScreen",			SRCLASS_CSrLscrRecord, CSrLscrRecord::s_FieldMap, CSrLscrRecord::Create },
	{ SR_NAME_LTEX, "LandTexture",			SRCLASS_CSrLtexRecord, CSrLtexRecord::s_FieldMap, CSrLtexRecord::Create },
	{ SR_NAME_LVLI, "LevelList",			SRCLASS_CSrLvliRecord, CSrLvliRecord::s_FieldMap, CSrLvliRecord::Create },
	{ SR_NAME_LVLN, "LevelActor",			SRCLASS_CSrLvlnRecord, CSrLvlnRecord::s_FieldMap, CSrLvlnRecord::Create },
	{ SR_NAME_LVSP, "LevelSpell",			SRCLASS_CSrLvspRecord, CSrLvspRecord::s_FieldMap, CSrLvspRecord::Create },
	{ SR_NAME_MATO, "MaterialObject",		SRCLASS_CSrMatoRecord, CSrMatoRecord::s_FieldMap, CSrMatoRecord::Create },
	{ SR_NAME_MATT, "MaterialType",			SRCLASS_CSrMattRecord, CSrMattRecord::s_FieldMap, CSrMattRecord::Create },
	{ SR_NAME_MESG, "Message",				SRCLASS_CSrMesgRecord, CSrMesgRecord::s_FieldMap, CSrMesgRecord::Create },
	{ SR_NAME_MGEF, "MagicEffect",			SRCLASS_CSrMgefRecord, CSrMgefRecord::s_FieldMap, CSrMgefRecord::Create },
	{ SR_NAME_MISC, "MiscObject",			SRCLASS_CSrMiscRecord, CSrMiscRecord::s_FieldMap, CSrMiscRecord::Create },
	{ SR_NAME_MOVT, "MovementType",			SRCLASS_CSrMovtRecord, CSrMovtRecord::s_FieldMap, CSrMovtRecord::Create },
	{ SR_NAME_MSTT, "MovableStatic",		SRCLASS_CSrMsttRecord, CSrMsttRecord::s_FieldMap, CSrMsttRecord::Create },
	{ SR_NAME_MUSC, "Music",				SRCLASS_CSrMuscRecord, CSrMuscRecord::s_FieldMap, CSrMuscRecord::Create },
	{ SR_NAME_MUST, "MusicTrack",			SRCLASS_CSrMustRecord, CSrMustRecord::s_FieldMap, CSrMustRecord::Create },
	{ SR_NAME_NAVI, "Navigation",			SRCLASS_CSrNaviRecord, CSrNaviRecord::s_FieldMap, CSrNaviRecord::Create },
	{ SR_NAME_NAVM, "NavMesh",				SRCLASS_CSrNavmRecord, CSrNavmRecord::s_FieldMap, CSrNavmRecord::Create },
	{ SR_NAME_NPC_, "Actor",				SRCLASS_CSrNpc_Record, CSrNpc_Record::s_FieldMap, CSrNpc_Record::Create },
	{ SR_NAME_OTFT, "Outfit",				SRCLASS_CSrOtftRecord, CSrOtftRecord::s_FieldMap, CSrOtftRecord::Create },
	{ SR_NAME_PACK, "Package",				SRCLASS_CSrPackRecord, CSrPackRecord::s_FieldMap, CSrPackRecord::Create },
	{ SR_NAME_PERK, "Perk",					SRCLASS_CSrPerkRecord, CSrPerkRecord::s_FieldMap, CSrPerkRecord::Create },
	{ SR_NAME_PGRE, "PlacedGrenade",		SRCLASS_CSrPgreRecord, CSrPgreRecord::s_FieldMap, CSrPgreRecord::Create },
	{ SR_NAME_PHZD, "PlacedHazard",			SRCLASS_CSrPhzdRecord, CSrPhzdRecord::s_FieldMap, CSrPhzdRecord::Create },
	{ SR_NAME_PROJ, "Projectile",			SRCLASS_CSrProjRecord, CSrProjRecord::s_FieldMap, CSrProjRecord::Create },
	{ SR_NAME_QUST, "Quest",				SRCLASS_CSrQustRecord, CSrQustRecord::s_FieldMap, CSrQustRecord::Create },
	{ SR_NAME_RACE, "Race",					SRCLASS_CSrRaceRecord, CSrRaceRecord::s_FieldMap, CSrRaceRecord::Create },
	{ SR_NAME_REFR, "Reference",			SRCLASS_CSrRefrRecord, CSrRefrRecord::s_FieldMap, CSrRefrRecord::Create },
	{ SR_NAME_REGN, "Region",				SRCLASS_CSrRegnRecord, CSrRegnRecord::s_FieldMap, CSrRegnRecord::Create },
	{ SR_NAME_RELA, "Relationship",			SRCLASS_CSrRelaRecord, CSrRelaRecord::s_FieldMap, CSrRelaRecord::Create },
	{ SR_NAME_REVB, "Reverb",				SRCLASS_CSrRevbRecord, CSrRevbRecord::s_FieldMap, CSrRevbRecord::Create },
	{ SR_NAME_RFCT, "Refreaction",			SRCLASS_CSrRfctRecord, CSrRfctRecord::s_FieldMap, CSrRfctRecord::Create },
	{ SR_NAME_SCEN, "Scene",				SRCLASS_CSrScenRecord, CSrScenRecord::s_FieldMap, CSrScenRecord::Create },
	{ SR_NAME_SCRL, "Scroll",				SRCLASS_CSrScrlRecord, CSrScrlRecord::s_FieldMap, CSrScrlRecord::Create },
	{ SR_NAME_SHOU, "Shout",				SRCLASS_CSrShouRecord, CSrShouRecord::s_FieldMap, CSrShouRecord::Create },
	{ SR_NAME_SLGM, "SoulGem",				SRCLASS_CSrSlgmRecord, CSrSlgmRecord::s_FieldMap, CSrSlgmRecord::Create },
	{ SR_NAME_SMBN, "StoryBranchNode",      SRCLASS_CSrSmbnRecord, CSrSmbnRecord::s_FieldMap, CSrSmbnRecord::Create },
	{ SR_NAME_SMEN, "StoryEventNode",		SRCLASS_CSrSmenRecord, CSrSmenRecord::s_FieldMap, CSrSmenRecord::Create },
	{ SR_NAME_SMQN, "StoryQuestNode",		SRCLASS_CSrSmqnRecord, CSrSmqnRecord::s_FieldMap, CSrSmqnRecord::Create },
	{ SR_NAME_SNCT, "SoundCategory",		SRCLASS_CSrSnctRecord, CSrSnctRecord::s_FieldMap, CSrSnctRecord::Create },
	{ SR_NAME_SNDR, "SoundReference",		SRCLASS_CSrSndrRecord, CSrSndrRecord::s_FieldMap, CSrSndrRecord::Create },
	{ SR_NAME_SOPM, "SoundOutputMarker",    SRCLASS_CSrSopmRecord, CSrSopmRecord::s_FieldMap, CSrSopmRecord::Create },
	{ SR_NAME_SOUN, "Sound",				SRCLASS_CSrSounRecord, CSrSounRecord::s_FieldMap, CSrSounRecord::Create },
	{ SR_NAME_SPEL, "Spell",				SRCLASS_CSrSpelRecord, CSrSpelRecord::s_FieldMap, CSrSpelRecord::Create },
	{ SR_NAME_SPGD, "ShaderParticle",		SRCLASS_CSrSpgdRecord, CSrSpgdRecord::s_FieldMap, CSrSpgdRecord::Create },
	{ SR_NAME_STAT, "Static",				SRCLASS_CSrStatRecord, CSrStatRecord::s_FieldMap, CSrStatRecord::Create },
	{ SR_NAME_TACT, "TalkingActivator",		SRCLASS_CSrTactRecord, CSrTactRecord::s_FieldMap, CSrTactRecord::Create },
	{ SR_NAME_TES4, "Tes4",					SRCLASS_CSrTes4Record, CSrTes4Record::s_FieldMap, CSrTes4Record::Create },
	{ SR_NAME_TREE, "Tree",					SRCLASS_CSrTreeRecord, CSrTreeRecord::s_FieldMap, CSrTreeRecord::Create },
	{ SR_NAME_TXST, "TextureSet",			SRCLASS_CSrTxstRecord, CSrTxstRecord::s_FieldMap, CSrTxstRecord::Create },
	{ SR_NAME_VTYP, "VoiceType",			SRCLASS_CSrVtypRecord, CSrVtypRecord::s_FieldMap, CSrVtypRecord::Create },
	{ SR_NAME_WATR, "Water",				SRCLASS_CSrWatrRecord, CSrWatrRecord::s_FieldMap, CSrWatrRecord::Create },
	{ SR_NAME_WEAP, "Weapon",				SRCLASS_CSrWeapRecord, CSrWeapRecord::s_FieldMap, CSrWeapRecord::Create },
	{ SR_NAME_WOOP, "WordofPower",			SRCLASS_CSrWoopRecord, CSrWoopRecord::s_FieldMap, CSrWoopRecord::Create },
	{ SR_NAME_WRLD, "World",				SRCLASS_CSrWrldRecord, CSrWrldRecord::s_FieldMap, CSrWrldRecord::Create },
	{ SR_NAME_WTHR, "Weather",				SRCLASS_CSrWthrRecord, CSrWthrRecord::s_FieldMap, CSrWthrRecord::Create }
};

const int g_RecTypeInfoCount = sizeof(g_RecTypeInfos) / sizeof(srrectypeinfo_t);


typedef TGenRefPtrMap<srrectype_t, srrectypeinfo_t, srrectype_t> CSrRecTypeInfoMap;


dword HashGenKey (const srrectype_t Key) 
{
	return (Key.Value >> 4);
}


bool CompareGenKeys (const srrectype_t Key1, const srrectype_t Key2) 
{
	return Key1.Value == Key2.Value;
}


const srrectypeinfo_t* GetSrRecTypeInfo (const srrectype_t RecordType)
{
	static CSrRecTypeInfoMap s_InfoMap;
	static bool IsInit = false;

	if (!IsInit)
	{
		s_InfoMap.InitHashTable(256);

		for (dword i = 0; i < g_RecTypeInfoCount; ++i)
		{
			s_InfoMap.SetAt(g_RecTypeInfos[i].Type, &g_RecTypeInfos[i]);
		}

		IsInit = true;
	}

	return s_InfoMap.Lookup(RecordType);
}


const char* GetSrRecTypeName (const srrectype_t RecordType)
{
	static CSString s_Buffer;

	const srrectypeinfo_t* pInfo = GetSrRecTypeInfo(RecordType);
	if (pInfo != NULL) return pInfo->Name;

	s_Buffer.Format("%4.4s", RecordType.Name);
	return s_Buffer.c_str();	
}