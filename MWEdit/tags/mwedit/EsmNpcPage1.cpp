/*===========================================================================
 *
 * File:	Esmnpcpage1.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 25, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmNpcPage1.h"
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

  IMPLEMENT_DYNCREATE(CEsmNpcPage1, CPropertyPage);
  DEFINE_FILE("EsmNpcPage1.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmNpcPage1 Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmNpcPage1, CPropertyPage)
  //{{AFX_MSG_MAP(CEsmNpcPage1)
  ON_MESSAGE(ESMLIST_NOTIFY_ONKEY, OnRecordKey)
  ON_MESSAGE(ESMLIST_NOTIFY_ONSORT, OnRecordSort)
  ON_NOTIFY(LVN_ENDLABELEDIT, IDC_SKILLLIST, OnEndlabeleditItemlist)
  ON_BN_CLICKED(IDC_ANIMATIONBUTTON, OnAnimationbutton)
  ON_BN_CLICKED(IDC_AUTOCALCCHECK, OnAutocalccheck)
  ON_BN_CLICKED(IDC_FEMALECHECK, OnFemalecheck)
  ON_CBN_SELCHANGE(IDC_RACELIST, OnSelchangeRacelist)
  ON_BN_CLICKED(IDC_SCRIPTEDIT, OnScriptEdit)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmNpcPage1 Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int l_SortCallback (lParam1, lParam2, lUserData);
 *
 *=========================================================================*/
int __stdcall l_SortCallback (LPARAM lParam1, LPARAM lParam2, LPARAM lUserData) {
  CEsmNpcPage1* pPage = (CEsmNpcPage1 *) lUserData;

  return pPage->SortCallback(lParam1, lParam2);
 }
/*===========================================================================
 *		End of Function l_SortCallback()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Constructor
 *
 *=========================================================================*/
CEsmNpcPage1::CEsmNpcPage1() : CPropertyPage(CEsmNpcPage1::IDD) {
  //{{AFX_DATA_INIT(CEsmNpcPage1)
  //}}AFX_DATA_INIT
  m_pRecInfo    = NULL;
  m_pDlgHandler = NULL;
  m_SortReverse = false;
  m_SortCol     = 0;
 }
/*===========================================================================
 *		End of Class CEsmNpcPage1 Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Destructor
 *
 *=========================================================================*/
CEsmNpcPage1::~CEsmNpcPage1() {
 }
/*===========================================================================
 *		End of Class CEsmNpcPage1 Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmNpcPage1::DoDataExchange(CDataExchange* pDX) {
  CPropertyPage::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmNpcPage1)
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_PERSISTCHECK, m_PersistCheck);
  DDX_Control(pDX, IDC_AUTOCALCCHECK, m_AutoCalcCheck);
  DDX_Control(pDX, IDC_RESPAWNCHECK1, m_RespawnCheck);
  DDX_Control(pDX, IDC_ESSENTIALCHECK, m_EssentialCheck);
  DDX_Control(pDX, IDC_FEMALECHECK, m_FemaleCheck);
  DDX_Control(pDX, IDC_ANIMATIONBUTTON, m_AnimButton);
  DDX_Control(pDX, IDC_BLOODLIST, m_BloodList);
  DDX_Control(pDX, IDC_HAIRLIST, m_HairList);
  DDX_Control(pDX, IDC_HEADLIST, m_HeadList);
  DDX_Control(pDX, IDC_REPUTATIONTEXT, m_RepText);
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
  DDX_Control(pDX, IDC_LEVELTEXT2, m_DispText);
  DDX_Control(pDX, IDC_LEVELTEXT, m_LevelText);
  DDX_Control(pDX, IDC_RANKLIST, m_RankList);
  DDX_Control(pDX, IDC_FACTIONLIST, m_FactionList);
  DDX_Control(pDX, IDC_CLASSLIST, m_ClassList);
  DDX_Control(pDX, IDC_RACELIST, m_RaceList);
  DDX_Control(pDX, IDC_SCRIPTLIST, m_ScriptList);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_SKILLLIST, m_SkillList);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage1::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmNpcPage1::GetControlData (void) {
  CEsmNpc*  	  pNpc;
  npclongdata_t*  pLongData;
  CString	  Buffer;
  long		  Flag;
  int		  Value;
  int		  Index;
  
  if (m_pRecInfo == NULL) return;
  pNpc = (CEsmNpc *) m_pRecInfo->pRecord;
  pLongData = pNpc->GetLongData();
  Flag = 0;

  	/* Common texts */
  m_NameText.GetWindowText(Buffer);
  pNpc->SetName(Buffer);
  m_RaceList.GetWindowText(Buffer);
  pNpc->SetRace(Buffer);
  m_ClassList.GetWindowText(Buffer);
  pNpc->SetClass(Buffer);
  m_FactionList.GetWindowText(Buffer);
  pNpc->SetFaction(Buffer);
  m_ScriptList.GetWindowText(Buffer);
  pNpc->SetScript(Buffer);

  Index = m_RankList.GetCurSel();
  pNpc->SetRank(Index >= 0 ? m_RankList.GetItemData(Index) : -1);

  m_DispText.GetWindowText(Buffer);
  pNpc->SetDisposition(atoi(Buffer));
  m_LevelText.GetWindowText(Buffer);
  pNpc->SetLevel(atoi(Buffer));

	/* Animation button */
  m_AnimButton.GetWindowText(Buffer);
  pNpc->SetAnimation(Buffer);

	/* Head/hair list */
  m_HeadList.GetWindowText(Buffer);
  pNpc->SetHeadModel(Buffer);  
  m_HairList.GetWindowText(Buffer);
  pNpc->SetHairModel(Buffer);  
  Index = m_BloodList.GetCurSel();
  if (Index >= 0) Flag |= m_BloodList.GetItemData(Index);

  if (!m_AutoCalcCheck.GetCheck() && pLongData != NULL) {
    m_StrText.GetWindowText(Buffer);
    Value = atoi(Buffer);
    FIXLIMIT(Value, 0, 255);
    pLongData->Strength = (byte) Value;
    m_IntText.GetWindowText(Buffer);
    Value = atoi(Buffer);
    FIXLIMIT(Value, 0, 255);
    pLongData->Intelligence = (byte) Value;
    m_WilText.GetWindowText(Buffer);
    Value = atoi(Buffer);
    FIXLIMIT(Value, 0, 255);
    pLongData->Willpower = (byte) Value;
    m_SpdText.GetWindowText(Buffer);
    Value = atoi(Buffer);
    FIXLIMIT(Value, 0, 255);
    pLongData->Speed = (byte) Value;
    m_AgiText.GetWindowText(Buffer);
    Value = atoi(Buffer);
    FIXLIMIT(Value, 0, 255);
    pLongData->Agility = (byte) Value;
    m_EndText.GetWindowText(Buffer);
    Value = atoi(Buffer);
    FIXLIMIT(Value, 0, 255);
    pLongData->Endurance = (byte) Value;
    m_PerText.GetWindowText(Buffer);
    Value = atoi(Buffer);
    FIXLIMIT(Value, 0, 255);
    pLongData->Personality = (byte) Value;
    m_LucText.GetWindowText(Buffer);
    Value = atoi(Buffer);
    FIXLIMIT(Value, 0, 255);
    pLongData->Luck = (byte) Value;
    m_HealthText.GetWindowText(Buffer);
    Value = atoi(Buffer);
    pLongData->Health = (short) Value;
    m_MagicText.GetWindowText(Buffer);
    Value = atoi(Buffer);
    pLongData->SpellPts = (short) Value;
    m_FatigueText.GetWindowText(Buffer);
    Value = atoi(Buffer);
    pLongData->Fatigue = (short) Value;
    m_RepText.GetWindowText(Buffer);
    Value = atoi(Buffer);
    pLongData->Reputation = (byte) Value;

    for (Index = 0; Index < MWESM_MAX_SKILLS; Index++) {
      pLongData->Skills[Index] = (char) m_SkillValues[Index];
     }
   }
  else {
    Flag |= MWESM_NPCFLAG_AUTOCALC;
   }
 
 	/* NPC flags */
  if (m_FemaleCheck.GetCheck()) Flag |= MWESM_NPCFLAG_FEMALE;
  if (m_RespawnCheck.GetCheck()) Flag |= MWESM_NPCFLAG_RESPAWN;
  if (m_EssentialCheck.GetCheck()) Flag |= MWESM_NPCFLAG_ESSENTIAL;
  pNpc->SetPersist(m_PersistCheck.GetCheck() != 0);
  pNpc->SetBlocked(m_BlockedCheck.GetCheck() != 0);
  pNpc->SetFlag(Flag);
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage1::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Method - CMWEditDoc* GetDocument (void);
 *
 *=========================================================================*/
CMWEditDoc* CEsmNpcPage1::GetDocument (void) {
  DEFINE_FUNCTION("CEsmNpcPage1::GetDocument()");
  ASSERT(m_pDlgHandler != NULL);
  return m_pDlgHandler->GetDocument();
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage1::GetDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Method - bool IsAutoCalc (void);
 *
 *=========================================================================*/
bool CEsmNpcPage1::IsAutoCalc (void) {
  if (!::IsWindow(m_AutoCalcCheck.m_hWnd)) return (false);
  return (m_AutoCalcCheck.GetCheck() != 0);
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage1::IsAutoCalc()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Event - void OnAnimationbutton ();
 *
 *=========================================================================*/
void CEsmNpcPage1::OnAnimationbutton() {
  CString Buffer;
  bool    Result;

  m_AnimButton.GetWindowText(Buffer);
  Result = SelectEsmModel(Buffer, _T("Select Animation"), this);
  if (Result) m_AnimButton.SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage1::OnAnimationbutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Event - void OnAutocalccheck ();
 *
 *=========================================================================*/
void CEsmNpcPage1::OnAutocalccheck() { 
  UpdateAutoCalc();
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage1::OnAutocalccheck()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Event - void OnEndlabeleditItemlist (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmNpcPage1::OnEndlabeleditItemlist (NMHDR* pNMHDR, LRESULT* pResult) {
  LV_DISPINFO*	pDispInfo = (LV_DISPINFO*)pNMHDR;
  CString	Buffer;
  int		Count;
  int		SkillIndex;

	/* Ignore if autocalc is enabled */
  if (m_AutoCalcCheck.GetCheck()) return;

  if (pDispInfo->item.pszText != NULL) {
    Count = atoi(pDispInfo->item.pszText);
    if (Count < SHRT_MIN) Count = SHRT_MIN;
    if (Count > SHRT_MAX) Count = SHRT_MAX;
    Buffer.Format(_T("%d"), Count);
    m_SkillList.SetItemText(pDispInfo->item.iItem, 0, Buffer);

    SkillIndex = m_SkillList.GetItemData(pDispInfo->item.iItem);
    m_SkillValues[SkillIndex] = Count;
   }

  *pResult = 0;
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage1::OnEndlabeleditItemlist()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmNpcPage1::OnInitDialog() {
  CPropertyPage::OnInitDialog();

	/* Spell List */
  m_SkillList.OnInitCtrl();
  m_SkillList.SetDlgHandler(m_pDlgHandler);
  m_SkillList.SetEnableDrag(true);
  m_SkillList.SetAcceptDrag(true);
  m_SkillList.SetWantKeys(true);
  m_SkillList.SetWantEditMsg(true);
  m_SkillList.SetWantSortMsg(true);
  m_SkillList.SetActNormal(true);
  m_SkillList.InsertColumn(0, _T("Value"), LVCFMT_CENTER, 50, 0);
  m_SkillList.InsertColumn(1, _T("Skill"), LVCFMT_LEFT, 100, 1);

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
  m_DispText.SetLimitText(8);
  m_RepText.SetLimitText(8);
  m_FatigueText.SetLimitText(8);
  m_LevelText.SetLimitText(8);

	/* Lists */
  FillEsmRankCombo(m_RankList, true);
  FillEsmScriptCombo(m_ScriptList);
  FillEsmClassCombo(m_ClassList, false);
  FillEsmRaceCombo(m_RaceList, false);
  FillEsmFactionCombo(m_FactionList, true);
  FillEsmBloodTypeCombo(m_BloodList);

  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage1::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Event - LRESULT OnRecordKey (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmNpcPage1::OnRecordKey (LPARAM lParam, LPARAM wParam) {
  CString Buffer;
  int	  ListIndex;
  int     SkillIndex;
  int     AddCount;

	/* Ignore if autocalc is enabled */
  if (m_AutoCalcCheck.GetCheck()) return (0);
  
  if (lParam == VK_SUBTRACT || lParam == VK_ADD) {
    AddCount = (lParam == VK_SUBTRACT) ? -1 : +1;
    ListIndex = m_SkillList.GetNextItem(-1, LVNI_SELECTED);

    while (ListIndex >= 0) {
      SkillIndex = m_SkillList.GetItemData(ListIndex);
      m_SkillValues[SkillIndex] += AddCount;
      Buffer.Format(_T("%d"), m_SkillValues[SkillIndex]);
      m_SkillList.SetItemText(ListIndex, 0, Buffer);
      ListIndex = m_SkillList.GetNextItem(ListIndex, LVNI_SELECTED);
     }
  
    return (1);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage1::OnRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Event - LRESULT OnRecordSort (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmNpcPage1::OnRecordSort (LPARAM lParam, LPARAM wParam) {
  esmlistsortdata_t* pSortData = (esmlistsortdata_t *) lParam;

  m_SortCol     = pSortData->iSubItem;
  m_SortReverse = pSortData->Reverse;
  m_SkillList.SortItems(l_SortCallback, (DWORD) this);

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage1::OnRecordSort()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmNpcPage1::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage1::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmNpcPage1::SetControlData (void) {
  CEsmNpc*  	  pNpc;
  CString	  Buffer;
  CString	  Race;
  npclongdata_t*  pLongData;
  int		  Index;
  int		  ListIndex;
  
  if (m_pRecInfo == NULL) return;
  pNpc = (CEsmNpc *) m_pRecInfo->pRecord;
  pLongData = pNpc->GetLongData();

	/* Common texts */
  m_NameText.SetWindowText(pNpc->GetName());

  if (pNpc->GetRace()[0] == NULL_CHAR) {
    m_RaceList.SetCurSel(0);
    m_RaceList.GetWindowText(Race);
  }
  else {
    m_RaceList.SetCurSel(-1);
    m_RaceList.SelectString(-1, pNpc->GetRace());
    Race = pNpc->GetRace();
  }

  if (pNpc->GetRace()[0] == NULL_CHAR) {
    m_ClassList.SetCurSel(0);
  }
  else {
    m_ClassList.SetCurSel(-1);
    m_ClassList.SelectString(-1, pNpc->GetClass());
  }
  
  m_FactionList.SelectString(-1, pNpc->GetFaction());
  m_ScriptList.SelectString(-1, pNpc->GetScript());
  FindComboListItem(m_RankList, pNpc->GetRank(), true);
  Buffer.Format(_T("%d"), pNpc->GetDisposition());
  m_DispText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pNpc->GetLevel());
  m_LevelText.SetWindowText(Buffer);

	/* Animation button */
  m_AnimButton.SetWindowText(pNpc->GetAnimation());

	/* Head/hair list */
  m_RaceList.GetWindowText(Buffer);
  FillEsmBodyRaceCombo(m_HeadList, MWESM_PART_HEAD, pNpc->IsFemale(), Race, false);
  FillEsmBodyRaceCombo(m_HairList, MWESM_PART_HAIR, pNpc->IsFemale(), Race, false);

  if (pNpc->GetHeadModel()[0] == NULL_CHAR) {
    m_HeadList.SetCurSel(0);
  }
  else {
    m_HeadList.SelectString(-1, pNpc->GetHeadModel());
  }

  if (pNpc->GetHairModel()[0] == NULL_CHAR) {
    m_HairList.SetCurSel(0);
  }
  else {
    m_HairList.SelectString(-1, pNpc->GetHairModel());
  }

  FindComboListItem(m_BloodList, pNpc->GetFlag() & MWESM_NPCFLAG_BLOODMASK, true);

  if (!pNpc->IsAutoCalc() && pLongData != NULL) {
    m_AutoCalcCheck.SetCheck(FALSE);
    Buffer.Format(_T("%d"), (int) (byte) pLongData->Strength);
    m_StrText.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), (int) (byte) pLongData->Intelligence);
    m_IntText.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), (int) (byte) pLongData->Willpower);
    m_WilText.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), (int) (byte) pLongData->Speed);
    m_SpdText.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), (int) (byte) pLongData->Agility);
    m_AgiText.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), (int) (byte) pLongData->Endurance);
    m_EndText.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), (int) (byte) pLongData->Personality);
    m_PerText.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), (int) (byte) pLongData->Luck);
    m_LucText.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), (int) (byte)pLongData->Health);
    m_HealthText.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), (int) (byte) pLongData->SpellPts);
    m_MagicText.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), (int) (byte) pLongData->Fatigue);
    m_FatigueText.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), (int) pLongData->Reputation);
    m_RepText.SetWindowText(Buffer);

    for (Index = 0; Index < MWESM_MAX_SKILLS; Index++) {
      ListIndex = m_SkillList.InsertItem(Index, _T("") , -1);
      m_SkillList.SetItemText(ListIndex, 1, GetESMSkill(Index));
      m_SkillList.SetItemData(ListIndex, Index);
      m_SkillValues[Index] = (int) (byte) pLongData->Skills[Index];
      Buffer.Format(_T("%d"), m_SkillValues[Index]);
      m_SkillList.SetItemText(ListIndex, 0, Buffer);
     }
   }
  else {
    m_AutoCalcCheck.SetCheck(TRUE);
    UpdateAutoCalc();

    	/* Skill list initialize */
    for (Index = 0; Index < MWESM_MAX_SKILLS; Index++) {
      ListIndex = m_SkillList.InsertItem(Index, _T("0"), -1);
      m_SkillList.SetItemText(ListIndex, 1, GetESMSkill(Index));
      m_SkillList.SetItemData(ListIndex, Index);
     }  

    memset(m_SkillValues, 0, sizeof(int) * MWESM_MAX_SKILLS);
   }

	/* NPC flags */
  m_FemaleCheck.SetCheck(pNpc->IsFemale());
  m_PersistCheck.SetCheck(pNpc->IsPersist());
  m_RespawnCheck.SetCheck(pNpc->IsRespawn());
  m_BlockedCheck.SetCheck(pNpc->IsBlocked());
  m_EssentialCheck.SetCheck(pNpc->IsEssential());
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage1::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Method - int SortCallback (lParam1, lParam2);
 *
 *=========================================================================*/
int CEsmNpcPage1::SortCallback (LPARAM lParam1, LPARAM lParam2) {
  int Result = 0;

  if (m_SortCol == 0) {
    Result = m_SkillValues[lParam1] - m_SkillValues[lParam2];
   }
  else {
    Result = StringCompare(GetESMSkill(lParam1), GetESMSkill(lParam2), false);
   }

  if (m_SortReverse) return (-Result);
  return (Result);
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage1::SortCallback()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Method - void UpdateAutoCalc (void);
 *
 *=========================================================================*/
void CEsmNpcPage1::UpdateAutoCalc (void) {
  BOOL Result = !m_AutoCalcCheck.GetCheck();
  m_StrText.EnableWindow(Result);
  m_IntText.EnableWindow(Result);
  m_WilText.EnableWindow(Result);
  m_AgiText.EnableWindow(Result);
  m_EndText.EnableWindow(Result);
  m_SpdText.EnableWindow(Result);
  m_PerText.EnableWindow(Result);
  m_LucText.EnableWindow(Result);
  m_HealthText.EnableWindow(Result);
  m_MagicText.EnableWindow(Result);
  m_FatigueText.EnableWindow(Result);
  m_RepText.EnableWindow(Result);
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage1::UpdateAutoCalc()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage1 Event - void OnScriptEdit ();
 *
 *=========================================================================*/
void CEsmNpcPage1::OnScriptEdit() {
  esmrecinfo_t* pRecInfo;
  CString	Buffer;
  
  m_ScriptList.GetWindowText(Buffer);
  pRecInfo = m_pDlgHandler->GetDocument()->FindRecord(Buffer);

  if (pRecInfo != NULL) {
    m_pDlgHandler->EditRecord(pRecInfo);
   }

 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage1::OnScriptEdit()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Body Part Rebuild Events 
 *
 *=========================================================================*/
void CEsmNpcPage1::OnFemalecheck() {
  CString RaceName;
  m_RaceList.GetWindowText(RaceName);

  FillEsmBodyRaceCombo(m_HeadList, MWESM_PART_HEAD, (m_FemaleCheck.GetCheck() != 0), RaceName, false);
  FillEsmBodyRaceCombo(m_HairList, MWESM_PART_HAIR, (m_FemaleCheck.GetCheck() != 0), RaceName, false);
  m_HeadList.SetCurSel(0);
  m_HairList.SetCurSel(0);
 }


void CEsmNpcPage1::OnSelchangeRacelist() {
  OnFemalecheck();
 }
/*===========================================================================
 *		End of Body Part Rebuild Events 
 *=========================================================================*/

