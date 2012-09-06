/*===========================================================================
 *
 * File:	Esmcontaindlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 14, 2003
 *
 * Description
 *
 * 14 September 2003
 *	- The item count is not permanently held in the RecInfo->UserData
 *	  member any more. The UserData value is updated only just before
 *	  the list is to be sorted.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmContainDlg.h"


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

  DEFINE_FILE("EsmContainDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmContainDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int CALLBACK l_ContSortCallBack (lParam1, lParam2, lParamSort);
 *
 *=========================================================================*/
int CALLBACK l_ContSortCallBack (LPARAM lParam1, LPARAM lParam2, LPARAM lParamSort) {
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
/*===========================================================================
 *		End of Function CALLBACK l_ContSortCallBack()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Item List Display Data Array
 *
 *=========================================================================*/
static esmcoldata_t l_ItemColData[] = {
	{  _T("Count"),		ESM_FIELD_CUSTOM,	LVCFMT_CENTER,	ESMLIST_WIDTH_COUNT+20,	ESMLIST_SUBITEM_COUNT, l_ContSortCallBack }, 
	{  _T("ID"),		ESM_FIELD_ID,		LVCFMT_LEFT,	ESMLIST_WIDTH_ID,	ESMLIST_SUBITEM_ID, }, 
	{  _T("Mod"),		ESM_FIELD_CHANGED,	LVCFMT_CENTER,	ESMLIST_WIDTH_CHANGED,	ESMLIST_SUBITEM_CHANGED }, 
	{  _T("Name"),		ESM_FIELD_NAME,		LVCFMT_LEFT,	ESMLIST_WIDTH_NAME,	ESMLIST_SUBITEM_NAME }, 
	{  _T("Type"),		ESM_FIELD_ITEMTYPE,	LVCFMT_LEFT,	ESMLIST_WIDTH_INDEX,	ESMLIST_SUBITEM_ITEMTYPE }, 
	{ NULL, 0, 0, 0 }	/* Must be last record */
 };
/*===========================================================================
 *		End of Item List Display Data Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmContainDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmContainDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmContainDlg)
  ON_BN_CLICKED(IDC_ORGANICCHECK, OnOrganiccheck)
  ON_MESSAGE(ESMLIST_NOTIFY_ONDROP, OnRecordDrop)
  ON_MESSAGE(ESMLIST_NOTIFY_ONKEY, OnRecordKey)
  ON_NOTIFY(LVN_ENDLABELEDIT, IDC_ITEMLIST, OnEndlabeleditItemlist)
  ON_MESSAGE(ESMLIST_NOTIFY_ONSORT, OnRecordSort)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmContainDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Constructor
 *
 *=========================================================================*/
CEsmContainDlg::CEsmContainDlg() : CEsmRecDialog(CEsmContainDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmContainDlg)
  //}}AFX_DATA_INIT
  m_pContainer = NULL;
 }
/*===========================================================================
 *		End of Class CEsmContainDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmContainDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmContainDlg)
  DDX_Control(pDX, IDC_PERSISTCHECK, m_PersistCheck);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_RESPAWNCHECK, m_RespawnCheck);
  DDX_Control(pDX, IDC_ORGANICCHECK, m_OrganicCheck);
  DDX_Control(pDX, IDC_MODELBUTTON, m_ModelButton);
  DDX_Control(pDX, IDC_SCRIPTLIST, m_ScriptList);
  DDX_Control(pDX, IDC_WEIGHTTEXT, m_WeightText);
  DDX_Control(pDX, IDC_WEIGHTLABEL, m_WeightLabel);
  DDX_Control(pDX, IDC_ITEMLIST, m_ItemList);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmContainDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmContainDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmContainDlg::GetControlData()");
  CString	Buffer;  
  
	/* Update the armor pointer and data */
  m_pContainer = (CEsmContainer *) GetRecInfo()->pRecord;
  ASSERT(m_pContainer != NULL);
  
	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pContainer->SetID(TrimStringSpace(Buffer));
   }

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pContainer->SetName(TrimStringSpace(Buffer));

  	/* Item weight */
  m_WeightText.GetWindowText(Buffer);
  m_pContainer->SetWeight((float)atof(Buffer));

	/* Item script */
  m_ScriptList.GetWindowText(Buffer);
  m_pContainer->SetScript(TrimStringSpace(Buffer));
  	
	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pContainer->SetModel(TrimStringSpace(Buffer));

	/* Record flags */
  m_pContainer->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pContainer->SetBlocked(m_BlockedCheck.GetCheck() != 0);
  m_pContainer->SetOrganic(m_OrganicCheck.GetCheck() != 0);
  m_pContainer->SetRespawn(m_RespawnCheck.GetCheck() != 0);

  GetItemData();
 }
/*===========================================================================
 *		End of Class Method CEsmContainDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Method - void GetItemData (void);
 *
 *=========================================================================*/
void CEsmContainDlg::GetItemData (void) {
  CEsmSubNPCO*  pItemSubRec;
  CString	Buffer;
  int		Index;
  int		Count;

  	/* Delete all the NPCO sub-records from the record */
  m_pContainer->DeleteSubRecords(MWESM_SUBREC_NPCO);

  for (Index = 0; Index < m_ItemList.GetItemCount(); Index++) {
    Buffer = m_ItemList.GetItemText(Index, 0);
    Count = atoi(Buffer);
    Buffer = m_ItemList.GetItemText(Index, 1);

    	/* Create the new index sub-record */
    pItemSubRec = (CEsmSubNPCO *) m_pContainer->AllocateSubRecord(MWESM_SUBREC_NPCO);
    pItemSubRec->CreateNew();
    pItemSubRec->SetCount(Count);
    pItemSubRec->SetItem(Buffer);
   }
  
 }
/*===========================================================================
 *		End of Class Method CEsmContainDlg::GetItemData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Event - void OnEndlabeleditItemlist (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmContainDlg::OnEndlabeleditItemlist(NMHDR* pNMHDR, LRESULT* pResult) {
  LV_DISPINFO*	pDispInfo = (LV_DISPINFO*)pNMHDR;
  esmrecinfo_t* pRecInfo;
  CString	Buffer;
  int		Count;

  if (pDispInfo->item.pszText != NULL) {
    Count = atoi(pDispInfo->item.pszText);
    if (Count < SHRT_MIN) Count = SHRT_MIN;
    if (Count > SHRT_MAX) Count = SHRT_MAX;
    Buffer.Format(_T("%d"), Count);
    m_ItemList.SetItemText(pDispInfo->item.iItem, 0, Buffer);
    pRecInfo = (esmrecinfo_t *)m_ItemList.GetItemData(pDispInfo->item.iItem);
    pRecInfo->UserData = Count;
    UpdateTotalWeight();
   }

  *pResult = 0;
 }
/*===========================================================================
 *		End of Class Event CEsmContainDlg::OnEndlabeleditItemlist()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmContainDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_NameText.GetModify())   m_Modified = true;
  if (m_IDText.GetModify())     m_Modified = true;
  if (m_WeightText.GetModify()) m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmContainDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmContainDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

	/* Initialize the list control */
  m_ItemList.OnInitCtrl();
  m_ItemList.SetDlgHandler(m_pParent);
  m_ItemList.InitObjectList(l_ItemColData);
  m_ItemList.SetWantKeys(true);
  m_ItemList.SetWantSortMsg(true);
  m_ItemList.SetAcceptDrag(true);
  m_ItemList.SetEnableDrag(true);

	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pContainer = (CEsmContainer *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmScriptCombo(m_ScriptList);
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_WeightText.SetLimitText(16);

	/* Update the UI data */
  SetControlData();
  m_ItemList.SortItems(l_ContSortCallBack, ESM_FIELD_COUNT);
 }
/*===========================================================================
 *		End of Class Event CEsmContainDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Event - void OnOrganiccheck ();
 *
 *=========================================================================*/
void CEsmContainDlg::OnOrganiccheck() {
  m_RespawnCheck.EnableWindow(m_OrganicCheck.GetCheck());
  m_Modified = true;
 }
/*===========================================================================
 *		End of Class Event CEsmContainDlg::OnOrganiccheck()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Event - LRESULT OnRecordDrop (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmContainDlg::OnRecordDrop (LPARAM lParam, LPARAM wParam) {
  CString	Buffer;
  CMWEditDoc*   pSourceDoc = (CMWEditDoc *) lParam;
  esmrecinfo_t* pRecInfo = (esmrecinfo_t *) wParam;
  int		ListIndex;
  int		Count;

	/* Ensure we only drag from the current document */
  if (pSourceDoc != GetDocument()) return (0);
  
	/* Only accept certain types */
  if (!IsESMRecordCarryable(pRecInfo->pRecord->GetType())) return (0);
  ListIndex = m_ItemList.FindRecord(pRecInfo);

	/* Add a new item to the container */
  if (ListIndex < 0) {
    pRecInfo->UserData = 1;
    ListIndex = m_ItemList.AddItem(pRecInfo);
    m_ItemList.SetItemText(ListIndex, 0, _T("1"));	/* Default 1 item */
   }
	/* Update an existing item in the container */
  else {
    Buffer = m_ItemList.GetItemText(ListIndex, 0);
    Count = atoi(Buffer);
    Buffer.Format(_T("%d"), (Count < 0) ? --Count : ++Count);
    m_ItemList.SetItemText(ListIndex, 0,  Buffer);
    pRecInfo->UserData = Count;
   }

  UpdateTotalWeight();
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmContainDlg::OnRecordDrop()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Event - LRESULT  OnRecordKey (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmContainDlg::OnRecordKey (LPARAM lParam, LPARAM wParam) {
  CString	Buffer;
  int		ListIndex;
  int		AddCount;
  int		ItemCount;
    
	/* Update all selected items */
  if (lParam == VK_SUBTRACT || lParam == VK_ADD) {
    AddCount = (lParam == VK_ADD) ? 1 : -1;
    ListIndex = m_ItemList.GetNextItem(-1, LVNI_SELECTED);

    while (ListIndex >= 0) {
      Buffer = m_ItemList.GetItemText(ListIndex, 0);
      ItemCount = atoi(Buffer);

      Buffer.Format(_T("%d"), ItemCount + AddCount);
      m_ItemList.SetItemText(ListIndex, 0, Buffer);
      ListIndex = m_ItemList.GetNextItem(ListIndex, LVNI_SELECTED);
     }
  
    UpdateTotalWeight();
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
 *		End of Class Event CEsmContainDlg::OnRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Event - LRESULT OnRecordSort (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmContainDlg::OnRecordSort (LPARAM lParam, LPARAM wParam) {
  esmlistsortdata_t* pSortData = (esmlistsortdata_t *) lParam;

  UpdateUserData();
  m_ItemList.SortItems(l_ContSortCallBack, pSortData->iField | (pSortData->Reverse << 16));

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmContainDlg::OnRecordSort()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmContainDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  int     Index;

	/* Update an item inside the container */
  Index = m_ItemList.FindRecord(pRecInfo);

  if (Index >= 0) {
    m_ItemList.UpdateItem(Index);
    UpdateTotalWeight();
   }

	/* Refill the script list if required */
  if (pRecInfo->pRecord->IsType(MWESM_REC_SCRI)) {
    esmrecinfo_t* pRecInfo = NULL;
    int	  	  Index;

    Index = m_ScriptList.GetCurSel();
    if (Index >= 0) pRecInfo = (esmrecinfo_t *) m_ScriptList.GetItemData(Index);
    FillEsmScriptCombo(m_ScriptList);
    FindComboListItem(m_ScriptList, (DWORD) pRecInfo, true);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmContainDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmContainDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pContainer == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pContainer->GetID());
  UpdateTitle(m_pContainer->GetID());

	/* Item strings and values */
  m_NameText.SetWindowText(m_pContainer->GetName());
  m_NameText.SetModify(FALSE);
  m_WeightText.SetWindowText(m_pContainer->GetFieldString(ESM_FIELD_WEIGHT));
  m_WeightText.SetModify(FALSE);
  
	/* Model/icon buttons */
  m_ModelButton.SetWindowText(m_pContainer->GetModel());
  
	/* Item lists */
  m_ScriptList.SelectString(-1, m_pContainer->GetScript());

	/* Record flags */
  m_BlockedCheck.SetCheck(m_pContainer->IsBlocked());
  m_PersistCheck.SetCheck(m_pContainer->IsPersist());
  m_RespawnCheck.SetCheck(m_pContainer->IsRespawn());
  m_OrganicCheck.SetCheck(m_pContainer->IsOrganic());

  m_RespawnCheck.EnableWindow(m_pContainer->IsOrganic());

  SetItemData();
 }
/*===========================================================================
 *		End of Class Method CEsmContainDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Method - void SetItemData (void);
 *
 *=========================================================================*/
void CEsmContainDlg::SetItemData (void) {
  CEsmSubNPCO*  pItemSubRec;
  esmrecinfo_t* pRecInfo;
  CString	Buffer;
  int		ArrayIndex;
  int		ListIndex;

  pItemSubRec = (CEsmSubNPCO *) m_pContainer->FindFirst(MWESM_SUBREC_NPCO, ArrayIndex);

  while (pItemSubRec != NULL) {
    pRecInfo = GetDocument()->FindRecord(pItemSubRec->GetItem());

    if (pRecInfo != NULL) {
      ListIndex = m_ItemList.AddItem(pRecInfo);
      pRecInfo->UserData = pItemSubRec->GetCount();
      Buffer.Format(_T("%d"), pItemSubRec->GetCount());
      m_ItemList.SetItemText(ListIndex, 0, Buffer);
     }

    pItemSubRec = (CEsmSubNPCO *) m_pContainer->FindNext(MWESM_SUBREC_NPCO, ArrayIndex);
   }
  
  UpdateTotalWeight();
 }
/*===========================================================================
 *		End of Class Method CEsmContainDlg::SetItemData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Method - void UpdateTotalWeight (void);
 *
 *=========================================================================*/
void CEsmContainDlg::UpdateTotalWeight (void) {
  esmrecinfo_t* pRecInfo;
  CString	Buffer;
  int		Index;
  float		Total = 0;

  for (Index = 0; Index < m_ItemList.GetItemCount(); Index++) {
    pRecInfo = (esmrecinfo_t*) m_ItemList.GetItemData(Index);
    Total += (float)atof(pRecInfo->pRecord->GetFieldString(ESM_FIELD_WEIGHT)) * abs(pRecInfo->UserData);
   }

  Buffer.Format(_T("%.2f"), Total);
  m_WeightLabel.SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmContainDlg::UpdateTotalWeight()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmContainDlg Method - void UpdateUserData (void);
 *
 * Updates the user data in the recinfo pointers to match the current item
 * count for sorting.
 *
 *=========================================================================*/
void CEsmContainDlg::UpdateUserData (void) {
  CString	Buffer;
  esmrecinfo_t* pRecInfo;
  int		Index;
  int		Count;

	/* Loop over all items in the list */
  for (Index = 0; Index < m_ItemList.GetItemCount(); Index++) {
    Buffer   = m_ItemList.GetItemText(Index, 0);
    Count    = atoi(Buffer);
    pRecInfo = (esmrecinfo_t *) m_ItemList.GetItemData(Index);
    
    pRecInfo->UserData = Count;    	
   }

 }
/*===========================================================================
 *		End of Class Method CEsmContainDlg::UpdateUserData()
 *=========================================================================*/
