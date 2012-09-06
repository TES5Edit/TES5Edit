/*===========================================================================
 *
 * File:	Esmsounddlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmSoundDlg.h"
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

  DEFINE_FILE("EsmSoundDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmSoundDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmSoundDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmSoundDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmSoundDlg)
  ON_BN_CLICKED(IDC_SOUNDBUTTON, OnSoundbutton)
  ON_BN_CLICKED(IDC_PLAYSOUND, OnPlaysound)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmSoundDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundDlg Constructor
 *
 *=========================================================================*/
CEsmSoundDlg::CEsmSoundDlg() : CEsmRecDialog(CEsmSoundDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmSoundDlg)
  //}}AFX_DATA_INIT
  m_pSound = NULL;
 }
/*===========================================================================
 *		End of Class CEsmSoundDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmSoundDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmSoundDlg)
  DDX_Control(pDX, IDC_VOLUMETEXT, m_VolumeText);
  DDX_Control(pDX, IDC_MINRANGETEXT, m_MinRangeText);
  DDX_Control(pDX, IDC_MAXRANGETEXT, m_MaxRangeText);
  DDX_Control(pDX, IDC_SOUNDBUTTON, m_SoundButton);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmSoundDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmSoundDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmSoundDlg::GetControlData()");
  CString Buffer;  
  
	/* Update the armor pointer and data */
  m_pSound = (CEsmSound *) GetRecInfo()->pRecord;
  ASSERT(m_pSound != NULL);
  
	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pSound->SetID(TrimStringSpace(Buffer));
   }

	/* Sound volume */
  m_VolumeText.GetWindowText(Buffer);
  m_pSound->SetVolume((float)atof(Buffer));

  	/* Range */
  m_MinRangeText.GetWindowText(Buffer);
  m_pSound->SetMinRange(atoi(Buffer));
  m_MaxRangeText.GetWindowText(Buffer);
  m_pSound->SetMaxRange(atoi(Buffer));

	/* Sound filename */
  m_SoundButton.GetWindowText(Buffer);
  m_pSound->SetName(TrimStringSpace(Buffer));

 }
/*===========================================================================
 *		End of Class Method CEsmSoundDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmSoundDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_IDText.GetModify())     m_Modified = true;
  if (m_VolumeText.GetModify()) m_Modified = true;
  if (m_MinRangeText.GetModify()) m_Modified = true;
  if (m_MaxRangeText.GetModify()) m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmSoundDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmSoundDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pSound = (CEsmSound *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_VolumeText.SetLimitText(8);
  m_MinRangeText.SetLimitText(8);
  m_MaxRangeText.SetLimitText(8);
  
	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmSoundDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundDlg Event - void OnPlaysound ();
 *
 *=========================================================================*/
void CEsmSoundDlg::OnPlaysound() {
  CString	SoundFile;
  CString	Buffer;

  m_SoundButton.GetWindowText(Buffer);
  
  SoundFile  = GetMWDataPath();
  SoundFile += MWPATH_SOUNDS;
  SoundFile += Buffer;

  PlaySound(SoundFile, NULL, SND_FILENAME | SND_ASYNC | SND_NODEFAULT);
 }
/*===========================================================================
 *		End of Class Event CEsmSoundDlg::OnPlaysound()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundDlg Event - void OnSoundbutton ();
 *
 *=========================================================================*/
void CEsmSoundDlg::OnSoundbutton() {
  CString	Buffer; 
  bool		Result;

  m_SoundButton.GetWindowText(Buffer);
  Result = SelectEsmSound(Buffer, _T("Select Sound"), this);
  if (Result) m_SoundButton.SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Event CEsmSoundDlg::OnSoundbutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmSoundDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmSoundDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmSoundDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmSoundDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pSound == NULL) return;

	/* Item ID, update title as well */
  m_IDText.SetWindowText(m_pSound->GetID());
  UpdateTitle(m_pSound->GetID());

	/* Item texts */
  m_SoundButton.SetWindowText(m_pSound->GetName());
  m_MinRangeText.SetWindowText(m_pSound->GetFieldString(ESM_FIELD_MINRANGE));
  m_MaxRangeText.SetWindowText(m_pSound->GetFieldString(ESM_FIELD_MAXRANGE));
  m_VolumeText.SetWindowText(m_pSound->GetFieldString(ESM_FIELD_VOLUME));
  
 }
/*===========================================================================
 *		End of Class Method CEsmSoundDlg::SetControlData()
 *=========================================================================*/
