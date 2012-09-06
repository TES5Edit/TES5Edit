/*===========================================================================
 *
 * File:	Esmusesdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 7, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmUsesDlg.h"


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

  DEFINE_FILE("EsmUsesDlg.CPP");
  IMPLEMENT_DYNCREATE(CEsmUsesDlg, CFormView)
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CESmUsesDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmUsesDlg, CFormView)
  //{{AFX_MSG_MAP(CEsmUsesDlg)
  ON_WM_DESTROY()
  ON_MESSAGE(ESMLIST_NOTIFY_ONEDIT, OnEditRecord)
  ON_COMMAND(ID_EDIT_INFO, OnEditInfo)
  ON_UPDATE_COMMAND_UI(ID_EDIT_INFO, OnUpdateEditInfo)
  ON_WM_CONTEXTMENU()
  ON_BN_CLICKED(IDCANCEL, OnCancel)
  ON_COMMAND(ID_EDIT_SELECTRECORD, OnEditSelectrecord)
  ON_UPDATE_COMMAND_UI(ID_EDIT_SELECTRECORD, OnUpdateEditSelectrecord)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CESmUsesDlg Message Map
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
 * Class CEsmUsesDlg Constructor
 *
 *=========================================================================*/
CEsmUsesDlg::CEsmUsesDlg() : CFormView(CEsmUsesDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmUsesDlg)
  //}}AFX_DATA_INIT
  m_pDlgHandler = NULL;
  m_pRecInfo    = NULL;
  m_TotalRecords = 0;
  m_UsedRecords  = 0;
 }
/*===========================================================================
 *		End of Class CEsmUsesDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmUsesDlg Destructor
 *
 *=========================================================================*/
CEsmUsesDlg::~CEsmUsesDlg() {
 }
/*===========================================================================
 *		End of Class CEsmUsesDlg Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmUsesDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmUsesDlg::DoDataExchange (CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmUsesDlg)
  DDX_Control(pDX, IDC_COUNTLABEL, m_UsesLabel);
  DDX_Control(pDX, IDC_PROGRESS1, m_ProgressBar);
  DDX_Control(pDX, IDC_RECORDLIST, m_RecordList);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmUsesDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class Diagnostics
 *
 *=========================================================================*/
#ifdef _DEBUG

void CEsmUsesDlg::AssertValid() const {
  CFormView::AssertValid();
 }

void CEsmUsesDlg::Dump(CDumpContext& dc) const {
  CFormView::Dump(dc);
 }

#endif 
/*===========================================================================
 *		End of Class Diagnostics
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmUsesDlg Event - void OnCancel ();
 *
 *=========================================================================*/
void CEsmUsesDlg::OnCancel() {
  GetParentFrame()->DestroyWindow();
 }
/*===========================================================================
 *		End of Class Event CEsmUsesDlg::OnCancel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmUsesDlg Event - void OnContextMenu (pWnd, Point);
 *
 *=========================================================================*/
void CEsmUsesDlg::OnContextMenu (CWnd* pWnd, CPoint Point) {
   if (pWnd->GetDlgCtrlID() == IDC_RECORDLIST) OpenContextMenu(this, pWnd, Point, IDR_FIND_MENU);
 }
/*===========================================================================
 *		End of Class Event CEsmUsesDlg::OnContextMenu()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmUsesDlg Event - void OnDestroy();
 *
 *=========================================================================*/
void CEsmUsesDlg::OnDestroy() {
  CFormView::OnDestroy();
  m_pDlgHandler->OnCloseUsesDlg();
 }
/*===========================================================================
 *		End of Class Event CEsmUsesDlg::OnDestroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmUsesDlg Event - void OnEditInfo ();
 *
 *=========================================================================*/
void CEsmUsesDlg::OnEditInfo() {
  esmrecinfo_t* pRecInfo;

	/* Get the currently selected record */
  pRecInfo = m_RecordList.GetCurrentRecord();
  if (pRecInfo == NULL) return;

	/* Display the uses dialog */
  m_pDlgHandler->OpenUsesDlg(pRecInfo);
 }
/*===========================================================================
 *		End of Class Event CEsmUsesDlg::OnEditInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmUsesDlg Event - void OnUpdateEditInfo (pCmdUI);
 *
 *=========================================================================*/
void CEsmUsesDlg::OnUpdateEditInfo(CCmdUI* pCmdUI) {
  pCmdUI->Enable(m_RecordList.GetSelectedCount() > 0);
 }

void CEsmUsesDlg::OnUpdateEditSelectrecord(CCmdUI* pCmdUI) {
  pCmdUI->Enable(m_RecordList.GetSelectedCount() > 0);
 }
/*===========================================================================
 *		End of Class Event CEsmUsesDlg::OnUpdateEditInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmUsesDlg Event - LRESULT OnEditRecord (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmUsesDlg::OnEditRecord (LPARAM lParam, LPARAM wParam) {
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
 *		End of Class Event CEsmUsesDlg::OnEditRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmUsesDlg Event - void OnEditSelectrecord ();
 *
 *=========================================================================*/
void CEsmUsesDlg::OnEditSelectrecord() {
  m_pDlgHandler->GetDocument()->UpdateAllViews(NULL, MWEDITDOC_HINT_SELECTITEM, (CObject *)m_RecordList.GetCurrentRecord());
}
/*===========================================================================
 *		End of Class Event CEsmUsesDlg::OnEditSelectrecord()
 *=========================================================================*/

/*===========================================================================
 *
 * Class CEsmUsesDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmUsesDlg::OnInitialUpdate() {
  
  CFormView::OnInitialUpdate();
  ResizeParentToFit(FALSE);
  UpdateTitle();

	/* Initialize the progress bar */
  m_ProgressBar.SetRange(0, 100);
  m_ProgressBar.SetPos(0);

	/* Initialize the record list */
  m_RecordList.OnInitCtrl();
  m_RecordList.SetDlgHandler(m_pDlgHandler);
  m_RecordList.InitObjectList(l_ItemColData);
  m_RecordList.SetWantKeys(false);
  m_RecordList.SetAcceptDrag(false);
  m_RecordList.SetEnableDrag(true);
  m_RecordList.SetWantEditMsg(true);

	/* Find the uses information for the current record */
  //ShowWindow(SW_NORMAL);
  //RedrawWindow();
  //GetParentFrame()->ShowWindow(SW_NORMAL);
  //UpdateUses();
 }
/*===========================================================================
 *		End of Class Event CEsmUsesDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmUsesDlg Method - void UpdateLabel (void);
 *
 * Updates the uses label.
 *
 *=========================================================================*/
void CEsmUsesDlg::UpdateLabel (void) {
  CString Buffer;

  if (m_pRecInfo != NULL)
    Buffer.Format(_T("Record %s (%s) is found in the following objects (%d of %d records)..."), m_pRecInfo->pRecord->GetID(), 
			m_pRecInfo->pRecord->GetItemType(), m_UsedRecords, m_TotalRecords);
  else
    Buffer.Format(_T("Record ?? (???) is found in the following objects (%d of %d records)..."), m_UsedRecords, m_TotalRecords);
    
  m_UsesLabel.SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmUsesDlg::UpdateLabel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmUsesDlg Method - void UpdateTitle (void);
 *
 * Updates the parent frame title based on the current document and 
 * record information.
 *
 *=========================================================================*/
void CEsmUsesDlg::UpdateTitle (void) {
  CString Buffer;

  if (m_pRecInfo != NULL)
    Buffer.Format(_T("%s -- Uses -- %s"), m_pDlgHandler->GetDocument()->GetTitle(), m_pRecInfo->pRecord->GetID());
  else
    Buffer.Format(_T("%s -- Uses --"), m_pDlgHandler->GetDocument()->GetTitle());
    
  GetParentFrame()->SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmUsesDlg::UpdateTitle()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmUsesDlg Method - bool UpdateUses (void);
 *
 * Updates the uses information for the current record. Returns false on
 * any error.
 *
 *=========================================================================*/
bool CEsmUsesDlg::UpdateUses (void) {
  CEsmRecInfoArray* pRecInfoArray = m_pDlgHandler->GetDocument()->GetRecInfoArray();
  esmrecinfo_t*     pRecInfo;
  const TCHAR*	    pRecordID;
  bool		    Result;
  int		    iResult;
  int		    Index;

	/* Reset variables */
  m_RecordList.DeleteAllItems();
  m_TotalRecords = pRecInfoArray->GetSize();
  m_UsedRecords  = 0;
  m_ProgressBar.SetPos(0);

	/* Update the frame title */
  UpdateTitle();

	/* Ignore if there is nothing to look for */
  if (m_pRecInfo == NULL) {
    m_UsesLabel.SetWindowText(_T("No record specified!"));
    return (false);
   }

	/* Get the record ID to look for */
  pRecordID = m_pRecInfo->pRecord->GetID();
  if (pRecordID == NULL || *pRecordID == NULL_CHAR) pRecordID = m_pRecInfo->pRecord->GetFieldString(ESM_FIELD_ID);

	/* Don't bother searching for an empty record ID */
  if (pRecordID == NULL || *pRecordID == NULL_CHAR) {
    m_UsesLabel.SetWindowText(_T("Null or empty record ID specified!"));
    return (false);
   }

  SystemLog.Printf(_T("Finding uses info = '%s'"), pRecordID);

	/* Search all current records (except the current one) */
  for (Index = 0; Index < pRecInfoArray->GetSize(); Index++) {
    pRecInfo = pRecInfoArray->GetAt(Index);
    if (pRecInfo == m_pRecInfo) continue;
    Result =  pRecInfo->pRecord->IsUsed(pRecordID);

    if (Result) {
      iResult = m_RecordList.AddItem(pRecInfo);
      m_UsedRecords++;
     }

		/* Update the progress bar as required */
    if (Index % 100 == 0) {
      m_ProgressBar.SetPos(Index * 100 / pRecInfoArray->GetSize());
      m_ProgressBar.RedrawWindow();
     }
   }

	/* Resort the found item list */
  m_RecordList.SortItems(l_ItemSortCallBack, ESM_FIELD_ID);
  m_RecordList.SortItems(l_ItemSortCallBack, ESM_FIELD_ITEMTYPE);
  m_ProgressBar.SetPos(0);

  UpdateLabel();
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmUsesDlg::UpdateUses()
 *=========================================================================*/




