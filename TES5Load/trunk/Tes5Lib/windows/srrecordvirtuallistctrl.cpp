/*===========================================================================
 *
 * File:		Srrecordvirtuallistctrl.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "srrecordvirtuallistctrl.h"


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

  IMPLEMENT_DYNCREATE(CSrRecordVirtualListCtrl, CSrRecordListCtrl);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecordVirtualListCtrl Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CSrRecordVirtualListCtrl, CSrRecordListCtrl)
	//{{AFX_MSG_MAP(CSrRecordVirtualListCtrl)
	ON_NOTIFY_REFLECT(LVN_GETDISPINFO, OnGetDispInfo)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CSrRecordVirtualListCtrl Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int CALLBACK s_DefaultVirtualRecListSort (lParam1, lParam2, lParamSort);
 *
 *=========================================================================*/
int CALLBACK s_DefaultVirtualRecListSort (LPARAM lParam1, LPARAM lParam2, LPARAM lParamSort) {
  SRRL_SORTFUNC_GETPARAMS(lParam1, lParam2, lParamSort);
  
  if (pSortData->Reverse) return -pRecord1->CompareFields(pSortData->FieldID, pRecord2);
  return pRecord1->CompareFields(pSortData->FieldID, pRecord2);
}
/*===========================================================================
 *		End of Function CALLBACK s_DefaultVirtualRecListSort()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordVirtualListCtrl Constructor
 *
 *=========================================================================*/
CSrRecordVirtualListCtrl::CSrRecordVirtualListCtrl () {

 }
/*===========================================================================
 *		End of Class CSrRecordVirtualListCtrl Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordVirtualListCtrl Destructor
 *
 *=========================================================================*/
CSrRecordVirtualListCtrl::~CSrRecordVirtualListCtrl () {
}
/*===========================================================================
 *		End of Class CSrRecordVirtualListCtrl Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordVirtualListCtrl Method - int AddCustomRecord (CustomData);
 *
 *=========================================================================*/
int CSrRecordVirtualListCtrl::AddCustomRecord (srrlcustomdata_t& CustomData) {
  int ListIndex;

  if (CustomData.pRecord == NULL) return (-1);
  ListIndex = m_Records.GetSize();

  m_Records.Add(CustomData.pRecord);

  SetItemCount(ListIndex + 1);
  return (ListIndex);
}
/*===========================================================================
 *		End of Class Method CSrRecordVirtualListCtrl::AddCustomRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordVirtualListCtrl Method - void DefaultSettings (void);
 *
 *=========================================================================*/
void CSrRecordVirtualListCtrl::DefaultSettings (void) {
  CSrRecordListCtrl::DefaultSettings();
}
/*===========================================================================
 *		End of Class Method CSrRecordVirtualListCtrl::DefaultSettings()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordVirtualListCtrl Method - BOOL DeleteAllItems (void);
 *
 *=========================================================================*/
BOOL CSrRecordVirtualListCtrl::DeleteAllItems (void) {
  m_Records.Destroy();
    
  return CSrRecordListCtrl::DeleteAllItems();
 }
/*===========================================================================
 *		End of Class Method CSrRecordVirtualListCtrl::DeleteAllItems()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordVirtualListCtrl Method - int FindEditorID (pString);
 *
 *=========================================================================*/
int CSrRecordVirtualListCtrl::FindEditorID (const SSCHAR* pString) {
  CSString Buffer;
  dword    Index;
  bool     Result;
  int      LastMatch = -1;
  int      LastMatchCount = 0;
  int	   Matching;

  for (Index = 0; Index < m_Records.GetSize(); ++Index) {
    Result = m_Records[Index]->GetField(Buffer, SR_FIELD_EDITORID);
    if (!Result) continue;

    Matching = Buffer.CountMatchLengthNoCase(pString);

    if (Matching > LastMatchCount) {
      LastMatchCount = Matching;
      LastMatch      = Index;
    }
  } 

  return (LastMatch);
}
/*===========================================================================
 *		End of Class Method CSrRecordVirtualListCtrl::FindEditorID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordVirtualListCtrl Method - bool FindRecord (pRecord);
 *
 * Finds the given record in the current list. Returns the list index or
 * -1 if not found.
 *
 *=========================================================================*/
int CSrRecordVirtualListCtrl::FindRecord (CSrRecord* pRecord) {
  if (pRecord == NULL) return (-1);
  return m_Records.Find(pRecord);
}
/*===========================================================================
 *		End of Class Method CSrRecordVirtualListCtrl::FindRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordVirtualListCtrl Method - CSrRecord* GetRecord (ListIndex);
 *
 *=========================================================================*/
CSrRecord* CSrRecordVirtualListCtrl::GetRecord (const int ListIndex) {
  CSrBaseRecord* pBaseRecord = m_Records.GetAt(ListIndex);
  if (pBaseRecord == NULL) return (NULL);
  return SrCastClass(CSrRecord, pBaseRecord); 
}
/*===========================================================================
 *		End of Class Method CSrRecordVirtualListCtrl::GetRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordVirtualListCtrl Event - void OnGetDispInfo (pNMHDR, pResult);
 *
 *=========================================================================*/
void CSrRecordVirtualListCtrl::OnGetDispInfo (NMHDR* pNMHDR, LRESULT* pResult) {
  CSrBaseRecord* pBaseRecord;
  CSrRecord*     pRecord;
  LV_DISPINFO*   pDispInfo = (LV_DISPINFO *)pNMHDR;
  LV_ITEM*       pItem     = &(pDispInfo)->item;
  int	         ItemIndex = pItem->iItem;

  if (m_pCurrentList == NULL) return;

  pBaseRecord = m_Records.GetAt(ItemIndex);
  if (pBaseRecord == NULL) return;
  pRecord = SrCastClass(CSrRecord, pBaseRecord);
  if (pRecord == NULL) return;

  if (pItem->mask & LVIF_TEXT) {
    CSString       Buffer;
    srrecfieldid_t FieldID;
    bool           Result;

    if (pItem->iSubItem < 0 || pItem->iSubItem >= (int) m_pCurrentList->NumColumns) return;

    FieldID = m_pCurrentList->Columns[pItem->iSubItem].FieldID;
    Result = pRecord->GetField(Buffer, FieldID);
    if (Result) lstrcpyn(pItem->pszText, Buffer, pItem->cchTextMax);
  }

  *pResult = 0;
 }
/*===========================================================================
 *		End of Class Event CSrRecordVirtualListCtrl::OnGetDispInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordVirtualListCtrl Method - void SortListPriv (FieldID);
 *
 *=========================================================================*/
void CSrRecordVirtualListCtrl::SortListPriv (const srrecfieldid_t FieldID) {
  srreclistsort_t    SortData;
  srreclistcolumn_t* pColumn;

  if (m_pCurrentList == NULL) return;
  pColumn = FindListColumn(m_pCurrentList, FieldID);

  SortData.FieldID  = m_pCurrentList->SortField;
  SortData.SubItem  = m_pCurrentList->SortSubItem;
  SortData.Reverse  = m_pCurrentList->SortReverse;
  SortData.ListType = m_pCurrentList->Type;

  if (pColumn == NULL || pColumn->CompareFunc == NULL) {

    if (m_pCurrentList->Type == SR_RECORDLIST_CUSTOM) 
      return;
    else
      m_Records.Sort(s_DefaultVirtualRecListSort, (DWORD) (void *) &SortData);
   }
  else
    m_Records.Sort(pColumn->CompareFunc, (DWORD) (void *) &SortData);


  this->RedrawWindow();
  //m_Records.Sort(s_DefaultVirtualRecListSort, );
}
/*===========================================================================
 *		End of Class Method CSrRecordVirtualListCtrl::SortListPriv()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordVirtualListCtrl Method - int UpdateRecord (pNewRecord, pOldRecord);
 *
 * Updates an existing record or adds a new one. Returns the updated list
 * index or -1 on any error.
 *
 *=========================================================================*/
int CSrRecordVirtualListCtrl::UpdateRecord (CSrRecord* pNewRecord, CSrRecord* pOldRecord) {
  int ListIndex;

  ListIndex = FindRecord(pOldRecord);

  if (ListIndex < 0) {
    if (m_pCurrentFilter != NULL && !m_pCurrentFilter->CheckRecord(pNewRecord, m_ExtraFilter)) return (-1);
    return AddRecord(pNewRecord);
  }

  if (pNewRecord == NULL) {
    m_Records.Delete(ListIndex);
    SetItemCount(m_Records.GetSize());

    RedrawItems(ListIndex, ListIndex + GetCountPerPage());
    UpdateWindow();

    return (-1);
  }
  
  m_Records.SetAt(ListIndex, pNewRecord);

  RedrawItems(ListIndex, ListIndex);
  UpdateWindow();

  return (ListIndex);
}
/*===========================================================================
 *		End of Class Method CSrRecordVirtualListCtrl::UpdateRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordVirtualListCtrl Method - bool RemoveItem (ListIndex);
 *
 *=========================================================================*/
bool CSrRecordVirtualListCtrl::RemoveItem (const int ListIndex) {
  bool Result;

  Result = m_Records.Delete(ListIndex);
  if (!Result) return (false);

  SetItemCount(m_Records.GetSize());

  RedrawItems(ListIndex, ListIndex + GetCountPerPage());
  UpdateWindow();

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecordVirtualListCtrl::RemoveItem()
 *=========================================================================*/

