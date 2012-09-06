/*===========================================================================
 *
 * File:	Mwranduniques.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Friday, May 23, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "mwranduniques.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("MwRandUniques.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandUniques Constructor
 *
 *=========================================================================*/
CMwRandUniques::CMwRandUniques () : m_UniqueArray(0) {
  //DEFINE_FUNCTION("CMwRandUniques::CMwRandUniques()");
  m_pEffects = NULL;
  m_InputLine = 0;
 }
/*===========================================================================
 *		End of Class CMwRandUniques Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandUniques Method - void Destroy (void);
 *
 *=========================================================================*/
void CMwRandUniques::Destroy (void) {
  DEFINE_FUNCTION("CMwRandUniques::Destroy()");
  mwru_unique_t* pUnique;
  int		 Index;

	/* Delete all unique records */
  for (Index = 0; Index < (int)m_UniqueArray.GetNumElements(); Index++) {
    pUnique = m_UniqueArray.GetAt(Index);
    DestroyPointer(pUnique);
   }

	/* Clear the unique array */
  m_UniqueArray.RemoveAll();
  m_InputLine = 0;
 }
/*===========================================================================
 *		End of Class Method CMwRandUniques::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandUniques Method - bool AddEffect (pNewUnique pEffectName);
 *
 * Attempt to add the given effect to the given unique object. Returns
 * false on any error.
 *
 *=========================================================================*/
bool CMwRandUniques::AddEffect (mwru_unique_t* pNewUnique, const TCHAR* pEffectName) {

	/* Don't exceed the effect array size */
  if (pNewUnique->NumEffects >= MWRU_MAX_EFFECTS) {
    ErrorHandler.AddError(ERR_MAXINDEX, _T("\t%5ld: Exceeded the maximum number of unique effects %d!"), m_InputLine, MWRU_MAX_EFFECTS);
    return (false);
   }

  if (m_pEffects != NULL) {
    pNewUnique->pEffects[pNewUnique->NumEffects] = m_pEffects->FindEffect(pEffectName);

    if (pNewUnique->pEffects[pNewUnique->NumEffects] != NULL) 
      pNewUnique->NumEffects++;
    else
      SystemLog.Printf ("\t%5ld: Unknown effect '%s'!", m_InputLine, pEffectName);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandUniques::AddEffect()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandUniques Method - bool ReadUnique (File, pNewUnique);
 *
 * Protected class method which reads an unique section from the given file.
 * Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandUniques::ReadUnique (CGenFile& File, mwru_unique_t* pNewUnique) {
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
      Result = SetUniqueParam(pNewUnique, pVariable, pValue);
      if (!Result) return (false);
     }
    
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandUniques::ReadUnique()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandUniques Method - bool ReadUnique (File);
 *
 * Protected class method which reads an unique section from the given file.
 * Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandUniques::ReadUnique (CGenFile& File) {
  DEFINE_FUNCTION("CMwRandUniques::ReadUnique()");
  mwru_unique_t* pNewUnique;

	/* Create and initialize the new unique */
  CreatePointer(pNewUnique, mwru_unique_t);
  DefaultMwRandUnique (*pNewUnique);
  m_UniqueArray.Add(pNewUnique);

  return ReadUnique(File, pNewUnique);
 }
/*===========================================================================
 *		End of Class Method CMwRandUniques::ReadUnique()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandUniques Method - bool ReadUniqueFile (pFilename);
 *
 * Attempts to input unique data from the given file. Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandUniques::ReadUniqueFile (const TCHAR* pFilename) {
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

		/* Start of unique section */
    if (TSTRICMP(pVariable, _T("Unique")) == 0) {
      Result = ReadUnique(File);
      if (!Result) return (false);
     }
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandUniques::ReadUniqueFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandUniques Method - bool SetUniqueParam (pNewUnique, pVariable, pValue);
 *
 * Sets the given unique object values from the given string inputs. Returns
 * false on any error. Protected class method.
 *
 *=========================================================================*/
bool CMwRandUniques::SetUniqueParam (mwru_unique_t* pNewUnique, const TCHAR* pVariable,
				     const TCHAR* pValue) {

  if (TSTRICMP(pVariable, _T("Name")) == 0) {
    strnncpy(pNewUnique->Name, pValue, MWRI_MAX_NAMESIZE);
   }
  else if (TSTRICMP(pVariable, _T("NameType")) == 0) {
    if (TSTRICMP(pValue, "Exact") == 0) 
      pNewUnique->NameType = MWRU_NAMETYPE_EXACT;
    else if (TSTRICMP(pValue, "Suffix") == 0) 
      pNewUnique->NameType = MWRU_NAMETYPE_SUFFIX;
    else if (TSTRICMP(pValue, "Prefix") == 0) 
      pNewUnique->NameType = MWRU_NAMETYPE_PREFIX;
    else
      SystemLog.Printf ("\t%5ld: Unknown name type '%s'!", m_InputLine, pValue);
   }
  else if (TSTRICMP(pVariable, _T("Icon")) == 0) {
    strnncpy(pNewUnique->Icon, pValue, MWRI_MAX_NAMESIZE);
   }
  else if (TSTRICMP(pVariable, _T("Model")) == 0) {
    strnncpy(pNewUnique->Model, pValue, MWRI_MAX_NAMESIZE);
   }
  else if (TSTRICMP(pVariable, _T("ItemLevel")) == 0) {
    pNewUnique->ItemLevel = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("ItemMask")) == 0) {
    pNewUnique->ItemMask = ShortStringToMwRandItemMask(pValue);
   }
  else if (TSTRICMP(pVariable, _T("Effect")) == 0) {
    return AddEffect(pNewUnique, pValue);
   }
  else {
    SystemLog.Printf ("\t%5ld: Unknown unique parameter '%s'!", m_InputLine, pVariable);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandUniques::SetUniqueParam()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void DefaultMwRandUnique (UniqueItem);
 *
 *=========================================================================*/
void DefaultMwRandUnique (mwru_unique_t& UniqueItem) {
  UniqueItem.ItemMask = MWRI_ITEMMASK_ALL;
  UniqueItem.ItemLevel = 1;
  UniqueItem.NumEffects = 0;
  UniqueItem.Name[0]   = NULL_CHAR;
  UniqueItem.Model[0]  = NULL_CHAR;
  UniqueItem.Icon[0]   = NULL_CHAR;
  UniqueItem.NameType  = MWRU_NAMETYPE_EXACT;
 }  
/*===========================================================================
 *		End of Function DefaultMwRandUnique()
 *=========================================================================*/
