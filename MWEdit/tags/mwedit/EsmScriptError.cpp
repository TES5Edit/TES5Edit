/*===========================================================================
 *
 * File:	Esmscripterror.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 3, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "esmscripterror.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("EsmScriptError.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptError Constructor
 *
 *=========================================================================*/
CEsmScriptError::CEsmScriptError () {
  //DEFINE_FUNCTION("CEsmScriptError::CEsmScriptError()");
  m_pFunction	 = NULL;
  m_Type	 = ESMSCR_MESSAGE_WARNING;
  m_Code	 = 0;
  m_Line	 = 0;
  m_Character	 = 0;
  m_NumFuncArgs  = 0;
  m_FuncArgIndex = 0;
  m_TokenID      = 0;
 }
/*===========================================================================
 *		End of Class CEsmScriptError Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptError Method - void Destroy (void);
 *
 *=========================================================================*/
void CEsmScriptError::Destroy (void) {
  //DEFINE_FUNCTION("CEsmScriptError::Destroy()");

  m_pFunction	 = NULL;
  m_Code	 = 0;
  m_Line	 = 0;
  m_Character	 = 0;
  m_NumFuncArgs  = 0;
  m_FuncArgIndex = 0;
  m_TokenID      = 0;

  m_Token.Empty();
  m_Message.Empty();
 }
/*===========================================================================
 *		End of Class Method CEsmScriptError::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TCHAR* CEsmScriptError Method - const GetFuncArgString (void) const;
 *
 * Return a string of the current function argument, if any and if it is 
 * valid. Returns an "Invalid" string in any error. Uses a local static string
 * buffer;
 *
 *=========================================================================*/
const TCHAR* CEsmScriptError::GetFuncArgString(void) const {
  static TCHAR s_Buffer[64];

  if (m_pFunction == NULL) {
    strnncpy(s_Buffer, _T("No Function"), 63);
   }
  else if (m_FuncArgIndex < 0 || m_FuncArgIndex >= MWESM_SCRIPT_MAXARGS) {
    strnncpy(s_Buffer, _T("Invalid"), 63);
   }
  else if (m_pFunction->Var[m_FuncArgIndex] == 0) {
    strnncpy(s_Buffer, _T("Invalid"), 63);
   }
  else {
    snprintf (s_Buffer, 63, _T("0x%08X"), m_pFunction->Var[m_FuncArgIndex]);
   }

  return (s_Buffer);
 }
/*===========================================================================
 *		End of Class Method TCHAR* CEsmScriptError::GetFuncArgString()
 *=========================================================================*/
