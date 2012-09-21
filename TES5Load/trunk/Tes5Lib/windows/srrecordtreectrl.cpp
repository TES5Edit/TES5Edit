/*===========================================================================
 *
 * File:		Srrecordtreectrl.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "SrRecordTreeCtrl.h"


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

  srrectreeoptions_t CSrRecordTreeCtrl::m_Options;

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecordTreeCtrl Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CSrRecordTreeCtrl, CTreeCtrl)
	//{{AFX_MSG_MAP(CSrRecordTreeCtrl)
	ON_WM_RBUTTONDOWN( )
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CSrRecordTreeCtrl Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordTreeCtrl Constructor
 *
 *=========================================================================*/
CSrRecordTreeCtrl::CSrRecordTreeCtrl() {
  m_pRefFilters = NULL;
 }
/*===========================================================================
 *		End of Class CSrRecordTreeCtrl Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordTreeCtrl Destructor
 *
 *=========================================================================*/
CSrRecordTreeCtrl::~CSrRecordTreeCtrl() {
 }
/*===========================================================================
 *		End of Class CSrRecordTreeCtrl Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordTreeCtrl Method - bool CreateItemsFromFilters (void);
 *
 * Creates the tree items from the current filter data. Returns false
 * on any error.
 *
 *=========================================================================*/
bool CSrRecordTreeCtrl::CreateItemsFromFilters (void) {
  CSrRecFilterArray* pFilterArray = GetFilterArray();
  CSrRecordFilter*   pFilter;
  CString	     Buffer;
  HTREEITEM	     hParent;
  HTREEITEM	     hItem;
  dword		     Index;

	/* Clear the current tree */
  DeleteAllItems();

  for (Index = 0; Index < pFilterArray->GetSize(); ++Index) {
    pFilter = pFilterArray->GetAt(Index);

    if (pFilter->GetParent() == NULL) {
      hParent = TVI_ROOT;
     }
    else {
      hParent = (HTREEITEM) pFilter->GetParent()->GetUserData();
     }
    
    if (pFilter->IsFlagEmpty() || !m_Options.EnableCounts)
      Buffer.Format("%s", pFilter->GetDisplayName());
    else
      Buffer.Format("%s (0)", pFilter->GetDisplayName());

    hItem = InsertItem(Buffer, hParent, TVI_LAST);

    if (hItem != NULL) {
      SetItemData(hItem, (DWORD) (void *)pFilter);
      pFilter->SetUserData((dword) hItem);

      if (hParent == TVI_ROOT) SetItemState(hItem, TVIS_BOLD, TVIS_BOLD);
     }
   }

	/* Assume no selection initially */
  SelectItem(NULL);
  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrRecordTreeCtrl::CreateItemsFromFilters()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordTreeCtrl Method - CSrRecordFilter* GetSelectedFilter (void);
 *
 *=========================================================================*/
CSrRecordFilter* CSrRecordTreeCtrl::GetSelectedFilter (void) {
  HTREEITEM hSelItem;

	/* Get the currently selected tree item */
  hSelItem = GetSelectedItem();
  if (hSelItem == NULL) return (NULL);

  return (CSrRecordFilter *) GetItemData(hSelItem);
 }
/*===========================================================================
 *		End of Class Method CSrRecordTreeCtrl::GetSelectedFilter()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordTreeCtrl Method - bool Initialize (pFilename);
 *
 *=========================================================================*/
bool CSrRecordTreeCtrl::Initialize (const SSCHAR* pFilename) {
  bool Result;

  Result  = LoadFilters(pFilename);
  Result &= CreateItemsFromFilters();

  return (Result);
 }
/*===========================================================================
 *		End of Class Method CSrRecordTreeCtrl::Initialize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordTreeCtrl Method - bool Initialize (pFilterArray);
 *
 *=========================================================================*/
bool CSrRecordTreeCtrl::Initialize (CSrRecFilterArray* pFilterArray) {
  bool Result;

  SetRefFilterArray(pFilterArray);
  Result = CreateItemsFromFilters();

  return (Result);
 }
/*===========================================================================
 *		End of Class Method CSrRecordTreeCtrl::Initialize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordTreeCtrl Method - dword IncludeInCounts (pRecord);
 *
 * Includes the given record in any matching filters. Returns the number
 * of count changes.
 *
 *=========================================================================*/
dword CSrRecordTreeCtrl::IncludeInCounts (CSrRecord* pRecord) {
  CSrRecFilterArray* pFilterArray = GetFilterArray();
  CSrRecordFilter*   pFilter;
  CString	     Buffer;
  HTREEITEM	     hItem;
  dword		     Index;
  dword		     Count = 0;
  bool		     Result;

	/* Ignore if not updating counts */
  if (!m_Options.EnableCounts) return (0);

  for (Index = 0; Index < pFilterArray->GetSize(); ++Index) {
    pFilter = pFilterArray->GetAt(Index);
    hItem   = (HTREEITEM) pFilter->GetUserData();

    if (hItem == NULL)          continue;
    if (pFilter->IsFlagEmpty()) continue;

    Result = pFilter->CheckRecord(pRecord, m_ExtraFilter);

    if (Result) {
      pFilter->ModRecordCount(1);
      ++Count;
      UpdateItemText(hItem, pFilter);
    }
    
  }

  return (Count);
}
/*===========================================================================
 *		End of Class Method CSrRecordTreeCtrl::IncludeInCounts()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordTreeCtrl Method - dword RemoveFromCounts (CSrRecord* pRecord);
 *
 * Removes the given record in any matching filters. Returns the number
 * of count changes.
 *
 *=========================================================================*/
dword CSrRecordTreeCtrl::RemoveFromCounts (CSrRecord* pRecord) {
  CSrRecFilterArray* pFilterArray = GetFilterArray();
  CSrRecordFilter*   pFilter;
  CString	     Buffer;
  HTREEITEM	     hItem;
  dword		     Index;
  dword		     Count = 0;
  bool		     Result;

  	/* Ignore if not updating counts */
  if (!m_Options.EnableCounts) return (0);

  for (Index = 0; Index < pFilterArray->GetSize(); ++Index) {
    pFilter = pFilterArray->GetAt(Index);
    hItem   = (HTREEITEM) pFilter->GetUserData();

    if (hItem == NULL)          continue;
    if (pFilter->IsFlagEmpty()) continue;

    Result = pFilter->CheckRecord(pRecord, m_ExtraFilter);

    if (Result) {
      pFilter->ModRecordCount(-1);
      ++Count;
      UpdateItemText(hItem, pFilter);
    }
    
  }

  return (Count);
}
/*===========================================================================
 *		End of Class Method CSrRecordTreeCtrl::RemoveFromCounts()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordTreeCtrl Event - void OnRButtonDown (nFlags, Point);
 *
 *=========================================================================*/
void CSrRecordTreeCtrl::OnRButtonDown (UINT nFlags, CPoint Point) {
  HTREEITEM hItem;
  
	/* Select item on right-click */
  hItem = HitTest(Point, NULL);
  if (hItem != NULL) SelectItem(hItem);

  CTreeCtrl::OnRButtonDown(nFlags, Point);
}
/*===========================================================================
 *		End of Class Event CSrRecordTreeCtrl::OnRButtonDown()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordTreeCtrl Method - HTREEITEM SelectFromFilterID (pID);
 *
 * Finds, selects and returns the tree item with the given filter
 * ID. Returns NULL if the item is not found.
 *
 *=========================================================================*/
HTREEITEM CSrRecordTreeCtrl::SelectFromFilterID (const SSCHAR* pID) {
  CSrRecFilterArray* pFilterArray = GetFilterArray();
  CSrRecordFilter*   pFilter;
  HTREEITEM	     hItem;
  dword		     Index;

  for (Index = 0; Index < pFilterArray->GetSize(); ++Index) {
    pFilter = pFilterArray->GetAt(Index);

    if (stricmp(pFilter->GetID(), pID) == 0) {
      hItem = (HTREEITEM) pFilter->GetUserData();
      Select(hItem, TVGN_CARET);
      return (hItem);
    }
  }

	/* Assume no selection initially */
  return (NULL);
}
/*===========================================================================
 *		End of Class Method CSrRecordTreeCtrl::SelectFromFilterID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordTreeCtrl Method - void UpdateFilterCounts (File);
 *
 *=========================================================================*/
void CSrRecordTreeCtrl::UpdateFilterCounts (CSrEspFile& File) 
{
	UpdateFilterCounts(&File.GetRecords());
}
/*===========================================================================
 *		End of Class Method CSrRecordTreeCtrl::UpdateFilterCounts()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordTreeCtrl Method - void UpdateFilterCounts (pTopGroup);
 *
 *=========================================================================*/
void CSrRecordTreeCtrl::UpdateFilterCounts (CSrGroup* pTopGroup) 
{
  CSrRecFilterArray* pFilterArray = GetFilterArray();
  CSrRecordFilter*   pFilter;
  CString	     Buffer;
  HTREEITEM	     hItem;
  dword		     Index;
  dword		     Count;

  	/* Ignore if not updating counts */
  if (!m_Options.EnableCounts) return;

  for (Index = 0; Index < pFilterArray->GetSize(); ++Index) {
    pFilter = pFilterArray->GetAt(Index);
    hItem   = (HTREEITEM) pFilter->GetUserData();
    if (hItem == NULL) continue;

    if (pFilter->IsFlagEmpty()) continue;

    Count = pFilter->CountMatchingRecords(pTopGroup, m_ExtraFilter);
    pFilter->SetRecordCount(Count);

    UpdateItemText(hItem, pFilter);
  }

}
/*===========================================================================
 *		End of Class Method CSrRecordTreeCtrl::UpdateFilterCounts()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordTreeCtrl Method - void UpdateItemText (hItem, pFilter);
 *
 * Helper function to update tree item text.
 *
 *=========================================================================*/
void CSrRecordTreeCtrl::UpdateItemText (HTREEITEM hItem, CSrRecordFilter* pFilter) {
  static CString s_Buffer;
  
  if (!m_Options.EnableCounts || pFilter->IsFlagEmpty())
    s_Buffer.Format("%s", pFilter->GetDisplayName());
  else
    s_Buffer.Format("%s (%d)", pFilter->GetDisplayName(), pFilter->GetRecordCount());
    
  SetItemText(hItem, s_Buffer);
}
/*===========================================================================
 *		End of Class Method CSrRecordTreeCtrl::UpdateItemText()
 *=========================================================================*/
