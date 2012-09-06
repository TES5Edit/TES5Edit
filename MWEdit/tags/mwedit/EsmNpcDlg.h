/*===========================================================================
 *
 * File:	Esmnpcdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 23, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMNPCDLG_H
#define __ESMNPCDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmRecDialog.h"
  #include "Resource.h"
  #include "windows/TabCtrlSheet.h"
  #include "EsmNpcPage1.h"
  #include "EsmNpcPage2.h"
  #include "EsmNpcPage3.h"
  #include "EsmNpcPage4.h"
  #include "EsmNpcPage5.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmNpcDlg Definition
 *
 *=========================================================================*/
class CEsmNpcDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmNpcDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmNpcPage1	 m_Page1;
  CEsmNpcPage2	 m_Page2;
  CEsmNpcPage3	 m_Page3;
  CEsmNpcPage4	 m_Page4;
  CEsmNpcPage5	 m_Page5;
  CEsmNpc*	 m_pNpc;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmNpcDlg();

  	/* Get class members */
  virtual bool IsModified (void);
	
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmNpcDlg)
  enum { IDD = IDD_NPC_DLG };
  CTabCtrlSheet	m_MainTab;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmNpcDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmNpcDlg)
  afx_msg void OnSelchangingMaintab(NMHDR* pNMHDR, LRESULT* pResult);
  //}}AFX_MSG
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmNpcDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmnpcdlg.H
 *=========================================================================*/
