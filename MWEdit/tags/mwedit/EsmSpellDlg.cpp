/*===========================================================================
 *
 * File:	Esmspelldlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmSpellDlg.h"



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

  IMPLEMENT_DYNCREATE(CEsmSpellDlg, CEsmRecDialog);
  DEFINE_FILE("EsmSpellDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmSpellDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmSpellDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmSpellDlg)
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
  ON_EN_CHANGE(IDC_AREATEXT1, OnChangeAreatext1)
  ON_EN_CHANGE(IDC_AREATEXT2, OnChangeAreatext2)
  ON_EN_CHANGE(IDC_AREATEXT3, OnChangeAreatext3)
  ON_EN_CHANGE(IDC_AREATEXT4, OnChangeAreatext4)
  ON_EN_CHANGE(IDC_AREATEXT5, OnChangeAreatext5)
  ON_EN_CHANGE(IDC_AREATEXT6, OnChangeAreatext6)
  ON_EN_CHANGE(IDC_AREATEXT7, OnChangeAreatext7)
  ON_EN_CHANGE(IDC_AREATEXT8, OnChangeAreatext8)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT1, OnChangeDurationtext1)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT2, OnChangeDurationtext2)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT3, OnChangeDurationtext3)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT4, OnChangeDurationtext4)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT5, OnChangeDurationtext5)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT6, OnChangeDurationtext6)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT7, OnChangeDurationtext7)
  ON_EN_CHANGE(IDC_MAGNITUDETEXT8, OnChangeDurationtext8)
  ON_EN_CHANGE(IDC_MAGNITUDE2TEXT1, OnChangeDurationtext1)
  ON_EN_CHANGE(IDC_MAGNITUDE2TEXT2, OnChangeDurationtext2)
  ON_EN_CHANGE(IDC_MAGNITUDE2TEXT3, OnChangeDurationtext3)
  ON_EN_CHANGE(IDC_MAGNITUDE2TEXT4, OnChangeDurationtext4)
  ON_EN_CHANGE(IDC_MAGNITUDE2TEXT5, OnChangeDurationtext5)
  ON_EN_CHANGE(IDC_MAGNITUDE2TEXT6, OnChangeDurationtext6)
  ON_EN_CHANGE(IDC_MAGNITUDE2TEXT7, OnChangeDurationtext7)
  ON_EN_CHANGE(IDC_MAGNITUDE2TEXT8, OnChangeDurationtext8)
  ON_CBN_SELCHANGE(IDC_TYPELIST, OnSelchangeTypelist)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmSpellDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Constructor
 *
 *=========================================================================*/
CEsmSpellDlg::CEsmSpellDlg() : CEsmRecDialog(CEsmSpellDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmSpellDlg)
  //}}AFX_DATA_INIT
  int Index;
  m_pSpell = NULL;

  for (Index = 0; Index < MWESM_ENCHANT_NUMENCHANTS; Index++) {
    m_pEffectInfo[Index] = NULL;
   }

  m_DisableCost = false;
 }
/*===========================================================================
 *		End of Class CEsmSpellDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmSpellDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmSpellDlg)
  DDX_Control(pDX, IDC_COSTTEXT, m_CostText);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_AUTOCALCCHECK, m_AutoCalcCheck);
  DDX_Control(pDX, IDC_SUCCEEDCHECK, m_SucceedCheck);
  DDX_Control(pDX, IDC_PCSTARTCHECK, m_PCStartCheck);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  DDX_Control(pDX, IDC_TYPELIST, m_TypeList);
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
  DDX_Control(pDX, IDC_COSTLABEL1, m_CostLabel[0]);
  DDX_Control(pDX, IDC_COSTLABEL2, m_CostLabel[1]);
  DDX_Control(pDX, IDC_COSTLABEL3, m_CostLabel[2]);
  DDX_Control(pDX, IDC_COSTLABEL4, m_CostLabel[3]);
  DDX_Control(pDX, IDC_COSTLABEL5, m_CostLabel[4]);
  DDX_Control(pDX, IDC_COSTLABEL6, m_CostLabel[5]);
  DDX_Control(pDX, IDC_COSTLABEL7, m_CostLabel[6]);
  DDX_Control(pDX, IDC_COSTLABEL8, m_CostLabel[7]);
  DDX_Control(pDX, IDC_RANGELIST1, m_RangeList[0]);
  DDX_Control(pDX, IDC_RANGELIST2, m_RangeList[1]);
  DDX_Control(pDX, IDC_RANGELIST3, m_RangeList[2]);
  DDX_Control(pDX, IDC_RANGELIST4, m_RangeList[3]);
  DDX_Control(pDX, IDC_RANGELIST5, m_RangeList[4]);
  DDX_Control(pDX, IDC_RANGELIST6, m_RangeList[5]);
  DDX_Control(pDX, IDC_RANGELIST7, m_RangeList[6]);
  DDX_Control(pDX, IDC_RANGELIST8, m_RangeList[7]);
  DDX_Control(pDX, IDC_AREATEXT1, m_AreaText[0]);
  DDX_Control(pDX, IDC_AREATEXT2, m_AreaText[1]);
  DDX_Control(pDX, IDC_AREATEXT3, m_AreaText[2]);
  DDX_Control(pDX, IDC_AREATEXT4, m_AreaText[3]);
  DDX_Control(pDX, IDC_AREATEXT5, m_AreaText[4]);
  DDX_Control(pDX, IDC_AREATEXT6, m_AreaText[5]);
  DDX_Control(pDX, IDC_AREATEXT7, m_AreaText[6]);
  DDX_Control(pDX, IDC_AREATEXT8, m_AreaText[7]);
  DDX_Control(pDX, IDC_DURATIONTEXT1, m_DurationText[0]);
  DDX_Control(pDX, IDC_DURATIONTEXT2, m_DurationText[1]);
  DDX_Control(pDX, IDC_DURATIONTEXT3, m_DurationText[2]);
  DDX_Control(pDX, IDC_DURATIONTEXT4, m_DurationText[3]);
  DDX_Control(pDX, IDC_DURATIONTEXT5, m_DurationText[4]);
  DDX_Control(pDX, IDC_DURATIONTEXT6, m_DurationText[5]);
  DDX_Control(pDX, IDC_DURATIONTEXT7, m_DurationText[6]);
  DDX_Control(pDX, IDC_DURATIONTEXT8, m_DurationText[7]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT1, m_Magnitude1Text[0]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT2, m_Magnitude1Text[1]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT3, m_Magnitude1Text[2]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT4, m_Magnitude1Text[3]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT5, m_Magnitude1Text[4]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT6, m_Magnitude1Text[5]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT7, m_Magnitude1Text[6]);
  DDX_Control(pDX, IDC_MAGNITUDETEXT8, m_Magnitude1Text[7]);
  DDX_Control(pDX, IDC_MAGNITUDE2TEXT1, m_Magnitude2Text[0]);
  DDX_Control(pDX, IDC_MAGNITUDE2TEXT2, m_Magnitude2Text[1]);
  DDX_Control(pDX, IDC_MAGNITUDE2TEXT3, m_Magnitude2Text[2]);
  DDX_Control(pDX, IDC_MAGNITUDE2TEXT4, m_Magnitude2Text[3]);
  DDX_Control(pDX, IDC_MAGNITUDE2TEXT5, m_Magnitude2Text[4]);
  DDX_Control(pDX, IDC_MAGNITUDE2TEXT6, m_Magnitude2Text[5]);
  DDX_Control(pDX, IDC_MAGNITUDE2TEXT7, m_Magnitude2Text[6]);
  DDX_Control(pDX, IDC_MAGNITUDE2TEXT8, m_Magnitude2Text[7]);
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
 *		End of Class Method CEsmSpellDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmSpellDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmSpellDlg::GetControlData()");
  spelldata_t*	pSpellData;
  CString	Buffer;  
  int		ListIndex;

	/* Update the armor pointer and data */
  m_pSpell = (CEsmSpell *) GetRecInfo()->pRecord;
  if (m_pSpell == NULL) return;
  pSpellData = m_pSpell->GetSpellData();
  ASSERT(pSpellData != NULL);

	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pSpell->SetID(TrimStringSpace(Buffer));
   }

     	/* Spell type */
  ListIndex = m_TypeList.GetCurSel();
  if (ListIndex >= 0) m_pSpell->SetSpellType(m_TypeList.GetItemData(ListIndex));

	/* Spell cost */
  m_CostText.GetWindowText(Buffer);
  pSpellData->SpellCost = atoi(Buffer);

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pSpell->SetName(TrimStringSpace(Buffer));

	/* Record flags */
  if (m_AutoCalcCheck.GetCheck())
    pSpellData->Flags |= MWESM_SPELLFLAG_AUTOCALC;
  else
    pSpellData->Flags &= ~MWESM_SPELLFLAG_AUTOCALC;

  if (m_SucceedCheck.GetCheck())
    pSpellData->Flags |= MWESM_SPELLFLAG_SUCCEEDS;
  else
    pSpellData->Flags &= ~MWESM_SPELLFLAG_SUCCEEDS;

  if (m_PCStartCheck.GetCheck())
    pSpellData->Flags |= MWESM_SPELLFLAG_PCSTART;
  else
    pSpellData->Flags &= ~MWESM_SPELLFLAG_PCSTART;

  m_pSpell->SetBlocked(m_BlockedCheck.GetCheck() != 0);

  GetEffectData();
 }
/*===========================================================================
 *		End of Class Method CEsmSpellDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Method - void GetEffectData (EffectIndex);
 *
 *=========================================================================*/
void CEsmSpellDlg::GetEffectData (const int EffectIndex) {
  CEsmSubENAM*     pEnchantSubRec;
  enchanteffect_t* pSpellData;
  CString	   Buffer;
  int	 	   ListIndex;

	/* Get the currently selected effect */
  ListIndex = m_EffectList[EffectIndex].GetCurSel();
  if (ListIndex < 0) return;

	/* Create the new index sub-record */
  pEnchantSubRec = (CEsmSubENAM *) m_pSpell->AllocateSubRecord(MWESM_SUBREC_ENAM);
  pEnchantSubRec->CreateNew();
  pSpellData = pEnchantSubRec->GetEnchantData();

	/* Set the enchant effect */
  pSpellData->EffectID = (short) m_EffectList[EffectIndex].GetItemData(ListIndex);

	/* Set the enchant duration */
  m_DurationText[EffectIndex].GetWindowText(Buffer);
  pSpellData->Duration = (short) (atoi(Buffer));
  if (pSpellData->Duration < 0) pSpellData->Duration = 0;

	/* Get the range type */
  ListIndex = m_RangeList[EffectIndex].GetCurSel();
  if (ListIndex >= 0) pSpellData->RangeType = m_RangeList[EffectIndex].GetItemData(ListIndex);

  	/* Set the enchant area */
  m_AreaText[EffectIndex].GetWindowText(Buffer);
  pSpellData->Area = (short) (atoi(Buffer));
  if (pSpellData->Area < 0) pSpellData->Area = 0;

	/* Get the enchant magnitude */
  m_Magnitude1Text[EffectIndex].GetWindowText(Buffer);
  pSpellData->MagMin = (short) (atoi(Buffer));
  if (pSpellData->MagMin < 0) pSpellData->MagMin = 0;
  m_Magnitude2Text[EffectIndex].GetWindowText(Buffer);
  pSpellData->MagMax = (short) (atoi(Buffer));
  if (pSpellData->MagMax < 0) pSpellData->MagMax = 0;

	/* Get the skill/attribute ids */
  if (IsESMSkillEffect(pSpellData->EffectID)) {
     ListIndex = m_SkillList[EffectIndex].GetCurSel();
     if (ListIndex >= 0) pSpellData->SkillID = (byte) m_SkillList[EffectIndex].GetItemData(ListIndex);
   }
  else if (IsESMAttributeEffect(pSpellData->EffectID)) {
    ListIndex = m_SkillList[EffectIndex].GetCurSel();
    if (ListIndex >= 0) pSpellData->AttributeID = (byte) m_SkillList[EffectIndex].GetItemData(ListIndex);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmSpellDlg::GetEffectData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Method - void GetEffectData (void);
 *
 *=========================================================================*/
void CEsmSpellDlg::GetEffectData (void) {
  //DEFINE_FUNCTION("CEsmSpellDlg::GetEffectData()");
  int Index;

	/* Delete all the enchant ub-records from the alchemy record */
  m_pSpell->DeleteSubRecords(MWESM_SUBREC_ENAM);
  
  for (Index = 0; Index < MWESM_ENCHANT_NUMENCHANTS; Index++) {
    GetEffectData(Index);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmSpellDlg::GetEffectData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmSpellDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_CostText.GetModify()) m_Modified = true;
  if (m_NameText.GetModify()) m_Modified = true;
  if (m_IDText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmSpellDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmSpellDlg::OnInitialUpdate() {
  int Index;

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pSpell = (CEsmSpell *) GetRecInfo()->pRecord;
  FillEsmSpellTypeCombo(m_TypeList);

  for (Index = 0; Index < MWESM_ENCHANT_NUMENCHANTS; Index++) {
    FillEsmEffectsCombo(m_EffectList[Index], false);
    FillEsmEnchantRangeCombo(m_RangeList[Index]);
    m_DurationText[Index].SetLimitText(5);	/* Are shorts so only need 5 digits at most */
    m_Magnitude1Text[Index].SetLimitText(5);
    m_Magnitude2Text[Index].SetLimitText(5);
    m_AreaText[Index].SetLimitText(5);
   }

  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmSpellDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Event - void OnSelChangeEffectList (ListIndex);
 *
 *=========================================================================*/
void CEsmSpellDlg::OnSelChangeEffectList (const int ListIndex) { 
  const esmeffectdata_t* pEffectData = NULL;
  int EffectIndex;
  int EffectID = -1;
  int PrevSel;

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
    m_RangeList[ListIndex].ResetContent();
    m_SkillList[ListIndex].EnableWindow(FALSE);
    m_DurationText[ListIndex].EnableWindow(FALSE);
    m_Magnitude1Text[ListIndex].EnableWindow(FALSE);
    m_Magnitude2Text[ListIndex].EnableWindow(FALSE);
    m_AreaText[ListIndex].EnableWindow(FALSE);
    m_RangeList[ListIndex].EnableWindow(FALSE);
    m_DurationText[ListIndex].SetWindowText(_T(""));
    m_Magnitude1Text[ListIndex].SetWindowText(_T(""));
    m_Magnitude2Text[ListIndex].SetWindowText(_T(""));
    m_AreaText[ListIndex].SetWindowText(_T(""));
    m_CostLabel[ListIndex].SetWindowText(_T(""));
    m_TotalCostText[ListIndex].SetWindowText(_T(""));
    UpdateSpellCost(ListIndex);
    return;
   }
  
	/* Enable the input controls if required */
  if (pEffectData->HasDuration()) {
    m_DurationText[ListIndex].EnableWindow(!m_DisableCost);
   }
  else {
    m_DurationText[ListIndex].EnableWindow(FALSE);
    m_DurationText[ListIndex].SetWindowText(_T(""));
   }
 
  if (pEffectData->HasMagnitude()) {
    m_Magnitude1Text[ListIndex].EnableWindow(TRUE);
    m_Magnitude2Text[ListIndex].EnableWindow(TRUE);
   }
  else {
    m_Magnitude1Text[ListIndex].EnableWindow(FALSE);
    m_Magnitude1Text[ListIndex].SetWindowText(_T(""));
    m_Magnitude2Text[ListIndex].EnableWindow(FALSE);
    m_Magnitude2Text[ListIndex].SetWindowText(_T(""));
   }  

	/* Enable or disable the range list */
  if (pEffectData->IsSelfOnly() || m_DisableCost) {
    FillEsmEnchantRangeCombo(m_RangeList[ListIndex]);
    m_RangeList[ListIndex].EnableWindow(FALSE);
    m_RangeList[ListIndex].SetCurSel(0);
    m_AreaText[ListIndex].EnableWindow(FALSE);
    m_AreaText[ListIndex].SetWindowText(_T("0"));
   }
  else {
    PrevSel = m_RangeList[ListIndex].GetCurSel();
    if (PrevSel >= 0) PrevSel = m_RangeList[ListIndex].GetItemData(PrevSel);
    FillEsmEnchantRangeCombo(m_RangeList[ListIndex], pEffectData->IsNotSelf());
    m_RangeList[ListIndex].EnableWindow(TRUE);
    FindComboListItem(m_RangeList[ListIndex], PrevSel, true);
    if (m_RangeList[ListIndex].GetCurSel() < 0) m_RangeList[ListIndex].SetCurSel(0);

    m_AreaText[ListIndex].EnableWindow(TRUE);
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
 *		End of Class Event CEsmSpellDlg::OnSelChangeEffectList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Event - void OnSelChangeSkillList (ListIndex);
 *
 *=========================================================================*/
void CEsmSpellDlg::OnSelChangeSkillList (const int ListIndex) {
  UpdateSpellCost(ListIndex);
  m_Modified = true;
 }
/*===========================================================================
 *		End of Class Event CEsmSpellDlg::OnSelChangeSkillList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmSpellDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmSpellDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmSpellDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pSpell == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pSpell->GetID());
  UpdateTitle(m_pSpell->GetID());

  	/* Spell type */
  FindComboListItem(m_TypeList, m_pSpell->GetSpellTypeID(), true);
  m_DisableCost = !(( m_pSpell->GetSpellTypeID() == MWESM_SPELLTYPE_SPELL) || ( m_pSpell->GetSpellTypeID() == MWESM_SPELLTYPE_POWER));

	/* Item strings and values */
  m_NameText.SetWindowText(m_pSpell->GetName());
  m_CostText.SetWindowText(m_pSpell->GetFieldString(ESM_FIELD_COST));
  m_CostText.EnableWindow(!m_pSpell->IsAutoCalc() && !m_DisableCost);
  m_CostText.SetModify(FALSE);
  m_NameText.SetModify(FALSE);

	/* Record flags */
  m_AutoCalcCheck.SetCheck(m_pSpell->IsAutoCalc());
  m_AutoCalcCheck.EnableWindow(!m_DisableCost);
  m_SucceedCheck.SetCheck(m_pSpell->IsSucceeds());
  m_BlockedCheck.SetCheck(m_pSpell->IsBlocked());
  m_PCStartCheck.SetCheck(m_pSpell->IsPCStart());
  m_PCStartCheck.EnableWindow(m_pSpell->GetSpellTypeID() == MWESM_SPELLTYPE_SPELL);

	/* Set the effect data */
  SetEffectData();
 }
/*===========================================================================
 *		End of Class Method CEsmSpellDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Method - void SetEffectData (EffectIndex, pEffectRecord);
 *
 *=========================================================================*/
void CEsmSpellDlg::SetEffectData (const int EffectIndex, CEsmSubENAM* pEffectRecord) {
  DEFINE_FUNCTION("CEsmSpellDlg::SetEffectData()");
  const esmeffectdata_t* pEffectData = NULL;
  CString	   Buffer;
  enchanteffect_t* pSpellData = NULL;

	/* Try and get the enchant/effect data */
  if (pEffectRecord != NULL) {
    pSpellData = pEffectRecord->GetEnchantData();
    ASSERT(pSpellData != NULL);
    pEffectData = GetESMEffectData(pSpellData->EffectID);
    m_pEffectInfo[EffectIndex] = GetDocument()->GetEffectRecord(pSpellData->EffectID);
   }

  	/* Disable the controls if the record is not valid */
  if (pSpellData == NULL || pEffectData == NULL) {
    m_pEffectInfo[EffectIndex] = NULL;
    m_EffectList[EffectIndex].SelectString(-1, _T(""));
    m_RangeList[EffectIndex].SelectString(-1, _T(""));
    m_SkillList[EffectIndex].EnableWindow(FALSE);
    m_DurationText[EffectIndex].EnableWindow(FALSE);
    m_Magnitude1Text[EffectIndex].EnableWindow(FALSE);
    m_Magnitude2Text[EffectIndex].EnableWindow(FALSE);
    m_AreaText[EffectIndex].EnableWindow(FALSE);
    m_DurationText[EffectIndex].SetModify(FALSE);
    m_Magnitude1Text[EffectIndex].SetModify(FALSE);
    m_Magnitude2Text[EffectIndex].SetModify(FALSE);
    m_AreaText[EffectIndex].SetModify(FALSE);
    return;
   }
  
	/* Select the effect ID */
  FindComboListItem(m_EffectList[EffectIndex], pSpellData->EffectID, true);

	/* Set the effect magnitude */
  if (pEffectData->HasMagnitude()) {
    Buffer.Format(_T("%d"), (int)pSpellData->MagMin);
    m_Magnitude1Text[EffectIndex].EnableWindow(TRUE);
    m_Magnitude1Text[EffectIndex].SetWindowText(Buffer);
    m_Magnitude1Text[EffectIndex].SetModify(FALSE);
    Buffer.Format(_T("%d"), (int)pSpellData->MagMax);
    m_Magnitude2Text[EffectIndex].EnableWindow(TRUE);
    m_Magnitude2Text[EffectIndex].SetWindowText(Buffer);
    m_Magnitude2Text[EffectIndex].SetModify(FALSE);
   }
  else {
    m_Magnitude1Text[EffectIndex].EnableWindow(FALSE);
    m_Magnitude1Text[EffectIndex].SetWindowText(_T(""));
    m_Magnitude1Text[EffectIndex].SetModify(FALSE);
    m_Magnitude2Text[EffectIndex].EnableWindow(FALSE);
    m_Magnitude2Text[EffectIndex].SetWindowText(_T(""));
    m_Magnitude2Text[EffectIndex].SetModify(FALSE);
   }

	/* Set the effect duration */
  if (pEffectData->HasDuration()) {
    Buffer.Format(_T("%d"), (int)pSpellData->Duration);
    m_DurationText[EffectIndex].EnableWindow(!m_DisableCost);
    m_DurationText[EffectIndex].SetWindowText(Buffer);
    m_DurationText[EffectIndex].SetModify(FALSE);
   }
  else {
    m_DurationText[EffectIndex].EnableWindow(FALSE);
    m_DurationText[EffectIndex].SetWindowText(_T(""));
    m_DurationText[EffectIndex].SetModify(FALSE);
   }

	/* Set the effect range */
  if (pEffectData->IsSelfOnly()) {
    FillEsmEnchantRangeCombo(m_RangeList[EffectIndex]);
    m_RangeList[EffectIndex].EnableWindow(TRUE);
    m_RangeList[EffectIndex].SetCurSel(0);
    m_AreaText[EffectIndex].EnableWindow(TRUE);
    m_AreaText[EffectIndex].SetWindowText(_T(""));
   }
  else if (pEffectData->IsNotSelf()) {
    FillEsmEnchantRangeCombo(m_RangeList[EffectIndex], true);
    m_RangeList[EffectIndex].EnableWindow(!m_DisableCost);
    FindComboListItem(m_RangeList[EffectIndex], pSpellData->RangeType, true);
    m_AreaText[EffectIndex].EnableWindow(TRUE);
   }
  else {
    FillEsmEnchantRangeCombo(m_RangeList[EffectIndex]);
    m_RangeList[EffectIndex].EnableWindow(TRUE);
    FindComboListItem(m_RangeList[EffectIndex], pSpellData->RangeType, true);
    m_AreaText[EffectIndex].EnableWindow(TRUE);
   }

	/* Set the effect area */
  Buffer.Format(_T("%d"), (int)pSpellData->Area);
  m_AreaText[EffectIndex].SetWindowText(Buffer);
  m_AreaText[EffectIndex].SetModify(FALSE);

	/* Disable the area/range controls if required */
  if (m_DisableCost) {
    m_RangeList[EffectIndex].EnableWindow(FALSE);
    m_RangeList[EffectIndex].SelectString(-1, _T("Self"));
    m_AreaText[EffectIndex].EnableWindow(FALSE);
   }

	/* Set the initial effect cost and total cost labels */
  Buffer.Format(_T("%d"), 0);
  m_CostLabel[EffectIndex].SetWindowText(Buffer);
  Buffer.Format(_T("%d"), 0);
  m_TotalCostText[EffectIndex].SetWindowText(Buffer);

	/* Fill in the skill/attribute list as required */
  if (IsESMSkillEffect(pSpellData->EffectID)) {
    m_SkillList[EffectIndex].EnableWindow(TRUE);
    FillEsmSkillsCombo(m_SkillList[EffectIndex]);
    FindComboListItem(m_SkillList[EffectIndex], pSpellData->SkillID, true);
   }
  else if (IsESMAttributeEffect(pSpellData->EffectID)) {
    m_SkillList[EffectIndex].EnableWindow(TRUE);
    FillEsmAttributesCombo(m_SkillList[EffectIndex]);
    FindComboListItem(m_SkillList[EffectIndex], pSpellData->AttributeID, true);
   }
  else {
    m_SkillList[EffectIndex].EnableWindow(FALSE);
   }

  UpdateSpellCost(EffectIndex);
 }
/*===========================================================================
 *		End of Class Method CEsmSpellDlg::SetEffectData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Method - void SetEffectData (void);
 *
 *=========================================================================*/
void CEsmSpellDlg::SetEffectData (void) {
  CEsmSubENAM*	pEffectRecord;
  int		RecordIndex;
  int		EffectIndex;

  pEffectRecord = (CEsmSubENAM *) m_pSpell->FindFirst(MWESM_SUBREC_ENAM, RecordIndex);

  for (EffectIndex = 0; EffectIndex < MWESM_ENCHANT_NUMENCHANTS; EffectIndex++) {
    SetEffectData(EffectIndex, pEffectRecord);
    pEffectRecord =  (CEsmSubENAM *) m_pSpell->FindNext(MWESM_SUBREC_ENAM, RecordIndex);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmSpellDlg::SetEffectData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Method - void UpdateSpellCost (EffectIndex);
 *
 *=========================================================================*/
void CEsmSpellDlg::UpdateSpellCost (const int EffectIndex) {
  CString	  Buffer;
  enchanteffect_t EffectData;
  int		  ListIndex;
  float		  Cost;

	/* Get the current effect ID for the effect */
  EffectData.EffectID = -1;
  ListIndex = m_EffectList[EffectIndex].GetCurSel();
  if (ListIndex >= 0) EffectData.EffectID = (short)m_EffectList[EffectIndex].GetItemData(ListIndex);

	/* No effect selected, clear costs */
  if (EffectData.EffectID < 0) {
    m_CostLabel[EffectIndex].SetWindowText(_T(""));
    m_TotalCostText[EffectIndex].SetWindowText(_T(""));
    return;
   }

	/* Compute the spell cost if the effect is available */
  if (m_pEffectInfo[EffectIndex] != NULL) { 
    m_Magnitude1Text[EffectIndex].GetWindowText(Buffer);
    EffectData.MagMin = atoi(Buffer);
    m_Magnitude2Text[EffectIndex].GetWindowText(Buffer);
    EffectData.MagMax = atoi(Buffer);
    m_DurationText[EffectIndex].GetWindowText(Buffer);
    EffectData.Duration = atoi(Buffer);
    m_AreaText[EffectIndex].GetWindowText(Buffer);
    EffectData.Area = atoi(Buffer);
    Cost = ((CEsmMagicEffect *)m_pEffectInfo[EffectIndex]->pRecord)->GetEnchantCost(EffectData);
    Buffer.Format(_T("%.2f"), ((CEsmMagicEffect *)m_pEffectInfo[EffectIndex]->pRecord)->GetBaseCost());
    m_CostLabel[EffectIndex].SetWindowText(Buffer);
   }
  else {
    m_CostLabel[EffectIndex].SetWindowText(_T("???"));
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
 *		End of Class Method CEsmSpellDlg::UpdateSpellCost()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Method - void UpdateTotalSpellCost (void);
 *
 *=========================================================================*/
void CEsmSpellDlg::UpdateTotalSpellCost (void) {
  CString Buffer;
  int     Index;
  int     EnchantType = MWESM_ENCHTYPE_CASTONCE;
  float   SumValue = 0;

	/* Ignore if we are not auto-computing */
  if (m_AutoCalcCheck.GetCheck() == 0) return;
  Index = m_TypeList.GetCurSel();
  if (Index >= 0) EnchantType = m_TypeList.GetItemData(Index);

  if (EnchantType != MWESM_ENCHTYPE_CONSTANT) {
    for (Index = 0; Index < MWESM_ENCHANT_NUMENCHANTS; Index++) {
      m_TotalCostText[Index].GetWindowText(Buffer);
      SumValue += (float) atof(Buffer);
     }
   }

	/* Set the cost text */
  Buffer.Format(_T("%d"), (int) SumValue);
  m_CostText.SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmSpellDlg::UpdateTotalSpellCost()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Event - void OnAutocalccheck ();
 *
 *=========================================================================*/
void CEsmSpellDlg::OnAutocalccheck() {
  m_CostText.EnableWindow(!m_AutoCalcCheck.GetCheck() && !m_DisableCost);

  UpdateTotalSpellCost();
 }
/*===========================================================================
 *		End of Class Event CEsmSpellDlg::OnAutocalccheck()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSpellDlg Event - void OnSelchangeTypelist ();
 *
 *=========================================================================*/
void CEsmSpellDlg::OnSelchangeTypelist() {
  CString Buffer;
  int     ListIndex;
  int     Type;

  ListIndex = m_TypeList.GetCurSel();
  if (ListIndex < 0) return;
  Type = m_TypeList.GetItemData(ListIndex);

  m_PCStartCheck.EnableWindow(Type == MWESM_SPELLTYPE_SPELL);
  m_DisableCost = !((Type == MWESM_SPELLTYPE_SPELL) || (Type == MWESM_SPELLTYPE_POWER));
  m_CostText.EnableWindow(!m_DisableCost && !m_AutoCalcCheck.GetCheck());
  m_AutoCalcCheck.EnableWindow(!m_DisableCost);

  for (ListIndex = 0; ListIndex < MWESM_ENCHANT_NUMENCHANTS; ListIndex++) {
    m_EffectList[ListIndex].GetWindowText(Buffer);
    FillEsmEffectsCombo(m_EffectList[ListIndex], m_DisableCost);
    m_EffectList[ListIndex].SelectString(-1, Buffer);
    m_RangeList[ListIndex].EnableWindow(!m_DisableCost);
    OnSelChangeEffectList(ListIndex);
   }

  m_Modified = true;
  UpdateTotalSpellCost();
 }
/*===========================================================================
 *		End of Class Event CEsmSpellDlg::OnSelchangeTypelist()
 *=========================================================================*/
