/*===========================================================================
 *
 * File:	MWRandItem.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Thursday, 22 May, 2003
 *
 * Defines the class behaviors for the application, CMWRandItemApp.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWRandItem.h"
#include "MWRandItemDlg.h"
#include "dl_err.h"


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

	/* The primary application object */
  CMWRandItemApp theApp;
  DEFINE_FILE("MWRandItem.cpp");

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemApp Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CMWRandItemApp, CWinApp)
  //{{AFX_MSG_MAP(CMWRandItemApp)
  //}}AFX_MSG
  ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CMWRandItemApp Message Map
 *=========================================================================*/
	

/*===========================================================================
 *
 * Class CMWRandItemApp Constructor
 *
 *=========================================================================*/
CMWRandItemApp::CMWRandItemApp() {
 }
/*===========================================================================
 *		End of Class CMWRandItemApp Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemApp Method - BOOL InitInstance ();
 *
 *=========================================================================*/
BOOL CMWRandItemApp::InitInstance() {
  AfxEnableControlContainer();
  SystemLog.Open("MWRandItem.log");

	/* Standard initialization */
#ifdef _AFXDLL
  Enable3dControls();
#else
  Enable3dControlsStatic();
#endif


	/* Start and display the dialog modally */
  CMWRandItemDlg dlg;
  m_pMainWnd = &dlg;
  int nResponse = dlg.DoModal();

  if (nResponse == IDOK) {
   }
  else if (nResponse == IDCANCEL) {
   }

	/* Since the dialog has been closed, return FALSE so that we exit the
	 *  application, rather than start the application's message pump. */
  return (FALSE);
 }
/*===========================================================================
 *		End of Class Method CMWRandItemApp::InitInstance()
 *=========================================================================*/


