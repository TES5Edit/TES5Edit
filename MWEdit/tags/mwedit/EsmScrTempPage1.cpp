/*===========================================================================
 *
 * File:	Esmscrtemppage1.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 8, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmScrTempPage1.h"
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

  IMPLEMENT_DYNCREATE(CEsmScrTempPage1, CPropertyPage)
  DEFINE_FILE("EsmScrTempPage1.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmScrTempPage1 Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmScrTempPage1, CPropertyPage)
  //{{AFX_MSG_MAP(CEsmScrTempPage1)
  ON_BN_CLICKED(IDC_LOADSCRTEMP, OnLoadscrtemp)
  ON_BN_CLICKED(IDC_UPDATETEXT, OnUpdatetext)
  ON_BN_CLICKED(IDC_LOADCSV, OnLoadcsv)
  ON_BN_CLICKED(IDC_RELOADSCRTEMP, OnReloadscrtemp)
  ON_BN_CLICKED(IDC_RELOADCSVFILE, OnReloadcsvfile)
  ON_BN_CLICKED(IDC_AUTOSCRIPTNAME, OnAutoscriptname)
  ON_BN_CLICKED(IDC_CHECK, OnCheckTemplate)
  ON_BN_CLICKED(IDC_CREATE, OnCreateTemplate)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of Class CEsmScrTempPage1 Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempPage1 Constructor
 *
 *=========================================================================*/
CEsmScrTempPage1::CEsmScrTempPage1() : CPropertyPage(CEsmScrTempPage1::IDD) {
  //{{AFX_DATA_INIT(CEsmScrTempPage1)
  //}}AFX_DATA_INIT
  m_pParentView = NULL;
 }
/*===========================================================================
 *		End of Class CEsmScrTempPage1 Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempPage1 Destructor
 *
 *=========================================================================*/
CEsmScrTempPage1::~CEsmScrTempPage1() {
 }
/*===========================================================================
 *		End of Class CEsmScrTempPage1 Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempPage1 Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmScrTempPage1::DoDataExchange(CDataExchange* pDX) {
  CPropertyPage::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmScrTempPage1)
	DDX_Control(pDX, IDC_SCRIPTNAME, m_ScriptName);
	DDX_Control(pDX, IDC_AUTOSCRIPTNAME, m_AutoScriptName);
	DDX_Control(pDX, IDC_ONLYVALIDROWS, m_OnlyCompleteRows);
	DDX_Control(pDX, IDC_KEEPCSVSTRINGS, m_KeepQuotes);
  DDX_Control(pDX, IDC_CSV_FILE, m_CsvFile);
  DDX_Control(pDX, IDC_TEMPLATE_FILE, m_TemplateFile);
  DDX_Control(pDX, IDC_TEMPLATELIST, m_TemplateList);
	//}}AFX_DATA_MAP
}
/*===========================================================================
 *		End of Class Method CEsmScrTempPage1::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempPage1 Method - void FillTempVarList (void);
 *
 * Fills the list of template variables.
 *
 *=========================================================================*/
void CEsmScrTempPage1::FillTempVarList (void) {
  CEsmScriptTemplate*	pScrTemplate = m_pParentView->GetScriptTemplate();
  esmscrtempvar_t*	pTempVar;
  CString		Buffer;
  int			Index;
  int			iResult;

	/* Clear the current list */
  m_TemplateList.ResetContent();

  for (Index = 0; Index < pScrTemplate->GetNumTempVars(); Index++) {
    pTempVar = pScrTemplate->GetTemplateVar(Index);

    Buffer.Format(_T("%s   (%d)"), pTempVar->Name, pTempVar->Uses);
    iResult = m_TemplateList.AddString(Buffer);
    if (iResult != LB_ERR) m_TemplateList.SetItemDataPtr(iResult, pTempVar);
   }

  }
/*===========================================================================
 *		End of Class Method CEsmScrTempPage1::FillTempVarList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempPage1 Method - void GetControlData (void);
 *
 * Save the current control data.
 *
 *=========================================================================*/
void CEsmScrTempPage1::GetControlData (void) {
  CString Buffer;
  
  	/* Update the options */
  m_pParentView->GetOptions()->KeepQuotes       = (m_KeepQuotes.GetCheck() != 0);
  m_pParentView->GetOptions()->OnlyCompleteRows = (m_OnlyCompleteRows.GetCheck() != 0);
  m_pParentView->GetOptions()->AutoScriptName   = (m_AutoScriptName.GetCheck() != 0);
  m_ScriptName.GetWindowText(Buffer);
  m_pParentView->GetOptions()->SetScriptName(Buffer);
  
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempPage1::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempPage1 Event - void OnAutoscriptname ();
 *
 *=========================================================================*/
void CEsmScrTempPage1::OnAutoscriptname() {
  m_ScriptName.EnableWindow(m_AutoScriptName.GetCheck() != 0);
 }
/*===========================================================================
 *		End of Class Event CEsmScrTempPage1::OnAutoscriptname()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempPage1 Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmScrTempPage1::OnInitDialog() {
  CPropertyPage::OnInitDialog();
	
  m_ScriptName.SetLimitText(ESMSCRTEMP_SCRIPTNAMESIZE);
	
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmScrTempPage1::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempPage1 Event - void OnLoadcsv ();
 *
 *=========================================================================*/
void CEsmScrTempPage1::OnCheckTemplate() {
  m_pParentView->OnCheckTemplate();
 }


void CEsmScrTempPage1::OnCreateTemplate() {
  m_pParentView->OnCreateTemplate();
 }


void CEsmScrTempPage1::OnLoadcsv() {
  m_pParentView->OnScrtempLoadcsv();
 }


void CEsmScrTempPage1::OnLoadscrtemp() {
  m_pParentView->OnLoadTemplate();
 }


void CEsmScrTempPage1::OnReloadcsvfile() {
  m_pParentView->OnReloadCsvFile();
 }


void CEsmScrTempPage1::OnReloadscrtemp() {
  m_pParentView->OnReloadScrTemp();
 }


void CEsmScrTempPage1::OnUpdatetext() {
  m_pParentView->OnUpdateText();
 }
/*===========================================================================
 *		End of Class Event CEsmScrTempPage1::OnUpdatetext()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScrTempPage1 Method - void UpdatePage (void);
 *
 * Updates the page's controls from the variable data.
 *
 *=========================================================================*/
void CEsmScrTempPage1::UpdatePage (void) {

	/* Update the template filename */
  m_TemplateFile.SetWindowText(m_pParentView->GetScriptTemplate()->GetFilename());

  	/* Update the csv filename */
  m_CsvFile.SetWindowText(m_pParentView->GetCsvFile()->GetFilename());

	/* Update the options */
  m_KeepQuotes.SetCheck(m_pParentView->GetOptions()->KeepQuotes);
  m_OnlyCompleteRows.SetCheck(m_pParentView->GetOptions()->OnlyCompleteRows);
  m_AutoScriptName.SetCheck(m_pParentView->GetOptions()->AutoScriptName);
  m_ScriptName.SetWindowText(m_pParentView->GetOptions()->ScriptName);
  m_ScriptName.EnableWindow(m_pParentView->GetOptions()->AutoScriptName);

	/* Fill the template variable list */
  FillTempVarList();
 }
/*===========================================================================
 *		End of Class Method CEsmScrTempPage1::UpdatePage()
 *=========================================================================*/


