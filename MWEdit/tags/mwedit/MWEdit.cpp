/*===========================================================================
 *
 * File:	MWEdit.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Monday, 03 February, 2003
 *
 * Defines the class behaviors for the application.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "MainFrm.h"
#include "ChildFrm.h"
#include "MWEditDoc.h"
#include "MWEditView.h"
#include "dl_err.h"
#include "OpenPluginDlg.h"
#include "EsmListCtrl.h"
#include "EsmUtils.h"
#include "dl_err.h"
#include "il/il.h"
#include "dl_math.h"
#include "ChildFrmFix.h"
#include "ChildFrmVar.h"
#include "ChildFrm.h"
#include "resource.h"
#include "EsmScriptCompile.h"


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
  CMWEditApp theApp;

  DEFINE_FILE("MWEdit.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CMWEditApp Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CMWEditApp, CWinApp)
  //{{AFX_MSG_MAP(CMWEditApp)
  ON_COMMAND(ID_APP_ABOUT, OnAppAbout)
  //}}AFX_MSG_MAP

	/* Standard file based document commands */
  ON_COMMAND(ID_FILE_NEW,  CWinApp::OnFileNew)
  ON_COMMAND(ID_FILE_OPEN, CMWEditApp::OnFileOpen)

END_MESSAGE_MAP()
/*===========================================================================
 *		End of CMWEditApp Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditApp Constructor
 *
 *=========================================================================*/
CMWEditApp::CMWEditApp() : m_EsmMasters(0) {
  m_hFuncHelpView = NULL;
  m_pFuncHelpView = NULL;
  m_NonameCount = 0;
 }
/*===========================================================================
 *		End of Class CMWEditApp Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditApp Destructor
 *
 *=========================================================================*/
CMWEditApp::~CMWEditApp() {
  ErrorHandler.Destroy();
  ErrorDatabase.Destroy();
  g_CustomFunctions.Destroy();
  
  ClearFileArray();

	/* Ensure all child windows are closed */
  if (IsWindow(m_hFuncHelpView)) CloseWindow(m_hFuncHelpView);
 }
/*===========================================================================
 *		End of Class CMWEditApp Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditApp Method - bool AddFindHistory (pString);
 *
 * Saves a new find history string to the registry.
 *
 *=========================================================================*/
bool CMWEditApp::AddFindHistory (const TCHAR* pString) { 
  CString LastFind = pString;
  CString TempFind;
  CString RegName;
  int     Result;
  int	  Index;

	/* See if the find string already exists */
  Result = FindFindHistory (pString);
  if (Result >= 0) return (false);

	/* Shift all existing find history records and add the new one */
  for (Index = 0; Index < ESMSCR_FINDHISTORY_NUMRECORDS; Index++) {

		/* Get the existing record at the current location */
    RegName.Format(_T("%s%d"), ESMSCR_REGENTRY_FIND, Index);
    TempFind = AfxGetApp()->GetProfileString(ESMSCR_REGSEC_FINDHISTORY, RegName, NULL);

		/* Store the previous find element to the registry */
    AfxGetApp()->WriteProfileString(ESMSCR_REGSEC_FINDHISTORY, RegName, LastFind);
    if (TempFind.IsEmpty()) break;  
    LastFind = TempFind;
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMWEditApp::AddFindHistory()
 *=========================================================================*/
 

/*===========================================================================
 *
 * Class CMWEditApp Method - void ClearFileArray (void);
 *
 *=========================================================================*/
void CMWEditApp::ClearFileArray (void) {
  CEsmFile* pFile;
  int	    Index;

  for (Index = 0; Index < m_EsmMasters.GetSize(); Index++) {
    pFile = m_EsmMasters.GetAt(Index);
    DestroyPointer(pFile);
   }

  m_EsmMasters.RemoveAll();
 }
/*===========================================================================
 *		End of Class Method CMWEditApp::ClearFileArray()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditApp Method - int FindFindHistory (pString);
 *
 * Returns the index of the given find string currently exists in the 
 * find history. Returns -1 if it was not found.
 *
 *=========================================================================*/
int CMWEditApp::FindFindHistory (const TCHAR* pString) {
  CString RegName;
  CString Buffer;
  int	  Index;

	/* Look through all existing find history records */
  for (Index = 0; Index < ESMSCR_FINDHISTORY_NUMRECORDS; Index++) {

		/* Find the existing record at the current location */
    RegName.Format(_T("%s%d"), ESMSCR_REGENTRY_FIND, Index);
    Buffer = AfxGetApp()->GetProfileString(ESMSCR_REGSEC_FINDHISTORY, RegName, NULL);
    if (Buffer.IsEmpty()) break;

		/* Does the find string match? */
    if (Buffer.CompareNoCase(pString) == 0) return (Index);
   }

	/* No match found */
  return (-1);
 }
/*===========================================================================
 *		End of Class Method CMWEditApp::FindFindHistory()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditApp Method - CEsmFile* FindMaster (pPathname);
 *
 *=========================================================================*/
CEsmFile* CMWEditApp::FindMaster (const TCHAR *pPathname) {
  const TCHAR*	pFilename = FindFilename(pPathname);
  CEsmFile*	pFile;
  int		Index;

  for (Index = 0; Index < m_EsmMasters.GetSize(); Index++) {
    pFile = m_EsmMasters.GetAt(Index);
    if (TSTRICMP(FindFilename(pFile->GetFilename()), pFilename) == 0) return (pFile);
   }

  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CMWEditApp::FindMaster()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditApp Method - BOOL InitInstance ();
 *
 * Description
 *
 *=========================================================================*/
BOOL CMWEditApp::InitInstance() {
  AfxEnableControlContainer();
  AfxInitRichEdit();
  SystemLog.Open("mwedit.log");

/*  int Index;
  int RandomValue;
  int RandCount[101];
  memset(RandCount, 0, sizeof(int)*101);
  
  for (Index = 0; Index < 1000000; Index++) {
    RandomValue = Random(100);
    RandCount[RandomValue]++;
   }

  int Total = 0;
  for (Index = 0; Index < 101; Index++) {
    SystemLog.Printf ("%3d = %d", Index, RandCount[Index]);
    Total += RandCount[Index];
   }

  SystemLog.Printf ("Total = %d", Total); //*/

	/* Attempt to load the default function help definitions */
  m_FunctionArray.LoadDefault();

	/* Attempt to load the custom function definitions */
  ReadMwCustomFunctions(g_CustomFunctions, MWEDIT_DEFAULT_CUSTOMFUNCS);

#ifdef _AFXDLL
  Enable3dControls();
#else
  Enable3dControlsStatic();
#endif

	/* Initialize the image list */
  m_IconBitmap[ESMLIST_IMAGE_ARMOR].LoadBitmap(IDB_ARMOR);
  m_IconBitmap[ESMLIST_IMAGE_ALCHEMY].LoadBitmap(IDB_ALCHEMY);
  m_IconBitmap[ESMLIST_IMAGE_ACTIVATOR].LoadBitmap(IDB_ACTIVATOR);
  m_IconBitmap[ESMLIST_IMAGE_APPARATUS].LoadBitmap(IDB_APPARATUS);
  m_IconBitmap[ESMLIST_IMAGE_BODYPART].LoadBitmap(IDB_BODYPART);
  m_IconBitmap[ESMLIST_IMAGE_BOOK].LoadBitmap(IDB_BOOK);
  m_IconBitmap[ESMLIST_IMAGE_CLOTHING].LoadBitmap(IDB_CLOTHING);
  m_IconBitmap[ESMLIST_IMAGE_CONTAINER].LoadBitmap(IDB_CONTAINER);
  m_IconBitmap[ESMLIST_IMAGE_CREATURE].LoadBitmap(IDB_CREATURE);
  m_IconBitmap[ESMLIST_IMAGE_DOOR].LoadBitmap(IDB_DOOR);
  m_IconBitmap[ESMLIST_IMAGE_ENCHANT].LoadBitmap(IDB_ENCHANT);
  m_IconBitmap[ESMLIST_IMAGE_INGREDIANT].LoadBitmap(IDB_INGREDIANT);
  m_IconBitmap[ESMLIST_IMAGE_LEVELCREA].LoadBitmap(IDB_LEVELCREA);
  m_IconBitmap[ESMLIST_IMAGE_LEVELITEM].LoadBitmap(IDB_LEVELITEM);
  m_IconBitmap[ESMLIST_IMAGE_LIGHT].LoadBitmap(IDB_LIGHT);
  m_IconBitmap[ESMLIST_IMAGE_LOCKPICK].LoadBitmap(IDB_LOCKPICK);
  m_IconBitmap[ESMLIST_IMAGE_MISC].LoadBitmap(IDB_MISC);
  m_IconBitmap[ESMLIST_IMAGE_NPC].LoadBitmap(IDB_NPC);
  m_IconBitmap[ESMLIST_IMAGE_PROBE].LoadBitmap(IDB_PROBE);
  m_IconBitmap[ESMLIST_IMAGE_REPAIR].LoadBitmap(IDB_REPAIR);
  m_IconBitmap[ESMLIST_IMAGE_SPELL].LoadBitmap(IDB_SPELL);
  m_IconBitmap[ESMLIST_IMAGE_STATIC].LoadBitmap(IDB_STATIC);
  m_IconBitmap[ESMLIST_IMAGE_WEAPON].LoadBitmap(IDB_WEAPON);
  m_IconBitmap[ESMLIST_IMAGE_GLOBAL].LoadBitmap(IDB_GLOBAL);
  m_IconBitmap[ESMLIST_IMAGE_SOUND].LoadBitmap(IDB_SOUND);
  m_IconBitmap[ESMLIST_IMAGE_EFFECT].LoadBitmap(IDB_MAGICEFFECT);
  m_IconBitmap[ESMLIST_IMAGE_DIALOG].LoadBitmap(IDB_DIALOG);
  m_IconBitmap[ESMLIST_IMAGE_SETTING].LoadBitmap(IDB_GAMESETTING);
  m_IconBitmap[ESMLIST_IMAGE_CLASS].LoadBitmap(IDB_CLASS);
  m_IconBitmap[ESMLIST_IMAGE_FACTION].LoadBitmap(IDB_FACTION);
  m_IconBitmap[ESMLIST_IMAGE_RACE].LoadBitmap(IDB_RACE);
  m_IconBitmap[ESMLIST_IMAGE_SKILL].LoadBitmap(IDB_SKILL);
  m_IconBitmap[ESMLIST_IMAGE_SCRIPT].LoadBitmap(IDB_SCRIPT);
  m_IconBitmap[ESMLIST_IMAGE_BIRTHSIGN].LoadBitmap(IDB_BIRTHSIGN);
  m_IconBitmap[ESMLIST_IMAGE_SOUNDGEN].LoadBitmap(IDB_SOUNDGEN);
  m_IconBitmap[ESMLIST_IMAGE_REGION].LoadBitmap(IDB_REGION);
  m_IconBitmap[ESMLIST_IMAGE_CELL].LoadBitmap(IDB_CELL);
  m_IconBitmap[ESMLIST_IMAGE_STARTSCRIPT].LoadBitmap(IDB_STARTSCRIPT);
  
  CEsmListCtrl::m_ImageList.Create(16, 16, ILC_COLOR16, 64, 8);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_ACTIVATOR], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_ALCHEMY], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_APPARATUS], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_ARMOR], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_BODYPART], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_BOOK], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_CLOTHING], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_CONTAINER], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_CREATURE], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_DOOR], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_ENCHANT], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_INGREDIANT], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_LEVELCREA], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_LEVELITEM], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_LIGHT], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_LOCKPICK], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_MISC], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_NPC], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_PROBE], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_REPAIR], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_SPELL], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_STATIC], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_WEAPON], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_GLOBAL], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_SOUND], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_EFFECT], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_DIALOG], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_SETTING], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_CLASS], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_FACTION], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_RACE], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_SKILL], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_SCRIPT], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_BIRTHSIGN], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_SOUNDGEN], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_REGION], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_CELL], (CBitmap *)NULL);
  CEsmListCtrl::m_ImageList.Add(&m_IconBitmap[ESMLIST_IMAGE_STARTSCRIPT], (CBitmap *)NULL);

	/* Initialize the TGA/DDS image library */
  ilInit();

	/* Change the registry key under which our settings are stored. */
  SetRegistryKey(_T("MWEdit"));
  FindMWRegistryPath();

	/* Load standard INI file options (including MRU) */
  LoadStdProfileSettings(0); 

	/* Load the options from the registry */
  m_Options.ReadFromRegistry();

	/* Attempt to initialize the extra file for the script compiler */
  if (m_Options.GetExtraFile()[0] != NULL_CHAR) {
    CEsmScriptCompile::GetExtraFile().Read(m_Options.GetExtraFile());
    CEsmScriptCompile::InitializeExtraRecords();
  }
  
	/* Register document templates */
  CMultiDocTemplate* pDocTemplate;
  pDocTemplate = new CMultiDocTemplate(IDR_MWEDITTYPE,
		RUNTIME_CLASS(CMWEditDoc),
		RUNTIME_CLASS(CChildFrame), /* Custom MDI child frame */
		RUNTIME_CLASS(CMWEditView));
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
  //if (!ProcessShellCommand(cmdInfo)) return FALSE;

	/* The main window has been initialized, so show and update it. */
  pMainFrame->ShowWindow(m_nCmdShow);
  pMainFrame->UpdateWindow();

	/* Display warning dialog */
  pMainFrame->MessageBox(_T("WARNING: This version of MWEdit is a BETA version and still\nhas not been thoroughly tested. Please use caution and backup any\nplugins while editting. View the README.TXT file for more information."), _T("MWEdit Warning"), MB_OK | MB_ICONWARNING);

  return TRUE;
 }
/*===========================================================================
 *		End of Class Method CMWEditApp::InitInstance()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditApp Method - CEsmFile* LoadMaster (pFilename, pLoadDlg);
 *
 * Loads the given master if it is not already loaded and returns the
 * new/existing file pointer.
 *
 *=========================================================================*/
CEsmFile* CMWEditApp::LoadMaster (const TCHAR* pString, CEsmLoadDlg* pLoadDlg) {
  DEFINE_FUNCTION("CMWEditApp::LoadMaster()");
  CEsmFile* pFile;
  bool	    Result;

	/* Find an existing file */
  pFile = FindMaster(pString);

  if (pFile != NULL) {
    pLoadDlg->SetFilename(pString);
    pLoadDlg->SetProgress(100.0f);
    return (pFile);
   }
  
	/* Create a new file */  
  CreatePointer(pFile, CEsmFile);
  m_EsmMasters.Add(pFile);
  pFile->SetMaster(true);

	/* Progress dialog initialization */
  pLoadDlg->SetFilename(pString);
  pLoadDlg->SetSubLabel(_T("Loading..."));
  pLoadDlg->SetProgress(0.0f);
  pFile->SetCallback(g_EsmLoadDlgCallback, (long) pLoadDlg);

	/* Attempt to read the file */
  Result = pFile->Read(pString);

  if (!Result) {
    ErrorHandler.Notify("Master Read Error!");
   }
   
  return (pFile);

 }
/*===========================================================================
 *		End of Class Method CMWEditApp::LoadMaster()
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
  CStatic	m_SiteLink;
  //}}AFX_DATA
  CFont		m_Font;

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CAboutDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

	/* Implementation */
protected:
  //{{AFX_MSG(CAboutDlg)
  afx_msg void OnSitelink();
  virtual BOOL OnInitDialog();
  afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

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
  ON_BN_CLICKED(IDC_SITELINK, OnSitelink)
  ON_WM_CTLCOLOR()
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
  m_Font.CreateFont(9, 0, 0, 0, FW_NORMAL, 0, 1, 0, 
			DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, 
			DEFAULT_QUALITY, DEFAULT_PITCH, _T("MS Sans Serif"));
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
  DDX_Control(pDX, IDC_SITELINK, m_SiteLink);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CAboutDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditApp Event - void OnAppAbout ();
 *
 * Application command to run the about dialog.
 *
 *=========================================================================*/
void CMWEditApp::OnAppAbout() {
  CAboutDlg aboutDlg;
  aboutDlg.DoModal();
 }
/*===========================================================================
 *		End of Class Event CMWEditApp::OnAppAbout()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditApp Method - CDocument* OpenDocumentFile (lpszFileName);
 *
 *=========================================================================*/
CDocument* CMWEditApp::OpenDocumentFile(LPCTSTR lpszFileName) {
  return CWinApp::OpenDocumentFile(lpszFileName);
 }
/*===========================================================================
 *		End of Class Method CMWEditApp::OpenDocumentFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditApp Event - void OnFileOpen (void);
 *
 *=========================================================================*/
void CMWEditApp::OnFileOpen (void) {
  COpenPluginDlg OpenDlg;
  int		 Result;

  ChangeDirectory(GetMWDataPath());
  m_Masters.RemoveAll();
  m_Plugins.RemoveAll();
  m_ActivePlugin.Empty();

  Result = OpenDlg.DoModal();
  if (Result != IDOK) return;

  m_Masters.AddHead(&OpenDlg.GetMasters());
  m_Plugins.AddHead(&OpenDlg.GetPlugins());
  m_ActivePlugin = OpenDlg.GetActivePlugin();

  if (m_ActivePlugin.IsEmpty() && m_Plugins.GetCount() == 0 && m_Masters.GetCount() == 0)
    return;
  else if (!m_ActivePlugin.IsEmpty())
    AfxGetApp()->OpenDocumentFile(m_ActivePlugin);
  else {
    CString Buffer;
    Buffer.Format(_T("noname%d.esp"), m_NonameCount);
    m_NonameCount++;
    AfxGetApp()->OpenDocumentFile(Buffer);
   }

 }
/*===========================================================================
 *		End of Class Event CMWEditApp::OnFileOpen()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditApp Method - void OpenFuncHelpView (void);
 *
 *=========================================================================*/
void CMWEditApp::OpenFuncHelpView (const TCHAR* pFunction) {
  CCreateContext Context;

	/* If the window is already open, just activate it */
  if (IsWindow(m_hFuncHelpView)) {
    m_pFuncHelpView->ActivateFrame(SW_SHOW);
    m_pFuncHelpView->SendMessageToDescendants(MSG_SCRIPTFRM_VIEWERROR, (WPARAM) pFunction, 0);
    return;
   }

	/* Initialize the context structure */
  Context.m_pCurrentDoc     = NULL;
  Context.m_pCurrentFrame   = NULL;
  Context.m_pNewDocTemplate = NULL;
  Context.m_pLastView       = NULL;

	/* Create the dialog parent frame */  
  Context.m_pNewViewClass = RUNTIME_CLASS(CEsmFuncHelpView);
  m_pFuncHelpView = (CFrameWnd*) RUNTIME_CLASS(CChildFrame)->CreateObject();
  ASSERT_KINDOF(CFrameWnd, m_pFuncHelpView);

	/* Create form view new from resource */
  m_pFuncHelpView->LoadFrame(CEsmFuncHelpView::IDD, WS_OVERLAPPEDWINDOW, NULL, &Context);
  if (m_pFuncHelpView == NULL) return;
  m_hFuncHelpView = m_pFuncHelpView->m_hWnd;

	/* Initialize the frameview and display it */
  SetInternalWindowText(m_hFuncHelpView, _T("Function Help"));
  //MessageBox(NULL, "test1", "", MB_OK);
  m_pFuncHelpView->InitialUpdateFrame(NULL, TRUE);
  //MessageBox(NULL, "test2", "", MB_OK);
  m_pFuncHelpView->ActivateFrame(SW_SHOW);
  //MessageBox(NULL, "test3", "", MB_OK);

  if (pFunction != NULL) {
    m_pFuncHelpView->SendMessageToDescendants(MSG_SCRIPTFRM_VIEWERROR, (WPARAM) pFunction, 0);
   }
 }
/*===========================================================================
 *		End of Class Method CMWEditApp::OpenFuncHelpView()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditApp Method - bool ReadFindHistory (Buffer, FindIndex);
 *
 * Attempts to read the given find history entry from the registry.
 * Returns false on any error.
 *
 *=========================================================================*/
bool CMWEditApp::ReadFindHistory (CString& Buffer, const int FindIndex) {
  CString RegName;

  RegName.Format(_T("%s%d"), ESMSCR_REGENTRY_FIND, FindIndex);
  Buffer = AfxGetApp()->GetProfileString(ESMSCR_REGSEC_FINDHISTORY, RegName, NULL);

  return (!Buffer.IsEmpty());
 }
/*===========================================================================
 *		End of Class Method CMWEditApp::ReadFindHistory()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CAboutDlg Event - void OnSitelink ();
 *
 *=========================================================================*/
void CAboutDlg::OnSitelink() {
  OpenWebPage(MWEDIT_WEBPAGE_PROJECT);
 }
/*===========================================================================
 *		End of Class Event CAboutDlg::OnSitelink()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CAboutDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CAboutDlg::OnInitDialog() {
  CDialog::OnInitDialog();
  m_SiteLink.SetFont(&m_Font);
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CAboutDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CAboutDlg Event - HBRUSH OnCtlColor (CDC* pDC, CWnd* pWnd, UINT nCtlColor);
 *
 *=========================================================================*/
HBRUSH CAboutDlg::OnCtlColor (CDC* pDC, CWnd* pWnd, UINT nCtlColor) {
  HBRUSH hBrush = CDialog::OnCtlColor(pDC, pWnd, nCtlColor);
	
  if (pWnd != NULL && pWnd->GetDlgCtrlID() == IDC_SITELINK) {
    SetTextColor(pDC->m_hDC, RGB(0,0,255));
   }

  return (hBrush);
 }
/*===========================================================================
 *		End of Class Event CAboutDlg::OnCtlColor()
 *=========================================================================*/
