// EsmAlchemyDlg.cpp : implementation file
//

#include "stdafx.h"
#include "MWEdit.h"
#include "EsmAlchemyDlg.h"
#include "EsmDlgArray.h"


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

  IMPLEMENT_DYNCREATE(CEsmAlchemyDlg, CEsmRecDialog);
  DEFINE_FILE("EsmAlchemyDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmAlchemyDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmAlchemyDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmAlchemyDlg)
  ON_BN_CLICKED(IDC_AUTOCALCCHECK, OnAutocalccheck)
  ON_CBN_SELCHANGE(IDC_EFFECTLIST1, OnSelchangeEffectlist1)
  ON_CBN_SELCHANGE(IDC_EFFECTLIST2, OnSelchangeEffectlist2)
  ON_CBN_SELCHANGE(IDC_EFFECTLIST3, OnSelchangeEffectlist3)
  ON_CBN_SELCHANGE(IDC_EFFECTLIST4, OnSelchangeEffectlist4)
  ON_CBN_SELCHANGE(IDC_EFFECTLIST5, OnSelchangeEffectlist5)
  ON_CBN_SELCHANGE(IDC_EFFECTLIST6, OnSelchangeEffectlist6)
  ON_CBN_SELCHANGE(IDC_EFFECTLIST7, OnSelchangeEffectlist7)
  ON_CBN_SELCHANGE(IDC_EFFECTLIST8, OnSelchangeEffectlist8)
  ON_CBN_SELCHANGE(IDC_SKILLLIST1,  OnSelchangeSkilllist1)
  ON_CBN_SELCHANGE(IDC_SKILLLIST2,  OnSelchangeSkilllist2)
  ON_CBN_SELCHANGE(IDC_SKILLLIST3,  OnSelchangeSkilllist3)
  ON_CBN_SELCHANGE(IDC_SKILLLIST4,  OnSelchangeSkilllist4)
  ON_CBN_SELCHANGE(IDC_SKILLLIST5,  OnSelchangeSkilllist5)
  ON_CBN_SELCHANGE(IDC_SKILLLIST6,  OnSelchangeSkilllist6)
  ON_CBN_SELCHANGE(IDC_SKILLLIST7,  OnSelchangeSkilllist7)
  ON_CBN_SELCHANGE(IDC_SKILLLIST8,  OnSelchangeSkilllist8)
  ON_EN_CHANGE(IDC_DURATIONTEXT1, OnChangeDurationtext1)
  ON_EN_CHANGE(IDC_DURATIONTEXT2, OnChangeDurationtext2)
  ON_EN_CHANGE(IDC_DURATIONTEXT3, OnChangeDurationtext3)
  ON_EN_CHANGE(IDC_DURATIONTEXT4, OnChangeDurationtext4)
  ON_EN_CHANGE(IDC_DURATIONTEXT5, OnChangeDurationtext5)
  ON_EN_CHANGE(IDC_DURATIONTEXT6, OnChangeDurationtext6)
  ON_EN_CHANGE(IDC_DURATIONTEXT7, OnChangeDurationtext7)
  ON_EN_CHANGE(IDC_DURATIONTEXT8, OnChangeDurationtext8)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT1, OnChangeDurationtext1)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT2, OnChangeDurationtext2)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT3, OnChangeDurationtext3)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT4, OnChangeDurationtext4)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT5, OnChangeDurationtext5)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT6, OnChangeDurationtext6)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT7, OnChangeDurationtext7)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT8, OnChangeDurationtext8)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmAlchemyDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Constructor
 *
 *=========================================================================*/
CEsmAlchemyDlg::CEsmAlchemyDlg() : CEsmRecDialog(CEsmAlchemyDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmAlchemyDlg)
  //}}AFX_DATA_INIT
  int Index;
  m_pAlchemy = NULL;

  for (Index = 0; Index < MWESM_ALCHEMY_NUMENCHANTS; Index++) {
    m_pEffectInfo[Index] = NULL;
   }

 }
/*===========================================================================
 *		End of Class CEsmAlchemyDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmAlchemyDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmAlchemyDlg)
  DDX_Control(pDX, IDC_ICONPICTURE, m_IconPicture);
  DDX_Control(pDX, IDC_PERSISTCHECK, m_PersistCheck);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_ICONBUTTON, m_IconButton);
  DDX_Control(pDX, IDC_MODELBUTTON, m_ModelButton);
  DDX_Control(pDX, IDC_VALUETEXT, m_ValueText);
  DDX_Control(pDX, IDC_WEIGHTTEXT, m_WeightText);
  DDX_Control(pDX, IDC_AUTOCALCCHECK, m_AutoCalcCheck);
  DDX_Control(pDX, IDC_SCRIPTLIST, m_ScriptList);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP

  DDX_Control(pDX, IDC_EFFECTLIST1, m_EffectList[0]);
  DDX_Control(pDX, IDC_EFFECTLIST2, m_EffectList[1]);
  DDX_Control(pDX, IDC_EFFECTLIST3, m_EffectList[2]);
  DDX_Control(pDX, IDC_EFFECTLIST4, m_EffectList[3]);
  DDX_Control(pDX, IDC_EFFECTLIST5, m_EffectList[4]);
  DDX_Control(pDX, IDC_EFFECTLIST6, m_EffectList[5]);
  DDX_Control(pDX, IDC_EFFECTLIST7, m_EffectList[6]);
  DDX_Control(pDX, IDC_EFFECTLIST8, m_EffectList[7]);
  DDX_Control(pDX, IDC_SKILLLIST1, m_SkillList[0]);
  DDX_Control(pDX, IDC_SKILLLIST2, m_SkillList[1]);
  DDX_Control(pDX, IDC_SKILLLIST3, m_SkillList[2]);
  DDX_Control(pDX, IDC_SKILLLIST4, m_SkillList[3]);
  DDX_Control(pDX, IDC_SKILLLIST5, m_SkillList[4]);
  DDX_Control(pDX, IDC_SKILLLIST6, m_SkillList[5]);
  DDX_Control(pDX, IDC_SKILLLIST7, m_SkillList[6]);
  DDX_Control(pDX, IDC_SKILLLIST8, m_SkillList[7]);
  DDX_Control(pDX, IDC_COSTLABEL1, m_CostText[0]);
  DDX_Control(pDX, IDC_COSTLABEL2, m_CostText[1]);
  DDX_Control(pDX, IDC_COSTLABEL3, m_CostText[2]);
  DDX_Control(pDX, IDC_COSTLABEL4, m_CostText[3]);
  DDX_Control(pDX, IDC_COSTLABEL5, m_CostText[4]);
  DDX_Control(pDX, IDC_COSTLABEL6, m_CostText[5]);
  DDX_Control(pDX, IDC_COSTLABEL7, m_CostText[6]);
  DDX_Control(pDX, IDC_COSTLABEL8, m_CostText[7]);
  DDX_Control(pDX, IDC_DURATIONTEXT1, m_DurationText[0]);
  DDX_Control(pDX, IDC_DURATIONTEXT2, m_DurationText[1]);
  DDX_Control(pDX, IDC_DURATIONTEXT3, m_DurationText[2]);
  DDX_Control(pDX, IDC_DURATIONTEXT4, m_DurationText[3]);
  DDX_Control(pDX, IDC_DURATIONTEXT5, m_DurationText[4]);
  DDX_Control(pDX, IDC_DURATIONTEXT6, m_DurationText[5]);
  DDX_Control(pDX, IDC_DURATIONTEXT7, m_DurationText[6]);
  DDX_Control(pDX, IDC_DURATIONTEXT8, m_DurationText[7]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT1, m_MagnitudeText[0]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT2, m_MagnitudeText[1]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT3, m_MagnitudeText[2]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT4, m_MagnitudeText[3]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT5, m_MagnitudeText[4]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT6, m_MagnitudeText[5]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT7, m_MagnitudeText[6]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT8, m_MagnitudeText[7]);
  DDX_Control(pDX, IDC_TOTALCOSTLABEL1, m_TotalCostText[0]);
  DDX_Control(pDX, IDC_TOTALCOSTLABEL2, m_TotalCostText[1]);
  DDX_Control(pDX, IDC_TOTALCOSTLABEL3, m_TotalCostText[2]);
  DDX_Control(pDX, IDC_TOTALCOSTLABEL4, m_TotalCostText[3]);
  DDX_Control(pDX, IDC_TOTALCOSTLABEL5, m_TotalCostText[4]);
  DDX_Control(pDX, IDC_TOTALCOSTLABEL6, m_TotalCostText[5]);
  DDX_Control(pDX, IDC_TOTALCOSTLABEL7, m_TotalCostText[6]);
  DDX_Control(pDX, IDC_TOTALCOSTLABEL8, m_TotalCostText[7]);
 }
/*===========================================================================
 *		End of Class Method CEsmAlchemyDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmAlchemyDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmAlchemyDlg::GetControlData()");
  alchemydata_t* pAlchemyData;
  CString	 Buffer;  

	/* Update the armor pointer and data */
  m_pAlchemy = (CEsmAlchemy *) GetRecInfo()->pRecord;
  if (m_pAlchemy == NULL) return;
  pAlchemyData = m_pAlchemy->GetAlchemyData();
  ASSERT(pAlchemyData != NULL);

	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pAlchemy->SetID(TrimStringSpace(Buffer));
   }

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pAlchemy->SetName(TrimStringSpace(Buffer));

	/* Item weight */
  m_WeightText.GetWindowText(Buffer);
  pAlchemyData->Weight = (float) atof(Buffer);

	/* Item value */
  m_ValueText.GetWindowText(Buffer);
  pAlchemyData->Value = atoi(Buffer);

	/* Item script */
  m_ScriptList.GetWindowText(Buffer);
  m_pAlchemy->SetScript(TrimStringSpace(Buffer));

	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pAlchemy->SetModel(TrimStringSpace(Buffer));

  	/* Icon filename */
  m_IconButton.GetWindowText(Buffer);
  m_pAlchemy->SetIcon(TrimStringSpace(Buffer));

	/* Record flags */
  m_pAlchemy->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pAlchemy->SetBlocked(m_BlockedCheck.GetCheck() != 0);
  pAlchemyData->AutoCalc = (m_AutoCalcCheck.GetCheck() != 0);

  GetEffectData();
 }
/*===========================================================================
 *		End of Class Method CEsmAlchemyDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Method - void GetEffectData (EffectIndex);
 *
 *=========================================================================*/
void CEsmAlchemyDlg::GetEffectData (const int EffectIndex) {
  CEsmSubENAM*	   pEnchantSubRec;
  enchanteffect_t* pEnchantData;
  CString	   Buffer;
  int	 	   ListIndex;

	/* Get the currently selected effect */
  ListIndex = m_EffectList[EffectIndex].GetCurSel();
  if (ListIndex < 0) return;

	/* Create the new index sub-record */
  pEnchantSubRec = (CEsmSubENAM *) m_pAlchemy->AllocateSubRecord(MWESM_SUBREC_ENAM);
  pEnchantSubRec->CreateNew();
  pEnchantData = pEnchantSubRec->GetEnchantData();
  pEnchantData->Area = 0;
  pEnchantData->RangeType = 0;

	/* Set the enchant effect */
  pEnchantData->EffectID = (short) m_EffectList[EffectIndex].GetItemData(ListIndex);

	/* Set the enchant duration */
  m_DurationText[EffectIndex].GetWindowText(Buffer);
  pEnchantData->Duration = (short) (atoi(Buffer));
  if (pEnchantData->Duration < 0) pEnchantData->Duration = 0;

	/* Get the enchant magnitude */
  m_MagnitudeText[EffectIndex].GetWindowText(Buffer);
  pEnchantData->MagMin = (short) (atoi(Buffer));
  if (pEnchantData->MagMin < 0) pEnchantData->MagMin = 0;
  pEnchantData->MagMax = pEnchantData->MagMin;

	/* Get the skill/attribute ids */
  if (IsESMSkillEffect(pEnchantData->EffectID)) {
     ListIndex = m_SkillList[EffectIndex].GetCurSel();
     if (ListIndex >= 0) pEnchantData->SkillID = (byte) m_SkillList[EffectIndex].GetItemData(ListIndex);
   }
  else if (IsESMAttributeEffect(pEnchantData->EffectID)) {
    ListIndex = m_SkillList[EffectIndex].GetCurSel();
    if (ListIndex >= 0) pEnchantData->AttributeID = (byte) m_SkillList[EffectIndex].GetItemData(ListIndex);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmAlchemyDlg::GetEffectData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Method - void GetEffectData (void);
 *
 *=========================================================================*/
void CEsmAlchemyDlg::GetEffectData (void) {
  //DEFINE_FUNCTION("CEsmAlchemyDlg::GetEffectData()");
  int Index;

	/* Delete all the enchant ub-records from the alchemy record */
  m_pAlchemy->DeleteSubRecords(MWESM_SUBREC_ENAM);
  
  for (Index = 0; Index < MWESM_ALCHEMY_NUMENCHANTS; Index++) {
    GetEffectData(Index);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmAlchemyDlg::GetEffectData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmAlchemyDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_WeightText.GetModify()) m_Modified = true;
  if (m_ValueText.GetModify()) m_Modified = true;
  if (m_NameText.GetModify()) m_Modified = true;
  if (m_IDText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmAlchemyDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmAlchemyDlg::OnInitialUpdate() {
  int Index;

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pAlchemy = (CEsmAlchemy *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmScriptCombo(m_ScriptList);
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
  m_WeightText.SetLimitText(16);
  m_ValueText.SetLimitText(16);

  for (Index = 0; Index < MWESM_ALCHEMY_NUMENCHANTS; Index++) {
    FillEsmEffectsCombo(m_EffectList[Index], true);
    m_DurationText[Index].SetLimitText(5);	/* Are shorts so only need 5 digits at most */
    m_MagnitudeText[Index].SetLimitText(5);
   }

  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmAlchemyDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Event - void OnSelChangeEffectList (ListIndex);
 *
 *=========================================================================*/
void CEsmAlchemyDlg::OnSelChangeEffectList (const int ListIndex) { 
  const esmeffectdata_t* pEffectData = NULL;
  int EffectIndex;
  int EffectID = -1;

  EffectIndex = m_EffectList[ListIndex].GetCurSel();

  if (EffectIndex >= 0) {
    EffectID = m_EffectList[ListIndex].GetItemData(EffectIndex);
    m_pEffectInfo[ListIndex] = m_pParent->GetEffectRecord(EffectID);
    pEffectData = GetESMEffectData(EffectID);
    SystemLog.Printf ("EffectID = %d (%p, %p)", EffectID, m_pEffectInfo[ListIndex], pEffectData);
   }

	/* Disable the controls if no effect is selected */
  if (EffectID < 0 || pEffectData == NULL) {
    m_pEffectInfo[ListIndex] = NULL;
    m_SkillList[ListIndex].ResetContent();
    m_SkillList[ListIndex].EnableWindow(FALSE);
    m_DurationText[ListIndex].EnableWindow(FALSE);
    m_MagnitudeText[ListIndex].EnableWindow(FALSE);
    m_DurationText[ListIndex].SetWindowText(_T(""));
    m_MagnitudeText[ListIndex].SetWindowText(_T(""));
    m_CostText[ListIndex].SetWindowText(_T(""));
    m_TotalCostText[ListIndex].SetWindowText(_T(""));
    UpdateSpellCost(ListIndex);
    return;
   }
  
	/* Enable the input controls if required */
  if (pEffectData->HasDuration()) {
    m_DurationText[ListIndex].EnableWindow(TRUE);
   }
  else {
    m_DurationText[ListIndex].EnableWindow(FALSE);
    m_DurationText[ListIndex].SetWindowText(_T(""));
   }
 
  if (pEffectData->HasMagnitude()) {
    m_MagnitudeText[ListIndex].EnableWindow(TRUE);
   }
  else {
    m_MagnitudeText[ListIndex].EnableWindow(FALSE);
    m_MagnitudeText[ListIndex].SetWindowText(_T(""));
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

  UpdateSpellCost(ListIndex);
  m_Modified = true;
 }
/*===========================================================================
 *		End of Class Event CEsmAlchemyDlg::OnSelChangeEffectList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Event - void OnSelChangeSkillList (ListIndex);
 *
 *=========================================================================*/
void CEsmAlchemyDlg::OnSelChangeSkillList (const int ListIndex) {
  UpdateSpellCost(ListIndex);
  m_Modified = true;
 }
/*===========================================================================
 *		End of Class Event CEsmAlchemyDlg::OnSelChangeSkillList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmAlchemyDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {

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
 *		End of Class Event CEsmAlchemyDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmAlchemyDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pAlchemy == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pAlchemy->GetID());
  UpdateTitle(m_pAlchemy->GetID());

	/* Item strings and values */
  m_NameText.SetWindowText(m_pAlchemy->GetName());
  m_WeightText.SetWindowText(m_pAlchemy->GetFieldString(ESM_FIELD_WEIGHT));
  m_ValueText.SetWindowText(m_pAlchemy->GetFieldString(ESM_FIELD_VALUE));
  m_ValueText.EnableWindow(!m_pAlchemy->IsAutoCalc());
  m_NameText.SetModify(FALSE);
  m_WeightText.SetModify(FALSE);
  m_ValueText.SetModify(FALSE);

	/* Model/icon buttons */
  m_ModelButton.SetWindowText(m_pAlchemy->GetModel());
  m_IconButton.SetWindowText(m_pAlchemy->GetIcon());
  m_IconPicture.SetEsmIcon(m_pAlchemy->GetIcon());
  
	/* Item lists */
  m_ScriptList.SelectString(-1, m_pAlchemy->GetScript());

	/* Record flags */
  m_BlockedCheck.SetCheck(m_pAlchemy->IsBlocked());
  m_PersistCheck.SetCheck(m_pAlchemy->IsPersist());
  m_AutoCalcCheck.SetCheck(m_pAlchemy->IsAutoCalc());

	/* Set the effect data */
  SetEffectData();
 }
/*===========================================================================
 *		End of Class Method CEsmAlchemyDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Method - void SetEffectData (EffectIndex, pEffectRecord);
 *
 *=========================================================================*/
void CEsmAlchemyDlg::SetEffectData (const int EffectIndex, CEsmSubENAM* pEffectRecord) {
  DEFINE_FUNCTION("CEsmAlchemyDlg::SetEffectData()");
  const esmeffectdata_t* pEffectData = NULL;
  CString	   Buffer;
  enchanteffect_t* pEnchantData = NULL;

	/* Try and get the enchant/effect data */
  if (pEffectRecord != NULL) {
    pEnchantData = pEffectRecord->GetEnchantData();
    ASSERT(pEnchantData != NULL);
    pEffectData = GetESMEffectData(pEnchantData->EffectID);
    m_pEffectInfo[EffectIndex] = m_pParent->GetEffectRecord(pEnchantData->EffectID);
   }

	/* Disable the controls if the record is not valid */
  if (pEnchantData == NULL || pEffectData == NULL) {
    m_pEffectInfo[EffectIndex] = NULL;
    m_EffectList[EffectIndex].SelectString(-1, _T(""));
    m_SkillList[EffectIndex].EnableWindow(FALSE);
    m_DurationText[EffectIndex].EnableWindow(FALSE);
    m_MagnitudeText[EffectIndex].EnableWindow(FALSE);
    m_DurationText[EffectIndex].SetModify(FALSE);
    m_MagnitudeText[EffectIndex].SetModify(FALSE);
    return;
   }
  
	/* Select the effect ID */
  FindComboListItem(m_EffectList[EffectIndex], pEnchantData->EffectID, true);

	/* Set the effect magnitude */
  if (pEffectData->HasMagnitude()) {
    Buffer.Format(_T("%d"), (int)pEnchantData->MagMin);
    m_MagnitudeText[EffectIndex].EnableWindow(TRUE);
    m_MagnitudeText[EffectIndex].SetWindowText(Buffer);
    m_MagnitudeText[EffectIndex].SetModify(FALSE);
   }
  else {
    m_MagnitudeText[EffectIndex].EnableWindow(FALSE);
    m_MagnitudeText[EffectIndex].SetWindowText(_T(""));
    m_MagnitudeText[EffectIndex].SetModify(FALSE);
   }

	/* Set the effect duration */
  if (pEffectData->HasDuration()) {
    Buffer.Format(_T("%d"), (int)pEnchantData->Duration);
    m_DurationText[EffectIndex].EnableWindow(TRUE);
    m_DurationText[EffectIndex].SetWindowText(Buffer);
    m_DurationText[EffectIndex].SetModify(FALSE);
   }
  else {
    m_DurationText[EffectIndex].EnableWindow(FALSE);
    m_DurationText[EffectIndex].SetWindowText(_T(""));
    m_DurationText[EffectIndex].SetModify(FALSE);
   }

	/* Set the effect cost and total cost */
  Buffer.Format(_T("%d"), 0);
  m_TotalCostText[EffectIndex].SetWindowText(Buffer);
  Buffer.Format(_T("%d"), 0);
  m_CostText[EffectIndex].SetWindowText(Buffer);

	/* Fill in the skill list as required */
  if (IsESMSkillEffect(pEnchantData->EffectID)) {
    m_SkillList[EffectIndex].EnableWindow(TRUE);
    FillEsmSkillsCombo(m_SkillList[EffectIndex]);
    FindComboListItem(m_SkillList[EffectIndex], pEnchantData->SkillID, true);
   }
  else if (IsESMAttributeEffect(pEnchantData->EffectID)) {
    m_SkillList[EffectIndex].EnableWindow(TRUE);
    FillEsmAttributesCombo(m_SkillList[EffectIndex]);
    FindComboListItem(m_SkillList[EffectIndex], pEnchantData->AttributeID, true);
   }
  else {
    m_SkillList[EffectIndex].EnableWindow(FALSE);
   }

  UpdateSpellCost(EffectIndex);
 }
/*===========================================================================
 *		End of Class Method CEsmAlchemyDlg::SetEffectData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Method - void SetEffectData (void);
 *
 *=========================================================================*/
void CEsmAlchemyDlg::SetEffectData (void) {
  CEsmSubENAM*	pEffectRecord;
  int		RecordIndex;
  int		EffectIndex;

  pEffectRecord = (CEsmSubENAM *) m_pAlchemy->FindFirst(MWESM_SUBREC_ENAM, RecordIndex);

  for (EffectIndex = 0; EffectIndex < MWESM_ALCHEMY_NUMENCHANTS; EffectIndex++) {
    SetEffectData(EffectIndex, pEffectRecord);
    pEffectRecord =  (CEsmSubENAM *) m_pAlchemy->FindNext(MWESM_SUBREC_ENAM, RecordIndex);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmAlchemyDlg::SetEffectData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Method - void UpdateSpellCost (EffectIndex);
 *
 *=========================================================================*/
void CEsmAlchemyDlg::UpdateSpellCost (const int EffectIndex) {
  CString Buffer;
  int	  EffectID = -1;
  int	  ListIndex;
  float	  Cost = -1;
  int	  Duration;
  int	  Magnitude;

	/* Get the current effect ID for the effect */
  ListIndex = m_EffectList[EffectIndex].GetCurSel();
  if (ListIndex >= 0) EffectID = m_EffectList[EffectIndex].GetItemData(ListIndex);

	/* No effect selected, clear costs */
  if (EffectID < 0) {
    m_CostText[EffectIndex].SetWindowText(_T(""));
    m_TotalCostText[EffectIndex].SetWindowText(_T(""));
    return;
   }

	/* Compute the spell cost if the effect is available */
  if (m_pEffectInfo[EffectIndex] != NULL) { 
    m_MagnitudeText[EffectIndex].GetWindowText(Buffer);
    Magnitude = atoi(Buffer);
    m_DurationText[EffectIndex].GetWindowText(Buffer);
    Duration = atoi(Buffer);
    Cost = ((CEsmMagicEffect *)m_pEffectInfo[EffectIndex]->pRecord)->GetAlchemyCost(Duration, Magnitude);
    Buffer.Format(_T("%.2f"), ((CEsmMagicEffect *)m_pEffectInfo[EffectIndex]->pRecord)->GetBaseCost());
    m_CostText[EffectIndex].SetWindowText(Buffer);
   }
  else {
    m_CostText[EffectIndex].SetWindowText(_T("???"));
   }

	/* Set the compute spell cost text */
  if (Cost < 0) {
    m_TotalCostText[EffectIndex].SetWindowText(_T("???"));
   }
  else {
    Buffer.Format(_T("%.2f"), Cost);
    m_TotalCostText[EffectIndex].SetWindowText(Buffer);
   }

	/* Update the total spell cost */
  UpdateTotalSpellCost();  
 }
/*===========================================================================
 *		End of Class Method CEsmAlchemyDlg::UpdateSpellCost()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Method - void UpdateTotalSpellCost (void);
 *
 *=========================================================================*/
void CEsmAlchemyDlg::UpdateTotalSpellCost (void) {
  CString Buffer;
  int     Index;
  float   SumValue = 0;

	/* Ignore if we are not auto-computing */
  if (m_AutoCalcCheck.GetCheck() == 0) return;

  for (Index = 0; Index < MWESM_ALCHEMY_NUMENCHANTS; Index++) {
    m_TotalCostText[Index].GetWindowText(Buffer);
    SumValue += (float) atof(Buffer);
   }

	/* Set the value text */
  Buffer.Format(_T("%d"), (int) SumValue);
  m_ValueText.SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmAlchemyDlg::UpdateTotalSpellCost()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmAlchemyDlg Event - void OnAutocalccheck ();
 *
 *=========================================================================*/
void CEsmAlchemyDlg::OnAutocalccheck() {
  m_ValueText.EnableWindow(!m_AutoCalcCheck.GetCheck());
  UpdateTotalSpellCost();
 }
/*===========================================================================
 *		End of Class Event CEsmAlchemyDlg::OnAutocalccheck()
 *=========================================================================*/

