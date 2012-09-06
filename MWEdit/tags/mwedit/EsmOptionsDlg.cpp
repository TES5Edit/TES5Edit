/*===========================================================================
 *
 * File:	EsmOptionsDlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 6, 2003
 *
 * Implements the CEsmOptionsDlg class for the options dialog.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmOptionsDlg.h"
#include "windows/WinUtil.h"
#include "esmutils.h"
#include "esmscriptcompile.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif

  DEFINE_FILE("EsmOptionsDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmOptionsDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmOptionsDlg, CDialog)
  //{{AFX_MSG_MAP(CEsmOptionsDlg)
  ON_CBN_SELCHANGE(IDC_FONTFACE_LIST, OnSelchangeFontfaceList)
  ON_CBN_SELCHANGE(IDC_FONTSIZE_LIST, OnSelchangeFontsizeList)
  ON_BN_CLICKED(IDC_FONTBOLD_CHECK, OnFontboldCheck)
  ON_BN_CLICKED(IDC_FONTITALIC_CHECK, OnFontitalicCheck)
  ON_BN_CLICKED(IDC_FORMATCOLOR, OnFormatcolor)
  ON_LBN_SELCHANGE(IDC_FORMAT_LIST, OnSelchangeFormatList)
  ON_BN_CLICKED(IDC_BGCOLOR, OnBgcolor)
  ON_BN_CLICKED(IDC_BLUEFORMAT_BUTTON, OnBlueformatButton)
  ON_BN_CLICKED(IDC_WHITEFORMAT_BUTTON, OnWhiteformatButton)
  ON_BN_CLICKED(IDC_BROWSEGAMEPATH, OnBrowsegamepath)
  ON_BN_CLICKED(IDC_BROWSEEXTRAFILE, OnBrowseextrafile)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmOptionsDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Constructor
 *
 *=========================================================================*/
CEsmOptionsDlg::CEsmOptionsDlg(CWnd* pParent) : CDialog(CEsmOptionsDlg::IDD, pParent) {
  //{{AFX_DATA_INIT(CEsmOptionsDlg)
  //}}AFX_DATA_INIT
  m_pOrigOptions = NULL;
  m_CurrentFormat = -1;
 }
/*===========================================================================
 *		End of Class CEsmOptionsDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmOptionsDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmOptionsDlg)
  DDX_Control(pDX, IDC_ALLOWTRIBUNAL, m_AllowTribunal);
  DDX_Control(pDX, IDC_ALLOWBLOODMOON, m_AllowBloodmoon);
  DDX_Control(pDX, IDC_INDENTCOMMENTSMORE, m_IndentCommentsMore);
  DDX_Control(pDX, IDC_INDENTSPACES_TEXT, m_IndentSpacesText);
  DDX_Control(pDX, IDC_INDENTSPACES, m_IndentSpace);
  DDX_Control(pDX, IDC_INDENTTABS, m_IndentTab);
  DDX_Control(pDX, IDC_INITIALINDENTLEVEL, m_InitialIndentLevel);
  DDX_Control(pDX, IDC_STRICTIDS, m_StrictIDs);
  DDX_Control(pDX, IDC_USEEXTRAFILE, m_UseExtraFile);
  DDX_Control(pDX, IDC_EXTRAFILE_TEXT, m_ExtraFile);
  DDX_Control(pDX, IDC_NOSCRIPTPROMPT_CHECK, m_NoScriptPrompt);
  DDX_Control(pDX, IDC_ALLOWEXTFUNCS_CHECK, m_AllowExtFuncs);
  DDX_Control(pDX, IDC_BACKUPSAVES, m_BackupSaves);
  DDX_Control(pDX, IDC_AUTHOR_TEXT2, m_GamePath);
  DDX_Control(pDX, IDC_NOTOOLTIP_CHECK, m_NoToolTipCheck);
  DDX_Control(pDX, IDC_AUTHOR_TEXT, m_AuthorText);
  DDX_Control(pDX, IDC_BGCOLOR, m_BGColor);
  DDX_Control(pDX, IDC_FORMATCOLOR, m_FormatColor);
  DDX_Control(pDX, IDC_SAMPLE_TEXT, m_SampleText);
  DDX_Control(pDX, IDC_FONTITALIC_CHECK, m_FontItalicCheck);
  DDX_Control(pDX, IDC_FONTBOLD_CHECK, m_FontBoldCheck);
  DDX_Control(pDX, IDC_FONTFACE_LIST, m_FontFaceList);
  DDX_Control(pDX, IDC_FONTSIZE_LIST, m_FontSizeList);
  DDX_Control(pDX, IDC_FORMAT_LIST, m_FormatList);
  DDX_Control(pDX, IDC_NOFORMAT_CHECK, m_NoFormatCheck);
  DDX_Control(pDX, IDC_WARNLEVEL_LIST, m_WarnLevelList);
	//}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmOptionsDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Method - void FillFormatList (void);
 *
 * Fills the format list with the format names.
 *
 *=========================================================================*/
void CEsmOptionsDlg::FillFormatList (void) {

	/* Clear the current list */
  m_FormatList.ResetContent();
  m_CurrentFormat = -1;

	/* Add the script format types */
  AddListString(m_FormatList, _T("Text"),	ESMSCRIPT_FORMAT_DEFAULT);
  AddListString(m_FormatList, _T("Symbol"),	ESMSCRIPT_FORMAT_SYMBOL);
  AddListString(m_FormatList, _T("Function"),	ESMSCRIPT_FORMAT_FUNCTION);
  AddListString(m_FormatList, _T("Reserved"),	ESMSCRIPT_FORMAT_RESERVED);
  AddListString(m_FormatList, _T("Integer"),	ESMSCRIPT_FORMAT_INTEGER);
  AddListString(m_FormatList, _T("Float"),	ESMSCRIPT_FORMAT_FLOAT);
  AddListString(m_FormatList, _T("String"),	ESMSCRIPT_FORMAT_STRING);
  AddListString(m_FormatList, _T("Comment"),	ESMSCRIPT_FORMAT_COMMENT);
  AddListString(m_FormatList, _T("Operator"),	ESMSCRIPT_FORMAT_OPERATOR);
  AddListString(m_FormatList, _T("Error"),	ESMSCRIPT_FORMAT_ERROR);
 }
/*===========================================================================
 *		End of Class Method CEsmOptionsDlg::FillFormatList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Method - void FillFontSizeList (void);
 *
 * Fills the font size list.
 *
 *=========================================================================*/
void CEsmOptionsDlg::FillFontSizeList (void) {

	/* Clear the current list */
  m_FontSizeList.ResetContent();

  	/* Add the font sizes */
  AddComboString(m_FontSizeList, _T("6"),	6);
  AddComboString(m_FontSizeList, _T("7"),	7);
  AddComboString(m_FontSizeList, _T("8"),	8);
  AddComboString(m_FontSizeList, _T("9"),	9);
  AddComboString(m_FontSizeList, _T("10"),	10);
  AddComboString(m_FontSizeList, _T("11"),	11);
  AddComboString(m_FontSizeList, _T("12"),	12);
  AddComboString(m_FontSizeList, _T("13"),	13);
  AddComboString(m_FontSizeList, _T("14"),	14);
  AddComboString(m_FontSizeList, _T("15"),	15);
  AddComboString(m_FontSizeList, _T("16"),	16);
  AddComboString(m_FontSizeList, _T("18"),	18);
  AddComboString(m_FontSizeList, _T("20"),	20);
 }
/*===========================================================================
 *		End of Class Method CEsmOptionsDlg::FillFontSizeList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Method - void FillFontNameList (void);
 *
 * Fills the font name list.
 *
 *=========================================================================*/
void CEsmOptionsDlg::FillFontNameList (void) {

	/* Clear the current list */
  m_FontFaceList.ResetContent();

	/* Add the font names (fixed for now) */
  m_FontFaceList.AddString(_T("Fixedsys"));
  m_FontFaceList.AddString(_T("Courier"));
  m_FontFaceList.AddString(_T("Courier New"));
  m_FontFaceList.AddString(_T("Times New Roman"));
  m_FontFaceList.AddString(_T("MS Sans Serif"));
  m_FontFaceList.AddString(_T("Arial"));
  m_FontFaceList.AddString(_T("Terminal"));
 }
/*===========================================================================
 *		End of Class Method CEsmOptionsDlg::FillFontNameList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Method - void FillWarnLevelList (void);
 *
 * Fill the warning level list with the level types.
 *
 *=========================================================================*/
void CEsmOptionsDlg::FillWarnLevelList (void) {
  int ListIndex;

	/* Clear the current list */
  m_WarnLevelList.ResetContent();

	/* Add the warning level types */
  ListIndex = m_WarnLevelList.AddString(_T("Strong"));
  if (ListIndex >= 0) m_WarnLevelList.SetItemData(ListIndex, ESMSCR_COMPILEMSG_STRONG);
  ListIndex = m_WarnLevelList.AddString(_T("Default"));
  if (ListIndex >= 0) m_WarnLevelList.SetItemData(ListIndex, ESMSCR_COMPILEMSG_DEFAULT);
  ListIndex = m_WarnLevelList.AddString(_T("Weak"));
  if (ListIndex >= 0) m_WarnLevelList.SetItemData(ListIndex, ESMSCR_COMPILEMSG_WEAK);
 }
/*===========================================================================
 *		End of Class Method CEsmOptionsDlg::FillWarnLevelList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Method - void GetControlData (void);
 *
 * Save the control data to the original options object.
 *
 *=========================================================================*/
void CEsmOptionsDlg::GetControlData (void) {
  CString Buffer;
  int     ListIndex;
  int     Count;
  bool    Result;

	/* Ensure a valid options object */
  if (m_pOrigOptions == NULL) return;

	/* General options */
  m_AuthorText.GetWindowText(Buffer);
  m_pOrigOptions->SetAuthorName(Buffer);

  m_GamePath.GetWindowText(Buffer);
  TerminatePathString(Buffer);
  m_pOrigOptions->SetDataPath(Buffer);

  if (Buffer.IsEmpty()) {
    FindMWRegistryPath();
  }
  else {
    SetMWDataPath(Buffer);
  } 

  m_pOrigOptions->SetBackupSaves(m_BackupSaves.GetCheck() != 0);
  m_pOrigOptions->SetAllowExtFuncs(m_AllowExtFuncs.GetCheck() != 0);
  m_pOrigOptions->SetStrictIDs(m_StrictIDs.GetCheck() != 0);

  m_pOrigOptions->SetAllowBloodmoon(m_AllowBloodmoon.GetCheck() != 0);
  m_pOrigOptions->SetAllowTribunal(m_AllowTribunal.GetCheck() != 0);
  
	/* Save the script no-format flag and script warning level */
  m_pOrigOptions->SetNoScriptFormat(m_NoFormatCheck.GetCheck() != 0);
  m_pOrigOptions->SetNoScriptPrompt(m_NoScriptPrompt.GetCheck() != 0);
  m_pOrigOptions->SetNoToolTips(m_NoToolTipCheck.GetCheck() != 0);
  m_pOrigOptions->SetUseExtraFile(m_UseExtraFile.GetCheck() != 0);
  ListIndex = m_WarnLevelList.GetCurSel();
  if (ListIndex >= 0) m_pOrigOptions->SetScriptWarnLevel(m_WarnLevelList.GetItemData(ListIndex));

	/* Get the extra file */
  m_ExtraFile.GetWindowText(Buffer);
  Buffer.TrimLeft(_T(" \t\n\r"));
  Buffer.TrimRight(_T(" \t\n\r"));
  m_pOrigOptions->SetExtraFile(Buffer);

	/* Refresh the file contents if required */
  if (Buffer.IsEmpty()) {
    CEsmScriptCompile::GetExtraFile().Destroy();
    CEsmScriptCompile::InitializeExtraRecords();
  }
  else {
    Result = CEsmScriptCompile::GetExtraFile().Read(Buffer);
    CEsmScriptCompile::InitializeExtraRecords();
    if (m_pOrigOptions->GetUseExtraFile() && !Result) ErrorHandler.Notify(_T("Failed to read the extra file!"), _T("MWEdit Error"));
  }

  	/* Indentation values */
  m_pOrigOptions->SetInitialIndentLevel(m_InitialIndentLevel.GetCheck() != 0);
  m_pOrigOptions->SetIndentCommentsMore(m_IndentCommentsMore.GetCheck() != 0);

  if (m_IndentSpace.GetCheck()) {
    m_IndentSpacesText.GetWindowText(Buffer);
    Count = atoi(Buffer);
    if (Count <  0) Count = 0;
    if (Count > 16) Count = 16;
    Buffer.Empty();

    for (int i = 0; i < Count; ++i) {
      Buffer += " ";
    }

    m_pOrigOptions->SetScriptIndentString(Buffer);
  }
  else {
    m_pOrigOptions->SetScriptIndentString("\t");
  }

  if (m_pOrigOptions->GetScriptIndentString()[0] == ' ') {
    
    Buffer.Format(_T("%d"), _tcslen(m_pOrigOptions->GetScriptIndentString()));
   
  }
  else {
  }

	/* Update the current format data */
  GetFormatData();
  memcpy(m_pOrigOptions->GetUserFormat()->GetCharFormat(0), m_ScriptOptions.GetCharFormat(0), sizeof(CHARFORMAT2)*ESMSCRIPT_NUMFORMATS);
  m_pOrigOptions->GetUserFormat()->SetBGColor(m_BGColor.m_Color);

	/* Update the font data */
  GetFontData(m_pOrigOptions->GetUserFormat()->GetTextFont());
 }
/*===========================================================================
 *		End of Class Method CEsmOptionsDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Method - void GetFormatData (void);
 *
 * Gets the format data from the controls if required.
 *
 *=========================================================================*/
void CEsmOptionsDlg::GetFormatData (void) {
  CHARFORMAT2* pFormat;
  int	       FormatIndex;
  
	/* Ignore if the current format is not valid */
  if (m_CurrentFormat < 0) return;

  FormatIndex = m_FormatList.GetItemData(m_CurrentFormat);
  pFormat = m_ScriptOptions.GetCharFormat(FormatIndex);
  pFormat->crTextColor = m_FormatColor.m_Color;
 }
/*===========================================================================
 *		End of Class Method CEsmOptionsDlg::GetFormatData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Method - void GetFontData (pFont);
 *
 * Gets the current font data from the controls and updates the given
 * font object.
 *
 *=========================================================================*/
void CEsmOptionsDlg::GetFontData (CFont* pFont) {
  int     Size;
  int     Italic = 0;
  int     Bold = FW_NORMAL;
  CString Face;
  int     ListIndex;

	/* Get the font information */
  ListIndex = m_FontFaceList.GetCurSel();
  if (ListIndex < 0) return;
  m_FontFaceList.GetLBText(ListIndex, Face);

  ListIndex = m_FontSizeList.GetCurSel();
  if (ListIndex < 0) return;
  Size = m_FontSizeList.GetItemData(ListIndex);

  if (m_FontBoldCheck.GetCheck()) Bold = FW_BOLD;
  if (m_FontItalicCheck.GetCheck()) Italic = 1;

	/* Update the font object */
  pFont->Detach();
  CFONT_CREATE((*pFont), Size, Bold, Italic, Face);
 }
/*===========================================================================
 *		End of Class Method CEsmOptionsDlg::GetFontData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Event - void OnBgcolor ();
 *
 *=========================================================================*/
void CEsmOptionsDlg::OnBgcolor() {
  int Result;

	/* Initialize and display the dialog */
  CColorDialog  ColorDlg(m_BGColor.m_Color, CC_ANYCOLOR | CC_FULLOPEN, this);
  Result = ColorDlg.DoModal();
  if (Result != IDOK) return;
  
  m_BGColor.SetColor(ColorDlg.GetColor());
  m_BGColor.RedrawWindow();
 }
/*===========================================================================
 *		End of Class Event CEsmOptionsDlg::OnBgcolor()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Event - void OnBrowseextrafile ();
 *
 *=========================================================================*/
void CEsmOptionsDlg::OnBrowseextrafile() {
  CString     Buffer;
  m_ExtraFile.GetWindowText(Buffer);

  CFileDialog BrowseDlg(TRUE, _T("esp"), Buffer, OFN_FILEMUSTEXIST | OFN_HIDEREADONLY, _T("Plugin Files (*.esp)|*.esp|Master Files (*.esm)|*.esm|All Files (*.*)|*.*||"), this);
  int	      Result;

  BrowseDlg.m_ofn.lpstrTitle = _T("Select Extra File for Script Compiling");

  Result = BrowseDlg.DoModal();
  if (Result != IDOK) return;

  m_ExtraFile.SetWindowText(BrowseDlg.GetPathName());  
}
/*===========================================================================
 *		End of Class Event CEsmOptionsDlg::OnBrowseextrafile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Event - void OnBrowsegamepath ();
 *
 *=========================================================================*/
void CEsmOptionsDlg::OnBrowsegamepath() {
  CString Buffer;
  bool    Result;

  m_GamePath.GetWindowText(Buffer);

  Result = BrowseForFolder (Buffer, m_hWnd, _T("Select Custom Game Path"));
  if (!Result) return;

  TerminatePathString(Buffer);
  m_GamePath.SetWindowText(Buffer);
}
/*===========================================================================
 *		End of Class Event CEsmOptionsDlg::OnBrowsegamepath()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Event - void OnCancel ();
 *
 *=========================================================================*/
void CEsmOptionsDlg::OnCancel() {
	
  CDialog::OnCancel();
 }
/*===========================================================================
 *		End of Class Event CEsmOptionsDlg::OnCancel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Event - void OnFormatcolor ();
 *
 *=========================================================================*/
void CEsmOptionsDlg::OnFormatcolor() {
  int Result;

	/* Initialize and display the dialog */
  CColorDialog  ColorDlg(m_FormatColor.m_Color, CC_ANYCOLOR | CC_FULLOPEN, this);
  Result = ColorDlg.DoModal();
  if (Result != IDOK) return;
  
  m_FormatColor.SetColor(ColorDlg.GetColor());
  m_FormatColor.RedrawWindow();
 }
/*===========================================================================
 *		End of Class Event CEsmOptionsDlg::OnFormatcolor()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Event - void OnBlueformatButton ();
 *
 *=========================================================================*/
void CEsmOptionsDlg::OnBlueformatButton() {
  int Result;

	/* Prompt user to make sure they want to change formats */
  Result = MessageBox(_T("Lose the current format settings and use the default blue format?"), _T("Set Blue Format"), MB_YESNO | MB_ICONQUESTION);
  if (Result != IDYES) return;

	/* Copy the default blue format into the current script options */
  m_ScriptOptions.CreateDefaultBlueFormat();

	/* Update the dialog */
  m_BGColor.SetColor(m_ScriptOptions.GetBGColor());
  m_BGColor.RedrawWindow();
  SetFormatData(m_CurrentFormat);
 }
/*===========================================================================
 *		End of Class Event CEsmOptionsDlg::OnBlueformatButton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Event - void OnWhiteformatButton ();
 *
 *=========================================================================*/
void CEsmOptionsDlg::OnWhiteformatButton() {
  int Result;

	/* Prompt user to make sure they want to change formats */
  Result = MessageBox(_T("Lose the current format settings and use the default white format?"), _T("Set White Format"), MB_YESNO | MB_ICONQUESTION);
  if (Result != IDYES) return;

	/* Copy the default white format into the current script options */
  m_ScriptOptions.CreateDefaultWhiteFormat();

	/* Update the dialog */
  m_BGColor.SetColor(m_ScriptOptions.GetBGColor());
  m_BGColor.RedrawWindow();
  SetFormatData(m_CurrentFormat);
 }
/*===========================================================================
 *		End of Class Event CEsmOptionsDlg::OnWhiteformatButton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmOptionsDlg::OnInitDialog() {
  CDialog::OnInitDialog();

	/* Fill/create the required lists */
  FillWarnLevelList();
  FillFormatList();
  FillFontNameList();
  FillFontSizeList();

	/* Limit the size of the input author name textbox */
  m_AuthorText.SetLimitText(ESMSCR_OPTION_NAMESIZE);

	/* Set the sample text value */
  m_SampleText.SetWindowText(_T("Sample Text..."));

	/* Initialize the options data */
  if (m_pOrigOptions != NULL) {
    m_ScriptOptions = *(m_pOrigOptions->GetUserFormat());
   }

  SetControlData();
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmOptionsDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Event - void OnOK ();
 *
 *=========================================================================*/
void CEsmOptionsDlg::OnOK() {

  GetControlData();
  m_pOrigOptions->WriteToRegistry();

  CDialog::OnOK();	
 }
/*===========================================================================
 *		End of Class Event CEsmOptionsDlg::OnOK()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Event - void OnSelchangeFormatList ();
 *
 *=========================================================================*/
void CEsmOptionsDlg::OnSelchangeFormatList() {
  GetFormatData();
  SetFormatData(m_FormatList.GetCurSel());
 }
/*===========================================================================
 *		End of Class Event CEsmOptionsDlg::OnSelchangeFormatList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Method - void SetControlData (void);
 *
 * Set the control values from the options object.
 *
 *=========================================================================*/
void CEsmOptionsDlg::SetControlData (void) {
  CString Buffer;

	/* Ensure a valid options object */
  if (m_pOrigOptions == NULL) return;

  	/* General options */
  m_AuthorText.SetWindowText(m_pOrigOptions->GetAuthorName());
  m_GamePath.SetWindowText(m_pOrigOptions->GetDataPath());
  m_BackupSaves.SetCheck(m_pOrigOptions->GetBackupSaves());
  m_AllowExtFuncs.SetCheck(m_pOrigOptions->GetAllowExtFuncs());
  m_StrictIDs.SetCheck(m_pOrigOptions->GetStrictIDs());
  m_AllowBloodmoon.SetCheck(m_pOrigOptions->GetAllowBloodmoon());
  m_AllowTribunal.SetCheck(m_pOrigOptions->GetAllowTribunal());

	/* Format and warning level type */
  m_NoFormatCheck.SetCheck(m_pOrigOptions->GetNoScriptFormat());
  m_NoScriptPrompt.SetCheck(m_pOrigOptions->GetNoScriptPrompt());
  m_NoToolTipCheck.SetCheck(m_pOrigOptions->GetNoToolTips());
  m_UseExtraFile.SetCheck(m_pOrigOptions->GetUseExtraFile());
  m_ExtraFile.SetWindowText(m_pOrigOptions->GetExtraFile());
  FindComboListItem(m_WarnLevelList, m_pOrigOptions->GetScriptWarnLevel(), true);
  m_BGColor.SetColor(m_pOrigOptions->GetUserFormat()->GetBGColor());
  m_BGColor.RedrawWindow();

	/* Indentation values */
  m_InitialIndentLevel.SetCheck(m_pOrigOptions->GetInitialIndentLevel());
  m_IndentCommentsMore.SetCheck(m_pOrigOptions->GetIndentCommentsMore());

  if (m_pOrigOptions->GetScriptIndentString()[0] == ' ') {
    m_IndentSpace.SetCheck(TRUE);
    Buffer.Format(_T("%d"), _tcslen(m_pOrigOptions->GetScriptIndentString()));
    m_IndentSpacesText.SetWindowText(Buffer);
  }
  else {
    m_IndentSpacesText.SetWindowText("4");
    m_IndentTab.SetCheck(TRUE);
  }

  	/* Display the first format information */
  m_FormatList.SetCurSel(0);
  SetFormatData(0);

	/* Set the font controls */
  SetFontData();
 }
/*===========================================================================
 *		End of Class Method CEsmOptionsDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Method - void SetFontData (void);
 *
 * Sets the font control data from the current options object.
 *
 *=========================================================================*/
void CEsmOptionsDlg::SetFontData (void) {
  LOGFONT LogFont;
  int     ListIndex;

	/* Get the font information */
  m_pOrigOptions->GetUserFormat()->GetTextFont()->GetLogFont(&LogFont);

	/* Update the font controls */
  FindComboListItem(m_FontSizeList, (int) (LogFont.lfHeight), true);
  ListIndex = m_FontFaceList.FindStringExact(0, LogFont.lfFaceName);
  m_FontFaceList.SetCurSel(ListIndex);
  m_FontBoldCheck.SetCheck(LogFont.lfWeight > FW_NORMAL);
  m_FontItalicCheck.SetCheck(LogFont.lfItalic);

	/* Update the font display in the sample textbox */
  UpdateSampleFontText();
 }
/*===========================================================================
 *		End of Class Method CEsmOptionsDlg::SetFontData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Method - void SetFormatData (Index);
 *
 * Sets the displayed format to the list index.
 *
 *=========================================================================*/
void CEsmOptionsDlg::SetFormatData (const int Index) {
  int		FormatIndex;
  CHARFORMAT2*	pFormat;

	/* Ensure a valid input list index and format index */
  if (Index < 0 || Index >= m_FormatList.GetCount()) return;
  FormatIndex = m_FormatList.GetItemData(Index);
  if (FormatIndex < 0 || FormatIndex >= ESMSCRIPT_NUMFORMATS) return;
  pFormat = m_ScriptOptions.GetCharFormat(FormatIndex);

	/* Update the format color box */
  m_FormatColor.SetColor(pFormat->crTextColor);
  m_FormatColor.RedrawWindow();

  m_CurrentFormat = Index;
 }
/*===========================================================================
 *		End of Class Method CEsmOptionsDlg::SetFormatData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmOptionsDlg Method - void UpdateSampleFontText (void);
 *
 * Updates the font of the sample textbox and redraws it.
 *
 *=========================================================================*/
void CEsmOptionsDlg::UpdateSampleFontText (void) { 
  GetFontData(&m_SampleFont);
  m_SampleText.SetFont(&m_SampleFont, TRUE);
 }
/*===========================================================================
 *		End of Class Method CEsmOptionsDlg::UpdateSampleFontText()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Font Update Methods
 *
 *=========================================================================*/
void CEsmOptionsDlg::OnSelchangeFontfaceList() {
  UpdateSampleFontText();
 }

void CEsmOptionsDlg::OnSelchangeFontsizeList() {
  UpdateSampleFontText();
 }

void CEsmOptionsDlg::OnFontboldCheck() {
  UpdateSampleFontText();
 }

void CEsmOptionsDlg::OnFontitalicCheck() { 
  UpdateSampleFontText();
 }
/*===========================================================================
 *		End of Font Update Methods
 *=========================================================================*/
