/*===========================================================================
 *
 * File:	Esmcsvimportdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 13, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmCsvImportDlg.h"
#include "MWEditDoc.h"


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

  DEFINE_FILE("EsmCsvImportDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmCsvImportDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmCsvImportDlg, CDialog)
	//{{AFX_MSG_MAP(CEsmCsvImportDlg)
	ON_BN_CLICKED(IDC_LOADCSVBUTTON, OnLoadcsvbutton)
	ON_BN_CLICKED(IDC_CREATEBUTTON, OnCreatebutton)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmCsvImportDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCsvImportDlg Constructor
 *
 *=========================================================================*/
CEsmCsvImportDlg::CEsmCsvImportDlg(CWnd* pParent) : CDialog(CEsmCsvImportDlg::IDD, pParent) {
  //{{AFX_DATA_INIT(CEsmCsvImportDlg)
  //}}AFX_DATA_INIT
  m_pDocument    = NULL;
  m_IDColIndex   = -1;
  m_TypeColIndex = -1;
 }
/*===========================================================================
 *		End of Class CEsmCsvImportDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCsvImportDlg Destructor
 *
 *=========================================================================*/
CEsmCsvImportDlg::~CEsmCsvImportDlg() {
 }
/*===========================================================================
 *		End of Class CEsmCsvImportDlg Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCsvImportDlg Method - bool CheckData (void);
 *
 * Ensures the current data is valid. Returns false on any error.
 *
 *=========================================================================*/
bool CEsmCsvImportDlg::CheckData (void) {
  CCsvRow*  pRow;
  CSString* pString;
  bool      Result;
  int	    RowIndex;
  int       FieldID;
  int	    ColIndex;

	/* Ensure there is some data to convert */
  if (m_CsvFile.GetNumLines() <= 1) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("No rows in the CSV file to convert!"));
    return (false);
   }

	/* Ensure the header row is valid */
  if (m_CsvFile.GetRow(0) == NULL) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("Invalid header row in the CSV file!"));
    return (false);
   }

	/* Ensure any required columns are included */
  Result = FindColumns();
  if (!Result) return (false);
  pRow = m_CsvFile.GetRow(0);

	/* Check all header row for validity */
  for (ColIndex = 0; ColIndex < pRow->GetNumElements(); ColIndex++) {
    pString = pRow->GetAt(ColIndex);
    if (pString == NULL) continue;

    FieldID = GetEsmFieldID(*pString);

    if (FieldID < 0) {
      ErrorHandler.AddError(ERR_BADINPUT, _T("Unknown header column '%s' found in te CSV file!"), (const TCHAR *)*pString);
      return (false);
     }
   }

	/* Check all rows for validity */
  for (RowIndex = 1; RowIndex < m_CsvFile.GetNumLines(); RowIndex++) {
    Result = CheckRow(RowIndex);
    if (!Result) return (false);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmCsvImportDlg::CheckData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCsvImportDlg Method - bool CheckRow (RowIndex);
 *
 * Returns false if the given row is not valid.
 *
 *=========================================================================*/
bool CEsmCsvImportDlg::CheckRow (const int RowIndex) {
  //DEFINE_FUNCTION("CEsmCsvImportDlg::CheckRow()");
  CSString* pString;
  CCsvRow*  pRow;
  

  pRow = m_CsvFile.GetRow(RowIndex);

	/* Ensure the row is valid */
  if (pRow == NULL) { 
    ErrorHandler.AddError(ERR_BADINPUT, _T("Csv file row %d is not valid!"), RowIndex+1);
    return (false);
   }

	/* Ensure the required type column is valid */
  if (m_TypeColIndex >= 0) {
    pString = pRow->GetAt(m_TypeColIndex);

    if (pString == NULL || pString->GetLength() == 0) {
      ErrorHandler.AddError(ERR_BADINPUT, _T("The column TYPE in row %d is not valid!"), RowIndex+1);
      return (false);
     }

		/* Check for a valid type field value */
    const TCHAR* pRecType = GetEsmCsvRecordType(*pString);

    if (pRecType == NULL) {
      ErrorHandler.AddError(ERR_BADINPUT, _T("The record type '%s' is not valid or not supported for import!"), *pString);
      return (false);
     }
   }

	/* Ensure the required ID column is valid */
  if (m_IDColIndex >= 0) {
    pString = pRow->GetAt(m_IDColIndex);

    if (pString == NULL || pString->GetLength() == 0) {
      ErrorHandler.AddError(ERR_BADINPUT, _T("The column ID in row %d is not valid!"), RowIndex+1);
      return (false);
     }
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmCsvImportDlg::CheckRow()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCsvImportDlg Method - void ClearCsvList (void);
 *
 * Deletes all items and columns from the CSV file.
 *
 *=========================================================================*/
void CEsmCsvImportDlg::ClearCsvList (void) {
  BOOL Result;

	/* Clear all rows */
  m_CsvList.DeleteAllItems();

	/* Delete all columns */
  do {
    Result = m_CsvList.DeleteColumn(0);
  } while (Result);

 }
/*===========================================================================
 *		End of Class Method CEsmCsvImportDlg::ClearCsvList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCsvImportDlg Method - bool CreateRecords (void);
 *
 * Creates all the records in the current CSV file. Returns false on any
 * error. Assumes the current csv file is valid.
 *
 *=========================================================================*/
bool CEsmCsvImportDlg::CreateRecords (void) {
  CCsvRow* pRow;
  int	   RowIndex;
  bool	   Result;

	/* Output all rows */
  for (RowIndex = 1; RowIndex < m_CsvFile.GetNumLines(); RowIndex++) {

		/* Ensure a valid row */
    pRow = m_CsvFile.GetRow(RowIndex);

    if (pRow == NULL) { 
      ErrorHandler.AddError(ERR_BADINPUT, _T("Csv file row %d is not valid!"), RowIndex+1);
      return (false);
     }

		/* Attempt to create the new record */
    Result = CreateRecord(pRow);
    if (!Result) return (false);
    m_CreatedRecords++;
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmCsvImportDlg::CreateRecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCsvImportDlg Method - bool CreateRecord (pRow);
 *
 * Attempts to create the given record. Returns false on any error.
 * Assumes that the given row and csv file are valid.
 *
 *=========================================================================*/
bool CEsmCsvImportDlg::CreateRecord (CCsvRow* pRow) {
  CEsmRecord*   pNewRecord;
  CSString*     pTypeCol;
  CSString*     pIDCol;
  CSString*     pString;
  CSString*     pHeaderString;
  esmrecinfo_t* pRecInfo;
  CCsvRow*      pHeaderRow;
  const TCHAR*  pRecordType;
  bool		Result;
  int		ColIndex;
  int		FieldID;

	/* Get the record type/ID */
  pTypeCol    = pRow->GetAt(m_TypeColIndex);
  pIDCol      = pRow->GetAt(m_IDColIndex);
  pHeaderRow  = m_CsvFile.GetRow(0);
  pRecordType = GetEsmCsvRecordType(*pTypeCol);
  if (pRecordType == NULL) return (false);

	/* Attempt to create the new record and find any existing one */
  pRecInfo = m_pDocument->FindExistingRecord(*pIDCol, pRecordType);

	/* Create a new record */
  if (pRecInfo == NULL) {
    pRecInfo = m_pDocument->CreateNewRecord(pRecordType, *pIDCol);
    if (pRecInfo == NULL) return (false);
   }
	/* Existing record is incorrect type */
  else if (!pRecInfo->pRecord->IsType(pRecordType)) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("The previous record '%s' is not the correct type (%s)!"), *pIDCol, pRecInfo->pRecord->GetItemType());
    return (false);
   }
	/* Use an existing record */
  else {
    pRecInfo = m_pDocument->CopyToActive(pRecInfo);
    if (pRecInfo == NULL) return (false);
   }

	/* The new record object we will edit */
  pNewRecord = pRecInfo->pRecord;

	/* Set all column values */
  for (ColIndex = 0; ColIndex < pHeaderRow->GetNumElements(); ColIndex++) {
    if (ColIndex == m_TypeColIndex) continue;
    if (ColIndex == m_IDColIndex)   continue;

    pString       = pRow->GetAt(ColIndex);
    pHeaderString = pHeaderRow->GetAt(ColIndex);
    if (pString == NULL || pHeaderString == NULL) continue;
    FieldID = GetEsmFieldID(*pHeaderString);
    if (FieldID < 0) continue;

    Result = pNewRecord->SetFieldValue(FieldID, *pString);
    if (!Result) return (false);
   }  

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmCsvImportDlg::CreateRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCsvImportDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmCsvImportDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmCsvImportDlg)
  DDX_Control(pDX, IDC_CSVLIST, m_CsvList);
  DDX_Control(pDX, IDC_CSVFILENAME, m_CsvFilename);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmCsvImportDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCsvImportDlg Method - void FillCsvList (void);
 *
 * Updates the contents of the Csv list.
 *
 *=========================================================================*/
void CEsmCsvImportDlg::FillCsvList (void) {
  CCsvRow*  pRow;
  CSString* pString;
  CString   Buffer;
  int	    ColIndex;
  int       RowIndex;
  int       ListIndex;

	/* Clear the current contents */
  ClearCsvList();

	/* Add the csv columns from the header row */
  pRow = m_CsvFile.GetRow(0);
  if (pRow == NULL) return;
  m_CsvList.InsertColumn(0, _T(""), LVCFMT_LEFT, 25, 0);

  for (ColIndex = 0; ColIndex < pRow->GetNumElements(); ColIndex++) {
    pString = pRow->GetAt(ColIndex);
    m_CsvList.InsertColumn(ColIndex+1, pString == NULL ? _T("?") : *pString, LVCFMT_CENTER, ESMCSVIMP_LIST_COLWIDTH, ColIndex+1);
   }

	/* Add the remaining row data */
  for (RowIndex = 1; RowIndex < m_CsvFile.GetNumLines(); RowIndex++) {

  		/* Add the row item */
    Buffer.Format(_T("%d"), RowIndex);
    ListIndex = m_CsvList.InsertItem(RowIndex, Buffer);

    pRow = m_CsvFile.GetRow(RowIndex);
    if (pRow == NULL) continue;

		/* Add all columns in the current row */
    for (ColIndex = 0; ColIndex < pRow->GetNumElements(); ColIndex++) {
      pString = pRow->GetAt(ColIndex);
      if (pString != NULL) m_CsvList.SetItemText(ListIndex, ColIndex+1, *pString);
     }
   }
  
 }
/*===========================================================================
 *		End of Class Method CEsmCsvImportDlg::FillCsvList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCsvImportDlg Method - bool FindColumns (void);
 *
 * Finds the required special columns in the CSV file, returning false on
 * any error.
 *
 *=========================================================================*/
bool CEsmCsvImportDlg::FindColumns (void) {
  CCsvRow*	pRow = m_CsvFile.GetRow(0);
  CSString*	pString;
  const TCHAR*  pIDString;
  const TCHAR*  pTypeString;
  int		ColIndex;

	/* Reset the current indices */
  m_IDColIndex   = -1;
  m_TypeColIndex = -1;
  pIDString      = GetEsmFieldName(ESM_FIELD_ID);
  pTypeString    = GetEsmFieldName(ESM_FIELD_ITEMTYPE);

	/* Check each column header */
  for (ColIndex = 0; ColIndex < pRow->GetNumElements(); ColIndex++) {
    pString = pRow->GetAt(ColIndex);
    if (pString == NULL) continue;

    if (pString->CompareNoCase(pIDString) == 0)
      m_IDColIndex   = ColIndex;
    else if (pString->CompareNoCase(pTypeString) == 0)
      m_TypeColIndex = ColIndex;
   }

	/* Check indices for validity */
  if (m_IDColIndex < 0) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("Record ID column was not found in the CSV file!"));
    return (false);
   }

  if (m_TypeColIndex < 0) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("Record TYPE column was not found in the CSV file!"));
    return (false);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmCsvImportDlg::FindColumns()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCsvImportDlg Method - bool LoadCsvFile (void);
 *
 * Prompts user to load a csv file. Returns false on any error.
 *
 *=========================================================================*/
bool CEsmCsvImportDlg::LoadCsvFile (void) {
  CFileDialog	FileDlg(TRUE, ESMCSVIMP_CSV_EXT, NULL, OFN_HIDEREADONLY, ESMCSVIMP_CSV_FILTER, this);
  int		Result;

	/* Display the modal open dialog */
  FileDlg.m_ofn.lpstrTitle = _T("Open CSV File");
  Result = FileDlg.DoModal();
  if (Result != IDOK) return (false);;

	/* Attempt to load the csv file */
  Result = m_CsvFile.Load(FileDlg.GetPathName());

  if (!Result) {
    ErrorHandler.Notify(_T("Csv File Error!"));
    return (false);
   }

	/* Update the display */
  SetControlData();
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmCsvImportDlg::LoadCsvFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCsvImportDlg Event - void OnCreatebutton ();
 *
 *=========================================================================*/
void CEsmCsvImportDlg::OnCreatebutton() {
  bool Result;

	/* Ensure the data is valid */
  Result = CheckData();
  
  if (!Result) {
    ErrorHandler.Notify(_T("Check Failed!"));
    return;
   }

  m_CreatedRecords = 0;
  Result = CreateRecords();

  if (Result) {
    CString Buffer;
    Buffer.Format(_T("Successfully created %d records from the CSV data!"), m_CreatedRecords);
    MessageBox(Buffer, _T("Record Creation Success"), MB_OK | MB_ICONINFORMATION);
   }
  else {
    ErrorHandler.Notify(_T("Record Creation Failure"));
    return;
   }

	/* Close the dialog with a success code */
  if (m_CreatedRecords > 0) m_pDocument->SetModifiedFlag(TRUE);
  EndDialog(IDOK);
 }
/*===========================================================================
 *		End of Class Event CEsmCsvImportDlg::OnCreatebutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCsvImportDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmCsvImportDlg::OnInitDialog() {
  CDialog::OnInitDialog();

	/* Update the title bar */
  if (m_pDocument != NULL) {
    CString Buffer;
    Buffer.Format(_T("MWEdit -- %s -- Import Csv"), m_pDocument->GetTitle());
    SetWindowText(Buffer);
   }

	/* Initialize the csv list */
  m_CsvList.SetExtendedStyle(LVS_EX_FULLROWSELECT | LVS_EX_GRIDLINES );	 
	
	/* Load the initial CSV file */
  bool Result = LoadCsvFile();

  if (!Result) {
    EndDialog(IDCANCEL);
    return (FALSE);
   }

  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmCsvImportDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCsvImportDlg Event - void OnLoadcsvbutton ();
 *
 *=========================================================================*/
void CEsmCsvImportDlg::OnLoadcsvbutton() {
  LoadCsvFile();
 }
/*===========================================================================
 *		End of Class Event CEsmCsvImportDlg::OnLoadcsvbutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCsvImportDlg Method - void SetControlData (void);
 *
 * Updates the values of the dialog controls.
 *
 *=========================================================================*/
void CEsmCsvImportDlg::SetControlData (void) {

	/* Filename */
  m_CsvFilename.SetWindowText(m_CsvFile.GetFilename());

	/* Update the csv list */
  FillCsvList();
 }
/*===========================================================================
 *		End of Class Method CEsmCsvImportDlg::SetControlData()
 *=========================================================================*/

