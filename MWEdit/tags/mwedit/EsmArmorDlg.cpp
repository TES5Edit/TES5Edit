/*===========================================================================
 *
 * File:	Esmarmordlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 8, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "Resource.h"
#include "EsmArmorDlg.h"
#include "EsmDlgArray.h"
#include "ChildFrmFix.h"


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

  IMPLEMENT_DYNCREATE(CEsmArmorDlg, CEsmRecDialog);
  DEFINE_FILE("EsmArmorDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmArmorDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmArmorDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmArmorDlg)
  ON_CBN_SELCHANGE(IDC_BIPEDLIST1, OnSelchangeBipedlist1)
  ON_CBN_SELCHANGE(IDC_BIPEDLIST2, OnSelchangeBipedlist2)
  ON_CBN_SELCHANGE(IDC_BIPEDLIST3, OnSelchangeBipedlist3)
  ON_CBN_SELCHANGE(IDC_BIPEDLIST4, OnSelchangeBipedlist4)
  ON_CBN_SELCHANGE(IDC_BIPEDLIST5, OnSelchangeBipedlist5)
  ON_CBN_SELCHANGE(IDC_BIPEDLIST6, OnSelchangeBipedlist6)
  ON_CBN_SELCHANGE(IDC_BIPEDLIST7, OnSelchangeBipedlist7)
  ON_CBN_SELCHANGE(IDC_MARMORLIST1, OnSelchangeArmorList)
  ON_CBN_SELCHANGE(IDC_MARMORLIST2, OnSelchangeArmorList)
  ON_CBN_SELCHANGE(IDC_MARMORLIST3, OnSelchangeArmorList)
  ON_CBN_SELCHANGE(IDC_MARMORLIST4, OnSelchangeArmorList)
  ON_CBN_SELCHANGE(IDC_MARMORLIST5, OnSelchangeArmorList)
  ON_CBN_SELCHANGE(IDC_MARMORLIST6, OnSelchangeArmorList)
  ON_CBN_SELCHANGE(IDC_MARMORLIST7, OnSelchangeArmorList)
  ON_CBN_SELCHANGE(IDC_FARMORLIST1, OnSelchangeArmorList)
  ON_CBN_SELCHANGE(IDC_FARMORLIST2, OnSelchangeArmorList)
  ON_CBN_SELCHANGE(IDC_FARMORLIST3, OnSelchangeArmorList)
  ON_CBN_SELCHANGE(IDC_FARMORLIST4, OnSelchangeArmorList)
  ON_CBN_SELCHANGE(IDC_FARMORLIST5, OnSelchangeArmorList)
  ON_CBN_SELCHANGE(IDC_FARMORLIST6, OnSelchangeArmorList)
  ON_CBN_SELCHANGE(IDC_FARMORLIST7, OnSelchangeArmorList)
  ON_BN_CLICKED(IDC_ENCHANTEDIT2, OnEnchantedit)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmArmorDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmArmorDlg Constructor
 *
 *=========================================================================*/
CEsmArmorDlg::CEsmArmorDlg() : CEsmRecDialog(CEsmArmorDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmArmorDlg)
  //}}AFX_DATA_INIT
  m_pArmor = NULL;
 }
/*===========================================================================
 *		End of Class CEsmArmorDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmArmorDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmArmorDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmArmorDlg)
  DDX_Control(pDX, IDC_ICONPICTURE, m_IconPicture);
  DDX_Control(pDX, IDC_PERSISTCHECK, m_PersistCheck);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_ICONBUTTON, m_IconButton);
  DDX_Control(pDX, IDC_MODELBUTTON, m_ModelButton);
  DDX_Control(pDX, IDC_ENCHANTTEXT, m_EnchantText);
  DDX_Control(pDX, IDC_ENCHANTLIST, m_EnchantList);
  DDX_Control(pDX, IDC_VALUETEXT, m_ValueText);
  DDX_Control(pDX, IDC_HEALTHTEXT, m_HealthText);
  DDX_Control(pDX, IDC_RATINGTEXT, m_RatingText);
  DDX_Control(pDX, IDC_WEIGHTTEXT, m_WeightText);
  DDX_Control(pDX, IDC_SCRIPTLIST, m_ScriptList);
  DDX_Control(pDX, IDC_TYPELIST, m_TypeList);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP

  DDX_Control(pDX, IDC_MARMORLIST1, m_MArmorList[0]);
  DDX_Control(pDX, IDC_MARMORLIST2, m_MArmorList[1]);
  DDX_Control(pDX, IDC_MARMORLIST3, m_MArmorList[2]);
  DDX_Control(pDX, IDC_MARMORLIST4, m_MArmorList[3]);
  DDX_Control(pDX, IDC_MARMORLIST5, m_MArmorList[4]);
  DDX_Control(pDX, IDC_MARMORLIST6, m_MArmorList[5]);
  DDX_Control(pDX, IDC_MARMORLIST7, m_MArmorList[6]);
  DDX_Control(pDX, IDC_FARMORLIST1, m_FArmorList[0]);
  DDX_Control(pDX, IDC_FARMORLIST2, m_FArmorList[1]);
  DDX_Control(pDX, IDC_FARMORLIST3, m_FArmorList[2]);
  DDX_Control(pDX, IDC_FARMORLIST4, m_FArmorList[3]);
  DDX_Control(pDX, IDC_FARMORLIST5, m_FArmorList[4]);
  DDX_Control(pDX, IDC_FARMORLIST6, m_FArmorList[5]);
  DDX_Control(pDX, IDC_FARMORLIST7, m_FArmorList[6]);
  DDX_Control(pDX, IDC_BIPEDLIST1,  m_BipedList[0]);
  DDX_Control(pDX, IDC_BIPEDLIST2,  m_BipedList[1]);
  DDX_Control(pDX, IDC_BIPEDLIST3,  m_BipedList[2]);
  DDX_Control(pDX, IDC_BIPEDLIST4,  m_BipedList[3]);
  DDX_Control(pDX, IDC_BIPEDLIST5,  m_BipedList[4]);
  DDX_Control(pDX, IDC_BIPEDLIST6,  m_BipedList[5]);
  DDX_Control(pDX, IDC_BIPEDLIST7,  m_BipedList[6]);
 }
/*===========================================================================
 *		End of Class Method CEsmArmorDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmArmorDlg Method - void GetBipedData (void);
 *
 *=========================================================================*/
void CEsmArmorDlg::GetBipedData (void) {
  CEsmSubByte*	pIndexRecord;
  CEsmSubName*	pNameRecord;
  CString	Buffer;
  int		BipedIndex;
  int		BipedPart;
  int		Index;

	/* Delete all the INDX/BNAM/CNAM sub-records from the armor record */
  m_pArmor->DeleteSubRecords(MWESM_SUBREC_INDX);
  m_pArmor->DeleteSubRecords(MWESM_SUBREC_BNAM);
  m_pArmor->DeleteSubRecords(MWESM_SUBREC_CNAM);

  for (BipedIndex = 0; BipedIndex < MWESM_ARMOR_MAXBODYPARTS; BipedIndex++) {

		/* Get the value of the currently selected biped part */
    Index = m_BipedList[BipedIndex].GetCurSel();
    if (Index < 0) continue;
    BipedPart = m_BipedList[BipedIndex].GetItemData(Index);
    if (BipedPart < 0) continue;

		/* Create the new index sub-record */
    pIndexRecord = (CEsmSubByte *) m_pArmor->AllocateSubRecord(MWESM_SUBREC_INDX);
    pIndexRecord->CreateNew();
    pIndexRecord->SetValue((byte)BipedPart);

		/* Create the male part record, if any */
    Index = m_MArmorList[BipedIndex].GetCurSel();
    m_MArmorList[BipedIndex].GetWindowText(Buffer);

    if (Index >= 0 && !Buffer.IsEmpty()) {
      pNameRecord = (CEsmSubName *) m_pArmor->AllocateSubRecord(MWESM_SUBREC_BNAM);
      pNameRecord->CreateNew();
      pNameRecord->SetName(Buffer);
     }

		/* Create the female part record, if any */
    Index = m_FArmorList[BipedIndex].GetCurSel();
    m_FArmorList[BipedIndex].GetWindowText(Buffer);

    if (Index >= 0 && !Buffer.IsEmpty()) {
      pNameRecord = (CEsmSubName *) m_pArmor->AllocateSubRecord(MWESM_SUBREC_CNAM);
      pNameRecord->CreateNew();
      pNameRecord->SetName(Buffer);
     }

   }

 }
/*===========================================================================
 *		End of Class Method CEsmArmorDlg::GetBipedData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmArmorDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmArmorDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmArmorDlg::GetControlData()");
  armordata_t*	pArmorData;
  CString	Buffer;  
  int		Index;

	/* Update the armor pointer and data */
  m_pArmor = (CEsmArmor *) GetRecInfo()->pRecord;
  if (m_pArmor == NULL) return;
  pArmorData = m_pArmor->GetArmorData();
  ASSERT(pArmorData != NULL);

	/* Armor ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pArmor->SetID(TrimStringSpace(Buffer));
   }

	/* Armor name */
  m_NameText.GetWindowText(Buffer);
  m_pArmor->SetName(TrimStringSpace(Buffer));

	/* Armor type */
  Index = m_TypeList.GetCurSel();
  if (Index >= 0) pArmorData->Type = m_TypeList.GetItemData(Index);

	/* Armor rating */
  m_RatingText.GetWindowText(Buffer);
  pArmorData->Rating = atoi(Buffer);

	/* Armor health */
  m_HealthText.GetWindowText(Buffer);
  pArmorData->Health = atoi(Buffer);

	/* Armor weight */
  m_WeightText.GetWindowText(Buffer);
  pArmorData->Weight = (float) atof(Buffer);

	/* Armor value */
  m_ValueText.GetWindowText(Buffer);
  pArmorData->Value = atoi(Buffer);

	/* Enchant points */
  m_EnchantText.GetWindowText(Buffer);
  pArmorData->EnchantPts = atoi(Buffer);

	/* Item script */
  m_ScriptList.GetWindowText(Buffer);
  m_pArmor->SetScript(TrimStringSpace(Buffer));

  	/* Item enchant */
  m_EnchantList.GetWindowText(Buffer);
  m_pArmor->SetEnchant(TrimStringSpace(Buffer));

	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pArmor->SetModel(TrimStringSpace(Buffer));

  	/* Icon filename */
  m_IconButton.GetWindowText(Buffer);
  m_pArmor->SetIcon(TrimStringSpace(Buffer));

	/* Record flags */
  m_pArmor->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pArmor->SetBlocked(m_BlockedCheck.GetCheck() != 0);

  GetBipedData();
 }
/*===========================================================================
 *		End of Class Method CEsmArmorDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmArmorDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmArmorDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_RatingText.GetModify()) m_Modified = true;
  if (m_WeightText.GetModify()) m_Modified = true;
  if (m_ValueText.GetModify()) m_Modified = true;
  if (m_HealthText.GetModify()) m_Modified = true;
  if (m_EnchantText.GetModify()) m_Modified = true;
  if (m_NameText.GetModify()) m_Modified = true;
  if (m_IDText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmArmorDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmArmorDlg Event - void OnEnchantedit ();
 *
 *=========================================================================*/
void CEsmArmorDlg::OnEnchantedit() {
  esmrecinfo_t* pRecInfo;
  int		Index;

  Index = m_EnchantList.GetCurSel();
  if (Index < 0) return;
  pRecInfo = (esmrecinfo_t *) m_EnchantList.GetItemData(Index);

  m_pParent->EditRecord(pRecInfo, false);
 }
/*===========================================================================
 *		End of Class Event CEsmArmorDlg::OnEnchantedit()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmArmorDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmArmorDlg::OnInitialUpdate() {
  int Index;

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

  //HICON hIcon;
  //hIcon = AfxGetApp()->LoadIcon(IDI_ARMOR);
  //GetParentFrame()->SetIcon(hIcon, FALSE);
  //SetIcon(hIcon, FALSE);

  //CMenu Menu;
  //Menu.LoadMenu(IDR_LIST_MENU);
  //((CChildFrameFix *)GetParentFrame())->SetSharedMenu(Menu.GetSafeHmenu());
  //((CFrameWnd*)AfxGetMainWnd())->OnUpdateFrameMenu(Menu.GetSafeHmenu());
  //((CFrameWnd*)AfxGetMainWnd())>OnUpdateFrameMenu(NULL) ;
  //((CFrameWnd*)AfxGetMainWnd())->DrawMenuBar();
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pArmor = (CEsmArmor *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmArmorTypeCombo(m_TypeList);
  FillEsmScriptCombo(m_ScriptList);
  FillEsmEnchantCombo(m_EnchantList);
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
  m_EnchantText.SetLimitText(16);
  m_WeightText.SetLimitText(16);
  m_RatingText.SetLimitText(16);
  m_HealthText.SetLimitText(16);
  m_ValueText.SetLimitText(16);

  for (Index = 0; Index < MWESM_ARMOR_MAXBODYPARTS; Index++) {
    FillEsmBodyPartsCombo(m_BipedList[Index]);
   }

  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmArmorDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmArmorDlg Event - void OnSelChangeBipedList (BipedIndex);
 *
 *=========================================================================*/
void CEsmArmorDlg::OnSelChangeBipedList (const int BipedIndex) {
  SetBipedObject(BipedIndex);
  m_Modified = true;
 }
/*===========================================================================
 *		End of Class Event CEsmArmorDlg::OnSelChangeBipedList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmArmorDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmArmorDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {

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
 *		End of Class Event CEsmArmorDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmArmorDlg Method - void SetBipedData (BipedIndex);
 *
 *=========================================================================*/
void CEsmArmorDlg::SetBipedData (const int BipedIndex, CEsmSubByte* pIndexRecord, const int RecordIndex) {
  //DEFINE_FUNCTION("CEsmArmorDlg::SetBipedData()");
  CEsmSubRecord* pPartName1;
  CEsmSubRecord* pPartName2;
  CEsmSubName*   pMalePart   = NULL;
  CEsmSubName*   pFemalePart = NULL;

	/* Is the biped data valid? */
  if (pIndexRecord == NULL) {
    m_BipedList[BipedIndex].SelectString(-1, _T(""));
    SetBipedObject(BipedIndex);
    return;
   }
	
	/* Select the biped part in the list */
  FindComboListItem(m_BipedList[BipedIndex], (int)pIndexRecord->GetValue(), true);

	/* Create the male/female object lists */
  SetBipedObject(BipedIndex);

	/* Try and get the male/female parts */
  pPartName1 = m_pArmor->GetSubRecord(RecordIndex + 1);
  pPartName2 = m_pArmor->GetSubRecord(RecordIndex + 2);

	/* Find the male/female body parts, if any */
  if (pPartName1 != NULL) {
    if (pPartName1->IsType(MWESM_SUBREC_BNAM)) pMalePart   = (CEsmSubName *) pPartName1;
    if (pPartName1->IsType(MWESM_SUBREC_CNAM)) pFemalePart = (CEsmSubName *) pPartName1;
   }

  if (pPartName2 != NULL && pPartName2->IsType(MWESM_SUBREC_CNAM)) pFemalePart = (CEsmSubName *) pPartName2;

	/* Update the female part list */
  if (pFemalePart == NULL)
    m_FArmorList[BipedIndex].SelectString(-1, _T(""));
  else
    m_FArmorList[BipedIndex].SelectString(-1, pFemalePart->GetName());

	/* Update the male part list */
  if (pMalePart == NULL)
    m_MArmorList[BipedIndex].SelectString(-1, _T(""));
  else
    m_MArmorList[BipedIndex].SelectString(-1, pMalePart->GetName());

 }
/*===========================================================================
 *		End of Class Method CEsmArmorDlg::SetBipedData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmArmorDlg Method - void SetBipedData (void);
 *
 *=========================================================================*/
void CEsmArmorDlg::SetBipedData (void) {
  CEsmSubByte* pIndexRecord;
  int	       RecordIndex;
  int	       BipedIndex;

  pIndexRecord = (CEsmSubByte *) m_pArmor->FindFirst(MWESM_SUBREC_INDX, RecordIndex);

	/* Set the body part controls */
  for (BipedIndex = 0; BipedIndex < MWESM_ARMOR_MAXBODYPARTS; BipedIndex++) {
    SetBipedData(BipedIndex, pIndexRecord, RecordIndex);
    pIndexRecord =  (CEsmSubByte *) m_pArmor->FindNext(MWESM_SUBREC_INDX, RecordIndex);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmArmorDlg::SetBipedData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmArmorDlg Method - void SetBipedObject (BipedIndex);
 *
 *=========================================================================*/
void CEsmArmorDlg::SetBipedObject (const int BipedIndex) {
  int BipedPart = -1;
  int BodyPart;
  int ListIndex;

	/* Get the Bodypart ID */
  ListIndex = m_BipedList[BipedIndex].GetCurSel();
  if (BipedIndex >= 0) BipedPart = m_BipedList[BipedIndex].GetItemData(ListIndex);
  
	/* No body part so disable lists */
  if (BipedPart < 0) {
    m_FArmorList[BipedIndex].ResetContent();
    m_MArmorList[BipedIndex].ResetContent();
    m_FArmorList[BipedIndex].EnableWindow(FALSE);
    m_MArmorList[BipedIndex].EnableWindow(FALSE);
    return;
   }

	/* Enable the male/female body part lists */
  m_FArmorList[BipedIndex].EnableWindow(TRUE);
  m_MArmorList[BipedIndex].EnableWindow(TRUE);

	/* Fill the body lists with the appropriate body part records */
  BodyPart = ConvertBipedToBodyPart(BipedPart);
  FillEsmBodyPartsCombo(m_MArmorList[BipedIndex], BodyPart, false, MWESM_PARTTYPE_ARMOR);
  FillEsmBodyPartsCombo(m_FArmorList[BipedIndex], BodyPart, true,  MWESM_PARTTYPE_ARMOR);

	/* Set the list items to initially nothing */
  m_MArmorList[BipedIndex].SelectString(-1, _T(""));
  m_FArmorList[BipedIndex].SelectString(-1, _T(""));
 }
/*===========================================================================
 *		End of Class Method CEsmArmorDlg::SetBipedObject()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmArmorDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmArmorDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pArmor == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pArmor->GetID());
  UpdateTitle(m_pArmor->GetID());

	/* Item strings and values */
  m_NameText.SetWindowText(m_pArmor->GetName());
  m_RatingText.SetWindowText(m_pArmor->GetFieldString(ESM_FIELD_RATING));
  m_HealthText.SetWindowText(m_pArmor->GetFieldString(ESM_FIELD_HEALTH));
  m_WeightText.SetWindowText(m_pArmor->GetFieldString(ESM_FIELD_WEIGHT));
  m_ValueText.SetWindowText(m_pArmor->GetFieldString(ESM_FIELD_VALUE));
  m_EnchantText.SetWindowText(m_pArmor->GetFieldString(ESM_FIELD_ENCHANTPTS));
  m_NameText.SetModify(FALSE);
  m_RatingText.SetModify(FALSE);
  m_HealthText.SetModify(FALSE);
  m_WeightText.SetModify(FALSE);
  m_ValueText.SetModify(FALSE);
  m_EnchantText.SetModify(FALSE);

	/* Model/icon buttons */
  m_ModelButton.SetWindowText(m_pArmor->GetModel());
  m_IconButton.SetWindowText(m_pArmor->GetIcon());
  m_IconPicture.SetEsmIcon(m_pArmor->GetIcon());
  
	/* Item lists */
  FindComboListItem(m_TypeList, m_pArmor->GetArmorTypeID(), true);
  m_EnchantList.SelectString(-1, m_pArmor->GetEnchant());
  m_ScriptList.SelectString(-1, m_pArmor->GetScript());

	/* Record flags */
  m_BlockedCheck.SetCheck(m_pArmor->IsBlocked());
  m_PersistCheck.SetCheck(m_pArmor->IsPersist());

	/* Set all the biped part data */
  SetBipedData();
 }
/*===========================================================================
 *		End of Class Method CEsmArmorDlg::SetControlData()
 *=========================================================================*/

