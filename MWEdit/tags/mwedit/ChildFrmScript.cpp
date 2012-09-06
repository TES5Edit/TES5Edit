/*===========================================================================
 *
 * File:	Childfrmscript.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 3, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "childfrmscript.h"
#include "ScriptErrorView.h"
#include "EsmScriptDlg.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *misc_dwrv_Ark_key00
 *=========================================================================*/

	/* Debug defines */
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif

  IMPLEMENT_DYNCREATE(CChildFrmScript, CMDIChildWnd);
  DEFINE_FILE("Childfrmscript.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CChildFrmScript Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CChildFrmScript, CMDIChildWnd)
  //{{AFX_MSG_MAP(CChildFrmScript)
  ON_MESSAGE(MSG_SCRIPTFRM_CLEARERROR,  OnClearError)
  ON_MESSAGE(MSG_SCRIPTFRM_UPDATEERROR, OnUpdateError)
  ON_MESSAGE(MSG_SCRIPTFRM_GOTOLINE, OnGotoError)
  ON_WM_SIZE()
  ON_WM_MOVE()
  ON_WM_CLOSE()
  ON_WM_KILLFOCUS()
  ON_WM_MDIACTIVATE()
  ON_WM_SYSCOMMAND()
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CChildFrmScript Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrmScript Constructor
 *
 *=========================================================================*/
CChildFrmScript::CChildFrmScript() {
  m_pErrorView  = NULL;
  m_pScriptView = NULL;
  m_Created = false;
  m_IsFakeMaximized = false;
}
/*===========================================================================
 *		End of Class CChildFrmScript Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrmScript Destructor
 *
 *=========================================================================*/
CChildFrmScript::~CChildFrmScript() {
  m_Created = false;
 }
/*===========================================================================
 *		End of Class CChildFrmScript Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrmScript Event - BOOL OnCreateClient (CreateStruct, pContext);
 *
 *=========================================================================*/
BOOL CChildFrmScript::OnCreateClient(LPCREATESTRUCT, CCreateContext* pContext) {
  m_Created = false;

	/* Create a splitter with 2 rows, 1 column */
  if (!m_wndSplitter.CreateStatic(this, 2, 1)) {
    TRACE0("Failed to CreateStaticSplitter\n");
    return FALSE;
   }

	/* Add the first splitter pane - the default view in row 0 */
  if (!m_wndSplitter.CreateView(0, 0, pContext->m_pNewViewClass, CSize(0, 100), pContext)) {
    TRACE0("Failed to create first pane\n");
    return FALSE;
    }

	/* Add the second splitter pane - an error list view in row 1 */
  if (!m_wndSplitter.CreateView(1, 0, RUNTIME_CLASS(CScriptErrorView), CSize(0, 50), pContext)) {
    TRACE0("Failed to create second pane\n");
    return FALSE;
   }

	/* Initialize the splitter areas */
  m_wndSplitter.SetRowInfo(0, 351, 0);
  m_wndSplitter.SetRowInfo(1, 51, 0);
  m_wndSplitter.RecalcLayout();
  m_wndSplitter.SetScrollStyle(0);

  m_pErrorView  = (CScriptErrorView *) m_wndSplitter.GetPane(1, 0);
  m_pScriptView = (CEsmScriptDlg *)    m_wndSplitter.GetPane(0, 0);
  ASSERT(m_pErrorView->IsKindOf(RUNTIME_CLASS(CScriptErrorView)));
  ASSERT(m_pScriptView->IsKindOf(RUNTIME_CLASS(CEsmScriptDlg)));
  
	/* Activate the default view */
  SetActiveView((CView *)m_wndSplitter.GetPane(0,0));
  //m_wndSplitter.SetWindowPos(NULL, 0, 0, 640, 400, SWP_NOMOVE | SWP_NOZORDER);

  m_Created = true;
  return TRUE;
 }
/*===========================================================================
 *		End of Class Event CChildFrmScript::OnCreateClient()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrmScript Event - LRESULT OnClearError (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CChildFrmScript::OnClearError (LPARAM lParam, WPARAM wParam) {
  if (m_pErrorView != NULL) m_pErrorView->ClearErrors();
  return (0);
 }
/*===========================================================================
 *		End of Class Event CChildFrmScript::OnClearError()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrmScript Event - void OnClose (void);
 *
 *=========================================================================*/
void CChildFrmScript::OnClose (void) {
  DestroyWindow();
 }
/*===========================================================================
 *		End of Class Event CChildFrmScript::OnClose()
 *=========================================================================*/
  

/*===========================================================================
 *
 * Class CChildFrmScript Event - LRESULT OnGotoError (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CChildFrmScript::OnGotoError (LPARAM lParam, WPARAM wParam) {
  SetActiveView((CView *)m_wndSplitter.GetPane(0,0));
  CWnd* pWnd = m_wndSplitter.GetPane(0, 0);
  if (pWnd != NULL) pWnd->SendMessage(MSG_SCRIPTFRM_GOTOLINE, lParam, wParam);
  return (0);
 }
/*===========================================================================
 *		End of Class Event CChildFrmScript::OnGotoError()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrmScript Event - void OnKillFocus (pWnd);
 *
 *=========================================================================*/
void CChildFrmScript::OnKillFocus(CWnd* pWnd) {
  if (m_pScriptView != NULL) m_pScriptView->CloseToolTips();
  CMDIChildWnd::OnKillFocus(pWnd);
 }
/*===========================================================================
 *		End of Class Event CChildFrmScript::OnKillFocus()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrmScript Event - void OnMDIActivate (bActivate, pActivateWnd, pDeactivateWnd);
 *
 *=========================================================================*/
void CChildFrmScript::OnMDIActivate(BOOL bActivate, CWnd* pActivateWnd, CWnd* pDeactivateWnd) {
  if (m_pScriptView != NULL) m_pScriptView->CloseToolTips();
  CMDIChildWnd::OnMDIActivate(bActivate, pActivateWnd, pDeactivateWnd);
 }
/*===========================================================================
 *		End of Class Event CChildFrmScript::OnMDIActivate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrmScript Event - void OnMove (cx, cy);
 *
 *=========================================================================*/
void CChildFrmScript::OnMove(int cx, int cy) {
  if (m_pScriptView != NULL) m_pScriptView->CloseToolTips();
  CMDIChildWnd::OnMove(cx, cy);
 }
/*===========================================================================
 *		End of Class Event CChildFrmScript::OnMove()
 *=========================================================================*/



/*===========================================================================
 *
 * Class CChildFrmScript Event - void OnSize (nType, cx, cy);
 *
 *=========================================================================*/
void CChildFrmScript::OnSize(UINT nType, int cx, int cy) {
  CRect WndRect;
  CRect OldRect;
  CRect WndRect1;
  CRect WndRect2;
  float Ratio;
  
  m_IsFakeMaximized = false;
  m_wndSplitter.GetWindowRect(&OldRect);
  if (m_pErrorView != NULL)  m_pErrorView->GetWindowRect(&WndRect2);
  if (m_pScriptView != NULL) m_pScriptView->GetWindowRect(&WndRect1);

  CMDIChildWnd::OnSize(nType, cx, cy);
  if (!m_Created) return;

  m_wndSplitter.GetWindowRect(&WndRect);

  if (WndRect1.Height() != 0) {
    Ratio = (float) OldRect.Height() / (float) WndRect1.Height();
    //m_pScriptView->SetWindowPos(NULL, 0, 0, WndRect.Width(), WndRect.Height() / Ratio, SWP_NOZORDER | SWP_NOMOVE);
    m_wndSplitter.SetRowInfo(0, (int) (WndRect.Height() / Ratio), 0);
   }

  m_wndSplitter.RecalcLayout();
 }
/*===========================================================================
 *		End of Class Event CChildFrmScript::OnSize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrmScript Event - LRESULT OnUpdateError (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CChildFrmScript::OnUpdateError (LPARAM lParam, WPARAM wParam) {
  if (m_pErrorView != NULL) m_pErrorView->UpdateErrors((CEsmScriptErrArray *)lParam);
  return (0);
 }
/*===========================================================================
 *		End of Class Event CChildFrmScript::OnUpdateError()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrmScript Method - BOOL PreCreateWindow (cs);
 *
 *=========================================================================*/
BOOL CChildFrmScript::PreCreateWindow (CREATESTRUCT& cs) {
  cs.style &= ~WS_MAXIMIZE;
  if( !CMDIChildWnd::PreCreateWindow(cs) ) return FALSE;

  return TRUE;
}
/*===========================================================================
 *		End of Class Method CChildFrmScript::PreCreateWindow()
 *=========================================================================*/

 
/*===========================================================================
 *
 * Class CChildFrmScript Method - void FakeMaximize (void);
 *
 *=========================================================================*/
void CChildFrmScript::FakeMaximize (void) {
  CRect ClientRect;
  CRect RestoreRect;

  if (m_IsFakeMaximized) {
    SetWindowPos(NULL, m_RestoreRect.left, m_RestoreRect.top, m_RestoreRect.Width(), m_RestoreRect.Height(), SWP_NOZORDER);
    m_IsFakeMaximized = false;
  }
  else {
    if (IsIconic()) {
      ShowWindow(SW_RESTORE);
    }

    GetWindowRect(&RestoreRect);
    GetParent()->ScreenToClient(&RestoreRect);

    GetParent()->GetClientRect(&ClientRect);
    SetWindowPos(NULL, 0, 0, ClientRect.Width(), ClientRect.Height(), SWP_NOZORDER);

    m_IsFakeMaximized = true;
    m_RestoreRect = RestoreRect;
  }

}
/*===========================================================================
 *		End of Class Method CChildFrmScript::FakeMaximize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrmScript Event - void OnSysCommand (nID, Param);
 *
 *=========================================================================*/
void CChildFrmScript::OnSysCommand (UINT nID, LPARAM Param) {

  if ((nID & 0xFFF0) == SC_MAXIMIZE) {
    FakeMaximize();
    return;
  }
  else if ((nID & 0xFFF0) == SC_MINIMIZE) {
    m_IsFakeMaximized = false;
  }

  CMDIChildWnd::OnSysCommand(nID, Param);
}
/*===========================================================================
 *		End of Class Event CChildFrmScript::OnSysCommand()
 *=========================================================================*/
