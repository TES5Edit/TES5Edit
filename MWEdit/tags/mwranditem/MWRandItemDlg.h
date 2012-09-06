/*===========================================================================
 *
 * File:	MWRandItemDlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Thursday, 22 May, 2003
 *
 * Definition of the CMWRandItemDlg class.
 *
 *=========================================================================*/
#ifndef __MWRandItemDlg_H
#define __MWRandItemDlg_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "TabCtrlSheet.h"
  #include "d:\vcsource\uesp\morrow\mwedit\EsmListCtrl.h"
  #include "MWRandCom.h"
  #include "WeaponView.h"
  #include "CreateView.h"
  #include "EnchantView.h"
  #include "OutputView.h"
  #include "MwRandItemGen.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Used for tab resizing */
  #define MWRI_TAB_MINWIDTH	200
  #define MWRI_TAB_MINHEIGHT	200
  #define MWRI_TAB_SIZEXOFFSET	20
  #define MWRI_TAB_SIZEYOFFSET	20

	/* Random number flags */
  #define MWRI_RANDFLAG_BELL 1

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemDlg Definition
 *
 *=========================================================================*/
class CMWRandItemDlg : public CDialog {


  /*---------- Begin Protected Class Members ---------------------------*/
protected:
  HICON			m_hIcon;		/* UI members */
  CTabCtrlSheet		m_MainTab;
  CWeaponView		m_OldWeaponView;
  CEnchantView		m_OldEnchantView;
  COutputView		m_OutputView;
  CCreateView		m_CreateView;
	
  CEsmRecInfoArray	m_RecInfoArray;

  CMwRandItemGen	m_RandItemGen;		/* Main generator class */


  /*---------- Begin Protected Class Methods ---------------------------*/
protected:

	/* Clear all rec info pointers */
  void DeleteRecInfo (void);


  /*---------- Begin Public Class Methods ------------------------------*/
public:

	/* Constructor/destructor */
  CMWRandItemDlg(CWnd* pParent = NULL);
  virtual ~CMWRandItemDlg();

	/* Creates a new record of the given type */
  CEsmRecord* CreateRecord (const TCHAR* pType);

  	/* Clear the file contents */
  void DestroyContents (void);

  	/* Get class members */
  CEsmFile*         GetEsmFile (void) { return (m_RandItemGen.GetEsmFile()); }
  CEsmRecInfoArray* GetRecInfo (void) { return (&m_RecInfoArray); }

	/* Updates the item list from the file records */
  void UpdateList (void);

	/* Dialog Data */
  //{{AFX_DATA(CMWRandItemDlg)
  enum { IDD = IDD_MWRANDITEM_DIALOG };
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CMWRandItemDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

	/* Generated message map functions */
  //{{AFX_MSG(CMWRandItemDlg)
  virtual BOOL OnInitDialog();
  afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
  afx_msg void OnDestroy();
  afx_msg void OnPaint();
  afx_msg HCURSOR OnQueryDragIcon();
  afx_msg void OnSize(UINT nType, int cx, int cy);
  afx_msg void OnFileNew();
  afx_msg void OnFileSave();
  afx_msg void OnFileExit();
  afx_msg LRESULT OnNewItems(WPARAM wParam, LPARAM lParam);
  afx_msg void OnTestExportesp();
	afx_msg void OnFileLoadbase();
	afx_msg void OnFileLoadgroup();
	afx_msg void OnFileSavegroup();
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CMWRandItemDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION Microsoft Visual C++ will insert additional declarations immediately before the previous line.


#endif
/*===========================================================================
 *		End of File MWRandItemDlg.H
 *=========================================================================*/
