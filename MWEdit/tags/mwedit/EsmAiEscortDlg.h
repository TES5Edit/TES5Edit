/*===========================================================================
 *
 * File:	Esmaiescortdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 24, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMAIESCORTDLG_H
#define __ESMAIESCORTDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmSubAI_E.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmAiEscortDlg
 *
 *=========================================================================*/
class CEsmAiEscortDlg : public CDialog {

  /*---------- Begin Protected Class Members -------------------------*/
protected:
  CEsmSubAI_E*	m_pSubRecord;
  CString	m_CellName;
  CString	m_Title;


  /*---------- Begin Public Class Method -----------------------------*/
public:

	/* Construction */
  CEsmAiEscortDlg(CWnd* pParent = NULL);

	/* Main access method */
  bool DoModal (CEsmSubAI_E* pSubRecord, const TCHAR* pCellName, const TCHAR* pTitle);

	/* Get class members */
  CString& GetCellName (void) { return (m_CellName); }

	/* Dialog Data */
  //{{AFX_DATA(CEsmAiEscortDlg)
  enum { IDD = IDD_AIESCORT_DLG };
  CEdit		m_ZText;
  CEdit		m_YText;
  CEdit		m_XText;
  CButton	m_PointCheck;
  CComboBox	m_CellList;
  CButton	m_EscortCheck;
  CEdit		m_DurationText;
  CComboBox	m_TargetList;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmAiEscortDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmAiEscortDlg)
  virtual BOOL OnInitDialog();
  virtual void OnOK();
	afx_msg void OnEscortcheck();
	afx_msg void OnPointcheck();
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmAiEscortDlg
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmaiescortdlg.H
 *=========================================================================*/
