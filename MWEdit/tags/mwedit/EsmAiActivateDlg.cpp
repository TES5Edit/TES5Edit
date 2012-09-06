/*===========================================================================
 *
 * File:	Esmaiactivatedlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 24, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmAiActivateDlg.h"
#include "EsmAiWanderDlg.h"
#include "EsmUtils.h"


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

  DEFINE_FILE("EsmAiActivateDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmAiActivateDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmAiActivateDlg, CDialog)
  //{{AFX_MSG_MAP(CEsmAiActivateDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmAiActivateDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiActivateDlg Constructor
 *
 *=========================================================================*/
CEsmAiActivateDlg::CEsmAiActivateDlg(CWnd* pParent) : CDialog(CEsmAiActivateDlg::IDD, pParent) {
  //{{AFX_DATA_INIT(CEsmAiActivateDlg)
  //}}AFX_DATA_INIT
  m_pSubRecord = NULL;
 }
/*===========================================================================
 *		End of Class CEsmAiActivateDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiActivateDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmAiActivateDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmAiActivateDlg)
  DDX_Control(pDX, IDC_COMBO1, m_TargetList);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmAiActivateDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiActivateDlg Method - bool DoModal (pSubRecord);
 *
 *=========================================================================*/
bool CEsmAiActivateDlg::DoModal (CEsmSubAI_A* pSubRecord) {
  int Result; 

  m_pSubRecord = pSubRecord;
  if (pSubRecord == NULL) return (false);

  Result = CDialog::DoModal();
  if (Result != IDOK) return (false);
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmAiActivateDlg::DoModal()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiActivateDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmAiActivateDlg::OnInitDialog() {
  CDialog::OnInitDialog();

  FillEsmNpcCombo(m_TargetList);
  m_TargetList.SetWindowText(m_pSubRecord->GetName());
  m_TargetList.LimitText(MWESM_ID_MAXSIZE);
	
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmAiActivateDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiActivateDlg Event - void OnOK ();
 *
 *=========================================================================*/
void CEsmAiActivateDlg::OnOK() {
  CString Buffer;

  m_TargetList.GetWindowText(Buffer);
  m_pSubRecord->SetName(Buffer);

  CDialog::OnOK();
 }
/*===========================================================================
 *		End of Class Event CEsmAiActivateDlg::OnOK()
 *=========================================================================*/
