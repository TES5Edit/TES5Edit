/*===========================================================================
 *
 * File:	Esmglobaldlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 12, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMGLOBALDLG_H
#define __ESMGLOBALDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmRecDialog.h"
  #include "Resource.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmGlobalDlg Definition
 *
 *=========================================================================*/
class CEsmGlobalDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmGlobalDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmGlobal*	m_pGlobal;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmGlobalDlg();

	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);
	
	/* Dialog Data */
  //{{AFX_DATA(CEsmGlobalDlg)
  enum { IDD = IDD_GLOBAL_DLG };
  CEdit		m_ValueText;
  CComboBox	m_TypeList;
  //}}AFX_DATA
  
	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmGlobalDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmGlobalDlg)
  afx_msg void OnSelchangeTypelist();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmGlobalDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmglobaldlg.H
 *=========================================================================*/
