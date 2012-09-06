/*===========================================================================
 *
 * File:	Esmcreaturepage1.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	March 1, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmCreaturePage1.h"
#include "dl_Err.h"
#include "MWEditDoc.h"
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

  IMPLEMENT_DYNCREATE(CEsmCreaturePage1, CPropertyPage);
  DEFINE_FILE("EsmCreaturePage1.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmCreaturePage1 Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmCreaturePage1, CPropertyPage)
  //{{AFX_MSG_MAP(CEsmCreaturePage1)
  ON_BN_CLICKED(IDC_ANIMATIONBUTTON, OnAnimationbutton)
  ON_BN_CLICKED(IDC_SCRIPTEDIT, OnScriptEdit)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmCreaturePage1 Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage1 Constructor
 *
 *=========================================================================*/
CEsmCreaturePage1::CEsmCreaturePage1() : CPropertyPage(CEsmCreaturePage1::IDD) {
  //{{AFX_DATA_INIT(CEsmCreaturePage1)
  //}}AFX_DATA_INIT
  m_pRecInfo    = NULL;
  m_pDlgHandler = NULL;
  m_SortReverse = false;
  m_SortCol     = 0;
 }
/*===========================================================================
 *		End of Class CEsmCreaturePage1 Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage1 Destructor
 *
 *=========================================================================*/
CEsmCreaturePage1::~CEsmCreaturePage1() {
 }
/*===========================================================================
 *		End of Class CEsmCreaturePage1 Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage1 Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmCreaturePage1::DoDataExchange(CDataExchange* pDX) {
  CPropertyPage::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmCreaturePage1)
	DDX_Control(pDX, IDC_SCRIPTLIST, m_ScriptList);
  DDX_Control(pDX, IDC_THRUSTMAXTEXT, m_AttMax3Text);
  DDX_Control(pDX, IDC_THRUSTMINTEXT, m_AttMin3Text);
  DDX_Control(pDX, IDC_SLASHMAXTEXT, m_AttMax2Text);
  DDX_Control(pDX, IDC_SLASHMINTEXT, m_AttMin2Text);
  DDX_Control(pDX, IDC_CHOPMAXTEXT, m_AttMax1Text);
  DDX_Control(pDX, IDC_CHOPMINTEXT, m_AttMin1Text);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_PERSISTCHECK, m_PersistCheck);
  DDX_Control(pDX, IDC_WEAPSHIELDCHECK, m_WeapShieldCheck);
  DDX_Control(pDX, IDC_RESPAWNCHECK1, m_RespawnCheck);
  DDX_Control(pDX, IDC_ESSENTIALCHECK, m_EssentialCheck);
  DDX_Control(pDX, IDC_NONECHECK, m_NoneCheck);
  DDX_Control(pDX, IDC_BIPEDCHECK, m_BipedCheck);
  DDX_Control(pDX, IDC_SWIMSCHECK, m_SwimsCheck);
  DDX_Control(pDX, IDC_WALKSCHECK, m_WalksCheck);
  DDX_Control(pDX, IDC_FLIESCHECK, m_FliesCheck);
  DDX_Control(pDX, IDC_ANIMATIONBUTTON, m_AnimButton);
  DDX_Control(pDX, IDC_BLOODLIST, m_BloodList);
  DDX_Control(pDX, IDC_SOUNDGENLIST, m_SoundList);
  DDX_Control(pDX, IDC_SOULTEXT, m_SoulText);
  DDX_Control(pDX, IDC_FAQTIGUETEXT, m_FatigueText);
  DDX_Control(pDX, IDC_MAGICTEXT, m_MagicText);
  DDX_Control(pDX, IDC_HEALTHTEXT, m_HealthText);
  DDX_Control(pDX, IDC_LUCTEXT, m_LucText);
  DDX_Control(pDX, IDC_PERTEXT, m_PerText);
  DDX_Control(pDX, IDC_ENDTEXT, m_EndText);
  DDX_Control(pDX, IDC_SPDTEXT, m_SpdText);
  DDX_Control(pDX, IDC_AGITEXT, m_AgiText);
  DDX_Control(pDX, IDC_WILTEXT3, m_WilText);
  DDX_Control(pDX, IDC_INTTEXT, m_IntText);
  DDX_Control(pDX, IDC_STRTEXT, m_StrText);
  DDX_Control(pDX, IDC_STEALTHTEXT, m_StealthText);
  DDX_Control(pDX, IDC_MAGICSKILLTEXT, m_MagicSkillText);
  DDX_Control(pDX, IDC_COMBATTEXT, m_CombatText);
  DDX_Control(pDX, IDC_LEVELTEXT, m_LevelText);
  DDX_Control(pDX, IDC_TYPELIST, m_TypeList);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
	//}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmCreaturePage1::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage1 Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmCreaturePage1::GetControlData (void) {
  CEsmCreature*   pCreature;
  creaturedata_t* pCreaData;
  CString	  Buffer;
  long		  Flag;
  int		  Value;
  int		  Index;
  
  if (m_pRecInfo == NULL) return;
  pCreature = (CEsmCreature *) m_pRecInfo->pRecord;
  pCreaData = pCreature->GetCreatureData();
  Flag = 0;

  	/* Common texts */
  m_NameText.GetWindowText(Buffer);
  pCreature->SetName(Buffer);
  m_ScriptList.GetWindowText(Buffer);
  pCreature->SetScript(Buffer);
  m_LevelText.GetWindowText(Buffer);
  pCreaData->Level = atoi(Buffer);

	/* Animation button */
  m_AnimButton.GetWindowText(Buffer);
  pCreature->SetModel(Buffer);

	/* Blood list */
  Index = m_BloodList.GetCurSel();
  if (Index >= 0) Flag |= m_BloodList.GetItemData(Index);

	/* Type List */
  Index = m_TypeList.GetCurSel();
  if (Index >= 0) pCreaData->Type = m_TypeList.GetItemData(Index);  

	/* Sound list */
  m_SoundList.GetWindowText(Buffer);
  pCreature->SetSound(Buffer);

	/* Statistics */
  m_StrText.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->Strength = (long) Value;
  m_IntText.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->Intelligence = (long) Value;
  m_WilText.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->Willpower = (long) Value;
  m_SpdText.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->Speed = (long) Value;
  m_AgiText.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->Agility = (long) Value;
  m_EndText.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->Endurance = (long) Value;
  m_PerText.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->Personality = (long) Value;
  m_LucText.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->Luck = (long) Value;

  m_HealthText.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->Health = (long) Value;
  m_MagicText.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->SpellPts = (long) Value;
  m_FatigueText.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->Fatigue = (long) Value;
  m_SoulText.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->Soul = (long) Value;
  m_CombatText.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->Combat = (long) Value;
  m_MagicSkillText.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->Magic = (long) Value;
  m_StealthText.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->Stealth = (long) Value;

	/* Attacks */
  m_AttMin1Text.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->AttackMin1 = (long) Value;
  m_AttMax1Text.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->AttackMax1 = (long) Value;
  m_AttMin2Text.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->AttackMin2 = (long) Value;
  m_AttMax2Text.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->AttackMax2 = (long) Value;
  m_AttMin3Text.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->AttackMin3 = (long) Value;
  m_AttMax3Text.GetWindowText(Buffer);
  Value = atoi(Buffer);
  pCreaData->AttackMax3 = (long) Value;

	/* Movement */
  if (m_BipedCheck.GetCheck()) Flag |= MWESM_CREAFLAG_BIPED;
  if (m_NoneCheck.GetCheck()) Flag |= MWESM_CREAFLAG_NONE;
  if (m_SwimsCheck.GetCheck()) Flag |= MWESM_CREAFLAG_SWIMS;
  if (m_FliesCheck.GetCheck()) Flag |= MWESM_CREAFLAG_FLIES;
  if (m_WalksCheck.GetCheck()) Flag |= MWESM_CREAFLAG_WALKS;

   	/* NPC flags */
  if (m_RespawnCheck.GetCheck()) Flag |= MWESM_CREAFLAG_RESPAWN;
  if (m_EssentialCheck.GetCheck()) Flag |= MWESM_CREAFLAG_ESSENTIAL;
  if (m_WeapShieldCheck.GetCheck()) Flag |= MWESM_CREAFLAG_WEAPSHIELD;
  pCreature->SetPersist(m_PersistCheck.GetCheck() != 0);
  pCreature->SetBlocked(m_BlockedCheck.GetCheck() != 0);
  pCreature->SetFlag(Flag);
 }
/*===========================================================================
 *		End of Class Method CEsmCreaturePage1::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage1 Method - CMWEditDoc* GetDocument (void);
 *
 *=========================================================================*/
CMWEditDoc* CEsmCreaturePage1::GetDocument (void) {
  DEFINE_FUNCTION("CEsmCreaturePage1::GetDocument()");
  ASSERT(m_pDlgHandler != NULL);
  return m_pDlgHandler->GetDocument();
 }
/*===========================================================================
 *		End of Class Method CEsmCreaturePage1::GetDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage1 Event - void OnAnimationbutton ();
 *
 *=========================================================================*/
void CEsmCreaturePage1::OnAnimationbutton() {
  CString Buffer;
  bool    Result;

  m_AnimButton.GetWindowText(Buffer);
  Result = SelectEsmModel(Buffer, _T("Select Animation"), this);
  if (Result) m_AnimButton.SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Event CEsmCreaturePage1::OnAnimationbutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage1 Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmCreaturePage1::OnInitDialog() {
  CPropertyPage::OnInitDialog();

	/* Text controls */
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
  m_StrText.SetLimitText(8);
  m_IntText.SetLimitText(8);
  m_WilText.SetLimitText(8);
  m_EndText.SetLimitText(8);
  m_SpdText.SetLimitText(8);
  m_AgiText.SetLimitText(8);
  m_PerText.SetLimitText(8);
  m_LucText.SetLimitText(8);
  m_HealthText.SetLimitText(8);
  m_MagicText.SetLimitText(8);
  m_StealthText.SetLimitText(8);
  m_MagicSkillText.SetLimitText(8);
  m_CombatText.SetLimitText(8);
  m_FatigueText.SetLimitText(8);
  m_LevelText.SetLimitText(8);

	/* Lists */
  FillEsmScriptCombo(m_ScriptList);
  FillEsmBloodTypeCombo(m_BloodList);
  FillEsmSoundGenCreaCombo(m_SoundList);
  FillEsmCreatureListCombo(m_TypeList);
  
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmCreaturePage1::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage1 Event - void OnScriptEdit ();
 *
 *=========================================================================*/
void CEsmCreaturePage1::OnScriptEdit() {
  esmrecinfo_t* pRecInfo;
  CString	Buffer;
  
  m_ScriptList.GetWindowText(Buffer);
  pRecInfo = m_pDlgHandler->GetDocument()->FindRecord(Buffer);

  if (pRecInfo != NULL) {
    m_pDlgHandler->EditRecord(pRecInfo);
   }

 }
/*===========================================================================
 *		End of Class Event CEsmCreaturePage1::OnScriptEdit()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage1 Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmCreaturePage1::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmCreaturePage1::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage1 Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmCreaturePage1::SetControlData (void) {
  CEsmCreature*   pCreature;
  CString	  Buffer;
  creaturedata_t* pCreaData;
  
  if (m_pRecInfo == NULL) return;
  pCreature = (CEsmCreature *) m_pRecInfo->pRecord;
  pCreaData =  pCreature->GetCreatureData();

	/* Common texts */
  m_NameText.SetWindowText(pCreature->GetName());
  m_ScriptList.SelectString(-1, pCreature->GetScript());
  Buffer.Format(_T("%d"), pCreature->GetLevel());
  m_LevelText.SetWindowText(Buffer);

	/* Animation button */
  m_AnimButton.SetWindowText(pCreature->GetModel());

	/* Statistics */
  Buffer.Format(_T("%d"), (int) (byte) pCreaData->Strength);
  m_StrText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) (byte) pCreaData->Intelligence);
  m_IntText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) (byte) pCreaData->Willpower);
  m_WilText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) (byte) pCreaData->Speed);
  m_SpdText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) (byte) pCreaData->Agility);
  m_AgiText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) (byte) pCreaData->Endurance);
  m_EndText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) (byte) pCreaData->Personality);
  m_PerText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) (byte) pCreaData->Luck);
  m_LucText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) (byte)pCreaData->Health);
  m_HealthText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) (byte) pCreaData->SpellPts);
  m_MagicText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) (byte) pCreaData->Fatigue);
  m_FatigueText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pCreaData->Soul);
  m_SoulText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pCreaData->Combat);
  m_CombatText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pCreaData->Magic);
  m_MagicSkillText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pCreaData->Stealth);
  m_StealthText.SetWindowText(Buffer);

	/* Blood list */
  FindComboListItem(m_BloodList, pCreature->GetFlag() & MWESM_CREAFLAG_BLOODMASK, true);

	/* Sound list */
  m_SoundList.SelectString(-1, pCreature->GetSound());

	/* Type list */
  FindComboListItem(m_TypeList, pCreaData->Type, true);

	/* Damage */
  Buffer.Format(_T("%d"), (int) pCreaData->AttackMin1);
  m_AttMin1Text.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pCreaData->AttackMax1);
  m_AttMax1Text.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pCreaData->AttackMin2);
  m_AttMin2Text.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pCreaData->AttackMax2);
  m_AttMax2Text.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pCreaData->AttackMin3);
  m_AttMin3Text.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pCreaData->AttackMax3);
  m_AttMax3Text.SetWindowText(Buffer);

	/* NPC flags */
  m_PersistCheck.SetCheck(pCreature->IsPersist());
  m_RespawnCheck.SetCheck(pCreature->IsRespawn());
  m_BlockedCheck.SetCheck(pCreature->IsBlocked());
  m_EssentialCheck.SetCheck(pCreature->IsEssential());
  m_BipedCheck.SetCheck(pCreature->IsBiped());
  m_FliesCheck.SetCheck(pCreature->IsFlies());
  m_SwimsCheck.SetCheck(pCreature->IsSwims());
  m_WalksCheck.SetCheck(pCreature->IsWalks());
  m_NoneCheck.SetCheck(pCreature->IsNone());
  m_WeapShieldCheck.SetCheck(pCreature->IsWeapShield());
 }
/*===========================================================================
 *		End of Class Method CEsmCreaturePage1::SetControlData()
 *=========================================================================*/

