/*===========================================================================
 *
 * File:	Esmlevelitemdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 15, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "esmlevelitemdlg.h"
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmLevelItemDlg.h"


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

  DEFINE_FILE("EsmLevelItemDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmLevelItemDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int CALLBACK l_LevItemSortCallBack (lParam1, lParam2, lParamSort);
 *
 *=========================================================================*/
int CALLBACK l_LevItemSortCallBack (LPARAM lParam1, LPARAM lParam2, LPARAM lParamSort) {
  esmrecinfo_t* pRecInfo1 = (esmrecinfo_t*) lParam1;
  esmrecinfo_t* pRecInfo2 = (esmrecinfo_t*) lParam2;
  int	        SortType  = lParamSort & 0xFFFF;
  int	        Flags     = lParamSort >> 16;
  int	        Result;

  if (SortType == ESM_FIELD_CUSTOM) {
    Result = pRecInfo1->UserData - pRecInfo2->UserData;
    if (Flags) return (-Result);
    return (Result);
   }

  return l_ItemSortCallBack(lParam1, lParam2, lParamSort);
 }


int CALLBACK l_LevItemSortCallBack1 (LPARAM lParam1, LPARAM lParam2, LPARAM lParamData) {
  esmrecinfo_t*     pRecInfo1 = (esmrecinfo_t*) lParam1;
  esmrecinfo_t*	    pRecInfo2 = (esmrecinfo_t*) lParam2;
  CEsmLevelItemDlg* pDialog   = (CEsmLevelItemDlg *) lParamData;
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
 *		End of Function CALLBACK l_LevItemSortCallBack()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Item List Display Data Array
 *
 *=========================================================================*/
static esmcoldata_t l_ItemColData[] = {
	{  _T("Level"),		ESM_FIELD_CUSTOM,	LVCFMT_CENTER,	ESMLIST_WIDTH_COUNT+20,	ESMLIST_SUBITEM_COUNT, l_LevItemSortCallBack }, 
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
 * Begin CEsmLevelItemDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmLevelItemDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmLevelItemDlg)
  ON_MESSAGE(ESMLIST_NOTIFY_ONDROP, OnRecordDrop)
  ON_MESSAGE(ESMLIST_NOTIFY_ONKEY, OnRecordKey)
  ON_MESSAGE(ESMLIST_NOTIFY_ONSORT, OnRecordSort)
  ON_NOTIFY(LVN_ENDLABELEDIT, IDC_ITEMLIST, OnEndlabeleditlist)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmLevelItemDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelItemDlg Constructor
 *
 *=========================================================================*/
CEsmLevelItemDlg::CEsmLevelItemDlg() : CEsmRecDialog(CEsmLevelItemDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmLevelItemDlg)
  //}}AFX_DATA_INIT
  m_pLevelItem = NULL;
 }
/*===========================================================================
 *		End of Class CEsmLevelItemDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelItemDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmLevelItemDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmLevelItemDlg)
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_PCLEVELCHECK, m_PCLevelCheck);
  DDX_Control(pDX, IDC_EACHITEMCHECK, m_EachItemCheck);
  DDX_Control(pDX, IDC_CHANCENONETEXT, m_ChanceNoneText);
  DDX_Control(pDX, IDC_ITEMLIST, m_ItemList);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmLevelItemDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelItemDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmLevelItemDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmLevelItemDlg::GetControlData()");
  CString Buffer;  
  int     Chance;
  
	/* Update the armor pointer and data */
  m_pLevelItem = (CEsmLevelItem *) GetRecInfo()->pRecord;
  ASSERT(m_pLevelItem != NULL);
  
	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pLevelItem->SetID(TrimStringSpace(Buffer));
   }

  	/* Chance none */
  m_ChanceNoneText.GetWindowText(Buffer);
  Chance = atoi(Buffer);
  if (Chance < 0) Chance = 0;
  if (Chance > 100) Chance = 100;
  m_pLevelItem->SetChanceNone(Chance);

	/* Record flags */
  m_pLevelItem->SetBlocked(m_BlockedCheck.GetCheck() != 0);
  m_pLevelItem->SetAllPC(m_PCLevelCheck.GetCheck() != 0);
  m_pLevelItem->SetCalcEach(m_EachItemCheck.GetCheck() != 0);

  GetItemData();
 }
/*===========================================================================
 *		End of Class Method CEsmLevelItemDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelItemDlg Method - void GetItemData (void);
 *
 *=========================================================================*/
void CEsmLevelItemDlg::GetItemData (void) {
  CEsmSubNameFix* pNameSubRec;
  CEsmSubShort*	  pLevelSubRec;
  CString	  Buffer;
  int		  Index;
  int		  Level;
  int		  ItemCount = 0;

  	/* Delete all the CNAM and INTV sub-records from the record */
  m_pLevelItem->DeleteSubRecords(MWESM_SUBREC_INAM);
  m_pLevelItem->DeleteSubRecords(MWESM_SUBREC_INTV);

  for (Index = 0; Index < m_ItemList.GetItemCount(); Index++) {
    Buffer = m_ItemList.GetItemText(Index, 0);
    Level = atoi(Buffer);
    Buffer = m_ItemList.GetItemText(Index, 1);

    	/* Create the new index sub-record */
    pNameSubRec  = (CEsmSubNameFix *) m_pLevelItem->AllocateSubRecord(MWESM_SUBREC_INAM);
    pLevelSubRec = (CEsmSubShort *)   m_pLevelItem->AllocateSubRecord(MWESM_SUBREC_INTV);
    pNameSubRec->CreateNew();
    pLevelSubRec->CreateNew();
    pNameSubRec->SetName(Buffer);
    pLevelSubRec->SetValue(Level);

    ItemCount++;
   }
  
  m_pLevelItem->SetListSize(ItemCount);
 }
/*===========================================================================
 *		End of Class Method CEsmLevelItemDlg::GetItemData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelItemDlg Method - int GetSortCount (pRecInfo);
 *
 * Return the current count/level for the given recinfo in the list. Returns
 * 0 on any error.
 *
 *=========================================================================*/
int CEsmLevelItemDlg::GetSortCount (esmrecinfo_t* pRecInfo) {
  CString Buffer;
  int     ListIndex;
  int     Count;

	/* Attempt to find the record in the list */
  ListIndex = m_ItemList.FindRecord(pRecInfo);
  if (ListIndex < 0) return (0);

	/* Get the text and convert to a number value */
  Buffer = m_ItemList.GetItemText(ListIndex, 0);
  Count = atoi(Buffer);
  if (Count < 0) Count = 0;

  return (Count);
 }
/*===========================================================================
 *		End of Class Method CEsmLevelItemDlg::GetSortCount()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelItemDlg Event - void OnEndlabeleditlist (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmLevelItemDlg::OnEndlabeleditlist(NMHDR* pNMHDR, LRESULT* pResult) {
  LV_DISPINFO*	pDispInfo = (LV_DISPINFO*)pNMHDR;
  CString	Buffer;
  int		Count;

  if (pDispInfo->item.pszText != NULL) {
    Count = atoi(pDispInfo->item.pszText);
    if (Count < SHRT_MIN) Count = SHRT_MIN;
    if (Count > SHRT_MAX) Count = SHRT_MAX;
    Buffer.Format(_T("%d"), Count);
    m_ItemList.SetItemText(pDispInfo->item.iItem, 0, Buffer);
   }

  *pResult = 0;
 }
/*===========================================================================
 *		End of Class Event CEsmLevelItemDlg::OnEndlabeleditlist()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelItemDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmLevelItemDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_IDText.GetModify())         m_Modified = true;
  if (m_ChanceNoneText.GetModify()) m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmLevelItemDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelItemDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmLevelItemDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

	/* Initialize the list control */
  m_ItemList.OnInitCtrl();
  m_ItemList.SetDlgHandler(m_pParent);
  m_ItemList.InitObjectList(l_ItemColData);
  m_ItemList.SetWantKeys(true);
  m_ItemList.SetAcceptDrag(true);
  m_ItemList.SetEnableDrag(true);
  m_ItemList.SetWantSortMsg(true);

	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pLevelItem = (CEsmLevelItem *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_ChanceNoneText.SetLimitText(4);

	/* Update the UI data */
  SetControlData();
  m_ItemList.SortItems(l_LevItemSortCallBack, ESM_FIELD_CUSTOM);
 }
/*===========================================================================
 *		End of Class Event CEsmLevelItemDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelItemDlg Event - LRESULT OnRecordDrop (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmLevelItemDlg::OnRecordDrop (LPARAM lParam, LPARAM wParam) {
  static const TCHAR* s_ValidTypes[] = { MWESM_REC_ALCH, MWESM_REC_ALCH, MWESM_REC_APPA, MWESM_REC_ARMO, 
	MWESM_REC_BOOK, MWESM_REC_CLOT, MWESM_REC_CREA, MWESM_REC_INGR, MWESM_REC_LEVI, MWESM_REC_LIGH,
	MWESM_REC_LOCK, MWESM_REC_MISC, MWESM_REC_REPA, MWESM_REC_PROB, MWESM_REC_WEAP, MWESM_REC_LEVI, 
	NULL };

  CString	Buffer;
  CMWEditDoc*   pSourceDoc = (CMWEditDoc *) lParam;
  esmrecinfo_t* pRecInfo = (esmrecinfo_t *) wParam;
  int		ListIndex;
  int		Index;

	/* Ensure we only drag from the current document */
  if (pSourceDoc != GetDocument()) return (0);

  	/* Only accept certain types */
  for (Index = 0; s_ValidTypes[Index] != NULL; Index++) {

		/* Add a new item to the list if the type is valid */
    if (pRecInfo->pRecord->IsType(s_ValidTypes[Index])) {
      ListIndex = m_ItemList.AddItem(pRecInfo);
      m_ItemList.SetItemText(ListIndex, 0, _T("1"));	/* Default 1 item */
      return (0);
     }
   }	
 
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmLevelItemDlg::OnRecordDrop()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelItemDlg Event - LRESULT OnRecordKey (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmLevelItemDlg::OnRecordKey (LPARAM lParam, LPARAM wParam) {
  CString	Buffer;
  int		ListIndex;
  int		AddCount;
  int		Count;

	/* Update all selected creatures */
  if (lParam == VK_ADD || lParam == VK_SUBTRACT) {
    AddCount = (lParam == VK_ADD) ? 1 : -1;
    ListIndex = m_ItemList.GetNextItem(-1, LVNI_SELECTED);

    while (ListIndex >= 0) {
      Buffer = m_ItemList.GetItemText(ListIndex, 0);
      Count = atoi(Buffer);
      if (Count < 0) Count = 0;

      Buffer.Format(_T("%d"), Count + AddCount);
      m_ItemList.SetItemText(ListIndex, 0, Buffer);
      ListIndex = m_ItemList.GetNextItem(ListIndex, LVNI_SELECTED);
     }
  
    return (1);
   }
  else if (lParam == VK_DELETE || lParam == VK_BACK) {
    ListIndex = m_ItemList.GetNextItem(-1, LVNI_SELECTED);

    while (ListIndex >= 0) {
      m_ItemList.DeleteItem(ListIndex);
      ListIndex = m_ItemList.GetNextItem(-1, LVNI_SELECTED);
     }
  
    return (1);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmLevelItemDlg::OnRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelItemDlg Event - LRESULT OnRecordSort (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmLevelItemDlg::OnRecordSort (LPARAM lParam, LPARAM wParam) {
  esmlistsortdata_t* pSortData = (esmlistsortdata_t *) lParam;

  m_SortData = pSortData->iField | (pSortData->Reverse << 16);
  m_ItemList.SortItems(l_LevItemSortCallBack1, (DWORD) this);

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmLevelItemDlg::OnRecordSort()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelItemDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmLevelItemDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  CString Buffer;
  int     Index;

	/* Update an item inside the container */
  Index = m_ItemList.FindRecord(pRecInfo);

  if (Index >= 0) {
    m_ItemList.UpdateItem(Index);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmLevelItemDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelItemDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmLevelItemDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pLevelItem == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pLevelItem->GetID());
  UpdateTitle(m_pLevelItem->GetID());

	/* Item strings and values */
  m_ChanceNoneText.SetWindowText(m_pLevelItem->GetFieldString(ESM_FIELD_CHANCENONE));
  m_ChanceNoneText.SetModify(FALSE);
  
	/* Record flags */
  m_BlockedCheck.SetCheck(m_pLevelItem->IsBlocked());
  m_PCLevelCheck.SetCheck(m_pLevelItem->IsAllPC());
  m_EachItemCheck.SetCheck(m_pLevelItem->IsCalcEach());

  SetItemData();
 }
/*===========================================================================
 *		End of Class Method CEsmLevelItemDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLevelItemDlg Method - void SetItemData (void);
 *
 *=========================================================================*/
void CEsmLevelItemDlg::SetItemData (void) {
  CEsmSubNameFix* pNameSubRec;
  CEsmSubShort*   pLevelSubRec;
  esmrecinfo_t*   pRecInfo;
  CString	  Buffer;
  int		  ArrayIndex;
  int		  ListIndex;

  pNameSubRec = (CEsmSubNameFix *) m_pLevelItem->FindFirst(MWESM_SUBREC_INAM, ArrayIndex);

  while (pNameSubRec != NULL) {
    pLevelSubRec = (CEsmSubShort *) m_pLevelItem->GetSubRecord(ArrayIndex + 1);
    pRecInfo = GetDocument()->FindRecord(pNameSubRec->GetName());

    if (pRecInfo != NULL && pLevelSubRec != NULL && pLevelSubRec->IsType(MWESM_SUBREC_INTV)) {
      ListIndex = m_ItemList.AddItem(pRecInfo);
      pRecInfo->UserData = pLevelSubRec->GetValue();
      Buffer.Format(_T("%d"), pRecInfo->UserData);
      m_ItemList.SetItemText(ListIndex, 0, Buffer);
     }

    pNameSubRec = (CEsmSubNameFix *) m_pLevelItem->FindNext(MWESM_SUBREC_INAM, ArrayIndex);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmLevelItemDlg::SetItemData()
 *=========================================================================*/
