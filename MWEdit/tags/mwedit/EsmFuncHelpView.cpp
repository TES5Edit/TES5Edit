/*===========================================================================
 *
 * File:	Esmfunchelpview.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 2, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmFuncHelpView.h"
#include "windows/winutil.h"


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

  DEFINE_FILE("EsmFuncHelpView.cpp");
  IMPLEMENT_DYNCREATE(CEsmFuncHelpView, CFormView);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmFuncHelpView Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmFuncHelpView, CFormView)
  //{{AFX_MSG_MAP(CEsmFuncHelpView)
  ON_CBN_SELCHANGE(IDC_FUNCTIONLIST, OnSelchangeFuncList)
  ON_MESSAGE(MSG_SCRIPTFRM_VIEWERROR, OnViewError)
  ON_WM_CTLCOLOR()
  ON_WM_SIZE()
  ON_BN_CLICKED(IDC_WIKILINK, OnWikilink)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmFuncHelpView Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Constructor
 *
 *=========================================================================*/
CEsmFuncHelpView::CEsmFuncHelpView() : CFormView(CEsmFuncHelpView::IDD) {
  //{{AFX_DATA_INIT(CEsmFuncHelpView)
  //}}AFX_DATA_INIT

  m_pFuncArray  = NULL;
  m_CurrentFunc = -1;

  m_Font.CreatePointFont(90, _T("Arial Bold"), NULL);
  m_NameFont.CreatePointFont(160, _T("Arial Bold"), NULL);

  m_LinkFont.CreateFont(16, 0, 0, 0, FW_NORMAL, 0, TRUE, 0, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, 
		CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, _T("Arial")); 

  /*m_Font.CreateFont(100, 0, 0, 0, FW_BOLD, 0, 0, 0, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, 
		CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, _T("Arial")); //*/

 }
/*===========================================================================
 *		End of Class CEsmFuncHelpView Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Destructor
 *
 *=========================================================================*/
CEsmFuncHelpView::~CEsmFuncHelpView() {
}
/*===========================================================================
 *		End of Class CEsmFuncHelpView Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Method - void DisplayFunction (Index);
 *
 * Display the given function in the help window.
 *
 *=========================================================================*/
void CEsmFuncHelpView::DisplayFunction (const int Index) {
  CEsmScrFuncData* pFunction;

	/* Ignore if the function hasn't changed */
  if (m_CurrentFunc == Index) return;

	/* See if we need to clear the controls */
  if (Index < 0) {
    return;
   }

	/* Update the display */
  pFunction = (CEsmScrFuncData *) m_FunctionList.GetItemDataPtr(Index);
  SetFuncTitle(pFunction);
  SetReturnText(pFunction);
  SetDescText(pFunction);
  SetDetailText(pFunction);

  m_CurrentFunc = Index;
 }
/*===========================================================================
 *		End of Class Method CEsmFuncHelpView::DisplayFunction()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmFuncHelpView::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmFuncHelpView)
	DDX_Control(pDX, IDC_DETAILLABEL, m_DetailLabel);
  DDX_Control(pDX, IDC_HBAR, m_Bar);
  DDX_Control(pDX, IDC_WIKILINK, m_WikiLink);
  DDX_Control(pDX, IDC_DETAILTEXT, m_DetailText);
  DDX_Control(pDX, IDC_FUNCNAME, m_FuncName);
  DDX_Control(pDX, IDC_DESCTITLE, m_DescText);
  DDX_Control(pDX, IDC_RETURNTITLE, m_ReturnText);
  DDX_Control(pDX, IDC_FUNCTITLE, m_FuncTitle);
  DDX_Control(pDX, IDC_FUNCTIONLIST, m_FunctionList);
	//}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmFuncHelpView::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmFuncHelpView Diagnostics
 *
 *=========================================================================*/
#ifdef _DEBUG

void CEsmFuncHelpView::AssertValid() const {
  CFormView::AssertValid();
 }


void CEsmFuncHelpView::Dump(CDumpContext& dc) const {
  CFormView::Dump(dc);
 }

#endif
/*===========================================================================
 *		End of CEsmFuncHelpView Diagnostics
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Method - void FillFunctionList (void);
 *
 * Fills the function combo list with the current function names.
 *
 *=========================================================================*/
void CEsmFuncHelpView::FillFunctionList (void) {
  CEsmScrFuncData* pFunction;
  int		   Index;
  int		   Result;

	/* Clear the current list */
  m_FunctionList.ResetContent();
  if (m_pFuncArray == NULL) return;

  for (Index = 0; Index < m_pFuncArray->GetCount(); Index++) {
    pFunction = m_pFuncArray->GetFunction(Index);
    Result = m_FunctionList.AddString(pFunction->GetFunction());
    if (Result >= 0) m_FunctionList.SetItemDataPtr(Result, (void *) pFunction);
   }

  m_CurrentFunc = -1;
 }
/*===========================================================================
 *		End of Class Method CEsmFuncHelpView::FillFunctionList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Method - CMWEditApp* GetApp (void);
 *
 *=========================================================================*/
CMWEditApp* CEsmFuncHelpView::GetApp (void) {
  return (CMWEditApp *) AfxGetApp();
 }
/*===========================================================================
 *		End of Class Method CEsmFuncHelpView::GetApp()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Event - HBRUSH OnCtlColor (pDC, pWnd, nCtlColor);
 *
 *=========================================================================*/
HBRUSH CEsmFuncHelpView::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor) {
  HBRUSH hbr = CFormView::OnCtlColor(pDC, pWnd, nCtlColor);

  if (pWnd->GetDlgCtrlID() == IDC_WIKILINK) {
     pDC->SetTextColor(RGB(0,0,255));
  }
	
  return hbr;
}
/*===========================================================================
 *		End of Class Event CEsmFuncHelpView::OnCtlColor()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmFuncHelpView::OnInitialUpdate() {
  CFormView::OnInitialUpdate();
  ResizeParentToFit(FALSE);
  m_pFuncArray = GetApp()->GetFunctionArray();

	/* Change the control fonts */
  m_ReturnText.SetFont(&m_Font, FALSE);
  m_FuncTitle.SetFont(&m_Font, FALSE);
  m_FuncName.SetFont(&m_NameFont, FALSE);
  m_WikiLink.SetFont(&m_LinkFont, FALSE);

	/* Initialize the controls */
  FillFunctionList();
  DisplayFunction(0);
  m_FunctionList.SetCurSel(0);
 }
/*===========================================================================
 *		End of Class Event CEsmFuncHelpView::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Event - void OnSelchangeFuncList ();
 *
 *=========================================================================*/
void CEsmFuncHelpView::OnSelchangeFuncList() {
  DisplayFunction(m_FunctionList.GetCurSel());
 }
/*===========================================================================
 *		End of Class Event CEsmFuncHelpView::OnSelchangeFuncList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Event - LRESULT OnViewError (wParam, lParam);
 *
 *=========================================================================*/
LRESULT CEsmFuncHelpView::OnViewError (WPARAM wParam, LPARAM lParam) {
  const TCHAR* pName = (const TCHAR *) wParam;
  int	       ListIndex;

	/* Ensure valid input */
  if (pName == NULL) return (0);

	/* Attempt to find the function in the list */
  ListIndex = m_FunctionList.FindStringExact(0, pName);
  if (ListIndex < 0) return (0);

  m_FunctionList.SetCurSel(ListIndex);
  DisplayFunction(ListIndex);

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmFuncHelpView::OnViewError()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Event - void OnSize (nType, CX, CY);
 *
 *=========================================================================*/
void CEsmFuncHelpView::OnSize (UINT nType, int CX, int CY) {
  int NewWidth;
  int NewHeight;

  CFormView::OnSize(nType, CX, CY);
  if (!IsWindow(m_DetailText.m_hWnd)) return;

  NewWidth = CX - 20;
  if (NewWidth < 150) NewWidth = 150;
  m_Bar.SetWindowPos(NULL, 0, 0, NewWidth, 2, SWP_NOZORDER | SWP_NOMOVE);

  NewWidth = CX - 70;

  m_WikiLink.SetWindowPos(NULL, CX - 60, 50, 0, 0, SWP_NOSIZE | SWP_NOZORDER);

  m_FuncTitle.SetWindowPos(NULL, 0, 0, NewWidth, 40, SWP_NOZORDER | SWP_NOMOVE);
  m_ReturnText.SetWindowPos(NULL, 0, 0, NewWidth, 25, SWP_NOZORDER | SWP_NOMOVE);

  NewHeight = (CY - 160) / 2;
  if (NewHeight < 50) NewHeight = 50;

  m_DescText.SetWindowPos(NULL, 0, 0, NewWidth, NewHeight, SWP_NOZORDER | SWP_NOMOVE);
  m_DetailText.SetWindowPos(NULL, 60, 140 + 10 + NewHeight, NewWidth, NewHeight, SWP_NOZORDER);
  m_DetailLabel.SetWindowPos(NULL, 10, 140 + 10 + NewHeight, 0, 0, SWP_NOSIZE | SWP_NOZORDER);
}
/*===========================================================================
 *		End of Class Event CEsmFuncHelpView::OnSize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Event - void OnWikilink ();
 *
 *=========================================================================*/
void CEsmFuncHelpView::OnWikilink() {
  CEsmScrFuncData* pFunction = NULL;
  CString	   Buffer;
  CString	   FuncName;
  int		   ListIndex;

  ListIndex = m_FunctionList.GetCurSel();
  if (ListIndex >= 0) pFunction = (CEsmScrFuncData *) m_FunctionList.GetItemData(ListIndex);

  Buffer  = _T("http://www.uesp.net/wiki/Tes3Mod:");

  if (pFunction)
    Buffer += pFunction->GetWikiLink();
  else
    Buffer += _T("Alphabetical_Function_List");

  OpenWebPage(Buffer);
}
/*===========================================================================
 *		End of Class Event CEsmFuncHelpView::OnWikilink()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Method - void SetDescText (pFunction);
 *
 * Sets the description text control for the given function.
 *
 *=========================================================================*/
void CEsmFuncHelpView::SetDescText (CEsmScrFuncData* pFunction) {
  m_DescText.SetWindowText(pFunction->GetDescription());
 }
/*===========================================================================
 *		End of Class Method CEsmFuncHelpView::SetDescText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Method - void SetDetailText (pFunction);
 *
 * Sets the detail text control for the given function.
 *
 *=========================================================================*/
void CEsmFuncHelpView::SetDetailText (CEsmScrFuncData* pFunction) {
  CString Buffer;
  int     Index;

  Buffer  = _T("Type(s):\t");
  Buffer += pFunction->GetFlagString();
  Buffer += _T("\r\n\r\n");

  for (Index = 0; Index < pFunction->GetNumParams(); Index++) {
    Buffer += pFunction->GetParamDetail(Index);
    Buffer += _T("\r\n");
   }

  m_DetailText.SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmFuncHelpView::SetDetailText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Method - void SetFuncTitle (pFunction);
 *
 * Sets the complete function title using the input function data.
 *
 *=========================================================================*/
void CEsmFuncHelpView::SetFuncTitle (CEsmScrFuncData* pFunction) {
  m_FuncName.SetWindowText(pFunction->GetFunction());
  m_FuncTitle.SetWindowText(pFunction->GetFuncForm());
 }
/*===========================================================================
 *		End of Class Method CEsmFuncHelpView::SetFuncTitle()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmFuncHelpView Method - void SetReturnText (pFunction);
 *
 * Sets the return text control for the given function.
 *
 *=========================================================================*/
void CEsmFuncHelpView::SetReturnText (CEsmScrFuncData* pFunction) {
  CString Buffer;

  m_ReturnText.SetWindowText(pFunction->GetReturnDesc());
 }
/*===========================================================================
 *		End of Class Method CEsmFuncHelpView::SetReturnText()
 *=========================================================================*/
