/*===========================================================================
 *
 * File:	ChildFrmVar.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Monday, 03 February, 2003
 *
 * Definition of the CChildFrameVar class.
 *
 *=========================================================================*/
#ifndef __ChildFrmVar_H
#define __ChildFrmVar_H


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
 * Class CChildFrameVar Definition
 *
 *=========================================================================*/
class CChildFrameVar : public CMDIChildWnd {
  DECLARE_DYNCREATE(CChildFrameVar)


  /*---------- Begin Private Class Members ----------------------*/
private:
  bool		m_IsFakeMaximized;
  CRect		m_RestoreRect;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class constructor/destructor */
  CChildFrameVar();
  virtual ~CChildFrameVar();

  void FakeMaximize (void);

  void SetSharedMenu (HMENU hMenu) { m_hMenuShared = hMenu; }

	/* Diagnostics routines */
#ifdef _DEBUG
  virtual void AssertValid () const;
  virtual void Dump (CDumpContext& dc) const;
#endif


	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CChildFrameVar)
  virtual BOOL PreCreateWindow (CREATESTRUCT& cs);
  //}}AFX_VIRTUAL


  /*---------- Generated message map functions ------------------*/
protected:
  //{{AFX_MSG(CChildFrameVar)
  afx_msg void OnSize(UINT nType, int cx, int cy);
  afx_msg void OnClose (void);
  afx_msg void OnSysCommand (UINT nID, LPARAM Param);
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CMWEditView Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File ChildFrm.H
 *=========================================================================*/
