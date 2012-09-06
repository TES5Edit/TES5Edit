/*===========================================================================
 *
 * File:	Esmnpcpage3.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 25, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMNPCPAGE3_H
#define __ESMNPCPAGE3_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmListCtrl.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
  class CEsmDlgHandler;
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmNpcPage3 Definition
 *
 *=========================================================================*/
class CEsmNpcPage3 : public CPropertyPage {
  DECLARE_DYNCREATE(CEsmNpcPage3);

  /*---------- Begin Protected Class Methods ----------------------*/
protected:
  esmrecinfo_t*		m_pRecInfo;
  CEsmDlgHandler*	m_pDlgHandler;


  /*---------- Begin Public Class Methods -------------------------*/
public:

	/* Construction */
  CEsmNpcPage3();
  ~CEsmNpcPage3();

	/* Get class members */
  CMWEditDoc* GetDocument (void);

  	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);

  	/* Set class members */
  void SetRecInfo    (esmrecinfo_t* pRecInfo)   { m_pRecInfo = pRecInfo; }
  void SetDlgHandler (CEsmDlgHandler*  pParent) { m_pDlgHandler = pParent; }

	/* Get/set control data */
  void GetControlData (void);
  void SetControlData (void);

	/* Update the current weight the NPC is carrying */
  void UpdateTotalWeight (void);

	/* Updates the recinfo userdata before a sort */
  void UpdateUserData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmNpcPage3)
  enum { IDD = IDD_CREATURE_VIEW3 };
  CEsmListCtrl	m_ItemList;
  CStatic	m_WeightLabel;
  //}}AFX_DATA

	/* ClassWizard generate virtual function overrides */
  //{{AFX_VIRTUAL(CEsmNpcPage3)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmNpcPage3)
  afx_msg LRESULT OnRecordDrop (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnRecordKey  (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnRecordSort (LPARAM lParam, LPARAM wParam);
  virtual BOOL OnInitDialog();
  afx_msg void OnEndlabeleditItemlist(NMHDR* pNMHDR, LRESULT* pResult);
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmNpcPage3 Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmnpcpage3.H
 *=========================================================================*/
