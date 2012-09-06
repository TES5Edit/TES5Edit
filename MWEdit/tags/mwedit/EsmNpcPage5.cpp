/*===========================================================================
 *
 * File:	Esmnpcpage5.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 25, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmNpcPage5.h"
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

  IMPLEMENT_DYNCREATE(CEsmNpcPage5, CPropertyPage);
  DEFINE_FILE("EsmNpcPage5.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmNpcPage5 Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmNpcPage5, CPropertyPage)
  //{{AFX_MSG_MAP(CEsmNpcPage5)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmNpcPage5 Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage5 Constructor
 *
 *=========================================================================*/
CEsmNpcPage5::CEsmNpcPage5() : CPropertyPage(CEsmNpcPage5::IDD) {
  //{{AFX_DATA_INIT(CEsmNpcPage5)
  //}}AFX_DATA_INIT
  m_pRecInfo    = NULL;
  m_pDlgHandler = NULL;
 }
/*===========================================================================
 *		End of Class CEsmNpcPage5 Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage5 Destructor
 *
 *=========================================================================*/
CEsmNpcPage5::~CEsmNpcPage5() {
 }
/*===========================================================================
 *		End of Class CEsmNpcPage5 Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage5 Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmNpcPage5::DoDataExchange(CDataExchange* pDX) {
  CPropertyPage::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmNpcPage5)
  DDX_Control(pDX, IDC_CELLLIST4, m_CellList4);
  DDX_Control(pDX, IDC_CELLLIST3, m_CellList3);
  DDX_Control(pDX, IDC_CELLLIST2, m_CellList2);
  DDX_Control(pDX, IDC_CELLLIST1, m_CellList1);
  DDX_Control(pDX, IDC_REPAIRSCHECK, m_RepairsItemsCheck);
  DDX_Control(pDX, IDC_TRAINCHECK, m_TrainCheck);
  DDX_Control(pDX, IDC_SPELLMAKECHECK, m_SpellmakeCheck);
  DDX_Control(pDX, IDC_ENCHANTCHECK, m_EnchantCheck);
  DDX_Control(pDX, IDC_GOLDTEXT, m_GoldText);
  DDX_Control(pDX, IDC_WEAPONCHECK, m_WeaponCheck);
  DDX_Control(pDX, IDC_SPELLCHECK, m_SpellCheck);
  DDX_Control(pDX, IDC_MAGICITEMCHECK, m_MagicCheck);
  DDX_Control(pDX, IDC_REPAIRCHECK, m_RepairCheck);
  DDX_Control(pDX, IDC_POTIONCHECK, m_PotionCheck);
  DDX_Control(pDX, IDC_PROBECHECK, m_ProbeCheck);
  DDX_Control(pDX, IDC_MISCCHECK, m_MiscCheck);
  DDX_Control(pDX, IDC_PICKCHECK, m_PickCheck);
  DDX_Control(pDX, IDC_LIGHTCHECK, m_LightCheck);
  DDX_Control(pDX, IDC_INGREDIANTCHECK, m_IngreCheck);
  DDX_Control(pDX, IDC_CLOTHINGCHECK, m_ClothCheck);
  DDX_Control(pDX, IDC_BOOKCHECK, m_BookCheck);
  DDX_Control(pDX, IDC_ARMORCHECK, m_ArmorCheck);
  DDX_Control(pDX, IDC_APPARATUSCHECK, m_ApparatusCheck);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage5::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage5 Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmNpcPage5::GetControlData (void) {
  CEsmNpc*  	  pNpc;
  aidata_t*	  pAiData;
  CString	  Buffer;
  
  if (m_pRecInfo == NULL) return;
  pNpc = (CEsmNpc *) m_pRecInfo->pRecord;
  pAiData = pNpc->GetAIData();

	/* Gold */
  m_GoldText.GetWindowText(Buffer);
  pNpc->SetGold(atol(Buffer));

	/* Flags */
  if (!pNpc->IsAutoCalc() && pAiData != NULL) {
    pAiData->Flags = 0;
    if (m_ApparatusCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_APPARATUS;
    if (m_WeaponCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_WEAPONS;
    if (m_ArmorCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_ARMOR;
    if (m_LightCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_LIGHTS;
    if (m_BookCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_BOOKS;
    if (m_ClothCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_CLOTHING;
    if (m_PickCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_PICKS;
    if (m_ProbeCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_PROBES;
    if (m_MiscCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_MISC;
    if (m_SpellCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_SPELLS;
    if (m_MagicCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_MAGICITEMS;
    if (m_RepairCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_REPAIR;
    if (m_IngreCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_INGREDIANTS;
    if (m_SpellmakeCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_SPELLMAKING;
    if (m_EnchantCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_ENCHANTING;
    if (m_RepairsItemsCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_REPAIRITEM;
    if (m_TrainCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_TRAINING;
    if (m_PotionCheck.GetCheck()) pAiData->Flags |= MWESM_CLASSAUTO_POTIONS;
   }

 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage5::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage5 Method - CMWEditDoc* GetDocument (void);
 *
 *=========================================================================*/
CMWEditDoc* CEsmNpcPage5::GetDocument (void) {
  DEFINE_FUNCTION("CEsmNpcPage5::GetDocument()");
  ASSERT(m_pDlgHandler != NULL);
  return m_pDlgHandler->GetDocument();
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage5::GetDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage5 Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmNpcPage5::OnInitDialog() {
  CPropertyPage::OnInitDialog();

  m_GoldText.SetLimitText(16);  	
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage5::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage5 Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmNpcPage5::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage5::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage5 Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmNpcPage5::SetControlData (void) {
  CEsmNpc*  	  pNpc;
  aidata_t*	  pAiData;
  CString	  Buffer;
  CEsmSubPos6*	  pDoorData;
  CEsmSubRecord*  pCellName;
  int		  ArrayIndex;
  int		  Count;
  
  if (m_pRecInfo == NULL || m_pDlgHandler == NULL) return;
  pNpc = (CEsmNpc *) m_pRecInfo->pRecord;
  pAiData = pNpc->GetAIData();

	/* Gold */
  Buffer.Format(_T("%ld"), pNpc->GetGold());
  m_GoldText.SetWindowText(Buffer);

	/* Flags */
  if (!pNpc->IsAutoCalc() && pAiData != NULL) {
    m_ApparatusCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_APPARATUS) != 0);
    m_WeaponCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_WEAPONS) != 0);
    m_ArmorCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_ARMOR) != 0);
    m_LightCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_LIGHTS) != 0);
    m_BookCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_BOOKS) != 0);
    m_ClothCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_CLOTHING) != 0);
    m_PickCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_PICKS) != 0);
    m_ProbeCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_PROBES) != 0);
    m_MiscCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_MISC) != 0);
    m_SpellCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_SPELLS) != 0);
    m_MagicCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_MAGICITEMS) != 0);
    m_RepairCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_REPAIR) != 0);
    m_IngreCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_INGREDIANTS) != 0);
    m_SpellmakeCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_SPELLMAKING) != 0);
    m_EnchantCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_ENCHANTING) != 0);
    m_RepairsItemsCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_REPAIRITEM) != 0);
    m_TrainCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_TRAINING) != 0);
    m_PotionCheck.SetCheck((pAiData->Flags & MWESM_CLASSAUTO_POTIONS) != 0);
   }
  else {
    UpdateAutoCalc(true);
   }

	/* Cell names */
  m_CellList1.SetWindowText(pNpc->GetTravelCell(0));
  m_CellList2.SetWindowText(pNpc->GetTravelCell(1));
  m_CellList3.SetWindowText(pNpc->GetTravelCell(2));
  m_CellList4.SetWindowText(pNpc->GetTravelCell(3));
  /*
  
  pDoorData = (CEsmSubPos6 *) pNpc->FindFirst(MWESM_SUBREC_DODT, ArrayIndex);
  Count = 0;

  while (pDoorData != NULL) {
    pCellName = pNpc->GetSubRecord(ArrayIndex + 1);

    if (pCellName != NULL && pCellName->IsType(MWESM_SUBREC_DNAM)) {
      Buffer.Format(_T("%s"), ((CEsmSubName *)pCellName)->GetName());
     }
    else {
      Buffer.Format(_T("%.0g, %.0g, %.0g"), pDoorData->GetPosData()->PosX, pDoorData->GetPosData()->PosY, pDoorData->GetPosData()->PosZ);
     }
    
    switch (Count) {
      case 0: m_CellList1.SetWindowText(Buffer); break;
      case 1: m_CellList2.SetWindowText(Buffer); break;
      case 2: m_CellList3.SetWindowText(Buffer); break;
      case 3: m_CellList4.SetWindowText(Buffer); break;
     }

    pDoorData = (CEsmSubPos6 *) pNpc->FindNext(MWESM_SUBREC_DODT, ArrayIndex);
    Count++;
   } //*/

 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage5::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage5 Method - void UpdateAutoCalc (AutoCalc);
 *
 *=========================================================================*/
void CEsmNpcPage5::UpdateAutoCalc (const bool AutoCalc) {
  m_ApparatusCheck.EnableWindow(!AutoCalc);
  m_ArmorCheck.EnableWindow(!AutoCalc);
  m_ClothCheck.EnableWindow(!AutoCalc);
  m_ProbeCheck.EnableWindow(!AutoCalc);
  m_PickCheck.EnableWindow(!AutoCalc);
  m_PotionCheck.EnableWindow(!AutoCalc);
  m_WeaponCheck.EnableWindow(!AutoCalc);
  m_MagicCheck.EnableWindow(!AutoCalc);
  m_ApparatusCheck.EnableWindow(!AutoCalc);
  m_RepairCheck.EnableWindow(!AutoCalc);
  m_MiscCheck.EnableWindow(!AutoCalc);
  m_BookCheck.EnableWindow(!AutoCalc);
  m_SpellCheck.EnableWindow(!AutoCalc);
  m_IngreCheck.EnableWindow(!AutoCalc);
  m_LightCheck.EnableWindow(!AutoCalc);
  m_EnchantCheck.EnableWindow(!AutoCalc);
  m_SpellmakeCheck.EnableWindow(!AutoCalc);
  m_RepairsItemsCheck.EnableWindow(!AutoCalc);
  m_TrainCheck.EnableWindow(!AutoCalc);

 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage5::UpdateAutoCalc()
 *=========================================================================*/
