/*===========================================================================
 *
 * File:	Esmsoundgendlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 19, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmSoundGenDlg.h"
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

  DEFINE_FILE("EsmSoundGenDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmSoundGenDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmSoundGenDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmSoundGenDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmSoundGenDlg)
  ON_BN_CLICKED(IDC_PLAYSOUND, OnPlaysound)
  ON_CBN_SELCHANGE(IDC_CREATURELIST, OnSelchangeList)
  ON_CBN_SELCHANGE(IDC_SOUNDLIST, OnSelchangeList)
  ON_CBN_SELCHANGE(IDC_TYPELIST, OnSelchangeList)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmSoundGenDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundGenDlg Constructor
 *
 *=========================================================================*/
CEsmSoundGenDlg::CEsmSoundGenDlg() : CEsmRecDialog(CEsmSoundGenDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmSoundGenDlg)
  //}}AFX_DATA_INIT
  m_pSoundGen = NULL;
 }
/*===========================================================================
 *		End of Class CEsmSoundGenDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundGenDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmSoundGenDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmSoundGenDlg)
  DDX_Control(pDX, IDC_TYPELIST, m_TypeList);
  DDX_Control(pDX, IDC_SOUNDLIST, m_SoundList);
  DDX_Control(pDX, IDC_CREATURELIST, m_CreatureList);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmSoundGenDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundGenDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmSoundGenDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmSoundGenDlg::GetControlData()");
  CString Buffer;  
  int     Index;
  
	/* Update the armor pointer and data */
  m_pSoundGen = (CEsmSoundGen *) GetRecInfo()->pRecord;
  ASSERT(m_pSoundGen != NULL);
  
	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pSoundGen->SetID(TrimStringSpace(Buffer));
   }

	/* Sound ID */
  m_SoundList.GetWindowText(Buffer);
  m_pSoundGen->SetSound(Buffer);

  	/* Creature list */
  m_CreatureList.GetWindowText(Buffer);
  m_pSoundGen->SetCreature(Buffer);

	/* Type list */
  Index = m_TypeList.GetCurSel();
  if (Index >= 0) m_pSoundGen->SetSoundType(m_TypeList.GetItemData(Index));

 }
/*===========================================================================
 *		End of Class Method CEsmSoundGenDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundGenDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmSoundGenDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_IDText.GetModify()) m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmSoundGenDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundGenDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmSoundGenDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pSoundGen = (CEsmSoundGen *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  FillEsmSoundCombo(m_SoundList);
  FillEsmCreatureCombo(m_CreatureList);
  FillEsmSoundGenTypeCombo(m_TypeList);
  
	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmSoundGenDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundGenDlg Event - void OnPlaysound ();
 *
 *=========================================================================*/
void CEsmSoundGenDlg::OnPlaysound() {
  CString	SoundFile;
  CString	Buffer;
  CEsmSound*	pSound;
  esmrecinfo_t* pRecInfo;
  int		Index;

  Index = m_SoundList.GetCurSel();
  if (Index < 0) return;
  pRecInfo = (esmrecinfo_t *) m_SoundList.GetItemData(Index);
  pSound = (CEsmSound *) pRecInfo->pRecord;
  
  SoundFile  = GetMWDataPath();
  SoundFile += MWPATH_SOUNDS;
  SoundFile += pSound->GetName();

  PlaySound(SoundFile, NULL, SND_FILENAME | SND_ASYNC | SND_NODEFAULT);
 }
/*===========================================================================
 *		End of Class Event CEsmSoundGenDlg::OnPlaysound()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundGenDlg Event - void OnSelchangeList ();
 *
 *=========================================================================*/
void CEsmSoundGenDlg::OnSelchangeList() {
  UpdateID();
 }
/*===========================================================================
 *		End of Class Event CEsmSoundGenDlg::OnSelchangeList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundGenDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmSoundGenDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  esmrecinfo_t*  pOldRecInfo = NULL;
  int	  	 Index;

  if (pRecInfo->pRecord->IsType(MWESM_REC_CREA)) {
    Index = m_CreatureList.GetCurSel();
    if (Index >= 0) pOldRecInfo = (esmrecinfo_t *) m_CreatureList.GetItemData(Index);
    FillEsmCreatureCombo(m_CreatureList);
    FindComboListItem(m_CreatureList, (DWORD) pOldRecInfo, true);
   }
  else if (pRecInfo->pRecord->IsType(MWESM_REC_SOUN)) {
    Index = m_SoundList.GetCurSel();
    if (Index >= 0) pOldRecInfo = (esmrecinfo_t *) m_SoundList.GetItemData(Index);
    FillEsmSoundCombo(m_SoundList);
    FindComboListItem(m_SoundList, (DWORD) pOldRecInfo, true);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmSoundGenDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundGenDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmSoundGenDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pSoundGen == NULL) return;

	/* Item ID, update title as well */
  m_IDText.SetWindowText(m_pSoundGen->GetID());
  UpdateTitle(m_pSoundGen->GetID());

	/* Item lists */
  FindComboListItem(m_TypeList, m_pSoundGen->GetSoundType(), true);
  m_SoundList.SelectString(-1, m_pSoundGen->GetSound());
  m_CreatureList.SelectString(-1, m_pSoundGen->GetCreature());
  
  if (m_pSoundGen->GetID() == NULL || *m_pSoundGen->GetID() == NULL_CHAR) UpdateID();
 }
/*===========================================================================
 *		End of Class Method CEsmSoundGenDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundGenDlg Method - void UpdateID (void);
 *
 *=========================================================================*/
void CEsmSoundGenDlg::UpdateID (void) {
  //DEFINE_FUNCTION("CEsmSoundGenDlg::UpdateID()");
  CString CreatureName;
  CString NewID;
  int     Index;
  int	  SoundType = 0;

	/* Get the control data */
  m_CreatureList.GetWindowText(CreatureName);
  if (CreatureName.IsEmpty())  CreatureName = _T("DEFAULT");
  Index = m_TypeList.GetCurSel();
  if (Index >= 0) SoundType = m_TypeList.GetItemData(Index);

	/* Create the new ID string */
  NewID.Format(_T("%s%04d"), CreatureName, SoundType);
  if (NewID.GetLength() > MWESM_ID_MAXSIZE) NewID.SetAt(MWESM_ID_MAXSIZE, NULL_CHAR);
  m_IDText.SetWindowText(NewID);
  m_IDText.SetModify(TRUE);
 }
/*===========================================================================
 *		End of Class Method CEsmSoundGenDlg::SetControlData()
 *=========================================================================*/

