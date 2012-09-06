/*===========================================================================
 *
 * File:	Esmapparatusdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmApparatusDlg.h"


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

  IMPLEMENT_DYNCREATE(CEsmApparatusDlg, CEsmRecDialog);
  DEFINE_FILE("EsmApparatusDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmApparatusDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmApparatusDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmApparatusDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmApparatusDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmApparatusDlg Constructor
 *
 *=========================================================================*/
CEsmApparatusDlg::CEsmApparatusDlg() : CEsmRecDialog(CEsmApparatusDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmApparatusDlg)
  //}}AFX_DATA_INIT
  m_pApparatus = NULL;
 }
/*===========================================================================
 *		End of Class CEsmApparatusDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmApparatusDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmApparatusDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmApparatusDlg)
  DDX_Control(pDX, IDC_ICONPICTURE, m_IconPicture);
  DDX_Control(pDX, IDC_PERSISTCHECK, m_PersistCheck);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_ICONBUTTON, m_IconButton);
  DDX_Control(pDX, IDC_MODELBUTTON, m_ModelButton);
  DDX_Control(pDX, IDC_VALUETEXT, m_ValueText);
  DDX_Control(pDX, IDC_QUALITYTEXT, m_QualityText);
  DDX_Control(pDX, IDC_WEIGHTTEXT, m_WeightText);
  DDX_Control(pDX, IDC_SCRIPTLIST, m_ScriptList);
  DDX_Control(pDX, IDC_TYPELIST, m_TypeList);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmApparatusDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmApparatusDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmApparatusDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmApparatusDlg::GetControlData()");
  appadata_t*	pAppaData;
  CString	Buffer;  
  int		Index;

	/* Update the armor pointer and data */
  m_pApparatus = (CEsmApparatus *) GetRecInfo()->pRecord;
  if (m_pApparatus == NULL) return;
  pAppaData = m_pApparatus->GetAppaData();
  ASSERT(pAppaData != NULL);

	/* Armor ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pApparatus->SetID(TrimStringSpace(Buffer));
   }

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pApparatus->SetName(TrimStringSpace(Buffer));

	/* Item type */
  Index = m_TypeList.GetCurSel();
  if (Index >= 0) pAppaData->Type = m_TypeList.GetItemData(Index);

	/* Item quality */
  m_QualityText.GetWindowText(Buffer);
  pAppaData->Quality = (float) atof(Buffer);

	/* Item weight */
  m_WeightText.GetWindowText(Buffer);
  pAppaData->Weight = (float) atof(Buffer);

	/* Item value */
  m_ValueText.GetWindowText(Buffer);
  pAppaData->Value = atoi(Buffer);

	/* Item script */
  m_ScriptList.GetWindowText(Buffer);
  m_pApparatus->SetScript(TrimStringSpace(Buffer));

	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pApparatus->SetModel(TrimStringSpace(Buffer));

  	/* Icon filename */
  m_IconButton.GetWindowText(Buffer);
  m_pApparatus->SetIcon(TrimStringSpace(Buffer));

	/* Record flags */
  m_pApparatus->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pApparatus->SetBlocked(m_BlockedCheck.GetCheck() != 0);
 }
/*===========================================================================
 *		End of Class Method CEsmApparatusDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmApparatusDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmApparatusDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_QualityText.GetModify()) m_Modified = true;
  if (m_WeightText.GetModify()) m_Modified = true;
  if (m_ValueText.GetModify()) m_Modified = true;
  if (m_NameText.GetModify()) m_Modified = true;
  if (m_IDText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmApparatusDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmApparatusDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmApparatusDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pApparatus = (CEsmApparatus *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmApparatusTypeCombo(m_TypeList);
  FillEsmScriptCombo(m_ScriptList);
  m_WeightText.SetLimitText(8);
  m_ValueText.SetLimitText(8);
  m_QualityText.SetLimitText(8);

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmApparatusDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmApparatusDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmApparatusDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {

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
 *		End of Class Event CEsmApparatusDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmApparatusDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmApparatusDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pApparatus == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pApparatus->GetID());
  UpdateTitle(m_pApparatus->GetID());

	/* Item strings and values */
  m_NameText.SetWindowText(m_pApparatus->GetName());
  m_QualityText.SetWindowText(m_pApparatus->GetFieldString(ESM_FIELD_QUALITY));
  m_WeightText.SetWindowText(m_pApparatus->GetFieldString(ESM_FIELD_WEIGHT));
  m_ValueText.SetWindowText(m_pApparatus->GetFieldString(ESM_FIELD_VALUE));
  m_NameText.SetModify(FALSE);
  m_QualityText.SetModify(FALSE);
  m_WeightText.SetModify(FALSE);
  m_ValueText.SetModify(FALSE);

	/* Model/icon buttons */
  m_ModelButton.SetWindowText(m_pApparatus->GetModel());
  m_IconButton.SetWindowText(m_pApparatus->GetIcon());
  m_IconPicture.SetEsmIcon(m_pApparatus->GetIcon());
  
	/* Item lists */
  FindComboListItem(m_TypeList, m_pApparatus->GetAppaTypeID(), true);
  m_ScriptList.SelectString(-1, m_pApparatus->GetScript());
  
	/* Record flags */
  m_BlockedCheck.SetCheck(m_pApparatus->IsBlocked());
  m_PersistCheck.SetCheck(m_pApparatus->IsPersist());
 }
/*===========================================================================
 *		End of Class Method CEsmApparatusDlg::SetControlData()
 *=========================================================================*/
