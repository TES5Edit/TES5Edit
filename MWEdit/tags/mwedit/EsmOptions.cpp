/*===========================================================================
 *
 * File:	Esmoptions.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	April 6, 2003
 *
 * Implements the CEsmOptions class.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "esmoptions.h"
#include "dl_file.h"
#include "esmutils.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("EsmOptions.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptions Constructor
 *
 *=========================================================================*/
CEsmOptions::CEsmOptions () {
  //DEFINE_FUNCTION("CEsmOptions::CEsmOptions()");

	/* Initialize the script options */
  m_BlueScriptOptions.CreateDefaultBlueFormat();
  m_WhiteScriptOptions.CreateDefaultWhiteFormat();
  m_UserScriptOptions.CreateDefaultWhiteFormat();

  m_ScriptFormatType = ESMSCR_FORMAT_USER;
  m_AuthorName[0]    = NULL_CHAR;
  m_DataPath[0]      = NULL_CHAR;

  SetExtraFile(MWEDIT_DEFAULT_EXTRAFILE);
  SetScriptIndentString(MWEDIT_DEFAULT_SCRIPTINDENT);

  m_BackupSaves        = true;
  m_AllowExtFuncs      = true;
  m_StrictIDs          = true;
  m_IndentCommentsMore = true;
  m_UseExtraFile       = false;
  m_NoScriptPrompt     = false;
  m_NoScriptFormat     = false;
  m_InitialIndentLevel = true;
  m_AllowTribunal      = true;
  m_AllowBloodmoon     = true;

  m_ScriptWarnLevel = ESMSCR_COMPILEMSG_DEFAULT;
 }
/*===========================================================================
 *		End of Class CEsmOptions Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptions Method - void Destroy (void);
 *
 *=========================================================================*/
void CEsmOptions::Destroy (void) {
  //DEFINE_FUNCTION("CEsmOptions::Destroy()");

 }
/*===========================================================================
 *		End of Class Method CEsmOptions::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptions Method - CEsmScriptOptions* GetScriptOptions (void);
 *
 * Returns the script format options from the current type field.
 *
 *=========================================================================*/
CEsmScriptOptions* CEsmOptions::GetScriptOptions (void) {

  switch (m_ScriptFormatType) {
    case ESMSCR_FORMAT_WHITE:	return (&m_WhiteScriptOptions);
    case ESMSCR_FORMAT_BLUE:	return (&m_BlueScriptOptions);
    case ESMSCR_FORMAT_USER:
    default:			return (&m_UserScriptOptions);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmOptions::GetScriptOptions()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptions Method - bool ReadFromRegistry (void);
 *
 * Read the options from the registry. Returns false on any error.
 *
 *=========================================================================*/
bool CEsmOptions::ReadFromRegistry (void) {
  CWinApp* pApp = AfxGetApp();
  CString  Buffer;
  bool	   Result;

	/* General options */
  Buffer = pApp->GetProfileString(ESMSCR_REGSEC_GENERAL, ESMSCR_REGENTRY_AUTHORNAME, NULL);
  SetAuthorName(Buffer);

  Buffer = pApp->GetProfileString(ESMSCR_REGSEC_GENERAL, ESMSCR_REGENTRY_DATAPATH, NULL);
  SetDataPath(Buffer);
  TerminatePath(m_DataPath);

  if (Buffer.IsEmpty()) {
    FindMWRegistryPath();
  }
  else {
    SetMWDataPath(Buffer);
  }

  m_BackupSaves    = (pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_BACKUPSAVES,    m_BackupSaves) != 0);
  m_AllowExtFuncs  = (pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_ALLOWEXTFUNCS,  m_AllowExtFuncs) != 0);
  m_StrictIDs      = (pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_STRICTIDS,      m_StrictIDs) != 0);
  m_AllowBloodmoon = (pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_ALLOWBLOODMOON, m_AllowBloodmoon) != 0);
  m_AllowTribunal  = (pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_ALLOWTRIBUNAL,  m_AllowTribunal) != 0);

	/* Script options */
  m_ScriptWarnLevel    = pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_WARNLEVEL,     m_ScriptWarnLevel);
  m_NoScriptFormat     = (pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_NOSCRFORMAT,  m_NoScriptFormat) != 0);
  m_UseExtraFile       = (pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_USEEXTRAFILE, m_UseExtraFile) != 0);
  m_NoScriptPrompt     = (pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_NOSCRPROMPT,  m_NoScriptPrompt) != 0);
  m_InitialIndentLevel = (pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_INITIALINDENTLEVEL,  m_InitialIndentLevel) != 0);
  m_IndentCommentsMore = (pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_INDENTCOMMENTSMORE,  m_IndentCommentsMore) != 0);
  m_ScriptFormatType   = pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT,  ESMSCR_REGENTRY_SCRFORMAT,    m_ScriptFormatType);

  Buffer = pApp->GetProfileString(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_EXTRAFILE, m_ExtraFile);
  SetExtraFile(Buffer);

  Buffer = pApp->GetProfileString(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_SCRIPTINDENTSTRING, m_ScriptIndentString);
  SetScriptIndentString(Buffer);

	/* Script user format */
  Result = m_UserScriptOptions.ReadFromRegistry();
  return (Result);
 }
/*===========================================================================
 *		End of Class Method CEsmOptions::ReadFromRegistry()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptions Method - bool WriteToRegistry (void);
 *
 * Writes the options to the registry. Returns false on any error.
 *
 *=========================================================================*/
bool CEsmOptions::WriteToRegistry (void) {
  CWinApp* pApp = AfxGetApp();
  bool	   Result;
  int	   iResult;

  	/* General options */
  iResult  = pApp->WriteProfileString(ESMSCR_REGSEC_GENERAL, ESMSCR_REGENTRY_AUTHORNAME, m_AuthorName);
  iResult &= pApp->WriteProfileString(ESMSCR_REGSEC_GENERAL, ESMSCR_REGENTRY_DATAPATH,   m_DataPath);

  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_BACKUPSAVES,    m_BackupSaves);
  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_ALLOWEXTFUNCS,  m_AllowExtFuncs);
  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_STRICTIDS,      m_StrictIDs);
  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_ALLOWBLOODMOON, m_AllowBloodmoon);
  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_ALLOWTRIBUNAL,  m_AllowTribunal);
  
  	/* Script options */
  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_WARNLEVEL,    m_ScriptWarnLevel);
  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_NOSCRPROMPT,  m_NoScriptPrompt);
  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_INITIALINDENTLEVEL,  m_InitialIndentLevel);
  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_INDENTCOMMENTSMORE,  m_IndentCommentsMore);
  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_NOSCRFORMAT,  m_NoScriptFormat);
  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_USEEXTRAFILE, m_UseExtraFile);
  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_SCRFORMAT,    m_ScriptFormatType);
  iResult &= pApp->WriteProfileString(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_EXTRAFILE, m_ExtraFile);
  iResult &= pApp->WriteProfileString(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_SCRIPTINDENTSTRING, m_ScriptIndentString);

	/* Script user format */
  Result = m_UserScriptOptions.WriteToRegistry();
  return (Result & (iResult != 0));
 }
/*===========================================================================
 *		End of Class Method CEsmOptions::WriteToRegistry()
 *=========================================================================*/


