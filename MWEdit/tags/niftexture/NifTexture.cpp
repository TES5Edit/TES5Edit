/*===========================================================================
 *
 * File:	NifTexture.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Saturday, 28 December, 2002
 *
 * Defines the class behaviors for the application.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "NifTexture.h"
#include "MainFrm.h"
#include "ChildFrm.h"
#include "NifTextureDoc.h"
#include "NifTextureView.h"

	/* Debug definitions */
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/

	/* Main application object */
  CNifTextureApp theApp;


/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CNifTextureApp Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CNifTextureApp, CWinApp)
  //{{AFX_MSG_MAP(CNifTextureApp)
  ON_COMMAND(ID_APP_ABOUT, OnAppAbout)
  //}}AFX_MSG_MAP

	/* Standard file based document commands */
  ON_COMMAND(ID_FILE_NEW, CWinApp::OnFileNew)
  ON_COMMAND(ID_FILE_OPEN, CWinApp::OnFileOpen)

	/* Standard print setup command */
  ON_COMMAND(ID_FILE_PRINT_SETUP, CWinApp::OnFilePrintSetup)
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CNifTextureApp Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureApp Constructor
 *
 *=========================================================================*/
CNifTextureApp::CNifTextureApp() {
 }
/*===========================================================================
 *		End of Class CNifTextureApp Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureApp Method - CString GetBrowsePath (void);
 *
 * Get the browse path from the registry.
 *
 *=========================================================================*/
CString CNifTextureApp::GetBrowsePath (void) {
  return GetProfileString("Path", "BrowsePath", "");
 }
/*===========================================================================
 *		End of Class Method CNifTextureApp::GetBrowsePath()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureApp Method - void SetBrowsePath (pPath);
 *
 * Save the given path to the registry.
 *
 *=========================================================================*/
void CNifTextureApp::SetBrowsePath (const TCHAR* pPath) {
  WriteProfileString("Path", "BrowsePath", pPath);
 }
/*===========================================================================
 *		End of Class Method CNifTextureApp::SetBrowsePath()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureApp Method - BOOL InitInstance ();
 *
 * Description
 *
 *=========================================================================*/
BOOL CNifTextureApp::InitInstance() {

  AfxEnableControlContainer();


#ifdef _AFXDLL
  Enable3dControls();
#else
  Enable3dControlsStatic();
#endif

	/* Change the registry key under which our settings are stored. */
  SetRegistryKey(_T("NifTexture"));

	/* Load standard INI file options (including MRU) */
  LoadStdProfileSettings(5); 

	/* Register document templates */
  CMultiDocTemplate* pDocTemplate;
  pDocTemplate = new CMultiDocTemplate(IDR_NIFTYPE,
		RUNTIME_CLASS(CNifTextureDoc),
		RUNTIME_CLASS(CChildFrame), /* Custom MDI child frame */
		RUNTIME_CLASS(CNifTextureView));
  AddDocTemplate(pDocTemplate);

	/* Create main MDI Frame window */
  CMainFrame* pMainFrame = new CMainFrame;
  if (!pMainFrame->LoadFrame(IDR_MAINFRAME)) return FALSE;
  m_pMainWnd = pMainFrame;

	/* Enable drag/drop open */
  m_pMainWnd->DragAcceptFiles();

	/* Enable DDE Execute open */
  EnableShellOpen();
  RegisterShellFileTypes(TRUE);

	/* Parse command line for standard shell commands, DDE, file open */
  CCommandLineInfo cmdInfo;
  ParseCommandLine(cmdInfo);

	/* Dispatch commands specified on the command line */
  if (!ProcessShellCommand(cmdInfo)) return FALSE;

	/* The main window has been initialized, so show and update it. */
  pMainFrame->ShowWindow(m_nCmdShow);
  pMainFrame->UpdateWindow();

  return TRUE;
 }
/*===========================================================================
 *		End of Class Method CNifTextureApp::InitInstance()
 *=========================================================================*/




/*===========================================================================
 *
 * Begin Class CAboutDlg Definition
 *
 *=========================================================================*/
class CAboutDlg : public CDialog {

public:
  CAboutDlg();

	/* Dialog Data */
  //{{AFX_DATA(CAboutDlg)
  enum { IDD = IDD_ABOUTBOX };
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CAboutDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

	/* Implementation */
protected:
  //{{AFX_MSG(CAboutDlg)
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP()

 };
/*===========================================================================
 *		End of Class CAboutDlg Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CAboutDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
  //{{AFX_MSG_MAP(CAboutDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of Class CAboutDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CAboutDlg Constructor
 *
 *=========================================================================*/
CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD) {
  //{{AFX_DATA_INIT(CAboutDlg)
  //}}AFX_DATA_INIT
 }
/*===========================================================================
 *		End of Class CAboutDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CAboutDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CAboutDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CAboutDlg)
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CAboutDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureApp Event - void OnAppAbout ();
 *
 * Application command to run the about dialog.
 *
 *=========================================================================*/
void CNifTextureApp::OnAppAbout() {
  CAboutDlg aboutDlg;
  aboutDlg.DoModal();
 }

/*===========================================================================
 *		End of Class Event CNifTextureApp::OnAppAbout()
 *=========================================================================*/
