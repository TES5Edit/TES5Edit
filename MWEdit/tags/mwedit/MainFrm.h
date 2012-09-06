/*===========================================================================
 *
 * File:	MainFrm.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Monday, 03 February, 2003
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

  HINSTANCE		m_hItemHelp;


  /*---------- Begin Public Class Methods ------------------------*/
public:

	/* Destructor */
  virtual ~CMainFrame();

	/* Attempt to find the main application view */
  CView* GetActiveMainView (void);


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
  afx_msg void OnHelpFunctions();
  afx_msg void OnViewOptions();
  afx_msg void OnEditFindtext();
  afx_msg void OnEditPluginInfo();
  afx_msg void OnHelpSubmitbug();
  afx_msg void OnHelpSubmitfeature();
  afx_msg void OnHelpLinksSourceforge();
  afx_msg void OnHelpEmail();
  afx_msg void OnHelpItemindex();
  afx_msg void OnHelpAbout();
  afx_msg void OnHelpLinksUesptes3mod();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

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
