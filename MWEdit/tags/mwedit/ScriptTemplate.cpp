/*===========================================================================
 *
 * File:	Scripttemplate.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 8, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "scripttemplate.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("ScriptTemplate.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptTemplate Constructor
 *
 *=========================================================================*/
CEsmScriptTemplate::CEsmScriptTemplate () : m_TemplateVars(0) {
  //DEFINE_FUNCTION("CEsmScriptTemplate::CEsmScriptTemplate()");

 }
/*===========================================================================
 *		End of Class CEsmScriptTemplate Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptTemplate Method - void Destroy (void);
 *
 *=========================================================================*/
void CEsmScriptTemplate::Destroy (void) {
  //DEFINE_FUNCTION("CEsmScriptTemplate::Destroy()");
  m_TemplateText.Empty();
  m_Filename.Empty();

  ClearTemplateVars();
 }
/*===========================================================================
 *		End of Class Method CEsmScriptTemplate::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptTemplate Method - bool AddTemplateVariable (pVariable, Length);
 *
 * Adds the given template variable which includes the first/last template
 * character. Returns false on any error. Protected class method.
 *
 *=========================================================================*/
bool CEsmScriptTemplate::AddTemplateVariable (const TCHAR* pVariable, const int Length) {
  TCHAR Buffer[ESM_SCRTEMP_MAXVARSIZE+1];

	/* Ignore invalid input */
  if (pVariable == NULL || Length <= 2) return (false);
  strnncpy(Buffer, pVariable + 1, (Length-1 > ESM_SCRTEMP_MAXVARSIZE) ? ESM_SCRTEMP_MAXVARSIZE : Length-1);

  return AddTemplateVar(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptTemplate::AddTemplateVariable()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptTemplate Method - bool AddTemplateVar (pVariable);
 *
 * Adds the given template variable. Returns false on any error.
 *
 *=========================================================================*/
bool CEsmScriptTemplate::AddTemplateVar (const TCHAR* pVariable) {
  DEFINE_FUNCTION("CEsmScriptTemplate::AddTemplateVar()");
  esmscrtempvar_t* pTempVar;

	/* See if the variable already exists */
  pTempVar = FindTemplateVar(pVariable);

  if (pTempVar != NULL) {
    pTempVar->Uses++;
    return (true);
   }

	/* Create a new template variable */
  CreatePointer(pTempVar, esmscrtempvar_t);
  pTempVar->SetName(pVariable);
  pTempVar->Uses        = 1;
  pTempVar->CsvColIndex = -1;
  m_TemplateVars.Add(pTempVar);
    
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptTemplate::AddTemplateVar()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptTemplate Method - void ClearTemplateVars (void);
 *
 * Deletes any defined template variables in the array.
 *
 *=========================================================================*/
void CEsmScriptTemplate::ClearTemplateVars (void) {
  DEFINE_FUNCTION("CEsmScriptTemplate::ClearTemplateVars()");
  esmscrtempvar_t* pTempVar;
  int		   Index;

  for (Index = 0; Index < m_TemplateVars.GetNumElements(); Index++) {
    pTempVar = m_TemplateVars.GetAt(Index);
    DestroyPointer(pTempVar);
   }

  m_TemplateVars.RemoveAll();
 }
/*===========================================================================
 *		End of Class Method CEsmScriptTemplate::ClearTemplateVars()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptTemplate Method - bool ConvertText (pOutBuffer, BufferSize, pRow);
 *
 * Converts a template script buffer using the given CSV variable data.
 * Assumes that the current CSV column index data is valid. Returns false
 * on any error.
 *
 *=========================================================================*/
bool CEsmScriptTemplate::ConvertText (TCHAR* pOutBuffer, const int BufferSize, CCsvRow* pRow) {
  TCHAR*		pParse;
  TCHAR*		pLastVarStart;
  CSString		CurrentVar;
  CSString*		pCsvString;
  bool			InQuote;
  bool			EndVar;
  int			Index;
  int			OutSize;
  int			LengthDiff;

	/* Ensure valid input */
  if (pOutBuffer == NULL || BufferSize < m_TemplateText.GetLength()) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("Invalid or short template script string received!"));
    return (false);
   }

	/* Create the buffer copy */
  OutSize = m_TemplateText.GetLength();
  strnncpy(pOutBuffer, m_TemplateText, OutSize);
  
	/* Initialize loop variables */
  pParse	= pOutBuffer;
  pLastVarStart = NULL;
  InQuote	= false;
  EndVar	= false;
  Index		= 0;

	/* Parse the entire string */
  while (Index < OutSize) {

    switch (*pParse) {
		/* Quote character indicating a string */
      case '"':
	InQuote = !InQuote;
	break;
		/* Carriage return, end-of-line */
      case '\n':
        InQuote = false;
	if (pLastVarStart != NULL) EndVar = true;
	break;
		/* Start of a template variable */
      case ESM_SCRTEMP_TEMPCHAR1:
        pLastVarStart = pParse;
	break;
		/* End of a template variable */
     case ESM_SCRTEMP_TEMPCHAR2:
        EndVar = true;
	break;
     }

		/* Parse a template variable */
    if (EndVar) {
      CurrentVar.Copy(pLastVarStart + 1, (int) (pParse - pLastVarStart - 1));

		/* Get the variable value */
      pCsvString = GetCsvString (CurrentVar, pRow);
      if (pCsvString == NULL) return (false);

		/* Ensure the buffer size is not exceeded */
      LengthDiff = pCsvString->GetLength() - CurrentVar.GetLength() - 2;

      if (OutSize + LengthDiff >= BufferSize) { 
        ErrorHandler.AddError(ERR_BADINPUT, _T("Exceeded the script template buffer size of %d!"), BufferSize);
        return (false);
       }

		/* Shift the right-hand portion of the string */
      memmove((pParse + (1 + LengthDiff)*sizeof(TCHAR)), (void *)(pParse + sizeof(TCHAR)), (OutSize - Index)*sizeof(TCHAR));

		/* Copy in the new variable value */
      memcpy((void *)pLastVarStart, (const TCHAR *)*pCsvString, pCsvString->GetLength()*sizeof(TCHAR));

      pParse  += LengthDiff;
      Index   += LengthDiff;
      OutSize += LengthDiff;

      pLastVarStart = NULL;
      EndVar = false;
     }

    Index++;
    pParse++;
   }

  pOutBuffer[OutSize] = NULL_CHAR;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptTemplate::ConvertText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptTemplate Method - esmscrtempvar_t* FindTemplateVar (pVariable);
 *
 * Attempt to find and record the given template variable. Returns NULL
 * on any error.
 *
 *=========================================================================*/
esmscrtempvar_t* CEsmScriptTemplate::FindTemplateVar (const TCHAR* pVariable) {
  esmscrtempvar_t* pTempVar;
  int		   Index;

	/* Check all currently defined variables in the array */
  for (Index = 0; Index < m_TemplateVars.GetNumElements(); Index++) {
    pTempVar = m_TemplateVars.GetAt(Index);
    if (pTempVar->IsName(pVariable)) return (pTempVar);
   }

	/* No match */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptTemplate::FindTemplateVar()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptTemplate Method - CSString* GetCsvString (pVarName, pRow);
 *
 * Attempt to access the given variable value in the csv row. Returns
 * NULL on any error.
 *
 *=========================================================================*/
CSString* CEsmScriptTemplate::GetCsvString (const TCHAR* pVarName, CCsvRow* pRow) {
  //DEFINE_FUNCTION("CEsmScriptTemplate::GetCsvString()");
  esmscrtempvar_t* pTempVar;
  CSString*	   pCsvString;

	/* Special script name */
  if (TSTRICMP(pVarName, ESMSCRTEMP_CSV_SCRIPTNAME) == 0) return (&m_ScriptName);
  
		/* Ensure a valid template variable */
  pTempVar = FindTemplateVar(pVarName);

  if (pTempVar == NULL) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("Failed to find the script template variable '%s'!"), pVarName);
    return (NULL);
   }

		/* Ensure a valid variable value */
  pCsvString = pRow->GetAt(pTempVar->CsvColIndex);

  if (pCsvString == NULL || pCsvString->IsEmpty()) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("Empty or missing script template variable '%s'!"), pVarName);
    return (NULL);
   }
   

  return (pCsvString);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptTemplate::GetCsvString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptTemplate Method - bool Load (pFilename);
 *
 * Attenpt to load the given template file. Returns false on any error.
 *
 *=========================================================================*/
bool CEsmScriptTemplate::Load (const TCHAR* pFilename) { 
  CGenFile File;
  bool	   Result;
  long	   FileSize;

	/* Attempt to open the file for reading */
  Result = File.Open(pFilename, _T("rb"));
  if (!Result) return (false);

  FileSize = File.GetFileSize();
  if (FileSize > ESM_SCRTEMP_MAXTEMPSIZE) FileSize = ESM_SCRTEMP_MAXTEMPSIZE;

	/* Clear the current contents */
  Destroy();
  m_Filename = pFilename;

	/* Read the text all at once */
  m_TemplateText.SetSize(FileSize);
  Result = File.Read((TCHAR *)(const TCHAR *)m_TemplateText, FileSize);
  if (!Result) return (false);

	/* Parse the template text */
  Result = ParseText();
  if (!Result) return (false);

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptTemplate::Load()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptTemplate Method - bool ParseText (void);
 *
 * Parses the template text looking for template variable codes. Returns
 * false on any error.
 *
 *=========================================================================*/
bool CEsmScriptTemplate::ParseText (void) {
  const TCHAR*  pParse;
  const TCHAR*  pLastVarStart;
  bool		InQuote;
  bool	        EndVar;
  bool		Result;
  int		VarLength;
  int	        Index;

	/* Delete any previous variable information */
  ClearTemplateVars();

	/* Initialize loop variables */
  pParse	= m_TemplateText;
  pLastVarStart = NULL;
  InQuote	= false;
  EndVar	= false;
  Index		= 0;

	/* Parse the entire string */
  while (Index < m_TemplateText.GetLength()) {

    switch (*pParse) {
		/* Quote character indicating a string */
      case '"':
	InQuote = !InQuote;
	break;
		/* Carriage return, end-of-line */
      case '\n':
        InQuote = false;
	if (pLastVarStart != NULL) EndVar  = true;
	break;
		/* Start of a template variable */
      case ESM_SCRTEMP_TEMPCHAR1:
        pLastVarStart = pParse;
	VarLength     = 0;
	break;
		/* End of a template variable */
     case ESM_SCRTEMP_TEMPCHAR2:
        EndVar = true;
	break;
     }

		/* Parse a template variable */
    if (EndVar) {
      EndVar = false;
      Result = AddTemplateVariable(pLastVarStart, VarLength);
      pLastVarStart = NULL;
     }

    Index++;
    pParse++;
    VarLength++;
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptTemplate::ParseText()
 *=========================================================================*/

