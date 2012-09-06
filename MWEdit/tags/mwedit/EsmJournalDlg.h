/*===========================================================================
 *
 * File:	Esmjournaldlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	March 2, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMJOURNALDLG_H
#define __ESMJOURNALDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmInfo.h"
  #include "contain/ptrarray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Class forward definition */
  class CMWEditDoc;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmJournalDlg Definition
 *
 *=========================================================================*/
class CEsmJournalDlg : public CDialog {

  /*---------- Begin Protected Class Methods ----------------------*/
protected:
  CEsmInfo*	m_pInfo;	/* The info object we are editting */
  bool		m_IsNew;	
  bool		m_AlreadyIsNew;

  CMWEditDoc*	m_pDocument;


  /*---------- Begin Public Class Methods ------------------------*/
public:

	/* Construction */
  CEsmJournalDlg(CWnd* pParent = NULL);

	/* Main access method */
  bool DoModal (CEsmInfo* pInfo, const bool IsNew, CMWEditDoc* pDocument);

	/* Get class members */
  bool      HasNewInfo (void) { return (m_IsNew); }
  CEsmInfo* GetInfo    (void) { return (m_pInfo); }

	/* Set/get control data */
  void GetControlData (void);
  void SetControlData (void);
  void GetFuncData (const int Index, int& FuncIndex);
  void SetFuncData (const int Index, CEsmSubSCVR* pFuncData, CEsmSubRecord* pValue);

	/* Dialog Data */
  //{{AFX_DATA(CEsmJournalDlg)
  enum { IDD = IDD_JOURNAL_DLG };
  CEdit		m_IndexText;
  CButton	m_RestartCheck;
  CButton	m_FinishCheck;
  CButton	m_NameCheck;
  CEdit		m_NameText;
  CEdit		m_IDText;
  //}}AFX_DATA
  

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmJournalDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmJournalDlg)
  virtual void OnOK();
  virtual void OnCancel();
  virtual BOOL OnInitDialog();
	afx_msg void OnNamecheck();
	afx_msg void OnFinishcheck();
	afx_msg void OnRestartcheck();
	//}}AFX_MSG
  
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmJournalDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmjournaldlg.H
 *=========================================================================*/
