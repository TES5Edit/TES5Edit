/*===========================================================================
 *
 * File:	Scripterrorview.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 3, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SCRIPTERRORVIEW_H
#define __SCRIPTERRORVIEW_H

	
/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
#ifndef __AFXEXT_H__
  #include <afxext.h>
#endif

  #include "EsmScriptError.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CScriptErrorView Definition
 *
 *=========================================================================*/
class CScriptErrorView : public CFormView {

  /*---------- Begin Protected Class Methods -----------------------*/
protected:
  CScriptErrorView();
  DECLARE_DYNCREATE(CScriptErrorView);

	/* Destructor */
  virtual ~CScriptErrorView();


  /*---------- Begin Public Class Methods --------------------------*/
public:
  //{{AFX_DATA(CScriptErrorView)
  enum { IDD = IDD_SCRIPTERRORVIEW };
  CListBox	m_ErrorList;
  //}}AFX_DATA

	/* Clear the current error list */
  void ClearErrors (void);

	/* Update the displayed errors */
  void UpdateErrors (CEsmScriptErrArray* pErrorArray);


	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CScriptErrorView)
public:
  virtual void OnInitialUpdate();
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

#ifdef _DEBUG
  virtual void AssertValid() const;
  virtual void Dump(CDumpContext& dc) const;
#endif

	/* Generated message map functions */
  //{{AFX_MSG(CScriptErrorView)
  afx_msg void OnSize(UINT nType, int cx, int cy);
  afx_msg void OnDblclkErrorlist();
	afx_msg void OnScrerrorGoto();
	afx_msg void OnUpdateScrerrorGoto(CCmdUI* pCmdUI);
	afx_msg void OnScrerrorDetails();
	afx_msg void OnUpdateScrerrorDetails(CCmdUI* pCmdUI);
	afx_msg void OnScrerrorCopy();
	afx_msg void OnUpdateScrerrorCopy(CCmdUI* pCmdUI);
	afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
	afx_msg void OnScrerrorFunchelp();
	afx_msg void OnUpdateScrerrorFunchelp(CCmdUI* pCmdUI);
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CScriptErrorView Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Scripterrorview.H
 *=========================================================================*/
