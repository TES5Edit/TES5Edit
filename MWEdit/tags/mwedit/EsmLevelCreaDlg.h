/*===========================================================================
 *
 * File:	Esmlevelcreadlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 15, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMLEVELCREADLG_H
#define __ESMLEVELCREADLG_H


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
 * Begin Class CEsmLevelCreaDlg Definition
 *
 *=========================================================================*/
class CEsmLevelCreaDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmLevelCreaDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmLevelCrea*	m_pLevelCrea;
  int			m_SortData;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Helper get/set methods */
  void GetCreatureData (void);
  void SetCreatureData (void);

	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);

  	/* Update the rec info user data count values */
  void UpdateUserData (void);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmLevelCreaDlg();

  	/* Get class members */
  virtual bool IsModified   (void);
          int  GetSortData  (void) { return (m_SortData); }
	  int  GetSortCount (esmrecinfo_t* pRecInfo);
	
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmLevelCreaDlg)
  enum { IDD = IDD_LEVELCREA_DLG };
  CButton	m_PCLevelCheck;
  CButton	m_BlockedCheck;
  CEdit		m_ChanceNoneText;
  CEsmListCtrl	m_CreatureList;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmLevelCreaDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmLevelCreaDlg)
  afx_msg LRESULT OnRecordDrop (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnRecordKey  (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnRecordSort (LPARAM lParam, LPARAM wParam);
  afx_msg void OnEndlabeleditlist(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
  //}}AFX_MSG
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmLevelCreaDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmlevelcreadlg.H
 *=========================================================================*/
