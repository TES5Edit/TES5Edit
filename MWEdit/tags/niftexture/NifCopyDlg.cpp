/*===========================================================================
 *
 * File:	Nifcopydlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 19, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "niftexture.h"
#include "NifCopyDlg.h"
#include "WinUtil.h"

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

  DEFINE_FILE("NifCopyDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CNifCopyDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CNifCopyDlg, CDialog)
  //{{AFX_MSG_MAP(CNifCopyDlg)
  ON_BN_CLICKED(ID_NIFLOAD_BUTTON, OnNifloadButton)
  ON_BN_CLICKED(ID_CSVLOAD_BUTTON, OnCsvloadButton)
  ON_BN_CLICKED(ID_NIFCOPY_CREATE, OnNifcopyCreate)
  ON_BN_CLICKED(ID_NIFCOPY_CHECK, OnNifcopyCheck)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CNifCopyDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Constructor
 *
 *=========================================================================*/
CNifCopyDlg::CNifCopyDlg(CWnd* pParent)	: CDialog(CNifCopyDlg::IDD, pParent), m_CopyInfos(0) {
  //{{AFX_DATA_INIT(CNifCopyDlg)
  //}}AFX_DATA_INIT
  m_OverWriteFiles   = false;
  m_FilenameColIndex = -1;
  m_CreatedFiles     = 0;
 }
/*===========================================================================
 *		End of Class CNifCopyDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Destructor
 *
 *=========================================================================*/
CNifCopyDlg::~CNifCopyDlg () {
  //DEFINE_FUNCTION("CNifCopyDlg::~CNifCopyDlg()");
  ClearCopyInfos();
 }
/*===========================================================================
 *		End of Class CNifCopyDlg Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Method - CNifCopyInfo* AddCopyInfo (void);
 *
 * Creates and returns a new copy info record.
 *
 *=========================================================================*/
CNifCopyInfo* CNifCopyDlg::AddCopyInfo (void) {
  DEFINE_FUNCTION("CNifCopyDlg::AddCopyInfo()");
  CNifCopyInfo* pNewInfo;

	/* Allocate the new pointer */
  CreatePointer(pNewInfo, CNifCopyInfo);
  m_CopyInfos.Add(pNewInfo);

	/* Initialize the new info */
  pNewInfo->CsvColIndex       = -1;
  pNewInfo->pSourceTexture    = NULL;
  pNewInfo->pMaterialProperty = NULL;

  return (pNewInfo);
 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::AddCopyInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Method - bool CheckCsvColumns (void);
 *
 * Checks the current CSV column data to ensure it is valid. Returns false
 * on any error.
 *
 *=========================================================================*/
bool CNifCopyDlg::CheckCsvColumns (void) {
  CNifSourceTexture* pSourceTexture;
  POSITION	     FindPos;
  CSString*	     pString;
  CCsvRow*	     pRow;
  int		     CsvColIndex;
  int		     MatchColCount;
  int		     RowIndex;

	/* Check for the required filename column */
  m_FilenameColIndex = m_CsvFile.FindHeaderCol(NIFCOPY_CSV_FILENAME);

  if (m_FilenameColIndex < 0) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("Missing the required '%s' CSV column!"), NIFCOPY_CSV_FILENAME);
    return (false);
   }

	/* See if there is any matching csv columns and source textures */
  pSourceTexture = (CNifSourceTexture *) m_NifFile.FindFirstRecord(FindPos, _T("NiSourceTexture"));
  MatchColCount  = 0;

  while (pSourceTexture != NULL) {

		/* See if there is matching csv column */
    CsvColIndex = m_CsvFile.FindHeaderCol(pSourceTexture->GetTextureName());
    if (CsvColIndex >= 0) MatchColCount++;

		/* Get the next source texture record */
    pSourceTexture = (CNifSourceTexture *) m_NifFile.FindNextRecord(FindPos, _T("NiSourceTexture"));
   }

	/* Did we find any matching columns? */
  /*if (MatchColCount == 0) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("Found no matching texture name columns in the CSV file!"));
    return (false);
   } //*/

	/* Check the NIF filenames in the CSV file */
  for (RowIndex = 1; RowIndex < m_CsvFile.GetNumLines(); RowIndex++) {
    pRow = m_CsvFile.GetRow(RowIndex);
    if (pRow == NULL) continue;
    pString = pRow->GetAt(m_FilenameColIndex);

    if (pString == NULL || pString->IsEmpty()) {
      ErrorHandler.AddError(ERR_BADINPUT, _T("Missing the required %s string in row %d of the CSV file!"), RowIndex);
      return (false);
     }
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::CheckCsvColumns()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Method - bool CheckData (void);
 *
 * Check if the current information is valid. Returns false on any error.
 *
 *=========================================================================*/
bool CNifCopyDlg::CheckData (void) {
  bool Result;

	/* Check for a valid Csv file */
  if (m_InputCsv.IsEmpty()) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("No CSV file loaded!"));
    return (false);
   }

   	/* Check for a valid Nif file */
  if (m_InputNif.IsEmpty()) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("No NIF file loaded!"));
    return (false);
   }

	/* Check for the required CSV columns */
  Result = CheckCsvColumns();
  if (!Result) return (false);

  return (true);
 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::CheckData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Method - void ClearCopyInfos (void);
 *
 * Unallocate any copy info records in the info array.
 *
 *=========================================================================*/
void CNifCopyDlg::ClearCopyInfos (void) {
  DEFINE_FUNCTION("CNifCopyDlg::ClearCopyInfos()");
  CNifCopyInfo* pCopyInfo;
  int		Index;

  for (Index = 0; Index < m_CopyInfos.GetNumElements(); Index++) {
    pCopyInfo = m_CopyInfos.GetAt(Index);
    DestroyPointer(pCopyInfo);
   }

  m_CopyInfos.RemoveAll();
 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::ClearCopyInfos()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Method - void ClearCsvList (void);
 *
 *=========================================================================*/
void CNifCopyDlg::ClearCsvList (void) { 
  BOOL Result;

	/* Clear all rows */
  m_CsvList.DeleteAllItems();

	/* Clear all columns */
  do {
    Result = m_CsvList.DeleteColumn(0);
  } while (Result);

 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::ClearCsvList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Method - bool CreateCopyInfos (void);
 *
 * Creates the copy info records from the current data. Returns false
 * on any error.
 *
 *=========================================================================*/
bool CNifCopyDlg::CreateCopyInfos (void) {
  CNifCopyInfo*   pCopyInfo;
  CNifBaseRecord* pNifRecord;
  POSITION	  FindPos;

	/* Clear the current information */
  ClearCopyInfos();

	/* Find all source texture records in the current NIF file */
  pNifRecord = m_NifFile.FindFirstRecord(FindPos, _T("NiSourceTexture"));

  while (pNifRecord != NULL) {

		/* Add a new copy info record */
    pCopyInfo = AddCopyInfo();

		/* Initialize the new copy info record */
    pCopyInfo->pSourceTexture = (CNifSourceTexture *) pNifRecord;
    pCopyInfo->OrigTexture    = (const TCHAR *) pCopyInfo->pSourceTexture->GetTextureName();
    pCopyInfo->CsvColIndex    = m_CsvFile.FindHeaderCol(pCopyInfo->OrigTexture);

		/* Get the next source texture record */
    pNifRecord = m_NifFile.FindNextRecord(FindPos, _T("NiSourceTexture"));
   }

	/* Find all material property records in the current NIF file */
  pNifRecord = m_NifFile.FindFirstRecord(FindPos, _T("NiMaterialProperty"));

  while (pNifRecord != NULL) {

		/* Add a new copy info record */
    pCopyInfo = AddCopyInfo();

		/* Initialize the new copy info record */
    pCopyInfo->pMaterialProperty = (CNifMaterialProperty *) pNifRecord;
    pCopyInfo->CsvColIndex       = m_CsvFile.FindHeaderCol(_T("AutoTint"));

		/* Get the next source texture record */
    pNifRecord = m_NifFile.FindNextRecord(FindPos, _T("NiMaterialProperty"));
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::CreateCopyInfos()
 *=========================================================================*/
  

/*===========================================================================
 *
 * Class CNifCopyDlg Method - void CreateCsvColumns (void);
 *
 *=========================================================================*/
void CNifCopyDlg::CreateCsvColumns (void) {
  CCsvRow*  pHeaderRow;
  CSString* pString;
  int       ColIndex;

	/* Add the counter column */
  m_CsvList.InsertColumn(0, _T(""), LVCFMT_CENTER, NIFCOPY_LIST_INDEXWIDTH, 0);

	/* Get the header row from the CSV file */
  pHeaderRow = m_CsvFile.GetRow(0);
  if (pHeaderRow == NULL) return;

	/* Add the CSV columns */
  for (ColIndex = 0; ColIndex < pHeaderRow->GetNumElements(); ColIndex++) {
    pString = pHeaderRow->GetAt(ColIndex);
    m_CsvList.InsertColumn(ColIndex+1, pString == NULL ? _T("") : (const TCHAR *)*pString, LVCFMT_CENTER, NIFCOPY_LIST_COLWIDTH, ColIndex+1);
   }

 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::CreateCsvColumns()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Method - bool CreateFiles (void);
 *
 * Creates all the desired NIF files. Returns false on any error.
 *
 *=========================================================================*/
bool CNifCopyDlg::CreateFiles (void) {
  CCsvRow* pRow;
  int      RowIndex;
  bool	   Result;

  m_CreatedFiles = 0;

  for (RowIndex = 1; RowIndex < m_CsvFile.GetNumLines(); RowIndex++) {
    pRow = m_CsvFile.GetRow(RowIndex);

		/* Ensure a valid row */
    if (pRow == NULL || pRow->GetNumElements() == 0) continue;

		/* Attempt to create the single NIF file */
    Result = CreateFile(pRow);
    if (!Result) return (false);
   }
   
  return (true);
 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::CreateFiles()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Method - bool CreateFile (pRow);
 *
 * Create a single NIF file using the given CSV row. Returns false on 
 * any error. Assumes valid input.
 *
 *=========================================================================*/
bool CNifCopyDlg::CreateFile (CCsvRow* pRow) {
  CSString* pFilename;
  CString   Buffer;
  bool	    Result;
  
	/* Get the output filename */
  pFilename = pRow->GetAt(m_FilenameColIndex);
  ExtractPath(Buffer, (const TCHAR *)m_InputNif);
  Buffer += (const TCHAR *)*pFilename;
  
	/* Ignore if the output file exists and we cannot overwrite */
  if (!m_OverWriteFiles && FileExists(Buffer)) return (true);

	/* Update the NIF file textures */
  UpdateTextures(pRow);
	
	/* Attempt to save the new NIF file */
  Result = m_NifFile.Write(Buffer);

  if (!Result) {
    ResetInputNif();
    return (false);
   }

  	/* Reset the NIF data */
  ResetInputNif();
  m_CreatedFiles++;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::CreateFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CNifCopyDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CNifCopyDlg)
  DDX_Control(pDX, IDC_TEXTURELIST, m_TextureList);
  DDX_Control(pDX, IDC_CSV_LIST, m_CsvList);
  DDX_Control(pDX, IDC_OVERWRITE_CHECK, m_OverwriteCheck);
  DDX_Control(pDX, IDC_CSVFILENAME, m_CsvFilename);
  DDX_Control(pDX, IDC_NIFFILENAME, m_NifFilename);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Method - void FillCsvList (void);
 *
 *=========================================================================*/
void CNifCopyDlg::FillCsvList (void) {
  CCsvRow*  pRow;
  CSString* pString;
  CString   Buffer;
  int	    RowIndex;
  int	    ColIndex;
  int	    ListIndex;

	/* Clear the current list */
  ClearCsvList();

	/* Add the csv columns */
  CreateCsvColumns();

	/* Add all the csv rows */
  for (RowIndex = 1; RowIndex < m_CsvFile.GetNumLines(); RowIndex++) {
    pRow = m_CsvFile.GetRow(RowIndex);
    if (pRow == NULL) continue;

		/* Add the counter */
    Buffer.Format(_T("%d"), RowIndex);
    ListIndex = m_CsvList.InsertItem(RowIndex, Buffer);

		/* Add all the column values for the current row */
    for (ColIndex = 0; ColIndex < pRow->GetNumElements(); ColIndex++) {
      pString = pRow->GetAt(ColIndex);
      if (pString != NULL) m_CsvList.SetItemText(ListIndex, ColIndex+1, (const TCHAR *)*pString);
     }
   }

 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::FillCsvList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Method - void FillTextureList (void);
 *
 *=========================================================================*/
void CNifCopyDlg::FillTextureList (void) {  
  CNifSourceTexture* pSourceTexture;
  POSITION	     FindPos;

	/* Clear the current list */
  m_TextureList.ResetContent();;

	/* Find all source texture records in the current NIF file */
  pSourceTexture = (CNifSourceTexture *) m_NifFile.FindFirstRecord(FindPos, _T("NiSourceTexture"));

  while (pSourceTexture != NULL) {

		/* Add the list item */
    m_TextureList.AddString(pSourceTexture->GetTextureName());

		/* Get the next source texture record */
    pSourceTexture = (CNifSourceTexture *) m_NifFile.FindNextRecord(FindPos, _T("NiSourceTexture"));
   }

 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::FillTextureList()
 *=========================================================================*/
 

/*===========================================================================
 *
 * Class CNifCopyDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CNifCopyDlg::GetControlData (void) {

	/* Update filenames */
  m_CsvFilename.GetWindowText(m_InputCsv);
  m_NifFilename.GetWindowText(m_InputNif);

	/* Update options */
  m_OverWriteFiles = (m_OverwriteCheck.GetCheck() != 0);

 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Event - void OnCsvloadButton ();
 *
 *=========================================================================*/
void CNifCopyDlg::OnCsvloadButton() {
  CString Filename;
  int     Result;

	/* Get the current nif filename */
  GetControlData();
  m_CsvFilename.GetWindowText(Filename);
  
	/* Initialize the open file dialog */
  CFileDialog FileDlg(TRUE, NIFCOPY_CSV_EXT, Filename, OFN_HIDEREADONLY | OFN_PATHMUSTEXIST, NIFCOPY_CSV_FILTER, this);
  FileDlg.m_ofn.lpstrTitle = _T("Select Input CSV File");

	/* Display the modal file dialog */
  Result = FileDlg.DoModal();
  if (Result != IDOK) return;

	/* Update the csv filename */
  m_InputCsv = FileDlg.GetPathName();
  m_CsvFilename.SetWindowText(m_InputCsv);

  	/* Attempt to load the CSV file */
  Result = m_CsvFile.Load(m_InputCsv);

  if (!Result) {
    ErrorHandler.Notify(_T("Csv Read Error!"));
    m_InputCsv.Empty();
   }

	/* Update the display */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CNifCopyDlg::OnCsvloadButton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CNifCopyDlg::OnInitDialog() {
  CDialog::OnInitDialog();

	/* Initialize the list control */
  m_CsvList.SetExtendedStyle(LVS_EX_GRIDLINES | LVS_EX_FULLROWSELECT);	

  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CNifCopyDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Event - void OnNifcopyCheck ();
 *
 *=========================================================================*/
void CNifCopyDlg::OnNifcopyCheck() {
  bool Result;

	/* Update the current control data */
  GetControlData();

	/* Check the data */
  Result = CheckData();

  if (Result)
    MessageBox(_T("Successfully checked the current CSV/NIF information."), _T("Csv Check Success!"), MB_OK | MB_ICONINFORMATION);
  else
    ErrorHandler.Notify(_T("Csv Check Failed!"));

 }
/*===========================================================================
 *		End of Class Event CNifCopyDlg::OnNifcopyCheck()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Event - void OnNifcopyCreate ();
 *
 *=========================================================================*/
void CNifCopyDlg::OnNifcopyCreate() {
  CString Buffer;
  bool    Result;

	/* Update the current control data */
  GetControlData();

	/* Check the data */
  Result = CheckData();
  
  if (!Result) {
    ErrorHandler.Notify(_T("Csv Check Failed!"));
    return;
   }

	/* Update the copy information */
  CreateCopyInfos();

	/* Attempt to create the nif files */
  Result = CreateFiles();
  
  if (!Result) {
    ErrorHandler.Notify(_T("Nif Copy Failed!"));
    return;
   }

  Buffer.Format(_T("Successfully created %d NIF files!"), m_CreatedFiles);
  MessageBox(Buffer, _T("NIF Copy Success!"), MB_OK | MB_ICONINFORMATION);
  EndDialog(IDOK);
 }
/*===========================================================================
 *		End of Class Event CNifCopyDlg::OnNifcopyCreate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Event - void OnNifloadButton ();
 *
 *=========================================================================*/
void CNifCopyDlg::OnNifloadButton() {
  CString Filename;
  int     Result;

	/* Get the current nif filename */
  GetControlData();
  m_NifFilename.GetWindowText(Filename);
  
	/* Initialize the open file dialog */
  CFileDialog FileDlg(TRUE, NIFCOPY_NIF_EXT, Filename, OFN_HIDEREADONLY | OFN_PATHMUSTEXIST, NIFCOPY_NIF_FILTER, this);
  FileDlg.m_ofn.lpstrTitle = _T("Select Input NIF File");

	/* Display the modal file dialog */
  Result = FileDlg.DoModal();
  if (Result != IDOK) return;

	/* Update the nif filename */
  m_InputNif = FileDlg.GetPathName();
  m_NifFilename.SetWindowText(m_InputNif);

	/* Attempt to load the NIF file */
  Result = m_NifFile.Read(m_InputNif);

  if (!Result) {
    ErrorHandler.Notify(_T("Nif Read Error!"));
    m_InputNif.Empty();
   }

  SetControlData();
 } 
/*===========================================================================
 *		End of Class Event CNifCopyDlg::OnNifloadButton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Method - void ResetInputNif (void);
 *
 * Resets the filename and source texture strings for the input nif.
 *
 *=========================================================================*/
void CNifCopyDlg::ResetInputNif (void) {
  CNifCopyInfo* pCopyInfo;
  int		Index;

	/* Update from all copy info records */
  for (Index = 0; Index < m_CopyInfos.GetNumElements(); Index++) {
    pCopyInfo = m_CopyInfos.GetAt(Index);

    if (pCopyInfo->pSourceTexture != NULL) {
      pCopyInfo->pSourceTexture->SetTextureName(pCopyInfo->OrigTexture);
     }
   }

 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::ResetInputNif()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CNifCopyDlg::SetControlData (void) {

	/* Set filenames */
  m_CsvFilename.SetWindowText(m_InputCsv);
  m_NifFilename.SetWindowText(m_InputNif);

	/* Set options */
  m_OverwriteCheck.SetCheck(m_OverWriteFiles);

	/* Update the csv and texture lists */
  FillCsvList();
  FillTextureList();
 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifCopyDlg Method - bool UpdateTextures (pRow);
 *
 * Updates the NIF textures for the given row. Returns false on any error.
 *
 *=========================================================================*/
bool CNifCopyDlg::UpdateTextures (CCsvRow* pRow) {
  CNifCopyInfo* pCopyInfo;
  CSString*     pString;
  int		Index;

	/* Update from all copy info records */
  for (Index = 0; Index < m_CopyInfos.GetNumElements(); Index++) {
    pCopyInfo = m_CopyInfos.GetAt(Index);
    if (pCopyInfo->CsvColIndex < 0) continue;
    pString = pRow->GetAt(pCopyInfo->CsvColIndex);

		/* Change a texture record */
    if (pCopyInfo->pSourceTexture != NULL) {
      if (pString != NULL) pCopyInfo->pSourceTexture->SetTextureName((const TCHAR *)*pString);
     }
		/* Autotint a material */
    else if (pCopyInfo->pMaterialProperty != NULL) {
      if (pString != NULL && StringToBoolean(*pString)) pCopyInfo->pMaterialProperty->AutoTint();
     }
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CNifCopyDlg::UpdateTextures()
 *=========================================================================*/
