/*===========================================================================
 *
 * File:	Activatordlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 10, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "ActivatorDlg.h"


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

  DEFINE_FILE("ActivatorDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmActivatorDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmActivatorDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmActivatorDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmActivatorDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmActivatorDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmActivatorDlg Constructor
 *
 *=========================================================================*/
CEsmActivatorDlg::CEsmActivatorDlg() : CEsmRecDialog(CEsmActivatorDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmActivatorDlg)
  //}}AFX_DATA_INIT
  m_pActivator = NULL;
 }
/*===========================================================================
 *		End of Class CEsmActivatorDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmActivatorDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmActivatorDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmActivatorDlg)
  DDX_Control(pDX, IDC_PERSISTCHECK, m_PersistCheck);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_MODELBUTTON, m_ModelButton);
  DDX_Control(pDX, IDC_SCRIPTLIST, m_ScriptList);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmActivatorDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmActivatorDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmActivatorDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmActivatorDlg::GetControlData()");
  CString	Buffer;  
  
	/* Update the armor pointer and data */
  m_pActivator = (CEsmActivator *) GetRecInfo()->pRecord;
  ASSERT(m_pActivator != NULL);
  
	/* Armor ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pActivator->SetID(TrimStringSpace(Buffer));
   }

	/* Armor name */
  m_NameText.GetWindowText(Buffer);
  m_pActivator->SetName(TrimStringSpace(Buffer));

	/* Item script */
  m_ScriptList.GetWindowText(Buffer);
  m_pActivator->SetScript(TrimStringSpace(Buffer));
  	
	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pActivator->SetModel(TrimStringSpace(Buffer));

	/* Record flags */
  m_pActivator->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pActivator->SetBlocked(m_BlockedCheck.GetCheck() != 0);
 }
/*===========================================================================
 *		End of Class Method CEsmActivatorDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmActivatorDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmActivatorDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_NameText.GetModify()) m_Modified = true;
  if (m_IDText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmActivatorDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmActivatorDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmActivatorDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pActivator = (CEsmActivator *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmScriptCombo(m_ScriptList);

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmActivatorDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmActivatorDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmActivatorDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {

  	/* Refill the script list if required */
  if (pRecInfo->pRecord->IsType(MWESM_REC_SCRI)) {
   esmrecinfo_t* pRecInfo = NULL;
    int	  	  Index;

    Index = m_ScriptList.GetCurSel();
    if (Index >= 0) pRecInfo = (esmrecinfo_t *) m_ScriptList.GetItemData(Index);
    FillEsmScriptCombo(m_ScriptList);
    FindComboListItem(m_ScriptList, (DWORD) pRecInfo, true);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmActivatorDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmActivatorDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmActivatorDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pActivator == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pActivator->GetID());
  UpdateTitle(m_pActivator->GetID());

	/* Item strings and values */
  m_NameText.SetWindowText(m_pActivator->GetName());
  m_NameText.SetModify(FALSE);
  
	/* Model/icon buttons */
  m_ModelButton.SetWindowText(m_pActivator->GetModel());
  
	/* Item lists */
  m_ScriptList.SelectString(-1, m_pActivator->GetScript());

	/* Record flags */
  m_BlockedCheck.SetCheck(m_pActivator->IsBlocked());
  m_PersistCheck.SetCheck(m_pActivator->IsPersist());
 }
/*===========================================================================
 *		End of Class Method CEsmActivatorDlg::SetControlData()
 *=========================================================================*/

