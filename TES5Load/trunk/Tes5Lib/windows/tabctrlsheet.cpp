/*===========================================================================
 *
 * File:		Tabctrlsheet.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Implements the CTabCtrlSheet class.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "TabCtrlSheet.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/

	/* Debug definitions */
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CTabCtrlSheet Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CTabCtrlSheet, CTabCtrl)
  //{{AFX_MSG_MAP(CTabCtrlSheet)
  ON_WM_GETDLGCODE()
  ON_WM_SYSCOMMAND()
  ON_NOTIFY_REFLECT(TCN_SELCHANGE, OnSelchange)
  ON_WM_KEYDOWN()
  ON_WM_SIZE()
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CTabCtrlSheet Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CTabCtrlSheet Constructor
 *
 *=========================================================================*/
CTabCtrlSheet::CTabCtrlSheet() {
  m_NumPages    = 0;
  m_AutoResize  = false;
  m_CurrentPage = -1;
 }
/*===========================================================================
 *		End of Class CTabCtrlSheet Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CTabCtrlSheet Destructor
 *
 *=========================================================================*/
CTabCtrlSheet::~CTabCtrlSheet() {
 }
/*===========================================================================
 *		End of Class CTabCtrlSheet Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CTabCtrlSheet Method - bool AddTab (pTitle, pPage);
 *
 * Adds the given page/tab to the end of the tab ctrl.  Returns false on
 * any error.
 *
 *=========================================================================*/
bool CTabCtrlSheet::AddTab (const SSCHAR* pTitle, CPropertyPage* pPage) {
  int Result;

	/* Ensure valid input */
  //assert(pTitle != NULL && pPage != NULL);

	/* Ensure the maximum number of sheets hasn't been reached */
  if (m_NumPages >= TCS_ARRAYSIZE) return (false);

	/* Attempt to add the tab and sheet */
  m_pPages[m_NumPages] = pPage;
  Result = InsertItem(m_NumPages, pTitle);
  if (Result < 0) return (false);

  ++m_NumPages;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CTabCtrlSheet::AddTab()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CTabCtrlSheet Method - void AutoResize (void);
 *
 *=========================================================================*/
void CTabCtrlSheet::AutoResize (void) {
  CRect ParentRect;
  CRect NewSize;

  GetParent()->GetClientRect(&ParentRect);

  NewSize.top    = m_AutoResizeOffset.top;
  NewSize.bottom = m_AutoResizeOffset.bottom + ParentRect.bottom + 19;
  NewSize.right  = m_AutoResizeOffset.right  + ParentRect.right;
  NewSize.left   = m_AutoResizeOffset.left;

  SetWindowPos(NULL, NewSize.left, NewSize.top, NewSize.Width(), NewSize.Height(), SWP_NOZORDER | SWP_NOMOVE );

  AdjustRect(FALSE, &NewSize);

  for (int Index = 0; Index < m_NumPages; ++Index) {
    if (m_pPages[Index] == NULL) continue;
    m_pPages[Index]->SetWindowPos(NULL, 0, 0, NewSize.Width(), NewSize.Height(), SWP_NOZORDER | SWP_NOMOVE);
   }

 }
/*===========================================================================
 *		End of Class Method CTabCtrlSheet::AutoResize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CTabCtrlSheet Method - void DisplayPage (PageIndex);
 *
 * Protected class method which displays the given tab page.  Resizes and
 * repositions the page to fit within the current tab display area.
 *
 *=========================================================================*/
void CTabCtrlSheet::DisplayPage (const int PageIndex) {
  CRect PageRect;

	/* Adjust the size/position of page and display it */
  PageRect = GetPageRect();

  if (m_pPages[PageIndex] != NULL) {
    m_pPages[PageIndex]->SetWindowPos(NULL, PageRect.left, PageRect.top, 
					  PageRect.Width(), PageRect.Height(), SWP_SHOWWINDOW);
   }
 }
/*===========================================================================
 *		End of Class Method CTabCtrlSheet::DisplayPage()
 *=========================================================================*/


CWnd* CTabCtrlSheet::FindChild(const int ControlID)
{
	CWnd* pWnd;

	for (int i = 0; i < m_NumPages; ++i)
	{
		pWnd = m_pPages[i]->GetDlgItem(ControlID);
		if (pWnd != NULL) return pWnd;
	}

	return NULL;
}


/*===========================================================================
 *
 * Class CTabCtrlSheet Method - RECT GetPageRect (void);
 *
 * Returns the coordinates for outputting the tab pages within the tab
 * display area.
 *
 *=========================================================================*/
RECT CTabCtrlSheet::GetPageRect (void) {
  RECT PageRect;

  GetClientRect(&PageRect);
  AdjustRect(FALSE, &PageRect);

  return (PageRect);
 }
/*===========================================================================
 *		End of Class Method CTabCtrlSheet::GetPageRect()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CTabCtrlSheet Event - UINT OnGetDlgCode ();
 *
 *=========================================================================*/
UINT CTabCtrlSheet::OnGetDlgCode() {
  return (CTabCtrl::OnGetDlgCode() | DLGC_WANTTAB | DLGC_WANTALLKEYS);
 }
/*===========================================================================
 *		End of Class Event CTabCtrlSheet::OnGetDlgCode()
*=========================================================================*/


/*===========================================================================
 *
 * Class CTabCtrlSheet Event - void OnSelchange (pNMHDR, pResult);
 *
 *=========================================================================*/
void CTabCtrlSheet::OnSelchange(NMHDR* pNMHDR, LRESULT* pResult) {
  int CurrentTab;

  CurrentTab = GetCurSel();
  SetCurrentPage(CurrentTab);
  	
  *pResult = 0;
 }
/*===========================================================================
 *		End of Class Event CTabCtrlSheet::OnSelchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CTabCtrlSheet Event - void OnSize (nType, cx, cy);
 *
 *=========================================================================*/
void CTabCtrlSheet::OnSize (UINT nType, int cx, int cy) {
  CTabCtrl::OnSize(nType, cx, cy);
 }
/*===========================================================================
 *		End of Class Event CTabCtrlSheet::OnSize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CTabCtrlSheet Method - void SetAutoResizeOffset (void);
 *
 *=========================================================================*/
void CTabCtrlSheet::SetAutoResizeOffset (void) {
  CRect ParentRect;
  CRect ThisRect;

  GetWindowRect(&ThisRect);
  GetParent()->GetClientRect(&ParentRect);

  m_AutoResizeOffset.top    = ThisRect.top;
  m_AutoResizeOffset.bottom = ThisRect.bottom - ParentRect.bottom;
  m_AutoResizeOffset.right  = ThisRect.right  - ParentRect.right;
  m_AutoResizeOffset.left   = ThisRect.left;

//  if (GetParent()->IsKindOf(RUNTIME_CLASS(CSplitterWnd))) {
    //m_AutoResizeOffset.bottom -= 51;
   //}

 }
/*===========================================================================
 *		End of Class Method CTabCtrlSheet::SetAutoResizeOffset()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CTabCtrlSheet Method - bool SetCurrentPage (PageIndex);
 *
 * Change the currently display page.  Updates the display and returns
 * true on success.  Protected class method.
 *
 *=========================================================================*/
bool CTabCtrlSheet::SetCurrentPage (const int PageIndex) {

	/* Ignore if nothing changed */
  if (m_CurrentPage == PageIndex) return (false);

	/* Ensure valid input */
  if (PageIndex >= m_NumPages) return (false);

	/* Hide the currently display page, if any */
  if (m_CurrentPage >= 0 && m_pPages[m_CurrentPage] != NULL) {
    m_pPages[m_CurrentPage]->ShowWindow(SW_HIDE);
   }

	/* Display the new page if required */
  m_CurrentPage = PageIndex;	
  if (m_CurrentPage >= 0) DisplayPage(m_CurrentPage);
  return (true);
 }
/*===========================================================================
 *		End of Class Method CTabCtrlSheet::SetCurrentPage()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CTabCtrlSheet Method - bool SetPage (PageIndex);
 *
 * Sets the currently displayed page and tab to the given 0-based index.
 * Returns true on success.
 *
 *=========================================================================*/
bool CTabCtrlSheet::SetPage (const int PageIndex) {
  int  iResult;
  bool Result;
	
	/* Ensure valid input */
  if (!IsValidPage(PageIndex)) return (false);

  iResult = SetCurSel(PageIndex);
  if (iResult < 0) return (false);

  Result = SetCurrentPage(PageIndex);
  return (Result);
 }
/*===========================================================================
 *		End of Class Method CTabCtrlSheet::SetPage()
 *=========================================================================*/

 

void CTabCtrlSheet::OnSysCommand(UINT nID, LPARAM lParam) {
  CTabCtrl::OnSysCommand(nID, lParam);
 }


void CTabCtrlSheet::OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags) {
  CTabCtrl::OnKeyDown(nChar, nRepCnt, nFlags);
 }
