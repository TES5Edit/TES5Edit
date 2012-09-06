/*===========================================================================
 *
 * File:	Errordialog.H
 * Author:	Dave Humphrey (uesp@sympatico.ca)
 * Created On:	November 21, 2006
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ERRORDIALOG_H
#define __ERRORDIALOG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


class CErrorDialog : public CDialog
{

public:
	CErrorDialog(CWnd* pParent = NULL);

	CString	m_MessageText;
	CString	m_TitleText;

	//{{AFX_DATA(CErrorDialog)
	enum { IDD = IDD_ERROR_DLG };
	CEdit	m_Text;
	CStatic	m_Label;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CErrorDialog)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);
	//}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CErrorDialog)
	virtual BOOL OnInitDialog();
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();
};


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Errordialog.H
 *=========================================================================*/
