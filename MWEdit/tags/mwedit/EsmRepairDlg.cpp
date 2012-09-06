/*===========================================================================
 *
 * File:	Esmrepairdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmRepairDlg.h"


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

  IMPLEMENT_DYNCREATE(CEsmRepairDlg, CEsmRecDialog);
  DEFINE_FILE("EsmRepairDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmRepairDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmRepairDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmRepairDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmRepairDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRepairDlg Constructor
 *
 *=========================================================================*/
CEsmRepairDlg::CEsmRepairDlg() : CEsmRecDialog(CEsmRepairDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmRepairDlg)
  //}}AFX_DATA_INIT
  m_pRepair = NULL;
 }
/*===========================================================================
 *		End of Class CEsmRepairDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRepairDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmRepairDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmRepairDlg)
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
 *		End of Class Method CEsmRepairDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRepairDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmRepairDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmRepairDlg::GetControlData()");
  repairdata_t*	pRepairData;
  CString	Buffer;  

	/* Update the armor pointer and data */
  m_pRepair = (CEsmRepair *) GetRecInfo()->pRecord;
  if (m_pRepair == NULL) return;
  pRepairData = m_pRepair->GetRepairData();
  ASSERT(pRepairData != NULL);

	/* Armor ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pRepair->SetID(TrimStringSpace(Buffer));
   }

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pRepair->SetName(TrimStringSpace(Buffer));

	/* Item uses */
  m_UsesText.GetWindowText(Buffer);
  pRepairData->Uses = atoi(Buffer);

	/* Item quality */
  m_QualityText.GetWindowText(Buffer);
  pRepairData->Quality = (float) atof(Buffer);

	/* Item weight */
  m_WeightText.GetWindowText(Buffer);
  pRepairData->Weight = (float) atof(Buffer);

	/* Item value */
  m_ValueText.GetWindowText(Buffer);
  pRepairData->Value = atoi(Buffer);

	/* Item script */
  m_ScriptList.GetWindowText(Buffer);
  m_pRepair->SetScript(TrimStringSpace(Buffer));

	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pRepair->SetModel(TrimStringSpace(Buffer));

  	/* Icon filename */
  m_IconButton.GetWindowText(Buffer);
  m_pRepair->SetIcon(TrimStringSpace(Buffer));

	/* Record flags */
  m_pRepair->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pRepair->SetBlocked(m_BlockedCheck.GetCheck() != 0);
 }
/*===========================================================================
 *		End of Class Method CEsmRepairDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRepairDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmRepairDlg::IsModified (void) {
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
 *		End of Class Method CEsmRepairDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRepairDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmRepairDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pRepair = (CEsmRepair *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmScriptCombo(m_ScriptList);
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_WeightText.SetLimitText(8);
  m_ValueText.SetLimitText(8);
  m_UsesText.SetLimitText(8);
  m_QualityText.SetLimitText(8);

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmRepairDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRepairDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmRepairDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {

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
 *		End of Class Event CEsmRepairDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRepairDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmRepairDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pRepair == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pRepair->GetID());
  UpdateTitle(m_pRepair->GetID());

	/* Item strings and values */
  m_NameText.SetWindowText(m_pRepair->GetName());
  m_QualityText.SetWindowText(m_pRepair->GetFieldString(ESM_FIELD_QUALITY));
  m_WeightText.SetWindowText(m_pRepair->GetFieldString(ESM_FIELD_WEIGHT));
  m_ValueText.SetWindowText(m_pRepair->GetFieldString(ESM_FIELD_VALUE));
  m_UsesText.SetWindowText(m_pRepair->GetFieldString(ESM_FIELD_USES));
  m_UsesText.SetModify(FALSE);
  m_NameText.SetModify(FALSE);
  m_QualityText.SetModify(FALSE);
  m_WeightText.SetModify(FALSE);
  m_ValueText.SetModify(FALSE);

	/* Model/icon buttons */
  m_ModelButton.SetWindowText(m_pRepair->GetModel());
  m_IconButton.SetWindowText(m_pRepair->GetIcon());
  m_IconPicture.SetEsmIcon(m_pRepair->GetIcon());
  
	/* Item lists */
  m_ScriptList.SelectString(-1, m_pRepair->GetScript());

	/* Record flags */
  m_BlockedCheck.SetCheck(m_pRepair->IsBlocked());
  m_PersistCheck.SetCheck(m_pRepair->IsPersist());
 }
/*===========================================================================
 *		End of Class Method CEsmRepairDlg::SetControlData()
 *=========================================================================*/
