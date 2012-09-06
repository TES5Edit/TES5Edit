/*===========================================================================
 *
 * File:	Esmscriptdefs.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Wednesday, February 12, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "esmscriptdefs.h"
#include "mwcustomfunc.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("EsmScriptDefs.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Reserved String Array
 *
 *=========================================================================*/
const TCHAR* l_Reserved[] = {
	_T("begin"),
	_T("else"),
	_T("elseif"),
	_T("end"),
	_T("endif"),
	_T("endwhile"),
	_T("float"),
	_T("get"),
	_T("if"),
#ifdef MWEDIT_SCRIPT_MWSE
	_T("ifx")
#endif
	_T("long"),
	_T("return"),
	_T("set"),
#ifdef MWEDIT_SCRIPT_MWSE
	_T("setx"),
#endif
	_T("short"),
	_T("to"),
	_T("while"),
#ifdef MWEDIT_SCRIPT_MWSE
	_T("whilex"),
#endif
	_T("X"),
	_T("Y"),
	_T("Z"),
//	_T("reset"),
	NULL	/* Must be last entry */
 };
/*===========================================================================
 *		End of Reserved String Array
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool IsESMScriptFunction (pString);
 *
 * Returns true if the given word is a valid ESM script function. Uses the
 * fact that the script function array is sorted by name and jumps to the
 * first character in the string to speed search.  
 *
 * Typical speed is 0.08 secs for 1000 runs checking various strings.
 * This is ~7 times faster than the brute IsESMScriptFunction1() function.
 *
 *=========================================================================*/
bool IsESMScriptFunction (const TCHAR* pString) {
  //DEFINE_FUNCTION("IsESMScriptFunction()");
  int			FirstChar = toupper(*pString) - (int)'A';
  esmscrfuncinfo_t*	pStartSearch;
  int			Result;
  int			Index;

	/* Ensure valid word input */
  if (FirstChar < 0 || FirstChar > 26) return (false);
  pStartSearch = g_ScriptFuncAlpha[FirstChar];
  if (pStartSearch == NULL) return (false);

  for (Index = 0; pStartSearch[Index].Name[0] != NULL_CHAR; Index++) {
    Result = TSTRICMP(pStartSearch[Index].Name, pString);
    if (Result == 0) return (true);
    if (Result  > 0) return (false);
   }

  return (false);
 }
/*===========================================================================
 *		End of Function IsESMScriptFunction()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool IsESMScriptCustomFunction (pString);
 *
 * Returns true if the given string is a custom function.
 *
 *=========================================================================*/
bool IsESMScriptCustomFunction (const TCHAR* pString) {
  CMwCustomFunction* pFunction;
  return g_CustomFunctions.Lookup(pString, pFunction);
}
/*===========================================================================
 *		End of Function IsESMScriptCustomFunction()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - esmscrfuncinfo_t* GetESMScriptCustomFuncInfo (pString);
 *
 *=========================================================================*/
esmscrfuncinfo_t* GetESMScriptCustomFuncInfo (const TCHAR* pString) {
  CMwCustomFunction* pFunction;
  bool		     Result;

  Result = g_CustomFunctions.Lookup(pString, pFunction);
  if (!Result) return (NULL);

  return &(pFunction->GetData());
 }
/*===========================================================================
 *		End of Function GetESMScriptCustomFuncInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - esmscrfuncinfo_t* GetESMScriptFuncInfo (pString);
 *
 *=========================================================================*/
esmscrfuncinfo_t* GetESMScriptFuncInfo (const TCHAR* pString) {
  int			FirstChar = toupper(*pString) - (int)'A';
  esmscrfuncinfo_t*	pStartSearch;
  int			Result;
  int			Index;

	/* Ensure valid word input */
  if (FirstChar < 0 || FirstChar > 26) return (NULL);
  pStartSearch = g_ScriptFuncAlpha[FirstChar];
  if (pStartSearch == NULL) return (NULL);

  for (Index = 0; pStartSearch[Index].Name[0] != NULL_CHAR; Index++) {
    Result = TSTRICMP(pStartSearch[Index].Name, pString);
    if (Result == 0) return &(pStartSearch[Index]);
    if (Result  > 0) return (NULL);
   }

  return (NULL);
 }
/*===========================================================================
 *		End of Function GetESMScriptFuncInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool IsESMScriptFunction1 (pString);
 *
 * Returns true if the given word is a valid ESM script function.  Does a
 * brute force search of the entire function array.
 *
 * Typical speed is 0.5 secs for 1000 runs checking various strings.
 *
 *=========================================================================*/
bool IsESMScriptFunction1 (const TCHAR* pString) {
  //DEFINE_FUNCTION("IsESMScriptFunction1()");
  int	Result;
  int	Index;

  for (Index = 0; g_ScriptFunctions[Index].Name[0] != NULL_CHAR; Index++) {
    Result = TSTRICMP(g_ScriptFunctions[Index].Name, pString);
    if (Result == 0) return (true);
    if (Result  > 0) return (false);
   }

  return (false);
 }
/*===========================================================================
 *		End of Function IsESMScriptFunction1()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool IsESMScriptOperator (Char);
 *
 * Returns true if the given character is a valid ESM script operator.
 *
 *=========================================================================*/
bool IsESMScriptOperator (const TCHAR Char) {
  //DEFINE_FUNCTION("IsESMScriptOperator()");

  switch (Char) {
    case '(':
    case ')':
    case '*':
    case '+':
    case '/':
    case '.':
    case ',':
    case '<':    
    case '>':
    case '=':
    case '!':
    case '-':
	return (true);
   }

  return (false);
 }
/*===========================================================================
 *		End of Function IsESMScriptOperator()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int GetESMScriptOpToken (pString);
 *
 * Returns the token of the given script operator, or ESMSCR_TOKEN_UNKNOWN 
 * on any error.
 *
 *=========================================================================*/
int GetESMScriptOpToken (const TCHAR* pString) {

	/* 1-byte operators */
  if (pString[1] == NULL_CHAR) {
    switch (pString[0]) {
      case '(': return ESMSCR_TOKEN_OPENBRAC;
      case ')': return ESMSCR_TOKEN_CLOSEBRAC;
      case '+':
      case '-': return ESMSCR_TOKEN_ADDOP;
      case '*':
      case '/': return ESMSCR_TOKEN_MULOP;
      case '>':
      case '<': return ESMSCR_TOKEN_RELOP;
      case '.': return ESMSCR_TOKEN_VAROP;
      case ',': return ESMSCR_TOKEN_COMMA;
      default:  return ESMSCR_TOKEN_UNKNOWN;
     }
   }
	/* 2-byte operators */
  else if (pString[2] == NULL_CHAR) {
    switch (pString[0]) {
      case '-':
	if (pString[1] == '>') return (ESMSCR_TOKEN_FUNCOP);
	break;
      case '=':
      case '<':
      case '!':
      case '>': 
	if (pString[1] == '=') return (ESMSCR_TOKEN_RELOP);
      default: return (ESMSCR_TOKEN_UNKNOWN);
     }
   }

  return (ESMSCR_TOKEN_UNKNOWN);
 }
/*===========================================================================
 *		End of Function GetESMScriptOpToken()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const TCHAR* GetESMTokenName (Token);
 *
 * Returns a string for the given input token ID.
 *
 *=========================================================================*/
const TCHAR* GetESMTokenName (const int Token) {
  switch (Token) {
    case ESMSCR_BEGINBLOCK:	return _T("Begin Block");
    case ESMSCR_ENDTABLE:	return _T("End Table");
    case ESMSCR_TOKEN_UNKNOWN:	return _T("Unknown");
    case ESMSCR_TOKEN_INTEGER:	return _T("Integer");
    case ESMSCR_TOKEN_FLOAT:	return _T("Float");
    case ESMSCR_TOKEN_STRING:	return _T("String");
    case ESMSCR_TOKEN_SYMBOL:	return _T("Symbol");
    case ESMSCR_TOKEN_OPERATOR:	return _T("Operator");
    case ESMSCR_TOKEN_EOL:	return _T("End-of-Line");
    case ESMSCR_TOKEN_EOS:	return _T("End-of-File");
    case ESMSCR_TOKEN_BEGIN:	return _T("begin");
    case ESMSCR_TOKEN_END:	return _T("end");
    case ESMSCR_TOKEN_TYPEOP:	return _T("Type");
    case ESMSCR_TOKEN_SET:	return _T("set");
    case ESMSCR_TOKEN_TO:	return _T("to");
    case ESMSCR_TOKEN_OPENBRAC:	return _T("(");
    case ESMSCR_TOKEN_CLOSEBRAC:return _T(")");
    case ESMSCR_TOKEN_ADDOP:	return _T("+ or -");
    case ESMSCR_TOKEN_MULOP:	return _T("* or /");
    case ESMSCR_TOKEN_RELOP:	return _T("Compare Operator");
    case ESMSCR_TOKEN_IF:	return _T("if");
    case ESMSCR_TOKEN_ELSEIF:	return _T("elseif");
    case ESMSCR_TOKEN_ELSE:	return _T("else");
    case ESMSCR_TOKEN_ENDIF:	return _T("endif");
    case ESMSCR_TOKEN_WHILE:	return _T("while");
    case ESMSCR_TOKEN_ENDWHILE:	return _T("endwhile");
    case ESMSCR_TOKEN_RETURN:	return _T("return");
    case ESMSCR_TOKEN_GET:	return _T("get");
    case ESMSCR_TOKEN_NUMBER:	return _T("Number");
    case ESMSCR_TOKEN_COMMA:	return _T(",");
    case ESMSCR_TOKEN_FUNCOP:	return _T("->");
    case ESMSCR_TOKEN_VAROP:	return _T(".");
    case ESMSCR_TOKEN_XYZ:	return _T("X/Y/Z");
    case ESMSCR_TOKEN_LOCALVAR:	return _T("Local Variable");
    case ESMSCR_TOKEN_GLOBALVAR:return _T("Global Variable");
    case ESMSCR_TOKEN_FUNCTION:	return _T("Function");
    case ESMSCR_TOKEN_SYMBOLID:	return _T("Object ID");
    case ESMSCR_TOKEN_RESET:	return _T("reset");
#ifdef MWEDIT_SCRIPT_MWSE
    case ESMSCR_TOKEN_WHILEX:	return _T("whilex");
    case ESMSCR_TOKEN_SETX:	return _T("setx");
    case ESMSCR_TOKEN_IFX:	return _T("ifx");
#endif
    default:			return _T("Unknown");
   }
 }
/*===========================================================================
 *		End of Function TCHAR* GetESMTokenName()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool IsESMScriptOperator (pString);
 *
 * Returns true if the given operator is a valid ESM script operator.
 *
 *=========================================================================*/
bool IsESMScriptOperator (const TCHAR* pString) {
  //DEFINE_FUNCTION("IsESMScriptOperator()");

  switch (pString[0]) {
    case '(':
    case ')':
    case '*':
    case '+':
    case '/':
    case '.':
    case ',':
	if (pString[1] == NULL_CHAR) return (true);
	break;
    case '<':    
    case '>':
    case '=':
 	if (pString[1] == NULL_CHAR) return (true);
	if (TSTRCMP(pString+1, _T("=")) == 0) return (true);
	break;
    case '!':
	if (TSTRCMP(pString+1, _T("=")) == 0) return (true);
	break;
    case '-':
        if (pString[1] == NULL_CHAR) return (true);
	if (TSTRCMP(pString+1, _T(">")) == 0) return (true);
	break;
   }

  return (false);
 }
/*===========================================================================
 *		End of Function IsESMScriptOperator()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool IsESMScriptReserved (pString);
 *
 * Returns true if the given word is an ESM reserved script identifier.
 * Is 2.5x faster than IsESMScriptReserved1() in DEBUG builds and 
 * 4x faster in RELEASE builds. Roughly 0.22 secs for 100000 runs with 15
 * reserved words (RELEASE).
 *
 *=========================================================================*/
bool IsESMScriptReserved (const TCHAR* pString) {
  //DEFINE_FUNCTION("IsESMScriptReserved()");
  return (GetESMScriptResToken(pString) != ESMSCR_TOKEN_UNKNOWN);
 }


int GetESMScriptResToken (const TCHAR* pString) {

  switch (toupper(pString[0])) {
    case 'B':
	if (TSTRICMP(pString+1, _T("egin")) == 0) return (ESMSCR_TOKEN_BEGIN);
	break;
    case 'E':
	if (TSTRICMP(pString+1, _T("nd"))      == 0) return (ESMSCR_TOKEN_END);
	if (TSTRICMP(pString+1, _T("ndwhile")) == 0) return (ESMSCR_TOKEN_ENDWHILE);
	if (TSTRICMP(pString+1, _T("lse"))     == 0) return (ESMSCR_TOKEN_ELSE);
	if (TSTRICMP(pString+1, _T("lseif"))   == 0) return (ESMSCR_TOKEN_ELSEIF);
	if (TSTRICMP(pString+1, _T("ndif"))    == 0) return (ESMSCR_TOKEN_ENDIF);
	break;
    case 'I':
	if (TSTRICMP(pString+1, _T("f")) == 0) return (ESMSCR_TOKEN_IF);
#ifdef MWEDIT_SCRIPT_MWSE
	if (TSTRICMP(pString+1, _T("fx")) == 0) return (ESMSCR_TOKEN_IFX);
#endif
	break;
    case 'L':
	if (TSTRICMP(pString+1, _T("ong")) == 0) return (ESMSCR_TOKEN_TYPEOP);
	break;
    case 'F':
	if (TSTRICMP(pString+1, _T("loat")) == 0) return (ESMSCR_TOKEN_TYPEOP);
	break;
    case 'R':
	if (TSTRICMP(pString+1, _T("eturn"))   == 0) return (ESMSCR_TOKEN_RETURN);
//	if (TSTRICMP(pString+1, _T("eset"))    == 0) return (ESMSCR_TOKEN_RESET);
	break;
    case 'S':
	if (TSTRICMP(pString+1, _T("et"))   == 0) return (ESMSCR_TOKEN_SET);
	if (TSTRICMP(pString+1, _T("hort")) == 0) return (ESMSCR_TOKEN_TYPEOP);
#ifdef MWEDIT_SCRIPT_MWSE
	if (TSTRICMP(pString+1, _T("etx"))   == 0) return (ESMSCR_TOKEN_SETX);
#endif
	break;
    case 'T':
	if (TSTRICMP(pString+1, _T("o"))   == 0) return (ESMSCR_TOKEN_TO);
	break;
    case 'G':
	if (TSTRICMP(pString+1, _T("et")) == 0) return (ESMSCR_TOKEN_GET);
	break;
    case 'W':
	if (TSTRICMP(pString+1, _T("hile")) == 0) return (ESMSCR_TOKEN_WHILE);
#ifdef MWEDIT_SCRIPT_MWSE
	if (TSTRICMP(pString+1, _T("hilex")) == 0) return (ESMSCR_TOKEN_WHILEX);
#endif
	break;
    case 'X':
    case 'Y':
    case 'Z':
	if (pString[1] == NULL_CHAR) return (ESMSCR_TOKEN_XYZ);
	break;
   };

  return (ESMSCR_TOKEN_UNKNOWN);
 }
/*===========================================================================
 *		End of Function IsESMScriptReserved()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool IsESMScriptReserved1 (pString);
 *
 * Roughly 0.82 secs for 100000 runs with 15 reserved words (RELEASE).
 *
 *=========================================================================*/
bool IsESMScriptReserved1 (const TCHAR* pString) {
  //DEFINE_FUNCTION("IsESMScriptReserved1()");
  int Index;
  int Result;

  for (Index = 0; l_Reserved[Index] != NULL; Index++) {
    Result = TSTRICMP(l_Reserved[Index], pString);

    if (Result == 0) 
      return (true);
    else if (Result  > 0) 
      return (false);
   }

  return (false);
 }
/*===========================================================================
 *		End of Function IsESMScriptReserved1()
 *=========================================================================*/

