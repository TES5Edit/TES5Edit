/*===========================================================================
 *
 * File:	Esmrecdialog.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 8, 2003
 *
 * Description
 *
 * 18 October 2003
 *	- Model/Icon click methods updated to pass the current filenames 
 *	  onto the select file functions.
 *
 * 3 November 2003
 *	- Script edit forces record type to script to ensure the correct
 *	  record is editted.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "EsmRecDialog.h"
#include "EsmDlgArray.h"
#include "MWEdit.h"
#include "MWEditDoc.h"

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

  IMPLEMENT_DYNCREATE(CEsmRecDialog, CFormView);
  DEFINE_FILE("EsmRecDialog.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmRecDialog Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmRecDialog, CFormView)
  //{{AFX_MSG_MAP(CEsmRecDialog)
  ON_WM_DESTROY()
  ON_BN_CLICKED(IDC_SCRIPTEDIT, OnScriptEdit)
  ON_BN_CLICKED(IDCANCEL, OnCancel)
  ON_BN_CLICKED(IDC_SAVE, OnSave)
  ON_BN_CLICKED(IDC_ICONBUTTON,  OnIconbutton)
  ON_BN_CLICKED(IDC_MODELBUTTON, OnModelbutton)
  ON_COMMAND(ID_EDIT_COPY, OnEditCopy)
  ON_COMMAND(ID_EDIT_CUT, OnEditCut)
  ON_COMMAND(ID_EDIT_PASTE, OnEditPaste)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmRecDialog Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Constructor
 *
 *=========================================================================*/
CEsmRecDialog::CEsmRecDialog(const int IDD) : CFormView(IDD) {
  //{{AFX_DATA_INIT(CEsmRecDialog)
  //}}AFX_DATA_INIT
  m_DialogID = IDD;
  m_pParent  = NULL;
  m_pTitle   = NULL;

  m_Modified   = false;
  m_HasIDText  = true;
  m_hAccelator = NULL;

  	/* Initialize the record edit info structure */
  m_RecEditInfo.IsNew     = false;
  m_RecEditInfo.IsCopied  = false;
  m_RecEditInfo.HasNewID  = false;
  m_RecEditInfo.IsRenamed = false;
  m_RecEditInfo.HasAdded  = false;
  m_RecEditInfo.pRecInfo  = NULL;

 }
/*===========================================================================
 *		End of Class CEsmRecDialog Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Destructor
 *
 *=========================================================================*/
CEsmRecDialog::~CEsmRecDialog() {
  m_RecEditInfo.NewID.Empty();
  m_RecEditInfo.OldID.Empty();
 }
/*===========================================================================
 *		End of Class CEsmRecDialog Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Method - void CheckIDText (void);
 *
 * Checks the object ID of the dialog (if any) to see if it has been
 * modified.
 *
 *=========================================================================*/
void CEsmRecDialog::CheckIDText (void) {

	/* Ignore if the dialog doesn't have any ID text control */
  if (!m_HasIDText) return;

  m_IDText.GetWindowText(m_RecEditInfo.NewID);
  TrimStringSpace(m_RecEditInfo.NewID);

  if (m_RecEditInfo.OldID.CompareNoCase(m_RecEditInfo.NewID) != 0) {
    m_RecEditInfo.HasNewID = true;
   }
  else {
    m_RecEditInfo.HasNewID = false;
   }

 }
/*===========================================================================
 *		End of Class Method CEsmRecDialog::CheckIDText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmRecDialog::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmRecDialog)
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmRecDialog::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Method - CMWEditDoc* GetDocument (void);
 *
 *=========================================================================*/
CMWEditDoc* CEsmRecDialog::GetDocument (void) {
  ASSERT(m_pParent != NULL);
  ASSERT(m_pParent->GetDocument() != NULL);
  return (m_pParent->GetDocument());
 }
/*===========================================================================
 *		End of Class Method CEsmRecDialog::GetDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Method - bool IsRecord (pRecInfo);
 *
 *=========================================================================*/
bool CEsmRecDialog::IsRecord (esmrecinfo_t* pRecInfo) {
  if (pRecInfo == NULL || GetRecInfo() == NULL) return (false);
  return GetRecInfo()->pRecord->IsSame(pRecInfo->pRecord);
 }
/*===========================================================================
 *		End of Class Method CEsmRecDialog::IsRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Event - void OnDestroy ();
 *
 *=========================================================================*/
void CEsmRecDialog::OnDestroy() {
  CFormView::OnDestroy();
  if (m_pParent != NULL) m_pParent->RemoveFrame(GetParentFrame());
 }
/*===========================================================================
 *		End of Class Event CEsmRecDialog::OnDestroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Event - void OnCancel ();
 *
 *=========================================================================*/
void CEsmRecDialog::OnCancel() {
  DEFINE_FUNCTION("CEsmRecDialog::OnCancel()");

	/* Delete the record/recinfo if it is new */
  if (m_RecEditInfo.IsNew) { 
    DestroyPointer(m_RecEditInfo.pRecInfo->pRecord);
    DestroyPointer(m_RecEditInfo.pRecInfo);
   }
  
  GetParentFrame()->DestroyWindow();
 }
/*===========================================================================
 *		End of Class Event CEsmRecDialog::OnCancel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Event - void OnEditCopy ();
 *
 *=========================================================================*/
void CEsmRecDialog::OnEditCopy() {
  CWnd*  pFocusWnd = GetFocus();
  CEdit* pEditWnd;

	/* Ignore if no control currently has the focus */
  if (pFocusWnd == NULL) return;

	/* Only support copying from certain types of controls */
  if (!pFocusWnd->IsKindOf(RUNTIME_CLASS(CEdit))) return;
  pEditWnd = (CEdit *)pFocusWnd;
  pEditWnd->Copy();
 }
/*===========================================================================
 *		End of Class Event CEsmRecDialog::OnEditCopy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Event - void OnEditCut ();
 *
 *=========================================================================*/
void CEsmRecDialog::OnEditCut() {
  CWnd*  pFocusWnd = GetFocus();
  CEdit* pEditWnd;

	/* Ignore if no control currently has the focus */
  if (pFocusWnd == NULL) return;

	/* Only support cutting from certain types of controls */
  if (!pFocusWnd->IsKindOf(RUNTIME_CLASS(CEdit))) return;
  pEditWnd = (CEdit *)pFocusWnd;
  pEditWnd->Cut();
 }
/*===========================================================================
 *		End of Class Event CEsmRecDialog::OnEditCut()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Event - void OnEditPaste ();
 *
 *=========================================================================*/
void CEsmRecDialog::OnEditPaste() {
  CWnd*  pFocusWnd = GetFocus();
  CEdit* pEditWnd;

	/* Ignore if no control currently has the focus */
  if (pFocusWnd == NULL) return;

	/* Only support pasting to certain types of controls */
  if (!pFocusWnd->IsKindOf(RUNTIME_CLASS(CEdit))) return;
  pEditWnd = (CEdit *)pFocusWnd;
  pEditWnd->Paste();
 }
/*===========================================================================
 *		End of Class Event CEsmRecDialog::OnEditPaste()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Event - void OnIconbutton ();
 *
 *=========================================================================*/
void CEsmRecDialog::OnIconbutton() {
  CString Filename;
  bool	  Result;

  m_IconButton.GetWindowText(Filename);
  Result = SelectEsmIcon(Filename, _T("Select Icon"), this);

  if (Result) {
    m_IconButton.SetWindowText(Filename);
    m_IconPicture.SetEsmIcon(Filename, true);
   }
 }
/*===========================================================================
 *		End of Class Event CEsmRecDialog::OnIconbutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmRecDialog::OnInitialUpdate() {
  CFormView::OnInitialUpdate();
  ResizeParentToFit(FALSE);
  m_Modified = false;

	/* Load the default accelerator table */
  m_hAccelator = LoadAccelerators(AfxGetApp()->m_hInstance, MAKEINTRESOURCE(IDR_RECORD_ACCEL));
  
	/* Save the record's initial object ID */
  ASSERT(GetRecInfo() != NULL);
  m_RecEditInfo.OldID = GetRecInfo()->pRecord->GetID();

	/* Limit the size of the input ID text control */
  if (m_HasIDText) m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
 }
/*===========================================================================
 *		End of Class Event CEsmRecDialog::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Event - void OnModelbutton ();
 *
 *=========================================================================*/
void CEsmRecDialog::OnModelbutton() {
  CString Filename;
  bool	  Result;

  m_ModelButton.GetWindowText(Filename);
  Result = SelectEsmModel(Filename, _T("Select Model"), this);
  if (Result) m_ModelButton.SetWindowText(Filename);
 }
/*===========================================================================
 *		End of Class Event CEsmRecDialog::OnModelbutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Event - int OnPostSaveRecord (void);
 *
 *=========================================================================*/
int CEsmRecDialog::OnPostSaveRecord (void) {
  ASSERT(m_pParent != NULL);
  return (m_pParent->OnPostSaveRecord(&m_RecEditInfo));
 }
/*===========================================================================
 *		End of Class Event CEsmRecDialog::OnPostSaveRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Method - int OnPreSaveRecord (void);
 *
 *=========================================================================*/
int CEsmRecDialog::OnPreSaveRecord (void) {
  //DEFINE_FUNCTION("CEsmRecDialog::OnPreSaveRecord()");

	/* Ensure a valid object state */
  ASSERT(m_pParent != NULL);
  
	/* Update the record ID if it is changed */
  if (m_HasIDText) CheckIDText();

	/* Call the parent event */
  return m_pParent->OnPreSaveRecord(&m_RecEditInfo);
 }
/*===========================================================================
 *		End of Class Method CEsmRecDialog::OnPreSaveRecord()
 *=========================================================================*/
 

/*===========================================================================
 *
 * Class CEsmRecDialog Event - void OnSave ();
 *
 *=========================================================================*/
void CEsmRecDialog::OnSave() {
  int Result;

	/* Call the pre-save event */
  Result = OnPreSaveRecord();

  if (Result == MWESM_ONSAVE_ABORTEDIT) {
    OnCancel();
    return;
   }
  else if (Result < 0) 
    return;

	/* Save the record data */
  GetControlData();

	/* Call the post-save event */
  Result = OnPostSaveRecord();

  if (Result == MWESM_ONSAVE_ABORTEDIT) {
    OnCancel();
    return;
   }
  else if (Result < 0) 
    return;

	/* Close the window */
  GetParentFrame()->DestroyWindow();
 }
/*===========================================================================
 *		End of Class Event CEsmRecDialog::OnSave()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Event - void OnScriptEdit ();
 *
 *=========================================================================*/
void CEsmRecDialog::OnScriptEdit() {
  esmrecinfo_t* pRecInfo;
  CString	Buffer;
  
  m_ScriptList.GetWindowText(Buffer);
  pRecInfo = GetDocument()->FindRecord(Buffer, MWESM_REC_SCPT);

  if (pRecInfo != NULL) {
    GetParentDlg()->EditRecord(pRecInfo);
    m_Modified = true;
   }

 }
/*===========================================================================
 *		End of Class Event CEsmRecDialog::OnScriptEdit()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Event - void OnUpdate (pSender, lHint, pHint);
 *
 *=========================================================================*/
void CEsmRecDialog::OnUpdate(CView* pSender, LPARAM lHint, CObject* pHint) {

  switch (lHint) {
    case MWEDITDOC_HINT_UPDATE:
	OnUpdateRecord();
	break;
    case MWEDITDOC_HINT_UPDATEITEM:
	OnUpdateItem((esmrecinfo_t*) pHint);
	break;
    case MWEDITDOC_HINT_NEWITEM:
	OnUpdateAddItem((esmrecinfo_t*) pHint);
	break;
    default:
	CFormView::OnUpdate(pSender, lHint, pHint);
	break;
   }
 }
/*===========================================================================
 *		End of Class Event CEsmRecDialog::OnUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Method - BOOL PreTranslateMessage (pMsg);
 *
 *=========================================================================*/
BOOL CEsmRecDialog::PreTranslateMessage(MSG* pMsg) {
  int Result;

  if (pMsg->message >= WM_KEYFIRST && pMsg->message <= WM_KEYLAST && m_hAccelator != NULL) {
    Result = TranslateAccelerator(m_hWnd, m_hAccelator, pMsg);

    if (Result != 0) {
      return (Result);
     }
   }
	
  return CFormView::PreTranslateMessage(pMsg);
 }
/*===========================================================================
 *		End of Class Method CEsmRecDialog::PreTranslateMessage()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecDialog Method - void UpdateTitle (pItemID);
 *
 *=========================================================================*/
void CEsmRecDialog::UpdateTitle (const TCHAR* pItemID) {
  CString Buffer;

  Buffer.Format(_T("%s -- %s -- %s"), m_pParent ? m_pParent->GetDocFilename() : _T("Unknown"), 
				      m_pTitle ? m_pTitle : _T(""), (pItemID && *pItemID != NULL_CHAR) ? pItemID : _T("New Object"));

  SetInternalWindowText(GetParentFrame()->m_hWnd, Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmRecDialog::UpdateTitle()
 *=========================================================================*/

