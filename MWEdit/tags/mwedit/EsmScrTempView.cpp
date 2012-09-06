/*===========================================================================
 *
 * File:	Esmscrtempview.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 8, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmScrTempView.h"
#include "EsmScriptCompile.h"


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

  IMPLEMENT_DYNCREATE(CEsmScrTempView, CFormView);
  DEFINE_FILE("EsmScrTempView.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmScrTempView Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmScrTempView, CFormView)
  //{{AFX_MSG_MAP(CEsmScrTempView)
  ON_WM_DESTROY()
  ON_COMMAND(ID_SCRTEMP_LOADCSV, OnScrtempLoadcsv)
  ON_COMMAND(ID_EDIT_COPY, OnEditCopy)
  ON_COMMAND(ID_EDIT_CUT, OnEditCut)
  ON_COMMAND(ID_EDIT_PASTE, OnEditPaste)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of Class CEsmScrTempView Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Constructor
 *
 *=========================================================================*/
CEsmScrTempView::CEsmScrTempView() : CFormView(CEsmScrTempView::IDD) {
  //{{AFX_DATA_INIT(CEsmScrTempView)
  //}}AFX_DATA_INIT
  m_pDlgHandler  = NULL;
  m_pDocument    = NULL;
  m_hAccelerator = NULL;

	/* Default options */
  m_Options.KeepQuotes	     = true;
  m_Options.OnlyCompleteRows = true;
  m_Options.AutoScriptName   = true;
  m_Options.SetScriptName(_T("scripttemp_"));
 }
/*===========================================================================
 *		End of Class CEsmScrTempView Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Destructor
 *
 *=========================================================================*/
CEsmScrTempView::~CEsmScrTempView() {
 }
/*===========================================================================
 *		End of Class CEsmScrTempView Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Method - bool CheckCsvFile (void);
 *
 * Checks the csv specific parameters and returns false if anu
 * are invalid.
 *
 *=========================================================================*/
bool CEsmScrTempView::CheckCsvFile (void) {
  int  iResult;
  bool Result;

	/* Ensure the csv file has a scriptname column */
  if (!m_Options.AutoScriptName) {
    iResult = m_CsvFile.FindHeaderCol(ESMSCRTEMP_CSV_SCRIPTNAME);

    if (iResult < 0) { 
      ErrorHandler.AddError(ERR_BADINPUT, _T("No %s column found in the CSV file!"), ESMSCRTEMP_CSV_SCRIPTNAME);
      return (false);
     }
   }

	/* Check for 'empty' fields */
  if (!m_Options.OnlyCompleteRows) {
    Result = m_CsvFile.IsMissingCells();

    if (Result) { 
      ErrorHandler.AddError(ERR_BADINPUT, _T("Missing or empty cells found in the CSV file!"));
      return (false);
     }
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempView::CheckCsvFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Method - bool CheckTemplate (void);
 *
 * Returns false if any script template parameters are not valid.
 *
 *=========================================================================*/
bool CEsmScrTempView::CheckTemplate (void) {
  bool Result;

	/* Do we have a template file? */
  if (!HasTemplateFile()) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("No template file loaded!"));
    return (false);
   }

	/* Do we have a csv file? */
  if (!HasCsvFile()) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("No csv file loaded!"));
    return (false);
   }

	/* Check the template file parameters */
  Result = CheckTemplateFile();
  if (!Result) return (false);

  	/* Check the csv file parameters */
  Result = CheckCsvFile();
  if (!Result) return (false);

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempView::CheckTemplate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Method - bool CheckTemplateFile (void);
 *
 * Checks the template specific parameters and returns false if anu
 * are invalid.
 *
 *=========================================================================*/
bool CEsmScrTempView::CheckTemplateFile (void) {
  esmscrtempvar_t* pTempVar;
  int		   Index;
  int		   iResult;

	/* Check all template variables */
  for (Index = 0; Index < m_ScriptTemplate.GetNumTempVars(); Index++) {
    pTempVar = m_ScriptTemplate.GetTemplateVar(Index);

		/* Ensure the variable exists in the csv file */
    iResult = m_CsvFile.FindHeaderCol(pTempVar->Name);

    if (iResult < 0) { 
      ErrorHandler.AddError(ERR_BADINPUT, _T("No '%s' column found in the CSV file!"), pTempVar->Name);
      return (false);
     }
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempView::CheckTemplateFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Method - bool CreateScripts (void);
 *
 * Creates all the required scripts. Returns false on any error. Assumes
 * that all template parameters have been checked and are valid.
 *
 *=========================================================================*/
bool CEsmScrTempView::CreateScripts (void) {
  CCsvRow* pRow;
  bool	   Result;
  int	   RowIndex;
  
	/* Update the CSV column indices for the template variables */
  UpdateColIndices();
  m_CreatedScripts = 0;

	/* Output a script for each row in csv file except the header */
  for (RowIndex = 1; RowIndex < m_CsvFile.GetNumLines(); RowIndex++) {
    if (m_CsvFile.IsRowMissingCells(RowIndex)) continue;
    pRow = m_CsvFile.GetRow(RowIndex);

  		/* Create the script for the given row */
    Result = CreateScript(pRow);
    if (!Result) return (false);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempView::CreateScripts()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Method - bool CreateScript (pRow);
 *
 * Creates a script using the given data row which is assumed to be
 * valid. Returns false on any errors.
 *
 *=========================================================================*/
bool CEsmScrTempView::CreateScript (CCsvRow* pRow) {
  CEsmScript*		pScript;
  esmrecinfo_t*		pRecInfo;
  CEsmScriptCompile	Compiler;
  CString		ScriptName;
  bool			Result;
  int			iResult;  

	/* Create/get the current script name */
  m_CreatedScripts++;
  ScriptName = MakeScriptName(pRow);

	/* Find any existing script */
  pRecInfo = m_pDocument->FindExistingRecord(ScriptName, MWESM_REC_SCPT);

	/* Create a new script record */
  if (pRecInfo == NULL) {
    pRecInfo = m_pDocument->CreateNewRecord(MWESM_REC_SCPT, ScriptName);
    if (pRecInfo == NULL) return (false);
   }
	/* Existing record is incorrect type */
  else if (!pRecInfo->pRecord->IsType(MWESM_REC_SCPT)) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("The previous record '%s' is not a script (%s)!"), ScriptName, pRecInfo->pRecord->GetItemType());
    return (false);
   }
	/* Use an existing script record */
  else {
    pRecInfo = m_pDocument->CopyToActive(pRecInfo);
    if (pRecInfo == NULL) return (false);
   }

	/* The script object we will edit */
  pScript = (CEsmScript *) pRecInfo->pRecord;
  pScript->ClearCompileData();

	/* Create the new script text */
  Result = ParseScriptText(pRow, ScriptName);
  if (!Result) return (false);

	/* Update the script text */
  pScript->SetScriptText(m_NewScriptText);
  
	/* Attempt to compile the script */
  Compiler.SetScriptText(m_NewScriptText, m_NewScriptText.GetLength());
  Compiler.SetDocument(m_pDocument);
  iResult = Compiler.Compile();

  if (iResult == ESMSCR_RESULT_OK) {
    CEsmSubRecord* pSubRec;
    CEsmSubSCHD*   pScriptHeader;

		/* Set the script header */
    pScriptHeader = pScript->GetScriptHeader();
    pScriptHeader->GetScriptHeadData()->LocalVarSize = Compiler.GetLocalVarDataSize();
    pScriptHeader->GetScriptHeadData()->ScriptDataSize = Compiler.GetScriptDataSize();
    pScriptHeader->GetScriptHeadData()->NumShorts = Compiler.GetNumShortLocals();
    pScriptHeader->GetScriptHeadData()->NumLongs  = Compiler.GetNumLongLocals();
    pScriptHeader->GetScriptHeadData()->NumFloats = Compiler.GetNumFloatLocals();

		/* Set the local variable data */
    pSubRec = pScript->GetScriptVars();
    pSubRec->CopyData(Compiler.GetLocalVarData(), Compiler.GetLocalVarDataSize());

		/* Set the compiled script data */
    pSubRec = pScript->GetScriptData();
    pSubRec->CopyData(Compiler.GetScriptData(), Compiler.GetScriptDataSize());
   }
  else { 
    ErrorHandler.AddError(ERR_BADINPUT, _T("Failed to compile script '%s'!"), ScriptName);
   }
  
	/* Update any record view */
  m_pDocument->UpdateAllViews(NULL, MWEDITDOC_HINT_UPDATEITEM, (CObject *) pRecInfo);

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempView::CreateScript()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmScrTempView::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmScrTempView)
  DDX_Control(pDX, IDC_TAB1, m_TabControl);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempView::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Method - void GetControlData (void);
 *
 * Get the current control data.
 *
 *=========================================================================*/
void CEsmScrTempView::GetControlData (void) {
  m_Page1.GetControlData();
  OnUpdateText();
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempView::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Method - bool HasCsvFile (void);
 *
 * Checks if there is a current valid csv/template file.
 *
 *=========================================================================*/
bool CEsmScrTempView::HasCsvFile (void) {
  return !(*m_CsvFile.GetFilename() == NULL_CHAR);
 }


bool CEsmScrTempView::HasTemplateFile (void) {
  return !(*m_ScriptTemplate.GetFilename() == NULL_CHAR);
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempView::HasCsvFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmScrTempView Diagnostics
 *
 *=========================================================================*/
#ifdef _DEBUG

void CEsmScrTempView::AssertValid() const {
  CFormView::AssertValid();
 }

void CEsmScrTempView::Dump(CDumpContext& dc) const {
  CFormView::Dump(dc);
 }

#endif
/*===========================================================================
 *		End of Class CEsmScrTempView Diagnostics
 *=========================================================================*/


/*===========================================================================
 *
 * Class TCHAR* CEsmScrTempView Method - const MakeScriptName (pRow);
 *
 * Gets or creates the script name for the given csv row.
 *
 *=========================================================================*/
const TCHAR* CEsmScrTempView::MakeScriptName (CCsvRow* pRow) {
  static CString	s_Buffer;
  esmscrtempvar_t*	pTempVar;
  CSString*		pString;

	/* Attempt to get the supplied script name */
  if (!m_Options.AutoScriptName) {
    pTempVar = m_ScriptTemplate.FindTemplateVar(ESMSCRTEMP_CSV_SCRIPTNAME);

    if (pTempVar != NULL) {
      pString = pRow->GetAt(pTempVar->CsvColIndex);

      if (pString != NULL && !pString->IsEmpty()) {
        s_Buffer = (const TCHAR *) *pString;
        return (s_Buffer);
       }
     }
   }

	/* Autocreate the scriptname? */
  s_Buffer.Format(_T("%s%04d"), m_Options.ScriptName, m_CreatedScripts);
  return (s_Buffer);
 }
/*===========================================================================
 *		End of Class Method TCHAR* CEsmScrTempView::MakeScriptName()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Event - void OnCheckTemplate (void);
 *
 *=========================================================================*/
void CEsmScrTempView::OnCheckTemplate (void) {
  bool Result;

	/* Update the control data */
  GetControlData();

	/* Check all the parameters */
  Result = CheckTemplate();

  if (!Result) 
    ErrorHandler.Notify(_T("Template Check Failed!"));
  else
    MessageBox(_T("Template check was successfull."), _T("Template Check Success"), MB_OK | MB_ICONINFORMATION);

 }
/*===========================================================================
 *		End of Class Event CEsmScrTempView::OnCheckTemplate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Event - void OnCreateTemplate (void);
 *
 *=========================================================================*/
void CEsmScrTempView::OnCreateTemplate (void) {
  bool Result;

	/* Update the control data */
  GetControlData();
  ErrorHandler.ClearErrorCount();

	/* Check all the parameters */
  Result = CheckTemplate();

  if (!Result) {
    ErrorHandler.Notify(_T("Template Check Failed!"));
    return;
   }
 
	/* Attempt to create the scripts */
  Result = CreateScripts();

  if (!Result) {
    ErrorHandler.NotifyList(_T("The following errors occured while creating the script templates:"), _T("Template Errors:"));
   }
  else {
    CString Buffer;
    Buffer.Format(_T("Successfully created %d template scripts!"), m_CreatedScripts);
    MessageBox(Buffer, _T("Script Template Success"), MB_OK | MB_ICONINFORMATION);
   }  

 }
/*===========================================================================
 *		End of Class Event CEsmScrTempView::OnCreateTemplate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Event - void OnDestroy ();
 *
 *=========================================================================*/
void CEsmScrTempView::OnDestroy() {
  CFormView::OnDestroy();
  if (m_pDlgHandler != NULL) m_pDlgHandler->OnCloseScrTempDlg();
 }
/*===========================================================================
 *		End of Class Event CEsmScrTempView::OnDestroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Event - void OnEditCopy ();
 *
 *=========================================================================*/
void CEsmScrTempView::OnEditCopy() {
  ClipCopyFromWnd(GetFocus());
 }


void CEsmScrTempView::OnEditCut() {
  ClipCutFromWnd(GetFocus());
 }


void CEsmScrTempView::OnEditPaste() {
  ClipPasteToWnd(GetFocus());
 }
/*===========================================================================
 *		End of Class Event CEsmScrTempView::OnEditPaste()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmScrTempView::OnInitialUpdate() {
  CString Buffer;

  CFormView::OnInitialUpdate();
  ResizeParentToFit(FALSE);

	/* Initialize the tab control */
  m_Page1.Create(IDD_SCRTEMP_PAGE1, &m_TabControl);
  m_Page2.Create(IDD_SCRTEMP_PAGE2, &m_TabControl);
  m_Page3.Create(IDD_SCRTEMP_PAGE3, &m_TabControl);
  m_Page1.SetDlgHandler(m_pDlgHandler);
  m_Page2.SetDlgHandler(m_pDlgHandler);
  m_Page3.SetDlgHandler(m_pDlgHandler);
  m_Page1.SetParentView(this);
  m_Page2.SetParentView(this);
  m_Page3.SetParentView(this);

  m_TabControl.AddTab(_T("Main Info"),     &m_Page1);
  m_TabControl.AddTab(_T("Template Text"), &m_Page2);
  m_TabControl.AddTab(_T("CSV File"),      &m_Page3);
  m_TabControl.SetPage(0);

	/* Load the accelerator table */
  m_hAccelerator = ::LoadAccelerators(AfxGetApp()->m_hInstance, MAKEINTRESOURCE(IDR_RECORD_ACCEL));

  	/* Update the frame title */
  Buffer.Format(_T("%s -- Script Template"), m_pDlgHandler->GetDocument()->GetTitle());
  GetParentFrame()->SetWindowText(Buffer);

  	/* Update the display */
  m_Page1.UpdatePage();
  m_Page2.UpdatePage();
  m_Page3.UpdatePage();
 }
/*===========================================================================
 *		End of Class Event CEsmScrTempView::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Event - void OnReloadCsvFile (void);
 *
 *=========================================================================*/
void CEsmScrTempView::OnReloadCsvFile (void) {
  CString Buffer;
  bool    Result;

	/* See if there is a file to reload */
  Buffer = m_CsvFile.GetFilename();
  if (Buffer.IsEmpty()) return;

  	/* Update the csv file options */
  GetControlData();
  m_CsvFile.SetKeepQuotes(m_Options.KeepQuotes);

	/* Attempt to load the csv file */
  Result = m_CsvFile.Load(Buffer);

  if (!Result) {
    ErrorHandler.Notify(_T("Csv File Error!"));
    return;
   }

	/* Update the display */
  m_Page3.UpdatePage();
  m_Page1.UpdatePage();
 }
/*===========================================================================
 *		End of Class Event CEsmScrTempView::OnReloadCsvFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Event - void OnReloadScrTemp (void);
 *
 *=========================================================================*/
void CEsmScrTempView::OnReloadScrTemp (void) {
  CString Buffer;
  bool    Result;

	/* See if there is a file to reload */
  Buffer = m_ScriptTemplate.GetFilename();
  if (Buffer.IsEmpty()) return;

	/* Attempt to load the template file */
  Result = m_ScriptTemplate.Load(Buffer);
  if (!Result) ErrorHandler.Notify(_T("Script Template Error"));

	/* Update the display */
  m_Page1.UpdatePage();
  m_Page2.UpdatePage();
 }
/*===========================================================================
 *		End of Class Event CEsmScrTempView::OnReloadScrTemp()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Event - void OnScrtempLoadcsv ();
 *
 *=========================================================================*/
void CEsmScrTempView::OnScrtempLoadcsv() {
  CFileDialog	FileDlg(TRUE, ESMSCRTEMP_CSV_EXT, NULL, OFN_HIDEREADONLY, ESMSCRTEMP_CSV_FILTER, this);
  int		Result;

	/* Display the modal open dialog */
  FileDlg.m_ofn.lpstrTitle = _T("Open CSV File");
  Result = FileDlg.DoModal();
  if (Result != IDOK) return;

	/* Update the csv file options */
  GetControlData();
  m_CsvFile.SetKeepQuotes(m_Options.KeepQuotes);

	/* Attempt to load the csv file */
  Result = m_CsvFile.Load(FileDlg.GetPathName());

  if (!Result) {
    ErrorHandler.Notify(_T("Csv File Error!"));
    return;
   }

	/* Update the display */
  m_Page3.UpdatePage();
  m_Page1.UpdatePage();
 }
/*===========================================================================
 *		End of Class Event CEsmScrTempView::OnScrtempLoadcsv()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Event - void OnLoadTemplate (void);
 *
 *=========================================================================*/
void CEsmScrTempView::OnLoadTemplate (void) {
  CFileDialog FileDlg(TRUE, ESM_SCRTEMP_FILEEXT, NULL, OFN_HIDEREADONLY, ESM_SCRTEMP_FILEFILTER, this);
  bool Result;
  int  iResult;

	/* Display the open dialog */
  FileDlg.m_ofn.lpstrTitle = _T("Open Script Template");
  iResult = FileDlg.DoModal();
  if (iResult != IDOK) return;

	/* Attmept to load the template file */
  Result = m_ScriptTemplate.Load(FileDlg.GetPathName());
  if (!Result) ErrorHandler.Notify(_T("Script Template Error"));

	/* Update the display */
  m_Page1.UpdatePage();
  m_Page2.UpdatePage();
 }
/*===========================================================================
 *		End of Class Event CEsmScrTempView::OnLoadTemplate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Event - void OnUpdateText (void);
 *
 *=========================================================================*/
void CEsmScrTempView::OnUpdateText (void) {
  m_Page2.UpdateText();
  m_ScriptTemplate.ParseText();
  m_Page1.UpdatePage();
 }
/*===========================================================================
 *		End of Class Event CEsmScrTempView::OnUpdateText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Method - bool ParseScriptText (pRow, pScriptName);
 *
 * Parse the script text updating the class member variables. Returns
 * false on any error.
 *
 *=========================================================================*/
bool CEsmScrTempView::ParseScriptText (CCsvRow* pRow, const TCHAR* pScriptName) {
  TCHAR*  pBuffer;
  bool	  Result;

	/* Initialize the text buffer */
  pBuffer = m_NewScriptText.GetBufferSetLength(ESM_SCRTEMP_MAXTEMPSIZE+1);
  m_ScriptTemplate.SetScriptName(pScriptName);

	/* Convert the text */
  Result = m_ScriptTemplate.ConvertText(pBuffer, ESM_SCRTEMP_MAXTEMPSIZE, pRow);
  m_NewScriptText.ReleaseBuffer(-1);

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempView::ParseScriptText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Method - BOOL PreTranslateMessage (pMsg);
 *
 *=========================================================================*/
BOOL CEsmScrTempView::PreTranslateMessage(MSG* pMsg) {
  int Result;

  if (m_hAccelerator != NULL && pMsg->message >= WM_KEYFIRST && pMsg->message <= WM_KEYLAST) {
    Result = TranslateAccelerator(m_hWnd, m_hAccelerator, pMsg);
    if (Result != 0) return (Result);
   }
	
  return CFormView::PreTranslateMessage(pMsg);
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempView::PreTranslateMessage()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempView Method - bool UpdateColIndices (void);
 *
 * Updates the CSV column indices for all the template variables. Returns
 * false on any error.
 *
 *=========================================================================*/
bool CEsmScrTempView::UpdateColIndices (void) {
  esmscrtempvar_t* pTempVar;
  int		   iResult;
  int		   Index;

	/* Update all template variables */
  for (Index = 0; Index < m_ScriptTemplate.GetNumTempVars(); Index++) {
    pTempVar = m_ScriptTemplate.GetTemplateVar(Index);

		/* Find an update the csv column index */
    iResult = m_CsvFile.FindHeaderCol(pTempVar->Name);
    pTempVar->CsvColIndex = iResult;
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempView::UpdateColIndices()
 *=========================================================================*/
