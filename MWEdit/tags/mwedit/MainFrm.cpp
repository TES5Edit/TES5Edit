/*===========================================================================
 *
 * File:	MainFrm.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Wednesday, July 03, 2002
 *
 * Implementation of the CMainFrame class.
 *
 * 24 September 2003
 *	- Added the GetActiveMainView().
 *	- Added the event methods for handling 'global' CMWEditView events.
 *	- Added the events for opening the various web page links.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "MainFrm.h"
#include "EsmOptionsDlg.h"
#include "MWEditView.h"


/*===========================================================================
 *
 * Local Definitions
 *
 *=========================================================================*/

	/* Debug defines */
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif

	/* Status bar setup */
  static UINT indicators[] = {
	ID_SEPARATOR,
	ID_INDICATOR_CAPS,
	ID_INDICATOR_NUM,
	ID_INDICATOR_SCRL,
   };

  IMPLEMENT_DYNAMIC(CMainFrame, CMDIFrameWnd);
  DEFINE_FILE("MainFrm.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CMainFrame, CMDIFrameWnd)
  //{{AFX_MSG_MAP(CMainFrame)
  ON_WM_CREATE()
  ON_COMMAND(ID_HELP_FUNCTIONS, OnHelpFunctions)
  ON_COMMAND(ID_VIEW_OPTIONS, OnViewOptions)
  ON_COMMAND(ID_EDIT_FINDTEXT, OnEditFindtext)
  ON_COMMAND(ID_EDIT_PLUGININFO, OnEditPluginInfo)  
  ON_COMMAND(ID_HELP_SUBMITBUG, OnHelpSubmitbug)
  ON_COMMAND(ID_HELP_SUBMITFEATURE, OnHelpSubmitfeature)
  ON_COMMAND(ID_HELP_LINKS_SOURCEFORGE, OnHelpLinksSourceforge)
  ON_COMMAND(ID_HELP_EMAIL, OnHelpEmail)
  ON_COMMAND(ID_HELP_ITEMINDEX, OnHelpItemindex)
  ON_COMMAND(ID_APP_ABOUT, OnHelpAbout)
  ON_COMMAND(ID_HELP_LINKS_UESPTES3MOD, OnHelpLinksUesptes3mod)
  //}}AFX_MSG_MAP

  ON_COMMAND(ID_HELP_FINDER, CMDIFrameWnd::OnHelpFinder)
  ON_COMMAND(ID_HELP, CMDIFrameWnd::OnHelp)
  ON_COMMAND(ID_CONTEXT_HELP, CMDIFrameWnd::OnContextHelp)
  ON_COMMAND(ID_DEFAULT_HELP, CMDIFrameWnd::OnHelpFinder)
END_MESSAGE_MAP()
/*===========================================================================
 *		End of Class CMainFrame Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Constructor
 *
 *=========================================================================*/
CMainFrame::CMainFrame() {
  m_hItemHelp = NULL;
 }
/*===========================================================================
 *		End of Class CMainFrame Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Destructor
 *
 *=========================================================================*/
CMainFrame::~CMainFrame() {
 }
/*===========================================================================
 *		End of Class CMainFrame Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Method - CView* GetActiveMainView (void);
 *
 * Attempt to find the current CMWEditView object which is returned.
 * NULL is returned if it is not found.
 *
 *=========================================================================*/
CView* CMainFrame::GetActiveMainView (void) {
  CMDIChildWnd* pActiveWnd = MDIGetActive();
  CView*	pView;
  POSITION	ViewPos;
  CDocument*	pDoc;  
  
	/* Ensure there is an active child window, view, and document */
  if (pActiveWnd == NULL) return (NULL);
  CView* pActiveView = pActiveWnd->GetActiveView();
  if (pActiveView == NULL) return (NULL);
  pDoc = pActiveView->GetDocument();
  if (pDoc == NULL) return (NULL);

	/* Find the 'main' view in the list of current document views */
  ViewPos = pDoc->GetFirstViewPosition();

  while (ViewPos != NULL) {
    pView = pDoc->GetNextView(ViewPos);
    if (pView->IsKindOf(RUNTIME_CLASS(CMWEditView))) return (pView);
   }

	/* No matching view found */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CMainFrame::GetActiveMainView()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Event - int OnCreate (lpCreateStruct);
 *
 *=========================================================================*/
int CMainFrame::OnCreate (LPCREATESTRUCT lpCreateStruct) {

	/* Call the base class create method first */
  if (CMDIFrameWnd::OnCreate(lpCreateStruct) == -1) return (-1);

  if (!m_wndToolBar.CreateEx(this, TBSTYLE_FLAT, WS_CHILD | WS_VISIBLE | CBRS_TOP
		| CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC) ||
		!m_wndToolBar.LoadToolBar(IDR_MAINFRAME)) {
    TRACE0("Failed to create toolbar\n");
    return (-1);
   }

  if (!m_wndStatusBar.Create(this) || !m_wndStatusBar.SetIndicators(indicators,
		  sizeof(indicators)/sizeof(UINT))) {
    TRACE0("Failed to create status bar\n");
    return (-1);
   }

  m_wndToolBar.EnableDocking(CBRS_ALIGN_ANY);
  EnableDocking(CBRS_ALIGN_ANY);
  DockControlBar(&m_wndToolBar);

  return (0);
 }
/*===========================================================================
 *		End of Class Event CMainFrame::OnCreate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Method - BOOL PreCreateWindow (cs);
 *
 *=========================================================================*/
BOOL CMainFrame::PreCreateWindow (CREATESTRUCT& cs) {
  if( !CMDIFrameWnd::PreCreateWindow(cs) ) return FALSE;
  return TRUE;
 }
/*===========================================================================
 *		End of Class Method CMainFrame::PreCreateWindow()
 *=========================================================================*/


#ifdef _DEBUG
/*===========================================================================
 *
 * Class CMainFrame Diagnostics
 *
 *=========================================================================*/
void CMainFrame::AssertValid() const {
  CMDIFrameWnd::AssertValid();
 }

void CMainFrame::Dump(CDumpContext& dc) const {
  CMDIFrameWnd::Dump(dc);
 }
/*===========================================================================
 *		End of Class CMainFrame Diagnostics
 *=========================================================================*/
#endif


/*===========================================================================
 *
 * Class CMainFrame Event - void OnEditFindtext ();
 *
 *=========================================================================*/
void CMainFrame::OnEditFindtext () {
  CView* pView = GetActiveMainView();
  if (pView != NULL) pView->SendMessage(WM_COMMAND, ID_EDIT_FINDTEXT, 0);
 }
/*===========================================================================
 *		End of Class Event CMainFrame::OnEditFindtext()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Event - void OnEditPluginInfo ();
 *
 *=========================================================================*/
void CMainFrame::OnEditPluginInfo () {
  CView* pView = GetActiveMainView();
  if (pView != NULL) pView->SendMessage(WM_COMMAND, ID_EDIT_PLUGININFO, 0);
 }
/*===========================================================================
 *		End of Class Event CMainFrame::OnEditPluginInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Event - void OnHelpAbout ();
 *
 *=========================================================================*/
void CMainFrame::OnHelpAbout() {
  CDialog dlg(IDD_ABOUTBOX);
  dlg.DoModal();
 }
/*===========================================================================
 *		End of Class Event CMainFrame::OnHelpAbout()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Event - void OnHelpEmail ();
 *
 *=========================================================================*/
void CMainFrame::OnHelpEmail() {
  OpenWebPage(MWEDIT_EMAIL_DEVELOPER);
 }
/*===========================================================================
 *		End of Class Event CMainFrame::OnHelpEmail()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Event - void OnHelpFunctions ();
 *
 *=========================================================================*/
void CMainFrame::OnHelpFunctions() {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  pApp->OpenFuncHelpView();
 }
/*===========================================================================
 *		End of Class Event CMainFrame::OnHelpFunctions()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Event - void OnHelpItemindex ();
 *
 *=========================================================================*/
void CMainFrame::OnHelpItemindex() {
  HWND hWnd = NULL;

	/* Activate a currently open window, if any */
  //if (m_hItemHelp != NULL) hWnd = FindWindowHandle(m_hItemHelp);
  hWnd = ::FindWindow(NULL, MWEDIT_FILE_ITEMHELPTITLE);

  if (hWnd != NULL) 
    ::SetForegroundWindow(hWnd);
  else
    m_hItemHelp = OpenWebPage(MWEDIT_FILE_ITEMHELP);
 }
/*===========================================================================
 *		End of Class Event CMainFrame::OnHelpItemindex()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Event - void OnHelpLinksSourceforge ();
 *
 *=========================================================================*/
void CMainFrame::OnHelpLinksSourceforge() {
  OpenWebPage(MWEDIT_WEBPAGE_PROJECT);
 }
/*===========================================================================
 *		End of Class Event CMainFrame::OnHelpLinksSourceforge()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Event - void OnHelpSubmitbug ();
 *
 *=========================================================================*/
void CMainFrame::OnHelpSubmitbug() {
  OpenWebPage(MWEDIT_WEBPAGE_BUG);
 }
/*===========================================================================
 *		End of Class Event CMainFrame::OnHelpSubmitbug()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Event - void OnHelpSubmitfeature ();
 *
 *=========================================================================*/
void CMainFrame::OnHelpSubmitfeature() {
  OpenWebPage(MWEDIT_WEBPAGE_FEATURE);
 }
/*===========================================================================
 *		End of Class Event CMainFrame::OnHelpSubmitfeature()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Event - void OnViewOptions ();
 *
 *=========================================================================*/
void CMainFrame::OnViewOptions() {
  CEsmOptionsDlg OptionsDlg;
  CMWEditApp*    pApp = (CMWEditApp *) AfxGetApp();
  int		 Result;

	/* Initialize and display the options dlg */
  OptionsDlg.SetOptions(pApp->GetOptions());
  Result = OptionsDlg.DoModal();

 }
/*===========================================================================
 *		End of Class Event CMainFrame::OnViewOptions()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMainFrame Event - void OnHelpLinksUesptes3mod ();
 *
 *=========================================================================*/
void CMainFrame::OnHelpLinksUesptes3mod() {
  OpenWebPage(MWEDIT_WEBPAGE_UESPTES3MOD);
}
/*===========================================================================
 *		End of Class Event CMainFrame::OnHelpLinksUesptes3mod()
 *=========================================================================*/
