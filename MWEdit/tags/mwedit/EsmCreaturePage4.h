/*===========================================================================
 *
 * File:	Esmcreaturepage4.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	March 1, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMCREATUREPAGE4_H
#define __ESMCREATUREPAGE4_H


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
 * Begin Class CEsmCreaturePage4 Definition
 *
 *=========================================================================*/
class CEsmCreaturePage4 : public CPropertyPage {
  DECLARE_DYNCREATE(CEsmCreaturePage4);

  /*---------- Begin Protected Class Members  --------------------*/
protected:
  esmrecinfo_t*		m_pRecInfo;
  CEsmDlgHandler*	m_pDlgHandler;
  CEsmSubRecArray	m_PackageArray;		/* Holds all the packages being editted */

  /*---------- Begin Protected Class Methods ---------------------*/
protected:

	/* Creates a copy of all the given AI subrecords */
  void AddAIRecords (const TCHAR* pType);

	/* Delete all sub-records in the package array */
  void ClearPackageArray (void);

	/* Delete all selected items in the list */
  void DeleteSelectedItems (void);

	/* Find a subrecord array index */
  CEsmSubNameFix* FindCNDTSubRec (CEsmSubRecord* pSubRecord);

	/* Output the given AI package sub-record to the text control */
  void OutputAIData (CEsmSubRecord* pSubRec);

	/* Updates the package list */
  void UpdatePackageList (void);
  

  /*---------- Begin Public Class Methods ------------------------*/
public:

	/* Construction */
  CEsmCreaturePage4();
  ~CEsmCreaturePage4();

  	/* Get class members */
  CMWEditDoc* GetDocument (void);

    	/* Set class members */
  void SetRecInfo    (esmrecinfo_t* pRecInfo)   { m_pRecInfo = pRecInfo; }
  void SetDlgHandler (CEsmDlgHandler*  pParent) { m_pDlgHandler = pParent; }

	/* Get/set control data */
  void GetControlData (void);
  void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmCreaturePage4)
  enum { IDD = IDD_NPC_VIEW4 };
  CEdit		m_PackageText;
  CEdit		m_HelloText;
  CEdit		m_FleeText;
  CEdit		m_AlarmText;
  CEdit		m_FightText;
  CEsmListCtrl	m_PackageList;
  //}}AFX_DATA

	/* ClassWizard generate virtual function overrides */
  //{{AFX_VIRTUAL(CEsmCreaturePage4)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:
	/* Generated message map functions */
  //{{AFX_MSG(CEsmCreaturePage4)
  afx_msg void OnActivatebutton();
  afx_msg void OnEscortbutton();
  afx_msg void OnFollowbutton();
  afx_msg void OnTravelbutton();
  afx_msg void OnWanderbutton();
  afx_msg void OnEditbutton();
  afx_msg void OnDeletebutton();
  afx_msg LRESULT OnRecordKey (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnEditRecord(LPARAM lParam, WPARAM wParam);
  virtual BOOL OnInitDialog();
  afx_msg void OnItemchangingPackagelist(NMHDR* pNMHDR, LRESULT* pResult);
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

};
/*===========================================================================
 *		End of Class CEsmCreaturePage4 Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmcreaturepage4.H
 *=========================================================================*/
