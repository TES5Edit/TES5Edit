/*===========================================================================
 *
 * File:	ChildFrm.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Saturday, 28 December, 2002
 *
 * Implementation of the CChildFrame class
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "NifTexture.h"
#include "ChildFrm.h"


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

  IMPLEMENT_DYNCREATE(CChildFrame, CMDIChildWnd)
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrame Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CChildFrame, CMDIChildWnd)
  //{{AFX_MSG_MAP(CChildFrame)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CChildFrame Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrame Constructor
 *
 *=========================================================================*/
CChildFrame::CChildFrame() {
 }
/*===========================================================================
 *		End of Class CChildFrame Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrame Destructor
 *
 *=========================================================================*/
CChildFrame::~CChildFrame() {
 }
/*===========================================================================
 *		End of Class CChildFrame Destructor
 *=========================================================================*/


/*===========================================================================
 *		End of Class Event CChildFrame::OnCreateClient()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CChildFrame Method - BOOL PreCreateWindow (cs);
 *
 *=========================================================================*/
BOOL CChildFrame::PreCreateWindow (CREATESTRUCT& cs) {
  if( !CMDIChildWnd::PreCreateWindow(cs) ) return FALSE;

  cs.style = WS_CHILD | WS_VISIBLE | WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU
		| FWS_ADDTOTITLE | WS_MINIMIZEBOX | WS_MAXIMIZEBOX;


  return TRUE;
 }
/*===========================================================================
 *		End of Class Method CChildFrame::PreCreateWindow()
 *=========================================================================*/





#ifdef _DEBUG
/*===========================================================================
 *
 * CChildFrame Diagnostics
 *
 *=========================================================================*/
void CChildFrame::AssertValid() const {
  CMDIChildWnd::AssertValid();
 }

void CChildFrame::Dump(CDumpContext& dc) const {
  CMDIChildWnd::Dump(dc);
 }
/*===========================================================================
 *		End of CChildFrame Diagnostics
 *=========================================================================*/
#endif




