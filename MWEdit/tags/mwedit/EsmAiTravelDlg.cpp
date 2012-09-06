/*===========================================================================
 *
 * File:	Esmaitraveldlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 24, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmAiTravelDlg.h"


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

  DEFINE_FILE("EsmAiTravelDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmAiTravelDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmAiTravelDlg, CDialog)
  //{{AFX_MSG_MAP(CEsmAiTravelDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmAiTravelDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiTravelDlg Constructor
 *
 *=========================================================================*/
CEsmAiTravelDlg::CEsmAiTravelDlg(CWnd* pParent) : CDialog(CEsmAiTravelDlg::IDD, pParent) {
  //{{AFX_DATA_INIT(CEsmAiTravelDlg)
  //}}AFX_DATA_INIT
  m_pSubRecord = NULL;
 }
/*===========================================================================
 *		End of Class CEsmAiTravelDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiTravelDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmAiTravelDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmAiTravelDlg)
  DDX_Control(pDX, IDC_ZTEXT, m_ZText);
  DDX_Control(pDX, IDC_YTEXT, m_YText);
  DDX_Control(pDX, IDC_XTEXT, m_XText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmAiTravelDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiTravelDlg Method - bool DoModal (pSubRecord);
 *
 *=========================================================================*/
bool CEsmAiTravelDlg::DoModal (CEsmSubAI_T* pSubRecord) {
  int Result; 

  m_pSubRecord = pSubRecord;
  if (pSubRecord == NULL) return (false);

  Result = CDialog::DoModal();
  if (Result != IDOK) return (false);

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmAiTravelDlg::DoModal()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiTravelDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmAiTravelDlg::OnInitDialog() {
  ai_tdata_t*	pAiData;
  CString	Buffer;

  CDialog::OnInitDialog();
  pAiData = m_pSubRecord->GetAIData();
  m_XText.LimitText(16);
  m_YText.LimitText(16);
  m_ZText.LimitText(16);

	/* Set the text values */
  if (pAiData != NULL) {
    Buffer.Format(_T("%g"), pAiData->X);
    m_XText.SetWindowText(Buffer); 
    Buffer.Format(_T("%g"), pAiData->Y);
    m_YText.SetWindowText(Buffer); 
    Buffer.Format(_T("%g"), pAiData->Z);
    m_ZText.SetWindowText(Buffer); 
   }
	
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmAiTravelDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiTravelDlg Event - void OnOK ();
 *
 *=========================================================================*/
void CEsmAiTravelDlg::OnOK() {
  ai_tdata_t*	pAiData;
  CString	Buffer;

  pAiData = m_pSubRecord->GetAIData();

	/* Savet the text values */
  if (pAiData != NULL) {
    m_XText.GetWindowText(Buffer);
    pAiData->X = (float) atof(Buffer);
    m_YText.GetWindowText(Buffer);
    pAiData->Y = (float) atof(Buffer);
    m_ZText.GetWindowText(Buffer);
    pAiData->Z = (float) atof(Buffer);
   }
  
  CDialog::OnOK();
 }
/*===========================================================================
 *		End of Class Event CEsmAiTravelDlg::OnOK()
 *=========================================================================*/
