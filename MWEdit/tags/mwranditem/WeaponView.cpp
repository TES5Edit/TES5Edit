/*===========================================================================
 *
 * File:	Weaponview.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	May 22, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWRandItem.h"
#include "WeaponView.h"
#include "EsmWeapon.h"
#include "MWRandItemDlg.h"
#include "dl_Math.h"
#include "WinUtil.h"


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

  IMPLEMENT_DYNCREATE(CWeaponView, CPropertyPage);
  DEFINE_FILE("WeaponView.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CWeaponView Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CWeaponView, CPropertyPage)
  //{{AFX_MSG_MAP(CWeaponView)
  ON_BN_CLICKED(IDC_CREATEBUTTON, OnCreateButton)
  ON_BN_CLICKED(IDC_USENUMBERID, OnUsenumberid)
  ON_BN_CLICKED(IDC_LEVELLIST, OnLevellist)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CWeaponView Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CWeaponView Constructor
 *
 *=========================================================================*/
CWeaponView::CWeaponView() : CPropertyPage(CWeaponView::IDD) {
  //{{AFX_DATA_INIT(CWeaponView)
  //}}AFX_DATA_INIT
  DefaultWeaponData(m_WeaponData);
  m_pParentDlg  = NULL;
  m_ListID = _T("test_weapons_01");
 }
/*===========================================================================
 *		End of Class CWeaponView Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CWeaponView Destructor
 *
 *=========================================================================*/
CWeaponView::~CWeaponView() {
 }
/*===========================================================================
 *		End of Class CWeaponView Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CWeaponView Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CWeaponView::DoDataExchange(CDataExchange* pDX) {
  CPropertyPage::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CWeaponView)
  DDX_Control(pDX, IDC_IDPREFIX, m_IDPrefix);
  DDX_Control(pDX, IDC_USENUMBERID, m_UseNumberID);
  DDX_Control(pDX, IDC_CHANCENONE, m_ChanceNone);
  DDX_Control(pDX, IDC_LEVELLISTID, m_LevelListID);
  DDX_Control(pDX, IDC_LEVELLIST, m_CreateList);
  DDX_Control(pDX, IDC_WEIGHTFACTOR, m_WeightFactor);
  DDX_Control(pDX, IDC_ENCHANTFACTOR, m_EnchantFactor);
  DDX_Control(pDX, IDC_REACHFACTOR, m_ReachFactor);
  DDX_Control(pDX, IDC_SPEEDFACTOR, m_SpeedFactor);
  DDX_Control(pDX, IDC_HEALTHFACTOR, m_HealthFactor);
  DDX_Control(pDX, IDC_DAMAGEFACTOR, m_DamageFactor);
  DDX_Control(pDX, IDC_RESISTCHANCE, m_IgnoreChance);
  DDX_Control(pDX, IDC_ENCHANTCHANCE, m_EnchantChance);
  DDX_Control(pDX, IDC_NUMBER, m_Number);
  DDX_Control(pDX, IDC_REACH2, m_Reach2);
  DDX_Control(pDX, IDC_REACH1, m_Reach1);
  DDX_Control(pDX, IDC_SPEED2, m_Speed2);
  DDX_Control(pDX, IDC_SPEED1, m_Speed1);
  DDX_Control(pDX, IDC_CONDITION2, m_Condition2);
  DDX_Control(pDX, IDC_CONDITION1, m_Condition1);
  DDX_Control(pDX, IDC_WEIGHT2, m_Weight2);
  DDX_Control(pDX, IDC_WEIGHT1, m_Weight1);
  DDX_Control(pDX, IDC_MAXTHRUST2, m_ThrustMax2);
  DDX_Control(pDX, IDC_MAXTHRUST1, m_ThrustMax1);
  DDX_Control(pDX, IDC_MAXSLASH2, m_SlashMax2);
  DDX_Control(pDX, IDC_MAXSLASH1, m_SlashMax1);
  DDX_Control(pDX, IDC_MAXCHOP3, m_ChopMax2);
  DDX_Control(pDX, IDC_MAXCHOP1, m_ChopMax1);
  DDX_Control(pDX, IDC_MINTHRUST2, m_ThrustMin2);
  DDX_Control(pDX, IDC_MINTHRUST1, m_ThrustMin1);
  DDX_Control(pDX, IDC_MINSLASH2, m_SlashMin2);
  DDX_Control(pDX, IDC_MINSLASH1, m_SlashMin1);
  DDX_Control(pDX, IDC_MINCHOP3, m_ChopMin2);
  DDX_Control(pDX, IDC_MINCHOP1, m_ChopMin1);
	//}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CWeaponView::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CWeaponView Method - void CreateWeapon (void);
 *
 * Creates a single, random weapon using the current weapon data. Saves the
 * new weapon to the main ESP file. Protected class method.
 *
 *=========================================================================*/
void CWeaponView::CreateWeapon (void) {
  DEFINE_FUNCTION("CWeaponView::CreateWeapon()");
  CEsmWeapon*   pWeapon;
  weapondata_t* pWeaponData;
  float	        Result;
  long		Value = 0;
  long		RandFlags = 0;
  
	/* Create the weapon */
  pWeapon = (CEsmWeapon *) m_pParentDlg->CreateRecord(MWESM_REC_WEAP);
  pWeapon->CreateNew(NULL);

  //if (m_WeaponData.UseShortNumberID)
    //pWeapon->SetID(MakeNumberItemId(m_WeaponData.Prefix));
  //else
    pWeapon->SetID(MakeRandomItemId(m_WeaponData.Prefix));

  pWeapon->SetName(_T("Unknown"));
  pWeaponData = pWeapon->GetWeaponData();

	/* Weapon damage */
  Result = MakeRandItemNumber((float)m_WeaponData.ChopMin1, (float)m_WeaponData.ChopMin2, 0);
  pWeaponData->ChopMin = (int) Result;
  Result = MakeRandItemNumber((float)m_WeaponData.ChopMax1, (float)m_WeaponData.ChopMax2, 0);
  pWeaponData->ChopMax = (int) Result;
  Result = MakeRandItemNumber((float)m_WeaponData.SlashMin1, (float)m_WeaponData.SlashMin2, 0);
  pWeaponData->SlashMin = (int) Result;
  Result = MakeRandItemNumber((float)m_WeaponData.SlashMax1, (float)m_WeaponData.SlashMax2, 0);
  pWeaponData->SlashMax = (int) Result;
  Result = MakeRandItemNumber((float)m_WeaponData.ThrustMin1, (float)m_WeaponData.ThrustMin2, 0);
  pWeaponData->ThrustMin = (int) Result;
  Result = MakeRandItemNumber((float)m_WeaponData.ThrustMax1, (float)m_WeaponData.ThrustMax2, 0);
  pWeaponData->ThrustMax = (int) Result;

	/* Other stats */
  Result = MakeRandItemNumber(m_WeaponData.Reach1, m_WeaponData.Reach2, 0);
  pWeaponData->Reach = Result;
  Result = MakeRandItemNumber(m_WeaponData.Speed1, m_WeaponData.Speed2, 0);
  pWeaponData->Speed = Result;
  Result = MakeRandItemNumber((float)m_WeaponData.Condition1, (float)m_WeaponData.Condition2, 0);
  pWeaponData->Health = (int) Result;
  Result = MakeRandItemNumber(m_WeaponData.Weight1, m_WeaponData.Weight2, 0);
  pWeaponData->Weight = Result;
  Result = MakeRandItemNumber(m_WeaponData.Enchant1, m_WeaponData.Enchant2, 0);
  pWeaponData->EnchantPts = (int) Result;

	/* Weapon resistance */
  Result = MakeRandItemNumber(0.0f, 1.0f, 0);

  if (m_WeaponData.IgnoreChance >= Result) {
    pWeaponData->Flags |= MWESM_WEAPONFLAG_IGNORERESIST;
    Value += 50;
   }

	/* Enchantments */
  Result = MakeRandItemNumber(0.0f, 1.0f, 0);

  if (m_WeaponData.EnchantChance >= Result) {
    Value += 1;
   }   

	/* Weapon value */
  Result = (pWeaponData->ChopMax + pWeaponData->ChopMin + 
		pWeaponData->SlashMax + pWeaponData->SlashMin +
		pWeaponData->ThrustMax + pWeaponData->ThrustMin)/6.0f;
  Value += (long) (pow(Result - 5.0f, 5)/1000 * m_WeaponData.DamageFactor);
  Value += (long) (pow(pWeaponData->Reach - 0.7f, 5) * m_WeaponData.ReachFactor);
  Value += (long) (pow(pWeaponData->Speed - 0.7f, 5) * m_WeaponData.SpeedFactor);
  Value += (long) ((pWeaponData->Health - 20) / 10 * m_WeaponData.HealthFactor);
  Value += (long) (pWeaponData->EnchantPts * 15 * m_WeaponData.EnchantFactor);
  Value += (long) (pow(20 - pWeaponData->Weight, 3) * m_WeaponData.WeightFactor);

  if (Value < 0) Value = (long) MakeRandItemNumber(1, 200, 0);
  pWeaponData->Value = Value;
  
	/* Weapon type */
  pWeaponData->Type = Random(MWESM_WEAPONTYPE_MIN, MWESM_WEAPONTYPE_MAX);

  
	/* Add weapon to level list if required */
  if (m_WeaponData.OutputList) {
    m_pLevelItem->AddItem(pWeapon->GetID(), 1);
   }
 }
/*===========================================================================
 *		End of Class Method CWeaponView::CreateWeapon()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CWeaponView Method - void GetControlData (void);
 *
 * Gets the data from the control and saves it in the weapon data structure.
 * Does not perform any validity checks (except to ensure the weapon damage
 * is 0-255).
 *
 *=========================================================================*/
void CWeaponView::GetControlData (void) {
  CString Buffer;

  m_IgnoreChance.GetWindowText(Buffer);
  m_WeaponData.IgnoreChance = (float) atof(Buffer)/100.0f;
   
  m_EnchantChance.GetWindowText(Buffer);
  m_WeaponData.EnchantChance = (float) atof(Buffer)/100.0f;

  m_Number.GetWindowText(Buffer);
  m_WeaponData.Number = atoi(Buffer);

  m_Reach1.GetWindowText(Buffer);
  m_WeaponData.Reach1 = (float) atof(Buffer);
  m_Reach2.GetWindowText(Buffer);
  m_WeaponData.Reach2 = (float) atof(Buffer);

  m_Speed1.GetWindowText(Buffer);
  m_WeaponData.Speed1 = (float) atof(Buffer);
  m_Speed2.GetWindowText(Buffer);
  m_WeaponData.Speed2 = (float) atof(Buffer);

  m_Condition1.GetWindowText(Buffer);
  m_WeaponData.Condition1 = atoi(Buffer);
  m_Condition2.GetWindowText(Buffer);
  m_WeaponData.Condition2 = atoi(Buffer);

  m_Weight1.GetWindowText(Buffer);
  m_WeaponData.Weight1 = (float) atof(Buffer);
  m_Weight2.GetWindowText(Buffer);
  m_WeaponData.Weight2 = (float) atof(Buffer);

  m_ChopMin1.GetWindowText(Buffer);
  m_WeaponData.ChopMin1 = atoi(Buffer) & 0xFF;
  m_ChopMin2.GetWindowText(Buffer);
  m_WeaponData.ChopMin2 = atoi(Buffer) & 0xFF;
  m_ChopMax1.GetWindowText(Buffer);
  m_WeaponData.ChopMax1 = atoi(Buffer) & 0xFF;
  m_ChopMax2.GetWindowText(Buffer);
  m_WeaponData.ChopMax2 = atoi(Buffer) & 0xFF;

  m_SlashMin1.GetWindowText(Buffer);
  m_WeaponData.SlashMin1 = atoi(Buffer) & 0xFF;
  m_SlashMin2.GetWindowText(Buffer);
  m_WeaponData.SlashMin2 = atoi(Buffer) & 0xFF;
  m_SlashMax1.GetWindowText(Buffer);
  m_WeaponData.SlashMax1 = atoi(Buffer) & 0xFF;
  m_SlashMax2.GetWindowText(Buffer);
  m_WeaponData.SlashMax2 = atoi(Buffer) & 0xFF;

  m_ThrustMin1.GetWindowText(Buffer);
  m_WeaponData.ThrustMin1 = atoi(Buffer) & 0xFF;
  m_ThrustMin2.GetWindowText(Buffer);
  m_WeaponData.ThrustMin2 = atoi(Buffer) & 0xFF;
  m_ThrustMax1.GetWindowText(Buffer);
  m_WeaponData.ThrustMax1 = atoi(Buffer) & 0xFF;
  m_ThrustMax2.GetWindowText(Buffer);
  m_WeaponData.ThrustMax2 = atoi(Buffer) & 0xFF;

  m_DamageFactor.GetWindowText(Buffer);
  m_WeaponData.DamageFactor = (float) atof(Buffer);
  m_SpeedFactor.GetWindowText(Buffer);
  m_WeaponData.SpeedFactor = (float) atof(Buffer);
  m_ReachFactor.GetWindowText(Buffer);
  m_WeaponData.ReachFactor = (float) atof(Buffer);
  m_WeightFactor.GetWindowText(Buffer);
  m_WeaponData.WeightFactor = (float) atof(Buffer);
  m_HealthFactor.GetWindowText(Buffer);
  m_WeaponData.HealthFactor = (float) atof(Buffer);
  m_EnchantFactor.GetWindowText(Buffer);
  m_WeaponData.EnchantFactor = (float) atof(Buffer);

  m_ChanceNone.GetWindowText(Buffer);
  m_WeaponData.ChanceNone = (float) atof(Buffer);
  
  m_LevelListID.GetWindowText(m_ListID);
  TrimStringSpace(m_ListID);
  m_WeaponData.OutputList = (m_CreateList.GetCheck() != 0);
  m_WeaponData.UseShortNumberID = (m_UseNumberID.GetCheck() != 0);
  m_IDPrefix.GetWindowText(Buffer);
  TrimStringSpace(Buffer);
  
  if (m_WeaponData.UseShortNumberID) {
    strnncpy(m_WeaponData.Prefix, Buffer, 24);
   }
  else {
    strnncpy(m_WeaponData.Prefix, Buffer, 8);
   }

 }
/*===========================================================================
 *		End of Class Method CWeaponView::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CWeaponView Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CWeaponView::OnInitDialog() {
  CPropertyPage::OnInitDialog();

  m_IDPrefix.SetLimitText(8);
  m_LevelListID.SetLimitText(32);
  SetControlData();	
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CWeaponView::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CWeaponView Event - void OnCreateButton ();
 *
 *=========================================================================*/
void CWeaponView::OnCreateButton() {
  CString Buffer;
  int	  Index;

	/* Ensure a valid object state */
  if (m_pParentDlg == NULL) return;

	/* Update the weapon data */
  GetControlData();

	/* Setup the leveled list if required */
  if (m_WeaponData.OutputList) { 
    m_pLevelItem = (CEsmLevelItem *) m_pParentDlg->CreateRecord(MWESM_REC_LEVI);
    m_pLevelItem->CreateNew(NULL);
    m_pLevelItem->SetCalcEach(true);
    m_pLevelItem->SetChanceNone((int)m_WeaponData.ChanceNone);
    m_pLevelItem->SetAllPC(false);
    m_pLevelItem->SetID(m_ListID);
   }

	/* Make all the weapons */
  for (Index = 0; Index < m_WeaponData.Number; Index++) {
    CreateWeapon();
   }

	/* Display simple message box */
  Buffer.Format(_T("Finished creating %d random weapons."), m_WeaponData.Number);
  MessageBox(Buffer, _T("Random Weapons"));

	/* Update the item list */
  m_pParentDlg->UpdateList();
  m_pLevelItem = NULL;
 }
/*===========================================================================
 *		End of Class Event CWeaponView::OnCreateButton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CWeaponView Method - void SetControlData (void);
 *
 * Puts the data currently in the weapon structure to the controls.
 *
 *=========================================================================*/
void CWeaponView::SetControlData (void) {
  CString Buffer;

  Buffer.Format(_T("%4.1f"), m_WeaponData.IgnoreChance*100.0f);
  m_IgnoreChance.SetWindowText(Buffer);
   
  Buffer.Format(_T("%4.1f"), m_WeaponData.EnchantChance*100.0f);
  m_EnchantChance.SetWindowText(Buffer);
  
  Buffer.Format(_T("%d"), m_WeaponData.Number);
  m_Number.SetWindowText(Buffer);

  Buffer.Format(_T("%.2f"), m_WeaponData.Reach1);
  m_Reach1.SetWindowText(Buffer);
  Buffer.Format(_T("%.2f"), m_WeaponData.Reach2);
  m_Reach2.SetWindowText(Buffer);
  
  Buffer.Format(_T("%.2f"), m_WeaponData.Speed1);
  m_Speed1.SetWindowText(Buffer);
  Buffer.Format(_T("%.2f"), m_WeaponData.Speed2);
  m_Speed2.SetWindowText(Buffer);

  Buffer.Format(_T("%d"), m_WeaponData.Condition1);
  m_Condition1.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), m_WeaponData.Condition2);
  m_Condition2.SetWindowText(Buffer);

  Buffer.Format(_T("%.2g"), m_WeaponData.Weight1);
  m_Weight1.SetWindowText(Buffer);
  Buffer.Format(_T("%.2g"), m_WeaponData.Weight2);
  m_Weight2.SetWindowText(Buffer);

  Buffer.Format(_T("%d"), m_WeaponData.ChopMin1);
  m_ChopMin1.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), m_WeaponData.ChopMin2);
  m_ChopMin2.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), m_WeaponData.ChopMax1);
  m_ChopMax1.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), m_WeaponData.ChopMax2);
  m_ChopMax2.SetWindowText(Buffer);

  Buffer.Format(_T("%d"), m_WeaponData.SlashMin1);
  m_SlashMin1.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), m_WeaponData.SlashMin2);
  m_SlashMin2.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), m_WeaponData.SlashMax1);
  m_SlashMax1.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), m_WeaponData.SlashMax2);
  m_SlashMax2.SetWindowText(Buffer);

  Buffer.Format(_T("%d"), m_WeaponData.ThrustMin1);
  m_ThrustMin1.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), m_WeaponData.ThrustMin2);
  m_ThrustMin2.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), m_WeaponData.ThrustMax1);
  m_ThrustMax1.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), m_WeaponData.ThrustMax2);
  m_ThrustMax2.SetWindowText(Buffer);
  
  Buffer.Format(_T("%g"), m_WeaponData.DamageFactor);
  m_DamageFactor.SetWindowText(Buffer);
  Buffer.Format(_T("%g"), m_WeaponData.SpeedFactor);
  m_SpeedFactor.SetWindowText(Buffer);
  Buffer.Format(_T("%g"), m_WeaponData.ReachFactor);
  m_ReachFactor.SetWindowText(Buffer);
  Buffer.Format(_T("%g"), m_WeaponData.WeightFactor);
  m_WeightFactor.SetWindowText(Buffer);
  Buffer.Format(_T("%g"), m_WeaponData.HealthFactor);
  m_HealthFactor.SetWindowText(Buffer);
  Buffer.Format(_T("%g"), m_WeaponData.EnchantFactor);
  m_EnchantFactor.SetWindowText(Buffer);

  Buffer.Format(_T("%g"), m_WeaponData.ChanceNone);
  m_ChanceNone.SetWindowText(Buffer);

  m_LevelListID.SetWindowText(m_ListID);
  m_CreateList.SetCheck(m_WeaponData.OutputList);
  m_UseNumberID.SetCheck(m_WeaponData.UseShortNumberID);
  OnLevellist();
  OnUsenumberid();
  m_IDPrefix.SetWindowText(m_WeaponData.Prefix);
 }
/*===========================================================================
 *		End of Class Method CWeaponView::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CWeaponView Event - void OnUsenumberid ();
 *
 *=========================================================================*/
void CWeaponView::OnUsenumberid() {

  if (m_UseNumberID.GetCheck()) 
    m_IDPrefix.SetLimitText(24);
  else
    m_IDPrefix.SetLimitText(8);

 }
/*===========================================================================
 *		End of Class Event CWeaponView::OnUsenumberid()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CWeaponView Event - void OnLevellist ();
 *
 *=========================================================================*/
void CWeaponView::OnLevellist() {
  m_ChanceNone.EnableWindow(m_CreateList.GetCheck());
  m_LevelListID.EnableWindow(m_CreateList.GetCheck());
 }
/*===========================================================================
 *		End of Class Event CWeaponView::OnLevellist()
 *=========================================================================*/
