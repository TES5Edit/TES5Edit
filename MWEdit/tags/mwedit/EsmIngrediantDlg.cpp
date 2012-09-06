/*===========================================================================
 *
 * File:	Esmingrediantdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 15, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmIngrediantDlg.h"

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

  IMPLEMENT_DYNCREATE(CEsmIngrediantDlg, CEsmRecDialog);
  DEFINE_FILE("EsmIngrediantDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmIngrediantDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmIngrediantDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmIngrediantDlg)
  ON_CBN_SELCHANGE(IDC_EFFECTLIST1, OnSelchangeEffectlist1)
  ON_CBN_SELCHANGE(IDC_EFFECTLIST2, OnSelchangeEffectlist2)
  ON_CBN_SELCHANGE(IDC_EFFECTLIST3, OnSelchangeEffectlist3)
  ON_CBN_SELCHANGE(IDC_EFFECTLIST4, OnSelchangeEffectlist4)
  ON_CBN_SELCHANGE(IDC_SKILLLIST1,  OnSelchangeSkilllist1)
  ON_CBN_SELCHANGE(IDC_SKILLLIST2,  OnSelchangeSkilllist2)
  ON_CBN_SELCHANGE(IDC_SKILLLIST3,  OnSelchangeSkilllist3)
  ON_CBN_SELCHANGE(IDC_SKILLLIST4,  OnSelchangeSkilllist4)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmIngrediantDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIngrediantDlg Constructor
 *
 *=========================================================================*/
CEsmIngrediantDlg::CEsmIngrediantDlg() : CEsmRecDialog(CEsmIngrediantDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmIngrediantDlg)
  //}}AFX_DATA_INIT
  int Index;
  m_pIngrediant = NULL;

  for (Index = 0; Index < MWESM_INGRE_NUMENCHANTS; Index++) {
    m_pEffectInfo[Index] = NULL;
   }

 }
/*===========================================================================
 *		End of Class CEsmIngrediantDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIngrediantDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmIngrediantDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmIngrediantDlg)
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

  DDX_Control(pDX, IDC_EFFECTLIST1, m_EffectList[0]);
  DDX_Control(pDX, IDC_EFFECTLIST2, m_EffectList[1]);
  DDX_Control(pDX, IDC_EFFECTLIST3, m_EffectList[2]);
  DDX_Control(pDX, IDC_EFFECTLIST4, m_EffectList[3]);
  DDX_Control(pDX, IDC_SKILLLIST1, m_SkillList[0]);
  DDX_Control(pDX, IDC_SKILLLIST2, m_SkillList[1]);
  DDX_Control(pDX, IDC_SKILLLIST3, m_SkillList[2]);
  DDX_Control(pDX, IDC_SKILLLIST4, m_SkillList[3]);
 }
/*===========================================================================
 *		End of Class Method CEsmIngrediantDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIngrediantDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmIngrediantDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmIngrediantDlg::GetControlData()");
  ingredata_t*	 pIngreData;
  CString	 Buffer;  

	/* Update the armor pointer and data */
  m_pIngrediant = (CEsmIngrediant *) GetRecInfo()->pRecord;
  if (m_pIngrediant == NULL) return;
  pIngreData = m_pIngrediant->GetIngreData();
  ASSERT(pIngreData != NULL);

	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pIngrediant->SetID(TrimStringSpace(Buffer));
   }

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pIngrediant->SetName(TrimStringSpace(Buffer));

	/* Item weight */
  m_WeightText.GetWindowText(Buffer);
  pIngreData->Weight = (float) atof(Buffer);

	/* Item value */
  m_ValueText.GetWindowText(Buffer);
  pIngreData->Value = atoi(Buffer);

	/* Item script */
  m_ScriptList.GetWindowText(Buffer);
  m_pIngrediant->SetScript(TrimStringSpace(Buffer));

	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pIngrediant->SetModel(TrimStringSpace(Buffer));

  	/* Icon filename */
  m_IconButton.GetWindowText(Buffer);
  m_pIngrediant->SetIcon(TrimStringSpace(Buffer));

	/* Record flags */
  m_pIngrediant->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pIngrediant->SetBlocked(m_BlockedCheck.GetCheck() != 0);

  GetEffectData();
 }
/*===========================================================================
 *		End of Class Method CEsmIngrediantDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIngrediantDlg Method - void GetEffectData (ListIndex, EffectIndex);
 *
 *=========================================================================*/
void CEsmIngrediantDlg::GetEffectData (const int ListIndex, const int EffectIndex) {
  ingredata_t*	pIngreData = m_pIngrediant->GetIngreData();
  CString	Buffer;
  int	 	Index;

	/* Get the effect ID */
  Index = m_EffectList[ListIndex].GetCurSel();
  pIngreData->EffectID[EffectIndex] = (short) m_EffectList[ListIndex].GetItemData(Index);

	/* Get any the skill/attribute ids */
  if (IsESMSkillEffect(pIngreData->EffectID[EffectIndex])) {
     pIngreData->AttributeID[EffectIndex] = -1;
     Index = m_SkillList[ListIndex].GetCurSel();

     if (Index >= 0) 
       pIngreData->SkillID[EffectIndex] = m_SkillList[ListIndex].GetItemData(Index);
     else
       pIngreData->SkillID[EffectIndex] = -1;
   }
  else if (IsESMAttributeEffect(pIngreData->EffectID[EffectIndex])) {
    pIngreData->SkillID[EffectIndex] = -1;
    Index = m_SkillList[ListIndex].GetCurSel();

    if (Index >= 0) 
      pIngreData->AttributeID[EffectIndex] = m_SkillList[ListIndex].GetItemData(Index);
    else
      pIngreData->AttributeID[EffectIndex] = -1;
   }

 }
/*===========================================================================
 *		End of Class Method CEsmIngrediantDlg::GetEffectData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIngrediantDlg Method - void GetEffectData (void);
 *
 *=========================================================================*/
void CEsmIngrediantDlg::GetEffectData (void) {
  //DEFINE_FUNCTION("CEsmIngrediantDlg::GetEffectData()");
  ingredata_t*	pIngreData = m_pIngrediant->GetIngreData();
  int		Index;
  int		ListIndex;
  int		EffectIndex;

  	/* Clear all the ingrediants */
  for (EffectIndex = 0 ; EffectIndex < MWESM_INGRE_NUMENCHANTS; EffectIndex++) {
    pIngreData->AttributeID[EffectIndex] = -1;
    pIngreData->EffectID[EffectIndex]    = -1;
    pIngreData->SkillID[EffectIndex]     = -1;
   }

  for (ListIndex = 0, EffectIndex = 0; ListIndex < MWESM_INGRE_NUMENCHANTS; ListIndex++) {
    Index = m_EffectList[ListIndex].GetCurSel();

    if (Index >= 0) {
      GetEffectData(ListIndex, EffectIndex);
      EffectIndex++;
     }
   }

 }
/*===========================================================================
 *		End of Class Method CEsmIngrediantDlg::GetEffectData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIngrediantDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmIngrediantDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_WeightText.GetModify()) m_Modified = true;
  if (m_ValueText.GetModify()) m_Modified = true;
  if (m_NameText.GetModify()) m_Modified = true;
  if (m_IDText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmIngrediantDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIngrediantDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmIngrediantDlg::OnInitialUpdate() {
  int Index;

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pIngrediant = (CEsmIngrediant *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmScriptCombo(m_ScriptList);
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
  m_WeightText.SetLimitText(16);
  m_ValueText.SetLimitText(16);

  for (Index = 0; Index < MWESM_INGRE_NUMENCHANTS; Index++) {
    FillEsmEffectsCombo(m_EffectList[Index], true);
   }

  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmIngrediantDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIngrediantDlg Event - void OnSelChangeEffectList (ListIndex);
 *
 *=========================================================================*/
void CEsmIngrediantDlg::OnSelChangeEffectList (const int ListIndex) { 
  const esmeffectdata_t* pEffectData = NULL;
  int EffectIndex;
  int EffectID = -1;

  EffectIndex = m_EffectList[ListIndex].GetCurSel();

  if (EffectIndex >= 0) {
    EffectID = m_EffectList[ListIndex].GetItemData(EffectIndex);
    m_pEffectInfo[ListIndex] = GetDocument()->GetEffectRecord(EffectID);
    pEffectData = GetESMEffectData(EffectID);
   }

	/* Disable the controls if no effect is selected */
  if (EffectID < 0 || pEffectData == NULL) {
    m_pEffectInfo[ListIndex] = NULL;
    m_SkillList[ListIndex].ResetContent();
    m_SkillList[ListIndex].EnableWindow(FALSE);
    return;
   }
  
	/* Enable or disable the skill list */
  if (IsESMSkillEffect(EffectID)) {
    m_SkillList[ListIndex].EnableWindow(TRUE);
    FillEsmSkillsCombo(m_SkillList[ListIndex]);
    m_SkillList[ListIndex].SetCurSel(0);
   }
  else if (IsESMAttributeEffect(EffectID)) {
    m_SkillList[ListIndex].EnableWindow(TRUE);
    FillEsmAttributesCombo(m_SkillList[ListIndex]);
    m_SkillList[ListIndex].SetCurSel(0);
   }
  else {
    m_SkillList[ListIndex].ResetContent();
    m_SkillList[ListIndex].EnableWindow(FALSE);
   }

  m_Modified = true;
 }
/*===========================================================================
 *		End of Class Event CEsmIngrediantDlg::OnSelChangeEffectList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIngrediantDlg Event - void OnSelChangeSkillList (ListIndex);
 *
 *=========================================================================*/
void CEsmIngrediantDlg::OnSelChangeSkillList (const int ListIndex) {
  m_Modified = true;
 }
/*===========================================================================
 *		End of Class Event CEsmIngrediantDlg::OnSelChangeSkillList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIngrediantDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmIngrediantDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  CString Buffer;

  	/* Refill the script list if required */
  if (pRecInfo->pRecord->IsType(MWESM_REC_SCRI)) {
    m_ScriptList.GetWindowText(Buffer);
    FillEsmScriptCombo(m_ScriptList);
    m_ScriptList.SelectString(-1, Buffer);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmIngrediantDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIngrediantDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmIngrediantDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pIngrediant == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pIngrediant->GetID());
  UpdateTitle(m_pIngrediant->GetID());

	/* Item strings and values */
  m_NameText.SetWindowText(m_pIngrediant->GetName());
  m_WeightText.SetWindowText(m_pIngrediant->GetFieldString(ESM_FIELD_WEIGHT));
  m_ValueText.SetWindowText(m_pIngrediant->GetFieldString(ESM_FIELD_VALUE));
  m_NameText.SetModify(FALSE);
  m_WeightText.SetModify(FALSE);
  m_ValueText.SetModify(FALSE);

	/* Model/icon buttons */
  m_ModelButton.SetWindowText(m_pIngrediant->GetModel());
  m_IconButton.SetWindowText(m_pIngrediant->GetIcon());
  m_IconPicture.SetEsmIcon(m_pIngrediant->GetIcon());
  
	/* Item lists */
  m_ScriptList.SelectString(-1, m_pIngrediant->GetScript());

	/* Record flags */
  m_BlockedCheck.SetCheck(m_pIngrediant->IsBlocked());
  m_PersistCheck.SetCheck(m_pIngrediant->IsPersist());

	/* Set the effect data */
  SetEffectData();
 }
/*===========================================================================
 *		End of Class Method CEsmIngrediantDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIngrediantDlg Method - void SetEffectData (EffectIndex);
 *
 *=========================================================================*/
void CEsmIngrediantDlg::SetEffectData (const int EffectIndex) {
  DEFINE_FUNCTION("CEsmIngrediantDlg::SetEffectData()");
  const esmeffectdata_t* pEffectData = NULL;
  ingredata_t*	   pIngreData = m_pIngrediant->GetIngreData();
  CString	   Buffer;

	/* Try and get the enchant/effect data */
  pEffectData = GetESMEffectData(pIngreData->EffectID[EffectIndex]);
  m_pEffectInfo[EffectIndex] = GetDocument()->GetEffectRecord(pIngreData->EffectID[EffectIndex]);

	/* Disable the controls if the record is not valid */
  if (pIngreData->EffectID[EffectIndex] == -1 || pEffectData == NULL) {
    m_pEffectInfo[EffectIndex] = NULL;
    m_EffectList[EffectIndex].SelectString(-1, _T(""));
    m_SkillList[EffectIndex].EnableWindow(FALSE);
    return;
   }
  
	/* Select the effect ID */
  FindComboListItem(m_EffectList[EffectIndex], pIngreData->EffectID[EffectIndex], true);

	/* Fill in the skill list as required */
  if (IsESMSkillEffect(pIngreData->EffectID[EffectIndex])) {
    m_SkillList[EffectIndex].EnableWindow(TRUE);
    FillEsmSkillsCombo(m_SkillList[EffectIndex]);
    FindComboListItem(m_SkillList[EffectIndex], pIngreData->SkillID[EffectIndex], true);
   }
  else if (IsESMAttributeEffect(pIngreData->EffectID[EffectIndex])) {
    m_SkillList[EffectIndex].EnableWindow(TRUE);
    FillEsmAttributesCombo(m_SkillList[EffectIndex]);
    FindComboListItem(m_SkillList[EffectIndex], pIngreData->AttributeID[EffectIndex], true);
   }
  else {
    m_SkillList[EffectIndex].EnableWindow(FALSE);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmIngrediantDlg::SetEffectData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIngrediantDlg Method - void SetEffectData (void);
 *
 *=========================================================================*/
void CEsmIngrediantDlg::SetEffectData (void) {
  int		EffectIndex;

  for (EffectIndex = 0; EffectIndex < MWESM_INGRE_NUMENCHANTS; EffectIndex++) {
    SetEffectData(EffectIndex);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmIngrediantDlg::SetEffectData()
 *=========================================================================*/

