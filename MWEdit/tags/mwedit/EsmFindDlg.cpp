/*===========================================================================
 *
 * File:	Esmfinddlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	March 3, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmFindDlg.h"
#include "EsmDlgArray.h"


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

  DEFINE_FILE("EsmFindDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmFindDlg, CFormView)
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Record List Display Data Array
 *
 *=========================================================================*/
static esmcoldata_t l_ItemColData[] = {
	{  _T("ID"),		ESM_FIELD_ID,		LVCFMT_LEFT,	ESMLIST_WIDTH_ID,	ESMLIST_SUBITEM_ID, }, 
	{  _T("Mod"),		ESM_FIELD_CHANGED,	LVCFMT_CENTER,	ESMLIST_WIDTH_CHANGED,	ESMLIST_SUBITEM_CHANGED }, 
	{  _T("Name"),		ESM_FIELD_NAME,		LVCFMT_LEFT,	ESMLIST_WIDTH_NAME,	ESMLIST_SUBITEM_NAME }, 
	{  _T("Type"),		ESM_FIELD_ITEMTYPE,	LVCFMT_LEFT,	ESMLIST_WIDTH_ITEMTYPE,	ESMLIST_SUBITEM_ITEMTYPE }, 
	{  _T("Topic"),		ESM_FIELD_TOPIC,	LVCFMT_LEFT,	ESMLIST_WIDTH_TOPIC,	ESMLIST_SUBITEM_TOPIC }, 
	{ NULL, 0, 0, 0 }	/* Must be last record */
 };
/*===========================================================================
 *		End of Record List Display Data Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmFindDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmFindDlg, CFormView)
  //{{AFX_MSG_MAP(CEsmFindDlg)
  ON_BN_CLICKED(IDC_FINDBUTTON, OnFindbutton)
  ON_WM_DESTROY()
  ON_MESSAGE(ESMLIST_NOTIFY_ONEDIT, OnEditRecord)
  ON_COMMAND(ID_EDIT_INFO, OnEditInfo)
  ON_UPDATE_COMMAND_UI(ID_EDIT_INFO, OnUpdateEditInfo)
  ON_COMMAND(ID_EDIT_COPY, OnEditCopy)
  ON_COMMAND(ID_EDIT_CUT, OnEditCut)
  ON_COMMAND(ID_EDIT_PASTE, OnEditPaste)
  ON_WM_CONTEXTMENU()
  ON_BN_CLICKED(IDCANCEL, OnCancel)
	ON_COMMAND(ID_EDIT_SELECTRECORD, OnEditSelectrecord)
	ON_UPDATE_COMMAND_UI(ID_EDIT_SELECTRECORD, OnUpdateEditSelectrecord)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmFindDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Constructor
 *
 *=========================================================================*/
CEsmFindDlg::CEsmFindDlg() : CFormView(CEsmFindDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmFindDlg)
  //}}AFX_DATA_INIT
  m_pDlgHandler  = NULL;
  m_hAccelerator = NULL;
 }
/*===========================================================================
 *		End of Class CEsmFindDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Destructor
 *
 *=========================================================================*/
CEsmFindDlg::~CEsmFindDlg() {
 }
/*===========================================================================
 *		End of Class CEsmFindDlg Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Method - void AddFindHistory (pString);
 *
 * Adds a find history record to the registry and the find list.
 *
 *=========================================================================*/
void CEsmFindDlg::AddFindHistory (const TCHAR* pString) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  bool		Result;

	/* Save the find text to the registry */
  Result = pApp->AddFindHistory(pString);

	/* Add the string to the top of the find list if required */
  if (Result) m_FindList.InsertString(0, pString);

 }
/*===========================================================================
 *		End of Class Method CEsmFindDlg::AddFindHistory()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmFindDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmFindDlg)
  DDX_Control(pDX, IDC_PROGRESS1, m_ProgressBar);
  DDX_Control(pDX, IDC_FINDLIST, m_FindList);
  DDX_Control(pDX, IDC_COUNTLABEL, m_CountLabel);
  DDX_Control(pDX, IDC_RECORDLIST, m_RecordList);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmFindDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class Diagnostics
 *
 *=========================================================================*/
#ifdef _DEBUG
void CEsmFindDlg::AssertValid() const {
  CFormView::AssertValid();
 }

void CEsmFindDlg::Dump(CDumpContext& dc) const {
  CFormView::Dump(dc);
 }

#endif 
/*===========================================================================
 *		End of Class Diagnostics
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Method - void FillFindList (void);
 *
 * Fills the find list with the history records from the registry.
 *
 *=========================================================================*/
void CEsmFindDlg::FillFindList (void) {
  CMWEditApp*	pApp = (CMWEditApp *) AfxGetApp();
  CString	Buffer;
  bool		Result;
  int		Index;

	/* Clear the current find list content */
  m_FindList.ResetContent();

	/* Add all exisiting find history records */
  for (Index = 0; Index < ESMSCR_FINDHISTORY_NUMRECORDS; Index++) {
    Result = pApp->ReadFindHistory(Buffer, Index);
    if (!Result) break;
    m_FindList.AddString(Buffer);

		/* Set the most recent entry */
    if (Index == 0) m_FindList.SetWindowText(Buffer);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmFindDlg::FillFindList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Event - void OnCancel ();
 *
 *=========================================================================*/
void CEsmFindDlg::OnCancel() {
  GetParentFrame()->DestroyWindow();
 }
/*===========================================================================
 *		End of Class Event CEsmFindDlg::OnCancel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Event - void OnContextMenu (pWnd, Point);
 *
 *=========================================================================*/
void CEsmFindDlg::OnContextMenu (CWnd* pWnd, CPoint Point) {
  if (pWnd->GetDlgCtrlID() == IDC_RECORDLIST) OpenContextMenu(this, pWnd, Point, IDR_FIND_MENU);
 }
/*===========================================================================
 *		End of Class Event CEsmFindDlg::OnContextMenu()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Event - void OnDestroy();
 *
 *=========================================================================*/
void CEsmFindDlg::OnDestroy() {
  CFormView::OnDestroy();
  m_pDlgHandler->OnCloseFindDlg();
 }
/*===========================================================================
 *		End of Class Event CEsmFindDlg::OnDestroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Event - void OnEditCopy ();
 *
 *=========================================================================*/
void CEsmFindDlg::OnEditCopy() {
  ClipCopyFromWnd(GetFocus());
 }


void CEsmFindDlg::OnEditCut() {
  ClipCutFromWnd(GetFocus());
 }


void CEsmFindDlg::OnEditPaste() {
  ClipPasteToWnd(GetFocus());
 }
/*===========================================================================
 *		End of Class Event CEsmFindDlg::OnEditPaste()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Event - LRESULT OnEditRecord (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmFindDlg::OnEditRecord (LPARAM lParam, LPARAM wParam) {
  POSITION	ListPos;
  int		ListIndex;
  esmrecinfo_t* pRecInfo;

	/* Get the first selected item */
  ListPos = m_RecordList.GetFirstSelectedItemPosition();
  if (ListPos == NULL) return (0);
  ListIndex = m_RecordList.GetNextSelectedItem(ListPos);

  pRecInfo = m_RecordList.GetRecInfo(ListIndex);
  if (m_pDlgHandler == NULL || pRecInfo == NULL) return (0);

	/* Check for special case of INFO record type */
  if (pRecInfo->pRecord->IsType(MWESM_REC_INFO)) {
    CEsmInfo* pInfo = (CEsmInfo *) pRecInfo->pRecord;
    esmrecinfo_t* pNewRecInfo = m_pDlgHandler->GetDocument()->FindRecInfo(pInfo->GetDialParent());

    if (pNewRecInfo != NULL) {
      m_pDlgHandler->EditRecord(pNewRecInfo);
      CFrameWnd* pWnd = m_pDlgHandler->FindDialog(pNewRecInfo);

      if (pWnd != NULL) { 
        pWnd->SendMessageToDescendants(ESMDLG_MSG_ONINFOEDIT, (LPARAM) pRecInfo, -1, FALSE); 
       }
     }
   }
  else {   
    m_pDlgHandler->EditRecord(pRecInfo);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmFindDlg::OnEditRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Event - void OnFindbutton ();
 *
 *=========================================================================*/
void CEsmFindDlg::OnFindbutton() {
  CEsmRecInfoArray* pRecInfoArray = m_pDlgHandler->GetDocument()->GetRecInfoArray();
  esmrecinfo_t*     pRecInfo;
  CString	    FindText;
  esmfind_t	    FindData;
  dword		    NumRecords = m_pDlgHandler->GetDocument()->GetNumRecords(); 
  bool		    Result;
  long		    Count;
  int		    Index;
  int		    iResult;

	/* Ensure we have valid text to find */
  m_CountLabel.SetWindowText(_T(""));
  m_FindList.GetWindowText(FindText);
  TrimStringSpace(FindText);
  if (FindText.IsEmpty()) return;

	/* Add the find string to the find history */
  AddFindHistory(FindText);

	/* Initialize the search */
  FindData.Length = FindText.GetLength();
  FindData.pText  = FindText;
  m_RecordList.DeleteAllItems();
  m_ProgressBar.SetRange(0, 100);
  m_ProgressBar.SetPos(0);
  Count = 0;

	/* Search all current records */
  for (Index = 0; Index < pRecInfoArray->GetSize(); Index++) {
    pRecInfo = pRecInfoArray->GetAt(Index);
    Result =  pRecInfo->pRecord->Find(FindData);

    if (Result) {
      iResult = m_RecordList.AddItem(pRecInfo);
      Count++;
     }

		/* Update the progress bar as required */
    if (Index % 100 == 0) {
      m_ProgressBar.SetPos(Index * 100 / NumRecords);
      m_ProgressBar.RedrawWindow();
     }
   }

	/* Resort the found item list */
  m_RecordList.SortItems(l_ItemSortCallBack, ESM_FIELD_ID);
  m_RecordList.SortItems(l_ItemSortCallBack, ESM_FIELD_ITEMTYPE);
  m_ProgressBar.SetPos(0);
    
	/* Output the status text */
  FindText.Format(_T("Found %ld matches in %ld records"), Count, NumRecords);
  m_CountLabel.SetWindowText(FindText);
 }
/*===========================================================================
 *		End of Class Event CEsmFindDlg::OnFindbutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmFindDlg::OnInitialUpdate() {
  CString Buffer;

  CFormView::OnInitialUpdate();
  ResizeParentToFit(FALSE);

	/* Fill the find history list */
  FillFindList();

	/* Create the shortcut key accelerators */
  m_hAccelerator = ::LoadAccelerators(AfxGetApp()->m_hInstance, MAKEINTRESOURCE(IDR_RECORD_ACCEL));

	/* Initialize the record list */
  m_RecordList.OnInitCtrl();
  m_RecordList.SetDlgHandler(m_pDlgHandler);
  m_RecordList.InitObjectList(l_ItemColData);
  m_RecordList.SetWantKeys(false);
  m_RecordList.SetAcceptDrag(false);
  m_RecordList.SetEnableDrag(true);
  m_RecordList.SetWantEditMsg(true);

	/* Update the title */
  Buffer.Format(_T("%s -- Find Text"), m_pDlgHandler->GetDocument()->GetTitle());
  GetParentFrame()->SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Event CEsmFindDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Event - void OnEditInfo ();
 *
 *=========================================================================*/
void CEsmFindDlg::OnEditInfo() {
  esmrecinfo_t* pRecInfo;

	/* Get the currently selected record */
  pRecInfo = m_RecordList.GetCurrentRecord();
  if (pRecInfo == NULL) return;

	/* Display the uses dialog */
  m_pDlgHandler->OpenUsesDlg(pRecInfo);
 }
/*===========================================================================
 *		End of Class Event CEsmFindDlg::OnEditInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Event - void OnEditSelectrecord ();
 *
 *=========================================================================*/
void CEsmFindDlg::OnEditSelectrecord() {
  m_pDlgHandler->GetDocument()->UpdateAllViews(NULL, MWEDITDOC_HINT_SELECTITEM, (CObject *)m_RecordList.GetCurrentRecord());
 }
/*===========================================================================
 *		End of Class Event CEsmFindDlg::OnEditSelectrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Event - void OnUpdateEditInfo (pCmdUI);
 *
 *=========================================================================*/
void CEsmFindDlg::OnUpdateEditInfo (CCmdUI* pCmdUI)  {
  pCmdUI->Enable(m_RecordList.GetSelectedCount() > 0);
 }


void CEsmFindDlg::OnUpdateEditSelectrecord(CCmdUI* pCmdUI) {
  pCmdUI->Enable(m_RecordList.GetSelectedCount() > 0);
 }
/*===========================================================================
 *		End of Class Event CEsmFindDlg::OnUpdateEditInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFindDlg Method - BOOL PreTranslateMessage (pMsg);
 *
 *=========================================================================*/
BOOL CEsmFindDlg::PreTranslateMessage(MSG* pMsg) {
  int Result;

  if (m_hAccelerator != NULL && pMsg->message >= WM_KEYFIRST && pMsg->message <= WM_KEYLAST) {
    Result = TranslateAccelerator(m_hWnd, m_hAccelerator, pMsg);
    if (Result != 0) return (Result);
   }
	
  return CFormView::PreTranslateMessage(pMsg);
 }
/*===========================================================================
 *		End of Class Method CEsmFindDlg::PreTranslateMessage()
 *=========================================================================*/



