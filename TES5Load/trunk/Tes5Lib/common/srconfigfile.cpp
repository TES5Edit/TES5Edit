/*===========================================================================
 *
 * File:	Srconfigfile.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srconfigfile.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrConfigFile Constructor
 *
 *=========================================================================*/
CSrConfigFile::CSrConfigFile() {

}
/*===========================================================================
 *		End of Class CSrConfigFile Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrConfigFile Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrConfigFile::Destroy (void) {
  m_Records.Destroy();
}
/*===========================================================================
 *		End of Class Method CSrConfigFile::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrConfigFile Method - bool Delete (pVariable);
 *
 * Attempts to delete the given config entry. Returns true on success or
 * false if it was not found.
 *
 *=========================================================================*/
bool CSrConfigFile::Delete (const char* pVariable) {
  CSrConfigEntry* pEntry;

  pEntry = FindEntry(pVariable);
  if (pEntry == NULL) return (false);

  m_Records.Delete(pEntry);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrConfigFile::Delete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrConfigFile Method - CSrConfigEntry* FindEntry (pVariable);
 *
 * Find and return the first config entry with the matching variable name.
 * Returns NULL if not found.
 *
 *=========================================================================*/
CSrConfigEntry* CSrConfigFile::FindEntry (const char* pVariable) {
  CSrConfigEntry* pEntry;
  dword		  Index;

  for (Index = 0; Index < m_Records.GetSize(); ++Index) {
    pEntry = m_Records.GetAt(Index);
    if (pEntry->IsVariable(pVariable)) return (pEntry);
  }  

  return (NULL);
}
/*===========================================================================
 *		End of Class Method CSrConfigFile::FindEntry()
 *=========================================================================*/


bool CSrConfigFile::FindFirst (CSString& Value, const char* pVariable, int& Position, const char* Default)
{
	Position = -1;
	return FindNext(Value, pVariable, Position, Default);
}


bool CSrConfigFile::FindNext (CSString& Value, const char* pVariable, int& Position, const char* Default)
{
	
	while (Position+1 < (int) m_Records.GetSize()) 
	{
		++Position;

		CSrConfigEntry* pEntry = m_Records[Position];
		if (pEntry == NULL) continue;

		if (pEntry->IsVariable(pVariable)) 
		{
			Value = pEntry->GetValue();
			return true;
		}
	}

	Value = Default;
	return false;
}


/*===========================================================================
 *
 * Class char* CSrConfigFile Method - const Get (pVariable);
 *
 * Returns the value of the given config entry or NULL if not found.
 *
 *=========================================================================*/
const char* CSrConfigFile::Get (const char* pVariable) {
  CSrConfigEntry* pEntry;

  pEntry = FindEntry(pVariable);
  if (pEntry == NULL) return (NULL);

  return pEntry->GetValue();
}
/*===========================================================================
 *		End of Class Method char* CSrConfigFile::Get()
 *=========================================================================*/


/*===========================================================================
 *
 * Class char* CSrConfigFile Method - const Get (pVariable, pDefault);
 *
 * Returns the value of the given config entry or the default value
 * if not found.
 *
 *=========================================================================*/
const char* CSrConfigFile::Get (const char* pVariable, const char* pDefault) {
  CSrConfigEntry* pEntry;

  pEntry = FindEntry(pVariable);
  if (pEntry == NULL) return (pDefault);

  return pEntry->GetValue();
}
/*===========================================================================
 *		End of Class Method char* CSrConfigFile::Get()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrConfigFile Method - bool GetInteger (Value, pVariable, Default);
 *
 *=========================================================================*/
bool CSrConfigFile::GetInteger (int& Value, const char* pVariable, const int Default) {
  CSrConfigEntry* pEntry;
  char*		  pError;

  Value  = Default;
  pEntry = FindEntry(pVariable);
  if (pEntry == NULL) return (false);

  Value = strtol(pEntry->GetValue(), &pError, 0);

  if (*pError != NULL_CHAR) return (false);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrConfigFile::GetInteger()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrConfigFile Method - bool GetDword (Value, pVariable, Default);
 *
 *=========================================================================*/
bool CSrConfigFile::GetDword (dword& Value, const char* pVariable, const dword Default) {
  CSrConfigEntry* pEntry;
  char*		  pError;

  Value  = Default;
  pEntry = FindEntry(pVariable);
  if (pEntry == NULL) return (false);

  Value = strtoul(pEntry->GetValue(), &pError, 0);

  if (*pError != NULL_CHAR) return (false);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrConfigFile::GetDword()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrConfigFile Method - bool GetFloat (Value, pVariable, Default);
 *
 *=========================================================================*/
bool CSrConfigFile::GetFloat (float& Value, const char* pVariable, const float Default) {
  CSrConfigEntry* pEntry;
  char*		  pError;

  Value  = Default;
  pEntry = FindEntry(pVariable);
  if (pEntry == NULL) return (false);

  Value = (float) strtod(pEntry->GetValue(), &pError);

  if (*pError != NULL_CHAR) return (false);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrConfigFile::GetFloat()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrConfigFile Method - bool GetBoolean (Value, pVariable, Default);
 *
 *=========================================================================*/
bool CSrConfigFile::GetBoolean (bool& Value, const char* pVariable, const bool Default) {
  CSrConfigEntry* pEntry;
  char*		  pError;

  Value  = Default;
  pEntry = FindEntry(pVariable);
  if (pEntry == NULL) return (false);

  if (stricmp(pEntry->GetValue(), "true") == 0)
    Value = true;
  else if (stricmp(pEntry->GetValue(), "false") == 0)
    Value = false;
  else if (stricmp(pEntry->GetValue(), "yes") == 0)
    Value = true;
  else if (stricmp(pEntry->GetValue(), "no") == 0)
    Value = false;
  else {
    Value = (strtol(pEntry->GetValue(), &pError, 0) != 0);
    if (*pError != NULL_CHAR) return (false);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrConfigFile::GetBoolean()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrConfigFile Method - bool GetString (Value, pVariable, Default);
 *
 *=========================================================================*/
bool CSrConfigFile::GetString (CSString& Value, const char* pVariable, const char* Default) {
  CSrConfigEntry* pEntry;

  pEntry = FindEntry(pVariable);

  if (pEntry == NULL) {
    Value = Default;
    return (false);
  }

  Value = pEntry->GetValue();;
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrConfigFile::GetString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrConfigFile Method - bool Load (pFilename);
 *
 *=========================================================================*/
bool CSrConfigFile::Load (const char* pFilename) {
  CSrFile         File;
  CSrConfigEntry* pEntry = NULL;
  CSString        Buffer;
  bool            Result;

	/* Clear the current contents */
  Destroy();

	/* Attempt to open file for input */
  Result = File.Open(pFilename, "rt");
  if (!Result) return (false);

	/* Read entire line line by line */
  while (!File.IsEOF()) {
    Result = File.ReadLine(Buffer);
    if (!Result) return (false);

    pEntry = new CSrConfigEntry(m_Options);
    m_Records.Add(pEntry);

    pEntry->ParseLine(Buffer);
  }

	/* Remove the last entry if it is empty */
  if (pEntry != NULL && pEntry->IsEmpty()) {
    m_Records.Delete(pEntry);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrConfigFile::Load()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrConfigFile Method - bool Save (pFilename);
 *
 *=========================================================================*/
bool CSrConfigFile::Save (const char* pFilename) {
  CSrFile  File;
  dword    Index;
  bool     Result;

  Result = File.Open(pFilename, "wt");
  if (!Result) return (false);

  for (Index = 0; Index < m_Records.GetSize(); ++Index) {
    Result = File.Printf("%s\n", m_Records.GetAt(Index)->GetLine());
    if (!Result) return (false);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrConfigFile::Save()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrConfigFile Method - void SetValue (pVariable, pValue);
 *
 * Sets the value of the given config entry. Creates the entry if it 
 * doesn't already exist.
 *
 *=========================================================================*/
void CSrConfigFile::SetValue (const char* pVariable, const char* pValue) {
  CSrConfigEntry* pEntry;
 
  pEntry = FindEntry(pVariable);

  if (pEntry == NULL) { 
    pEntry = new CSrConfigEntry(m_Options);
    m_Records.Add(pEntry);
    pEntry->SetNew(pVariable, pValue);
  }
  else {
    pEntry->Set(pVariable, pValue);
  }

}
/*===========================================================================
 *		End of Class Method CSrConfigFile::SetValue()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrConfigFile Method - void SetValueFormat (pVariable, pValue, ...);
 *
 * Sets the value of the given config entry in with a printf() formatted
 * string. Creates the entry if it doesn't already exist.
 *
 *=========================================================================*/
void CSrConfigFile::SetValueFormat (const char* pVariable, const char* pValue, ...) {
  CSrConfigEntry* pEntry;
  va_list	  Args;

  pEntry = FindEntry(pVariable);
  va_start(Args, pValue);

  if (pEntry == NULL) { 
    pEntry = new CSrConfigEntry(m_Options);
    m_Records.Add(pEntry);

    pEntry->SetNewFormatV(pVariable, pValue, Args);
  }
  else {
    pEntry->SetVariable(pVariable);
    pEntry->SetValueFormatV(pValue, Args);
  }
  
  va_end(Args);
}
/*===========================================================================
 *		End of Class Method CSrConfigFile::SetValueFormat()
 *=========================================================================*/

