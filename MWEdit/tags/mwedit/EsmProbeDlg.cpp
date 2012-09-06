/*===========================================================================
 *
 * File:	Esmprobedlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmProbeDlg.h"


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

  IMPLEMENT_DYNCREATE(CEsmProbeDlg, CEsmRecDialog);
  DEFINE_FILE("EsmProbeDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmProbeDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmProbeDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmProbeDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmProbeDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmProbeDlg Constructor
 *
 *=========================================================================*/
CEsmProbeDlg::CEsmProbeDlg() : CEsmRecDialog(CEsmProbeDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmProbeDlg)
  //}}AFX_DATA_INIT
  m_pProbe = NULL;
 }
/*===========================================================================
 *		End of Class CEsmProbeDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmProbeDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmProbeDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmProbeDlg)
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
 *		End of Class Method CEsmProbeDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmProbeDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmProbeDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmProbeDlg::GetControlData()");
  probedata_t*	pProbeData;
  CString	Buffer;  

	/* Update the armor pointer and data */
  m_pProbe = (CEsmProbe *) GetRecInfo()->pRecord;
  if (m_pProbe == NULL) return;
  pProbeData = m_pProbe->GetProbeData();
  ASSERT(pProbeData != NULL);

	/* Armor ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pProbe->SetID(TrimStringSpace(Buffer));
   }

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pProbe->SetName(TrimStringSpace(Buffer));

	/* Item uses */
  m_UsesText.GetWindowText(Buffer);
  pProbeData->Uses = atoi(Buffer);

	/* Item quality */
  m_QualityText.GetWindowText(Buffer);
  pProbeData->Quality = (float) atof(Buffer);

	/* Item weight */
  m_WeightText.GetWindowText(Buffer);
  pProbeData->Weight = (float) atof(Buffer);

	/* Item value */
  m_ValueText.GetWindowText(Buffer);
  pProbeData->Value = atoi(Buffer);

	/* Item script */
  m_ScriptList.GetWindowText(Buffer);
  m_pProbe->SetScript(TrimStringSpace(Buffer));

	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pProbe->SetModel(TrimStringSpace(Buffer));

  	/* Icon filename */
  m_IconButton.GetWindowText(Buffer);
  m_pProbe->SetIcon(TrimStringSpace(Buffer));

	/* Record flags */
  m_pProbe->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pProbe->SetBlocked(m_BlockedCheck.GetCheck() != 0);
 }
/*===========================================================================
 *		End of Class Method CEsmProbeDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmProbeDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmProbeDlg::IsModified (void) {
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
 *		End of Class Method CEsmProbeDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmProbeDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmProbeDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pProbe = (CEsmProbe *) GetRecInfo()->pRecord;

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
 *		End of Class Event CEsmProbeDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmProbeDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmProbeDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {

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
 *		End of Class Event CEsmProbeDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmProbeDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmProbeDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pProbe == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pProbe->GetID());
  UpdateTitle(m_pProbe->GetID());

	/* Item strings and values */
  m_NameText.SetWindowText(m_pProbe->GetName());
  m_QualityText.SetWindowText(m_pProbe->GetFieldString(ESM_FIELD_QUALITY));
  m_WeightText.SetWindowText(m_pProbe->GetFieldString(ESM_FIELD_WEIGHT));
  m_ValueText.SetWindowText(m_pProbe->GetFieldString(ESM_FIELD_VALUE));
  m_UsesText.SetWindowText(m_pProbe->GetFieldString(ESM_FIELD_USES));
  m_UsesText.SetModify(FALSE);
  m_NameText.SetModify(FALSE);
  m_QualityText.SetModify(FALSE);
  m_WeightText.SetModify(FALSE);
  m_ValueText.SetModify(FALSE);

	/* Model/icon buttons */
  m_ModelButton.SetWindowText(m_pProbe->GetModel());
  m_IconButton.SetWindowText(m_pProbe->GetIcon());
  m_IconPicture.SetEsmIcon(m_pProbe->GetIcon());
  
	/* Item lists */
  m_ScriptList.SelectString(-1, m_pProbe->GetScript());

	/* Record flags */
  m_BlockedCheck.SetCheck(m_pProbe->IsBlocked());
  m_PersistCheck.SetCheck(m_pProbe->IsPersist());
 }
/*===========================================================================
 *		End of Class Method CEsmProbeDlg::SetControlData()
 *=========================================================================*/
