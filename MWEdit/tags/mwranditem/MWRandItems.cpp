/*===========================================================================
 *
 * File:	Mwranditems.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Friday, May 23, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "mwranditems.h"



/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("MwRandItems.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Biped Object Types
 *
 *=========================================================================*/
valuenames_t l_MwItemBipeds[] = {
	{ MWRI_ITEMBODY_HEAD,		_T("Head") },	
	{ MWRI_ITEMBODY_HAIR,		_T("Hair") },
	{ MWRI_ITEMBODY_NECK,		_T("Neck") },
	{ MWRI_ITEMBODY_CHEST,		_T("Chest") },
	{ MWRI_ITEMBODY_GROIN,		_T("Groin") },
	{ MWRI_ITEMBODY_SKIRT,		_T("Skirt") },
	{ MWRI_ITEMBODY_RIGHTHAND,	_T("RightHand") },
	{ MWRI_ITEMBODY_LEFTHAND,	_T("LeftHand") },
	{ MWRI_ITEMBODY_RIGHTWRIST,	_T("RightWrist") },
	{ MWRI_ITEMBODY_LEFTWRIST,	_T("LeftWrist") },
	{ MWRI_ITEMBODY_SHIELD,		_T("Shield") },
	{ MWRI_ITEMBODY_RIGHTFOREARM,	_T("RightForeArm") },
	{ MWRI_ITEMBODY_LEFTFOREARM,	_T("LeftForeArm") },
	{ MWRI_ITEMBODY_RIGHTUPPERARM,	_T("RightUpperArm") },
	{ MWRI_ITEMBODY_LEFTUPPERARM,	_T("LeftUpperArm") },
	{ MWRI_ITEMBODY_RIGHTFOOT,	_T("RightFoot") },
	{ MWRI_ITEMBODY_LEFTFOOT,	_T("LeftFoot") },
	{ MWRI_ITEMBODY_RIGHTANKLE,	_T("RightAnkle") },
	{ MWRI_ITEMBODY_LEFTANKLE,	_T("LeftAnkle") },
	{ MWRI_ITEMBODY_RIGHTKNEE,	_T("RightKnee") },
	{ MWRI_ITEMBODY_LEFTKNEE,	_T("LeftKnee") },
	{ MWRI_ITEMBODY_RIGHTUPPERLEG,	_T("RightUpperLeg") },
	{ MWRI_ITEMBODY_LEFTUPPERLEG,	_T("LeftUpperLeg") },
	{ MWRI_ITEMBODY_RIGHTPAULDRON,	_T("RightPauldron") },
	{ MWRI_ITEMBODY_LEFTPAULDRON,	_T("LeftPauldron") },
	{ MWRI_ITEMBODY_WEAPON,		_T("Weapon") },
	{ MWRI_ITEMBODY_TAIL,		_T("Tail") },
	{ MWRI_ITEMBODY_NONE,		NULL }
 };
/*===========================================================================
 *		End of Biped Object Types
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Value Name Arrays
 *
 *=========================================================================*/
valuenames_t l_MwItemMasks[] = {
	{ MWRI_ITEMMASK_WEAPON,		_T("Weapon") },
	{ MWRI_ITEMMASK_ARMOR,		_T("Armor") },
	{ MWRI_ITEMMASK_CLOTHING,	_T("Clothing") },
	{ MWRI_ITEMMASK_MISC,		_T("Misc") },
	{ MWRI_ITEMMASK_ALL,		NULL }
 };
/*===========================================================================
 *		End of Value Name Arrays
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Effect Mask Value-String Arrays
 *
 *=========================================================================*/
valuenames_t l_MwEffectMasks[] = {
	{ MWRI_EFFMASK_NONE,		_T("None") },
	{ MWRI_EFFMASK_ENCHANT,		_T("Enchant") },
	{ MWRI_EFFMASK_WEIGHT,		_T("Weight") },
	{ MWRI_EFFMASK_DAMAGE,		_T("Damage") },
	{ MWRI_EFFMASK_MAXDAMAGE,	_T("MaxDamage") },
	{ MWRI_EFFMASK_MINDAMAGE,	_T("MinDamage") },
	{ MWRI_EFFMASK_REACH,		_T("Reach") },
	{ MWRI_EFFMASK_SPEED,		_T("Speed") },
	{ MWRI_EFFMASK_CONDITION,	_T("Condition") },
	{ MWRI_EFFMASK_CONDITION,	_T("Health") },
	{ MWRI_EFFMASK_ARMOR,		_T("Armor") },
	{ MWRI_EFFMASK_ARMOR,		_T("AC") },
	{ MWRI_EFFMASK_ENCHANTPTS,	_T("EnchantPts") },
	{ MWRI_EFFMASK_SPELL,		_T("Spell") },
	{ MWRI_EFFMASK_ALL,		_T("All") },
	{ 0,				NULL } /* Must be last entry */
 };
/*===========================================================================
 *		End of Value String Arrays
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Enchantment Mask Value-String Arrays
 *
 *=========================================================================*/
valuenames_t l_MwEnchantMasks[] = {
	{ MWRI_ENCMASK_NONE,		_T("None") },
	{ MWRI_ENCMASK_STRIKES,		_T("Cast Strikes") },
	{ MWRI_ENCMASK_USED,		_T("Cast When Used") },
	{ MWRI_ENCMASK_ONCE,		_T("Cast Once") },
	{ MWRI_ENCMASK_CONSTANT,	_T("Constant Effect") },
	{ MWRI_ENCMASK_ALL,		_T("All") },
	{ 0,				NULL } /* Must be last entry */
 };
/*===========================================================================
 *		End of Enchantment Mask Value-String Arrays
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItems Constructor
 *
 *=========================================================================*/
CMwRandItems::CMwRandItems () : m_ItemArray(0) {
  //DEFINE_FUNCTION("CMwRandItems::CMwRandItems()");
  m_InputLine = 0;
 }
/*===========================================================================
 *		End of Class CMwRandItems Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItems Method - void Destroy (void);
 *
 *=========================================================================*/
void CMwRandItems::Destroy (void) {
  DEFINE_FUNCTION("CMwRandItems::Destroy()");
  mwri_item_t*  pItem;
  int		Index;
	
	/* Delete all allocated item records */
  for (Index = 0; Index < (int)m_ItemArray.GetNumElements(); Index++) {
    pItem = m_ItemArray.GetAt(Index);
    DestroyPointer(pItem);
   }

	/* Clear the array */
  m_ItemArray.RemoveAll();
  m_InputLine = 0;
 }
/*===========================================================================
 *		End of Class Method CMwRandItems::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItems Method - int FindBodyPart (pString);
 *
 * Find and return a body part index of the given string within the 
 * l_MwItemBipeds array. Returns -1 if the part is not found.
 *
 *=========================================================================*/
int CMwRandItems::FindBodyPart (const TCHAR* pString) {
  int Result = FindNameValue(l_MwItemBipeds, pString);

  if (Result == MWRI_ITEMBODY_NONE) {
    SystemLog.Printf("\t%5ld: Unknown body part '%s'!", m_InputLine, pString);
    return (MWRI_ITEMBODY_HEAD);
   }

  return (Result);
 }
/*===========================================================================
 *		End of Class Method CMwRandItems::FindBodyPart()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItems Method - long ParseEffectMask (TCHAR* pValue);
 *
 * Parses and returns the effect mask value from the given string.
 *
 *=========================================================================*/
long CMwRandItems::ParseEffectMask (const TCHAR* pValue) {
  TCHAR  Buffer[MWRI_MAX_BUFFERSIZE+1];
  TCHAR* pParse;
  TCHAR* pParse1;
  long   Mask = 0;
  long   Result;
  bool	 IsParsing = true;

	/* Create a copy of the input value for parsing */
  strnncpy(Buffer, pValue, MWRI_MAX_BUFFERSIZE);
  strlwr(Buffer);

	/* Parse the entire string */
  pParse = TSTRTOK(Buffer, _T("|"));

  while (pParse != NULL) {
    pParse1 = trim(pParse);
    
		/* Find the effect mask */
    Result = FindNameValue(l_MwEffectMasks, pParse1);

    if (Result == 0)
      SystemLog.Printf("\t%05ld: Unknown item effect mask '%s'!", m_InputLine, pParse1);
    else
      Mask |= Result;

    pParse = TSTRTOK(NULL, _T("|"));
   }

  return (Mask);
 }
/*===========================================================================
 *		End of Class Method CMwRandItems::ParseEffectMask()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItems Method - long ParseEnchantMask (pValue);
 *
 * Parses and returns the enchantment mask value from the given string.
 *
 *=========================================================================*/
long CMwRandItems::ParseEnchantMask (const TCHAR* pValue) {
  TCHAR  Buffer[MWRI_MAX_BUFFERSIZE+1];
  TCHAR* pParse;
  TCHAR* pParse1;
  long   Mask = 0;
  long   Result;

	/* Create a copy of the input value for parsing */
  strnncpy(Buffer, pValue, MWRI_MAX_BUFFERSIZE);
  strlwr(Buffer);

	/* Parse the entire string */
  pParse = strtok(Buffer, _T("|"));

  while (pParse != NULL) {
    pParse1 = trim(pParse);

		/* Find the effect mask */
    Result = FindNameValue(l_MwEnchantMasks, pParse1);

    if (Result == 0)
      SystemLog.Printf("\t%05ld: Unknown item enchantment mask '%s'!", m_InputLine, pParse1);
    else
      Mask |= Result;

    pParse = TSTRTOK(NULL, _T("|"));
   }

  return (Mask);
 }
/*===========================================================================
 *		End of Class Method CMwRandItems::ParseEnchantMask()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItems Method - bool ReadItem (File, pNewItem);
 *
 * Inputs an item section from the given file and stores the results in the
 * given item. Returns false on any error. Protected class method.
 *
 *=========================================================================*/
bool CMwRandItems::ReadItem (CGenFile& File, mwri_item_t* pNewItem) {
  TCHAR  LineBuffer[MWRI_MAX_LINELENGTH+1];
  TCHAR* pVariable;
  TCHAR* pValue;
  bool   IsReading = true;
  bool   ParseResult;
  bool	 Result;
  int    ReadResult;

	/* Input until end of file or end of effect */
  while (!File.IsEOF() && IsReading) {

		/* Input a single line of text from the file */
    ReadResult = File.ReadLine(LineBuffer, MWRI_MAX_LINELENGTH);
    if (ReadResult == READLINE_MSL) ReadResult = File.ReadLine(); 
    if (ReadResult == READLINE_ERROR) return (false);
    m_InputLine++;

		/* Parse input, ignore comments, whitespace trim, etc... */
    ParseResult = SeperateVarValueQ(&pVariable, &pValue, LineBuffer);

		/* Determine input action */
    if (TSTRICMP(pVariable, _T("End")) == 0) {
      IsReading = false;
     }
    else if (ParseResult) {
      Result = SetItemParam(pNewItem, pVariable, pValue);
      if (!Result) return (false);
     }
    
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItems::ReadItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItems Method - bool ReadItem (File);
 *
 * Protected class method which reads an item section from the given file.
 * Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItems::ReadItem (CGenFile& File) {
  DEFINE_FUNCTION("CMwRandItems::ReadItem()");
  mwri_item_t* pNewItem;

	/* Create and initialize the new item */
  CreatePointer(pNewItem, mwri_item_t);
  DefaultMwRandItem(*pNewItem);
  m_ItemArray.Add(pNewItem);

  return ReadItem(File, pNewItem);
 }
/*===========================================================================
 *		End of Class Method CMwRandItems::ReadItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItems Method - bool ReadItemFile (pFilename);
 *
 * Attempts to input item data from the given file. Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItems::ReadItemFile (const TCHAR* pFilename) {
  TCHAR    LineBuffer[MWRI_MAX_LINELENGTH+1];
  TCHAR*   pVariable;
  TCHAR*   pValue;
  CGenFile File;
  bool	   Result;
  int      ReadResult;

	/* Attempt to open the file for reading */
  Result = File.Open(pFilename, "rt");
  if (!Result) return (false);

	/* Input until end of file or end of effect */
  while (!File.IsEOF()) {

		/* Input a single line of text from the file */
    ReadResult = File.ReadLine(LineBuffer, MWRI_MAX_LINELENGTH);
    if (ReadResult == READLINE_MSL) ReadResult = File.ReadLine(); 
    if (ReadResult == READLINE_ERROR) return (false);
    m_InputLine++;

		/* Parse input, ignore comments, whitespace trim, etc... */
    SeperateVarValueQ(&pVariable, &pValue, LineBuffer);

		/* Start of item section */
    if (TSTRICMP(pVariable, _T("Item")) == 0) {
      Result = ReadItem(File);
      if (!Result) return (false);
     }
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItems::ReadItemFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItems Method - bool SetItemParam (pNewItem, pVariable, pValue);
 *
 * Sets a parameter of the given item record using the input strings.
 * Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItems::SetItemParam (mwri_item_t* pNewItem, const TCHAR* pVariable, const TCHAR* pValue) {

  if (TSTRICMP(pVariable, _T("Name")) == 0) {
    strnncpy(pNewItem->Name, pValue, MWRI_MAX_NAMESIZE);
   }
  else if (TSTRICMP(pVariable, _T("Material")) == 0) {
    strnncpy(pNewItem->Material, pValue, MWRI_MAX_NAMESIZE);
   }
  else if (TSTRICMP(pVariable, _T("Icon")) == 0) {
    strnncpy(pNewItem->Icon, pValue, MWRI_MAX_NAMESIZE);
   }
  else if (TSTRICMP(pVariable, _T("Model")) == 0) {
    strnncpy(pNewItem->Model, pValue, MWRI_MAX_NAMESIZE);
   }
  else if (TSTRICMP(pVariable, _T("EnchantPts")) == 0) {
    pNewItem->EnchantPts = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("ItemType")) == 0) {
    pNewItem->ItemType = StringToMwRandItemMask(pValue);

    if      (pNewItem->ItemType == MWRI_ITEMMASK_ARMOR)    DefaultMwRandItemArmor(*pNewItem);
    else if (pNewItem->ItemType == MWRI_ITEMMASK_CLOTHING) DefaultMwRandItemClothing(*pNewItem);
    else if (pNewItem->ItemType == MWRI_ITEMMASK_WEAPON)   DefaultMwRandItemWeapon(*pNewItem);
    else if (pNewItem->ItemType == MWRI_ITEMMASK_MISC)     DefaultMwRandItemMisc(*pNewItem);
    else    SystemLog.Printf("\t%5ld: Unknown item type '%s'!", m_InputLine, pValue);
   }
  else if (TSTRICMP(pVariable, _T("BasePrice")) == 0 || TSTRICMP(pVariable, _T("Value")) == 0) {
    pNewItem->BasePrice = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("Weight")) == 0) {
    pNewItem->Weight = (float) atof(pValue);
   }
  else if (TSTRICMP(pVariable, _T("ItemLevel")) == 0) {
    pNewItem->ItemLevel = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("EffectMask")) == 0) {
    pNewItem->EffectMask = ParseEffectMask(pValue);
   }
  else if (TSTRICMP(pVariable, _T("EnchantMask")) == 0) {
    pNewItem->EnchantMask = ParseEnchantMask(pValue);
   }
  else if (pNewItem->ItemType == MWRI_ITEMMASK_ARMOR) {
    SetArmorParam(pNewItem, pVariable, pValue);
   }
  else if (pNewItem->ItemType == MWRI_ITEMMASK_CLOTHING) {
    SetClothingParam(pNewItem, pVariable, pValue);
   }
  else if (pNewItem->ItemType == MWRI_ITEMMASK_WEAPON) {
    SetWeaponParam(pNewItem, pVariable, pValue);
   }
  else if (pNewItem->ItemType == MWRI_ITEMMASK_MISC) {
    SetMiscParam(pNewItem, pVariable, pValue);
   }
  else {
    SystemLog.Printf("\t%5ld: Unknown item variable '%s'!", m_InputLine, pVariable);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItems::SetItemParam()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItems Method - bool SetArmorParam (pNewItem, pVariable, pValue);
 *
 * Sets a armor parameter of the given item record using the input strings.
 * Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItems::SetArmorParam (mwri_item_t* pNewItem, const TCHAR* pVariable,
				  const TCHAR* pValue) {
  bool Result;

  if (TSTRICMP(pVariable, _T("Condition")) == 0) {
    pNewItem->Armor.Condition = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("AC")) == 0 || TSTRICMP(pVariable, _T("Armor")) == 0) {
    pNewItem->Armor.AC = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("Type")) == 0) {
    Result = GetESMArmorType(pNewItem->Armor.Type, pValue);
    if (!Result) SystemLog.Printf("\t%5ld: Unknown armor type '%s'!", m_InputLine, pValue);
   }
  else if (toupper(pVariable[0]) == 'M') {
    SetMaleBodyPart(pNewItem, pVariable, pValue);
   }
  else if (toupper(pVariable[0]) == 'F') {
    SetFemaleBodyPart(pNewItem, pVariable, pValue);
   }
  else {
    SystemLog.Printf("\t%5ld: Unknown armor variable '%s'!", m_InputLine, pVariable);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItems::SetArmorParam()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItems Method - bool SetClothingParam (pNewItem, pVariable, pValue);
 *
 * Sets a clothing parameter of the given item record using the input strings.
 * Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItems::SetClothingParam (mwri_item_t* pNewItem, const TCHAR* pVariable,
				     const TCHAR* pValue) {
  bool Result;

  if (TSTRICMP(pVariable, _T("Type")) == 0) {
    Result = GetESMClothType(pNewItem->Clothing.Type, pValue);
    if (!Result) SystemLog.Printf("\t%5ld: Unknown clothing type '%s'!", m_InputLine, pValue);
   }
  else if (toupper(pVariable[0]) == 'M') {
    SetMaleBodyPart(pNewItem, pVariable, pValue);
   }
  else if (toupper(pVariable[0]) == 'F') {
    SetFemaleBodyPart(pNewItem, pVariable, pValue);
   }
  else {
    SystemLog.Printf("\t%5ld: Unknown clothing variable '%s'!", m_InputLine, pVariable);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItems::SetClothingParam()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItems Method - bool SetMaleBodyPart (pNewItem, pVariable, pValue);
 *
 * Attempt to set a male body part ID string. Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItems::SetMaleBodyPart (mwri_item_t* pNewItem, const TCHAR* pVariable, 
				    const TCHAR* pValue) {
  int PartIndex;

	/* Attempt to find the associated body part index */
  PartIndex = FindBodyPart(pVariable+1);

  if (PartIndex < 0) {
    SystemLog.Printf("\t%5ld: Unknown male body part '%s'!", m_InputLine, pVariable);
    return (false);
   }

  strnncpy(pNewItem->MaleParts[PartIndex], pValue, MWRI_MAX_NAMESIZE);
  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItems::SetMaleBodyPart()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItems Method - bool SetFemaleBodyPart (pNewItem, pVariable, pValue);
 *
 * Attempt to set a female body part ID string. Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItems::SetFemaleBodyPart (mwri_item_t* pNewItem, const TCHAR* pVariable,
				      const TCHAR* pValue) {
  int PartIndex;

	/* Attempt to find the associated body part index */
  PartIndex = FindBodyPart(pVariable+1);

  if (PartIndex < 0) {
    SystemLog.Printf("\t%5ld: Unknown female body part '%s'!", m_InputLine, pVariable);
    return (false);
   }

  strnncpy(pNewItem->FemaleParts[PartIndex], pValue, MWRI_MAX_NAMESIZE);
  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItems::SetFemaleBodyPart()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItems Method - bool SetMiscParam (pNewItem, pVariable, pValue);
 *
 * Sets a clothing parameter of the given item record using the input strings.
 * Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItems::SetMiscParam (mwri_item_t* pNewItem, const TCHAR* pVariable,
				     const TCHAR* pValue) {
   
  SystemLog.Printf("\t%5ld: Unknown misc variable '%s'!", m_InputLine, pVariable);
  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItems::SetMiscParam()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItems Method - bool SetWeaponParam (NewItem, pVariable, pValue);
 *
 * Sets a weapon parameter of the given item record using the input strings.
 * Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItems::SetWeaponParam (mwri_item_t* pNewItem, const TCHAR* pVariable,
				   const TCHAR* pValue) {
  bool Result;

  if (TSTRICMP(pVariable, _T("Reach")) == 0) {
    pNewItem->Weapon.Reach = (float) atof(pValue);
   }
  else if (TSTRICMP(pVariable, _T("Speed")) == 0) {
    pNewItem->Weapon.Speed = (float) atof(pValue);
   }
  else if (TSTRICMP(pVariable, _T("ChopMin")) == 0 || TSTRICMP(pVariable, _T("MinChop")) == 0) {
    pNewItem->Weapon.MinChop = atoi(pValue) & 0xFF;
   }
  else if (TSTRICMP(pVariable, _T("ChopMax")) == 0 || TSTRICMP(pVariable, _T("MaxChop")) == 0) {
    pNewItem->Weapon.MaxChop = atoi(pValue) & 0xFF;
   }
  else if (TSTRICMP(pVariable, _T("SlashMin")) == 0 || TSTRICMP(pVariable, _T("MinSlash")) == 0) {
    pNewItem->Weapon.MinSlash = atoi(pValue) & 0xFF;
   }
  else if (TSTRICMP(pVariable, _T("SlashMax")) == 0 || TSTRICMP(pVariable, _T("MaxSlash")) == 0) {
    pNewItem->Weapon.MaxSlash = atoi(pValue) & 0xFF;
   }
  else if (TSTRICMP(pVariable, _T("ThrustMin")) == 0 || TSTRICMP(pVariable, _T("MinThrust")) == 0) {
    pNewItem->Weapon.MinThrust = atoi(pValue) & 0xFF;
   }
  else if (TSTRICMP(pVariable, _T("ThrustMax")) == 0 || TSTRICMP(pVariable, _T("MaxThrust")) == 0) {
    pNewItem->Weapon.MaxThrust = atoi(pValue) & 0xFF;
   }
  else if (TSTRICMP(pVariable, _T("Condition")) == 0) {
    pNewItem->Weapon.Condition = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("Type")) == 0) {
    pNewItem->Weapon.Type = GetESMWeaponType(pValue);

    if (pNewItem->Weapon.Type == MWRI_ITEMBODY_NONE) {
      pNewItem->Weapon.Type = MWRI_ITEMBODY_HEAD;
      SystemLog.Printf("\t%5ld: Unknown weapon type '%s'!", m_InputLine, pValue);
     }
   }
  else if (TSTRICMP(pVariable, _T("IgnoreResist")) == 0) {
    Result = StringToBoolean(pNewItem->Weapon.IgnoreResist, pValue);
    if (!Result) SystemLog.Printf("\t%5ld: Unknown boolean value '%s'!", m_InputLine, pValue);
   }
  else {
    SystemLog.Printf("\t%5ld: Unknown weapon variable '%s'!", m_InputLine, pVariable);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItems::SetWeaponParam()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void DefaultMwRandItem (Item);
 *
 *=========================================================================*/
void DefaultMwRandItem (mwri_item_t& Item) {
  memset(&Item, 0, sizeof(mwri_item_t));

  Item.BasePrice   = 50;
  Item.ItemLevel   = 1;
  Item.ItemType    = MWRI_ITEMMASK_WEAPON;
  Item.Weight      = 1.0f;
  Item.EnchantPts  = 0;
  Item.EffectMask  = MWRI_EFFMASK_ALL;
  Item.EnchantMask = MWRI_ENCMASK_ALL;
  Item.Name[0]     = NULL_CHAR;
  Item.Material[0] = NULL_CHAR;
  Item.Model[0]    = NULL_CHAR;
  Item.Icon[0]     = NULL_CHAR;
 }  
/*===========================================================================
 *		End of Function DefaultMwRandItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void DefaultMwRandItemArmor (Item);
 *
 *=========================================================================*/
void DefaultMwRandItemArmor (mwri_item_t& Item) {
  Item.Armor.Condition = 100;
  Item.Armor.AC = 10;
  Item.Armor.Type = 0;
 }
/*===========================================================================
 *		End of Function DefaultMwRandItemArmor()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void DefaultMwRandItemClothing (Item);
 *
 *=========================================================================*/
void DefaultMwRandItemClothing (mwri_item_t& Item) {
  Item.Clothing.Type = 0;
 }
/*===========================================================================
 *		End of Function DefaultMwRandItemClothing()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void DefaultMwRandItemMisc (Item);
 *
 *=========================================================================*/
void DefaultMwRandItemMisc (mwri_item_t& Item) {
 }
/*===========================================================================
 *		End of Function DefaultMwRandItemMisc()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void DefaultMwRandItemWeapon (Item);
 *
 *=========================================================================*/
void DefaultMwRandItemWeapon (mwri_item_t& Item) {
  Item.Weapon.Condition = 100;
  Item.Weapon.MinChop   = 1;
  Item.Weapon.MinSlash  = 1;
  Item.Weapon.MinThrust = 1;
  Item.Weapon.MaxChop   = 5;
  Item.Weapon.MaxSlash  = 5;
  Item.Weapon.MaxThrust = 5;
  Item.Weapon.Speed     = 1.0f;
  Item.Weapon.Reach     = 1.0f;
  Item.Weapon.Type      = 0;
  Item.Weapon.IgnoreResist = false;
 }
/*===========================================================================
 *		End of Function DefaultMwRandItemWeapon()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const TCHAR* GetMWRandItemBodyPart (Index);
 *
 * Return a body part string. Returns NULL on any error.
 *
 *=========================================================================*/
const TCHAR* GetMWRandItemBodyPart (const int Index) {
  return FindValueName(l_MwItemBipeds, Index);
 }
/*===========================================================================
 *		End of Function TCHAR* GetMWRandItemBodyPart()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - long ShortStringToMwRandItemMask (pString);
 *
 *=========================================================================*/
long ShortStringToMwRandItemMask (const TCHAR* pString) {
  long Mask = 0;
  if (pString == NULL) return (0);

  while (*pString != NULL_CHAR) {
    switch (toupper(*pString)) {
	case 'A': Mask |= MWRI_ITEMMASK_ARMOR; break;
	case 'W': Mask |= MWRI_ITEMMASK_WEAPON; break;
	case 'C': Mask |= MWRI_ITEMMASK_CLOTHING; break;
	case 'M': Mask |= MWRI_ITEMMASK_MISC; break;
	case '*': Mask |= MWRI_ITEMMASK_ALL; break;
	default: SystemLog.Printf ("\t     : Unknown item mask character '%c'!", *pString); break;
     }

    pString++;
   } 

  return (Mask);
 }
/*===========================================================================
 *		End of Function ShortStringToMwRandItemMask()
 *=========================================================================*/

  
/*===========================================================================
 *
 * Function - int StringToMwRandItemMask (pString);
 *
 * Converts the input string to an item mask and vice-versa.
 *
 *=========================================================================*/
int StringToMwRandItemMask (const TCHAR* pString) {
  return FindNameValue(l_MwItemMasks, pString);
 }

const TCHAR* MwRandItemMaskToString (const long ItemMask) {
  return FindValueName(l_MwItemMasks, ItemMask);
 }

const TCHAR* MwRandItemMaskToShortString (const long ItemMask) {
  static TCHAR s_Buffer[16];

  s_Buffer[0] = NULL_CHAR;
  if ((ItemMask & MWRI_ITEMMASK_WEAPON)   != 0) chrcat(s_Buffer, 'W');
  if ((ItemMask & MWRI_ITEMMASK_MISC)     != 0) chrcat(s_Buffer, 'M');
  if ((ItemMask & MWRI_ITEMMASK_ARMOR)    != 0) chrcat(s_Buffer, 'A');
  if ((ItemMask & MWRI_ITEMMASK_CLOTHING) != 0) chrcat(s_Buffer, 'C');

  return (s_Buffer);
 }
/*===========================================================================
 *		End of Function StringToMwRandItemMask()
 *=========================================================================*/
