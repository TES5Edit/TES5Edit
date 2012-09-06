/*===========================================================================
 *
 * File:	Esmstaticdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmStaticDlg.h"


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

  DEFINE_FILE("EsmStaticDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmStaticDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmStaticDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmStaticDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmStaticDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmStaticDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmStaticDlg Constructor
 *
 *=========================================================================*/
CEsmStaticDlg::CEsmStaticDlg() : CEsmRecDialog(CEsmStaticDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmStaticDlg)
  //}}AFX_DATA_INIT
  m_pStatic = NULL;
 }
/*===========================================================================
 *		End of Class CEsmStaticDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmStaticDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmStaticDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmStaticDlg)
  DDX_Control(pDX, IDC_PERSISTCHECK, m_PersistCheck);
  DDX_Control(pDX, IDC_BLOCKEDCHECK, m_BlockedCheck);
  DDX_Control(pDX, IDC_MODELBUTTON, m_ModelButton);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmStaticDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmStaticDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmStaticDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmStaticDlg::GetControlData()");
  CString	Buffer;  
  
	/* Update the armor pointer and data */
  m_pStatic = (CEsmStatic *) GetRecInfo()->pRecord;
  ASSERT(m_pStatic != NULL);
  
	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pStatic->SetID(TrimStringSpace(Buffer));
   }
	
	/* Model filename */
  m_ModelButton.GetWindowText(Buffer);
  m_pStatic->SetModel(TrimStringSpace(Buffer));

	/* Record flags */
  m_pStatic->SetPersist(m_PersistCheck.GetCheck() != 0);
  m_pStatic->SetBlocked(m_BlockedCheck.GetCheck() != 0);
 }
/*===========================================================================
 *		End of Class Method CEsmStaticDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmStaticDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmStaticDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_IDText.GetModify())   m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmStaticDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmStaticDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmStaticDlg::OnInitialUpdate() {
  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pStatic = (CEsmStatic *) GetRecInfo()->pRecord;

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmStaticDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmStaticDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmStaticDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {
  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmStaticDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmStaticDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmStaticDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pStatic == NULL) return;

	/* Armor ID, update title as well */
  m_IDText.SetWindowText(m_pStatic->GetID());
  UpdateTitle(m_pStatic->GetID());

	/* Model/icon buttons */
  m_ModelButton.SetWindowText(m_pStatic->GetModel());

	/* Record flags */
  m_BlockedCheck.SetCheck(m_pStatic->IsBlocked());
  m_PersistCheck.SetCheck(m_pStatic->IsPersist());
 }
/*===========================================================================
 *		End of Class Method CEsmStaticDlg::SetControlData()
 *=========================================================================*/

