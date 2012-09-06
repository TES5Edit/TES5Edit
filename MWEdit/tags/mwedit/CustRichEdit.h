/*===========================================================================
 *
 * File:	Custrichedit.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Friday, February 21, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __CUSTRICHEDIT_H
#define __CUSTRICHEDIT_H


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Custom events */
  #define CRE_UPDATEPOS		0x8001
  #define CRE_UPDATESCROLL	0x8002

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CCustRichEdit Class Definition
 *
 *=========================================================================*/
class CCustRichEdit : public CRichEditCtrl {

public:

	/* Construction */
  CCustRichEdit();
  virtual ~CCustRichEdit();

	/* Get the current line of text */
  const TCHAR* GetCurLineText    (CString& Buffer);
  int	       GetCurLineCharPos (void);

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CCustRichEdit)
public:
  virtual BOOL Create( DWORD dwStyle, const RECT& rect, CWnd* pParentWnd, UINT nID );
  //}}AFX_VIRTUAL

	/* Generated message map functions */
protected:
  //{{AFX_MSG(CCustRichEdit)
  afx_msg UINT OnGetDlgCode();
  afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
  afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
  afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
  afx_msg void OnRButtonDown(UINT nFlags, CPoint point);
  afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
  afx_msg BOOL OnMouseWheel (UINT nFlags, short zDelta, CPoint pt);
  afx_msg void OnVScroll (UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of CCustRichEdit Class Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Custrichedit.H
 *=========================================================================*/
