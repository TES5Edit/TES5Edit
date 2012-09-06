/*===========================================================================
 *
 * File:	Esmaiescortdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 24, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmAiEscortDlg.h"
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

  DEFINE_FILE("EsmAiEscortDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmAiEscortDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmAiEscortDlg, CDialog)
  //{{AFX_MSG_MAP(CEsmAiEscortDlg)
  ON_BN_CLICKED(IDC_ESCORTCHECK, OnEscortcheck)
  ON_BN_CLICKED(IDC_POINTCHECK, OnPointcheck)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmAiEscortDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiEscortDlg Constructor
 *
 *=========================================================================*/
CEsmAiEscortDlg::CEsmAiEscortDlg(CWnd* pParent) : CDialog(CEsmAiEscortDlg::IDD, pParent) {
  //{{AFX_DATA_INIT(CEsmAiEscortDlg)
  //}}AFX_DATA_INIT
  m_pSubRecord = NULL;
 }
/*===========================================================================
 *		End of Class CEsmAiEscortDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiEscortDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmAiEscortDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmAiEscortDlg)
  DDX_Control(pDX, IDC_ZTEXT, m_ZText);
  DDX_Control(pDX, IDC_YTEXT, m_YText);
  DDX_Control(pDX, IDC_XTEXT, m_XText);
  DDX_Control(pDX, IDC_POINTCHECK, m_PointCheck);
  DDX_Control(pDX, IDC_CELLLIST, m_CellList);
  DDX_Control(pDX, IDC_ESCORTCHECK, m_EscortCheck);
  DDX_Control(pDX, IDC_DURATIONTEXT, m_DurationText);
  DDX_Control(pDX, IDC_TARGETLIST, m_TargetList);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmAiEscortDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiEscortDlg Method - bool DoModal (pSubRecord, pCellName, pTitle);
 *
 *=========================================================================*/
bool CEsmAiEscortDlg::DoModal (CEsmSubAI_E* pSubRecord, const TCHAR* pCellName, const TCHAR* pTitle) {
  int Result; 

  m_pSubRecord = pSubRecord;
  m_Title = (pTitle == NULL) ? _T("") : pTitle;

  if (pCellName == NULL || *pCellName == NULL_CHAR)
    m_CellName.Empty();
  else
    m_CellName = pCellName;

  if (pSubRecord == NULL) return (false);

  Result = CDialog::DoModal();
  if (Result != IDOK) return (false);
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmAiEscortDlg::DoModal()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiEscortDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmAiEscortDlg::OnInitDialog() {
  ai_edata_t*	pAiData;
  CString	Buffer;

  CDialog::OnInitDialog();
  Buffer.Format(_T("AI Package: %s"), m_Title);
  SetWindowText(Buffer);

  pAiData = m_pSubRecord->GetAIData();
  FillEsmNpcCombo(m_TargetList);
  FillEsmCellCombo(m_CellList);
  m_CellList.LimitText(MWESM_ID_MAXSIZE);
  m_TargetList.LimitText(MWESM_ID_MAXSIZE);
  m_DurationText.LimitText(16);
  m_XText.LimitText(16);
  m_YText.LimitText(16);
  m_ZText.LimitText(16);

	/* Set the text values */
  if (pAiData != NULL) {
    Buffer.Format(_T("%d"), (int) pAiData->Duration);
    m_DurationText.SetWindowText(Buffer); 
    m_TargetList.SetWindowText(pAiData->ID); 
    m_EscortCheck.SetCheck(!m_CellName.IsEmpty());
    m_CellList.SetWindowText(m_CellName);

    if (pAiData->X != FLT_MAX) {
      m_PointCheck.SetCheck(TRUE);
      Buffer.Format(_T("%g"), pAiData->X);
      m_XText.SetWindowText(Buffer); 
      Buffer.Format(_T("%g"), pAiData->Y);
      m_YText.SetWindowText(Buffer); 
      Buffer.Format(_T("%g"), pAiData->Z);
      m_ZText.SetWindowText(Buffer); 
     }
    else {
      m_PointCheck.SetCheck(FALSE);
     }
   }
	
	/* Enable/disable controls as required */
  OnEscortcheck();

  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmAiEscortDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiEscortDlg Event - void OnOK ();
 *
 *=========================================================================*/
void CEsmAiEscortDlg::OnOK() {
  ai_edata_t*	pAiData;
  CString	Buffer;

  pAiData = m_pSubRecord->GetAIData();

	/* Savet the text values */
  if (pAiData != NULL) {
    m_TargetList.GetWindowText(Buffer); 
    strncpy(pAiData->ID, Buffer, 32);
    m_DurationText.GetWindowText(Buffer); 
    pAiData->Duration = (short)atoi(Buffer);

    if (m_EscortCheck.GetCheck()) {
      m_CellList.GetWindowText(m_CellName);

      if (m_PointCheck.GetCheck()) {
        m_XText.GetWindowText(Buffer);
	pAiData->X = (float) atof(Buffer);
	m_YText.GetWindowText(Buffer);
	pAiData->Y = (float) atof(Buffer);
	m_ZText.GetWindowText(Buffer);
	pAiData->Z = (float) atof(Buffer);
       }
      else {
        pAiData->X = FLT_MAX;
        pAiData->Y = FLT_MAX;
        pAiData->Z = FLT_MAX;
       }
     }
    else {
      m_CellName.Empty();
      pAiData->X = FLT_MAX;
      pAiData->Y = FLT_MAX;
      pAiData->Z = FLT_MAX;
     }
   }
  
  CDialog::OnOK();
 }
/*===========================================================================
 *		End of Class Event CEsmAiEscortDlg::OnOK()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CheckBox Events
 *
 *=========================================================================*/
void CEsmAiEscortDlg::OnEscortcheck() { 
  m_CellList.EnableWindow(m_EscortCheck.GetCheck() != 0);
  m_PointCheck.EnableWindow(m_EscortCheck.GetCheck() != 0);
  m_XText.EnableWindow(m_EscortCheck.GetCheck() != 0 && m_PointCheck.GetCheck() != 0);
  m_YText.EnableWindow(m_EscortCheck.GetCheck() != 0 && m_PointCheck.GetCheck() != 0);
  m_ZText.EnableWindow(m_EscortCheck.GetCheck() != 0 && m_PointCheck.GetCheck() != 0);
 }

void CEsmAiEscortDlg::OnPointcheck() {
  m_XText.EnableWindow(m_EscortCheck.GetCheck() != 0 && m_PointCheck.GetCheck() != 0);
  m_YText.EnableWindow(m_EscortCheck.GetCheck() != 0 && m_PointCheck.GetCheck() != 0);
  m_ZText.EnableWindow(m_EscortCheck.GetCheck() != 0 && m_PointCheck.GetCheck() != 0);
 }
/*===========================================================================
 *		End of CheckBox Events
 *=========================================================================*/

