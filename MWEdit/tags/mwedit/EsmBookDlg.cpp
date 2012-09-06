/*===========================================================================
 *
 * File:	Esmbookdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 14, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmBookDlg.h"
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

  IMPLEMENT_DYNCREATE(CEsmBookDlg, CEsmRecDialog);
  DEFINE_FILE("EsmBookDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmBookDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmBookDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmBookDlg)
  ON_BN_CLICKED(IDC_ENCHANTEDIT, OnEnchantedit)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmBookDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBookDlg Constructor
 *
 *=========================================================================*/
CEsmBookDlg::CEsmBookDlg() : CEsmRecDialog(CEsmBookDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmBookDlg)
  //}}AFX_DATA_INIT
  m_pBook = NULL;
 }
/*===========================================================================
 *		End of Class CEsmBookDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBookDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmBookDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmBookDlg)
  DDX_Control(pDX, IDC_ICONPICTURE, m_IconPicture);
  DDX_Control(pDX, IDC_PERSISTCHECK, m_PersistCheck);
  DDX_Control(pDX, IDC_SCROLLCHECK, m_ScrollCheck);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_ICONBUTTON, m_IconButton);
  DDX_Control(pDX, IDC_MODELBUTTON, m_ModelButton);
  DDX_Control(pDX, IDC_ENCHANTTEXT, m_EnchantText);
  DDX_Control(pDX, IDC_ENCHANTLIST, m_EnchantList);
  DDX_Control(pDX, IDC_VALUETEXT, m_ValueText);
  DDX_Control(pDX, IDC_BOOKTEXT, m_BookText);
  DDX_Control(pDX, IDC_WEIGHTTEXT, m_WeightText);
  DDX_Control(pDX, IDC_SCRIPTLIST, m_ScriptList);
  DDX_Control(pDX, IDC_SKILLLIST, m_SkillList);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmBookDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBookDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmBookDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmBookDlg::GetControlData()");
  CString	Buffer;  
  int		Index;

	/* Update the object pointer and data */
  m_pBook = (CEsmBook *) GetRecInfo()->pRecord;
  if (m_pBook == NULL) return;

	/* Armor ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pBook->SetID(TrimStringSpace(Buffer));
   }

	/* Object name */
  m_NameText.GetWindowText(Buffer);
  m_pBook->SetName(TrimStringSpace(Buffer));

	/* Object skill type */
  Index = m_SkillList.GetCurSel();

  if (Index >= 0) 
    m_pBook->SetSkillID(m_SkillList.GetItemData(Index));
  else 
    m_pBook->SetSkillID(-1);

	/* Object book text */
  m_BookText.GetWindowText(Buffer);
  m_pBook->SetBookText(Buffer);

	/* Object weight */
  m_WeightText.GetWindowText(Buffer);
  m_pBook->SetWeight((float) atof(Buffer));

	/* Object value */
  m_ValueText.GetWindowText(Buffer);
  m_pBook->SetValue(atoi(Buffer));

	/* Enchant points */
  m_EnchantText.GetWindowText(Buffer);
  m_pBook->SetEnchantPts(atoi(Buffer));

	/* Item script */
  m_ScriptList.GetWindowText(Buffer);
  m_pBook->SetScript(TrimStringSpace(Buffer));

  	/* Item enchant */
  m_EnchantList.GetWindowText(Buffer);
  m_pBook->SetEnchant(TrimStringSpace(Buffer));

	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pBook->SetModel(TrimStringSpace(Buffer));

  	/* Icon filename */
  m_IconButton.GetWindowText(Buffer);
  m_pBook->SetIcon(TrimStringSpace(Buffer));

	/* Record flags */
  m_pBook->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pBook->SetScroll(m_ScrollCheck.GetCheck() != 0);
  m_pBook->SetBlocked(m_BlockedCheck.GetCheck() != 0);
 }
/*===========================================================================
 *		End of Class Method CEsmBookDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBookDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmBookDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_BookText.GetModify()) m_Modified = true;
  if (m_WeightText.GetModify()) m_Modified = true;
  if (m_ValueText.GetModify()) m_Modified = true;
  if (m_EnchantText.GetModify()) m_Modified = true;
  if (m_NameText.GetModify()) m_Modified = true;
  if (m_IDText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmBookDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBookDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmBookDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
 
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pBook = (CEsmBook *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmSkillsCombo(m_SkillList, true);
  FillEsmScriptCombo(m_ScriptList);
  FillEsmEnchantCombo(m_EnchantList);
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
  m_WeightText.SetLimitText(10);
  m_ValueText.SetLimitText(10);
  m_EnchantText.SetLimitText(10);
  m_BookText.SetLimitText(65536);

  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmBookDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBookDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmBookDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  CString Buffer;

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
 *		End of Class Event CEsmBookDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBookDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmBookDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pBook == NULL) return;

	/* ID, update title as well */
  m_IDText.SetWindowText(m_pBook->GetID());
  UpdateTitle(m_pBook->GetID());

	/* Item strings and values */
  m_NameText.SetWindowText(m_pBook->GetName());
  m_WeightText.SetWindowText(m_pBook->GetFieldString(ESM_FIELD_WEIGHT));
  m_ValueText.SetWindowText(m_pBook->GetFieldString(ESM_FIELD_VALUE));
  m_EnchantText.SetWindowText(m_pBook->GetFieldString(ESM_FIELD_ENCHANTPTS));
  m_BookText.SetWindowText(m_pBook->GetBookText());
  m_NameText.SetModify(FALSE);
  m_BookText.SetModify(FALSE);
  m_WeightText.SetModify(FALSE);
  m_ValueText.SetModify(FALSE);
  m_EnchantText.SetModify(FALSE);

	/* Model/icon buttons */
  m_ModelButton.SetWindowText(m_pBook->GetModel());
  m_IconButton.SetWindowText(m_pBook->GetIcon());
  m_IconPicture.SetEsmIcon(m_pBook->GetIcon());
  
	/* Item lists */
  FindComboListItem(m_SkillList, m_pBook->GetSkillID(), true);
  m_EnchantList.SelectString(-1, m_pBook->GetEnchant());
  m_ScriptList.SelectString(-1, m_pBook->GetScript());

	/* Record flags */
  m_ScrollCheck.SetCheck(m_pBook->IsScroll());
  m_BlockedCheck.SetCheck(m_pBook->IsBlocked());
  m_PersistCheck.SetCheck(m_pBook->IsPersist());
 }
/*===========================================================================
 *		End of Class Method CEsmBookDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBookDlg Event - void OnEnchantedit ();
 *
 *=========================================================================*/
void CEsmBookDlg::OnEnchantedit() {
  esmrecinfo_t* pRecInfo;
  int		Index;

  Index = m_EnchantList.GetCurSel();
  if (Index < 0) return;
  pRecInfo = (esmrecinfo_t *) m_EnchantList.GetItemData(Index);

  m_pParent->EditRecord(pRecInfo, false);
 }
/*===========================================================================
 *		End of Class Event CEsmBookDlg::OnEnchantedit()
 *=========================================================================*/
