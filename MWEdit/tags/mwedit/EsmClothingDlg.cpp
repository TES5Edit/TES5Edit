/*===========================================================================
 *
 * File:	Esmclothingdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 14, 2003
 *
 * Description
 *
 *=========================================================================*/


	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "Resource.h"
#include "EsmClothingDlg.h"
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

  IMPLEMENT_DYNCREATE(CEsmClothingDlg, CEsmRecDialog);
  DEFINE_FILE("EsmClothingDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmClothingDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmClothingDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmClothingDlg)
  ON_CBN_SELCHANGE(IDC_BIPEDLIST1, OnSelchangeBipedlist1)
  ON_CBN_SELCHANGE(IDC_BIPEDLIST2, OnSelchangeBipedlist2)
  ON_CBN_SELCHANGE(IDC_BIPEDLIST3, OnSelchangeBipedlist3)
  ON_CBN_SELCHANGE(IDC_BIPEDLIST4, OnSelchangeBipedlist4)
  ON_CBN_SELCHANGE(IDC_BIPEDLIST5, OnSelchangeBipedlist5)
  ON_CBN_SELCHANGE(IDC_BIPEDLIST6, OnSelchangeBipedlist6)
  ON_CBN_SELCHANGE(IDC_BIPEDLIST7, OnSelchangeBipedlist7)
  ON_CBN_SELCHANGE(IDC_MCLOTHLIST1, OnSelchangeClothList)
  ON_CBN_SELCHANGE(IDC_MCLOTHLIST2, OnSelchangeClothList)
  ON_CBN_SELCHANGE(IDC_MCLOTHLIST3, OnSelchangeClothList)
  ON_CBN_SELCHANGE(IDC_MCLOTHLIST4, OnSelchangeClothList)
  ON_CBN_SELCHANGE(IDC_MCLOTHLIST5, OnSelchangeClothList)
  ON_CBN_SELCHANGE(IDC_MCLOTHLIST6, OnSelchangeClothList)
  ON_CBN_SELCHANGE(IDC_MCLOTHLIST7, OnSelchangeClothList)
  ON_CBN_SELCHANGE(IDC_FCLOTHLIST1, OnSelchangeClothList)
  ON_CBN_SELCHANGE(IDC_FCLOTHLIST2, OnSelchangeClothList)
  ON_CBN_SELCHANGE(IDC_FCLOTHLIST3, OnSelchangeClothList)
  ON_CBN_SELCHANGE(IDC_FCLOTHLIST4, OnSelchangeClothList)
  ON_CBN_SELCHANGE(IDC_FCLOTHLIST5, OnSelchangeClothList)
  ON_CBN_SELCHANGE(IDC_FCLOTHLIST6, OnSelchangeClothList)
  ON_CBN_SELCHANGE(IDC_FCLOTHLIST7, OnSelchangeClothList)
  ON_BN_CLICKED(IDC_ENCHANTEDIT, OnEnchantedit)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmClothingDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClothingDlg Constructor
 *
 *=========================================================================*/
CEsmClothingDlg::CEsmClothingDlg() : CEsmRecDialog(CEsmClothingDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmClothingDlg)
  //}}AFX_DATA_INIT
  m_pClothing = NULL;
 }
/*===========================================================================
 *		End of Class CEsmClothingDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClothingDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmClothingDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmClothingDlg)
  DDX_Control(pDX, IDC_ICONPICTURE, m_IconPicture);
  DDX_Control(pDX, IDC_PERSISTCHECK, m_PersistCheck);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_ICONBUTTON, m_IconButton);
  DDX_Control(pDX, IDC_MODELBUTTON, m_ModelButton);
  DDX_Control(pDX, IDC_ENCHANTTEXT, m_EnchantText);
  DDX_Control(pDX, IDC_ENCHANTLIST, m_EnchantList);
  DDX_Control(pDX, IDC_VALUETEXT, m_ValueText);
  DDX_Control(pDX, IDC_WEIGHTTEXT, m_WeightText);
  DDX_Control(pDX, IDC_SCRIPTLIST, m_ScriptList);
  DDX_Control(pDX, IDC_TYPELIST, m_TypeList);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP

  DDX_Control(pDX, IDC_MCLOTHLIST1, m_MClothList[0]);
  DDX_Control(pDX, IDC_MCLOTHLIST2, m_MClothList[1]);
  DDX_Control(pDX, IDC_MCLOTHLIST3, m_MClothList[2]);
  DDX_Control(pDX, IDC_MCLOTHLIST4, m_MClothList[3]);
  DDX_Control(pDX, IDC_MCLOTHLIST5, m_MClothList[4]);
  DDX_Control(pDX, IDC_MCLOTHLIST6, m_MClothList[5]);
  DDX_Control(pDX, IDC_MCLOTHLIST7, m_MClothList[6]);
  DDX_Control(pDX, IDC_FCLOTHLIST1, m_FClothList[0]);
  DDX_Control(pDX, IDC_FCLOTHLIST2, m_FClothList[1]);
  DDX_Control(pDX, IDC_FCLOTHLIST3, m_FClothList[2]);
  DDX_Control(pDX, IDC_FCLOTHLIST4, m_FClothList[3]);
  DDX_Control(pDX, IDC_FCLOTHLIST5, m_FClothList[4]);
  DDX_Control(pDX, IDC_FCLOTHLIST6, m_FClothList[5]);
  DDX_Control(pDX, IDC_FCLOTHLIST7, m_FClothList[6]);
  DDX_Control(pDX, IDC_BIPEDLIST1,  m_BipedList[0]);
  DDX_Control(pDX, IDC_BIPEDLIST2,  m_BipedList[1]);
  DDX_Control(pDX, IDC_BIPEDLIST3,  m_BipedList[2]);
  DDX_Control(pDX, IDC_BIPEDLIST4,  m_BipedList[3]);
  DDX_Control(pDX, IDC_BIPEDLIST5,  m_BipedList[4]);
  DDX_Control(pDX, IDC_BIPEDLIST6,  m_BipedList[5]);
  DDX_Control(pDX, IDC_BIPEDLIST7,  m_BipedList[6]);
 }
/*===========================================================================
 *		End of Class Method CEsmClothingDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClothingDlg Method - void GetBipedData (void);
 *
 *=========================================================================*/
void CEsmClothingDlg::GetBipedData (void) {
  CEsmSubByte*	pIndexRecord;
  CEsmSubName*	pNameRecord;
  CString	Buffer;
  int		BipedIndex;
  int		BipedPart;
  int		Index;

	/* Delete all the INDX/BNAM/CNAM sub-records from the armor record */
  m_pClothing->DeleteSubRecords(MWESM_SUBREC_INDX);
  m_pClothing->DeleteSubRecords(MWESM_SUBREC_BNAM);
  m_pClothing->DeleteSubRecords(MWESM_SUBREC_CNAM);

  for (BipedIndex = 0; BipedIndex < MWESM_CLOTH_MAXBODYPARTS; BipedIndex++) {

		/* Get the value of the currently selected biped part */
    Index = m_BipedList[BipedIndex].GetCurSel();
    if (Index < 0) continue;
    BipedPart = m_BipedList[BipedIndex].GetItemData(Index);
    if (BipedPart < 0) continue;

		/* Create the new index sub-record */
    pIndexRecord = (CEsmSubByte *) m_pClothing->AllocateSubRecord(MWESM_SUBREC_INDX);
    pIndexRecord->CreateNew();
    pIndexRecord->SetValue((byte)BipedPart);

		/* Create the male part record, if any */
    Index = m_MClothList[BipedIndex].GetCurSel();
    m_MClothList[BipedIndex].GetWindowText(Buffer);

    if (Index >= 0 && !Buffer.IsEmpty()) {
      pNameRecord = (CEsmSubName *) m_pClothing->AllocateSubRecord(MWESM_SUBREC_BNAM);
      pNameRecord->CreateNew();
      pNameRecord->SetName(Buffer);
     }

		/* Create the female part record, if any */
    Index = m_FClothList[BipedIndex].GetCurSel();
    m_FClothList[BipedIndex].GetWindowText(Buffer);

    if (Index >= 0 && !Buffer.IsEmpty()) {
      pNameRecord = (CEsmSubName *) m_pClothing->AllocateSubRecord(MWESM_SUBREC_CNAM);
      pNameRecord->CreateNew();
      pNameRecord->SetName(Buffer);
     }

   }

 }
/*===========================================================================
 *		End of Class Method CEsmClothingDlg::GetBipedData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClothingDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmClothingDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmClothingDlg::GetControlData()");
  CString	Buffer;  
  int		Index;

	/* Update the armor pointer and data */
  m_pClothing = (CEsmClothing *) GetRecInfo()->pRecord;
  if (m_pClothing == NULL) return;

	/* Armor ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pClothing->SetID(TrimStringSpace(Buffer));
   }

	/* Armor name */
  m_NameText.GetWindowText(Buffer);
  m_pClothing->SetName(TrimStringSpace(Buffer));

	/* Armor type */
  Index = m_TypeList.GetCurSel();
  if (Index >= 0) m_pClothing->SetClothType(m_TypeList.GetItemData(Index));

	/* Armor weight */
  m_WeightText.GetWindowText(Buffer);
  m_pClothing->SetWeight((float) atof(Buffer));

	/* Armor value */
  m_ValueText.GetWindowText(Buffer);
  m_pClothing->SetValue(atoi(Buffer));

	/* Enchant points */
  m_EnchantText.GetWindowText(Buffer);
  m_pClothing->SetEnchantPts(atoi(Buffer));

	/* Item script */
  m_ScriptList.GetWindowText(Buffer);
  m_pClothing->SetScript(TrimStringSpace(Buffer));

  	/* Item enchant */
  m_EnchantList.GetWindowText(Buffer);
  m_pClothing->SetEnchant(TrimStringSpace(Buffer));

	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pClothing->SetModel(TrimStringSpace(Buffer));

  	/* Icon filename */
  m_IconButton.GetWindowText(Buffer);
  m_pClothing->SetIcon(TrimStringSpace(Buffer));

	/* Record flags */
  m_pClothing->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pClothing->SetBlocked(m_BlockedCheck.GetCheck() != 0);

  GetBipedData();
 }
/*===========================================================================
 *		End of Class Method CEsmClothingDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClothingDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmClothingDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_WeightText.GetModify()) m_Modified = true;
  if (m_ValueText.GetModify()) m_Modified = true;
  if (m_EnchantText.GetModify()) m_Modified = true;
  if (m_NameText.GetModify()) m_Modified = true;
  if (m_IDText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmClothingDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClothingDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmClothingDlg::OnInitialUpdate() {
  int Index;

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pClothing = (CEsmClothing *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmClothTypeCombo(m_TypeList);
  FillEsmScriptCombo(m_ScriptList);
  FillEsmEnchantCombo(m_EnchantList);
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
  m_EnchantText.SetLimitText(16);
  m_WeightText.SetLimitText(16);
  m_ValueText.SetLimitText(16);

  for (Index = 0; Index < MWESM_CLOTH_MAXBODYPARTS; Index++) {
    FillEsmBodyPartsCombo(m_BipedList[Index]);
   }

  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmClothingDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClothingDlg Event - void OnSelChangeBipedList (BipedIndex);
 *
 *=========================================================================*/
void CEsmClothingDlg::OnSelChangeBipedList (const int BipedIndex) {
  SetBipedObject(BipedIndex);
  m_Modified = true;
 }
/*===========================================================================
 *		End of Class Event CEsmClothingDlg::OnSelChangeBipedList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClothingDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmClothingDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {

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
 *		End of Class Event CEsmClothingDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClothingDlg Method - void SetBipedData (BipedIndex);
 *
 *=========================================================================*/
void CEsmClothingDlg::SetBipedData (const int BipedIndex, CEsmSubByte* pIndexRecord, const int RecordIndex) {
  //DEFINE_FUNCTION("CEsmClothingDlg::SetBipedData()");
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
  pPartName1 = m_pClothing->GetSubRecord(RecordIndex + 1);
  pPartName2 = m_pClothing->GetSubRecord(RecordIndex + 2);

	/* Find the male/female body parts, if any */
  if (pPartName1 != NULL) {
    if (pPartName1->IsType(MWESM_SUBREC_BNAM)) pMalePart   = (CEsmSubName *) pPartName1;
    if (pPartName1->IsType(MWESM_SUBREC_CNAM)) pFemalePart = (CEsmSubName *) pPartName1;
   }

  if (pPartName2 != NULL && pPartName2->IsType(MWESM_SUBREC_CNAM)) pFemalePart = (CEsmSubName *) pPartName2;

	/* Update the female part list */
  if (pFemalePart == NULL)
    m_FClothList[BipedIndex].SelectString(-1, _T(""));
  else
    m_FClothList[BipedIndex].SelectString(-1, pFemalePart->GetName());

	/* Update the male part list */
  if (pMalePart == NULL)
    m_MClothList[BipedIndex].SelectString(-1, _T(""));
  else
    m_MClothList[BipedIndex].SelectString(-1, pMalePart->GetName());

 }
/*===========================================================================
 *		End of Class Method CEsmClothingDlg::SetBipedData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClothingDlg Method - void SetBipedData (void);
 *
 *=========================================================================*/
void CEsmClothingDlg::SetBipedData (void) {
  CEsmSubByte* pIndexRecord;
  int	       RecordIndex;
  int	       BipedIndex;

  pIndexRecord = (CEsmSubByte *) m_pClothing->FindFirst(MWESM_SUBREC_INDX, RecordIndex);

	/* Set the body part controls */
  for (BipedIndex = 0; BipedIndex < MWESM_CLOTH_MAXBODYPARTS; BipedIndex++) {
    SetBipedData(BipedIndex, pIndexRecord, RecordIndex);
    pIndexRecord =  (CEsmSubByte *) m_pClothing->FindNext(MWESM_SUBREC_INDX, RecordIndex);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmClothingDlg::SetBipedData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClothingDlg Method - void SetBipedObject (BipedIndex);
 *
 *=========================================================================*/
void CEsmClothingDlg::SetBipedObject (const int BipedIndex) {
  int BipedPart = -1;
  int BodyPart;
  int ListIndex;

	/* Get the Bodypart ID */
  ListIndex = m_BipedList[BipedIndex].GetCurSel();
  if (BipedIndex >= 0) BipedPart = m_BipedList[BipedIndex].GetItemData(ListIndex);
  
	/* No body part so disable lists */
  if (BipedPart < 0) {
    m_FClothList[BipedIndex].ResetContent();
    m_MClothList[BipedIndex].ResetContent();
    m_FClothList[BipedIndex].EnableWindow(FALSE);
    m_MClothList[BipedIndex].EnableWindow(FALSE);
    return;
   }

	/* Enable the male/female body part lists */
  m_FClothList[BipedIndex].EnableWindow(TRUE);
  m_MClothList[BipedIndex].EnableWindow(TRUE);

	/* Fill the body lists with the appropriate body part records */
  BodyPart = ConvertBipedToBodyPart(BipedPart);
  FillEsmBodyPartsCombo(m_MClothList[BipedIndex], BodyPart, false, MWESM_PARTTYPE_CLOTHING);
  FillEsmBodyPartsCombo(m_FClothList[BipedIndex], BodyPart, true,  MWESM_PARTTYPE_CLOTHING);

	/* Set the list items to initially nothing */
  m_MClothList[BipedIndex].SelectString(-1, _T(""));
  m_FClothList[BipedIndex].SelectString(-1, _T(""));
 }
/*===========================================================================
 *		End of Class Method CEsmClothingDlg::SetBipedObject()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClothingDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmClothingDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pClothing == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pClothing->GetID());
  UpdateTitle(m_pClothing->GetID());

	/* Item strings and values */
  m_NameText.SetWindowText(m_pClothing->GetName());
  m_WeightText.SetWindowText(m_pClothing->GetFieldString(ESM_FIELD_WEIGHT));
  m_ValueText.SetWindowText(m_pClothing->GetFieldString(ESM_FIELD_VALUE));
  m_EnchantText.SetWindowText(m_pClothing->GetFieldString(ESM_FIELD_ENCHANTPTS));
  m_NameText.SetModify(FALSE);
  m_WeightText.SetModify(FALSE);
  m_ValueText.SetModify(FALSE);
  m_EnchantText.SetModify(FALSE);

	/* Model/icon buttons */
  m_ModelButton.SetWindowText(m_pClothing->GetModel());
  m_IconButton.SetWindowText(m_pClothing->GetIcon());
  m_IconPicture.SetEsmIcon(m_pClothing->GetIcon());
  
	/* Item lists */
  FindComboListItem(m_TypeList, m_pClothing->GetClothTypeID(), true);
  m_EnchantList.SelectString(-1, m_pClothing->GetEnchant());
  m_ScriptList.SelectString(-1, m_pClothing->GetScript());

	/* Record flags */
  m_BlockedCheck.SetCheck(m_pClothing->IsBlocked());
  m_PersistCheck.SetCheck(m_pClothing->IsPersist());

	/* Set all the biped part data */
  SetBipedData();
 }
/*===========================================================================
 *		End of Class Method CEsmClothingDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmClothingDlg Event - void OnEnchantedit ();
 *
 *=========================================================================*/
void CEsmClothingDlg::OnEnchantedit() {
  esmrecinfo_t* pRecInfo;
  int		Index;

  Index = m_EnchantList.GetCurSel();
  if (Index < 0) return;
  pRecInfo = (esmrecinfo_t *) m_EnchantList.GetItemData(Index);

  m_pParent->EditRecord(pRecInfo, false);
 }
/*===========================================================================
 *		End of Class Event CEsmClothingDlg::OnEnchantedit()
 *=========================================================================*/
