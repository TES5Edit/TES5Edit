/*===========================================================================
 *
 * File:	Esmcreaturepage3.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	March 1, 2003
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
#include "EsmCreaturePage3.h"
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

  IMPLEMENT_DYNCREATE(CEsmCreaturePage3, CPropertyPage);
  DEFINE_FILE("EsmCreaturePage3.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int CALLBACK l_CreaItemSortCallBack (lParam1, lParam2, lParamSort);
 *
 *=========================================================================*/
int CALLBACK l_CreaItemSortCallBack (LPARAM lParam1, LPARAM lParam2, LPARAM lParamSort) {
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
 *		End of Function CALLBACK l_CreaItemSortCallBack()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Item List Display Data Array
 *
 *=========================================================================*/
static esmcoldata_t l_ItemColData[] = {
	{  _T("Count"),		ESM_FIELD_CUSTOM,	LVCFMT_CENTER,	ESMLIST_WIDTH_COUNT+20,	ESMLIST_SUBITEM_COUNT, l_CreaItemSortCallBack }, 
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
 * Begin CEsmCreaturePage3 Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmCreaturePage3, CPropertyPage)
  //{{AFX_MSG_MAP(CEsmCreaturePage3)
  ON_MESSAGE(ESMLIST_NOTIFY_ONDROP, OnRecordDrop)
  ON_MESSAGE(ESMLIST_NOTIFY_ONKEY, OnRecordKey)
  ON_MESSAGE(ESMLIST_NOTIFY_ONSORT, OnRecordSort)
  ON_NOTIFY(LVN_ENDLABELEDIT, IDC_ITEMLIST, OnEndlabeleditItemlist)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmCreaturePage3 Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage3 Constructor
 *
 *=========================================================================*/
CEsmCreaturePage3::CEsmCreaturePage3() : CPropertyPage(CEsmCreaturePage3::IDD) {
  //{{AFX_DATA_INIT(CEsmCreaturePage3)
  //}}AFX_DATA_INIT
  m_pRecInfo    = NULL;
  m_pDlgHandler = NULL;
 }
/*===========================================================================
 *		End of Class CEsmCreaturePage3 Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage3 Destructor
 *
 *=========================================================================*/
CEsmCreaturePage3::~CEsmCreaturePage3() {
 }
/*===========================================================================
 *		End of Class CEsmCreaturePage3 Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage3 Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmCreaturePage3::DoDataExchange(CDataExchange* pDX) {
  CPropertyPage::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmCreaturePage3)
  DDX_Control(pDX, IDC_ENCUMLABEL, m_WeightLabel);
  DDX_Control(pDX, IDC_ITEMLIST, m_ItemList);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmCreaturePage3::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage3 Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmCreaturePage3::GetControlData (void) {
  CEsmCreature*   pCreature;
  CEsmSubNPCO*    pItemName;
  esmrecinfo_t*   pRecInfo;
  CString	  Buffer;
  int		  ListIndex;
  
  if (m_pRecInfo == NULL || m_pDlgHandler == NULL) return;
  pCreature = (CEsmCreature *) m_pRecInfo->pRecord;

	/* Delete all current spell records */
  pCreature->DeleteSubRecords(MWESM_SUBREC_NPCO);

	/* Add all the new spell ID records */
  for (ListIndex = 0; ListIndex < m_ItemList.GetItemCount(); ListIndex++) {
    pRecInfo = m_ItemList.GetRecInfo(ListIndex);
    pItemName = (CEsmSubNPCO *) pCreature->AllocateSubRecord(MWESM_SUBREC_NPCO);
    pItemName->CreateNew();
    pItemName->SetItem(pRecInfo->pRecord->GetID());
    Buffer = m_ItemList.GetItemText(ListIndex, 0);
    pItemName->SetCount(atoi(Buffer));
   }
 
 }
/*===========================================================================
 *		End of Class Method CEsmCreaturePage3::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage3 Method - CMWEditDoc* GetDocument (void);
 *
 *=========================================================================*/
CMWEditDoc* CEsmCreaturePage3::GetDocument (void) {
  DEFINE_FUNCTION("CEsmCreaturePage3::GetDocument()");
  ASSERT(m_pDlgHandler != NULL);
  return m_pDlgHandler->GetDocument();
 }
/*===========================================================================
 *		End of Class Method CEsmCreaturePage3::GetDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage3 Event - void OnEndlabeleditItemlist (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmCreaturePage3::OnEndlabeleditItemlist(NMHDR* pNMHDR, LRESULT* pResult) {
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
 *		End of Class Event CEsmCreaturePage3::OnEndlabeleditItemlist()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage3 Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmCreaturePage3::OnInitDialog() {
  CPropertyPage::OnInitDialog();

	/* Spell List */
  m_ItemList.OnInitCtrl();
  m_ItemList.SetDlgHandler(m_pDlgHandler);
  m_ItemList.SetEnableDrag(true);
  m_ItemList.SetAcceptDrag(true);
  m_ItemList.SetWantKeys(true);
  m_ItemList.InitObjectList(&l_ItemColData[0]);
	
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmCreaturePage3::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage3 Event - LRESULT OnRecordDrop (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmCreaturePage3::OnRecordDrop (LPARAM lParam, LPARAM wParam) {
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
 *		End of Class Event CEsmCreaturePage3::OnRecordDrop()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage3 Event - LRESULT OnRecordKey (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmCreaturePage3::OnRecordKey (LPARAM lParam, LPARAM wParam) {
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
 *		End of Class Event CEsmCreaturePage3::OnRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage3 Event - LRESULT OnRecordSort (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmCreaturePage3::OnRecordSort (LPARAM lParam, LPARAM wParam) {
  esmlistsortdata_t* pSortData = (esmlistsortdata_t *) lParam;

  UpdateUserData();
  m_ItemList.SortItems(l_CreaItemSortCallBack, pSortData->iField | (pSortData->Reverse << 16));

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmCreaturePage3::OnRecordSort()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage3 Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmCreaturePage3::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  m_ItemList.UpdateItem(pRecInfo);
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmCreaturePage3::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage3 Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmCreaturePage3::SetControlData (void) {
  CEsmCreature*   pCreature;
  CEsmSubNPCO*    pItemName;
  esmrecinfo_t*   pRecInfo;
  CString	  Buffer;
  int		  ArrayIndex;
  int		  ListIndex;
  
  if (m_pRecInfo == NULL || m_pDlgHandler == NULL) return;
  m_ItemList.SetDlgHandler(m_pDlgHandler);
  pCreature = (CEsmCreature *) m_pRecInfo->pRecord;

  pItemName = (CEsmSubNPCO *) pCreature->FindFirst(MWESM_SUBREC_NPCO, ArrayIndex);

  while (pItemName != NULL) {
    pRecInfo = GetDocument()->FindRecord(pItemName->GetItem());

    if (pRecInfo != NULL) {
      ListIndex = m_ItemList.AddItem(pRecInfo);
      Buffer.Format(_T("%d"), pItemName->GetCount());
      m_ItemList.SetItemText(ListIndex, 0, Buffer);
     }

    pItemName = (CEsmSubNPCO *) pCreature->FindNext(MWESM_SUBREC_NPCO, ArrayIndex);
   }

  UpdateUserData();
  UpdateTotalWeight();
 }
/*===========================================================================
 *		End of Class Method CEsmCreaturePage3::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage3 Method - void UpdateTotalWeight (void);
 *
 *=========================================================================*/
void CEsmCreaturePage3::UpdateTotalWeight (void) {
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

  Buffer.Format(_T("Encumberance: %.2f lbs"), Total);
  m_WeightLabel.SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmCreaturePage3::UpdateTotalWeight()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage3 Method - void UpdateUserData (void);
 *
 * Updates the user data in the recinfo pointers to match the current item
 * count for sorting.
 *
 *=========================================================================*/
void CEsmCreaturePage3::UpdateUserData (void) {
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
 *		End of Class Method CEsmCreaturePage3::UpdateUserData()
 *=========================================================================*/
