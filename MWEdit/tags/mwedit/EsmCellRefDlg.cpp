/*===========================================================================
 *
 * File:	Esmcellrefdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 22, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmCellRefDlg.h"


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

  DEFINE_FILE("EsmCellRefDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmCellRefDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmCellRefDlg, CDialog)
  //{{AFX_MSG_MAP(CEsmCellRefDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmCellRefDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCellRefDlg Constructor
 *
 *=========================================================================*/
CEsmCellRefDlg::CEsmCellRefDlg(CWnd* pParent) : CDialog(CEsmCellRefDlg::IDD, pParent) {
  //{{AFX_DATA_INIT(CEsmCellRefDlg)
  //}}AFX_DATA_INIT
  m_HasNewCellRef = true;
  m_pCellRef      = NULL;
  m_pCell	  = NULL;
  m_IsAlreadyNew  = false;
 }
/*===========================================================================
 *		End of Class CEsmCellRefDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCellRefDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmCellRefDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmCellRefDlg)
  DDX_Control(pDX, IDC_SCALETEXT, m_ScaleText);
  DDX_Control(pDX, IDC_ZROTTEXT, m_ZRotText);
  DDX_Control(pDX, IDC_YROTTEXT, m_YRotText);
  DDX_Control(pDX, IDC_XROTTEXT, m_XRotText);
  DDX_Control(pDX, IDC_ZPOSTEXT, m_ZPosText);
  DDX_Control(pDX, IDC_YPOSTEXT, m_YPosText);
  DDX_Control(pDX, IDC_XPOSTEXT, m_XPosText);
  //}}AFX_DATA_MAP
}
/*===========================================================================
 *		End of Class Method CEsmCellRefDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCellRefDlg Method - bool DoModal (pCellRef, IsNew, pCell);
 *
 * Description
 *
 *=========================================================================*/
bool CEsmCellRefDlg::DoModal (CEsmSubCellRef* pCellRef, const bool IsNew, CEsmCell* pCell) {
  //DEFINE_FUNCTION("CEsmCellRefDlg::DoModal()");
  int Result;

	/* Initialize the dialog members */
  m_pCellRef = pCellRef;
  m_pCell    = pCell;
  m_IsAlreadyNew  = IsNew;
  m_HasNewCellRef = false;  
  if (pCell == NULL || pCellRef == NULL) return (false);
  
	/* Display the model dialog */
  Result = CDialog::DoModal();
  if (Result != IDOK) return (false);

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmCellRefDlg::DoModal()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCellRefDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmCellRefDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmCellRefDlg::GetControlData()");
  CEsmSubPos6*	  pPosition;
  CEsmSubFloat*	  pScale;
  pos6data_t*     pPosData;
  CString	  Buffer;
  CEsmSubCellRef* pNewCellRef;
  CEsmSubFRMR*    pIndexData;

	/* Create a new cell ref if the current one is not active */
  if (!m_IsAlreadyNew) {
    CreatePointer(pNewCellRef, CEsmSubCellRef);
    pNewCellRef->Copy(m_pCellRef);
    m_pCellRef = pNewCellRef;
    m_HasNewCellRef = true;

    pIndexData = (CEsmSubFRMR *) m_pCellRef->FindSubRecord(MWESM_SUBREC_FRMR);
    if (pIndexData != NULL) pIndexData->SetFlag(1);
   }

	/* Set the position data */
  pPosition = (CEsmSubPos6 *) m_pCellRef->FindSubRecord(MWESM_SUBREC_DATA);

  if (pPosition == NULL) {
    pPosition = (CEsmSubPos6 *) m_pCell->AllocNewSubRecord(MWESM_SUBREC_DATA);
    m_pCellRef->AddSubRec(pPosition);
   }

  if (pPosition != NULL) {
    pPosData = pPosition->GetPosData();

    m_XPosText.GetWindowText(Buffer);
    pPosData->PosX = (float) atof(Buffer);
    m_YPosText.GetWindowText(Buffer);
    pPosData->PosY = (float) atof(Buffer);
    m_ZPosText.GetWindowText(Buffer);
    pPosData->PosZ = (float) atof(Buffer);

    m_XRotText.GetWindowText(Buffer);
    pPosData->RotX = (float) atof(Buffer);
    m_YRotText.GetWindowText(Buffer);
    pPosData->RotY = (float) atof(Buffer);
    m_ZRotText.GetWindowText(Buffer);
    pPosData->RotZ = (float) atof(Buffer);
   }

	/* Set the scale data */
  pScale = (CEsmSubFloat *) m_pCellRef->FindSubRecord(MWESM_SUBREC_XSCL);

  if (pScale == NULL) {
    pScale = (CEsmSubFloat *) m_pCell->AllocNewSubRecord(MWESM_SUBREC_XSCL);
    m_pCellRef->AddSubRec(pScale);
   }

  if (pScale != NULL) {
    m_ScaleText.GetWindowText(Buffer);    
    pScale->SetValue((float) atof(Buffer));
   }

 }
/*===========================================================================
 *		End of Class Method CEsmCellRefDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCellRefDlg Event - void OnCancel ();
 *
 *=========================================================================*/
void CEsmCellRefDlg::OnCancel() {
  CDialog::OnCancel();
 }
/*===========================================================================
 *		End of Class Event CEsmCellRefDlg::OnCancel()
 *=========================================================================*/

 
/*===========================================================================
 *
 * Class CEsmCellRefDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmCellRefDlg::OnInitDialog() {
  CDialog::OnInitDialog();

  SetControlData();
	
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmCellRefDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCellRefDlg Event - void OnOK ();
 *
 *=========================================================================*/
void CEsmCellRefDlg::OnOK() {
  GetControlData();
  CDialog::OnOK();
 }
/*===========================================================================
 *		End of Class Event CEsmCellRefDlg::OnOK()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCellRefDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmCellRefDlg::SetControlData (void) {
  CEsmSubPos6*	pPosition;
  CEsmSubFloat*	pScale;
  pos6data_t*   pPosData;
  CString	Buffer;

	/* Set the position data */
  pPosition = (CEsmSubPos6 *) m_pCellRef->FindSubRecord(MWESM_SUBREC_DATA);

  if (pPosition != NULL) {
    pPosData = pPosition->GetPosData();
    Buffer.Format(_T("%f"), pPosData->PosX);
    m_XPosText.SetWindowText(Buffer);
    Buffer.Format(_T("%f"), pPosData->PosY);
    m_YPosText.SetWindowText(Buffer);
    Buffer.Format(_T("%f"), pPosData->PosZ);
    m_ZPosText.SetWindowText(Buffer);
    Buffer.Format(_T("%f"), pPosData->RotX);
    m_XRotText.SetWindowText(Buffer);
    Buffer.Format(_T("%f"), pPosData->RotY);
    m_YRotText.SetWindowText(Buffer);
    Buffer.Format(_T("%f"), pPosData->RotZ);
    m_ZRotText.SetWindowText(Buffer);
   }
  else {
    m_XPosText.SetWindowText(_T(""));
    m_YPosText.SetWindowText(_T(""));
    m_ZPosText.SetWindowText(_T(""));
    m_XRotText.SetWindowText(_T(""));
    m_YRotText.SetWindowText(_T(""));
    m_ZRotText.SetWindowText(_T(""));
   }

	/* Set the scale data */
  pScale = (CEsmSubFloat *) m_pCellRef->FindSubRecord(MWESM_SUBREC_XSCL);

  if (pScale != NULL) {
    Buffer.Format(_T("%f"), pScale->GetValue());
    m_ScaleText.SetWindowText(Buffer);    
   }
  else {
    m_ScaleText.SetWindowText(_T("1.0"));
   }

 }
/*===========================================================================
 *		End of Class Method CEsmCellRefDlg::SetControlData()
 *=========================================================================*/

