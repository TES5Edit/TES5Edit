/*===========================================================================
 *
 * File:	Esmgloboptions.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 7, 2003
 *
 * Implements the global functions for accessing and returning the
 * various MWEdit options.
 *
 *=========================================================================*/

	/* Include Files */
#include "Stdafx.h"
#include "esmgloboptions.h"
#include "EsmOptions.h"
#include "MwEdit.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("EsmGlobOptions.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool GetEsmOptAllowBloodmoon (void);
 *
 *=========================================================================*/
bool GetEsmOptAllowBloodmoon (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetAllowBloodmoon());
}
/*===========================================================================
 *		End of Function GetEsmOptAllowBloodmoon()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool GetEsmOptAllowTribunal (void);
 *
 *=========================================================================*/
bool GetEsmOptAllowTribunal (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetAllowTribunal());
}
/*===========================================================================
 *		End of Function GetEsmOptAllowTribunal()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool GetEsmOptNoScriptFormat (void);
 *
 * Returns the current no-script-format options flag.
 *
 *=========================================================================*/
bool GetEsmOptNoScriptFormat (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetNoScriptFormat());
 }
/*===========================================================================
 *		End of Function GetEsmOptNoScriptFormat()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool GetEsmOptBackupSaves (void);
 *
 *=========================================================================*/
bool GetEsmOptBackupSaves (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetBackupSaves());
 }
/*===========================================================================
 *		End of Function GetEsmOptBackupSaves()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool GetEsmOptStrictIDs (void);
 *
 *=========================================================================*/
bool GetEsmOptStrictIDs (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetStrictIDs());
 }
/*===========================================================================
 *		End of Function GetEsmOptStrictIDs()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool GetEsmOptInitialIndentLevel (void);
 *
 *=========================================================================*/
bool GetEsmOptInitialIndentLevel (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetInitialIndentLevel());
 }
/*===========================================================================
 *		End of Function GetEsmOptInitialIndentLevel()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool GetEsmOptIndentCommentsMore (void);
 *
 *=========================================================================*/
bool GetEsmOptIndentCommentsMore (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetIndentCommentsMore());
 }
/*===========================================================================
 *		End of Function GetEsmOptIndentCommentsMore()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool GetEsmOptNoScriptPrompt (void);
 *
 *=========================================================================*/
bool GetEsmOptNoScriptPrompt (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetNoScriptPrompt());
 }
/*===========================================================================
 *		End of Function GetEsmOptNoScriptPrompt()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool GetEsmOptUseExtraFile (void);
 *
 *=========================================================================*/
bool GetEsmOptUseExtraFile (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetUseExtraFile());
 }
/*===========================================================================
 *		End of Function GetEsmOptUseExtraFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool GetEsmOptAllowExtFuncs (void);
 *
 *=========================================================================*/
bool GetEsmOptAllowExtFuncs (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetAllowExtFuncs());
 }
/*===========================================================================
 *		End of Function GetEsmOptAllowExtFuncs()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int GetEsmOptScriptWarnLevel (void);
 *
 * Returns the current script compiler message level setting.
 *
 *=========================================================================*/
int GetEsmOptScriptWarnLevel (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetScriptWarnLevel());
 }
/*===========================================================================
 *		End of Function GetEsmOptScriptWarnLevel()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int GetEsmOptScriptFormatType (void);
 *
 * Return the current type of the script format.
 *
 *=========================================================================*/
int GetEsmOptScriptFormatType (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetFormatType());
 }
/*===========================================================================
 *		End of Function GetEsmOptScriptFormatType()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - CEsmScriptOptions* GetEsmOptScriptOptions (void);
 *
 * Gets the current script options object.
 *
 *=========================================================================*/
CEsmScriptOptions* GetEsmOptScriptOptions (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetScriptOptions());
 }
/*===========================================================================
 *		End of Function GetEsmOptScriptOptions()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const TCHAR* GetEsmOptDefaultAuthor (void);
 *
 * Returns the default author string from the application options.
 *
 *=========================================================================*/
const TCHAR* GetEsmOptDefaultAuthor (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetAuthorName());
 }
/*===========================================================================
 *		End of Function TCHAR* GetEsmOptDefaultAuthor()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const TCHAR* GetEsmOptExtraFile (void);
 *
 *=========================================================================*/
const TCHAR* GetEsmOptExtraFile (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetExtraFile());
 }
/*===========================================================================
 *		End of Function TCHAR* GetEsmOptExtraFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const TCHAR* GetEsmOptScriptIndentString (void);
 *
 *=========================================================================*/
const TCHAR* GetEsmOptScriptIndentString (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  return (pApp->GetOptions()->GetScriptIndentString());
 }
/*===========================================================================
 *		End of Function TCHAR* GetEsmOptScriptIndentString()
 *=========================================================================*/

