/*===========================================================================
 *
 * File:	Esmdoordlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 15, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmDoorDlg.h"
#include "mmsystem.h"


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

  IMPLEMENT_DYNCREATE(CEsmDoorDlg, CEsmRecDialog);
  DEFINE_FILE("EsmDoorDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmDoorDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmDoorDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmDoorDlg)
  ON_BN_CLICKED(IDC_OPENPLAY, OnOpenPlay)
  ON_BN_CLICKED(IDC_CLOSEPLAY, OnClosePlay)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmDoorDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDoorDlg Constructor
 *
 *=========================================================================*/
CEsmDoorDlg::CEsmDoorDlg() : CEsmRecDialog(CEsmDoorDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmDoorDlg)
  //}}AFX_DATA_INIT
  m_pDoor = NULL;
 }
/*===========================================================================
 *		End of Class CEsmDoorDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDoorDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmDoorDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmDoorDlg)
  DDX_Control(pDX, IDC_PERSISTCHECK, m_PersistCheck);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_OPENLIST, m_OpenList);
  DDX_Control(pDX, IDC_CLOSELIST, m_CloseList);
  DDX_Control(pDX, IDC_MODELBUTTON, m_ModelButton);
  DDX_Control(pDX, IDC_SCRIPTLIST, m_ScriptList);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmDoorDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDoorDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmDoorDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmDoorDlg::GetControlData()");
  CString	 Buffer;  

	/* Update the armor pointer and data */
  m_pDoor = (CEsmDoor *) GetRecInfo()->pRecord;
  if (m_pDoor == NULL) return;

	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pDoor->SetID(TrimStringSpace(Buffer));
   }

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pDoor->SetName(TrimStringSpace(Buffer));

	/* Item script */
  m_ScriptList.GetWindowText(Buffer);
  m_pDoor->SetScript(TrimStringSpace(Buffer));

	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pDoor->SetModel(TrimStringSpace(Buffer));

  	/* Open filename */
  m_OpenList.GetWindowText(Buffer);
  m_pDoor->SetOpenSound(TrimStringSpace(Buffer));

  	/* Close filename */
  m_CloseList.GetWindowText(Buffer);
  m_pDoor->SetCloseSound(TrimStringSpace(Buffer));

	/* Record flags */
  m_pDoor->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pDoor->SetBlocked(m_BlockedCheck.GetCheck() != 0);
 }
/*===========================================================================
 *		End of Class Method CEsmDoorDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDoorDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmDoorDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_NameText.GetModify()) m_Modified = true;
  if (m_IDText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmDoorDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDoorDlg Event - void OnClosebutton ();
 *
 *=========================================================================*/
void CEsmDoorDlg::OnClosebutton() {
 }
/*===========================================================================
 *		End of Class Event CEsmDoorDlg::OnClosebutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDoorDlg Event - void OnOpenbutton ();
 *
 *=========================================================================*/
void CEsmDoorDlg::OnOpenbutton() {
 }
/*===========================================================================
 *		End of Class Event CEsmDoorDlg::OnOpenbutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDoorDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmDoorDlg::OnInitialUpdate() {
  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pDoor = (CEsmDoor *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmScriptCombo(m_ScriptList);
  FillEsmSoundCombo(m_OpenList);
  FillEsmSoundCombo(m_CloseList);
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
   
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmDoorDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDoorDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmDoorDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  CString Buffer;

  	/* Refill the script list if required */
  if (pRecInfo->pRecord->IsType(MWESM_REC_SCRI)) {
    esmrecinfo_t* pRecInfo = NULL;
    int	  	  Index;

    Index = m_ScriptList.GetCurSel();
    if (Index >= 0) pRecInfo = (esmrecinfo_t *) m_ScriptList.GetItemData(Index);
    FillEsmScriptCombo(m_ScriptList);
    FindComboListItem(m_ScriptList, (DWORD) pRecInfo, true);
   }
	/* Update the sound list */
  else if (pRecInfo->pRecord->IsType(MWESM_REC_SOUN)) {
    CString Buffer1;
    m_OpenList.GetWindowText(Buffer);
    m_CloseList.GetWindowText(Buffer1);

    FillEsmSoundCombo(m_OpenList);
    FillEsmSoundCombo(m_CloseList);

    m_OpenList.SelectString(-1, Buffer);
    m_CloseList.SelectString(-1, Buffer1);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmDoorDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDoorDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmDoorDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pDoor == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pDoor->GetID());
  UpdateTitle(m_pDoor->GetID());

	/* Item strings and values */
  m_NameText.SetWindowText(m_pDoor->GetName());
  m_NameText.SetModify(FALSE);

	/* Model/sound buttons */
  m_ModelButton.SetWindowText(m_pDoor->GetModel());
  m_OpenList.SelectString(-1, m_pDoor->GetOpenSound());
  m_CloseList.SelectString(-1, m_pDoor->GetCloseSound());
  
	/* Item lists */
  m_ScriptList.SelectString(-1, m_pDoor->GetScript());

	/* Record flags */
  m_BlockedCheck.SetCheck(m_pDoor->IsBlocked());
  m_PersistCheck.SetCheck(m_pDoor->IsPersist());

 }
/*===========================================================================
 *		End of Class Method CEsmDoorDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDoorDlg Event - void OnClosePlay ();
 *
 *=========================================================================*/
void CEsmDoorDlg::OnClosePlay() {
  CString	SoundFile;
  CEsmSound*	pSound;
  esmrecinfo_t* pRecInfo;
  int		ListIndex;

  ListIndex = m_CloseList.GetCurSel();

  if (ListIndex >= 0) {
    pRecInfo = (esmrecinfo_t *) m_CloseList.GetItemData(ListIndex);
    pSound = (CEsmSound *) pRecInfo->pRecord;

    SoundFile  = GetMWDataPath();
    SoundFile += MWPATH_SOUNDS;
    SoundFile += pSound->GetName();

    PlaySound(SoundFile, NULL, SND_FILENAME | SND_ASYNC | SND_NODEFAULT);
   }
 }
/*===========================================================================
 *		End of Class Event CEsmDoorDlg::OnClosePlay()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmDoorDlg Event - void OnOpenPlay ();
 *
 *=========================================================================*/
void CEsmDoorDlg::OnOpenPlay() {
  CString	SoundFile;
  CEsmSound*	pSound;
  esmrecinfo_t* pRecInfo;
  int		ListIndex;

  ListIndex = m_OpenList.GetCurSel();

  if (ListIndex >= 0) {
    pRecInfo = (esmrecinfo_t *) m_OpenList.GetItemData(ListIndex);
    pSound = (CEsmSound *) pRecInfo->pRecord;

    SoundFile  = GetMWDataPath();
    SoundFile += MWPATH_SOUNDS;
    SoundFile += pSound->GetName();

    PlaySound(SoundFile, NULL, SND_FILENAME | SND_ASYNC | SND_NODEFAULT);
   }

 }
/*===========================================================================
 *		End of Class Event CEsmDoorDlg::OnOpenPlay()
 *=========================================================================*/
