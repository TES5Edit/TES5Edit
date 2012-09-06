/*===========================================================================
 *
 * File:	Esmcontaindlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 14, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMCONTAINDLG_H
#define __ESMCONTAINDLG_H


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
 * Begin Class CEsmContainDlg Definition
 *
 *=========================================================================*/
class CEsmContainDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmContainDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmContainer*	m_pContainer;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Helper get/set methods */
  void GetItemData (void);
  void SetItemData (void);
  void UpdateTotalWeight (void);

	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);

	/* Update the rec info user data count values */
  void UpdateUserData (void);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmContainDlg();

  	/* Get class members */
  virtual bool IsModified (void);
	
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmContainDlg)
  enum { IDD = IDD_CONTAINER_DLG };
  CButton	m_PersistCheck;
  CButton	m_OrganicCheck;
  CButton	m_RespawnCheck;
  CButton	m_BlockedCheck;
  CEdit		m_NameText;
  CEdit		m_WeightText;
  CEsmListCtrl	m_ItemList;
  CStatic	m_WeightLabel;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmContainDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmContainDlg)
  afx_msg void OnOrganiccheck();
  afx_msg LRESULT OnRecordDrop (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnRecordKey  (LPARAM lParam, LPARAM wParam);
  afx_msg void OnEndlabeleditItemlist(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
  afx_msg LRESULT OnRecordSort (LPARAM lParam, LPARAM wParam);
  //}}AFX_MSG
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmContainDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmcontaindlg.H
 *=========================================================================*/
