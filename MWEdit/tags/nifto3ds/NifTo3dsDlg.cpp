/*===========================================================================
 *
 * File:	NifTo3dsDlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Saturday, 06 December, 2003
 *
 * Implementation of the CNifTo3dsDlg class.
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

	/* Debug definitions */
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * CNifTo3dsDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CNifTo3dsDlg, CDialog)
  //{{AFX_MSG_MAP(CNifTo3dsDlg)
  ON_WM_SYSCOMMAND()
  ON_WM_DESTROY()
  ON_WM_PAINT()
  ON_WM_QUERYDRAGICON()
  ON_BN_CLICKED(IDC_CONVERT_BUTTON, OnConvertButton)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CNifTo3dsDlg Message Map
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
 * Class CNifTo3dsDlg Constructor
 *
 *=========================================================================*/
CNifTo3dsDlg::CNifTo3dsDlg(CWnd* pParent) : 
	CDialog(CNifTo3dsDlg::IDD, pParent) {
  //{{AFX_DATA_INIT(CNifTo3dsDlg)
  //}}AFX_DATA_INIT

  m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
 }
/*===========================================================================
 *		End of Class CNifTo3dsDlg Constructor
 *=========================================================================*/




/*===========================================================================
 *
 * Class CNifTo3dsDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CNifTo3dsDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CNifTo3dsDlg)
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CNifTo3dsDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTo3dsDlg Event - void OnConvertButton ();
 *
 *=========================================================================*/
void CNifTo3dsDlg::OnConvertButton() {
  CFileDialog FileDlg3ds(FALSE, _T("3ds"), NULL, OFN_HIDEREADONLY, _T("3DS Files (*.3ds)|*.3ds|All Files (*.*)|*.*||"), this);
  CFileDialog FileDlgNif(TRUE , _T("3ds"), NULL, OFN_HIDEREADONLY | OFN_PATHMUSTEXIST, _T("NIF Files (*.nif)|*.nif|All Files (*.*)|*.*||"), this);
  CNifFile    NifFile;
  int	      Result;
  bool	      fResult;

  FileDlgNif.m_ofn.lpstrTitle = _T("Select Input NIF File");
  FileDlg3ds.m_ofn.lpstrTitle = _T("Select Output 3DS File");

  	/* Get the input file */
  Result = FileDlgNif.DoModal();
  if (Result != IDOK) return;

	/* Get the output file */
  Result = FileDlg3ds.DoModal();
  if (Result != IDOK) return;

	/* Attempt to load the nif file */
  fResult = NifFile.Read(FileDlgNif.GetPathName());

  if (!fResult) {
    ErrorHandler.Notify(_T("Nif Load Error!"));
    return;
   }

	/* Attempt to convert the nif to a 3ds file */
  ErrorHandler.ClearErrorCount();
  fResult = ConvertNifTo3ds(NifFile, FileDlg3ds.GetPathName());

  if (!fResult) {
    ErrorHandler.Notify(_T("3ds Export Error!"));
   }
  else if (ErrorHandler.GetErrorCount() > 0) {
    ErrorHandler.NotifyList(_T("Conversion was successful but the following errors or warnings occurred:"), _T("Conversion Success"));
   }
  else {
    MessageBox(_T("Conversion Completed Successfully!"), _T("Success"), MB_OK | MB_ICONINFORMATION);
   }
 }
/*===========================================================================
 *		End of Class Event CNifTo3dsDlg::OnConvertButton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTo3dsDlg Event - void OnDestroy ();
 *
 *=========================================================================*/
void CNifTo3dsDlg::OnDestroy() {
  WinHelp(0L, HELP_QUIT);
  CDialog::OnDestroy();
 }
/*===========================================================================
 *		End of Class Event CNifTo3dsDlg::OnDestroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTo3dsDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CNifTo3dsDlg::OnInitDialog () {
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
	
	/* Return TRUE  unless you set the focus to a control */
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CNifTo3dsDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTo3dsDlg Event - void OnPaint ();
 *
 * If you add a minimize button to your dialog, you will need the code below
 * to draw the icon.  For MFC applications using the document/view model,
 * this is automatically done for you by the framework.
 *
 *=========================================================================*/
void CNifTo3dsDlg::OnPaint() {

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
 *		End of Class Event CNifTo3dsDlg::OnPaint()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTo3dsDlg Event - HCURSOR OnQueryDragIcon ();
 *
 * The system calls this to obtain the cursor to display while the user drags
 * the icon.
 *
 *=========================================================================*/
HCURSOR CNifTo3dsDlg::OnQueryDragIcon() {
  return (HCURSOR) m_hIcon;
 }
/*===========================================================================
 *		End of Class Event CNifTo3dsDlg::OnQueryDragIcon()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTo3dsDlg Event - void OnSysCommand (nID, lParam);
 *
 *=========================================================================*/
void CNifTo3dsDlg::OnSysCommand(UINT nID, LPARAM lParam) {

  if ((nID & 0xFFF0) == IDM_ABOUTBOX) {
    CAboutDlg dlgAbout;
    dlgAbout.DoModal();
   }
  else {
    CDialog::OnSysCommand(nID, lParam);
   }
 }
/*===========================================================================
 *		End of Class Event CNifTo3dsDlg::OnSysCommand()
 *=========================================================================*/