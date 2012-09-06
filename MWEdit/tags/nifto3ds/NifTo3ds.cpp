/*===========================================================================
 *
 * File:	NifTo3ds.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Saturday, 06 December, 2003
 *
 * Defines the class behaviors for the application, CNifTo3dsApp.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "NifTo3ds.h"
#include "NifTo3dsDlg.h"


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
  CNifTo3dsApp theApp;

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTo3dsApp Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CNifTo3dsApp, CWinApp)
  //{{AFX_MSG_MAP(CNifTo3dsApp)
  //}}AFX_MSG
  ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CNifTo3dsApp Message Map
 *=========================================================================*/
	

/*===========================================================================
 *
 * Class CNifTo3dsApp Constructor
 *
 *=========================================================================*/
CNifTo3dsApp::CNifTo3dsApp() {
 }
/*===========================================================================
 *		End of Class CNifTo3dsApp Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTo3dsApp Method - BOOL InitInstance ();
 *
 *=========================================================================*/
BOOL CNifTo3dsApp::InitInstance() {



  AfxEnableControlContainer();

	/* Standard initialization */
#ifdef _AFXDLL
  Enable3dControls();
#else
  Enable3dControlsStatic();
#endif


	/* Start and display the dialog modally */
  CNifTo3dsDlg dlg;
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
 *		End of Class Method CNifTo3dsApp::InitInstance()
 *=========================================================================*/
