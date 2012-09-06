/*===========================================================================
 *
 * File:	Esmenchantdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 15, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmEnchantDlg.h"


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

  IMPLEMENT_DYNCREATE(CEsmEnchantDlg, CEsmRecDialog);
  DEFINE_FILE("EsmEnchantDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmEnchantDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmEnchantDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmEnchantDlg)
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
 *		End of CEsmEnchantDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Constructor
 *
 *=========================================================================*/
CEsmEnchantDlg::CEsmEnchantDlg() : CEsmRecDialog(CEsmEnchantDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmEnchantDlg)
  //}}AFX_DATA_INIT
  int Index;
  m_pEnchant = NULL;
  m_IsConstantEffect = false;

  for (Index = 0; Index < MWESM_ENCHANT_NUMENCHANTS; Index++) {
    m_pEffectInfo[Index] = NULL;
   }

 }
/*===========================================================================
 *		End of Class CEsmEnchantDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmEnchantDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmEnchantDlg)
  DDX_Control(pDX, IDC_COSTTEXT, m_CostText);
  DDX_Control(pDX, IDC_CHARGETEXT, m_ChargeText);
  DDX_Control(pDX, IDC_AUTOCALCCHECK, m_AutoCalcCheck);
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
 *		End of Class Method CEsmEnchantDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmEnchantDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmEnchantDlg::GetControlData()");
  enchantdata_t* pEnchantData;
 CString	 Buffer;  
  int		 ListIndex;

	/* Update the armor pointer and data */
  m_pEnchant = (CEsmEnchant *) GetRecInfo()->pRecord;
  if (m_pEnchant == NULL) return;
  pEnchantData = m_pEnchant->GetEnchantData();
  ASSERT(pEnchantData != NULL);

	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pEnchant->SetID(TrimStringSpace(Buffer));
   }

     	/* Enchant type */
  ListIndex = m_TypeList.GetCurSel();
  if (ListIndex >= 0) m_pEnchant->SetEnchantType(m_TypeList.GetItemData(ListIndex));

	/* Item cost */
  m_CostText.GetWindowText(Buffer);
  pEnchantData->EnchantCost = atoi(Buffer);

	/* Item charge */
  m_ChargeText.GetWindowText(Buffer);
  pEnchantData->Charge = atoi(Buffer);

	/* Record flags */
  pEnchantData->AutoCalc = (m_AutoCalcCheck.GetCheck() != 0);

  GetEffectData();
 }
/*===========================================================================
 *		End of Class Method CEsmEnchantDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Method - void GetEffectData (EffectIndex);
 *
 *=========================================================================*/
void CEsmEnchantDlg::GetEffectData (const int EffectIndex) {
  CEsmSubENAM*     pEnchantSubRec;
  enchanteffect_t* pEnchantData;
  CString	   Buffer;
  int	 	   ListIndex;

	/* Get the currently selected effect */
  ListIndex = m_EffectList[EffectIndex].GetCurSel();
  if (ListIndex < 0) return;

	/* Create the new index sub-record */
  pEnchantSubRec = (CEsmSubENAM *) m_pEnchant->AllocateSubRecord(MWESM_SUBREC_ENAM);
  pEnchantSubRec->CreateNew();
  pEnchantData = pEnchantSubRec->GetEnchantData();

	/* Set the enchant effect */
  pEnchantData->EffectID = (short) m_EffectList[EffectIndex].GetItemData(ListIndex);

	/* Set the enchant duration */
  m_DurationText[EffectIndex].GetWindowText(Buffer);
  pEnchantData->Duration = (short) (atoi(Buffer));
  if (pEnchantData->Duration < 0) pEnchantData->Duration = 0;

	/* Get the range type */
  ListIndex = m_RangeList[EffectIndex].GetCurSel();
  if (ListIndex >= 0) pEnchantData->RangeType = m_RangeList[EffectIndex].GetItemData(ListIndex);

  	/* Set the enchant area */
  m_AreaText[EffectIndex].GetWindowText(Buffer);
  pEnchantData->Area = (short) (atoi(Buffer));
  if (pEnchantData->Area < 0) pEnchantData->Area = 0;

	/* Get the enchant magnitude */
  m_Magnitude1Text[EffectIndex].GetWindowText(Buffer);
  pEnchantData->MagMin = (short) (atoi(Buffer));
  if (pEnchantData->MagMin < 0) pEnchantData->MagMin = 0;
  m_Magnitude2Text[EffectIndex].GetWindowText(Buffer);
  pEnchantData->MagMax = (short) (atoi(Buffer));
  if (pEnchantData->MagMax < 0) pEnchantData->MagMax = 0;

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
 *		End of Class Method CEsmEnchantDlg::GetEffectData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Method - void GetEffectData (void);
 *
 *=========================================================================*/
void CEsmEnchantDlg::GetEffectData (void) {
  //DEFINE_FUNCTION("CEsmEnchantDlg::GetEffectData()");
  int Index;

	/* Delete all the enchant ub-records from the alchemy record */
  m_pEnchant->DeleteSubRecords(MWESM_SUBREC_ENAM);
  
  for (Index = 0; Index < MWESM_ENCHANT_NUMENCHANTS; Index++) {
    GetEffectData(Index);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmEnchantDlg::GetEffectData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmEnchantDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_CostText.GetModify()) m_Modified = true;
  if (m_ChargeText.GetModify()) m_Modified = true;
  if (m_IDText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmEnchantDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmEnchantDlg::OnInitialUpdate() {
  int Index;

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pEnchant = (CEsmEnchant *) GetRecInfo()->pRecord;
  FillEsmEnchantTypeCombo(m_TypeList);

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
 *		End of Class Event CEsmEnchantDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Event - void OnSelChangeEffectList (ListIndex);
 *
 *=========================================================================*/
void CEsmEnchantDlg::OnSelChangeEffectList (const int ListIndex) { 
  const esmeffectdata_t* pEffectData = NULL;
  int EffectIndex;
  int EffectID = -1;
  int PrevSel;

  EffectIndex = m_EffectList[ListIndex].GetCurSel();

  if (EffectIndex >= 0) {
    EffectID = m_EffectList[ListIndex].GetItemData(EffectIndex);
    m_pEffectInfo[ListIndex] = GetDocument()->GetEffectRecord(EffectID);
    pEffectData = GetESMEffectData(EffectID);
    SystemLog.Printf ("EffectID = %d (%p, %p)", EffectID, m_pEffectInfo[ListIndex], pEffectData);
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
    m_DurationText[ListIndex].EnableWindow(TRUE);
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
  if (pEffectData->IsSelfOnly()) {
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
 *		End of Class Event CEsmEnchantDlg::OnSelChangeEffectList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Event - void OnSelChangeSkillList (ListIndex);
 *
 *=========================================================================*/
void CEsmEnchantDlg::OnSelChangeSkillList (const int ListIndex) {
  UpdateSpellCost(ListIndex);
  m_Modified = true;
 }
/*===========================================================================
 *		End of Class Event CEsmEnchantDlg::OnSelChangeSkillList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmEnchantDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmEnchantDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmEnchantDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pEnchant == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pEnchant->GetID());
  UpdateTitle(m_pEnchant->GetID());

  	/* Enchant type */
  FindComboListItem(m_TypeList, m_pEnchant->GetEnchantTypeID(), true);
  m_IsConstantEffect = (m_pEnchant->GetEnchantTypeID() == MWESM_ENCHTYPE_CONSTANT);

	/* Item strings and values */
  m_ChargeText.SetWindowText(m_pEnchant->GetFieldString(ESM_FIELD_CHARGE));
  m_CostText.SetWindowText(m_pEnchant->GetFieldString(ESM_FIELD_COST));
  m_CostText.EnableWindow(!m_pEnchant->IsAutoCalc() && !m_IsConstantEffect);
  m_ChargeText.EnableWindow(!m_pEnchant->IsAutoCalc() && !m_IsConstantEffect);
  m_CostText.SetModify(FALSE);
  m_ChargeText.SetModify(FALSE);

	/* Record flags */
  m_AutoCalcCheck.SetCheck(m_pEnchant->IsAutoCalc());

	/* Set the effect data */
  SetEffectData();
 }
/*===========================================================================
 *		End of Class Method CEsmEnchantDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Method - void SetEffectData (EffectIndex, pEffectRecord);
 *
 *=========================================================================*/
void CEsmEnchantDlg::SetEffectData (const int EffectIndex, CEsmSubENAM* pEffectRecord) {
  DEFINE_FUNCTION("CEsmEnchantDlg::SetEffectData()");
  const esmeffectdata_t* pEffectData = NULL;
  CString	   Buffer;
  enchanteffect_t* pEnchantData = NULL;

	/* Try and get the enchant/effect data */
  if (pEffectRecord != NULL) {
    pEnchantData = pEffectRecord->GetEnchantData();
    ASSERT(pEnchantData != NULL);
    pEffectData = GetESMEffectData(pEnchantData->EffectID);
    m_pEffectInfo[EffectIndex] = GetDocument()->GetEffectRecord(pEnchantData->EffectID);
   }

	/* Disable the controls if the record is not valid */
  if (pEnchantData == NULL || pEffectData == NULL) {
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
  FindComboListItem(m_EffectList[EffectIndex], pEnchantData->EffectID, true);

	/* Set the effect magnitude */
  if (pEffectData->HasMagnitude()) {
    Buffer.Format(_T("%d"), (int)pEnchantData->MagMin);
    m_Magnitude1Text[EffectIndex].EnableWindow(TRUE);
    m_Magnitude1Text[EffectIndex].SetWindowText(Buffer);
    m_Magnitude1Text[EffectIndex].SetModify(FALSE);
    Buffer.Format(_T("%d"), (int)pEnchantData->MagMax);
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

	/* Set the effect range */
  if (pEffectData->IsSelfOnly()) {
    FillEsmEnchantRangeCombo(m_RangeList[EffectIndex]);
    m_RangeList[EffectIndex].EnableWindow(FALSE);
    m_RangeList[EffectIndex].SetCurSel(0);
    m_AreaText[EffectIndex].EnableWindow(FALSE);
    m_AreaText[EffectIndex].SetWindowText(_T(""));
   }
  else if (pEffectData->IsNotSelf()) {
    FillEsmEnchantRangeCombo(m_RangeList[EffectIndex], true);
    m_RangeList[EffectIndex].EnableWindow(TRUE);
    FindComboListItem(m_RangeList[EffectIndex], pEnchantData->RangeType, true);
    m_AreaText[EffectIndex].EnableWindow(TRUE);
   }
  else {
    FillEsmEnchantRangeCombo(m_RangeList[EffectIndex]);
    m_RangeList[EffectIndex].EnableWindow(TRUE);
    FindComboListItem(m_RangeList[EffectIndex], pEnchantData->RangeType, true);
    m_AreaText[EffectIndex].EnableWindow(TRUE);
   }

	/* Set the effect area */
  Buffer.Format(_T("%d"), (int)pEnchantData->Area);
  m_AreaText[EffectIndex].SetWindowText(Buffer);
  m_AreaText[EffectIndex].SetModify(FALSE);

	/* Set the initial effect cost and total cost labels */
  Buffer.Format(_T("%d"), 0);
  m_CostLabel[EffectIndex].SetWindowText(Buffer);
  Buffer.Format(_T("%d"), 0);
  m_TotalCostText[EffectIndex].SetWindowText(Buffer);

	/* Fill in the skill/attribute list as required */
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
 *		End of Class Method CEsmEnchantDlg::SetEffectData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Method - void SetEffectData (void);
 *
 *=========================================================================*/
void CEsmEnchantDlg::SetEffectData (void) {
  CEsmSubENAM*	pEffectRecord;
  int		RecordIndex;
  int		EffectIndex;

  pEffectRecord = (CEsmSubENAM *) m_pEnchant->FindFirst(MWESM_SUBREC_ENAM, RecordIndex);

  for (EffectIndex = 0; EffectIndex < MWESM_ENCHANT_NUMENCHANTS; EffectIndex++) {
    SetEffectData(EffectIndex, pEffectRecord);
    pEffectRecord =  (CEsmSubENAM *) m_pEnchant->FindNext(MWESM_SUBREC_ENAM, RecordIndex);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmEnchantDlg::SetEffectData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Method - void UpdateSpellCost (EffectIndex);
 *
 *=========================================================================*/
void CEsmEnchantDlg::UpdateSpellCost (const int EffectIndex) {
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
 *		End of Class Method CEsmEnchantDlg::UpdateSpellCost()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Method - void UpdateTotalSpellCost (void);
 *
 *=========================================================================*/
void CEsmEnchantDlg::UpdateTotalSpellCost (void) {
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
   
  switch (EnchantType) {
    case MWESM_ENCHTYPE_CASTUSED:
	SumValue *= 5.0f;
	break;
    case MWESM_ENCHTYPE_CASTSTRIKES:
	SumValue *= 10.0f;
	break;
   }
  

	/* Set the charge text */
  Buffer.Format(_T("%d"), (int) SumValue);
  m_ChargeText.SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmEnchantDlg::UpdateTotalSpellCost()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Event - void OnAutocalccheck ();
 *
 *=========================================================================*/
void CEsmEnchantDlg::OnAutocalccheck() {
  m_CostText.EnableWindow(!m_AutoCalcCheck.GetCheck() && !m_IsConstantEffect);
  m_ChargeText.EnableWindow(!m_AutoCalcCheck.GetCheck() && !m_IsConstantEffect);

  UpdateTotalSpellCost();
 }
/*===========================================================================
 *		End of Class Event CEsmEnchantDlg::OnAutocalccheck()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEnchantDlg Event - void OnSelchangeTypelist ();
 *
 *=========================================================================*/
void CEsmEnchantDlg::OnSelchangeTypelist() {
  int ListIndex;

  ListIndex = m_TypeList.GetCurSel();
  if (ListIndex < 0) return;

  if (m_TypeList.GetItemData(ListIndex) == MWESM_ENCHTYPE_CONSTANT) {
    m_CostText.EnableWindow(!m_AutoCalcCheck.GetCheck());
    m_ChargeText.EnableWindow(!m_AutoCalcCheck.GetCheck());
    m_IsConstantEffect = true;
   }
  else {
    m_IsConstantEffect = false;
    m_CostText.EnableWindow(!m_AutoCalcCheck.GetCheck());
    m_ChargeText.EnableWindow(!m_AutoCalcCheck.GetCheck());
   }

  m_Modified = true;
  UpdateTotalSpellCost();
 }
/*===========================================================================
 *		End of Class Event CEsmEnchantDlg::OnSelchangeTypelist()
 *=========================================================================*/
