/*===========================================================================
 *
 * File:	Createview.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	May 24, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWRandItem.h"
#include "CreateView.h"
#include "MwRandItemDlg.h" 
#include "WinUtil.h"
#include "dl_time.h"
 

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

  IMPLEMENT_DYNCREATE(CCreateView, CPropertyPage);
  DEFINE_FILE("CreateView.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CCreateView Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CCreateView, CPropertyPage)
  //{{AFX_MSG_MAP(CCreateView)
  ON_BN_CLICKED(IDC_CREATEBUTTON2, OnCreateButton)
  ON_BN_CLICKED(IDC_CREATELISTCHECK, OnCreatelistcheck)
  ON_BN_CLICKED(IDC_BELLCHECK, OnBellcheck)
  ON_BN_CLICKED(IDC_USELISTID, OnUselistid)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CCreateView Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCreateView Constructor
 *
 *=========================================================================*/
CCreateView::CCreateView() : CPropertyPage(CCreateView::IDD) {
  //{{AFX_DATA_INIT(CCreateView)
  //}}AFX_DATA_INIT
  m_pOptions     = NULL;
  m_pRandItemGen = NULL;
  m_pParentDlg   = NULL;
  m_CreateTime   = 0;
 }
/*===========================================================================
 *		End of Class CCreateView Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCreateView Destructor
 *
 *=========================================================================*/
CCreateView::~CCreateView() {
 }
/*===========================================================================
 *		End of Class CCreateView Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCreateView Method - void CreateIDTypeList (void);
 *
 * Creates the ID type combo box list.
 *
 *=========================================================================*/
void CCreateView::CreateIDTypeList (void) {
  int Result;

  m_IdTypeList.ResetContent();

  Result = m_IdTypeList.AddString(_T("Long ID"));
  if (Result >= 0) m_IdTypeList.SetItemData(Result, MWRID_IDTYPE_LONG);
  m_IdTypeList.SetCurSel(Result);

  Result = m_IdTypeList.AddString(_T("Short ID-8"));
  if (Result >= 0) m_IdTypeList.SetItemData(Result, MWRID_IDTYPE_SHORT8);
  Result = m_IdTypeList.AddString(_T("Short ID-4"));
  if (Result >= 0) m_IdTypeList.SetItemData(Result, MWRID_IDTYPE_SHORT4);
 }
/*===========================================================================
 *		End of Class Method CCreateView::CreateIDTypeList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCreateView Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CCreateView::DoDataExchange(CDataExchange* pDX) {
  CPropertyPage::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CCreateView)
  DDX_Control(pDX, IDC_MISCCREATE, m_MiscCheck);
  DDX_Control(pDX, IDC_UNINSTALLSCRIPTNAME, m_UnScriptName);
  DDX_Control(pDX, IDC_INSTALLSCRIPTNAME, m_InScriptName);
  DDX_Control(pDX, IDC_INSTALLSCRIPT, m_UseScriptName);
  DDX_Control(pDX, IDC_PHLISTID, m_PHListID);
  DDX_Control(pDX, IDC_MAKEPHLIST, m_MakePHList);
  DDX_Control(pDX, IDC_IDTYPECOMBO, m_IdTypeList);
  DDX_Control(pDX, IDC_OUTPUTSCRIPTCHECK2, m_OutputScriptRec);
  DDX_Control(pDX, IDC_OUTPUTSCRIPTCHECK, m_OutputScript);
  DDX_Control(pDX, IDC_USELISTID, m_UseListID);
  DDX_Control(pDX, IDC_CHANCENONE1, m_ChanceNone);
  DDX_Control(pDX, IDC_REMOVEDUPCHECK, m_RemoveDuplicates);
  DDX_Control(pDX, IDC_CURSECHANCE, m_CurseChance);
  DDX_Control(pDX, IDC_UNIQUECHANCE, m_UniqueChance);
  DDX_Control(pDX, IDC_SUFFIXCHANCE, m_SuffixChance);
  DDX_Control(pDX, IDC_PREFIXCHANCE, m_PrefixChance);
  DDX_Control(pDX, IDC_IDPREFIXTEXT, m_IDPrefix);
  DDX_Control(pDX, IDC_LISTID, m_ListID);
  DDX_Control(pDX, IDC_CREATELISTCHECK, m_CreateListCheck);
  DDX_Control(pDX, IDC_CLOTHINGCREATE, m_ClothingCheck);
  DDX_Control(pDX, IDC_ARMORCHECK, m_ArmorCheck);
  DDX_Control(pDX, IDC_WEAPONCHECK, m_WeaponCheck);
  DDX_Control(pDX, IDC_BELLVALUE, m_BellValue);
  DDX_Control(pDX, IDC_BELLCHECK, m_BellCheck);
  DDX_Control(pDX, IDC_LEVELTO, m_LevelTo);
  DDX_Control(pDX, IDC_LEVELFROM, m_LevelFrom);
  DDX_Control(pDX, IDC_NUMBER, m_ItemNumber);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CCreateView::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCreateView Method - void GetControlData (void);
 *
 * Get data from the controls and store it in the current options object.
 *
 *=========================================================================*/
void CCreateView::GetControlData (void) {
  CString Buffer;
  int     Result;

	/* Ignore if the options object is not valid */
  if (m_pOptions == NULL) return;

  m_IDPrefix.GetWindowText(Buffer);
  Result = m_IdTypeList.GetCurSel();
  if (Result >= 0) m_pOptions->IDType = m_IdTypeList.GetItemData(Result);

  switch (m_pOptions->IDType) {
    case MWRID_IDTYPE_LONG: 
      strnncpy(m_pOptions->IDPrefix, Buffer, 8);
      break;
    case MWRID_IDTYPE_SHORT8: 
      strnncpy(m_pOptions->IDPrefix, Buffer, 24);
      break;
    case MWRID_IDTYPE_SHORT4:
      strnncpy(m_pOptions->IDPrefix, Buffer, 28);
      break;
   }
  
  m_pOptions->UseBell = (m_BellCheck.GetCheck() != 0);
  m_pOptions->MakePHLists = (m_MakePHList.GetCheck() != 0);
  m_pOptions->RemoveDuplicates = (m_RemoveDuplicates.GetCheck() != 0);
  m_pOptions->UseListID = (m_UseListID.GetCheck() != 0);
  m_pOptions->OutputScript = (m_OutputScript.GetCheck() != 0);
  m_pOptions->OutputScriptRecord = (m_OutputScriptRec.GetCheck() != 0);
  m_pOptions->UseScriptNames = (m_UseScriptName.GetCheck() != 0);

  m_InScriptName.GetWindowText(Buffer);
  strnncpy(m_pOptions->InstallScript, Buffer, MWRI_MAX_NAMESIZE);
  m_UnScriptName.GetWindowText(Buffer);
  strnncpy(m_pOptions->UninstallScript, Buffer, MWRI_MAX_NAMESIZE);

  m_ListID.GetWindowText(Buffer);
  strnncpy(m_pOptions->ListID, Buffer, MWRI_MAX_NAMESIZE);

  m_PHListID.GetWindowText(Buffer);
  strnncpy(m_pOptions->PHListID, Buffer, MWRI_MAX_NAMESIZE);

  m_BellValue.GetWindowText(Buffer);
  m_pOptions->RandomBell = (float) atof(Buffer);
  if (m_pOptions->RandomBell < 1.0f)  m_pOptions->RandomBell = 1.0f;
  if (m_pOptions->RandomBell > 99.0f) m_pOptions->RandomBell = 99.0f;

  m_CurseChance.GetWindowText(Buffer);
  m_pOptions->CursedChance = (float) atof(Buffer) / 100.0f;

  m_PrefixChance.GetWindowText(Buffer);
  m_pOptions->PrefixChance = (float) atof(Buffer) / 100.0f;

  m_SuffixChance.GetWindowText(Buffer);
  m_pOptions->SuffixChance = (float) atof(Buffer) / 100.0f;

  m_UniqueChance.GetWindowText(Buffer);
  m_pOptions->UniqueChance = (float) atof(Buffer) / 100.0f;

  m_ChanceNone.GetWindowText(Buffer);
  m_pOptions->ChanceNone = (float) atof(Buffer);
  if (m_pOptions->ChanceNone < 0)   m_pOptions->ChanceNone = 0;
  if (m_pOptions->ChanceNone > 100) m_pOptions->ChanceNone = 100;

  m_LevelFrom.GetWindowText(Buffer);
  m_pOptions->MinLevel = atoi(Buffer);
  
  m_LevelTo.GetWindowText(Buffer);
  m_pOptions->MaxLevel = atoi(Buffer);

  m_ItemNumber.GetWindowText(Buffer);
  m_pOptions->NumItems = atoi(Buffer);

  m_pOptions->CreateLevelLists = m_CreateListCheck.GetCheck() != 0;
  m_pOptions->ItemMask = 0;

  if (m_WeaponCheck.GetCheck())   m_pOptions->ItemMask |= MWRI_ITEMMASK_WEAPON;
  if (m_ArmorCheck.GetCheck())    m_pOptions->ItemMask |= MWRI_ITEMMASK_ARMOR;
  if (m_ClothingCheck.GetCheck()) m_pOptions->ItemMask |= MWRI_ITEMMASK_CLOTHING;
  if (m_MiscCheck.GetCheck())     m_pOptions->ItemMask |= MWRI_ITEMMASK_MISC;
 }
/*===========================================================================
 *		End of Class Method CCreateView::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCreateView Event - void OnBellcheck ();
 *
 *=========================================================================*/
void CCreateView::OnBellcheck() {
  m_BellValue.EnableWindow(m_BellCheck.GetCheck());
 }
/*===========================================================================
 *		End of Class Event CCreateView::OnBellcheck()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCreateView Event - void OnCreatelistcheck ();
 *
 *=========================================================================*/
void CCreateView::OnCreatelistcheck() {
  //m_ListID.EnableWindow(m_CreateListCheck.GetCheck());
 }
/*===========================================================================
 *		End of Class Event CCreateView::OnCreatelistcheck()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCreateView Event - void OnCreateButton ();
 *
 *=========================================================================*/
void CCreateView::OnCreateButton() {
  double StartTime;

  GetControlData();
  if (m_pRandItemGen == NULL) return;

  StartTime = GetHiClockTime();
  m_pRandItemGen->CreateItems();
  m_CreateTime = GetHiClockTime() - StartTime;

  if (m_pParentDlg != NULL) m_pParentDlg->SendMessage(MWRI_EVENT_NEWITEMS, 0, 0);
 }
/*===========================================================================
 *		End of Class Event CCreateView::OnCreateButton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCreateView Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CCreateView::OnInitDialog() {
  CPropertyPage::OnInitDialog();
	
  CreateIDTypeList();
  SetControlData();	 
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CCreateView::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCreateView Method - void SetControlData (void);
 *
 * Set data to the controls from the current options object.
 *
 *=========================================================================*/
void CCreateView::SetControlData (void) {
  CString Buffer;

	/* Ignore if the options object is not valid */
  if (m_pOptions == NULL) return;

  m_IDPrefix.SetWindowText(m_pOptions->IDPrefix);
  FindComboListItem(m_IdTypeList, m_pOptions->IDType, true);
  m_BellCheck.SetCheck(m_pOptions->UseBell);
  m_ListID.SetWindowText(m_pOptions->ListID);
  m_PHListID.SetWindowText(m_pOptions->PHListID);
  m_InScriptName.SetWindowText(m_pOptions->InstallScript);
  m_UnScriptName.SetWindowText(m_pOptions->UninstallScript);
  Buffer.Format(_T("%g"), m_pOptions->RandomBell);
  m_BellValue.SetWindowText(Buffer);
  m_BellValue.EnableWindow(m_pOptions->UseBell);
  m_RemoveDuplicates.SetCheck(m_pOptions->RemoveDuplicates);

  Buffer.Format(_T("%g"), m_pOptions->CursedChance*100.0f);
  m_CurseChance.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int)m_pOptions->ChanceNone);
  m_ChanceNone.SetWindowText(Buffer);
  Buffer.Format(_T("%.1f"), m_pOptions->PrefixChance*100.0f);
  m_PrefixChance.SetWindowText(Buffer);
  Buffer.Format(_T("%.1f"), m_pOptions->SuffixChance*100.0f);
  m_SuffixChance.SetWindowText(Buffer);
  Buffer.Format(_T("%.1f"), m_pOptions->UniqueChance*100.0f);
  m_UniqueChance.SetWindowText(Buffer);

  Buffer.Format(_T("%d"), m_pOptions->MinLevel);
  m_LevelFrom.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), m_pOptions->MaxLevel);
  m_LevelTo.SetWindowText(Buffer);

  Buffer.Format(_T("%d"), m_pOptions->NumItems);
  m_ItemNumber.SetWindowText(Buffer);

  m_CreateListCheck.SetCheck(m_pOptions->CreateLevelLists);
  m_OutputScript.SetCheck(m_pOptions->OutputScript);
  m_OutputScriptRec.SetCheck(m_pOptions->OutputScriptRecord);
  m_UseScriptName.SetCheck(m_pOptions->UseScriptNames);
  m_MakePHList.SetCheck(m_pOptions->MakePHLists);

  m_WeaponCheck.SetCheck((m_pOptions->ItemMask & MWRI_ITEMMASK_WEAPON) != 0);
  m_ArmorCheck.SetCheck((m_pOptions->ItemMask & MWRI_ITEMMASK_ARMOR) != 0);
  m_ClothingCheck.SetCheck((m_pOptions->ItemMask & MWRI_ITEMMASK_CLOTHING) != 0);
  m_MiscCheck.SetCheck((m_pOptions->ItemMask & MWRI_ITEMMASK_MISC) != 0);

  m_UseListID.SetCheck(m_pOptions->UseListID);
  m_ListID.EnableWindow(m_UseListID.GetCheck());
 }
/*===========================================================================
 *		End of Class Method CCreateView::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCreateView Event - void OnUselistid ();
 *
 *=========================================================================*/
void CCreateView::OnUselistid() {
  m_ListID.EnableWindow(m_UseListID.GetCheck());
 }
/*===========================================================================
 *		End of Class Event CCreateView::OnUselistid()
 *=========================================================================*/


