/*===========================================================================
 *
 * File:	Outputview.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	May 22, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __OUTPUTVIEW_H
#define __OUTPUTVIEW_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmFile.h"
  #include "d:\vcsource\uesp\morrow\mwedit\EsmListCtrl.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Used to resize the list control */
  #define OUTPUTVIEW_LIST_XOFFSET	20
  #define OUTPUTVIEW_LIST_YOFFSET	20
  #define OUTPUTVIEW_LIST_MINWIDTH	200
  #define OUTPUTVIEW_LIST_MINHEIGHT	100

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class COutputView Definition
 *
 *=========================================================================*/
class CMWRandItemDlg;

class COutputView : public CPropertyPage {
  DECLARE_DYNCREATE(COutputView);

  CMWRandItemDlg*	m_pParentDlg;

public:
  COutputView();
  ~COutputView();

  	/* Set class members */
  void SetParentDlg (CMWRandItemDlg* pParent) { m_pParentDlg = pParent; }

	/* Updates the item list from the current ESM file contents */
  void UpdateList (void);

  //{{AFX_DATA(COutputView)
  enum { IDD = IDD_OUTPUT_VIEW };
  CEsmListCtrl	m_ItemList;
  //}}AFX_DATA

	/* ClassWizard generate virtual function overrides */
  //{{AFX_VIRTUAL(COutputView)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:
	/* Generated message map functions */
  //{{AFX_MSG(COutputView)
  afx_msg void OnSize(UINT nType, int cx, int cy);
  virtual BOOL OnInitDialog();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class COutputView Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Outputview.H
 *=========================================================================*/
