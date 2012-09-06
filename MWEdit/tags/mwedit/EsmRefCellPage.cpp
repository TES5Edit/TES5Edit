/*===========================================================================
 *
 * File:	Esmrefcellpage.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 25, 2003
 *
 * Description
 *
 * 5 October 2003
 *	- Added the 'Index' column to the reference list.
 *	- Redid the overall design so that changes to any cell reference
 *	  are not 'saved' to the active file until the user presses the
 *	  'Save' button in the dialog.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmRefCellPage.h"
#include "EsmRecDialog.h"
#include "EsmCellRefDlg.h"


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

  IMPLEMENT_DYNCREATE(CEsmRefCellPage, CPropertyPage);
  DEFINE_FILE("EsmRefCellPage.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Item List Display Data Array
 *
 *=========================================================================*/
static esmcoldata_t l_ItemColData[] = {
	{  _T("ID"),		ESM_FIELD_ID,		LVCFMT_LEFT,	ESMLIST_WIDTH_ID,	ESMLIST_SUBITEM_ID, }, 
	{  _T("Mod"),		ESMSUBLIST_FIELD_MOD,	LVCFMT_CENTER,	ESMLIST_WIDTH_CHANGED,	ESMLIST_SUBITEM_CHANGED }, 
	{  _T("Name"),		ESM_FIELD_NAME,		LVCFMT_LEFT,	ESMLIST_WIDTH_NAME,	ESMLIST_SUBITEM_NAME }, 
	{  _T("Type"),		ESM_FIELD_ITEMTYPE,	LVCFMT_LEFT,	ESMLIST_WIDTH_ITEMTYPE,	ESMLIST_SUBITEM_ITEMTYPE }, 
	{  _T("Index"),		ESMSUBLIST_FIELD_INDEX,	LVCFMT_LEFT,	ESMLIST_WIDTH_INDEX,	ESMLIST_SUBITEM_INDEX }, 
	{ NULL, 0, 0, 0 }	/* Must be last record */
 };
/*===========================================================================
 *		End of Item List Display Data Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmRefCellPage Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmRefCellPage, CPropertyPage)
  //{{AFX_MSG_MAP(CEsmRefCellPage)
  ON_MESSAGE(ESMLIST_NOTIFY_ONEDIT, OnRecordEdit)
  ON_MESSAGE(ESMLIST_NOTIFY_ONKEY, OnRecordKey)
  ON_MESSAGE(ESMLIST_NOTIFY_ONDROP, OnRecordDrop)
  ON_WM_CONTEXTMENU()
  ON_COMMAND(ID_EDIT_CLEAN, OnEditClean)
  ON_COMMAND(ID_CELLREF_EDITREF, OnCellrefEditref)
  ON_UPDATE_COMMAND_UI(ID_CELLREF_EDITREF, OnUpdateCellrefEditref)
  ON_COMMAND(ID_CELLREF_EDIT, OnCellrefEdit)
  ON_UPDATE_COMMAND_UI(ID_CELLREF_EDIT, OnUpdateCellrefEdit)
  ON_COMMAND(ID_CELLREF_DELETE, OnCellrefDelete)
  ON_UPDATE_COMMAND_UI(ID_CELLREF_DELETE, OnUpdateCellrefDelete)
  ON_UPDATE_COMMAND_UI(ID_EDIT_CLEAN, OnUpdateEditClean)
  ON_COMMAND(ID_CELLREF_UNDELETE, OnCellrefUndelete)
  ON_UPDATE_COMMAND_UI(ID_CELLREF_UNDELETE, OnUpdateCellrefUndelete)
	ON_COMMAND(ID_CELLREF_CREATECOPY, OnCellrefCreatecopy)
	ON_UPDATE_COMMAND_UI(ID_CELLREF_CREATECOPY, OnUpdateCellrefCreatecopy)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmRefCellPage Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Constructor
 *
 *=========================================================================*/
CEsmRefCellPage::CEsmRefCellPage() : CPropertyPage(CEsmRefCellPage::IDD), m_ModCellRefs(0) {
  //{{AFX_DATA_INIT(CEsmRefCellPage)
  //}}AFX_DATA_INIT
  m_pRecInfo    = NULL;
  m_pDlgParent  = NULL;
 }
/*===========================================================================
 *		End of Class CEsmRefCellPage Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Destructor
 *
 *=========================================================================*/
CEsmRefCellPage::~CEsmRefCellPage() {
  ClearCellRefArray(); 
 }
/*===========================================================================
 *		End of Class CEsmRefCellPage Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - cellrefdata_t* AddNewCellRef (pCellRef);
 *
 * Attempt to add a new cell reference to the modified reference array.
 * Does not create a new cell reference sub-record.
 *
 *=========================================================================*/
cellrefdata_t* CEsmRefCellPage::AddNewCellRef (CEsmSubCellRef* pCellRef) {
  DEFINE_FUNCTION("CEsmRefCellPage::CleanCellRef()");
  cellrefdata_t* pCellRefData;

	/* Add a new record to the modified array */
  CreatePointer(pCellRefData, cellrefdata_t);
  m_ModCellRefs.AddElement(pCellRefData);

	/* Initialize the new cell ref data */
  pCellRefData->IsNew = true;
  pCellRefData->Type  = ESMCELLREF_MODTYPE_NEW;
  pCellRefData->pOldCellRef = NULL;
  pCellRefData->pNewCellRef = pCellRef;

  return (pCellRefData);
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::AddNewCellRef()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - bool AddNewCellRef (pCellRefData);
 *
 * Attempt to add a new cell reference to the cell.
 *
 *=========================================================================*/
bool CEsmRefCellPage::AddNewCellRef (cellrefdata_t* pCellRefData) {
  CEsmCell* pCell = (CEsmCell *) m_pRecInfo->pRecord;

	/* Remove the cell reference from the cell */
  pCell->AddCellRef(pCellRefData->pNewCellRef);
  if (!pCellRefData->pNewCellRef->IsDeleted()) pCell->IncCount();

	/* Unallocate the pointers */
  DestroyPointer(pCellRefData);

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::AddNewCellRef()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - cellrefdata_t* CleanCellRef (pCellRef);
 *
 * Updates the modified cell reference array to clean the selected cell 
 * reference.
 *
 *=========================================================================*/
cellrefdata_t* CEsmRefCellPage::CleanCellRef (CEsmSubCellRef* pCellRef) {
  DEFINE_FUNCTION("CEsmRefCellPage::CleanCellRef()");
  cellrefdata_t* pCellRefData;

	/* See if the record already exists in array */
  pCellRefData = FindNewCellRef(pCellRef);

  if (pCellRefData != NULL) {

		/* Delete a new reference sub-record outright */
    if (pCellRefData->IsNew) {
      m_ModCellRefs.DeleteElement(pCellRefData);
      DestroyPointer(pCellRefData->pNewCellRef);
      DestroyPointer(pCellRefData);
      return (pCellRefData);
     }
    
	/* Update the reference element to clean it */
    pCellRefData->Type = ESMCELLREF_MODTYPE_CLEAN;
    return (pCellRefData);
   }

	/* Add a new record to the modified array */
  CreatePointer(pCellRefData, cellrefdata_t);
  m_ModCellRefs.AddElement(pCellRefData);

	/* Initialize the new cell ref data */
  pCellRefData->IsNew = false;
  pCellRefData->Type  = ESMCELLREF_MODTYPE_CLEAN;
  pCellRefData->pNewCellRef = pCellRef;
  pCellRefData->pOldCellRef = pCellRef;

  return (pCellRefData);
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::CleanCellRef()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - bool CleanCellRef (pCellRefData);
 *
 * Attempt to clean the given cell reference from the active file.
 *
 *=========================================================================*/
bool CEsmRefCellPage::CleanCellRef (cellrefdata_t* pCellRefData) {
  CEsmCell* pCell = (CEsmCell *) m_pRecInfo->pRecord;

	/* Remove the cell reference from the cell */
  pCell->DeleteSubRecord(pCellRefData->pOldCellRef);
  if (!pCellRefData->pNewCellRef->IsDeleted()) pCell->DecCount();

	/* Unallocate the pointers */
  DestroyPointer(pCellRefData->pOldCellRef);
  DestroyPointer(pCellRefData);

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::CleanCellRef()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - void ClearCellRefArray (void);
 *
 *=========================================================================*/
void CEsmRefCellPage::ClearCellRefArray (void) {
  DEFINE_FUNCTION("CEsmRefCellPage::ClearCellRefArray()");
  cellrefdata_t* pCellRefData;
  int		 Index;

  for (Index = 0; Index < m_ModCellRefs.GetSize(); Index++) {
    pCellRefData = m_ModCellRefs.GetAt(Index);
    DestroyPointer(pCellRefData);
   }

  m_ModCellRefs.RemoveAll();
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::ClearCellRefArray()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - cellrefdata_t* DeleteCellRef (pCellRef);
 *
 * Adds a delete entry to the reference modified array.
 *
 *=========================================================================*/
cellrefdata_t* CEsmRefCellPage::DeleteCellRef (CEsmSubCellRef* pCellRef) {
  DEFINE_FUNCTION("CEsmRefCellPage::DeleteCellRef()");
  cellrefdata_t* pCellRefData;

	/* See if the record already exists in array */
  pCellRefData = FindNewCellRef(pCellRef);

  if (pCellRefData != NULL) {
    pCellRefData->Type = ESMCELLREF_MODTYPE_DEL;
    return (pCellRefData);
   }

	/* Add a new record to the modified array */
  CreatePointer(pCellRefData, cellrefdata_t);
  m_ModCellRefs.AddElement(pCellRefData);

	/* Initialize the new cell ref data */
  pCellRefData->IsNew = false;
  pCellRefData->Type  = ESMCELLREF_MODTYPE_DEL;
  pCellRefData->pNewCellRef = pCellRef;
  pCellRefData->pOldCellRef = pCellRef;
  
  return (pCellRefData);
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::DeleteCellRef()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - void DeleteIndex (ListIndex, Delete);
 *
 * Deletes or undeletes the given list record.
 *
 *=========================================================================*/
void CEsmRefCellPage::DeleteIndex (const int ListIndex, const bool Delete) {
  DEFINE_FUNCTION("CEsmRefCellPage::DeleteIndex()");
  CEsmSubCellRef* pOldCellRef;
  CEsmSubCellRef* pNewCellRef;
  CEsmCellRefDlg  RefDialog;
  cellrefdata_t*  pCellRefData;
  
	/* Get the given cell reference object */
  pOldCellRef = (CEsmSubCellRef *) m_CellRefList.GetItemData(ListIndex);
  if (pOldCellRef == NULL) return;

	/* See if the reference record is already 'new' */
  pCellRefData = FindNewCellRef(pOldCellRef);

  if (pCellRefData == NULL) {
    CreatePointer(pNewCellRef, CEsmSubCellRef);
    pNewCellRef->Copy(pOldCellRef);
   }
  else {
    pNewCellRef = pCellRefData->pNewCellRef;
   }

	/* Create a new cell ref data record if required */ 
  if (pCellRefData == NULL) {
    pCellRefData = DeleteCellRef(pNewCellRef);
    pCellRefData->pOldCellRef = pOldCellRef;
    pCellRefData->pNewCellRef = pNewCellRef;
   }
  else {
    pCellRefData->Type = ESMCELLREF_MODTYPE_DEL;
   }

	/* Delete or undelete the reference */
  pCellRefData->pNewCellRef->SetDelete(Delete);
  pCellRefData->pNewCellRef->SetFRMRFlag(1);
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::DeleteIndex()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - bool DeleteCellRef (pCellRefData);
 *
 * Attempt to delete the given cell reference entirely from the cell.
 *
 *=========================================================================*/
bool CEsmRefCellPage::DeleteCellRef (cellrefdata_t* pCellRefData) {
  CEsmCell*	  pCell = (CEsmCell *) m_pRecInfo->pRecord;
  CEsmSubCellRef* pCellRef;

  if (pCellRefData->pOldCellRef == NULL)
    pCellRef = NULL;
  else
    pCellRef = pCell->FindActiveCellRef(pCellRefData->pOldCellRef);

	/* Update the cell reference counts */
  if (pCellRefData->pOldCellRef != NULL) {
    if (pCellRefData->pOldCellRef->IsDeleted() && !pCellRefData->pNewCellRef->IsDeleted()) 
      pCell->IncCount();
    else if (!pCellRefData->pOldCellRef->IsDeleted() && pCellRefData->pNewCellRef->IsDeleted())
      pCell->DecCount();
   }
  else if (!pCellRefData->pNewCellRef->IsDeleted()) {
    pCell->IncCount();
   }

	/* Don't recreate an active cell reference */
  if (pCellRef != NULL) {
    pCellRef->Copy(pCellRefData->pNewCellRef);
    DestroyPointer(pCellRefData->pNewCellRef);
   }
	/* Create a new active cell reference sub-record */
  else {
    pCell->AddCellRef(pCellRefData->pNewCellRef);
   }

	/* Unallocate pointer data */
  DestroyPointer(pCellRefData);
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::DeleteCellRef()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmRefCellPage::DoDataExchange(CDataExchange* pDX) {
  CPropertyPage::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmRefCellPage)
  DDX_Control(pDX, IDC_OBJECTLIST, m_CellRefList);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - cellrefdata_t* FindNewCellRef (pCellRef);
 *
 * Attempt to find the given cell reference object in the current modified
 * reference array. Returns NULL if it is not found.
 *
 *=========================================================================*/
cellrefdata_t* CEsmRefCellPage::FindNewCellRef (CEsmSubCellRef* pCellRef) {
  cellrefdata_t* pCellRefData;
  int		 Index;

	/* Search all existing modified references for a match */
  for (Index = 0; Index < m_ModCellRefs.GetNumElements(); Index++) {
    pCellRefData = m_ModCellRefs.GetAt(Index);
    if (pCellRefData->pNewCellRef == pCellRef) return (pCellRefData);
   }

	/* No match found */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::FindNewCellRef()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - cellrefdata_t* FindOldCellRef (pCellRef);
 *
 * Attempt to find the given cell reference object in the current modified
 * reference array. Returns NULL if it is not found.
 *
 *=========================================================================*/
cellrefdata_t* CEsmRefCellPage::FindOldCellRef (CEsmSubCellRef* pCellRef) {
  cellrefdata_t* pCellRefData;
  int		 Index;

	/* Search all existing modified references for a match */
  for (Index = 0; Index < m_ModCellRefs.GetNumElements(); Index++) {
    pCellRefData = m_ModCellRefs.GetAt(Index);
    if (pCellRefData->pOldCellRef == pCellRef) return (pCellRefData);
   }

	/* No match found */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::FindOldCellRef()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmRefCellPage::GetControlData (void) {
  CEsmCell*  	  pCell;
  cellrefdata_t*  pCellRefData;
  bool		  Result;
  int		  Index;
  
	/* Ignore if class members are invalid */
  if (m_pRecInfo == NULL) return;
  pCell = (CEsmCell *) m_pRecInfo->pRecord;

	/* Clean/delete/modify/add the required records */
  for (Index = 0; Index < m_ModCellRefs.GetSize(); Index++) {
    pCellRefData = m_ModCellRefs.GetAt(Index);

    switch (pCellRefData->Type) {
      case ESMCELLREF_MODTYPE_NEW:
        Result = AddNewCellRef(pCellRefData);
	break;
      case ESMCELLREF_MODTYPE_MOD:
        Result = ModifyCellRef(pCellRefData);
	break;
      case ESMCELLREF_MODTYPE_CLEAN:
        Result = CleanCellRef(pCellRefData);
	break;
      case ESMCELLREF_MODTYPE_DEL:
        Result = DeleteCellRef(pCellRefData);
	break;
     };
   }

	/* Clear the modified array (records are deleted as needed in the above methods) */ 
  m_ModCellRefs.RemoveAll();
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - CMWEditDoc* GetDocument (void);
 *
 *=========================================================================*/
CMWEditDoc* CEsmRefCellPage::GetDocument (void) {
  DEFINE_FUNCTION("CEsmRefCellPage::GetDocument()");
  ASSERT(m_pDlgParent != NULL);
  return m_pDlgParent->GetDocument();
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::GetDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - cellrefdata_t* ModifyCellRef (pCellRef);
 *
 * Adds the given record to the modified reference array.
 *
 *=========================================================================*/
cellrefdata_t* CEsmRefCellPage::ModifyCellRef (CEsmSubCellRef* pCellRef) {
  DEFINE_FUNCTION("CEsmRefCellPage::DeleteCellRef()");
  cellrefdata_t* pCellRefData;

	/* See if the record already exists in array */
  pCellRefData = FindNewCellRef(pCellRef);

  if (pCellRefData != NULL) {
    pCellRefData->Type = ESMCELLREF_MODTYPE_MOD;
    return (pCellRefData);
   }

	/* Add a new record to the modified array */
  CreatePointer(pCellRefData, cellrefdata_t);
  m_ModCellRefs.AddElement(pCellRefData);

	/* Initialize the new cell ref data */
  pCellRefData->IsNew = false;
  pCellRefData->Type  = ESMCELLREF_MODTYPE_MOD;
  pCellRefData->pNewCellRef = pCellRef;
  pCellRefData->pOldCellRef = pCellRef;

  return (pCellRefData);
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::ModifyCellRef()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - bool ModifyCellRef (pCellRefData);
 *
 * Attempt to modify and existing cell reference in the cell.
 *
 *=========================================================================*/
bool CEsmRefCellPage::ModifyCellRef (cellrefdata_t* pCellRefData) {
  CEsmCell*	  pCell = (CEsmCell *) m_pRecInfo->pRecord;
  CEsmSubCellRef* pCellRef;

  pCellRef = pCell->FindActiveCellRef(pCellRefData->pOldCellRef);

	/* Don't recreate an active cell reference */
  if (pCellRef != NULL) {
    pCellRef->Copy(pCellRefData->pNewCellRef);
    DestroyPointer(pCellRefData->pNewCellRef);
   }
	/* Create a new active cell reference sub-record */
  else {
    pCell->AddCellRef(pCellRefData->pNewCellRef);
   }

	/* Unallocate pointer data */
  DestroyPointer(pCellRefData);

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::ModifyCellRef()
 *=========================================================================*/



/*===========================================================================
 *
 * Class CEsmRefCellPage Event - void OnCellrefCreatecopy ();
 *
 *=========================================================================*/
void CEsmRefCellPage::OnCellrefCreatecopy() {
  DEFINE_FUNCTION("CEsmRefCellPage::OnCellrefDelete()");
  CEsmCell*	  pCell = (CEsmCell *) m_pRecInfo->pRecord;
  POSITION	  SelPos;
  CEsmSubCellRef* pOldCellRef;
  CEsmSubCellRef* pNewCellRef;
  cellrefdata_t*  pCellRefData;
  int		  SelectedIndex;
  
	/* Copy all selected records */
  SelPos = m_CellRefList.GetFirstSelectedItemPosition();

  while (SelPos != NULL) {
    SelectedIndex = m_CellRefList.GetNextSelectedItem(SelPos);
    pOldCellRef = (CEsmSubCellRef *) m_CellRefList.GetItemData(SelectedIndex);
    if (pOldCellRef == NULL) continue;

    CreatePointer(pNewCellRef, CEsmSubCellRef);
    pNewCellRef->Copy(pOldCellRef);
    pNewCellRef->SetIsActive(true);
    pNewCellRef->SetIndex(pCell->GetNextRefIndex(), 0);
    pCellRefData = AddNewCellRef(pNewCellRef);

	/* Update the reference list */
    m_CellRefList.AddItem(pNewCellRef);
   }

	/* Update the display */
  UpdateCellRefList();
 }
/*===========================================================================
 *		End of Class Event CEsmRefCellPage::OnCellrefCreatecopy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Event - void OnCellrefEditref ();
 *
 *=========================================================================*/
void CEsmRefCellPage::OnCellrefEditref() {
  POSITION SelPos;
  int	   SelectedIndex;

  SelPos = m_CellRefList.GetFirstSelectedItemPosition();
  if (SelPos == NULL) return;
  SelectedIndex = m_CellRefList.GetNextSelectedItem(SelPos);

  OnRecordEdit(SelectedIndex, 0);
 }
/*===========================================================================
 *		End of Class Event CEsmRefCellPage::OnCellrefEditref()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Event - void OnCellrefEdit ();
 *
 *=========================================================================*/
void CEsmRefCellPage::OnCellrefEdit() {
  POSITION SelPos;
  int	   SelectedIndex;

  SelPos = m_CellRefList.GetFirstSelectedItemPosition();
  if (SelPos == NULL) return;
  SelectedIndex = m_CellRefList.GetNextSelectedItem(SelPos);

  m_CellRefList.EditRecord(SelectedIndex);
 }
/*===========================================================================
 *		End of Class Event CEsmRefCellPage::OnCellrefEdit()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Event - void OnCellrefDelete ();
 *
 *=========================================================================*/
void CEsmRefCellPage::OnCellrefDelete() {
  DEFINE_FUNCTION("CEsmRefCellPage::OnCellrefDelete()");
  POSITION	  SelPos;
  int		  SelectedIndex;
  
	/* Delete all selected records */
  SelPos = m_CellRefList.GetFirstSelectedItemPosition();

  while (SelPos != NULL) {
    SelectedIndex = m_CellRefList.GetNextSelectedItem(SelPos);
    DeleteIndex(SelectedIndex, true);
   }

	/* Update the display */
  UpdateCellRefList();
 }
/*===========================================================================
 *		End of Class Event CEsmRefCellPage::OnCellrefDelete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Event - void OnCellrefUndelete ();
 *
 *=========================================================================*/
void CEsmRefCellPage::OnCellrefUndelete() {
  DEFINE_FUNCTION("CEsmRefCellPage::OnCellrefDelete()");
  POSITION	  SelPos;
  int		  SelectedIndex;
  
	/* Delete all selected records */
  SelPos = m_CellRefList.GetFirstSelectedItemPosition();

  while (SelPos != NULL) {
    SelectedIndex = m_CellRefList.GetNextSelectedItem(SelPos);
    DeleteIndex(SelectedIndex, false);
   }

	/* Update the display */
  UpdateCellRefList();
 }
/*===========================================================================
 *		End of Class Event CEsmRefCellPage::OnCellrefUndelete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Event - void OnContextMenu (pWnd, point);
 *
 *=========================================================================*/
void CEsmRefCellPage::OnContextMenu(CWnd* pWnd, CPoint Point) {
  CMenu  Menu;
  CMenu* pPopup;
  BOOL   Result;
  CCmdUI MenuState;
  int    Index;

	/* Get the popup menu to display */
  Result = Menu.LoadMenu(IDR_CELLREF_MENU);
  if (!Result) return;
  pPopup = Menu.GetSubMenu(0);
  if (pPopup == NULL) return;

  	/* Force the update of the menu commands */
  for (Index = 0; Index < (int) pPopup->GetMenuItemCount(); Index++) {
    MenuState.m_nID = pPopup->GetMenuItemID(Index);
    MenuState.m_nIndex = Index;
    MenuState.m_pMenu = pPopup;
    MenuState.m_pOther = NULL;
    MenuState.m_pSubMenu = NULL;
    MenuState.m_nIndexMax = pPopup->GetMenuItemCount();

    if (MenuState.m_nID != 0) {
      OnCmdMsg(MenuState.m_nID, CN_UPDATE_COMMAND_UI, &MenuState, NULL);
     }
   }
  
  if (pWnd->GetDlgCtrlID() == IDC_OBJECTLIST) {
    pPopup->TrackPopupMenu(TPM_RIGHTBUTTON | TPM_LEFTALIGN, Point.x, Point.y, this);
   }

 }
/*===========================================================================
 *		End of Class Event CEsmRefCellPage::OnContextMenu()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Event - void OnEditClean ();
 *
 *=========================================================================*/
void CEsmRefCellPage::OnEditClean() {
  POSITION	  SelPos;
  CEsmSubCellRef* pCellRef;
  cellrefdata_t*  pCellRefData;
  CString	  Buffer;
  int		  ListIndex;
  int		  SelCount;
  int		  Result;

  SelPos = m_CellRefList.GetFirstSelectedItemPosition();
  SelCount = m_CellRefList.GetSelectedCount();
  if (SelCount <= 0 || SelPos == NULL) return;

	/* Prompt user to ensure they wish to proceed */
  Buffer.Format(_T("This will permanently remove the %d selected references from the active file.\nAre you sure you wish to continue?"), SelCount);
  Result = MessageBox(Buffer, _T("Clean References"), MB_YESNO | MB_ICONQUESTION);
  if (Result != IDYES) return;

  while (SelPos != NULL) {
    ListIndex = m_CellRefList.GetNextSelectedItem(SelPos);
    pCellRef = (CEsmSubCellRef *) m_CellRefList.GetItemData(ListIndex);

		/* Only need to clean active cell references */
    if (pCellRef->IsActive()) {
      pCellRefData = CleanCellRef(pCellRef);
     }
   }

	/* Update the reference list */
  UpdateCellRefList();
 }
/*===========================================================================
 *		End of Class Event CEsmRefCellPage::OnEditClean()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmRefCellPage::OnInitDialog() {
  CPropertyPage::OnInitDialog();

	/* Intialize the list */
  m_CellRefList.OnInitCtrl();
  m_CellRefList.InitObjectList(l_ItemColData);
  m_CellRefList.SetWantKeys(true);
  m_CellRefList.SetAcceptDrag(true);
  m_CellRefList.SetEnableDrag(true);
  m_CellRefList.SetWantEditMsg(true);

  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmRefCellPage::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Event - LRESULT OnRecordDrop (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmRefCellPage::OnRecordDrop (LPARAM lParam, LPARAM wParam) {
  DEFINE_FUNCTION("CEsmRefCellPage::OnRecordDrop()");
  CEsmCell*	  pCell = (CEsmCell *) m_pRecInfo->pRecord;
  CString	  Buffer;
  CMWEditDoc*     pSourceDoc = (CMWEditDoc *) lParam;
  esmrecinfo_t*   pRecInfo = (esmrecinfo_t *) wParam;
  CEsmSubCellRef* pNewCellRef;
  cellrefdata_t*  pCellRefData;

	/* Ensure we only drag from the current document */
  if (pSourceDoc != GetDocument()) return (0);
  
	/* Only accept certain types */
  if (!IsESMRecordModel(pRecInfo->pRecord->GetType())) return (0);
  //return (0);

	/* Add a new item to the cell */
  CreatePointer(pNewCellRef, CEsmSubCellRef);
  pNewCellRef->CreateNew((CEsmCell *) m_pRecInfo->pRecord);
  pNewCellRef->SetIsActive(true);
  pNewCellRef->SetIndex(pCell->GetNextRefIndex(), 0);
  pNewCellRef->SetRefName(pRecInfo->pRecord->GetID());

  pCellRefData = AddNewCellRef(pNewCellRef);

	/* Update the reference list */
  m_CellRefList.AddItem(pNewCellRef);
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmRefCellPage::OnRecordDrop()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Event - LRESULT OnRecordEdit (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmRefCellPage::OnRecordEdit (LPARAM lParam, LPARAM wParam) {
  DEFINE_FUNCTION("CEsmRefCellPage::OnRecordEdit()");
  CEsmSubCellRef* pOldCellRef;
  CEsmSubCellRef* pNewCellRef;
  CEsmCellRefDlg  RefDialog;
  cellrefdata_t*  pCellRefData;
  bool		  Result;
  bool		  IsNew;
  bool		  NewAllocated;

	/* Ignore if no record currently selected */
  if (lParam < 0) return (0);
  pOldCellRef = (CEsmSubCellRef *) m_CellRefList.GetItemData(lParam);
  if (pOldCellRef == NULL) return (0);

	/* See if the reference record is already 'new' */
  pCellRefData = FindNewCellRef(pOldCellRef);

  if (pCellRefData == NULL) {
    if (pOldCellRef->IsDeleted()) return (0);
    IsNew = false;
    NewAllocated = true;
    CreatePointer(pNewCellRef, CEsmSubCellRef);
    pNewCellRef->Copy(pOldCellRef);
   }
  else {
    if (pOldCellRef->IsDeleted()) return (0);
    if (pCellRefData->Type == ESMCELLREF_MODTYPE_DEL) return (0);
    NewAllocated = false;
    IsNew = pCellRefData->IsNew;
    pNewCellRef = pCellRefData->pNewCellRef;
   }
  
	/* Display the modal edit dialogue */
  Result = RefDialog.DoModal(pNewCellRef, true, (CEsmCell *) m_pRecInfo->pRecord);

  if (!Result) {
    if (NewAllocated) {
      DestroyPointer(pNewCellRef);
     }
    return (0);
   }

	/* Create a new cell ref data record if required */ 
  if (pCellRefData == NULL) {
    pCellRefData = ModifyCellRef(pNewCellRef);
    pCellRefData->pOldCellRef = pOldCellRef;
    pNewCellRef->SetFRMRFlag(1);
   }
  else {
    pCellRefData->Type = ESMCELLREF_MODTYPE_MOD;
   }

	/* Update the display */
  UpdateCellRefList();
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmRefCellPage::OnRecordEdit()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Event - LRESULT OnRecordKey (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmRefCellPage::OnRecordKey (LPARAM lParam, LPARAM wParam) {
  return (0);
 }
/*===========================================================================
 *		End of Class Event OnRecordKey::OnRecordEdit()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmRefCellPage::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmRefCellPage::OnUpdateItem()
 *========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Event - void OnUpdateCellrefDelete (pCmdUI);
 *
 *=========================================================================*/
void CEsmRefCellPage::OnUpdateCellrefDelete(CCmdUI* pCmdUI) {
  pCmdUI->Enable(m_CellRefList.GetSelectedCount() > 0);
 }


void CEsmRefCellPage::OnUpdateEditClean(CCmdUI* pCmdUI) {
  pCmdUI->Enable(m_CellRefList.GetSelectedCount() > 0);
 }


void CEsmRefCellPage::OnUpdateCellrefEdit(CCmdUI* pCmdUI) {
  pCmdUI->Enable(m_CellRefList.GetSelectedCount() > 0);
 }


void CEsmRefCellPage::OnUpdateCellrefEditref(CCmdUI* pCmdUI) {
  pCmdUI->Enable(m_CellRefList.GetSelectedCount() > 0);
 }


void CEsmRefCellPage::OnUpdateCellrefUndelete(CCmdUI* pCmdUI) {
  pCmdUI->Enable(m_CellRefList.GetSelectedCount() > 0);
 }


void CEsmRefCellPage::OnUpdateCellrefCreatecopy(CCmdUI* pCmdUI) {
  pCmdUI->Enable(m_CellRefList.GetSelectedCount() > 0);
 }
/*===========================================================================
 *		End of Class Event CEsmRefCellPage::OnUpdateCellrefDelete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmRefCellPage::SetControlData (void) {
  m_CellRefList.SetDlgHandler(m_pDlgParent->GetParentDlg());
  UpdateCellRefList();
 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRefCellPage Method - void UpdateCellRefList (void);
 *
 *=========================================================================*/
void CEsmRefCellPage::UpdateCellRefList (void) {
  CEsmSubCellRef* pCellRef;
  cellrefdata_t*  pCellRefData;
  CEsmCell*  	  pCell = (CEsmCell *) m_pRecInfo->pRecord;
  CString	  Buffer;
  int		  ArrayIndex;
  
	/* Clear the current list */
  m_CellRefList.DeleteAllItems();
  if (m_pRecInfo == NULL) return;
  
	/* Add all existing cell references to the list */
  while (pCell != NULL) {
    pCellRef = (CEsmSubCellRef *) pCell->FindFirst(MWESM_SUBREC_CREF, ArrayIndex);

    while (pCellRef != NULL) {
      pCellRefData = FindOldCellRef(pCellRef);

      if (pCellRefData == NULL) {
        m_CellRefList.AddItem(pCellRef);
       }
      else if (pCellRefData->Type == ESMCELLREF_MODTYPE_CLEAN) {
       }
      else if (pCellRefData->Type == ESMCELLREF_MODTYPE_DEL) {
        m_CellRefList.AddItem(pCellRefData->pNewCellRef);
       }
      else if (pCellRefData->Type == ESMCELLREF_MODTYPE_MOD) {
        m_CellRefList.AddItem(pCellRefData->pNewCellRef);
       }
      else if (pCellRefData->Type == ESMCELLREF_MODTYPE_NEW) {
        m_CellRefList.AddItem(pCellRefData->pNewCellRef);
       }

      pCellRef = (CEsmSubCellRef *) pCell->FindNext(MWESM_SUBREC_CREF, ArrayIndex);
     }

    pCell = (CEsmCell *) pCell->GetPrevRecord();
   }

	/* Add any new cell references */
  for (ArrayIndex = 0; ArrayIndex < m_ModCellRefs.GetNumElements(); ArrayIndex++) {
    pCellRefData = m_ModCellRefs.GetAt(ArrayIndex);

    if (pCellRefData->Type == ESMCELLREF_MODTYPE_NEW) {
      m_CellRefList.AddItem(pCellRefData->pNewCellRef);
     }
    else if (pCellRefData->IsNew) {
      m_CellRefList.AddItem(pCellRefData->pNewCellRef);
     }
   }

 }
/*===========================================================================
 *		End of Class Method CEsmRefCellPage::UpdateCellRefList()
 *=========================================================================*/

