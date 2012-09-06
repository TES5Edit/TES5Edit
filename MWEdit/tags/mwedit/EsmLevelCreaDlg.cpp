/*===========================================================================
 *
 * File:	Esmlevelcreadlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 15, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmLevelCreaDlg.h"


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

  DEFINE_FILE("EsmLevelCreaDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmLevelCreaDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int CALLBACK l_CreaSortCallBack (lParam1, lParam2, lParamSort);
 *
 *=========================================================================*/
int CALLBACK l_CreaSortCallBack (LPARAM lParam1, LPARAM lParam2, LPARAM lParamSort) {
  esmrecinfo_t* pRecInfo1 = (esmrecinfo_t*) lParam1;
  esmrecinfo_t* pRecInfo2 = (esmrecinfo_t*) lParam2;
  int	        SortType = lParamSort & 0xFFFF;
  int	        Flags    = lParamSort >> 16;
  int	        Result;

  if (SortType == ESM_FIELD_CUSTOM) {
    Result = pRecInfo1->UserData - pRecInfo2->UserData;
    if (Flags) return (-Result);
    return (Result);
   }

  return l_ItemSortCallBack(lParam1, lParam2, lParamSort);
 }



int CALLBACK l_CreaSortCallBack1 (LPARAM lParam1, LPARAM lParam2, LPARAM lParamData) {
  esmrecinfo_t*     pRecInfo1 = (esmrecinfo_t*) lParam1;
  esmrecinfo_t*	    pRecInfo2 = (esmrecinfo_t*) lParam2;
  CEsmLevelCreaDlg* pDialog   = (CEsmLevelCreaDlg *) lParamData;
  int	            SortType  = pDialog->GetSortData() & 0xFFFF;
  int	            Flags     = pDialog->GetSortData() >> 16;
  int	            Result;

  if (SortType == ESM_FIELD_CUSTOM) {
    Result = pDialog->GetSortCount(pRecInfo1) - pDialog->GetSortCount(pRecInfo2);
    if (Flags) return (-Result);
    return (Result);
   }

  return l_ItemSortCallBack(lParam1, lParam2, pDialog->GetSortData());
 }
/*===========================================================================
 *		End of Function CALLBACK l_CreaSortCallBack()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Item List Display Data Array
 *
 *=========================================================================*/
static esmcoldata_t l_CreatureColData[] = {
	{  _T("Level"),		ESM_FIELD_CUSTOM,	LVCFMT_CENTER,	ESMLIST_WIDTH_COUNT+20,	ESMLIST_SUBITEM_COUNT, l_CreaSortCallBack }, 
	{  _T("ID"),		ESM_FIELD_ID,		LVCFMT_LEFT,	ESMLIST_WIDTH_ID,	ESMLIST_SUBITEM_ID, }, 
	{  _T("Mod"),		ESM_FIELD_CHANGED,	LVCFMT_CENTER,	ESMLIST_WIDTH_CHANGED,	ESMLIST_SUBITEM_CHANGED }, 
	{  _T("Name"),		ESM_FIELD_NAME,		LVCFMT_LEFT,	ESMLIST_WIDTH_NAME,	ESMLIST_SUBITEM_NAME }, 
	{  _T("Type"),		ESM_FIELD_ITEMTYPE,	LVCFMT_LEFT,	ESMLIST_WIDTH_ITEMTYPE,	ESMLIST_SUBITEM_ITEMTYPE }, 
	{ NULL, 0, 0, 0 }	/* Must be last record */
 };
/*===========================================================================
 *		End of Item List Display Data Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmLevelCreaDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmLevelCreaDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmLevelCreaDlg)
  ON_MESSAGE(ESMLIST_NOTIFY_ONDROP, OnRecordDrop)
  ON_MESSAGE(ESMLIST_NOTIFY_ONKEY, OnRecordKey)
  ON_NOTIFY(LVN_ENDLABELEDIT, IDC_CREATURELIST, OnEndlabeleditlist)
  ON_MESSAGE(ESMLIST_NOTIFY_ONSORT, OnRecordSort)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmLevelCreaDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelCreaDlg Constructor
 *
 *=========================================================================*/
CEsmLevelCreaDlg::CEsmLevelCreaDlg() : CEsmRecDialog(CEsmLevelCreaDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmLevelCreaDlg)
  //}}AFX_DATA_INIT
  m_pLevelCrea = NULL;
 }
/*===========================================================================
 *		End of Class CEsmLevelCreaDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelCreaDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmLevelCreaDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmLevelCreaDlg)
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_PCLEVELCHECK, m_PCLevelCheck);
  DDX_Control(pDX, IDC_CHANCENONETEXT, m_ChanceNoneText);
  DDX_Control(pDX, IDC_CREATURELIST, m_CreatureList);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmLevelCreaDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelCreaDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmLevelCreaDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmLevelCreaDlg::GetControlData()");
  CString Buffer;  
  int     Chance;
  
	/* Update the armor pointer and data */
  m_pLevelCrea = (CEsmLevelCrea *) GetRecInfo()->pRecord;
  ASSERT(m_pLevelCrea != NULL);
  
	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pLevelCrea->SetID(TrimStringSpace(Buffer));
   }

  	/* Chance none */
  m_ChanceNoneText.GetWindowText(Buffer);
  Chance = atoi(Buffer);
  if (Chance < 0) Chance = 0;
  if (Chance > 100) Chance = 100;
  m_pLevelCrea->SetChanceNone(Chance);

	/* Record flags */
  m_pLevelCrea->SetBlocked(m_BlockedCheck.GetCheck() != 0);
  m_pLevelCrea->SetAllPC(m_PCLevelCheck.GetCheck() != 0);

  GetCreatureData();
 }
/*===========================================================================
 *		End of Class Method CEsmLevelCreaDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelCreaDlg Method - int GetSortCount (pRecInfo);
 *
 * Return the current count/level for the given recinfo in the list. Returns
 * 0 on any error.
 *
 *=========================================================================*/
int CEsmLevelCreaDlg::GetSortCount (esmrecinfo_t* pRecInfo) {
  CString Buffer;
  int     ListIndex;
  int     Count;

	/* Attempt to find the record in the list */
  ListIndex = m_CreatureList.FindRecord(pRecInfo);
  if (ListIndex < 0) return (0);

	/* Get the text and convert to a number value */
  Buffer = m_CreatureList.GetItemText(ListIndex, 0);
  Count = atoi(Buffer);
  if (Count < 0) Count = 0;

  return (Count);
 }
/*===========================================================================
 *		End of Class Method CEsmLevelCreaDlg::GetSortCount()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelCreaDlg Method - void GetCreatureData (void);
 *
 *=========================================================================*/
void CEsmLevelCreaDlg::GetCreatureData (void) {
  CEsmSubNameFix* pNameSubRec;
  CEsmSubShort*	  pLevelSubRec;
  CString	  Buffer;
  int		  Index;
  int		  Level;
  int		  CreatureCount = 0;

  	/* Delete all the CNAM and INTV sub-records from the record */
  m_pLevelCrea->DeleteSubRecords(MWESM_SUBREC_CNAM);
  m_pLevelCrea->DeleteSubRecords(MWESM_SUBREC_INTV);

  for (Index = 0; Index < m_CreatureList.GetItemCount(); Index++) {
    Buffer = m_CreatureList.GetItemText(Index, 0);
    Level = atoi(Buffer);
    Buffer = m_CreatureList.GetItemText(Index, 1);

    	/* Create the new index sub-record */
    pNameSubRec  = (CEsmSubNameFix *) m_pLevelCrea->AllocateSubRecord(MWESM_SUBREC_CNAM);
    pLevelSubRec = (CEsmSubShort *)   m_pLevelCrea->AllocateSubRecord(MWESM_SUBREC_INTV);
    pNameSubRec->CreateNew();
    pLevelSubRec->CreateNew();
    pNameSubRec->SetName(Buffer);
    pLevelSubRec->SetValue(Level);

    CreatureCount++;
   }
  
  m_pLevelCrea->SetListSize(CreatureCount);
 }
/*===========================================================================
 *		End of Class Method CEsmLevelCreaDlg::GetCreatureData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelCreaDlg Event - void OnEndlabeleditlist (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmLevelCreaDlg::OnEndlabeleditlist(NMHDR* pNMHDR, LRESULT* pResult) {
  LV_DISPINFO*	pDispInfo = (LV_DISPINFO*)pNMHDR;
  CString	Buffer;
  int		Count;

  if (pDispInfo->item.pszText != NULL) {
    Count = atoi(pDispInfo->item.pszText);
    if (Count < SHRT_MIN) Count = SHRT_MIN;
    if (Count > SHRT_MAX) Count = SHRT_MAX;
    Buffer.Format(_T("%d"), Count);
    m_CreatureList.SetItemText(pDispInfo->item.iItem, 0, Buffer);

    //pRecInfo = (esmrecinfo_t *)m_CreatureList.GetItemData(pDispInfo->item.iItem);
    //pRecInfo->UserData = Count;
   }

  *pResult = 0;
 }
/*===========================================================================
 *		End of Class Event CEsmLevelCreaDlg::OnEndlabeleditlist()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelCreaDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmLevelCreaDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_IDText.GetModify())         m_Modified = true;
  if (m_ChanceNoneText.GetModify()) m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmLevelCreaDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelCreaDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmLevelCreaDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

	/* Initialize the list control */
  m_CreatureList.OnInitCtrl();
  m_CreatureList.SetDlgHandler(m_pParent);
  m_CreatureList.InitObjectList(l_CreatureColData);
  m_CreatureList.SetWantKeys(true);
  m_CreatureList.SetAcceptDrag(true);
  m_CreatureList.SetEnableDrag(true);
  m_CreatureList.SetWantSortMsg(true);

	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pLevelCrea = (CEsmLevelCrea *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_ChanceNoneText.SetLimitText(4);

	/* Update the UI data */
  SetControlData();
  m_CreatureList.SortItems(l_CreaSortCallBack, ESM_FIELD_CUSTOM);
 }
/*===========================================================================
 *		End of Class Event CEsmLevelCreaDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelCreaDlg Event - LRESULT OnRecordDrop (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmLevelCreaDlg::OnRecordDrop (LPARAM lParam, LPARAM wParam) {
  CString	Buffer;
  CMWEditDoc*   pSourceDoc = (CMWEditDoc *) lParam;
  esmrecinfo_t* pRecInfo = (esmrecinfo_t *) wParam;
  int		ListIndex;

	/* Ensure we only drag from the current document */
  if (pSourceDoc != GetDocument()) return (0);
  
	/* Only accept creature/NPC records */
  if (!pRecInfo->pRecord->IsType(MWESM_REC_NPC_) && 
      !pRecInfo->pRecord->IsType(MWESM_REC_CREA)) return (0);

	/* Add a new creature to the list */
  ListIndex = m_CreatureList.AddItem(pRecInfo);
  m_CreatureList.SetItemText(ListIndex, 0, _T("1"));	/* Default level 1 */

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmLevelCreaDlg::OnRecordDrop()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelCreaDlg Event - LRESULT  OnRecordKey (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmLevelCreaDlg::OnRecordKey (LPARAM lParam, LPARAM wParam) {
  CString	Buffer;
  int		ListIndex;
  int		AddCount;
  int		Count;
    
	/* Update all selected creatures */
  if (lParam == VK_ADD || lParam ==  VK_SUBTRACT) {
    AddCount = (lParam == VK_ADD) ? 1 : -1;
    ListIndex = m_CreatureList.GetNextItem(-1, LVNI_SELECTED);

    while (ListIndex >= 0) {
      Buffer = m_CreatureList.GetItemText(ListIndex, 0);
      Count = atoi(Buffer);
      if (Count < 0) Count = 0;

      Buffer.Format(_T("%d"), Count + AddCount);
      m_CreatureList.SetItemText(ListIndex, 0, Buffer);
      ListIndex = m_CreatureList.GetNextItem(ListIndex, LVNI_SELECTED);
     }
  
    return (1);
   }
  else if (lParam == VK_DELETE || lParam == VK_BACK) {
    ListIndex = m_CreatureList.GetNextItem(-1, LVNI_SELECTED);

    while (ListIndex >= 0) {
      m_CreatureList.DeleteItem(ListIndex);
      ListIndex = m_CreatureList.GetNextItem(-1, LVNI_SELECTED);
     }
  
    return (1);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmLevelCreaDlg::OnRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelCreaDlg Event - LRESULT OnRecordSort (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmLevelCreaDlg::OnRecordSort (LPARAM lParam, LPARAM wParam) {
  esmlistsortdata_t* pSortData = (esmlistsortdata_t *) lParam;

  m_SortData = pSortData->iField | (pSortData->Reverse << 16);
  m_CreatureList.SortItems(l_CreaSortCallBack1, (DWORD) this);

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmLevelCreaDlg::OnRecordSort()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelCreaDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmLevelCreaDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  CString Buffer;
  int     Index;

	/* Update an item inside the container */
  Index = m_CreatureList.FindRecord(pRecInfo);

  if (Index >= 0) {
    m_CreatureList.UpdateItem(Index);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmLevelCreaDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelCreaDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmLevelCreaDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pLevelCrea == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pLevelCrea->GetID());
  UpdateTitle(m_pLevelCrea->GetID());

	/* Item strings and values */
  m_ChanceNoneText.SetWindowText(m_pLevelCrea->GetFieldString(ESM_FIELD_CHANCENONE));
  m_ChanceNoneText.SetModify(FALSE);
  
	/* Record flags */
  m_BlockedCheck.SetCheck(m_pLevelCrea->IsBlocked());
  m_PCLevelCheck.SetCheck(m_pLevelCrea->IsAllPC());

  SetCreatureData();
 }
/*===========================================================================
 *		End of Class Method CEsmLevelCreaDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelCreaDlg Method - void SetCreatureData (void);
 *
 *=========================================================================*/
void CEsmLevelCreaDlg::SetCreatureData (void) {
  CEsmSubNameFix* pNameSubRec;
  CEsmSubShort*   pLevelSubRec;
  esmrecinfo_t*   pRecInfo;
  CString	  Buffer;
  int		  ArrayIndex;
  int		  ListIndex;

  pNameSubRec = (CEsmSubNameFix *) m_pLevelCrea->FindFirst(MWESM_SUBREC_CNAM, ArrayIndex);

  while (pNameSubRec != NULL) {
    SystemLog.Printf ("Found '%s'", pNameSubRec->GetName());
    pLevelSubRec = (CEsmSubShort *) m_pLevelCrea->GetSubRecord(ArrayIndex + 1);
    pRecInfo = GetDocument()->FindRecord(pNameSubRec->GetName());

    if (pRecInfo != NULL && pLevelSubRec != NULL && pLevelSubRec->IsType(MWESM_SUBREC_INTV)) {
      ListIndex = m_CreatureList.AddItem(pRecInfo);
      pRecInfo->UserData = pLevelSubRec->GetValue();
      Buffer.Format(_T("%d"), pRecInfo->UserData);
      m_CreatureList.SetItemText(ListIndex, 0, Buffer);
     }

    pNameSubRec = (CEsmSubNameFix *) m_pLevelCrea->FindNext(MWESM_SUBREC_CNAM, ArrayIndex);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmLevelCreaDlg::SetCreatureData()
 *=========================================================================*/


