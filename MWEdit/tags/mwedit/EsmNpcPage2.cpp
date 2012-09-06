/*===========================================================================
 *
 * File:	Esmnpcpage2.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 23, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmNpcPage2.h"
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

  IMPLEMENT_DYNCREATE(CEsmNpcPage2, CPropertyPage);
  DEFINE_FILE("EsmNpcPage2.cpp");
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
 * Begin CEsmNpcPage2 Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmNpcPage2, CPropertyPage)
  //{{AFX_MSG_MAP(CEsmNpcPage2)
  ON_MESSAGE(ESMLIST_NOTIFY_ONDROP, OnRecordDrop)
  ON_MESSAGE(ESMLIST_NOTIFY_ONKEY, OnRecordKey)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmNpcPage2 Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage2 Constructor
 *
 *=========================================================================*/
CEsmNpcPage2::CEsmNpcPage2() : CPropertyPage(CEsmNpcPage2::IDD) {
  //{{AFX_DATA_INIT(CEsmNpcPage2)
  //}}AFX_DATA_INIT
  m_pRecInfo    = NULL;
  m_pDlgHandler = NULL;
 }
/*===========================================================================
 *		End of Class CEsmNpcPage2 Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage2 Destructor
 *
 *=========================================================================*/
CEsmNpcPage2::~CEsmNpcPage2() {
 }
/*===========================================================================
 *		End of Class CEsmNpcPage2 Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage2 Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmNpcPage2::DoDataExchange(CDataExchange* pDX) {
  CPropertyPage::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmNpcPage2)
   DDX_Control(pDX, IDC_ITEMLIST, m_SpellList);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage2::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage2 Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmNpcPage2::GetControlData (void) {
  CEsmNpc*  	  pNpc;
  CEsmSubNPCS*    pSpellName;
  esmrecinfo_t*   pRecInfo;
  int		  ListIndex;
  
  if (m_pRecInfo == NULL || m_pDlgHandler == NULL) return;
  pNpc = (CEsmNpc *) m_pRecInfo->pRecord;

	/* Delete all current spell records */
  pNpc->DeleteSubRecords(MWESM_SUBREC_NPCS);

	/* Add all the new spell ID records */
  for (ListIndex = 0; ListIndex < m_SpellList.GetItemCount(); ListIndex++) {
    pRecInfo = m_SpellList.GetRecInfo(ListIndex);
    pSpellName = (CEsmSubNPCS *) pNpc->AllocateSubRecord(MWESM_SUBREC_NPCS);
    pSpellName->CreateNew();
    pSpellName->SetName(pRecInfo->pRecord->GetID());
   }
 
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage2::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage2 Method - CMWEditDoc* GetDocument (void);
 *
 *=========================================================================*/
CMWEditDoc* CEsmNpcPage2::GetDocument (void) {
  DEFINE_FUNCTION("CEsmNpcPage2::GetDocument()");
  ASSERT(m_pDlgHandler != NULL);
  return m_pDlgHandler->GetDocument();
 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage2::GetDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage2 Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmNpcPage2::OnInitDialog() {
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
 *		End of Class Event CEsmNpcPage2::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage2 Event - LRESULT OnRecordDrop (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmNpcPage2::OnRecordDrop (LPARAM lParam, LPARAM wParam) {
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
 *		End of Class Event CEsmNpcPage2::OnRecordDrop()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage2 Event - LRESULT OnRecordKey (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmNpcPage2::OnRecordKey (LPARAM lParam, LPARAM wParam) {
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
 *		End of Class Event CEsmNpcPage2::OnRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage2 Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmNpcPage2::OnUpdateItem (esmrecinfo_t* pRecInfo) {

  	/* Refill the script list if required */
  if (pRecInfo->pRecord->IsType(MWESM_REC_SPEL)) {
    m_SpellList.UpdateItem(pRecInfo);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmNpcPage2::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcPage2 Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmNpcPage2::SetControlData (void) {
  CEsmNpc*  	  pNpc;
  CEsmSubNPCS*    pSpellName;
  esmrecinfo_t*   pRecInfo;
  int		  ArrayIndex;
  
  if (m_pRecInfo == NULL || m_pDlgHandler == NULL) return;
  m_SpellList.SetDlgHandler(m_pDlgHandler);
  pNpc = (CEsmNpc *) m_pRecInfo->pRecord;

  pSpellName = (CEsmSubNPCS *) pNpc->FindFirst(MWESM_SUBREC_NPCS, ArrayIndex);

  while (pSpellName != NULL) {
    pRecInfo = GetDocument()->FindRecord(pSpellName->GetName());
    if (pRecInfo != NULL) m_SpellList.AddItem(pRecInfo);
    pSpellName = (CEsmSubNPCS *) pNpc->FindNext(MWESM_SUBREC_NPCS, ArrayIndex);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmNpcPage2::SetControlData()
 *=========================================================================*/
