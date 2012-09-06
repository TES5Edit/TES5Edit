/*===========================================================================
 *
 * File:	Esmfactiondlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 18, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmFactionDlg.h"


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

  DEFINE_FILE("EsmFactionDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmFactionDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmFactionDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmFactionDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmFactionDlg)
  ON_NOTIFY(LVN_ITEMCHANGING, IDC_RANKLIST, OnItemchangingRanklist)
  ON_NOTIFY(LVN_ITEMCHANGING, IDC_REACTIONLIST, OnItemchangingReactionlist)
  ON_BN_CLICKED(IDC_NEWREACTION, OnNewreaction)
  ON_BN_CLICKED(IDC_DELREACTION, OnDelreaction)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmFactionDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFactionDlg Constructor
 *
 *=========================================================================*/
CEsmFactionDlg::CEsmFactionDlg() : CEsmRecDialog(CEsmFactionDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmFactionDlg)
  //}}AFX_DATA_INIT
  m_pFaction = NULL;
  m_CurrentRank = -1;
  m_CurrentReaction = -1;
 }
/*===========================================================================
 *		End of Class CEsmFactionDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFactionDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmFactionDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmFactionDlg)
  DDX_Control(pDX, IDC_ADJUSTTEXT, m_AdjustText);
  DDX_Control(pDX, IDC_FACTREPTEXT, m_FactRepText);
  DDX_Control(pDX, IDC_FACTIONLIST, m_FactionList);
  DDX_Control(pDX, IDC_REACTIONLIST, m_ReactionList);
  DDX_Control(pDX, IDC_SKILLTEXT2, m_SkillText2);
  DDX_Control(pDX, IDC_SKILLTEXT1, m_SkillText1);
  DDX_Control(pDX, IDC_ATTRIBTEXT2, m_AttributeText2);
  DDX_Control(pDX, IDC_ATTRIBTEXT1, m_AttributeText1);
  DDX_Control(pDX, IDC_RANKTEXT, m_RankNameText);
  DDX_Control(pDX, IDC_ATTRIBUTELIST2, m_AttributeList2);
  DDX_Control(pDX, IDC_ATTRIBUTELIST1, m_AttributeList1);
  DDX_Control(pDX, IDC_SKILLLIST6, m_SkillList6);
  DDX_Control(pDX, IDC_SKILLLIST5, m_SkillList5);
  DDX_Control(pDX, IDC_SKILLLIST4, m_SkillList4);
  DDX_Control(pDX, IDC_SKILLLIST3, m_SkillList3);
  DDX_Control(pDX, IDC_SKILLLIST2, m_SkillList2);
  DDX_Control(pDX, IDC_SKILLLIST1, m_SkillList1);
  DDX_Control(pDX, IDC_RANKLIST, m_RankList);
  DDX_Control(pDX, IDC_HIDDENCHECK, m_HiddenCheck);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmFactionDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFactionDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmFactionDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmFactionDlg::GetControlData()");
  factiondata_t*	pFactionData;
  CEsmSubLong*		pSubLong;
  CEsmSubNameFix*	pSubName;
  CString		Buffer;  
  int			Index;
  
	/* Update the armor pointer and data */
  m_pFaction = (CEsmFaction *) GetRecInfo()->pRecord;
  ASSERT(m_pFaction != NULL);
  pFactionData = m_pFaction->GetFactionData();
  if (pFactionData == NULL) return;
  
	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pFaction->SetID(TrimStringSpace(Buffer));
   }

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pFaction->SetName(TrimStringSpace(Buffer));

  	/* Attribute lists */
  GETLISTDATA(m_AttributeList1, pFactionData->AttributeID1);
  GETLISTDATA(m_AttributeList2, pFactionData->AttributeID2);

	/* Skill lists */
  GETLISTDATA(m_SkillList1, pFactionData->SkillID1);
  GETLISTDATA(m_SkillList2, pFactionData->SkillID2);
  GETLISTDATA(m_SkillList3, pFactionData->SkillID3);
  GETLISTDATA(m_SkillList4, pFactionData->SkillID4);
  GETLISTDATA(m_SkillList5, pFactionData->SkillID5);
  GETLISTDATA(m_SkillList6, pFactionData->SkillID6);
  
	/* Flags */
  pFactionData->Flags = 0;
  if (m_HiddenCheck.GetCheck()) pFactionData->Flags = MWESM_FACTFLAG_HIDDEN;

	/* Update and store the rank data */
  GetRankData();
	
  for (Index = 0; Index < MWESM_FACTION_NUMRANKS; Index++) {
    Buffer = m_RankList.GetItemText(Index, MWESM_RANKLIST_NAME);
    m_pFaction->SetRankName(Index, Buffer);
    Buffer = m_RankList.GetItemText(Index, MWESM_RANKLIST_ATTRIB1);
    pFactionData->RankData[Index].Attribute1 = atoi(Buffer);
    Buffer = m_RankList.GetItemText(Index, MWESM_RANKLIST_ATTRIB2);
    pFactionData->RankData[Index].Attribute2 = atoi(Buffer);
    Buffer = m_RankList.GetItemText(Index, MWESM_RANKLIST_SKILL1);
    pFactionData->RankData[Index].Skill1 = atoi(Buffer);
    Buffer = m_RankList.GetItemText(Index, MWESM_RANKLIST_SKILL2);
    pFactionData->RankData[Index].Skill2 = atoi(Buffer);
    Buffer = m_RankList.GetItemText(Index, MWESM_RANKLIST_FACTREP);
    pFactionData->RankData[Index].Faction = atoi(Buffer);
   }

	/* Update and store the reaction list data */
  GetReactionData();
  m_pFaction->DeleteSubRecords(MWESM_SUBREC_ANAM);
  m_pFaction->DeleteSubRecords(MWESM_SUBREC_INTV);

  for (Index = 0; Index < m_ReactionList.GetItemCount(); Index++) {
    pSubName = (CEsmSubNameFix *) m_pFaction->AllocateSubRecord(MWESM_SUBREC_ANAM);
    pSubName->CreateNew();
    pSubLong = (CEsmSubLong    *) m_pFaction->AllocateSubRecord(MWESM_SUBREC_INTV);
    pSubLong->CreateNew();

    Buffer = m_ReactionList.GetItemText(Index, MWESM_REACLIST_NAME);
    pSubName->SetName(Buffer);
    Buffer = m_ReactionList.GetItemText(Index, MWESM_REACLIST_VALUE);
    pSubLong->SetValue(atoi(Buffer));
   }

 }
/*===========================================================================
 *		End of Class Method CEsmFactionDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFactionDlg Method - void GetRankData (void);
 *
 *=========================================================================*/
void CEsmFactionDlg::GetRankData (void) {
  CString Buffer;

  if (m_CurrentRank < 0) return;

  m_RankNameText.GetWindowText(Buffer);
  m_RankList.SetItemText(m_CurrentRank, MWESM_RANKLIST_NAME, TrimStringSpace(Buffer));
  
  m_AttributeText1.GetWindowText(Buffer);
  m_RankList.SetItemText(m_CurrentRank, MWESM_RANKLIST_ATTRIB1, Buffer);
  
  m_AttributeText2.GetWindowText(Buffer);
  m_RankList.SetItemText(m_CurrentRank, MWESM_RANKLIST_ATTRIB2, Buffer);
  
  m_SkillText1.GetWindowText(Buffer);
  m_RankList.SetItemText(m_CurrentRank, MWESM_RANKLIST_SKILL1, Buffer);
  
  m_SkillText2.GetWindowText(Buffer);
  m_RankList.SetItemText(m_CurrentRank, MWESM_RANKLIST_SKILL2, Buffer);
  
  m_FactRepText.GetWindowText(Buffer);
  m_RankList.SetItemText(m_CurrentRank, MWESM_RANKLIST_FACTREP, Buffer);

 }
/*===========================================================================
 *		End of Class Method CEsmFactionDlg::GetRankData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFactionDlg Method - void GetReactionData (void);
 *
 *=========================================================================*/
void CEsmFactionDlg::GetReactionData (void) {
  CString Buffer;

  if (m_CurrentReaction < 0) return;

  m_FactionList.GetWindowText(Buffer);
  m_ReactionList.SetItemText(m_CurrentReaction, MWESM_REACLIST_NAME, Buffer);

  m_AdjustText.GetWindowText(Buffer);
  m_ReactionList.SetItemText(m_CurrentReaction, MWESM_REACLIST_VALUE, TrimStringSpace(Buffer));
 }
/*===========================================================================
 *		End of Class Method CEsmFactionDlg::GetReactionData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFactionDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmFactionDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_IDText.GetModify())     m_Modified = true;
  if (m_NameText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmFactionDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFactionDlg Event - void OnDelreaction ();
 *
 *=========================================================================*/
void CEsmFactionDlg::OnDelreaction() {
  POSITION SelPos;
  int      ListIndex;

  SelPos = m_ReactionList.GetFirstSelectedItemPosition();
  if (SelPos == NULL) return;
  ListIndex = m_ReactionList.GetNextSelectedItem(SelPos);
  m_ReactionList.DeleteItem(ListIndex);

  if (m_ReactionList.GetItemCount() == 0) {
    m_AdjustText.EnableWindow(FALSE);
    m_FactionList.EnableWindow(FALSE);
    m_AdjustText.SetWindowText(_T(""));
    m_FactionList.SetCurSel(-1);
   }
  else 
    m_ReactionList.SetItemState(0, LVIS_SELECTED,  LVIS_SELECTED );

 }
/*===========================================================================
 *		End of Class Event CEsmFactionDlg::OnDelreaction()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFactionDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmFactionDlg::OnInitialUpdate() {
  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pFaction = (CEsmFaction *) GetRecInfo()->pRecord;

	/* Initialize the lists */
  FillEsmAttributesCombo(m_AttributeList1);
  FillEsmAttributesCombo(m_AttributeList2);
  FillEsmSkillsCombo(m_SkillList1, true);
  FillEsmSkillsCombo(m_SkillList2, true);
  FillEsmSkillsCombo(m_SkillList3, true);
  FillEsmSkillsCombo(m_SkillList4, true);
  FillEsmSkillsCombo(m_SkillList5, true);
  FillEsmSkillsCombo(m_SkillList6, true);
  FillEsmFactionCombo(m_FactionList);

	/* Rank list */
  m_RankList.InsertColumn(MWESM_RANKLIST_INDEX,	  _T("#"),	   LVCFMT_CENTER, 40,  MWESM_RANKLIST_INDEX);
  m_RankList.InsertColumn(MWESM_RANKLIST_NAME,	  _T("Rank Name"), LVCFMT_LEFT,   100, MWESM_RANKLIST_NAME);
  m_RankList.InsertColumn(MWESM_RANKLIST_ATTRIB1, _T("Attrib 1"),  LVCFMT_CENTER, 60,  MWESM_RANKLIST_ATTRIB1);
  m_RankList.InsertColumn(MWESM_RANKLIST_ATTRIB2, _T("Attrib 2"),  LVCFMT_CENTER, 60,  MWESM_RANKLIST_ATTRIB2);
  m_RankList.InsertColumn(MWESM_RANKLIST_SKILL1,  _T("Skill 1"),   LVCFMT_CENTER, 60,  MWESM_RANKLIST_SKILL1);
  m_RankList.InsertColumn(MWESM_RANKLIST_SKILL2,  _T("Skill 2"),   LVCFMT_CENTER, 60,  MWESM_RANKLIST_SKILL2);
  m_RankList.InsertColumn(MWESM_RANKLIST_FACTREP,  _T("Fact Rep"), LVCFMT_CENTER, 60,  MWESM_RANKLIST_FACTREP);
  m_RankList.SetExtendedStyle(LVS_EX_FULLROWSELECT | LVS_EX_GRIDLINES);

	/* Faction reaction list */
  m_ReactionList.InsertColumn(MWESM_REACLIST_NAME,  _T("Faction"),  LVCFMT_LEFT,   140,  MWESM_REACLIST_NAME);
  m_ReactionList.InsertColumn(MWESM_REACLIST_VALUE, _T("Reaction"), LVCFMT_CENTER,  80,  MWESM_REACLIST_VALUE);
  m_ReactionList.SetExtendedStyle(LVS_EX_FULLROWSELECT | LVS_EX_GRIDLINES);

	/* Initialize the text controls */
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
  m_AttributeText1.SetLimitText(8);
  m_AttributeText2.SetLimitText(8);
  m_SkillText1.SetLimitText(8);
  m_SkillText2.SetLimitText(8);
  m_AdjustText.SetLimitText(8);

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmFactionDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFactionDlg Event - void OnItemchangingRanklist (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmFactionDlg::OnItemchangingRanklist(NMHDR* pNMHDR, LRESULT* pResult) {
  NM_LISTVIEW* pNMListView = (NM_LISTVIEW*)pNMHDR;
  *pResult = 0;

	/* Ignore if the item selection state hasn't changed */
  if ((pNMListView->uChanged & LVIF_STATE ) == 0) return;
  if ((pNMListView->uNewState & LVIS_SELECTED) == (pNMListView->uOldState & LVIS_SELECTED)) return;

	/* Loss of selection, save the list text */
  if ((pNMListView->uNewState & LVIS_SELECTED) != 0) {
    GetRankData();
    SetRankData(pNMListView->iItem);
   }

 }
/*===========================================================================
 *		End of Class Event CEsmFactionDlg::OnItemchangingRanklist()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFactionDlg Event - void OnItemchangingReactionlist (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmFactionDlg::OnItemchangingReactionlist(NMHDR* pNMHDR, LRESULT* pResult) {
  NM_LISTVIEW* pNMListView = (NM_LISTVIEW*)pNMHDR;
  *pResult = 0;

  	/* Ignore if the item selection state hasn't changed */
  if ((pNMListView->uChanged & LVIF_STATE ) == 0) return;
  if ((pNMListView->uNewState & LVIS_SELECTED) == (pNMListView->uOldState & LVIS_SELECTED)) return;

	/* Loss of selection, save the list text */
  if ((pNMListView->uNewState & LVIS_SELECTED) != 0) {
    GetReactionData();
    SetReactionData(pNMListView->iItem);
   }

 }
/*===========================================================================
 *		End of Class Event CEsmFactionDlg::OnItemchangingReactionlist()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFactionDlg Event - void OnNewreaction ();
 *
 *=========================================================================*/
void CEsmFactionDlg::OnNewreaction() {
  m_AdjustText.EnableWindow(TRUE);
  m_FactionList.EnableWindow(TRUE);

  GetReactionData();
  m_ReactionList.InsertItem(0, _T(""), -1);
  m_ReactionList.SetItemState(0, LVIS_SELECTED,  LVIS_SELECTED );
 }
/*===========================================================================
 *		End of Class Event CEsmFactionDlg::OnNewreaction()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFactionDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmFactionDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {

  	/* Refill the faction list */
  if (pRecInfo->pRecord->IsType(MWESM_REC_FACT)) {
    esmrecinfo_t* pRecInfo = NULL;
    int	  	  Index;

    Index = m_FactionList.GetCurSel();
    if (Index >= 0) pRecInfo = (esmrecinfo_t *) m_FactionList.GetItemData(Index);
    FillEsmFactionCombo(m_FactionList);
    FindComboListItem(m_FactionList, (DWORD) pRecInfo, true);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmFactionDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFactionDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmFactionDlg::SetControlData (void) {
  factiondata_t*  pFactionData;
  CEsmSubNameFix* pSubName;
  CEsmSubRecord*  pSubLong;
  CString	  Buffer;
  int		  Index;

	/* Ignore if the current item is not valid */
  if (m_pFaction == NULL) return;
  pFactionData = m_pFaction->GetFactionData();
  if (pFactionData == NULL) return;

	/* Item ID, update title as well */
  m_IDText.SetWindowText(m_pFaction->GetID());
  UpdateTitle(m_pFaction->GetID());
  m_IDText.SetModify(FALSE);

	/* Item name */
  m_NameText.SetWindowText(m_pFaction->GetName());
  m_NameText.SetModify(FALSE);

	/* Attribute lists */
  FindComboListItem(m_AttributeList1, pFactionData->AttributeID1, true);
  FindComboListItem(m_AttributeList2, pFactionData->AttributeID2, true);

	/* Skill lists */
  FindComboListItem(m_SkillList1, pFactionData->SkillID1, true);
  FindComboListItem(m_SkillList2, pFactionData->SkillID2, true);
  FindComboListItem(m_SkillList3, pFactionData->SkillID3, true);
  FindComboListItem(m_SkillList4, pFactionData->SkillID4, true);
  FindComboListItem(m_SkillList5, pFactionData->SkillID5, true);
  FindComboListItem(m_SkillList6, pFactionData->SkillID6, true);
  
	/* Flags */
  m_HiddenCheck.SetCheck(m_pFaction->IsHidden());
  
	/* Rank table list */
  m_RankList.DeleteAllItems();

  for (Index = 0; Index < MWESM_FACTION_NUMRANKS; Index++) {
    m_RankList.InsertItem(Index, _T(""), -1);
    Buffer.Format(_T("%d"), Index + 1);
    m_RankList.SetItemText(Index, MWESM_RANKLIST_INDEX, Buffer);
    m_RankList.SetItemText(Index, MWESM_RANKLIST_NAME,  m_pFaction->GetRankName(Index));
    Buffer.Format(_T("%d"), pFactionData->RankData[Index].Attribute1);
    m_RankList.SetItemText(Index, MWESM_RANKLIST_ATTRIB1, Buffer);
    Buffer.Format(_T("%d"), pFactionData->RankData[Index].Attribute2);
    m_RankList.SetItemText(Index, MWESM_RANKLIST_ATTRIB2, Buffer);
    Buffer.Format(_T("%d"), pFactionData->RankData[Index].Skill1);
    m_RankList.SetItemText(Index, MWESM_RANKLIST_SKILL1, Buffer);
    Buffer.Format(_T("%d"), pFactionData->RankData[Index].Skill2);
    m_RankList.SetItemText(Index, MWESM_RANKLIST_SKILL2, Buffer);
    Buffer.Format(_T("%d"), pFactionData->RankData[Index].Faction);
    m_RankList.SetItemText(Index, MWESM_RANKLIST_FACTREP, Buffer);
   }

	/* Reaction list */
  pSubName = (CEsmSubNameFix *) m_pFaction->FindFirst(MWESM_SUBREC_ANAM, Index);

  while (pSubName != NULL) {
    pSubLong = m_pFaction->GetSubRecord(Index + 1);

    if (pSubLong != NULL && pSubLong->IsType(MWESM_SUBREC_INTV)) {
      m_ReactionList.InsertItem(0, _T(""), -1);
      m_ReactionList.SetItemText(0, MWESM_REACLIST_NAME, pSubName->GetName());
      Buffer.Format(_T("%d"), (int)((CEsmSubLong*)pSubLong)->GetValue());
      m_ReactionList.SetItemText(0, MWESM_REACLIST_VALUE, Buffer);
     }

    pSubName = (CEsmSubNameFix *) m_pFaction->FindNext(MWESM_SUBREC_ANAM, Index);
   }  
	
  m_RankList.SetItemState(0, LVIS_SELECTED,  LVIS_SELECTED );
  m_ReactionList.SetItemState(0, LVIS_SELECTED,  LVIS_SELECTED );

  if (m_ReactionList.GetItemCount() == 0) {
    m_AdjustText.EnableWindow(FALSE);
    m_FactionList.EnableWindow(FALSE);
   }
 }
/*===========================================================================
 *		End of Class Method CEsmFactionDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFactionDlg Method - void SetRankData (Rank);
 *
 *=========================================================================*/
void CEsmFactionDlg::SetRankData (const int Rank) {
  CString Buffer;

  Buffer = m_RankList.GetItemText(Rank, MWESM_RANKLIST_NAME);
  m_RankNameText.SetWindowText(Buffer);
  Buffer = m_RankList.GetItemText(Rank, MWESM_RANKLIST_ATTRIB1);
  m_AttributeText1.SetWindowText(Buffer);
  Buffer = m_RankList.GetItemText(Rank, MWESM_RANKLIST_ATTRIB2);
  m_AttributeText2.SetWindowText(Buffer);
  Buffer = m_RankList.GetItemText(Rank, MWESM_RANKLIST_SKILL1);
  m_SkillText1.SetWindowText(Buffer);
  Buffer = m_RankList.GetItemText(Rank, MWESM_RANKLIST_SKILL2);
  m_SkillText2.SetWindowText(Buffer);
  Buffer = m_RankList.GetItemText(Rank, MWESM_RANKLIST_FACTREP);
  m_FactRepText.SetWindowText(Buffer);

  m_CurrentRank = Rank;
 }
/*===========================================================================
 *		End of Class Method CEsmFactionDlg::SetRankData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFactionDlg Method - void SetReactionData (Rank);
 *
 *=========================================================================*/
void CEsmFactionDlg::SetReactionData (const int Reaction) {
  CString Buffer;

  Buffer = m_ReactionList.GetItemText(Reaction, MWESM_REACLIST_NAME);
  m_FactionList.SelectString(-1, Buffer);
  Buffer = m_ReactionList.GetItemText(Reaction, MWESM_REACLIST_VALUE);
  m_AdjustText.SetWindowText(Buffer);
  
  m_CurrentReaction = Reaction;
 }
/*===========================================================================
 *		End of Class Method CEsmFactionDlg::SetReactionData()
 *=========================================================================*/

