/*===========================================================================
 *
 * File:	Inputdialog.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	April 5, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __INPUTDIALOG_H
#define __INPUTDIALOG_H


/*===========================================================================
 *
 * Begin Class CInputDialog Definition
 *
 *=========================================================================*/
class CInputDialog : public CDialog {

protected:
  const TCHAR*  m_pLabel;		/* The label text string */
  const TCHAR*  m_pTitle;		/* The window title string */
  CString*	m_pOutputString;	/* Where to store the input result */


public:

	/* Construction */
  CInputDialog(CWnd* pParent = NULL);

	/* Main access method */
  bool DoModal (CString* pResult, const TCHAR* pLabel, const TCHAR* pTitle);

  //{{AFX_DATA(CInputDialog)
  enum { IDD = IDD_INPUT_DIALOG };
  CStatic	m_MainLabel;
  CEdit		m_InputText;
  //}}AFX_DATA
  
  
	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CInputDialog)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CInputDialog)
  virtual BOOL OnInitDialog();
  virtual void OnOK ();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CInputDialog Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototype
 *
 *=========================================================================*/
  bool InputDialog (CString* pResult, const TCHAR* pLabel, const TCHAR* pTitle);
/*===========================================================================
 *		End of Function Prototype
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Inputdialog.H
 *=========================================================================*/
