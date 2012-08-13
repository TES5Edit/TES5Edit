/*===========================================================================
 *
 * File:		Srrecordfilter.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srrecordfilter.h"


/*===========================================================================
 *
 * Class CSrRecordFilter Constructor
 *
 *=========================================================================*/
CSrRecordFilter::CSrRecordFilter () {
 
  m_pParent      = NULL;

  m_FilterMask   = 0;
  m_Flags        = 0;
  m_BodyCompare  = SR_RECFILTER_BODY_EQUAL;
  m_BodyParts    = 0;
  m_ArmorType    = 0;
  m_UserData     = 0;
  m_EnchantType  = 0;
  m_ScriptType   = 0;
  m_SpellType    = 0;
  m_SpellLevel   = 0;
  m_RecordCount  = 0;
 }
/*===========================================================================
 *		End of Class CSrRecordFilter Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordFilter Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrRecordFilter::Destroy (void) {

  m_ID.Empty();
  m_Material.Empty();
  m_WeaponType.Empty();
  m_NameFilter.Empty();
  m_ParentName.Empty();
  m_DisplayName.Empty();

  m_FieldFilters.Destroy();

  m_RecordType   = SR_NAME_NULL;
  m_FilterMask   = 0;
  m_Flags        = 0;
  m_BodyCompare  = SR_RECFILTER_BODY_EQUAL;
  m_BodyParts    = 0;
  m_ArmorType    = 0;
  m_UserData     = 0;
  m_EnchantType  = 0;
  m_ScriptType   = 0;
  m_SpellType    = 0;
  m_SpellLevel   = 0;
  m_RecordCount  = 0;
}
/*===========================================================================
 *		End of Class Method CSrRecordFilter::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordFilter Method - bool CheckRecord (pRecord, const srfilterextra_t ExtraFilter);
 *
 * Checks if the given record matches the filter. Returns true if it does.
 *
 *=========================================================================*/
bool CSrRecordFilter::CheckRecord (CSrRecord* pRecord, const srfilterextra_t ExtraFilter) 
{
  CSrWeapRecord*  pWeapon;
  CSrArmoRecord*  pArmor;
  CSrItem1Record* pItem1 = NULL;
  dword			  BodyFlags;
  bool		  	  Result;

	/* Ignore invalid input */
  if (pRecord == NULL) return (false);
  if (IsFlagEmpty())   return (false);

	/* Check active record if required */
  if (ExtraFilter.ActiveOnly && !pRecord->IsActive()) return false;

	/* Do the record types match? */
  if (IsMaskRecordType()) 
  {
    if (pRecord->GetRecordType() != m_RecordType) return (false);
  }

	/* Do the item names match? */
  if (IsMaskItemName()) 
  {
    pItem1 = SrCastClass(CSrItem1Record, pRecord);
    if (pItem1 == NULL) return (false);
    if (strnicmp(m_NameFilter, pItem1->GetItemName(), m_NameFilter.GetLength()) != 0) return (false);
  }

	/* Do the materials names match? */
  if (IsMaskMaterial()) 
  {
	  pWeapon = SrCastClass(CSrWeapRecord, pRecord);

	  if (pWeapon != NULL)
	  {
		  if (m_Material.CompareNoCase(pWeapon->GetWeaponMaterial())) return (false);
	  }

      if (pItem1 == NULL) return (false);

      if (stristr(pItem1->GetItemName(), m_Material) == NULL) 
	  {
		if (stristr(m_NameFilter, pItem1->GetModel()) == NULL) return (false);
      }
   }

	/* Do the weapon types match? */
  if (IsMaskWeaponType()) {
    pWeapon = SrCastClass(CSrWeapRecord, pRecord);
    if (pWeapon == NULL) return (false);
	if (m_WeaponType.CompareNoCase(pWeapon->GetWeaponType())) return (false);
   }

	/* Do the armor types match? */
  if (IsMaskArmorType()) 
  {
	  //TODO
  }

   	/* Do the script types match? */
  if (IsMaskScriptType()) 
  {
  	  //TODO
  }

   	/* Do the enchant types match? */
  if (IsMaskEnchantType()) 
  {
  	  //TODO
  }

	/* Do the spell types match? */
  if (IsMaskSpellType()) 
  {
   	  //TODO
  }

	/* Do the spell levels match? */
  if (IsMaskSpellLevel()) 
  {
	  	  //TODO
  }
   
   	/* Do the biped parts match? */
  if (IsMaskBodyParts()) {
    if (pRecord->GetRecordType() == SR_NAME_ARMO) 
	{
      pArmor = SrCastClass(CSrArmoRecord, pRecord);
      if (pArmor == NULL) return (false);
      BodyFlags = pArmor->GetBodyFlags();
    }
    else 
	{
      return (false);
    }

    switch (m_BodyCompare) 
	{
      case SR_RECFILTER_BODY_AND:
		if ((BodyFlags & m_BodyParts) != m_BodyParts) return (false);
		break;
      case SR_RECFILTER_BODY_OR:
		if ((BodyFlags & m_BodyParts) == 0) return (false);
		break;
      case SR_RECFILTER_BODY_EQUAL:
      default:
		if (BodyFlags != m_BodyParts) return (false);
		break;
    }

  }

	/* Check all field filters */
  Result = CheckFieldRecord(pRecord);
  if (!Result) return (false);

	/* Check text filters if required */
  if (!ExtraFilter.FilterText.IsEmpty())
  {
	  CSrIdRecord* pIDRecord = SrCastClassNull(CSrIdRecord, pRecord);

	  if (pIDRecord == NULL)
	  {
		  CSrSubrecord* pEdid = pRecord->FindSubrecord(SR_NAME_EDID);
		  if (pEdid == NULL || pEdid->GetData() == NULL) return false;
		  if (stristr((const char *) pEdid->GetData(), ExtraFilter.FilterText.c_str()) == NULL) return false;
	  }

	  if (stristr(pIDRecord->GetEditorID(), ExtraFilter.FilterText.c_str()) == NULL) return false;
  }

	/* Record matches all filter criteria */
  return true;
}
/*===========================================================================
 *		End of Class Method CSrRecordFilter::CheckRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordFilter Method - bool CheckFieldRecord (pRecord);
 *
 * Helper class for checking if the given record matches any field filters.
 *
 *=========================================================================*/
bool CSrRecordFilter::CheckFieldRecord (CSrRecord* pRecord) {
  dword Index;
  bool  Result;

  for (Index = 0; Index < m_FieldFilters.GetSize(); ++Index) {
    Result = CheckFieldRecord(*m_FieldFilters.GetAt(Index), pRecord);
    if (!Result) return (false);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecordFilter::CheckFieldRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordFilter Method - bool CheckFieldRecord (Filter, pRecord);
 *
 *=========================================================================*/
bool CSrRecordFilter::CheckFieldRecord (srfilterfield_t& Filter, CSrRecord* pRecord) {
  CSString Buffer;
  bool     Result;
  bool     CaseSensitive = ((Filter.Flags & SR_RECFILTER_FIELDFLAG_CASESENSITIVE) != 0);

	/* Ignore a NULL field */
  if (Filter.FieldID == 0) return (true);
  //SystemLog.Printf("Checking field filter %d, %s...", Filter.FieldID, Filter.Value.c_str());

  Result = pRecord->GetField(Buffer, Filter.FieldID);

  if (!Result) {
	/* Do nothing */
  }
  else if ((Filter.Flags & SR_RECFILTER_FIELDFLAG_EXACT) != 0) {
    Result = SafeStringCompare(Buffer, Filter.Value, !CaseSensitive) == 0;
  }
  else if ((Filter.Flags & SR_RECFILTER_FIELDFLAG_CONTAINS) != 0) {
    if (CaseSensitive)
      Result = strstr(Buffer, Filter.Value) != NULL;
    else
      Result = stristr(Buffer, Filter.Value) != NULL;
  }
  else if ((Filter.Flags & SR_RECFILTER_FIELDFLAG_STARTS) != 0) {
    if (CaseSensitive)
      Result = strncmp(Buffer, Filter.Value, Filter.Value.GetLength()) == 0;
    else
      Result = strnicmp(Buffer, Filter.Value, Filter.Value.GetLength()) == 0;
  }

  if ((Filter.Flags & SR_RECFILTER_FIELDFLAG_EXCLUDE) != 0) return (!Result);
  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrRecordFilter::CheckFieldRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordFilter Method - dword CountMatchingRecords (File, ExtraFilter);
 *
 * Counts and returns the number of matching records in the given file.
 *
 *=========================================================================*/
dword CSrRecordFilter::CountMatchingRecords (CSrEspFile& File, const srfilterextra_t ExtraFilter) 
{
	return CountMatchingRecords(&File.GetRecords(), ExtraFilter);
}
/*===========================================================================
 *		End of Class Method CSrRecordFilter::CountMatchingRecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordFilter Method - dword CountMatchingRecords (pTopGroup, ExtraFilter);
 *
 * Counts and returns the number of matching records in the given file.
 *
 *=========================================================================*/
dword CSrRecordFilter::CountMatchingRecords (CSrGroup* pTopGroup, const srfilterextra_t ExtraFilter) 
{
  CSrTypeGroup*  pGroup;
  CSrBaseRecord* pBaseRecord;
  CSrRecord*     pRecord;
  dword          Count = 0;
  dword			 Index;

	/* Easy answer for an empty filter */
  if (IsFlagEmpty()) return (0);
  if (!IsMaskRecordType()) return (0);
  if (m_RecordType == SR_NAME_NULL) return (0);
  if (pTopGroup == NULL) return (0);

	/* Try and retrieve the group for the given record type */
  pGroup = pTopGroup->GetTypeGroup(m_RecordType);
  if (pGroup == NULL) return (0);

	/* Very quick result for simple filters */
  if (m_FilterMask == SR_RECFILTER_MASK_RECORDTYPE && !ExtraFilter.ActiveOnly && ExtraFilter.FilterText.IsEmpty()) 
  {
    return pGroup->GetNumRecords();
  }

  for (Index = 0; Index < pGroup->GetNumRecords(); ++Index) {
    pBaseRecord = pGroup->GetRecord(Index);
    pRecord     = SrCastClass(CSrRecord, pBaseRecord);
    if (pRecord == NULL) continue;

    if (CheckRecord(pRecord, ExtraFilter)) ++Count;
   }

  return (Count);
 }
/*===========================================================================
 *		End of Class Method CSrRecordFilter::CountMatchingRecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordFilter Method - bool SetParameter (pVariable, pValue);
 *
 * Sets a class parameter from the given string pair. Returns false if 
 * the input is invalid.
 *
 *=========================================================================*/
bool CSrRecordFilter::SetParameter (const SSCHAR* pVariable, const SSCHAR* pValue) {
  bool Result;
  bool Flag;

  if (stricmp(pVariable, "RecName") == 0 || stricmp(pVariable, "RecordName") == 0 ||
      stricmp(pVariable, "RecType") == 0 || stricmp(pVariable, "RecordType") == 0) {
    m_RecordType = pValue;
    m_FilterMask |= SR_RECFILTER_MASK_RECORDTYPE;
   }
  else if (stricmp(pVariable, "ID") == 0) {
    m_ID = pValue;
    if (m_DisplayName.IsEmpty()) m_DisplayName = pValue;
   }
  else if (stricmp(pVariable, "DisplayName") == 0) {
    m_DisplayName = pValue;
    if (m_ID.IsEmpty()) m_ID = pValue;
   }
  else if (stricmp(pVariable, "NameFilter") == 0) {
    m_NameFilter = pValue;
    m_FilterMask |= SR_RECFILTER_MASK_ITEMNAME;
   }
  else if (stricmp(pVariable, "Material") == 0) {
    m_Material = pValue;
    m_FilterMask |= SR_RECFILTER_MASK_MATERIAL;
   }
  else if (stricmp(pVariable, "Parent") == 0) {
    
    if (stricmp(pValue, "NULL") == 0) {
      m_ParentName.Empty();
      m_pParent = NULL;
     }
    else {
      m_ParentName = pValue;
     }
   }
  else if (stricmp(pVariable, "Empty") == 0) {
    Result = StringToBoolean(Flag, pValue);
    if (!Result) AddSrGeneralError("Invalid boolean value '%s'!", pValue);
    SetEmpty(Flag);
   }
  else if (stricmp(pVariable, "ArmorType") == 0) {

    if (stricmp(pValue, "Light") == 0)
      m_ArmorType = 0;
    else if (stricmp(pValue, "Heavy") == 0)
      m_ArmorType = 1;
    else {
      AddSrGeneralError("Invalid armor type '%s'!", pValue);    
     }

    m_FilterMask |= SR_RECFILTER_MASK_ARMORTYPE;
   }
  else if (stricmp(pVariable, "ScriptType") == 0) {
	  /*
    Result = GetObScriptTypeValue(m_ScriptType, pValue);

    if (!Result) 
      AddSrGeneralError("Invalid script type value '%s'!", pValue);
    else
      m_FilterMask |= SR_RECFILTER_MASK_SCRIPTTYPE; */
   }
  else if (stricmp(pVariable, "EnchantType") == 0) {
	  /*
    Result = GetObEnchantTypeValue(m_EnchantType, pValue);

    if (!Result) 
      AddSrGeneralError("Invalid enchantment type value '%s'!", pValue);
    else
      m_FilterMask |= SR_RECFILTER_MASK_ENCHANTTYPE; */
   }
 else if (stricmp(pVariable, "SpellType") == 0) {
    /*
	Result = GetObSpellTypeValue(m_EnchantType, pValue);

    if (!Result) 
      AddSrGeneralError("Invalid spell type value '%s'!", pValue);
    else
      m_FilterMask |= SR_RECFILTER_MASK_SPELLTYPE;
	  */
   }
  else if (stricmp(pVariable, "SpellLevel") == 0) {
	/*
    Result = GetObSpellLevelValue(m_SpellLevel, pValue);

    if (!Result) 
      AddSrGeneralError("Invalid spell level value '%s'!", pValue);
    else
      m_FilterMask |= SR_RECFILTER_MASK_SPELLLEVEL;
	  */
   }
  else if (stricmp(pVariable, "WeaponType") == 0) 
  {
    m_WeaponType = pValue;
    m_FilterMask |= SR_RECFILTER_MASK_WEAPONTYPE;
  }
  else if (stricmp(pVariable, "BodyParts") == 0) 
  {
     GetSrBodyPartFlagValue(m_BodyParts, pValue);
     m_FilterMask |= SR_RECFILTER_MASK_BODYPARTS;
  }
  else if (stricmp(pVariable, "BodyCompare") == 0) 
  {

    if (stricmp(pValue, "AND") == 0)
      m_BodyCompare = SR_RECFILTER_BODY_AND;
    else if (stricmp(pValue, "OR") == 0)
      m_BodyCompare = SR_RECFILTER_BODY_OR;
    else if (stricmp(pValue, "Equal") == 0)
      m_BodyCompare = SR_RECFILTER_BODY_EQUAL;
    else
      AddSrGeneralError("Invalid body compare type '%s'!", pValue);

  }
  else if (stricmp(pVariable, "Field") == 0 || stricmp(pVariable, "FieldExact") == 0) {
    AddFieldFilter(pValue, SR_RECFILTER_FIELDFLAG_EXACT);
  }
  else if (stricmp(pVariable, "FieldStarts") == 0) {
     AddFieldFilter(pValue, SR_RECFILTER_FIELDFLAG_STARTS);
  }
  else if (stricmp(pVariable, "FieldContains") == 0) {
     AddFieldFilter(pValue, SR_RECFILTER_FIELDFLAG_CONTAINS);
  }
  else if (stricmp(pVariable, "FieldNot") == 0 || stricmp(pVariable, "FieldExactNot") == 0) {
    AddFieldFilter(pValue, SR_RECFILTER_FIELDFLAG_EXACT | SR_RECFILTER_FIELDFLAG_EXCLUDE);
  }
  else if (stricmp(pVariable, "FieldStartsNot") == 0) {
     AddFieldFilter(pValue, SR_RECFILTER_FIELDFLAG_STARTS | SR_RECFILTER_FIELDFLAG_EXCLUDE);
  }
  else if (stricmp(pVariable, "FieldContainsNot") == 0) {
     AddFieldFilter(pValue, SR_RECFILTER_FIELDFLAG_CONTAINS | SR_RECFILTER_FIELDFLAG_EXCLUDE);
  }
  else {
    AddSrGeneralError("Unknown filter variable '%s'!", pVariable);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecordFilter::SetParameter()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordFilter Method - bool AddFieldFilter (pValue, Flags);
 *
 *=========================================================================*/
bool CSrRecordFilter::AddFieldFilter (const char* pValue, const dword Flags) {
  CSString			Buffer(pValue);
  CSString			Field;
  CSString			Value;
  srfilterfield_t*	pNewFilter;
  bool				Result;
  int				FieldID;

	/* Parse the input string */
  Result = Buffer.SeperateVarValue(Field, Value, ',', 0);
  if (!Result) return AddSrGeneralError("No value set for field '%s'!", pValue);

	/* Find the field */
  Result = GetSrFieldValue(FieldID, Field);
  if (!Result) return AddSrGeneralError("Unknown field '%s' found!", Field.c_str());
  
	/* Add a new field */
  pNewFilter = new srfilterfield_t;
  m_FieldFilters.Add(pNewFilter);

  pNewFilter->FieldID = FieldID;
  pNewFilter->Flags   = Flags;
  pNewFilter->Value   = Value;

  m_FilterMask |= SR_RECFILTER_MASK_FIELDS;
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecordFilter::AddFieldFilter()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - CSrRecordFilter* FindObRecordFilter (pID, Filters);
 *
 * Find a filter in the given array by its ID. Returns NULL if
 * is is not found.
 *
 *=========================================================================*/
CSrRecordFilter* FindObRecordFilter (const SSCHAR* pID, CSrRecFilterArray& Filters) {
  CSrRecordFilter* pFilter;
  dword		   Index;

  for (Index = 0; Index < Filters.GetSize(); ++Index) {
    pFilter = Filters[Index];
    if (stricmp(pFilter->GetID(), pID) == 0) return (pFilter);
   }

  return (NULL);
 }
/*===========================================================================
 *		End of Function FindObRecordFilter()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool ResolveObRecordFilterParents (Filters);
 *
 * Fills in the m_pParent field for all filters in the given array.
 *
 *=========================================================================*/
bool ResolveObRecordFilterParents (CSrRecFilterArray& Filters) {
  CSrRecordFilter* pFilter;
  CSrRecordFilter* pParent;
  dword		   Index;

  for (Index = 0; Index < Filters.GetSize(); ++Index) {
    pFilter = Filters[Index];
    if (!pFilter->HasParent()) continue;

    pParent = FindObRecordFilter(pFilter->GetParentName(), Filters);

    if (pParent == NULL) {
      AddSrGeneralError("The filter's parent '%s' was not found!", pFilter->GetParentName());
     }
    else {
      pFilter->SetParent(pParent);
     }
    
   }

  return (true);
 }
/*===========================================================================
 *		End of Function ResolveObRecordFilterParents()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool LoadObRecordFilters (pFilename, Records);
 *
 *=========================================================================*/
bool LoadObRecordFilters (const SSCHAR* pFilename, CSrRecFilterArray& Records) {
  CSrRecordFilter* pFilter;
  CSString         Buffer;
  CSString	   Variable;
  CSString	   Value;
  CSrFile	   File;
  dword		   InputLine;
  long		   Filesize;
  bool		   Result;

	/* Clear the current filter data, if any */
  Records.Destroy();

	/* Attempt to open the file for input */
  Result = File.Open(pFilename, "rt");
  if (!Result) return (false);

  Filesize  = File.GetFileSize();
  InputLine = 0;
  pFilter   = NULL;

	/* Read and parse entire file */
  while (!File.IsEOF() && File.Tell() < Filesize) {
    Result = File.ReadLine(Buffer);
    if (!Result) return (false);
    ++InputLine;

    Result = Buffer.SeperateVarValue(Variable, Value);

    if (pFilter != NULL) {
      if (Variable.CompareNoCase("End") == 0) {
	pFilter = NULL;
       }
     else if (Result) {
       Result = pFilter->SetParameter(Variable, Value);
       //if (!Result) AddSrGeneralError("%5lu: Invalid filter variable/value found: %s = %s", InputLine, Variable.c_str(), Value.c_str());
      }
     else {
       AddSrGeneralError("%5lu: Unknown variable/value pair found: %s = %s", InputLine, Variable.c_str(), Value.c_str());
      }

     }
    else if (Variable.CompareNoCase("DisplayFilter") == 0 || Variable.CompareNoCase("Filter") == 0) {
      pFilter = new CSrRecordFilter;
      Records.Add(pFilter);
     }
   }

  if (pFilter != NULL) {
    AddSrGeneralError("%5lu: Missing 'End' tag!", InputLine);
   }

  ResolveObRecordFilterParents(Records);
  return (true);
 }
/*===========================================================================
 *		End of Function LoadObRecordFilters()
 *=========================================================================*/
