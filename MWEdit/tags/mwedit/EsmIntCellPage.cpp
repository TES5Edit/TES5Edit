/*===========================================================================
 *
 * File:	Esmintcellpage.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 25, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmIntCellPage.h"
#include "EsmRecDialog.h"


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

  IMPLEMENT_DYNCREATE(CEsmIntCellPage, CPropertyPage);
  DEFINE_FILE("EsmIntCellPage.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmIntCellPage Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmIntCellPage, CPropertyPage)
  //{{AFX_MSG_MAP(CEsmIntCellPage)
  ON_BN_CLICKED(IDC_COLORBUTTONA, OnColorbuttona)
  ON_BN_CLICKED(IDC_COLORBUTTONS, OnColorbuttons)
  ON_BN_CLICKED(IDC_COLORBUTTONF, OnColorbuttonf)
  ON_EN_CHANGE(IDC_REDTEXTA, OnChangeColorA)
  ON_EN_CHANGE(IDC_REDTEXTS, OnChangeColorS)
  ON_EN_CHANGE(IDC_REDTEXTF, OnChangeColorF)
  ON_BN_CLICKED(IDC_WATERCHECK, OnWatercheck)
  ON_EN_CHANGE(IDC_GREENTEXTA, OnChangeColorA)
  ON_EN_CHANGE(IDC_GREENTEXTS, OnChangeColorS)
  ON_EN_CHANGE(IDC_GREENTEXTF, OnChangeColorF)
  ON_EN_CHANGE(IDC_BLUETEXTA, OnChangeColorA)
  ON_EN_CHANGE(IDC_BLUETEXTS, OnChangeColorS)
  ON_EN_CHANGE(IDC_BLUETEXTF, OnChangeColorF)
  ON_BN_CLICKED(IDC_EXTERIORCHECK, OnExteriorcheck)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmIntCellPage Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIntCellPage Constructor
 *
 *=========================================================================*/
CEsmIntCellPage::CEsmIntCellPage() : CPropertyPage(CEsmIntCellPage::IDD) {
  //{{AFX_DATA_INIT(CEsmIntCellPage)
  //}}AFX_DATA_INIT
  m_pRecInfo    = NULL;
  m_pDlgParent  = NULL;
 }
/*===========================================================================
 *		End of Class CEsmIntCellPage Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIntCellPage Destructor
 *
 *=========================================================================*/
CEsmIntCellPage::~CEsmIntCellPage() {
 }
/*===========================================================================
 *		End of Class CEsmIntCellPage Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIntCellPage Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmIntCellPage::DoDataExchange(CDataExchange* pDX) {
  CPropertyPage::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmIntCellPage)
  DDX_Control(pDX, IDC_COLORBOXF, m_ColorBoxF);
  DDX_Control(pDX, IDC_BSPINF, m_BSpinF);
  DDX_Control(pDX, IDC_GSPINF, m_GSpinF);
  DDX_Control(pDX, IDC_RSPINF, m_RSpinF);
  DDX_Control(pDX, IDC_WATERTEXT2, m_DensityText);
  DDX_Control(pDX, IDC_BLUETEXTF, m_BlueTextF);
  DDX_Control(pDX, IDC_GREENTEXTF, m_GreenTextF);
  DDX_Control(pDX, IDC_REDTEXTF, m_RedTextF);
  DDX_Control(pDX, IDC_BSPINS, m_BSpinS);
  DDX_Control(pDX, IDC_GSPINS, m_GSpinS);
  DDX_Control(pDX, IDC_RSPINS, m_RSpinS);
  DDX_Control(pDX, IDC_COLORBOXS, m_ColorBoxS);
  DDX_Control(pDX, IDC_BLUETEXTS, m_BlueTextS);
  DDX_Control(pDX, IDC_GREENTEXTS, m_GreenTextS);
  DDX_Control(pDX, IDC_REDTEXTS, m_RedTextS);
  DDX_Control(pDX, IDC_BSPINA, m_BSpinA);
  DDX_Control(pDX, IDC_GSPINA, m_GSpinA);
  DDX_Control(pDX, IDC_RSPINA, m_RSpinA);
  DDX_Control(pDX, IDC_COLORBOXA, m_ColorBoxA);
  DDX_Control(pDX, IDC_WATERTEXT, m_WaterText);
  DDX_Control(pDX, IDC_REGIONLIST, m_RegionList);
  DDX_Control(pDX, IDC_EXTERIORCHECK, m_ExteriorCheck);
  DDX_Control(pDX, IDC_SLEEPCHECK, m_SleepCheck);
  DDX_Control(pDX, IDC_WATERCHECK, m_WaterCheck);
  DDX_Control(pDX, IDC_BLUETEXTA, m_BlueTextA);
  DDX_Control(pDX, IDC_GREENTEXTA, m_GreenTextA);
  DDX_Control(pDX, IDC_REDTEXTA, m_RedTextA);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmIntCellPage::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIntCellPage Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmIntCellPage::GetControlData (void) {
  CEsmCell*  	  pCell;
  CString	  Buffer;
  ambidata_t*	  pLightData;
  long		  Flags;
  int		  Red;
  int		  Green;
  int		  Blue;
  
  if (m_pRecInfo == NULL) return;
  pCell = (CEsmCell *) m_pRecInfo->pRecord;
  pLightData = pCell->GetAMBIData();
  Flags = MWESM_CELLFLAG_INTERIOR;

  if (pLightData != NULL) {
    m_RedTextA.GetWindowText(Buffer);
    Red = atoi(Buffer);
    m_GreenTextA.GetWindowText(Buffer);
    Green = atoi(Buffer);
    m_BlueTextA.GetWindowText(Buffer);
    Blue = atoi(Buffer);
    pLightData->AmbientColor = RGB(Red, Green, Blue);
    m_RedTextF.GetWindowText(Buffer);
    Red = atoi(Buffer);
    m_GreenTextF.GetWindowText(Buffer);
    Green = atoi(Buffer);
    m_BlueTextF.GetWindowText(Buffer);
    Blue = atoi(Buffer);
    pLightData->FogColor = RGB(Red, Green, Blue);
    m_RedTextS.GetWindowText(Buffer);
    Red = atoi(Buffer);
    m_GreenTextS.GetWindowText(Buffer);
    Green = atoi(Buffer);
    m_BlueTextS.GetWindowText(Buffer);
    Blue = atoi(Buffer);
    pLightData->SunlightColor = RGB(Red, Green, Blue);

    m_DensityText.GetWindowText(Buffer);
    pLightData->FogDensity = (float) atof(Buffer);
   }

	/* Flags */
  if (m_SleepCheck.GetCheck()) Flags |= MWESM_CELLFLAG_SLEEPILLEGAL;

  if (m_ExteriorCheck.GetCheck()) {
    Flags |= MWESM_CELLFLAG_LIKEEXTERIOR;
    m_RegionList.GetWindowText(Buffer);
    pCell->SetRegion(Buffer);
   }

  if (m_WaterCheck.GetCheck()) {
    Flags |= MWESM_CELLFLAG_HASWATER;
    m_WaterText.GetWindowText(Buffer);
    pCell->SetWaterHeight((float) atof(Buffer));
   }
  
  pCell->GetCellData()->Flags = Flags;
 }
/*===========================================================================
 *		End of Class Method CEsmIntCellPage::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIntCellPage Method - CMWEditDoc* GetDocument (void);
 *
 *=========================================================================*/
CMWEditDoc* CEsmIntCellPage::GetDocument (void) {
  DEFINE_FUNCTION("CEsmIntCellPage::GetDocument()");
  ASSERT(m_pDlgParent != NULL);
  return m_pDlgParent->GetDocument();
 }
/*===========================================================================
 *		End of Class Method CEsmIntCellPage::GetDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIntCellPage Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmIntCellPage::OnInitDialog() {
  CPropertyPage::OnInitDialog();

  FillEsmRegionCombo(m_RegionList);

  m_RedTextA.SetLimitText(3);
  m_GreenTextA.SetLimitText(3);
  m_BlueTextA.SetLimitText(3);
  m_RedTextS.SetLimitText(3);
  m_GreenTextS.SetLimitText(3);
  m_BlueTextS.SetLimitText(3);
  m_RedTextF.SetLimitText(3);
  m_GreenTextF.SetLimitText(3);
  m_BlueTextF.SetLimitText(3);
  m_DensityText.SetLimitText(8);
  m_WaterText.SetLimitText(8);
  m_RSpinA.SetRange32(0, 255);
  m_GSpinA.SetRange32(0,255);
  m_BSpinA.SetRange32(0,255);
  m_RSpinS.SetRange32(0, 255);
  m_GSpinS.SetRange32(0,255);
  m_BSpinS.SetRange32(0,255);
  m_RSpinF.SetRange32(0, 255);
  m_GSpinF.SetRange32(0,255);
  m_BSpinF.SetRange32(0,255);

  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmIntCellPage::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIntCellPage Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmIntCellPage::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmIntCellPage::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIntCellPage Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmIntCellPage::SetControlData (void) {
  CEsmCell*  	  pCell;
  CString	  Buffer;
  ambidata_t*	  pLightData;
  
  if (m_pRecInfo == NULL) return;
  pCell = (CEsmCell *) m_pRecInfo->pRecord;
  pLightData = pCell->GetAMBIData();

  if (pLightData != NULL) {
    Buffer.Format(_T("%d"), GetRValue(pLightData->AmbientColor));
    m_RedTextA.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), GetGValue(pLightData->AmbientColor));
    m_GreenTextA.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), GetBValue(pLightData->AmbientColor));
    m_BlueTextA.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), GetRValue(pLightData->SunlightColor));
    m_RedTextS.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), GetGValue(pLightData->SunlightColor));
    m_GreenTextS.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), GetBValue(pLightData->SunlightColor));
    m_BlueTextS.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), GetRValue(pLightData->FogColor));
    m_RedTextF.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), GetGValue(pLightData->FogColor));
    m_GreenTextF.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), GetBValue(pLightData->FogColor));
    m_BlueTextF.SetWindowText(Buffer);

    OnChangeColorA();
    OnChangeColorS();
    OnChangeColorF();

    Buffer.Format(_T("%.2f"), pLightData->FogDensity);
    m_DensityText.SetWindowText(Buffer);
   }

  if ((pCell->GetFlags() & MWESM_CELLFLAG_HASWATER) != 0) {
    m_WaterCheck.SetCheck(TRUE);
    Buffer.Format(_T("%f"), pCell->GetWaterHeight());
    m_WaterText.SetWindowText(Buffer);
   }
  else {
    m_WaterCheck.SetCheck(FALSE);
    m_WaterText.EnableWindow(FALSE);
   }
  
  m_SleepCheck.SetCheck((pCell->GetFlags() & MWESM_CELLFLAG_SLEEPILLEGAL) != 0);

  if ((pCell->GetFlags() & MWESM_CELLFLAG_SLEEPILLEGAL) != 0) {
    m_ExteriorCheck.SetCheck(FALSE);  
    m_RegionList.SelectString(-1, pCell->GetRegion());
   }
  else {
    m_ExteriorCheck.SetCheck(FALSE);
    m_RegionList.EnableWindow(FALSE);
   }

  OnExteriorcheck();
  OnWatercheck();
 }
/*===========================================================================
 *		End of Class Method CEsmIntCellPage::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Color Buttons
 *
 *=========================================================================*/
void CEsmIntCellPage::OnColorbuttona() {
  int		Result;
  CString	Buffer;
  int		Red;
  int		Green;
  int		Blue;

  m_RedTextA.GetWindowText(Buffer);
  Red   = atoi(Buffer);
  if (Red < 0)   Red = 0;
  if (Red > 255) Red = 255;
  m_GreenTextA.GetWindowText(Buffer);
  Green = atoi(Buffer);
  if (Green < 0)   Green = 0;
  if (Green > 255) Green = 255;
  m_BlueTextA.GetWindowText(Buffer);
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
  m_RedTextA.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), Green);
  m_GreenTextA.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), Blue);
  m_BlueTextA.SetWindowText(Buffer);

  m_ColorBoxA.SetColor(Red, Green, Blue);
 }

void CEsmIntCellPage::OnColorbuttons() {
  int		Result;
  CString	Buffer;
  int		Red;
  int		Green;
  int		Blue;

  m_RedTextS.GetWindowText(Buffer);
  Red   = atoi(Buffer);
  if (Red < 0)   Red = 0;
  if (Red > 255) Red = 255;
  m_GreenTextS.GetWindowText(Buffer);
  Green = atoi(Buffer);
  if (Green < 0)   Green = 0;
  if (Green > 255) Green = 255;
  m_BlueTextS.GetWindowText(Buffer);
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
  m_RedTextS.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), Green);
  m_GreenTextS.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), Blue);
  m_BlueTextS.SetWindowText(Buffer);

  m_ColorBoxS.SetColor(Red, Green, Blue);
 }

void CEsmIntCellPage::OnColorbuttonf() {
  int		Result;
  CString	Buffer;
  int		Red;
  int		Green;
  int		Blue;

  m_RedTextF.GetWindowText(Buffer);
  Red   = atoi(Buffer);
  if (Red < 0)   Red = 0;
  if (Red > 255) Red = 255;
  m_GreenTextF.GetWindowText(Buffer);
  Green = atoi(Buffer);
  if (Green < 0)   Green = 0;
  if (Green > 255) Green = 255;
  m_BlueTextF.GetWindowText(Buffer);
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
  m_RedTextF.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), Green);
  m_GreenTextF.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), Blue);
  m_BlueTextF.SetWindowText(Buffer);

  m_ColorBoxF.SetColor(Red, Green, Blue);
 }
/*===========================================================================
 *		End of Color Buttons
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Color Change Events
 *
 *=========================================================================*/
void CEsmIntCellPage::OnChangeColorA() {
  CString Buffer;
  int     Red;
  int     Green;
  int     Blue;

  if (!::IsWindow(m_RedTextA.m_hWnd)) return;

  m_RedTextA.GetWindowText(Buffer);
  Red   = atoi(Buffer);
  if (Red < 0)   Red = 0;
  if (Red > 255) Red = 255;
  m_GreenTextA.GetWindowText(Buffer);
  Green = atoi(Buffer);
  if (Green < 0)   Green = 0;
  if (Green > 255) Green = 255;
  m_BlueTextA.GetWindowText(Buffer);
  Blue  = atoi(Buffer);
  if (Blue < 0)   Blue = 0;
  if (Blue > 255) Blue = 255;

  m_ColorBoxA.SetColor(Red, Green, Blue);
  m_ColorBoxA.RedrawWindow();
 }


void CEsmIntCellPage::OnChangeColorS() {
  CString Buffer;
  int     Red;
  int     Green;
  int     Blue;

  if (!::IsWindow(m_RedTextS.m_hWnd)) return;

  m_RedTextS.GetWindowText(Buffer);
  Red   = atoi(Buffer);
  if (Red < 0)   Red = 0;
  if (Red > 255) Red = 255;
  m_GreenTextS.GetWindowText(Buffer);
  Green = atoi(Buffer);
  if (Green < 0)   Green = 0;
  if (Green > 255) Green = 255;
  m_BlueTextS.GetWindowText(Buffer);
  Blue  = atoi(Buffer);
  if (Blue < 0)   Blue = 0;
  if (Blue > 255) Blue = 255;

  m_ColorBoxS.SetColor(Red, Green, Blue);
  m_ColorBoxS.RedrawWindow();
 }

void CEsmIntCellPage::OnChangeColorF() {
  CString Buffer;
  int     Red;
  int     Green;
  int     Blue;

  if (!::IsWindow(m_RedTextF.m_hWnd)) return;

  m_RedTextF.GetWindowText(Buffer);
  Red   = atoi(Buffer);
  if (Red < 0)   Red = 0;
  if (Red > 255) Red = 255;
  m_GreenTextF.GetWindowText(Buffer);
  Green = atoi(Buffer);
  if (Green < 0)   Green = 0;
  if (Green > 255) Green = 255;
  m_BlueTextF.GetWindowText(Buffer);
  Blue  = atoi(Buffer);
  if (Blue < 0)   Blue = 0;
  if (Blue > 255) Blue = 255;

  m_ColorBoxF.SetColor(Red, Green, Blue);
  m_ColorBoxF.RedrawWindow();
 }
/*===========================================================================
 *		End of Color Change Events
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Checkbox Events
 *
 *=========================================================================*/
void CEsmIntCellPage::OnWatercheck() {
  m_WaterText.EnableWindow(m_WaterCheck.GetCheck());
 }

void CEsmIntCellPage::OnExteriorcheck() {
  m_RegionList.EnableWindow(m_ExteriorCheck.GetCheck());	
 }
/*===========================================================================
 *		End of Checkbox Events
 *=========================================================================*/

