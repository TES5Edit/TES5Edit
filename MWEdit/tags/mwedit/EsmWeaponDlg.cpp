/*===========================================================================
 *
 * File:	Esmweapondlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmWeaponDlg.h"
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

  IMPLEMENT_DYNCREATE(CEsmWeaponDlg, CEsmRecDialog);
  DEFINE_FILE("EsmWeaponDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmWeaponDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmWeaponDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmWeaponDlg)
  ON_BN_CLICKED(IDC_ENCHANTEDIT, OnEnchantedit)
  ON_CBN_SELCHANGE(IDC_TYPELIST, OnSelchangeTypelist)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmWeaponDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmWeaponDlg Constructor
 *
 *=========================================================================*/
CEsmWeaponDlg::CEsmWeaponDlg() : CEsmRecDialog(CEsmWeaponDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmWeaponDlg)
  //}}AFX_DATA_INIT
  m_pWeapon = NULL;
 }
/*===========================================================================
 *		End of Class CEsmWeaponDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmWeaponDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmWeaponDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmWeaponDlg)
	DDX_Control(pDX, IDC_SCRIPTEDIT, m_ScriptButton);
  DDX_Control(pDX, IDC_PERSISTCHECK, m_PersistCheck);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_IGNORERESISTCHECK, m_IgnoreResistCheck);
  DDX_Control(pDX, IDC_ENCHANTTEXT, m_EnchantText);
  DDX_Control(pDX, IDC_ENCHANTLIST, m_EnchantList);
  DDX_Control(pDX, IDC_VALUETEXT, m_ValueText);
  DDX_Control(pDX, IDC_HEALTHTEXT, m_HealthText);
  DDX_Control(pDX, IDC_SPEEDTEXT, m_SpeedText);
  DDX_Control(pDX, IDC_CHOPMINTEXT, m_ChopMinText);
  DDX_Control(pDX, IDC_CHOPMAXTEXT, m_ChopMaxText);
  DDX_Control(pDX, IDC_SLASHMINTEXT, m_SlashMinText);
  DDX_Control(pDX, IDC_SLASHMAXTEXT, m_SlashMaxText);
  DDX_Control(pDX, IDC_THRUSTMINTEXT, m_ThrustMinText);
  DDX_Control(pDX, IDC_THRUSTMAXTEXT, m_ThrustMaxText);
  DDX_Control(pDX, IDC_REACHTEXT, m_ReachText);
  DDX_Control(pDX, IDC_WEIGHTTEXT, m_WeightText);
  DDX_Control(pDX, IDC_TYPELIST, m_TypeList);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_ICONPICTURE, m_IconPicture);
  DDX_Control(pDX, IDC_ICONBUTTON, m_IconButton);
  DDX_Control(pDX, IDC_MODELBUTTON, m_ModelButton);
  DDX_Control(pDX, IDC_SCRIPTLIST, m_ScriptList);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
	//}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmWeaponDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmWeaponDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmWeaponDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmWeaponDlg::GetControlData()");
  weapondata_t*	pWeaponData;
  CString	Buffer;  
  int		Index;

	/* Update the Weapon pointer and data */
  m_pWeapon = (CEsmWeapon *) GetRecInfo()->pRecord;
  if (m_pWeapon == NULL) return;
  pWeaponData = m_pWeapon->GetWeaponData();
  ASSERT(pWeaponData != NULL);

	/* Weapon ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pWeapon->SetID(TrimStringSpace(Buffer));
   }

	/* Weapon name */
  m_NameText.GetWindowText(Buffer);
  m_pWeapon->SetName(TrimStringSpace(Buffer));

	/* Weapon type */
  Index = m_TypeList.GetCurSel();
  if (Index >= 0) pWeaponData->Type = (short)m_TypeList.GetItemData(Index);

	/* Weapon speed */
  m_SpeedText.GetWindowText(Buffer);
  pWeaponData->Speed = (float) atof(Buffer);

  	/* Weapon reach */
  m_ReachText.GetWindowText(Buffer);
  pWeaponData->Reach = (float) atof(Buffer);

	/* Weapon health */
  m_HealthText.GetWindowText(Buffer);
  pWeaponData->Health = (short) atoi(Buffer);

	/* Weapon weight */
  m_WeightText.GetWindowText(Buffer);
  pWeaponData->Weight = (float) atof(Buffer);

	/* Weapon value */
  m_ValueText.GetWindowText(Buffer);
  pWeaponData->Value = atoi(Buffer);

	/* Enchant points */
  m_EnchantText.GetWindowText(Buffer);
  pWeaponData->EnchantPts = atoi(Buffer);

	/* Item script */
  m_ScriptList.GetWindowText(Buffer);
  
  switch (pWeaponData->Type) {
    case MWESM_WEAPONTYPE_THROWN:
    case MWESM_WEAPONTYPE_BOLT:
    case MWESM_WEAPONTYPE_ARROW:
	m_pWeapon->SetScript(NULL);
	break;
    default:
	m_pWeapon->SetScript(TrimStringSpace(Buffer));
	break;
  }

  	/* Item enchant */
  m_EnchantList.GetWindowText(Buffer);
  m_pWeapon->SetEnchant(TrimStringSpace(Buffer));

	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pWeapon->SetModel(TrimStringSpace(Buffer));

  	/* Icon filename */
  m_IconButton.GetWindowText(Buffer);
  m_pWeapon->SetIcon(TrimStringSpace(Buffer));

	/* Damage */
  m_ChopMinText.GetWindowText(Buffer);
  pWeaponData->ChopMin = (byte)atoi(Buffer);
  m_ChopMaxText.GetWindowText(Buffer);
  pWeaponData->ChopMax = (byte)atoi(Buffer);
  m_SlashMinText.GetWindowText(Buffer);
  pWeaponData->SlashMin = (byte)atoi(Buffer);
  m_SlashMaxText.GetWindowText(Buffer);
  pWeaponData->SlashMax = (byte)atoi(Buffer);
  m_ThrustMinText.GetWindowText(Buffer);
  pWeaponData->ThrustMin = (byte)atoi(Buffer);
  m_ThrustMaxText.GetWindowText(Buffer);
  pWeaponData->ThrustMax = (byte)atoi(Buffer);

	/* Record flags */
  m_pWeapon->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pWeapon->SetBlocked(m_BlockedCheck.GetCheck() != 0);

  if (m_IgnoreResistCheck.GetCheck())
    pWeaponData->Flags = MWESM_WEAPONFLAG_IGNORERESIST;
  else
    pWeaponData->Flags = 0;

 }
/*===========================================================================
 *		End of Class Method CEsmWeaponDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmWeaponDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmWeaponDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_SpeedText.GetModify()) m_Modified = true;
  if (m_ReachText.GetModify()) m_Modified = true;
  if (m_WeightText.GetModify()) m_Modified = true;
  if (m_ValueText.GetModify()) m_Modified = true;
  if (m_HealthText.GetModify()) m_Modified = true;
  if (m_EnchantText.GetModify()) m_Modified = true;
  if (m_NameText.GetModify()) m_Modified = true;
  if (m_IDText.GetModify())   m_Modified = true;
  if (m_ChopMinText.GetModify()) m_Modified = true;
  if (m_ChopMaxText.GetModify()) m_Modified = true;
  if (m_SlashMinText.GetModify()) m_Modified = true;
  if (m_SlashMaxText.GetModify()) m_Modified = true;
  if (m_ThrustMinText.GetModify()) m_Modified = true;
  if (m_ThrustMaxText.GetModify()) m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmWeaponDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmWeaponDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmWeaponDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the Weapon record */
  ASSERT(GetRecInfo() != NULL);
  m_pWeapon = (CEsmWeapon *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmWeaponTypeCombo(m_TypeList);
  FillEsmScriptCombo(m_ScriptList);
  FillEsmEnchantCombo(m_EnchantList);
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
  m_EnchantText.SetLimitText(16);
  m_WeightText.SetLimitText(16);
  m_SpeedText.SetLimitText(16);
  m_ReachText.SetLimitText(16);
  m_HealthText.SetLimitText(16);
  m_ValueText.SetLimitText(16);

  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmWeaponDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmWeaponDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmWeaponDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {

  	/* Refill the script list if required */
  if (pRecInfo->pRecord->IsType(MWESM_REC_SCRI)) {
    esmrecinfo_t* pRecInfo = NULL;
    int	  	  Index;

    Index = m_ScriptList.GetCurSel();
    if (Index >= 0) pRecInfo = (esmrecinfo_t *) m_ScriptList.GetItemData(Index);
    FillEsmScriptCombo(m_ScriptList);
    FindComboListItem(m_ScriptList, (DWORD) pRecInfo, true);
   }
  else if (pRecInfo->pRecord->IsType(MWESM_REC_ENCH)) {
    esmrecinfo_t* pRecInfo = NULL;
    int	  	  Index;

    Index = m_EnchantList.GetCurSel();
    if (Index >= 0) pRecInfo = (esmrecinfo_t *) m_EnchantList.GetItemData(Index);
    FillEsmEnchantCombo(m_EnchantList);
    FindComboListItem(m_EnchantList, (DWORD) pRecInfo, true);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmWeaponDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmWeaponDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmWeaponDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pWeapon == NULL) return;

	/* Weapon ID, update title as well */
  m_IDText.SetWindowText(m_pWeapon->GetID());
  UpdateTitle(m_pWeapon->GetID());

	/* Item strings and values */
  m_NameText.SetWindowText(m_pWeapon->GetName());
  m_SpeedText.SetWindowText(m_pWeapon->GetFieldString(ESM_FIELD_SPEED));
  m_ReachText.SetWindowText(m_pWeapon->GetFieldString(ESM_FIELD_REACH));
  m_HealthText.SetWindowText(m_pWeapon->GetFieldString(ESM_FIELD_HEALTH));
  m_WeightText.SetWindowText(m_pWeapon->GetFieldString(ESM_FIELD_WEIGHT));
  m_ValueText.SetWindowText(m_pWeapon->GetFieldString(ESM_FIELD_VALUE));
  m_EnchantText.SetWindowText(m_pWeapon->GetFieldString(ESM_FIELD_ENCHANTPTS));
  m_NameText.SetModify(FALSE);
  m_SpeedText.SetModify(FALSE);
  m_ReachText.SetModify(FALSE);
  m_HealthText.SetModify(FALSE);
  m_WeightText.SetModify(FALSE);
  m_ValueText.SetModify(FALSE);
  m_EnchantText.SetModify(FALSE);

	/* Damage */
  m_ChopMinText.SetWindowText(m_pWeapon->GetFieldString(ESM_FIELD_CHOPMIN));
  m_ChopMaxText.SetWindowText(m_pWeapon->GetFieldString(ESM_FIELD_CHOPMAX));
  m_SlashMinText.SetWindowText(m_pWeapon->GetFieldString(ESM_FIELD_SLASHMIN));
  m_SlashMaxText.SetWindowText(m_pWeapon->GetFieldString(ESM_FIELD_SLASHMAX));
  m_ThrustMinText.SetWindowText(m_pWeapon->GetFieldString(ESM_FIELD_THRUSTMIN));
  m_ThrustMaxText.SetWindowText(m_pWeapon->GetFieldString(ESM_FIELD_THRUSTMAX));
  m_ChopMinText.SetModify(FALSE);
  m_ChopMaxText.SetModify(FALSE);
  m_SlashMinText.SetModify(FALSE);
  m_SlashMaxText.SetModify(FALSE);
  m_ThrustMinText.SetModify(FALSE);
  m_ThrustMaxText.SetModify(FALSE);

	/* Model/icon buttons */
  m_ModelButton.SetWindowText(m_pWeapon->GetModel());
  m_IconButton.SetWindowText(m_pWeapon->GetIcon());
  m_IconPicture.SetEsmIcon(m_pWeapon->GetIcon());
  
	/* Item lists */
  FindComboListItem(m_TypeList, m_pWeapon->GetWeaponTypeID(), true);
  m_EnchantList.SelectString(-1, m_pWeapon->GetEnchant());
  m_ScriptList.SelectString(-1, m_pWeapon->GetScript());

	/* Record flags */
  m_BlockedCheck.SetCheck(m_pWeapon->IsBlocked());
  m_PersistCheck.SetCheck(m_pWeapon->IsPersist());
  m_IgnoreResistCheck.SetCheck(m_pWeapon->IsIgnoreResist());

  OnSelchangeTypelist();
}
/*===========================================================================
 *		End of Class Method CEsmWeaponDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmWeaponDlg Event - void OnEnchantedit ();
 *
 *=========================================================================*/
void CEsmWeaponDlg::OnEnchantedit() {
  esmrecinfo_t* pRecInfo;
  int		Index;

  Index = m_EnchantList.GetCurSel();
  if (Index < 0) return;
  pRecInfo = (esmrecinfo_t *) m_EnchantList.GetItemData(Index);

  m_pParent->EditRecord(pRecInfo, false);
 }
/*===========================================================================
 *		End of Class Event CEsmWeaponDlg::OnEnchantedit()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmWeaponDlg Event - void OnSelchangeTypelist ();
 *
 *=========================================================================*/
void CEsmWeaponDlg::OnSelchangeTypelist() {
  int ListIndex;
  int Type;

  ListIndex = m_TypeList.GetCurSel();
  if (ListIndex < 0) return;
  Type = (short) m_TypeList.GetItemData(ListIndex);

  switch (Type) {
    case MWESM_WEAPONTYPE_THROWN:
    case MWESM_WEAPONTYPE_BOLT:
    case MWESM_WEAPONTYPE_ARROW:
	m_ScriptList.EnableWindow(FALSE);
	m_ScriptButton.EnableWindow(FALSE);
	break;
    default:
	m_ScriptList.EnableWindow(TRUE);
	m_ScriptButton.EnableWindow(TRUE);
	break;
  }

}
/*===========================================================================
 *		End of Class Event CEsmWeaponDlg::OnSelchangeTypelist()
 *=========================================================================*/
