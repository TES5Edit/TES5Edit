/*===========================================================================
 *
 * File:	Esmdialogdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 * 2 January 2004
 *	- Changed the UpdateInfoList() method to reverse iterate the INFO 
 *	  list to check for any 'one-way' links.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmDialogDlg.h"
#include "EsmInfoDlg.h"
#include "EsmJournalDlg.h"


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

  DEFINE_FILE("EsmDialogDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmDialogDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Item List Display Data Array
 *
 *=========================================================================*/
static esmcoldata_t l_InfoColData[] = {
	{  _T("Info"),		ESM_FIELD_NAME,		LVCFMT_CENTER,	ESMLIST_WIDTH_NAME+50,	ESMLIST_SUBITEM_NAME, NULL }, 
	{  _T("ID"),		ESM_FIELD_ID,		LVCFMT_LEFT,	10,			ESMLIST_SUBITEM_ID, }, 
	{  _T("Mod"),		ESM_FIELD_CHANGED,	LVCFMT_CENTER,	ESMLIST_WIDTH_CHANGED,	ESMLIST_SUBITEM_CHANGED }, 
	{  _T("Disposition"),	ESM_FIELD_DISPOSITION,	LVCFMT_CENTER,	ESMLIST_WIDTH_DISPOSITION,ESMLIST_SUBITEM_DISPOSITION }, 
	{  _T("NPC ID"),	ESM_FIELD_NPCID,	LVCFMT_LEFT,	ESMLIST_WIDTH_NPCID,	ESMLIST_SUBITEM_NPCID }, 
	{  _T("Faction"),	ESM_FIELD_NPCFACTION,	LVCFMT_LEFT,	ESMLIST_WIDTH_NPCFACTION,ESMLIST_SUBITEM_NPCFACTION }, 
	{  _T("Cell"),		ESM_FIELD_NPCCELL,	LVCFMT_LEFT,	ESMLIST_WIDTH_NPCCELL,	ESMLIST_SUBITEM_NPCCELL }, 
	{  _T("Func/Var 1"),	ESM_FIELD_INFOFUNC1,	LVCFMT_LEFT,	ESMLIST_WIDTH_INFOFUNC,	ESMLIST_SUBITEM_INFOFUNC1 }, 
	{  _T("Func/Var 2"),	ESM_FIELD_INFOFUNC2,	LVCFMT_LEFT,	ESMLIST_WIDTH_INFOFUNC,	ESMLIST_SUBITEM_INFOFUNC2 }, 
	{  _T("Func/Var 3"),	ESM_FIELD_INFOFUNC3,	LVCFMT_LEFT,	ESMLIST_WIDTH_INFOFUNC,	ESMLIST_SUBITEM_INFOFUNC3 }, 
	{  _T("Func/Var 4"),	ESM_FIELD_INFOFUNC4,	LVCFMT_LEFT,	ESMLIST_WIDTH_INFOFUNC,	ESMLIST_SUBITEM_INFOFUNC4 }, 
	{  _T("Func/Var 5"),	ESM_FIELD_INFOFUNC5,	LVCFMT_LEFT,	ESMLIST_WIDTH_INFOFUNC,	ESMLIST_SUBITEM_INFOFUNC5 }, 
	{  _T("Func/Var 6"),	ESM_FIELD_INFOFUNC6,	LVCFMT_LEFT,	ESMLIST_WIDTH_INFOFUNC,	ESMLIST_SUBITEM_INFOFUNC6 }, 
	{  _T("Prev ID"),	ESM_FIELD_PREV,		LVCFMT_LEFT,	10,			ESMLIST_SUBITEM_PREV, }, 
	{  _T("Next ID"),	ESM_FIELD_NEXT,		LVCFMT_LEFT,	10,			ESMLIST_SUBITEM_NEXT, }, 
	{ NULL, 0, 0, 0 }	/* Must be last record */
 };
/*===========================================================================
 *		End of Item List Display Data Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmDialogDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmDialogDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmDialogDlg)
  ON_MESSAGE(ESMLIST_NOTIFY_ONDROP, OnRecordDrop)
  ON_MESSAGE(ESMLIST_NOTIFY_ONKEY, OnRecordKey)
  ON_MESSAGE(ESMLIST_NOTIFY_ONEDIT, OnEditRecord)
  ON_MESSAGE(ESMDLG_MSG_ONINFOEDIT, OnEditInfoRecord)  
  ON_BN_CLICKED(IDC_MOVEUPBUTTON, OnMoveupbutton)
  ON_BN_CLICKED(IDC_MOVEDOWNBUTTON, OnMovedownbutton)
  ON_WM_CONTEXTMENU()
  ON_COMMAND(ID_EDIT_ADDNEW, OnEditAddnew)
  ON_COMMAND(ID_EDIT_EDITITEM, OnEditEdititem)
  ON_CBN_SELCHANGE(IDC_FILTERLIST, OnSelchangeFilterlist)
  ON_COMMAND(ID_EDIT_CREATECOPY, OnEditCreatecopy)
  ON_WM_SIZE()
  ON_COMMAND(ID_EDIT_DELETE, OnEditDelete)
  ON_COMMAND(ID_EDIT_CLEAN, OnEditClean)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmDialogDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Constructor
 *
 *=========================================================================*/
CEsmDialogDlg::CEsmDialogDlg() : CEsmRecDialog(CEsmDialogDlg::IDD), m_NewInfos(0) {
  //{{AFX_DATA_INIT(CEsmDialogDlg)
  //}}AFX_DATA_INIT
  m_pDialog    = NULL;
  m_pStartInfo = NULL;
  m_pNpcFilter = NULL;
 }
/*===========================================================================
 *		End of Class CEsmDialogDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Destructor
 *
 *=========================================================================*/
CEsmDialogDlg::~CEsmDialogDlg () {
  ClearNewInfos();
 }
/*===========================================================================
 *		End of Class CEsmDialogDlg Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - bool CanCleanInfo (pRecInfo);
 *
 * Returns true if the given info record can be safely cleaned.
 *
 *=========================================================================*/
bool CEsmDialogDlg::CanCleanInfo (esmrecinfo_t* pRecInfo) {
  CEsmInfo*     pPrevInfo = (CEsmInfo *) pRecInfo->pRecord->GetPrevRecord();
  CEsmInfo*     pInfo = (CEsmInfo *) pRecInfo->pRecord;
  esmrecinfo_t* pPrevRecInfo;

	/* Try and find the previous record, if any */
  pPrevRecInfo = GetDocument()->FindRecInfo(pPrevInfo);
  if (pPrevRecInfo == NULL) return (true);

	/* Ensure the linked list info names match exactly */
  if (StringCompare(pInfo->GetNextName(), pPrevInfo->GetNextName(), false) != 0) return (false);
  if (StringCompare(pInfo->GetPrevName(), pPrevInfo->GetPrevName(), false) != 0) return (false);
  
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::CanCleanInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - bool CheckInfoLinks (pStartInfoRec, FirstUpdate, pFilterNpc);
 *
 * Checks through the previous links starting with the given INFO and
 * ensures that all the INFOs have been added to the list.
 *
 *=========================================================================*/
bool CEsmDialogDlg::CheckInfoLinks (esmrecinfo_t* pStartInfoRec, const bool FirstUpdate, CEsmNpc* pFilterNpc) {
  //DEFINE_FUNCTION("CEsmDialogDlg::CheckInfoLinks()");
  esmrecinfo_t*  pRecInfo;
  esmrecinfo_t*  pLastRecInfo = NULL;
  CEsmInfo*      pInfo;
  const TCHAR*   pPrevInfo;
  int		 LastIndex;
  int		 RecIndex;

	/* Initialize the loop variable */
  RecIndex  = m_InfoList.FindRecord(pStartInfoRec);
  pInfo     = (CEsmInfo *) pStartInfoRec->pRecord;
  pPrevInfo = pInfo->GetID();
  SystemLog.Printf(_T("\tChecking INFO(%s)"), pPrevInfo);
      
	/* Reverse iterate the linked list starting at the given INFO */
  while (pPrevInfo != NULL && pPrevInfo[0] != NULL_CHAR) {
    pRecInfo = GetRecInfo(pPrevInfo);
    if (pRecInfo == NULL) break;
    pInfo = (CEsmInfo *) pRecInfo->pRecord;
    SystemLog.Printf(_T("\tINFO(%s)"), pInfo->GetID());

		/* Don't add record if it is already in the list */
    LastIndex = RecIndex;
    RecIndex  = m_InfoList.FindRecord(pRecInfo);

    if (RecIndex >= 0) {
      pPrevInfo = pInfo->GetPrevName();
      continue;
     }

       		/* Add and update the list item */
    if (FirstUpdate) pRecInfo->UserData = 0;
            
    if (pFilterNpc == NULL || pFilterNpc->DoesInfoApply(pInfo)) {
      LastIndex = m_InfoList.InsertRecord(LastIndex - 1, pRecInfo);
      SystemLog.Printf(_T("\t\tAdded INFO at index %d"), LastIndex);
      RecIndex = LastIndex;
     }

    pPrevInfo = pInfo->GetPrevName();
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::CheckInfoLinks()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - void ClearNewInfos (void);
 *
 *=========================================================================*/
void CEsmDialogDlg::ClearNewInfos (void) {
  DEFINE_FUNCTION("CEsmDialogDlg::ClearNewInfos()");
  esminfodata_t* pInfoData;
  int	         Index;

	/* Delete all current records in the new info array */
  for (Index = 0; Index < m_NewInfos.GetSize(); Index++) {
    pInfoData = m_NewInfos.GetAt(Index);
    if (pInfoData->pNewRecInfo != NULL) DestroyPointer(pInfoData->pNewRecInfo);
    DestroyPointer(pInfoData);
   }

  m_NewInfos.RemoveAll();
 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::ClearNewInfos()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - void CopyAllInfos (Rename);
 *
 * Ensures that all child INFOs of the dialogue are 'new'. The Rename flag
 * determines whether all the INFO records are given new IDs. Used if the
 * dialogue topic is renamed and requires the new topic to contain a copy
 * of all the info records.
 *
 *=========================================================================*/
void CEsmDialogDlg::CopyAllInfos (const bool Rename) {
  esmrecinfo_t*  pRecInfo;
  CEsmInfo*      pInfo;
  CEsmInfo*      pPrevInfo = NULL;
  const TCHAR*   pNextInfoID;
  bool		 IsStart = true;

	/* Ignore if there are no info records in this dialogue */
  if (m_pStartInfo == NULL) return;

	/* Initialize the linked list variables */
  pNextInfoID = m_pStartInfo->GetID();
  pInfo = m_pStartInfo;

  	/* Loop until the end of the info linked list */
  while (pNextInfoID != NULL && pNextInfoID[0] != NULL_CHAR) {

		/* Get the record with the given info ID */
    pRecInfo = GetRecInfo(pNextInfoID, m_RecEditInfo.OldID);
    if (pRecInfo == NULL) break;
    pInfo = (CEsmInfo *) pRecInfo->pRecord;

		/* Don't copy empty cleaned records */
    if (pRecInfo->UserData == MWESM_DLGFORM_CLEANED) {
      pNextInfoID = pInfo->GetNextName();
      continue;
     }

		/* Ensure the info record is active */
    pRecInfo = CreateNewInfo(pRecInfo, Rename);

		/* Initialize the record on success */
    if (pRecInfo != NULL) {
      pInfo = (CEsmInfo *) pRecInfo->pRecord;
      pInfo->SetDialParent(m_pDialog);

		/* Update the list start if required */
      if (IsStart && !Rename) {
        IsStart = false;
        m_pStartInfo = pInfo;	
       }
    
		/* Rename the INFO record and update the linked list if required */
      if (Rename) {
        pInfo->SetID(GetDocument()->MakeNewINFOId());

        if (pPrevInfo != NULL) {
	  pPrevInfo->SetNextName(pInfo->GetID());
	  pInfo->SetPrevName(pPrevInfo->GetID());
	 }
        else {
	  pInfo->SetPrevName(_T(""));
	 }
       }
     }

		/* Get the next info record in the linked list */
    pPrevInfo = pInfo;
    pNextInfoID = pInfo->GetNextName();
   }

 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::CopyAllInfos()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - esmrecinfo_t* CreateNewInfo (ListIndex);
 *
 * Ensures that the INFO record at the given list index is active.
 * If the INFO already is active the existing new recinfo structure is
 * returned.  Otherwise the INFO is initialized and copied into the new
 * info array.
 *
 *=========================================================================*/
esmrecinfo_t* CEsmDialogDlg::CreateNewInfo (const int ListIndex) {
  esmrecinfo_t*  pRecInfo;
  esmrecinfo_t*  pNewRecInfo;

	/* Ensure a valid list index */
  if (ListIndex < 0 || ListIndex >= m_InfoList.GetItemCount()) return (NULL);
  pRecInfo = (esmrecinfo_t *) m_InfoList.GetItemData(ListIndex);

	/* Create a new info record if required */
  if (pRecInfo->UserData == 0) {
    pNewRecInfo = CreateNewInfo(pRecInfo);
   }
   	/* Is the current info already new? */
  else if (pRecInfo->UserData >= MWESM_DLGFORM_OLDINFO) {
    pNewRecInfo = pRecInfo;
   }
  else {
    return (pRecInfo);
   }

	/* Update the list item */
  m_InfoList.SetItemData(ListIndex, (DWORD) pNewRecInfo);
  //m_InfoList.SetItem(ListIndex, pNewRecInfo);

  return (pNewRecInfo);
 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::CreateNewInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - esmrecinfo_t* CreateNewInfo (pRecInfo, MustBeNew);
 *
 * Ensures that the given INFO record an active info. If the INFO already is 
 * active the existing new recinfo structure is returned.  Otherwise the INFO 
 * is initialized and copied into the new info array.
 *
 * If MustBeNew is true, the new info record is created unless the given
 * record has already been newly created during the current edit. Otherwise
 * the new info record is only created if the current info is not active.
 *
 *=========================================================================*/
esmrecinfo_t* CEsmDialogDlg::CreateNewInfo (esmrecinfo_t* pRecInfo, const bool MustBeNew) {
  DEFINE_FUNCTION("CEsmDialogDlg::CreateNewInfo()");
  esminfodata_t* pInfoData;
  CEsmInfo*      pNewInfo;
	
	/* Ensure valid input */
  if (pRecInfo == NULL) return (NULL);

	/* Determine if we have to create a new info record */
  if (MustBeNew) {
    if (pRecInfo->UserData == MWESM_DLGFORM_NEWINFO) return (pRecInfo);
   }
  else {
    if (pRecInfo->UserData >= MWESM_DLGFORM_OLDINFO) return (pRecInfo);
    //if (pRecInfo->pFile->IsActive()) return (pRecInfo);
   }

	/* Create a new Info data structure */
  CreatePointer(pInfoData, esminfodata_t);
  pInfoData->pRecInfo = pRecInfo;

	/* Create a new recinfo */
  CreatePointer(pInfoData->pNewRecInfo, esmrecinfo_t);

	/* Create the new info record */
  CreatePointer(pNewInfo, CEsmInfo);
  pNewInfo->Copy(pRecInfo->pRecord);
  pNewInfo->SetFile(GetDocument()->GetActivePlugin());

	/* Initialize the new rec info */
  pInfoData->pNewRecInfo->pFile    = GetDocument()->GetActivePlugin();
  pInfoData->pNewRecInfo->pRecord  = pNewInfo;

	/* Set the type of the new record */
  if (MustBeNew) {
    pInfoData->pNewRecInfo->UserData = MWESM_DLGFORM_NEWINFO;
    pInfoData->pRecInfo->UserData    = MWESM_DLGFORM_NEWINFO;
    pInfoData->pNewRecInfo->pRecord->SetPrevRecord(NULL);
   }
  else if (pInfoData->pRecInfo->pFile->IsActive()) {
    pInfoData->pNewRecInfo->UserData = MWESM_DLGFORM_ACTIVEINFO;
    pInfoData->pRecInfo->UserData    = MWESM_DLGFORM_ACTIVEINFO;
   pInfoData->pNewRecInfo->pRecord->SetPrevRecord(pRecInfo->pRecord);
   }
  else {
    pInfoData->pNewRecInfo->UserData = MWESM_DLGFORM_OLDINFO;
    pInfoData->pRecInfo->UserData    = MWESM_DLGFORM_OLDINFO;
    pInfoData->pNewRecInfo->pRecord->SetPrevRecord(pRecInfo->pRecord);
   }

	/* Save the new info record to the info array */
  m_NewInfos.Add(pInfoData);
  return (pInfoData->pNewRecInfo);
 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::CreateNewInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmDialogDlg::DoDataExchange (CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmDialogDlg)
  DDX_Control(pDX, IDCANCEL, m_CancelButton);
  DDX_Control(pDX, IDC_SAVE, m_SaveButton);
  DDX_Control(pDX, IDC_FILTERLIST, m_FilterList);
  DDX_Control(pDX, IDC_INFOLIST, m_InfoList);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - void FillInfoList (void);
 *
 * Fills the info list with the INFO records for the current filter settings.
 *
 *=========================================================================*/
void CEsmDialogDlg::FillInfoList (void) {
  esmrecinfo_t* pStartRecInfo;
  esmrecinfo_t* pRecInfo;

	/* Find the start of the info list */
  pStartRecInfo = GetDocument()->GetInfoStart(CEsmRecDialog::GetRecInfo());
  pRecInfo = pStartRecInfo;

  if (pRecInfo != NULL)
    m_pStartInfo = (CEsmInfo *) pRecInfo->pRecord;
  else
    m_pStartInfo = NULL;

  UpdateInfoList(true);
 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::FillInfoList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - esminfodata_t* FindNewInfo (pID);
 *
 * Attempt to find the given INFO ID string in the new info array.
 *
 *=========================================================================*/
esminfodata_t* CEsmDialogDlg::FindNewInfo (const TCHAR* pID) {
  esminfodata_t* pInfoData;
  int	         Index;

	/* Search the new info array for the matching record */
  for (Index = 0; Index < m_NewInfos.GetSize(); Index++) {
    pInfoData = m_NewInfos.GetAt(Index);
    if (pInfoData->pNewRecInfo == NULL) continue;
    if (pInfoData->pNewRecInfo->pRecord == NULL) continue;
    if (pInfoData->pNewRecInfo->pRecord->IsID(pID)) return (pInfoData);
   }

	/* Not found */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::FindNewInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - esminfodata_t* FindNewInfo (pRecInfo);
 *
 * Searching for the given RecInfo pointer in the new array (does not
 * match the INFO ID string).
 *
 *=========================================================================*/
esminfodata_t* CEsmDialogDlg::FindNewInfo (esmrecinfo_t* pRecInfo) {
  esminfodata_t* pInfoData;
  int	         Index;

	/* Search the new info array for a matching record */
  for (Index = 0; Index < m_NewInfos.GetSize(); Index++) {
    pInfoData = m_NewInfos.GetAt(Index);
    if (pInfoData->pNewRecInfo == NULL) continue;
    if (pInfoData->pNewRecInfo == pRecInfo) return (pInfoData);
   }

	/* Not found */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::FindNewInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - esmrecinfo_t* GetRecInfo (pID, pDialogID);
 *
 * Find the INFO record (new or old) with the given ID.
 *
 *=========================================================================*/
esmrecinfo_t* CEsmDialogDlg::GetRecInfo (const TCHAR* pID, const TCHAR* pDialogID) {
  esminfodata_t* pInfoData;
  esmrecinfo_t*  pRecInfo;

	/* Not a valid INFO record */
  if (pID == NULL || *pID == NULL_CHAR) return (NULL);

	/* Find a new info record */
  pInfoData = FindNewInfo(pID);
  if (pInfoData != NULL) return (pInfoData->pNewRecInfo);

	/* Get the 'old' record from the document */
  //pRecInfo = GetDocument()->FindRecord(pID, MWESM_REC_INFO);

  if (pDialogID == NULL)
    pRecInfo = GetDocument()->FindInfoRecord(pID, m_pDialog->GetID());
  else
    pRecInfo = GetDocument()->FindInfoRecord(pID, pDialogID);

  return (pRecInfo);
 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::GetRecInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmDialogDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmDialogDlg::GetControlData()");
  esminfodata_t* pInfoData;
  CString 	 Buffer;  
  bool		 AddNewRecord;
  int		 Index;

	/* Save the current column widths of the info list */
  m_InfoList.UpdateColData();

	/* Update the dialogue pointer and data */
  m_pDialog = (CEsmDialogue *) m_RecEditInfo.pRecInfo->pRecord;
  ASSERT(m_pDialog != NULL);
  
 	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pDialog->SetID(TrimStringSpace(Buffer));

		/* Update all child INFOs */
    CopyAllInfos(m_RecEditInfo.IsCopied);
   }
		/* Copy and rename all new INFOs */
  else if (m_RecEditInfo.IsCopied) {
    CopyAllInfos(true);
   }

	/* Save any info records along with the dialogue */
  for (Index = 0; Index < m_NewInfos.GetSize(); Index++) {
    pInfoData = m_NewInfos.GetAt(Index);
    AddNewRecord = pInfoData->pNewRecInfo->UserData == MWESM_DLGFORM_OLDINFO || 
		   pInfoData->pNewRecInfo->UserData == MWESM_DLGFORM_NEWINFO;

		/* Clean a record from the active file */
    if (pInfoData->pNewRecInfo->UserData == MWESM_DLGFORM_CLEANED) {
      GetDocument()->CleanRecord(pInfoData->pRecInfo);
      //DestroyPointer(pInfoData->pNewRecInfo->pRecord);
      DestroyPointer(pInfoData->pNewRecInfo);
      DestroyPointer(pInfoData);
      continue;
     }
		/* Add the new info to the active file if required */
    else if (AddNewRecord) {
      GetDocument()->GetActivePlugin()->AddRecord(pInfoData->pNewRecInfo->pRecord, m_pDialog);
      ((CEsmInfo *)pInfoData->pNewRecInfo->pRecord)->SetDialParent(m_pDialog);
     }
    else {
      ((CEsmInfo *)pInfoData->pNewRecInfo->pRecord)->SetDialParent(m_pDialog);
     }
     
    		/* Rearrange the rec info structures */
    if (pInfoData->pRecInfo == NULL || pInfoData->pNewRecInfo->UserData == MWESM_DLGFORM_NEWINFO) {
      GetDocument()->AddRecInfo(pInfoData->pNewRecInfo);
      DestroyPointer(pInfoData);
     }
    else if (pInfoData->pNewRecInfo->UserData == MWESM_DLGFORM_OLDINFO) {
      pInfoData->pRecInfo->pRecord = pInfoData->pNewRecInfo->pRecord;
      pInfoData->pRecInfo->pFile   = pInfoData->pNewRecInfo->pFile;
      DestroyPointer(pInfoData->pNewRecInfo);
      DestroyPointer(pInfoData);
     }
    else if (pInfoData->pNewRecInfo->UserData == MWESM_DLGFORM_ACTIVEINFO) {
      pInfoData->pRecInfo->pRecord->Copy(pInfoData->pNewRecInfo->pRecord);
      pInfoData->pRecInfo->pFile   = pInfoData->pNewRecInfo->pFile;
      DestroyPointer(pInfoData->pNewRecInfo->pRecord);
      DestroyPointer(pInfoData->pNewRecInfo);
      DestroyPointer(pInfoData);
     }
   }

	/* Clear the new info record */
  m_NewInfos.RemoveAll();
 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmDialogDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_IDText.GetModify()) m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - LRESULT OnEditRecord (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmDialogDlg::OnEditRecord (LPARAM lParam, LPARAM wParam) {
  DEFINE_FUNCTION("CEsmDialogDlg::OnEditRecord()");
  esmrecinfo_t*  pRecInfo;
  
	/* Get the recinfo record and pass it onto the OnEditInfoRecord() method */
  if (lParam < 0) return (0);
  pRecInfo = (esmrecinfo_t *) m_InfoList.GetItemData(lParam);

  return OnEditInfoRecord((LPARAM) pRecInfo, lParam);
 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnEditRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - LRESULT OnEditInfoRecord (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmDialogDlg::OnEditInfoRecord (LPARAM lParam, LPARAM wParam) {
  DEFINE_FUNCTION("CEsmDialogDlg::OnEditInfoRecord()");
  esmrecinfo_t*  pRecInfo = (esmrecinfo_t *) lParam;
  esminfodata_t* pInfoData;
  CEsmInfo*	 pInfo;
  CEsmInfo*	 pNewInfo;
  bool	         Result;
  bool		 HasNewInfo;
  bool		 AlreadyIsNew;
  int		 ListIndex;

	/* Ensure a valid input record to edit */
  if (pRecInfo == NULL) return (0);
  pInfo = (CEsmInfo *) pRecInfo->pRecord;
  AlreadyIsNew = (pRecInfo->UserData >= MWESM_DLGFORM_OLDINFO);

	/* Get the list index of the info record */
  if (wParam < 0) 
    ListIndex = m_InfoList.FindRecord(pRecInfo);
  else
    ListIndex = wParam;

	/* Display the usual INFO or Journal dialog */
  if (pInfo->GetDialParent() != NULL && pInfo->GetDialParent()->GetDialogTypeID() == MWESM_DIALTYPE_JOURNAL) {
    CEsmJournalDlg JournalDlg;
    Result   = JournalDlg.DoModal(pInfo, AlreadyIsNew, GetDocument());
    pNewInfo = JournalDlg.GetInfo();
    HasNewInfo = JournalDlg.HasNewInfo();
   }
  else {
    CEsmInfoDlg    InfoDialog;
    Result   = InfoDialog.DoModal(pInfo, AlreadyIsNew, GetDocument());
    pNewInfo = InfoDialog.GetInfo();
    HasNewInfo = InfoDialog.HasNewInfo();
   }

	/* Abort if the user cancelled the edit dialog */
  if (!Result) return (0);

	/* Check if we need to create a new info */
  if (HasNewInfo) {
    CreatePointer(pInfoData, esminfodata_t);
    m_NewInfos.Add(pInfoData);

		/* Initialize the new info data */
    pInfoData->pRecInfo = pRecInfo;
    CreatePointer(pInfoData->pNewRecInfo, esmrecinfo_t);
    pInfoData->pNewRecInfo->pFile    = GetDocument()->GetActivePlugin();
    pInfoData->pNewRecInfo->pRecord  = pNewInfo;
    pNewInfo->SetPrevRecord(pRecInfo->pRecord);
    if (pNewInfo->GetPrevName() == NULL || pNewInfo->GetPrevName()[0] == NULL_CHAR) m_pStartInfo = pNewInfo;
    
    if (pRecInfo->pFile->IsActive()) {
      pInfoData->pNewRecInfo->UserData = MWESM_DLGFORM_ACTIVEINFO;
      pInfoData->pRecInfo->UserData    = MWESM_DLGFORM_ACTIVEINFO;
     }
    else {
      pInfoData->pNewRecInfo->UserData = MWESM_DLGFORM_OLDINFO;
      pInfoData->pRecInfo->UserData    = MWESM_DLGFORM_OLDINFO;
     }

		/* Update the list data */
    m_InfoList.SetItemData(ListIndex, (DWORD) pInfoData->pNewRecInfo);
    m_InfoList.SetItem(ListIndex, pInfoData->pNewRecInfo);
   } 
	/* Update an existing new info record in the list */
  else {
    m_InfoList.SetItem(ListIndex, pRecInfo);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnEditInfoRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmDialogDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  ResizeParentToFit();
  SetScrollSizes(MM_TEXT, CSize(0, 0) );

	/* Initialize the list control */
  m_InfoList.OnInitCtrl();
  m_InfoList.SetDlgHandler(m_pParent);
  m_InfoList.InitObjectList(l_InfoColData);
  m_InfoList.SetWantKeys(true);
  m_InfoList.SetAcceptDrag(true);
  m_InfoList.SetEnableDrag(true);
  m_InfoList.SetWantEditMsg(true);

	/* Initialize the armor record */
  ASSERT(CEsmRecDialog::GetRecInfo() != NULL);
  m_pDialog = (CEsmDialogue *) CEsmRecDialog::GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  
	/* Disable filter list for journal IDs */
  if (m_pDialog->GetDialogTypeID() == MWESM_DIALTYPE_JOURNAL) {
    m_FilterList.EnableWindow(FALSE);
   }
  else {
    FillEsmNpcCombo(m_FilterList, true);
   }

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - LRESULT OnRecordDrop (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmDialogDlg::OnRecordDrop (LPARAM lParam, LPARAM wParam) {
  CString	Buffer;
  esmrecinfo_t* pRecInfo = (esmrecinfo_t *) wParam;

  	/* Only accept INFO types */
  if (!pRecInfo->pRecord->IsType(MWESM_REC_INFO)) return (0);
  
	/* Copy the the dialogue item  */
  //pRecInfo->UserData = 1;
  //ListIndex = m_ItemList.AddItem(pRecInfo);
  //m_ItemList.SetItemText(ListIndex, 0, _T("1"));
 
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnRecordDrop()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - LRESULT OnRecordKey (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmDialogDlg::OnRecordKey (LPARAM lParam, LPARAM wParam) {

  if (lParam == VK_DELETE || lParam == VK_BACK) {
    return (1);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmDialogDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  CString Buffer;
  int     Index;

	/* Update the filter list */
  if (pRecInfo->pRecord->IsType(MWESM_REC_NPC_)) {
   }
	/* Update a dialogue info item */
  else if (pRecInfo->pRecord->IsType(MWESM_REC_INFO)) {
    Index = m_InfoList.FindRecord(pRecInfo);
    if (Index >= 0) m_InfoList.UpdateItem(Index);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmDialogDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pDialog == NULL) return;

	/* Dialog topic name, update title as well */
  m_IDText.SetWindowText(m_pDialog->GetID());
  UpdateTitle(m_pDialog->GetID());

	/* Fill the main info list control */
  FillInfoList();
 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - void OnMoveupbutton ();
 *
 *=========================================================================*/
void CEsmDialogDlg::OnMoveupbutton() {
  esmrecinfo_t*  pRecInfo;
  esmrecinfo_t*  pSourcePrevRecInfo = NULL;
  esmrecinfo_t*  pSourceNextRecInfo = NULL;
  esmrecinfo_t*  pDestPrevRecInfo = NULL;
  esmrecinfo_t*  pDestNextRecInfo = NULL;
  CEsmInfo*      pInfo;
  CEsmInfo*      pSourceNextInfo = NULL;
  CEsmInfo*      pSourcePrevInfo = NULL;    
  CEsmInfo*      pDestNextInfo = NULL;
  CEsmInfo*      pDestPrevInfo = NULL;    
  POSITION	 SelPos;
  int		 ListIndex;
  
	/* Get the INFO record to be moved */
  SelPos = m_InfoList.GetFirstSelectedItemPosition();
  if (SelPos == NULL) return;
  ListIndex = m_InfoList.GetNextSelectedItem(SelPos);
  pRecInfo = m_InfoList.GetRecInfo(ListIndex);
  if (pRecInfo == NULL) return;

	/* Ignore if this INFO is already the first in the list */
  if (ListIndex == 0) return;
  
	/* Get the item to be moved */
  pRecInfo = CreateNewInfo(ListIndex); 
  pInfo = (CEsmInfo *) pRecInfo->pRecord;

	/* Update the next/prev records */
  pDestNextRecInfo = CreateNewInfo(ListIndex - 1);
  if (pDestNextRecInfo != NULL) pDestNextInfo    = (CEsmInfo *) pDestNextRecInfo->pRecord;
  if (pDestNextInfo    != NULL) pDestPrevRecInfo = CreateNewInfo(GetRecInfo(pDestNextInfo->GetPrevName()));
  if (pDestPrevRecInfo != NULL) pDestPrevInfo    = (CEsmInfo *) pDestPrevRecInfo->pRecord;
  pSourcePrevRecInfo = CreateNewInfo(GetRecInfo(pInfo->GetPrevName()));
  pSourceNextRecInfo = CreateNewInfo(GetRecInfo(pInfo->GetNextName()));
  if (pSourcePrevRecInfo != NULL) pSourcePrevInfo = (CEsmInfo *) pSourcePrevRecInfo->pRecord;
  if (pSourceNextRecInfo != NULL) pSourceNextInfo = (CEsmInfo *) pSourceNextRecInfo->pRecord;
  
	/* Rearrange the INFO pointers */
  if (pSourceNextInfo != NULL) pSourceNextInfo->SetPrevName(pSourcePrevInfo ? pSourcePrevInfo->GetID() : _T(""));
  if (pSourcePrevInfo != NULL) pSourcePrevInfo->SetNextName(pSourceNextInfo ? pSourceNextInfo->GetID() : _T(""));

  if (pDestNextInfo == NULL) {
    pInfo->SetNextName(_T(""));
   }
  else {
    pInfo->SetNextName(pDestNextInfo->GetID());
    pDestNextInfo->SetPrevName(pInfo->GetID());
   }

  if (pDestPrevInfo == NULL) {
    pInfo->SetPrevName(_T(""));
    m_pStartInfo = pInfo;
   }
  else {
    pInfo->SetPrevName(pDestPrevInfo->GetID());
    pDestPrevInfo->SetNextName(pInfo->GetID());
    if (pDestPrevInfo->GetPrevName()[0] == NULL_CHAR) m_pStartInfo = pDestPrevInfo;
   }
 
	/* Redraw the current info list */
  UpdateInfoList();
  ListIndex = m_InfoList.FindRecord(pRecInfo);
  m_InfoList.SetItemState(ListIndex, LVIS_SELECTED, LVIS_SELECTED);
 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnMoveupbutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - void OnMovedownbutton ();
 *
 *=========================================================================*/
void CEsmDialogDlg::OnMovedownbutton() {
  esmrecinfo_t*  pRecInfo;
  esmrecinfo_t*  pSourcePrevRecInfo = NULL;
  esmrecinfo_t*  pSourceNextRecInfo = NULL;
  esmrecinfo_t*  pDestPrevRecInfo = NULL;
  esmrecinfo_t*  pDestNextRecInfo = NULL;
  CEsmInfo*      pInfo;
  CEsmInfo*      pSourceNextInfo = NULL;
  CEsmInfo*      pSourcePrevInfo = NULL;    
  CEsmInfo*      pDestNextInfo = NULL;
  CEsmInfo*      pDestPrevInfo = NULL;    
  POSITION	 SelPos;
  int		 ListIndex;
  
	/* Get the INFO record to be moved */
  SelPos = m_InfoList.GetFirstSelectedItemPosition();
  if (SelPos == NULL) return;
  ListIndex = m_InfoList.GetNextSelectedItem(SelPos);
  pRecInfo = m_InfoList.GetRecInfo(ListIndex);
  if (pRecInfo == NULL) return;

	/* Ignore if this INFO is already the last in the list */
  if (ListIndex + 1 >= m_InfoList.GetItemCount()) return;
  
	/* Get the item to be moved */
  pRecInfo = CreateNewInfo(ListIndex); 
  pInfo = (CEsmInfo *) pRecInfo->pRecord;

	/* Update the next/prev records */
  pDestPrevRecInfo = CreateNewInfo(ListIndex + 1);
  if (pDestPrevRecInfo != NULL) pDestPrevInfo    = (CEsmInfo *) pDestPrevRecInfo->pRecord;
  if (pDestPrevInfo    != NULL) pDestNextRecInfo = CreateNewInfo(GetRecInfo(pDestPrevInfo->GetNextName()));
  if (pDestNextRecInfo != NULL) pDestNextInfo    = (CEsmInfo *) pDestNextRecInfo->pRecord;
  pSourcePrevRecInfo = CreateNewInfo(GetRecInfo(pInfo->GetPrevName()));
  pSourceNextRecInfo = CreateNewInfo(GetRecInfo(pInfo->GetNextName()));
  if (pSourcePrevRecInfo != NULL) pSourcePrevInfo = (CEsmInfo *) pSourcePrevRecInfo->pRecord;
  if (pSourceNextRecInfo != NULL) pSourceNextInfo = (CEsmInfo *) pSourceNextRecInfo->pRecord;
  
	/* Rearrange the INFO pointers */
  if (pSourceNextInfo != NULL) pSourceNextInfo->SetPrevName(pSourcePrevInfo ? pSourcePrevInfo->GetID() : _T(""));

  if (pSourcePrevInfo != NULL) 
    pSourcePrevInfo->SetNextName(pSourceNextInfo ? pSourceNextInfo->GetID() : _T(""));
  else
    m_pStartInfo = pSourceNextInfo;

  if (pDestNextInfo == NULL) {
    pInfo->SetNextName(_T(""));
   }
  else {
    pInfo->SetNextName(pDestNextInfo->GetID());
    pDestNextInfo->SetPrevName(pInfo->GetID());
   }

  if (pDestPrevInfo == NULL) {
    pInfo->SetPrevName(_T(""));
    m_pStartInfo = pInfo;
   }
  else {
    pInfo->SetPrevName(pDestPrevInfo->GetID());
    pDestPrevInfo->SetNextName(pInfo->GetID());
    if (pDestPrevInfo->GetPrevName()[0] == NULL_CHAR) m_pStartInfo = pDestPrevInfo;
   }
 
	/* Redraw the current info list */
  UpdateInfoList();
  ListIndex = m_InfoList.FindRecord(pRecInfo);
  m_InfoList.SetItemState(ListIndex, LVIS_SELECTED, LVIS_SELECTED);
 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnMovedownbutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - void OnContextMenu (pWnd, Point);
 *
 *=========================================================================*/
void CEsmDialogDlg::OnContextMenu (CWnd* pWnd, CPoint point) {
  CMenu  Menu;
  CMenu* pPopup;
  BOOL   Result;

	/* Ignore if not in the list control */
  if (pWnd->GetDlgCtrlID() != IDC_INFOLIST) return;

	/* Attempt to load the popup menu */
  Result = Menu.LoadMenu(IDR_DIALOGMENU);
  if (!Result) return;
  pPopup = Menu.GetSubMenu(0);
  if (pPopup == NULL) return;

	/* Display the popup */
  pPopup->TrackPopupMenu(TPM_LEFTALIGN | TPM_LEFTBUTTON, point.x, point.y, this);
 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnContextMenu()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - void OnEditAddnew ();
 *
 *=========================================================================*/
void CEsmDialogDlg::OnEditAddnew() {
  DEFINE_FUNCTION("CEsmDialogDlg::OnEditAddnew()");
  CEsmInfo*	 pNewInfo;
  CEsmInfo*      pNextInfo = NULL;
  CEsmInfo*      pPrevInfo = NULL;
  esminfodata_t* pInfoData;
  esmrecinfo_t*  pRecInfo = NULL;
  esmrecinfo_t*  pPrevRecInfo = NULL;
  esmrecinfo_t*  pNextRecInfo = NULL;
  const TCHAR*   pNewInfoID;
  bool	         Result;
  POSITION	 SelPos;
  int	 	 ListIndex;
  
	/* Find the currently selected item */
  SelPos = m_InfoList.GetFirstSelectedItemPosition();

  if (SelPos != NULL) {
    ListIndex = m_InfoList.GetNextSelectedItem(SelPos);
    pNextRecInfo = (esmrecinfo_t *) m_InfoList.GetItemData(ListIndex);
    if (pNextRecInfo != NULL) pNextInfo    = (CEsmInfo *) pNextRecInfo->pRecord;
    if (pNextInfo    != NULL) pPrevRecInfo = GetRecInfo(pNextInfo->GetPrevName());
    if (pPrevRecInfo != NULL) pPrevInfo    = (CEsmInfo *) pPrevRecInfo->pRecord;
   }
  else {
    if (m_InfoList.GetItemCount() > 0) pPrevRecInfo = (esmrecinfo_t *) m_InfoList.GetItemData(m_InfoList.GetItemCount() - 1);
    if (pPrevRecInfo != NULL) pPrevInfo    = (CEsmInfo *) pPrevRecInfo->pRecord;
    if (pPrevInfo    != NULL) pNextRecInfo = GetRecInfo(pPrevInfo->GetNextName());
    if (pNextRecInfo != NULL) pNextInfo    = (CEsmInfo *) pNextRecInfo->pRecord;
   }

	/* Create the new info item */
  CreatePointer(pNewInfo, CEsmInfo);
  pNewInfo->SetType(MWESM_REC_INFO);
  pNewInfo->CreateNew(GetDocument()->GetActivePlugin());

	/* Get a new Info ID */
  pNewInfoID = GetDocument()->MakeNewINFOId();
  pNewInfo->SetID(pNewInfoID);
  pNewInfo->SetFile(GetDocument()->GetActivePlugin());
  pNewInfo->SetDialParent(m_pDialog);

	/* Display the modal info edit dialog for the new info */
  if (m_pDialog->GetDialogTypeID() == MWESM_DIALTYPE_JOURNAL) {
    CEsmJournalDlg    JournalDialog;
    Result = JournalDialog.DoModal(pNewInfo, true, GetDocument());
   }
  else {
    CEsmInfoDlg    InfoDialog;
    Result = InfoDialog.DoModal(pNewInfo, true, GetDocument());
   }

	/* On failure delete the new info */
  if (!Result) {
    DestroyPointer(pNewInfo);
    return;
   }

	/* Save the next info if required */
  if (pNextRecInfo != NULL) {
    pNextRecInfo = CreateNewInfo(pNextRecInfo);
    ASSERT(pNextRecInfo != NULL);
    pNextInfo = (CEsmInfo *) pNextRecInfo->pRecord;
   }
  
	/* Save the previous info if required */
  if (pPrevRecInfo != NULL) {
    pPrevRecInfo = CreateNewInfo(pPrevRecInfo);
    ASSERT(pPrevRecInfo != NULL);
    pPrevInfo = (CEsmInfo *) pPrevRecInfo->pRecord;
   }

	/* Set the next/prev info linked list IDs */
  pNewInfo->SetPrevName(pPrevInfo ? pPrevInfo->GetID() : "");
  pNewInfo->SetNextName(pNextInfo ? pNextInfo->GetID() : "");
  if (pNextInfo != NULL) pNextInfo->SetPrevName(pNewInfo->GetID());
  if (pPrevInfo != NULL) pPrevInfo->SetNextName(pNewInfo->GetID());

	/* Save the new info */
  CreatePointer(pInfoData, esminfodata_t);
  pInfoData->pRecInfo = NULL;
  CreatePointer(pInfoData->pNewRecInfo, esmrecinfo_t);
  pInfoData->pNewRecInfo->pFile    = GetDocument()->GetActivePlugin();
  pInfoData->pNewRecInfo->pRecord  = pNewInfo;
  pInfoData->pNewRecInfo->UserData = MWESM_DLGFORM_NEWINFO;
  m_NewInfos.Add(pInfoData);
  
  	/* Update the linked list head if require */
  if (pPrevInfo == NULL) m_pStartInfo = pNewInfo;

	/* Update the info list */
  UpdateInfoList();
 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnEditAddnew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - void OnEditClean ();
 *
 *=========================================================================*/
void CEsmDialogDlg::OnEditClean() {
  DEFINE_FUNCTION("CEsmDialogDlg::OnEditClean()");
  POSITION	 SelPos;
  esmrecinfo_t*  pRecInfo;
  esmrecinfo_t*  pNextRecInfo = NULL;
  esmrecinfo_t*  pPrevRecInfo = NULL;
  esmrecinfo_t*  pNewRecInfo;
  esminfodata_t* pInfoData;
  CEsmRecord*    pPrevRecord;
  CEsmInfo*      pInfo;
  bool		 OnlyNewInfo;
  bool		 IsStart;
  int		 ListIndex;

	/* Find the currently selected item */
  SelPos = m_InfoList.GetFirstSelectedItemPosition();
  if (SelPos == NULL) return;
  ListIndex = m_InfoList.GetNextSelectedItem(SelPos);
  pRecInfo  = m_InfoList.GetRecInfo(ListIndex);
  pInfo     = (CEsmInfo *) pRecInfo->pRecord;
  IsStart   = (pInfo->GetPrevName() == NULL ||  pInfo->GetPrevName()[0] == NULL_CHAR);

  	/* Ignore if the record's file is not the active file */
  if (!pRecInfo->pFile->IsActive()) return;
  pPrevRecord = pRecInfo->pRecord->GetPrevRecord();

	/* Ensure the info record can be safely cleaned */
  if (!CanCleanInfo(pRecInfo)) {
    MessageBox(_T("This info record cannot be safely cleaned as it could\r\ndestroy the order of other info records."), _T("Clean Info Record"), MB_OK | MB_ICONWARNING);
    return;
   }

	/* Delete any new infos for the record in the new info array */
  pInfoData = FindNewInfo(pRecInfo);

  if (pInfoData != NULL) {
    OnlyNewInfo = pInfoData->pNewRecInfo->UserData > MWESM_DLGFORM_OLDINFO;
    pRecInfo    = GetDocument()->FindRecInfo(pPrevRecord);

		/* Adjust the info linked list if required */
    if (pRecInfo == NULL) RemoveInfo(pInfoData->pNewRecInfo);

		/* Delete the info data record */
    m_NewInfos.DeleteElement(pInfoData);
    DestroyPointer(pInfoData->pNewRecInfo->pRecord);
    DestroyPointer(pInfoData->pNewRecInfo);
    DestroyPointer(pInfoData);

		/* Was a new record so remove from list and update display */
    if (pRecInfo == NULL) {
      UpdateInfoList();
      return;
     }

		/* No more active record data to cleam, update list */
    if (!OnlyNewInfo || !pRecInfo->pFile->IsActive()) {
      if (IsStart) m_pStartInfo = (CEsmInfo *) pRecInfo->pRecord;
      m_InfoList.SetItemData(ListIndex, (DWORD) pRecInfo);
      m_InfoList.UpdateItem(ListIndex);
      return;
     }

		/* Update the new info and previous info records */
    pInfo = (CEsmInfo *) pRecInfo->pRecord;
    pPrevRecord = pRecInfo->pRecord->GetPrevRecord();
   }

  	/* Create the new info entry to clean the record if required */
  CreatePointer(pInfoData,   esminfodata_t);
  CreatePointer(pNewRecInfo, esmrecinfo_t);

	/* Remove the record from the linked list */
  if (pPrevRecord == NULL) {
    pNewRecInfo->pFile   = NULL;
    pNewRecInfo->pRecord = NULL;
		
		/* Ensure the next/prev records are new infos */
    pNextRecInfo = CreateNewInfo(GetRecInfo(pInfo->GetNextName()));
    pPrevRecInfo = CreateNewInfo(GetRecInfo(pInfo->GetPrevName()));
    
		/* Adjust the linked list names */
    if (pNextRecInfo != NULL && pPrevRecInfo != NULL) {
      ((CEsmInfo *)pNextRecInfo->pRecord)->SetPrevName(((CEsmInfo *)pPrevRecInfo->pRecord)->GetID());
      ((CEsmInfo *)pPrevRecInfo->pRecord)->SetNextName(((CEsmInfo *)pNextRecInfo->pRecord)->GetID());
      if (IsStart) m_pStartInfo = (CEsmInfo *) pNextRecInfo->pRecord;
     }
    else if (pNextRecInfo != NULL) {
      ((CEsmInfo *)pNextRecInfo->pRecord)->SetPrevName(_T(""));
      if (IsStart) m_pStartInfo = (CEsmInfo *) pNextRecInfo->pRecord;
     }
    else if (pPrevRecInfo != NULL) {
      ((CEsmInfo *)pPrevRecInfo->pRecord)->SetNextName(_T(""));
      if (IsStart) m_pStartInfo = NULL;
     }
    else if (IsStart) {
      m_pStartInfo = NULL;
     }
   }
	/* Get the 'previous' record for the one being cleaned */
  else {
    pNewRecInfo->pFile   = pPrevRecord->GetFile();
    pNewRecInfo->pRecord = pPrevRecord;
   }

	/* Initialize the new info data */
  pInfoData->pRecInfo    = pRecInfo;
  pInfoData->pNewRecInfo = pNewRecInfo;
  pNewRecInfo->UserData  = MWESM_DLGFORM_CLEANED;
  pRecInfo->UserData     = MWESM_DLGFORM_CLEANED;
  m_NewInfos.Add(pInfoData);
 
	/* Update the list */
  if (pPrevRecord == NULL) {
    UpdateInfoList();
   }
  else {
    m_InfoList.SetItemData(ListIndex, (DWORD) pNewRecInfo);
    m_InfoList.UpdateItem(ListIndex);
   }

 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnEditClean()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - void OnEditCreatecopy ();
 *
 *=========================================================================*/
void CEsmDialogDlg::OnEditCreatecopy() {
  DEFINE_FUNCTION("CEsmDialogDlg::OnEditCreatecopy()");
  POSITION	 SelPos;
  esminfodata_t* pInfoData;
  CEsmInfo*      pNewInfo;
  CEsmInfo*      pNextInfo = NULL;
  CEsmInfo*      pPrevInfo = NULL;
  esmrecinfo_t*  pRecInfo;
  esmrecinfo_t*  pNextRecInfo = NULL;
  esmrecinfo_t*  pPrevRecInfo = NULL;
  int		 ListIndex;

	/* Find the currently selected item */
  SelPos = m_InfoList.GetFirstSelectedItemPosition();
  if (SelPos == NULL) return;
  ListIndex = m_InfoList.GetNextSelectedItem(SelPos);
  pRecInfo = m_InfoList.GetRecInfo(ListIndex);

	/* Create a new Info data structure */
  CreatePointer(pInfoData, esminfodata_t);
  pInfoData->pRecInfo = NULL;

	/* Create a new recinfo */
  CreatePointer(pInfoData->pNewRecInfo, esmrecinfo_t);

	/* Create the new info record */
  CreatePointer(pNewInfo, CEsmInfo);
  pNewInfo->Copy(pRecInfo->pRecord);
  pNewInfo->SetID(GetDocument()->MakeNewINFOId());
  pNewInfo->SetFile(GetDocument()->GetActivePlugin());

	/* Initialize the new rec info */
  pInfoData->pNewRecInfo->pFile    = GetDocument()->GetActivePlugin();
  pInfoData->pNewRecInfo->pRecord  = pNewInfo;
  pInfoData->pNewRecInfo->UserData = MWESM_DLGFORM_NEWINFO;

	/* Add the new info to the array */
  m_NewInfos.Add(pInfoData);

	/* Update the linked list names (default add to end) */
  if (m_InfoList.GetItemCount() > 0) {  
    pPrevRecInfo = CreateNewInfo(m_InfoList.GetItemCount() - 1);
    if (pPrevRecInfo != NULL) pPrevInfo = (CEsmInfo *) pPrevRecInfo->pRecord;
    if (pPrevInfo    != NULL) pNextRecInfo = CreateNewInfo(GetRecInfo(pPrevInfo->GetNextName()));
    if (pNextRecInfo != NULL) pNextInfo = (CEsmInfo *) pNextRecInfo->pRecord;

    pNewInfo->SetPrevName(pPrevInfo ? pPrevInfo->GetID() : _T(""));
    pNewInfo->SetNextName(pNextInfo ? pNextInfo->GetID() : _T(""));
    if (pNextInfo != NULL) pNextInfo->SetPrevName(pNewInfo->GetID());

    if (pPrevInfo != NULL) {
      pPrevInfo->SetNextName(pNewInfo->GetID());
      if (pPrevInfo->GetPrevName()[0] == NULL_CHAR) m_pStartInfo = pPrevInfo;
     }
   }
  else {
    m_pStartInfo = pNewInfo;
   }

	/* Add the new item to the list */
  UpdateInfoList();
 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnEditCreatecopy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - void OnEditDelete ();
 *
 *=========================================================================*/
void CEsmDialogDlg::OnEditDelete() {
  POSITION	 SelPos;
  esmrecinfo_t*  pRecInfo;
  int		 ListIndex;

	/* Find the currently selected item */
  SelPos = m_InfoList.GetFirstSelectedItemPosition();
  if (SelPos == NULL) return;
  ListIndex = m_InfoList.GetNextSelectedItem(SelPos);
  pRecInfo  = m_InfoList.GetRecInfo(ListIndex);

	/* Ensure the rec info record is new */
  pRecInfo = CreateNewInfo(pRecInfo);

	/* Delete or undelete the record */
  pRecInfo->pRecord->DeleteToggle();

	/* Update the list */
  m_InfoList.SetItemData(ListIndex, (DWORD) pRecInfo);
  m_InfoList.UpdateItem(ListIndex);
 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnEditDelete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - void OnEditEdititem ();
 *
 *=========================================================================*/
void CEsmDialogDlg::OnEditEdititem() {
  m_InfoList.EditSelectedItem();
 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnEditEdititem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - void OnSelchangeFilterlist ();
 *
 *=========================================================================*/
void CEsmDialogDlg::OnSelchangeFilterlist() {
  int ListIndex;

  ListIndex = m_FilterList.GetCurSel();

  if (ListIndex < 0)
    m_pNpcFilter = NULL;
  else
    m_pNpcFilter = (esmrecinfo_t *) m_FilterList.GetItemData(ListIndex);
 
  UpdateInfoList();
 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnSelchangeFilterlist()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Event - void OnSize (nType, cx, int cy);
 *
 *=========================================================================*/
void CEsmDialogDlg::OnSize(UINT nType, int cx, int cy) {
  CRect ButtonRect;
  int   Width;
  int   Height;

	/* Call the base class method first */
  CEsmRecDialog::OnSize(nType, cx, cy);

	/* Ignore minimize size events */
  if (nType == SIZE_MINIMIZED) return;
  if (!::IsWindow(m_InfoList.m_hWnd)) return;

	/* Compute the new width/height of the info list */
  Width  = cx - MWESM_DLGFORM_WIDTHMARGIN;
  Height = cy - MWESM_DLGFORM_HEIGHTMARGIN;
  if (Width  < MWESM_DLGFORM_MINWIDTH)  Width  = MWESM_DLGFORM_MINWIDTH;
  if (Height < MWESM_DLGFORM_MINHEIGHT) Height = MWESM_DLGFORM_MINHEIGHT;

	/* Resize the info list */
  m_InfoList.SetWindowPos(NULL, 0, 0, Width, Height, SWP_NOMOVE | SWP_NOZORDER);

	/* Set the position of the ok/cancel buttons */
  m_SaveButton.GetWindowRect(&ButtonRect);
  ScreenToClient(&ButtonRect);
  m_SaveButton.SetWindowPos(NULL, Width - MWESM_DLGFORM_BUTTONWIDTH - MWESM_DLGFORM_WIDTHMARGIN/2, ButtonRect.top, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
  m_CancelButton.GetWindowRect(&ButtonRect);
  ScreenToClient(&ButtonRect);
  m_CancelButton.SetWindowPos(NULL, Width - MWESM_DLGFORM_BUTTONWIDTH - MWESM_DLGFORM_WIDTHMARGIN/2, ButtonRect.top, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
 }
/*===========================================================================
 *		End of Class Event CEsmDialogDlg::OnSize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - void RemoveInfo (pRecInfo);
 *
 * Removes the given info record from the linked info list. Modifies
 * the previous/next info records to point to each other.
 *
 *=========================================================================*/
void CEsmDialogDlg::RemoveInfo (esmrecinfo_t* pRecInfo) {
  CEsmInfo*     pInfo = (CEsmInfo *) pRecInfo->pRecord;
  esmrecinfo_t* pNextRecInfo;
  esmrecinfo_t* pPrevRecInfo;
  bool		IsStart;

	/* Ensure valid input */
  if (pInfo == NULL) return;
  IsStart = (pInfo->GetPrevName() == NULL ||  pInfo->GetPrevName()[0] == NULL_CHAR);

	/* Find the next/previous info records */
  pNextRecInfo = CreateNewInfo(GetRecInfo(pInfo->GetNextName()));
  pPrevRecInfo = CreateNewInfo(GetRecInfo(pInfo->GetPrevName()));

	/* Modify the linked list as required */
  if (pNextRecInfo != NULL && pPrevRecInfo != NULL) {
    ((CEsmInfo *)pNextRecInfo->pRecord)->SetPrevName(((CEsmInfo *)pPrevRecInfo->pRecord)->GetID());
    ((CEsmInfo *)pPrevRecInfo->pRecord)->SetNextName(((CEsmInfo *)pNextRecInfo->pRecord)->GetID());
    if (IsStart) m_pStartInfo = (CEsmInfo *) pNextRecInfo->pRecord;
   }
  else if (pNextRecInfo != NULL) {
    ((CEsmInfo *)pNextRecInfo->pRecord)->SetPrevName(_T(""));
    if (IsStart) m_pStartInfo = (CEsmInfo *) pNextRecInfo->pRecord;
   }
  else if (pPrevRecInfo != NULL) {
    ((CEsmInfo *)pPrevRecInfo->pRecord)->SetNextName(_T(""));
    if (IsStart) m_pStartInfo = NULL;
   }
  else if (IsStart) {
    m_pStartInfo = NULL;
   }
 
 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::RemoveInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDialogDlg Method - void UpdateInfoList (FirstUpdate);
 *
 *=========================================================================*/
void CEsmDialogDlg::UpdateInfoList (const bool FirstUpdate) {
  esmrecinfo_t*  pRecInfo;
  esmrecinfo_t*  pLastRecInfo = NULL;
  CEsmInfo*      pInfo;
  CEsmInfo*      pLastInfo = NULL;
  const TCHAR*   pNextInfo;
  CEsmNpc*	 pNpc = NULL;
  int		 LastIndex;

	/* Clear the current list */
  m_InfoList.DeleteAllItems();
  pInfo = m_pStartInfo;
  if (m_pStartInfo == NULL) return;
  pNextInfo = m_pStartInfo->GetID();

	/* Initialize the filter NPC */
  if (m_pNpcFilter != NULL) pNpc = (CEsmNpc *) m_pNpcFilter->pRecord;
      
	/* Fill all next names */
  while (pNextInfo != NULL && pNextInfo[0] != NULL_CHAR) {
    pRecInfo = GetRecInfo(pNextInfo);
    if (pRecInfo == NULL) break;
    pLastRecInfo = pRecInfo;
    
    		/* Update the list item */
    if (FirstUpdate) pRecInfo->UserData = 0;
    pInfo = (CEsmInfo *) pRecInfo->pRecord;

    if (pNpc == NULL || pNpc->DoesInfoApply(pInfo)) {
      LastIndex = m_InfoList.AddItem(pRecInfo);

      if (pLastInfo != NULL) {
        //if (stricmp(pLastInfo->GetID(), pInfo->GetPrevName()) != 0) {
	  SystemLog.Printf("Broken Info List: %s != %s", pLastInfo->GetID(), pInfo->GetPrevName());
	//}
      }

      pLastInfo = pInfo;
     }

    pNextInfo = pInfo->GetNextName();
   }

	/* Iterate the INFO list to add any missing INFOs */
  if (pLastRecInfo != NULL) { /*
    pInfo = m_pStartInfo;
    pNextInfo = m_pStartInfo->GetID();
      
    while (pNextInfo != NULL && pNextInfo[0] != NULL_CHAR) {
      pRecInfo = GetRecInfo(pNextInfo);
      if (pRecInfo == NULL) break;

      CheckInfoLinks(pRecInfo, FirstUpdate, pNpc);

      pInfo = (CEsmInfo *) pRecInfo->pRecord;
      pNextInfo = pInfo->GetNextName(); 
     } //*/
   }

 }
/*===========================================================================
 *		End of Class Method CEsmDialogDlg::UpdateInfoList()
 *=========================================================================*/

