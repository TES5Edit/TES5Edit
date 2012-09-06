/*===========================================================================
 *
 * File:	Esmloaddlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	March 2, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMLOADDLG_H
#define __ESMLOADDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "resource.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmLoadDlg Definition
 *
 *=========================================================================*/
class CEsmLoadDlg : public CDialog {

  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmLoadDlg(CWnd* pParent = NULL);

	/* Dialog Data */
  //{{AFX_DATA(CEsmLoadDlg)
  enum { IDD = IDD_LOAD_DLG };
  CStatic	m_SubLabel;
  CStatic	m_FileLabel;
  CProgressCtrl	m_ProgressCtrl;
  //}}AFX_DATA

  	/* Update the dialog members */
  void SetFilename (const TCHAR* pString) { m_FileLabel.SetWindowText(pString); }
  void SetSubLabel (const TCHAR* pString) { m_SubLabel.SetWindowText(pString); }
  void SetProgress (const float  Percent) { m_ProgressCtrl.SetPos((long)Percent); }

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmLoadDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmLoadDlg)
  virtual BOOL OnInitDialog();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmLoadDlg Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/

	/* Global function for dialog update callback during load */
  int g_EsmLoadDlgCallback (const int Event, const TCHAR* pMessage, const float Percent, long Data);

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmloaddlg.H
 *=========================================================================*/
