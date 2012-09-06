/*===========================================================================
 *
 * File:	Esmclassdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 17, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmClassDlg.h"


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

  DEFINE_FILE("EsmClassDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmClassDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmClassDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmClassDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmClassDlg)
  ON_CBN_SELCHANGE(IDC_MAJORLIST1, OnSelchangeMajorlist1)
  ON_CBN_SELCHANGE(IDC_MAJORLIST2, OnSelchangeMajorlist2)
  ON_CBN_SELCHANGE(IDC_MAJORLIST3, OnSelchangeMajorlist3)
  ON_CBN_SELCHANGE(IDC_MAJORLIST4, OnSelchangeMajorlist4)
  ON_CBN_SELCHANGE(IDC_MAJORLIST5, OnSelchangeMajorlist5)
  ON_CBN_SELCHANGE(IDC_MINORLIST1, OnSelchangeMinorlist1)
  ON_CBN_SELCHANGE(IDC_MINORLIST2, OnSelchangeMinorlist2)
  ON_CBN_SELCHANGE(IDC_MINORLIST3, OnSelchangeMinorlist3)
  ON_CBN_SELCHANGE(IDC_MINORLIST4, OnSelchangeMinorlist4)
  ON_CBN_SELCHANGE(IDC_MINORLIST5, OnSelchangeMinorlist5)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmClassDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClassDlg Constructor
 *
 *=========================================================================*/
CEsmClassDlg::CEsmClassDlg() : CEsmRecDialog(CEsmClassDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmClassDlg)
  //}}AFX_DATA_INIT
  m_pClass = NULL;
 }
/*===========================================================================
 *		End of Class CEsmClassDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClassDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmClassDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmClassDlg)
  DDX_Control(pDX, IDC_MINORLIST5, m_MinorList5);
  DDX_Control(pDX, IDC_MINORLIST4, m_MinorList4);
  DDX_Control(pDX, IDC_MINORLIST3, m_MinorList3);
  DDX_Control(pDX, IDC_MINORLIST2, m_MinorList2);
  DDX_Control(pDX, IDC_MINORLIST1, m_MinorList1);
  DDX_Control(pDX, IDC_MAJORLIST5, m_MajorList5);
  DDX_Control(pDX, IDC_MAJORLIST4, m_MajorList4);
  DDX_Control(pDX, IDC_MAJORLIST3, m_MajorList3);
  DDX_Control(pDX, IDC_MAJORLIST2, m_MajorList2);
  DDX_Control(pDX, IDC_MAJORLIST1, m_MajorList1);
  DDX_Control(pDX, IDC_PLAYABLECHECK, m_PlayableCheck);
  DDX_Control(pDX, IDC_REPAIRSCHECK, m_RepairItemsCheck);
  DDX_Control(pDX, IDC_TRAINCHECK, m_TrainCheck);
  DDX_Control(pDX, IDC_SPELLMAKECHECK, m_SpellmakingCheck);
  DDX_Control(pDX, IDC_ENCHANTCHECK, m_EnchantCheck);
  DDX_Control(pDX, IDC_WEAPONCHECK, m_WeaponCheck);
  DDX_Control(pDX, IDC_SPELLCHECK, m_SpellCheck);
  DDX_Control(pDX, IDC_MAGICITEMCHECK, m_MagicItemCheck);
  DDX_Control(pDX, IDC_REPAIRCHECK, m_RepairCheck);
  DDX_Control(pDX, IDC_POTIONCHECK, m_PotionCheck);
  DDX_Control(pDX, IDC_PROBECHECK, m_ProbeCheck);
  DDX_Control(pDX, IDC_MISCCHECK, m_MiscCheck);
  DDX_Control(pDX, IDC_PICKCHECK, m_PickCheck);
  DDX_Control(pDX, IDC_LIGHTCHECK, m_LightCheck);
  DDX_Control(pDX, IDC_INGREDIANTCHECK, m_IngrediantCheck);
  DDX_Control(pDX, IDC_CLOTHINGCHECK, m_ClothingCheck);
  DDX_Control(pDX, IDC_BOOKCHECK, m_BookCheck);
  DDX_Control(pDX, IDC_ARMORCHECK, m_ArmorCheck);
  DDX_Control(pDX, IDC_APPARATUSCHECK, m_ApparatusCheck);
  DDX_Control(pDX, IDC_DESCTEXT, m_DescText);
  DDX_Control(pDX, IDC_MAJORLIST6, m_SpecialList);
  DDX_Control(pDX, IDC_ATTRIBUTELIST2, m_AttributeList2);
  DDX_Control(pDX, IDC_ATTRIBUTELIST1, m_AttributeList1);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmClassDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClassDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmClassDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmClassDlg::GetControlData()");
  classdata_t*	pClassData;
  CString	Buffer;  
  
	/* Update the armor pointer and data */
  m_pClass = (CEsmClass *) GetRecInfo()->pRecord;
  ASSERT(m_pClass != NULL);
  pClassData = m_pClass->GetClassData();
  if (pClassData == NULL) return;
  
	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pClass->SetID(TrimStringSpace(Buffer));
   }

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pClass->SetName(TrimStringSpace(Buffer));
	
	/* Item description */
  m_DescText.GetWindowText(Buffer);
  m_pClass->SetDescription(TrimStringSpace(Buffer));

	/* Attribute lists */
  GETLISTDATA(m_AttributeList1, pClassData->AttributeID1);
  GETLISTDATA(m_AttributeList2, pClassData->AttributeID2);

	/* Skill lists */
  GETLISTDATA(m_MajorList1, pClassData->MajorID1);
  GETLISTDATA(m_MajorList2, pClassData->MajorID2);
  GETLISTDATA(m_MajorList3, pClassData->MajorID3);
  GETLISTDATA(m_MajorList4, pClassData->MajorID4);
  GETLISTDATA(m_MajorList5, pClassData->MajorID5);
  GETLISTDATA(m_MinorList1, pClassData->MinorID1);
  GETLISTDATA(m_MinorList2, pClassData->MinorID2);
  GETLISTDATA(m_MinorList3, pClassData->MinorID3);
  GETLISTDATA(m_MinorList4, pClassData->MinorID4);
  GETLISTDATA(m_MinorList5, pClassData->MinorID5);
  
	/* Specialization list */
  GETLISTDATA(m_SpecialList, pClassData->Specialization);

	/* Checkboxes */
  pClassData->Flags = 0;
  pClassData->AutoCalcFlags = 0;
  if (m_PlayableCheck.GetCheck())	pClassData->Flags |= MWESM_CLASSFLAG_PLAYABLE;
  if (m_WeaponCheck.GetCheck())		pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_WEAPONS;
  if (m_ArmorCheck.GetCheck())		pClassData->AutoCalcFlags |=MWESM_CLASSAUTO_ARMOR;
  if (m_ClothingCheck.GetCheck())	pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_CLOTHING;
  if (m_BookCheck.GetCheck())		pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_BOOKS;
  if (m_IngrediantCheck.GetCheck())	pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_INGREDIANTS;
  if (m_PickCheck.GetCheck())		pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_PICKS;
  if (m_ProbeCheck.GetCheck())		pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_PROBES;
  if (m_LightCheck.GetCheck())		pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_LIGHTS;
  if (m_ApparatusCheck.GetCheck())	pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_APPARATUS;
  if (m_RepairCheck.GetCheck())		pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_REPAIR;
  if (m_MiscCheck.GetCheck())		pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_MISC;
  if (m_SpellCheck.GetCheck())		pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_SPELLS;
  if (m_MagicItemCheck.GetCheck())	pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_MAGICITEMS;
  if (m_PotionCheck.GetCheck())		pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_POTIONS;
  if (m_TrainCheck.GetCheck())		pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_TRAINING;
  if (m_SpellmakingCheck.GetCheck())	pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_SPELLMAKING;
  if (m_EnchantCheck.GetCheck())	pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_ENCHANTING;
  if (m_RepairItemsCheck.GetCheck())	pClassData->AutoCalcFlags |= MWESM_CLASSAUTO_REPAIRITEM;

 }
/*===========================================================================
 *		End of Class Method CEsmClassDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClassDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmClassDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_IDText.GetModify())     m_Modified = true;
  if (m_NameText.GetModify())   m_Modified = true;
  if (m_DescText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmClassDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClassDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmClassDlg::OnInitialUpdate() {
  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pClass = (CEsmClass *) GetRecInfo()->pRecord;

	/* Initialize the lists */
  FillEsmAttributesCombo(m_AttributeList1);
  FillEsmAttributesCombo(m_AttributeList2);
  FillEsmSkillsCombo(m_MajorList1);
  FillEsmSkillsCombo(m_MajorList2);
  FillEsmSkillsCombo(m_MajorList3);
  FillEsmSkillsCombo(m_MajorList4);
  FillEsmSkillsCombo(m_MajorList5);
  FillEsmSkillsCombo(m_MinorList1);
  FillEsmSkillsCombo(m_MinorList2);
  FillEsmSkillsCombo(m_MinorList3);
  FillEsmSkillsCombo(m_MinorList4);
  FillEsmSkillsCombo(m_MinorList5);
  FillEsmClassSpecCombo(m_SpecialList);

	/* Initialize the text controls */
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
  m_DescText.SetLimitText(256);

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmClassDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClassDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmClassDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {

  	/* Refill the script list if required */
  if (pRecInfo->pRecord->IsType(MWESM_REC_SCRI)) {
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmClassDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClassDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmClassDlg::SetControlData (void) {
  classdata_t* pClassData;

	/* Ignore if the current item is not valid */
  if (m_pClass == NULL) return;
  pClassData = m_pClass->GetClassData();
  if (pClassData == NULL) return;

	/* Item ID, update title as well */
  m_IDText.SetWindowText(m_pClass->GetID());
  UpdateTitle(m_pClass->GetID());
  m_IDText.SetModify(FALSE);

	/* Item name */
  m_NameText.SetWindowText(m_pClass->GetName());
  m_NameText.SetModify(FALSE);
	
	/* Item description */
  m_DescText.SetWindowText(m_pClass->GetDescription());
  m_DescText.SetModify(FALSE);

	/* Attribute lists */
  FindComboListItem(m_AttributeList1, pClassData->AttributeID1, true);
  FindComboListItem(m_AttributeList2, pClassData->AttributeID2, true);

	/* Skill lists */
  FindComboListItem(m_MajorList1, pClassData->MajorID1, true);
  FindComboListItem(m_MajorList2, pClassData->MajorID2, true);
  FindComboListItem(m_MajorList3, pClassData->MajorID3, true);
  FindComboListItem(m_MajorList4, pClassData->MajorID4, true);
  FindComboListItem(m_MajorList5, pClassData->MajorID5, true);
  FindComboListItem(m_MinorList1, pClassData->MinorID1, true);
  FindComboListItem(m_MinorList2, pClassData->MinorID2, true);
  FindComboListItem(m_MinorList3, pClassData->MinorID3, true);
  FindComboListItem(m_MinorList4, pClassData->MinorID4, true);
  FindComboListItem(m_MinorList5, pClassData->MinorID5, true);

	/* Specialization list */
  FindComboListItem(m_SpecialList, pClassData->Specialization, true);

	/* Checkboxes */
  m_PlayableCheck.SetCheck((pClassData->Flags & MWESM_CLASSFLAG_PLAYABLE) != 0);
  m_WeaponCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_WEAPONS) != 0);
  m_ArmorCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_ARMOR) != 0);
  m_ClothingCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_CLOTHING) != 0);
  m_BookCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_BOOKS) != 0);
  m_IngrediantCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_INGREDIANTS) != 0);
  m_PickCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_PICKS) != 0);
  m_ProbeCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_PROBES) != 0);
  m_LightCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_LIGHTS) != 0);
  m_ApparatusCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_APPARATUS) != 0);
  m_RepairCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_REPAIR) != 0);
  m_MiscCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_MISC) != 0);
  m_SpellCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_SPELLS) != 0);
  m_MagicItemCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_MAGICITEMS) != 0);
  m_PotionCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_POTIONS) != 0);
  m_TrainCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_TRAINING) != 0);
  m_SpellmakingCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_SPELLMAKING) != 0);  
  m_EnchantCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_ENCHANTING) != 0);
  m_RepairItemsCheck.SetCheck((pClassData->AutoCalcFlags & MWESM_CLASSAUTO_REPAIRITEM) != 0);

 }
/*===========================================================================
 *		End of Class Method CEsmClassDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClassDlg Event - void OnSelChangeSkillList (pComboBox);
 *
 *=========================================================================*/
void CEsmClassDlg::OnSelChangeSkillList (CComboBox* pComboBox) {
  CComboBox* Boxes[] = { &m_MajorList1, &m_MajorList2, &m_MajorList3, &m_MajorList4, &m_MajorList5,
	&m_MinorList1, &m_MinorList2, &m_MinorList3, &m_MinorList4, &m_MinorList5, NULL };
  int SkillIDArray[MWESM_MAX_SKILLS];
  int SkillID;
  int CurrentSkillID;
  int Index;
  int ListIndex;
  int NextEmptySkill = 0;

	/* Get the attribute ID of the current combobox */
  ListIndex = pComboBox->GetCurSel();
  if (ListIndex < 0) return;
  CurrentSkillID = pComboBox->GetItemData(ListIndex);

	/* Initialize the skill ID array */
  memset(&SkillIDArray, 0, MWESM_MAX_SKILLS*sizeof(int));

  for (Index = 0; Boxes[Index] != NULL; Index++) {
    ListIndex = Boxes[Index]->GetCurSel();
    if (ListIndex < 0) continue;
    SkillID = Boxes[Index]->GetItemData(ListIndex);
    SkillIDArray[SkillID]++;
   }

	/* Eliminate all skills the same as the input combo */
  for (Index = 0; Boxes[Index] != NULL; Index++) {
    if (Boxes[Index] == pComboBox) continue;
    ListIndex = Boxes[Index]->GetCurSel();
    if (ListIndex < 0) continue;
    SkillID = Boxes[Index]->GetItemData(ListIndex);

    if (SkillID == CurrentSkillID) {
      for ( ; NextEmptySkill < MWESM_MAX_SKILLS; NextEmptySkill++) {
        if (SkillIDArray[NextEmptySkill] == 0) break;
       }

       FindComboListItem(*Boxes[Index], NextEmptySkill, true);
       SkillIDArray[NextEmptySkill]++;
     }
   }

 }
/*===========================================================================
 *		End of Class Event CEsmClassDlg::OnSelChangeSkillList()
 *=========================================================================*/
