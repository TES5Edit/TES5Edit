/*===========================================================================
 *
 * File:	Esmcreaturedlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 15, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmCreatureDlg.h"


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

  DEFINE_FILE("EsmCreatureDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmCreatureDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmCreatureDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmCreatureDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmCreatureDlg)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmCreatureDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreatureDlg Constructor
 *
 *=========================================================================*/
CEsmCreatureDlg::CEsmCreatureDlg() : CEsmRecDialog(CEsmCreatureDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmCreatureDlg)
  //}}AFX_DATA_INIT
  m_pCreature = NULL;
 }
/*===========================================================================
 *		End of Class CEsmCreatureDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreatureDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmCreatureDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmCreatureDlg)
  DDX_Control(pDX, IDC_MAINTAB, m_MainTab);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmCreatureDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreatureDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmCreatureDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmCreatureDlg::GetControlData()");
  CString	Buffer;  
  
	/* Update the armor pointer and data */
  m_pCreature = (CEsmCreature *) GetRecInfo()->pRecord;
  ASSERT(m_pCreature != NULL);

  	/* Object ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pCreature->SetID(TrimStringSpace(Buffer));
   }
  
  m_Page1.GetControlData();
  m_Page2.GetControlData();
  m_Page3.GetControlData();
  m_Page4.GetControlData();
  m_Page5.GetControlData();
 }
/*===========================================================================
 *		End of Class Method CEsmCreatureDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreatureDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmCreatureDlg::IsModified (void) {
  if (m_Modified) return (true);

	
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmCreatureDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreatureDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmCreatureDlg::OnInitialUpdate() {
  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

  m_Page1.Create(IDD_CREATURE_VIEW1, &m_MainTab);
  m_Page2.Create(IDD_CREATURE_VIEW2, &m_MainTab);
  m_Page3.Create(IDD_CREATURE_VIEW3, &m_MainTab);
  m_Page4.Create(IDD_CREATURE_VIEW4, &m_MainTab);
  m_Page5.Create(IDD_CREATURE_VIEW5, &m_MainTab);
  m_Page1.SetRecInfo(GetRecInfo());
  m_Page1.SetDlgHandler(m_pParent);
  m_Page2.SetRecInfo(GetRecInfo());
  m_Page2.SetDlgHandler(m_pParent);
  m_Page3.SetRecInfo(GetRecInfo());
  m_Page3.SetDlgHandler(m_pParent);
  m_Page4.SetRecInfo(GetRecInfo());
  m_Page4.SetDlgHandler(m_pParent);
  m_Page5.SetRecInfo(GetRecInfo());
  m_Page5.SetDlgHandler(m_pParent);

  m_MainTab.AddTab("Statistics", &m_Page1);
  m_MainTab.AddTab("Spells", &m_Page2);
  m_MainTab.AddTab("Items", &m_Page3);
  m_MainTab.AddTab("AI Packages", &m_Page4);
  m_MainTab.AddTab("Services", &m_Page5);
  m_MainTab.SetPage(0);

	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pCreature = (CEsmCreature *) GetRecInfo()->pRecord;

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmCreatureDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmCreatureDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmCreatureDlg::SetControlData (void) {

	/* Ignore if the current item is not valid */
  if (m_pCreature == NULL) return;

  	/* Object ID, update title as well */
  m_IDText.SetWindowText(m_pCreature->GetID());
  UpdateTitle(m_pCreature->GetID());

  m_Page1.SetControlData();
  m_Page2.SetControlData();
  m_Page3.SetControlData();
  m_Page4.SetControlData();
  m_Page5.SetControlData();
 }
/*===========================================================================
 *		End of Class Method CEsmCreatureDlg::SetControlData()
 *=========================================================================*/

