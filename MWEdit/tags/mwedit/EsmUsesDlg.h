/*===========================================================================
 *
 * File:	Esmusesdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 7, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMUSESDLG_H
#define __ESMUSESDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "MWEditDoc.h"
  #include "EsmListCtrl.h"
/*===========================================================================
 *		End of Required Includes
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
 * Begin CEsmUsesDlg Definition
 *
 *=========================================================================*/
class CEsmUsesDlg : public CFormView {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CEsmDlgHandler* m_pDlgHandler;	/* Reference to parent handler */
  esmrecinfo_t*   m_pRecInfo;		/* The record being searched for */

  int		  m_TotalRecords;
  int		  m_UsedRecords;


  /*---------- Begin Protected Class Methods --------------------*/
protected:
  CEsmUsesDlg();
  virtual ~CEsmUsesDlg();
  DECLARE_DYNCREATE(CEsmUsesDlg);

  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Set class members */
  void SetDlgHandler (CEsmDlgHandler* pParent) { m_pDlgHandler = pParent; }
  void SetRecInfo    (esmrecinfo_t* pRecInfo)  { m_pRecInfo    = pRecInfo; }

	/* Updates the uses label control */
  void UpdateLabel (void);

	/* Updates the title based on the current information */
  void UpdateTitle (void);

	/* Updates the uses information for the current record */
  bool UpdateUses (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmUsesDlg)
  enum { IDD = IDD_USES_DLG };
  CStatic	m_UsesLabel;
  CProgressCtrl	m_ProgressBar;
  CEsmListCtrl	m_RecordList;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmUsesDlg)
public:
  virtual void OnInitialUpdate();
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
  //{{AFX_MSG(CEsmUsesDlg)
  afx_msg void OnCancel();
  afx_msg void OnDestroy();
  afx_msg LRESULT OnEditRecord (LPARAM lParam, LPARAM wParam);
	afx_msg void OnEditInfo();
	afx_msg void OnUpdateEditInfo(CCmdUI* pCmdUI);
	afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
	afx_msg void OnEditSelectrecord();
	afx_msg void OnUpdateEditSelectrecord(CCmdUI* pCmdUI);
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of CEsmUsesDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmusesdlg.H
 *=========================================================================*/
