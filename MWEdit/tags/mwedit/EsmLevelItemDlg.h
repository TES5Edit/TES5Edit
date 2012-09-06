/*===========================================================================
 *
 * File:	Esmlevelitemdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 15, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMLEVELITEMDLG_H
#define __ESMLEVELITEMDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmRecDialog.h"
  #include "Resource.h"
  #include "EsmListCtrl.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmLevelItemDlg Definition
 *
 *=========================================================================*/
class CEsmLevelItemDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmLevelItemDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmLevelItem*	m_pLevelItem;
  int			m_SortData;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Helper get/set methods */
  void GetItemData (void);
  void SetItemData (void);

	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmLevelItemDlg();

  	/* Get class members */
  virtual bool IsModified   (void);
          int  GetSortData  (void) { return (m_SortData); }
	  int  GetSortCount (esmrecinfo_t* pRecInfo);
	
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmLevelItemDlg)
  enum { IDD = IDD_LEVELITEM_DLG };
  CButton	m_PCLevelCheck;
  CButton	m_EachItemCheck;
  CButton	m_BlockedCheck;
  CEdit		m_ChanceNoneText;
  CEsmListCtrl	m_ItemList;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmLevelItemDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmLevelItemDlg)
  afx_msg LRESULT OnRecordDrop (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnRecordKey  (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnRecordSort (LPARAM lParam, LPARAM wParam);
  afx_msg void OnEndlabeleditlist(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
  //}}AFX_MSG
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmLevelItemDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmlevelitemdlg.H
 *=========================================================================*/
