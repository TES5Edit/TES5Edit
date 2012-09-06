/*===========================================================================
 *
 * File:	Esmcelldlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 21, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmCellDlg.h"

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

  DEFINE_FILE("EsmCellDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmCellDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmCellDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmCellDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmCellDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmCellDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCellDlg Constructor
 *
 *=========================================================================*/
CEsmCellDlg::CEsmCellDlg() : CEsmRecDialog(CEsmCellDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmCellDlg)
  //}}AFX_DATA_INIT
  m_pCell = NULL;
 }
/*===========================================================================
 *		End of Class CEsmCellDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCellDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmCellDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmCellDlg)
  DDX_Control(pDX, IDC_GRIDTEXT, m_GridText);
  DDX_Control(pDX, IDC_TABCTRL, m_TabControl);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmCellDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCellDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmCellDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmCellDlg::GetControlData()");
  CString	Buffer;  
  
	/* Update the armor pointer and data */
  m_pCell = (CEsmCell *) GetRecInfo()->pRecord;
  ASSERT(m_pCell != NULL);
  
	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pCell->SetID(TrimStringSpace(Buffer));
   }

  	/* Get interior/exterior data */
  if (m_pCell->IsInterior()) {
    m_IntCellPage.GetControlData();
   }
  else {
    m_ExtCellPage.GetControlData();
   }

  m_RefCellPage.GetControlData();
 }
/*===========================================================================
 *		End of Class Method CEsmCellDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCellDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmCellDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_IDText.GetModify()) m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmCellDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCellDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmCellDlg::OnInitialUpdate() {
  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

  	/* Initialize the cell record */
  ASSERT(GetRecInfo() != NULL);
  m_pCell = (CEsmCell *) GetRecInfo()->pRecord;

	/* Create the tab control pages according to the cell type */  
  m_RefCellPage.Create(IDD_REFCELL_PAGE, &m_TabControl);
  m_TabControl.AddTab("Objects",  &m_RefCellPage);
  m_RefCellPage.SetRecInfo(GetRecInfo());
  m_RefCellPage.SetEsmRecParent(this);

  if (m_pCell->IsInterior()) {
    m_IntCellPage.Create(IDD_INTCELL_PAGE, &m_TabControl);
    m_TabControl.AddTab("Interior", &m_IntCellPage);
    m_IntCellPage.SetEsmRecParent(this);
    m_IntCellPage.SetRecInfo(GetRecInfo());
   }
  else {
    m_ExtCellPage.Create(IDD_EXTCELL_PAGE, &m_TabControl);
    m_TabControl.AddTab("Exterior", &m_ExtCellPage);
    m_ExtCellPage.SetEsmRecParent(this);
    m_ExtCellPage.SetRecInfo(GetRecInfo());
   }
 
  m_TabControl.SetPage(0);
  
	/* Initialize the text controls */
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE*2);

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmCellDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCellDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmCellDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {

  	/* Refill the script list if required */
  if (pRecInfo->pRecord->IsType(MWESM_REC_REGN)) {
    if (m_pCell->IsInterior()) m_IntCellPage.OnUpdateItem(pRecInfo);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmCellDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCellDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmCellDlg::SetControlData (void) {
  
	/* Ignore if the current item is not valid */
  if (m_pCell == NULL) return;
  
	/* Item ID, update title as well */
  m_IDText.SetWindowText(m_pCell->GetID());
  UpdateTitle(m_pCell->GetName());
  m_IDText.SetModify(FALSE);

	/* Read only textbox for the grid coordinates */
  m_GridText.SetWindowText(m_pCell->GetGrid());

  m_RefCellPage.SetControlData();

  if (m_pCell->IsInterior())
    m_IntCellPage.SetControlData();
  else
    m_ExtCellPage.SetControlData();

 }
/*===========================================================================
 *		End of Class Method CEsmCellDlg::SetControlData()
 *=========================================================================*/


