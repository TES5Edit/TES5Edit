/*===========================================================================
 *
 * File:	Esmnpcpage3.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 25, 2003
 *
 * Description
 *
 * 14 September 2003
 *	- Properly implemented the item count mechanism. The item count is
 *	  now held only in the actual list. The RecInfo->UserData member is
 *	  only updated just before a sort.
 *	- Added the ability to increment/decrement item counts using the
 *	  +/- key.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmNpcPage3.h"
#include "dl_Err.h"
#include "MWEditDoc.h"
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

  IMPLEMENT_DYNCREATE(CEsmNpcPage3, CPropertyPage);
  DEFINE_FILE("EsmNpcPage3.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int CALLBACK l_ContSortCallBack (lParam1, lParam2, lParamSort);
 *
 *=========================================================================*/
int CALLBACK l_NPCItemSortCallBack (LPARAM lParam1, LPARAM lParam2, LPARAM lParamSort) {
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
	{  _T("Count"),		ESM_FIELD_CUSTOM,	LVCFMT_CENTER,	ESMLIST_WIDTH_COUNT+20,	ESMLIST_SUBITEM_COUNT, l_NPCItemSortCallBack }, 
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
 * Begin CEsmNpcPage3 Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmNpcPage3, CPropertyPage)
  //{{AFX_MSG_MAP(CEsmNpcPage3)
  ON_MESSAGE(ESMLIST_NOTIFY_ONDROP, OnRecordDrop)
  ON_MESSAGE(ESMLIST_NOTIFY_ONKEY, OnRecordKey)
  ON_NOTIFY(LVN_ENDLABELEDIT, IDC_ITEMLIST, OnEndlabeleditItemlist)
  ON_MESSAGE(ESMLIST_NOTIFY_ONSORT, OnRecordSort)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmNpcPage3 Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage3 Constructor
 *
 *=========================================================================*/
CEsmNpcPage3::CEsmNpcPage3() : CPropertyPage(CEsmNpcPage3::IDD) {
  //{{AFX_DATA_INIT(CEsmNpcPage3)
  //}}AFX_DATA_INIT
  m_pRecInfo    = NULL;
  m_pDlgHandler = NULL;
 }
/*===========================================================================
 *		End of Class CEsmNpcPage3 Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage3 Destructor
 *
 *=========================================================================*/
CEsmNpcPage3::~CEsmNpcPage3() {
 }
/*===========================================================================
 *		End of Class CEsmNpcPage3 Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage3 Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmNpcPage3::DoDataExchange(CDataExchange* pDX) {
  CPropertyPage::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmNpcPage3)
  DDX_Control(pDX, IDC_ENCUMLABEL, m_WeightLabel);
  DDX_Control(pDX, IDC_ITEMLIST, m_ItemList);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage3::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage3 Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmNpcPage3::GetControlData (void) {
  CEsmNpc*  	  pNpc;
  CEsmSubNPCO*    pItemName;
  esmrecinfo_t*   pRecInfo;
  CString	  Buffer;
  int		  ListIndex;
  
  if (m_pRecInfo == NULL || m_pDlgHandler == NULL) return;
  pNpc = (CEsmNpc *) m_pRecInfo->pRecord;

	/* Delete all current spell records */
  pNpc->DeleteSubRecords(MWESM_SUBREC_NPCO);

	/* Add all the new spell ID records */
  for (ListIndex = 0; ListIndex < m_ItemList.GetItemCount(); ListIndex++) {
    pRecInfo = m_ItemList.GetRecInfo(ListIndex);
    pItemName = (CEsmSubNPCO *) pNpc->AllocateSubRecord(MWESM_SUBREC_NPCO);
    pItemName->CreateNew();
    pItemName->SetItem(pRecInfo->pRecord->GetID());
    Buffer = m_ItemList.GetItemText(ListIndex, 0);
    pItemName->SetCount(atoi(Buffer));
   }
 
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage3::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage3 Method - CMWEditDoc* GetDocument (void);
 *
 *=========================================================================*/
CMWEditDoc* CEsmNpcPage3::GetDocument (void) {
  DEFINE_FUNCTION("CEsmNpcPage3::GetDocument()");
  ASSERT(m_pDlgHandler != NULL);
  return m_pDlgHandler->GetDocument();
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage3::GetDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage3 Event - void OnEndlabeleditItemlist (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmNpcPage3::OnEndlabeleditItemlist(NMHDR* pNMHDR, LRESULT* pResult) {
  LV_DISPINFO*	pDispInfo = (LV_DISPINFO*)pNMHDR;
  CString	Buffer;
  int		Count;

  if (pDispInfo->item.pszText != NULL) {
    Count = atoi(pDispInfo->item.pszText);
    if (Count < SHRT_MIN) Count = SHRT_MIN;
    if (Count > SHRT_MAX) Count = SHRT_MAX;
    Buffer.Format(_T("%d"), Count);
    m_ItemList.SetItemText(pDispInfo->item.iItem, 0, Buffer);
    UpdateTotalWeight();
   }

  *pResult = 0;
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage3::OnEndlabeleditItemlist()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage3 Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmNpcPage3::OnInitDialog() {
  CPropertyPage::OnInitDialog();

	/* Spell List */
  m_ItemList.OnInitCtrl();
  m_ItemList.SetDlgHandler(m_pDlgHandler);
  m_ItemList.SetEnableDrag(true);
  m_ItemList.SetAcceptDrag(true);
  m_ItemList.SetWantSortMsg(true);
  m_ItemList.SetWantKeys(true);
  m_ItemList.SetWantKeys(true);
  m_ItemList.InitObjectList(&l_ItemColData[0]);


  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage3::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage3 Event - LRESULT OnRecordDrop (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmNpcPage3::OnRecordDrop (LPARAM lParam, LPARAM wParam) {
  CString	Buffer;
  CMWEditDoc*   pSourceDoc = (CMWEditDoc *) lParam;
  esmrecinfo_t* pRecInfo = (esmrecinfo_t *) wParam;
  int		ListIndex;
  int		Count;

	/* Ensure we only drag from the current document */
  if (pSourceDoc != GetDocument()) return (0);
  
	/* Can only drag spells onto the list */
  if (!IsESMRecordCarryable(pRecInfo->pRecord->GetType())) return (0);
  ListIndex = m_ItemList.FindRecord(pRecInfo);

	/* Add a new item to the npc */
  if (ListIndex < 0) {
    ListIndex = m_ItemList.AddItem(pRecInfo);
    m_ItemList.SetItemText(ListIndex, 0, _T("1"));	/* Default 1 item */
   }
	/* Update an existing item in the npc */
  else {
    Buffer = m_ItemList.GetItemText(ListIndex, 0);
    Count = atoi(Buffer);
    Buffer.Format(_T("%d"), (Count < 0) ? --Count : ++Count);
    m_ItemList.SetItemText(ListIndex, 0,  Buffer);
   }

  UpdateTotalWeight();
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage3::OnRecordDrop()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage3 Event - LRESULT OnRecordKey (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmNpcPage3::OnRecordKey (LPARAM lParam, LPARAM wParam) {
  CString Buffer;
  int	  ListIndex;
  int	  AddCount;
  int     Count;
  
	/* Delete all currently selected items */  
  if (lParam == VK_DELETE || lParam == VK_BACK) {
    ListIndex = m_ItemList.GetNextItem(-1, LVNI_SELECTED);

    while (ListIndex >= 0) {
      m_ItemList.DeleteItem(ListIndex);
      ListIndex = m_ItemList.GetNextItem(-1, LVNI_SELECTED);
     }
  
    UpdateTotalWeight();
    return (1);
   }
	/* Update all selected items by increment/decrementing their count */
  else if (lParam == VK_ADD || lParam ==  VK_SUBTRACT) {
    AddCount = (lParam == VK_ADD) ? 1 : -1;
    ListIndex = m_ItemList.GetNextItem(-1, LVNI_SELECTED);

    while (ListIndex >= 0) {
      Buffer = m_ItemList.GetItemText(ListIndex, 0);
      Count = atoi(Buffer);

      Buffer.Format(_T("%d"), Count + AddCount);
      m_ItemList.SetItemText(ListIndex, 0, Buffer);
      ListIndex = m_ItemList.GetNextItem(ListIndex, LVNI_SELECTED);
     }
  
    return (1);
   }


  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage3::OnRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage3 Event - LRESULT OnRecordSort (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmNpcPage3::OnRecordSort (LPARAM lParam, LPARAM wParam) {
  esmlistsortdata_t* pSortData = (esmlistsortdata_t *) lParam;

  UpdateUserData();
  m_ItemList.SortItems(l_NPCItemSortCallBack, pSortData->iField | (pSortData->Reverse << 16));

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage3::OnRecordSort()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage3 Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmNpcPage3::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  m_ItemList.UpdateItem(pRecInfo);
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage3::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage3 Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmNpcPage3::SetControlData (void) {
  CEsmNpc*  	  pNpc;
  CEsmSubNPCO*    pItemName;
  esmrecinfo_t*   pRecInfo;
  CString	  Buffer;
  int		  ArrayIndex;
  int		  ListIndex;
  
  if (m_pRecInfo == NULL || m_pDlgHandler == NULL) return;
  m_ItemList.SetDlgHandler(m_pDlgHandler);
  pNpc = (CEsmNpc *) m_pRecInfo->pRecord;

  pItemName = (CEsmSubNPCO *) pNpc->FindFirst(MWESM_SUBREC_NPCO, ArrayIndex);

  while (pItemName != NULL) {
    pRecInfo = GetDocument()->FindRecord(pItemName->GetItem());
    //SystemLog.Printf ("NPC Item '%s'", pItemName->GetItem());

    if (pRecInfo != NULL) {
      ListIndex = m_ItemList.AddItem(pRecInfo);
      Buffer.Format(_T("%d"), pItemName->GetCount());
      m_ItemList.SetItemText(ListIndex, 0, Buffer);
     }
    else {
      SystemLog.Printf ("\t\tItem '%s' not found!", pItemName->GetItem());
     }

    pItemName = (CEsmSubNPCO *) pNpc->FindNext(MWESM_SUBREC_NPCO, ArrayIndex);
   }

  UpdateTotalWeight();
  UpdateUserData();
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage3::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage3 Method - void UpdateTotalWeight (void);
 *
 *=========================================================================*/
void CEsmNpcPage3::UpdateTotalWeight (void) {
  esmrecinfo_t* pRecInfo;
  CString	Buffer;
  int		Index;
  float		Total = 0;
  float		Weight;

  for (Index = 0; Index < m_ItemList.GetItemCount(); Index++) {
    pRecInfo = (esmrecinfo_t*) m_ItemList.GetItemData(Index);
    Weight = (float)atof(pRecInfo->pRecord->GetFieldString(ESM_FIELD_WEIGHT));
    Buffer = m_ItemList.GetItemText(Index, 0);
    Total +=  Weight * abs(atoi(Buffer));
   }

  Buffer.Format(_T("Encumbreance: %.2f lbs"), Total);
  m_WeightLabel.SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage3::UpdateTotalWeight()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage3 Method - void UpdateUserData (void);
 *
 * Updates the user data in the recinfo pointers to match the current item
 * count for sorting.
 *
 *=========================================================================*/
void CEsmNpcPage3::UpdateUserData (void) {
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
 *		End of Class Method CEsmNpcPage3::UpdateUserData()
 *=========================================================================*/
