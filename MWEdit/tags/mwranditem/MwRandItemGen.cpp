/*===========================================================================
 *
 * File:	Mwranditemgen.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	May 23, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "mwranditemgen.h"
#include "MwRandCom.h"
#include <math.h>
#include "Genfind.h"
#include "dl_time.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("MwRandItemGen.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Compare Function
 *
 *=========================================================================*/
int _cdecl l_RecordCmpFunc (const void* pElem1, const void* pElem2, const long lUserData) {
  CEsmRecord* pRec1 = (CEsmRecord *) pElem1;
  CEsmRecord* pRec2 = (CEsmRecord *) pElem2;

  if (pRec1 == NULL || pRec2 == NULL) return (1);
  return pRec1->GetUserData() - pRec2->GetUserData();
 }


int _cdecl l_ValueCmpFunc (const void* pElem1, const void* pElem2, const long lUserData) {
  CEsmRecord* pRec1 = (CEsmRecord *) pElem1;
  CEsmRecord* pRec2 = (CEsmRecord *) pElem2;

  if (pRec1 == NULL || pRec2 == NULL) return (1);
  if (*(long *) pRec1->GetType() != *(long *) pRec2->GetType()) return (*(long *) pRec1->GetType() - *(long *) pRec2->GetType());
  if (((CEsmItem2 *) pRec1)->GetValue() != ((CEsmItem2 *) pRec2)->GetValue()) return (int) (((CEsmItem2 *) pRec1)->GetValue() - ((CEsmItem2 *) pRec2)->GetValue());
  return TSTRICMP(((CEsmItem2 *) pRec2)->GetName(), ((CEsmItem2 *) pRec1)->GetName());
 }
/*===========================================================================
 *		End of Compare Function
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Constructor
 *
 *=========================================================================*/
CMwRandItemGen::CMwRandItemGen () : m_NewRecords(0), m_ValidItems(0), 
				    m_ValidPrefixes(0), m_ValidSuffixes(0), 
				    m_ValidUniques(0), m_ListRecords(0),
				    m_LevelLists(0), m_PHLists(0), m_AllRecords(0) {
  DefaultMWRandItemGenOptions(m_Options);
  m_EsmFile.CreateNew();
  m_RandUniques.SetEffects(&m_RandEffects);
  m_NumNewItems     = 0;
  m_NumEnchantments = 0;
  m_ScriptSize1     = 0;
  m_ScriptSize2     = 0;
  m_NumScripts	    = 0;
  m_NumPHLists	    = 0;
  m_NumLevelLists   = 0;
  m_HasEnchantment  = false;
  m_pLevelItems     = NULL;

  m_ListRecords.SetCompareFunc(l_RecordCmpFunc);
  m_AllRecords.SetCompareFunc(l_ValueCmpFunc);

  GetDirString(m_InitialPath, _MAX_PATH);
 }
/*===========================================================================
 *		End of Class CMwRandItemGen Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void Destroy (void);
 *
 *=========================================================================*/
void CMwRandItemGen::Destroy (void) {
  //DEFINE_FUNCTION("CMwRandItemGen::Destroy()");
  m_RandUniques.Destroy();
  m_RandEffects.Destroy();
  m_RandItems.Destroy();

  m_EsmFile.Destroy();
  m_EsmFile.CreateNew();

  m_ScriptSize1     = 0;
  m_ScriptSize2     = 0;
  m_NumNewItems     = 0;
  m_NumEnchantments = 0;
  m_HasEnchantment  = false;
  m_pLevelItems     = NULL;

  DestroyNewRecords();
  m_LevelLists.RemoveAll();
  m_AllRecords.RemoveAll();
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void AddEnchantEffect (ppEnchant, EnchantEffect);
 *
 * Adds a single effect to the given enchantment or spell record.
 *
 *=========================================================================*/
void CMwRandItemGen::AddEnchantEffect (CEsmRecord* pEnchant, mwrand_encheff_t& EnchantEffect) {
  CEsmSubRecord* pSubRec;
  CEsmSubENAM*   pEnameSubRec;
  int		 EffectCount;
  int		 ArrayIndex;
  int		 TempValue;

	/* Count the number of current effects */
  pSubRec = pEnchant->FindFirst(MWESM_SUBREC_ENAM, ArrayIndex);
  EffectCount = 0;

  while (pSubRec != NULL) {
    EffectCount++;
    pSubRec = pEnchant->FindNext(MWESM_SUBREC_ENAM, ArrayIndex);
   }

	/* Ignore if we've reached the maximum number of effects */
  if (EffectCount >= MWESM_ENCHANT_NUMENCHANTS) return;

	/* Allocate and initialize the effect */
  pEnameSubRec = (CEsmSubENAM *) pEnchant->AllocateSubRecord(MWESM_SUBREC_ENAM);
  pEnameSubRec->CreateNew();

	/* Set the effect properties */
  pEnameSubRec->GetEnchantData()->Area        = (long)SplitValue((float)EnchantEffect.Area1, (float)EnchantEffect.Area2, m_Options.CurrentRatio);
  pEnameSubRec->GetEnchantData()->Duration    = (long)SplitValue((float)EnchantEffect.Duration1, (float)EnchantEffect.Duration2, m_Options.CurrentRatio);;
  pEnameSubRec->GetEnchantData()->MagMin      = (long)SplitValue((float)EnchantEffect.MagMin1, (float)EnchantEffect.MagMin2, m_Options.CurrentRatio);;
  pEnameSubRec->GetEnchantData()->MagMax      = (long)SplitValue((float)EnchantEffect.MagMax1, (float)EnchantEffect.MagMax2, m_Options.CurrentRatio);;
  pEnameSubRec->GetEnchantData()->RangeType   = EnchantEffect.RangeType;
  pEnameSubRec->GetEnchantData()->EffectID    = EnchantEffect.EffectID;
  pEnameSubRec->GetEnchantData()->AttributeID = EnchantEffect.AttributeID;
  pEnameSubRec->GetEnchantData()->SkillID     = EnchantEffect.SkillID;

	/* Clear the duration for constant effect types */
  if (pEnchant->IsType(MWESM_REC_ENCH)) {
    if (((CEsmEnchant *)pEnchant)->GetEnchantData()->Type == MWESM_ENCHTYPE_CONSTANT) {
      pEnameSubRec->GetEnchantData()->Duration = 0;
     }
   }

	/* Ensure valid magnitudes */
  if (pEnameSubRec->GetEnchantData()->MagMin > pEnameSubRec->GetEnchantData()->MagMax) {
    TempValue = pEnameSubRec->GetEnchantData()->MagMin;
    pEnameSubRec->GetEnchantData()->MagMin = pEnameSubRec->GetEnchantData()->MagMax;
    pEnameSubRec->GetEnchantData()->MagMax = TempValue;
   }

 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::AddEnchantEffect()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void AddLevelListItem (CEsmRecord* pRecord);
 *
 * Adds a new item record to be added to the level lists depending on the
 * current options.
 *
 *=========================================================================*/
void CMwRandItemGen::AddLevelListItem (CEsmRecord* pRecord) {
  DEFINE_FUNCTION("CMwRandItemGen::AddLevelListItem()");

	/* Ignore if not creating any level lists */
  if (!m_Options.CreateLevelLists) return;

	/* Do we need to make another level list? */
  if (m_ListRecords.GetNumElements() >= MWRID_MAXITEMS_LEVELLIST) {
    AddSortLevelItems();
    AllocateLevelList();
   }

	/* Add the item to the list sorted by item level */
  m_ListRecords.AddSort(pRecord);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::AddLevelListItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void AddSortLevelItems (void);
 *
 * Adds all the items to the leveled list sorted by item level.
 *
 *=========================================================================*/
void CMwRandItemGen::AddSortLevelItems (void) {
  CEsmRecord*	pRecord;
  int		Index;

	/* Ensure a valid level list */
  if (m_pLevelItems == NULL) return;

  for (Index = 0; Index < m_ListRecords.GetNumElements(); Index++) {
    pRecord = m_ListRecords.GetAt(Index);
    m_pLevelItems->AddItem(pRecord->GetID(), pRecord->GetUserData());
   }

  m_ListRecords.RemoveAll();
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::AddSortLevelItems()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool AddScriptData1 (pData, Size);
 *
 * Adds data to the compiled script buffer. Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItemGen::AddScriptData1 (const char* pData, const int Size) {

	/* Ensure we don't exceed the maximum script size */
  if (m_ScriptSize1 + Size >= MWRIG_SCRIPTDATA_SIZE) {
    ErrorHandler.AddError(ERR_MAXINDEX, _T("Exceeded the compiled script #1 size of %d!"), MWRIG_SCRIPTDATA_SIZE);
    return (false);
   }

  memcpy(m_ScriptData1 + m_ScriptSize1, pData, Size);
  m_ScriptSize1 += Size;

  return (true);
 }


bool CMwRandItemGen::AddScriptData2 (const char* pData, const int Size) {

	/* Ensure we don't exceed the maximum script size */
  if (m_ScriptSize2 + Size >= MWRIG_SCRIPTDATA_SIZE) {
    ErrorHandler.AddError(ERR_MAXINDEX, _T("Exceeded the compiled script #2 size of %d!"), MWRIG_SCRIPTDATA_SIZE);
    return (false);
   }

  memcpy(m_ScriptData2 + m_ScriptSize2, pData, Size);
  m_ScriptSize2 += Size;

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::AddScriptData1()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void AllocateLevelList (void);
 *
 * Protected class method. Allocates the required level list item.
 *
 *=========================================================================*/
void CMwRandItemGen::AllocateLevelList (void) {
  
	/* Allocate the leveled item list */
  m_pLevelItems = (CEsmLevelItem *) m_EsmFile.AllocateRecord(MWESM_REC_LEVI);
  m_pLevelItems->CreateNew(&m_EsmFile);
  m_NewRecords.Add(m_pLevelItems);
  m_LevelLists.Add(m_pLevelItems);
  m_NumLevelLists++;

	/* Initialize the leveled list */
  m_pLevelItems->SetAllPC(true);
  m_pLevelItems->SetCalcEach(true);
  m_pLevelItems->SetChanceNone((int)m_Options.ChanceNone);
  m_pLevelItems->SetID(MakeLevelListID());
 } 
/*===========================================================================
 *		End of Class Method CMwRandItemGen::AllocateLevelList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - CEsmRecord* AllocateNewRecord (void);
 *
 * Allocates a new record according to the current settings. Adds the
 * new record to the array and returns it.
 *
 *=========================================================================*/
CEsmRecord* CMwRandItemGen::AllocateNewRecord (void) {
  DEFINE_FUNCTION("CMwRandItemGen::AllocateNewRecord()");
  CEsmRecord* pNewRecord;

	/* Create the object according to the base item type */
  switch (m_Options.pCurrentItem->ItemType) {
    case MWRI_ITEMMASK_WEAPON:
        pNewRecord = m_EsmFile.AllocateRecord(MWESM_REC_WEAP);
	break;
    case MWRI_ITEMMASK_CLOTHING:
        pNewRecord = m_EsmFile.AllocateRecord(MWESM_REC_CLOT);
	break;
    case MWRI_ITEMMASK_ARMOR:
        pNewRecord = m_EsmFile.AllocateRecord(MWESM_REC_ARMO);
	break;
    case MWRI_ITEMMASK_MISC:
        pNewRecord = m_EsmFile.AllocateRecord(MWESM_REC_MISC);
	break;
    }
  
	/* Initialize record and add it to the array */
  pNewRecord->CreateNew(&m_EsmFile);
  return (pNewRecord);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::AllocateNewRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool CheckDuplicates (pRecord);
 *
 * Checks and removes item duplicates if required. Returns true if the item
 * is not a duplicate.
 *
 *=========================================================================*/
bool CMwRandItemGen::CheckDuplicates (CEsmRecord* pRecord) {
  DEFINE_FUNCTION("CMwRandItemGen::CheckDuplicates()");
  int Index;

	/* Ignore if we don't have to remove duplicates */
  if (!m_Options.RemoveDuplicates) return (true);

	/* Ignore if the record isn't a duplicate item */
  //if (!IsDuplicate(pRecord)) return (true);
  Index = m_AllRecords.FindFast(pRecord);
  if (Index < 0) return (true);

	/* Delete the duplicated record if found */
  m_EsmFile.DeleteRecord(pRecord);
  //m_AllRecords.DeleteElement(pRecord);
  DestroyPointer(pRecord);
  
  return (false);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CheckDuplicates()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool CheckItemLevel (Level);
 *
 * Returns true if the input item/effect level matches the currently set item
 * level.
 *
 *=========================================================================*/
bool CMwRandItemGen::CheckItemLevel (const int Level) {

	/* Include more lower level items */
  if (m_Options.CurrentItemLevel < 15 && Level <= m_Options.CurrentItemLevel) return (true);

  return (Level >= m_Options.CurrentItemLevel/4 && Level <= m_Options.CurrentItemLevel);
 }


bool CMwRandItemGen::CheckEffectLevel (const int Level) {
  return (Level >= m_Options.CurrentItemLevel/2 && Level <= m_Options.CurrentItemLevel);
 }


bool CMwRandItemGen::CheckCursedLevel (const int Level) {
  return (Level <= m_Options.CurrentItemLevel);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CheckItemLevel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CheckWeaponDamage (pWeapon);
 *
 * Checks and corrects the weapon damage for the given record.
 *
 *=========================================================================*/
void CMwRandItemGen::CheckWeaponDamage (CEsmWeapon* pWeapon) {
  weapondata_t* pWeaponData = pWeapon->GetWeaponData();
  
  	/* Check for 0 damages */
  if (pWeaponData->ChopMin   <= 0) pWeaponData->ChopMin = 1;
  if (pWeaponData->ChopMax   <= 0) pWeaponData->ChopMax = 1;
  if (pWeaponData->SlashMin  <= 0) pWeaponData->SlashMin = 1;
  if (pWeaponData->SlashMax  <= 0) pWeaponData->SlashMax = 1;
  if (pWeaponData->ThrustMin <= 0) pWeaponData->ThrustMin = 1;
  if (pWeaponData->ThrustMax <= 0) pWeaponData->ThrustMax = 1;

	/* Check for valid min/maxs */
  if (pWeaponData->ChopMin   > pWeaponData->ChopMax)   pWeaponData->ChopMax   = pWeaponData->ChopMin;
  if (pWeaponData->SlashMin  > pWeaponData->SlashMax)  pWeaponData->SlashMax  = pWeaponData->SlashMin;
  if (pWeaponData->ThrustMin > pWeaponData->ThrustMax) pWeaponData->ThrustMax = pWeaponData->ThrustMin;
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CheckWeaponDamage()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CheckValidSuffixes (void);
 *
 * Checks the current list of suffixes and removes any that do not match
 * the currently selected prefix.
 *
 *=========================================================================*/
void CMwRandItemGen::CheckValidSuffixes (void) {
  mwrand_effect_t* pEffect;
  int		   Index;

	/* Ignore if no current prefix */
  if (m_Options.pCurrentPrefix == NULL) return;

	/* Ignore if the prefix type isn't an enchantment */
  if (m_Options.pCurrentPrefix->EffectType != MWRE_EFFECT_ENCHANT) return;

	/* Check each suffix */
  for (Index = 0; Index < m_ValidSuffixes.GetNumElements(); Index++) {
    pEffect = m_ValidSuffixes.GetAt(Index);
    if (pEffect == NULL) return;
    if (pEffect->EffectType != MWRE_EFFECT_ENCHANT) continue;
    if (pEffect->Enchantment.EnchantType == m_Options.pCurrentPrefix->Enchantment.EnchantType) continue;

		/* Remove the suffix from the list */
    m_ValidSuffixes.RemoveAt(Index);
    Index--;
   }

 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CheckValidSuffixes()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void ClearValidItems (void);
 *
 *=========================================================================*/
void CMwRandItemGen::ClearValidItems (void) {
  m_ValidItems.RemoveAll();
  m_ValidPrefixes.RemoveAll();
  m_ValidSuffixes.RemoveAll();
  m_ValidUniques.RemoveAll();
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::ClearValidItems()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool CloseScriptFile (void);
 *
 * Protected class method that attempts to close the script file.
 *
 *=========================================================================*/
bool CMwRandItemGen::CloseScriptFile (void) {
  bool Result;

  Result  = m_ScriptFile.Printf("\tStopScript, \"script_name\"\n");
  Result &= m_ScriptFile.Printf("end\n");
  m_ScriptFile.Close();
  return (Result);
 }


bool CMwRandItemGen::CloseScriptRecord (void) {
  byte CharData;
  char TempData[2];

  m_ScriptBuffer1 += _T("\tStopScript, \"");
  m_ScriptBuffer1 += m_pScript1->GetID();
  m_ScriptBuffer1 += _T("\"\n");
  m_ScriptBuffer1 += _T("end\n");

  TempData[0] = 0x1C;
  TempData[1] = 0x10;
  AddScriptData1(TempData, 2);
  CharData = strlen(m_pScript1->GetID());
  AddScriptData1((char *)&CharData, 1);
  AddScriptData1(m_pScript1->GetID(), (int) CharData);
  AddScriptData1("\01\01", 2);

  m_ScriptBuffer2 += _T("\tStopScript, \"");
  m_ScriptBuffer2 += m_pScript2->GetID();
  m_ScriptBuffer2 += _T("\"\n");
  m_ScriptBuffer2 += _T("end\n");
  
  AddScriptData2(TempData, 2);
  CharData = strlen(m_pScript2->GetID());
  AddScriptData2((char *)&CharData, 1);
  AddScriptData2(m_pScript2->GetID(), (int) CharData);
  AddScriptData2("\01\01", 2);
  
  m_pScript1->SetScriptText(m_ScriptBuffer1);
  m_pScript2->SetScriptText(m_ScriptBuffer2);
  m_pScript1->GetScriptData()->CopyData((char *)m_ScriptData1, m_ScriptSize1);
  m_pScript2->GetScriptData()->CopyData((char *)m_ScriptData2, m_ScriptSize2);
  m_pScript1->GetScriptHeader()->GetScriptHeadData()->ScriptDataSize = m_ScriptSize1;
  m_pScript2->GetScriptHeader()->GetScriptHeadData()->ScriptDataSize = m_ScriptSize2;

  m_ScriptSize1 = 0;
  m_ScriptSize2 = 0;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::OpenNewScriptFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void ComputeCurrentEffects (void);
 *
 * Computes any current effects for the current item using the current list
 * of valid suffics, prefixes, and uniques.
 *
 *=========================================================================*/
void CMwRandItemGen::ComputeCurrentEffects (void) {
  bool  HasPrefix = false;
  bool  HasSuffix = false;
  bool  IsUnique = false;
  float Chance;

	/* Get prefix chance */
  Chance = (rand() / (float)RAND_MAX)*1.0f;
  if (Chance <= m_Options.PrefixChance) HasPrefix = true;

  	/* Get suffix chance */
  Chance = (rand() / (float)RAND_MAX)*1.0f;
  if (Chance <= m_Options.SuffixChance) HasSuffix = true;

	/* Get unique chance */
  if (HasSuffix && HasPrefix) {
    Chance = (rand() / (float)RAND_MAX)*1.0f;
    if (Chance <= m_Options.UniqueChance) IsUnique = true;
   }

	/* Clear current effect objects */
  m_Options.pCurrentPrefix = NULL;
  m_Options.pCurrentSuffix = NULL;
  m_Options.pCurrentUnique = NULL;
  
	/* Ignore if the item isn't allowed to have any effects */
  if (m_Options.pCurrentItem->EffectMask == MWRI_EFFMASK_NONE) return;

	/* Select appropriate unique object */
  if (IsUnique) {
    Chance = (rand()/(float)RAND_MAX) * m_ValidUniques.GetNumElements();
    m_Options.pCurrentUnique = m_ValidUniques.GetAt((int)Chance);
    HasPrefix = false;
    HasSuffix = false;
   }

	/* Select random prefix object */
  if (HasPrefix) {
    Chance = (rand()/(float)RAND_MAX) * m_ValidPrefixes.GetNumElements();
    m_Options.pCurrentPrefix = m_ValidPrefixes.GetAt((int)Chance);
   }

	/* Select random suffix object */
  if (HasSuffix) {
    if (HasPrefix) CheckValidSuffixes();

    if (m_ValidSuffixes.GetNumElements() == 0) {
      m_Options.pCurrentSuffix = NULL;
      HasSuffix = false;
     }
    else {
      Chance = (rand()/(float)RAND_MAX) * m_ValidSuffixes.GetNumElements();
      m_Options.pCurrentSuffix = m_ValidSuffixes.GetAt((int)Chance);
     }
   }
 
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::ComputeCurrentEffects()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void ComputeItemLevel (pItem);
 *
 * Estimates and returns an item level for the given item record (1-100).
 *
 *=========================================================================*/
int CMwRandItemGen::ComputeItemLevel (CEsmItem2* pItem) { 
  int ItemLevel;
  ItemLevel = (int) (sqrt((float) pItem->GetValue()) / 5);

  if (ItemLevel <= 0)   ItemLevel = 1;
  if (ItemLevel >= 100) ItemLevel = 100;
  return (ItemLevel);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::ComputeItemLevel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void ComputeItemLevel (void);
 *
 * Uses the current settings and computes a new item level value, storing
 * the result in the options structure. Protected class method.
 *
 *=========================================================================*/
void CMwRandItemGen::ComputeItemLevel (void) {

  if (m_Options.UseBell)
    m_Options.CurrentItemLevel = (int)MakeRandItemNumber((float)m_Options.MinLevel, (float)m_Options.MaxLevel, m_Options.RandomBell / 100.0f * (m_Options.MaxLevel - m_Options.MinLevel) + m_Options.MinLevel);
  else
    m_Options.CurrentItemLevel = (int)MakeRandItemNumber((float)m_Options.MinLevel, (float)m_Options.MaxLevel);

 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::ComputeItemLevel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void ComputeQualityLevel (void);
 *
 *=========================================================================*/
void CMwRandItemGen::ComputeQualityLevel (void) {
  m_Options.CurrentRatio = MakeRandItemNumber(0.0f, 1.0f);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::ComputeQualityLevel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool CreateItems (void);
 *
 * Creates all items according to the current settings.
 *
 *=========================================================================*/
bool CMwRandItemGen::CreateItems (void) {
  int    Index;

	/* Reset the number of items/objects created */
  m_NumNewItems     = 0;
  m_NumEnchantments = 0;
  m_NumScripts	    = 0;
  m_NumLevelLists   = 0;
  m_NumPHLists      = 0;
  
	/* Perform list/script initialization */
  if (m_Options.CreateLevelLists) AllocateLevelList();
  if (m_Options.OutputScript) OpenNewScriptFile();
  if (m_Options.OutputScriptRecord && m_Options.CreateLevelLists) OpenNewScriptRecord();

	/* Make all the random items */
  for (Index = 0; Index < m_Options.NumItems; Index++) {
    MakeRandomItem();
   }

	/* Create the various level lists as required */
  if (m_Options.CreateLevelLists) {
    if (m_ListRecords.GetNumElements() > 0) AddSortLevelItems();
    if (m_Options.MakePHLists) CreatePHLists();
   }

	/* Create/add the various scripts as required */  
  if (m_Options.OutputScript) CloseScriptFile();

  if (m_Options.OutputScriptRecord && m_Options.CreateLevelLists) {
    if (m_Options.MakePHLists) {
      OutputPHListScripts();
     }
    else {
      OutputLListScripts();
     }

    CloseScriptRecord();
   }

	/* Clear various arrays */
  m_ListRecords.RemoveAll();
  m_LevelLists.RemoveAll();
  m_PHLists.RemoveAll();
  m_pLevelItems = NULL;

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CreateItems()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CreateDamage (pRecord, pEffect);
 *
 * Adjusts the overall weapon's damage by a given percentage.
 *
 *=========================================================================*/
void CMwRandItemGen::CreateDamage (CEsmRecord* pRecord, mwrand_effect_t* pEffect) {
  CEsmWeapon*   pWeapon;
  weapondata_t* pWeaponData;
  float	        Factor;

	/* Ignore if the record isn't a weapon */
  if (!pRecord->IsType(MWESM_REC_WEAP)) return;
  pWeapon = (CEsmWeapon *) pRecord;
  pWeaponData = pWeapon->GetWeaponData();
  Factor = SplitValue(pEffect->MinEffect, pEffect->MaxEffect, m_Options.CurrentRatio);
  
	/* Modify weapon damages */
  pWeaponData->ChopMin   = ((int)(pWeaponData->ChopMin   * (Factor + 1.0f)))&0xFF;
  pWeaponData->ChopMax   = ((int)(pWeaponData->ChopMax   * (Factor + 1.0f)))&0xFF;
  pWeaponData->SlashMin  = ((int)(pWeaponData->SlashMin  * (Factor + 1.0f)))&0xFF;
  pWeaponData->SlashMax  = ((int)(pWeaponData->SlashMax  * (Factor + 1.0f)))&0xFF;
  pWeaponData->ThrustMin = ((int)(pWeaponData->ThrustMin * (Factor + 1.0f)))&0xFF;
  pWeaponData->ThrustMax = ((int)(pWeaponData->ThrustMax * (Factor + 1.0f)))&0xFF;
  
	/* Check weapon damages */
  CheckWeaponDamage(pWeapon);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CreateDamage()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CreateEnchantPts (pRecord, pEffect);
 *
 * Creates a enchant point % modification effect on the given record.
 *
 *=========================================================================*/
void CMwRandItemGen::CreateEnchantPts (CEsmRecord* pRecord, mwrand_effect_t* pEffect) {
  long  EnchantPts;
  float	Factor;

	/* Ignore if the record doesn't have a weight */
  if ((pRecord->GetClassType() & MWESM_CLASSTYPE_ITEM3) == 0) return;
  EnchantPts = ((CEsmItem3 *) pRecord)->GetEnchantPts();
  
	/* Compute the new weight */
  Factor = SplitValue(pEffect->MinEffect, pEffect->MaxEffect, m_Options.CurrentRatio);
  EnchantPts = (long) (EnchantPts * (Factor + 1.0f));
  if (EnchantPts <= 0) EnchantPts = 1;

  ((CEsmItem3 *) pRecord)->SetEnchantPts(EnchantPts);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CreateEnchantPts()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CreatePHLists (void);
 *
 * Create and initialize the place-holder lists.
 *
 *=========================================================================*/
void CMwRandItemGen::CreatePHLists (void) {
  CEsmLevelItem* pLevelList;
  int 		 Index;
  int		 ListIndex;

  for (Index = 0; Index < m_RandLLists.GetMaxNumber() + MWRID_EXTRA_PHLISTS; Index++) {

		/* Allocate the leveled item list */
    pLevelList = (CEsmLevelItem *) m_EsmFile.AllocateRecord(MWESM_REC_LEVI);
    pLevelList->CreateNew(&m_EsmFile);
    m_NewRecords.Add(pLevelList);
    m_PHLists.Add(pLevelList);
    m_NumPHLists++;

		/* Initialize the leveled list */
    pLevelList->SetAllPC(true);
    pLevelList->SetCalcEach(true);
    pLevelList->SetChanceNone((int)0);
    pLevelList->SetID(MakePHListID());

		/* Add all the base level lists to the place-holder list */
    for (ListIndex = 0; ListIndex < m_LevelLists.GetNumElements(); ListIndex++) {
      pLevelList->AddItem(((CEsmLevelItem *)m_LevelLists.GetAt(ListIndex))->GetID(), 1);
     }
   }

 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CreatePHLists()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CreateWeight (pRecord, pEffect);
 *
 * Creates a weight % modification effect on the given record.
 *
 *=========================================================================*/
void CMwRandItemGen::CreateWeight (CEsmRecord* pRecord, mwrand_effect_t* pEffect) {
  float Weight;
  float	Factor;

	/* Ignore if the record doesn't have a weight */
  if ((pRecord->GetClassType() & MWESM_CLASSTYPE_ITEM2) == 0) return;
  Weight = ((CEsmItem2 *) pRecord)->GetWeight();
  
	/* Compute the new weight */
  Factor = SplitValue(pEffect->MinEffect, pEffect->MaxEffect, m_Options.CurrentRatio);
  Weight *= (Factor + 1.0f);
  if (Weight <= 0) Weight = 0.1f;

  ((CEsmItem2 *) pRecord)->SetWeight(Weight);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CreateWeight()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CreateReach (pRecord, pEffect);
 *
 * Creates a reach % modification effect on the given record.
 *
 *=========================================================================*/
void CMwRandItemGen::CreateReach (CEsmRecord* pRecord, mwrand_effect_t* pEffect) {
  CEsmWeapon*   pWeapon;
  float	        Factor;

	/* Ignore if the record isn't a weapon */
  if (!pRecord->IsType(MWESM_REC_WEAP)) return;
  pWeapon = (CEsmWeapon *) pRecord;
  Factor = SplitValue(pEffect->MinEffect, pEffect->MaxEffect, m_Options.CurrentRatio);

  pWeapon->GetWeaponData()->Reach *= (Factor + 1.0f);
  if (pWeapon->GetWeaponData()->Reach <= 0) pWeapon->GetWeaponData()->Reach = 0.1f;
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CreateReach()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CreateSpeed (pRecord, pEffect);
 *
 * Creates a spee % modification effect on the given record.
 *
 *=========================================================================*/
void CMwRandItemGen::CreateSpeed (CEsmRecord* pRecord, mwrand_effect_t* pEffect) {
  CEsmWeapon*   pWeapon;
  float	        Factor;

	/* Ignore if the record isn't a weapon */
  if (!pRecord->IsType(MWESM_REC_WEAP)) return;
  pWeapon = (CEsmWeapon *) pRecord;
  Factor = SplitValue(pEffect->MinEffect, pEffect->MaxEffect, m_Options.CurrentRatio);

  pWeapon->GetWeaponData()->Speed *= (Factor + 1.0f);
  if (pWeapon->GetWeaponData()->Speed <= 0) pWeapon->GetWeaponData()->Speed = 0.1f;
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CreateSpeed()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CreateCondition (pRecord, pEffect);
 *
 * Creates a condition % modification effect on the given record.
 *
 *=========================================================================*/
void CMwRandItemGen::CreateCondition (CEsmRecord* pRecord, mwrand_effect_t* pEffect) {
  long  Condition;
  float	Factor;

	/* Get the current record condition */
  if (pRecord->IsType(MWESM_REC_ARMO))
    Condition = ((CEsmArmor *) pRecord)->GetArmorData()->Health;
  else if (pRecord->IsType(MWESM_REC_WEAP))
    Condition = ((CEsmWeapon *) pRecord)->GetWeaponData()->Health;
  else
    return;
  
	/* Compute the new condition */
  Factor = SplitValue(pEffect->MinEffect, pEffect->MaxEffect, m_Options.CurrentRatio);
  Condition = (long) (Condition * (Factor + 1.0f));
  if (Condition <= 0)     Condition = 1;
  if (Condition >= 32768) Condition = 32768;

	/* Set the item condition */
  if (pRecord->IsType(MWESM_REC_ARMO))
    ((CEsmArmor *) pRecord)->GetArmorData()->Health = Condition;
  else if (pRecord->IsType(MWESM_REC_WEAP))
    ((CEsmWeapon *) pRecord)->GetWeaponData()->Health = Condition & 0xFFFF;

 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CreateCondition()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CreateMaxDamage (pRecord, pEffect);
 *
 * Adjusts the overall weapon's maximum damage by a given percentage.
 *
 *=========================================================================*/
void CMwRandItemGen::CreateMaxDamage (CEsmRecord* pRecord, mwrand_effect_t* pEffect) {
  CEsmWeapon*   pWeapon;
  weapondata_t* pWeaponData;
  float	        Factor;

	/* Ignore if the record isn't a weapon */
  if (!pRecord->IsType(MWESM_REC_WEAP)) return;
  pWeapon = (CEsmWeapon *) pRecord;
  pWeaponData = pWeapon->GetWeaponData();
  Factor = SplitValue(pEffect->MinEffect, pEffect->MaxEffect, m_Options.CurrentRatio);
  
	/* Modify weapon damages */
  pWeaponData->ChopMax   = ((int)(pWeaponData->ChopMax   * (Factor + 1.0f)))&0xFF;
  pWeaponData->SlashMax  = ((int)(pWeaponData->SlashMax  * (Factor + 1.0f)))&0xFF;
  pWeaponData->ThrustMax = ((int)(pWeaponData->ThrustMax * (Factor + 1.0f)))&0xFF;
  
	/* Check weapon damages */
  CheckWeaponDamage(pWeapon);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CreateMaxDamage()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CreateMinDamage (pRecord, pEffect);
 *
 * Adjusts the overall weapon's minimum damage by a given percentage.
 *
 *=========================================================================*/
void CMwRandItemGen::CreateMinDamage (CEsmRecord* pRecord, mwrand_effect_t* pEffect) {
  CEsmWeapon*   pWeapon;
  weapondata_t* pWeaponData;
  float	        Factor;

	/* Ignore if the record isn't a weapon */
  if (!pRecord->IsType(MWESM_REC_WEAP)) return;
  pWeapon = (CEsmWeapon *) pRecord;
  pWeaponData = pWeapon->GetWeaponData();
  Factor = SplitValue(pEffect->MinEffect, pEffect->MaxEffect, m_Options.CurrentRatio);
  
	/* Modify weapon damages */
  pWeaponData->ChopMin   = ((int)(pWeaponData->ChopMin   * (Factor + 1.0f)))&0xFF;
  pWeaponData->SlashMin  = ((int)(pWeaponData->SlashMin  * (Factor + 1.0f)))&0xFF;
  pWeaponData->ThrustMin = ((int)(pWeaponData->ThrustMin * (Factor + 1.0f)))&0xFF;
  
	/* Check weapon damages */
  CheckWeaponDamage(pWeapon);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CreateMinDamage()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CreateArmor (pRecord, pEffect);
 *
 * Adjusts the armor's AC value by a given percentage.
 *
 *=========================================================================*/
void CMwRandItemGen::CreateArmor (CEsmRecord* pRecord, mwrand_effect_t* pEffect) {
  CEsmArmor*   pArmor;
  armordata_t* pArmorData;
  float	       Factor;

	/* Ignore if the record isn't a armor */
  if (!pRecord->IsType(MWESM_REC_ARMO)) return;
  pArmor = (CEsmArmor *) pRecord;
  pArmorData = pArmor->GetArmorData();
  Factor = SplitValue(pEffect->MinEffect, pEffect->MaxEffect, m_Options.CurrentRatio);
  
	/* Modify armor class */
  pArmorData->Rating = ((int)(pArmorData->Rating * (Factor + 1.0f)))&0xFF;

  //if (pArmorData->Rating <= 0) pArmorData->Rating = 1;
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CreateArmor()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CreateEffect (pRecord, pEffect, ppEnchant, ppSpell);
 *
 * Creates and adds the given effect to the record. Creates the enchantment
 * object only if required.
 *
 *=========================================================================*/
void CMwRandItemGen::CreateEffect (CEsmRecord* pRecord, mwrand_effect_t* pEffect,
				   CEsmEnchant** ppEnchant, CEsmSpell** ppSpell) {

	/* Add the effect to the object */
  switch (pEffect->EffectType) {
    case MWRE_EFFECT_NONE:
	break;
    case MWRE_EFFECT_SPELL:
        CreateSpell(pRecord, pEffect, ppSpell);
	break;
    case MWRE_EFFECT_ENCHANT:
        CreateEnchantment(pRecord, pEffect, ppEnchant);
	break;
    case MWRE_EFFECT_WEIGHT:
        CreateWeight(pRecord, pEffect);
	break;
    case MWRE_EFFECT_DAMAGE:
        CreateDamage(pRecord, pEffect);
	break;
    case MWRE_EFFECT_MAXDAMAGE:
        CreateMaxDamage(pRecord, pEffect);
	break;
    case MWRE_EFFECT_MINDAMAGE:
	CreateMinDamage(pRecord, pEffect);
	break;
    case MWRE_EFFECT_REACH:
	CreateReach(pRecord, pEffect);
	break;
    case MWRE_EFFECT_SPEED:
	CreateSpeed(pRecord, pEffect);
	break;
    case MWRE_EFFECT_CONDITION:
	CreateCondition(pRecord, pEffect);
	break;
    case MWRE_EFFECT_ENCHANTPTS:
	CreateEnchantPts(pRecord, pEffect);
	break;
    case MWRE_EFFECT_ARMOR:
    	CreateArmor(pRecord, pEffect);
	break;
   }

 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CreateEffect()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CreateSpell (pRecord, pEffect, ppSpell);
 *
 * Creates and adds the given spell effect to the record. Creates the
 * spell object only if required.
 *
 *=========================================================================*/
void CMwRandItemGen::CreateSpell (CEsmRecord* pRecord, mwrand_effect_t* pEffect, CEsmSpell** ppSpell) {
  int Index;

	/* Allocate and initialize the spell record if required */
  if (*ppSpell == NULL) MakeSpell(pRecord, ppSpell);
  (*ppSpell)->SetUserData(m_Options.CurrentItemLevel);

	/* Set the basic spell settings */
  (*ppSpell)->GetSpellData()->Type = MWESM_SPELLTYPE_SPELL;
  (*ppSpell)->SetAutoCalc(pEffect->Enchantment.AutoCalc);
  
	/* Add individual effects */
  for (Index = 0; Index < pEffect->Enchantment.NumEffects; Index++) {
    AddEnchantEffect(*ppSpell, pEffect->Enchantment.Effects[Index]);
   }

 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CreateSpell()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CreateEnchantment (pRecord, pEffect, ppEnchant);
 *
 * Creates and adds the given enchantment effect to the record. Creates the
 * enchantment object only if required.
 *
 *=========================================================================*/
void CMwRandItemGen::CreateEnchantment (CEsmRecord* pRecord, mwrand_effect_t* pEffect,
				        CEsmEnchant** ppEnchant) {
  int  Index;
  long Charge;
  long Cost;

	/* Allocate and initialize the enchantment record if required */
  if (*ppEnchant == NULL) MakeEnchantment(pRecord, ppEnchant);
  (*ppEnchant)->SetUserData(m_Options.CurrentItemLevel);

	/* Set the basic enchantment settings */
  Charge = (long)SplitValue((float)pEffect->Enchantment.Charge1, (float)pEffect->Enchantment.Charge2, m_Options.CurrentRatio);
  Cost   = (long)SplitValue((float)pEffect->Enchantment.EnchantCost1, (float)pEffect->Enchantment.EnchantCost2, m_Options.CurrentRatio);
  (*ppEnchant)->GetEnchantData()->Charge      += Charge*Cost;
  (*ppEnchant)->GetEnchantData()->EnchantCost += Cost;
  (*ppEnchant)->GetEnchantData()->Type         = pEffect->Enchantment.EnchantType;
  (*ppEnchant)->GetEnchantData()->AutoCalc     = pEffect->Enchantment.AutoCalc;

	/* Add individual effects */
  for (Index = 0; Index < pEffect->Enchantment.NumEffects; Index++) {
    AddEnchantEffect(*ppEnchant, pEffect->Enchantment.Effects[Index]);
   }

 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CreateEffect()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void CreateItem (void);
 *
 * Creates the actual item record according to the current settings.
 *
 *=========================================================================*/
void CMwRandItemGen::CreateItem (void) {
  CEsmRecord* pNewRecord;

  m_HasEnchantment = false;

	/* Create the new record and add it to the array */
  pNewRecord = AllocateNewRecord();

	/* Set the new record parameters */
  SetRecordItemParams(pNewRecord);
  SetRecordEffects(pNewRecord);

	/* Check for item duplication if required */
  if (CheckDuplicates(pNewRecord)) {
    m_NewRecords.Add(pNewRecord);
    if (m_Options.RemoveDuplicates) m_AllRecords.AddSort(pNewRecord);

    if (m_HasEnchantment) m_NumEnchantments++;
    m_NumNewItems++;
    
    if (m_Options.pCurrentPrefix != NULL || m_Options.pCurrentSuffix || m_Options.pCurrentUnique) {
      pNewRecord->SetUserData(m_Options.CurrentItemLevel);
     }
    else { 
      pNewRecord->SetUserData(m_Options.pCurrentItem->ItemLevel);
     }

		/* Add the item to the level lists */
    AddLevelListItem(pNewRecord);
   }

 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::CreateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void DestroyNewRecords (void);
 *
 * Delete all records currently in the new records array.
 *
 *=========================================================================*/
void CMwRandItemGen::DestroyNewRecords (void) {
  m_NewRecords.RemoveAll();
  m_ListRecords.RemoveAll();
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::DestroyNewRecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool ExportItemData (pEsmFile, pOutputFile);
 *
 * Attempt to export unenchanted items from the given ESM/ESP file to a
 * base item DAT text file. Uses the current settings to determine which
 * items to export.  Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItemGen::ExportItemData (const TCHAR* pEsmFile, const TCHAR* pOutputFile) {
  CEsmFile    InputFile;
  CGenFile    OutputFile;
  CEsmRecord* pRecord;
  bool        Result;
  int	      Index;

	/* Attempt to input the given ESM/ESP file */
  Result = InputFile.Read(pEsmFile);
  if (!Result) return (false);

	/* Attempt to open the output file */
  Result = OutputFile.Open(pOutputFile, "wt");
  if (!Result) return (false);
  m_ExportCount = 0;

	/* Output all records as required */
  for (Index = 0; Index < InputFile.GetNumRecords(); Index++) {
    pRecord = InputFile.GetRecord(Index);

		/* Output record by object type */
    if (pRecord->IsType(MWESM_REC_ARMO) && (m_Options.ItemMask & MWRI_ITEMMASK_WEAPON) != 0) {
      Result = ExportArmor(OutputFile, (CEsmArmor *)pRecord);
      if (!Result) return (false);
     }
    else if (pRecord->IsType(MWESM_REC_WEAP) && (m_Options.ItemMask & MWRI_ITEMMASK_ARMOR) != 0) {
      Result = ExportWeapon(OutputFile, (CEsmWeapon *)pRecord);
      if (!Result) return (false);
     }
    else if (pRecord->IsType(MWESM_REC_CLOT) && (m_Options.ItemMask & MWRI_ITEMMASK_CLOTHING) != 0) {
      Result = ExportClothing(OutputFile, (CEsmClothing *)pRecord);
      if (!Result) return (false);
     }
    else if (pRecord->IsType(MWESM_REC_MISC) && (m_Options.ItemMask & MWRI_ITEMMASK_MISC) != 0) {
      Result = ExportMisc(OutputFile, (CEsmMisc *)pRecord);
      if (!Result) return (false);
     }
   }

  SystemLog.Printf("ExportCount = %ld", m_ExportCount);
  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::ExportItemData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool ExportArmor (OutputFile, pArmor);
 *
 * Output armor data record to a text base item file. Returns false on any
 * error. Protected class method.
 *
 *=========================================================================*/
bool CMwRandItemGen::ExportArmor (CGenFile& OutputFile, CEsmArmor* pArmor) {

	/* Determine if we wish to export the record */
  if (pArmor->GetEnchant() != NULL && pArmor->GetEnchant()[0] != NULL_CHAR) return (true);

  OutputFile.Printf(_T("Item\n"));
  OutputFile.Printf(_T("\tItemType = Armor\n"));
  OutputFile.Printf(_T("\tName = \"%s\"\n"), pArmor->GetName());
  OutputFile.Printf(_T("\tIcon = \"%s\"\n"), pArmor->GetIcon());
  OutputFile.Printf(_T("\tModel = \"%s\"\n"), pArmor->GetModel());
  OutputFile.Printf(_T("\tBasePrice = %ld\n"), pArmor->GetValue());
  OutputFile.Printf(_T("\tItemLevel = %d\n"), ComputeItemLevel(pArmor));
  OutputFile.Printf(_T("\tWeight = %g\n"), pArmor->GetWeight());
  OutputFile.Printf(_T("\tEnchantPts = %d\n"), pArmor->GetEnchantPts());
  OutputFile.Printf(_T("\tArmor = %d\n"), pArmor->GetArmorData()->Rating);
  OutputFile.Printf(_T("\tType = \"%s\"\n"), pArmor->GetArmorType());
  OutputFile.Printf(_T("\tCondition = %d\n"), pArmor->GetArmorData()->Health);

  ExportBodyParts(OutputFile, pArmor);

  OutputFile.Printf(_T("End\n"));
  m_ExportCount++;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::ExportItemData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool ExportBodyParts (OutputFile, pRecord);
 *
 * Export any body parts in the given record to the item output file.
 *
 *=========================================================================*/
bool CMwRandItemGen::ExportBodyParts (CGenFile& OutputFile, CEsmRecord* pRecord) {
  CEsmSubByte*		pIndex;
  CEsmSubRecord*	pBName;
  CEsmSubRecord*	pCName;
  int			BodyIndex;
  int			ArrayIndex;

	/* Find all body part sub-records */
  pIndex = (CEsmSubByte *) pRecord->FindFirst(MWESM_SUBREC_INDX, ArrayIndex);

  while (pIndex != NULL) {
    BodyIndex = (int) pIndex->GetValue();
    pBName = pRecord->GetSubRecord(ArrayIndex+1);
    pCName = pRecord->GetSubRecord(ArrayIndex+2);

		/* Output the first, optional, body part string */
    if (pBName != NULL) {
      if (pBName->IsType(MWESM_SUBREC_BNAM)) {
        OutputFile.Printf(_T("\tM%s = \"%s\"\n"), GetMWRandItemBodyPart(BodyIndex), ((CEsmSubNameFix *)pBName)->GetName());
       }
     else if (pBName->IsType(MWESM_SUBREC_CNAM)) {
        OutputFile.Printf(_T("\tF%s = \"%s\"\n"), GetMWRandItemBodyPart(BodyIndex), ((CEsmSubNameFix *)pBName)->GetName());
       }
     }

		/* Output the second, optional, body part string */
    if (pCName != NULL) {
      if (pCName->IsType(MWESM_SUBREC_BNAM)) {
        OutputFile.Printf(_T("\tM%s = \"%s\"\n"), GetMWRandItemBodyPart(BodyIndex), ((CEsmSubNameFix *)pCName)->GetName());
       }
     else if (pCName->IsType(MWESM_SUBREC_CNAM)) {
        OutputFile.Printf(_T("\tF%s = \"%s\"\n"), GetMWRandItemBodyPart(BodyIndex), ((CEsmSubNameFix *)pCName)->GetName());
       }
     }

    pIndex = (CEsmSubByte *) pRecord->FindNext(MWESM_SUBREC_INDX, ArrayIndex); 
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::ExportBodyParts()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool ExportClothing (OutputFile, pClothing);
 *
 * Output clothing data record to a text base item file. Returns false on any
 * error. Protected class method.
 *
 *=========================================================================*/
bool CMwRandItemGen::ExportClothing (CGenFile& OutputFile, CEsmClothing* pClothing) {

	/* Determine if we wish to export the record */
  if (pClothing->GetEnchant() != NULL && pClothing->GetEnchant()[0] != NULL_CHAR) return (true);

  OutputFile.Printf(_T("Item\n"));
  OutputFile.Printf(_T("\tItemType = Clothing\n"));
  OutputFile.Printf(_T("\tName = \"%s\"\n"), pClothing->GetName());
  OutputFile.Printf(_T("\tIcon = \"%s\"\n"), pClothing->GetIcon());
  OutputFile.Printf(_T("\tModel = \"%s\"\n"), pClothing->GetModel());
  OutputFile.Printf(_T("\tBasePrice = %ld\n"), pClothing->GetValue());
  OutputFile.Printf(_T("\tItemLevel = %d\n"), ComputeItemLevel(pClothing));
  OutputFile.Printf(_T("\tWeight = %g\n"), pClothing->GetWeight());
  OutputFile.Printf(_T("\tEnchantPts = %d\n"), pClothing->GetEnchantPts());
  OutputFile.Printf(_T("\tType = \"%s\"\n"), pClothing->GetClothType());

  ExportBodyParts(OutputFile, pClothing);

  OutputFile.Printf(_T("End\n"));
  m_ExportCount++;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::ExportItemData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool ExportMisc (OutputFile, pMisc);
 *
 * Output misc data record to a text base item file. Returns false on any
 * error. Protected class method.
 *
 *=========================================================================*/
bool CMwRandItemGen::ExportMisc (CGenFile& OutputFile, CEsmMisc* pMisc) {
  OutputFile.Printf(_T("Item\n"));
  OutputFile.Printf(_T("\tItemType = Misc\n"));
  OutputFile.Printf(_T("\tName = \"%s\"\n"), pMisc->GetName());
  OutputFile.Printf(_T("\tIcon = \"%s\"\n"), pMisc->GetIcon());
  OutputFile.Printf(_T("\tModel = \"%s\"\n"), pMisc->GetModel());
  OutputFile.Printf(_T("\tBasePrice = %ld\n"), pMisc->GetValue());
  OutputFile.Printf(_T("\tItemLevel = %d\n"), ComputeItemLevel(pMisc));
  OutputFile.Printf(_T("\tWeight = %g\n"), pMisc->GetWeight());

  OutputFile.Printf(_T("End\n"));
  m_ExportCount++;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::ExportMisc()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool ExportWeapon (OutputFile, pWeapon);
 *
 * Output clothing data record to a text base item file. Returns false on any
 * error. Protected class method.
 *
 *=========================================================================*/
bool CMwRandItemGen::ExportWeapon (CGenFile& OutputFile, CEsmWeapon* pWeapon) {

	/* Determine if we wish to export the record */
  if (pWeapon->GetEnchant() != NULL && pWeapon->GetEnchant()[0] != NULL_CHAR) return (true);
    
  OutputFile.Printf(_T("Item\n"));
  OutputFile.Printf(_T("\tItemType = Weapon\n"));
  OutputFile.Printf(_T("\tName = \"%s\"\n"), pWeapon->GetName());
  OutputFile.Printf(_T("\tIcon = \"%s\"\n"), pWeapon->GetIcon());
  OutputFile.Printf(_T("\tModel = \"%s\"\n"), pWeapon->GetModel());
  OutputFile.Printf(_T("\tBasePrice = %ld\n"), pWeapon->GetValue());
  OutputFile.Printf(_T("\tItemLevel = %d\n"), ComputeItemLevel(pWeapon));
  OutputFile.Printf(_T("\tWeight = %g\n"), pWeapon->GetWeight());
  OutputFile.Printf(_T("\tEnchantPts = %d\n"), pWeapon->GetEnchantPts());
  OutputFile.Printf(_T("\tType = \"%s\"\n"), pWeapon->GetWeaponType());
  OutputFile.Printf(_T("\tReach = %g\n"), pWeapon->GetWeaponData()->Reach);
  OutputFile.Printf(_T("\tSpeed = %g\n"), pWeapon->GetWeaponData()->Speed);
  OutputFile.Printf(_T("\tCondition = %d\n"), (int)pWeapon->GetWeaponData()->Health);
  OutputFile.Printf(_T("\tMinChop = %d\n"), (int)pWeapon->GetWeaponData()->ChopMin);
  OutputFile.Printf(_T("\tMaxChop = %d\n"), (int)pWeapon->GetWeaponData()->ChopMax);
  OutputFile.Printf(_T("\tMinSlash = %d\n"), (int)pWeapon->GetWeaponData()->SlashMin);
  OutputFile.Printf(_T("\tMaxSlash = %d\n"), (int)pWeapon->GetWeaponData()->SlashMax);
  OutputFile.Printf(_T("\tMinThrust = %d\n"), (int)pWeapon->GetWeaponData()->ThrustMin);
  OutputFile.Printf(_T("\tMaxThrust = %d\n"), (int)pWeapon->GetWeaponData()->ThrustMax);
  OutputFile.Printf(_T("\tIgnoreResist = %s\n"), BooleanToString(pWeapon->IsIgnoreResist()));
  OutputFile.Printf(_T("End\n"));
  m_ExportCount++;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::ExportWeapon()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool IsDuplicate (pRecord);
 *
 * Returns true if the input item already exists in the file. Checks the
 * item name, type and value.
 *
 *=========================================================================*/
bool CMwRandItemGen::IsDuplicate (CEsmRecord* pRecord) {
  CEsmRecord*	pRecord1;
  CEsmItem2*    pItem2;
  int		Index;

  if ((pRecord->GetClassType() & MWESM_CLASSTYPE_ITEM2) == 0) return (false);
  pItem2 = (CEsmItem2 *) pRecord;

  for (Index = 0; Index < m_EsmFile.GetNumRecords(); Index++) {
    pRecord1 = m_EsmFile.GetRecord(Index);
    if (pRecord1 == pRecord) continue;
    if (!pRecord1->IsType(pRecord->GetType())) continue;
    if ((pRecord1->GetClassType() & MWESM_CLASSTYPE_ITEM2) == 0) continue;
    if (pItem2->GetValue() != ((CEsmItem2 *)pRecord1)->GetValue()) continue;
    if (TSTRICMP(pItem2->GetName(), ((CEsmItem2 *)pRecord1)->GetName()) == 0) return (true);
   }

  return (false);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::IsDuplicate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool IsValidEffect (pEffect, pItem);
 *
 * Returns true if the given effect/item combination is valid. Does not
 * check the effect or item level.
 *
 *=========================================================================*/
bool CMwRandItemGen::IsValidEffect (mwrand_effect_t* pEffect, mwri_item_t* pItem) {

	/* Ignore ranged weapons with constant effect enchantments */
  if (pItem->ItemType == MWRI_ITEMMASK_WEAPON && 
	pEffect->Enchantment.EnchantType == MWESM_ENCHTYPE_CONSTANT && 
	IsESMWeaponRange(pItem->Weapon.Type)) return (false);

	/* Check the effect/enchantment type */
  if ((pItem->EffectMask & pEffect->EffectMask) == 0) return (false);

  if (pEffect->EffectType == MWRE_EFFECT_ENCHANT &&
	(pEffect->Enchantment.EnchantMask & pItem->EnchantMask) == 0) return (false);

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::IsValidEffect()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool LoadDataFiles (void);
 *
 * Attempt to load the data files. Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItemGen::LoadDataFiles (void) {
  bool Result;

  m_RandItems.Destroy();
  m_RandEffects.Destroy();
  m_RandUniques.Destroy();
  m_RandLLists.Destroy();

  Result  = m_RandItems.ReadItemFile(m_Options.BaseItems);
  Result &= m_RandEffects.ReadEffectFile(m_Options.Effects);
  Result &= m_RandUniques.ReadUniqueFile(m_Options.Uniques);
  Result &= m_RandLLists.Read(m_Options.LevelLists);

  return (Result);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::LoadDataFiles()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool LoadGroupFile (pFilename);
 *
 * Attempt to load the given group data file
 *
 *=========================================================================*/
bool CMwRandItemGen::LoadGroupFile (const TCHAR* pFilename) {
  bool Result;
  int  Index;

	/* Attempt to load the group file */
  Result = m_GroupData.Load(pFilename);
  if (!Result) return (false);

  	/* Clear the current data */
  m_EsmFile.Destroy();
  m_EsmFile.CreateNew();
  ClearAllRecords();

  ChangeDirectory(m_InitialPath);

	/* Copy the new options */
  *(mwri_group_t *) &m_Options = *m_GroupData.GetGroup();

	/* Reload the data files */
  ErrorHandler.ClearErrors();
  Result = LoadDataFiles();
  
	/* Merge all the required ESP files */
  for (Index = 0; Index < m_GroupData.GetNumEspFiles(); Index++) {
    Result &= MergeEsp(m_GroupData.GetEspFile(Index), false);
   }
  
  return (Result);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::LoadGroupFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - MakeSpell (pRecord, ppSpell);
 *
 * Creates an spell object, adding it to the given record.
 *
 *=========================================================================*/
void CMwRandItemGen::MakeSpell (CEsmRecord* pRecord, CEsmSpell** ppSpell) {
  DEFINE_FUNCTION("CMwRandItemGen::MakeSpell()");

	/* Allocate the new spell object */
  *ppSpell = (CEsmSpell *) m_EsmFile.AllocateRecord(MWESM_REC_SPEL);
  (*ppSpell)->CreateNew(&m_EsmFile);
  m_NewRecords.Add(*ppSpell);

	/* Initialize the spell */
  (*ppSpell)->SetID(MakeItemID());
  (*ppSpell)->GetSpellData()->SpellCost = 0;
  (*ppSpell)->GetSpellData()->Type = MWESM_SPELLTYPE_SPELL;
  (*ppSpell)->SetAutoCalc(true);

  m_HasEnchantment = true;
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::MakeSpell()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - MakeEnchantment (pRecord, ppEnchant);
 *
 * Creates an enchantment object, adding it to the given record.
 *
 *=========================================================================*/
void CMwRandItemGen::MakeEnchantment (CEsmRecord* pRecord, CEsmEnchant** ppEnchant) {
  DEFINE_FUNCTION("CMwRandItemGen::MakeEnchantment()");

	/* Allocate the new enchant object */
  *ppEnchant = (CEsmEnchant *) m_EsmFile.AllocateRecord(MWESM_REC_ENCH);
  (*ppEnchant)->CreateNew(&m_EsmFile);
  m_NewRecords.Add(*ppEnchant);

	/* Initialize the enchantment */
  (*ppEnchant)->SetID(MakeItemID());
  (*ppEnchant)->GetEnchantData()->AutoCalc    = false;
  (*ppEnchant)->GetEnchantData()->Charge      = 0;
  (*ppEnchant)->GetEnchantData()->EnchantCost = 0;
  (*ppEnchant)->GetEnchantData()->Type        = MWESM_ENCHTYPE_CASTONCE;

	/* Assign the enchantment to the record */
  ((CEsmItem3 *)pRecord)->SetEnchant((*ppEnchant)->GetID());
  m_HasEnchantment = true;
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::MakeEnchantment()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TCHAR* CMwRandItemGen Method - const MakeItemID (void);
 *
 *=========================================================================*/
const TCHAR* CMwRandItemGen::MakeItemID (void) {
  switch (m_Options.IDType) {
    case MWRID_IDTYPE_SHORT8: return MakeNumberItemId8(m_Options.IDPrefix);
    case MWRID_IDTYPE_SHORT4: return MakeNumberItemId4(m_Options.IDPrefix);
    default:
    case MWRID_IDTYPE_LONG:   return MakeRandomItemId(m_Options.IDPrefix);
   }
 }

const TCHAR* CMwRandItemGen::MakeLevelListID (void) {
  static TCHAR s_Buffer[MWESM_ID_MAXSIZE+4];

	/* Make the ID string */
  if (!m_Options.UseListID)
    return (MakeItemID());
  else if (m_Options.ListID[0] != NULL_CHAR)
    snprintf (s_Buffer, 31, _T("%.28s%04lX"), m_Options.ListID, m_NumLevelLists);
  else
    snprintf (s_Buffer, 31, _T("llist_%04lX"), m_NumLevelLists);

  return (s_Buffer);
 }


const TCHAR* CMwRandItemGen::MakePHListID (void) { 
  static TCHAR s_Buffer[MWESM_ID_MAXSIZE+4];

  if (m_Options.PHListID[0] != NULL_CHAR)
    snprintf (s_Buffer, 31, _T("%.28s%04lX"), m_Options.PHListID, m_NumPHLists);
  else
    snprintf (s_Buffer, 31, _T("phlist_%04lX"), m_Options.PHListID, m_NumPHLists);

  return (s_Buffer);
 }
/*===========================================================================
 *		End of Class Method TCHAR* CMwRandItemGen::MakeItemID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TCHAR* CMwRandItemGen Method - const MakeItemName (void);
 *
 *=========================================================================*/
const TCHAR* CMwRandItemGen::MakeItemName (void) {
  static TCHAR s_Name[256] = "";

	/* Attempt to make the name using the item material if available */
  if (m_Options.pCurrentItem->Material[0] != NULL_CHAR) {
    if (m_Options.pCurrentPrefix != NULL && m_Options.pCurrentSuffix != NULL) {
      snprintf (s_Name, 255, _T("%s %s %s of %s"), m_Options.pCurrentPrefix->Name, 
		m_Options.pCurrentItem->Material, m_Options.pCurrentItem->Name, m_Options.pCurrentSuffix->Name);
     }
    else if (m_Options.pCurrentPrefix != NULL) {
      snprintf (s_Name, 255, _T("%s %s %s"),  m_Options.pCurrentPrefix->Name, 
		m_Options.pCurrentItem->Material, m_Options.pCurrentItem->Name);
     } 
    else if (m_Options.pCurrentSuffix != NULL) {
      snprintf (s_Name, 255, _T("%s %s of %s"), m_Options.pCurrentItem->Material, m_Options.pCurrentItem->Name,
	m_Options.pCurrentSuffix->Name);
     }
    else if (m_Options.pCurrentUnique != NULL) {
      if (m_Options.pCurrentUnique->NameType == MWRU_NAMETYPE_SUFFIX) 
        snprintf (s_Name, 255, _T("%s of %s"),  m_Options.pCurrentItem->Name, m_Options.pCurrentUnique->Name);
      else if (m_Options.pCurrentUnique->NameType == MWRU_NAMETYPE_PREFIX)
        snprintf (s_Name, 255, _T("%s %s"), m_Options.pCurrentUnique->Name, m_Options.pCurrentItem->Name);
      else
        snprintf (s_Name, 255, _T("%s"), m_Options.pCurrentUnique->Name);
     }
    else {
      snprintf (s_Name, 255, _T("%s %s"), m_Options.pCurrentItem->Material, m_Options.pCurrentItem->Name);
     }
   }

	/* Remake item name without the material as required */
  if (m_Options.pCurrentItem->Material[0] == NULL_CHAR || TSTRLEN(s_Name) >= MWRI_MAX_NAMESIZE) {
    if (m_Options.pCurrentPrefix != NULL && m_Options.pCurrentSuffix != NULL) {
      snprintf (s_Name, 255, _T("%s %s of %s"), m_Options.pCurrentPrefix->Name, 
		m_Options.pCurrentItem->Name, m_Options.pCurrentSuffix->Name);
     }
    else if (m_Options.pCurrentPrefix != NULL) {
      snprintf (s_Name, 255, _T("%s %s"),  m_Options.pCurrentPrefix->Name, 
		m_Options.pCurrentItem->Name);
     } 
    else if (m_Options.pCurrentSuffix != NULL) {
      snprintf (s_Name, 255, _T("%s of %s"), m_Options.pCurrentItem->Name,
	m_Options.pCurrentSuffix->Name);
     }
    else if (m_Options.pCurrentUnique != NULL) {
      if (m_Options.pCurrentUnique->NameType == MWRU_NAMETYPE_SUFFIX) 
        snprintf (s_Name, 255, _T("%s of %s"),  m_Options.pCurrentItem->Name, m_Options.pCurrentUnique->Name);
      else if (m_Options.pCurrentUnique->NameType == MWRU_NAMETYPE_PREFIX)
        snprintf (s_Name, 255, _T("%s %s"), m_Options.pCurrentUnique->Name, m_Options.pCurrentItem->Name);
      else
        snprintf (s_Name, 255, _T("%s"), m_Options.pCurrentUnique->Name);
     }
    else {
      snprintf (s_Name, 255, _T("%s"), m_Options.pCurrentItem->Name);
     }
   }

 	/* Remake item name without the suffix if required */
  if (TSTRLEN(s_Name) >= MWRI_MAX_NAMESIZE) {
    if (m_Options.pCurrentPrefix != NULL) {
      snprintf (s_Name, 255, _T("%s %s"), m_Options.pCurrentPrefix->Name, m_Options.pCurrentItem->Name);
     }
    else if (m_Options.pCurrentUnique != NULL) {
      snprintf (s_Name, 255, _T("%s"), m_Options.pCurrentUnique->Name);
     }
    else {
      snprintf (s_Name, 255, _T("%s"), m_Options.pCurrentItem->Name);
     }
   }

	/* Ensure it is properly terminated */
  s_Name[MWRI_MAX_NAMESIZE] = NULL_CHAR;
  return (s_Name);
 }
/*===========================================================================
 *		End of Class Method TCHAR* CMwRandItemGen::MakeItemName()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool MakeRandomItem (void);
 *
 * Attempts to make a new random item using the current settings. The new
 * record is stored in the new records array. Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItemGen::MakeRandomItem (void) {

	/* Compute the desired item level */
  ComputeItemLevel();

	/* Select all valid items based on current setting */
  SelectValidItems();

	/* Choose a base item to use */
  SelectBaseItem();

	/* Ensure the current item is valid */
  if (m_Options.pCurrentItem == NULL) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("No valid base item to use!"));
    return (false);
   }

	/* Select all effects based on current item */
  SelectValidPrefixes();
  SelectValidSuffixes();
  SelectValidUniques();

	/* Choose the magical effects for the current item */
  ComputeCurrentEffects();

	/* Check to ensure item/effect pair is valid for a no effect item */
  if ((m_Options.pCurrentItem->EffectMask & MWRI_EFFMASK_NONE) == 0 && 
		m_Options.pCurrentPrefix == NULL && 
		m_Options.pCurrentSuffix == NULL && 
		m_Options.pCurrentUnique == NULL) {
    return (false);	
   }

	/* Create the item object and save it to the array */
  CreateItem();

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::MakeRandomItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool MergeEsp (pFilename, Add);
 *
 * Attempt to merge the given ESP file with the current records. Returns 
 * false on any error.
 *
 *=========================================================================*/
bool CMwRandItemGen::MergeEsp (const TCHAR* pFilename, const bool Add) {
  DEFINE_FUNCTION("CMwRandItemGen::MergeEsp()");
  CEsmFile    NewFile;
  CEsmRecord* pRecord;
  bool        Result;
  int         Index;

	/* Attempt to input the given ESP file */
  Result = NewFile.Read(pFilename);
  if (!Result) return(false);

	/* Save the esp file to the current group if required */
  if (Add) m_GroupData.AddEspFile(pFilename);

	/* Copy all the records from the new ESP to the current ESP */
  for (Index = 0; Index < NewFile.GetNumRecords(); Index++) {
    pRecord = NewFile.GetRecord(Index);

		/* Determine whether to move or copy the record */
    if (pRecord->IsType(MWESM_REC_TES3)) {
      DestroyPointer(pRecord);
     }
    else {	
      m_EsmFile.GetRecords()->Add(pRecord);
     }
   }

	/* Clear all the records since we've moved/deleted them already */
  NewFile.GetRecords()->RemoveAll();
  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::MergeEsp()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool OpenNewScriptFile (void);
 *
 * Protected class method that attempts to open a new file for script 
 * output. Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItemGen::OpenNewScriptFile (void) {
  CFindFile FindFile;
  char      FileBuffer[16];
  bool      FindResult;
  bool      Result;
  int       LastIndex = 0;
  int       FileIndex;

	/* Find existing script files */
  FindResult = FindFile.FindFirst(MWRIG_SCRIPTFILE_WILDCARD);

  while (FindResult) {
    FindResult = FindFile.FindNext();
    strnncpy(FileBuffer, FindFile.GetName()+6, 4);
    FileIndex = atoi(FileBuffer);
    if (FileIndex > LastIndex) LastIndex = FileIndex;
   }

	/* Create the filename */
  sprintf (m_Options.ScriptFile, MWRIG_SCRIPTFILE_FORMAT, LastIndex+1);

	/* Attempt to open the file for output */
  Result = m_ScriptFile.Open(m_Options.ScriptFile, "wt");
  if (Result) Result = m_ScriptFile.Printf("begin randitem_scr_%04d\n", LastIndex+1);
  return (Result);
 }


bool CMwRandItemGen::OpenNewScriptRecord (void) {
    
	/* Create the install script */
  m_pScript1 = (CEsmScript *) m_EsmFile.AllocateRecord(MWESM_REC_SCPT);
  m_pScript1->CreateNew(&m_EsmFile);
  m_NewRecords.Add(m_pScript1);
  m_NumScripts++;

	/* Create the uninstall script */
  m_pScript2 = (CEsmScript *) m_EsmFile.AllocateRecord(MWESM_REC_SCPT);
  m_pScript2->CreateNew(&m_EsmFile);
  m_NewRecords.Add(m_pScript2);
  m_NumScripts++;

  if (m_Options.UseScriptNames) {
    m_pScript1->SetID(m_Options.InstallScript);
    m_pScript2->SetID(m_Options.UninstallScript);
   }
  else {
    m_pScript1->SetID(MakeItemID());
    m_pScript2->SetID(MakeItemID());
   }

  strnncpy(m_pScript1->GetScriptHeader()->GetScriptHeadData()->Name, m_pScript1->GetID(), MWESM_ID_MAXSIZE);
  strnncpy(m_pScript2->GetScriptHeader()->GetScriptHeadData()->Name, m_pScript2->GetID(), MWESM_ID_MAXSIZE);

  m_ScriptBuffer1 = _T("begin ");
  m_ScriptBuffer1 += m_pScript1->GetID();
  m_ScriptBuffer1 += _T("\n");

  m_ScriptBuffer2 = _T("begin ");
  m_ScriptBuffer2 += m_pScript2->GetID();
  m_ScriptBuffer2 += _T("\n");

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::OpenNewScriptFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool OutputLListScripts (void);
 *
 * Creates the install/uninstall scripts.
 *
 *=========================================================================*/
bool CMwRandItemGen::OutputLListScripts (void) {
  mwri_levellist_t* pLevelList;
  CEsmLevelItem*    pBaseList;
  TCHAR		    TempBuffer1[256];
  TCHAR		    TempBuffer2[256];
  byte		    DataBuffer1[256];
  byte		    DataBuffer2[256];
  float		    FloatData;
  int		    DataSize1;
  int		    DataSize2;
  int		    Index;
  int		    ListIndex;
  int		    BaseIndex;

  for (Index = 0; Index < m_RandLLists.GetNumLists(); Index++) {

    for (BaseIndex = 0; BaseIndex < m_LevelLists.GetNumElements(); BaseIndex++) {
      pLevelList = m_RandLLists.GetLevelList(Index);
      pBaseList  = (CEsmLevelItem *) m_LevelLists.GetAt(BaseIndex);

      sprintf(TempBuffer1, _T("\tAddToLevItem, \"%s\", \"%s\", 1\n"), pLevelList->ID, pBaseList->GetID());
      sprintf(TempBuffer2, _T("\tRemoveFromLevItem, \"%s\", \"%s\", -1\n"), pLevelList->ID, pBaseList->GetID());

      DataBuffer1[0] = 0xA8;
      DataBuffer1[1] = 0x11;
      DataBuffer1[2] = (byte) strlen(pLevelList->ID);
      memcpy(DataBuffer1 + 3, pLevelList->ID, (int) DataBuffer1[2]);
      DataSize1 = 3 + (int) DataBuffer1[2];
      DataBuffer1[DataSize1] = (byte) strlen(pBaseList->GetID());
      memcpy(DataBuffer1 + DataSize1 + 1, pBaseList->GetID(), (int) DataBuffer1[DataSize1]);
      DataSize1 += 1 + (int) (byte) strlen(pBaseList->GetID());
      FloatData = 1;
      memcpy(DataBuffer1 + DataSize1, &FloatData, 4);
      DataSize1 += 4;

      memcpy(DataBuffer2, DataBuffer1, DataSize1);
      DataSize2 = DataSize1;
      DataBuffer2[0] = 0xA9;
      FloatData = -1;
      memcpy(DataBuffer2 + DataSize1 - 4, &FloatData, 4);

      for (ListIndex = 0; ListIndex < pLevelList->Number; ListIndex++) {
        m_ScriptBuffer1 += TempBuffer1;
        AddScriptData1((char *)DataBuffer1, DataSize1);
       }

      m_ScriptBuffer2 += TempBuffer2;
      AddScriptData2((char *)DataBuffer2, DataSize2);
     }
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::OutputLListScripts()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool OutputPHListScripts (void);
 *
 * Creates the install/uninstall scripts.
 *
 *=========================================================================*/
bool CMwRandItemGen::OutputPHListScripts (void) {
  mwri_levellist_t* pLevelList;
  CEsmLevelItem*    pPHList;
  TCHAR		    TempBuffer1[256];
  TCHAR		    TempBuffer2[256];
  byte		    DataBuffer1[256];
  byte		    DataBuffer2[256];
  float		    FloatData;
  int		    DataSize1;
  int		    DataSize2;
  int		    Index;
  int		    ListIndex;

  for (Index = 0; Index < m_RandLLists.GetNumLists(); Index++) {
    pLevelList = m_RandLLists.GetLevelList(Index);

    for (ListIndex = 0; ListIndex < pLevelList->Number; ListIndex++) {
      pPHList = (CEsmLevelItem *) m_PHLists.GetAt(ListIndex);
      if (pPHList == NULL) break;

      sprintf(TempBuffer1, _T("\tAddToLevItem, \"%s\", \"%s\", 1\n"), pLevelList->ID, pPHList->GetID());
      sprintf(TempBuffer2, _T("\tRemoveFromLevItem, \"%s\", \"%s\", -1\n"), pLevelList->ID, pPHList->GetID());

      DataBuffer1[0] = 0xA8;
      DataBuffer1[1] = 0x11;
      DataBuffer1[2] = (byte) strlen(pLevelList->ID);
      memcpy(DataBuffer1 + 3, pLevelList->ID, (int) DataBuffer1[2]);
      DataSize1 = 3 + (int) DataBuffer1[2];
      DataBuffer1[DataSize1] = (byte) strlen(pPHList->GetID());
      memcpy(DataBuffer1 + DataSize1 + 1, pPHList->GetID(), (int) DataBuffer1[DataSize1]);
      DataSize1 += 1 + (int) (byte) strlen(pPHList->GetID());
      FloatData = 1;
      memcpy(DataBuffer1 + DataSize1, &FloatData, 4);
      DataSize1 += 4;

      memcpy(DataBuffer2, DataBuffer1, DataSize1);
      DataSize2 = DataSize1;
      DataBuffer2[0] = 0xA9;
      FloatData = -1;
      memcpy(DataBuffer2 + DataSize1 - 4, &FloatData, 4);

      m_ScriptBuffer1 += TempBuffer1;
      AddScriptData1((char *)DataBuffer1, DataSize1);
      m_ScriptBuffer2 += TempBuffer2;
      AddScriptData2((char *)DataBuffer2, DataSize2);
     }
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::OutputPHListScripts()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool SaveGroupFile (pFilename);
 *
 * Attempt to save the current group data file
 *
 *=========================================================================*/
bool CMwRandItemGen::SaveGroupFile (const TCHAR* pFilename) {
  bool Result;

  	/* Copy the current options */
  *m_GroupData.GetGroup() = *(mwri_group_t *) &m_Options;

	/* Attempt to save the group file */
  Result = m_GroupData.Save(pFilename);
  if (!Result) return (false);
  
  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::SaveGroupFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void SelectBaseItem (void);
 *
 * Selects a base item from the current list of valid items to be used 
 * in creating a random item.
 *
 *=========================================================================*/
void CMwRandItemGen::SelectBaseItem (void) {
  int Index;

	/* Check for no valid items */
  if (m_ValidItems.GetNumElements() <= 0) {
    m_Options.pCurrentItem = NULL;
   }
  else {
    Index = (int) (rand()/(float)RAND_MAX * m_ValidItems.GetNumElements());
    m_Options.pCurrentItem = m_ValidItems.GetAt(Index);
   }
  
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::SelectBaseItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void SelectValidItems (void);
 *
 *=========================================================================*/
void CMwRandItemGen::SelectValidItems (void) {
  mwri_item_t*	pItem;
  int		Index;

	/* Clear the current valid items */
  m_ValidItems.RemoveAll();

	/* Select all valid items */
  for (Index = 0; Index < m_RandItems.GetNumItems(); Index++) {
    pItem = m_RandItems.GetItem(Index);

		/* Check item type and level */
    if ((pItem->ItemType & m_Options.ItemMask) == 0) continue;
    if (!CheckItemLevel(pItem->ItemLevel)) continue;

    m_ValidItems.Add(pItem);
   }

 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::SelectValidItems()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void SelectValidPrefixes (void);
 *
 *=========================================================================*/
void CMwRandItemGen::SelectValidPrefixes (void) {
  mwrand_effect_t* pEffect;
  int		   Index;

	/* Clear the current valid effects */
  m_ValidPrefixes.RemoveAll();

	/* Select all valid prefixes */
  for (Index = 0; Index < m_RandEffects.GetNumPrefixes(); Index++) {
    pEffect = m_RandEffects.GetPrefix(Index);

		/* Check effect type and level */
    if ((pEffect->ItemMask & m_Options.ItemMask) == 0) continue;
    if ((pEffect->ItemMask & m_Options.pCurrentItem->ItemType) == 0) continue;
    if (!IsValidEffect(pEffect, m_Options.pCurrentItem)) continue;

    if (pEffect->Cursed) {
      if (!CheckCursedLevel(pEffect->ItemLevel)) continue;
     }
    else {
      if (!CheckEffectLevel(pEffect->ItemLevel)) continue;
     }

    m_ValidPrefixes.Add(pEffect);
   }
 }


void CMwRandItemGen::SelectValidSuffixes (void) {
  mwrand_effect_t* pEffect;
  int		   Index;

  m_ValidSuffixes.RemoveAll();

	/* Select all valid suffixes */
  for (Index = 0; Index < m_RandEffects.GetNumSuffixes(); Index++) {
    pEffect = m_RandEffects.GetSuffix(Index);

		/* Check effect type and level */
    if ((pEffect->ItemMask & m_Options.ItemMask) == 0) continue;
    if ((pEffect->ItemMask & m_Options.pCurrentItem->ItemType) == 0) continue;
    if (!CheckEffectLevel(pEffect->ItemLevel)) continue;

    if (!IsValidEffect(pEffect, m_Options.pCurrentItem)) continue;

    m_ValidSuffixes.Add(pEffect);
   }

 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::SelectValidEffects()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void SelectValidUniques (void);
 *
 *=========================================================================*/
void CMwRandItemGen::SelectValidUniques (void) {
  mwru_unique_t* pUnique;
  int		 Index;
  int		 EffectIndex;
  bool		 ValidUnique;

	/* Clear the current valid uniques */
  m_ValidUniques.RemoveAll();

	/* Select all valid uniques */
  for (Index = 0; Index < m_RandUniques.GetNumUniques(); Index++) {
    pUnique = m_RandUniques.GetUnique(Index);

		/* Check effect type and level */
    if ((pUnique->ItemMask & m_Options.ItemMask) == 0) continue;
    if ((pUnique->ItemMask & m_Options.pCurrentItem->ItemType) == 0) continue;
    if (!CheckEffectLevel(pUnique->ItemLevel)) continue;
    ValidUnique = true;

    for (EffectIndex = 0; EffectIndex < pUnique->NumEffects; EffectIndex++) {

      if (!IsValidEffect(pUnique->pEffects[EffectIndex], m_Options.pCurrentItem)) {
        ValidUnique = false;
        break;
       }

     }

    if (ValidUnique) m_ValidUniques.Add(pUnique);
   }

 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::SelectValidUniques()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void SetRecordEffects (pRecord);
 *
 * Adds any effects to the input record according to the current
 * item settings.
 *
 *=========================================================================*/
void CMwRandItemGen::SetRecordEffects (CEsmRecord* pRecord) {
  CEsmEnchant*	pEnchant = NULL;
  CEsmSpell*    pSpell = NULL;
  int		Index;
  long		MultiplierSum = 0;
  long		QualitySum = 0;
  long		Value;

	/* Ignore if there are no effects to add */
  if (m_Options.pCurrentUnique == NULL && 
      m_Options.pCurrentPrefix == NULL && 
      m_Options.pCurrentSuffix == NULL) return;

	/* Compute the quality level for the effects */
  ComputeQualityLevel();

	/* Add the unique effects */
  if (m_Options.pCurrentUnique != NULL) {

    for (Index = 0; Index < m_Options.pCurrentUnique->NumEffects; Index++) {
      CreateEffect(pRecord, m_Options.pCurrentUnique->pEffects[Index], &pEnchant, &pSpell);
      QualitySum += (long) SplitValue((float)m_Options.pCurrentUnique->pEffects[Index]->MinQuality,
				      (float)m_Options.pCurrentUnique->pEffects[Index]->MaxQuality,
				      m_Options.CurrentRatio);
      MultiplierSum += m_Options.pCurrentUnique->pEffects[Index]->Multiplier;
     }
   }

	/* Add the prefix effects */
  if (m_Options.pCurrentPrefix != NULL) {
    CreateEffect(pRecord, m_Options.pCurrentPrefix, &pEnchant, &pSpell);
    QualitySum += (long) SplitValue ((float)m_Options.pCurrentPrefix->MinQuality,
				     (float)m_Options.pCurrentPrefix->MaxQuality,
				     m_Options.CurrentRatio);
    MultiplierSum += m_Options.pCurrentPrefix->Multiplier;
   }

	/* Add the suffix effect */
  if (m_Options.pCurrentSuffix != NULL) {
    CreateEffect(pRecord, m_Options.pCurrentSuffix, &pEnchant, &pSpell);
    QualitySum += (long) SplitValue ((float)m_Options.pCurrentSuffix->MinQuality,
				     (float)m_Options.pCurrentSuffix->MaxQuality,
				     m_Options.CurrentRatio);
    MultiplierSum += m_Options.pCurrentSuffix->Multiplier;
   }

	/* Compute the final item value */
  if (MultiplierSum < 0)
    Value = abs(QualitySum + m_Options.pCurrentItem->BasePrice / MultiplierSum);
  else
    Value = QualitySum + m_Options.pCurrentItem->BasePrice * MultiplierSum;

  if (Value <= 0) {
    Value = 1;
   }

	/* Save the item value */
  switch (m_Options.pCurrentItem->ItemType) {
    case MWRI_ITEMMASK_WEAPON:	((CEsmWeapon   *) pRecord)->GetWeaponData()->Value = Value; break;
    case MWRI_ITEMMASK_ARMOR:	((CEsmArmor    *) pRecord)->GetArmorData()->Value  = Value; break;
    case MWRI_ITEMMASK_MISC:	((CEsmMisc     *) pRecord)->GetMiscData()->Value   = Value; break;
    case MWRI_ITEMMASK_CLOTHING:
	if (Value > 65535) Value = 65535;
	((CEsmClothing *) pRecord)->GetClothData()->Value = Value & 0xFFFF; 
	break;
   }
  
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::SetRecordEffects()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void SetRecordItemParams (pRecord);
 *
 * Sets the parameters of the input record according to the current
 * item settings.
 *
 *=========================================================================*/
void CMwRandItemGen::SetRecordItemParams (CEsmRecord* pRecord) {

	/* Record ID and name */
  pRecord->SetID(MakeItemID());
  ((CEsmItem1 *)pRecord)->SetName(MakeItemName());

	/* Set parameters according to item type */
  switch (m_Options.pCurrentItem->ItemType) {
    case MWRI_ITEMMASK_WEAPON:
	SetWeaponParams((CEsmWeapon *)pRecord);
	break;
    case MWRI_ITEMMASK_ARMOR:
        SetArmorParams((CEsmArmor *)pRecord);
	break;
    case MWRI_ITEMMASK_CLOTHING:
        SetClothingParams((CEsmClothing *)pRecord);
	break;
    case MWRI_ITEMMASK_MISC:
        SetMiscParams((CEsmMisc *)pRecord);
	break;
   }

 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::SetRecordItemParams()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void SetBodyParts (pRecord);
 *
 * Adds any body part sub-records to the given record.
 *
 *=========================================================================*/
void CMwRandItemGen::SetBodyParts (CEsmRecord* pRecord) {
  CEsmSubByte*    pIndex;
  CEsmSubNameFix* pName;
  int		  Index;

  for (Index = 0; Index < MWRI_ITEMBODY_NUMPARTS; Index++) {

		/* Ignore if no parts to add for this index */
    if (m_Options.pCurrentItem->MaleParts[Index][0]   == NULL_CHAR &&
        m_Options.pCurrentItem->FemaleParts[Index][0] == NULL_CHAR) continue;

		/* Allocate the index subrecord */
    pIndex = (CEsmSubByte *) pRecord->AllocateSubRecord(MWESM_SUBREC_INDX);
    pIndex->CreateNew();
    pIndex->SetValue(Index);

		/* Add the male part subrecord */
    if (m_Options.pCurrentItem->MaleParts[Index][0] != NULL_CHAR) {
      pName = (CEsmSubNameFix *) pRecord->AllocateSubRecord(MWESM_SUBREC_BNAM);
      pName->CreateNew();
      pName->SetName(m_Options.pCurrentItem->MaleParts[Index]);
     }

		/* Add the female part subrecord */
    if (m_Options.pCurrentItem->FemaleParts[Index][0] != NULL_CHAR) {
      pName = (CEsmSubNameFix *) pRecord->AllocateSubRecord(MWESM_SUBREC_CNAM);
      pName->CreateNew();
      pName->SetName(m_Options.pCurrentItem->FemaleParts[Index]);
     }
   }

 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::SetBodyParts()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void SetArmorParams (pArmor);
 *
 * Sets the parameters of the input armor according to the current
 * item settings.
 *
 *=========================================================================*/
void CMwRandItemGen::SetArmorParams (CEsmArmor* pArmor) {
  armordata_t* pArmorData;
  pArmorData = pArmor->GetArmorData();

  pArmorData->Weight     = m_Options.pCurrentItem->Weight;
  pArmorData->EnchantPts = (short) (m_Options.pCurrentItem->EnchantPts);
  pArmorData->Type       = m_Options.pCurrentItem->Armor.Type;
  pArmorData->Rating     = m_Options.pCurrentItem->Armor.AC;
  pArmorData->Value      = m_Options.pCurrentItem->BasePrice;
  pArmorData->Health     = (short) m_Options.pCurrentItem->Armor.Condition;
  pArmor->SetIcon(m_Options.pCurrentItem->Icon);
  pArmor->SetModel(m_Options.pCurrentItem->Model);

  SetBodyParts(pArmor);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::SetArmorParams()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void SetClothingParams (pClothing);
 *
 * Sets the parameters of the input clothing according to the current
 * item settings.
 *
 *=========================================================================*/
void CMwRandItemGen::SetClothingParams (CEsmClothing* pClothing) {
  clothdata_t* pClothData;
  pClothData = pClothing->GetClothData();

  pClothData->Weight     = m_Options.pCurrentItem->Weight;
  pClothData->EnchantPts = (short) (m_Options.pCurrentItem->EnchantPts);
  pClothData->Type       = m_Options.pCurrentItem->Clothing.Type;
  pClothData->Value      = (m_Options.pCurrentItem->BasePrice & 0x7FFF);
  pClothing->SetIcon(m_Options.pCurrentItem->Icon);
  pClothing->SetModel(m_Options.pCurrentItem->Model);
  SetBodyParts(pClothing);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::SetClothingParams()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void SetMiscParams (pMisc);
 *
 * Sets the parameters of the input misc item according to the current
 * item settings.
 *
 *=========================================================================*/
void CMwRandItemGen::SetMiscParams (CEsmMisc* pMisc) {
  miscdata_t* pMiscData;
  pMiscData = pMisc->GetMiscData();
  
  pMiscData->Value  = m_Options.pCurrentItem->BasePrice;
  pMiscData->Weight = m_Options.pCurrentItem->Weight;

  pMisc->SetIcon(m_Options.pCurrentItem->Icon);
  pMisc->SetModel(m_Options.pCurrentItem->Model);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::SetMiscParams()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - void SetWeaponParams (pWeapon);
 *
 * Sets the parameters of the input weapon according to the current
 * item settings.
 *
 *=========================================================================*/
void CMwRandItemGen::SetWeaponParams (CEsmWeapon* pWeapon) {
  weapondata_t* pWeaponData;
  pWeaponData = pWeapon->GetWeaponData();

  if (m_Options.pCurrentItem->Weapon.IgnoreResist) pWeaponData->Flags |= MWESM_WEAPONFLAG_IGNORERESIST;
  pWeaponData->Weight     = m_Options.pCurrentItem->Weight;
  pWeaponData->EnchantPts = (short) (m_Options.pCurrentItem->EnchantPts);
  pWeaponData->Reach      = (short) (m_Options.pCurrentItem->Weapon.Reach);
  pWeaponData->ChopMin    = m_Options.pCurrentItem->Weapon.MinChop;
  pWeaponData->ChopMax    = m_Options.pCurrentItem->Weapon.MaxChop;
  pWeaponData->SlashMin   = m_Options.pCurrentItem->Weapon.MinSlash;
  pWeaponData->SlashMax   = m_Options.pCurrentItem->Weapon.MaxSlash;
  pWeaponData->Speed      = m_Options.pCurrentItem->Weapon.Speed;
  pWeaponData->ThrustMin  = m_Options.pCurrentItem->Weapon.MinThrust;
  pWeaponData->ThrustMax  = m_Options.pCurrentItem->Weapon.MaxThrust;
  pWeaponData->Type       = m_Options.pCurrentItem->Weapon.Type;
  pWeaponData->Value      = m_Options.pCurrentItem->BasePrice;
  pWeaponData->Health     = (short) m_Options.pCurrentItem->Weapon.Condition;
  pWeapon->SetIcon(m_Options.pCurrentItem->Icon);
  pWeapon->SetModel(m_Options.pCurrentItem->Model);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::SetWeaponParams()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGen Method - bool WriteScriptEntry (pID, Level);
 *
 * Outputs a single entry to the script file.
 *
 *=========================================================================*/
bool CMwRandItemGen::WriteScriptEntry (const TCHAR* pID, const int Level) {
  return m_ScriptFile.Printf("\tAddToLevItem, levellist, \"%s\", %d\n", pID, Level);
 }


bool CMwRandItemGen::WriteScriptRecord (const TCHAR* pID, const int Level) {
  TCHAR TempBuffer[256];

  sprintf (TempBuffer, _T("\tAddToLevItem, levellist, \"%s\", %d\n"), pID, Level);
  m_ScriptBuffer1 += TempBuffer;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGen::WriteScriptEntry()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void DefaultMWRandItemGenOptions (Options);
 *
 *=========================================================================*/
void DefaultMWRandItemGenOptions (mwrig_options_t& Options) {
  DefaultMWRandItemGroupOptions(*(mwri_group_t*) &Options);
  Options.pCurrentItem = NULL;
  Options.pCurrentPrefix = NULL;
  Options.pCurrentSuffix = NULL;
  Options.pCurrentUnique = NULL;
 }
/*===========================================================================
 *		End of Function DefaultMWRandItemGenOptions()
 *=========================================================================*/


