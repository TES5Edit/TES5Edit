/*===========================================================================
 *
 * File:	Esmutils.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 9, 2003
 *
 * Description
 *
 * 18 October 2003
 *	- The SelectTexture/Model/Sound/Icon() methods updated to use 
 *	  the previous filename as the initial filename.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "esmutils.h"
#include "EsmArmor.h"
#include "MWEditDoc.h"
#include "windows/WinUtil.h"
#include <direct.h>
#include "esmgloboptions.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("EsmUtils.cpp");

  CString	l_MWDataPath = _T("");	/* Absolute path to the Morrowind data files */

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Array to Convert from a Biped to a Bodypart Type
 *
 *=========================================================================*/
int l_BipedToBody[] = {
	0, 1, 2, 3, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, -1, 14
 };
/*===========================================================================
 *		End of Array to Convert from a Biped to a Bodypart Type
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int ConvertBipedToBodyPart (BipedType);
 *
 * Returns the body part type related to the given input BipedType.  Returns
 * -1 on any error.
 *
 *=========================================================================*/
int ConvertBipedToBodyPart (const int BipedType) {
  if (BipedType < MWESM_BIPEDPART_MIN || BipedType > MWESM_BIPEDPART_MAX) return (-1);
  return l_BipedToBody[BipedType];
 }
/*===========================================================================
 *		End of Function ConvertBipedToBodyPart()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmArmorTypeCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmArmorTypeCombo (CComboBox& ComboBox) {
  //DEFINE_FUNCTION("FillEsmArmorTypeCombo()");
  int Index;
  int ResultIndex;

  ComboBox.ResetContent();

  for (Index = MWESM_ARMORTYPE_MIN; Index <= MWESM_ARMORTYPE_MAX; Index++) {
     ResultIndex = ComboBox.AddString(GetESMArmorType(Index));
     ComboBox.SetItemData(ResultIndex, Index);
   }

 }
/*===========================================================================
 *		End of Function FillEsmArmorTypeCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmScriptCombo (ComboBox);
 *
 * Fills the given combobox with the scripts of the currently active 
 * document.
 *
 *=========================================================================*/
void FillEsmScriptCombo (CComboBox& ComboBox) {
  FillEsmRecordCombo(ComboBox, MWESM_REC_SCPT, true);
 }

void FillEsmSoundCombo (CComboBox& ComboBox) {
  FillEsmRecordCombo(ComboBox, MWESM_REC_SOUN);
 }

void FillEsmRaceCombo (CComboBox& ComboBox, const bool IncludeEmpty) {
  FillEsmRecordCombo(ComboBox, MWESM_REC_RACE, IncludeEmpty);
 }

void FillEsmEnchantCombo (CComboBox& ComboBox) {
  FillEsmRecordCombo(ComboBox, MWESM_REC_ENCH);
 }

void FillEsmRegionCombo (CComboBox& ComboBox) {
  FillEsmRecordCombo(ComboBox, MWESM_REC_REGN);
 }

void FillEsmGlobalCombo (CComboBox& ComboBox) {
  FillEsmRecordCombo(ComboBox, MWESM_REC_GLOB, false);
 }

void FillEsmCellCombo (CComboBox& ComboBox, const bool IncludeEmpty) {
  FillEsmRecordCombo(ComboBox, MWESM_REC_CELL, IncludeEmpty);
 }

void FillEsmClassCombo (CComboBox& ComboBox, const bool IncludeEmpty) {
  FillEsmRecordCombo(ComboBox, MWESM_REC_CLAS, IncludeEmpty);
 }

void FillEsmNpcCombo (CComboBox& ComboBox, const bool IncludeEmpty) {
  FillEsmRecordCombo(ComboBox, MWESM_REC_NPC_, IncludeEmpty);
 }

void FillEsmFactionCombo (CComboBox& ComboBox, const bool IncludeEmpty) {
  FillEsmRecordCombo(ComboBox, MWESM_REC_FACT, IncludeEmpty);
 }
/*===========================================================================
 *		End of Function FillEsmScriptCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmRecordCombo (ComboBox, pType, IncludeEmpty);
 *
 * Fills the given combobox with the given type of records from the currently 
 * active document.
 *
 *=========================================================================*/
void FillEsmRecordCombo (CComboBox& ComboBox, const TCHAR* pType, const bool IncludeEmpty) {
  CMWEditDoc*   pDocument = (CMWEditDoc *) GetActiveDocument();
  esmrecinfo_t* pRecInfo;
  int	        ArrayIndex;
  int	        ListIndex;

  ComboBox.ResetContent();
  if (pDocument == NULL || !pDocument->IsKindOf(RUNTIME_CLASS(CMWEditDoc))) return;

	/* Add the default empty entry */
  if (IncludeEmpty) {
    ListIndex = ComboBox.AddString(_T(""));
    if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD) NULL);
   }

  	/* Find and add all scripts from the document */
  pRecInfo = pDocument->FindFirstRecord(pType, ArrayIndex);

  while (pRecInfo != NULL) {
    ListIndex = ComboBox.AddString(pRecInfo->pRecord->GetID());
    if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD) pRecInfo);
    pRecInfo = pDocument->FindNextRecord(pType, ArrayIndex);
   }

 }
/*===========================================================================
 *		End of Function FillEsmRecordCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmApparatusTypeCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmApparatusTypeCombo (CComboBox& ComboBox) {
  int Index;
  int ResultIndex;

	/* Delete the current contents, if any */
  ComboBox.ResetContent();

  for (Index = MWESM_APPATYPE_MIN; Index <= MWESM_APPATYPE_MAX; Index++) {
     ResultIndex = ComboBox.AddString(GetESMAppaType(Index));
     ComboBox.SetItemData(ResultIndex, Index);
   }

 }
/*===========================================================================
 *		End of Function FillEsmApparatusTypeCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmBodyPartsCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmBodyPartsCombo (CComboBox& ComboBox) {
  int Index;
  int ResultIndex;

	/* Delete the current contents, if any */
  ComboBox.ResetContent();

	/* Add the default empty entry */
  ResultIndex = ComboBox.AddString(_T(""));
  if (ResultIndex >= 0) ComboBox.SetItemData(ResultIndex, (DWORD) -1);

  for (Index = MWESM_BIPEDPART_MIN; Index <= MWESM_BIPEDPART_MAX; Index++) {
     ResultIndex = ComboBox.AddString(GetMWBipedPartType(Index));
     ComboBox.SetItemData(ResultIndex, Index);
   }

 }
/*===========================================================================
 *		End of Function FillEsmBodyPartsCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmBodyPartsCombo (ComboBox, BodyPart, IsFemale, BodyPartType, AddEmpty);
 *
 * Fills the given list with body part records that match the input type
 * and gender.
 *
 *=========================================================================*/
void FillEsmBodyPartsCombo (CComboBox& ComboBox, const int BodyPart, const bool IsFemale, const int BodyPartType, const bool AddEmpty) {
  CMWEditDoc*   pDocument = (CMWEditDoc *) GetActiveDocument();
  esmrecinfo_t* pRecInfo;
  CEsmBodyPart* pBodyPart;
  int	        ArrayIndex;
  int	        ListIndex;

  ComboBox.ResetContent();
  if (pDocument == NULL || !pDocument->IsKindOf(RUNTIME_CLASS(CMWEditDoc))) return;

	/* Add the default empty entry */
  if (AddEmpty) {
    ListIndex = ComboBox.AddString(_T(""));
    if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD) NULL);
  }

	/* Find and add all scripts from the document */
  pRecInfo = pDocument->FindFirstRecord(MWESM_REC_BODY, ArrayIndex);

  while (pRecInfo != NULL) {
    pBodyPart = (CEsmBodyPart *) pRecInfo->pRecord;

		/* Determine if the current body part is the correct type */
    if ((pBodyPart->IsFemale() == IsFemale) && (pBodyPart->GetBodyPartID() == BodyPart) && BodyPart >= 0 &&
		(pBodyPart->GetBodyTypeID() == BodyPartType) && BodyPartType >= 0)  {
      ListIndex = ComboBox.AddString(pRecInfo->pRecord->GetID());
      if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD) pRecInfo);
     }

    pRecInfo = pDocument->FindNextRecord(MWESM_REC_BODY, ArrayIndex);
   }

 }
/*===========================================================================
 *		End of Function FillEsmBodyPartsCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmBodyRaceCombo (ComboBox, BodyPart, IsFemale, pRace, AddEmpty);
 *
 * Fills the given list with body part records that match the input type
 * and gender and race.
 *
 *=========================================================================*/
void FillEsmBodyRaceCombo (CComboBox& ComboBox, const int BodyPart, const bool IsFemale, const TCHAR* pRace, const bool AddEmpty) {
  CMWEditDoc*   pDocument = (CMWEditDoc *) GetActiveDocument();
  esmrecinfo_t* pRecInfo;
  CEsmBodyPart* pBodyPart;
  int	        ArrayIndex;
  int	        ListIndex;

  ComboBox.ResetContent();
  if (pDocument == NULL || !pDocument->IsKindOf(RUNTIME_CLASS(CMWEditDoc))) return;

	/* Add the default empty entry */
  if (AddEmpty) {
    ListIndex = ComboBox.AddString(_T(""));
    if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD) NULL);
  }

	/* Find and add all scripts from the document */
  pRecInfo = pDocument->FindFirstRecord(MWESM_REC_BODY, ArrayIndex);

  while (pRecInfo != NULL) {
    pBodyPart = (CEsmBodyPart *) pRecInfo->pRecord;

		/* Determine if the current body part is the correct type */
    if ((pBodyPart->IsFemale() == IsFemale) && (pBodyPart->GetBodyPartID() == BodyPart) && BodyPart >= 0 &&
		TSTRICMP(pRace, pBodyPart->GetRace()) == 0)  {
      ListIndex = ComboBox.AddString(pRecInfo->pRecord->GetID());
      if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD) pRecInfo);
     }

    pRecInfo = pDocument->FindNextRecord(MWESM_REC_BODY, ArrayIndex);
   }

 }
/*===========================================================================
 *		End of Function FillEsmBodyRaceCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmAttributesCombo (CComboBox& ComboBox);
 *
 *=========================================================================*/
void FillEsmAttributesCombo (CComboBox& ComboBox) {
  int Index;
  int ResultIndex;

	/* Delete the current contents, if any */
  ComboBox.ResetContent();

  for (Index = 0; Index < MWESM_MAX_ATTRIBUTES; Index++) {
     ResultIndex = ComboBox.AddString(GetESMAttribute(Index));
     ComboBox.SetItemData(ResultIndex, Index);
   }

 }
/*===========================================================================
 *		End of Function FillEsmAttributesCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmClothTypeCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmClothTypeCombo (CComboBox& ComboBox) {
  int Index;
  int ResultIndex;

	/* Delete the current contents, if any */
  ComboBox.ResetContent();

  for (Index = 0; Index < MWESM_CLOTHTYPE_MAX; Index++) {
     ResultIndex = ComboBox.AddString(GetESMClothType(Index));
     ComboBox.SetItemData(ResultIndex, Index);
   }

 }
/*===========================================================================
 *		End of Function FillEsmClothTypeCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmSkillsCombo (CComboBox& ComboBox, IncludeEmpty);
 *
 *=========================================================================*/
void FillEsmSkillsCombo (CComboBox& ComboBox, const bool IncludeEmpty) {
  int Index;
  int ResultIndex;

	/* Delete the current contents, if any */
  ComboBox.ResetContent();

	/* Include the empty skill if required */
  if (IncludeEmpty) {
    ResultIndex = ComboBox.AddString("");
    ComboBox.SetItemData(ResultIndex, -1);
   }

  for (Index = 0; Index < MWESM_MAX_SKILLS; Index++) {
     ResultIndex = ComboBox.AddString(GetESMSkill(Index));
     ComboBox.SetItemData(ResultIndex, Index);
   }

 }
/*===========================================================================
 *		End of Function FillEsmSkillsCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmEffectsCombo (ComboBox, IsAlchemy);
 *
 *=========================================================================*/
void FillEsmEffectsCombo (CComboBox& ComboBox, const bool IsAlchemy) {
  const esmeffectdata_t* pEffectData;
  
  int Index;
  int ResultIndex;

	/* Delete the current contents, if any */
  ComboBox.ResetContent();

	/* Add the default empty entry */
  ResultIndex = ComboBox.AddString(_T(""));
  if (ResultIndex >= 0) ComboBox.SetItemData(ResultIndex, (DWORD) -1);

  for (Index = 0; Index < MWESM_MAX_EFFECTS; Index++) {
     pEffectData = GetESMEffectData (Index);

     if (!IsAlchemy || (IsAlchemy && pEffectData->IsAlchemy())) {
       ResultIndex = ComboBox.AddString(GetESMEffect(Index));
       ComboBox.SetItemData(ResultIndex, Index);
      }
   }

 }
/*===========================================================================
 *		End of Function FillEsmEffectsCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmSpellSchoolCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmSpellSchoolCombo (CComboBox& ComboBox) {
  int Index;
  int ResultIndex;

	/* Delete the current contents, if any */
  ComboBox.ResetContent();

  for (Index = MWESM_SCHOOL_MIN; Index <= MWESM_SCHOOL_MAX; Index++) {
     ResultIndex = ComboBox.AddString(GetESMSpellSchool(Index));
     ComboBox.SetItemData(ResultIndex, Index);
   }

 }
/*===========================================================================
 *		End of Function FillEsmSpellSchoolCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmGlobalTypeCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmGlobalTypeCombo (CComboBox& ComboBox) {
  int ListIndex;

  ComboBox.ResetContent();

  ListIndex = ComboBox.AddString(_T("short"));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_GLOBAL_SHORT);
  ListIndex = ComboBox.AddString(_T("long"));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_GLOBAL_LONG);
  ListIndex = ComboBox.AddString(_T("float"));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_GLOBAL_FLOAT);
 }
/*===========================================================================
 *		End of Function FillEsmGlobalTypeCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmBodyPartCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmBodyPartCombo (CComboBox& ComboBox) {
  int Index;
  int ResultIndex;

	/* Delete the current contents, if any */
  ComboBox.ResetContent();

  for (Index = MWESM_PART_MIN; Index <= MWESM_PART_MAX; Index++) {
    ResultIndex = ComboBox.AddString(GetESMBodyPart(Index));
    ComboBox.SetItemData(ResultIndex, Index);
   }

 }
/*===========================================================================
 *		End of Function FillEsmBodyPartCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmBodyPartTypeCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmBodyPartTypeCombo (CComboBox& ComboBox) {
  int Index;
  int ResultIndex;

	/* Delete the current contents, if any */
  ComboBox.ResetContent();

  for (Index = MWESM_PARTTYPE_MIN; Index <= MWESM_PARTTYPE_MAX; Index++) {
    ResultIndex = ComboBox.AddString(GetESMBodyPartType(Index));
    ComboBox.SetItemData(ResultIndex, Index);
   }

 }
/*===========================================================================
 *		End of Function FillEsmBodyPartTypeCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmEnchantTypeCombo (ComboBox, NoSelf);
 *
 *=========================================================================*/
void FillEsmEnchantTypeCombo (CComboBox& ComboBox) {
  int ListIndex;
  int Index;

  ComboBox.ResetContent();
  
  for (Index = MWESM_ENCHTYPE_MIN; Index <= MWESM_ENCHTYPE_MAX; Index++) {
    ListIndex = ComboBox.AddString(GetESMEnchantType(Index));
    ComboBox.SetItemData(ListIndex, Index);
   }

 }
/*===========================================================================
 *		End of Function FillEsmEnchantTypeCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmEnchantRangeCombo (ComboBox, NoSelf);
 *
 *=========================================================================*/
void FillEsmEnchantRangeCombo (CComboBox& ComboBox, const bool NoSelf) {
  int ListIndex;
  int Index;

  ComboBox.ResetContent();
  
  for (Index = MWESM_ENCHANTRANGE_MIN; Index <= MWESM_ENCHANTRANGE_MAX; Index++) {

    if (!NoSelf || Index != MWESM_ENCHANTRANGE_SELF) {
      ListIndex = ComboBox.AddString(GetESMEnchantRangeType(Index));
      ComboBox.SetItemData(ListIndex, Index);
     }
   }

 }
/*===========================================================================
 *		End of Function FillEsmEnchantRangeCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmSpellTypeCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmSpellTypeCombo (CComboBox& ComboBox) {
  int ListIndex;
  int Index;

  ComboBox.ResetContent();
  
  for (Index = MWESM_SPELLTYPE_MIN; Index <= MWESM_SPELLTYPE_MAX; Index++) {
    ListIndex = ComboBox.AddString(GetESMSpellType(Index));
    ComboBox.SetItemData(ListIndex, Index);
   }

 }
/*===========================================================================
 *		End of Function FillEsmSpellTypeCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmLightFlickerCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmLightFlickerCombo (CComboBox& ComboBox) {
  int ListIndex;
  ComboBox.ResetContent();

  ListIndex = ComboBox.AddString(GetESMLightFlicker(MWESM_LIGHTFLAG_FLICKER));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_LIGHTFLAG_FLICKER);

  ListIndex = ComboBox.AddString(GetESMLightFlicker(MWESM_LIGHTFLAG_PULSE));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_LIGHTFLAG_PULSE);

  ListIndex = ComboBox.AddString(GetESMLightFlicker(MWESM_LIGHTFLAG_PULSESLOW));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_LIGHTFLAG_PULSESLOW);

  ListIndex = ComboBox.AddString(GetESMLightFlicker(MWESM_LIGHTFLAG_FLICKERSLOW));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_LIGHTFLAG_FLICKERSLOW);

  ListIndex = ComboBox.AddString(GetESMLightFlicker(0));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, 0);

 }
/*===========================================================================
 *		End of Function TCHAR* FillEsmLightFlickerCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmVisualCombo (ComboBox, IsBolt);
 *
 *=========================================================================*/
void FillEsmVisualCombo (CComboBox& ComboBox, const bool IsBolt) {
  CMWEditDoc*   pDocument = (CMWEditDoc *) GetActiveDocument();
  esmrecinfo_t* pRecInfo;
  int		ArrayIndex;
  int		ListIndex;

  ComboBox.ResetContent();
  if (pDocument == NULL) return;

  pRecInfo = pDocument->FindFirstRecord(IsBolt ? MWESM_REC_WEAP : MWESM_REC_STAT, ArrayIndex);
  
  while (pRecInfo != NULL) {
    
    if (TSTRNICMP(pRecInfo->pRecord->GetID(), _T("VFX_"), 4) == 0) {
      ListIndex = ComboBox.AddString(pRecInfo->pRecord->GetID());
      if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD) pRecInfo);
     }

    pRecInfo = pDocument->FindNextRecord(IsBolt ? MWESM_REC_WEAP : MWESM_REC_STAT, ArrayIndex);
   }

 }
/*===========================================================================
 *		End of Function FillEsmVisualCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmWeaponTypeCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmWeaponTypeCombo (CComboBox& ComboBox) {
  int ListIndex;
  int Index;

  ComboBox.ResetContent();
  
  for (Index = MWESM_WEAPONTYPE_MIN; Index <= MWESM_WEAPONTYPE_MAX; Index++) {
    ListIndex = ComboBox.AddString(GetESMWeaponType(Index));
    ComboBox.SetItemData(ListIndex, Index);
   }

 }
/*===========================================================================
 *		End of Function FillEsmWeaponTypeCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmClassSpecCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmClassSpecCombo (CComboBox& ComboBox) {
  int ListIndex;
 
  ComboBox.ResetContent();
 
  ListIndex = ComboBox.AddString(GetESMClassSpec(MWESM_CLASSSPEC_COMBAT));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_CLASSSPEC_COMBAT);
  ListIndex = ComboBox.AddString(GetESMClassSpec(MWESM_CLASSSPEC_MAGIC));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_CLASSSPEC_MAGIC);
  ListIndex = ComboBox.AddString(GetESMClassSpec(MWESM_CLASSSPEC_STEALTH));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_CLASSSPEC_STEALTH);

 }
/*===========================================================================
 *		End of Function FillEsmClassSpecCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmCreatureCombo (ComboBox, IncludeEmpty, IncludeLevel);
 *
 *=========================================================================*/
void FillEsmCreatureCombo (CComboBox& ComboBox, const bool IncludeEmpty, const bool IncludeLevel) {
  CMWEditDoc*   pDocument = (CMWEditDoc *) GetActiveDocument();
  esmrecinfo_t* pRecInfo;
  int		ArrayIndex;
  int		ListIndex;

  ComboBox.ResetContent();
  if (pDocument == NULL) return;

  if (IncludeEmpty) {
    ListIndex = ComboBox.AddString(_T(""));
    if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, NULL);
   }

  pRecInfo = pDocument->FindFirstRecord(MWESM_REC_CREA, ArrayIndex);
  
  while (pRecInfo != NULL) {
    ListIndex = ComboBox.AddString(pRecInfo->pRecord->GetID());
    if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD) pRecInfo);
    pRecInfo = pDocument->FindNextRecord(MWESM_REC_CREA, ArrayIndex);
   }

	/* Include leveled creatures */
  if (IncludeLevel) {
    pRecInfo = pDocument->FindFirstRecord(MWESM_REC_LEVC, ArrayIndex);
  
    while (pRecInfo != NULL) {
      ListIndex = ComboBox.AddString(pRecInfo->pRecord->GetID());
      if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD) pRecInfo);
      pRecInfo = pDocument->FindNextRecord(MWESM_REC_LEVC, ArrayIndex);
     }
   }

 }
/*===========================================================================
 *		End of Function FillEsmCreatureCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmJournalCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmJournalCombo (CComboBox& ComboBox) {
  CMWEditDoc*   pDocument = (CMWEditDoc *) GetActiveDocument();
  CEsmDialogue* pDialogue;
  esmrecinfo_t* pRecInfo;
  int		ArrayIndex;
  int		ListIndex;

  ComboBox.ResetContent();
  if (pDocument == NULL) return;

  //ListIndex = ComboBox.AddString(_T(""));
  //if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, NULL);

  pRecInfo = pDocument->FindFirstRecord(MWESM_REC_DIAL, ArrayIndex);
  
  while (pRecInfo != NULL) {
    pDialogue = (CEsmDialogue *) pRecInfo->pRecord;

    if (pDialogue->GetDialogTypeID() == MWESM_DIALTYPE_JOURNAL) {
      ListIndex = ComboBox.AddString(pRecInfo->pRecord->GetID());
      if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD) pRecInfo);
     }

    pRecInfo = pDocument->FindNextRecord(MWESM_REC_DIAL, ArrayIndex);
   }

 }
/*===========================================================================
 *		End of Function FillEsmJournalCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmLocalCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmLocalCombo (CComboBox& ComboBox) {
  CMWEditDoc*    pDocument = (CMWEditDoc *) GetActiveDocument();
  CEsmScript*    pScript;
  CEsmSubRecord* pScriptVars;
  esmrecinfo_t*  pRecInfo;
  int		 ArrayIndex;
  int		 ListIndex;
  int		 TotalVarLength;
  int		 VarLength;
  int		 Length;
  char*		 pVar;

  ComboBox.ResetContent();
  if (pDocument == NULL) return;

  //ListIndex = ComboBox.AddString(_T(""));
  //if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, NULL);

  pRecInfo = pDocument->FindFirstRecord(MWESM_REC_SCPT, ArrayIndex);
  
  while (pRecInfo != NULL) {
    pScript = (CEsmScript *) pRecInfo->pRecord;
    pScriptVars = pScript->GetScriptVars();

    if (pScriptVars != NULL && pScriptVars->GetData() != NULL) {
      TotalVarLength = pScriptVars->GetRecordSize();
      pVar = (char *)pScriptVars->GetData();
      Length = 0;

      while (Length < TotalVarLength) { 
        VarLength = strlen(pVar);
	if (VarLength > TotalVarLength) break;

	ListIndex = ComboBox.FindString(-1, pVar);
        if (ListIndex < 0) ComboBox.AddString(pVar);
	
	pVar   += VarLength + 1;
	Length += VarLength + 1;
       }

      //ListIndex = ComboBox.AddString(pRecInfo->pRecord->GetID());
      //if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD) pRecInfo);
     }

    pRecInfo = pDocument->FindNextRecord(MWESM_REC_SCPT, ArrayIndex);
   }

 }
/*===========================================================================
 *		End of Function FillEsmLocalCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmItemCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmItemCombo (CComboBox& ComboBox) {
  CMWEditDoc*   pDocument = (CMWEditDoc *) GetActiveDocument();
  esmrecinfo_t* pRecInfo;
  int		ArrayIndex;
  int		ListIndex;

  ComboBox.ResetContent();
  if (pDocument == NULL) return;

  //ListIndex = ComboBox.AddString(_T(""));
  //if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, NULL);

  pRecInfo = pDocument->FindFirstItem(ArrayIndex);
  
  while (pRecInfo != NULL) {
    ListIndex = ComboBox.AddString(pRecInfo->pRecord->GetID());
    if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD) pRecInfo);

    pRecInfo = pDocument->FindNextItem(ArrayIndex);
   }
 }
/*===========================================================================
 *		End of Function FillEsmItemCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmFunctionCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmFunctionCombo (CComboBox& ComboBox) {
  static short s_Functions[] = {*(short *)"00", *(short *)"01", *(short *)"02", *(short *)"03", *(short *)"04",
	 *(short *)"05", *(short *)"06", *(short *)"07", *(short *)"08", *(short *)"09", *(short *)"10", *(short *)"11",
	 *(short *)"12", *(short *)"13", *(short *)"14", *(short *)"15", *(short *)"16", *(short *)"17", *(short *)"18",
	 *(short *)"19", *(short *)"20", *(short *)"21", *(short *)"22", *(short *)"23", *(short *)"24", *(short *)"25",
	 *(short *)"26", *(short *)"27", *(short *)"28", *(short *)"29", *(short *)"30", *(short *)"31", *(short *)"32",
	 *(short *)"33", *(short *)"34", *(short *)"35", *(short *)"36", *(short *)"37", *(short *)"38", *(short *)"39",
	 *(short *)"40", *(short *)"41", *(short *)"42", *(short *)"43", *(short *)"44", *(short *)"45", *(short *)"46",
	 *(short *)"47", *(short *)"48", *(short *)"49", *(short *)"50", *(short *)"51", *(short *)"52", *(short *)"53",
	 *(short *)"54", *(short *)"55", *(short *)"56", *(short *)"57", *(short *)"58", *(short *)"59", *(short *)"60",
	 *(short *)"61", *(short *)"62", *(short *)"63", *(short *)"64", *(short *)"65", *(short *)"66", *(short *)"67",
	 *(short *)"68", *(short *)"69", *(short *)"70", *(short *)"71", 0 };
  int  ListIndex;
  int  Index;
  
  ComboBox.ResetContent();

  for (Index = 0; s_Functions[Index] != 0; Index++) {
    ListIndex = ComboBox.AddString(GetESMInfoFunction(s_Functions[Index]));
    if (ListIndex >=0 ) ComboBox.SetItemData(ListIndex, (DWORD) s_Functions[Index]);
   }

 }
/*===========================================================================
 *		End of Function FillEsmFunctionCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmGenderCombo (ComboBox, IncludeEmpty);
 *
 *=========================================================================*/
void FillEsmGenderCombo (CComboBox& ComboBox, const bool IncludeEmpty) {
  int ListIndex;

  ComboBox.ResetContent();

  if (IncludeEmpty) {
    ListIndex = ComboBox.AddString(GetESMInfoGender(MWESM_INFOGENDER_NONE));
    if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD)MWESM_INFOGENDER_NONE);
   }


  ListIndex = ComboBox.AddString(GetESMInfoGender(MWESM_INFOGENDER_MALE));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD)MWESM_INFOGENDER_MALE);

  ListIndex = ComboBox.AddString(GetESMInfoGender(MWESM_INFOGENDER_FEMALE));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD)MWESM_INFOGENDER_FEMALE);

 }
/*===========================================================================
 *		End of Function FillEsmGenderCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmSoundGenTypeCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmSoundGenTypeCombo (CComboBox& ComboBox) {
  int ListIndex;
  int Index;

  ComboBox.ResetContent();
  
  for (Index = MWESM_SNDGEN_MIN; Index <= MWESM_SNDGEN_MAX; Index++) {
    ListIndex = ComboBox.AddString(GetESMSoundGenType(Index));
    ComboBox.SetItemData(ListIndex, Index);
   }

 }
/*===========================================================================
 *		End of Function FillEsmSoundGenTypeCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmBloodTypeCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmBloodTypeCombo (CComboBox& ComboBox) {
  int ListIndex;

  ComboBox.ResetContent();

  ListIndex = ComboBox.AddString(_T("Default (Red)"));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_NPCFLAG_BLOODRED);
  ListIndex = ComboBox.AddString(_T("Skeleton (White)"));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_NPCFLAG_BLOODSKEL);
  ListIndex = ComboBox.AddString(_T("Metal (Gold)"));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_NPCFLAG_BLOODMETAL);

 }
/*===========================================================================
 *		End of Function FillEsmBloodTypeCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmSoundGenCreaCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmSoundGenCreaCombo (CComboBox& ComboBox) {
  CMWEditDoc*   pDocument = (CMWEditDoc *) GetActiveDocument();
  CEsmSoundGen* pSoundGen;
  esmrecinfo_t* pRecInfo;
  int		ArrayIndex;
  int		ListIndex;

  ComboBox.ResetContent();
  if (pDocument == NULL) return;

	/* Add the empty sound gen */
  ListIndex = ComboBox.AddString(_T(""));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, NULL);

  pRecInfo = pDocument->FindFirstRecord(MWESM_REC_SNDG, ArrayIndex);
  
  while (pRecInfo != NULL) {
    pSoundGen = (CEsmSoundGen *) pRecInfo->pRecord;

		/* Don't add multiple creature names */
    ListIndex = ComboBox.FindString(-1, pSoundGen->GetCreature());

    if (ListIndex < 0) {
      ListIndex = ComboBox.AddString(pSoundGen->GetCreature());
      if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, (DWORD) pRecInfo);
     }

    pRecInfo = pDocument->FindNextRecord(MWESM_REC_SNDG, ArrayIndex);
   }

 }
/*===========================================================================
 *		End of Function FillEsmSoundGenCreaCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmCreatureListCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmCreatureListCombo (CComboBox& ComboBox) {
  int ListIndex;
  int Index;

  ComboBox.ResetContent();

  for (Index = MWESM_CREATYPE_MIN; Index <= MWESM_CREATYPE_MAX; Index++) {
    ListIndex = ComboBox.AddString(GetESMCreatureType(Index));
    if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, Index);
   }

 }
/*===========================================================================
 *		End of Function FillEsmCreatureListCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmRankCombo (ComboBox, IncludeEmpty);
 *
 *=========================================================================*/
void FillEsmRankCombo (CComboBox& ComboBox, const bool IncludeEmpty) {
  int ResultIndex;

  ComboBox.ResetContent();
  
  if (IncludeEmpty) {
    ResultIndex = ComboBox.AddString(_T(""));
    if (ResultIndex >= 0) ComboBox.SetItemData(ResultIndex, -1);
   }

  ResultIndex = ComboBox.AddString(_T("Rank  0"));
  if (ResultIndex >= 0) ComboBox.SetItemData(ResultIndex, 0);
  ResultIndex = ComboBox.AddString(_T("Rank  1"));
  if (ResultIndex >= 0) ComboBox.SetItemData(ResultIndex, 1);
  ResultIndex = ComboBox.AddString(_T("Rank  2"));
  if (ResultIndex >= 0) ComboBox.SetItemData(ResultIndex, 2);
  ResultIndex = ComboBox.AddString(_T("Rank  3"));
  if (ResultIndex >= 0) ComboBox.SetItemData(ResultIndex, 3);
  ResultIndex = ComboBox.AddString(_T("Rank  4"));
  if (ResultIndex >= 0) ComboBox.SetItemData(ResultIndex, 4);
  ResultIndex = ComboBox.AddString(_T("Rank  5"));
  if (ResultIndex >= 0) ComboBox.SetItemData(ResultIndex, 5);
  ResultIndex = ComboBox.AddString(_T("Rank  6"));
  if (ResultIndex >= 0) ComboBox.SetItemData(ResultIndex, 6);
  ResultIndex = ComboBox.AddString(_T("Rank  7"));
  if (ResultIndex >= 0) ComboBox.SetItemData(ResultIndex, 7);
  ResultIndex = ComboBox.AddString(_T("Rank  8"));
  if (ResultIndex >= 0) ComboBox.SetItemData(ResultIndex, 8);
  ResultIndex = ComboBox.AddString(_T("Rank  9"));
  if (ResultIndex >= 0) ComboBox.SetItemData(ResultIndex, 9);
  ResultIndex = ComboBox.AddString(_T("Rank 10"));
  if (ResultIndex >= 0) ComboBox.SetItemData(ResultIndex, 10);

 }
/*===========================================================================
 *		End of Function FillEsmRankCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmInfoFuncTypeCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmInfoFuncTypeCombo (CComboBox& ComboBox) {
  int ListIndex;

  ComboBox.ResetContent();

  ListIndex = ComboBox.AddString(GetESMInfoFuncType(MWESM_SCVRFUNC_NONE));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVRFUNC_NONE);

  ListIndex = ComboBox.AddString(GetESMInfoFuncType(MWESM_SCVRFUNC_FUNCTION));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVRFUNC_FUNCTION);

  ListIndex = ComboBox.AddString(GetESMInfoFuncType(MWESM_SCVRFUNC_GLOBAL));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVRFUNC_GLOBAL);

  ListIndex = ComboBox.AddString(GetESMInfoFuncType(MWESM_SCVRFUNC_LOCAL));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVRFUNC_LOCAL);

  ListIndex = ComboBox.AddString(GetESMInfoFuncType(MWESM_SCVRFUNC_JOURNAL));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVRFUNC_JOURNAL);

  ListIndex = ComboBox.AddString(GetESMInfoFuncType(MWESM_SCVRFUNC_ITEM));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVRFUNC_ITEM);

  ListIndex = ComboBox.AddString(GetESMInfoFuncType(MWESM_SCVRFUNC_DEAD));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVRFUNC_DEAD);

  ListIndex = ComboBox.AddString(GetESMInfoFuncType(MWESM_SCVRFUNC_NOTID));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVRFUNC_NOTID);

  ListIndex = ComboBox.AddString(GetESMInfoFuncType(MWESM_SCVRFUNC_NOTFACTION));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVRFUNC_NOTFACTION);

  ListIndex = ComboBox.AddString(GetESMInfoFuncType(MWESM_SCVRFUNC_NOTCLASS));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVRFUNC_NOTCLASS);

  ListIndex = ComboBox.AddString(GetESMInfoFuncType(MWESM_SCVRFUNC_NOTRACE));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVRFUNC_NOTRACE);
 
  ListIndex = ComboBox.AddString(GetESMInfoFuncType(MWESM_SCVRFUNC_NOTCELL));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVRFUNC_NOTCELL);

  ListIndex = ComboBox.AddString(GetESMInfoFuncType(MWESM_SCVRFUNC_NOTLOCAL));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVRFUNC_NOTLOCAL);
 }
/*===========================================================================
 *		End of Function FillEsmInfoFuncTypeCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FillEsmInfoCompareOpCombo (ComboBox);
 *
 *=========================================================================*/
void FillEsmInfoCompareOpCombo (CComboBox& ComboBox) {
  int ListIndex;

  ComboBox.ResetContent();

  ListIndex = ComboBox.AddString(GetESMInfoCompareOp(MWESM_SCVROP_EQUALS));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVROP_EQUALS);

  ListIndex = ComboBox.AddString(GetESMInfoCompareOp(MWESM_SCVROP_NOEQUALS));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVROP_NOEQUALS);

  ListIndex = ComboBox.AddString(GetESMInfoCompareOp(MWESM_SCVROP_GREATER));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVROP_GREATER);

  ListIndex = ComboBox.AddString(GetESMInfoCompareOp(MWESM_SCVROP_GREATEREQUALS));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVROP_GREATEREQUALS);

  ListIndex = ComboBox.AddString(GetESMInfoCompareOp(MWESM_SCVROP_LESSER));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVROP_LESSER);

  ListIndex = ComboBox.AddString(GetESMInfoCompareOp(MWESM_SCVROP_LESSEREQUALS));
  if (ListIndex >= 0) ComboBox.SetItemData(ListIndex, MWESM_SCVROP_LESSEREQUALS);
   
 }
/*===========================================================================
 *		End of Function FillEsmInfoCompareOpCombo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void FindMWRegistryPath (void);
 *
 * Attempts to find the Morrowind Data Files path from the registry
 *
 *=========================================================================*/
void FindMWRegistryPath (void) {
  //l_MWDataPath = AfxGetApp()->GetProfileString(MWESM_REG_PATH, _T(""), NULL);
  BYTE  Buffer[_MAX_PATH+8];
  DWORD BufferSize = _MAX_PATH+7;
  DWORD Type;
  HKEY  hKey;
  long  Result;

  Result = RegOpenKeyEx(HKEY_LOCAL_MACHINE, MWESM_REG_PATH, 0, KEY_QUERY_VALUE, &hKey);
  if (Result != ERROR_SUCCESS) return; 

  Result = RegQueryValueEx(hKey, _T("Installed Path"), NULL, &Type, Buffer, &BufferSize);
  RegCloseKey(hKey);
  if (Result != ERROR_SUCCESS) return;

  l_MWDataPath = Buffer;
  TerminatePathString(l_MWDataPath);
  l_MWDataPath += _T("Data Files\\");
 }
/*===========================================================================
 *		End of Function FindMWRegistryPath()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const TCHAR* GetMWDataPath (void);
 *
 * Return the Morrowind Data File path.
 *
 *=========================================================================*/
const TCHAR* GetMWDataPath (void) {
  //return _T("e:\\Morrowind\\Data Files\\");
  return (l_MWDataPath);
 }

void SetMWDataPath (const TCHAR* pString) {
  l_MWDataPath = pString;
 }
/*===========================================================================
 *		End of Function TCHAR* GetMWDataPath()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool IsValidESMID (pID);
 *
 * Description
 *
 *=========================================================================*/
bool IsValidESMID (const TCHAR* pID) {

	/* Check for a NULL or empty ID */
  if (pID  == NULL) return (false);
  if (*pID == NULL_CHAR) return (false);

	/* First char should not be a space, but any a-z, 0-9, _ */
  if (!iscsym(*pID)) return (false);

	/* Check rest of string if needed */
  if (GetEsmOptStrictIDs()) {

    while (*pID != NULL_CHAR) {
      if (!iscsym(*pID) && !(*pID == ' ')) return (false);
      pID++;
     }
  }

  return (true);
 }
/*===========================================================================
 *		End of Function IsValidESMID()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SelectEsmIcon (IconString, pTitle, pParent);
 *
 *=========================================================================*/
bool SelectEsmIcon (CString& IconString, const TCHAR* pTitle, CWnd* pParent) {
  CString	IconPath = GetMWDataPath();
  CString	Buffer;
  int		Result;

	/* Get the current model path and filename */
  IconPath += MWPATH_ICONS;
  Buffer = IconPath + IconString;
  Result = Buffer.ReverseFind('\\');
  if (Result >= 0) Buffer.Delete(Result + 1, Buffer.GetLength()-Result-1);
  
	/* Initialize the file dialog */
  CFileDialog	OpenDlg(TRUE, MWESM_ICON_EXT, FindFilename(IconString), 
				OFN_HIDEREADONLY | OFN_PATHMUSTEXIST | OFN_NOCHANGEDIR,
				MWESM_ICON_FILTER, pParent);
  OpenDlg.m_ofn.lpstrInitialDir = Buffer;
  OpenDlg.m_ofn.lpstrTitle      = (char *) pTitle;
  
	/* Display the modal file dialog */
  Result = OpenDlg.DoModal();
  if (Result != IDOK) return (false);

	/* Get the pathname */
  IconString = OpenDlg.GetPathName();
  Result = TSTRNICMP(IconString, IconPath, IconPath.GetLength());
  if (Result == 0) IconString.Delete(0, IconPath.GetLength());

	/* Check the string length */
  if (IconString.GetLength() >= MWESM_ID_MAXSIZE) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("Icon filename exceeds the %d byte size limit!"), MWESM_ID_MAXSIZE);
    ErrorHandler.Notify(_T("File Error!"));
    return (true);
   }

  return (true);
 }
/*===========================================================================
 *		End of Function SelectEsmIcon()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SelectEsmModel (ModelString, pTitle, pParent);
 *
 *=========================================================================*/
bool SelectEsmModel (CString& ModelString, const TCHAR* pTitle, CWnd* pParent) {
  CString	ModelPath = GetMWDataPath();
  CString	Buffer;
  int		Result;

	/* Get the current model path and filename */
  ModelPath += MWPATH_MODELS;
  Buffer = ModelPath + ModelString;
  Result = Buffer.ReverseFind('\\');
  if (Result >= 0) Buffer.Delete(Result + 1, Buffer.GetLength()-Result-1);

	/* Initialize the file dialog */
  CFileDialog	OpenDlg(TRUE, MWESM_MODEL_EXT, FindFilename(ModelString), 
				OFN_HIDEREADONLY | OFN_PATHMUSTEXIST,
				MWESM_MODEL_FILTER, pParent);
  //SetCurrentDirectory(Buffer);
  OpenDlg.m_ofn.lpstrInitialDir = Buffer;
  OpenDlg.m_ofn.lpstrTitle      = pTitle;
  
	/* Display the modal file dialog */
  Result = OpenDlg.DoModal();
  SetCurrentDirectory(GetMWDataPath());
  if (Result != IDOK) return (false);

	/* Get the pathname */
  ModelString = OpenDlg.GetPathName();
  Result = TSTRNICMP(ModelString, ModelPath, ModelPath.GetLength());
  if (Result == 0) ModelString.Delete(0, ModelPath.GetLength());
  SystemLog.Printf ("Model Length = %d", ModelString.GetLength());

  	/* Check the string length */
  if (ModelString.GetLength() >= MWESM_ID_MAXSIZE) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("Model filename exceeds the %d byte size limit!"), MWESM_ID_MAXSIZE);
    ErrorHandler.Notify(_T("File Error!"));
    return (false);
   }

  return (true);
 }
/*===========================================================================
 *		End of Function SelectEsmModel()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SelectEsmSound (SoundString, pTitle, pParent);
 *
 *=========================================================================*/
bool SelectEsmSound (CString& SoundString, const TCHAR* pTitle, CWnd* pParent) {
  CString	SoundPath = GetMWDataPath();
  CString	Buffer;
  int		Result;

	/* Get the current model path and filename */
  SoundPath += MWPATH_SOUNDS;
  Buffer = SoundPath + SoundString;
  Result = Buffer.ReverseFind('\\');
  if (Result >= 0) Buffer.Delete(Result + 1, Buffer.GetLength()-Result-1);

	/* Initialize the file dialog */
  CFileDialog	OpenDlg(TRUE, MWESM_SOUND_EXT, FindFilename(SoundString), 
				OFN_HIDEREADONLY | OFN_PATHMUSTEXIST,
				MWESM_SOUND_FILTER, pParent);
  //SetCurrentDirectory(Buffer);
  OpenDlg.m_ofn.lpstrInitialDir = Buffer;
  OpenDlg.m_ofn.lpstrTitle      = pTitle;
  
	/* Display the modal file dialog */
  Result = OpenDlg.DoModal();
  SetCurrentDirectory(GetMWDataPath());
  if (Result != IDOK) return (false);

	/* Get the pathname */
  SoundString = OpenDlg.GetPathName();
  Result = TSTRNICMP(SoundString, SoundPath, SoundPath.GetLength());
  if (Result == 0) SoundString.Delete(0, SoundPath.GetLength());

  	/* Check the string length */
  if (SoundString.GetLength() >= MWESM_ID_MAXSIZE) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("Sound filename exceeds the %d byte size limit!"), MWESM_ID_MAXSIZE);
    ErrorHandler.Notify(_T("File Error!"));
    return (false);
   }

  return (true);
 }
/*===========================================================================
 *		End of Function SelectEsmSound()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SelectEsmTexture (TextureString, pTitle, pParent);
 *
 *=========================================================================*/
bool SelectEsmTexture (CString& TextureString, const TCHAR* pTitle, CWnd* pParent) {
  CString	TexturePath = GetMWDataPath();
  CString	Buffer;
  int		Result;

	/* Get the current model path and filename */
  TexturePath += MWPATH_TEXTURES;
  Buffer = TexturePath + TextureString;
  Result = Buffer.ReverseFind('\\');
  if (Result >= 0) Buffer.Delete(Result + 1, Buffer.GetLength()-Result-1);

	/* Initialize the file dialog */
  CFileDialog	OpenDlg(TRUE, MWESM_TEXTURE_EXT, FindFilename(TextureString), 
				OFN_HIDEREADONLY | OFN_PATHMUSTEXIST,
				MWESM_TEXTURE_FILTER, pParent);
  OpenDlg.m_ofn.lpstrInitialDir = Buffer;
  OpenDlg.m_ofn.lpstrTitle      = pTitle;
  
	/* Display the modal file dialog */
  Result = OpenDlg.DoModal();
  if (Result != IDOK) return (false);

	/* Get the pathname */
  TextureString = OpenDlg.GetPathName();
  Result = TSTRNICMP(TextureString, TexturePath, TexturePath.GetLength());
  if (Result == 0) TextureString.Delete(0, TexturePath.GetLength());

	/* Check the string length */
  if (TextureString.GetLength() >= MWESM_ID_MAXSIZE) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("Texture filename exceeds the %d byte size limit!"), MWESM_ID_MAXSIZE);
    ErrorHandler.Notify(_T("File Error!"));
    return (false);
   }

  return (true);
 }
/*===========================================================================
 *		End of Function SelectEsmTexture()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool ReadFile (Bffer, pFilename);
 *
 * Attempt to input an entire file into a string buffer.  Returns false on
 * any error.
 *
 *=========================================================================*/
bool ReadFile (CSString& Buffer, const TCHAR* pFilename) {
  FILE* pFileHandle;
  long  FileSize;
  int   Result;

	/* Attempt to open the file for input */
  pFileHandle = OpenFile(pFilename, "rb");
  if (pFileHandle == NULL) return (false);

	/* Get filesize */
  FileSize = GetFileSize(pFileHandle);

	/* Input file */
  Buffer.SetSize(FileSize);
  Result = fread((TCHAR *)(const TCHAR *)Buffer, 1, FileSize, pFileHandle);
  fclose (pFileHandle);

	/* Check for errors */
  if (Result != FileSize) {
    ErrorHandler.AddError(ERR_READFILE, _T("Error reading from file '%s'!"), pFilename);
    return (false);
   }
  
  return (true);
 }
/*===========================================================================
 *		End of Function ReadFile()
 *=========================================================================*/
