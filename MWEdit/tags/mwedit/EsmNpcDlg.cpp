/*===========================================================================
 *
 * File:	Esmnpcdlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 23, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmNpcDlg.h"


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

  DEFINE_FILE("EsmNpcDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmNpcDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmNpcDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmNpcDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmNpcDlg)
  ON_NOTIFY(TCN_SELCHANGING, IDC_MAINTAB, OnSelchangingMaintab)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmNpcDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcDlg Constructor
 *
 *=========================================================================*/
CEsmNpcDlg::CEsmNpcDlg() : CEsmRecDialog(CEsmNpcDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmNpcDlg)
  //}}AFX_DATA_INIT
  m_pNpc = NULL;
 }
/*===========================================================================
 *		End of Class CEsmNpcDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmNpcDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmNpcDlg)
  DDX_Control(pDX, IDC_MAINTAB, m_MainTab);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmNpcDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmNpcDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmNpcDlg::GetControlData()");
  CString	Buffer;  
  
	/* Update the object pointer and data */
  m_pNpc = (CEsmNpc *) GetRecInfo()->pRecord;
  ASSERT(m_pNpc != NULL);

  	/* Object ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pNpc->SetID(TrimStringSpace(Buffer));
   }

	/* Reallocate NPC data as required */
  m_pNpc->CreateNPCData(m_Page1.IsAutoCalc());

  m_Page1.GetControlData();
  m_Page2.GetControlData();
  m_Page3.GetControlData();
  m_Page4.GetControlData();
  m_Page5.GetControlData();
 }
/*===========================================================================
 *		End of Class Method CEsmNpcDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmNpcDlg::IsModified (void) {
  if (m_Modified) return (true);

  if (m_IDText.GetModify()) m_Modified = true;	

  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmNpcDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmNpcDlg::OnInitialUpdate() {
  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

  m_Page1.Create(IDD_NPC_VIEW1, &m_MainTab);
  m_Page2.Create(IDD_NPC_VIEW2, &m_MainTab);
  m_Page3.Create(IDD_NPC_VIEW3, &m_MainTab);
  m_Page4.Create(IDD_NPC_VIEW4, &m_MainTab);
  m_Page5.Create(IDD_NPC_VIEW5, &m_MainTab);
  
  m_MainTab.AddTab("Stats",		&m_Page1);
  m_MainTab.AddTab("Spells",		&m_Page2);
  m_MainTab.AddTab("Items",		&m_Page3);
  m_MainTab.AddTab("AI Packages",	&m_Page4);
  m_MainTab.AddTab("Services",		&m_Page5);
  m_MainTab.SetPage(0);
  m_Page1.SetDlgHandler(m_pParent);
  m_Page1.SetRecInfo(GetRecInfo());
  m_Page2.SetRecInfo(GetRecInfo());
  m_Page2.SetDlgHandler(m_pParent);
  m_Page3.SetRecInfo(GetRecInfo());
  m_Page3.SetDlgHandler(m_pParent);
  m_Page4.SetRecInfo(GetRecInfo());
  m_Page4.SetDlgHandler(m_pParent);
  m_Page5.SetRecInfo(GetRecInfo());
  m_Page5.SetDlgHandler(m_pParent);

	/* Initialize the record */
  ASSERT(GetRecInfo() != NULL);
  m_pNpc = (CEsmNpc *) GetRecInfo()->pRecord;

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmNpcDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcDlg Event - void OnSelchangingMaintab (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmNpcDlg::OnSelchangingMaintab(NMHDR* pNMHDR, LRESULT* pResult) {
  *pResult = 0;
  m_Page5.UpdateAutoCalc(m_Page1.IsAutoCalc());
 }
/*===========================================================================
 *		End of Class Event CEsmNpcDlg::OnSelchangingMaintab()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmNpcDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {

  	/* Refill the spell list if required */
  if (pRecInfo->pRecord->IsType(MWESM_REC_SPEL)) {
    m_Page2.OnUpdateItem(pRecInfo);
   }
  else {
    m_Page3.OnUpdateItem(pRecInfo);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmNpcDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmNpcDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmNpcDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pNpc == NULL) return;

  	/* Object ID, update title as well */
  m_IDText.SetWindowText(m_pNpc->GetID());
  UpdateTitle(m_pNpc->GetID());

  m_Page1.SetControlData();
  m_Page2.SetControlData();
  m_Page3.SetControlData();
  m_Page4.SetControlData();
  m_Page5.SetControlData();
 }
/*===========================================================================
 *		End of Class Method CEsmNpcDlg::SetControlData()
 *=========================================================================*/


