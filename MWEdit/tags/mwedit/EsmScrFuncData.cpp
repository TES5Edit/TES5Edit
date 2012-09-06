/*===========================================================================
 *
 * File:	Esmscrfuncdata.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 1, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "esmscrfuncdata.h"
#include "string/sstring.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("EsmScrFuncData.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrFuncData Constructor
 *
 *=========================================================================*/
CEsmScrFuncData::CEsmScrFuncData () {

  m_Function[0]   = NULL_CHAR;
  m_ReturnDesc[0] = NULL_CHAR;
  m_WikiLink[0]   = NULL_CHAR;

  m_ReturnFlags   = 0;
  m_Flags	  = 0;
  m_OpCode	  = 0;
  m_NumParams	  = 0;
 }
/*===========================================================================
 *		End of Class CEsmScrFuncData Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrFuncData Destructor
 *
 *=========================================================================*/
void CEsmScrFuncData::Destroy (void) {
  int Index;

	/* Clear strings */
  m_Description.Empty();
  m_Function[0]   = NULL_CHAR;
  m_ReturnDesc[0] = NULL_CHAR;
  m_WikiLink[0]   = NULL_CHAR;

	/* Clear flags */
  m_ReturnFlags   = 0;
  m_Flags	  = 0;
  m_OpCode	  = 0;

	/* Clear parameters */
  for (Index = 0; Index < m_NumParams; Index++) {
    m_ParamDesc[Index].Empty();
    m_ParamFlags[Index] = 0;
   }

  m_NumParams = 0;
 }
/*===========================================================================
 *		End of Class CEsmScrFuncData Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class TCHAR* CEsmScrFuncData Method - const CreateParamString (Index) const;
 *
 * Creates and returns a string for the given parameter. Returns an empty 
 * string on any error. Uses a local static string buffer.
 *
 *=========================================================================*/
const TCHAR* CEsmScrFuncData::CreateParamString (const int Index) const { 
  static TCHAR s_Buffer[64];

	/* Ensure the input parameter index is valid */
  if (!IsValidIndex(Index)) { 
    s_Buffer[0] = NULL_CHAR;
    return (s_Buffer);
   }

  snprintf(s_Buffer, 60, _T("[%s]"), m_ParamDesc[Index]);

  if ((m_ParamFlags[Index] & ESMSCR_FUNC_OPTIONAL) != 0) {
    chrcat(s_Buffer, '*');
   }

  return (s_Buffer);
 }
/*===========================================================================
 *		End of Class Method TCHAR* CEsmScrFuncData::CreateParamString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TCHAR* CEsmScrFuncData Method - const TCHAR* GetFuncForm (void) const;
 *
 * Returns the complete function format including name and parameters.
 * Uses a local static string buffer.
 *
 *=========================================================================*/
const TCHAR* CEsmScrFuncData::GetFuncForm (void) const {
  static CSString s_Buffer;
  int     Index;
  
  s_Buffer = GetFunction();

	/* Add all parameters to the function title string */
  for (Index = 0; Index < GetNumParams(); Index++) {
    s_Buffer += _T(", ");
    s_Buffer += CreateParamString(Index);
   }

  return (s_Buffer);
 }
/*===========================================================================
 *		End of Class Method TCHAR* CEsmScrFuncData::GetFuncForm()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TCHAR* CEsmScrFuncData Method - const TCHAR* GetExFuncForm (ParamIndex, LineLength) const;
 *
 * Returns the complete function format including name and parameters.
 * Uses a local static string buffer. If the input LineLength is positive
 * a carriage return will be inserted after that many characters.
 *
 *=========================================================================*/
const TCHAR* CEsmScrFuncData::GetExFuncForm (const int ParamIndex, const int LineLength) const {
  static CSString s_Buffer;
  int             Index;
  int		  MaxLength;
  
  s_Buffer  = GetReturnString();;
  s_Buffer += GetFunction();
  MaxLength = LineLength;

	/* Add all parameters to the function title string */
  for (Index = 0; Index < GetNumParams(); Index++) {
    s_Buffer += _T(", ");

    if (LineLength > 0 && s_Buffer.GetLength() > MaxLength) {
      s_Buffer += _T("\n\r");
      MaxLength += LineLength;
     }

    if (Index == ParamIndex) {
      s_Buffer += _T(" >");
      s_Buffer += CreateParamString(Index);
      s_Buffer += _T("< ");
     }
    else {
      s_Buffer += CreateParamString(Index);
     }
   }

  return (s_Buffer);
 }
/*===========================================================================
 *		End of Class Method TCHAR* CEsmScrFuncData::GetExFuncForm()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TCHAR* CEsmScrFuncData Method - const GetParamDetail (Index) const;
 *
 * Creates and returns a detailed string for the given parameter. Returns an 
 * empty  string on any error. Uses a local static string buffer.
 *
 *=========================================================================*/
const TCHAR* CEsmScrFuncData::GetParamDetail (const int Index) const { 
  static TCHAR s_Buffer[256];
  CSString     Buffer;

	/* Ensure the input parameter index is valid */
  if (!IsValidIndex(Index)) { 
    s_Buffer[0] = NULL_CHAR;
    return (s_Buffer);
   }

  Buffer += m_ParamDesc[Index];
  Buffer += _T(":\t");
  
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_BYTE) != 0) 
    Buffer += _T("byte");
  else if ((m_ParamFlags[Index] & ESMSCR_FUNC_SHORT) != 0) 
    Buffer += _T("short");
  else if ((m_ParamFlags[Index] & ESMSCR_FUNC_LONG) != 0) 
    Buffer += _T("long");
  else if ((m_ParamFlags[Index] & ESMSCR_FUNC_FLOAT) != 0) 
    Buffer += _T("float");
  else if ((m_ParamFlags[Index] & ESMSCR_FUNC_STRING) != 0) 
    Buffer += _T("string");
  else if ((m_ParamFlags[Index] & ESMSCR_FUNC_ID) != 0) 
    Buffer += _T("ID");
  else if ((m_ParamFlags[Index] & ESMSCR_FUNC_XYZ) != 0) 
    Buffer += _T("XYZ");
  
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_OPTIONAL) != 0) Buffer += _T(", Optional");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_EFFECT) != 0) Buffer += _T(", EffectID");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_RESET) != 0) Buffer += _T(", Reset");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_ANIM) != 0) Buffer += _T(", Animation Group");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_NOTREQ) != 0) Buffer += _T(", Optional");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_CELLSTR) != 0) Buffer += _T(", Cell String");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_SCRIPTID) != 0) Buffer += _T(", Script");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_SOUNDID) != 0) Buffer += _T(", Sound");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_RACEID) != 0) Buffer += _T(", Race");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_JOURNALID) != 0) Buffer += _T(", Journal");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_FACTIONID) != 0) Buffer += _T(", Faction");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_ITEMID) != 0) Buffer += _T(", Item");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_REGIONID) != 0) Buffer += _T(", Region");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_TOPICID) != 0) Buffer += _T(", Topic");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_CELLID) != 0) Buffer += _T(", Cell");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_EFFECTID) != 0) Buffer += _T(", Effect Number");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_LEVELCID) != 0) Buffer += _T(", Level Creature");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_LEVELIID) != 0) Buffer += _T(", Level Item");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_SOULGEMID) != 0) Buffer += _T(", Soulgem");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_CREATUREID) != 0) Buffer += _T(", Creature");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_SPELLID) != 0) Buffer += _T(", Spell");
  if ((m_ParamFlags[Index] & ESMSCR_FUNC_NPCID) != 0) Buffer += _T(", Npc");
  
  strnncpy(s_Buffer, Buffer, 255);
  return (s_Buffer);
 }
/*===========================================================================
 *		End of Class Method TCHAR* CEsmScrFuncData::GetParamDetail()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TCHAR* CEsmScrFuncData Method - const GetFlagString (void) const;
 *
 * Returns a string representing the function flags, if any. Uses a local
 * static string buffer.
 *
 *=========================================================================*/
const TCHAR* CEsmScrFuncData::GetFlagString (void) const {
  static TCHAR s_Buffer[128];
  CSString     Buffer;

  if ((m_Flags & ESMSCR_FUNC_ALLOWGLOBAL) != 0) {
    if (!Buffer.IsEmpty()) Buffer += _T(", ");
    Buffer += _T("Accepts Globals");
   }

  if ((m_Flags & ESMSCR_FUNC_BLOODMOON) != 0) {
    if (!Buffer.IsEmpty()) Buffer += _T(", ");
    Buffer += _T("Bloodmoon");
   }

  if ((m_Flags & ESMSCR_FUNC_TRIBUNAL) != 0) {
    if (!Buffer.IsEmpty()) Buffer += _T(", ");
    Buffer += _T("Tribunal");
   }

  if ((m_Flags & ESMSCR_FUNC_DIALOGUE) != 0) {
    if (!Buffer.IsEmpty()) Buffer += _T(", ");
    Buffer += _T("Dialogue Only");
   }

  if ((m_Flags & ESMSCR_FUNC_BAD) != 0) {
    if (!Buffer.IsEmpty()) Buffer += _T(", ");
    Buffer += _T("Broken");
   }

  if ((m_Flags & ESMSCR_FUNC_VAR) != 0) {
    if (!Buffer.IsEmpty()) Buffer += _T(", ");
    Buffer += _T("Accepts Variables");
   }

  if ((m_Flags & ESMSCR_FUNC_MWSE) != 0) {
    if (!Buffer.IsEmpty()) Buffer += _T(", ");
    Buffer += _T("MW-SE");
   }

  if ((m_Flags & ESMSCR_FUNC_MWE) != 0) {
    if (!Buffer.IsEmpty()) Buffer += _T(", ");
    Buffer += _T("MW-Enhanced");
   }

  if (Buffer.IsEmpty())
    strnncpy(s_Buffer, _T("-"), 127);
  else
    strnncpy(s_Buffer, Buffer, 127);

  return (s_Buffer);
 }
/*===========================================================================
 *		End of Class Method TCHAR* CEsmScrFuncData::GetFlagString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TCHAR* CEsmScrFuncData Method - const TCHAR* GetReturnString (void) const;
 *
 * Returns a description of the return string.
 *
 *=========================================================================*/
const TCHAR* CEsmScrFuncData::GetReturnString (void) const {
  static TCHAR s_Buffer[32];

  if ((m_ReturnFlags & ESMSCR_FUNC_BYTE) != 0) 
    strnncpy(s_Buffer, _T("byte "), 31);
  else if ((m_ReturnFlags & ESMSCR_FUNC_SHORT) != 0) 
    strnncpy(s_Buffer, _T("short "), 31);
  else if ((m_ReturnFlags & ESMSCR_FUNC_LONG) != 0) 
    strnncpy(s_Buffer, _T("long "), 31);
  else if ((m_ReturnFlags & ESMSCR_FUNC_FLOAT) != 0) 
    strnncpy(s_Buffer, _T("float "), 31);
  else if ((m_ReturnFlags & ESMSCR_FUNC_STRING) != 0) 
    strnncpy(s_Buffer, _T("string "), 31);
  else 
    strnncpy(s_Buffer, _T(""), 31);
  
  return (s_Buffer);
 }
/*===========================================================================
 *		End of Class Method TCHAR* CEsmScrFuncData::GetReturnString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrFuncData Method - bool ReadData (File);
 *
 * Inputs the function data section from the current location in the
 * given file. Returns false on any error.
 *
 *=========================================================================*/
bool CEsmScrFuncData::ReadData (CGenFile& File) {
  TCHAR  LineBuffer[ESM_SFDATA_LINELENGTH+1];
  TCHAR* pVariable;
  TCHAR* pValue; 
  bool   Result;
  int    LineResult;

	/* Read until end of file or end of function section */
  while (!File.IsEOF()) {

		/* Input one line from file, ignore extra data on long lines */
    LineResult = File.ReadLine(LineBuffer, ESM_SFDATA_LINELENGTH);
    if (LineResult == READLINE_MSL) LineResult = File.ReadLine();
    if (LineResult == READLINE_ERROR) return (false);
    
		/* Seperate the input line into its basic two components */
    Result = SeperateVarValue(&pVariable, &pValue, LineBuffer);
    if (TSTRICMP(pVariable, _T("End")) == 0) return (true);

		/* Save the input parameter on success */
    if (Result) SetValue(pVariable, pValue);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScrFuncData::ReadData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrFuncData Method - void SetParamValue (ParamIndex, pValue);
 *
 * Sets the given parameter flag/description from the input string. The input
 * string is modified and is assumed to have the format:
 *
 *		Flags, "Description"
 *
 *=========================================================================*/
void CEsmScrFuncData::SetParamValue (const int ParamIndex, TCHAR* pValue) {
  TCHAR* pParse;

	/* Ensure a valid input parameter index */
  if (ParamIndex < 0 || ParamIndex >= MWESM_SCRIPT_MAXARGS) { 
    ErrorHandler.AddError(ERR_BADARRAYINDEX, _T("Invalid parameter index %d!"), ParamIndex);
    return;
   }

	/* Adjust the current number of parameters */
  if (m_NumParams <= ParamIndex) m_NumParams = ParamIndex + 1;
  pParse = strchr(pValue, ',');

	/* Parse out the flags and description from the input string */
  if (pParse != NULL) {
    *pParse = NULL_CHAR;
    SetParamFlags(ParamIndex, strtoul(pValue, NULL, 0));
    SetParamDesc(ParamIndex, UnquoteString(pParse + 1));
   }
	/* Input string doesn't have any comma */
  else {
    SetParamFlags(ParamIndex, strtoul(pValue, NULL, 0));
    SetParamDesc(ParamIndex, _T(""));
   }

 }
/*===========================================================================
 *		End of Class Method CEsmScrFuncData::SetParamValue()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrFuncData Method - void SetReturnValue (pValue);
 *
 * Sets the return flags/description from the input string. The input
 * string is modified  and is assumed to have the format:
 *
 *		Flags, "Description"
 *
 *=========================================================================*/
void CEsmScrFuncData::SetReturnValue (TCHAR* pValue) {
  TCHAR* pParse;

	/* Try and find the comma seperating character */
  pParse = TSTRCHR(pValue, ',');

	/* Parse the return flags and description from the string */
  if (pParse != NULL) {
    *pParse = NULL_CHAR;
    m_ReturnFlags = strtoul(pValue, NULL, 0);
    SetReturnDesc(UnquoteString(pParse + 1));
   }
	/* String doesn't contain a comma character */
  else {
    m_ReturnFlags = strtoul(pValue, NULL, 0);
    SetReturnDesc(_T(""));
   }

 }
/*===========================================================================
 *		End of Class Method CEsmScrFuncData::SetReturnValue()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrFuncData Method - bool SetValue (pVariable, pValue);
 *
 * Sets a class member based on the input data. Returns false on any error.
 *	
 *=========================================================================*/
bool CEsmScrFuncData::SetValue (const TCHAR* pVariable, TCHAR* pValue) {
  int ParamIndex;

  if (TSTRICMP(pVariable, _T("function")) == 0) {
    SetFunction(pValue);
   }
  else if (TSTRICMP(pVariable, _T("wikilink")) == 0) {
    SetWikiLink(pValue);
   }
  else if (TSTRICMP(pVariable, _T("options")) == 0) {
    m_Flags = strtoul(pValue, NULL, 0);
   }
  else if (TSTRICMP(pVariable, _T("opcode")) == 0) {
    m_OpCode = strtoul(pValue, NULL, 0);
   }
  else if (TSTRICMP(pVariable, _T("return")) == 0) {
    SetReturnValue(pValue);
   }
  else if (TSTRNICMP(pVariable, _T("param"), 5) == 0) {
    ParamIndex = atoi(pVariable + 5) - 1;
    SetParamValue(ParamIndex, pValue);
   }
  else if (TSTRICMP(pVariable, _T("desc")) == 0) {
    m_Description += UnquoteString(pValue);
    m_Description += _T(" ");
   }
  else if (TSTRICMP(pVariable, _T("descl")) == 0) {
    m_Description += UnquoteString(pValue);
    m_Description += _T("\r\n");
   }
  else {
    ErrorHandler.AddError(ERR_CUSTOM, _T("Unknown script function variable '%s' found!"), pVariable);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScrFuncData::SetValue()
 *=========================================================================*/
