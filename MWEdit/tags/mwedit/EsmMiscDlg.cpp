/*===========================================================================
 *
 * File:	Esmmiscdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmMiscDlg.h"


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

  IMPLEMENT_DYNCREATE(CEsmMiscDlg, CEsmRecDialog);
  DEFINE_FILE("EsmMiscDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmMiscDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmMiscDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmMiscDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmMiscDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmMiscDlg Constructor
 *
 *=========================================================================*/
CEsmMiscDlg::CEsmMiscDlg() : CEsmRecDialog(CEsmMiscDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmMiscDlg)
  //}}AFX_DATA_INIT
  m_pMisc = NULL;
 }
/*===========================================================================
 *		End of Class CEsmMiscDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmMiscDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmMiscDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmMiscDlg)
  DDX_Control(pDX, IDC_ICONPICTURE, m_IconPicture);
  DDX_Control(pDX, IDC_PERSISTCHECK, m_PersistCheck);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_ICONBUTTON, m_IconButton);
  DDX_Control(pDX, IDC_MODELBUTTON, m_ModelButton);
  DDX_Control(pDX, IDC_VALUETEXT, m_ValueText);
  DDX_Control(pDX, IDC_WEIGHTTEXT, m_WeightText);
  DDX_Control(pDX, IDC_SCRIPTLIST, m_ScriptList);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmMiscDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmMiscDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmMiscDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmMiscDlg::GetControlData()");
  miscdata_t*	pMiscData;
  CString	Buffer;  

	/* Update the armor pointer and data */
  m_pMisc = (CEsmMisc *) GetRecInfo()->pRecord;
  if (m_pMisc == NULL) return;
  pMiscData = m_pMisc->GetMiscData();
  ASSERT(pMiscData != NULL);

	/* Armor ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pMisc->SetID(TrimStringSpace(Buffer));
   }

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pMisc->SetName(TrimStringSpace(Buffer));

	/* Item weight */
  m_WeightText.GetWindowText(Buffer);
  pMiscData->Weight = (float) atof(Buffer);

	/* Item value */
  m_ValueText.GetWindowText(Buffer);
  pMiscData->Value = atoi(Buffer);

	/* Item script */
  m_ScriptList.GetWindowText(Buffer);
  m_pMisc->SetScript(TrimStringSpace(Buffer));

	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pMisc->SetModel(TrimStringSpace(Buffer));

  	/* Icon filename */
  m_IconButton.GetWindowText(Buffer);
  m_pMisc->SetIcon(TrimStringSpace(Buffer));

	/* Record flags */
  m_pMisc->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pMisc->SetBlocked(m_BlockedCheck.GetCheck() != 0);
 }
/*===========================================================================
 *		End of Class Method CEsmMiscDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmMiscDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmMiscDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_WeightText.GetModify()) m_Modified = true;
  if (m_ValueText.GetModify()) m_Modified = true;
  if (m_NameText.GetModify()) m_Modified = true;
  if (m_IDText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmMiscDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmMiscDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmMiscDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pMisc = (CEsmMisc *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmScriptCombo(m_ScriptList);

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmMiscDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmMiscDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmMiscDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  CString Buffer;

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
 *		End of Class Event CEsmMiscDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmMiscDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmMiscDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pMisc == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pMisc->GetID());
  UpdateTitle(m_pMisc->GetID());

	/* Item strings and values */
  m_NameText.SetWindowText(m_pMisc->GetName());
  m_WeightText.SetWindowText(m_pMisc->GetFieldString(ESM_FIELD_WEIGHT));
  m_ValueText.SetWindowText(m_pMisc->GetFieldString(ESM_FIELD_VALUE));
  m_NameText.SetModify(FALSE);
  m_WeightText.SetModify(FALSE);
  m_ValueText.SetModify(FALSE);

	/* Model/icon buttons */
  m_ModelButton.SetWindowText(m_pMisc->GetModel());
  m_IconButton.SetWindowText(m_pMisc->GetIcon());
  m_IconPicture.SetEsmIcon(m_pMisc->GetIcon());
  
	/* Item lists */
  m_ScriptList.SelectString(-1, m_pMisc->GetScript());
  
	/* Record flags */
  m_BlockedCheck.SetCheck(m_pMisc->IsBlocked());
  m_PersistCheck.SetCheck(m_pMisc->IsPersist());
 }
/*===========================================================================
 *		End of Class Method CEsmMiscDlg::SetControlData()
 *=========================================================================*/
