/*===========================================================================
 *
 * File:	Esmstartscriptdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 13, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSTARTSCRIPTDLG_H
#define __ESMSTARTSCRIPTDLG_H


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
 * Begin Class CEsmStartScriptDlg Definition
 *
 *=========================================================================*/
class CEsmStartScriptDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmStartScriptDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmStartScript*	m_pStartScript;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

  	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Standard constructor */
  CEsmStartScriptDlg(CWnd* pParent = NULL);

  	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmStartScriptDlg)
  enum { IDD = IDD_STARTSCRIPT_DLG };
  CButton	m_BlockedCheck;
  CButton	m_PersistCheck;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmStartScriptDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  virtual void OnInitialUpdate();
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmStartScriptDlg)
	afx_msg void OnSelchangeScriptlist();
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmStartScriptDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION}}


#endif
/*===========================================================================
 *		End of File Esmstartscriptdlg.H
 *=========================================================================*/
