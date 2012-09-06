/*===========================================================================
 *
 * File:	Mwrandeffects.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Friday, May 23, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "mwrandeffects.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("MwRandEffects.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Value String Arrays
 *
 *=========================================================================*/
valuenames_t l_MwEffectTypes[] = {
	{ MWRE_EFFECT_NONE,		_T("None") },
	{ MWRE_EFFECT_ENCHANT,		_T("Enchant") },
	{ MWRE_EFFECT_WEIGHT,		_T("Weight") },
	{ MWRE_EFFECT_DAMAGE,		_T("Damage") },
	{ MWRE_EFFECT_MAXDAMAGE,	_T("MaxDamage") },
	{ MWRE_EFFECT_MINDAMAGE,	_T("MinDamage") },
	{ MWRE_EFFECT_REACH,		_T("Reach") },
	{ MWRE_EFFECT_SPEED,		_T("Speed") },
	{ MWRE_EFFECT_CONDITION,	_T("Condition") },
	{ MWRE_EFFECT_CONDITION,	_T("Health") },
	{ MWRE_EFFECT_ARMOR,		_T("Armor") },
	{ MWRE_EFFECT_ARMOR,		_T("AC") },
	{ MWRE_EFFECT_ENCHANTPTS,	_T("EnchantPts") },
	{ MWRE_EFFECT_SPELL,		_T("Spell") },
	{ -1,				NULL } /* Must be last entry */
 };
/*===========================================================================
 *		End of Value String Arrays
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandEffects Constructor
 *
 *=========================================================================*/
CMwRandEffects::CMwRandEffects () : m_Suffixes(0), m_Prefixes(0) {
  //DEFINE_FUNCTION("CMwRandEffects::CMwRandEffects()");
  m_InputLine = 0;
 }
/*===========================================================================
 *		End of Class CMwRandEffects Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandEffects Method - void Destroy (void);
 *
 *=========================================================================*/
void CMwRandEffects::Destroy (void) {
  DEFINE_FUNCTION("CMwRandEffects::Destroy()");
  mwrand_effect_t* pEffect;
  int		   Index;

	/* Delete all prefix records */
  for (Index = 0; Index < (int)m_Prefixes.GetNumElements(); Index++) {
    pEffect = m_Prefixes.GetAt(Index);
    DestroyPointer(pEffect);
   }

	/* Delete all suffix records */
  for (Index = 0; Index < (int)m_Suffixes.GetNumElements(); Index++) {
    pEffect = m_Suffixes.GetAt(Index);
    DestroyPointer(pEffect);
   }

	/* Clear the arrays */
  m_Prefixes.RemoveAll();
  m_Suffixes.RemoveAll();

  m_InputLine = 0;
 }
/*===========================================================================
 *		End of Class Method CMwRandEffects::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandEffects Method - mwrand_effect_t* FindEffect (pName);
 *
 * Searches the suffix and prefix arrays for an effect with the matching 
 * name (not case sensitive). Returns NULL on any error.
 *
 *=========================================================================*/
mwrand_effect_t* CMwRandEffects::FindEffect (const TCHAR* pName) {
  mwrand_effect_t* pEffect;
  int		   Index;

	/* Ignore invalid input */
  if (pName == NULL) return (NULL);

	/* Search the prefix array */
  for (Index = 0; Index < (int)m_Prefixes.GetNumElements(); Index++) {
    pEffect = m_Prefixes.GetAt(Index);
    if (TSTRICMP(pEffect->Name, pName) == 0) return (pEffect);
   }

	/* Search the suffix array */
  for (Index = 0; Index < (int)m_Suffixes.GetNumElements(); Index++) {
    pEffect = m_Suffixes.GetAt(Index);
    if (TSTRICMP(pEffect->Name, pName) == 0) return (pEffect);
   }
 
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CMwRandEffects::FindEffect()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandEffects Method - bool ReadEffect (File, pNewEffect);
 *
 * Inputs a new record from the current position in the given file, storing
 * the data in the given object. Protected class method. Returns false on
 * any error.
 *
 *=========================================================================*/
bool CMwRandEffects::ReadEffect (CGenFile& File, mwrand_effect_t* pNewEffect) {
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
		/* Input an enchantment section */
    else if (TSTRICMP(pVariable, _T("Enchant")) == 0) {
      Result = ReadEnchant(File, pNewEffect);
      if (!Result) return (false);
     }
    else if (ParseResult) {
      Result = SetEffectParam(pNewEffect, pVariable, pValue);
      if (!Result) return (false);
     }
    
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandEffects::ReadEffect()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandEffects Method - bool ReadEffectFile (pFilename);
 *
 * Attempts to input effect data from the given file. Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandEffects::ReadEffectFile (const TCHAR* pFilename) {
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

		/* Start of effect sections */
    if (TSTRICMP(pVariable, _T("Suffix")) == 0) {
      Result = ReadSuffix(File);
      if (!Result) return (false);
     }
    else if (TSTRICMP(pVariable, _T("Prefix")) == 0) {
      Result = ReadPrefix(File);
      if (!Result) return (false);
     }
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandEffects::ReadEffectFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandEffects Method - bool ReadEnchant (File, pNewEffect);
 *
 * Protected class method to input an enchantment block starting at the
 * current position in the given file. Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandEffects::ReadEnchant(CGenFile& File, mwrand_effect_t* pNewEffect) {
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
		/* Input an effect section */
    else if (TSTRICMP(pVariable, _T("Effect")) == 0) {

		/* Ensure we don't exceed the effect array size */
      if (pNewEffect->Enchantment.NumEffects < MWRE_MAX_EFFECTS) {
        DefaultMwRandEnchEffect(pNewEffect->Enchantment.Effects[pNewEffect->Enchantment.NumEffects]);
	pNewEffect->Enchantment.NumEffects++;	  
        Result = ReadEnchantEffect(File, pNewEffect);
	if (!Result) return (false);
       }
      else {
        ErrorHandler.AddError(ERR_MAXINDEX, _T("Exceeded the effect array size of %d!"), MWRE_MAX_EFFECTS);
        return (false);
       }
     }
    else if (ParseResult) {
      Result = SetEnchantParam(pNewEffect, pVariable, pValue);
      if (!Result) return (false);
     }
    
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandEffects::ReadEnchant()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandEffects Method - bool ReadEnchantEffect (File, pNewEffect);
 *
 * Protected class method to input an effect enchantment block starting at the
 * current position in the given file. Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandEffects::ReadEnchantEffect(CGenFile& File, mwrand_effect_t* pNewEffect) {
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
      Result = SetEnchantEffectParam(pNewEffect, pVariable, pValue);
      if (!Result) return (false);
     }
    
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandEffects::ReadEnchantEffect()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandEffects Method - bool ReadPrefix (File);
 *
 * Input effect data from the current position in the given file. Protected
 * class method. Assumes that the 'Prefix' line has already been input.
 * Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandEffects::ReadPrefix (CGenFile& File) {
  DEFINE_FUNCTION("CMwRandEffects::ReadPrefix()");
  mwrand_effect_t* pNewPrefix;

	/* Create and initialize the new effect object */
  CreatePointer(pNewPrefix, mwrand_effect_t);
  m_Prefixes.Add(pNewPrefix);
  DefaultMwRandEffect(*pNewPrefix);

  return ReadEffect(File, pNewPrefix);
 }
/*===========================================================================
 *		End of Class Method CMwRandEffects::ReadPrefix()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandEffects Method - bool ReadSuffix (File);
 *
 * Input effect data from the current position in the given file. Protected
 * class method. Assumes that the 'Suffix' line has already been input.
 * Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandEffects::ReadSuffix (CGenFile& File) {
  DEFINE_FUNCTION("CMwRandEffects::ReadSuffix()");
  mwrand_effect_t* pNewSuffix;

	/* Create and initialize the new effect object */
  CreatePointer(pNewSuffix, mwrand_effect_t);
  m_Suffixes.Add(pNewSuffix);
  DefaultMwRandEffect(*pNewSuffix);

  return ReadEffect(File, pNewSuffix);
 }
/*===========================================================================
 *		End of Class Method CMwRandEffects::ReadSuffix()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandEffects Method - bool SetEffectParam (pNewEffect, pVariable, pValue);
 *
 * Sets the input effect parameter according to the value of the variable
 * and value strings. Returns false on any error. Protected class method.
 *
 *=========================================================================*/
bool CMwRandEffects::SetEffectParam (mwrand_effect_t* pNewEffect, const TCHAR* pVariable, 
				     const TCHAR* pValue) {
  bool Result;

  if (TSTRICMP(pVariable, _T("Name")) == 0) {
    strnncpy(pNewEffect->Name, pValue, MWRI_MAX_NAMESIZE);
   }
  else if (TSTRICMP(pVariable, _T("Cursed")) == 0) {
    Result = StringToBoolean(pNewEffect->Cursed, pValue);
    if (!Result) SystemLog.Printf ("\t%5ld: Unknown boolean value '%s'!", m_InputLine, pValue);
   }
  else if (TSTRICMP(pVariable, _T("EffectType")) == 0) {
    Result = StringToMwRandEffectType(pNewEffect->EffectType, pValue);
    pNewEffect->EffectMask = FindNameValue(l_MwEffectMasks, pValue);
    if (!Result) SystemLog.Printf ("\t%5ld: Unknown effect type '%s'!", m_InputLine, pValue);
   }
  else if (TSTRICMP(pVariable, _T("ItemLevel")) == 0) {
    pNewEffect->ItemLevel = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("ItemMask")) == 0) {
    pNewEffect->ItemMask = ShortStringToMwRandItemMask(pValue);
   }
  else if (TSTRICMP(pVariable, _T("MinEffect")) == 0) {
    pNewEffect->MinEffect = (float) atof(pValue);
   }
  else if (TSTRICMP(pVariable, _T("MaxEffect")) == 0) {
    pNewEffect->MaxEffect = (float) atof(pValue);
   }
  else if (TSTRICMP(pVariable, _T("MinQuality")) == 0) {
    pNewEffect->MinQuality = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("MaxQuality")) == 0) {
    pNewEffect->MaxQuality = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("Multiplier")) == 0) {
    pNewEffect->Multiplier = atoi(pValue);
   }
  else {
    SystemLog.Printf ("\t%5ld: Unknown effect variable '%s'!", m_InputLine, pValue);
   }

  return (true);				       
 }
/*===========================================================================
 *		End of Class Method CMwRandEffects::SetEffectParam()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandEffects Method - bool SetEnchantParam (pNewEffect, pVariable, pValue);
 *
 * Sets the input enchantment parameter according to the value of the variable
 * and value strings. Returns false on any error. Protected class method.
 *
 *=========================================================================*/
bool CMwRandEffects::SetEnchantParam (mwrand_effect_t* pNewEffect, const TCHAR* pVariable, 
				      const TCHAR* pValue) {
  bool Result;

  if (TSTRICMP(pVariable, _T("Charge1")) == 0 || TSTRICMP(pVariable, _T("Uses1")) == 0) {
    pNewEffect->Enchantment.Charge1 = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("Charge2")) == 0 || TSTRICMP(pVariable, _T("Uses2")) == 0) {
    pNewEffect->Enchantment.Charge2 = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("EnchantCost1")) == 0) {
    pNewEffect->Enchantment.EnchantCost1 = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("EnchantCost2")) == 0) {
    pNewEffect->Enchantment.EnchantCost2 = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("EnchantType")) == 0) {
    Result = GetESMEnchantType(pNewEffect->Enchantment.EnchantType, pValue);
    pNewEffect->Enchantment.EnchantMask = FindNameValue(l_MwEnchantMasks, pValue);
    if (!Result) SystemLog.Printf ("\t%05ld: Unknown enchant type '%s'!", m_InputLine, pValue);
   }
  else if (TSTRICMP(pVariable, _T("AutoCalc")) == 0) {
    Result = StringToBoolean(pNewEffect->Enchantment.AutoCalc, pValue);
    if (!Result) SystemLog.Printf ("\t%05ld: Unknown boolean value '%s'!", m_InputLine, pValue);
   }
  else {
    SystemLog.Printf ("\t%05ld: Unknown enchantment variable '%s'!", m_InputLine, pValue);
   }

  return (true);				       
 }
/*===========================================================================
 *		End of Class Method CMwRandEffects::SetEnchantParam()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandEffects Method - bool SetEnchantEffectParam (pNewEffect, pVariable, pValue);
 *
 * Sets the input enchantment effect parameter according to the value 
 * of the variable and value strings. Returns false on any error. 
 * Protected class method.
 *
 *=========================================================================*/
bool CMwRandEffects::SetEnchantEffectParam (mwrand_effect_t* pNewEffect,
					    const TCHAR* pVariable, 
				            const TCHAR* pValue) {
  int  EffectIndex;
  bool Result;
  int  iResult;

	/* Ensure a valid effect index */
  EffectIndex = pNewEffect->Enchantment.NumEffects - 1;
  if (EffectIndex < 0 || EffectIndex >= MWRE_MAX_EFFECTS) return (false);

  if (TSTRICMP(pVariable, _T("EffectID")) == 0) {
    Result = GetESMEffectID(iResult, pValue);

    if (!Result)
      SystemLog.Printf ("\t%05ld: Unknown effect ID '%s'!", m_InputLine, pValue);
    else
      pNewEffect->Enchantment.Effects[EffectIndex].EffectID = iResult;
   }
  else if (TSTRICMP(pVariable, _T("SkillID")) == 0) {
    Result = GetESMSkill(iResult, pValue);

    if (!Result) 
      SystemLog.Printf ("\t%05ld: Unknown skill ID '%s'!", m_InputLine, pValue);
    else
      pNewEffect->Enchantment.Effects[EffectIndex].SkillID = iResult;
   }
  else if (TSTRICMP(pVariable, _T("AttributeID")) == 0) {
    Result = GetESMAttribute(iResult, pValue);

    if (!Result)
      SystemLog.Printf ("\t%05ld: Unknown atribute ID '%s'!", m_InputLine, pValue);
    else
      pNewEffect->Enchantment.Effects[EffectIndex].AttributeID = iResult;
   }
  else if (TSTRICMP(pVariable, _T("RangeType")) == 0) {
    Result = GetESMEnchantRangeType(iResult, pValue);

    if (!Result) 
      SystemLog.Printf ("\t%05ld: Unknown enchant range type '%s'!", m_InputLine, pValue);
    else
      pNewEffect->Enchantment.Effects[EffectIndex].RangeType = iResult;
   }
  else if (TSTRICMP(pVariable, _T("Area1")) == 0) {
    pNewEffect->Enchantment.Effects[EffectIndex].Area1 = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("Area2")) == 0) {
    pNewEffect->Enchantment.Effects[EffectIndex].Area2 = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("Duration1")) == 0) {
    pNewEffect->Enchantment.Effects[EffectIndex].Duration1 = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("Duration2")) == 0) {
    pNewEffect->Enchantment.Effects[EffectIndex].Duration2 = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("MagMin1")) == 0) {
    pNewEffect->Enchantment.Effects[EffectIndex].MagMin1 = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("MagMin2")) == 0) {
    pNewEffect->Enchantment.Effects[EffectIndex].MagMin2 = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("MagMax1")) == 0) {
    pNewEffect->Enchantment.Effects[EffectIndex].MagMax1 = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("MagMax2")) == 0) {
    pNewEffect->Enchantment.Effects[EffectIndex].MagMax2 = atoi(pValue);
   }
  else {
    SystemLog.Printf ("\t%05ld: Unknown enchantment effect variable '%s'!", m_InputLine, pValue);
   }
 
  return (true);				       
 }
/*===========================================================================
 *		End of Class Method CMwRandEffects::SetEnchantEffectParam()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void DefaultMwRandEffect (Effect);
 *
 *=========================================================================*/
void DefaultMwRandEffect (mwrand_effect_t& Effect) {
  Effect.Cursed     = false;
  Effect.EffectType = MWRE_EFFECT_NONE;
  DefaultMwRandEnchant(Effect.Enchantment);
  Effect.ItemLevel = 1;
  Effect.ItemMask  = MWRI_ITEMMASK_ALL;
  Effect.MinEffect = 1;
  Effect.MaxEffect = 10;
  Effect.MinQuality = 10;
  Effect.MaxQuality = 100;
  Effect.Multiplier = 1;
  Effect.Name[0] = NULL_CHAR;
  Effect.EffectMask = 0;
 }
/*===========================================================================
 *		End of Function DefaultMwRandEffect()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void DefaultMwRandEnchant (Enchant);
 *
 *=========================================================================*/
void DefaultMwRandEnchant (mwrand_enchant_t& Enchant) {
  Enchant.NumEffects = 0;
  Enchant.Charge1 = 100;
  Enchant.Charge2 = 100;
  Enchant.EnchantCost1 = 10;
  Enchant.EnchantCost2 = 10;
  Enchant.EnchantType = 0;
  Enchant.EnchantMask = 0;
  Enchant.AutoCalc = false;
 }
/*===========================================================================
 *		End of Function DefaultMwRandEnchant()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void DefaultMwRandEnchEffect (EnchEffect);
 *
 *=========================================================================*/
void DefaultMwRandEnchEffect (mwrand_encheff_t& EnchEffect) {
  EnchEffect.Area1 = 0;
  EnchEffect.Area2 = 0;
  EnchEffect.Duration1 = 10;
  EnchEffect.Duration2 = 10;
  EnchEffect.RangeType = 0;
  EnchEffect.MagMin1 = 1;
  EnchEffect.MagMin2 = 1;
  EnchEffect.MagMax1 = 5;
  EnchEffect.MagMax2 = 5;
  EnchEffect.AttributeID = -1;
  EnchEffect.SkillID     = -1;
  EnchEffect.EffectID    = 0;
 }
/*===========================================================================
 *		End of Function DefaultMwRandEnchEffect()
 *=========================================================================*/

  
/*===========================================================================
 *
 * Function - int StringToMwRandEffectType (pString);
 *
 * Converts the input string to an effect type.
 *
 *=========================================================================*/
bool StringToMwRandEffectType (int& OutType, const TCHAR* pString) {
  int Index = FindNameValue(l_MwEffectTypes, pString);
  if (Index < -1) return (false);
  OutType = Index;
  return (true);
 }


int StringToMwRandEffectType (const TCHAR* pString) {
  int Index = FindNameValue(l_MwEffectTypes, pString);
  if (Index < 0) return (MWRE_EFFECT_NONE);
  return (Index);
 }
/*===========================================================================
 *		End of Function StringToMwRandEffectType()
 *=========================================================================*/

