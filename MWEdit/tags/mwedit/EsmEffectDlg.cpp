/*===========================================================================
 *
 * File:	Esmeffectdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmEffectDlg.h"
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

  IMPLEMENT_DYNCREATE(CEsmEffectDlg, CEsmRecDialog);
  DEFINE_FILE("EsmEffectDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmEffectDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmEffectDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmEffectDlg)
  ON_BN_CLICKED(IDC_CASTPLAY, OnCastPlay)
  ON_BN_CLICKED(IDC_AREAPLAY, OnAreaPlay)
  ON_BN_CLICKED(IDC_HITPLAY, OnHitPlay)
  ON_BN_CLICKED(IDC_BOLTPLAY, OnBoltPlay)
  ON_EN_CHANGE(IDC_REDTEXT, OnChangeColor)
  ON_BN_CLICKED(IDC_COLORBUTTON, OnColorbutton)
  ON_BN_CLICKED(IDC_PARTICLEBUTTON, OnParticlebutton)
  ON_EN_CHANGE(IDC_GREENTEXT, OnChangeColor)
  ON_EN_CHANGE(IDC_BLUETEXT, OnChangeColor)
  ON_BN_CLICKED(IDC_ICONBUTTON, OnIconbutton)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmEffectDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEffectDlg Constructor
 *
 *=========================================================================*/
CEsmEffectDlg::CEsmEffectDlg() : CEsmRecDialog(CEsmEffectDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmEffectDlg)
  //}}AFX_DATA_INIT
  m_pEffect = NULL;
  m_HasIDText = false;
 }
/*===========================================================================
 *		End of Class CEsmEffectDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEffectDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmEffectDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmEffectDlg)
  DDX_Control(pDX, IDC_ENCHANTCHECK, m_EnchantCheck);
  DDX_Control(pDX, IDC_SPELLCHECK, m_SpellCheck);
  DDX_Control(pDX, IDC_NEGATIVECHECK, m_NegativeCheck);
  DDX_Control(pDX, IDC_CASTSOUNDLIST, m_CastSoundList);
  DDX_Control(pDX, IDC_BOLTSOUNDLIST, m_BoltSoundList);
  DDX_Control(pDX, IDC_AREASOUNDLIST, m_AreaSoundList);
  DDX_Control(pDX, IDC_HITSOUNDLIST, m_HitSoundList);
  DDX_Control(pDX, IDC_CASTVISUALLIST, m_CastVisualList);
  DDX_Control(pDX, IDC_BOLTVISUALLIST, m_BoltVisualList);
  DDX_Control(pDX, IDC_AREAVISUALLIST, m_AreaVisualList);
  DDX_Control(pDX, IDC_HITVISUALLIST, m_HitVisualList);
  DDX_Control(pDX, IDC_PARTICLEBUTTON, m_ParticleButton);
  DDX_Control(pDX, IDC_ICONBUTTON, m_IconButton);
  DDX_Control(pDX, IDC_PARTICLEBOX, m_ParticleBox);
  DDX_Control(pDX, IDC_ICONBOX, m_IconBox);
  DDX_Control(pDX, IDC_COLORBOX, m_ColorBox);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_BASECOSTTEXT, m_BaseCostText);
  DDX_Control(pDX, IDC_SIZETEXT, m_SizeText);
  DDX_Control(pDX, IDC_REDTEXT, m_RedText);
  DDX_Control(pDX, IDC_GREENTEXT, m_GreenText);
  DDX_Control(pDX, IDC_BLUETEXT, m_BlueText);
  DDX_Control(pDX, IDC_DESCTEXT, m_DescText);
  DDX_Control(pDX, IDC_RSPIN, m_RedSpin);
  DDX_Control(pDX, IDC_GSPIN, m_GreenSpin);
  DDX_Control(pDX, IDC_BSPIN, m_BlueSpin);
  DDX_Control(pDX, IDC_MAXSIZETEXT, m_MaxSizeText);
  DDX_Control(pDX, IDC_SPEEDTEXT, m_SpeedText);
  DDX_Control(pDX, IDC_SCHOOLLIST, m_SchoolList);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmEffectDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEffectDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmEffectDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmEffectDlg::GetControlData()");
  CString Buffer;  
  int	  Index;

	/* Update the armor pointer and data */
  m_pEffect = (CEsmMagicEffect *) GetRecInfo()->pRecord;
  if (m_pEffect == NULL) return;

	/* Item description */
  m_DescText.GetWindowText(Buffer);
  m_pEffect->SetDescription(TrimStringSpace(Buffer));

	/* Base cost */
  m_BaseCostText.GetWindowText(Buffer);
  m_pEffect->SetBaseCost((float) atof(Buffer));

  	/* Size */
  m_SizeText.GetWindowText(Buffer);
  m_pEffect->SetSize((float) atof(Buffer));

  	/* Max Size */
  m_MaxSizeText.GetWindowText(Buffer);
  m_pEffect->SetMaxSize((float) atof(Buffer));

  	/* Speed */
  m_SpeedText.GetWindowText(Buffer);
  m_pEffect->SetSpeed((float) atof(Buffer));

	/* Speel school */
  Index = m_SchoolList.GetCurSel();
  if (Index >= 0) m_pEffect->SetSchool(m_SchoolList.GetItemData(Index));

	/* Cast sound/visual */
  m_CastSoundList.GetWindowText(Buffer);
  m_pEffect->SetCastSound(TrimStringSpace(Buffer));
  m_CastVisualList.GetWindowText(Buffer);
  m_pEffect->SetCastVisual(TrimStringSpace(Buffer));

  	/* Bolt sound/visual */
  m_BoltSoundList.GetWindowText(Buffer);
  m_pEffect->SetBoltSound(TrimStringSpace(Buffer));
  m_BoltVisualList.GetWindowText(Buffer);
  m_pEffect->SetBoltVisual(TrimStringSpace(Buffer));

  	/* Area sound/visual */
  m_AreaSoundList.GetWindowText(Buffer);
  m_pEffect->SetAreaSound(TrimStringSpace(Buffer));
  m_AreaVisualList.GetWindowText(Buffer);
  m_pEffect->SetAreaVisual(TrimStringSpace(Buffer));

  	/* Hit sound/visual */
  m_HitSoundList.GetWindowText(Buffer);
  m_pEffect->SetHitSound(TrimStringSpace(Buffer));
  m_HitVisualList.GetWindowText(Buffer);
  m_pEffect->SetHitVisual(TrimStringSpace(Buffer));

	/* Particle/effect icons */
  m_ParticleButton.GetWindowText(Buffer);
  m_pEffect->SetParticle(TrimStringSpace(Buffer));
  m_IconButton.GetWindowText(Buffer);
  m_pEffect->SetIcon(TrimStringSpace(Buffer));

	/* Set the lighting color */
  m_RedText.GetWindowText(Buffer);
  m_pEffect->SetRed(atoi(Buffer));
  m_GreenText.GetWindowText(Buffer);
  m_pEffect->SetGreen(atoi(Buffer));
  m_BlueText.GetWindowText(Buffer);
  m_pEffect->SetBlue(atoi(Buffer));

	/* Record flags */
  m_pEffect->SetEnchanting(m_EnchantCheck.GetCheck() != 0);
  m_pEffect->SetSpellMaking(m_SpellCheck.GetCheck() != 0);
  m_pEffect->SetNegative(m_NegativeCheck.GetCheck() != 0);
 }
/*===========================================================================
 *		End of Class Method CEsmEffectDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEffectDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmEffectDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_NameText.GetModify()) m_Modified = true;
  if (m_SizeText.GetModify()) m_Modified = true;
  if (m_MaxSizeText.GetModify()) m_Modified = true;
  if (m_DescText.GetModify()) m_Modified = true;
  if (m_SpeedText.GetModify()) m_Modified = true;
  if (m_RedText.GetModify()) m_Modified = true;  
  if (m_GreenText.GetModify()) m_Modified = true;
  if (m_BlueText.GetModify()) m_Modified = true;

  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmEffectDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEffectDlg Event - void OnCastPlay ();
 *
 *=========================================================================*/
void CEsmEffectDlg::OnCastPlay() {
  CString	SoundFile;
  CEsmSound*	pSound;
  esmrecinfo_t* pRecInfo;
  int		ListIndex;

  ListIndex = m_CastSoundList.GetCurSel();

  if (ListIndex >= 0) {
    pRecInfo = (esmrecinfo_t *) m_CastSoundList.GetItemData(ListIndex);
    pSound = (CEsmSound *) pRecInfo->pRecord;

    SoundFile  = GetMWDataPath();
    SoundFile += MWPATH_SOUNDS;
    SoundFile += pSound->GetName();

    PlaySound(SoundFile, NULL, SND_FILENAME | SND_ASYNC | SND_NODEFAULT);
   }
 }

void CEsmEffectDlg::OnHitPlay() {
  CString	SoundFile;
  CEsmSound*	pSound;
  esmrecinfo_t* pRecInfo;
  int		ListIndex;

  ListIndex = m_HitSoundList.GetCurSel();

  if (ListIndex >= 0) {
    pRecInfo = (esmrecinfo_t *) m_HitSoundList.GetItemData(ListIndex);
    pSound = (CEsmSound *) pRecInfo->pRecord;

    SoundFile  = GetMWDataPath();
    SoundFile += MWPATH_SOUNDS;
    SoundFile += pSound->GetName();

    PlaySound(SoundFile, NULL, SND_FILENAME | SND_ASYNC | SND_NODEFAULT);
   }
 }

void CEsmEffectDlg::OnBoltPlay() {
  CString	SoundFile;
  CEsmSound*	pSound;
  esmrecinfo_t* pRecInfo;
  int		ListIndex;

  ListIndex = m_BoltSoundList.GetCurSel();

  if (ListIndex >= 0) {
    pRecInfo = (esmrecinfo_t *) m_BoltSoundList.GetItemData(ListIndex);
    pSound = (CEsmSound *) pRecInfo->pRecord;

    SoundFile  = GetMWDataPath();
    SoundFile += MWPATH_SOUNDS;
    SoundFile += pSound->GetName();

    PlaySound(SoundFile, NULL, SND_FILENAME | SND_ASYNC | SND_NODEFAULT);
   }
 }

void CEsmEffectDlg::OnAreaPlay() {
  CString	SoundFile;
  CEsmSound*	pSound;
  esmrecinfo_t* pRecInfo;
  int		ListIndex;

  ListIndex = m_AreaSoundList.GetCurSel();

  if (ListIndex >= 0) {
    pRecInfo = (esmrecinfo_t *) m_AreaSoundList.GetItemData(ListIndex);
    pSound = (CEsmSound *) pRecInfo->pRecord;

    SoundFile  = GetMWDataPath();
    SoundFile += MWPATH_SOUNDS;
    SoundFile += pSound->GetName();

    PlaySound(SoundFile, NULL, SND_FILENAME | SND_ASYNC | SND_NODEFAULT);
   }
 }
/*===========================================================================
 *		End of Class Event CEsmEffectDlg::OnCastPlay()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEffectDlg Event - void OnChangeColor ();
 *
 *=========================================================================*/
void CEsmEffectDlg::OnChangeColor() {
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
 *		End of Class Event CEsmEffectDlg::OnChangeColor()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEffectDlg Event - void OnColorbutton ();
 *
 *=========================================================================*/
void CEsmEffectDlg::OnColorbutton() {
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
 *		End of Class Event CEsmEffectDlg::OnColorbutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEffectDlg Event - void OnIconbutton ();
 *
 *=========================================================================*/
void CEsmEffectDlg::OnIconbutton() {
  CString Filename;
  bool	  Result;

  Result = SelectEsmIcon(Filename, _T("Select Icon"), this);

  if (Result) {
    m_IconButton.SetWindowText(Filename);
    m_IconBox.SetEsmIcon(Filename);
   }

 }
/*===========================================================================
 *		End of Class Event CEsmEffectDlg::OnIconbutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEffectDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmEffectDlg::OnInitialUpdate() {
  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);
  
	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pEffect = (CEsmMagicEffect *) GetRecInfo()->pRecord;

	/* Initialize the ui controls/lists */
  FillEsmSpellSchoolCombo(m_SchoolList);
  FillEsmSoundCombo(m_CastSoundList);
  FillEsmSoundCombo(m_AreaSoundList);
  FillEsmSoundCombo(m_BoltSoundList);
  FillEsmSoundCombo(m_HitSoundList);
  FillEsmVisualCombo(m_CastVisualList, false);
  FillEsmVisualCombo(m_BoltVisualList, true);
  FillEsmVisualCombo(m_AreaVisualList, false);
  FillEsmVisualCombo(m_HitVisualList, false);
  m_SizeText.SetLimitText(16);
  m_MaxSizeText.SetLimitText(16);
  m_SpeedText.SetLimitText(16);
  m_BaseCostText.SetLimitText(16);
  m_SizeText.SetLimitText(16);
  m_RedText.SetLimitText(3);
  m_GreenText.SetLimitText(3);
  m_BlueText.SetLimitText(3);
  m_RedSpin.SetRange32(0, 255);
  m_GreenSpin.SetRange32(0, 255);
  m_BlueSpin.SetRange32(0, 255);
   
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmEffectDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEffectDlg Event - void OnParticlebutton ();
 *
 *=========================================================================*/
void CEsmEffectDlg::OnParticlebutton() {
  CString Filename;
  bool	  Result;

  Result = SelectEsmTexture(Filename, _T("Select Texture"), this);

  if (Result) {
    m_ParticleButton.SetWindowText(Filename);
    m_ParticleBox.SetEsmIcon(Filename);
   }

 }
/*===========================================================================
 *		End of Class Event CEsmEffectDlg::OnParticlebutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEffectDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmEffectDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  CString Buffer;

  	/* Refill the script list if required */
  if (pRecInfo->pRecord->IsType(MWESM_REC_SOUN)) {
    m_CastSoundList.GetWindowText(Buffer);
    FillEsmSoundCombo(m_CastSoundList);
    m_CastSoundList.SelectString(-1, Buffer);

    m_AreaSoundList.GetWindowText(Buffer);
    FillEsmSoundCombo(m_AreaSoundList);
    m_AreaSoundList.SelectString(-1, Buffer);

    m_BoltSoundList.GetWindowText(Buffer);
    FillEsmSoundCombo(m_BoltSoundList);
    m_BoltSoundList.SelectString(-1, Buffer);

    m_HitSoundList.GetWindowText(Buffer);
    FillEsmSoundCombo(m_HitSoundList);
    m_HitSoundList.SelectString(-1, Buffer);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmEffectDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmEffectDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmEffectDlg::SetControlData (void) {
  CString      Buffer;
  const TCHAR* pString;

	/* Ignore if the current item is not valid */
  if (m_pEffect == NULL) return;
  UpdateTitle(m_pEffect->GetName());

	/* Item strings and values */
  m_NameText.SetWindowText(m_pEffect->GetName());
  m_NameText.SetModify(FALSE);

	/* Base cost/size/etc... */
  Buffer.Format(_T("%.2f"), m_pEffect->GetBaseCost());
  m_BaseCostText.SetWindowText(Buffer);
  m_BaseCostText.SetModify(FALSE);

  Buffer.Format(_T("%.2f"), m_pEffect->GetSize());
  m_SizeText.SetWindowText(Buffer);
  m_SizeText.SetModify(FALSE);

  Buffer.Format(_T("%.2f"), m_pEffect->GetMaxSize());
  m_MaxSizeText.SetWindowText(Buffer);
  m_MaxSizeText.SetModify(FALSE);

  Buffer.Format(_T("%.2f"), m_pEffect->GetSpeed());
  m_SpeedText.SetWindowText(Buffer);
  m_SpeedText.SetModify(FALSE);

	/* Description */
  m_DescText.SetWindowText(m_pEffect->GetDescription());
  m_DescText.SetModify(FALSE);

	/* Model/sound buttons */
  pString = m_pEffect->GetCastSound();

  if (*pString == NULL_CHAR) {
    Buffer.Format(_T("%s Cast"), m_pEffect->GetSchool());
    m_CastSoundList.SelectString(-1, Buffer);
   }
  else
    m_CastSoundList.SelectString(-1, pString);

  pString = m_pEffect->GetBoltSound();

  if (*pString == NULL_CHAR) {
    Buffer.Format(_T("%s Bolt"), m_pEffect->GetSchool());
    m_BoltSoundList.SelectString(-1, Buffer);
   }
  else
    m_BoltSoundList.SelectString(-1, pString);

  pString = m_pEffect->GetAreaSound();

  if (*pString == NULL_CHAR) {
    Buffer.Format(_T("%s Area"), m_pEffect->GetSchool());
    m_AreaSoundList.SelectString(-1, Buffer);
   }
  else
    m_AreaSoundList.SelectString(-1, pString);

  pString = m_pEffect->GetHitSound();

  if (*pString == NULL_CHAR) {
    Buffer.Format(_T("%s Hit"), m_pEffect->GetSchool());
    m_HitSoundList.SelectString(-1, Buffer);
   }
  else
    m_HitSoundList.SelectString(-1, pString);

  pString = m_pEffect->GetCastVisual();

  if (*pString == NULL_CHAR) 
    m_CastVisualList.SelectString(-1, _T("VFX_DefaultCast"));
  else
    m_CastVisualList.SelectString(-1, m_pEffect->GetCastVisual());

  pString = m_pEffect->GetBoltVisual();

  if (*pString == NULL_CHAR) 
    m_BoltVisualList.SelectString(-1, _T("VFX_DefaultBolt"));
  else
    m_BoltVisualList.SelectString(-1, m_pEffect->GetBoltVisual());

  pString = m_pEffect->GetAreaVisual();

  if (*pString == NULL_CHAR)  
     m_AreaVisualList.SelectString(-1, _T("VFX_DefaultArea"));
  else
    m_AreaVisualList.SelectString(-1, m_pEffect->GetAreaVisual());

  pString = m_pEffect->GetHitVisual();

  if (*pString == NULL_CHAR)
    m_HitVisualList.SelectString(-1, _T("VFX_DefaultHit"));
  else
   m_HitVisualList.SelectString(-1, m_pEffect->GetHitVisual());

	/* Particle/icon button */
  m_IconButton.SetWindowText(m_pEffect->GetIcon());
  m_ParticleButton.SetWindowText(m_pEffect->GetParticle());
  m_IconBox.SetEsmIcon(m_pEffect->GetIcon());
  m_ParticleBox.SetEsmIcon(m_pEffect->GetParticle());

	/* Color */
  Buffer.Format(_T("%d"), m_pEffect->GetRed());
  m_RedText.SetWindowText(Buffer);
  m_RedText.SetModify(FALSE);
  Buffer.Format(_T("%d"), m_pEffect->GetGreen());
  m_GreenText.SetWindowText(Buffer);
  m_GreenText.SetModify(FALSE);
  Buffer.Format(_T("%d"), m_pEffect->GetBlue());
  m_BlueText.SetWindowText(Buffer);
  m_BlueText.SetModify(FALSE);
  m_ColorBox.SetColor(m_pEffect->GetRed(), m_pEffect->GetGreen(), m_pEffect->GetBlue());

	/* Spell school */
  FindComboListItem(m_SchoolList, m_pEffect->GetSchoolID(), true);
 
	/* Record flags */
  m_EnchantCheck.SetCheck(m_pEffect->IsSpellMaking());
  m_SpellCheck.SetCheck(m_pEffect->IsEnchanting());
  m_NegativeCheck.SetCheck(m_pEffect->IsNegative());
 }
/*===========================================================================
 *		End of Class Method CEsmEffectDlg::SetControlData()
 *=========================================================================*/



