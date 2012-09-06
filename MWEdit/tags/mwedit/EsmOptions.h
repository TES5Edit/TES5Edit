/*===========================================================================
 *
 * File:	Esmoptions.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	April 6, 2003
 *
 * Defines the CEsmOptions class, used for loading/save INI files and storing
 * various user options.
 *
 *=========================================================================*/
#ifndef __ESMOPTIONS_H
#define __ESMOPTIONS_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmDefs.h"
  #include "EsmOptionsDef.h"
  #include "EsmScriptOptions.h"
  #include "EsmRegDefs.h"
  #include "dl_str.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

  #define MWEDIT_DEFAULT_EXTRAFILE	_T("mweditextrafile.esp")
  #define MWEDIT_DEFAULT_SCRIPTINDENT	_T("\t")

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmOptions Definition
 *
 * Stores various user options and handles the input/output of config files.
 *
 *=========================================================================*/
class CEsmOptions {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CEsmScriptOptions	m_BlueScriptOptions;		/* Standard/user script settings */
  CEsmScriptOptions	m_WhiteScriptOptions;
  CEsmScriptOptions	m_UserScriptOptions;
  int			m_ScriptFormatType;

  bool			m_StrictIDs;			/* Only only certain IDs */

  bool			m_BackupSaves;			/* Backup plugins when saving */

  bool			m_AllowExtFuncs;		/* Allow extended MWSE functions */

  bool			m_NoScriptFormat;		/* Display script format or not? */
  bool			m_NoScriptPrompt;		/* No script compile prompt */
  
  int			m_ScriptWarnLevel;		/* The warning level of the compiler */

  TCHAR			m_ScriptIndentString[ESMSCR_OPTION_NAMESIZE+1];
  bool			m_InitialIndentLevel;
  bool			m_IndentCommentsMore;
  
				/* Default author name for new plugins */
  TCHAR			m_AuthorName[ESMSCR_OPTION_NAMESIZE+1];

				/* Optional custom game path */
  TCHAR			m_DataPath[_MAX_PATH + 4];

  bool			m_UseExtraFile;			/* Use extra file for script compilations */
  TCHAR			m_ExtraFile[_MAX_PATH + 4];

  bool			m_AllowBloodmoon;		/* Enable game specific features */
  bool			m_AllowTribunal;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CEsmOptions();
  virtual ~CEsmOptions() { Destroy(); }
  virtual void Destroy (void);

	/* Get class members */
  CEsmScriptOptions*	GetScriptOptions      (void);
  CEsmScriptOptions*	GetUserFormat	      (void) { return (&m_UserScriptOptions); }
  const TCHAR*		GetAuthorName	      (void) { return (m_AuthorName); }
  const TCHAR*		GetDataPath	      (void) { return (m_DataPath); }
  const TCHAR*		GetExtraFile	      (void) { return (m_ExtraFile); }
  const TCHAR*		GetScriptIndentString (void) { return (m_ScriptIndentString); }
  bool			GetInitialIndentLevel (void) { return (m_InitialIndentLevel); }
  bool			GetIndentCommentsMore (void) { return (m_IndentCommentsMore); }
  bool			GetStrictIDs          (void) { return (m_StrictIDs); }
  bool			GetNoScriptFormat     (void) { return (m_NoScriptFormat); }
  bool			GetNoToolTips	      (void) { return (m_UserScriptOptions.GetNoToolTips()); }
  bool			GetUseExtraFile	      (void) { return (m_UseExtraFile); }
  bool			GetNoScriptPrompt     (void) { return (m_NoScriptPrompt); }
  bool			GetBackupSaves        (void) { return (m_BackupSaves); }
  bool			GetAllowExtFuncs      (void) { return (m_AllowExtFuncs); }
  bool			GetAllowBloodmoon     (void) { return (m_AllowBloodmoon); }
  bool			GetAllowTribunal      (void) { return (m_AllowTribunal); }
  int			GetScriptWarnLevel    (void) { return (m_ScriptWarnLevel); }
  int			GetFormatType	      (void) { return (m_ScriptFormatType); }

  bool HasDataPath (void) const { return (m_DataPath[0] != NULL_CHAR); }

	/* Set class members */
  void SetBlueScript	     (void)	    { m_ScriptFormatType = ESMSCR_FORMAT_BLUE; }
  void SetUserScript	     (void)	    { m_ScriptFormatType = ESMSCR_FORMAT_USER; }
  void SetWhiteScript        (void)	    { m_ScriptFormatType = ESMSCR_FORMAT_WHITE; }
  void SetScriptWarnLevel    (const int Value) { m_ScriptWarnLevel  = Value; }
  void SetBackupSaves        (const bool Flag) { m_BackupSaves      = Flag; }
  void SetNoScriptFormat     (const bool Flag) { m_NoScriptFormat   = Flag; }
  void SetUseExtraFile       (const bool Flag) { m_UseExtraFile     = Flag; }
  void SetNoScriptPrompt     (const bool Flag) { m_NoScriptPrompt   = Flag; }
  void SetAllowExtFuncs      (const bool Flag) { m_AllowExtFuncs    = Flag; }
  void SetNoToolTips         (const bool Flag) { m_UserScriptOptions.SetNoToolTips(Flag); }
  void SetStrictIDs          (const bool Flag) { m_StrictIDs = Flag; }
  void SetInitialIndentLevel (const bool Flag) { m_InitialIndentLevel = Flag; }
  void SetIndentCommentsMore (const bool Flag) { m_IndentCommentsMore = Flag; }
  void SetAllowBloodmoon     (const bool Flag) { m_AllowBloodmoon = Flag; }
  void SetAllowTribunal      (const bool Flag) { m_AllowTribunal  = Flag; }
  void SetScriptIndentString (const TCHAR* pString) { strnncpy(m_ScriptIndentString, pString, ESMSCR_OPTION_NAMESIZE); }
  void SetAuthorName	     (const TCHAR* pString) { strnncpy(m_AuthorName, pString, ESMSCR_OPTION_NAMESIZE); }
  void SetDataPath	     (const TCHAR* pString) { strnncpy(m_DataPath,  pString, _MAX_PATH); }
  void SetExtraFile	     (const TCHAR* pString) { strnncpy(m_ExtraFile, pString, _MAX_PATH); }

	/* Read options from the registry */
  bool ReadFromRegistry (void);

	/* Write options to the registry */
  bool WriteToRegistry (void);

 };
/*===========================================================================
 *		End of Class CEsmOptions Definition
 *=========================================================================*/



#endif
/*===========================================================================
 *		End of File Esmoptions.H
 *=========================================================================*/
