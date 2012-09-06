/*===========================================================================
 *
 * File:	MainFrm.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Saturday, 28 December, 2002
 *
 * Defines the interface of the CMainFrame class.
 *
 *=========================================================================*/
#ifndef __MainFrm_H
#define __MainFrm_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/
  	

/*===========================================================================
 *
 * Class CMainFrame Definition
 *
 *=========================================================================*/
class CMainFrame : public CMDIFrameWnd {
  DECLARE_DYNAMIC(CMainFrame)
public:
  CMainFrame();

  /*---------- Begin Protected Class Members ----------------------*/
protected:
  CStatusBar		m_wndStatusBar;
  CToolBar		m_wndToolBar;


  /*---------- Begin Public Class Methods ------------------------*/
public:

	/* Destructor */
  virtual ~CMainFrame();


	/* Diagnostics */
#ifdef _DEBUG
  virtual void AssertValid() const;
  virtual void Dump(CDumpContext& dc) const;
#endif


	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CMainFrame)
  virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
  //}}AFX_VIRTUAL

	/* Generated message map functions */
protected:
  //{{AFX_MSG(CMainFrame)
  afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnFileCreatecopies();
	//}}AFX_MSG


  DECLARE_MESSAGE_MAP()

 };
/*===========================================================================
 *		End of Class CMainFrame Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File MainFrm.H
 *=========================================================================*/
