/*===========================================================================
 *
 * File:	Esmcreaturedlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 15, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMCREATUREDLG_H
#define __ESMCREATUREDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmRecDialog.h"
  #include "Resource.h"
  #include "windows/TabCtrlSheet.h"
  #include "EsmCreaturePage1.h"
  #include "EsmCreaturePage2.h"
  #include "EsmCreaturePage3.h"
  #include "EsmCreaturePage4.h"
  #include "EsmCreaturePage5.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmCreatureDlg Definition
 *
 *=========================================================================*/
class CEsmCreatureDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmCreatureDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmCreaturePage1 m_Page1;
  CEsmCreaturePage2 m_Page2;
  CEsmCreaturePage3 m_Page3;
  CEsmCreaturePage4 m_Page4;
  CEsmCreaturePage5 m_Page5;
  CEsmCreature*	    m_pCreature;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmCreatureDlg();

  	/* Get class members */
  virtual bool IsModified (void);
	
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmCreatureDlg)
  enum { IDD = IDD_CREATURE_DLG };
  CTabCtrlSheet	m_MainTab;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmCreatureDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmCreatureDlg)
  afx_msg void OnScriptEdit();
  //}}AFX_MSG
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmCreatureDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmcreaturedlg.H
 *=========================================================================*/
