/*===========================================================================
 *
 * File:	Mwcustomfunc.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	August 21, 2006
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "mwcustomfunc.h"

/*===========================================================================
 *
 * Begin Global Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("MwCustomFunc.cpp");

	/* Global custom function map */
  CMwCustomFunctions g_CustomFunctions;

/*===========================================================================
 *		End of Global Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwCustomFunction Constructor
 *
 *=========================================================================*/
CMwCustomFunction::CMwCustomFunction () {
  //DEFINE_FUNCTION("CMwCustomFunction::CMwCustomFunction()");
  memset(&m_Data, 0, sizeof(m_Data));
 }
/*===========================================================================
 *		End of Class CMwCustomFunction Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwCustomFunction Method - bool Read (File, LineCount);
 *
 * Input function parameters from the current position in the given text
 * file. Returns false on any error.
 *
 *=========================================================================*/
bool CMwCustomFunction::Read (CGenFile& File, dword& LineCount) {
  TCHAR  Buffer[512];
  TCHAR* pVar;
  TCHAR* pValue;
  int    Result;

  while (!File.IsEOF()) {
    Result = File.ReadLine(Buffer, 500);
    if (Result == READLINE_ERROR) return (false);
    if (Result == READLINE_MSL) File.ReadLine(NULL);
    ++LineCount;
    m_LineCount = LineCount;

    Result = SeperateVarValueQ(&pVar, &pValue, Buffer);

    if (Result) {
      Result = SetParameter(pVar, pValue);
    }
    else if (stricmp(pVar, "end") == 0) {
      break;
    }
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CMwCustomFunction::Read()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwCustomFunction Method - dword ParseFuncOptions (Options, pValue);
 *
 * Parse and return function options from the given string. Returns false
 * on any error.
 *
 *=========================================================================*/
bool CMwCustomFunction::ParseFuncOptions (dword& Options, const char* pValue) {
  bool     ReturnValue = true;
  TCHAR    Buffer[512];
  TCHAR*   pParse;
  
  Options = 0;
  strnncpy(Buffer, pValue, 500);
  pParse = strtok(Buffer, "|");

  while (pParse != NULL) {
     pParse = trim(pParse);

     if (stricmp(pParse, "none") == 0) {
     }
     else if (stricmp(pParse, "shortvar") == 0) {
       Options |= ESMSCR_FUNC_ALLOWGLOBAL;
     }
     else if (stricmp(pParse, "allowglobal") == 0) {
       Options |= ESMSCR_FUNC_ALLOWGLOBAL;
     }
     else if (stricmp(pParse, "extrashort") == 0) {
       Options |= ESMSCR_FUNC_EXTRASHORT;
     }
     else if (stricmp(pParse, "nooptout") == 0) {
       Options |= ESMSCR_FUNC_NOOPTOUT;
     }
     else if (stricmp(pParse, "bloodmoon") == 0) {
       Options |= ESMSCR_FUNC_BLOODMOON;
     }
     else if (stricmp(pParse, "tribunal") == 0) {
       Options |= ESMSCR_FUNC_TRIBUNAL;
     }
     else if (stricmp(pParse, "dialogue") == 0) {
       Options |= ESMSCR_FUNC_DIALOGUE;
     }
     else if (stricmp(pParse, "bad") == 0) {
       Options |= ESMSCR_FUNC_BAD;
     }
     else if (stricmp(pParse, "allowvar") == 0) {
       Options |= ESMSCR_FUNC_VAR;
     }
     else if (stricmp(pParse, "mwse") == 0 || stricmp(pParse, "extended") == 0) {
       Options |= ESMSCR_FUNC_MWSE;
     }
     else if (stricmp(pParse, "mwe") == 0 || stricmp(pParse, "mwenhanced") == 0) {
       Options |= ESMSCR_FUNC_MWE;
     }
     else {
       ErrorHandler.AddError(ERR_BADINPUT, "%05d: Unknown function option '%s'!", m_LineCount, pParse);
       ReturnValue = false;
     }

     pParse = strtok(NULL, "|");
  }

  return (ReturnValue);
}
/*===========================================================================
 *		End of Class Method CMwCustomFunction::ParseFuncOptions()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwCustomFunction Method - dword ParseFuncArgOptions (Options, pValue);
 *
 * Parse and return function argument options from the given string. Returns
 * false on any error.
 *
 *=========================================================================*/
bool CMwCustomFunction::ParseFuncArgOptions (dword& Options, const char* pValue) {
  bool     ReturnValue = true;
  TCHAR    Buffer[512];
  TCHAR*   pParse;
  
  Options = 0;
  strnncpy(Buffer, pValue, 500);
  pParse = strtok(Buffer, "|");

  while (pParse != NULL) {
     pParse = trim(pParse);

     if (stricmp(pParse, "none") == 0) {
     }
     else if (stricmp(pParse, "byte") == 0) {
       Options |= ESMSCR_FUNC_BYTE;
     }
     else if (stricmp(pParse, "short") == 0) {
       Options |= ESMSCR_FUNC_SHORT;
     }
     else if (stricmp(pParse, "long") == 0 || stricmp(pParse, "ref") == 0) {
       Options |= ESMSCR_FUNC_LONG;
     }
     else if (stricmp(pParse, "float") == 0) {
       Options |= ESMSCR_FUNC_FLOAT;
     }
     else if (stricmp(pParse, "number") == 0) {
       Options |= ESMSCR_FUNC_NUMBER;
     }
     else if (stricmp(pParse, "string") == 0) {
       Options |= ESMSCR_FUNC_STRING;
     }
     else if (stricmp(pParse, "id") == 0) {
       Options |= ESMSCR_FUNC_ID;
     }
     else if (stricmp(pParse, "xyz") == 0) {
       Options |= ESMSCR_FUNC_XYZ;
     }
     else if (stricmp(pParse, "effect") == 0) {
       Options |= ESMSCR_FUNC_EFFECT;
     }
     else if (stricmp(pParse, "reset") == 0) {
       Options |= ESMSCR_FUNC_RESET;
     }
     else if (stricmp(pParse, "animation") == 0) {
       Options |= ESMSCR_FUNC_ANIM;
     }
     else if (stricmp(pParse, "optstart") == 0) {
       Options |= ESMSCR_FUNC_OPTSTART;
     }
     else if (stricmp(pParse, "optional") == 0) {
       Options |= ESMSCR_FUNC_OPTIONAL;
     }
     else if (stricmp(pParse, "notrequired") == 0) {
       Options |= ESMSCR_FUNC_NOTREQ;
     }
     else if (stricmp(pParse, "cellstring") == 0) {
       Options |= ESMSCR_FUNC_CELLSTR;
     }
     else if (stricmp(pParse, "shortstring") == 0) {
       Options |= ESMSCR_FUNC_SHORTSTR;
     }
     else if (stricmp(pParse, "many") == 0) {
       Options |= ESMSCR_FUNC_MANY;
     }
     else if (stricmp(pParse, "scriptid") == 0) {
       Options |= ESMSCR_FUNC_SCRIPTID;
     }
     else if (stricmp(pParse, "soundid") == 0) {
       Options |= ESMSCR_FUNC_SOUNDID;
     }
     else if (stricmp(pParse, "raceid") == 0) {
       Options |= ESMSCR_FUNC_RACEID;
     }
     else if (stricmp(pParse, "journalid") == 0) {
       Options |= ESMSCR_FUNC_JOURNALID;
     }
     else if (stricmp(pParse, "factionid") == 0) {
       Options |= ESMSCR_FUNC_FACTIONID;
     }
     else if (stricmp(pParse, "itemid") == 0) {
       Options |= ESMSCR_FUNC_ITEMID;
     }
     else if (stricmp(pParse, "regionid") == 0) {
       Options |= ESMSCR_FUNC_REGIONID;
     }
     else if (stricmp(pParse, "topicid") == 0) {
       Options |= ESMSCR_FUNC_TOPICID;
     }
     else if (stricmp(pParse, "cellid") == 0) {
       Options |= ESMSCR_FUNC_CELLID;
     }
     else if (stricmp(pParse, "effectid") == 0) {
       Options |= ESMSCR_FUNC_EFFECTID;
     }
     else if (stricmp(pParse, "levelcreatureid") == 0) {
       Options |= ESMSCR_FUNC_LEVELCID;
     }
     else if (stricmp(pParse, "levelitemid") == 0) {
       Options |= ESMSCR_FUNC_LEVELIID;
     }
     else if (stricmp(pParse, "soulgemid") == 0) {
       Options |= ESMSCR_FUNC_SOULGEMID;
     }
     else if (stricmp(pParse, "creatureid") == 0) {
       Options |= ESMSCR_FUNC_CREATUREID;
     }
     else if (stricmp(pParse, "spellid") == 0) {
       Options |= ESMSCR_FUNC_SPELLID;
     }
     else if (stricmp(pParse, "npcid") == 0) {
       Options |= ESMSCR_FUNC_NPCID;
     }
     else {
       ErrorHandler.AddError(ERR_BADINPUT, "%05d: Unknown function argument option '%s'!", m_LineCount, pParse);
       ReturnValue = false;
     }

     pParse = strtok(NULL, "|");
  }

  return (ReturnValue);
}
/*===========================================================================
 *		End of Class Method CMwCustomFunction::ParseFuncArgOptions()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwCustomFunction Method - dword ParseReturnOptions (Options, pValue);
 *
 * Parse and return function return options from the given string. Returns
 * false on any error.
 *
 *=========================================================================*/
bool CMwCustomFunction::ParseReturnOptions (dword& Options, const char* pValue) {
  bool     ReturnValue = true;
  TCHAR    Buffer[512];
  TCHAR*   pParse;
  
  Options = 0;
  strnncpy(Buffer, pValue, 500);
  pParse = strtok(Buffer, "|");

  while (pParse != NULL) {
     pParse = trim(pParse);

     if (stricmp(pParse, "none") == 0) {
     }
     else if (stricmp(pParse, "byte") == 0) {
       Options |= ESMSCR_FUNC_BYTE;
     }
     else if (stricmp(pParse, "short") == 0) {
       Options |= ESMSCR_FUNC_SHORT;
     }
     else if (stricmp(pParse, "long") == 0 || stricmp(pParse, "ref") == 0) {
       Options |= ESMSCR_FUNC_LONG;
     }
     else if (stricmp(pParse, "float") == 0) {
       Options |= ESMSCR_FUNC_FLOAT;
     }
     else if (stricmp(pParse, "string") == 0) {
       Options |= ESMSCR_FUNC_STRING;
     }
     else if (stricmp(pParse, "many") == 0) {
       Options |= ESMSCR_FUNC_MANY;
     }
     else {
       ErrorHandler.AddError(ERR_BADINPUT, "%05d: Unknown function return option '%s'!", m_LineCount, pParse);
       ReturnValue = false;
     }

     pParse = strtok(NULL, "|");
  }

  return (ReturnValue);
}
/*===========================================================================
 *		End of Class Method CMwCustomFunction::ParseReturnOptions()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwCustomFunction Method - bool SetParameter (pVariable, pValue);
 *
 * Attempts to set a function parameter using the given inputs. Returns
 * false on any error.
 *
 *=========================================================================*/
bool CMwCustomFunction::SetParameter (const char* pVariable, const char* pValue) {
  dword Options;
  bool  Result;

  if (stricmp(pVariable, "name") == 0) {
    SetName(pValue);
    return (true);
  }
  else if (stricmp(pVariable, "opcode") == 0) {
    dword OpCode = strtoul(pValue, NULL, 0);
    SetOpCode((short) OpCode);
    return (OpCode != 0);
  }
  else if (stricmp(pVariable, "options") == 0) {
    Result = ParseFuncOptions(Options, pValue);
    SetOptions(Options);
    return (Result);
  }
  else if (stricmp(pVariable, "return") == 0) {
    Result = ParseReturnOptions(Options, pValue);
    SetReturnOptions(Options);
    return (Result);
  }
  else if (stricmp(pVariable, "param1") == 0) {
    Result = ParseFuncArgOptions(Options, pValue);
    SetArgOptions(0, Options);
    return (Result);
  }
  else if (stricmp(pVariable, "param2") == 0) {
    Result = ParseFuncArgOptions(Options, pValue);
    SetArgOptions(1, Options);
    return (Result);
  }
  else if (stricmp(pVariable, "param3") == 0) {
    Result = ParseFuncArgOptions(Options, pValue);
    SetArgOptions(2, Options);
    return (Result);
  }
  else if (stricmp(pVariable, "param4") == 0) {
    Result = ParseFuncArgOptions(Options, pValue);
    SetArgOptions(3, Options);
    return (Result);
  }
  else if (stricmp(pVariable, "param5") == 0) {
    Result = ParseFuncArgOptions(Options, pValue);
    SetArgOptions(4, Options);
    return (Result);
  }
  else if (stricmp(pVariable, "param6") == 0) {
    Result = ParseFuncArgOptions(Options, pValue);
    SetArgOptions(5, Options);
    return (Result);
  }
  else if (stricmp(pVariable, "param7") == 0) {
    Result = ParseFuncArgOptions(Options, pValue);
    SetArgOptions(6, Options);
    return (Result);
  }
  else if (stricmp(pVariable, "param8") == 0) {
    Result = ParseFuncArgOptions(Options, pValue);
    SetArgOptions(7, Options);
    return (Result);
  }
  else if (stricmp(pVariable, "param9") == 0) {
    Result = ParseFuncArgOptions(Options, pValue);
    SetArgOptions(8, Options);
    return (Result);
  }
  else if (stricmp(pVariable, "param10") == 0) {
    Result = ParseFuncArgOptions(Options, pValue);
    SetArgOptions(9, Options);
    return (Result);
  }
  else if (stricmp(pVariable, "param11") == 0) {
    Result = ParseFuncArgOptions(Options, pValue);
    SetArgOptions(10, Options);
    return (Result);
  }
  else if (stricmp(pVariable, "param12") == 0) {
    Result = ParseFuncArgOptions(Options, pValue);
    SetArgOptions(11, Options);
    return (Result);
  }

  ErrorHandler.AddError(ERR_BADINPUT, "Unknown function parameter '%s'!", pVariable);
  return (false);
}
/*===========================================================================
 *		End of Class Method CMwCustomFunction::SetParameter()
 *=========================================================================*/
 

/*===========================================================================
 *
 * Function - bool ReadMwCustomFunctions (Functions, pFilename);
 *
 * Input custom functions from the given file. Returns false on any error.
 *
 *=========================================================================*/
bool ReadMwCustomFunctions (CMwCustomFunctions& Functions, const char* pFilename) {
  DEFINE_FUNCTION("ReadMwCustomFunctions()");
  CMwCustomFunction*	pFunction;
  CGenFile		File;
  dword			LineCount = 0;
  char			Buffer[512];
  char*			pVar;
  char*			pValue;
  int			Result;

	/* Clear the current content */
  Functions.RemoveAll();

  Result = File.Open(pFilename, "rb");
  if (!Result) return (false);

  while (!File.IsEOF()) {
    Result = File.ReadLine(Buffer, 500);
    if (Result == READLINE_ERROR) return (false);
    if (Result == READLINE_MSL) File.ReadLine(NULL);
    ++LineCount;

    SeperateVarValueQ(&pVar, &pValue, Buffer);

    if (stricmp(pVar, "function") == 0) {
      CreatePointer(pFunction, CMwCustomFunction);

      Result = pFunction->Read(File, LineCount);
      Functions.SetAt(pFunction->GetName(), pFunction);
      if (!Result) return (false);
    }
    else if (*pVar != NULL_CHAR) {
       ErrorHandler.AddError(ERR_BADINPUT, "Unknown function parameter '%s'!", pVar);
    }
  }

  return (true);
}
/*===========================================================================
 *		End of Function ReadMwCustomFunctions()
 *=========================================================================*/
 