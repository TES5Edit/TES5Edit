/*===========================================================================
 *
 * File:	Esmlistctrl.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 5, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmSubListCtrl.h"
#include "Resource.h"


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



  IMPLEMENT_DYNCREATE(CEsmSubListCtrl, CEsmListCtrl);
  DEFINE_FILE("EsmSubListCtrl.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Default List Sort Functions
 *
 *=========================================================================*/
int CALLBACK l_ItemSubSortCallBack (LPARAM lParam1, LPARAM lParam2, LPARAM lParamSort) {
  CEsmSubCellRef* pCellRef1 = (CEsmSubCellRef*) lParam1;
  CEsmSubCellRef* pCellRef2 = (CEsmSubCellRef*) lParam2;
  int	          SortType = lParamSort & 0xFFFF;
  int	          Flags    = lParamSort >> 16;
  int	          Result;
  
  if (SortType == ESMSUBLIST_FIELD_MOD) {
    Result = (int)pCellRef2->IsActive() - (int) pCellRef1->IsActive() + 10*((int)pCellRef2->IsDeleted() - (int)pCellRef1->IsDeleted());
   }
  else {
    if (pCellRef1->GetRecInfo() == NULL || pCellRef2->GetRecInfo() == NULL) return (0);  
    Result = pCellRef1->GetRecInfo()->pRecord->CompareFields(SortType, pCellRef2->GetRecInfo()->pRecord);
   }
 
  if (Flags) return (-Result);
  return (Result);  
 }
/*===========================================================================
 *		End of Default List Sort Functions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmSubListCtrl Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmSubListCtrl, CEsmListCtrl)
  //{{AFX_MSG_MAP(CEsmSubListCtrl)
  ON_NOTIFY_REFLECT(LVN_COLUMNCLICK, OnColumnclick)
  ON_NOTIFY_REFLECT(LVN_BEGINDRAG, OnBeginDrag)
  ON_NOTIFY_REFLECT(NM_CUSTOMDRAW, OnCustomdraw )
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmSubListCtrl Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSubListCtrl Constructor
 *
 *=========================================================================*/
CEsmSubListCtrl::CEsmSubListCtrl() {
 }
/*===========================================================================
 *		End of Class CEsmSubListCtrl Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSubListCtrl Destructor
 *
 *=========================================================================*/
CEsmSubListCtrl::~CEsmSubListCtrl() {
 }
/*===========================================================================
 *		End of Class CEsmSubListCtrl Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSubListCtrl Method - int AddItem (pCellRef);
 *
 *=========================================================================*/
int CEsmSubListCtrl::AddItem (CEsmSubCellRef* pCellRef) {
  esmrecinfo_t*   pRecInfo;
  CEsmSubNameFix* pName;
  int		  ListIndex;
  int		  ImageIndex;
  
	/* Find an existing reference in the list (no duplicates) */
  ListIndex = FindCellRef(pCellRef);
  if (ListIndex >= 0) return (ListIndex);

	/* Initialize the record info */
  if (pCellRef != NULL && pCellRef->GetRecInfo() == NULL) {
    pName = (CEsmSubNameFix *) pCellRef->FindSubRecord(MWESM_SUBREC_NAME);

    if (pName != NULL) {
      pRecInfo = m_pEsmDlgHandler->GetDocument()->FindRecord(pName->GetName());
      pCellRef->SetRecInfo(pRecInfo);
     }
   
   }

  if (pCellRef->GetRecInfo() == NULL)
    ImageIndex = -1;
  else
    ImageIndex = GetImageIndex(pCellRef->GetRecInfo()->pRecord);
  
	/* Add the item to the end of the list */
  ListIndex = InsertItem(GetItemCount(), "", ImageIndex);
  if (ListIndex < 0) return (ListIndex);

	/* Set the item data */
  SetItemData(ListIndex, (DWORD) pCellRef);
  SetItem(ListIndex, pCellRef);

  return (ListIndex);
 }
/*===========================================================================
 *		End of Class Method CEsmSubListCtrl::AddItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSubListCtrl Method - int FindCellRef (pCellRef);
 *
 * Finds the given cell reference in the list.  Returns -1 if the
 * reference is not found.
 *
 *=========================================================================*/
int CEsmSubListCtrl::FindCellRef (CEsmSubCellRef* pCellRef) {
  CEsmSubCellRef* pCellRef1;
  int		  Index;

  for (Index = 0; Index < GetItemCount(); Index++) {
    pCellRef1 = (CEsmSubCellRef *) GetItemData(Index);

    if (pCellRef1->IsSame(pCellRef)) {
      CEsmSubFRMR* pLong = (CEsmSubFRMR *) pCellRef->FindSubRecord(MWESM_SUBREC_FRMR);
      SystemLog.Printf ("Found Same, %d", pLong->GetValue());
      return (Index);
     }
   }

	/* Not found */
  return (-1);
 }
/*===========================================================================
 *		End of Class Method CEsmSubListCtrl::FindCellRef()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSubListCtrl Method - esmrecinfo_t* GetRecInfo (Item);
 *
 *=========================================================================*/
esmrecinfo_t* CEsmSubListCtrl::GetRecInfo (const int Item) {
  if (Item < 0 || Item >= GetItemCount()) return (NULL);
  CEsmSubCellRef* pCellRef = (CEsmSubCellRef *) GetItemData(Item);
  if (pCellRef == NULL) return (NULL);
  return (pCellRef->GetRecInfo());
 }
/*===========================================================================
 *		End of Class Method CEsmSubListCtrl::GetRecInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSubListCtrl Event - void OnBeginDrag (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmSubListCtrl::OnBeginDrag (NMHDR* pNMHDR, LRESULT* pResult) {
  DEFINE_FUNCTION("CEsmSubListCtrl::OnBeginDrag()");
  NM_LISTVIEW*	  pNMListView = (NM_LISTVIEW*)pNMHDR;
  CEsmSubCellRef* pCellRef;
  CEsmSubName*    pRefName; 
  esmrecinfo_t*   pRecInfo;
  LVITEM	  ItemInfo;
  POINT		  DragPoint;
  BOOL		  Result;
  BYTE*		  pArray;
  POSITION	  SelPos;
  int		  Offset = 10;
  int		  ListIndex;
  int		  Index;
  *pResult = 0;

	/* Ignore if the dragging is disabled for the list */
  if (!m_EnableDrag) return;
  if (m_ActNormalList) return;

	/* Copy the records we wish to drag */
  CreateArrayPointer(pArray, byte, sizeof(esmrecinfo_t*)*GetSelectedCount());
  m_ppDragRecords = (esmrecinfo_t**) pArray;
  SelPos = GetFirstSelectedItemPosition();
  m_NumDragRecords = 0;
  Index = 0;

  while (SelPos != NULL) {
    ListIndex = GetNextSelectedItem(SelPos);
    pCellRef = (CEsmSubCellRef *) GetItemData(ListIndex);
    pRefName = (CEsmSubName *) pCellRef->FindSubRecord(MWESM_SUBREC_NAME);

		/* Ensure the cell reference object is valid */
    if (pRefName == NULL) continue;
    pRecInfo = m_pEsmDlgHandler->GetDocument()->FindRecord(pRefName->GetName());
    if (pRecInfo == NULL) continue;

    m_ppDragRecords[Index] = pRecInfo;
    m_NumDragRecords++;
    Index++;
   }

	/* Setup the dragging members */
  m_DragIndex  = pNMListView->iItem;
  m_IsDragging = true;
  DragPoint.x  = Offset;
  DragPoint.y  = Offset;
  m_DropIndex  = 0;
  m_pDropWnd   = this;
  m_pDropList  = NULL;
  
	/* Create the image for dragging */
  ItemInfo.mask     = LVIF_IMAGE;
  ItemInfo.iItem    = pNMListView->iItem;
  ItemInfo.iSubItem = 0;
  Result = CListCtrl::GetItem(&ItemInfo);

  m_hGoodDropCursor = GetCursor();
  SetCursor(m_hBadDropCursor);

  if (Result) {
    m_pDragImage = new CImageList();
    m_pDragImage->Create(&m_ImageList);
    m_pDragImage->Copy(0, ItemInfo.iImage, ILCF_MOVE);
   }
  else {
    m_pDragImage = CreateDragImage(m_DragIndex, &DragPoint);
   }

  ASSERT(m_pDragImage);

	/* Change the cursor to the drag image
	  (still must perform DragMove() in OnMouseMove() to show it moving) */
  m_pDragImage->BeginDrag(0, CPoint(Offset, Offset));
  m_pDragImage->DragEnter(GetDesktopWindow(), pNMListView->ptAction);

	/* Cause this control to capture all the mouse messages */
  SetCapture();
 }
/*===========================================================================
 *		End of Class Event CEsmSubListCtrl::OnBeginDrag()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSubListCtrl Event - void OnColumnclick (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmSubListCtrl::OnColumnclick (NMHDR* pNMHDR, LRESULT* pResult) {
  NM_LISTVIEW* pNMListView = (NM_LISTVIEW*)pNMHDR;
  int		Data;
  *pResult = 0;

	/* Ensure we have a proper object state */
  if (m_pCurrentColData == NULL) return;

	/* Get the type of field to sort by */
  Data = m_pCurrentColData[pNMListView->iSubItem].FieldType;

	/* Initialize the sorting options */
  if (m_LastSortSubItem == Data) {
    m_SortReverse = !m_SortReverse;
    Data |= m_SortReverse ? 0x010000 : 0x0000;
   }
  else {
    m_LastSortSubItem = Data;
    m_SortReverse     = false;
   }

	/* Call using custom or default sort callback */
  if (m_pCurrentColData->SortFunc != NULL)
    SortItems(m_pCurrentColData->SortFunc, Data);
  else
    SortItems(l_ItemSubSortCallBack, Data);
   
 }
/*===========================================================================
 *		End of Class Event CEsmSubListCtrl::OnColumnclick()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSubListCtrl Event - void OnCustomdraw (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmSubListCtrl::OnCustomdraw (NMHDR* pNMHDR, LRESULT* pResult) {
  NMLVCUSTOMDRAW* pLVCD = reinterpret_cast<NMLVCUSTOMDRAW*>( pNMHDR );
  
	/* Take the default processing unless we set this to something else below. */
  *pResult = CDRF_DODEFAULT; 

	/* First thing - check the draw stage. If it's the control's prepaint
	 * stage, then tell Windows we want messages for every item. */
  if ( CDDS_PREPAINT == pLVCD->nmcd.dwDrawStage ) {
    *pResult = CDRF_NOTIFYITEMDRAW;
   }
        /* This is the prepaint stage for an item. Here's where we set the
           item's text/back color. */
  else if ( CDDS_ITEMPREPAINT == pLVCD->nmcd.dwDrawStage ) {
    CEsmSubCellRef* pCellRef;

    pCellRef = (CEsmSubCellRef *) GetItemData(pLVCD->nmcd.dwItemSpec);

    if (pCellRef != NULL) {
      if (pCellRef->IsDeleted()) 
        pLVCD->clrTextBk = m_DeleteColor;
      else if (pCellRef->IsActive()) 
        pLVCD->clrTextBk = m_ActiveColor;
     }

		// Tell Windows to paint the control itself.
    *pResult = CDRF_DODEFAULT;
   }

 }
/*===========================================================================
 *		End of Class Event CEsmSubListCtrl::OnCustomdraw()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSubListCtrl Method - void SetItem (ListIndex, pCellRef);
 *
 *=========================================================================*/
void CEsmSubListCtrl::SetItem (const int ListIndex, CEsmSubCellRef* pCellRef) {
  CEsmRecord*	pRecord;
  int		ColIndex;
  bool		ClearFields = false;

  if (pCellRef->GetRecInfo() == NULL) return;
  pRecord = pCellRef->GetRecInfo()->pRecord;

  for (ColIndex = 0; m_pCurrentColData[ColIndex].pName != NULL; ColIndex++) {

    if ((m_pCurrentColData[ColIndex].FieldType & ESMSUBLIST_FIELD_MASK) != 0) {
      SetItemText(ListIndex, m_ColSubItems[m_pCurrentColData[ColIndex].SubItem], pCellRef->GetFieldString(m_pCurrentColData[ColIndex].FieldType));
     }
    else if (m_pCurrentColData[ColIndex].SubItem != ESM_FIELD_CUSTOM) {

      if (!ClearFields) {
        SetItemText(ListIndex, m_ColSubItems[m_pCurrentColData[ColIndex].SubItem], 
			pRecord->GetFieldString(m_pCurrentColData[ColIndex].FieldType));
        if (m_pCurrentColData[ColIndex].SubItem == ESM_FIELD_CHANGED && pRecord->IsDeleted()) ClearFields = true; 
       }
      else {
        SetItemText(ListIndex, m_ColSubItems[m_pCurrentColData[ColIndex].SubItem], _T(""));
       }
     }
   }

 }
/*===========================================================================
 *		End of Class Method CEsmSubListCtrl::SetItem()
 *=========================================================================*/
