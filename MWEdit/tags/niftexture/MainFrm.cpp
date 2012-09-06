/*===========================================================================
 *
 * File:	MainFrm.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Wednesday, July 03, 2002
 *
 * Implementation of the CMainFrame class.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "NifTexture.h"
#include "MainFrm.h"
#include "NifCopyDlg.h"


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

  IMPLEMENT_DYNAMIC(CMainFrame, CMDIFrameWnd)
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
	ON_COMMAND(ID_FILE_CREATECOPIES, OnFileCreatecopies)
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
 * Class CMainFrame Event - void OnFileCreatecopies ();
 *
 *=========================================================================*/
void CMainFrame::OnFileCreatecopies() {
  CNifCopyDlg CopyDlg;
  CopyDlg.DoModal();
 }
/*===========================================================================
 *		End of Class Event CMainFrame::OnFileCreatecopies()
 *=========================================================================*/
