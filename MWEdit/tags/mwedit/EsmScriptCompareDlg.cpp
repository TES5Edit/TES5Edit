/*===========================================================================
 *
 * File:	EsmScriptCompareDlg.CPP
 * Author:	Dave Humphrey (uesp@sympatico.ca)
 * Created On:	September 8, 2006
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmScriptCompareDlg.h"


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

  DEFINE_FILE("EsmScriptCompareDlg.CPP");
  IMPLEMENT_DYNCREATE(CEsmScriptCompareDlg, CFormView)
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmScriptCompareDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmScriptCompareDlg, CFormView)
  //{{AFX_MSG_MAP(CEsmScriptCompareDlg)
  ON_WM_DESTROY()
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmScriptCompareDlg Message Map
 *=========================================================================*/



/*===========================================================================
 *
 * Class CEsmScriptCompareDlg Constructor
 *
 *=========================================================================*/
CEsmScriptCompareDlg::CEsmScriptCompareDlg() : CFormView(CEsmScriptCompareDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmScriptCompareDlg)
  //}}AFX_DATA_INIT
  m_pDlgHandler = NULL;
 }
/*===========================================================================
 *		End of Class CEsmScriptCompareDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompareDlg Destructor
 *
 *=========================================================================*/
CEsmScriptCompareDlg::~CEsmScriptCompareDlg() {
 }
/*===========================================================================
 *		End of Class CEsmScriptCompareDlg Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompareDlg Method - void AddLogText (pString, Args);
 *
 *=========================================================================*/
void CEsmScriptCompareDlg::AddLogText (const TCHAR* pString, va_list Args) {
  CString Buffer;
  int     Length;

  Buffer.FormatV(pString, Args);
  Buffer += _T("\r\n");

  Length = m_LogText.GetWindowTextLength();
  m_LogText.SetSel(Length, Length);
  m_LogText.ReplaceSel(Buffer);
}
/*===========================================================================
 *		End of Class Method CEsmScriptCompareDlg::AddLogText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompareDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmScriptCompareDlg::DoDataExchange (CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmScriptCompareDlg)
  DDX_Control(pDX, IDC_LOGTEXT, m_LogText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompareDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class Diagnostics
 *
 *=========================================================================*/
#ifdef _DEBUG

void CEsmScriptCompareDlg::AssertValid() const {
  CFormView::AssertValid();
 }

void CEsmScriptCompareDlg::Dump(CDumpContext& dc) const {
  CFormView::Dump(dc);
 }

#endif 
/*===========================================================================
 *		End of Class Diagnostics
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompareDlg Event - void OnCancel ();
 *
 *=========================================================================*/
void CEsmScriptCompareDlg::OnCancel() {
  GetParentFrame()->DestroyWindow();
 }
/*===========================================================================
 *		End of Class Event CEsmScriptCompareDlg::OnCancel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompareDlg Event - void OnDestroy();
 *
 *=========================================================================*/
void CEsmScriptCompareDlg::OnDestroy() {
  CFormView::OnDestroy();
  m_pDlgHandler->OnCloseScriptCompareDlg();
 }
/*===========================================================================
 *		End of Class Event CEsmScriptCompareDlg::OnDestroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompareDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmScriptCompareDlg::OnInitialUpdate() {
  
  CFormView::OnInitialUpdate();
  ResizeParentToFit(FALSE);

  UpdateTitle();

	/* Find the uses information for the current record */
  //ShowWindow(SW_NORMAL);
  //RedrawWindow();
  //GetParentFrame()->ShowWindow(SW_NORMAL);
  //UpdateUses();
 }
/*===========================================================================
 *		End of Class Event CEsmScriptCompareDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompareDlg Method - void UpdateTitle (void);
 *
 * Updates the parent frame title based on the current document and 
 * record information.
 *
 *=========================================================================*/
void CEsmScriptCompareDlg::UpdateTitle (void) {
  CString Buffer;

  Buffer.Format(_T("%s -- Script Compare"), m_pDlgHandler->GetDocument()->GetTitle());
  GetParentFrame()->SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompareDlg::UpdateTitle()
 *=========================================================================*/