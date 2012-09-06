/*===========================================================================
 *
 * File:	Esmracedlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 18, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmRaceDlg.h"


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

  DEFINE_FILE("EsmRaceDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmRaceDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Spell Column Data
 *
 *=========================================================================*/
static esmcoldata_t l_SpellColData[] = {
	{  _T("ID"),		ESM_FIELD_ID,		LVCFMT_LEFT,	ESMLIST_WIDTH_ID,	ESMLIST_SUBITEM_ID,	NULL }, 
	{  _T("Mod"),		ESM_FIELD_CHANGED,	LVCFMT_CENTER,	ESMLIST_WIDTH_CHANGED,	ESMLIST_SUBITEM_CHANGED }, 
	{  _T("Name"),		ESM_FIELD_NAME,		LVCFMT_LEFT,	ESMLIST_WIDTH_NAME,	ESMLIST_SUBITEM_NAME }, 
	{  _T("Type"),		ESM_FIELD_TYPE,		LVCFMT_CENTER,	ESMLIST_WIDTH_TYPE,	ESMLIST_SUBITEM_TYPE },
	{  _T("Cost"),		ESM_FIELD_COST,		LVCFMT_CENTER,	ESMLIST_WIDTH_COST,	ESMLIST_SUBITEM_COST },
	{ NULL, 0, 0, 0 }	/* Must be last record */
 };
/*===========================================================================
 *		End of Spell Column Data
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmRaceDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmRaceDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmRaceDlg)
  ON_EN_CHANGE(IDC_STRTEXT1, OnChangeAttribText)
  ON_EN_CHANGE(IDC_STRTEXT2, OnChangeAttribText)
  ON_EN_CHANGE(IDC_INTTEXT1, OnChangeAttribText)
  ON_EN_CHANGE(IDC_INTTEXT2, OnChangeAttribText)
  ON_EN_CHANGE(IDC_WILTEXT1, OnChangeAttribText)
  ON_EN_CHANGE(IDC_WILTEXT2, OnChangeAttribText)
  ON_EN_CHANGE(IDC_ENDTEXT1, OnChangeAttribText)
  ON_EN_CHANGE(IDC_ENDTEXT2, OnChangeAttribText)
  ON_EN_CHANGE(IDC_PERTEXT1, OnChangeAttribText)
  ON_EN_CHANGE(IDC_PERTEXT2, OnChangeAttribText)
  ON_EN_CHANGE(IDC_LUCTEXT1, OnChangeAttribText)
  ON_EN_CHANGE(IDC_LUCTEXT2, OnChangeAttribText)
  ON_EN_CHANGE(IDC_SPDTEXT1, OnChangeAttribText)
  ON_EN_CHANGE(IDC_SPDTEXT2, OnChangeAttribText)
  ON_EN_CHANGE(IDC_AGITEXT1, OnChangeAttribText)
  ON_EN_CHANGE(IDC_AGITEXT2, OnChangeAttribText)
  ON_CBN_SELCHANGE(IDC_SKILLLIST1, OnSelchangeSkilllist1)
  ON_CBN_SELCHANGE(IDC_SKILLLIST2, OnSelchangeSkilllist2)
  ON_CBN_SELCHANGE(IDC_SKILLLIST3, OnSelchangeSkilllist3)
  ON_CBN_SELCHANGE(IDC_SKILLLIST4, OnSelchangeSkilllist4)
  ON_CBN_SELCHANGE(IDC_SKILLLIST5, OnSelchangeSkilllist5)
  ON_CBN_SELCHANGE(IDC_SKILLLIST6, OnSelchangeSkilllist6)
  ON_CBN_SELCHANGE(IDC_SKILLLIST7, OnSelchangeSkilllist7)
  ON_MESSAGE(ESMLIST_NOTIFY_ONDROP, OnRecordDrop)
  ON_MESSAGE(ESMLIST_NOTIFY_ONKEY, OnRecordKey)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmRaceDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRaceDlg Constructor
 *
 *=========================================================================*/
CEsmRaceDlg::CEsmRaceDlg() : CEsmRecDialog(CEsmRaceDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmRaceDlg)
  //}}AFX_DATA_INIT
  m_pRace = NULL;
 }
/*===========================================================================
 *		End of Class CEsmRaceDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRaceDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmRaceDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmRaceDlg)
  DDX_Control(pDX, IDC_FEMALETOTAL, m_FemaleTotal);
  DDX_Control(pDX, IDC_MALETOTAL, m_MaleTotal);
  DDX_Control(pDX, IDC_DESCTEXT, m_DescText);
  DDX_Control(pDX, IDC_SPELLLIST, m_SpellList);
  DDX_Control(pDX, IDC_BONUSTEXT7, m_BonusText7);
  DDX_Control(pDX, IDC_BONUSTEXT6, m_BonusText6);
  DDX_Control(pDX, IDC_BONUSTEXT5, m_BonusText5);
  DDX_Control(pDX, IDC_BONUSTEXT4, m_BonusText4);
  DDX_Control(pDX, IDC_BONUSTEXT3, m_BonusText3);
  DDX_Control(pDX, IDC_BONUSTEXT2, m_BonusText2);
  DDX_Control(pDX, IDC_BONUSTEXT1, m_BonusText1);
  DDX_Control(pDX, IDC_SKILLLIST7, m_SkillList7);
  DDX_Control(pDX, IDC_SKILLLIST6, m_SkillList6);
  DDX_Control(pDX, IDC_SKILLLIST5, m_SkillList5);
  DDX_Control(pDX, IDC_SKILLLIST4, m_SkillList4);
  DDX_Control(pDX, IDC_SKILLLIST3, m_SkillList3);
  DDX_Control(pDX, IDC_SKILLLIST2, m_SkillList2);
  DDX_Control(pDX, IDC_SKILLLIST1, m_SkillList1);
  DDX_Control(pDX, IDC_BEASTCHECK, m_BeastCheck);
  DDX_Control(pDX, IDC_PLAYABLECHECK, m_PlayableCheck);
  DDX_Control(pDX, IDC_WEIGHTTEXT2, m_WeightText2);
  DDX_Control(pDX, IDC_WEIGHTTEXT1, m_WeightText1);
  DDX_Control(pDX, IDC_HEIGHTTEXT2, m_HeightText2);
  DDX_Control(pDX, IDC_HEIGHTTEXT1, m_HeightText1);
  DDX_Control(pDX, IDC_LUCTEXT2, m_LucText2);
  DDX_Control(pDX, IDC_LUCTEXT1, m_LucText1);
  DDX_Control(pDX, IDC_PERTEXT2, m_PerText2);
  DDX_Control(pDX, IDC_PERTEXT1, m_PerText1);
  DDX_Control(pDX, IDC_ENDTEXT2, m_EndText2);
  DDX_Control(pDX, IDC_ENDTEXT1, m_EndText1);
  DDX_Control(pDX, IDC_SPDTEXT2, m_SpdText2);
  DDX_Control(pDX, IDC_SPDTEXT1, m_SpdText1);
  DDX_Control(pDX, IDC_AGITEXT2, m_AgiText2);
  DDX_Control(pDX, IDC_AGITEXT1, m_AgiText1);
  DDX_Control(pDX, IDC_WILTEXT2, m_WilText2);
  DDX_Control(pDX, IDC_WILTEXT1, m_WilText1);
  DDX_Control(pDX, IDC_INTTEXT2, m_IntText2);
  DDX_Control(pDX, IDC_INTTEXT1, m_IntText1);
  DDX_Control(pDX, IDC_STRTEXT2, m_StrText2);
  DDX_Control(pDX, IDC_STRTEXT1, m_StrText1);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmRaceDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRaceDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmRaceDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmRaceDlg::GetControlData()");
  CEsmSubName32* pSpellRec;
  esmrecinfo_t*  pRecInfo;
  racedata_t*	 pRaceData;
  CString	 Buffer;  
  int		 Index;
  
	/* Update the armor pointer and data */
  m_pRace = (CEsmRace *) GetRecInfo()->pRecord;
  ASSERT(m_pRace != NULL);
  pRaceData = m_pRace->GetRaceData();
  if (pRaceData == NULL) return;
  
	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pRace->SetID(TrimStringSpace(Buffer));
   }

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pRace->SetName(TrimStringSpace(Buffer));
	
	/* Item description */
  m_DescText.GetWindowText(Buffer);
  m_pRace->SetDescription(TrimStringSpace(Buffer));

	/* Skill lists */
  GETLISTDATA(m_SkillList1, pRaceData->SkillBonuses[0].SkillID);
  GETLISTDATA(m_SkillList2, pRaceData->SkillBonuses[1].SkillID);
  GETLISTDATA(m_SkillList3, pRaceData->SkillBonuses[2].SkillID);
  GETLISTDATA(m_SkillList4, pRaceData->SkillBonuses[3].SkillID);
  GETLISTDATA(m_SkillList5, pRaceData->SkillBonuses[4].SkillID);
  GETLISTDATA(m_SkillList6, pRaceData->SkillBonuses[5].SkillID);
  GETLISTDATA(m_SkillList7, pRaceData->SkillBonuses[6].SkillID);
  m_BonusText1.GetWindowText(Buffer);
  pRaceData->SkillBonuses[0].Bonus = atoi(Buffer);
  m_BonusText2.GetWindowText(Buffer);
  pRaceData->SkillBonuses[1].Bonus = atoi(Buffer);
  m_BonusText3.GetWindowText(Buffer);
  pRaceData->SkillBonuses[2].Bonus = atoi(Buffer);
  m_BonusText4.GetWindowText(Buffer);
  pRaceData->SkillBonuses[3].Bonus = atoi(Buffer);
  m_BonusText5.GetWindowText(Buffer);
  pRaceData->SkillBonuses[4].Bonus = atoi(Buffer);
  m_BonusText6.GetWindowText(Buffer);
  pRaceData->SkillBonuses[5].Bonus = atoi(Buffer);
  m_BonusText7.GetWindowText(Buffer);
  pRaceData->SkillBonuses[6].Bonus = atoi(Buffer);
 
 	/* Attributes */
  m_StrText1.GetWindowText(Buffer);
  pRaceData->Strength[0] = atoi(Buffer);
  m_StrText2.GetWindowText(Buffer);
  pRaceData->Strength[1] = atoi(Buffer);
  m_IntText1.GetWindowText(Buffer);
  pRaceData->Intelligence[0] = atoi(Buffer);
  m_IntText2.GetWindowText(Buffer);
  pRaceData->Intelligence[1] = atoi(Buffer);
  m_WilText1.GetWindowText(Buffer);
  pRaceData->Willpower[0] = atoi(Buffer);
  m_WilText2.GetWindowText(Buffer);
  pRaceData->Willpower[1] = atoi(Buffer);
  m_AgiText1.GetWindowText(Buffer);
  pRaceData->Agility[0] = atoi(Buffer);
  m_AgiText2.GetWindowText(Buffer);
  pRaceData->Agility[1] = atoi(Buffer);
  m_SpdText1.GetWindowText(Buffer);
  pRaceData->Speed[0] = atoi(Buffer);
  m_SpdText2.GetWindowText(Buffer);
  pRaceData->Speed[1] = atoi(Buffer);
  m_EndText1.GetWindowText(Buffer);
  pRaceData->Endurance[0] = atoi(Buffer);
  m_EndText2.GetWindowText(Buffer);
  pRaceData->Endurance[1] = atoi(Buffer);
  m_PerText1.GetWindowText(Buffer);
  pRaceData->Personality[0] = atoi(Buffer);
  m_PerText2.GetWindowText(Buffer);
  pRaceData->Personality[1] = atoi(Buffer);
  m_LucText1.GetWindowText(Buffer);
  pRaceData->Luck[0] = atoi(Buffer);
  m_LucText2.GetWindowText(Buffer);
  pRaceData->Luck[1] = atoi(Buffer);
  
	/* Weight and height */
  m_WeightText1.GetWindowText(Buffer);
  pRaceData->Weight[0] = (float) atof(Buffer);
  m_WeightText2.GetWindowText(Buffer);
  pRaceData->Weight[1] = (float) atof(Buffer);
  m_HeightText1.GetWindowText(Buffer);
  pRaceData->Height[0] = (float) atof(Buffer);
  m_HeightText2.GetWindowText(Buffer);
  pRaceData->Height[1] = (float) atof(Buffer);

	/* Race Flags */
  pRaceData->Flags = 0;
  if (m_PlayableCheck.GetCheck()) pRaceData->Flags |= MWESM_RACEFLAG_PLAYABLE;
  if (m_BeastCheck.GetCheck())    pRaceData->Flags |= MWESM_RACEFLAG_BEAST;
  
	/* Spells and abilities */
  m_pRace->DeleteSubRecords(MWESM_SUBREC_NPCS);

  for (Index = 0; Index < m_SpellList.GetItemCount(); Index++) {
    pRecInfo = (esmrecinfo_t *) m_SpellList.GetItemData(Index);
    if (pRecInfo == NULL) continue;
    pSpellRec = (CEsmSubName32 *) m_pRace->AllocateSubRecord(MWESM_SUBREC_NPCS);
    pSpellRec->CreateNew();
    pSpellRec->SetName(pRecInfo->pRecord->GetID());
   }

 }
/*===========================================================================
 *		End of Class Method CEsmRaceDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRaceDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmRaceDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_IDText.GetModify())     m_Modified = true;
  if (m_NameText.GetModify())   m_Modified = true;
  if (m_DescText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmRaceDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRaceDlg Event - void OnChangeAttribText ();
 *
 *=========================================================================*/
void CEsmRaceDlg::OnChangeAttribText() {
  UpdateAttribTotals();
 }
/*===========================================================================
 *		End of Class Event CEsmRaceDlg::OnChangeAttribText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRaceDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmRaceDlg::OnInitialUpdate() {
  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pRace = (CEsmRace *) GetRecInfo()->pRecord;

	/* Initialize the lists */
  FillEsmSkillsCombo(m_SkillList1, true);
  FillEsmSkillsCombo(m_SkillList2, true);
  FillEsmSkillsCombo(m_SkillList3, true);
  FillEsmSkillsCombo(m_SkillList4, true);
  FillEsmSkillsCombo(m_SkillList5, true);
  FillEsmSkillsCombo(m_SkillList6, true);
  FillEsmSkillsCombo(m_SkillList7, true);

	/* Spell List */
  m_SpellList.OnInitCtrl();
  m_SpellList.SetDlgHandler(m_pParent);
  m_SpellList.SetEnableDrag(true);
  m_SpellList.SetAcceptDrag(true);
  m_SpellList.SetWantKeys(true);
  m_SpellList.InitObjectList(&l_SpellColData[0]);

	/* Initialize the text controls */
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
  m_DescText.SetLimitText(256);
  m_StrText1.SetLimitText(4);
  m_IntText1.SetLimitText(4);
  m_WilText1.SetLimitText(4);
  m_PerText1.SetLimitText(4);
  m_LucText1.SetLimitText(4);
  m_EndText1.SetLimitText(4);
  m_AgiText1.SetLimitText(4);
  m_SpdText1.SetLimitText(4);
  m_WeightText1.SetLimitText(8);
  m_HeightText1.SetLimitText(8);
  m_StrText2.SetLimitText(4);
  m_IntText2.SetLimitText(4);
  m_WilText2.SetLimitText(4);
  m_PerText2.SetLimitText(4);
  m_LucText2.SetLimitText(4);
  m_EndText2.SetLimitText(4);
  m_AgiText2.SetLimitText(4);
  m_SpdText2.SetLimitText(4);
  m_WeightText2.SetLimitText(8);
  m_HeightText2.SetLimitText(8);
  m_BonusText1.SetLimitText(4);
  m_BonusText2.SetLimitText(4);
  m_BonusText3.SetLimitText(4);
  m_BonusText4.SetLimitText(4);
  m_BonusText5.SetLimitText(4);
  m_BonusText6.SetLimitText(4);
  m_BonusText7.SetLimitText(4);

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmRaceDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRaceDlg Event - LRESULT OnRecordDrop (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmRaceDlg::OnRecordDrop (LPARAM lParam, LPARAM wParam) {
  CString	Buffer;
  CMWEditDoc*   pSourceDoc = (CMWEditDoc *) lParam;
  esmrecinfo_t* pRecInfo = (esmrecinfo_t *) wParam;
  int		ListIndex;

	/* Ensure we only drag from the current document */
  if (pSourceDoc != GetDocument()) return (0);
  
	/* Can only drag spells onto the list */
  if (!pRecInfo->pRecord->IsType(MWESM_REC_SPEL)) return (0);
  ListIndex = m_SpellList.FindRecord(pRecInfo);

	/* Add a new item to the container */
  if (ListIndex < 0) {
    ListIndex = m_SpellList.AddItem(pRecInfo);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmRaceDlg::OnRecordDrop()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRaceDlg Event - LRESULT OnRecordKey (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmRaceDlg::OnRecordKey (LPARAM lParam, LPARAM wParam) {
  int		ListIndex;
  
	/* Delete all currently selected items */  
  if (lParam == VK_DELETE || lParam == VK_BACK) {
    ListIndex = m_SpellList.GetNextItem(-1, LVNI_SELECTED);

    while (ListIndex >= 0) {
      m_SpellList.DeleteItem(ListIndex);
      ListIndex = m_SpellList.GetNextItem(-1, LVNI_SELECTED);
     }
  
    return (1);
   }


  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmRaceDlg::OnRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRaceDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmRaceDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {

  	/* Refill the script list if required */
  if (pRecInfo->pRecord->IsType(MWESM_REC_SPEL)) {
    m_SpellList.UpdateItem(pRecInfo);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmRaceDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRaceDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmRaceDlg::SetControlData (void) {
  CEsmSubName32* pSpellRec;
  esmrecinfo_t*  pRecInfo;
  CString	 Buffer;
  racedata_t*	 pRaceData;
  int		 Index;

	/* Ignore if the current item is not valid */
  if (m_pRace == NULL) return;
  pRaceData = m_pRace->GetRaceData();
  if (pRaceData == NULL) return;

	/* Item ID, update title as well */
  m_IDText.SetWindowText(m_pRace->GetID());
  UpdateTitle(m_pRace->GetID());
  m_IDText.SetModify(FALSE);

	/* Item name */
  m_NameText.SetWindowText(m_pRace->GetName());
  m_NameText.SetModify(FALSE);
	
	/* Item description */
  m_DescText.SetWindowText(m_pRace->GetDescription());
  m_DescText.SetModify(FALSE);

	/* Skill lists */
  FindComboListItem(m_SkillList1, pRaceData->SkillBonuses[0].SkillID, true);
  FindComboListItem(m_SkillList2, pRaceData->SkillBonuses[1].SkillID, true);
  FindComboListItem(m_SkillList3, pRaceData->SkillBonuses[2].SkillID, true);
  FindComboListItem(m_SkillList4, pRaceData->SkillBonuses[3].SkillID, true);
  FindComboListItem(m_SkillList5, pRaceData->SkillBonuses[4].SkillID, true);
  FindComboListItem(m_SkillList6, pRaceData->SkillBonuses[5].SkillID, true);
  FindComboListItem(m_SkillList7, pRaceData->SkillBonuses[6].SkillID, true);
  m_BonusText1.EnableWindow(pRaceData->SkillBonuses[0].SkillID != -1);
  m_BonusText2.EnableWindow(pRaceData->SkillBonuses[1].SkillID != -1);
  m_BonusText3.EnableWindow(pRaceData->SkillBonuses[2].SkillID != -1);
  m_BonusText4.EnableWindow(pRaceData->SkillBonuses[3].SkillID != -1);
  m_BonusText5.EnableWindow(pRaceData->SkillBonuses[4].SkillID != -1);
  m_BonusText6.EnableWindow(pRaceData->SkillBonuses[5].SkillID != -1);
  m_BonusText7.EnableWindow(pRaceData->SkillBonuses[6].SkillID != -1);

  if (pRaceData->SkillBonuses[0].SkillID != -1) {
    Buffer.Format(_T("%d"), pRaceData->SkillBonuses[0].Bonus);
    m_BonusText1.SetWindowText(Buffer);
   }

  if (pRaceData->SkillBonuses[1].SkillID != -1) {
    Buffer.Format(_T("%d"), pRaceData->SkillBonuses[1].Bonus);
    m_BonusText2.SetWindowText(Buffer);
   }

  if (pRaceData->SkillBonuses[2].SkillID != -1) {
    Buffer.Format(_T("%d"), pRaceData->SkillBonuses[2].Bonus);
    m_BonusText3.SetWindowText(Buffer);
   }

  if (pRaceData->SkillBonuses[3].SkillID != -1) {
    Buffer.Format(_T("%d"), pRaceData->SkillBonuses[3].Bonus);
    m_BonusText4.SetWindowText(Buffer);
   }

  if (pRaceData->SkillBonuses[4].SkillID != -1) {
    Buffer.Format(_T("%d"), pRaceData->SkillBonuses[4].Bonus);
    m_BonusText5.SetWindowText(Buffer);
   }

  if (pRaceData->SkillBonuses[5].SkillID != -1) {
    Buffer.Format(_T("%d"), pRaceData->SkillBonuses[5].Bonus);
    m_BonusText6.SetWindowText(Buffer);
   }

  if (pRaceData->SkillBonuses[6].SkillID != -1) {
    Buffer.Format(_T("%d"), pRaceData->SkillBonuses[6].Bonus);
    m_BonusText7.SetWindowText(Buffer);
   }

	/* Attributes */
  Buffer.Format(_T("%d"), pRaceData->Strength[0]);
  m_StrText1.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pRaceData->Strength[1]);
  m_StrText2.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pRaceData->Intelligence[0]);
  m_IntText1.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pRaceData->Intelligence[1]);
  m_IntText2.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pRaceData->Willpower[0]);
  m_WilText1.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pRaceData->Willpower[1]);
  m_WilText2.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pRaceData->Agility[0]);
  m_AgiText1.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pRaceData->Agility[1]);
  m_AgiText2.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pRaceData->Speed[0]);
  m_SpdText1.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pRaceData->Speed[1]);
  m_SpdText2.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pRaceData->Endurance[0]);
  m_EndText1.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pRaceData->Endurance[1]);
  m_EndText2.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pRaceData->Personality[0]);
  m_PerText1.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pRaceData->Personality[1]);
  m_PerText2.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pRaceData->Luck[0]);
  m_LucText1.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), pRaceData->Luck[1]);
  m_LucText2.SetWindowText(Buffer);
  
	/* Weight and height */
  Buffer.Format(_T("%.2f"), pRaceData->Weight[0]);
  m_WeightText1.SetWindowText(Buffer);
  Buffer.Format(_T("%.2f"), pRaceData->Weight[1]);
  m_WeightText2.SetWindowText(Buffer);
  Buffer.Format(_T("%.2f"), pRaceData->Height[0]);
  m_HeightText1.SetWindowText(Buffer);
  Buffer.Format(_T("%.2f"), pRaceData->Height[1]);
  m_HeightText2.SetWindowText(Buffer);

	/* Race Flags */
  m_PlayableCheck.SetCheck(m_pRace->IsPlayable());
  m_BeastCheck.SetCheck(m_pRace->IsBeastRace());

	/* Spells and abilities */
  pSpellRec = (CEsmSubName32 *) m_pRace->FindFirst(MWESM_SUBREC_NPCS, Index);

  while (pSpellRec != NULL) {
    pRecInfo = GetDocument()->FindRecord(pSpellRec->GetName());
    if (pRecInfo != NULL) m_SpellList.AddItem(pRecInfo);
    pSpellRec =  (CEsmSubName32 *) m_pRace->FindNext(MWESM_SUBREC_NPCS, Index);
   }
  
  UpdateAttribTotals();
 }
/*===========================================================================
 *		End of Class Method CEsmRaceDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRaceDlg Method - void UpdateAttribTotals (void);
 *
 *=========================================================================*/
void CEsmRaceDlg::UpdateAttribTotals (void) {
  CString Buffer;
  int	  MaleTotal   = 0;
  int	  FemaleTotal = 0;

  m_StrText1.GetWindowText(Buffer);
  MaleTotal += atoi(Buffer);
  m_IntText1.GetWindowText(Buffer);
  MaleTotal += atoi(Buffer);
  m_WilText1.GetWindowText(Buffer);
  MaleTotal += atoi(Buffer);
  m_AgiText1.GetWindowText(Buffer);
  MaleTotal += atoi(Buffer);
  m_SpdText1.GetWindowText(Buffer);
  MaleTotal += atoi(Buffer);
  m_EndText1.GetWindowText(Buffer);
  MaleTotal += atoi(Buffer);
  m_PerText1.GetWindowText(Buffer);
  MaleTotal += atoi(Buffer);
  m_LucText1.GetWindowText(Buffer);
  MaleTotal += atoi(Buffer);

  m_StrText2.GetWindowText(Buffer);
  FemaleTotal += atoi(Buffer);
  m_IntText2.GetWindowText(Buffer);
  FemaleTotal += atoi(Buffer);
  m_WilText2.GetWindowText(Buffer);
  FemaleTotal += atoi(Buffer);
  m_AgiText2.GetWindowText(Buffer);
  FemaleTotal += atoi(Buffer);
  m_SpdText2.GetWindowText(Buffer);
  FemaleTotal += atoi(Buffer);
  m_EndText2.GetWindowText(Buffer);
  FemaleTotal += atoi(Buffer);
  m_PerText2.GetWindowText(Buffer);
  FemaleTotal += atoi(Buffer);
  m_LucText2.GetWindowText(Buffer);
  FemaleTotal += atoi(Buffer);

  Buffer.Format(_T("%d"), MaleTotal);
  m_MaleTotal.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), FemaleTotal);
  m_FemaleTotal.SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmRaceDlg::UpdateAttribTotals()
 *=========================================================================*/



/*===========================================================================
 *
 * Begin Skill List Sel Change Events
 *
 *=========================================================================*/
void CEsmRaceDlg::OnSelchangeSkilllist1() {
  int Index;

  Index = m_SkillList1.GetCurSel();

  if (Index < 0 || (int)m_SkillList1.GetItemData(Index) < 0) {
    m_BonusText1.EnableWindow(FALSE);
    m_BonusText1.SetWindowText(_T(""));
   }
  else
    m_BonusText1.EnableWindow(TRUE);
 }

void CEsmRaceDlg::OnSelchangeSkilllist2() {
  int Index;

  Index = m_SkillList2.GetCurSel();

  if (Index < 0 || (int)m_SkillList2.GetItemData(Index) < 0) {
    m_BonusText2.EnableWindow(FALSE);
    m_BonusText2.SetWindowText(_T(""));
   }
  else
    m_BonusText2.EnableWindow(TRUE);
 }

void CEsmRaceDlg::OnSelchangeSkilllist3() {
  int Index;

  Index = m_SkillList3.GetCurSel();

  if (Index < 0 || (int)m_SkillList3.GetItemData(Index) < 0) {
    m_BonusText3.EnableWindow(FALSE);
    m_BonusText3.SetWindowText(_T(""));
   }
  else
    m_BonusText3.EnableWindow(TRUE);
 }

void CEsmRaceDlg::OnSelchangeSkilllist4() {
  int Index;

  Index = m_SkillList4.GetCurSel();

  if (Index < 0 || (int)m_SkillList4.GetItemData(Index) < 0) {
    m_BonusText4.EnableWindow(FALSE);
    m_BonusText4.SetWindowText(_T(""));
   }
  else
    m_BonusText4.EnableWindow(TRUE);
 }

void CEsmRaceDlg::OnSelchangeSkilllist5() {
  int Index;

  Index = m_SkillList5.GetCurSel();

  if (Index < 0 || (int)m_SkillList5.GetItemData(Index) < 0) {
    m_BonusText5.EnableWindow(FALSE);
    m_BonusText5.SetWindowText(_T(""));
   }
  else
    m_BonusText5.EnableWindow(TRUE);
 }

void CEsmRaceDlg::OnSelchangeSkilllist6() {
  int Index;

  Index = m_SkillList6.GetCurSel();

  if (Index < 0 || (int)m_SkillList6.GetItemData(Index) < 0) {
    m_BonusText6.EnableWindow(FALSE);
    m_BonusText6.SetWindowText(_T(""));
   }
  else
    m_BonusText6.EnableWindow(TRUE);
 }

void CEsmRaceDlg::OnSelchangeSkilllist7() {
  int Index;

  Index = m_SkillList7.GetCurSel();

  if (Index < 0 || (int)m_SkillList7.GetItemData(Index) < 0) {
    m_BonusText7.EnableWindow(FALSE);
    m_BonusText7.SetWindowText(_T(""));
   }
  else
    m_BonusText7.EnableWindow(TRUE);
 }
/*===========================================================================
 *		End of Skill List Sel Change Events
 *=========================================================================*/

