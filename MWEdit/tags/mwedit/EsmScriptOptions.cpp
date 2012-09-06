/*===========================================================================
 *
 * File:	Esmscriptoptions.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Tuesday, February 11, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "Stdafx.h"
#include "esmscriptoptions.h"
#include "EsmOptions.h"
#include "windows/WinUtil.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("EsmScriptOptions.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptOptions Constructor
 *
 *=========================================================================*/
CEsmScriptOptions::CEsmScriptOptions () {
  //DEFINE_FUNCTION("CEsmScriptOptions::CEsmScriptOptions()");
  CreateDefaultWhiteFormat();
  m_NoToolTips = false;
 }
/*===========================================================================
 *		End of Class CEsmScriptOptions Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptOptions Method - void Destroy (void);
 *
 *=========================================================================*/
void CEsmScriptOptions::Destroy (void) {
  //DEFINE_FUNCTION("CEsmScriptOptions::Destroy()");
 }
/*===========================================================================
 *		End of Class Method CEsmScriptOptions::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptOptions Method - void CreateDefaultWhiteFormat (void);
 *
 *=========================================================================*/
void CEsmScriptOptions::CreateDefaultWhiteFormat (void) {

	/* Create the default font */
  m_TextFont.Detach();
  CFONT_CREATE(m_TextFont, 8, FW_NORMAL, FALSE, "FixedSys");

	/* Set the background color */
  m_BackgroundColor = RGB(255,255,255);

	/* Set the default formats */
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_DEFAULT],	RGB(0,0,0));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_SYMBOL],	RGB(255,0,0));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_FUNCTION],	RGB(0,0,255));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_RESERVED],	RGB(0,128,0));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_INTEGER],	RGB(255,0,255));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_FLOAT],	RGB(255,0,255));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_STRING],	RGB(255,0,255));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_COMMENT],	RGB(128,128,128));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_OPERATOR],	RGB(64,64,64));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_ERROR],	RGB(255,128,128));

  m_Formats[ESMSCRIPT_FORMAT_ERROR].dwMask |= CFM_BACKCOLOR;
  m_Formats[ESMSCRIPT_FORMAT_ERROR].crBackColor = RGB(128,128,128);
  m_Formats[ESMSCRIPT_FORMAT_COMMENT].dwMask |= CFM_BACKCOLOR;
  m_Formats[ESMSCRIPT_FORMAT_COMMENT].crBackColor = RGB(255,128,128);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptOptions::CreateDefaultWhiteFormat()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptOptions Method - void CreateDefaultBlueFormat (void);
 *
 *=========================================================================*/
void CEsmScriptOptions::CreateDefaultBlueFormat (void) {

	/* Create the default font */
  m_TextFont.Detach(); 
  CFONT_CREATE(m_TextFont, 8, FW_NORMAL, FALSE, "FixedSys");

	/* Set the background color */
  m_BackgroundColor = RGB(0,0,128);

	/* Set the default formats */
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_DEFAULT],	RGB(0,255,0));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_SYMBOL],	RGB(128,128,255));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_FUNCTION],	RGB(255,128,128));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_RESERVED],	RGB(255,255,255));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_INTEGER],	RGB(172,172,172));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_FLOAT],	RGB(172,172,172));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_STRING],	RGB(255,0,255));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_COMMENT],	RGB(0,128,128));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_OPERATOR],	RGB(255,255,0));
  InitCharFormat(m_Formats[ESMSCRIPT_FORMAT_ERROR],	RGB(255,0,0));

  m_Formats[ESMSCRIPT_FORMAT_ERROR].dwMask |= CFM_BACKCOLOR;
  m_Formats[ESMSCRIPT_FORMAT_ERROR].crBackColor = RGB(255,0,0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptOptions::CreateDefaultBlueFormat()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptOptions Method - void InitCharFormat (Format, Color);
 *
 * Static class method that initializes the given format to the given text
 * color.
 *
 *=========================================================================*/
void CEsmScriptOptions::InitCharFormat (CHARFORMAT2& Format, COLORREF Color) {
  Format.cbSize	     = sizeof(Format);
  Format.dwMask	     = CFM_COLOR | CFM_BACKCOLOR;
  Format.crTextColor = Color;
  Format.dwEffects   = 0;
 }
/*===========================================================================
 *		End of Class Method CEsmScriptOptions::InitCharFormat()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptOptions Method - bool ReadFromRegistry (void);
 *
 * Read the script options from the applicatiom registry. Returns false
 * on any error.
 *
 *=========================================================================*/
bool CEsmScriptOptions::ReadFromRegistry (void) {
  CWinApp* pApp = AfxGetApp();
  bool	   Result;

	/* Input the background color */
  m_BackgroundColor = pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_BGCOLOR, m_BackgroundColor);
  m_NoToolTips      = (pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_NOTOOLTIPS, (int) m_NoToolTips) != 0);

	/* Input the various char format and font options */
  Result  = ReadRegCharFormat();
  Result &= ReadRegFont();

  return (Result);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptOptions::ReadFromRegistry()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptOptions Method - bool ReadRegCharFormat (void);
 *
 * Input the char formats from the registry. 
 *
 *=========================================================================*/
bool CEsmScriptOptions::ReadRegCharFormat (void) {
  CWinApp*	pApp = AfxGetApp();
  CString	RegName;
  CHARFORMAT2	CharFormat;
  BYTE*		pData = (BYTE *) &CharFormat;
  UINT		Size;
  BOOL		Result;
  int		Index;

	/* Input all the script formats */
  for (Index = 0; Index < ESMSCRIPT_NUMFORMATS; Index++) {
    RegName.Format(_T("%s%d"), ESMSCR_REGENTRY_CHARFORMAT, Index);
    Size = sizeof(CharFormat);
    Result = pApp->GetProfileBinary(ESMSCR_REGSEC_SCRIPT, RegName, &pData, &Size);

    if (Result) { 
      memcpy(&m_Formats[Index], pData,  sizeof(CHARFORMAT2));
      delete [] pData;
     }
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptOptions::ReadRegCharFormat()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptOptions Method - bool ReadRegFont (void);
 *
 * Input the font options from the registry.
 *
 *=========================================================================*/
bool CEsmScriptOptions::ReadRegFont (void) {
  CWinApp* pApp = AfxGetApp();
  CString  FontName = _T("FixedSys");
  int	   FontSize   = 8;
  int	   FontBold   = FW_NORMAL;
  int	   FontItalic = FALSE;
  
	/* Read the font options from the registry */
  FontSize   = pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_FONTSIZE, FontSize);
  FontBold   = pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_FONTBOLD, FontBold);
  FontItalic = pApp->GetProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_FONTITALIC, FontItalic);
  FontName   = pApp->GetProfileString(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_FONTNAME, FontName);

	/* Create the font object */
  m_TextFont.Detach();
  CFONT_CREATE(m_TextFont, FontSize, FontBold, FontItalic, FontName);

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptOptions::ReadRegFont()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptOptions Method - bool WriteToRegistry (void);
 *
 * Writes the script options to the registry. Reurns false on any error.
 *
 *=========================================================================*/
bool CEsmScriptOptions::WriteToRegistry (void) {
  CWinApp* pApp = AfxGetApp();
  bool	   Result;
  int	   iResult;

	/* Output the background color */
  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_BGCOLOR,    m_BackgroundColor);
  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_NOTOOLTIPS, (int) m_NoToolTips);

	/* Output the various char format and font options */
  Result  = WriteRegCharFormat();
  Result &= WriteRegFont();

  return (Result & (iResult != 0));
 }
/*===========================================================================
 *		End of Class Method CEsmScriptOptions::WriteToRegistry()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptOptions Method - bool WriteRegCharFormat (void);
 *
 * Writes the script user format to the registry. Reurns false on any error.
 *
 *=========================================================================*/
bool CEsmScriptOptions::WriteRegCharFormat (void) {
  CWinApp*	pApp = AfxGetApp();
  CString	RegName;
  BOOL		Result = TRUE;
  int		Index;

	/* Output all the script formats */
  for (Index = 0; Index < ESMSCRIPT_NUMFORMATS; Index++) {
    RegName.Format(_T("%s%d"), ESMSCR_REGENTRY_CHARFORMAT, Index);
    Result &= pApp->WriteProfileBinary(ESMSCR_REGSEC_SCRIPT, RegName, (BYTE *) &m_Formats[Index], sizeof(m_Formats[Index]));
   }

  return (Result != 0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptOptions::WriteRegCharFormat()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptOptions Method - bool WriteRegFont (void);
 *
 * Writes the script font options to the registry. Reurns false on any error.
 *
 *=========================================================================*/
bool CEsmScriptOptions::WriteRegFont (void) {
  CWinApp* pApp = AfxGetApp();
  LOGFONT  LogFont;
  int	   iResult;

	/* Attempt to get the font information */
  iResult = m_TextFont.GetLogFont(&LogFont);
  if (iResult == 0) return (false);
  
	/* Write the font options to the registry */
  iResult  = pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_FONTSIZE, LogFont.lfHeight);
  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_FONTBOLD,  LogFont.lfWeight);
  iResult &= pApp->WriteProfileInt(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_FONTITALIC, LogFont.lfItalic);
  iResult &= pApp->WriteProfileString(ESMSCR_REGSEC_SCRIPT, ESMSCR_REGENTRY_FONTNAME, LogFont.lfFaceName);

  return (iResult != 0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptOptions::WriteRegFont()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptOptions& CEsmScriptOptions Method - const operator= (Options);
 *
 *=========================================================================*/
const CEsmScriptOptions& CEsmScriptOptions::operator= (CEsmScriptOptions& Options) {
  LOGFONT LogFont;

	/* Copy the font object */
  m_TextFont.Detach();
  Options.m_TextFont.GetLogFont(&LogFont);
  m_TextFont.CreateFontIndirect(&LogFont);

	/* Copy the rest of the class members */
  m_BackgroundColor = Options.m_BackgroundColor;
  m_NoToolTips      = Options.m_NoToolTips;
  memcpy(&m_Formats[0], &Options.m_Formats[0], sizeof(m_Formats[0])*ESMSCRIPT_NUMFORMATS);

  return (*this);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptOptions& CEsmScriptOptions::operator=()
 *=========================================================================*/
