/*===========================================================================
 *
 * File:	ChildFrmFix.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Monday, 03 February, 2003
 *
 * Implementation of the CChildFrameFix class
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "ChildFrmFix.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/

	/* Debug defines */
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif

  IMPLEMENT_DYNCREATE(CChildFrameFix, CMDIChildWnd);
  DEFINE_FILE("ChildFrmFix.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrameFix Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CChildFrameFix, CMDIChildWnd)
  //{{AFX_MSG_MAP(CChildFrameFix)
  ON_WM_SIZE()
  ON_WM_CLOSE()
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CChildFrameFix Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrameFix Constructor
 *
 *=========================================================================*/
CChildFrameFix::CChildFrameFix() {
 }
/*===========================================================================
 *		End of Class CChildFrameFix Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrameFix Destructor
 *
 *=========================================================================*/
CChildFrameFix::~CChildFrameFix() {
 }
/*===========================================================================
 *		End of Class CChildFrameFix Destructor
 *=========================================================================*/


/*===========================================================================
 *		End of Class Event CChildFrameFix::OnCreateClient()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrameFix Method - BOOL PreCreateWindow (cs);
 *
 *=========================================================================*/
BOOL CChildFrameFix::PreCreateWindow (CREATESTRUCT& cs) {
  cs.style &= ~WS_THICKFRAME;
  cs.style &= ~WS_MAXIMIZEBOX;
  if( !CMDIChildWnd::PreCreateWindow(cs) ) return FALSE;
  return TRUE;
 }
/*===========================================================================
 *		End of Class Method CChildFrameFix::PreCreateWindow()
 *=========================================================================*/


#ifdef _DEBUG
/*===========================================================================
 *
 * CChildFrameFix Diagnostics
 *
 *=========================================================================*/
void CChildFrameFix::AssertValid() const {
  CMDIChildWnd::AssertValid();
 }

void CChildFrameFix::Dump(CDumpContext& dc) const {
  CMDIChildWnd::Dump(dc);
 }
/*===========================================================================
 *		End of CChildFrameFix Diagnostics
 *=========================================================================*/
#endif


/*===========================================================================
 *
 * Class CChildFrameFix Event - void OnClose (void);
 *
 *=========================================================================*/
void CChildFrameFix::OnClose(void) {
  DestroyWindow();
 }
/*===========================================================================
 *		End of Class Event CChildFrameFix::OnClose()
 *=========================================================================*/
  

/*===========================================================================
 *
 * Class CChildFrameFix Event - void OnSize (nType, cx, cy);
 *
 *=========================================================================*/
void CChildFrameFix::OnSize(UINT nType, int cx, int cy) {

	/* Cannot maximize this type of frame */
  if (nType == SIZE_MAXIMIZED) {
    CMDIChildWnd::OnSize(SIZE_RESTORED, 200, 200);
   }
  else 
    CMDIChildWnd::OnSize(nType, cx, cy);

 }
/*===========================================================================
 *		End of Class Event CChildFrameFix::OnSize()
 *=========================================================================*/
  

void CChildFrameFix::ActivateFrame(int nCmdShow)
{
	BOOL bVisibleThen = (GetStyle() & WS_VISIBLE) != 0;
	CMDIFrameWnd* pFrameWnd = GetMDIFrame();
	ASSERT_VALID(pFrameWnd);

	// determine default show command
	if (nCmdShow == -1)
	{
		// get maximized state of frame window (previously active child)
		BOOL bMaximized;
		pFrameWnd->MDIGetActive(&bMaximized);

		// convert show command based on current style
		DWORD dwStyle = GetStyle();
		if (bMaximized || (dwStyle & WS_MAXIMIZE))
			nCmdShow = SW_SHOWMAXIMIZED;
		else if (dwStyle & WS_MINIMIZE)
			nCmdShow = SW_SHOWMINIMIZED;
	}

//MessageBox("test1");
	// finally, show the window
	CFrameWnd::ActivateFrame(nCmdShow);
//MessageBox("test2");

	// update the Window menu to reflect new child window
	CMDIFrameWnd* pFrame = GetMDIFrame();
	::SendMessage(pFrame->m_hWndMDIClient, WM_MDIREFRESHMENU, 0, 0);

	// Note: Update the m_bPseudoInactive flag.  This is used to handle the
	//  last MDI child getting hidden.  Windows provides no way to deactivate
	//  an MDI child window.

	BOOL bVisibleNow = (GetStyle() & WS_VISIBLE) != 0;
	if (bVisibleNow == bVisibleThen)
		return;

	if (!bVisibleNow)
	{
		// get current active window according to Windows MDI
		HWND hWnd = (HWND)::SendMessage(pFrameWnd->m_hWndMDIClient,
			WM_MDIGETACTIVE, 0, 0);
		if (hWnd != m_hWnd)
		{
			// not active any more -- window must have been deactivated
			ASSERT(!m_bPseudoInactive);
			return;
		}

		// check next window
		ASSERT(hWnd != NULL);
		pFrameWnd->MDINext();

		// see if it has been deactivated now...
		hWnd = (HWND)::SendMessage(pFrameWnd->m_hWndMDIClient,
			WM_MDIGETACTIVE, 0, 0);
		if (hWnd == m_hWnd)
		{
			// still active -- fake deactivate it
			ASSERT(hWnd != NULL);
			OnMDIActivate(FALSE, NULL, this);
			m_bPseudoInactive = TRUE;   // so MDIGetActive returns NULL
		}
	}
	else if (m_bPseudoInactive)
	{
		// if state transitioned from not visible to visible, but
		//  was pseudo deactivated -- send activate notify now
		OnMDIActivate(TRUE, this, NULL);
		ASSERT(!m_bPseudoInactive); // should get set in OnMDIActivate!
	}
}