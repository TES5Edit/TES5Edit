/*===========================================================================
 *
 * File:	Esmlockpickdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "resource.h"
#include "EsmLockPickDlg.h"


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

  IMPLEMENT_DYNCREATE(CEsmLockPickDlg, CEsmRecDialog);
  DEFINE_FILE("EsmLockPickDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmLockPickDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmLockPickDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmLockPickDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmLockPickDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLockPickDlg Constructor
 *
 *=========================================================================*/
CEsmLockPickDlg::CEsmLockPickDlg() : CEsmRecDialog(CEsmLockPickDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmLockPickDlg)
  //}}AFX_DATA_INIT
  m_pLockPick = NULL;
 }
/*===========================================================================
 *		End of Class CEsmLockPickDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLockPickDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmLockPickDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmLockPickDlg)
  DDX_Control(pDX, IDC_ICONPICTURE, m_IconPicture);
  DDX_Control(pDX, IDC_PERSISTCHECK, m_PersistCheck);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_ICONBUTTON, m_IconButton);
  DDX_Control(pDX, IDC_MODELBUTTON, m_ModelButton);
  DDX_Control(pDX, IDC_VALUETEXT, m_ValueText);
  DDX_Control(pDX, IDC_QUALITYTEXT, m_QualityText);
  DDX_Control(pDX, IDC_WEIGHTTEXT, m_WeightText);
  DDX_Control(pDX, IDC_SCRIPTLIST, m_ScriptList);
  DDX_Control(pDX, IDC_USESTEXT, m_UsesText);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmLockPickDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLockPickDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmLockPickDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmLockPickDlg::GetControlData()");
  lockdata_t*	pLockData;
  CString	Buffer;  

	/* Update the armor pointer and data */
  m_pLockPick = (CEsmLockPick *) GetRecInfo()->pRecord;
  if (m_pLockPick == NULL) return;
  pLockData = m_pLockPick->GetLockData();
  ASSERT(pLockData != NULL);

	/* Armor ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pLockPick->SetID(TrimStringSpace(Buffer));
   }

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pLockPick->SetName(TrimStringSpace(Buffer));

	/* Item uses */
  m_UsesText.GetWindowText(Buffer);
  pLockData->Uses = atoi(Buffer);

	/* Item quality */
  m_QualityText.GetWindowText(Buffer);
  pLockData->Quality = (float) atof(Buffer);

	/* Item weight */
  m_WeightText.GetWindowText(Buffer);
  pLockData->Weight = (float) atof(Buffer);

	/* Item value */
  m_ValueText.GetWindowText(Buffer);
  pLockData->Value = atoi(Buffer);

	/* Item script */
  m_ScriptList.GetWindowText(Buffer);
  m_pLockPick->SetScript(TrimStringSpace(Buffer));

	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pLockPick->SetModel(TrimStringSpace(Buffer));

  	/* Icon filename */
  m_IconButton.GetWindowText(Buffer);
  m_pLockPick->SetIcon(TrimStringSpace(Buffer));

	/* Record flags */
  m_pLockPick->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pLockPick->SetBlocked(m_BlockedCheck.GetCheck() != 0);
 }
/*===========================================================================
 *		End of Class Method CEsmLockPickDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLockPickDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmLockPickDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_QualityText.GetModify()) m_Modified = true;
  if (m_UsesText.GetModify()) m_Modified = true;
  if (m_WeightText.GetModify()) m_Modified = true;
  if (m_ValueText.GetModify()) m_Modified = true;
  if (m_NameText.GetModify()) m_Modified = true;
  if (m_IDText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmLockPickDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLockPickDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmLockPickDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pLockPick = (CEsmLockPick *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmScriptCombo(m_ScriptList);
  m_WeightText.SetLimitText(8);
  m_ValueText.SetLimitText(8);
  m_UsesText.SetLimitText(8);
  m_QualityText.SetLimitText(8);

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmLockPickDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLockPickDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmLockPickDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
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
 *		End of Class Event CEsmLockPickDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLockPickDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmLockPickDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pLockPick == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pLockPick->GetID());
  UpdateTitle(m_pLockPick->GetID());

	/* Item strings and values */
  m_NameText.SetWindowText(m_pLockPick->GetName());
  m_QualityText.SetWindowText(m_pLockPick->GetFieldString(ESM_FIELD_QUALITY));
  m_WeightText.SetWindowText(m_pLockPick->GetFieldString(ESM_FIELD_WEIGHT));
  m_ValueText.SetWindowText(m_pLockPick->GetFieldString(ESM_FIELD_VALUE));
  m_UsesText.SetWindowText(m_pLockPick->GetFieldString(ESM_FIELD_USES));
  m_UsesText.SetModify(FALSE);
  m_NameText.SetModify(FALSE);
  m_QualityText.SetModify(FALSE);
  m_WeightText.SetModify(FALSE);
  m_ValueText.SetModify(FALSE);

	/* Model/icon buttons */
  m_ModelButton.SetWindowText(m_pLockPick->GetModel());
  m_IconButton.SetWindowText(m_pLockPick->GetIcon());
  m_IconPicture.SetEsmIcon(m_pLockPick->GetIcon());
  
	/* Item lists */
  m_ScriptList.SelectString(-1, m_pLockPick->GetScript());

	/* Record flags */
  m_BlockedCheck.SetCheck(m_pLockPick->IsBlocked());
  m_PersistCheck.SetCheck(m_pLockPick->IsPersist());
 }
/*===========================================================================
 *		End of Class Method CEsmLockPickDlg::SetControlData()
 *=========================================================================*/
