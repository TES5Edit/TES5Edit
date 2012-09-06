/*===========================================================================
 *
 * File:	NifTo3dsDlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Saturday, 06 December, 2003
 *
 * Definition of the CNifTo3dsDlg class.
 *
 *=========================================================================*/
#ifndef __NifTo3dsDlg_H
#define __NifTo3dsDlg_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "ConvertNif3ds.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTo3dsDlg Definition
 *
 *=========================================================================*/
class CNifTo3dsDlg : public CDialog {


  /*---------- Begin Protected Class Members ---------------------------*/
protected:
  HICON		m_hIcon;


  /*---------- Begin Protected Class Methods ---------------------------*/
protected:



  /*---------- Begin Public Class Methods ------------------------------*/
public:

	/* Constructor/destructor */
  CNifTo3dsDlg(CWnd* pParent = NULL);

	/* Dialog Data */
  //{{AFX_DATA(CNifTo3dsDlg)
  enum { IDD = IDD_NIFTO3DS_DIALOG };
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CNifTo3dsDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

	/* Generated message map functions */
  //{{AFX_MSG(CNifTo3dsDlg)
  virtual BOOL OnInitDialog();
  afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
  afx_msg void OnDestroy();
  afx_msg void OnPaint();
  afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnConvertButton();
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP()

 };
/*===========================================================================
 *		End of Class CNifTo3dsDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION Microsoft Visual C++ will insert additional declarations immediately before the previous line.


#endif
/*===========================================================================
 *		End of File NifTo3dsDlg.H
 *=========================================================================*/
