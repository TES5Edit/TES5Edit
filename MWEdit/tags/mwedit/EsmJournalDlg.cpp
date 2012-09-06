/*===========================================================================
 *
 * File:	Esmjournaldlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	March 2, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmJournalDlg.h"
#include "MWEditDoc.h"
#include "EsmUtils.h"
#include "windows/WinUtil.h"


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

  DEFINE_FILE("EsmJournalDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmJournalDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmJournalDlg, CDialog)
  //{{AFX_MSG_MAP(CEsmJournalDlg)
	ON_BN_CLICKED(IDC_NAMECHECK, OnNamecheck)
	ON_BN_CLICKED(IDC_FINISHCHECK, OnFinishcheck)
	ON_BN_CLICKED(IDC_RESTARTCHECK, OnRestartcheck)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmJournalDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmJournalDlg Constructor
 *
 *=========================================================================*/
CEsmJournalDlg::CEsmJournalDlg(CWnd* pParent) : CDialog(CEsmJournalDlg::IDD, pParent) {
  //{{AFX_DATA_INIT(CEsmJournalDlg)
  //}}AFX_DATA_INIT
  m_pInfo = NULL;
  m_IsNew = false;
  m_pDocument = NULL;
  m_AlreadyIsNew = false;
 }
/*===========================================================================
 *		End of Class CEsmJournalDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmJournalDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmJournalDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmJournalDlg)
  DDX_Control(pDX, IDC_DISPOSITIONTEXT, m_IndexText);
  DDX_Control(pDX, IDC_RESTARTCHECK, m_RestartCheck);
  DDX_Control(pDX, IDC_FINISHCHECK, m_FinishCheck);
  DDX_Control(pDX, IDC_NAMECHECK, m_NameCheck);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 
 }
/*===========================================================================
 *		End of Class Method CEsmJournalDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmJournalDlg Method - bool DoModal (pInfo, IsNew, pDocument);
 *
 * Description
 *
 *=========================================================================*/
bool CEsmJournalDlg::DoModal (CEsmInfo* pInfo, const bool IsNew, CMWEditDoc* pDocument) {
  int Result;

	/* Initialize the class members */  
  m_pInfo = pInfo;
  m_IsNew = false;
  m_AlreadyIsNew = IsNew;
  m_pDocument = pDocument;
  if (pInfo == NULL || pDocument == NULL) return (false);

	/* Display the modal window */
  Result = CDialog::DoModal();
  if (Result != IDOK) return (false);
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmJournalDlg::DoModal()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmJournalDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmJournalDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmJournalDlg::GetControlData()");
  CString	Buffer;
  CEsmInfo*	pNewInfo;
  CEsmSubByte*  pByteSubRec;
  infodata_t*	pInfoData = m_pInfo->GetInfoData();
  int		FuncIndex = 0;

  	/* Create a new object if required */
  if (!m_AlreadyIsNew) {
    CreatePointer(pNewInfo, CEsmInfo);
    pNewInfo->Copy(m_pInfo);
    pNewInfo->SetDialParent(m_pInfo->GetDialParent());
    m_pInfo = pNewInfo;
    m_pInfo->SetFile(m_pDocument->GetActivePlugin());
    m_IsNew = true;
   } 

	/* Get the main text */
  m_NameText.GetWindowText(Buffer);
  m_pInfo->SetResponse(Buffer);

	/* Index */
  m_IndexText.GetWindowText(Buffer);
  pInfoData->Disposition = atoi(Buffer);

	/* Flags */
  m_pInfo->DeleteSubRecords(MWESM_SUBREC_QSTF);
  m_pInfo->DeleteSubRecords(MWESM_SUBREC_QSTR);
  m_pInfo->DeleteSubRecords(MWESM_SUBREC_QSTN);

  if (m_NameCheck.GetCheck()) {
    pByteSubRec = (CEsmSubByte *) m_pInfo->AllocateSubRecord(MWESM_SUBREC_QSTN);
    pByteSubRec->SetValue(1);
   }
  else if (m_RestartCheck.GetCheck()) {
    pByteSubRec = (CEsmSubByte *) m_pInfo->AllocateSubRecord(MWESM_SUBREC_QSTR);
    pByteSubRec->SetValue(1);
   }
  else if (m_FinishCheck.GetCheck()) {
    pByteSubRec = (CEsmSubByte *) m_pInfo->AllocateSubRecord(MWESM_SUBREC_QSTF);
    pByteSubRec->SetValue(1);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmJournalDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmJournalDlg Event - void OnCancel ();
 *
 *=========================================================================*/
void CEsmJournalDlg::OnCancel() {
  CDialog::OnCancel();
 }
/*===========================================================================
 *		End of Class Event CEsmJournalDlg::OnCancel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmJournalDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmJournalDlg::OnInitDialog() {
  CDialog::OnInitDialog();

	/* Initilaize the text controls */
  m_NameText.SetLimitText(512);
  m_IndexText.SetLimitText(8);

  SetControlData();	
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmJournalDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmJournalDlg Event - void OnOK ();
 *
 *=========================================================================*/
void CEsmJournalDlg::OnOK() {
  GetControlData();
  CDialog::OnOK();
 }
/*===========================================================================
 *		End of Class Event CEsmJournalDlg::OnOK()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmJournalDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmJournalDlg::SetControlData (void) {
  CString	  Buffer;
  int		  ArrayIndex;

	/* Set the info ID and dialog title */
  m_IDText.SetWindowText(m_pInfo->GetID());
  Buffer.Format(_T("%s -- Journal Info"), m_pDocument->GetTitle());
  SetWindowText(Buffer);

	/* Name/result text */
  m_NameText.SetWindowText(m_pInfo->GetResponse());

	/* Index */
  Buffer.Format(_T("%d"), m_pInfo->GetDisposition());
  m_IndexText.SetWindowText(Buffer);

	/* Flags */
  m_NameCheck.SetCheck((m_pInfo->FindFirst(MWESM_SUBREC_QSTN, ArrayIndex) != NULL));
  m_FinishCheck.SetCheck(m_pInfo->FindFirst(MWESM_SUBREC_QSTF, ArrayIndex) != NULL);
  m_RestartCheck.SetCheck(m_pInfo->FindFirst(MWESM_SUBREC_QSTR, ArrayIndex) != NULL);
 }
/*===========================================================================
 *		End of Class Method CEsmJournalDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Checkbox Events
 *
 *=========================================================================*/
void CEsmJournalDlg::OnNamecheck() {
  m_FinishCheck.SetCheck(0);
  m_RestartCheck.SetCheck(0);
 }

void CEsmJournalDlg::OnFinishcheck() {
  m_NameCheck.SetCheck(0);
  m_RestartCheck.SetCheck(0);
 }

void CEsmJournalDlg::OnRestartcheck() {
  m_FinishCheck.SetCheck(0);
  m_NameCheck.SetCheck(0);
 }
/*===========================================================================
 *		End of Checkbox Events
 *=========================================================================*/
