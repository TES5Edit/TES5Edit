/*===========================================================================
 *
 * File:	Esmaiwanderdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 24, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmAiWanderDlg.h"


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

  DEFINE_FILE("EsmAiWanderDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmAiWanderDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmAiWanderDlg, CDialog)
  //{{AFX_MSG_MAP(CEsmAiWanderDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmAiWanderDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiWanderDlg Constructor
 *
 *=========================================================================*/
CEsmAiWanderDlg::CEsmAiWanderDlg(CWnd* pParent) : CDialog(CEsmAiWanderDlg::IDD, pParent) {
  //{{AFX_DATA_INIT(CEsmAiWanderDlg)
  //}}AFX_DATA_INIT
  m_pSubRecord = NULL;
 }
/*===========================================================================
 *		End of Class CEsmAiWanderDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiWanderDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmAiWanderDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmAiWanderDlg)
  
  DDX_Control(pDX, IDC_TIMETEXT, m_TimeText);
  DDX_Control(pDX, IDC_DISTANCETEXT, m_DistanceText);
  DDX_Control(pDX, IDC_DURATIONTEXT, m_DurationText);
  //}}AFX_DATA_MAP
  DDX_Control(pDX, IDC_IDLETEXT2, m_IdleText[0]);
  DDX_Control(pDX, IDC_IDLETEXT3, m_IdleText[1]);
  DDX_Control(pDX, IDC_IDLETEXT4, m_IdleText[2]);
  DDX_Control(pDX, IDC_IDLETEXT5, m_IdleText[3]);
  DDX_Control(pDX, IDC_IDLETEXT6, m_IdleText[4]);
  DDX_Control(pDX, IDC_IDLETEXT7, m_IdleText[5]);
  DDX_Control(pDX, IDC_IDLETEXT8, m_IdleText[6]);
  DDX_Control(pDX, IDC_IDLETEXT9, m_IdleText[7]);
 }
/*===========================================================================
 *		End of Class Method CEsmAiWanderDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiWanderDlg Method - bool DoModal (pSubRecord);
 *
 *=========================================================================*/
bool CEsmAiWanderDlg::DoModal (CEsmSubAI_W* pSubRecord) {
  int Result; 

  m_pSubRecord = pSubRecord;
  if (pSubRecord == NULL) return (false);

  Result = CDialog::DoModal();
  if (Result != IDOK) return (false);
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmAiWanderDlg::DoModal()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiWanderDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmAiWanderDlg::OnInitDialog() {
  ai_wdata_t*	pAiData;
  CString	Buffer;
  int		Index;

  CDialog::OnInitDialog();
  pAiData = m_pSubRecord->GetAIData();
  m_DistanceText.LimitText(16);
  m_DurationText.LimitText(16);
  m_TimeText.LimitText(16);

	/* Set the text values */
  if (pAiData != NULL) {
    Buffer.Format(_T("%d"), (int) pAiData->Distance);
    m_DistanceText.SetWindowText(Buffer); 
    Buffer.Format(_T("%d"), (int) pAiData->Duration);
    m_DurationText.SetWindowText(Buffer); 
    Buffer.Format(_T("%d"), (int) pAiData->TimeOfDay);
    m_TimeText.SetWindowText(Buffer); 

    for (Index = 0; Index < MWESM_AIW_NUMIDLES; Index++) {
      Buffer.Format(_T("%d"), (int) pAiData->Idle[Index]);
      m_IdleText[Index].SetWindowText(Buffer); 
      m_IdleText[Index].LimitText(4);
     }
   }
	
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmAiWanderDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAiWanderDlg Event - void OnOK ();
 *
 *=========================================================================*/
void CEsmAiWanderDlg::OnOK() {
  ai_wdata_t*	pAiData;
  CString	Buffer;
  int		Index;

  pAiData = m_pSubRecord->GetAIData();

	/* Savet the text values */
  if (pAiData != NULL) {
    m_DistanceText.GetWindowText(Buffer); 
    pAiData->Distance = (short)atoi(Buffer);
    m_DurationText.GetWindowText(Buffer); 
    pAiData->Duration = (short)atoi(Buffer);
    m_TimeText.GetWindowText(Buffer); 
    pAiData->TimeOfDay = (byte)atoi(Buffer);
    FIXLIMIT(pAiData->TimeOfDay, 0, 23);

    for (Index = 0; Index < MWESM_AIW_NUMIDLES; Index++) {
      m_IdleText[Index].GetWindowText(Buffer); 
      pAiData->Idle[Index] = (byte)atoi(Buffer);
     }
   }
  
  CDialog::OnOK();
 }
/*===========================================================================
 *		End of Class Event CEsmAiWanderDlg::OnOK()
 *=========================================================================*/
