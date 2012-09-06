/*===========================================================================
 *
 * File:	Scripterrordlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 6, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SCRIPTERRORDLG_H
#define __SCRIPTERRORDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmScriptError.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/
	
	/* Return codes */
  #define SCRERRDLG_RESULT_GOTO		101
  #define SCRERRDLG_RESULT_MOREHELP	102

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CScriptErrorDlg
 *
 *=========================================================================*/
class CScriptErrorDlg : public CDialog {

  /*---------- Begin Protected Class Memebers -----------------------*/
protected:
  CEsmScriptError*	m_pError;		/* Reference to the script error object */


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Standard constructor */
  CScriptErrorDlg(CWnd* pParent = NULL);

	/* Clear/enable control contents */
  void ClearControlData  (void);
  void ClearFunctionData (void);
  void EnableControls    (const bool Enable);
  void EnableFuncCtrls   (const bool Enable);

	/* Set class members */
  void SetScriptError (CEsmScriptError* pError) { m_pError = pError; }

	/* Update the controls from the current error object */
  void SetControlData  (void);
  void SetFunctionData (void);

	/* Dialog Data */
  //{{AFX_DATA(CScriptErrorDlg)
	enum { IDD = IDD_SCRIPTERROR_DLG };
	CButton	m_GotoButton;
  CButton	m_FuncButton;
  CEdit		m_FuncDescText;
  CEdit		m_FuncFormText;
  CEdit		m_FuncArgText;
  CEdit		m_FunctionText;
  CEdit		m_MsgText;
  CEdit		m_TokenText;
  CEdit		m_LocationText;
  CEdit		m_CodeText;
  CEdit		m_MsgTypeText;
	//}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CScriptErrorDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CScriptErrorDlg)
  afx_msg void OnFuncButton();
  virtual BOOL OnInitDialog();
	afx_msg void OnFuncGoto();
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CScriptErrorDlg
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Scripterrordlg.H
 *=========================================================================*/
