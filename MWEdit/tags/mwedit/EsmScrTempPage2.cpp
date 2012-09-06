/*===========================================================================
 *
 * File:	Esmscrtemppage2.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 8, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmScrTempPage2.h"
#include "EsmScrTempView.h"


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

  IMPLEMENT_DYNCREATE(CEsmScrTempPage2, CPropertyPage);
  DEFINE_FILE("EsmScrTempPage2.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmScrTempPage2 Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmScrTempPage2, CPropertyPage)
  //{{AFX_MSG_MAP(CEsmScrTempPage2)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of Class CEsmScrTempPage2 Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempPage2 Constructor
 *
 *=========================================================================*/
CEsmScrTempPage2::CEsmScrTempPage2() : CPropertyPage(CEsmScrTempPage2::IDD) {
  //{{AFX_DATA_INIT(CEsmScrTempPage2)
  //}}AFX_DATA_INIT
  m_pParentView = NULL;
 }
/*===========================================================================
 *		End of Class CEsmScrTempPage2 Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempPage2 Destructor
 *
 *=========================================================================*/
CEsmScrTempPage2::~CEsmScrTempPage2() {
 }
/*===========================================================================
 *		End of Class CEsmScrTempPage2 Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempPage2 Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmScrTempPage2::DoDataExchange(CDataExchange* pDX) {
  CPropertyPage::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmScrTempPage2)
  DDX_Control(pDX, IDC_TEMPLATE_TEXT, m_TemplateText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempPage2::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempPage2 Method - void UpdatePage (void);
 *
 * Updates the page's controls from the variable data.
 *
 *=========================================================================*/
void CEsmScrTempPage2::UpdatePage (void) {
  m_TemplateText.SetWindowText(m_pParentView->GetScriptTemplate()->GetTemplateText());
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempPage1::CEsmScrTempPage2()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempPage2 Method - void UpdateText (void);
 *
 * Updates any changed text in the text control to the script template
 * object.
 *
 *=========================================================================*/
void CEsmScrTempPage2::UpdateText (void) {
  CString Buffer;

  m_TemplateText.GetWindowText(Buffer);
  m_pParentView->GetScriptTemplate()->SetText(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempPage2::UpdateText()
 *=========================================================================*/
