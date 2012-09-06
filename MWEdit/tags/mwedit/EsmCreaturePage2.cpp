/*===========================================================================
 *
 * File:	Esmcreaturepage2.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	March 1, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmCreaturePage2.h"
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

  IMPLEMENT_DYNCREATE(CEsmCreaturePage2, CPropertyPage);
  DEFINE_FILE("EsmCreaturePage2.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Spell List Column Data
 *
 *=========================================================================*/
static esmcoldata_t l_SpellColData[] = {
	{  _T("ID"),		ESM_FIELD_ID,		LVCFMT_LEFT,	ESMLIST_WIDTH_ID,	ESMLIST_SUBITEM_ID,	NULL }, 
	{  _T("Count"),		ESM_FIELD_COUNT,	LVCFMT_CENTER,	ESMLIST_WIDTH_COUNT,	ESMLIST_SUBITEM_COUNT }, 
	{  _T("Mod"),		ESM_FIELD_CHANGED,	LVCFMT_CENTER,	ESMLIST_WIDTH_CHANGED,	ESMLIST_SUBITEM_CHANGED }, 
	{  _T("Name"),		ESM_FIELD_NAME,		LVCFMT_LEFT,	ESMLIST_WIDTH_NAME,	ESMLIST_SUBITEM_NAME }, 
	{  _T("Type"),		ESM_FIELD_TYPE,		LVCFMT_CENTER,	ESMLIST_WIDTH_TYPE,	ESMLIST_SUBITEM_TYPE },
	{  _T("Cost"),		ESM_FIELD_COST,		LVCFMT_CENTER,	ESMLIST_WIDTH_COST,	ESMLIST_SUBITEM_COST },
	{  _T("AutoCalc"),	ESM_FIELD_AUTOCALC,	LVCFMT_CENTER,	ESMLIST_WIDTH_AUTOCALC,	ESMLIST_SUBITEM_AUTOCALC }, 
	{  _T("PCStart"),	ESM_FIELD_PCSTART,	LVCFMT_CENTER,	ESMLIST_WIDTH_PCSTART,	ESMLIST_SUBITEM_PCSTART }, 
	{  _T("Blocked"),	ESM_FIELD_BLOCKED,	LVCFMT_CENTER,	ESMLIST_WIDTH_BLOCKED,	ESMLIST_SUBITEM_BLOCKED },
	{ NULL, 0, 0, 0 }	/* Must be last record */
 };
/*===========================================================================
 *		End of Spell List Column Data
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmCreaturePage2 Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmCreaturePage2, CPropertyPage)
  //{{AFX_MSG_MAP(CEsmCreaturePage2)
  ON_MESSAGE(ESMLIST_NOTIFY_ONDROP, OnRecordDrop)
  ON_MESSAGE(ESMLIST_NOTIFY_ONKEY, OnRecordKey)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmCreaturePage2 Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage2 Constructor
 *
 *=========================================================================*/
CEsmCreaturePage2::CEsmCreaturePage2() : CPropertyPage(CEsmCreaturePage2::IDD) {
  //{{AFX_DATA_INIT(CEsmCreaturePage2)
  //}}AFX_DATA_INIT
  m_pRecInfo    = NULL;
  m_pDlgHandler = NULL;
 }
/*===========================================================================
 *		End of Class CEsmCreaturePage2 Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage2 Destructor
 *
 *=========================================================================*/
CEsmCreaturePage2::~CEsmCreaturePage2() {
 }
/*===========================================================================
 *		End of Class CEsmCreaturePage2 Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage2 Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmCreaturePage2::DoDataExchange(CDataExchange* pDX) {
  CPropertyPage::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmCreaturePage2)
  DDX_Control(pDX, IDC_ITEMLIST, m_SpellList);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmCreaturePage2::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage2 Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmCreaturePage2::GetControlData (void) {
  CEsmCreature*   pCreature;
  CEsmSubNPCS*    pSpellName;
  esmrecinfo_t*   pRecInfo;
  int		  ListIndex;
  
  if (m_pRecInfo == NULL || m_pDlgHandler == NULL) return;
  pCreature = (CEsmCreature *) m_pRecInfo->pRecord;

	/* Delete all current spell records */
  pCreature->DeleteSubRecords(MWESM_SUBREC_NPCS);

	/* Add all the new spell ID records */
  for (ListIndex = 0; ListIndex < m_SpellList.GetItemCount(); ListIndex++) {
    pRecInfo = m_SpellList.GetRecInfo(ListIndex);
    pSpellName = (CEsmSubNPCS *) pCreature->AllocateSubRecord(MWESM_SUBREC_NPCS);
    pSpellName->CreateNew();
    pSpellName->SetName(pRecInfo->pRecord->GetID());
   }
 
 }
/*===========================================================================
 *		End of Class Method CEsmCreaturePage2::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage2 Method - CMWEditDoc* GetDocument (void);
 *
 *=========================================================================*/
CMWEditDoc* CEsmCreaturePage2::GetDocument (void) {
  DEFINE_FUNCTION("CEsmCreaturePage2::GetDocument()");
  ASSERT(m_pDlgHandler != NULL);
  return m_pDlgHandler->GetDocument();
 }
/*===========================================================================
 *		End of Class Method CEsmCreaturePage2::GetDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage2 Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmCreaturePage2::OnInitDialog() {
  CPropertyPage::OnInitDialog();

	/* Spell List */
  m_SpellList.OnInitCtrl();
  m_SpellList.SetDlgHandler(m_pDlgHandler);
  m_SpellList.SetEnableDrag(true);
  m_SpellList.SetAcceptDrag(true);
  m_SpellList.SetWantKeys(true);
  m_SpellList.InitObjectList(&l_SpellColData[0]);
	
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmCreaturePage2::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage2 Event - LRESULT OnRecordDrop (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmCreaturePage2::OnRecordDrop (LPARAM lParam, LPARAM wParam) {
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
 *		End of Class Event CEsmCreaturePage2::OnRecordDrop()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage2 Event - LRESULT OnRecordKey (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmCreaturePage2::OnRecordKey (LPARAM lParam, LPARAM wParam) {
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
 *		End of Class Event CEsmCreaturePage2::OnRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage2 Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmCreaturePage2::OnUpdateItem (esmrecinfo_t* pRecInfo) {

  	/* Refill the script list if required */
  if (pRecInfo->pRecord->IsType(MWESM_REC_SPEL)) {
    m_SpellList.UpdateItem(pRecInfo);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmCreaturePage2::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreaturePage2 Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmCreaturePage2::SetControlData (void) {
  CEsmCreature*   pCreature;
  CEsmSubNPCS*    pSpellName;
  esmrecinfo_t*   pRecInfo;
  int		  ArrayIndex;
  
  if (m_pRecInfo == NULL || m_pDlgHandler == NULL) return;
  m_SpellList.SetDlgHandler(m_pDlgHandler);
  pCreature = (CEsmCreature *) m_pRecInfo->pRecord;

  pSpellName = (CEsmSubNPCS *) pCreature->FindFirst(MWESM_SUBREC_NPCS, ArrayIndex);

  while (pSpellName != NULL) {
    pRecInfo = GetDocument()->FindRecord(pSpellName->GetName());
    if (pRecInfo != NULL) m_SpellList.AddItem(pRecInfo);
    pSpellName = (CEsmSubNPCS *) pCreature->FindNext(MWESM_SUBREC_NPCS, ArrayIndex);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmCreaturePage2::SetControlData()
 *=========================================================================*/
