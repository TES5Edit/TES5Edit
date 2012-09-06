/*===========================================================================
 *
 * File:	Esmlightdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmLightDlg.h"
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

  IMPLEMENT_DYNCREATE(CEsmLightDlg, CEsmRecDialog);
  DEFINE_FILE("EsmLightDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmLightDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmLightDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmLightDlg)
  ON_BN_CLICKED(IDC_COLORBUTTON, OnColorbutton)
  ON_BN_CLICKED(IDC_CANCARRYCHECK, OnCancarrycheck)
  ON_EN_CHANGE(IDC_REDTEXT, OnChangeColor)
  ON_EN_CHANGE(IDC_GREENTEXT, OnChangeColor)
  ON_EN_CHANGE(IDC_BLUETEXT, OnChangeColor)
  ON_BN_CLICKED(IDC_SOUNDPLAY, OnSoundPlay)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmLightDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLightDlg Constructor
 *
 *=========================================================================*/
CEsmLightDlg::CEsmLightDlg() : CEsmRecDialog(CEsmLightDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmLightDlg)
  //}}AFX_DATA_INIT
  m_pLight = NULL;
 }
/*===========================================================================
 *		End of Class CEsmLightDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLightDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmLightDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmLightDlg)
  DDX_Control(pDX, IDC_RSPIN, m_RedSpin);
  DDX_Control(pDX, IDC_GSPIN, m_GreenSpin);
  DDX_Control(pDX, IDC_BSPIN, m_BlueSpin);
  DDX_Control(pDX, IDC_ICONPICTURE, m_IconPicture);
  DDX_Control(pDX, IDC_COLORBOX, m_ColorBox);
  DDX_Control(pDX, IDC_PERSISTCHECK, m_PersistCheck);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_CANCARRYCHECK, m_CanCarryCheck);
  DDX_Control(pDX, IDC_OFFCHECK, m_OffCheck);
  DDX_Control(pDX, IDC_FIRECHECK, m_FireCheck);
  DDX_Control(pDX, IDC_DYNAMICCHECK, m_DynamicCheck);
  DDX_Control(pDX, IDC_NEGATIVECHECK, m_NegativeCheck);
  DDX_Control(pDX, IDC_VALUETEXT, m_ValueText);
  DDX_Control(pDX, IDC_WEIGHTTEXT, m_WeightText);
  DDX_Control(pDX, IDC_FLICKERLIST, m_FlickerList);
  DDX_Control(pDX, IDC_SOUNDLIST, m_SoundList);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_RADIUSTEXT, m_RadiusText);
  DDX_Control(pDX, IDC_TIMETEXT, m_TimeText);
  DDX_Control(pDX, IDC_REDTEXT, m_RedText);
  DDX_Control(pDX, IDC_GREENTEXT, m_GreenText);
  DDX_Control(pDX, IDC_BLUETEXT, m_BlueText);
  DDX_Control(pDX, IDC_ICONBUTTON, m_IconButton);
  DDX_Control(pDX, IDC_MODELBUTTON, m_ModelButton);
  DDX_Control(pDX, IDC_SCRIPTLIST, m_ScriptList);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmLightDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLightDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmLightDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmLightDlg::GetControlData()");
  lightdata_t*	pLightData;
  CString	Buffer;
  int		Index;

	/* Update the armor pointer and data */
  m_pLight = (CEsmLight *) GetRecInfo()->pRecord;
  if (m_pLight == NULL) return;
  pLightData = m_pLight->GetLightData();
  ASSERT(pLightData != NULL);

	/* Armor ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pLight->SetID(TrimStringSpace(Buffer));
   }

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pLight->SetName(TrimStringSpace(Buffer));

	/* Item weight */
  m_WeightText.GetWindowText(Buffer);
  pLightData->Weight = (float) atof(Buffer);

	/* Item value */
  m_ValueText.GetWindowText(Buffer);
  pLightData->Value = atoi(Buffer);

	/* Light radius */
  m_RadiusText.GetWindowText(Buffer);
  pLightData->Radius = atoi(Buffer);

	/* Flicker list */
  Index = m_FlickerList.GetCurSel();
  pLightData->Flags &= ~pLightData->Flags;	/* Clear flicker flags */
  if (Index >= 0) pLightData->Flags = m_FlickerList.GetItemData(Index);

	/* Carry options */
  if (m_CanCarryCheck.GetCheck() != 0) {
    pLightData->Flags |= MWESM_LIGHTFLAG_CANCARRY;
    m_TimeText.GetWindowText(Buffer);    
    pLightData->Time = atoi(Buffer);
    m_WeightText.GetWindowText(Buffer);    
    pLightData->Weight = (float) atof(Buffer);
    m_ValueText.GetWindowText(Buffer);    
    pLightData->Value = atoi(Buffer);
    m_IconButton.GetWindowText(Buffer);
    m_pLight->SetIcon(TrimStringSpace(Buffer));
    m_NameText.GetWindowText(Buffer);
    m_pLight->SetName(TrimStringSpace(Buffer));

    if (m_OffCheck.GetCheck())
      pLightData->Flags |= MWESM_LIGHTFLAG_DEFAULTOFF;
    else
      pLightData->Flags &= ~MWESM_LIGHTFLAG_DEFAULTOFF;

   }
  else {
    pLightData->Flags &= ~MWESM_LIGHTFLAG_CANCARRY;
    pLightData->Flags &= ~MWESM_LIGHTFLAG_DEFAULTOFF;
    m_pLight->SetName(NULL);
    m_pLight->SetIcon(NULL);
    pLightData->Weight = 0;
    pLightData->Value  = 0;
    pLightData->Time   = 0;
   }

  	/* Light color */
  m_RedText.GetWindowText(Buffer);
  pLightData->Red   = (byte)atoi(Buffer);
  m_GreenText.GetWindowText(Buffer);
  pLightData->Green = (byte)atoi(Buffer);
  m_BlueText.GetWindowText(Buffer);
  pLightData->Blue  = (byte)atoi(Buffer);

	/* Item script */
  m_ScriptList.GetWindowText(Buffer);
  m_pLight->SetScript(TrimStringSpace(Buffer));

  	/* Item sound */
  m_SoundList.GetWindowText(Buffer);
  m_pLight->SetSound(TrimStringSpace(Buffer));

	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pLight->SetModel(TrimStringSpace(Buffer));

  	/* Icon filename */
  m_IconButton.GetWindowText(Buffer);
  m_pLight->SetIcon(TrimStringSpace(Buffer));

	/* Record flags */
  m_pLight->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pLight->SetBlocked(m_BlockedCheck.GetCheck() != 0);

  if (m_FireCheck.GetCheck() != 0)
    pLightData->Flags |= MWESM_LIGHTFLAG_ISFIRE; 
  else
    pLightData->Flags &= ~MWESM_LIGHTFLAG_ISFIRE; 

  if (m_DynamicCheck.GetCheck() != 0)
    pLightData->Flags |= MWESM_LIGHTFLAG_DYNAMIC;
  else
    pLightData->Flags &= ~MWESM_LIGHTFLAG_DYNAMIC;

  if (m_NegativeCheck.GetCheck() != 0)
    pLightData->Flags |= MWESM_LIGHTFLAG_NEGATIVE;
  else
    pLightData->Flags &= ~MWESM_LIGHTFLAG_NEGATIVE;

 }
/*===========================================================================
 *		End of Class Method CEsmLightDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLightDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmLightDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_WeightText.GetModify()) m_Modified = true;
  if (m_ValueText.GetModify()) m_Modified = true;
  if (m_NameText.GetModify()) m_Modified = true;
  if (m_IDText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmLightDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLightDlg Event - void OnCancarrycheck ();
 *
 *=========================================================================*/
void CEsmLightDlg::OnCancarrycheck() {
  m_ValueText.EnableWindow(m_CanCarryCheck.GetCheck());
  m_WeightText.EnableWindow(m_CanCarryCheck.GetCheck());
  m_IconButton.EnableWindow(m_CanCarryCheck.GetCheck());
  m_IconPicture.EnableWindow(m_CanCarryCheck.GetCheck());
  m_NameText.EnableWindow(m_CanCarryCheck.GetCheck());
  m_TimeText.EnableWindow(m_CanCarryCheck.GetCheck());
  m_OffCheck.EnableWindow(m_CanCarryCheck.GetCheck());
 }
/*===========================================================================
 *		End of Class Event CEsmLightDlg::OnCancarrycheck()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLightDlg Event - void OnChangeColor ();
 *
 *=========================================================================*/
void CEsmLightDlg::OnChangeColor() {
  CString Buffer;
  int     Red;
  int     Green;
  int     Blue;

  if (!::IsWindow(m_RedText.m_hWnd)) return;

  m_RedText.GetWindowText(Buffer);
  Red   = atoi(Buffer);
  if (Red < 0)   Red = 0;
  if (Red > 255) Red = 255;
  m_GreenText.GetWindowText(Buffer);
  Green = atoi(Buffer);
  if (Green < 0)   Green = 0;
  if (Green > 255) Green = 255;
  m_BlueText.GetWindowText(Buffer);
  Blue  = atoi(Buffer);
  if (Blue < 0)   Blue = 0;
  if (Blue > 255) Blue = 255;

  m_ColorBox.SetColor(Red, Green, Blue);
  m_ColorBox.RedrawWindow();
 }
/*===========================================================================
 *		End of Class Event CEsmLightDlg::OnChangeColor()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLightDlg Event - void OnColorbutton ();
 *
 *=========================================================================*/
void CEsmLightDlg::OnColorbutton() {
  int		Result;
  CString	Buffer;
  int		Red;
  int		Green;
  int		Blue;

  m_RedText.GetWindowText(Buffer);
  Red   = atoi(Buffer);
  if (Red < 0)   Red = 0;
  if (Red > 255) Red = 255;
  m_GreenText.GetWindowText(Buffer);
  Green = atoi(Buffer);
  if (Green < 0)   Green = 0;
  if (Green > 255) Green = 255;
  m_BlueText.GetWindowText(Buffer);
  Blue  = atoi(Buffer);
  if (Blue < 0)   Blue = 0;
  if (Blue > 255) Blue = 255;

	/* Initialize and display the dialog */
  CColorDialog  ColorDlg(RGB(Red, Green, Blue), CC_ANYCOLOR | CC_FULLOPEN, this);
  Result = ColorDlg.DoModal();
  if (Result != IDOK) return;

  Red   = GetRValue(ColorDlg.GetColor());
  Green = GetGValue(ColorDlg.GetColor());
  Blue  = GetBValue(ColorDlg.GetColor());
  Buffer.Format(_T("%d"), Red);
  m_RedText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), Green);
  m_GreenText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), Blue);
  m_BlueText.SetWindowText(Buffer);

  m_ColorBox.SetColor(Red, Green, Blue);
 }
/*===========================================================================
 *		End of Class Event CEsmLightDlg::OnColorbutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLightDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmLightDlg::OnInitialUpdate() {

  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pLight = (CEsmLight *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmLightFlickerCombo(m_FlickerList);
  FillEsmScriptCombo(m_ScriptList);
  FillEsmSoundCombo(m_SoundList);
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
  m_WeightText.SetLimitText(16);
  m_ValueText.SetLimitText(16);
  m_TimeText.SetLimitText(8);
  m_RedText.SetLimitText(3);
  m_GreenText.SetLimitText(3);
  m_BlueText.SetLimitText(3);
  m_RadiusText.SetLimitText(8);
  m_RedSpin.SetRange32(0, 255);
  m_GreenSpin.SetRange32(0,255);
  m_BlueSpin.SetRange32(0,255);
    
	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmLightDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLightDlg Event - void OnSoundPlay ();
 *
 *=========================================================================*/
void CEsmLightDlg::OnSoundPlay() {
  CString	SoundFile;
  CEsmSound*	pSound;
  esmrecinfo_t* pRecInfo;
  int		ListIndex;

  ListIndex = m_SoundList.GetCurSel();

  if (ListIndex >= 0) {
    pRecInfo = (esmrecinfo_t *) m_SoundList.GetItemData(ListIndex);
    pSound = (CEsmSound *) pRecInfo->pRecord;

    SoundFile  = GetMWDataPath();
    SoundFile += MWPATH_SOUNDS;
    SoundFile += pSound->GetName();

    PlaySound(SoundFile, NULL, SND_FILENAME | SND_ASYNC | SND_NODEFAULT);
   }

 }
/*===========================================================================
 *		End of Class Event CEsmLightDlg::OnSoundPlay()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLightDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmLightDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
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
	/* Refill the sound list if required */
  else if (pRecInfo->pRecord->IsType(MWESM_REC_SOUN)) {
    m_SoundList.GetWindowText(Buffer);
    FillEsmSoundCombo(m_SoundList);
    m_SoundList.SelectString(-1, Buffer);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmLightDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmLightDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmLightDlg::SetControlData (void) {
  CString      Buffer;
  lightdata_t* pLightData;

	/* Ignore if the current item is not valid */
  if (m_pLight == NULL) return;
  pLightData = m_pLight->GetLightData();

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pLight->GetID());
  UpdateTitle(m_pLight->GetID());

	/* Model buttons */
  m_ModelButton.SetWindowText(m_pLight->GetModel());
  
  	/* Light radius */
  Buffer.Format(_T("%d"), pLightData->Radius);
  m_RadiusText.SetWindowText(Buffer);
  
  if (m_pLight->IsCanCarry()) {
    Buffer.Format(_T("%d"), pLightData->Time);
    m_TimeText.SetWindowText(Buffer);    
    m_IconButton.SetWindowText(m_pLight->GetIcon());
    m_IconPicture.SetEsmIcon(m_pLight->GetIcon());
    m_NameText.SetWindowText(m_pLight->GetName());
    Buffer.Format(_T("%.2f"), pLightData->Weight);
    m_WeightText.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), pLightData->Value);
    m_ValueText.SetWindowText(Buffer);
    m_OffCheck.SetCheck(m_pLight->IsDefaultOff());
    m_CanCarryCheck.SetCheck(TRUE);
   }
  else {
    m_NameText.EnableWindow(FALSE);
    m_WeightText.EnableWindow(FALSE);
    m_ValueText.EnableWindow(FALSE); 
    m_TimeText.SetWindowText(_T(""));    
    m_TimeText.EnableWindow(FALSE);    
    m_IconButton.SetWindowText(_T(""));
    m_IconButton.EnableWindow(FALSE);
    m_OffCheck.EnableWindow(FALSE);
    m_IconPicture.EnableWindow(FALSE);
    m_CanCarryCheck.SetCheck(FALSE);
   }

	/* Item strings and values */
  m_NameText.SetModify(FALSE);
  m_WeightText.SetModify(FALSE);
  m_ValueText.SetModify(FALSE);

  	/* Light color */
  Buffer.Format(_T("%d"), (int)pLightData->Red);
  m_RedText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int)pLightData->Green);
  m_GreenText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int)pLightData->Blue);
  m_BlueText.SetWindowText(Buffer);
  m_ColorBox.SetColor(pLightData->Red, pLightData->Green, pLightData->Blue);

	/* Script and sound lists */
  m_ScriptList.SelectString(-1, m_pLight->GetScript());
  m_SoundList.SelectString(-1, m_pLight->GetSound());
  
	/* Flicker type list */
  if (m_pLight->IsFlicker())
    FindComboListItem(m_FlickerList, MWESM_LIGHTFLAG_FLICKER, true);
  else if (m_pLight->IsFlickerSlow())
    FindComboListItem(m_FlickerList, MWESM_LIGHTFLAG_FLICKERSLOW, true);
  else if (m_pLight->IsPulse())
    FindComboListItem(m_FlickerList, MWESM_LIGHTFLAG_PULSE, true);
  else if (m_pLight->IsPulseSlow())
    FindComboListItem(m_FlickerList, MWESM_LIGHTFLAG_PULSESLOW, true);
  else
    FindComboListItem(m_FlickerList, 0, true);
 
	/* Record flags */
  m_BlockedCheck.SetCheck(m_pLight->IsBlocked());
  m_PersistCheck.SetCheck(m_pLight->IsPersist());
  m_CanCarryCheck.SetCheck(m_pLight->IsCanCarry());
  m_FireCheck.SetCheck(m_pLight->IsFire());
  m_DynamicCheck.SetCheck(m_pLight->IsDynamic());
  m_NegativeCheck.SetCheck(m_pLight->IsNegative());
 }
/*===========================================================================
 *		End of Class Method CEsmLightDlg::SetControlData()
 *=========================================================================*/
