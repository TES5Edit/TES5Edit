/*===========================================================================
 *
 * File:	Esmbodypartdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 12, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmBodyPartDlg.h"


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

  IMPLEMENT_DYNCREATE(CEsmBodyPartDlg, CEsmRecDialog);
  DEFINE_FILE("EsmBodyPartDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmBodyPartDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmBodyPartDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmBodyPartDlg)
  ON_CBN_SELCHANGE(IDC_PARTTYPELIST, OnSelchangeParttypelist)
  ON_CBN_SELCHANGE(IDC_RACELIST, OnSelchangeList)
  ON_CBN_SELCHANGE(IDC_PARTLIST, OnSelchangeList)
  ON_BN_CLICKED(IDC_VAMPIRECHECK, OnSelchangeList)
  ON_BN_CLICKED(IDC_PLAYABLECHECK, OnSelchangeList)
  ON_BN_CLICKED(IDC_FEMALECHECK, OnSelchangeList)
  ON_BN_CLICKED(IDC_BLOCKEDCHECK, OnSelchangeList)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmBodyPartDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBodyPartDlg Constructor
 *
 *=========================================================================*/
CEsmBodyPartDlg::CEsmBodyPartDlg() : CEsmRecDialog(CEsmBodyPartDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmBodyPartDlg)
  //}}AFX_DATA_INIT
  m_pBodyPart = NULL;
 }
/*===========================================================================
 *		End of Class CEsmBodyPartDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBodyPartDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmBodyPartDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmBodyPartDlg)
  DDX_Control(pDX, IDC_VAMPIRECHECK, m_VampireCheck);
  DDX_Control(pDX, IDC_FEMALECHECK, m_FemaleCheck);
  DDX_Control(pDX, IDC_PLAYABLECHECK, m_PlayableCheck);
  DDX_Control(pDX, IDC_RACELIST, m_RaceList);
  DDX_Control(pDX, IDC_PARTTYPELIST, m_PartTypeList);
  DDX_Control(pDX, IDC_PARTLIST, m_PartList);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_MODELBUTTON, m_ModelButton);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP

 }
/*===========================================================================
 *		End of Class Method CEsmBodyPartDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBodyPartDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmBodyPartDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmBodyPartDlg::GetControlData()");
  bodypartdata_t* pBodyData;
  CString	  Buffer;  
  int		  ListIndex;

	/* Update the armor pointer and data */
  m_pBodyPart = (CEsmBodyPart *) GetRecInfo()->pRecord;
  if (m_pBodyPart == NULL) return;
  pBodyData = m_pBodyPart->GetBodyData();
  if (pBodyData == NULL) return;

	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pBodyPart->SetID(TrimStringSpace(Buffer));
   }

	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pBodyPart->SetModel(TrimStringSpace(Buffer));

	/* Record flags */
  m_pBodyPart->SetBlocked(m_BlockedCheck.GetCheck() != 0);
  pBodyData->Vampire = m_VampireCheck.GetCheck();
  m_pBodyPart->SetPlayable(m_PlayableCheck.GetCheck() != 0);
  m_pBodyPart->SetFemale(m_FemaleCheck.GetCheck() != 0);

	/* Body part list */
  ListIndex = m_PartList.GetCurSel();
  if (ListIndex >= 0) pBodyData->Part = (byte)m_PartList.GetItemData(ListIndex);

  	/* Body part type list */
  ListIndex = m_PartTypeList.GetCurSel();
  if (ListIndex >= 0) pBodyData->PartType = (byte)m_PartTypeList.GetItemData(ListIndex);

	/* Get race */	
  m_RaceList.GetWindowText(Buffer);
  m_pBodyPart->SetRace(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmBodyPartDlg::GetControlData()
 *=========================================================================*/

/*===========================================================================
 *
 * Class CEsmBodyPartDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmBodyPartDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_IDText.GetModify()) m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmBodyPartDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBodyPartDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmBodyPartDlg::OnInitialUpdate() {
  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the record */
  ASSERT(GetRecInfo() != NULL);
  m_pBodyPart = (CEsmBodyPart *) GetRecInfo()->pRecord;

	/* Set text limits */
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);

	/* Disable controls */
  m_PlayableCheck.EnableWindow(FALSE);

	/* Fill the various lists */
  FillEsmBodyPartCombo(m_PartList);
  FillEsmBodyPartTypeCombo(m_PartTypeList);
  FillEsmRaceCombo(m_RaceList);

  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmBodyPartDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBodyPartDlg Event - void OnSelchangeParttypelist ();
 *
 *=========================================================================*/
void CEsmBodyPartDlg::OnSelchangeParttypelist() {
  int ListIndex;
  int PartType;

  ListIndex = m_PartTypeList.GetCurSel();
  if (ListIndex < 0) return;
  PartType = m_PartTypeList.GetItemData(ListIndex);

  m_RaceList.EnableWindow(PartType == MWESM_PARTTYPE_SKIN);
  m_VampireCheck.EnableWindow(PartType == MWESM_PARTTYPE_SKIN);
  m_Modified = true;
 }
/*===========================================================================
 *		End of Class Event CEsmBodyPartDlg::OnSelchangeParttypelist()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBodyPartDlg Event - void OnSelchangeList ();
 *
 *=========================================================================*/
void CEsmBodyPartDlg::OnSelchangeList() {
  m_Modified = true;	
 }
/*===========================================================================
 *		End of Class Event CEsmBodyPartDlg::OnSelchangeList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBodyPartDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmBodyPartDlg::SetControlData (void) {
  bodypartdata_t* pBodyData;

	/* Ignore if the current item is not valid */
  if (m_pBodyPart == NULL) return;
  pBodyData = m_pBodyPart->GetBodyData();
  if (pBodyData == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pBodyPart->GetID());
  UpdateTitle(m_pBodyPart->GetID());

	/* Update Lists */
  FindComboListItem(m_PartList, pBodyData->Part, true);
  FindComboListItem(m_PartTypeList, pBodyData->PartType, true);
  m_RaceList.SelectString(-1, m_pBodyPart->GetRace());
  
	/* Model/icon buttons */
  m_ModelButton.SetWindowText(m_pBodyPart->GetModel());

	/* Enable/disable skin data controls */
  m_RaceList.EnableWindow(pBodyData->PartType == MWESM_PARTTYPE_SKIN);
  m_VampireCheck.EnableWindow(pBodyData->PartType == MWESM_PARTTYPE_SKIN);
  
	/* Record flags */
  m_BlockedCheck.SetCheck(m_pBodyPart->IsBlocked());
  m_VampireCheck.SetCheck(m_pBodyPart->IsVampire());
  m_PlayableCheck.SetCheck(m_pBodyPart->IsPlayable());
  m_FemaleCheck.SetCheck(m_pBodyPart->IsFemale());
 }
/*===========================================================================
 *		End of Class Method CEsmBodyPartDlg::SetControlData()
 *=========================================================================*/


