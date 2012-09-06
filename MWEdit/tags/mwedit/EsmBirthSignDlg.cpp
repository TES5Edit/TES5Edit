/*===========================================================================
 *
 * File:	Esmbirthsigndlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 19, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmBirthSignDlg.h"


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

  DEFINE_FILE("EsmBirthSignDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmBirthSignDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Spell Column Data
 *
 *=========================================================================*/
static esmcoldata_t l_SpellColData[] = {
	{  _T("ID"),		ESM_FIELD_ID,		LVCFMT_LEFT,	ESMLIST_WIDTH_ID,	ESMLIST_SUBITEM_ID,	NULL }, 
	{  _T("Mod"),		ESM_FIELD_CHANGED,	LVCFMT_CENTER,	ESMLIST_WIDTH_CHANGED,	ESMLIST_SUBITEM_CHANGED }, 
	{  _T("Name"),		ESM_FIELD_NAME,		LVCFMT_LEFT,	ESMLIST_WIDTH_NAME,	ESMLIST_SUBITEM_NAME }, 
	{  _T("Type"),		ESM_FIELD_TYPE,		LVCFMT_CENTER,	ESMLIST_WIDTH_TYPE,	ESMLIST_SUBITEM_TYPE },
	{  _T("Cost"),		ESM_FIELD_COST,		LVCFMT_CENTER,	ESMLIST_WIDTH_COST,	ESMLIST_SUBITEM_COST },
	{ NULL, 0, 0, 0 }	/* Must be last record */
 };
/*===========================================================================
 *		End of Spell Column Data
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmBirthSignDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmBirthSignDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmBirthSignDlg)
  ON_MESSAGE(ESMLIST_NOTIFY_ONDROP, OnRecordDrop)
  ON_MESSAGE(ESMLIST_NOTIFY_ONKEY, OnRecordKey)
  ON_BN_CLICKED(IDC_TEXTUREBUTTON, OnTexturebutton)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmBirthSignDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBirthSignDlg Constructor
 *
 *=========================================================================*/
CEsmBirthSignDlg::CEsmBirthSignDlg() : CEsmRecDialog(CEsmBirthSignDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmBirthSignDlg)
  //}}AFX_DATA_INIT
  m_pBirthSign = NULL;
 }
/*===========================================================================
 *		End of Class CEsmBirthSignDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBirthSignDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmBirthSignDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmBirthSignDlg)
  DDX_Control(pDX, IDC_DESCTEXT, m_DescText);
  DDX_Control(pDX, IDC_SPELLLIST, m_SpellList);
  DDX_Control(pDX, IDC_TEXTUREBUTTON, m_TextureButton);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmBirthSignDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBirthSignDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmBirthSignDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmBirthSignDlg::GetControlData()");
  CEsmSubName32* pSpellRec;
  esmrecinfo_t*  pRecInfo;
  CString	 Buffer;  
  int		 Index;
  
	/* Update the armor pointer and data */
  m_pBirthSign = (CEsmBirthSign *) GetRecInfo()->pRecord;
  ASSERT(m_pBirthSign != NULL);
 
	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pBirthSign->SetID(TrimStringSpace(Buffer));
   }

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pBirthSign->SetName(TrimStringSpace(Buffer));
	
	/* Item description */
  m_DescText.GetWindowText(Buffer);
  m_pBirthSign->SetDescription(TrimStringSpace(Buffer));

	/* Texture button */
  m_TextureButton.GetWindowText(Buffer);
  m_pBirthSign->SetTexture(Buffer);
 
	/* Spells and abilities */
  m_pBirthSign->DeleteSubRecords(MWESM_SUBREC_NPCS);

  for (Index = 0; Index < m_SpellList.GetItemCount(); Index++) {
    pRecInfo = (esmrecinfo_t *) m_SpellList.GetItemData(Index);
    if (pRecInfo == NULL) continue;
    pSpellRec = (CEsmSubName32 *) m_pBirthSign->AllocateSubRecord(MWESM_SUBREC_NPCS);
    pSpellRec->CreateNew();
    pSpellRec->SetName(pRecInfo->pRecord->GetID());
   }

 }
/*===========================================================================
 *		End of Class Method CEsmBirthSignDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBirthSignDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmBirthSignDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_IDText.GetModify())     m_Modified = true;
  if (m_NameText.GetModify())   m_Modified = true;
  if (m_DescText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmBirthSignDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBirthSignDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmBirthSignDlg::OnInitialUpdate() {
  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pBirthSign = (CEsmBirthSign *) GetRecInfo()->pRecord;

	/* Spell List */
  m_SpellList.OnInitCtrl();
  m_SpellList.SetDlgHandler(m_pParent);
  m_SpellList.SetEnableDrag(true);
  m_SpellList.SetAcceptDrag(true);
  m_SpellList.SetWantKeys(true);
  m_SpellList.InitObjectList(&l_SpellColData[0]);

	/* Initialize the text controls */
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
  m_DescText.SetLimitText(256);
  
	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmBirthSignDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBirthSignDlg Event - LRESULT OnRecordDrop (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmBirthSignDlg::OnRecordDrop (LPARAM lParam, LPARAM wParam) {
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
 *		End of Class Event CEsmBirthSignDlg::OnRecordDrop()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBirthSignDlg Event - LRESULT OnRecordKey (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmBirthSignDlg::OnRecordKey (LPARAM lParam, LPARAM wParam) {
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
 *		End of Class Event CEsmBirthSignDlg::OnRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBirthSignDlg Event - void OnTexturebutton ();
 *
 *=========================================================================*/
void CEsmBirthSignDlg::OnTexturebutton() {
  CString Filename;
  bool	  Result;

  Result = SelectEsmTexture(Filename, _T("Select Texture"), this);
  if (Result) m_TextureButton.SetWindowText(Filename);
 }
/*===========================================================================
 *		End of Class Event CEsmBirthSignDlg::OnTexturebutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBirthSignDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmBirthSignDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {

  	/* Refill the script list if required */
  if (pRecInfo->pRecord->IsType(MWESM_REC_SPEL)) {
    m_SpellList.UpdateItem(pRecInfo);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmBirthSignDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmBirthSignDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmBirthSignDlg::SetControlData (void) {
  CEsmSubName32* pSpellRec;
  esmrecinfo_t*  pRecInfo;
  CString	 Buffer;
  int		 Index;

	/* Ignore if the current item is not valid */
  if (m_pBirthSign == NULL) return;

	/* Item ID, update title as well */
  m_IDText.SetWindowText(m_pBirthSign->GetID());
  UpdateTitle(m_pBirthSign->GetID());
  m_IDText.SetModify(FALSE);

	/* Item name */
  m_NameText.SetWindowText(m_pBirthSign->GetName());
  m_NameText.SetModify(FALSE);
	
	/* Item description */
  m_DescText.SetWindowText(m_pBirthSign->GetDescription());
  m_DescText.SetModify(FALSE);

	/* Texture button */
  m_TextureButton.SetWindowText(m_pBirthSign->GetTexture());

  	/* Spells and abilities */
  pSpellRec = (CEsmSubName32 *) m_pBirthSign->FindFirst(MWESM_SUBREC_NPCS, Index);

  while (pSpellRec != NULL) {
    pRecInfo = GetDocument()->FindRecord(pSpellRec->GetName());
    if (pRecInfo != NULL) m_SpellList.AddItem(pRecInfo);
    pSpellRec =  (CEsmSubName32 *) m_pBirthSign->FindNext(MWESM_SUBREC_NPCS, Index);
   }
  
 }
/*===========================================================================
 *		End of Class Method CEsmBirthSignDlg::SetControlData()
 *=========================================================================*/

