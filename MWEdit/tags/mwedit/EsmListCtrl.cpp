/*===========================================================================
 *
 * File:	Esmlistctrl.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 5, 2003
 *
 * Description
 *
 * 12 October 2003
 *	- Key event checking extended so that handled characters are
 *	  not handled twice in the next OnChar() event handler. This fixes
 *	  the bug of the selection changing in a list when using the +/- keys.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"

#if !defined(NO_ESMLIST_EDIT)
  #include "MWEdit.h"
#endif

#include "EsmListCtrl.h"

//#include "Resource.h"


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


	/* Static class member */
  CImageList CEsmListCtrl::m_ImageList;

  IMPLEMENT_DYNCREATE(CEsmListCtrl, CListCtrl);
  DEFINE_FILE("EsmListCtrl.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmListCtrl Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmListCtrl, CListCtrl)
  //{{AFX_MSG_MAP(CEsmListCtrl)
  ON_WM_GETDLGCODE()
  ON_NOTIFY_REFLECT(LVN_COLUMNCLICK, OnColumnclick)
  ON_NOTIFY_REFLECT(LVN_ITEMCHANGED, OnItemchanged)
  ON_NOTIFY_REFLECT(NM_CUSTOMDRAW, OnCustomdraw )
  ON_NOTIFY_REFLECT(NM_DBLCLK, OnDblclk)
  ON_NOTIFY_REFLECT(LVN_BEGINDRAG, OnBeginDrag)
  ON_WM_MOUSEMOVE()
  ON_WM_LBUTTONUP()
  ON_WM_CHAR()
  ON_WM_KEYDOWN()
  ON_WM_KEYUP()
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmListCtrl Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Default List Sort Functions
 *
 *=========================================================================*/
int CALLBACK l_ItemSortCallBack (LPARAM lParam1, LPARAM lParam2, LPARAM lParamSort) {
  esmrecinfo_t* pRecInfo1 = (esmrecinfo_t*) lParam1;
  esmrecinfo_t* pRecInfo2 = (esmrecinfo_t*) lParam2;
  int	        SortType = lParamSort & 0xFFFF;
  int	        Flags    = lParamSort >> 16;
  int	        Result;
    
  Result = pRecInfo1->pRecord->CompareFields(SortType, pRecInfo2->pRecord);
 
  if (Flags) return (-Result);
  return (Result);  
 }
/*===========================================================================
 *		End of Default List Sort Functions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Constructor
 *
 *=========================================================================*/
CEsmListCtrl::CEsmListCtrl() {
  m_pCurrentColData = NULL;

#if !defined(NO_ESMLIST_EDIT)
  m_pEsmDlgHandler  = NULL;
#endif

  m_LastSortSubItem = -1;
  m_SortReverse     = false;
  m_LastSelItem     = -1;
  m_WantKeys        = false;
  m_WantEditMsg     = false;
  m_ActNormalList   = false;
  m_WantSortMsg     = false;
  m_LastSortField   = -1;
  m_IgnoreCharKey   = 0;

  m_EnableDrag = false;
  m_AcceptDrag = false;
  m_DragIndex  = -1;
  m_IsDragging = false;
  m_pDragImage = NULL;
  m_pDropWnd   = NULL;
  m_pDropList  = NULL;
  m_ppDragRecords  = NULL;
  m_NumDragRecords = 0;

  m_DeleteColor = RGB(255,192,192);
  m_ActiveColor = RGB(192,255,192);
  m_hBadDropCursor = NULL;
 }
/*===========================================================================
 *		End of Class CEsmListCtrl Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Destructor
 *
 *=========================================================================*/
CEsmListCtrl::~CEsmListCtrl() {
  if (m_pDragImage != NULL) {
    delete m_pDragImage;
   }

  byte* pArray = (byte *)m_ppDragRecords;
  DestroyArrayPointer(pArray);
  m_ppDragRecords = NULL;
 }
/*===========================================================================
 *		End of Class CEsmListCtrl Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Method - int AddItem (pRecInfo);
 *
 * Add an item to the end of the list.
 *
 *=========================================================================*/
int CEsmListCtrl::AddItem (esmrecinfo_t* pRecInfo) {
  int ListIndex;
  
	/* Add the item to the end of the list */
  ListIndex = InsertItem(GetItemCount(), "",  GetImageIndex(pRecInfo->pRecord));
  if (ListIndex < 0) return (ListIndex);

	/* Set the item data */
  SetItemData(ListIndex, (DWORD) pRecInfo);
  SetItem(ListIndex, pRecInfo, m_pCurrentColData);

  return (ListIndex);
 }
/*===========================================================================
 *		End of Class Method CEsmListCtrl::AddItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Method - void DropItemOnList (pDropList);
 *
 * Used to copy records between the current list and the source list.
 *
 *=========================================================================*/
#if !defined(NO_ESMLIST_EDIT)

void CEsmListCtrl::DropItemOnList (CEsmListCtrl* pDropList) {
  int Index;

	/* Ignore if we are just dropping onto itself */
  if (pDropList == this) return;
  if (!pDropList->m_AcceptDrag) return;
  if (m_ActNormalList) return;

	/* Unhilight the drop target */
  pDropList->SetItemState (m_DropIndex, 0, LVIS_DROPHILITED);

  for (Index = 0; Index < m_NumDragRecords; Index++) {
    pDropList->OnDropRecord(m_pEsmDlgHandler->GetDocument(), m_ppDragRecords[Index]);
   }

 }

#endif
/*===========================================================================
 *		End of Class Method CEsmListCtrl::DropItemOnList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Method - void EditRecord (SelIndex, WantEditMsg);
 *
 * Edits the given item index if valid. Only posts an edit msg if the
 * WantEditMsg and the internal member flag are true.
 *
 *=========================================================================*/
void CEsmListCtrl::EditRecord (const int SelIndex, const bool WantEditMsg) {

#if !defined(NO_ESMLIST_EDIT) 
  esmrecinfo_t* pRecInfo;

	/* Call the user's event handler if required */
  if (m_WantEditMsg && WantEditMsg) {
    GetParent()->SendMessage(ESMLIST_NOTIFY_ONEDIT, (LPARAM) SelIndex, 0);
    return;
   }

  pRecInfo = GetRecInfo(SelIndex);
  if (m_pEsmDlgHandler != NULL && pRecInfo != NULL) m_pEsmDlgHandler->EditRecord(pRecInfo);

#endif
 }
/*===========================================================================
 *		End of Class Method CEsmListCtrl::EditRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Method - void EditSelectedItem (void);
 *
 *=========================================================================*/
void CEsmListCtrl::EditSelectedItem (void) {

#if !defined(NO_ESMLIST_EDIT) 
  POSITION	ListPos;
  int		ListIndex;

  if (m_ActNormalList) return;

	/* Get the first selected item */
  ListPos = GetFirstSelectedItemPosition();
  if (ListPos == NULL) return;
  ListIndex = GetNextSelectedItem(ListPos);

	/* Edit the record */
  EditRecord(ListIndex, true);
#endif
 }
/*===========================================================================
 *		End of Class Method CEsmListCtrl::EditSelectedItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Method - int FindRecord (pRecInfo);
 *
 *=========================================================================*/
int CEsmListCtrl::FindRecord (esmrecinfo_t* pRecInfo) {
  LVFINDINFO FindInfo;

  FindInfo.flags  = LVFI_PARAM;
  FindInfo.lParam = (DWORD) pRecInfo;
  return FindItem(&FindInfo);
 }
/*===========================================================================
 *		End of Class Method CEsmListCtrl::FindRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Method - esmrecinfo_t* GetCurrentRecord (void);
 *
 * Returns the currently selected item in the list.
 *
 *=========================================================================*/
esmrecinfo_t* CEsmListCtrl::GetCurrentRecord (void) {
  int Index;

	/* Find the first focused item */
  Index = GetNextItem(-1, LVNI_FOCUSED);
  if (Index < 0) return (NULL);

  return GetRecInfo(Index);
 }
/*===========================================================================
 *		End of Class Method CEsmListCtrl::GetCurrentRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Method - esmrecinfo_t* GetRecInfo (Item);
 *
 *=========================================================================*/
esmrecinfo_t* CEsmListCtrl::GetRecInfo (const int Item) {
  if (m_ActNormalList) return(NULL);
  if (Item < 0 || Item >= GetItemCount()) return (NULL);
  return (esmrecinfo_t *) GetItemData(Item);
 }
/*===========================================================================
 *		End of Class Method CEsmListCtrl::GetRecInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Method - int GetImageIndex (pRecord);
 *
 * Description
 *
 *=========================================================================*/
int CEsmListCtrl::GetImageIndex (CEsmRecord* pRecord) {

  if (pRecord->IsType(MWESM_REC_ACTI))
    return ESMLIST_IMAGE_ACTIVATOR;
  else if (pRecord->IsType(MWESM_REC_ARMO))
    return ESMLIST_IMAGE_ARMOR;
  else if (pRecord->IsType(MWESM_REC_APPA))
    return ESMLIST_IMAGE_APPARATUS;
  else if (pRecord->IsType(MWESM_REC_ALCH))
    return ESMLIST_IMAGE_ALCHEMY;
  else if (pRecord->IsType(MWESM_REC_BODY))
    return ESMLIST_IMAGE_BODYPART;
  else if (pRecord->IsType(MWESM_REC_BOOK))
    return ESMLIST_IMAGE_BOOK;
  else if (pRecord->IsType(MWESM_REC_CLOT))
    return ESMLIST_IMAGE_CLOTHING;
  else if (pRecord->IsType(MWESM_REC_CONT))
    return ESMLIST_IMAGE_CONTAINER;
  else if (pRecord->IsType(MWESM_REC_CREA))
    return ESMLIST_IMAGE_CREATURE;
  else if (pRecord->IsType(MWESM_REC_DOOR))
    return ESMLIST_IMAGE_DOOR;
  else if (pRecord->IsType(MWESM_REC_ENCH))
    return ESMLIST_IMAGE_ENCHANT;
  else if (pRecord->IsType(MWESM_REC_INGR))
    return ESMLIST_IMAGE_INGREDIANT;
  else if (pRecord->IsType(MWESM_REC_LEVC))
    return ESMLIST_IMAGE_LEVELCREA;
  else if (pRecord->IsType(MWESM_REC_LEVI))
    return ESMLIST_IMAGE_LEVELITEM;
  else if (pRecord->IsType(MWESM_REC_LIGH))
    return ESMLIST_IMAGE_LIGHT;
  else if (pRecord->IsType(MWESM_REC_LOCK))
    return ESMLIST_IMAGE_LOCKPICK;
  else if (pRecord->IsType(MWESM_REC_MISC))
    return ESMLIST_IMAGE_MISC;
  else if (pRecord->IsType(MWESM_REC_NPC_))
    return ESMLIST_IMAGE_NPC;
  else if (pRecord->IsType(MWESM_REC_PROB))
    return ESMLIST_IMAGE_PROBE;
  else if (pRecord->IsType(MWESM_REC_REPA))
    return ESMLIST_IMAGE_REPAIR;
  else if (pRecord->IsType(MWESM_REC_SPEL))
    return ESMLIST_IMAGE_SPELL;
  else if (pRecord->IsType(MWESM_REC_STAT))
    return ESMLIST_IMAGE_STATIC;
  else if (pRecord->IsType(MWESM_REC_WEAP))
    return ESMLIST_IMAGE_WEAPON;
  else if (pRecord->IsType(MWESM_REC_GLOB))
    return ESMLIST_IMAGE_GLOBAL;
  else if (pRecord->IsType(MWESM_REC_SOUN))
    return ESMLIST_IMAGE_SOUND;
  else if (pRecord->IsType(MWESM_REC_MGEF))
    return ESMLIST_IMAGE_EFFECT;
  else if (pRecord->IsType(MWESM_REC_DIAL))
    return ESMLIST_IMAGE_DIALOG;
  else if (pRecord->IsType(MWESM_REC_INFO))
    return (-1);
  else if (pRecord->IsType(MWESM_REC_GMST))
    return (ESMLIST_IMAGE_SETTING);
  else if (pRecord->IsType(MWESM_REC_CLAS))
    return (ESMLIST_IMAGE_CLASS);
  else if (pRecord->IsType(MWESM_REC_FACT))
    return (ESMLIST_IMAGE_FACTION);
  else if (pRecord->IsType(MWESM_REC_RACE))
    return (ESMLIST_IMAGE_RACE);
  else if (pRecord->IsType(MWESM_REC_SKIL))
    return (ESMLIST_IMAGE_SKILL);
  else if (pRecord->IsType(MWESM_REC_SCPT))
    return (ESMLIST_IMAGE_SCRIPT);
  else if (pRecord->IsType(MWESM_REC_BSGN))
    return (ESMLIST_IMAGE_BIRTHSIGN);
  else if (pRecord->IsType(MWESM_REC_SNDG))
    return (ESMLIST_IMAGE_SOUNDGEN);
  else if (pRecord->IsType(MWESM_REC_REGN))
    return (ESMLIST_IMAGE_REGION);
  else if (pRecord->IsType(MWESM_REC_CELL))
    return (ESMLIST_IMAGE_CELL);
  else if (pRecord->IsType(MWESM_REC_SSCR))
    return (ESMLIST_IMAGE_STARTSCRIPT);

  return (-1);
 }
/*===========================================================================
 *		End of Class Method CEsmListCtrl::GetImageIndex()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Method - void InitObjectList (pColData);
 *
 * Initializes the object list with the given array of column data.
 *
 *=========================================================================*/
void CEsmListCtrl::InitObjectList (esmcoldata_t* pColData) {
  int  Index = 0;
  BOOL Result;
  
	/* Remove all items and columns from the list */
  DeleteAllItems();
  m_pCurrentColData = NULL;

  do {
    Result = DeleteColumn(0);	
  } while (Result);

	/* Check for NULL input */
  if (pColData == NULL) return;

	/* Add the required columns */
  while (pColData[Index].pName != NULL) {
    InsertColumn(Index, pColData[Index].pName, pColData[Index].Format, pColData[Index].Width, pColData[Index].SubItem);
    m_ColSubItems[pColData[Index].SubItem] = Index;
    Index++;
   }

  m_pCurrentColData = pColData;
  m_LastSelItem     = -1;
  m_LastSortField   = -1;
 }
/*===========================================================================
 *		End of Class Method CEsmListCtrl::InitObjectList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Method - int InsertRecord (Index, pRecInfo);
 *
 * Add an item to the given index in the list.
 *
 *=========================================================================*/
int CEsmListCtrl::InsertRecord (const int Index, esmrecinfo_t* pRecInfo) {
  int ListIndex;
  
	/* Add the item to the end of the list */
  ListIndex = InsertItem(Index, "",  GetImageIndex(pRecInfo->pRecord));
  if (ListIndex < 0) return (ListIndex);

	/* Set the item data */
  SetItemData(ListIndex, (DWORD) pRecInfo);
  SetItem(ListIndex, pRecInfo, m_pCurrentColData);

  return (ListIndex);
 }
/*===========================================================================
 *		End of Class Method CEsmListCtrl::InsertRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Event - void OnBeginDrag (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmListCtrl::OnBeginDrag (NMHDR* pNMHDR, LRESULT* pResult) {
  DEFINE_FUNCTION("CEsmListCtrl::OnBeginDrag()");
  NM_LISTVIEW* pNMListView = (NM_LISTVIEW*)pNMHDR;
  LVITEM   ItemInfo;
  POINT    DragPoint;
  BOOL     Result;
  BYTE*    pArray;
  POSITION SelPos;
  int      Offset = 10;
  int	   ListIndex;
  int	   Index;
  *pResult = 0;

	/* Ignore if the dragging is disabled for the list */
  if (!m_EnableDrag) return;
  if (m_ActNormalList) return;

	/* Copy the records we wish to drag */
  CreateArrayPointer(pArray, byte, sizeof(esmrecinfo_t*)*GetSelectedCount());
  m_ppDragRecords = (esmrecinfo_t**) pArray;
  SelPos = GetFirstSelectedItemPosition();
  m_NumDragRecords = GetSelectedCount();
  Index = 0;

  while (SelPos != NULL) {
    ListIndex = GetNextSelectedItem(SelPos);
    m_ppDragRecords[Index] = GetRecInfo(ListIndex);
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
 *		End of Class Event CEsmListCtrl::OnBeginDrag()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Event - void OnChar (nChar, nRepCnt, nFlags);
 *
 *=========================================================================*/
void CEsmListCtrl::OnChar(UINT nChar, UINT nRepCnt, UINT nFlags) {

  if (m_IgnoreCharKey > 0 && (m_IgnoreCharKey == (int) nChar || 
	(m_IgnoreCharKey == VK_SUBTRACT && nChar == '-') ||
	(m_IgnoreCharKey == VK_ADD      && nChar == '+') )) { 
    m_IgnoreCharKey = 0;
    return;
   }   

  CListCtrl::OnChar(nChar, nRepCnt, nFlags);
 }
/*===========================================================================
 *		End of Class Event CEsmListCtrl::OnChar()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Event - void OnColumnclick (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmListCtrl::OnColumnclick(NMHDR* pNMHDR, LRESULT* pResult) {
  NM_LISTVIEW*  pNMListView = (NM_LISTVIEW*)pNMHDR;
  int		Data;
  int		FieldType;
  *pResult = 0;

	/* Use the custom sort callback if provided */
  if (m_WantSortMsg) {
    esmlistsortdata_t SortData;
    SortData.iColumn  = pNMListView->iItem;
    SortData.iSubItem = pNMListView->iSubItem;
    SortData.iField   = m_pCurrentColData[pNMListView->iSubItem].FieldType;

    	/* Initialize the sorting options */
    if (m_LastSortSubItem == pNMListView->iSubItem) {
      m_SortReverse = !m_SortReverse;
     }
    else {
      m_LastSortSubItem = pNMListView->iSubItem;
      m_SortReverse     = false;
     }

    SortData.Reverse = m_SortReverse;
    GetParent()->SendMessage(ESMLIST_NOTIFY_ONSORT, (LPARAM) &SortData, 0);
    return;
   }

	/* Ensure we have a proper object state */
  if (m_pCurrentColData == NULL) return;
  if (m_ActNormalList) return;

	/* Get the type of field to sort by */
  FieldType = m_pCurrentColData[pNMListView->iSubItem].FieldType;
  m_pCurrentColData->LastSortField = FieldType;
  m_LastSortField = FieldType;
  Data = FieldType;

	/* Initialize the sorting options */
  if (m_LastSortSubItem == FieldType) {
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
    SortItems(l_ItemSortCallBack, Data);
   
  m_pCurrentColData->LastReverseSort = m_SortReverse;
 }
/*===========================================================================
 *		End of Class Event CEsmListCtrl::OnColumnclick()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Event - void OnCustomdraw (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmListCtrl::OnCustomdraw (NMHDR* pNMHDR, LRESULT* pResult) {
  NMLVCUSTOMDRAW* pLVCD = reinterpret_cast<NMLVCUSTOMDRAW*>( pNMHDR );

	/* Take the default processing unless we set this to something else below. */
  *pResult = CDRF_DODEFAULT; 
  if (m_ActNormalList) return;

	/* First thing - check the draw stage. If it's the control's prepaint
	 * stage, then tell Windows we want messages for every item. */
  if ( CDDS_PREPAINT == pLVCD->nmcd.dwDrawStage ) {
    *pResult = CDRF_NOTIFYITEMDRAW;
   }
        /* This is the prepaint stage for an item. Here's where we set the
           item's text/back color. */
  else if ( CDDS_ITEMPREPAINT == pLVCD->nmcd.dwDrawStage ) {
    esmrecinfo_t*	pRecInfo;

    pRecInfo = GetRecInfo(pLVCD->nmcd.dwItemSpec);

    if (pRecInfo != NULL) {
      if (pRecInfo->pRecord->IsDeleted())
        pLVCD->clrTextBk = m_DeleteColor;
      else if (pRecInfo->pFile->IsActive()) 
        pLVCD->clrTextBk = m_ActiveColor;
     }

		// Tell Windows to paint the control itself.
    *pResult = CDRF_DODEFAULT;
   }

 }
/*===========================================================================
 *		End of Class Event CEsmListCtrl::OnCustomdraw()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Event - void OnDblclk (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmListCtrl::OnDblclk (NMHDR* pNMHDR, LRESULT* pResult) {

#if !defined(NO_ESMLIST_EDIT)
  esmrecinfo_t* pRecInfo;
  LPNMLISTVIEW  pListView = (LPNMLISTVIEW) pNMHDR;

	/* Call the user's event handler instead? */
  if (m_WantEditMsg) {
    GetParent()->SendMessage(ESMLIST_NOTIFY_ONEDIT, (LPARAM) pListView->iItem, 0);
    return;
   }
  else if (m_ActNormalList) {
    return;
   }

  *pResult = 0;
  if (m_pEsmDlgHandler == NULL || pListView->iItem < 0) return;
  pRecInfo = GetRecInfo(pListView->iItem);
  if (pRecInfo == NULL) return;

	/* Don't edit deleted records */
  if (pRecInfo->pRecord->IsDeleted()) return;

  m_pEsmDlgHandler->EditRecord(pRecInfo);
#endif
 }
/*===========================================================================
 *		End of Class Event CEsmListCtrl::OnDblclk()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Event - int OnDropRecord (pDocument, pRecInfo);
 *
 *=========================================================================*/
#if !defined(NO_ESMLIST_EDIT)

int CEsmListCtrl::OnDropRecord (CMWEditDoc* pDocument, esmrecinfo_t* pRecInfo) {
  //GetParent()->SendNotifyMessage(ESMLIST_NOTIFY_ONDROP, 0, (LPARAM) pRecInfo);
  GetParent()->SendMessage(ESMLIST_NOTIFY_ONDROP, (LPARAM) pDocument, (LPARAM) pRecInfo);
  return (0);
 }

#endif
/*===========================================================================
 *		End of Class Event CEsmListCtrl::OnDropRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Event - UINT OnGetDlgCode ();
 *
 *=========================================================================*/
UINT CEsmListCtrl::OnGetDlgCode() {

  if (m_WantKeys) {
    return (CListCtrl::OnGetDlgCode() | DLGC_WANTCHARS);
   }

  return CListCtrl::OnGetDlgCode();
 }
/*===========================================================================
 *		End of Class Event CEsmListCtrl::OnGetDlgCode()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Event - void OnInitCtrl (void);
 *
 *=========================================================================*/
void CEsmListCtrl::OnInitCtrl (void) {
  ListView_SetExtendedListViewStyle(m_hWnd,  LVS_EX_FULLROWSELECT | LVS_EX_GRIDLINES);
  SetImageList(&m_ImageList, LVSIL_SMALL);

  m_hBadDropCursor = LoadCursor(NULL, MAKEINTRESOURCE(IDC_NO));
 }
/*===========================================================================
 *		End of Class Event CEsmListCtrl::OnInitCtrl()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Event - void OnItemchanged (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmListCtrl::OnItemchanged (NMHDR* pNMHDR, LRESULT* pResult) {
  NM_LISTVIEW* pNMListView = (NM_LISTVIEW*)pNMHDR;
  POSITION SelPos;
  int      SelIndex;
  *pResult = 0;

  if (m_ActNormalList) return;
  SelPos = GetFirstSelectedItemPosition();

  if (SelPos == NULL) {
    m_LastSelItem = -1;
    return;
   }

  SelIndex = GetNextSelectedItem(SelPos);
  if (SelIndex == m_LastSelItem) return;
  m_LastSelItem = SelIndex;
 }
/*===========================================================================
 *		End of Class Event CEsmListCtrl::OnItemchanged()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Event - void OnKeyDown (nChar, nRepCnt, nFlags);
 *
 *=========================================================================*/
void CEsmListCtrl::OnKeyDown (UINT nChar, UINT nRepCnt, UINT nFlags) {

  if (m_WantKeys) {  
    int Result;
    Result = GetParent()->SendMessage(ESMLIST_NOTIFY_ONKEY, (LPARAM) nChar, (LPARAM) nFlags);
    m_IgnoreCharKey = nChar;
    if (Result != 0) return; 
   } 

  CListCtrl::OnKeyDown(nChar, nRepCnt, nFlags);
 }
/*===========================================================================
 *		End of Class Event CEsmListCtrl::OnKeyDown()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Event - void OnKeyUp (nChar, nRepCnt, nFlags);
 *
 *=========================================================================*/
void CEsmListCtrl::OnKeyUp (UINT nChar, UINT nRepCnt, UINT nFlags) {
  CListCtrl::OnKeyUp(nChar, nRepCnt, nFlags);
 }
/*===========================================================================
 *		End of Class Event CEsmListCtrl::OnKeyUp()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Event - void OnLButtonUp (nFlags, Point);
 *
 *=========================================================================*/
void CEsmListCtrl::OnLButtonUp (UINT nFlags, CPoint Point) {

  	/* Ignore if not handling any dragging messages */
  if (!m_IsDragging) {
    CListCtrl::OnLButtonUp(nFlags, Point);
    return;
   }

	/* Release mouse capture, so that other controls can get control/messages */
  ReleaseCapture();

	/* Update the dragging state */
  m_IsDragging = FALSE;

	/* End dragging image */
  m_pDragImage->DragLeave (GetDesktopWindow ());
  m_pDragImage->EndDrag();

	/* Clean up the image list */
  delete m_pDragImage;
  m_pDragImage = NULL;

	/* Get the mouse point in screen coordinates */
  CPoint MousePt (Point); 
  ClientToScreen (&MousePt);
	
	/* Get the CWnd pointer of the window that is under the mouse cursor */
  CWnd* pDropWnd = WindowFromPoint (MousePt);
  ASSERT (pDropWnd);

	/* If window is CListCtrl, we perform the drop */
  if (pDropWnd->IsKindOf (RUNTIME_CLASS (CEsmListCtrl))) {
    m_pDropList = (CEsmListCtrl*) pDropWnd; 
#if !defined(NO_ESMLIST_EDIT)
    DropItemOnList(m_pDropList); 
#endif
   }

	/* Delete the drag array of records */
  byte* pArray = (byte *)m_ppDragRecords;
  DestroyArrayPointer(pArray);
  m_ppDragRecords  = NULL;
  m_NumDragRecords = 0;
 }
/*===========================================================================
 *		End of Class Event CEsmListCtrl::OnLButtonUp()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Event - void OnMouseMove (nFlags, Ppoint);
 *
 *=========================================================================*/
void CEsmListCtrl::OnMouseMove (UINT nFlags, CPoint Point) {
  DEFINE_FUNCTION("CEsmListCtrl::OnMouseMove()");

	/* Ignore if not handling any dragging messages */
  if (!m_IsDragging) {
    CListCtrl::OnMouseMove(nFlags, Point);
    return;
   }

	/* Get mouse coordinates in screen */
  CPoint MousePt(Point);
  ClientToScreen(&MousePt);

	/* Move the drag image to those coordinates */
  m_pDragImage->DragMove(MousePt); 
  m_pDragImage->DragShowNolock(false);	/* Smoother updates */

	/* Get the CWnd pointer of the window that is under the mouse cursor */
  CWnd* pDropWnd = WindowFromPoint(MousePt);
  ASSERT(pDropWnd);

	/* Save current window pointer as the CListCtrl we are dropping onto */
  m_pDropWnd = pDropWnd;
  pDropWnd->ScreenToClient(&MousePt);

	/* If we are hovering over a CEsmListCtrl we need to adjust the highlights */
  if (pDropWnd->IsKindOf(RUNTIME_CLASS (CEsmListCtrl))) {            
    CEsmListCtrl* pList = (CEsmListCtrl *) pDropWnd;
    UINT uFlags;
            
		/* Get the item that is below cursor, highlight, and redraw it */
    if (pList != this && pList->m_AcceptDrag) {
      m_DropIndex = pList->HitTest(MousePt, &uFlags);
      SetCursor(m_hGoodDropCursor); 
     }
    else {
      SetCursor(m_hBadDropCursor); 
     }

    //pList->SetItemState(m_DropIndex, LVIS_DROPHILITED, LVIS_DROPHILITED);
    //pList->RedrawItems(m_DropIndex, m_DropIndex);
    //pList->UpdateWindow();
   }

	/* Lock window updates */
  m_pDragImage->DragShowNolock(true);
 }
/*===========================================================================
 *		End of Class Event CEsmListCtrl::OnMouseMove()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Method - void SetItem (ListIndex, pRecInfo, pColInfo);
 *
 * Description
 *
 *=========================================================================*/
void CEsmListCtrl::SetItem (const int ListIndex, esmrecinfo_t* pRecInfo, esmcoldata_t* pColInfo) {
  CEsmRecord*	pRecord = pRecInfo->pRecord;
  int		ColIndex;
  bool		ClearFields = false;

  for (ColIndex = 0; pColInfo[ColIndex].pName != NULL; ColIndex++) {
    if (pColInfo[ColIndex].SubItem != ESM_FIELD_CUSTOM) {
      if (!ClearFields) {
        SetItemText(ListIndex, m_ColSubItems[pColInfo[ColIndex].SubItem], pRecord->GetFieldString(pColInfo[ColIndex].FieldType));
        if (pColInfo[ColIndex].SubItem == ESM_FIELD_CHANGED && pRecord->IsDeleted()) ClearFields = true; 
       }
      else {
        SetItemText(ListIndex, m_ColSubItems[pColInfo[ColIndex].SubItem], _T(""));
       }
     }
   }

 }
/*===========================================================================
 *		End of Class Method CEsmListCtrl::SetItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Method - void UpdateColData (void);
 *
 *=========================================================================*/
void CEsmListCtrl::UpdateColData (void) {
  //DEFINE_FUNCTION("CEsmListCtrl::UpdateColData()");
  int Index = 0;
  int Width;
  
  if (m_pCurrentColData == NULL) return;

  while (m_pCurrentColData[Index].pName != NULL) {
    Width = GetColumnWidth(Index);
    if (Width > 0) m_pCurrentColData[Index].Width = Width;
    Index++;
   }

 }
/*===========================================================================
 *		End of Class Method CEsmListCtrl::UpdateColData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmListCtrl Method - void UpdateItem (Index);
 *
 *=========================================================================*/
void CEsmListCtrl::UpdateItem (const int Index) {
  esmrecinfo_t* pRecInfo = GetRecInfo(Index);

  if (m_pCurrentColData != NULL && pRecInfo != NULL) {
    SetItem (Index, pRecInfo, m_pCurrentColData);
   }
  
  //RedrawItems(Index, Index);
 }

void CEsmListCtrl::UpdateItem (esmrecinfo_t* pRecInfo) {
  int Index;

  Index = FindRecord(pRecInfo);
  if (Index >= 0) UpdateItem(Index);
 }
/*===========================================================================
 *		End of Class Method CEsmListCtrl::UpdateItem()
 *=========================================================================*/

