/*===========================================================================
 *
 * File:	MWRandItemDlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Thursday, 22 May, 2003
 *
 * Implementation of the CMWRandItemDlg class.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWRandItem.h"
#include "MWRandItemDlg.h"
#include "esmwinutils.h"
#include "dl_time.h"


/*===========================================================================
 *
 * Local Definitions
 *
 *=========================================================================*/

	/* Debug definitions */
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif

  DEFINE_FILE("MWRandItemDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * CMWRandItemDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CMWRandItemDlg, CDialog)
  //{{AFX_MSG_MAP(CMWRandItemDlg)
  ON_WM_SYSCOMMAND()
  ON_WM_DESTROY()
  ON_WM_PAINT()
  ON_WM_QUERYDRAGICON()
  ON_WM_SIZE()
  ON_COMMAND(ID_FILE_NEW, OnFileNew)
  ON_COMMAND(ID_FILE_SAVE, OnFileSave)
  ON_COMMAND(ID_FILE_EXIT, OnFileExit)
  ON_MESSAGE(MWRI_EVENT_NEWITEMS, OnNewItems)
  ON_COMMAND(ID_TEST_EXPORTESP, OnTestExportesp)
  ON_COMMAND(ID_FILE_LOADBASE, OnFileLoadbase)
  ON_COMMAND(ID_FILE_LOADGROUP, OnFileLoadgroup)
  ON_COMMAND(ID_FILE_SAVEGROUP, OnFileSavegroup)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CMWRandItemDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CAboutDlg Definition
 *
 *=========================================================================*/
class CAboutDlg : public CDialog {
public:

	/* Class constructor */
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
 * CAboutDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
  //{{AFX_MSG_MAP(CAboutDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CAboutDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CAboutDlg Constructor
 *
 *=========================================================================*/
CAboutDlg::CAboutDlg () : CDialog(CAboutDlg::IDD) {
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
void CAboutDlg::DoDataExchange (CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CAboutDlg)
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CAboutDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Constructor
 *
 *=========================================================================*/
CMWRandItemDlg::CMWRandItemDlg(CWnd* pParent) : CDialog(CMWRandItemDlg::IDD, pParent), m_RecInfoArray(1024) {
  //{{AFX_DATA_INIT(CMWRandItemDlg)
  //}}AFX_DATA_INIT
  m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
  m_CreateView.SetOptions(m_RandItemGen.GetOptions());
  m_CreateView.SetRandItemGen(&m_RandItemGen);
 }
/*===========================================================================
 *		End of Class CMWRandItemDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Destructor
 *
 *=========================================================================*/
CMWRandItemDlg::~CMWRandItemDlg() {
  DeleteRecInfo();
 }
/*===========================================================================
 *		End of Class CMWRandItemDlg Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Method - CEsmRecord* CreateRecord (pType);
 *
 * Creates a new record of the given type. The new record is added to the
 * file and is returned.
 *
 *=========================================================================*/
CEsmRecord* CMWRandItemDlg::CreateRecord (const TCHAR* pType) { 
  DEFINE_FUNCTION("CMWRandItemDlg::CreateRecord()");
  CEsmRecord*   pRecord;
  esmrecinfo_t* pRecInfo;
  
  pRecord = GetEsmFile()->AllocateRecord(pType);
  CreatePointer(pRecInfo, esmrecinfo_t);
  pRecInfo->pFile   = GetEsmFile();
  pRecInfo->pRecord = pRecord;
  m_RecInfoArray.Add(pRecInfo);

  return (pRecord);
 }
/*===========================================================================
 *		End of Class Method CMWRandItemDlg::CreateRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Method - void DeleteRecInfo (void);
 *
 * Delete all rec info pointers in the array.
 *
 *=========================================================================*/
void CMWRandItemDlg::DeleteRecInfo (void) {
  DEFINE_FUNCTION("CMWRandItemDlg::DeleteRecInfo()");
  esmrecinfo_t* pRecInfo;
  int		Index;

	/* Delete all elements in the array */
  for (Index = 0; Index < m_RecInfoArray.GetNumElements(); Index++) {
    pRecInfo = m_RecInfoArray.GetAt(Index);
    DestroyPointer(pRecInfo);
   }

  m_RecInfoArray.RemoveAll();
 }
/*===========================================================================
 *		End of Class Method CMWRandItemDlg::DeleteRecInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Method - void DestroyContents (void);
 *
 * Destroys all the contents of the current file/records.
 *
 *=========================================================================*/
void CMWRandItemDlg::DestroyContents (void) {
  DeleteRecInfo();

	/* Clear the file */
  GetEsmFile()->Destroy();
  GetEsmFile()->CreateNew();
  m_RandItemGen.ClearAllRecords();

	/* Update the display */
  UpdateList();
 }
/*===========================================================================
 *		End of Class Method CMWRandItemDlg::DestroyContents()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CMWRandItemDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CMWRandItemDlg)
  DDX_Control(pDX, IDC_MAIN_TAB, m_MainTab);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CMWRandItemDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CMWRandItemDlg::OnInitDialog () {
  CDialog::OnInitDialog();

	/* Add "About..." menu item to system menu.
	   IDM_ABOUTBOX must be in the system command range. */
  ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
  ASSERT(IDM_ABOUTBOX < 0xF000);
  CMenu* pSysMenu = GetSystemMenu(FALSE);

  if (pSysMenu != NULL) {
    CString strAboutMenu;
    strAboutMenu.LoadString(IDS_ABOUTBOX);

    if (!strAboutMenu.IsEmpty()) {
      pSysMenu->AppendMenu(MF_SEPARATOR);
      pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
     }      		
   }

	/* Set the icon for this dialog.  The framework does this automatically
	 *  when the application's main window is not a dialog */
  SetIcon(m_hIcon, TRUE);
  SetIcon(m_hIcon, FALSE);

	/* Attempt to load the item data files */
  bool Result = m_RandItemGen.LoadDataFiles();
  if (!Result) ErrorHandler.Notify(_T("File Load Error!"));

	/* Create the tab view objects */
  m_OutputView.Create(IDD_OUTPUT_VIEW, &m_MainTab);
  m_OutputView.SetParentDlg(this);
  m_CreateView.Create(IDD_CREATE_VIEW, &m_MainTab);
  m_CreateView.SetParentDlg(this);
  //m_OldWeaponView.Create(IDD_WEAPON_VIEW, &m_MainTab);
  //m_OldEnchantView.Create(IDD_ENCHANT_VIEW, &m_MainTab);
  //m_OldWeaponView.SetParentDlg(this);
  //m_OldEnchantView.SetParentDlg(this);

	/* Initialize the tab control */
  m_MainTab.AddTab(_T("Output"),  &m_OutputView);
  m_MainTab.AddTab(_T("Create"),  &m_CreateView);
  //m_MainTab.AddTab(_T("Weapon"),  &m_OldWeaponView);
  //m_MainTab.AddTab(_T("Enchant"), &m_OldEnchantView);
  m_MainTab.SetPage(0);
	
	/* Return TRUE  unless you set the focus to a control */
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CMWRandItemDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Event - void OnSysCommand (nID, lParam);
 *
 *=========================================================================*/
void CMWRandItemDlg::OnSysCommand(UINT nID, LPARAM lParam) {

  if ((nID & 0xFFF0) == IDM_ABOUTBOX) {
    CAboutDlg dlgAbout;
    dlgAbout.DoModal();
   }
  else {
    CDialog::OnSysCommand(nID, lParam);
   }
 }
/*===========================================================================
 *		End of Class Event CMWRandItemDlg::OnSysCommand()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Event - void OnDestroy ();
 *
 *=========================================================================*/
void CMWRandItemDlg::OnDestroy() {
  WinHelp(0L, HELP_QUIT);
  CDialog::OnDestroy();
 }
/*===========================================================================
 *		End of Class Event CMWRandItemDlg::OnDestroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Event - void OnFileExit ();
 *
 *=========================================================================*/
void CMWRandItemDlg::OnFileExit() {
  EndDialog(0);
 }
/*===========================================================================
 *		End of Class Event CMWRandItemDlg::OnFileExit()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Event - void OnFileNew ();
 *
 *=========================================================================*/
void CMWRandItemDlg::OnFileNew() {
  int Result = MessageBox(_T("Delete all records?"), _T("New"), MB_YESNO | MB_ICONQUESTION);
  if (Result != IDYES) return;
  DestroyContents();
 }
/*===========================================================================
 *		End of Class Event CMWRandItemDlg::OnFileNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Event - void OnFileSave ();
 *
 *=========================================================================*/
void CMWRandItemDlg::OnFileSave() {
  CFileDialog FileDlg(FALSE, _T("ESP"), NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, 
		_T("ESP Files (*.esp)|*.esp|All Files (*.*)|*.*||"), this);
  int Result;
  
  Result = FileDlg.DoModal();
  if (Result == IDCANCEL) return;

  Result = GetEsmFile()->Write(FileDlg.GetPathName());
  if (!Result) ErrorHandler.Notify("Error Saving ESP File!");

 }
/*===========================================================================
 *		End of Class Event CMWRandItemDlg::OnFileSave()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Event - void OnPaint ();
 *
 * If you add a minimize button to your dialog, you will need the code below
 * to draw the icon.  For MFC applications using the document/view model,
 * this is automatically done for you by the framework.
 *
 *=========================================================================*/
void CMWRandItemDlg::OnPaint() {

  if (IsIconic()) {
    CPaintDC dc(this);	/* Device context for painting */
    SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

	/* Center icon in client rectangle */
    int cxIcon = GetSystemMetrics(SM_CXICON);
    int cyIcon = GetSystemMetrics(SM_CYICON);
    CRect rect;
    GetClientRect(&rect);
    int x = (rect.Width() - cxIcon + 1) / 2;
    int y = (rect.Height() - cyIcon + 1) / 2;

	/* Draw the icon */
    dc.DrawIcon(x, y, m_hIcon);
   }
  else {
    CDialog::OnPaint();
   }
 }
/*===========================================================================
 *		End of Class Event CMWRandItemDlg::OnPaint()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Event - void OnNewItems ();
 *
 *=========================================================================*/
LRESULT CMWRandItemDlg::OnNewItems(WPARAM wParam, LPARAM lParam) {
  DEFINE_FUNCTION("CMWRandItemDlg::OnNewItems()");
  esmrecinfo_t* pRecInfo;
  CString       Buffer;
  int		Index;
//*
  for (Index = 0; Index < m_RandItemGen.GetNewRecords()->GetNumElements(); Index++) {
    CreatePointer(pRecInfo, esmrecinfo_t);
    m_RecInfoArray.Add(pRecInfo);
    pRecInfo->pRecord = m_RandItemGen.GetNewRecords()->GetAt(Index);
    pRecInfo->pFile   = GetEsmFile();
   } //*/

  m_RandItemGen.GetNewRecords()->RemoveAll();
  UpdateList();

  if (m_RandItemGen.GetOptions()->OutputScript) {
    Buffer.Format(_T("Created %ld items and %ld enchantments in %g secs.\n\rOutput script text file to '%s'."), m_RandItemGen.GetNumNewItems(), 
		m_RandItemGen.GetNumEnchantments(), m_CreateView.GetCreateTime(), m_RandItemGen.GetOptions()->ScriptFile);
   }
  else {
    Buffer.Format(_T("Created %ld items and %ld enchantments in %g secs."), m_RandItemGen.GetNumNewItems(), m_RandItemGen.GetNumEnchantments(), m_CreateView.GetCreateTime());
   }

  MessageBox(Buffer, _T("Created Items"));
  return (0);
 }
/*===========================================================================
 *		End of Class Event CMWRandItemDlg::OnNewItems()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Event - HCURSOR OnQueryDragIcon ();
 *
 * The system calls this to obtain the cursor to display while the user drags
 * the icon.
 *
 *=========================================================================*/
HCURSOR CMWRandItemDlg::OnQueryDragIcon() {
  return (HCURSOR) m_hIcon;
 }
/*===========================================================================
 *		End of Class Event CMWRandItemDlg::OnQueryDragIcon()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Event - void OnSize (nType, cx, cy);
 *
 *=========================================================================*/
void CMWRandItemDlg::OnSize(UINT nType, int cx, int cy) {
  CPropertyPage* pPage;
  int		 NewWidth;
  int		 NewHeight;

	/* Resize the window */
  CDialog::OnSize(nType, cx, cy);

	/* Compute the new tab size if required */
  if (nType != SW_MINIMIZE && IsWindow(m_MainTab.m_hWnd)) {

		/* Calculate the new tab control size */
    NewWidth  = cx - MWRI_TAB_SIZEXOFFSET;
    NewHeight = cy - MWRI_TAB_SIZEYOFFSET;
		/* Ensure the size isn't too small */
    if (NewWidth  < MWRI_TAB_MINWIDTH)  NewWidth  = MWRI_TAB_MINWIDTH;
    if (NewHeight < MWRI_TAB_MINHEIGHT) NewHeight = MWRI_TAB_MINHEIGHT;
    
    m_MainTab.SetWindowPos(NULL, 0, 0, NewWidth, NewHeight, SWP_NOZORDER | SWP_NOMOVE);
    //m_OutputView.SetWindowPos(NULL, 0, 0, NewWidth, NewHeight, SWP_NOZORDER | SWP_NOMOVE);
    pPage = m_MainTab.GetCurrentPage();

    if (pPage != NULL) {
      CRect PageRect = m_MainTab.GetPageRect();

      pPage->SetWindowPos(NULL, 0, 0, PageRect.Width(), PageRect.Height(), SWP_NOZORDER | SWP_NOMOVE);
     }
   }

 }
/*===========================================================================
 *		End of Class Event CMWRandItemDlg::OnSize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Method - void UpdateList (void);
 *
 * Updates the item list from the ESM file records.
 *
 *=========================================================================*/
void CMWRandItemDlg::UpdateList (void) {
  m_OutputView.UpdateList();
 }
/*===========================================================================
 *		End of Class Method CMWRandItemDlg::UpdateList()
 *=========================================================================*/
 
  
/*===========================================================================
 *
 * Class CMWRandItemDlg Event - void OnTestExportesp ();
 *
 *=========================================================================*/
void CMWRandItemDlg::OnTestExportesp() {
  CFileDialog FileDlg(TRUE, _T("ESP"), NULL, OFN_HIDEREADONLY | OFN_PATHMUSTEXIST, 
		_T("ESP Files (*.esp)|*.esp|ESM Files (*.esm)|*.esm|All Files (*.*)|*.*||"), this);
  int Result;
  m_CreateView.GetControlData();

  FileDlg.m_ofn.lpstrInitialDir = GetMWDataPath();
  Result = FileDlg.DoModal();
  if (Result == IDCANCEL) return;

  Result = m_RandItemGen.ExportItemData(FileDlg.GetPathName(), _T("itemtest.dat"));
  if (!Result) ErrorHandler.AddError(ERR_CUSTOM, _T("Error exporting items to DAT file!"));
	
 }
/*===========================================================================
 *		End of Class Event CMWRandItemDlg::OnTestExportesp()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Event - void OnFileLoadbase ();
 *
 *=========================================================================*/
void CMWRandItemDlg::OnFileLoadbase() {
  CFileDialog FileDlg(TRUE, _T("ESP"), NULL, OFN_HIDEREADONLY | OFN_PATHMUSTEXIST, 
		_T("ESP Files (*.esp)|*.esp|ESM Files (*.esm)|*.esm|All Files (*.*)|*.*||"), this);
  int Result;
  
  FileDlg.m_ofn.lpstrInitialDir = GetMWDataPath();
  Result = FileDlg.DoModal();
  if (Result == IDCANCEL) return;

	/* Ensure the user wants to proceed */
  Result = MessageBox("Merge the selected ESP file with the current data?", "Merge ESP", MB_YESNO);
  if (Result != IDYES) return;

	/* Attempt to load the file */
  Result = m_RandItemGen.MergeEsp(FileDlg.GetPathName());
  if (!Result) ErrorHandler.Notify("Merge ESP Error!");
 }
/*===========================================================================
 *		End of Class Event CMWRandItemDlg::OnFileLoadbase()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Event - void OnFileLoadgroup ();
 *
 *=========================================================================*/
void CMWRandItemDlg::OnFileLoadgroup() {
  CFileDialog FileDlg(TRUE, _T("GRP"), NULL, OFN_HIDEREADONLY | OFN_PATHMUSTEXIST, 
		_T("GRP Files (*.GRP)|*.GRP|All Files (*.*)|*.*||"), this);
  int Result;
  
  FileDlg.m_ofn.lpstrInitialDir = GetMWDataPath();
  Result = FileDlg.DoModal();
  if (Result == IDCANCEL) return;

  	/* Ensure the user wants to proceed */
  Result = MessageBox("Clear the current settings/records and load the selected group file?", "Load Group", MB_YESNO);
  if (Result != IDYES) return;

	/* Attempt to load the file */
  Result = m_RandItemGen.LoadGroupFile(FileDlg.GetPathName());
  if (!Result) ErrorHandler.NotifyList("Error(s) where encountered for the selected group file", "Load Group Error!");

  m_CreateView.SetControlData();
 }
/*===========================================================================
 *		End of Class Event CMWRandItemDlg::OnFileLoadgroup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Event - void OnFileSavegroup ();
 *
 *=========================================================================*/
void CMWRandItemDlg::OnFileSavegroup() {
 CFileDialog FileDlg(FALSE, _T("GRP"), NULL, OFN_HIDEREADONLY | OFN_PATHMUSTEXIST | OFN_OVERWRITEPROMPT, 
		_T("GRP Files (*.GRP)|*.GRP|All Files (*.*)|*.*||"), this);
  int Result;

	/* Update the variable data from the window controls */
  m_CreateView.GetControlData();
  
  FileDlg.m_ofn.lpstrInitialDir = GetMWDataPath();
  Result = FileDlg.DoModal();
  if (Result == IDCANCEL) return;

	/* Attempt to save the file */
  Result = m_RandItemGen.SaveGroupFile(FileDlg.GetPathName());

  if (!Result)
    ErrorHandler.Notify("Save Group Error!");
  else {
   }

 }
/*===========================================================================
 *		End of Class Event CMWRandItemDlg::OnFileSavegroup()
 *=========================================================================*/
