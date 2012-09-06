/*===========================================================================
 *
 * File:	Esmheaderdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	March 2, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMHEADERDLG_H
#define __ESMHEADERDLG_H


/*===========================================================================
 *
 * Begin Class CEsmHeaderDlg Definition
 *
 *=========================================================================*/
class CEsmHeaderDlg : public CDialog {

  /*---------- Begin Protected Class Members ----------------------*/
protected:
  CEsmTES3*    m_pHeader;
  const TCHAR* m_pFilename;
  

  /*---------- Begin Public Class Methods -------------------------*/
public:

	/* Construction */
  CEsmHeaderDlg(CWnd* pParent = NULL);

	/* Main access method */
  bool DoModal (CEsmTES3* pHeader, const TCHAR* pFilename);

	/* Dialog Data */
  //{{AFX_DATA(CEsmHeaderDlg)
  enum { IDD = IDD_HEADER_DLG };
  CEdit	m_DescText;
  CEdit	m_AuthorText;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmHeaderDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmHeaderDlg)
  virtual void OnOK();
	virtual BOOL OnInitDialog();
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();

};
/*===========================================================================
 *		End of Class CEsmHeaderDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmheaderdlg.H
 *=========================================================================*/
