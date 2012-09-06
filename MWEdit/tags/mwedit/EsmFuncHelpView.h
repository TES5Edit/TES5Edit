/*===========================================================================
 *
 * File:	Esmfunchelpview.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 2, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMFUNCHELPVIEW_H
#define __ESMFUNCHELPVIEW_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
#ifndef __AFXEXT_H__
  #include <afxext.h>
#endif

  #include "EsmScrFuncArray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmFuncHelpView Definition
 *
 *=========================================================================*/
class CMWEditApp;

class CEsmFuncHelpView : public CFormView {

  /*---------- Begin Protected Class Members -----------------------------*/
protected:
  CFont			m_Font;		
  CFont			m_NameFont;
  CFont			m_LinkFont;

  CEsmScrFuncArray*	m_pFuncArray;	/* Points to the array of functions in the app */
  int			m_CurrentFunc;


  /*---------- Begin Protected Class Methods -----------------------------*/
protected:

	/* Class constructor */
  CEsmFuncHelpView();
  DECLARE_DYNCREATE(CEsmFuncHelpView);

	/* Set the various control strings */
  void SetFuncTitle  (CEsmScrFuncData* pFunction);
  void SetReturnText (CEsmScrFuncData* pFunction);
  void SetDescText   (CEsmScrFuncData* pFunction);
  void SetDetailText (CEsmScrFuncData* pFunction);
  
	/* Fill the function list with the current definitions */
  void FillFunctionList (void);


  /*---------- Begin Public Class Members --------------------------------*/
public:
  //{{AFX_DATA(CEsmFuncHelpView)
	enum { IDD = IDD_FUNCTION_HELP };
	CStatic	m_DetailLabel;
  CStatic	m_Bar;
  CStatic	m_WikiLink;
  CEdit		m_DetailText;
  CStatic	m_FuncName;
  CEdit		m_DescText;
  CEdit		m_ReturnText;
  CEdit		m_FuncTitle;
  CComboBox	m_FunctionList;
	//}}AFX_DATA

	/* Display function information */
  void DisplayFunction (const int Index);

	/* Return the application object */
  CMWEditApp* GetApp (void);


  /*---------- Begin Public Class Methods --------------------------------*/
public:

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmFuncHelpView)
public:
  virtual void OnInitialUpdate();
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Class destructor */
  virtual ~CEsmFuncHelpView();

#ifdef _DEBUG
  virtual void AssertValid() const;
  virtual void Dump(CDumpContext& dc) const;
#endif

	/* Generated message map functions */
  //{{AFX_MSG(CEsmFuncHelpView)
  afx_msg void OnSelchangeFuncList();
  afx_msg LRESULT OnViewError (WPARAM wParam, LPARAM lParam);
  afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
  afx_msg void OnWikilink();
  afx_msg void OnSize( UINT, int, int );
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmFuncHelpView Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmfunchelpview.H
 *=========================================================================*/
