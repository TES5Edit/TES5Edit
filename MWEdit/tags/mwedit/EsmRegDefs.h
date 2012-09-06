/*===========================================================================
 *
 * File:	Esmregdefs.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 7, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMREGDEFS_H
#define __ESMREGDEFS_H


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Registry sections */
  #define ESMSCR_REGSEC_GENERAL		_T("General")
  #define ESMSCR_REGSEC_SCRIPT		_T("Script")
  #define ESMSCR_REGSEC_USERFORMAT	_T("UserFormat")
  #define ESMSCR_REGSEC_FINDHISTORY	_T("FindHistory")

	/* Registry entries */
  #define ESMSCR_REGENTRY_WARNLEVEL	_T("ScriptWarnLevel")
  #define ESMSCR_REGENTRY_NOSCRFORMAT	_T("NoScriptFormat")
  #define ESMSCR_REGENTRY_SCRFORMAT	_T("ScriptFormatType")
  #define ESMSCR_REGENTRY_CHARFORMAT	_T("CharFormat")
  #define ESMSCR_REGENTRY_NOFORMAT	_T("NoFormat")
  #define ESMSCR_REGENTRY_BGCOLOR	_T("BGColor")
  #define ESMSCR_REGENTRY_NOTOOLTIPS	_T("NoToolTips")
  #define ESMSCR_REGENTRY_FONTSIZE	_T("FontSize")
  #define ESMSCR_REGENTRY_FONTITALIC	_T("FontItalic")
  #define ESMSCR_REGENTRY_FONTBOLD	_T("FontBold")
  #define ESMSCR_REGENTRY_FONTNAME	_T("FontName")
  #define ESMSCR_REGENTRY_FIND		_T("Find")
  #define ESMSCR_REGENTRY_AUTHORNAME	_T("AuthorName")
  #define ESMSCR_REGENTRY_DATAPATH	_T("DataPath")
  #define ESMSCR_REGENTRY_BACKUPSAVES   _T("BackupSaves")
  #define ESMSCR_REGENTRY_ALLOWEXTFUNCS _T("AllowExtFuncs")
  #define ESMSCR_REGENTRY_NOSCRPROMPT   _T("NoScriptPrompt")
  #define ESMSCR_REGENTRY_USEEXTRAFILE  _T("UseExtraFile")
  #define ESMSCR_REGENTRY_EXTRAFILE     _T("ExtraFile")
  #define ESMSCR_REGENTRY_STRICTIDS     _T("StrictIDs")
  #define ESMSCR_REGENTRY_SCRIPTINDENTSTRING _T("ScriptIndentString")
  #define ESMSCR_REGENTRY_INITIALINDENTLEVEL _T("InitialIndentLevel")
  #define ESMSCR_REGENTRY_INDENTCOMMENTSMORE _T("IndentCommentsMore")
  #define ESMSCR_REGENTRY_ALLOWBLOODMOON _T("AllowBloodmoon")
  #define ESMSCR_REGENTRY_ALLOWTRIBUNAL  _T("AllowTribunal")

	/* Number of find history records to save */
  #define ESMSCR_FINDHISTORY_NUMRECORDS	10

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Esmregdefs.H
 *=========================================================================*/
