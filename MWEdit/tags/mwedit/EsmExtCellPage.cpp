/*===========================================================================
 *
 * File:	Esmextcellpage.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 25, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmExtCellPage.h"
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

  IMPLEMENT_DYNCREATE(CEsmExtCellPage, CPropertyPage);
  DEFINE_FILE("EsmExtCellPage.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmExtCellPage Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmExtCellPage, CPropertyPage)
  //{{AFX_MSG_MAP(CEsmExtCellPage)
  ON_BN_CLICKED(IDC_COLORBUTTON, OnColorbutton)
  ON_EN_CHANGE(IDC_REDTEXT, OnChangeColor)
  ON_EN_CHANGE(IDC_GREENTEXT, OnChangeColor)
  ON_EN_CHANGE(IDC_BLUETEXT, OnChangeColor)
  ON_BN_CLICKED(IDC_MAPCHECK, OnMapcheck)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmExtCellPage Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmExtCellPage Constructor
 *
 *=========================================================================*/
CEsmExtCellPage::CEsmExtCellPage() : CPropertyPage(CEsmExtCellPage::IDD) {
  //{{AFX_DATA_INIT(CEsmExtCellPage)
  //}}AFX_DATA_INIT
  m_pRecInfo    = NULL;
  m_pDlgParent = NULL;
 }
/*===========================================================================
 *		End of Class CEsmExtCellPage Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmExtCellPage Destructor
 *
 *=========================================================================*/
CEsmExtCellPage::~CEsmExtCellPage() {
 }
/*===========================================================================
 *		End of Class CEsmExtCellPage Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmExtCellPage Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmExtCellPage::DoDataExchange(CDataExchange* pDX) {
  CPropertyPage::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmExtCellPage)
  DDX_Control(pDX, IDC_COLORBUTTON, m_ColorButton);
  DDX_Control(pDX, IDC_COLORBOX, m_ColorBox);
  DDX_Control(pDX, IDC_BSPIN, m_BSpin);
  DDX_Control(pDX, IDC_GSPIN, m_GSpin);
  DDX_Control(pDX, IDC_RSPIN, m_RSpin);
  DDX_Control(pDX, IDC_BLUETEXT, m_BlueText);
  DDX_Control(pDX, IDC_GREENTEXT, m_GreenText);
  DDX_Control(pDX, IDC_REDTEXT, m_RedText);
  DDX_Control(pDX, IDC_REGIONLIST, m_RegionList);
  DDX_Control(pDX, IDC_MAPCHECK, m_MapCheck);
  DDX_Control(pDX, IDC_SLEEPCHECK, m_SleepCheck);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmExtCellPage::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmExtCellPage Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmExtCellPage::GetControlData (void) {
  CEsmCell*  	  pCell;
  CString	  Buffer;
  CEsmSubLong*	  pLightData;
  long		  Flags;
  int		  ArrayIndex;
  int		  Red;
  int		  Green;
  int		  Blue;
  
  if (m_pRecInfo == NULL) return;
  pCell = (CEsmCell *) m_pRecInfo->pRecord;
  Flags = 0;

	/* Region */
  m_RegionList.GetWindowText(Buffer);
  pCell->SetRegion(Buffer);

  if (m_MapCheck.GetCheck()) {
    pLightData = (CEsmSubLong *) pCell->FindFirst(MWESM_SUBREC_NAM5, ArrayIndex);

    if (pLightData == NULL) {
      pLightData = (CEsmSubLong *) pCell->AllocateSubRecord(MWESM_SUBREC_NAM5);
     }

    m_RedText.GetWindowText(Buffer);
    Red = atoi(Buffer);
    m_GreenText.GetWindowText(Buffer);
    Green = atoi(Buffer);
    m_BlueText.GetWindowText(Buffer);
    Blue = atoi(Buffer);

    pLightData->SetValue(RGB(Red, Green, Blue));
   }

	/* Flags */
  if (m_SleepCheck.GetCheck()) Flags |= MWESM_CELLFLAG_SLEEPILLEGAL;
  pCell->GetCellData()->Flags = Flags;
 }
/*===========================================================================
 *		End of Class Method CEsmExtCellPage::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmExtCellPage Method - CMWEditDoc* GetDocument (void);
 *
 *=========================================================================*/
CMWEditDoc* CEsmExtCellPage::GetDocument (void) {
  DEFINE_FUNCTION("CEsmExtCellPage::GetDocument()");
  ASSERT(m_pDlgParent != NULL);
  return m_pDlgParent->GetDocument();
 }
/*===========================================================================
 *		End of Class Method CEsmExtCellPage::GetDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmExtCellPage Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmExtCellPage::OnInitDialog() {
  CPropertyPage::OnInitDialog();

  FillEsmRegionCombo(m_RegionList);

  m_RedText.SetLimitText(3);
  m_GreenText.SetLimitText(3);
  m_BlueText.SetLimitText(3);
  m_RSpin.SetRange32(0, 255);
  m_GSpin.SetRange32(0,255);
  m_BSpin.SetRange32(0,255);
  
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmExtCellPage::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmExtCellPage Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmExtCellPage::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmExtCellPage::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmExtCellPage Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmExtCellPage::SetControlData (void) {
  CEsmCell*  	  pCell;
  CString	  Buffer;
  CEsmSubLong*	  pLightData;
  int		  ArrayIndex;
  
  if (m_pRecInfo == NULL) return;
  pCell = (CEsmCell *) m_pRecInfo->pRecord;
  pLightData = (CEsmSubLong *) pCell->FindFirst(MWESM_SUBREC_NAM5, ArrayIndex);

  m_RegionList.SelectString(-1, pCell->GetRegion());

  if (pLightData != NULL) {
    m_MapCheck.SetCheck(TRUE);
    Buffer.Format(_T("%d"), GetRValue(pLightData->GetValue()));
    m_RedText.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), GetGValue(pLightData->GetValue()));
    m_GreenText.SetWindowText(Buffer);
    Buffer.Format(_T("%d"), GetBValue(pLightData->GetValue()));
    m_BlueText.SetWindowText(Buffer);
    OnChangeColor();
   }
  else {
    m_MapCheck.SetCheck(FALSE);
    OnMapcheck();
   }

  m_SleepCheck.SetCheck((pCell->GetFlags() & MWESM_CELLFLAG_SLEEPILLEGAL) != 0);
 }
/*===========================================================================
 *		End of Class Method CEsmExtCellPage::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Color Buttons
 *
 *=========================================================================*/
void CEsmExtCellPage::OnColorbutton() {
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
 *		End of Color Buttons
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Color Change Events
 *
 *=========================================================================*/
void CEsmExtCellPage::OnChangeColor() {
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
 *		End of Color Change Events
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmExtCellPage Event - void OnMapcheck ();
 *
 *=========================================================================*/
void CEsmExtCellPage::OnMapcheck() {
  BOOL Result = m_MapCheck.GetCheck();
  m_RedText.EnableWindow(Result);
  m_BlueText.EnableWindow(Result);
  m_GreenText.EnableWindow(Result);
  m_ColorButton.EnableWindow(Result);
 }
/*===========================================================================
 *		End of Class Event CEsmExtCellPage::OnMapcheck()
 *=========================================================================*/
