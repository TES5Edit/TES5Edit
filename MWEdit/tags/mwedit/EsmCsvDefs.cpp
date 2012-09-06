/*===========================================================================
 *
 * File:	Esmcsvdefs.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 13, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "esmcsvdefs.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("EsmCsvDefs.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Csv Record Arrays
 *
 *=========================================================================*/

int l_EsmCsvColActivator[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_MODEL,
	ESM_FIELD_ICON,
	ESM_FIELD_SCRIPT,
	-1,
 };

int l_EsmCsvColAlchemy[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_VALUE,
	ESM_FIELD_WEIGHT,
	ESM_FIELD_MODEL,
	ESM_FIELD_ICON,
	ESM_FIELD_SCRIPT,
	ESM_FIELD_AUTOCALC,
	-1,
 };

int l_EsmCsvColApparatus[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_TYPE,
	ESM_FIELD_VALUE,
	ESM_FIELD_WEIGHT,
	ESM_FIELD_QUALITY,
	ESM_FIELD_MODEL,
	ESM_FIELD_ICON,
	ESM_FIELD_SCRIPT,
	-1,
 };

int l_EsmCsvColArmor[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_TYPE,
	ESM_FIELD_VALUE,
	ESM_FIELD_WEIGHT,
	ESM_FIELD_RATING,
	ESM_FIELD_HEALTH,
	ESM_FIELD_MODEL,
	ESM_FIELD_ICON,
	ESM_FIELD_SCRIPT,
	ESM_FIELD_ENCHANTPTS,
	ESM_FIELD_ENCHANT,
	-1,
 };

int l_EsmCsvColBook[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_VALUE,
	ESM_FIELD_WEIGHT,
	ESM_FIELD_TEACHES,
	ESM_FIELD_ENCHANT,
	//ESM_FIELD_TEXT,	/* The text field messes things up due to CR and other characters */
	ESM_FIELD_ENCHANTPTS,
	ESM_FIELD_MODEL,
	ESM_FIELD_ICON,
	ESM_FIELD_SCRIPT,
	-1,
 };

int l_EsmCsvColClass[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_DESC,
	ESM_FIELD_PLAYABLE,
	-1,
 };

int l_EsmCsvColClothing[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_TYPE,
	ESM_FIELD_VALUE,
	ESM_FIELD_WEIGHT,
	ESM_FIELD_MODEL,
	ESM_FIELD_ICON,
	ESM_FIELD_SCRIPT,
	ESM_FIELD_ENCHANTPTS,
	ESM_FIELD_ENCHANT,
	-1,
 };

int l_EsmCsvColContainer[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_WEIGHT,
	ESM_FIELD_MODEL,
	ESM_FIELD_ICON,
	ESM_FIELD_SCRIPT,
	ESM_FIELD_ORGANIC,
	ESM_FIELD_RESPAWN,
	-1,
 };

int l_EsmCsvColEnchantment[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_TYPE,
	ESM_FIELD_COST,
	ESM_FIELD_CHARGE,
	ESM_FIELD_AUTOCALC,
	-1,
 };

int l_EsmCsvColGlobal[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_TYPE,
	ESM_FIELD_VALUE,
	-1,
 };

int l_EsmCsvColIngrediant[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_VALUE,
	ESM_FIELD_WEIGHT,
	ESM_FIELD_MODEL,
	ESM_FIELD_ICON,
	ESM_FIELD_SCRIPT,
	-1,
 };

int l_EsmCsvColLevelItems[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_ALLPC,
	ESM_FIELD_CHANCENONE,
	ESM_FIELD_CALCEACH,
	-1,
 };

int l_EsmCsvColLevelCreatures[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_ALLPC,
	ESM_FIELD_CHANCENONE,
	-1,
 };

int l_EsmCsvColLight[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_VALUE,
	ESM_FIELD_WEIGHT,
	ESM_FIELD_MODEL,
	ESM_FIELD_ICON,
	ESM_FIELD_SCRIPT,
	ESM_FIELD_SOUND,
	ESM_FIELD_RADIUS,
	-1,
 };

int l_EsmCsvColLock[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_VALUE,
	ESM_FIELD_WEIGHT,
	ESM_FIELD_USES,
	ESM_FIELD_QUALITY,
	ESM_FIELD_MODEL,
	ESM_FIELD_ICON,
	ESM_FIELD_SCRIPT,
	-1,
 };

int l_EsmCsvColMisc[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_VALUE,
	ESM_FIELD_WEIGHT,
	ESM_FIELD_MODEL,
	ESM_FIELD_ICON,
	ESM_FIELD_SCRIPT,
	-1,
 };

int l_EsmCsvColNpc[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_SCRIPT,
	ESM_FIELD_LEVEL,
	ESM_FIELD_RACE,
	ESM_FIELD_FEMALE,
	ESM_FIELD_CLASS,
	ESM_FIELD_FACTION,
	ESM_FIELD_RANK,
	ESM_FIELD_AUTOCALC,
	ESM_FIELD_RESPAWN,
	ESM_FIELD_ANIMATION,
	ESM_FIELD_DISPOSITION,
	ESM_FIELD_BLOOD,
	ESM_FIELD_HAIR,
	ESM_FIELD_HEAD,
	ESM_FIELD_PERSIST,
	ESM_FIELD_BLOCKED,
	ESM_FIELD_STRENGTH,	/* Not when AutoCalc=true */
	ESM_FIELD_AGILITY,
	ESM_FIELD_SPEED,
	ESM_FIELD_ENDURANCE,
	ESM_FIELD_PERSONALITY,
	ESM_FIELD_INTELLIGENCE,
	ESM_FIELD_WILLPOWER,
	ESM_FIELD_LUCK,
	ESM_FIELD_GOLD,
	ESM_FIELD_HEALTH,
	ESM_FIELD_FATIGUE,
	ESM_FIELD_SPELLPTS,
	/* Item, ItemEx, Spell, Skill, Attribute */
	-1,
 };

esmcsvcol_t l_EsmCsvColNpcEx[] = {
	{ ESM_FIELD_ID,		  0 },
	{ ESM_FIELD_ITEMTYPE,	  0 },
	{ ESM_FIELD_NAME,	  0 },
	{ ESM_FIELD_SCRIPT,	  0 },
	{ ESM_FIELD_LEVEL,	  0 },
	{ ESM_FIELD_RACE,	  0 },
	{ ESM_FIELD_FEMALE,	  0 },
	{ ESM_FIELD_CLASS,	  0 },
	{ ESM_FIELD_FACTION,	  0 },
	{ ESM_FIELD_RANK,	  0 },
	{ ESM_FIELD_AUTOCALC,	  0 },
	{ ESM_FIELD_RESPAWN,	  0 },
	{ ESM_FIELD_ANIMATION,    0 },
	{ ESM_FIELD_DISPOSITION,  0 },
	{ ESM_FIELD_BLOOD, 	  0 },
	{ ESM_FIELD_HAIR,	  0 },
	{ ESM_FIELD_HEAD,	  0 },
	{ ESM_FIELD_PERSIST,	  0 },
	{ ESM_FIELD_BLOCKED, 	  0 },
	{ ESM_FIELD_ATTRIBUTE, 	  MWESM_ATTRIBUTE_STR },	/* Not when AutoCalc=true */
	{ ESM_FIELD_ATTRIBUTE, 	  MWESM_ATTRIBUTE_AGI },
	{ ESM_FIELD_ATTRIBUTE, 	  MWESM_ATTRIBUTE_SPD },
	{ ESM_FIELD_ATTRIBUTE, 	  MWESM_ATTRIBUTE_END },
	{ ESM_FIELD_ATTRIBUTE,    MWESM_ATTRIBUTE_INT },
	{ ESM_FIELD_ATTRIBUTE,	  MWESM_ATTRIBUTE_WIL },
	{ ESM_FIELD_ATTRIBUTE, 	  MWESM_ATTRIBUTE_PER },
	{ ESM_FIELD_ATTRIBUTE, 	  MWESM_ATTRIBUTE_LUC },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_BLOCK },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_ARMORER },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_MEDARMOR },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_HEAVYARMOR },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_BLUNT },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_LONGBLADE },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_AXE },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_SPEAR },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_ATHLETICS },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_ENCHANT },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_DESTRUCTION },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_ALTERATION },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_ILLUSION },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_CONJURATION },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_MYSTICISM },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_RESTORATION },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_ALCHEMY },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_SECURITY },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_SNEAK },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_ACROBATICS },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_UNARMORED },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_LIGHTARMOR },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_SHORTBLADE },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_MARKSMAN },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_MERCANTILE },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_SPEECHCRAFT },
	{ ESM_FIELD_SKILL, 	  MWESM_SKILL_HANDTOHAND },
	/* Item, ItemEx, Spell, Skill, Attribute */
	{ -1, 0 }
 };

int l_EsmCsvColProbe[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_VALUE,
	ESM_FIELD_WEIGHT,
	ESM_FIELD_USES,
	ESM_FIELD_QUALITY,
	ESM_FIELD_MODEL,
	ESM_FIELD_ICON,
	ESM_FIELD_SCRIPT,
	-1,
 };

int l_EsmCsvColRace[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_DESC,
	ESM_FIELD_PLAYABLE,
	-1,
 };

int l_EsmCsvColRepair[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_VALUE,
	ESM_FIELD_WEIGHT,
	ESM_FIELD_USES,
	ESM_FIELD_QUALITY,
	ESM_FIELD_MODEL,
	ESM_FIELD_ICON,
	ESM_FIELD_SCRIPT,
	-1,
 };

int l_EsmCsvColSoundGen[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_TYPE,
	ESM_FIELD_SOUND,
	ESM_FIELD_CREATURE,
	-1,
 };

int l_EsmCsvColSound[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_MINRANGE,
	ESM_FIELD_MAXRANGE,
	ESM_FIELD_VOLUME,
	-1,
 };

int l_EsmCsvColSpell[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_AUTOCALC,
	ESM_FIELD_PCSTART,
	ESM_FIELD_TYPE,
	ESM_FIELD_COST,
	-1,
 };

int l_EsmCsvColStatic[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_MODEL,
	-1,
 };

int l_EsmCsvColWeapon[] = {
	ESM_FIELD_ID,
	ESM_FIELD_ITEMTYPE,
	ESM_FIELD_NAME,
	ESM_FIELD_VALUE,
	ESM_FIELD_WEIGHT,
	ESM_FIELD_TYPE,
	ESM_FIELD_CHOPMIN,
	ESM_FIELD_CHOPMAX,
	ESM_FIELD_SLASHMIN,
	ESM_FIELD_SLASHMAX,
	ESM_FIELD_THRUSTMIN,
	ESM_FIELD_THRUSTMAX,
	ESM_FIELD_IGNORERESIST,
	ESM_FIELD_HEALTH,
	ESM_FIELD_SPEED,
	ESM_FIELD_REACH,
	-1,
 };

static esmcsvrecinfo_t l_EsmCsvRecInfos[] = {
	{ MWESM_REC_ACTI, _T("Activator"),	l_EsmCsvColActivator,	NULL },
	{ MWESM_REC_ALCH, _T("Alchemy"),	l_EsmCsvColAlchemy,	NULL },
	{ MWESM_REC_APPA, _T("Apparatus"),	l_EsmCsvColApparatus,	NULL },
	{ MWESM_REC_ARMO, _T("Armor"),		l_EsmCsvColArmor,	NULL },
	{ MWESM_REC_BOOK, _T("Book"),		l_EsmCsvColBook,	NULL },
	{ MWESM_REC_CLAS, _T("Class"),		l_EsmCsvColClass,	NULL },
	{ MWESM_REC_CLOT, _T("Clothing"),	l_EsmCsvColClothing,	NULL },
	{ MWESM_REC_CONT, _T("Container"),	l_EsmCsvColContainer,	NULL },
	{ MWESM_REC_ENCH, _T("Enchantment"),	l_EsmCsvColEnchantment,	NULL },
	{ MWESM_REC_GLOB, _T("Global"),		l_EsmCsvColGlobal,	NULL },
	{ MWESM_REC_INGR, _T("Ingredient"),	l_EsmCsvColIngrediant,	NULL },
	{ MWESM_REC_LEVI, _T("Level Item"),	l_EsmCsvColLevelItems,	NULL },
	{ MWESM_REC_LEVC, _T("Level Creature"),	l_EsmCsvColLevelCreatures,	NULL },
	{ MWESM_REC_LIGH, _T("Light"),		l_EsmCsvColLight,	NULL },
	{ MWESM_REC_LOCK, _T("Lock"),		l_EsmCsvColLock,	NULL },
	{ MWESM_REC_MISC, _T("Misc"),		l_EsmCsvColMisc,	NULL },
	{ MWESM_REC_NPC_, _T("NPC"),		l_EsmCsvColNpc,		l_EsmCsvColNpcEx },
	{ MWESM_REC_PROB, _T("Probe"),		l_EsmCsvColProbe,	NULL },
	{ MWESM_REC_RACE, _T("Race"),		l_EsmCsvColRace,	NULL },
	{ MWESM_REC_REPA, _T("Repair"),		l_EsmCsvColRepair,	NULL },
	{ MWESM_REC_SNDG, _T("SoundGen"),	l_EsmCsvColSoundGen,	NULL },
	{ MWESM_REC_SOUN, _T("Sound"),		l_EsmCsvColSound,	NULL },
	{ MWESM_REC_SPEL, _T("Spell"),		l_EsmCsvColSpell,	NULL },
	{ MWESM_REC_STAT, _T("Static"),		l_EsmCsvColStatic,	NULL },
	{ MWESM_REC_WEAP, _T("Weapon"),		l_EsmCsvColWeapon,	NULL },
	{ NULL, NULL, NULL }
 };
/*===========================================================================
 *		End of Csv Record Arrays
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int l_FindCsvItemType (pString);
 *
 * Finds the array index in the local l_EsmCsvRecInfos[] that has a matching
 * item type string. Returns -1 on any error.
 *
 *=========================================================================*/
int l_FindCsvItemType (const TCHAR* pString) {
  int Index = 0;

  while (l_EsmCsvRecInfos[Index].pEsmRecType != NULL) {
    if (strnicmp(l_EsmCsvRecInfos[Index].pEsmRecType, pString, 4) == 0) return (Index);
    Index++;
   }

  return (-1);
 }
/*===========================================================================
 *		End of Function l_FindCsvItemType()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int l_FindCsvRecordString (pString);
 *
 * Finds the array index in the local l_EsmCsvRecInfos[] that has a matching
 * record string. Returns -1 on any error.
 *
 *=========================================================================*/
int l_FindCsvRecordString (const TCHAR* pString) {
  int Index = 0;

  while (l_EsmCsvRecInfos[Index].pEsmRecType != NULL) {
    if (stricmp(l_EsmCsvRecInfos[Index].pRecordName, pString) == 0) return (Index);
    Index++;
   }

  return (-1);
 }
/*===========================================================================
 *		End of Function l_FindCsvRecordString()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const TCHAR* GetEsmCsvRecordType (pString);
 *
 * Converts a record type string input from a CSV file to a regular MW
 * record type string. Returns NULL on any error.
 *
 *=========================================================================*/
const TCHAR* GetEsmCsvRecordType (const TCHAR* pString) {
  int Index;

  Index = l_FindCsvRecordString(pString);
  if (Index < 0) return (NULL);

  return (l_EsmCsvRecInfos[Index].pEsmRecType);
 }
/*===========================================================================
 *		End of Function TCHAR* GetEsmCsvRecordType()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const TCHAR* GetEsmCsvRecordString (pString);
 *
 * Converts an ESM record type string into a record string for outputting 
 * to a CSV file. Returns NULL on any error.
 *
 *=========================================================================*/
const TCHAR* GetEsmCsvRecordString (const TCHAR* pString) {
  int Index;

  Index = l_FindCsvItemType(pString);
  if (Index < 0) return (NULL);

  return (l_EsmCsvRecInfos[Index].pRecordName);
 }
/*===========================================================================
 *		End of Function TCHAR* GetEsmCsvRecordType()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const TCHAR* GetEsmCsvColArray (pString);
 *
 * Gets the field ID array for the given ESM record type string.
 * Returns NULL on any error.
 *
 *=========================================================================*/
int* GetEsmCsvColArray (const TCHAR* pType) {
  int Index;

  Index = l_FindCsvItemType(pType);
  if (Index < 0) return (NULL);

  return (l_EsmCsvRecInfos[Index].pColArray);
 }


esmcsvcol_t* GetEsmCsvExColArray (const TCHAR* pType) {
  int Index;

  Index = l_FindCsvItemType(pType);
  if (Index < 0) return (NULL);

  return (l_EsmCsvRecInfos[Index].pExColArray);
 }
/*===========================================================================
 *		End of Function TCHAR* GetEsmCsvColArray()
 *=========================================================================*/


