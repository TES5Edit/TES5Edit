/*===========================================================================
 *
 * File:	Esmcreaturepage3.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	March 1, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMCREATUREPAGE3_H
#define __ESMCREATUREPAGE3_H


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
 * Begin Class CEsmCreaturePage3 Definition
 *
 *=========================================================================*/
class CEsmCreaturePage3 : public CPropertyPage {
  DECLARE_DYNCREATE(CEsmCreaturePage3);

  /*---------- Begin Protected Class Methods ----------------------*/
protected:
  esmrecinfo_t*		m_pRecInfo;
  CEsmDlgHandler*	m_pDlgHandler;


  /*---------- Begin Public Class Methods -------------------------*/
public:

	/* Construction */
  CEsmCreaturePage3();
  ~CEsmCreaturePage3();

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

	/* Update the recinfo userdata with the item counts */
  void UpdateUserData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmCreaturePage3)
  enum { IDD = IDD_CREATURE_VIEW3 };
  CEsmListCtrl	m_ItemList;
  CStatic	m_WeightLabel;
  //}}AFX_DATA

	/* ClassWizard generate virtual function overrides */
  //{{AFX_VIRTUAL(CEsmCreaturePage3)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmCreaturePage3)
  afx_msg LRESULT OnRecordDrop (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnRecordKey  (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnRecordSort (LPARAM lParam, LPARAM wParam);
  virtual BOOL OnInitDialog();
  afx_msg void OnEndlabeleditItemlist(NMHDR* pNMHDR, LRESULT* pResult);
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmCreaturePage3 Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmcreaturepage3.H
 *=========================================================================*/
