/*===========================================================================
 *
 * File:	Esmheaderdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	March 2, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmHeaderDlg.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif

  DEFINE_FILE("EsmHeaderDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmHeaderDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmHeaderDlg, CDialog)
  //{{AFX_MSG_MAP(CEsmHeaderDlg)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of Class CEsmHeaderDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmHeaderDlg Constructor
 *
 *=========================================================================*/
CEsmHeaderDlg::CEsmHeaderDlg(CWnd* pParent) : CDialog(CEsmHeaderDlg::IDD, pParent) {
  //{{AFX_DATA_INIT(CEsmHeaderDlg)
  //}}AFX_DATA_INIT
  m_pHeader   = NULL;
  m_pFilename = NULL;
 }
/*===========================================================================
 *		End of Class CEsmHeaderDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmHeaderDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmHeaderDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmHeaderDlg)
  DDX_Control(pDX, IDC_DESCTEXT, m_DescText);
  DDX_Control(pDX, IDC_AUTHORTEXT, m_AuthorText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmHeaderDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmHeaderDlg Method - bool DoModal (pHeader, pFilename);
 *
 *=========================================================================*/
bool CEsmHeaderDlg::DoModal (CEsmTES3* pHeader, const TCHAR* pFilename) {
  int Result;

	/* Ensure valid input */
  if (pHeader == NULL) return (false);
  m_pHeader   = pHeader;
  m_pFilename = pFilename;

  Result = CDialog::DoModal();
  if (Result != IDOK) return (false);
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmHeaderDlg::DoModal()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmHeaderDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmHeaderDlg::OnInitDialog() {
  CString Buffer;

  CDialog::OnInitDialog();

  if (m_pFilename != NULL) {
    Buffer.Format(_T("%s -- Plugin Header"), m_pFilename);
    SetWindowText(Buffer);
   }
	
  m_AuthorText.SetLimitText(MWESM_HEDR_AUTHORSIZE);
  m_DescText.SetLimitText(MWESM_HEDR_DESCSIZE);
  m_AuthorText.SetWindowText(m_pHeader->GetHeaderData()->Author);
  m_DescText.SetWindowText(m_pHeader->GetHeaderData()->Description);

  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmHeaderDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmHeaderDlg Event - void OnOK ();
 *
 *=========================================================================*/
void CEsmHeaderDlg::OnOK() {
  CString Buffer;

  m_AuthorText.GetWindowText(Buffer);
  TSTRNCPY(m_pHeader->GetHeaderData()->Author, Buffer, MWESM_HEDR_AUTHORSIZE);

  m_DescText.GetWindowText(Buffer);
  TSTRNCPY(m_pHeader->GetHeaderData()->Description, Buffer, MWESM_HEDR_DESCSIZE);
  
  CDialog::OnOK();
 }
/*===========================================================================
 *		End of Class Event CEsmHeaderDlg::OnOK()
 *=========================================================================*/

