/*===========================================================================
 *
 * File:	Esmdlgarray.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 8, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "EsmDlgArray.h"
#include "ActivatorDlg.h"
#include "EsmAlchemyDlg.h"
#include "EsmApparatusDlg.h"
#include "EsmArmorDlg.h"
#include "EsmBirthSignDlg.h"
#include "EsmBodyPartDlg.h"
#include "EsmBookDlg.h"
#include "EsmCellDlg.h"
#include "EsmClassDlg.h"
#include "EsmClothingDlg.h"
#include "EsmContainDlg.h"
#include "EsmCreatureDlg.h"
#include "EsmDialogDlg.h"
#include "EsmDoorDlg.h"
#include "EsmEffectDlg.h"
#include "EsmEnchantDlg.h"
#include "EsmFactionDlg.h"
#include "EsmGlobalDlg.h"
#include "EsmIngrediantDlg.h"
#include "EsmLevelCreaDlg.h"
#include "EsmLevelItemDlg.h"
#include "EsmLightDlg.h"
#include "EsmLockPickDlg.h"
#include "EsmMiscDlg.h"
#include "EsmNpcDlg.h"
#include "EsmProbeDlg.h"
#include "EsmRaceDlg.h"
#include "EsmRegionDlg.h"
#include "EsmRepairDlg.h"
#include "EsmScriptDlg.h"
#include "EsmSettingDlg.h"
#include "EsmSkillDlg.h"
#include "EsmSoundDlg.h"
#include "EsmSoundGenDlg.h"
#include "EsmSpellDlg.h"
#include "EsmStartScriptDlg.h"
#include "EsmStaticDlg.h"
#include "EsmWeaponDlg.h"
#include "ChildFrm.h"
#include "ChildFrmFix.h"
#include "ChildFrmVar.h"
#include "MWEditDoc.h"
#include "EsmFindDlg.h"
#include "ChildFrmScript.h"
#include "EsmUsesDlg.h"
#include "EsmScrTempView.h"
#include "EsmScriptCompareDlg.h"
//#include "mmsystem.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("EsmDlgArray.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Dialog Creation Array
 *
 *=========================================================================*/
static esmdlgcreateinfo_t l_EsmDlgCreateInfo[] = {
	{ MWESM_REC_ACTI, _T("Activator"),	CEsmActivatorDlg::IDD,	RUNTIME_CLASS(CEsmActivatorDlg),	RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_ALCH, _T("Alchemy"),	CEsmAlchemyDlg::IDD,	RUNTIME_CLASS(CEsmAlchemyDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_APPA, _T("Apparatus"),	CEsmApparatusDlg::IDD,	RUNTIME_CLASS(CEsmApparatusDlg),	RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_ARMO, _T("Armor"),		CEsmArmorDlg::IDD,	RUNTIME_CLASS(CEsmArmorDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_BSGN, _T("Birth Sign"),	CEsmBirthSignDlg::IDD,	RUNTIME_CLASS(CEsmBirthSignDlg),	RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_BODY, _T("Body Part"),	CEsmBodyPartDlg::IDD,	RUNTIME_CLASS(CEsmBodyPartDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_BOOK, _T("Book"),		CEsmBookDlg::IDD,	RUNTIME_CLASS(CEsmBookDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_CELL, _T("Cell"),		CEsmCellDlg::IDD,	RUNTIME_CLASS(CEsmCellDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_CLAS, _T("Class"),		CEsmClassDlg::IDD,	RUNTIME_CLASS(CEsmClassDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_CLOT, _T("Clothing"),	CEsmClothingDlg::IDD,	RUNTIME_CLASS(CEsmClothingDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_CONT, _T("Container"),	CEsmContainDlg::IDD,	RUNTIME_CLASS(CEsmContainDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_CREA, _T("Creature"),	CEsmCreatureDlg::IDD,	RUNTIME_CLASS(CEsmCreatureDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_DIAL, _T("Dialogue"),	CEsmDialogDlg::IDD,	RUNTIME_CLASS(CEsmDialogDlg),		RUNTIME_CLASS(CChildFrameVar),	CEsmDlgHandler::CreateDialogueDlg },
	{ MWESM_REC_DOOR, _T("Door"),		CEsmDoorDlg::IDD,	RUNTIME_CLASS(CEsmDoorDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_ENCH, _T("Enchant"),	CEsmEnchantDlg::IDD,	RUNTIME_CLASS(CEsmEnchantDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_FACT, _T("Faction"),	CEsmFactionDlg::IDD,	RUNTIME_CLASS(CEsmFactionDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_GLOB, _T("Global"),		CEsmGlobalDlg::IDD,	RUNTIME_CLASS(CEsmGlobalDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_INGR, _T("Ingredient"),	CEsmIngrediantDlg::IDD,	RUNTIME_CLASS(CEsmIngrediantDlg),	RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_LEVC, _T("Level Creature"),	CEsmLevelCreaDlg::IDD,	RUNTIME_CLASS(CEsmLevelCreaDlg),	RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_LEVI, _T("Level Item"),	CEsmLevelItemDlg::IDD,	RUNTIME_CLASS(CEsmLevelItemDlg),	RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_LIGH, _T("Light"),		CEsmLightDlg::IDD,	RUNTIME_CLASS(CEsmLightDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_LOCK, _T("Lock Pick"),	CEsmLockPickDlg::IDD,	RUNTIME_CLASS(CEsmLockPickDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_MGEF, _T("Magic Effect"),	CEsmEffectDlg::IDD,	RUNTIME_CLASS(CEsmEffectDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_MISC, _T("Misc"),		CEsmMiscDlg::IDD,	RUNTIME_CLASS(CEsmMiscDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_NPC_, _T("NPC"),		CEsmNpcDlg::IDD,	RUNTIME_CLASS(CEsmNpcDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_RACE, _T("Race"),		CEsmRaceDlg::IDD,	RUNTIME_CLASS(CEsmRaceDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_PROB, _T("Probe"),		CEsmProbeDlg::IDD,	RUNTIME_CLASS(CEsmProbeDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_RACE, _T("Race"),		CEsmRaceDlg::IDD,	RUNTIME_CLASS(CEsmRaceDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_REGN, _T("Region"),		CEsmRegionDlg::IDD,	RUNTIME_CLASS(CEsmRegionDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_REPA, _T("Repair"),		CEsmRepairDlg::IDD,	RUNTIME_CLASS(CEsmRepairDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_SCPT, _T("Script"),		CEsmScriptDlg::IDD,	RUNTIME_CLASS(CEsmScriptDlg),		RUNTIME_CLASS(CChildFrmScript),	NULL },
	{ MWESM_REC_GMST, _T("Setting"),	CEsmSettingDlg::IDD,	RUNTIME_CLASS(CEsmSettingDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_SKIL, _T("Skill"),		CEsmSkillDlg::IDD,	RUNTIME_CLASS(CEsmSkillDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_SOUN, _T("Sound"),		CEsmSoundDlg::IDD,	RUNTIME_CLASS(CEsmSoundDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_SNDG, _T("Sound Gen"),	CEsmSoundGenDlg::IDD,	RUNTIME_CLASS(CEsmSoundGenDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_SPEL, _T("Spell"),		CEsmSpellDlg::IDD,	RUNTIME_CLASS(CEsmSpellDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_SSCR, _T("Start Script"),	CEsmStartScriptDlg::IDD,RUNTIME_CLASS(CEsmStartScriptDlg),	RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_STAT, _T("Static"),		CEsmStaticDlg::IDD,	RUNTIME_CLASS(CEsmStaticDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ MWESM_REC_WEAP, _T("Weapon"),		CEsmWeaponDlg::IDD,	RUNTIME_CLASS(CEsmWeaponDlg),		RUNTIME_CLASS(CChildFrameFix),	NULL },
	{ NULL, NULL, NULL }	/* Must be last record */
 };

static esmdlgcreateinfo_t l_EsmFindCreateInfo = {
	NULL, _T("Find Text"), CEsmFindDlg::IDD,	RUNTIME_CLASS(CEsmFindDlg),	RUNTIME_CLASS(CChildFrameFix),	NULL
 };

static esmdlgcreateinfo_t l_EsmUsesCreateInfo = {
	NULL, _T("Uses"), CEsmUsesDlg::IDD,	RUNTIME_CLASS(CEsmUsesDlg),	RUNTIME_CLASS(CChildFrameFix),	NULL
 };

static esmdlgcreateinfo_t l_EsmScriptCompareCreateInfo = {
	NULL, _T("Script Comparison"), CEsmScriptCompareDlg::IDD,	RUNTIME_CLASS(CEsmScriptCompareDlg),	RUNTIME_CLASS(CChildFrameFix),	NULL
 };

static esmdlgcreateinfo_t l_EsmScrTempCreateInfo = {
	NULL, _T("Script Template"), CEsmScrTempView::IDD,	RUNTIME_CLASS(CEsmScrTempView),	RUNTIME_CLASS(CChildFrameFix),	NULL
 };
/*===========================================================================
 *		End of Dialog Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Constructor
 *
 *=========================================================================*/
CEsmDlgHandler::CEsmDlgHandler () : m_Frames(0) {
  //DEFINE_FUNCTION("CEsmDlgHandler::CEsmDlgHandler()");
  m_pDocument    = NULL;
  m_pFindDlg     = NULL;
  m_pUsesDlg     = NULL;
  m_pMainFrame   = NULL;
  m_pScrTempDlg  = NULL;
  m_pScriptCompareDlg = NULL;
 }
/*===========================================================================
 *		End of Class CEsmDlgHandler Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Method - void Destroy (void);
 *
 *=========================================================================*/
void CEsmDlgHandler::Destroy (void) {
  //DEFINE_FUNCTION("CEsmDlgHandler::Destroy()");
  ClearDlgArray();
 }
/*===========================================================================
 *		End of Class Method CEsmDlgHandler::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Method - void ClearDlgArray (void);
 *
 * Deletes all dialogs current in the dialog array as well as any special
 * dialogs currently open.
 *
 *=========================================================================*/
void CEsmDlgHandler::ClearDlgArray (void) {
  DEFINE_FUNCTION("CEsmDlgHandler::ClearDlgArray()");
  CFrameWnd* pFrame;
  
	/* Close and delete any dialogs in the array */
  while (m_Frames.GetSize() > 0) {
    pFrame = m_Frames.GetAt(0);
    m_Frames.RemoveAt(0);
    pFrame->CloseWindow();
    pFrame->DestroyWindow();
   }

	/* Close the find/uses dialog if required */
  if (m_pFindDlg != NULL) {
    m_pFindDlg->DestroyWindow();
    m_pFindDlg = NULL;
   }

  if (m_pUsesDlg != NULL) {
    m_pUsesDlg->DestroyWindow();
    m_pUsesDlg = NULL;
   }

  if (m_pScrTempDlg != NULL) {
    m_pScrTempDlg->DestroyWindow();
    m_pScrTempDlg = NULL;
   }

  if (m_pScriptCompareDlg != NULL) {
    m_pScriptCompareDlg->DestroyWindow();
    m_pScriptCompareDlg = NULL;
  }

 }
/*===========================================================================
 *		End of Class Method CEsmDlgHandler::ClearDlgArray()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Method - CEsmRecord* CreateCopy (pRecord);
 *
 *=========================================================================*/
CEsmRecord* CEsmDlgHandler::CreateCopy (CEsmRecord* pRecord) {
  CEsmRecord* pNewRecord;

  ASSERT(m_pDocument != NULL);
  pNewRecord = m_pDocument->CreateCopy(pRecord);
  return (pNewRecord);
 }
/*===========================================================================
 *		End of Class Method CEsmDlgHandler::CreateCopy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Method - CFrameWnd* CreateDialogueDlg (void);
 *
 * Creates and returns the window for editting a dialogue topic.
 *
 *=========================================================================*/
CFrameWnd* CEsmDlgHandler::CreateDialogueDlg (esmrecinfo_t* pRecInfo) {
  CEsmDialogue*  pDialogue;
  CCreateContext Context;
  CFrameWnd*     pFrame;

	/* Get the dialog object */
  pDialogue = (CEsmDialogue *) pRecInfo->pRecord;

	/* Initialize the context structure */
  Context.m_pCurrentDoc     = m_pDocument;
  Context.m_pCurrentFrame   = NULL;
  Context.m_pNewDocTemplate = NULL;
  Context.m_pLastView       = NULL;

	/* Create the dialog parent frame */  
  pFrame = (CFrameWnd*) (RUNTIME_CLASS(CChildFrameVar)->CreateObject());
  ASSERT_KINDOF(CFrameWnd, pFrame);

	/* Create formview new from resource depending on the dialog type */
  if (pDialogue->GetDialogTypeID() == MWESM_DIALTYPE_JOURNAL) {
    Context.m_pNewViewClass = RUNTIME_CLASS(CEsmDialogDlg);
    pFrame->LoadFrame(CEsmDialogDlg::IDD, WS_OVERLAPPEDWINDOW, NULL, &Context);
   }
  else {
    Context.m_pNewViewClass = RUNTIME_CLASS(CEsmDialogDlg);
    pFrame->LoadFrame(CEsmDialogDlg::IDD, WS_OVERLAPPEDWINDOW, NULL, &Context);
   }

  return (pFrame);      
 }
/*===========================================================================
 *		End of Class Method CEsmDlgHandler::CreateDialogueDlg()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Method - CFrameWnd* CreateESMDialog (CreateInfo);
 *
 * Protected class method which uses the given record of the local create 
 * array to make and return a new dialog.
 *
 *=========================================================================*/
CFrameWnd* CEsmDlgHandler::CreateESMDialog (esmdlgcreateinfo_t& CreateInfo) {
  CCreateContext Context;
  CFrameWnd*     pFrame;

	/* Initialize the context structure */
  Context.m_pCurrentDoc     = m_pDocument;
  Context.m_pCurrentFrame   = NULL;
  Context.m_pNewDocTemplate = NULL;
  Context.m_pLastView       = NULL;

	/* Create the dialog parent frame */  
  Context.m_pNewViewClass = CreateInfo.pViewClass;
  pFrame = (CFrameWnd*) CreateInfo.pFrameClass->CreateObject();
  ASSERT_KINDOF(CFrameWnd, pFrame);

	/* Create form view new from resource */
  pFrame->LoadFrame(CreateInfo.ResourceID, WS_OVERLAPPEDWINDOW,
			NULL, &Context);
  return (pFrame);      
 }
/*===========================================================================
 *		End of Class Method CEsmDlgHandler::CreateESMDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Method - CFrameWnd* CreateDialog (pRecInfo, IsNew);
 *
 * Attempts to create a dialog for editting the given type.  Returns
 * NULL if it cannot.  Adds the frame to the class array and updates
 * the new CEsmRecView.  Does not display the frame. 
 *
 *=========================================================================*/
CFrameWnd* CEsmDlgHandler::CreateESMDialog (esmrecinfo_t* pRecInfo, const bool IsNew) {
  CFrameWnd*     pFrame;
  CEsmRecDialog* pView;
  CEsmRecord*    pRecord = pRecInfo->pRecord;
  CWnd*	  	 pWnd;
  int		 Index;

  for (Index = 0; l_EsmDlgCreateInfo[Index].pViewClass != NULL; Index++) {

    if (pRecord->IsType(l_EsmDlgCreateInfo[Index].Type)) {

		/* Use default or custom frame creation routine */
      if (l_EsmDlgCreateInfo[Index].CreateFunc == NULL)
        pFrame = CreateESMDialog(l_EsmDlgCreateInfo[Index]);
      else
        pFrame = (this->*(l_EsmDlgCreateInfo[Index].CreateFunc))(pRecInfo);
      
		/* Attempt to initialize the new view */
      pWnd = pFrame->GetDescendantWindow(AFX_IDW_PANE_FIRST, TRUE);

      if (pWnd != NULL && pWnd->IsKindOf(RUNTIME_CLASS(CEsmRecDialog)))	{
        pView = (CEsmRecDialog *) pWnd;
        pView->SetRecInfo(pRecInfo);
	pView->SetIsNew(IsNew);
	pView->SetParent(this);
	
        if (pRecord->IsType(MWESM_REC_DIAL))
          pView->SetTitle(pRecord->GetItemType());
	else
	  pView->SetTitle(l_EsmDlgCreateInfo[Index].pTitle);
       }

      m_Frames.Add(pFrame);
      return (pFrame);
     }
   }

	/* No matching dialog found */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CEsmDlgHandler::CreateESMDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Method - bool EditRecord (pRecInfo, IsNew);
 *
 * Display a dialog to edit the given item.  The current dialogs that are
 * open and checked to see if the item is already being editted.  If it 
 * is, the dialog is activated.  Otherwise a new dialog is created and
 * displayed to edit the item.
 *
 *=========================================================================*/
bool CEsmDlgHandler::EditRecord (esmrecinfo_t* pRecInfo, const bool IsNew) {
  CFrameWnd* pFrame;

	/* See if item is already being editted */
  pFrame = FindDialog(pRecInfo);

	/* Create a new dialog to edit the item */
  if (pFrame == NULL) {
    pFrame = CreateESMDialog(pRecInfo, IsNew);

    if (pFrame != NULL) {
      pFrame->InitialUpdateFrame(NULL, TRUE);
      pFrame->ActivateFrame(SW_SHOWNORMAL);
     }
    else {
      ErrorHandler.AddError(ERR_BADINPUT, _T("No edit dialog defined for '%4.4s' records!"), pRecInfo->pRecord->GetType());
      return (false);
     }
   }
  else {
    pFrame->ActivateFrame(SW_RESTORE);
   }  
  
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmDlgHandler::EditRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Method - CFrameWnd* FindDialog (pRecInfo);
 *
 * Find an existing record frame. Returns NULL if no open dialog is found.
 *
 *=========================================================================*/
CFrameWnd* CEsmDlgHandler::FindDialog (esmrecinfo_t* pRecInfo) {
  CEsmRecDialog* pView;
  CFrameWnd*	 pFrame;
  int		 Index;

	/* Close and delete any dialogs in the array */
  for (Index = 0; Index < m_Frames.GetSize(); Index++) {
    pFrame = m_Frames.GetAt(Index);
    pView = (CEsmRecDialog *) pFrame->GetActiveView();

    if (pView != NULL && pView->IsKindOf(RUNTIME_CLASS(CEsmRecDialog))) {
      if (pView->IsRecord(pRecInfo)) return pFrame;
     }
   }

	/* Nothing found */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CEsmDlgHandler::FindDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TCHAR* CEsmDlgHandler Method - const GetDocFilename (void);
 *
 *=========================================================================*/
const TCHAR* CEsmDlgHandler::GetDocFilename (void) {
  ASSERT(m_pDocument != NULL);
  return (m_pDocument->GetTitle());
 }

CEsmFile* CEsmDlgHandler::GetActiveFile (void) {
  ASSERT(m_pDocument != NULL);
  return (m_pDocument->GetActivePlugin());
 }
/*===========================================================================
 *		End of Class Method TCHAR* CEsmDlgHandler::GetDocFilename()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Method - esmrecinfo_t* GetEffectRecord (EffectID);
 *
 *=========================================================================*/
esmrecinfo_t* CEsmDlgHandler::GetEffectRecord (const int EffectID) {
  ASSERT(m_pDocument != NULL);
  return m_pDocument->GetEffectRecord(EffectID);
 }
/*===========================================================================
 *		End of Class Method CEsmDlgHandler::GetEffectRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Method - bool IsValidID (pID);
 *
 *=========================================================================*/
bool CEsmDlgHandler::IsValidID (const TCHAR* pID) {
  return IsValidESMID(pID);
 }


bool CEsmDlgHandler::IsExistingID (const TCHAR* pID) {
  esmrecinfo_t* pRecInfo;
  ASSERT(m_pDocument != NULL);

  pRecInfo = m_pDocument->FindRecord(pID);
  return (pRecInfo != NULL);
 }
/*===========================================================================
 *		End of Class Method CEsmDlgHandler::IsValidID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Event - CEsmRecord* OnAddNew (pType);
 *
 *=========================================================================*/
CEsmRecord* CEsmDlgHandler::OnAddNew (const TCHAR* pType) {
  DEFINE_FUNCTION("CEsmDlgHandler::OnAddNew()");
  CEsmRecord*   pRecord;
  esmrecinfo_t* pRecInfo;
  bool		Result;

	/* Ensure a valid object state */
  if (m_pDocument == NULL) return (NULL);

	/* Create the new record */
  pRecord = m_pDocument->CreateNewRecord(pType);
  if (pRecord == NULL) return (NULL);

	/* Create the new recinfo object */
  CreatePointer(pRecInfo, esmrecinfo_t);
  pRecInfo->pFile   = m_pDocument->GetActivePlugin();
  pRecInfo->pRecord = pRecord;
  pRecord->SetFile(pRecInfo->pFile);

	/* Attempt to display the edit dialog for the record */
  Result = EditRecord(pRecInfo, true);

	/* Delete the objects if we couldn't display the edit dialog */
  if (!Result) {
    DestroyPointer(pRecInfo);
    DestroyPointer(pRecord);
   }
  
  return (pRecord);
 }
/*===========================================================================
 *		End of Class Event CEsmDlgHandler::OnAddNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Event - CEsmRecord* OnAddNewDialog (DialType);
 *
 *=========================================================================*/
CEsmRecord* CEsmDlgHandler::OnAddNewDialog (const int DialType) {
  DEFINE_FUNCTION("CEsmDlgHandler::OnAddNewDialog()");
  CEsmRecord*   pRecord;
  esmrecinfo_t* pRecInfo;
  bool		Result;

	/* Ensure a valid object state */
  if (m_pDocument == NULL) return (NULL);

	/* Create the new record */
  pRecord = m_pDocument->CreateNewRecord(MWESM_REC_DIAL);
  if (pRecord == NULL) return (NULL);
  ((CEsmDialogue *)pRecord)->SetDialogType(DialType);

	/* Create the new recinfo object */
  CreatePointer(pRecInfo, esmrecinfo_t);
  pRecInfo->pFile   = m_pDocument->GetActivePlugin();
  pRecInfo->pRecord = pRecord;
  pRecord->SetFile(pRecInfo->pFile);

	/* Attempt to display the edit dialog for the record */
  Result = EditRecord(pRecInfo, true);
  
	/* Delete the objects if we couldn't display the edit dialog */
  if (!Result) {
    DestroyPointer(pRecInfo);
    DestroyPointer(pRecord);
   }
  
  return (pRecord);
 }
/*===========================================================================
 *		End of Class Event CEsmDlgHandler::OnAddNewDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Event - int OnPostSaveRecord (pRecEditInfo);
 *
 * Called after an item has been changed.
 *
 *=========================================================================*/
int CEsmDlgHandler::OnPostSaveRecord (esmreceditinfo_t* pRecEditInfo) {
  ASSERT(m_pDocument != NULL);
  return m_pDocument->OnPostSaveRecord(pRecEditInfo);
 }
/*===========================================================================
 *		End of Class Event CEsmDlgHandler::OnPostSaveRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Event - int OnPreSaveRecord (pRecEditInfo);
 *
 * Called by the ESM record dialogs before any changes are saved to the
 * record in the given structure.  The record is copied into the current
 * active plugin if required.
 *
 *=========================================================================*/
int CEsmDlgHandler::OnPreSaveRecord (esmreceditinfo_t* pRecEditInfo) {
  ASSERT(m_pDocument != NULL);
  return m_pDocument->OnPreSaveRecord(pRecEditInfo);
 }
/*===========================================================================
 *		End of Class Event CEsmDlgHandler::OnPreSaveRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Method - void OpenFindDlg (void);
 *
 * Creates if nessecary, and displays the find window.
 *
 *=========================================================================*/
void CEsmDlgHandler::OpenFindDlg (void) {
  CEsmFindDlg*   pFindView;
  CWnd*	  	 pWnd;

	/* Just active the existing find window */
  if (m_pFindDlg != NULL) {
    m_pFindDlg->ActivateFrame(SW_RESTORE);
    return;
   } 

	/* Attempt to create the frame/formview */
  m_pFindDlg = CreateESMDialog (l_EsmFindCreateInfo);
  if (m_pFindDlg == NULL) return;

  	/* Attempt to initialize the new view */
  pWnd = m_pFindDlg->GetDescendantWindow(AFX_IDW_PANE_FIRST, TRUE);

  if (pWnd != NULL && pWnd->IsKindOf(RUNTIME_CLASS(CEsmFindDlg))) {
    pFindView = (CEsmFindDlg *) pWnd;
    pFindView->SetDlgHandler(this);
   }

  m_pFindDlg->InitialUpdateFrame(NULL, TRUE);
  m_pFindDlg->ActivateFrame(SW_SHOWNORMAL);
 }
/*===========================================================================
 *		End of Class Method CEsmDlgHandler::OpenFindDlg()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Method - void OpenScrTempDlg (void);
 *
 * Opens the script template form view.
 *
 *=========================================================================*/
void CEsmDlgHandler::OpenScrTempDlg (void) {
  CEsmScrTempView* pScrTempView;
  CWnd*	  	   pWnd;

	/* Just active the existing uses window */
  if (m_pScrTempDlg != NULL) {
    m_pScrTempDlg->ActivateFrame(SW_RESTORE);
    return;
   } 

	/* Attempt to create the frame/formview */
  m_pScrTempDlg = CreateESMDialog (l_EsmScrTempCreateInfo);
  if (m_pScrTempDlg == NULL) return;

  	/* Attempt to initialize the new view */
  pWnd = m_pScrTempDlg->GetDescendantWindow(AFX_IDW_PANE_FIRST, TRUE);

  if (pWnd != NULL && pWnd->IsKindOf(RUNTIME_CLASS(CEsmScrTempView))) {
    pScrTempView = (CEsmScrTempView *) pWnd;
    pScrTempView->SetDlgHandler(this);
    pScrTempView->SetDocument(GetDocument());
   }

  m_pScrTempDlg->InitialUpdateFrame(NULL, TRUE);
  m_pScrTempDlg->ActivateFrame(SW_SHOWNORMAL);
 }
/*===========================================================================
 *		End of Class Method CEsmDlgHandler::OpenScrTempDlg()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Method - void OpenUsesDlg (pRecInfo);
 *
 * Creates if nessecary, and displays the uses window for the given record.
 *
 *=========================================================================*/
void CEsmDlgHandler::OpenUsesDlg (esmrecinfo_t* pRecInfo) {
  CEsmUsesDlg*   pUsesView;
  CWnd*	  	 pWnd;

	/* Just active the existing uses window */
  if (m_pUsesDlg != NULL) {
    m_pUsesDlg->ActivateFrame(SW_RESTORE);

    		/* Attempt to update the view */
    pWnd = m_pUsesDlg->GetDescendantWindow(AFX_IDW_PANE_FIRST, TRUE);

    if (pWnd != NULL && pWnd->IsKindOf(RUNTIME_CLASS(CEsmUsesDlg))) {
      pUsesView = (CEsmUsesDlg *) pWnd;
      pUsesView->SetDlgHandler(this);
      pUsesView->SetRecInfo(pRecInfo);
      pUsesView->UpdateUses();
     }

    return;
   } 

	/* Attempt to create the frame/formview */
  m_pUsesDlg = CreateESMDialog (l_EsmUsesCreateInfo);
  if (m_pUsesDlg == NULL) return;

  	/* Attempt to initialize the new view */
  pWnd = m_pUsesDlg->GetDescendantWindow(AFX_IDW_PANE_FIRST, TRUE);

  if (pWnd != NULL && pWnd->IsKindOf(RUNTIME_CLASS(CEsmUsesDlg))) {
    pUsesView = (CEsmUsesDlg *) pWnd;
    pUsesView->SetDlgHandler(this);
    pUsesView->SetRecInfo(pRecInfo);
   }

  m_pUsesDlg->InitialUpdateFrame(NULL, TRUE);
  m_pUsesDlg->ActivateFrame(SW_SHOWNORMAL);
  pUsesView->UpdateUses();
 }
/*===========================================================================
 *		End of Class Method CEsmDlgHandler::OpenUsesDlg()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Method - CEsmScriptCompareDlg* OpenScriptCompareDlg (void);
 *
 *=========================================================================*/
CEsmScriptCompareDlg* CEsmDlgHandler::OpenScriptCompareDlg (void) {
  CEsmScriptCompareDlg*   pCompareView = NULL;
  CWnd*	  		  pWnd;

	/* Just active the existing uses window */
  if (m_pScriptCompareDlg != NULL) {
    m_pScriptCompareDlg->ActivateFrame(SW_RESTORE);

    		/* Attempt to update the view */
    pWnd = m_pScriptCompareDlg->GetDescendantWindow(AFX_IDW_PANE_FIRST, TRUE);

    if (pWnd != NULL && pWnd->IsKindOf(RUNTIME_CLASS(CEsmScriptCompareDlg))) {
      pCompareView = (CEsmScriptCompareDlg *) pWnd;
      pCompareView->SetDlgHandler(this);
     }

    return (pCompareView);
   }

	/* Attempt to create the frame/formview */
  m_pScriptCompareDlg = CreateESMDialog (l_EsmScriptCompareCreateInfo);
  if (m_pScriptCompareDlg == NULL) return (NULL);

  	/* Attempt to initialize the new view */
  pWnd = m_pScriptCompareDlg->GetDescendantWindow(AFX_IDW_PANE_FIRST, TRUE);

  if (pWnd != NULL && pWnd->IsKindOf(RUNTIME_CLASS(CEsmScriptCompareDlg))) {
    pCompareView = (CEsmScriptCompareDlg *) pWnd;
    pCompareView->SetDlgHandler(this);
   }

  m_pScriptCompareDlg->InitialUpdateFrame(m_pDocument, TRUE);
  m_pScriptCompareDlg->ActivateFrame(SW_SHOWNORMAL);
  return (pCompareView);
 }
/*===========================================================================
 *		End of Class Method CEsmDlgHandler::OpenScriptCompareDlg()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDlgHandler Method - void RemoveFrame (pFrame);
 *
 * Removes the frame from the class array.
 *
 *=========================================================================*/
void CEsmDlgHandler::RemoveFrame (CFrameWnd* pFrame) {
  m_Frames.DeleteElement(pFrame);
 }
/*===========================================================================
 *		End of Class Method CEsmDlgHandler::RemoveFrame()
 *=========================================================================*/

