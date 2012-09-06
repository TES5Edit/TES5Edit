/*===========================================================================
 *
 * File:	Esmfinddlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	March 3, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMFINDDLG_H
#define __ESMFINDDLG_H


/*===========================================================================
 *
 * Begin Required Include Files
 *
 *=========================================================================*/
 #include "MWEditDoc.h"
 #include "EsmListCtrl.h"
/*===========================================================================
 *		End of Required Include Files
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
  class CEsmDlgHandler;
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmFindDlg Definition
 *
 *=========================================================================*/
class CEsmFindDlg : public CFormView {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CEsmDlgHandler* m_pDlgHandler;
  HACCEL	  m_hAccelerator;


  /*---------- Begin Protected Class Methods --------------------*/
protected:
  CEsmFindDlg();
  virtual ~CEsmFindDlg();
  DECLARE_DYNCREATE(CEsmFindDlg);

	/* Save a find history to the registry */
  void AddFindHistory (const TCHAR* pString);

	/* Fills the find list with previous entries */
  void FillFindList (void);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Set parent dialog handler */
  void SetDlgHandler (CEsmDlgHandler* pParent) { m_pDlgHandler = pParent; }

  //{{AFX_DATA(CEsmFindDlg)
  enum { IDD = IDD_FIND_DLG };
  CProgressCtrl	m_ProgressBar;
  CComboBox	m_FindList;
  CStatic	m_CountLabel;
  CEsmListCtrl	m_RecordList;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmFindDlg)
	public:
  virtual void OnInitialUpdate();
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	protected:
  virtual void DoDataExchange(CDataExchange* pDX);
	//}}AFX_VIRTUAL


protected:

	/* Class diagnostics */
#ifdef _DEBUG
  virtual void AssertValid() const;
  virtual void Dump(CDumpContext& dc) const;
#endif

	/* Generated message map functions */
  //{{AFX_MSG(CEsmFindDlg)
  afx_msg void OnFindbutton();
  afx_msg void OnCancel();
  afx_msg void OnDestroy();
  afx_msg LRESULT OnEditRecord (LPARAM lParam, LPARAM wParam);
  afx_msg void OnEditInfo();
  afx_msg void OnUpdateEditInfo(CCmdUI* pCmdUI);
  afx_msg void OnEditCopy();
  afx_msg void OnEditCut();
  afx_msg void OnEditPaste();
	afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
	afx_msg void OnEditSelectrecord();
	afx_msg void OnUpdateEditSelectrecord(CCmdUI* pCmdUI);
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmFindDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION



#endif
/*===========================================================================
 *		End of File Esmfinddlg.H
 *=========================================================================*/
