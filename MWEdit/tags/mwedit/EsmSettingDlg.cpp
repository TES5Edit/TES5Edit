/*===========================================================================
 *
 * File:	Esmsettingdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 17, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmSettingDlg.h"


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

  IMPLEMENT_DYNCREATE(CEsmSettingDlg, CEsmRecDialog);
  DEFINE_FILE("EsmSettingDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmSettingDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmSettingDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmSettingDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmSettingDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSettingDlg Constructor
 *
 *=========================================================================*/
CEsmSettingDlg::CEsmSettingDlg() : CEsmRecDialog(CEsmSettingDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmSettingDlg)
  //}}AFX_DATA_INIT
  m_pSetting = NULL;
 }
/*===========================================================================
 *		End of Class CEsmSettingDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSettingDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmSettingDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmSettingDlg)
  DDX_Control(pDX, IDC_VALUETEXT, m_ValueText);
  DDX_Control(pDX, IDC_TYPELABEL, m_TypeLabel);
  DDX_Control(pDX, IDC_IDTEXT,    m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmSettingDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSettingDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmSettingDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmSettingDlg::GetControlData()");
  CString	Buffer;  

	/* Update the record pointer and data */
  m_pSetting = (CEsmGameSetting *) GetRecInfo()->pRecord;
  if (m_pSetting == NULL) return;

	/* Item value */
  m_ValueText.GetWindowText(Buffer);
  m_pSetting->SetValue(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmSettingDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSettingDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmSettingDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_ValueText.GetModify()) m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmSettingDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSettingDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmSettingDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pSetting = (CEsmGameSetting *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  m_ValueText.SetLimitText(256);

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmSettingDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSettingDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmSettingDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pSetting == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pSetting->GetID());
  UpdateTitle(m_pSetting->GetID());

	/* Item strings and values */
  m_ValueText.SetWindowText(m_pSetting->GetValue());
  m_TypeLabel.SetWindowText(m_pSetting->GetTypeString());
  m_IDText.SetModify(FALSE);
  m_ValueText.SetModify(FALSE);

 }
/*===========================================================================
 *		End of Class Method CEsmSettingDlg::SetControlData()
 *=========================================================================*/


