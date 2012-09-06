/*===========================================================================
 *
 * File:	Esmglobaldlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 12, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmGlobalDlg.h"


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

  IMPLEMENT_DYNCREATE(CEsmGlobalDlg, CEsmRecDialog);
  DEFINE_FILE("EsmApparatusDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmGlobalDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmGlobalDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmGlobalDlg)
  ON_CBN_SELCHANGE(IDC_TYPELIST, OnSelchangeTypelist)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmGlobalDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmGlobalDlg Constructor
 *
 *=========================================================================*/
CEsmGlobalDlg::CEsmGlobalDlg() : CEsmRecDialog(CEsmGlobalDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmGlobalDlg)
  //}}AFX_DATA_INIT
  m_pGlobal = NULL;
 }
/*===========================================================================
 *		End of Class CEsmGlobalDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmGlobalDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmGlobalDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmGlobalDlg)
  DDX_Control(pDX, IDC_VALUETEXT, m_ValueText);
  DDX_Control(pDX, IDC_TYPELIST,  m_TypeList);
  DDX_Control(pDX, IDC_IDTEXT,    m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmGlobalDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmGlobalDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmGlobalDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmGlobalDlg::GetControlData()");
  CString	Buffer;  
  float		Value;
  int		Index;

	/* Update the record pointer and data */
  m_pGlobal = (CEsmGlobal *) GetRecInfo()->pRecord;
  if (m_pGlobal == NULL) return;

	/* Armor ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pGlobal->SetID(TrimStringSpace(Buffer));
   }

	/* Item type */
  Index = m_TypeList.GetCurSel();
  if (Index >= 0) m_pGlobal->SetType(m_TypeList.GetItemData(Index));

	/* Item value */
  m_ValueText.GetWindowText(Buffer);
  Value = (float) atof(Buffer);

  if (m_pGlobal->GetType() == MWESM_GLOBAL_SHORT) {
    if (Value < SHRT_MIN) Value = SHRT_MIN;
    if (Value > SHRT_MAX) Value = SHRT_MAX;
   }
  else if (m_pGlobal->GetType() == MWESM_GLOBAL_LONG) {
    if (Value < LONG_MIN) Value = (float) LONG_MIN;
    if (Value > LONG_MAX) Value = (float) LONG_MAX;
   }

  m_pGlobal->SetValue(Value);
 }
/*===========================================================================
 *		End of Class Method CEsmGlobalDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmGlobalDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmGlobalDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_ValueText.GetModify()) m_Modified = true;
  if (m_IDText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmGlobalDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmGlobalDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmGlobalDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pGlobal = (CEsmGlobal *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmGlobalTypeCombo(m_TypeList);
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_ValueText.SetLimitText(16);

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmGlobalDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmGlobalDlg Event - void OnSelchangeTypelist ();
 *
 *=========================================================================*/
void CEsmGlobalDlg::OnSelchangeTypelist() {
  m_Modified = true;
 }
/*===========================================================================
 *		End of Class Event CEsmGlobalDlg::OnSelchangeTypelist()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmGlobalDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmGlobalDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pGlobal == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pGlobal->GetID());
  UpdateTitle(m_pGlobal->GetID());

	/* Item strings and values */
  m_ValueText.SetWindowText(m_pGlobal->GetFieldString(ESM_FIELD_VALUE));
  m_IDText.SetModify(FALSE);
  m_ValueText.SetModify(FALSE);

	/* Item lists */
  FindComboListItem(m_TypeList, m_pGlobal->GetType(), true);
 }
/*===========================================================================
 *		End of Class Method CEsmGlobalDlg::SetControlData()
 *=========================================================================*/


